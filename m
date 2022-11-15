Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D22629D90
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 16:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiKOPc2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 10:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238374AbiKOPb7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 10:31:59 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CC41274A
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:53 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id h21so8919253qtu.2
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDD/foEajlqt1rNL2RZ1lrzwh1zHViY2M1YNHzT8LnA=;
        b=D4mowdkjcmZ++sTXGoLBVgrFWdNj9iRZhzYJYuc4sOtLbH/KmqgwoWe3akteUiD/0V
         ZkWb/9uxHFGPcEW36wWkqEi2M0nX8y0T7ScDnSECizDkS4U5cKPLZp9jPMp1O0J9DyYD
         dR4oc1swidf3EwIAetnldJ1DJvoDD3m6KKcLlB2lK3kEgDVJwuFLnwNQnIhoWjS1mLcG
         EFq/bSH/R3w5z7ZFck/EmfkdQ1802Oye8rCgj+scYNYW3XY4ykmhiCwBp4XDxFI23LOD
         4wTstw/EQunPrZnIKD01sXAzT3Fv7DsmfpHyLfYQd5KlUm8uHX4NNoLmL1E9j0ryOC4G
         vNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDD/foEajlqt1rNL2RZ1lrzwh1zHViY2M1YNHzT8LnA=;
        b=7YNtToJdTL6QEA9RjPM+Af/Ik5Kscx4bPSNmXMG980UUir2mAZez7cl3ZiJs9Ebof8
         52tZIFyIGlVbvjBC99UvuZRd5vbRr3qKk1FFT5WjcB+pwosTH7kh6zMJV3iYWHseNjec
         +MjK9w7pbgnADtLNJKP4OUrPixjn3ECsGDOidjJDl9KujFUUhCgP1EbwjLGBDXM1RFRJ
         SQRaeGboMCI3qMBEDQNFP5A6lJDQMhlSlSiE8L5IFeFO/Xlv1+mEH3brpDMJpm6LGHVC
         kEFFR2WXbvRJyEjiJA/TLGTAmrapLh6r7wZ5671Lb2kQeidJo8AyVkBofEkRtGDSQKdQ
         I10A==
X-Gm-Message-State: ANoB5pkabtkUzqeuMkrHIlTK0ykAsiVC55ixc/CNOeDFTw+pOUS4QRP5
        +vyf+Gn+kGdxCINcnou0p4NAY+O1rw1qCg==
X-Google-Smtp-Source: AA0mqf5+i6Fl2zpZwLwi6fI8kWl7qaH059l/IDwrr034DqHw/24hwxrp0sMTfVOA4+iy1IxuTtl1lA==
X-Received: by 2002:a05:622a:1a88:b0:3a4:ef5c:c69d with SMTP id s8-20020a05622a1a8800b003a4ef5cc69dmr16883522qtc.194.1668526311480;
        Tue, 15 Nov 2022 07:31:51 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006ec62032d3dsm8527672qkp.30.2022.11.15.07.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:31:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 12/18] btrfs-progs: sync ondisk definitions from the kernel
Date:   Tue, 15 Nov 2022 10:31:21 -0500
Message-Id: <1fd2927a95de406395e5fdfeddfbfd7572351acf.1668526161.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668526161.git.josef@toxicpanda.com>
References: <cover.1668526161.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This pulls in the kernel's btrfs_tree.h, which now has all of the ondisk
definitions.  Include this into ctree.h, and then yank out all the
duplicate code from ctree.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h           |  950 +----------------------
 kernel-shared/uapi/btrfs_tree.h | 1259 +++++++++++++++++++++++++++++++
 2 files changed, 1260 insertions(+), 949 deletions(-)
 create mode 100644 kernel-shared/uapi/btrfs_tree.h

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 3f674484..fe0d2c9b 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -26,11 +26,11 @@
 #include "common/extent-cache.h"
 #include "kernel-shared/extent_io.h"
 #include "kernel-shared/uapi/btrfs.h"
+#include "kernel-shared/uapi/btrfs_tree.h"
 
 struct btrfs_root;
 struct btrfs_trans_handle;
 struct btrfs_free_space_ctl;
-#define BTRFS_MAGIC 0x4D5F53665248425FULL /* ascii _BHRfS_M, no null */
 
 /*
  * Fake signature for an unfinalized filesystem, which only has barebone tree
@@ -42,272 +42,10 @@ struct btrfs_free_space_ctl;
 
 #define BTRFS_MAX_MIRRORS 3
 
-#define BTRFS_MAX_LEVEL 8
-
-/* holds pointers to all of the tree roots */
-#define BTRFS_ROOT_TREE_OBJECTID 1ULL
-
-/* stores information about which extents are in use, and reference counts */
-#define BTRFS_EXTENT_TREE_OBJECTID 2ULL
-
-/*
- * chunk tree stores translations from logical -> physical block numbering
- * the super block points to the chunk tree
- */
-#define BTRFS_CHUNK_TREE_OBJECTID 3ULL
-
-/*
- * stores information about which areas of a given device are in use.
- * one per device.  The tree of tree roots points to the device tree
- */
-#define BTRFS_DEV_TREE_OBJECTID 4ULL
-
-/* one per subvolume, storing files and directories */
-#define BTRFS_FS_TREE_OBJECTID 5ULL
-
-/* directory objectid inside the root tree */
-#define BTRFS_ROOT_TREE_DIR_OBJECTID 6ULL
-/* holds checksums of all the data extents */
-#define BTRFS_CSUM_TREE_OBJECTID 7ULL
-#define BTRFS_QUOTA_TREE_OBJECTID 8ULL
-
-/* for storing items that use the BTRFS_UUID_KEY* */
-#define BTRFS_UUID_TREE_OBJECTID 9ULL
-
-/* tracks free space in block groups. */
-#define BTRFS_FREE_SPACE_TREE_OBJECTID 10ULL
-
-/* hold the block group items. */
-#define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
-
-/* device stats in the device tree */
-#define BTRFS_DEV_STATS_OBJECTID 0ULL
-
-/* for storing balance parameters in the root tree */
-#define BTRFS_BALANCE_OBJECTID -4ULL
-
-/* orphan objectid for tracking unlinked/truncated files */
-#define BTRFS_ORPHAN_OBJECTID -5ULL
-
-/* does write ahead logging to speed up fsyncs */
-#define BTRFS_TREE_LOG_OBJECTID -6ULL
-#define BTRFS_TREE_LOG_FIXUP_OBJECTID -7ULL
-
-/* space balancing */
-#define BTRFS_TREE_RELOC_OBJECTID -8ULL
-#define BTRFS_DATA_RELOC_TREE_OBJECTID -9ULL
-
-/*
- * extent checksums all have this objectid
- * this allows them to share the logging tree
- * for fsyncs
- */
-#define BTRFS_EXTENT_CSUM_OBJECTID -10ULL
-
-/* For storing free space cache */
-#define BTRFS_FREE_SPACE_OBJECTID -11ULL
-
-/*
- * The inode number assigned to the special inode for storing
- * free ino cache
- */
-#define BTRFS_FREE_INO_OBJECTID -12ULL
-
-/* dummy objectid represents multiple objectids */
-#define BTRFS_MULTIPLE_OBJECTIDS -255ULL
-
-/*
- * All files have objectids in this range.
- */
-#define BTRFS_FIRST_FREE_OBJECTID 256ULL
-#define BTRFS_LAST_FREE_OBJECTID -256ULL
-#define BTRFS_FIRST_CHUNK_TREE_OBJECTID 256ULL
-
-
-
-/*
- * the device items go into the chunk tree.  The key is in the form
- * [ 1 BTRFS_DEV_ITEM_KEY device_id ]
- */
-#define BTRFS_DEV_ITEMS_OBJECTID 1ULL
-
-#define BTRFS_EMPTY_SUBVOL_DIR_OBJECTID 2ULL
-
-/*
- * the max metadata block size.  This limit is somewhat artificial,
- * but the memmove costs go through the roof for larger blocks.
- */
-#define BTRFS_MAX_METADATA_BLOCKSIZE 65536
-
-/*
- * we can actually store much bigger names, but lets not confuse the rest
- * of linux
- */
-#define BTRFS_NAME_LEN 255
-
-/*
- * Theoretical limit is larger, but we keep this down to a sane
- * value. That should limit greatly the possibility of collisions on
- * inode ref items.
- */
-#define	BTRFS_LINK_MAX	65535U
-
-/* 32 bytes in various csum fields */
-#define BTRFS_CSUM_SIZE 32
-
-/* csum types */
-enum btrfs_csum_type {
-	BTRFS_CSUM_TYPE_CRC32		= 0,
-	BTRFS_CSUM_TYPE_XXHASH		= 1,
-	BTRFS_CSUM_TYPE_SHA256		= 2,
-	BTRFS_CSUM_TYPE_BLAKE2		= 3,
-};
-
-#define BTRFS_EMPTY_DIR_SIZE 0
-
-#define BTRFS_FT_UNKNOWN	0
-#define BTRFS_FT_REG_FILE	1
-#define BTRFS_FT_DIR		2
-#define BTRFS_FT_CHRDEV		3
-#define BTRFS_FT_BLKDEV		4
-#define BTRFS_FT_FIFO		5
-#define BTRFS_FT_SOCK		6
-#define BTRFS_FT_SYMLINK	7
-#define BTRFS_FT_XATTR		8
-#define BTRFS_FT_MAX		9
-
-#define BTRFS_ROOT_SUBVOL_RDONLY	(1ULL << 0)
-
-/*
- * the key defines the order in the tree, and so it also defines (optimal)
- * block layout.  objectid corresponds to the inode number.  The flags
- * tells us things about the object, and is a kind of stream selector.
- * so for a given inode, keys with flags of 1 might refer to the inode
- * data, flags of 2 may point to file data in the btree and flags == 3
- * may point to extents.
- *
- * offset is the starting byte offset for this key in the stream.
- *
- * btrfs_disk_key is in disk byte order.  struct btrfs_key is always
- * in cpu native order.  Otherwise they are identical and their sizes
- * should be the same (ie both packed)
- */
-struct btrfs_disk_key {
-	__le64 objectid;
-	u8 type;
-	__le64 offset;
-} __attribute__ ((__packed__));
-
-struct btrfs_key {
-	u64 objectid;
-	u8 type;
-	u64 offset;
-} __attribute__ ((__packed__));
-
 struct btrfs_mapping_tree {
 	struct cache_tree cache_tree;
 };
 
