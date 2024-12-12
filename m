Return-Path: <linux-btrfs+bounces-10328-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5444F9EFD75
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 21:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E7A289C0E
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 20:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F7F19E968;
	Thu, 12 Dec 2024 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDci6sRK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E261422D4
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 20:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734035480; cv=none; b=iM154FH+JHEpmeQROrQ2Sro4cG7y/4pod8589sbh0Bir5WWJXGjd5O5ih+HzWzqbN/CITehCCcSz62s8wIQ88MCeFDeKXqzsX05mg07sMuD7mERCxMgMmW/BBsLpjkqja61ELrtdBvZzSxWOu0/k5Hxic3VgOU3+xHKAxfdvvYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734035480; c=relaxed/simple;
	bh=oQN9PKoo4/XxL2HTr+T3SQvrKxeZZqBZ7CGVSu871mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8srhZyFYYM4Q7Wxmj9b0O/XeMuNYekzdzqkE/c+lIkXqNqUgepnAAohc6zwFpmT5fNCI2PUf4aEAR8y/C03JZ0n+mNF0ym4yvTIhqx5q2DpxO7DGfembqorSdNw99z99VK9sgZZ2h4cSAGuwPCiwAm944FxJyqbNSWOun8pq3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDci6sRK; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-844e6d1283aso13139139f.1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 12:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734035478; x=1734640278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u81hyYymjCO6gTrB/A5NmlBtBd1FR4760ndipuiDqVo=;
        b=IDci6sRKopmFpOZMCY++ynvXjwVQRHJ47/JoAL9O4HWnIKrAr1mCAKuPvhmEfb6fHy
         MJbC6OCd3bbdSFyxXr4yMOXsnIaCGqqX1fibLXYE2UnROqDEGFD0iDZ0nVY5tzb5sZWt
         gT024NCDVbaJnDa85qxgJziC8R9Q7vEf8nf27czuEBNljjLEqu8rv82lxNDLgYLxhQmZ
         QwahEDOGHSUi0yOLHdozOXpFqDChpk1P0vGQAYVS7IXAIt3UMB+lvF5s3O92XqozHSoe
         RYxbDDs5YR39L66haGJHOtbZCuHpma4IotgXVYVLgO5T5WhnAUejzGAcjNWkKGCVsNHR
         g+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734035478; x=1734640278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u81hyYymjCO6gTrB/A5NmlBtBd1FR4760ndipuiDqVo=;
        b=IkbgZjfK2oicrsYNZ+1kLcqriYGkgqdLFy7dhXdhMqJj49pYuqsBVreTfjlDf0+loa
         wSmLyUyHf67uG3Ycfs4b0vwxDUlsNsdTPdaYL+wtpl7RJRF5hT7s3/BqQX+YWZxvlXe3
         tXEWzdA5M945qVOc0wiNEJA4EKvcR8CZaVuE0zrIuaPdAhKT9baIVlIn/hl8CrCZYo0M
         bNVi2CvxHu/X7KodAycd/7Lbl/ze6QZiagUTdt2U6z+jodBY3oXSYoqDr5/ZT5bwBsCq
         wAsi+58wJzKXTFnd5XdvqAqGbXjkVdJnE2rv/s5eB1ff2fgk2Pk5LcPP/PwXWZ69t6PF
         xUiQ==
X-Gm-Message-State: AOJu0YzO4YL0d6V9sHr0nVlpQs+ffxDLdKxfZj9e4UQW/c9qQwFRtGRq
	pSTA/q2GCL3HFUEBDJ8gncaXt642NkC2Znt5FaFmPQUeNHL4T+HdSXsHap/9Ka0=
X-Gm-Gg: ASbGncu7X+U1RjM5gQHAvVJtDBbno//Kg7oAR7jgouZ/G7HOR/ri+vpAcRChi3K6i4Y
	MW8Ed+mYiidSJwfQM0UuU5wkT9F+SMnwpTvUDNHEwod1gN9i0rli7TA3mM1X2HqvJ19k1YAywpu
	K1iqy5YbnE45DBbnVIkEA+NLuQyxDthbYE1XouMQ8cRyq8eWbTCICEvTeEQjrgUBq8Eig6v6R7O
	MueCN1rvgwwSPzXsICjagFQgBPXBGkJI0RwnP4HSlLIytCFEzAGV0tQqmPaMt3s7A==
X-Google-Smtp-Source: AGHT+IFEzcoDzg408ZPisPeY3d+QWX5elIh3jktehIwD5zRIuj4r7vqGcdIR4OothoXCKVjj61hrJg==
X-Received: by 2002:a05:6602:6d14:b0:841:8345:5eed with SMTP id ca18e2360f4ac-844e5b6e414mr157777439f.0.1734035478311;
        Thu, 12 Dec 2024 12:31:18 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844e29b6103sm28642939f.29.2024.12.12.12.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 12:31:17 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: beckerlee3@gmail.com
Cc: linux-btrfs@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 2/6] btrfs: update btrfs_add_block_group_cache() to use rb helpers
Date: Thu, 12 Dec 2024 14:29:40 -0600
Message-ID: <e2bd469a65fc93477240ebe9dd53b2ae7d591f46.1734033142.git.beckerlee3@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734033142.git.beckerlee3@gmail.com>
References: <cover.1734033142.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update fs/btrfs/block-group.c to use rb_find_add_cached()
implement btrfs_bg_start_cmp() for use with rb_find_add_cached().

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
---
 fs/btrfs/block-group.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5be029734cfa..6001b78e9ea9 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -173,40 +173,34 @@ void btrfs_put_block_group(struct btrfs_block_group *cache)
 	}
 }
 
+static int btrfs_bg_start_cmp(struct rb_node *new, const struct rb_node *exist)
+{
+	struct btrfs_block_group *cmp1 = rb_entry(new, struct btrfs_block_group, cache_node);
+	const struct btrfs_block_group *cmp2 = rb_entry(exist, struct btrfs_block_group, cache_node);
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
+			&info->block_group_cache_tree, btrfs_bg_start_cmp);
+	if (exist != NULL)
+		return -EEXIST;
 	write_unlock(&info->block_group_cache_lock);
 
 	return 0;
-- 
2.45.2


