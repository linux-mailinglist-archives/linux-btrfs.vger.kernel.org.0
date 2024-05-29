Return-Path: <linux-btrfs+bounces-5344-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E7B8D2DE8
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 09:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A411B24E86
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 07:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF9C167DA7;
	Wed, 29 May 2024 07:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AShNnZdu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B932E16726B
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966824; cv=none; b=d9Xoqw05Y9HzqaJra/XcALXOWA6KfcKuEIJYVrMPUD9MFlwG6vpFFHUUqeKGOgi99t6Ts/22mP3zUa+xUP2MaUclB5amN7U12czybKmkrPF/mUKS1MUf/J5t7eWHAE2Bsi1QgqSPdKtnPexGVhgRsCiDv64+wIcLd+v0esFKS10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966824; c=relaxed/simple;
	bh=ry26AqNbwTnYcG7ZE4Czs5f+gXbgatGc4qsIEWVYt7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbG8YE4AWCqY9HOafuA75awozBj1WDjAoLNs+6+g7q+befAol7mTtCUjo3VJgZav4lMvEFJtkufs/NhZTcvqh9XucaEz04qe/p6hn4S8g4Ussn2AKHi/PktFAedEkeUYEAlLEeJnwPW2IYb0YwqQ9VmF4ik3Nnu74R0MC833tA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AShNnZdu; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716966821; x=1748502821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ry26AqNbwTnYcG7ZE4Czs5f+gXbgatGc4qsIEWVYt7s=;
  b=AShNnZduoGT9ICrNDZ+UwOV69d0muFNJfx8yhRVwE1qbPdJqQLhLx+VO
   Ni5UXZaqZoLJY3NKT+lPkQFXWlTg//HPRc161mWpWSmXpqK5fnCJwlLFw
   pt4kSTjE+kc9smn1JLG0Wn82vLrDHnJy0eUBiVzsDVDy2XjGL+/UFI5k6
   k3UW5IhPQWJClvBwRPyf2TSzCBKuS9eOF33wpjDNrI2AbugoQiVfSGG8b
   +WCuhPhi7QlprAA4sdeoTO1j4xaU41xtTe+lox5/9PXD0TxQ8q1dygJtM
   FptKlpWuba8Kw3SQbl8IFk8CN5+iDEn85aGhDg3bPfgzg4bT8BjmkQuaP
   g==;
X-CSE-ConnectionGUID: zmO4x05NTnKsoKOGMSD+GQ==
X-CSE-MsgGUID: s4yd2NfTQcSOurlSYYoqDg==
X-IronPort-AV: E=Sophos;i="6.08,197,1712592000"; 
   d="scan'208";a="16865347"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2024 15:13:35 +0800
IronPort-SDR: 6656c94f_QAQJYMVoHVAa/Gr6u5WXLEBiOQWwTkRjL5vhOpijO3J2afV
 xYRnVzuv+Y3y6cU6Vj+h/fx6DGSgluiJrQrBLkw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 May 2024 23:21:03 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.62])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 May 2024 00:13:34 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 06/10] btrfs-progs: support byte length for zone resetting
Date: Wed, 29 May 2024 16:13:21 +0900
Message-ID: <20240529071325.940910-7-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240529071325.940910-1-naohiro.aota@wdc.com>
References: <20240529071325.940910-1-naohiro.aota@wdc.com>
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
range. Having an active zone outside FS reduces the number of zones btrfs
can write simultaneously. Technically, we can still scan all the device
zones and keep active zones outside FS intact and try to live with the
limited active zones. But, that will make btrfs operations harder.

It is generally bad idea to use "-b" on a non-test usage on a device with
active zone limit in the first place. You really need to take care that FS
and outside the FS goes over the limit. That means you'll never be able to
use zones outside the FS anyway.

So, until there is a strong request for that, I don't think it's worthwhile
to do so.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
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
2.45.1


