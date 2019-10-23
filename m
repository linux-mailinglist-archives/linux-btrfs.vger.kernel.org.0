Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 646EFE20EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 18:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfJWQsT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 12:48:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:57096 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726388AbfJWQsT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 12:48:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 793CDACD8;
        Wed, 23 Oct 2019 16:48:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D7E50DA734; Wed, 23 Oct 2019 18:48:22 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 6/6] btrfs: add dedicated members for start and length of a block group
Date:   Wed, 23 Oct 2019 18:48:22 +0200
Message-Id: <745a39a04234491ea7e77f2ff66221b3a462556f.1571848791.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571848791.git.dsterba@suse.com>
References: <cover.1571848791.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The on-disk format of block group item makes use of the key that stores
the offset and and length. This is further used in the code, although
this makes thing harder to understand. The key is also packed so the
offset/length is not properly aligned as u64.

Add start (key.objectid) and length (key.offset) members to block group
and remove the embedded key.  When the item is searched or written, a
local variable for key is used.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c                 | 137 +++++++++++++------------
 fs/btrfs/block-group.h                 |   3 +-
 fs/btrfs/extent-tree.c                 |  28 ++---
 fs/btrfs/free-space-cache.c            |  37 ++++---
 fs/btrfs/free-space-tree.c             |  83 ++++++++-------
 fs/btrfs/ioctl.c                       |   2 +-
 fs/btrfs/reada.c                       |   4 +-
 fs/btrfs/relocation.c                  |  16 +--
 fs/btrfs/scrub.c                       |   8 +-
 fs/btrfs/space-info.c                  |   3 +-
 fs/btrfs/sysfs.c                       |   2 +-
 fs/btrfs/tests/btrfs-tests.c           |   5 +-
 fs/btrfs/tests/free-space-tree-tests.c |  75 ++++++--------
 fs/btrfs/volumes.c                     |  15 ++-
 include/trace/events/btrfs.h           |  16 +--
 15 files changed, 210 insertions(+), 224 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 3957b1817385..1e521db3ef56 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -162,9 +162,9 @@ static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
 		parent = *p;
 		cache = rb_entry(parent, struct btrfs_block_group_cache,
 				 cache_node);
