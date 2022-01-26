Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5DD49C5A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 09:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbiAZI7p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 03:59:45 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42046 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiAZI7p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 03:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643187585; x=1674723585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3sC7Vc10YDRV+Tyq4v+r5wxd/11qhsQd0P2aO8FBxEM=;
  b=LT5/uGksPp1KS3NPzNlaJrM1C2O77ArHmRQ2TFsaxVYUF2ZOerablAip
   9Lp6enUOwZ0t8vpFeiAi44YgZiCAUExMU+VPGSEJDlmrx7+lbmEAiW2bS
   CWzqYRdXNZsijoLVJwi20w5mF6wRXvGwdesD1b2ZE+ruJJtyeLgbcBkV9
   y2QlnXAlCjlu2avGKUpqcbrKw45qm3rj+GBNB76kxRjjXH6bmE3bbYt07
   C2wXzgw8gff7tGwOngeOKTH69jJlIihPhGJhfqql9aK/LoIo3DkV16ZV/
   lKPHK4u7oKnVEbK3UOcjb4IGZ5zIB8kHZk6CiZ0As3/bzzVcDeG9QB8BG
   w==;
X-IronPort-AV: E=Sophos;i="5.88,317,1635177600"; 
   d="scan'208";a="192406583"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2022 16:59:45 +0800
IronPort-SDR: Ee74hUER8b33mmwrwl/guUfgR3wc8p/vkLHnqHzmZ2n7uJ4KBlvvdfetyxxihOy9DbzKWU81bC
 ooafH95yV0cDw6O5b+IQlcearffBQG5DLCXKuSEnf1vOLB+DANRK0/oF9eXDeC4IL/G234xpL0
 nAxNOnwGfGOeXJfTdLlb0LwH/5GbijVx9upn8FUPXhbbxOfleyH5SjYPF8s2pViEOrRb08SnGb
 zVCa9UqwMdll6PePHR015XSWM949IDCHEf0Z+QpVlo7GBl19TpoFl7yameUGPqKLVOK2xLgC34
 pQDYw5my8QWKognDssJpG23L
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 00:31:49 -0800
IronPort-SDR: ZoC6Il5f4h4a1RRvDYp6/6KMTQDeRN2jEq9UdJh7TWVUOrBrO0/sijThwLzjwT3/k7OgLmVtRW
 RlEP6f/9JedgXzbUCtY4g+0CZQ9120BPWjTI/r4b1jxm7z93S7GW3aCMvwoLEOjRqpc7l5iN/D
 85b4kzZoW5QsTRneqYXq5bzTQN+JwR5jj86eaW4tZKxPA8U9SU1w1zhJv+GbsfwvmGxuz2hAh4
 l3udhOy9b2FfgQnRiXpkFWpekZqm1kjKbQ2PvkIdlwAMhGhYlDj2bYR507hoDEZeycZN7Gkzfm
 lS0=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Jan 2022 00:59:45 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: zoned: make zone finishing multi stripe capable
Date:   Wed, 26 Jan 2022 00:59:31 -0800
Message-Id: <37ef057e777624647a1ab5988115707e77c53aae.1643185812.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643185812.git.johannes.thumshirn@wdc.com>
References: <cover.1643185812.git.johannes.thumshirn@wdc.com>
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

