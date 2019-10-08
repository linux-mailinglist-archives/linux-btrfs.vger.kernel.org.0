Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9887CCF1F0
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2019 06:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbfJHEtU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Oct 2019 00:49:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:33560 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729489AbfJHEtU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Oct 2019 00:49:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2A2EAE35
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2019 04:49:16 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs: Introduce new incompat feature, BG_TREE, to speed up mount time
Date:   Tue,  8 Oct 2019 12:49:09 +0800
Message-Id: <20191008044909.157750-4-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191008044909.157750-1-wqu@suse.com>
References: <20191008044909.157750-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The overall idea of the new BG_TREE is pretty simple:
Put BLOCK_GROUP_ITEMS into a separate tree.

This brings one obvious enhancement:
- Reduce mount time of large fs

Although it could be possible to accept BLOCK_GROUP_ITEMS in either
trees (extent root or bg root), I'll leave that kernel convert as
alternatives to offline convert, as next step if there are a lot of
interests in that.

So for now, if an existing fs want to take advantage of BG_TREE feature,
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

 6)               |  open_ctree [btrfs]() {
 6)               |    btrfs_read_block_groups [btrfs]() {
 6) * 91204.69 us |    }
 6) @ 192039.5 us |  }

  open_ctree() time is only 21% of original mount time.
  And btrfs_read_block_groups() only takes 47% of total open_ctree()
  execution time.

The reason is pretty obvious when considering how many tree blocks needs
to be read from disk:
- Original extent tree:
  nodes:	55
  leaves:	1025
  total:	1080
- Block group tree:
  nodes:	1
  leaves:	13
  total:	14

Not to mention all the tree blocks readahead works pretty fine for bg
tree, as we will read every item.
While readahead for extent tree will just be a diaster, as all block
groups are scatter across the whole extent tree.

The reduction of mount time is already obvious even on super fast NVMe
disk with memory cache.
It would be even more obvious if the fs is on spinning rust.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c          | 104 ++++++++++++++++++++++++++------
 fs/btrfs/ctree.h                |   5 +-
 fs/btrfs/disk-io.c              |  13 ++++
 fs/btrfs/sysfs.c                |   2 +
 include/uapi/linux/btrfs.h      |   1 +
 include/uapi/linux/btrfs_tree.h |   3 +
 6 files changed, 110 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 0c5eef0610fa..0101fd42b586 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -861,7 +861,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 			     u64 group_start, struct extent_map *em)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_root *root;
 	struct btrfs_path *path;
 	struct btrfs_block_group_cache *block_group;
 	struct btrfs_free_cluster *cluster;
@@ -880,6 +880,11 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	BUG_ON(!block_group);
 	BUG_ON(!block_group->ro);
 
+	if (btrfs_fs_incompat(fs_info, BG_TREE))
+		root = fs_info->bg_root;
+	else
+		root = fs_info->extent_root;
+
 	trace_btrfs_remove_block_group(block_group);
 	/*
 	 * Free the reserved super bytes from this block group before
@@ -1790,6 +1795,56 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	return ret;
 }
 
+static int read_block_group_tree(struct btrfs_fs_info *info, int need_clear)
+{
+	struct btrfs_path *path;
+	struct btrfs_key key;
+	int ret;
+
+	key.objectid = 0;
+	key.offset = 0;
+	key.type = 0;
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
+		if (key.type != BTRFS_BLOCK_GROUP_ITEM_KEY) {
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
@@ -1815,20 +1870,26 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
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
+	if (btrfs_fs_incompat(info, BG_TREE)) {
+		ret = read_block_group_tree(info, need_clear);
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
@@ -1863,7 +1924,7 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_block_group_cache *block_group;
-	struct btrfs_root *extent_root = fs_info->extent_root;
+	struct btrfs_root *root;
 	struct btrfs_block_group_item item;
 	struct btrfs_key key;
 	int ret = 0;
@@ -1871,6 +1932,11 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 	if (!trans->can_flush_pending_bgs)
 		return;
 
+	if (btrfs_fs_incompat(fs_info, BG_TREE))
+		root = fs_info->bg_root;
+	else
+		root = fs_info->extent_root;
+
 	while (!list_empty(&trans->new_bgs)) {
 		block_group = list_first_entry(&trans->new_bgs,
 					       struct btrfs_block_group_cache,
@@ -1883,7 +1949,7 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 		memcpy(&key, &block_group->key, sizeof(key));
 		spin_unlock(&block_group->lock);
 
-		ret = btrfs_insert_item(trans, extent_root, &key, &item,
+		ret = btrfs_insert_item(trans, root, &key, &item,
 					sizeof(item));
 		if (ret)
 			btrfs_abort_transaction(trans, ret);
@@ -2119,11 +2185,15 @@ static int write_one_cache_group(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	int ret;
-	struct btrfs_root *extent_root = fs_info->extent_root;
+	struct btrfs_root *root;
 	unsigned long bi;
 	struct extent_buffer *leaf;
 
-	ret = btrfs_search_slot(trans, extent_root, &cache->key, path, 0, 1);
+	if (btrfs_fs_incompat(fs_info, BG_TREE))
+		root = fs_info->bg_root;
+	else
+		root = fs_info->extent_root;
+	ret = btrfs_search_slot(trans, root, &cache->key, path, 0, 1);
 	if (ret) {
 		if (ret > 0)
 			ret = -ENOENT;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 19d669d12ca1..c98d008fb42f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -291,7 +291,8 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |		\
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
-	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID)
+	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
+	 BTRFS_FEATURE_INCOMPAT_BG_TREE)
 
 #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
 	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
@@ -538,6 +539,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *quota_root;
 	struct btrfs_root *uuid_root;
 	struct btrfs_root *free_space_root;
+	struct btrfs_root *bg_root;
 
 	/* the log root tree is a directory of all the other log roots */
 	struct btrfs_root *log_root_tree;
