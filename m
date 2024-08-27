Return-Path: <linux-btrfs+bounces-7573-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4A49617C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 21:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0078C1C23656
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 19:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BB91D319A;
	Tue, 27 Aug 2024 19:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knd1QM+I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1211D3181
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785792; cv=none; b=hcUgrMtBrEmcCrGehISmTf9xAQmlwUC9+SJQRD/3FPpGvEcEoyxp2oFp1rBbp/htuq9xd6UXhzq2jFUJ87gdek+cKwkBgFDLZl3wWQkU6RYTsEhBOoq9vS+ZT+SXcpHCuzovo9UhcPlhcZTAPFHcFrciSUaSzA3vdXVa5i6AvSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785792; c=relaxed/simple;
	bh=VTVbdeZ7m/yShOS/JfSfvNtOAHt5e3BhJfk96jpX39I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2BmlTzqy9R4keLOWvclnRHnG8/qZRjgi91IwIkKmBje4gCBsBq9ndBJbJLHbT61KapsWe4SKHPprH482DsEfE5hfyRf/Q6DWY4OfPwGMWxVhymxXWViUg92sUH8447YTWAg3u7TiOVKeeEYpdzt9X+hFn6LSorWjURzHpehwM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knd1QM+I; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7095bfd6346so5228296a34.0
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 12:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724785790; x=1725390590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TgCXovq2H9JnOdzJX6Nr9BDbcORhNZ6yZsuhVd1ZMCI=;
        b=knd1QM+Icg4KvX5A2OEzObkwpf85ao0pvyGFYpPQ1f6GyZEiT/PsXkQZwBmNlne0u8
         vyjVGBf4ryTWadLqwnOELYCztk/JB2a+MMLic1dy3y9JrrJjA8cbcioSyFsdTgk3L5l+
         dWmuNf3Syvi4w3rsHtMjZL/YCaGCQn3tupwQP0wUTPwdgdEkfylPILHR4tJs++NxzS8A
         TOAYhPBzYGO8r3KRazHm+BIgKxgz5ZcgLXFG91cViGZiDYVGiR0Vt7ZfADvbv/tP2ZNh
         /H/svRjIWFj6lH6CSqDrv5mJJRo4SYjGWnxleDr5mS1J6LT4yxLcQHkc77EZlcEXycf9
         hong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724785790; x=1725390590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgCXovq2H9JnOdzJX6Nr9BDbcORhNZ6yZsuhVd1ZMCI=;
        b=rMwFhiLRsTI/O4c7UvJhIw9RkhA5bdma9XBTChArHOFH5uIO65rPTS91hx0H7tcDw4
         5DMKinSTI6Q0hoR0Xj3oY1WyWcw6t40jbaCbWUYNOvHL5E52M+Tk5o/VAMrgGqFd7y6c
         lO9XT+YThdYhn32aSIljTY3dQfkJnTZdjKL0z7QhbzJQMD3rodY8BXIgZETsuTU4F2fj
         SaR3RjNSGAFRCotW7J7UqXOL3eqb41+JWmKBy7xgSGaDae2QzwftMNYDWkNhcKH5ViGm
         xM0OQgfr8O9oBc0G3EsxB+thRa6Ke0DDGa28YKZKR7B6Z/DxqOWb0C4PRN0OCDeHd34Q
         KT4g==
X-Gm-Message-State: AOJu0YwRUej4VeyaF5W987xOI5ot/Pn3ZoCuvnOc4dCnrop87GSVkM1W
	uXNFjl/exOEsbAzuPYm6NJ+7VbAYdqtd7msanSO2mR7VsXmynFWqXTR95PhF
X-Google-Smtp-Source: AGHT+IHzeJnwNclWgdQKQYjzUIqHmGx5/n81vEeGqjr57ZcRIfj9NCSfLNn78np1Xs4xvP2gMNxfIw==
X-Received: by 2002:a05:6830:63ce:b0:703:5e45:f991 with SMTP id 46e09a7af769-70e0ec200c3mr14806339a34.31.1724785789782;
        Tue, 27 Aug 2024 12:09:49 -0700 (PDT)
Received: from localhost (fwdproxy-eag-004.fbsv.net. [2a03:2880:3ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70e03ab6bfdsm2478503a34.37.2024.08.27.12.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 12:09:49 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 2/3] btrfs: BTRFS_PATH_AUTO_FREE in zoned.c
Date: Tue, 27 Aug 2024 12:08:44 -0700
Message-ID: <ed3ccffaef20ae705342051ca697567eabcc1769.1724785204.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1724785204.git.loemra.dev@gmail.com>
References: <cover.1724785204.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add automatic path freeing in zoned.c, the examples here are both fairly
trivial with one exit path and the only cleanup is btrfs_free_path.
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


