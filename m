Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03662A2D4F
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgKBOtQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:49:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:39864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgKBOtM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 09:49:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604328550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MTdVEwf3m8UVE9iNbxXcTzP76FgF9l9/Jr9k/VuJoB4=;
        b=tUaVuClz2QZGX9pAcX1JgwF1HltaqG5PyBpf5bTPI+5EfVW+TK5JYLZbufkQJ8O8u17kCy
        2QVcIvPJlDe+CVfIAtbKDrTHcoMN08L23ax0azFI6XfEpKh5PA4ByOcPHMeF08lBYhceqi
        P/wh9ZVcdWy7KJFwLN67njBzxSnMBoU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04960B911;
        Mon,  2 Nov 2020 14:49:10 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 07/14] btrfs: Make btrfs_update_inode take btrfs_inode
Date:   Mon,  2 Nov 2020 16:48:59 +0200
Message-Id: <20201102144906.3767963-8-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102144906.3767963-1-nborisov@suse.com>
References: <20201102144906.3767963-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/block-group.c      |  2 +-
 fs/btrfs/ctree.h            |  3 +-
 fs/btrfs/file.c             |  8 +++---
 fs/btrfs/free-space-cache.c |  6 ++--
 fs/btrfs/inode-map.c        |  2 +-
 fs/btrfs/inode.c            | 57 +++++++++++++++++++------------------
 fs/btrfs/ioctl.c            |  6 ++--
 fs/btrfs/reflink.c          |  2 +-
 fs/btrfs/tree-log.c         | 13 +++++----
 fs/btrfs/xattr.c            |  4 +--
 10 files changed, 52 insertions(+), 51 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index bb6685711824..d2fd228a90a7 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2449,7 +2449,7 @@ static int cache_save_setup(struct btrfs_block_group *block_group,
 	 * time.
 	 */
 	BTRFS_I(inode)->generation = 0;
-	ret = btrfs_update_inode(trans, root, inode);
+	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	if (ret) {
 		/*
 		 * So theoretically we could recover from this, simply set the
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f85a5e69614c..a23a7de6a4f3 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3038,8 +3038,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 				    struct page *page, size_t pg_offset,
 				    u64 start, u64 end);
 int btrfs_update_inode(struct btrfs_trans_handle *trans,
-			      struct btrfs_root *root,
-			      struct inode *inode);
+		       struct btrfs_root *root, struct btrfs_inode *inode);
 int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
 				struct btrfs_root *root, struct inode *inode);
 int btrfs_orphan_add(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 4b44ad980a5d..56f6548da451 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2760,7 +2760,7 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 
 		cur_offset = drop_end;
 
-		ret = btrfs_update_inode(trans, root, inode);
+		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 		if (ret)
 			break;
 
@@ -2995,7 +2995,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	ASSERT(trans != NULL);
 	inode_inc_iversion(inode);
 	inode->i_mtime = inode->i_ctime = current_time(inode);
-	ret = btrfs_update_inode(trans, root, inode);
+	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	updated_inode = true;
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
@@ -3022,7 +3022,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		} else {
 			int ret2;
 
-			ret = btrfs_update_inode(trans, root, inode);
+			ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 			ret2 = btrfs_end_transaction(trans);
 			if (!ret)
 				ret = ret2;
@@ -3091,7 +3091,7 @@ static int btrfs_fallocate_update_isize(struct inode *inode,
 	inode->i_ctime = current_time(inode);
 	i_size_write(inode, end);
 	btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
-	ret = btrfs_update_inode(trans, root, inode);
+	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	ret2 = btrfs_end_transaction(trans);
 
 	return ret ? ret : ret2;
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 48f059e91518..d72afb76a9f9 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -272,7 +272,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto fail;
 
-	ret = btrfs_update_inode(trans, root, inode);
+	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 
 fail:
 	if (locked)
@@ -1191,7 +1191,7 @@ static int __btrfs_wait_cache_io(struct btrfs_root *root,
 	  "failed to write free space cache for block group %llu error %d",
 				  block_group->start, ret);
 	}
-	btrfs_update_inode(trans, root, inode);
+	btrfs_update_inode(trans, root, BTRFS_I(inode));
 
 	if (block_group) {
 		/* the dirty list is protected by the dirty_bgs_lock */
@@ -1381,7 +1381,7 @@ static int __btrfs_write_out_cache(struct btrfs_root *root, struct inode *inode,
 		invalidate_inode_pages2(inode->i_mapping);
 		BTRFS_I(inode)->generation = 0;
 	}
-	btrfs_update_inode(trans, root, inode);
+	btrfs_update_inode(trans, root, BTRFS_I(inode));
 	if (must_iput)
 		iput(inode);
 	return ret;
diff --git a/fs/btrfs/inode-map.c b/fs/btrfs/inode-map.c
index 76d2e43817ea..8cf39402b227 100644
--- a/fs/btrfs/inode-map.c
+++ b/fs/btrfs/inode-map.c
@@ -463,7 +463,7 @@ int btrfs_save_ino_cache(struct btrfs_root *root,
 	}
 
 	BTRFS_I(inode)->generation = 0;
-	ret = btrfs_update_inode(trans, root, inode);
+	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out_put;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4165eb322c11..a82dbc683a43 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -256,7 +256,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	 * could end up racing with unlink.
 	 */
 	BTRFS_I(inode)->disk_i_size = inode->i_size;
-	ret = btrfs_update_inode(trans, root, inode);
+	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 
 fail:
 	return ret;
@@ -3487,7 +3487,8 @@ static noinline int btrfs_update_inode_item(struct btrfs_trans_handle *trans,
  * copy everything in the in-memory inode into the btree.
  */
 noinline int btrfs_update_inode(struct btrfs_trans_handle *trans,
-				struct btrfs_root *root, struct inode *inode)
+				struct btrfs_root *root,
+				struct btrfs_inode *inode)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret;
@@ -3499,18 +3500,18 @@ noinline int btrfs_update_inode(struct btrfs_trans_handle *trans,
 	 * The data relocation inode should also be directly updated
 	 * without delay
 	 */
-	if (!btrfs_is_free_space_inode(BTRFS_I(inode))
+	if (!btrfs_is_free_space_inode(inode)
 	    && root->root_key.objectid != BTRFS_DATA_RELOC_TREE_OBJECTID
 	    && !test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags)) {
 		btrfs_update_root_times(trans, root);
 
-		ret = btrfs_delayed_update_inode(trans, root, BTRFS_I(inode));
+		ret = btrfs_delayed_update_inode(trans, root, inode);
 		if (!ret)
-			btrfs_set_inode_last_trans(trans, BTRFS_I(inode));
+			btrfs_set_inode_last_trans(trans, inode);
 		return ret;
 	}
 
-	return btrfs_update_inode_item(trans, root, BTRFS_I(inode));
+	return btrfs_update_inode_item(trans, root, inode);
 }
 
 noinline int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
@@ -3519,7 +3520,7 @@ noinline int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
 {
 	int ret;
 
-	ret = btrfs_update_inode(trans, root, inode);
+	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	if (ret == -ENOSPC)
 		return btrfs_update_inode_item(trans, root, BTRFS_I(inode));
 	return ret;
@@ -3630,7 +3631,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	inode_inc_iversion(&dir->vfs_inode);
 	inode->vfs_inode.i_ctime = dir->vfs_inode.i_mtime =
 		dir->vfs_inode.i_ctime = current_time(&inode->vfs_inode);
-	ret = btrfs_update_inode(trans, root, &dir->vfs_inode);
+	ret = btrfs_update_inode(trans, root, dir);
 out:
 	return ret;
 }
@@ -3644,7 +3645,7 @@ int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	ret = __btrfs_unlink_inode(trans, root, dir, inode, name, name_len);
 	if (!ret) {
 		drop_nlink(&inode->vfs_inode);
-		ret = btrfs_update_inode(trans, root, &inode->vfs_inode);
+		ret = btrfs_update_inode(trans, root, inode);
 	}
 	return ret;
 }
@@ -4662,7 +4663,7 @@ static int maybe_insert_hole(struct btrfs_root *root, struct inode *inode,
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
 	else
-		btrfs_update_inode(trans, root, inode);
+		btrfs_update_inode(trans, root, BTRFS_I(inode));
 	btrfs_end_transaction(trans);
 	return ret;
 }
@@ -4823,7 +4824,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		i_size_write(inode, newsize);
 		btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
 		pagecache_isize_extended(inode, oldsize, newsize);
-		ret = btrfs_update_inode(trans, root, inode);
+		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 		btrfs_drew_write_unlock(&root->snapshot_lock);
 		btrfs_end_transaction(trans);
 	} else {
@@ -5735,7 +5736,7 @@ static int btrfs_dirty_inode(struct inode *inode)
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	ret = btrfs_update_inode(trans, root, inode);
+	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	if (ret && ret == -ENOSPC) {
 		/* whoops, lets try again with the full transaction */
 		btrfs_end_transaction(trans);
@@ -5743,7 +5744,7 @@ static int btrfs_dirty_inode(struct inode *inode)
 		if (IS_ERR(trans))
 			return PTR_ERR(trans);
 
-		ret = btrfs_update_inode(trans, root, inode);
+		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	}
 	btrfs_end_transaction(trans);
 	if (BTRFS_I(inode)->delayed_node)
@@ -6132,7 +6133,7 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 		parent_inode->vfs_inode.i_mtime = now;
 		parent_inode->vfs_inode.i_ctime = now;
 	}
