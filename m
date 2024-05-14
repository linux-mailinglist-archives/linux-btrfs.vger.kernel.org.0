Return-Path: <linux-btrfs+bounces-4951-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1E68C4AA6
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 02:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF201C230AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 00:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7A3A93A;
	Tue, 14 May 2024 00:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FrZwbZJG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4FD17C2
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 00:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715647932; cv=none; b=V1x5WppEUWKogqiqvXXj9PLu/fSAef7PKLt6nlL7NLJ0ZMSwaZcuxDZLRSsJMq6Iv1xUCe20hRedT9SQvK0MfPRgvJEA3MS4WkLx7O0Sebrb8sBHdbgJTqm6OBQlHQckOCX0QGHu8X4jr8beoTdmig0Dih2cTLE8y03/GpoBBMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715647932; c=relaxed/simple;
	bh=lS/za6YRAtKHJKFODuWu5J4pzptbO4u+AJ15KGasgh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWLIWGGcLCmPnooi3LnFLgc3x4qzcq4AUoDQhE4C2Mc/nGFmuUNWmsEUPdb41pPbBSBJ7JxvpZLG1mko2KiQrpFEjjhNenE358kRPyMi7yYG0QqnVNjv62OTi+xuWZHVl9/2II/5Xkfj8byfwK3njFQqhGxVViDLvMl6URuCIhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FrZwbZJG; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715647930; x=1747183930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lS/za6YRAtKHJKFODuWu5J4pzptbO4u+AJ15KGasgh4=;
  b=FrZwbZJGxYWP+pH37S5gx6+iYOls880FyYfYnjcUPQEsM1wexVZhW9ja
   pzuuPo+M7j8H5D23nubaFAbkGQggsHXvnF3OxoNlWTFoNfmR6C+q4KhLU
   Kq8np9nNARcYm/s1UYcImlI7Z4kTrkTSlMhy+ZOpGYMBeiLHI3N9xBQes
   0JkmSi5kdq5roxALkHywY/SxafapxzLwOmzobaz+pBsOPqZM8UP7fsGlg
   UJX6DesJ01GSbaPCBqEG8g2qUriygIT8Qg6ky5zi54ilpafeg/68ShJW/
   7E/9la8i2BG0YpnkR6SW7k180q9s1OMPIiRjvUeV6aoiSWHwmPGuDsjFe
   g==;
X-CSE-ConnectionGUID: HSCIEpMzTBqFEyL70KvPCg==
X-CSE-MsgGUID: QpfbInihSAejf2aSYUZNIA==
X-IronPort-AV: E=Sophos;i="6.08,159,1712592000"; 
   d="scan'208";a="16252239"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 May 2024 08:52:08 +0800
