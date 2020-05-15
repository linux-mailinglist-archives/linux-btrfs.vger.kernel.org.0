Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FAB1D4585
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 May 2020 08:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgEOGBx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 May 2020 02:01:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:44830 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgEOGBw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 May 2020 02:01:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C7751AD0D
        for <linux-btrfs@vger.kernel.org>; Fri, 15 May 2020 06:01:52 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/3] btrfs: Rename BTRFS_ROOT_REF_COWS to BTRFS_ROOT_SHAREABLE
Date:   Fri, 15 May 2020 14:01:40 +0800
Message-Id: <20200515060142.23609-2-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515060142.23609-1-wqu@suse.com>
References: <20200515060142.23609-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The name BTRFS_ROOT_REF_COWS is not helpful to show what it really
means.

In fact, that bit can only be set to those trees:
- Subvolume roots
- Data reloc root
- Reloc roots for above roots

All other trees won't get this bit set.
So just by the result, it is obvious that, roots with this bit set can
have tree blocks shared with other trees.
Either shared by snapshots, or by reloc roots (an special snapshot
created by relocation).

This patch will rename BTRFS_ROOT_REF_COWS to BTRFS_ROOT_SHAREABLE to
make it easier to understand, and update all comment mentioning
"reference counted" to follow the rename.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.c     |  4 ++--
 fs/btrfs/backref.h     |  2 +-
 fs/btrfs/block-rsv.c   |  2 +-
 fs/btrfs/ctree.c       | 26 +++++++++++++-------------
 fs/btrfs/ctree.h       | 24 ++++++++++++++++++++++--
 fs/btrfs/disk-io.c     | 13 +++++++------
 fs/btrfs/extent-tree.c |  2 +-
 fs/btrfs/file.c        |  2 +-
 fs/btrfs/inode.c       | 18 ++++++++++--------
 fs/btrfs/ioctl.c       |  2 +-
 fs/btrfs/relocation.c  | 24 +++++++++++++-----------
 fs/btrfs/transaction.c | 12 ++++++------
 fs/btrfs/tree-defrag.c |  2 +-
 13 files changed, 79 insertions(+), 54 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 60a69f7c0b36..f1ff92eb14f3 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2702,7 +2702,7 @@ static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
 	root = btrfs_get_fs_root(fs_info, &root_key, false);
 	if (IS_ERR(root))
 		return PTR_ERR(root);
-	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
+	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 		cur->cowonly = 1;
 
 	if (btrfs_root_level(&root->root_item) == cur->level) {
@@ -2789,7 +2789,7 @@ static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
 				goto out;
 			}
 			upper->owner = btrfs_header_owner(eb);
-			if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
+			if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 				upper->cowonly = 1;
 
 			/*
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 18393cc05ca2..ff705cc564a9 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -184,7 +184,7 @@ struct btrfs_backref_node {
 	struct extent_buffer *eb;
 	/* Level of the tree block */
 	unsigned int level:8;
-	/* Is the block in non-reference counted tree */
+	/* Is the block in a non-shareable tree */
 	unsigned int cowonly:1;
 	/* 1 if no child node is in the cache */
 	unsigned int lowest:1;
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index dbba53e712e6..7e1549a84fcc 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -458,7 +458,7 @@ static struct btrfs_block_rsv *get_block_rsv(
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_block_rsv *block_rsv = NULL;
 
-	if (test_bit(BTRFS_ROOT_REF_COWS, &root->state) ||
+	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
 	    (root == fs_info->csum_root && trans->adding_csums) ||
 	    (root == fs_info->uuid_root))
 		block_rsv = trans->block_rsv;
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 6c28efe5b14a..90a9e238ead8 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -144,9 +144,10 @@ struct extent_buffer *btrfs_root_node(struct btrfs_root *root)
 	return eb;
 }
 
