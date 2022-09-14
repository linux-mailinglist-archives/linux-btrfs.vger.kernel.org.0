Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9872D5B8B4C
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 17:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiINPHD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 11:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiINPGv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 11:06:51 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A99877E80
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:06:50 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id c11so11363817qtw.8
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=oABoixBFI91oZKgA2zZitFgs73Xzrpga0ZMJ4zfMr6c=;
        b=FWqjR1XRsMzVwbhYxJpOKZccBoHAga5KffzWRwxN+d0p0KReOxBQD9LfWouUwfWTEe
         YrQZYgo4jsZPJsYIoxvU59OXRcDgThzTnq39mK7LtAO4ysmk3lgBV3pAxY7WBVzLDIA+
         B9Sth2q8HJH2OHNZMEqHZMpWwszr7vP5H1hQaF+g8p2eFRV7Pzn5DHkS1Ufnk2YdiHEf
         WYCZrcWryxdTx2oMRi2jICNkh5/1rTe6y/WAbrbAakWgD6fwukQWKOTvVqJ9bwVqvUdp
         Q8QX983KFKeFqUc89vUsf8Rr2w1zce1COQYmJCObLr7+LTi08+NHbIXLIvtFw5/mLIqQ
         Dq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=oABoixBFI91oZKgA2zZitFgs73Xzrpga0ZMJ4zfMr6c=;
        b=Id+V28/ROMZLdl8J/18WEXvzsXjFwMTFj5ouLQcMgEYgUO/Z1VFTcvAmGjFMfpagv6
         4wSaKCd5rrl0XMJkxQ7fcdkiEOablUo3gPWAs+otgvIP34dv6MKLYpY6x2TWP55PMGTC
         nzG6WTs8k0+d7GDRzEceclq/2w2po2sHakfXahXLXohZIWfyjGD41ePQE8qI1hwGISEe
         Z0hcGdC4aXAnT6mZJBaK+YbU1btMdTwMLn3eRicZG+YNMg2BcY5q3Vqfy9suRyOGoJHO
         fuUH97tk5bsjBHGyC7ZCPKf8dzvvtF+uKwtK3e4QdTCEd6uUoRjGiWgc37w5JLfT7Owp
         lXmw==
X-Gm-Message-State: ACgBeo2LWDM7EE+e4CfVMHy7InGW2jsKyPGc38aQpa9cAREZrO/1ZQqS
        ua9qW9Kb69DlLSXEP4aEoW+AoX9fF4CBbQ==
X-Google-Smtp-Source: AA6agR7gCMaUQ3A4SIFpMbxGXKASjDZRaIlzaLjDk2fYNZ2Orft/Aa/qiWg204IlprBrkBnyRJY9VA==
X-Received: by 2002:a05:622a:f:b0:35b:a648:5871 with SMTP id x15-20020a05622a000f00b0035ba6485871mr20018051qtw.43.1663168008903;
        Wed, 14 Sep 2022 08:06:48 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s14-20020ac85ece000000b00339b8a5639csm1609245qtx.95.2022.09.14.08.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:06:48 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/17] btrfs: move btrfs on disk definitions out of ctree.h
Date:   Wed, 14 Sep 2022 11:06:28 -0400
Message-Id: <058e41f7732823196f030916c04134418688cbe9.1663167823.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663167823.git.josef@toxicpanda.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The bulk of our on-disk definitions exist in btrfs_tree.h, which user
space can use.  Keep things consistent and move the rest of the on disk
definitions out of ctree.h into btrfs_tree.h.  Note I did have to update
all u8's to __u8, but otherwise this is a strict copy and paste.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h                | 215 +-------------------------------
 include/uapi/linux/btrfs_tree.h | 213 +++++++++++++++++++++++++++++++
 2 files changed, 214 insertions(+), 214 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 5cf18a120dff..c3a8440d3223 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -50,8 +50,6 @@ struct btrfs_ref;
 struct btrfs_bio;
 struct btrfs_ioctl_encoded_io_args;
 
-#define BTRFS_MAGIC 0x4D5F53665248425FULL /* ascii _BHRfS_M, no null */
-
 /*
  * Maximum number of mirrors that can be available for all profiles counting
  * the target device of dev-replace as one. During an active device replace
@@ -63,8 +61,6 @@ struct btrfs_ioctl_encoded_io_args;
  */
 #define BTRFS_MAX_MIRRORS (4 + 1)
 
