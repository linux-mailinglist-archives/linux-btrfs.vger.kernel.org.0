Return-Path: <linux-btrfs+bounces-12850-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00393A7E8B8
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 19:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E33444024D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 17:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0959E253F03;
	Mon,  7 Apr 2025 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8MA/GwP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFB8253B71
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047399; cv=none; b=XYd96rVAd6M06r4DmI/8GAawz/wK23dS40EAnexjOO52i0W0oBaIVwqoly2Q+jg4nJXpWPFH7cy7s8ilaTxEDJF7fyMvKpO2JQgQyfu4W7OBxO1OrOooKTEO6Mzlqt/Mt5oWY1pEczQjBMc699+r3hurOFRx+Xm9rdrXkVZFOV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047399; c=relaxed/simple;
	bh=NU6+RVsRnEEd8/T+N2BxYouKBPYZG93j6NxmPgjHNkw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hfKbmgIPqasRPQbEeJwOQKuaL7Fvyi4Ub8dt5y8efEcj35sFqu5Hv4u+doreiVT063lGEcS6J8HmyX42yiLbGpQv1/FrFwb81K3R6ehXRfilNo+wFtKHZanehffeCjgvJ49lxDLmt+tXouz5+HvkK8REHCJblWBXJstfgon533g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8MA/GwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B191C4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047399;
	bh=NU6+RVsRnEEd8/T+N2BxYouKBPYZG93j6NxmPgjHNkw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=X8MA/GwP5rJkI3ACMarpI9wzmIZOwrrEF7FQ4BLFBetVMrWDh/T4U0aWhJQXq75GY
	 3ghTD1/YUjyyH8VXMlOog/2ZK9yeMiA3o35hpYFqlgrfsSNH8k2Po4WEewv3h7bhQ3
	 6ToI1fHmLDyAoejeVGMXav2X61dTok2Flo9SAZ2l+LBuD5EqbzG5OwDhgef6TCFilt
	 EUVZF0TQu6UR5fHJgcp2BVbkkKcMiPJiZVuhANY/GocjI/AvtlC+Xh4hvziUInYz6/
	 WflA3L7go2BxzQpJnaMGjyH96BenK5JtChrPwg7b55+0DzUdXU1SRgwdcBV4TGnFvQ
	 r3DK4aRU5zNlQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 12/16] btrfs: rename the functions to count, test and get bit ranges in io trees
Date: Mon,  7 Apr 2025 18:36:19 +0100
Message-Id: <c6f1a1df5d4aa215fd06195fa80e987c13ad7044.1744046765.git.fdmanana@suse.com>
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
collisions with functions from elsewhere in the kernel.

So add a 'btrfs_' prefix to their names to make it clear they are from
btrfs.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/defrag.c         |  4 ++--
 fs/btrfs/extent-io-tree.c | 18 +++++++++---------
 fs/btrfs/extent-io-tree.h | 18 +++++++++---------
 fs/btrfs/extent_io.c      | 10 +++++-----
 fs/btrfs/file.c           |  8 ++++----
 fs/btrfs/inode.c          | 13 +++++++------
 fs/btrfs/relocation.c     |  4 ++--
 7 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 587f2504a570..d56815a685be 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -1024,8 +1024,8 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		 *    very likely resulting in a larger extent after writeback is
 		 *    triggered (except in a case of free space fragmentation).
 		 */
-		if (test_range_bit_exists(&inode->io_tree, cur, cur + range_len - 1,
-					  EXTENT_DELALLOC))
+		if (btrfs_test_range_bit_exists(&inode->io_tree, cur, cur + range_len - 1,
+						EXTENT_DELALLOC))
 			goto next;
 
 		/*
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 4b9f18a12154..835a9463f687 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1612,10 +1612,10 @@ void btrfs_find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
  * all given bits set. If the returned number of bytes is greater than zero
  * then @start is updated with the offset of the first byte with the bits set.
  */
