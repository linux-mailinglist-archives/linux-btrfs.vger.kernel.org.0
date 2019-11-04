Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC349EDF99
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 13:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbfKDMEB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 07:04:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:43848 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728592AbfKDMEA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Nov 2019 07:04:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F3309AED5
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Nov 2019 12:03:56 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 2/2] btrfs: Introduce new incompat feature, SKINNY_BG_TREE, to further reduce mount time
Date:   Mon,  4 Nov 2019 20:03:47 +0800
Message-Id: <20191104120347.56342-3-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104120347.56342-1-wqu@suse.com>
References: <20191104120347.56342-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The overall idea of the new SKINNY_BG_TREE is:
- Put block group items into a separate tree
- Reduce the size of block group item to minimal

This brings one obvious enhancement:
- Reduce mount time of large fs to minimal

With all these good news, there are still something we need extra
attention:
- Need extra chunk lookup when read block group
  To get the block group length and block group flags.

- We can no longer rely on key->offset for various block group context
  Only key->objectid is still the same.
  We need to get bg_len first, then pass it to existing infrastructure.

For now, if an existing fs want to take advantage of BG_TREE feature,
btrfs-progs will provide offline convertion tool.

[[Benchmark]]
Physical device:	NVMe SSD
VM device:		VirtIO block device, backup by sparse file
Nodesize:		4K  (to bump up tree height)
Extent data size:	4M
Fs size used:		1T

All file extents on disk is in 4M size, preallocated to reduce space usage
(as the VM uses loopback block device backed by sparse file)

Without patchset:
Use ftrace function graph:

 7)               |  open_ctree [btrfs]() {
 7)               |    btrfs_read_block_groups [btrfs]() {
 7) @ 805851.8 us |    }
 7) @ 911890.2 us |  }

 btrfs_read_block_groups() takes 88% of the total mount time,

With patchset, and use -O bg-tree mkfs option:

 5)               |  open_ctree [btrfs]() {
 5)               |    btrfs_read_block_groups [btrfs]() {
 5) * 63395.75 us |    }
 5) @ 143106.9 us |  }

  open_ctree() time is only 15% of original mount time.
  And btrfs_read_block_groups() only takes 7% of total open_ctree()
  execution time.

The reason is pretty obvious when considering how many tree blocks needs
to be read from disk:

          |  Extent tree  |  Regular bg tree |  Skinny bg tree  |
-----------------------------------------------------------------------
  nodes   |            55 |                1 |                1 |
  leaves  |          1025 |               13 |                7 |
  total   |          1080 |               14 |                8 |

The skinny bg tree reduces half of its tree blocks compared to regular
bg tree, less than 1% of extent tree implementation.

Not to mention all the tree blocks readahead works pretty fine for
regular and skinny bg tree, as we will read every item.
While readahead for extent tree will just be a diaster, as all block
groups are scatter across the whole extent tree.

The reduction of mount time is already obvious even on super fast NVMe
disk with memory cache.
It would be even more obvious if the fs is on spinning rust.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c          | 279 +++++++++++++++++++++++++-------
 fs/btrfs/block-rsv.c            |   2 +
 fs/btrfs/ctree.h                |   5 +-
 fs/btrfs/disk-io.c              |  14 ++
 fs/btrfs/sysfs.c                |   2 +
 include/uapi/linux/btrfs.h      |   1 +
 include/uapi/linux/btrfs_tree.h |  11 ++
 7 files changed, 252 insertions(+), 62 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 7a1e4a8fb52b..7b38c4870f5c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -856,7 +856,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 			     u64 group_start, struct extent_map *em)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_root *root;
 	struct btrfs_path *path;
 	struct btrfs_block_group_cache *block_group;
 	struct btrfs_free_cluster *cluster;
@@ -1054,10 +1054,6 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 
 	spin_unlock(&block_group->space_info->lock);
 
-	key.objectid = block_group->start;
-	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
-	key.offset = block_group->length;
-
 	mutex_lock(&fs_info->chunk_mutex);
 	spin_lock(&block_group->lock);
 	block_group->removed = 1;
@@ -1096,11 +1092,35 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	btrfs_put_block_group(block_group);
 	btrfs_put_block_group(block_group);
 
