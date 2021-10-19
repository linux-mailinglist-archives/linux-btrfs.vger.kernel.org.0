Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665DF4334B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 13:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhJSLcA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 07:32:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42982 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhJSLb7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 07:31:59 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0C8D11FCB4
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 11:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634642986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uSO57RqobzLFZRllSnULyxAag8ppWw89QGqbJwpBEYw=;
        b=bPilrbgkqRKjaeHTdAKPnlVdgM4CM/bfzxbHfMOjG9QnU8C3KpnSVW8aMLGPVd8C4MfZBl
        f6wad/JXX1mBLOT3+26UaJpHi2mwnMCRk/77Qz5CZT/6J5kS9B7iJokzh6CpHD8tpiWt13
        bicS6HZYLI0QWPo26754yGR72ky6whA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6541A13E5F
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 11:29:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aHKwCymsbmGmcAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 11:29:45 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: move btrfs_super_block to uapi/linux/btrfs_tree.h
Date:   Tue, 19 Oct 2021 19:29:25 +0800
Message-Id: <20211019112925.71920-3-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019112925.71920-1-wqu@suse.com>
References: <20211019112925.71920-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Due to the fact that btrfs_tree.h contains all the info for
BTRFS_IOC_TREE_SEARCH, it's almost the perfect location of btrfs on-disk
schema.

So let's move struct btrfs_super_block to uapi/linux/btrfs_tree.h,
further reducing the size of ctree.h.

Also move btrfs_dev_item and btrfs_root_backup to btrfs_tree.h, as they
are included in btrfs_super_block.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h                | 139 --------------------------------
 include/uapi/linux/btrfs_tree.h | 135 +++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+), 139 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e05098ac0337..843b3fdf132e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -171,145 +171,6 @@ struct btrfs_header {
 	u8 level;
 } __attribute__ ((__packed__));
 
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
-
-	/* Padded to 4096 bytes */
-	u8 padding[565];
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
 /*
  * A leaf is full of items. offset and size tell us where to find
  * the item in the leaf (relative to the start of the data area)
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index e1c4c732aaba..4770d12d4888 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -483,6 +483,53 @@ struct btrfs_free_space_header {
 	__le64 num_bitmaps;
 } __attribute__ ((__packed__));
 
+/*
+ * This is a very generous portion of the super block, giving us
+ * room to translate 14 chunks with 3 stripes each.
+ */
+#define BTRFS_SYSTEM_CHUNK_ARRAY_SIZE 2048
+
+/*
+ * Just in case we somehow lose the roots and are not able to mount,
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
 #define BTRFS_HEADER_FLAG_WRITTEN	(1ULL << 0)
 #define BTRFS_HEADER_FLAG_RELOC		(1ULL << 1)
 
@@ -496,6 +543,94 @@ struct btrfs_free_space_header {
 #define BTRFS_SUPER_FLAG_CHANGING_FSID	(1ULL << 35)
 #define BTRFS_SUPER_FLAG_CHANGING_FSID_V2 (1ULL << 36)
 
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
+/* The super block basically lists the main trees of the FS */
+struct btrfs_super_block {
+	u8 csum[BTRFS_CSUM_SIZE];
+	/* FS specific UUID, visible to user */
+	u8 fsid[BTRFS_FSID_SIZE];
+
+	/* Physical bytenr of this super block */
+	__le64 bytenr;
+
+	/* Valid bits are (BTRFS_SUPER_FLAG_* | BTRFS_HEADER_FLAG_WRITTEN) */
+	__le64 flags;
+	__le64 magic;
+	__le64 generation;
+	/* All bytenr used in root and *_root are logical bytenr */
+	__le64 root;
+	__le64 chunk_root;
+	__le64 log_root;
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
+	/* The UUID written into btree blocks */
+	u8 metadata_uuid[BTRFS_FSID_SIZE];
+
+	/* Future expansion */
+	__le64 reserved[28];
+	u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
+	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
+
+	/* Padded to 4096 bytes */
+	u8 padding[565];
+} __attribute__ ((__packed__));
 
 /*
  * items in the extent btree are used to record the objectid of the
-- 
2.33.0

