Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54223642625
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Dec 2022 10:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiLEJwS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Dec 2022 04:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiLEJvn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Dec 2022 04:51:43 -0500
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC84CF587
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Dec 2022 01:51:42 -0800 (PST)
From:   robbieko <robbieko@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1670233900; bh=C7iRRPBot6NgeuG2S9Jnf7VohKbPL1nf7r28i4hyOeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=txkDNqvUGm1rpA/snTR27r539xdIceM00Ppw0M6FqzeRXs3QFS1f9C7+drtRacf8U
         aQUZ0DacdMigo15e3jok0AF8/CDsVn+4WvK5fjyr12R2jpAuVSIhPW37awjN8UqvGG
         xM7wkJFusPUn2t7wq/UIYNb5KTL2JbCbQXgB90Ns=
To:     linux-btrfs@vger.kernel.org
Cc:     Robbie Ko <robbieko@synology.com>
Subject: [PATCH 2/3] btrfs: change snapshot_lock to dynamic pointer
Date:   Mon,  5 Dec 2022 17:51:21 +0800
Message-Id: <20221205095122.17011-3-robbieko@synology.com>
In-Reply-To: <20221205095122.17011-1-robbieko@synology.com>
References: <20221205095122.17011-1-robbieko@synology.com>
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Robbie Ko <robbieko@synology.com>

