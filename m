Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA8D7986C2
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 14:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242880AbjIHMJd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 08:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237407AbjIHMJc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 08:09:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB611BE7
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 05:09:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE84CC433CA
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 12:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694174968;
        bh=3r+8KXdnEbNUFoJkeo/6HM/e/oJDp2xbWJBvwB9oz0Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BvRWpYBJRWiom/+nDLRVm19RfCtuCeVYy80UNFSuZqss1DUvUg4ZhAJsYPcxR9X5H
         mzwJ14WJtcmCndNmzPk98ONQihM2ChNI7IIOnKJ0//ABgZlRMs/JLhfL66hFG1lvAZ
         ocMxkm22/qZKEXiBSVPp7Oku3XAbv7QZDmyDSAN+QrWllYDyyBxYkKYoi4Hcfon+rM
         tgokc8RS3jo4VUx59BRGA2A9LzcQxcR9s0aTmgYIV2lrEsjYCzjf8oizS1xGCfPbFj
         Gdci1yaLSG8ZFePHDDtX47VTMUJajc/Jga4W6KN69/Hc+3YAI8QZMHhXI8logQR7lF
         4X379llsORlZg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/21] btrfs: fix race when refilling delayed refs block reserve
Date:   Fri,  8 Sep 2023 13:09:03 +0100
Message-Id: <ad77c4035370a5db4e0b813da9eff73e52fd30c0.1694174371.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694174371.git.fdmanana@suse.com>
References: <cover.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

If we have two (or more) tasks attempting to refill the delayed refs block
reserve we can end up with the delayed block reserve being over reserved,
that is, with a reserved space greater than its size. If this happens, we
are holding to more reserved space than necessary, however it may or may
not be harmless. In case the delayed refs block reserve size later
increases to match or go beyond the reserved space, then nothing bad
happens, we end up simply avoiding doing a space reservation later at the
expense of doing it now. However if the delayed refs block reserve size
never increases to match its reserved size, then at unmount time we will
trigger the following warning from btrfs_release_global_block_rsv():

   WARN_ON(fs_info->delayed_block_rsv.reserved > 0);

The race happens like this:

1) The delayed refs block reserve has a size of 8M and a reserved space of
   6M for example;

2) Task A calls btrfs_delayed_refs_rsv_refill();

3) Task B also calls btrfs_delayed_refs_rsv_refill();

4) Task A sees there's a 2M difference between the size and the reserved
   space of the delayed refs rsv, so it will reserve 2M of space by
   calling btrfs_reserve_metadata_bytes();

5) Task B also sees that 2M difference, and like task A, it reserves
   another 2M of metadata space;

6) Both task A and task B increase the reserved space of block reserve
   by 2M, by calling btrfs_block_rsv_add_bytes(), so the block reserve
   ends up with a size of 8M and a reserved space of 10M;

7) As delayed refs are run and their space released, the delayed refs
   block reserve ends up with a size of 0 and a reserved space of 2M;

8) The fs is unmounted and the warning at btrfs_release_global_block_rsv()
   is triggered because the size the reserved space is not zero.

So fix this by checking if we still need to add space to the delayed refs
block reserve after reserving the metadata space, and if we don't, just
release that space.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 6a13cf00218b..1043f66cc130 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -163,6 +163,8 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 	struct btrfs_block_rsv *block_rsv = &fs_info->delayed_refs_rsv;
 	u64 limit = btrfs_calc_delayed_ref_bytes(fs_info, 1);
 	u64 num_bytes = 0;
+	u64 refilled_bytes;
+	u64 to_free;
 	int ret = -ENOSPC;
 
 	spin_lock(&block_rsv->lock);
@@ -178,9 +180,38 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, num_bytes, flush);
 	if (ret)
 		return ret;
-	btrfs_block_rsv_add_bytes(block_rsv, num_bytes, false);
-	trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
-				      0, num_bytes, 1);
+
+	/*
+	 * We may have raced with someone else, so check again if we the block
+	 * reserve is still not full and release any excess space.
+	 */
+	spin_lock(&block_rsv->lock);
+	if (block_rsv->reserved < block_rsv->size) {
+		u64 needed = block_rsv->size - block_rsv->reserved;
+
+		if (num_bytes >= needed) {
+			block_rsv->reserved += needed;
+			block_rsv->full = true;
+			to_free = num_bytes - needed;
+			refilled_bytes = needed;
+		} else {
+			block_rsv->reserved += num_bytes;
+			to_free = 0;
+			refilled_bytes = num_bytes;
+		}
+	} else {
+		to_free = num_bytes;
+		refilled_bytes = 0;
+	}
+	spin_unlock(&block_rsv->lock);
+
+	if (to_free > 0)
+		btrfs_space_info_free_bytes_may_use(fs_info, block_rsv->space_info,
+						    to_free);
+
+	if (refilled_bytes > 0)
+		trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv", 0,
+					      refilled_bytes, 1);
 	return 0;
 }
 
-- 
2.40.1

