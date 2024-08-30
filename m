Return-Path: <linux-btrfs+bounces-7693-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA72966703
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 18:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6DF1F23692
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 16:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39E21B2ED3;
	Fri, 30 Aug 2024 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hfj29xEL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C3326ADD
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035586; cv=none; b=UISsfzvyBArbEMvX4HaBXwXbEHiPEyBdfedAuPRzWdly+XCpnuXtc6hcNRbWFcISR/z8F7CmQc0yHTUiqjUwjZEtcAAuZQfKQewcNxFSRXfAwe3POCK8h/dRJszPJKmU9QRL/XnhUtPRXD8ezZ+vOA3D6p2CdwYg1AvdWOgjyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035586; c=relaxed/simple;
	bh=zeUev8rWV5kBgKjvOsMi2XxytxooCFo68IKgyzVvs7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qYNY0Aeg+7/7oFb4JxYijapt9rbz/pAOKVDqsAsRno862Pw/AwVMTn6JAAlozQqvXQdgL4EswfcfOOEavoXGxexSOSo+iBmKKFd+DwpRqnG0IcY9cdY9sU0FBcpJvzJn5yl+ajGZC0nbUPdpkO0uJZ5yBjPBWw7T1XdmAF6Yuag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hfj29xEL; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725035584; x=1756571584;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zeUev8rWV5kBgKjvOsMi2XxytxooCFo68IKgyzVvs7E=;
  b=hfj29xELZY+fNO8ZZGHjAsL3MY2UkQ9mu/W4hOLWJn0i2By3soLcUfXI
   6XiRUBKpIEhT7DQREMuM4u5ayld7gPF5h/4vtd4epFutESjDlK9T9MRqM
   gQW5OoBcZGeg3B+4PuyL2/wPSttLqnCBlFQoXSeWL4Wc4OiMAbgdp76Cp
   pkM7PSGazCK9jApk4gnouWbtqZG27PgNwy1XEkbbTMvnO9FZsy6DTdQ2g
   d3HdILrB63MS5Y0yVYtXLIKqtcI3MhK84rWpnbso1RirZKsR7KpxGVBXe
   MyzVDJVOuJNZK1BmCepElfLy3DPAnWXEEgeg/fLuATQDeV4/akapgo0yD
   w==;
X-CSE-ConnectionGUID: HYM6mJofTpKPzAOajfenxQ==
X-CSE-MsgGUID: rHFdv51GRa2RmDWE/5e4gQ==
X-IronPort-AV: E=Sophos;i="6.10,189,1719849600"; 
   d="scan'208";a="26586993"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2024 00:32:58 +0800
IronPort-SDR: 66d1e778_Wy311KnLYOZ+AMWf7Zk7N/yweH9B6fW/Hqhbx227p/sgU3U
 gpLBc1ZJfFWd4+fxD5J44r4uYf6oSrcnGxSxHSA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Aug 2024 08:38:32 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.120])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Aug 2024 09:32:58 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: xuefer@gmail.com,
	Naohiro Aota <naohiro.aota@wdc.com>,
	HAN Yuwei <hrx@bupt.moe>
Subject: [PATCH] btrfs: zoned: handle broken write pointer on zones
Date: Sat, 31 Aug 2024 01:32:49 +0900
Message-ID: <6a8b1550cef136b1d733d5c1016a7ba717335344.1725035560.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Btrfs rejects to mount a FS if it finds a block group with a broken write
pointer (e.g, unequal write pointers on two zones of RAID1 block group).
Since such case can happen easily with a power-loss or crash of a system,
we need to handle the case more gently.

Handle such block group by making it unallocatable, so that there will be
no writes into it. That can be done by setting the allocation pointer at
the end of allocating region (= block_group->zone_capacity). Then, existing
code handle zone_unusable properly.

Having proper zone_capacity is necessary for the change. So, set it as fast
as possible.

We cannot handle RAID0 and RAID10 case like this. But, they are anyway
unable to read because of a missing stripe.

Fixes: 265f7237dd25 ("btrfs: zoned: allow DUP on meta-data block groups")
Fixes: 568220fa9657 ("btrfs: zoned: support RAID0/1/10 on top of raid stripe tree")
CC: stable@vger.kernel.org # 6.1+
Reported-by: HAN Yuwei <hrx@bupt.moe>
Cc: Xuefer <xuefer@gmail.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 66f63e82af79..047e3337852e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1406,6 +1406,8 @@ static int btrfs_load_block_group_dup(struct btrfs_block_group *bg,
 		return -EINVAL;
 	}
 
+	bg->zone_capacity = min_not_zero(zone_info[0].capacity, zone_info[1].capacity);
+
 	if (zone_info[0].alloc_offset == WP_MISSING_DEV) {
 		btrfs_err(bg->fs_info,
 			  "zoned: cannot recover write pointer for zone %llu",
@@ -1432,7 +1434,6 @@ static int btrfs_load_block_group_dup(struct btrfs_block_group *bg,
 	}
 
 	bg->alloc_offset = zone_info[0].alloc_offset;
-	bg->zone_capacity = min(zone_info[0].capacity, zone_info[1].capacity);
 	return 0;
 }
 
@@ -1450,6 +1451,9 @@ static int btrfs_load_block_group_raid1(struct btrfs_block_group *bg,
 		return -EINVAL;
 	}
 
+	/* In case a device is missing we have a cap of 0, so don't use it. */
+	bg->zone_capacity = min_not_zero(zone_info[0].capacity, zone_info[1].capacity);
+
 	for (i = 0; i < map->num_stripes; i++) {
 		if (zone_info[i].alloc_offset == WP_MISSING_DEV ||
 		    zone_info[i].alloc_offset == WP_CONVENTIONAL)
@@ -1471,9 +1475,6 @@ static int btrfs_load_block_group_raid1(struct btrfs_block_group *bg,
 			if (test_bit(0, active))
 				set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &bg->runtime_flags);
 		}
-		/* In case a device is missing we have a cap of 0, so don't use it. */
-		bg->zone_capacity = min_not_zero(zone_info[0].capacity,
-						 zone_info[1].capacity);
 	}
 
 	if (zone_info[0].alloc_offset != WP_MISSING_DEV)
@@ -1563,6 +1564,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	unsigned long *active = NULL;
 	u64 last_alloc = 0;
 	u32 num_sequential = 0, num_conventional = 0;
+	u64 profile;
 
 	if (!btrfs_is_zoned(fs_info))
 		return 0;
@@ -1623,7 +1625,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		}
 	}
 
-	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
+	profile = map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK;
+	switch (profile) {
 	case 0: /* single */
 		ret = btrfs_load_block_group_single(cache, &zone_info[0], active);
 		break;
@@ -1650,6 +1653,23 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		goto out;
 	}
 
+	if (ret == -EIO && profile != 0 && profile != BTRFS_BLOCK_GROUP_RAID0 &&
+	    profile != BTRFS_BLOCK_GROUP_RAID10) {
+		/*
+		 * Detected broken write pointer.  Make this block group
+		 * unallocatable by setting the allocation pointer at the end of
+		 * allocatable region. Relocating this block group will fix the
+		 * mismatch.
+		 *
+		 * Currently, we cannot handle RAID0 or RAID10 case like this
+		 * because we don't have a proper zone_capacity value. But,
+		 * reading from this block group won't work anyway by a missing
+		 * stripe.
+		 */
+		cache->alloc_offset = cache->zone_capacity;
+		ret = 0;
+	}
+
 out:
 	/* Reject non SINGLE data profiles without RST */
 	if ((map->type & BTRFS_BLOCK_GROUP_DATA) &&
-- 
2.46.0


