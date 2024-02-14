Return-Path: <linux-btrfs+bounces-2386-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A596C854EE3
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 17:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584B41F23D76
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 16:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ACC63107;
	Wed, 14 Feb 2024 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BqTZuWEZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401A761695;
	Wed, 14 Feb 2024 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928947; cv=none; b=uZl5QRCvb852R/GPCacDcDhwHFPXlthGbVcfH0iLcR3bONJU/2+f5QFYp5N6bbrXf7V8VIcEhBPFgLLST9/yRBiWKfPIiYoMyO75kNf7k85YA5TNviD9oWambqPd/2LCIMvJzqSeBTXKVThigOvbT+c9jT2WEg0a7hw2d7Isddo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928947; c=relaxed/simple;
	bh=n/Ct+FOCPnbG6TCxKfw5AO3FWijGxGRtmVbb789OJTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ILtSj1VWUASBZGvy/KXiwnqdu7GORtmE1twnAR5NFSErthNGku1yPjdEtI1w1FdgkbLo0nmvuVYmUOOxtXcJDNwLCo4QgtxrYKx/lHxA9b9+GqvHeeRxxNauNtiCUIqabA3k9K3Z+DJv+YtWkSmDGdVEACXXYo5Y8+HXUdzxyk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BqTZuWEZ; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707928945; x=1739464945;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=n/Ct+FOCPnbG6TCxKfw5AO3FWijGxGRtmVbb789OJTM=;
  b=BqTZuWEZE8YUEPxhjGR4fbzg1nQbl4ttkg14Bs3PCw5WOX0bh+X1UHZy
   kX216bsZwX6lcZwjhu68P/HtyH8DYx0OcJbojGT+XiKhiAvaRbZYG/kdE
   iRgvLvRLA3fHCxggF+kM2SfxGBnd0Sy/FNOAjLT7VG9G/zyD0uh9jbxnl
   /XM7weEPIy5g0DS771TjTq9tBavolPHGu6b0hVvmclv2hyxfw+OVlws6A
   72nWsI5FK00mLti2H7/xD7lxYYHqN+eA+Q+o5mPQg4p1NPb/E+TK7sC5a
   SBmV1Uz4v7GHPbjN2UHZ3khkOCnQmG3FhssqauFoCiepqRrCjyVgMO4Yq
   A==;
X-CSE-ConnectionGUID: 3PqAXj1mRHCgh1akvRC+cw==
X-CSE-MsgGUID: qvE74kfMRh+XStqcluh2OA==
X-IronPort-AV: E=Sophos;i="6.06,159,1705334400"; 
   d="scan'208";a="9294747"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2024 00:42:24 +0800
IronPort-SDR: F6k1MLOE5/8J8qKOpxUSURReH5Yusmwr/nIa58Ltsl2GXDjoysUKZnXpdmsY27sfc0rQGqJpsI
 Da6NvglNaSQg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2024 07:51:59 -0800
IronPort-SDR: gqvyFZhGSaw04+Ud78YXDxHFnxQddOfK8ygif5khsnA6k0J5jME4Cy2ASv3MXe0GseQVdGmh5s
 aDi1iUDBXXGg==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Feb 2024 08:42:22 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 14 Feb 2024 08:42:16 -0800
Subject: [PATCH 5/5] btrfs: use the super_block as holder when mounting
 file systems
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-hch-device-open-v1-5-b153428b4f72@wdc.com>
References: <20240214-hch-device-open-v1-0-b153428b4f72@wdc.com>
In-Reply-To: <20240214-hch-device-open-v1-0-b153428b4f72@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707928933; l=1407;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=5rfa6IXupj7Jvp1HyDQOjFATBDPTi0LqbzcMFjmSCro=;
 b=YI3WD5e/SUmGdIE0DfNpjyBwSXRjmr39hdskYzorTvIHh9L6oUFmy4XE+lzd7sgCkziaYG8x2
 iNlLie//3u3DKi7tZZpXW/p1nuhTq0YEolIZFV0utmEplJ4NRDB7IDR
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

From: Christoph Hellwig <hch@lst.de>

The file system type is not a very useful holder as it doesn't allow us
to go back to the actual file system instance.  Pass the super_block
instead which is useful when passed back to the file system driver.

This matches what is done for all other block device based file systems.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 1fa7d83d02c1..0c7956e8f21e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1843,7 +1843,7 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 
 		mutex_lock(&uuid_mutex);
-		ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
+		ret = btrfs_open_devices(fs_devices, mode, sb);
 		mutex_unlock(&uuid_mutex);
 		if (ret)
 			goto error_deactivate;
@@ -1856,7 +1856,7 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		snprintf(sb->s_id, sizeof(sb->s_id), "%pg",
 			 fs_devices->latest_dev->bdev);
 		shrinker_debugfs_rename(sb->s_shrink, "sb-btrfs:%s", sb->s_id);
-		btrfs_sb(sb)->bdev_holder = &btrfs_fs_type;
+		btrfs_sb(sb)->bdev_holder = sb;
 		ret = btrfs_fill_super(sb, fs_devices, NULL);
 		if (ret)
 			goto error_deactivate;

-- 
2.43.0


