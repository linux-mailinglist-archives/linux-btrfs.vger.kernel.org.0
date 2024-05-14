Return-Path: <linux-btrfs+bounces-4986-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF728C5B09
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 20:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64FBE2828A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 18:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E827518130A;
	Tue, 14 May 2024 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J02zkHXo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5FC180A77
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715711096; cv=none; b=UiHhdtUk73xUi79Pd85MFFhK2XlamoFLPDvFKPR5z954PY2sWZMTrZLrsLIuFkpYM9qLdb9F8uZ+f7FZueAeymv3C0YP0/dNZVtfpnvCwDnMXoaw8weT0KDtSr0CtKnNRPESFFpi7qy5Re9v1UKFLAXkGWTEUSEPzDjKfDeYF2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715711096; c=relaxed/simple;
	bh=klr9/AUVZNtvfwteTzObnPP7VP0pV1dlrOUo7PAanQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8/PWBmqccE9sl3kH+jPNwmIPjG7Qii/Gb2ij9agvuZcCxOg4t8Y/8B1FnoxW6TFIqUQ0VbAP7kUDDh5k91IPQx6DjdQlg1XB7wmvU7UA/sio1BHUR1+QroktIiRnRvZgUKwDPG5MW4WV20wxJruJAy8UjWqhWL5gO/nauQDiy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=J02zkHXo; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715711094; x=1747247094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=klr9/AUVZNtvfwteTzObnPP7VP0pV1dlrOUo7PAanQE=;
  b=J02zkHXospehLsAu2dnI3GAzhcgHW6MH+pmf9xXMOq/uW56izY4kzoHU
   3tQZlq/qJWpr2qFEfxZrSooVNmKmmjK4mgr7ICWbRju1E77VEMiEnIHV5
   rW5BLmygRPxSqRSHydSztr4UCGuwaSmV370/SYskdoTQf0z4DZeK3GwxE
   naSCQ/kRAanXeCojqh26K+s2UCM/iyNzlhL7RRCdMr2EB3QyRIvmrSBIW
   tYj5tAB+sTWd/0fonZsM703v9PUtjTUqiYYFcVaXBrOdfCKvdyNrAJ/fi
   wKoXY4Hdcq0Psx+3MHlk1wqA+WdX7LCs0f9ikuFbN/k9aoTXC09R/ubdx
   A==;
X-CSE-ConnectionGUID: 5UnV/yRgRaOoxK6uoped/A==
X-CSE-MsgGUID: Fgc10bolTFC9Oga3pRr9cQ==
X-IronPort-AV: E=Sophos;i="6.08,159,1712592000"; 
   d="scan'208";a="17162688"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2024 02:24:54 +0800
IronPort-SDR: 6643a038_bzNZP6ph9vREVfHrz3Xw14H1s+4zYeGcG8NdJk3gCxXOzOv
 RbIn4r8EZTO0fCGyV1lcYOHQmikEAKjwzzJiioA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2024 10:32:41 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-x1.wdc.com) ([10.225.163.56])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 May 2024 11:24:53 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 6/8] btrfs-progs: support byte length for zone resetting
Date: Tue, 14 May 2024 12:22:25 -0600
Message-ID: <20240514182227.1197664-7-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514182227.1197664-1-naohiro.aota@wdc.com>
References: <20240514182227.1197664-1-naohiro.aota@wdc.com>
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
 kernel-shared/zoned.h |  7 ++++---
 3 files changed, 38 insertions(+), 9 deletions(-)

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
index 6eba86d266bf..2bf24cbba62a 100644
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
@@ -203,8 +203,9 @@ static inline int btrfs_reset_chunk_zones(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-static inline int btrfs_reset_all_zones(int fd,
-					struct btrfs_zoned_device_info *zinfo)
+static inline int btrfs_reset_zones(int fd,
+				    struct btrfs_zoned_device_info *zinfo,
+				    u64 byte_count)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.45.0


