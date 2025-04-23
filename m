Return-Path: <linux-btrfs+bounces-13308-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2075A98CBF
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BDF23A5DF4
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 14:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBC927FD7E;
	Wed, 23 Apr 2025 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udJeXzc7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F229B27CCDF
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418019; cv=none; b=janzKPTCBC4xHeVuM+fOcXWw1H0jD31hUvlKzHlxRvTmWDwS6IKGN/noo0nykdI/B53WoWb3hM6EW8Zcznw3k/wYrZDPkJf5iBs/Cb0JvNJwgYv0WBa0/jPe8HQ4yEtGvkitdrHi1iH+aYFzJi03o5Oz8kRH+BtQn7cvKGshXRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418019; c=relaxed/simple;
	bh=Mso19FsSjWh/cLHSGiYhF/o0EKB4ylKB0ELe/p/XfQU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lwTliwcGzjVo7OtklwhuxqSTTjmzaKcP7CJsgz/++OdGA+QTFCudY7MoYsfZXAE3zK6AB9SiZ6zNibWW7r1ymBJ+EyaqnkywDwH4Vm0ZFw2HB2TlLCcgdl5ibo0PkZs32eTJlPN+aQ6y7MPu7bEZguNWFtjslKlcp0KbVVu4Fsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udJeXzc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB5DC4CEE2
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745418016;
	bh=Mso19FsSjWh/cLHSGiYhF/o0EKB4ylKB0ELe/p/XfQU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=udJeXzc7hN/tTR9VS8A0s6W2JRxypjFjNqlqpg5/dg65QTRztpSUnpexEYi6RVtWT
	 uF7tESJPHTMDGux5u6W6TzYCpqxcB5VwLHUt/VaNAOwQxLl3YDLOBQk06TG8rVaxvS
	 9JDwTeLIXCmzVJfx7B5oNylZKnMiZkymBnMcb4iNvriX/XvsGZbi2nmEXmSsej1AP1
	 7fTQhK125NezMydwlNSd0py/j7Bv7t1HkF6CCTKKANfmBt+hJvxuWDXekGFKT1xz6b
	 6ZJrgZ6lInFXlyp//EjPQ8g6SzQ9dMNI6hbthltjKCxJmtD4Bt6jq8O8fYStZdLzXS
	 mgUs3taG4Rggg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 10/22] btrfs: avoid unnecessary next node searches when clearing bits from extent range
Date: Wed, 23 Apr 2025 15:19:50 +0100
Message-Id: <73d68a9cbf6944f14cb87936bfce3eefea3e2a74.1745401628.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745401627.git.fdmanana@suse.com>
References: <cover.1745401627.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When clearing bits for a range in an io tree, at clear_state_bit(), we
always go search for the next node (through next_state() -> rb_next()) and
return it. However if the current extent state record ends at or after the
target range passed to btrfs_clear_extent_bit_changeset() or
btrfs_convert_extent_bit(), we are just wasting time finding that next
node since we won't use it in those functions.

Improve on this by skipping the next node search if the current node ends
at or after the target range.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 41 ++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 591111879aec..bb829c5703f2 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -544,12 +544,9 @@ static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
  * If no bits are set on the state struct after clearing things, the
  * struct is freed and removed from the tree
  */
-static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
-					    struct extent_state *state,
-					    u32 bits, int wake,
-					    struct extent_changeset *changeset)
+static void clear_state_bit(struct extent_io_tree *tree, struct extent_state *state,
+			    u32 bits, int wake, struct extent_changeset *changeset)
 {
-	struct extent_state *next;
 	u32 bits_to_clear = bits & ~EXTENT_CTLBITS;
 	int ret;
 
@@ -562,7 +559,6 @@ static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
 	if (wake)
 		wake_up(&state->wq);
 	if (state->state == 0) {
-		next = next_state(state);
 		if (extent_state_in_tree(state)) {
 			rb_erase(&state->rb_node, &tree->state);
 			RB_CLEAR_NODE(&state->rb_node);
@@ -572,9 +568,7 @@ static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
 		}
 	} else {
 		merge_state(tree, state);
-		next = next_state(state);
 	}
-	return next;
 }
 
 /*
@@ -587,6 +581,18 @@ static void set_gfp_mask_from_bits(u32 *bits, gfp_t *mask)
 	*bits &= EXTENT_NOWAIT - 1;
 }
 
+/*
+ * Use this during tree iteration to avoid doing next node searches when it's
+ * not needed (the current record ends at or after the target range's end).
+ */
+static inline struct extent_state *next_search_state(struct extent_state *state, u64 end)
+{
+	if (state->end < end)
+		return next_state(state);
+
+	return NULL;
+}
+
 /*
  * Clear some bits on a range in the tree.  This may require splitting or
  * inserting elements in the tree, so the gfp mask is used to indicate which
@@ -601,6 +607,7 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
 				     struct extent_changeset *changeset)
 {
 	struct extent_state *state;
+	struct extent_state *next;
 	struct extent_state *cached;
 	struct extent_state *prealloc = NULL;
 	u64 last_end;
@@ -666,7 +673,7 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
 
 	/* The state doesn't have the wanted bits, go ahead. */
 	if (!(state->state & bits)) {
-		state = next_state(state);
+		next = next_search_state(state, end);
 		goto next;
 	}
 
@@ -696,7 +703,8 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
 			goto out;
 		}
 		if (state->end <= end) {
-			state = clear_state_bit(tree, state, bits, wake, changeset);
+			next = next_search_state(state, end);
+			clear_state_bit(tree, state, bits, wake, changeset);
 			goto next;
 		}
 		if (need_resched())
@@ -732,11 +740,13 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
 		goto out;
 	}
 
-	state = clear_state_bit(tree, state, bits, wake, changeset);
+	next = next_search_state(state, end);
+	clear_state_bit(tree, state, bits, wake, changeset);
 next:
 	if (last_end >= end)
 		goto out;
 	start = last_end + 1;
+	state = next;
 	if (state && !need_resched())
 		goto hit_next;
 
@@ -1292,6 +1302,7 @@ int btrfs_convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 			     struct extent_state **cached_state)
 {
 	struct extent_state *state;
+	struct extent_state *next;
 	struct extent_state *prealloc = NULL;
 	struct rb_node **p = NULL;
 	struct rb_node *parent = NULL;
@@ -1357,10 +1368,12 @@ int btrfs_convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	if (state->start == start && state->end <= end) {
 		set_state_bits(tree, state, bits, NULL);
 		cache_state(state, cached_state);
-		state = clear_state_bit(tree, state, clear_bits, 0, NULL);
+		next = next_search_state(state, end);
+		clear_state_bit(tree, state, clear_bits, 0, NULL);
 		if (last_end == (u64)-1)
 			goto out;
 		start = last_end + 1;
+		state = next;
 		if (start < end && state && state->start == start &&
 		    !need_resched())
 			goto hit_next;
@@ -1397,10 +1410,12 @@ int btrfs_convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		if (state->end <= end) {
 			set_state_bits(tree, state, bits, NULL);
 			cache_state(state, cached_state);
-			state = clear_state_bit(tree, state, clear_bits, 0, NULL);
+			next = next_search_state(state, end);
+			clear_state_bit(tree, state, clear_bits, 0, NULL);
 			if (last_end == (u64)-1)
 				goto out;
 			start = last_end + 1;
+			state = next;
 			if (start < end && state && state->start == start &&
 			    !need_resched())
 				goto hit_next;
-- 
2.47.2


