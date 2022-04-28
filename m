Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2930B5137A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 17:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348702AbiD1PFl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 11:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343735AbiD1PFk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 11:05:40 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB94B3C6C
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 08:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651158144; x=1682694144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t0pwqfD4XHuiGp+7FfFl1ic8ER7qdyEW1rCq/MyzWXs=;
  b=SegxuJMnwoue9ueYcVuyiM6sAdt2igw6h96S7OHglULHvegCmBXQtn34
   gB+k0Y/CEv4/BxBNJUvQ1L2EPTjVisH9xkeNLh56W9+inChip6PgTfzQ+
   2wI7r6WUw543b0EhVdzYyhbkyuOYjTpw97N5rMZpbFJbK5cqltMCMZIMT
   0cpNYgoD2pBlYehAfTKqJ9vRYdmPKjJFSETXNQBm0eyVmNJyHexm0aA+o
   a8cCnmJRl8qEual0rsDQLl8ugBWXRSboXkqZN58vkDrt4bX5eE5SJdyA7
   QS/cWNS7rlOhxT4eT15NZ8QXUePHXiKMPcGb++cO0orcHBgsgcVCZBHlk
   g==;
X-IronPort-AV: E=Sophos;i="5.91,295,1647273600"; 
   d="scan'208";a="303279894"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 23:02:24 +0800
IronPort-SDR: fr3ji37y6zR4G6FeQVZVIrwz4WlUVpMiL24nqp8lj4RkXiYs5Y2ymDOOUJ0I22kFITOPhnl8CE
 6jMsdkvJAG9n7jwlYxxKbaILnEMR6US7zMnsqbdx62CEE2ripbtvD4tE6LPVkufdnhamwbh9JW
 ofthv61b3anbwlLyBy4UhCpofejov4QYEDJsl5wa91YroY1zQE6u8paX7O6vnZv0Vrj3kqt1my
 KWkDUuq1+hu7E/sMxwDpZMgi5GTFkW4eimg27ONVWAsm+jzqigC5itpv2gy2ozU/7KoIe45n+9
 KHjx+lWfWQTxbgIdx+SyesrX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2022 07:32:32 -0700
IronPort-SDR: N6aWaAmv18LFGdBxfOzZNamlD33rQf9TAmzGwDgu2er7oYp13ImTG164/rN7nrpzS2QCDdmya8
 5EW0wq4Dp/98nxAmX53Unwep+v54ruZlkcxPnVRU2eFQkUSdYYPsUMKysFWozKsUeGPjjXBiQT
 sVsEaXy2foxU1Y2HcEoY9DnN/qIsN7ePhVvg05n8hcX5L3B9Lo7+h9v+gCRyGRfZQ5WDFkAigP
 MfgfsXaL7yf0C1ueiKdSQZXDNAhFy6SJ1pAnzp+W+uXFcrp2H+OHSJDdGEksR4mKT/kq5YMGbm
 9gU=
WDCIronportException: Internal
Received: from fd6v5s2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Apr 2022 08:02:24 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/4] btrfs: zoned: consolidate zone finish function
Date:   Fri, 29 Apr 2022 00:02:15 +0900
Message-Id: <4d5e42d343318979a254f7dbdd96aa1c48908ed8.1651157034.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651157034.git.naohiro.aota@wdc.com>
References: <cover.1651157034.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_zone_finish() and btrfs_zone_finish_endio() have similar code.
Introduce __btrfs_zone_finish() to consolidate them.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 127 ++++++++++++++++++++---------------------------
 1 file changed, 54 insertions(+), 73 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 997a96d7a3d5..9cddafe78fb1 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1879,20 +1879,14 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 	return ret;
 }
 
-int btrfs_zone_finish(struct btrfs_block_group *block_group)
+static int __btrfs_zone_finish(struct btrfs_block_group *block_group, bool nowait)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct map_lookup *map;
-	struct btrfs_device *device;
-	u64 physical;
+	bool need_zone_finish;
 	int ret = 0;
 	int i;
 
-	if (!btrfs_is_zoned(fs_info))
-		return 0;
-
-	map = block_group->physical_map;
-
 	spin_lock(&block_group->lock);
 	if (!block_group->zone_is_active) {
 		spin_unlock(&block_group->lock);
@@ -1906,36 +1900,42 @@ int btrfs_zone_finish(struct btrfs_block_group *block_group)
 		spin_unlock(&block_group->lock);
 		return -EAGAIN;
 	}
-	spin_unlock(&block_group->lock);
 
