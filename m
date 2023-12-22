Return-Path: <linux-btrfs+bounces-1121-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C61581C478
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Dec 2023 05:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59363284886
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Dec 2023 04:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB9E53AA;
	Fri, 22 Dec 2023 04:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xq+nIVJY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE328523C
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Dec 2023 04:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1703221024; x=1734757024;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lftUTuLlCGMLRwBz1tVxuRwKBXIpRC4IDXUnMSHnMDU=;
  b=Xq+nIVJYDJ3xVSMv+baPjlcfsmaCdv/2U3o1B+nKUGsLJhBFY7ycEqmJ
   FGGEqJgWTiCl2X9efifp5+c2ZQycNsbM7GP6Ivo5+YVO4Y0Uf+byjTtoq
   58iAPtsmmbRn850PvpEzAKNrBw0eY+sJsFM7xw4Jn/FhMzZzuI65o+E+U
   ZsPW6PWqO8g5yxa4sTf2T8AAuR1XVDVcWWNT0OF+2QoR4zdYoiZupr3ze
   qDIcWZu5aax++W/Uc+0pw950POh90vPkZfAAcxSSjV/rYlwwHFWl5Z5el
   oMnB8z+3ArXOLamXUxIGbbVsvRIetjqLetAilrdhGoid6aUlMpgHCb92w
   Q==;
X-CSE-ConnectionGUID: /8ctJ7DeQwK6IbBn3+7T8Q==
X-CSE-MsgGUID: 9oTNv+HEQ52z0s6P+XOAew==
X-IronPort-AV: E=Sophos;i="6.04,294,1695657600"; 
   d="scan'208";a="5472549"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2023 12:57:03 +0800
IronPort-SDR: wssOQKBOaQ3+h6Gcx9OzzGw2QPf81gu953WedXwzVq3MsRr0VQzgmceMaCLyXHnPMPEMhxMo+u
 SNfNc40m8TEg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Dec 2023 20:02:05 -0800
IronPort-SDR: y+jpx5kn5vVVtbBt32csZmUvOaTBF4b0AxR+r1HmMbVLIM97KxbAtB2c8/bLj6Asdehed03mAf
 x2FHd87KRt8g==
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.97])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Dec 2023 20:57:03 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: fix lock ordering in btrfs_zone_activate()
Date: Fri, 22 Dec 2023 13:56:34 +0900
Message-ID: <6e209698b6956fb5cc9da480ac194a6d79426148.1703220899.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The btrfs CI reported a lockdep warning as follows by running generic
generic/129.

   ======================================================
   WARNING: possible circular locking dependency detected
   6.7.0-rc5+ #1 Not tainted
   ------------------------------------------------------
   kworker/u5:5/793427 is trying to acquire lock:
   ffff88813256d028 (&cache->lock){+.+.}-{2:2}, at: btrfs_zone_finish_one_bg+0x5e/0x130
   but task is already holding lock:
   ffff88810a23a318 (&fs_info->zone_active_bgs_lock){+.+.}-{2:2}, at: btrfs_zone_finish_one_bg+0x34/0x130
   which lock already depends on the new lock.

   the existing dependency chain (in reverse order) is:
   -> #1 (&fs_info->zone_active_bgs_lock){+.+.}-{2:2}:
   ...
   -> #0 (&cache->lock){+.+.}-{2:2}:
   ...

This is because we take fs_info->zone_active_bgs_lock after a block_group's
lock in btrfs_zone_activate() while doing the opposite other place.

Fix the issue by expanding the fs_info->zone_active_bgs_lock's critical
section and taking it before a block_group's lock.

CC: stable@vger.kernel.org # 6.6
Fixes: a7e1ac7bdc5a ("btrfs: zoned: reserve zones for an active metadata/system block group")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 12066afc235c..ac9bbe0c4ffe 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2072,6 +2072,7 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 
 	map = block_group->physical_map;
 
+	spin_lock(&fs_info->zone_active_bgs_lock);
 	spin_lock(&block_group->lock);
 	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags)) {
 		ret = true;
@@ -2084,7 +2085,6 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 		goto out_unlock;
 	}
 
-	spin_lock(&fs_info->zone_active_bgs_lock);
 	for (i = 0; i < map->num_stripes; i++) {
 		struct btrfs_zoned_device_info *zinfo;
 		int reserved = 0;
@@ -2104,20 +2104,17 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 		 */
 		if (atomic_read(&zinfo->active_zones_left) <= reserved) {
 			ret = false;
-			spin_unlock(&fs_info->zone_active_bgs_lock);
 			goto out_unlock;
 		}
 
 		if (!btrfs_dev_set_active_zone(device, physical)) {
 			/* Cannot activate the zone */
 			ret = false;
-			spin_unlock(&fs_info->zone_active_bgs_lock);
 			goto out_unlock;
 		}
 		if (!is_data)
 			zinfo->reserved_active_zones--;
 	}
-	spin_unlock(&fs_info->zone_active_bgs_lock);
 
 	/* Successfully activated all the zones */
 	set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags);
@@ -2125,8 +2122,6 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 
 	/* For the active block group list */
 	btrfs_get_block_group(block_group);
-
-	spin_lock(&fs_info->zone_active_bgs_lock);
 	list_add_tail(&block_group->active_bg_list, &fs_info->zone_active_bgs);
 	spin_unlock(&fs_info->zone_active_bgs_lock);
 
@@ -2134,6 +2129,7 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 
 out_unlock:
 	spin_unlock(&block_group->lock);
+	spin_unlock(&fs_info->zone_active_bgs_lock);
 	return ret;
 }
 
-- 
2.43.0


