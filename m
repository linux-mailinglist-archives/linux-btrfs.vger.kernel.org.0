Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B87543954
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 18:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbiFHQsL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 12:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343557AbiFHQsK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 12:48:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4E4248E0
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 09:48:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 81C341F997;
        Wed,  8 Jun 2022 16:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654706887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGF+m9+ytgvzLnxBj7K+2PBVyMlDvmWyaitVufRlArc=;
        b=D/YXQspz9LOJ4o+6+lfJwRtnaBqJyKcazhV7MRGz5dmD5vkKMAbDb1jCCeQGX27mjqRqnz
        xdH6IIhVEbrqg6zGHA4BANH7lmzRZeVj+fw18KGHc0fpL2uc2zFoDx1JpqcBlodvW4JGJ0
        kiPH2oEYew0hvFDbUE9O1htwBnLzd2U=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 77E992C141;
        Wed,  8 Jun 2022 16:48:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E61A6DA883; Wed,  8 Jun 2022 18:43:38 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 9/9] btrfs: unify tree search helper returning prev and next nodes
Date:   Wed,  8 Jun 2022 18:43:38 +0200
Message-Id: <62221b54b299b54442187a9675e9a9532b6e4cbd.1654706034.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654706034.git.dsterba@suse.com>
References: <cover.1654706034.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Simplify helper to return only next and prev pointers, we don't need all
the node/parent/prev/next pointers of __etree_search as there are now
other specialized helpers. Rename parameters so they follow the naming.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 113 ++++++++++++++++++++++---------------------
 1 file changed, 57 insertions(+), 56 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ae27b7a5e56c..48c5432a7c8f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -374,9 +374,7 @@ void free_extent_state(struct extent_state *state)
  *
  * @tree:       the tree to search
  * @offset:     offset that should fall within an entry in @tree