-#define BTRFS_UUID_SIZE 16
-struct btrfs_dev_item {
-	/* the internal btrfs device id */
-	__le64 devid;
-
-	/* size of the device */
-	__le64 total_bytes;
-
-	/* bytes used */
-	__le64 bytes_used;
-
-	/* optimal io alignment for this device */
-	__le32 io_align;
-
-	/* optimal io width for this device */
-	__le32 io_width;
-
-	/* minimal io size for this device */
-	__le32 sector_size;
-
-	/* type and info about this device */
-	__le64 type;
-
-	/* expected generation for this device */
-	__le64 generation;
-
-	/*
-	 * starting byte of this partition on the device,
-	 * to allow for stripe alignment in the future
-	 */
-	__le64 start_offset;
-
-	/* grouping information for allocation decisions */
-	__le32 dev_group;
-
-	/* seek speed 0-100 where 100 is fastest */
-	u8 seek_speed;
-
-	/* bandwidth 0-100 where 100 is fastest */
-	u8 bandwidth;
-
-	/* btrfs generated uuid for this device */
-	u8 uuid[BTRFS_UUID_SIZE];
-
-	/* uuid of FS who owns this device */
-	u8 fsid[BTRFS_UUID_SIZE];
-} __attribute__ ((__packed__));
-
-struct btrfs_stripe {
-	__le64 devid;
-	__le64 offset;
-	u8 dev_uuid[BTRFS_UUID_SIZE];
-} __attribute__ ((__packed__));
-
-struct btrfs_chunk {
-	/* size of this chunk in bytes */
-	__le64 length;
-
-	/* objectid of the root referencing this chunk */
-	__le64 owner;
-
-	__le64 stripe_len;
-	__le64 type;
-
-	/* optimal io alignment for this chunk */
-	__le32 io_align;
-
-	/* optimal io width for this chunk */
-	__le32 io_width;
-
-	/* minimal io size for this chunk */
-	__le32 sector_size;
-
-	/* 2^16 stripes is quite a lot, a second limit is the size of a single
-	 * item in the btree
-	 */
-	__le16 num_stripes;
-
-	/* sub stripes only matter for raid10 */
-	__le16 sub_stripes;
-	struct btrfs_stripe stripe;
-	/* additional stripes go here */
-} __attribute__ ((__packed__));
-
-#define BTRFS_FREE_SPACE_EXTENT	1
-#define BTRFS_FREE_SPACE_BITMAP	2
-
-struct btrfs_free_space_entry {
-	__le64 offset;
-	__le64 bytes;
-	u8 type;
-} __attribute__ ((__packed__));
-
-struct btrfs_free_space_header {
-	struct btrfs_disk_key location;
-	__le64 generation;
-	__le64 num_entries;
-	__le64 num_bitmaps;
-} __attribute__ ((__packed__));
-
 static inline unsigned long btrfs_chunk_item_size(int num_stripes)
 {
 	BUG_ON(num_stripes == 0);
@@ -315,13 +53,6 @@ static inline unsigned long btrfs_chunk_item_size(int num_stripes)
 		sizeof(struct btrfs_stripe) * (num_stripes - 1);
 }
 
