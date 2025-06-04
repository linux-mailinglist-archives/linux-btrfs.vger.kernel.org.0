Return-Path: <linux-btrfs+bounces-14453-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFDFACDC08
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 12:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201DB1667DB
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 10:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E948428C5DA;
	Wed,  4 Jun 2025 10:37:41 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE713D3B8
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749033461; cv=none; b=FecmIhaNN86tsTOTsWO9Hv7st/f8ahxzTLxjKunZ3nfSl29knpspgDj/zdpdoSesugtXfVB/q5hY+zryzzF2Jj4D0TCxdk9cA8lS4lUHfryK9DFvyy2cpNQ/XMRfPY7lV+klcY+UAGMBHDE2N7IF9ZcxbIU5/8CTQooo0VnFTmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749033461; c=relaxed/simple;
	bh=pyb/ZxeEyaO9Ctfs9p0Nie/h1rAChgz09IJq2xadMYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bLQ5SGxYiSnlQzAKuXNrHsyAWHk9XG3i6H42nWzhYy7WJXrodrdDyVBKMrvlr4VkMsssWbCGPjkJmYBsfE7r3JamX0hi1fjw0atli5duW/UIcAXbmF9GVO6Vb7EHVwcfPeDhU+j/cSO2UGOv/kx+iDYzlrjsub5FGt6HBMYJN1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so77328255e9.2
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Jun 2025 03:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749033458; x=1749638258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YwfNS1q8D+yAZ/SIrcUPIUi0P9iWkJK0yOFaI6KQfXU=;
        b=qdT4ZVqtpUDmpSomMBc2djtKohKDLityJTmuyUr34oOsoe0CY1A6GzJuhekFQIRiVA
         BnXJ5BSIqyZUiXRC7/hFLoGGI8aAdZ+CTCfjcxJqYrSqGwhrYusP/Y1tKTFDEQkS5/Td
         xdQ9OCZtQBDtIqV7ORSUaheqW3ZavlaQ2ArZTlGPm48T2KI2+KuOf7S6dOJXWqUosR00
         LgPJMDdyFJQPq+B+1uLy4ARcEpqPjWXKI0UZTiiA3EBHR6oNnrnpuqZn4tVoDCvtgn3w
         6Helo8yWSKBxiiGQ4AEBBqZKNSSxKYn1hckBu9139VawdzKWpx2xWQZA0eTQpWdRgvzS
         rmJA==
X-Gm-Message-State: AOJu0Yx5pr/b8SW2I3CzXGi0GK1dbXIQl8YHU7ia6Thk/DYUu/524iL6
	xPuhV/JxV3Ftpp6w8EP1JefMlSCH3mF/I75uTov0D7K8geu1MRn5ncb7tExWNA==
X-Gm-Gg: ASbGncsLT8EWhuWmH/31U/aj2ed6+Had9TsPe/Ws8hgi2U0v89bS1LRPk3fq2zzbZ0Q
	7CDbsnVK+0Hf30eq/Kse+HFb2VFXCZ6jpWuTFcom2DIpo1FtuV7+RS5x0U8wk8RAN+Yb228AeB5
	PimoTo+4GNBaSOXe21ts7aNrQrtPxMR8jPgHkpmw3ayPpJcPJCT2IznCLXkPk8kM6I6sXS9TgJz
	v/RtygBn65Xd0LUF9vXxUaOA4OwVQjI1l5X+eAb+LNAgD+d6vLE0Pqvf36h5NuHy4dg10+fvAba
	cy7PEVN7ZrUB1MGXbK+jwD2KwKVM30TK0po6KW5rOeCKcfgGtYehoqleQWds3Z5Er8ayXODTzLa
	EM2F/9+wVlD3I9DCQbN52mQC3LRvhgtne51GBD7WPZ3asAKblUg==
