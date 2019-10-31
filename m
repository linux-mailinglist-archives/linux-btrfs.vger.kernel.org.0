Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66DE1EB3AA
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2019 16:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfJaPNk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Oct 2019 11:13:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:50756 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728004AbfJaPNj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Oct 2019 11:13:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 93E7CB6EA;
        Thu, 31 Oct 2019 15:13:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 764EFDA785; Thu, 31 Oct 2019 16:13:45 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 1/4] btrfs: add support for 3-copy replication (raid1c3)
Date:   Thu, 31 Oct 2019 16:13:45 +0100
Message-Id: <ee21de37b5f090241ae210b188aa2dac8a547055.1572534591.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572534591.git.dsterba@suse.com>
References: <cover.1572534591.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add new block group profile to store 3 copies in a simliar way that
current RAID1 does. The profile attributes and constraints are defined
in the raid table and used by the same code that already handles the
2-copy RAID1.

The minimum number of devices is 3, the maximum number of devices/chunks
that can be lost/damaged is 2. Like RAID6 but with 33% space
utilization.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h                |  4 ++--
 fs/btrfs/super.c                |  2 ++
 fs/btrfs/volumes.c              | 19 +++++++++++++++++--
 fs/btrfs/volumes.h              |  2 ++
 include/uapi/linux/btrfs.h      |  3 ++-
 include/uapi/linux/btrfs_tree.h |  6 +++++-
 6 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1c8f01eaf27c..aa1b437fb951 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -57,9 +57,9 @@ struct btrfs_ref;
  * filesystem data as well that can be used to read data in order to repair
  * read errors on other disks.
  *
- * Current value is derived from RAID1 with 2 copies.
+ * Current value is derived from RAID1C3 with 3 copies.
  */
-#define BTRFS_MAX_MIRRORS (2 + 1)
+#define BTRFS_MAX_MIRRORS (3 + 1)
 
 #define BTRFS_MAX_LEVEL 8
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3f49407cc2aa..a5aff138e2e0 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1935,6 +1935,8 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 		num_stripes = nr_devices;
 	else if (type & BTRFS_BLOCK_GROUP_RAID1)
 		num_stripes = 2;
+	else if (type & BTRFS_BLOCK_GROUP_RAID1C3)
+		num_stripes = 3;
 	else if (type & BTRFS_BLOCK_GROUP_RAID10)
 		num_stripes = 4;
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f534a6a5553e..22560062269f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -58,6 +58,18 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
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
+		.raid_name	= "raid1c3",
+		.bg_flag	= BTRFS_BLOCK_GROUP_RAID1C3,
+		.mindev_error	= BTRFS_ERROR_DEV_RAID1C3_MIN_NOT_MET,
+	},
 	[BTRFS_RAID_DUP] = {
 		.sub_stripes	= 1,
 		.dev_stripes	= 2,
@@ -4839,8 +4851,11 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
 	     btrfs_cmp_device_info, NULL);
 
-	/* round down to number of usable stripes */
-	ndevs = round_down(ndevs, devs_increment);
+	/*
+	 * Round down to number of usable stripes, devs_increment can be any
+	 * number so we can't use round_down()
+	 */
+	ndevs -= ndevs % devs_increment;
 
 	if (ndevs < devs_min) {
 		ret = -ENOSPC;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index ac4ba8c57283..a4e26b84e1b9 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -545,6 +545,8 @@ static inline enum btrfs_raid_types btrfs_bg_flags_to_raid_index(u64 flags)
 		return BTRFS_RAID_RAID10;
 	else if (flags & BTRFS_BLOCK_GROUP_RAID1)
 		return BTRFS_RAID_RAID1;
+	else if (flags & BTRFS_BLOCK_GROUP_RAID1C3)
+		return BTRFS_RAID_RAID1C3;
 	else if (flags & BTRFS_BLOCK_GROUP_DUP)
 		return BTRFS_RAID_DUP;
 	else if (flags & BTRFS_BLOCK_GROUP_RAID0)
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 3ee0678c0a83..ba22f91a3f5b 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -831,7 +831,8 @@ enum btrfs_err_code {
 	BTRFS_ERROR_DEV_TGT_REPLACE,
 	BTRFS_ERROR_DEV_MISSING_NOT_FOUND,
 	BTRFS_ERROR_DEV_ONLY_WRITABLE,
-	BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS
+	BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS,
+	BTRFS_ERROR_DEV_RAID1C3_MIN_NOT_MET,
 };
 
 #define BTRFS_IOC_SNAP_CREATE _IOW(BTRFS_IOCTL_MAGIC, 1, \
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 5160be1d7332..52b2964b0311 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -841,6 +841,7 @@ struct btrfs_dev_replace_item {
 #define BTRFS_BLOCK_GROUP_RAID10	(1ULL << 6)
 #define BTRFS_BLOCK_GROUP_RAID5         (1ULL << 7)
 #define BTRFS_BLOCK_GROUP_RAID6         (1ULL << 8)
+#define BTRFS_BLOCK_GROUP_RAID1C3       (1ULL << 9)
 #define BTRFS_BLOCK_GROUP_RESERVED	(BTRFS_AVAIL_ALLOC_BIT_SINGLE | \
 					 BTRFS_SPACE_INFO_GLOBAL_RSV)
 
@@ -852,6 +853,7 @@ enum btrfs_raid_types {
 	BTRFS_RAID_SINGLE,
 	BTRFS_RAID_RAID5,
 	BTRFS_RAID_RAID6,
+	BTRFS_RAID_RAID1C3,
 	BTRFS_NR_RAID_TYPES
 };
 
@@ -861,6 +863,7 @@ enum btrfs_raid_types {
 
 #define BTRFS_BLOCK_GROUP_PROFILE_MASK	(BTRFS_BLOCK_GROUP_RAID0 |   \
 					 BTRFS_BLOCK_GROUP_RAID1 |   \
+					 BTRFS_BLOCK_GROUP_RAID1C3 | \
 					 BTRFS_BLOCK_GROUP_RAID5 |   \
 					 BTRFS_BLOCK_GROUP_RAID6 |   \
 					 BTRFS_BLOCK_GROUP_DUP |     \
@@ -868,7 +871,8 @@ enum btrfs_raid_types {
 #define BTRFS_BLOCK_GROUP_RAID56_MASK	(BTRFS_BLOCK_GROUP_RAID5 |   \
 					 BTRFS_BLOCK_GROUP_RAID6)
 
-#define BTRFS_BLOCK_GROUP_RAID1_MASK	(BTRFS_BLOCK_GROUP_RAID1)
+#define BTRFS_BLOCK_GROUP_RAID1_MASK	(BTRFS_BLOCK_GROUP_RAID1 |   \
+					 BTRFS_BLOCK_GROUP_RAID1C3)
 
 /*
  * We need a bit for restriper to be able to tell when chunks of type
-- 
2.23.0

