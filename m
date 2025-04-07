Return-Path: <linux-btrfs+bounces-12841-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFCAA7E8B7
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 19:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB87189951D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 17:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42DD22D78F;
	Mon,  7 Apr 2025 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zn4DG4jZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF6122ACF7
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047390; cv=none; b=InBjgHlnID5kR50p0rNyc0xi4tEcTFsU3Ilx1t70Yv1ArhMWgoWeULBhInMFwxPLeqb88EWL0GKJm5xTsSSIWCI2VMKdvqyVjIZjPfkxoRv2xux/QzBwlJ2tVakeUu0xW+vSFZCiQY536jrnyimuQM9282j61sU00OK19OxzQ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047390; c=relaxed/simple;
	bh=85N7zE3LGcDBZ/g36jl3RDk1YhbgAOUK/8IG+0T6rz0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iBT7FBPWuDxsZOofLb8MvugfYsBdqxZ6eMfcPAhjPqRwd0miLlAb7Jvn+IHwdo9vHAPlrk89kndwYpigIEcR0XGOjL89aaOXTEadzw6CApPigdD9LUFnN8SikOEgK8KzVHUCUHtZaV6mGLLtTfHExg/UI9Vj+yeTloPdXkw5/60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zn4DG4jZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052A6C4CEE9
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047389;
	bh=85N7zE3LGcDBZ/g36jl3RDk1YhbgAOUK/8IG+0T6rz0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Zn4DG4jZ5RD8S9vuGM+EZAn0geTWix6nKUEs7YhRs9MG1RGFCjKfAypxuNRiBsPrn
	 e+KuF5eAInMPyxmNgLptrZVTUsG/uWVPhFU2s3qN3c1tmCQTsETATHX0gApPqavtfq
	 liDPBMDt3im7pMDeu9D4HBN2C6TJV0UqtUZdgefCBepgoMOC7/8BKkY7hR4eLOqWxW
	 uyTj/ne2OmBCXK8P2bxg3CT3eVP4/Grq2ulSOR2XGXEdIibOgqljQZyvkRwJTeYQsy
	 fv5trIsME8MPvY3mxVx9KZen6ftvqVrDIQs16Z9/xlR/KRNjc0Ludn+ClZD/81Yb3S
	 Y6wA6PXTzqzJw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 03/16] btrfs: add btrfs prefix to main lock, try lock and unlock extent functions
Date: Mon,  7 Apr 2025 18:36:10 +0100
Message-Id: <00cca0cc2f7a6f75d3de5c48107b2d677ae1a939.1744046765.git.fdmanana@suse.com>
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

These functions are exported so they should have a 'btrfs_' prefix by
convention, to make it clear they are btrfs specific and to avoid
collisions with functions from elsewhere in the kernel. So add a prefix to
their name.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/compression.c           |  6 +--
 fs/btrfs/defrag.c                | 22 ++++----
 fs/btrfs/direct-io.c             |  8 +--
 fs/btrfs/extent-io-tree.h        | 12 ++---
 fs/btrfs/extent_io.c             | 20 ++++----
 fs/btrfs/extent_map.c            |  4 +-
 fs/btrfs/fiemap.c                |  4 +-
 fs/btrfs/file.c                  | 61 +++++++++++-----------
 fs/btrfs/free-space-cache.c      | 16 +++---
 fs/btrfs/inode.c                 | 86 ++++++++++++++++----------------
 fs/btrfs/ioctl.c                 |  8 +--
 fs/btrfs/ordered-data.c          |  8 +--
 fs/btrfs/reflink.c               |  8 +--
 fs/btrfs/relocation.c            | 28 +++++------
 fs/btrfs/tests/extent-io-tests.c |  6 +--
 fs/btrfs/tree-log.c              |  8 +--
 16 files changed, 152 insertions(+), 153 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 11f1dd11d21b..1e6ac863f84a 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -499,7 +499,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		}
 
 		page_end = (pg_index << PAGE_SHIFT) + folio_size(folio) - 1;
-		lock_extent(tree, cur, page_end, NULL);
+		btrfs_lock_extent(tree, cur, page_end, NULL);
 		read_lock(&em_tree->lock);
 		em = lookup_extent_mapping(em_tree, cur, page_end + 1 - cur);
 		read_unlock(&em_tree->lock);
@@ -514,14 +514,14 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		    (extent_map_block_start(em) >> SECTOR_SHIFT) !=
 		    orig_bio->bi_iter.bi_sector) {
 			free_extent_map(em);
-			unlock_extent(tree, cur, page_end, NULL);
+			btrfs_unlock_extent(tree, cur, page_end, NULL);
 			folio_unlock(folio);
 			folio_put(folio);
 			break;
 		}
 		add_size = min(em->start + em->len, page_end + 1) - cur;
 		free_extent_map(em);
