Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501BC1C4AD5
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 02:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgEEACs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 20:02:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:38782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728455AbgEEACr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 20:02:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0082EAF01
        for <linux-btrfs@vger.kernel.org>; Tue,  5 May 2020 00:02:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 06/11] btrfs-progs: Introduce rw support for skinny_bg_tree
Date:   Tue,  5 May 2020 08:02:25 +0800
Message-Id: <20200505000230.4454-7-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505000230.4454-1-wqu@suse.com>
References: <20200505000230.4454-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The ability to read/write a fs with skinny_bg_tree feature.
The code is mostly synced from kernel support.

Please note that, currently the support is just open/read/write, no
conversion support yet.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 ctree.h       |  15 ++++-
 disk-io.c     |  20 ++++++
 extent-tree.c | 167 +++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 192 insertions(+), 10 deletions(-)

diff --git a/ctree.h b/ctree.h
index 7c7c992cd885..9ce73008a7e0 100644
--- a/ctree.h
+++ b/ctree.h
@@ -91,6 +91,9 @@ struct btrfs_free_space_ctl;
 /* tracks free space in block groups. */
 #define BTRFS_FREE_SPACE_TREE_OBJECTID 10ULL
 
+/* store SKINNY_BLOCK_GROUP_ITEMs in a seperate tree */
+#define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
+
 /* device stats in the device tree */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
 
@@ -495,6 +498,7 @@ struct btrfs_super_block {
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID    (1ULL << 10)
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
+#define BTRFS_FEATURE_INCOMPAT_SKINNY_BG_TREE	(1ULL << 12)
 
 #define BTRFS_FEATURE_COMPAT_SUPP		0ULL
 
@@ -519,7 +523,8 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES |		\
 	 BTRFS_FEATURE_INCOMPAT_RAID1C34 |		\
-	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID)
+	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID |		\
+	 BTRFS_FEATURE_INCOMPAT_SKINNY_BG_TREE)
 
 /*
  * A leaf is full of items. offset and size tell us where to find
@@ -1147,6 +1152,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *quota_root;
 	struct btrfs_root *free_space_root;
 	struct btrfs_root *uuid_root;
+	struct btrfs_root *bg_root;
 
 	struct rb_root fs_root_tree;
 
@@ -1355,6 +1361,13 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
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
index c895bd277491..4cfb48326e3b 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -751,6 +751,8 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_fs_info *fs_info,
 	if (location->objectid == BTRFS_FREE_SPACE_TREE_OBJECTID)
 		return fs_info->free_space_root ? fs_info->free_space_root :
 						ERR_PTR(-ENOENT);
+	if (location->objectid == BTRFS_BLOCK_GROUP_TREE_OBJECTID)
+		return fs_info->bg_root ? fs_info->bg_root : ERR_PTR(-ENOENT);
 
 	BUG_ON(location->objectid == BTRFS_TREE_RELOC_OBJECTID ||
 	       location->offset != (u64)-1);
@@ -803,6 +805,7 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
 	fs_info->quota_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->free_space_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->uuid_root = calloc(1, sizeof(struct btrfs_root));
+	fs_info->bg_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->super_copy = calloc(1, BTRFS_SUPER_INFO_SIZE);
 
 	if (!fs_info->tree_root || !fs_info->extent_root ||
@@ -968,6 +971,21 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
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
@@ -1056,6 +1074,8 @@ void btrfs_release_all_roots(struct btrfs_fs_info *fs_info)
 		free_extent_buffer(fs_info->dev_root->node);
 	if (fs_info->extent_root)
 		free_extent_buffer(fs_info->extent_root->node);
+	if (fs_info->bg_root)
+		free_extent_buffer(fs_info->bg_root->node);
 	if (fs_info->tree_root)
 		free_extent_buffer(fs_info->tree_root->node);
 	if (fs_info->log_root_tree)
diff --git a/extent-tree.c b/extent-tree.c
index 89e38e2ed7ae..179fce4422cf 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -1527,6 +1527,36 @@ int btrfs_dec_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	return __btrfs_mod_ref(trans, root, buf, record_parent, 0);
 }
 
+static int locate_skinny_bg_item(struct btrfs_fs_info *fs_info,
+				 struct btrfs_trans_handle *trans,
+				 struct btrfs_block_group *bg,
+				 struct btrfs_path *path,
+				 int ins_len, int cow)
+{
+	struct btrfs_root *bg_root = fs_info->bg_root;
+	struct btrfs_key key;
+	int ret;
+
+	key.objectid = bg->start;
+	key.type = BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY;
+	key.offset = (u64)-1;
+
+	ret = btrfs_search_slot(trans, bg_root, &key, path, ins_len, cow);
+	if (ret == 0)
+		ret = -EUCLEAN;
+	if (ret < 0)
+		goto error;
+	ret = btrfs_previous_item(bg_root, path, key.objectid, key.type);
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0)
+		goto error;
+	return ret;
+error:
+	btrfs_release_path(path);
+	return ret;
+}
+
 static int update_block_group_item(struct btrfs_trans_handle *trans,
 				   struct btrfs_path *path,
 				   struct btrfs_block_group *cache)
@@ -1539,6 +1569,14 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 	unsigned long bi;
 	int ret;
 
+	if (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE)) {
+		ret = locate_skinny_bg_item(fs_info, trans, cache, path, 0, 1);
+		if (ret < 0)
+			goto fail;
+		key.offset = cache->used;
+		btrfs_set_item_key_safe(fs_info->bg_root, path, &key);
+		return 0;
+	}
 	key.objectid = cache->start;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	key.offset = cache->length;
@@ -2637,9 +2675,33 @@ static int read_block_group_item(struct btrfs_block_group *cache,
 				 const struct btrfs_key *key)
 {
 	struct extent_buffer *leaf = path->nodes[0];
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	struct btrfs_block_group_item bgi;
 	int slot = path->slots[0];
 
+	if (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE)) {
+		struct cache_extent *ce;
+		struct map_lookup *map;
+
+		ASSERT(key->type == BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY);
+		ce = search_cache_extent(&fs_info->mapping_tree.cache_tree,
+					 key->objectid);
+		if (!ce || ce->start != key->objectid)
+			return -ENOENT;
+		map = container_of(ce, struct map_lookup, ce);
+		cache->start = key->objectid;
+		cache->length = ce->size;
+		cache->used = key->offset;
+		cache->flags = map->type;
+		if (cache->used > cache->length) {
+			error(
+	"invalid used bytes for block group %llu, have %llu expect [0, %llu]",
+			      cache->start, cache->used, ce->size);
+			return -EUCLEAN;
+		}
+		return 0;
+	}
+
 	ASSERT(key->type == BTRFS_BLOCK_GROUP_ITEM_KEY);
 
 	cache->start = key->objectid;
@@ -2670,14 +2732,10 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 	int ret;
 
 	btrfs_item_key_to_cpu(leaf, &key, slot);
-	ASSERT(key.type == BTRFS_BLOCK_GROUP_ITEM_KEY);
-
-	/*
-	 * Skip 0 sized block group, don't insert them into block group cache
-	 * tree, as its length is 0, it won't get freed at close_ctree() time.
-	 */
-	if (key.offset == 0)
-		return 0;
+	ASSERT((!btrfs_fs_incompat(fs_info, SKINNY_BG_TREE) &&
+				key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) ||
+	       (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE) &&
+				key.type == BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY));
 
 	cache = kzalloc(sizeof(*cache), GFP_NOFS);
 	if (!cache)
