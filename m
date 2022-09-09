Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA82B5B41DA
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiIIVyc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiIIVy2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:28 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70D3E25
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:23 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id m9so2283162qvv.7
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=37ITjuqXN/bU0OZlQn3yRW7PPr3lMEK9VWCoUPZurx4=;
        b=XbmS2dfq5PczpPfvpvhskGv0u4Sc95ThWbq3aQyG6aDHps56duJQ6P7aQHzqUUranF
         WgNsSt4zUUkriPLzUpgQTi9+8I/bLRYxKrKCYJDLVj1Gcs8pdFhJsS9fm7pP/95PKh+p
         gCE/nWGjdJo/8m3kdG0/9hF0qfzWE+8pP79q2vyFB+qJlgqW+EL2TCUpDHwy/3HpIzYd
         eE0uPD2C8qgBw3ZqjWSivMlWTV/KasnyUDFyBN9e5MjSNzqLP+ymknEk8inTjYdvedvK
         lTX64Z/IxaDAhwV/snX1BBNwgaq/6Xrw2LP4CtZCEG4B6hE7wzERjfuxJxtMMv26Hvtd
         CQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=37ITjuqXN/bU0OZlQn3yRW7PPr3lMEK9VWCoUPZurx4=;
        b=ALROapgpLsUH6HvuOpp2sOE7KmCP83uZex+ZxDFchCPcYajXHSy9fmek8lPR8GtfhM
         GvUaLu7ckX10wUTLPjWoiY4y+ZF/1tY5Aeic5RzgJ3y8ildgmJjcqQ3moseDmgYJY4MQ
         nFvE63jM6UTq068ln5n5Hi1G6QV7GavkW1KEOywUDC5FH+tbkbRs4TvqTl40B2C8w0J2
         q1Ajh/rn3tTIqvAsxKs1noX0av+g7gc5TlB/gUwnqJCqOO557/4GgTPFLcLHScMuM1Ok
         wzKk5T/irjjQYpwTcyI6xIYnvk08laUjT5cxoeB4TjLIIv38tsRHyD5+R+zoZ2V1p6VO
         HuYA==
X-Gm-Message-State: ACgBeo2Frqhvbi+JPICnEDQGEI52LXtcr2/0BBFre+ROYcULRbEIjqYw
        TRTdmTNYpfLBIzCDzFxSzHyJJO1/wzEhDA==
X-Google-Smtp-Source: AA6agR64sX6Q0ALHzPP2mPoREw4hEywQEiWygVmlTnjUzYXTJyIbbSr2+5wvOulpuNiqEkmoRbyj2A==
X-Received: by 2002:a05:6214:27c6:b0:4ac:94f9:c727 with SMTP id ge6-20020a05621427c600b004ac94f9c727mr1997243qvb.51.1662760462998;
        Fri, 09 Sep 2022 14:54:22 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f8-20020a05620a408800b006bc192d277csm1643062qko.10.2022.09.09.14.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 22/36] btrfs: make tree_search_for_insert return extent_state
Date:   Fri,  9 Sep 2022 17:53:35 -0400
Message-Id: <f25454dd1f650a62b4b29a97d117f23400027803.1662760286.git.josef@toxicpanda.com>
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
 fs/btrfs/extent-io-tree.c | 43 +++++++++++++++------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 5cfe66941ade..a1cfd690db18 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -220,15 +220,15 @@ static inline struct extent_state *next_state(struct extent_state *state)
  * If no such entry exists, return pointer to entry that ends before @offset
  * and fill parameters @node_ret and @parent_ret, ie. does not return NULL.
  */
-static inline struct rb_node *tree_search_for_insert(struct extent_io_tree *tree,
-						     u64 offset,
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
@@ -239,7 +239,7 @@ static inline struct rb_node *tree_search_for_insert(struct extent_io_tree *tree
 		else if (offset > entry->end)
 			node = &(*node)->rb_right;
 		else
-			return *node;
+			return entry;
 	}
 
 	if (node_ret)
@@ -248,12 +248,10 @@ static inline struct rb_node *tree_search_for_insert(struct extent_io_tree *tree
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
 
 /**
@@ -317,8 +315,7 @@ static inline struct rb_node *tree_search_prev_next(struct extent_io_tree *tree,
  */
 static inline struct extent_state *tree_search(struct extent_io_tree *tree, u64 offset)
 {
-	struct rb_node *n = tree_search_for_insert(tree, offset, NULL, NULL);
-	return (n) ? rb_entry(n, struct extent_state, rb_node) : NULL;
+	return tree_search_for_insert(tree, offset, NULL, NULL);
 }
 
 static void extent_io_tree_panic(struct extent_io_tree *tree, int err)
@@ -972,7 +969,6 @@ int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
 {
 	struct extent_state *state;
 	struct extent_state *prealloc = NULL;
-	struct rb_node *node;
 	struct rb_node **p;
 	struct rb_node *parent;
 	int err = 0;
@@ -1002,17 +998,15 @@ int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
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
@@ -1022,7 +1016,6 @@ int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
 		prealloc = NULL;
 		goto out;
 	}
-	state = rb_entry(node, struct extent_state, rb_node);
 hit_next:
 	last_start = state->start;
 	last_end = state->end;
@@ -1208,7 +1201,6 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 {
 	struct extent_state *state;
 	struct extent_state *prealloc = NULL;
-	struct rb_node *node;
 	struct rb_node **p;
 	struct rb_node *parent;
 	int err = 0;
@@ -1238,18 +1230,16 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
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
@@ -1262,7 +1252,6 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		prealloc = NULL;
 		goto out;
 	}
-	state = rb_entry(node, struct extent_state, rb_node);
 hit_next:
 	last_start = state->start;
 	last_end = state->end;
-- 
2.26.3

