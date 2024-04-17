Return-Path: <linux-btrfs+bounces-4332-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346888A81A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 13:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5735E1C22B58
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 11:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE8B13F427;
	Wed, 17 Apr 2024 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPHdSVkZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF1F13E41B
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351833; cv=none; b=aAc79N/ujUOsFKwOW3YXHqvvE1gq74O3AbloU/wyAiJz3DIoGs8z8g8Yem7BRAALpBZXAiONbMfU7Le/5/sN7f+ISWeo/Gizh2x4/F4HYGvYNx88fQKh4Q8kGZ+Np9DMez1PyBXfO12jaIG1IM5ldmxs3NIfp5QQFzZh2fc3Mwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351833; c=relaxed/simple;
	bh=+2rJfZ+rgSP1rvZsl6ZHDHYCz31rfo8CeBtXIr0kjRA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PO1M/1ZioNegnXQscRKKvml7JHj93jq9OgFt1kND8FA4uDoKiflnu1tNWtIivUDic8q+F1O2Lus3XxF4SAw/DyYWUbukyj7A0zO01q//TktTavcY5U5UP3YQ/M7ChmYxrTVY8lu/aVReECNpEti2dah2ZkbmBriomJ9M85YFXZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPHdSVkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DE1C32781
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 11:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713351832;
	bh=+2rJfZ+rgSP1rvZsl6ZHDHYCz31rfo8CeBtXIr0kjRA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uPHdSVkZsshjQjdF4WVJl4sy7o0AYLrZS+gNX/aw4OBYdOUog3yXQ063RhDvI8L5k
	 W4vsHp9yjPqX/BQC3AT2se3M4oy2Pu2bz4nByiTgRmtzjK4Oqjhns/NYlURseNzOGg
	 gUC9djOI+tJoFcPm3W2bn6pi1K6yJAeMG73MN7upZ64gzzm8jTrMVBjGUq3Jf9L2ks
	 cRTP2IVMkijDiZPT3PIj/cxMKUwzLYfniNy8464fPrJfSoieFEtuNvfftoADfHvir6
	 RLCQ8FASbBSR/t2OB9NmTpr/13l/n8s2m1fuskqwUK4lOq8FsDHNXS+aMHF8vBDKQU
	 Dv16bnfvkkK5Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/5] btrfs: be better releasing extent maps at try_release_extent_mapping()
Date: Wed, 17 Apr 2024 12:03:34 +0100
Message-Id: <225a3fc5fdbe804cf40dabe27f0d8a9f07f9a1d3.1713302470.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713302470.git.fdmanana@suse.com>
References: <cover.1713302470.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At try_release_extent_mapping(), called during the release folio callback
(btrfs_release_folio() callchain), we don't release any extent maps in the
range if the gfp flags don't allow blocking. This behaviour is exaggerated
because:

1) Both searching for extent maps and removing them are not blocking
   operations. The only thing that it is the cond_resched() call at the
   end of the loop that searches for and removes extent maps;

2) We currently only operate on a single page, so for the case where
   block size matches the page size, we can only have one extent map,
   and for the case where the block size is smaller than the page size,
   we can have at most 16 extent maps.

So it's very unlikely the cond_resched() call will ever block even in the
block size smaller than page size scenario.

