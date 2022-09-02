Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992065AB94C
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiIBURU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiIBURJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:17:09 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2DCCC32E
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:17:08 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id q8so2252200qvr.9
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=m4FfrR3uXRAR+xtQeLgJeMiHsrg7F7P/ODE/4VHRLbs=;
        b=SJTkVpNPqPlR+KBP8hnkU5d7iYf+5Dm9XuLQasKjqRbl4pbMW/cyGMSfjQddiI4XGC
         ASkehg3KHX0tu3ZRux1w/LV7LPNEE0ielaOuku3Ja1aIDb1XKDZEDU0XUfOHcHJWGBAx
         Z3B/3WtNe5QSyhlRZ6hXqZsoY+YE1pO4TjzDfavGTY+nRNa9fGFjkYi7fC1pQ15Au0Ih
         cMgo7gNXHcc9r5PEZcFIiUWsAp46xxzVoH8xzRXPNYFWKiAUbCLYGHph7xFsX7AsknSz
         69b9JnMo4tam7tvIp27/OTJwctVkuPhRJaV/0QErtcf5OpO1ZjqraAMaJg1yCKcbTEsK
         yy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=m4FfrR3uXRAR+xtQeLgJeMiHsrg7F7P/ODE/4VHRLbs=;
        b=L2qCSJsodAChAW3encb2ElrvhcyrdVUEtMBwtduWyoGV0ZsuAtqHOULL1UihK6nfp/
         cbDnEU5+3jKmaUcQF/MoqLB3pBpeN8Wvmq0+nsGZN74UIOKlxlhEt/3AXw+noh/Yo3c9
         eAdsiPTKKYRkNvaP83msoG6XYIxLik9qauw/LONmcBmqVDi2OF25rI1evtIgSK5/ae+S
         767erwm0GUch02K+J/YAyv0BXL3Bq4kobYQDBlEzBSQzS4k/6rlFNgoW00hmovyb2imb
         N66/mx0VYb4PPg+CEdVzXo9vuhCbUgwdaTvR0XMWJ0Cgb045+6l/C7kjKCRMo3dErmMZ
         DSvQ==
X-Gm-Message-State: ACgBeo0c/eP3jgdVk+rkkyaA19x17BtQNx9tH6UrruyYRW701yS8gBsi
        X9jMBsnLCBt+5pHiByhztNv6R5pzU3HIFA==
X-Google-Smtp-Source: AA6agR7QI08M4v90Zkp0Xn8RnAqdDqZbX2tII4PjQ1fByrXtFRRkiHUmaKp4yv0NKTesT9Oh+IYzTw==
X-Received: by 2002:a0c:e082:0:b0:498:f8ed:9a94 with SMTP id l2-20020a0ce082000000b00498f8ed9a94mr27966716qvk.0.1662149826951;
        Fri, 02 Sep 2022 13:17:06 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e5-20020ac80105000000b00342b7e4241fsm1576573qtg.77.2022.09.02.13.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:17:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 16/31] btrfs: make tree_search_for_insert return extent_state
Date:   Fri,  2 Sep 2022 16:16:21 -0400
Message-Id: <d88dc92a466bb1e9cbf07b3ef618c1a863444850.1662149276.git.josef@toxicpanda.com>
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

We use this to search for an extent state, or return the nodes we need
to insert a new extent state.  This means we have the following pattern

node = tree_search_for_insert();
if (!node) {
	/* alloc and insert. */
	goto again;
}
state = rb_entry(node, struct extent_state, rb_node);

we don't use the node for anything else.  Making
tree_search_for_insert() return the extent_state means we can drop the
rb_node and clean this up by eliminating the rb_entry.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 61 ++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index f39eb5e816eb..82a18c233fa0 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -227,6 +227,15 @@ int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end)
 	return 1;
 }
 
+static struct extent_state *next_state(struct extent_state *state)
+{
+	struct rb_node *next = rb_next(&state->rb_node);
+	if (next)
+		return rb_entry(next, struct extent_state, rb_node);
+	else
+		return NULL;
+}
+
 /**
  * Search @tree for an entry that contains @offset. Such entry would have
  * entry->start <= offset && entry->end >= offset.
@@ -244,15 +253,15 @@ int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end)
  * If no such entry exists, return pointer to entry that ends before @offset
  * and fill parameters @node_ret and @parent_ret, ie. does not return NULL.
  */
