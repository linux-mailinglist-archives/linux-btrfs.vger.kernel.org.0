Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4401B37E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 08:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgDVGvN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 02:51:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:51516 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbgDVGvM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 02:51:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9B9BFABCF;
        Wed, 22 Apr 2020 06:51:07 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        u-boot@lists.denx.de
Cc:     marek.behun@nic.cz
Subject: [PATCH U-BOOT 15/26] fs: btrfs: Crossport open_ctree_fs_info()
Date:   Wed, 22 Apr 2020 14:49:58 +0800
Message-Id: <20200422065009.69392-16-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200422065009.69392-1-wqu@suse.com>
References: <20200422065009.69392-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

open_ctree_fs_info() is the main entry point to open a btrfs.

This version is a simplfied version of __open_ctree_fd() of btrfs-progs,
the main differences are:
- Parameters on how to specify a block device
  Instead of @fd and @path, uboot uses blk_desc and disk_partition_t.

- Remove open_ctree flags
  There will not be multiple open ctree modes in uboot.

Otherwise the function structure are all kept the same.

With open_ctree_fs_info() implemented, also introduce the global
current_fs_info pointer to show the current opened btrfs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/Makefile    |   2 +-
 fs/btrfs/btrfs.c     |  15 +-
 fs/btrfs/btrfs.h     |   1 +
 fs/btrfs/compat.h    |   2 +
 fs/btrfs/ctree.h     |   4 +
 fs/btrfs/disk-io.c   | 509 +++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/disk-io.h   |  19 ++
 fs/btrfs/root-tree.c |  47 ++++
 8 files changed, 579 insertions(+), 20 deletions(-)
 create mode 100644 fs/btrfs/root-tree.c

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 573bb7514fce..3cf8a716f8c0 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -4,4 +4,4 @@
 
 obj-y := btrfs.o chunk-map.o compression.o ctree.o dev.o dir-item.o \
 	extent-io.o inode.o root.o subvolume.o crypto/hash.o disk-io.o \
-	common/rbtree-utils.o extent-cache.o extent-io.o volumes.o
+	common/rbtree-utils.o extent-cache.o extent-io.o volumes.o root-tree.o
diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index 4f2fa2fe6c9f..b86e5cc50b9e 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -13,6 +13,7 @@
 #include "disk-io.h"
 
 struct btrfs_info btrfs_info;
+struct btrfs_fs_info *current_fs_info;
 
 static int readdir_callback(const struct __btrfs_root *root,
 			    struct btrfs_dir_item *item)
@@ -79,6 +80,9 @@ static int readdir_callback(const struct __btrfs_root *root,
 
 int btrfs_probe(struct blk_desc *fs_dev_desc, disk_partition_t *fs_partition)
 {
+	struct btrfs_fs_info *fs_info;
+	int ret = -1;
+
 	btrfs_blk_desc = fs_dev_desc;
 	btrfs_part_info = fs_partition;
 
@@ -109,7 +113,12 @@ int btrfs_probe(struct blk_desc *fs_dev_desc, disk_partition_t *fs_partition)
 		return -1;
 	}
 
-	return 0;
+	fs_info = open_ctree_fs_info(fs_dev_desc, fs_partition);
+	if (fs_info) {
+		current_fs_info = fs_info;
+		ret = 0;
+	}
+	return ret;
 }
 
 int btrfs_ls(const char *path)
