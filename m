Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F64D5B41CB
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiIIVyU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiIIVyT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:19 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059681269D9
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:18 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id h28so2244080qka.0
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=smhc6y9qajeggr9zFcF+804yjK+8Bf2zTQtZmMWXTm0=;
        b=WErKrXnlP27kS49hnVaGwPDXPZvXjXb1k2IrmF62ILBOBKjlQMhivwXX5+MOi9ei7l
         Uep30ta2S753oiq6FdijSbsTP80rb407hyWWdLgLwYUwK1ilkgyBlj91148ZGWxuE4wE
         FZ29eZfbWXtI/ezaZiBN6N+Vb/5/+WyTq/XFt59HsmSK+mO/k+30KrYxHgrf4q1elr1j
         QliRGqalPk0c4noPjyhY26bUUVVgIft6Ho4ileAoimnnUoxO+31cUnzCTmGHJ0AlEwIZ
         Do521raomf/QJxiTU4j+ojJr8flp4Tyxqv/h8aq216ano15BHuMQqlWVKPR9oBKnc1hG
         CqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=smhc6y9qajeggr9zFcF+804yjK+8Bf2zTQtZmMWXTm0=;
        b=lFwG/u+x0yA01nh4/R0boNbvlYvlHb17wRClyQfwKenvrLMfasXmsdLjFwPsEToLuJ
         lBboqkSiQgkctLOX2xGK+13ZdNRMY10ygMIFZetaISqOju9+EKGyN4ddWRzeTMTKHb5S
         og7lxa3cNi/D+DZlaTrq+mQUK1LkahKtRObsNkURwv6eDU6PTKHpwTy0RDXVsOkNetXo
         ryUqXJWwh8eztxmtWDjCGDRkIYUX9QwvTxUV2eKevd6ZE0b3I9h6dhgAltei5Jg+GxJC
         d9EbdV+DooxYw0dycibBXv8HupA2qIVbOi1CMhE1hY5rpfgyN8xZdqeNMdWiMWXAsUhW
         nC7w==
X-Gm-Message-State: ACgBeo1GWzMVpB6FQFniqZPLIKrSX5z9e29KHRsKyaflPRHjVmsTPmH5
        r9CviYtU82VQKzJCUNlltv0AuXX71+DIjQ==
X-Google-Smtp-Source: AA6agR5kWTyLi4Dus03sxm1BrNO4yXUAH5PhLwR5deE/TTXSyCw51OBUuq6axxR7dOHNK+wMQknpew==
X-Received: by 2002:a05:620a:4384:b0:6bb:268c:1c3c with SMTP id a4-20020a05620a438400b006bb268c1c3cmr11876959qkp.16.1662760457319;
        Fri, 09 Sep 2022 14:54:17 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m13-20020a05620a290d00b006b9815a05easm1336999qkp.26.2022.09.09.14.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:16 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 18/36] btrfs: unexport all the temporary exports for extent-io-tree.c
Date:   Fri,  9 Sep 2022 17:53:31 -0400
Message-Id: <d8eda49459cf376e5d2fa4e239fe41fc7b794ba5.1662760286.git.josef@toxicpanda.com>
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

Now that we've moved everything we can unexport all the temporary
exports, move the random helpers, and mark everything as static again.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 69 ++++++++++++++++++++++++++-------------
 fs/btrfs/extent-io-tree.h | 47 --------------------------
 2 files changed, 47 insertions(+), 69 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 6e1945fef01f..e462b81a8d3e 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -9,6 +9,11 @@
 
 static struct kmem_cache *extent_state_cache;
 
+static inline bool extent_state_in_tree(const struct extent_state *state)
+{
+	return !RB_EMPTY_NODE(&state->rb_node);
+}
+
 #ifdef CONFIG_BTRFS_DEBUG
 static LIST_HEAD(states);
 static DEFINE_SPINLOCK(leak_lock);
