Return-Path: <linux-btrfs+bounces-10137-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B349E883E
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 23:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5AF281095
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 22:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0634B197A7A;
	Sun,  8 Dec 2024 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnEpuj6V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AFE195962
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733697523; cv=none; b=bvFSzi2zxNFdAG85HyU2SXrdhlA+j1ZcqaXuehP+/wrIty51qESDqENpfbrSV6JbsZoLC6wF52w6E3Ya27UEzaEYnkaMgko7Ll0+kClAU6uyJFDgOyWv4P4IvwnEWCmdhh/lbTg6v1XHDlJbtjZDRsyn9pDgDkRdNvuXhaoFlFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733697523; c=relaxed/simple;
	bh=9kpe6TDmVSVFtYplQJBDMWGlI52PtJexub6dCkCXgg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4EUiBsWfU13EC6z/LOgDKu6mR4+UZR6BjT1RPUkH+AaWLF7A5CcbHz9hy/cWkWo1qWefAiRMvkEWIVNOaubuw4FafvqUUZWY82Lpm9Cd+arfcGuUDz0t8pCwH4K1tRygsl/4DFZ5LAXYTPos57QKwVf/3g/bonTkjzr4cu+Q0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnEpuj6V; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a8c7b02d68so7247215ab.3
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Dec 2024 14:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733697520; x=1734302320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhrCFLlh2CA5eBdvoQ1grHTqpO1miyOgMhXMpbOo9xY=;
        b=bnEpuj6VR2hb0FJnjULNTWhhhqaKdyiRuDQBJYPR/rygBXPGzoUZvbL8+8l3wnBkP8
         VVHlVXzC5Zd/vKF1993b5SJAtT6252Zyzi4iDlVHNaLSupTbI3ZIjaJJnZ1wTJLIkWRz
         x5FnN+6npCvSgjzhAJLFloMNHr6t3wLgxmb4PSmp7pmGRa0F3YnJnhDQqLQDEQ3Iw1dS
         Zszh/EDP61Te1djmOf8L8FEnydQNn9IlaebgRSjfnDoWxkstEinoO1EplmFeUXjmmryb
         hdMZx/oAoCz9bbobFcXgeiAym5s5Urz2xX4JsptcRIC26CPPHKG+IhxU3EMa8VVP86nK
         OamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733697520; x=1734302320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhrCFLlh2CA5eBdvoQ1grHTqpO1miyOgMhXMpbOo9xY=;
        b=ZKDYcXFfQqkoYCaeUWmcgLUE+kphMkpeWOlggFLkR53fadDUM2d+4J4j3N3Qk5gy2u
         ZpTj9BMGDjYdEtkthQX8/Ii6pLVl5SVFG/kpF4naw1Jo6blPAXnBIN+S1yJbru+74zB3
         ckwvhqexZnqdYOIrbU+M2tFj/ZbhHbEtE+YYn617YgCFbjNHGgecUuKAUerTu6cQZCXL
         Z7Yw4SwuuS0WGj6Se4a1U55iJxNauLUL7UiGUruv9h2d34uCIo7xzxE/eBQjY9+2nvqr
         OUdHHYAK/5mN5ILRZkTjRHNdmQoEzJ/J6g9lB/LsEY3a2jHZ0phk8FYzFKfzaBrNpV0K
         dR2g==
X-Gm-Message-State: AOJu0YyYhliV0H3oX+1YZSqrutV4q/j1e8gkHwPpt7dMdw4y4ndpVZ/a
	auW88goXXAz1U8V6NwXr2WLo7DPejxPRYIUWlqmLzYTEuQtC4xm+yHy+cA==
X-Gm-Gg: ASbGnctNq9hTypipVFi2N/eYXNR23DYv6YUfmIrQbQqC7ucfgG/8mznTTDZC7IY910n
	guZQNvG6NYm//B1CdScEdnODVhmW7Aeg5Mm5/KYHs69b0eTrdvaGlJE7ocX6bpNmeOI7AHUQ8WG
	hBBM/0p5eSyZCmKJw1j3vW2L0g1FmMzMIn9yiurCFObOB27N/6kz0hqV39XMb/5884p0zM9vdQh
	zg6hj0Be83otX4FgRTCvQmEbGzKKiX19xJlZDxyD+wp0tM2G7uaDHItW70=
X-Google-Smtp-Source: AGHT+IGNf3W+48uBKUSbZ+jHvLWF9DH5qHtWmMtMndrlWA2mK1EWsWJLjZ5KOnxDpltM2B5Z0txGTA==
X-Received: by 2002:a05:6e02:1d8b:b0:3a7:78a8:1fb4 with SMTP id e9e14a558f8ab-3a811db2837mr116758935ab.13.1733697520062;
        Sun, 08 Dec 2024 14:38:40 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a8f162d6dcsm12704745ab.67.2024.12.08.14.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 14:38:38 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH] btrfs: edit btrfs_add_block_group_cache() to use rb helper
Date: Sun,  8 Dec 2024 16:38:01 -0600
Message-ID: <4d8d468cc1240adf03fd23fd4b80582f57a5b28f.1733695544.git.beckerlee3@gmail.com>
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

Edits fs/btrfs/block-group.c to use rb_find_add_cached(),
also adds a comparison function, btrfs_add_block_blkgrp_cmp(),
for use with rb_find_add_cached().

Tested-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
Reviewed-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
---
 fs/btrfs/block-group.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5be029734cfa..ccff051de43a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -173,40 +173,34 @@ void btrfs_put_block_group(struct btrfs_block_group *cache)
 	}
 }
 
+static int btrfs_add_blkgrp_cmp(struct rb_node *new, const struct rb_node *exist)
+{
+	struct btrfs_block_group *cmp1 = rb_entry(new, struct btrfs_block_group, cache_node);
+	struct btrfs_block_group *cmp2 = rb_entry(exist, struct btrfs_block_group, cache_node);
+
+	if (cmp1->start < cmp2->start)
+		return -1;
+	if (cmp1->start > cmp2->start)
+		return 1;
+	return 0;
+}
+
 /*
  * This adds the block group to the fs_info rb tree for the block group cache
  */
 static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
 				       struct btrfs_block_group *block_group)
 {
-	struct rb_node **p;
-	struct rb_node *parent = NULL;
-	struct btrfs_block_group *cache;
-	bool leftmost = true;
+	struct rb_node *exist;
 
 	ASSERT(block_group->length != 0);
 
 	write_lock(&info->block_group_cache_lock);
-	p = &info->block_group_cache_tree.rb_root.rb_node;
-
-	while (*p) {
-		parent = *p;
-		cache = rb_entry(parent, struct btrfs_block_group, cache_node);
-		if (block_group->start < cache->start) {
-			p = &(*p)->rb_left;
-		} else if (block_group->start > cache->start) {
-			p = &(*p)->rb_right;
-			leftmost = false;
-		} else {
-			write_unlock(&info->block_group_cache_lock);
-			return -EEXIST;
-		}
-	}
-
-	rb_link_node(&block_group->cache_node, parent, p);
-	rb_insert_color_cached(&block_group->cache_node,
-			       &info->block_group_cache_tree, leftmost);
 
+	exist = rb_find_add_cached(&block_group->cache_node,
+			&info->block_group_cache_tree, btrfs_add_blkgrp_cmp);
+	if (exist != NULL)
+		return -EEXIST;
 	write_unlock(&info->block_group_cache_lock);
 
 	return 0;
-- 
2.45.2


