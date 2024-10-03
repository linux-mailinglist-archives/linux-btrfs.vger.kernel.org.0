Return-Path: <linux-btrfs+bounces-8509-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A16B98F302
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 17:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2F92812BF
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 15:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8980A1AB535;
	Thu,  3 Oct 2024 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="RD6H29Hu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1681AB533
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970216; cv=none; b=JDUcuwS13JRzl5tLI+w+qpdND/fyb1f7UU05evjXjpeDDKo9f+nS+0cTIj0rnKitVVjwKMHzOXjiqYrYXmQn3yj2An4qPY/7fo1utbNh5CSbFBwhHa+1FYkD7sv18S7E5V0azrftF9YlajpHODYfj5XJWh5rwGX3QHo38aGbfik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970216; c=relaxed/simple;
	bh=5FyJ9F7y2B0r5D4V85DtrUmwwKrmFCqX1gC147U9iDo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fdo/QngJ//0r3ccytLoeId8sUOzIUADq0WSo1JsYSxFjFXpDDhNA7T9KCW1u1H7F4mCPlQMG5FQ2zYiu4dLWBoQdMyeA5O8GER+fLWldlkN+9vQSdGqqN0XzHl4j4ZRVl8620X/1FekjRpEQpu2fUYpwZZg0e4UYfrAal8c2aQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=RD6H29Hu; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cb2dffcdbbso10001426d6.1
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2024 08:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727970214; x=1728575014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDSVkZ2EBt445h2p1JvHxEyE96llUbKZPMr/ondzwG8=;
        b=RD6H29HuR/t51qWBPLIOc3K5HKmxFod89IkHAxCVM6SEbUHHlm1aWc66Jh+0qsGiUA
         s8L/HuB39/QByK5dAIHEZw3kMwFILXdwG32XPy/VkNsTTgAy+veoW+hcD3u2OwpbtAMy
         iI6ahtTSiNmbtI4+FKyMVvwfjijaehpy8k/zJJjKAjbVMZN683AoAJ3wz6V4mA1tugAh
         2g/6dlcogEdf/gicVK++XjT6EEslei3T6p2pEX/fnlrGE2an1WuR5eYUb1ZODXJ3zUJb
         yPB4mEd8h0kxP8C9pxSM3fSEiS9wXYjqcd/Cldguy0AwFp+z//ofjZjfpysB6NM0VI+5
         CjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970214; x=1728575014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDSVkZ2EBt445h2p1JvHxEyE96llUbKZPMr/ondzwG8=;
        b=VC8yLPBnzEDaipceacGoerfJ/JviDcpzaBvWRH2IPjHHmJIHvzW8NqJsL8Kk2gIeAW
         mv3zXmcFhJI2daWAX+nf3nuPrd89tWXV3Bifewvx3C7BunK3hYaGmYga6Ii6QsH8zpEh
         C5dWfQj0r/n1+Q+qn4H9m0eXoU/0A0zHNr2V0js63WaZRyhnOaScRALD4uaeD/Xtz0yB
         //ux5zjLzSsBr01kBy6Ibed520HvjGCZP33JRLgAT0qHAPnHGwjX7TIxaJBPCcmpou+E
         uMNAvW8t0w3fKeuoUDwr7fsxVphaLsDuzSVCqyM3RefUlUT1taqbgyLach2319bS73Ux
         qoGQ==
X-Gm-Message-State: AOJu0Yx7O53MLp1cuUl1Twjr3vk6owIVS1+8h0vKAh8m9qvJ0UKhj1es
	zKbyPxk4z/E2dsp4L5kuuQQIp5wJiJeVaecOyuJKG9UEw6wUAsVO+bI1MvFSBUL84Bd1jIDGkcT
	c
X-Google-Smtp-Source: AGHT+IEF16Hu2oy7hTpo4ej+e/e9fLzDGsPNWNITWvGmspoaX4e5XKdDNDjehKT4FuEFvk3P6LHDdQ==
X-Received: by 2002:a05:6214:2c08:b0:6cb:7396:ee37 with SMTP id 6a1803df08f44-6cb81bbab15mr117990006d6.42.1727970213726;
        Thu, 03 Oct 2024 08:43:33 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb937d3415sm7482326d6.78.2024.10.03.08.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 08:43:33 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 10/10] btrfs: remove detached list from btrfs_backref_cache
Date: Thu,  3 Oct 2024 11:43:12 -0400
Message-ID: <cc3a43f39f3005ab68a4ce2c7c77a111e72bbcac.1727970063.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727970062.git.josef@toxicpanda.com>
References: <cover.1727970062.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't ever look at this list, remove it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c    | 2 --
 fs/btrfs/backref.h    | 2 --
 fs/btrfs/relocation.c | 1 -
 3 files changed, 5 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 5e7d41a8efdb..a8257755e1d0 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -3021,7 +3021,6 @@ void btrfs_backref_init_cache(struct btrfs_fs_info *fs_info,
 	cache->rb_root = RB_ROOT;
 	for (i = 0; i < BTRFS_MAX_LEVEL; i++)
 		INIT_LIST_HEAD(&cache->pending[i]);
-	INIT_LIST_HEAD(&cache->detached);
 	INIT_LIST_HEAD(&cache->pending_edge);
 	INIT_LIST_HEAD(&cache->useless_node);
 	cache->fs_info = fs_info;
@@ -3158,7 +3157,6 @@ void btrfs_backref_release_cache(struct btrfs_backref_cache *cache)
 
 	ASSERT(list_empty(&cache->pending_edge));
 	ASSERT(list_empty(&cache->useless_node));
-	ASSERT(list_empty(&cache->detached));
 	ASSERT(!cache->nr_nodes);
 	ASSERT(!cache->nr_edges);
 }
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 13c9bc33095a..2317380d2b1c 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -393,8 +393,6 @@ struct btrfs_backref_cache {
 	 * level blocks may not reflect the new location
 	 */
 	struct list_head pending[BTRFS_MAX_LEVEL];
-	/* List of detached backref node. */
-	struct list_head detached;
 
 	u64 last_trans;
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 7fb021dd0e67..bd86769de66a 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -367,7 +367,6 @@ static bool handle_useless_nodes(struct reloc_control *rc,
 		 * cache to avoid unnecessary backref lookup.
 		 */
 		if (cur->level > 0) {
-			list_add(&cur->list, &cache->detached);
 			cur->detached = 1;
 		} else {
 			rb_erase(&cur->rb_node, &cache->rb_root);
-- 
2.43.0


