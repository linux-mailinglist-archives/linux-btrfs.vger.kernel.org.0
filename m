Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6F9354E48
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 10:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237320AbhDFIIG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 04:08:06 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4298 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239304AbhDFIIG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Apr 2021 04:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617696502; x=1649232502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i/7A/NBkseawY7PczIVP4b9ZJDMCS9aAjjDendbEmhk=;
  b=NtcE/VSD6+V3WmYcQtZ2BWr/nrI4LpESMCzcTx245+9Z94s40hs6ne3Y
   vslOUR4uJk4g24h0T3Lfy4K5vFQl8GCrodxpd6+B1493vZ77QwZGzw+3S
   S4JAY2cVba0r3G68eVGkmPxN8VDDo2lo+5iWbk5N8vxbzupXhioo7AfQ4
   1bCNsKG0fjhada7URWARJQEZVsWkC0X8pAfXCrauraHGPJLfRBSu9KN0m
   cR064o/xB7NcDtdmlJn7AyAZoe8jdh/rSatkVfDXuq/w26435hX+j9Iv4
   RTmdvLs0imy1SpcXkpiCKvJtkLuPoCAym1bLwrGzp4tE8QUHnfMGE2Jyg
   A==;
IronPort-SDR: ZbLMdSlZHsJ1VoSTtITpx4Pslhw3ARzUFjaX0dC3lNPuWdCLw6OehY8/WScP/2iJgNzdHVES8/
 9E9Rn1IkipAToULYYMRxTWqP6hHp1XvOUbQHTgPdkawVugKXIIgpfmSdj4Q3kWwZ0CJvLQDDaE
 aYwvti/3qnUZZOnJyNqzXgTnIsIV/lY+WU7UZE6TU/k/dZQb97XDaxV5bzYaVk5ontEBPQivKP
 JdmpMpCMViafdnH4+poy/Nzu5fMW3HZfaGTbQuNCf5f/tQhAzKBs+5PoW0Lf8GfGHBRBUlwf+G
 EH0=
X-IronPort-AV: E=Sophos;i="5.81,308,1610380800"; 
   d="scan'208";a="268290702"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2021 16:08:00 +0800
IronPort-SDR: 2fzsezHRC2VjcSjc2Fe5PYeQpYWgVL0G0i2fGGVC+9EZR9W+STLmlNfkRJZB30xkpatH3Xh8Vw
 NDm34wbLBROueZMvOUyRCSG7DM4RGF2GiQ+Z5Eg6rvtje/CbpeyMne9lckqloJgeFuDWadDBlm
 GbAUK72C6Xh1MN23bkx3qMWXEkc2EpuT3q2gosPM+mmpc36LohB1OflsUAFil4WE/6d+kiTM16
 DBHF/nPVul7UZXDvmuxwIitARYqevf4NRyr4YxfB7SqvNLM2PrtYQPmTRvPGjVdTKzV5XZP7Gf
 nVs9d5Ng8D/cGUPNiB/7iNI0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 00:48:25 -0700
IronPort-SDR: 3lJ9MNbMm4I8IL02/tkXU9PT8JnCqIYDAP8rc42KcCC52d4dOxbc5KzvfjbhsKzw3KNi8UDCHs
 wreMTesSnEFAInX917tYR58fiK7C7ZuNFVi+t3TcY+5LZVOqwBmV8WD7BMiqHKGNTZw63sFhEw
 uvCyvE/y48pJyzDe4TCQ/gRchKtwjaDyXt9nR6vlv5LiqVqcOK+f2pU9s+l7LP+vnEAFRNPdvf
 sedPQ+ww3JqINRTls8KGtASXF+6zVaEF9x0y599W45kXvBdyzRI7CoWdwyw9hngImsTB22DpPb
 dAA=
WDCIronportException: Internal
Received: from 5pgg7h2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.29])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Apr 2021 01:07:00 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 06/12] btrfs-progs: factor out create_chunk()
Date:   Tue,  6 Apr 2021 17:05:48 +0900
Message-Id: <d4ff8e93e92baf64b28e02e129ba084ac7032663.1617694997.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617694997.git.naohiro.aota@wdc.com>
References: <cover.1617694997.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Factor out create_chunk() from btrfs_alloc_chunk(). This new function
creates a chunk.

