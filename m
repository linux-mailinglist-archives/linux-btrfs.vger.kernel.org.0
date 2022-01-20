Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2007D494C61
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jan 2022 12:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiATLAZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jan 2022 06:00:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38808 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiATLAV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jan 2022 06:00:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F5AF61515
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 11:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2F9C340E8
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 11:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642676420;
        bh=h3OVljvVuJRIO6QVUIJ8P71TlccbuXWEZgZVW2BJkBY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ASbyhvQXHBc2p5Oi/6P0OpJwSR0amv9xz6VdDBjTKahjmmK6N3+pm82EOi5txp7r/
         JgVThhP19dVj8oipkiF+LOfL13Fnn595tvpGB1LQQkLHZzPk7flbVSiBexXKlz0UU6
         zNFKKbDC1RHncNudC1ZZvdZpyHqROZU5TZot5D+1UmXN1VJFZZ8jQ8smFFcBLnFFA9
         obbCBkNuJniMvlmgukY27+L1zBliTgfxcXNPGTlK8oTQo55pkTXP9q8Pbq5CEEx58q
         LWeq6mgcqqBkGjvUFz+hFLNG0yqO6hmiUM2DXd2e2+RJHWXxZOZIhfOoKTIPQoD4Qc
         KhQ4pWvAWsV9A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] btrfs: use single variable to track return value at btrfs_log_inode()
Date:   Thu, 20 Jan 2022 11:00:11 +0000
Message-Id: <35bfc17e94d10d179574a47550a4fdcfa4e4fe9a.1642676248.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1642676248.git.fdmanana@suse.com>
References: <cover.1642676248.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At btrfs_log_inode(), we have two variables to track errors and the
return value of the function, named 'ret' and 'err'. In some places we
use 'ret' and if gets a non-zero value we assign its value to 'err'
and then jump to the 'out' label, while in other places we use 'err'
directly without 'ret' as an intermediary. This is inconsistent, error
prone and not necessary. So change that to use only the 'ret' variable,
making this consistent with most functions in btrfs.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 52 +++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6f9829188948..8f7163fe3ebe 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5663,8 +5663,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	struct btrfs_key min_key;
 	struct btrfs_key max_key;
 	struct btrfs_root *log = inode->root->log_root;
-	int err = 0;
-	int ret = 0;
+	int ret;
 	bool fast_search = false;
 	u64 ino = btrfs_ino(inode);
 	struct extent_map_tree *em_tree = &inode->extent_tree;
@@ -5707,8 +5706,8 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	 * and figure out which index ranges have to be logged.
 	 */
 	if (S_ISDIR(inode->vfs_inode.i_mode)) {
-		err = btrfs_commit_inode_delayed_items(trans, inode);
-		if (err)
+		ret = btrfs_commit_inode_delayed_items(trans, inode);
+		if (ret)
 			goto out;
 	}
 
@@ -5729,11 +5728,10 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	 * the inode was previously logged in this transaction.
 	 */
 	ret = inode_logged(trans, inode, path);
-	if (ret < 0) {
-		err = ret;
+	if (ret < 0)
 		goto out;
-	}
 	ctx->logged_before = (ret == 1);
+	ret = 0;
 
 	/*
 	 * This is for cases where logging a directory could result in losing a
@@ -5746,7 +5744,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	    inode_only == LOG_INODE_ALL &&
 	    inode->last_unlink_trans >= trans->transid) {
 		btrfs_set_log_full_commit(trans);
-		err = 1;
+		ret = 1;
 		goto out_unlock;
 	}
 
@@ -5778,8 +5776,8 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 			 * (zeroes), as if an expanding truncate happened,
 			 * instead of getting a file of 4Kb only.
 			 */
-			err = logged_inode_size(log, inode, path, &logged_isize);
-			if (err)
+			ret = logged_inode_size(log, inode, path, &logged_isize);
+			if (ret)
 				goto out_unlock;
 		}
 		if (test_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
@@ -5815,37 +5813,35 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 		}
 
 	}
-	if (ret) {
-		err = ret;
+	if (ret)
 		goto out_unlock;
-	}
 
-	err = copy_inode_items_to_log(trans, inode, &min_key, &max_key,
+	ret = copy_inode_items_to_log(trans, inode, &min_key, &max_key,
 				      path, dst_path, logged_isize,
 				      recursive_logging, inode_only, ctx,
 				      &need_log_inode_item);
-	if (err)
+	if (ret)
 		goto out_unlock;
 
 	btrfs_release_path(path);
 	btrfs_release_path(dst_path);
-	err = btrfs_log_all_xattrs(trans, inode, path, dst_path);
-	if (err)
+	ret = btrfs_log_all_xattrs(trans, inode, path, dst_path);
+	if (ret)
 		goto out_unlock;
 	xattrs_logged = true;
 	if (max_key.type >= BTRFS_EXTENT_DATA_KEY && !fast_search) {
 		btrfs_release_path(path);
 		btrfs_release_path(dst_path);
-		err = btrfs_log_holes(trans, inode, path);
-		if (err)
+		ret = btrfs_log_holes(trans, inode, path);
+		if (ret)
 			goto out_unlock;
 	}
 log_extents:
 	btrfs_release_path(path);
 	btrfs_release_path(dst_path);
 	if (need_log_inode_item) {
-		err = log_inode_item(trans, log, dst_path, inode, inode_item_dropped);
-		if (err)
+		ret = log_inode_item(trans, log, dst_path, inode, inode_item_dropped);
+		if (ret)
 			goto out_unlock;
 		/*
 		 * If we are doing a fast fsync and the inode was logged before
@@ -5856,18 +5852,16 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 		 * BTRFS_INODE_COPY_EVERYTHING set.
 		 */
 		if (!xattrs_logged && inode->logged_trans < trans->transid) {
-			err = btrfs_log_all_xattrs(trans, inode, path, dst_path);
-			if (err)
+			ret = btrfs_log_all_xattrs(trans, inode, path, dst_path);
+			if (ret)
 				goto out_unlock;
 			btrfs_release_path(path);
 		}
 	}
 	if (fast_search) {
 		ret = btrfs_log_changed_extents(trans, inode, dst_path, ctx);
-		if (ret) {
-			err = ret;
+		if (ret)
 			goto out_unlock;
-		}
 	} else if (inode_only == LOG_INODE_ALL) {
 		struct extent_map *em, *n;
 
@@ -5879,10 +5873,8 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 
 	if (inode_only == LOG_INODE_ALL && S_ISDIR(inode->vfs_inode.i_mode)) {
 		ret = log_directory_changes(trans, inode, path, dst_path, ctx);
-		if (ret) {
-			err = ret;
+		if (ret)
 			goto out_unlock;
-		}
 	}
 
 	spin_lock(&inode->lock);
@@ -5930,7 +5922,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	if (recursive_logging)
 		ctx->logged_before = orig_logged_before;
 
-	return err;
+	return ret;
 }
 
 /*
-- 
2.33.0

