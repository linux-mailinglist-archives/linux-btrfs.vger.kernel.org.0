Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4F05B41D7
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiIIVyO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiIIVyN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:13 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB81910B573
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:11 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id j6so2204218qkl.10
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=TzrpwW8Bygt4v46Ij11RFpHynq8d67Wsk5QDfEVEdjc=;
        b=Qnj8N+MZVrAw82j4IYkd7ynHztUVOcj8DeV1+O2hWGmV1SnuP5KGiVOc4Z58DR0Ud5
         +tFWHycG5uo3nwy0/Y8wYFqwGJTRzaCN6mOWbCBq3AT8dykpNAy/LLL4zqfoFVn+lTDc
         y5Jaj3f1cQq2upcWZWWaxv+/HdFArGghcpj/JdZ1+cAnLxVgzt0sJ+Esyo4qOXQlca3Y
         4VmaijN6UU/9HA80HIedQgIGcvxDrekSUwHecP3050OJCAxAf1ecI/fMuqdFznZJ8eWR
         lDkcZIvJq2yQPkXLefCCLDAFRSge77yWKkcWvTncWGz0ctrLa5XauAinlf/BeA2Pf37V
         O8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TzrpwW8Bygt4v46Ij11RFpHynq8d67Wsk5QDfEVEdjc=;
        b=z00nbMHZjwkOGVbyPvPXQAQVIt/0ZtyvfZxmx2io4NpJmiRs5lqgNPYqSXVkph1Xju
         Ecf6amtwwBnNkDZ6ZxkGDwz5JaFZaHl5D95LZlg9jC0IOY8VbkUS7jTXbBS4YxVBNyw9
         5nvusbJ+i5vtVbJR2Nz+YDkv1h2PFNotFiUeepL3rfjDurq0RDZf7/M0cADIEZSezCK5
         PRtAQwLes0XxKXIKkT5hTGKEfGsg7TRdakh/9YAQ5ZzRmUnNahcS+eG6CVAM3E6b5t3U
         KmG69WMOf/7xNN83Ts2jdrG+gliGuJ61LNQowGyuY2yF9/K0+QEYwMYObfAqBDLXWUNc
         JKDQ==
X-Gm-Message-State: ACgBeo3K05ObU5aSdAPLqAOG1SwGcNhpVE8NFqI2g4DBWPY5dM9eH9pF
        B7E0fMyO3ALN8hmJf/V3ndetjfqHgb3jzA==
X-Google-Smtp-Source: AA6agR7zCeRjZPZUqUmR748BMYoTB7nyzRAx7OOhQmegnrvn+gU27qNSK6ugwdXGGBZPuh/ptFtQPQ==
X-Received: by 2002:a05:620a:254e:b0:6c9:cc85:c41a with SMTP id s14-20020a05620a254e00b006c9cc85c41amr11909765qko.260.1662760451142;
        Fri, 09 Sep 2022 14:54:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d10-20020a05622a05ca00b003430589dd34sm1426973qtb.57.2022.09.09.14.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 14/36] btrfs: temporarily export and then move extent state helpers
Date:   Fri,  9 Sep 2022 17:53:27 -0400
Message-Id: <51721f4bfbba615dcf597116046ad0d11499b0d9.1662760286.git.josef@toxicpanda.com>
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

In order to avoid moving all of the related code at once temporarily
export all of the extent state related helpers.  Then move these helpers
into extent-io-tree.c.  We will clean up the exports and make them
static in followup patches.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 242 +++++++++++++++++++++++++++++++++++
 fs/btrfs/extent-io-tree.h |  25 ++++
 fs/btrfs/extent_io.c      | 258 --------------------------------------
 3 files changed, 267 insertions(+), 258 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index d3d5c24ed820..882f9a609d11 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -161,6 +161,24 @@ void free_extent_state(struct extent_state *state)
 	}
 }
 
