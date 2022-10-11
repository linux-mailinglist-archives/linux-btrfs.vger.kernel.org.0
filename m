Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5FC5FB235
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJKMRY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiJKMRU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:17:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1905B550BD
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 05:17:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8650BB815B1
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CDEC43470
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665490636;
        bh=XEHhBU03Mz+hEp5lxPdN8/D4vUQeaLBenLlnWZU9ya4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=G2hKbX8fnxIlnBn8Ko+VtTNwtRNu6B6ZjT0C/9a0ZoDS/ThOuVB27lcyO/5TLBIln
         ILlOopeqb6H62nHhzvrUJK+YvY8Zw1i82Om+C2Hy7fB5UrwehmShdx3EZ+2Lxq6cI5
         /3wuYTu6vOayMhrXzkWjzfPkBEHbeDUcNpJS73PUgc0ZVVM8JB23VCKUrqdZWTDfzO
         /YEfacyicqIVKwKhftq5Aun6qDzX8Rmw7yBldLPsmGD8dfa7ke+7ocowMUwc9248Nx
         TDUJXP+m2ylTTIffew8azmGSo0t2DjOU5XhsenuWpGdp8QNItHWCMKUS5uKogjEDBz
         zbEj7eUHlv6Rg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 04/19] btrfs: get the next extent map during fiemap/lseek more efficiently
Date:   Tue, 11 Oct 2022 13:16:54 +0100
Message-Id: <27ba24f269d8ebbe114f1fadbc3fca060b970556.1665490018.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665490018.git.fdmanana@suse.com>
References: <cover.1665490018.git.fdmanana@suse.com>
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

