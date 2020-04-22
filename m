Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FBF1B37DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 08:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgDVGup (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 02:50:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:51188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgDVGup (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 02:50:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 96827AC1D;
        Wed, 22 Apr 2020 06:50:40 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        u-boot@lists.denx.de
Cc:     marek.behun@nic.cz
Subject: [PATCH U-BOOT 07/26] fs: btrfs: Cross port structure accessor into ctree.h
Date:   Wed, 22 Apr 2020 14:49:50 +0800
Message-Id: <20200422065009.69392-8-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200422065009.69392-1-wqu@suse.com>
References: <20200422065009.69392-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This will include all structure accessor from btrfs-progs/ctree.h, which
is also the same as kernel ctree.h.

All these accessor handles the endian convert at runtime, and since all
of them are defined as static inline functions, even we don't use them
they won't take extra text space.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compat.h  |   14 +
 fs/btrfs/ctree.h   | 1136 ++++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/disk-io.h |    9 -
 3 files changed, 1064 insertions(+), 95 deletions(-)

diff --git a/fs/btrfs/compat.h b/fs/btrfs/compat.h
index 376a035cd6db..64e8b8ab3dfb 100644
--- a/fs/btrfs/compat.h
+++ b/fs/btrfs/compat.h
@@ -23,6 +23,20 @@
 #define cpu_to_le8(v) (v)
 #define __le8 u8
 
+/*
+ * Macros to generate set/get funcs for the struct fields
+ * assume there is a lefoo_to_cpu for every type, so lets make a simple
+ * one for u8:
+ */
+#define le8_to_cpu(v) (v)
+#define cpu_to_le8(v) (v)
+#define __le8 u8
+
+#define get_unaligned_le8(p) (*((u8 *)(p)))
+#define get_unaligned_8(p) (*((u8 *)(p)))
+#define put_unaligned_le8(val,p) ((*((u8 *)(p))) = (val))
+#define put_unaligned_8(val,p) ((*((u8 *)(p))) = (val))
+
 /*
  * Read data from device specified by @desc and @part
  *
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c7528d1ac3db..65ec8256d44b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -12,7 +12,10 @@
 #include <common.h>
 #include <compiler.h>
 #include <linux/rbtree.h>
+#include <linux/unaligned/le_byteshift.h>
+#include <u-boot/crc.h>
 #include "kernel-shared/btrfs_tree.h"
+#include "crypto/hash.h"
 #include "compat.h"
 #include "extent-io.h"
 
@@ -34,6 +37,20 @@
 /* four bytes for CRC32 */
 #define BTRFS_EMPTY_DIR_SIZE 0
 
+struct btrfs_mapping_tree {
+	struct cache_tree cache_tree;
+};
+
+static inline unsigned long btrfs_chunk_item_size(int num_stripes)
+{
+	BUG_ON(num_stripes == 0);
+	return sizeof(struct btrfs_chunk) +
+		sizeof(struct btrfs_stripe) * (num_stripes - 1);
+}
+
+#define __BTRFS_LEAF_DATA_SIZE(bs) ((bs) - sizeof(struct btrfs_header))
+#define BTRFS_LEAF_DATA_SIZE(fs_info) \
+				(__BTRFS_LEAF_DATA_SIZE(fs_info->nodesize))
 /* ioprio of readahead is set to idle */
 #define BTRFS_IOPRIO_READA (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0))
 
@@ -41,6 +58,35 @@
 
 #define BTRFS_MAX_EXTENT_SIZE SZ_128M
 
+struct btrfs_device;
+struct btrfs_fs_devices;
+struct btrfs_fs_info {
+	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
+	u8 *new_chunk_tree_uuid;
+	struct btrfs_root *fs_root;
+	struct btrfs_root *tree_root;
+	struct btrfs_root *chunk_root;
+	struct btrfs_root *csum_root;
+
+	struct rb_root fs_root_tree;
+
+	struct extent_io_tree extent_cache;
+
+	/* logical->physical extent mapping */
+	struct btrfs_mapping_tree mapping_tree;
+
+	u64 last_trans_committed;
+
+	struct btrfs_super_block *super_copy;
+
+	struct btrfs_fs_devices *fs_devices;
+
+	/* Cached block sizes */
+	u32 nodesize;
+	u32 sectorsize;
+	u32 stripesize;
+};
+
 /*
  * File system states
  */
@@ -62,6 +108,35 @@
 			    offsetof(type, member),			\
 			   sizeof(((type *)0)->member)))
 
+#define BTRFS_SETGET_HEADER_FUNCS(name, type, member, bits)		\
+static inline u##bits btrfs_##name(const struct extent_buffer *eb)	\
+{									\
+	const struct btrfs_header *h = (struct btrfs_header *)eb->data;	\
+	return le##bits##_to_cpu(h->member);				\
+}									\
+static inline void btrfs_set_##name(struct extent_buffer *eb,		\
+				    u##bits val)			\
+{									\
+	struct btrfs_header *h = (struct btrfs_header *)eb->data;	\
+	h->member = cpu_to_le##bits(val);				\
+}
+
+#define BTRFS_SETGET_FUNCS(name, type, member, bits)			\
+static inline u##bits btrfs_##name(const struct extent_buffer *eb,	\
+				   const type *s)			\
+{									\
+	unsigned long offset = (unsigned long)s;			\
+	const type *p = (type *) (eb->data + offset);			\
+	return get_unaligned_le##bits(&p->member);			\
+}									\
+static inline void btrfs_set_##name(struct extent_buffer *eb,		\
+				    type *s, u##bits val)		\
+{									\
+	unsigned long offset = (unsigned long)s;			\
+	type *p = (type *) (eb->data + offset);				\
+	put_unaligned_le##bits(val, &p->member);			\
+}
+
 #define BTRFS_SETGET_STACK_FUNCS(name, type, member, bits)		\
 static inline u##bits btrfs_##name(const type *s)			\
 {									\
@@ -72,126 +147,721 @@ static inline void btrfs_set_##name(type *s, u##bits val)		\
 	s->member = cpu_to_le##bits(val);				\
 }
 
-union btrfs_tree_node {
-	struct btrfs_header header;
-	struct btrfs_leaf leaf;
-	struct btrfs_node node;
-};
+BTRFS_SETGET_FUNCS(device_type, struct btrfs_dev_item, type, 64);
+BTRFS_SETGET_FUNCS(device_total_bytes, struct btrfs_dev_item, total_bytes, 64);
+BTRFS_SETGET_FUNCS(device_bytes_used, struct btrfs_dev_item, bytes_used, 64);
+BTRFS_SETGET_FUNCS(device_io_align, struct btrfs_dev_item, io_align, 32);
+BTRFS_SETGET_FUNCS(device_io_width, struct btrfs_dev_item, io_width, 32);
+BTRFS_SETGET_FUNCS(device_start_offset, struct btrfs_dev_item,
+		   start_offset, 64);
+BTRFS_SETGET_FUNCS(device_sector_size, struct btrfs_dev_item, sector_size, 32);
+BTRFS_SETGET_FUNCS(device_id, struct btrfs_dev_item, devid, 64);
+BTRFS_SETGET_FUNCS(device_group, struct btrfs_dev_item, dev_group, 32);
+BTRFS_SETGET_FUNCS(device_seek_speed, struct btrfs_dev_item, seek_speed, 8);
+BTRFS_SETGET_FUNCS(device_bandwidth, struct btrfs_dev_item, bandwidth, 8);
+BTRFS_SETGET_FUNCS(device_generation, struct btrfs_dev_item, generation, 64);
 
