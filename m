Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF4C354E44
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 10:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbhDFIHn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 04:07:43 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:34748 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbhDFIHm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Apr 2021 04:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617696455; x=1649232455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t8mxuPUK4bxWp9SYu2R2wa8HLwqik3UtNUQGW6gRmz8=;
  b=GvSR8246q++weFoflj4ZHRNFKkMHorYb6cztrhTwtXp2Bx3cQ6O+T4Fo
   uLzwE+CDgkzt90ld5VKQPLumzoH+XjGXsIpsE4e4uA5xGnSJHYqp3cZk1
   TjGL3u4ajHyuXRs6C21DfHx098pEGmtjNjtcYsMsvsIqZu8KhE324zbqa
   irQ1ALHqkTnrcoanfl8jsfm5fBGy+wKhLhovLMsZzhRXw3YcjyDMf/ul1
   p6Mu3/puZkLALGvUXDZjIVXz1l2MdXw+Ah4GyUiTqr4MlkMU7FGkfN32I
   AMfnb8ZMF3MYp8pz4E2P1RL626HlIk8BNnUs/jNO4MdeBTfJokFVQu3a/
   w==;
IronPort-SDR: 8sBIBKJ3VjGlDCvuBeys3vvcuNumIJsmqLWnnZ8VeYbI47od47POeVdUGyAO2RuikvtMWDJmAN
 DON9v92d5k7w6kXcZy4DNRVNX20Wcpm/SFQD9biWrcotr3ZqSiFBbMi7eR3O9kqtKIhK+ZORnV
 o+e6AA+HXf2wyGjWmqr0aKXbnPn3DMPuwEzXV5jsB39SEubuoz5BKyOCmB2sxGya3bSDyZhhw3
 2U4nerWBytOAHAbwP7grorvlCToI6IJ41YWEu10d1OMRevP8D83CgMw6noRrUV85L61shS2hAx
 +j8=
X-IronPort-AV: E=Sophos;i="5.81,308,1610380800"; 
   d="scan'208";a="163733727"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2021 16:07:25 +0800
IronPort-SDR: cACb7gHtw8WkkIYRxaUOj28ZY1R0LEM9imP+63XiEOA6hCQV2t2VEVfxMIqtIgRL5ubZPx7vBc
 bn3i2bAZ9UJjDGQ7YqU+rRPtAC1Oa8OXfqy1mgSmKgHt7MjnenWp9OytLfeEtLS/0efR/QyDkC
 P3ZtzjmgKRT1bakj8to8ljbKd+xXt3wI2RRudX3xUupeLDnp1E5tJqWBPpTkdwEktdbSNTQllh
 YidqkzD0wugmzoOVPWA3IYli6iP4IRUHLnJwSfnDSAKufYY0eFDyosf/sByrGGXCnCuHSFjykA
 SGnr2FgnTeIHiB/zlWUnup4v
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 00:48:23 -0700
IronPort-SDR: kSvnO/QYNU1+h7T0JxOxHx9xas18TjToF8Hj74ASd6SKrlhclwXG3VVSmdFxK89v2xJH38xm69
 FgSE5V/xP3uDx0GunUJ8qN/muihbF1r3ojTKovuRC8QG9/rXdvXzOtXUF8+zKBLb8cwWlQPIC5
 Zk88lwpVhERTBlj8JMFpYchppqNtIREsqnYQFplRW/7ccggD0nmYnHHdGpbAZmkIf0rEH9+ESi
 5u6+Q930Ru+J7/bCkq+lIhmwQI4WJXNsx80dRvW5V2KNTe7qYmukPNy/knVbSz+NLmIrNSLIcc
 O50=