-		unlock_extent(tree, cur, page_end, NULL);
+		btrfs_unlock_extent(tree, cur, page_end, NULL);
 
 		if (folio_contains(folio, end_index)) {
 			size_t zero_offset = offset_in_folio(folio, isize);
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index d302a67efced..3e2e462365d6 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -776,10 +776,10 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
 
 		/* Get the big lock and read metadata off disk. */
 		if (!locked)
-			lock_extent(io_tree, start, end, &cached);
+			btrfs_lock_extent(io_tree, start, end, &cached);
 		em = defrag_get_extent(BTRFS_I(inode), start, newer_than);
 		if (!locked)
-			unlock_extent(io_tree, start, end, &cached);
+			btrfs_unlock_extent(io_tree, start, end, &cached);
 
 		if (IS_ERR(em))
 			return NULL;
@@ -891,10 +891,10 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
 	while (1) {
 		struct btrfs_ordered_extent *ordered;
 
-		lock_extent(&inode->io_tree, page_start, page_end, &cached_state);
+		btrfs_lock_extent(&inode->io_tree, page_start, page_end, &cached_state);
 		ordered = btrfs_lookup_ordered_range(inode, page_start, PAGE_SIZE);
-		unlock_extent(&inode->io_tree, page_start, page_end,
-			      &cached_state);
+		btrfs_unlock_extent(&inode->io_tree, page_start, page_end,
+				    &cached_state);
 		if (!ordered)
 			break;
 
@@ -1223,9 +1223,9 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 		folio_wait_writeback(folios[i]);
 
 	/* Lock the pages range */
-	lock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
-		    (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
-		    &cached_state);
+	btrfs_lock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
+			  (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
+			  &cached_state);
 	/*
 	 * Now we have a consistent view about the extent map, re-check
 	 * which range really needs to be defragged.
@@ -1251,9 +1251,9 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 		kfree(entry);
 	}
 unlock_extent:
-	unlock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
-		      (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
-		      &cached_state);
+	btrfs_unlock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
+			    (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
+			    &cached_state);
 free_folios:
 	for (i = 0; i < nr_pages; i++) {
 		folio_unlock(folios[i]);
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index e8548de319e7..f87b5eac6323 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -50,13 +50,13 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 
 	while (1) {
 		if (nowait) {
-			if (!try_lock_extent(io_tree, lockstart, lockend,
-					     cached_state)) {
+			if (!btrfs_try_lock_extent(io_tree, lockstart, lockend,
+						   cached_state)) {
 				ret = -EAGAIN;
 				break;
 			}
 		} else {
-			lock_extent(io_tree, lockstart, lockend, cached_state);
+			btrfs_lock_extent(io_tree, lockstart, lockend, cached_state);
 		}
 		/*
 		 * We're concerned with the entire range that we're going to be
@@ -78,7 +78,7 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 							 lockstart, lockend)))
 			break;
 
-		unlock_extent(io_tree, lockstart, lockend, cached_state);
+		btrfs_unlock_extent(io_tree, lockstart, lockend, cached_state);
 
 		if (ordered) {
 			if (nowait) {
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index bdcb18324516..86436ed37ad6 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -145,14 +145,14 @@ int __lock_extent(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
 bool __try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
 		       struct extent_state **cached);
 
-static inline int lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
-			      struct extent_state **cached)
+static inline int btrfs_lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
+				    struct extent_state **cached)
 {
 	return __lock_extent(tree, start, end, EXTENT_LOCKED, cached);
 }
 
-static inline bool try_lock_extent(struct extent_io_tree *tree, u64 start,
-				   u64 end, struct extent_state **cached)
+static inline bool btrfs_try_lock_extent(struct extent_io_tree *tree, u64 start,
+					 u64 end, struct extent_state **cached)
 {
 	return __try_lock_extent(tree, start, end, EXTENT_LOCKED, cached);
 }
@@ -184,8 +184,8 @@ static inline int clear_extent_bit(struct extent_io_tree *tree, u64 start,
 	return __clear_extent_bit(tree, start, end, bits, cached, NULL);
 }
 
-static inline int unlock_extent(struct extent_io_tree *tree, u64 start, u64 end,
-				struct extent_state **cached)
+static inline int btrfs_unlock_extent(struct extent_io_tree *tree, u64 start, u64 end,
+				      struct extent_state **cached)
 {
 	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, cached, NULL);
 }
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4ccbf8b6b565..82164c1bcd5c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -369,13 +369,13 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	}
 
 	/* step three, lock the state bits for the whole range */
-	lock_extent(tree, delalloc_start, delalloc_end, &cached_state);
+	btrfs_lock_extent(tree, delalloc_start, delalloc_end, &cached_state);
 
 	/* then test to make sure it is all still delalloc */
 	ret = test_range_bit(tree, delalloc_start, delalloc_end,
 			     EXTENT_DELALLOC, cached_state);
 
-	unlock_extent(tree, delalloc_start, delalloc_end, &cached_state);
+	btrfs_unlock_extent(tree, delalloc_start, delalloc_end, &cached_state);
 	if (!ret) {
 		unlock_delalloc_folio(inode, locked_folio, delalloc_start,
 				      delalloc_end);
@@ -1202,7 +1202,7 @@ static void lock_extents_for_read(struct btrfs_inode *inode, u64 start, u64 end,
 	ASSERT(IS_ALIGNED(end + 1, PAGE_SIZE));
 
 again:
-	lock_extent(&inode->io_tree, start, end, cached_state);
+	btrfs_lock_extent(&inode->io_tree, start, end, cached_state);
 	cur_pos = start;
 	while (cur_pos < end) {
 		struct btrfs_ordered_extent *ordered;
@@ -1226,7 +1226,7 @@ static void lock_extents_for_read(struct btrfs_inode *inode, u64 start, u64 end,
 		}
 
 		/* Now wait for the OE to finish. */
-		unlock_extent(&inode->io_tree, start, end, cached_state);
+		btrfs_unlock_extent(&inode->io_tree, start, end, cached_state);
 		btrfs_start_ordered_extent_nowriteback(ordered, start, end + 1 - start);
 		btrfs_put_ordered_extent(ordered);
 		/* We have unlocked the whole range, restart from the beginning. */
@@ -1246,7 +1246,7 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
 
 	lock_extents_for_read(inode, start, end, &cached_state);
 	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
-	unlock_extent(&inode->io_tree, start, end, &cached_state);
+	btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state);
 
 	free_extent_map(em_cached);
 
@@ -1434,8 +1434,8 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			 * We've hit an error during previous delalloc range,
 			 * have to cleanup the remaining locked ranges.
 			 */
-			unlock_extent(&inode->io_tree, found_start,
-				      found_start + found_len - 1, NULL);
+			btrfs_unlock_extent(&inode->io_tree, found_start,
+					    found_start + found_len - 1, NULL);
 			unlock_delalloc_folio(&inode->vfs_inode, folio,
 					      found_start,
 					      found_start + found_len - 1);
@@ -2565,7 +2565,7 @@ void btrfs_readahead(struct readahead_control *rac)
 	while ((folio = readahead_folio(rac)) != NULL)
 		btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
 
-	unlock_extent(&inode->io_tree, start, end, &cached_state);
+	btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state);
 
 	if (em_cached)
 		free_extent_map(em_cached);
@@ -2592,7 +2592,7 @@ int extent_invalidate_folio(struct extent_io_tree *tree,
 	if (start > end)
 		return 0;
 
-	lock_extent(tree, start, end, &cached_state);
+	btrfs_lock_extent(tree, start, end, &cached_state);
 	folio_wait_writeback(folio);
 
 	/*
@@ -2600,7 +2600,7 @@ int extent_invalidate_folio(struct extent_io_tree *tree,
 	 * so here we only need to unlock the extent range to free any
 	 * existing extent state.
 	 */
-	unlock_extent(tree, start, end, &cached_state);
+	btrfs_unlock_extent(tree, start, end, &cached_state);
 	return 0;
 }
 
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index d62c36a0b7ba..67c724a576ee 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1055,7 +1055,7 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 		goto out_free_pre;
 	}
 
-	lock_extent(&inode->io_tree, start, start + len - 1, NULL);
+	btrfs_lock_extent(&inode->io_tree, start, start + len - 1, NULL);
 	write_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, start, len);
 	if (!em) {
@@ -1108,7 +1108,7 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 
 out_unlock:
 	write_unlock(&em_tree->lock);
-	unlock_extent(&inode->io_tree, start, start + len - 1, NULL);
+	btrfs_unlock_extent(&inode->io_tree, start, start + len - 1, NULL);
 	free_extent_map(split_mid);
 out_free_pre:
 	free_extent_map(split_pre);
diff --git a/fs/btrfs/fiemap.c b/fs/btrfs/fiemap.c
index 7715e30508c5..ba65a4821c44 100644
--- a/fs/btrfs/fiemap.c
+++ b/fs/btrfs/fiemap.c
@@ -661,7 +661,7 @@ static int extent_fiemap(struct btrfs_inode *inode,
 	range_end = round_up(start + len, sectorsize);
 	prev_extent_end = range_start;
 
-	lock_extent(&inode->io_tree, range_start, range_end, &cached_state);
+	btrfs_lock_extent(&inode->io_tree, range_start, range_end, &cached_state);
 
 	ret = fiemap_find_last_extent_offset(inode, path, &last_extent_end);
 	if (ret < 0)
@@ -841,7 +841,7 @@ static int extent_fiemap(struct btrfs_inode *inode,
 	}
 
 out_unlock:
-	unlock_extent(&inode->io_tree, range_start, range_end, &cached_state);
+	btrfs_unlock_extent(&inode->io_tree, range_start, range_end, &cached_state);
 
 	if (ret == BTRFS_FIEMAP_FLUSH_CACHE) {
 		btrfs_release_path(path);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 4035c5552fd9..bec7d6ff333d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -921,14 +921,15 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct folio *folio,
 		struct btrfs_ordered_extent *ordered;
 
 		if (nowait) {
-			if (!try_lock_extent(&inode->io_tree, start_pos, last_pos,
-					     cached_state)) {
+			if (!btrfs_try_lock_extent(&inode->io_tree, start_pos,
+						   last_pos, cached_state)) {
 				folio_unlock(folio);
 				folio_put(folio);
 				return -EAGAIN;
 			}
 		} else {
-			lock_extent(&inode->io_tree, start_pos, last_pos, cached_state);
+			btrfs_lock_extent(&inode->io_tree, start_pos, last_pos,
+					  cached_state);
 		}
 
 		ordered = btrfs_lookup_ordered_range(inode, start_pos,
@@ -936,8 +937,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct folio *folio,
 		if (ordered &&
 		    ordered->file_offset + ordered->num_bytes > start_pos &&
 		    ordered->file_offset <= last_pos) {
-			unlock_extent(&inode->io_tree, start_pos, last_pos,
-				      cached_state);
+			btrfs_unlock_extent(&inode->io_tree, start_pos, last_pos,
+					    cached_state);
 			folio_unlock(folio);
 			folio_put(folio);
 			btrfs_start_ordered_extent(ordered);
@@ -1017,7 +1018,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 	else
 		*write_bytes = min_t(size_t, *write_bytes ,
 				     num_bytes - pos + lockstart);
-	unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
+	btrfs_unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 
 	return ret;
 }
@@ -1286,8 +1287,8 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *iter,
 		/* No copied bytes, unlock, release reserved space and exit. */
 		if (copied == 0) {
 			if (extents_locked)
-				unlock_extent(&inode->io_tree, lockstart, lockend,
-					      &cached_state);
+				btrfs_unlock_extent(&inode->io_tree, lockstart, lockend,
+						    &cached_state);
 			else
 				free_extent_state(cached_state);
 			btrfs_delalloc_release_extents(inode, reserved_len);
@@ -1316,7 +1317,7 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *iter,
 	 * to avoid a memory leak.
 	 */
 	if (extents_locked)
-		unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
+		btrfs_unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 	else
 		free_extent_state(cached_state);
 
@@ -1897,11 +1898,11 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	}
 	folio_wait_writeback(folio);
 
-	lock_extent(io_tree, page_start, page_end, &cached_state);
+	btrfs_lock_extent(io_tree, page_start, page_end, &cached_state);
 	ret2 = set_folio_extent_mapped(folio);
 	if (ret2 < 0) {
 		ret = vmf_error(ret2);
-		unlock_extent(io_tree, page_start, page_end, &cached_state);
+		btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
 		goto out_unlock;
 	}
 
@@ -1911,7 +1912,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	 */
 	ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), page_start, fsize);
 	if (ordered) {
-		unlock_extent(io_tree, page_start, page_end, &cached_state);
+		btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
 		folio_unlock(folio);
 		up_read(&BTRFS_I(inode)->i_mmap_lock);
 		btrfs_start_ordered_extent(ordered);
@@ -1943,7 +1944,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	ret2 = btrfs_set_extent_delalloc(BTRFS_I(inode), page_start, end, 0,
 					&cached_state);
 	if (ret2) {
-		unlock_extent(io_tree, page_start, page_end, &cached_state);
+		btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
 		ret = VM_FAULT_SIGBUS;
 		goto out_unlock;
 	}
@@ -1963,7 +1964,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
 	btrfs_set_inode_last_sub_trans(BTRFS_I(inode));
 
-	unlock_extent(io_tree, page_start, page_end, &cached_state);
+	btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
 	up_read(&BTRFS_I(inode)->i_mmap_lock);
 
 	btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
@@ -2224,8 +2225,8 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
 	while (1) {
 		truncate_pagecache_range(inode, lockstart, lockend);
 
-		lock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-			    cached_state);
+		btrfs_lock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+				  cached_state);
 		/*
 		 * We can't have ordered extents in the range, nor dirty/writeback
 		 * pages, because we have locked the inode's VFS lock in exclusive
@@ -2239,8 +2240,8 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
 		if (!check_range_has_page(inode, lockstart, lockend))
 			break;
 
-		unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-			      cached_state);
+		btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+				    cached_state);
 	}
 
 	btrfs_assert_inode_range_clean(BTRFS_I(inode), lockstart, lockend);
@@ -2738,8 +2739,8 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
 out:
-	unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-		      &cached_state);
+	btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+			    &cached_state);
 out_only_mutex:
 	if (!updated_inode && truncated_block && !ret) {
 		/*
@@ -3009,16 +3010,16 @@ static int btrfs_zero_range(struct inode *inode,
 		ret = btrfs_qgroup_reserve_data(BTRFS_I(inode), &data_reserved,
 						alloc_start, bytes_to_reserve);
 		if (ret) {
-			unlock_extent(&BTRFS_I(inode)->io_tree, lockstart,
-				      lockend, &cached_state);
+			btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, lockstart,
+					    lockend, &cached_state);
 			goto out;
 		}
 		ret = btrfs_prealloc_file_range(inode, mode, alloc_start,
 						alloc_end - alloc_start,
 						fs_info->sectorsize,
 						offset + len, &alloc_hint);
-		unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-			      &cached_state);
+		btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+				    &cached_state);
 		/* btrfs_prealloc_file_range releases reserved space on error */
 		if (ret) {
 			space_reserved = false;
@@ -3129,8 +3130,8 @@ static long btrfs_fallocate(struct file *file, int mode,
 	}
 
 	locked_end = alloc_end - 1;
-	lock_extent(&BTRFS_I(inode)->io_tree, alloc_start, locked_end,
-		    &cached_state);
+	btrfs_lock_extent(&BTRFS_I(inode)->io_tree, alloc_start, locked_end,
+			  &cached_state);
 
 	btrfs_assert_inode_range_clean(BTRFS_I(inode), alloc_start, locked_end);
 
@@ -3218,8 +3219,8 @@ static long btrfs_fallocate(struct file *file, int mode,
 	 */
 	ret = btrfs_fallocate_update_isize(inode, actual_end, mode);
 out_unlock:
-	unlock_extent(&BTRFS_I(inode)->io_tree, alloc_start, locked_end,
-		      &cached_state);
+	btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, alloc_start, locked_end,
+			    &cached_state);
 out:
 	btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
 	extent_changeset_free(data_reserved);
@@ -3565,7 +3566,7 @@ static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 
 	last_extent_end = lockstart;
 
-	lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
+	btrfs_lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0) {
@@ -3711,7 +3712,7 @@ static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 	}
 
 out:
-	unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
+	btrfs_unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 	btrfs_free_path(path);
 
 	if (ret < 0)
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 633dfe4ee93e..30263f15bdca 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -336,7 +336,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 	btrfs_i_size_write(inode, 0);
 	truncate_pagecache(vfs_inode, 0);
 
-	lock_extent(&inode->io_tree, 0, (u64)-1, &cached_state);
+	btrfs_lock_extent(&inode->io_tree, 0, (u64)-1, &cached_state);
 	btrfs_drop_extent_map_range(inode, 0, (u64)-1, false);
 
 	/*
@@ -348,7 +348,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 	inode_sub_bytes(&inode->vfs_inode, control.sub_bytes);
 	btrfs_inode_safe_disk_i_size_write(inode, control.last_size);
 
-	unlock_extent(&inode->io_tree, 0, (u64)-1, &cached_state);
+	btrfs_unlock_extent(&inode->io_tree, 0, (u64)-1, &cached_state);
 	if (ret)
 		goto fail;
 
@@ -1288,8 +1288,8 @@ cleanup_write_cache_enospc(struct inode *inode,
 			   struct extent_state **cached_state)
 {
 	io_ctl_drop_pages(io_ctl);
-	unlock_extent(&BTRFS_I(inode)->io_tree, 0, i_size_read(inode) - 1,
-		      cached_state);
+	btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, 0, i_size_read(inode) - 1,
+			    cached_state);
 }
 
 static int __btrfs_wait_cache_io(struct btrfs_root *root,
@@ -1414,8 +1414,8 @@ static int __btrfs_write_out_cache(struct inode *inode,
 	if (ret)
 		goto out_unlock;
 
-	lock_extent(&BTRFS_I(inode)->io_tree, 0, i_size_read(inode) - 1,
-		    &cached_state);
+	btrfs_lock_extent(&BTRFS_I(inode)->io_tree, 0, i_size_read(inode) - 1,
+			  &cached_state);
 
 	io_ctl_set_generation(io_ctl, trans->transid);
 
@@ -1475,8 +1475,8 @@ static int __btrfs_write_out_cache(struct inode *inode,
 	io_ctl_drop_pages(io_ctl);
 	io_ctl_free(io_ctl);
 
-	unlock_extent(&BTRFS_I(inode)->io_tree, 0, i_size_read(inode) - 1,
-		      &cached_state);
+	btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, 0, i_size_read(inode) - 1,
+			    &cached_state);
 
 	/*
 	 * at this point the pages are under IO and we're happy,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8eef3b135cfa..b3194cdb8ec2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -689,12 +689,12 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode,
 	if (!can_cow_file_range_inline(inode, offset, size, compressed_size))
 		return 1;
 
-	lock_extent(&inode->io_tree, offset, end, &cached);
+	btrfs_lock_extent(&inode->io_tree, offset, end, &cached);
 	ret = __cow_file_range_inline(inode, size, compressed_size,
 				      compress_type, compressed_folio,
 				      update_i_size);
 	if (ret > 0) {
-		unlock_extent(&inode->io_tree, offset, end, &cached);
+		btrfs_unlock_extent(&inode->io_tree, offset, end, &cached);
 		return ret;
 	}
 
@@ -1136,7 +1136,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 		goto done;
 	}
 
-	lock_extent(io_tree, start, end, &cached);
+	btrfs_lock_extent(io_tree, start, end, &cached);
 
 	/* Here we're doing allocation and writeback of the compressed pages */
 	file_extent.disk_bytenr = ins.objectid;
@@ -1385,14 +1385,14 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		 * Locked range will be released either during error clean up or
 		 * after the whole range is finished.
 		 */
-		lock_extent(&inode->io_tree, start, start + cur_alloc_size - 1,
-			    &cached);
+		btrfs_lock_extent(&inode->io_tree, start, start + cur_alloc_size - 1,
+				  &cached);
 
 		em = btrfs_create_io_em(inode, start, &file_extent,
 					BTRFS_ORDERED_REGULAR);
 		if (IS_ERR(em)) {
-			unlock_extent(&inode->io_tree, start,
-				      start + cur_alloc_size - 1, &cached);
+			btrfs_unlock_extent(&inode->io_tree, start,
+					    start + cur_alloc_size - 1, &cached);
 			ret = PTR_ERR(em);
 			goto out_reserve;
 		}
@@ -1401,8 +1401,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
 						     1 << BTRFS_ORDERED_REGULAR);
 		if (IS_ERR(ordered)) {
-			unlock_extent(&inode->io_tree, start,
-				      start + cur_alloc_size - 1, &cached);
+			btrfs_unlock_extent(&inode->io_tree, start,
+					    start + cur_alloc_size - 1, &cached);
 			ret = PTR_ERR(ordered);
 			goto out_drop_extent_cache;
 		}
@@ -1737,7 +1737,7 @@ static int fallback_to_cow(struct btrfs_inode *inode,
 	 * group that contains that extent to RO mode and therefore force COW
 	 * when starting writeback.
 	 */
-	lock_extent(io_tree, start, end, &cached_state);
+	btrfs_lock_extent(io_tree, start, end, &cached_state);
 	count = count_range_bits(io_tree, &range_start, end, range_bytes,
 				 EXTENT_NORESERVE, 0, NULL);
 	if (count > 0 || is_space_ino || is_reloc_ino) {
@@ -1755,7 +1755,7 @@ static int fallback_to_cow(struct btrfs_inode *inode,
 		if (count > 0)
 			clear_extent_bits(io_tree, start, end, EXTENT_NORESERVE);
 	}
-	unlock_extent(io_tree, start, end, &cached_state);
+	btrfs_unlock_extent(io_tree, start, end, &cached_state);
 
 	/*
 	 * Don't try to create inline extents, as a mix of inline extent that
@@ -1964,7 +1964,7 @@ static int nocow_one_range(struct btrfs_inode *inode,
 	u64 end = file_pos + len - 1;
 	int ret = 0;
 
-	lock_extent(&inode->io_tree, file_pos, end, cached);
+	btrfs_lock_extent(&inode->io_tree, file_pos, end, cached);
 
 	if (is_prealloc) {
 		struct extent_map *em;
@@ -1973,8 +1973,7 @@ static int nocow_one_range(struct btrfs_inode *inode,
 					&nocow_args->file_extent,
 					BTRFS_ORDERED_PREALLOC);
 		if (IS_ERR(em)) {
-			unlock_extent(&inode->io_tree, file_pos,
-				      end, cached);
+			btrfs_unlock_extent(&inode->io_tree, file_pos, end, cached);
 			return PTR_ERR(em);
 		}
 		free_extent_map(em);
@@ -1990,8 +1989,7 @@ static int nocow_one_range(struct btrfs_inode *inode,
 			btrfs_drop_extent_map_range(inode, file_pos,
 						    end, false);
 		}
-		unlock_extent(&inode->io_tree, file_pos,
-			      end, cached);
+		btrfs_unlock_extent(&inode->io_tree, file_pos, end, cached);
 		return PTR_ERR(ordered);
 	}
 
@@ -2290,7 +2288,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	if (cur_offset < end) {
 		struct extent_state *cached = NULL;
 
-		lock_extent(&inode->io_tree, cur_offset, end, &cached);
+		btrfs_lock_extent(&inode->io_tree, cur_offset, end, &cached);
 		extent_clear_unlock_delalloc(inode, cur_offset, end,
 					     locked_folio, &cached,
 					     EXTENT_LOCKED | EXTENT_DELALLOC |
@@ -2796,7 +2794,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	if (ret)
 		goto out_page;
 
-	lock_extent(&inode->io_tree, page_start, page_end, &cached_state);
+	btrfs_lock_extent(&inode->io_tree, page_start, page_end, &cached_state);
 
 	/* already ordered? We're done */
 	if (folio_test_ordered(folio))
@@ -2804,8 +2802,8 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 
 	ordered = btrfs_lookup_ordered_range(inode, page_start, PAGE_SIZE);
 	if (ordered) {
-		unlock_extent(&inode->io_tree, page_start, page_end,
-			      &cached_state);
+		btrfs_unlock_extent(&inode->io_tree, page_start, page_end,
+				    &cached_state);
 		folio_unlock(folio);
 		btrfs_start_ordered_extent(ordered);
 		btrfs_put_ordered_extent(ordered);
@@ -2831,7 +2829,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	if (free_delalloc_space)
 		btrfs_delalloc_release_space(inode, data_reserved, page_start,
 					     PAGE_SIZE, true);
-	unlock_extent(&inode->io_tree, page_start, page_end, &cached_state);
+	btrfs_unlock_extent(&inode->io_tree, page_start, page_end, &cached_state);
 out_page:
 	if (ret) {
 		/*
@@ -4863,11 +4861,11 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 
 	folio_wait_writeback(folio);
 
-	lock_extent(io_tree, block_start, block_end, &cached_state);
+	btrfs_lock_extent(io_tree, block_start, block_end, &cached_state);
 
 	ordered = btrfs_lookup_ordered_extent(inode, block_start);
 	if (ordered) {
-		unlock_extent(io_tree, block_start, block_end, &cached_state);
+		btrfs_unlock_extent(io_tree, block_start, block_end, &cached_state);
 		folio_unlock(folio);
 		folio_put(folio);
 		btrfs_start_ordered_extent(ordered);
@@ -4882,7 +4880,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	ret = btrfs_set_extent_delalloc(inode, block_start, block_end, 0,
 					&cached_state);
 	if (ret) {
-		unlock_extent(io_tree, block_start, block_end, &cached_state);
+		btrfs_unlock_extent(io_tree, block_start, block_end, &cached_state);
 		goto out_unlock;
 	}
 
@@ -4901,7 +4899,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 				  block_end + 1 - block_start);
 	btrfs_folio_set_dirty(fs_info, folio, block_start,
 			      block_end + 1 - block_start);
-	unlock_extent(io_tree, block_start, block_end, &cached_state);
+	btrfs_unlock_extent(io_tree, block_start, block_end, &cached_state);
 
 	if (only_release_metadata)
 		set_extent_bit(&inode->io_tree, block_start, block_end,
@@ -5063,7 +5061,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 			break;
 	}
 	free_extent_map(em);
-	unlock_extent(io_tree, hole_start, block_end - 1, &cached_state);
+	btrfs_unlock_extent(io_tree, hole_start, block_end - 1, &cached_state);
 	return ret;
 }
 
@@ -5247,7 +5245,7 @@ static void evict_inode_truncate_pages(struct inode *inode)
 		state_flags = state->state;
 		spin_unlock(&io_tree->lock);
 
-		lock_extent(io_tree, start, end, &cached_state);
+		btrfs_lock_extent(io_tree, start, end, &cached_state);
 
 		/*
 		 * If still has DELALLOC flag, the extent didn't reach disk,
@@ -7361,7 +7359,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	}
 
 	if (!inode_evicting)
-		lock_extent(tree, page_start, page_end, &cached_state);
+		btrfs_lock_extent(tree, page_start, page_end, &cached_state);
 
 	cur = page_start;
 	while (cur < page_end) {
@@ -7569,7 +7567,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 		const u64 lock_start = ALIGN_DOWN(new_size, fs_info->sectorsize);
 
 		control.new_size = new_size;
-		lock_extent(&inode->io_tree, lock_start, (u64)-1, &cached_state);
+		btrfs_lock_extent(&inode->io_tree, lock_start, (u64)-1, &cached_state);
 		/*
 		 * We want to drop from the next block forward in case this new
 		 * size is not block aligned since we will be keeping the last
@@ -7584,7 +7582,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 		inode_sub_bytes(&inode->vfs_inode, control.sub_bytes);
 		btrfs_inode_safe_disk_i_size_write(inode, control.last_size);
 
-		unlock_extent(&inode->io_tree, lock_start, (u64)-1, &cached_state);
+		btrfs_unlock_extent(&inode->io_tree, lock_start, (u64)-1, &cached_state);
 
 		trans->block_rsv = &fs_info->trans_block_rsv;
 		if (ret != -ENOSPC && ret != -EAGAIN)
@@ -9139,7 +9137,7 @@ static ssize_t btrfs_encoded_read_inline(
 
 	read_extent_buffer(leaf, tmp, ptr, count);
 	btrfs_release_path(path);
-	unlock_extent(io_tree, start, lockend, cached_state);
+	btrfs_unlock_extent(io_tree, start, lockend, cached_state);
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 	*unlocked = true;
 
@@ -9287,7 +9285,7 @@ ssize_t btrfs_encoded_read_regular(struct kiocb *iocb, struct iov_iter *iter,
 	if (ret)
 		goto out;
 
-	unlock_extent(io_tree, start, lockend, cached_state);
+	btrfs_unlock_extent(io_tree, start, lockend, cached_state);
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 	*unlocked = true;
 
@@ -9364,7 +9362,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 			goto out_unlock_inode;
 		}
 
-		if (!try_lock_extent(io_tree, start, lockend, cached_state)) {
+		if (!btrfs_try_lock_extent(io_tree, start, lockend, cached_state)) {
 			ret = -EAGAIN;
 			goto out_unlock_inode;
 		}
@@ -9373,7 +9371,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 						     lockend - start + 1);
 		if (ordered) {
 			btrfs_put_ordered_extent(ordered);
-			unlock_extent(io_tree, start, lockend, cached_state);
+			btrfs_unlock_extent(io_tree, start, lockend, cached_state);
 			ret = -EAGAIN;
 			goto out_unlock_inode;
 		}
@@ -9386,13 +9384,13 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 			if (ret)
 				goto out_unlock_inode;
 
-			lock_extent(io_tree, start, lockend, cached_state);
+			btrfs_lock_extent(io_tree, start, lockend, cached_state);
 			ordered = btrfs_lookup_ordered_range(inode, start,
 							     lockend - start + 1);
 			if (!ordered)
 				break;
 			btrfs_put_ordered_extent(ordered);
-			unlock_extent(io_tree, start, lockend, cached_state);
+			btrfs_unlock_extent(io_tree, start, lockend, cached_state);
 			cond_resched();
 		}
 	}
@@ -9467,7 +9465,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 	em = NULL;
 
 	if (*disk_bytenr == EXTENT_MAP_HOLE) {
-		unlock_extent(io_tree, start, lockend, cached_state);
+		btrfs_unlock_extent(io_tree, start, lockend, cached_state);
 		btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 		unlocked = true;
 		ret = iov_iter_zero(count, iter);
@@ -9483,7 +9481,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 out_unlock_extent:
 	/* Leave inode and extent locked if we need to do a read. */
 	if (!unlocked && ret != -EIOCBQUEUED)
-		unlock_extent(io_tree, start, lockend, cached_state);
+		btrfs_unlock_extent(io_tree, start, lockend, cached_state);
 out_unlock_inode:
 	if (!unlocked && ret != -EIOCBQUEUED)
 		btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
@@ -9630,14 +9628,14 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 						    end >> PAGE_SHIFT);
 		if (ret)
 			goto out_folios;
-		lock_extent(io_tree, start, end, &cached_state);
+		btrfs_lock_extent(io_tree, start, end, &cached_state);
 		ordered = btrfs_lookup_ordered_range(inode, start, num_bytes);
 		if (!ordered &&
 		    !filemap_range_has_page(inode->vfs_inode.i_mapping, start, end))
 			break;
 		if (ordered)
 			btrfs_put_ordered_extent(ordered);
-		unlock_extent(io_tree, start, end, &cached_state);
+		btrfs_unlock_extent(io_tree, start, end, &cached_state);
 		cond_resched();
 	}
 
@@ -9702,7 +9700,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	if (start + encoded->len > inode->vfs_inode.i_size)
 		i_size_write(&inode->vfs_inode, start + encoded->len);
 
-	unlock_extent(io_tree, start, end, &cached_state);
+	btrfs_unlock_extent(io_tree, start, end, &cached_state);
 
 	btrfs_delalloc_release_extents(inode, num_bytes);
 
@@ -9727,7 +9725,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	if (!extent_reserved)
 		btrfs_free_reserved_data_space_noquota(fs_info, disk_num_bytes);
 out_unlock:
-	unlock_extent(io_tree, start, end, &cached_state);
+	btrfs_unlock_extent(io_tree, start, end, &cached_state);
 out_folios:
 	for (i = 0; i < nr_folios; i++) {
 		if (folios[i])
@@ -9992,7 +9990,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 
 	isize = ALIGN_DOWN(inode->i_size, fs_info->sectorsize);
 
-	lock_extent(io_tree, 0, isize - 1, &cached_state);
+	btrfs_lock_extent(io_tree, 0, isize - 1, &cached_state);
 	while (prev_extent_end < isize) {
 		struct btrfs_key key;
 		struct extent_buffer *leaf;
@@ -10170,7 +10168,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	if (!IS_ERR_OR_NULL(map))
 		btrfs_free_chunk_map(map);
 
-	unlock_extent(io_tree, 0, isize - 1, &cached_state);
+	btrfs_unlock_extent(io_tree, 0, isize - 1, &cached_state);
 
 	if (ret)
 		btrfs_swap_deactivate(file);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 63aeacc54945..3341344a9fd2 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4510,7 +4510,7 @@ static int btrfs_ioctl_encoded_read(struct file *file, void __user *argp,
 						 args.compression, &unlocked);
 
 		if (!unlocked) {
-			unlock_extent(io_tree, start, lockend, &cached_state);
+			btrfs_unlock_extent(io_tree, start, lockend, &cached_state);
 			btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 		}
 	}
@@ -4699,7 +4699,7 @@ static void btrfs_uring_read_finished(struct io_uring_cmd *cmd, unsigned int iss
 	ret = priv->count;
 
 out:
-	unlock_extent(io_tree, priv->start, priv->lockend, &priv->cached_state);
+	btrfs_unlock_extent(io_tree, priv->start, priv->lockend, &priv->cached_state);
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 
 	io_uring_cmd_done(cmd, ret, 0, issue_flags);
@@ -4788,7 +4788,7 @@ static int btrfs_uring_read_extent(struct kiocb *iocb, struct iov_iter *iter,
 	return -EIOCBQUEUED;
 
 out_fail:
-	unlock_extent(io_tree, start, lockend, &cached_state);
+	btrfs_unlock_extent(io_tree, start, lockend, &cached_state);
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 	kfree(priv);
 	return ret;
@@ -4913,7 +4913,7 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 			 (const char *)&data->args + copy_end_kernel,
 			 sizeof(data->args) - copy_end_kernel)) {
 		if (ret == -EIOCBQUEUED) {
-			unlock_extent(io_tree, start, lockend, &cached_state);
+			btrfs_unlock_extent(io_tree, start, lockend, &cached_state);
 			btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 		}
 		ret = -EFAULT;
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index fd33217e4b27..c889d0a365c9 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1173,7 +1173,7 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 		cachedp = cached_state;
 
 	while (1) {
-		lock_extent(&inode->io_tree, start, end, cachedp);
+		btrfs_lock_extent(&inode->io_tree, start, end, cachedp);
 		ordered = btrfs_lookup_ordered_range(inode, start,
 						     end - start + 1);
 		if (!ordered) {
@@ -1186,7 +1186,7 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 				refcount_dec(&cache->refs);
 			break;
 		}
-		unlock_extent(&inode->io_tree, start, end, cachedp);
+		btrfs_unlock_extent(&inode->io_tree, start, end, cachedp);
 		btrfs_start_ordered_extent(ordered);
 		btrfs_put_ordered_extent(ordered);
 	}
@@ -1204,7 +1204,7 @@ bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end,
 {
 	struct btrfs_ordered_extent *ordered;
 
-	if (!try_lock_extent(&inode->io_tree, start, end, cached_state))
+	if (!btrfs_try_lock_extent(&inode->io_tree, start, end, cached_state))
 		return false;
 
 	ordered = btrfs_lookup_ordered_range(inode, start, end - start + 1);
@@ -1212,7 +1212,7 @@ bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end,
 		return true;
 
 	btrfs_put_ordered_extent(ordered);
-	unlock_extent(&inode->io_tree, start, end, cached_state);
+	btrfs_unlock_extent(&inode->io_tree, start, end, cached_state);
 
 	return false;
 }
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 09e40a2fdcf0..e6c0a10c4c67 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -645,10 +645,10 @@ static int btrfs_extent_same_range(struct btrfs_inode *src, u64 loff, u64 len,
 	 * because we have already locked the inode's i_mmap_lock in exclusive
 	 * mode.
 	 */
-	lock_extent(&dst->io_tree, dst_loff, end, &cached_state);
+	btrfs_lock_extent(&dst->io_tree, dst_loff, end, &cached_state);
 	ret = btrfs_clone(&src->vfs_inode, &dst->vfs_inode, loff, len,
 			  ALIGN(len, bs), dst_loff, 1);
-	unlock_extent(&dst->io_tree, dst_loff, end, &cached_state);
+	btrfs_unlock_extent(&dst->io_tree, dst_loff, end, &cached_state);
 
 	btrfs_btree_balance_dirty(fs_info);
 
@@ -748,9 +748,9 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 	 * mode.
 	 */
 	end = destoff + len - 1;
-	lock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_state);
+	btrfs_lock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_state);
 	ret = btrfs_clone(src, inode, off, olen, len, destoff, 0);
-	unlock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_state);
+	btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_state);
 
 	/*
 	 * We may have copied an inline extent into a page of the destination
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index b7f7563d3c14..4ac2e63cbe55 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -910,16 +910,16 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 				/* Take mmap lock to serialize with reflinks. */
 				if (!down_read_trylock(&inode->i_mmap_lock))
 					continue;
-				ret = try_lock_extent(&inode->io_tree, key.offset,
-						      end, &cached_state);
+				ret = btrfs_try_lock_extent(&inode->io_tree, key.offset,
+							    end, &cached_state);
 				if (!ret) {
 					up_read(&inode->i_mmap_lock);
 					continue;
 				}
 
 				btrfs_drop_extent_map_range(inode, key.offset, end, true);
-				unlock_extent(&inode->io_tree, key.offset, end,
-					      &cached_state);
+				btrfs_unlock_extent(&inode->io_tree, key.offset, end,
+						    &cached_state);
 				up_read(&inode->i_mmap_lock);
 			}
 		}
@@ -1378,9 +1378,9 @@ static int invalidate_extent_cache(struct btrfs_root *root,
 		}
 
 		/* the lock_extent waits for read_folio to complete */
-		lock_extent(&inode->io_tree, start, end, &cached_state);
+		btrfs_lock_extent(&inode->io_tree, start, end, &cached_state);
 		btrfs_drop_extent_map_range(inode, start, end, true);
-		unlock_extent(&inode->io_tree, start, end, &cached_state);
+		btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state);
 	}
 	return 0;
 }