@@ -213,6 +222,10 @@ int btrfs_read(const char *file, void *buf, loff_t offset, loff_t len,
 void btrfs_close(void)
 {
 	btrfs_chunk_map_exit();
+	if (current_fs_info) {
+		close_ctree_fs_info(current_fs_info);
+		current_fs_info = NULL;
+	}
 }
 
 int btrfs_uuid(char *uuid_str)
diff --git a/fs/btrfs/btrfs.h b/fs/btrfs/btrfs.h
index 037492fa06a8..3d20d2bf06bb 100644
--- a/fs/btrfs/btrfs.h
+++ b/fs/btrfs/btrfs.h
@@ -22,6 +22,7 @@ struct btrfs_info {
 };
 
 extern struct btrfs_info btrfs_info;
+extern struct btrfs_fs_info *current_fs_info;
 
 /* dev.c */
 extern struct blk_desc *btrfs_blk_desc;
diff --git a/fs/btrfs/compat.h b/fs/btrfs/compat.h
index 8840e509f32c..64c343f4169c 100644
--- a/fs/btrfs/compat.h
+++ b/fs/btrfs/compat.h
@@ -12,6 +12,8 @@
 /* A simple wraper to for error() from btrfs-progs */
 #define error(...) { printf(__VA_ARGS__); printf("\n"); }
 
+#define ASSERT(c) assert(c)
+
 #define BTRFS_UUID_UNPARSED_SIZE	37
 
 /*
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1fe7a4544022..8699cef689ef 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1274,6 +1274,10 @@ const char *btrfs_super_csum_name(u16 csum_type);
 u16 btrfs_csum_type_size(u16 csum_type);
 size_t btrfs_super_num_csums(void);
 
+/* root-tree.c */
+int btrfs_find_last_root(struct btrfs_root *root, u64 objectid,
+			struct btrfs_root_item *item, struct btrfs_key *key);
+
 /* ctree.c */
 int btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
 enum btrfs_tree_block_status
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9c5021ce2861..8dc816f7a8c9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4,6 +4,7 @@
 #include <uuid.h>
 #include <memalign.h>
 #include "kernel-shared/btrfs_tree.h"
+#include "common/rbtree-utils.h"
 #include "disk-io.h"
 #include "ctree.h"
 #include "btrfs.h"
@@ -424,24 +425,6 @@ out:
 
 }
 
-int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid)
-{
-	int ret;
-
-	ret = extent_buffer_uptodate(buf);
-	if (!ret)
-		return ret;
-
-	ret = verify_parent_transid(&buf->fs_info->extent_cache, buf,
-				    parent_transid, 1);
-	return !ret;
-}
-
-int btrfs_set_buffer_uptodate(struct extent_buffer *eb)
-{
-	return set_extent_buffer_uptodate(eb);
-}
-
 int read_whole_eb(struct btrfs_fs_info *info, struct extent_buffer *eb, int mirror)
 {
 	unsigned long offset = 0;
@@ -581,3 +564,493 @@ struct extent_buffer* read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 	free_extent_buffer(eb);
 	return ERR_PTR(ret);
 }