X-Google-Smtp-Source: AGHT+IEn4DFbREP3bm9kinAAXxYB/4+qTpTEtfO8Dr0ByozXbajSDF0bZNhS2MNaPABaEtyFhagDdg==
X-Received: by 2002:a05:600c:4f94:b0:43c:fcbc:9680 with SMTP id 5b1f17b1804b1-451f0b24269mr18022825e9.25.1749033457596;
        Wed, 04 Jun 2025 03:37:37 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f734a1006f354b1e839513ef.dip0.t-ipconnect.de. [2003:f6:f734:a100:6f35:4b1e:8395:13ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000e3esm193933515e9.22.2025.06.04.03.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 03:37:37 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: zoned: fix alloc_offset calculation for partly conventional block groups
Date: Wed,  4 Jun 2025 12:37:30 +0200
Message-ID: <20250604103730.358907-1-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When one of two zones composing a DUP block group is a conventional zone,
we have the zone_info[i]->alloc_offset = WP_CONVENTIONAL. That will, of
course, not match the write pointer of the other zone, and fails that
block group.

This commit solves that issue by properly recovering the emulated write
pointer from the last allocated extent. The offset for the SINGLE, DUP,
and RAID1 are straight-forward: it is same as the end of last allocated
extent. The RAID0 and RAID10 are a bit tricky that we need to do the math
of striping.

This is the kernel equivalent of Naohiro's user-space commit:
1e85aa96e107 ("btrfs-progs: zoned: fix alloc_offset calculation for partly conventional block groups")

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 85 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 71 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 4e122d6c19c0..69f1a6d36add 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1404,7 +1404,8 @@ static int btrfs_load_block_group_single(struct btrfs_block_group *bg,
 static int btrfs_load_block_group_dup(struct btrfs_block_group *bg,
 				      struct btrfs_chunk_map *map,
 				      struct zone_info *zone_info,
-				      unsigned long *active)
+				      unsigned long *active,
+				      u64 last_alloc)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
 
@@ -1427,6 +1428,13 @@ static int btrfs_load_block_group_dup(struct btrfs_block_group *bg,
 			  zone_info[1].physical);
 		return -EIO;
 	}
