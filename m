Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6621F54E4
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 14:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbgFJMd0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 08:33:26 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12382 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgFJMdX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 08:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591792402; x=1623328402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4rTThLZPL/2dTjEKuvaP6/qRdu3n3nG+IXm41NpwE8c=;
  b=nx4Qeab2y0hKsDvMWAbuaxh7b/pINoBU04G5RTIyLvJwrV7h5JXsSdaa
   1Dvgk4VSSHrVSIuRXSUbcLOyH58oC3uQh8/z96OnaDq8M64xg3Tm+Cub1
   1cohtKSms34Ns9nPrEWZReplMVKILH2yrYmdzzlD63LwY0J9ZFS0qwFNb
   YE+X0OdY0Zhe26GDqkb1l0faydyaelv6/Tc61JdzMfJl4wGIi1BNIjzMI
   SfZwdVGGlJ8HvhruFv4lCxEf7NHbfpByCnL7Cw99DcUFeCDqzOV/IHmz4
   s/YVehvWrTm/pLJVmFvN5+oCwStkYrZ7PSHqgSWruEBM8hR+DI1tPGBta
   A==;
IronPort-SDR: f0et1iv0PRf+R1pmQfN7udtzDUrhzSnbnHcHMfrqhx1WpHyg3O2BifZGI3/NyBHsJ/EG907/nz
 k6SbVP0zQqUGc/6piBfSNIYQpoE2njAwThg7vluGDBPP52QNJ0YpcTJ86YGwU1nCi6I6IDq1QG
 aGg6YfGU12HXEZBbgcruEvNHUbY166eXb6F7Um8yzHVXhaBuxELqUgCU+20pSvAJEs7uBedFCE
 eP2DvWNtS5Ts46YNrp5R9GL1AwIc1+Qj5m9vVwohbmeR/jpQo1K1eRz+8NJlU8z1m8RTC1iux7
 eoY=
X-IronPort-AV: E=Sophos;i="5.73,496,1583164800"; 
   d="scan'208";a="139632694"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2020 20:33:06 +0800
IronPort-SDR: VAOyevNs6qzaMzEnumfaMeYQGdp3vtwKuLyUc1hOLe2q1FgLR85nRAv1p+F0InpSV3Ugp8FzMS
 RvSidKcPQlAp7enn3XJexhUIKjv3M5/8Y=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 05:22:33 -0700
IronPort-SDR: EbOYOJIlm7YBbnGL+DGYgLFu0it65bLaaSuHukT6f0SY/kHE3uaDqg1vysglEPSAz9/LUB3Jii
 WXWLXZJD9Oyg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jun 2020 05:33:06 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 03/15] btrfs-progs: introduce alloc_chunk_ctl structure
Date:   Wed, 10 Jun 2020 21:32:46 +0900
Message-Id: <20200610123258.12382-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
References: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce an alloc_chunk_ctl structure, which holds parameters to control
chunk allocation.

Furthermore use this throughout btrfs_alloc_chunk().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 volumes.c | 140 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 76 insertions(+), 64 deletions(-)

diff --git a/volumes.c b/volumes.c
index 2a33dc09d7e7..ea3e105859da 100644
--- a/volumes.c
+++ b/volumes.c
@@ -148,6 +148,16 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 	},
 };
 
+struct alloc_chunk_ctl {
+	enum btrfs_raid_types type;
+	int num_stripes;
+	int max_stripes;
+	int min_stripes;
+	int sub_stripes;
+	int stripe_len;
+	int total_devs;
+};
+
 struct stripe {
 	struct btrfs_device *dev;
 	u64 physical;
@@ -1016,14 +1026,10 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	u64 avail = 0;
 	u64 max_avail = 0;
 	u64 percent_max;
-	int num_stripes = 1;
-	int max_stripes = 0;
-	int min_stripes = 1;
-	int sub_stripes = 1;
+	struct alloc_chunk_ctl ctl;
 	int looped = 0;
 	int ret;
 	int index;
-	int stripe_len = BTRFS_STRIPE_LEN;
 	struct btrfs_key key;
 	u64 offset;
 
@@ -1031,17 +1037,23 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		return -ENOSPC;
 	}
 