+
+void btrfs_setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
+		      u64 objectid)
+{
+	root->node = NULL;
+	root->track_dirty = 0;
+
+	root->fs_info = fs_info;
+	root->objectid = objectid;
+	root->last_trans = 0;
+	root->last_inode_alloc = 0;
+
+	memset(&root->root_key, 0, sizeof(root->root_key));
+	memset(&root->root_item, 0, sizeof(root->root_item));
+	root->root_key.objectid = objectid;
+}
+
+static int find_and_setup_root(struct btrfs_root *tree_root,
+			       struct btrfs_fs_info *fs_info,
+			       u64 objectid, struct btrfs_root *root)
+{
+	int ret;
+	u64 generation;
+
+	btrfs_setup_root(root, fs_info, objectid);
+	ret = btrfs_find_last_root(tree_root, objectid,
+				   &root->root_item, &root->root_key);
+	if (ret)
+		return ret;
+
+	generation = btrfs_root_generation(&root->root_item);
+	root->node = read_tree_block(fs_info,
+			btrfs_root_bytenr(&root->root_item), generation);
+	if (!extent_buffer_uptodate(root->node))
+		return -EIO;
+
+	return 0;
+}
+
+int btrfs_free_fs_root(struct btrfs_root *root)
+{
+	if (root->node)
+		free_extent_buffer(root->node);
+	kfree(root);
+	return 0;
+}
+
+static void __free_fs_root(struct rb_node *node)
+{
+	struct btrfs_root *root;
+
+	root = container_of(node, struct btrfs_root, rb_node);
+	btrfs_free_fs_root(root);
+}
+
+FREE_RB_BASED_TREE(fs_roots, __free_fs_root);
+
+struct btrfs_root *btrfs_read_fs_root_no_cache(struct btrfs_fs_info *fs_info,
+					       struct btrfs_key *location)
+{
+	struct btrfs_root *root;
+	struct btrfs_root *tree_root = fs_info->tree_root;
+	struct btrfs_path *path;
+	struct extent_buffer *l;
+	u64 generation;
+	int ret = 0;
+
+	root = calloc(1, sizeof(*root));
+	if (!root)
+		return ERR_PTR(-ENOMEM);
+	if (location->offset == (u64)-1) {
+		ret = find_and_setup_root(tree_root, fs_info,
+					  location->objectid, root);
+		if (ret) {
+			free(root);
+			return ERR_PTR(ret);
+		}
+		goto insert;
+	}
+
+	btrfs_setup_root(root, fs_info,
+			 location->objectid);
+
+	path = btrfs_alloc_path();
+	if (!path) {
+		free(root);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ret = btrfs_search_slot(NULL, tree_root, location, path, 0, 0);
+	if (ret != 0) {
+		if (ret > 0)
+			ret = -ENOENT;
+		goto out;
+	}
+	l = path->nodes[0];
+	read_extent_buffer(l, &root->root_item,
+	       btrfs_item_ptr_offset(l, path->slots[0]),
+	       sizeof(root->root_item));
+	memcpy(&root->root_key, location, sizeof(*location));
+
+	/* If this root is already an orphan, no need to read */
+	if (btrfs_root_refs(&root->root_item) == 0) {
+		ret = -ENOENT;
+		goto out;
+	}
+	ret = 0;
+out:
+	btrfs_free_path(path);
+	if (ret) {
+		free(root);
+		return ERR_PTR(ret);
+	}
+	generation = btrfs_root_generation(&root->root_item);
+	root->node = read_tree_block(fs_info,
+			btrfs_root_bytenr(&root->root_item), generation);
+	if (!extent_buffer_uptodate(root->node)) {
+		free(root);
+		return ERR_PTR(-EIO);
+	}
+insert:
+	root->ref_cows = 1;
+	return root;
+}
+
+static int btrfs_fs_roots_compare_objectids(struct rb_node *node,
+					    void *data)
+{
+	u64 objectid = *((u64 *)data);
+	struct btrfs_root *root;
+
+	root = rb_entry(node, struct btrfs_root, rb_node);
+	if (objectid > root->objectid)
+		return 1;
+	else if (objectid < root->objectid)
+		return -1;
+	else
+		return 0;
+}
+
+int btrfs_fs_roots_compare_roots(struct rb_node *node1, struct rb_node *node2)
+{
+	struct btrfs_root *root;
+
+	root = rb_entry(node2, struct btrfs_root, rb_node);
+	return btrfs_fs_roots_compare_objectids(node1, (void *)&root->objectid);
+}
+
+struct btrfs_root *btrfs_read_fs_root(struct btrfs_fs_info *fs_info,
+				      struct btrfs_key *location)
+{
+	struct btrfs_root *root;
+	struct rb_node *node;
+	int ret;
+	u64 objectid = location->objectid;
+
+	if (location->objectid == BTRFS_ROOT_TREE_OBJECTID)
+		return fs_info->tree_root;
+	if (location->objectid == BTRFS_CHUNK_TREE_OBJECTID)
+		return fs_info->chunk_root;
+	if (location->objectid == BTRFS_CSUM_TREE_OBJECTID)
+		return fs_info->csum_root;
+	BUG_ON(location->objectid == BTRFS_TREE_RELOC_OBJECTID ||
+	       location->offset != (u64)-1);
+
+	node = rb_search(&fs_info->fs_root_tree, (void *)&objectid,
+			 btrfs_fs_roots_compare_objectids, NULL);
+	if (node)
+		return container_of(node, struct btrfs_root, rb_node);
+
+	root = btrfs_read_fs_root_no_cache(fs_info, location);
+	if (IS_ERR(root))
+		return root;
+
+	ret = rb_insert(&fs_info->fs_root_tree, &root->rb_node,
+			btrfs_fs_roots_compare_roots);
+	BUG_ON(ret);
+	return root;
+}
+
+void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
+{
+	free(fs_info->tree_root);
+	free(fs_info->chunk_root);
+	free(fs_info->csum_root);
+	free(fs_info->super_copy);
+	free(fs_info);
+}
+
+struct btrfs_fs_info *btrfs_new_fs_info(void)
+{
+	struct btrfs_fs_info *fs_info;
+
+	fs_info = calloc(1, sizeof(struct btrfs_fs_info));
+	if (!fs_info)
+		return NULL;
+
+	fs_info->tree_root = calloc(1, sizeof(struct btrfs_root));
+	fs_info->chunk_root = calloc(1, sizeof(struct btrfs_root));
+	fs_info->csum_root = calloc(1, sizeof(struct btrfs_root));
+	fs_info->super_copy = calloc(1, BTRFS_SUPER_INFO_SIZE);
+
+	if (!fs_info->tree_root || !fs_info->chunk_root ||
+	    !fs_info->csum_root || !fs_info->super_copy)
+		goto free_all;
+
+	extent_io_tree_init(&fs_info->extent_cache);
+
+	fs_info->fs_root_tree = RB_ROOT;
+	cache_tree_init(&fs_info->mapping_tree.cache_tree);
+
+	mutex_init(&fs_info->fs_mutex);
+
+	return fs_info;
+free_all:
+	btrfs_free_fs_info(fs_info);
+	return NULL;
+}
+
+static int setup_root_or_create_block(struct btrfs_fs_info *fs_info,
+				      struct btrfs_root *info_root,
+				      u64 objectid, char *str)
+{
+	struct btrfs_root *root = fs_info->tree_root;
+	int ret;
+
+	ret = find_and_setup_root(root, fs_info, objectid, info_root);
+	if (ret) {
+		error("could not setup %s tree", str);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_super_block *sb = fs_info->super_copy;
+	struct btrfs_root *root;
+	struct btrfs_key key;
+	u64 root_tree_bytenr;
+	u64 generation;
+	int ret;
+
+	root = fs_info->tree_root;
+	btrfs_setup_root(root, fs_info, BTRFS_ROOT_TREE_OBJECTID);
+	generation = btrfs_super_generation(sb);
+
+	root_tree_bytenr = btrfs_super_root(sb);
+
+	root->node = read_tree_block(fs_info, root_tree_bytenr, generation);
+	if (!extent_buffer_uptodate(root->node)) {
+		fprintf(stderr, "Couldn't read tree root\n");
+		return -EIO;
+	}
+
+	ret = setup_root_or_create_block(fs_info, fs_info->csum_root,
+					 BTRFS_CSUM_TREE_OBJECTID, "csum");
+	if (ret)
+		return ret;
+	fs_info->csum_root->track_dirty = 1;
+
+	fs_info->last_trans_committed = generation;
+
+	key.objectid = BTRFS_FS_TREE_OBJECTID;
+	key.type = BTRFS_ROOT_ITEM_KEY;
+	key.offset = (u64)-1;
+	fs_info->fs_root = btrfs_read_fs_root(fs_info, &key);
+
+	if (IS_ERR(fs_info->fs_root))
+		return -EIO;
+	return 0;
+}
+
+void btrfs_release_all_roots(struct btrfs_fs_info *fs_info)
+{
+	if (fs_info->csum_root)
+		free_extent_buffer(fs_info->csum_root->node);
+	if (fs_info->tree_root)
+		free_extent_buffer(fs_info->tree_root->node);
+	if (fs_info->chunk_root)
+		free_extent_buffer(fs_info->chunk_root->node);
+}
+
+static void free_map_lookup(struct cache_extent *ce)
+{
+	struct map_lookup *map;
+
+	map = container_of(ce, struct map_lookup, ce);
+	kfree(map);
+}
+
+FREE_EXTENT_CACHE_BASED_TREE(mapping_cache, free_map_lookup);
+
+void btrfs_cleanup_all_caches(struct btrfs_fs_info *fs_info)
+{
+	free_mapping_cache_tree(&fs_info->mapping_tree.cache_tree);
+	extent_io_tree_cleanup(&fs_info->extent_cache);
+}
+
+static int btrfs_scan_fs_devices(struct blk_desc *desc, disk_partition_t *part,
+				 struct btrfs_fs_devices **fs_devices)
+{
+	u64 total_devs;
+	int ret;
+
+	if (round_up(BTRFS_SUPER_INFO_SIZE + BTRFS_SUPER_INFO_OFFSET,
+		     desc->blksz) > (part->size << desc->log2blksz)) {
+		error("superblock end %u is larger than device size %llu",
+				BTRFS_SUPER_INFO_SIZE + BTRFS_SUPER_INFO_OFFSET,
+				part->size << desc->log2blksz);
+		return -EINVAL;
+	}
+
+	ret = btrfs_scan_one_device(desc, part, fs_devices, &total_devs);
+	if (ret) {
+		fprintf(stderr, "No valid Btrfs found\n");
+		return ret;
+	}
+	return 0;
+}
+
+int btrfs_check_fs_compatibility(struct btrfs_super_block *sb)
+{
+	u64 features;
+
+	features = btrfs_super_incompat_flags(sb) &
+		   ~BTRFS_FEATURE_INCOMPAT_SUPP;
+	if (features) {
+		printk("couldn't open because of unsupported "
+		       "option features (%llx).\n",
+		       (unsigned long long)features);
+		return -ENOTSUPP;
+	}
+
+	features = btrfs_super_incompat_flags(sb);
+	if (!(features & BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF)) {
+		features |= BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF;
+		btrfs_set_super_incompat_flags(sb, features);
+	}
+
+	return 0;
+}
+
+static int btrfs_setup_chunk_tree_and_device_map(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_super_block *sb = fs_info->super_copy;
+	u64 chunk_root_bytenr;
+	u64 generation;
+	int ret;
+
+	btrfs_setup_root(fs_info->chunk_root, fs_info,
+			BTRFS_CHUNK_TREE_OBJECTID);
+
+	ret = btrfs_read_sys_array(fs_info);
+	if (ret)
+		return ret;
+
+	generation = btrfs_super_chunk_root_generation(sb);
+	chunk_root_bytenr = btrfs_super_chunk_root(sb);
+
+	fs_info->chunk_root->node = read_tree_block(fs_info,
+						    chunk_root_bytenr,
+						    generation);
+	if (!extent_buffer_uptodate(fs_info->chunk_root->node)) {
+		error("cannot read chunk root");
+		return -EIO;
+	}
+
+	ret = btrfs_read_chunk_tree(fs_info);
+	if (ret) {
+		fprintf(stderr, "Couldn't read chunk tree\n");
+		return ret;
+	}
+	return 0;
+}
+
+struct btrfs_fs_info *open_ctree_fs_info(struct blk_desc *desc,
+					 disk_partition_t *part)
+{
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_super_block *disk_super;
+	struct btrfs_fs_devices *fs_devices = NULL;
+	struct extent_buffer *eb;
+	int ret;
+
+	fs_info = btrfs_new_fs_info();
+	if (!fs_info) {
+		fprintf(stderr, "Failed to allocate memory for fs_info\n");
+		return NULL;
+	}
+
+	ret = btrfs_scan_fs_devices(desc, part, &fs_devices);
+	if (ret)
+		goto out;
+
+	fs_info->fs_devices = fs_devices;
+
+	ret = btrfs_open_devices(fs_devices);
+	if (ret)
+		goto out;
+
+	disk_super = fs_info->super_copy;
+	ret = btrfs_read_dev_super(desc, part, disk_super);
+	if (ret) {
+		printk("No valid btrfs found\n");
+		goto out_devices;
+	}
+
+	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_CHANGING_FSID) {
+		fprintf(stderr, "ERROR: Filesystem UUID change in progress\n");
+		goto out_devices;
+	}
+
+	ASSERT(!memcmp(disk_super->fsid, fs_devices->fsid, BTRFS_FSID_SIZE));
+	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
+		ASSERT(!memcmp(disk_super->metadata_uuid,
+			       fs_devices->metadata_uuid, BTRFS_FSID_SIZE));
+
+	fs_info->sectorsize = btrfs_super_sectorsize(disk_super);
+	fs_info->nodesize = btrfs_super_nodesize(disk_super);
+	fs_info->stripesize = btrfs_super_stripesize(disk_super);
+
+	ret = btrfs_check_fs_compatibility(fs_info->super_copy);
+	if (ret)
+		goto out_devices;
+
+	ret = btrfs_setup_chunk_tree_and_device_map(fs_info);
+	if (ret)
+		goto out_chunk;
+
+	/* Chunk tree root is unable to read, return directly */
+	if (!fs_info->chunk_root)
+		return fs_info;
+
+	eb = fs_info->chunk_root->node;
+	read_extent_buffer(eb, fs_info->chunk_tree_uuid,
+			   btrfs_header_chunk_tree_uuid(eb),
+			   BTRFS_UUID_SIZE);
+
+	ret = btrfs_setup_all_roots(fs_info);
+	if (ret)
+		goto out_chunk;
+
+	return fs_info;
+
+out_chunk:
+	btrfs_release_all_roots(fs_info);
+	btrfs_cleanup_all_caches(fs_info);
+out_devices:
+	btrfs_close_devices(fs_devices);
+out:
+	btrfs_free_fs_info(fs_info);
+	return NULL;
+}
+
+int close_ctree_fs_info(struct btrfs_fs_info *fs_info)
+{
+	int ret;
+	int err = 0;
+
+	free_fs_roots_tree(&fs_info->fs_root_tree);
+
+	btrfs_release_all_roots(fs_info);
+	ret = btrfs_close_devices(fs_info->fs_devices);
+	btrfs_cleanup_all_caches(fs_info);
+	btrfs_free_fs_info(fs_info);
+	if (!err)
+		err = ret;
+	return err;
+}
+
+int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid)
+{
+	int ret;
+
+	ret = extent_buffer_uptodate(buf);
+	if (!ret)
+		return ret;
+
+	ret = verify_parent_transid(&buf->fs_info->extent_cache, buf,
+				    parent_transid, 1);
+	return !ret;
+}
+
+int btrfs_set_buffer_uptodate(struct extent_buffer *eb)
+{
+	return set_extent_buffer_uptodate(eb);
+}
+
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 9d593374c096..d8f6f827550a 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -22,6 +22,25 @@ struct extent_buffer* btrfs_find_create_tree_block(
 		struct btrfs_fs_info *fs_info, u64 bytenr);
 struct extent_buffer *btrfs_find_tree_block(struct btrfs_fs_info *fs_info,
 					    u64 bytenr, u32 blocksize);
