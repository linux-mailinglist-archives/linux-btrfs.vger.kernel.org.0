Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF504BAB2
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 16:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbfFSOEq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 10:04:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:42880 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729325AbfFSOEo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 10:04:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05A13AD33
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 14:04:43 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/4] btrfs-progs: Remove commented code
Date:   Wed, 19 Jun 2019 17:04:38 +0300
Message-Id: <20190619140440.5550-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190619140440.5550-1-nborisov@suse.com>
References: <20190619140440.5550-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This piece of code has been commented since 2009, given the number of
changes that have happened it's unlikely it could be made to work or
is needed at all. Just delete it.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 extent-tree.c | 257 --------------------------------------------------
 1 file changed, 257 deletions(-)

diff --git a/extent-tree.c b/extent-tree.c
index 7693313c50b3..b822eaa28700 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -2539,263 +2539,6 @@ struct extent_buffer *btrfs_alloc_free_block(struct btrfs_trans_handle *trans,
 	return buf;
 }
 
-#if 0
-
-static int noinline drop_leaf_ref(struct btrfs_trans_handle *trans,
-				  struct btrfs_root *root,
-				  struct extent_buffer *leaf)
-{
-	u64 leaf_owner;
-	u64 leaf_generation;
-	struct btrfs_key key;
-	struct btrfs_file_extent_item *fi;
-	int i;
-	int nritems;
-	int ret;
-
-	BUG_ON(!btrfs_is_leaf(leaf));
-	nritems = btrfs_header_nritems(leaf);
-	leaf_owner = btrfs_header_owner(leaf);
-	leaf_generation = btrfs_header_generation(leaf);
-
-	for (i = 0; i < nritems; i++) {
-		u64 disk_bytenr;
-
-		btrfs_item_key_to_cpu(leaf, &key, i);
-		if (btrfs_key_type(&key) != BTRFS_EXTENT_DATA_KEY)
-			continue;
-		fi = btrfs_item_ptr(leaf, i, struct btrfs_file_extent_item);
-		if (btrfs_file_extent_type(leaf, fi) ==
-		    BTRFS_FILE_EXTENT_INLINE)
-			continue;
-		/*
-		 * FIXME make sure to insert a trans record that
-		 * repeats the snapshot del on crash
-		 */
-		disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
-		if (disk_bytenr == 0)
-			continue;
-		ret = btrfs_free_extent(trans, root, disk_bytenr,
-				btrfs_file_extent_disk_num_bytes(leaf, fi),
-				leaf->start, leaf_owner, leaf_generation,
-				key.objectid, 0);
-		BUG_ON(ret);
-	}
-	return 0;
-}
-
-static void noinline reada_walk_down(struct btrfs_root *root,
-				     struct extent_buffer *node,
-				     int slot)
-{
-	u64 bytenr;
-	u64 last = 0;
-	u32 nritems;
-	u32 refs;
-	u32 blocksize;
-	int ret;
-	int i;
-	int level;
-	int skipped = 0;
-
-	nritems = btrfs_header_nritems(node);
-	level = btrfs_header_level(node);
-	if (level)
-		return;
-
-	for (i = slot; i < nritems && skipped < 32; i++) {
-		bytenr = btrfs_node_blockptr(node, i);
-		if (last && ((bytenr > last && bytenr - last > SZ_32K) ||
-			     (last > bytenr && last - bytenr > SZ_32K))) {
-			skipped++;
-			continue;
-		}
-		blocksize = btrfs_level_size(root, level - 1);
-		if (i != slot) {
-			ret = btrfs_lookup_extent_ref(NULL, root, bytenr,
-						      blocksize, &refs);
-			BUG_ON(ret);
-			if (refs != 1) {
-				skipped++;
-				continue;
-			}
-		}
-		mutex_unlock(&root->fs_info->fs_mutex);
-		ret = readahead_tree_block(root, bytenr, blocksize,
-					   btrfs_node_ptr_generation(node, i));
-		last = bytenr + blocksize;
-		cond_resched();
-		mutex_lock(&root->fs_info->fs_mutex);
-		if (ret)
-			break;
-	}
-}
-
-/*
- * helper function for drop_snapshot, this walks down the tree dropping ref
- * counts as it goes.
- */
-static int noinline walk_down_tree(struct btrfs_trans_handle *trans,
-				   struct btrfs_root *root,
-				   struct btrfs_path *path, int *level)
-{
-	u64 root_owner;
-	u64 root_gen;
-	u64 bytenr;
-	u64 ptr_gen;
-	struct extent_buffer *next;
-	struct extent_buffer *cur;
-	struct extent_buffer *parent;
-	u32 blocksize;
-	int ret;
-	u32 refs;
-
-	WARN_ON(*level < 0);
-	WARN_ON(*level >= BTRFS_MAX_LEVEL);
-	ret = btrfs_lookup_extent_ref(trans, root,
-				      path->nodes[*level]->start,
-				      path->nodes[*level]->len, &refs);
-	BUG_ON(ret);
-	if (refs > 1)
-		goto out;
-
-	/*
-	 * walk down to the last node level and free all the leaves
-	 */
-	while(*level >= 0) {
-		WARN_ON(*level < 0);
-		WARN_ON(*level >= BTRFS_MAX_LEVEL);
-		cur = path->nodes[*level];
-
-		if (btrfs_header_level(cur) != *level)
-			WARN_ON(1);
-
-		if (path->slots[*level] >=
-		    btrfs_header_nritems(cur))
-			break;
-		if (*level == 0) {
-			ret = drop_leaf_ref(trans, root, cur);
-			BUG_ON(ret);
-			break;
-		}
-		bytenr = btrfs_node_blockptr(cur, path->slots[*level]);
-		ptr_gen = btrfs_node_ptr_generation(cur, path->slots[*level]);
-		blocksize = btrfs_level_size(root, *level - 1);
-		ret = btrfs_lookup_extent_ref(trans, root, bytenr, blocksize,
-					      &refs);
-		BUG_ON(ret);
-		if (refs != 1) {
-			parent = path->nodes[*level];
-			root_owner = btrfs_header_owner(parent);
-			root_gen = btrfs_header_generation(parent);
-			path->slots[*level]++;
-			ret = btrfs_free_extent(trans, root, bytenr, blocksize,
-						parent->start, root_owner,
-						root_gen, *level - 1, 0);
-			BUG_ON(ret);
-			continue;
-		}
-		next = btrfs_find_tree_block(root, bytenr, blocksize);
-		if (!next || !btrfs_buffer_uptodate(next, ptr_gen)) {
-			free_extent_buffer(next);
-			reada_walk_down(root, cur, path->slots[*level]);
-			mutex_unlock(&root->fs_info->fs_mutex);
-			next = read_tree_block(root, bytenr, blocksize,
-					       ptr_gen);
-			mutex_lock(&root->fs_info->fs_mutex);
-			if (!extent_buffer_uptodate(next)) {
-				if (IS_ERR(next))
-					ret = PTR_ERR(next);
-				else
-					ret = -EIO;
-				break;
-			}
-		}
-		WARN_ON(*level <= 0);
-		if (path->nodes[*level-1])
-			free_extent_buffer(path->nodes[*level-1]);
-		path->nodes[*level-1] = next;
-		*level = btrfs_header_level(next);
-		path->slots[*level] = 0;
-	}
-out:
-	WARN_ON(*level < 0);
-	WARN_ON(*level >= BTRFS_MAX_LEVEL);
-
-	if (path->nodes[*level] == root->node) {
-		root_owner = root->root_key.objectid;
-		parent = path->nodes[*level];
-	} else {
-		parent = path->nodes[*level + 1];
-		root_owner = btrfs_header_owner(parent);
-	}
-
-	root_gen = btrfs_header_generation(parent);
-	ret = btrfs_free_extent(trans, root, path->nodes[*level]->start,
-				path->nodes[*level]->len, parent->start,
-				root_owner, root_gen, *level, 0);
-	free_extent_buffer(path->nodes[*level]);
-	path->nodes[*level] = NULL;
-	*level += 1;
-	BUG_ON(ret);
-	return 0;
-}
-
-/*
- * helper for dropping snapshots.  This walks back up the tree in the path
- * to find the first node higher up where we haven't yet gone through
- * all the slots
- */
-static int noinline walk_up_tree(struct btrfs_trans_handle *trans,
-				 struct btrfs_root *root,
-				 struct btrfs_path *path, int *level)
-{
-	u64 root_owner;
-	u64 root_gen;
-	struct btrfs_root_item *root_item = &root->root_item;
-	int i;
-	int slot;
-	int ret;
-
-	for(i = *level; i < BTRFS_MAX_LEVEL - 1 && path->nodes[i]; i++) {
-		slot = path->slots[i];
-		if (slot < btrfs_header_nritems(path->nodes[i]) - 1) {
-			struct extent_buffer *node;
-			struct btrfs_disk_key disk_key;
-			node = path->nodes[i];
-			path->slots[i]++;
-			*level = i;
-			WARN_ON(*level == 0);
-			btrfs_node_key(node, &disk_key, path->slots[i]);
-			memcpy(&root_item->drop_progress,
-			       &disk_key, sizeof(disk_key));
-			root_item->drop_level = i;
-			return 0;
-		} else {
-			struct extent_buffer *parent;
-			if (path->nodes[*level] == root->node)
-				parent = path->nodes[*level];
-			else
-				parent = path->nodes[*level + 1];
-
-			root_owner = btrfs_header_owner(parent);
-			root_gen = btrfs_header_generation(parent);
-			ret = btrfs_free_extent(trans, root,
-						path->nodes[*level]->start,
-						path->nodes[*level]->len,
-						parent->start, root_owner,
-						root_gen, *level, 0);
-			BUG_ON(ret);
-			free_extent_buffer(path->nodes[*level]);
-			path->nodes[*level] = NULL;
-			*level = i + 1;
-		}
-	}
-	return 1;
-}
-
-#endif
-
 int btrfs_free_block_groups(struct btrfs_fs_info *info)
 {
 	struct btrfs_space_info *sinfo;
-- 
2.17.1

