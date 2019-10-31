Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F58EB3AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2019 16:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfJaPNl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Oct 2019 11:13:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:50772 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728306AbfJaPNk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Oct 2019 11:13:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 945A5B706;
        Thu, 31 Oct 2019 15:13:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C6736DA783; Thu, 31 Oct 2019 16:13:47 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 2/4] btrfs: add support for 4-copy replication (raid1c4)
Date:   Thu, 31 Oct 2019 16:13:47 +0100
Message-Id: <501e343804320c22f6cafe417543f5039ef8c48a.1572534591.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572534591.git.dsterba@suse.com>
References: <cover.1572534591.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add new block group profile to store 4 copies in a simliar way that
current RAID1 does.  The profile attributes and constraints are defined
in the raid table and used by the same code that already handles the 2-
and 3-copy RAID1.

The minimum number of devices is 4, the maximum number of devices/chunks
that can be lost/damaged is 3. There is no comparable traditional RAID
level, the profile is added for future needs to accompany triple-parity
and beyond.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h                |  4 ++--
 fs/btrfs/super.c                |  2 ++
 fs/btrfs/volumes.c              | 12 ++++++++++++
 fs/btrfs/volumes.h              |  2 ++
 include/uapi/linux/btrfs.h      |  1 +
 include/uapi/linux/btrfs_tree.h |  6 +++++-
 6 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index aa1b437fb951..923a8804ae94 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -57,9 +57,9 @@ struct btrfs_ref;
  * filesystem data as well that can be used to read data in order to repair
  * read errors on other disks.
  *
- * Current value is derived from RAID1C3 with 3 copies.
+ * Current value is derived from RAID1C4 with 4 copies.
  */
-#define BTRFS_MAX_MIRRORS (3 + 1)
+#define BTRFS_MAX_MIRRORS (4 + 1)
 
 #define BTRFS_MAX_LEVEL 8
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a5aff138e2e0..a98c3c71fc54 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1937,6 +1937,8 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 		num_stripes = 2;
 	else if (type & BTRFS_BLOCK_GROUP_RAID1C3)
 		num_stripes = 3;
+	else if (type & BTRFS_BLOCK_GROUP_RAID1C4)
+		num_stripes = 4;
 	else if (type & BTRFS_BLOCK_GROUP_RAID10)
 		num_stripes = 4;
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 22560062269f..238d814f83a1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -70,6 +70,18 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 		.bg_flag	= BTRFS_BLOCK_GROUP_RAID1C3,
 		.mindev_error	= BTRFS_ERROR_DEV_RAID1C3_MIN_NOT_MET,
 	},
+	[BTRFS_RAID_RAID1C4] = {
+		.sub_stripes	= 1,
+		.dev_stripes	= 1,
+		.devs_max	= 0,
+		.devs_min	= 4,
+		.tolerated_failures = 3,
+		.devs_increment	= 4,
+		.ncopies	= 4,
+		.raid_name	= "raid1c4",
+		.bg_flag	= BTRFS_BLOCK_GROUP_RAID1C4,
+		.mindev_error	= BTRFS_ERROR_DEV_RAID1C4_MIN_NOT_MET,
+	},
 	[BTRFS_RAID_DUP] = {
 		.sub_stripes	= 1,
 		.dev_stripes	= 2,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index a4e26b84e1b9..46987a2da786 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -547,6 +547,8 @@ static inline enum btrfs_raid_types btrfs_bg_flags_to_raid_index(u64 flags)
 		return BTRFS_RAID_RAID1;
 	else if (flags & BTRFS_BLOCK_GROUP_RAID1C3)
 		return BTRFS_RAID_RAID1C3;
+	else if (flags & BTRFS_BLOCK_GROUP_RAID1C4)
+		return BTRFS_RAID_RAID1C4;
 	else if (flags & BTRFS_BLOCK_GROUP_DUP)
 		return BTRFS_RAID_DUP;
 	else if (flags & BTRFS_BLOCK_GROUP_RAID0)
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index ba22f91a3f5b..a2b761275bba 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -833,6 +833,7 @@ enum btrfs_err_code {
 	BTRFS_ERROR_DEV_ONLY_WRITABLE,
 	BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS,
 	BTRFS_ERROR_DEV_RAID1C3_MIN_NOT_MET,
+	BTRFS_ERROR_DEV_RAID1C4_MIN_NOT_MET,
 };
 
 #define BTRFS_IOC_SNAP_CREATE _IOW(BTRFS_IOCTL_MAGIC, 1, \
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 52b2964b0311..8e322e2c7e78 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -842,6 +842,7 @@ struct btrfs_dev_replace_item {
 #define BTRFS_BLOCK_GROUP_RAID5         (1ULL << 7)
 #define BTRFS_BLOCK_GROUP_RAID6         (1ULL << 8)
 #define BTRFS_BLOCK_GROUP_RAID1C3       (1ULL << 9)
+#define BTRFS_BLOCK_GROUP_RAID1C4       (1ULL << 10)
 #define BTRFS_BLOCK_GROUP_RESERVED	(BTRFS_AVAIL_ALLOC_BIT_SINGLE | \
 					 BTRFS_SPACE_INFO_GLOBAL_RSV)
 
@@ -854,6 +855,7 @@ enum btrfs_raid_types {
 	BTRFS_RAID_RAID5,
 	BTRFS_RAID_RAID6,
 	BTRFS_RAID_RAID1C3,
+	BTRFS_RAID_RAID1C4,
 	BTRFS_NR_RAID_TYPES
 };
 
@@ -864,6 +866,7 @@ enum btrfs_raid_types {
 #define BTRFS_BLOCK_GROUP_PROFILE_MASK	(BTRFS_BLOCK_GROUP_RAID0 |   \
 					 BTRFS_BLOCK_GROUP_RAID1 |   \
 					 BTRFS_BLOCK_GROUP_RAID1C3 | \
+					 BTRFS_BLOCK_GROUP_RAID1C4 | \
 					 BTRFS_BLOCK_GROUP_RAID5 |   \
 					 BTRFS_BLOCK_GROUP_RAID6 |   \
 					 BTRFS_BLOCK_GROUP_DUP |     \
@@ -872,7 +875,8 @@ enum btrfs_raid_types {
 					 BTRFS_BLOCK_GROUP_RAID6)
 
 #define BTRFS_BLOCK_GROUP_RAID1_MASK	(BTRFS_BLOCK_GROUP_RAID1 |   \
-					 BTRFS_BLOCK_GROUP_RAID1C3)
+					 BTRFS_BLOCK_GROUP_RAID1C3 | \
+					 BTRFS_BLOCK_GROUP_RAID1C4)
 
 /*
  * We need a bit for restriper to be able to tell when chunks of type
-- 
2.23.0

