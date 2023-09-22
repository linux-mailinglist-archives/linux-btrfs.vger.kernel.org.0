Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A9D7AAFBA
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 12:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjIVKjZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 06:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbjIVKjW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 06:39:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D2EAC
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 03:39:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D96C433C8
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 10:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695379154;
        bh=OtF12TdO1meoqfq3jUsxSmmhVtbD7nJwZQ9OF1vRNyI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=l7cbH0s/JFPe/prFG7r48FJcIop7CL5U+UvH7v+Gf3s0hbLQn1tboEJ2yRss6IE0e
         jPVQ7c1Qi2Ay0zWI7Ic33TUPezYezn3fNVZxf1q1OYDXGLgwidPViWRxkIYdh3h9sM
         6NTmVVdjyVK6oW6k2DVLRSW+KPLeJjTu0wGJ6YsD/Jpq0vBUJ2HOZkq7SXyKS6pL8s
         MlF/ayokhsOrlS9CgPSIBYgIamUm4W54gINCwbLi+6KQeOw1tQ+nJ+1t0/BfvPi+Zm
         AlgmwOo7GeTQM40W9NYD69K8qGObh9F4o8HlZcNxSBr2BPDSUKUlcvAWJqPoP9lmIQ
         g+rkpXWPS/KTQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/8] btrfs: make extent state merges more efficient during insertions
Date:   Fri, 22 Sep 2023 11:39:02 +0100
Message-Id: <915e23dfc59be63ff5999ee0e4b2f35c426e3db9.1695333278.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695333278.git.fdmanana@suse.com>
References: <cover.1695333278.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When inserting a new extent state record into an io tree that happens to
be mergeable, we currently do the following:

1) Insert the extent state record in the io tree's rbtree. This requires
   going down the tree to find where to insert it, and during the
   insertion we often need to balance the rbtree;

2) We then check if the previous node is mergeable, so we call rb_prev()
   to find it, which requires some looping to find the previous node;

3) If the previous node is mergeable, we adjust our node to include the
   range of the previous node and then delete the previous node from the
   rbtree, which again may need to balance the rbtree;

4) Then we check if the next node is mergeable with the node we inserted,
   so we call rb_next(), which requires some looping too. If the next node
   is indeed mergeable, we expand the range of our node to include the
   next node's range and then delete the next node from the rbtree, which
   again may need to balance the tree.

So these are quite of lot of iterations and looping over the rbtree, and
some of the operations may need to rebalance the rb tree. This can be made
a bit more efficient by:

1) When iterating the rbtree, once we find a node that is mergeable with
   the node we want to insert, we can just adjust that node's range with
   the range of the node to insert - this avoids continuing iterating
   over the tree and deleting a node from the rbtree;

2) If we expand the range of a mergeable node, then we find the next or
   the previous node, depending on other we merged a range to the right or
   to the left of the node we are currently at during the iteration. This
   merging is as before, we find the next or previous node with rb_next()
   or rb_prev() and if that other node is mergeable with the current one,
   we adjust the range of the current node and remove the other node from
   the rbtree;

3) Whenever we need to insert the new extent state record it's because
   we don't have any extent state record in the rbtree which can be
   merged, so we can remove the call to merge_state() after the insertion,
   saving rb_next() and rb_prev() calls, which require some looping.

So update the insertion function insert_state() to have this behaviour.

Running dbench for 120 seconds and capturing the execution times of
set_extent_bit() at pin_down_extent(), resulted in the following data
(time values are in nanoseconds):

Before this change:

  Count: 2278299
  Range:  0.000 - 4003728.000; Mean: 713.436; Median: 612.000; Stddev: 3606.952
  Percentiles:  90th: 1187.000; 95th: 1350.000; 99th: 1724.000
     0.000 -    7.534:     5 |
     7.534 -   35.418:    36 |
    35.418 -  154.403:   273 |
   154.403 -  662.138: 1244016 #####################################################
   662.138 - 2828.745: 1031335 ############################################
  2828.745 - 12074.102:  1395 |
  12074.102 - 51525.930:   806 |
  51525.930 - 219874.955:   162 |
  219874.955 - 938254.688:    22 |
  938254.688 - 4003728.000:     3 |

