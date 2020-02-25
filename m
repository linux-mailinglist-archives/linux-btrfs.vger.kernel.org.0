Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1DC916B846
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 04:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgBYD5L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 22:57:11 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34216 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbgBYD5K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 22:57:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582603030; x=1614139030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UXooGQ6m9FbDHNc2PR+2H55BH57wjrn1A6srh2NtkdA=;
  b=m3eD0V/IkleFin06Xu3kdobNh6AMNU80cUPf9KZeqMyOsdu38HGc28m4
   FNnslVcwXMHWZpQc6neRQmVEYm5svzUNW/FZQtwkB0k5RVFwZmER7k9v8
   Xxckff6cSZUHHacVn1JQFXq2GU426U1W3UeC7TI4n2xg+q9iIHypQ5iCA
   N2V/tEkq1Ifk/q88Pb0T3tcnTleV0ITYaMKHquKDpsnjjo9lig3RYQOXy
   2p0NbxVevDWaDY7UUbzFGtuQBUstEPGIJyDhQCgRb+gSwpxSgGxePhN2Q
   VtXGgIjFYozACKTRH5m4ZqpIHRsIVWD2U+d0+H3m+VW51GCkTZhnPTvxj
   A==;
IronPort-SDR: Y1Rv3pCzkYN5ZGX4163RWH41k5fwBm5g3P1IcZtx+wV+HbhH67dltqQ+zmVDFb5CerN8NZ+B7k
 NgX8Pyjw9OHNdIS7UlaFmwGc+D7sUZbpJuVOZ1oJw5m9IUYGt9JeLk47zmfBQblhUvTI0W25wo
 Jgllu4cOsQKn9DxY5Obv/7BN9fbNKPmcEw/JaH/Kp4pJm9NLPm772AUp8WzEE/kAMrN+v3XvRI
 SgplNvQk6Ws/UwgVl7jgmb1uOB1dLkIsjzHiTt9ym7KntjXqW5UaoXBTp4H2I0eXpxaDl76Drv
 yPs=
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="131168278"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 11:57:01 +0800
IronPort-SDR: j2OlMM/NaZClB6ZcQt50LkjdpTO7ooGDJ8usTWGOLNPB2Ms3XdYE/ZmRutMCF8lXCkDvftPlLF
 6kU8Rac2uKKLDl7OTL7vyWQR7uyIFi6u/lIubQG+qz4M85gbUQcvUF9c6+8cqmTIS4yWaiRuAH
 7GsnDqCnXBSBOyr5wbVZd4n9Pfbch/ob1YsWVBJN+DJGCW6UkWha/L+nSBevD+Q+7orYxeIuQn
 nbwf3YPzREJ8OWAqFqB2Y0iVcjVl02XXv40dnsYfhtxaZNkrJGUPVEL94Qyrbe4ppVR3zdSXAz
 cTw3riOGHsvVxvqXdnrhPjw5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 19:49:30 -0800
IronPort-SDR: a+28elkjtYJa04Y7IRuD4Nu2a6CL7VFLC/yLvyh+B3Yefdov1RFx9rqQi/y7ekp3CsW+t1RqOI
 vRsjp6vI1lVbI11XlqDITzKjHpDqIpOxNR5cd+JyCetKjH8AHW0PdyTLBezgXnaMIs3bYZE1n0
 g2sP2ghxKBn5VKB8xaJbrfTkxXu75dsDdBZuG4GfRv/W4AguG9Ubucs4l9CwOzlhrYYqr0Hfd3
 jvVbujTvJyd03GV4enTY9SUw19e8/x7pc4R0vcVk2nYz+tlXlLSwpXo34aK4xwqWbI7LSsITCA
 2N8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Feb 2020 19:57:01 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 05/21] btrfs: introduce alloc_chunk_ctl
Date:   Tue, 25 Feb 2020 12:56:10 +0900
Message-Id: <20200225035626.1049501-6-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225035626.1049501-1-naohiro.aota@wdc.com>
References: <20200225035626.1049501-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce "struct alloc_chunk_ctl" to wrap needed parameters for the chunk
allocation.  This will be used to split __btrfs_alloc_chunk() into smaller
functions.

