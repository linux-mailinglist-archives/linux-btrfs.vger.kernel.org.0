Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235E25AB947
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiIBURT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiIBURL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:17:11 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCB3CE303
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:17:09 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id x14so2270176qvr.6
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=+AwI6eBo+LqisNJlM74dVMhtCZp4vIVOIvZM4d3rQuU=;
        b=dgmB9DF+k6OBwoGBie9BHc8xWFWYpC2kty/GOOfhTObD1ocwqnDvInIHzkFVsnY5tm
         BBcrDkpQn+vpdss+Yy/x+nA8OvA8ZOenW8YOEakFv1cEPjWqpJiBpMCxpX8Pyw9vwNwm
         GXmYL7GFfOGhGD9aePt4mzObSFWVKMFCMYZjcP39zx7ZUtIEFTaoXWIDULtfp2/l53Di
         0gT8hcT2m1J8G3ppSheJ6vVi95xLDb6ZknlPq0l5GnxqzkMlxHhVYh/W0u7fbC/XfLUx
         iQpZPmG270Ap+VPTU1mKOg8ZSnC7jcacPYSdTl7WGqTaazWcA0kJQ4Z8gSbP5xihzwPo
         6/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+AwI6eBo+LqisNJlM74dVMhtCZp4vIVOIvZM4d3rQuU=;
        b=O5QGkXhySpqRUTSZAiyPtXMcL+8F1Lk7K+vNQZQS0G9nVIUoBjq9sRNvkRJa1/Uxw3
         T6Bdq6RNP2sixdJ6yEcIlvrFqsmyqdIbfwFkf+sjPJJ5mbLdJ5UDTBtTYowQ63gkawNv
         EgtTz9HVRNj6rYNdqL9WMfibQkLElBDfxYuf+havY6UAXRjjKPEqA8OFADqJtKPSidvC
         ujPRRWY+IdoN4gNK9cGe8K+PIGcuKLCEYG0tyJ31Odt/ItQisNp5yjgLS1lrf98kXjvw
         a/k6hGcFUUOxjDR8qNST44tpXZEYoJTM3So+QzR1AhBy8Jb5sEbMCgOCedaToC5uow7F
         9WVQ==
X-Gm-Message-State: ACgBeo3oW27ATGZXSouq4tSRTIabC5jARtEdQsYkhWKQ7LmfKQwg1zZk
        cDAgjm396DNubsYIzQIBGhH5v3VSlAu3Ag==
X-Google-Smtp-Source: AA6agR64Tej5JeiVAGdEnw49ezgMirRimpokh8CbTdlYqYrcDDy7Lpt2oXhgTpP4bkHwjI8E2IjFDQ==
X-Received: by 2002:a05:6214:1c8c:b0:473:408f:ddd6 with SMTP id ib12-20020a0562141c8c00b00473408fddd6mr31483245qvb.74.1662149828673;
        Fri, 02 Sep 2022 13:17:08 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n22-20020ac86756000000b0034355a352d1sm1547605qtp.92.2022.09.02.13.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:17:08 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 17/31] btrfs: make tree_search_prev_next return extent_state's
Date:   Fri,  2 Sep 2022 16:16:22 -0400
Message-Id: <102bb920a9f6dec6e327f1f67d54ff850362b18c.1662149276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662149276.git.josef@toxicpanda.com>
References: <cover.1662149276.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of doing the rb_entry again once we return from this function,
simply return the actual states themselves, and then clean up the only
user of this helper to handle states instead of nodes.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 73 ++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 82a18c233fa0..9bf82c7146a8 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -236,6 +236,15 @@ static struct extent_state *next_state(struct extent_state *state)
 		return NULL;
 }
 
+static struct extent_state *prev_state(struct extent_state *state)
+{
+	struct rb_node *next = rb_prev(&state->rb_node);
+	if (next)
+		return rb_entry(next, struct extent_state, rb_node);
+	else
+		return NULL;
+}
+
 /**
  * Search @tree for an entry that contains @offset. Such entry would have
  * entry->start <= offset && entry->end >= offset.
@@ -307,46 +316,39 @@ static inline struct extent_state *tree_search(struct extent_io_tree *tree, u64
  * such entry exists, then return NULL and fill @prev_ret and @next_ret.
  * Otherwise return the found entry and other pointers are left untouched.
  */