@@ -81,6 +86,12 @@ static inline void __btrfs_debug_check_extent_io_range(const char *caller,
  */
 static struct lock_class_key file_extent_tree_class;
 
+struct tree_entry {
+	u64 start;
+	u64 end;
+	struct rb_node rb_node;
+};
+
 void extent_io_tree_init(struct btrfs_fs_info *fs_info,
 			 struct extent_io_tree *tree, unsigned int owner,
 			 void *private_data)
@@ -124,7 +135,7 @@ void extent_io_tree_release(struct extent_io_tree *tree)
 	spin_unlock(&tree->lock);
 }
 
-struct extent_state *alloc_extent_state(gfp_t mask)
+static struct extent_state *alloc_extent_state(gfp_t mask)
 {
 	struct extent_state *state;
 
@@ -145,7 +156,7 @@ struct extent_state *alloc_extent_state(gfp_t mask)
 	return state;
 }
 
-struct extent_state *alloc_extent_state_atomic(struct extent_state *prealloc)
+static struct extent_state *alloc_extent_state_atomic(struct extent_state *prealloc)
 {
 	if (!prealloc)
 		prealloc = alloc_extent_state(GFP_ATOMIC);
@@ -183,6 +194,15 @@ static int add_extent_changeset(struct extent_state *state, u32 bits,
 	return ret;
 }
 
+static inline struct extent_state *next_state(struct extent_state *state)
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
@@ -200,9 +220,10 @@ static int add_extent_changeset(struct extent_state *state, u32 bits,
  * If no such entry exists, return pointer to entry that ends before @offset
  * and fill parameters @node_ret and @parent_ret, ie. does not return NULL.
  */
-struct rb_node *tree_search_for_insert(struct extent_io_tree *tree, u64 offset,
-				       struct rb_node ***node_ret,
-				       struct rb_node **parent_ret)
+static inline struct rb_node *tree_search_for_insert(struct extent_io_tree *tree,
+						     u64 offset,
+						     struct rb_node ***node_ret,
+						     struct rb_node **parent_ret)
 {
 	struct rb_root *root = &tree->state;
 	struct rb_node **node = &root->rb_node;
@@ -247,9 +268,10 @@ struct rb_node *tree_search_for_insert(struct extent_io_tree *tree, u64 offset,
  * such entry exists, then return NULL and fill @prev_ret and @next_ret.
  * Otherwise return the found entry and other pointers are left untouched.
  */
-struct rb_node *tree_search_prev_next(struct extent_io_tree *tree, u64 offset,
-				      struct rb_node **prev_ret,
-				      struct rb_node **next_ret)
+static inline struct rb_node *tree_search_prev_next(struct extent_io_tree *tree,
+						    u64 offset,
+						    struct rb_node **prev_ret,
+						    struct rb_node **next_ret)
 {
 	struct rb_root *root = &tree->state;
 	struct rb_node **node = &root->rb_node;
@@ -313,7 +335,7 @@ static void extent_io_tree_panic(struct extent_io_tree *tree, int err)
  *
  * This should be called with the tree lock held.
  */
-void merge_state(struct extent_io_tree *tree, struct extent_state *state)
+static void merge_state(struct extent_io_tree *tree, struct extent_state *state)
 {
 	struct extent_state *other;
 	struct rb_node *other_node;
@@ -353,8 +375,9 @@ void merge_state(struct extent_io_tree *tree, struct extent_state *state)
 	}
 }
 
-void set_state_bits(struct extent_io_tree *tree, struct extent_state *state,
-		    u32 bits, struct extent_changeset *changeset)
+static void set_state_bits(struct extent_io_tree *tree,
+			   struct extent_state *state,
+			   u32 bits, struct extent_changeset *changeset)
 {
 	u32 bits_to_set = bits & ~EXTENT_CTLBITS;
 	int ret;
@@ -381,8 +404,9 @@ void set_state_bits(struct extent_io_tree *tree, struct extent_state *state,
  * The tree lock is not taken internally.  This is a utility function and
  * probably isn't what you want to call (see set/clear_extent_bit).
  */
-int insert_state(struct extent_io_tree *tree, struct extent_state *state,
-		 u32 bits, struct extent_changeset *changeset)
+static int insert_state(struct extent_io_tree *tree,
+			struct extent_state *state,
+			u32 bits, struct extent_changeset *changeset)
 {
 	struct rb_node **node;
 	struct rb_node *parent;
@@ -419,9 +443,10 @@ int insert_state(struct extent_io_tree *tree, struct extent_state *state,
 /*
  * Insert state to @tree to the location given by @node and @parent.
  */
-void insert_state_fast(struct extent_io_tree *tree, struct extent_state *state,
-		       struct rb_node **node, struct rb_node *parent,
-		       unsigned bits, struct extent_changeset *changeset)
+static void insert_state_fast(struct extent_io_tree *tree,
+			      struct extent_state *state, struct rb_node **node,
+			      struct rb_node *parent, unsigned bits,
+			      struct extent_changeset *changeset)
 {
 	set_state_bits(tree, state, bits, changeset);
 	rb_link_node(&state->rb_node, parent, node);
@@ -443,8 +468,8 @@ void insert_state_fast(struct extent_io_tree *tree, struct extent_state *state,
  * The tree locks are not taken by this function. They need to be held
  * by the caller.
  */
-int split_state(struct extent_io_tree *tree, struct extent_state *orig,
-		struct extent_state *prealloc, u64 split)
+static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
+		       struct extent_state *prealloc, u64 split)
 {
 	struct rb_node *parent = NULL;
 	struct rb_node **node;
@@ -489,10 +514,10 @@ int split_state(struct extent_io_tree *tree, struct extent_state *orig,
  * If no bits are set on the state struct after clearing things, the
  * struct is freed and removed from the tree
  */
-struct extent_state *clear_state_bit(struct extent_io_tree *tree,
-				     struct extent_state *state, u32 bits,
-				     int wake,
-				     struct extent_changeset *changeset)
+static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
+					    struct extent_state *state,
+					    u32 bits, int wake,
+					    struct extent_changeset *changeset)
 {
 	struct extent_state *next;
 	u32 bits_to_clear = bits & ~EXTENT_CTLBITS;
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index d01aba02ae2f..3b17cc33bcec 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -260,51 +260,4 @@ void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start,
 		u64 end);
 int btrfs_clean_io_failure(struct btrfs_inode *inode, u64 start,
 			   struct page *page, unsigned int pg_offset);
-
-struct extent_state *alloc_extent_state_atomic(struct extent_state *prealloc);
-struct extent_state *alloc_extent_state(gfp_t mask);
-
-static inline bool extent_state_in_tree(const struct extent_state *state)
-{
-	return !RB_EMPTY_NODE(&state->rb_node);
-}
-
-struct tree_entry {
-	u64 start;
-	u64 end;
-	struct rb_node rb_node;
-};
-
-struct rb_node *tree_search_for_insert(struct extent_io_tree *tree, u64 offset,
-				       struct rb_node ***node_ret,
-				       struct rb_node **parent_ret);
-struct rb_node *tree_search_prev_next(struct extent_io_tree *tree, u64 offset,
-				      struct rb_node **prev_ret,
-				      struct rb_node **next_ret);
-void merge_state(struct extent_io_tree *tree, struct extent_state *state);
-
-static inline struct extent_state *next_state(struct extent_state *state)
-{
-	struct rb_node *next = rb_next(&state->rb_node);
-	if (next)
-		return rb_entry(next, struct extent_state, rb_node);
-	else
-		return NULL;
-}
-struct extent_state *clear_state_bit(struct extent_io_tree *tree,
-				     struct extent_state *state, u32 bits,
-				     int wake,
-				     struct extent_changeset *changeset);
-int insert_state(struct extent_io_tree *tree, struct extent_state *state,
-		 u32 bits, struct extent_changeset *changeset);
-int split_state(struct extent_io_tree *tree, struct extent_state *orig,
-		struct extent_state *prealloc, u64 split);
-int insert_state(struct extent_io_tree *tree, struct extent_state *state,
-		 u32 bits, struct extent_changeset *changeset);
-void insert_state_fast(struct extent_io_tree *tree, struct extent_state *state,
-		       struct rb_node **node, struct rb_node *parent,
-		       unsigned bits, struct extent_changeset *changeset);
-void set_state_bits(struct extent_io_tree *tree, struct extent_state *state,
-		    u32 bits, struct extent_changeset *changeset);
-
 #endif /* BTRFS_EXTENT_IO_TREE_H */
-- 
2.26.3

