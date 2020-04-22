Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB01B1B37E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 08:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgDVGvG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 02:51:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:51478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgDVGvG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 02:51:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3A5C3AB91;
        Wed, 22 Apr 2020 06:51:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        u-boot@lists.denx.de
Cc:     marek.behun@nic.cz
Subject: [PATCH U-BOOT 14/26] fs: btrfs: Crossport btrfs_read_sys_array() and btrfs_read_chunk_tree()
Date:   Wed, 22 Apr 2020 14:49:57 +0800
Message-Id: <20200422065009.69392-15-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200422065009.69392-1-wqu@suse.com>
References: <20200422065009.69392-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These two functions play a big role in btrfs bootstrap.

The following function is removed:
- Seed device support

Although in theory we can still support multiple devices, we don't have
a facility in U-boot to do device scan without opening them.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs.c     |   2 +-
 fs/btrfs/btrfs.h     |   2 +-
 fs/btrfs/chunk-map.c |   2 +-
 fs/btrfs/volumes.c   | 301 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h   |   2 +
 5 files changed, 306 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index 1cb56ea0124d..4f2fa2fe6c9f 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -98,7 +98,7 @@ int btrfs_probe(struct blk_desc *fs_dev_desc, disk_partition_t *fs_partition)
 	btrfs_info.chunk_root.objectid = 0;
 	btrfs_info.chunk_root.bytenr = btrfs_info.sb.chunk_root;
 
-	if (btrfs_read_chunk_tree()) {
+	if (__btrfs_read_chunk_tree()) {
 		printf("%s: failed to read chunk tree\n", __func__);
 		return -1;
 	}
diff --git a/fs/btrfs/btrfs.h b/fs/btrfs/btrfs.h
index 57cdb5aad58c..037492fa06a8 100644
--- a/fs/btrfs/btrfs.h
+++ b/fs/btrfs/btrfs.h
@@ -33,7 +33,7 @@ int btrfs_devread(u64, int, void *);
 u64 btrfs_map_logical_to_physical(u64);
 int btrfs_chunk_map_init(void);
 void btrfs_chunk_map_exit(void);
-int btrfs_read_chunk_tree(void);
+int __btrfs_read_chunk_tree(void);
 
 /* compression.c */
 u32 btrfs_decompress(u8 type, const char *, u32, char *, u32);
diff --git a/fs/btrfs/chunk-map.c b/fs/btrfs/chunk-map.c
index 85c3efc63e16..49d8835e14e9 100644
--- a/fs/btrfs/chunk-map.c
+++ b/fs/btrfs/chunk-map.c
@@ -141,7 +141,7 @@ int btrfs_chunk_map_init(void)
 	return 0;
 }
 
