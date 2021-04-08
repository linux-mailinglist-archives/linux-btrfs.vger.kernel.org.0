Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF76A357E03
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Apr 2021 10:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhDHI0U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Apr 2021 04:26:20 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:20456 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhDHI0S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Apr 2021 04:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617870368; x=1649406368;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ppzGHzfKraWS8It9CI0IFaXO5eF/Irki2pf4weTXeMQ=;
  b=a/MaRqc7kfgyidRFVEPE971J7j82vXEqU/33a9t7k1HlK9dTEZ9JlPlb
   XJd7dgKWMNBW54ptwU9C7kv5VpCAh1g/4Z+8E2FJGEFb2UtOjYS9NNHf2
   NfrEJDRh13CgGVHDji706kp/m39SCYTjCnwCA4aWCfAlwxVfW+jyQzI1j
   Lmx5hANtAh16oANbjKGrd57Zjd2V5dkKa3pqfKV+Do2m7YZyIT/9ty3ok
   3KVi63lF9VG4A05XySv/4/Nuxhbw0lTm9+iXtFFTZGvKmEAy6Ra438z3P
   H8BtI8dCUZ00/6YFwXXnLlyu/9vQA8dkq2IZxvNmzamNQt9NFVqVgDRu7
   Q==;
IronPort-SDR: gwZ4QKAWoha03yI81qy108BeCg9bFsU9v9oiuYxe7OI82JccZctaijj+ITnvQDYWqq/yOZjHoE
 GBZvTMxIC/zFfh+QBuUgUjGxSILCQzZTNlDBaw3UpCZA637iI2QOG/Fs7h+cAuuvsESK6nqmQA
 I2Pvnoto8LNRqcYdQHTvsHoKXRbNfUCDqozTxYF7GNChaIB0BrL2fXU6k0vb5hkRfhvwPh+50n
 38qhDrGCSAAZW8FQE0xWB6g2yJLp+cLNQL4Rkq7lV4C4tsJNxFSNUMfyi7Rmgxol6J7nKum9M6
 RUw=
X-IronPort-AV: E=Sophos;i="5.82,205,1613404800"; 
   d="scan'208";a="268470974"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2021 16:25:52 +0800
IronPort-SDR: VlPZdU20wKDgc5XOEDHl1FlK2M4+bsQ+zHkznXisMBLKm3pZNHtjt6ycTZ2Rca59q1JNXLuuYX
 qWMT+/8Ncfo44j9MbfC+1zajVSfS3PQUp/nMLg/E90NbDeYGpQAg8wKP8WAGZYYNAycd1GS6CB
 Xz3ylgw7JMQEJbJ2Y3OqfQSpZGDdbXRg0JSAeFfC4DT404yPn+/FlPHwnkFkZk7nhBp0hdv+eO
 ae7ytrGitzAe9KlYFJ6Z3oUMDjGv/4qf9wy+G8b4tCOIDO3djisF+AhUAJVpOkC8oX4UN6e/K4
 pZco3tTdlReJHjiHIH1+mTN9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 01:05:26 -0700
IronPort-SDR: S6G+ouRa7ifIYc1WMGUrO8vC5/hQXT4hob+J8XnGX7tFTfJANGGLSoX4+3EH3n8uz5FUanYmN7
 z2ayWUJ3TBqwv48KtJN1x2YuJKJQhu40bRIXx/n9ffbfR7hpo16okmYd6qVqxj8QT2v52Tmj5O
 UPgR4QMw3Hphw126gwWaazQDb2TjmZtkGoxzNVsgtfySJlADmwOLbaPIfPhQ3kxjI1TjTytrEC
 uKLdVcS0naI9ZJz2vOb3Lp82jH9L0obN7EHFLXKCaPzZ9AF9idZA8o6zTZJnf0z50+2JcAghCe
 ySw=
WDCIronportException: Internal
Received: from wdmnc1493.ad.shared (HELO naota-xeon.wdc.com) ([10.225.51.53])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Apr 2021 01:25:45 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2] btrfs: zoned: move superblock logging zone location
Date:   Thu,  8 Apr 2021 17:25:28 +0900
Message-Id: <2f58edb74695825632c77349b000d31f16cb3226.1617870145.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This commit moves the location of the superblock logging zones. The new
locations of the logging zones are now determined based on fixed block
addresses instead of on fixed zone numbers.

The old placement method based on fixed zone numbers causes problems when
one needs to inspect a file system image without access to the drive zone
information. In such case, the super block locations cannot be reliably
determined as the zone size is unknown. By locating the superblock logging
zones using fixed addresses, we can scan a dumped file system image without
the zone information since a super block copy will always be present at or
after the fixed location.

This commit introduces the following three pairs of zones containing fixed
offset locations, regardless of the device zone size.

  - Primary superblock: zone starting at offset 0 and the following zone
  - First copy: zone containing offset 64GB and the following zone
  - Second copy: zone containing offset 256GB and the following zone

