Return-Path: <linux-btrfs+bounces-18308-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD04C07A98
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 20:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE0924F3C73
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 18:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6D6346E74;
	Fri, 24 Oct 2025 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="pAeL4R2C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38341347FE8
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329566; cv=none; b=nsRHE+wWSbt4IbLEHx8KkY83crT9OiSPMqTFUvSF73SwplAmM7X4EjfUsB6Ty6zhlVqWyJ1QYMHjR6OBPEYs1uwtb7H5FH1YbwJSo7igSdQi8AoexX1khYnsAzdKByWX6FAE/KiPcuCqGcu7Ln1uGmvdmRpY3rxMhyKuwHACmpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329566; c=relaxed/simple;
	bh=g7DZNP2U/ujCPEROzNLKqwl1RX40oGxQwT5DyeXdK8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=bd1Cjh3KGFaI64G8StUmJrhIoGdgswORcr6I0SPxMZUgWvR8W/+Jv1+NLn14UKrdp7SJktwavg/U7cBGQOCpXFfpjcV7Q0J9U/vGzXmPgrdE9Ovzx0LuVPib0evCT8XZBkcIW+HlYVlxeqiSvJZtpeIVlsePgPOPZnjZqKyCmzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=pAeL4R2C; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id D54002CFE4F;
	Fri, 24 Oct 2025 19:12:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1761329550;
	bh=pQ7xWqYpPi/zn4B75/DL49s/j7XHeYaag/2q+ib97U4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pAeL4R2CnUYxrLHmZ1JeDlaexEXdMjDVaaHhshUkTspy0N1MDqCtMxs7+t5JePzHO
	 eHSTViW6QHKXzmhhdUyNtCPCtTDEk3EzKhomQkMP2uFmFy8kp/TT94H8/bJONurAtX
	 /A4ZstAKtWiFd8LnXBPITzB2II0GqwqW0NoFjB/g=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v4 10/16] btrfs: handle setting up relocation of block group with remap-tree
Date: Fri, 24 Oct 2025 19:12:11 +0100
Message-ID: <20251024181227.32228-11-mark@harmstone.com>
In-Reply-To: <20251024181227.32228-1-mark@harmstone.com>
References: <20251024181227.32228-1-mark@harmstone.com>
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
 fs/btrfs/relocation.c      | 423 ++++++++++++++++++++++++++++++++++++-
 fs/btrfs/relocation.h      |   2 +-
 fs/btrfs/space-info.c      |   9 +-
 fs/btrfs/volumes.c         |  15 +-
 8 files changed, 447 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 3bf5f20d90ec..8feddb472882 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2423,6 +2423,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	cache->used = btrfs_stack_block_group_v2_used(bgi);
 	cache->commit_used = cache->used;
 	cache->flags = btrfs_stack_block_group_v2_flags(bgi);
+	cache->commit_flags = cache->flags;
 	cache->global_root_id = btrfs_stack_block_group_v2_chunk_objectid(bgi);
 	cache->space_info = btrfs_find_space_info(info, cache->flags);
 	cache->remap_bytes = btrfs_stack_block_group_v2_remap_bytes(bgi);
@@ -2732,6 +2733,7 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 	block_group->commit_remap_bytes = block_group->remap_bytes;
 	block_group->commit_identity_remap_count =
 		block_group->identity_remap_count;
+	block_group->commit_flags = block_group->flags;
 	key.objectid = block_group->start;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	key.offset = block_group->length;
@@ -3220,13 +3222,15 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
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
index 9f3ce3395d6a..cd53509c2fda 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3627,7 +3627,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		btrfs_btree_balance_dirty(fs_info);
 	}
 