-struct btrfs_path {
-	union btrfs_tree_node *nodes[BTRFS_MAX_LEVEL];
-	u32 slots[BTRFS_MAX_LEVEL];
-};
+BTRFS_SETGET_STACK_FUNCS(stack_device_type, struct btrfs_dev_item, type, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_device_total_bytes, struct btrfs_dev_item,
+			 total_bytes, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_device_bytes_used, struct btrfs_dev_item,
+			 bytes_used, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_device_io_align, struct btrfs_dev_item,
+			 io_align, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_device_io_width, struct btrfs_dev_item,
+			 io_width, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_device_sector_size, struct btrfs_dev_item,
+			 sector_size, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_device_id, struct btrfs_dev_item, devid, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_device_group, struct btrfs_dev_item,
+			 dev_group, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_device_seek_speed, struct btrfs_dev_item,
+			 seek_speed, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_device_bandwidth, struct btrfs_dev_item,
+			 bandwidth, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_device_generation, struct btrfs_dev_item,
+			 generation, 64);
 
-struct btrfs_root {
-	u64 objectid;
-	u64 bytenr;
-	u64 root_dirid;
-};
+static inline char *btrfs_device_uuid(struct btrfs_dev_item *d)
+{
+	return (char *)d + offsetof(struct btrfs_dev_item, uuid);
+}
 
-struct btrfs_mapping_tree {
-	struct cache_tree cache_tree;
-};
+static inline char *btrfs_device_fsid(struct btrfs_dev_item *d)
+{
+	return (char *)d + offsetof(struct btrfs_dev_item, fsid);
+}
 
-struct btrfs_device;
-struct btrfs_fs_info {
-	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
-	u8 *new_chunk_tree_uuid;
-	struct btrfs_root *fs_root;
-	struct btrfs_root *tree_root;
-	struct btrfs_root *chunk_root;
-	struct btrfs_root *csum_root;
+BTRFS_SETGET_FUNCS(chunk_length, struct btrfs_chunk, length, 64);
+BTRFS_SETGET_FUNCS(chunk_owner, struct btrfs_chunk, owner, 64);
+BTRFS_SETGET_FUNCS(chunk_stripe_len, struct btrfs_chunk, stripe_len, 64);
+BTRFS_SETGET_FUNCS(chunk_io_align, struct btrfs_chunk, io_align, 32);
+BTRFS_SETGET_FUNCS(chunk_io_width, struct btrfs_chunk, io_width, 32);
+BTRFS_SETGET_FUNCS(chunk_sector_size, struct btrfs_chunk, sector_size, 32);
+BTRFS_SETGET_FUNCS(chunk_type, struct btrfs_chunk, type, 64);
+BTRFS_SETGET_FUNCS(chunk_num_stripes, struct btrfs_chunk, num_stripes, 16);
+BTRFS_SETGET_FUNCS(chunk_sub_stripes, struct btrfs_chunk, sub_stripes, 16);
+BTRFS_SETGET_FUNCS(stripe_devid, struct btrfs_stripe, devid, 64);
+BTRFS_SETGET_FUNCS(stripe_offset, struct btrfs_stripe, offset, 64);
 
-	struct rb_root fs_root_tree;
+static inline char *btrfs_stripe_dev_uuid(struct btrfs_stripe *s)
+{
+	return (char *)s + offsetof(struct btrfs_stripe, dev_uuid);
+}
 
-	struct extent_io_tree extent_cache;
-	struct extent_io_tree free_space_cache;
-	struct extent_io_tree pinned_extents;
-	struct extent_io_tree extent_ins;
-	struct extent_io_tree *excluded_extents;
+BTRFS_SETGET_STACK_FUNCS(stack_chunk_length, struct btrfs_chunk, length, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_chunk_owner, struct btrfs_chunk, owner, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_chunk_stripe_len, struct btrfs_chunk,
+			 stripe_len, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_chunk_io_align, struct btrfs_chunk,
+			 io_align, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_chunk_io_width, struct btrfs_chunk,
+			 io_width, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_chunk_sector_size, struct btrfs_chunk,
+			 sector_size, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_chunk_type, struct btrfs_chunk, type, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_chunk_num_stripes, struct btrfs_chunk,
+			 num_stripes, 16);
+BTRFS_SETGET_STACK_FUNCS(stack_chunk_sub_stripes, struct btrfs_chunk,
+			 sub_stripes, 16);
+BTRFS_SETGET_STACK_FUNCS(stack_stripe_devid, struct btrfs_stripe, devid, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_stripe_offset, struct btrfs_stripe, offset, 64);
 
-	struct rb_root block_group_cache_tree;
-	/* logical->physical extent mapping */
-	struct btrfs_mapping_tree mapping_tree;
+static inline struct btrfs_stripe *btrfs_stripe_nr(struct btrfs_chunk *c,
+						   int nr)
+{
+	unsigned long offset = (unsigned long)c;
+	offset += offsetof(struct btrfs_chunk, stripe);
+	offset += nr * sizeof(struct btrfs_stripe);
+	return (struct btrfs_stripe *)offset;
+}
 
-	u64 generation;
-	u64 last_trans_committed;
+static inline char *btrfs_stripe_dev_uuid_nr(struct btrfs_chunk *c, int nr)
+{
+	return btrfs_stripe_dev_uuid(btrfs_stripe_nr(c, nr));
+}
 
-	struct btrfs_super_block *super_copy;
+static inline u64 btrfs_stripe_offset_nr(struct extent_buffer *eb,
+					 struct btrfs_chunk *c, int nr)
+{
+	return btrfs_stripe_offset(eb, btrfs_stripe_nr(c, nr));
+}
 
-	u64 super_bytenr;
+static inline void btrfs_set_stripe_offset_nr(struct extent_buffer *eb,
+					     struct btrfs_chunk *c, int nr,
+					     u64 val)
+{
+	btrfs_set_stripe_offset(eb, btrfs_stripe_nr(c, nr), val);
+}
 
-	/* Only support one device yet */
-	struct btrfs_devvice *dev;
+static inline u64 btrfs_stripe_devid_nr(struct extent_buffer *eb,
+					 struct btrfs_chunk *c, int nr)
+{
+	return btrfs_stripe_devid(eb, btrfs_stripe_nr(c, nr));
+}
 
-	/* Cached block sizes */
-	u32 nodesize;
-	u32 sectorsize;
-	u32 stripesize;
-};
+static inline void btrfs_set_stripe_devid_nr(struct extent_buffer *eb,
+					     struct btrfs_chunk *c, int nr,
+					     u64 val)
+{
+	btrfs_set_stripe_devid(eb, btrfs_stripe_nr(c, nr), val);
+}
 
-int btrfs_comp_keys(struct btrfs_key *, struct btrfs_key *);
-int btrfs_comp_keys_type(struct btrfs_key *, struct btrfs_key *);
-int btrfs_bin_search(union btrfs_tree_node *, struct btrfs_key *, int *);
-void btrfs_free_path(struct btrfs_path *);
-int btrfs_search_tree(const struct btrfs_root *, struct btrfs_key *,
-		      struct btrfs_path *);
-int btrfs_prev_slot(struct btrfs_path *);
-int btrfs_next_slot(struct btrfs_path *);
+/* struct btrfs_block_group_item */
+BTRFS_SETGET_STACK_FUNCS(block_group_used, struct btrfs_block_group_item,
+			 used, 64);
+BTRFS_SETGET_FUNCS(disk_block_group_used, struct btrfs_block_group_item,
+			 used, 64);
+BTRFS_SETGET_STACK_FUNCS(block_group_chunk_objectid,
+			struct btrfs_block_group_item, chunk_objectid, 64);
 
