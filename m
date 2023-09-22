Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2197AAFA6
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 12:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbjIVKhq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 06:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjIVKhm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 06:37:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BC91B6
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 03:37:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA275C433C7
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 10:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695379054;
        bh=ECCTmCloCoYGv4prd9pS8dIGwg8eHEWCwQRUJdNY51s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=msWoa8yGPe5ir3AtnRNyMUtFPumCL5d0joL95RaWHGj+7kPLa0VVUQHYPWqbJ1l52
         ANhDa06xR7esj6bL/I+lazWPGU3oxOeGLcc7VreCtq0oJSQCSjfxdrkfYu9fYQUh0U
         ecLwXhTzevyhibYMrILHIxHqWZB8czbMHcplxfrMJxso2ceSfeVCtVLs1e4AntA5b8
         PQxv3M4wKy2/TU5XvCGRCVOY/GlrwU+Vx6e5GngiA2F6bvzhPnfy4WkQfEhdKIV5S1
         2MrEpxjN1BIKDi591G4tLEhyWxSOcnbTF2u1BBXuRFSRisX+A8/JGtLuM6+Hrfmrr0
         lluoOEoat1Zzw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/8] btrfs: remove redundant root argument from btrfs_update_inode()
Date:   Fri, 22 Sep 2023 11:37:22 +0100
Message-Id: <cccbd191f2e3c18c826c06a24fb2758339fdf1ba.1695333082.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695333082.git.fdmanana@suse.com>
References: <cover.1695333082.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The root argument for btrfs_update_inode() always matches the root of the
given inode, so remove the root argument and get it from the inode
argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c      |  3 +--
 fs/btrfs/btrfs_inode.h      |  2 +-
 fs/btrfs/file.c             |  8 ++++----
 fs/btrfs/free-space-cache.c | 13 ++++++-------
 fs/btrfs/inode.c            | 34 +++++++++++++++++-----------------
 fs/btrfs/ioctl.c            |  2 +-
 fs/btrfs/reflink.c          |  3 +--
 fs/btrfs/tree-log.c         | 12 ++++++------
 fs/btrfs/verity.c           |  4 ++--
 fs/btrfs/xattr.c            |  4 ++--
 10 files changed, 41 insertions(+), 44 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 2b9aaeefaf76..6e2a4000bfe0 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3051,7 +3051,6 @@ static int cache_save_setup(struct btrfs_block_group *block_group,
 			    struct btrfs_path *path)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
-	struct btrfs_root *root = fs_info->tree_root;
 	struct inode *inode = NULL;
 	struct extent_changeset *data_reserved = NULL;
 	u64 alloc_hint = 0;