This commit folds a number of local variables in __btrfs_alloc_chunk() into
one "struct alloc_chunk_ctl ctl". There is no functional change.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 151 ++++++++++++++++++++++++++-------------------
 1 file changed, 86 insertions(+), 65 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5f4e875a42f6..ed90e9d2bd9b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4818,6 +4818,29 @@ static void check_raid1c34_incompat_flag(struct btrfs_fs_info *info, u64 type)
 	btrfs_set_fs_incompat(info, RAID1C34);
 }
 
+/*
+ * Structure used internally for __btrfs_alloc_chunk() function.
+ * Wraps needed parameters.
+ */
+struct alloc_chunk_ctl {
+	u64 start;
+	u64 type;
+	int num_stripes;	/* total number of stripes to allocate */
+	int sub_stripes;	/* sub_stripes info for map */
+	int dev_stripes;	/* stripes per dev */
+	int devs_max;		/* max devs to use */
+	int devs_min;		/* min devs needed */
+	int devs_increment;	/* ndevs has to be a multiple of this */
+	int ncopies;		/* how many copies to data has */
+	int nparity;		/* number of stripes worth of bytes to
+				   store parity information */
+	u64 max_stripe_size;
+	u64 max_chunk_size;
+	u64 stripe_size;
+	u64 chunk_size;
+	int ndevs;
+};
+
 static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 			       u64 start, u64 type)
 {
@@ -4828,23 +4851,11 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	struct extent_map_tree *em_tree;
 	struct extent_map *em;
 	struct btrfs_device_info *devices_info = NULL;
+	struct alloc_chunk_ctl ctl;
 	u64 total_avail;
-	int num_stripes;	/* total number of stripes to allocate */
 	int data_stripes;	/* number of stripes that count for
 				   block group size */
-	int sub_stripes;	/* sub_stripes info for map */
-	int dev_stripes;	/* stripes per dev */
-	int devs_max;		/* max devs to use */
-	int devs_min;		/* min devs needed */
-	int devs_increment;	/* ndevs has to be a multiple of this */
-	int ncopies;		/* how many copies to data has */
-	int nparity;		/* number of stripes worth of bytes to
-				   store parity information */
 	int ret;
-	u64 max_stripe_size;
-	u64 max_chunk_size;
-	u64 stripe_size;
-	u64 chunk_size;
 	int ndevs;
 	int i;
 	int j;
@@ -4861,32 +4872,36 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		return -ENOSPC;
 	}
 
+	ctl.start = start;
+	ctl.type = type;
+
 	index = btrfs_bg_flags_to_raid_index(type);
 
-	sub_stripes = btrfs_raid_array[index].sub_stripes;
-	dev_stripes = btrfs_raid_array[index].dev_stripes;
-	devs_max = btrfs_raid_array[index].devs_max;
-	if (!devs_max)
-		devs_max = BTRFS_MAX_DEVS(info);
-	devs_min = btrfs_raid_array[index].devs_min;
-	devs_increment = btrfs_raid_array[index].devs_increment;
-	ncopies = btrfs_raid_array[index].ncopies;
-	nparity = btrfs_raid_array[index].nparity;
+	ctl.sub_stripes = btrfs_raid_array[index].sub_stripes;
+	ctl.dev_stripes = btrfs_raid_array[index].dev_stripes;
+	ctl.devs_max = btrfs_raid_array[index].devs_max;
+	if (!ctl.devs_max)
+		ctl.devs_max = BTRFS_MAX_DEVS(info);
+	ctl.devs_min = btrfs_raid_array[index].devs_min;
+	ctl.devs_increment = btrfs_raid_array[index].devs_increment;
+	ctl.ncopies = btrfs_raid_array[index].ncopies;
+	ctl.nparity = btrfs_raid_array[index].nparity;
 
 	if (type & BTRFS_BLOCK_GROUP_DATA) {
-		max_stripe_size = SZ_1G;
-		max_chunk_size = BTRFS_MAX_DATA_CHUNK_SIZE;
+		ctl.max_stripe_size = SZ_1G;
+		ctl.max_chunk_size = BTRFS_MAX_DATA_CHUNK_SIZE;
 	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
 		/* for larger filesystems, use larger metadata chunks */
 		if (fs_devices->total_rw_bytes > 50ULL * SZ_1G)
-			max_stripe_size = SZ_1G;
+			ctl.max_stripe_size = SZ_1G;
 		else
-			max_stripe_size = SZ_256M;
-		max_chunk_size = max_stripe_size;
+			ctl.max_stripe_size = SZ_256M;
+		ctl.max_chunk_size = ctl.max_stripe_size;
 	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
-		max_stripe_size = SZ_32M;
-		max_chunk_size = 2 * max_stripe_size;
-		devs_max = min_t(int, devs_max, BTRFS_MAX_DEVS_SYS_CHUNK);
+		ctl.max_stripe_size = SZ_32M;
+		ctl.max_chunk_size = 2 * ctl.max_stripe_size;
+		ctl.devs_max = min_t(int, ctl.devs_max,
+				      BTRFS_MAX_DEVS_SYS_CHUNK);
 	} else {
 		btrfs_err(info, "invalid chunk type 0x%llx requested",
 		       type);
@@ -4894,8 +4909,8 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	}
 
 	/* We don't want a chunk larger than 10% of writable space */
