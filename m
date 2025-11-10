Return-Path: <linux-btrfs+bounces-18839-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E32ABC48411
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 18:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6985834A723
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 17:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2764129D29F;
	Mon, 10 Nov 2025 17:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="nhlSbdfl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF5B29A309
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794931; cv=none; b=d1Af4RPCe08w77JYFOBhg+h+8NVuJOnHSJt/CbTaoxEqt70uOor4vcj86K4D87ENpFhruH+cIJRABvabp+EJaiOdub3wXf1mgT+HMRT1M41umZNDdmU+xtB1SZ6J0pcGA+o/3af5N3iER+e84OAVz/Di2HaxOp+bOaNWx1IVKXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794931; c=relaxed/simple;
	bh=BrAryI/ruu52Uj7NP5/AWHk6O/P5P1puyb37Na6ngAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=kJJl9F2gV2diTK6SIudhbdADoigiWhdRJeoqz10XqKdXspZBn3mgb2TXCHxaH/bUS5Hn5ujzBb2lfOEW16JO+nJFgY3/5I6oWIP50Kj6xvrh2wN/842J4ZOnMzFeGmpCPlh/GXOcMSqbLJJcygbbMgf4kF77hEcKSxQWi14dAcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=nhlSbdfl; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 1917F2D8F92;
	Mon, 10 Nov 2025 17:15:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1762794915;
	bh=46pszwGnCgDNcJXc8AdC8pP/UOWQHdYHQ8sCS8ZKue0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nhlSbdflYu8KJerucWWhLt4HGgtlOYLmu4inwlA7VZ+bnG9AYBt1fbOqSE9huu3FY
	 FcYpzccG6Z1z857mOM182/s1cYsSWSslx7IX2toI/T9/cwKcgef23d+PnAXtt+Lxe1
	 LR2pdzs0OYWOnvr2VXuYjdZtJaQS2seddvdrVYV4=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v5 10/16] btrfs: handle setting up relocation of block group with remap-tree
Date: Mon, 10 Nov 2025 17:14:34 +0000
Message-ID: <20251110171511.20900-11-mark@harmstone.com>
In-Reply-To: <20251110171511.20900-1-mark@harmstone.com>
References: <20251110171511.20900-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle the preliminary work for relocating a block group in a filesystem
with the remap-tree flag set.

If the block group is SYSTEM btrfs_relocate_block_group() proceeds as it
does already, as bootstrapping issues mean that these block groups have
to be processed the existing way. Similarly with REMAP blocks, which are
dealt with in a later patch.

Otherwise we walk the free-space tree for the block group in question,
recording any holes. These get converted into identity remaps and placed
in the remap tree, and the block group's REMAPPED flag is set. From now
on no new allocations are possible within this block group, and any I/O
to it will be funnelled through btrfs_translate_remap(). We store the
number of identity remaps in `identity_remap_count`, so that we know
when we've removed the last one and the block group is fully remapped.

The change in btrfs_read_roots() is because data relocations no longer
rely on the data reloc tree as a hidden subvolume in which to do
snapshots.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/block-group.c     |   6 +-
 fs/btrfs/block-group.h     |   4 +
 fs/btrfs/free-space-tree.c |   4 +-
 fs/btrfs/free-space-tree.h |   5 +-
 fs/btrfs/relocation.c      | 492 +++++++++++++++++++++++++++++++++----
 fs/btrfs/relocation.h      |  11 +
 fs/btrfs/space-info.c      |   9 +-
 fs/btrfs/volumes.c         |  15 ++
 8 files changed, 490 insertions(+), 56 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 0e41b311aa3d..7e9c3222beb6 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2416,6 +2416,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	cache->used = btrfs_stack_block_group_v2_used(bgi);
 	cache->commit_used = cache->used;
 	cache->flags = btrfs_stack_block_group_v2_flags(bgi);
+	cache->commit_flags = cache->flags;
 	cache->global_root_id = btrfs_stack_block_group_v2_chunk_objectid(bgi);
 	cache->space_info = btrfs_find_space_info(info, cache->flags);
 	cache->remap_bytes = btrfs_stack_block_group_v2_remap_bytes(bgi);
