Return-Path: <linux-btrfs+bounces-245-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 037EA7F2E81
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 14:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7240281811
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 13:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB7B524C4;
	Tue, 21 Nov 2023 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLcDi6Ap"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EA5524B3
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 13:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A7DC433CA
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 13:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700573931;
	bh=zLRW/MvhcSbGbDyDj8ApRqUk+Ky0NhK5OBtJdxEBbdM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eLcDi6Ap0ajV30a27WNkRbXgBuE/XwQ5+f88kvse/CzCC+uvqP/3gipaRVW63m33X
	 l0ma0RVjpiTbw7GvA+A7uNfEpPqoqoO6GydyLMRdRFFvngDN56aobnkizhT6iAjasr
	 luh4AF8t/Sf8k2an4V1IcLsIlSWDpGk2iJKIMJbIJWbCYFwLqsjIebQ4Eqq1F6Rvcp
	 oZvhlEGOae1eSJRJegQaqRbWjWTc7UhPGqotBbtO89VRLmVH41Qt0MSuM4CGrCwTtN
	 nDA9NQWW0yicoR86Vrwr6PPoTt7wJ6EQ0czynSjEEY5O4Ou7d3pnI/V6224kJulhc+
	 0qT8h0x7WcwLA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs: use a dedicated data structure for chunk maps
Date: Tue, 21 Nov 2023 13:38:38 +0000
Message-Id: <777320fd09dfc68a89180723bf5d7368dab06299.1700573314.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1700573313.git.fdmanana@suse.com>
References: <cover.1700573313.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently we abuse the extent_map structure for two purposes:

1) To actually represent extents for inodes;
2) To represent chunk mappings.

This is odd and has several disadvantages:

1) To create a chunk map, we need to do two memory allocations: one for
   an extent_map structure and another one for a map_lookup structure, so
   more potential for an allocation failure and more complicated code to
   manage and link two structures;

2) For a chunk map we actually only use 3 fields (24 bytes) of the
   respective extent map structure: the 'start' field to have the logical
   start address of the chunk, the 'len' field to have the chunk's size,
   and the 'orig_block_len' field to contain the chunk's stripe size.

   Besides wasting a memory, it's also odd and not intuitive at all to
   have the stripe size in a field named 'orig_block_len'.

   We are also using 'block_len' of the extent_map structure to contain
   the chunk size, so we have 2 fields for the same value, 'len' and
   'block_len', which is pointless;

3) When an extent map is associated to a chunk mapping, we set the bit
   EXTENT_FLAG_FS_MAPPING on its flags and then make its member named
   'map_lookup' point to the associated map_lookup structure. This means
   that for an extent map associated to an inode extent, we are not using
   this 'map_lookup' pointer, so wasting 8 bytes (on a 64 bits platform);

4) Extent maps associated to a chunk mapping are never merged or split so
   it's pointless to use the existing extent map infrastructure.

So add a dedicated data structure named 'btrfs_chunk_map' to represent
chunk mappings, this is basically the existing map_lookup structure with
some extra fields:

1) 'start' to contain the chunk logical address;
2) 'chunk_len' to contain the chunk's length;
3) 'stripe_size' for the stripe size;
4) 'rb_node' for insertion into a rb tree;
5) 'refs' for reference counting.

This way we do a single memory allocation for chunk mappings and we don't
waste memory for them with unused/unnecessary fields from an extent_map.

We also save 8 bytes from the extent_map structure by removing the
'map_lookup' pointer, so the size of struct extent_map is reduced from
144 bytes down to 136 bytes, and we can now have 30 extents map per 4K
page instead of 28.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c            | 165 ++++-----
 fs/btrfs/block-group.h            |   6 +-
 fs/btrfs/dev-replace.c            |  28 +-
 fs/btrfs/disk-io.c                |   7 +-
 fs/btrfs/extent_map.c             |  46 ---
 fs/btrfs/extent_map.h             |   4 -
 fs/btrfs/fs.h                     |   3 +-
 fs/btrfs/inode.c                  |  25 +-
 fs/btrfs/raid56.h                 |   2 +-
 fs/btrfs/scrub.c                  |  39 +--
 fs/btrfs/tests/btrfs-tests.c      |   3 +-
 fs/btrfs/tests/btrfs-tests.h      |   1 +
 fs/btrfs/tests/extent-map-tests.c |  40 +--
 fs/btrfs/volumes.c                | 540 ++++++++++++++++++------------
 fs/btrfs/volumes.h                |  45 ++-
 fs/btrfs/zoned.c                  |  24 +-
 include/trace/events/btrfs.h      |  11 +-
 17 files changed, 501 insertions(+), 488 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index fca653cc977c..0fea258eea15 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -168,7 +168,7 @@ void btrfs_put_block_group(struct btrfs_block_group *cache)
 						  cache);
 
 		kfree(cache->free_space_ctl);
-		kfree(cache->physical_map);
+		btrfs_free_chunk_map(cache->physical_map);
 		kfree(cache);
 	}
 }
@@ -1047,7 +1047,7 @@ static int remove_block_group_item(struct btrfs_trans_handle *trans,
 }
 
 int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
-			     u64 group_start, struct extent_map *em)
+			     struct btrfs_chunk_map *map)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_path *path;
@@ -1059,10 +1059,10 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	int index;
 	int factor;
 	struct btrfs_caching_control *caching_ctl = NULL;
-	bool remove_em;
+	bool remove_map;
 	bool remove_rsv = false;
 
-	block_group = btrfs_lookup_block_group(fs_info, group_start);
+	block_group = btrfs_lookup_block_group(fs_info, map->start);
 	BUG_ON(!block_group);
 	BUG_ON(!block_group->ro);
 
@@ -1252,7 +1252,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	 * entries because we already removed them all when we called
 	 * btrfs_remove_free_space_cache().
 	 *
-	 * And we must not remove the extent map from the fs_info->mapping_tree
+	 * And we must not remove the chunk map from the fs_info->mapping_tree
 	 * to prevent the same logical address range and physical device space
 	 * ranges from being reused for a new block group. This is needed to
 	 * avoid races with trimming and scrub.
@@ -1268,19 +1268,11 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	 * in place until the extents have been discarded completely when
 	 * the transaction commit has completed.
 	 */
-	remove_em = (atomic_read(&block_group->frozen) == 0);
+	remove_map = (atomic_read(&block_group->frozen) == 0);
 	spin_unlock(&block_group->lock);
 
-	if (remove_em) {
-		struct extent_map_tree *em_tree;
-
-		em_tree = &fs_info->mapping_tree;
-		write_lock(&em_tree->lock);
-		remove_extent_mapping(em_tree, em);
-		write_unlock(&em_tree->lock);
-		/* once for the tree */
-		free_extent_map(em);
-	}
+	if (remove_map)
+		btrfs_remove_chunk_map(fs_info, map);
 
 out:
 	/* Once for the lookup reference */
@@ -1295,16 +1287,12 @@ struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
 		struct btrfs_fs_info *fs_info, const u64 chunk_offset)
 {
 	struct btrfs_root *root = btrfs_block_group_root(fs_info);
-	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
-	struct extent_map *em;
-	struct map_lookup *map;
+	struct btrfs_chunk_map *map;
 	unsigned int num_items;
 
-	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, chunk_offset, 1);
-	read_unlock(&em_tree->lock);
-	ASSERT(em != NULL);
-	ASSERT(em->start == chunk_offset);
+	map = btrfs_find_chunk_map(fs_info, chunk_offset, 1);
+	ASSERT(map != NULL);
+	ASSERT(map->start == chunk_offset);
 
 	/*
 	 * We need to reserve 3 + N units from the metadata space info in order
@@ -1325,9 +1313,8 @@ struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
 	 * more device items and remove one chunk item), but this is done at
 	 * btrfs_remove_chunk() through a call to check_system_chunk().
 	 */
-	map = em->map_lookup;
 	num_items = 3 + map->num_stripes;
-	free_extent_map(em);
+	btrfs_free_chunk_map(map);
 
 	return btrfs_start_transaction_fallback_global_rsv(root, num_items);
 }
