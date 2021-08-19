Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EF33F192D
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 14:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239342AbhHSM2A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 08:28:00 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46871 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239164AbhHSM14 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629376039; x=1660912039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=31udtkov2l5e2UqXWR9Bp322TvmelSlrcJ16q2ILMR4=;
  b=mQ0vroIg1/MN5r42873qlmroF8J2KE1nLutYOoSBUD92iwJXtFypRifY
   2tiwZXeXpXPUiMZpZ74Ir3qPpiI/QYzp+UJ3dBNwAcTOK/rkI9O+y8amr
   S0/c6h/xvu1TDQZ11jm6ERiQM2zR9bvxdINRZvnuFh24OhyIE5eQ9d3WY
   VKGsZ9H0m7EiOFCkaRREgveVWwtuesNiCxqVIW7l5ZkVAilScihUEmueB
   M6AJ+/1zvm4llKLOqmiBpEhkdbCrFwKCH80KxoVRva2iqWL3nvgtZHQKI
   0kf1jgZtNkktYyLVItyt8eFkdkB5cpVmtOC+8/KRKxHNjQQinI1U3HWL/
   g==;
X-IronPort-AV: E=Sophos;i="5.84,334,1620662400"; 
   d="scan'208";a="177773597"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2021 20:27:19 +0800
IronPort-SDR: DMvOVFLLkQRSREDKNr8S2hgESi2PYbppjqDgZhEfIVXDo7aV2F/QrqVdc3qXLANKL2Cs2M8E0V
 jQt3JnVpjHKLp8oCpY84h58lxwXHbnS1tHx+kTmBs4KqjA6NnJYvBXDN2xwld/Irh2//l8KvLd
 6gt7tz+8fZT8H8ZSS4jT8mcD4dOHizgsJf86/VDbumCkrVVjPtZcL3f12ScXGeFF0UcuNgOU4c
 0Mgiwsv0AtKOiS5X8z3ShAFporOM7wlWmJgDSki1+LgoRDJXhG7OuBJwtm1FN60Q8gqK2SrbBV
 XAoFX73Ee5Em3b8ragbgp6e9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 05:04:27 -0700
IronPort-SDR: hwErjTpQT4CDp5j2ZTPq/O401rCevGiymTS5gaI7w2lTWGiQwxT2/HOP3AbLk/+7M/glMATkxb
 KFIM6etEGm2Vm/B0gZ7RP2tYmWtMcZbjQK3EsH7oXQIzJeFrgn8tgbgAZe9N07ni9zZTCgRrWk
 PmAsPdJB9DPDXqx/KvgAHTk60/aK3KX4fE8j85oWAbf+lOnuXN5gJtZIIWxwyt6s1dbeMA5KGP
 s1x0Btqqi10LNJpBB/T1awFTAYZok0msoxYFOHjeXbwxs0iBOX5uyDlBN2ab+9N6I+e7YPT+Oo
 CD0=
WDCIronportException: Internal
Received: from gkg9hr2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.52.110])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2021 05:27:19 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 11/17] btrfs: zoned: load active zone info for block group
Date:   Thu, 19 Aug 2021 21:19:18 +0900
Message-Id: <c50cccd2606e930eb8d8235bac001e4e22a309c4.1629349224.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1629349224.git.naohiro.aota@wdc.com>
References: <cover.1629349224.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Load activeness of underlying zones of a block group. When underlying zones
are active, we add the block group to the fs_info->zone_active_bgs list.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index f28685898df4..441cdd4c507f 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1170,6 +1170,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	unsigned int nofs_flag;
 	u64 *alloc_offsets = NULL;
 	u64 *caps = NULL;
+	unsigned long *active = NULL;
 	u64 last_alloc = 0;
 	u32 num_sequential = 0, num_conventional = 0;
 
@@ -1215,6 +1216,12 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		goto out;
 	}
 
+	active = bitmap_zalloc(map->num_stripes, GFP_NOFS);
+	if (!active) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	for (i = 0; i < map->num_stripes; i++) {
 		bool is_sequential;
 		struct blk_zone zone;
@@ -1298,8 +1305,16 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 			/* Partially used zone */
 			alloc_offsets[i] =
 					((zone.wp - zone.start) << SECTOR_SHIFT);
+			__set_bit(i, active);
 			break;
 		}
+
+		/*
+		 * Consider a zone as active if we can allow any number of
+		 * active zones.
+		 */
+		if (!device->zone_info->max_active_zones)
+			__set_bit(i, active);
 	}
 
 	if (num_sequential > 0)
@@ -1347,6 +1362,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		}
 		cache->alloc_offset = alloc_offsets[0];
 		cache->zone_capacity = caps[0];
+		cache->zone_is_active = test_bit(0, active);
 		break;
 	case BTRFS_BLOCK_GROUP_DUP:
 	case BTRFS_BLOCK_GROUP_RAID1:
@@ -1362,6 +1378,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		goto out;
 	}
 
+	if (cache->zone_is_active) {
+		btrfs_get_block_group(cache);
+		spin_lock(&fs_info->zone_active_bgs_lock);
+		list_add_tail(&cache->active_bg_list,
+			      &fs_info->zone_active_bgs);
+		spin_unlock(&fs_info->zone_active_bgs_lock);
+	}
+
 out:
 	if (cache->alloc_offset > fs_info->zone_size) {
 		btrfs_err(fs_info,
@@ -1393,6 +1417,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		kfree(cache->physical_map);
 		cache->physical_map = NULL;
 	}
+	bitmap_free(active);
 	kfree(caps);
 	kfree(alloc_offsets);
 	free_extent_map(em);
-- 
2.33.0