@@ -2725,6 +2726,7 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 	block_group->commit_remap_bytes = block_group->remap_bytes;
 	block_group->commit_identity_remap_count =
 		block_group->identity_remap_count;
+	block_group->commit_flags = block_group->flags;
 	key.objectid = block_group->start;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	key.offset = block_group->length;
@@ -3213,13 +3215,15 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 	/* No change in values, can safely skip it. */
 	if (cache->commit_used == used &&
 	    cache->commit_remap_bytes == remap_bytes &&
-	    cache->commit_identity_remap_count == identity_remap_count) {
+	    cache->commit_identity_remap_count == identity_remap_count &&
+	    cache->commit_flags == cache->flags) {
 		spin_unlock(&cache->lock);
 		return 0;
 	}
 	cache->commit_used = used;
 	cache->commit_remap_bytes = remap_bytes;
 	cache->commit_identity_remap_count = identity_remap_count;
+	cache->commit_flags = cache->flags;
 	spin_unlock(&cache->lock);
 
 	key.objectid = cache->start;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index d85f3c2546d0..4522074a45c2 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -146,6 +146,10 @@ struct btrfs_block_group {
 	 * The last commited identity_remap_count value of this block group.
 	 */
 	u32 commit_identity_remap_count;
+	/*
+	 * The last committed flags value for this block group.
+	 */
+	u64 commit_flags;
 
 	/*
 	 * If the free space extent count exceeds this number, convert the block
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 26eae347739f..e46b1fa86f80 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -21,8 +21,7 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 					struct btrfs_block_group *block_group,
 					struct btrfs_path *path);
 
-static struct btrfs_root *btrfs_free_space_root(
-				struct btrfs_block_group *block_group)
+struct btrfs_root *btrfs_free_space_root(struct btrfs_block_group *block_group)
 {
 	struct btrfs_key key = {
 		.objectid = BTRFS_FREE_SPACE_TREE_OBJECTID,
@@ -93,7 +92,6 @@ static int add_new_free_space_info(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-EXPORT_FOR_TESTS
 struct btrfs_free_space_info *btrfs_search_free_space_info(
 		struct btrfs_trans_handle *trans,
 		struct btrfs_block_group *block_group,
diff --git a/fs/btrfs/free-space-tree.h b/fs/btrfs/free-space-tree.h
index 3d9a5d4477fc..89d2ff7e5c18 100644
--- a/fs/btrfs/free-space-tree.h
+++ b/fs/btrfs/free-space-tree.h
@@ -35,12 +35,13 @@ int btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
 				 u64 start, u64 size);
 int btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
 				      u64 start, u64 size);
-
-#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct btrfs_free_space_info *
 btrfs_search_free_space_info(struct btrfs_trans_handle *trans,
 			     struct btrfs_block_group *block_group,
 			     struct btrfs_path *path, int cow);
+struct btrfs_root *btrfs_free_space_root(struct btrfs_block_group *block_group);
+
+#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 int __btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
 				   struct btrfs_block_group *block_group,
 				   struct btrfs_path *path, u64 start, u64 size);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 49488c125b5c..535e07cc3719 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3617,7 +3617,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		btrfs_btree_balance_dirty(fs_info);
 	}
 
-	if (!err) {
+	if (!err && !btrfs_fs_incompat(fs_info, REMAP_TREE)) {
 		ret = relocate_file_extent_cluster(rc);
 		if (ret < 0)
 			err = ret;
@@ -3861,6 +3861,90 @@ static const char *stage_to_string(enum reloc_stage stage)
 	return "unknown";
 }
 
+static int add_remap_tree_entries(struct btrfs_trans_handle *trans,
+				  struct btrfs_path *path,
+				  struct btrfs_key *entries,
+				  unsigned int num_entries)
+{
+	int ret;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_item_batch batch;
+	u32 *data_sizes;
+	u32 max_items;
+
+	max_items = BTRFS_LEAF_DATA_SIZE(trans->fs_info) / sizeof(struct btrfs_item);
+
+	data_sizes = kzalloc(sizeof(u32) * min_t(u32, num_entries, max_items),
+			     GFP_NOFS);
+	if (!data_sizes)
+		return -ENOMEM;
+
+	while (true) {
+		batch.keys = entries;
+		batch.data_sizes = data_sizes;
+		batch.total_data_size = 0;
+		batch.nr = min_t(u32, num_entries, max_items);
+
+		ret = btrfs_insert_empty_items(trans, fs_info->remap_root, path,
+					       &batch);
+		btrfs_release_path(path);
+
+		if (num_entries <= max_items)
+			break;
+
+		num_entries -= max_items;
+		entries += max_items;
+	}
+
+	kfree(data_sizes);
+
+	return ret;
+}
+
+struct space_run {
+	u64 start;
+	u64 end;
+};
+
+static void parse_bitmap(u64 block_size, const unsigned long *bitmap,
+			 unsigned long size, u64 address,
+			 struct space_run *space_runs,
+			 unsigned int *num_space_runs)
+{
+	unsigned long pos, end;
+	u64 run_start, run_length;
+
+	pos = find_first_bit(bitmap, size);
+
+	if (pos == size)
+		return;
+
+	while (true) {
+		end = find_next_zero_bit(bitmap, size, pos);
+
+		run_start = address + (pos * block_size);
+		run_length = (end - pos) * block_size;
+
+		if (*num_space_runs != 0 &&
+		    space_runs[*num_space_runs - 1].end == run_start) {
+			space_runs[*num_space_runs - 1].end += run_length;
+		} else {
+			space_runs[*num_space_runs].start = run_start;
+			space_runs[*num_space_runs].end = run_start + run_length;
+
+			(*num_space_runs)++;
+		}
+
+		if (end == size)
+			break;
+
+		pos = find_next_bit(bitmap, size, end + 1);
+
+		if (pos == size)
+			break;
+	}
+}
+
 static void adjust_block_group_remap_bytes(struct btrfs_trans_handle *trans,
 					   struct btrfs_block_group *bg,
 					   s64 diff)
@@ -3893,6 +3977,184 @@ static void adjust_block_group_remap_bytes(struct btrfs_trans_handle *trans,
 		btrfs_inc_delayed_refs_rsv_bg_updates(fs_info);
 }
 
+static int create_remap_tree_entries(struct btrfs_trans_handle *trans,
+				     struct btrfs_path *path,
+				     struct btrfs_block_group *bg)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_free_space_info *fsi;
+	struct btrfs_key key, found_key;
+	struct extent_buffer *leaf;
+	struct btrfs_root *space_root;
+	u32 extent_count;
+	struct space_run *space_runs = NULL;
+	unsigned int num_space_runs = 0;
+	struct btrfs_key *entries = NULL;
+	unsigned int max_entries, num_entries;
+	int ret;
+
+	mutex_lock(&bg->free_space_lock);
+
+	if (test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &bg->runtime_flags)) {
+		mutex_unlock(&bg->free_space_lock);
+
+		ret = btrfs_add_block_group_free_space(trans, bg);
+		if (ret)
+			return ret;
+
+		mutex_lock(&bg->free_space_lock);
+	}
+
+	fsi = btrfs_search_free_space_info(trans, bg, path, 0);
+	if (IS_ERR(fsi)) {
+		mutex_unlock(&bg->free_space_lock);
+		return PTR_ERR(fsi);
+	}
+
+	extent_count = btrfs_free_space_extent_count(path->nodes[0], fsi);
+
+	btrfs_release_path(path);
+
+	space_runs = kmalloc(sizeof(*space_runs) * extent_count, GFP_NOFS);
+	if (!space_runs) {
+		mutex_unlock(&bg->free_space_lock);
+		return -ENOMEM;
+	}
+
+	key.objectid = bg->start;
+	key.type = 0;
+	key.offset = 0;
+
+	space_root = btrfs_free_space_root(bg);
+
+	ret = btrfs_search_slot(trans, space_root, &key, path, 0, 0);
+	if (ret < 0) {
+		mutex_unlock(&bg->free_space_lock);
+		goto out;
+	}
+
+	ret = 0;
+
+	while (true) {
+		leaf = path->nodes[0];
+
+		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
+
+		if (found_key.objectid >= bg->start + bg->length)
+			break;
+
+		if (found_key.type == BTRFS_FREE_SPACE_EXTENT_KEY) {
+			if (num_space_runs != 0 &&
+			    space_runs[num_space_runs - 1].end == found_key.objectid) {
+				space_runs[num_space_runs - 1].end =
+					found_key.objectid + found_key.offset;
+			} else {
+				BUG_ON(num_space_runs >= extent_count);
+
+				space_runs[num_space_runs].start = found_key.objectid;
+				space_runs[num_space_runs].end =
+					found_key.objectid + found_key.offset;
+
+				num_space_runs++;
+			}
+		} else if (found_key.type == BTRFS_FREE_SPACE_BITMAP_KEY) {
+			void *bitmap;
+			unsigned long offset;
+			u32 data_size;
+
+			offset = btrfs_item_ptr_offset(leaf, path->slots[0]);
+			data_size = btrfs_item_size(leaf, path->slots[0]);
+
+			if (data_size != 0) {
+				bitmap = kmalloc(data_size, GFP_NOFS);
+				if (!bitmap) {
+					mutex_unlock(&bg->free_space_lock);
+					ret = -ENOMEM;
+					goto out;
+				}
+
+				read_extent_buffer(leaf, bitmap, offset,
+						   data_size);
+
+				parse_bitmap(fs_info->sectorsize, bitmap,
+					     data_size * BITS_PER_BYTE,
+					     found_key.objectid, space_runs,
+					     &num_space_runs);
+
+				BUG_ON(num_space_runs > extent_count);
+
+				kfree(bitmap);
+			}
+		}
+
+		path->slots[0]++;
+
+		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
+			ret = btrfs_next_leaf(space_root, path);
+			if (ret != 0) {
+				if (ret == 1)
+					ret = 0;
+				break;
+			}
+			leaf = path->nodes[0];
+		}
+	}
+
+	btrfs_release_path(path);
+
+	mutex_unlock(&bg->free_space_lock);
+
+	max_entries = extent_count + 2;
+	entries = kmalloc(sizeof(*entries) * max_entries, GFP_NOFS);
+	if (!entries) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	num_entries = 0;
+
+	if (num_space_runs > 0 && space_runs[0].start > bg->start) {
+		entries[num_entries].objectid = bg->start;
+		entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
+		entries[num_entries].offset = space_runs[0].start - bg->start;
+		num_entries++;
+	}
+
+	for (unsigned int i = 1; i < num_space_runs; i++) {
+		entries[num_entries].objectid = space_runs[i - 1].end;
+		entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
+		entries[num_entries].offset =
+			space_runs[i].start - space_runs[i - 1].end;
+		num_entries++;
+	}
+
+	if (num_space_runs == 0) {
+		entries[num_entries].objectid = bg->start;
+		entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
+		entries[num_entries].offset = bg->length;
+		num_entries++;
+	} else if (space_runs[num_space_runs - 1].end < bg->start + bg->length) {
+		entries[num_entries].objectid = space_runs[num_space_runs - 1].end;
+		entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
+		entries[num_entries].offset =
+			bg->start + bg->length - space_runs[num_space_runs - 1].end;
+		num_entries++;
+	}
+
+	if (num_entries == 0)
+		goto out;
+
+	bg->identity_remap_count = num_entries;
+
+	ret = add_remap_tree_entries(trans, path, entries, num_entries);
+
+out:
+	kfree(entries);
+	kfree(space_runs);
+
+	return ret;
+}
+
 static int remove_chunk_stripes(struct btrfs_trans_handle *trans,
 				struct btrfs_chunk_map *chunk,
 				struct btrfs_path *path)
@@ -4006,6 +4268,55 @@ static void adjust_identity_remap_count(struct btrfs_trans_handle *trans,
 		btrfs_mark_bg_fully_remapped(bg, trans);
 }
 
+static int mark_chunk_remapped(struct btrfs_trans_handle *trans,
+			       struct btrfs_path *path, uint64_t start)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_chunk_map *chunk;
+	struct btrfs_key key;
+	u64 type;
+	int ret;
+	struct extent_buffer *leaf;
+	struct btrfs_chunk *c;
+
+	read_lock(&fs_info->mapping_tree_lock);
+
+	chunk = btrfs_find_chunk_map_nolock(fs_info, start, 1);
+	if (!chunk) {
+		read_unlock(&fs_info->mapping_tree_lock);
+		return -ENOENT;
+	}
+
+	chunk->type |= BTRFS_BLOCK_GROUP_REMAPPED;
+	type = chunk->type;
+
+	read_unlock(&fs_info->mapping_tree_lock);
+
+	key.objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
+	key.type = BTRFS_CHUNK_ITEM_KEY;
+	key.offset = start;
+
+	ret = btrfs_search_slot(trans, fs_info->chunk_root, &key, path,
+				0, 1);
+	if (ret == 1) {
+		ret = -ENOENT;
+		goto end;
+	} else if (ret < 0)
+		goto end;
+
+	leaf = path->nodes[0];
+
+	c = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_chunk);
+	btrfs_set_chunk_type(leaf, c, type);
+	btrfs_mark_buffer_dirty(trans, leaf);
+
+	ret = 0;
+end:
+	btrfs_free_chunk_map(chunk);
+	btrfs_release_path(path);
+	return ret;
+}
+
 int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
 			  u64 *length)
 {
@@ -4060,6 +4371,83 @@ int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
 	return 0;
 }
 
+static int start_block_group_remapping(struct btrfs_fs_info *fs_info,
+				       struct btrfs_path *path,
+				       struct btrfs_block_group *bg)
+{
+	struct btrfs_trans_handle *trans;
+	bool bg_already_dirty = true;
+	int ret, ret2;
+
+	ret = btrfs_cache_block_group(bg, true);
+	if (ret)
+		return ret;
+
+	trans = btrfs_start_transaction(fs_info->remap_root, 0);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	/* We need to run delayed refs, to make sure FST is up to date. */
+	ret = btrfs_run_delayed_refs(trans, U64_MAX);
+	if (ret) {
+		btrfs_end_transaction(trans);
+		return ret;
+	}
+
+	mutex_lock(&fs_info->remap_mutex);
+
+	if (bg->flags & BTRFS_BLOCK_GROUP_REMAPPED) {
+		ret = 0;
+		goto end;
+	}
+
+	ret = create_remap_tree_entries(trans, path, bg);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto end;
+	}
+
+	spin_lock(&bg->lock);
+	bg->flags |= BTRFS_BLOCK_GROUP_REMAPPED;
+	spin_unlock(&bg->lock);
+
+	spin_lock(&trans->transaction->dirty_bgs_lock);
+	if (list_empty(&bg->dirty_list)) {
+		list_add_tail(&bg->dirty_list,
+			      &trans->transaction->dirty_bgs);
+		bg_already_dirty = false;
+		btrfs_get_block_group(bg);
+	}
+	spin_unlock(&trans->transaction->dirty_bgs_lock);
+
+	/* Modified block groups are accounted for in the delayed_refs_rsv. */
+	if (!bg_already_dirty)
+		btrfs_inc_delayed_refs_rsv_bg_updates(fs_info);
+
+	ret = mark_chunk_remapped(trans, path, bg->start);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto end;
+	}
+
+	ret = btrfs_remove_block_group_free_space(trans, bg);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto end;
+	}
+
+	btrfs_remove_free_space_cache(bg);
+
+end:
+	mutex_unlock(&fs_info->remap_mutex);
+
+	ret2 = btrfs_end_transaction(trans);
+	if (!ret)
+		ret = ret2;
+
+	return ret;
+}
+
 /*
  * function to relocate all extents in a block group.
  */
