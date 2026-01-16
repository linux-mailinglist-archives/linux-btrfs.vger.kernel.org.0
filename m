Return-Path: <linux-btrfs+bounces-20618-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F89D2F279
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 10:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEC493023570
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 09:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18235313293;
	Fri, 16 Jan 2026 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NcGpcU7i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC82331D730
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557482; cv=none; b=V6E7F9Q7FxTXDNaQ2s8EZgUhsmMnxbFzexSe6+1cH1GrWAeMoWlznWBE8jSkebFcfazq8hBjUkEIiMH59vW24aYl7LOINVyp50rKvePR+S/D23FEFgri+U9qAaPeXenHwUJKFZT1x74TvpKtQ/2hV4fs7J++5vHUpUKR4WsFXFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557482; c=relaxed/simple;
	bh=3m1Thrb2ELTY0XqIl+BCcNIZLg/vh/NCZpn7wAIKELE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYnjxkbRm0lMZ62vBVLjuRY8DLjsDVbjl1gy7OIXU4DCvwwt6hFiwzBrOvwW7NrSMoay2A7be9ohUXQMWMxpZ0KQrsO/6zw91xW/4yUakzhp3p1vwxdDiOcdZcsFQWCQDYVdQ4P5iNi/4uKz6WmfLmpeYh8+43fOFJYV1FZB58A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NcGpcU7i; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768557478; x=1800093478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3m1Thrb2ELTY0XqIl+BCcNIZLg/vh/NCZpn7wAIKELE=;
  b=NcGpcU7ibvJtuL1G30dDMwhR7WfBW5qQ3CL7j/lSwNfZqtUgruadBvlD
   uEvFG0e6kX60b+THTMQ8IwMazwtW8Pi1pQ1b7KwbsxQrpBWXZSGfZaB82
   Qd8uyItPE09FGMOnbNBbkU8TevWxswL53UdJ1MmcMSKAe/gK/28amjoEd
   yJuVr44yfGbSv4CL9usNvtaGAumWz2qgg4YrAANdeXxQWAY9gGzwf1+fr
   +/LsueSE/AV40Eb+jFe95/aT7xCNrexZHf9skHDoVdrYoqzB3HpJZSeiv
   ilzFEXWMPC+if0baInlfDjjscVNpoDIFu1ie+Y5d9m/0rEUvFiXduUPI4
   A==;
X-CSE-ConnectionGUID: x1LW0iNITD6qpAmJ7skWhA==
X-CSE-MsgGUID: MHkh/E98SkGi97G8bQo00A==
X-IronPort-AV: E=Sophos;i="6.21,230,1763395200"; 
   d="scan'208";a="138913519"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2026 17:57:54 +0800
IronPort-SDR: 696a0ba2_cdxSd0/vHyLn8uFYI9JFSIQLJivumdSkUbwKEhczIygHsEc
 A8EvCL1KLUNeZBwU1Jn/3B2CvRhEyZjkKwlxEUQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2026 01:57:55 -0800
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO neo.fritz.box) ([10.224.28.27])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Jan 2026 01:57:52 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH RFC 1/1] btrfs: zoned: only allocate data off of sequential zones
Date: Fri, 16 Jan 2026 10:57:37 +0100
Message-ID: <20260116095739.44201-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116095739.44201-1-johannes.thumshirn@wdc.com>
References: <20260116095739.44201-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a zoned filesystem allocate data block-groups only off of the
sequential zones of a device.

Doing so will free up the conventional zones for the system and metadata
block-groups, eventually removing the need for using the zoned allocator
and all it's required infrastructure, that needs to be emulated, for
conventional zones.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6bde24292aeb..0083944649ca 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1547,7 +1547,7 @@ static u64 dev_extent_search_start(struct btrfs_device *device)
 	}
 }
 
-static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
+static bool dev_extent_hole_check_zoned(struct btrfs_device *device, u64 type,
 					u64 *hole_start, u64 *hole_size,
 					u64 num_bytes)
 {
@@ -1560,6 +1560,8 @@ static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
 	       "hole_start=%llu zone_size=%llu", *hole_start, zone_size);
 
 	while (*hole_size > 0) {
+		bool sequential;
+
 		pos = btrfs_find_allocatable_zones(device, *hole_start,
 						   *hole_start + *hole_size,
 						   num_bytes);
@@ -1571,6 +1573,11 @@ static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
 				break;
 		}
 
+		sequential = btrfs_dev_is_sequential(device, pos);
+
+		if (type & BTRFS_BLOCK_GROUP_DATA && !sequential)
+			goto next_zone;
+
 		ret = btrfs_ensure_empty_zones(device, pos, num_bytes);
 
 		/* Range is ensured to be empty */
@@ -1584,6 +1591,7 @@ static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
 			return true;
 		}
 
+next_zone:
 		*hole_start += zone_size;
 		*hole_size -= zone_size;
 		changed = true;
@@ -1603,8 +1611,8 @@ static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
  * This function may modify @hole_start and @hole_size to reflect the suitable
  * position for allocation. Returns 1 if hole position is updated, 0 otherwise.
  */
-static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
-				  u64 *hole_size, u64 num_bytes)
+static bool dev_extent_hole_check(struct btrfs_device *device, u64 type,
+				  u64 *hole_start, u64 *hole_size, u64 num_bytes)
 {
 	bool changed = false;
 	u64 hole_end = *hole_start + *hole_size;
@@ -1630,7 +1638,7 @@ static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
 			/* No extra check */
 			break;
 		case BTRFS_CHUNK_ALLOC_ZONED:
-			if (dev_extent_hole_check_zoned(device, hole_start,
+			if (dev_extent_hole_check_zoned(device, type, hole_start,
 							hole_size, num_bytes)) {
 				changed = true;
 				/*
@@ -1675,8 +1683,8 @@ static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
  * correct usable device space, as device extent freed in current transaction
  * is not reported as available.
  */
-static int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
-				u64 *start, u64 *len)
+static int find_free_dev_extent(struct btrfs_device *device, u64 type,
+				u64 num_bytes, u64 *start, u64 *len)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
 	struct btrfs_root *root = fs_info->dev_root;
@@ -1751,8 +1759,8 @@ static int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
 
 		if (key.offset > search_start) {
 			hole_size = key.offset - search_start;
-			dev_extent_hole_check(device, &search_start, &hole_size,
-					      num_bytes);
+			dev_extent_hole_check(device, type, &search_start,
+					      &hole_size, num_bytes);
 
 			if (hole_size > max_hole_size) {
 				max_hole_start = search_start;
@@ -1791,7 +1799,7 @@ static int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
 	 */
 	if (search_end > search_start) {
 		hole_size = search_end - search_start;
-		if (dev_extent_hole_check(device, &search_start, &hole_size,
+		if (dev_extent_hole_check(device, type, &search_start, &hole_size,
 					  num_bytes)) {
 			btrfs_release_path(path);
 			goto again;
@@ -5243,8 +5251,8 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 		if (total_avail < ctl->dev_extent_min)
 			continue;
 
-		ret = find_free_dev_extent(device, dev_extent_want, &dev_offset,
-					   &max_avail);
+		ret = find_free_dev_extent(device, ctl->type, dev_extent_want,
+					   &dev_offset, &max_avail);
 		if (ret && ret != -ENOSPC)
 			return ret;
 
-- 
2.52.0


