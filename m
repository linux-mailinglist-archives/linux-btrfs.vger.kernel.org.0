Return-Path: <linux-btrfs+bounces-15523-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDEFB06FCD
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 10:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857CC1AA05DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 08:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB18292B34;
	Wed, 16 Jul 2025 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a52ukIdz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE1415B54A
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652821; cv=none; b=Hx3cPK7GqXFx9QnW2+b5NCh5eloJlQzMmKIY5qMKoiAxaJrBQJTDU+Thb28EE3QlYJJXhLeAPwAkBtu6vQnO2cVvoaOWpMVQf55lzJi40k0x0finMp/pt777JEhRAIKLiSHkNT6bMTobGXxMSUrfjsBIaZYPUCDYFjxHRULegl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652821; c=relaxed/simple;
	bh=7RiPPwJMr0G1aCMmU4xUgNgQpi8cIm4xpcbx7gkin28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUgZ/c3Op89F31Haa6JGdghS6USypJ/TpUVOYQPrRovxNInADkvIpS5TffVJD420HqZMQEHYPNDnCaT/mEZOA0hOy0y7nO/Q1h/tUN/q5yy2a2wSvl8L6Uc+Fa15s0pZYdY/i4f8e0urtO3l2pTTdtC1ynfiLWoKsi7aATMac2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=a52ukIdz; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752652820; x=1784188820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7RiPPwJMr0G1aCMmU4xUgNgQpi8cIm4xpcbx7gkin28=;
  b=a52ukIdzYH4bshCtf7Z23uO4R0Df4m4TJtQQgEMsqJYbs6aHkVALk48o
   zbD5XZoxRJ3VnF8e8GK6LdnAYSV+ann0Aml/LRCTflVLwmwZ09AeAshM6
   vG5+k6HR+aqrRg8gMzQwwE7GX2BJrRBg+MFJ6+utjqAmey6m1LMnu05AX
   xMtKIJCuKs9XMVUSxPrbP0m5OqZcD+99s+I2bwI3huNalbDbSgNpEodPO
   g6tMANV6lWjTkOE5ooDWRzk0D+GPdtNHnWwoYzIrSJjAFiaGIm9gXJIXA
   Na2M5JMqmNQY6jgIiW/qyjNH8QlLEe0vWkl/xMwf2szTQPWL4mMDfU9hY
   g==;
X-CSE-ConnectionGUID: eDTZ9mRsRkyr/WU8/8eZ5Q==
X-CSE-MsgGUID: VjqjuFLvTHSclS3a11KsBA==
X-IronPort-AV: E=Sophos;i="6.16,315,1744041600"; 
   d="scan'208";a="94432941"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2025 16:00:19 +0800
IronPort-SDR: 68774d72_JjME8hfJdu+RxXIF4wU8hPclscCxFf383IIU4efdO/VpvIE
 SnTZ9raJqjeabNyZTidUM9F2QOPXBFqLJLv1/cA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2025 23:57:54 -0700
WDCIronportException: Internal
Received: from wdap-0lwmw3epm9.ad.shared (HELO naota-xeon) ([10.224.173.10])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Jul 2025 01:00:19 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 4/4] btrfs: zoned: limit active zones to max_open_zones
Date: Wed, 16 Jul 2025 16:59:55 +0900
Message-ID: <47f7423f53492e0ee1cd40f204db8354efb8d6b1.1752652539.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752652539.git.naohiro.aota@wdc.com>
References: <cover.1752652539.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When there is no active zone limit, we can technically write into any
number of zones at the same time. However, exceeding the max open zones can
degrade performance. To prevent this, set the max_active_zones to
bdev_max_open_zones() if there is no active zone limit.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index edd70ac2446c..42a2079d756d 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -43,6 +43,9 @@
 /* Number of superblock log zones */
 #define BTRFS_NR_SB_LOG_ZONES 2
 
+/* Default number of max active zones when the device has no limits. */
+#define BTRFS_DEFAULT_MAX_ACTIVE_ZONES	128
+
 /*
  * Minimum of active zones we need:
  *
@@ -417,7 +420,10 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	if (!IS_ALIGNED(nr_sectors, zone_sectors))
 		zone_info->nr_zones++;
 
-	max_active_zones = bdev_max_active_zones(bdev);
+	max_active_zones = min_not_zero(bdev_max_active_zones(bdev),
+					bdev_max_open_zones(bdev));
+	if (!max_active_zones && zone_info->nr_zones > BTRFS_DEFAULT_MAX_ACTIVE_ZONES)
+		max_active_zones = BTRFS_DEFAULT_MAX_ACTIVE_ZONES;
 	if (max_active_zones && max_active_zones < BTRFS_MIN_ACTIVE_ZONES) {
 		btrfs_err(fs_info,
 "zoned: %s: max active zones %u is too small, need at least %u active zones",
-- 
2.50.1