@@ -4070,7 +4458,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
 	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, group_start);
 	struct reloc_control *rc;
 	struct inode *inode;
-	struct btrfs_path *path;
+	struct btrfs_path *path = NULL;
 	int ret;
 	bool bg_is_ro = false;
 
@@ -4132,7 +4520,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
 	}
 
 	inode = lookup_free_space_inode(rc->block_group, path);
-	btrfs_free_path(path);
+	btrfs_release_path(path);
 
 	if (!IS_ERR(inode))
 		ret = delete_block_group_cache(rc->block_group, inode, 0);
@@ -4142,11 +4530,13 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
 	if (ret && ret != -ENOENT)
 		goto out;
 
-	rc->data_inode = create_reloc_inode(rc->block_group);
-	if (IS_ERR(rc->data_inode)) {
-		ret = PTR_ERR(rc->data_inode);
-		rc->data_inode = NULL;
-		goto out;
+	if (!btrfs_fs_incompat(fs_info, REMAP_TREE)) {
+		rc->data_inode = create_reloc_inode(rc->block_group);
+		if (IS_ERR(rc->data_inode)) {
+			ret = PTR_ERR(rc->data_inode);
+			rc->data_inode = NULL;
+			goto out;
+		}
 	}
 
 	if (verbose)
@@ -4159,54 +4549,60 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
 	ret = btrfs_zone_finish(rc->block_group);
 	WARN_ON(ret && ret != -EAGAIN);
 
-	while (1) {
-		enum reloc_stage finishes_stage;
+	if (should_relocate_using_remap_tree(bg)) {
+		ret = start_block_group_remapping(fs_info, path, bg);
+	} else {
+		while (1) {
+			enum reloc_stage finishes_stage;
 
-		mutex_lock(&fs_info->cleaner_mutex);
-		ret = relocate_block_group(rc);
-		mutex_unlock(&fs_info->cleaner_mutex);
+			mutex_lock(&fs_info->cleaner_mutex);
+			ret = relocate_block_group(rc);
+			mutex_unlock(&fs_info->cleaner_mutex);
 
-		finishes_stage = rc->stage;
-		/*
-		 * We may have gotten ENOSPC after we already dirtied some
-		 * extents.  If writeout happens while we're relocating a
-		 * different block group we could end up hitting the
-		 * BUG_ON(rc->stage == UPDATE_DATA_PTRS) in
-		 * btrfs_reloc_cow_block.  Make sure we write everything out
-		 * properly so we don't trip over this problem, and then break
-		 * out of the loop if we hit an error.
-		 */
-		if (rc->stage == MOVE_DATA_EXTENTS && rc->found_file_extent) {
-			int wb_ret;
-
-			wb_ret = btrfs_wait_ordered_range(BTRFS_I(rc->data_inode), 0,
-							  (u64)-1);
-			if (wb_ret && ret == 0)
-				ret = wb_ret;
-			invalidate_mapping_pages(rc->data_inode->i_mapping,
-						 0, -1);
-			rc->stage = UPDATE_DATA_PTRS;
-		}
+			finishes_stage = rc->stage;
+			/*
+			 * We may have gotten ENOSPC after we already dirtied
+			 * some extents.  If writeout happens while we're
+			 * relocating a different block group we could end up
+			 * hitting the BUG_ON(rc->stage == UPDATE_DATA_PTRS) in
+			 * btrfs_reloc_cow_block.  Make sure we write everything
+			 * out properly so we don't trip over this problem, and
+			 * then break out of the loop if we hit an error.
+			 */
+			if (rc->stage == MOVE_DATA_EXTENTS && rc->found_file_extent) {
+				int wb_ret;
+
+				wb_ret = btrfs_wait_ordered_range(BTRFS_I(rc->data_inode),
+								  0, (u64)-1);
+				if (wb_ret && ret == 0)
+					ret = wb_ret;
+				invalidate_mapping_pages(rc->data_inode->i_mapping,
+							 0, -1);
+				rc->stage = UPDATE_DATA_PTRS;
+			}
 
-		if (ret < 0)
-			goto out;
+			if (ret < 0)
+				goto out;
 
-		if (rc->extents_found == 0)
-			break;
+			if (rc->extents_found == 0)
+				break;
 
-		if (verbose)
-			btrfs_info(fs_info, "found %llu extents, stage: %s",
-				   rc->extents_found,
-				   stage_to_string(finishes_stage));
-	}
+			if (verbose)
+				btrfs_info(fs_info, "found %llu extents, stage: %s",
+					rc->extents_found,
+					stage_to_string(finishes_stage));
+		}
 
-	WARN_ON(rc->block_group->pinned > 0);
-	WARN_ON(rc->block_group->reserved > 0);
-	WARN_ON(rc->block_group->used > 0);
+		WARN_ON(rc->block_group->pinned > 0);
+		WARN_ON(rc->block_group->reserved > 0);
+		WARN_ON(rc->block_group->used > 0);
+	}
 out:
 	if (ret && bg_is_ro)
 		btrfs_dec_block_group_ro(rc->block_group);
-	iput(rc->data_inode);
+	if (!btrfs_fs_incompat(fs_info, REMAP_TREE))
+		iput(rc->data_inode);
+	btrfs_free_path(path);
 	reloc_chunk_end(fs_info);
 out_put_bg:
 	btrfs_put_block_group(bg);
@@ -4400,7 +4796,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 
 	btrfs_free_path(path);
 
-	if (ret == 0) {
+	if (ret == 0 && !btrfs_fs_incompat(fs_info, REMAP_TREE)) {
 		/* cleanup orphan inode in data relocation tree */
 		fs_root = btrfs_grab_root(fs_info->data_reloc_root);
 		ASSERT(fs_root);
diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
index 7cfe91971cab..bbb510a5d51c 100644
--- a/fs/btrfs/relocation.h
+++ b/fs/btrfs/relocation.h
@@ -12,6 +12,17 @@ struct btrfs_trans_handle;
 struct btrfs_ordered_extent;
 struct btrfs_pending_snapshot;
 
+static inline bool should_relocate_using_remap_tree(struct btrfs_block_group *bg)
+{
+	if (!btrfs_fs_incompat(bg->fs_info, REMAP_TREE))
+		return false;
+
+	if (bg->flags & (BTRFS_BLOCK_GROUP_SYSTEM | BTRFS_BLOCK_GROUP_REMAP))
+		return false;
+
+	return true;
+}
+
 int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
 			       bool verbose);
 int btrfs_init_reloc_root(struct btrfs_trans_handle *trans, struct btrfs_root *root);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 5baf5605e303..df37c61dec7d 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -366,8 +366,13 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 	factor = btrfs_bg_type_to_factor(block_group->flags);
 
 	spin_lock(&space_info->lock);
-	space_info->total_bytes += block_group->length;
-	space_info->disk_total += block_group->length * factor;
+
+	if (!(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED) ||
+	    block_group->identity_remap_count != 0) {
+		space_info->total_bytes += block_group->length;
+		space_info->disk_total += block_group->length * factor;
+	}
+
 	space_info->bytes_used += block_group->used;
 	space_info->disk_used += block_group->used * factor;
 	space_info->bytes_readonly += block_group->bytes_super;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2347b37113b0..abffb9f02ca7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3455,6 +3455,13 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset,
 	block_group = btrfs_lookup_block_group(fs_info, chunk_offset);
 	if (!block_group)
 		return -ENOENT;
+
+	/* If we're relocating using the remap tree we're now done. */
+	if (should_relocate_using_remap_tree(block_group)) {
+		btrfs_put_block_group(block_group);
+		return 0;
+	}
+
 	btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
 	length = block_group->length;
 	btrfs_put_block_group(block_group);
@@ -4155,6 +4162,14 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 		chunk = btrfs_item_ptr(leaf, slot, struct btrfs_chunk);
 		chunk_type = btrfs_chunk_type(leaf, chunk);
 
+		/* Check if chunk has already been fully relocated. */
+		if (chunk_type & BTRFS_BLOCK_GROUP_REMAPPED &&
+		    btrfs_chunk_num_stripes(leaf, chunk) == 0) {
+			btrfs_release_path(path);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
+			goto loop;
+		}
+
 		if (!counting) {
 			spin_lock(&fs_info->balance_lock);
 			bctl->stat.considered++;
-- 
2.51.0


