Return-Path: <linux-btrfs+bounces-7158-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 471CB9502D5
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 12:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5ECA2822FC
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 10:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173EE19AA63;
	Tue, 13 Aug 2024 10:49:44 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07A623D0;
	Tue, 13 Aug 2024 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546183; cv=none; b=G5HRFFWlLAprmWnyZyVdftEzC7h7vWIvhJxnPXZNBCIFtlWP6Upbrttbnl8aR3jSYk20kHEQT5qp1B5mttxx75Oo6UIk0bqzQiGjepPO/iDZaCk2TZQ4X2vyNiOMKTvbsxBOBW/wDrg4EXlXDwBUsoUGFeD2HdMCfwZL5eoiFsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546183; c=relaxed/simple;
	bh=2bAnjcylwCIbEgunZmUYly7eRS7HTnWhdO9hyO2NFAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jlx3tl/ARvcCoC+2rwvUgPm7SCTrVCOcby/gYt66xQn2T9ZKulaBRqzL705UTbQimTKT+xIgujEhV1+M1YlmdaUrIwH2jDejZ4uCUTJcJynSs0nyL9k5DOFKEj3koVq84PVqMkTR8zu+A5XqC9hl2wYYTEX2nKbtkkOmokNhMFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f04c29588so1629295e87.3;
        Tue, 13 Aug 2024 03:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723546177; x=1724150977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUm/bEXImaEK1obrlqGtsRYLmCBpTLTnHcA0pud0em4=;
        b=Y3280MklEv5LPlKZR4rUey0CuK6dJ2pu5xfhP4SeT6GpdM32eiTqQvJ8BBreObrnF9
         +F0navCBBXlhyTagIzbZbJMWWG0CydBU+2pCrFB6kyIsBQKdXleUW2ct/1MyHGg813fd
         TWPQQm8OAl32DoMxlRX4Ns6G/TvuA62KLsxMz3xVmUYs241wwfi9cT4zEDEtlrryj4Ef
         VIIKGBoFcXqxF13z5slDEIpjWjwyuEOUWtnip7AktxRz5Yuh2V6YaRisHX3uWJ9KhxDN
         rr8UyKrLqqjMBYR2UlTvyqM/Yk1dWWp+e4dBUeEJiN5BnGNn8rhvr1TEzFIsaclNsHvx
         +eZA==
X-Forwarded-Encrypted: i=1; AJvYcCWol0nensxEzqX3Av9+21/iMzrFn+hR/hpC/2XWL5SSWU1A7sE2dMWD59FvhVGHzppMmZpFQWPcPAkEt79X6XdzWiatGOLXPmckLPH+rNOSyrZYF6wTvq7K0c40P12+na0kZrN++qHFutE=
X-Gm-Message-State: AOJu0YzBcdXEdC35ngExcfZAR38xoETN3yy/3xldJWWP3eGoEHi4KuhU
	MHfZcdJaDceNlo1Q1qgBOZPMdTAGxUBd1AYJjfgC1WAglIU3fB/B
X-Google-Smtp-Source: AGHT+IHFz76jpw0cuOkw55EbndtRrNzhWyNedTeXoCWLJpudYR4McHuWZWp2bJyFKaWegBlDp9CVDg==
X-Received: by 2002:a05:6512:685:b0:52c:db04:5a57 with SMTP id 2adb3069b0e04-5321365dccamr1956558e87.31.1723546176526;
        Tue, 13 Aug 2024 03:49:36 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f732f200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f732:f200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c775c912sm131513875e9.45.2024.08.13.03.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 03:49:36 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] btrfs: reduce chunk_map lookups in btrfs_map_block
Date: Tue, 13 Aug 2024 12:49:20 +0200
Message-ID: <bc73d318c7f24196cdc7305b6a6ce516fb4fc81d.1723546054.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Currently we're calling btrfs_num_copies() before btrfs_get_chunk_map() in
btrfs_map_block(). But btrfs_num_copies() itself does a chunk map lookup
to be able to calculate the number of copies.

