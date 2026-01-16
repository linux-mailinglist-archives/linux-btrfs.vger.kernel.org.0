Return-Path: <linux-btrfs+bounces-20619-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6D4D2F28A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 10:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21CBE30BDB4C
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 09:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D5335CBCA;
	Fri, 16 Jan 2026 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JO3U7nF9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E7621B185
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557484; cv=none; b=au0hgJ+IIbmByvAf8WkyAU2vHwxbsqgnPYfH3SpWMQrIYzlo961ri52Vth2jsjMsAZvxZSKtAH3x6//cNaMYnfEx1U+bpAxYTdQDRu/OMcSJQxKtm1BsHrZ+Mn2IsBKPjnFLfMtORWeIhNXg898iEBHklz16DfwGgQnaVSfkezs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557484; c=relaxed/simple;
	bh=TZXkp/YVQGjhtjNz8RIRfO7oHgoYZG2NBKBSt/C2sd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zn4DhURicXqCfSy4o0hAjgpihlAQz29S+/fpiuuZb0Vx5xVdIy4WmjS3F9HARs0wyVOU4mYeUHViJhTeqiAeMHsII0izBIXjv43gOQUbvriBa5dQDlDfAJCOYZEg2z8JYtXs4xvU6brvr5aYIbBQcMxdGOlIP6USgPE5CcuDVpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JO3U7nF9; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768557482; x=1800093482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TZXkp/YVQGjhtjNz8RIRfO7oHgoYZG2NBKBSt/C2sd0=;
  b=JO3U7nF9Dfx2BieRNnZntbuDnIfiMZYckaUNBQ78OwxyQvLXFwJGCUxK
   4pifPWykANmjEQ4X2lyEIiXObcZWKSJCrgKEcxaz0ZigrEv4Lmmy+vhT2
   0MqvyU9oBjduVHp+cLfl1lq+Ok5in88il2egui0XgqAnpRE54VQ+8Fniq
   ryfSJcF2rgqkLNnP4HYKvnKeEisXGViddPXhAtBYWlYDmOxjIp5w7Q0a8
   7qgkV7/c0iPFRezPmornyKyEyjBNz78d/zBW7KjrFVdktRQSHuoTnhIpk
   K5i3BvL9Rw4H/dvTN6baQSFlx2faWlefefn3OSbMEU46JGNIg6xROUfci
   g==;
X-CSE-ConnectionGUID: yUih2bAHS9yrDU7CtPta9g==
X-CSE-MsgGUID: LveCC8SWR1K57PE+cKX+BA==
X-IronPort-AV: E=Sophos;i="6.21,230,1763395200"; 
   d="scan'208";a="138913534"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2026 17:58:01 +0800
IronPort-SDR: 696a0ba9_p1Ku6KKg6EqWov9y8JhVzsIvk2khrRFMwrHtEocLy5oMI/p
 pmvk0fRIYC81PPZj70tDP99jx9nBEAPEJyC3Ekw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2026 01:58:02 -0800
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO neo.fritz.box) ([10.224.28.27])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Jan 2026 01:57:59 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH RFC 2/2] btrfs-progs: zoned: only allocate data off of sequential zones
Date: Fri, 16 Jan 2026 10:57:39 +0100
Message-ID: <20260116095739.44201-4-johannes.thumshirn@wdc.com>
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

On a zoned filesystem allocatate data block-groups only off of sequential
zones leaving conventional zones to metadata and system block-groups.

TODO if the device doesn't implement conventional zones or does not have
any empty conventional zones left, skip this step and allow metadata and
system block-groups on sequential zones.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel-shared/volumes.c | 59 ++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index f1baf5c30ce0..fcf6b40a2d4a 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -763,23 +763,39 @@ static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
 	}
 }
 