So instead of not removing any extent maps at all in case the gfp glags
don't allow blocking, keep removing extent maps while we don't need to
reschedule. This makes it safe for the subpage case and for a future
where we can process folios with a size larger than a page.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 120 ++++++++++++++++++++++---------------------
 1 file changed, 61 insertions(+), 59 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ff9132b897e3..2230e6b6ba95 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2395,73 +2395,75 @@ static int try_release_extent_state(struct extent_io_tree *tree,
  */
 int try_release_extent_mapping(struct page *page, gfp_t mask)
 {
-	struct extent_map *em;
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
 	struct btrfs_inode *inode = page_to_inode(page);
 	struct extent_io_tree *io_tree = &inode->io_tree;
-	struct extent_map_tree *extent_tree = &inode->extent_tree;
-
-	if (gfpflags_allow_blocking(mask)) {
-		u64 len;
-		while (start <= end) {
-			const u64 cur_gen = btrfs_get_fs_generation(inode->root->fs_info);
-
-			len = end - start + 1;
-			write_lock(&extent_tree->lock);
-			em = lookup_extent_mapping(extent_tree, start, len);
-			if (!em) {
-				write_unlock(&extent_tree->lock);
-				break;
-			}
-			if ((em->flags & EXTENT_FLAG_PINNED) ||
-			    em->start != start) {
-				write_unlock(&extent_tree->lock);
-				free_extent_map(em);
-				break;
-			}
-			if (test_range_bit_exists(io_tree, em->start,
-						  extent_map_end(em) - 1,
-						  EXTENT_LOCKED))
-				goto next;
-			/*
-			 * If it's not in the list of modified extents, used
-			 * by a fast fsync, we can remove it. If it's being
-			 * logged we can safely remove it since fsync took an
-			 * extra reference on the em.
-			 */
-			if (list_empty(&em->list) ||
-			    (em->flags & EXTENT_FLAG_LOGGING))
-				goto remove_em;
-			/*
-			 * If it's in the list of modified extents, remove it
-			 * only if its generation is older then the current one,
-			 * in which case we don't need it for a fast fsync.
-			 * Otherwise don't remove it, we could be racing with an
-			 * ongoing fast fsync that could miss the new extent.
-			 */
-			if (em->generation >= cur_gen)
-				goto next;
-remove_em:
-			/*
-			 * We only remove extent maps that are not in the list of
-			 * modified extents or that are in the list but with a
-			 * generation lower then the current generation, so there
-			 * is no need to set the full fsync flag on the inode (it
-			 * hurts the fsync performance for workloads with a data
-			 * size that exceeds or is close to the system's memory).
-			 */
-			remove_extent_mapping(inode, em);
-			/* once for the rb tree */
+
+	while (start <= end) {
+		const u64 cur_gen = btrfs_get_fs_generation(inode->root->fs_info);
+		const u64 len = end - start + 1;
+		struct extent_map_tree *extent_tree = &inode->extent_tree;
+		struct extent_map *em;
+
+		write_lock(&extent_tree->lock);
+		em = lookup_extent_mapping(extent_tree, start, len);
+		if (!em) {
+			write_unlock(&extent_tree->lock);
+			break;
+		}
+		if ((em->flags & EXTENT_FLAG_PINNED) || em->start != start) {
+			write_unlock(&extent_tree->lock);
 			free_extent_map(em);
+			break;
+		}
+		if (test_range_bit_exists(io_tree, em->start,
+					  extent_map_end(em) - 1, EXTENT_LOCKED))
+			goto next;
+		/*
+		 * If it's not in the list of modified extents, used by a fast
+		 * fsync, we can remove it. If it's being logged we can safely
+		 * remove it since fsync took an extra reference on the em.
+		 */
+		if (list_empty(&em->list) || (em->flags & EXTENT_FLAG_LOGGING))
+			goto remove_em;
+		/*
+		 * If it's in the list of modified extents, remove it only if
+		 * its generation is older then the current one, in which case
+		 * we don't need it for a fast fsync. Otherwise don't remove it,
+		 * we could be racing with an ongoing fast fsync that could miss
+		 * the new extent.
+		 */
+		if (em->generation >= cur_gen)
+			goto next;
+remove_em:
+		/*
+		 * We only remove extent maps that are not in the list of
+		 * modified extents or that are in the list but with a
+		 * generation lower then the current generation, so there is no
+		 * need to set the full fsync flag on the inode (it hurts the
+		 * fsync performance for workloads with a data size that exceeds
+		 * or is close to the system's memory).
+		 */
+		remove_extent_mapping(inode, em);
+		/* Once for the inode's extent map tree. */
+		free_extent_map(em);
 next:
-			start = extent_map_end(em);
-			write_unlock(&extent_tree->lock);
+		start = extent_map_end(em);
+		write_unlock(&extent_tree->lock);
 
-			/* once for us */
-			free_extent_map(em);
+		/* Once for us, for the lookup_extent_mapping() reference. */
+		free_extent_map(em);
+
+		if (need_resched()) {
+			/*
+			 * If we need to resched but we can't block just exit
+			 * and leave any remaining extent maps.
+			 */
+			if (!gfpflags_allow_blocking(mask))
+				break;
 
-			cond_resched(); /* Allow large-extent preemption. */
+			cond_resched();
 		}
 	}
 	return try_release_extent_state(io_tree, page, mask);
-- 
2.43.0


