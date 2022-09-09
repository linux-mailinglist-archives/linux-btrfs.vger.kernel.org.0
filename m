Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205E55B41D1
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiIIVya (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiIIVy2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:28 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE70260
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:22 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id ml1so2298323qvb.1
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=LqAJ+9wD7xVuvVryKVLMmz/qAdDNUaoPbnnrJEhmQXI=;
        b=sCuzXkIOFLZ+eaI6yvOKWzOmjR9Ayl1qGQZKuhBVefXqEiCBiCfAQkRGPQWzs3opD5
         ZCu1XMzr0h59xaaH8SWtNe55uq63FwXlxnk9oXKy74NaalbqBhnWyTFdZNvWdzJA1v4Q
         y3Dz8XBnWyqIWMUtODBdGWleRtzJmMagLcUuREp2ngguJt0NrfLy+XMF66AxdvWW02ag
         U73gXhcKXnsFDDsE3Fm1ClvoiU9knbWM8YgIHDnPwqSkSqHHXgeNYOSeHBk+CJEYuejY
         TDi7zB9xg6wEcuMMPkawAY9f4lGf0u7wjmXD2B5woxecSSLPJQvfeOdSp09qRV1RZOnn
         FYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LqAJ+9wD7xVuvVryKVLMmz/qAdDNUaoPbnnrJEhmQXI=;
        b=chSk9QcUGTmOavDg65O1zdQocJAQRw7ODDMp5ccsUmEEhaKUbU3vYOTB8kqiftLj+u
         CP3dRh+EXmvZ3TNWQ0cadfLBaqf4r3B+j1Zwfuzn+ot5EK3HNKQOgysyXv3mpm/eHPWC
         2Avai+HaZzp6IFPOYJJ4jUK1zIy9k0pBIKmqunDvbAQxhXRVSCO5TC76fsAyFhHufaFt
         nmw8l0M+Ene4r8CU96geQI7YEhdo8POuoUvEewa1a9e2lb+mi3YcWOu7LYZNht8SK/SD
         m92oEUlBKXQokFupVihJ+q5O4nHdCVd3mfWII8p7Yed3lL+pBFnoioz5sLlL6YRO2hhi
         3GGA==
X-Gm-Message-State: ACgBeo0W841sswBQApgskRJqlLRqbttgZhwZIUBrQ9qoV9H6+iiJKJnn
        Oz7bLbx6Q5ioT+I/O0+OKCxpG/l0UJTLaA==
X-Google-Smtp-Source: AA6agR5/hx/zsbfsR8jQlBXB4FvUJAa4eK63Liy905xhkoNyWyD+xuV9PR4BkvRMkgmgZCXA38OfUQ==
X-Received: by 2002:a05:6214:508f:b0:4aa:a63d:ad12 with SMTP id kk15-20020a056214508f00b004aaa63dad12mr14524347qvb.123.1662760461563;
        Fri, 09 Sep 2022 14:54:21 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t137-20020a37aa8f000000b006b8e63dfffbsm1209317qke.58.2022.09.09.14.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:21 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 21/36] btrfs: make tree_search return struct extent_state
Date:   Fri,  9 Sep 2022 17:53:34 -0400
Message-Id: <2c3ba5eed29cea277db76d296623260756baf82e.1662760286.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662760286.git.josef@toxicpanda.com>
References: <cover.1662760286.git.josef@toxicpanda.com>
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
index f3034524acdf..5cfe66941ade 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -315,9 +315,10 @@ static inline struct rb_node *tree_search_prev_next(struct extent_io_tree *tree,
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
 
 static void extent_io_tree_panic(struct extent_io_tree *tree, int err)
@@ -573,7 +574,6 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	struct extent_state *state;
 	struct extent_state *cached;
 	struct extent_state *prealloc = NULL;
-	struct rb_node *node;
 	u64 last_end;
 	int err;
 	int clear = 0;
@@ -624,10 +624,9 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
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
@@ -740,7 +739,6 @@ static void wait_on_state(struct extent_io_tree *tree,
 void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits)
 {
 	struct extent_state *state;
-	struct rb_node *node;
 
 	btrfs_debug_check_extent_io_range(tree, start, end);
 
@@ -751,11 +749,10 @@ void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits)
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
 
@@ -806,25 +803,18 @@ static void cache_state(struct extent_state *state,
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
 		if (state->end >= start && (state->state & bits))
 			return state;
-
 		state = next_state(state);
 	}
-out:
 	return NULL;
 }
 
@@ -920,7 +910,6 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 			       u64 *end, u64 max_bytes,
 			       struct extent_state **cached_state)
 {
-	struct rb_node *node;
 	struct extent_state *state;
 	u64 cur_start = *start;
 	bool found = false;
@@ -932,13 +921,12 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
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
@@ -1536,7 +1524,6 @@ u64 count_range_bits(struct extent_io_tree *tree,
 		     u64 *start, u64 search_end, u64 max_bytes,
 		     u32 bits, int contig)
 {
-	struct rb_node *node;
 	struct extent_state *state;
 	u64 cur_start = *start;
 	u64 total_bytes = 0;
@@ -1555,11 +1542,7 @@ u64 count_range_bits(struct extent_io_tree *tree,
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
@@ -1595,19 +1578,14 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
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
@@ -1638,7 +1616,6 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	/* We ran out of states and were still inside of our range. */
 	if (filled && !state)
 		bitset = 0;
-out:
 	spin_unlock(&tree->lock);
 	return bitset;
 }
-- 
2.26.3

