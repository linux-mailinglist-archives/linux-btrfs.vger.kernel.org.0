Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1330E56643D
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 09:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiGEHjk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 03:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiGEHjg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 03:39:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBF313D1C
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 00:39:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7F359224BB
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657006773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bbuz35aYGGlIOmXJlPgihigDXD7+a/SPH0Ikalhnhtw=;
        b=jWi1Zdwez4NMS1xiua/uy1TZqC3d5X/GONB/niC65dVYIScDwy3as7AVK32qvmtBgBrsUz
        Fcj/sO83gg8oCLKVjNed0WLnuw6LlKiRg5XL/pTvEmnpGQ72+5muIpEENMCSXZL6bCcX8u
        9jBQ4aaje5+elt6CzRrHBxCWWKa8ANo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D18701339A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:39:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8O+jJrTqw2L6OwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Jul 2022 07:39:32 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 01/11] btrfs: introduce new compat RO flag, EXTRA_SUPER_RESERVED
Date:   Tue,  5 Jul 2022 15:39:03 +0800
Message-Id: <67f49ace41bb92c4ed0ad663c553e96d56acf5af.1657004556.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657004556.git.wqu@suse.com>
References: <cover.1657004556.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From the beginning of btrfs kernel module, kernel will avoid allocating
dev extents into the first 1MiB of each device, not only for the
superblock at 64KiB, but also for legacy bootloaders to store their
data.

Here for later expansion, we introduce a new compat RO flag,
EXTRA_SUPER_RESERVED, this allows btrfs to have extra reserved space
beyond the default 1MiB.

The extra reserved space can be utilized by things like write-intent
log.

Several new checks are introduced:

- No super_reserved_bytes should be smaller than the old 1MiB limit
- No zoned device support
  Such reserved space will be utilized in a no COW way, thus it can
  not be supported by zoned device.

We still allow dev extents to exist in the new reserved_bytes range,
this is to allow btrfstune to set reserved_bytes, then rely on kernel
balance to reserve the new space.

But later, if there is any feature relying on the reserved_bytes, we
will disable those features automatically.

There is a special catch, the new member @reserved_bytes is located at
the end of the superblock, to utilize the padding bytes.

The reason is, due to some undetermined extent tree v2 on-disk format
mess, we don't have reliable location inside the reserved8[] array.
I just want a stable location undisturbed.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h           | 14 +++++++++++---
 fs/btrfs/disk-io.c         |  9 +++++++++
 fs/btrfs/sysfs.c           |  2 ++
 fs/btrfs/volumes.c         | 22 ++++++++++++++++++----
 fs/btrfs/zoned.c           |  8 ++++++++
 include/uapi/linux/btrfs.h | 10 ++++++++++
 6 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4e2569f84aab..12019904f1cf 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -293,14 +293,19 @@ struct btrfs_super_block {
 	__le64 block_group_root_generation;
 	u8 block_group_root_level;
 
-	/* future expansion */
 	u8 reserved8[7];
 	__le64 reserved[25];
 	u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
 	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
 
+	/*
+	 * How many bytes are reserved at the beginning of a device.
+	 * Should be >= BTRFS_DEFAULT_RESERVED.
+	 */
+	__le32 reserved_bytes;
+
 	/* Padded to 4096 bytes */
-	u8 padding[565];
+	u8 padding[561];
 } __attribute__ ((__packed__));
 static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 
@@ -315,7 +320,8 @@ static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 #define BTRFS_FEATURE_COMPAT_RO_SUPP			\
 	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
 	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID | \
-	 BTRFS_FEATURE_COMPAT_RO_VERITY)
+	 BTRFS_FEATURE_COMPAT_RO_VERITY |		\
+	 BTRFS_FEATURE_COMPAT_RO_EXTRA_SUPER_RESERVED)
 
 #define BTRFS_FEATURE_COMPAT_RO_SAFE_SET	0ULL
 #define BTRFS_FEATURE_COMPAT_RO_SAFE_CLEAR	0ULL
@@ -2539,6 +2545,8 @@ BTRFS_SETGET_STACK_FUNCS(super_block_group_root_generation,
 			 block_group_root_generation, 64);
 BTRFS_SETGET_STACK_FUNCS(super_block_group_root_level, struct btrfs_super_block,
 			 block_group_root_level, 8);
+BTRFS_SETGET_STACK_FUNCS(super_reserved_bytes, struct btrfs_super_block,
+			 reserved_bytes, 32);
 
 int btrfs_super_csum_size(const struct btrfs_super_block *s);
 const char *btrfs_super_csum_name(u16 csum_type);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 70b388de4d66..1df2da2509ca 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2822,6 +2822,15 @@ static int validate_super(struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 	}
 
