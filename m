Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51D7CEDFA0
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 13:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbfKDMEV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 07:04:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:44040 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728592AbfKDMEU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Nov 2019 07:04:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 82623AF6A
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Nov 2019 12:04:17 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 2/7] btrfs-progs: Enable read-write ability for 'skinny_bg_tree' feature
Date:   Mon,  4 Nov 2019 20:03:56 +0800
Message-Id: <20191104120401.56408-3-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104120401.56408-1-wqu@suse.com>
References: <20191104120401.56408-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Allow btrfs-progs to open, read and write 'skinny_bg_tree' enabled fs.

The modification itself is not large, as block groups items are only
used at 4 timing:

1) open_ctree()
   We only need to populate fs_info->bg_root and read block group items
   from fs_info->bg_root.
   The obvious change is, we don't need to do btrfs_search_slot() for
   each block group item, but btrfs_next_item() is enough.

   This should hugely reduce open_ctree() execution duration.

2) btrfs_commit_transaction()
   We need to write back dirty block group items back to bg_root.

   The modification here is to insert new block group item if we can't
   find one existing in bg_root, and delete the old one in extent tree
   if we're converting to skinny_bg_tree feature.

3) btrfs_make_block_group()
   For skinny_bg_tree feature, we insert key only, with key.offset ==
   used.

   This modification needs extra handling for converting case, where
   block group items can be either in extent tree or bg tree.

4) free_block_group_item()
   Just delete the block group item in extent tree or bg tree.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 ctree.h       |  17 +++-
 disk-io.c     |  21 ++++-
 extent-tree.c | 230 ++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 251 insertions(+), 17 deletions(-)

diff --git a/ctree.h b/ctree.h
index ec57f113839f..a93e1d5d202d 100644
--- a/ctree.h
+++ b/ctree.h
@@ -89,6 +89,9 @@ struct btrfs_free_space_ctl;
 /* tracks free space in block groups. */
 #define BTRFS_FREE_SPACE_TREE_OBJECTID 10ULL
 
+/* store BLOCK_GROUP_ITEMS in a seperate tree */
+#define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
+
 /* device stats in the device tree */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
 
@@ -492,6 +495,7 @@ struct btrfs_super_block {
 #define BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA	(1ULL << 8)
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID    (1ULL << 10)
+#define BTRFS_FEATURE_INCOMPAT_SKINNY_BG_TREE	(1ULL << 11)
 
 #define BTRFS_FEATURE_COMPAT_SUPP		0ULL
 
@@ -515,7 +519,8 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS |		\
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES |		\
-	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID)
+	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID |		\
+	 BTRFS_FEATURE_INCOMPAT_SKINNY_BG_TREE)
 
 /*
  * A leaf is full of items. offset and size tell us where to find
@@ -1125,6 +1130,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *quota_root;
 	struct btrfs_root *free_space_root;
 	struct btrfs_root *uuid_root;
+	struct btrfs_root *bg_root;
 
 	struct rb_root fs_root_tree;
 
@@ -1176,6 +1182,8 @@ struct btrfs_fs_info {
 	unsigned int avoid_meta_chunk_alloc:1;
 	unsigned int avoid_sys_chunk_alloc:1;
 	unsigned int finalize_on_close:1;
+	/* Converting from bg in extent tree to skinny bg tree */
+	unsigned int convert_to_bg_tree:1;
 
 	int transaction_aborted;
 
@@ -1332,6 +1340,13 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
  */
 #define BTRFS_BLOCK_GROUP_ITEM_KEY 192
 
