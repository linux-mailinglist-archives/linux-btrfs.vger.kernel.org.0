Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CCA5B41E3
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiIIVyg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiIIVy3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:29 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B198BF56
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:25 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id h22so2359442qtu.2
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=EzXzUC4fBt366+YXHHUv28uiXyNRdIg1O9Ebkxa9GoY=;
        b=TIW5n1/Gf60natV+xQq19bj/9HW72CFZ5p4je1T+khf+uQGG7BAHP4CEOUE96DknNq
         qYlauZF09qTOrfNPnK87YshlE4I0vJKdsbKV7nJujCBvSVZ7BqIZNaLUW0AQlGhGAViz
         f6SFeS4Tfctt2DGC9Fz90iLsXiRc9UADbZypwacMw5/wmfmxO5QToh0CmwtohRQJU90E
         0nZs4kkPszOqdWDAXgV99AgB0C1CfDgjGXWOcFYB+IepvEYKMy70xn2B7K2vwVFDvni3
         +3nkVjuVytDIZIfWY4ttUEhAQm0xzcaWgoz+K0Dhx7spIQ8f8KKDXNpG/pQoRimvlB5k
         4RSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EzXzUC4fBt366+YXHHUv28uiXyNRdIg1O9Ebkxa9GoY=;
        b=kJBZ0y6+XrEMjxXX9zTQYjVJb9jHzUO4VR1v+hXsnITaYrbiQx8jrfzGykP/VtxaMK
         7/DrdhIK6ixuUmJsu/v2Zf7pizRoiz21XoSr7tnPoRShKzJoTM0wmocthIFw02SEgsP1
         B4pyXPbooCC2R5BErKeiVB2KCxlFnv0XyEnTu0zZ/3XQ/pAtc/GMjq3VnJ98hGe+QNsZ
         1RDEqwEPIjtNH5kkiotI0jd9KgHc26BlbVVluqr6UnsqbroZaB/1rrsgxVGsmkkx9ljD
         D8d2EUoJpJsFVHU5DCfF+epBHEdFMbKEBF+3SfRttW5qsPDn6k2etrymB8gmT546N2Kw
         M52Q==
X-Gm-Message-State: ACgBeo16glbOUEXNQpr66Rb80zqI7rnpaZsE4U3/A7/G+JYY7UbLN5cc
        GpFXFF7bRIjgdRQe/5z6sRKehhKEAx9w8A==
X-Google-Smtp-Source: AA6agR4D4VfUikuvoupVa38wKpgXFYaDPMZXTLMzmuVz+Uvx2fPkaO687YABdWXEyOOmpWNGyPKh1Q==
X-Received: by 2002:ac8:7dc4:0:b0:343:622d:5fda with SMTP id c4-20020ac87dc4000000b00343622d5fdamr13941343qte.197.1662760464496;
        Fri, 09 Sep 2022 14:54:24 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y29-20020a37f61d000000b006cbd60c14c9sm1254012qkj.35.2022.09.09.14.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:24 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 23/36] btrfs: make tree_search_prev_next return extent_state's
Date:   Fri,  9 Sep 2022 17:53:36 -0400
Message-Id: <a84241f2143d380d74b8a199f1dc04b21a2c807d.1662760286.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662760286.git.josef@toxicpanda.com>
References: <cover.1662760286.git.josef@toxicpanda.com>
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
 fs/btrfs/extent-io-tree.c | 80 +++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index a1cfd690db18..9b3380c353e7 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -203,6 +203,15 @@ static inline struct extent_state *next_state(struct extent_state *state)
 		return NULL;
 }
 
+static inline struct extent_state *prev_state(struct extent_state *state)
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
@@ -266,46 +275,39 @@ static inline struct extent_state *tree_search_for_insert(struct extent_io_tree
  * such entry exists, then return NULL and fill @prev_ret and @next_ret.
  * Otherwise return the found entry and other pointers are left untouched.
  */
-static inline struct rb_node *tree_search_prev_next(struct extent_io_tree *tree,
-						    u64 offset,
-						    struct rb_node **prev_ret,
-						    struct rb_node **next_ret)
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
@@ -1409,14 +1411,14 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
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
@@ -1424,24 +1426,22 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
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
+
 		/*
-		 * At this point 'node' either contains 'start' or start is
-		 * before 'node'
+		 * At this point 'state' either contains 'start' or start is
+		 * before 'state'
 		 */
-		state = rb_entry(node, struct extent_state, rb_node);
-
 		if (in_range(start, state->start, state->end - state->start + 1)) {
 			if (state->state & bits) {
 				/*
@@ -1475,13 +1475,10 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 			 * 0   |
 			 *    start
 			 */
-			if (prev) {
-				state = rb_entry(prev, struct extent_state,
-						 rb_node);
-				*start_ret = state->end + 1;
-			} else {
+			if (prev)
+				*start_ret = prev->end + 1;
+			else
 				*start_ret = 0;
-			}
 			break;
 		}
 	}
@@ -1490,7 +1487,6 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 	 * Find the longest stretch from start until an entry which has the
 	 * bits set
 	 */
-	state = rb_entry(node, struct extent_state, rb_node);
 	while (state) {
 		if (state->end >= start && !(state->state & bits)) {
 			*end_ret = state->end;
-- 
2.26.3

