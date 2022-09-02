Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895425AB95B
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiIBURR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiIBURH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:17:07 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74660E3974
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:17:06 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id y17so2273510qvr.5
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=bpVoGm6kiR8Rt3bEgKfAybcmSUc2idOuTh+rUnr2iCc=;
        b=QwTkbbS7Q2pGYKJr7VNQpwgMXLnRN9Ag1FdKf8ZGMD1id8FsdjuQLQjLysPg5KmIAK
         OfkbaA/4Lj3ZHlkPYY/gJt2mttL+9wmjQL9w+UzvyRmD1f7C4m/0mnF4KBlmw7uAPPBO
         i8OFqdlGNI4nO4AQe7V7/DSu8T1sBC//0vWnEBsi4e7zFfDswqqfuXGseGL74flr0DSD
         9lGJFmHNUIgoCGVoB82AHwpIKUn8ku5W8fUectDp15z2cEDc8344ryF1oHCIEU3r03po
         HboyfDvAml7YH/7ziUnmCgUjFx9TQn9lrYAswyDBYFftCam90J829IJ967wrdF1Bprxo
         pmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bpVoGm6kiR8Rt3bEgKfAybcmSUc2idOuTh+rUnr2iCc=;
        b=bGQZY7YUED2YeO+vguFMgjwxl+kKVrVWtxq6KMmJ2iOKsP0u7xychfW3Jks785cyIO
         OaFUnaMZ/sKgIj2P5NpZYzfbcGCbDKJQHK4GjfQVQjsVcZMapvYZpQXAa6rmSSgaDode
         v6B1YsVSRoPwK2xPiRhvDbDkng2/l58j7viseGzwuGZ4HbASEaEchrEa0FF3HFjN1Vb8
         P0wBGf7XTPJvfpIhQxPXzqq5Gwath5hBtEVG+W7rkp/YARV/SNx/UYVGMQEda+CNnMts
         sVX7sx6AC0m7sc0TNeWzbygqp4b0gC9LqjJctY3ZSBUyF9E/5j3xi4CPnmzBuKG76BNu
         G4Yw==
X-Gm-Message-State: ACgBeo1AJjidGdbX2IPGN9Xw0mhOEyYO9M/xVoQ+7n42vKXnlF8foJZG
        91IePWK+3hEeC0Ka/2w6s9pLz0lRYor+qw==
X-Google-Smtp-Source: AA6agR7sFl1yAoconlXfuA00eXH5zfPSXVEnNGCa9l2lrIzf9mFxea+h4s0nKhOCO9SYJbE8UL5lDw==
X-Received: by 2002:a05:6214:166:b0:498:ef84:f2c9 with SMTP id y6-20020a056214016600b00498ef84f2c9mr30722178qvs.104.1662149825221;
        Fri, 02 Sep 2022 13:17:05 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y9-20020ac81289000000b003434e47515csm1569048qti.7.2022.09.02.13.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:17:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 15/31] btrfs: make tree_search return struct extent_state
Date:   Fri,  2 Sep 2022 16:16:20 -0400
Message-Id: <ed6ec4dc3eef59baba9ac2e716f16dbe39d81df2.1662149276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662149276.git.josef@toxicpanda.com>
References: <cover.1662149276.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a consistent pattern of

n = tree_search();
if (!n)
	goto out;
state = rb_entry(n, struct extent_state, rb_node);
while (state) {
	/* do something. */
}

which is a bit redundant.  If we make tree_search return the state we
can simply have

state = tree_search();
while (state) {
	/* do something. */
}