-#define BTRFS_MAX_LEVEL 8
-
 #define BTRFS_OLDEST_GENERATION	0ULL
 
 /*
@@ -133,81 +129,9 @@ enum {
 	BTRFS_FS_STATE_COUNT
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
 #define BTRFS_SUPER_INFO_OFFSET			SZ_64K
 #define BTRFS_SUPER_INFO_SIZE			4096
+static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 
 /*
  * The reserved space at the beginning of each device.
@@ -216,69 +140,6 @@ struct btrfs_root_backup {
  */
 #define BTRFS_DEVICE_RANGE_RESERVED			(SZ_1M)
 
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
-	/*
-	 * This member has never been utilized since the very beginning, thus
-	 * it's always 0 regardless of kernel version.  We always use
-	 * generation + 1 to read log tree root.  So here we mark it deprecated.
-	 */
-	__le64 __unused_log_root_transid;
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
-	u8 reserved8[8];
-	__le64 reserved[27];
-	u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
-	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
-
-	/* Padded to 4096 bytes */
-	u8 padding[565];
-} __attribute__ ((__packed__));
-static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
-
 /*
  * Compat flags that we support.  If any incompat flags are set other than the
  * ones specified below then we will fail to mount
@@ -336,43 +197,6 @@ static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
 #define BTRFS_FEATURE_INCOMPAT_SAFE_CLEAR		0ULL
 
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
 /* Read ahead values for struct btrfs_path.reada */
 enum {
 	READA_NONE,
@@ -1633,43 +1457,6 @@ do {									\
 #define btrfs_clear_pending(info, opt)	\
 	clear_bit(BTRFS_PENDING_##opt, &(info)->pending_changes)
 
-/*
- * Inode flags
- */
-#define BTRFS_INODE_NODATASUM		(1U << 0)
-#define BTRFS_INODE_NODATACOW		(1U << 1)
-#define BTRFS_INODE_READONLY		(1U << 2)
-#define BTRFS_INODE_NOCOMPRESS		(1U << 3)
-#define BTRFS_INODE_PREALLOC		(1U << 4)
-#define BTRFS_INODE_SYNC		(1U << 5)
-#define BTRFS_INODE_IMMUTABLE		(1U << 6)
-#define BTRFS_INODE_APPEND		(1U << 7)
-#define BTRFS_INODE_NODUMP		(1U << 8)
-#define BTRFS_INODE_NOATIME		(1U << 9)
-#define BTRFS_INODE_DIRSYNC		(1U << 10)
-#define BTRFS_INODE_COMPRESS		(1U << 11)
-
-#define BTRFS_INODE_ROOT_ITEM_INIT	(1U << 31)
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
-#define BTRFS_INODE_RO_VERITY		(1U << 0)
-
-#define BTRFS_INODE_RO_FLAG_MASK	(BTRFS_INODE_RO_VERITY)
-
 struct btrfs_map_token {
 	struct extent_buffer *eb;
 	char *kaddr;
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 1f7a38ec6ac3..e6bf902b9c92 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -10,6 +10,10 @@
 #include <stddef.h>
 #endif
 
+#define BTRFS_MAGIC 0x4D5F53665248425FULL /* ascii _BHRfS_M, no null */
+
+#define BTRFS_MAX_LEVEL 8
+
 /*
  * This header contains the structure definitions and constants used
  * by file system objects that can be retrieved using
@@ -360,6 +364,43 @@ enum btrfs_csum_type {
 #define BTRFS_FT_XATTR		8
 #define BTRFS_FT_MAX		9
 
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
 /*
  * The key defines the order in the tree, and so it also defines (optimal)
  * block layout.
@@ -389,6 +430,108 @@ struct btrfs_key {
 	__u64 offset;
 } __attribute__ ((__packed__));
 
+/*
+ * every tree block (leaf or node) starts with this header.
+ */
+struct btrfs_header {
+	/* these first four must match the super block */
+	__u8 csum[BTRFS_CSUM_SIZE];
+	__u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
+	__le64 bytenr; /* which block this node is supposed to live in */
+	__le64 flags;
+
+	/* allowed to be different from the super from here on down */
+	__u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
+	__le64 generation;
+	__le64 owner;
+	__le32 nritems;
+	__u8 level;
+} __attribute__ ((__packed__));
+
+/*
+ * this is a very generous portion of the super block, giving us
+ * room to translate 14 chunks with 3 stripes each.
+ */
+#define BTRFS_SYSTEM_CHUNK_ARRAY_SIZE 2048
+
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
 struct btrfs_dev_item {
 	/* the internal btrfs device id */
 	__le64 devid;
@@ -472,6 +615,68 @@ struct btrfs_chunk {
 	/* additional stripes go here */
 } __attribute__ ((__packed__));
 
+/*
+ * the super block basically lists the main trees of the FS
+ * it currently lacks any block count etc etc
+ */
+struct btrfs_super_block {
+	/* the first 4 fields must match struct btrfs_header */
+	__u8 csum[BTRFS_CSUM_SIZE];
+	/* FS specific UUID, visible to user */
+	__u8 fsid[BTRFS_FSID_SIZE];
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
+	/* the UUID written into btree blocks */
+	__u8 metadata_uuid[BTRFS_FSID_SIZE];
+
+	/* future expansion */
+	__u8 reserved8[8];
+	__le64 reserved[27];
+	__u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
+	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
+
+	/* Padded to 4096 bytes */
+	__u8 padding[565];
+} __attribute__ ((__packed__));
+
 #define BTRFS_FREE_SPACE_EXTENT	1
 #define BTRFS_FREE_SPACE_BITMAP	2
 
@@ -526,6 +731,14 @@ struct btrfs_extent_item_v0 {
 /* use full backrefs for extent pointers in the block */
 #define BTRFS_BLOCK_FLAG_FULL_BACKREF	(1ULL << 8)
 
+#define BTRFS_BACKREF_REV_MAX		256
+#define BTRFS_BACKREF_REV_SHIFT		56
+#define BTRFS_BACKREF_REV_MASK		(((u64)BTRFS_BACKREF_REV_MAX - 1) << \
+					 BTRFS_BACKREF_REV_SHIFT)
+
+#define BTRFS_OLD_BACKREF_REV		0
+#define BTRFS_MIXED_BACKREF_REV		1
+
 /*
  * this flag is only used internally by scrub and may be changed at any time
  * it is only declared here to avoid collisions
-- 
2.26.3

