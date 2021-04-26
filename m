Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D09F36AC31
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhDZG3N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:29:13 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41951 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhDZG3K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418508; x=1650954508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P5lV0K+qJTEhuwTW3AJRQ0wX1wtPNylRcGOWbVn2pbk=;
  b=Axg2XnMvXvbROyuskQcqMln7JDWfL9MqOIM5ag9l7Jiz3IpAdW2lSuVk
   e3gxvNKAqLR/NN2GYcVZnHqg/Y5Bd0akxKiU8UpdCRTTH0I995VEqKw2W
   MXNsDNMX3Y9SvQSkLbrKT+aOn96jB1cbj7fBanG2bJ+4Clxz7bcKRk7Hi
   PluA9Dxz9djPzdc9JeME1mbgB8UmT3Ry/U5/Pkrr7kCPoXzP0g1yFNywl
   YcEeHLnz9PF1NVozsqDDxUhBF3Fg6bkO7rEf5JoHrrjGlI0dT42FK3ndj
   ACQjdRCMOrfPYm4B4MutzZtLzWiqd/LEd02PcscMPy9EfpQUgNO09sObG
   Q==;
IronPort-SDR: P5rCZPA+m7ULetW5sThUXKN26ORXlQLBUwBjL0wMbxKoesO4B45d1Scj0mvooI+V+//PySDBmV
 kmUCJfazsTadXfTScHvAxIw4RBBj6WMO4aCozVqczEINtaBS7gGvOCOt/YaiOs14A+55wIBDr2
 vpCepKkTSPePg1mU8ZwrC1c6U9Mk8IIL5dnH88MlU612vYLubonCbhsqKkXA2MZIvGl4TSerf4
 eHMDDQ80HSy+j/Mi+vCF2CUNeaxe5e/UpACsg30Y9vKL5koY1abwDiJ+inGeEpq3wYLf/9UPBJ
 Ggo=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788134"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:28 +0800
IronPort-SDR: NkNQhS9v1m1b8T+8TP7XVMCTuHWcPCD1yWlvUBVTwB42vN7FBYXGtq1u1oNqKD9/3KSJJoCGb+
 ZGNZKW/n03lCQ2g2kh/kBXgVd006TUXurHJW7mFoYI/q/pJvfTCW2iUdksF2u9MiEsbELbqE1o
 y3NY5Ct48Qq+OYf8lObeCdIxbh6p3lUIOdOWifOx4plpx1fZM12eelUzuntlxot5eWJK/FeUkS
 MLilOvnqFL11LubndeTDKc8+u3r5ejOCjMM8omdAmY82tsn3SKLgMQ8vj8lTGH8erRCVwC5oRq
 jEB+ZlGhggcX6t/JsMCD4E75
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:52 -0700
IronPort-SDR: 5wCC3dvqYytowrptfYuU5V6VQYOFDdsuJ+xXF/2jpdzUStTeYCYtCUsPa7WahTsa2IBSE6NOzG
 vCpIvw4cpOhJsshi7gVtu62fv288ITmLKioWmEQS6WzLki7eLg1SoCDNHq+TghZc1oiJ4rTH4h
 gcL//0E0RrFhMqihE5A7yJs2TQ4FE9LnwHpSYfAYrkVAuHy9sHxRBdS4BHe7fLfVJEvFusAKvH
 LiM2ECKI8oSHeMkmH05Q0oHlIYz6ro+oIelWlnEYzYEX+sWIcYPUM9XNsd2mYolPnT1WZ4kLO4
 88E=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:28 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 18/26] btrfs-progs: zoned: support zero out on zoned block device
Date:   Mon, 26 Apr 2021 15:27:34 +0900
Message-Id: <9740fbfd8cb582ac0f961bd96a4a8dadb10c8a44.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we zero out a region in a sequential write required zone, we cannot
write to the region until we reset the zone. Thus, we must prohibit zeroing
out to a sequential write required zone.

zero_dev_clamped() is modified to take the zone information and it calls
zero_zone_blocks() if the device is host managed to avoid writing to
sequential write required zones.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/device-utils.c | 14 +++++++++-----
 common/device-utils.h |  1 +
 kernel-shared/zoned.c | 28 ++++++++++++++++++++++++++++
 kernel-shared/zoned.h |  9 +++++++++
 4 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index 2687f1884619..c1006c501555 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -67,7 +67,7 @@ int discard_blocks(int fd, u64 start, u64 len)
 	return 0;
 }
 