-#define BTRFS_HEADER_FLAG_WRITTEN		(1ULL << 0)
-#define BTRFS_HEADER_FLAG_RELOC			(1ULL << 1)
-#define BTRFS_SUPER_FLAG_SEEDING		(1ULL << 32)
-#define BTRFS_SUPER_FLAG_METADUMP		(1ULL << 33)
-#define BTRFS_SUPER_FLAG_METADUMP_V2		(1ULL << 34)
-#define BTRFS_SUPER_FLAG_CHANGING_FSID		(1ULL << 35)
-#define BTRFS_SUPER_FLAG_CHANGING_FSID_V2	(1ULL << 36)
 #define BTRFS_SUPER_FLAG_CHANGING_CSUM		(1ULL << 37)
 
 /*
@@ -331,32 +62,6 @@ static inline unsigned long btrfs_chunk_item_size(int num_stripes)
  */
 #define BTRFS_SUPER_FLAG_CHANGING_BG_TREE	(1ULL << 38)
 
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
 static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
 {
 	return nodesize - sizeof(struct btrfs_header);
@@ -364,160 +69,9 @@ static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
 
 #define BTRFS_LEAF_DATA_SIZE(fs_info) (fs_info->leaf_data_size)
 
-/*
- * this is a very generous portion of the super block, giving us
- * room to translate 14 chunks with 3 stripes each.
- */
-#define BTRFS_SYSTEM_CHUNK_ARRAY_SIZE 2048
-#define BTRFS_LABEL_SIZE 256
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
-	__le64 unsed_64[4];
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
 #define BTRFS_SUPER_INFO_OFFSET			(65536)
 #define BTRFS_SUPER_INFO_SIZE			(4096)
 
-/*
- * the super block basically lists the main trees of the FS
- * it currently lacks any block count etc etc
- */
-struct btrfs_super_block {
-	u8 csum[BTRFS_CSUM_SIZE];
-	/* the first 3 fields must match struct btrfs_header */
-	u8 fsid[BTRFS_FSID_SIZE];    /* FS specific uuid */
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
-	/*
-	 * This has never been used and is 0 in all versions.  We always use
-	 * generation + 1 to read log tree root.
-	 */
-	__le64 __unused_log_root_transid;
-	__le64 total_bytes;
-	__le64 bytes_used;
-	__le64 root_dir_objectid;
-	__le64 num_devices;
-	__le32 sectorsize;
-	__le32 nodesize;
-	/* Unused and must be equal to nodesize */
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
-	u8 metadata_uuid[BTRFS_FSID_SIZE];
-
-	__le64 nr_global_roots;
-
-	__le64 reserved[27];
-	u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
-	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
-	/* Padded to 4096 bytes */
-	u8 padding[565];
-} __attribute__ ((__packed__));
-BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
-
-/*
- * Compat flags that we support.  If any incompat flags are set other than the
- * ones specified below then we will fail to mount
- */
-#define BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE	(1ULL << 0)
-/*
- * Older kernels on big-endian systems produced broken free space tree bitmaps,
- * and btrfs-progs also used to corrupt the free space tree. If this bit is
- * clear, then the free space tree cannot be trusted. btrfs-progs can also
- * intentionally clear this bit to ask the kernel to rebuild the free space
- * tree.
- */
-#define BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID	(1ULL << 1)
-#define BTRFS_FEATURE_COMPAT_RO_VERITY			(1ULL << 2)
-
-/*
- * Save all block group items into a dedicated block group tree, to greatly
- * reduce mount time for large fs.
- */
-#define BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE	(1ULL << 3)
-
-#define BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF	(1ULL << 0)
-#define BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL	(1ULL << 1)
-#define BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS	(1ULL << 2)
-#define BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO	(1ULL << 3)
-#define BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD	(1ULL << 4)
-
-/*
- * older kernels tried to do bigger metadata blocks, but the
- * code was pretty buggy.  Lets not let them try anymore.
- */
-#define BTRFS_FEATURE_INCOMPAT_BIG_METADATA     (1ULL << 5)
-#define BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF	(1ULL << 6)
-#define BTRFS_FEATURE_INCOMPAT_RAID56		(1ULL << 7)
-#define BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA	(1ULL << 8)
-#define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
-#define BTRFS_FEATURE_INCOMPAT_METADATA_UUID    (1ULL << 10)
-#define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
-#define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
-#define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
-
-#define BTRFS_FEATURE_COMPAT_SUPP		0ULL
-
 /*
  * The FREE_SPACE_TREE and FREE_SPACE_TREE_VALID compat_ro bits must not be
  * added here until read-write support for the free space tree is implemented in
@@ -562,43 +116,6 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 	 BTRFS_FEATURE_INCOMPAT_ZONED)
 #endif
 
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
@@ -627,92 +144,11 @@ struct btrfs_path {
 	u8 skip_check_block;
 };
 
-/*
- * items in the extent btree are used to record the objectid of the
- * owner of the block and the number of references
- */
-
-struct btrfs_extent_item {
-	__le64 refs;
-	__le64 generation;
-	__le64 flags;
-} __attribute__ ((__packed__));
-
-struct btrfs_extent_item_v0 {
-	__le32 refs;
-} __attribute__ ((__packed__));
-
 #define BTRFS_MAX_EXTENT_ITEM_SIZE(r) \
 			((BTRFS_LEAF_DATA_SIZE(r->fs_info) >> 4) - \
 					sizeof(struct btrfs_item))
 #define BTRFS_MAX_EXTENT_SIZE		128UL * 1024 * 1024
 
-#define BTRFS_EXTENT_FLAG_DATA		(1ULL << 0)
-#define BTRFS_EXTENT_FLAG_TREE_BLOCK	(1ULL << 1)
-
-/* following flags only apply to tree blocks */
-
-/* use full backrefs for extent pointers in the block*/
-#define BTRFS_BLOCK_FLAG_FULL_BACKREF	(1ULL << 8)
-
-struct btrfs_tree_block_info {
-	struct btrfs_disk_key key;
-	u8 level;
-} __attribute__ ((__packed__));
-
-struct btrfs_extent_data_ref {
-	__le64 root;
-	__le64 objectid;
-	__le64 offset;
-	__le32 count;
-} __attribute__ ((__packed__));
-
-struct btrfs_shared_data_ref {
-	__le32 count;
-} __attribute__ ((__packed__));
-
-struct btrfs_extent_inline_ref {
-	u8 type;
-	__le64 offset;
-} __attribute__ ((__packed__));
-
-struct btrfs_extent_ref_v0 {
-	__le64 root;
-	__le64 generation;
-	__le64 objectid;
-	__le32 count;
-} __attribute__ ((__packed__));
-
-/* dev extents record free space on individual devices.  The owner
- * field points back to the chunk allocation mapping tree that allocated
- * the extent.  The chunk tree uuid field is a way to double check the owner
- */
-struct btrfs_dev_extent {
-	__le64 chunk_tree;
-	__le64 chunk_objectid;
-	__le64 chunk_offset;
-	__le64 length;
-	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
-} __attribute__ ((__packed__));
-
-struct btrfs_inode_ref {
-	__le64 index;
-	__le16 name_len;
-	/* name goes here */
-} __attribute__ ((__packed__));
-
-struct btrfs_inode_extref {
-	__le64 parent_objectid;
-	__le64 index;
-	__le16 name_len;
-	__u8   name[0]; /* name goes here */
-} __attribute__ ((__packed__));
-
-struct btrfs_timespec {
-	__le64 sec;
-	__le32 nsec;
-} __attribute__ ((__packed__));
-
 typedef enum {
 	BTRFS_COMPRESS_NONE  = 0,
 	BTRFS_COMPRESS_ZLIB  = 1,
@@ -722,12 +158,6 @@ typedef enum {
 	BTRFS_COMPRESS_LAST  = 4,
 } btrfs_compression_type;
 
-/* we don't understand any encryption methods right now */
-typedef enum {
-	BTRFS_ENCRYPTION_NONE = 0,
-	BTRFS_ENCRYPTION_LAST = 1,
-} btrfs_encryption_type;
-
 enum btrfs_tree_block_status {
 	BTRFS_TREE_BLOCK_CLEAN,
 	BTRFS_TREE_BLOCK_INVALID_NRITEMS,
@@ -739,269 +169,6 @@ enum btrfs_tree_block_status {
 	BTRFS_TREE_BLOCK_INVALID_BLOCKPTR,
 };
 
-struct btrfs_inode_item {
-	/* nfs style generation number */
-	__le64 generation;
-	/* transid that last touched this inode */
-	__le64 transid;
-	__le64 size;
-	__le64 nbytes;
-	__le64 block_group;
-	__le32 nlink;
-	__le32 uid;
-	__le32 gid;
-	__le32 mode;
-	__le64 rdev;
-	__le64 flags;
-
-	/* modification sequence number for NFS */
-	__le64 sequence;
-
-	/*
-	 * a little future expansion, for more than this we can
-	 * just grow the inode item and version it
-	 */
-	__le64 reserved[4];
-	struct btrfs_timespec atime;
-	struct btrfs_timespec ctime;
-	struct btrfs_timespec mtime;
-	struct btrfs_timespec otime;
-} __attribute__ ((__packed__));
-
-struct btrfs_dir_log_item {
-	__le64 end;
-} __attribute__ ((__packed__));
-
-struct btrfs_dir_item {
-	struct btrfs_disk_key location;
-	__le64 transid;
-	__le16 data_len;
-	__le16 name_len;
-	u8 type;
-} __attribute__ ((__packed__));
-
-struct btrfs_root_item_v0 {
-	struct btrfs_inode_item inode;
-	__le64 generation;
-	__le64 root_dirid;
-	__le64 bytenr;
-	__le64 byte_limit;
-	__le64 bytes_used;
-	__le64 last_snapshot;
-	__le64 flags;
-	__le32 refs;
-	struct btrfs_disk_key drop_progress;
-	u8 drop_level;
-	u8 level;
-} __attribute__ ((__packed__));
-
-struct btrfs_root_item {
-	struct btrfs_inode_item inode;
-	__le64 generation;
-	__le64 root_dirid;
-	__le64 bytenr;
-	__le64 byte_limit;
-	__le64 bytes_used;
-	__le64 last_snapshot;
-	__le64 flags;
-	__le32 refs;
-	struct btrfs_disk_key drop_progress;
-	u8 drop_level;
-	u8 level;
-
-	/*
-	 * The following fields appear after subvol_uuids+subvol_times
-	 * were introduced.
-	 */
-
-	/*
-	 * This generation number is used to test if the new fields are valid
-	 * and up to date while reading the root item. Every time the root item
-	 * is written out, the "generation" field is copied into this field. If
-	 * anyone ever mounted the fs with an older kernel, we will have
-	 * mismatching generation values here and thus must invalidate the
-	 * new fields. See btrfs_update_root and btrfs_find_last_root for
-	 * details.
-	 * the offset of generation_v2 is also used as the start for the memset
-	 * when invalidating the fields.
-	 */
-	__le64 generation_v2;
-	u8 uuid[BTRFS_UUID_SIZE];
-	u8 parent_uuid[BTRFS_UUID_SIZE];
-	u8 received_uuid[BTRFS_UUID_SIZE];
-	__le64 ctransid; /* updated when an inode changes */
-	__le64 otransid; /* trans when created */
-	__le64 stransid; /* trans when sent. non-zero for received subvol */
-	__le64 rtransid; /* trans when received. non-zero for received subvol */
-	struct btrfs_timespec ctime;
-	struct btrfs_timespec otime;
-	struct btrfs_timespec stime;
-	struct btrfs_timespec rtime;
-
-	/*
-	 * If we want to use a specific set of fst/checksum/extent roots for
-	 * this root.
-	 */
-	__le64 global_tree_id;
-        __le64 reserved[7]; /* for future */
-} __attribute__ ((__packed__));
-
-/*
- * this is used for both forward and backward root refs
- */
-struct btrfs_root_ref {
-	__le64 dirid;
-	__le64 sequence;
-	__le16 name_len;
-} __attribute__ ((__packed__));
-
-struct btrfs_disk_balance_args {
-	/*
-	 * profiles to operate on, single is denoted by
-	 * BTRFS_AVAIL_ALLOC_BIT_SINGLE
-	 */
-	__le64 profiles;
-
-	/*
-	 * usage filter
-	 * BTRFS_BALANCE_ARGS_USAGE with a single value means '0..N'
-	 * BTRFS_BALANCE_ARGS_USAGE_RANGE - range syntax, min..max
-	 */
-	union {
-		__le64 usage;
-		struct {
-			__le32 usage_min;
-			__le32 usage_max;
-		};
-	};
-
-	/* devid filter */
-	__le64 devid;
-
-	/* devid subset filter [pstart..pend) */
-	__le64 pstart;
-	__le64 pend;
-
-	/* btrfs virtual address space subset filter [vstart..vend) */
-	__le64 vstart;
-	__le64 vend;
-
-	/*
-	 * profile to convert to, single is denoted by
-	 * BTRFS_AVAIL_ALLOC_BIT_SINGLE
-	 */
-	__le64 target;
-
-	/* BTRFS_BALANCE_ARGS_* */
-	__le64 flags;
-
-	/*
-	 * BTRFS_BALANCE_ARGS_LIMIT with value 'limit'
-	 * BTRFS_BALANCE_ARGS_LIMIT_RANGE - the extend version can use minimum
-	 * and maximum
-	 */
-	union {
-		__le64 limit;
-		struct {
-			__le32 limit_min;
-			__le32 limit_max;
-		};
-	};
-
-	/*
-	 * Process chunks that cross stripes_min..stripes_max devices,
-	 * BTRFS_BALANCE_ARGS_STRIPES_RANGE
-	 */
-	__le32 stripes_min;
-	__le32 stripes_max;
-
-	__le64 unused[6];
-} __attribute__ ((__packed__));
-
-/*
- * store balance parameters to disk so that balance can be properly
- * resumed after crash or unmount
- */
-struct btrfs_balance_item {
-	/* BTRFS_BALANCE_* */
-	__le64 flags;
-
-	struct btrfs_disk_balance_args data;
-	struct btrfs_disk_balance_args meta;
-	struct btrfs_disk_balance_args sys;
-
-	__le64 unused[4];
-} __attribute__ ((__packed__));
-
-#define BTRFS_FILE_EXTENT_INLINE 0
-#define BTRFS_FILE_EXTENT_REG 1
-#define BTRFS_FILE_EXTENT_PREALLOC 2
-
-struct btrfs_file_extent_item {
-	/*
-	 * transaction id that created this extent
-	 */
-	__le64 generation;
-	/*
-	 * max number of bytes to hold this extent in ram
-	 * when we split a compressed extent we can't know how big
-	 * each of the resulting pieces will be.  So, this is
-	 * an upper limit on the size of the extent in ram instead of
-	 * an exact limit.
-	 */
-	__le64 ram_bytes;
-
-	/*
-	 * 32 bits for the various ways we might encode the data,
-	 * including compression and encryption.  If any of these
-	 * are set to something a given disk format doesn't understand
-	 * it is treated like an incompat flag for reading and writing,
-	 * but not for stat.
-	 */
-	u8 compression;
-	u8 encryption;
-	__le16 other_encoding; /* spare for later use */
-
-	/* are we inline data or a real extent? */
-	u8 type;
-
-	/*
-	 * Disk space consumed by the data extent
-	 * Data checksum is stored in csum tree, thus no bytenr/length takes
-	 * csum into consideration.
-	 *
-	 * The inline extent data starts at this offset in the structure.
-	 */
-	__le64 disk_bytenr;
-	__le64 disk_num_bytes;
-	/*
-	 * The logical offset in file blocks.
-	 * this extent record is for.  This allows a file extent to point
-	 * into the middle of an existing extent on disk, sharing it
-	 * between two snapshots (useful if some bytes in the middle of the
-	 * extent have changed
-	 */
-	__le64 offset;
-	/*
-	 * The logical number of file blocks. This always reflects the size
-	 * uncompressed and without encoding.
-	 */
-	__le64 num_bytes;
-
-} __attribute__ ((__packed__));
-
-struct btrfs_dev_stats_item {
-        /*
-         * grow this item struct at the end for future enhancements and keep
-         * the existing values unchanged
-         */
-        __le64 values[BTRFS_DEV_STAT_VALUES_MAX];
-} __attribute__ ((__packed__));
-
-struct btrfs_csum_item {
-	u8 csum;
-} __attribute__ ((__packed__));
-
 /*
  * We don't want to overwrite 1M at the beginning of device, even though
  * there is our 1st superblock at 64k. Some possible reasons:
@@ -1010,20 +177,6 @@ struct btrfs_csum_item {
  */
 #define BTRFS_BLOCK_RESERVED_1M_FOR_SUPER	((u64)1 * 1024 * 1024)
 
-#define BTRFS_BLOCK_GROUP_DATA		(1ULL << 0)
-#define BTRFS_BLOCK_GROUP_SYSTEM	(1ULL << 1)
-#define BTRFS_BLOCK_GROUP_METADATA	(1ULL << 2)
-#define BTRFS_BLOCK_GROUP_RAID0		(1ULL << 3)
-#define BTRFS_BLOCK_GROUP_RAID1		(1ULL << 4)
-#define BTRFS_BLOCK_GROUP_DUP		(1ULL << 5)
-#define BTRFS_BLOCK_GROUP_RAID10	(1ULL << 6)
-#define BTRFS_BLOCK_GROUP_RAID5    	(1ULL << 7)
-#define BTRFS_BLOCK_GROUP_RAID6    	(1ULL << 8)
-#define BTRFS_BLOCK_GROUP_RAID1C3    	(1ULL << 9)
-#define BTRFS_BLOCK_GROUP_RAID1C4    	(1ULL << 10)
-#define BTRFS_BLOCK_GROUP_RESERVED	(BTRFS_AVAIL_ALLOC_BIT_SINGLE | \
-					 BTRFS_SPACE_INFO_GLOBAL_RSV)
-
 enum btrfs_raid_types {
 	BTRFS_RAID_RAID10,
 	BTRFS_RAID_RAID1,
@@ -1037,32 +190,6 @@ enum btrfs_raid_types {
 	BTRFS_NR_RAID_TYPES
 };
 
-#define BTRFS_BLOCK_GROUP_TYPE_MASK	(BTRFS_BLOCK_GROUP_DATA |    \
-					 BTRFS_BLOCK_GROUP_SYSTEM |  \
-					 BTRFS_BLOCK_GROUP_METADATA)
-
-#define BTRFS_BLOCK_GROUP_PROFILE_MASK	(BTRFS_BLOCK_GROUP_RAID0 |   \
-					 BTRFS_BLOCK_GROUP_RAID1 |   \
-					 BTRFS_BLOCK_GROUP_RAID5 |   \
-					 BTRFS_BLOCK_GROUP_RAID6 |   \
-					 BTRFS_BLOCK_GROUP_RAID1C3 | \
-					 BTRFS_BLOCK_GROUP_RAID1C4 | \
-					 BTRFS_BLOCK_GROUP_DUP |     \
-					 BTRFS_BLOCK_GROUP_RAID10)
-
-#define BTRFS_BLOCK_GROUP_RAID56_MASK	(BTRFS_BLOCK_GROUP_RAID5 |	\
-                                         BTRFS_BLOCK_GROUP_RAID6)
-
-#define BTRFS_BLOCK_GROUP_RAID1_MASK    (BTRFS_BLOCK_GROUP_RAID1 |	\
-                                         BTRFS_BLOCK_GROUP_RAID1C3 |	\
-                                         BTRFS_BLOCK_GROUP_RAID1C4)
-
-/* used in struct btrfs_balance_args fields */
-#define BTRFS_AVAIL_ALLOC_BIT_SINGLE	(1ULL << 48)
-
-#define BTRFS_EXTENDED_PROFILE_MASK	(BTRFS_BLOCK_GROUP_PROFILE_MASK | \
-					 BTRFS_AVAIL_ALLOC_BIT_SINGLE)
-
 /*
  * GLOBAL_RSV does not exist as a on-disk block group type and is used
  * internally for exporting info about global block reserve from space infos
@@ -1071,65 +198,11 @@ enum btrfs_raid_types {
 
 #define BTRFS_QGROUP_LEVEL_SHIFT		48
 
-static inline __u16 btrfs_qgroup_level(u64 qgroupid)
-{
-	return qgroupid >> BTRFS_QGROUP_LEVEL_SHIFT;
-}
-
 static inline u64 btrfs_qgroup_subvid(u64 qgroupid)
 {
 	return qgroupid & ((1ULL << BTRFS_QGROUP_LEVEL_SHIFT) - 1);
 }
 
-#define BTRFS_QGROUP_STATUS_FLAG_ON		(1ULL << 0)
-#define BTRFS_QGROUP_STATUS_FLAG_RESCAN		(1ULL << 1)
-#define BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT	(1ULL << 2)
-
-struct btrfs_qgroup_status_item {
-	__le64 version;
-	__le64 generation;
-	__le64 flags;
-	__le64 rescan;		/* progress during scanning */
-} __attribute__ ((__packed__));
-
-#define BTRFS_QGROUP_STATUS_VERSION		1
-struct btrfs_block_group_item {
-	__le64 used;
-	__le64 chunk_objectid;
-	__le64 flags;
-} __attribute__ ((__packed__));
-
-struct btrfs_free_space_info {
-	__le32 extent_count;
-	__le32 flags;
-} __attribute__ ((__packed__));
-
-#define BTRFS_FREE_SPACE_USING_BITMAPS (1ULL << 0)
-
-struct btrfs_qgroup_info_item {
-	__le64 generation;
-	__le64 rfer;
-	__le64 rfer_cmpr;
-	__le64 excl;
-	__le64 excl_cmpr;
-} __attribute__ ((__packed__));
-
-/* flags definition for qgroup limits */
-#define BTRFS_QGROUP_LIMIT_MAX_RFER	(1ULL << 0)
-#define BTRFS_QGROUP_LIMIT_MAX_EXCL	(1ULL << 1)
-#define BTRFS_QGROUP_LIMIT_RSV_RFER	(1ULL << 2)
-#define BTRFS_QGROUP_LIMIT_RSV_EXCL	(1ULL << 3)
-#define BTRFS_QGROUP_LIMIT_RFER_CMPR	(1ULL << 4)
-#define BTRFS_QGROUP_LIMIT_EXCL_CMPR	(1ULL << 5)
-
-struct btrfs_qgroup_limit_item {
-	__le64 flags;
-	__le64 max_rfer;
-	__le64 max_excl;
-	__le64 rsv_rfer;
-	__le64 rsv_excl;
-} __attribute__ ((__packed__));
-
 struct btrfs_space_info {
 	u64 flags;
 	u64 total_bytes;
@@ -1552,21 +625,6 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
  * data in the FS
  */
 #define BTRFS_STRING_ITEM_KEY	253
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
 
 #define read_eb_member(eb, ptr, type, member, result) (			\
 	read_extent_buffer(eb, (char *)(result),			\
@@ -1936,12 +994,6 @@ static inline u32 btrfs_extent_inline_ref_size(int type)
 	return 0;
 }
 
-BTRFS_SETGET_FUNCS(ref_root_v0, struct btrfs_extent_ref_v0, root, 64);
-BTRFS_SETGET_FUNCS(ref_generation_v0, struct btrfs_extent_ref_v0,
-		   generation, 64);
-BTRFS_SETGET_FUNCS(ref_objectid_v0, struct btrfs_extent_ref_v0, objectid, 64);
-BTRFS_SETGET_FUNCS(ref_count_v0, struct btrfs_extent_ref_v0, count, 32);
-
 /* struct btrfs_node */
 BTRFS_SETGET_FUNCS(key_blockptr, struct btrfs_key_ptr, blockptr, 64);
 BTRFS_SETGET_FUNCS(key_generation, struct btrfs_key_ptr, generation, 64);
diff --git a/kernel-shared/uapi/btrfs_tree.h b/kernel-shared/uapi/btrfs_tree.h
new file mode 100644
index 00000000..42744d2b
--- /dev/null
+++ b/kernel-shared/uapi/btrfs_tree.h
@@ -0,0 +1,1259 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _BTRFS_CTREE_H_
+#define _BTRFS_CTREE_H_
+
+#include "btrfs.h"
+#include <linux/types.h>
+#ifdef __KERNEL__
+#include <linux/stddef.h>
+#else
+#include <stddef.h>
+#endif
+
+/* ASCII for _BHRfS_M, no terminating nul */
+#define BTRFS_MAGIC 0x4D5F53665248425FULL
+
+#define BTRFS_MAX_LEVEL 8
+
+/*
+ * We can actually store much bigger names, but lets not confuse the rest of
+ * linux.
+ */
+#define BTRFS_NAME_LEN 255
+
+/*
+ * Theoretical limit is larger, but we keep this down to a sane value. That
+ * should limit greatly the possibility of collisions on inode ref items.
+ */
+#define BTRFS_LINK_MAX 65535U
+
+/*
+ * This header contains the structure definitions and constants used
+ * by file system objects that can be retrieved using
+ * the BTRFS_IOC_SEARCH_TREE ioctl.  That means basically anything that
+ * is needed to describe a leaf node's key or item contents.
+ */
+
+/* holds pointers to all of the tree roots */
+#define BTRFS_ROOT_TREE_OBJECTID 1ULL
+
+/* stores information about which extents are in use, and reference counts */
+#define BTRFS_EXTENT_TREE_OBJECTID 2ULL
+
+/*
+ * chunk tree stores translations from logical -> physical block numbering
+ * the super block points to the chunk tree
+ */
+#define BTRFS_CHUNK_TREE_OBJECTID 3ULL
+
+/*
+ * stores information about which areas of a given device are in use.
+ * one per device.  The tree of tree roots points to the device tree
+ */
+#define BTRFS_DEV_TREE_OBJECTID 4ULL
+
+/* one per subvolume, storing files and directories */
+#define BTRFS_FS_TREE_OBJECTID 5ULL
+
+/* directory objectid inside the root tree */
+#define BTRFS_ROOT_TREE_DIR_OBJECTID 6ULL
+
+/* holds checksums of all the data extents */
+#define BTRFS_CSUM_TREE_OBJECTID 7ULL
+
+/* holds quota configuration and tracking */
+#define BTRFS_QUOTA_TREE_OBJECTID 8ULL
+
+/* for storing items that use the BTRFS_UUID_KEY* types */
+#define BTRFS_UUID_TREE_OBJECTID 9ULL
+
+/* tracks free space in block groups. */
+#define BTRFS_FREE_SPACE_TREE_OBJECTID 10ULL
+
+/* Holds the block group items for extent tree v2. */
+#define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
+
+/* device stats in the device tree */
+#define BTRFS_DEV_STATS_OBJECTID 0ULL
+
+/* for storing balance parameters in the root tree */
+#define BTRFS_BALANCE_OBJECTID -4ULL
+
+/* orphan objectid for tracking unlinked/truncated files */
+#define BTRFS_ORPHAN_OBJECTID -5ULL
+
+/* does write ahead logging to speed up fsyncs */
+#define BTRFS_TREE_LOG_OBJECTID -6ULL
+#define BTRFS_TREE_LOG_FIXUP_OBJECTID -7ULL
+
+/* for space balancing */
+#define BTRFS_TREE_RELOC_OBJECTID -8ULL
+#define BTRFS_DATA_RELOC_TREE_OBJECTID -9ULL
+
+/*
+ * extent checksums all have this objectid
+ * this allows them to share the logging tree
+ * for fsyncs
+ */
+#define BTRFS_EXTENT_CSUM_OBJECTID -10ULL
+
+/* For storing free space cache */
+#define BTRFS_FREE_SPACE_OBJECTID -11ULL
+
+/*
+ * The inode number assigned to the special inode for storing
+ * free ino cache
+ */
+#define BTRFS_FREE_INO_OBJECTID -12ULL
+
+/* dummy objectid represents multiple objectids */
+#define BTRFS_MULTIPLE_OBJECTIDS -255ULL
+
+/*
+ * All files have objectids in this range.
+ */
+#define BTRFS_FIRST_FREE_OBJECTID 256ULL
+#define BTRFS_LAST_FREE_OBJECTID -256ULL
+#define BTRFS_FIRST_CHUNK_TREE_OBJECTID 256ULL
+
+
+/*
+ * the device items go into the chunk tree.  The key is in the form
+ * [ 1 BTRFS_DEV_ITEM_KEY device_id ]
+ */
+#define BTRFS_DEV_ITEMS_OBJECTID 1ULL
+
+#define BTRFS_BTREE_INODE_OBJECTID 1
+
+#define BTRFS_EMPTY_SUBVOL_DIR_OBJECTID 2
+
+#define BTRFS_DEV_REPLACE_DEVID 0ULL
+
+/*
+ * inode items have the data typically returned from stat and store other
+ * info about object characteristics.  There is one for every file and dir in
+ * the FS
+ */
+#define BTRFS_INODE_ITEM_KEY		1
+#define BTRFS_INODE_REF_KEY		12
+#define BTRFS_INODE_EXTREF_KEY		13
+#define BTRFS_XATTR_ITEM_KEY		24
+
+/*
+ * fs verity items are stored under two different key types on disk.
+ * The descriptor items:
+ * [ inode objectid, BTRFS_VERITY_DESC_ITEM_KEY, offset ]
+ *
+ * At offset 0, we store a btrfs_verity_descriptor_item which tracks the size
+ * of the descriptor item and some extra data for encryption.
+ * Starting at offset 1, these hold the generic fs verity descriptor.  The
+ * latter are opaque to btrfs, we just read and write them as a blob for the
+ * higher level verity code.  The most common descriptor size is 256 bytes.
+ *
+ * The merkle tree items:
+ * [ inode objectid, BTRFS_VERITY_MERKLE_ITEM_KEY, offset ]
+ *
+ * These also start at offset 0, and correspond to the merkle tree bytes.  When
+ * fsverity asks for page 0 of the merkle tree, we pull up one page starting at
+ * offset 0 for this key type.  These are also opaque to btrfs, we're blindly
+ * storing whatever fsverity sends down.
+ */
+#define BTRFS_VERITY_DESC_ITEM_KEY	36
+#define BTRFS_VERITY_MERKLE_ITEM_KEY	37
+
+#define BTRFS_ORPHAN_ITEM_KEY		48
+/* reserve 2-15 close to the inode for later flexibility */
+
+/*
+ * dir items are the name -> inode pointers in a directory.  There is one
+ * for every name in a directory.  BTRFS_DIR_LOG_ITEM_KEY is no longer used
+ * but it's still defined here for documentation purposes and to help avoid
+ * having its numerical value reused in the future.
+ */
+#define BTRFS_DIR_LOG_ITEM_KEY  60
+#define BTRFS_DIR_LOG_INDEX_KEY 72
+#define BTRFS_DIR_ITEM_KEY	84
+#define BTRFS_DIR_INDEX_KEY	96
+/*
+ * extent data is for file data
+ */
+#define BTRFS_EXTENT_DATA_KEY	108
+
+/*
+ * extent csums are stored in a separate tree and hold csums for
+ * an entire extent on disk.
+ */
+#define BTRFS_EXTENT_CSUM_KEY	128
+
+/*
+ * root items point to tree roots.  They are typically in the root
+ * tree used by the super block to find all the other trees
+ */
+#define BTRFS_ROOT_ITEM_KEY	132
+
+/*
+ * root backrefs tie subvols and snapshots to the directory entries that
+ * reference them
+ */
+#define BTRFS_ROOT_BACKREF_KEY	144
+
+/*
+ * root refs make a fast index for listing all of the snapshots and
+ * subvolumes referenced by a given root.  They point directly to the
+ * directory item in the root that references the subvol
+ */
+#define BTRFS_ROOT_REF_KEY	156
+
+/*
+ * extent items are in the extent map tree.  These record which blocks
+ * are used, and how many references there are to each block
+ */
+#define BTRFS_EXTENT_ITEM_KEY	168
+
+/*
+ * The same as the BTRFS_EXTENT_ITEM_KEY, except it's metadata we already know
+ * the length, so we save the level in key->offset instead of the length.
+ */
+#define BTRFS_METADATA_ITEM_KEY	169
+
+#define BTRFS_TREE_BLOCK_REF_KEY	176
+
+#define BTRFS_EXTENT_DATA_REF_KEY	178
+
+#define BTRFS_EXTENT_REF_V0_KEY		180
+
+#define BTRFS_SHARED_BLOCK_REF_KEY	182
+
+#define BTRFS_SHARED_DATA_REF_KEY	184
+
+/*
+ * block groups give us hints into the extent allocation trees.  Which
+ * blocks are free etc etc
+ */
+#define BTRFS_BLOCK_GROUP_ITEM_KEY 192
+
+/*
+ * Every block group is represented in the free space tree by a free space info
+ * item, which stores some accounting information. It is keyed on
+ * (block_group_start, FREE_SPACE_INFO, block_group_length).
+ */
+#define BTRFS_FREE_SPACE_INFO_KEY 198
+
+/*
+ * A free space extent tracks an extent of space that is free in a block group.
+ * It is keyed on (start, FREE_SPACE_EXTENT, length).
+ */
+#define BTRFS_FREE_SPACE_EXTENT_KEY 199
+
+/*
+ * When a block group becomes very fragmented, we convert it to use bitmaps
+ * instead of extents. A free space bitmap is keyed on
+ * (start, FREE_SPACE_BITMAP, length); the corresponding item is a bitmap with
+ * (length / sectorsize) bits.
+ */
+#define BTRFS_FREE_SPACE_BITMAP_KEY 200
+
+#define BTRFS_DEV_EXTENT_KEY	204
+#define BTRFS_DEV_ITEM_KEY	216
+#define BTRFS_CHUNK_ITEM_KEY	228
+
+/*
+ * Records the overall state of the qgroups.
+ * There's only one instance of this key present,
+ * (0, BTRFS_QGROUP_STATUS_KEY, 0)
+ */
+#define BTRFS_QGROUP_STATUS_KEY         240
+/*
+ * Records the currently used space of the qgroup.
+ * One key per qgroup, (0, BTRFS_QGROUP_INFO_KEY, qgroupid).
+ */
+#define BTRFS_QGROUP_INFO_KEY           242
+/*
+ * Contains the user configured limits for the qgroup.
+ * One key per qgroup, (0, BTRFS_QGROUP_LIMIT_KEY, qgroupid).
+ */
+#define BTRFS_QGROUP_LIMIT_KEY          244
+/*
+ * Records the child-parent relationship of qgroups. For
+ * each relation, 2 keys are present:
+ * (childid, BTRFS_QGROUP_RELATION_KEY, parentid)
+ * (parentid, BTRFS_QGROUP_RELATION_KEY, childid)
+ */
+#define BTRFS_QGROUP_RELATION_KEY       246
+
+/*
+ * Obsolete name, see BTRFS_TEMPORARY_ITEM_KEY.
+ */
+#define BTRFS_BALANCE_ITEM_KEY	248
+
+/*
+ * The key type for tree items that are stored persistently, but do not need to
+ * exist for extended period of time. The items can exist in any tree.
+ *
+ * [subtype, BTRFS_TEMPORARY_ITEM_KEY, data]
+ *
+ * Existing items:
+ *
+ * - balance status item
+ *   (BTRFS_BALANCE_OBJECTID, BTRFS_TEMPORARY_ITEM_KEY, 0)
+ */
+#define BTRFS_TEMPORARY_ITEM_KEY	248
+
+/*
+ * Obsolete name, see BTRFS_PERSISTENT_ITEM_KEY
+ */
+#define BTRFS_DEV_STATS_KEY		249
+
+/*
+ * The key type for tree items that are stored persistently and usually exist
+ * for a long period, eg. filesystem lifetime. The item kinds can be status
+ * information, stats or preference values. The item can exist in any tree.
+ *
+ * [subtype, BTRFS_PERSISTENT_ITEM_KEY, data]
+ *
+ * Existing items:
+ *
+ * - device statistics, store IO stats in the device tree, one key for all
+ *   stats
+ *   (BTRFS_DEV_STATS_OBJECTID, BTRFS_DEV_STATS_KEY, 0)
+ */
+#define BTRFS_PERSISTENT_ITEM_KEY	249
+
+/*
+ * Persistently stores the device replace state in the device tree.
+ * The key is built like this: (0, BTRFS_DEV_REPLACE_KEY, 0).
+ */
+#define BTRFS_DEV_REPLACE_KEY	250
+
+/*
+ * Stores items that allow to quickly map UUIDs to something else.
+ * These items are part of the filesystem UUID tree.
+ * The key is built like this:
+ * (UUID_upper_64_bits, BTRFS_UUID_KEY*, UUID_lower_64_bits).
+ */
+#if BTRFS_UUID_SIZE != 16
+#error "UUID items require BTRFS_UUID_SIZE == 16!"
+#endif
+#define BTRFS_UUID_KEY_SUBVOL	251	/* for UUIDs assigned to subvols */
+#define BTRFS_UUID_KEY_RECEIVED_SUBVOL	252	/* for UUIDs assigned to
+						 * received subvols */
+
+/*
+ * string items are for debugging.  They just store a short string of
+ * data in the FS
+ */
+#define BTRFS_STRING_ITEM_KEY	253
+
+/* Maximum metadata block size (nodesize) */
+#define BTRFS_MAX_METADATA_BLOCKSIZE			65536
+
+/* 32 bytes in various csum fields */
+#define BTRFS_CSUM_SIZE 32
+
+/* csum types */
+enum btrfs_csum_type {
+	BTRFS_CSUM_TYPE_CRC32	= 0,
+	BTRFS_CSUM_TYPE_XXHASH	= 1,
+	BTRFS_CSUM_TYPE_SHA256	= 2,
+	BTRFS_CSUM_TYPE_BLAKE2	= 3,
+};
+
+/*
+ * flags definitions for directory entry item type
+ *
+ * Used by:
+ * struct btrfs_dir_item.type
+ *
+ * Values 0..7 must match common file type values in fs_types.h.
+ */
+#define BTRFS_FT_UNKNOWN	0
+#define BTRFS_FT_REG_FILE	1
+#define BTRFS_FT_DIR		2
+#define BTRFS_FT_CHRDEV		3
+#define BTRFS_FT_BLKDEV		4
+#define BTRFS_FT_FIFO		5
+#define BTRFS_FT_SOCK		6
+#define BTRFS_FT_SYMLINK	7
+#define BTRFS_FT_XATTR		8
+#define BTRFS_FT_MAX		9
+/* Directory contains encrypted data */
+#define BTRFS_FT_ENCRYPTED	0x80
+
+static inline __u8 btrfs_dir_flags_to_ftype(__u8 flags)
+{
+	return flags & ~BTRFS_FT_ENCRYPTED;
+}
+
+/*
+ * Inode flags
+ */
+#define BTRFS_INODE_NODATASUM		(1U << 0)
+#define BTRFS_INODE_NODATACOW		(1U << 1)
+#define BTRFS_INODE_READONLY		(1U << 2)
+#define BTRFS_INODE_NOCOMPRESS		(1U << 3)
+#define BTRFS_INODE_PREALLOC		(1U << 4)
+#define BTRFS_INODE_SYNC		(1U << 5)
+#define BTRFS_INODE_IMMUTABLE		(1U << 6)
+#define BTRFS_INODE_APPEND		(1U << 7)
+#define BTRFS_INODE_NODUMP		(1U << 8)
+#define BTRFS_INODE_NOATIME		(1U << 9)
+#define BTRFS_INODE_DIRSYNC		(1U << 10)
+#define BTRFS_INODE_COMPRESS		(1U << 11)
+
+#define BTRFS_INODE_ROOT_ITEM_INIT	(1U << 31)
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
+#define BTRFS_INODE_RO_VERITY		(1U << 0)
+
+#define BTRFS_INODE_RO_FLAG_MASK	(BTRFS_INODE_RO_VERITY)
+
+/*
+ * The key defines the order in the tree, and so it also defines (optimal)
+ * block layout.
+ *
+ * objectid corresponds to the inode number.
+ *
+ * type tells us things about the object, and is a kind of stream selector.
+ * so for a given inode, keys with type of 1 might refer to the inode data,
+ * type of 2 may point to file data in the btree and type == 3 may point to
+ * extents.
+ *
+ * offset is the starting byte offset for this key in the stream.
+ *
+ * btrfs_disk_key is in disk byte order.  struct btrfs_key is always
+ * in cpu native order.  Otherwise they are identical and their sizes
+ * should be the same (ie both packed)
+ */
+struct btrfs_disk_key {
+	__le64 objectid;
+	__u8 type;
+	__le64 offset;
+} __attribute__ ((__packed__));
+
+struct btrfs_key {
+	__u64 objectid;
+	__u8 type;
+	__u64 offset;
+} __attribute__ ((__packed__));
+
+/*
+ * Every tree block (leaf or node) starts with this header.
+ */
+struct btrfs_header {
+	/* These first four must match the super block */
+	__u8 csum[BTRFS_CSUM_SIZE];
+	/* FS specific uuid */
+	__u8 fsid[BTRFS_FSID_SIZE];
+	/* Which block this node is supposed to live in */
+	__le64 bytenr;
+	__le64 flags;
+
+	/* Allowed to be different from the super from here on down */
+	__u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
+	__le64 generation;
+	__le64 owner;
+	__le32 nritems;
+	__u8 level;
+} __attribute__ ((__packed__));
+
+/*
+ * This is a very generous portion of the super block, giving us room to
+ * translate 14 chunks with 3 stripes each.
+ */
+#define BTRFS_SYSTEM_CHUNK_ARRAY_SIZE 2048
+
+/*
+ * Just in case we somehow lose the roots and are not able to mount, we store
+ * an array of the roots from previous transactions in the super.
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
+	__u8 tree_root_level;
+	__u8 chunk_root_level;
+	__u8 extent_root_level;
+	__u8 fs_root_level;
+	__u8 dev_root_level;
+	__u8 csum_root_level;
+	/* future and to align */
+	__u8 unused_8[10];
+} __attribute__ ((__packed__));
+
+/*
+ * A leaf is full of items. offset and size tell us where to find the item in
+ * the leaf (relative to the start of the data area)
+ */
+struct btrfs_item {
+	struct btrfs_disk_key key;
+	__le32 offset;
+	__le32 size;
+} __attribute__ ((__packed__));
+
+/*
+ * Leaves have an item area and a data area:
+ * [item0, item1....itemN] [free space] [dataN...data1, data0]
+ *
+ * The data is separate from the items to get the keys closer together during
+ * searches.
+ */
+struct btrfs_leaf {
+	struct btrfs_header header;
+	struct btrfs_item items[];
+} __attribute__ ((__packed__));
+
+/*
+ * All non-leaf blocks are nodes, they hold only keys and pointers to other
+ * blocks.
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
+struct btrfs_dev_item {
+	/* the internal btrfs device id */
+	__le64 devid;
+
+	/* size of the device */
+	__le64 total_bytes;
+
+	/* bytes used */
+	__le64 bytes_used;
+
+	/* optimal io alignment for this device */
+	__le32 io_align;
+
+	/* optimal io width for this device */
+	__le32 io_width;
+
+	/* minimal io size for this device */
+	__le32 sector_size;
+
+	/* type and info about this device */
+	__le64 type;
+
+	/* expected generation for this device */
+	__le64 generation;
+
+	/*
+	 * starting byte of this partition on the device,
+	 * to allow for stripe alignment in the future
+	 */
+	__le64 start_offset;
+
+	/* grouping information for allocation decisions */
+	__le32 dev_group;
+
+	/* seek speed 0-100 where 100 is fastest */
+	__u8 seek_speed;
+
+	/* bandwidth 0-100 where 100 is fastest */
+	__u8 bandwidth;
+
+	/* btrfs generated uuid for this device */
+	__u8 uuid[BTRFS_UUID_SIZE];
+
+	/* uuid of FS who owns this device */
+	__u8 fsid[BTRFS_UUID_SIZE];
+} __attribute__ ((__packed__));
+
+struct btrfs_stripe {
+	__le64 devid;
+	__le64 offset;
+	__u8 dev_uuid[BTRFS_UUID_SIZE];
+} __attribute__ ((__packed__));
+
+struct btrfs_chunk {
+	/* size of this chunk in bytes */
+	__le64 length;
+
+	/* objectid of the root referencing this chunk */
+	__le64 owner;
+
+	__le64 stripe_len;
+	__le64 type;
+
+	/* optimal io alignment for this chunk */
+	__le32 io_align;
+
+	/* optimal io width for this chunk */
+	__le32 io_width;
+
+	/* minimal io size for this chunk */
+	__le32 sector_size;
+
+	/* 2^16 stripes is quite a lot, a second limit is the size of a single
+	 * item in the btree
+	 */
+	__le16 num_stripes;
+
+	/* sub stripes only matter for raid10 */
+	__le16 sub_stripes;
+	struct btrfs_stripe stripe;
+	/* additional stripes go here */
+} __attribute__ ((__packed__));
+
+/*
+ * The super block basically lists the main trees of the FS.
+ */
+struct btrfs_super_block {
+	/* The first 4 fields must match struct btrfs_header */
+	__u8 csum[BTRFS_CSUM_SIZE];
+	/* FS specific UUID, visible to user */
+	__u8 fsid[BTRFS_FSID_SIZE];
+	/* This block number */
+	__le64 bytenr;
+	__le64 flags;
+
+	/* Allowed to be different from the btrfs_header from here own down */
+	__le64 magic;
+	__le64 generation;
+	__le64 root;
+	__le64 chunk_root;
+	__le64 log_root;
+
+	/*
+	 * This member has never been utilized since the very beginning, thus
+	 * it's always 0 regardless of kernel version.  We always use
+	 * generation + 1 to read log tree root.  So here we mark it deprecated.
+	 */
+	__le64 __unused_log_root_transid;
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
+	__u8 root_level;
+	__u8 chunk_root_level;
+	__u8 log_root_level;
+	struct btrfs_dev_item dev_item;
+
+	char label[BTRFS_LABEL_SIZE];
+
+	__le64 cache_generation;
+	__le64 uuid_tree_generation;
+
+	/* The UUID written into btree blocks */
+	__u8 metadata_uuid[BTRFS_FSID_SIZE];
+
+	__u64 nr_global_roots;
+
+	__le64 reserved[27];
+	__u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
+	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
+
+	/* Padded to 4096 bytes */
+	__u8 padding[565];
+} __attribute__ ((__packed__));
+
+#define BTRFS_FREE_SPACE_EXTENT	1
+#define BTRFS_FREE_SPACE_BITMAP	2
+
+struct btrfs_free_space_entry {
+	__le64 offset;
+	__le64 bytes;
+	__u8 type;
+} __attribute__ ((__packed__));
+
+struct btrfs_free_space_header {
+	struct btrfs_disk_key location;
+	__le64 generation;
+	__le64 num_entries;
+	__le64 num_bitmaps;
+} __attribute__ ((__packed__));
+
+#define BTRFS_HEADER_FLAG_WRITTEN	(1ULL << 0)
+#define BTRFS_HEADER_FLAG_RELOC		(1ULL << 1)
+
+/* Super block flags */
+/* Errors detected */
+#define BTRFS_SUPER_FLAG_ERROR		(1ULL << 2)
+
+#define BTRFS_SUPER_FLAG_SEEDING	(1ULL << 32)
+#define BTRFS_SUPER_FLAG_METADUMP	(1ULL << 33)
+#define BTRFS_SUPER_FLAG_METADUMP_V2	(1ULL << 34)
+#define BTRFS_SUPER_FLAG_CHANGING_FSID	(1ULL << 35)
+#define BTRFS_SUPER_FLAG_CHANGING_FSID_V2 (1ULL << 36)
+
+
+/*
+ * items in the extent btree are used to record the objectid of the
+ * owner of the block and the number of references
+ */
+
+struct btrfs_extent_item {
+	__le64 refs;
+	__le64 generation;
+	__le64 flags;
+} __attribute__ ((__packed__));
+
+struct btrfs_extent_item_v0 {
+	__le32 refs;
+} __attribute__ ((__packed__));
+
+
+#define BTRFS_EXTENT_FLAG_DATA		(1ULL << 0)
+#define BTRFS_EXTENT_FLAG_TREE_BLOCK	(1ULL << 1)
+
+/* following flags only apply to tree blocks */
+
+/* use full backrefs for extent pointers in the block */
+#define BTRFS_BLOCK_FLAG_FULL_BACKREF	(1ULL << 8)
+
+#define BTRFS_BACKREF_REV_MAX		256
+#define BTRFS_BACKREF_REV_SHIFT		56
+#define BTRFS_BACKREF_REV_MASK		(((u64)BTRFS_BACKREF_REV_MAX - 1) << \
+					 BTRFS_BACKREF_REV_SHIFT)
+
+#define BTRFS_OLD_BACKREF_REV		0
+#define BTRFS_MIXED_BACKREF_REV		1
+
+/*
+ * this flag is only used internally by scrub and may be changed at any time
+ * it is only declared here to avoid collisions
+ */
+#define BTRFS_EXTENT_FLAG_SUPER		(1ULL << 48)
+
+struct btrfs_tree_block_info {
+	struct btrfs_disk_key key;
+	__u8 level;
+} __attribute__ ((__packed__));
+
+struct btrfs_extent_data_ref {
+	__le64 root;
+	__le64 objectid;
+	__le64 offset;
+	__le32 count;
+} __attribute__ ((__packed__));
+
+struct btrfs_shared_data_ref {
+	__le32 count;
+} __attribute__ ((__packed__));
+
+struct btrfs_extent_inline_ref {
+	__u8 type;
+	__le64 offset;
+} __attribute__ ((__packed__));
+
+/* dev extents record free space on individual devices.  The owner
+ * field points back to the chunk allocation mapping tree that allocated
+ * the extent.  The chunk tree uuid field is a way to double check the owner
+ */
+struct btrfs_dev_extent {
+	__le64 chunk_tree;
+	__le64 chunk_objectid;
+	__le64 chunk_offset;
+	__le64 length;
+	__u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
+} __attribute__ ((__packed__));
+
+struct btrfs_inode_ref {
+	__le64 index;
+	__le16 name_len;
+	/* name goes here */
+} __attribute__ ((__packed__));
+
+struct btrfs_inode_extref {
+	__le64 parent_objectid;
+	__le64 index;
+	__le16 name_len;
+	__u8   name[];
+	/* name goes here */
+} __attribute__ ((__packed__));
+
+struct btrfs_timespec {
+	__le64 sec;
+	__le32 nsec;
+} __attribute__ ((__packed__));
+
+struct btrfs_inode_item {
+	/* nfs style generation number */
+	__le64 generation;
+	/* transid that last touched this inode */
+	__le64 transid;
+	__le64 size;
+	__le64 nbytes;
+	__le64 block_group;
+	__le32 nlink;
+	__le32 uid;
+	__le32 gid;
+	__le32 mode;
+	__le64 rdev;
+	__le64 flags;
+
+	/* modification sequence number for NFS */
+	__le64 sequence;
+
+	/*
+	 * a little future expansion, for more than this we can
+	 * just grow the inode item and version it
+	 */
+	__le64 reserved[4];
+	struct btrfs_timespec atime;
+	struct btrfs_timespec ctime;
+	struct btrfs_timespec mtime;
+	struct btrfs_timespec otime;
+} __attribute__ ((__packed__));
+
+struct btrfs_dir_log_item {
+	__le64 end;
+} __attribute__ ((__packed__));
+
+struct btrfs_dir_item {
+	struct btrfs_disk_key location;
+	__le64 transid;
+	__le16 data_len;
+	__le16 name_len;
+	__u8 type;
+} __attribute__ ((__packed__));
+
+#define BTRFS_ROOT_SUBVOL_RDONLY	(1ULL << 0)
+
+/*
+ * Internal in-memory flag that a subvolume has been marked for deletion but
+ * still visible as a directory
+ */
+#define BTRFS_ROOT_SUBVOL_DEAD		(1ULL << 48)
+
+struct btrfs_root_item {
+	struct btrfs_inode_item inode;
+	__le64 generation;
+	__le64 root_dirid;
+	__le64 bytenr;
+	__le64 byte_limit;
+	__le64 bytes_used;
+	__le64 last_snapshot;
+	__le64 flags;
+	__le32 refs;
+	struct btrfs_disk_key drop_progress;
+	__u8 drop_level;
+	__u8 level;
+
+	/*
+	 * The following fields appear after subvol_uuids+subvol_times
+	 * were introduced.
+	 */
+
+	/*
+	 * This generation number is used to test if the new fields are valid
+	 * and up to date while reading the root item. Every time the root item
+	 * is written out, the "generation" field is copied into this field. If
+	 * anyone ever mounted the fs with an older kernel, we will have
+	 * mismatching generation values here and thus must invalidate the
+	 * new fields. See btrfs_update_root and btrfs_find_last_root for
+	 * details.
+	 * the offset of generation_v2 is also used as the start for the memset
+	 * when invalidating the fields.
+	 */
+	__le64 generation_v2;
+	__u8 uuid[BTRFS_UUID_SIZE];
+	__u8 parent_uuid[BTRFS_UUID_SIZE];
+	__u8 received_uuid[BTRFS_UUID_SIZE];
+	__le64 ctransid; /* updated when an inode changes */
+	__le64 otransid; /* trans when created */
+	__le64 stransid; /* trans when sent. non-zero for received subvol */
+	__le64 rtransid; /* trans when received. non-zero for received subvol */
+	struct btrfs_timespec ctime;
+	struct btrfs_timespec otime;
+	struct btrfs_timespec stime;
+	struct btrfs_timespec rtime;
+	__le64 reserved[8]; /* for future */
+} __attribute__ ((__packed__));
+
+/*
+ * Btrfs root item used to be smaller than current size.  The old format ends
+ * at where member generation_v2 is.
+ */
+static inline __u32 btrfs_legacy_root_item_size(void)
+{
+	return offsetof(struct btrfs_root_item, generation_v2);
+}
+
+/*
+ * this is used for both forward and backward root refs
+ */
+struct btrfs_root_ref {
+	__le64 dirid;
+	__le64 sequence;
+	__le16 name_len;
+} __attribute__ ((__packed__));
+
+struct btrfs_disk_balance_args {
+	/*
+	 * profiles to operate on, single is denoted by
+	 * BTRFS_AVAIL_ALLOC_BIT_SINGLE
+	 */
+	__le64 profiles;
+
+	/*
+	 * usage filter
+	 * BTRFS_BALANCE_ARGS_USAGE with a single value means '0..N'
+	 * BTRFS_BALANCE_ARGS_USAGE_RANGE - range syntax, min..max
+	 */
+	union {
+		__le64 usage;
+		struct {
+			__le32 usage_min;
+			__le32 usage_max;
+		};
+	};
+
+	/* devid filter */
+	__le64 devid;
+
+	/* devid subset filter [pstart..pend) */
+	__le64 pstart;
+	__le64 pend;
+
+	/* btrfs virtual address space subset filter [vstart..vend) */
+	__le64 vstart;
+	__le64 vend;
+
+	/*
+	 * profile to convert to, single is denoted by
+	 * BTRFS_AVAIL_ALLOC_BIT_SINGLE
+	 */
+	__le64 target;
+
+	/* BTRFS_BALANCE_ARGS_* */
+	__le64 flags;
+
+	/*
+	 * BTRFS_BALANCE_ARGS_LIMIT with value 'limit'
+	 * BTRFS_BALANCE_ARGS_LIMIT_RANGE - the extend version can use minimum
+	 * and maximum
+	 */
+	union {
+		__le64 limit;
+		struct {
+			__le32 limit_min;
+			__le32 limit_max;
+		};
+	};
+
+	/*
+	 * Process chunks that cross stripes_min..stripes_max devices,
+	 * BTRFS_BALANCE_ARGS_STRIPES_RANGE
+	 */
+	__le32 stripes_min;
+	__le32 stripes_max;
+
+	__le64 unused[6];
+} __attribute__ ((__packed__));
+
+/*
+ * store balance parameters to disk so that balance can be properly
+ * resumed after crash or unmount
+ */
+struct btrfs_balance_item {
+	/* BTRFS_BALANCE_* */
+	__le64 flags;
+
+	struct btrfs_disk_balance_args data;
+	struct btrfs_disk_balance_args meta;
+	struct btrfs_disk_balance_args sys;
+
+	__le64 unused[4];
+} __attribute__ ((__packed__));
+
+enum {
+	BTRFS_FILE_EXTENT_INLINE   = 0,
+	BTRFS_FILE_EXTENT_REG      = 1,
+	BTRFS_FILE_EXTENT_PREALLOC = 2,
+	BTRFS_NR_FILE_EXTENT_TYPES = 3,
+};
+
+struct btrfs_file_extent_item {
+	/*
+	 * transaction id that created this extent
+	 */
+	__le64 generation;
+	/*
+	 * max number of bytes to hold this extent in ram
+	 * when we split a compressed extent we can't know how big
+	 * each of the resulting pieces will be.  So, this is
+	 * an upper limit on the size of the extent in ram instead of
+	 * an exact limit.
+	 */
+	__le64 ram_bytes;
+
+	/*
+	 * 32 bits for the various ways we might encode the data,
+	 * including compression and encryption.  If any of these
+	 * are set to something a given disk format doesn't understand
+	 * it is treated like an incompat flag for reading and writing,
+	 * but not for stat.
+	 */
+	__u8 compression;
+	__u8 encryption;
+	__le16 other_encoding; /* spare for later use */
+
+	/* are we inline data or a real extent? */
+	__u8 type;
+
+	/*
+	 * disk space consumed by the extent, checksum blocks are included
+	 * in these numbers
+	 *
+	 * At this offset in the structure, the inline extent data start.
+	 */
+	__le64 disk_bytenr;
+	__le64 disk_num_bytes;
+	/*
+	 * the logical offset in file blocks (no csums)
+	 * this extent record is for.  This allows a file extent to point
+	 * into the middle of an existing extent on disk, sharing it
+	 * between two snapshots (useful if some bytes in the middle of the
+	 * extent have changed
+	 */
+	__le64 offset;
+	/*
+	 * the logical number of file blocks (no csums included).  This
+	 * always reflects the size uncompressed and without encoding.
+	 */
+	__le64 num_bytes;
+
+} __attribute__ ((__packed__));
+
+struct btrfs_csum_item {
+	__u8 csum;
+} __attribute__ ((__packed__));
+
+struct btrfs_dev_stats_item {
+	/*
+	 * grow this item struct at the end for future enhancements and keep
+	 * the existing values unchanged
+	 */
+	__le64 values[BTRFS_DEV_STAT_VALUES_MAX];
+} __attribute__ ((__packed__));
+
+#define BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_ALWAYS	0
+#define BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_AVOID	1
+
+struct btrfs_dev_replace_item {
+	/*
+	 * grow this item struct at the end for future enhancements and keep
+	 * the existing values unchanged
+	 */
+	__le64 src_devid;
+	__le64 cursor_left;
+	__le64 cursor_right;
+	__le64 cont_reading_from_srcdev_mode;
+
+	__le64 replace_state;
+	__le64 time_started;
+	__le64 time_stopped;
+	__le64 num_write_errors;
+	__le64 num_uncorrectable_read_errors;
+} __attribute__ ((__packed__));
+
+/* different types of block groups (and chunks) */
+#define BTRFS_BLOCK_GROUP_DATA		(1ULL << 0)
+#define BTRFS_BLOCK_GROUP_SYSTEM	(1ULL << 1)
+#define BTRFS_BLOCK_GROUP_METADATA	(1ULL << 2)
+#define BTRFS_BLOCK_GROUP_RAID0		(1ULL << 3)
+#define BTRFS_BLOCK_GROUP_RAID1		(1ULL << 4)
+#define BTRFS_BLOCK_GROUP_DUP		(1ULL << 5)
+#define BTRFS_BLOCK_GROUP_RAID10	(1ULL << 6)
+#define BTRFS_BLOCK_GROUP_RAID5         (1ULL << 7)
+#define BTRFS_BLOCK_GROUP_RAID6         (1ULL << 8)
+#define BTRFS_BLOCK_GROUP_RAID1C3       (1ULL << 9)
+#define BTRFS_BLOCK_GROUP_RAID1C4       (1ULL << 10)
+#define BTRFS_BLOCK_GROUP_RESERVED	(BTRFS_AVAIL_ALLOC_BIT_SINGLE | \
+					 BTRFS_SPACE_INFO_GLOBAL_RSV)
+
+#define BTRFS_BLOCK_GROUP_TYPE_MASK	(BTRFS_BLOCK_GROUP_DATA |    \
+					 BTRFS_BLOCK_GROUP_SYSTEM |  \
+					 BTRFS_BLOCK_GROUP_METADATA)
+
+#define BTRFS_BLOCK_GROUP_PROFILE_MASK	(BTRFS_BLOCK_GROUP_RAID0 |   \
+					 BTRFS_BLOCK_GROUP_RAID1 |   \
+					 BTRFS_BLOCK_GROUP_RAID1C3 | \
+					 BTRFS_BLOCK_GROUP_RAID1C4 | \
+					 BTRFS_BLOCK_GROUP_RAID5 |   \
+					 BTRFS_BLOCK_GROUP_RAID6 |   \
+					 BTRFS_BLOCK_GROUP_DUP |     \
+					 BTRFS_BLOCK_GROUP_RAID10)
+#define BTRFS_BLOCK_GROUP_RAID56_MASK	(BTRFS_BLOCK_GROUP_RAID5 |   \
+					 BTRFS_BLOCK_GROUP_RAID6)
+
+#define BTRFS_BLOCK_GROUP_RAID1_MASK	(BTRFS_BLOCK_GROUP_RAID1 |   \
+					 BTRFS_BLOCK_GROUP_RAID1C3 | \
+					 BTRFS_BLOCK_GROUP_RAID1C4)
+
+/*
+ * We need a bit for restriper to be able to tell when chunks of type
+ * SINGLE are available.  This "extended" profile format is used in
+ * fs_info->avail_*_alloc_bits (in-memory) and balance item fields
+ * (on-disk).  The corresponding on-disk bit in chunk.type is reserved
+ * to avoid remappings between two formats in future.
+ */
+#define BTRFS_AVAIL_ALLOC_BIT_SINGLE	(1ULL << 48)
+
+/*
+ * A fake block group type that is used to communicate global block reserve
+ * size to userspace via the SPACE_INFO ioctl.
+ */
+#define BTRFS_SPACE_INFO_GLOBAL_RSV	(1ULL << 49)
+
+#define BTRFS_EXTENDED_PROFILE_MASK	(BTRFS_BLOCK_GROUP_PROFILE_MASK | \
+					 BTRFS_AVAIL_ALLOC_BIT_SINGLE)
+
+static inline __u64 chunk_to_extended(__u64 flags)
+{
+	if ((flags & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0)
+		flags |= BTRFS_AVAIL_ALLOC_BIT_SINGLE;
+
+	return flags;
+}
+static inline __u64 extended_to_chunk(__u64 flags)
+{
+	return flags & ~BTRFS_AVAIL_ALLOC_BIT_SINGLE;
+}
+
+struct btrfs_block_group_item {
+	__le64 used;
+	__le64 chunk_objectid;
+	__le64 flags;
+} __attribute__ ((__packed__));
+
+struct btrfs_free_space_info {
+	__le32 extent_count;
+	__le32 flags;
+} __attribute__ ((__packed__));
+
+#define BTRFS_FREE_SPACE_USING_BITMAPS (1ULL << 0)
+
+#define BTRFS_QGROUP_LEVEL_SHIFT		48
+static inline __u16 btrfs_qgroup_level(__u64 qgroupid)
+{
+	return (__u16)(qgroupid >> BTRFS_QGROUP_LEVEL_SHIFT);
+}
+
+/*
+ * is subvolume quota turned on?
+ */
+#define BTRFS_QGROUP_STATUS_FLAG_ON		(1ULL << 0)
+/*
+ * RESCAN is set during the initialization phase
+ */
+#define BTRFS_QGROUP_STATUS_FLAG_RESCAN		(1ULL << 1)
+/*
+ * Some qgroup entries are known to be out of date,
+ * either because the configuration has changed in a way that
+ * makes a rescan necessary, or because the fs has been mounted
+ * with a non-qgroup-aware version.
+ * Turning qouta off and on again makes it inconsistent, too.
+ */
+#define BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT	(1ULL << 2)
+
+#define BTRFS_QGROUP_STATUS_FLAGS_MASK	(BTRFS_QGROUP_STATUS_FLAG_ON |		\
+					 BTRFS_QGROUP_STATUS_FLAG_RESCAN |	\
+					 BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT)
+
+#define BTRFS_QGROUP_STATUS_VERSION        1
+
+struct btrfs_qgroup_status_item {
+	__le64 version;
+	/*
+	 * the generation is updated during every commit. As older
+	 * versions of btrfs are not aware of qgroups, it will be
+	 * possible to detect inconsistencies by checking the
+	 * generation on mount time
+	 */
+	__le64 generation;
+
+	/* flag definitions see above */
+	__le64 flags;
+
+	/*
+	 * only used during scanning to record the progress
+	 * of the scan. It contains a logical address
+	 */
+	__le64 rescan;
+} __attribute__ ((__packed__));
+
+struct btrfs_qgroup_info_item {
+	__le64 generation;
+	__le64 rfer;
+	__le64 rfer_cmpr;
+	__le64 excl;
+	__le64 excl_cmpr;
+} __attribute__ ((__packed__));
+
+struct btrfs_qgroup_limit_item {
+	/*
+	 * only updated when any of the other values change
+	 */
+	__le64 flags;
+	__le64 max_rfer;
+	__le64 max_excl;
+	__le64 rsv_rfer;
+	__le64 rsv_excl;
+} __attribute__ ((__packed__));
+
+struct btrfs_verity_descriptor_item {
+	/* Size of the verity descriptor in bytes */
+	__le64 size;
+	/*
+	 * When we implement support for fscrypt, we will need to encrypt the
+	 * Merkle tree for encrypted verity files. These 128 bits are for the
+	 * eventual storage of an fscrypt initialization vector.
+	 */
+	__le64 reserved[2];
+	__u8 encryption;
+} __attribute__ ((__packed__));
+
+#endif /* _BTRFS_CTREE_H_ */
-- 
2.26.3