-		if (block_group->key.objectid < cache->key.objectid) {
+		if (block_group->start < cache->start) {
 			p = &(*p)->rb_left;
-		} else if (block_group->key.objectid > cache->key.objectid) {
+		} else if (block_group->start > cache->start) {
 			p = &(*p)->rb_right;
 		} else {
 			spin_unlock(&info->block_group_cache_lock);
@@ -176,8 +176,8 @@ static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
 	rb_insert_color(&block_group->cache_node,
 			&info->block_group_cache_tree);
 
-	if (info->first_logical_byte > block_group->key.objectid)
-		info->first_logical_byte = block_group->key.objectid;
+	if (info->first_logical_byte > block_group->start)
+		info->first_logical_byte = block_group->start;
 
 	spin_unlock(&info->block_group_cache_lock);
 
@@ -201,11 +201,11 @@ static struct btrfs_block_group_cache *block_group_cache_tree_search(
 	while (n) {
 		cache = rb_entry(n, struct btrfs_block_group_cache,
 				 cache_node);
-		end = cache->key.objectid + cache->key.offset - 1;
-		start = cache->key.objectid;
+		end = cache->start + cache->length - 1;
+		start = cache->start;
 
 		if (bytenr < start) {
-			if (!contains && (!ret || start < ret->key.objectid))
+			if (!contains && (!ret || start < ret->start))
 				ret = cache;
 			n = n->rb_left;
 		} else if (bytenr > start) {
@@ -221,8 +221,8 @@ static struct btrfs_block_group_cache *block_group_cache_tree_search(
 	}
 	if (ret) {
 		btrfs_get_block_group(ret);
-		if (bytenr == 0 && info->first_logical_byte > ret->key.objectid)
-			info->first_logical_byte = ret->key.objectid;
+		if (bytenr == 0 && info->first_logical_byte > ret->start)
+			info->first_logical_byte = ret->start;
 	}
 	spin_unlock(&info->block_group_cache_lock);
 
@@ -257,7 +257,7 @@ struct btrfs_block_group_cache *btrfs_next_block_group(
 
 	/* If our block group was removed, we need a full search. */
 	if (RB_EMPTY_NODE(&cache->cache_node)) {
-		const u64 next_bytenr = cache->key.objectid + cache->key.offset;
+		const u64 next_bytenr = cache->start + cache->length;
 
 		spin_unlock(&fs_info->block_group_cache_lock);
 		btrfs_put_block_group(cache);
@@ -427,8 +427,8 @@ int btrfs_wait_block_group_cache_done(struct btrfs_block_group_cache *cache)
 static void fragment_free_space(struct btrfs_block_group_cache *block_group)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
-	u64 start = block_group->key.objectid;
-	u64 len = block_group->key.offset;
+	u64 start = block_group->start;
+	u64 len = block_group->length;
 	u64 chunk = block_group->flags & BTRFS_BLOCK_GROUP_METADATA ?
 		fs_info->nodesize : fs_info->sectorsize;
 	u64 step = chunk << 1;
@@ -507,7 +507,7 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 	if (!path)
 		return -ENOMEM;
 
-	last = max_t(u64, block_group->key.objectid, BTRFS_SUPER_INFO_OFFSET);
+	last = max_t(u64, block_group->start, BTRFS_SUPER_INFO_OFFSET);
 
 #ifdef CONFIG_BTRFS_DEBUG
 	/*
@@ -587,13 +587,12 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 			goto next;
 		}
 
-		if (key.objectid < block_group->key.objectid) {
+		if (key.objectid < block_group->start) {
 			path->slots[0]++;
 			continue;
 		}
 
-		if (key.objectid >= block_group->key.objectid +
-		    block_group->key.offset)
+		if (key.objectid >= block_group->start + block_group->length)
 			break;
 
 		if (key.type == BTRFS_EXTENT_ITEM_KEY ||
@@ -617,8 +616,7 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 	ret = 0;
 
 	total_found += add_new_free_space(block_group, last,
-					  block_group->key.objectid +
-					  block_group->key.offset);
+				block_group->start + block_group->length);
 	caching_ctl->progress = (u64)-1;
 
 out:
@@ -656,7 +654,7 @@ static noinline void caching_thread(struct btrfs_work *work)
 
 		spin_lock(&block_group->space_info->lock);
 		spin_lock(&block_group->lock);
-		bytes_used = block_group->key.offset - block_group->used;
+		bytes_used = block_group->length - block_group->used;
 		block_group->space_info->bytes_used += bytes_used >> 1;
 		spin_unlock(&block_group->lock);
 		spin_unlock(&block_group->space_info->lock);
@@ -692,7 +690,7 @@ int btrfs_cache_block_group(struct btrfs_block_group_cache *cache,
 	mutex_init(&caching_ctl->mutex);
 	init_waitqueue_head(&caching_ctl->wait);
 	caching_ctl->block_group = cache;
-	caching_ctl->progress = cache->key.objectid;
+	caching_ctl->progress = cache->start;
 	refcount_set(&caching_ctl->count, 1);
 	btrfs_init_work(&caching_ctl->work, caching_thread, NULL, NULL);
 
@@ -761,7 +759,7 @@ int btrfs_cache_block_group(struct btrfs_block_group_cache *cache,
 
 			spin_lock(&cache->space_info->lock);
 			spin_lock(&cache->lock);
-			bytes_used = cache->key.offset - cache->used;
+			bytes_used = cache->length - cache->used;
 			cache->space_info->bytes_used += bytes_used >> 1;
 			spin_unlock(&cache->lock);
 			spin_unlock(&cache->space_info->lock);
@@ -883,10 +881,9 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	 * remove it.
 	 */
 	btrfs_free_excluded_extents(block_group);
-	btrfs_free_ref_tree_range(fs_info, block_group->key.objectid,
-				  block_group->key.offset);
+	btrfs_free_ref_tree_range(fs_info, block_group->start,
+				  block_group->length);
 
-	memcpy(&key, &block_group->key, sizeof(key));
 	index = btrfs_bg_flags_to_raid_index(block_group->flags);
 	factor = btrfs_bg_type_to_factor(block_group->flags);
 
@@ -964,8 +961,8 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	}
 
 	key.objectid = BTRFS_FREE_SPACE_OBJECTID;
-	key.offset = block_group->key.objectid;
 	key.type = 0;
+	key.offset = block_group->start;
 
 	ret = btrfs_search_slot(trans, tree_root, &key, path, -1, 1);
 	if (ret < 0)
@@ -984,7 +981,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		 &fs_info->block_group_cache_tree);
 	RB_CLEAR_NODE(&block_group->cache_node);
 
-	if (fs_info->first_logical_byte == block_group->key.objectid)
+	if (fs_info->first_logical_byte == block_group->start)
 		fs_info->first_logical_byte = (u64)-1;
 	spin_unlock(&fs_info->block_group_cache_lock);
 
@@ -1045,19 +1042,21 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 
 	if (btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
 		WARN_ON(block_group->space_info->total_bytes
-			< block_group->key.offset);
+			< block_group->length);
 		WARN_ON(block_group->space_info->bytes_readonly
-			< block_group->key.offset);
+			< block_group->length);
 		WARN_ON(block_group->space_info->disk_total
-			< block_group->key.offset * factor);
+			< block_group->length * factor);
 	}
-	block_group->space_info->total_bytes -= block_group->key.offset;
-	block_group->space_info->bytes_readonly -= block_group->key.offset;
-	block_group->space_info->disk_total -= block_group->key.offset * factor;
+	block_group->space_info->total_bytes -= block_group->length;
+	block_group->space_info->bytes_readonly -= block_group->length;
+	block_group->space_info->disk_total -= block_group->length * factor;
 
 	spin_unlock(&block_group->space_info->lock);
 
-	memcpy(&key, &block_group->key, sizeof(key));
+	key.objectid = block_group->start;
+	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+	key.offset = block_group->length;
 
 	mutex_lock(&fs_info->chunk_mutex);
 	spin_lock(&block_group->lock);
@@ -1206,7 +1205,7 @@ static int inc_block_group_ro(struct btrfs_block_group_cache *cache, int force)
 		goto out;
 	}
 
-	num_bytes = cache->key.offset - cache->reserved - cache->pinned -
+	num_bytes = cache->length - cache->reserved - cache->pinned -
 		    cache->bytes_super - cache->used;
 	sinfo_used = btrfs_space_info_used(sinfo, true);
 
@@ -1228,8 +1227,7 @@ static int inc_block_group_ro(struct btrfs_block_group_cache *cache, int force)
 	spin_unlock(&sinfo->lock);
 	if (ret == -ENOSPC && btrfs_test_opt(cache->fs_info, ENOSPC_DEBUG)) {
 		btrfs_info(cache->fs_info,
-			"unable to make block group %llu ro",
-			cache->key.objectid);
+			"unable to make block group %llu ro", cache->start);
 		btrfs_info(cache->fs_info,
 			"sinfo_used=%llu bg_num_bytes=%llu min_allocable=%llu",
 			sinfo_used, num_bytes, min_allocable_bytes);
@@ -1304,7 +1302,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		 * properly if we fail to join the transaction.
 		 */
 		trans = btrfs_start_trans_remove_block_group(fs_info,
-						     block_group->key.objectid);
+						     block_group->start);
 		if (IS_ERR(trans)) {
 			btrfs_dec_block_group_ro(block_group);
 			ret = PTR_ERR(trans);
@@ -1315,8 +1313,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		 * We could have pending pinned extents for this block group,
 		 * just delete them, we don't care about them anymore.
 		 */
-		start = block_group->key.objectid;
-		end = start + block_group->key.offset - 1;
+		start = block_group->start;
+		end = start + block_group->length - 1;
 		/*
 		 * Hold the unused_bg_unpin_mutex lock to avoid racing with
 		 * btrfs_finish_extent_commit(). If we are at transaction N,
@@ -1371,7 +1369,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		 * Btrfs_remove_chunk will abort the transaction if things go
 		 * horribly wrong.
 		 */
-		ret = btrfs_remove_chunk(trans, block_group->key.objectid);
+		ret = btrfs_remove_chunk(trans, block_group->start);
 
 		if (ret) {
 			if (trimming)
@@ -1522,10 +1520,10 @@ static int exclude_super_stripes(struct btrfs_block_group_cache *cache)
 	int stripe_len;
 	int i, nr, ret;
 
-	if (cache->key.objectid < BTRFS_SUPER_INFO_OFFSET) {
-		stripe_len = BTRFS_SUPER_INFO_OFFSET - cache->key.objectid;
+	if (cache->start < BTRFS_SUPER_INFO_OFFSET) {
+		stripe_len = BTRFS_SUPER_INFO_OFFSET - cache->start;
 		cache->bytes_super += stripe_len;
-		ret = btrfs_add_excluded_extent(fs_info, cache->key.objectid,
+		ret = btrfs_add_excluded_extent(fs_info, cache->start,
 						stripe_len);
 		if (ret)
 			return ret;
@@ -1533,7 +1531,7 @@ static int exclude_super_stripes(struct btrfs_block_group_cache *cache)
 
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
 		bytenr = btrfs_sb_offset(i);
-		ret = btrfs_rmap_block(fs_info, cache->key.objectid,
+		ret = btrfs_rmap_block(fs_info, cache->start,
 				       bytenr, &logical, &nr, &stripe_len);
 		if (ret)
 			return ret;
@@ -1541,21 +1539,19 @@ static int exclude_super_stripes(struct btrfs_block_group_cache *cache)
 		while (nr--) {
 			u64 start, len;
 
-			if (logical[nr] > cache->key.objectid +
-			    cache->key.offset)
+			if (logical[nr] > cache->start + cache->length)
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
 				len = min_t(u64, stripe_len,
-					    cache->key.objectid +
-					    cache->key.offset - start);
+					    cache->start + cache->length - start);
 			}
 
 			cache->bytes_super += len;
@@ -1603,9 +1599,8 @@ static struct btrfs_block_group_cache *btrfs_create_block_group_cache(
 		return NULL;
 	}
 
-	cache->key.objectid = start;
-	cache->key.offset = size;
-	cache->key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+	cache->start = start;
+	cache->length = size;
 
 	cache->fs_info = fs_info;
 	cache->full_stripe_len = btrfs_full_stripe_len(fs_info, start);
@@ -1661,15 +1656,14 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
 			free_extent_map(em);
 			break;
 		}
-		if (bg->key.objectid != em->start ||
-		    bg->key.offset != em->len ||
+		if (bg->start != em->start || bg->length != em->len ||
 		    (bg->flags & BTRFS_BLOCK_GROUP_TYPE_MASK) !=
 		    (em->map_lookup->type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
 			btrfs_err(fs_info,
 "chunk start=%llu len=%llu flags=0x%llx doesn't match block group start=%llu len=%llu flags=0x%llx",
 				em->start, em->len,
 				em->map_lookup->type & BTRFS_BLOCK_GROUP_TYPE_MASK,
-				bg->key.objectid, bg->key.offset,
+				bg->start, bg->length,
 				bg->flags & BTRFS_BLOCK_GROUP_TYPE_MASK);
 			ret = -EUCLEAN;
 			free_extent_map(em);
@@ -1760,7 +1754,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		    (cache->flags & BTRFS_BLOCK_GROUP_DATA))) {
 			btrfs_err(info,
 "bg %llu is a mixed block group but filesystem hasn't enabled mixed block groups",
-				  cache->key.objectid);
+				  cache->start);
 			btrfs_put_block_group(cache);
 			ret = -EINVAL;
 			goto error;
@@ -1822,7 +1816,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		link_block_group(cache);
 
 		set_avail_alloc_bits(info, cache->flags);
-		if (btrfs_chunk_readonly(info, cache->key.objectid)) {
+		if (btrfs_chunk_readonly(info, cache->start)) {
 			inc_block_group_ro(cache, 1);
 		} else if (cache->used == 0) {
 			ASSERT(list_empty(&cache->bg_list));
@@ -1882,7 +1876,9 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 		btrfs_set_stack_block_group_chunk_objectid(&item,
 				BTRFS_FIRST_CHUNK_TREE_OBJECTID);
 		btrfs_set_stack_block_group_flags(&item, block_group->flags);
-		memcpy(&key, &block_group->key, sizeof(key));
+		key.objectid = block_group->start;
+		key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+		key.offset = block_group->length;
 		spin_unlock(&block_group->lock);
 
 		ret = btrfs_insert_item(trans, extent_root, &key, &item,
@@ -2101,7 +2097,7 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache)
 	spin_lock(&sinfo->lock);
 	spin_lock(&cache->lock);
 	if (!--cache->ro) {
-		num_bytes = cache->key.offset - cache->reserved -
+		num_bytes = cache->length - cache->reserved -
 			    cache->pinned - cache->bytes_super - cache->used;
 		sinfo->bytes_readonly -= num_bytes;
 		list_del_init(&cache->ro_list);
@@ -2120,8 +2116,13 @@ static int write_one_cache_group(struct btrfs_trans_handle *trans,
 	unsigned long bi;
 	struct extent_buffer *leaf;
 	struct btrfs_block_group_item bgi;
+	struct btrfs_key key;
+
+	key.objectid = cache->start;
+	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+	key.offset = cache->length;
 
-	ret = btrfs_search_slot(trans, extent_root, &cache->key, path, 0, 1);
+	ret = btrfs_search_slot(trans, extent_root, &key, path, 0, 1);
 	if (ret) {
 		if (ret > 0)
 			ret = -ENOENT;
@@ -2160,7 +2161,7 @@ static int cache_save_setup(struct btrfs_block_group_cache *block_group,
 	 * If this block group is smaller than 100 megs don't bother caching the
 	 * block group.
 	 */
-	if (block_group->key.offset < (100 * SZ_1M)) {
+	if (block_group->length < (100 * SZ_1M)) {
 		spin_lock(&block_group->lock);
 		block_group->disk_cache_state = BTRFS_DC_WRITTEN;
 		spin_unlock(&block_group->lock);
@@ -2261,7 +2262,7 @@ static int cache_save_setup(struct btrfs_block_group_cache *block_group,
 	 * taking up quite a bit since it's not folded into the other space
 	 * cache.
 	 */
-	num_pages = div_u64(block_group->key.offset, SZ_256M);
+	num_pages = div_u64(block_group->length, SZ_256M);
 	if (!num_pages)
 		num_pages = 1;
 
@@ -2668,8 +2669,8 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		if (!alloc && !btrfs_block_group_cache_done(cache))
 			btrfs_cache_block_group(cache, 1);
 
-		byte_in_group = bytenr - cache->key.objectid;
-		WARN_ON(byte_in_group > cache->key.offset);
+		byte_in_group = bytenr - cache->start;
+		WARN_ON(byte_in_group > cache->length);
 
 		spin_lock(&cache->space_info->lock);
 		spin_lock(&cache->lock);
@@ -2679,7 +2680,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 			cache->disk_cache_state = BTRFS_DC_CLEAR;
 
 		old_val = cache->used;
-		num_bytes = min(total, cache->key.offset - byte_in_group);
+		num_bytes = min(total, cache->length - byte_in_group);
 		if (alloc) {
 			old_val += num_bytes;
 			cache->used = old_val;
@@ -3076,7 +3077,7 @@ void btrfs_put_block_group_cache(struct btrfs_fs_info *info)
 		spin_unlock(&block_group->lock);
 		ASSERT(block_group->io_ctl.inode == NULL);
 		iput(inode);
-		last = block_group->key.objectid + block_group->key.offset;
+		last = block_group->start + block_group->length;
 		btrfs_put_block_group(block_group);
 	}
 }
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index d78fce7cd3a4..2ea580352aff 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -43,10 +43,11 @@ struct btrfs_caching_control {
 #define CACHING_CTL_WAKE_UP SZ_2M
 
 struct btrfs_block_group_cache {
-	struct btrfs_key key;
 	struct btrfs_fs_info *fs_info;
 	struct inode *inode;
 	spinlock_t lock;
+	u64 start;
+	u64 length;
 	u64 pinned;
 	u64 reserved;
 	u64 used;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e3fd4b0ca905..b24d116eaf0b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -75,8 +75,8 @@ void btrfs_free_excluded_extents(struct btrfs_block_group_cache *cache)
 	struct btrfs_fs_info *fs_info = cache->fs_info;
 	u64 start, end;
 
-	start = cache->key.objectid;
-	end = start + cache->key.offset - 1;
+	start = cache->start;
+	end = start + cache->length - 1;
 
 	clear_extent_bits(&fs_info->freed_extents[0],
 			  start, end, EXTENT_UPTODATE);
@@ -2560,7 +2560,7 @@ static u64 first_logical_byte(struct btrfs_fs_info *fs_info, u64 search_start)
 	if (!cache)
 		return 0;
 
-	bytenr = cache->key.objectid;
+	bytenr = cache->start;
 	btrfs_put_block_group(cache);
 
 	return bytenr;
@@ -2796,7 +2796,7 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 	while (start <= end) {
 		readonly = false;
 		if (!cache ||
-		    start >= cache->key.objectid + cache->key.offset) {
+		    start >= cache->start + cache->length) {
 			if (cache)
 				btrfs_put_block_group(cache);
 			total_unpinned = 0;
@@ -2809,7 +2809,7 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 			empty_cluster <<= 1;
 		}
 
-		len = cache->key.objectid + cache->key.offset - start;
+		len = cache->start + cache->length - start;
 		len = min(len, end + 1 - start);
 
 		if (start < cache->last_byte_to_unpin) {
@@ -2925,8 +2925,8 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 		ret = -EROFS;
 		if (!trans->aborted)
 			ret = btrfs_discard_extent(fs_info,
-						   block_group->key.objectid,
-						   block_group->key.offset,
+						   block_group->start,
+						   block_group->length,
 						   &trimmed);
 
 		list_del_init(&block_group->bg_list);
@@ -3492,7 +3492,7 @@ static int find_free_extent_clustered(struct btrfs_block_group_cache *bg,
 		goto release_cluster;
 
 	offset = btrfs_alloc_from_cluster(cluster_bg, last_ptr,
-			ffe_ctl->num_bytes, cluster_bg->key.objectid,
+			ffe_ctl->num_bytes, cluster_bg->start,
 			&ffe_ctl->max_extent_size);
 	if (offset) {
 		/* We have a block, we're done */
@@ -3903,7 +3903,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 			continue;
 
 		btrfs_grab_block_group(block_group, delalloc);
-		ffe_ctl.search_start = block_group->key.objectid;
+		ffe_ctl.search_start = block_group->start;
 
 		/*
 		 * this can happen if we end up cycling through all the
@@ -3983,7 +3983,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 
 		/* move on to the next group */
 		if (ffe_ctl.search_start + num_bytes >
-		    block_group->key.objectid + block_group->key.offset) {
+		    block_group->start + block_group->length) {
 			btrfs_add_free_space(block_group, ffe_ctl.found_offset,
 					     num_bytes);
 			goto loop;
@@ -5497,7 +5497,7 @@ u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo)
 		}
 
 		factor = btrfs_bg_type_to_factor(block_group->flags);
-		free_bytes += (block_group->key.offset -
+		free_bytes += (block_group->length -
 			       block_group->used) * factor;
 
 		spin_unlock(&block_group->lock);
@@ -5645,13 +5645,13 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 
 	cache = btrfs_lookup_first_block_group(fs_info, range->start);
 	for (; cache; cache = btrfs_next_block_group(cache)) {
-		if (cache->key.objectid >= range_end) {
+		if (cache->start >= range_end) {
 			btrfs_put_block_group(cache);
 			break;
 		}
 
-		start = max(range->start, cache->key.objectid);
-		end = min(range_end, cache->key.objectid + cache->key.offset);
+		start = max(range->start, cache->start);
+		end = min(range_end, cache->start + cache->length);
 
 		if (end - start >= range->minlen) {
 			if (!btrfs_block_group_cache_done(cache)) {
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index e4ea277d4e01..279c41c4ba50 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -107,7 +107,7 @@ struct inode *lookup_free_space_inode(
 		return inode;
 
 	inode = __lookup_free_space_inode(fs_info->tree_root, path,
-					  block_group->key.objectid);
+					  block_group->start);
 	if (IS_ERR(inode))
 		return inode;
 
@@ -201,7 +201,7 @@ int create_free_space_inode(struct btrfs_trans_handle *trans,
 		return ret;
 
 	return __create_free_space_inode(trans->fs_info->tree_root, trans, path,
-					 ino, block_group->key.objectid);
+					 ino, block_group->start);
 }
 
 int btrfs_check_trunc_cache_free_space(struct btrfs_fs_info *fs_info,
@@ -882,13 +882,13 @@ int load_free_space_cache(struct btrfs_block_group_cache *block_group)
 	spin_unlock(&block_group->lock);
 
 	ret = __load_free_space_cache(fs_info->tree_root, inode, ctl,
-				      path, block_group->key.objectid);
+				      path, block_group->start);
 	btrfs_free_path(path);
 	if (ret <= 0)
 		goto out;
 
 	spin_lock(&ctl->tree_lock);
-	matched = (ctl->free_space == (block_group->key.offset - used -
+	matched = (ctl->free_space == (block_group->length - used -
 				       block_group->bytes_super));
 	spin_unlock(&ctl->tree_lock);
 
@@ -896,7 +896,7 @@ int load_free_space_cache(struct btrfs_block_group_cache *block_group)
 		__btrfs_remove_free_space_cache(ctl);
 		btrfs_warn(fs_info,
 			   "block group %llu has wrong amount of free space",
-			   block_group->key.objectid);
+			   block_group->start);
 		ret = -1;
 	}
 out:
@@ -909,7 +909,7 @@ int load_free_space_cache(struct btrfs_block_group_cache *block_group)
 
 		btrfs_warn(fs_info,
 			   "failed to load free space cache for block group %llu, rebuilding it now",
-			   block_group->key.objectid);
+			   block_group->start);
 	}
 
 	iput(inode);
@@ -1067,9 +1067,9 @@ static noinline_for_stack int write_pinned_extent_entries(
 	 */
 	unpin = block_group->fs_info->pinned_extents;
 
-	start = block_group->key.objectid;
+	start = block_group->start;
 
-	while (start < block_group->key.objectid + block_group->key.offset) {
+	while (start < block_group->start + block_group->length) {
 		ret = find_first_extent_bit(unpin, start,
 					    &extent_start, &extent_end,
 					    EXTENT_DIRTY, NULL);
@@ -1077,13 +1077,12 @@ static noinline_for_stack int write_pinned_extent_entries(
 			return 0;
 
 		/* This pinned extent is out of our range */
-		if (extent_start >= block_group->key.objectid +
-		    block_group->key.offset)
+		if (extent_start >= block_group->start + block_group->length)
 			return 0;
 
 		extent_start = max(extent_start, start);
-		extent_end = min(block_group->key.objectid +
-				 block_group->key.offset, extent_end + 1);
+		extent_end = min(block_group->start + block_group->length,
+				 extent_end + 1);
 		len = extent_end - extent_start;
 
 		*entries += 1;
@@ -1174,7 +1173,7 @@ static int __btrfs_wait_cache_io(struct btrfs_root *root,
 #ifdef DEBUG
 			btrfs_err(root->fs_info,
 				  "failed to write free space cache for block group %llu",
-				  block_group->key.objectid);
+				  block_group->start);
 #endif
 		}
 	}
@@ -1221,7 +1220,7 @@ int btrfs_wait_cache_io(struct btrfs_trans_handle *trans,
 {
 	return __btrfs_wait_cache_io(block_group->fs_info->tree_root, trans,
 				     block_group, &block_group->io_ctl,
-				     path, block_group->key.objectid);
+				     path, block_group->start);
 }
 
 /**
@@ -1400,7 +1399,7 @@ int btrfs_write_out_cache(struct btrfs_trans_handle *trans,
 #ifdef DEBUG
 		btrfs_err(fs_info,
 			  "failed to write free space cache for block group %llu",
-			  block_group->key.objectid);
+			  block_group->start);
 #endif
 		spin_lock(&block_group->lock);
 		block_group->disk_cache_state = BTRFS_DC_ERROR;
@@ -1657,7 +1656,7 @@ static void recalculate_thresholds(struct btrfs_free_space_ctl *ctl)
 	u64 max_bytes;
 	u64 bitmap_bytes;
 	u64 extent_bytes;
-	u64 size = block_group->key.offset;
+	u64 size = block_group->length;
 	u64 bytes_per_bg = BITS_PER_BITMAP * ctl->unit;
 	u64 max_bitmaps = div64_u64(size + bytes_per_bg - 1, bytes_per_bg);
 
@@ -2034,7 +2033,7 @@ static bool use_bitmap(struct btrfs_free_space_ctl *ctl,
 	 * so allow those block groups to still be allowed to have a bitmap
 	 * entry.
 	 */
-	if (((BITS_PER_BITMAP * ctl->unit) >> 1) > block_group->key.offset)
+	if (((BITS_PER_BITMAP * ctl->unit) >> 1) > block_group->length)
 		return false;
 
 	return true;
@@ -2516,7 +2515,7 @@ void btrfs_init_free_space_ctl(struct btrfs_block_group_cache *block_group)
 
 	spin_lock_init(&ctl->tree_lock);
 	ctl->unit = fs_info->sectorsize;
-	ctl->start = block_group->key.objectid;
+	ctl->start = block_group->start;
 	ctl->private = block_group;
 	ctl->op = &free_space_op;
 	INIT_LIST_HEAD(&ctl->trimming_ranges);
@@ -3379,7 +3378,7 @@ void btrfs_put_block_group_trimming(struct btrfs_block_group_cache *block_group)
 		mutex_lock(&fs_info->chunk_mutex);
 		em_tree = &fs_info->mapping_tree;
 		write_lock(&em_tree->lock);
-		em = lookup_extent_mapping(em_tree, block_group->key.objectid,
+		em = lookup_extent_mapping(em_tree, block_group->start,
 					   1);
 		BUG_ON(!em); /* logic error, can't happen */
 		remove_extent_mapping(em_tree, em);
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 48a03f5240f5..d3aa65a4c76f 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -27,8 +27,7 @@ void set_free_space_tree_thresholds(struct btrfs_block_group_cache *cache)
 	 * exceeds that required for using bitmaps.
 	 */
 	bitmap_range = cache->fs_info->sectorsize * BTRFS_FREE_SPACE_BITMAP_BITS;
-	num_bitmaps = div_u64(cache->key.offset + bitmap_range - 1,
-			      bitmap_range);
+	num_bitmaps = div_u64(cache->length + bitmap_range - 1, bitmap_range);
 	bitmap_size = sizeof(struct btrfs_item) + BTRFS_FREE_SPACE_BITMAP_SIZE;
 	total_bitmap_size = num_bitmaps * bitmap_size;
 	cache->bitmap_high_thresh = div_u64(total_bitmap_size,
@@ -54,9 +53,9 @@ static int add_new_free_space_info(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	int ret;
 
-	key.objectid = block_group->key.objectid;
+	key.objectid = block_group->start;
 	key.type = BTRFS_FREE_SPACE_INFO_KEY;
-	key.offset = block_group->key.offset;
+	key.offset = block_group->length;
 
 	ret = btrfs_insert_empty_item(trans, root, path, &key, sizeof(*info));
 	if (ret)
@@ -86,16 +85,16 @@ struct btrfs_free_space_info *search_free_space_info(
 	struct btrfs_key key;
 	int ret;
 
-	key.objectid = block_group->key.objectid;
+	key.objectid = block_group->start;
 	key.type = BTRFS_FREE_SPACE_INFO_KEY;
-	key.offset = block_group->key.offset;
+	key.offset = block_group->length;
 
 	ret = btrfs_search_slot(trans, root, &key, path, 0, cow);
 	if (ret < 0)
 		return ERR_PTR(ret);
 	if (ret != 0) {
 		btrfs_warn(fs_info, "missing free space info for %llu",
-			   block_group->key.objectid);
+			   block_group->start);
 		ASSERT(0);
 		return ERR_PTR(-ENOENT);
 	}
@@ -197,7 +196,7 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 	int done = 0, nr;
 	int ret;
 
-	bitmap_size = free_space_bitmap_size(block_group->key.offset,
+	bitmap_size = free_space_bitmap_size(block_group->length,
 					     fs_info->sectorsize);
 	bitmap = alloc_bitmap(bitmap_size);
 	if (!bitmap) {
@@ -205,8 +204,8 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	start = block_group->key.objectid;
-	end = block_group->key.objectid + block_group->key.offset;
+	start = block_group->start;
+	end = block_group->start + block_group->length;
 
 	key.objectid = end - 1;
 	key.type = (u8)-1;
@@ -224,8 +223,8 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 			btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0] - 1);
 
 			if (found_key.type == BTRFS_FREE_SPACE_INFO_KEY) {
-				ASSERT(found_key.objectid == block_group->key.objectid);
-				ASSERT(found_key.offset == block_group->key.offset);
+				ASSERT(found_key.objectid == block_group->start);
+				ASSERT(found_key.offset == block_group->length);
 				done = 1;
 				break;
 			} else if (found_key.type == BTRFS_FREE_SPACE_EXTENT_KEY) {
@@ -271,7 +270,7 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 	if (extent_count != expected_extent_count) {
 		btrfs_err(fs_info,
 			  "incorrect extent count for %llu; counted %u, expected %u",
-			  block_group->key.objectid, extent_count,
+			  block_group->start, extent_count,
 			  expected_extent_count);
 		ASSERT(0);
 		ret = -EIO;
@@ -336,7 +335,7 @@ int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 	int done = 0, nr;
 	int ret;
 
-	bitmap_size = free_space_bitmap_size(block_group->key.offset,
+	bitmap_size = free_space_bitmap_size(block_group->length,
 					     fs_info->sectorsize);
 	bitmap = alloc_bitmap(bitmap_size);
 	if (!bitmap) {
@@ -344,8 +343,8 @@ int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	start = block_group->key.objectid;
-	end = block_group->key.objectid + block_group->key.offset;
+	start = block_group->start;
+	end = block_group->start + block_group->length;
 
 	key.objectid = end - 1;
 	key.type = (u8)-1;
@@ -363,8 +362,8 @@ int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 			btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0] - 1);
 
 			if (found_key.type == BTRFS_FREE_SPACE_INFO_KEY) {
-				ASSERT(found_key.objectid == block_group->key.objectid);
-				ASSERT(found_key.offset == block_group->key.offset);
+				ASSERT(found_key.objectid == block_group->start);
+				ASSERT(found_key.offset == block_group->length);
 				done = 1;
 				break;
 			} else if (found_key.type == BTRFS_FREE_SPACE_BITMAP_KEY) {
@@ -413,7 +412,7 @@ int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_release_path(path);
 
-	nrbits = div_u64(block_group->key.offset, block_group->fs_info->sectorsize);
+	nrbits = div_u64(block_group->length, block_group->fs_info->sectorsize);
 	start_bit = find_next_bit_le(bitmap, nrbits, 0);
 
 	while (start_bit < nrbits) {
@@ -437,7 +436,7 @@ int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 	if (extent_count != expected_extent_count) {
 		btrfs_err(fs_info,
 			  "incorrect extent count for %llu; counted %u, expected %u",
-			  block_group->key.objectid, extent_count,
+			  block_group->start, extent_count,
 			  expected_extent_count);
 		ASSERT(0);
 		ret = -EIO;
@@ -597,7 +596,7 @@ static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 	 * Read the bit for the block immediately before the extent of space if
 	 * that block is within the block group.
 	 */
-	if (start > block_group->key.objectid) {
+	if (start > block_group->start) {
 		u64 prev_block = start - block_group->fs_info->sectorsize;
 
 		key.objectid = prev_block;
@@ -649,7 +648,7 @@ static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 	 * Read the bit for the block immediately after the extent of space if
 	 * that block is within the block group.
 	 */
-	if (end < block_group->key.objectid + block_group->key.offset) {
+	if (end < block_group->start + block_group->length) {
 		/* The next block may be in the next bitmap. */
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 		if (end >= key.objectid + key.offset) {
@@ -880,7 +879,7 @@ static int add_free_space_extent(struct btrfs_trans_handle *trans,
 	new_key.offset = size;
 
 	/* Search for a neighbor on the left. */
-	if (start == block_group->key.objectid)
+	if (start == block_group->start)
 		goto right;
 	key.objectid = start - 1;
 	key.type = (u8)-1;
@@ -900,8 +899,8 @@ static int add_free_space_extent(struct btrfs_trans_handle *trans,
 
 	found_start = key.objectid;
 	found_end = key.objectid + key.offset;
-	ASSERT(found_start >= block_group->key.objectid &&
-	       found_end > block_group->key.objectid);
+	ASSERT(found_start >= block_group->start &&
+	       found_end > block_group->start);
 	ASSERT(found_start < start && found_end <= start);
 
 	/*
@@ -920,7 +919,7 @@ static int add_free_space_extent(struct btrfs_trans_handle *trans,
 
 right:
 	/* Search for a neighbor on the right. */
-	if (end == block_group->key.objectid + block_group->key.offset)
+	if (end == block_group->start + block_group->length)
 		goto insert;
 	key.objectid = end;
 	key.type = (u8)-1;
@@ -940,8 +939,8 @@ static int add_free_space_extent(struct btrfs_trans_handle *trans,
 
 	found_start = key.objectid;
 	found_end = key.objectid + key.offset;
-	ASSERT(found_start >= block_group->key.objectid &&
-	       found_end > block_group->key.objectid);
+	ASSERT(found_start >= block_group->start &&
+	       found_end > block_group->start);
 	ASSERT((found_start < start && found_end <= start) ||
 	       (found_start >= end && found_end > end));
 
@@ -1075,7 +1074,7 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	 * BLOCK_GROUP_ITEM, so an extent may precede the block group that it's
 	 * contained in.
 	 */
-	key.objectid = block_group->key.objectid;
+	key.objectid = block_group->start;
 	key.type = BTRFS_EXTENT_ITEM_KEY;
 	key.offset = 0;
 
@@ -1084,8 +1083,8 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 		goto out_locked;
 	ASSERT(ret == 0);
 
-	start = block_group->key.objectid;
-	end = block_group->key.objectid + block_group->key.offset;
+	start = block_group->start;
+	end = block_group->start + block_group->length;
 	while (1) {
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 
@@ -1109,7 +1108,7 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 			else
 				start += key.offset;
 		} else if (key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) {
-			if (key.objectid != block_group->key.objectid)
+			if (key.objectid != block_group->start)
 				break;
 		}
 
@@ -1277,8 +1276,8 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 		return ret;
 
 	return __add_to_free_space_tree(trans, block_group, path,
-					block_group->key.objectid,
-					block_group->key.offset);
+					block_group->start,
+					block_group->length);
 }
 
 int add_block_group_free_space(struct btrfs_trans_handle *trans,
@@ -1336,8 +1335,8 @@ int remove_block_group_free_space(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	start = block_group->key.objectid;
-	end = block_group->key.objectid + block_group->key.offset;
+	start = block_group->start;
+	end = block_group->start + block_group->length;
 
 	key.objectid = end - 1;
 	key.type = (u8)-1;
@@ -1355,8 +1354,8 @@ int remove_block_group_free_space(struct btrfs_trans_handle *trans,
 			btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0] - 1);
 
 			if (found_key.type == BTRFS_FREE_SPACE_INFO_KEY) {
-				ASSERT(found_key.objectid == block_group->key.objectid);
-				ASSERT(found_key.offset == block_group->key.offset);
+				ASSERT(found_key.objectid == block_group->start);
+				ASSERT(found_key.offset == block_group->length);
 				done = 1;
 				nr++;
 				path->slots[0]--;
@@ -1407,7 +1406,7 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
 	fs_info = block_group->fs_info;
 	root = fs_info->free_space_root;
 
-	end = block_group->key.objectid + block_group->key.offset;
+	end = block_group->start + block_group->length;
 
 	while (1) {
 		ret = btrfs_next_item(root, path);
@@ -1454,7 +1453,7 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
 	if (extent_count != expected_extent_count) {
 		btrfs_err(fs_info,
 			  "incorrect extent count for %llu; counted %u, expected %u",
-			  block_group->key.objectid, extent_count,
+			  block_group->start, extent_count,
 			  expected_extent_count);
 		ASSERT(0);
 		ret = -EIO;
@@ -1485,7 +1484,7 @@ static int load_free_space_extents(struct btrfs_caching_control *caching_ctl,
 	fs_info = block_group->fs_info;
 	root = fs_info->free_space_root;
 
-	end = block_group->key.objectid + block_group->key.offset;
+	end = block_group->start + block_group->length;
 
 	while (1) {
 		ret = btrfs_next_item(root, path);
@@ -1516,7 +1515,7 @@ static int load_free_space_extents(struct btrfs_caching_control *caching_ctl,
 	if (extent_count != expected_extent_count) {
 		btrfs_err(fs_info,
 			  "incorrect extent count for %llu; counted %u, expected %u",
-			  block_group->key.objectid, extent_count,
+			  block_group->start, extent_count,
 			  expected_extent_count);
 		ASSERT(0);
 		ret = -EIO;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c214c3cd5c72..b4ffa232479a 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4038,7 +4038,7 @@ static void get_block_group_info(struct list_head *groups_list,
 	space->flags = 0;
 	list_for_each_entry(block_group, groups_list, list) {
 		space->flags = block_group->flags;
-		space->total_bytes += block_group->key.offset;
+		space->total_bytes += block_group->length;
 		space->used_bytes += block_group->used;
 	}
 }
diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
index 1feaeadc8cf5..907c5d79a197 100644
--- a/fs/btrfs/reada.c
+++ b/fs/btrfs/reada.c
@@ -248,8 +248,8 @@ static struct reada_zone *reada_find_zone(struct btrfs_device *dev, u64 logical,
 	if (!cache)
 		return NULL;
 
-	start = cache->key.objectid;
-	end = start + cache->key.offset - 1;
+	start = cache->start;
+	end = start + cache->length - 1;
 	btrfs_put_block_group(cache);
 
 	zone = kzalloc(sizeof(*zone), GFP_KERNEL);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 77863f7d5179..8f57c086231d 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1563,8 +1563,8 @@ static struct inode *find_next_inode(struct btrfs_root *root, u64 objectid)
 static int in_block_group(u64 bytenr,
 			  struct btrfs_block_group_cache *block_group)
 {
-	if (bytenr >= block_group->key.objectid &&
-	    bytenr < block_group->key.objectid + block_group->key.offset)
+	if (bytenr >= block_group->start &&
+	    bytenr < block_group->start + block_group->length)
 		return 1;
 	return 0;
 }
@@ -3861,7 +3861,7 @@ int find_next_extent(struct reloc_control *rc, struct btrfs_path *path,
 	u64 start, end, last;
 	int ret;
 
-	last = rc->block_group->key.objectid + rc->block_group->key.offset;
+	last = rc->block_group->start + rc->block_group->length;
 	while (1) {
 		cond_resched();
 		if (rc->search_start >= last) {
@@ -3978,7 +3978,7 @@ int prepare_to_relocate(struct reloc_control *rc)
 		return -ENOMEM;
 
 	memset(&rc->cluster, 0, sizeof(rc->cluster));
-	rc->search_start = rc->block_group->key.objectid;
+	rc->search_start = rc->block_group->start;
 	rc->extents_found = 0;
 	rc->nodes_relocated = 0;
 	rc->merging_rsv_size = 0;
@@ -4246,7 +4246,7 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 	key.offset = 0;
 	inode = btrfs_iget(fs_info->sb, &key, root);
 	BUG_ON(IS_ERR(inode));
-	BTRFS_I(inode)->index_cnt = group->key.objectid;
+	BTRFS_I(inode)->index_cnt = group->start;
 
 	err = btrfs_orphan_add(trans, BTRFS_I(inode));
 out:
@@ -4289,7 +4289,7 @@ static void describe_relocation(struct btrfs_fs_info *fs_info,
 
 	btrfs_info(fs_info,
 		   "relocating block group %llu flags %s",
-		   block_group->key.objectid, buf);
+		   block_group->start, buf);
 }
 
 /*
@@ -4362,8 +4362,8 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 	btrfs_wait_block_group_reservations(rc->block_group);
 	btrfs_wait_nocow_writers(rc->block_group);
 	btrfs_wait_ordered_roots(fs_info, U64_MAX,
-				 rc->block_group->key.objectid,
-				 rc->block_group->key.offset);
+				 rc->block_group->start,
+				 rc->block_group->length);
 
 	while (1) {
 		mutex_lock(&fs_info->cleaner_mutex);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 00313a182036..4a5a4e4ef707 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -404,8 +404,8 @@ static u64 get_full_stripe_logical(struct btrfs_block_group_cache *cache,
 	 * round_down() can only handle power of 2, while RAID56 full
 	 * stripe length can be 64KiB * n, so we need to manually round down.
 	 */
-	ret = div64_u64(bytenr - cache->key.objectid, cache->full_stripe_len) *
-		cache->full_stripe_len + cache->key.objectid;
+	ret = div64_u64(bytenr - cache->start, cache->full_stripe_len) *
+			cache->full_stripe_len + cache->start;
 	return ret;
 }
 
@@ -3583,8 +3583,8 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			btrfs_wait_block_group_reservations(cache);
 			btrfs_wait_nocow_writers(cache);
 			ret = btrfs_wait_ordered_roots(fs_info, U64_MAX,
-						       cache->key.objectid,
-						       cache->key.offset);
+						       cache->start,
+						       cache->length);
 			if (ret > 0) {
 				struct btrfs_trans_handle *trans;
 
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 978006ac577f..ec054e5f945a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -301,8 +301,7 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 		spin_lock(&cache->lock);
 		btrfs_info(fs_info,
 			"block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %s",
-			cache->key.objectid, cache->key.offset,
-			cache->used, cache->pinned,
+			cache->start, cache->length, cache->used, cache->pinned,
 			cache->reserved, cache->ro ? "[readonly]" : "");
 		btrfs_dump_free_space(cache, bytes);
 		spin_unlock(&cache->lock);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 2ad3891ff4a5..232a3aa9dbf0 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -379,7 +379,7 @@ static ssize_t raid_bytes_show(struct kobject *kobj,
 	down_read(&sinfo->groups_sem);
 	list_for_each_entry(block_group, &sinfo->block_groups[index], list) {
 		if (&attr->attr == BTRFS_ATTR_PTR(raid, total_bytes))
-			val += block_group->key.offset;
+			val += block_group->length;
 		else
 			val += block_group->used;
 	}
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index 99fe9bf3fdac..f4bb5e2a4ba5 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -218,9 +218,8 @@ btrfs_alloc_dummy_block_group(struct btrfs_fs_info *fs_info,
 		return NULL;
 	}
 
-	cache->key.objectid = 0;
-	cache->key.offset = length;
-	cache->key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+	cache->start = 0;
+	cache->length = length;
 	cache->full_stripe_len = fs_info->sectorsize;
 	cache->fs_info = fs_info;
 
diff --git a/fs/btrfs/tests/free-space-tree-tests.c b/fs/btrfs/tests/free-space-tree-tests.c
index bc92df977630..188f08bd44b0 100644
--- a/fs/btrfs/tests/free-space-tree-tests.c
+++ b/fs/btrfs/tests/free-space-tree-tests.c
@@ -48,7 +48,7 @@ static int __check_free_space_extents(struct btrfs_trans_handle *trans,
 	if (flags & BTRFS_FREE_SPACE_USING_BITMAPS) {
 		if (path->slots[0] != 0)
 			goto invalid;
-		end = cache->key.objectid + cache->key.offset;
+		end = cache->start + cache->length;
 		i = 0;
 		while (++path->slots[0] < btrfs_header_nritems(path->nodes[0])) {
 			btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
@@ -155,7 +155,7 @@ static int test_empty_block_group(struct btrfs_trans_handle *trans,
 				  u32 alignment)
 {
 	const struct free_space_extent extents[] = {
-		{cache->key.objectid, cache->key.offset},
+		{cache->start, cache->length},
 	};
 
 	return check_free_space_extents(trans, fs_info, cache, path,
@@ -172,8 +172,8 @@ static int test_remove_all(struct btrfs_trans_handle *trans,
 	int ret;
 
 	ret = __remove_from_free_space_tree(trans, cache, path,
-					    cache->key.objectid,
-					    cache->key.offset);
+					    cache->start,
+					    cache->length);
 	if (ret) {
 		test_err("could not remove free space");
 		return ret;
@@ -190,13 +190,12 @@ static int test_remove_beginning(struct btrfs_trans_handle *trans,
 				 u32 alignment)
 {
 	const struct free_space_extent extents[] = {
-		{cache->key.objectid + alignment,
-			cache->key.offset - alignment},
+		{cache->start + alignment, cache->length - alignment},
 	};
 	int ret;
 
 	ret = __remove_from_free_space_tree(trans, cache, path,
-					    cache->key.objectid, alignment);
+					    cache->start, alignment);
 	if (ret) {
 		test_err("could not remove free space");
 		return ret;
@@ -214,14 +213,13 @@ static int test_remove_end(struct btrfs_trans_handle *trans,
 			   u32 alignment)
 {
 	const struct free_space_extent extents[] = {
-		{cache->key.objectid, cache->key.offset - alignment},
+		{cache->start, cache->length - alignment},
 	};
 	int ret;
 
 	ret = __remove_from_free_space_tree(trans, cache, path,
-					    cache->key.objectid +
-					    cache->key.offset - alignment,
-					    alignment);
+				    cache->start + cache->length - alignment,
+				    alignment);
 	if (ret) {
 		test_err("could not remove free space");
 		return ret;
@@ -238,14 +236,13 @@ static int test_remove_middle(struct btrfs_trans_handle *trans,
 			      u32 alignment)
 {
 	const struct free_space_extent extents[] = {
-		{cache->key.objectid, alignment},
-		{cache->key.objectid + 2 * alignment,
-			cache->key.offset - 2 * alignment},
+		{cache->start, alignment},
+		{cache->start + 2 * alignment, cache->length - 2 * alignment},
 	};
 	int ret;
 
 	ret = __remove_from_free_space_tree(trans, cache, path,
-					    cache->key.objectid + alignment,
+					    cache->start + alignment,
 					    alignment);
 	if (ret) {
 		test_err("could not remove free space");
@@ -263,19 +260,18 @@ static int test_merge_left(struct btrfs_trans_handle *trans,
 			   u32 alignment)
 {
 	const struct free_space_extent extents[] = {
-		{cache->key.objectid, 2 * alignment},
+		{cache->start, 2 * alignment},
 	};
 	int ret;
 
 	ret = __remove_from_free_space_tree(trans, cache, path,
-					    cache->key.objectid,
-					    cache->key.offset);
+					    cache->start, cache->length);
 	if (ret) {
 		test_err("could not remove free space");
 		return ret;
 	}
 
-	ret = __add_to_free_space_tree(trans, cache, path, cache->key.objectid,
+	ret = __add_to_free_space_tree(trans, cache, path, cache->start,
 				       alignment);
 	if (ret) {
 		test_err("could not add free space");
@@ -283,7 +279,7 @@ static int test_merge_left(struct btrfs_trans_handle *trans,
 	}
 
 	ret = __add_to_free_space_tree(trans, cache, path,
-				       cache->key.objectid + alignment,
+				       cache->start + alignment,
 				       alignment);
 	if (ret) {
 		test_err("could not add free space");
@@ -301,20 +297,19 @@ static int test_merge_right(struct btrfs_trans_handle *trans,
 			   u32 alignment)
 {
 	const struct free_space_extent extents[] = {
-		{cache->key.objectid + alignment, 2 * alignment},
+		{cache->start + alignment, 2 * alignment},
 	};
 	int ret;
 
 	ret = __remove_from_free_space_tree(trans, cache, path,
-					    cache->key.objectid,
-					    cache->key.offset);
+					    cache->start, cache->length);
 	if (ret) {
 		test_err("could not remove free space");
 		return ret;
 	}
 
 	ret = __add_to_free_space_tree(trans, cache, path,
-				       cache->key.objectid + 2 * alignment,
+				       cache->start + 2 * alignment,
 				       alignment);
 	if (ret) {
 		test_err("could not add free space");
@@ -322,7 +317,7 @@ static int test_merge_right(struct btrfs_trans_handle *trans,
 	}
 
 	ret = __add_to_free_space_tree(trans, cache, path,
-				       cache->key.objectid + alignment,
+				       cache->start + alignment,
 				       alignment);
 	if (ret) {
 		test_err("could not add free space");
@@ -340,19 +335,18 @@ static int test_merge_both(struct btrfs_trans_handle *trans,
 			   u32 alignment)
 {
 	const struct free_space_extent extents[] = {
-		{cache->key.objectid, 3 * alignment},
+		{cache->start, 3 * alignment},
 	};
 	int ret;
 
 	ret = __remove_from_free_space_tree(trans, cache, path,
-					    cache->key.objectid,
-					    cache->key.offset);
+					    cache->start, cache->length);
 	if (ret) {
 		test_err("could not remove free space");
 		return ret;
 	}
 
-	ret = __add_to_free_space_tree(trans, cache, path, cache->key.objectid,
+	ret = __add_to_free_space_tree(trans, cache, path, cache->start,
 				       alignment);
 	if (ret) {
 		test_err("could not add free space");
@@ -360,16 +354,14 @@ static int test_merge_both(struct btrfs_trans_handle *trans,
 	}
 
 	ret = __add_to_free_space_tree(trans, cache, path,
-				       cache->key.objectid + 2 * alignment,
-				       alignment);
+				       cache->start + 2 * alignment, alignment);
 	if (ret) {
 		test_err("could not add free space");
 		return ret;
 	}
 
 	ret = __add_to_free_space_tree(trans, cache, path,
-				       cache->key.objectid + alignment,
-				       alignment);
+				       cache->start + alignment, alignment);
 	if (ret) {
 		test_err("could not add free space");
 		return ret;
@@ -386,21 +378,20 @@ static int test_merge_none(struct btrfs_trans_handle *trans,
 			   u32 alignment)
 {
 	const struct free_space_extent extents[] = {
-		{cache->key.objectid, alignment},
-		{cache->key.objectid + 2 * alignment, alignment},
-		{cache->key.objectid + 4 * alignment, alignment},
+		{cache->start, alignment},
+		{cache->start + 2 * alignment, alignment},
+		{cache->start + 4 * alignment, alignment},
 	};
 	int ret;
 
 	ret = __remove_from_free_space_tree(trans, cache, path,
-					    cache->key.objectid,
-					    cache->key.offset);
+					    cache->start, cache->length);
 	if (ret) {
 		test_err("could not remove free space");
 		return ret;
 	}
 
-	ret = __add_to_free_space_tree(trans, cache, path, cache->key.objectid,
+	ret = __add_to_free_space_tree(trans, cache, path, cache->start,
 				       alignment);
 	if (ret) {
 		test_err("could not add free space");
@@ -408,16 +399,14 @@ static int test_merge_none(struct btrfs_trans_handle *trans,
 	}
 
 	ret = __add_to_free_space_tree(trans, cache, path,
-				       cache->key.objectid + 4 * alignment,
-				       alignment);
+				       cache->start + 4 * alignment, alignment);
 	if (ret) {
 		test_err("could not add free space");
 		return ret;
 	}
 
 	ret = __add_to_free_space_tree(trans, cache, path,
-				       cache->key.objectid + 2 * alignment,
-				       alignment);
+				       cache->start + 2 * alignment, alignment);
 	if (ret) {
 		test_err("could not add free space");
 		return ret;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8431ea3b9abf..dc45d65cd296 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3194,16 +3194,16 @@ static int chunk_usage_range_filter(struct btrfs_fs_info *fs_info, u64 chunk_off
 	if (bargs->usage_min == 0)
 		user_thresh_min = 0;
 	else
-		user_thresh_min = div_factor_fine(cache->key.offset,
-					bargs->usage_min);
+		user_thresh_min = div_factor_fine(cache->length,
+						  bargs->usage_min);
 
 	if (bargs->usage_max == 0)
 		user_thresh_max = 1;
 	else if (bargs->usage_max > 100)
-		user_thresh_max = cache->key.offset;
+		user_thresh_max = cache->length;
 	else
-		user_thresh_max = div_factor_fine(cache->key.offset,
-					bargs->usage_max);
+		user_thresh_max = div_factor_fine(cache->length,
+						  bargs->usage_max);
 
 	if (user_thresh_min <= chunk_used && chunk_used < user_thresh_max)
 		ret = 0;
@@ -3225,10 +3225,9 @@ static int chunk_usage_filter(struct btrfs_fs_info *fs_info,
 	if (bargs->usage_min == 0)
 		user_thresh = 1;
 	else if (bargs->usage > 100)
-		user_thresh = cache->key.offset;
+		user_thresh = cache->length;
 	else
-		user_thresh = div_factor_fine(cache->key.offset,
-					      bargs->usage);
+		user_thresh = div_factor_fine(cache->length, bargs->usage);
 
 	if (chunk_used < user_thresh)
 		ret = 0;
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 7b842b049ea3..070619891915 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -713,8 +713,8 @@ TRACE_EVENT(btrfs_add_block_group,
 	),
 
 	TP_fast_assign_btrfs(fs_info,
-		__entry->offset		= block_group->key.objectid;
-		__entry->size		= block_group->key.offset;
+		__entry->offset		= block_group->start;
+		__entry->size		= block_group->length;
 		__entry->flags		= block_group->flags;
 		__entry->bytes_used	= block_group->used;
 		__entry->bytes_super	= block_group->bytes_super;
@@ -1197,7 +1197,7 @@ DECLARE_EVENT_CLASS(btrfs__reserve_extent,
 	),
 
 	TP_fast_assign_btrfs(block_group->fs_info,
-		__entry->bg_objectid	= block_group->key.objectid;
+		__entry->bg_objectid	= block_group->start;
 		__entry->flags		= block_group->flags;
 		__entry->start		= start;
 		__entry->len		= len;
@@ -1245,7 +1245,7 @@ TRACE_EVENT(btrfs_find_cluster,
 	),
 
 	TP_fast_assign_btrfs(block_group->fs_info,
-		__entry->bg_objectid	= block_group->key.objectid;
+		__entry->bg_objectid	= block_group->start;
 		__entry->flags		= block_group->flags;
 		__entry->start		= start;
 		__entry->bytes		= bytes;
@@ -1272,7 +1272,7 @@ TRACE_EVENT(btrfs_failed_cluster_setup,
 	),
 
 	TP_fast_assign_btrfs(block_group->fs_info,
-		__entry->bg_objectid	= block_group->key.objectid;
+		__entry->bg_objectid	= block_group->start;
 	),
 
 	TP_printk_btrfs("block_group=%llu", __entry->bg_objectid)
@@ -1296,7 +1296,7 @@ TRACE_EVENT(btrfs_setup_cluster,
 	),
 
 	TP_fast_assign_btrfs(block_group->fs_info,
-		__entry->bg_objectid	= block_group->key.objectid;
+		__entry->bg_objectid	= block_group->start;
 		__entry->flags		= block_group->flags;
 		__entry->start		= cluster->window_start;
 		__entry->max_size	= cluster->max_size;
@@ -1856,8 +1856,8 @@ DECLARE_EVENT_CLASS(btrfs__block_group,
 	),
 
 	TP_fast_assign_btrfs(bg_cache->fs_info,
-		__entry->bytenr = bg_cache->key.objectid,
-		__entry->len	= bg_cache->key.offset,
+		__entry->bytenr = bg_cache->start,
+		__entry->len	= bg_cache->length,
 		__entry->used	= bg_cache->used;
 		__entry->flags	= bg_cache->flags;
 	),
-- 
2.23.0

