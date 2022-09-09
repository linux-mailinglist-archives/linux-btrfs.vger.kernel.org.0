Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD31D5B41D3
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiIIVyN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiIIVyM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:12 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790A3F651D
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:10 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id a3so808645qto.10
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=8fmQiplXoeNhOXIFMnUk7aC0hhtIIS6l4LnW+GM2Rsg=;
        b=nFH3THRq4NqmA5pUShqc0kYd6S8pqkA0/Opf89k+3Szrov6NytMyEHgfocUiTMv5cG
         DDEnxO9viB9atNHtpMVggwmkv3IrtPOtF1ARrx9P8GVCaIjV8bpYQwfSwbsLkZis1eR/
         nzLdrzfwFTEMCZRYf9hb/6jY23D7JrrErKraB7aeqSkh12vWBQ1q1BZbZM0U/rxiT8Un
         9YRemBVWfhw8c6fZJ2aRnnL/mkhdi/nTxekfPV4pALXl4kz62atepkGWHpoFG6dkl8DL
         PS7lUXeFF6tgaM9EW1sen9pIXji627hXY463Wg3nlOjP7NT7AgPnG6+l+Pf9SDdjAMK1
         M0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8fmQiplXoeNhOXIFMnUk7aC0hhtIIS6l4LnW+GM2Rsg=;
        b=UIAAF2tni5HCyr1OP4Nndxkz/bJizChxs91JGd/REwDVo0/4CDV/7bJfQ1R9Nz/ot2
         hWImeoden6OSFHIxd0ULEdr5CMIdBrw7V1Mjc1Oh3qD3SZT9+uQM8y7CVZSwwbnp4l2d
         ESrwkGAPT9nPkvVg+xqK1YjVcWopmmU+omGwPYqdlWjTF41VSUMaV3wTLKza9N2BQZ7H
         MxNb8j4CQjEcjmkxrJk0E52u6da5cxwZnJRxk305me4VutY2WKBnz2hQ0MZ2FbLk1oPp
         kG8C1kDNRGm35j9xLKTfDxsgH6MpDq0KHSd43ZG8mCfbvBWVzCiRsnRW0cgEdy6+nLJF
         qHXg==
X-Gm-Message-State: ACgBeo3HasLFY9N7zAFK/2QO12H1omrLzmYCiaLXCS1LZvDJUfSnVRNF
        +iwPmLIGwy9lWhuWs7pHnb00nfzJXf0XOA==
X-Google-Smtp-Source: AA6agR4jiR2MmdQhelxvyoCTImWgEFLdrweBAhnRfJWLF3BN/WTf1DW04bOCmTv1D1OFimM4vSxL/g==
X-Received: by 2002:ac8:5808:0:b0:35a:7219:f31d with SMTP id g8-20020ac85808000000b0035a7219f31dmr6388671qtg.221.1662760449718;
        Fri, 09 Sep 2022 14:54:09 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i8-20020ac860c8000000b00304fe5247bfsm1239052qtm.36.2022.09.09.14.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 13/36] btrfs: temporarily export and move core extent_io_tree tree functions
Date:   Fri,  9 Sep 2022 17:53:26 -0400
Message-Id: <433b8c2e4971e0cf26c96cb62fe83485a3bfc855.1662760286.git.josef@toxicpanda.com>
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

A lot of the various internals of extent_io_tree call these two
functions for insert or searching the rb tree for entries, so
temporarily export them and then move them to extent-io-tree.c.  We
can't move tree_search() without renaming it, and I don't want to
introduce a bunch of churn just to do that, so move these functions
first and then we can move a few big functions and then the remaining
users of tree_search().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 107 +++++++++++++++++++++++++++++++++++
 fs/btrfs/extent-io-tree.h |  13 +++++
 fs/btrfs/extent_io.c      | 115 --------------------------------------
 3 files changed, 120 insertions(+), 115 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index b38aa46c86a1..d3d5c24ed820 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -161,6 +161,113 @@ void free_extent_state(struct extent_state *state)
 	}
 }
 