Change snapshot_lock to dynamic pointer to allocate memory
at the beginning of creating a subvolume/snapshot.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 fs/btrfs/ctree.h   |  2 +-
 fs/btrfs/disk-io.c | 10 ++++++++--
 fs/btrfs/file.c    |  8 ++++----
 fs/btrfs/inode.c   | 12 ++++++------
 fs/btrfs/ioctl.c   |  4 ++--
 5 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9e6d48ff4597..99003b0dd407 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1429,7 +1429,7 @@ struct btrfs_root {
 	 */
 	int dedupe_in_progress;
 	/* For exclusion of snapshot creation and nocow writes */
-	struct btrfs_drew_lock snapshot_lock;
+	struct btrfs_drew_lock *snapshot_lock;
 
 	atomic_t snapshot_force_cow;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index afe16e1f0b18..5760c2b1a100 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1464,12 +1464,17 @@ static int btrfs_init_fs_root(struct btrfs_root *root,
 	int ret;
 	unsigned int nofs_flag;
 
+	root->snapshot_lock = kzalloc(sizeof(*root->snapshot_lock), GFP_NOFS);
+	if (!root->snapshot_lock) {
+		ret = -ENOMEM;
+		goto fail;
+	}
 	/*
 	 * We might be called under a transaction (e.g. indirect backref
 	 * resolution) which could deadlock if it triggers memory reclaim
 	 */
 	nofs_flag = memalloc_nofs_save();
-	ret = btrfs_drew_lock_init(&root->snapshot_lock);
+	ret = btrfs_drew_lock_init(root->snapshot_lock);
 	memalloc_nofs_restore(nofs_flag);
 	if (ret)
 		goto fail;
@@ -2180,7 +2185,8 @@ void btrfs_put_root(struct btrfs_root *root)
 		WARN_ON(test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state));
 		if (root->anon_dev)
 			free_anon_bdev(root->anon_dev);
-		btrfs_drew_lock_destroy(&root->snapshot_lock);
+		if (root->snapshot_lock)
+			btrfs_drew_lock_destroy(root->snapshot_lock);
 		free_root_extent_buffers(root);
 #ifdef CONFIG_BTRFS_DEBUG
 		spin_lock(&root->fs_info->fs_roots_radix_lock);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index d01631d47806..a338fbd34472 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1379,7 +1379,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 	if (!(inode->flags & (BTRFS_INODE_NODATACOW | BTRFS_INODE_PREALLOC)))
 		return 0;
 
-	if (!btrfs_drew_try_write_lock(&root->snapshot_lock))
+	if (!btrfs_drew_try_write_lock(root->snapshot_lock))
 		return -EAGAIN;
 
 	lockstart = round_down(pos, fs_info->sectorsize);
@@ -1389,7 +1389,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 
 	if (nowait) {
 		if (!btrfs_try_lock_ordered_range(inode, lockstart, lockend)) {
-			btrfs_drew_write_unlock(&root->snapshot_lock);
+			btrfs_drew_write_unlock(root->snapshot_lock);
 			return -EAGAIN;
 		}
 	} else {
@@ -1398,7 +1398,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 	ret = can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes,
 			NULL, NULL, NULL, nowait, false);
 	if (ret <= 0)
-		btrfs_drew_write_unlock(&root->snapshot_lock);
+		btrfs_drew_write_unlock(root->snapshot_lock);
 	else
 		*write_bytes = min_t(size_t, *write_bytes ,
 				     num_bytes - pos + lockstart);
@@ -1409,7 +1409,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 
 void btrfs_check_nocow_unlock(struct btrfs_inode *inode)
 {
-	btrfs_drew_write_unlock(&inode->root->snapshot_lock);
+	btrfs_drew_write_unlock(inode->root->snapshot_lock);
 }
 
 static void update_time_for_write(struct inode *inode)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0e516aefbf51..8fe4b00d31f4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5167,16 +5167,16 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		 * truncation, it must capture all writes that happened before
 		 * this truncation.
 		 */
-		btrfs_drew_write_lock(&root->snapshot_lock);
+		btrfs_drew_write_lock(root->snapshot_lock);
 		ret = btrfs_cont_expand(BTRFS_I(inode), oldsize, newsize);
 		if (ret) {
-			btrfs_drew_write_unlock(&root->snapshot_lock);
+			btrfs_drew_write_unlock(root->snapshot_lock);
 			return ret;
 		}
 
 		trans = btrfs_start_transaction(root, 1);
 		if (IS_ERR(trans)) {
-			btrfs_drew_write_unlock(&root->snapshot_lock);
+			btrfs_drew_write_unlock(root->snapshot_lock);
 			return PTR_ERR(trans);
 		}
 
@@ -5184,7 +5184,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
 		pagecache_isize_extended(inode, oldsize, newsize);
 		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
-		btrfs_drew_write_unlock(&root->snapshot_lock);
+		btrfs_drew_write_unlock(root->snapshot_lock);
 		btrfs_end_transaction(trans);
 	} else {
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -11026,7 +11026,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	 * completes before the first write into the swap file after it is
 	 * activated, than that write would fallback to COW.
 	 */
-	if (!btrfs_drew_try_write_lock(&root->snapshot_lock)) {
+	if (!btrfs_drew_try_write_lock(root->snapshot_lock)) {
 		btrfs_exclop_finish(fs_info);
 		btrfs_warn(fs_info,
 	   "cannot activate swapfile because snapshot creation is in progress");
@@ -11199,7 +11199,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	if (ret)
 		btrfs_swap_deactivate(file);
 
-	btrfs_drew_write_unlock(&root->snapshot_lock);
+	btrfs_drew_write_unlock(root->snapshot_lock);
 
 	btrfs_exclop_finish(fs_info);
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 5785336ab7cf..9f1b81ff37a3 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1008,7 +1008,7 @@ static noinline int btrfs_mksnapshot(const struct path *parent,
 	 * possible. This is to avoid later writeback (running dealloc) to
 	 * fallback to COW mode and unexpectedly fail with ENOSPC.
 	 */
-	btrfs_drew_read_lock(&root->snapshot_lock);
+	btrfs_drew_read_lock(root->snapshot_lock);
 
 	ret = btrfs_start_delalloc_snapshot(root, false);
 	if (ret)
@@ -1029,7 +1029,7 @@ static noinline int btrfs_mksnapshot(const struct path *parent,
 out:
 	if (snapshot_force_cow)
 		atomic_dec(&root->snapshot_force_cow);
-	btrfs_drew_read_unlock(&root->snapshot_lock);
+	btrfs_drew_read_unlock(root->snapshot_lock);
 	return ret;
 }
 
-- 
2.17.1

