Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F101F2A2D4B
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgKBOtM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:49:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:39768 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbgKBOtL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 09:49:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604328549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fcyeIRM5QuDxFlmdFGpAepGfsHA4573yzU77a8knLyM=;
        b=H+LL10FDkQm3DfviqW10oV+7hHdE2bFORsH8jocWWQoHEEn7CR7B5N+qH92veSM6JtoqgA
        8s/yN/1sSTKfD2FBLBukVZ/IQEnKK6ERW7vW62nkMIhEX331F+DaU92ltmQVhED0+vN1Wc
        /nv1chFheQ6e6u8Y1EBNDqhonl55s9c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E4827B904;
        Mon,  2 Nov 2020 14:49:08 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 03/14] btrfs: Make btrfs_truncate_inode_items take btrfs_inode
Date:   Mon,  2 Nov 2020 16:48:55 +0200
Message-Id: <20201102144906.3767963-4-nborisov@suse.com>
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
 fs/btrfs/ctree.h            |  2 +-
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/inode.c            | 43 ++++++++++++++++++++-----------------
 fs/btrfs/tree-log.c         |  5 ++---
 4 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c0108a4730d1..f85a5e69614c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2998,7 +2998,7 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 			int front);
 int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root,
-			       struct inode *inode, u64 new_size,
+			       struct btrfs_inode *inode, u64 new_size,
 			       u32 min_type);
 
 int btrfs_start_delalloc_snapshot(struct btrfs_root *root);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 5ea36a06e514..48f059e91518 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -267,7 +267,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 	 * We skip the throttling logic for free space cache inodes, so we don't
 	 * need to check for -EAGAIN.
 	 */
-	ret = btrfs_truncate_inode_items(trans, root, inode,
+	ret = btrfs_truncate_inode_items(trans, root, BTRFS_I(inode),
 					 0, BTRFS_EXTENT_DATA_KEY);
 	if (ret)
 		goto fail;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f31132106fad..4ec4e59ddb47 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4130,7 +4130,7 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
  */
 int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root,
-			       struct inode *inode,
+			       struct btrfs_inode *inode,
 			       u64 new_size, u32 min_type)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -4151,7 +4151,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	int pending_del_slot = 0;
 	int extent_type = -1;
 	int ret;
-	u64 ino = btrfs_ino(BTRFS_I(inode));
+	u64 ino = btrfs_ino(inode);
 	u64 bytes_deleted = 0;
 	bool be_nice = false;
 	bool should_throttle = false;
@@ -4165,7 +4165,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	 * off from time to time.  This means all inodes in subvolume roots,
 	 * reloc roots, and data reloc roots.
 	 */
-	if (!btrfs_is_free_space_inode(BTRFS_I(inode)) &&
+	if (!btrfs_is_free_space_inode(inode) &&
 	    test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 		be_nice = true;
 
@@ -4175,7 +4175,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	path->reada = READA_BACK;
 
 	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
-		lock_extent_bits(&BTRFS_I(inode)->io_tree, lock_start, (u64)-1,
+		lock_extent_bits(&inode->io_tree, lock_start, (u64)-1,
 				 &cached_state);
 
 		/*
@@ -4183,7 +4183,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		 * new size is not block aligned since we will be keeping the
 		 * last block of the extent just the way it is.
 		 */
-		btrfs_drop_extent_cache(BTRFS_I(inode), ALIGN(new_size,
+		btrfs_drop_extent_cache(inode, ALIGN(new_size,
 					fs_info->sectorsize),
 					(u64)-1, 0);
 	}
@@ -4194,8 +4194,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	 * it is used to drop the logged items. So we shouldn't kill the delayed
 	 * items.
 	 */
-	if (min_type == 0 && root == BTRFS_I(inode)->root)
-		btrfs_kill_delayed_inode_items(BTRFS_I(inode));
+	if (min_type == 0 && root == inode->root)
+		btrfs_kill_delayed_inode_items(inode);
 
 	key.objectid = ino;
 	key.offset = (u64)-1;
@@ -4251,14 +4251,13 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 				    btrfs_file_extent_num_bytes(leaf, fi);
 
 				trace_btrfs_truncate_show_fi_regular(
-					BTRFS_I(inode), leaf, fi,
-					found_key.offset);
+					inode, leaf, fi, found_key.offset);
 			} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 				item_end += btrfs_file_extent_ram_bytes(leaf,
 									fi);
 
 				trace_btrfs_truncate_show_fi_inline(
-					BTRFS_I(inode), leaf, fi, path->slots[0],
+					inode, leaf, fi, path->slots[0],
 					found_key.offset);
 			}
 			item_end--;
@@ -4297,7 +4296,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 				if (test_bit(BTRFS_ROOT_SHAREABLE,
 					     &root->state) &&
 				    extent_start != 0)
-					inode_sub_bytes(inode, num_dec);
+					inode_sub_bytes(&inode->vfs_info,
+							num_dec);
 				btrfs_mark_buffer_dirty(leaf);
 			} else {
 				extent_num_bytes =
@@ -4312,7 +4312,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 					found_extent = 1;
 					if (test_bit(BTRFS_ROOT_SHAREABLE,
 						     &root->state))
-						inode_sub_bytes(inode, num_dec);
+						inode_sub_bytes(&inode->vfs_inode,
+								num_dec);
 				}
 			}
 			clear_len = num_dec;