-static inline struct btrfs_key *btrfs_path_leaf_key(struct btrfs_path *p) {
-	/* At tree read time we have converted the endian for btrfs_disk_key */
-	return (struct btrfs_key *)&p->nodes[0]->leaf.items[p->slots[0]].key;
+BTRFS_SETGET_FUNCS(disk_block_group_chunk_objectid,
+		   struct btrfs_block_group_item, chunk_objectid, 64);
+BTRFS_SETGET_FUNCS(disk_block_group_flags,
+		   struct btrfs_block_group_item, flags, 64);
+BTRFS_SETGET_STACK_FUNCS(block_group_flags,
+			struct btrfs_block_group_item, flags, 64);
+
+/* struct btrfs_free_space_info */
+BTRFS_SETGET_FUNCS(free_space_extent_count, struct btrfs_free_space_info,
+		   extent_count, 32);
+BTRFS_SETGET_FUNCS(free_space_flags, struct btrfs_free_space_info, flags, 32);
+
+/* struct btrfs_inode_ref */
+BTRFS_SETGET_FUNCS(inode_ref_name_len, struct btrfs_inode_ref, name_len, 16);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_ref_name_len, struct btrfs_inode_ref, name_len, 16);
+BTRFS_SETGET_FUNCS(inode_ref_index, struct btrfs_inode_ref, index, 64);
+
+/* struct btrfs_inode_extref */
+BTRFS_SETGET_FUNCS(inode_extref_parent, struct btrfs_inode_extref,
+		   parent_objectid, 64);
+BTRFS_SETGET_FUNCS(inode_extref_name_len, struct btrfs_inode_extref,
+		   name_len, 16);
+BTRFS_SETGET_FUNCS(inode_extref_index, struct btrfs_inode_extref, index, 64);
+
+/* struct btrfs_inode_item */
+BTRFS_SETGET_FUNCS(inode_generation, struct btrfs_inode_item, generation, 64);
+BTRFS_SETGET_FUNCS(inode_sequence, struct btrfs_inode_item, sequence, 64);
+BTRFS_SETGET_FUNCS(inode_transid, struct btrfs_inode_item, transid, 64);
+BTRFS_SETGET_FUNCS(inode_size, struct btrfs_inode_item, size, 64);
+BTRFS_SETGET_FUNCS(inode_nbytes, struct btrfs_inode_item, nbytes, 64);
+BTRFS_SETGET_FUNCS(inode_block_group, struct btrfs_inode_item, block_group, 64);
+BTRFS_SETGET_FUNCS(inode_nlink, struct btrfs_inode_item, nlink, 32);
+BTRFS_SETGET_FUNCS(inode_uid, struct btrfs_inode_item, uid, 32);
+BTRFS_SETGET_FUNCS(inode_gid, struct btrfs_inode_item, gid, 32);
+BTRFS_SETGET_FUNCS(inode_mode, struct btrfs_inode_item, mode, 32);
+BTRFS_SETGET_FUNCS(inode_rdev, struct btrfs_inode_item, rdev, 64);
+BTRFS_SETGET_FUNCS(inode_flags, struct btrfs_inode_item, flags, 64);
+
+BTRFS_SETGET_STACK_FUNCS(stack_inode_generation,
+			 struct btrfs_inode_item, generation, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_sequence,
+			 struct btrfs_inode_item, sequence, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_transid,
+			 struct btrfs_inode_item, transid, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_size,
+			 struct btrfs_inode_item, size, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_nbytes,
+			 struct btrfs_inode_item, nbytes, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_block_group,
+			 struct btrfs_inode_item, block_group, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_nlink,
+			 struct btrfs_inode_item, nlink, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_uid,
+			 struct btrfs_inode_item, uid, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_gid,
+			 struct btrfs_inode_item, gid, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_mode,
+			 struct btrfs_inode_item, mode, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_rdev,
+			 struct btrfs_inode_item, rdev, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_inode_flags,
+			 struct btrfs_inode_item, flags, 64);
+
+static inline struct btrfs_timespec *
+btrfs_inode_atime(struct btrfs_inode_item *inode_item)
+{
+	unsigned long ptr = (unsigned long)inode_item;
+	ptr += offsetof(struct btrfs_inode_item, atime);
+	return (struct btrfs_timespec *)ptr;
 }
 
-static inline struct btrfs_key *
-btrfs_search_tree_key_type(const struct btrfs_root *root, u64 objectid,
-			   u8 type, struct btrfs_path *path)
+static inline struct btrfs_timespec *
+btrfs_inode_mtime(struct btrfs_inode_item *inode_item)
 {
-	struct btrfs_key key, *res;
+	unsigned long ptr = (unsigned long)inode_item;
+	ptr += offsetof(struct btrfs_inode_item, mtime);
+	return (struct btrfs_timespec *)ptr;
+}
 
-	key.objectid = objectid;
-	key.type = type;
-	key.offset = 0;
+static inline struct btrfs_timespec *
+btrfs_inode_ctime(struct btrfs_inode_item *inode_item)
+{
+	unsigned long ptr = (unsigned long)inode_item;
+	ptr += offsetof(struct btrfs_inode_item, ctime);
+	return (struct btrfs_timespec *)ptr;
+}
 
-	if (btrfs_search_tree(root, &key, path))
-		return NULL;
+static inline struct btrfs_timespec *
+btrfs_inode_otime(struct btrfs_inode_item *inode_item)
+{
+	unsigned long ptr = (unsigned long)inode_item;
+	ptr += offsetof(struct btrfs_inode_item, otime);
+	return (struct btrfs_timespec *)ptr;
+}
 
-	res = btrfs_path_leaf_key(path);
-	if (btrfs_comp_keys_type(&key, res)) {
-		btrfs_free_path(path);
-		return NULL;
-	}
+BTRFS_SETGET_FUNCS(timespec_sec, struct btrfs_timespec, sec, 64);
+BTRFS_SETGET_FUNCS(timespec_nsec, struct btrfs_timespec, nsec, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_timespec_sec, struct btrfs_timespec,
+			 sec, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_timespec_nsec, struct btrfs_timespec,
+			 nsec, 32);
 
-	return res;
+/* struct btrfs_dev_extent */
+BTRFS_SETGET_FUNCS(dev_extent_chunk_tree, struct btrfs_dev_extent,
+		   chunk_tree, 64);
+BTRFS_SETGET_FUNCS(dev_extent_chunk_objectid, struct btrfs_dev_extent,
+		   chunk_objectid, 64);
+BTRFS_SETGET_FUNCS(dev_extent_chunk_offset, struct btrfs_dev_extent,
+		   chunk_offset, 64);
+BTRFS_SETGET_FUNCS(dev_extent_length, struct btrfs_dev_extent, length, 64);
+
+BTRFS_SETGET_STACK_FUNCS(stack_dev_extent_length, struct btrfs_dev_extent,
+			 length, 64);
+
+static inline u8 *btrfs_dev_extent_chunk_tree_uuid(struct btrfs_dev_extent *dev)
+{
+	unsigned long ptr = offsetof(struct btrfs_dev_extent, chunk_tree_uuid);
+	return (u8 *)((unsigned long)dev + ptr);
 }
 
