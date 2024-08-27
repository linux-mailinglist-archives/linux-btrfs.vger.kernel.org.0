Return-Path: <linux-btrfs+bounces-7593-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1314961A19
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 00:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17427B221EB
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 22:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0791D45E0;
	Tue, 27 Aug 2024 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBbR5FNU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B901D4165
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724798530; cv=none; b=OknGhPyFOt8xL0dPP7P8phSePRJwqUqfInNzE1yRkv69bviQ2As7159t4GTwiKu6gKPDYr2W3rFjOe50ApFmMHAN36KdBOgwMVRyilc8Z5T4SKS+VYIf8ANcwYrwwDd9/o4v4lFkQzmqMsHjwKPiD8zrTfYg2sKLMnuA/GeVAvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724798530; c=relaxed/simple;
	bh=Mj9L80TmcUqhnBNXpA+4LISewFqhqg8Wrv8MloGzFN0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSL/ljDE6rPT+gsEzX7qqAzKTR5nxdsWRXUHbY2CIvDvQId1Oguv3xqzxV/29qEDbDG5IOtst6goCWP1/Jq+HZYRkG0hEzV3oibbx+Odv20h0q1GzvrPUDh2ePnzXoFZ4ilzDa0CGGcQzdOZgyd9IQRL5eTRdBam4ZyH/PQNmK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBbR5FNU; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-3db51133978so786600b6e.3
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 15:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724798528; x=1725403328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1cQ+5UH/9MovsoNRkqll87lIGd/AatsUKrccEw5cJU=;
        b=RBbR5FNUUzdVhVcTopZyiBfjFpMTVQ3Pe/BXU1IE/OOvxSnl7oBSWU3c2Qpy4ib/iX
         b08V3eeGrO3+ixAFlWsEqiBg8dumQGns9KGGWEUNQz6F5ygl+f9vALvAzrDkWWzzMv5u
         3OYGF+HbO65YyzvujdWoBfh675+TddLWX7OxtGfFYC+FK05zHyPP0Vkn7tlKcuCLOurj
         fNH5/g8in3EIuwDywRlNKx64BDTUaOqw4V8Dao5m0RNf1r77Qcvoce6JY3Ij+O3FGgUX
         SDU0lmRNDbktlrrnyHcxkf9/YMPRJTF7TiZft/5O01MWOFpz04FozpLk/o8OPwtbVKhy
         qKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724798528; x=1725403328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1cQ+5UH/9MovsoNRkqll87lIGd/AatsUKrccEw5cJU=;
        b=Vvxbu8IPhsWIM38UQIofGRK6KK0d7xqN5tIAdGZz8/KLVmyibdNqMhiOXvbipT+nUT
         /wJ2t56RCmBkccFZYzV75oScvy/E1yCzwgp9j4VYNofq58CTWj/FQKnUI71ScsxksI27
         /ZQ6f1XW43pPZmuz+T5z7iFwg9T8Wl5SymMOC0dMy+lG3nQ8EP6ShIWwDv1XbMVjF37W
         L7BgiduqrUK1U4oqJFVM2VWbD7D+zMKNPalAiq9X5BviqyqUVXa0R9ENZ5GQcMGWgoqP
         yUxHq/C39zEf268Or2LB8qISWaHYq/r/7XvAhVZGlG/aN5McFHIqPTOFmrJjRglTynxt
         uF5g==
X-Gm-Message-State: AOJu0YxQhZEi3bd9DvV0UVWFzB6lweKsdjNsQH/xhjighyuvu4dgQJOZ
	NwS6AavDnSn1U/vmvKqXqahUStxYRgfiXhfmAr3w23ph/KSj2aDUXkPZEXDY
X-Google-Smtp-Source: AGHT+IHnLT2V81YXoYGSfU2+88HaY0Msk5q3IRRPAMnd5i2ZH8BgRhQNmAGRusMqGhdEp+VPEl32SQ==
X-Received: by 2002:a05:6808:1296:b0:3d9:2c62:72b4 with SMTP id 5614622812f47-3deffb4925dmr193587b6e.19.1724798527648;
        Tue, 27 Aug 2024 15:42:07 -0700 (PDT)
Received: from localhost (fwdproxy-eag-008.fbsv.net. [2a03:2880:3ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de2254ec26sm2755474b6e.18.2024.08.27.15.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 15:42:07 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 2/3] btrfs: BTRFS_PATH_AUTO_FREE in zoned.c
Date: Tue, 27 Aug 2024 15:41:32 -0700
Message-ID: <0843271a3901ff3f52658f1a7a4382f3d8263b88.1724792563.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1724792563.git.loemra.dev@gmail.com>
References: <cover.1724792563.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add automatic path freeing in zoned.c, the examples here are both fairly
trivial with one exit path and only btrfs_free_path cleanup.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/zoned.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 66f63e82af793..158bb0b708805 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -287,7 +287,7 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 /* The emulated zone size is determined from the size of device extent */
 static int calculate_emulated_zone_size(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_root *root = fs_info->dev_root;
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
@@ -304,28 +304,21 @@ static int calculate_emulated_zone_size(struct btrfs_fs_info *fs_info)
 
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
 		ret = btrfs_next_leaf(root, path);
 		if (ret < 0)
-			goto out;
+			return ret;
 		/* No dev extents at all? Not good */
-		if (ret > 0) {
-			ret = -EUCLEAN;
-			goto out;
-		}
+		if (ret > 0)
+			return -EUCLEAN;
 	}
 
 	leaf = path->nodes[0];
 	dext = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dev_extent);
 	fs_info->zone_size = btrfs_dev_extent_length(leaf, dext);
-	ret = 0;
-
-out:
-	btrfs_free_path(path);
-
-	return ret;
+	return 0;
 }
 
 int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
@@ -1211,7 +1204,7 @@ static int calculate_alloc_pointer(struct btrfs_block_group *cache,
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
 	struct btrfs_root *root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	int ret;
@@ -1246,7 +1239,7 @@ static int calculate_alloc_pointer(struct btrfs_block_group *cache,
 	if (!ret)
 		ret = -EUCLEAN;
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	ret = btrfs_previous_extent_item(root, path, cache->start);
 	if (ret) {
@@ -1254,7 +1247,7 @@ static int calculate_alloc_pointer(struct btrfs_block_group *cache,
 			ret = 0;
 			*offset_ret = 0;
 		}
-		goto out;
+		return ret;
 	}
 
 	btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0]);
@@ -1266,15 +1259,10 @@ static int calculate_alloc_pointer(struct btrfs_block_group *cache,
 
 	if (!(found_key.objectid >= cache->start &&
 	       found_key.objectid + length <= cache->start + cache->length)) {
-		ret = -EUCLEAN;
-		goto out;
+		return -EUCLEAN;
 	}
 	*offset_ret = found_key.objectid + length - cache->start;
-	ret = 0;
-
-out:
-	btrfs_free_path(path);
-	return ret;
+	return 0;
 }
 
 struct zone_info {
-- 
2.43.5


