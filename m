Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C66211A0975
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Apr 2020 10:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgDGIol (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Apr 2020 04:44:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:33732 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgDGIol (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Apr 2020 04:44:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5EC4BAC44
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Apr 2020 08:44:38 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: Move on-disk structure definition to btrfs_tree.h
Date:   Tue,  7 Apr 2020 16:44:33 +0800
Message-Id: <20200407084434.46143-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These structures all are on-disk format. Move them to btrfs_tree.h

This move includes:
- btrfs magic
  It's a surprise that it's not even definied in btrfs_tree.h

- tree block max level
  Move it before btrfs_header definition.

- tree block backref revision
- btrfs_header structure
- btrfs_root_backup structure
- btrfs_super_block structure
- BTRFS_FEATURE_* flags

- btrfs_item structure
- btrfs_leaf structure
- btrfs_key_ptr structure
- btrfs_node structure

- BTRFS_INODE_* flags
  Move them before btrfs_inode_item definition.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This moved btree_tree.h is more appropriate for btrfs-progs to reuse.
---
 fs/btrfs/ctree.h                | 234 --------------------------------
 include/uapi/linux/btrfs_tree.h | 234 ++++++++++++++++++++++++++++++++
 2 files changed, 234 insertions(+), 234 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8aa7b9dac405..627b88b0eb08 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -49,8 +49,6 @@ extern struct kmem_cache *btrfs_free_space_bitmap_cachep;
 struct btrfs_ordered_sum;
 struct btrfs_ref;
 
-#define BTRFS_MAGIC 0x4D5F53665248425FULL /* ascii _BHRfS_M, no null */
-
 /*
  * Maximum number of mirrors that can be available for all profiles counting
  * the target device of dev-replace as one. During an active device replace
@@ -62,8 +60,6 @@ struct btrfs_ref;
  */
 #define BTRFS_MAX_MIRRORS (4 + 1)
 
-#define BTRFS_MAX_LEVEL 8
-
 #define BTRFS_OLDEST_GENERATION	0ULL
 
 /*
@@ -148,203 +144,6 @@ enum {
 	BTRFS_FS_STATE_DUMMY_FS_INFO,
 };
 
-#define BTRFS_BACKREF_REV_MAX		256
-#define BTRFS_BACKREF_REV_SHIFT		56
-#define BTRFS_BACKREF_REV_MASK		(((u64)BTRFS_BACKREF_REV_MAX - 1) << \
-					 BTRFS_BACKREF_REV_SHIFT)
-
-#define BTRFS_OLD_BACKREF_REV		0
-#define BTRFS_MIXED_BACKREF_REV		1
-
-/*
- * every tree block (leaf or node) starts with this header.
- */
-struct btrfs_header {
-	/* these first four must match the super block */
-	u8 csum[BTRFS_CSUM_SIZE];
-	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
-	__le64 bytenr; /* which block this node is supposed to live in */
-	__le64 flags;
-
-	/* allowed to be different from the super from here on down */
-	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
-	__le64 generation;
-	__le64 owner;
-	__le32 nritems;
-	u8 level;
-} __attribute__ ((__packed__));
-
-/*
- * this is a very generous portion of the super block, giving us
- * room to translate 14 chunks with 3 stripes each.
- */
-#define BTRFS_SYSTEM_CHUNK_ARRAY_SIZE 2048
-
-/*
- * just in case we somehow lose the roots and are not able to mount,
- * we store an array of the roots from previous transactions
- * in the super.
- */
-#define BTRFS_NUM_BACKUP_ROOTS 4
-struct btrfs_root_backup {
-	__le64 tree_root;
-	__le64 tree_root_gen;
-
-	__le64 chunk_root;
-	__le64 chunk_root_gen;
-
-	__le64 extent_root;
-	__le64 extent_root_gen;
-
-	__le64 fs_root;
-	__le64 fs_root_gen;
-
-	__le64 dev_root;
-	__le64 dev_root_gen;
-
-	__le64 csum_root;
-	__le64 csum_root_gen;
-
-	__le64 total_bytes;
-	__le64 bytes_used;
-	__le64 num_devices;
-	/* future */
-	__le64 unused_64[4];
-
-	u8 tree_root_level;
-	u8 chunk_root_level;
-	u8 extent_root_level;
-	u8 fs_root_level;
-	u8 dev_root_level;
-	u8 csum_root_level;
-	/* future and to align */
-	u8 unused_8[10];
-} __attribute__ ((__packed__));
-
-/*
- * the super block basically lists the main trees of the FS
- * it currently lacks any block count etc etc
- */
-struct btrfs_super_block {
-	/* the first 4 fields must match struct btrfs_header */
-	u8 csum[BTRFS_CSUM_SIZE];
-	/* FS specific UUID, visible to user */
-	u8 fsid[BTRFS_FSID_SIZE];
-	__le64 bytenr; /* this block number */
-	__le64 flags;
-
-	/* allowed to be different from the btrfs_header from here own down */
-	__le64 magic;
-	__le64 generation;
-	__le64 root;
-	__le64 chunk_root;
-	__le64 log_root;
-
-	/* this will help find the new super based on the log root */
-	__le64 log_root_transid;
-	__le64 total_bytes;
-	__le64 bytes_used;
-	__le64 root_dir_objectid;
-	__le64 num_devices;
-	__le32 sectorsize;
-	__le32 nodesize;
-	__le32 __unused_leafsize;
-	__le32 stripesize;
-	__le32 sys_chunk_array_size;
-	__le64 chunk_root_generation;
-	__le64 compat_flags;
-	__le64 compat_ro_flags;
-	__le64 incompat_flags;
-	__le16 csum_type;
-	u8 root_level;
-	u8 chunk_root_level;
-	u8 log_root_level;
-	struct btrfs_dev_item dev_item;
-
-	char label[BTRFS_LABEL_SIZE];
-
-	__le64 cache_generation;
-	__le64 uuid_tree_generation;
-
-	/* the UUID written into btree blocks */
-	u8 metadata_uuid[BTRFS_FSID_SIZE];
-
-	/* future expansion */
-	__le64 reserved[28];
-	u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
-	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
-} __attribute__ ((__packed__));
-
-/*
- * Compat flags that we support.  If any incompat flags are set other than the
- * ones specified below then we will fail to mount
- */
-#define BTRFS_FEATURE_COMPAT_SUPP		0ULL
-#define BTRFS_FEATURE_COMPAT_SAFE_SET		0ULL
-#define BTRFS_FEATURE_COMPAT_SAFE_CLEAR		0ULL
-
-#define BTRFS_FEATURE_COMPAT_RO_SUPP			\
-	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
-	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID)
-
-#define BTRFS_FEATURE_COMPAT_RO_SAFE_SET	0ULL
-#define BTRFS_FEATURE_COMPAT_RO_SAFE_CLEAR	0ULL
-
-#define BTRFS_FEATURE_INCOMPAT_SUPP			\
-	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
-	 BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL |	\
-	 BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS |		\
-	 BTRFS_FEATURE_INCOMPAT_BIG_METADATA |		\
-	 BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO |		\
-	 BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD |		\
-	 BTRFS_FEATURE_INCOMPAT_RAID56 |		\
-	 BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |		\
-	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
-	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
-	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
-	 BTRFS_FEATURE_INCOMPAT_RAID1C34)
-
-#define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
-	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
-#define BTRFS_FEATURE_INCOMPAT_SAFE_CLEAR		0ULL
-
-/*
- * A leaf is full of items. offset and size tell us where to find
- * the item in the leaf (relative to the start of the data area)
- */
-struct btrfs_item {
-	struct btrfs_disk_key key;
-	__le32 offset;
-	__le32 size;
-} __attribute__ ((__packed__));
-
-/*
- * leaves have an item area and a data area:
- * [item0, item1....itemN] [free space] [dataN...data1, data0]
- *
- * The data is separate from the items to get the keys closer together
- * during searches.
- */
-struct btrfs_leaf {
-	struct btrfs_header header;
-	struct btrfs_item items[];
-} __attribute__ ((__packed__));
-
-/*
- * all non-leaf blocks are nodes, they hold only keys and pointers to
- * other blocks
- */
-struct btrfs_key_ptr {
-	struct btrfs_disk_key key;
-	__le64 blockptr;
-	__le64 generation;
-} __attribute__ ((__packed__));
-
-struct btrfs_node {
-	struct btrfs_header header;
-	struct btrfs_key_ptr ptrs[];
-} __attribute__ ((__packed__));
-
 /*
  * btrfs_paths remember the path taken from the root down to the leaf.
  * level 0 is always the leaf, and nodes[1...BTRFS_MAX_LEVEL] will point
@@ -1307,39 +1106,6 @@ do {                                                                   \
        }                                                               \
 } while(0)
 
-/*
- * Inode flags
- */
-#define BTRFS_INODE_NODATASUM		(1 << 0)
-#define BTRFS_INODE_NODATACOW		(1 << 1)
-#define BTRFS_INODE_READONLY		(1 << 2)
-#define BTRFS_INODE_NOCOMPRESS		(1 << 3)
-#define BTRFS_INODE_PREALLOC		(1 << 4)
-#define BTRFS_INODE_SYNC		(1 << 5)
-#define BTRFS_INODE_IMMUTABLE		(1 << 6)
-#define BTRFS_INODE_APPEND		(1 << 7)
-#define BTRFS_INODE_NODUMP		(1 << 8)
-#define BTRFS_INODE_NOATIME		(1 << 9)
-#define BTRFS_INODE_DIRSYNC		(1 << 10)
-#define BTRFS_INODE_COMPRESS		(1 << 11)
-
-#define BTRFS_INODE_ROOT_ITEM_INIT	(1 << 31)
-
-#define BTRFS_INODE_FLAG_MASK						\
-	(BTRFS_INODE_NODATASUM |					\
-	 BTRFS_INODE_NODATACOW |					\
-	 BTRFS_INODE_READONLY |						\
-	 BTRFS_INODE_NOCOMPRESS |					\
-	 BTRFS_INODE_PREALLOC |						\
-	 BTRFS_INODE_SYNC |						\
-	 BTRFS_INODE_IMMUTABLE |					\
-	 BTRFS_INODE_APPEND |						\
-	 BTRFS_INODE_NODUMP |						\
-	 BTRFS_INODE_NOATIME |						\
-	 BTRFS_INODE_DIRSYNC |						\
-	 BTRFS_INODE_COMPRESS |						\
-	 BTRFS_INODE_ROOT_ITEM_INIT)
-
 struct btrfs_map_token {
 	const struct extent_buffer *eb;
 	char *kaddr;
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 8e322e2c7e78..a20a9e53a40a 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -5,6 +5,8 @@
 #include <linux/btrfs.h>
 #include <linux/types.h>
 
+#define BTRFS_MAGIC 0x4D5F53665248425FULL /* ascii _BHRfS_M, no null */
+
 /*
  * This header contains the structure definitions and constants used
  * by file system objects that can be retrieved using
@@ -559,6 +561,39 @@ struct btrfs_timespec {
 	__le32 nsec;
 } __attribute__ ((__packed__));
 
+/*
+ * Inode flags
+ */
+#define BTRFS_INODE_NODATASUM		(1 << 0)
+#define BTRFS_INODE_NODATACOW		(1 << 1)
+#define BTRFS_INODE_READONLY		(1 << 2)
+#define BTRFS_INODE_NOCOMPRESS		(1 << 3)
+#define BTRFS_INODE_PREALLOC		(1 << 4)
+#define BTRFS_INODE_SYNC		(1 << 5)
+#define BTRFS_INODE_IMMUTABLE		(1 << 6)
+#define BTRFS_INODE_APPEND		(1 << 7)
+#define BTRFS_INODE_NODUMP		(1 << 8)
+#define BTRFS_INODE_NOATIME		(1 << 9)
+#define BTRFS_INODE_DIRSYNC		(1 << 10)
+#define BTRFS_INODE_COMPRESS		(1 << 11)
+
+#define BTRFS_INODE_ROOT_ITEM_INIT	(1 << 31)
+
+#define BTRFS_INODE_FLAG_MASK						\
+	(BTRFS_INODE_NODATASUM |					\
+	 BTRFS_INODE_NODATACOW |					\
+	 BTRFS_INODE_READONLY |						\
+	 BTRFS_INODE_NOCOMPRESS |					\
+	 BTRFS_INODE_PREALLOC |						\
+	 BTRFS_INODE_SYNC |						\
+	 BTRFS_INODE_IMMUTABLE |					\
+	 BTRFS_INODE_APPEND |						\
+	 BTRFS_INODE_NODUMP |						\
+	 BTRFS_INODE_NOATIME |						\
+	 BTRFS_INODE_DIRSYNC |						\
+	 BTRFS_INODE_COMPRESS |						\
+	 BTRFS_INODE_ROOT_ITEM_INIT)
+
 struct btrfs_inode_item {
 	/* nfs style generation number */
 	__le64 generation;
@@ -985,4 +1020,203 @@ struct btrfs_qgroup_limit_item {
 	__le64 rsv_excl;
 } __attribute__ ((__packed__));
 
+/*
+ * just in case we somehow lose the roots and are not able to mount,
+ * we store an array of the roots from previous transactions
+ * in the super.
+ */
+#define BTRFS_NUM_BACKUP_ROOTS 4
+struct btrfs_root_backup {
+	__le64 tree_root;
+	__le64 tree_root_gen;
+
+	__le64 chunk_root;
+	__le64 chunk_root_gen;
+
+	__le64 extent_root;
+	__le64 extent_root_gen;
+
+	__le64 fs_root;
+	__le64 fs_root_gen;
+
+	__le64 dev_root;
+	__le64 dev_root_gen;
+
+	__le64 csum_root;
+	__le64 csum_root_gen;
+
+	__le64 total_bytes;
+	__le64 bytes_used;
+	__le64 num_devices;
+	/* future */
+	__le64 unused_64[4];
+
+	u8 tree_root_level;
+	u8 chunk_root_level;
+	u8 extent_root_level;
+	u8 fs_root_level;
+	u8 dev_root_level;
+	u8 csum_root_level;
+	/* future and to align */
+	u8 unused_8[10];
+} __attribute__ ((__packed__));
+
+/*
+ * this is a very generous portion of the super block, giving us
+ * room to translate 14 chunks with 3 stripes each.
+ */
+#define BTRFS_SYSTEM_CHUNK_ARRAY_SIZE 2048
+
+/*
+ * the super block basically lists the main trees of the FS
+ * it currently lacks any block count etc etc
+ */
+struct btrfs_super_block {
+	/* the first 4 fields must match struct btrfs_header */
+	u8 csum[BTRFS_CSUM_SIZE];
+	/* FS specific UUID, visible to user */
+	u8 fsid[BTRFS_FSID_SIZE];
+	__le64 bytenr; /* this block number */
+	__le64 flags;
+
+	/* allowed to be different from the btrfs_header from here own down */
+	__le64 magic;
+	__le64 generation;
+	__le64 root;
+	__le64 chunk_root;
+	__le64 log_root;
+
+	/* this will help find the new super based on the log root */
+	__le64 log_root_transid;
+	__le64 total_bytes;
+	__le64 bytes_used;
+	__le64 root_dir_objectid;
+	__le64 num_devices;
+	__le32 sectorsize;
+	__le32 nodesize;
+	__le32 __unused_leafsize;
+	__le32 stripesize;
+	__le32 sys_chunk_array_size;
+	__le64 chunk_root_generation;
+	__le64 compat_flags;
+	__le64 compat_ro_flags;
+	__le64 incompat_flags;
+	__le16 csum_type;
+	u8 root_level;
+	u8 chunk_root_level;
+	u8 log_root_level;
+	struct btrfs_dev_item dev_item;
+
+	char label[BTRFS_LABEL_SIZE];
+
+	__le64 cache_generation;
+	__le64 uuid_tree_generation;
+
+	/* the UUID written into btree blocks */
+	u8 metadata_uuid[BTRFS_FSID_SIZE];
+
+	/* future expansion */
+	__le64 reserved[28];
+	u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
+	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
+} __attribute__ ((__packed__));
+
+/*
+ * Compat flags that we support.  If any incompat flags are set other than the
+ * ones specified below then we will fail to mount
+ */
+#define BTRFS_FEATURE_COMPAT_SUPP		0ULL
+#define BTRFS_FEATURE_COMPAT_SAFE_SET		0ULL
+#define BTRFS_FEATURE_COMPAT_SAFE_CLEAR		0ULL
+
+#define BTRFS_FEATURE_COMPAT_RO_SUPP			\
+	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
+	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID)
+
+#define BTRFS_FEATURE_COMPAT_RO_SAFE_SET	0ULL
+#define BTRFS_FEATURE_COMPAT_RO_SAFE_CLEAR	0ULL
+
+#define BTRFS_FEATURE_INCOMPAT_SUPP			\
+	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
+	 BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL |	\
+	 BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS |		\
+	 BTRFS_FEATURE_INCOMPAT_BIG_METADATA |		\
+	 BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO |		\
+	 BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD |		\
+	 BTRFS_FEATURE_INCOMPAT_RAID56 |		\
+	 BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |		\
+	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
+	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
+	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
+	 BTRFS_FEATURE_INCOMPAT_RAID1C34)
+
+#define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
+	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
+#define BTRFS_FEATURE_INCOMPAT_SAFE_CLEAR		0ULL
+
+#define BTRFS_BACKREF_REV_MAX		256
+#define BTRFS_BACKREF_REV_SHIFT		56
+#define BTRFS_BACKREF_REV_MASK		(((u64)BTRFS_BACKREF_REV_MAX - 1) << \
+					 BTRFS_BACKREF_REV_SHIFT)
+
+#define BTRFS_OLD_BACKREF_REV		0
+#define BTRFS_MIXED_BACKREF_REV		1
+
+#define BTRFS_MAX_LEVEL 8
+
+/*
+ * every tree block (leaf or node) starts with this header.
+ */
+struct btrfs_header {
+	/* these first four must match the super block */
+	u8 csum[BTRFS_CSUM_SIZE];
+	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
+	__le64 bytenr; /* which block this node is supposed to live in */
+	__le64 flags;
+
+	/* allowed to be different from the super from here on down */
+	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
+	__le64 generation;
+	__le64 owner;
+	__le32 nritems;
+	u8 level;
+} __attribute__ ((__packed__));
+
+/*
+ * A leaf is full of items. offset and size tell us where to find
+ * the item in the leaf (relative to the start of the data area)
+ */
+struct btrfs_item {
+	struct btrfs_disk_key key;
+	__le32 offset;
+	__le32 size;
+} __attribute__ ((__packed__));
+
+/*
+ * leaves have an item area and a data area:
+ * [item0, item1....itemN] [free space] [dataN...data1, data0]
+ *
+ * The data is separate from the items to get the keys closer together
+ * during searches.
+ */
+struct btrfs_leaf {
+	struct btrfs_header header;
+	struct btrfs_item items[];
+} __attribute__ ((__packed__));
+
+/*
+ * all non-leaf blocks are nodes, they hold only keys and pointers to
+ * other blocks
+ */
+struct btrfs_key_ptr {
+	struct btrfs_disk_key key;
+	__le64 blockptr;
+	__le64 generation;
+} __attribute__ ((__packed__));
+
+struct btrfs_node {
+	struct btrfs_header header;
+	struct btrfs_key_ptr ptrs[];
+} __attribute__ ((__packed__));
+
 #endif /* _BTRFS_CTREE_H_ */
-- 
2.26.0

