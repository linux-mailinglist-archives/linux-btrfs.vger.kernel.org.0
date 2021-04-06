Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5E8354E4E
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 10:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239982AbhDFIIi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 04:08:38 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:26861 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbhDFIIi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Apr 2021 04:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617696522; x=1649232522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L/blqibO+TuU9qcmt+0D/6AYl3qQRV+N08VxkKnA5ko=;
  b=P2bRFkuFFoWFGS8CO6eLOAK8QV0b0Os2Uf/mPYKSGNtf4KI0JAHJcg4Z
   F/Q7F0E7eC+ZtDhzq7gBRSvtPVr6NEjlKx03Unwm6CouRCyIFK7+OxvO8
   xo5npTz4zvXii9o7nOqTG0zKppAtLnXVE1cYDje9XKt1JT/QZ6Ecxh6Z8
   6YMKZOY69BDdD+TSa4oxmWPWZYuXRCs59NW5TUxDBmxN1zW8+YmcCVF4l
   UHgS1AJED1vwdpeBKsJJurvbGrJamJMBz0ss9DStht+7D/Yj2n0yRQoeo
   Zw4FWLz9WrMtXbkNlA/baP64NwyV+o364sDOJvhUHApqTrj3KAEhmXVq6
   w==;
IronPort-SDR: TOq9zeH44QF1iscQ4X5uuhL9pI63q2AH/ZMS1E9Zky8FBKB43441FFBw6uwGPoe6dHH79uh02V
 LXR1dd+e8MuN7E3UlyfxZGGmgMV1gZbPKymL3yJT2vTBnt9alKlZSsT0YVz7bh1slcQajz7LG/
 u4fKCgeAqYn7mDU7C8aU9riff2YXDioCCSDZyGKZDJDMV2lwIanoz/rsv6qBHoLV9lzIBicLRC
 IuLesoXk5sCV7POtq+9vVpNRtpNVnKcb8MhUyDTIwQk6QoFPFdyaguu/c9ZbBbvLD72I1vdmPu
 mAQ=
X-IronPort-AV: E=Sophos;i="5.81,308,1610380800"; 
   d="scan'208";a="268290743"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2021 16:08:28 +0800
IronPort-SDR: qDg6YDBpvju7Vr84snntPCzZj79jNrRsVDbbYqeknrMV5x+2+yev7WxCIjX7aHeYfWZ9pAKzHy
 0gvPLUoKowX4wajdfQB2HaRnYAmykYOX/ek80w0ueNUCNd89uKkUJwaSsn2AsYAFyZGfGI4nNM
 4aSAbYOlZ8+pIV5/cdrxTutRYgMLdAjsLJI+oLf2o7pHHgjShxdChuQQ2UFfvgv3YYtCrqkcUj
 SOdWMMHQHEi62m7KZP3OX+sMCWZn3cAlocc/E8jFGca0SUWZK4Z/DAuJKOKr2tsOp+7SsSCI44
 NHumK5D+pZIopdmBGHMO9XRW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 00:48:31 -0700
IronPort-SDR: RZxPnAcsz1mkpoQFl1vRcIMoq4saAs9dbIKRKo4ROZybipFX22lrRQQvNtLEYeIL7UWeSYO3qL
 DplGxI1hbDPcGAGZ2XK7j2J75O1F2/Q72RIVI4qv74PQQVN5uwhPynYvtkFZkP7JpbDBSaGdrx
 60pThjm2ViBOrVTu6R5J2VOlGdf30c7G5XmKLdOLA8+wVB8xsAhhmSs4YJJA5bAnZZQRJdYdJZ
 ajyclELAsFxgToUM34tWfPTpzucsFRGQi6mmjuU0bfzlaxjsftFVvQnRxC1Txgcv0oOBedjYG2
 YRk=
