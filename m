Return-Path: <linux-btrfs+bounces-15275-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063A2AFA9C6
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 04:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3CE3ADB1D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 02:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D3A1DB34B;
	Mon,  7 Jul 2025 02:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OXV2ie/7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83F41C6FEC
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 02:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751856353; cv=none; b=C298PQAMCN+HyNjRjCkR/mcCP20MMvP4/iQmQ0GwXyiubUt9MHT+7CCRHWlEBn4hk6HmiCJW9QCMLpWL8XyUdGBdi5dhrVn+w8Ss65K8N38Osj+s8TBNb1Opk9Twgq8+h/9ysX9rHx7B0jl8uUbkHIt1tz0k+zg9ajaKcrSOLBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751856353; c=relaxed/simple;
	bh=YKk97qI8Lx0tlzXx9HgFrflgzb5YZSd43zuiC1Ej1bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zv41fK69bGCTc9Ywgz+j31G9z0JgjT2tnLdgOrpQbVm/L3Va2ZtTXGr2NlkR2aoNoc14N5WkPPYP30vcBtS2DrL7v/w8C1FS6C54h2zOw4i3ZPcMhJKbdao6u+LUbEhtElbs+RY9KscVmevfCfEY8HIX4fCfGtIXAX2aC2Wrsts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OXV2ie/7; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751856351; x=1783392351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YKk97qI8Lx0tlzXx9HgFrflgzb5YZSd43zuiC1Ej1bo=;
  b=OXV2ie/7/rgNMFSAX6zV/+C8VPViuYXRdbufdq4CAda/nyXSOHqCYVyr
   +mznzhK6kp117S2cH24fhw4Hk5QkJardTOQ/ls28xhKnZ7ozwtVVb06Jg
   98uxX3TJJD/7yF0rW9GOB3UNzLx9MKJHiSUMW4QqjFT663NmvUC9+TIxY
   yBopi2BlrHoxduMbrNXaHWEyHsj3NTnSOulWxse1eRays3+V04lUh3HKb
   vOfnEuHi9/UhNoSFdRGyZ4eyFGjJbQdKf29sB9iW6LNq6ceZrCL34ZOjl
   aemll0kSTzN3te8Iwyu7pUj/cYfn+Rf6tiyWO+zurHEcrFmn6+zKmEYVw
   g==;
X-CSE-ConnectionGUID: /JOdmIrNTMG5lw4eB41bvA==
X-CSE-MsgGUID: Pb7rtWRoQY2ZyIJhFH6uVw==
X-IronPort-AV: E=Sophos;i="6.16,293,1744041600"; 
   d="scan'208";a="85911274"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2025 10:44:40 +0800
IronPort-SDR: 686b2606_Zj6xasNQTI+w7fvVaRQaq0p6zIU9FNTHzg/1DnZFidzTzO/
 GFxJW0se0xLpMuyQCwVG/Ene+Mb5ByIICn4Ta5A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jul 2025 18:42:30 -0700
WDCIronportException: Internal
Received: from 5cg217427s.ad.shared (HELO naota-xeon) ([10.224.173.231])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Jul 2025 19:44:41 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 3/3] btrfs: zoned: limit active zones to max_open_zones
Date: Mon,  7 Jul 2025 11:44:12 +0900
Message-ID: <d2f36336c9eff5de35149223e9fd9b279028a804.1751611657.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751611657.git.naohiro.aota@wdc.com>
References: <cover.1751611657.git.naohiro.aota@wdc.com>
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
---
 fs/btrfs/zoned.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 9c354e84ab07..bdcfabcb35e7 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -418,6 +418,8 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 		zone_info->nr_zones++;
 
 	max_active_zones = bdev_max_active_zones(bdev);
+	if (!max_active_zones)
+		max_active_zones = bdev_max_open_zones(bdev);
 	if (max_active_zones && max_active_zones < BTRFS_MIN_ACTIVE_ZONES) {
 		btrfs_err(fs_info,
 "zoned: %s: max active zones %u is too small, need at least %u active zones",
-- 
2.50.0


