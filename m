Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12C6E3B507
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2019 14:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389927AbfFJM3G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jun 2019 08:29:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:46900 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389912AbfFJM3G (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jun 2019 08:29:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3095AE48
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2019 12:29:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2947CDA867; Mon, 10 Jun 2019 14:29:53 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 5/6] btrfs: add support for 4-copy replication (raid1c4)
Date:   Mon, 10 Jun 2019 14:29:53 +0200
Message-Id: <9f7af6767a25101f489de517cfbc0f96eb3485a5.1559917235.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559917235.git.dsterba@suse.com>
References: <cover.1559917235.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add new block group profile to store 4 copies in a simliar way that
current RAID1 does. The profile name is temporary and may change in the
future.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h                |  4 ++--
 fs/btrfs/super.c                |  3 +++
 fs/btrfs/volumes.c              | 12 ++++++++++++
 fs/btrfs/volumes.h              |  2 ++
 include/uapi/linux/btrfs.h      |  1 +
 include/uapi/linux/btrfs_tree.h |  6 +++++-
 6 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index fbb7c4cf41e9..5a17d97d81fd 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -53,9 +53,9 @@ struct btrfs_ref;
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
index a51469ae1c89..28fcb5868160 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1936,6 +1936,9 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 	} else if (type & BTRFS_BLOCK_GROUP_RAID1C3) {
 		min_stripes = 3;
 		num_stripes = 3;
+	} else if (type & BTRFS_BLOCK_GROUP_RAID1C4) {
+		min_stripes = 4;
+		num_stripes = 4;
 	} else if (type & BTRFS_BLOCK_GROUP_RAID10) {
 		min_stripes = 4;
 		num_stripes = 4;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c929eb46f814..95dab3012377 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -68,6 +68,18 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
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
index 9d5ea7fae1ab..ff314c5dc772 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -551,6 +551,8 @@ static inline enum btrfs_raid_types btrfs_bg_flags_to_raid_index(u64 flags)
 		return BTRFS_RAID_RAID1;
 	else if (flags & BTRFS_BLOCK_GROUP_RAID1C3)
 		return BTRFS_RAID_RAID1C3;
+	else if (flags & BTRFS_BLOCK_GROUP_RAID1C4)
+		return BTRFS_RAID_RAID1C4;
 	else if (flags & BTRFS_BLOCK_GROUP_DUP)
 		return BTRFS_RAID_DUP;
 	else if (flags & BTRFS_BLOCK_GROUP_RAID0)
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index b03b386cfe2b..4e32b161adfa 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -828,6 +828,7 @@ enum btrfs_err_code {
 	BTRFS_ERROR_DEV_ONLY_WRITABLE,
 	BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS,
 	BTRFS_ERROR_DEV_RAID1C3_MIN_NOT_MET,
+	BTRFS_ERROR_DEV_RAID1C4_MIN_NOT_MET,
 };
 
 #define BTRFS_IOC_SNAP_CREATE _IOW(BTRFS_IOCTL_MAGIC, 1, \
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 8ee1092332ed..16640355700d 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -840,6 +840,7 @@ struct btrfs_dev_replace_item {
 #define BTRFS_BLOCK_GROUP_RAID5         (1ULL << 7)
 #define BTRFS_BLOCK_GROUP_RAID6         (1ULL << 8)
 #define BTRFS_BLOCK_GROUP_RAID1C3       (1ULL << 9)
+#define BTRFS_BLOCK_GROUP_RAID1C4       (1ULL << 10)
 #define BTRFS_BLOCK_GROUP_RESERVED	(BTRFS_AVAIL_ALLOC_BIT_SINGLE | \
 					 BTRFS_SPACE_INFO_GLOBAL_RSV)
 
@@ -852,6 +853,7 @@ enum btrfs_raid_types {
 	BTRFS_RAID_RAID5,
 	BTRFS_RAID_RAID6,
 	BTRFS_RAID_RAID1C3,
+	BTRFS_RAID_RAID1C4,
 	BTRFS_NR_RAID_TYPES
 };
 
@@ -862,6 +864,7 @@ enum btrfs_raid_types {
 #define BTRFS_BLOCK_GROUP_PROFILE_MASK	(BTRFS_BLOCK_GROUP_RAID0 |   \
 					 BTRFS_BLOCK_GROUP_RAID1 |   \
 					 BTRFS_BLOCK_GROUP_RAID1C3 | \
+					 BTRFS_BLOCK_GROUP_RAID1C4 | \
 					 BTRFS_BLOCK_GROUP_RAID5 |   \
 					 BTRFS_BLOCK_GROUP_RAID6 |   \
 					 BTRFS_BLOCK_GROUP_DUP |     \
@@ -870,7 +873,8 @@ enum btrfs_raid_types {
 					 BTRFS_BLOCK_GROUP_RAID6)
 
 #define BTRFS_BLOCK_GROUP_RAID1_MASK	(BTRFS_BLOCK_GROUP_RAID1 |   \
-					 BTRFS_BLOCK_GROUP_RAID1C3)
+					 BTRFS_BLOCK_GROUP_RAID1C3 | \
+					 BTRFS_BLOCK_GROUP_RAID1C4)
 
 /*
  * We need a bit for restriper to be able to tell when chunks of type
-- 
2.21.0

