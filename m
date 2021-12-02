Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F92246615E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 11:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356930AbhLBKZN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 05:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242697AbhLBKZM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Dec 2021 05:25:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7055AC06174A
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 02:21:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36A46B82250
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 10:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A65C00446
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 10:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638440507;
        bh=KuH7HqOP/no48hRxcIKBDvkGTHietKGoVJ7aG4vuo7o=;
        h=From:To:Subject:Date:From;
        b=rQI084gr8RaKpVPQtNPQ0AxVg+T/fGD6KuwACaqGe3/fIvTdHFDkWAOVPl0qFhkdT
         7IgJK4vc3AwLH0hp37qs9lLJwzwU/ZOP/JvioDl5pKnVAeX8DnlW3im8zat0XiAXgm
         KVJgEe8lRmcKkBlSQymsxNQQuV04eFHD8soOEmUrn/ncLPuQE6CH2Onkx8xfuyyJ3w
         +L9CXuD2jAih/78RoJaaEW9hOP9f5G2TTSWbQkrqUtWRvlGyYO51gd26GM2B4RoeGt
         kMXdSdLM9aLdydI6yTxnQnG0K9Kvt6rHqfnHc6WsrY1apyH6uYASYS5wekei+QtDky
         RgA0TSfholq6Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: send: fix a failure when looking for data backrefs after relocation
Date:   Thu,  2 Dec 2021 10:21:43 +0000
Message-Id: <829076d580be74f270e740f8dded6fda45390311.1638440202.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During a send, when trying to find roots from which to clone data extents,
if the leaf of our file extent item was obtained before relocation for a
data block group finished, we can end up trying to lookup for backrefs
for an extent location (file extent item's disk_bytenr) that is not in
use anymore. That is, the extent was reallocated and the transaction used
for the relocation was committed. This makes the backref lookup not find
anything and we fail at find_extent_clone() with -EIO and log an error
message like the following:

  [ 7642.897365] BTRFS error (device sdc): did not find backref in send_root. inode=881, offset=2592768, disk_byte=1292025856 found extent=1292025856

This is because we are checking if relocation happened after we check if
we found the backref for the file extent item we are processing. We should
do it before, and in case relocation happened, do not attempt to clone and
instead fallback to issuing write commands, which will read the correct
data from the new extent location. The current check is being done too
late, so fix this by moving it to right after we do the backref lookup and
before checking if we found our own backref.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

David, this can be squashed into the patch:

   "btrfs: make send work with concurrent block group relocation"

 fs/btrfs/send.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index f0015b5cf4b1..3fc144b8c0d8 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1431,6 +1431,26 @@ static int find_extent_clone(struct send_ctx *sctx,
 	if (ret < 0)
 		goto out;
 
+	down_read(&fs_info->commit_root_sem);
+	if (fs_info->last_reloc_trans > sctx->last_reloc_trans) {
+		/*
+		 * A transaction commit for a transaction in which block group
+		 * relocation was done just happened.
+		 * The disk_bytenr of the file extent item we processed is
+		 * possibly stale, referring to the extent's location before
+		 * relocation. So act as if we haven't found any clone sources
+		 * and fallback to write commands, which will read the correct
+		 * data from the new extent location. Otherwise we will fail
+		 * below because we haven't found our own back reference or we
+		 * could be getting incorrect sources in case the old extent
+		 * was already reallocated after the relocation.
+		 */
+		up_read(&fs_info->commit_root_sem);
+		ret = -ENOENT;
+		goto out;
+	}
+	up_read(&fs_info->commit_root_sem);
+
 	if (!backref_ctx.found_itself) {
 		/* found a bug in backref code? */
 		ret = -EIO;
@@ -1444,28 +1464,8 @@ static int find_extent_clone(struct send_ctx *sctx,
 		    "find_extent_clone: data_offset=%llu, ino=%llu, num_bytes=%llu, logical=%llu",
 		    data_offset, ino, num_bytes, logical);
 
-	if (backref_ctx.found > 0) {
-		down_read(&fs_info->commit_root_sem);
-		if (fs_info->last_reloc_trans > sctx->last_reloc_trans) {
-			/*
-			 * A transaction commit for a transaction in which block
-			 * group relocation was done just happened.
-			 * The disk_bytenr of the file extent item we processed
-			 * is possibly stale, referring to the extent's location
-			 * before relocation, so act as if we haven't found any
-			 * clone sources - otherwise we could end up later issuing
-			 * clone operations that could leave the receiver with
-			 * incorrect data, in case the old disk_bytenr got
-			 * reallocated for another extent.
-			 */
-			up_read(&fs_info->commit_root_sem);
-			ret = -ENOENT;
-			goto out;
-		}
-		up_read(&fs_info->commit_root_sem);
-	} else {
+	if (!backref_ctx.found)
 		btrfs_debug(fs_info, "no clones found");
-	}
 
 	cur_clone_root = NULL;
 	for (i = 0; i < sctx->clone_roots_cnt; i++) {
-- 
2.33.0

