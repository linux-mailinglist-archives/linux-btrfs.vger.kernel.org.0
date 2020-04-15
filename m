Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A8C1A971E
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Apr 2020 10:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894837AbgDOIlj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Apr 2020 04:41:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:39668 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2894820AbgDOIla (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Apr 2020 04:41:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 79589ABE7
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Apr 2020 08:41:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 2/2] btrfs: Reformat btrfs_tree.h comments
Date:   Wed, 15 Apr 2020 16:41:13 +0800
Message-Id: <20200415084113.64378-3-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415084113.64378-1-wqu@suse.com>
References: <20200415084113.64378-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since we're here, modify btrfs_tree.h to follow the latest comment
style.

This involves:
- Use upper case char for the first word
- Use one line comment if possible
- Add the ending dot if it's a sentence
- Add more comment explaining the usage of each tree
- Add key type/objectid/offset reference URL
- Remove dead comment
- Update the header define line to reflect the filename
- Add newline to seperate long comment

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 include/uapi/linux/btrfs_tree.h | 455 ++++++++++++++++----------------
 1 file changed, 232 insertions(+), 223 deletions(-)

diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 1170be498c43..d0402359300c 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _BTRFS_CTREE_H_
-#define _BTRFS_CTREE_H_
+#ifndef __BTRFS_TREE_H__
+#define __BTRFS_TREE_H__
 
 #include <linux/types.h>
 
@@ -23,95 +23,98 @@
 #define BTRFS_NAME_LEN 255
 
 /*
- * This header contains the structure definitions and constants used
- * by file system objects that can be retrieved using
- * the BTRFS_IOC_SEARCH_TREE ioctl.  That means basically anything that
- * is needed to describe a leaf node's key or item contents.
+ * Objectids start from here.
+ *
+ * Check btrfs_disk_key for the meaning of objectids.
  */
 
-/* holds pointers to all of the tree roots */
+/*
+ * Root tree holds pointers to all of the tree roots.
+ * Without special mention, the root tree contains the root bytenr of all other 
+ * trees, except the chunk tree and the log tree.
+ *
+ * The super block contains the root bytenr of this tree.
+ */
 #define BTRFS_ROOT_TREE_OBJECTID 1ULL
 
-/* stores information about which extents are in use, and reference counts */
+/*
+ * Extent tree stores information about which extents are in use, and backrefs
+ * for each extent.
+ */
 #define BTRFS_EXTENT_TREE_OBJECTID 2ULL
 
 /*
- * chunk tree stores translations from logical -> physical block numbering
- * the super block points to the chunk tree
+ * Chunk tree stores btrfs logical address -> physical address mapping.
+ *
+ * The super block contains part of chunk tree for bootstrap, and contains
+ * the root bytenr of this tree.
  */
 #define BTRFS_CHUNK_TREE_OBJECTID 3ULL
 
 /*
- * stores information about which areas of a given device are in use.
- * one per device.  The tree of tree roots points to the device tree
+ * Device tree stores info about which areas of a given device are in use,
+ * and physical address -> btrfs logical address mapping.
  */
 #define BTRFS_DEV_TREE_OBJECTID 4ULL
 
-/* one per subvolume, storing files and directories */
+/* The fs tree is the first subvolume tree, storing files and directories. */
 #define BTRFS_FS_TREE_OBJECTID 5ULL
 
-/* directory objectid inside the root tree */
+/* Shows the directory objectid inside the root tree. */
 #define BTRFS_ROOT_TREE_DIR_OBJECTID 6ULL
 
-/* holds checksums of all the data extents */
+/* Csum tree holds checksums of all the data extents. */
 #define BTRFS_CSUM_TREE_OBJECTID 7ULL
 
-/* holds quota configuration and tracking */
+/* Quota tree holds quota configuration and tracking. */
 #define BTRFS_QUOTA_TREE_OBJECTID 8ULL
 
-/* for storing items that use the BTRFS_UUID_KEY* types */
+/* UUID tree stores items that use the BTRFS_UUID_KEY* types. */
 #define BTRFS_UUID_TREE_OBJECTID 9ULL
 
-/* tracks free space in block groups. */
+/* Free space cache tree (v2 space cache) tracks free space in block groups. */
 #define BTRFS_FREE_SPACE_TREE_OBJECTID 10ULL
 
-/* device stats in the device tree */
+/* Indicates device stats in the device tree. */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
 
-/* for storing balance parameters in the root tree */
+/* For storing balance parameters in the root tree. */
 #define BTRFS_BALANCE_OBJECTID -4ULL
 
-/* orhpan objectid for tracking unlinked/truncated files */
+/* Orhpan objectid for tracking unlinked/truncated files. */
 #define BTRFS_ORPHAN_OBJECTID -5ULL
 
-/* does write ahead logging to speed up fsyncs */
+/* Does write ahead logging to speed up fsyncs. */
 #define BTRFS_TREE_LOG_OBJECTID -6ULL
 #define BTRFS_TREE_LOG_FIXUP_OBJECTID -7ULL
 
