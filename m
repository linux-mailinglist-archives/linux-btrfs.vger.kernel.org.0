Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD07EEB769
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2019 19:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfJaSnT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Oct 2019 14:43:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:42054 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729313AbfJaSnS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Oct 2019 14:43:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 66C9EB2FE;
        Thu, 31 Oct 2019 18:43:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1476BDA783; Thu, 31 Oct 2019 19:43:23 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs-progs: add support for raid1c3 and raid1c4
Date:   Thu, 31 Oct 2019 19:43:17 +0100
Message-Id: <20191031184317.28746-1-dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572534591.git.dsterba@suse.com>
References: <cover.1572534591.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add support for 3- and 4- copy variants of RAID1. This adds resiliency
against 2 or resp. 3 devices lost or damaged.

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
 cmds/balance.c              |  4 ++++
 cmds/filesystem-usage.c     |  8 +++++++
 cmds/inspect-dump-super.c   |  3 ++-
 cmds/rescue-chunk-recover.c |  4 ++++
 common/fsfeatures.c         |  6 +++++
 common/utils.c              | 12 +++++++++-
 ctree.h                     |  8 +++++++
 extent-tree.c               |  4 ++++
 ioctl.h                     |  4 +++-
 mkfs/main.c                 | 11 ++++++++-
 print-tree.c                |  6 +++++
 volumes.c                   | 48 +++++++++++++++++++++++++++++++++++--
 volumes.h                   |  4 ++++
 13 files changed, 116 insertions(+), 6 deletions(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index 32830002f3a0..2d0fb6ef52ed 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
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
diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 212322188d19..744ff2de5a7f 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -374,6 +374,10 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
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
@@ -654,6 +658,10 @@ static u64 calc_chunk_size(struct chunk_info *ci)
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
diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index bf380ad2b56a..b32a5ebecc86 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -227,7 +227,8 @@ static struct readable_flag_entry incompat_flags_array[] = {
 	DEF_INCOMPAT_FLAG_ENTRY(RAID56),
 	DEF_INCOMPAT_FLAG_ENTRY(SKINNY_METADATA),
 	DEF_INCOMPAT_FLAG_ENTRY(NO_HOLES),
-	DEF_INCOMPAT_FLAG_ENTRY(METADATA_UUID)
+	DEF_INCOMPAT_FLAG_ENTRY(METADATA_UUID),
+	DEF_INCOMPAT_FLAG_ENTRY(RAID1C34),
 };
 static const int incompat_flags_num = sizeof(incompat_flags_array) /
 				      sizeof(struct readable_flag_entry);
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index 329a608dfc6b..5d573161905f 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1582,6 +1582,10 @@ static int calc_num_stripes(u64 type)
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
diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 50934bd161b0..ac12d57b25a3 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -86,6 +86,12 @@ static const struct btrfs_fs_feature {
 		VERSION_TO_STRING2(4,0),
 		NULL, 0,
 		"no explicit hole extents for files" },
+	{ "raid1c34", BTRFS_FEATURE_INCOMPAT_RAID1C34,
+		"raid1c34",
+		VERSION_TO_STRING2(5,5),
+		NULL, 0,
+		NULL, 0,
+		"RAID1 with 3 or 4 copies" },
 	/* Keep this one last */
 	{ "list-all", BTRFS_FEATURE_LIST_ALL, NULL }
 };
