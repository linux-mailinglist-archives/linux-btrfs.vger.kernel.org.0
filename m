Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3091B519300
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 02:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244773AbiEDAxP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 20:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244769AbiEDAxO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 20:53:14 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EDD3F881
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 17:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651625380; x=1683161380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nh9pnvyypqwWTofcXe8XBLctV0p4cmgHPKQU0UzWMSw=;
  b=WqOO11D6ig1Zx+ZEUTX8gFxphKc6evLjv8ttdFOj6p6u4nnx8nrsmhPU
   0Zr4tGBpo1H+ruT7AnA6E2xAMtdjaNiuBUhB43WaLIsLVfs2RVRCThG1i
   TjOnSX7NEbI/eMiZU9wVWdkNxfoN1DKWwih8mJ37AyNurq2vPYb+RQLT7
   eukV8SuKlkcgMZokvkgwAwtoG/p2vxX4E0yL00VmefwLd6WridmGVdgYT
   WzUEC3WtYLFlBQf8L2PK+YCojrkcxOMroaoRbZjnswDJjFaKrSAW4KcyS
   QPdRZvauqA25GYdAyaJr/nVx1pDVgBL7Ba2CtJDjpKH84qoZtijCOVQFa
   w==;
X-IronPort-AV: E=Sophos;i="5.91,196,1647273600"; 
   d="scan'208";a="200341881"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2022 08:49:40 +0800
IronPort-SDR: Udx/7ISMvUM+i1CAfhmROtJHUjT7uYYFiCMs7UfIh26sNJMceXIKPXRl09RWnk2dD2a1PSy3Cq
 tFWo/R5tKmdjLzzTY2K+/jZrOwguSNcucGpAh7TtSyf4SwNNTndj7v6PWGmPPdNMm3cya04AJJ
 apTjEwnt93evvN30D5Pryq9jQX8aAk8XZpbn3rII1qhvUcKG1mJzdx2krd3RYvGrYJF7Q8DLQs
 Fi3hFrmGsYSxUYZlwP+RGIZY9rOfGa6W2RDWYYo/9mN3c/AS2RodKIAnDA0/KkeSKxODryOORn
 iFv9bUKAfQWUBCZORtmbDZ9N
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 May 2022 17:19:42 -0700
IronPort-SDR: fsImnAQxQlsIw162V/XofqdCKJ+FBSRkNI1FcBYv0IpIn6ByV2rh3C67JXJr2OMCEeMUnx7LVX
 TE8VCIJtHjHNcdl1WMoJr0kUjkuiPfvtExT0nfM4Q4lsPVAsYSmr4lZih6c4EY6mVfyY2DRF2+
 hBm/71kkamCLnga3a+kNH2gsESdndjCE4Gjj01vB2XOnG4j0QNvMFMSgziXiFT77emIwdf7YiV
 x4Hjoj6iaZxPyObPQIfzrxtrs4TovL805EHdNaGTFk/94KdQuUCenaSe1uGQHYjyqBQFxHgStU
 UAo=
WDCIronportException: Internal
Received: from jv0vzd3.ad.shared (HELO naota-x1.wdc.com) ([10.225.48.207])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 May 2022 17:49:39 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 2/5] btrfs: zoned: consolidate zone finish function
Date:   Tue,  3 May 2022 17:48:51 -0700
Message-Id: <3710880ddfd0ce03bc0c239dc8665a846f0049c6.1651624820.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651624820.git.naohiro.aota@wdc.com>
References: <cover.1651624820.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_zone_finish() and btrfs_zone_finish_endio() have similar code.
Introduce __btrfs_zone_finish() to consolidate them.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 137 ++++++++++++++++++++++-------------------------
 1 file changed, 64 insertions(+), 73 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index cc0c5dd5a901..0286fb1c63db 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1873,20 +1873,14 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 	return ret;
 }
 
-int btrfs_zone_finish(struct btrfs_block_group *block_group)
+static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_written)
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
@@ -1900,36 +1894,52 @@ int btrfs_zone_finish(struct btrfs_block_group *block_group)
 		spin_unlock(&block_group->lock);
 		return -EAGAIN;
 	}
-	spin_unlock(&block_group->lock);
-
-	ret = btrfs_inc_block_group_ro(block_group, false);
-	if (ret)
-		return ret;
-
-	/* Ensure all writes in this block group finish */
-	btrfs_wait_block_group_reservations(block_group);
-	/* No need to wait for NOCOW writers. Zoned mode does not allow that. */
-	btrfs_wait_ordered_roots(fs_info, U64_MAX, block_group->start,
-				 block_group->length);
-
-	spin_lock(&block_group->lock);
 
 	/*
-	 * Bail out if someone already deactivated the block group, or
-	 * allocated space is left in the block group.
+	 * If we are sure that the block group is full (= no more room left for
+	 * new allocation) and the IO for the last usable block is completed, we
+	 * don't need to wait for the other IOs. This holds because we ensure
+	 * the sequential IO submissions using the ZONE_APPEND command for data
+	 * and block_group->meta_write_pointer for metadata.
 	 */
-	if (!block_group->zone_is_active) {
+	if (!fully_written) {
 		spin_unlock(&block_group->lock);
-		btrfs_dec_block_group_ro(block_group);
-		return 0;
-	}
 
-	if (block_group->reserved) {
-		spin_unlock(&block_group->lock);
-		btrfs_dec_block_group_ro(block_group);
-		return -EAGAIN;
+		ret = btrfs_inc_block_group_ro(block_group, false);
+		if (ret)
+			return ret;
+
+		/* Ensure all writes in this block group finish */
+		btrfs_wait_block_group_reservations(block_group);
+		/* No need to wait for NOCOW writers. Zoned mode does not allow that. */
+		btrfs_wait_ordered_roots(fs_info, U64_MAX, block_group->start,
+					 block_group->length);
+
+		spin_lock(&block_group->lock);
+
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
 
+	/*
+	 * The block group is not fully allocated, so not fully written yet. We
+	 * need to send ZONE_FINISH command to free up an active zone.
+	 */
+	need_zone_finish = !btrfs_zoned_bg_is_full(block_group);
+
 	block_group->zone_is_active = 0;
 	block_group->alloc_offset = block_group->zone_capacity;
 	block_group->free_space_ctl->free_space = 0;
@@ -1937,24 +1947,29 @@ int btrfs_zone_finish(struct btrfs_block_group *block_group)
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
+	if (!fully_written)
+		btrfs_dec_block_group_ro(block_group);
 
 	spin_lock(&fs_info->zone_active_bgs_lock);
 	ASSERT(!list_empty(&block_group->active_bg_list));
@@ -1967,6 +1982,14 @@ int btrfs_zone_finish(struct btrfs_block_group *block_group)
 	return 0;
 }
 
+int btrfs_zone_finish(struct btrfs_block_group *block_group)
+{
+	if (!btrfs_is_zoned(block_group->fs_info))
+		return 0;
+
+	return do_zone_finish(block_group, false);
+}
+
 bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 {
 	struct btrfs_fs_info *fs_info = fs_devices->fs_info;
@@ -1998,9 +2021,6 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, u64 length)
 {
 	struct btrfs_block_group *block_group;
-	struct map_lookup *map;
-	struct btrfs_device *device;
-	u64 physical;
 
 	if (!btrfs_is_zoned(fs_info))
 		return;
@@ -2011,36 +2031,7 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, u64 len
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
+	do_zone_finish(block_group, true);
 
 out:
 	btrfs_put_block_group(block_group);
-- 
2.35.1

