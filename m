Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBF21C4ACB
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 01:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgEDX6o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 19:58:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:37928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728278AbgEDX6n (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 19:58:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 68EABABAD
        for <linux-btrfs@vger.kernel.org>; Mon,  4 May 2020 23:58:42 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 6/7] btrfs: Introduce new incompat feature, SKINNY_BG_TREE, to hugely reduce mount time
Date:   Tue,  5 May 2020 07:58:24 +0800
Message-Id: <20200504235825.4199-7-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504235825.4199-1-wqu@suse.com>
References: <20200504235825.4199-1-wqu@suse.com>
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
  To get the block group length and block group flags, but that's all
  in-memory lookup, thus way faster than regular tree search.

- We can no longer rely on key->offset for various block group context
  Only key->objectid is still the same.
  The good news is, in previous refactors, we have already killed such
  call sites.

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

          |  Extent tree  |  Skinny bg tree  |
----------------------------------------------
  nodes   |            55 |                1 |
  leaves  |          1025 |                7 |
  total   |          1080 |                8 |

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
 fs/btrfs/block-group.c          | 168 +++++++++++++++++++++++++++++---
 fs/btrfs/block-rsv.c            |   2 +
 fs/btrfs/ctree.h                |   4 +-
 fs/btrfs/disk-io.c              |  18 +++-
 fs/btrfs/sysfs.c                |   2 +
 include/uapi/linux/btrfs.h      |   1 +
 include/uapi/linux/btrfs_tree.h |  11 +++
 7 files changed, 190 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 46846749b631..fad9118c2c1e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -874,6 +874,28 @@ static int remove_block_group_item(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	int ret;
 
+	if (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE)) {
+		root = fs_info->bg_root;
+		key.objectid = block_group->start;
+		key.type = BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY;
+		key.offset = (u64)-1;
+
+		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
+		if (ret == 0) {
+			btrfs_release_path(path);
+			return -EUCLEAN;
+		}
+		if (ret < 0)
+			return ret;
+		ret = btrfs_previous_item(root, path, key.objectid, key.type);
+		if (ret > 0)
+			ret = -ENOENT;
+		if (ret < 0)
+			return ret;
+		ret = btrfs_del_item(trans, root, path);
+		return ret;
+	}
+
 	root = fs_info->extent_root;
 	key.objectid = block_group->start;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
@@ -1883,9 +1905,38 @@ static int read_block_group_item(struct btrfs_block_group *cache,
 				 const struct btrfs_key *key)
 {
 	struct extent_buffer *leaf = path->nodes[0];
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	struct btrfs_block_group_item bgi;
 	int slot = path->slots[0];
 
+	if (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE)) {
+		struct extent_map *em;
+
+		ASSERT(key->type == BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY);
+		em = btrfs_get_chunk_map(fs_info, key->objectid, 1);
+		if (IS_ERR(em))
+			return PTR_ERR(em);
+		if (em->start != key->objectid) {
+			btrfs_err(fs_info, "no chunk found for bytenr %llu",
+				key->objectid);
+			free_extent_map(em);
+			return -EUCLEAN;
+		}
+		/* key->offset is used space */
+		if (key->offset > em->len) {
+			btrfs_err(fs_info,
+				"invalid bg used, have %llu expect [0, %llu]",
+				  key->offset, em->len);
+			free_extent_map(em);
+			return -EUCLEAN;
+		}
+		cache->length = em->len;
+		cache->flags = em->map_lookup->type;
+		cache->used = key->offset;
+		free_extent_map(em);
+		return 0;
+	}
+	ASSERT(key->type == BTRFS_BLOCK_GROUP_ITEM_KEY);
 	cache->length = key->offset;
 
 	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
@@ -1906,7 +1957,10 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	const bool mixed = btrfs_fs_incompat(info, MIXED_GROUPS);
 	int ret;
 
-	ASSERT(key->type == BTRFS_BLOCK_GROUP_ITEM_KEY);
+	ASSERT((!btrfs_fs_incompat(info, SKINNY_BG_TREE) &&
+		key->type == BTRFS_BLOCK_GROUP_ITEM_KEY) ||
+	       (btrfs_fs_incompat(info, SKINNY_BG_TREE) &&
+		key->type == BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY));
 
 	cache = btrfs_create_block_group_cache(info, key->objectid);
 	if (!cache)
