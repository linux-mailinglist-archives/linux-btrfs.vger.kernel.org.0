Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 059C63B509
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2019 14:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389855AbfFJM3L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jun 2019 08:29:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:46920 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389471AbfFJM3L (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jun 2019 08:29:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8E0C4AE48
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2019 12:29:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E477EDA867; Mon, 10 Jun 2019 14:29:58 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs-progs: add support for raid1c3 and raid1c4
Date:   Mon, 10 Jun 2019 14:29:58 +0200
Message-Id: <20190610122958.15595-1-dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559917235.git.dsterba@suse.com>
References: <cover.1559917235.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

$ ./mkfs.btrfs -m raid1c4 -d raid1c3 /dev/sd[abcd]

Label:              (null)
UUID:               f1f988ab-6750-4bc2-957b-98a4ebe98631
Node size:          16384
Sector size:        4096
Filesystem size:    8.00GiB
Block group profiles:
  Data:             RAID1C3         273.06MiB
  Metadata:         RAID1C4         204.75MiB
  System:           RAID1C4           8.00MiB
SSD detected:       no
Incompat features:  extref, skinny-metadata, raid1c34
Number of devices:  4
Devices:
   ID        SIZE  PATH
    1     2.00GiB  /dev/sda
    2     2.00GiB  /dev/sdb
    3     2.00GiB  /dev/sdc
    4     2.00GiB  /dev/sdd

Signed-off-by: David Sterba <dsterba@suse.com>
---
 chunk-recover.c           |  4 ++++
 cmds-balance.c            |  4 ++++
 cmds-fi-usage.c           |  8 +++++++
 cmds-inspect-dump-super.c |  3 ++-
 ctree.h                   |  8 +++++++
 extent-tree.c             |  4 ++++
 fsfeatures.c              |  6 +++++
 ioctl.h                   |  4 +++-
 mkfs/main.c               | 11 ++++++++-
 print-tree.c              |  6 +++++
 utils.c                   | 12 +++++++++-
 volumes.c                 | 48 +++++++++++++++++++++++++++++++++++++--
 volumes.h                 |  4 ++++
 13 files changed, 116 insertions(+), 6 deletions(-)

diff --git a/chunk-recover.c b/chunk-recover.c
index f3e7774efc0f..005032961e71 100644
--- a/chunk-recover.c
+++ b/chunk-recover.c
@@ -1579,6 +1579,10 @@ static int calc_num_stripes(u64 type)
 	else if (type & (BTRFS_BLOCK_GROUP_RAID1 |
 			 BTRFS_BLOCK_GROUP_DUP))
 		return 2;
+	else if (type & (BTRFS_BLOCK_GROUP_RAID1C3))
+		return 3;
+	else if (type & (BTRFS_BLOCK_GROUP_RAID1C4))
+		return 4;
 	else
 		return 1;
 }
