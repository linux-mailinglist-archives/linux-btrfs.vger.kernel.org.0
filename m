Return-Path: <linux-btrfs+bounces-8507-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09E898F300
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 17:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7881EB23740
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 15:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7461AB528;
	Thu,  3 Oct 2024 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="UipRfLA+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76F61AAE16
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970213; cv=none; b=sY6A6moXFZkO/xiGOvtnDmC+ar2HPLrRM6EMIVrHavdUqpSVt4By8nA2aYftSqOr9Z34ah55bxzTYrk3ezFOYju+17jmZrSR8aN2TynMEciNFzMzUwqXL0uRKrwsfvfUiJSibfC1UcwuNos7Fel58diRk3cDOjMLCfI4Dck3hoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970213; c=relaxed/simple;
	bh=Lk4wDPgCaqJdBkq4KjXEaWvM8/p5eXEcoYEqgLXSWDU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MutPwDh04g6LUUezl0t+knTVLXhqQz6W+FsaA1zIJpp1JGwcRruvW3Kys+vGeUdnsG2bToHkj2oneddDtByA/PgMeOximcHsJnDfuhT+ajgIsFUPptTq+JIbajwk+8n1wsnyGeoZY2xEU1X72Wdktb6C9jibgUg6JPMpVowYinw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=UipRfLA+; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a99eee4a5bso83225785a.0
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2024 08:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727970210; x=1728575010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2vw2q9Lj3ia4Ysl9JdLS/BhRI3oAC18Kr8Zfp6lBUg=;
        b=UipRfLA+bIivFNfxwOZRJxyidIz5fLhgiUcYFsSTaocbMyafnCeIU1GSBIPHUjt3KQ
         SJsuNwBxDXfeMHgevcwi4/kyriDagDUvkC6vbBlYEJVgXFCQcSrGdFU3DCxzd5nnbdH+
         UFQJa/XZavTO9yZEVTSOs5VJUJ4zhKPpN6P3bCiU75mmGL/q9+XIvvbGK+l+vj5kFhHZ
         Gw7XVSw65z+oSTMtrN0vYoaa9vCsZymDPfQguNck/QIZYz/SYjO1oq7ht2novWmSzShM
         CwtbnRaJ0DXPGdZ7x9PtV17pBD8s0zmSSmpVBmupitlfVqS53NbcDUVc9+zgWAx9zqsN
         W8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970210; x=1728575010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2vw2q9Lj3ia4Ysl9JdLS/BhRI3oAC18Kr8Zfp6lBUg=;
        b=Fq4qsnCJNFDk74n+2V2tEJddeXnftAV05lTonmGhAvuyDoQVtlsv8W4n5TCbaX+b1s
         99ZGuBXUaWftsttw5Zqa6SQJmkL3+j6bIgAO7ttDJ0cGfv3sRiHyShjOoxRyb70kbpnl
         c03q+YKHAFxHGYIxsx2DX7+tcmRBKCqh2VusnkCCGo2lWf/r6iN2AcTaBwMtvOJVlKuP
         1pHwpETN18RheqqRF/7KumQgplaKGUi5VJiex89CYH0/UudHjHW7Jl+epW+nf+/hSJIm
         0tMW34YU8U746zEUR9ggPES0BBDelCYrm9CFuub6ld+rMgkkmepGJFYkLY1kNU8+ifY2
         PzOA==
X-Gm-Message-State: AOJu0Yxq8biRT5Clmll2LWD8FiuXIQlptCvjERKRb03CengcTFWpKjKb
	/77Vmq5iEXU7080fSq+mNsNYn/P85BnfIbP7Zmv1IVGV7X850Risk4NkjF1LH5GkPiLOv52IVrN
	T
X-Google-Smtp-Source: AGHT+IGv3vFMRd5ChFRbvLLErvHCyCQ6uNo/O2kR+CvtlbrpMhS4ss5YbhMWequW7MWIeauHVL2Qjw==
X-Received: by 2002:a05:620a:4004:b0:7a3:524f:7ef7 with SMTP id af79cd13be357-7ae626b23ccmr924779285a.12.1727970210526;
        Thu, 03 Oct 2024 08:43:30 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b3d55basm60076185a.86.2024.10.03.08.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 08:43:29 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 08/10] btrfs: simplify btrfs_backref_release_cache
Date: Thu,  3 Oct 2024 11:43:10 -0400
Message-ID: <4f7e20a5e41c837f05cc88f3f2e4942ca18f8154.1727970063.git.josef@toxicpanda.com>
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

We rely on finding all our nodes on the various lists in the backref
cache, when they are all also in the rbtree.  Instead just search
through the rbtree and free everything.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 9c011ccd7209..a7462d7f2531 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -3164,32 +3164,14 @@ void btrfs_backref_cleanup_node(struct btrfs_backref_cache *cache,
 void btrfs_backref_release_cache(struct btrfs_backref_cache *cache)
 {
 	struct btrfs_backref_node *node;
-	int i;
 
-	while (!list_empty(&cache->detached)) {
-		node = list_entry(cache->detached.next,
-				  struct btrfs_backref_node, list);
+	while ((node = rb_entry_safe(rb_first(&cache->rb_root),
+				     struct btrfs_backref_node, rb_node)))
 		btrfs_backref_cleanup_node(cache, node);
-	}
 
-	while (!list_empty(&cache->leaves)) {
-		node = list_entry(cache->leaves.next,
-				  struct btrfs_backref_node, lower);
-		btrfs_backref_cleanup_node(cache, node);
-	}
-
-	for (i = 0; i < BTRFS_MAX_LEVEL; i++) {
-		while (!list_empty(&cache->pending[i])) {
-			node = list_first_entry(&cache->pending[i],
-						struct btrfs_backref_node,
-						list);
-			btrfs_backref_cleanup_node(cache, node);
-		}
-	}
 	ASSERT(list_empty(&cache->pending_edge));
 	ASSERT(list_empty(&cache->useless_node));
 	ASSERT(list_empty(&cache->detached));
-	ASSERT(RB_EMPTY_ROOT(&cache->rb_root));
 	ASSERT(!cache->nr_nodes);
 	ASSERT(!cache->nr_edges);
 }
-- 
2.43.0


