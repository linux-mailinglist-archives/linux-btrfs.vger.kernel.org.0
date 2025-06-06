Return-Path: <linux-btrfs+bounces-14524-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C1DACFD55
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 09:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACDB9167A39
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 07:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6741F1E2853;
	Fri,  6 Jun 2025 07:17:53 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E6F3596A
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 07:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749194273; cv=none; b=LAp4MhwiQ+ZuuhHrHhBzkVS28/F3LF/geShCbebgbS/JHs/yoWYiJgPPgELAeP4lg2tXoll2gtPb9SDJ3iXDlT99BrP05rrA5eYgMYpX6rgr8uuzqWohV7agThqFg9ecC/rk6uUR9T+A/qSVjWw1QjuCAb9aeHMldoO44XYYHtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749194273; c=relaxed/simple;
	bh=PquHxi4oJtinRNbTK0HHldrpy5WloTkTYPBn0u7kH/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l0Vi85Z0OksiM7y0W91exrzUKNAtzdYGI1yidcTbdfwcupH2jvFRtx+ifw0WAXxbqNRdLpv6bDKWDslme6XAyIV1CMc1uXbzdWSdvvZG0rTzFfij/B1wp13FR5fEs5wuczPVqMXN8l6reLUeH89YKWDDj2zw0zQUb+KKz/7oaS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450ce671a08so11219395e9.3
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Jun 2025 00:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749194269; x=1749799069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fm8ROhNCBhuDWMTr/abEozFxnCIq/qBAsH7qm4Lv1KA=;
        b=SWmUbXrGSAyUeFARxCvtEoWs1atWb40Z3DOGx+F2mysZWrHpEe2UL8KMNJGkNL6hoc
         wOfSRBTFAxsVcoWXEMYWHFL62WEcb7cbH/gSKlErk/7GufNMyOhsZM6HTab/t03PJnyf
         jA6d7/0MgyMctdq/IXpBkUy0lK26tHLoSmfGHjn5YJLSfpa0/aJNzqupElitDvORvhdc
         9DLcbujn5tLHJIH1P/iT9QoHtPb2dqWTbrhuo8Prodst1XkDItp0E9CXxpDvkXbQH/Yw
         FeYsuUAI+FYPbWs7rr3hbXLF6oclJKmpIg1Xby7rdDSjIM5ImaC1k03MzuDiOmnDNCtl
         Y1AQ==
X-Gm-Message-State: AOJu0YyRa+3KOkUTJAvqA4C0q7UogZr4ZTrHJMp0EXYHGKab37erYpXX
	5rAK0ZGqnf3nvVHwPHF0v2fHvbpeu4PFVZpQ3n1QG35Rqb3V1o+raHUOMovL1g==
X-Gm-Gg: ASbGncsM+HUnaychkllcuBD+e9yVhJP/J+luQtCUtRWZtpUyDxezUAD0Ylibkwh+Zv1
	ebo/Oq/aas2oE0vmjrrQ+dpsRvTMfUpHYh50mQkVYIP+MuR1xvrP5KMSiJxSd6/Jp5YHdu/SbdP
	WpqyfVYCpdLvcwx5M0PRdI1/27WoiuxAlwAGAOWUbLvFdUcLgxCrUvBc51rwc6scqYe1V5KMlBj
	WpWN2DJA26rcn4LT7W6GGWT1+GUpiba8EvMsaQeLuuNqUxZq4FnXoUQFotHW1ZXvUs9jfeNgSUs
	F/+YvTFrhbZFouuX54zqTMVGN8fKaIaPqfmXbXV6Ds6au+7smIk5b76KlbrnSqJIEWJiyalmhCe
	FR7ItAuLYU846b/J0Cfdv4ksE+KrNqBNHotqSgK8s6vxpDKQ53Q==
X-Google-Smtp-Source: AGHT+IFITtiBb3YIFsJ6eWukSMC2iLW3aeut4EcXDFU+ntGfgbuva8MBg/FohhuGGBoRx2ocERAAow==
X-Received: by 2002:a05:6000:2c0f:b0:3a5:2257:17b4 with SMTP id ffacd0b85a97d-3a5319b5aa1mr2001715f8f.55.1749194269151;
        Fri, 06 Jun 2025 00:17:49 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f734a1006f354b1e839513ef.dip0.t-ipconnect.de. [2003:f6:f734:a100:6f35:4b1e:8395:13ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452730b9b3esm11760405e9.25.2025.06.06.00.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 00:17:48 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3] btrfs: zoned: fix alloc_offset calculation for partly conventional block groups
Date: Fri,  6 Jun 2025 09:17:41 +0200
Message-ID: <20250606071741.409240-1-jth@kernel.org>
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
Changes to v2:
- Fix kbuild error on 32bit due to modulos

Changes to v1:
- Fix kbuild error on 32bit due to divisions
---
 fs/btrfs/zoned.c | 86 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 72 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 4e122d6c19c0..79b72f6673e7 100644
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
+			div_u64_rem(stripe_nr, map->num_stripes, &stripe_index);
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
@@ -1550,6 +1581,29 @@ static int btrfs_load_block_group_raid10(struct btrfs_block_group *bg,
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
+			div_u64_rem(stripe_nr,
+				    (map->num_stripes / map->sub_stripes),
+				    &stripe_index);
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
@@ -1638,18 +1692,22 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
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


