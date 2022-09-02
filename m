Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA645AB94F
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiIBURS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiIBURH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:17:07 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5010D275F
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:17:04 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id w18so2598749qki.8
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=F+g/fJCJSE8HpoM9LtNLwRyeR57FytCndlKkSsi63LU=;
        b=1eJyfsYPC4hRJ6fxcpIVaEJ3E1ucafYSHaqvJ17LWhiF4pn2YwndGeqdqHGpUiXXqU
         444OK2eYwwRLu4z/ZOZjJ8js2/Itptgfb7MCT+wO+LrpFpbNyabStrj7+3D+qtUoL/5L
         FGt9I8zJqBxx2Vd24wEZiYQGL8n1oQRkunf5uGAXk5dfkg+ctNYWiBs8gVeNZu+6fI3j
         iMajrVko05TRKBA7ghRfjvhgcHIlhmv5uQQQQc+sI2ejL3yYXsRMCZ8tMnKQC4q2a/h8
         O8I+peMyea+GMDkRmCIZ9ybMBniF4dRmIcXisbWdG7WqFuHtXSjPB1GlmoKcNPFQaEty
         ypRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=F+g/fJCJSE8HpoM9LtNLwRyeR57FytCndlKkSsi63LU=;
        b=cFDXzfZrdedCUt2ZQfOuLJhcjR0czkH4IGh0GwcxxGawHTODcHYVsaz+EAz3sHaBM9
         GRHxzS1LLNTSgfU4ZBzKUfR6my0qOvOR3Okq8vktf2LcOh1zcUQ4eJ1uJzV7aKhwk+M4
         RaRpkFFMBqNOHsR/4jNXOn3B+/hWgQI0fqSgWfJJ9Gvyj0BSRN/ZzeYkeH0mBHZR51kL
         po33mKlom5VCbuqCW5G2UVNnL/0qw9YgVC3oSH6khhW5eBdsoeBlmgHp2bxv3icflu4Q
         a/VysafyVO3l1043zsrIDNDhenNrQjyUrGK3hRaAK5msgtwOL40k649+faQua0cNNThR
         Nn5Q==
X-Gm-Message-State: ACgBeo2saYgfxhPLj0tjwDPtEBIx5QLeOuYsWcKFsweO4dP4d4AYznHc
        XJbktLb/o5wEcEqatHZf0XRoaUgtzWwBIg==
X-Google-Smtp-Source: AA6agR6Jan+pe+YQuevbyPRQ9IN1iys0EBwLsW72ssV7qXKlk95t4epfbMmnpEqtj5K1rQ9aL/PFDQ==
X-Received: by 2002:a05:620a:170d:b0:6bb:3f82:6a7d with SMTP id az13-20020a05620a170d00b006bb3f826a7dmr24106571qkb.166.1662149823490;
        Fri, 02 Sep 2022 13:17:03 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n22-20020ac86756000000b0034355a352d1sm1547459qtp.92.2022.09.02.13.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:17:03 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 14/31] btrfs: use next_state instead of rb_next where we can
Date:   Fri,  2 Sep 2022 16:16:19 -0400
Message-Id: <9a273f88a443ecbbc338a0ea87b6294efa6553f2.1662149276.git.josef@toxicpanda.com>
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

We can simplify a lot of these functions where we have to cycle through
extent_state's by simply using next_state() instead of rb_next().  In
many spots this allows us to do things like

while (state) {
	/* whatever */
	state = next_state(state);
}

instead of

while (1) {
	state = rb_entry(n, struct extent_state, rb_node);
	n = rb_next(n);
	if (!n)
		break;
}

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 57 +++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 4e3cbb4edbe2..32f86a524bdd 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -770,12 +770,10 @@ void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits)
 		 * our range starts
 		 */
 		node = tree_search(tree, start);
-process_node:
 		if (!node)
 			break;
-
 		state = rb_entry(node, struct extent_state, rb_node);