@@ -3103,7 +3102,7 @@ static int cache_save_setup(struct btrfs_block_group *block_group,
 	 * time.
 	 */
 	BTRFS_I(inode)->generation = 0;
-	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+	ret = btrfs_update_inode(trans, BTRFS_I(inode));
 	if (ret) {
 		/*
 		 * So theoretically we could recover from this, simply set the
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index d12556627cce..f2c928345d53 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -482,7 +482,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 				    struct page *page, size_t pg_offset,
 				    u64 start, u64 end);
 int btrfs_update_inode(struct btrfs_trans_handle *trans,
-		       struct btrfs_root *root, struct btrfs_inode *inode);
+		       struct btrfs_inode *inode);
 int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
 				struct btrfs_inode *inode);
 int btrfs_orphan_add(struct btrfs_trans_handle *trans, struct btrfs_inode *inode);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7d6652941210..e847043defce 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2460,7 +2460,7 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 		if (!extent_info || extent_info->update_times)
 			inode->vfs_inode.i_mtime = inode_set_ctime_current(&inode->vfs_inode);
 
-		ret = btrfs_update_inode(trans, root, inode);
+		ret = btrfs_update_inode(trans, inode);
 		if (ret)
 			break;
 
@@ -2700,7 +2700,7 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 	ASSERT(trans != NULL);
 	inode_inc_iversion(inode);
 	inode->i_mtime = inode_set_ctime_current(inode);
-	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+	ret = btrfs_update_inode(trans, BTRFS_I(inode));
 	updated_inode = true;
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
@@ -2726,7 +2726,7 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 		} else {
 			int ret2;
 
-			ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+			ret = btrfs_update_inode(trans, BTRFS_I(inode));
 			ret2 = btrfs_end_transaction(trans);
 			if (!ret)
 				ret = ret2;
@@ -2793,7 +2793,7 @@ static int btrfs_fallocate_update_isize(struct inode *inode,
 	inode_set_ctime_current(inode);
 	i_size_write(inode, end);
 	btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
-	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+	ret = btrfs_update_inode(trans, BTRFS_I(inode));
 	ret2 = btrfs_end_transaction(trans);
 
 	return ret ? ret : ret2;
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index acb8ef3dd6b0..6f93c9a2c3e3 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -359,7 +359,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto fail;
 
-	ret = btrfs_update_inode(trans, root, inode);
+	ret = btrfs_update_inode(trans, inode);
 
 fail:
 	if (locked)
@@ -1326,7 +1326,7 @@ static int __btrfs_wait_cache_io(struct btrfs_root *root,
 	  "failed to write free space cache for block group %llu error %d",
 				  block_group->start, ret);
 	}
-	btrfs_update_inode(trans, root, BTRFS_I(inode));
+	btrfs_update_inode(trans, BTRFS_I(inode));
 
 	if (block_group) {
 		/* the dirty list is protected by the dirty_bgs_lock */
@@ -1367,7 +1367,6 @@ int btrfs_wait_cache_io(struct btrfs_trans_handle *trans,
 /*
  * Write out cached info to an inode.
  *
- * @root:        root the inode belongs to
  * @inode:       freespace inode we are writing out
  * @ctl:         free space cache we are going to write out
  * @block_group: block_group for this cache if it belongs to a block_group
@@ -1378,7 +1377,7 @@ int btrfs_wait_cache_io(struct btrfs_trans_handle *trans,
  * on mount.  This will return 0 if it was successful in writing the cache out,
  * or an errno if it was not.
  */
-static int __btrfs_write_out_cache(struct btrfs_root *root, struct inode *inode,
+static int __btrfs_write_out_cache(struct inode *inode,
 				   struct btrfs_free_space_ctl *ctl,
 				   struct btrfs_block_group *block_group,
 				   struct btrfs_io_ctl *io_ctl,
@@ -1511,7 +1510,7 @@ static int __btrfs_write_out_cache(struct btrfs_root *root, struct inode *inode,
 		invalidate_inode_pages2(inode->i_mapping);
 		BTRFS_I(inode)->generation = 0;
 	}
-	btrfs_update_inode(trans, root, BTRFS_I(inode));
+	btrfs_update_inode(trans, BTRFS_I(inode));
 	if (must_iput)
 		iput(inode);
 	return ret;
@@ -1537,8 +1536,8 @@ int btrfs_write_out_cache(struct btrfs_trans_handle *trans,
 	if (IS_ERR(inode))
 		return 0;
 
-	ret = __btrfs_write_out_cache(fs_info->tree_root, inode, ctl,
-				block_group, &block_group->io_ctl, trans);
+	ret = __btrfs_write_out_cache(inode, ctl, block_group,
+				      &block_group->io_ctl, trans);
 	if (ret) {
 		btrfs_debug(fs_info,
 	  "failed to write free space cache for block group %llu error %d",
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 44836d1f99a9..13a97d3ce34a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -671,7 +671,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
 	}
 
 	btrfs_update_inode_bytes(inode, size, drop_args.bytes_found);
-	ret = btrfs_update_inode(trans, root, inode);
+	ret = btrfs_update_inode(trans, inode);
 	if (ret && ret != -ENOSPC) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -4002,9 +4002,9 @@ static noinline int btrfs_update_inode_item(struct btrfs_trans_handle *trans,
  * copy everything in the in-memory inode into the btree.
  */
 int btrfs_update_inode(struct btrfs_trans_handle *trans,
-		       struct btrfs_root *root,
 		       struct btrfs_inode *inode)
 {
+	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret;
 
@@ -4034,7 +4034,7 @@ int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
 {
 	int ret;
 
-	ret = btrfs_update_inode(trans, inode->root, inode);
+	ret = btrfs_update_inode(trans, inode);
 	if (ret == -ENOSPC)
 		return btrfs_update_inode_item(trans, inode->root, inode);
 	return ret;
@@ -4143,7 +4143,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	inode_inc_iversion(&dir->vfs_inode);
 	inode_set_ctime_current(&inode->vfs_inode);
 	dir->vfs_inode.i_mtime = inode_set_ctime_current(&dir->vfs_inode);
-	ret = btrfs_update_inode(trans, root, dir);
+	ret = btrfs_update_inode(trans, dir);
 out:
 	return ret;
 }
@@ -4157,7 +4157,7 @@ int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	ret = __btrfs_unlink_inode(trans, dir, inode, name, NULL);
 	if (!ret) {
 		drop_nlink(&inode->vfs_inode);
-		ret = btrfs_update_inode(trans, inode->root, inode);
+		ret = btrfs_update_inode(trans, inode);
 	}
 	return ret;
 }
@@ -4843,7 +4843,7 @@ static int maybe_insert_hole(struct btrfs_root *root, struct btrfs_inode *inode,
 		btrfs_abort_transaction(trans, ret);
 	} else {
 		btrfs_update_inode_bytes(inode, 0, drop_args.bytes_found);
-		btrfs_update_inode(trans, root, inode);
+		btrfs_update_inode(trans, inode);
 	}
 	btrfs_end_transaction(trans);
 	return ret;
@@ -4994,7 +4994,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		i_size_write(inode, newsize);
 		btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
 		pagecache_isize_extended(inode, oldsize, newsize);
-		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+		ret = btrfs_update_inode(trans, BTRFS_I(inode));
 		btrfs_drew_write_unlock(&root->snapshot_lock);
 		btrfs_end_transaction(trans);
 	} else {
@@ -6010,7 +6010,7 @@ static int btrfs_dirty_inode(struct btrfs_inode *inode)
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	ret = btrfs_update_inode(trans, root, inode);
+	ret = btrfs_update_inode(trans, inode);
 	if (ret == -ENOSPC || ret == -EDQUOT) {
 		/* whoops, lets try again with the full transaction */
 		btrfs_end_transaction(trans);
@@ -6018,7 +6018,7 @@ static int btrfs_dirty_inode(struct btrfs_inode *inode)
 		if (IS_ERR(trans))
 			return PTR_ERR(trans);
 
-		ret = btrfs_update_inode(trans, root, inode);
+		ret = btrfs_update_inode(trans, inode);
 	}
 	btrfs_end_transaction(trans);
 	if (inode->delayed_node)
@@ -6457,7 +6457,7 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 		parent_inode->vfs_inode.i_mtime =
 			inode_set_ctime_current(&parent_inode->vfs_inode);
 
-	ret = btrfs_update_inode(trans, root, parent_inode);
+	ret = btrfs_update_inode(trans, parent_inode);
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
 	return ret;
@@ -6608,7 +6608,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	} else {
 		struct dentry *parent = dentry->d_parent;
 
-		err = btrfs_update_inode(trans, root, BTRFS_I(inode));
+		err = btrfs_update_inode(trans, BTRFS_I(inode));
 		if (err)
 			goto fail;
 		if (inode->i_nlink == 1) {
@@ -8349,7 +8349,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 		if (ret != -ENOSPC && ret != -EAGAIN)
 			break;
 
-		ret = btrfs_update_inode(trans, root, inode);
+		ret = btrfs_update_inode(trans, inode);
 		if (ret)
 			break;
 
@@ -8402,7 +8402,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 		int ret2;
 
 		trans->block_rsv = &fs_info->trans_block_rsv;
-		ret2 = btrfs_update_inode(trans, root, inode);
+		ret2 = btrfs_update_inode(trans, inode);
 		if (ret2 && !ret)
 			ret = ret2;
 
@@ -8833,7 +8833,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 					   BTRFS_I(old_dentry->d_inode),
 					   old_name, &old_rename_ctx);
 		if (!ret)
-			ret = btrfs_update_inode(trans, root, BTRFS_I(old_inode));
+			ret = btrfs_update_inode(trans, BTRFS_I(old_inode));
 	}
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
@@ -8848,7 +8848,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 					   BTRFS_I(new_dentry->d_inode),
 					   new_name, &new_rename_ctx);
 		if (!ret)
-			ret = btrfs_update_inode(trans, dest, BTRFS_I(new_inode));
+			ret = btrfs_update_inode(trans, BTRFS_I(new_inode));
 	}
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
@@ -9093,7 +9093,7 @@ static int btrfs_rename(struct mnt_idmap *idmap,
 					   BTRFS_I(d_inode(old_dentry)),
 					   &old_fname.disk_name, &rename_ctx);
 		if (!ret)
-			ret = btrfs_update_inode(trans, root, BTRFS_I(old_inode));
+			ret = btrfs_update_inode(trans, BTRFS_I(old_inode));
 	}
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
@@ -9649,7 +9649,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 			btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
 		}
 
-		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+		ret = btrfs_update_inode(trans, BTRFS_I(inode));
 
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 018ea98b239a..24eae7c2b3ae 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -385,7 +385,7 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 	btrfs_sync_inode_flags_to_i_flags(inode);
 	inode_inc_iversion(inode);
 	inode_set_ctime_current(inode);
-	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+	ret = btrfs_update_inode(trans, BTRFS_I(inode));
 
  out_end_trans:
 	btrfs_end_transaction(trans);
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 65d2bd6910f2..fabd856e5079 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -25,7 +25,6 @@ static int clone_finish_inode_update(struct btrfs_trans_handle *trans,
 				     const u64 olen,
 				     int no_time_update)
 {
-	struct btrfs_root *root = BTRFS_I(inode)->root;
 	int ret;
 
 	inode_inc_iversion(inode);
@@ -43,7 +42,7 @@ static int clone_finish_inode_update(struct btrfs_trans_handle *trans,
 		btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
 	}
 
-	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+	ret = btrfs_update_inode(trans, BTRFS_I(inode));
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		btrfs_end_transaction(trans);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 595982434216..a7bba3d61e55 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -889,7 +889,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 
 update_inode:
 	btrfs_update_inode_bytes(BTRFS_I(inode), nbytes, drop_args.bytes_found);
-	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+	ret = btrfs_update_inode(trans, BTRFS_I(inode));
 out:
 	iput(inode);
 	return ret;
@@ -1444,7 +1444,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 			if (ret)
 				goto out;
 
-			ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+			ret = btrfs_update_inode(trans, BTRFS_I(inode));
 			if (ret)
 				goto out;
 		}
@@ -1622,7 +1622,7 @@ static noinline int fixup_inode_link_count(struct btrfs_trans_handle *trans,
 
 	if (nlink != inode->i_nlink) {
 		set_nlink(inode, nlink);
-		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+		ret = btrfs_update_inode(trans, BTRFS_I(inode));
 		if (ret)
 			goto out;
 	}
@@ -1731,7 +1731,7 @@ static noinline int link_to_fixup_dir(struct btrfs_trans_handle *trans,
 			set_nlink(inode, 1);
 		else
 			inc_nlink(inode);
-		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+		ret = btrfs_update_inode(trans, BTRFS_I(inode));
 	} else if (ret == -EEXIST) {
 		ret = 0;
 	}
@@ -1938,7 +1938,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 out:
 	if (!ret && update_size) {
 		btrfs_i_size_write(BTRFS_I(dir), dir->i_size + name.len * 2);
-		ret = btrfs_update_inode(trans, root, BTRFS_I(dir));
+		ret = btrfs_update_inode(trans, BTRFS_I(dir));
 	}
 	kfree(name.name);
 	iput(dir);
@@ -2482,7 +2482,7 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 							drop_args.bytes_found);
 					/* Update the inode's nbytes. */
 					ret = btrfs_update_inode(wc->trans,
-							root, BTRFS_I(inode));
+								 BTRFS_I(inode));
 				}
 				iput(inode);
 				if (ret)
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 744f4f4d4c68..66e2270b0dae 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -487,7 +487,7 @@ static int rollback_verity(struct btrfs_inode *inode)
 	}
 	inode->ro_flags &= ~BTRFS_INODE_RO_VERITY;
 	btrfs_sync_inode_flags_to_i_flags(&inode->vfs_inode);