-	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
-	if (ret > 0)
-		ret = -EIO;
-	if (ret < 0)
-		goto out;
+	if (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE)) {
+		root = fs_info->bg_root;
+		key.objectid = block_group->start;
+		key.type = BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY;
+		key.offset = (u64)-1;
+		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
+		if (ret == 0)
+			ret = -EINVAL;
+		if (ret > 0) {
+			ret = btrfs_previous_item(root, path, key.objectid,
+						  key.type);
+			if (ret > 0)
+				ret = -ENOENT;
+		}
+		if (ret < 0)
+			goto out;
+
+	} else {
+		root = fs_info->extent_root;
+		key.objectid = block_group->start;
+		key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+		key.offset = block_group->length;
+		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
+		if (ret > 0)
+			ret = -EIO;
+		if (ret < 0)
+			goto out;
+	}
+
 
 	ret = btrfs_del_item(trans, root, path);
 	if (ret)
@@ -1685,19 +1705,56 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	struct btrfs_block_group_cache *cache;
 	struct btrfs_space_info *space_info;
 	struct btrfs_key key;
-	struct btrfs_block_group_item bgi;
 	int mixed = btrfs_fs_incompat(info, MIXED_GROUPS);
 	int slot = path->slots[0];
+	u64 bg_len;
+	u64 flags;
+	u64 used;
 	int ret;
 
 	btrfs_item_key_to_cpu(leaf, &key, slot);
-	ASSERT(key.type == BTRFS_BLOCK_GROUP_ITEM_KEY);
+	ASSERT((!btrfs_fs_incompat(info, SKINNY_BG_TREE) &&
+		key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) ||
+	       (btrfs_fs_incompat(info, SKINNY_BG_TREE) &&
+		key.type == BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY));
+
+	if (key.type == BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY) {
+		struct extent_map *em = NULL;
+
+		em = btrfs_get_chunk_map(info, key.objectid, 1);
+		if (IS_ERR(em)) {
+			return PTR_ERR(em);
+		}
+		if (em->start != key.objectid) {
+			btrfs_err(info, "no chunk found for bytenr %llu",
+				  key.objectid);
+			free_extent_map(em);
+			return -EUCLEAN;
+		}
+		if (key.offset > em->len) {
+			btrfs_err(info,
+				"invalid bg used, have %llu expect [0, %llu]",
+				  key.offset, em->len);
+			free_extent_map(em);
+			return -EUCLEAN;
+		}
+		bg_len = em->len;
+		flags = em->flags;
+		used = key.offset;
+		free_extent_map(em);
+	} else {
+		struct btrfs_block_group_item bgi;
 
-	cache = btrfs_create_block_group_cache(info, key.objectid,
-					       key.offset);
+		bg_len = key.offset;
+		read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
+				   sizeof(bgi));
+		flags = btrfs_stack_block_group_flags(&bgi);
+		used = btrfs_stack_block_group_used(&bgi);
+	}
+
+	cache = btrfs_create_block_group_cache(info, key.objectid, bg_len);
 	if (!cache)
 		return -ENOMEM;
-
 	if (need_clear) {
 		/*
 		 * When we mount with old space cache, we need to
@@ -1712,10 +1769,9 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		if (btrfs_test_opt(info, SPACE_CACHE))
 			cache->disk_cache_state = BTRFS_DC_CLEAR;
 	}
-	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
-			   sizeof(bgi));
-	cache->flags = btrfs_stack_block_group_flags(&bgi);
-	cache->used = btrfs_stack_block_group_used(&bgi);
+	cache->flags = flags;
+	cache->used = used;
+
 	if (!mixed && ((cache->flags & BTRFS_BLOCK_GROUP_METADATA) &&
 	    (cache->flags & BTRFS_BLOCK_GROUP_DATA))) {
 			btrfs_err(info,
@@ -1743,7 +1799,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	 * are empty, and we can just add all the space in and be done with it.
 	 * This saves us _a_lot_ of time, particularly in the full case.
 	 */
-	if (key.offset == cache->used) {
+	if (bg_len == cache->used) {
 		cache->last_byte_to_unpin = (u64)-1;
 		cache->cached = BTRFS_CACHE_FINISHED;
 		btrfs_free_excluded_extents(cache);
@@ -1751,7 +1807,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		cache->last_byte_to_unpin = (u64)-1;
 		cache->cached = BTRFS_CACHE_FINISHED;
 		add_new_free_space(cache, key.objectid,
-				   key.objectid + key.offset);
+				   key.objectid + bg_len);
 		btrfs_free_excluded_extents(cache);
 	}
 	ret = btrfs_add_block_group_cache(info, cache);
@@ -1760,7 +1816,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		goto error;
 	}
 	trace_btrfs_add_block_group(info, cache, 0);