-static inline u32 btrfs_path_item_size(struct btrfs_path *p)
+
+/* struct btrfs_extent_item */
+BTRFS_SETGET_FUNCS(extent_refs, struct btrfs_extent_item, refs, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_extent_refs, struct btrfs_extent_item, refs, 64);
+BTRFS_SETGET_FUNCS(extent_generation, struct btrfs_extent_item,
+		   generation, 64);
+BTRFS_SETGET_FUNCS(extent_flags, struct btrfs_extent_item, flags, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_extent_flags, struct btrfs_extent_item, flags, 64);
+
+BTRFS_SETGET_FUNCS(extent_refs_v0, struct btrfs_extent_item_v0, refs, 32);
+
+BTRFS_SETGET_FUNCS(tree_block_level, struct btrfs_tree_block_info, level, 8);
+
+static inline void btrfs_tree_block_key(struct extent_buffer *eb,
+					struct btrfs_tree_block_info *item,
+					struct btrfs_disk_key *key)
 {
-	return p->nodes[0]->leaf.items[p->slots[0]].size;
+	read_eb_member(eb, item, struct btrfs_tree_block_info, key, key);
 }
 
-static inline void *btrfs_leaf_data(struct btrfs_leaf *leaf, u32 slot)
+static inline void btrfs_set_tree_block_key(struct extent_buffer *eb,
+					    struct btrfs_tree_block_info *item,
+					    struct btrfs_disk_key *key)
 {
-	return ((u8 *) leaf) + sizeof(struct btrfs_header)
-	       + leaf->items[slot].offset;
+	write_eb_member(eb, item, struct btrfs_tree_block_info, key, key);
 }
 
-static inline void *btrfs_path_leaf_data(struct btrfs_path *p)
+BTRFS_SETGET_FUNCS(extent_data_ref_root, struct btrfs_extent_data_ref,
+		   root, 64);
+BTRFS_SETGET_FUNCS(extent_data_ref_objectid, struct btrfs_extent_data_ref,
+		   objectid, 64);
+BTRFS_SETGET_FUNCS(extent_data_ref_offset, struct btrfs_extent_data_ref,
+		   offset, 64);
+BTRFS_SETGET_FUNCS(extent_data_ref_count, struct btrfs_extent_data_ref,
+		   count, 32);
+
+BTRFS_SETGET_FUNCS(shared_data_ref_count, struct btrfs_shared_data_ref,
+		   count, 32);
+
+BTRFS_SETGET_FUNCS(extent_inline_ref_type, struct btrfs_extent_inline_ref,
+		   type, 8);
+BTRFS_SETGET_FUNCS(extent_inline_ref_offset, struct btrfs_extent_inline_ref,
+		   offset, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_extent_inline_ref_type,
+			 struct btrfs_extent_inline_ref, type, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_extent_inline_ref_offset,
+			 struct btrfs_extent_inline_ref, offset, 64);
+
+static inline u32 btrfs_extent_inline_ref_size(int type)
 {
-	return btrfs_leaf_data(&p->nodes[0]->leaf, p->slots[0]);
+	if (type == BTRFS_TREE_BLOCK_REF_KEY ||
+	    type == BTRFS_SHARED_BLOCK_REF_KEY)
+		return sizeof(struct btrfs_extent_inline_ref);
+	if (type == BTRFS_SHARED_DATA_REF_KEY)
+		return sizeof(struct btrfs_shared_data_ref) +
+		       sizeof(struct btrfs_extent_inline_ref);
+	if (type == BTRFS_EXTENT_DATA_REF_KEY)
+		return sizeof(struct btrfs_extent_data_ref) +
+		       offsetof(struct btrfs_extent_inline_ref, offset);
+	BUG();
+	return 0;
 }
 
-#define btrfs_item_ptr(l,s,t)			\
-	((t *) btrfs_leaf_data((l),(s)))
+BTRFS_SETGET_FUNCS(ref_root_v0, struct btrfs_extent_ref_v0, root, 64);
+BTRFS_SETGET_FUNCS(ref_generation_v0, struct btrfs_extent_ref_v0,
+		   generation, 64);
+BTRFS_SETGET_FUNCS(ref_objectid_v0, struct btrfs_extent_ref_v0, objectid, 64);
+BTRFS_SETGET_FUNCS(ref_count_v0, struct btrfs_extent_ref_v0, count, 32);
 
-#define btrfs_path_item_ptr(p,t)		\
-	((t *) btrfs_path_leaf_data((p)))
+/* struct btrfs_node */
+BTRFS_SETGET_FUNCS(key_blockptr, struct btrfs_key_ptr, blockptr, 64);
+BTRFS_SETGET_FUNCS(key_generation, struct btrfs_key_ptr, generation, 64);
 
