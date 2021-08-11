Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774A03E938A
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 16:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhHKOV1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 10:21:27 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35977 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbhHKOVT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 10:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628691655; x=1660227655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zU2idOabwJoqFZBtkH9iENAlTmh1ZrQD5KOMojjSq8Y=;
  b=rGPpHITLnDsa1XKraV3DXz6t6gWCt30OJ0/VGaPYvHpuEzm+6xgKe+1f
   efSXuxkTSNER90GtVCN+VYDjdPZhhz4kV/9QggVYsZIckmuab0PAJ6GvE
   UtSa4Po58Y7IG+PTZUXPOMpddauVnMW6C5kz6JRAJTo2fglGC9BxoKz9l
   hMuZE7wrAw+czdGh6LR7nG2rVBAw4cte4inAdOED6yQq2djjuxHLYKcRh
   segAdWIf8o1Ly3fTFGuYyG4ZOU3WGDWxgcjXvSIrrWlnExt25UIqhGnH3
   lsC430Y53vDLHypzvhSTW4QV8+HpEPJOVRZvwcxzkkDBPGd7qCuaticgt
   A==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="176937890"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 22:20:55 +0800
IronPort-SDR: 7vDQKOXlSW9lWxG7C1ezZLHm4UmZFVnoDq8Zz+vWV/UjJS19V/+O9dQImKOCkW1cQ3IoEhlEAc
 yme6tFTz136lJSDIouo79PlKcKd7s3+7Dg89NlyY4Q4zcmq9NrrLWmbYGHyKUslgYOQL6znF2l
 kfFLxEQDKnUTcbLiRDCx+hkMUNw5z1jQRDf7v9MCIVFeXNaTgtkqMuu4e8YZUu8eFW1wwuauCb
 Xy1hUL9xFFcqNV8t1ua5sR8EvMcreiH3Z8fciifmKJriQemZkFfS1X/ikUuDnARrCGqEusCNc2
 qoesOHAw1u7k+Er2+EZYcww7
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 06:56:25 -0700
IronPort-SDR: cOu5A18FLJZG9NFptBlno+Ic6Zu3paAhg1o/qzXgd7crzfZrX6PyiuDRLjaM0+oSNLptteXOU5
 Q1XPoFlpqQbGuevT2/nmzXq62lzUo/OWXh0+BttkgzCGGa8EpAVmoVOt5u8aNIS0zczW9P4vsH
 JqUBFCoNikk3B7dBYThS2vcu4CnL4j6LOXbdZ4n74JM5KoSI/J+72U0W4iaYN8uKCRo+w5xpL7
 22jAF7cmtBA2YsMtO6NXu94Aobiy8SSCuGwDGA2iH1jhLylmOB20LzTofoyQapCiqUmHkyPW8Z
 opY=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Aug 2021 07:20:55 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 09/17] btrfs: zoned: introduce physical_map to btrfs_block_group
Date:   Wed, 11 Aug 2021 23:16:33 +0900
Message-Id: <10439dc1a45272fa6e4b6aeb3596b6e977f49fa0.1628690222.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628690222.git.naohiro.aota@wdc.com>
References: <cover.1628690222.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We will use a block group's physical location to track active zones and
finish fully written zones in the following commits. Since the zone
activation is done in the extent allocation context which already holding
the tree locks, we can't query the chunk tree for the physical locations.
So, copy the location info into a block group and use it for activation.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |  1 +
 fs/btrfs/block-group.h |  1 +
 fs/btrfs/zoned.c       | 17 +++++++++++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index de22e3c9599e..c94815cbd136 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -144,6 +144,7 @@ void btrfs_put_block_group(struct btrfs_block_group *cache)
 		 */
 		WARN_ON(!RB_EMPTY_ROOT(&cache->full_stripe_locks_root.root));
 		kfree(cache->free_space_ctl);
+		kfree(cache->physical_map);
 		kfree(cache);
 	}
 }
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 2db40a005512..265db2c316d3 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -204,6 +204,7 @@ struct btrfs_block_group {
 	u64 zone_unusable;
 	u64 zone_capacity;
 	u64 meta_write_pointer;
+	struct map_lookup *physical_map;
 };
 
 static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index a198ce073353..cfc6d4337473 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1158,10 +1158,19 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 
 	map = em->map_lookup;
 
+	cache->physical_map = kmalloc(map_lookup_size(map->num_stripes),
+				      GFP_NOFS);
+	if (!cache->physical_map) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	memcpy(cache->physical_map, map, map_lookup_size(map->num_stripes));
+
 	alloc_offsets = kcalloc(map->num_stripes, sizeof(*alloc_offsets), GFP_NOFS);
 	if (!alloc_offsets) {
-		free_extent_map(em);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 
 	caps = kcalloc(map->num_stripes, sizeof(*caps), GFP_NOFS);
@@ -1344,6 +1353,10 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	if (!ret)
 		cache->meta_write_pointer = cache->alloc_offset + cache->start;
 
+	if (ret) {
+		kfree(cache->physical_map);
+		cache->physical_map = NULL;
+	}
 	kfree(caps);
 	kfree(alloc_offsets);
 	free_extent_map(em);
-- 
2.32.0