-	btrfs_update_space_info(info, cache->flags, key.offset, cache->used,
+	btrfs_update_space_info(info, cache->flags, bg_len, cache->used,
 				cache->bytes_super, &space_info);
 
 	cache->space_info = space_info;
@@ -1780,6 +1836,58 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	return ret;
 }
 
+static int read_skinny_block_group_tree(struct btrfs_fs_info *info,
+					int need_clear)
+{
+	struct btrfs_path *path;
+	struct btrfs_key key;
+	int ret;
+
+	key.objectid = 0;
+	key.offset = 0;
+	key.type = 0;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	ret = btrfs_search_slot(NULL, info->bg_root, &key, path, 0, 0);
+	if (ret < 0)
+		return ret;
+	if (ret == 0) {
+		btrfs_err(info,
+			  "found invalid block group bytenr %llu len %llu",
+			  key.objectid, key.offset);
+		ret = -EUCLEAN;
+		goto out;
+	}
+
+	while (1) {
+		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+		if (key.type != BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY) {
+			btrfs_err(info,
+		"found invalid key (%llu, %u, %llu) in block group tree",
+				  key.objectid, key.type, key.offset);
+			ret = -EUCLEAN;
+			goto out;
+		}
+
+		ret = read_one_block_group(info, path, need_clear);
+		if (ret < 0)
+			goto out;
+		ret = btrfs_next_item(info->bg_root, path);
+		if (ret < 0)
+			goto out;
+		if (ret > 0) {
+			ret = 0;
+			goto out;
+		}
+	}
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
 int btrfs_read_block_groups(struct btrfs_fs_info *info)
 {
 	struct btrfs_path *path;
@@ -1805,20 +1913,26 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	if (btrfs_test_opt(info, CLEAR_CACHE))
 		need_clear = 1;
 
-	while (1) {
-		ret = find_first_block_group(info, path, &key);
-		if (ret > 0)
-			break;
-		if (ret != 0)
-			goto error;
-
-		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-		ret = read_one_block_group(info, path, need_clear);
+	if (btrfs_fs_incompat(info, SKINNY_BG_TREE)) {
+		ret = read_skinny_block_group_tree(info, need_clear);
 		if (ret < 0)
 			goto error;
-		key.objectid += key.offset;
-		key.offset = 0;
-		btrfs_release_path(path);
+	} else {
+		while (1) {
+			ret = find_first_block_group(info, path, &key);
+			if (ret > 0)
+				break;
+			if (ret != 0)
+				goto error;
+
+			btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+			ret = read_one_block_group(info, path, need_clear);
+			if (ret < 0)
+				goto error;
+			key.objectid += key.offset;
+			key.offset = 0;
+			btrfs_release_path(path);
+		}
 	}
 
 	list_for_each_entry_rcu(space_info, &info->space_info, list) {
@@ -1853,9 +1967,11 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_block_group_cache *block_group;
-	struct btrfs_root *extent_root = fs_info->extent_root;
 	struct btrfs_block_group_item item;
+	struct btrfs_root *root;
 	struct btrfs_key key;
+	void *data;
+	u32 data_size;
 	int ret = 0;
 
 	if (!trans->can_flush_pending_bgs)
@@ -1869,20 +1985,33 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 			goto next;
 
 		spin_lock(&block_group->lock);
-		btrfs_set_stack_block_group_used(&item, block_group->used);
-		btrfs_set_stack_block_group_chunk_objectid(&item,
-				BTRFS_FIRST_CHUNK_TREE_OBJECTID);
-		btrfs_set_stack_block_group_flags(&item, block_group->flags);
-		key.objectid = block_group->start;
-		key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
-		key.offset = block_group->length;
+		if (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE)) {
+			key.objectid = block_group->start;
+			key.type = BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY;
+			key.offset = block_group->used;
+			data = NULL;
+			data_size = 0;
+			root = fs_info->bg_root;
+		} else {
+
+			btrfs_set_stack_block_group_used(&item, block_group->used);
+			btrfs_set_stack_block_group_chunk_objectid(&item,
+						BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+			btrfs_set_stack_block_group_flags(&item,
+							  block_group->flags);
+			key.objectid = block_group->start;
+			key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+			key.offset = block_group->length;
+			data = &item;
+			data_size = sizeof(item);
+			root = fs_info->extent_root;
+		}
 		spin_unlock(&block_group->lock);
 
-		ret = btrfs_insert_item(trans, extent_root, &key, &item,
-					sizeof(item));
+		ret = btrfs_insert_item(trans, root, &key, data, data_size);
 		if (ret)
 			btrfs_abort_transaction(trans, ret);
-		ret = btrfs_finish_chunk_alloc(trans, key.objectid, key.offset);
+		ret = btrfs_finish_chunk_alloc(trans, key.objectid, block_group->length);
 		if (ret)
 			btrfs_abort_transaction(trans, ret);
 		add_block_group_free_space(trans, block_group);
@@ -2109,30 +2238,58 @@ static int write_one_cache_group(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	int ret;
-	struct btrfs_root *extent_root = fs_info->extent_root;
+	struct btrfs_root *root;
 	unsigned long bi;
 	struct extent_buffer *leaf;
 	struct btrfs_block_group_item bgi;
 	struct btrfs_key key;
 
-	key.objectid = cache->start;
-	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
-	key.offset = cache->length;
+	if (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE)) {
+		root = fs_info->bg_root;
+		key.objectid = cache->start;
+		key.type = BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY;
+		key.offset = (u64)-1;
 
-	ret = btrfs_search_slot(trans, extent_root, &key, path, 0, 1);
-	if (ret) {
-		if (ret > 0)
-			ret = -ENOENT;
-		goto fail;
+		ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
+		if (ret == 0) {
+			btrfs_err(fs_info,
+			"invalid skinny block group item found for bg %llu",
+				  cache->start);
+			ret = -EUCLEAN;
+			goto fail;
+		}
+		if (ret > 0) {
+			ret = btrfs_previous_item(root, path, key.objectid,
+						  key.type);
+			if (ret > 0)
+				ret = -ENOENT;
+		}
+		if (ret < 0)
+			goto fail;
+		key.offset = cache->used;
+		btrfs_set_item_key_safe(fs_info, path, &key);
+		leaf = path->nodes[0];
+	} else {
+		root = fs_info->extent_root;
+		key.objectid = cache->start;
+		key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+		key.offset = cache->length;
+
+		ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
+		if (ret) {
+			if (ret > 0)
+				ret = -ENOENT;
+			goto fail;
+		}
+		leaf = path->nodes[0];
+		bi = btrfs_item_ptr_offset(leaf, path->slots[0]);
+		btrfs_set_stack_block_group_used(&bgi, cache->used);
+		btrfs_set_stack_block_group_chunk_objectid(&bgi,
+				BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+		btrfs_set_stack_block_group_flags(&bgi, cache->flags);
+		write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
 	}
 
-	leaf = path->nodes[0];
-	bi = btrfs_item_ptr_offset(leaf, path->slots[0]);
-	btrfs_set_stack_block_group_used(&bgi, cache->used);
-	btrfs_set_stack_block_group_chunk_objectid(&bgi,
-			BTRFS_FIRST_CHUNK_TREE_OBJECTID);
-	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
-	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
 	btrfs_mark_buffer_dirty(leaf);
 fail:
 	btrfs_release_path(path);
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index d07bd41a7c1e..e34f89de10f6 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -337,6 +337,8 @@ void btrfs_init_global_block_rsv(struct btrfs_fs_info *fs_info)
 	fs_info->tree_root->block_rsv = &fs_info->global_block_rsv;
 	if (fs_info->quota_root)
 		fs_info->quota_root->block_rsv = &fs_info->global_block_rsv;
+	if (fs_info->bg_root)
+		fs_info->bg_root->block_rsv = &fs_info->global_block_rsv;
 	fs_info->chunk_root->block_rsv = &fs_info->chunk_block_rsv;
 
 	btrfs_update_global_block_rsv(fs_info);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1c8f01eaf27c..d3429dd32a7e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -292,7 +292,8 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |		\
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
-	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID)
+	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
+	 BTRFS_FEATURE_INCOMPAT_SKINNY_BG_TREE)
 
 #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
 	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
@@ -539,6 +540,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *quota_root;
 	struct btrfs_root *uuid_root;
 	struct btrfs_root *free_space_root;
+	struct btrfs_root *bg_root;
 
 	/* the log root tree is a directory of all the other log roots */
 	struct btrfs_root *log_root_tree;
@@ -2659,6 +2661,7 @@ static inline void free_fs_info(struct btrfs_fs_info *fs_info)
 	kfree(fs_info->quota_root);
 	kfree(fs_info->uuid_root);
 	kfree(fs_info->free_space_root);
+	kfree(fs_info->bg_root);
 	kfree(fs_info->super_copy);
 	kfree(fs_info->super_for_commit);
 	kvfree(fs_info);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 315fc2f2269d..29e37b536d9b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1573,6 +1573,8 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 	if (location->objectid == BTRFS_FREE_SPACE_TREE_OBJECTID)
 		return fs_info->free_space_root ? fs_info->free_space_root :
 						  ERR_PTR(-ENOENT);
+	if (location->objectid == BTRFS_BLOCK_GROUP_TREE_OBJECTID)
+		return fs_info->bg_root ? fs_info->bg_root: ERR_PTR(-ENOENT);
 again:
 	root = btrfs_lookup_fs_root(fs_info, location->objectid);
 	if (root) {
@@ -1993,6 +1995,7 @@ static void free_root_pointers(struct btrfs_fs_info *info, bool free_chunk_root)
 	if (free_chunk_root)
 		free_root_extent_buffers(info->chunk_root);
 	free_root_extent_buffers(info->free_space_root);
+	free_root_extent_buffers(info->bg_root);
 }
 
 void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info)
@@ -2270,6 +2273,17 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
 	fs_info->extent_root = root;
 
+	if (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE)) {
+		location.objectid = BTRFS_BLOCK_GROUP_TREE_OBJECTID;
+		root = btrfs_read_tree_root(tree_root, &location);
+		if (IS_ERR(root)) {
+			ret = PTR_ERR(root);
+			goto out;
+		}
+		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+		fs_info->bg_root = root;
+	}
+
 	location.objectid = BTRFS_DEV_TREE_OBJECTID;
 	root = btrfs_read_tree_root(tree_root, &location);
 	if (IS_ERR(root)) {
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 4a78bc4ec62e..739627c03679 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -258,6 +258,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(raid56, RAID56);
 BTRFS_FEAT_ATTR_INCOMPAT(skinny_metadata, SKINNY_METADATA);
 BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
 BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
+BTRFS_FEAT_ATTR_INCOMPAT(skinny_bg_tree, SKINNY_BG_TREE);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 
 /*
@@ -283,6 +284,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(no_holes),
 	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
 	BTRFS_FEAT_ATTR_PTR(free_space_tree),
+	BTRFS_FEAT_ATTR_PTR(skinny_bg_tree),
 	NULL
 };
 
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 3ee0678c0a83..2c5f47eaa25b 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -270,6 +270,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA	(1ULL << 8)
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID	(1ULL << 10)
+#define BTRFS_FEATURE_INCOMPAT_SKINNY_BG_TREE	(1ULL << 11)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 5160be1d7332..d1fa31234719 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -48,6 +48,9 @@
 /* tracks free space in block groups. */
 #define BTRFS_FREE_SPACE_TREE_OBJECTID 10ULL
 
+/* sotre BLOCK_GROUP_ITEMs in a seprate tree */
+#define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
+
 /* device stats in the device tree */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
 
@@ -182,6 +185,14 @@
  */
 #define BTRFS_BLOCK_GROUP_ITEM_KEY 192
 
+/*
+ * A more optimized structure for block group item.
+ * key.objectid = bg->start
+ * key.offset = bg->used
+ * No item needed, all other info can be extracted from corresponding chunk.
+ */
+#define BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY 193
+
 /*
  * Every block group is represented in the free space tree by a free space info
  * item, which stores some accounting information. It is keyed on
-- 
2.23.0

