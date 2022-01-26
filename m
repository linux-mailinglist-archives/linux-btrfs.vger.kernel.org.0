Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6D949CB3A
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 14:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241281AbiAZNq3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 08:46:29 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:46304 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240643AbiAZNq2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 08:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643204788; x=1674740788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3sC7Vc10YDRV+Tyq4v+r5wxd/11qhsQd0P2aO8FBxEM=;
  b=kTLTA382aJqghxmWhr+qX4qL7hWXi84QQwhtb9PMnCjVHlrYac+tzMDV
   sgpBYnllNwNDGiiaCKikpqGlSYfYnKqbeexBCv4ZINupBpu+gefD1u+FX
   pHaNDvkWHyFaJIYBRrNwNcYvOTyL/iw8nhDI+kdGWP7HfZnmXe5alfBDx
   vgtyqGKfYDs04OVdUtX7uISqBASpeTNGOAMzHOSsSEPr032kc+lhFkI1Q
   YzQyjiMKx7rtapr2AdHczyq+01GoKozmsfH/Vl7UImw/sNRLhpbCep9E+
   1Jzqo5Jxn6mdtKmQuTSwajtzzJJ0hPz3hyPtbTiHKQrcadByurFkRoNih
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,318,1635177600"; 
   d="scan'208";a="190373106"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2022 21:46:27 +0800
IronPort-SDR: WNmPnvjmzOo0AcgLnlZWyJ0VhYq9IlpHveTjZHgbKXlELfYrmri1qvPhlE4DWFURFTO/VkVK9l
 RI0BatH7fANWpeTHfdAp956/p0o9NZ7+wzKZOfihg7NHfqUvQXDJdos3iwZbk5sVWZK951YWzU
 txmuc9r+Xl/joUt1xzPyuzMvQ7CtOYljRsnyyfUKYn1XQkchPNNHUbxJPAw3QvY6DN/KVhdGWV
 1sJPyRmpmOPp0c8kdFvKwlpzq8aYD7aWMCfIydNBPQEeUTJH/88JXGcfaVwj+k80LEM1NasUGf
 AmXtdz7L8BnBJ9Gl/W3p/Euu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:19:47 -0800
IronPort-SDR: 1orOCN/uYm0czh86IOghAxGT6qDV0v3MrSDw/2fq2iXlDguhLH9nzNKYiGYqY7CHuvCWvJ/BM9
 ZQ/1uu5LQrKV2KGbysf45sqTQ3o/Ef9vZ9iBPV1l8CkbVDSZpCaW0A/UOqsL5oj5SyaQ1GyUpi
 8N8l9a3iEXnFfKKcms/RZB7un07WEhknVAKAQiEjFv/INI99nR9JBIngZvewy3xR5gp50VqW0G
 tkPh9JjTH5Iz33OI3opAzXQnp9wyPiOJI58IIKxh3E+Scz4yFj3mjbJdXteb91S1AbrGCwTh2V
 Kws=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Jan 2022 05:46:28 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/4] btrfs: zoned: make zone finishing multi stripe capable
Date:   Wed, 26 Jan 2022 05:46:21 -0800
Message-Id: <33664c5883e87e2c989e1a87ae600ea44a8f37a1.1643204608.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643204608.git.johannes.thumshirn@wdc.com>
References: <cover.1643204608.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently finishing of a zone only works if the block group isn't
spanning more than one zone.

This limitation is purely artificial and can be easily expanded to block
groups being places across multiple zones.

This is a preparation for allowing DUP and later more complex block-group
profiles on zoned btrfs.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e3d198405d39..987d2456d398 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1845,19 +1845,12 @@ int btrfs_zone_finish(struct btrfs_block_group *block_group)
 	struct btrfs_device *device;
 	u64 physical;
 	int ret = 0;
+	int i;
 
 	if (!btrfs_is_zoned(fs_info))
 		return 0;
 
 	map = block_group->physical_map;
-	/* Currently support SINGLE profile only */
-	ASSERT(map->num_stripes == 1);
-
-	device = map->stripes[0].dev;
-	physical = map->stripes[0].physical;
-
-	if (device->zone_info->max_active_zones == 0)
-		return 0;
 
 	spin_lock(&block_group->lock);
 	if (!block_group->zone_is_active) {
@@ -1909,25 +1902,34 @@ int btrfs_zone_finish(struct btrfs_block_group *block_group)
 	btrfs_clear_data_reloc_bg(block_group);
 	spin_unlock(&block_group->lock);
 
-	ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
-			       physical >> SECTOR_SHIFT,
-			       device->zone_info->zone_size >> SECTOR_SHIFT,
-			       GFP_NOFS);
-	btrfs_dec_block_group_ro(block_group);
+	for (i = 0; i < map->num_stripes; i++) {
+		device = map->stripes[i].dev;
+		physical = map->stripes[i].physical;
 
-	if (!ret) {
-		btrfs_dev_clear_active_zone(device, physical);
+		if (device->zone_info->max_active_zones == 0)
+			continue;
 
-		spin_lock(&fs_info->zone_active_bgs_lock);
-		ASSERT(!list_empty(&block_group->active_bg_list));
-		list_del_init(&block_group->active_bg_list);
-		spin_unlock(&fs_info->zone_active_bgs_lock);
+		ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
+				       physical >> SECTOR_SHIFT,
+				       device->zone_info->zone_size >> SECTOR_SHIFT,
+				       GFP_NOFS);
+
+		if (ret)
+			return ret;
 
-		/* For active_bg_list */
-		btrfs_put_block_group(block_group);
+		btrfs_dev_clear_active_zone(device, physical);
 	}
+	btrfs_dec_block_group_ro(block_group);
 
-	return ret;
+	spin_lock(&fs_info->zone_active_bgs_lock);
+	ASSERT(!list_empty(&block_group->active_bg_list));
+	list_del_init(&block_group->active_bg_list);
+	spin_unlock(&fs_info->zone_active_bgs_lock);
+
+	/* For active_bg_list */
+	btrfs_put_block_group(block_group);
+
+	return 0;
 }
 
 bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
-- 
2.31.1

