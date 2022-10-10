Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B7A5F9CA6
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 12:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiJJKWl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 06:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiJJKWe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 06:22:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8DA6B159
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 03:22:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D76FC60ECE
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4C8C433C1
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665397346;
        bh=XEHhBU03Mz+hEp5lxPdN8/D4vUQeaLBenLlnWZU9ya4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=orIfnMFPBGNv0ART9CKmJz+qxLLKk7bPysh7hYceqfNXnCpBTnfbiw4EJ1oOMuRP6
         k8An3j15mxNtsQ2w3ft7s0gmnPsJVgN+isgLFwitRUWlErKIAiaG0JXAfEWX3kV2KU
         B4qvyMDpWw9sk69x8txthY7tvd9SbPU0ELvJWK0Qp9ZFoOYeBrBPRL5mBMlyTqwgmi
         gh/bZiGSz1zENXH294GRPsTRkSDSTHIP+oWrTebgqrZseObEmwyIyWXHZQflVyl+QV
         4LoMf3FuyGrKr1/2AIzZWWDLbGMfpAgTBfdTsw/1s/UP5BPm7S0buBeH9wKntcraIl
         JWUTN8K2TgnTw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/18] btrfs: get the next extent map during fiemap/lseek more efficiently
Date:   Mon, 10 Oct 2022 11:22:05 +0100
Message-Id: <2ec5bdb13c1bb6a2d1fb883000f695037cb0f3ac.1665396437.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665396437.git.fdmanana@suse.com>
References: <cover.1665396437.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At find_delalloc_subrange(), when we need to get the next extent map, we
do a full search on the extent map tree (a red black tree). This is fine
but it's a lot more efficient to simply use rb_next(), which typically
requires iterating over less nodes of the tree and never needs to compare
the ranges of nodes with the one we are looking for.

So add a public helper to extent_map.{h,c} to get the extent map that
immediately follows another extent map, using rb_next(), and use that
helper at find_delalloc_subrange().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 31 +++++++++++++++++++++++++++++-
 fs/btrfs/extent_map.h |  2 ++
 fs/btrfs/file.c       | 44 ++++++++++++++++++++++++++-----------------
 3 files changed, 59 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 6092a4eedc92..715979807ae1 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -523,7 +523,7 @@ void replace_extent_mapping(struct extent_map_tree *tree,
 	setup_extent_mapping(tree, new, modified);
 }
 
-static struct extent_map *next_extent_map(struct extent_map *em)
+static struct extent_map *next_extent_map(const struct extent_map *em)
 {
 	struct rb_node *next;
 
@@ -533,6 +533,35 @@ static struct extent_map *next_extent_map(struct extent_map *em)
 	return container_of(next, struct extent_map, rb_node);
 }
 
+/*
+ * Get the extent map that immediately follows another one.
+ *
+ * @tree:       The extent map tree that the extent map belong to.
+ *              Holding read or write access on the tree's lock is required.
+ * @em:         An extent map from the given tree. The caller must ensure that
+ *              between getting @em and between calling this function, the
+ *              extent map @em is not removed from the tree - for example, by
+ *              holding the tree's lock for the duration of those 2 operations.
+ *
+ * Returns the extent map that immediately follows @em, or NULL if @em is the
+ * last extent map in the tree.
+ */
+struct extent_map *btrfs_next_extent_map(const struct extent_map_tree *tree,
+					 const struct extent_map *em)
+{
+	struct extent_map *next;
+
+	/* The lock must be acquired either in read mode or write mode. */
+	lockdep_assert_held(&tree->lock);
+	ASSERT(extent_map_in_tree(em));
+
+	next = next_extent_map(em);
+	if (next)
+		refcount_inc(&next->refs);
+
+	return next;
+}
+
 static struct extent_map *prev_extent_map(struct extent_map *em)
 {
 	struct rb_node *prev;
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index ad311864272a..68d3f2c9ea1d 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -87,6 +87,8 @@ static inline u64 extent_map_block_end(struct extent_map *em)
 void extent_map_tree_init(struct extent_map_tree *tree);
 struct extent_map *lookup_extent_mapping(struct extent_map_tree *tree,
 					 u64 start, u64 len);
+struct extent_map *btrfs_next_extent_map(const struct extent_map_tree *tree,
+					 const struct extent_map *em);
 int add_extent_mapping(struct extent_map_tree *tree,
 		       struct extent_map *em, int modified);
 void remove_extent_mapping(struct extent_map_tree *tree, struct extent_map *em);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 176b432035ae..4a9a2e660b42 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3550,40 +3550,50 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
 	 */
 	read_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, start, len);
-	read_unlock(&em_tree->lock);
+	if (!em) {
+		read_unlock(&em_tree->lock);
+		return (delalloc_len > 0);
+	}
 
 	/* extent_map_end() returns a non-inclusive end offset. */
-	em_end = em ? extent_map_end(em) : 0;
+	em_end = extent_map_end(em);
 
 	/*
 	 * If we have a hole/prealloc extent map, check the next one if this one
 	 * ends before our range's end.
 	 */
-	if (em && (em->block_start == EXTENT_MAP_HOLE ||
-		   test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) && em_end < end) {
+	if ((em->block_start == EXTENT_MAP_HOLE ||
+	     test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) && em_end < end) {
 		struct extent_map *next_em;
 
-		read_lock(&em_tree->lock);
-		next_em = lookup_extent_mapping(em_tree, em_end, len - em_end);
-		read_unlock(&em_tree->lock);
-
+		next_em = btrfs_next_extent_map(em_tree, em);
 		free_extent_map(em);
-		em_end = next_em ? extent_map_end(next_em) : 0;
+
+		/*
+		 * There's no next extent map or the next one starts beyond our
+		 * range, return the range found in the io tree (if any).
+		 */
+		if (!next_em || next_em->start > end) {
+			read_unlock(&em_tree->lock);
+			free_extent_map(next_em);
+			return (delalloc_len > 0);
+		}
+
+		em_end = extent_map_end(next_em);
 		em = next_em;
 	}
 
-	if (em && (em->block_start == EXTENT_MAP_HOLE ||
-		   test_bit(EXTENT_FLAG_PREALLOC, &em->flags))) {
-		free_extent_map(em);
-		em = NULL;
-	}
+	read_unlock(&em_tree->lock);
 
 	/*
-	 * No extent map or one for a hole or prealloc extent. Use the delalloc
-	 * range we found in the io tree if we have one.
+	 * We have a hole or prealloc extent that ends at or beyond our range's
+	 * end, return the range found in the io tree (if any).
 	 */
-	if (!em)
+	if (em->block_start == EXTENT_MAP_HOLE ||
+	    test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
+		free_extent_map(em);
 		return (delalloc_len > 0);
+	}
 
 	/*
 	 * We don't have any range as EXTENT_DELALLOC in the io tree, so the
-- 
2.35.1