-/* for space balancing */
+/* For space balancing. */
 #define BTRFS_TREE_RELOC_OBJECTID -8ULL
 #define BTRFS_DATA_RELOC_TREE_OBJECTID -9ULL
 
-/*
- * extent checksums all have this objectid
- * this allows them to share the logging tree
- * for fsyncs
- */
+/* Extent checksums, shared between the csum tree and log trees. */
 #define BTRFS_EXTENT_CSUM_OBJECTID -10ULL
 
-/* For storing free space cache */
+/* For storing free space cache (v1 space cache). */
 #define BTRFS_FREE_SPACE_OBJECTID -11ULL
 
-/*
- * The inode number assigned to the special inode for storing
- * free ino cache
- */
+/* The inode number assigned to the special inode for storing free ino cache. */
 #define BTRFS_FREE_INO_OBJECTID -12ULL
 
-/* dummy objectid represents multiple objectids */
+/* Dummy objectid represents multiple objectids. */
 #define BTRFS_MULTIPLE_OBJECTIDS -255ULL
 
-/*
- * All files have objectids in this range.
- */
+/* All files have objectids in this range. */
 #define BTRFS_FIRST_FREE_OBJECTID 256ULL
 #define BTRFS_LAST_FREE_OBJECTID -256ULL
 #define BTRFS_FIRST_CHUNK_TREE_OBJECTID 256ULL
 
 
 /*
- * the device items go into the chunk tree.  The key is in the form
- * [ 1 BTRFS_DEV_ITEM_KEY device_id ]
+ * The device items go into the chunk tree.
+ *
+ * The key is in the form
+ * (BTRFS_DEV_ITEMS_OBJECTID, BTRFS_DEV_ITEM_KEY,  <device_id>)
  */
 #define BTRFS_DEV_ITEMS_OBJECTID 1ULL
 
@@ -122,58 +125,68 @@
 #define BTRFS_DEV_REPLACE_DEVID 0ULL
 
 /*
- * inode items have the data typically returned from stat and store other
- * info about object characteristics.  There is one for every file and dir in
- * the FS
+ * Types start from here.
+ *
+ * Check btrfs_disk_key for details about types.
+ */
+
+/*
+ * Inode items have the data typically returned from stat and store other
+ * info about object characteristics.
+ *
+ * There is one for every file and dir in the FS.
  */
 #define BTRFS_INODE_ITEM_KEY		1
+/* reserve 2-11 close to the inode for later flexibility */
 #define BTRFS_INODE_REF_KEY		12
 #define BTRFS_INODE_EXTREF_KEY		13
 #define BTRFS_XATTR_ITEM_KEY		24
 #define BTRFS_ORPHAN_ITEM_KEY		48
-/* reserve 2-15 close to the inode for later flexibility */
 
 /*
- * dir items are the name -> inode pointers in a directory.  There is one
- * for every name in a directory.
+ * Dir items are the name -> inode pointers in a directory.
+ *
+ * There is one for every name in a directory.
  */
 #define BTRFS_DIR_LOG_ITEM_KEY  60
 #define BTRFS_DIR_LOG_INDEX_KEY 72
 #define BTRFS_DIR_ITEM_KEY	84
 #define BTRFS_DIR_INDEX_KEY	96
-/*
- * extent data is for file data
- */
+
+/* Stores info (position, size ...) about a data extent of a file */
 #define BTRFS_EXTENT_DATA_KEY	108
 
 /*
- * extent csums are stored in a separate tree and hold csums for
+ * Extent csums are stored in a separate tree and hold csums for
  * an entire extent on disk.
  */
 #define BTRFS_EXTENT_CSUM_KEY	128
 
 /*
- * root items point to tree roots.  They are typically in the root
- * tree used by the super block to find all the other trees
+ * Root items point to tree roots.
+ *
+ * They are typically in the root tree used by the super block to find all the
+ * other trees.
  */
 #define BTRFS_ROOT_ITEM_KEY	132
 
 /*
- * root backrefs tie subvols and snapshots to the directory entries that
- * reference them
+ * Root backrefs tie subvols and snapshots to the directory entries that
+ * reference them.
  */
 #define BTRFS_ROOT_BACKREF_KEY	144
 
 /*
- * root refs make a fast index for listing all of the snapshots and
+ * Root refs make a fast index for listing all of the snapshots and
  * subvolumes referenced by a given root.  They point directly to the
- * directory item in the root that references the subvol
+ * directory item in the root that references the subvol.
  */
 #define BTRFS_ROOT_REF_KEY	156
 
 /*
- * extent items are in the extent map tree.  These record which blocks
- * are used, and how many references there are to each block
+ * Extent items are in the extent tree.
+ *
+ * These record which blocks are used, and how many references there are.
  */
 #define BTRFS_EXTENT_ITEM_KEY	168
 
@@ -194,8 +207,9 @@
 #define BTRFS_SHARED_DATA_REF_KEY	184
 
 /*
- * block groups give us hints into the extent allocation trees.  Which
- * blocks are free etc etc
+ * Block groups give us hints into the extent allocation trees.
+ *
+ * Stores how many free space there is in a block group.
  */
 #define BTRFS_BLOCK_GROUP_ITEM_KEY 192
 
