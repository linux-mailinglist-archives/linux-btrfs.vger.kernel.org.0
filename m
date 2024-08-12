Return-Path: <linux-btrfs+bounces-7144-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1351694F579
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 19:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBB81F2128A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 17:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D101A18785F;
	Mon, 12 Aug 2024 16:59:54 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86DB186E5B;
	Mon, 12 Aug 2024 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481994; cv=none; b=Z1R66fhVfmKfqb9IPzND6nM4E6RSRIFTDqrhYJ709qHlMWIaJuxuPiQmaecZpuhp24cZWb1p1FReWNqQyovBxYFK/v7tecOMNBYEU4C4ISt8Du1x/114DDWv/wPBRR+dDQQ02BFNP+HPNDCavZJe7FUZsf35bLsi3nL2e6TPk80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481994; c=relaxed/simple;
	bh=MWZG/stRZlwSBWX9yPCSHf4vAICXFPCGDCYET2x9MKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R0zRIAFosyy4D5e9Jl3SRzPBmJEnE/z7UbTC6LLS4cZBwraKaXausnpyAW9OHHvi/gSk/8eA87yN9L/ok+5lKwOby1arDUmKTXoC9/d5yLyXcWXB1a2ujDvzh9OAXAILUtdF/lU9usVBYFicxMxDaeGrb9iMiCEqXVaodj7Ccww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bb477e3a6dso4395099a12.0;
        Mon, 12 Aug 2024 09:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481991; x=1724086791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/o1IqV2hgO8RM/6MLdLztA93uxz4FzzAolAt4JwN+e0=;
        b=SMZTsAI5558PpWo/zrURN7JWcTFEwaqcUfZ9w8vO7f4kH3rg1Nb5kV2gyfZcRPyoA7
         ylF6NNLyvcyQULdBIbvwIrvv7evE1qCakXd4jO93+6z55++1zoZQukC4tVgIaPgkj3e/
         SpoFAy2idnDhkP8SseqX061HgCkPKh24yowV/AXMQWFndxuUO38t9teBfCWvemPDyUdY
         sYBt3DEIenV3+Eor1pUusNfjiHAYc19TxXiLaK1F9yB82iyf/bGCePm4E5zExSbUsPr0
         NqEevR+PAq/VETCNvDBkgvwcvJUVZAT/yk9TTMGIr5UvrYhFgDf8jUt3/AmaBRDF8eKA
         hvvA==
X-Forwarded-Encrypted: i=1; AJvYcCVAB/tHfojVQvJ/qrFIU0gtw3UlTNIxSzzY2fe1qaBjp18kYWDeL8Tt1BUqTE+ToWfr/8GbeMc3jiGahrGyA9Gh5MHC4ekq1YNsKJ/I8liS/PsZzNLwHPbG+vs3qJhrx2L4vkQ2MxqJfOw=
X-Gm-Message-State: AOJu0YyMCKX/bPHPhJcKO3Hx13wVe/nWj/ivi5DEjDwfeXr8P6MmyjRb
	2IA7hYRvrochpdvIRYDQ5R804SG/9jpqDt6saNWMN6ei2/seEPe5d7h2mA==
X-Google-Smtp-Source: AGHT+IHw7XaBfNS4pMZ543DETIq182k43CcwQ31/PxFJbOHDuW6srOl/LlmVNpcMTwOEaZc72ChluA==
X-Received: by 2002:a17:907:f18c:b0:a7a:c256:3c5 with SMTP id a640c23a62f3a-a80ed2c4c8amr71517866b.46.1723481990834;
        Mon, 12 Aug 2024 09:59:50 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f732f200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f732:f200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb0e0565sm244050766b.67.2024.08.12.09.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:59:50 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: reduce chunk_map lookups in btrfs_map_block
Date: Mon, 12 Aug 2024 18:59:31 +0200
Message-ID: <20240812165931.9106-1-jth@kernel.org>
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 50 +++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e07452207426..4863bdb4d6f4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5781,10 +5781,33 @@ void btrfs_mapping_tree_free(struct btrfs_fs_info *fs_info)
 	write_unlock(&fs_info->mapping_tree_lock);
 }
 
+static int btrfs_chunk_map_num_copies(struct btrfs_chunk_map *map)
+{
+	enum btrfs_raid_types index = btrfs_bg_flags_to_raid_index(map->type);
+
+	/* Non-RAID56, use their ncopies from btrfs_raid_array. */
+	if (!(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK))
+		return btrfs_raid_array[index].ncopies;
+
+	if (map->type & BTRFS_BLOCK_GROUP_RAID5)
+		return 2;
+
+	/*
+	 * There could be two corrupted data stripes, we need
+	 * to loop retry in order to rebuild the correct data.
+	 *
+	 * Fail a stripe at a time on every retry except the
+	 * stripe under reconstruction.
+	 */
+	if (map->type & BTRFS_BLOCK_GROUP_RAID6)
+		return map->num_stripes;
+
+	return 1;
+}
+
 int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 {
 	struct btrfs_chunk_map *map;
-	enum btrfs_raid_types index;
 	int ret = 1;
 
 	map = btrfs_get_chunk_map(fs_info, logical, len);
@@ -5797,22 +5820,7 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
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
@@ -6462,14 +6470,14 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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


