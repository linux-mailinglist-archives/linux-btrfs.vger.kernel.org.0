Return-Path: <linux-btrfs+bounces-2276-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEFF84F3AB
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 11:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB451C214FD
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 10:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA1F25630;
	Fri,  9 Feb 2024 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CTon7LbC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D20925613
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475601; cv=none; b=IbFnV5MNyTQ760rnPmEWM5QcWOUeGKoy2jpLEG8QkqXDtu3k2/KQoKfpj9AiifcOhXuUXVJ9vkwggQJp58jEoK0T3tvUV0jFpeWDe+PhYTFB78URC2HK8mVeLO3Edcmba+xbTn4hv5u0q/9FCPWW7O96AcyJboIm/RcQ16ia5Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475601; c=relaxed/simple;
	bh=GI2LQcImfVE85c799ReZXpLgSVCHcWrBslQfBoUycgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LftOEcThy0oskBuwNc63voMQvv+f/r7Xd4W/2HGgIj3XQMrGD9j1JjhT4eYzzybRDvDpL1VKKmsizSTF44/UFQxC+WxHAwgfvJKs7/Fl7uR7/ab/4W2z5JnfBCWPTdBKQF8FSE6X31ZD0vWNOpwHsDam0kujCy4GPet7GcrzuV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CTon7LbC; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707475598; x=1739011598;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GI2LQcImfVE85c799ReZXpLgSVCHcWrBslQfBoUycgQ=;
  b=CTon7LbCMeActUsDe0L4IzYX80Rvd5gG5j2W04m2P7r89GSfymi0h83e
   X7vbwmqtRbnm4D0Asd0b4Z2LdeKDl1zL6iU9ZsPYJuD1PIEMPAIQSlSLq
   jgjoZ3MWlxiy4Q8K4YYrUPTN8sWwpZS+GExlRbv2Z/0NPvqUC3qekZ6RJ
   Rs+B2EYsx0XgZV7pGD5osUxJqyDtjxNSgob6XVrYBYeOaXoGb76p82vz2
   9ppsRMAjYaKhv2wH/Gl255ay9fqyRZGM4yVeloaXiCJGO3GLCDzvi9T3d
   aSzeBZ+qMOEHh2uVrWe//fS3yyu4XGe55LmXHYZoG/H5SvRyM1BZsYcvd
   g==;
X-CSE-ConnectionGUID: fVwZExRQQwuc5wHkbaO8WQ==
X-CSE-MsgGUID: L6KHpi7sTqy1Gst4OEXIlw==
X-IronPort-AV: E=Sophos;i="6.05,256,1701100800"; 
   d="scan'208";a="8888673"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2024 18:46:31 +0800
IronPort-SDR: OZVlPX1XrlhNIwYtlQLf0HWKmRax07jwU1zBDCcxhQKNHPp3ZxPJqP2gZMLTeOf3MNwAbAzJLe
 nhaGX3+EGaeQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Feb 2024 01:50:33 -0800
IronPort-SDR: lysTBH6pABMZdqyGSi+QID9LOIO4Fbee/dJ7lHaAW6T5WWRo+asz2O0pSOuUAop1AZnplVYP+y
 OzwkdmuKSdbg==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Feb 2024 02:46:29 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.cz>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	=?UTF-8?q?=E9=9F=A9=E4=BA=8E=E6=83=9F?= <hrx@bupt.moe>
Subject: [PATCH] btrfs: zoned: don't skip block group profile checks on conv zones
Date: Fri,  9 Feb 2024 02:46:26 -0800
Message-ID: <534c381d897ad3f29948594014910310fe504bbc.1707475586.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On a zoned filesystem with conventional zones, we're skipping the block
group profile checks for the conventional zones.

This allows converting a zoned filesystem's data block groups to RAID when
all of the zones backing the chunk are on conventional zones.  But this
will lead to problems, once we're trying to allocate chunks backed by
sequential zones.

So also check for conventional zones when loading a block group's profile
on them.

Reported-by: 韩于惟 <hrx@bupt.moe>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index d9716456bce0..5beb6b936e61 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1369,8 +1369,10 @@ static int btrfs_load_block_group_single(struct btrfs_block_group *bg,
 		return -EIO;
 	}
 
-	bg->alloc_offset = info->alloc_offset;
-	bg->zone_capacity = info->capacity;
+	if (info->alloc_offset != WP_CONVENTIONAL) {
+		bg->alloc_offset = info->alloc_offset;
+		bg->zone_capacity = info->capacity;
+	}
 	if (test_bit(0, active))
 		set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &bg->runtime_flags);
 	return 0;
@@ -1406,6 +1408,16 @@ static int btrfs_load_block_group_dup(struct btrfs_block_group *bg,
 		return -EIO;
 	}
 
+	if (zone_info[0].alloc_offset == WP_CONVENTIONAL) {
+		zone_info[0].alloc_offset = bg->alloc_offset;
+		zone_info[0].capacity = bg->length;
+	}
+
+	if (zone_info[1].alloc_offset == WP_CONVENTIONAL) {
+		zone_info[1].alloc_offset = bg->alloc_offset;
+		zone_info[1].capacity = bg->length;
+	}
+
 	if (test_bit(0, active) != test_bit(1, active)) {
 		if (!btrfs_zone_activate(bg))
 			return -EIO;
@@ -1458,6 +1470,9 @@ static int btrfs_load_block_group_raid1(struct btrfs_block_group *bg,
 						 zone_info[1].capacity);
 	}
 
+	if (zone_info[0].alloc_offset == WP_CONVENTIONAL)
+		zone_info[0].alloc_offset = bg->alloc_offset;
+
 	if (zone_info[0].alloc_offset != WP_MISSING_DEV)
 		bg->alloc_offset = zone_info[0].alloc_offset;
 	else
@@ -1479,6 +1494,11 @@ static int btrfs_load_block_group_raid0(struct btrfs_block_group *bg,
 		return -EINVAL;
 	}
 
+	for (int i = 0; i < map->num_stripes; i++) {
+		if (zone_info[i].alloc_offset == WP_CONVENTIONAL)
+			zone_info[i].alloc_offset = bg->alloc_offset;
+	}
+
 	for (int i = 0; i < map->num_stripes; i++) {
 		if (zone_info[i].alloc_offset == WP_MISSING_DEV ||
 		    zone_info[i].alloc_offset == WP_CONVENTIONAL)
@@ -1511,6 +1531,11 @@ static int btrfs_load_block_group_raid10(struct btrfs_block_group *bg,
 		return -EINVAL;
 	}
 
+	for (int i = 0; i < map->num_stripes; i++) {
+		if (zone_info[i].alloc_offset == WP_CONVENTIONAL)
+			zone_info[i].alloc_offset = bg->alloc_offset;
+	}
+
 	for (int i = 0; i < map->num_stripes; i++) {
 		if (zone_info[i].alloc_offset == WP_MISSING_DEV ||
 		    zone_info[i].alloc_offset == WP_CONVENTIONAL)
@@ -1605,7 +1630,6 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		} else if (map->num_stripes == num_conventional) {
 			cache->alloc_offset = last_alloc;
 			set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &cache->runtime_flags);
-			goto out;
 		}
 	}
 
-- 
2.43.0