-u16 btrfs_super_csum_size(const struct btrfs_super_block *s);
-const char *btrfs_super_csum_name(u16 csum_type);
-u16 btrfs_csum_type_size(u16 csum_type);
-size_t btrfs_super_num_csums(void);
+static inline u64 btrfs_node_blockptr(struct extent_buffer *eb, int nr)
+{
+	unsigned long ptr;
+	ptr = offsetof(struct btrfs_node, ptrs) +
+		sizeof(struct btrfs_key_ptr) * nr;
+	return btrfs_key_blockptr(eb, (struct btrfs_key_ptr *)ptr);
+}
+
+static inline void btrfs_set_node_blockptr(struct extent_buffer *eb,
+					   int nr, u64 val)
+{
+	unsigned long ptr;
+	ptr = offsetof(struct btrfs_node, ptrs) +
+		sizeof(struct btrfs_key_ptr) * nr;
+	btrfs_set_key_blockptr(eb, (struct btrfs_key_ptr *)ptr, val);
+}
+
+static inline u64 btrfs_node_ptr_generation(struct extent_buffer *eb, int nr)
+{
+	unsigned long ptr;
+	ptr = offsetof(struct btrfs_node, ptrs) +
+		sizeof(struct btrfs_key_ptr) * nr;
+	return btrfs_key_generation(eb, (struct btrfs_key_ptr *)ptr);
+}
+
+static inline void btrfs_set_node_ptr_generation(struct extent_buffer *eb,
+						 int nr, u64 val)
+{
+	unsigned long ptr;
+	ptr = offsetof(struct btrfs_node, ptrs) +
+		sizeof(struct btrfs_key_ptr) * nr;
+	btrfs_set_key_generation(eb, (struct btrfs_key_ptr *)ptr, val);
+}
+
+static inline unsigned long btrfs_node_key_ptr_offset(int nr)
+{
+	return offsetof(struct btrfs_node, ptrs) +
+		sizeof(struct btrfs_key_ptr) * nr;
+}
+
+static inline void btrfs_node_key(struct extent_buffer *eb,
+				  struct btrfs_disk_key *disk_key, int nr)
+{
+	unsigned long ptr;
+	ptr = btrfs_node_key_ptr_offset(nr);
+	read_eb_member(eb, (struct btrfs_key_ptr *)ptr,
+		       struct btrfs_key_ptr, key, disk_key);
+}
+
+static inline void btrfs_set_node_key(struct extent_buffer *eb,
+				      struct btrfs_disk_key *disk_key, int nr)
+{
+	unsigned long ptr;
+	ptr = btrfs_node_key_ptr_offset(nr);
+	write_eb_member(eb, (struct btrfs_key_ptr *)ptr,
+		       struct btrfs_key_ptr, key, disk_key);
+}
+
+/* struct btrfs_item */
+BTRFS_SETGET_FUNCS(item_offset, struct btrfs_item, offset, 32);
+BTRFS_SETGET_FUNCS(item_size, struct btrfs_item, size, 32);
+
+static inline unsigned long btrfs_item_nr_offset(int nr)
+{
+	return offsetof(struct btrfs_leaf, items) +
+		sizeof(struct btrfs_item) * nr;
+}
+
+static inline struct btrfs_item *btrfs_item_nr(int nr)
+{
+	return (struct btrfs_item *)btrfs_item_nr_offset(nr);
+}
+
+static inline u32 btrfs_item_end(struct extent_buffer *eb,
+				 struct btrfs_item *item)
+{
+	return btrfs_item_offset(eb, item) + btrfs_item_size(eb, item);
+}
+
+static inline u32 btrfs_item_end_nr(struct extent_buffer *eb, int nr)
+{
+	return btrfs_item_end(eb, btrfs_item_nr(nr));
+}
+
+static inline u32 btrfs_item_offset_nr(const struct extent_buffer *eb, int nr)
+{
+	return btrfs_item_offset(eb, btrfs_item_nr(nr));
+}
+
+static inline u32 btrfs_item_size_nr(struct extent_buffer *eb, int nr)
+{
+	return btrfs_item_size(eb, btrfs_item_nr(nr));
+}
+
+static inline void btrfs_item_key(struct extent_buffer *eb,
+			   struct btrfs_disk_key *disk_key, int nr)
+{
+	struct btrfs_item *item = btrfs_item_nr(nr);
+	read_eb_member(eb, item, struct btrfs_item, key, disk_key);
+}
+
+static inline void btrfs_set_item_key(struct extent_buffer *eb,
+			       struct btrfs_disk_key *disk_key, int nr)
+{
+	struct btrfs_item *item = btrfs_item_nr(nr);
+	write_eb_member(eb, item, struct btrfs_item, key, disk_key);
+}
+
+BTRFS_SETGET_FUNCS(dir_log_end, struct btrfs_dir_log_item, end, 64);
+
+/*
+ * struct btrfs_root_ref
+ */
+BTRFS_SETGET_FUNCS(root_ref_dirid, struct btrfs_root_ref, dirid, 64);
+BTRFS_SETGET_FUNCS(root_ref_sequence, struct btrfs_root_ref, sequence, 64);
+BTRFS_SETGET_FUNCS(root_ref_name_len, struct btrfs_root_ref, name_len, 16);
+
+BTRFS_SETGET_STACK_FUNCS(stack_root_ref_dirid, struct btrfs_root_ref, dirid, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_root_ref_sequence, struct btrfs_root_ref, sequence, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_root_ref_name_len, struct btrfs_root_ref, name_len, 16);
+
+/* struct btrfs_dir_item */
+BTRFS_SETGET_FUNCS(dir_data_len, struct btrfs_dir_item, data_len, 16);
+BTRFS_SETGET_FUNCS(dir_type, struct btrfs_dir_item, type, 8);
+BTRFS_SETGET_FUNCS(dir_name_len, struct btrfs_dir_item, name_len, 16);
+BTRFS_SETGET_FUNCS(dir_transid, struct btrfs_dir_item, transid, 64);
+
+BTRFS_SETGET_STACK_FUNCS(stack_dir_data_len, struct btrfs_dir_item, data_len, 16);
+BTRFS_SETGET_STACK_FUNCS(stack_dir_type, struct btrfs_dir_item, type, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_dir_name_len, struct btrfs_dir_item, name_len, 16);
+BTRFS_SETGET_STACK_FUNCS(stack_dir_transid, struct btrfs_dir_item, transid, 64);
+
+static inline void btrfs_dir_item_key(struct extent_buffer *eb,
+				      struct btrfs_dir_item *item,
+				      struct btrfs_disk_key *key)
+{
+	read_eb_member(eb, item, struct btrfs_dir_item, location, key);
+}
+
+static inline void btrfs_set_dir_item_key(struct extent_buffer *eb,
+					  struct btrfs_dir_item *item,
+					  struct btrfs_disk_key *key)
+{
+	write_eb_member(eb, item, struct btrfs_dir_item, location, key);
+}
+
+/* struct btrfs_free_space_header */
+BTRFS_SETGET_FUNCS(free_space_entries, struct btrfs_free_space_header,
+		   num_entries, 64);
+BTRFS_SETGET_FUNCS(free_space_bitmaps, struct btrfs_free_space_header,
+		   num_bitmaps, 64);
+BTRFS_SETGET_FUNCS(free_space_generation, struct btrfs_free_space_header,
+		   generation, 64);
+
+static inline void btrfs_free_space_key(struct extent_buffer *eb,
+					struct btrfs_free_space_header *h,
+					struct btrfs_disk_key *key)
+{
+	read_eb_member(eb, h, struct btrfs_free_space_header, location, key);
+}
+
+static inline void btrfs_set_free_space_key(struct extent_buffer *eb,
+					    struct btrfs_free_space_header *h,
+					    struct btrfs_disk_key *key)
+{
+	write_eb_member(eb, h, struct btrfs_free_space_header, location, key);
+}
+
+/* struct btrfs_disk_key */
+BTRFS_SETGET_STACK_FUNCS(disk_key_objectid, struct btrfs_disk_key,
+			 objectid, 64);
+BTRFS_SETGET_STACK_FUNCS(disk_key_offset, struct btrfs_disk_key, offset, 64);
+BTRFS_SETGET_STACK_FUNCS(disk_key_type, struct btrfs_disk_key, type, 8);
+
+static inline void btrfs_disk_key_to_cpu(struct btrfs_key *cpu,
+					 struct btrfs_disk_key *disk)
+{
+	cpu->offset = le64_to_cpu(disk->offset);
+	cpu->type = disk->type;
+	cpu->objectid = le64_to_cpu(disk->objectid);
+}
+
+static inline void btrfs_cpu_key_to_disk(struct btrfs_disk_key *disk,
+					 const struct btrfs_key *cpu)
+{
+	disk->offset = cpu_to_le64(cpu->offset);
+	disk->type = cpu->type;
+	disk->objectid = cpu_to_le64(cpu->objectid);
+}
+
+static inline void btrfs_node_key_to_cpu(struct extent_buffer *eb,
+				  struct btrfs_key *key, int nr)
+{
+	struct btrfs_disk_key disk_key;
+	btrfs_node_key(eb, &disk_key, nr);
+	btrfs_disk_key_to_cpu(key, &disk_key);
+}
+
+static inline void btrfs_item_key_to_cpu(struct extent_buffer *eb,
+				  struct btrfs_key *key, int nr)
+{
+	struct btrfs_disk_key disk_key;
+	btrfs_item_key(eb, &disk_key, nr);
+	btrfs_disk_key_to_cpu(key, &disk_key);
+}
+
+static inline void btrfs_dir_item_key_to_cpu(struct extent_buffer *eb,
+				      struct btrfs_dir_item *item,
+				      struct btrfs_key *key)
+{
+	struct btrfs_disk_key disk_key;
+	btrfs_dir_item_key(eb, item, &disk_key);
+	btrfs_disk_key_to_cpu(key, &disk_key);
+}
+
+/* struct btrfs_header */
+BTRFS_SETGET_HEADER_FUNCS(header_bytenr, struct btrfs_header, bytenr, 64);
+BTRFS_SETGET_HEADER_FUNCS(header_generation, struct btrfs_header,
+			  generation, 64);
+BTRFS_SETGET_HEADER_FUNCS(header_owner, struct btrfs_header, owner, 64);
+BTRFS_SETGET_HEADER_FUNCS(header_nritems, struct btrfs_header, nritems, 32);
+BTRFS_SETGET_HEADER_FUNCS(header_flags, struct btrfs_header, flags, 64);
+BTRFS_SETGET_HEADER_FUNCS(header_level, struct btrfs_header, level, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_header_bytenr, struct btrfs_header, bytenr, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_header_nritems, struct btrfs_header, nritems,
+			 32);
+BTRFS_SETGET_STACK_FUNCS(stack_header_owner, struct btrfs_header, owner, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_header_generation, struct btrfs_header,
+			 generation, 64);
+
+static inline int btrfs_header_flag(struct extent_buffer *eb, u64 flag)
+{
+	return (btrfs_header_flags(eb) & flag) == flag;
+}
+
+static inline int btrfs_set_header_flag(struct extent_buffer *eb, u64 flag)
+{
+	u64 flags = btrfs_header_flags(eb);
+	btrfs_set_header_flags(eb, flags | flag);
+	return (flags & flag) == flag;
+}
+
+static inline int btrfs_clear_header_flag(struct extent_buffer *eb, u64 flag)
+{
+	u64 flags = btrfs_header_flags(eb);
+	btrfs_set_header_flags(eb, flags & ~flag);
+	return (flags & flag) == flag;
+}
+
+static inline int btrfs_header_backref_rev(struct extent_buffer *eb)
+{
+	u64 flags = btrfs_header_flags(eb);
+	return flags >> BTRFS_BACKREF_REV_SHIFT;
+}
+
+static inline void btrfs_set_header_backref_rev(struct extent_buffer *eb,
+						int rev)
+{
+	u64 flags = btrfs_header_flags(eb);
+	flags &= ~BTRFS_BACKREF_REV_MASK;
+	flags |= (u64)rev << BTRFS_BACKREF_REV_SHIFT;
+	btrfs_set_header_flags(eb, flags);
+}
+
+static inline unsigned long btrfs_header_fsid(void)
+{
+	return offsetof(struct btrfs_header, fsid);
+}
+
+static inline unsigned long btrfs_header_chunk_tree_uuid(struct extent_buffer *eb)
+{
+	return offsetof(struct btrfs_header, chunk_tree_uuid);
+}
+
+static inline u8 *btrfs_header_csum(struct extent_buffer *eb)
+{
+	unsigned long ptr = offsetof(struct btrfs_header, csum);
+	return (u8 *)ptr;
+}
+
+static inline int btrfs_is_leaf(struct extent_buffer *eb)
+{
+	return (btrfs_header_level(eb) == 0);
+}
+
+/* struct btrfs_root_item */
+BTRFS_SETGET_FUNCS(disk_root_generation, struct btrfs_root_item,
+		   generation, 64);
+BTRFS_SETGET_FUNCS(disk_root_refs, struct btrfs_root_item, refs, 32);
+BTRFS_SETGET_FUNCS(disk_root_bytenr, struct btrfs_root_item, bytenr, 64);
+BTRFS_SETGET_FUNCS(disk_root_level, struct btrfs_root_item, level, 8);
+
+BTRFS_SETGET_STACK_FUNCS(root_generation, struct btrfs_root_item,
+			 generation, 64);
+BTRFS_SETGET_STACK_FUNCS(root_bytenr, struct btrfs_root_item, bytenr, 64);
+BTRFS_SETGET_STACK_FUNCS(root_level, struct btrfs_root_item, level, 8);
+BTRFS_SETGET_STACK_FUNCS(root_dirid, struct btrfs_root_item, root_dirid, 64);
+BTRFS_SETGET_STACK_FUNCS(root_refs, struct btrfs_root_item, refs, 32);
+BTRFS_SETGET_STACK_FUNCS(root_flags, struct btrfs_root_item, flags, 64);
+BTRFS_SETGET_STACK_FUNCS(root_used, struct btrfs_root_item, bytes_used, 64);
+BTRFS_SETGET_STACK_FUNCS(root_limit, struct btrfs_root_item, byte_limit, 64);
+BTRFS_SETGET_STACK_FUNCS(root_last_snapshot, struct btrfs_root_item,
+			 last_snapshot, 64);
+BTRFS_SETGET_STACK_FUNCS(root_generation_v2, struct btrfs_root_item,
+			 generation_v2, 64);
+BTRFS_SETGET_STACK_FUNCS(root_ctransid, struct btrfs_root_item,
+			 ctransid, 64);
+BTRFS_SETGET_STACK_FUNCS(root_otransid, struct btrfs_root_item,
+			 otransid, 64);
+BTRFS_SETGET_STACK_FUNCS(root_stransid, struct btrfs_root_item,
+			 stransid, 64);
+BTRFS_SETGET_STACK_FUNCS(root_rtransid, struct btrfs_root_item,
+			 rtransid, 64);
+
+static inline struct btrfs_timespec* btrfs_root_ctime(
+		struct btrfs_root_item *root_item)
+{
+	unsigned long ptr = (unsigned long)root_item;
+	ptr += offsetof(struct btrfs_root_item, ctime);
+	return (struct btrfs_timespec *)ptr;
+}
+
+static inline struct btrfs_timespec* btrfs_root_otime(
+		struct btrfs_root_item *root_item)
+{
+	unsigned long ptr = (unsigned long)root_item;
+	ptr += offsetof(struct btrfs_root_item, otime);
+	return (struct btrfs_timespec *)ptr;
+}
+
+static inline struct btrfs_timespec* btrfs_root_stime(
+		struct btrfs_root_item *root_item)
+{
+	unsigned long ptr = (unsigned long)root_item;
+	ptr += offsetof(struct btrfs_root_item, stime);
+	return (struct btrfs_timespec *)ptr;
+}
+
+static inline struct btrfs_timespec* btrfs_root_rtime(
+		struct btrfs_root_item *root_item)
+{
+	unsigned long ptr = (unsigned long)root_item;
+	ptr += offsetof(struct btrfs_root_item, rtime);
+	return (struct btrfs_timespec *)ptr;
+}
+
+/* struct btrfs_root_backup */
+BTRFS_SETGET_STACK_FUNCS(backup_tree_root, struct btrfs_root_backup,
+		   tree_root, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_tree_root_gen, struct btrfs_root_backup,
+		   tree_root_gen, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_tree_root_level, struct btrfs_root_backup,
+		   tree_root_level, 8);
+
+BTRFS_SETGET_STACK_FUNCS(backup_chunk_root, struct btrfs_root_backup,
+		   chunk_root, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_chunk_root_gen, struct btrfs_root_backup,
+		   chunk_root_gen, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_chunk_root_level, struct btrfs_root_backup,
+		   chunk_root_level, 8);
+
+BTRFS_SETGET_STACK_FUNCS(backup_extent_root, struct btrfs_root_backup,
+		   extent_root, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_extent_root_gen, struct btrfs_root_backup,
+		   extent_root_gen, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_extent_root_level, struct btrfs_root_backup,
+		   extent_root_level, 8);
+
+BTRFS_SETGET_STACK_FUNCS(backup_fs_root, struct btrfs_root_backup,
+		   fs_root, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_fs_root_gen, struct btrfs_root_backup,
+		   fs_root_gen, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_fs_root_level, struct btrfs_root_backup,
+		   fs_root_level, 8);
+
+BTRFS_SETGET_STACK_FUNCS(backup_dev_root, struct btrfs_root_backup,
+		   dev_root, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_dev_root_gen, struct btrfs_root_backup,
+		   dev_root_gen, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_dev_root_level, struct btrfs_root_backup,
+		   dev_root_level, 8);
+
+BTRFS_SETGET_STACK_FUNCS(backup_csum_root, struct btrfs_root_backup,
+		   csum_root, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_csum_root_gen, struct btrfs_root_backup,
+		   csum_root_gen, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_csum_root_level, struct btrfs_root_backup,
+		   csum_root_level, 8);
+BTRFS_SETGET_STACK_FUNCS(backup_total_bytes, struct btrfs_root_backup,
+		   total_bytes, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_bytes_used, struct btrfs_root_backup,
+		   bytes_used, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_num_devices, struct btrfs_root_backup,
+		   num_devices, 64);
 
 /* struct btrfs_super_block */
 