-
+process_node:
 		if (state->start > end)
 			goto out;
 
@@ -792,7 +790,7 @@ void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits)
 			break;
 
 		if (!cond_resched_lock(&tree->lock)) {
-			node = rb_next(node);
+			state = next_state(state);
 			goto process_node;
 		}
 	}
@@ -1325,15 +1323,13 @@ find_first_extent_bit_state(struct extent_io_tree *tree, u64 start, u32 bits)
 	node = tree_search(tree, start);
 	if (!node)
 		goto out;
+	state = rb_entry(node, struct extent_state, rb_node);
 
-	while (1) {
+	while (state) {
 		state = rb_entry(node, struct extent_state, rb_node);
 		if (state->end >= start && (state->state & bits))
 			return state;
-
-		node = rb_next(node);
-		if (!node)
-			break;
+		state = next_state(state);
 	}
 out:
 	return NULL;
@@ -1521,18 +1517,15 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 	 * Find the longest stretch from start until an entry which has the
 	 * bits set
 	 */
-	while (1) {
-		state = rb_entry(node, struct extent_state, rb_node);
+	state = rb_entry(node, struct extent_state, rb_node);
+	while (state) {
 		if (state->end >= start && !(state->state & bits)) {
 			*end_ret = state->end;
 		} else {
 			*end_ret = state->start - 1;
 			break;
 		}
-
-		node = rb_next(node);
-		if (!node)
-			break;
+		state = next_state(state);
 	}
 out:
 	spin_unlock(&tree->lock);
@@ -1566,8 +1559,8 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 		goto out;
 	}
 
-	while (1) {
-		state = rb_entry(node, struct extent_state, rb_node);
+	state = rb_entry(node, struct extent_state, rb_node);
+	while (state) {
 		if (found && (state->start != cur_start ||
 			      (state->state & EXTENT_BOUNDARY))) {
 			goto out;
@@ -1585,12 +1578,10 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 		found = true;
 		*end = state->end;
 		cur_start = state->end + 1;
-		node = rb_next(node);
 		total_bytes += state->end - state->start + 1;
 		if (total_bytes >= max_bytes)
 			break;
-		if (!node)
-			break;
+		state = next_state(state);
 	}
 out:
 	spin_unlock(&tree->lock);
@@ -1629,8 +1620,8 @@ u64 count_range_bits(struct extent_io_tree *tree,
 	if (!node)
 		goto out;
 
-	while (1) {
-		state = rb_entry(node, struct extent_state, rb_node);
+	state = rb_entry(node, struct extent_state, rb_node);
+	while (state) {
 		if (state->start > search_end)
 			break;
 		if (contig && found && state->start > last + 1)
@@ -1648,9 +1639,7 @@ u64 count_range_bits(struct extent_io_tree *tree,
 		} else if (contig && found) {
 			break;
 		}
-		node = rb_next(node);
-		if (!node)
-			break;
+		state = next_state(state);
 	}
 out:
 	spin_unlock(&tree->lock);
@@ -1676,9 +1665,11 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		node = &cached->rb_node;
 	else
 		node = tree_search(tree, start);
-	while (node && start <= end) {
-		state = rb_entry(node, struct extent_state, rb_node);
+	if (!node)
+		goto out;
 
+	state = rb_entry(node, struct extent_state, rb_node);
+	while (state && start <= end) {
 		if (filled && state->start > start) {
 			bitset = 0;
 			break;
@@ -1702,13 +1693,13 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		start = state->end + 1;
 		if (start > end)
 			break;
-		node = rb_next(node);
-		if (!node) {
-			if (filled)
-				bitset = 0;
-			break;
-		}
+		state = next_state(state);
 	}
+
+	/* We ran out of states and were still inside of our range. */
+	if (filled && !state)
+		bitset = 0;
+out:
 	spin_unlock(&tree->lock);
 	return bitset;
 }
-- 
2.26.3