diff --git a/cmds-balance.c b/cmds-balance.c
index b533cf737584..854d7d4c380a 100644
--- a/cmds-balance.c
+++ b/cmds-balance.c
@@ -46,6 +46,10 @@ static int parse_one_profile(const char *profile, u64 *flags)
 		*flags |= BTRFS_BLOCK_GROUP_RAID0;
 	} else if (!strcmp(profile, "raid1")) {
 		*flags |= BTRFS_BLOCK_GROUP_RAID1;
+	} else if (!strcmp(profile, "raid1c3")) {
+		*flags |= BTRFS_BLOCK_GROUP_RAID1C3;
+	} else if (!strcmp(profile, "raid1c4")) {
+		*flags |= BTRFS_BLOCK_GROUP_RAID1C4;
 	} else if (!strcmp(profile, "raid10")) {
 		*flags |= BTRFS_BLOCK_GROUP_RAID10;
 	} else if (!strcmp(profile, "raid5")) {
diff --git a/cmds-fi-usage.c b/cmds-fi-usage.c
index 9a23e17633d4..6bae4e723daf 100644
--- a/cmds-fi-usage.c
+++ b/cmds-fi-usage.c
@@ -373,6 +373,10 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 			ratio = 1;
 		else if (flags & BTRFS_BLOCK_GROUP_RAID1)
 			ratio = 2;
+		else if (flags & BTRFS_BLOCK_GROUP_RAID1C3)
+			ratio = 3;
+		else if (flags & BTRFS_BLOCK_GROUP_RAID1C4)
+			ratio = 4;
 		else if (flags & BTRFS_BLOCK_GROUP_RAID5)
 			ratio = 0;
 		else if (flags & BTRFS_BLOCK_GROUP_RAID6)
@@ -653,6 +657,10 @@ static u64 calc_chunk_size(struct chunk_info *ci)
 		return ci->size / ci->num_stripes;
 	else if (ci->type & BTRFS_BLOCK_GROUP_RAID1)
 		return ci->size ;
+	else if (ci->type & BTRFS_BLOCK_GROUP_RAID1C3)
+		return ci->size;
+	else if (ci->type & BTRFS_BLOCK_GROUP_RAID1C4)
+		return ci->size;
 	else if (ci->type & BTRFS_BLOCK_GROUP_DUP)
 		return ci->size ;
 	else if (ci->type & BTRFS_BLOCK_GROUP_RAID5)
diff --git a/cmds-inspect-dump-super.c b/cmds-inspect-dump-super.c
index d62f0932556c..bf9539df0dd5 100644
--- a/cmds-inspect-dump-super.c
+++ b/cmds-inspect-dump-super.c
@@ -229,7 +229,8 @@ static struct readable_flag_entry incompat_flags_array[] = {
 	DEF_INCOMPAT_FLAG_ENTRY(RAID56),
 	DEF_INCOMPAT_FLAG_ENTRY(SKINNY_METADATA),
 	DEF_INCOMPAT_FLAG_ENTRY(NO_HOLES),
-	DEF_INCOMPAT_FLAG_ENTRY(METADATA_UUID)
+	DEF_INCOMPAT_FLAG_ENTRY(METADATA_UUID),
+	DEF_INCOMPAT_FLAG_ENTRY(RAID1C34),
 };
 static const int incompat_flags_num = sizeof(incompat_flags_array) /
 				      sizeof(struct readable_flag_entry);
diff --git a/ctree.h b/ctree.h
index 9156ca4de6fd..87f586991648 100644
--- a/ctree.h
+++ b/ctree.h
@@ -490,6 +490,7 @@ struct btrfs_super_block {
 #define BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA	(1ULL << 8)
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID    (1ULL << 10)
+#define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 
 #define BTRFS_FEATURE_COMPAT_SUPP		0ULL
 
@@ -513,6 +514,7 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS |		\
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES |		\
+	 BTRFS_FEATURE_INCOMPAT_RAID1C34 |		\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID)
 
 /*
@@ -962,6 +964,8 @@ struct btrfs_csum_item {
 #define BTRFS_BLOCK_GROUP_RAID10	(1ULL << 6)
 #define BTRFS_BLOCK_GROUP_RAID5    	(1ULL << 7)
 #define BTRFS_BLOCK_GROUP_RAID6    	(1ULL << 8)
+#define BTRFS_BLOCK_GROUP_RAID1C3    	(1ULL << 9)
+#define BTRFS_BLOCK_GROUP_RAID1C4    	(1ULL << 10)
 #define BTRFS_BLOCK_GROUP_RESERVED	BTRFS_AVAIL_ALLOC_BIT_SINGLE
 
 enum btrfs_raid_types {
@@ -972,6 +976,8 @@ enum btrfs_raid_types {
 	BTRFS_RAID_SINGLE,
 	BTRFS_RAID_RAID5,
 	BTRFS_RAID_RAID6,
+	BTRFS_RAID_RAID1C3,
+	BTRFS_RAID_RAID1C4,
 	BTRFS_NR_RAID_TYPES
 };
 
@@ -983,6 +989,8 @@ enum btrfs_raid_types {
 					 BTRFS_BLOCK_GROUP_RAID1 |   \
 					 BTRFS_BLOCK_GROUP_RAID5 |   \
 					 BTRFS_BLOCK_GROUP_RAID6 |   \
+					 BTRFS_BLOCK_GROUP_RAID1C3 | \
+					 BTRFS_BLOCK_GROUP_RAID1C4 | \
 					 BTRFS_BLOCK_GROUP_DUP |     \
 					 BTRFS_BLOCK_GROUP_RAID10)
 
diff --git a/extent-tree.c b/extent-tree.c
index c6516b2ba445..50a38a775147 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -1668,6 +1668,8 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
 {
 	u64 extra_flags = flags & (BTRFS_BLOCK_GROUP_RAID0 |
 				   BTRFS_BLOCK_GROUP_RAID1 |
+				   BTRFS_BLOCK_GROUP_RAID1C3 |
+				   BTRFS_BLOCK_GROUP_RAID1C4 |
 				   BTRFS_BLOCK_GROUP_RAID10 |
 				   BTRFS_BLOCK_GROUP_RAID5 |
 				   BTRFS_BLOCK_GROUP_RAID6 |
@@ -3339,6 +3341,8 @@ static u64 get_dev_extent_len(struct map_lookup *map)
 	case 0: /* Single */
 	case BTRFS_BLOCK_GROUP_DUP:
 	case BTRFS_BLOCK_GROUP_RAID1:
+	case BTRFS_BLOCK_GROUP_RAID1C3:
+	case BTRFS_BLOCK_GROUP_RAID1C4:
 		div = 1;
 		break;
 	case BTRFS_BLOCK_GROUP_RAID5:
diff --git a/fsfeatures.c b/fsfeatures.c
index 7f3ef03b8452..e3b3d63b43a5 100644
--- a/fsfeatures.c
+++ b/fsfeatures.c
@@ -86,6 +86,12 @@ static const struct btrfs_fs_feature {
 		VERSION_TO_STRING2(4,0),
 		NULL, 0,
 		"no explicit hole extents for files" },
+	{ "raid1c34", BTRFS_FEATURE_INCOMPAT_RAID1C34,
+		"raid1c34",
+		VERSION_TO_STRING2(5,3),
+		NULL, 0,
+		NULL, 0,
+		"RAID1 with 3 or 4 copies" },
 	/* Keep this one last */
 	{ "list-all", BTRFS_FEATURE_LIST_ALL, NULL }
 };
