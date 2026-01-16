Return-Path: <linux-btrfs+bounces-20620-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90601D2F289
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 10:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DFC930BDA6D
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 09:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD3B35CBBB;
	Fri, 16 Jan 2026 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FiKVhZvk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F901357A5E
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557484; cv=none; b=prp8rQ37bpcbIn6KXMthCL7Ae8Rz0apF8WBM5+L69wDWxlceFad3toItwr20C+NES10ku3MawUOlGlvYnvduNGGwOTJHtPHfIgs3eRC0+TdzGm8Re1YM/oZvhzVrqYzhY9sxBrQFuMWnBmNE4THVjs2E0wLCWhAOpUf5mdu4BiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557484; c=relaxed/simple;
	bh=lEGgUjiVuDLj9DPMjbysvMEbWQW5NC0SID85KdTCV38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWw6buBOpkkRyKMl1hkXaXDgjZ+z3MeHEyuTNHEoAEHnPNCpNA2uchvKCmA7EiimPJnq6A676gMvkvQxcaXSaqiQS6sOyyytVQbitWhdugN3KtZCHpy0wy7IgKjVi2MWbNKOl2KtFQJR8K0ZL+Py557B8fY6S3twZuyn73Gw+4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FiKVhZvk; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768557478; x=1800093478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lEGgUjiVuDLj9DPMjbysvMEbWQW5NC0SID85KdTCV38=;
  b=FiKVhZvkMj5orDahBalNqrOU5ftbj9oT1WtwhsxBzhiJpM88z5wdQ2R5
   vfoRIcxLmuz26Am5aJRSqq8RL+LVL+ACrJYkW3uLfN/jexzZdPhYzWJh2
   O+LQX5e2x+IipJMxKiCZGFp+vfpkeoDAyt5sqB2Z/EYcDiTDjeWuu7EVm
   1NrY74LUb5zABZG/l/fTp9RVCA2aI1eRrzm/Pw7Yso3aTcpB52YF0QUrp
   iswGa0Q0WK5krfyTMGD2b0XLM3yq8d/AQukdXBRzH3xOZgyHYxOKpq6B7
   gbM3e+ovpDEC4p5dS4/KoM59ZdrHJrYMrOCTlcWoemuaF7GAJ8HqSN/ia
   g==;
X-CSE-ConnectionGUID: 3mNAKXVLSXu4tPQO+ByPig==
X-CSE-MsgGUID: 2suOgUm9Si+AUWvu7qJ5ZQ==
X-IronPort-AV: E=Sophos;i="6.21,230,1763395200"; 
   d="scan'208";a="138913523"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2026 17:57:58 +0800
IronPort-SDR: 696a0ba6_hLSedC2HB0vyZvBQIOoc+HsFr7DGBdljxxr7DLJaHjKL7PM
 UzVFzO1J0AErKe9sjFhccR9Q4T0ad0mP3RCU30g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2026 01:57:58 -0800
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO neo.fritz.box) ([10.224.28.27])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Jan 2026 01:57:56 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH RFC 1/2] btrfs-progs: collapse find_free_dev_extent into find_free_dev_extent_start
Date: Fri, 16 Jan 2026 10:57:38 +0100
Message-ID: <20260116095739.44201-3-johannes.thumshirn@wdc.com>
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel-shared/volumes.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 0a7301281470..f1baf5c30ce0 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -812,10 +812,9 @@ static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
 }
 
 /*
- * find_free_dev_extent_start - find free space in the specified device
+ * find_free_dev_extent - find free space in the specified device
  * @device:	  the device which we search the free space in
  * @num_bytes:	  the size of the free space that we need
- * @search_start: the position from which to begin the search
  * @start:	  store the start of the free space.
  * @len:	  the size of the free space. that we find, or the size
  *		  of the max free space if we don't find suitable free space
@@ -832,9 +831,8 @@ static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
  * But if we don't find suitable free space, it is used to store the size of
  * the max free space.
  */
-static int find_free_dev_extent_start(struct btrfs_device *device,
-				      u64 num_bytes, u64 search_start,
-				      u64 *start, u64 *len)
+static int find_free_dev_extent(struct btrfs_device *device,
+			        u64 num_bytes, u64 *start, u64 *len)
 {
 	struct btrfs_key key;
 	struct btrfs_root *root = device->dev_root;
@@ -849,6 +847,7 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	int slot;
 	struct extent_buffer *l;
 	u64 zone_size = 0;
+	u64 search_start = 0;
 
 	if (device->zone_info)
 		zone_size = device->zone_info->zone_size;
@@ -975,13 +974,6 @@ out:
 	return ret;
 }
 
-static int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
-				u64 *start, u64 *len)
-{
-	/* FIXME use last free of some kind */
-	return find_free_dev_extent_start(device, num_bytes, 0, start, len);
-}
-
 /*
  * Insert one device extent into the fs.
  */
-- 
2.52.0