-u64 count_range_bits(struct extent_io_tree *tree,
-		     u64 *start, u64 search_end, u64 max_bytes,
-		     u32 bits, int contig,
-		     struct extent_state **cached_state)
+u64 btrfs_count_range_bits(struct extent_io_tree *tree,
+			   u64 *start, u64 search_end, u64 max_bytes,
+			   u32 bits, int contig,
+			   struct extent_state **cached_state)
 {
 	struct extent_state *state = NULL;
 	struct extent_state *cached;
@@ -1700,7 +1700,7 @@ u64 count_range_bits(struct extent_io_tree *tree,
 /*
  * Check if the single @bit exists in the given range.
  */
-bool test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64 end, u32 bit)
+bool btrfs_test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64 end, u32 bit)
 {
 	struct extent_state *state;
 	bool bitset = false;
@@ -1726,8 +1726,8 @@ bool test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64 end, u32
 	return bitset;
 }
 
-void get_range_bits(struct extent_io_tree *tree, u64 start, u64 end, u32 *bits,
-		    struct extent_state **cached_state)
+void btrfs_get_range_bits(struct extent_io_tree *tree, u64 start, u64 end, u32 *bits,
+			  struct extent_state **cached_state)
 {
 	struct extent_state *state;
 
@@ -1763,8 +1763,8 @@ void get_range_bits(struct extent_io_tree *tree, u64 start, u64 end, u32 *bits,
 /*
  * Check if the whole range [@start,@end) contains the single @bit set.
  */
-bool test_range_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bit,
-		    struct extent_state *cached)
+bool btrfs_test_range_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bit,
+			  struct extent_state *cached)
 {
 	struct extent_state *state;
 	bool bitset = true;
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 85eeee4ac613..2f5e27d96acd 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -160,17 +160,17 @@ static inline bool btrfs_try_lock_extent(struct extent_io_tree *tree, u64 start,
 int __init extent_state_init_cachep(void);
 void __cold extent_state_free_cachep(void);
 
-u64 count_range_bits(struct extent_io_tree *tree,
-		     u64 *start, u64 search_end,
-		     u64 max_bytes, u32 bits, int contig,
-		     struct extent_state **cached_state);
+u64 btrfs_count_range_bits(struct extent_io_tree *tree,
+			   u64 *start, u64 search_end,
+			   u64 max_bytes, u32 bits, int contig,
+			   struct extent_state **cached_state);
 
 void free_extent_state(struct extent_state *state);
-bool test_range_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bit,
-		    struct extent_state *cached_state);
-bool test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64 end, u32 bit);
-void get_range_bits(struct extent_io_tree *tree, u64 start, u64 end, u32 *bits,
-		    struct extent_state **cached_state);
+bool btrfs_test_range_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bit,
+			  struct extent_state *cached_state);
+bool btrfs_test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64 end, u32 bit);
+void btrfs_get_range_bits(struct extent_io_tree *tree, u64 start, u64 end, u32 *bits,
+			  struct extent_state **cached_state);
 int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			     u32 bits, struct extent_changeset *changeset);
 int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64 end,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 679f07390bb8..617e08946dd5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -372,8 +372,8 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	btrfs_lock_extent(tree, delalloc_start, delalloc_end, &cached_state);
 
 	/* then test to make sure it is all still delalloc */
