Return-Path: <linux-btrfs+bounces-10205-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D38E9EB9D2
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 20:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B9D283C2A
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 19:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF34B214209;
	Tue, 10 Dec 2024 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZRq16Bt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A4A214225
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733857641; cv=none; b=f+1Lhh8LfzKJG+4aLT3YhUjFVuMe69FDn9HBphGZEdVsSN1O/QU5prsD5E5zsYZUUOZz7XYaZjyfh6HbbZ73r0oTHLBMJVnYHBU0Hq4AEOkdYpqpBw22BWQr65cPtxZacPs4vkWn9OV+YM9aKYII8ptOLYXUMLCNTA9dSjWfp2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733857641; c=relaxed/simple;
	bh=f8zqfLDbVbo6pVP8+8i1UClt68Hb+1fTkJKIoUaUkvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScGskLpzsXApi/wbWM33L8xuw16OilFXux+YRQP8fey666dueB2v11ykqwDlyyCXjC7ZYsVo8yVnBN+HGphN6bspxoTkBPZTJSI3E+2g6ucGzksWCQKtJ5x4mzNUBNKAKiY9exQByfHccSGRTSDkKZqAfWOKdXHjHjfQFculzho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZRq16Bt; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-841a565f871so292337939f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 11:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733857638; x=1734462438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyF61UPlwTPl6abI/g9ou4p5GQJQbBZfjdnOgGeqJFY=;
        b=PZRq16Btljqmzug7FGu8ZrFxRd7K59B5HUUPuICBp7cCf0a8VvLwhhkmrZtzksUU8l
         I6Cf94lo+WtiSK0UkPXIGkMvEJMBHFrjWUefS/9UYDXq3s9/9QFqExiXXZ9QDoVzrb0V
         0PrY8b/ubT/jkYOLdbwtTO1T6zL9Rt7FhVVJkZi2qpWPYfG3ayBZkwHultVXImdNtqTR
         7yq+WMs7AStf7Onp/ePDHTHXOfMw+cCzeaHyM4oeml5x+gkF5FKz+hz+8caPU3yeuETN
         Tpy0zRyaqtkFdrGtfVpp13M3+l3uj7p0R9V8AO6abLKQJ2JBVJIAbyQni76RSd5DLkcg
         bgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733857638; x=1734462438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyF61UPlwTPl6abI/g9ou4p5GQJQbBZfjdnOgGeqJFY=;
        b=gZ5NRS2jJo4sxemTXE6VgXyiVcIzwbdCuRVwbs/GB6chQk0et9g/Obd139vh0bqtU3
         riGPi2Jq9k6vW87hzPoBNJ43lhfr4LCGcWaVs7gUxk1wjYjzmTLw1g1a09ThkrkSKbfE
         xvrCyk9XDt2Fz3qVp397gFoK9t3bReYytBjbHvJdS7HrhK1Oxv6npqvYyaLFbJuBGQDM
         OL8Ri6jSb/1BifyLGHguglpz5csSDPyZRkfmzbCGOTEYI5WnIHsgwIHyAkgQ+auGRjDL
         mqAF8PX80gynZk9qxtiCz2FHE2RPx8HMeb8fiaXxgr42RahcEepnU0bQMikJijhdN8pS
         5cWg==
X-Gm-Message-State: AOJu0YyczrKEp99gpKUYemw65mAqr0LOfLv+QCxPzWmO38ON95gJQC6k
	0o8auNg7S0Yvg7IwyAGWyZ5zjGKTB0j3ymEAo6wipNJIq0WCwf+6eH5QWg==
X-Gm-Gg: ASbGncvwcr6TtTa4QOFLCeZ7rIPEfdXCaWhWKhXlsMTqwk1H9VHiokuixdti2PCoM+1
	NEPtZEGhukb2R3Isu7F90RAgnT10jauY3oErUaBooBF50F3lp3vgRjsZHZ5wpBHq2ys02pCFKTy
	oHvTtesH0sIYZiYyGf/mWyV1t+i0Fvx1aKne0q9FBnxv/np/IciLEnyoiU/NnreMadm9PCmFKLm
	tDTAi3F+oQ3oh1/YKs72Bga8F6+plWJqdvdAhC+L4iKRc1RvN2jo6yoG1EPJJ0=
X-Google-Smtp-Source: AGHT+IE9ezKhUgqWL2Je4ErOKNjh+Ya+8bVJT2btugSNMKPPPChgRYFIWU2sikUWCdnDjGwQqPq7oQ==
X-Received: by 2002:a05:6602:26c7:b0:83b:a47c:dbfd with SMTP id ca18e2360f4ac-844cb5f57ccmr66924239f.6.1733857638325;
        Tue, 10 Dec 2024 11:07:18 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844cb2611b5sm7044839f.38.2024.12.10.11.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:07:17 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: [PATCH 5/6] btrfs: edit btrfs_add_chunk_map() to use rb helpers
Date: Tue, 10 Dec 2024 13:06:11 -0600
Message-ID: <536cfab6a2c1189bfe4e00282a54289fca6afc36.1733850317.git.beckerlee3@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733850317.git.beckerlee3@gmail.com>
References: <cover.1733850317.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Edits btrfs_add_chunk_map() to use rb_find_add_cached(). Also adds a
comparison function to use with rb_find_add_cached().

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


