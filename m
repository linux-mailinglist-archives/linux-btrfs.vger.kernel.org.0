Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F671C0E5E
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 08:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgEAGwe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 May 2020 02:52:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:44316 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbgEAGwc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 May 2020 02:52:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 08D8EAD11
        for <linux-btrfs@vger.kernel.org>; Fri,  1 May 2020 06:52:28 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/4] btrfs-progs: Kill block_group_cache::key
Date:   Fri,  1 May 2020 14:52:17 +0800
Message-Id: <20200501065219.484868-3-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501065219.484868-1-wqu@suse.com>
References: <20200501065219.484868-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This would sync the code between kernel and btrfs-progs, and save at
least 1 byte for each btrfs_block_group_cache.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c                    |  29 +++----
 check/mode-common.c             |   2 +-
 check/mode-lowmem.c             |   4 +-
 cmds/rescue-chunk-recover.c     |   4 +-
 convert/main.c                  |   6 +-
 convert/source-fs.c             |   2 +-
 ctree.h                         |   3 +-
 extent-tree.c                   | 133 ++++++++++++++++----------------
 free-space-cache.c              |  22 +++---
 kernel-shared/free-space-tree.c |  77 +++++++++---------
 mkfs/main.c                     |  10 +--
 volumes.h                       |   2 +-
 12 files changed, 150 insertions(+), 144 deletions(-)