So split out the code getting the number of copies from btrfs_num_copies()
into a helper called btrfs_chunk_map_num_copies() and directly call it
from btrfs_map_block() and btrfs_num_copies().

This saves us one rbtree lookup per btrfs_map_block() invocation.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Changes in v2:
- Added Reviewed-bys
- Reflowed comments
- Moved non RAID56 cases to the end without an if
Link to v1:
https://lore.kernel.org/all/20240812165931.9106-1-jth@kernel.org/

 fs/btrfs/volumes.c | 58 +++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e07452207426..796f6350a017 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5781,38 +5781,44 @@ void btrfs_mapping_tree_free(struct btrfs_fs_info *fs_info)
 	write_unlock(&fs_info->mapping_tree_lock);
 }
 
+static int btrfs_chunk_map_num_copies(struct btrfs_chunk_map *map)
+{
+	enum btrfs_raid_types index = btrfs_bg_flags_to_raid_index(map->type);
+
+	if (map->type & BTRFS_BLOCK_GROUP_RAID5)
+		return 2;
+
+	/*
+	 * There could be two corrupted data stripes, we need to loop
+	 * retry in order to rebuild the correct data.
+	 *
+	 * Fail a stripe at a time on every retry except the stripe
+	 * under reconstruction.
+	 */
+	if (map->type & BTRFS_BLOCK_GROUP_RAID6)
+		return map->num_stripes;
+
+	/* Non-RAID56, use their ncopies from btrfs_raid_array. */
+	return btrfs_raid_array[index].ncopies;
+}
+
 int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 {
 	struct btrfs_chunk_map *map;
-	enum btrfs_raid_types index;
-	int ret = 1;
+	int ret;
 
 	map = btrfs_get_chunk_map(fs_info, logical, len);
 	if (IS_ERR(map))
 		/*
-		 * We could return errors for these cases, but that could get
-		 * ugly and we'd probably do the same thing which is just not do
-		 * anything else and exit, so return 1 so the callers don't try
-		 * to use other copies.
+		 * We could return errors for these cases, but that
+		 * could get ugly and we'd probably do the same thing
+		 * which is just not do anything else and exit, so
+		 * return 1 so the callers don't try to use other
+		 * copies.
 		 */
 		return 1;
 
-	index = btrfs_bg_flags_to_raid_index(map->type);
-
-	/* Non-RAID56, use their ncopies from btrfs_raid_array. */
-	if (!(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK))
-		ret = btrfs_raid_array[index].ncopies;
-	else if (map->type & BTRFS_BLOCK_GROUP_RAID5)
-		ret = 2;
-	else if (map->type & BTRFS_BLOCK_GROUP_RAID6)
-		/*
-		 * There could be two corrupted data stripes, we need
-		 * to loop retry in order to rebuild the correct data.
-		 *
-		 * Fail a stripe at a time on every retry except the
-		 * stripe under reconstruction.
-		 */
-		ret = map->num_stripes;
+	ret = btrfs_chunk_map_num_copies(map);
 	btrfs_free_chunk_map(map);
 	return ret;
 }
@@ -6462,14 +6468,14 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	io_geom.stripe_index = 0;
 	io_geom.op = op;
 
-	num_copies = btrfs_num_copies(fs_info, logical, fs_info->sectorsize);
-	if (io_geom.mirror_num > num_copies)
-		return -EINVAL;
-
 	map = btrfs_get_chunk_map(fs_info, logical, *length);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
+	num_copies = btrfs_chunk_map_num_copies(map);
+	if (io_geom.mirror_num > num_copies)
+		return -EINVAL;
+
 	map_offset = logical - map->start;
 	io_geom.raid56_full_stripe_start = (u64)-1;
 	max_len = btrfs_max_io_len(map, map_offset, &io_geom);
-- 
2.43.0


