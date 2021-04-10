Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACA135ACB2
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Apr 2021 12:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbhDJKO7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Apr 2021 06:14:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:47856 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229992AbhDJKO7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Apr 2021 06:14:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618049684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=K1OJZrRr35YehiL9LX1/ZUkrbWtzDfKiaMiIKPlDoQY=;
        b=JqCkTF23GgCfnL76mfkffRPv2KjxBHtFVunvJ/AchzCplS/SeFIhAd5ylmlKu+31xhaRh2
        nfnu7/OTQF3jJ9EYfw2kWhAYiyRZwqhxMM402oyxGnnkogHcGjghCEJ13meIKOLajnsJj8
        Q84f2czc0piH9ZW2OCNsv21ahmAcwPY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D7269AE5C;
        Sat, 10 Apr 2021 10:14:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0E870DAF21; Sat, 10 Apr 2021 12:12:30 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     naohiro.aota@wdc.com, josef@toxicpanda.com,
        Johannes.Thumshirn@wdc.com, Damien.LeMoal@wdc.com,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v3] btrfs: zoned: move superblock logging zone location
Date:   Sat, 10 Apr 2021 12:12:23 +0200
Message-Id: <20210410101223.30303-1-dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Naohiro Aota <naohiro.aota@wdc.com>

Moves the location of the superblock logging zones. The new locations of
the logging zones are now determined based on fixed block addresses
instead of on fixed zone numbers.

The old placement method based on fixed zone numbers causes problems when
one needs to inspect a file system image without access to the drive zone
information. In such case, the super block locations cannot be reliably
determined as the zone size is unknown. By locating the superblock logging
zones using fixed addresses, we can scan a dumped file system image without
the zone information since a super block copy will always be present at or
after the fixed known locations.

Introduce the following three pairs of zones containing fixed offset
locations, regardless of the device zone size.

  - primary superblock: offset   0B (and the following zone)
  - first copy:         offset 512G (and the following zone)
  - Second copy:        offset   4T (4096G, and the following zone)

If a logging zone is outside of the disk capacity, we do not record the
superblock copy.

The first copy position is much larger than for a non-zoned filesystem,
which is at 64M.  This is to avoid overlapping with the log zones for
the primary superblock. This higher location is arbitrary but allows
supporting devices with very large zone sizes, plus some space around in
between.

Such large zone size is unrealistic and very unlikely to ever be seen in
real devices. Currently, SMR disks have a zone size of 256MB, and we are
expecting ZNS drives to be in the 1-4GB range, so this limit gives us
room to breathe. For now, we only allow zone sizes up to 8GB. The
maximum zone size that would still fit in the space is 256G.

The fixed location addresses are somewhat arbitrary, with the intent of
maintaining superblock reliability for smaller and larger devices, with
the preference for the latter. For this reason, there are two superblocks
under the first 1T. This should cover use cases for physical devices and
for emulated/device-mapper devices.

The superblock logging zones are reserved for superblock logging and
never used for data or metadata blocks. Note that we only reserve the
two zones per primary/copy actually used for superblock logging. We do
not reserve the ranges of zones possibly containing superblocks with the
largest supported zone size (0-16GB, 512G-528GB, 4096G-4112G).

The zones containing the fixed location offsets used to store
superblocks on a non-zoned volume are also reserved to avoid confusion.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---

For context see replies under
https://lore.kernel.org/linux-btrfs/2f58edb74695825632c77349b000d31f16cb3226.1617870145.git.naohiro.aota@wdc.com/

 fs/btrfs/zoned.c | 53 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 1f972b75a9ab..eeb3ebe11d7a 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -21,9 +21,30 @@
 /* Pseudo write pointer value for conventional zone */
 #define WP_CONVENTIONAL ((u64)-2)
 
+/*
+ * Location of the first zone of superblock logging zone pairs.
+ *
+ * - primary superblock:    0B (zone 0)
+ * - first copy:          512G (zone starting at that offset)
+ * - second copy:           4T (zone starting at that offset)
+ */
+#define BTRFS_SB_LOG_PRIMARY_OFFSET	(0ULL)
+#define BTRFS_SB_LOG_FIRST_OFFSET	(512ULL * SZ_1G)
+#define BTRFS_SB_LOG_SECOND_OFFSET	(4096ULL * SZ_1G)
+
+#define BTRFS_SB_LOG_FIRST_SHIFT	const_ilog2(BTRFS_SB_LOG_FIRST_OFFSET)
+#define BTRFS_SB_LOG_SECOND_SHIFT	const_ilog2(BTRFS_SB_LOG_SECOND_OFFSET)
+
 /* Number of superblock log zones */
 #define BTRFS_NR_SB_LOG_ZONES 2
 
+/*
+ * Maximum supported zone size. Currently, SMR disks have a zone size of
+ * 256MiB, and we are expecting ZNS drives to be in the 1-4GiB range. We do not
+ * expect the zone size to become larger than 8GiB in the near future.
+ */
+#define BTRFS_MAX_ZONE_SIZE		SZ_8G
+
 static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx, void *data)
 {
 	struct blk_zone *zones = data;
@@ -111,23 +132,22 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 }
 
 /*
- * The following zones are reserved as the circular buffer on ZONED btrfs.
- *  - The primary superblock: zones 0 and 1
- *  - The first copy: zones 16 and 17
- *  - The second copy: zones 1024 or zone at 256GB which is minimum, and
- *                     the following one
+ * Get the first zone number of the superblock mirror
  */
 static inline u32 sb_zone_number(int shift, int mirror)
 {
-	ASSERT(mirror < BTRFS_SUPER_MIRROR_MAX);
+	u64 zone;
 
+	ASSERT(mirror < BTRFS_SUPER_MIRROR_MAX);
 	switch (mirror) {
-	case 0: return 0;
-	case 1: return 16;
-	case 2: return min_t(u64, btrfs_sb_offset(mirror) >> shift, 1024);
+	case 0: zone = 0; break;
+	case 1: zone = 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;
+	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
 	}
 
-	return 0;
+	ASSERT(zone <= U32_MAX);
+
+	return (u32)zone;
 }
 
 /*
@@ -300,10 +320,21 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 		zone_sectors = bdev_zone_sectors(bdev);
 	}
 
-	nr_sectors = bdev_nr_sectors(bdev);
 	/* Check if it's power of 2 (see is_power_of_2) */
 	ASSERT(zone_sectors != 0 && (zone_sectors & (zone_sectors - 1)) == 0);
 	zone_info->zone_size = zone_sectors << SECTOR_SHIFT;
+
+	/* We reject devices with a zone size larger than 8GB */
+	if (zone_info->zone_size > BTRFS_MAX_ZONE_SIZE) {
+		btrfs_err_in_rcu(fs_info,
+		"zoned: %s: zone size %llu larger than supported maximum %llu",
+				 rcu_str_deref(device->name),
+				 zone_info->zone_size, BTRFS_MAX_ZONE_SIZE);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	nr_sectors = bdev_nr_sectors(bdev);
 	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
 	zone_info->max_zone_append_size =
 		(u64)queue_max_zone_append_sectors(queue) << SECTOR_SHIFT;
-- 
2.29.2