+/**
+ * Search @tree for an entry that contains @offset. Such entry would have
+ * entry->start <= offset && entry->end >= offset.
+ *
+ * @tree:       the tree to search
+ * @offset:     offset that should fall within an entry in @tree
+ * @node_ret:   pointer where new node should be anchored (used when inserting an
+ *	        entry in the tree)
+ * @parent_ret: points to entry which would have been the parent of the entry,
+ *               containing @offset
+ *
+ * Return a pointer to the entry that contains @offset byte address and don't change
+ * @node_ret and @parent_ret.
+ *
+ * If no such entry exists, return pointer to entry that ends before @offset
+ * and fill parameters @node_ret and @parent_ret, ie. does not return NULL.
+ */
+struct rb_node *tree_search_for_insert(struct extent_io_tree *tree, u64 offset,
+				       struct rb_node ***node_ret,
+				       struct rb_node **parent_ret)
+{
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
+	if (node_ret)
+		*node_ret = node;
+	if (parent_ret)
+		*parent_ret = prev;
+
+	/* Search neighbors until we find the first one past the end */
+	while (prev && offset > entry->end) {
+		prev = rb_next(prev);
+		entry = rb_entry(prev, struct tree_entry, rb_node);
+	}
+
+	return prev;
+}
+
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
+struct rb_node *tree_search_prev_next(struct extent_io_tree *tree, u64 offset,
+				      struct rb_node **prev_ret,
+				      struct rb_node **next_ret)
+{
+	struct rb_root *root = &tree->state;
+	struct rb_node **node = &root->rb_node;
+	struct rb_node *prev = NULL;
+	struct rb_node *orig_prev = NULL;
+	struct tree_entry *entry;
+
+	ASSERT(prev_ret);
+	ASSERT(next_ret);
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
+	orig_prev = prev;
+	while (prev && offset > entry->end) {
+		prev = rb_next(prev);
+		entry = rb_entry(prev, struct tree_entry, rb_node);
+	}
+	*next_ret = prev;
+	prev = orig_prev;
+
+	entry = rb_entry(prev, struct tree_entry, rb_node);
+	while (prev && offset < entry->start) {
+		prev = rb_prev(prev);
+		entry = rb_entry(prev, struct tree_entry, rb_node);
+	}
+	*prev_ret = prev;
+
+	return NULL;
+}
+
 /* wrappers around set/clear extent bit */
 int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			   u32 bits, struct extent_changeset *changeset)
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index d9c1bb70d76b..ce07432954b4 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -279,4 +279,17 @@ void __btrfs_debug_check_extent_io_range(const char *caller,
 #define btrfs_debug_check_extent_io_range(c, s, e)	do {} while (0)
 #endif
 
+struct tree_entry {
+	u64 start;
+	u64 end;
+	struct rb_node rb_node;
+};
+
+struct rb_node *tree_search_for_insert(struct extent_io_tree *tree, u64 offset,
+				       struct rb_node ***node_ret,
+				       struct rb_node **parent_ret);
+struct rb_node *tree_search_prev_next(struct extent_io_tree *tree, u64 offset,
+				      struct rb_node **prev_ret,
+				      struct rb_node **next_ret);
+
 #endif /* BTRFS_EXTENT_IO_TREE_H */
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8d8a2cf177ac..852f29ea00ce 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -85,12 +85,6 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
 #define btrfs_leak_debug_del_eb(eb)			do {} while (0)
 #endif
 
-struct tree_entry {
-	u64 start;
-	u64 end;
-	struct rb_node rb_node;
-};
-
 /*
  * Structure to record info about the bio being assembled, and other info like
  * how many bytes are there before stripe/ordered extent boundary.
@@ -205,59 +199,6 @@ void __cold extent_buffer_free_cachep(void)
 	kmem_cache_destroy(extent_buffer_cache);
 }
 
-/**
- * Search @tree for an entry that contains @offset. Such entry would have
- * entry->start <= offset && entry->end >= offset.
- *
- * @tree:       the tree to search
- * @offset:     offset that should fall within an entry in @tree
- * @node_ret:   pointer where new node should be anchored (used when inserting an
- *	        entry in the tree)
- * @parent_ret: points to entry which would have been the parent of the entry,
- *               containing @offset
- *
- * Return a pointer to the entry that contains @offset byte address and don't change
- * @node_ret and @parent_ret.
- *
- * If no such entry exists, return pointer to entry that ends before @offset
- * and fill parameters @node_ret and @parent_ret, ie. does not return NULL.
- */
-static inline struct rb_node *tree_search_for_insert(struct extent_io_tree *tree,
-					             u64 offset,
-						     struct rb_node ***node_ret,
-						     struct rb_node **parent_ret)
-{
-	struct rb_root *root = &tree->state;
-	struct rb_node **node = &root->rb_node;
-	struct rb_node *prev = NULL;
-	struct tree_entry *entry;
-
-	while (*node) {
-		prev = *node;
-		entry = rb_entry(prev, struct tree_entry, rb_node);
-
-		if (offset < entry->start)
-			node = &(*node)->rb_left;
-		else if (offset > entry->end)
-			node = &(*node)->rb_right;
-		else
-			return *node;
-	}
-
-	if (node_ret)
-		*node_ret = node;
-	if (parent_ret)
-		*parent_ret = prev;
-
-	/* Search neighbors until we find the first one past the end */
-	while (prev && offset > entry->end) {
-		prev = rb_next(prev);
-		entry = rb_entry(prev, struct tree_entry, rb_node);
-	}
-
-	return prev;
-}
-
 /*
  * Inexact rb-tree search, return the next entry if @offset is not found
  */
@@ -266,62 +207,6 @@ static inline struct rb_node *tree_search(struct extent_io_tree *tree, u64 offse
 	return tree_search_for_insert(tree, offset, NULL, NULL);
 }
 
-/**
- * Search offset in the tree or fill neighbor rbtree node pointers.
- *
- * @tree:      the tree to search
- * @offset:    offset that should fall within an entry in @tree
- * @next_ret:  pointer to the first entry whose range ends after @offset
- * @prev_ret:  pointer to the first entry whose range begins before @offset
- *
- * Return a pointer to the entry that contains @offset byte address. If no
- * such entry exists, then return NULL and fill @prev_ret and @next_ret.
- * Otherwise return the found entry and other pointers are left untouched.
- */
-static struct rb_node *tree_search_prev_next(struct extent_io_tree *tree,
-					     u64 offset,
-					     struct rb_node **prev_ret,
-					     struct rb_node **next_ret)
-{
-	struct rb_root *root = &tree->state;
-	struct rb_node **node = &root->rb_node;
-	struct rb_node *prev = NULL;
-	struct rb_node *orig_prev = NULL;
-	struct tree_entry *entry;
-
-	ASSERT(prev_ret);
-	ASSERT(next_ret);
-
-	while (*node) {
-		prev = *node;
-		entry = rb_entry(prev, struct tree_entry, rb_node);
-
-		if (offset < entry->start)
-			node = &(*node)->rb_left;
-		else if (offset > entry->end)
-			node = &(*node)->rb_right;
-		else
-			return *node;
-	}
-
-	orig_prev = prev;
-	while (prev && offset > entry->end) {
-		prev = rb_next(prev);
-		entry = rb_entry(prev, struct tree_entry, rb_node);
-	}
-	*next_ret = prev;
-	prev = orig_prev;
-
-	entry = rb_entry(prev, struct tree_entry, rb_node);
-	while (prev && offset < entry->start) {
-		prev = rb_prev(prev);
-		entry = rb_entry(prev, struct tree_entry, rb_node);
-	}
-	*prev_ret = prev;
-
-	return NULL;
-}
-
 /*
  * utility function to look for merge candidates inside a given range.
  * Any extents with matching state are merged together into a single
-- 
2.26.3

