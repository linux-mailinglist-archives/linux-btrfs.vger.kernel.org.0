Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A41D566449
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 09:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiGEHiR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 03:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiGEHiK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 03:38:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CB413D2B
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 00:38:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E00571FAC9
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657006688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gRAtAPQK/ZYiUZDC2g+a+AvNRcbmZNqcqUWMf97yVF8=;
        b=InrA8atvt9uhRFUPfthCQL8uSVg01bjJ0DtGO2MP5+aWfooXeERlaWs8psJI8EEanwxmI5
        udhcPzljT64R5PjaTF7x4CW1a0WmThjd6FjW61jF0Jjiwsm2UsdcQ4IxBKuZQQ+Gb37V+d
        s8Hk5IT2ex8h98fcJiDH5iaGDivwUy4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45DAA1339A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:38:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eIadJ1/qw2JTOwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Jul 2022 07:38:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/8] btrfs-progs: introduce a new compat RO flag, EXTRA_SUPER_RESERVED
Date:   Tue,  5 Jul 2022 15:37:40 +0800
Message-Id: <ac2fe89eba762ec9ddf3dfe9bab236e78afc758f.1657006141.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657006141.git.wqu@suse.com>
References: <cover.1657006141.git.wqu@suse.com>
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

This new compat RO flag allows btrfs to reserve extra space other than
the default 1MiB at the beginning of each device.

Currently the new RO flag will enable the new super block member,
reserved_bytes, to be utilized for chunk allocation, to avoid the
specified byte range.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/ctree.h   | 24 ++++++++++++++++++++++--
 kernel-shared/disk-io.c |  9 +++++++++
 kernel-shared/volumes.c |  4 ++++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index fc8b61eda829..eb49aa8da919 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -466,8 +466,15 @@ struct btrfs_super_block {
 	__le64 reserved[24];
 	u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
 	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
+
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
 BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 
@@ -485,6 +492,16 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
  */
 #define BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID	(1ULL << 1)
 
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
@@ -514,7 +531,8 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
  */
 #define BTRFS_FEATURE_COMPAT_RO_SUPP			\
 	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
-	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID)
+	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID |\
+	 BTRFS_FEATURE_COMPAT_RO_EXTRA_SUPER_RESERVED)
 
 #if EXPERIMENTAL
 #define BTRFS_FEATURE_INCOMPAT_SUPP			\
@@ -2374,6 +2392,8 @@ BTRFS_SETGET_STACK_FUNCS(super_block_group_root_level,
 			 struct btrfs_super_block, block_group_root_level, 8);
 BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_block,
 			 nr_global_roots, 64);
+BTRFS_SETGET_STACK_FUNCS(super_reserved_bytes, struct btrfs_super_block,
+			 reserved_bytes, 32);
 
 static inline unsigned long btrfs_leaf_data(struct extent_buffer *l)
 {
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 26b1c9aa192a..bf3ea5e63165 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1848,6 +1848,15 @@ int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
 		}
 	}
 
+	if (btrfs_super_compat_ro_flags(sb) &
+	    BTRFS_FEATURE_COMPAT_RO_EXTRA_SUPER_RESERVED &&
+	    btrfs_super_reserved_bytes(sb) < BTRFS_BLOCK_RESERVED_1M_FOR_SUPER) {
+		error("reserved bytes invalid, has %u expect >= %llu",
+			btrfs_super_reserved_bytes(sb),
+			BTRFS_BLOCK_RESERVED_1M_FOR_SUPER);
+		goto error_out;
+	}
+
 	if (btrfs_super_incompat_flags(sb) & BTRFS_FEATURE_INCOMPAT_METADATA_UUID)
 		metadata_uuid = sb->metadata_uuid;
 	else
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 40032a4b4059..58254c9df5e1 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -562,10 +562,14 @@ int btrfs_scan_one_device(int fd, const char *path,
 
 static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
 {
+	struct btrfs_fs_info *fs_info = device->fs_info;
 	u64 zone_size;
 
 	switch (device->fs_devices->chunk_alloc_policy) {
 	case BTRFS_CHUNK_ALLOC_REGULAR:
+		if (btrfs_fs_compat_ro(fs_info, EXTRA_SUPER_RESERVED))
+			return max_t(u64, start,
+				btrfs_super_reserved_bytes(fs_info->super_copy));
 		/*
 		 * We don't want to overwrite the superblock on the drive nor
 		 * any area used by the boot loader (grub for example), so we
-- 
2.36.1