+	ctl.num_stripes = 1;
+	ctl.max_stripes = 0;
+	ctl.min_stripes = 1;
+	ctl.sub_stripes = 1;
+	ctl.stripe_len = BTRFS_STRIPE_LEN;
+
 	if (type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
 		if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
 			calc_size = SZ_8M;
 			max_chunk_size = calc_size * 2;
 			min_stripe_size = SZ_1M;
-			max_stripes = BTRFS_MAX_DEVS_SYS_CHUNK;
+			ctl.max_stripes = BTRFS_MAX_DEVS_SYS_CHUNK;
 		} else if (type & BTRFS_BLOCK_GROUP_DATA) {
 			calc_size = SZ_1G;
 			max_chunk_size = 10 * calc_size;
 			min_stripe_size = SZ_64M;
-			max_stripes = BTRFS_MAX_DEVS(info);
+			ctl.max_stripes = BTRFS_MAX_DEVS(info);
 		} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
 			/* for larger filesystems, use larger metadata chunks */
 			if (info->fs_devices->total_rw_bytes > 50ULL * SZ_1G)
@@ -1050,64 +1062,64 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 				max_chunk_size = SZ_256M;
 			calc_size = max_chunk_size;
 			min_stripe_size = SZ_32M;
-			max_stripes = BTRFS_MAX_DEVS(info);
+			ctl.max_stripes = BTRFS_MAX_DEVS(info);
 		}
 	}
 	if (type & BTRFS_BLOCK_GROUP_RAID1) {
-		min_stripes = 2;
-		num_stripes = min_t(u64, min_stripes,
+		ctl.min_stripes = 2;
+		ctl.num_stripes = min_t(u64, ctl.min_stripes,
 				  btrfs_super_num_devices(info->super_copy));
-		if (num_stripes < min_stripes)
+		if (ctl.num_stripes < ctl.min_stripes)
 			return -ENOSPC;
 	}
 	if (type & BTRFS_BLOCK_GROUP_RAID1C3) {
-		min_stripes = 3;
-		num_stripes = min_t(u64, min_stripes,
+		ctl.min_stripes = 3;
+		ctl.num_stripes = min_t(u64, ctl.min_stripes,
 				  btrfs_super_num_devices(info->super_copy));
-		if (num_stripes < min_stripes)
+		if (ctl.num_stripes < ctl.min_stripes)
 			return -ENOSPC;
 	}
 	if (type & BTRFS_BLOCK_GROUP_RAID1C4) {
-		min_stripes = 4;
-		num_stripes = min_t(u64, min_stripes,
+		ctl.min_stripes = 4;
+		ctl.num_stripes = min_t(u64, ctl.min_stripes,
 				  btrfs_super_num_devices(info->super_copy));
-		if (num_stripes < min_stripes)
+		if (ctl.num_stripes < ctl.min_stripes)
 			return -ENOSPC;
 	}
 	if (type & BTRFS_BLOCK_GROUP_DUP) {
-		num_stripes = 2;
-		min_stripes = 2;
+		ctl.num_stripes = 2;
+		ctl.min_stripes = 2;
 	}
 	if (type & (BTRFS_BLOCK_GROUP_RAID0)) {
-		num_stripes = min_t(u64, max_stripes,
+		ctl.num_stripes = min_t(u64, ctl.max_stripes,
 				    btrfs_super_num_devices(info->super_copy));
-		min_stripes = 2;
+		ctl.min_stripes = 2;
 	}
 	if (type & (BTRFS_BLOCK_GROUP_RAID10)) {
-		min_stripes = 4;
-		num_stripes = min_t(u64, max_stripes,
+		ctl.min_stripes = 4;
+		ctl.num_stripes = min_t(u64, ctl.max_stripes,
 				    btrfs_super_num_devices(info->super_copy));
-		if (num_stripes < min_stripes)
+		if (ctl.num_stripes < ctl.min_stripes)
 			return -ENOSPC;
-		num_stripes &= ~(u32)1;
-		sub_stripes = 2;
+		ctl.num_stripes &= ~(u32)1;
+		ctl.sub_stripes = 2;
 	}
 	if (type & (BTRFS_BLOCK_GROUP_RAID5)) {
-		min_stripes = 2;
-		num_stripes = min_t(u64, max_stripes,
+		ctl.min_stripes = 2;
+		ctl.num_stripes = min_t(u64, ctl.max_stripes,
 				    btrfs_super_num_devices(info->super_copy));
-		if (num_stripes < min_stripes)
+		if (ctl.num_stripes < ctl.min_stripes)
 			return -ENOSPC;
-		stripe_len = find_raid56_stripe_len(num_stripes - 1,
+		ctl.stripe_len = find_raid56_stripe_len(ctl.num_stripes - 1,
 				    btrfs_super_stripesize(info->super_copy));
 	}
 	if (type & (BTRFS_BLOCK_GROUP_RAID6)) {
-		min_stripes = 3;
-		num_stripes = min_t(u64, max_stripes,
+		ctl.min_stripes = 3;
+		ctl.num_stripes = min_t(u64, ctl.max_stripes,
 				    btrfs_super_num_devices(info->super_copy));
-		if (num_stripes < min_stripes)
+		if (ctl.num_stripes < ctl.min_stripes)
 			return -ENOSPC;
-		stripe_len = find_raid56_stripe_len(num_stripes - 2,
+		ctl.stripe_len = find_raid56_stripe_len(ctl.num_stripes - 2,
 				    btrfs_super_stripesize(info->super_copy));
 	}
 
@@ -1116,18 +1128,18 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	max_chunk_size = min(percent_max, max_chunk_size);
 
 again:
-	if (chunk_bytes_by_type(type, calc_size, num_stripes, sub_stripes) >
-	    max_chunk_size) {
+	if (chunk_bytes_by_type(type, calc_size, ctl.num_stripes,
+				ctl.sub_stripes) > max_chunk_size) {
 		calc_size = max_chunk_size;
-		calc_size /= num_stripes;
-		calc_size /= stripe_len;
-		calc_size *= stripe_len;
+		calc_size /= ctl.num_stripes;
+		calc_size /= ctl.stripe_len;
+		calc_size *= ctl.stripe_len;
 	}
 	/* we don't want tiny stripes */
 	calc_size = max_t(u64, calc_size, min_stripe_size);
 
-	calc_size /= stripe_len;
-	calc_size *= stripe_len;
+	calc_size /= ctl.stripe_len;
+	calc_size *= ctl.stripe_len;
 	INIT_LIST_HEAD(&private_devs);
 	cur = dev_list->next;
 	index = 0;
@@ -1138,7 +1150,7 @@ again:
 		min_free = calc_size;
 
 	/* build a private list of devices we will allocate from */
-	while(index < num_stripes) {
+	while(index < ctl.num_stripes) {
 		device = list_entry(cur, struct btrfs_device, dev_list);
 		ret = btrfs_device_avail_bytes(trans, device, &avail);
 		if (ret)
@@ -1154,13 +1166,13 @@ again:
 		if (cur == dev_list)
 			break;
 	}
-	if (index < num_stripes) {
+	if (index < ctl.num_stripes) {
 		list_splice(&private_devs, dev_list);
-		if (index >= min_stripes) {
-			num_stripes = index;
+		if (index >= ctl.min_stripes) {
+			ctl.num_stripes = index;
 			if (type & (BTRFS_BLOCK_GROUP_RAID10)) {
-				num_stripes /= sub_stripes;
-				num_stripes *= sub_stripes;
+				ctl.num_stripes /= ctl.sub_stripes;
+				ctl.num_stripes *= ctl.sub_stripes;
 			}
 			looped = 1;
 			goto again;
@@ -1179,11 +1191,11 @@ again:
 	key.type = BTRFS_CHUNK_ITEM_KEY;
 	key.offset = offset;
 
-	chunk = kmalloc(btrfs_chunk_item_size(num_stripes), GFP_NOFS);
+	chunk = kmalloc(btrfs_chunk_item_size(ctl.num_stripes), GFP_NOFS);
 	if (!chunk)
 		return -ENOMEM;
 
-	map = kmalloc(btrfs_map_lookup_size(num_stripes), GFP_NOFS);
+	map = kmalloc(btrfs_map_lookup_size(ctl.num_stripes), GFP_NOFS);
 	if (!map) {
 		kfree(chunk);
 		return -ENOMEM;
@@ -1191,9 +1203,9 @@ again:
 
 	stripes = &chunk->stripe;
 	*num_bytes = chunk_bytes_by_type(type, calc_size,
-					 num_stripes, sub_stripes);
+					 ctl.num_stripes, ctl.sub_stripes);
 	index = 0;
-	while(index < num_stripes) {
+	while(index < ctl.num_stripes) {
 		struct btrfs_stripe *stripe;
 		BUG_ON(list_empty(&private_devs));
 		cur = private_devs.next;
@@ -1201,7 +1213,7 @@ again:
 
 		/* loop over this device again if we're doing a dup group */
 		if (!(type & BTRFS_BLOCK_GROUP_DUP) ||
-		    (index == num_stripes - 1))
+		    (index == ctl.num_stripes - 1))
 			list_move(&device->dev_list, dev_list);
 
 		ret = btrfs_alloc_dev_extent(trans, device, key.offset,
@@ -1227,23 +1239,23 @@ again:
 	/* key was set above */
 	btrfs_set_stack_chunk_length(chunk, *num_bytes);
 	btrfs_set_stack_chunk_owner(chunk, extent_root->root_key.objectid);
-	btrfs_set_stack_chunk_stripe_len(chunk, stripe_len);
+	btrfs_set_stack_chunk_stripe_len(chunk, ctl.stripe_len);
 	btrfs_set_stack_chunk_type(chunk, type);
-	btrfs_set_stack_chunk_num_stripes(chunk, num_stripes);
-	btrfs_set_stack_chunk_io_align(chunk, stripe_len);
-	btrfs_set_stack_chunk_io_width(chunk, stripe_len);
+	btrfs_set_stack_chunk_num_stripes(chunk, ctl.num_stripes);
+	btrfs_set_stack_chunk_io_align(chunk, ctl.stripe_len);
+	btrfs_set_stack_chunk_io_width(chunk, ctl.stripe_len);
 	btrfs_set_stack_chunk_sector_size(chunk, info->sectorsize);
-	btrfs_set_stack_chunk_sub_stripes(chunk, sub_stripes);
+	btrfs_set_stack_chunk_sub_stripes(chunk, ctl.sub_stripes);
 	map->sector_size = info->sectorsize;
-	map->stripe_len = stripe_len;
-	map->io_align = stripe_len;
-	map->io_width = stripe_len;
+	map->stripe_len = ctl.stripe_len;
+	map->io_align = ctl.stripe_len;
+	map->io_width = ctl.stripe_len;
 	map->type = type;
-	map->num_stripes = num_stripes;
-	map->sub_stripes = sub_stripes;
+	map->num_stripes = ctl.num_stripes;
+	map->sub_stripes = ctl.sub_stripes;
 
 	ret = btrfs_insert_item(trans, chunk_root, &key, chunk,
-				btrfs_chunk_item_size(num_stripes));
+				btrfs_chunk_item_size(ctl.num_stripes));
 	BUG_ON(ret);
 	*start = key.offset;;
 
@@ -1256,7 +1268,7 @@ again:
 
 	if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
 		ret = btrfs_add_system_chunk(info, &key,
-				    chunk, btrfs_chunk_item_size(num_stripes));
+			    chunk, btrfs_chunk_item_size(ctl.num_stripes));
 		if (ret < 0)
 			goto out_chunk;
 	}
-- 
2.26.2

