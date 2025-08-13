Return-Path: <linux-btrfs+bounces-16051-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33968B24C37
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 16:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C279D1BC804F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 14:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF412F067A;
	Wed, 13 Aug 2025 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="2wu2Feq0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741222EAB78
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Aug 2025 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095725; cv=none; b=goWGOoeK3nN7HGRVkvtZXd9TlT798dLNiLShNVSs2YlaYobtNO1PYg+upCjL1rvhzUMJOvv7j/xiGgNGdeBwvUSUDfZT1cUgvdFKQqK5u8GGoUUansctzftE+PiAz+wURkRBCZR7LNHoxDwQu4pFfiE7OOxz9f6SzAaBIorxH1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095725; c=relaxed/simple;
	bh=XVj0UhI0OmhI2Ah2XZD+ECIe5k6fJfhrpqQrIKPdTyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=FxQ80/SdEhaxCGsxa0HkfuFiB1Huxl6VQQi3BSZj1O328vRUZo5UV2uiPltOKWMNubOwR+obwaP2FE9ZwUL8CbRqOutiffyCpurKncvNeDxpRIAIdtrXAy/aYkh/jcWUKYFccJKwPaknBfSJZ/3sGJCMQj8Ho5+fvRpGNV5F5JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=2wu2Feq0; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 29E992A7592;
	Wed, 13 Aug 2025 15:35:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1755095713;
	bh=IqEOpZB4veF76duSJfeDI+f+5ipjG8gmtYr6kJ9a5sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=2wu2Feq0RiGtcQiGKIVEBdFvxdcFVKXJg1ni726uh7Ha1y84ZVS+noHvbbOAhqZfI
	 g+mejgQQ9sq2GYv94wj797w2T6bkCDLHiFD0efhh3x8DuoCQoBqwCpjE0/txgolNqE
	 jI0eWCp+w2PTI4zZznuTS3jR38Royx1pQdHve9vI=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v2 03/16] btrfs: allow remapped chunks to have zero stripes
Date: Wed, 13 Aug 2025 15:34:45 +0100
Message-ID: <20250813143509.31073-4-mark@harmstone.com>
In-Reply-To: <20250813143509.31073-1-mark@harmstone.com>
References: <20250813143509.31073-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

When a chunk has been fully remapped, we are going to set its
num_stripes to 0, as it will no longer represent a physical location on
disk.

Change tree-checker to allow for this, and fix a couple of
divide-by-zeroes seen elsewhere.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/tree-checker.c | 63 ++++++++++++++++++++++++++++-------------
 fs/btrfs/volumes.c      |  8 +++++-
 2 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index ca898b1f12f1..20bfe333ffdd 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -815,6 +815,39 @@ static void chunk_err(const struct btrfs_fs_info *fs_info,
 	va_end(args);
 }
 
