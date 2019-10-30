Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDEC6E974B
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 08:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfJ3Hkq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 03:40:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:51102 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725953AbfJ3Hkq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 03:40:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 94382B253
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2019 07:40:43 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: Replace btrfs_block_group_cache::item with dedicated members
Date:   Wed, 30 Oct 2019 15:40:39 +0800
Message-Id: <20191030074039.112707-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We access btrfs_block_group_cache::item mostly for @used and @flags.

@flags is already a dedicated member in btrfs_block_group_cache, only
@used doesn't have a dedicated member.

This patch will remove btrfs_block_group_cache::item and add
btrfs_block_group_cache::used.

It's the btrfs-progs equivalent of the following kernel patches:
btrfs: move block_group_item::used to block group
btrfs: move block_group_item::flags to block group
btrfs: remove embedded block_group_cache::item

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c                |  8 +++--
 cmds/rescue-chunk-recover.c |  2 +-
 ctree.h                     |  2 +-
 extent-tree.c               | 63 ++++++++++++++++++++-----------------
 free-space-cache.c          |  2 +-
 image/main.c                |  1 -
 6 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/check/main.c b/check/main.c
index 034b2bd7be89..a0e5ac47c152 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9091,15 +9091,19 @@ again:
 	 * pinned all of it above.
 	 */
 	while (1) {
+		struct btrfs_block_group_item bgi;
 		struct btrfs_block_group_cache *cache;
 
 		cache = btrfs_lookup_first_block_group(fs_info, start);
 		if (!cache)
 			break;
 		start = cache->key.objectid + cache->key.offset;
+		btrfs_set_block_group_used(&bgi, cache->used);
+		btrfs_set_block_group_chunk_objectid(&bgi,
+					BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+		btrfs_set_block_group_flags(&bgi, cache->flags);
 		ret = btrfs_insert_item(trans, fs_info->extent_root,
-					&cache->key, &cache->item,
-					sizeof(cache->item));
+					&cache->key, &bgi, sizeof(bgi));
 		if (ret) {
 			fprintf(stderr, "Error adding block group\n");
 			return ret;
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index bf35693ddbfa..22d7a5959531 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1104,7 +1104,7 @@ static int block_group_free_all_extent(struct btrfs_root *root,
 			BLOCK_GROUP_DIRTY);
 	set_extent_dirty(&info->free_space_cache, start, end);
 
-	btrfs_set_block_group_used(&cache->item, 0);
+	cache->used = 0;
 
 	return 0;
 }
diff --git a/ctree.h b/ctree.h
index 83e41fb885f7..ec57f113839f 100644
--- a/ctree.h
+++ b/ctree.h
@@ -1090,9 +1090,9 @@ struct btrfs_space_info {
 struct btrfs_block_group_cache {
 	struct cache_extent cache;
 	struct btrfs_key key;
-	struct btrfs_block_group_item item;
 	struct btrfs_space_info *space_info;
 	struct btrfs_free_space_ctl *free_space_ctl;
+	u64 used;
 	u64 bytes_super;
 	u64 pinned;
 	u64 flags;
diff --git a/extent-tree.c b/extent-tree.c
index 52b963265a07..d67e4098351f 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -338,7 +338,7 @@ btrfs_find_block_group(struct btrfs_root *root, struct btrfs_block_group_cache
 		struct btrfs_block_group_cache *shint;
 		shint = btrfs_lookup_block_group(info, search_start);
 		if (shint && !shint->ro && block_group_bits(shint, data)) {
-			used = btrfs_block_group_used(&shint->item);
+			used = shint->used;
 			if (used + shint->pinned <
 			    div_factor(shint->key.offset, factor)) {
 				return shint;
@@ -346,7 +346,7 @@ btrfs_find_block_group(struct btrfs_root *root, struct btrfs_block_group_cache
 		}
 	}
 	if (hint && !hint->ro && block_group_bits(hint, data)) {
-		used = btrfs_block_group_used(&hint->item);
+		used = hint->used;
 		if (used + hint->pinned <
 		    div_factor(hint->key.offset, factor)) {
 			return hint;
@@ -374,7 +374,7 @@ again:
 
 		cache = (struct btrfs_block_group_cache *)(unsigned long)ptr;
 		last = cache->key.objectid + cache->key.offset;
-		used = btrfs_block_group_used(&cache->item);
+		used = cache->used;
 
 		if (!cache->ro && block_group_bits(cache, data)) {
 			if (full_search)
@@ -1531,6 +1531,7 @@ static int write_one_cache_group(struct btrfs_trans_handle *trans,
 	int ret;
 	struct btrfs_root *extent_root = trans->fs_info->extent_root;
 	unsigned long bi;
+	struct btrfs_block_group_item bgi;
 	struct extent_buffer *leaf;
 
 	ret = btrfs_search_slot(trans, extent_root, &cache->key, path, 0, 1);
@@ -1540,7 +1541,10 @@ static int write_one_cache_group(struct btrfs_trans_handle *trans,
 
 	leaf = path->nodes[0];
 	bi = btrfs_item_ptr_offset(leaf, path->slots[0]);
-	write_extent_buffer(leaf, &cache->item, bi, sizeof(cache->item));
+	btrfs_set_block_group_used(&bgi, cache->used);
+	btrfs_set_block_group_flags(&bgi, cache->flags);
+	btrfs_set_block_group_chunk_objectid(&bgi, BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_release_path(path);
 fail:
@@ -1774,7 +1778,7 @@ static int update_block_group(struct btrfs_fs_info *info, u64 bytenr,
 		set_extent_bits(&info->block_group_cache, start, end,
 				BLOCK_GROUP_DIRTY);
 
-		old_val = btrfs_block_group_used(&cache->item);
+		old_val = cache->used;
 		num_bytes = min(total, cache->key.offset - byte_in_group);
 
 		if (alloc) {
@@ -1788,7 +1792,7 @@ static int update_block_group(struct btrfs_fs_info *info, u64 bytenr,
 						bytenr, bytenr + num_bytes - 1);
 			}
 		}
-		btrfs_set_block_group_used(&cache->item, old_val);
+		cache->used = old_val;
 		total -= num_bytes;
 		bytenr += num_bytes;
 	}
@@ -2661,6 +2665,7 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 	struct extent_buffer *leaf = path->nodes[0];
 	struct btrfs_space_info *space_info;
 	struct btrfs_block_group_cache *cache;
+	struct btrfs_block_group_item bgi;
 	struct btrfs_key key;
 	int slot = path->slots[0];
 	int bit = 0;
@@ -2679,13 +2684,13 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 	cache = kzalloc(sizeof(*cache), GFP_NOFS);
 	if (!cache)
 		return -ENOMEM;
-	read_extent_buffer(leaf, &cache->item,
-			   btrfs_item_ptr_offset(leaf, slot),
-			   sizeof(cache->item));
+	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
+			   sizeof(bgi));
 	memcpy(&cache->key, &key, sizeof(key));
 	cache->cached = 0;
 	cache->pinned = 0;
-	cache->flags = btrfs_block_group_flags(&cache->item);
+	cache->flags = btrfs_block_group_flags(&bgi);
+	cache->used = btrfs_block_group_used(&bgi);
 	if (cache->flags & BTRFS_BLOCK_GROUP_DATA) {
 		bit = BLOCK_GROUP_DATA;
 	} else if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
@@ -2699,8 +2704,7 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 	exclude_super_stripes(fs_info, cache);
 
 	ret = update_space_info(fs_info, cache->flags, cache->key.offset,
-				btrfs_block_group_used(&cache->item),
-				&space_info);
+				cache->used, &space_info);
 	if (ret < 0) {
 		free(cache);
 		return ret;
@@ -2773,11 +2777,8 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 	cache->key.offset = size;
 
 	cache->key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
-	btrfs_set_block_group_used(&cache->item, bytes_used);
-	btrfs_set_block_group_chunk_objectid(&cache->item,
-					     BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+	cache->used = bytes_used;
 	cache->flags = type;
-	btrfs_set_block_group_flags(&cache->item, type);
 
 	exclude_super_stripes(fs_info, cache);
 	ret = update_space_info(fs_info, cache->flags, size, bytes_used,
@@ -2805,11 +2806,16 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans,
 	int ret;
 	struct btrfs_root *extent_root = fs_info->extent_root;
 	struct btrfs_block_group_cache *cache;
+	struct btrfs_block_group_item bgi;
 
 	cache = btrfs_add_block_group(fs_info, bytes_used, type, chunk_offset,
 				      size);
-	ret = btrfs_insert_item(trans, extent_root, &cache->key, &cache->item,
-				sizeof(cache->item));
+	btrfs_set_block_group_used(&bgi, cache->used);
+	btrfs_set_block_group_flags(&bgi, cache->flags);
+	btrfs_set_block_group_chunk_objectid(&bgi,
+			BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+	ret = btrfs_insert_item(trans, extent_root, &cache->key, &bgi,
+				sizeof(bgi));
 	BUG_ON(ret);
 
 	return 0;
@@ -2832,7 +2838,6 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 	u64 group_align;
 	u64 total_data = 0;
 	u64 total_metadata = 0;
-	u64 chunk_objectid;
 	int ret;
 	int bit;
 	struct btrfs_root *extent_root = fs_info->extent_root;
@@ -2840,7 +2845,6 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 	struct extent_io_tree *block_group_cache;
 
 	block_group_cache = &fs_info->block_group_cache;
-	chunk_objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
 	total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
 	group_align = 64 * fs_info->sectorsize;
 
@@ -2877,12 +2881,7 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 		cache->key.objectid = cur_start;
 		cache->key.offset = group_size;
 		cache->key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
-
-		btrfs_set_block_group_used(&cache->item, 0);
-		btrfs_set_block_group_chunk_objectid(&cache->item,
-						     chunk_objectid);
-		btrfs_set_block_group_flags(&cache->item, group_type);
-
+		cache->used = 0;
 		cache->flags = group_type;
 
 		ret = update_space_info(fs_info, group_type, group_size,
@@ -2900,11 +2899,17 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 	/* then insert all the items */
 	cur_start = 0;
 	while(cur_start < total_bytes) {
+		struct btrfs_block_group_item bgi;
+
 		cache = btrfs_lookup_block_group(fs_info, cur_start);
 		BUG_ON(!cache);
 
-		ret = btrfs_insert_item(trans, extent_root, &cache->key, &cache->item,
-					sizeof(cache->item));
+		btrfs_set_block_group_used(&bgi, cache->used);
+		btrfs_set_block_group_flags(&bgi, cache->flags);
+		btrfs_set_block_group_chunk_objectid(&bgi,
+				BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+		ret = btrfs_insert_item(trans, extent_root, &cache->key, &bgi,
+					sizeof(bgi));
 		BUG_ON(ret);
 
 		cur_start = cache->key.objectid + cache->key.offset;
@@ -3297,7 +3302,7 @@ int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans)
 		if (!cache)
 			break;
 		start = cache->key.objectid + cache->key.offset;
-		btrfs_set_block_group_used(&cache->item, 0);
+		cache->used = 0;
 		cache->space_info->bytes_used = 0;
 		set_extent_bits(&root->fs_info->block_group_cache,
 				cache->key.objectid,
diff --git a/free-space-cache.c b/free-space-cache.c
index 6e7d7e1ef561..b95cabadcbd8 100644
--- a/free-space-cache.c
+++ b/free-space-cache.c
@@ -436,7 +436,7 @@ int load_free_space_cache(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	struct btrfs_path *path;
-	u64 used = btrfs_block_group_used(&block_group->item);
+	u64 used = block_group->used;
 	int ret = 0;
 	u64 bg_free;
 	s64 diff;
diff --git a/image/main.c b/image/main.c
index c72da1d36101..bddb49720f0a 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2364,7 +2364,6 @@ static void fixup_block_groups(struct btrfs_fs_info *fs_info)
 
 		/* Update the block group item and mark the bg dirty */
 		bg->flags = map->type;
-		btrfs_set_block_group_flags(&bg->item, bg->flags);
 		set_extent_bits(&fs_info->block_group_cache, ce->start,
 				ce->start + ce->size - 1, BLOCK_GROUP_DIRTY);
 
-- 
2.23.0