-static inline struct rb_node *tree_search_for_insert(struct extent_io_tree *tree,
-					             u64 offset,
-						     struct rb_node ***node_ret,
-						     struct rb_node **parent_ret)
+static inline struct extent_state *tree_search_for_insert(struct extent_io_tree *tree,
+							  u64 offset,
+							  struct rb_node ***node_ret,
+							  struct rb_node **parent_ret)
 {
 	struct rb_root *root = &tree->state;
 	struct rb_node **node = &root->rb_node;
 	struct rb_node *prev = NULL;
-	struct extent_state *entry;
+	struct extent_state *entry = NULL;
 
 	while (*node) {
 		prev = *node;
@@ -263,7 +272,7 @@ static inline struct rb_node *tree_search_for_insert(struct extent_io_tree *tree
 		else if (offset > entry->end)
 			node = &(*node)->rb_right;
 		else
-			return *node;
+			return entry;
 	}
 
 	if (node_ret)
@@ -272,12 +281,10 @@ static inline struct rb_node *tree_search_for_insert(struct extent_io_tree *tree
 		*parent_ret = prev;
 
 	/* Search neighbors until we find the first one past the end */
-	while (prev && offset > entry->end) {
-		prev = rb_next(prev);
-		entry = rb_entry(prev, struct extent_state, rb_node);
-	}
+	while (entry && offset > entry->end)
+		entry = next_state(entry);
 
-	return prev;
+	return entry;
 }
 
 /*
@@ -285,8 +292,7 @@ static inline struct rb_node *tree_search_for_insert(struct extent_io_tree *tree
  */
 static inline struct extent_state *tree_search(struct extent_io_tree *tree, u64 offset)
 {
-	struct rb_node *n = tree_search_for_insert(tree, offset, NULL, NULL);
-	return (n) ? rb_entry(n, struct extent_state, rb_node) : NULL;
+	return tree_search_for_insert(tree, offset, NULL, NULL);
 }
 
 /**
@@ -511,15 +517,6 @@ static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
 	return 0;
 }
 
-static struct extent_state *next_state(struct extent_state *state)
-{
-	struct rb_node *next = rb_next(&state->rb_node);
-	if (next)
-		return rb_entry(next, struct extent_state, rb_node);
-	else
-		return NULL;
-}
-
 /*
  * utility function to clear some bits in an extent state struct.
  * it will optionally wake up anyone waiting on this state (wake == 1).
@@ -850,7 +847,6 @@ int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
 {
 	struct extent_state *state;
 	struct extent_state *prealloc = NULL;
-	struct rb_node *node;
 	struct rb_node **p;
 	struct rb_node *parent;
 	int err = 0;
@@ -880,17 +876,15 @@ int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
 	if (cached_state && *cached_state) {
 		state = *cached_state;
 		if (state->start <= start && state->end > start &&
-		    extent_state_in_tree(state)) {
-			node = &state->rb_node;
+		    extent_state_in_tree(state))
 			goto hit_next;
-		}
 	}
 	/*
 	 * this search will find all the extents that end after
 	 * our range starts.
 	 */
-	node = tree_search_for_insert(tree, start, &p, &parent);
-	if (!node) {
+	state = tree_search_for_insert(tree, start, &p, &parent);
+	if (!state) {
 		prealloc = alloc_extent_state_atomic(prealloc);
 		BUG_ON(!prealloc);
 		prealloc->start = start;
@@ -900,7 +894,6 @@ int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
 		prealloc = NULL;
 		goto out;
 	}
-	state = rb_entry(node, struct extent_state, rb_node);
 hit_next:
 	last_start = state->start;
 	last_end = state->end;
@@ -1086,7 +1079,6 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 {
 	struct extent_state *state;
 	struct extent_state *prealloc = NULL;
-	struct rb_node *node;
 	struct rb_node **p;
 	struct rb_node *parent;
 	int err = 0;
@@ -1116,18 +1108,16 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	if (cached_state && *cached_state) {
 		state = *cached_state;
 		if (state->start <= start && state->end > start &&
-		    extent_state_in_tree(state)) {
-			node = &state->rb_node;
+		    extent_state_in_tree(state))
 			goto hit_next;
-		}
 	}
 
 	/*
 	 * this search will find all the extents that end after
 	 * our range starts.
 	 */
-	node = tree_search_for_insert(tree, start, &p, &parent);
-	if (!node) {
+	state = tree_search_for_insert(tree, start, &p, &parent);
+	if (!state) {
 		prealloc = alloc_extent_state_atomic(prealloc);
 		if (!prealloc) {
 			err = -ENOMEM;
@@ -1140,7 +1130,6 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		prealloc = NULL;
 		goto out;
 	}
-	state = rb_entry(node, struct extent_state, rb_node);
 hit_next:
 	last_start = state->start;
 	last_end = state->end;
-- 
2.26.3