diff --git a/ioctl.h b/ioctl.h
index 66ee599f7a82..d3dfd6375de1 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -775,7 +775,9 @@ enum btrfs_err_code {
 	BTRFS_ERROR_DEV_TGT_REPLACE,
 	BTRFS_ERROR_DEV_MISSING_NOT_FOUND,
 	BTRFS_ERROR_DEV_ONLY_WRITABLE,
-	BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS
+	BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS,
+	BTRFS_ERROR_DEV_RAID1C3_MIN_NOT_MET,
+	BTRFS_ERROR_DEV_RAID1C4_MIN_NOT_MET,
 };
 
 /* An error code to error string mapping for the kernel
diff --git a/mkfs/main.c b/mkfs/main.c
index 6b47a9ee0e73..88801b89e827 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -316,7 +316,7 @@ static void print_usage(int ret)
 	printf("Usage: mkfs.btrfs [options] dev [ dev ... ]\n");
 	printf("Options:\n");
 	printf("  allocation profiles:\n");
-	printf("\t-d|--data PROFILE       data profile, raid0, raid1, raid5, raid6, raid10, dup or single\n");
+	printf("\t-d|--data PROFILE       data profile, raid0, raid1, raid1c3, raid1c4, raid5, raid6, raid10, dup or single\n");
 	printf("\t-m|--metadata PROFILE   metadata profile, values like for data profile\n");
 	printf("\t-M|--mixed              mix metadata and data together\n");
 	printf("  features:\n");
@@ -347,6 +347,10 @@ static u64 parse_profile(const char *s)
 		return BTRFS_BLOCK_GROUP_RAID0;
 	} else if (strcasecmp(s, "raid1") == 0) {
 		return BTRFS_BLOCK_GROUP_RAID1;
+	} else if (strcasecmp(s, "raid1c3") == 0) {
+		return BTRFS_BLOCK_GROUP_RAID1C3;
+	} else if (strcasecmp(s, "raid1c4") == 0) {
+		return BTRFS_BLOCK_GROUP_RAID1C4;
 	} else if (strcasecmp(s, "raid5") == 0) {
 		return BTRFS_BLOCK_GROUP_RAID5;
 	} else if (strcasecmp(s, "raid6") == 0) {
@@ -1022,6 +1026,11 @@ int main(int argc, char **argv)
 		features |= BTRFS_FEATURE_INCOMPAT_RAID56;
 	}
 
+	if ((data_profile | metadata_profile) &
+	    (BTRFS_BLOCK_GROUP_RAID1C3 | BTRFS_BLOCK_GROUP_RAID1C4)) {
+		features |= BTRFS_FEATURE_INCOMPAT_RAID1C34;
+	}
+
 	if (btrfs_check_nodesize(nodesize, sectorsize,
 				 features))
 		goto error;
diff --git a/print-tree.c b/print-tree.c
index 0d0bb5109207..78931d2d8eb1 100644
--- a/print-tree.c
+++ b/print-tree.c
@@ -163,6 +163,12 @@ static void bg_flags_to_str(u64 flags, char *ret)
 	case BTRFS_BLOCK_GROUP_RAID1:
 		strcat(ret, "|RAID1");
 		break;
+	case BTRFS_BLOCK_GROUP_RAID1C3:
+		strcat(ret, "|RAID1C3");
+		break;
+	case BTRFS_BLOCK_GROUP_RAID1C4:
+		strcat(ret, "|RAID1C4");
+		break;
 	case BTRFS_BLOCK_GROUP_DUP:
 		strcat(ret, "|DUP");
 		break;
diff --git a/utils.c b/utils.c
index 0b271517551b..6320d1a496cd 100644
--- a/utils.c
+++ b/utils.c
@@ -1900,8 +1900,10 @@ static int group_profile_devs_min(u64 flag)
 	case BTRFS_BLOCK_GROUP_RAID5:
 		return 2;
 	case BTRFS_BLOCK_GROUP_RAID6:
+	case BTRFS_BLOCK_GROUP_RAID1C3:
 		return 3;
 	case BTRFS_BLOCK_GROUP_RAID10:
+	case BTRFS_BLOCK_GROUP_RAID1C4:
 		return 4;
 	default:
 		return -1;
@@ -1918,9 +1920,10 @@ int test_num_disk_vs_raid(u64 metadata_profile, u64 data_profile,
 	default:
 	case 4:
 		allowed |= BTRFS_BLOCK_GROUP_RAID10;
+		allowed |= BTRFS_BLOCK_GROUP_RAID10 | BTRFS_BLOCK_GROUP_RAID1C4;
 		__attribute__ ((fallthrough));
 	case 3:
-		allowed |= BTRFS_BLOCK_GROUP_RAID6;
+		allowed |= BTRFS_BLOCK_GROUP_RAID6 | BTRFS_BLOCK_GROUP_RAID1C3;
 		__attribute__ ((fallthrough));
 	case 2:
 		allowed |= BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID1 |
@@ -1975,7 +1978,10 @@ int group_profile_max_safe_loss(u64 flags)
 	case BTRFS_BLOCK_GROUP_RAID10:
 		return 1;
 	case BTRFS_BLOCK_GROUP_RAID6:
+	case BTRFS_BLOCK_GROUP_RAID1C3:
 		return 2;
+	case BTRFS_BLOCK_GROUP_RAID1C4:
+		return 3;
 	default:
 		return -1;
 	}
@@ -2199,6 +2205,10 @@ const char* btrfs_group_profile_str(u64 flag)
 		return "RAID0";
 	case BTRFS_BLOCK_GROUP_RAID1:
 		return "RAID1";
+	case BTRFS_BLOCK_GROUP_RAID1C3:
+		return "RAID1C3";
+	case BTRFS_BLOCK_GROUP_RAID1C4:
+		return "RAID1C4";
 	case BTRFS_BLOCK_GROUP_RAID5:
 		return "RAID5";
 	case BTRFS_BLOCK_GROUP_RAID6:
diff --git a/volumes.c b/volumes.c
index 3a91b43b378b..66a88c7b7c17 100644
--- a/volumes.c
+++ b/volumes.c
@@ -49,6 +49,24 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 		.devs_increment	= 2,
 		.ncopies	= 2,
 	},
+	[BTRFS_RAID_RAID1C3] = {
+		.sub_stripes	= 1,
+		.dev_stripes	= 1,
+		.devs_max	= 0,
+		.devs_min	= 3,
+		.tolerated_failures = 2,
+		.devs_increment	= 3,
+		.ncopies	= 3,
+	},
+	[BTRFS_RAID_RAID1C4] = {
+		.sub_stripes	= 1,
+		.dev_stripes	= 1,
+		.devs_max	= 0,
+		.devs_min	= 4,
+		.tolerated_failures = 3,
+		.devs_increment	= 4,
+		.ncopies	= 4,
+	},
 	[BTRFS_RAID_DUP] = {
 		.sub_stripes	= 1,
 		.dev_stripes	= 2,
@@ -826,6 +844,8 @@ static u64 chunk_bytes_by_type(u64 type, u64 calc_size, int num_stripes,
 {
 	if (type & (BTRFS_BLOCK_GROUP_RAID1 | BTRFS_BLOCK_GROUP_DUP))
 		return calc_size;
+	else if (type & (BTRFS_BLOCK_GROUP_RAID1C3 | BTRFS_BLOCK_GROUP_RAID1C4))
+		return calc_size;
 	else if (type & BTRFS_BLOCK_GROUP_RAID10)
 		return calc_size * (num_stripes / sub_stripes);
 	else if (type & BTRFS_BLOCK_GROUP_RAID5)
@@ -1006,6 +1026,20 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 			return -ENOSPC;
 		min_stripes = 2;
 	}
+	if (type & BTRFS_BLOCK_GROUP_RAID1C3) {
+		num_stripes = min_t(u64, 3,
+				  btrfs_super_num_devices(info->super_copy));
+		if (num_stripes < 3)
+			return -ENOSPC;
+		min_stripes = 3;
+	}
+	if (type & BTRFS_BLOCK_GROUP_RAID1C4) {
+		num_stripes = min_t(u64, 4,
+				  btrfs_super_num_devices(info->super_copy));
+		if (num_stripes < 4)
+			return -ENOSPC;
+		min_stripes = 4;
+	}
 	if (type & BTRFS_BLOCK_GROUP_DUP) {
 		num_stripes = 2;
 		min_stripes = 2;
@@ -1354,7 +1388,8 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 	}
 	map = container_of(ce, struct map_lookup, ce);
 
-	if (map->type & (BTRFS_BLOCK_GROUP_DUP | BTRFS_BLOCK_GROUP_RAID1))
+	if (map->type & (BTRFS_BLOCK_GROUP_DUP | BTRFS_BLOCK_GROUP_RAID1 |
+			 BTRFS_BLOCK_GROUP_RAID1C3 | BTRFS_BLOCK_GROUP_RAID1C4))
 		ret = map->num_stripes;
 	else if (map->type & BTRFS_BLOCK_GROUP_RAID10)
 		ret = map->sub_stripes;
@@ -1550,6 +1585,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, int rw,
 
 	if (rw == WRITE) {
 		if (map->type & (BTRFS_BLOCK_GROUP_RAID1 |
+				 BTRFS_BLOCK_GROUP_RAID1C3 |
+				 BTRFS_BLOCK_GROUP_RAID1C4 |
 				 BTRFS_BLOCK_GROUP_DUP)) {
 			stripes_required = map->num_stripes;
 		} else if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
@@ -1592,6 +1629,7 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, int rw,
 	stripe_offset = offset - stripe_offset;
 
 	if (map->type & (BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID1 |
+			 BTRFS_BLOCK_GROUP_RAID1C3 | BTRFS_BLOCK_GROUP_RAID1C4 |
 			 BTRFS_BLOCK_GROUP_RAID5 | BTRFS_BLOCK_GROUP_RAID6 |
 			 BTRFS_BLOCK_GROUP_RAID10 |
 			 BTRFS_BLOCK_GROUP_DUP)) {
@@ -1607,7 +1645,9 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, int rw,
 
 	multi->num_stripes = 1;
 	stripe_index = 0;
-	if (map->type & BTRFS_BLOCK_GROUP_RAID1) {
+	if (map->type & (BTRFS_BLOCK_GROUP_RAID1 |
+			 BTRFS_BLOCK_GROUP_RAID1C3 |
+			 BTRFS_BLOCK_GROUP_RAID1C4)) {
 		if (rw == WRITE)
 			multi->num_stripes = map->num_stripes;
 		else if (mirror_num)
@@ -1877,6 +1917,8 @@ int btrfs_check_chunk_valid(struct btrfs_fs_info *fs_info,
 	if ((type & BTRFS_BLOCK_GROUP_RAID10 && (sub_stripes != 2 ||
 		  !IS_ALIGNED(num_stripes, sub_stripes))) ||
 	    (type & BTRFS_BLOCK_GROUP_RAID1 && num_stripes < 1) ||
+	    (type & BTRFS_BLOCK_GROUP_RAID1C3 && num_stripes < 3) ||
+	    (type & BTRFS_BLOCK_GROUP_RAID1C4 && num_stripes < 4) ||
 	    (type & BTRFS_BLOCK_GROUP_RAID5 && num_stripes < 2) ||
 	    (type & BTRFS_BLOCK_GROUP_RAID6 && num_stripes < 3) ||
 	    (type & BTRFS_BLOCK_GROUP_DUP && num_stripes > 2) ||
@@ -2436,6 +2478,8 @@ u64 btrfs_stripe_length(struct btrfs_fs_info *fs_info,
 	switch (profile) {
 	case 0: /* Single profile */
 	case BTRFS_BLOCK_GROUP_RAID1:
+	case BTRFS_BLOCK_GROUP_RAID1C3:
+	case BTRFS_BLOCK_GROUP_RAID1C4:
 	case BTRFS_BLOCK_GROUP_DUP:
 		stripe_len = chunk_len;
 		break;
diff --git a/volumes.h b/volumes.h
index dbe9d3dea647..6fa39cf31b9d 100644
--- a/volumes.h
+++ b/volumes.h
@@ -130,6 +130,10 @@ static inline enum btrfs_raid_types btrfs_bg_flags_to_raid_index(u64 flags)
 		return BTRFS_RAID_RAID10;
 	else if (flags & BTRFS_BLOCK_GROUP_RAID1)
 		return BTRFS_RAID_RAID1;
+	else if (flags & BTRFS_BLOCK_GROUP_RAID1C3)
+		return BTRFS_RAID_RAID1C3;
+	else if (flags & BTRFS_BLOCK_GROUP_RAID1C4)
+		return BTRFS_RAID_RAID1C4;
 	else if (flags & BTRFS_BLOCK_GROUP_DUP)
 		return BTRFS_RAID_DUP;
 	else if (flags & BTRFS_BLOCK_GROUP_RAID0)
-- 
2.21.0