+struct btrfs_root *btrfs_read_fs_root_no_cache(struct btrfs_fs_info *fs_info,
+					       struct btrfs_key *location);
+struct btrfs_root *btrfs_read_fs_root(struct btrfs_fs_info *fs_info,
+				      struct btrfs_key *location);
+
+void btrfs_setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
+		      u64 objectid);
+
+void btrfs_free_fs_info(struct btrfs_fs_info *fs_info);
+struct btrfs_fs_info *btrfs_new_fs_info(void);
+int btrfs_check_fs_compatibility(struct btrfs_super_block *sb);
+int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info);
+void btrfs_release_all_roots(struct btrfs_fs_info *fs_info);
+void btrfs_cleanup_all_caches(struct btrfs_fs_info *fs_info);
+
+struct btrfs_fs_info *open_ctree_fs_info(struct blk_desc *desc,
+					 disk_partition_t *part);
+int close_ctree_fs_info(struct btrfs_fs_info *fs_info);
+
 int btrfs_read_dev_super(struct blk_desc *desc, disk_partition_t *part,
 			 struct btrfs_super_block *sb);
 int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid);
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
new file mode 100644
index 000000000000..a39ad72067d7
--- /dev/null
+++ b/fs/btrfs/root-tree.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "ctree.h"
+
+int btrfs_find_last_root(struct btrfs_root *root, u64 objectid,
+			struct btrfs_root_item *item, struct btrfs_key *key)
+{
+	struct btrfs_path *path;
+	struct btrfs_key search_key;
+	struct btrfs_key found_key;
+	struct extent_buffer *l;
+	int ret;
+	int slot;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	search_key.objectid = objectid;
+	search_key.type = BTRFS_ROOT_ITEM_KEY;
+	search_key.offset = (u64)-1;
+
+	ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
+	if (ret < 0)
+		goto out;
+	if (path->slots[0] == 0) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	BUG_ON(ret == 0);
+	l = path->nodes[0];
+	slot = path->slots[0] - 1;
+	btrfs_item_key_to_cpu(l, &found_key, slot);
+	if (found_key.type != BTRFS_ROOT_ITEM_KEY ||
+	    found_key.objectid != objectid) {
+		ret = -ENOENT;
+		goto out;
+	}
+	read_extent_buffer(l, item, btrfs_item_ptr_offset(l, slot),
+			   sizeof(*item));
+	memcpy(key, &found_key, sizeof(found_key));
+	ret = 0;
+out:
+	btrfs_free_path(path);
+	return ret;
+}
-- 
2.26.0