There is no functional changes.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/volumes.c | 217 ++++++++++++++++++++++------------------
 1 file changed, 120 insertions(+), 97 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 95b42eab846d..a409dd3d0366 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -149,6 +149,7 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 };
 
 struct alloc_chunk_ctl {
+	u64 start;
 	u64 type;
 	int num_stripes;
 	int max_stripes;
@@ -156,6 +157,7 @@ struct alloc_chunk_ctl {
 	int sub_stripes;
 	u64 calc_size;
 	u64 min_stripe_size;
+	u64 num_bytes;
 	u64 max_chunk_size;
 	int stripe_len;
 	int total_devs;
@@ -1118,88 +1120,23 @@ static int decide_stripe_size(struct btrfs_fs_info *info,
 	}
 }
 
-int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
-		      struct btrfs_fs_info *info, u64 *start,
-		      u64 *num_bytes, u64 type)
+static int create_chunk(struct btrfs_trans_handle *trans,
+			struct btrfs_fs_info *info, struct alloc_chunk_ctl *ctl,
+			struct list_head *private_devs)
 {
-	u64 dev_offset;
 	struct btrfs_root *extent_root = info->extent_root;
 	struct btrfs_root *chunk_root = info->chunk_root;
 	struct btrfs_stripe *stripes;
 	struct btrfs_device *device = NULL;
 	struct btrfs_chunk *chunk;
-	struct list_head private_devs;
 	struct list_head *dev_list = &info->fs_devices->devices;
 	struct list_head *cur;
 	struct map_lookup *map;
-	u64 min_free;
-	u64 avail = 0;
-	u64 max_avail = 0;
-	struct alloc_chunk_ctl ctl;
-	int looped = 0;
 	int ret;
 	int index;
 	struct btrfs_key key;
 	u64 offset;
 
-	if (list_empty(dev_list)) {
-		return -ENOSPC;
-	}
-
-	ctl.type = type;
-	init_alloc_chunk_ctl(info, &ctl);
-	if (ctl.num_stripes < ctl.min_stripes)
-		return -ENOSPC;
-
-again:
-	ret = decide_stripe_size(info, &ctl);
-	if (ret < 0)
-		return ret;
-
-	INIT_LIST_HEAD(&private_devs);
-	cur = dev_list->next;
-	index = 0;
-
-	if (type & BTRFS_BLOCK_GROUP_DUP)
-		min_free = ctl.calc_size * 2;
-	else
-		min_free = ctl.calc_size;
-
-	/* build a private list of devices we will allocate from */
-	while(index < ctl.num_stripes) {
-		device = list_entry(cur, struct btrfs_device, dev_list);
-		ret = btrfs_device_avail_bytes(trans, device, &avail);
-		if (ret)
-			return ret;
-		cur = cur->next;
-		if (avail >= min_free) {
-			list_move(&device->dev_list, &private_devs);
-			index++;
-			if (type & BTRFS_BLOCK_GROUP_DUP)
-				index++;
-		} else if (avail > max_avail)
-			max_avail = avail;
-		if (cur == dev_list)
-			break;
-	}
-	if (index < ctl.num_stripes) {
-		list_splice(&private_devs, dev_list);
-		if (index >= ctl.min_stripes) {
-			ctl.num_stripes = index;
-			if (type & (BTRFS_BLOCK_GROUP_RAID10)) {
-				ctl.num_stripes /= ctl.sub_stripes;
-				ctl.num_stripes *= ctl.sub_stripes;
-			}
-			looped = 1;
-			goto again;
-		}
-		if (!looped && max_avail > 0) {
-			looped = 1;
-			ctl.calc_size = max_avail;
-			goto again;
-		}
-		return -ENOSPC;
-	}
 	ret = find_next_chunk(info, &offset);
 	if (ret)
 		return ret;
@@ -1207,36 +1144,38 @@ again:
 	key.type = BTRFS_CHUNK_ITEM_KEY;
 	key.offset = offset;
 
-	chunk = kmalloc(btrfs_chunk_item_size(ctl.num_stripes), GFP_NOFS);
+	chunk = kmalloc(btrfs_chunk_item_size(ctl->num_stripes), GFP_NOFS);
 	if (!chunk)
 		return -ENOMEM;
 
-	map = kmalloc(btrfs_map_lookup_size(ctl.num_stripes), GFP_NOFS);
+	map = kmalloc(btrfs_map_lookup_size(ctl->num_stripes), GFP_NOFS);
 	if (!map) {
 		kfree(chunk);
 		return -ENOMEM;
 	}
 
 	stripes = &chunk->stripe;
-	*num_bytes = chunk_bytes_by_type(type, ctl.calc_size, &ctl);
+	ctl->num_bytes = chunk_bytes_by_type(ctl->type, ctl->calc_size, ctl);
 	index = 0;
-	while(index < ctl.num_stripes) {
+	while (index < ctl->num_stripes) {
+		u64 dev_offset;
 		struct btrfs_stripe *stripe;
-		BUG_ON(list_empty(&private_devs));
-		cur = private_devs.next;
+
+		BUG_ON(list_empty(private_devs));
+		cur = private_devs->next;
 		device = list_entry(cur, struct btrfs_device, dev_list);
 
 		/* loop over this device again if we're doing a dup group */
-		if (!(type & BTRFS_BLOCK_GROUP_DUP) ||
-		    (index == ctl.num_stripes - 1))
+		if (!(ctl->type & BTRFS_BLOCK_GROUP_DUP) ||
+		    (index == ctl->num_stripes - 1))
 			list_move(&device->dev_list, dev_list);
 
 		ret = btrfs_alloc_dev_extent(trans, device, key.offset,
-			     ctl.calc_size, &dev_offset);
+			     ctl->calc_size, &dev_offset);
 		if (ret < 0)
 			goto out_chunk_map;
 
-		device->bytes_used += ctl.calc_size;
+		device->bytes_used += ctl->calc_size;
 		ret = btrfs_update_device(trans, device);
 		if (ret < 0)
 			goto out_chunk_map;
@@ -1249,41 +1188,41 @@ again:
 		memcpy(stripe->dev_uuid, device->uuid, BTRFS_UUID_SIZE);
 		index++;
 	}
-	BUG_ON(!list_empty(&private_devs));
+	BUG_ON(!list_empty(private_devs));
 
 	/* key was set above */
-	btrfs_set_stack_chunk_length(chunk, *num_bytes);
+	btrfs_set_stack_chunk_length(chunk, ctl->num_bytes);
 	btrfs_set_stack_chunk_owner(chunk, extent_root->root_key.objectid);
-	btrfs_set_stack_chunk_stripe_len(chunk, ctl.stripe_len);
-	btrfs_set_stack_chunk_type(chunk, type);
-	btrfs_set_stack_chunk_num_stripes(chunk, ctl.num_stripes);
-	btrfs_set_stack_chunk_io_align(chunk, ctl.stripe_len);
-	btrfs_set_stack_chunk_io_width(chunk, ctl.stripe_len);
+	btrfs_set_stack_chunk_stripe_len(chunk, ctl->stripe_len);
+	btrfs_set_stack_chunk_type(chunk, ctl->type);
+	btrfs_set_stack_chunk_num_stripes(chunk, ctl->num_stripes);
+	btrfs_set_stack_chunk_io_align(chunk, ctl->stripe_len);
+	btrfs_set_stack_chunk_io_width(chunk, ctl->stripe_len);
 	btrfs_set_stack_chunk_sector_size(chunk, info->sectorsize);
-	btrfs_set_stack_chunk_sub_stripes(chunk, ctl.sub_stripes);
+	btrfs_set_stack_chunk_sub_stripes(chunk, ctl->sub_stripes);
 	map->sector_size = info->sectorsize;
-	map->stripe_len = ctl.stripe_len;
-	map->io_align = ctl.stripe_len;
-	map->io_width = ctl.stripe_len;
-	map->type = type;
-	map->num_stripes = ctl.num_stripes;
-	map->sub_stripes = ctl.sub_stripes;
+	map->stripe_len = ctl->stripe_len;
+	map->io_align = ctl->stripe_len;
+	map->io_width = ctl->stripe_len;
+	map->type = ctl->type;
+	map->num_stripes = ctl->num_stripes;
+	map->sub_stripes = ctl->sub_stripes;
 
 	ret = btrfs_insert_item(trans, chunk_root, &key, chunk,
-				btrfs_chunk_item_size(ctl.num_stripes));
+				btrfs_chunk_item_size(ctl->num_stripes));
 	BUG_ON(ret);
