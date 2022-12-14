Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A4764C228
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Dec 2022 03:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbiLNCLh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 21:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbiLNCLg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 21:11:36 -0500
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A25220E1
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 18:11:35 -0800 (PST)
From:   robbieko <robbieko@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1670983893; bh=kf0ITIjM8WQ7X4OdjEACXrniQHZKopXQI62U23e6Itw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VlQi7qfkR+qWT+bLMGJFb902ZyqIp9mdRf+35mJDzINRarWaavFUTF9mbL2Pz9uZI
         8PFP1OtOKRNJ5lJN+07IBzHvkI7UJEkrtb7iHXdhggRG0NXpu5k4oB7M/A1cjijFBB
         0Kvh3Q9HNW5xVe0kbNQf0X7ff1tZHA3rOYT1pkUk=
To:     linux-btrfs@vger.kernel.org
Cc:     Robbie Ko <robbieko@synology.com>
Subject: [PATCH v2 2/3] btrfs: change snapshot_lock to dynamic pointer
Date:   Wed, 14 Dec 2022 10:11:24 +0800
Message-Id: <20221214021125.28289-3-robbieko@synology.com>
In-Reply-To: <20221214021125.28289-1-robbieko@synology.com>
References: <20221214021125.28289-1-robbieko@synology.com>
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
 fs/btrfs/disk-io.c | 12 ++++++++++--
 fs/btrfs/file.c    |  8 ++++----
 fs/btrfs/inode.c   | 12 ++++++------
 fs/btrfs/ioctl.c   |  4 ++--
 5 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6965703a81b6..d0e703ad865f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -307,7 +307,7 @@ struct btrfs_root {
 	 */
 	int dedupe_in_progress;
 	/* For exclusion of snapshot creation and nocow writes */
-	struct btrfs_drew_lock snapshot_lock;
+	struct btrfs_drew_lock *snapshot_lock;
 
 	atomic_t snapshot_force_cow;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e45fd1ef5d11..ed2ce2dfbfcd 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1546,12 +1546,17 @@ static int btrfs_init_fs_root(struct btrfs_root *root,
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
@@ -2260,7 +2265,10 @@ void btrfs_put_root(struct btrfs_root *root)
 		WARN_ON(test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state));
 		if (root->anon_dev)
 			free_anon_bdev(root->anon_dev);
-		btrfs_drew_lock_destroy(&root->snapshot_lock);
+		if (root->snapshot_lock) {
+			btrfs_drew_lock_destroy(root->snapshot_lock);
+			kfree(root->snapshot_lock);
+		}
 		free_root_extent_buffers(root);
 #ifdef CONFIG_BTRFS_DEBUG
 		spin_lock(&root->fs_info->fs_roots_radix_lock);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 91b00eb2440e..377ed246792c 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1071,7 +1071,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 	if (!(inode->flags & (BTRFS_INODE_NODATACOW | BTRFS_INODE_PREALLOC)))
 		return 0;
 
-	if (!btrfs_drew_try_write_lock(&root->snapshot_lock))
+	if (!btrfs_drew_try_write_lock(root->snapshot_lock))
 		return -EAGAIN;
 
 	lockstart = round_down(pos, fs_info->sectorsize);
@@ -1082,7 +1082,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 	if (nowait) {
 		if (!btrfs_try_lock_ordered_range(inode, lockstart, lockend,
 						  &cached_state)) {
-			btrfs_drew_write_unlock(&root->snapshot_lock);
+			btrfs_drew_write_unlock(root->snapshot_lock);
 			return -EAGAIN;
 		}
 	} else {
@@ -1092,7 +1092,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 	ret = can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes,
 			NULL, NULL, NULL, nowait, false);
 	if (ret <= 0)
-		btrfs_drew_write_unlock(&root->snapshot_lock);
+		btrfs_drew_write_unlock(root->snapshot_lock);
 	else
 		*write_bytes = min_t(size_t, *write_bytes ,
 				     num_bytes - pos + lockstart);
@@ -1103,7 +1103,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 
 void btrfs_check_nocow_unlock(struct btrfs_inode *inode)
 {
-	btrfs_drew_write_unlock(&inode->root->snapshot_lock);
+	btrfs_drew_write_unlock(inode->root->snapshot_lock);
 }
 
 static void update_time_for_write(struct inode *inode)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8bcad9940154..a0a1cd70f5ee 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5218,16 +5218,16 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
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
 
@@ -5235,7 +5235,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
 		pagecache_isize_extended(inode, oldsize, newsize);
 		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
-		btrfs_drew_write_unlock(&root->snapshot_lock);
+		btrfs_drew_write_unlock(root->snapshot_lock);
 		btrfs_end_transaction(trans);
 	} else {
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -11090,7 +11090,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	 * completes before the first write into the swap file after it is
 	 * activated, than that write would fallback to COW.
 	 */
-	if (!btrfs_drew_try_write_lock(&root->snapshot_lock)) {
+	if (!btrfs_drew_try_write_lock(root->snapshot_lock)) {
 		btrfs_exclop_finish(fs_info);
 		btrfs_warn(fs_info,
 	   "cannot activate swapfile because snapshot creation is in progress");
@@ -11263,7 +11263,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	if (ret)
 		btrfs_swap_deactivate(file);
 
-	btrfs_drew_write_unlock(&root->snapshot_lock);
+	btrfs_drew_write_unlock(root->snapshot_lock);
 
 	btrfs_exclop_finish(fs_info);
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index de0cafe9b62b..9adaf3384f58 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1019,7 +1019,7 @@ static noinline int btrfs_mksnapshot(const struct path *parent,
 	 * possible. This is to avoid later writeback (running dealloc) to
 	 * fallback to COW mode and unexpectedly fail with ENOSPC.
 	 */
-	btrfs_drew_read_lock(&root->snapshot_lock);
+	btrfs_drew_read_lock(root->snapshot_lock);
 
 	ret = btrfs_start_delalloc_snapshot(root, false);
 	if (ret)
@@ -1040,7 +1040,7 @@ static noinline int btrfs_mksnapshot(const struct path *parent,
 out:
 	if (snapshot_force_cow)
 		atomic_dec(&root->snapshot_force_cow);
-	btrfs_drew_read_unlock(&root->snapshot_lock);
+	btrfs_drew_read_unlock(root->snapshot_lock);
 	return ret;
 }
 
-- 
2.17.1

