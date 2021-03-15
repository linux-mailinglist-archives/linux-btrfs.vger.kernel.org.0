Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D8A33AB4B
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 06:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhCOFyw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 01:54:52 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:23258 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhCOFyu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 01:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615787689; x=1647323689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YBiHwKYdCZwUugI48jTeMKshfcHKsnEt/GiGHHD72LM=;
  b=C+cgwMvBkM8Tp4dKK0exgOjzZWiQHEHoLljzcdy4tlNuD2JmueRygQLb
   v1hvNrN/lJFhdOhq8g+RSrU6yWCb7095EIEqwaU9I99UMrNv8S22puaSW
   g7ahYNpZtInmvqK4oCI8tdayhCBUsRD7w7obb5yu7VSzXkIuGyYrXUMKv
   OIR0pA6CamR/jRiLX9Cz2jFG7AeF100k3bemRQ4o0loX4Q1fQGmbe91da
   41E7vAzZvsfPHhq2chp+zRkKELFgxjgMeO5lyJdS7mPW/bX/MXkeBae7E
   QXcpGOn/qGaoNDJHc6wuGtjaWVpfCYsmSwG7wH8vjVcKI8xdRytda3ZJ1
   g==;
IronPort-SDR: uvhxIWdbZ5x+ZHyax8ULz9+t6Cu3AIbr2EPwkpYE19LcC/wnJyxSjijtN4ptH2oKM3evdCtpSS
 zc8xABfAGX2Gc8TiY5DOV1vNmlVtRIwv0NxFbzWsrfNvQc02Ydy5z1JPn2DZIWsIceso0cCrPD
 0h3KQGmIU1dgyC2+vUUle6NflNjRySEcfgS+Aag7FQ3PbmwWeFHIh931IjuPwROQXN0JoxSLlm
 GNVMVSxSaC+k2OOrXFEWNNbawqUb9ND985LTu2XIo0BDMjmlAjydfu5LMfqBc5+c687rzN0DnA
 WjE=
X-IronPort-AV: E=Sophos;i="5.81,249,1610380800"; 
   d="scan'208";a="272850829"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2021 13:54:47 +0800
IronPort-SDR: +uF4anNtPvby4OLp1LBfMgbp0tGH4xlBCf43wLdAqulXdlkZlfOKmSk0JGFqMcc184+7LA8O2f
 QDlz/1YPKGDwTZlDRyM16qILN058oTvPhrSq/1wrhHe3smgdMmSXmMpUqzeMg/tlUHi/Tp5nIO
 rQlEiXYlr/YEvVS9Frj2brWgNs/sTiSb7Shu4arSuQF7eIwvK7mVQ5gk9Q+Qp7XKaoWozQ5lsY
 bPstYEPaIbwJUIKCXjUU3OmIYWXp9bo6pgWXXGZ5dGWCqtpveTorKmedCMHBqkCe84JTTIXBYf
 7Q5SzDrSZtDiB6I0+aPc10s1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2021 22:37:16 -0700
IronPort-SDR: vevqda7f/c4wU72qeAmR9cMNgSII7h3k3D2wau5smc+gL85iIaUmxD/TQUI/0WWqALGuo5Ad/D
 +BbCg+fP2tClSfALbYAw+94Jmyzzrf+Urr4EuerpZ9wJmsP1mRwYv9Z+CRrf7/qQnpD7+8rnYK
 sjf7CamWhbVvaU1J+LQjnBEQpUmxzxsZ89YJ97+138dchBilI72pFx87JuCIQY7eEd0xpzQIFZ
 YQRZvbJqSUaX72djLb7GHWdPoAr8dURUoqtm02Ymq1rg3JpvW9o0sLRexZKJNuOzAWsMgKPG2D
 ieY=
WDCIronportException: Internal
Received: from ind007401.ad.shared (HELO naota-xeon.wdc.com) ([10.225.51.60])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Mar 2021 22:54:46 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: move superblock logging zone location
Date:   Mon, 15 Mar 2021 14:53:03 +0900
Message-Id: <931d8d8a1eb757a1109ffcb36e592d2c0889d304.1615787415.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1615773143.git.naohiro.aota@wdc.com>
References: <cover.1615773143.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This commit moves the location of superblock logging zones. The location of
the logging zones are determined based on fixed block addresses instead of
on fixed zone numbers.

By locating the superblock zones using fixed addresses, we can scan a
dumped file system image without the zone information. And, no drawbacks
exist.

We use the following three pairs of zones containing fixed offset
locations, regardless of the device zone size.

  - Primary superblock: zone starting at offset 0 and the following zone
  - First copy: zone containing offset 64GB and the following zone
  - Second copy: zone containing offset 256GB and the following zone

If the location of the zones are outside of disk, we don't record the
superblock copy.

These addresses are arbitrary, but using addresses that are too large
reduces superblock reliability for smaller devices, so we do not want to
exceed 1T to cover all case nicely.

Also, LBAs are generally distributed initially across one head (platter
side) up to one or more zones, then go on the next head backward (the other
side of the same platter), and on to the following head/platter. Thus using
non sequential fixed addresses for superblock logging, such as 0/64G/256G,
likely result in each superblock copy being on a different head/platter
which improves chances of recovery in case of superblock read error.

These zones are reserved for superblock logging and never used for data or
metadata blocks. Zones containing the offsets used to store superblocks in
a regular btrfs volume (no zoned case) are also reserved to avoid
confusion.

Note that we only reserve the 2 zones per primary/copy actually used for
superblock logging. We don't reserve the ranges possibly containing
superblock with the largest supported zone size (0-16GB, 64G-80GB,
256G-272GB).

The first copy position is much larger than for a regular btrfs volume
(64M).  This increase is to avoid overlapping with the log zones for the
primary superblock. This higher location is arbitrary but allows supporting
devices with very large zone size, up to 32GB. But we only allow zone sizes
up to 8GB for now.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 43948bd40e02..6a72ca1f7988 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -21,9 +21,24 @@
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
 
+/* Max size of supported zone size */
+#define BTRFS_MAX_ZONE_SIZE SZ_8G
+
 static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx, void *data)
 {
 	struct blk_zone *zones = data;
@@ -111,11 +126,8 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
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
@@ -123,8 +135,8 @@ static inline u32 sb_zone_number(int shift, int mirror)
 
 	switch (mirror) {
 	case 0: return 0;
-	case 1: return 16;
-	case 2: return min_t(u64, btrfs_sb_offset(mirror) >> shift, 1024);
+	case 1: return 1 << (BTRFS_FIRST_SB_LOG_ZONE_SHIFT - shift);
+	case 2: return 1 << (BTRFS_SECOND_SB_LOG_ZONE_SHIFT - shift);
 	}
 
 	return 0;
@@ -300,10 +312,21 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
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
2.30.2

