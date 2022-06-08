Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B787543955
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 18:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343515AbiFHQr6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 12:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245745AbiFHQry (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 12:47:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48014504C
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 09:47:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7005B1F997;
        Wed,  8 Jun 2022 16:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654706872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8q0+qHN0/EHHXEkSojoc9/jN0w1B2YG/gnelxufubbg=;
        b=S/yrvX9/H3y3eqkxQTQzBB9zLDOU9YS4WeqyoylaRGlGUAY0h9Iqumx51R/xIWHDwfNbeE
        odpA/6+ORVafNR11pf2r21TJ2ct+Ula7MuqDT3ulfxLj+jZrGab6EDrdz2axIQVjHGfCip
        CWKa1TDzxDXMOFE4C7H8ZuRMg3MGnRA=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 659272C141;
        Wed,  8 Jun 2022 16:47:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D585ADA883; Wed,  8 Jun 2022 18:43:23 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/9] btrfs: open code rbtree search in insert_state
Date:   Wed,  8 Jun 2022 18:43:23 +0200
Message-Id: <3b36c2631779e51b57e8ded3ffd6b7f7e51b927e.1654706034.git.dsterba@suse.com>
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

The rbtree search is a known pattern and can be open coded, allowing to
remove the tree_insert and further cleanups.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 80 ++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c39f8674b6ce..429096fc8899 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -368,42 +368,6 @@ void free_extent_state(struct extent_state *state)
 	}
 }
 
-static struct rb_node *tree_insert(struct rb_root *root,
-				   struct rb_node *search_start,
-				   u64 offset,
-				   struct rb_node *node,
-				   struct rb_node ***p_in,
-				   struct rb_node **parent_in)
-{
-	struct rb_node **p;
-	struct rb_node *parent = NULL;
-	struct tree_entry *entry;
-
-	if (p_in && parent_in) {
-		p = *p_in;
-		parent = *parent_in;
-		goto do_insert;
-	}
-
-	p = search_start ? &search_start : &root->rb_node;
-	while (*p) {
-		parent = *p;
-		entry = rb_entry(parent, struct tree_entry, rb_node);
-
-		if (offset < entry->start)
-			p = &(*p)->rb_left;
-		else if (offset > entry->end)
-			p = &(*p)->rb_right;
-		else
-			return parent;
-	}
-
-do_insert:
-	rb_link_node(node, parent, p);
-	rb_insert_color(node, root);
-	return NULL;
-}
-
 /**
  * Search @tree for an entry that contains @offset. Such entry would have
  * entry->start <= offset && entry->end >= offset.
@@ -561,11 +525,12 @@ static void set_state_bits(struct extent_io_tree *tree,
  */
 static int insert_state(struct extent_io_tree *tree,
 			struct extent_state *state, u64 start, u64 end,
-			struct rb_node ***p,
-			struct rb_node **parent,
+			struct rb_node ***node_in,
+			struct rb_node **parent_in,
 			u32 *bits, struct extent_changeset *changeset)
 {
-	struct rb_node *node;
+	struct rb_node **node;
+	struct rb_node *parent;
 
 	if (end < start) {
 		btrfs_err(tree->fs_info,
@@ -577,15 +542,36 @@ static int insert_state(struct extent_io_tree *tree,
 
 	set_state_bits(tree, state, bits, changeset);
 
-	node = tree_insert(&tree->state, NULL, end, &state->rb_node, p, parent);
-	if (node) {
-		struct extent_state *found;
-		found = rb_entry(node, struct extent_state, rb_node);
-		btrfs_err(tree->fs_info,
-		       "found node %llu %llu on insert of %llu %llu",
-		       found->start, found->end, start, end);
-		return -EEXIST;
+	/* Caller provides the exact tree location */
+	if (node_in && parent_in) {
+		node = *node_in;
+		parent = *parent_in;
+		goto insert_new;
 	}
+
+	node = &tree->state.rb_node;
+	while (*node) {
+		struct tree_entry *entry;
+
+		parent = *node;
+		entry = rb_entry(parent, struct tree_entry, rb_node);
+
+		if (end < entry->start) {
+			node = &(*node)->rb_left;
+		} else if (end > entry->end) {
+			node = &(*node)->rb_right;
+		} else {
+			btrfs_err(tree->fs_info,
+			       "found node %llu %llu on insert of %llu %llu",
+			       entry->start, entry->end, start, end);
+			return -EEXIST;
+		}
+	}
+
+insert_new:
+	rb_link_node(&state->rb_node, parent, node);
+	rb_insert_color(&state->rb_node, &tree->state);
+
 	merge_state(tree, state);
 	return 0;
 }
-- 
2.36.1