@@ -2687,6 +2745,16 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 		free(cache);
 		return ret;
 	}
+
+	/*
+	 * Skip 0 sized block group, don't insert them into block group cache
+	 * tree, as its length is 0, it won't get freed at close_ctree() time.
+	 */
+	if (cache->length == 0) {
+		free(cache);
+		return 0;
+	}
+
 	INIT_LIST_HEAD(&cache->dirty_list);
 
 	set_avail_alloc_bits(fs_info, cache->flags);
@@ -2711,6 +2779,53 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+static int read_skinny_block_groups(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_root *root = fs_info->bg_root;
+	struct btrfs_path path;
+	struct btrfs_key key;
+	int ret;
+
+	key.objectid = 0;
+	key.type = 0;
+	key.offset = 0;
+	btrfs_init_path(&path);
+
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	if (ret < 0)
+		return ret;
+	if (ret == 0) {
+		error("found invalid key (0, 0, 0) in block group tree");
+		ret = -EUCLEAN;
+		goto out;
+	}
+	while (1) {
+		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+		if (key.type != BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY) {
+			error(
+		"found invalid key(%llu, %u, %llu) in block group tree",
+				key.objectid, key.type, key.offset);
+			ret = -EUCLEAN;
+			goto out;
+		}
+
+		ret = read_one_block_group(fs_info, &path);
+		if (ret < 0)
+			goto out;
+
+		ret = btrfs_next_item(root, &path);
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
@@ -2718,6 +2833,9 @@ int btrfs_read_block_groups(struct btrfs_fs_info *fs_info)
 	int ret;
 	struct btrfs_key key;
 
+	if (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE))
+		return read_skinny_block_groups(fs_info);
+
 	root = fs_info->extent_root;
 	key.objectid = 0;
 	key.offset = 0;
@@ -2813,6 +2931,14 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 	struct btrfs_root *root;
 	struct btrfs_key key;
 
+	if (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE)) {
+		key.objectid = block_group->start;
+		key.type = BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY;
+		key.offset = block_group->used;
+		root = fs_info->bg_root;
+
+		return btrfs_insert_item(trans, root, &key, NULL, 0);
+	}
 	btrfs_set_stack_block_group_used(&bgi, block_group->used);
 	btrfs_set_stack_block_group_chunk_objectid(&bgi,
 				BTRFS_FIRST_CHUNK_TREE_OBJECTID);
@@ -2921,13 +3047,36 @@ static int remove_block_group_item(struct btrfs_trans_handle *trans,
 				   struct btrfs_block_group *block_group)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_root *root;
 	struct btrfs_key key;
 	int ret = 0;
 
+	if (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE)) {
+		key.objectid = block_group->start;
+		key.type = BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY;
+		key.offset = (u64)-1;
+		root = fs_info->bg_root;
+
+		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
+		if (ret == 0) {
+			btrfs_release_path(path);
+			ret = -EUCLEAN;
+		}
+		if (ret < 0)
+			return ret;
+
+		ret = btrfs_previous_item(root, path, key.objectid, key.type);
+		if (ret > 0)
+			ret = -ENOENT;
+		if (ret < 0)
+			return ret;
+		ret = btrfs_del_item(trans, root, path);
+		return ret;
+	}
 	key.objectid = block_group->start;
 	key.offset = block_group->length;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+	root = fs_info->extent_root;
 
 	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
 	if (ret > 0)
-- 
2.26.2

