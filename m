Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBC23B506
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2019 14:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389917AbfFJM3E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jun 2019 08:29:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:46890 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389912AbfFJM3D (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jun 2019 08:29:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 055B9AE48
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2019 12:29:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 82960DA84E; Mon, 10 Jun 2019 14:29:51 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 4/6] btrfs: add support for 3-copy replication (raid1c3)
Date:   Mon, 10 Jun 2019 14:29:51 +0200
Message-Id: <89c7966ac71bed6ff488cc1232c558eb64292918.1559917235.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559917235.git.dsterba@suse.com>
References: <cover.1559917235.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add new block group profile to store 3 copies in a simliar way that
current RAID1 does. The profile name is temporary and may change in the
future.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h                |  4 ++--
 fs/btrfs/extent-tree.c          |  2 ++
 fs/btrfs/super.c                |  3 +++
 fs/btrfs/volumes.c              | 19 +++++++++++++++++--
 fs/btrfs/volumes.h              |  2 ++
 include/uapi/linux/btrfs.h      |  3 ++-
 include/uapi/linux/btrfs_tree.h |  6 +++++-
 7 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 31198499f175..fbb7c4cf41e9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -53,9 +53,9 @@ struct btrfs_ref;
  * filesystem data as well that can be used to read data in order to repair
  * read errors on other disks.
  *
- * Current value is derived from RAID1 with 2 copies.
+ * Current value is derived from RAID1C3 with 3 copies.
  */
-#define BTRFS_MAX_MIRRORS (2 + 1)
+#define BTRFS_MAX_MIRRORS (3 + 1)
 
 #define BTRFS_MAX_LEVEL 8
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 556deb03c215..a4afd3a18c27 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -9884,6 +9884,8 @@ int btrfs_can_relocate(struct btrfs_fs_info *fs_info, u64 bytenr)
 		min_free >>= 1;
 	} else if (index == BTRFS_RAID_RAID1) {
 		dev_min = 2;
+	} else if (index == BTRFS_RAID_RAID1C3) {
+		dev_min = 3;
 	} else if (index == BTRFS_RAID_DUP) {
 		/* Multiply by 2 */
 		min_free <<= 1;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6e196b8a0820..a51469ae1c89 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1933,6 +1933,9 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 	} else if (type & BTRFS_BLOCK_GROUP_RAID1) {
 		min_stripes = 2;
 		num_stripes = 2;
+	} else if (type & BTRFS_BLOCK_GROUP_RAID1C3) {
+		min_stripes = 3;
+		num_stripes = 3;
 	} else if (type & BTRFS_BLOCK_GROUP_RAID10) {
 		min_stripes = 4;
 		num_stripes = 4;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9e5167a0e406..c929eb46f814 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -56,6 +56,18 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
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
@@ -5050,8 +5062,11 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
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
index fea7b65a712e..9d5ea7fae1ab 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -549,6 +549,8 @@ static inline enum btrfs_raid_types btrfs_bg_flags_to_raid_index(u64 flags)
 		return BTRFS_RAID_RAID10;
 	else if (flags & BTRFS_BLOCK_GROUP_RAID1)
 		return BTRFS_RAID_RAID1;
+	else if (flags & BTRFS_BLOCK_GROUP_RAID1C3)
+		return BTRFS_RAID_RAID1C3;
 	else if (flags & BTRFS_BLOCK_GROUP_DUP)
 		return BTRFS_RAID_DUP;
 	else if (flags & BTRFS_BLOCK_GROUP_RAID0)
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index c195896d478f..b03b386cfe2b 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -826,7 +826,8 @@ enum btrfs_err_code {
 	BTRFS_ERROR_DEV_TGT_REPLACE,
 	BTRFS_ERROR_DEV_MISSING_NOT_FOUND,
 	BTRFS_ERROR_DEV_ONLY_WRITABLE,
-	BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS
+	BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS,
+	BTRFS_ERROR_DEV_RAID1C3_MIN_NOT_MET,
 };
 
 #define BTRFS_IOC_SNAP_CREATE _IOW(BTRFS_IOCTL_MAGIC, 1, \
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 34d5b34286fa..8ee1092332ed 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -839,6 +839,7 @@ struct btrfs_dev_replace_item {
 #define BTRFS_BLOCK_GROUP_RAID10	(1ULL << 6)
 #define BTRFS_BLOCK_GROUP_RAID5         (1ULL << 7)
 #define BTRFS_BLOCK_GROUP_RAID6         (1ULL << 8)
+#define BTRFS_BLOCK_GROUP_RAID1C3       (1ULL << 9)
 #define BTRFS_BLOCK_GROUP_RESERVED	(BTRFS_AVAIL_ALLOC_BIT_SINGLE | \
 					 BTRFS_SPACE_INFO_GLOBAL_RSV)
 
@@ -850,6 +851,7 @@ enum btrfs_raid_types {
 	BTRFS_RAID_SINGLE,
 	BTRFS_RAID_RAID5,
 	BTRFS_RAID_RAID6,
+	BTRFS_RAID_RAID1C3,
 	BTRFS_NR_RAID_TYPES
 };
 
@@ -859,6 +861,7 @@ enum btrfs_raid_types {
 
 #define BTRFS_BLOCK_GROUP_PROFILE_MASK	(BTRFS_BLOCK_GROUP_RAID0 |   \
 					 BTRFS_BLOCK_GROUP_RAID1 |   \
+					 BTRFS_BLOCK_GROUP_RAID1C3 | \
 					 BTRFS_BLOCK_GROUP_RAID5 |   \
 					 BTRFS_BLOCK_GROUP_RAID6 |   \
 					 BTRFS_BLOCK_GROUP_DUP |     \
@@ -866,7 +869,8 @@ enum btrfs_raid_types {
 #define BTRFS_BLOCK_GROUP_RAID56_MASK	(BTRFS_BLOCK_GROUP_RAID5 |   \
 					 BTRFS_BLOCK_GROUP_RAID6)
 
-#define BTRFS_BLOCK_GROUP_RAID1_MASK	(BTRFS_BLOCK_GROUP_RAID1)
+#define BTRFS_BLOCK_GROUP_RAID1_MASK	(BTRFS_BLOCK_GROUP_RAID1 |   \
+					 BTRFS_BLOCK_GROUP_RAID1C3)
 
 /*
  * We need a bit for restriper to be able to tell when chunks of type
-- 
2.21.0