-	ret = btrfs_update_inode(trans, root, &parent_inode->vfs_inode);
+	ret = btrfs_update_inode(trans, root, parent_inode);
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
 	return ret;
@@ -6223,7 +6224,7 @@ static int btrfs_mknod(struct inode *dir, struct dentry *dentry,
 	if (err)
 		goto out_unlock;
 
-	btrfs_update_inode(trans, root, inode);
+	btrfs_update_inode(trans, root, BTRFS_I(inode));
 	d_instantiate_new(dentry, inode);
 
 out_unlock:
@@ -6282,7 +6283,7 @@ static int btrfs_create(struct inode *dir, struct dentry *dentry,
 	if (err)
 		goto out_unlock;
 
-	err = btrfs_update_inode(trans, root, inode);
+	err = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	if (err)
 		goto out_unlock;
 
@@ -6354,7 +6355,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	} else {
 		struct dentry *parent = dentry->d_parent;
 
-		err = btrfs_update_inode(trans, root, inode);
+		err = btrfs_update_inode(trans, root, BTRFS_I(inode));
 		if (err)
 			goto fail;
 		if (inode->i_nlink == 1) {
@@ -6422,7 +6423,7 @@ static int btrfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 		goto out_fail;
 
 	btrfs_i_size_write(BTRFS_I(inode), 0);
-	err = btrfs_update_inode(trans, root, inode);
+	err = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	if (err)
 		goto out_fail;
 
@@ -8465,7 +8466,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 		if (ret != -ENOSPC && ret != -EAGAIN)
 			break;
 
-		ret = btrfs_update_inode(trans, root, inode);
+		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 		if (ret)
 			break;
 
@@ -8511,7 +8512,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 		int ret2;
 
 		trans->block_rsv = &fs_info->trans_block_rsv;
-		ret2 = btrfs_update_inode(trans, root, inode);
+		ret2 = btrfs_update_inode(trans, root, BTRFS_I(inode));
 		if (ret2 && !ret)
 			ret = ret2;
 
@@ -8557,7 +8558,7 @@ int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
 			  "error inheriting subvolume %llu properties: %d",
 			  new_root->root_key.objectid, err);
 
-	err = btrfs_update_inode(trans, new_root, inode);
+	err = btrfs_update_inode(trans, new_root, BTRFS_I(inode));
 
 	iput(inode);
 	return err;
@@ -8912,7 +8913,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 					   old_dentry->d_name.name,
 					   old_dentry->d_name.len);
 		if (!ret)
-			ret = btrfs_update_inode(trans, root, old_inode);
+			ret = btrfs_update_inode(trans, root, BTRFS_I(old_inode));
 	}
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
@@ -8928,7 +8929,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 					   new_dentry->d_name.name,
 					   new_dentry->d_name.len);
 		if (!ret)
