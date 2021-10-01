Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E345D41EDC8
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Oct 2021 14:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353291AbhJAMuF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Oct 2021 08:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhJAMuE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Oct 2021 08:50:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A0DD61AA9
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Oct 2021 12:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633092500;
        bh=brGuNXGWsBaCwsOKaQPOJeCm5qfVOUu2+/ory44S3AE=;
        h=From:To:Subject:Date:From;
        b=ehCyyAbcWOlQcxWRrtsx1NO227OlRsQwnYw1aV/9G0Qbyi2pXzTF2gMKhN1AVevlJ
         LTx4J0Lh4yOdHEFCeleLem0/y11zNoEnXE7WQXv+CQsB0Zt2oKp6BnMRG5qlvl3zd2
         uiwxAz9/66LdvSDdgoN98MlVO82dym8IuF7HwUL9V+9qySCVjHHC83PZELYYYYT8kr
         kuOoq1zHOVBRa9qXHcAWxYcFqpgbmqFmfzboXmKzpC0g5mrAfRr3Fm6HHnObMT1bMj
         cp53IuB+P3GaMuRZWFwLuCMm+pU7oaUTZY3gz5NV9xkT5Y3XvDKzC6MUMO3pSDyp6Y
         d0ek5i9btUrww==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: check for error when looking up inode during dir entry replay
Date:   Fri,  1 Oct 2021 13:48:18 +0100
Message-Id: <ddfdc77c1d84fecfbbf72811f7eb3a14915610a0.1633091618.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At replay_one_name(), we are treating any error from btrfs_lookup_inode()
as if the inode does not exists. Fix this by checking for an error and
returning it to the caller.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 68d92835dd0f..87a994d245ec 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1978,8 +1978,8 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	struct btrfs_key log_key;
 	struct inode *dir;
 	u8 log_type;
-	int exists;
-	int ret = 0;
+	bool exists;
+	int ret;
 	bool update_size = (key->type == BTRFS_DIR_INDEX_KEY);
 	bool name_added = false;
 
@@ -1999,12 +1999,12 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 		   name_len);
 
 	btrfs_dir_item_key_to_cpu(eb, di, &log_key);
-	exists = btrfs_lookup_inode(trans, root, path, &log_key, 0);
-	if (exists == 0)
-		exists = 1;
-	else
-		exists = 0;
+	ret = btrfs_lookup_inode(trans, root, path, &log_key, 0);
 	btrfs_release_path(path);
+	if (ret < 0)
+		goto out;
+	exists = (ret == 0);
+	ret = 0;
 
 	if (key->type == BTRFS_DIR_ITEM_KEY) {
 		dst_di = btrfs_lookup_dir_item(trans, root, path, key->objectid,
-- 
2.33.0