@@ -2735,13 +2735,13 @@ static noinline_for_stack int prealloc_file_extent_cluster(struct reloc_control
 		else
 			end = cluster->end - offset;
 
-		lock_extent(&inode->io_tree, start, end, &cached_state);
+		btrfs_lock_extent(&inode->io_tree, start, end, &cached_state);
 		num_bytes = end + 1 - start;
 		ret = btrfs_prealloc_file_range(&inode->vfs_inode, 0, start,
 						num_bytes, num_bytes,
 						end + 1, &alloc_hint);
 		cur_offset = end + 1;
-		unlock_extent(&inode->io_tree, start, end, &cached_state);
+		btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state);
 		if (ret)
 			break;
 	}
@@ -2774,9 +2774,9 @@ static noinline_for_stack int setup_relocation_extent_mapping(struct reloc_contr
 	em->ram_bytes = em->len;
 	em->flags |= EXTENT_FLAG_PINNED;
 
-	lock_extent(&inode->io_tree, start, end, &cached_state);
+	btrfs_lock_extent(&inode->io_tree, start, end, &cached_state);
 	ret = btrfs_replace_extent_map_range(inode, em, false);
-	unlock_extent(&inode->io_tree, start, end, &cached_state);
+	btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state);
 	free_extent_map(em);
 
 	return ret;
