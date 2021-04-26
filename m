Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F4936AC28
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhDZG3B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:29:01 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41929 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbhDZG3A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418498; x=1650954498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sczYZgfONl8x2jLo9BD68Jlw4NkITHMuKlvjtlVTGug=;
  b=p68JrY97bYS53MwGnD0JWrNOED/EL3N2ZKQ9m36HqlrvnPad6dCLuY/e
   N3P6Y2CmNSw3ea+9vFhzDZHZlxfVXYpmzOnm4rWT5lkRxv6ngFxccOxxX
   j3wF81OVm0N7ZA6g+oanG9XZxS1yEzbcrzn1XTQhEAF0nODY/vn6rz9l5
   J/LgRxQwN3ZBduILJ/KK9h0b3w1bzpYC1GdN2jAevcTi+Bi5He5QHKuFr
   VDda50BNPkhCG5wews1GhVgkvqcDczRFksRBND5zWVsywhLzT3efaGIZW
   CiWCfEEC7BR7Z1XF7X2W2Ja5WwT77IRP5hzfX9S0VEFxF4ormR39BLspe
   Q==;
IronPort-SDR: XqI4I8y77pMiAsCUns5hlL4BefoEFW+4vnifiyfw9QNaM80uriz5iBGVnAFK2cxt/7rSBXl48N
 FKhSoKvz+F/Owme9UHxnXCD4krIzeD1Bwl6bpatDPCzYd+Z1USXuY7WlqHD8GJu1WgqwYPAfhc
 TNXbKq3p+yZJ1coHcvopGCE+FHP6ARSc60Wzdv18Mzr5BH/be5DrbeKXW5HecTsRNdoRVrQWKU
 Fn0hclDs3fhzJVYhi/xJth9FnCmQ/yAqBDFgysYN3CgHo1g1n6O72NK47zftFEpP4kDe1QZQk7
 yqo=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788121"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:18 +0800
IronPort-SDR: YMjep2Bt73icod7grhp+h6k2MjeFYiD9W3j01yoD+I7PBtxC4LglFUcjmu+tPJvmlLGEJd2atX
 gTOKLMZnn/xmz+cxcKBjJd7PRYH5GIlgAN82v9/8ije3SeCJJ7x0g8HrXh26oyLoIKoPS2ifbr
 BxVGzYOczQLVyZ1H+EtDWsag/c1ajcKoo/wZYulLBzShkD/ofx0UL29CwEqIAtEjbObcOFRnN8
 kmv4fHRuHi7rPLdxd3a1t7F5H9yldRwwc+yv40WJTOOikuXvdtXCaDqG2W6xmtuBDAUjY2WuLv
 v4A6CvWIbnkIvMvea2AOqbE8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:43 -0700
IronPort-SDR: MWBaLVLRjy4c/W//N9boEMwCB+wh/DJQ8VLKbeLFgXl4y90cn1fC43oeGWZAbkTL1Rg29aGP8B
 xLR7hd0WxejwECleghFkWjW6co1nJV+8QxB19FVbFd7zX4ZxMRUFt1TaQ7SsW85+mNoIzIrX16
 k2XAJs0gs+J00s60PAuKvn1LGQeEP+WYyg3y+Tl3qpDN5tWcR8hNLZW5ShO+uuUBmuFwHwh/H5
 7gWJJeGyupK568stXo8YX0YcNqbpDxI++s/+fVx7JoQT8tz9Er5Pl+pIsu6Uq3kzka6ENpfdg/
 l2w=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:18 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 09/26] btrfs-progs: zoned: allow zoned filesystems on non-zoned block devices
Date:   Mon, 26 Apr 2021 15:27:25 +0900
Message-Id: <3ecdd9e85e977d87443a503a41fc349944687d6c.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Run a zoned filesystem on non-zoned devices. This is done by "slicing up"
the block device into static sized chunks and fake a conventional zone on
each of them. The emulated zone size is determined from the size of device
extent.

This is mainly aimed at testing of zoned filesystems, i.e. the zoned chunk
allocator, on regular block devices.

Currently, we always use EMULATED_ZONE_SIZE (= 256MB) for the emulated zone
size. In the future, this will be customized by mkfs option.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kerncompat.h          |  1 +
 kernel-shared/zoned.c | 67 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/kerncompat.h b/kerncompat.h