- * @next_ret:   pointer to the first entry whose range ends after @offset
- * @prev_ret:   pointer to the first entry whose range begins before @offset
- * @p_ret:      pointer where new node should be anchored (used when inserting an
+ * @node_ret:   pointer where new node should be anchored (used when inserting an
  *	        entry in the tree)
  * @parent_ret: points to entry which would have been the parent of the entry,
  *               containing @offset
@@ -386,69 +384,76 @@ void free_extent_state(struct extent_state *state)
  * pointer arguments to the function are filled, otherwise the found entry is
  * returned and other pointers are left untouched.
  */
-static struct rb_node *__etree_search(struct extent_io_tree *tree, u64 offset,
-				      struct rb_node **next_ret,
-				      struct rb_node **prev_ret,
-				      struct rb_node ***p_ret,
-				      struct rb_node **parent_ret)
+static inline struct rb_node *tree_search_for_insert(struct extent_io_tree *tree,
+					             u64 offset,
+						     struct rb_node ***node_ret,
+						     struct rb_node **parent_ret)
 {
 	struct rb_root *root = &tree->state;
-	struct rb_node **n = &root->rb_node;
+	struct rb_node **node = &root->rb_node;
 	struct rb_node *prev = NULL;
-	struct rb_node *orig_prev = NULL;
 	struct tree_entry *entry;
-	struct tree_entry *prev_entry = NULL;
 
-	while (*n) {
-		prev = *n;
+	while (*node) {
+		prev = *node;
 		entry = rb_entry(prev, struct tree_entry, rb_node);
-		prev_entry = entry;
 
 		if (offset < entry->start)
-			n = &(*n)->rb_left;
+			node = &(*node)->rb_left;
 		else if (offset > entry->end)
-			n = &(*n)->rb_right;
+			node = &(*node)->rb_right;
 		else
-			return *n;
+			return *node;
 	}
 
-	if (p_ret)
-		*p_ret = n;
+	if (node_ret)
+		*node_ret = node;
 	if (parent_ret)
 		*parent_ret = prev;
 
-	if (next_ret) {
-		orig_prev = prev;
-		while (prev && offset > prev_entry->end) {
-			prev = rb_next(prev);
-			prev_entry = rb_entry(prev, struct tree_entry, rb_node);
-		}
-		*next_ret = prev;
-		prev = orig_prev;
+	/* Search neighbors until we find the first one past the end */
+	while (prev && offset > entry->end) {
+		prev = rb_next(prev);
+		entry = rb_entry(prev, struct tree_entry, rb_node);
 	}
 
-	if (prev_ret) {
-		prev_entry = rb_entry(prev, struct tree_entry, rb_node);
-		while (prev && offset < prev_entry->start) {
-			prev = rb_prev(prev);
-			prev_entry = rb_entry(prev, struct tree_entry, rb_node);
-		}
-		*prev_ret = prev;
-	}
-	return NULL;
+	return prev;
+}
+
+/*
+ * Inexact rb-tree search, return the next entry if @offset is not found
+ */
+static inline struct rb_node *tree_search(struct extent_io_tree *tree, u64 offset)
+{
+	return tree_search_for_insert(tree, offset, NULL, NULL);
 }
 
-static inline struct rb_node *
-tree_search_for_insert(struct extent_io_tree *tree,
-		       u64 offset,
-		       struct rb_node ***p_ret,
-		       struct rb_node **parent_ret)
+/**
+ * Search offset in the tree or fill neighbor rbtree node pointers.
+ *
+ * @tree:      the tree to search
+ * @offset:    offset that should fall within an entry in @tree
+ * @next_ret:  pointer to the first entry whose range ends after @offset
+ * @prev_ret:  pointer to the first entry whose range begins before @offset
+ *
+ * Return a pointer to the entry that contains @offset byte address. If no
+ * such entry exists, then return NULL and fill @prev_ret and @next_ret.
+ * Otherwise return the found entry and other pointers are left untouched.
+ */
+static struct rb_node *tree_search_prev_next(struct extent_io_tree *tree,
+					     u64 offset,
+					     struct rb_node **prev_ret,
+					     struct rb_node **next_ret)
 {
 	struct rb_root *root = &tree->state;
 	struct rb_node **node = &root->rb_node;
 	struct rb_node *prev = NULL;
+	struct rb_node *orig_prev = NULL;
 	struct tree_entry *entry;
 
+	ASSERT(prev_ret);
+	ASSERT(next_ret);
+
 	while (*node) {
 		prev = *node;
 		entry = rb_entry(prev, struct tree_entry, rb_node);
@@ -461,26 +466,22 @@ tree_search_for_insert(struct extent_io_tree *tree,
 			return *node;
 	}
 
-	if (p_ret)
-		*p_ret = node;
-	if (parent_ret)
-		*parent_ret = prev;
-
-	/* Search neighbors until we find the first one past the end */
+	orig_prev = prev;
 	while (prev && offset > entry->end) {
 		prev = rb_next(prev);
 		entry = rb_entry(prev, struct tree_entry, rb_node);
 	}
+	*next_ret = prev;
+	prev = orig_prev;
 
-	return prev;
-}
+	entry = rb_entry(prev, struct tree_entry, rb_node);
+	while (prev && offset < entry->start) {
+		prev = rb_prev(prev);
+		entry = rb_entry(prev, struct tree_entry, rb_node);
+	}
+	*prev_ret = prev;
 
-/*
- * Inexact rb-tree search, return the next entry if @offset is not found
- */
-static inline struct rb_node *tree_search(struct extent_io_tree *tree, u64 offset)
-{
-	return tree_search_for_insert(tree, offset, NULL, NULL);
+	return NULL;
 }
 
 /*
@@ -1687,7 +1688,7 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 
 	/* Find first extent with bits cleared */
 	while (1) {
-		node = __etree_search(tree, start, &next, &prev, NULL, NULL);
+		node = tree_search_prev_next(tree, start, &prev, &next);
 		if (!node && !next && !prev) {
 			/*
 			 * Tree is completely empty, send full range and let
-- 
2.36.1