@@ -2661,6 +2663,7 @@ static inline void free_fs_info(struct btrfs_fs_info *fs_info)
 	kfree(fs_info->quota_root);
 	kfree(fs_info->uuid_root);
 	kfree(fs_info->free_space_root);
+	kfree(fs_info->bg_root);
 	kfree(fs_info->super_copy);
 	kfree(fs_info->super_for_commit);
 	kvfree(fs_info);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index bfeeac83b952..b9693d82bb6f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1570,6 +1570,8 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 	if (location->objectid == BTRFS_FREE_SPACE_TREE_OBJECTID)
 		return fs_info->free_space_root ? fs_info->free_space_root :
 						  ERR_PTR(-ENOENT);
+	if (location->objectid == BTRFS_BLOCK_GROUP_TREE_OBJECTID)
+		return fs_info->bg_root ? fs_info->bg_root: ERR_PTR(-ENOENT);
 again:
 	root = btrfs_lookup_fs_root(fs_info, location->objectid);
 	if (root) {
@@ -2040,6 +2042,7 @@ static void free_root_pointers(struct btrfs_fs_info *info, int chunk_root)
 	free_root_extent_buffers(info->uuid_root);
 	free_root_extent_buffers(info->chunk_root);
 	free_root_extent_buffers(info->free_space_root);
+	free_root_extent_buffers(info->bg_root);
 }
 
 void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info)
@@ -2332,6 +2335,16 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
 	fs_info->extent_root = root;
 
+	if (btrfs_fs_incompat(fs_info, BG_TREE)) {
+		location.objectid = BTRFS_BLOCK_GROUP_TREE_OBJECTID;
+		root = btrfs_read_tree_root(tree_root, &location);
+		if (IS_ERR(root)) {
+			ret = PTR_ERR(root);
+			goto out;
+		}
+		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+		fs_info->bg_root = root;
+	}
 	location.objectid = BTRFS_DEV_TREE_OBJECTID;
 	root = btrfs_read_tree_root(tree_root, &location);
 	if (IS_ERR(root)) {
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index f6d3c80f2e28..799f7e18d6ee 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -257,6 +257,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(raid56, RAID56);
 BTRFS_FEAT_ATTR_INCOMPAT(skinny_metadata, SKINNY_METADATA);
 BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
 BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
+BTRFS_FEAT_ATTR_INCOMPAT(bg_tree, BG_TREE);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 
 static struct attribute *btrfs_supported_feature_attrs[] = {
@@ -272,6 +273,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(no_holes),
 	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
 	BTRFS_FEAT_ATTR_PTR(free_space_tree),
+	BTRFS_FEAT_ATTR_PTR(bg_tree),
 	NULL
 };
 
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 3ee0678c0a83..0f91ebc07064 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -270,6 +270,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA	(1ULL << 8)
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID	(1ULL << 10)
+#define BTRFS_FEATURE_INCOMPAT_BG_TREE		(1ULL << 11)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index b65c7ee75bc7..1d1e50c42d0e 100644
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
 
-- 
2.23.0