+/*
+ * More optimized block group item, use key.objectid for block group bytenr,
+ * key.offset for used bytes.
+ * No item data needed.
+ */
+#define BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY 193
+
 /*
  * Every block group is represented in the free space tree by a free space info
  * item, which stores some accounting information. It is keyed on
diff --git a/disk-io.c b/disk-io.c
index a5b47b0ef16c..1cb62511f4ad 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -731,6 +731,8 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_fs_info *fs_info,
 	if (location->objectid == BTRFS_FREE_SPACE_TREE_OBJECTID)
 		return fs_info->free_space_root ? fs_info->free_space_root :
 						ERR_PTR(-ENOENT);
+	if (location->objectid == BTRFS_BLOCK_GROUP_TREE_OBJECTID)
+		return fs_info->bg_root ? fs_info->bg_root : ERR_PTR(-ENOENT);
 
 	BUG_ON(location->objectid == BTRFS_TREE_RELOC_OBJECTID ||
 	       location->offset != (u64)-1);
@@ -783,6 +785,7 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
 	fs_info->quota_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->free_space_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->uuid_root = calloc(1, sizeof(struct btrfs_root));
+	fs_info->bg_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->super_copy = calloc(1, BTRFS_SUPER_INFO_SIZE);
 
 	if (!fs_info->tree_root || !fs_info->extent_root ||
@@ -932,7 +935,6 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 		root_tree_bytenr = btrfs_backup_tree_root(backup);
 		generation = btrfs_backup_tree_root_gen(backup);
 	}
-
 	root->node = read_tree_block(fs_info, root_tree_bytenr, generation);
 	if (!extent_buffer_uptodate(root->node)) {
 		fprintf(stderr, "Couldn't read tree root\n");
@@ -945,6 +947,21 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 		return ret;
 	fs_info->extent_root->track_dirty = 1;
 
+	if (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE)) {
+		ret = setup_root_or_create_block(fs_info, flags,
+					fs_info->bg_root,
+					BTRFS_BLOCK_GROUP_TREE_OBJECTID, "bg");
+		if (ret < 0) {
+			error("Couldn't setup bg tree");
+			return ret;
+		}
+		fs_info->bg_root->track_dirty = 1;
+		fs_info->bg_root->ref_cows = 0;
+	} else {
+		free(fs_info->bg_root);
+		fs_info->bg_root = NULL;
+	}
+
 	ret = find_and_setup_root(root, fs_info, BTRFS_DEV_TREE_OBJECTID,
 				  fs_info->dev_root);
 	if (ret) {
@@ -1035,6 +1052,8 @@ void btrfs_release_all_roots(struct btrfs_fs_info *fs_info)
 		free_extent_buffer(fs_info->extent_root->node);
 	if (fs_info->tree_root)
 		free_extent_buffer(fs_info->tree_root->node);
+	if (fs_info->bg_root)
+		free_extent_buffer(fs_info->bg_root->node);
 	if (fs_info->log_root_tree)
 		free_extent_buffer(fs_info->log_root_tree->node);
 	if (fs_info->chunk_root)
diff --git a/extent-tree.c b/extent-tree.c
index d67e4098351f..7c68508de2ac 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -1524,6 +1524,67 @@ int btrfs_dec_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	return __btrfs_mod_ref(trans, root, buf, record_parent, 0);
 }
 
+static int write_one_skinny_block_group(struct btrfs_trans_handle *trans,
+					struct btrfs_path *path,
+					struct btrfs_block_group_cache *cache)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *bg_root = fs_info->bg_root;
+	struct btrfs_key key;
+	int ret;
+
+	ASSERT(bg_root && btrfs_fs_incompat(fs_info, SKINNY_BG_TREE));
+	key.objectid = cache->key.objectid;
+	key.type = BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY;
+	key.offset = (u64)-1;
+
+	ret = btrfs_search_slot(trans, bg_root, &key, path, 0, 1);
+	if (ret < 0)
+		return ret;
+	if (ret == 0) {
+		error("invalid skinny bg found, start=%llu", key.objectid);
+		ret = -EUCLEAN;
+		goto out;
+	}
+	ret = btrfs_previous_item(bg_root, path, key.objectid, key.type);
+	if (ret < 0)
+		goto out;
+	if (ret > 0 && fs_info->convert_to_bg_tree) {
+		btrfs_release_path(path);
+
+		/* We are doing convert, insert new one for it */
+		key.offset = cache->used;
+		ret = btrfs_insert_item(trans, bg_root, &key, NULL, 0);
+		if (ret < 0)
+			goto out;
+
+		/* Also delete the existing one in extent tree */
+		key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+		key.offset = cache->key.offset;
+
+		ret = btrfs_search_slot(trans, fs_info->extent_root, &key,
+					path, -1, 1);
+		if (ret < 0)
+			goto out;
+		if (ret > 0) {
+			ret = 0;
+			goto out;
+		}
+		ret = btrfs_del_item(trans, fs_info->extent_root, path);
+		goto out;
+	}
+	if (ret > 0) {
+		ret = -ENOENT;
+		goto out;
+	}
+	key.offset = cache->used;
+	btrfs_set_item_key_safe(bg_root, path, &key);
+	btrfs_mark_buffer_dirty(path->nodes[0]);
+out:
+	btrfs_release_path(path);
+	return ret;
+}
+
 static int write_one_cache_group(struct btrfs_trans_handle *trans,
 				 struct btrfs_path *path,
 				 struct btrfs_block_group_cache *cache)