@@ -1998,6 +2052,54 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	return ret;
 }
 
+static int read_skinny_block_groups(struct btrfs_fs_info *fs_info,
+				    struct btrfs_path *path,
+				    int need_clear)
+{
+	struct btrfs_root *root = fs_info->bg_root;
+	struct btrfs_key key;
+	int ret;
+
+	key.objectid = 0;
+	key.type = 0;
+	key.offset = 0;
+
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	if (ret < 0)
+		return ret;
+	if (ret == 0) {
+		btrfs_err(fs_info,
+			  "found invalid key (0, 0, 0) in block group tree");
+		ret = -EUCLEAN;
+		goto out;
+	}
+
+	while (1) {
+		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+		if (key.type != BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY) {
+			btrfs_err(fs_info,
+		"found invalid key (%llu, %u, %llu) in block group tree",
+				  key.objectid, key.type, key.offset);
+			ret = -EUCLEAN;
+			goto out;
+		}
+
+		ret = read_one_block_group(fs_info, path, &key, need_clear);
+		if (ret < 0)
+			goto out;
+		ret = btrfs_next_item(root, path);
+		if (ret < 0)
+			goto out;
+		if (ret > 0) {
+			ret = 0;
+			goto out;
+		}
+	}
+out:
+	btrfs_release_path(path);
+	return ret;
+}
+
 int btrfs_read_block_groups(struct btrfs_fs_info *info)
 {
 	struct btrfs_path *path;
@@ -2022,20 +2124,27 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	if (btrfs_test_opt(info, CLEAR_CACHE))
 		need_clear = 1;
 
-	while (1) {
-		ret = find_first_block_group(info, path, &key);
-		if (ret > 0)
-			break;
-		if (ret != 0)
-			goto error;
+	if (btrfs_fs_incompat(info, SKINNY_BG_TREE)) {
+		path->reada = READA_FORWARD;
+		ret = read_skinny_block_groups(info, path, need_clear);
+	} else {
+		while (1) {
+			ret = find_first_block_group(info, path, &key);
+			if (ret > 0)
+				break;
+			if (ret != 0)
+				goto error;
 
-		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-		ret = read_one_block_group(info, path, &key, need_clear);
-		if (ret < 0)
-			goto error;
-		key.objectid += key.offset;
-		key.offset = 0;
-		btrfs_release_path(path);
+			btrfs_item_key_to_cpu(path->nodes[0], &key,
+						path->slots[0]);
+			ret = read_one_block_group(info, path, &key,
+						need_clear);
+			if (ret < 0)
+				goto error;
+			key.objectid += key.offset;
+			key.offset = 0;
+			btrfs_release_path(path);
+		}
 	}
 
 	rcu_read_lock();
@@ -2076,6 +2185,16 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 	struct btrfs_root *root;
 	struct btrfs_key key;
 
+	if (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE)) {
+		spin_lock(&block_group->lock);
+		key.objectid = block_group->start;
+		key.type = BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY;
+		key.offset = block_group->used;
+		spin_unlock(&block_group->lock);
+
+		root = fs_info->bg_root;
+		return btrfs_insert_item(trans, root, &key, 0, 0);
+	}
 	spin_lock(&block_group->lock);
 	btrfs_set_stack_block_group_used(&bgi, block_group->used);
 	btrfs_set_stack_block_group_chunk_objectid(&bgi,
@@ -2358,6 +2477,27 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 	unsigned long bi;
 	int ret;
 
+	if (btrfs_fs_incompat(fs_info, SKINNY_BG_TREE)) {
+		key.objectid = cache->start;
+		key.type = BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY;
+		key.offset = (u64)-1;
+		root = fs_info->bg_root;
+
+		ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
+		if (ret == 0)
+			ret = -EUCLEAN;
+		if (ret < 0)
+			goto fail;
+		ret = btrfs_previous_item(root, path, key.objectid, key.type);
+		if (ret > 0)
+			ret = -ENOENT;
+		if (ret < 0)
+			goto fail;
+		key.offset = cache->used;
+		btrfs_set_item_key_safe(fs_info, path, &key);
+		btrfs_release_path(path);
+		return 0;
+	}
 	key.objectid = cache->start;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	key.offset = cache->length;
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index dbba53e712e6..f0d36f1c8c6e 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -432,6 +432,8 @@ void btrfs_init_global_block_rsv(struct btrfs_fs_info *fs_info)
 	fs_info->tree_root->block_rsv = &fs_info->global_block_rsv;
 	if (fs_info->quota_root)
 		fs_info->quota_root->block_rsv = &fs_info->global_block_rsv;
+	if (fs_info->bg_root)
+		fs_info->bg_root->block_rsv = &fs_info->global_block_rsv;
 	fs_info->chunk_root->block_rsv = &fs_info->chunk_block_rsv;
 
 	btrfs_update_global_block_rsv(fs_info);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 03ea7370aea7..e40131d662b8 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -302,7 +302,8 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
-	 BTRFS_FEATURE_INCOMPAT_RAID1C34)
+	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
+	 BTRFS_FEATURE_INCOMPAT_SKINNY_BG_TREE)
 
 #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
 	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