-	*start = key.offset;;
+	ctl->start = key.offset;
 
 	map->ce.start = key.offset;
-	map->ce.size = *num_bytes;
+	map->ce.size = ctl->num_bytes;
 
 	ret = insert_cache_extent(&info->mapping_tree.cache_tree, &map->ce);
 	if (ret < 0)
 		goto out_chunk_map;
 
-	if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
+	if (ctl->type & BTRFS_BLOCK_GROUP_SYSTEM) {
 		ret = btrfs_add_system_chunk(info, &key,
-			    chunk, btrfs_chunk_item_size(ctl.num_stripes));
+			    chunk, btrfs_chunk_item_size(ctl->num_stripes));
 		if (ret < 0)
 			goto out_chunk;
 	}
@@ -1298,6 +1237,90 @@ out_chunk:
 	return ret;
 }
 
+int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
+		      struct btrfs_fs_info *info, u64 *start,
+		      u64 *num_bytes, u64 type)
+{
+	struct btrfs_device *device = NULL;
+	struct list_head private_devs;
+	struct list_head *dev_list = &info->fs_devices->devices;
+	struct list_head *cur;
+	u64 min_free;
+	u64 avail = 0;
+	u64 max_avail = 0;
+	struct alloc_chunk_ctl ctl;
+	int looped = 0;
+	int ret;
+	int index;
+
+	if (list_empty(dev_list))
+		return -ENOSPC;
+
+	ctl.type = type;
+	/* start and num_bytes will be set by create_chunk() */
+	ctl.start = 0;
+	ctl.num_bytes = 0;
+	init_alloc_chunk_ctl(info, &ctl);
+	if (ctl.num_stripes < ctl.min_stripes)
+		return -ENOSPC;
+
+again:
+	ret = decide_stripe_size(info, &ctl);
+	if (ret < 0)
+		return ret;
+
+	INIT_LIST_HEAD(&private_devs);
+	cur = dev_list->next;
+	index = 0;
+
+	if (type & BTRFS_BLOCK_GROUP_DUP)
+		min_free = ctl.calc_size * 2;
+	else
+		min_free = ctl.calc_size;
+
+	/* build a private list of devices we will allocate from */
+	while (index < ctl.num_stripes) {
+		device = list_entry(cur, struct btrfs_device, dev_list);
+		ret = btrfs_device_avail_bytes(trans, device, &avail);
+		if (ret)
+			return ret;
+		cur = cur->next;
+		if (avail >= min_free) {
+			list_move(&device->dev_list, &private_devs);
+			index++;
+			if (type & BTRFS_BLOCK_GROUP_DUP)
+				index++;
+		} else if (avail > max_avail)
+			max_avail = avail;
+		if (cur == dev_list)
+			break;
+	}
+	if (index < ctl.num_stripes) {
+		list_splice(&private_devs, dev_list);
+		if (index >= ctl.min_stripes) {
+			ctl.num_stripes = index;
+			if (type & (BTRFS_BLOCK_GROUP_RAID10)) {
+				ctl.num_stripes /= ctl.sub_stripes;
+				ctl.num_stripes *= ctl.sub_stripes;
+			}
+			looped = 1;
+			goto again;
+		}
+		if (!looped && max_avail > 0) {
+			looped = 1;
+			ctl.calc_size = max_avail;
+			goto again;
+		}
+		return -ENOSPC;
+	}
+
+	ret = create_chunk(trans, info, &ctl, &private_devs);
+	*start = ctl.start;
+	*num_bytes = ctl.num_bytes;
+
+	return ret;
+}
+
 /*
  * Alloc a DATA chunk with SINGLE profile.
  *
-- 
2.31.1