@@ -214,9 +228,10 @@
 
 /*
  * When a block group becomes very fragmented, we convert it to use bitmaps
- * instead of extents. A free space bitmap is keyed on
- * (start, FREE_SPACE_BITMAP, length); the corresponding item is a bitmap with
- * (length / sectorsize) bits.
+ * instead of extents.
+ *
+ * A free space bitmap is keyed on (start, FREE_SPACE_BITMAP, length).
+ * The corresponding item is a bitmap with (length / sectorsize) bits.
  */
 #define BTRFS_FREE_SPACE_BITMAP_KEY 200
 
@@ -226,20 +241,25 @@
 
 /*
  * Records the overall state of the qgroups.
+ *
  * There's only one instance of this key present,
  * (0, BTRFS_QGROUP_STATUS_KEY, 0)
  */
 #define BTRFS_QGROUP_STATUS_KEY         240
 /*
  * Records the currently used space of the qgroup.
+ *
  * One key per qgroup, (0, BTRFS_QGROUP_INFO_KEY, qgroupid).
  */
 #define BTRFS_QGROUP_INFO_KEY           242
+
 /*
  * Contains the user configured limits for the qgroup.
+ *
  * One key per qgroup, (0, BTRFS_QGROUP_LIMIT_KEY, qgroupid).
  */
 #define BTRFS_QGROUP_LIMIT_KEY          244
+
 /*
  * Records the child-parent relationship of qgroups. For
  * each relation, 2 keys are present:
@@ -248,9 +268,7 @@
  */
 #define BTRFS_QGROUP_RELATION_KEY       246
 
-/*
- * Obsolete name, see BTRFS_TEMPORARY_ITEM_KEY.
- */
+/* Obsolete name, see BTRFS_TEMPORARY_ITEM_KEY. */
 #define BTRFS_BALANCE_ITEM_KEY	248
 
 /*
@@ -266,9 +284,7 @@
  */
 #define BTRFS_TEMPORARY_ITEM_KEY	248
 
-/*
- * Obsolete name, see BTRFS_PERSISTENT_ITEM_KEY
- */
+/* Obsolete name, see BTRFS_PERSISTENT_ITEM_KEY */
 #define BTRFS_DEV_STATS_KEY		249
 
 /*
@@ -287,13 +303,15 @@
 #define BTRFS_PERSISTENT_ITEM_KEY	249
 
 /*
- * Persistantly stores the device replace state in the device tree.
+ * Persistently stores the device replace state in the device tree.
+ *
  * The key is built like this: (0, BTRFS_DEV_REPLACE_KEY, 0).
  */
 #define BTRFS_DEV_REPLACE_KEY	250
 
 /*
  * Stores items that allow to quickly map UUIDs to something else.
+ *
  * These items are part of the filesystem UUID tree.
  * The key is built like this:
  * (UUID_upper_64_bits, BTRFS_UUID_KEY*, UUID_lower_64_bits).
@@ -303,8 +321,9 @@
 						 * received subvols */
 
 /*
- * string items are for debugging.  They just store a short string of
- * data in the FS
+ * String items are for debugging.
+ *
+ * They just store a short string of data in the FS.
  */
 #define BTRFS_STRING_ITEM_KEY	253
 
@@ -313,7 +332,7 @@
 /* 32 bytes in various csum fields */
 #define BTRFS_CSUM_SIZE 32
 
