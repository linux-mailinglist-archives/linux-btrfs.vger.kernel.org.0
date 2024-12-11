Return-Path: <linux-btrfs+bounces-10217-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCF39EC35E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 04:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC0E1677BF
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 03:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCE220E010;
	Wed, 11 Dec 2024 03:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="phYROc45"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2E76F073
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733888174; cv=none; b=E1kudNmGb63hwMgts6pE0K0qXL6SZ3vccMxTnsNNuIczpyz16VlybQrKEfjq9N40arpz9DP34iyU3ul5JNwehXdYSx11xlhPWhvWej3g0xILwEDjRZ8iYVArR6t1sx8NJYvazQhDkYUSAZPdqsk/LpDN2z/9kwwCEFDN+qvtf2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733888174; c=relaxed/simple;
	bh=TXffDh1vGC7MlYQfhCWHbPLTB8wYGwGhhLz9XoXxf7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k47Da0bX50EnxuucggEYy9uZCsuy5lhTPQ756Utz+98SAhKOKzCvU8XDne9mSrqOxYdM8fiMfYWBd3ziok74kTaUGK2xTztLj5UyrBnWYCnNH/XXgpWZMoLcqBSY44L5GmgthenAkg/XSj5BGJTAilA9SIYF5SCBSWUKU17nws0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=phYROc45; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733888172; x=1765424172;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TXffDh1vGC7MlYQfhCWHbPLTB8wYGwGhhLz9XoXxf7E=;
  b=phYROc45z3gf2lOFhD6jL0kgiBhzwbeZSm4S/tcBKm9i1DvVX0IoAh/2
   qhkU5o4KZgO+lVm2xWzBsYMw121Hdgs7Z5hK7m/BsTUpuvqdCOGx+kXDv
   pk2OYLF5pLS6r+ilM4fk8FOd9LXVvVfcIgHWaZUgx4YGqLIOkMhnvofb0
   F8p/JdWQi1P93o2oYuvVmSXOXKbRAQtDMVPVpWqPMioUK+xZG0Y+htWq+
   I/8Y5rMR4npj5p8he6BgsLmHtUI34nrMeh4CK4AOJjiEsZ4jnTGb+Dz25
   jcAIeKp6qbLSvDFbkYaDi8+WE/+PWVoJupcDLldKl0da0j+0PZCa/rJ30
   A==;
X-CSE-ConnectionGUID: /yYVH9KdSESW7ch1ZTq1cg==
X-CSE-MsgGUID: U8x+RDf0RWy0di3yWsYO9A==
X-IronPort-AV: E=Sophos;i="6.12,224,1728921600"; 
   d="scan'208";a="32874244"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2024 11:36:11 +0800
IronPort-SDR: 6758f9ff_jJJdkt6zqAxP55koHgMKqFv7zh1X8HyhvAHMmyLUnz9Frri
 HD7KBWj0VVJ7kJMPU2cAWQcWhTXTLwSMPu5i0rw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Dec 2024 18:33:35 -0800
WDCIronportException: Internal
Received: from 5cg21505s2.ad.shared (HELO naota-xeon..) ([10.224.102.244])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Dec 2024 19:36:11 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] btrfs: zoned: calculate max_zone_append_size properly on non-zoned setup
Date: Wed, 11 Dec 2024 12:36:00 +0900
Message-ID: <9c00c066e9529f1a6439c1c8895a8f0d010a07e5.1733887702.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 559218d43ec9 ("block: pre-calculate max_zone_append_sectors"),
queue_limits's max_zone_append_sectors is default to be 0 and it is only
updated when there is a zoned device. So, we have
lim->max_zone_append_sectors = 0 when there is no zoned device in the
filesystem.

That leads to fs_info->max_zone_append_size and fs_info->max_extent_size to
be 0, which causes several errors. One example is the divide error as
below. Running simple test as btrfs/001 on a non-zoned device with the
zoned mode (zoned emulation) leads to this error because we have
fs_info->max_extent_size = 0 in count_max_extents().

   Oops: divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
   CPU: 21 UID: 0 PID: 2378822 Comm: dd Tainted: G        W          6.13.0-rc2-kts #1
   Tainted: [W]=WARN
   Hardware name: Supermicro SYS-520P-WTR/X12SPW-TF, BIOS 1.2 02/14/2022
   RIP: 0010:btrfs_delalloc_reserve_metadata+0x161/0x790 [btrfs]

The block layer logic, having max_zone_append_sectors = 0 by stacking
non-zoned devices, seems reasonable to me. So, let's deal with that in
btrfs side by ignoring max_zone_append_sectors if it is non-zoned setup.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 559218d43ec9 ("block: pre-calculate max_zone_append_sectors")
CC: Christoph Hellwig <hch@lst.de>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index abea8f2f497e..12ad6fcc2513 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -741,12 +741,23 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	 * we add the pages one by one to a bio, and cannot increase the
 	 * metadata reservation even if it increases the number of extents, it
 	 * is safe to stick with the limit.
+	 *
+	 * If there is no zoned device in the filesystem, we have
+	 * max_zone_append_sectors = 0. That will cause
+	 * fs_info->max_zone_append_size and fs_info->max_extent_size to be
+	 * 0 in the following lines. Set the maximum value to avoid that.
 	 */
-	fs_info->max_zone_append_size = ALIGN_DOWN(
-		min3((u64)lim->max_zone_append_sectors << SECTOR_SHIFT,
-		     (u64)lim->max_sectors << SECTOR_SHIFT,
-		     (u64)lim->max_segments << PAGE_SHIFT),
-		fs_info->sectorsize);
+	if (lim->features & BLK_FEAT_ZONED)
+		fs_info->max_zone_append_size = ALIGN_DOWN(
+			min3((u64)lim->max_zone_append_sectors << SECTOR_SHIFT,
+			     (u64)lim->max_sectors << SECTOR_SHIFT,
+			     (u64)lim->max_segments << PAGE_SHIFT),
+			fs_info->sectorsize);
+	else
+		fs_info->max_zone_append_size = ALIGN_DOWN(
+			min((u64)lim->max_sectors << SECTOR_SHIFT,
+			    (u64)lim->max_segments << PAGE_SHIFT),
+			fs_info->sectorsize);
 	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
 	if (fs_info->max_zone_append_size < fs_info->max_extent_size)
 		fs_info->max_extent_size = fs_info->max_zone_append_size;
-- 
2.47.1