-	ret = test_range_bit(tree, delalloc_start, delalloc_end,
-			     EXTENT_DELALLOC, cached_state);
+	ret = btrfs_test_range_bit(tree, delalloc_start, delalloc_end,
+				   EXTENT_DELALLOC, cached_state);
 
 	btrfs_unlock_extent(tree, delalloc_start, delalloc_end, &cached_state);
 	if (!ret) {
@@ -2620,7 +2620,7 @@ static bool try_release_extent_state(struct extent_io_tree *tree,
 	bool ret = false;
 	int ret2;
 
-	get_range_bits(tree, start, end, &range_bits, &cached_state);
+	btrfs_get_range_bits(tree, start, end, &range_bits, &cached_state);
 
 	/*
 	 * We can release the folio if it's locked only for ordered extent
@@ -2680,8 +2680,8 @@ bool try_release_extent_mapping(struct folio *folio, gfp_t mask)
 			free_extent_map(em);
 			break;
 		}
-		if (test_range_bit_exists(io_tree, em->start,
-					  extent_map_end(em) - 1, EXTENT_LOCKED))
+		if (btrfs_test_range_bit_exists(io_tree, em->start,
+						extent_map_end(em) - 1, EXTENT_LOCKED))
 			goto next;
 		/*
 		 * If it's not in the list of modified extents, used by a fast
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 630343d8b0e7..ec644840fa49 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3254,10 +3254,10 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
 		if (inode->delalloc_bytes > 0) {
 			spin_unlock(&inode->lock);
 			*delalloc_start_ret = start;
-			delalloc_len = count_range_bits(&inode->io_tree,
-							delalloc_start_ret, end,
-							len, EXTENT_DELALLOC, 1,
-							cached_state);
+			delalloc_len = btrfs_count_range_bits(&inode->io_tree,
+							      delalloc_start_ret, end,
+							      len, EXTENT_DELALLOC, 1,
+							      cached_state);
 		} else {
 			spin_unlock(&inode->lock);
 		}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bf1f4821b8db..9c32465dcf9b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1738,8 +1738,8 @@ static int fallback_to_cow(struct btrfs_inode *inode,
 	 * when starting writeback.
 	 */
 	btrfs_lock_extent(io_tree, start, end, &cached_state);
-	count = count_range_bits(io_tree, &range_start, end, range_bytes,
-				 EXTENT_NORESERVE, 0, NULL);
+	count = btrfs_count_range_bits(io_tree, &range_start, end, range_bytes,
+				       EXTENT_NORESERVE, 0, NULL);
 	if (count > 0 || is_space_ino || is_reloc_ino) {
 		u64 bytes = count;
 		struct btrfs_fs_info *fs_info = inode->root->fs_info;
@@ -2310,7 +2310,7 @@ static bool should_nocow(struct btrfs_inode *inode, u64 start, u64 end)
 {
 	if (inode->flags & (BTRFS_INODE_NODATACOW | BTRFS_INODE_PREALLOC)) {
 		if (inode->defrag_bytes &&
-		    test_range_bit_exists(&inode->io_tree, start, end, EXTENT_DEFRAG))
+		    btrfs_test_range_bit_exists(&inode->io_tree, start, end, EXTENT_DEFRAG))
 			return false;
 		return true;
 	}
@@ -3378,8 +3378,8 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 		return true;
 
 	if (btrfs_is_data_reloc_root(inode->root) &&
-	    test_range_bit(&inode->io_tree, file_offset, end, EXTENT_NODATASUM,
-			   NULL)) {
+	    btrfs_test_range_bit(&inode->io_tree, file_offset, end, EXTENT_NODATASUM,
+				 NULL)) {
 		/* Skip the range without csum for data reloc inode */
 		btrfs_clear_extent_bits(&inode->io_tree, file_offset, end,
 					EXTENT_NODATASUM);
@@ -7154,7 +7154,8 @@ noinline int can_nocow_extent(struct btrfs_inode *inode, u64 offset, u64 *len,
 
 		range_end = round_up(offset + nocow_args.file_extent.num_bytes,
 				     root->fs_info->sectorsize) - 1;
-		ret = test_range_bit_exists(io_tree, offset, range_end, EXTENT_DELALLOC);
+		ret = btrfs_test_range_bit_exists(io_tree, offset, range_end,
+						  EXTENT_DELALLOC);
 		if (ret)
 			return -EAGAIN;
 	}
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 0a5a48aa58cc..4bfc5403cf17 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2409,8 +2409,8 @@ static int tree_block_processed(u64 bytenr, struct reloc_control *rc)
 {
 	u32 blocksize = rc->extent_root->fs_info->nodesize;
 
-	if (test_range_bit(&rc->processed_blocks, bytenr,
-			   bytenr + blocksize - 1, EXTENT_DIRTY, NULL))
+	if (btrfs_test_range_bit(&rc->processed_blocks, bytenr,
+				 bytenr + blocksize - 1, EXTENT_DIRTY, NULL))
 		return 1;
 	return 0;
 }
-- 
2.45.2