-static struct rb_node *tree_search_prev_next(struct extent_io_tree *tree,
-					     u64 offset,
-					     struct rb_node **prev_ret,
-					     struct rb_node **next_ret)
+static struct extent_state *tree_search_prev_next(struct extent_io_tree *tree,
+						  u64 offset,
+						  struct extent_state **prev_ret,
+						  struct extent_state **next_ret)
 {
 	struct rb_root *root = &tree->state;
 	struct rb_node **node = &root->rb_node;
-	struct rb_node *prev = NULL;
-	struct rb_node *orig_prev = NULL;
-	struct extent_state *entry;
+	struct extent_state *orig_prev;
+	struct extent_state *entry = NULL;
 
 	ASSERT(prev_ret);
 	ASSERT(next_ret);
 
 	while (*node) {
-		prev = *node;
-		entry = rb_entry(prev, struct extent_state, rb_node);
+		entry = rb_entry(*node, struct extent_state, rb_node);
 
 		if (offset < entry->start)
 			node = &(*node)->rb_left;
 		else if (offset > entry->end)
 			node = &(*node)->rb_right;
 		else
-			return *node;
+			return entry;
 	}
 
-	orig_prev = prev;
-	while (prev && offset > entry->end) {
-		prev = rb_next(prev);
-		entry = rb_entry(prev, struct extent_state, rb_node);
-	}
-	*next_ret = prev;
-	prev = orig_prev;
+	orig_prev = entry;
+	while (entry && offset > entry->end)
+		entry = next_state(entry);
+	*next_ret = entry;
+	entry = orig_prev;
 
-	entry = rb_entry(prev, struct extent_state, rb_node);
-	while (prev && offset < entry->start) {
-		prev = rb_prev(prev);
-		entry = rb_entry(prev, struct extent_state, rb_node);
-	}
-	*prev_ret = prev;
+	while (entry && offset < entry->start)
+		entry = prev_state(entry);
+	*prev_ret = entry;
 
 	return NULL;
 }
@@ -1415,14 +1417,14 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 				 u64 *start_ret, u64 *end_ret, u32 bits)
 {
 	struct extent_state *state;
-	struct rb_node *node, *prev = NULL, *next;
+	struct extent_state *prev = NULL, *next;
 
 	spin_lock(&tree->lock);
 
 	/* Find first extent with bits cleared */
 	while (1) {
-		node = tree_search_prev_next(tree, start, &prev, &next);
-		if (!node && !next && !prev) {
+		state = tree_search_prev_next(tree, start, &prev, &next);
+		if (!state && !next && !prev) {
 			/*
 			 * Tree is completely empty, send full range and let
 			 * caller deal with it
@@ -1430,24 +1432,21 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 			*start_ret = 0;
 			*end_ret = -1;
 			goto out;
-		} else if (!node && !next) {
+		} else if (!state && !next) {
 			/*
 			 * We are past the last allocated chunk, set start at
 			 * the end of the last extent.
 			 */
-			state = rb_entry(prev, struct extent_state, rb_node);
-			*start_ret = state->end + 1;
+			*start_ret = prev->end + 1;
 			*end_ret = -1;
 			goto out;
-		} else if (!node) {
-			node = next;
+		} else if (!state) {
+			state = next;
 		}
 		/*
 		 * At this point 'node' either contains 'start' or start is
 		 * before 'node'
 		 */
-		state = rb_entry(node, struct extent_state, rb_node);
-
 		if (in_range(start, state->start, state->end - state->start + 1)) {
 			if (state->state & bits) {
 				/*
@@ -1481,13 +1480,10 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 			 * 0   |
 			 *    start
 			 */
-			if (prev) {
-				state = rb_entry(prev, struct extent_state,
-						 rb_node);
+			if (prev)
 				*start_ret = state->end + 1;
-			} else {
+			else
 				*start_ret = 0;
-			}
 			break;
 		}
 	}
@@ -1496,7 +1492,6 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 	 * Find the longest stretch from start until an entry which has the
 	 * bits set
 	 */
-	state = rb_entry(node, struct extent_state, rb_node);
 	while (state) {
 		if (state->end >= start && !(state->state & bits)) {
 			*end_ret = state->end;
-- 
2.26.3

