Return-Path: <linux-btrfs+bounces-12610-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267ACA73678
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 17:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B213B77A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 16:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC421A3163;
	Thu, 27 Mar 2025 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5rKXnQn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A801A2846
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743092038; cv=none; b=VPTzegeUpNcnQKJ/X4VVeHnaJ2ayOAuoSo+ow/Nq+cNq3fFbqkuDmlQzbaJ70yHFCYTqbQRosmD1lkTSWPCfXGwAL33YdyPswJaoPwSO+Jv6GefPpB9SVYJn5NkRyBmv1MbWwJbcCCT7+iy2r5iU+52jYeP9SR6G6Af/JtDOn+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743092038; c=relaxed/simple;
	bh=eJg2Y6t4wDtRnf6qwDghQQK0IczGvXuCl+jUu2pSrzs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DsgYvF9u9mkG8zrB9jOvok6Gq23mRRpIZPS6ijUrlYMqOJVwNQTSltUECN6sgIRp93uwb+1+iSvK684AYnRPO/+6VN8wvcv0IpEtplw3nVIIaRwlF7RZkCvw24Jt0MJkW7RKX6u6upc7/9KHEYs1k/G0pwGjle4uJJ5bI11zMJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5rKXnQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B6FC4CEED
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 16:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743092037;
	bh=eJg2Y6t4wDtRnf6qwDghQQK0IczGvXuCl+jUu2pSrzs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=k5rKXnQnxzKFXATpLtBU3np/4bhFibAiGoX/nHmg2pQzZs8WJFJRY2sfUQK/0DOFW
	 wNnjZFa6j5DYAGzbY0/uxj1vmuwWUgBQv5/fkmPrLzyc6H4f3NR/CyCJxBK9v/j8L0
	 wAo6EjVv5mVOMED6vPKcC3sUHHol1zoti+GOXll9UtPC/0WX8tHkZaTVKlCZzV3pkd
	 mM1OrFlKh6KmSWA5KQlP/Ow8ebnBLpLlk0EglVH4A01P64zSCpGz1EHf4XI5PopwZi
	 Gzf1xQG3VyfvfxvsR3nbhd53n0fVttPV6q0uNr22bvYaoJrS/1sf5nQyf1JrfV16ZI
	 j4o4ZAaz/oMng==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: allow folios to be released while ordered extent is finishing
Date: Thu, 27 Mar 2025 16:13:51 +0000
Message-Id: <c20733c28d02562ff09bfff6739b01b5f710bed7.1743004734.git.fdmanana@suse.com>
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

When the release_folio callback (from struct address_space_operations) is
invoked we don't allow the folio to be released if its range is currently
locked in the inode's io_tree, as it may indicate the folio may be needed
by the task that locked the range.

However if the range is locked because an ordered extent is finishing,
then we can safely allow the folio to be released because ordered extent
completion doesn't need to use the folio at all.

When we are under memory pressure, the kernel starts writeback of dirty
pages (folios) with the goal of releasing the pages from the page cache
after writeback completes, however this often is not possible on btrfs
because:

  * Once the writeback completes we queue the ordered extent completion;

  * Once the ordered extent completion starts, we lock the range in the
    inode's io_tree (at btrfs_finish_one_ordered());

  * If the release_folio callback is called while the folio's range is
    locked in the inode's io_tree, we don't allow the folio to be
    released, so the kernel has to try to release memory elsewhere,
    which may result in triggering more writeback or releasing other
    pages from the page cache which may be more useful to have around
    for applications.

In contrast, when the release_folio callback is invoked after writeback
finishes and before ordered extent completion starts or locks the range,
we allow the folio to be released, as well as when the release_folio
callback is invoked after ordered extent completion unlocks the range.

Improve on this by detecting if the range is locked for ordered extent
completion and if it is, allow the folio to be released. This detection
is achieved by adding a new extent flag in the io_tree that is set when
the range is locked during ordered extent completion.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 22 +++++++++++++++++
 fs/btrfs/extent-io-tree.h |  6 +++++
 fs/btrfs/extent_io.c      | 52 +++++++++++++++++++++------------------
 fs/btrfs/inode.c          |  6 +++--
 4 files changed, 60 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 13de6af279e5..14510a71a8fd 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1752,6 +1752,28 @@ bool test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64 end, u32
 	return bitset;
 }
 