-int btrfs_read_chunk_tree(void)
+int __btrfs_read_chunk_tree(void)
 {
 	struct __btrfs_path path;
 	struct btrfs_key key, *found_key;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 63853cb2a1dd..56cf7ac8c631 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5,6 +5,7 @@
 #include "ctree.h"
 #include "disk-io.h"
 #include "volumes.h"
+#include "extent-io.h"
 
 const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 	[BTRFS_RAID_RAID10] = {
@@ -369,6 +370,14 @@ struct btrfs_device *btrfs_find_device(struct btrfs_fs_info *fs_info, u64 devid,
 	return NULL;
 }
 
+static struct btrfs_device *fill_missing_device(u64 devid)
+{
+	struct btrfs_device *device;
+
+	device = kzalloc(sizeof(*device), GFP_NOFS);
+	return device;
+}
+
 /*
  * slot == -1: SYSTEM chunk
  * return -EIO on error, otherwise return 0
@@ -498,6 +507,298 @@ int btrfs_check_chunk_valid(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+/*
+ * Slot is used to verify the chunk item is valid
+ *
+ * For sys chunk in superblock, pass -1 to indicate sys chunk.
+ */
+static int read_one_chunk(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
+			  struct extent_buffer *leaf,
+			  struct btrfs_chunk *chunk, int slot)
+{
+	struct btrfs_mapping_tree *map_tree = &fs_info->mapping_tree;
+	struct map_lookup *map;
+	struct cache_extent *ce;
+	u64 logical;
+	u64 length;
+	u64 devid;
+	u8 uuid[BTRFS_UUID_SIZE];
+	int num_stripes;
+	int ret;
+	int i;
+
+	logical = key->offset;
+	length = btrfs_chunk_length(leaf, chunk);
+	num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
+	/* Validation check */
+	ret = btrfs_check_chunk_valid(fs_info, leaf, chunk, slot, logical);
+	if (ret) {
+		error("%s checksums match, but it has an invalid chunk, %s",
+		      (slot == -1) ? "Superblock" : "Metadata",
+		      (slot == -1) ? "try btrfsck --repair -s <superblock> ie, 0,1,2" : "");
+		return ret;
+	}
+
+	ce = search_cache_extent(&map_tree->cache_tree, logical);
+
+	/* already mapped? */
+	if (ce && ce->start <= logical && ce->start + ce->size > logical) {
+		return 0;
+	}
+
+	map = kmalloc(btrfs_map_lookup_size(num_stripes), GFP_NOFS);
+	if (!map)
+		return -ENOMEM;
+
+	map->ce.start = logical;
+	map->ce.size = length;
+	map->num_stripes = num_stripes;
+	map->io_width = btrfs_chunk_io_width(leaf, chunk);
+	map->io_align = btrfs_chunk_io_align(leaf, chunk);
+	map->sector_size = btrfs_chunk_sector_size(leaf, chunk);
+	map->stripe_len = btrfs_chunk_stripe_len(leaf, chunk);
+	map->type = btrfs_chunk_type(leaf, chunk);
+	map->sub_stripes = btrfs_chunk_sub_stripes(leaf, chunk);
+
+	for (i = 0; i < num_stripes; i++) {
+		map->stripes[i].physical =
+			btrfs_stripe_offset_nr(leaf, chunk, i);
+		devid = btrfs_stripe_devid_nr(leaf, chunk, i);
+		read_extent_buffer(leaf, uuid, (unsigned long)
+				   btrfs_stripe_dev_uuid_nr(chunk, i),
+				   BTRFS_UUID_SIZE);
+		map->stripes[i].dev = btrfs_find_device(fs_info, devid, uuid,
+							NULL);
+		if (!map->stripes[i].dev) {
+			map->stripes[i].dev = fill_missing_device(devid);
+			printf("warning, device %llu is missing\n",
+			       (unsigned long long)devid);
+			list_add(&map->stripes[i].dev->dev_list,
+				 &fs_info->fs_devices->devices);
+		}
+
+	}
+	ret = insert_cache_extent(&map_tree->cache_tree, &map->ce);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to add chunk map start=%llu len=%llu: %d (%m)",
+		      map->ce.start, map->ce.size, ret);
+	}
+
+	return ret;
+}
+
+static int fill_device_from_item(struct extent_buffer *leaf,
+				 struct btrfs_dev_item *dev_item,
+				 struct btrfs_device *device)
+{
+	unsigned long ptr;
+
+	device->devid = btrfs_device_id(leaf, dev_item);
+	device->total_bytes = btrfs_device_total_bytes(leaf, dev_item);
+	device->bytes_used = btrfs_device_bytes_used(leaf, dev_item);
+	device->type = btrfs_device_type(leaf, dev_item);
+	device->io_align = btrfs_device_io_align(leaf, dev_item);
+	device->io_width = btrfs_device_io_width(leaf, dev_item);
+	device->sector_size = btrfs_device_sector_size(leaf, dev_item);
+
+	ptr = (unsigned long)btrfs_device_uuid(dev_item);
+	read_extent_buffer(leaf, device->uuid, ptr, BTRFS_UUID_SIZE);
+
+	return 0;
+}
+
+static int read_one_dev(struct btrfs_fs_info *fs_info,
+			struct extent_buffer *leaf,
+			struct btrfs_dev_item *dev_item)
+{
+	struct btrfs_device *device;
+	u64 devid;
+	int ret = 0;
+	u8 fs_uuid[BTRFS_UUID_SIZE];
+	u8 dev_uuid[BTRFS_UUID_SIZE];
+
+	devid = btrfs_device_id(leaf, dev_item);
+	read_extent_buffer(leaf, dev_uuid,
+			   (unsigned long)btrfs_device_uuid(dev_item),
+			   BTRFS_UUID_SIZE);
+	read_extent_buffer(leaf, fs_uuid,
+			   (unsigned long)btrfs_device_fsid(dev_item),
+			   BTRFS_FSID_SIZE);
+
+	if (memcmp(fs_uuid, fs_info->fs_devices->fsid, BTRFS_UUID_SIZE)) {
+		error("Seed device is not yet supported\n");
+		return -ENOTSUPP;
+	}
+
+	device = btrfs_find_device(fs_info, devid, dev_uuid, fs_uuid);
+	if (!device) {
+		device = kzalloc(sizeof(*device), GFP_NOFS);
+		if (!device)
+			return -ENOMEM;
+		list_add(&device->dev_list,
+			 &fs_info->fs_devices->devices);
+	}
+
+	fill_device_from_item(leaf, dev_item, device);
+	fs_info->fs_devices->total_rw_bytes +=
+		btrfs_device_total_bytes(leaf, dev_item);
+	return ret;
+}
+
+int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_super_block *super_copy = fs_info->super_copy;
+	struct extent_buffer *sb;
+	struct btrfs_disk_key *disk_key;
+	struct btrfs_chunk *chunk;
+	u8 *array_ptr;
+	unsigned long sb_array_offset;
+	int ret = 0;
+	u32 num_stripes;
+	u32 array_size;
+	u32 len = 0;
+	u32 cur_offset;
+	struct btrfs_key key;
+
+	if (fs_info->nodesize < BTRFS_SUPER_INFO_SIZE) {
+		printf("ERROR: nodesize %u too small to read superblock\n",
+				fs_info->nodesize);
+		return -EINVAL;
+	}
+	sb = alloc_dummy_extent_buffer(fs_info, BTRFS_SUPER_INFO_OFFSET,
+				       BTRFS_SUPER_INFO_SIZE);
+	if (!sb)
+		return -ENOMEM;
+	btrfs_set_buffer_uptodate(sb);
+	write_extent_buffer(sb, super_copy, 0, sizeof(*super_copy));
+	array_size = btrfs_super_sys_array_size(super_copy);
+
+	array_ptr = super_copy->sys_chunk_array;
+	sb_array_offset = offsetof(struct btrfs_super_block, sys_chunk_array);
+	cur_offset = 0;
+
+	while (cur_offset < array_size) {
+		disk_key = (struct btrfs_disk_key *)array_ptr;
+		len = sizeof(*disk_key);
+		if (cur_offset + len > array_size)
+			goto out_short_read;
+
+		btrfs_disk_key_to_cpu(&key, disk_key);
+
+		array_ptr += len;
+		sb_array_offset += len;
+		cur_offset += len;
+
+		if (key.type == BTRFS_CHUNK_ITEM_KEY) {
+			chunk = (struct btrfs_chunk *)sb_array_offset;
+			/*
+			 * At least one btrfs_chunk with one stripe must be
+			 * present, exact stripe count check comes afterwards
+			 */
+			len = btrfs_chunk_item_size(1);
+			if (cur_offset + len > array_size)
+				goto out_short_read;
+
+			num_stripes = btrfs_chunk_num_stripes(sb, chunk);
+			if (!num_stripes) {
+				printk(
+	    "ERROR: invalid number of stripes %u in sys_array at offset %u\n",
+					num_stripes, cur_offset);
+				ret = -EIO;
+				break;
+			}
+
+			len = btrfs_chunk_item_size(num_stripes);
+			if (cur_offset + len > array_size)
+				goto out_short_read;
+
+			ret = read_one_chunk(fs_info, &key, sb, chunk, -1);
+			if (ret)
+				break;
+		} else {
+			printk(
+		"ERROR: unexpected item type %u in sys_array at offset %u\n",
+				(u32)key.type, cur_offset);
+ 			ret = -EIO;
+ 			break;
+		}
+		array_ptr += len;
+		sb_array_offset += len;
+		cur_offset += len;
+	}
+	free_extent_buffer(sb);
+	return ret;
+
+out_short_read:
+	printk("ERROR: sys_array too short to read %u bytes at offset %u\n",
+			len, cur_offset);
+	free_extent_buffer(sb);
+	return -EIO;
+}
+
+int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_path *path;
+	struct extent_buffer *leaf;
+	struct btrfs_key key;
+	struct btrfs_key found_key;
+	struct btrfs_root *root = fs_info->chunk_root;
+	int ret;
+	int slot;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	/*
+	 * Read all device items, and then all the chunk items. All
+	 * device items are found before any chunk item (their object id
+	 * is smaller than the lowest possible object id for a chunk
+	 * item - BTRFS_FIRST_CHUNK_TREE_OBJECTID).
+	 */
+	key.objectid = BTRFS_DEV_ITEMS_OBJECTID;
+	key.offset = 0;
+	key.type = 0;
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	if (ret < 0)
+		goto error;
+	while(1) {
+		leaf = path->nodes[0];
+		slot = path->slots[0];
+		if (slot >= btrfs_header_nritems(leaf)) {
+			ret = btrfs_next_leaf(root, path);
+			if (ret == 0)
+				continue;
+			if (ret < 0)
+				goto error;
+			break;
+		}
+		btrfs_item_key_to_cpu(leaf, &found_key, slot);
+		if (found_key.type == BTRFS_DEV_ITEM_KEY) {
+			struct btrfs_dev_item *dev_item;
+			dev_item = btrfs_item_ptr(leaf, slot,
+						  struct btrfs_dev_item);
+			ret = read_one_dev(fs_info, leaf, dev_item);
+			if (ret < 0)
+				goto error;
+		} else if (found_key.type == BTRFS_CHUNK_ITEM_KEY) {
+			struct btrfs_chunk *chunk;
+			chunk = btrfs_item_ptr(leaf, slot, struct btrfs_chunk);
+			ret = read_one_chunk(fs_info, &found_key, leaf, chunk,
+					     slot);
+			if (ret < 0)
+				goto error;
+		}
+		path->slots[0]++;
+	}
+
+	ret = 0;
+error:
+	btrfs_free_path(path);
+	return ret;
+}
+
 /*
  * Get stripe length from chunk item and its stripe items
  *
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 4383b4f9c034..d0c09d831c74 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -182,6 +182,8 @@ static inline int btrfs_next_bg_system(struct btrfs_fs_info *fs_info,
 	return btrfs_next_bg(fs_info, logical, size,
 			BTRFS_BLOCK_GROUP_SYSTEM);
 }
+int btrfs_read_sys_array(struct btrfs_fs_info *fs_info);
+int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices);
 int btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
 void btrfs_close_all_devices(void);
-- 
2.26.0

