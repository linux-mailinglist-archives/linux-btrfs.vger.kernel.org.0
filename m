Return-Path: <linux-btrfs+bounces-15442-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 163BEB0147F
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 09:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408D31884989
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 07:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99B41EFF93;
	Fri, 11 Jul 2025 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dhcHse3H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DFA1EC01D
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218647; cv=none; b=NhsC0QVoyFXFbt7FcpHHofwjngy4G2qY/bhguR52iQcB7CqKGq1ElHyC7XVuwqxVlMJiuoO7u/d5idC78BGDvblkYQpP64HbjJdqs4y/fYLicP8zz4zOQRaLjVZPo8fOHfk6jH5PF2XNQWWm1rXpmkjFzTA1x6DPjTDFNqc1v7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218647; c=relaxed/simple;
	bh=VNUcj8+0ImBqacK6ILts9Znj7h8f8Sm9t/6qfNVjOqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2yNQrhi61iA3qzwxORJfYHjdOZwSftJKYedTcFPpciCcpjAzTrS7B0VamxUS5+7+pjdG22ZqbZJdjiI7soPYVCf3DL2HDqFOyoJ3Z98RzIEEYl6O16hfK6qqIW3u+y8rJfzgLkCIN+M7mlHK1jZ4QOL1QarkNtu187QKS1rHs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dhcHse3H; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752218646; x=1783754646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VNUcj8+0ImBqacK6ILts9Znj7h8f8Sm9t/6qfNVjOqU=;
  b=dhcHse3HbQYYPCsL8Mnve6mlF5I2v3dFlWIPV7kN2fMNER4ZgwWy8SD9
   z6dxd1A0wTfYL4PYDAXNEJIfhlDir0czhowiStzhHe9SkI2BT+bSb8+/9
   0Wv+cwCegJ1fLyFluwTRIJc5ICIsx7+L5kQNxWdIu5Q6z1ZVcopf+XPwh
   705fuWvq2KS6cL18n952ih9p2hWcpefpzgTyGI0iDZCZfHt4LXgeX2Cko
   gqCWs8z1QUWgI9VhZbsf7aHi2fABtks5GmX65KJCDyDINhfOlckQ3EZbo
   OiJeSclHq8HOlaq7Z7rLNnrZtU/57g07gFmkgFVAkB6cMLY9Nrmcqa1gq
   A==;
X-CSE-ConnectionGUID: 0b+pis8QSWiScrjgM/Oskw==
X-CSE-MsgGUID: QSiAB7eASYKqdBI+eee4iw==
X-IronPort-AV: E=Sophos;i="6.16,303,1744041600"; 
   d="scan'208";a="87607287"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2025 15:24:05 +0800
IronPort-SDR: 6870ad7b_ijrVOo6afk1HloneSSCfN1QgaNvfOEgi1UUC72Y0ZuIsAg+
 EOBCY70eFBk1gf5uajjH+yvWVWMd32LJbNAVN0Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2025 23:21:48 -0700
WDCIronportException: Internal
Received: from 5cg2012qjk.ad.shared (HELO naota-xeon) ([10.224.163.136])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Jul 2025 00:24:04 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 3/3] btrfs: zoned: limit active zones to max_open_zones
Date: Fri, 11 Jul 2025 16:23:40 +0900
Message-ID: <99393b24788a89f01d2cd36cdc819c3caafc948e.1752218199.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752218199.git.naohiro.aota@wdc.com>
References: <cover.1752218199.git.naohiro.aota@wdc.com>
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

If the device has no limit, use a reasonable default value
BTRFS_DEFAULT_MAX_ACTIVE_ZONES to limit the open zones.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 14d959cf5a4c..7f4ae39cecf7 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -42,6 +42,9 @@
 /* Number of superblock log zones */
 #define BTRFS_NR_SB_LOG_ZONES 2
 
+/* Default number of max active zones when the device has no limits. */
+#define BTRFS_DEFAULT_MAX_ACTIVE_ZONES	128
+
 /*
  * Minimum of active zones we need:
  *
@@ -416,7 +419,10 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
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
2.50.0


