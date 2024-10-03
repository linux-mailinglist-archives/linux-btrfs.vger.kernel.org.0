Return-Path: <linux-btrfs+bounces-8508-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4ED98F301
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 17:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4241F22CA7
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 15:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04A51AB536;
	Thu,  3 Oct 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="kV1y60cM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7D11AB522
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970214; cv=none; b=Pm4HWhiE086o24RJuzOib+nqRALcfJS8iAL4YlEwk10PBnzPb05i0gM2VY6EmidZ88FKv5LLzfUHvnekcB4iI+EVpnN1bR0Ij+FEmaLf+rX+tHFlVAUm+Z2BYhITAExMO3rgUePnVyaTdHgvG53oTNn6MpW4KaV6tVVU/jMaK1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970214; c=relaxed/simple;
	bh=SmO24r4D/24sLPqKI8euNDgKL7G5ZQuKKA4EjRnLq8g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svqIZZWELT107bh9n1Bh2cO61wmlnz/RIwaOwlS/fN+yess+8Cfebq1WDwp8LMHdLQRfcsirZnflrCIjTFbtRjB1uJ1hZYiHjOKdkqBBPMtW6AyD0nRz5H5cSaiCWcyz5CSXIWN/3C4CYjRmqpm6UvBLwMGzbiIANxJfL0GNrds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=kV1y60cM; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a9af813f6cso95058785a.3
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2024 08:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727970212; x=1728575012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+5SgY6eSSkSzB7yxei3Tn7MALUZ5NKccDpnwrg0yUs=;
        b=kV1y60cMg51TnCsPBq7TEL3WrsjY67fGreisWQHM/OzBrN/IR1EobLkZhYLHmqxX/L
         z9xkcXdeeGdRZHqlYB9m/PxWiIpAK+pqc6Jx7YDdqPUmBRMahp37DL27HBDzZrreLWHb
         64VWKbrsHmcmZuj6wRHsuXJnB35t45grCwNHRZ2LfTgqGeuHeSpngHNbrNwZtvV9MxZ7
         oJWwp8RT7Lkeol9vVwhfLDXBGbl0y0Oe6cWeFhTqn5LVoNWw7Nzp2UQQqsx9wHD3dkMT
         kskp/mMG5lZlPiXpT/RMKBHb0MdHT4LsLrSZ5pWZwo/NHZkmgaOawe0B9Pzkg0Sg5IKK
         1E7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970212; x=1728575012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+5SgY6eSSkSzB7yxei3Tn7MALUZ5NKccDpnwrg0yUs=;
        b=Hc43PhB/CaeGk+5N6cqGHtjVQxObxDJJracDUnQSJX/nOVQ3f7ZUI7ag/zv5mvP5Cg
         fg58YP5+VOLPYBA3XeW23V0HcpWq6atcq0IFKjI8AXPdFYBKIF4JuNgUpdDv7ciSIODp
         BvXLAH+tJ6N5T5Bazl00qKeDkB/Xz9WNbwsDl7OBcJY7Tw6HnWLReNEniuhHAWqwq9qM
         a7N49Mrn14XZksBp9JB+l+Uy6kxjh9rk3q6trJGqjDWE44HF9uDj/YGmsfr3MW5UGVSu
         d3mHd0zUu8p96yFP1Es5bPk4BNXCn5AA0va0sybExHzr10Cgf1YHi6V1mzHskmCAnNAb
         A98Q==
X-Gm-Message-State: AOJu0YyewRLmLpojnEHZn6DNtSVCv3t7/D5NaJODWBdnNJTlXN7nxJyn
	KeLIGjqR5svnWnXrrPrOkzDVRMh0Qf93Xr8m+zdkCzTN4KuOEz0hJL+3PeaL0SadDRCtnvAgNH+
	a
X-Google-Smtp-Source: AGHT+IER3caYw6PmOVv6UmiGMvY1zJ35IgGbZShYLQ/03F59R274GvBOXoatCRSClM8Oj6GsEbRfaw==
X-Received: by 2002:a05:620a:2496:b0:7ac:e879:1a20 with SMTP id af79cd13be357-7ae626af7d1mr1177321285a.1.1727970211958;
        Thu, 03 Oct 2024 08:43:31 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b3dc587sm59683685a.111.2024.10.03.08.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 08:43:31 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 09/10] btrfs: remove the ->lowest and ->leaves members from backref cache
Date: Thu,  3 Oct 2024 11:43:11 -0400
Message-ID: <28f56ec3b86951cdae8fa94822bda7a898f6ffbc.1727970063.git.josef@toxicpanda.com>
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