-	max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
-			     max_chunk_size);
+	ctl.max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
+				  ctl.max_chunk_size);
 
 	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
 			       GFP_NOFS);
@@ -4931,21 +4946,21 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		if (total_avail == 0)
 			continue;
 
-		ret = find_free_dev_extent(device,
-					   max_stripe_size * dev_stripes,
-					   &dev_offset, &max_avail);
+		ret = find_free_dev_extent(
+			device, ctl.max_stripe_size * ctl.dev_stripes,
+			&dev_offset, &max_avail);
 		if (ret && ret != -ENOSPC)
 			goto error;
 
 		if (ret == 0)
-			max_avail = max_stripe_size * dev_stripes;
+			max_avail = ctl.max_stripe_size * ctl.dev_stripes;
 
-		if (max_avail < BTRFS_STRIPE_LEN * dev_stripes) {
+		if (max_avail < BTRFS_STRIPE_LEN * ctl.dev_stripes) {
 			if (btrfs_test_opt(info, ENOSPC_DEBUG))
 				btrfs_debug(info,
 			"%s: devid %llu has no free space, have=%llu want=%u",
 					    __func__, device->devid, max_avail,
-					    BTRFS_STRIPE_LEN * dev_stripes);
+					    BTRFS_STRIPE_LEN * ctl.dev_stripes);
 			continue;
 		}
 
@@ -4960,30 +4975,31 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		devices_info[ndevs].dev = device;
 		++ndevs;
 	}
+	ctl.ndevs = ndevs;
 
 	/*
 	 * now sort the devices by hole size / available space
 	 */
-	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
+	sort(devices_info, ctl.ndevs, sizeof(struct btrfs_device_info),
 	     btrfs_cmp_device_info, NULL);
 
 	/*
 	 * Round down to number of usable stripes, devs_increment can be any
 	 * number so we can't use round_down()
 	 */
-	ndevs -= ndevs % devs_increment;
+	ctl.ndevs -= ctl.ndevs % ctl.devs_increment;
 
-	if (ndevs < devs_min) {
+	if (ctl.ndevs < ctl.devs_min) {
 		ret = -ENOSPC;
 		if (btrfs_test_opt(info, ENOSPC_DEBUG)) {
 			btrfs_debug(info,
 	"%s: not enough devices with free space: have=%d minimum required=%d",
-				    __func__, ndevs, devs_min);
+				    __func__, ctl.ndevs, ctl.devs_min);
 		}
 		goto error;
 	}
 
-	ndevs = min(ndevs, devs_max);
+	ctl.ndevs = min(ctl.ndevs, ctl.devs_max);
 
 	/*
 	 * The primary goal is to maximize the number of stripes, so use as
@@ -4992,14 +5008,15 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	 * The DUP profile stores more than one stripe per device, the
 	 * max_avail is the total size so we have to adjust.
 	 */
-	stripe_size = div_u64(devices_info[ndevs - 1].max_avail, dev_stripes);
-	num_stripes = ndevs * dev_stripes;
+	ctl.stripe_size = div_u64(devices_info[ctl.ndevs - 1].max_avail,
+				   ctl.dev_stripes);
+	ctl.num_stripes = ctl.ndevs * ctl.dev_stripes;
 
 	/*
 	 * this will have to be fixed for RAID1 and RAID10 over
 	 * more drives
 	 */
-	data_stripes = (num_stripes - nparity) / ncopies;
+	data_stripes = (ctl.num_stripes - ctl.nparity) / ctl.ncopies;
 
 	/*
 	 * Use the number of data stripes to figure out how big this chunk
@@ -5007,44 +5024,46 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	 * and compare that answer with the max chunk size. If it's higher,
 	 * we try to reduce stripe_size.
 	 */