+
+	if (zone_info[0].alloc_offset == WP_CONVENTIONAL)
+		zone_info[0].alloc_offset = last_alloc;
+
+	if (zone_info[1].alloc_offset == WP_CONVENTIONAL)
+		zone_info[1].alloc_offset = last_alloc;
+
 	if (zone_info[0].alloc_offset != zone_info[1].alloc_offset) {
 		btrfs_err(bg->fs_info,
 			  "zoned: write pointer offset mismatch of zones in DUP profile");
@@ -1447,7 +1455,8 @@ static int btrfs_load_block_group_dup(struct btrfs_block_group *bg,
 static int btrfs_load_block_group_raid1(struct btrfs_block_group *bg,
 					struct btrfs_chunk_map *map,
 					struct zone_info *zone_info,
-					unsigned long *active)
+					unsigned long *active,
+					u64 last_alloc)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
 	int i;
@@ -1462,10 +1471,12 @@ static int btrfs_load_block_group_raid1(struct btrfs_block_group *bg,
 	bg->zone_capacity = min_not_zero(zone_info[0].capacity, zone_info[1].capacity);
 
 	for (i = 0; i < map->num_stripes; i++) {
-		if (zone_info[i].alloc_offset == WP_MISSING_DEV ||
-		    zone_info[i].alloc_offset == WP_CONVENTIONAL)
+		if (zone_info[i].alloc_offset == WP_MISSING_DEV)
 			continue;
 
+		if (zone_info[i].alloc_offset == WP_CONVENTIONAL)
+			zone_info[i].alloc_offset = last_alloc;
+
 		if ((zone_info[0].alloc_offset != zone_info[i].alloc_offset) &&
 		    !btrfs_test_opt(fs_info, DEGRADED)) {
 			btrfs_err(fs_info,
@@ -1495,7 +1506,8 @@ static int btrfs_load_block_group_raid1(struct btrfs_block_group *bg,
 static int btrfs_load_block_group_raid0(struct btrfs_block_group *bg,
 					struct btrfs_chunk_map *map,
 					struct zone_info *zone_info,
-					unsigned long *active)
+					unsigned long *active,
+					u64 last_alloc)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
 
@@ -1506,10 +1518,29 @@ static int btrfs_load_block_group_raid0(struct btrfs_block_group *bg,
 	}
 
 	for (int i = 0; i < map->num_stripes; i++) {
-		if (zone_info[i].alloc_offset == WP_MISSING_DEV ||
-		    zone_info[i].alloc_offset == WP_CONVENTIONAL)
+		if (zone_info[i].alloc_offset == WP_MISSING_DEV)
 			continue;
 
+		if (zone_info[i].alloc_offset == WP_CONVENTIONAL) {
+			u64 stripe_nr, full_stripe_nr;
+			u64 stripe_offset;
+			int stripe_index;
+
+			stripe_nr = last_alloc / map->stripe_size;
+			stripe_offset = stripe_nr * map->stripe_size;
+			full_stripe_nr = stripe_nr / map->num_stripes;
+			stripe_index = stripe_nr % map->num_stripes;
+
+			zone_info[i].alloc_offset =
+				full_stripe_nr * map->stripe_size;
+
+			if (stripe_index > i)
+				zone_info[i].alloc_offset += map->stripe_size;
+			else if (stripe_index == i)
+				zone_info[i].alloc_offset +=
+					(last_alloc - stripe_offset);
+		}
+
 		if (test_bit(0, active) != test_bit(i, active)) {
 			if (!btrfs_zone_activate(bg))
 				return -EIO;
@@ -1527,7 +1558,8 @@ static int btrfs_load_block_group_raid0(struct btrfs_block_group *bg,
 static int btrfs_load_block_group_raid10(struct btrfs_block_group *bg,
 					 struct btrfs_chunk_map *map,
 					 struct zone_info *zone_info,
-					 unsigned long *active)
+					 unsigned long *active,
+					 u64 last_alloc)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
 
@@ -1538,8 +1570,7 @@ static int btrfs_load_block_group_raid10(struct btrfs_block_group *bg,
 	}
 
 	for (int i = 0; i < map->num_stripes; i++) {
-		if (zone_info[i].alloc_offset == WP_MISSING_DEV ||
-		    zone_info[i].alloc_offset == WP_CONVENTIONAL)
+		if (zone_info[i].alloc_offset == WP_MISSING_DEV)
 			continue;
 
 		if (test_bit(0, active) != test_bit(i, active)) {
@@ -1550,6 +1581,28 @@ static int btrfs_load_block_group_raid10(struct btrfs_block_group *bg,
 				set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &bg->runtime_flags);
 		}
 
+		if (zone_info[i].alloc_offset == WP_CONVENTIONAL) {
+			u64 stripe_nr, full_stripe_nr;
+			u64 stripe_offset;
+			int stripe_index;
+
+			stripe_nr = last_alloc / map->stripe_size;
+			stripe_offset = stripe_nr * map->stripe_size;
+			full_stripe_nr = stripe_nr /
+				(map->num_stripes / map->sub_stripes);
+			stripe_index = stripe_nr %
+				(map->num_stripes / map->sub_stripes);
+
+			zone_info[i].alloc_offset =
+				full_stripe_nr * map->stripe_size;
+
+			if (stripe_index > (i / map->sub_stripes))
+				zone_info[i].alloc_offset += map->stripe_size;
+			else if (stripe_index == (i / map->sub_stripes))
+				zone_info[i].alloc_offset +=
+					(last_alloc - stripe_offset);
+		}
+
 		if ((i % map->sub_stripes) == 0) {
 			bg->zone_capacity += zone_info[i].capacity;
 			bg->alloc_offset += zone_info[i].alloc_offset;
@@ -1638,18 +1691,22 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		ret = btrfs_load_block_group_single(cache, &zone_info[0], active);
 		break;
 	case BTRFS_BLOCK_GROUP_DUP:
-		ret = btrfs_load_block_group_dup(cache, map, zone_info, active);
+		ret = btrfs_load_block_group_dup(cache, map, zone_info, active,
+						 last_alloc);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID1:
 	case BTRFS_BLOCK_GROUP_RAID1C3:
 	case BTRFS_BLOCK_GROUP_RAID1C4:
-		ret = btrfs_load_block_group_raid1(cache, map, zone_info, active);
+		ret = btrfs_load_block_group_raid1(cache, map, zone_info,
+						   active, last_alloc);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID0:
-		ret = btrfs_load_block_group_raid0(cache, map, zone_info, active);
+		ret = btrfs_load_block_group_raid0(cache, map, zone_info,
+						   active, last_alloc);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID10:
-		ret = btrfs_load_block_group_raid10(cache, map, zone_info, active);
+		ret = btrfs_load_block_group_raid10(cache, map, zone_info,
+						    active, last_alloc);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID5:
 	case BTRFS_BLOCK_GROUP_RAID6:
-- 
2.49.0