WDCIronportException: Internal
Received: from 5pgg7h2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.29])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Apr 2021 01:06:58 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 04/12] btrfs-progs: consolidate parameter initialization of regular allocator
Date:   Tue,  6 Apr 2021 17:05:46 +0900
Message-Id: <0639b2958d564920fa4d37959586780808a4c0c2.1617694997.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617694997.git.naohiro.aota@wdc.com>
References: <cover.1617694997.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Move parameter initialization code for regular allocator to
init_alloc_chunk_ctl_policy_regular(). This will help adding another
allocator in the future.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/volumes.c | 112 +++++++++++++++++++++++-----------------
 1 file changed, 64 insertions(+), 48 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index ea14a9413157..1ca71a9bc430 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -154,6 +154,9 @@ struct alloc_chunk_ctl {
 	int max_stripes;
 	int min_stripes;
 	int sub_stripes;
+	u64 calc_size;
+	u64 min_stripe_size;
+	u64 max_chunk_size;
 	int stripe_len;
 	int total_devs;
 };
@@ -1005,6 +1008,40 @@ error:
 				- 2 * sizeof(struct btrfs_chunk))	\
 				/ sizeof(struct btrfs_stripe) + 1)
 
+static void init_alloc_chunk_ctl_policy_regular(struct btrfs_fs_info *info,
+						struct alloc_chunk_ctl *ctl)
+{
+	u64 type = ctl->type;
+	u64 percent_max;
+
+	if (type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
+		if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
+			ctl->calc_size = SZ_8M;
+			ctl->max_chunk_size = ctl->calc_size * 2;
+			ctl->min_stripe_size = SZ_1M;
+			ctl->max_stripes = BTRFS_MAX_DEVS_SYS_CHUNK;
+		} else if (type & BTRFS_BLOCK_GROUP_DATA) {
+			ctl->calc_size = SZ_1G;
+			ctl->max_chunk_size = 10 * ctl->calc_size;
+			ctl->min_stripe_size = SZ_64M;
+			ctl->max_stripes = BTRFS_MAX_DEVS(info);
+		} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
+			/* for larger filesystems, use larger metadata chunks */
+			if (info->fs_devices->total_rw_bytes > 50ULL * SZ_1G)
+				ctl->max_chunk_size = SZ_1G;
+			else
+				ctl->max_chunk_size = SZ_256M;
+			ctl->calc_size = ctl->max_chunk_size;
+			ctl->min_stripe_size = SZ_32M;
+			ctl->max_stripes = BTRFS_MAX_DEVS(info);
+		}
+	}
+
+	/* we don't want a chunk larger than 10% of the FS */
+	percent_max = div_factor(btrfs_super_total_bytes(info->super_copy), 1);
+	ctl->max_chunk_size = min(percent_max, ctl->max_chunk_size);
+}
+
 static void init_alloc_chunk_ctl(struct btrfs_fs_info *info,
 				 struct alloc_chunk_ctl *ctl)
 {
@@ -1012,8 +1049,21 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_info *info,
 
 	ctl->num_stripes = btrfs_raid_array[type].dev_stripes;
 	ctl->min_stripes = btrfs_raid_array[type].devs_min;
+	ctl->max_stripes = 0;
 	ctl->sub_stripes = btrfs_raid_array[type].sub_stripes;
+	ctl->calc_size = SZ_8M;
+	ctl->min_stripe_size = SZ_1M;
+	ctl->max_chunk_size = 4 * ctl->calc_size;
 	ctl->stripe_len = BTRFS_STRIPE_LEN;
+	ctl->total_devs = btrfs_super_num_devices(info->super_copy);
+
+	switch (info->fs_devices->chunk_alloc_policy) {
+	case BTRFS_CHUNK_ALLOC_REGULAR:
+		init_alloc_chunk_ctl_policy_regular(info, ctl);
+		break;
+	default:
+		BUG();
+	}
 
 	switch (type) {
 	case BTRFS_RAID_DUP:
@@ -1051,13 +1101,9 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	struct list_head *dev_list = &info->fs_devices->devices;
 	struct list_head *cur;
 	struct map_lookup *map;
-	int min_stripe_size = SZ_1M;
-	u64 calc_size = SZ_8M;
 	u64 min_free;
-	u64 max_chunk_size = 4 * calc_size;
 	u64 avail = 0;
 	u64 max_avail = 0;
-	u64 percent_max;
 	struct alloc_chunk_ctl ctl;
 	int looped = 0;
 	int ret;
@@ -1070,60 +1116,30 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	}
 
 	ctl.type = type;
-	ctl.max_stripes = 0;
-	ctl.total_devs = btrfs_super_num_devices(info->super_copy);
-
-	if (type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
-		if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
-			calc_size = SZ_8M;
-			max_chunk_size = calc_size * 2;
-			min_stripe_size = SZ_1M;
-			ctl.max_stripes = BTRFS_MAX_DEVS_SYS_CHUNK;
-		} else if (type & BTRFS_BLOCK_GROUP_DATA) {
-			calc_size = SZ_1G;
-			max_chunk_size = 10 * calc_size;
-			min_stripe_size = SZ_64M;
-			ctl.max_stripes = BTRFS_MAX_DEVS(info);
-		} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
-			/* for larger filesystems, use larger metadata chunks */
-			if (info->fs_devices->total_rw_bytes > 50ULL * SZ_1G)
-				max_chunk_size = SZ_1G;
-			else
-				max_chunk_size = SZ_256M;
-			calc_size = max_chunk_size;
-			min_stripe_size = SZ_32M;
-			ctl.max_stripes = BTRFS_MAX_DEVS(info);
-		}
-	}
-
 	init_alloc_chunk_ctl(info, &ctl);
 	if (ctl.num_stripes < ctl.min_stripes)
 		return -ENOSPC;
 