@@ -1928,8 +1915,7 @@ void btrfs_mark_bg_to_reclaim(struct btrfs_block_group *bg)
 static int read_bg_from_eb(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
 			   struct btrfs_path *path)
 {
-	struct extent_map_tree *em_tree;
-	struct extent_map *em;
+	struct btrfs_chunk_map *map;
 	struct btrfs_block_group_item bg;
 	struct extent_buffer *leaf;
 	int slot;
@@ -1939,23 +1925,20 @@ static int read_bg_from_eb(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
 	slot = path->slots[0];
 	leaf = path->nodes[0];
 
-	em_tree = &fs_info->mapping_tree;
-	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, key->objectid, key->offset);
-	read_unlock(&em_tree->lock);
-	if (!em) {
+	map = btrfs_find_chunk_map(fs_info, key->objectid, key->offset);
+	if (!map) {
 		btrfs_err(fs_info,
 			  "logical %llu len %llu found bg but no related chunk",
 			  key->objectid, key->offset);
 		return -ENOENT;
 	}
 
-	if (em->start != key->objectid || em->len != key->offset) {
+	if (map->start != key->objectid || map->chunk_len != key->offset) {
 		btrfs_err(fs_info,
 			"block group %llu len %llu mismatch with chunk %llu len %llu",
-			key->objectid, key->offset, em->start, em->len);
+			  key->objectid, key->offset, map->start, map->chunk_len);
 		ret = -EUCLEAN;
-		goto out_free_em;
+		goto out_free_map;
 	}
 
 	read_extent_buffer(leaf, &bg, btrfs_item_ptr_offset(leaf, slot),
@@ -1963,16 +1946,16 @@ static int read_bg_from_eb(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
 	flags = btrfs_stack_block_group_flags(&bg) &
 		BTRFS_BLOCK_GROUP_TYPE_MASK;
 
-	if (flags != (em->map_lookup->type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
+	if (flags != (map->type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
 		btrfs_err(fs_info,
 "block group %llu len %llu type flags 0x%llx mismatch with chunk type flags 0x%llx",
 			  key->objectid, key->offset, flags,
-			  (BTRFS_BLOCK_GROUP_TYPE_MASK & em->map_lookup->type));
+			  (BTRFS_BLOCK_GROUP_TYPE_MASK & map->type));
 		ret = -EUCLEAN;
 	}
 
-out_free_em:
-	free_extent_map(em);
+out_free_map:
+	btrfs_free_chunk_map(map);
 	return ret;
 }
 
@@ -2025,8 +2008,7 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
 int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 		     u64 physical, u64 **logical, int *naddrs, int *stripe_len)
 {
-	struct extent_map *em;
-	struct map_lookup *map;
+	struct btrfs_chunk_map *map;
 	u64 *buf;
 	u64 bytenr;
 	u64 data_stripe_length;
@@ -2034,14 +2016,13 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 	int i, nr = 0;
 	int ret = 0;
 
-	em = btrfs_get_chunk_map(fs_info, chunk_start, 1);
-	if (IS_ERR(em))
+	map = btrfs_get_chunk_map(fs_info, chunk_start, 1);
+	if (IS_ERR(map))
 		return -EIO;
 
-	map = em->map_lookup;
-	data_stripe_length = em->orig_block_len;
+	data_stripe_length = map->stripe_size;
 	io_stripe_size = BTRFS_STRIPE_LEN;
-	chunk_start = em->start;
+	chunk_start = map->start;
 
 	/* For RAID5/6 adjust to a full IO stripe length */
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
@@ -2095,7 +2076,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 	*naddrs = nr;
 	*stripe_len = io_stripe_size;
 out:
-	free_extent_map(em);
+	btrfs_free_chunk_map(map);
 	return ret;
 }
 
@@ -2200,49 +2181,47 @@ static struct btrfs_block_group *btrfs_create_block_group_cache(
  */
 static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
 {
-	struct extent_map_tree *map_tree = &fs_info->mapping_tree;
-	struct extent_map *em;
-	struct btrfs_block_group *bg;
 	u64 start = 0;
 	int ret = 0;
 
 	while (1) {
-		read_lock(&map_tree->lock);
+		struct btrfs_chunk_map *map;
+		struct btrfs_block_group *bg;
+
 		/*
-		 * lookup_extent_mapping will return the first extent map
-		 * intersecting the range, so setting @len to 1 is enough to
+		 * btrfs_find_chunk_map() will return the first chunk map
+		 * intersecting the range, so setting @length to 1 is enough to
 		 * get the first chunk.
 		 */
-		em = lookup_extent_mapping(map_tree, start, 1);
-		read_unlock(&map_tree->lock);
-		if (!em)
+		map = btrfs_find_chunk_map(fs_info, start, 1);
+		if (!map)
 			break;
 
-		bg = btrfs_lookup_block_group(fs_info, em->start);
+		bg = btrfs_lookup_block_group(fs_info, map->start);
 		if (!bg) {
 			btrfs_err(fs_info,
 	"chunk start=%llu len=%llu doesn't have corresponding block group",
-				     em->start, em->len);
+				     map->start, map->chunk_len);
 			ret = -EUCLEAN;
-			free_extent_map(em);
+			btrfs_free_chunk_map(map);
 			break;
 		}
-		if (bg->start != em->start || bg->length != em->len ||
+		if (bg->start != map->start || bg->length != map->chunk_len ||
 		    (bg->flags & BTRFS_BLOCK_GROUP_TYPE_MASK) !=
-		    (em->map_lookup->type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
+		    (map->type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
 			btrfs_err(fs_info,
 "chunk start=%llu len=%llu flags=0x%llx doesn't match block group start=%llu len=%llu flags=0x%llx",
-				em->start, em->len,
-				em->map_lookup->type & BTRFS_BLOCK_GROUP_TYPE_MASK,
+				map->start, map->chunk_len,
+				map->type & BTRFS_BLOCK_GROUP_TYPE_MASK,
 				bg->start, bg->length,
 				bg->flags & BTRFS_BLOCK_GROUP_TYPE_MASK);
 			ret = -EUCLEAN;
-			free_extent_map(em);
+			btrfs_free_chunk_map(map);
 			btrfs_put_block_group(bg);
 			break;
 		}
-		start = em->start + em->len;
-		free_extent_map(em);
+		start = map->start + map->chunk_len;
+		btrfs_free_chunk_map(map);
 		btrfs_put_block_group(bg);
 	}
 	return ret;
@@ -2370,28 +2349,25 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 
 static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
 {
-	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
 	struct rb_node *node;
 	int ret = 0;
 
-	for (node = rb_first_cached(&em_tree->map); node; node = rb_next(node)) {
-		struct extent_map *em;
-		struct map_lookup *map;
+	for (node = rb_first_cached(&fs_info->mapping_tree); node; node = rb_next(node)) {
+		struct btrfs_chunk_map *map;
 		struct btrfs_block_group *bg;
 
-		em = rb_entry(node, struct extent_map, rb_node);
-		map = em->map_lookup;
-		bg = btrfs_create_block_group_cache(fs_info, em->start);
+		map = rb_entry(node, struct btrfs_chunk_map, rb_node);
+		bg = btrfs_create_block_group_cache(fs_info, map->start);
 		if (!bg) {
 			ret = -ENOMEM;
 			break;
 		}
 
 		/* Fill dummy cache as FULL */
-		bg->length = em->len;
+		bg->length = map->chunk_len;
 		bg->flags = map->type;
 		bg->cached = BTRFS_CACHE_FINISHED;
-		bg->used = em->len;
+		bg->used = map->chunk_len;
 		bg->flags = map->type;
 		ret = btrfs_add_block_group_cache(fs_info, bg);
 		/*
@@ -2619,19 +2595,17 @@ static int insert_dev_extents(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_device *device;
-	struct extent_map *em;
-	struct map_lookup *map;
+	struct btrfs_chunk_map *map;
 	u64 dev_offset;
 	u64 stripe_size;
 	int i;
 	int ret = 0;
 
-	em = btrfs_get_chunk_map(fs_info, chunk_offset, chunk_size);
-	if (IS_ERR(em))
-		return PTR_ERR(em);
+	map = btrfs_get_chunk_map(fs_info, chunk_offset, chunk_size);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
 
-	map = em->map_lookup;
-	stripe_size = em->orig_block_len;
+	stripe_size = map->stripe_size;
 
 	/*
 	 * Take the device list mutex to prevent races with the final phase of
@@ -2654,7 +2628,7 @@ static int insert_dev_extents(struct btrfs_trans_handle *trans,
 	}
 	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 
-	free_extent_map(em);
+	btrfs_free_chunk_map(map);
 	return ret;
 }
 
@@ -4407,8 +4381,6 @@ void btrfs_freeze_block_group(struct btrfs_block_group *cache)
 void btrfs_unfreeze_block_group(struct btrfs_block_group *block_group)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
-	struct extent_map_tree *em_tree;
-	struct extent_map *em;
 	bool cleanup;
 
 	spin_lock(&block_group->lock);
@@ -4417,17 +4389,16 @@ void btrfs_unfreeze_block_group(struct btrfs_block_group *block_group)
 	spin_unlock(&block_group->lock);
 
 	if (cleanup) {
-		em_tree = &fs_info->mapping_tree;
-		write_lock(&em_tree->lock);
-		em = lookup_extent_mapping(em_tree, block_group->start,
-					   1);
-		BUG_ON(!em); /* logic error, can't happen */
-		remove_extent_mapping(em_tree, em);
-		write_unlock(&em_tree->lock);
-
-		/* once for us and once for the tree */
-		free_extent_map(em);
-		free_extent_map(em);
+		struct btrfs_chunk_map *map;
+
+		map = btrfs_find_chunk_map(fs_info, block_group->start, 1);
+		/* Logic error, can't happen. */
+		ASSERT(map);
+
+		btrfs_remove_chunk_map(fs_info, map);
+
+		/* Once for our lookup reference. */
+		btrfs_free_chunk_map(map);
 
 		/*
 		 * We may have left one free space entry and other possible
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 2bdbcb834f95..c4a1f01cc1c2 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -5,6 +5,8 @@
 
 #include "free-space-cache.h"
 
+struct btrfs_chunk_map;
+
 enum btrfs_disk_cache_state {
 	BTRFS_DC_WRITTEN,
 	BTRFS_DC_ERROR,
@@ -243,7 +245,7 @@ struct btrfs_block_group {
 	u64 zone_unusable;
 	u64 zone_capacity;
 	u64 meta_write_pointer;
-	struct map_lookup *physical_map;
+	struct btrfs_chunk_map *physical_map;
 	struct list_head active_bg_list;
 	struct work_struct zone_finish_work;
 	struct extent_buffer *last_eb;
@@ -297,7 +299,7 @@ struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
 				struct btrfs_fs_info *fs_info,
 				const u64 chunk_offset);
 int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
-			     u64 group_start, struct extent_map *em);
+			     struct btrfs_chunk_map *map);
 void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info);
 void btrfs_mark_bg_unused(struct btrfs_block_group *bg);
 void btrfs_reclaim_bgs_work(struct work_struct *work);
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index d3998cad62c2..38811493f74f 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -548,8 +548,7 @@ bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
 				      u64 physical)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
-	struct extent_map *em;
-	struct map_lookup *map;
+	struct btrfs_chunk_map *map;
 	u64 chunk_offset = cache->start;
 	int num_extents, cur_extent;
 	int i;
@@ -565,9 +564,8 @@ bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
 	}
 	spin_unlock(&cache->lock);
 
-	em = btrfs_get_chunk_map(fs_info, chunk_offset, 1);
-	ASSERT(!IS_ERR(em));
-	map = em->map_lookup;
+	map = btrfs_get_chunk_map(fs_info, chunk_offset, 1);
+	ASSERT(!IS_ERR(map));
 
 	num_extents = 0;
 	cur_extent = 0;
@@ -581,7 +579,7 @@ bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
 			cur_extent = i;
 	}
 
-	free_extent_map(em);
+	btrfs_free_chunk_map(map);
 
 	if (num_extents > 1 && cur_extent < num_extents - 1) {
 		/*
@@ -810,25 +808,23 @@ static void btrfs_dev_replace_update_device_in_mapping_tree(
 						struct btrfs_device *srcdev,
 						struct btrfs_device *tgtdev)
 {
-	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
-	struct extent_map *em;
-	struct map_lookup *map;
 	u64 start = 0;
 	int i;
 
-	write_lock(&em_tree->lock);
+	write_lock(&fs_info->mapping_tree_lock);
 	do {
-		em = lookup_extent_mapping(em_tree, start, (u64)-1);
-		if (!em)
+		struct btrfs_chunk_map *map;
+
+		map = btrfs_find_chunk_map_nolock(fs_info, start, U64_MAX);
+		if (!map)
 			break;
-		map = em->map_lookup;
 		for (i = 0; i < map->num_stripes; i++)
 			if (srcdev == map->stripes[i].dev)
 				map->stripes[i].dev = tgtdev;
-		start = em->start + em->len;
-		free_extent_map(em);
+		start = map->start + map->chunk_len;
+		btrfs_free_chunk_map(map);
 	} while (start);
-	write_unlock(&em_tree->lock);
+	write_unlock(&fs_info->mapping_tree_lock);
 }
 
 static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 350e1b02cc8e..e34d05c0d305 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2720,7 +2720,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	INIT_LIST_HEAD(&fs_info->allocated_ebs);
 	spin_lock_init(&fs_info->eb_leak_lock);
 #endif
-	extent_map_tree_init(&fs_info->mapping_tree);
+	fs_info->mapping_tree = RB_ROOT_CACHED;
+	rwlock_init(&fs_info->mapping_tree_lock);
 	btrfs_init_block_rsv(&fs_info->global_block_rsv,
 			     BTRFS_BLOCK_RSV_GLOBAL);
 	btrfs_init_block_rsv(&fs_info->trans_block_rsv, BTRFS_BLOCK_RSV_TRANS);
@@ -3603,7 +3604,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	btrfs_stop_all_workers(fs_info);
 	btrfs_free_block_groups(fs_info);
 fail_alloc:
-	btrfs_mapping_tree_free(&fs_info->mapping_tree);
+	btrfs_mapping_tree_free(fs_info);
 
 	iput(fs_info->btree_inode);
 fail:
@@ -4386,7 +4387,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 
 	iput(fs_info->btree_inode);
 
-	btrfs_mapping_tree_free(&fs_info->mapping_tree);
+	btrfs_mapping_tree_free(fs_info);
 	btrfs_close_devices(fs_info->fs_devices);
 }
 
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index bced39dc0da8..c956b1ced69f 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -67,8 +67,6 @@ void free_extent_map(struct extent_map *em)
 	if (refcount_dec_and_test(&em->refs)) {
 		WARN_ON(extent_map_in_tree(em));
 		WARN_ON(!list_empty(&em->list));
-		if (test_bit(EXTENT_FLAG_FS_MAPPING, &em->flags))
-			kfree(em->map_lookup);
 		kmem_cache_free(extent_map_cache, em);
 	}
 }
@@ -217,13 +215,8 @@ static int mergable_maps(struct extent_map *prev, struct extent_map *next)
 	ASSERT(next->block_start != EXTENT_MAP_DELALLOC &&
 	       prev->block_start != EXTENT_MAP_DELALLOC);
 
-	if (prev->map_lookup || next->map_lookup)
-		ASSERT(test_bit(EXTENT_FLAG_FS_MAPPING, &prev->flags) &&
-		       test_bit(EXTENT_FLAG_FS_MAPPING, &next->flags));
-
 	if (extent_map_end(prev) == next->start &&
 	    prev->flags == next->flags &&
-	    prev->map_lookup == next->map_lookup &&
 	    ((next->block_start == EXTENT_MAP_HOLE &&
 	      prev->block_start == EXTENT_MAP_HOLE) ||
 	     (next->block_start == EXTENT_MAP_INLINE &&
@@ -361,39 +354,6 @@ static inline void setup_extent_mapping(struct extent_map_tree *tree,
 		try_merge_map(tree, em);
 }
 
-static void extent_map_device_set_bits(struct extent_map *em, unsigned bits)
-{
-	struct map_lookup *map = em->map_lookup;
-	u64 stripe_size = em->orig_block_len;
-	int i;
-
-	for (i = 0; i < map->num_stripes; i++) {
-		struct btrfs_io_stripe *stripe = &map->stripes[i];
-		struct btrfs_device *device = stripe->dev;
-
-		set_extent_bit(&device->alloc_state, stripe->physical,
-			       stripe->physical + stripe_size - 1,
-			       bits | EXTENT_NOWAIT, NULL);
-	}
-}
-
-static void extent_map_device_clear_bits(struct extent_map *em, unsigned bits)
-{
-	struct map_lookup *map = em->map_lookup;
-	u64 stripe_size = em->orig_block_len;
-	int i;
-
-	for (i = 0; i < map->num_stripes; i++) {
-		struct btrfs_io_stripe *stripe = &map->stripes[i];
-		struct btrfs_device *device = stripe->dev;
-
-		__clear_extent_bit(&device->alloc_state, stripe->physical,
-				   stripe->physical + stripe_size - 1,
-				   bits | EXTENT_NOWAIT,
-				   NULL, NULL);
-	}
-}
-
 /*
  * Add new extent map to the extent tree
  *
@@ -419,10 +379,6 @@ int add_extent_mapping(struct extent_map_tree *tree,
 		goto out;
 
 	setup_extent_mapping(tree, em, modified);
-	if (test_bit(EXTENT_FLAG_FS_MAPPING, &em->flags)) {
-		extent_map_device_set_bits(em, CHUNK_ALLOCATED);
-		extent_map_device_clear_bits(em, CHUNK_TRIMMED);
-	}
 out:
 	return ret;
 }
@@ -506,8 +462,6 @@ void remove_extent_mapping(struct extent_map_tree *tree, struct extent_map *em)
 	rb_erase_cached(&em->rb_node, &tree->map);
 	if (!test_bit(EXTENT_FLAG_LOGGING, &em->flags))
 		list_del_init(&em->list);
-	if (test_bit(EXTENT_FLAG_FS_MAPPING, &em->flags))
-		extent_map_device_clear_bits(em, CHUNK_ALLOCATED);
 	RB_CLEAR_NODE(&em->rb_node);
 }
 
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index d0328127f89c..bae14af197ef 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -23,8 +23,6 @@ enum {
 	EXTENT_FLAG_LOGGING,
 	/* Filling in a preallocated extent */
 	EXTENT_FLAG_FILLING,
-	/* filesystem extent mapping type */
-	EXTENT_FLAG_FS_MAPPING,
 	/* This em is merged from two or more physically adjacent ems */
 	EXTENT_FLAG_MERGED,
 };
@@ -50,8 +48,6 @@ struct extent_map {
 	 */
 	u64 generation;
 	unsigned long flags;
-	/* Used for chunk mappings, flag EXTENT_FLAG_FS_MAPPING must be set */
-	struct map_lookup *map_lookup;
 	refcount_t refs;
 	unsigned int compress_type;
 	struct list_head list;
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 318df6f9d9cb..a3debac2819a 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -398,7 +398,8 @@ struct btrfs_fs_info {
 	struct extent_io_tree excluded_extents;
 
 	/* logical->physical extent mapping */
-	struct extent_map_tree mapping_tree;
+	struct rb_root_cached mapping_tree;
+	rwlock_t mapping_tree_lock;
 
 	/*
 	 * Block reservation for extent, checksum, root tree and delayed dir
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 137c4824ff91..66111600b61d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10560,6 +10560,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct extent_state *cached_state = NULL;
 	struct extent_map *em = NULL;
+	struct btrfs_chunk_map *map = NULL;
 	struct btrfs_device *device = NULL;
 	struct btrfs_swap_info bsi = {
 		.lowest_ppage = (sector_t)-1ULL,
@@ -10699,13 +10700,13 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 			goto out;
 		}
 
-		em = btrfs_get_chunk_map(fs_info, logical_block_start, len);
-		if (IS_ERR(em)) {
-			ret = PTR_ERR(em);
+		map = btrfs_get_chunk_map(fs_info, logical_block_start, len);
+		if (IS_ERR(map)) {
+			ret = PTR_ERR(map);
 			goto out;
 		}
 
-		if (em->map_lookup->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
+		if (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
 			btrfs_warn(fs_info,
 				   "swapfile must have single data profile");
 			ret = -EINVAL;
@@ -10713,23 +10714,23 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		}
 
 		if (device == NULL) {
-			device = em->map_lookup->stripes[0].dev;
+			device = map->stripes[0].dev;
 			ret = btrfs_add_swapfile_pin(inode, device, false);
 			if (ret == 1)
 				ret = 0;
 			else if (ret)
 				goto out;
-		} else if (device != em->map_lookup->stripes[0].dev) {
+		} else if (device != map->stripes[0].dev) {
 			btrfs_warn(fs_info, "swapfile must be on one device");
 			ret = -EINVAL;
 			goto out;
 		}
 
-		physical_block_start = (em->map_lookup->stripes[0].physical +
-					(logical_block_start - em->start));
-		len = min(len, em->len - (logical_block_start - em->start));
-		free_extent_map(em);
-		em = NULL;
+		physical_block_start = (map->stripes[0].physical +
+					(logical_block_start - map->start));
+		len = min(len, map->chunk_len - (logical_block_start - map->start));
+		btrfs_free_chunk_map(map);
+		map = NULL;
 
 		bg = btrfs_lookup_block_group(fs_info, logical_block_start);
 		if (!bg) {
@@ -10782,6 +10783,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 out:
 	if (!IS_ERR_OR_NULL(em))
 		free_extent_map(em);
+	if (!IS_ERR_OR_NULL(map))
+		btrfs_free_chunk_map(map);
 
 	unlock_extent(io_tree, 0, isize - 1, &cached_state);
 
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 45e6ff78316f..470213688872 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -164,7 +164,7 @@ struct raid56_bio_trace_info {
 	u8 stripe_nr;
 };
 
-static inline int nr_data_stripes(const struct map_lookup *map)
+static inline int nr_data_stripes(const struct btrfs_chunk_map *map)
 {
 	return map->num_stripes - btrfs_nr_parity_stripes(map->type);
 }
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 63ac78006f1c..71311ac14e4b 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1280,7 +1280,7 @@ static void scrub_throttle_dev_io(struct scrub_ctx *sctx, struct btrfs_device *d
  * return 0 if it is a data stripe, 1 means parity stripe.
  */
 static int get_raid56_logic_offset(u64 physical, int num,
-				   struct map_lookup *map, u64 *offset,
+				   struct btrfs_chunk_map *map, u64 *offset,
 				   u64 *stripe_start)
 {
 	int i;
@@ -1893,7 +1893,7 @@ static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *
 static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 				      struct btrfs_device *scrub_dev,
 				      struct btrfs_block_group *bg,
-				      struct map_lookup *map,
+				      struct btrfs_chunk_map *map,
 				      u64 full_stripe_start)
 {
 	DECLARE_COMPLETION_ONSTACK(io_done);
@@ -2062,7 +2062,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
  */
 static int scrub_simple_mirror(struct scrub_ctx *sctx,
 			       struct btrfs_block_group *bg,
-			       struct map_lookup *map,
+			       struct btrfs_chunk_map *map,
 			       u64 logical_start, u64 logical_length,
 			       struct btrfs_device *device,
 			       u64 physical, int mirror_num)
@@ -2121,7 +2121,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 }
 
 /* Calculate the full stripe length for simple stripe based profiles */
-static u64 simple_stripe_full_stripe_len(const struct map_lookup *map)
+static u64 simple_stripe_full_stripe_len(const struct btrfs_chunk_map *map)
 {
 	ASSERT(map->type & (BTRFS_BLOCK_GROUP_RAID0 |
 			    BTRFS_BLOCK_GROUP_RAID10));
@@ -2130,7 +2130,7 @@ static u64 simple_stripe_full_stripe_len(const struct map_lookup *map)
 }
 
 /* Get the logical bytenr for the stripe */
-static u64 simple_stripe_get_logical(struct map_lookup *map,
+static u64 simple_stripe_get_logical(struct btrfs_chunk_map *map,
 				     struct btrfs_block_group *bg,
 				     int stripe_index)
 {
@@ -2147,7 +2147,7 @@ static u64 simple_stripe_get_logical(struct map_lookup *map,
 }
 
 /* Get the mirror number for the stripe */
-static int simple_stripe_mirror_num(struct map_lookup *map, int stripe_index)
+static int simple_stripe_mirror_num(struct btrfs_chunk_map *map, int stripe_index)
 {
 	ASSERT(map->type & (BTRFS_BLOCK_GROUP_RAID0 |
 			    BTRFS_BLOCK_GROUP_RAID10));
@@ -2159,7 +2159,7 @@ static int simple_stripe_mirror_num(struct map_lookup *map, int stripe_index)
 
 static int scrub_simple_stripe(struct scrub_ctx *sctx,
 			       struct btrfs_block_group *bg,
-			       struct map_lookup *map,
+			       struct btrfs_chunk_map *map,
 			       struct btrfs_device *device,
 			       int stripe_index)
 {
@@ -2192,18 +2192,17 @@ static int scrub_simple_stripe(struct scrub_ctx *sctx,
 
 static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   struct btrfs_block_group *bg,
-					   struct extent_map *em,
+					   struct btrfs_chunk_map *map,
 					   struct btrfs_device *scrub_dev,
 					   int stripe_index)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	struct map_lookup *map = em->map_lookup;
 	const u64 profile = map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK;
 	const u64 chunk_logical = bg->start;
 	int ret;
 	int ret2;
 	u64 physical = map->stripes[stripe_index].physical;
-	const u64 dev_stripe_len = btrfs_calc_stripe_length(em);
+	const u64 dev_stripe_len = btrfs_calc_stripe_length(map);
 	const u64 physical_end = physical + dev_stripe_len;
 	u64 logical;
 	u64 logic_end;
@@ -2366,17 +2365,12 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
 					  u64 dev_extent_len)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	struct extent_map_tree *map_tree = &fs_info->mapping_tree;
-	struct map_lookup *map;
-	struct extent_map *em;
+	struct btrfs_chunk_map *map;
 	int i;
 	int ret = 0;
 
-	read_lock(&map_tree->lock);
-	em = lookup_extent_mapping(map_tree, bg->start, bg->length);
-	read_unlock(&map_tree->lock);
-
-	if (!em) {
+	map = btrfs_find_chunk_map(fs_info, bg->start, bg->length);
+	if (!map) {
 		/*
 		 * Might have been an unused block group deleted by the cleaner
 		 * kthread or relocation.
@@ -2388,22 +2382,21 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
 
 		return ret;
 	}
-	if (em->start != bg->start)
+	if (map->start != bg->start)
 		goto out;
-	if (em->len < dev_extent_len)
+	if (map->chunk_len < dev_extent_len)
 		goto out;
 
-	map = em->map_lookup;
 	for (i = 0; i < map->num_stripes; ++i) {
 		if (map->stripes[i].dev->bdev == scrub_dev->bdev &&
 		    map->stripes[i].physical == dev_offset) {
-			ret = scrub_stripe(sctx, bg, em, scrub_dev, i);
+			ret = scrub_stripe(sctx, bg, map, scrub_dev, i);
 			if (ret)
 				goto out;
 		}
 	}
 out:
-	free_extent_map(em);
+	btrfs_free_chunk_map(map);
 
 	return ret;
 }
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index ca09cf9afce8..b50cfac7ad4e 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -28,6 +28,7 @@ const char *test_error[] = {
 	[TEST_ALLOC_INODE]	     = "cannot allocate inode",
 	[TEST_ALLOC_BLOCK_GROUP]     = "cannot allocate block group",
 	[TEST_ALLOC_EXTENT_MAP]      = "cannot allocate extent map",
+	[TEST_ALLOC_CHUNK_MAP]       = "cannot allocate chunk map",
 };
 
 static const struct super_operations btrfs_test_super_ops = {
@@ -185,7 +186,7 @@ void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
 	}
 	spin_unlock(&fs_info->buffer_lock);
 
-	btrfs_mapping_tree_free(&fs_info->mapping_tree);
+	btrfs_mapping_tree_free(fs_info);
 	list_for_each_entry_safe(dev, tmp, &fs_info->fs_devices->devices,
 				 dev_list) {
 		btrfs_free_dummy_device(dev);
diff --git a/fs/btrfs/tests/btrfs-tests.h b/fs/btrfs/tests/btrfs-tests.h
index 7a2d7ffbe30e..dc2f2ab15fa5 100644
--- a/fs/btrfs/tests/btrfs-tests.h
+++ b/fs/btrfs/tests/btrfs-tests.h
@@ -23,6 +23,7 @@ enum {
 	TEST_ALLOC_INODE,
 	TEST_ALLOC_BLOCK_GROUP,
 	TEST_ALLOC_EXTENT_MAP,
+	TEST_ALLOC_CHUNK_MAP,
 };
 
 extern const char *test_error[];
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 29bdd08b241f..8602f94cc29d 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -859,33 +859,21 @@ struct rmap_test_vector {
 static int test_rmap_block(struct btrfs_fs_info *fs_info,
 			   struct rmap_test_vector *test)
 {
-	struct extent_map *em;
-	struct map_lookup *map = NULL;
+	struct btrfs_chunk_map *map;
 	u64 *logical = NULL;
 	int i, out_ndaddrs, out_stripe_len;
 	int ret;
 
-	em = alloc_extent_map();
-	if (!em) {
-		test_std_err(TEST_ALLOC_EXTENT_MAP);
-		return -ENOMEM;
-	}
-
-	map = kmalloc(map_lookup_size(test->num_stripes), GFP_KERNEL);
+	map = btrfs_alloc_chunk_map(test->num_stripes, GFP_KERNEL);
 	if (!map) {
-		kfree(em);
-		test_std_err(TEST_ALLOC_EXTENT_MAP);
+		test_std_err(TEST_ALLOC_CHUNK_MAP);
 		return -ENOMEM;
 	}
 
-	set_bit(EXTENT_FLAG_FS_MAPPING, &em->flags);
 	/* Start at 4GiB logical address */
-	em->start = SZ_4G;
-	em->len = test->data_stripe_size * test->num_data_stripes;
-	em->block_len = em->len;
-	em->orig_block_len = test->data_stripe_size;
-	em->map_lookup = map;
-
+	map->start = SZ_4G;
+	map->chunk_len = test->data_stripe_size * test->num_data_stripes;
+	map->stripe_size = test->data_stripe_size;
 	map->num_stripes = test->num_stripes;
 	map->type = test->raid_type;
 
@@ -901,15 +889,13 @@ static int test_rmap_block(struct btrfs_fs_info *fs_info,
 		map->stripes[i].physical = test->data_stripe_phys_start[i];
 	}
 
-	write_lock(&fs_info->mapping_tree.lock);
-	ret = add_extent_mapping(&fs_info->mapping_tree, em, 0);
-	write_unlock(&fs_info->mapping_tree.lock);
+	ret = btrfs_add_chunk_map(fs_info, map);
 	if (ret) {
-		test_err("error adding block group mapping to mapping tree");
+		test_err("error adding chunk map to mapping tree");
 		goto out_free;
 	}
 
-	ret = btrfs_rmap_block(fs_info, em->start, btrfs_sb_offset(1),
+	ret = btrfs_rmap_block(fs_info, map->start, btrfs_sb_offset(1),
 			       &logical, &out_ndaddrs, &out_stripe_len);
 	if (ret || (out_ndaddrs == 0 && test->expected_mapped_addr)) {
 		test_err("didn't rmap anything but expected %d",
@@ -938,14 +924,8 @@ static int test_rmap_block(struct btrfs_fs_info *fs_info,
 
 	ret = 0;
 out:
-	write_lock(&fs_info->mapping_tree.lock);
-	remove_extent_mapping(&fs_info->mapping_tree, em);
-	write_unlock(&fs_info->mapping_tree.lock);
-	/* For us */
-	free_extent_map(em);
+	btrfs_remove_chunk_map(fs_info, map);
 out_free:
-	/* For the tree */
-	free_extent_map(em);
 	kfree(logical);
 	return ret;
 }
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9c4b52d29d6b..5a3880616bc6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1738,19 +1738,18 @@ static int btrfs_free_dev_extent(struct btrfs_trans_handle *trans,
 
 static u64 find_next_chunk(struct btrfs_fs_info *fs_info)
 {
-	struct extent_map_tree *em_tree;
-	struct extent_map *em;
 	struct rb_node *n;
 	u64 ret = 0;
 
-	em_tree = &fs_info->mapping_tree;
-	read_lock(&em_tree->lock);
-	n = rb_last(&em_tree->map.rb_root);
+	read_lock(&fs_info->mapping_tree_lock);
+	n = rb_last(&fs_info->mapping_tree.rb_root);
 	if (n) {
-		em = rb_entry(n, struct extent_map, rb_node);
-		ret = em->start + em->len;
+		struct btrfs_chunk_map *map;
+
+		map = rb_entry(n, struct btrfs_chunk_map, rb_node);
+		ret = map->start + map->chunk_len;
 	}
-	read_unlock(&em_tree->lock);
+	read_unlock(&fs_info->mapping_tree_lock);
 
 	return ret;
 }
@@ -2983,6 +2982,81 @@ static int btrfs_del_sys_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	return ret;
 }
 
+struct btrfs_chunk_map *btrfs_find_chunk_map_nolock(struct btrfs_fs_info *fs_info,
+						    u64 logical, u64 length)
+{
+	struct rb_node *node = fs_info->mapping_tree.rb_root.rb_node;
+	struct rb_node *prev = NULL;
+	struct rb_node *orig_prev;
+	struct btrfs_chunk_map *map;
+	struct btrfs_chunk_map *prev_map = NULL;
+
+	while (node) {
+		map = rb_entry(node, struct btrfs_chunk_map, rb_node);
+		prev = node;
+		prev_map = map;
+
+		if (logical < map->start) {
+			node = node->rb_left;
+		} else if (logical >= map->start + map->chunk_len) {
+			node = node->rb_right;
+		} else {
+			refcount_inc(&map->refs);
+			return map;
+		}
+	}
+
+	if (!prev)
+		return NULL;
+
+	orig_prev = prev;
+	while (prev && logical >= prev_map->start + prev_map->chunk_len) {
+		prev = rb_next(prev);
+		prev_map = rb_entry(prev, struct btrfs_chunk_map, rb_node);
+	}
+
+	if (!prev) {
+		prev = orig_prev;
+		prev_map = rb_entry(prev, struct btrfs_chunk_map, rb_node);
+		while (prev && logical < prev_map->start) {
+			prev = rb_prev(prev);
+			prev_map = rb_entry(prev, struct btrfs_chunk_map, rb_node);
+		}
+	}
+
+	if (prev) {
+		u64 end = logical + length;
+
+		/*
+		 * Caller can pass a U64_MAX length when it wants to get any
+		 * chunk starting at an offset of 'logical' or higher, so deal
+		 * with underflow by resetting the end offset to U64_MAX.
+		 */
+		if (end < logical)
+			end = U64_MAX;
+
+		if (end > prev_map->start &&
+		    logical < prev_map->start + prev_map->chunk_len) {
+			refcount_inc(&prev_map->refs);
+			return prev_map;
+		}
+	}
+
+	return NULL;
+}
+
+struct btrfs_chunk_map *btrfs_find_chunk_map(struct btrfs_fs_info *fs_info,
+					     u64 logical, u64 length)
+{
+	struct btrfs_chunk_map *map;
+
+	read_lock(&fs_info->mapping_tree_lock);
+	map = btrfs_find_chunk_map_nolock(fs_info, logical, length);
+	read_unlock(&fs_info->mapping_tree_lock);
+
+	return map;
+}
+
 /*
  * Find the mapping containing the given logical extent.
  *
@@ -2991,38 +3065,37 @@ static int btrfs_del_sys_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
  *
  * Return: Chunk mapping or ERR_PTR.
  */
-struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
-				       u64 logical, u64 length)
+struct btrfs_chunk_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
+					    u64 logical, u64 length)
 {
-	struct extent_map_tree *em_tree;
-	struct extent_map *em;
+	struct btrfs_chunk_map *map;
 
-	em_tree = &fs_info->mapping_tree;
-	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, logical, length);
-	read_unlock(&em_tree->lock);
+	map = btrfs_find_chunk_map(fs_info, logical, length);
 
-	if (unlikely(!em)) {
+	if (unlikely(!map)) {
+		read_unlock(&fs_info->mapping_tree_lock);
 		btrfs_crit(fs_info,
 			   "unable to find chunk map for logical %llu length %llu",
 			   logical, length);
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (unlikely(em->start > logical || em->start + em->len <= logical)) {
+	if (unlikely(map->start > logical || map->start + map->chunk_len <= logical)) {
+		read_unlock(&fs_info->mapping_tree_lock);
 		btrfs_crit(fs_info,
 			   "found a bad chunk map, wanted %llu-%llu, found %llu-%llu",
-			   logical, logical + length, em->start, em->start + em->len);
-		free_extent_map(em);
+			   logical, logical + length, map->start,
+			   map->start + map->chunk_len);
+		btrfs_free_chunk_map(map);
 		return ERR_PTR(-EINVAL);
 	}
 
-	/* callers are responsible for dropping em's ref. */
-	return em;
+	/* Callers are responsible for dropping the reference. */
+	return map;
 }
 
 static int remove_chunk_item(struct btrfs_trans_handle *trans,
-			     struct map_lookup *map, u64 chunk_offset)
+			     struct btrfs_chunk_map *map, u64 chunk_offset)
 {
 	int i;
 
@@ -3047,23 +3120,21 @@ static int remove_chunk_item(struct btrfs_trans_handle *trans,
 int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct extent_map *em;
-	struct map_lookup *map;
+	struct btrfs_chunk_map *map;
 	u64 dev_extent_len = 0;
 	int i, ret = 0;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 
-	em = btrfs_get_chunk_map(fs_info, chunk_offset, 1);
-	if (IS_ERR(em)) {
+	map = btrfs_get_chunk_map(fs_info, chunk_offset, 1);
+	if (IS_ERR(map)) {
 		/*
 		 * This is a logic error, but we don't want to just rely on the
 		 * user having built with ASSERT enabled, so if ASSERT doesn't
 		 * do anything we still error out.
 		 */
 		ASSERT(0);
-		return PTR_ERR(em);
+		return PTR_ERR(map);
 	}
-	map = em->map_lookup;
 
 	/*
 	 * First delete the device extent items from the devices btree.
@@ -3166,7 +3237,7 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 		goto out;
 	}
 
-	trace_btrfs_chunk_free(fs_info, map, chunk_offset, em->len);
+	trace_btrfs_chunk_free(fs_info, map, chunk_offset, map->chunk_len);
 
 	if (map->type & BTRFS_BLOCK_GROUP_SYSTEM) {
 		ret = btrfs_del_sys_chunk(fs_info, chunk_offset);
@@ -3185,7 +3256,7 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 	 */
 	btrfs_trans_release_chunk_metadata(trans);
 
-	ret = btrfs_remove_block_group(trans, chunk_offset, em);
+	ret = btrfs_remove_block_group(trans, map);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -3197,7 +3268,7 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 		trans->removing_chunk = false;
 	}
 	/* once for us */
-	free_extent_map(em);
+	btrfs_free_chunk_map(map);
 	return ret;
 }
 
@@ -5344,24 +5415,131 @@ static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
 	}
 }
 
+static void chunk_map_device_set_bits(struct btrfs_chunk_map *map, unsigned int bits)
+{
+	for (int i = 0; i < map->num_stripes; i++) {
+		struct btrfs_io_stripe *stripe = &map->stripes[i];
+		struct btrfs_device *device = stripe->dev;
+
+		set_extent_bit(&device->alloc_state, stripe->physical,
+			       stripe->physical + map->stripe_size - 1,
+			       bits | EXTENT_NOWAIT, NULL);
+	}
+}
+
+static void chunk_map_device_clear_bits(struct btrfs_chunk_map *map, unsigned int bits)
+{
+	for (int i = 0; i < map->num_stripes; i++) {
+		struct btrfs_io_stripe *stripe = &map->stripes[i];
+		struct btrfs_device *device = stripe->dev;
+
+		__clear_extent_bit(&device->alloc_state, stripe->physical,
+				   stripe->physical + map->stripe_size - 1,
+				   bits | EXTENT_NOWAIT,
+				   NULL, NULL);
+	}
+}
+
+void btrfs_remove_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *map)
+{
+	write_lock(&fs_info->mapping_tree_lock);
+	rb_erase_cached(&map->rb_node, &fs_info->mapping_tree);
+	RB_CLEAR_NODE(&map->rb_node);
+	chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
+	write_unlock(&fs_info->mapping_tree_lock);
+
+	/* Once for the tree reference. */
+	btrfs_free_chunk_map(map);
+}
+
+EXPORT_FOR_TESTS
+int btrfs_add_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *map)
+{
+	struct rb_node **p;
+	struct rb_node *parent = NULL;
+	bool leftmost = true;
+
+	write_lock(&fs_info->mapping_tree_lock);
+	p = &fs_info->mapping_tree.rb_root.rb_node;
+	while (*p) {
+		struct btrfs_chunk_map *entry;
+
+		parent = *p;
+		entry = rb_entry(parent, struct btrfs_chunk_map, rb_node);
+
+		if (map->start < entry->start) {
+			p = &(*p)->rb_left;
+		} else if (map->start > entry->start) {
+			p = &(*p)->rb_right;
+			leftmost = false;
+		} else {
+			write_unlock(&fs_info->mapping_tree_lock);
+			return -EEXIST;
+		}
+	}
+	rb_link_node(&map->rb_node, parent, p);
+	rb_insert_color_cached(&map->rb_node, &fs_info->mapping_tree, leftmost);
+	chunk_map_device_set_bits(map, CHUNK_ALLOCATED);
+	chunk_map_device_clear_bits(map, CHUNK_TRIMMED);
+	write_unlock(&fs_info->mapping_tree_lock);
+
+	return 0;
+}
+
+EXPORT_FOR_TESTS
+struct btrfs_chunk_map *btrfs_alloc_chunk_map(int num_stripes, gfp_t gfp)
+{
+	struct btrfs_chunk_map *map;
+
+	map = kmalloc(btrfs_chunk_map_size(num_stripes), gfp);
+	if (!map)
+		return NULL;
+
+	refcount_set(&map->refs, 1);
+	RB_CLEAR_NODE(&map->rb_node);
+
+	return map;
+}
+
+struct btrfs_chunk_map *btrfs_clone_chunk_map(struct btrfs_chunk_map *map, gfp_t gfp)
+{
+	const int size = btrfs_chunk_map_size(map->num_stripes);
+	struct btrfs_chunk_map *clone;
+
+	clone = kmemdup(map, size, gfp);
+	if (!clone)
+		return NULL;
+
+	refcount_set(&clone->refs, 1);
+	RB_CLEAR_NODE(&clone->rb_node);
+
+	return clone;
+}
+
 static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 			struct alloc_chunk_ctl *ctl,
 			struct btrfs_device_info *devices_info)
 {
 	struct btrfs_fs_info *info = trans->fs_info;
-	struct map_lookup *map = NULL;
-	struct extent_map_tree *em_tree;
+	struct btrfs_chunk_map *map;
 	struct btrfs_block_group *block_group;
-	struct extent_map *em;
 	u64 start = ctl->start;
 	u64 type = ctl->type;
 	int ret;
 	int i;
 	int j;
 
-	map = kmalloc(map_lookup_size(ctl->num_stripes), GFP_NOFS);
+	map = btrfs_alloc_chunk_map(ctl->num_stripes, GFP_NOFS);
 	if (!map)
 		return ERR_PTR(-ENOMEM);
+
+	map->start = start;
+	map->chunk_len = ctl->chunk_size;
+	map->stripe_size = ctl->stripe_size;
+	map->type = type;
+	map->io_align = BTRFS_STRIPE_LEN;
+	map->io_width = BTRFS_STRIPE_LEN;
+	map->sub_stripes = ctl->sub_stripes;
 	map->num_stripes = ctl->num_stripes;
 
 	for (i = 0; i < ctl->ndevs; ++i) {
@@ -5372,41 +5550,22 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 						   j * ctl->stripe_size;
 		}
 	}
-	map->io_align = BTRFS_STRIPE_LEN;
-	map->io_width = BTRFS_STRIPE_LEN;
-	map->type = type;
-	map->sub_stripes = ctl->sub_stripes;
 
 	trace_btrfs_chunk_alloc(info, map, start, ctl->chunk_size);
 
-	em = alloc_extent_map();
-	if (!em) {
-		kfree(map);
-		return ERR_PTR(-ENOMEM);
-	}
-	set_bit(EXTENT_FLAG_FS_MAPPING, &em->flags);
-	em->map_lookup = map;
-	em->start = start;
-	em->len = ctl->chunk_size;
-	em->block_start = 0;
-	em->block_len = em->len;
-	em->orig_block_len = ctl->stripe_size;
-
-	em_tree = &info->mapping_tree;
-	write_lock(&em_tree->lock);
-	ret = add_extent_mapping(em_tree, em, 0);
+	ret = btrfs_add_chunk_map(info, map);
 	if (ret) {
-		write_unlock(&em_tree->lock);
-		free_extent_map(em);
+		btrfs_free_chunk_map(map);
 		return ERR_PTR(ret);
 	}
-	write_unlock(&em_tree->lock);
 
 	block_group = btrfs_make_block_group(trans, type, start, ctl->chunk_size);
-	if (IS_ERR(block_group))
-		goto error_del_extent;
+	if (IS_ERR(block_group)) {
+		btrfs_remove_chunk_map(info, map);
+		return block_group;
+	}
 
-	for (i = 0; i < map->num_stripes; i++) {
+	for (int i = 0; i < map->num_stripes; i++) {
 		struct btrfs_device *dev = map->stripes[i].dev;
 
 		btrfs_device_set_bytes_used(dev,
@@ -5419,22 +5578,9 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 	atomic64_sub(ctl->stripe_size * map->num_stripes,
 		     &info->free_chunk_space);
 
-	free_extent_map(em);
 	check_raid56_incompat_flag(info, type);
 	check_raid1c34_incompat_flag(info, type);
 
-	return block_group;
-
-error_del_extent:
-	write_lock(&em_tree->lock);
-	remove_extent_mapping(em_tree, em);
-	write_unlock(&em_tree->lock);
-
-	/* One for our allocation */
-	free_extent_map(em);
-	/* One for the tree reference */
-	free_extent_map(em);
-
 	return block_group;
 }
 
@@ -5511,8 +5657,7 @@ int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	struct btrfs_chunk *chunk;
 	struct btrfs_stripe *stripe;
-	struct extent_map *em;
-	struct map_lookup *map;
+	struct btrfs_chunk_map *map;
 	size_t item_size;
 	int i;
 	int ret;
@@ -5541,14 +5686,13 @@ int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
 	 */
 	lockdep_assert_held(&fs_info->chunk_mutex);
 
-	em = btrfs_get_chunk_map(fs_info, bg->start, bg->length);
-	if (IS_ERR(em)) {
-		ret = PTR_ERR(em);
+	map = btrfs_get_chunk_map(fs_info, bg->start, bg->length);
+	if (IS_ERR(map)) {
+		ret = PTR_ERR(map);
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
 
-	map = em->map_lookup;
 	item_size = btrfs_chunk_item_size(map->num_stripes);
 
 	chunk = kzalloc(item_size, GFP_NOFS);
@@ -5605,7 +5749,7 @@ int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
 
 out:
 	kfree(chunk);
-	free_extent_map(em);
+	btrfs_free_chunk_map(map);
 	return ret;
 }
 
@@ -5650,7 +5794,7 @@ static noinline int init_first_rw_device(struct btrfs_trans_handle *trans)
 	return 0;
 }
 
-static inline int btrfs_chunk_max_errors(struct map_lookup *map)
+static inline int btrfs_chunk_max_errors(struct btrfs_chunk_map *map)
 {
 	const int index = btrfs_bg_flags_to_raid_index(map->type);
 
@@ -5659,17 +5803,15 @@ static inline int btrfs_chunk_max_errors(struct map_lookup *map)
 
 bool btrfs_chunk_writeable(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 {
-	struct extent_map *em;
-	struct map_lookup *map;
+	struct btrfs_chunk_map *map;
 	int miss_ndevs = 0;
 	int i;
 	bool ret = true;
 
-	em = btrfs_get_chunk_map(fs_info, chunk_offset, 1);
-	if (IS_ERR(em))
+	map = btrfs_get_chunk_map(fs_info, chunk_offset, 1);
+	if (IS_ERR(map))
 		return false;
 
-	map = em->map_lookup;
 	for (i = 0; i < map->num_stripes; i++) {
 		if (test_bit(BTRFS_DEV_STATE_MISSING,
 					&map->stripes[i].dev->dev_state)) {
@@ -5690,38 +5832,37 @@ bool btrfs_chunk_writeable(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	if (miss_ndevs > btrfs_chunk_max_errors(map))
 		ret = false;
 end:
-	free_extent_map(em);
+	btrfs_free_chunk_map(map);
 	return ret;
 }
 
-void btrfs_mapping_tree_free(struct extent_map_tree *tree)
+void btrfs_mapping_tree_free(struct btrfs_fs_info *fs_info)
 {
-	struct extent_map *em;
+	write_lock(&fs_info->mapping_tree_lock);
+	while (!RB_EMPTY_ROOT(&fs_info->mapping_tree.rb_root)) {
+		struct btrfs_chunk_map *map;
+		struct rb_node *node;
 
-	while (1) {
-		write_lock(&tree->lock);
-		em = lookup_extent_mapping(tree, 0, (u64)-1);
-		if (em)
-			remove_extent_mapping(tree, em);
-		write_unlock(&tree->lock);
-		if (!em)
-			break;
-		/* once for us */
-		free_extent_map(em);
-		/* once for the tree */
-		free_extent_map(em);
+		node = rb_first_cached(&fs_info->mapping_tree);
+		map = rb_entry(node, struct btrfs_chunk_map, rb_node);
+		rb_erase_cached(&map->rb_node, &fs_info->mapping_tree);
+		RB_CLEAR_NODE(&map->rb_node);
+		chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
+		/* Once for the tree ref. */
+		btrfs_free_chunk_map(map);
+		cond_resched_rwlock_write(&fs_info->mapping_tree_lock);
 	}
+	write_unlock(&fs_info->mapping_tree_lock);
 }
 
 int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 {
-	struct extent_map *em;
-	struct map_lookup *map;
+	struct btrfs_chunk_map *map;
 	enum btrfs_raid_types index;
 	int ret = 1;
 
-	em = btrfs_get_chunk_map(fs_info, logical, len);
-	if (IS_ERR(em))
+	map = btrfs_get_chunk_map(fs_info, logical, len);
+	if (IS_ERR(map))
 		/*
 		 * We could return errors for these cases, but that could get
 		 * ugly and we'd probably do the same thing which is just not do
@@ -5730,7 +5871,6 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 		 */
 		return 1;
 
-	map = em->map_lookup;
 	index = btrfs_bg_flags_to_raid_index(map->type);
 
 	/* Non-RAID56, use their ncopies from btrfs_raid_array. */
@@ -5747,53 +5887,49 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 		 * stripe under reconstruction.
 		 */
 		ret = map->num_stripes;
-	free_extent_map(em);
+	btrfs_free_chunk_map(map);
 	return ret;
 }
 
 unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
 				    u64 logical)
 {
-	struct extent_map *em;
-	struct map_lookup *map;
+	struct btrfs_chunk_map *map;
 	unsigned long len = fs_info->sectorsize;
 
 	if (!btrfs_fs_incompat(fs_info, RAID56))
 		return len;
 
-	em = btrfs_get_chunk_map(fs_info, logical, len);
+	map = btrfs_get_chunk_map(fs_info, logical, len);
 
-	if (!WARN_ON(IS_ERR(em))) {
-		map = em->map_lookup;
+	if (!WARN_ON(IS_ERR(map))) {
 		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
 			len = btrfs_stripe_nr_to_offset(nr_data_stripes(map));
-		free_extent_map(em);
+		btrfs_free_chunk_map(map);
 	}
 	return len;
 }
 
 int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 {
-	struct extent_map *em;
-	struct map_lookup *map;
+	struct btrfs_chunk_map *map;
 	int ret = 0;
 
 	if (!btrfs_fs_incompat(fs_info, RAID56))
 		return 0;
 
-	em = btrfs_get_chunk_map(fs_info, logical, len);
+	map = btrfs_get_chunk_map(fs_info, logical, len);
 
-	if(!WARN_ON(IS_ERR(em))) {
-		map = em->map_lookup;
+	if (!WARN_ON(IS_ERR(map))) {
 		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
 			ret = 1;
-		free_extent_map(em);
+		btrfs_free_chunk_map(map);
 	}
 	return ret;
 }
 
 static int find_live_mirror(struct btrfs_fs_info *fs_info,
-			    struct map_lookup *map, int first,
+			    struct btrfs_chunk_map *map, int first,
 			    int dev_replace_is_ongoing)
 {
 	int i;
@@ -5900,8 +6036,7 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 					       u64 logical, u64 *length_ret,
 					       u32 *num_stripes)
 {
-	struct extent_map *em;
-	struct map_lookup *map;
+	struct btrfs_chunk_map *map;
 	struct btrfs_discard_stripe *stripes;
 	u64 length = *length_ret;
 	u64 offset;
@@ -5919,11 +6054,9 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 	int ret;
 	int i;
 
-	em = btrfs_get_chunk_map(fs_info, logical, length);
-	if (IS_ERR(em))
-		return ERR_CAST(em);
-
-	map = em->map_lookup;
+	map = btrfs_get_chunk_map(fs_info, logical, length);
+	if (IS_ERR(map))
+		return ERR_CAST(map);
 
 	/* we don't discard raid56 yet */
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
@@ -5931,8 +6064,8 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 		goto out_free_map;
 	}
 
-	offset = logical - em->start;
-	length = min_t(u64, em->start + em->len - logical, length);
+	offset = logical - map->start;
+	length = min_t(u64, map->start + map->chunk_len - logical, length);
 	*length_ret = length;
 
 	/*
@@ -6029,10 +6162,10 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 		}
 	}
 
-	free_extent_map(em);
+	btrfs_free_chunk_map(map);
 	return stripes;
 out_free_map:
-	free_extent_map(em);
+	btrfs_free_chunk_map(map);
 	return ERR_PTR(ret);
 }
 
@@ -6130,7 +6263,7 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 	bioc->replace_nr_stripes = nr_extra_stripes;
 }
 
-static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op op,
+static u64 btrfs_max_io_len(struct btrfs_chunk_map *map, enum btrfs_map_op op,
 			    u64 offset, u32 *stripe_nr, u64 *stripe_offset,
 			    u64 *full_stripe_start)
 {
@@ -6180,7 +6313,7 @@ static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op op,
 
 static int set_io_stripe(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 			 u64 logical, u64 *length, struct btrfs_io_stripe *dst,
-			 struct map_lookup *map, u32 stripe_index,
+			 struct btrfs_chunk_map *map, u32 stripe_index,
 			 u64 stripe_offset, u64 stripe_nr)
 {
 	dst->dev = map->stripes[stripe_index].dev;
@@ -6234,8 +6367,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		    struct btrfs_io_context **bioc_ret,
 		    struct btrfs_io_stripe *smap, int *mirror_num_ret)
 {
-	struct extent_map *em;
-	struct map_lookup *map;
+	struct btrfs_chunk_map *map;
 	u64 map_offset;
 	u64 stripe_offset;
 	u32 stripe_nr;
@@ -6260,17 +6392,16 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	if (mirror_num > num_copies)
 		return -EINVAL;
 
-	em = btrfs_get_chunk_map(fs_info, logical, *length);
-	if (IS_ERR(em))
-		return PTR_ERR(em);
+	map = btrfs_get_chunk_map(fs_info, logical, *length);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
 
-	map = em->map_lookup;
 	data_stripes = nr_data_stripes(map);
 
-	map_offset = logical - em->start;
+	map_offset = logical - map->start;
 	max_len = btrfs_max_io_len(map, op, map_offset, &stripe_nr,
 				   &stripe_offset, &raid56_full_stripe_start);
-	*length = min_t(u64, em->len - map_offset, max_len);
+	*length = min_t(u64, map->chunk_len - map_offset, max_len);
 
 	down_read(&dev_replace->rwsem);
 	dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(dev_replace);
@@ -6347,7 +6478,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 
 			/* Return the length to the full stripe end */
 			*length = min(logical + *length,
-				      raid56_full_stripe_start + em->start +
+				      raid56_full_stripe_start + map->start +
 				      btrfs_stripe_nr_to_offset(data_stripes)) -
 				  logical;
 			stripe_index = 0;
@@ -6434,7 +6565,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		 * In this case, we just add @stripe_nr with @i, then do the
 		 * modulo, to reduce one modulo call.
 		 */
-		bioc->full_stripe_logical = em->start +
+		bioc->full_stripe_logical = map->start +
 			btrfs_stripe_nr_to_offset(stripe_nr * data_stripes);
 		for (int i = 0; i < num_stripes; i++) {
 			ret = set_io_stripe(fs_info, op, logical, length,
@@ -6485,7 +6616,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		/* Unlock and let waiting writers proceed */
 		up_read(&dev_replace->rwsem);
 	}
-	free_extent_map(em);
+	btrfs_free_chunk_map(map);
 	return ret;
 }
 
@@ -6657,12 +6788,11 @@ static void btrfs_report_missing_device(struct btrfs_fs_info *fs_info,
 			      devid, uuid);
 }
 
-u64 btrfs_calc_stripe_length(const struct extent_map *em)
+u64 btrfs_calc_stripe_length(const struct btrfs_chunk_map *map)
 {
-	const struct map_lookup *map = em->map_lookup;
 	const int data_stripes = calc_data_stripes(map->type, map->num_stripes);
 
-	return div_u64(em->len, data_stripes);
+	return div_u64(map->chunk_len, data_stripes);
 }
 
 #if BITS_PER_LONG == 32
@@ -6731,9 +6861,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 {
 	BTRFS_DEV_LOOKUP_ARGS(args);
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
-	struct extent_map_tree *map_tree = &fs_info->mapping_tree;
-	struct map_lookup *map;
-	struct extent_map *em;
+	struct btrfs_chunk_map *map;
 	u64 logical;
 	u64 length;
 	u64 devid;
@@ -6767,35 +6895,22 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 			return ret;
 	}
 
-	read_lock(&map_tree->lock);
-	em = lookup_extent_mapping(map_tree, logical, 1);
-	read_unlock(&map_tree->lock);
+	map = btrfs_find_chunk_map(fs_info, logical, 1);
 
 	/* already mapped? */
-	if (em && em->start <= logical && em->start + em->len > logical) {
-		free_extent_map(em);
+	if (map && map->start <= logical && map->start + map->chunk_len > logical) {
+		btrfs_free_chunk_map(map);
 		return 0;
-	} else if (em) {
-		free_extent_map(em);
+	} else if (map) {
+		btrfs_free_chunk_map(map);
 	}
 
-	em = alloc_extent_map();
-	if (!em)
-		return -ENOMEM;
-	map = kmalloc(map_lookup_size(num_stripes), GFP_NOFS);
-	if (!map) {
-		free_extent_map(em);
+	map = btrfs_alloc_chunk_map(num_stripes, GFP_NOFS);
+	if (!map)
 		return -ENOMEM;
-	}
-
-	set_bit(EXTENT_FLAG_FS_MAPPING, &em->flags);
-	em->map_lookup = map;
-	em->start = logical;
-	em->len = length;
-	em->orig_start = 0;
-	em->block_start = 0;
-	em->block_len = em->len;
 
+	map->start = logical;
+	map->chunk_len = length;
 	map->num_stripes = num_stripes;
 	map->io_width = btrfs_chunk_io_width(leaf, chunk);
 	map->io_align = btrfs_chunk_io_align(leaf, chunk);
@@ -6810,7 +6925,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 	 */
 	map->sub_stripes = btrfs_raid_array[index].sub_stripes;
 	map->verified_stripes = 0;
-	em->orig_block_len = btrfs_calc_stripe_length(em);
+	map->stripe_size = btrfs_calc_stripe_length(map);
 	for (i = 0; i < num_stripes; i++) {
 		map->stripes[i].physical =
 			btrfs_stripe_offset_nr(leaf, chunk, i);
@@ -6826,7 +6941,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 								    devid, uuid);
 			if (IS_ERR(map->stripes[i].dev)) {
 				ret = PTR_ERR(map->stripes[i].dev);
-				free_extent_map(em);
+				btrfs_free_chunk_map(map);
 				return ret;
 			}
 		}
@@ -6835,15 +6950,12 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 				&(map->stripes[i].dev->dev_state));
 	}
 
-	write_lock(&map_tree->lock);
-	ret = add_extent_mapping(map_tree, em, 0);
-	write_unlock(&map_tree->lock);
+	ret = btrfs_add_chunk_map(fs_info, map);
 	if (ret < 0) {
 		btrfs_err(fs_info,
 			  "failed to add chunk map, start=%llu len=%llu: %d",
-			  em->start, em->len, ret);
+			  map->start, map->chunk_len, ret);
 	}
-	free_extent_map(em);
 
 	return ret;
 }
@@ -7153,26 +7265,21 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
 bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 					struct btrfs_device *failing_dev)
 {
-	struct extent_map_tree *map_tree = &fs_info->mapping_tree;
-	struct extent_map *em;
-	u64 next_start = 0;
+	struct btrfs_chunk_map *map;
+	u64 next_start;
 	bool ret = true;
 
-	read_lock(&map_tree->lock);
-	em = lookup_extent_mapping(map_tree, 0, (u64)-1);
-	read_unlock(&map_tree->lock);
+	map = btrfs_find_chunk_map(fs_info, 0, U64_MAX);
 	/* No chunk at all? Return false anyway */
-	if (!em) {
+	if (!map) {
 		ret = false;
 		goto out;
 	}
-	while (em) {
-		struct map_lookup *map;
+	while (map) {
 		int missing = 0;
 		int max_tolerated;
 		int i;
 
-		map = em->map_lookup;
 		max_tolerated =
 			btrfs_get_num_tolerated_disk_barrier_failures(
 					map->type);
@@ -7190,18 +7297,15 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 			if (!failing_dev)
 				btrfs_warn(fs_info,
 	"chunk %llu missing %d devices, max tolerance is %d for writable mount",
-				   em->start, missing, max_tolerated);
-			free_extent_map(em);
+				   map->start, missing, max_tolerated);
+			btrfs_free_chunk_map(map);
 			ret = false;
 			goto out;
 		}
-		next_start = extent_map_end(em);
-		free_extent_map(em);
+		next_start = map->start + map->chunk_len;
+		btrfs_free_chunk_map(map);
 
-		read_lock(&map_tree->lock);
-		em = lookup_extent_mapping(map_tree, next_start,
-					   (u64)(-1) - next_start);
-		read_unlock(&map_tree->lock);
+		map = btrfs_find_chunk_map(fs_info, next_start, U64_MAX - next_start);
 	}
 out:
 	return ret;
@@ -7694,20 +7798,15 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 				 u64 physical_offset, u64 physical_len)
 {
 	struct btrfs_dev_lookup_args args = { .devid = devid };
-	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
-	struct extent_map *em;
-	struct map_lookup *map;
+	struct btrfs_chunk_map *map;
 	struct btrfs_device *dev;
 	u64 stripe_len;
 	bool found = false;
 	int ret = 0;
 	int i;
 
-	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, chunk_offset, 1);
-	read_unlock(&em_tree->lock);
-
-	if (!em) {
+	map = btrfs_find_chunk_map(fs_info, chunk_offset, 1);
+	if (!map) {
 		btrfs_err(fs_info,
 "dev extent physical offset %llu on devid %llu doesn't have corresponding chunk",
 			  physical_offset, devid);
@@ -7715,12 +7814,11 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 		goto out;
 	}
 
-	map = em->map_lookup;
-	stripe_len = btrfs_calc_stripe_length(em);
+	stripe_len = btrfs_calc_stripe_length(map);
 	if (physical_len != stripe_len) {
 		btrfs_err(fs_info,
 "dev extent physical offset %llu on devid %llu length doesn't match chunk %llu, have %llu expect %llu",
-			  physical_offset, devid, em->start, physical_len,
+			  physical_offset, devid, map->start, physical_len,
 			  stripe_len);
 		ret = -EUCLEAN;
 		goto out;
@@ -7743,7 +7841,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 			if (map->verified_stripes >= map->num_stripes) {
 				btrfs_err(fs_info,
 				"too many dev extents for chunk %llu found",
-					  em->start);
+					  map->start);
 				ret = -EUCLEAN;
 				goto out;
 			}
@@ -7789,32 +7887,30 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 	}
 
 out:
-	free_extent_map(em);
+	btrfs_free_chunk_map(map);
 	return ret;
 }
 
 static int verify_chunk_dev_extent_mapping(struct btrfs_fs_info *fs_info)
 {
-	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
-	struct extent_map *em;
 	struct rb_node *node;
 	int ret = 0;
 
-	read_lock(&em_tree->lock);
-	for (node = rb_first_cached(&em_tree->map); node; node = rb_next(node)) {
-		em = rb_entry(node, struct extent_map, rb_node);
-		if (em->map_lookup->num_stripes !=
-		    em->map_lookup->verified_stripes) {
+	read_lock(&fs_info->mapping_tree_lock);
+	for (node = rb_first_cached(&fs_info->mapping_tree); node; node = rb_next(node)) {
+		struct btrfs_chunk_map *map;
+
+		map = rb_entry(node, struct btrfs_chunk_map, rb_node);
+		if (map->num_stripes != map->verified_stripes) {
 			btrfs_err(fs_info,
 			"chunk %llu has missing dev extent, have %d expect %d",
-				  em->start, em->map_lookup->verified_stripes,
-				  em->map_lookup->num_stripes);
+				  map->start, map->verified_stripes, map->num_stripes);
 			ret = -EUCLEAN;
 			goto out;
 		}
 	}
 out:
-	read_unlock(&em_tree->lock);
+	read_unlock(&fs_info->mapping_tree_lock);
 	return ret;
 }
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 5dd4ad775e5d..9c6a960d07ae 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -428,7 +428,8 @@ struct btrfs_discard_stripe {
 struct btrfs_io_context {
 	refcount_t refs;
 	struct btrfs_fs_info *fs_info;
-	u64 map_type; /* get from map_lookup->type */
+	/* Taken from struct btrfs_chunk_map::type. */
+	u64 map_type;
 	struct bio *orig_bio;
 	atomic_t error;
 	u16 max_errors;
@@ -531,18 +532,32 @@ struct btrfs_raid_attr {
 
 extern const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES];
 
-struct map_lookup {
+struct btrfs_chunk_map {
+	struct rb_node rb_node;
+	refcount_t refs;
+	u64 start;
+	u64 chunk_len;
+	u64 stripe_size;
 	u64 type;
 	int io_align;
 	int io_width;
 	int num_stripes;
 	int sub_stripes;
-	int verified_stripes; /* For mount time dev extent verification */
+	/* For mount time dev extent verification. */
+	int verified_stripes;
 	struct btrfs_io_stripe stripes[];
 };
 
-#define map_lookup_size(n) (sizeof(struct map_lookup) + \
-			    (sizeof(struct btrfs_io_stripe) * (n)))
+#define btrfs_chunk_map_size(n) (sizeof(struct btrfs_chunk_map) + \
+				 (sizeof(struct btrfs_io_stripe) * (n)))
+
+static inline void btrfs_free_chunk_map(struct btrfs_chunk_map *map)
+{
+	if (map && refcount_dec_and_test(&map->refs)) {
+		ASSERT(RB_EMPTY_NODE(&map->rb_node));
+		kfree(map);
+	}
+}
 
 struct btrfs_balance_args;
 struct btrfs_balance_progress;
@@ -626,7 +641,7 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info);
 int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
 struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 					    u64 type);
-void btrfs_mapping_tree_free(struct extent_map_tree *tree);
+void btrfs_mapping_tree_free(struct btrfs_fs_info *fs_info);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       blk_mode_t flags, void *holder);
 struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
@@ -682,13 +697,25 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info,
 			   u64 logical, u64 len);
 unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
 				    u64 logical);
-u64 btrfs_calc_stripe_length(const struct extent_map *em);
+u64 btrfs_calc_stripe_length(const struct btrfs_chunk_map *map);
 int btrfs_nr_parity_stripes(u64 type);
 int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
 				     struct btrfs_block_group *bg);
 int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset);
-struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
-				       u64 logical, u64 length);
+
+#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
+struct btrfs_chunk_map *btrfs_alloc_chunk_map(int num_stripes, gfp_t gfp);
+int btrfs_add_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *map);
+#endif
+
+struct btrfs_chunk_map *btrfs_clone_chunk_map(struct btrfs_chunk_map *map, gfp_t gfp);
+struct btrfs_chunk_map *btrfs_find_chunk_map(struct btrfs_fs_info *fs_info,
+					     u64 logical, u64 length);
+struct btrfs_chunk_map *btrfs_find_chunk_map_nolock(struct btrfs_fs_info *fs_info,
+						    u64 logical, u64 length);
+struct btrfs_chunk_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
+					    u64 logical, u64 length);
+void btrfs_remove_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *map);
 void btrfs_release_disk_super(struct btrfs_super_block *super);
 
 static inline void btrfs_dev_stat_inc(struct btrfs_device *dev,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 188378ca19c7..4c7d658fc078 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1553,8 +1553,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
 	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
-	struct extent_map *em;
-	struct map_lookup *map;
+	struct btrfs_chunk_map *map;
 	u64 logical = cache->start;
 	u64 length = cache->length;
 	struct zone_info *zone_info = NULL;
@@ -1575,17 +1574,11 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		return -EIO;
 	}
 
-	/* Get the chunk mapping */
-	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, logical, length);
-	read_unlock(&em_tree->lock);
-
-	if (!em)
+	map = btrfs_find_chunk_map(fs_info, logical, length);
+	if (!map)
 		return -EINVAL;
 
-	map = em->map_lookup;
-
-	cache->physical_map = kmemdup(map, map_lookup_size(map->num_stripes), GFP_NOFS);
+	cache->physical_map = btrfs_clone_chunk_map(map, GFP_NOFS);
 	if (!cache->physical_map) {
 		ret = -ENOMEM;
 		goto out;
@@ -1687,12 +1680,11 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 			spin_unlock(&fs_info->zone_active_bgs_lock);
 		}
 	} else {
-		kfree(cache->physical_map);
+		btrfs_free_chunk_map(cache->physical_map);
 		cache->physical_map = NULL;
 	}
 	bitmap_free(active);
 	kfree(zone_info);
-	free_extent_map(em);
 
 	return ret;
 }
@@ -2082,7 +2074,7 @@ int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
 bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
-	struct map_lookup *map;
+	struct btrfs_chunk_map *map;
 	struct btrfs_device *device;
 	u64 physical;
 	const bool is_data = (block_group->flags & BTRFS_BLOCK_GROUP_DATA);
@@ -2194,7 +2186,7 @@ static void wait_eb_writebacks(struct btrfs_block_group *block_group)
 static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_written)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
-	struct map_lookup *map;
+	struct btrfs_chunk_map *map;
 	const bool is_metadata = (block_group->flags &
 			(BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM));
 	int ret = 0;
@@ -2643,7 +2635,7 @@ void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info)
 	/* Release reservation for currently active block groups. */
 	spin_lock(&fs_info->zone_active_bgs_lock);
 	list_for_each_entry(block_group, &fs_info->zone_active_bgs, active_bg_list) {
-		struct map_lookup *map = block_group->physical_map;
+		struct btrfs_chunk_map *map = block_group->physical_map;
 
 		if (!(block_group->flags &
 		      (BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM)))
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 279a7a0c90c0..4a95097ab590 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -21,7 +21,7 @@ struct btrfs_delayed_data_ref;
 struct btrfs_delayed_ref_head;
 struct btrfs_block_group;
 struct btrfs_free_cluster;
-struct map_lookup;
+struct btrfs_chunk_map;
 struct extent_buffer;
 struct btrfs_work;
 struct btrfs_workqueue;
@@ -277,8 +277,7 @@ DEFINE_EVENT(btrfs__inode, btrfs_inode_evict,
 		{ (1 << EXTENT_FLAG_COMPRESSED), 	"COMPRESSED" 	},\
 		{ (1 << EXTENT_FLAG_PREALLOC), 		"PREALLOC" 	},\
 		{ (1 << EXTENT_FLAG_LOGGING),	 	"LOGGING" 	},\
-		{ (1 << EXTENT_FLAG_FILLING),	 	"FILLING" 	},\
-		{ (1 << EXTENT_FLAG_FS_MAPPING),	"FS_MAPPING"	})
+		{ (1 << EXTENT_FLAG_FILLING),		"FILLING"	})
 
 TRACE_EVENT_CONDITION(btrfs_get_extent,
 
@@ -1061,7 +1060,7 @@ DEFINE_EVENT(btrfs_delayed_ref_head,  run_delayed_ref_head,
 DECLARE_EVENT_CLASS(btrfs__chunk,
 
 	TP_PROTO(const struct btrfs_fs_info *fs_info,
-		 const struct map_lookup *map, u64 offset, u64 size),
+		 const struct btrfs_chunk_map *map, u64 offset, u64 size),
 
 	TP_ARGS(fs_info, map, offset, size),
 
@@ -1095,7 +1094,7 @@ DECLARE_EVENT_CLASS(btrfs__chunk,
 DEFINE_EVENT(btrfs__chunk,  btrfs_chunk_alloc,
 
 	TP_PROTO(const struct btrfs_fs_info *fs_info,
-		 const struct map_lookup *map, u64 offset, u64 size),
+		 const struct btrfs_chunk_map *map, u64 offset, u64 size),
 
 	TP_ARGS(fs_info, map, offset, size)
 );
@@ -1103,7 +1102,7 @@ DEFINE_EVENT(btrfs__chunk,  btrfs_chunk_alloc,
 DEFINE_EVENT(btrfs__chunk,  btrfs_chunk_free,
 
 	TP_PROTO(const struct btrfs_fs_info *fs_info,
-		 const struct map_lookup *map, u64 offset, u64 size),
+		 const struct btrfs_chunk_map *map, u64 offset, u64 size),
 
 	TP_ARGS(fs_info, map, offset, size)
 );
-- 
2.40.1


