Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC2236AC33
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhDZG3P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:29:15 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41951 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbhDZG3J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418507; x=1650954507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V06DWIQPAuC54kVXygCBbgmdtbthaINtC6mttwoRURo=;
  b=Azc1DWxQpIFTyZzUbkQElGQxeiwN4svH5yKicNfldUcr7GP41CvsFiQM
   ghjwAAgiwtZIwaAz/d8W+LrlMy9LihJLSGk9pvNX1KBVagK5kZAHPNNSE
   crVpVRS9wNpt/8RajpQz/uCpvORygc0yxUEcRjhYjVsipD9/12O8YZJrp
   tRmNx7G4e1AKPb+lg0lYyxreevx3d0r/XLInquhZPJyLUdPB+UmqbQhlP
   kDm+X0RdfKji8JQ0CrH9E202tNoEhq8MGhmjwpudbmyMFNQD2/8SFEbCz
   hwqokL/eU4ztz5H3VCJHa+tn3vP7RYE9CHkROkdEowIqjyq/NxrNG+ya9
   Q==;
IronPort-SDR: dzfXKTM+VPEPTt3NegSYTZnF/LqoLkTNKFazmv/ocvtAbIl4+4mR5o35reOmImApKD10SfEU3z
 j8U0DjfejrYNicoQsFa6W/x4BMcidpB/DGyb60tn0t5BgSexDwC8PdhkjKN7C7rQyRE2TBlwV7
 EsWt62MGdL2xPEJPcOjQsWt6BcMz/uBTW+jL6pABpaMWVNkl5AEAPUrUzX2vdzIuqNdtFZj6Op
 iG77PGWxkRYb+HmG2A/4IqqPWOyv84vgpMXzsFDxz3uSnmRg+aJ2nxvh7BEVNcEc9c8zEzPJG7
 LVc=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788133"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:27 +0800
IronPort-SDR: 2QKZ9Z6RWn1/MRmtxQKtoFqzpBb0DOCnObOAzbVAkq8TVio6B+QVXQESk4Xczi4i+TcrTpPS6k
 8FM8RoDuvqfzEY+4QFla03PvzL9B2CX4fEDZoeBBvGvVDByE2hTD2j4psHGyCJV62ZELDGKxio
 DJ/Tl/wnZbMefTp+2jnyaW1GHP8V1z1kga4d/1wGXNmkslAIAf0EM9Y0rGz8qcLqb8O5CJoxHX
 c3MUjFWh+COFI0jCLrCpGqTK3RFxBUI/ITAbz31NCrfzKP76aDrgTTnWhrIBPnxZjpII0MhDbW
 BtNEfcz6sORswpNfvFj0bG0R
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:51 -0700
IronPort-SDR: 1SjEG1dBd9BnnjnTgZ8RBbFIwgtaEZ9463LtcKuJhSmtFjrbIEiZG2fKHQ8lBTPatrBzTu2MWs
 /YMVa+WfP3N3xaXrPaZQf5NRewUx77tmuNTUtFakJ1P2Rika6mdvEQv4rd73dsYUDMBB0b+o/+
 wI47uiFOcM3dZo72KDuLaEXtYWrmSb1Nixuh3bgkeUHqyYqqFH3hO00cdu7XrF9edKzuVIiK9Z
 cxVVScBLVp7zRsl/YuSD5+w3bAQOt695p5ubwpp/9eW6tMelcbSnVzZJND8DMQt5QtZDcQPQSL
 5YE=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:27 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 17/26] btrfs-progs: zoned: support resetting zoned device
Date:   Mon, 26 Apr 2021 15:27:33 +0900
Message-Id: <cb5ce84c0621e714bdbf57a5ad6935444fecfd92.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All zones of zoned block devices should be reset before writing. Support
this by introducing PREP_DEVICE_ZONED.

btrfs_reset_all_zones() walk all the zones on a device, and reset a zone if
it is sequential required zone, or discard the zone range otherwise.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/device-utils.c | 35 +++++++++++++++++++++++++++++++----
 common/device-utils.h |  2 ++
 kernel-shared/zoned.c | 33 +++++++++++++++++++++++++++++++++
 kernel-shared/zoned.h |  7 +++++++
 4 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index f5d5277e8fce..2687f1884619 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -25,6 +25,7 @@
 #include <blkid/blkid.h>
 #include "kernel-lib/sizes.h"
 #include "kernel-shared/disk-io.h"
+#include "kernel-shared/zoned.h"
 #include "common/device-utils.h"
 #include "common/internal.h"
 #include "common/messages.h"
@@ -49,7 +50,7 @@ static int discard_range(int fd, u64 start, u64 len)
 /*
  * Discard blocks in the given range in 1G chunks, the process is interruptible
  */