diff --git a/check/main.c b/check/main.c
index 84c855eb0f65..2610220e5b6d 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5455,7 +5455,7 @@ static int check_cache_range(struct btrfs_root *root,
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
 		bytenr = btrfs_sb_offset(i);
 		ret = btrfs_rmap_block(root->fs_info,
-				       cache->key.objectid, bytenr,
+				       cache->start, bytenr,
 				       &logical, &nr, &stripe_len);
 		if (ret)
 			return ret;
@@ -5547,7 +5547,7 @@ static int verify_space_cache(struct btrfs_root *root,
 
 	root = root->fs_info->extent_root;
 
-	last = max_t(u64, cache->key.objectid, BTRFS_SUPER_INFO_OFFSET);
+	last = max_t(u64, cache->start, BTRFS_SUPER_INFO_OFFSET);
 
 	btrfs_init_path(&path);
 	key.objectid = last;
@@ -5569,7 +5569,7 @@ static int verify_space_cache(struct btrfs_root *root,
 		}
 		leaf = path.nodes[0];
 		btrfs_item_key_to_cpu(leaf, &key, path.slots[0]);
-		if (key.objectid >= cache->key.offset + cache->key.objectid)
+		if (key.objectid >= cache->start + cache->length)
 			break;
 		if (key.type != BTRFS_EXTENT_ITEM_KEY &&
 		    key.type != BTRFS_METADATA_ITEM_KEY) {
@@ -5597,10 +5597,9 @@ static int verify_space_cache(struct btrfs_root *root,
 		path.slots[0]++;
 	}
 
-	if (last < cache->key.objectid + cache->key.offset)
+	if (last < cache->start + cache->length)
 		ret = check_cache_range(root, cache, last,
-					cache->key.objectid +
-					cache->key.offset - last);
+					cache->start + cache->length - last);
 
 out:
 	btrfs_release_path(&path);
@@ -5628,7 +5627,7 @@ static int check_space_cache(struct btrfs_root *root)
 		if (!cache)
 			break;
 
-		start = cache->key.objectid + cache->key.offset;
+		start = cache->start + cache->length;
 		if (!cache->free_space_ctl) {
 			if (btrfs_init_free_space_ctl(cache,
 						root->fs_info->sectorsize)) {
@@ -5669,7 +5668,7 @@ static int check_space_cache(struct btrfs_root *root)
 		ret = verify_space_cache(root, cache);
 		if (ret) {
 			fprintf(stderr, "cache appears valid but isn't %llu\n",
-				cache->key.objectid);
+				cache->start);
 			error++;
 		}
 	}
@@ -8970,7 +8969,7 @@ static int reset_block_groups(struct btrfs_fs_info *fs_info)
 		if (!cache)
 			break;
 		cache->cached = 1;
-		start = cache->key.objectid + cache->key.offset;
+		start = cache->start + cache->length;
 	}
 
 	btrfs_release_path(&path);
@@ -9156,17 +9155,21 @@ again:
 	while (1) {
 		struct btrfs_block_group_item bgi;
 		struct btrfs_block_group_cache *cache;
+		struct btrfs_key key;
 
 		cache = btrfs_lookup_first_block_group(fs_info, start);
 		if (!cache)
 			break;
-		start = cache->key.objectid + cache->key.offset;
+		start = cache->start + cache->length;
 		btrfs_set_stack_block_group_used(&bgi, cache->used);
 		btrfs_set_stack_block_group_chunk_objectid(&bgi,
 					BTRFS_FIRST_CHUNK_TREE_OBJECTID);
 		btrfs_set_stack_block_group_flags(&bgi, cache->flags);
-		ret = btrfs_insert_item(trans, fs_info->extent_root,
-					&cache->key, &bgi, sizeof(bgi));
+		key.objectid = cache->start;
+		key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+		key.offset = cache->length;
+		ret = btrfs_insert_item(trans, fs_info->extent_root, &key,
+					&bgi, sizeof(bgi));
 		if (ret) {
 			fprintf(stderr, "Error adding block group\n");
 			return ret;
@@ -9815,7 +9818,7 @@ static int clear_free_space_cache(struct btrfs_fs_info *fs_info)
 		ret = btrfs_clear_free_space_cache(fs_info, bg_cache);
 		if (ret < 0)
 			return ret;
-		current = bg_cache->key.objectid + bg_cache->key.offset;
+		current = bg_cache->start + bg_cache->length;
 	}
 
 	/* Don't forget to set cache_generation to -1 */
diff --git a/check/mode-common.c b/check/mode-common.c
index 8fe1ea8eaeb4..73b2622dd674 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -601,7 +601,7 @@ void reset_cached_block_groups(struct btrfs_fs_info *fs_info)
 			break;
 		if (cache->cached)
 			cache->cached = 0;
-		start = cache->key.objectid + cache->key.offset;
+		start = cache->start + cache->length;
 	}
 }
 
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 91be09614c51..b47963a46d80 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -242,8 +242,8 @@ static int modify_block_group_cache(struct btrfs_fs_info *fs_info,
 		    struct btrfs_block_group_cache *block_group, int cache)
 {
 	struct extent_io_tree *free_space_cache = &fs_info->free_space_cache;
-	u64 start = block_group->key.objectid;
-	u64 end = start + block_group->key.offset;
+	u64 start = block_group->start;
+	u64 end = start + block_group->length;
 
 	if (cache && !block_group->cached) {
 		block_group->cached = 1;
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index 24c25b4d56a4..101b32700b0d 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1097,8 +1097,8 @@ static int block_group_free_all_extent(struct btrfs_trans_handle *trans,
 	if (!cache)
 		return -ENOENT;
 
-	start = cache->key.objectid;
-	end = start + cache->key.offset - 1;
+	start = cache->start;
+	end = start + cache->length - 1;
 
 	if (list_empty(&cache->dirty_list))
 		list_add_tail(&cache->dirty_list, &trans->dirty_bgs);
diff --git a/convert/main.c b/convert/main.c
index 86b208816127..62d839b7262c 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -300,13 +300,13 @@ static int create_image_file_range(struct btrfs_trans_handle *trans,
 		if (!(bg_cache->flags & BTRFS_BLOCK_GROUP_DATA)) {
 			error(
 	"data bytenr %llu is covered by non-data block group %llu flags 0x%llu",
-			      bytenr, bg_cache->key.objectid, bg_cache->flags);
+			      bytenr, bg_cache->start, bg_cache->flags);
 			return -EINVAL;
 		}
 
 		/* The extent should never cross block group boundary */
-		len = min_t(u64, len, bg_cache->key.objectid +
-			    bg_cache->key.offset - bytenr);
+		len = min_t(u64, len, bg_cache->start + bg_cache->length -
+				bytenr);
 	}
 
 	if (len != round_down(len, root->fs_info->sectorsize)) {
diff --git a/convert/source-fs.c b/convert/source-fs.c
index b11188e40c58..a4e49b774958 100644
--- a/convert/source-fs.c
+++ b/convert/source-fs.c
@@ -120,7 +120,7 @@ int block_iterate_proc(u64 disk_block, u64 file_block,
 		} else {
 			cache = btrfs_lookup_block_group(root->fs_info, bytenr);
 			BUG_ON(!cache);
-			bytenr = cache->key.objectid + cache->key.offset;
+			bytenr = cache->start + cache->length;
 		}
 
 		idata->first_block = file_block;
diff --git a/ctree.h b/ctree.h
index 62b77babad6e..d12ed5d8af31 100644
--- a/ctree.h
+++ b/ctree.h
@@ -1106,9 +1106,10 @@ struct btrfs_space_info {
 
 struct btrfs_block_group_cache {
 	struct cache_extent cache;
-	struct btrfs_key key;
 	struct btrfs_space_info *space_info;
 	struct btrfs_free_space_ctl *free_space_ctl;
+	u64 start;
+	u64 length;
 	u64 used;
 	u64 bytes_super;
 	u64 pinned;
diff --git a/extent-tree.c b/extent-tree.c
index cb7691e7c101..aee859af5d98 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -67,7 +67,7 @@ static int remove_sb_from_cache(struct btrfs_root *root,
 	free_space_cache = &fs_info->free_space_cache;
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
 		bytenr = btrfs_sb_offset(i);
-		ret = btrfs_rmap_block(fs_info, cache->key.objectid, bytenr,
+		ret = btrfs_rmap_block(fs_info, cache->start, bytenr,
 				       &logical, &nr, &stripe_len);
 		BUG_ON(ret);
 		while (nr--) {
@@ -105,7 +105,7 @@ static int cache_block_group(struct btrfs_root *root,
 		return -ENOMEM;
 
 	path->reada = READA_FORWARD;
-	last = max_t(u64, block_group->key.objectid, BTRFS_SUPER_INFO_OFFSET);
+	last = max_t(u64, block_group->start, BTRFS_SUPER_INFO_OFFSET);
 	key.objectid = last;
 	key.offset = 0;
 	key.type = 0;
@@ -128,11 +128,10 @@ static int cache_block_group(struct btrfs_root *root,
 			}
 		}
 		btrfs_item_key_to_cpu(leaf, &key, slot);
-		if (key.objectid < block_group->key.objectid) {
+		if (key.objectid < block_group->start) {
 			goto next;
 		}
-		if (key.objectid >= block_group->key.objectid +
-		    block_group->key.offset) {
+		if (key.objectid >= block_group->start + block_group->length) {
 			break;
 		}
 
@@ -152,10 +151,8 @@ next:
 		path->slots[0]++;
 	}
 
-	if (block_group->key.objectid +
-	    block_group->key.offset > last) {
-		hole_size = block_group->key.objectid +
-			block_group->key.offset - last;
+	if (block_group->start + block_group->length > last) {
+		hole_size = block_group->start + block_group->length - last;
 		set_extent_dirty(free_space_cache, last, last + hole_size - 1);
 	}
 	remove_sb_from_cache(root, block_group);
@@ -181,9 +178,9 @@ static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
 		parent = *p;
 		cache = rb_entry(parent, struct btrfs_block_group_cache,
 				 cache_node);
-		if (block_group->key.objectid < cache->key.objectid)
+		if (block_group->start < cache->start)
 			p = &(*p)->rb_left;
-		else if (block_group->key.objectid > cache->key.objectid)
+		else if (block_group->start > cache->start)
 			p = &(*p)->rb_right;
 		else
 			return -EEXIST;
@@ -216,11 +213,11 @@ static struct btrfs_block_group_cache *block_group_cache_tree_search(
 	while (n) {
 		cache = rb_entry(n, struct btrfs_block_group_cache,
 				 cache_node);
-		end = cache->key.objectid + cache->key.offset - 1;
-		start = cache->key.objectid;
+		end = cache->start + cache->length - 1;
+		start = cache->start;
 
 		if (bytenr < start) {
-			if (next && (!ret || start < ret->key.objectid))
+			if (next && (!ret || start < ret->start))
 				ret = cache;
 			n = n->rb_left;
 		} else if (bytenr > start) {
@@ -281,7 +278,7 @@ again:
 	if (ret)
 		goto out;
 
-	last = max(search_start, cache->key.objectid);
+	last = max(search_start, cache->start);
 	if (cache->ro || !block_group_bits(cache, data))
 		goto new_group;
 
@@ -297,7 +294,7 @@ again:
 		if (last - start < num) {
 			continue;
 		}
-		if (start + num > cache->key.objectid + cache->key.offset) {
+		if (start + num > cache->start + cache->length) {
 			goto new_group;
 		}
 		*start_ret = start;
@@ -314,7 +311,7 @@ out:
 	return -ENOSPC;
 
 new_group:
-	last = cache->key.objectid + cache->key.offset;
+	last = cache->start + cache->length;
 wrapped:
 	cache = btrfs_lookup_first_block_group(root->fs_info, last);
 	if (!cache) {
@@ -352,7 +349,7 @@ btrfs_find_block_group(struct btrfs_root *root, struct btrfs_block_group_cache
 		if (shint && !shint->ro && block_group_bits(shint, data)) {
 			used = shint->used;
 			if (used + shint->pinned <
-			    div_factor(shint->key.offset, factor)) {
+			    div_factor(shint->length, factor)) {
 				return shint;
 			}
 		}
@@ -360,14 +357,14 @@ btrfs_find_block_group(struct btrfs_root *root, struct btrfs_block_group_cache
 	if (hint && !hint->ro && block_group_bits(hint, data)) {
 		used = hint->used;
 		if (used + hint->pinned <
-		    div_factor(hint->key.offset, factor)) {
+		    div_factor(hint->length, factor)) {
 			return hint;
 		}
-		last = hint->key.objectid + hint->key.offset;
+		last = hint->start + hint->length;
 		hint_last = last;
 	} else {
 		if (hint)
-			hint_last = max(hint->key.objectid, search_start);
+			hint_last = max(hint->start , search_start);
 		else
 			hint_last = search_start;
 
@@ -379,15 +376,14 @@ again:
 		if (!cache)
 			break;
 
-		last = cache->key.objectid + cache->key.offset;
+		last = cache->start + cache->length;
 		used = cache->used;
 
 		if (!cache->ro && block_group_bits(cache, data)) {
 			if (full_search)
-				free_check = cache->key.offset;
+				free_check = cache->length;
 			else
-				free_check = div_factor(cache->key.offset,
-							factor);
+				free_check = div_factor(cache->length, factor);
 
 			if (used + cache->pinned < free_check) {
 				found_group = cache;
@@ -1539,8 +1535,13 @@ static int write_one_cache_group(struct btrfs_trans_handle *trans,
 	unsigned long bi;
 	struct btrfs_block_group_item bgi;
 	struct extent_buffer *leaf;
+	struct btrfs_key key;
+
+	key.objectid = cache->start;
+	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+	key.offset = cache->length;
 
-	ret = btrfs_search_slot(trans, extent_root, &cache->key, path, 0, 1);
+	ret = btrfs_search_slot(trans, extent_root, &key, path, 0, 1);
 	if (ret < 0)
 		goto fail;
 	BUG_ON(ret);
@@ -1761,12 +1762,12 @@ static int update_block_group(struct btrfs_trans_handle *trans, u64 bytenr,
 		if (!cache) {
 			return -1;
 		}
-		byte_in_group = bytenr - cache->key.objectid;
-		WARN_ON(byte_in_group > cache->key.offset);
+		byte_in_group = bytenr - cache->start;
+		WARN_ON(byte_in_group > cache->length);
 		if (list_empty(&cache->dirty_list))
 			list_add_tail(&cache->dirty_list, &trans->dirty_bgs);
 		old_val = cache->used;
-		num_bytes = min(total, cache->key.offset - byte_in_group);
+		num_bytes = min(total, cache->length- byte_in_group);
 
 		if (alloc) {
 			old_val += num_bytes;
@@ -1806,8 +1807,7 @@ static int update_pinned_extents(struct btrfs_fs_info *fs_info,
 			goto next;
 		}
 		WARN_ON(!cache);
-		len = min(num, cache->key.offset -
-			  (bytenr - cache->key.objectid));
+		len = min(num, cache->length - (bytenr - cache->start));
 		if (pin) {
 			cache->pinned += len;
 			cache->space_info->bytes_pinned += len;
@@ -2219,9 +2219,8 @@ check_failed:
 	ins->offset = num_bytes;
 
 	if (ins->objectid + num_bytes >
-	    block_group->key.objectid + block_group->key.offset) {
-		search_start = block_group->key.objectid +
-			block_group->key.offset;
+	    block_group->start + block_group->length) {
+		search_start = block_group->start + block_group->length;
 		goto new_group;
 	}
 
@@ -2258,11 +2257,11 @@ check_failed:
 			bg_cache = btrfs_lookup_block_group(info, ins->objectid);
 			if (!bg_cache)
 				goto no_bg_cache;
-			bg_offset = ins->objectid - bg_cache->key.objectid;
+			bg_offset = ins->objectid - bg_cache->start;
 
 			search_start = round_up(
 				bg_offset + num_bytes, BTRFS_STRIPE_LEN) +
-				bg_cache->key.objectid;
+				bg_cache->start;
 			goto new_group;
 		}
 no_bg_cache:
@@ -2663,7 +2662,8 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 		return -ENOMEM;
 	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
 			   sizeof(bgi));
-	memcpy(&cache->key, &key, sizeof(key));
+	cache->start = key.objectid;
+	cache->length = key.offset;
 	cache->cached = 0;
 	cache->pinned = 0;
 	cache->flags = btrfs_stack_block_group_flags(&bgi);
@@ -2671,7 +2671,7 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&cache->dirty_list);
 
 	set_avail_alloc_bits(fs_info, cache->flags);
-	ret = btrfs_chunk_readonly(fs_info, cache->key.objectid);
+	ret = btrfs_chunk_readonly(fs_info, cache->start);
 	if (ret < 0) {
 		free(cache);
 		return ret;
@@ -2680,7 +2680,7 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 		cache->ro = 1;
 	exclude_super_stripes(fs_info, cache);
 
-	ret = update_space_info(fs_info, cache->flags, cache->key.offset,
+	ret = update_space_info(fs_info, cache->flags, cache->length,
 				cache->used, &space_info);
 	if (ret < 0) {
 		free(cache);
@@ -2742,10 +2742,9 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 
 	cache = kzalloc(sizeof(*cache), GFP_NOFS);
 	BUG_ON(!cache);
-	cache->key.objectid = chunk_offset;
-	cache->key.offset = size;
+	cache->start = chunk_offset;
+	cache->length = size;
 
-	cache->key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	cache->used = bytes_used;
 	cache->flags = type;
 	INIT_LIST_HEAD(&cache->dirty_list);
@@ -2770,6 +2769,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans,
 	struct btrfs_root *extent_root = fs_info->extent_root;
 	struct btrfs_block_group_cache *cache;
 	struct btrfs_block_group_item bgi;
+	struct btrfs_key key;
 
 	cache = btrfs_add_block_group(fs_info, bytes_used, type, chunk_offset,
 				      size);
@@ -2777,8 +2777,10 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
 	btrfs_set_stack_block_group_chunk_objectid(&bgi,
 			BTRFS_FIRST_CHUNK_TREE_OBJECTID);
-	ret = btrfs_insert_item(trans, extent_root, &cache->key, &bgi,
-				sizeof(bgi));
+	key.objectid = cache->start;
+	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+	key.offset = cache->length;
+	ret = btrfs_insert_item(trans, extent_root, &key, &bgi, sizeof(bgi));
 	BUG_ON(ret);
 
 	return 0;
@@ -2837,9 +2839,8 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 		cache = kzalloc(sizeof(*cache), GFP_NOFS);
 		BUG_ON(!cache);
 
-		cache->key.objectid = cur_start;
-		cache->key.offset = group_size;
-		cache->key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+		cache->start = cur_start;
+		cache->length = group_size;
 		cache->used = 0;
 		cache->flags = group_type;
 		INIT_LIST_HEAD(&cache->dirty_list);
@@ -2855,6 +2856,7 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 	cur_start = 0;
 	while(cur_start < total_bytes) {
 		struct btrfs_block_group_item bgi;
+		struct btrfs_key key;
 
 		cache = btrfs_lookup_block_group(fs_info, cur_start);
 		BUG_ON(!cache);
@@ -2863,11 +2865,14 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 		btrfs_set_stack_block_group_flags(&bgi, cache->flags);
 		btrfs_set_stack_block_group_chunk_objectid(&bgi,
 				BTRFS_FIRST_CHUNK_TREE_OBJECTID);
-		ret = btrfs_insert_item(trans, extent_root, &cache->key, &bgi,
+		key.objectid = cache->start;
+		key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+		key.offset = cache->length;
+		ret = btrfs_insert_item(trans, extent_root, &key, &bgi,
 					sizeof(bgi));
 		BUG_ON(ret);
 
-		cur_start = cache->key.objectid + cache->key.offset;
+		cur_start = cache->start + cache->length;
 	}
 	return 0;
 }
@@ -3259,7 +3264,7 @@ int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans)
 		if (!cache)
 			break;
 
-		start = cache->key.objectid + cache->key.offset;
+		start = cache->start + cache->length;
 		cache->used = 0;
 		cache->space_info->bytes_used = 0;
 		if (list_empty(&cache->dirty_list))
@@ -3545,8 +3550,8 @@ void free_excluded_extents(struct btrfs_fs_info *fs_info,
 {
 	u64 start, end;
 
-	start = cache->key.objectid;
-	end = start + cache->key.offset - 1;
+	start = cache->start;
+	end = start + cache->length - 1;
 
 	clear_extent_bits(&fs_info->pinned_extents,
 			  start, end, EXTENT_UPTODATE);
@@ -3560,19 +3565,17 @@ int exclude_super_stripes(struct btrfs_fs_info *fs_info,
 	int stripe_len;
 	int i, nr, ret;
 
-	if (cache->key.objectid < BTRFS_SUPER_INFO_OFFSET) {
-		stripe_len = BTRFS_SUPER_INFO_OFFSET - cache->key.objectid;
+	if (cache->start < BTRFS_SUPER_INFO_OFFSET) {
+		stripe_len = BTRFS_SUPER_INFO_OFFSET - cache->start;
 		cache->bytes_super += stripe_len;
-		ret = add_excluded_extent(fs_info, cache->key.objectid,
-					  stripe_len);
+		ret = add_excluded_extent(fs_info, cache->start, stripe_len);
 		if (ret)
 			return ret;
 	}
 
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
 		bytenr = btrfs_sb_offset(i);
-		ret = btrfs_rmap_block(fs_info,
-				       cache->key.objectid, bytenr,
+		ret = btrfs_rmap_block(fs_info, cache->start, bytenr,
 				       &logical, &nr, &stripe_len);
 		if (ret)
 			return ret;
@@ -3580,21 +3583,19 @@ int exclude_super_stripes(struct btrfs_fs_info *fs_info,
 		while (nr--) {
 			u64 start, len;
 
-			if (logical[nr] >= cache->key.objectid +
-			    cache->key.offset)
+			if (logical[nr] >= cache->start + cache->length)
 				continue;
 
-			if (logical[nr] + stripe_len <= cache->key.objectid)
+			if (logical[nr] + stripe_len <= cache->start)
 				continue;
 
 			start = logical[nr];
-			if (start < cache->key.objectid) {
-				start = cache->key.objectid;
+			if (start < cache->start) {
+				start = cache->start;
 				len = (logical[nr] + stripe_len) - start;
 			} else {
-				len = min_t(u64, stripe_len,
-					    cache->key.objectid +
-					    cache->key.offset - start);
+				len = min_t(u64, stripe_len, cache->start +
+					    cache->length - start);
 			}
 
 			cache->bytes_super += len;
diff --git a/free-space-cache.c b/free-space-cache.c
index b95cabadcbd8..1523dbed018a 100644
--- a/free-space-cache.c
+++ b/free-space-cache.c
@@ -446,15 +446,15 @@ int load_free_space_cache(struct btrfs_fs_info *fs_info,
 		return 0;
 
 	ret = __load_free_space_cache(fs_info->tree_root, ctl, path,
-				      block_group->key.objectid);
+				      block_group->start);
 	btrfs_free_path(path);
 
-	bg_free = block_group->key.offset - used - block_group->bytes_super;
+	bg_free = block_group->length - used - block_group->bytes_super;
 	diff = ctl->free_space - bg_free;
 	if (ret == 1 && diff) {
 		fprintf(stderr,
 		       "block group %llu has wrong amount of free space, free space cache has %llu block group has %llu\n",
-		       block_group->key.objectid, ctl->free_space, bg_free);
+		       block_group->start, ctl->free_space, bg_free);
 		__btrfs_remove_free_space_cache(ctl);
 		/*
 		 * Due to btrfs_reserve_extent() can happen out of a
@@ -479,7 +479,7 @@ int load_free_space_cache(struct btrfs_fs_info *fs_info,
 
 		fprintf(stderr,
 		       "failed to load free space cache for block group %llu\n",
-		       block_group->key.objectid);
+		       block_group->start);
 	}
 
 	return ret;
@@ -797,7 +797,7 @@ int btrfs_init_free_space_ctl(struct btrfs_block_group_cache *block_group,
 
 	ctl->sectorsize = sectorsize;
 	ctl->unit = sectorsize;
-	ctl->start = block_group->key.objectid;
+	ctl->start = block_group->start;
 	ctl->private = block_group;
 	block_group->free_space_ctl = ctl;
 
@@ -917,7 +917,7 @@ int btrfs_clear_free_space_cache(struct btrfs_fs_info *fs_info,
 
 	key.objectid = BTRFS_FREE_SPACE_OBJECTID;
 	key.type = 0;
-	key.offset = bg->key.objectid;
+	key.offset = bg->start;
 
 	ret = btrfs_search_slot(trans, tree_root, &key, &path, -1, 1);
 	if (ret > 0) {
@@ -937,7 +937,7 @@ int btrfs_clear_free_space_cache(struct btrfs_fs_info *fs_info,
 	ret = btrfs_del_item(trans, tree_root, &path);
 	if (ret < 0) {
 		error("failed to remove free space header for block group %llu: %d",
-		      bg->key.objectid, ret);
+		      bg->start, ret);
 		goto out;
 	}
 	btrfs_release_path(&path);
@@ -949,7 +949,7 @@ int btrfs_clear_free_space_cache(struct btrfs_fs_info *fs_info,
 	ret = btrfs_search_slot(trans, tree_root, &key, &path, -1, 1);
 	if (ret < 0) {
 		error("failed to locate free space cache extent for block group %llu: %d",
-		      bg->key.objectid, ret);
+		      bg->start, ret);
 		goto out;
 	}
 	while (1) {
@@ -966,7 +966,7 @@ int btrfs_clear_free_space_cache(struct btrfs_fs_info *fs_info,
 		if (ret < 0) {
 			error(
 	"failed to locate free space cache extent for block group %llu: %d",
-				bg->key.objectid, ret);
+				bg->start, ret);
 			goto out;
 		}
 		node = path.nodes[0];
@@ -1005,14 +1005,14 @@ int btrfs_clear_free_space_cache(struct btrfs_fs_info *fs_info,
 	if (ret < 0) {
 		error(
 	"failed to locate free space cache inode %llu for block group %llu: %d",
-		      ino, bg->key.objectid, ret);
+		      ino, bg->start, ret);
 		goto out;
 	}
 	ret = btrfs_del_item(trans, tree_root, &path);
 	if (ret < 0) {
 		error(
 	"failed to delete free space cache inode %llu for block group %llu: %d",
-		      ino, bg->key.objectid, ret);
+		      ino, bg->start, ret);
 	}
 out:
 	btrfs_release_path(&path);
diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index d9f2e92bb894..6ed5b76a03d9 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -35,9 +35,9 @@ search_free_space_info(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	int ret;
 
-	key.objectid = block_group->key.objectid;
+	key.objectid = block_group->start;
 	key.type = BTRFS_FREE_SPACE_INFO_KEY;
-	key.offset = block_group->key.offset;
+	key.offset = block_group->length;
 
 	ret = btrfs_search_slot(trans, root, &key, path, 0, cow);
 	if (ret < 0)
@@ -109,9 +109,9 @@ static int add_new_free_space_info(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	int ret;
 
-	key.objectid = block_group->key.objectid;
+	key.objectid = block_group->start;
 	key.type = BTRFS_FREE_SPACE_INFO_KEY;
-	key.offset = block_group->key.offset;
+	key.offset = block_group->length;
 
 	ret = btrfs_insert_empty_item(trans, root, path, &key, sizeof(*info));
 	if (ret)
@@ -192,7 +192,7 @@ static int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 	int done = 0, nr;
 	int ret;
 
-	bitmap_size = free_space_bitmap_size(block_group->key.offset,
+	bitmap_size = free_space_bitmap_size(block_group->length,
 					     fs_info->sectorsize);
 	bitmap = alloc_bitmap(bitmap_size);
 	if (!bitmap) {
@@ -200,8 +200,8 @@ static int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	start = block_group->key.objectid;
-	end = block_group->key.objectid + block_group->key.offset;
+	start = block_group->start;
+	end = block_group->start + block_group->length;
 
 	key.objectid = end - 1;
 	key.type = (u8)-1;
@@ -219,8 +219,8 @@ static int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 			btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0] - 1);
 
 			if (found_key.type == BTRFS_FREE_SPACE_INFO_KEY) {
-				ASSERT(found_key.objectid == block_group->key.objectid);
-				ASSERT(found_key.offset == block_group->key.offset);
+				ASSERT(found_key.objectid == block_group->start);
+				ASSERT(found_key.offset == block_group->length);
 				done = 1;
 				break;
 			} else if (found_key.type == BTRFS_FREE_SPACE_EXTENT_KEY) {
@@ -266,7 +266,7 @@ static int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 	if (extent_count != expected_extent_count) {
 		fprintf(stderr,
 			"incorrect extent count for %llu; counted %u, expected %u",
-			block_group->key.objectid, extent_count,
+			block_group->start, extent_count,
 			expected_extent_count);
 		ASSERT(0);
 		ret = -EIO;
@@ -330,7 +330,7 @@ static int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 	int done = 0, nr;
 	int ret;
 
-	bitmap_size = free_space_bitmap_size(block_group->key.offset,
+	bitmap_size = free_space_bitmap_size(block_group->start,
 					     fs_info->sectorsize);
 	bitmap = alloc_bitmap(bitmap_size);
 	if (!bitmap) {
@@ -338,8 +338,8 @@ static int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	start = block_group->key.objectid;
-	end = block_group->key.objectid + block_group->key.offset;
+	start = block_group->start;
+	end = block_group->start + block_group->length;
 
 	key.objectid = end - 1;
 	key.type = (u8)-1;
@@ -357,8 +357,8 @@ static int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 			btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0] - 1);
 
 			if (found_key.type == BTRFS_FREE_SPACE_INFO_KEY) {
-				ASSERT(found_key.objectid == block_group->key.objectid);
-				ASSERT(found_key.offset == block_group->key.offset);
+				ASSERT(found_key.objectid == block_group->start);
+				ASSERT(found_key.offset == block_group->length);
 				done = 1;
 				break;
 			} else if (found_key.type == BTRFS_FREE_SPACE_BITMAP_KEY) {
@@ -407,7 +407,7 @@ static int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_release_path(path);
 
-	nrbits = div_u64(block_group->key.offset, fs_info->sectorsize);
+	nrbits = div_u64(block_group->length, fs_info->sectorsize);
 	start_bit = find_next_bit_le(bitmap, nrbits, 0);
 
 	while (start_bit < nrbits) {
@@ -431,7 +431,7 @@ static int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 	if (extent_count != expected_extent_count) {
 		fprintf(stderr,
 			"incorrect extent count for %llu; counted %u, expected %u",
-			block_group->key.objectid, extent_count,
+			block_group->start, extent_count,
 			expected_extent_count);
 		ASSERT(0);
 		ret = -EIO;
@@ -570,7 +570,7 @@ static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 	 * Read the bit for the block immediately before the extent of space if
 	 * that block is within the block group.
 	 */
-	if (start > block_group->key.objectid) {
+	if (start > block_group->start) {
 		u64 prev_block = start - trans->fs_info->sectorsize;
 
 		key.objectid = prev_block;
@@ -622,7 +622,7 @@ static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 	 * Read the bit for the block immediately after the extent of space if
 	 * that block is within the block group.
 	 */
-	if (end < block_group->key.objectid + block_group->key.offset) {
+	if (end < block_group->start + block_group->length) {
 		/* The next block may be in the next bitmap. */
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 		if (end >= key.objectid + key.offset) {
@@ -841,7 +841,7 @@ static int add_free_space_extent(struct btrfs_trans_handle *trans,
 	new_key.offset = size;
 
 	/* Search for a neighbor on the left. */
-	if (start == block_group->key.objectid)
+	if (start == block_group->start)
 		goto right;
 	key.objectid = start - 1;
 	key.type = (u8)-1;
@@ -861,8 +861,8 @@ static int add_free_space_extent(struct btrfs_trans_handle *trans,
 
 	found_start = key.objectid;
 	found_end = key.objectid + key.offset;
-	ASSERT(found_start >= block_group->key.objectid &&
-	       found_end > block_group->key.objectid);
+	ASSERT(found_start >= block_group->start &&
+	       found_end > block_group->start);
 	ASSERT(found_start < start && found_end <= start);
 
 	/*
@@ -880,7 +880,7 @@ static int add_free_space_extent(struct btrfs_trans_handle *trans,
 	btrfs_release_path(path);
 right:
 	/* Search for a neighbor on the right. */
-	if (end == block_group->key.objectid + block_group->key.offset)
+	if (end == block_group->start + block_group->length)
 		goto insert;
 	key.objectid = end;
 	key.type = (u8)-1;
@@ -900,8 +900,8 @@ right:
 
 	found_start = key.objectid;
 	found_end = key.objectid + key.offset;
-	ASSERT(found_start >= block_group->key.objectid &&
-			found_end > block_group->key.objectid);
+	ASSERT(found_start >= block_group->start &&
+			found_end > block_group->start);
 	ASSERT((found_start < start && found_end <= start) ||
 			(found_start >= end && found_end > end));
 
@@ -1017,7 +1017,7 @@ int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	 * BLOCK_GROUP_ITEM, so an extent may precede the block group that it's
 	 * contained in.
 	 */
-	key.objectid = block_group->key.objectid;
+	key.objectid = block_group->start;
 	key.type = BTRFS_EXTENT_ITEM_KEY;
 	key.offset = 0;
 
@@ -1026,8 +1026,8 @@ int populate_free_space_tree(struct btrfs_trans_handle *trans,
 		goto out;
 	ASSERT(ret == 0);
 
-	start = block_group->key.objectid;
-	end = block_group->key.objectid + block_group->key.offset;
+	start = block_group->start;
+	end = block_group->start + block_group->length;
 	while (1) {
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 
@@ -1049,7 +1049,7 @@ int populate_free_space_tree(struct btrfs_trans_handle *trans,
 			else
 				start += key.offset;
 		} else if (key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) {
-			if (key.objectid != block_group->key.objectid)
+			if (key.objectid != block_group->start)
 				break;
 		}
 
@@ -1090,8 +1090,8 @@ int remove_block_group_free_space(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	start = block_group->key.objectid;
-	end = block_group->key.objectid + block_group->key.offset;
+	start = block_group->start;
+	end = block_group->start + block_group->length;
 
 	key.objectid = end - 1;
 	key.type = (u8)-1;
@@ -1109,8 +1109,9 @@ int remove_block_group_free_space(struct btrfs_trans_handle *trans,
 			btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0] - 1);
 
 			if (found_key.type == BTRFS_FREE_SPACE_INFO_KEY) {
-				ASSERT(found_key.objectid == block_group->key.objectid);
-				ASSERT(found_key.offset == block_group->key.offset);
+				ASSERT(found_key.objectid ==
+					block_group->start);
+				ASSERT(found_key.offset == block_group->length);
 				done = 1;
 				nr++;
 				path->slots[0]--;
@@ -1239,8 +1240,8 @@ static int load_free_space_bitmaps(struct btrfs_fs_info *fs_info,
 	u32 extent_count = 0;
 	int ret;
 
-	start = block_group->key.objectid;
-	end = block_group->key.objectid + block_group->key.offset;
+	start = block_group->start;
+	end = block_group->start + block_group->length;
 
 	while (1) {
 		ret = btrfs_next_item(root, path);
@@ -1318,8 +1319,8 @@ static int load_free_space_extents(struct btrfs_fs_info *fs_info,
 	u32 extent_count = 0;
 	int ret;
 
-	start = block_group->key.objectid;
-	end = block_group->key.objectid + block_group->key.offset;
+	start = block_group->start;
+	end = block_group->start + block_group->length;
 
 	while (1) {
 		ret = btrfs_next_item(root, path);
@@ -1437,7 +1438,7 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 		block_group = btrfs_lookup_first_block_group(fs_info, start);
 		if (!block_group)
 			break;
-		start = block_group->key.objectid + block_group->key.offset;
+		start = block_group->start + block_group->length;
 		ret = populate_free_space_tree(trans, block_group);
 		if (ret)
 			goto abort;
diff --git a/mkfs/main.c b/mkfs/main.c
index b659c1cbb56b..5f7b693749b3 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -694,14 +694,14 @@ static void update_chunk_allocation(struct btrfs_fs_info *fs_info,
 		if (!bg_cache)
 			break;
 		if ((bg_cache->flags & mixed_flag) == mixed_flag)
-			allocation->mixed += bg_cache->key.offset;
+			allocation->mixed += bg_cache->length;
 		else if (bg_cache->flags & BTRFS_BLOCK_GROUP_DATA)
-			allocation->data += bg_cache->key.offset;
+			allocation->data += bg_cache->length;
 		else if (bg_cache->flags & BTRFS_BLOCK_GROUP_METADATA)
-			allocation->metadata += bg_cache->key.offset;
+			allocation->metadata += bg_cache->length;
 		else
-			allocation->system += bg_cache->key.offset;
-		search_start = bg_cache->key.objectid + bg_cache->key.offset;
+			allocation->system += bg_cache->length;
+		search_start = bg_cache->start + bg_cache->length;
 	}
 }
 
diff --git a/volumes.h b/volumes.h
index 41574f21dd23..2387e088ab5d 100644
--- a/volumes.h
+++ b/volumes.h
@@ -216,7 +216,7 @@ static inline int check_crossing_stripes(struct btrfs_fs_info *fs_info,
 	 */
 	if (!bg_cache)
 		return 0;
-	bg_offset = start - bg_cache->key.objectid;
+	bg_offset = start - bg_cache->start;
 
 	return (bg_offset / BTRFS_STRIPE_LEN !=
 		(bg_offset + len - 1) / BTRFS_STRIPE_LEN);
-- 
2.26.2

