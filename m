Return-Path: <linux-btrfs+bounces-10388-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5DC9F24A0
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Dec 2024 16:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0723F1886023
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Dec 2024 15:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9B2192B8F;
	Sun, 15 Dec 2024 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRP1pAqa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADC11925BF
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2024 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734276462; cv=none; b=A68ynwL7mhWU/3xJYIo0lHSGZPjM5VmhIIh2HjYzAPbuKIpeKl15apzkTjCxKHtbeEXde5HgD4KdZ0hW9G5TkQRpXBJMzefEZfP/PjMe+P7Bj1JtD8rOCFkjM5a1+9Ga6lfVW7O99fE7wONhEKvMO0cr9edhacYf2qNnKmW6Gy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734276462; c=relaxed/simple;
	bh=9b9YTj2xnHIEzes/Vr5Ux4+osSi8HavPDgrLuL9LjvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZktThptpwmo7A8BDBjbvqjISJMxlmma7d4IBvrg74XdJowvUJXIz65Bcnrlrl0DzC6pg62T0ePcEKFiG4D302v+7pcGS6qyzmuVbGJf6nTR0jc11iO2aNNZE6/Ikv3lfTkpauRadzOrREQwspB/pJsSfc0SKohnUM1/0/8mVyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRP1pAqa; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-844dac0a8f4so259214039f.2
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2024 07:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734276459; x=1734881259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0aR2sgw+Yd4htpY5BB3Zi6WNHIYiaERlucEqL79HRw=;
        b=VRP1pAqa58q2TeQB01YVZ/Pxd4T6MjjroxdyxV6hWbOO7zCApIsKpKzIPMvyJ00uBP
         gwZEJi98mF4TGPRSTggpP6Y/RYdfL+2INbRB2QmkjF8W4p10Dd1EJiNs9Gqsgryc0VcB
         Sb4VWKsdew8gB+jWjDlzCQshf4R2Q6kdn/6pN1rwjVdVpJFElEhhz2oqiMw772qVR2Ns
         7lmZqWkqywNyYLU8fqrsSABu1ELKXsv+ECQ35EINXvplGC37ddFO0c4q8/msTGfna+br
         eG/IbAWKas4pVp21LjK4WcWcr8C0JcJyoP98OtfxgagxJ5XQEBgZE3BWqFKQOHa0mAER
         bBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734276459; x=1734881259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0aR2sgw+Yd4htpY5BB3Zi6WNHIYiaERlucEqL79HRw=;
        b=WP5pmbIoS2wbg3Uvr6Y5hIeB5dduqAUJjqV3PEt4pysnU23djs7oXGuFDII6K+GxID
         NdkJKyBhwlALnWQxdLmcouW0v0ilbiUv/+8i04++Z7FJ7iGzVBybGVdKeKYRtfT4R27N
         ZkZ8a1PxBsdRoqiGpHj1Xiyq6B+ru0mLUV2ETJza8pp3IUg/t2G1S/mCCHIOydLepdFZ
         b9jf/x0eCL9+0Q80aqV+llRGgM1UsikFBgVXFoVE3QYK2zBVXDtRZXWLQif0XjNRsk5n
         meckB5za0QzE5OrqHFzdJAkQL3JP9DsgshSwizzB73rJ4GJiwMZbBEsbSPNE5c+3aURX
         Qa1g==
X-Gm-Message-State: AOJu0YxAmi0+C86jOMBrD9Di0o6U8rliN4ditSDxDMZiUpjNDxXyu+4Y
	lUo7dzTn6nXpoY/GxKDusIjpds6+Y5D2NAfOPywm8ve7S5Mz6FbOh0bDHA==
X-Gm-Gg: ASbGncvYPWkiJknFS9HCjzacLg6qZxg2II6eb4V1xg29pRJHz84hfXi5Xq5L7pIptFx
	Y8lxC2iW5UE2I+wPMOExdsHN+ogNvWHcHZvD/Lef02rMAWYKq3aFeY7VsnVOOC6tUIFJq5swd9e
	d1tsGI3djEaazpvqRR0qdmXuIDV4PQhnzgVYUP19iPljhtKYFoiKzuYbsE7GQmO6yjwBG30mzEx
	ztiIbol3g97+Qz5T0qG3GYXfXRQ/gUVM74b8V7ehMvY+cRqZLtjfMYZzG+Aia4wGg==
X-Google-Smtp-Source: AGHT+IG/nvI5+CkxMa1XgAhYFTCYzwwC+ORgy5PRv0limqykxZX/c6yZ0OIut4WIppb0K/oOio+yrA==
X-Received: by 2002:a05:6602:60cb:b0:844:c76a:354d with SMTP id ca18e2360f4ac-844e87b05a9mr1205394639f.2.1734276459638;
        Sun, 15 Dec 2024 07:27:39 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e37817e7sm773846173.114.2024.12.15.07.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 07:27:38 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: [PATCH v2 5/6] btrfs: update btrfs_add_chunk_map() to use rb helpers
Date: Sun, 15 Dec 2024 09:26:28 -0600
Message-ID: <189d8684f80c95a89d162f8aaa2bb676cad77d65.1734108739.git.beckerlee3@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734108739.git.beckerlee3@gmail.com>
References: <cover.1734108739.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update btrfs_add_chunk_map() to use rb_find_add_cached(). add
btrfs_chunk_map_cmp to use with rb_find_add_cached().

Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
---
 fs/btrfs/volumes.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1cccaf9c2b0d..d51badec5520 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5513,33 +5513,30 @@ void btrfs_remove_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_ma
 	btrfs_free_chunk_map(map);
 }
 
+static int btrfs_chunk_map_cmp(struct rb_node *rb_node, const struct rb_node *exist_node)
+{
+	struct btrfs_chunk_map *map = rb_entry(rb_node, struct btrfs_chunk_map, rb_node);
+	const struct btrfs_chunk_map *exist = rb_entry(exist_node, struct btrfs_chunk_map, rb_node);
+
+	if (map->start == exist->start)
+		return 0;
+	if (map->start < exist->start)
+		return -1;
+	return 1;
+}
+
 EXPORT_FOR_TESTS
 int btrfs_add_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *map)
 {
-	struct rb_node **p;
-	struct rb_node *parent = NULL;
-	bool leftmost = true;
+	struct rb_node *exist;
 
 	write_lock(&fs_info->mapping_tree_lock);
-	p = &fs_info->mapping_tree.rb_root.rb_node;
-	while (*p) {
-		struct btrfs_chunk_map *entry;
-
-		parent = *p;
-		entry = rb_entry(parent, struct btrfs_chunk_map, rb_node);
-
-		if (map->start < entry->start) {
-			p = &(*p)->rb_left;
-		} else if (map->start > entry->start) {
-			p = &(*p)->rb_right;
-			leftmost = false;
-		} else {
-			write_unlock(&fs_info->mapping_tree_lock);
-			return -EEXIST;
-		}
+	exist = rb_find_add_cached(&map->rb_node, &fs_info->mapping_tree, btrfs_chunk_map_cmp);
+
+	if (exist) {
+		write_unlock(&fs_info->mapping_tree_lock);
+		return -EEXIST;
 	}
-	rb_link_node(&map->rb_node, parent, p);
-	rb_insert_color_cached(&map->rb_node, &fs_info->mapping_tree, leftmost);
 	chunk_map_device_set_bits(map, CHUNK_ALLOCATED);
 	chunk_map_device_clear_bits(map, CHUNK_TRIMMED);
 	write_unlock(&fs_info->mapping_tree_lock);
-- 
2.45.2


