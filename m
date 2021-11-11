Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764DC44D15E
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 06:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhKKFRd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 00:17:33 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:53822 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhKKFRc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 00:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636607683; x=1668143683;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v5/AUiTf7t2lXMJ8zjhYKatkx7rIUfQ9ApzTdAIZ7Eo=;
  b=j1xBanAKosGasQ/8EuAuRI9BLYzxnGZVkPzEG4ek3J4jxBbVNE0s1CEv
   kibsRivEX0bfzakA6IWv0Vi8z+c30sfC54nQgD/usR1Vh6b0lmIsd4eQj
   WJeU8t2piGwNUnWpSzCxR/+W+d9SgRXtkxCgpNKm9ips8M74gNTeVhpWc
   nt0UVt7SAxXVP0YbzCEtmbEYPQBP4Z2fBki5ig/GTaSu8y2vfbCxrX1JT
   uzGbqUEJCOGA8RT2/QWH6+el3lnIQ5/XHbcIIOBzoBzgvabz9NIp/Tqqf
   Ke4NAX65QmjX4C2HV2657+HCHqvBCcIkPOvgZLgRwaEX4XisWVMN1dNPe
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,225,1631548800"; 
   d="scan'208";a="190115898"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2021 13:14:43 +0800
IronPort-SDR: 8XrdU3VZxHMhk4PrLNvC7NEJYSG632YhKKFfFtTI6UgTMLkNDn63+IUEIChuhJN8HRA4jKyfbf
 xytMp6vAGCQIQrbscuVMC+UgLNqRfd2vB6EgQXGhvS3jxQucP8ryc55qBZhPUz5e2ZsTyAKxEZ
 NVMskuC+Cd7G2hYwk89Fn+PP/t4K/Xo7WSjQASmcuUZmQu+HHz2gUn2Mm+QEMh8zDRCjnsOUqL
 C67+RzHeenKTTQ29ketKxPLRYy018Uw3IYaFPiv+ekM4HO3umUMSemYuDRXTShWsgxFgFVIuWz
 M9M66UU59Ta0jx8g+S0bPl3k
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 20:48:20 -0800
IronPort-SDR: kL/Bcsqa7w3O2FtYG005GEitihZXBZQ1KF8tg8IxSoq1BbrYz2dYHddH/WI33jD4ZDdv/p2hv1
 JeibkamfvAuwj4eYmmtGvxE4Pr8PlucEvVcCVtOg9hztEnV7Rgii4nl6vU4P2zvPZNubENT631
 rqYBF583rDptzD62ww8d3GG3dM8ywdEir+mQZHyJT6bocmooA0m8V5U0qMLaaWRj2JNJz0h5Dv
 ZoTOlclAR3yZRiR60JdP0/DOD6l+c9DI3NF1v0qI8AepHqCU2oIYCZcbCzOIjkmhorAQrwVj7n
 3kg=
WDCIronportException: Internal
Received: from jpf009847.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.133])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Nov 2021 21:14:44 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: cache reported zone during mount
Date:   Thu, 11 Nov 2021 14:14:38 +0900
Message-Id: <20211111051438.4081012-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When mounting a device, we are reporting the zones twice: once for
checking the zone attributes in btrfs_get_dev_zone_info and once for
loading block groups' zone info in
btrfs_load_block_group_zone_info(). With a lot of block groups, that
leads to a lot of REPORT ZONE commands and slows down the mount
process.

This patch introduces a zone info cache in struct
btrfs_zoned_device_info. The cache is populated while in
btrfs_get_dev_zone_info() and used for
btrfs_load_block_group_zone_info() to reduce the number of REPORT ZONE
commands. The zone cache is then released after loading the block
groups, as it will not be much effective during the run time.

Benchmark: Mount an HDD with 57,007 block groups
Before patch: 171.368 seconds
After patch: 64.064 seconds

While it still takes a minute due to the slowness of loading all the
block groups, the patch reduces the mount time by 1/3.

Link: https://lore.kernel.org/linux-btrfs/CAHQ7scUiLtcTqZOMMY5kbWUBOhGRwKo6J6wYPT5WY+C=cD49nQ@mail.gmail.com/
Fixes: 5b316468983d ("btrfs: get zone information of zoned block devices")
CC: stable@vger.kernel.org
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/dev-replace.c |  2 +-
 fs/btrfs/disk-io.c     |  2 ++
 fs/btrfs/volumes.c     |  2 +-
 fs/btrfs/zoned.c       | 78 +++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/zoned.h       |  8 +++--
 5 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index a39987e020e3..1c91f2203da4 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -323,7 +323,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
 	device->fs_devices = fs_info->fs_devices;
 
-	ret = btrfs_get_dev_zone_info(device);
+	ret = btrfs_get_dev_zone_info(device, false);
 	if (ret)
 		goto error;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 847aabb30676..369f84ff6bd3 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3563,6 +3563,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_sysfs;
 	}
 