-static int zero_blocks(int fd, off_t start, size_t len)
+int zero_blocks(int fd, off_t start, size_t len)
 {
 	char *buf = malloc(len);
 	int ret = 0;
@@ -86,7 +86,8 @@ static int zero_blocks(int fd, off_t start, size_t len)
 #define ZERO_DEV_BYTES SZ_2M
 
 /* don't write outside the device by clamping the region to the device size */
-static int zero_dev_clamped(int fd, off_t start, ssize_t len, u64 dev_size)
+static int zero_dev_clamped(int fd, struct btrfs_zoned_device_info *zinfo,
+			    off_t start, ssize_t len, u64 dev_size)
 {
 	off_t end = max(start, start + len);
 
@@ -99,6 +100,9 @@ static int zero_dev_clamped(int fd, off_t start, ssize_t len, u64 dev_size)
 	start = min_t(u64, start, dev_size);
 	end = min_t(u64, end, dev_size);
 
+	if (zinfo && zinfo->model == ZONED_HOST_MANAGED)
+		return zero_zone_blocks(fd, zinfo, start, end - start);
+
 	return zero_blocks(fd, start, end - start);
 }
 
@@ -209,12 +213,12 @@ int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 		}
 	}
 
-	ret = zero_dev_clamped(fd, 0, ZERO_DEV_BYTES, block_count);
+	ret = zero_dev_clamped(fd, zinfo, 0, ZERO_DEV_BYTES, block_count);
 	for (i = 0 ; !ret && i < BTRFS_SUPER_MIRROR_MAX; i++)
-		ret = zero_dev_clamped(fd, btrfs_sb_offset(i),
+		ret = zero_dev_clamped(fd, zinfo, btrfs_sb_offset(i),
 				       BTRFS_SUPER_INFO_SIZE, block_count);
 	if (!ret && (opflags & PREP_DEVICE_ZERO_END))
-		ret = zero_dev_clamped(fd, block_count - ZERO_DEV_BYTES,
+		ret = zero_dev_clamped(fd, zinfo, block_count - ZERO_DEV_BYTES,
 				       ZERO_DEV_BYTES, block_count);
 
 	if (ret < 0) {
diff --git a/common/device-utils.h b/common/device-utils.h
index e7e638a57eb2..6eee3270e0c7 100644
--- a/common/device-utils.h
+++ b/common/device-utils.h
@@ -26,6 +26,7 @@
 #define	PREP_DEVICE_ZONED	(1U << 3)
 
 int discard_blocks(int fd, u64 start, u64 len);
+int zero_blocks(int fd, off_t start, size_t len);
 u64 get_partition_size(const char *dev);
 u64 disk_size(const char *path);
 u64 btrfs_device_size(int fd, struct stat *st);
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index ba1399cce04d..3c476eebf004 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -394,6 +394,34 @@ int btrfs_reset_all_zones(int fd, struct btrfs_zoned_device_info *zinfo)
 	return fsync(fd);
 }
 
+int zero_zone_blocks(int fd, struct btrfs_zoned_device_info *zinfo, off_t start,
+		     size_t len)
+{
+	size_t zone_len = zinfo->zone_size;
+	off_t ofst = start;
+	size_t count;
+	int ret;
+
+	/* Make sure that zero_blocks does not write sequential zones */
+	while (len > 0) {
+		/* Limit zero_blocks to a single zone */
+		count = min_t(size_t, len, zone_len);
+		if (count > zone_len - (ofst & (zone_len - 1)))
+			count = zone_len - (ofst & (zone_len - 1));
+
+		if (!zone_is_sequential(zinfo, ofst)) {
+			ret = zero_blocks(fd, ofst, count);
+			if (ret != 0)
+				return ret;
+		}
+
+		len -= count;
+		ofst += count;
+	}
+
+	return 0;
+}
+
 static int sb_log_location(int fd, struct blk_zone *zones, int rw,
 			   u64 *bytenr_ret)
 {
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index 88831d2d787c..9e1ce3ae103f 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -92,6 +92,8 @@ bool btrfs_redirty_extent_buffer_for_zoned(struct btrfs_fs_info *fs_info,
 int btrfs_reset_chunk_zones(struct btrfs_fs_info *fs_info, u64 devid,
 			    u64 offset, u64 length);
 int btrfs_reset_all_zones(int fd, struct btrfs_zoned_device_info *zinfo);
+int zero_zone_blocks(int fd, struct btrfs_zoned_device_info *zinfo, off_t start,
+		     size_t len);
 #else
 #define sbread(fd, buf, offset) \
 	pread64(fd, buf, BTRFS_SUPER_INFO_SIZE, offset)
@@ -145,6 +147,13 @@ static inline int btrfs_reset_all_zones(int fd,
 	return -EOPNOTSUPP;
 }
 
+static inline int zero_zone_blocks(int fd,
+				   struct btrfs_zoned_device_info *zinfo,
+				   off_t start, size_t len)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* BTRFS_ZONED */
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.31.1