After this change:

  Count: 2275862
  Range:  0.000 - 1605175.000; Mean: 678.903; Median: 590.000; Stddev: 2149.785
  Percentiles:  90th: 1105.000; 95th: 1245.000; 99th: 1590.000
     0.000 -   10.219:    10 |
    10.219 -   40.957:    36 |
    40.957 -  155.907:   262 |
   155.907 -  585.789: 1127214 ####################################################
   585.789 - 2193.431: 1145134 #####################################################
  2193.431 - 8205.578:  1648 |
  8205.578 - 30689.378:  1039 |
  30689.378 - 114772.699:   362 |
  114772.699 - 429221.537:    52 |
  429221.537 - 1605175.000:    10 |

Maximum duration (range), average duration, percentiles and standard
deviation are all better.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 130 ++++++++++++++++++++++++++------------
 1 file changed, 88 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index ff8e117a1ace..dd9dd473654d 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -327,6 +327,38 @@ static void extent_io_tree_panic(struct extent_io_tree *tree, int err)
 	"locking error: extent tree was modified by another thread while locked");
 }
 
+static void merge_prev_state(struct extent_io_tree *tree, struct extent_state *state)
+{
+	struct extent_state *prev;
+
+	prev = prev_state(state);
+	if (prev && prev->end == state->start - 1 &&
+	    prev->state == state->state) {
+		if (tree->inode)
+			btrfs_merge_delalloc_extent(tree->inode, state, prev);
+		state->start = prev->start;
+		rb_erase(&prev->rb_node, &tree->state);
+		RB_CLEAR_NODE(&prev->rb_node);
+		free_extent_state(prev);
+	}
+}
+
+static void merge_next_state(struct extent_io_tree *tree, struct extent_state *state)
+{
+	struct extent_state *next;
+
+	next = next_state(state);
+	if (next && next->start == state->end + 1 &&
+	    next->state == state->state) {
+		if (tree->inode)
+			btrfs_merge_delalloc_extent(tree->inode, state, next);
+		state->end = next->end;
+		rb_erase(&next->rb_node, &tree->state);
+		RB_CLEAR_NODE(&next->rb_node);
+		free_extent_state(next);
+	}
+}
+
 /*
  * Utility function to look for merge candidates inside a given range.  Any
  * extents with matching state are merged together into a single extent in the
@@ -338,31 +370,11 @@ static void extent_io_tree_panic(struct extent_io_tree *tree, int err)
  */
 static void merge_state(struct extent_io_tree *tree, struct extent_state *state)
 {
-	struct extent_state *other;
-
 	if (state->state & (EXTENT_LOCKED | EXTENT_BOUNDARY))
 		return;
 
-	other = prev_state(state);
-	if (other && other->end == state->start - 1 &&
-	    other->state == state->state) {
-		if (tree->inode)
-			btrfs_merge_delalloc_extent(tree->inode, state, other);
-		state->start = other->start;
-		rb_erase(&other->rb_node, &tree->state);
-		RB_CLEAR_NODE(&other->rb_node);
-		free_extent_state(other);
-	}
-	other = next_state(state);
-	if (other && other->start == state->end + 1 &&
-	    other->state == state->state) {
-		if (tree->inode)
-			btrfs_merge_delalloc_extent(tree->inode, state, other);
-		state->end = other->end;
-		rb_erase(&other->rb_node, &tree->state);
-		RB_CLEAR_NODE(&other->rb_node);
-		free_extent_state(other);
-	}
+	merge_prev_state(tree, state);
+	merge_next_state(tree, state);
 }
 
 static void set_state_bits(struct extent_io_tree *tree,
@@ -384,19 +396,26 @@ static void set_state_bits(struct extent_io_tree *tree,
  * Insert an extent_state struct into the tree.  'bits' are set on the
  * struct before it is inserted.
  *
- * This may return -EEXIST if the extent is already there, in which case the
- * state struct is freed.
+ * Returns a pointer to the struct extent_state record containing the range
+ * requested for insertion, which may be the same as the given struct or it
+ * may be an existing record in the tree that was expanded to accommodate the
+ * requested range. In case of an extent_state different from the one that was
+ * given, the later can be freed or reused by the caller.
+ * On error it returns an error pointer.
  *
  * The tree lock is not taken internally.  This is a utility function and
  * probably isn't what you want to call (see set/clear_extent_bit).
  */
-static int insert_state(struct extent_io_tree *tree,
-			struct extent_state *state,
-			u32 bits, struct extent_changeset *changeset)
+static struct extent_state *insert_state(struct extent_io_tree *tree,
+					 struct extent_state *state,
+					 u32 bits,
+					 struct extent_changeset *changeset)
 {
 	struct rb_node **node;
 	struct rb_node *parent = NULL;
-	const u64 end = state->end;
+	const u64 start = state->start - 1;
+	const u64 end = state->end + 1;
+	const bool try_merge = !(bits & (EXTENT_LOCKED | EXTENT_BOUNDARY));
 
 	set_state_bits(tree, state, bits, changeset);
 
@@ -407,23 +426,40 @@ static int insert_state(struct extent_io_tree *tree,
 		parent = *node;
 		entry = rb_entry(parent, struct extent_state, rb_node);
 
-		if (end < entry->start) {
+		if (state->end < entry->start) {
+			if (try_merge && end == entry->start &&
+			    state->state == entry->state) {
+				if (tree->inode)
+					btrfs_merge_delalloc_extent(tree->inode, state, entry);
+				entry->start = state->start;
+				merge_prev_state(tree, entry);
+				state->state = 0;
+				return entry;
+			}
 			node = &(*node)->rb_left;
-		} else if (end > entry->end) {
+		} else if (state->end > entry->end) {
+			if (try_merge && entry->end == start &&
+			    state->state == entry->state) {
+				if (tree->inode)
+					btrfs_merge_delalloc_extent(tree->inode, state, entry);
+				entry->end = state->end;
+				merge_next_state(tree, entry);
+				state->state = 0;
+				return entry;
+			}
 			node = &(*node)->rb_right;
 		} else {
 			btrfs_err(tree->fs_info,
 			       "found node %llu %llu on insert of %llu %llu",
-			       entry->start, entry->end, state->start, end);
-			return -EEXIST;
+			       entry->start, entry->end, state->start, state->end);
+			return ERR_PTR(-EEXIST);
 		}
 	}
 
 	rb_link_node(&state->rb_node, parent, node);
 	rb_insert_color(&state->rb_node, &tree->state);
 
-	merge_state(tree, state);
-	return 0;
+	return state;
 }
 
 /*
@@ -1133,6 +1169,8 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	 */
 	if (state->start > start) {
 		u64 this_end;
+		struct extent_state *inserted_state;
+
 		if (end < last_start)
 			this_end = end;
 		else
@@ -1148,12 +1186,15 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		 */
 		prealloc->start = start;
 		prealloc->end = this_end;
-		err = insert_state(tree, prealloc, bits, changeset);
-		if (err)
+		inserted_state = insert_state(tree, prealloc, bits, changeset);
+		if (IS_ERR(inserted_state)) {
+			err = PTR_ERR(inserted_state);
 			extent_io_tree_panic(tree, err);
+		}
 
-		cache_state(prealloc, cached_state);
-		prealloc = NULL;
+		cache_state(inserted_state, cached_state);
+		if (inserted_state == prealloc)
+			prealloc = NULL;
 		start = this_end + 1;
 		goto search_again;
 	}
@@ -1356,6 +1397,8 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	 */
 	if (state->start > start) {
 		u64 this_end;
+		struct extent_state *inserted_state;
+
 		if (end < last_start)
 			this_end = end;
 		else
@@ -1373,11 +1416,14 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		 */
 		prealloc->start = start;
 		prealloc->end = this_end;
-		err = insert_state(tree, prealloc, bits, NULL);
-		if (err)
+		inserted_state = insert_state(tree, prealloc, bits, NULL);
+		if (IS_ERR(inserted_state)) {
+			err = PTR_ERR(inserted_state);
 			extent_io_tree_panic(tree, err);
-		cache_state(prealloc, cached_state);
-		prealloc = NULL;
+		}
+		cache_state(inserted_state, cached_state);
+		if (inserted_state == prealloc)
+			prealloc = NULL;
 		start = this_end + 1;
 		goto search_again;
 	}
-- 
2.40.1