Before we were keeping all of our nodes on various lists in order to
make sure everything got cleaned up correctly.  We used node->lowest to
indicate that node->lower was linked into the cache->leaves list.  Now
that we do cleanup based on the rb tree both the list and the flag are
useless, so delete them both.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c    | 19 -------------------
 fs/btrfs/backref.h    |  4 ----
 fs/btrfs/relocation.c |  7 -------
 3 files changed, 30 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index a7462d7f2531..5e7d41a8efdb 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -3022,7 +3022,6 @@ void btrfs_backref_init_cache(struct btrfs_fs_info *fs_info,
 	for (i = 0; i < BTRFS_MAX_LEVEL; i++)
 		INIT_LIST_HEAD(&cache->pending[i]);
 	INIT_LIST_HEAD(&cache->detached);
-	INIT_LIST_HEAD(&cache->leaves);
 	INIT_LIST_HEAD(&cache->pending_edge);
 	INIT_LIST_HEAD(&cache->useless_node);
 	cache->fs_info = fs_info;
@@ -3130,29 +3129,17 @@ void btrfs_backref_drop_node(struct btrfs_backref_cache *tree,
 void btrfs_backref_cleanup_node(struct btrfs_backref_cache *cache,
 				struct btrfs_backref_node *node)
 {
-	struct btrfs_backref_node *upper;
 	struct btrfs_backref_edge *edge;
 
 	if (!node)
 		return;
 
-	BUG_ON(!node->lowest && !node->detached);
 	while (!list_empty(&node->upper)) {
 		edge = list_entry(node->upper.next, struct btrfs_backref_edge,
 				  list[LOWER]);
-		upper = edge->node[UPPER];
 		list_del(&edge->list[LOWER]);
 		list_del(&edge->list[UPPER]);
 		btrfs_backref_free_edge(cache, edge);
-
-		/*
-		 * Add the node to leaf node list if no other child block
-		 * cached.
-		 */
-		if (list_empty(&upper->lower)) {
-			list_add_tail(&upper->lower, &cache->leaves);
-			upper->lowest = 1;
-		}
 	}
 
 	btrfs_backref_drop_node(cache, node);
@@ -3599,7 +3586,6 @@ int btrfs_backref_finish_upper_links(struct btrfs_backref_cache *cache,
 	if (rb_node)
 		btrfs_backref_panic(cache->fs_info, start->bytenr,
 				    -EEXIST);
-	list_add_tail(&start->lower, &cache->leaves);
 
 	/*
 	 * Use breadth first search to iterate all related edges.
@@ -3638,11 +3624,6 @@ int btrfs_backref_finish_upper_links(struct btrfs_backref_cache *cache,
 		 * parents have already been linked.
 		 */
 		if (!RB_EMPTY_NODE(&upper->rb_node)) {
-			if (upper->lowest) {
-				list_del_init(&upper->lower);
-				upper->lowest = 0;
-			}
-
 			list_add_tail(&edge->list[UPPER], &upper->lower);
 			continue;
 		}
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 6c27c070025a..13c9bc33095a 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -341,8 +341,6 @@ struct btrfs_backref_node {
 	struct extent_buffer *eb;
 	/* Level of the tree block */
 	unsigned int level:8;
-	/* 1 if no child node is in the cache */
-	unsigned int lowest:1;
 	/* Is the extent buffer locked */
 	unsigned int locked:1;
 	/* Has the block been processed */
@@ -395,8 +393,6 @@ struct btrfs_backref_cache {
 	 * level blocks may not reflect the new location
 	 */
 	struct list_head pending[BTRFS_MAX_LEVEL];
-	/* List of backref nodes with no child node */
-	struct list_head leaves;
 	/* List of detached backref node. */
 	struct list_head detached;
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 507fcc3f56e6..7fb021dd0e67 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -342,12 +342,6 @@ static bool handle_useless_nodes(struct reloc_control *rc,
 		if (cur == node)
 			ret = true;
 
-		/* The node is the lowest node */
-		if (cur->lowest) {
-			list_del_init(&cur->lower);
-			cur->lowest = 0;
-		}
-
 		/* Cleanup the lower edges */
 		while (!list_empty(&cur->lower)) {
 			struct btrfs_backref_edge *edge;
@@ -426,7 +420,6 @@ static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
 		goto out;
 	}
 
-	node->lowest = 1;
 	cur = node;
 
 	/* Breadth-first search to build backref cache */
-- 
2.43.0