WDCIronportException: Internal
Received: from 5pgg7h2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.29])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Apr 2021 01:07:06 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 12/12] btrfs-progs: rename calc_size to stripe_size
Date:   Tue,  6 Apr 2021 17:05:54 +0900
Message-Id: <b900f2f09eef7e7b7f0decf1ee408eed63946280.1617694997.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617694997.git.naohiro.aota@wdc.com>
References: <cover.1617694997.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

alloc_chunk_ctl::calc_size is actually the stripe_size in the kernel side
code.  Let's rename it to clarify what the "calc" is.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/volumes.c | 56 ++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index d4ef5d626f12..f7dd879398d4 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -155,7 +155,7 @@ struct alloc_chunk_ctl {
 	int max_stripes;
 	int min_stripes;
 	int sub_stripes;
-	u64 calc_size;
+	u64 stripe_size;
 	u64 min_stripe_size;
 	u64 num_bytes;
 	u64 max_chunk_size;
@@ -900,20 +900,20 @@ int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
 static u64 chunk_bytes_by_type(struct alloc_chunk_ctl *ctl)
 {
 	u64 type = ctl->type;
-	u64 calc_size = ctl->calc_size;
+	u64 stripe_size = ctl->stripe_size;
 
 	if (type & (BTRFS_BLOCK_GROUP_RAID1 | BTRFS_BLOCK_GROUP_DUP))
-		return calc_size;
+		return stripe_size;
 	else if (type & (BTRFS_BLOCK_GROUP_RAID1C3 | BTRFS_BLOCK_GROUP_RAID1C4))
-		return calc_size;
+		return stripe_size;
 	else if (type & BTRFS_BLOCK_GROUP_RAID10)
-		return calc_size * (ctl->num_stripes / ctl->sub_stripes);
+		return stripe_size * (ctl->num_stripes / ctl->sub_stripes);
 	else if (type & BTRFS_BLOCK_GROUP_RAID5)
-		return calc_size * (ctl->num_stripes - 1);
+		return stripe_size * (ctl->num_stripes - 1);
 	else if (type & BTRFS_BLOCK_GROUP_RAID6)
-		return calc_size * (ctl->num_stripes - 2);
+		return stripe_size * (ctl->num_stripes - 2);
 	else
-		return calc_size * ctl->num_stripes;
+		return stripe_size * ctl->num_stripes;
 }
 
 /*
@@ -1020,13 +1020,13 @@ static void init_alloc_chunk_ctl_policy_regular(struct btrfs_fs_info *info,
 
 	if (type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
 		if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
-			ctl->calc_size = SZ_8M;
-			ctl->max_chunk_size = ctl->calc_size * 2;
+			ctl->stripe_size = SZ_8M;
+			ctl->max_chunk_size = ctl->stripe_size * 2;
 			ctl->min_stripe_size = SZ_1M;
 			ctl->max_stripes = BTRFS_MAX_DEVS_SYS_CHUNK;
 		} else if (type & BTRFS_BLOCK_GROUP_DATA) {
-			ctl->calc_size = SZ_1G;
-			ctl->max_chunk_size = 10 * ctl->calc_size;
+			ctl->stripe_size = SZ_1G;
+			ctl->max_chunk_size = 10 * ctl->stripe_size;
 			ctl->min_stripe_size = SZ_64M;
 			ctl->max_stripes = BTRFS_MAX_DEVS(info);
 		} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
@@ -1035,7 +1035,7 @@ static void init_alloc_chunk_ctl_policy_regular(struct btrfs_fs_info *info,
 				ctl->max_chunk_size = SZ_1G;
 			else
 				ctl->max_chunk_size = SZ_256M;
-			ctl->calc_size = ctl->max_chunk_size;
+			ctl->stripe_size = ctl->max_chunk_size;
 			ctl->min_stripe_size = SZ_32M;
 			ctl->max_stripes = BTRFS_MAX_DEVS(info);
 		}
@@ -1055,9 +1055,9 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_info *info,
 	ctl->min_stripes = btrfs_raid_array[type].devs_min;
 	ctl->max_stripes = 0;
 	ctl->sub_stripes = btrfs_raid_array[type].sub_stripes;
-	ctl->calc_size = SZ_8M;
+	ctl->stripe_size = SZ_8M;
 	ctl->min_stripe_size = SZ_1M;
-	ctl->max_chunk_size = 4 * ctl->calc_size;
+	ctl->max_chunk_size = 4 * ctl->stripe_size;
 	ctl->total_devs = btrfs_super_num_devices(info->super_copy);
 	ctl->dev_offset = 0;
 
@@ -1094,15 +1094,15 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_info *info,
 static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl)
 {
 	if (chunk_bytes_by_type(ctl) > ctl->max_chunk_size) {
-		ctl->calc_size = ctl->max_chunk_size;
-		ctl->calc_size /= ctl->num_stripes;
-		ctl->calc_size = round_down(ctl->calc_size, BTRFS_STRIPE_LEN);
+		ctl->stripe_size = ctl->max_chunk_size;
+		ctl->stripe_size /= ctl->num_stripes;
+		ctl->stripe_size = round_down(ctl->stripe_size, BTRFS_STRIPE_LEN);
 	}
 	/* we don't want tiny stripes */