+void get_range_bits(struct extent_io_tree *tree, u64 start, u64 end, u32 *bits)
+{
+	struct extent_state *state;
+
+	*bits = 0;
+
+	spin_lock(&tree->lock);
+	state = tree_search(tree, start);
+	while (state) {
+		if (state->start > end)
+			break;
+
+		*bits |= state->state;
+
+		if (state->end >= end)
+			break;
+
+		state = next_state(state);
+	}
+	spin_unlock(&tree->lock);
+}
+
 /*
  * Check if the whole range [@start,@end) contains the single @bit set.
  */
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 6ffef1cd37c1..e49f24151167 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -38,6 +38,11 @@ enum {
 	 * that is left for the ordered extent completion.
 	 */
 	ENUM_BIT(EXTENT_DELALLOC_NEW),
+	/*
+	 * Mark that a range is being locked for finishing an ordered extent.
+	 * Used together with EXTENT_LOCKED.
+	 */
+	ENUM_BIT(EXTENT_FINISHING_ORDERED),
 	/*
 	 * When an ordered extent successfully completes for a region marked as
 	 * a new delalloc range, use this flag when clearing a new delalloc
@@ -166,6 +171,7 @@ void free_extent_state(struct extent_state *state);
 bool test_range_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bit,
 		    struct extent_state *cached_state);
 bool test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64 end, u32 bit);
+void get_range_bits(struct extent_io_tree *tree, u64 start, u64 end, u32 *bits);
 int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			     u32 bits, struct extent_changeset *changeset);
 int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a11b22fcd154..6b9a80f9e0f5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2627,33 +2627,37 @@ static bool try_release_extent_state(struct extent_io_tree *tree,
 {
 	u64 start = folio_pos(folio);
 	u64 end = start + folio_size(folio) - 1;
-	bool ret;
+	u32 range_bits;
+	u32 clear_bits;
+	int ret;
 
-	if (test_range_bit_exists(tree, start, end, EXTENT_LOCKED)) {
-		ret = false;
-	} else {
-		u32 clear_bits = ~(EXTENT_LOCKED | EXTENT_NODATASUM |
-				   EXTENT_DELALLOC_NEW | EXTENT_CTLBITS |
-				   EXTENT_QGROUP_RESERVED);
-		int ret2;
+	get_range_bits(tree, start, end, &range_bits);
 
-		/*
-		 * At this point we can safely clear everything except the
-		 * locked bit, the nodatasum bit and the delalloc new bit.
-		 * The delalloc new bit will be cleared by ordered extent
-		 * completion.
-		 */
-		ret2 = __clear_extent_bit(tree, start, end, clear_bits, NULL, NULL);
+	/*
+	 * We can release the folio if it's locked only for ordered extent
+	 * completion, since that doesn't require using the folio.
+	 */
+	if ((range_bits & EXTENT_LOCKED) &&
+	    !(range_bits & EXTENT_FINISHING_ORDERED))
+		return false;
 
-		/* if clear_extent_bit failed for enomem reasons,
-		 * we can't allow the release to continue.
-		 */
-		if (ret2 < 0)
-			ret = false;
-		else
-			ret = true;
-	}
-	return ret;
+	clear_bits = ~(EXTENT_LOCKED | EXTENT_NODATASUM | EXTENT_DELALLOC_NEW |
+		       EXTENT_CTLBITS | EXTENT_QGROUP_RESERVED |
+		       EXTENT_FINISHING_ORDERED);
+	/*
+	 * At this point we can safely clear everything except the locked,
+	 * nodatasum, delalloc new and finishing ordered bits. The delalloc new
+	 * bit will be cleared by ordered extent completion.
+	 */
+	ret = __clear_extent_bit(tree, start, end, clear_bits, NULL, NULL);
+	/*
+	 * If clear_extent_bit failed for enomem reasons, we can't allow the
+	 * release to continue.
+	 */
+	if (ret < 0)
+		return false;
+
+	return true;
 }
 
 /*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e283627c087d..469b3fd64f17 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3132,8 +3132,10 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 	 * depending on their current state).
 	 */
 	if (!test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags)) {
-		clear_bits |= EXTENT_LOCKED;
-		lock_extent(io_tree, start, end, &cached_state);
+		clear_bits |= EXTENT_LOCKED | EXTENT_FINISHING_ORDERED;
+		__lock_extent(io_tree, start, end,
+			      EXTENT_LOCKED | EXTENT_FINISHING_ORDERED,
+			      &cached_state);
 	}
 
 	if (freespace_inode)
-- 
2.45.2