@@ -4347,7 +4348,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			}
 
 			if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
-				inode_sub_bytes(inode, item_end + 1 - new_size);
+				inode_sub_bytes(&inode->vfs_inode,
+						item_end + 1 - new_size);
 		}
 delete:
 		/*
@@ -4355,8 +4357,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		 * multiple fsyncs, and in this case we don't want to clear the
 		 * file extent range because it's just the log.
 		 */
-		if (root == BTRFS_I(inode)->root) {
-			ret = btrfs_inode_clear_file_extent_range(BTRFS_I(inode),
+		if (root == inode->root) {
+			ret = btrfs_inode_clear_file_extent_range(inode,
 						  clear_start, clear_len);
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
@@ -4464,9 +4466,9 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		ASSERT(last_size >= new_size);
 		if (!ret && last_size > new_size)
 			last_size = new_size;
-		btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), last_size);
-		unlock_extent_cached(&BTRFS_I(inode)->io_tree, lock_start,
-				     (u64)-1, &cached_state);
+		btrfs_inode_safe_disk_i_size_write(inode, last_size);
+		unlock_extent_cached(&inode->io_tree, lock_start, (u64)-1,
+				     &cached_state);
 	}
 
 	btrfs_free_path(path);
@@ -5093,7 +5095,8 @@ void btrfs_evict_inode(struct inode *inode)
 
 		trans->block_rsv = rsv;
 
-		ret = btrfs_truncate_inode_items(trans, root, inode, 0, 0);
+		ret = btrfs_truncate_inode_items(trans, root, BTRFS_I(inode),
+						 0, 0);
 		trans->block_rsv = &fs_info->trans_block_rsv;
 		btrfs_end_transaction(trans);
 		btrfs_btree_balance_dirty(fs_info);
@@ -8456,7 +8459,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 	trans->block_rsv = rsv;
 
 	while (1) {
-		ret = btrfs_truncate_inode_items(trans, root, inode,
+		ret = btrfs_truncate_inode_items(trans, root, BTRFS_I(inode),
 						 inode->i_size,
 						 BTRFS_EXTENT_DATA_KEY);
 		trans->block_rsv = &fs_info->trans_block_rsv;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 135cb40295c1..4ea54fe23e3c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4365,8 +4365,7 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 			do {
 				ret = btrfs_truncate_inode_items(trans,
 							 root->log_root,
-							 &inode->vfs_inode,
-							 truncate_offset,
+							 inode, truncate_offset,
 							 BTRFS_EXTENT_DATA_KEY);
 			} while (ret == -EAGAIN);
 			if (ret)
@@ -5293,7 +5292,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 					  &inode->runtime_flags);
 				while(1) {
 					ret = btrfs_truncate_inode_items(trans,
-						log, &inode->vfs_inode, 0, 0);
+						log, inode, 0, 0);
 					if (ret != -EAGAIN)
 						break;
 				}
-- 
2.25.1