@@ -582,6 +583,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *quota_root;
 	struct btrfs_root *uuid_root;
 	struct btrfs_root *free_space_root;
+	struct btrfs_root *bg_root;
 
 	/* the log root tree is a directory of all the other log roots */
 	struct btrfs_root *log_root_tree;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8ad451695d49..56675d3cd23a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1516,6 +1516,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	kfree(fs_info->balance_ctl);
 	kfree(fs_info->delayed_root);
 	btrfs_put_root(fs_info->extent_root);
+	btrfs_put_root(fs_info->bg_root);
 	btrfs_put_root(fs_info->tree_root);
 	btrfs_put_root(fs_info->chunk_root);
 	btrfs_put_root(fs_info->dev_root);
@@ -1531,7 +1532,6 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	kvfree(fs_info);
 }
 
-
 struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 				     struct btrfs_key *location,
 				     bool check_ref)
@@ -1560,6 +1560,10 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 	if (location->objectid == BTRFS_FREE_SPACE_TREE_OBJECTID)
 		return btrfs_grab_root(fs_info->free_space_root) ?
 			fs_info->free_space_root : ERR_PTR(-ENOENT);
+	if (location->objectid == BTRFS_BLOCK_GROUP_TREE_OBJECTID)
+		return btrfs_grab_root(fs_info->bg_root) ?
+			fs_info->bg_root : ERR_PTR(-ENOENT);
+
 again:
 	root = btrfs_lookup_fs_root(fs_info, location->objectid);
 	if (root) {
@@ -1983,6 +1987,7 @@ static void free_root_pointers(struct btrfs_fs_info *info, bool free_chunk_root)
 	if (free_chunk_root)
 		free_root_extent_buffers(info->chunk_root);
 	free_root_extent_buffers(info->free_space_root);
+	free_root_extent_buffers(info->bg_root);
 }
 
 void btrfs_put_root(struct btrfs_root *root)
@@ -2267,6 +2272,17 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
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
index a39bff64ff24..d71bd4949636 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -261,6 +261,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
 BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
+BTRFS_FEAT_ATTR_INCOMPAT(skinny_bg_tree, SKINNY_BG_TREE);
 
 static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(mixed_backref),
@@ -276,6 +277,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
 	BTRFS_FEAT_ATTR_PTR(free_space_tree),
 	BTRFS_FEAT_ATTR_PTR(raid1c34),
+	BTRFS_FEAT_ATTR_PTR(skinny_bg_tree),
 	NULL
 };
 
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index e6b6cb0f8bc6..dc8675d892a4 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -290,6 +290,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID	(1ULL << 10)
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
+#define BTRFS_FEATURE_INCOMPAT_SKINNY_BG_TREE	(1ULL << 12)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 8e322e2c7e78..c1b63a63db9f 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -48,6 +48,9 @@
 /* tracks free space in block groups. */
 #define BTRFS_FREE_SPACE_TREE_OBJECTID 10ULL
 
+/* sotre SKINNY_BLOCK_GROUPs in a seprate tree */
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
2.26.2