which cleans up the code quite a bit.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 51 +++++++++++----------------------------
 1 file changed, 14 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 32f86a524bdd..f39eb5e816eb 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -283,9 +283,10 @@ static inline struct rb_node *tree_search_for_insert(struct extent_io_tree *tree
 /*
  * Inexact rb-tree search, return the next entry if @offset is not found
  */
-static inline struct rb_node *tree_search(struct extent_io_tree *tree, u64 offset)
+static inline struct extent_state *tree_search(struct extent_io_tree *tree, u64 offset)
 {
-	return tree_search_for_insert(tree, offset, NULL, NULL);
+	struct rb_node *n = tree_search_for_insert(tree, offset, NULL, NULL);
+	return (n) ? rb_entry(n, struct extent_state, rb_node) : NULL;
 }
 
 /**
@@ -591,7 +592,6 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	struct extent_state *state;
 	struct extent_state *cached;
 	struct extent_state *prealloc = NULL;
-	struct rb_node *node;
 	u64 last_end;
 	int err;
 	int clear = 0;
@@ -642,10 +642,9 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	 * this search will find the extents that end after
 	 * our range starts
 	 */
-	node = tree_search(tree, start);
-	if (!node)
+	state = tree_search(tree, start);
+	if (!state)
 		goto out;
-	state = rb_entry(node, struct extent_state, rb_node);
 hit_next:
 	if (state->start > end)
 		goto out;
@@ -758,7 +757,6 @@ static void wait_on_state(struct extent_io_tree *tree,
 void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits)
 {
 	struct extent_state *state;
-	struct rb_node *node;
 
 	btrfs_debug_check_extent_io_range(tree, start, end);
 
@@ -769,11 +767,10 @@ void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits)
 		 * this search will find all the extents that end after
 		 * our range starts
 		 */
-		node = tree_search(tree, start);
-		if (!node)
-			break;
-		state = rb_entry(node, struct extent_state, rb_node);
+		state = tree_search(tree, start);
 process_node:
+		if (!state)
+			break;
 		if (state->start > end)
 			goto out;
 
@@ -1313,25 +1310,18 @@ int lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 static struct extent_state *
 find_first_extent_bit_state(struct extent_io_tree *tree, u64 start, u32 bits)
 {
-	struct rb_node *node;
 	struct extent_state *state;
 
 	/*
 	 * this search will find all the extents that end after
 	 * our range starts.
 	 */
-	node = tree_search(tree, start);
-	if (!node)
-		goto out;
-	state = rb_entry(node, struct extent_state, rb_node);
-
+	state = tree_search(tree, start);
 	while (state) {
-		state = rb_entry(node, struct extent_state, rb_node);
 		if (state->end >= start && (state->state & bits))
 			return state;
 		state = next_state(state);
 	}
-out:
 	return NULL;
 }
 
@@ -1541,7 +1531,6 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 			       u64 *end, u64 max_bytes,
 			       struct extent_state **cached_state)
 {
-	struct rb_node *node;
 	struct extent_state *state;
 	u64 cur_start = *start;
 	bool found = false;
@@ -1553,13 +1542,12 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 	 * this search will find all the extents that end after
 	 * our range starts.
 	 */
-	node = tree_search(tree, cur_start);
-	if (!node) {
+	state = tree_search(tree, cur_start);
+	if (!state) {
 		*end = (u64)-1;
 		goto out;
 	}
 
-	state = rb_entry(node, struct extent_state, rb_node);
 	while (state) {
 		if (found && (state->start != cur_start ||
 			      (state->state & EXTENT_BOUNDARY))) {
@@ -1597,7 +1585,6 @@ u64 count_range_bits(struct extent_io_tree *tree,
 		     u64 *start, u64 search_end, u64 max_bytes,
 		     u32 bits, int contig)
 {
-	struct rb_node *node;
 	struct extent_state *state;
 	u64 cur_start = *start;
 	u64 total_bytes = 0;
@@ -1616,11 +1603,7 @@ u64 count_range_bits(struct extent_io_tree *tree,
 	 * this search will find all the extents that end after
 	 * our range starts.
 	 */
-	node = tree_search(tree, cur_start);
-	if (!node)
-		goto out;
-
-	state = rb_entry(node, struct extent_state, rb_node);
+	state = tree_search(tree, cur_start);
 	while (state) {
 		if (state->start > search_end)
 			break;
@@ -1656,19 +1639,14 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		   u32 bits, int filled, struct extent_state *cached)
 {
 	struct extent_state *state = NULL;
-	struct rb_node *node;
 	int bitset = 0;
 
 	spin_lock(&tree->lock);
 	if (cached && extent_state_in_tree(cached) && cached->start <= start &&
 	    cached->end > start)
-		node = &cached->rb_node;
+		state = cached;
 	else
-		node = tree_search(tree, start);
-	if (!node)
-		goto out;
-
-	state = rb_entry(node, struct extent_state, rb_node);
+		state = tree_search(tree, start);
 	while (state && start <= end) {
 		if (filled && state->start > start) {
 			bitset = 0;
@@ -1699,7 +1677,6 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	/* We ran out of states and were still inside of our range. */
 	if (filled && !state)
 		bitset = 0;
-out:
 	spin_unlock(&tree->lock);
 	return bitset;
 }
-- 
2.26.3

