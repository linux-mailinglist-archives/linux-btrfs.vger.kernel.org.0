Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A6C43920C
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 11:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhJYJLE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 05:11:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60656 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbhJYJLD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 05:11:03 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 99FEB2191E
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 09:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635152920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJcJI5vO5tSwhI0gM3VjtWKGBJ2Vx7UCoQzjTXPVsyM=;
        b=mU3Nxof8X2OnTtU/kL73E4Dg4uYXSIBlnYjHU92Zteq2f2s+w78m1FcSuGkBu5k8APJycb
        LrcbevCUbOiEk5ehf9eVeL5X5hTW/7BBoU/zpLczmc9Nn/eXejL3bOCplxhJxrKzrvAdfl
        Kt37bguWha/ShG9Zf615CVMOe0UDIjE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE5F413AAB
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 09:08:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gL+SLRd0dmHDPwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 09:08:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: move the remaining on-disk format to ondisk_format.h
Date:   Mon, 25 Oct 2021 17:08:19 +0800
Message-Id: <20211025090821.65646-2-wqu@suse.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025090821.65646-1-wqu@suse.com>
References: <20211025090821.65646-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are still some on-disk structures in ctree.h:

- btrfs_header
- btrfs_root_backup
- btrfs_super_block
- btrfs_item
- btrfs_leaf
- btrfs_key_ptr
- btrfs_node

Move the definition of them to a dedicated header, and add comment
explaining how btrfs ondisk schemas are split.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h         | 210 +-----------------------------------
 fs/btrfs/ondisk_format.h | 223 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 224 insertions(+), 209 deletions(-)
 create mode 100644 fs/btrfs/ondisk_format.h

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index dc6a6173a2c0..6d32ad7d9a8d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -20,7 +20,6 @@
 #include <asm/unaligned.h>
 #include <linux/pagemap.h>
 #include <linux/btrfs.h>
-#include <linux/btrfs_tree.h>
 #include <linux/workqueue.h>
 #include <linux/security.h>
 #include <linux/sizes.h>
@@ -28,6 +27,7 @@
 #include <linux/refcount.h>
 #include <linux/crc32c.h>
 #include <linux/iomap.h>
+#include "ondisk_format.h"
 #include "extent-io-tree.h"
 #include "extent_io.h"
 #include "extent_map.h"
@@ -50,8 +50,6 @@ struct btrfs_ordered_sum;
 struct btrfs_ref;
 struct btrfs_bio;
 
-#define BTRFS_MAGIC 0x4D5F53665248425FULL /* ascii _BHRfS_M, no null */
-
 /*
  * Maximum number of mirrors that can be available for all profiles counting
  * the target device of dev-replace as one. During an active device replace
@@ -145,212 +143,6 @@ enum {
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
-#define BTRFS_SUPER_INFO_OFFSET			SZ_64K
-#define BTRFS_SUPER_INFO_SIZE			4096
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
-
-	/* Padded to 4096 bytes */
-	u8 padding[565];
-} __attribute__ ((__packed__));
-static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
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
-	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID | \
-	 BTRFS_FEATURE_COMPAT_RO_VERITY)
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
-	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
-	 BTRFS_FEATURE_INCOMPAT_ZONED)
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
 /* Read ahead values for struct btrfs_path.reada */
 enum {
 	READA_NONE,
diff --git a/fs/btrfs/ondisk_format.h b/fs/btrfs/ondisk_format.h
new file mode 100644
index 000000000000..c3beff624691
--- /dev/null
+++ b/fs/btrfs/ondisk_format.h
@@ -0,0 +1,223 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_ONDISK_FORMAT_H
+#define BTRFS_ONDISK_FORMAT_H
+
+#include <linux/types.h>
+/*
+ * Most btrfs on-disk format is exposed through btrfs_tree.h uapi header
+ * already, as SEARCH_TREE ioctl can expose the tree directly to user space.
+ */
+#include <linux/btrfs_tree.h>
+
+/* Only structures not exposed through tree search ioctl are kept here. */
+
+#define BTRFS_MAGIC 0x4D5F53665248425FULL /* ascii _BHRfS_M, no null */
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
+#define BTRFS_SUPER_INFO_OFFSET			SZ_64K
+#define BTRFS_SUPER_INFO_SIZE			4096
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
+
+	/* Padded to 4096 bytes */
+	u8 padding[565];
+} __attribute__ ((__packed__));
+static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
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
+	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID | \
+	 BTRFS_FEATURE_COMPAT_RO_VERITY)
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
+	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
+	 BTRFS_FEATURE_INCOMPAT_ZONED)
+
+#define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
+	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
+#define BTRFS_FEATURE_INCOMPAT_SAFE_CLEAR		0ULL
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
+#endif
-- 
2.33.1