-			ret = btrfs_update_inode(trans, dest, new_inode);
+			ret = btrfs_update_inode(trans, dest, BTRFS_I(new_inode));
 	}
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
@@ -9048,7 +9049,7 @@ static int btrfs_whiteout_for_rename(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	ret = btrfs_update_inode(trans, root, inode);
+	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 out:
 	unlock_new_inode(inode);
 	if (ret)
@@ -9182,7 +9183,7 @@ static int btrfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 					old_dentry->d_name.name,
 					old_dentry->d_name.len);
 		if (!ret)
-			ret = btrfs_update_inode(trans, root, old_inode);
+			ret = btrfs_update_inode(trans, root, BTRFS_I(old_inode));
 	}
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
@@ -9542,7 +9543,7 @@ static int btrfs_symlink(struct inode *dir, struct dentry *dentry,
 	inode_nohighmem(inode);
 	inode_set_bytes(inode, name_len);
 	btrfs_i_size_write(BTRFS_I(inode), name_len);
-	err = btrfs_update_inode(trans, root, inode);
+	err = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	/*
 	 * Last step, add directory indexes for our symlink inode. This is the
 	 * last step to avoid extra cleanup of these indexes if an error happens
@@ -9738,7 +9739,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 			btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
 		}
 
-		ret = btrfs_update_inode(trans, root, inode);
+		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -9834,7 +9835,7 @@ static int btrfs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 	if (ret)
 		goto out;
 
-	ret = btrfs_update_inode(trans, root, inode);
+	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	if (ret)
 		goto out;
 	ret = btrfs_orphan_add(trans, BTRFS_I(inode));
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 30f86670635f..53a02b50340d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -336,7 +336,7 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 	btrfs_sync_inode_flags_to_i_flags(inode);
 	inode_inc_iversion(inode);
 	inode->i_ctime = current_time(inode);
-	ret = btrfs_update_inode(trans, root, inode);
+	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 
  out_end_trans:
 	btrfs_end_transaction(trans);
@@ -479,7 +479,7 @@ static int btrfs_ioctl_fssetxattr(struct file *file, void __user *arg)
 	btrfs_sync_inode_flags_to_i_flags(inode);
 	inode_inc_iversion(inode);
 	inode->i_ctime = current_time(inode);
-	ret = btrfs_update_inode(trans, root, inode);
+	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 
 	btrfs_end_transaction(trans);
 
@@ -733,7 +733,7 @@ static noinline int create_subvol(struct inode *dir,
 	}
 
 	btrfs_i_size_write(BTRFS_I(dir), dir->i_size + namelen * 2);
-	ret = btrfs_update_inode(trans, root, dir);
+	ret = btrfs_update_inode(trans, root, BTRFS_I(dir));
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index e624f4cd0585..f896dfba771b 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -34,7 +34,7 @@ static int clone_finish_inode_update(struct btrfs_trans_handle *trans,
 		btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
 	}
 
-	ret = btrfs_update_inode(trans, root, inode);
+	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		btrfs_end_transaction(trans);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 4ea54fe23e3c..baa2c4cfd293 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -830,7 +830,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 
 	inode_add_bytes(inode, nbytes);
 update_inode:
-	ret = btrfs_update_inode(trans, root, inode);
+	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 out:
 	if (inode)
 		iput(inode);
@@ -1529,7 +1529,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 			if (ret)
 				goto out;
 
-			btrfs_update_inode(trans, root, inode);
+			btrfs_update_inode(trans, root, BTRFS_I(inode));
 		}
 
 		ref_ptr = (unsigned long)(ref_ptr + ref_struct_size) + namelen;
@@ -1704,7 +1704,7 @@ static noinline int fixup_inode_link_count(struct btrfs_trans_handle *trans,
 
 	if (nlink != inode->i_nlink) {
 		set_nlink(inode, nlink);
-		btrfs_update_inode(trans, root, inode);
+		btrfs_update_inode(trans, root, BTRFS_I(inode));
 	}
 	BTRFS_I(inode)->index_cnt = (u64)-1;
 
@@ -1810,7 +1810,7 @@ static noinline int link_to_fixup_dir(struct btrfs_trans_handle *trans,
 			set_nlink(inode, 1);
 		else
 			inc_nlink(inode);
-		ret = btrfs_update_inode(trans, root, inode);
+		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	} else if (ret == -EEXIST) {
 		ret = 0;
 	} else {
@@ -1963,7 +1963,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	btrfs_release_path(path);
 	if (!ret && update_size) {
 		btrfs_i_size_write(BTRFS_I(dir), dir->i_size + name_len * 2);
-		ret = btrfs_update_inode(trans, root, dir);
+		ret = btrfs_update_inode(trans, root, BTRFS_I(dir));
 	}
 	kfree(name);
 	iput(dir);
@@ -2591,7 +2591,8 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 				if (!ret) {
 					/* Update the inode's nbytes. */
 					ret = btrfs_update_inode(wc->trans,
-								 root, inode);
+								 root,
+								 BTRFS_I(inode));
 				}
 				iput(inode);
 				if (ret)
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 95d9aebff2c4..f32fe9e39a74 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -239,7 +239,7 @@ int btrfs_setxattr_trans(struct inode *inode, const char *name,
 
 	inode_inc_iversion(inode);
 	inode->i_ctime = current_time(inode);
-	ret = btrfs_update_inode(trans, root, inode);
+	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	BUG_ON(ret);
 out:
 	btrfs_end_transaction(trans);
@@ -390,7 +390,7 @@ static int btrfs_xattr_handler_set_prop(const struct xattr_handler *handler,
 	if (!ret) {
 		inode_inc_iversion(inode);
 		inode->i_ctime = current_time(inode);
-		ret = btrfs_update_inode(trans, root, inode);
+		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 		BUG_ON(ret);
 	}
 
-- 
2.25.1

