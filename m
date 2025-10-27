Return-Path: <linux-btrfs+bounces-18358-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CE5C0C21D
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 08:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43D73B8B6C
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 07:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77032DEA71;
	Mon, 27 Oct 2025 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ImUdxkoF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797012D595F
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Oct 2025 07:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761550155; cv=none; b=pKcEKA3cH07TtWpMYleIYGhPh+rwBq42SUpabYkdn0eaJXtaThTCmTM1W+Vvv0v6OPCjEq710dIqLtJNYt8E73I8zdJrSDJNXbsK2H3XtRwt29oOf1MgA7Sw4jNVuARoZs6kxPLHyML6QC+z/5x0ls76sCJ2j8E+LLvXlLiOAlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761550155; c=relaxed/simple;
	bh=erOLMk6jw0J/6QdWtjhBokc9S2x0nvMjeyr/xuKNjdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKpGvdq3Bi7eMc/raByKc0z+GtrttvaoKrGooMFDFVWQNLy/u2xJVngg7ZqsXMKgFwRtPmSjwamSK+Lu2WWpv/BFUULnvR9XEiFCMU5BQVbf0qnM9xXEe4cV2MmScssY+PRmQW3pNYvakpZTuZVVfokv06VKAg+hnqpnqAnngjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ImUdxkoF; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761550153; x=1793086153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=erOLMk6jw0J/6QdWtjhBokc9S2x0nvMjeyr/xuKNjdM=;
  b=ImUdxkoFV/lG5ZRmPM6Zkyw8TpZXz0MIIXNk4VX+enLBOED41FFo5LGx
   fU+CZFRgLCO+fuN5go2c1RGXkQMsk/0zR7zzOSgscj0md2VInygDrLmwl
   e/9VnO/+DZEnWpo2JE1v+8jB988FCHjc09qca95J0aEBnSifnWmn5uVnF
   yj2Zyu7DpK7GsqieTBpOl1oMAed0PUfcdW+NJ2kkmnnRZIYuwftmacf/q
   YISZQkQW9Js6PxzCAaJEc+Hy+E5s2MLwZj2/Y33UY/ixWZfVuH544mB/g
   lx8cKrgUpJ12Z8TIcGi6VffcDKPAkkMk8VSHSD5f5tz7Hx0L+uHiiT7Br
   w==;
X-CSE-ConnectionGUID: FT6fYmIEReebllOCG6nFFQ==
X-CSE-MsgGUID: pvqQJwLETryq4ewOXKDeTg==
X-IronPort-AV: E=Sophos;i="6.19,258,1754928000"; 
   d="scan'208";a="130947253"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2025 15:29:04 +0800
IronPort-SDR: 68ff1f40_9Bx2+JVlM3LyQKB7rpewA12mFYQVtCc5ccGJaUoeMvhSwXT
 hGPYAWfbOT0QMSDGr43n5KCC1ffpGSupLepCWxw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2025 00:29:04 -0700
WDCIronportException: Internal
Received: from wdap-xbhuzc2r95.ad.shared (HELO naota-xeon) ([10.224.105.146])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Oct 2025 00:29:03 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/2] btrfs: zoned: fix zone capacity calculation
Date: Mon, 27 Oct 2025 16:27:57 +0900
Message-ID: <20251027072758.1066720-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027072758.1066720-1-naohiro.aota@wdc.com>
References: <20251027072758.1066720-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a block group contains both conventional zone and sequential zone, the
capacity of the block group is wrongly set to the block group's full
length. The capacity should be calculated in btrfs_load_block_group_* using
the last allocation offset.

Fixes: 568220fa9657 ("btrfs: zoned: support RAID0/1/10 on top of raid stripe tree")
CC: stable@vger.kernel.org # v6.12+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 2e3145c1a102..f20a9b83b7e1 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1317,6 +1317,7 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 	if (!btrfs_dev_is_sequential(device, info->physical)) {
 		up_read(&dev_replace->rwsem);
 		info->alloc_offset = WP_CONVENTIONAL;
+		info->capacity = device->zone_info->zone_size;
 		return 0;
 	}
 
@@ -1683,8 +1684,6 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		set_bit(BLOCK_GROUP_FLAG_SEQUENTIAL_ZONE, &cache->runtime_flags);
 
 	if (num_conventional > 0) {
-		/* Zone capacity is always zone size in emulation */
-		cache->zone_capacity = cache->length;
 		ret = calculate_alloc_pointer(cache, &last_alloc, new);
 		if (ret) {
 			btrfs_err(fs_info,
@@ -1693,6 +1692,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 			goto out;
 		} else if (map->num_stripes == num_conventional) {
 			cache->alloc_offset = last_alloc;
+			cache->zone_capacity = cache->length;
 			set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &cache->runtime_flags);
 			goto out;
 		}
-- 
2.51.1


