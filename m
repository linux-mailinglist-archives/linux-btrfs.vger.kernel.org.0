Return-Path: <linux-btrfs+bounces-12839-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF0CA7E8B3
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 19:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051F91893C39
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 17:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA52227599;
	Mon,  7 Apr 2025 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq8F6KMZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E13921ADC2
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047388; cv=none; b=S1W8HDlOT+wdpKnBDk9QscJ+6qiIa/wphgFrdkpNsCDupIz7LPpkzyd3XT22y8/NdgWCAxnYDHcm0PuOUHATeDxcTU16bxUjkJ08qQfXff5Oerjzgl3wsj69xHgE4vMssg6XusiyIxCk0WIMud5ZU4gibp4iYY7n+RNhlMcn800=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047388; c=relaxed/simple;
	bh=BifU0Evu7nYaMCsKFAMeXKiUFp9PFIu0AK6mrJCeLs4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JLkmAp1GsTiuNCUeFcE98E1uywm8DoAEDsIHaJszs8iOWAkDGY1WiTak+Lf2K2xIE1mOIGACAMosqFvqFNyo/IcKpbn16uqrsmIZH5Ij33CqoIZov1OoPpdO8n2ZuZ4m8GG9f4bz2C4UJMdjLYD3Y0mk1zFapwmQG64O0/E2izk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq8F6KMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45EAC4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047387;
	bh=BifU0Evu7nYaMCsKFAMeXKiUFp9PFIu0AK6mrJCeLs4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lq8F6KMZ4tScKCtfMth94Xa+tlcNdg7hvRxxyg6tuzJQzqn8ePijXk9WexHSiE7DZ
	 EsImuP3kWLdUPvqSZZsXZtUpwNhmBzPCMDMgl/upSNZOXvcJ4UMoFxs7cf/52eBYMI
	 I5gvqCZR+JjSlPlosphiHbBQB5klupk0I10NSv9s5TXlV6xJzMJIfIOiGt2fDrZhZ3
	 zgq3tp3EK6m5YgLHyNy968lHzfGIH32aeSTUXSi/HvLyBUZjvWPD4nMFzXL6ndNKQa
	 9iCKUXIaFJUfaHgXDKKNGfK1xNeY0n6JuV1pWaIm0Cw6PUhLgA3yB5d3prd9Z8mSD9
	 KH7Kzjbt5JxXA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 01/16] btrfs: remove extent_io_tree_to_inode() and is_inode_io_tree()
Date: Mon,  7 Apr 2025 18:36:08 +0100
Message-Id: <ff5526066ce19b76e1b2b596813d480138e86699.1744046765.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744046765.git.fdmanana@suse.com>
References: <cover.1744046765.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

These functions aren't used outside extent-io-tree.c, but yet one of them
(extent_io_tree_to_inode()) is unnecessarily exported in the header.

Furthermore their single use is in a pattern like this:

    if (is_inode_io_tree(tree))
        foo(extent_io_tree_to_inode(tree), ...);

So we're effectively unnecessarily adding more indirection, checking
twice if tree->owner == IO_TREE_INODE_IO before getting the inode and
doing a non-inline function call to get tree->inode.