If a logging zone is outside of the disk capacity, we do not record the
superblock copy.

The first copy position is much larger than for a regular btrfs volume
(64M).  This increase is to avoid overlapping with the log zones for the
primary superblock. This higher location is arbitrary but allows supporting
devices with very large zone sizes, up to 32GB. Such large zone size is
unrealistic and very unlikely to ever be seen in real devices. Currently,
SMR disks have a zone size of 256MB, and we are expecting ZNS drives to be
in the 1-4GB range, so this 32GB limit gives us room to breathe. For now,
we only allow zone sizes up to 8GB, below this hard limit of 32GB.

The fixed location addresses are somewhat arbitrary, but with the intent of
maintaining superblock reliability even for smaller devices. For this
reason, the superblock fixed locations do not exceed 1TB.

The superblock logging zones are reserved for superblock logging and never
used for data or metadata blocks. Note that we only reserve the two zones
per primary/copy actually used for superblock logging. We do not reserve
the ranges of zones possibly containing superblocks with the largest
supported zone size (0-16GB, 64G-80GB, 256G-272GB).

The zones containing the fixed location offsets used to store superblocks
in a regular btrfs volume (no zoned case) are also reserved to avoid
confusion.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 1f972b75a9ab..a4b195fe08a0 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -21,9 +21,28 @@
 /* Pseudo write pointer value for conventional zone */
 #define WP_CONVENTIONAL ((u64)-2)
 
+/*
+ * Location of the first zone of superblock logging zone pairs.
+ * - Primary superblock: the zone containing offset 0 (zone 0)
+ * - First superblock copy: the zone containing offset 64G
+ * - Second superblock copy: the zone containing offset 256G
+ */
+#define BTRFS_PRIMARY_SB_LOG_ZONE 0ULL
+#define BTRFS_FIRST_SB_LOG_ZONE (64ULL * SZ_1G)
+#define BTRFS_SECOND_SB_LOG_ZONE (256ULL * SZ_1G)
+#define BTRFS_FIRST_SB_LOG_ZONE_SHIFT const_ilog2(BTRFS_FIRST_SB_LOG_ZONE)
+#define BTRFS_SECOND_SB_LOG_ZONE_SHIFT const_ilog2(BTRFS_SECOND_SB_LOG_ZONE)
+
 /* Number of superblock log zones */
 #define BTRFS_NR_SB_LOG_ZONES 2
 
+/*
+ * Maximum size of zones. Currently, SMR disks have a zone size of 256MB,
+ * and we are expecting ZNS drives to be in the 1-4GB range. We do not
+ * expect the zone size to become larger than 8GB in the near future.
+ */
+#define BTRFS_MAX_ZONE_SIZE SZ_8G
+
 static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx, void *data)
 {
 	struct blk_zone *zones = data;
@@ -111,11 +130,8 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 }
 
 /*
- * The following zones are reserved as the circular buffer on ZONED btrfs.
- *  - The primary superblock: zones 0 and 1
- *  - The first copy: zones 16 and 17
- *  - The second copy: zones 1024 or zone at 256GB which is minimum, and
- *                     the following one
+ * Get the zone number of the first zone of a pair of contiguous zones used
+ * for superblock logging.
  */
 static inline u32 sb_zone_number(int shift, int mirror)
 {
@@ -123,8 +139,8 @@ static inline u32 sb_zone_number(int shift, int mirror)
 
 	switch (mirror) {
 	case 0: return 0;
-	case 1: return 16;
-	case 2: return min_t(u64, btrfs_sb_offset(mirror) >> shift, 1024);
+	case 1: return 1 << (BTRFS_FIRST_SB_LOG_ZONE_SHIFT - shift);
+	case 2: return 1 << (BTRFS_SECOND_SB_LOG_ZONE_SHIFT - shift);
 	}
 
 	return 0;
@@ -300,10 +316,21 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 		zone_sectors = bdev_zone_sectors(bdev);
 	}
 
-	nr_sectors = bdev_nr_sectors(bdev);
 	/* Check if it's power of 2 (see is_power_of_2) */
 	ASSERT(zone_sectors != 0 && (zone_sectors & (zone_sectors - 1)) == 0);
 	zone_info->zone_size = zone_sectors << SECTOR_SHIFT;
+
+	/* We reject devices with a zone size larger than 8GB. */
+	if (zone_info->zone_size > BTRFS_MAX_ZONE_SIZE) {
+		btrfs_err_in_rcu(fs_info,
+				 "zoned: %s: zone size %llu is too large",
+				 rcu_str_deref(device->name),
+				 zone_info->zone_size);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	nr_sectors = bdev_nr_sectors(bdev);
 	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
 	zone_info->max_zone_append_size =
 		(u64)queue_max_zone_append_sectors(queue) << SECTOR_SHIFT;
-- 
2.31.1

