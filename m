Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D59249CB39
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 14:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240698AbiAZNq2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 08:46:28 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:46304 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbiAZNq2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 08:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643204787; x=1674740787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2PJr/wWWWuGCLH6OKkXYdEB9XN18Htc0qqBmHDe/CRI=;
  b=hhrTWjV7GejSL8eOSNfvrXFIhdE2migoaTmasUH+cB14+R00BlFT1t9k
   FNHi7QD1tuD5EHW6FaHKbZRmZ+V2yaNtyXfsKRMfzhcImSUtK4wXsTKay
   JaiFxGJytvEBV5ndyabd7pw5EGctZE9sXahbedtGuEfkczDbDnZg9zJE+
   YMVg1gAYWNQDk5WG8kTQ1906I2O79/TbAtAfqJiuJLgu2mvj79rJSL1B+
   +Hsk3PIWa2JEbYzm2tHPDG019fzKkKMpg7AaWQAC/G6AIHxx1Vliphrk3
   56eq5sB/BM2hiXu8Jo8GvsPSd/NaPPxKdaWnjPv0v99BD9jmI9CjDZafP
   A==;
X-IronPort-AV: E=Sophos;i="5.88,318,1635177600"; 
   d="scan'208";a="190373105"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2022 21:46:27 +0800
IronPort-SDR: GdKhRzrA38e8OQdvqPulKzEa3DsrOyZsZAaE/WSmQYIDKgtFNu3fTk0bq1oGr02vxz1R4ogpMy
 fQK8VShiqFZGPYF1RjO0vtb633IjU0ST12CCw2CRoMrDNUdMMli6ByPo1Yd1IsUt8a6AhvTHUq
 OjWe13Eh/RwwxcgeFUTjPlOy3Q4dsJWd5kSZmRlsP+39boZiT9FVJUxAaKsRGxxdir6ufTwXWE
 kuYvVemPo1h/uLXVtnqYfzfjSJgbX1v8fSYcJXXj9YSegjJYS8XUP8Pfte6v/NeY7zDuvAYdS2
 9AH2xoslaEzeZZeQZ+WbiRAc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:19:47 -0800
IronPort-SDR: KRuj34ITY+cfLbPDVd77BaGZuDoLIYsIF11j1gDFbYNjEmqPr4spyjJP/9d2vq8iub4yqeZ1E9
 cf48Ly+E+rIxLEm140bFMvz6hH1FiJimFnRpY3UNSmOTh43c67hqV0QJ1Cl3rP1/baeOD+yo9O
 6pe+sdgdzteafZ3RHiTQeGJcSD+xTCI6hFjwycU1fE0JocWLyYOZrFyY0L3+WjqfmqdIlZT/sH
 VKzATtcqqgDab7eXpx1CmZ5cqHhJ1yyvbupXSxY74dFzk3VQWEPwLWiK5Saj79SSaUQlZ6H75w
 sJA=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Jan 2022 05:46:27 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/4] btrfs: zoned: make zone activation multi stripe capable
Date:   Wed, 26 Jan 2022 05:46:20 -0800
Message-Id: <10aeef328429cc5ecc2b8ac75464c07d6449a5ea.1643204608.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643204608.git.johannes.thumshirn@wdc.com>
References: <cover.1643204608.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently activation of a zone only works if the block group isn't
spanning more than one zone.

This limitation is purely artificial and can be easily expanded to block
groups being places across multiple zones.

This is a preparation for allowing DUP and later more complex block-group
profiles on zoned btrfs.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 57 ++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index f559d517c7c4..e3d198405d39 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1781,50 +1781,55 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 	struct btrfs_device *device;
 	u64 physical;
 	bool ret;
+	int i;
 
 	if (!btrfs_is_zoned(block_group->fs_info))
 		return true;
 
 	map = block_group->physical_map;
-	/* Currently support SINGLE profile only */
-	ASSERT(map->num_stripes == 1);
-	device = map->stripes[0].dev;
-	physical = map->stripes[0].physical;
-
-	if (device->zone_info->max_active_zones == 0)
-		return true;
 
 	spin_lock(&block_group->lock);
-
 	if (block_group->zone_is_active) {
 		ret = true;
 		goto out_unlock;
 	}
 
-	/* No space left */
-	if (block_group->alloc_offset == block_group->zone_capacity) {
-		ret = false;
-		goto out_unlock;
-	}
+	for (i = 0; i < map->num_stripes; i++) {
+		device = map->stripes[i].dev;
+		physical = map->stripes[i].physical;
 
-	if (!btrfs_dev_set_active_zone(device, physical)) {
-		/* Cannot activate the zone */
-		ret = false;
-		goto out_unlock;
-	}
+		if (device->zone_info->max_active_zones == 0)
+			continue;
+
+		/* No space left */
+		if (block_group->alloc_offset == block_group->zone_capacity) {
+			ret = false;
+			goto out_unlock;
+		}
+
+		if (!btrfs_dev_set_active_zone(device, physical)) {
+			/* Cannot activate the zone */
+			ret = false;
+			goto out_unlock;
+		}
+
+		/* Successfully activated all the zones */
+		if (i == map->num_stripes - 1)
+			block_group->zone_is_active = 1;
 
-	/* Successfully activated all the zones */
-	block_group->zone_is_active = 1;
 
+	}
 	spin_unlock(&block_group->lock);
 
-	/* For the active block group list */
-	btrfs_get_block_group(block_group);
+	if (block_group->zone_is_active) {
+		/* For the active block group list */
+		btrfs_get_block_group(block_group);
 
-	spin_lock(&fs_info->zone_active_bgs_lock);
-	ASSERT(list_empty(&block_group->active_bg_list));
-	list_add_tail(&block_group->active_bg_list, &fs_info->zone_active_bgs);
-	spin_unlock(&fs_info->zone_active_bgs_lock);
+		spin_lock(&fs_info->zone_active_bgs_lock);
+		list_add_tail(&block_group->active_bg_list,
+			      &fs_info->zone_active_bgs);
+		spin_unlock(&fs_info->zone_active_bgs_lock);
+	}
 
 	return true;
 
-- 
2.31.1