-	if (stripe_size * data_stripes > max_chunk_size) {
+	if (ctl.stripe_size * data_stripes > ctl.max_chunk_size) {
 		/*
 		 * Reduce stripe_size, round it up to a 16MB boundary again and
 		 * then use it, unless it ends up being even bigger than the
 		 * previous value we had already.
 		 */
-		stripe_size = min(round_up(div_u64(max_chunk_size,
-						   data_stripes), SZ_16M),
-				  stripe_size);
+		ctl.stripe_size =
+			min(round_up(div_u64(ctl.max_chunk_size, data_stripes),
+				     SZ_16M),
+			    ctl.stripe_size);
 	}
 
 	/* align to BTRFS_STRIPE_LEN */
-	stripe_size = round_down(stripe_size, BTRFS_STRIPE_LEN);
+	ctl.stripe_size = round_down(ctl.stripe_size, BTRFS_STRIPE_LEN);
 
-	map = kmalloc(map_lookup_size(num_stripes), GFP_NOFS);
+	map = kmalloc(map_lookup_size(ctl.num_stripes), GFP_NOFS);
 	if (!map) {
 		ret = -ENOMEM;
 		goto error;
 	}
-	map->num_stripes = num_stripes;
 
-	for (i = 0; i < ndevs; ++i) {
-		for (j = 0; j < dev_stripes; ++j) {
-			int s = i * dev_stripes + j;
+	map->num_stripes = ctl.num_stripes;
+
+	for (i = 0; i < ctl.ndevs; ++i) {
+		for (j = 0; j < ctl.dev_stripes; ++j) {
+			int s = i * ctl.dev_stripes + j;
 			map->stripes[s].dev = devices_info[i].dev;
 			map->stripes[s].physical = devices_info[i].dev_offset +
-						   j * stripe_size;
+						   j * ctl.stripe_size;
 		}
 	}
 	map->stripe_len = BTRFS_STRIPE_LEN;
 	map->io_align = BTRFS_STRIPE_LEN;
 	map->io_width = BTRFS_STRIPE_LEN;
 	map->type = type;
-	map->sub_stripes = sub_stripes;
+	map->sub_stripes = ctl.sub_stripes;
 
-	chunk_size = stripe_size * data_stripes;
+	ctl.chunk_size = ctl.stripe_size * data_stripes;
 
-	trace_btrfs_chunk_alloc(info, map, start, chunk_size);
+	trace_btrfs_chunk_alloc(info, map, start, ctl.chunk_size);
 
 	em = alloc_extent_map();
 	if (!em) {
@@ -5055,10 +5074,10 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	set_bit(EXTENT_FLAG_FS_MAPPING, &em->flags);
 	em->map_lookup = map;
 	em->start = start;
-	em->len = chunk_size;
+	em->len = ctl.chunk_size;
 	em->block_start = 0;
 	em->block_len = em->len;
-	em->orig_block_len = stripe_size;
+	em->orig_block_len = ctl.stripe_size;
 
 	em_tree = &info->mapping_tree;
 	write_lock(&em_tree->lock);
@@ -5070,20 +5089,22 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	}
 	write_unlock(&em_tree->lock);
 
-	ret = btrfs_make_block_group(trans, 0, type, start, chunk_size);
+	ret = btrfs_make_block_group(trans, 0, type, start, ctl.chunk_size);
 	if (ret)
 		goto error_del_extent;
 
 	for (i = 0; i < map->num_stripes; i++) {
 		struct btrfs_device *dev = map->stripes[i].dev;
 
-		btrfs_device_set_bytes_used(dev, dev->bytes_used + stripe_size);
+		btrfs_device_set_bytes_used(dev,
+					    dev->bytes_used + ctl.stripe_size);
 		if (list_empty(&dev->post_commit_list))
 			list_add_tail(&dev->post_commit_list,
 				      &trans->transaction->dev_update_list);
 	}
 
-	atomic64_sub(stripe_size * map->num_stripes, &info->free_chunk_space);
+	atomic64_sub(ctl.stripe_size * map->num_stripes,
+		     &info->free_chunk_space);
 
 	free_extent_map(em);
 	check_raid56_incompat_flag(info, type);
-- 
2.25.1