@@ -2899,8 +2899,8 @@ static int relocate_one_folio(struct reloc_control *rc,
 			goto release_folio;
 
 		/* Mark the range delalloc and dirty for later writeback */
-		lock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end,
-			    &cached_state);
+		btrfs_lock_extent(&BTRFS_I(inode)->io_tree, clamped_start,
+				  clamped_end, &cached_state);
 		ret = btrfs_set_extent_delalloc(BTRFS_I(inode), clamped_start,
 						clamped_end, 0, &cached_state);
 		if (ret) {
@@ -2933,8 +2933,8 @@ static int relocate_one_folio(struct reloc_control *rc,
 				       boundary_start, boundary_end,
 				       EXTENT_BOUNDARY, NULL);
 		}
-		unlock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end,
-			      &cached_state);
+		btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end,
+				    &cached_state);
 		btrfs_delalloc_release_extents(BTRFS_I(inode), clamped_len);
 		cur += clamped_len;
 
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index eaacd56bf5f3..2021090ccd6a 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -189,7 +189,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 			sectorsize - 1, start, end);
 		goto out_bits;
 	}
-	unlock_extent(tmp, start, end, NULL);
+	btrfs_unlock_extent(tmp, start, end, NULL);
 	unlock_page(locked_page);
 	put_page(locked_page);
 
