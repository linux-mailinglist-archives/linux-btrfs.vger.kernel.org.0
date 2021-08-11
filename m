Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4163E9382
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 16:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhHKOVP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 10:21:15 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35961 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbhHKOVK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 10:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628691646; x=1660227646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R0HG1SaOMAX5EARuUJru4/592OjUQV/ulzYy4Q3vdcc=;
  b=Np6OlJUXLJDRZZu1sQGGBO1cao2ru3wiXWtiPCumGj/3CCp3P/15Mp70
   4rsG5HLgQbjyM1OFUhoUT3AawLkrM5o2hPyd+mrCbLnlsUBMejWfVTCHW
   j2hCyureKRvH2H+9IGaBZ2Q60DkehL9R5k75/g6HQ4vcXC3fDHnpJU5lK
   vIUCD5n233t7d6rHtTa4z6aCi3L2+QFf2A5a2pRAX0/tiOsyvxJ1of2rj
   tVAKawfTIfWlbXm2hS6Hc+spdKOdxRwWLEhG/aJKASVuC8Ef16ZD1XSmy
   8J4glCHSOmMnnB+12B6Zvj9UJi2X5O7orHzxbVQ+KhwsFhiJZUZcT5UuD
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="176937863"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 22:20:46 +0800
IronPort-SDR: YHYpY/4oqPjK2KqsLk7Oe0Hyj4aXT8gY4f4kGhn5k/7TxkGj56sm6tBGzrPk7Mrkcdn0DUskr3
 +FWyonAYIiIUk6XQy1ijXCWgVHtNZ4qqOFJEmqyaQTxy41jXUpJmpqc2RghkEMghA8AyeOYlgk
 nyxUwlQWuTXh5StDfBdt1ipUxv14X/oOqnJ/CefPR6qSrHt8VT4LTD17rMyVLQZJK7IwGXktRo
 7dpShs69H7cv2hWqsX36DucQFxyuA/Tc4vfyvoW9gjXgz7liuwLI8AwYGKJQJRLBE7O9sQA5D/
 EOABvMQwIVKQgxD326+l6cZs
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 06:56:16 -0700
IronPort-SDR: wuQI8qgL7c8tjrcnSMNdgSPXzyGAEdn/fhSSGyAbF85Q7/TqSjU5xAIfmShnXi7iVrFTHAcnbP
 ScG4OjfFHp0OQ+KHNUKaJb02N8vKDmpLR5Z90EDMVYZJ6Knlbejk1sGp2Ph4sf7J53Xci/54ZS
 252g+/74QLo54zEm1jYmAxoun3RNShHDhEEfGZKx15xroqvVPdxP9rjkeudDlrLHANugoOTOSz
 FYUZCI2j4fi+p4/vx1pLnCUcPZH7/k76ZGyPt5dFZYwRKcCOQxRCy19Pr+ycaYCEuIKMqpl3GE
 SQk=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Aug 2021 07:20:46 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 01/17] btrfs: zoned: load zone capacity information from devices
Date:   Wed, 11 Aug 2021 23:16:25 +0900
Message-Id: <d735079ed82137e569834b944d1b5a9961d39bba.1628690222.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628690222.git.naohiro.aota@wdc.com>
References: <cover.1628690222.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The ZNS specification introduces the concept of a Zone Capacity.  A zone
capacity is an additional per-zone attribute that indicates the number of
usable logical blocks within each zone, starting from the first logical
block of each zone. It is always smaller or equal to the zone size.

With the SINGLE profile, we can set a block group's "capacity" as the same
as the underlying zone's Zone Capacity. We will limit the allocation not
to exceed in a following commit.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.h |  1 +
 fs/btrfs/zoned.c       | 24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index c72a71efcb18..2db40a005512 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -202,6 +202,7 @@ struct btrfs_block_group {
 	 */
 	u64 alloc_offset;
 	u64 zone_unusable;
+	u64 zone_capacity;
 	u64 meta_write_pointer;
 };
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 47af1ab3bf12..32f444c7ec76 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1039,6 +1039,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	int i;
 	unsigned int nofs_flag;
 	u64 *alloc_offsets = NULL;
+	u64 *caps = NULL;
 	u64 last_alloc = 0;
 	u32 num_sequential = 0, num_conventional = 0;
 
@@ -1069,6 +1070,12 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		return -ENOMEM;
 	}
 
+	caps = kcalloc(map->num_stripes, sizeof(*caps), GFP_NOFS);
+	if (!caps) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	for (i = 0; i < map->num_stripes; i++) {
 		bool is_sequential;
 		struct blk_zone zone;
@@ -1131,6 +1138,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 			goto out;
 		}
 
+		caps[i] = zone.capacity << SECTOR_SHIFT;
+
 		switch (zone.cond) {
 		case BLK_ZONE_COND_OFFLINE:
 		case BLK_ZONE_COND_READONLY:
@@ -1144,7 +1153,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 			alloc_offsets[i] = 0;
 			break;
 		case BLK_ZONE_COND_FULL:
-			alloc_offsets[i] = fs_info->zone_size;
+			alloc_offsets[i] = caps[i];
 			break;
 		default:
 			/* Partially used zone */
@@ -1169,6 +1178,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		 * calculate_alloc_pointer() which takes extent buffer
 		 * locks to avoid deadlock.
 		 */
+
+		/* Zone capacity is always zone size in emulation */
+		cache->zone_capacity = cache->length;
 		if (new) {
 			cache->alloc_offset = 0;
 			goto out;
@@ -1195,6 +1207,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 			goto out;
 		}
 		cache->alloc_offset = alloc_offsets[0];
+		cache->zone_capacity = caps[0];
 		break;
 	case BTRFS_BLOCK_GROUP_DUP:
 	case BTRFS_BLOCK_GROUP_RAID1:
@@ -1218,6 +1231,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		ret = -EIO;
 	}
 
+	if (cache->alloc_offset > cache->zone_capacity) {
+		btrfs_err(fs_info,
+"zoned: invalid write pointer %llu (larger than zone capacity %llu) in block group %llu",
+			  cache->alloc_offset, cache->zone_capacity,
+			  cache->start);
+		ret = -EIO;
+	}
+
 	/* An extent is allocated after the write pointer */
 	if (!ret && num_conventional && last_alloc > cache->alloc_offset) {
 		btrfs_err(fs_info,
@@ -1229,6 +1250,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	if (!ret)
 		cache->meta_write_pointer = cache->alloc_offset + cache->start;
 
+	kfree(caps);
 	kfree(alloc_offsets);
 	free_extent_map(em);
 
-- 
2.32.0