@@ -244,4 +914,298 @@ BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
 			 uuid_tree_generation, 64);
 BTRFS_SETGET_STACK_FUNCS(super_magic, struct btrfs_super_block, magic, 64);
 
+static inline unsigned long btrfs_leaf_data(struct extent_buffer *l)
+{
+	return offsetof(struct btrfs_leaf, items);
+}
+
+/* struct btrfs_file_extent_item */
+BTRFS_SETGET_FUNCS(file_extent_type, struct btrfs_file_extent_item, type, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_file_extent_type, struct btrfs_file_extent_item, type, 8);
+
+static inline unsigned long btrfs_file_extent_inline_start(struct
+						   btrfs_file_extent_item *e)
+{
+	unsigned long offset = (unsigned long)e;
+	offset += offsetof(struct btrfs_file_extent_item, disk_bytenr);
+	return offset;
+}
+
+static inline u32 btrfs_file_extent_calc_inline_size(u32 datasize)
+{
+	return offsetof(struct btrfs_file_extent_item, disk_bytenr) + datasize;
+}
+
+BTRFS_SETGET_FUNCS(file_extent_disk_bytenr, struct btrfs_file_extent_item,
+		   disk_bytenr, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_file_extent_disk_bytenr, struct btrfs_file_extent_item,
+		   disk_bytenr, 64);
+BTRFS_SETGET_FUNCS(file_extent_generation, struct btrfs_file_extent_item,
+		   generation, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_file_extent_generation, struct btrfs_file_extent_item,
+		   generation, 64);
+BTRFS_SETGET_FUNCS(file_extent_disk_num_bytes, struct btrfs_file_extent_item,
+		   disk_num_bytes, 64);
+BTRFS_SETGET_FUNCS(file_extent_offset, struct btrfs_file_extent_item,
+		  offset, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_file_extent_offset, struct btrfs_file_extent_item,
+		  offset, 64);
+BTRFS_SETGET_FUNCS(file_extent_num_bytes, struct btrfs_file_extent_item,
+		   num_bytes, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_file_extent_num_bytes, struct btrfs_file_extent_item,
+		   num_bytes, 64);
+BTRFS_SETGET_FUNCS(file_extent_ram_bytes, struct btrfs_file_extent_item,
+		   ram_bytes, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_file_extent_ram_bytes, struct btrfs_file_extent_item,
+		   ram_bytes, 64);
+BTRFS_SETGET_FUNCS(file_extent_compression, struct btrfs_file_extent_item,
+		   compression, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_file_extent_compression, struct btrfs_file_extent_item,
+		   compression, 8);
+BTRFS_SETGET_FUNCS(file_extent_encryption, struct btrfs_file_extent_item,
+		   encryption, 8);
+BTRFS_SETGET_FUNCS(file_extent_other_encoding, struct btrfs_file_extent_item,
+		   other_encoding, 16);
+
+/* btrfs_qgroup_status_item */
+BTRFS_SETGET_FUNCS(qgroup_status_version, struct btrfs_qgroup_status_item,
+		   version, 64);
+BTRFS_SETGET_FUNCS(qgroup_status_generation, struct btrfs_qgroup_status_item,
+		   generation, 64);
+BTRFS_SETGET_FUNCS(qgroup_status_flags, struct btrfs_qgroup_status_item,
+		   flags, 64);
+BTRFS_SETGET_FUNCS(qgroup_status_rescan, struct btrfs_qgroup_status_item,
+		   rescan, 64);
+
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_status_version,
+			 struct btrfs_qgroup_status_item, version, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_status_generation,
+			 struct btrfs_qgroup_status_item, generation, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_status_flags,
+			 struct btrfs_qgroup_status_item, flags, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_status_rescan,
+			 struct btrfs_qgroup_status_item, rescan, 64);
+
+/* btrfs_qgroup_info_item */
+BTRFS_SETGET_FUNCS(qgroup_info_generation, struct btrfs_qgroup_info_item,
+		   generation, 64);
+BTRFS_SETGET_FUNCS(qgroup_info_referenced, struct btrfs_qgroup_info_item,
+		   rfer, 64);
+BTRFS_SETGET_FUNCS(qgroup_info_referenced_compressed,
+		   struct btrfs_qgroup_info_item, rfer_cmpr, 64);
+BTRFS_SETGET_FUNCS(qgroup_info_exclusive, struct btrfs_qgroup_info_item,
+		   excl, 64);
+BTRFS_SETGET_FUNCS(qgroup_info_exclusive_compressed,
+		   struct btrfs_qgroup_info_item, excl_cmpr, 64);
+
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_generation,
+			 struct btrfs_qgroup_info_item, generation, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_referenced,
+			 struct btrfs_qgroup_info_item, rfer, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_referenced_compressed,
+		   struct btrfs_qgroup_info_item, rfer_cmpr, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_exclusive,
+			 struct btrfs_qgroup_info_item, excl, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_info_exclusive_compressed,
+		   struct btrfs_qgroup_info_item, excl_cmpr, 64);
+
+/* btrfs_qgroup_limit_item */
+BTRFS_SETGET_FUNCS(qgroup_limit_flags, struct btrfs_qgroup_limit_item,
+		   flags, 64);
+BTRFS_SETGET_FUNCS(qgroup_limit_max_referenced, struct btrfs_qgroup_limit_item,
+		   max_rfer, 64);
+BTRFS_SETGET_FUNCS(qgroup_limit_max_exclusive, struct btrfs_qgroup_limit_item,
+		   max_excl, 64);
+BTRFS_SETGET_FUNCS(qgroup_limit_rsv_referenced, struct btrfs_qgroup_limit_item,
+		   rsv_rfer, 64);
+BTRFS_SETGET_FUNCS(qgroup_limit_rsv_exclusive, struct btrfs_qgroup_limit_item,
+		   rsv_excl, 64);
+
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_flags,
+			 struct btrfs_qgroup_limit_item, flags, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_max_referenced,
+			 struct btrfs_qgroup_limit_item, max_rfer, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_max_exclusive,
+			 struct btrfs_qgroup_limit_item, max_excl, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_rsv_referenced,
+			 struct btrfs_qgroup_limit_item, rsv_rfer, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_rsv_exclusive,
+			 struct btrfs_qgroup_limit_item, rsv_excl, 64);
+
+/* btrfs_balance_item */
+BTRFS_SETGET_FUNCS(balance_item_flags, struct btrfs_balance_item, flags, 64);
+
+static inline struct btrfs_disk_balance_args* btrfs_balance_item_data(
+		struct extent_buffer *eb, struct btrfs_balance_item *bi)
+{
+	unsigned long offset = (unsigned long)bi;
+	struct btrfs_balance_item *p;
+	p = (struct btrfs_balance_item *)(eb->data + offset);
+	return &p->data;
+}
+
+static inline struct btrfs_disk_balance_args* btrfs_balance_item_meta(
+		struct extent_buffer *eb, struct btrfs_balance_item *bi)
+{
+	unsigned long offset = (unsigned long)bi;
+	struct btrfs_balance_item *p;
+	p = (struct btrfs_balance_item *)(eb->data + offset);
+	return &p->meta;
+}
+
+static inline struct btrfs_disk_balance_args* btrfs_balance_item_sys(
+		struct extent_buffer *eb, struct btrfs_balance_item *bi)
+{
+	unsigned long offset = (unsigned long)bi;
+	struct btrfs_balance_item *p;
+	p = (struct btrfs_balance_item *)(eb->data + offset);
+	return &p->sys;
+}
+
+static inline u64 btrfs_dev_stats_value(const struct extent_buffer *eb,
+					const struct btrfs_dev_stats_item *ptr,
+					int index)
+{
+	u64 val;
+
+	read_extent_buffer(eb, &val,
+			   offsetof(struct btrfs_dev_stats_item, values) +
+			    ((unsigned long)ptr) + (index * sizeof(u64)),
+			   sizeof(val));
+	return val;
+}
+
+/*
+ * this returns the number of bytes used by the item on disk, minus the
+ * size of any extent headers.  If a file is compressed on disk, this is
+ * the compressed size
+ */
+static inline u32 btrfs_file_extent_inline_item_len(struct extent_buffer *eb,
+						    struct btrfs_item *e)
+{
+       unsigned long offset;
+       offset = offsetof(struct btrfs_file_extent_item, disk_bytenr);
+       return btrfs_item_size(eb, e) - offset;
+}
+
+#define btrfs_fs_incompat(fs_info, opt) \
+	__btrfs_fs_incompat((fs_info), BTRFS_FEATURE_INCOMPAT_##opt)
+
+static inline bool __btrfs_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag)
+{
+	struct btrfs_super_block *disk_super;
+	disk_super = fs_info->super_copy;
+	return !!(btrfs_super_incompat_flags(disk_super) & flag);
+}
+
+#define btrfs_fs_compat_ro(fs_info, opt) \
+	__btrfs_fs_compat_ro((fs_info), BTRFS_FEATURE_COMPAT_RO_##opt)
+
+static inline int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag)
+{
+	struct btrfs_super_block *disk_super;
+	disk_super = fs_info->super_copy;
+	return !!(btrfs_super_compat_ro_flags(disk_super) & flag);
+}
+
+/* helper function to cast into the data area of the leaf. */
+#define btrfs_item_ptr(leaf, slot, type) \
+	((type *)(btrfs_leaf_data(leaf) + \
+	btrfs_item_offset_nr(leaf, slot)))
+
+#define btrfs_item_ptr_offset(leaf, slot) \
+	((unsigned long)(btrfs_leaf_data(leaf) + \
+	btrfs_item_offset_nr(leaf, slot)))
+
+static inline u64 btrfs_name_hash(const char *name, int len)
+{
+	return (u64)crc32c((u32)~1, (u8 *)name, len);
+}
+
+/*
+ * Figure the key offset of an extended inode ref
+ */
+static inline u64 btrfs_extref_hash(u64 parent_objectid, const char *name,
+				    int len)
+{
+	return crc32(parent_objectid, (u8 *)name, len);
+}
+
+union btrfs_tree_node {
+	struct btrfs_header header;
+	struct btrfs_leaf leaf;
+	struct btrfs_node node;
+};
+
+struct btrfs_path {
+	union btrfs_tree_node *nodes[BTRFS_MAX_LEVEL];
+	u32 slots[BTRFS_MAX_LEVEL];
+};
+
+struct btrfs_root {
+	u64 objectid;
+	u64 bytenr;
+	u64 root_dirid;
+};
+
+int btrfs_comp_keys(struct btrfs_key *, struct btrfs_key *);
+int btrfs_comp_keys_type(struct btrfs_key *, struct btrfs_key *);
+int btrfs_bin_search(union btrfs_tree_node *, struct btrfs_key *, int *);
+void btrfs_free_path(struct btrfs_path *);
+int btrfs_search_tree(const struct btrfs_root *, struct btrfs_key *,
+		      struct btrfs_path *);
+int btrfs_prev_slot(struct btrfs_path *);
+int btrfs_next_slot(struct btrfs_path *);
+
+static inline struct btrfs_key *btrfs_path_leaf_key(struct btrfs_path *p) {
+	/* At tree read time we have converted the endian for btrfs_disk_key */
+	return (struct btrfs_key *)&p->nodes[0]->leaf.items[p->slots[0]].key;
+}
+
+static inline struct btrfs_key *
+btrfs_search_tree_key_type(const struct btrfs_root *root, u64 objectid,
+			   u8 type, struct btrfs_path *path)
+{
+	struct btrfs_key key, *res;
+
+	key.objectid = objectid;
+	key.type = type;
+	key.offset = 0;
+
+	if (btrfs_search_tree(root, &key, path))
+		return NULL;
+
+	res = btrfs_path_leaf_key(path);
+	if (btrfs_comp_keys_type(&key, res)) {
+		btrfs_free_path(path);
+		return NULL;
+	}
+
+	return res;
+}
+
+static inline u32 btrfs_path_item_size(struct btrfs_path *p)
+{
+	return p->nodes[0]->leaf.items[p->slots[0]].size;
+}
+
+static inline void *__btrfs_leaf_data(struct btrfs_leaf *leaf, u32 slot)
+{
+	return ((u8 *) leaf) + sizeof(struct btrfs_header)
+	       + leaf->items[slot].offset;
+}
+
+static inline void *btrfs_path_leaf_data(struct btrfs_path *p)
+{
+	return __btrfs_leaf_data(&p->nodes[0]->leaf, p->slots[0]);
+}
+
+#define btrfs_path_item_ptr(p,t)		\
+	((t *) btrfs_path_leaf_data((p)))
+
+u16 btrfs_super_csum_size(const struct btrfs_super_block *s);
+const char *btrfs_super_csum_name(u16 csum_type);
+u16 btrfs_csum_type_size(u16 csum_type);
+size_t btrfs_super_num_csums(void);
+
 #endif /* __BTRFS_CTREE_H__ */
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 671f1ac55c68..8190abc920ad 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -4,20 +4,11 @@
 
 #include <linux/sizes.h>
 #include <fs_internal.h>
-#include "crypto/hash.h"
 #include "ctree.h"
 #include "disk-io.h"
 
 #define BTRFS_SUPER_INFO_OFFSET SZ_64K
 #define BTRFS_SUPER_INFO_SIZE	SZ_4K
-static inline u64 btrfs_name_hash(const char *name, int len)
-{
-	u32 crc;
-
-	crc = crc32c((u32)~1, (unsigned char *)name, len);
-
-	return (u64)crc;
-}
 
 int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len);
 
-- 
2.26.0