+	btrfs_free_zone_cache(fs_info);
+
 	if (!sb_rdonly(sb) && fs_info->fs_devices->missing_devices &&
 	    !btrfs_check_rw_degradable(fs_info, NULL)) {
 		btrfs_warn(fs_info,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 45c91a2f172c..dd1cbbb73ef0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2667,7 +2667,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	device->fs_info = fs_info;
 	device->bdev = bdev;
 
-	ret = btrfs_get_dev_zone_info(device);
+	ret = btrfs_get_dev_zone_info(device, false);
 	if (ret)
 		goto error_free_device;
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 67d932d70798..2300d9eff69a 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -213,6 +213,9 @@ static int emulate_report_zones(struct btrfs_device *device, u64 pos,
 static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 			       struct blk_zone *zones, unsigned int *nr_zones)
 {
+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
+	struct blk_zone *zone_info;
+	u32 zno;
 	int ret;
 
 	if (!*nr_zones)
@@ -224,6 +227,32 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 		return 0;
 	}
 
+	if (zinfo->zone_cache) {
+		/* Check cache */
+		unsigned int i;
+
+		ASSERT(IS_ALIGNED(pos, zinfo->zone_size));
+		zno = pos >> zinfo->zone_size_shift;
+		/*
+		 * We cannot report zones beyond the zone end. So, it
+		 * is OK to cap *nr_zones to at the end.
+		 */
+		*nr_zones = min_t(u32, *nr_zones, zinfo->nr_zones - zno);
+
+		for (i = 0; i < *nr_zones; i++) {
+			zone_info = &zinfo->zone_cache[zno + i];
+			if (!zone_info->len)
+				break;
+		}
+
+		if (i == *nr_zones) {
+			/* Cache hit on all the zones */
+			memcpy(zones, zinfo->zone_cache + zno,
+			       sizeof(*zinfo->zone_cache) * *nr_zones);
+			return 0;
+		}
+	}
+
 	ret = blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT, *nr_zones,
 				  copy_zone_info_cb, zones);
 	if (ret < 0) {
@@ -237,6 +266,11 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 	if (!ret)
 		return -EIO;
 
+	/* Populate cache */
+	if (zinfo->zone_cache)
+		memcpy(zinfo->zone_cache + zno, zones,
+		       sizeof(*zinfo->zone_cache) * *nr_zones);
+
 	return 0;
 }
 
@@ -300,7 +334,7 @@ int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
 		if (!device->bdev)
 			continue;
 
-		ret = btrfs_get_dev_zone_info(device);
+		ret = btrfs_get_dev_zone_info(device, true);
 		if (ret)
 			break;
 	}
@@ -309,7 +343,7 @@ int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
-int btrfs_get_dev_zone_info(struct btrfs_device *device)
+int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
 	struct btrfs_zoned_device_info *zone_info = NULL;
@@ -407,6 +441,25 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 		goto out;
 	}
 
+	/*
+	 * Enable zone cache only for a zoned device. On a non-zoned
+	 * device, we fill the zone info with emulated CONVENTIONAL
+	 * zones, so no need to use the cache.
+	 */
+	if (populate_cache && bdev_is_zoned(device->bdev)) {
+		zone_info->zone_cache = vzalloc(sizeof(struct blk_zone) *
+						zone_info->nr_zones);
+		if (!zone_info->zone_cache) {
+			btrfs_err_in_rcu(device->fs_info,
+					 "zoned: failed to allocate zone cache for %s",
+					 rcu_str_deref(device->name));
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+
+	device->zone_info = zone_info;
+
 	/* Get zones type */
 	nactive = 0;
 	while (sector < nr_sectors) {
@@ -505,8 +558,6 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 
 	kfree(zones);
 
-	device->zone_info = zone_info;
-
 	switch (bdev_zoned_model(bdev)) {
 	case BLK_ZONED_HM:
 		model = "host-managed zoned";
@@ -542,6 +593,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 	bitmap_free(zone_info->active_zones);
 	bitmap_free(zone_info->empty_zones);
 	bitmap_free(zone_info->seq_zones);
+	vfree(zone_info->zone_cache);
 	kfree(zone_info);
 	device->zone_info = NULL;
 
@@ -1973,3 +2025,21 @@ void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg)
 		fs_info->data_reloc_bg = 0;
 	spin_unlock(&fs_info->relocation_bg_lock);
 }
+
+void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_device *device;
+
+	if (!btrfs_is_zoned(fs_info))
+		return;
+
+	mutex_lock(&fs_devices->device_list_mutex);
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		if (device->zone_info) {
+			vfree(device->zone_info->zone_cache);
+			device->zone_info->zone_cache = NULL;
+		}
+	}
+	mutex_unlock(&fs_devices->device_list_mutex);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index e53ab7b96437..4344f4818389 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -28,6 +28,7 @@ struct btrfs_zoned_device_info {
 	unsigned long *seq_zones;
 	unsigned long *empty_zones;
 	unsigned long *active_zones;
+	struct blk_zone *zone_cache;
 	struct blk_zone sb_zones[2 * BTRFS_SUPER_MIRROR_MAX];
 };
 
@@ -35,7 +36,7 @@ struct btrfs_zoned_device_info {
 int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 		       struct blk_zone *zone);
 int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info);
-int btrfs_get_dev_zone_info(struct btrfs_device *device);
+int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
 int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
 int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info);
@@ -76,6 +77,7 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices,
 void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical,
 			     u64 length);
 void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg);
+void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -88,7 +90,8 @@ static inline int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_i
 	return 0;
 }
 
-static inline int btrfs_get_dev_zone_info(struct btrfs_device *device)
+static inline int btrfs_get_dev_zone_info(struct btrfs_device *device,
+					  bool populate_cache)
 {
 	return 0;
 }
@@ -232,6 +235,7 @@ static inline void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info,
 
 static inline void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg) { }
 
+static inline void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info) { }
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.33.1