+	if (btrfs_super_compat_ro_flags(sb) &
+	    BTRFS_FEATURE_COMPAT_RO_EXTRA_SUPER_RESERVED &&
+	    btrfs_super_reserved_bytes(sb) < BTRFS_DEVICE_RANGE_RESERVED) {
+		btrfs_err(fs_info,
+"EXTRA_SUPER_RESERVED feature enabled, but reserved space is smaller than default (%u)",
+			    BTRFS_DEVICE_RANGE_RESERVED);
+		ret = -EINVAL;
+	}
+
 	/*
 	 * The generation is a global counter, we'll trust it more than the others
 	 * but it's still possible that it's the one that's wrong.
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index d5d0717fd09a..7fd38539315f 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -287,6 +287,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
 BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
+BTRFS_FEAT_ATTR_COMPAT_RO(extra_super_reserved, EXTRA_SUPER_RESERVED);
 #ifdef CONFIG_BLK_DEV_ZONED
 BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
 #endif
@@ -317,6 +318,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
 	BTRFS_FEAT_ATTR_PTR(free_space_tree),
 	BTRFS_FEAT_ATTR_PTR(raid1c34),
+	BTRFS_FEAT_ATTR_PTR(extra_super_reserved),
 #ifdef CONFIG_BLK_DEV_ZONED
 	BTRFS_FEAT_ATTR_PTR(zoned),
 #endif
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2d788a351c1f..2a4ac905e39f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1401,8 +1401,13 @@ static bool contains_pending_extent(struct btrfs_device *device, u64 *start,
 
 static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
 {
+	struct btrfs_fs_info *fs_info = device->fs_devices->fs_info;
+
 	switch (device->fs_devices->chunk_alloc_policy) {
 	case BTRFS_CHUNK_ALLOC_REGULAR:
+		if (btrfs_fs_compat_ro(fs_info, EXTRA_SUPER_RESERVED))
+			return max_t(u64, start,
+				btrfs_super_reserved_bytes(fs_info->super_copy));
 		return max_t(u64, start, BTRFS_DEVICE_RANGE_RESERVED);
 	case BTRFS_CHUNK_ALLOC_ZONED:
 		/*
@@ -7969,11 +7974,14 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 	struct extent_map *em;
 	struct map_lookup *map;
 	struct btrfs_device *dev;
+	u32 super_reserved = BTRFS_DEVICE_RANGE_RESERVED;
 	u64 stripe_len;
 	bool found = false;
 	int ret = 0;
 	int i;
 
+	if (btrfs_fs_compat_ro(fs_info, EXTRA_SUPER_RESERVED))
+		super_reserved = btrfs_super_reserved_bytes(fs_info->super_copy);
 	read_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, chunk_offset, 1);
 	read_unlock(&em_tree->lock);
@@ -7998,11 +8006,17 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 	}
 
 	/*
-	 * Very old mkfs.btrfs (before v4.1) will not respect the reserved
-	 * space. Although kernel can handle it without problem, better to warn
-	 * the users.
+	 * This can be caused by two cases:
+	 * - Very old mkfs.btrfs (before v4.1) and no balance at all
+	 *   This should be pretty rare now, as balance will relocate
+	 *   those dev extents in reserved range.
+	 *
+	 * - Newly set btrfs_super_block::reserved_bytes
+	 *   We are rely on this mount to relocate those dev extents.
+	 *
+	 * So here, we just give a warning and continue the mount.
 	 */
-	if (physical_offset < BTRFS_DEVICE_RANGE_RESERVED)
+	if (physical_offset < super_reserved)
 		btrfs_warn(fs_info,
 		"devid %llu physical %llu len %llu inside the reserved space",
 			   devid, physical_offset, physical_len);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 7a0f8fa44800..ec16c0a6fb22 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -703,6 +703,14 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	if (incompat_zoned && btrfs_fs_compat_ro(fs_info, EXTRA_SUPER_RESERVED)) {
+		btrfs_err(fs_info,
+			"zoned: incompatible optional feature detected: 0x%llx",
+			BTRFS_FEATURE_COMPAT_RO_EXTRA_SUPER_RESERVED);
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/*
 	 * stripe_size is always aligned to BTRFS_STRIPE_LEN in
 	 * btrfs_create_chunk(). Since we want stripe_len == zone_size,
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index f54dc91e4025..4a0c9f4f55d1 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -290,6 +290,16 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID	(1ULL << 1)
 #define BTRFS_FEATURE_COMPAT_RO_VERITY			(1ULL << 2)
 
+/*
+ * Allow btrfs to have extra reserved space (other than the default 1MiB) at
+ * the beginning of each device.
+ *
+ * This feature will enable the usage of btrfs_super_block::reserved_bytes.
+ *
+ * This feature would only be available for non-zoned filesystems.
+ */
+#define BTRFS_FEATURE_COMPAT_RO_EXTRA_SUPER_RESERVED	(1ULL << 3)
+
 #define BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF	(1ULL << 0)
 #define BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL	(1ULL << 1)
 #define BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS	(1ULL << 2)
-- 
2.36.1

