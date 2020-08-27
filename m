Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA2E254853
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Aug 2020 17:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgH0PE6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Aug 2020 11:04:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:44548 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbgH0PEb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Aug 2020 11:04:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A4D69B03D;
        Thu, 27 Aug 2020 15:05:01 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/1] btrfs: Track subdirectories in nlink
Date:   Thu, 27 Aug 2020 18:04:25 +0300
Message-Id: <20200827150426.23842-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827150426.23842-1-nborisov@suse.com>
References: <20200827150426.23842-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This adds the necessary calls to inc_nlink so that the number of
subdirectories are accounted for in the i_nlink count of a directory. It
works also for subvolumes and snapshots. Unfortunately the state of the
on-disk i_nlink is codified in the tree checker so I had to remove the
check but such filesystems will refuse to mount on older kernels.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c        | 13 +++++++++++--
 fs/btrfs/ioctl.c        | 10 +++++++---
 fs/btrfs/transaction.c  | 12 ++++++++----
 fs/btrfs/tree-checker.c |  7 +------
 4 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 40fed3285f62..e82eb501fe0d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3635,6 +3635,8 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	inode_inc_iversion(&dir->vfs_inode);
 	inode->vfs_inode.i_ctime = dir->vfs_inode.i_mtime =
 		dir->vfs_inode.i_ctime = current_time(&inode->vfs_inode);
+	if (S_ISDIR(inode->vfs_inode.i_mode))
+		drop_nlink(&dir->vfs_inode);
 	ret = btrfs_update_inode(trans, root, &dir->vfs_inode);
 out:
 	return ret;
@@ -3798,9 +3800,12 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	btrfs_i_size_write(BTRFS_I(dir), dir->i_size - name_len * 2);
 	inode_inc_iversion(dir);
 	dir->i_mtime = dir->i_ctime = current_time(dir);
+	drop_nlink(dir);
 	ret = btrfs_update_inode_fallback(trans, root, dir);
-	if (ret)
+	if (ret) {
 		btrfs_abort_transaction(trans, ret);
+		inc_nlink(dir);
+	}
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -6137,9 +6142,13 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 		parent_inode->vfs_inode.i_mtime = now;
 		parent_inode->vfs_inode.i_ctime = now;
 	}
+	if (S_ISDIR(inode->vfs_inode.i_mode))
+		inc_nlink(&parent_inode->vfs_inode);
 	ret = btrfs_update_inode(trans, root, &parent_inode->vfs_inode);
-	if (ret)
+	if (ret) {
 		btrfs_abort_transaction(trans, ret);
+		drop_nlink(&parent_inode->vfs_inode);
+	}
 	return ret;
 
 fail_dir_item:
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index f12c3df3c216..96b8daa8e8e1 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -716,21 +716,22 @@ static noinline int create_subvol(struct inode *dir,
 				    BTRFS_FT_DIR, index);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
-		goto fail;
+		goto fail_drop_nlink;
 	}
 
 	btrfs_i_size_write(BTRFS_I(dir), dir->i_size + namelen * 2);
+	inc_nlink(dir);
 	ret = btrfs_update_inode(trans, root, dir);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
-		goto fail;
+		goto fail_drop_nlink;
 	}
 
 	ret = btrfs_add_root_ref(trans, objectid, root->root_key.objectid,
 				 btrfs_ino(BTRFS_I(dir)), index, name, namelen);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
-		goto fail;
+		goto fail_drop_nlink;
 	}
 
 	ret = btrfs_uuid_tree_add(trans, root_item->uuid,
@@ -738,6 +739,9 @@ static noinline int create_subvol(struct inode *dir,
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
 
+fail_drop_nlink:
+	if (ret)
+		drop_nlink(dir);
 fail:
 	kfree(root_item);
 	trans->block_rsv = NULL;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index a1a8a35263a9..7717c4f522aa 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1677,17 +1677,18 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 					 dentry->d_name.len * 2);
 	parent_inode->i_mtime = parent_inode->i_ctime =
 		current_time(parent_inode);
+	inc_nlink(parent_inode);
 	ret = btrfs_update_inode_fallback(trans, parent_root, parent_inode);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
-		goto fail;
+		goto fail_drop_nlink;
 	}
 	ret = btrfs_uuid_tree_add(trans, new_root_item->uuid,
 				  BTRFS_UUID_KEY_SUBVOL,
 				  objectid);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
-		goto fail;
+		goto fail_drop_nlink;
 	}
 	if (!btrfs_is_empty_uuid(new_root_item->received_uuid)) {
 		ret = btrfs_uuid_tree_add(trans, new_root_item->received_uuid,
@@ -1695,16 +1696,19 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 					  objectid);
 		if (ret && ret != -EEXIST) {
 			btrfs_abort_transaction(trans, ret);
-			goto fail;
+			goto fail_drop_nlink;
 		}
 	}
 
 	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
-		goto fail;
+		goto fail_drop_nlink;
 	}
 
+fail_drop_nlink:
+	if (ret)
+		drop_nlink(parent_inode);
 fail:
 	pending->error = ret;
 dir_item_existed:
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 517b44300a05..c353700b03c5 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1015,12 +1015,7 @@ static int check_inode_item(struct extent_buffer *leaf,
 			return -EUCLEAN;
 		}
 	}
-	if (S_ISDIR(mode) && btrfs_inode_nlink(leaf, iitem) > 1) {
-		inode_item_err(leaf, slot,
-		       "invalid nlink: has %u expect no more than 1 for dir",
-			btrfs_inode_nlink(leaf, iitem));
-		return -EUCLEAN;
-	}
+
 	if (btrfs_inode_flags(leaf, iitem) & ~BTRFS_INODE_FLAG_MASK) {
 		inode_item_err(leaf, slot,
 			       "unknown flags detected: 0x%llx",
-- 
2.17.1

