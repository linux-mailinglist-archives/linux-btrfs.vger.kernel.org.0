Return-Path: <linux-btrfs+bounces-14477-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480B4ACECB1
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 11:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD5F97A61B1
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 09:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA571FC0E6;
	Thu,  5 Jun 2025 09:18:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C043C2F
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749115113; cv=none; b=rWworgqJsDVfScIMb5bjYUdFu/9gtK5vZXTkdNVFHRWrZZsKNrpIlsP2E/kMzpzPmHtjjIYztkD6aJIN3wF3Pm6M6/4yyl1AWcJKpXoDawjBiCy8SFXlj2p51q4qvCaka7yAA1JScSLBgsXZGkdTOxVXRczOEtagMkK89cZHQAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749115113; c=relaxed/simple;
	bh=mAg7fry4tWL6psPLLCMyAAGEmxKCQFBQpdA9x5p6Afw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mjKKMso0g/mjMvlk9Hg7x9WQhXZcAwMLm6aCqWJ08aUkz3tA8Ku/rhqQv3gF538QuE08E8nfp4enVSLYmgwaJ6gQ2PgFTEwSdcA6lm1UeR4QQ4mJj8n0rCnPosHoJXCZS3HDoHN2kNqTwRGL/jBDodQ7axXu35QvpRhivpv4ROI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32a63ff3bdfso5666211fa.3
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 02:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749115110; x=1749719910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQ2jUsOGPnQ4TrVvX1+a7qcywZQ/QGmYBSp3WyGrgfI=;
        b=rc1r7SNMzlyVLKKrJnP0DtBe53JNMiXHnnb3O4ik9eR00oXw0j2+W0fXJcbXyHGx08
         9C2cTtgGiYeitmjwDqN+X6VJhmRefb5I+xN0wJLJr4VynaI7UwvhDVxAvfx6Z3H0pxXq
         zpe/pArlnT8zVEy7/ue6KrYV5ZrPFLrtfvTLn2maSN/v+awknd+SoUfum8teDPH12y2q
         sst7R05tbMRyVCROnklW5R1uSAYfK2nL8+5MQFCwivPh91W0G48y4AbP/i4tuTbUOlf2
         g2Lyxe90cvECcN7/z5ckXiCJELYzfVn3SmHYT/WN9b6xxTiZz0aRGozD8uGlQh4f68NV
         GFsg==
X-Gm-Message-State: AOJu0YwtxNNXb0ihhMsg/O4l1YjHNqfeqsHDABFXOwvZAJzYlExYoJR1
	gaO5brSRr7DHurvKRfmG2kR/C9Ld8ewc1fQPPj1cMto/K4SKfsfNnoA3VDeQjA==
X-Gm-Gg: ASbGncvd2VdzG0/heB3LU3wKAEMW2P60TdSzCpHdo9BdqLmU/DX6mlcjhXyRRmQYBOc
	h78Ci2K46m6cxDDDLB2I6cm5qYUJ9gMmpnjKjUdCC9I2TYSmCVSNVvH9zCvqRWTH1uw2h4gbV9i
	2HIQ5PNSXydFvwgnTykN6pnBvzwAQAZavayx97b8rd/LbSKnWNZfSoEMBJzG0GRWzt88ftmiAdx
	r0xmI36nwSJ+pBrcR38pzDupxgn3+U4Q8WGCi5nbDGDw4sW8bn8lHFfXR+GmlMyYZ+sKyVkF6Nc
	XMsm+G2yZuX2pCEFMIwHmDm42idrz6RGKjTcQROxRt/WNdXYS8eF6mKdnsaSzSjzszr+tvs9G/7
	E5ImWF4Kvm4qkNGl5nH73x7Y6eI5xvv7WNdZoGco=
X-Google-Smtp-Source: AGHT+IEpmCe1kp6mbXBcrQSCKHra1vASL5DG5smOLelFUqo/JD15fdltEFhevTtoxdKtgAbR7er+IQ==
X-Received: by 2002:a05:6000:381:b0:3a4:f71e:d2e with SMTP id ffacd0b85a97d-3a51d975bb7mr5676622f8f.56.1749115099223;
        Thu, 05 Jun 2025 02:18:19 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f734a1006f354b1e839513ef.dip0.t-ipconnect.de. [2003:f6:f734:a100:6f35:4b1e:8395:13ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f0097210sm23906202f8f.73.2025.06.05.02.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 02:18:18 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] btrfs: zoned: fix alloc_offset calculation for partly conventional block groups
Date: Thu,  5 Jun 2025 11:18:11 +0200
Message-ID: <20250605091811.386815-1-jth@kernel.org>
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
Changes to v1:
- Fix kbuild error on 32bit due to divisions
---
 fs/btrfs/zoned.c | 85 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 71 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 4e122d6c19c0..63d72bd63823 100644
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
+			stripe_nr = div64_u64(last_alloc, map->stripe_size);
+			stripe_offset = stripe_nr * map->stripe_size;
+			full_stripe_nr = div_u64(stripe_nr, map->num_stripes);
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
+			stripe_nr = div64_u64(last_alloc, map->stripe_size);
+			stripe_offset = stripe_nr * map->stripe_size;
+			full_stripe_nr = div_u64(stripe_nr,
+					 map->num_stripes / map->sub_stripes);
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


