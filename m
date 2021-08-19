Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB06D3F1926
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 14:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbhHSM15 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 08:27:57 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46871 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239094AbhHSM1y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629376037; x=1660912037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/qY3pxt70FVJ7umAg9Qkna1bXSBTa0ZNsLpgDFaX1E8=;
  b=Azshr065uroF8v9OPt9UJXhk70g/2F6qUUioTDrFlFEADFpHA8uiU8++
   8K9F8QM4AjxFKQafw64POE13X9DOvlp9kgtQsqov3N/VrPI8YfOCaAQ2d
   Ak/X1nO+akpjiXrjPH81Zwnde2ycTulQM2eZ19v9dI0L3iDEozwgVHSa1
   hZg10xdkajTiBwU/J43CjlRyfV7KYePKjT8Y2a6kl5fqO77c2KfUu3YYB
   wlufxcsoxZMvKH+5+mrRSGOtCvoCQPvIfmLeFDVU/BI6MLwodVDhdq1PT
   QLrkDoRCEGPEXahqjxlCSIc/2CPl5AFAUGQB70blZsgvYEhy6ieCd6v+y
   A==;
X-IronPort-AV: E=Sophos;i="5.84,334,1620662400"; 
   d="scan'208";a="177773581"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2021 20:27:17 +0800
IronPort-SDR: kbPiMg6JL1Z8Z2cuhiky1UZqbOFiySzxbCJNp0RxKkYcuxh4g+r2A+ECrYtYFU4e38YI3Lag0N
 kEGN+8YidsKnphyaPdAMeWnlHReIKCCvQwfoPuwtRA4qYXZwl7guViKNB6Otz6LcSJiMYeK+fG
 8stFGtPbpJyVrKLY8ZZgDzP8CnpAmp3mKN3ec7gzhWJx8Z6FZbZ5jU0JOo25jBYf45/UcUam46
 qcGHw672KU1Usglou+QBWUrXvgQPuLsXtBqimci/Sqapz6G1nKWnI7yMki21UicxdCQSwLKpJL
 9rJ5Zr4M9lOlDdBUpzr1RMMf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 05:04:25 -0700
IronPort-SDR: kptG92m9+uY8xQ7KmFdn5jqt0DcDmy7k5mblZ/P4jR+qWZ7gorLl7+fNnx2fElZv6O9CElFmWE
 +JQ/5wflxUy5zSQ/RpzqIThujEeIQUGamRIm2cqOGMXZrPua5YnqS+JbhUGSBxQ9wPYh4PS9h9
 50Ls6fBxVENYodyHF4u8NIeG1VWSKRGyxN5nwxTeYqZKfC/v/NRO6Qdt7stxHJjkbTScyhq6AR
 GhSHcDoNLyV632Zjl4gNFeBFBV3tAoEltcFlvGAp98pSCyrnfxR/scAyfCJa/DatUUzBqaI50/
 Y3k=
WDCIronportException: Internal
Received: from gkg9hr2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.52.110])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2021 05:27:17 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 09/17] btrfs: zoned: introduce physical_map to btrfs_block_group
Date:   Thu, 19 Aug 2021 21:19:16 +0900
Message-Id: <2b5e458e2e77a4cc29d081d859d7002d07fc4b9e.1629349224.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1629349224.git.naohiro.aota@wdc.com>
References: <cover.1629349224.git.naohiro.aota@wdc.com>
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
2.33.0