-	ctl->calc_size = max_t(u64, ctl->calc_size, ctl->min_stripe_size);
+	ctl->stripe_size = max_t(u64, ctl->stripe_size, ctl->min_stripe_size);
 
 	/* Align to the stripe length */
-	ctl->calc_size = round_down(ctl->calc_size, BTRFS_STRIPE_LEN);
+	ctl->stripe_size = round_down(ctl->stripe_size, BTRFS_STRIPE_LEN);
 
 	return 0;
 }
@@ -1175,18 +1175,18 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 
 		if (!ctl->dev_offset) {
 			ret = btrfs_alloc_dev_extent(trans, device, key.offset,
-				ctl->calc_size, &dev_offset);
+				ctl->stripe_size, &dev_offset);
 			if (ret < 0)
 				goto out_chunk_map;
 		} else {
 			dev_offset = ctl->dev_offset;
 			ret = btrfs_insert_dev_extent(trans, device, key.offset,
-						      ctl->calc_size,
+						      ctl->stripe_size,
 						      ctl->dev_offset);
 			BUG_ON(ret);
 		}
 
-		device->bytes_used += ctl->calc_size;
+		device->bytes_used += ctl->stripe_size;
 		ret = btrfs_update_device(trans, device);
 		if (ret < 0)
 			goto out_chunk_map;
@@ -1285,9 +1285,9 @@ again:
 	index = 0;
 
 	if (type & BTRFS_BLOCK_GROUP_DUP)
-		min_free = ctl.calc_size * 2;
+		min_free = ctl.stripe_size * 2;
 	else
-		min_free = ctl.calc_size;
+		min_free = ctl.stripe_size;
 
 	/* build a private list of devices we will allocate from */
 	while (index < ctl.num_stripes) {
@@ -1322,9 +1322,9 @@ again:
 		if (!looped && max_avail > 0) {
 			looped = 1;
 			if (ctl.type & BTRFS_BLOCK_GROUP_DUP)
-				ctl.calc_size = max_avail / 2;
+				ctl.stripe_size = max_avail / 2;
 			else
-				ctl.calc_size = max_avail;
+				ctl.stripe_size = max_avail;
 			goto again;
 		}
 		return -ENOSPC;
@@ -1363,7 +1363,7 @@ int btrfs_alloc_data_chunk(struct btrfs_trans_handle *trans,
 	ctl.max_stripes = 1;
 	ctl.min_stripes = 1;
 	ctl.sub_stripes = 1;
-	ctl.calc_size = num_bytes;
+	ctl.stripe_size = num_bytes;
 	ctl.min_stripe_size = num_bytes;
 	ctl.num_bytes = num_bytes;
 	ctl.max_chunk_size = num_bytes;
-- 
2.31.1

