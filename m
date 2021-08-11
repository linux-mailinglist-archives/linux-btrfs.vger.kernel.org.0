Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E753E9389
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 16:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhHKOV0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 10:21:26 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35974 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbhHKOVS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 10:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628691654; x=1660227654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kG9oyVK4uriKrldIlVDu3CcbJPeRplp/sY3XvsDRWIQ=;
  b=AzirkQdItF84K1zrKPVy5GEnhhz1i1BXa08hNd6ydNGrUqV/HJCbAi4t
   0UpVgCszElIsuXoL+mVL07I1omMj8lWaSlUX9m59BJfcGsND78mXvi+XB
   lt1d165GsrLUWPzpFcIVuWtS8lr2ekVjSgDk5KoYXaIsBQ8lSn7PvQq+k
   w/+FVFw1Rq25RlGUDXSR4a7ErIXqQWawjCAf2dNyvfWeRvp8tZAjJ8CVM
   7JSK8yTXWdJ6loEflvR0QLKexADphyYUcf2klDdiuNoo/WhZiqdNBvDbN
   EL/+5gavFrsfyHJz7VrFBjtV6l8kPiTv7ACUGht/t528s/SEKkU0IZySE
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="176937886"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 22:20:54 +0800
IronPort-SDR: 7L8vqEDGTkWN/hiNEuuAPo8ZIXTINxzmD5LUjLVydgvkW74LXfAS/VmanD5myjBIz3kkiGtxKS
 U4m9KZ09euSsTlqSMsuyXuG/W/2ZcOjAIX9QNg8HIg86FWroI/MKFelsVTtLwaGkL4gkE10Ixg
 EVNJbqsGWp/DaIU4Cm5YBDkf2CHRxPA7lMeey0No0ExRStzDyhTlbLmxqIpDBCEdWV10PL9c7/
 1vLr7w2qfXtHBakPxmbHAQlz/w/ojF4h6Tm0kLHwRJRJe5wfyYc5UqFfgF9Zvrot7EkfKHRXL6
 sM0youl3VA6OLvNBahtwIsvf
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 06:56:24 -0700
IronPort-SDR: Y40RXFQLXECkqXFrXWC63MxtrD2TL6GUjAnac6qNOO5al0u0G0vTBlxeP6CwKdbDtRM8IKLdyr
 AxnlYoYtngWQ6VO8KtHDExA7iDvZJUE9Xp4InHXbHKbNkVfsjthS9B666ib60Ivpr57X7oHvVd
 gnKBzwWDZ48t6lkw/YLeDA5DOS1mYzadVBKIqFiJmAITLdWqQaIeDA7WAzL5LH3dE7vgmw2Mks
 mZzjcycLOUKI8jP8cbydmRB3jMHdIa7KyYHhP8WX525dooSlDPZoGR4IyX9Gq06HIzpBvj/NGt
 zuA=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Aug 2021 07:20:54 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 08/17] btrfs: zoned: load active zone information from devices
Date:   Wed, 11 Aug 2021 23:16:32 +0900
Message-Id: <9e15c87886a2280dde1c9b1591ea8901af713341.1628690222.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628690222.git.naohiro.aota@wdc.com>
References: <cover.1628690222.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The ZNS specification defines a limit on the number of zones that can be in
the implicit open, explicit open or closed conditions. Any zone with such
condition is defined as an active zone and correspond to any zone that is
being written or that has been only partially written. If the maximum
number of active zones is reached, we must either reset or finish some
active zones before being able to chose other zones for storing data.

Load queue_max_active_zones() and track the number of active zones left on
the device.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/zoned.h |  3 +++
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 3eb74542a9b1..a198ce073353 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -4,6 +4,7 @@
 #include <linux/slab.h>
 #include <linux/blkdev.h>
 #include <linux/sched/mm.h>
+#include <linux/atomic.h>
 #include "ctree.h"
 #include "volumes.h"
 #include "zoned.h"
@@ -38,6 +39,15 @@
 /* Number of superblock log zones */
 #define BTRFS_NR_SB_LOG_ZONES 2
 