@@ -1534,6 +1595,9 @@ static int write_one_cache_group(struct btrfs_trans_handle *trans,
 	struct btrfs_block_group_item bgi;
 	struct extent_buffer *leaf;
 
+	if (btrfs_fs_incompat(trans->fs_info, SKINNY_BG_TREE))
+		return write_one_skinny_block_group(trans, path, cache);
+
 	ret = btrfs_search_slot(trans, extent_root, &cache->key, path, 0, 1);
 	if (ret < 0)
 		goto fail;
@@ -2665,32 +2729,63 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 	struct extent_buffer *leaf = path->nodes[0];
 	struct btrfs_space_info *space_info;
 	struct btrfs_block_group_cache *cache;
-	struct btrfs_block_group_item bgi;
 	struct btrfs_key key;
+	u64 bg_len;
+	u64 flags;
+	u64 used;
 	int slot = path->slots[0];
 	int bit = 0;
 	int ret;
 
 	btrfs_item_key_to_cpu(leaf, &key, slot);
-	ASSERT(key.type == BTRFS_BLOCK_GROUP_ITEM_KEY);
+	ASSERT((!btrfs_fs_incompat(fs_info, SKINNY_BG_TREE) &&
+		key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) ||
+	       (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE) &&
+		key.type == BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY));
 
 	/*
 	 * Skip 0 sized block group, don't insert them into block group cache
 	 * tree, as its length is 0, it won't get freed at close_ctree() time.
 	 */
-	if (key.offset == 0)
+	if (key.type == BTRFS_BLOCK_GROUP_ITEM_KEY && key.offset == 0)
 		return 0;
 
+	if (key.type == BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY) {
+		struct btrfs_mapping_tree *map_tree = &fs_info->mapping_tree;
+		struct map_lookup *map;
+		struct cache_extent *ce;
+
+		ce = search_cache_extent(&map_tree->cache_tree, key.objectid);
+		if (!ce || ce->start != key.objectid) {
+			error(
+		"invalid skinny block group %llu: no corresponding chunk",
+				key.objectid);
+			return -ENOENT;
+		}
+		bg_len = ce->size;
+		map = container_of(ce, struct map_lookup, ce);
+		flags = map->type;
+		used = key.offset;
+	} else {
+		struct btrfs_block_group_item bgi;
+
+		bg_len = key.offset;
+		read_extent_buffer(leaf, &bgi,
+				   btrfs_item_ptr_offset(leaf, slot),
+				   sizeof(bgi));
+		flags = btrfs_block_group_flags(&bgi);
+		used = btrfs_block_group_used(&bgi);
+	}
 	cache = kzalloc(sizeof(*cache), GFP_NOFS);
 	if (!cache)
 		return -ENOMEM;
-	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
-			   sizeof(bgi));
-	memcpy(&cache->key, &key, sizeof(key));
 	cache->cached = 0;
 	cache->pinned = 0;
-	cache->flags = btrfs_block_group_flags(&bgi);
-	cache->used = btrfs_block_group_used(&bgi);
+	cache->flags = flags;
+	cache->used = used;
+	cache->key.objectid = key.objectid;
+	cache->key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+	cache->key.offset = bg_len;
 	if (cache->flags & BTRFS_BLOCK_GROUP_DATA) {
 		bit = BLOCK_GROUP_DATA;
 	} else if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