+static int add_extent_changeset(struct extent_state *state, u32 bits,
+				 struct extent_changeset *changeset,
+				 int set)
+{
+	int ret;
+
+	if (!changeset)
+		return 0;
+	if (set && (state->state & bits) == bits)
+		return 0;
+	if (!set && (state->state & bits) == 0)
+		return 0;
+	changeset->bytes_changed += state->end - state->start + 1;
+	ret = ulist_add(&changeset->range_changed, state->start, state->end,
+			GFP_ATOMIC);
+	return ret;
+}
+
 /**
  * Search @tree for an entry that contains @offset. Such entry would have
  * entry->start <= offset && entry->end >= offset.
@@ -268,6 +286,230 @@ struct rb_node *tree_search_prev_next(struct extent_io_tree *tree, u64 offset,
 	return NULL;
 }
 
+/*
+ * utility function to look for merge candidates inside a given range.
+ * Any extents with matching state are merged together into a single
+ * extent in the tree.  Extents with EXTENT_IO in their state field
+ * are not merged because the end_io handlers need to be able to do
+ * operations on them without sleeping (or doing allocations/splits).
+ *
+ * This should be called with the tree lock held.
+ */
+void merge_state(struct extent_io_tree *tree, struct extent_state *state)
+{
+	struct extent_state *other;
+	struct rb_node *other_node;
+
+	if (state->state & (EXTENT_LOCKED | EXTENT_BOUNDARY))
+		return;
+
+	other_node = rb_prev(&state->rb_node);
+	if (other_node) {
+		other = rb_entry(other_node, struct extent_state, rb_node);
+		if (other->end == state->start - 1 &&
+		    other->state == state->state) {
+			if (tree->private_data &&
+			    is_data_inode(tree->private_data))
+				btrfs_merge_delalloc_extent(tree->private_data,
+							    state, other);
+			state->start = other->start;
+			rb_erase(&other->rb_node, &tree->state);
+			RB_CLEAR_NODE(&other->rb_node);
+			free_extent_state(other);
+		}
+	}
+	other_node = rb_next(&state->rb_node);
+	if (other_node) {
+		other = rb_entry(other_node, struct extent_state, rb_node);
+		if (other->start == state->end + 1 &&
+		    other->state == state->state) {
+			if (tree->private_data &&
+			    is_data_inode(tree->private_data))
+				btrfs_merge_delalloc_extent(tree->private_data,
+							    state, other);
+			state->end = other->end;
+			rb_erase(&other->rb_node, &tree->state);
+			RB_CLEAR_NODE(&other->rb_node);
+			free_extent_state(other);
+		}
+	}
+}
+
+void set_state_bits(struct extent_io_tree *tree, struct extent_state *state,
+		    u32 bits, struct extent_changeset *changeset)
+{
+	u32 bits_to_set = bits & ~EXTENT_CTLBITS;
+	int ret;
+
+	if (tree->private_data && is_data_inode(tree->private_data))
+		btrfs_set_delalloc_extent(tree->private_data, state, bits);
+
+	if ((bits_to_set & EXTENT_DIRTY) && !(state->state & EXTENT_DIRTY)) {
+		u64 range = state->end - state->start + 1;
+		tree->dirty_bytes += range;
+	}
+	ret = add_extent_changeset(state, bits_to_set, changeset, 1);
+	BUG_ON(ret < 0);
+	state->state |= bits_to_set;
+}
+
+/*
+ * insert an extent_state struct into the tree.  'bits' are set on the
+ * struct before it is inserted.
+ *
+ * This may return -EEXIST if the extent is already there, in which case the
+ * state struct is freed.
+ *
+ * The tree lock is not taken internally.  This is a utility function and
+ * probably isn't what you want to call (see set/clear_extent_bit).
+ */
+int insert_state(struct extent_io_tree *tree, struct extent_state *state,
+		 u32 bits, struct extent_changeset *changeset)
+{
+	struct rb_node **node;
+	struct rb_node *parent;
+	const u64 end = state->end;
+
+	set_state_bits(tree, state, bits, changeset);
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
+			       entry->start, entry->end, state->start, end);
+			return -EEXIST;
+		}
+	}
+
+	rb_link_node(&state->rb_node, parent, node);
+	rb_insert_color(&state->rb_node, &tree->state);
+
+	merge_state(tree, state);
+	return 0;
+}
+
+/*
+ * Insert state to @tree to the location given by @node and @parent.
+ */
+void insert_state_fast(struct extent_io_tree *tree, struct extent_state *state,
+		       struct rb_node **node, struct rb_node *parent,
+		       unsigned bits, struct extent_changeset *changeset)
+{
+	set_state_bits(tree, state, bits, changeset);
+	rb_link_node(&state->rb_node, parent, node);
+	rb_insert_color(&state->rb_node, &tree->state);
+	merge_state(tree, state);
+}
+
+/*
+ * split a given extent state struct in two, inserting the preallocated
+ * struct 'prealloc' as the newly created second half.  'split' indicates an
+ * offset inside 'orig' where it should be split.
+ *
+ * Before calling,
+ * the tree has 'orig' at [orig->start, orig->end].  After calling, there
+ * are two extent state structs in the tree:
+ * prealloc: [orig->start, split - 1]
+ * orig: [ split, orig->end ]
+ *
+ * The tree locks are not taken by this function. They need to be held
+ * by the caller.
+ */
+int split_state(struct extent_io_tree *tree, struct extent_state *orig,
+		struct extent_state *prealloc, u64 split)
+{
+	struct rb_node *parent = NULL;
+	struct rb_node **node;
+
+	if (tree->private_data && is_data_inode(tree->private_data))
+		btrfs_split_delalloc_extent(tree->private_data, orig, split);
+
+	prealloc->start = orig->start;
+	prealloc->end = split - 1;
+	prealloc->state = orig->state;
+	orig->start = split;
+
+	parent = &orig->rb_node;
+	node = &parent;
+	while (*node) {
+		struct tree_entry *entry;
+
+		parent = *node;
+		entry = rb_entry(parent, struct tree_entry, rb_node);
+
+		if (prealloc->end < entry->start) {
+			node = &(*node)->rb_left;
+		} else if (prealloc->end > entry->end) {
+			node = &(*node)->rb_right;
+		} else {
+			free_extent_state(prealloc);
+			return -EEXIST;
+		}
+	}
+
+	rb_link_node(&prealloc->rb_node, parent, node);
+	rb_insert_color(&prealloc->rb_node, &tree->state);
+
+	return 0;
+}
+
+
+/*
+ * utility function to clear some bits in an extent state struct.
+ * it will optionally wake up anyone waiting on this state (wake == 1).
+ *
+ * If no bits are set on the state struct after clearing things, the
+ * struct is freed and removed from the tree
+ */
+struct extent_state *clear_state_bit(struct extent_io_tree *tree,
+				     struct extent_state *state, u32 bits,
+				     int wake,
+				     struct extent_changeset *changeset)
+{
+	struct extent_state *next;
+	u32 bits_to_clear = bits & ~EXTENT_CTLBITS;
+	int ret;
+
+	if ((bits_to_clear & EXTENT_DIRTY) && (state->state & EXTENT_DIRTY)) {
+		u64 range = state->end - state->start + 1;
+		WARN_ON(range > tree->dirty_bytes);
+		tree->dirty_bytes -= range;
+	}
+
+	if (tree->private_data && is_data_inode(tree->private_data))
+		btrfs_clear_delalloc_extent(tree->private_data, state, bits);
+
+	ret = add_extent_changeset(state, bits_to_clear, changeset, 0);
+	BUG_ON(ret < 0);
+	state->state &= ~bits_to_clear;
+	if (wake)
+		wake_up(&state->wq);
+	if (state->state == 0) {
+		next = next_state(state);
+		if (extent_state_in_tree(state)) {
+			rb_erase(&state->rb_node, &tree->state);
+			RB_CLEAR_NODE(&state->rb_node);
+			free_extent_state(state);
+		} else {
+			WARN_ON(1);
+		}
+	} else {
+		merge_state(tree, state);
+		next = next_state(state);
+	}
+	return next;
+}
+
 /* wrappers around set/clear extent bit */
 int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			   u32 bits, struct extent_changeset *changeset)
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index ce07432954b4..251f1fc9a5b7 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -291,5 +291,30 @@ struct rb_node *tree_search_for_insert(struct extent_io_tree *tree, u64 offset,
 struct rb_node *tree_search_prev_next(struct extent_io_tree *tree, u64 offset,
 				      struct rb_node **prev_ret,
 				      struct rb_node **next_ret);
+void merge_state(struct extent_io_tree *tree, struct extent_state *state);
+
+static inline struct extent_state *next_state(struct extent_state *state)
+{
+	struct rb_node *next = rb_next(&state->rb_node);
+	if (next)
+		return rb_entry(next, struct extent_state, rb_node);
+	else
+		return NULL;
+}
+struct extent_state *clear_state_bit(struct extent_io_tree *tree,
+				     struct extent_state *state, u32 bits,
+				     int wake,
+				     struct extent_changeset *changeset);
+int insert_state(struct extent_io_tree *tree, struct extent_state *state,
+		 u32 bits, struct extent_changeset *changeset);
+int split_state(struct extent_io_tree *tree, struct extent_state *orig,
+		struct extent_state *prealloc, u64 split);
+int insert_state(struct extent_io_tree *tree, struct extent_state *state,
+		 u32 bits, struct extent_changeset *changeset);
+void insert_state_fast(struct extent_io_tree *tree, struct extent_state *state,
+		       struct rb_node **node, struct rb_node *parent,
+		       unsigned bits, struct extent_changeset *changeset);
+void set_state_bits(struct extent_io_tree *tree, struct extent_state *state,
+		    u32 bits, struct extent_changeset *changeset);
 
 #endif /* BTRFS_EXTENT_IO_TREE_H */
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 852f29ea00ce..65e239ab3dc0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -108,24 +108,6 @@ struct extent_page_data {
 	unsigned int sync_io:1;
 };
 
-static int add_extent_changeset(struct extent_state *state, u32 bits,
-				 struct extent_changeset *changeset,
-				 int set)
-{
-	int ret;
-
-	if (!changeset)
-		return 0;
-	if (set && (state->state & bits) == bits)
-		return 0;
-	if (!set && (state->state & bits) == 0)
-		return 0;
-	changeset->bytes_changed += state->end - state->start + 1;
-	ret = ulist_add(&changeset->range_changed, state->start, state->end,
-			GFP_ATOMIC);
-	return ret;
-}
-
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct bio *bio;
@@ -207,227 +189,6 @@ static inline struct rb_node *tree_search(struct extent_io_tree *tree, u64 offse
 	return tree_search_for_insert(tree, offset, NULL, NULL);
 }
 
-/*
- * utility function to look for merge candidates inside a given range.
- * Any extents with matching state are merged together into a single
- * extent in the tree.  Extents with EXTENT_IO in their state field
- * are not merged because the end_io handlers need to be able to do
- * operations on them without sleeping (or doing allocations/splits).
- *
- * This should be called with the tree lock held.
- */
-static void merge_state(struct extent_io_tree *tree,
-		        struct extent_state *state)
-{
-	struct extent_state *other;
-	struct rb_node *other_node;
-
-	if (state->state & (EXTENT_LOCKED | EXTENT_BOUNDARY))
-		return;
-
-	other_node = rb_prev(&state->rb_node);
-	if (other_node) {
-		other = rb_entry(other_node, struct extent_state, rb_node);
-		if (other->end == state->start - 1 &&
-		    other->state == state->state) {
-			if (tree->private_data &&
-			    is_data_inode(tree->private_data))
-				btrfs_merge_delalloc_extent(tree->private_data,
-							    state, other);
-			state->start = other->start;
-			rb_erase(&other->rb_node, &tree->state);
-			RB_CLEAR_NODE(&other->rb_node);
-			free_extent_state(other);
-		}
-	}
-	other_node = rb_next(&state->rb_node);
-	if (other_node) {
-		other = rb_entry(other_node, struct extent_state, rb_node);
-		if (other->start == state->end + 1 &&
-		    other->state == state->state) {
-			if (tree->private_data &&
-			    is_data_inode(tree->private_data))
-				btrfs_merge_delalloc_extent(tree->private_data,
-							    state, other);
-			state->end = other->end;
-			rb_erase(&other->rb_node, &tree->state);
-			RB_CLEAR_NODE(&other->rb_node);
-			free_extent_state(other);
-		}
-	}
-}
-
-static void set_state_bits(struct extent_io_tree *tree,
-			   struct extent_state *state, u32 bits,
-			   struct extent_changeset *changeset);
-
-/*
- * insert an extent_state struct into the tree.  'bits' are set on the
- * struct before it is inserted.
- *
- * This may return -EEXIST if the extent is already there, in which case the
- * state struct is freed.
- *
- * The tree lock is not taken internally.  This is a utility function and
- * probably isn't what you want to call (see set/clear_extent_bit).
- */
-static int insert_state(struct extent_io_tree *tree,
-			struct extent_state *state,
-			u32 bits, struct extent_changeset *changeset)
-{
-	struct rb_node **node;
-	struct rb_node *parent;
-	const u64 end = state->end;
-
-	set_state_bits(tree, state, bits, changeset);
-
-	node = &tree->state.rb_node;
-	while (*node) {
-		struct tree_entry *entry;
-
-		parent = *node;
-		entry = rb_entry(parent, struct tree_entry, rb_node);
-
-		if (end < entry->start) {
-			node = &(*node)->rb_left;
-		} else if (end > entry->end) {
-			node = &(*node)->rb_right;
-		} else {
-			btrfs_err(tree->fs_info,
-			       "found node %llu %llu on insert of %llu %llu",
-			       entry->start, entry->end, state->start, end);
-			return -EEXIST;
-		}
-	}
-
-	rb_link_node(&state->rb_node, parent, node);
-	rb_insert_color(&state->rb_node, &tree->state);
-
-	merge_state(tree, state);
-	return 0;
-}
-
-/*
- * Insert state to @tree to the location given by @node and @parent.
- */
-static void insert_state_fast(struct extent_io_tree *tree,
-			      struct extent_state *state, struct rb_node **node,
-			      struct rb_node *parent, unsigned bits,
-			      struct extent_changeset *changeset)
-{
-	set_state_bits(tree, state, bits, changeset);
-	rb_link_node(&state->rb_node, parent, node);
-	rb_insert_color(&state->rb_node, &tree->state);
-	merge_state(tree, state);
-}
-
-/*
- * split a given extent state struct in two, inserting the preallocated
- * struct 'prealloc' as the newly created second half.  'split' indicates an
- * offset inside 'orig' where it should be split.
- *
- * Before calling,
- * the tree has 'orig' at [orig->start, orig->end].  After calling, there
- * are two extent state structs in the tree:
- * prealloc: [orig->start, split - 1]
- * orig: [ split, orig->end ]
- *
- * The tree locks are not taken by this function. They need to be held
- * by the caller.
- */
-static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
-		       struct extent_state *prealloc, u64 split)
-{
-	struct rb_node *parent = NULL;
-	struct rb_node **node;
-
-	if (tree->private_data && is_data_inode(tree->private_data))
-		btrfs_split_delalloc_extent(tree->private_data, orig, split);
-
-	prealloc->start = orig->start;
-	prealloc->end = split - 1;
-	prealloc->state = orig->state;
-	orig->start = split;
-
-	parent = &orig->rb_node;
-	node = &parent;
-	while (*node) {
-		struct tree_entry *entry;
-
-		parent = *node;
-		entry = rb_entry(parent, struct tree_entry, rb_node);
-
-		if (prealloc->end < entry->start) {
-			node = &(*node)->rb_left;
-		} else if (prealloc->end > entry->end) {
-			node = &(*node)->rb_right;
-		} else {
-			free_extent_state(prealloc);
-			return -EEXIST;
-		}
-	}
-
-	rb_link_node(&prealloc->rb_node, parent, node);
-	rb_insert_color(&prealloc->rb_node, &tree->state);
-
-	return 0;
-}
-
-static struct extent_state *next_state(struct extent_state *state)
-{
-	struct rb_node *next = rb_next(&state->rb_node);
-	if (next)
-		return rb_entry(next, struct extent_state, rb_node);
-	else
-		return NULL;
-}
-
-/*
- * utility function to clear some bits in an extent state struct.
- * it will optionally wake up anyone waiting on this state (wake == 1).
- *
- * If no bits are set on the state struct after clearing things, the
- * struct is freed and removed from the tree
- */
-static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
-					    struct extent_state *state,
-					    u32 bits, int wake,
-					    struct extent_changeset *changeset)
-{
-	struct extent_state *next;
-	u32 bits_to_clear = bits & ~EXTENT_CTLBITS;
-	int ret;
-
-	if ((bits_to_clear & EXTENT_DIRTY) && (state->state & EXTENT_DIRTY)) {
-		u64 range = state->end - state->start + 1;
-		WARN_ON(range > tree->dirty_bytes);
-		tree->dirty_bytes -= range;
-	}
-
-	if (tree->private_data && is_data_inode(tree->private_data))
-		btrfs_clear_delalloc_extent(tree->private_data, state, bits);
-
-	ret = add_extent_changeset(state, bits_to_clear, changeset, 0);
-	BUG_ON(ret < 0);
-	state->state &= ~bits_to_clear;
-	if (wake)
-		wake_up(&state->wq);
-	if (state->state == 0) {
-		next = next_state(state);
-		if (extent_state_in_tree(state)) {
-			rb_erase(&state->rb_node, &tree->state);
-			RB_CLEAR_NODE(&state->rb_node);
-			free_extent_state(state);
-		} else {
-			WARN_ON(1);
-		}
-	} else {
-		merge_state(tree, state);
-		next = next_state(state);
-	}
-	return next;
-}
-
 static void extent_io_tree_panic(struct extent_io_tree *tree, int err)
 {
 	btrfs_panic(tree->fs_info, err,
@@ -663,25 +424,6 @@ void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits)
 	spin_unlock(&tree->lock);
 }
 
-static void set_state_bits(struct extent_io_tree *tree,
-			   struct extent_state *state,
-			   u32 bits, struct extent_changeset *changeset)
-{
-	u32 bits_to_set = bits & ~EXTENT_CTLBITS;
-	int ret;
-
-	if (tree->private_data && is_data_inode(tree->private_data))
-		btrfs_set_delalloc_extent(tree->private_data, state, bits);
-
-	if ((bits_to_set & EXTENT_DIRTY) && !(state->state & EXTENT_DIRTY)) {
-		u64 range = state->end - state->start + 1;
-		tree->dirty_bytes += range;
-	}
-	ret = add_extent_changeset(state, bits_to_set, changeset, 1);
-	BUG_ON(ret < 0);
-	state->state |= bits_to_set;
-}
-
 static void cache_state_if_flags(struct extent_state *state,
 				 struct extent_state **cached_ptr,
 				 unsigned flags)
-- 
2.26.3

