Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6D5527727
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 May 2022 12:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbiEOKzZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 May 2022 06:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiEOKzX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 May 2022 06:55:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F4315804
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 03:55:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 65EE921DC9
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 10:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652612120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mF+oCE1wk3w/BNIpR4hdDkkJJNcXGFTsLvSVXkentdU=;
        b=lC5jB6VkL5QlI5c+zbpMl5ntSkzPmn3w0X/rYd1MryxvUNXmkjE6ILD9Gv4FnG3qgGvWuf
        lY+5URe8ME5o7zqPkTHjFhxHoksFYwoH0iHL6nZSboiW4UXdG5Ut33+2Ldpq3OBBGjZWk6
        EdwXkuStij1eSH98QUruBG1uISL2AOo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E2CF13491
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 10:55:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YKd5BhfcgGLsfQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 10:55:19 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs-progs: introduce the basic support for RAID56J feature
Date:   Sun, 15 May 2022 18:54:56 +0800
Message-Id: <c80eda7127082ae9eefc9ed3c8258fafff12e776.1652611957.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1652611957.git.wqu@suse.com>
References: <cover.1652611957.git.wqu@suse.com>
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

This patch will cross-port the RAID56J feature from the WIP kernel
patch to btrfs-progs, allowing us to create a fs with RAID56J.

The RAID56J feature itself is pretty much the same as regular RAID56,
with extra btrfs_chunk::per_dev_reserved bytes reserved for each stripe.

The reserved space will be used for write-ahead journal to address the
write-hole problem.

Thankfully for btrfs-progs, there isn't much need to fully implement the
journal yet.

This patch will just allow chunk allocation/deletion to take the extra
reservation into consideration.

And the new feature will only be enabled with experimental feature.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/common.h              |   6 ++-
 cmds/filesystem-usage.c     |   6 ++-
 cmds/rescue-chunk-recover.c |  13 +++--
 common/utils.c              |   6 ++-
 kernel-shared/ctree.h       |  42 +++++++++++++--
 kernel-shared/extent-tree.c |  18 +++++--
 kernel-shared/volumes.c     | 105 +++++++++++++++++++++++++++++++-----
 kernel-shared/volumes.h     |   2 +
 8 files changed, 162 insertions(+), 36 deletions(-)

diff --git a/check/common.h b/check/common.h
index ba4e291e8d0d..f6e6eece37aa 100644
--- a/check/common.h
+++ b/check/common.h
@@ -133,9 +133,11 @@ static inline int check_num_stripes(u64 type, int num_stripes)
 {
 	if (num_stripes == 0)
 		return -1;
-	if (type & BTRFS_BLOCK_GROUP_RAID5 && num_stripes <= 1)
+	if (type & (BTRFS_BLOCK_GROUP_RAID5 | BTRFS_BLOCK_GROUP_RAID5J) &&
+	    num_stripes <= 1)
 		return -1;
-	if (type & BTRFS_BLOCK_GROUP_RAID6 && num_stripes <= 2)
+	if (type & (BTRFS_BLOCK_GROUP_RAID6 | BTRFS_BLOCK_GROUP_RAID6J) &&
+	    num_stripes <= 2)
 		return -1;
 	return 0;
 }
diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 01729e1886ac..4bdb07eeba86 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -356,11 +356,13 @@ static void get_raid56_space_info(struct btrfs_ioctl_space_args *sargs,
 		double l_data_ratio, l_metadata_ratio, l_system_ratio, rt;
 
 		parities_count = btrfs_bg_type_to_nparity(info_ptr->type);
-		if (info_ptr->type & BTRFS_BLOCK_GROUP_RAID5) {
+		if ((BTRFS_BLOCK_GROUP_RAID5 | BTRFS_BLOCK_GROUP_RAID5J) &
+		    info_ptr->type) {
 			l_data_ratio = l_data_ratio_r5;
 			l_metadata_ratio = l_metadata_ratio_r5;
 			l_system_ratio = l_system_ratio_r5;
-		} else if (info_ptr->type & BTRFS_BLOCK_GROUP_RAID6) {
+		} else if ((BTRFS_BLOCK_GROUP_RAID6 | BTRFS_BLOCK_GROUP_RAID6J) &
+		    info_ptr->type) {
 			l_data_ratio = l_data_ratio_r6;
 			l_metadata_ratio = l_metadata_ratio_r6;
 			l_system_ratio = l_system_ratio_r6;
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index ec5c206f85e7..67a7bd595b5d 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -2093,8 +2093,8 @@ next_csum:
 
 	if (list_empty(&candidates)) {
 		num_unordered = count_devext_records(&unordered);
-		if (chunk->type_flags & BTRFS_BLOCK_GROUP_RAID6
-					&& num_unordered == 2) {
+		if ((BTRFS_BLOCK_GROUP_RAID6 | BTRFS_BLOCK_GROUP_RAID6J) &
+		    chunk->type && num_unordered == 2) {
 			btrfs_release_path(&path);
 			ret = fill_chunk_up(chunk, &unordered, rc);
 			return ret;
@@ -2139,12 +2139,11 @@ out:
 		if (ret)
 			goto fail_out;
 	} else {
-		if ((num_unordered == 2 && chunk->type_flags
-			& BTRFS_BLOCK_GROUP_RAID5)
-		 || (num_unordered == 3 && chunk->type_flags
-			& BTRFS_BLOCK_GROUP_RAID6)) {
+		if ((num_unordered == 2 && chunk->type_flags &
+		    (BTRFS_BLOCK_GROUP_RAID5 | BTRFS_BLOCK_GROUP_RAID5J))
+		 || (num_unordered == 3 && chunk->type_flags &
+		    (BTRFS_BLOCK_GROUP_RAID6 | BTRFS_BLOCK_GROUP_RAID6J)))
 			ret = fill_chunk_up(chunk, &unordered, rc);
-		}
 	}
 fail_out:
 	ret = !!ret || (list_empty(&unordered) ? 0 : 1);
diff --git a/common/utils.c b/common/utils.c
index 1ed5571f7c1c..e609cca50cde 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -602,10 +602,12 @@ int test_num_disk_vs_raid(u64 metadata_profile, u64 data_profile,
 		return 1;
 	}
 
-	if (dev_cnt == 3 && profile & BTRFS_BLOCK_GROUP_RAID6) {
+	if (dev_cnt == 3 && profile &
+	    (BTRFS_BLOCK_GROUP_RAID6 | BTRFS_BLOCK_GROUP_RAID6J)) {
 		warning("RAID6 is not recommended on filesystem with 3 devices only");
 	}
-	if (dev_cnt == 2 && profile & BTRFS_BLOCK_GROUP_RAID5) {
+	if (dev_cnt == 2 && profile &
+	    (BTRFS_BLOCK_GROUP_RAID5 | BTRFS_BLOCK_GROUP_RAID5J)) {
 		warning("RAID5 is not recommended on filesystem with 2 devices only");
 	}
 	warning_on(!mixed && (data_profile & BTRFS_BLOCK_GROUP_DUP) && ssd,
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 68943ff294cc..4ad7cd9948a2 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -266,6 +266,10 @@ struct btrfs_dev_item {
 
 struct btrfs_stripe {
 	__le64 devid;
+	/*
+	 * Where the real stripe starts on the device, excluding the per-dev
+	 * reserved bytes.
+	 */
 	__le64 offset;
 	u8 dev_uuid[BTRFS_UUID_SIZE];
 } __attribute__ ((__packed__));
@@ -280,8 +284,19 @@ struct btrfs_chunk {
 	__le64 stripe_len;
 	__le64 type;
 
-	/* optimal io alignment for this chunk */
-	__le32 io_align;
+	union {
+		/*
+		 * For non-journaled profiles, optimal io alignment for this
+		 * chunk, not really utilized though.
+		 */
+		__le32 io_align;
+
+		/*
+		 * For journaled profiles, per-device-extent reserved bytes
+		 * before the real data starts.
+		 */
+		__le32 per_dev_reserved;
+	};
 
 	/* optimal io width for this chunk */
 	__le32 io_width;
@@ -512,6 +527,7 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
+#define BTRFS_FEATURE_INCOMPAT_RAID56_JOURNAL	(1ULL << 14)
 
 #define BTRFS_FEATURE_COMPAT_SUPP		0ULL
 
@@ -539,7 +555,8 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 	 BTRFS_FEATURE_INCOMPAT_RAID1C34 |		\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID |		\
 	 BTRFS_FEATURE_INCOMPAT_ZONED |			\
-	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2 |	\
+	 BTRFS_FEATURE_INCOMPAT_RAID56_JOURNAL)
 #else
 #define BTRFS_FEATURE_INCOMPAT_SUPP			\
 	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
@@ -1017,6 +1034,8 @@ struct btrfs_csum_item {
 #define BTRFS_BLOCK_GROUP_RAID6    	(1ULL << 8)
 #define BTRFS_BLOCK_GROUP_RAID1C3    	(1ULL << 9)
 #define BTRFS_BLOCK_GROUP_RAID1C4    	(1ULL << 10)
+#define BTRFS_BLOCK_GROUP_RAID5J    	(1ULL << 11)
+#define BTRFS_BLOCK_GROUP_RAID6J    	(1ULL << 12)
 #define BTRFS_BLOCK_GROUP_RESERVED	(BTRFS_AVAIL_ALLOC_BIT_SINGLE | \
 					 BTRFS_SPACE_INFO_GLOBAL_RSV)
 
@@ -1030,6 +1049,8 @@ enum btrfs_raid_types {
 	BTRFS_RAID_RAID6,
 	BTRFS_RAID_RAID1C3,
 	BTRFS_RAID_RAID1C4,
+	BTRFS_RAID_RAID5J,
+	BTRFS_RAID_RAID6J,
 	BTRFS_NR_RAID_TYPES
 };
 
@@ -1041,13 +1062,20 @@ enum btrfs_raid_types {
 					 BTRFS_BLOCK_GROUP_RAID1 |   \
 					 BTRFS_BLOCK_GROUP_RAID5 |   \
 					 BTRFS_BLOCK_GROUP_RAID6 |   \
+					 BTRFS_BLOCK_GROUP_RAID5J |   \
+					 BTRFS_BLOCK_GROUP_RAID6J |   \
 					 BTRFS_BLOCK_GROUP_RAID1C3 | \
 					 BTRFS_BLOCK_GROUP_RAID1C4 | \
 					 BTRFS_BLOCK_GROUP_DUP |     \
 					 BTRFS_BLOCK_GROUP_RAID10)
 
-#define BTRFS_BLOCK_GROUP_RAID56_MASK	(BTRFS_BLOCK_GROUP_RAID5 |	\
-                                         BTRFS_BLOCK_GROUP_RAID6)
+#define BTRFS_BLOCK_GROUP_RAID56_MASK	(BTRFS_BLOCK_GROUP_RAID5  |	\
+					 BTRFS_BLOCK_GROUP_RAID5J |	\
+					 BTRFS_BLOCK_GROUP_RAID6  |	\
+                                         BTRFS_BLOCK_GROUP_RAID6J)
+
+#define BTRFS_BLOCK_GROUP_JOURNAL_MASK	(BTRFS_BLOCK_GROUP_RAID5J |	\
+                                         BTRFS_BLOCK_GROUP_RAID6J)
 
 #define BTRFS_BLOCK_GROUP_RAID1_MASK    (BTRFS_BLOCK_GROUP_RAID1 |	\
                                          BTRFS_BLOCK_GROUP_RAID1C3 |	\
@@ -1652,6 +1680,8 @@ BTRFS_SETGET_FUNCS(chunk_length, struct btrfs_chunk, length, 64);
 BTRFS_SETGET_FUNCS(chunk_owner, struct btrfs_chunk, owner, 64);
 BTRFS_SETGET_FUNCS(chunk_stripe_len, struct btrfs_chunk, stripe_len, 64);
 BTRFS_SETGET_FUNCS(chunk_io_align, struct btrfs_chunk, io_align, 32);
+BTRFS_SETGET_FUNCS(chunk_per_dev_reserved, struct btrfs_chunk, per_dev_reserved,
+		   32);
 BTRFS_SETGET_FUNCS(chunk_io_width, struct btrfs_chunk, io_width, 32);
 BTRFS_SETGET_FUNCS(chunk_sector_size, struct btrfs_chunk, sector_size, 32);
 BTRFS_SETGET_FUNCS(chunk_type, struct btrfs_chunk, type, 64);
@@ -1671,6 +1701,8 @@ BTRFS_SETGET_STACK_FUNCS(stack_chunk_stripe_len, struct btrfs_chunk,
 			 stripe_len, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_chunk_io_align, struct btrfs_chunk,
 			 io_align, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_chunk_per_dev_reserved, struct btrfs_chunk,
+			 per_dev_reserved, 32);
 BTRFS_SETGET_STACK_FUNCS(stack_chunk_io_width, struct btrfs_chunk,
 			 io_width, 32);
 BTRFS_SETGET_STACK_FUNCS(stack_chunk_sector_size, struct btrfs_chunk,
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 697a8a1e4dec..92655fe32fb0 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -3004,7 +3004,9 @@ static int free_chunk_dev_extent_items(struct btrfs_trans_handle *trans,
 	struct btrfs_root *root= fs_info->chunk_root;
 	struct btrfs_path *path;
 	struct btrfs_key key;
+	bool is_journal;
 	u16 num_stripes;
+	u32 per_dev_reserved = 0;
 	int i;
 	int ret;
 
@@ -3025,19 +3027,24 @@ static int free_chunk_dev_extent_items(struct btrfs_trans_handle *trans,
 	}
 	chunk = btrfs_item_ptr(path->nodes[0], path->slots[0],
 			       struct btrfs_chunk);
+	is_journal = btrfs_bg_type_is_journal(btrfs_chunk_type(path->nodes[0],
+					      chunk));
+	if (is_journal)
+		per_dev_reserved = btrfs_chunk_per_dev_reserved(path->nodes[0],
+								chunk);
 	num_stripes = btrfs_chunk_num_stripes(path->nodes[0], chunk);
 	for (i = 0; i < num_stripes; i++) {
 		u64 devid = btrfs_stripe_devid_nr(path->nodes[0], chunk, i);
 		u64 offset = btrfs_stripe_offset_nr(path->nodes[0], chunk, i);
 		u64 length = btrfs_stripe_length(fs_info, path->nodes[0], chunk);
 
+		ASSERT(offset > per_dev_reserved);
 		ret = btrfs_reset_chunk_zones(fs_info, devid, offset, length);
 		if (ret < 0)
 			goto out;
 
-		ret = free_dev_extent_item(trans, fs_info,
-			btrfs_stripe_devid_nr(path->nodes[0], chunk, i),
-			btrfs_stripe_offset_nr(path->nodes[0], chunk, i));
+		ret = free_dev_extent_item(trans, fs_info, devid,
+					   offset - per_dev_reserved);
 		if (ret < 0)
 			goto out;
 	}
@@ -3146,6 +3153,8 @@ static u64 get_dev_extent_len(struct map_lookup *map)
 		break;
 	case BTRFS_BLOCK_GROUP_RAID5:
 	case BTRFS_BLOCK_GROUP_RAID6:
+	case BTRFS_BLOCK_GROUP_RAID5J:
+	case BTRFS_BLOCK_GROUP_RAID6J:
 		div = map->num_stripes - btrfs_bg_type_to_nparity(map->type);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID10:
@@ -3198,7 +3207,8 @@ static int free_block_group_cache(struct btrfs_trans_handle *trans,
 		struct btrfs_device *device;
 
 		device = map->stripes[i].dev;
-		device->bytes_used -= get_dev_extent_len(map);
+		device->bytes_used -= get_dev_extent_len(map) +
+				      map->per_dev_reserved;
 		ret = btrfs_update_device(trans, device);
 		if (ret < 0)
 			goto out;
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 97c09a1a4931..e0f31d089707 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -33,6 +33,14 @@
 #include "common/device-utils.h"
 #include "kernel-lib/raid56.h"
 
+/*
+ * The extra space for journal based profiles (raid56j).
+ *
+ * Each device will have this amount of bytes reserved before the real
+ * stripe begins.
+ */
+#define JOURNAL_RESERVED		(SZ_1M)
+
 const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 	[BTRFS_RAID_RAID10] = {
 		.sub_stripes	= 2,
@@ -164,6 +172,34 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 		.bg_flag	= BTRFS_BLOCK_GROUP_RAID6,
 		.mindev_error	= BTRFS_ERROR_DEV_RAID6_MIN_NOT_MET,
 	},
+	[BTRFS_RAID_RAID5J] = {
+		.sub_stripes	= 1,
+		.dev_stripes	= 1,
+		.devs_max	= 0,
+		.devs_min	= 2,
+		.tolerated_failures = 1,
+		.devs_increment	= 1,
+		.ncopies	= 1,
+		.nparity        = 1,
+		.lower_name	= "raid5j",
+		.upper_name	= "RAID5J",
+		.bg_flag	= BTRFS_BLOCK_GROUP_RAID5J,
+		.mindev_error	= BTRFS_ERROR_DEV_RAID5_MIN_NOT_MET,
+	},
+	[BTRFS_RAID_RAID6J] = {
+		.sub_stripes	= 1,
+		.dev_stripes	= 1,
+		.devs_max	= 0,
+		.devs_min	= 3,
+		.tolerated_failures = 2,
+		.devs_increment	= 1,
+		.ncopies	= 1,
+		.nparity        = 2,
+		.lower_name	= "raid6j",
+		.upper_name	= "RAID6J",
+		.bg_flag	= BTRFS_BLOCK_GROUP_RAID6J,
+		.mindev_error	= BTRFS_ERROR_DEV_RAID6_MIN_NOT_MET,
+	},
 };
 
 struct alloc_chunk_ctl {
@@ -173,6 +209,8 @@ struct alloc_chunk_ctl {
 	int max_stripes;
 	int min_stripes;
 	int sub_stripes;
+	u32 per_dev_reserved;
+	/* This stripe_size is excluding above per_dev_reserved */
 	u64 stripe_size;
 	u64 min_stripe_size;
 	u64 num_bytes;
@@ -210,6 +248,10 @@ enum btrfs_raid_types btrfs_bg_flags_to_raid_index(u64 flags)
 		return BTRFS_RAID_RAID5;
 	else if (flags & BTRFS_BLOCK_GROUP_RAID6)
 		return BTRFS_RAID_RAID6;
+	if (flags & BTRFS_BLOCK_GROUP_RAID5J)
+		return BTRFS_RAID_RAID5J;
+	if (flags & BTRFS_BLOCK_GROUP_RAID6J)
+		return BTRFS_RAID_RAID6J;
 
 	return BTRFS_RAID_SINGLE; /* BTRFS_BLOCK_GROUP_SINGLE */
 }
@@ -270,6 +312,11 @@ bool btrfs_bg_type_is_stripey(u64 flags)
 	return btrfs_raid_array[index].devs_max == 0;
 }
 
+bool btrfs_bg_type_is_journal(u64 flags)
+{
+	return (flags & BTRFS_BLOCK_GROUP_JOURNAL_MASK);
+}
+
 u64 btrfs_bg_flags_for_device_num(int number)
 {
 	int i;
@@ -1256,6 +1303,7 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_info *info,
 				 struct alloc_chunk_ctl *ctl)
 {
 	enum btrfs_raid_types type = btrfs_bg_flags_to_raid_index(ctl->type);
+	bool is_journal = btrfs_bg_type_is_journal(ctl->type);
 
 	ctl->num_stripes = btrfs_raid_array[type].dev_stripes;
 	ctl->min_stripes = btrfs_raid_array[type].devs_min;
@@ -1268,6 +1316,10 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_info *info,
 	ctl->dev_offset = 0;
 	ctl->nparity = btrfs_raid_array[type].nparity;
 	ctl->ncopies = btrfs_raid_array[type].ncopies;
+	if (is_journal)
+		ctl->per_dev_reserved = JOURNAL_RESERVED;
+	else
+		ctl->per_dev_reserved = 0;
 
 	switch (info->fs_devices->chunk_alloc_policy) {
 	case BTRFS_CHUNK_ALLOC_REGULAR:
@@ -1293,6 +1345,8 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_info *info,
 	case BTRFS_RAID_RAID10:
 	case BTRFS_RAID_RAID5:
 	case BTRFS_RAID_RAID6:
+	case BTRFS_RAID_RAID5J:
+	case BTRFS_RAID_RAID6J:
 		ctl->num_stripes = min(ctl->max_stripes, ctl->total_devs);
 		if (type == BTRFS_RAID_RAID10)
 			ctl->num_stripes &= ~(u32)1;
@@ -1320,6 +1374,7 @@ static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl)
 
 static int decide_stripe_size_zoned(struct alloc_chunk_ctl *ctl)
 {
+	ASSERT(!btrfs_bg_type_is_journal(ctl->type));
 	if (chunk_bytes_by_type(ctl) > ctl->max_chunk_size) {
 		/* stripe_size is fixed in ZONED, reduce num_stripes instead */
 		ctl->num_stripes = ctl->max_chunk_size * ctl->ncopies /
@@ -1358,6 +1413,7 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 	int ret;
 	int index;
 	struct btrfs_key key;
+	bool is_journal = btrfs_bg_type_is_journal(ctl->type);
 	u64 offset;
 	u64 zone_size = info->zone_size;
 
@@ -1401,29 +1457,31 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 
 		if (!ctl->dev_offset) {
 			ret = btrfs_alloc_dev_extent(trans, device, key.offset,
-					ctl->stripe_size, &dev_offset);
+					ctl->stripe_size + ctl->per_dev_reserved,
+					&dev_offset);
 			if (ret < 0)
 				goto out_chunk_map;
 		} else {
-			dev_offset = ctl->dev_offset;
+			dev_offset = ctl->dev_offset - ctl->per_dev_reserved;
 			ret = btrfs_insert_dev_extent(trans, device, key.offset,
-						      ctl->stripe_size,
-						      ctl->dev_offset);
+					ctl->stripe_size + ctl->per_dev_reserved,
+					ctl->dev_offset);
 			BUG_ON(ret);
 		}
 
 		ASSERT(!zone_size || IS_ALIGNED(dev_offset, zone_size));
 
-		device->bytes_used += ctl->stripe_size;
+		device->bytes_used += ctl->stripe_size + ctl->per_dev_reserved;
 		ret = btrfs_update_device(trans, device);
 		if (ret < 0)
 			goto out_chunk_map;
 
 		map->stripes[index].dev = device;
-		map->stripes[index].physical = dev_offset;
+		map->stripes[index].physical = dev_offset + ctl->per_dev_reserved;
 		stripe = stripes + index;
 		btrfs_set_stack_stripe_devid(stripe, device->devid);
-		btrfs_set_stack_stripe_offset(stripe, dev_offset);
+		btrfs_set_stack_stripe_offset(stripe, dev_offset +
+						      ctl->per_dev_reserved);
 		memcpy(stripe->dev_uuid, device->uuid, BTRFS_UUID_SIZE);
 		index++;
 	}
@@ -1435,7 +1493,11 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_chunk_stripe_len(chunk, BTRFS_STRIPE_LEN);
 	btrfs_set_stack_chunk_type(chunk, ctl->type);
 	btrfs_set_stack_chunk_num_stripes(chunk, ctl->num_stripes);
-	btrfs_set_stack_chunk_io_align(chunk, BTRFS_STRIPE_LEN);
+	if (is_journal)
+		btrfs_set_stack_chunk_per_dev_reserved(chunk,
+				ctl->per_dev_reserved);
+	else
+		btrfs_set_stack_chunk_io_align(chunk, BTRFS_STRIPE_LEN);
 	btrfs_set_stack_chunk_io_width(chunk, BTRFS_STRIPE_LEN);
 	btrfs_set_stack_chunk_sector_size(chunk, info->sectorsize);
 	btrfs_set_stack_chunk_sub_stripes(chunk, ctl->sub_stripes);
@@ -1446,6 +1508,7 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 	map->type = ctl->type;
 	map->num_stripes = ctl->num_stripes;
 	map->sub_stripes = ctl->sub_stripes;
+	map->per_dev_reserved = ctl->per_dev_reserved;
 
 	ret = btrfs_insert_item(trans, chunk_root, &key, chunk,
 				btrfs_chunk_item_size(ctl->num_stripes));
@@ -1552,7 +1615,8 @@ again:
 			if (ctl.type & BTRFS_BLOCK_GROUP_DUP)
 				ctl.stripe_size = max_avail / 2;
 			else
-				ctl.stripe_size = max_avail;
+				ctl.stripe_size = max_avail -
+						  ctl.per_dev_reserved;
 			goto again;
 		}
 		return -ENOSPC;
@@ -1592,7 +1656,7 @@ int btrfs_alloc_data_chunk(struct btrfs_trans_handle *trans,
 	struct list_head *dev_list = &info->fs_devices->devices;
 	struct list_head private_devs;
 	struct btrfs_device *device;
-	struct alloc_chunk_ctl ctl;
+	struct alloc_chunk_ctl ctl = {0};
 
 	if (*start != round_down(*start, info->sectorsize)) {
 		error("DATA chunk start not sectorsize aligned: %llu",
@@ -1649,9 +1713,11 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 		ret = map->num_stripes;
 	else if (map->type & BTRFS_BLOCK_GROUP_RAID10)
 		ret = map->sub_stripes;
-	else if (map->type & BTRFS_BLOCK_GROUP_RAID5)
+	else if ((BTRFS_BLOCK_GROUP_RAID5 | BTRFS_BLOCK_GROUP_RAID5J) &
+		 map->type)
 		ret = 2;
-	else if (map->type & BTRFS_BLOCK_GROUP_RAID6)
+	else if ((BTRFS_BLOCK_GROUP_RAID6 | BTRFS_BLOCK_GROUP_RAID6J) &
+		 map->type)
 		ret = 3;
 	else
 		ret = 1;
@@ -1953,7 +2019,8 @@ again:
 					ce->start + (tmp + i) * map->stripe_len;
 
 			raid_map[(i+rot) % map->num_stripes] = BTRFS_RAID5_P_STRIPE;
-			if (map->type & BTRFS_BLOCK_GROUP_RAID6)
+			if (map->type & (BTRFS_BLOCK_GROUP_RAID6 |
+					 BTRFS_BLOCK_GROUP_RAID6J))
 				raid_map[(i+rot+1) % map->num_stripes] = BTRFS_RAID6_Q_STRIPE;
 
 			*length = map->stripe_len;
@@ -2235,6 +2302,7 @@ static int read_one_chunk(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
 	u64 length;
 	u64 devid;
 	u8 uuid[BTRFS_UUID_SIZE];
+	bool is_journal;
 	int num_stripes;
 	int ret;
 	int i;
@@ -2262,11 +2330,18 @@ static int read_one_chunk(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
 	if (!map)
 		return -ENOMEM;
 
+	is_journal = btrfs_bg_type_is_journal(btrfs_chunk_type(leaf, chunk));
 	map->ce.start = logical;
 	map->ce.size = length;
 	map->num_stripes = num_stripes;
 	map->io_width = btrfs_chunk_io_width(leaf, chunk);
-	map->io_align = btrfs_chunk_io_align(leaf, chunk);
+	if (is_journal) {
+		map->io_align = map->io_width;
+		map->per_dev_reserved = btrfs_chunk_per_dev_reserved(leaf, chunk);
+	} else {
+		map->io_align = btrfs_chunk_io_align(leaf, chunk);
+		map->per_dev_reserved = 0;
+	}
 	map->sector_size = btrfs_chunk_sector_size(leaf, chunk);
 	map->stripe_len = btrfs_chunk_stripe_len(leaf, chunk);
 	map->type = btrfs_chunk_type(leaf, chunk);
@@ -2772,6 +2847,8 @@ u64 btrfs_stripe_length(struct btrfs_fs_info *fs_info,
 		break;
 	case BTRFS_BLOCK_GROUP_RAID5:
 	case BTRFS_BLOCK_GROUP_RAID6:
+	case BTRFS_BLOCK_GROUP_RAID5J:
+	case BTRFS_BLOCK_GROUP_RAID6J:
 		stripe_len = chunk_len / (num_stripes - btrfs_bg_type_to_nparity(profile));
 		break;
 	case BTRFS_BLOCK_GROUP_RAID10:
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index 6e9103a933b7..e1bf0bbe2978 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -120,6 +120,7 @@ struct map_lookup {
 	int sector_size;
 	int num_stripes;
 	int sub_stripes;
+	u32 per_dev_reserved;
 	struct btrfs_bio_stripe stripes[];
 };
 
@@ -315,5 +316,6 @@ int btrfs_bg_type_to_nparity(u64 flags);
 int btrfs_bg_type_to_sub_stripes(u64 flags);
 u64 btrfs_bg_flags_for_device_num(int number);
 bool btrfs_bg_type_is_stripey(u64 flags);
+bool btrfs_bg_type_is_journal(u64 flags);
 
 #endif
-- 
2.36.1

