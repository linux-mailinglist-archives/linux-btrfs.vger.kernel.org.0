Return-Path: <linux-btrfs+bounces-12611-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C91A73679
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 17:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 078003B6534
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 16:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB521A5BAD;
	Thu, 27 Mar 2025 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkSsLa3f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9BD1A3A8A
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743092039; cv=none; b=mKaq81+oOSDzXqsuRvuQ/mAjkGhKa4jpl9bHxaePZdxBqP4NVH26ETO06d7uGZex+EcJ/a7gAUmwePxLoqJwILt+Hfy/1aVR33G95LyC9zdexydEuvpXbwLXhoQsY1Jmp3tOQ88d4fMk8vmlpT/UQCUHRx2eeaVOVzy4jPuKcZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743092039; c=relaxed/simple;
	bh=hzNvGHPoAIyNT0XHe+i2gRaAtOx8wdfGRlJn+eIiKO8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FC3YehG4Hk5C+f2yb3YjTTGSMymYE/j8x566e1Sjkp20VqoZtz/5TP4w38GPrRIyFeWaufhEbzosgmfPy1PCD+EPqr3jIJbUUWuv26Pn7ydSumqFQOJ5hHk5YnY7k++LDcqMXZjrDXGTFYCZw92Tu9z3Uo14cmwX5NriRJ6EH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkSsLa3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5F7C4CEDD
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 16:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743092038;
	bh=hzNvGHPoAIyNT0XHe+i2gRaAtOx8wdfGRlJn+eIiKO8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UkSsLa3fLMP/XGVeHTPUoobgVgAYnPqTyHSqYRlx07KC4hp31MY5xT7wFrB6pLT0S
	 IAE2UxClYQ8nwqUQefJkLzy/ui49vHuHsHnuYVqCtnjNUnYMd2OvxdzO5olG1HLwcB
	 NvvibbHjo50ooyLxVulZeRdxg0RUQnYAy/elTYaGW5hM1fBkgAYLA0Fjs0e+VYWPxt
	 sX7Ykr+rUFIJIXS286GDWPLHuz8bnhWI3lqzQ9aL+1gwYy5vWmxKQZMoH2FnGsFXc4
	 JOjkglI8yplBneNUuTn0krgcA1hyhaI8lbLnB/Xo+2eNIRZ2v6yAO8ski7HH+RzgaI
	 MmNRXDBo+3utQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: pass a pointer to get_range_bits() to cache first search result
Date: Thu, 27 Mar 2025 16:13:52 +0000
Message-Id: <6e5df30b5e774df8bdfa24b34cceaa717ede7453.1743004734.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743004734.git.fdmanana@suse.com>
References: <cover.1743004734.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Allow get_range_bits() to take an extent state pointer to pointer argument
so that we can cache the first extent state record in the target range, so
that a caller can use it for subsequent operations without doing a full
tree search. Currently the only user is try_release_extent_state(), which
then does a call to __clear_extent_bit() which can use such a cached state
record.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 14 +++++++++++++-
 fs/btrfs/extent-io-tree.h |  3 ++-
 fs/btrfs/extent_io.c      | 18 +++++++++++-------
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 14510a71a8fd..7ae24a533404 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1752,14 +1752,26 @@ bool test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64 end, u32
 	return bitset;
 }
 
-void get_range_bits(struct extent_io_tree *tree, u64 start, u64 end, u32 *bits)
+void get_range_bits(struct extent_io_tree *tree, u64 start, u64 end, u32 *bits,
+		    struct extent_state **cached_state)
 {
 	struct extent_state *state;
 
+	/*
+	 * The cached state is currently mandatory and not used to start the
+	 * search, only to cache the first state record found in the range.
+	 */
+	ASSERT(cached_state != NULL);
+	ASSERT(*cached_state == NULL);
+
 	*bits = 0;
 
 	spin_lock(&tree->lock);
 	state = tree_search(tree, start);
+	if (state && state->start < end) {
+		*cached_state = state;
+		refcount_inc(&state->refs);
+	}
 	while (state) {
 		if (state->start > end)
 			break;
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index e49f24151167..cf83e094b00e 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -171,7 +171,8 @@ void free_extent_state(struct extent_state *state);
 bool test_range_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bit,
 		    struct extent_state *cached_state);
 bool test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64 end, u32 bit);
-void get_range_bits(struct extent_io_tree *tree, u64 start, u64 end, u32 *bits);
+void get_range_bits(struct extent_io_tree *tree, u64 start, u64 end, u32 *bits,
+		    struct extent_state **cached_state);
 int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			     u32 bits, struct extent_changeset *changeset);
 int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6b9a80f9e0f5..6a6f9ded00e3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2625,13 +2625,15 @@ int extent_invalidate_folio(struct extent_io_tree *tree,
 static bool try_release_extent_state(struct extent_io_tree *tree,
 				     struct folio *folio)
 {
+	struct extent_state *cached_state = NULL;
 	u64 start = folio_pos(folio);
 	u64 end = start + folio_size(folio) - 1;
 	u32 range_bits;
 	u32 clear_bits;
-	int ret;
+	bool ret = false;
+	int ret2;
 
-	get_range_bits(tree, start, end, &range_bits);
+	get_range_bits(tree, start, end, &range_bits, &cached_state);
 
 	/*
 	 * We can release the folio if it's locked only for ordered extent
@@ -2639,7 +2641,7 @@ static bool try_release_extent_state(struct extent_io_tree *tree,
 	 */
 	if ((range_bits & EXTENT_LOCKED) &&
 	    !(range_bits & EXTENT_FINISHING_ORDERED))
-		return false;
+		goto out;
 
 	clear_bits = ~(EXTENT_LOCKED | EXTENT_NODATASUM | EXTENT_DELALLOC_NEW |
 		       EXTENT_CTLBITS | EXTENT_QGROUP_RESERVED |
@@ -2649,15 +2651,17 @@ static bool try_release_extent_state(struct extent_io_tree *tree,
 	 * nodatasum, delalloc new and finishing ordered bits. The delalloc new
 	 * bit will be cleared by ordered extent completion.
 	 */
-	ret = __clear_extent_bit(tree, start, end, clear_bits, NULL, NULL);
+	ret2 = __clear_extent_bit(tree, start, end, clear_bits, &cached_state, NULL);
 	/*
 	 * If clear_extent_bit failed for enomem reasons, we can't allow the
 	 * release to continue.
 	 */
-	if (ret < 0)
-		return false;
+	if (ret2 == 0)
+		ret = true;
+out:
+	free_extent_state(cached_state);
 
-	return true;
+	return ret;
 }
 
 /*
-- 
2.45.2