diff --git a/common/utils.c b/common/utils.c
index 2cf15c333f6b..23e0a7927172 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -1117,8 +1117,10 @@ static int group_profile_devs_min(u64 flag)
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
@@ -1135,9 +1137,10 @@ int test_num_disk_vs_raid(u64 metadata_profile, u64 data_profile,
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
@@ -1191,7 +1194,10 @@ int group_profile_max_safe_loss(u64 flags)
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
@@ -1341,6 +1347,10 @@ const char* btrfs_group_profile_str(u64 flag)
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
diff --git a/ctree.h b/ctree.h
index b2745e1e8f13..f5227c053eb2 100644
--- a/ctree.h
+++ b/ctree.h
@@ -489,6 +489,7 @@ struct btrfs_super_block {
 #define BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA	(1ULL << 8)
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID    (1ULL << 10)
+#define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 
 #define BTRFS_FEATURE_COMPAT_SUPP		0ULL
 
@@ -512,6 +513,7 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS |		\
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES |		\
+	 BTRFS_FEATURE_INCOMPAT_RAID1C34 |		\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID)
 
 /*
@@ -961,6 +963,8 @@ struct btrfs_csum_item {
 #define BTRFS_BLOCK_GROUP_RAID10	(1ULL << 6)
 #define BTRFS_BLOCK_GROUP_RAID5    	(1ULL << 7)
 #define BTRFS_BLOCK_GROUP_RAID6    	(1ULL << 8)
+#define BTRFS_BLOCK_GROUP_RAID1C3    	(1ULL << 9)
+#define BTRFS_BLOCK_GROUP_RAID1C4    	(1ULL << 10)
 #define BTRFS_BLOCK_GROUP_RESERVED	BTRFS_AVAIL_ALLOC_BIT_SINGLE
 
 enum btrfs_raid_types {
@@ -971,6 +975,8 @@ enum btrfs_raid_types {
 	BTRFS_RAID_SINGLE,
 	BTRFS_RAID_RAID5,
 	BTRFS_RAID_RAID6,
+	BTRFS_RAID_RAID1C3,
+	BTRFS_RAID_RAID1C4,
 	BTRFS_NR_RAID_TYPES
 };
 
@@ -982,6 +988,8 @@ enum btrfs_raid_types {
 					 BTRFS_BLOCK_GROUP_RAID1 |   \
 					 BTRFS_BLOCK_GROUP_RAID5 |   \
 					 BTRFS_BLOCK_GROUP_RAID6 |   \
+					 BTRFS_BLOCK_GROUP_RAID1C3 | \
+					 BTRFS_BLOCK_GROUP_RAID1C4 | \
 					 BTRFS_BLOCK_GROUP_DUP |     \
 					 BTRFS_BLOCK_GROUP_RAID10)
 
diff --git a/extent-tree.c b/extent-tree.c
index 662fb1fa2b9a..d5cd13bd4328 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -1669,6 +1669,8 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
 {
 	u64 extra_flags = flags & (BTRFS_BLOCK_GROUP_RAID0 |
 				   BTRFS_BLOCK_GROUP_RAID1 |
+				   BTRFS_BLOCK_GROUP_RAID1C3 |
+				   BTRFS_BLOCK_GROUP_RAID1C4 |
 				   BTRFS_BLOCK_GROUP_RAID10 |
 				   BTRFS_BLOCK_GROUP_RAID5 |
 				   BTRFS_BLOCK_GROUP_RAID6 |
@@ -3104,6 +3106,8 @@ static u64 get_dev_extent_len(struct map_lookup *map)
 	case 0: /* Single */
 	case BTRFS_BLOCK_GROUP_DUP:
 	case BTRFS_BLOCK_GROUP_RAID1:
+	case BTRFS_BLOCK_GROUP_RAID1C3:
+	case BTRFS_BLOCK_GROUP_RAID1C4:
 		div = 1;
 		break;
 	case BTRFS_BLOCK_GROUP_RAID5:
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
index f52e8b61a460..dd1223f703e4 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -337,7 +337,7 @@ static void print_usage(int ret)
 	printf("Usage: mkfs.btrfs [options] dev [ dev ... ]\n");
 	printf("Options:\n");
 	printf("  allocation profiles:\n");
-	printf("\t-d|--data PROFILE       data profile, raid0, raid1, raid5, raid6, raid10, dup or single\n");
+	printf("\t-d|--data PROFILE       data profile, raid0, raid1, raid1c3, raid1c4, raid5, raid6, raid10, dup or single\n");
 	printf("\t-m|--metadata PROFILE   metadata profile, values like for data profile\n");
 	printf("\t-M|--mixed              mix metadata and data together\n");
 	printf("  features:\n");
@@ -370,6 +370,10 @@ static u64 parse_profile(const char *s)
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
@@ -1065,6 +1069,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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
index f70ce6844a7e..35ab9234cf48 100644
--- a/print-tree.c
+++ b/print-tree.c
@@ -162,6 +162,12 @@ static void bg_flags_to_str(u64 flags, char *ret)
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
diff --git a/volumes.c b/volumes.c
index fbbc22b5b1b3..63e7fba975cf 100644
--- a/volumes.c
+++ b/volumes.c
@@ -57,6 +57,24 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 		.bg_flag	= BTRFS_BLOCK_GROUP_RAID1,
 		.mindev_error	= BTRFS_ERROR_DEV_RAID1_MIN_NOT_MET,
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
@@ -854,6 +872,8 @@ static u64 chunk_bytes_by_type(u64 type, u64 calc_size, int num_stripes,
 {
 	if (type & (BTRFS_BLOCK_GROUP_RAID1 | BTRFS_BLOCK_GROUP_DUP))
 		return calc_size;
+	else if (type & (BTRFS_BLOCK_GROUP_RAID1C3 | BTRFS_BLOCK_GROUP_RAID1C4))
+		return calc_size;
 	else if (type & BTRFS_BLOCK_GROUP_RAID10)
 		return calc_size * (num_stripes / sub_stripes);
 	else if (type & BTRFS_BLOCK_GROUP_RAID5)
@@ -1034,6 +1054,20 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
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
@@ -1382,7 +1416,8 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 	}
 	map = container_of(ce, struct map_lookup, ce);
 
-	if (map->type & (BTRFS_BLOCK_GROUP_DUP | BTRFS_BLOCK_GROUP_RAID1))
+	if (map->type & (BTRFS_BLOCK_GROUP_DUP | BTRFS_BLOCK_GROUP_RAID1 |
+			 BTRFS_BLOCK_GROUP_RAID1C3 | BTRFS_BLOCK_GROUP_RAID1C4))
 		ret = map->num_stripes;
 	else if (map->type & BTRFS_BLOCK_GROUP_RAID10)
 		ret = map->sub_stripes;
@@ -1578,6 +1613,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, int rw,
 
 	if (rw == WRITE) {
 		if (map->type & (BTRFS_BLOCK_GROUP_RAID1 |
+				 BTRFS_BLOCK_GROUP_RAID1C3 |
+				 BTRFS_BLOCK_GROUP_RAID1C4 |
 				 BTRFS_BLOCK_GROUP_DUP)) {
 			stripes_required = map->num_stripes;
 		} else if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
@@ -1620,6 +1657,7 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, int rw,
 	stripe_offset = offset - stripe_offset;
 
 	if (map->type & (BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID1 |
+			 BTRFS_BLOCK_GROUP_RAID1C3 | BTRFS_BLOCK_GROUP_RAID1C4 |
 			 BTRFS_BLOCK_GROUP_RAID5 | BTRFS_BLOCK_GROUP_RAID6 |
 			 BTRFS_BLOCK_GROUP_RAID10 |
 			 BTRFS_BLOCK_GROUP_DUP)) {
@@ -1635,7 +1673,9 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, int rw,
 
 	multi->num_stripes = 1;
 	stripe_index = 0;
-	if (map->type & BTRFS_BLOCK_GROUP_RAID1) {
+	if (map->type & (BTRFS_BLOCK_GROUP_RAID1 |
+			 BTRFS_BLOCK_GROUP_RAID1C3 |
+			 BTRFS_BLOCK_GROUP_RAID1C4)) {
 		if (rw == WRITE)
 			multi->num_stripes = map->num_stripes;
 		else if (mirror_num)
@@ -1905,6 +1945,8 @@ int btrfs_check_chunk_valid(struct btrfs_fs_info *fs_info,
 	if ((type & BTRFS_BLOCK_GROUP_RAID10 && (sub_stripes != 2 ||
 		  !IS_ALIGNED(num_stripes, sub_stripes))) ||
 	    (type & BTRFS_BLOCK_GROUP_RAID1 && num_stripes < 1) ||
+	    (type & BTRFS_BLOCK_GROUP_RAID1C3 && num_stripes < 3) ||
+	    (type & BTRFS_BLOCK_GROUP_RAID1C4 && num_stripes < 4) ||
 	    (type & BTRFS_BLOCK_GROUP_RAID5 && num_stripes < 2) ||
 	    (type & BTRFS_BLOCK_GROUP_RAID6 && num_stripes < 3) ||
 	    (type & BTRFS_BLOCK_GROUP_DUP && num_stripes > 2) ||
@@ -2464,6 +2506,8 @@ u64 btrfs_stripe_length(struct btrfs_fs_info *fs_info,
 	switch (profile) {
 	case 0: /* Single profile */
 	case BTRFS_BLOCK_GROUP_RAID1:
+	case BTRFS_BLOCK_GROUP_RAID1C3:
+	case BTRFS_BLOCK_GROUP_RAID1C4:
 	case BTRFS_BLOCK_GROUP_DUP:
 		stripe_len = chunk_len;
 		break;
diff --git a/volumes.h b/volumes.h
index 586588c871ab..a6351dcf0bc3 100644
--- a/volumes.h
+++ b/volumes.h
@@ -135,6 +135,10 @@ static inline enum btrfs_raid_types btrfs_bg_flags_to_raid_index(u64 flags)
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
2.23.0