-	ret = btrfs_inc_block_group_ro(block_group, false);
-	if (ret)
-		return ret;
+	if (!nowait) {
+		spin_unlock(&block_group->lock);
 
-	/* Ensure all writes in this block group finish */
-	btrfs_wait_block_group_reservations(block_group);
-	/* No need to wait for NOCOW writers. Zoned mode does not allow that. */
-	btrfs_wait_ordered_roots(fs_info, U64_MAX, block_group->start,
-				 block_group->length);
+		ret = btrfs_inc_block_group_ro(block_group, false);
+		if (ret)
+			return ret;
 
-	spin_lock(&block_group->lock);
+		/* Ensure all writes in this block group finish */
+		btrfs_wait_block_group_reservations(block_group);
+		/* No need to wait for NOCOW writers. Zoned mode does not allow that. */
+		btrfs_wait_ordered_roots(fs_info, U64_MAX, block_group->start,
+					 block_group->length);
 
-	/*
-	 * Bail out if someone already deactivated the block group, or
-	 * allocated space is left in the block group.
-	 */
-	if (!block_group->zone_is_active) {
-		spin_unlock(&block_group->lock);
-		btrfs_dec_block_group_ro(block_group);
-		return 0;
-	}
+		spin_lock(&block_group->lock);
 
-	if (block_group->reserved) {
-		spin_unlock(&block_group->lock);
-		btrfs_dec_block_group_ro(block_group);
-		return -EAGAIN;
+		/*
+		 * Bail out if someone already deactivated the block group, or
+		 * allocated space is left in the block group.
+		 */
+		if (!block_group->zone_is_active) {
+			spin_unlock(&block_group->lock);
+			btrfs_dec_block_group_ro(block_group);
+			return 0;
+		}
+
+		if (block_group->reserved) {
+			spin_unlock(&block_group->lock);
+			btrfs_dec_block_group_ro(block_group);
+			return -EAGAIN;
+		}
 	}
 
+	/* There is unwritten space left. Need to finish the underlying zones. */
+	need_zone_finish = (block_group->zone_capacity - block_group->alloc_offset) > 0;
+
 	block_group->zone_is_active = 0;
 	block_group->alloc_offset = block_group->zone_capacity;
 	block_group->free_space_ctl->free_space = 0;
@@ -1943,24 +1943,29 @@ int btrfs_zone_finish(struct btrfs_block_group *block_group)
 	btrfs_clear_data_reloc_bg(block_group);
 	spin_unlock(&block_group->lock);
 
+	map = block_group->physical_map;
 	for (i = 0; i < map->num_stripes; i++) {
-		device = map->stripes[i].dev;
-		physical = map->stripes[i].physical;
+		struct btrfs_device *device = map->stripes[i].dev;
+		const u64 physical = map->stripes[i].physical;
 
 		if (device->zone_info->max_active_zones == 0)
 			continue;
 
-		ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
-				       physical >> SECTOR_SHIFT,
-				       device->zone_info->zone_size >> SECTOR_SHIFT,
-				       GFP_NOFS);
+		if (need_zone_finish) {
+			ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
+					       physical >> SECTOR_SHIFT,
+					       device->zone_info->zone_size >> SECTOR_SHIFT,
+					       GFP_NOFS);
 
-		if (ret)
-			return ret;
+			if (ret)
+				return ret;
+		}
 
 		btrfs_dev_clear_active_zone(device, physical);
 	}
-	btrfs_dec_block_group_ro(block_group);
+
+	if (!nowait)
+		btrfs_dec_block_group_ro(block_group);
 
 	spin_lock(&fs_info->zone_active_bgs_lock);
 	ASSERT(!list_empty(&block_group->active_bg_list));
@@ -1973,6 +1978,14 @@ int btrfs_zone_finish(struct btrfs_block_group *block_group)
 	return 0;
 }
 
+int btrfs_zone_finish(struct btrfs_block_group *block_group)
+{
+	if (!btrfs_is_zoned(block_group->fs_info))
+		return 0;
+
+	return __btrfs_zone_finish(block_group, false);
+}
+
 bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 {
 	struct btrfs_fs_info *fs_info = fs_devices->fs_info;
@@ -2004,9 +2017,6 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, u64 length)
 {
 	struct btrfs_block_group *block_group;
-	struct map_lookup *map;
-	struct btrfs_device *device;
-	u64 physical;
 
 	if (!btrfs_is_zoned(fs_info))
 		return;
@@ -2017,36 +2027,7 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, u64 len
 	if (logical + length < block_group->start + block_group->zone_capacity)
 		goto out;
 
-	spin_lock(&block_group->lock);
-
-	if (!block_group->zone_is_active) {
-		spin_unlock(&block_group->lock);
-		goto out;
-	}
-
-	block_group->zone_is_active = 0;
-	/* We should have consumed all the free space */
-	ASSERT(block_group->alloc_offset == block_group->zone_capacity);
-	ASSERT(block_group->free_space_ctl->free_space == 0);
-	btrfs_clear_treelog_bg(block_group);
-	btrfs_clear_data_reloc_bg(block_group);
-	spin_unlock(&block_group->lock);
-
-	map = block_group->physical_map;
-	device = map->stripes[0].dev;
-	physical = map->stripes[0].physical;
-
-	if (!device->zone_info->max_active_zones)
-		goto out;
-
-	btrfs_dev_clear_active_zone(device, physical);
-
-	spin_lock(&fs_info->zone_active_bgs_lock);
-	ASSERT(!list_empty(&block_group->active_bg_list));
-	list_del_init(&block_group->active_bg_list);
-	spin_unlock(&fs_info->zone_active_bgs_lock);
-
-	btrfs_put_block_group(block_group);
+	__btrfs_zone_finish(block_group, true);
 
 out:
 	btrfs_put_block_group(block_group);
-- 
2.35.1