-/* csum types */
+/* Csum types */
 enum btrfs_csum_type {
 	BTRFS_CSUM_TYPE_CRC32	= 0,
 	BTRFS_CSUM_TYPE_XXHASH	= 1,
@@ -322,7 +341,7 @@ enum btrfs_csum_type {
 };
 
 /*
- * flags definitions for directory entry item type
+ * Flags definitions for directory entry item type.
  *
  * Used by:
  * struct btrfs_dir_item.type
@@ -347,14 +366,13 @@ enum btrfs_csum_type {
  * The key defines the order in the tree, and so it also defines (optimal)
  * block layout.
  *
- * objectid corresponds to the inode number.
+ * Objectid and offset are interpreted based on type.
+ * While normally for objectid, it either represents a root number, or an
+ * inode number.
  *
- * type tells us things about the object, and is a kind of stream selector.
- * so for a given inode, keys with type of 1 might refer to the inode data,
- * type of 2 may point to file data in the btree and type == 3 may point to
- * extents.
- *
- * offset is the starting byte offset for this key in the stream.
+ * Type tells us things about the object, and is a kind of stream selector.
+ * Check the following URL for full references about btrfs_disk_key/btrfs_key:
+ * https://btrfs.wiki.kernel.org/index.php/Btree_Items
  *
  * btrfs_disk_key is in disk byte order.  struct btrfs_key is always
  * in cpu native order.  Otherwise they are identical and their sizes
@@ -373,49 +391,49 @@ struct btrfs_key {
 } __attribute__ ((__packed__));
 
 struct btrfs_dev_item {
-	/* the internal btrfs device id */
+	/* The internal btrfs device id */
 	__le64 devid;
 
-	/* size of the device */
+	/* Size of the device */
 	__le64 total_bytes;
 
-	/* bytes used */
+	/* Bytes used */
 	__le64 bytes_used;
 
-	/* optimal io alignment for this device */
+	/* Optimal io alignment for this device */
 	__le32 io_align;
 
-	/* optimal io width for this device */
+	/* Optimal io width for this device */
 	__le32 io_width;
 
-	/* minimal io size for this device */
+	/* Minimal io size for this device */
 	__le32 sector_size;
 
-	/* type and info about this device */
+	/* Type and info about this device */
 	__le64 type;
 
-	/* expected generation for this device */
+	/* Expected generation for this device */
 	__le64 generation;
 
 	/*
-	 * starting byte of this partition on the device,
-	 * to allow for stripe alignment in the future
+	 * Starting byte of this partition on the device,
+	 * to allow for stripe alignment in the future.
 	 */
 	__le64 start_offset;
 
-	/* grouping information for allocation decisions */
+	/* Grouping information for allocation decisions */
 	__le32 dev_group;
 
-	/* seek speed 0-100 where 100 is fastest */
+	/* Optimal seek speed 0-100 where 100 is fastest */
 	__u8 seek_speed;
 
-	/* bandwidth 0-100 where 100 is fastest */
+	/* Optimal bandwidth 0-100 where 100 is fastest */
 	__u8 bandwidth;
 
-	/* btrfs generated uuid for this device */
+	/* Btrfs generated uuid for this device */
 	__u8 uuid[BTRFS_UUID_SIZE];
 
-	/* uuid of FS who owns this device */
+	/* UUID of FS who owns this device */
 	__u8 fsid[BTRFS_UUID_SIZE];
 } __attribute__ ((__packed__));
 
