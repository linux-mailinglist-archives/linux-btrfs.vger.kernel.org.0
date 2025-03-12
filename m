Return-Path: <linux-btrfs+bounces-12213-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ECBA5D40F
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 02:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 383177A3D4C
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 01:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AF61482F2;
	Wed, 12 Mar 2025 01:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PJu4Zq0i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBD638384;
	Wed, 12 Mar 2025 01:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741743144; cv=none; b=r3jC26NRZEYFuN6zKiDgtOunDFg85e8PbVEixnMMVMFIECfTJC0yJvXtoAXal0phX4An5nnZu6IetsQG4A+R0AzLvGbhaKZnWQXRLLtEOGg93W9P+NLRi3z7aUK5c4FEH+1k7eyM+E6NwaJZ4MBOFBfGqYspK7f8iw5ah0hvpEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741743144; c=relaxed/simple;
	bh=2PmKo20eALCCLCCybEDsFX9n/0VI1YGdLp5x5dliZGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmn0OyuuteafyfmYeYjRC517rC+eHbofjfJCP1DECkPc+6IbIIccbSaPGdlxUg5yJAMFhZeMQLw8RzqliYzeS5ksrimjJ5tPR2idg/9Db1wJb/Ve2ESuXnkfV5YfmgSEum88Xu4asNzd2kZ0YHpZjPCiCU7VmXFWPf35P03dG9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PJu4Zq0i; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741743142; x=1773279142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2PmKo20eALCCLCCybEDsFX9n/0VI1YGdLp5x5dliZGo=;
  b=PJu4Zq0iQp4WewjhDszuTs0pM4HPb+RjpWJ7FEhgMMgOEr6NvOopfl+G
   4l2Lbo4H23sLGfJ80WQde6a9ZCJ6ljbk+N8gs7ZRXp+ZwIDBTIr4D7fA1
   V0tjeB3G1AGd9CIPlN4M39nFpeEpVunaHQFEHbAPT5TMSeUxfeY9muBsY
   8K+qaaJOi6Ec+pC6uE4MoFotMDpFTEXKSPZ/SKlzBW0A91zyC2vs3+hFb
   k8ldD7U7zf70CsZwAi6w+zPi+7jZXED9FnLuHK1s7CzjraIKN7RBW+mhB
   m9PEQC9+A0AqitqKBrRrmFuphPu+zbg9+RgZ8r3aKlEOq70JAwKuHNjKR
   Q==;
X-CSE-ConnectionGUID: ix2I/xGqQHSqaLCTWFEFew==
X-CSE-MsgGUID: lkVcB613TxqVbhpyZ8MKJQ==
X-IronPort-AV: E=Sophos;i="6.14,240,1736784000"; 
   d="scan'208";a="48299251"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2025 09:32:20 +0800
IronPort-SDR: 67d0d64e_aUCnfq56n3aPn4xsxX53Gbbi92LO6yffoDl8moIyrXTDTIE
 SxiJxOP2X6f80NZo8orqhkd5HLifqJcWgJrJ8Cg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Mar 2025 17:33:19 -0700
WDCIronportException: Internal
Received: from hy1cl13.ad.shared (HELO naota-xeon..) ([10.224.109.64])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Mar 2025 18:32:19 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: dlemoal@kernel.org,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/2] btrfs: zoned: skip reporting zone for new block group
Date: Wed, 12 Mar 2025 10:31:04 +0900
Message-ID: <ec6b55668686f77593f12c579832886294fc7310.1741596325.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741596325.git.naohiro.aota@wdc.com>
References: <cover.1741596325.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a potential deadlock if we do report zones in an IO context. When one
process do a report zones and another process freezes the block device, the
report zones side cannot allocate a tag because the freeze is already started.
This can thus result in new block group creation to hang forever, blocking the
write path.

Thankfully, a new block group should be created on empty zones. So, reporting
the zones is not necessary and we can set the write pointer = 0 and load the
zone capacity from the block layer using bdev_zone_capacity() helper.

CC: stable@vger.kernel.org # 6.13+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 4956baf8220a..6c730f6bce10 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1277,7 +1277,7 @@ struct zone_info {
 
 static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 				struct zone_info *info, unsigned long *active,
-				struct btrfs_chunk_map *map)
+				struct btrfs_chunk_map *map, bool new)
 {
 	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
 	struct btrfs_device *device;
@@ -1307,6 +1307,8 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 		return 0;
 	}
 
+	ASSERT(!new || btrfs_dev_is_empty_zone(device, info->physical));
+
 	/* This zone will be used for allocation, so mark this zone non-empty. */
 	btrfs_dev_clear_zone_empty(device, info->physical);
 
@@ -1319,6 +1321,18 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 	 * to determine the allocation offset within the zone.
 	 */
 	WARN_ON(!IS_ALIGNED(info->physical, fs_info->zone_size));
+
+	if (new) {
+		sector_t capacity;
+
+		capacity = bdev_zone_capacity(device->bdev, info->physical >> SECTOR_SHIFT);
+		up_read(&dev_replace->rwsem);
+		info->alloc_offset = 0;
+		info->capacity = capacity << SECTOR_SHIFT;
+
+		return 0;
+	}
+
 	nofs_flag = memalloc_nofs_save();
 	ret = btrfs_get_dev_zone(device, info->physical, &zone);
 	memalloc_nofs_restore(nofs_flag);
@@ -1588,7 +1602,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	}
 
 	for (i = 0; i < map->num_stripes; i++) {
-		ret = btrfs_load_zone_info(fs_info, i, &zone_info[i], active, map);
+		ret = btrfs_load_zone_info(fs_info, i, &zone_info[i], active, map, new);
 		if (ret)
 			goto out;
 
-- 
2.48.1


