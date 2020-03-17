Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4452F187AFB
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Mar 2020 09:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgCQIM4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Mar 2020 04:12:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:42966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgCQIMz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Mar 2020 04:12:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 90B32AE46
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Mar 2020 08:12:53 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 31/39] btrfs: relocation: Use btrfs_find_all_leaves() to locate parent tree leaves of a data extent
Date:   Tue, 17 Mar 2020 16:11:17 +0800
Message-Id: <20200317081125.36289-32-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317081125.36289-1-wqu@suse.com>
References: <20200317081125.36289-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In relocation, we need to locate all parent tree leaves referring one
data extent, thus we have a complex mechanism to iterate throught extent
tree and subvolume trees to locate related leaves.

However this is already done in backref.c, we have
btrfs_find_all_leaves(), which can return a ulist containing all leaves
referring to that data extent.

Use btrfs_find_all_leaves() to replace find_data_references().

There is a special handling for v1 space cache data extents, where we
need to delete the v1 space cache data extents, to avoid those data
extents to hang the data relocation.

In this patch, the special handling is done by re-iterating the root
tree leaf.
Although it's a little less efficient than the old handling, considering
we can reuse a lot of code, it should be acceptable.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.c    |   8 +-
 fs/btrfs/backref.h    |   4 +
 fs/btrfs/relocation.c | 312 +++++++-----------------------------------
 3 files changed, 61 insertions(+), 263 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 435982da3991..79ccada3fce6 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1410,10 +1410,10 @@ static void free_leaf_list(struct ulist *blocks)
  *
  * returns 0 on success, <0 on error
  */