-static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
+static bool dev_extent_hole_check_zoned(struct btrfs_device *device, u64 type,
 					u64 *hole_start, u64 *hole_size,
 					u64 num_bytes)
 {
-	u64 pos;
+	u64 zone_size = device->zone_info->zone_size;
+	bool changed = false;
 
 	ASSERT(IS_ALIGNED(*hole_start, device->zone_info->zone_size));
 
-	pos = btrfs_find_allocatable_zones(device, *hole_start,
-					   *hole_start + *hole_size, num_bytes);
-	if (pos != *hole_start) {
-		*hole_size = *hole_start + *hole_size - pos;
-		*hole_start = pos;
-		return true;
-	}
+	while (*hole_size > 0) {
+		bool sequential;
+		u64 pos;
 
-	return false;
+		pos = btrfs_find_allocatable_zones(device, *hole_start,
+				*hole_start + *hole_size, num_bytes);
+		if (pos != *hole_start) {
+			*hole_size = *hole_start + *hole_size - pos;
+			*hole_start = pos;
+			return true;
+		}
+
+		sequential = btrfs_dev_is_sequential(device, pos);
+		if (type & BTRFS_BLOCK_GROUP_DATA && sequential)
+			return false;
+
+		if (!(type & BTRFS_BLOCK_GROUP_DATA) && !sequential)
+			return false;
+
+		*hole_start += zone_size;
+		*hole_size -= zone_size;
+		changed = true;
+	}
+	return changed;
 }
 
 /**
@@ -794,15 +810,15 @@ static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
  * position for allocation. Returns true if hole position is updated, false
  * otherwise.
  */
-static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
-				  u64 *hole_size, u64 num_bytes)
+static bool dev_extent_hole_check(struct btrfs_device *device, u64 type,
+				  u64 *hole_start, u64 *hole_size, u64 num_bytes)
 {
 	switch (device->fs_devices->chunk_alloc_policy) {
 	case BTRFS_CHUNK_ALLOC_REGULAR:
 		/* No check */
 		break;
 	case BTRFS_CHUNK_ALLOC_ZONED:
-		return dev_extent_hole_check_zoned(device, hole_start,
+		return dev_extent_hole_check_zoned(device, type, hole_start,
 						   hole_size, num_bytes);
 	default:
 		BUG();
@@ -814,6 +830,7 @@ static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
 /*
  * find_free_dev_extent - find free space in the specified device
  * @device:	  the device which we search the free space in
+ * @type:         the block_group type we want to allocate
  * @num_bytes:	  the size of the free space that we need
  * @start:	  store the start of the free space.
  * @len:	  the size of the free space. that we find, or the size
@@ -831,7 +848,7 @@ static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
  * But if we don't find suitable free space, it is used to store the size of
  * the max free space.
  */
-static int find_free_dev_extent(struct btrfs_device *device,
+static int find_free_dev_extent(struct btrfs_device *device, u64 type,
 			        u64 num_bytes, u64 *start, u64 *len)
 {
 	struct btrfs_key key;
@@ -907,7 +924,7 @@ again:
 
 		if (key.offset > search_start) {
 			hole_size = key.offset - search_start;
-			dev_extent_hole_check(device, &search_start, &hole_size,
+			dev_extent_hole_check(device, type, &search_start, &hole_size,
 					      num_bytes);
 
 			if (hole_size > max_hole_size) {
@@ -947,8 +964,8 @@ next:
 	 */
 	if (search_end > search_start) {
 		hole_size = search_end - search_start;
-		if (dev_extent_hole_check(device, &search_start, &hole_size,
-					  num_bytes)) {
+		if (dev_extent_hole_check(device, type, &search_start,
+					  &hole_size, num_bytes)) {
 			btrfs_release_path(path);
 			goto again;
 		}
@@ -1028,12 +1045,12 @@ err:
  * Allocate one free dev extent and insert it into the fs.
  */
 static int btrfs_alloc_dev_extent(struct btrfs_trans_handle *trans,
-				  struct btrfs_device *device,
+				  struct btrfs_device *device, u64 type,
 				  u64 chunk_offset, u64 num_bytes, u64 *start)
 {
 	int ret;
 
-	ret = find_free_dev_extent(device, num_bytes, start, NULL);
+	ret = find_free_dev_extent(device, type, num_bytes, start, NULL);
 	if (ret)
 		return ret;
 	return btrfs_insert_dev_extent(trans, device, chunk_offset, num_bytes,
@@ -1598,8 +1615,8 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 			list_move(&device->dev_list, dev_list);
 
 		if (!ctl->dev_offset) {
-			ret = btrfs_alloc_dev_extent(trans, device, key.offset,
-					ctl->stripe_size, &dev_offset);
+			ret = btrfs_alloc_dev_extent(trans, device, ctl->type,
+					key.offset, ctl->stripe_size, &dev_offset);
 			if (ret < 0)
 				goto out_chunk_map;
 		} else {
-- 
2.52.0


