Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C19455F310
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jun 2022 04:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiF2CAu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jun 2022 22:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiF2CAt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jun 2022 22:00:49 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD342EA21
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jun 2022 19:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656468048; x=1688004048;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8KNupTZzge5fdey3PQgUM9PaMp7RilS3qaKnv8UlUjY=;
  b=GeabOhb1qk2sMnoEPm+sy790r0AcJDBPAtGsqxlv6DYS3NTMDnNKlVFb
   EbDOLm0GwHio0xnRl1M2zpgUzwSTmx5fZsJHDGgwShUqDVjRDKQAe9e5h
   5OMyiXK7R7caxGmitzzSsBm8LVbDvspH4VT8MBDDYnHyWEVE0Z0Hos5gD
   sVvXBsf4HDFWTN9ZAtwHokxdjz484l9KESMAJGtdsxZp3NtjJTdRLdXxQ
   Cvhe2Wc84g9j2gzQ9o3E2zBUGFrPxoiZhvNyypCdtNjG8VW53mRV78BWO
   /Z03vdrkQoKjqwQEy0szI65dnpWxauRBkHVf48SkylvY1Ag/hpMb5/foy
   A==;
X-IronPort-AV: E=Sophos;i="5.92,230,1650902400"; 
   d="scan'208";a="203018467"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 10:00:47 +0800
IronPort-SDR: AOv/mU1I43V1uSqWXSXWaFvHc9y/Q0STJNZtVgjbcliiRKi8phBQBZ/WBMqSYfW2Qh6vRVqiT1
 0oIItI+ggNXA5Zl/ctKrweo8Sy0yV/upOp+vQiZp8bTzQKGXJR+EAp7ihEvmxzPoN/eRTw114z
 HrBPtthX0biTfkIUjzdxUazT6TeinnC6SyMPa4NtD9DuJM6JDwAuZfV6I/lFD9pAXhfn9JpHmQ
 jArrmjcX8MGBAMXlOTCEBOe7kTQyw6zN9p8onp4VgmTydK+2RbTuXhqhDeA8IO6iSKerBAieRR
 b84C2IQOGUODWnXEgRCsx4et
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 18:18:26 -0700
IronPort-SDR: hpxVgeqgnlXLOlxOL9Xz3miXAM13aKS44eZSzQhPWB7h29IJjW6j+XvTOJGF2MrCxcYQUthZ86
 nG3RpzauMvf++kcNLMeFgN/2TwWdOsD14Lx1BNdeFVbiTafOjwBMvdCIrFRA7jnJWWIHW4j9MH
 fq4+g+t2mkcpTxJrPzN8R2vxlOE92dkXYInOAb8kC4NniqEsIfl2PVtImPAqTu4ERfFpIosocb
 +96bN6oA0C411TimXhOVAAE9zWuKl3fz/DBXp4Mb7lC2Fm0tSTWfkOfsFXgPm8pEGqRcz3KA3I
 pLU=
WDCIronportException: Internal
Received: from fcp68s2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.51.242])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Jun 2022 19:00:46 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: drop optimization of zone finish
Date:   Wed, 29 Jun 2022 11:00:38 +0900
Message-Id: <c5e53de667c5ec4ff49aa1719da1be7e1f80734e.1656467635.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
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

We have an optimization in do_zone_finish() to send REQ_OP_ZONE_FINISH only
when necessary, i.e., we don't send REQ_OP_ZONE_FINISH when we assume we
wrote fully into the zone.

The assumption is determined by "alloc_offset == capacity". This condition
won't work if the last ordered extent is canceled due to some errors. In
that case, we consider the zone is deactivated without sending the finish
command while it's still active.

This inconstancy results in activating another block group while we cannot
really activate the underlying zone, which causes the active zone exceeds
errors like below.

    BTRFS error (device nvme3n2): allocation failed flags 1, wanted 520192 tree-log 0, relocation: 0
    nvme3n2: I/O Cmd(0x7d) @ LBA 160432128, 127 blocks, I/O Error (sct 0x1 / sc 0xbd) MORE DNR
    active zones exceeded error, dev nvme3n2, sector 0 op 0xd:(ZONE_APPEND) flags 0x4800 phys_seg 1 prio class 0
    nvme3n2: I/O Cmd(0x7d) @ LBA 160432128, 127 blocks, I/O Error (sct 0x1 / sc 0xbd) MORE DNR
    active zones exceeded error, dev nvme3n2, sector 0 op 0xd:(ZONE_APPEND) flags 0x4800 phys_seg 1 prio class 0

Fix the issue by removing the optimization for now.

CC: stable@vger.kernel.org # 5.18.x: d70cbdda75da btrfs: zoned: consolidate zone finish functions
CC: stable@vger.kernel.org # 5.18.x
Fixes: 8376d9e1ed8f ("btrfs: zoned: finish superblock zone once no space left for new SB")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 7a0f8fa44800..119f75b11363 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1885,7 +1885,6 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct map_lookup *map;
-	bool need_zone_finish;
 	int ret = 0;
 	int i;
 
@@ -1942,12 +1941,6 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 		}
 	}
 
-	/*
-	 * The block group is not fully allocated, so not fully written yet. We
-	 * need to send ZONE_FINISH command to free up an active zone.
-	 */
-	need_zone_finish = !btrfs_zoned_bg_is_full(block_group);
-
 	block_group->zone_is_active = 0;
 	block_group->alloc_offset = block_group->zone_capacity;
 	block_group->free_space_ctl->free_space = 0;
@@ -1963,15 +1956,13 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 		if (device->zone_info->max_active_zones == 0)
 			continue;
 
-		if (need_zone_finish) {
-			ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
-					       physical >> SECTOR_SHIFT,
-					       device->zone_info->zone_size >> SECTOR_SHIFT,
-					       GFP_NOFS);
+		ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
+				       physical >> SECTOR_SHIFT,
+				       device->zone_info->zone_size >> SECTOR_SHIFT,
+				       GFP_NOFS);
 
-			if (ret)
-				return ret;
-		}
+		if (ret)
+			return ret;
 
 		btrfs_dev_clear_active_zone(device, physical);
 	}
-- 
2.35.1

