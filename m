Return-Path: <linux-btrfs+bounces-18298-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF96C07AC5
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 20:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BBAC3B121E
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 18:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9568F347BB4;
	Fri, 24 Oct 2025 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="ibyvQ+AZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8756A346E6E
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329561; cv=none; b=icdSY/k59yyWhfyhSgWKHOW6J8doj7H3oWbb6c9z0EMAzMQmvr65sxNGdVnmufeBdwpP55QafWegx6c08Un+qH9dFL43M/y8fT6cdbWmZFH2GNz78s1MlTqAwVWT/kWnmVj23f06yeEHNb7g08koR7mW2mOXkzUTDSNCEDQvO6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329561; c=relaxed/simple;
	bh=m/xRnuCZsgf4ObcB7pf0cLqdfRNC2B+VyNDMP49ixW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=rllwVuVT+ZcxBviW0k0BBS8fiuZ/rTQ2spuDAA8gLn0vQpNPvYTiQCkQRg5Ofz1hL6r8gBy0Aw8rLcupjEJuoJFSiW93JjZsrydlSUxbGv8roBJAe1NXJUkADg+XKWoOFdlxMApB3qeyAbmmCWl1Qi5J87AVfDvJ33tu8n/nQhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=ibyvQ+AZ; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 66B222CFE48;
	Fri, 24 Oct 2025 19:12:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1761329550;
	bh=jnbzR4/9hmiMvxToAvoubR+cz4o9b0i+cgt/bcT9+pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ibyvQ+AZpP0t9ypn9gITutLxpdsxhd0JUI+y5Q/lV0cELWhYLysStGwJR3I/Vfpzf
	 NZgTG5Kbi8U+6nxWShp5sDUAYj9W6B23cuuO7gAedDgQeMKih1byi524QKQFdxFlgA
	 mQqaQXBhsn+UooGwbyG/fPYvgDHlNpsw0PyOI6rA=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v4 03/16] btrfs: allow remapped chunks to have zero stripes
Date: Fri, 24 Oct 2025 19:12:04 +0100
Message-ID: <20251024181227.32228-4-mark@harmstone.com>
In-Reply-To: <20251024181227.32228-1-mark@harmstone.com>
References: <20251024181227.32228-1-mark@harmstone.com>
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
---
 fs/btrfs/tree-checker.c | 65 ++++++++++++++++++++++++++++-------------
 fs/btrfs/volumes.c      |  7 ++++-
 2 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 681c5c7fae35..b6827c2a7815 100644
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
index 82b8189f3e81..8a9bff0426ae 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7059,7 +7059,12 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
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
2.49.1


