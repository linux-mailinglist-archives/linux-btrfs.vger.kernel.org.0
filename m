Return-Path: <linux-btrfs+bounces-4439-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A148AB4EE
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 20:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB1C1F2109D
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 18:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5F913C3F2;
	Fri, 19 Apr 2024 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="HxiJIJGF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA8C130A5B
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550638; cv=none; b=iWKiKPOLyLXIvX+dcUPBkfCiAh4YDd4pQXfvOKK7cthPO2auXeyYp1bcX+Sfc2S6YlfNxYWcjKUgQtZ6MoNdIf/fF1EQqBk4xjR2pRBopQzXVTSwoP4ihrTSUDi+E6oD9z7spdUnrLzKiHCu/b4IGWcev4TnMV2J4dsydq8wPXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550638; c=relaxed/simple;
	bh=yLAKJjeyuCKLtU1yKko3PqdPmkAaQI52Jj9ivazbWYE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvxqyKZ5cPo5zP0kdIQ9aVgDF84uuxF6BJRiozUn6qVnkHYx6/knOZhkMSMi+FScUyrj5859mFlvGAahoYXJkU93zaIO5f7kPrIkV15hWT0HqhTYYkoAczXXpSx+JUHh93FrOn/jRVXQx7mv0S2R+xMvSKyK7JqpIf4luXxQrLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=HxiJIJGF; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c70e46f3caso1240855b6e.2
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 11:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713550636; x=1714155436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z31+zLHW3b8QEl1jHvlW3MeAcA7zHCJ8yETwFDHgxiY=;
        b=HxiJIJGFgGxY9y9HaDAdlmg9EClYjwXaCj4pAj3rPNdJCiywMAyDQTuBn5y0+bx0gr
         O2OYixvPXh84BNpNz00dvpAmiiEP4D/fvF7+XHE5mzk9kCSRr3oU+w86aoZjXmhrsfJg
         uR8tim6qojwCW6zSHRw/FP9y2IzkBgXlslXnQayHdwSuh10SjSRowIFmR2AecK+3RJ7g
         qSVxjTcvbI73IdgaJNWGlHE4UFzbj6q+Bd89VCURoyUl+r85Gk01Bi1ioV/DywTKxzEB
         xHy9yx/KynvFeGcfx8J+1rWXO9taVu7hbs3I/+5eaJJfbxtCou4guWqRuagWtjaAjsim
         WOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713550636; x=1714155436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z31+zLHW3b8QEl1jHvlW3MeAcA7zHCJ8yETwFDHgxiY=;
        b=CXZr0fCEDFjjIzz5LaYrZqVSdsrybc4IwBY9oZrQ5V2LqKhXckV9pXeWXpXZbslB+g
         RGYYXlXU4Ne5rhWpH+GeOwsOCwRrCDUxbvddK3sNm2fu9dBeKdlZDYEE02Oqif+eW7ki
         ylS2aCZ9ysOSbw/OBkLGcMQhBQFBr5jPgdeS0JpPF6u0VJNnwF5boPdifYKxrLzQeOKl
         yyjSlSOlxQeCmJvlCkHV0at/suYUoXaFTwI4yDxWJizGuQTHkja12uyDVLhziImgxR75
         gN3qAGKI5m3Ao+2/p4Ro8Shx5n4Aw/bw17bSsIluBevDsJ8l6zed6WOy63zlc/YNkRJx
         sPOA==
X-Gm-Message-State: AOJu0Yz5Kxa4ysJY9uq8pGCICI9vLeLFX9AMScypwKiqdv9WdZ9GEabJ
	m4LkuSiJB3M/p4JbuDOynks9PG5disOl2xlJWYsAKAoZ35yxc/OkrSoJOwo21Zgl27sbfBgds0t
	w
X-Google-Smtp-Source: AGHT+IF686qwrA9x5uIXEv3ZmrPshnwXQTTouQSu0QOAEJeBMD1/xP34fR4vFjes15XHqlglJJ8tXg==
X-Received: by 2002:a05:6808:2c4:b0:3c7:2914:9784 with SMTP id a4-20020a05680802c400b003c729149784mr2757693oid.16.1713550636158;
        Fri, 19 Apr 2024 11:17:16 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id pe16-20020a05620a851000b007883184574esm1814432qkn.98.2024.04.19.11.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 11:17:15 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 01/15] btrfs: don't do find_extent_buffer in do_walk_down
Date: Fri, 19 Apr 2024 14:16:56 -0400
Message-ID: <c30d22dcf2f6418a803ea2e0066545566829afa1.1713550368.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713550368.git.josef@toxicpanda.com>
References: <cover.1713550368.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do find_extent_buffer(), and then if we don't find the eb in cache we
call btrfs_find_create_tree_block(), which calls find_extent_buffer()
first and then allocates the extent buffer.

The reason we're doing this is because if we don't find the extent
buffer in cache we set reada = 1.  However this doesn't matter, because
lower down we only trigger reada if !btrfs_buffer_uptodate(eb), which is
what the case would be if we didn't find the extent buffer in cache and
had to allocate it.

Clean this up to simply call btrfs_find_create_tree_block(), and then
use the fact that we're having to read the extent buffer off of disk to
go ahead and kick off readahead.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 023920d0d971..64bb8c69e57a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5434,7 +5434,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	struct extent_buffer *next;
 	int level = wc->level;
-	int reada = 0;
 	int ret = 0;
 	bool need_account = false;
 
@@ -5460,14 +5459,11 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	btrfs_node_key_to_cpu(path->nodes[level], &check.first_key,
 			      path->slots[level]);
 
-	next = find_extent_buffer(fs_info, bytenr);
-	if (!next) {
-		next = btrfs_find_create_tree_block(fs_info, bytenr,
-				btrfs_root_id(root), level - 1);
-		if (IS_ERR(next))
-			return PTR_ERR(next);
-		reada = 1;
-	}
+	next = btrfs_find_create_tree_block(fs_info, bytenr,
+					    btrfs_root_id(root), level - 1);
+	if (IS_ERR(next))
+		return PTR_ERR(next);
+
 	btrfs_tree_lock(next);
 
 	ret = btrfs_lookup_extent_info(trans, fs_info, bytenr, level - 1, 1,
@@ -5518,7 +5514,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	}
 
 	if (!next) {
-		if (reada && level == 1)
+		if (level == 1)
 			reada_walk_down(trans, root, wc, path);
 		next = read_tree_block(fs_info, bytenr, &check);
 		if (IS_ERR(next)) {
-- 
2.43.0


