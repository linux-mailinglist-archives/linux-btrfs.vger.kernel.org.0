Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8275E49C5A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 09:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238649AbiAZI7p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 03:59:45 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42046 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238645AbiAZI7o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 03:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643187585; x=1674723585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2PJr/wWWWuGCLH6OKkXYdEB9XN18Htc0qqBmHDe/CRI=;
  b=OFACKbXh3dEbzzOFRDhBAdo/f3KbeScIRbVXwovutwgi+lyZzlDOjMPB
   Ym2AtVLRfnGxzYT8TGkI4rIbzCKwAP97Xq7fHATFs6I6vAGI+MG19+OLK
   bMegBOW5SVSmLZBlgrQ/9C9ZSGlBD304uMfkHdr/083ONmK5cHUqM1msU
   NJRX9zPnkF4JXVmBjS80Nq86SdvXOwYNbY28JrKyMc7I2hAa4zLk5O8a9
   EtXP0vzd7wPDOuEBrtNtRCWaVptMmpPygT3fWKwcU1bQSWRNy9xMGAnLk
   QIXydXV8iQNqZV067pJeD7SsYT2UPQBUNtd+nQPEQbwLKqxd6rJW4C5o7
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,317,1635177600"; 
   d="scan'208";a="192406582"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2022 16:59:45 +0800
IronPort-SDR: 4rw3YXBix3uLEt5o/Uqvy1MjrpsidS1jtqpi2m5F5fQJfpAj+tZkjDwhBRwsoov9iWWgWuU0RQ
 NJ7mwtsREii0gkJ/YsnkwCifemVjz0F0IEi2ReBcrnjhlomqJkLtc0I1+o+nTke5KRnJCRVOei
 AFfNqmriEjMFZHOxWfOuenV4nFko5/bpdgFAMuFxPiMgF0C2kIeiK6XTNlqzZd0K1mxAGMB8Wy
 uH6Gqm86wqcP9gz3hYd7cCXPcuT1rGtDkSxx3ThDueN26TmHhNQoJLDhnfPe6qyiBdk/zwv+Ty
 f4ffFzu3xJwrNlByq4spsE6O
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 00:31:49 -0800
IronPort-SDR: gXBl5AIMUN5pk+r4sdfBLSvccvJbJr1BO5MaRZPKOJ9EmrEQPwpxe7yINdyv6iOewLeYGsjBQu
 GsqYiujEl+iJilaE6VYxzI2EfCkJq6uTT5DmLQ4cdE51vf0whuIlqhHWlYW0xouE1Pp+9gzNn8
 Ppiw/vgAaWYsrZ/omTz4SXRw6yRJzqWfEpD3NuJaK6Ea2AmzNJ7mth4fcKX4P2Dq5drTe3mwd6
 Zd2vaGwDHbf1LCVF6ccKyiXD9wtRqnvyLxbSiwuxY1DwpHCUqOqePnb15aWO6oAcrxuindSLFN
 gmw=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Jan 2022 00:59:44 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: zoned: make zone activation multi stripe capable
Date:   Wed, 26 Jan 2022 00:59:30 -0800
Message-Id: <64affb64a778431d1eb5158958b5c7db0c99fabf.1643185812.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643185812.git.johannes.thumshirn@wdc.com>
References: <cover.1643185812.git.johannes.thumshirn@wdc.com>
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