index a39b79cba767..b2983ed60c4a 100644
--- a/kerncompat.h
+++ b/kerncompat.h
@@ -166,6 +166,7 @@ typedef long long s64;
 typedef int s32;
 #endif
 
+typedef u64 sector_t;
 
 struct vma_shared { int prio_tree_node; };
 struct vm_area_struct {
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 7b05fe6cc70f..ebaa2a81b2c8 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -14,6 +14,8 @@
 /* Maximum number of zones to report per ioctl(BLKREPORTZONE) call */
 #define BTRFS_REPORT_NR_ZONES   4096
 
+#define EMULATED_ZONE_SIZE SZ_256M
+
 static int btrfs_get_dev_zone_info(struct btrfs_device *device);
 
 enum btrfs_zoned_model zoned_model(const char *file)
@@ -51,6 +53,10 @@ u64 zone_size(const char *file)
 	char chunk[32];
 	int ret;
 
+	/* zoned emulation on regular device */
+	if (zoned_model(file) == ZONED_NONE)
+		return EMULATED_ZONE_SIZE;
+
 	ret = queue_param(file, "chunk_sectors", chunk, sizeof(chunk));
 	if (ret <= 0)
 		return 0;
@@ -71,6 +77,46 @@ u64 max_zone_append_size(const char *file)
 }
 
 #ifdef BTRFS_ZONED
+/*
+ * Emulate blkdev_report_zones() for a non-zoned device. It slices up the block
+ * device into static sized chunks and fake a conventional zone on each of
+ * them.
+ */
+static int emulate_report_zones(const char *file, int fd, u64 pos,
+				struct blk_zone *zones, unsigned int nr_zones)
+{
+	const sector_t zone_sectors = EMULATED_ZONE_SIZE >> SECTOR_SHIFT;
+	struct stat st;
+	sector_t bdev_size;
+	unsigned int i;
+	int ret;
+
+	ret = fstat(fd, &st);
+	if (ret < 0) {
+		error("unable to stat %s: %m", file);
+		return -EIO;
+	}
+
+	bdev_size = btrfs_device_size(fd, &st) >> SECTOR_SHIFT;
+
+	pos >>= SECTOR_SHIFT;
+	for (i = 0; i < nr_zones; i++) {
+		zones[i].start = i * zone_sectors + pos;
+		zones[i].len = zone_sectors;
+		zones[i].capacity = zone_sectors;
+		zones[i].wp = zones[i].start + zone_sectors;
+		zones[i].type = BLK_ZONE_TYPE_CONVENTIONAL;
+		zones[i].cond = BLK_ZONE_COND_NOT_WP;
+
+		if (zones[i].wp >= bdev_size) {
+			i++;
+			break;
+		}
+	}
+
+	return i;
+}
+
 static int report_zones(int fd, const char *file,
 			struct btrfs_zoned_device_info *zinfo)
 {
@@ -149,12 +195,23 @@ static int report_zones(int fd, const char *file,
 		rep->sector = sector;
 		rep->nr_zones = BTRFS_REPORT_NR_ZONES;
 
-		ret = ioctl(fd, BLKREPORTZONE, rep);
-		if (ret != 0) {
-			error("zoned: ioctl BLKREPORTZONE failed (%m)");
-			exit(1);
+		if (zinfo->model != ZONED_NONE) {
+			ret = ioctl(fd, BLKREPORTZONE, rep);
+			if (ret != 0) {
+				error("zoned: ioctl BLKREPORTZONE failed (%m)");
+				exit(1);
+			}
+		} else {
+			ret = emulate_report_zones(file, fd,
+						   sector << SECTOR_SHIFT,
+						   zone, BTRFS_REPORT_NR_ZONES);
+			if (ret < 0) {
+				error("zoned: failed to emulate BLKREPORTZONE");
+				exit(1);
+			}
 		}
 
+
 		if (!rep->nr_zones)
 			break;
 
@@ -231,8 +288,6 @@ int btrfs_get_zone_info(int fd, const char *file,
 
 	/* Check zone model */
 	model = zoned_model(file);
-	if (model == ZONED_NONE)
-		return 0;
 
 #ifdef BTRFS_ZONED
 	zinfo = calloc(1, sizeof(*zinfo));
-- 
2.31.1