@@ -225,7 +225,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 		test_err("there were unlocked pages in the range");
 		goto out_bits;
 	}
-	unlock_extent(tmp, start, end, NULL);
+	btrfs_unlock_extent(tmp, start, end, NULL);
 	/* locked_page was unlocked above */
 	put_page(locked_page);
 
@@ -280,7 +280,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 		test_err("pages in range were not all locked");
 		goto out_bits;
 	}
-	unlock_extent(tmp, start, end, NULL);
+	btrfs_unlock_extent(tmp, start, end, NULL);
 
 	/*
 	 * Now to test where we run into a page that is no longer dirty in the
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index f5af11565b87..31087b69d68f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4300,8 +4300,8 @@ static int log_csums(struct btrfs_trans_handle *trans,
 	 * file which happens to refer to the same extent as well. Such races
 	 * can leave checksum items in the log with overlapping ranges.
 	 */
-	ret = lock_extent(&log_root->log_csum_range, sums->logical, lock_end,
-			  &cached_state);
+	ret = btrfs_lock_extent(&log_root->log_csum_range, sums->logical, lock_end,
+				&cached_state);
 	if (ret)
 		return ret;
 	/*
@@ -4317,8 +4317,8 @@ static int log_csums(struct btrfs_trans_handle *trans,
 	if (!ret)
 		ret = btrfs_csum_file_blocks(trans, log_root, sums);
 
-	unlock_extent(&log_root->log_csum_range, sums->logical, lock_end,
-		      &cached_state);
+	btrfs_unlock_extent(&log_root->log_csum_range, sums->logical, lock_end,
+			    &cached_state);
 
 	return ret;
 }
-- 
2.45.2