Simplify this by removing these helper functions and instead doing
thing like this:

   if (tree->owner == IO_TREE_INODE_IO)
       foo(tree->inode, ...);

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 55 ++++++++++++---------------------------
 fs/btrfs/extent-io-tree.h |  1 -
 2 files changed, 16 insertions(+), 40 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index d833ab2d69a1..40da61cf3f0e 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -80,23 +80,6 @@ static inline void __btrfs_debug_check_extent_io_range(const char *caller,
 #define btrfs_debug_check_extent_io_range(c, s, e)	do {} while (0)
 #endif
 
-
-/*
- * The only tree allowed to set the inode is IO_TREE_INODE_IO.
- */
-static bool is_inode_io_tree(const struct extent_io_tree *tree)
-{
-	return tree->owner == IO_TREE_INODE_IO;
-}
-
-/* Return the inode if it's valid for the given tree, otherwise NULL. */
-struct btrfs_inode *extent_io_tree_to_inode(struct extent_io_tree *tree)
-{
-	if (tree->owner == IO_TREE_INODE_IO)
-		return tree->inode;
-	return NULL;
-}
-
 /* Read-only access to the inode. */
 const struct btrfs_inode *extent_io_tree_to_inode_const(const struct extent_io_tree *tree)
 {
@@ -362,9 +345,8 @@ static void merge_prev_state(struct extent_io_tree *tree, struct extent_state *s
 
 	prev = prev_state(state);
 	if (prev && prev->end == state->start - 1 && prev->state == state->state) {
-		if (is_inode_io_tree(tree))
-			btrfs_merge_delalloc_extent(extent_io_tree_to_inode(tree),
-						    state, prev);
+		if (tree->owner == IO_TREE_INODE_IO)
+			btrfs_merge_delalloc_extent(tree->inode, state, prev);
 		state->start = prev->start;
 		rb_erase(&prev->rb_node, &tree->state);
 		RB_CLEAR_NODE(&prev->rb_node);
@@ -378,9 +360,8 @@ static void merge_next_state(struct extent_io_tree *tree, struct extent_state *s
 
 	next = next_state(state);
 	if (next && next->start == state->end + 1 && next->state == state->state) {
-		if (is_inode_io_tree(tree))
-			btrfs_merge_delalloc_extent(extent_io_tree_to_inode(tree),
-						    state, next);
+		if (tree->owner == IO_TREE_INODE_IO)
+			btrfs_merge_delalloc_extent(tree->inode, state, next);
 		state->end = next->end;
 		rb_erase(&next->rb_node, &tree->state);
 		RB_CLEAR_NODE(&next->rb_node);
@@ -413,8 +394,8 @@ static void set_state_bits(struct extent_io_tree *tree,
 	u32 bits_to_set = bits & ~EXTENT_CTLBITS;
 	int ret;
 
-	if (is_inode_io_tree(tree))
-		btrfs_set_delalloc_extent(extent_io_tree_to_inode(tree), state, bits);
+	if (tree->owner == IO_TREE_INODE_IO)
+		btrfs_set_delalloc_extent(tree->inode, state, bits);
 
 	ret = add_extent_changeset(state, bits_to_set, changeset, 1);
 	BUG_ON(ret < 0);
@@ -459,10 +440,9 @@ static struct extent_state *insert_state(struct extent_io_tree *tree,
 		if (state->end < entry->start) {
 			if (try_merge && end == entry->start &&
 			    state->state == entry->state) {
-				if (is_inode_io_tree(tree))
-					btrfs_merge_delalloc_extent(
-							extent_io_tree_to_inode(tree),
-							state, entry);
+				if (tree->owner == IO_TREE_INODE_IO)
+					btrfs_merge_delalloc_extent(tree->inode,
+								    state, entry);
 				entry->start = state->start;
 				merge_prev_state(tree, entry);
 				state->state = 0;
@@ -472,10 +452,9 @@ static struct extent_state *insert_state(struct extent_io_tree *tree,
 		} else if (state->end > entry->end) {
 			if (try_merge && entry->end == start &&
 			    state->state == entry->state) {
-				if (is_inode_io_tree(tree))
-					btrfs_merge_delalloc_extent(
-							extent_io_tree_to_inode(tree),
-							state, entry);
+				if (tree->owner == IO_TREE_INODE_IO)
+					btrfs_merge_delalloc_extent(tree->inode,
+								    state, entry);
 				entry->end = state->end;
 				merge_next_state(tree, entry);
 				state->state = 0;
@@ -527,9 +506,8 @@ static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
 	struct rb_node *parent = NULL;
 	struct rb_node **node;
 
-	if (is_inode_io_tree(tree))
-		btrfs_split_delalloc_extent(extent_io_tree_to_inode(tree), orig,
-					    split);
+	if (tree->owner == IO_TREE_INODE_IO)
+		btrfs_split_delalloc_extent(tree->inode, orig, split);
 
 	prealloc->start = orig->start;
 	prealloc->end = split - 1;
@@ -576,9 +554,8 @@ static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
 	u32 bits_to_clear = bits & ~EXTENT_CTLBITS;
 	int ret;
 
-	if (is_inode_io_tree(tree))
-		btrfs_clear_delalloc_extent(extent_io_tree_to_inode(tree), state,
-					    bits);
+	if (tree->owner == IO_TREE_INODE_IO)
+		btrfs_clear_delalloc_extent(tree->inode, state, bits);
 
 	ret = add_extent_changeset(state, bits_to_clear, changeset, 0);
 	BUG_ON(ret < 0);
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 6dfe8b097d93..bdcb18324516 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -134,7 +134,6 @@ struct extent_state {
 #endif
 };
 
-struct btrfs_inode *extent_io_tree_to_inode(struct extent_io_tree *tree);
 const struct btrfs_inode *extent_io_tree_to_inode_const(const struct extent_io_tree *tree);
 const struct btrfs_fs_info *extent_io_tree_to_fs_info(const struct extent_io_tree *tree);
 
-- 
2.45.2