-static int discard_blocks(int fd, u64 start, u64 len)
+int discard_blocks(int fd, u64 start, u64 len)
 {
 	while (len > 0) {
 		/* 1G granularity */
@@ -155,6 +156,7 @@ out:
 int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 		u64 max_block_count, unsigned opflags)
 {
+	struct btrfs_zoned_device_info *zinfo = NULL;
 	u64 block_count;
 	struct stat st;
 	int i, ret;
@@ -173,7 +175,27 @@ int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 	if (max_block_count)
 		block_count = min(block_count, max_block_count);
 
-	if (opflags & PREP_DEVICE_DISCARD) {
+	if (opflags & PREP_DEVICE_ZONED) {
+		ret = btrfs_get_zone_info(fd, file, &zinfo);
+		if (ret < 0 || !zinfo) {
+			error("zoned: unable to load zone information of %s",
+			      file);
+			return 1;
+		}
+		if (opflags & PREP_DEVICE_VERBOSE)
+			printf("Resetting device zones %s (%u zones) ...\n",
+			       file, zinfo->nr_zones);
+		/*
+		 * We cannot ignore zone reset errors for a zoned block
+		 * device as this could result in the inability to write to
+		 * non-empty sequential zones of the device.
+		 */
+		if (btrfs_reset_all_zones(fd, zinfo)) {
+			error("zoned: failed to reset device '%s' zones: %m",
+			      file);
+			goto err;
+		}
+	} else if (opflags & PREP_DEVICE_DISCARD) {
 		/*
 		 * We intentionally ignore errors from the discard ioctl.  It
 		 * is not necessary for the mkfs functionality but just an
@@ -198,17 +220,22 @@ int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 	if (ret < 0) {
 		errno = -ret;
 		error("failed to zero device '%s': %m", file);
-		return 1;
+		goto err;
 	}
 
 	ret = btrfs_wipe_existing_sb(fd);
 	if (ret < 0) {
 		error("cannot wipe superblocks on %s", file);
-		return 1;
+		goto err;
 	}
 
+	free(zinfo);
 	*block_count_ret = block_count;
 	return 0;
+
+err:
+	free(zinfo);
+	return 1;
 }
 
 u64 btrfs_device_size(int fd, struct stat *st)
diff --git a/common/device-utils.h b/common/device-utils.h
index d1799323d002..e7e638a57eb2 100644
--- a/common/device-utils.h
+++ b/common/device-utils.h
@@ -23,7 +23,9 @@
 #define	PREP_DEVICE_ZERO_END	(1U << 0)
 #define	PREP_DEVICE_DISCARD	(1U << 1)
 #define	PREP_DEVICE_VERBOSE	(1U << 2)
+#define	PREP_DEVICE_ZONED	(1U << 3)
 
+int discard_blocks(int fd, u64 start, u64 len);
 u64 get_partition_size(const char *dev);
 u64 disk_size(const char *path);
 u64 btrfs_device_size(int fd, struct stat *st);
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 22e0245abaf6..ba1399cce04d 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -361,6 +361,39 @@ static int report_zones(int fd, const char *file,
 	return 0;
 }
 
+/*
+ * Discard blocks in the zones of a zoned block device. Process this with
+ * zone size granularity so that blocks in conventional zones are discarded
+ * using discard_range and blocks in sequential zones are reset though a
+ * zone reset.
+ */
+int btrfs_reset_all_zones(int fd, struct btrfs_zoned_device_info *zinfo)
+{
+	unsigned int i;
+	int ret = 0;
+
+	ASSERT(zinfo);
+
+	/* Zone size granularity */
+	for (i = 0; i < zinfo->nr_zones; i++) {
+		if (zinfo->zones[i].type == BLK_ZONE_TYPE_CONVENTIONAL) {
+			ret = discard_blocks(fd,
+					     zinfo->zones[i].start << SECTOR_SHIFT,
+					     zinfo->zone_size);
+			if (ret == EOPNOTSUPP)
+				ret = 0;
+		} else if (zinfo->zones[i].cond != BLK_ZONE_COND_EMPTY) {
+			ret = btrfs_reset_dev_zone(fd, &zinfo->zones[i]);
+		} else {
+			ret = 0;
+		}
+
+		if (ret)
+			return ret;
+	}
+	return fsync(fd);
+}
+
 static int sb_log_location(int fd, struct blk_zone *zones, int rw,
 			   u64 *bytenr_ret)
 {
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index 70044acc4d94..88831d2d787c 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -91,6 +91,7 @@ bool btrfs_redirty_extent_buffer_for_zoned(struct btrfs_fs_info *fs_info,
 					   u64 start, u64 end);
 int btrfs_reset_chunk_zones(struct btrfs_fs_info *fs_info, u64 devid,
 			    u64 offset, u64 length);
+int btrfs_reset_all_zones(int fd, struct btrfs_zoned_device_info *zinfo);
 #else
 #define sbread(fd, buf, offset) \
 	pread64(fd, buf, BTRFS_SUPER_INFO_SIZE, offset)
@@ -138,6 +139,12 @@ static inline int btrfs_reset_chunk_zones(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+static inline int btrfs_reset_all_zones(int fd,
+					struct btrfs_zoned_device_info *zinfo)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* BTRFS_ZONED */
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.31.1