@@ -2719,6 +2814,55 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+static int read_skinny_bg_tree(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_root *bg_root = fs_info->bg_root;
+	struct btrfs_path path;
+	struct btrfs_key key;
+	int ret;
+
+	btrfs_init_path(&path);
+	key.objectid = 0;
+	key.offset = 0;
+	key.type = 0;
+
+	ret = btrfs_search_slot(NULL, bg_root, &key, &path, 0, 0);
+	if (ret < 0)
+		goto out;
+	if (ret == 0) {
+		error("invalid key found in skinny bg tree: (0, 0, 0)");
+		ret = -EUCLEAN;
+		goto out;
+	}
+
+	while (1) {
+		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+		if (key.type != BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY) {
+			error(
+		"invalid key found in skinny bg tree: (%llu, %u, %llu)",
+			      key.objectid, key.type, key.offset);
+			ret = -EUCLEAN;
+			goto out;
+		}
+		ret = read_one_block_group(fs_info, &path);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to read one block group: %m");
+			goto out;
+		}
+		ret = btrfs_next_item(bg_root, &path);
+		if (ret < 0)
+			goto out;
+		if (ret > 0) {
+			ret = 0;
+			goto out;
+		}
+	}
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
+
 int btrfs_read_block_groups(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_path path;
@@ -2726,6 +2870,9 @@ int btrfs_read_block_groups(struct btrfs_fs_info *fs_info)
 	int ret;
 	struct btrfs_key key;
 
+	if (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE))
+		return read_skinny_bg_tree(fs_info);
+
 	root = fs_info->extent_root;
 	key.objectid = 0;
 	key.offset = 0;
@@ -2806,16 +2953,25 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans,
 	int ret;
 	struct btrfs_root *extent_root = fs_info->extent_root;
 	struct btrfs_block_group_cache *cache;
-	struct btrfs_block_group_item bgi;
 
 	cache = btrfs_add_block_group(fs_info, bytes_used, type, chunk_offset,
 				      size);
-	btrfs_set_block_group_used(&bgi, cache->used);
-	btrfs_set_block_group_flags(&bgi, cache->flags);
-	btrfs_set_block_group_chunk_objectid(&bgi,
-			BTRFS_FIRST_CHUNK_TREE_OBJECTID);
-	ret = btrfs_insert_item(trans, extent_root, &cache->key, &bgi,
+	if (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE)) {
+		struct btrfs_key key;
+
+		key.objectid = cache->key.objectid;
+		key.type = BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY;
+		key.offset = bytes_used;
+		ret = btrfs_insert_item(trans, fs_info->bg_root, &key, NULL, 0);
+	} else {
+		struct btrfs_block_group_item bgi;
+		btrfs_set_block_group_used(&bgi, cache->used);
+		btrfs_set_block_group_flags(&bgi, cache->flags);
+		btrfs_set_block_group_chunk_objectid(&bgi,
+				BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+		ret = btrfs_insert_item(trans, extent_root, &cache->key, &bgi,
 				sizeof(bgi));
+	}
 	BUG_ON(ret);
 
 	return 0;
@@ -2925,6 +3081,41 @@ int btrfs_update_block_group(struct btrfs_root *root,
 				  alloc, mark_free);
 }
 
+static int free_skinny_block_group_item(struct btrfs_trans_handle *trans,
+					struct btrfs_fs_info *fs_info,
+					u64 bytenr)
+{
+	struct btrfs_path path;
+	struct btrfs_key key;
+	struct btrfs_root *bg_root = fs_info->bg_root;
+	int ret;
+
+	btrfs_init_path(&path);
+	key.objectid = bytenr;
+	key.type = BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY;
+	key.offset = (u64)-1;
+
+	ret = btrfs_search_slot(trans, bg_root, &key, &path, -1, 1);
+	if (ret < 0)
+		return ret;
+	if (ret == 0) {
+		error("invalid skinny block group item found");
+		ret = -EUCLEAN;
+		goto out;
+	}
+	ret = btrfs_previous_item(bg_root, &path, key.objectid, key.type);
+	if (ret < 0)
+		goto out;
+	if (ret > 0) {
+		ret = -ENOENT;
+		goto out;
+	}
+	ret = btrfs_del_item(trans, bg_root, &path);
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
+
 /*
  * Just remove a block group item in extent tree
  * Caller should ensure the block group is empty and all space is pinned.
@@ -2939,6 +3130,12 @@ static int free_block_group_item(struct btrfs_trans_handle *trans,
 	struct btrfs_root *root = fs_info->extent_root;
 	int ret = 0;
 
+	if (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE)) {
+		ret = free_skinny_block_group_item(trans, fs_info, bytenr);
+		if (!fs_info->convert_to_bg_tree)
+			return ret;
+	}
+
 	key.objectid = bytenr;
 	key.offset = len;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
@@ -2949,7 +3146,10 @@ static int free_block_group_item(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
 	if (ret > 0) {
-		ret = -ENOENT;
+		if (fs_info->convert_to_bg_tree)
+			ret = 0;
+		else
+			ret = -ENOENT;
 		goto out;
 	}
 	if (ret < 0)
-- 
2.23.0

