Return-Path: <linux-btrfs+bounces-19305-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA909C822BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 19:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 62D5E3488C6
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 18:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDFF72628;
	Mon, 24 Nov 2025 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="wcuJd7Jc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456C92D3727
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 18:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764010416; cv=none; b=FnS/IHeW/6a2r3AwaJaFffvKxE3jADfMKyLX4z0aD0WfEo/hnDAgsacc2uY2HNQ2xkPipYCSJ+MyN6/OfK4O9ZpgQXrZXr7GAxmFqcWjd/FX9BDkWKdAMbqwhwA8J9DNSqC22Lhx9RxPsLvpPnOmCmPpkSwPh9uImye8sQkMA1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764010416; c=relaxed/simple;
	bh=1B7p17SohIL3kMeGImHEjGVA6AFmnSx8rFlV9PyKq68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=fnv0PMiGe1rDqeDFjvYWb/mx4iFaSLvQG8qBYEHNNUY9JF3y/PPq+rAjhTWveU2uKiyfsECPsBBZtM0B/sQWEXzhaigDh46d+vmsLKzYKnpsUEj3qTYMyD4bBaqoNBcpt/8QOpy5arV+a1V6Vw0HoQLZpQYaVtWilFZlsQve+oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=wcuJd7Jc; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id E159E2DEC5B;
	Mon, 24 Nov 2025 18:53:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1764010410;
	bh=mkxRaFDW6jJk2x5y0gshWVdL5W6kAnz9oKDhI3MhIVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wcuJd7JcuQvA0k0Ce/q25z+ddY85DlbihdlipZ7k1khCsxP+lgdcD7JIBXGfElfW3
	 mYpx8sdiGlcHuCy+BgFSv5XUIQs/XVzWmJPArJfHfAzwGNcs6kyPHf0an0dMjDniYl
	 i97IZuATSBmLM7/x0B2yNbbdWl6rQyluxq8ofUlA=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v7 03/16] btrfs: allow remapped chunks to have zero stripes
Date: Mon, 24 Nov 2025 18:52:55 +0000
Message-ID: <20251124185335.16556-4-mark@harmstone.com>
In-Reply-To: <20251124185335.16556-1-mark@harmstone.com>
References: <20251124185335.16556-1-mark@harmstone.com>
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

Change tree-checker to allow for this, and fix read_one_chunk() to avoid
a divide by zero.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
Reviewed-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/tree-checker.c | 65 ++++++++++++++++++++++++++++-------------
 fs/btrfs/volumes.c      |  7 ++++-
 2 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 21bf57e81e1a..bce0d86b256f 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -816,6 +816,41 @@ static void chunk_err(const struct btrfs_fs_info *fs_info,
 	va_end(args);
 }
 
+static bool valid_stripe_count(u64 profile, u16 num_stripes,
+			       u16 sub_stripes)
+{
+	switch (profile) {
+	case BTRFS_BLOCK_GROUP_RAID0:
+		return true;
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
@@ -839,6 +874,7 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
 	u64 features;
 	u32 chunk_sector_size;
 	bool mixed = false;
+	bool remapped;
 	int raid_index;
 	int nparity;
 	int ncopies;
@@ -862,12 +898,14 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
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
@@ -965,22 +1003,9 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
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
@@ -1004,11 +1029,11 @@ static int check_leaf_chunk_item(struct extent_buffer *leaf,
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
index c036d341f5c2..a3e93fc795b2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7046,7 +7046,12 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 	 */
 	map->sub_stripes = btrfs_raid_array[index].sub_stripes;
 	map->verified_stripes = 0;
-	map->stripe_size = btrfs_calc_stripe_length(map);
+
+	if (num_stripes > 0)
+		map->stripe_size = btrfs_calc_stripe_length(map);
+	else
+		map->stripe_size = 0;
+
 	for (i = 0; i < num_stripes; i++) {
 		map->stripes[i].physical =
 			btrfs_stripe_offset_nr(leaf, chunk, i);
-- 
2.51.0


