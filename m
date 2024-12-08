Return-Path: <linux-btrfs+bounces-10140-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522889E8841
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 23:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD25728100B
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 22:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690F519883C;
	Sun,  8 Dec 2024 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO95a1vU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A5E194A64
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733697528; cv=none; b=jUsTsn2S2F0SheHSNbE8OdzurwOba0EVKCthSdWoCorAUSwVdH+u9Z06sJXiF6q+yvzHskYCQ0hoIT6SfDssWhyXBhSDsNo1gtDcjDp6ElmOc1ChnaTthTKpvzJM9Z2wn6C+ieVAYvrPN/OV3OyyWV7oYb+sVs3+JTj/CDe3rB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733697528; c=relaxed/simple;
	bh=V0T6NqxDoLhmmdZpXfTj7q6zWBaRX+omH3h340cmils=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQH9eyKWqHTTxOWMXQfugfJxk0T0doJVkzS0SZQx7qvoD07Uv3Zn1lXTlfhaK53kWTFzNkZgoAGPyAic+RXKGAWsdUdoblgNKVWGQX1yYwgUfe+XNmOdCUaDsgkXaV68A1mxTZR8BBsEhpBmqSreAR+X5nRAhNi+09vq4C/8mIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FO95a1vU; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-84198253284so145790139f.3
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Dec 2024 14:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733697526; x=1734302326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUPK8JXg2FBBYMOeVz083T5kC5KtwfNKxXSBS/yfGV4=;
        b=FO95a1vUO7vuZa0bxEzT0Dq2eFdMD0gWvQJ+cbY3Xa5j3F1JWMj1TdKhxgS4AIpTn6
         /t13BQEzD1M6QKVts+LmbW85SKcO5cIn3c1EvS3PrQDvDAEdTHLfJKSgia6gP0bhtsUM
         lrEJNAz/jTUENboFXlqaVZrmfezzIQYd/Hfm8uF+8tGE/weNdyuV75fgwPyCuicNbjPw
         nsmmizi14A3N/n+d0tiyIClSBj+gxiPtssIUDmRU3qz4mYUxHrA6rI7m/S2LblNCSql2
         GyyNOL/gvnQORh0q+6kw30YiU7b2qima7M4KsBeTi/Hwe0wH8XtSTalLKU5NdjYoOeKp
         ZmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733697526; x=1734302326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUPK8JXg2FBBYMOeVz083T5kC5KtwfNKxXSBS/yfGV4=;
        b=RTp8D/BsOXQxLSkJPr4n3Z+PXsF6R22eKjYFMS1hYrhOSJP+WjdF/VZcmYTgHs1MoA
         ZdZuOqmkSRv6u5jCXP+tHlyx5WxIuENK9iKDK+FNKnswUNZ7p5s4e7gO2O/BxtPdmPYv
         i1IxxZeBl4HiVrOfJwXAaW/U9qeNVb+q1PkE56F9QQarm9n7DPck93xz2q3eObuhcNow
         qqL7SZjam0/r8SteI4HJrOK0lR2xkQQhz8derarjaggjA1nqgmIBMyETARbgZhfk+WZ1
         u/QIj2cfSLfXXh3DeHe8taYv8VJi66syVAXJXi9USux/byoxksk8E6JxtHfG/eC/torr
         rqog==
X-Gm-Message-State: AOJu0YxsgHbLFio1ARL4FWQsADuaw+inEY1bmZz2LylR/GuSGIAWXFc7
	T7Cjo/LBxUj7WOGlvL1vW+J3AAGtupsOcpe9zzeIzCXczYWlcTqEVBMtHg==
X-Gm-Gg: ASbGncsyDmqICiIS+VrgZtgSOrHVVC3a+96wrJPNnKQTmiYg3GD8VG7K3rWvpaou6EM
	suHpFmaHKpjtLZ7kIpdKzXU6MT9mM49Tjg9Dfe0xI79KtiSEEQOs2syXUUT+nkBDVPibOHK63iT
	YcXZXQcklYXpT4KUi6pDzvAq1wd6mO+rNkrSCkjNGqRBHhubQtlT4CY3jyEUV1vbEmhqGzL46yM
	8DsCR7qIu8NNHu+WUwxnFBtkrvwVzZN/DbpDOhofF5SEejT0wMgIhlpvmo=
X-Google-Smtp-Source: AGHT+IE/pJRoM9wRLdsLc3npeHSQX3sOISvSQBt5AjuhEJtsk1SXO0/JyU9ZMffDRnxNLlzlTmpaZQ==
X-Received: by 2002:a05:6e02:1c89:b0:3a7:8270:4050 with SMTP id e9e14a558f8ab-3a811e00d7bmr103877735ab.18.1733697526027;
        Sun, 08 Dec 2024 14:38:46 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a8f162d6dcsm12704745ab.67.2024.12.08.14.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 14:38:44 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: [PATCH] btrfs: edit btrfs_add_chunk_map() to use rb helpers
Date: Sun,  8 Dec 2024 16:38:04 -0600
Message-ID: <3d4e17f44bafeb7e83d2fdfb50ac4e0c3ce2d23e.1733695544.git.beckerlee3@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733695544.git.beckerlee3@gmail.com>
References: <cover.1733695544.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Edits btrfs_add_chunk_map() to use rb_find_add_cached(). Also adds a
comparison function to use with rb_find_add_cached().

Reviewed-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
Tested-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
---
 fs/btrfs/volumes.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1cccaf9c2b0d..4837761a56c9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5513,33 +5513,30 @@ void btrfs_remove_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_ma
 	btrfs_free_chunk_map(map);
 }
 
+static int btrfs_chunk_map_cmp(struct rb_node *rb_node, const struct rb_node *exist_node)
+{
+	struct btrfs_chunk_map *map = rb_entry(rb_node, struct btrfs_chunk_map, rb_node);
+	struct btrfs_chunk_map *exist = rb_entry(exist_node, struct btrfs_chunk_map, rb_node);
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
+	if (exist != NULL) {
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