+static bool valid_stripe_count(u64 profile, u16 num_stripes,
+			       u16 sub_stripes)
+{
+	switch (profile) {
+	case BTRFS_BLOCK_GROUP_RAID10:
+		return sub_stripes ==
+			btrfs_raid_array[BTRFS_RAID_RAID10].sub_stripes;
+	case BTRFS_BLOCK_GROUP_RAID1:
+		return num_stripes ==
+			btrfs_raid_array[BTRFS_RAID_RAID1].devs_min;
+	case BTRFS_BLOCK_GROUP_RAID1C3:
+		return num_stripes ==
+			btrfs_raid_array[BTRFS_RAID_RAID1C3].devs_min;
+	case BTRFS_BLOCK_GROUP_RAID1C4:
+		return num_stripes ==
+			btrfs_raid_array[BTRFS_RAID_RAID1C4].devs_min;
+	case BTRFS_BLOCK_GROUP_RAID5:
+		return num_stripes >=
+			btrfs_raid_array[BTRFS_RAID_RAID5].devs_min;
+	case BTRFS_BLOCK_GROUP_RAID6:
+		return num_stripes >=
+			btrfs_raid_array[BTRFS_RAID_RAID6].devs_min;
+	case BTRFS_BLOCK_GROUP_DUP:
+		return num_stripes ==
+			btrfs_raid_array[BTRFS_RAID_DUP].dev_stripes;
+	case 0: /* SINGLE */
+		return num_stripes ==
+			btrfs_raid_array[BTRFS_RAID_SINGLE].dev_stripes;
+	default:
+		BUG();
+	}
+}
+
 /*
  * The common chunk check which could also work on super block sys chunk array.
  *
@@ -838,6 +871,7 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
 	u64 features;
 	u32 chunk_sector_size;
 	bool mixed = false;
+	bool remapped;
 	int raid_index;
 	int nparity;
 	int ncopies;
@@ -861,12 +895,14 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
 	ncopies = btrfs_raid_array[raid_index].ncopies;
 	nparity = btrfs_raid_array[raid_index].nparity;
 
-	if (unlikely(!num_stripes)) {
+	remapped = type & BTRFS_BLOCK_GROUP_REMAPPED;
+
+	if (unlikely(!remapped && !num_stripes)) {
 		chunk_err(fs_info, leaf, chunk, logical,
 			  "invalid chunk num_stripes, have %u", num_stripes);
 		return -EUCLEAN;
 	}
-	if (unlikely(num_stripes < ncopies)) {
+	if (unlikely(num_stripes != 0 && num_stripes < ncopies)) {
 		chunk_err(fs_info, leaf, chunk, logical,
 			  "invalid chunk num_stripes < ncopies, have %u < %d",
 			  num_stripes, ncopies);
@@ -964,22 +1000,9 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
 		}
 	}
 
-	if (unlikely((type & BTRFS_BLOCK_GROUP_RAID10 &&
-		      sub_stripes != btrfs_raid_array[BTRFS_RAID_RAID10].sub_stripes) ||
-		     (type & BTRFS_BLOCK_GROUP_RAID1 &&
-		      num_stripes != btrfs_raid_array[BTRFS_RAID_RAID1].devs_min) ||
-		     (type & BTRFS_BLOCK_GROUP_RAID1C3 &&
-		      num_stripes != btrfs_raid_array[BTRFS_RAID_RAID1C3].devs_min) ||
-		     (type & BTRFS_BLOCK_GROUP_RAID1C4 &&
-		      num_stripes != btrfs_raid_array[BTRFS_RAID_RAID1C4].devs_min) ||
-		     (type & BTRFS_BLOCK_GROUP_RAID5 &&
-		      num_stripes < btrfs_raid_array[BTRFS_RAID_RAID5].devs_min) ||
-		     (type & BTRFS_BLOCK_GROUP_RAID6 &&
-		      num_stripes < btrfs_raid_array[BTRFS_RAID_RAID6].devs_min) ||
-		     (type & BTRFS_BLOCK_GROUP_DUP &&
-		      num_stripes != btrfs_raid_array[BTRFS_RAID_DUP].dev_stripes) ||
-		     ((type & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0 &&
-		      num_stripes != btrfs_raid_array[BTRFS_RAID_SINGLE].dev_stripes))) {
+	if (!remapped &&
+	    !valid_stripe_count(type & BTRFS_BLOCK_GROUP_PROFILE_MASK,
+				num_stripes, sub_stripes)) {
 		chunk_err(fs_info, leaf, chunk, logical,
 			"invalid num_stripes:sub_stripes %u:%u for profile %llu",
 			num_stripes, sub_stripes,
@@ -1003,11 +1026,11 @@ static int check_leaf_chunk_item(struct extent_buffer *leaf,
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	int num_stripes;
 
-	if (unlikely(btrfs_item_size(leaf, slot) < sizeof(struct btrfs_chunk))) {
+	if (unlikely(btrfs_item_size(leaf, slot) < offsetof(struct btrfs_chunk, stripe))) {
 		chunk_err(fs_info, leaf, chunk, key->offset,
 			"invalid chunk item size: have %u expect [%zu, %u)",
 			btrfs_item_size(leaf, slot),
-			sizeof(struct btrfs_chunk),
+			offsetof(struct btrfs_chunk, stripe),
 			BTRFS_LEAF_DATA_SIZE(fs_info));
 		return -EUCLEAN;
 	}
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f4d1527f265e..c95f83305c82 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6145,6 +6145,12 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 		goto out_free_map;
 	}
 
+	/* avoid divide by zero on fully-remapped chunks */
+	if (map->num_stripes == 0) {
+		ret = -EOPNOTSUPP;
+		goto out_free_map;
+	}
+
 	offset = logical - map->start;
 	length = min_t(u64, map->start + map->chunk_len - logical, length);
 	*length_ret = length;
@@ -6965,7 +6971,7 @@ u64 btrfs_calc_stripe_length(const struct btrfs_chunk_map *map)
 {
 	const int data_stripes = calc_data_stripes(map->type, map->num_stripes);
 
-	return div_u64(map->chunk_len, data_stripes);
+	return data_stripes ? div_u64(map->chunk_len, data_stripes) : 0;
 }
 
 #if BITS_PER_LONG == 32
-- 
2.49.1