@@ -426,30 +444,31 @@ struct btrfs_stripe {
 } __attribute__ ((__packed__));
 
 struct btrfs_chunk {
-	/* size of this chunk in bytes */
+	/* Size of this chunk in bytes */
 	__le64 length;
 
-	/* objectid of the root referencing this chunk */
+	/* Objectid of the root referencing this chunk */
 	__le64 owner;
 
 	__le64 stripe_len;
 	__le64 type;
 
-	/* optimal io alignment for this chunk */
+	/* Optimal io alignment for this chunk */
 	__le32 io_align;
 
-	/* optimal io width for this chunk */
+	/* Optimal io width for this chunk */
 	__le32 io_width;
 
-	/* minimal io size for this chunk */
+	/* Minimal io size for this chunk */
 	__le32 sector_size;
 
-	/* 2^16 stripes is quite a lot, a second limit is the size of a single
-	 * item in the btree
+	/*
+	 * 2^16 stripes is quite a lot, a second limit is the size of a single
+	 * item in the btree.
 	 */
 	__le16 num_stripes;
 
-	/* sub stripes only matter for raid10 */
+	/* Sub stripes only matter for raid10 */
 	__le16 sub_stripes;
 	struct btrfs_stripe stripe;
 	/* additional stripes go here */
@@ -486,10 +505,9 @@ struct btrfs_free_space_header {
 
 
 /*
- * items in the extent btree are used to record the objectid of the
- * owner of the block and the number of references
+ * Items in the extent tree are used to record the objectid of the
+ * owner of the block and the number of references.
  */
-
 struct btrfs_extent_item {
 	__le64 refs;
 	__le64 generation;
@@ -504,14 +522,12 @@ struct btrfs_extent_item_v0 {
 #define BTRFS_EXTENT_FLAG_DATA		(1ULL << 0)
 #define BTRFS_EXTENT_FLAG_TREE_BLOCK	(1ULL << 1)
 
-/* following flags only apply to tree blocks */
-
-/* use full backrefs for extent pointers in the block */
+/* Use full backrefs for extent pointers in the block */
 #define BTRFS_BLOCK_FLAG_FULL_BACKREF	(1ULL << 8)
 
 /*
- * this flag is only used internally by scrub and may be changed at any time
- * it is only declared here to avoid collisions
+ * This flag is only used internally by scrub and may be changed at any time
+ * it is only declared here to avoid collisions.
  */
 #define BTRFS_EXTENT_FLAG_SUPER		(1ULL << 48)
 
@@ -536,7 +552,7 @@ struct btrfs_extent_inline_ref {
 	__le64 offset;
 } __attribute__ ((__packed__));
 
-/* old style backrefs item */
+/* Old style backrefs item */
 struct btrfs_extent_ref_v0 {
 	__le64 root;
 	__le64 generation;
@@ -545,9 +561,11 @@ struct btrfs_extent_ref_v0 {
 } __attribute__ ((__packed__));
 
 
-/* dev extents record free space on individual devices.  The owner
- * field points back to the chunk allocation mapping tree that allocated
- * the extent.  The chunk tree uuid field is a way to double check the owner
+/* Dev extents record used space on individual devices.
+ *
+ * The owner field points back to the chunk allocation mapping tree that
+ * allocated the extent.
+ * The chunk tree uuid field is a way to double check the owner.
  */
 struct btrfs_dev_extent {
 	__le64 chunk_tree;
@@ -560,7 +578,7 @@ struct btrfs_dev_extent {
 struct btrfs_inode_ref {
 	__le64 index;
 	__le16 name_len;
-	/* name goes here */
+	/* Name goes here */
 } __attribute__ ((__packed__));
 
 struct btrfs_inode_extref {
@@ -568,7 +586,7 @@ struct btrfs_inode_extref {
 	__le64 index;
 	__le16 name_len;
 	__u8   name[0];
-	/* name goes here */
+	/* Name goes here */
 } __attribute__ ((__packed__));
 
 struct btrfs_timespec {
@@ -576,9 +594,7 @@ struct btrfs_timespec {
 	__le32 nsec;
 } __attribute__ ((__packed__));
 
-/*
- * Inode flags
- */
+/* Inode flags */
 #define BTRFS_INODE_NODATASUM		(1 << 0)
 #define BTRFS_INODE_NODATACOW		(1 << 1)
 #define BTRFS_INODE_READONLY		(1 << 2)
@@ -610,9 +626,9 @@ struct btrfs_timespec {
 	 BTRFS_INODE_ROOT_ITEM_INIT)
 
 struct btrfs_inode_item {
-	/* nfs style generation number */
+	/* Nfs style generation number */
 	__le64 generation;
-	/* transid that last touched this inode */
+	/* Transid that last touched this inode */
 	__le64 transid;
 	__le64 size;
 	__le64 nbytes;
@@ -624,12 +640,12 @@ struct btrfs_inode_item {
 	__le64 rdev;
 	__le64 flags;
 
-	/* modification sequence number for NFS */
+	/* Modification sequence number for NFS */
 	__le64 sequence;
 
 	/*
-	 * a little future expansion, for more than this we can
-	 * just grow the inode item and version it
+	 * A little future expansion, for more than this we can just grow the
+	 * inode item and version it
 	 */
 	__le64 reserved[4];
 	struct btrfs_timespec atime;
@@ -685,27 +701,25 @@ struct btrfs_root_item {
 	 * mismatching generation values here and thus must invalidate the
 	 * new fields. See btrfs_update_root and btrfs_find_last_root for
 	 * details.
-	 * the offset of generation_v2 is also used as the start for the memset
+	 * The offset of generation_v2 is also used as the start for the memset
 	 * when invalidating the fields.
 	 */
 	__le64 generation_v2;
 	__u8 uuid[BTRFS_UUID_SIZE];
 	__u8 parent_uuid[BTRFS_UUID_SIZE];
 	__u8 received_uuid[BTRFS_UUID_SIZE];
-	__le64 ctransid; /* updated when an inode changes */
-	__le64 otransid; /* trans when created */
-	__le64 stransid; /* trans when sent. non-zero for received subvol */
-	__le64 rtransid; /* trans when received. non-zero for received subvol */
+	__le64 ctransid; /* Updated when an inode changes */
+	__le64 otransid; /* Trans when created */
+	__le64 stransid; /* Trans when sent. Non-zero for received subvol. */
+	__le64 rtransid; /* Trans when received. Non-zero for received subvol.*/
 	struct btrfs_timespec ctime;
 	struct btrfs_timespec otime;
 	struct btrfs_timespec stime;
 	struct btrfs_timespec rtime;
-	__le64 reserved[8]; /* for future */
+	__le64 reserved[8]; /* For future */
 } __attribute__ ((__packed__));
 
-/*
- * this is used for both forward and backward root refs
- */
+/* This is used for both forward and backward root refs */
 struct btrfs_root_ref {
 	__le64 dirid;
 	__le64 sequence;
@@ -714,13 +728,14 @@ struct btrfs_root_ref {
 
 struct btrfs_disk_balance_args {
 	/*
-	 * profiles to operate on, single is denoted by
-	 * BTRFS_AVAIL_ALLOC_BIT_SINGLE
+	 * Profiles to operate on.
+	 *
+	 * SINGLE is denoted by BTRFS_AVAIL_ALLOC_BIT_SINGLE.
 	 */
 	__le64 profiles;
 
 	/*
-	 * usage filter
+	 * Usage filter
 	 * BTRFS_BALANCE_ARGS_USAGE with a single value means '0..N'
 	 * BTRFS_BALANCE_ARGS_USAGE_RANGE - range syntax, min..max
 	 */
@@ -732,20 +747,21 @@ struct btrfs_disk_balance_args {
 		};
 	};
 
-	/* devid filter */
+	/* Devid filter */
 	__le64 devid;
 
-	/* devid subset filter [pstart..pend) */
+	/* Devid subset filter [pstart..pend) */
 	__le64 pstart;
 	__le64 pend;
 
-	/* btrfs virtual address space subset filter [vstart..vend) */
+	/* Btrfs virtual address space subset filter [vstart..vend) */
 	__le64 vstart;
 	__le64 vend;
 
 	/*
-	 * profile to convert to, single is denoted by
-	 * BTRFS_AVAIL_ALLOC_BIT_SINGLE
+	 * Profile to convert to.
+	 *
+	 * SINGLE is denoted by BTRFS_AVAIL_ALLOC_BIT_SINGLE.
 	 */
 	__le64 target;
 
@@ -753,9 +769,9 @@ struct btrfs_disk_balance_args {
 	__le64 flags;
 
 	/*
-	 * BTRFS_BALANCE_ARGS_LIMIT with value 'limit'
+	 * BTRFS_BALANCE_ARGS_LIMIT with value 'limit'.
 	 * BTRFS_BALANCE_ARGS_LIMIT_RANGE - the extend version can use minimum
-	 * and maximum
+	 * and maximum.
 	 */
 	union {
 		__le64 limit;
@@ -767,7 +783,7 @@ struct btrfs_disk_balance_args {
 
 	/*
 	 * Process chunks that cross stripes_min..stripes_max devices,
-	 * BTRFS_BALANCE_ARGS_STRIPES_RANGE
+	 * BTRFS_BALANCE_ARGS_STRIPES_RANGE.
 	 */
 	__le32 stripes_min;
 	__le32 stripes_max;
@@ -776,8 +792,8 @@ struct btrfs_disk_balance_args {
 } __attribute__ ((__packed__));
 
 /*
- * store balance parameters to disk so that balance can be properly
- * resumed after crash or unmount
+ * Stores balance parameters to disk so that balance can be properly
+ * resumed after crash or unmount.
  */
 struct btrfs_balance_item {
 	/* BTRFS_BALANCE_* */
@@ -806,16 +822,14 @@ enum btrfs_compression_type {
 };
 
 struct btrfs_file_extent_item {
-	/*
-	 * transaction id that created this extent
-	 */
+	/* Transaction id that created this extent */
 	__le64 generation;
 	/*
-	 * max number of bytes to hold this extent in ram
-	 * when we split a compressed extent we can't know how big
-	 * each of the resulting pieces will be.  So, this is
-	 * an upper limit on the size of the extent in ram instead of
-	 * an exact limit.
+	 * Max number of bytes to hold this extent in ram.
+	 *
+	 * When we split a compressed extent we can't know how big each of the
+	 * resulting pieces will be.  So, this is an upper limit on the size of
+	 * the extent in ram instead of an exact limit.
 	 */
 	__le64 ram_bytes;
 
@@ -828,30 +842,34 @@ struct btrfs_file_extent_item {
 	 */
 	__u8 compression;
 	__u8 encryption;
-	__le16 other_encoding; /* spare for later use */
+	__le16 other_encoding; /* Spare for later use */
 
-	/* are we inline data or a real extent? */
+	/* Are we inline data or a real extent? */
 	__u8 type;
 
 	/*
-	 * disk space consumed by the extent, checksum blocks are included
+	 * Disk space consumed by the extent, checksum blocks are not included
 	 * in these numbers
 	 *
 	 * At this offset in the structure, the inline extent data start.
 	 */
 	__le64 disk_bytenr;
 	__le64 disk_num_bytes;
+
 	/*
-	 * the logical offset in file blocks (no csums)
-	 * this extent record is for.  This allows a file extent to point
-	 * into the middle of an existing extent on disk, sharing it
-	 * between two snapshots (useful if some bytes in the middle of the
-	 * extent have changed
+	 * The logical offset inside the file extent.
+	 *
+	 * This allows a file extent to point into the middle of an existing
+	 * extent on disk, sharing it between two snapshots (useful if some
+	 * bytes in the middle of the extent have changed).
 	 */
 	__le64 offset;
+
 	/*
-	 * the logical number of file blocks (no csums included).  This
-	 * always reflects the size uncompressed and without encoding.
+	 * The logical number of bytes this file extent is referencing (no
+	 * csums included).
+	 *
+	 * This always reflects the size uncompressed and without encoding.
 	 */
 	__le64 num_bytes;
 
@@ -862,19 +880,19 @@ struct btrfs_csum_item {
 } __attribute__ ((__packed__));
 
 enum btrfs_dev_stat_values {
-	/* disk I/O failure stats */
+	/* Disk I/O failure stats */
 	BTRFS_DEV_STAT_WRITE_ERRS, /* EIO or EREMOTEIO from lower layers */
 	BTRFS_DEV_STAT_READ_ERRS, /* EIO or EREMOTEIO from lower layers */
 	BTRFS_DEV_STAT_FLUSH_ERRS, /* EIO or EREMOTEIO from lower layers */
 
-	/* stats for indirect indications for I/O failures */
-	BTRFS_DEV_STAT_CORRUPTION_ERRS, /* checksum error, bytenr error or
+	/* Stats for indirect indications for I/O failures */
+	BTRFS_DEV_STAT_CORRUPTION_ERRS, /* Checksum error, bytenr error or
 					 * contents is illegal: this is an
 					 * indication that the block was damaged
 					 * during read or write, or written to
 					 * wrong location or read from wrong
 					 * location */
-	BTRFS_DEV_STAT_GENERATION_ERRS, /* an indication that blocks have not
+	BTRFS_DEV_STAT_GENERATION_ERRS, /* An indication that blocks have not
 					 * been written */
 
 	BTRFS_DEV_STAT_VALUES_MAX
@@ -882,8 +900,8 @@ enum btrfs_dev_stat_values {
 
 struct btrfs_dev_stats_item {
 	/*
-	 * grow this item struct at the end for future enhancements and keep
-	 * the existing values unchanged
+	 * Grow this item struct at the end for future enhancements and keep
+	 * the existing values unchanged.
 	 */
 	__le64 values[BTRFS_DEV_STAT_VALUES_MAX];
 } __attribute__ ((__packed__));
@@ -893,8 +911,8 @@ struct btrfs_dev_stats_item {
 
 struct btrfs_dev_replace_item {
 	/*
-	 * grow this item struct at the end for future enhancements and keep
-	 * the existing values unchanged
+	 * Grow this item struct at the end for future enhancements and keep
+	 * the existing values unchanged.
 	 */
 	__le64 src_devid;
 	__le64 cursor_left;
@@ -908,7 +926,7 @@ struct btrfs_dev_replace_item {
 	__le64 num_uncorrectable_read_errors;
 } __attribute__ ((__packed__));
 
-/* different types of block groups (and chunks) */
+/* Different types of block groups (and chunks) */
 #define BTRFS_BLOCK_GROUP_DATA		(1ULL << 0)
 #define BTRFS_BLOCK_GROUP_SYSTEM	(1ULL << 1)
 #define BTRFS_BLOCK_GROUP_METADATA	(1ULL << 2)
@@ -1004,20 +1022,16 @@ static inline __u64 btrfs_qgroup_level(__u64 qgroupid)
 	return qgroupid >> BTRFS_QGROUP_LEVEL_SHIFT;
 }
 
-/*
- * is subvolume quota turned on?
- */
+/* Is subvolume quota turned on? */
 #define BTRFS_QGROUP_STATUS_FLAG_ON		(1ULL << 0)
-/*
- * RESCAN is set during the initialization phase
- */
+
+/* Is qgroup rescan running? */
 #define BTRFS_QGROUP_STATUS_FLAG_RESCAN		(1ULL << 1)
+
 /*
- * Some qgroup entries are known to be out of date,
- * either because the configuration has changed in a way that
- * makes a rescan necessary, or because the fs has been mounted
- * with a non-qgroup-aware version.
- * Turning qouta off and on again makes it inconsistent, too.
+ * Some qgroup entries are known to be out of date, either because the
+ * configuration has changed in a way that makes a rescan necessary, or
+ * because the fs has been mounted with a non-qgroup-aware version.
  */
 #define BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT	(1ULL << 2)
 
@@ -1026,19 +1040,19 @@ static inline __u64 btrfs_qgroup_level(__u64 qgroupid)
 struct btrfs_qgroup_status_item {
 	__le64 version;
 	/*
-	 * the generation is updated during every commit. As older
+	 * The generation is updated during every commit. As older
 	 * versions of btrfs are not aware of qgroups, it will be
 	 * possible to detect inconsistencies by checking the
-	 * generation on mount time
+	 * generation on mount time.
 	 */
 	__le64 generation;
 
-	/* flag definitions see above */
+	/* Flag definitions see above */
 	__le64 flags;
 
 	/*
-	 * only used during scanning to record the progress
-	 * of the scan. It contains a logical address
+	 * Only used during scanning to record the progress of the scan.
+	 * It contains a logical address.
 	 */
 	__le64 rescan;
 } __attribute__ ((__packed__));
@@ -1052,7 +1066,7 @@ struct btrfs_qgroup_info_item {
 } __attribute__ ((__packed__));
 
 /*
- * flags definition for qgroup limits
+ * Flags definition for qgroup limits
  *
  * Used by:
  * struct btrfs_qgroup_limit.flags
@@ -1066,9 +1080,7 @@ struct btrfs_qgroup_info_item {
 #define BTRFS_QGROUP_LIMIT_EXCL_CMPR	(1ULL << 5)
 
 struct btrfs_qgroup_limit_item {
-	/*
-	 * only updated when any of the other values change
-	 */
+	/* Only updated when any of the other values change. */
 	__le64 flags;
 	__le64 max_rfer;
 	__le64 max_excl;
@@ -1077,9 +1089,8 @@ struct btrfs_qgroup_limit_item {
 } __attribute__ ((__packed__));
 
 /*
- * just in case we somehow lose the roots and are not able to mount,
- * we store an array of the roots from previous transactions
- * in the super.
+ * Just in case we somehow lose the roots and are not able to mount,
+ * we store an array of the roots from previous transactions in the super.
  */
 #define BTRFS_NUM_BACKUP_ROOTS 4
 struct btrfs_root_backup {
@@ -1118,32 +1129,30 @@ struct btrfs_root_backup {
 } __attribute__ ((__packed__));
 
 /*
- * this is a very generous portion of the super block, giving us
- * room to translate 14 chunks with 3 stripes each.
+ * This is a very generous portion of the super block, giving us room to
+ * translate 14 chunks with 3 stripes each.
  */
 #define BTRFS_SYSTEM_CHUNK_ARRAY_SIZE 2048
 
 #define BTRFS_LABEL_SIZE 256
-/*
- * the super block basically lists the main trees of the FS
- * it currently lacks any block count etc etc
- */
+
+/* The super block basically lists the main trees of the FS. */
 struct btrfs_super_block {
-	/* the first 4 fields must match struct btrfs_header */
+	/* The first 4 fields must match struct btrfs_header */
 	u8 csum[BTRFS_CSUM_SIZE];
 	/* FS specific UUID, visible to user */
 	u8 fsid[BTRFS_FSID_SIZE];
 	__le64 bytenr; /* this block number */
 	__le64 flags;
 
-	/* allowed to be different from the btrfs_header from here own down */
+	/* Allowed to be different from the btrfs_header from here own down. */
 	__le64 magic;
 	__le64 generation;
 	__le64 root;
 	__le64 chunk_root;
 	__le64 log_root;
 
-	/* this will help find the new super based on the log root */
+	/* This will help find the new super based on the log root. */
 	__le64 log_root_transid;
 	__le64 total_bytes;
 	__le64 bytes_used;
@@ -1169,17 +1178,17 @@ struct btrfs_super_block {
 	__le64 cache_generation;
 	__le64 uuid_tree_generation;
 
-	/* the UUID written into btree blocks */
+	/* The UUID written into btree blocks */
 	u8 metadata_uuid[BTRFS_FSID_SIZE];
 
-	/* future expansion */
+	/* Future expansion */
 	__le64 reserved[28];
 	u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
 	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
 } __attribute__ ((__packed__));
 
 /*
- * feature flags
+ * Feature flags
  *
  * Used by:
  * struct btrfs_super_block::(compat|compat_ro|incompat)_flags
@@ -1205,7 +1214,7 @@ struct btrfs_super_block {
 #define BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD	(1ULL << 4)
 
 /*
- * older kernels tried to do bigger metadata blocks, but the
+ * Older kernels tried to do bigger metadata blocks, but the
  * code was pretty buggy.  Lets not let them try anymore.
  */
 #define BTRFS_FEATURE_INCOMPAT_BIG_METADATA	(1ULL << 5)
@@ -1218,8 +1227,10 @@ struct btrfs_super_block {
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 
 /*
- * Compat flags that we support.  If any incompat flags are set other than the
- * ones specified below then we will fail to mount
+ * Compat flags that we support.
+ *
+ * If any incompat flags are set other than the ones specified below then we
+ * will fail to mount.
  */
 #define BTRFS_FEATURE_COMPAT_SUPP		0ULL
 #define BTRFS_FEATURE_COMPAT_SAFE_SET		0ULL
@@ -1260,17 +1271,15 @@ struct btrfs_super_block {
 
 #define BTRFS_MAX_LEVEL 8
 
-/*
- * every tree block (leaf or node) starts with this header.
- */
+/* Every tree block (leaf or node) starts with this header. */
 struct btrfs_header {
-	/* these first four must match the super block */
+	/* These first four must match the super block */
 	u8 csum[BTRFS_CSUM_SIZE];
 	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
-	__le64 bytenr; /* which block this node is supposed to live in */
+	__le64 bytenr; /* Which block this node is supposed to live in */
 	__le64 flags;
 
-	/* allowed to be different from the super from here on down */
+	/* Allowed to be different from the super from here on down. */
 	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
 	__le64 generation;
 	__le64 owner;
@@ -1279,8 +1288,8 @@ struct btrfs_header {
 } __attribute__ ((__packed__));
 
 /*
- * A leaf is full of items. offset and size tell us where to find
- * the item in the leaf (relative to the start of the data area)
+ * A leaf is full of items. Offset and size tell us where to find
+ * the item in the leaf (relative to the start of the data area).
  */
 struct btrfs_item {
 	struct btrfs_disk_key key;
@@ -1301,8 +1310,8 @@ struct btrfs_leaf {
 } __attribute__ ((__packed__));
 
 /*
- * all non-leaf blocks are nodes, they hold only keys and pointers to
- * other blocks
+ * All non-leaf blocks are nodes, they hold only keys and pointers to children
+ * blocks.
  */
 struct btrfs_key_ptr {
 	struct btrfs_disk_key key;
@@ -1315,4 +1324,4 @@ struct btrfs_node {
 	struct btrfs_key_ptr ptrs[];
 } __attribute__ ((__packed__));
 
-#endif /* _BTRFS_CTREE_H_ */
+#endif /* __BTRFS_TREE_H__ */
-- 
2.26.0