-/* cowonly root (everything not a reference counted cow subvolume), just get
- * put onto a simple dirty list.  transaction.c walks this to make sure they
- * get properly updated on disk.
+/*
+ * Cowonly root (not shareable trees, everything not subvolume roots or reloc
+ * roots), just get put onto a simple dirty list.  transaction.c walks this to
+ * make sure they get properly updated on disk.
  */
 static void add_root_to_dirty_list(struct btrfs_root *root)
 {
@@ -185,9 +186,9 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 	int level;
 	struct btrfs_disk_key disk_key;
 
-	WARN_ON(test_bit(BTRFS_ROOT_REF_COWS, &root->state) &&
+	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
 		trans->transid != fs_info->running_transaction->transid);
-	WARN_ON(test_bit(BTRFS_ROOT_REF_COWS, &root->state) &&
+	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
 		trans->transid != root->last_trans);
 
 	level = btrfs_header_level(buf);
@@ -826,12 +827,11 @@ int btrfs_block_can_be_shared(struct btrfs_root *root,
 			      struct extent_buffer *buf)
 {
 	/*
-	 * Tree blocks not in reference counted trees and tree roots
-	 * are never shared. If a block was allocated after the last
-	 * snapshot and the block was not allocated by tree relocation,
-	 * we know the block is not shared.
+	 * Tree blocks not in shareable trees and tree roots are never shared.
+	 * If a block was allocated after the last snapshot and the block was
+	 * not allocated by tree relocation, we know the block is not shared.
 	 */
-	if (test_bit(BTRFS_ROOT_REF_COWS, &root->state) &&
+	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
 	    buf != root->node && buf != root->commit_root &&
 	    (btrfs_header_generation(buf) <=
 	     btrfs_root_last_snapshot(&root->root_item) ||
@@ -1024,9 +1024,9 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 
 	btrfs_assert_tree_locked(buf);
 
-	WARN_ON(test_bit(BTRFS_ROOT_REF_COWS, &root->state) &&
+	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
 		trans->transid != fs_info->running_transaction->transid);
-	WARN_ON(test_bit(BTRFS_ROOT_REF_COWS, &root->state) &&
+	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
 		trans->transid != root->last_trans);
 
 	level = btrfs_header_level(buf);
@@ -1065,7 +1065,7 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 
-	if (test_bit(BTRFS_ROOT_REF_COWS, &root->state)) {
+	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
 		ret = btrfs_reloc_cow_block(trans, root, buf, cow);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 03ea7370aea7..65c09aea4cb9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -969,7 +969,27 @@ enum {
 	 * is used to tell us when more checks are required
 	 */
 	BTRFS_ROOT_IN_TRANS_SETUP,
-	BTRFS_ROOT_REF_COWS,
+
+	/*
+	 * If tree blocks of this root can be shared between other roots.
+	 * Only subvolume trees and their reloc trees have this bit set.
+	 * Conflicts with TRACK_DIRTY bit.
+	 *
+	 * This affects two things:
+	 * - How balance works
+	 *   For shareable roots, btrfs needs to use reloc tree and do path
+	 *   replacement for balance, and needs various pre/post hooks for
+	 *   snapshot creation to handle them.
+	 *
+	 *   While for non shareable trees, we just simply do a tree search
+	 *   with COW.
+	 *
+	 * - How dirty roots are tracked
+	 *   For shareable roots, btrfs_record_root_in_trans() is needed to
+	 *   trace them, while non subvolume roots have TRACK_DIRTY bit, they
+	 *   don't need manual record.
+	 */
+	BTRFS_ROOT_SHAREABLE,
 	BTRFS_ROOT_TRACK_DIRTY,
 	BTRFS_ROOT_IN_RADIX,
 	BTRFS_ROOT_ORPHAN_ITEM_INSERTED,
@@ -1055,7 +1075,7 @@ struct btrfs_root {
 	struct btrfs_key defrag_progress;
 	struct btrfs_key defrag_max;
 
-	/* the dirty list is only used by non-reference counted roots */
+	/* the dirty list is only used by non-shareable roots */
 	struct list_head dirty_list;
 
 	struct list_head root_list;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8ad451695d49..76b165ad497f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1275,12 +1275,13 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
 	root->root_key.offset = BTRFS_TREE_LOG_OBJECTID;
 
 	/*
-	 * DON'T set REF_COWS for log trees
+	 * DON'T set SHAREABLE bit for log trees.
 	 *
-	 * log trees do not get reference counted because they go away
-	 * before a real commit is actually done.  They do store pointers
-	 * to file data extents, and those reference counts still get
-	 * updated (along with back refs to the log tree).
+	 * Log trees are not exposed to user space thus can't be snapshotted,
+	 * and they go away before a real commit is actually done.
+	 *
+	 * They do store pointers to file data extents, and those reference
+	 * counts still get updated (along with back refs to the log tree).
 	 */
 
 	leaf = btrfs_alloc_tree_block(trans, root, 0, BTRFS_TREE_LOG_OBJECTID,
@@ -1419,7 +1420,7 @@ static int btrfs_init_fs_root(struct btrfs_root *root)
 		goto fail;
 
 	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
-		set_bit(BTRFS_ROOT_REF_COWS, &root->state);
+		set_bit(BTRFS_ROOT_SHAREABLE, &root->state);
 		btrfs_check_and_init_root_item(&root->root_item);
 	}
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index faa585d54eb7..36d8014ce452 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2442,7 +2442,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 	nritems = btrfs_header_nritems(buf);
 	level = btrfs_header_level(buf);
 
-	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state) && level == 0)
+	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state) && level == 0)
 		return 0;
 
 	if (full_backref)
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 719e68ab552c..606c2f3c1a38 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -775,7 +775,7 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 	if (start >= BTRFS_I(inode)->disk_i_size && !replace_extent)
 		modify_tree = 0;
 
-	update_refs = (test_bit(BTRFS_ROOT_REF_COWS, &root->state) ||
+	update_refs = (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
 		       root == fs_info->tree_root);
 	while (1) {
 		recow = 0;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5d567082f95a..a6c26c10ffc5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4107,11 +4107,13 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	BUG_ON(new_size > 0 && min_type != BTRFS_EXTENT_DATA_KEY);
 
 	/*
-	 * for non-free space inodes and ref cows, we want to back off from
-	 * time to time
+	 * for non-free space inodes and non-shareable roots, we want to back
+	 * off from time to time.
+	 * This means all inodes in subvolume roots, reloc roots, and data
+	 * reloc roots.
 	 */
 	if (!btrfs_is_free_space_inode(BTRFS_I(inode)) &&
-	    test_bit(BTRFS_ROOT_REF_COWS, &root->state))
+	    test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 		be_nice = true;
 
 	path = btrfs_alloc_path();
@@ -4128,7 +4130,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	 * not block aligned since we will be keeping the last block of the
 	 * extent just the way it is.
 	 */
-	if (test_bit(BTRFS_ROOT_REF_COWS, &root->state) ||
+	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
 	    root == fs_info->tree_root)
 		btrfs_drop_extent_cache(BTRFS_I(inode), ALIGN(new_size,
 					fs_info->sectorsize),
@@ -4240,7 +4242,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 							 extent_num_bytes);
 				num_dec = (orig_num_bytes -
 					   extent_num_bytes);
-				if (test_bit(BTRFS_ROOT_REF_COWS,
+				if (test_bit(BTRFS_ROOT_SHAREABLE,
 					     &root->state) &&
 				    extent_start != 0)
 					inode_sub_bytes(inode, num_dec);
@@ -4256,7 +4258,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 				num_dec = btrfs_file_extent_num_bytes(leaf, fi);
 				if (extent_start != 0) {
 					found_extent = 1;
-					if (test_bit(BTRFS_ROOT_REF_COWS,
+					if (test_bit(BTRFS_ROOT_SHAREABLE,
 						     &root->state))
 						inode_sub_bytes(inode, num_dec);
 				}
@@ -4292,7 +4294,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 				clear_len = fs_info->sectorsize;
 			}
 
-			if (test_bit(BTRFS_ROOT_REF_COWS, &root->state))
+			if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 				inode_sub_bytes(inode, item_end + 1 - new_size);
 		}
 delete:
@@ -4333,7 +4335,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		should_throttle = false;
 
 		if (found_extent &&
-		    (test_bit(BTRFS_ROOT_REF_COWS, &root->state) ||
+		    (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
 		     root == fs_info->tree_root)) {
 			struct btrfs_ref ref = { 0 };
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 40b729dce91c..709d9446896a 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -750,7 +750,7 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	int ret;
 	bool snapshot_force_cow = false;
 
-	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
+	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 		return -EINVAL;
 
 	if (atomic_read(&root->nr_swapfiles)) {
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f25deca18a5d..437b782c57e6 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -321,7 +321,7 @@ int btrfs_should_ignore_reloc_root(struct btrfs_root *root)
 {
 	struct btrfs_root *reloc_root;
 
-	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
+	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 		return 0;
 
 	/* This root has been merged with its reloc tree, we can ignore it */
@@ -808,7 +808,7 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 
 	reloc_root = btrfs_read_tree_root(fs_info->tree_root, &root_key);
 	BUG_ON(IS_ERR(reloc_root));
-	set_bit(BTRFS_ROOT_REF_COWS, &reloc_root->state);
+	set_bit(BTRFS_ROOT_SHAREABLE, &reloc_root->state);
 	reloc_root->last_trans = trans->transid;
 	return reloc_root;
 }
@@ -2018,7 +2018,7 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 		next = walk_up_backref(next, edges, &index);
 		root = next->root;
 		BUG_ON(!root);
-		BUG_ON(!test_bit(BTRFS_ROOT_REF_COWS, &root->state));
+		BUG_ON(!test_bit(BTRFS_ROOT_SHAREABLE, &root->state));
 
 		if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID) {
 			record_reloc_root_in_trans(trans, root);
@@ -2062,10 +2062,12 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 }
 
 /*
- * select a tree root for relocation. return NULL if the block
- * is reference counted. we should use do_relocation() in this
- * case. return a tree root pointer if the block isn't reference
- * counted. return -ENOENT if the block is root of reloc tree.
+ * Select a tree root for relocation.
+ *
+ * Return NULL if the block is not shareable. we should use do_relocation() in this
+ * case.
+ * Return a tree root pointer if the block is shareable.
+ * Return -ENOENT if the block is root of reloc tree.
  */
 static noinline_for_stack
 struct btrfs_root *select_one_root(struct btrfs_backref_node *node)
@@ -2083,8 +2085,8 @@ struct btrfs_root *select_one_root(struct btrfs_backref_node *node)
 		root = next->root;
 		BUG_ON(!root);
 
-		/* no other choice for non-references counted tree */
-		if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
+		/* no other choice for non-shareable tree */
+		if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 			return root;
 
 		if (root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID)
@@ -2480,7 +2482,7 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 	}
 
 	if (root) {
-		if (test_bit(BTRFS_ROOT_REF_COWS, &root->state)) {
+		if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
 			BUG_ON(node->new_bytenr);
 			BUG_ON(!list_empty(&node->list));
 			btrfs_record_root_in_trans(trans, root);
@@ -3765,7 +3767,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 			goto out;
 		}
 
-		set_bit(BTRFS_ROOT_REF_COWS, &reloc_root->state);
+		set_bit(BTRFS_ROOT_SHAREABLE, &reloc_root->state);
 		list_add(&reloc_root->root_list, &reloc_roots);
 
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 96eb313a5080..a04b5442ac39 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -349,10 +349,10 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 }
 
 /*
- * this does all the record keeping required to make sure that a reference
- * counted root is properly recorded in a given transaction.  This is required
+ * This does all the record keeping required to make sure that a shareable
+ * root is properly recorded in a given transaction.  This is required
  * to make sure the old root from before we joined the transaction is deleted
- * when the transaction commits
+ * when the transaction commits.
  */
 static int record_root_in_trans(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root,
@@ -360,7 +360,7 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
-	if ((test_bit(BTRFS_ROOT_REF_COWS, &root->state) &&
+	if ((test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
 	    root->last_trans < trans->transid) || force) {
 		WARN_ON(root == fs_info->extent_root);
 		WARN_ON(!force && root->commit_root != root->node);
@@ -439,7 +439,7 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
-	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
+	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 		return 0;
 
 	/*
@@ -504,7 +504,7 @@ static inline bool need_reserve_reloc_root(struct btrfs_root *root)
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
 	if (!fs_info->reloc_ctl ||
-	    !test_bit(BTRFS_ROOT_REF_COWS, &root->state) ||
+	    !test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
 	    root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID ||
 	    root->reloc_root)
 		return false;
diff --git a/fs/btrfs/tree-defrag.c b/fs/btrfs/tree-defrag.c
index 5f9e2dd413af..16c3a6d2586d 100644
--- a/fs/btrfs/tree-defrag.c
+++ b/fs/btrfs/tree-defrag.c
@@ -35,7 +35,7 @@ int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
+	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 		goto out;
 
 	path = btrfs_alloc_path();
-- 
2.26.2