-	/* we don't want a chunk larger than 10% of the FS */
-	percent_max = div_factor(btrfs_super_total_bytes(info->super_copy), 1);
-	max_chunk_size = min(percent_max, max_chunk_size);
-
 again:
-	if (chunk_bytes_by_type(type, calc_size, &ctl) > max_chunk_size) {
-		calc_size = max_chunk_size;
-		calc_size /= ctl.num_stripes;
-		calc_size /= ctl.stripe_len;
-		calc_size *= ctl.stripe_len;
+	if (chunk_bytes_by_type(type, ctl.calc_size, &ctl) > ctl.max_chunk_size) {
+		ctl.calc_size = ctl.max_chunk_size;
+		ctl.calc_size /= ctl.num_stripes;
+		ctl.calc_size /= ctl.stripe_len;
+		ctl.calc_size *= ctl.stripe_len;
 	}
 	/* we don't want tiny stripes */
-	calc_size = max_t(u64, calc_size, min_stripe_size);
+	ctl.calc_size = max_t(u64, ctl.calc_size, ctl.min_stripe_size);
 
-	calc_size /= ctl.stripe_len;
-	calc_size *= ctl.stripe_len;
+	ctl.calc_size /= ctl.stripe_len;
+	ctl.calc_size *= ctl.stripe_len;
 	INIT_LIST_HEAD(&private_devs);
 	cur = dev_list->next;
 	index = 0;
 
 	if (type & BTRFS_BLOCK_GROUP_DUP)
-		min_free = calc_size * 2;
+		min_free = ctl.calc_size * 2;
 	else
-		min_free = calc_size;
+		min_free = ctl.calc_size;
 
 	/* build a private list of devices we will allocate from */
 	while(index < ctl.num_stripes) {
@@ -1155,7 +1171,7 @@ again:
 		}
 		if (!looped && max_avail > 0) {
 			looped = 1;
-			calc_size = max_avail;
+			ctl.calc_size = max_avail;
 			goto again;
 		}
 		return -ENOSPC;
@@ -1178,7 +1194,7 @@ again:
 	}
 
 	stripes = &chunk->stripe;
-	*num_bytes = chunk_bytes_by_type(type, calc_size, &ctl);
+	*num_bytes = chunk_bytes_by_type(type, ctl.calc_size, &ctl);
 	index = 0;
 	while(index < ctl.num_stripes) {
 		struct btrfs_stripe *stripe;
@@ -1192,11 +1208,11 @@ again:
 			list_move(&device->dev_list, dev_list);
 
 		ret = btrfs_alloc_dev_extent(trans, device, key.offset,
-			     calc_size, &dev_offset);
+			     ctl.calc_size, &dev_offset);
 		if (ret < 0)
 			goto out_chunk_map;
 
-		device->bytes_used += calc_size;
+		device->bytes_used += ctl.calc_size;
 		ret = btrfs_update_device(trans, device);
 		if (ret < 0)
 			goto out_chunk_map;
-- 
2.31.1

