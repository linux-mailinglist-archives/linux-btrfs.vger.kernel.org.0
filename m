Return-Path: <linux-btrfs+bounces-7798-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E2B96A661
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 20:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB2C1C241C0
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 18:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72098191F62;
	Tue,  3 Sep 2024 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBzgW3DW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA361917C9
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725387644; cv=none; b=aQOsG7qatazHgWp5zlZlv4W5QDK5oIhVgwXaL2YdYGVxzUJ2bbSAQgEzFQ5ev1osw2Mwd288FN+46910x2W3jWs/dmvWOuwAA8VSBYhHgqCymMsU2lqOLuAx6KrYaO/3g8I66lX9lrm1kChFA84HYXa6YvEZOd+JaWzqu436qjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725387644; c=relaxed/simple;
	bh=wFHHFmxc0TbIdO3TTNIX9UIQAqSQI1psuBHMMfJAD+A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJhBKqU9smLoNascofu1SFCA0I0nY0KK4KoyfSrhff5Zw13rxo8PGG/T4S5zpxPSTkYwiwlAoFACeY2im8DEBhRRyazufD5L4C1G42DIKauvzdGJlu7tOsSlwd0VhMzrcwL3OZP/GuD3vXMsCs6yOCMrHb9DpgYk6PQf/Yq3Gvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBzgW3DW; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-3e0047fcb3aso1005492b6e.0
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Sep 2024 11:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725387642; x=1725992442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PCH1DfVOKonao3jChYQBvzWNIQZiX9CFR7wUHN2gk20=;
        b=JBzgW3DWvV162sQ4fPlwWmCoEE1sHXGyDnNvKsMveJ40LSAvFeOl9rYge2jF0XbFps
         P9J5VV+3TChqNce9wmY9zfwzb02I0FYmI7LCASapeVlTWeQCL0FhO3GSuAFsaoKYAsjW
         89i/a5RruM82K7OYgwNheBHRmrgY5qA/YdkmqgujOKpHc9l5T7b+lUk/K+BE8J0Px55c
         yOUts96SPgfjIvU8iTInXZIQhd7y6FFlmpNrhc1mszqAiiFq/0jZcaYfbPhW47LBfJts
         EF8PETEnDIJpsRPUQorQ1Pg+Ej8x+86DZqHz0/YrB4ohhDF3zpcX1H2MGCSscy8ZVNFR
         YZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725387642; x=1725992442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCH1DfVOKonao3jChYQBvzWNIQZiX9CFR7wUHN2gk20=;
        b=QB+wVyJMwyC9VEzp/mIPu1JLdVQnGkTNCZmbl8Z/LeHSrYudtsjMffWauDdMsKWP6p
         gq/vpYSScZpbydOVyKVRKiTjtbnP1NsJy7Ukt5UqZxbNnLvxTP7uvtby9kw6Rbdf+//E
         JgqFeSn4gU5FxkocmDNfY3KlBRuvAu3G+fVSyboJtoJmHCWnmK0Har90oBuPaWl6dXGj
         SfpfTXcl8Ri4qN3oEpOOMpvoS7nFnmS4VnEk6gPpo+VdUU7TMhUhoig19kpgfVqSuXBs
         1VbZsUhGq5LTktWevShWVP2GSr8Pi0HiGS2nXr5dEGPDyngMRIDL2v8tp8v1efv1klyw
         cJFw==
X-Gm-Message-State: AOJu0Yw+5m47uq7g8nFgTuf8YdzKH+PS6TyiLcyXfQXU8brUHOWhy67r
	enwkLucbioz5wy9AFfry2LwmTjQxsgAUYeB3AVjINbNq5jk+4pbaMPm9eJDM
X-Google-Smtp-Source: AGHT+IGZOr/uPlBM1ZkjVAXCk2DobsXHd0XnBpDeje806R13qN9uAlaQLloiJmqrtALznzPOt7jBbQ==
X-Received: by 2002:a05:6808:23c9:b0:3dd:ca:a3f6 with SMTP id 5614622812f47-3df0682c6camr7996971b6e.18.1725387641933;
        Tue, 03 Sep 2024 11:20:41 -0700 (PDT)
Received: from localhost (fwdproxy-eag-000.fbsv.net. [2a03:2880:3ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df117c446bsm2443361b6e.21.2024.09.03.11.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 11:20:41 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4 2/3] btrfs: BTRFS_PATH_AUTO_FREE in zoned.c
Date: Tue,  3 Sep 2024 11:19:06 -0700
Message-ID: <6ee68aa5c468b53adb93c617a99c184ea1e9f1a2.1725386993.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1725386993.git.loemra.dev@gmail.com>
References: <cover.1725386993.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All cleanup paths lead to btrfs_path_free so path can be defined with
the automatic freeing callback.

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