-static int btrfs_find_all_leafs(struct btrfs_trans_handle *trans,
-				struct btrfs_fs_info *fs_info, u64 bytenr,
-				u64 time_seq, struct ulist **leafs,
-				const u64 *extent_item_pos, bool ignore_offset)
+int btrfs_find_all_leafs(struct btrfs_trans_handle *trans,
+			 struct btrfs_fs_info *fs_info, u64 bytenr,
+			 u64 time_seq, struct ulist **leafs,
+			 const u64 *extent_item_pos, bool ignore_offset)
 {
 	int ret;
 
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 72b959377a14..06ecb96c183a 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -41,6 +41,10 @@ int iterate_inodes_from_logical(u64 logical, struct btrfs_fs_info *fs_info,
 
 int paths_from_inode(u64 inum, struct inode_fs_paths *ipath);
 
+int btrfs_find_all_leafs(struct btrfs_trans_handle *trans,
+			 struct btrfs_fs_info *fs_info, u64 bytenr,
+			 u64 time_seq, struct ulist **leafs,
+			 const u64 *extent_item_pos, bool ignore_offset);
 int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
 			 struct btrfs_fs_info *fs_info, u64 bytenr,
 			 u64 time_seq, struct ulist **roots, bool ignore_offset);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 466f90f7fb26..2d1866234164 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2887,31 +2887,6 @@ static int __add_tree_block(struct reloc_control *rc,
 	return ret;
 }
 
-/*
- * helper to check if the block use full backrefs for pointers in it
- */
-static int block_use_full_backref(struct reloc_control *rc,
-				  struct extent_buffer *eb)
-{
-	u64 flags;
-	int ret;
-
-	if (btrfs_header_flag(eb, BTRFS_HEADER_FLAG_RELOC) ||
-	    btrfs_header_backref_rev(eb) < BTRFS_MIXED_BACKREF_REV)
-		return 1;
-
-	ret = btrfs_lookup_extent_info(NULL, rc->extent_root->fs_info,
-				       eb->start, btrfs_header_level(eb), 1,
-				       NULL, &flags);
-	BUG_ON(ret);
-
-	if (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF)
-		ret = 1;
-	else
-		ret = 0;
-	return ret;
-}
-
 static int delete_block_group_cache(struct btrfs_fs_info *fs_info,
 				    struct btrfs_block_group *block_group,
 				    struct inode *inode,
@@ -2955,174 +2930,41 @@ static int delete_block_group_cache(struct btrfs_fs_info *fs_info,
 }
 
 /*
- * helper to add tree blocks for backref of type BTRFS_EXTENT_DATA_REF_KEY
- * this function scans fs tree to find blocks reference the data extent
+ * Helper function to locate the free space cache EXTENT_DATA in root tree leaf
+ * and delete the cache for specified free space cache inode.
  */
-static int find_data_references(struct reloc_control *rc,
-				struct btrfs_key *extent_key,
-				struct extent_buffer *leaf,
-				struct btrfs_extent_data_ref *ref,
-				struct rb_root *blocks)
+static int delete_v1_space_cache(struct btrfs_fs_info *fs_info,
+				 struct extent_buffer *leaf,
+				 struct btrfs_block_group *block_group,
+				 u64 data_bytenr)
 {
-	struct btrfs_fs_info *fs_info = rc->extent_root->fs_info;
-	struct btrfs_path *path;
-	struct tree_block *block;
-	struct btrfs_root *root;
-	struct btrfs_file_extent_item *fi;
-	struct rb_node *rb_node;
+	u64 space_cache_ino;
+	struct btrfs_file_extent_item *ei;
 	struct btrfs_key key;
-	u64 ref_root;
-	u64 ref_objectid;
-	u64 ref_offset;
-	u32 ref_count;
-	u32 nritems;
-	int err = 0;
-	int added = 0;
-	int counted;
+	bool found = false;
+	int i;
 	int ret;
 
-	ref_root = btrfs_extent_data_ref_root(leaf, ref);
-	ref_objectid = btrfs_extent_data_ref_objectid(leaf, ref);
-	ref_offset = btrfs_extent_data_ref_offset(leaf, ref);
-	ref_count = btrfs_extent_data_ref_count(leaf, ref);
-
-	/*
-	 * This is an extent belonging to the free space cache, lets just delete
-	 * it and redo the search.
-	 */
-	if (ref_root == BTRFS_ROOT_TREE_OBJECTID) {
-		ret = delete_block_group_cache(fs_info, rc->block_group,
-					       NULL, ref_objectid);
-		if (ret != -ENOENT)
-			return ret;
-		ret = 0;
-	}
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-	path->reada = READA_FORWARD;
-
-	root = read_fs_root(fs_info, ref_root);
-	if (IS_ERR(root)) {
-		err = PTR_ERR(root);
-		goto out_free;
-	}
-
-	key.objectid = ref_objectid;
-	key.type = BTRFS_EXTENT_DATA_KEY;
-	if (ref_offset > ((u64)-1 << 32))
-		key.offset = 0;
-	else
-		key.offset = ref_offset;
-
-	path->search_commit_root = 1;
-	path->skip_locking = 1;
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0) {
-		err = ret;
-		goto out;
-	}
-
-	leaf = path->nodes[0];
-	nritems = btrfs_header_nritems(leaf);
-	/*
-	 * the references in tree blocks that use full backrefs
-	 * are not counted in
-	 */
-	if (block_use_full_backref(rc, leaf))
-		counted = 0;
-	else
-		counted = 1;
-	rb_node = simple_search(blocks, leaf->start);
-	if (rb_node) {
-		if (counted)
-			added = 1;
-		else
-			path->slots[0] = nritems;
-	}
-
-	while (ref_count > 0) {
-		while (path->slots[0] >= nritems) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0) {
-				err = ret;
-				goto out;
-			}
-			if (WARN_ON(ret > 0))
-				goto out;
-
-			leaf = path->nodes[0];
-			nritems = btrfs_header_nritems(leaf);
-			added = 0;
-
-			if (block_use_full_backref(rc, leaf))
-				counted = 0;
-			else
-				counted = 1;
-			rb_node = simple_search(blocks, leaf->start);
-			if (rb_node) {
-				if (counted)
-					added = 1;
-				else
-					path->slots[0] = nritems;
-			}
-		}
+	if (btrfs_header_owner(leaf) != BTRFS_ROOT_TREE_OBJECTID)
+		return 0;
 
-		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
-		if (WARN_ON(key.objectid != ref_objectid ||
-		    key.type != BTRFS_EXTENT_DATA_KEY))
+	for (i = 0; i < btrfs_header_nritems(leaf); i++) {
+		btrfs_item_key_to_cpu(leaf, &key, i);
+		if (key.type != BTRFS_EXTENT_DATA_KEY)
+			continue;
+		ei = btrfs_item_ptr(leaf, i, struct btrfs_file_extent_item);
+		if (btrfs_file_extent_type(leaf, ei) == BTRFS_FILE_EXTENT_REG &&
+		    btrfs_file_extent_disk_bytenr(leaf, ei) == data_bytenr) {
+			found = true;
+			space_cache_ino = key.objectid;
 			break;
-
-		fi = btrfs_item_ptr(leaf, path->slots[0],
-				    struct btrfs_file_extent_item);
-
-		if (btrfs_file_extent_type(leaf, fi) ==
-		    BTRFS_FILE_EXTENT_INLINE)
-			goto next;
-
-		if (btrfs_file_extent_disk_bytenr(leaf, fi) !=
-		    extent_key->objectid)
-			goto next;
-
-		key.offset -= btrfs_file_extent_offset(leaf, fi);
-		if (key.offset != ref_offset)
-			goto next;
-
-		if (counted)
-			ref_count--;
-		if (added)
-			goto next;
-
-		if (!tree_block_processed(leaf->start, rc)) {
-			block = kmalloc(sizeof(*block), GFP_NOFS);
-			if (!block) {
-				err = -ENOMEM;
-				break;
-			}
-			block->bytenr = leaf->start;
-			btrfs_item_key_to_cpu(leaf, &block->key, 0);
-			block->level = 0;
-			block->key_ready = 1;
-			rb_node = simple_insert(blocks, block->bytenr,
-						&block->rb_node);
-			if (rb_node)
-				backref_cache_panic(fs_info, block->bytenr,
-						    -EEXIST);
 		}
-		if (counted)
-			added = 1;
-		else
-			path->slots[0] = nritems;
-next:
-		path->slots[0]++;
-
 	}
-out:
-	btrfs_put_root(root);
-out_free:
-	btrfs_free_path(path);
-	return err;
+	if (!found)
+		return -ENOENT;
+	ret = delete_block_group_cache(fs_info, block_group, NULL,
+					space_cache_ino);
+	return ret;
 }
 
 /*
@@ -3134,91 +2976,43 @@ int add_data_references(struct reloc_control *rc,
 			struct btrfs_path *path,
 			struct rb_root *blocks)
 {
-	struct btrfs_key key;
-	struct extent_buffer *eb;
-	struct btrfs_extent_data_ref *dref;
-	struct btrfs_extent_inline_ref *iref;
-	unsigned long ptr;
-	unsigned long end;
-	u32 blocksize = rc->extent_root->fs_info->nodesize;
+	struct btrfs_fs_info *fs_info = rc->extent_root->fs_info;
+	struct ulist *leaves = NULL;
+	struct ulist_iterator leaf_uiter;
+	struct ulist_node *ref_node = NULL;
+	u32 blocksize = fs_info->nodesize;
 	int ret = 0;
-	int err = 0;
 
-	eb = path->nodes[0];
-	ptr = btrfs_item_ptr_offset(eb, path->slots[0]);
-	end = ptr + btrfs_item_size_nr(eb, path->slots[0]);
-	ptr += sizeof(struct btrfs_extent_item);
-
-	while (ptr < end) {
-		iref = (struct btrfs_extent_inline_ref *)ptr;
-		key.type = btrfs_get_extent_inline_ref_type(eb, iref,
-							BTRFS_REF_TYPE_DATA);
-		if (key.type == BTRFS_SHARED_DATA_REF_KEY) {
-			key.offset = btrfs_extent_inline_ref_offset(eb, iref);
-			ret = __add_tree_block(rc, key.offset, blocksize,
-					       blocks);
-		} else if (key.type == BTRFS_EXTENT_DATA_REF_KEY) {
-			dref = (struct btrfs_extent_data_ref *)(&iref->offset);
-			ret = find_data_references(rc, extent_key,
-						   eb, dref, blocks);
-		} else {
-			ret = -EUCLEAN;
-			btrfs_err(rc->extent_root->fs_info,
-		     "extent %llu slot %d has an invalid inline ref type",
-			     eb->start, path->slots[0]);
-		}
-		if (ret) {
-			err = ret;
-			goto out;
-		}
-		ptr += btrfs_extent_inline_ref_size(key.type);
-	}
-	WARN_ON(ptr > end);
+	btrfs_release_path(path);
+	ret = btrfs_find_all_leafs(NULL, fs_info, extent_key->objectid,
+				   0, &leaves, NULL, true);
+	if (ret < 0)
+		return ret;
 
-	while (1) {
-		cond_resched();
-		eb = path->nodes[0];
-		if (path->slots[0] >= btrfs_header_nritems(eb)) {
-			ret = btrfs_next_leaf(rc->extent_root, path);
-			if (ret < 0) {
-				err = ret;
-				break;
-			}
-			if (ret > 0)
-				break;
-			eb = path->nodes[0];
+	ULIST_ITER_INIT(&leaf_uiter);
+	while ((ref_node = ulist_next(leaves, &leaf_uiter))) {
+		struct extent_buffer *eb;
+
+		eb = read_tree_block(fs_info, ref_node->val, 0, 0, NULL);
+		if (IS_ERR(eb)) {
+			ret = PTR_ERR(eb);
+			break;
 		}
 
-		btrfs_item_key_to_cpu(eb, &key, path->slots[0]);
-		if (key.objectid != extent_key->objectid)
+		ret = delete_v1_space_cache(fs_info, eb, rc->block_group,
+					    extent_key->objectid);
+		free_extent_buffer(eb);
+		if (ret < 0)
 			break;
 
-		if (key.type == BTRFS_SHARED_DATA_REF_KEY) {
-			ret = __add_tree_block(rc, key.offset, blocksize,
-					       blocks);
-		} else if (key.type == BTRFS_EXTENT_DATA_REF_KEY) {
-			dref = btrfs_item_ptr(eb, path->slots[0],
-					      struct btrfs_extent_data_ref);
-			ret = find_data_references(rc, extent_key,
-						   eb, dref, blocks);
-		} else if (unlikely(key.type == BTRFS_EXTENT_REF_V0_KEY)) {
-			btrfs_print_v0_err(eb->fs_info);
-			btrfs_handle_fs_error(eb->fs_info, -EINVAL, NULL);
-			ret = -EINVAL;
-		} else {
-			ret = 0;
-		}
-		if (ret) {
-			err = ret;
+		ret = __add_tree_block(rc, ref_node->val, blocksize, blocks);
+		if (ret < 0)
 			break;
-		}
-		path->slots[0]++;
 	}
-out:
-	btrfs_release_path(path);
-	if (err)
+	if (ret < 0)
 		free_block_list(blocks);
-	return err;
+	ulist_free(leaves);
+	return ret;
 }
 
 /*
-- 
2.25.1