-	ret = btrfs_update_inode(trans, root, inode);
+	ret = btrfs_update_inode(trans, inode);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -554,7 +554,7 @@ static int finish_verity(struct btrfs_inode *inode, const void *desc,
 	}
 	inode->ro_flags |= BTRFS_INODE_RO_VERITY;
 	btrfs_sync_inode_flags_to_i_flags(&inode->vfs_inode);
-	ret = btrfs_update_inode(trans, root, inode);
+	ret = btrfs_update_inode(trans, inode);
 	if (ret)
 		goto end_trans;
 	ret = del_orphan(trans, inode);
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index b906f809650e..76ff93b3eb27 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -265,7 +265,7 @@ int btrfs_setxattr_trans(struct inode *inode, const char *name,
 
 	inode_inc_iversion(inode);
 	inode_set_ctime_current(inode);
-	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+	ret = btrfs_update_inode(trans, BTRFS_I(inode));
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
 out:
@@ -408,7 +408,7 @@ static int btrfs_xattr_handler_set_prop(const struct xattr_handler *handler,
 	if (!ret) {
 		inode_inc_iversion(inode);
 		inode_set_ctime_current(inode);
-		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+		ret = btrfs_update_inode(trans, BTRFS_I(inode));
 		if (ret)
 			btrfs_abort_transaction(trans, ret);
 	}
-- 
2.40.1