-	if (!err) {
+	if (!err && !btrfs_fs_incompat(fs_info, REMAP_TREE)) {
 		ret = relocate_file_extent_cluster(rc);
 		if (ret < 0)
 			err = ret;
@@ -3871,6 +3871,90 @@ static const char *stage_to_string(enum reloc_stage stage)
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
@@ -3903,6 +3987,184 @@ static void adjust_block_group_remap_bytes(struct btrfs_trans_handle *trans,
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
@@ -4016,6 +4278,55 @@ static void adjust_identity_remap_count(struct btrfs_trans_handle *trans,
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
@@ -4070,17 +4381,94 @@ int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
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
 int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
-			       bool verbose)
+			       bool verbose, bool *using_remap_tree)
 {
 	struct btrfs_block_group *bg;
 	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, group_start);
 	struct reloc_control *rc;
 	struct inode *inode;
-	struct btrfs_path *path;
+	struct btrfs_path *path = NULL;
 	int ret;
 	bool bg_is_ro = false;
 
@@ -4142,7 +4530,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
 	}
 
 	inode = lookup_free_space_inode(rc->block_group, path);
-	btrfs_free_path(path);
+	btrfs_release_path(path);
 
 	if (!IS_ERR(inode))
 		ret = delete_block_group_cache(rc->block_group, inode, 0);
@@ -4152,11 +4540,17 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
 	if (ret && ret != -ENOENT)
 		goto out;
 
-	rc->data_inode = create_reloc_inode(rc->block_group);
-	if (IS_ERR(rc->data_inode)) {
-		ret = PTR_ERR(rc->data_inode);
-		rc->data_inode = NULL;
-		goto out;
+	*using_remap_tree = btrfs_fs_incompat(fs_info, REMAP_TREE) &&
+		!(bg->flags & BTRFS_BLOCK_GROUP_SYSTEM) &&
+		!(bg->flags & BTRFS_BLOCK_GROUP_REMAP);
+
+	if (!btrfs_fs_incompat(fs_info, REMAP_TREE)) {
+		rc->data_inode = create_reloc_inode(rc->block_group);
+		if (IS_ERR(rc->data_inode)) {
+			ret = PTR_ERR(rc->data_inode);
+			rc->data_inode = NULL;
+			goto out;
+		}
 	}
 
 	if (verbose)
@@ -4169,6 +4563,11 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
 	ret = btrfs_zone_finish(rc->block_group);
 	WARN_ON(ret && ret != -EAGAIN);
 
+	if (*using_remap_tree) {
+		ret = start_block_group_remapping(fs_info, path, bg);
+		goto out;
+	}
+
 	while (1) {
 		enum reloc_stage finishes_stage;
 
@@ -4216,7 +4615,9 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
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
@@ -4410,7 +4811,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 
 	btrfs_free_path(path);
 
-	if (ret == 0) {
+	if (ret == 0 && !btrfs_fs_incompat(fs_info, REMAP_TREE)) {
 		/* cleanup orphan inode in data relocation tree */
 		fs_root = btrfs_grab_root(fs_info->data_reloc_root);
 		ASSERT(fs_root);
diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
index 7cfe91971cab..fbe191ff5d08 100644
--- a/fs/btrfs/relocation.h
+++ b/fs/btrfs/relocation.h
@@ -13,7 +13,7 @@ struct btrfs_ordered_extent;
 struct btrfs_pending_snapshot;
 
 int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
-			       bool verbose);
+			       bool verbose, bool *using_remap_tree);
 int btrfs_init_reloc_root(struct btrfs_trans_handle *trans, struct btrfs_root *root);
 int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index a2ce72d3e873..752d098d1a6a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -375,8 +375,13 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
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
index 99ad95e1c300..cda94c6f5239 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3418,6 +3418,7 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset,
 	struct btrfs_block_group *block_group;
 	u64 length;
 	int ret;
+	bool using_remap_tree;
 
 	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
 		btrfs_err(fs_info,
@@ -3441,7 +3442,8 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset,
 
 	/* step one, relocate all the extents inside this chunk */
 	btrfs_scrub_pause(fs_info);
-	ret = btrfs_relocate_block_group(fs_info, chunk_offset, true);
+	ret = btrfs_relocate_block_group(fs_info, chunk_offset, true,
+					 &using_remap_tree);
 	btrfs_scrub_continue(fs_info);
 	if (ret) {
 		/*
@@ -3453,6 +3455,9 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset,
 		return ret;
 	}
 
+	if (using_remap_tree)
+		return 0;
+
 	block_group = btrfs_lookup_block_group(fs_info, chunk_offset);
 	if (!block_group)
 		return -ENOENT;
@@ -4156,6 +4161,14 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
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
2.49.1


