Return-Path: <linux-btrfs+bounces-7163-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A237D9503D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 13:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F008280F40
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 11:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907751991AD;
	Tue, 13 Aug 2024 11:36:55 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB161990D3;
	Tue, 13 Aug 2024 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549015; cv=none; b=TjieEIa6ChZzCNnLlD7YWEVOPOioPKIgqaGSTA+vK4w2z9dpCLlU5LA/6EAuFVoePMNhOLPSWGMn0YeT7EeqjPTg2PM3k0ik8VzjEa738L3hGjQ4AlO3CKmBgbOO7Tb1KMn5KhmlfVLD4kcZMAwLGTraDNmenz3TFKi1PbumrI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549015; c=relaxed/simple;
	bh=J6LkgiQ1s6KhtjbIfiDBJontENquYN+ObrYEP8IayyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fU2qRRz0afSnGc760YrPVXzee9SKezjXaCKTfpO4ydFl6nObZHJyE/8ArSAozcrFcB2DdEX4VTXK51CBxPO7oiakvQhEHyTaNMgSnWlyRY5zcbHG9MOXWDpGtpV3rNZndyQyx3ZAGIEvCTOh007ZdslbWepEQIFcuTgkTHBireo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a83a968ddso524788466b.0;
        Tue, 13 Aug 2024 04:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723549012; x=1724153812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+iitshKJMXvkvVP52vZE80SRd922bK8hj3c3Q35ZNI=;
        b=HAzMZYZZOD9daMcoAn3yYaFIMc7u7FwaLsQsXoqLa+2Qo7mXgaZJGVTbWbhWQoDHSS
         YtVXgpfCDBrZ1aZ4TJUwJBocpkjXXgjlT+e9T4Ghm6IWJolqvnZMgR2b+IGba2iCZj46
         jWH4jVvsuHOeTEjOwRlK+DN60mHX8dUwP7wNgSzpVhMTZp7XL4aTObCJ/dEkxgSsrL5g
         JtISZXAIUSZal/jcyHRMDAWzW7YJHTBVut5bI155WF+nz2HRRpPSmJrwTGxjA7UAX9lE
         pCo8gjMLBAX40MtgRmBqOMDCCojTr83yB3c4Q4gdm+hANFchHvr9Hn865uy0+uYlCJAl
         nsLg==
X-Forwarded-Encrypted: i=1; AJvYcCVWWvLUGTFhSeyHP0jfK+vK5ulrMsrDKtcpyX+uLM1h1MJE8j06zmL8kYUQmNGdit0VETpq/8vRKMWaygGesm69T81RVYR5ZrvNcBIBJr8aYvlBZp08fnv1F6TGbejA5lOrU/30mt5NQX4=
X-Gm-Message-State: AOJu0YzZNR/Ryu61D2rw0Cx8pef3nigs+aRvK6wW9wXppDva/gGlVIpz
	dJUL8KUHAfXXR3nZPjJ9zvKRBzN2tPkJCjw9jchIlHEbGD5SSFKYCygLaA==
X-Google-Smtp-Source: AGHT+IEjzpOr/wpKgbXkgvf9qV5tK2CoSPH5eBjVEFg/0K8tZxaU/xTTYSUmRKeb1JRaYqetqithHg==
X-Received: by 2002:a17:907:3f87:b0:a7a:ba59:3172 with SMTP id a640c23a62f3a-a80ed24ad0amr235345566b.38.1723549011309;
        Tue, 13 Aug 2024 04:36:51 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f732f200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f732:f200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f411b4e3sm61850666b.126.2024.08.13.04.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 04:36:50 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>
Subject: [PATCH v3] btrfs: reduce chunk_map lookups in btrfs_map_block
Date: Tue, 13 Aug 2024 13:36:40 +0200
Message-ID: <20240813113641.26579-1-jth@kernel.org>
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
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Changes in v2:
- Added Reviewed-bys
- Reflowed comments
- Moved non RAID56 cases to the end without an if
Link to v1:
https://lore.kernel.org/all/20240812165931.9106-1-jth@kernel.org/

Changes in v3:
- constified btrfs_chunk_map_num_copies() parameter
- fixed accidentially changed comment
Link to v2:
https://lore.kernel.org/all/bc73d318c7f24196cdc7305b6a6ce516fb4fc81d.1723546054.git.jth@kernel.org/

 fs/btrfs/volumes.c | 49 +++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e07452207426..4b9b647a7e29 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5781,11 +5781,31 @@ void btrfs_mapping_tree_free(struct btrfs_fs_info *fs_info)
 	write_unlock(&fs_info->mapping_tree_lock);
 }
 
+static int btrfs_chunk_map_num_copies(const struct btrfs_chunk_map *map)
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
@@ -5797,22 +5817,7 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
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
@@ -6462,14 +6467,14 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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