IronPort-SDR: 6642a827_/7XSvVrprHluTNDzWohjJc4ClHN+t39VA2QaR5PDIYASh3X
 uyv2c2x/oax8EQ1h/2v49MOAPJbyp0gbyFp506w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 May 2024 16:54:15 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-x1.wdc.com) ([10.225.163.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 May 2024 17:52:07 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 6/7] btrfs-progs: support byte length for zone resetting
Date: Mon, 13 May 2024 18:51:32 -0600
Message-ID: <20240514005133.44786-7-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514005133.44786-1-naohiro.aota@wdc.com>
References: <20240514005133.44786-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even with "mkfs.btrfs -b", mkfs.btrfs resets all the zones on the device.
Limit the reset target within the specified length.

Also, we need to check that there is no active zone outside of the FS
range. If there is one, btrfs fails to meet the active zone limit properly.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/device-utils.c | 17 ++++++++++++-----
 kernel-shared/zoned.c | 23 ++++++++++++++++++++++-
 kernel-shared/zoned.h |  2 +-
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index 86942e0c7041..7df7d9ce39d8 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -254,16 +254,23 @@ int btrfs_prepare_device(int fd, const char *file, u64 *byte_count_ret,
 
 		if (!zinfo->emulated) {
 			if (opflags & PREP_DEVICE_VERBOSE)
-				printf("Resetting device zones %s (%u zones) ...\n",
-				       file, zinfo->nr_zones);
+				printf("Resetting device zones %s (%llu zones) ...\n",
+				       file, byte_count / zinfo->zone_size);
 			/*
 			 * We cannot ignore zone reset errors for a zoned block
 			 * device as this could result in the inability to write
 			 * to non-empty sequential zones of the device.
 			 */
-			if (btrfs_reset_all_zones(fd, zinfo)) {
-				error("zoned: failed to reset device '%s' zones: %m",
-				      file);
+			ret = btrfs_reset_zones(fd, zinfo, byte_count);
+			if (ret) {
+				if (ret == EBUSY) {
+					error("zoned: device '%s' contains an active zone outside of the FS range",
+					      file);
+					error("zoned: btrfs needs full control of active zones");
+				} else {
+					error("zoned: failed to reset device '%s' zones: %m",
+					      file);
+				}
 				goto err;
 			}
 		}
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index fb1e1388804e..b4244966ca36 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -395,16 +395,24 @@ static int report_zones(int fd, const char *file,
  * Discard blocks in the zones of a zoned block device. Process this with zone
  * size granularity so that blocks in conventional zones are discarded using
  * discard_range and blocks in sequential zones are reset though a zone reset.
+ *
+ * We need to ensure that zones outside of the FS is not active, so that
+ * the FS can use all the active zones. Return EBUSY if there is an active
+ * zone.
  */
-int btrfs_reset_all_zones(int fd, struct btrfs_zoned_device_info *zinfo)
+int btrfs_reset_zones(int fd, struct btrfs_zoned_device_info *zinfo, u64 byte_count)
 {
 	unsigned int i;
 	int ret = 0;
 
 	ASSERT(zinfo);
+	ASSERT(IS_ALIGNED(byte_count, zinfo->zone_size));
 
 	/* Zone size granularity */
 	for (i = 0; i < zinfo->nr_zones; i++) {
+		if (byte_count == 0)
+			break;
+
 		if (zinfo->zones[i].type == BLK_ZONE_TYPE_CONVENTIONAL) {
 			ret = device_discard_blocks(fd,
 					     zinfo->zones[i].start << SECTOR_SHIFT,
@@ -419,7 +427,20 @@ int btrfs_reset_all_zones(int fd, struct btrfs_zoned_device_info *zinfo)
 
 		if (ret)
 			return ret;
+
+		byte_count -= zinfo->zone_size;
 	}
+	for (; i < zinfo->nr_zones; i++) {
+		const enum blk_zone_cond cond = zinfo->zones[i].cond;
+
+		if (zinfo->zones[i].type == BLK_ZONE_TYPE_CONVENTIONAL)
+			continue;
+		if (cond == BLK_ZONE_COND_IMP_OPEN ||
+		    cond == BLK_ZONE_COND_EXP_OPEN ||
+		    cond == BLK_ZONE_COND_CLOSED)
+			return EBUSY;
+	}
+
 	return fsync(fd);
 }
 
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index 6eba86d266bf..104fb7b19490 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -149,7 +149,7 @@ bool btrfs_redirty_extent_buffer_for_zoned(struct btrfs_fs_info *fs_info,
 					   u64 start, u64 end);
 int btrfs_reset_chunk_zones(struct btrfs_fs_info *fs_info, u64 devid,
 			    u64 offset, u64 length);
-int btrfs_reset_all_zones(int fd, struct btrfs_zoned_device_info *zinfo);
+int btrfs_reset_zones(int fd, struct btrfs_zoned_device_info *zinfo, u64 byte_count);
 int zero_zone_blocks(int fd, struct btrfs_zoned_device_info *zinfo, off_t start,
 		     size_t len);
 int btrfs_wipe_temporary_sb(struct btrfs_fs_devices *fs_devices);
-- 
2.45.0


