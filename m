Return-Path: <linux-btrfs+bounces-11498-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A586BA379CF
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 03:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1B9163BC2
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 02:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE298167DAC;
	Mon, 17 Feb 2025 02:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AM9RWfEj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E17D1531E8
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 02:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739759878; cv=none; b=GTgrpwQbqDmk4NZYqVgwDy9T+SuMWRXOOxXQuwwMcWDanJ8yeKGOFRYyM6PDTKH54QTtQ2IAsI7kcBtud/W6I94jxheHHnbRvwzbiCEk4DkuGkf5t8/X0HF4aDsAItasYkGJJVyZkQfKdL8j20au1/VPk2DLnWyWz6KtD4Kw8JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739759878; c=relaxed/simple;
	bh=x98HO+Od0wUM+b91JwZMMisWEGzHFTXUmgURwl+FebY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/clEFIc3rJTCunwf92GwHlqFYOSO4bzFqQpvIHqDKTuZy6J7zmPy/N3Jqs5z/VVpzED/QYh7XRM5gS8mVN54C+XvBcvL+ZHsaFDqrxluW7xNmBLCnxsHmV6bAScSJJfnAd5Q4PhsOYRbNilm/PnpPC7eyZ2mqzVOMLQd0ip534=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AM9RWfEj; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739759876; x=1771295876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x98HO+Od0wUM+b91JwZMMisWEGzHFTXUmgURwl+FebY=;
  b=AM9RWfEjkFOHuhTxytvzxGZl8w+FhDZQqouySwJbUYWcvo3OYf/OJjp8
   YvmJKFqesdILpZDVcBAdHnej470tvqiNw9qNFuMF5O/meOLEr/jjzg++X
   g14yNAcOGyGnqa4BKCrZwEyW4XYGnWyi8TgOYExBmBa+kWiMklJTPeL0J
   CXv5PV+O7mdweklJzXzVEGJFTxOmcPlg6rD4Nd9Z7nKIEo31znaliZpEy
   PTEZCnPeFfV7MKpS0TEQjwJ3CVZTEu3rwh6g3WZv1UfKLl1CN5hscezg9
   nBzO7FdAVypzeSCj1BWqM+LoVP6hT0mb6NunoDrrZti1DSrqX23KjWzRp
   Q==;
X-CSE-ConnectionGUID: WTGYj7IuSPWzjfWd3hdWwA==
X-CSE-MsgGUID: M+/59twLSVa3g19SSGXwcw==
X-IronPort-AV: E=Sophos;i="6.13,291,1732550400"; 
   d="scan'208";a="39877180"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2025 10:37:53 +0800
IronPort-SDR: 67b29349_AAQJBwzLLHCMpAwPV9FFng+NoTp2OU+7q3kvRpe+2ghy3iT
 TNar7i2jyA0+gbOTK8t+uvIa++wmmwAGVmAJ3Iw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2025 17:39:21 -0800
WDCIronportException: Internal
Received: from 5cg2075f7l.ad.shared (HELO naota-xeon..) ([10.224.109.184])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2025 18:37:53 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 07/12] btrfs-progs: zoned: factor out SINGLE zone info loading
Date: Mon, 17 Feb 2025 11:37:37 +0900
Message-ID: <11de06f6243f4f048d19f105a170cbd6f8e5f4c3.1739756953.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739756953.git.naohiro.aota@wdc.com>
References: <cover.1739756953.git.naohiro.aota@wdc.com>
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
 kernel-shared/zoned.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 4045cf0d2b98..3bc7d6ba1924 100644
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
@@ -1039,10 +1060,20 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
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