+/* Number of minimal activate zones we want.
+ *
+ * - BTRFS_SUPER_MIRROR_MAX zones for superblock mirrors
+ * - 3 zones to ensure at least one zone per SYSTEM, META and DATA block group
+ * - 1 zone for tree-log dedicated block group
+ * - 1 zone for relocation
+ */
+#define BTRFS_MIN_ACTIVE_ZONES (BTRFS_SUPER_MIRROR_MAX + 5)
+
 /*
  * Maximum supported zone size. Currently, SMR disks have a zone size of
  * 256MiB, and we are expecting ZNS drives to be in the 1-4GiB range. We do not
@@ -303,6 +313,9 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 	struct btrfs_fs_info *fs_info = device->fs_info;
 	struct btrfs_zoned_device_info *zone_info = NULL;
 	struct block_device *bdev = device->bdev;
+	struct request_queue *queue = bdev_get_queue(bdev);
+	unsigned int max_active_zones;
+	unsigned int nactive;
 	sector_t nr_sectors;
 	sector_t sector = 0;
 	struct blk_zone *zones = NULL;
@@ -358,6 +371,17 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 	if (!IS_ALIGNED(nr_sectors, zone_sectors))
 		zone_info->nr_zones++;
 
+	max_active_zones = queue_max_active_zones(queue);
+	if (max_active_zones && max_active_zones < BTRFS_MIN_ACTIVE_ZONES) {
+		btrfs_err_in_rcu(fs_info,
+"zoned: %s: max active zones %u is too small. Need at least %u active zones",
+				 rcu_str_deref(device->name), max_active_zones,
+				 BTRFS_MIN_ACTIVE_ZONES);
+		ret = -EINVAL;
+		goto out;
+	}
+	zone_info->max_active_zones = max_active_zones;
+
 	zone_info->seq_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
 	if (!zone_info->seq_zones) {
 		ret = -ENOMEM;
@@ -370,6 +394,12 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 		goto out;
 	}
 
+	zone_info->active_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
+	if (!zone_info->active_zones) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	zones = kcalloc(BTRFS_REPORT_NR_ZONES, sizeof(struct blk_zone), GFP_KERNEL);
 	if (!zones) {
 		ret = -ENOMEM;
@@ -377,6 +407,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 	}
 
 	/* Get zones type */
+	nactive = 0;
 	while (sector < nr_sectors) {
 		nr_zones = BTRFS_REPORT_NR_ZONES;
 		ret = btrfs_get_dev_zones(device, sector << SECTOR_SHIFT, zones,
@@ -387,8 +418,17 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 		for (i = 0; i < nr_zones; i++) {
 			if (zones[i].type == BLK_ZONE_TYPE_SEQWRITE_REQ)
 				__set_bit(nreported, zone_info->seq_zones);
-			if (zones[i].cond == BLK_ZONE_COND_EMPTY)
+			switch (zones[i].cond) {
+			case BLK_ZONE_COND_EMPTY:
 				__set_bit(nreported, zone_info->empty_zones);
+				break;
+			case BLK_ZONE_COND_IMP_OPEN:
+			case BLK_ZONE_COND_EXP_OPEN:
+			case BLK_ZONE_COND_CLOSED:
+				__set_bit(nreported, zone_info->active_zones);
+				nactive++;
+				break;
+			}
 			nreported++;
 		}
 		sector = zones[nr_zones - 1].start + zones[nr_zones - 1].len;
@@ -403,6 +443,19 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 		goto out;
 	}
 
+	if (max_active_zones) {
+		if (nactive > max_active_zones) {
+			btrfs_err_in_rcu(device->fs_info,
+			"zoned: %d active zones on %s exceeds max_active_zones %d",
+					 nactive, rcu_str_deref(device->name),
+					 max_active_zones);
+			ret = -EIO;
+			goto out;
+		}
+		atomic_set(&zone_info->active_zones_left,
+			   max_active_zones - nactive);
+	}
+
 	/* Validate superblock log */
 	nr_zones = BTRFS_NR_SB_LOG_ZONES;
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
@@ -485,6 +538,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 out:
 	kfree(zones);
 out_free_zone_info:
+	bitmap_free(zone_info->active_zones);
 	bitmap_free(zone_info->empty_zones);
 	bitmap_free(zone_info->seq_zones);
 	kfree(zone_info);
@@ -500,6 +554,7 @@ void btrfs_destroy_dev_zone_info(struct btrfs_device *device)
 	if (!zone_info)
 		return;
 
+	bitmap_free(zone_info->active_zones);
 	bitmap_free(zone_info->seq_zones);
 	bitmap_free(zone_info->empty_zones);
 	kfree(zone_info);
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 4f30f3bf1886..48628782e4b8 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -23,8 +23,11 @@ struct btrfs_zoned_device_info {
 	u64 zone_size;
 	u8  zone_size_shift;
 	u32 nr_zones;
+	unsigned int max_active_zones;
+	atomic_t active_zones_left;
 	unsigned long *seq_zones;
 	unsigned long *empty_zones;
+	unsigned long *active_zones;
 	struct blk_zone sb_zones[2 * BTRFS_SUPER_MIRROR_MAX];
 };
 
-- 
2.32.0

