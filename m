Return-Path: <linux-btrfs+bounces-11554-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 129B2A3B2EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 08:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76383B0583
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 07:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E982C1C5D5A;
	Wed, 19 Feb 2025 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oLubzzP8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8A61C5D44
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951900; cv=none; b=fYhrZZZSdobVi4IUKqsFCQn7vKG5TDUu+aN483E5F2z3Khw5CnoCqiYAi3A2k/OVJlR1LoZVbj0XhiRcmza7kOczGTkTjYDOR589nP485ay0Qv56B2Mz1cF+Ut4gb2Z4Px521IFJvc+71ggwdqlLHqmV9GwfmkvoMHTIBaUt1fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951900; c=relaxed/simple;
	bh=sUmSo10U0500bOerBdfktQaQwZHt39MTwCzMtKDfq1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9YWnQ/r41vXT7j7ZCVl5Ow0X5p7g/9GS54hu0wNIUkQhfiFdtRKp6V5rBwsmEANCQvWxzP3/CQb/RB6LEwfj3isyPuNTiQOkH849UHUSnQ5nI86pFPSJf0fr3gsZD34G3Pcm+CUq2WYGG+l1BhIvRkhDnl0g3/0MW8fervSB1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oLubzzP8; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739951898; x=1771487898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sUmSo10U0500bOerBdfktQaQwZHt39MTwCzMtKDfq1Y=;
  b=oLubzzP8lgSpeF1RYnFGSDlCLBlpivgvPyDFjdXeVW1F81HFppNQZgwe
   aTmbqguERYX+Xm0zlotyvHs/TxJg+2QhYuGK80GP27bwFuw2+vchsn1OP
   rBB/R6wcw/5QhZri3OEG9y3nFCdGYNbL7Dp9+emonlx0xlBx8zB3rbDxr
   EJGNcFs/mXCDye93JKuJRsspUva6wla9/qt5MoeWQUiDUH+efI4g597TW
   rKaOjv5Q7CYDAJY+IkVccdFuTDz4PZlQVx9jGgXJOG4qMKqKBNehW6Y9D
   RFCirg6XJeiYDTLb5DL5X25zLGPvZlQC5WUMCQkc1HMPDV6bm+tpucWmu
   w==;
X-CSE-ConnectionGUID: I5GA30mpQue46+/Imq+Hng==
X-CSE-MsgGUID: WJ7RSro6Tze1hDIVCdSsKQ==
X-IronPort-AV: E=Sophos;i="6.13,298,1732550400"; 
   d="scan'208";a="38310812"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2025 15:58:09 +0800
IronPort-SDR: 67b58156_vGAhKgt1DbsYXPlMOY+0UCattNvvLw+0o8w1dBTe0FCbHI1
 FMlf7bLLH8kSdbLXEREJiy6j8wYi+emJW03W74A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Feb 2025 22:59:34 -0800
WDCIronportException: Internal
Received: from 5cg20343qs.ad.shared (HELO naota-xeon..) ([10.224.109.7])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Feb 2025 23:58:08 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 07/12] btrfs-progs: zoned: factor out SINGLE zone info loading
Date: Wed, 19 Feb 2025 16:57:51 +0900
Message-ID: <d74539740f97e9538e919f9f4a60e3101597a706.1739951758.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739951758.git.naohiro.aota@wdc.com>
References: <cover.1739951758.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the userland tool only considers the SINGLE profile, which make it
fail when a DUP block group is created over one conventional zone and one
sequential required zone.

Before adding the other profiles support, let's factor out per-profile code
(actually, SINGLE only) into functions just like as the kernel side.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/zoned.c | 47 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 4045cf0d2b98..e3240714b415 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -958,6 +958,26 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 	return 0;
 }
 
+static int btrfs_load_block_group_single(struct btrfs_fs_info *fs_info,
+					 struct btrfs_block_group *bg,
+					 struct zone_info *info,
+					 unsigned long *active)
+{
+	if (info->alloc_offset == WP_MISSING_DEV) {
+		btrfs_err(fs_info,
+			"zoned: cannot recover write pointer for zone %llu",
+			info->physical);
+		return -EIO;
+	}
+
+	bg->alloc_offset = info->alloc_offset;
+	bg->zone_capacity = info->capacity;
+	if (test_bit(0, active))
+		bg->zone_is_active = 1;
+	return 0;
+}
+
+
 int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 				     struct btrfs_block_group *cache)
 {
@@ -972,6 +992,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 	int i;
 	u64 last_alloc = 0;
 	u32 num_conventional = 0;
+	u64 profile;
 
 	if (!btrfs_is_zoned(fs_info))
 		return 0;
@@ -1039,10 +1060,28 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 		goto out;
 	}
-	/* SINGLE profile case. */
-	cache->alloc_offset = zone_info[0].alloc_offset;
-	cache->zone_capacity = zone_info[0].capacity;
-	cache->zone_is_active = test_bit(0, active);
+
+	profile = map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK;
+	switch (profile) {
+	case 0: /* single */
+		ret = btrfs_load_block_group_single(fs_info, cache, &zone_info[0], active);
+		break;
+	case BTRFS_BLOCK_GROUP_DUP:
+	case BTRFS_BLOCK_GROUP_RAID1:
+	case BTRFS_BLOCK_GROUP_RAID1C3:
+	case BTRFS_BLOCK_GROUP_RAID1C4:
+	case BTRFS_BLOCK_GROUP_RAID0:
+	case BTRFS_BLOCK_GROUP_RAID10:
+		/* Temporarily fails these case, until following commits. */
+		fallthrough;
+	case BTRFS_BLOCK_GROUP_RAID5:
+	case BTRFS_BLOCK_GROUP_RAID6:
+	default:
+		error("zoned: profile %s not yet supported",
+		      btrfs_bg_type_to_raid_name(map->type));
+		ret = -EINVAL;
+		goto out;
+	}
 
 out:
 	/* An extent is allocated after the write pointer */
-- 
2.48.1


