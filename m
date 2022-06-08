Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9630543957
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 18:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343546AbiFHQsH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 12:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343534AbiFHQsF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 12:48:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA59E4B1A
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 09:48:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 347E81F997;
        Wed,  8 Jun 2022 16:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654706883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/IvUCt6wH0+jSIAhZRPQ1NGhoM6j23Ne3AOQK9aCYb8=;
        b=Pqsk+zOgCR8tI4sHbuqHUznI9MIZa/Rn5IV5y+jlGPqx5+WkBZ7pde8V/nBpc9Ze9ttrW5
        tnaApcz0zi6t+iPv4thiAf97WdWTNnifK1gRLCG+vlQUfz9R7VYEu/WnaydQF1tt5fZLwc
        bxCWtDi+GL4RFtwbQp1enleUcZQQXf8=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2AE082C141;
        Wed,  8 Jun 2022 16:48:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9742BDA883; Wed,  8 Jun 2022 18:43:34 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 7/9] btrfs: open code inexact rbtree search in tree_search
Date:   Wed,  8 Jun 2022 18:43:34 +0200
Message-Id: <c549e3874b4855d0fecd11e9c668e4ba6e3bf49d.1654706034.git.dsterba@suse.com>
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

The call chain from

tree_search
  tree_search_for_insert
    __etree_search

can be open coded and allow further simplifications, here we need a tree
search with fallback to the next node in case it's not found. This is
represented as __etree_search parameters next_ret=valid, prev_ret=NULL.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b7d6f2dc4706..de0bd32d99e0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -453,10 +453,35 @@ tree_search_for_insert(struct extent_io_tree *tree,
 	return ret;
 }
 
-static inline struct rb_node *tree_search(struct extent_io_tree *tree,
-					  u64 offset)
+/*
+ * Inexact rb-tree search, return the next entry if @offset is not found
+ */
+static inline struct rb_node *tree_search(struct extent_io_tree *tree, u64 offset)
 {
-	return tree_search_for_insert(tree, offset, NULL, NULL);
+	struct rb_root *root = &tree->state;
+	struct rb_node **node = &root->rb_node;
+	struct rb_node *prev = NULL;
+	struct tree_entry *entry;
+
+	while (*node) {
+		prev = *node;
+		entry = rb_entry(prev, struct tree_entry, rb_node);
+
+		if (offset < entry->start)
+			node = &(*node)->rb_left;
+		else if (offset > entry->end)
+			node = &(*node)->rb_right;
+		else
+			return *node;
+	}
+
+	/* Search neighbors until we find the first one past the end */
+	while (prev && offset > entry->end) {
+		prev = rb_next(prev);
+		entry = rb_entry(prev, struct tree_entry, rb_node);
+	}
+
+	return prev;
 }
 
 /*
-- 
2.36.1

