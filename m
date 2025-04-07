Return-Path: <linux-btrfs+bounces-12844-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF91A7E8BC
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 19:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59914189AA27
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 17:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6AB23C8C8;
	Mon,  7 Apr 2025 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvV91ZFf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6945823A9B6
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047393; cv=none; b=NlQZOecKs1CQO7M7yMrW+bDCqme2UUMmDbwlfolM7YK4QqqhQ6NuAhmqw98bfRSGJCTZXVv+uuha5039BBGGnKjp9mOZ5wDjeWet2ILRjyhkM4P8UZGma98KegI9NOk4GyaR56AbaCXPOnq6/wJnqOIQcQebtF4egvlIO70SxJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047393; c=relaxed/simple;
	bh=x7pxRIVTxsA9Eo0FGUNx0Q9BvpKhZEa4fjPNl+GDJc4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cf9yq0BN6SZUgZo7O+T17MAPSXPQF/pscD1K5RyYoD2D6e616inXRObOa/E0cVWIKDInkXIsDa0UwMxFvRw3+7kq6xXou97GSf/jDe3F6u7f7qUeZsQoPVkwlsg81cp3m+WNQ92euQD9If+yhTVB/Mj3oDrohE6w2RGsx7MEe9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvV91ZFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58082C4CEDD
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047392;
	bh=x7pxRIVTxsA9Eo0FGUNx0Q9BvpKhZEa4fjPNl+GDJc4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mvV91ZFfGhSlMMAT6a96w5cAR+rTAvAIW4jG6EvCfBspjfdijctkDtqLNlFPWRavC
	 YyaeEHE75R2TH7kTMLThdtKAVwpRjekjaB2M3SNQjfUS5kRlGTL5fJIxFJjxaKMGeu
	 LY3FrfEhc/tvXs8ONRmyqk37DY8e5TQ4oeugaOPuaN42Y7p5KSMniSTk6V7MBp/cl3
	 fjbotpEezhUMn3Mf1SG72Mplxcsadcp9Tij1V75KOUYxgMjtDwiz4lSP9wyOPv/uth
	 jZCYmXGJ6SeC4eek+C05J1sQ/X4AcEl+37gtTp269eEpEzMt9vJzJnG59eQoi3sHOz
	 vE1jXT+ya42zw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 06/16] btrfs: rename the functions to clear bits for an extent range
Date: Mon,  7 Apr 2025 18:36:13 +0100
Message-Id: <672c24c2ea0d6c9711baf053fad401d82a094fa4.1744046765.git.fdmanana@suse.com>
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
collisions with functions from elsewhere in the kernel. One of them has a
double underscore prefix which is also discouraged.

So remove double underscore prefix where applicable and add a 'btrfs_'
prefix to their name to make it clear they are from btrfs.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c           | 12 ++++-----
 fs/btrfs/defrag.c                |  6 ++---
 fs/btrfs/direct-io.c             |  8 +++---
 fs/btrfs/disk-io.c               |  4 +--
 fs/btrfs/extent-io-tree.c        | 15 +++++------
 fs/btrfs/extent-io-tree.h        | 36 +++++++++++++-------------
 fs/btrfs/extent-tree.c           |  2 +-
 fs/btrfs/extent_io.c             |  4 +--
 fs/btrfs/file-item.c             |  4 +--
 fs/btrfs/file.c                  | 12 ++++-----
 fs/btrfs/free-space-cache.c      | 14 +++++------
 fs/btrfs/inode.c                 | 43 ++++++++++++++++----------------
 fs/btrfs/qgroup.c                |  4 +--
 fs/btrfs/reflink.c               |  4 +--
 fs/btrfs/relocation.c            | 10 ++++----
 fs/btrfs/tests/extent-io-tests.c |  4 +--
 fs/btrfs/tests/inode-tests.c     | 24 +++++++++---------
 fs/btrfs/transaction.c           |  4 +--
 fs/btrfs/volumes.c               | 10 ++++----
 19 files changed, 112 insertions(+), 108 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 3eba00da9fc7..a5c587cf42a7 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -832,8 +832,8 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 
 static inline void btrfs_free_excluded_extents(const struct btrfs_block_group *bg)
 {
-	clear_extent_bits(&bg->fs_info->excluded_extents, bg->start,
-			  bg->start + bg->length - 1, EXTENT_DIRTY);
+	btrfs_clear_extent_bits(&bg->fs_info->excluded_extents, bg->start,
+				bg->start + bg->length - 1, EXTENT_DIRTY);
 }
 
 static noinline void caching_thread(struct btrfs_work *work)
@@ -1437,14 +1437,14 @@ static bool clean_pinned_extents(struct btrfs_trans_handle *trans,
 	 */
 	mutex_lock(&fs_info->unused_bg_unpin_mutex);
 	if (prev_trans) {
-		ret = clear_extent_bits(&prev_trans->pinned_extents, start, end,
-					EXTENT_DIRTY);
+		ret = btrfs_clear_extent_bits(&prev_trans->pinned_extents, start, end,
+					      EXTENT_DIRTY);
 		if (ret)
 			goto out;
 	}
 
-	ret = clear_extent_bits(&trans->transaction->pinned_extents, start, end,
-				EXTENT_DIRTY);
+	ret = btrfs_clear_extent_bits(&trans->transaction->pinned_extents, start, end,
+				      EXTENT_DIRTY);
 out:
 	mutex_unlock(&fs_info->unused_bg_unpin_mutex);
 	if (prev_trans)
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 3e2e462365d6..ee00250776bb 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -1170,9 +1170,9 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, start, len);
 	if (ret < 0)
 		return ret;
-	clear_extent_bit(&inode->io_tree, start, start + len - 1,
-			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
-			 EXTENT_DEFRAG, cached_state);
+	btrfs_clear_extent_bit(&inode->io_tree, start, start + len - 1,
+			       EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
+			       EXTENT_DEFRAG, cached_state);
 	set_extent_bit(&inode->io_tree, start, start + len - 1,
 		       EXTENT_DELALLOC | EXTENT_DEFRAG, cached_state);
 
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 4a0abf0751b4..20434d14d68a 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -575,8 +575,8 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	if (write)
 		unlock_bits |= EXTENT_DIO_LOCKED;
 
-	clear_extent_bit(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-			 unlock_bits, &cached_state);
+	btrfs_clear_extent_bit(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+			       unlock_bits, &cached_state);
 
 	/* We didn't use everything, unlock the dio extent for the remainder. */
 	if (!write && (start + len) < lockend)
@@ -591,8 +591,8 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	 * to update this, be explicit that we expect EXTENT_LOCKED and
 	 * EXTENT_DIO_LOCKED to be set here, and so that's what we're clearing.
 	 */
-	clear_extent_bit(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-			 EXTENT_LOCKED | EXTENT_DIO_LOCKED, &cached_state);
+	btrfs_clear_extent_bit(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+			       EXTENT_LOCKED | EXTENT_DIO_LOCKED, &cached_state);
 err:
 	if (dio_data->data_space_reserved) {
 		btrfs_free_reserved_data_space(BTRFS_I(inode),
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index cff8347d62b0..139a3a09ca57 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4693,7 +4693,7 @@ static void btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
 
 	while (find_first_extent_bit(dirty_pages, start, &start, &end,
 				     mark, NULL)) {
-		clear_extent_bits(dirty_pages, start, end, mark);
+		btrfs_clear_extent_bits(dirty_pages, start, end, mark);
 		while (start <= end) {
 			eb = find_extent_buffer(fs_info, start);
 			start += fs_info->nodesize;
@@ -4732,7 +4732,7 @@ static void btrfs_destroy_pinned_extent(struct btrfs_fs_info *fs_info,
 			break;
 		}
 
-		clear_extent_dirty(unpin, start, end, &cached_state);
+		btrfs_clear_extent_dirty(unpin, start, end, &cached_state);
 		free_extent_state(cached_state);
 		btrfs_error_unpin_extent_range(fs_info, start, end);
 		mutex_unlock(&fs_info->unused_bg_unpin_mutex);
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index dad092a1f81c..50b4d0b29468 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -597,9 +597,9 @@ static void set_gfp_mask_from_bits(u32 *bits, gfp_t *mask)
  *
  * This takes the tree lock, and returns 0 on success and < 0 on error.
  */
-int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		       u32 bits, struct extent_state **cached_state,
-		       struct extent_changeset *changeset)
+int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64 end,
+				     u32 bits, struct extent_state **cached_state,
+				     struct extent_changeset *changeset)
 {
 	struct extent_state *state;
 	struct extent_state *cached;
@@ -1828,7 +1828,7 @@ int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	 */
 	ASSERT(!(bits & EXTENT_LOCK_BITS));
 
-	return __clear_extent_bit(tree, start, end, bits, NULL, changeset);
+	return btrfs_clear_extent_bit_changeset(tree, start, end, bits, NULL, changeset);
 }
 
 bool btrfs_try_lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
@@ -1841,7 +1841,8 @@ bool btrfs_try_lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			       NULL, cached, NULL);
 	if (err == -EEXIST) {
 		if (failed_start > start)
-			clear_extent_bit(tree, start, failed_start - 1, bits, cached);
+			btrfs_clear_extent_bit(tree, start, failed_start - 1,
+					       bits, cached);
 		return 0;
 	}
 	return 1;
@@ -1862,8 +1863,8 @@ int btrfs_lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end, u32
 			       &failed_state, cached_state, NULL);
 	while (err == -EEXIST) {
 		if (failed_start != start)
-			clear_extent_bit(tree, start, failed_start - 1,
-					 bits, cached_state);
+			btrfs_clear_extent_bit(tree, start, failed_start - 1,
+					       bits, cached_state);
 
 		wait_extent_bit(tree, failed_start, end, bits, &failed_state);
 		err = __set_extent_bit(tree, start, end, bits,
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 518caf666bb0..6c2148ed0bb6 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -173,27 +173,28 @@ void get_range_bits(struct extent_io_tree *tree, u64 start, u64 end, u32 *bits,
 		    struct extent_state **cached_state);
 int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			     u32 bits, struct extent_changeset *changeset);
-int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		       u32 bits, struct extent_state **cached,
-		       struct extent_changeset *changeset);
+int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64 end,
+				     u32 bits, struct extent_state **cached,
+				     struct extent_changeset *changeset);
 
-static inline int clear_extent_bit(struct extent_io_tree *tree, u64 start,
-				   u64 end, u32 bits,
-				   struct extent_state **cached)
+static inline int btrfs_clear_extent_bit(struct extent_io_tree *tree, u64 start,
+					 u64 end, u32 bits,
+					 struct extent_state **cached)
 {
-	return __clear_extent_bit(tree, start, end, bits, cached, NULL);
+	return btrfs_clear_extent_bit_changeset(tree, start, end, bits, cached, NULL);
 }
 
 static inline int btrfs_unlock_extent(struct extent_io_tree *tree, u64 start, u64 end,
 				      struct extent_state **cached)
 {
-	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, cached, NULL);
+	return btrfs_clear_extent_bit_changeset(tree, start, end, EXTENT_LOCKED,
+						cached, NULL);
 }
 
-static inline int clear_extent_bits(struct extent_io_tree *tree, u64 start,
-				    u64 end, u32 bits)
+static inline int btrfs_clear_extent_bits(struct extent_io_tree *tree, u64 start,
+					  u64 end, u32 bits)
 {
-	return clear_extent_bit(tree, start, end, bits, NULL);
+	return btrfs_clear_extent_bit(tree, start, end, bits, NULL);
 }
 
 int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
@@ -201,12 +202,12 @@ int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		   u32 bits, struct extent_state **cached_state);
 
-static inline int clear_extent_dirty(struct extent_io_tree *tree, u64 start,
-				     u64 end, struct extent_state **cached)
+static inline int btrfs_clear_extent_dirty(struct extent_io_tree *tree, u64 start,
+					   u64 end, struct extent_state **cached)
 {
-	return clear_extent_bit(tree, start, end,
-				EXTENT_DIRTY | EXTENT_DELALLOC |
-				EXTENT_DO_ACCOUNTING, cached);
+	return btrfs_clear_extent_bit(tree, start, end,
+				      EXTENT_DIRTY | EXTENT_DELALLOC |
+				      EXTENT_DO_ACCOUNTING, cached);
 }
 
 int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
@@ -238,7 +239,8 @@ static inline bool btrfs_try_lock_dio_extent(struct extent_io_tree *tree, u64 st
 static inline int btrfs_unlock_dio_extent(struct extent_io_tree *tree, u64 start,
 					  u64 end, struct extent_state **cached)
 {
-	return __clear_extent_bit(tree, start, end, EXTENT_DIO_LOCKED, cached, NULL);
+	return btrfs_clear_extent_bit_changeset(tree, start, end, EXTENT_DIO_LOCKED,
+						cached, NULL);
 }
 
 #endif /* BTRFS_EXTENT_IO_TREE_H */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 47db37b7236d..841f538a940e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2839,7 +2839,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 			ret = btrfs_discard_extent(fs_info, start,
 						   end + 1 - start, NULL);
 
-		clear_extent_dirty(unpin, start, end, &cached_state);
+		btrfs_clear_extent_dirty(unpin, start, end, &cached_state);
 		ret = unpin_extent_range(fs_info, start, end, true);
 		BUG_ON(ret);
 		mutex_unlock(&fs_info->unused_bg_unpin_mutex);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 82164c1bcd5c..679f07390bb8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -393,7 +393,7 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct extent_state **cached,
 				  u32 clear_bits, unsigned long page_ops)
 {
-	clear_extent_bit(&inode->io_tree, start, end, clear_bits, cached);
+	btrfs_clear_extent_bit(&inode->io_tree, start, end, clear_bits, cached);
 
 	__process_folios_contig(inode->vfs_inode.i_mapping, locked_folio, start,
 				end, page_ops);
@@ -2638,7 +2638,7 @@ static bool try_release_extent_state(struct extent_io_tree *tree,
 	 * nodatasum, delalloc new and finishing ordered bits. The delalloc new
 	 * bit will be cleared by ordered extent completion.
 	 */
-	ret2 = clear_extent_bit(tree, start, end, clear_bits, &cached_state);
+	ret2 = btrfs_clear_extent_bit(tree, start, end, clear_bits, &cached_state);
 	/*
 	 * If clear_extent_bit failed for enomem reasons, we can't allow the
 	 * release to continue.
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index c191be6bcefb..aa840ba94634 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -121,8 +121,8 @@ int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
 	ASSERT(IS_ALIGNED(start + len, inode->root->fs_info->sectorsize) ||
 	       len == (u64)-1);
 
-	return clear_extent_bit(inode->file_extent_tree, start,
-				start + len - 1, EXTENT_DIRTY, NULL);
+	return btrfs_clear_extent_bit(inode->file_extent_tree, start,
+				      start + len - 1, EXTENT_DIRTY, NULL);
 }
 
 static size_t bytes_to_csum_size(const struct btrfs_fs_info *fs_info, u32 bytes)
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index bec7d6ff333d..630343d8b0e7 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -98,9 +98,9 @@ int btrfs_dirty_folio(struct btrfs_inode *inode, struct folio *folio, loff_t pos
 	 * The pages may have already been dirty, clear out old accounting so
 	 * we can set things up properly
 	 */
-	clear_extent_bit(&inode->io_tree, start_pos, end_of_last_block,
-			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
-			 cached);
+	btrfs_clear_extent_bit(&inode->io_tree, start_pos, end_of_last_block,
+			       EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
+			       cached);
 
 	ret = btrfs_set_extent_delalloc(inode, start_pos, end_of_last_block,
 					extra_bits, cached);
@@ -1937,9 +1937,9 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	 * clear any delalloc bits within this page range since we have to
 	 * reserve data&meta space before lock_page() (see above comments).
 	 */
-	clear_extent_bit(&BTRFS_I(inode)->io_tree, page_start, end,
-			  EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
-			  EXTENT_DEFRAG, &cached_state);
+	btrfs_clear_extent_bit(&BTRFS_I(inode)->io_tree, page_start, end,
+			       EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
+			       EXTENT_DEFRAG, &cached_state);
 
 	ret2 = btrfs_set_extent_delalloc(BTRFS_I(inode), page_start, end, 0,
 					&cached_state);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 30263f15bdca..ba3c8ba26c43 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1160,8 +1160,8 @@ update_cache_item(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
 	if (ret < 0) {
-		clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, inode->i_size - 1,
-				 EXTENT_DELALLOC, NULL);
+		btrfs_clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, inode->i_size - 1,
+				       EXTENT_DELALLOC, NULL);
 		goto fail;
 	}
 	leaf = path->nodes[0];
@@ -1172,9 +1172,9 @@ update_cache_item(struct btrfs_trans_handle *trans,
 		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
 		if (found_key.objectid != BTRFS_FREE_SPACE_OBJECTID ||
 		    found_key.offset != offset) {
-			clear_extent_bit(&BTRFS_I(inode)->io_tree, 0,
-					 inode->i_size - 1, EXTENT_DELALLOC,
-					 NULL);
+			btrfs_clear_extent_bit(&BTRFS_I(inode)->io_tree, 0,
+					       inode->i_size - 1, EXTENT_DELALLOC,
+					       NULL);
 			btrfs_release_path(path);
 			goto fail;
 		}
@@ -1267,8 +1267,8 @@ static int flush_dirty_cache(struct inode *inode)
 
 	ret = btrfs_wait_ordered_range(BTRFS_I(inode), 0, (u64)-1);
 	if (ret)
-		clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, inode->i_size - 1,
-				 EXTENT_DELALLOC, NULL);
+		btrfs_clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, inode->i_size - 1,
+				       EXTENT_DELALLOC, NULL);
 
 	return ret;
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 462b92c33930..6edf0998e627 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1753,7 +1753,7 @@ static int fallback_to_cow(struct btrfs_inode *inode,
 		spin_unlock(&sinfo->lock);
 
 		if (count > 0)
-			clear_extent_bits(io_tree, start, end, EXTENT_NORESERVE);
+			btrfs_clear_extent_bits(io_tree, start, end, EXTENT_NORESERVE);
 	}
 	btrfs_unlock_extent(io_tree, start, end, &cached_state);
 
@@ -3214,9 +3214,9 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 	 */
 	if ((clear_bits & EXTENT_DELALLOC_NEW) &&
 	    !test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags))
-		clear_extent_bit(&inode->io_tree, start, end,
-				 EXTENT_DELALLOC_NEW | EXTENT_ADD_INODE_BYTES,
-				 &cached_state);
+		btrfs_clear_extent_bit(&inode->io_tree, start, end,
+				       EXTENT_DELALLOC_NEW | EXTENT_ADD_INODE_BYTES,
+				       &cached_state);
 
 	btrfs_inode_safe_disk_i_size_write(inode, 0);
 	ret = btrfs_update_inode_fallback(trans, inode);
@@ -3225,8 +3225,8 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 out:
-	clear_extent_bit(&inode->io_tree, start, end, clear_bits,
-			 &cached_state);
+	btrfs_clear_extent_bit(&inode->io_tree, start, end, clear_bits,
+			       &cached_state);
 
 	if (trans)
 		btrfs_end_transaction(trans);
@@ -3381,8 +3381,8 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 	    test_range_bit(&inode->io_tree, file_offset, end, EXTENT_NODATASUM,
 			   NULL)) {
 		/* Skip the range without csum for data reloc inode */
-		clear_extent_bits(&inode->io_tree, file_offset, end,
-				  EXTENT_NODATASUM);
+		btrfs_clear_extent_bits(&inode->io_tree, file_offset, end,
+					EXTENT_NODATASUM);
 		return true;
 	}
 
@@ -4873,9 +4873,9 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 		goto again;
 	}
 
-	clear_extent_bit(&inode->io_tree, block_start, block_end,
-			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
-			 &cached_state);
+	btrfs_clear_extent_bit(&inode->io_tree, block_start, block_end,
+			       EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
+			       &cached_state);
 
 	ret = btrfs_set_extent_delalloc(inode, block_start, block_end, 0,
 					&cached_state);
@@ -5259,9 +5259,9 @@ static void evict_inode_truncate_pages(struct inode *inode)
 			btrfs_qgroup_free_data(BTRFS_I(inode), NULL, start,
 					       end - start + 1, NULL);
 
-		clear_extent_bit(io_tree, start, end,
-				 EXTENT_CLEAR_ALL_BITS | EXTENT_DO_ACCOUNTING,
-				 &cached_state);
+		btrfs_clear_extent_bit(io_tree, start, end,
+				       EXTENT_CLEAR_ALL_BITS | EXTENT_DO_ACCOUNTING,
+				       &cached_state);
 
 		cond_resched();
 		spin_lock(&io_tree->lock);
@@ -7415,10 +7415,10 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 		 * btrfs_finish_ordered_io().
 		 */
 		if (!inode_evicting)
-			clear_extent_bit(tree, cur, range_end,
-					 EXTENT_DELALLOC |
-					 EXTENT_LOCKED | EXTENT_DO_ACCOUNTING |
-					 EXTENT_DEFRAG, &cached_state);
+			btrfs_clear_extent_bit(tree, cur, range_end,
+					       EXTENT_DELALLOC |
+					       EXTENT_LOCKED | EXTENT_DO_ACCOUNTING |
+					       EXTENT_DEFRAG, &cached_state);
 
 		spin_lock_irq(&inode->ordered_tree_lock);
 		set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
@@ -7461,9 +7461,10 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 		 */
 		btrfs_qgroup_free_data(inode, NULL, cur, range_end + 1 - cur, NULL);
 		if (!inode_evicting)
-			clear_extent_bit(tree, cur, range_end, EXTENT_LOCKED |
-					 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
-					 EXTENT_DEFRAG | extra_flags, &cached_state);
+			btrfs_clear_extent_bit(tree, cur, range_end, EXTENT_LOCKED |
+					       EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
+					       EXTENT_DEFRAG | extra_flags,
+					       &cached_state);
 		cur = range_end + 1;
 	}
 	/*
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index d6fa36674270..a982fd64b814 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4129,8 +4129,8 @@ static int qgroup_unreserve_range(struct btrfs_inode *inode,
 		 * Now the entry is in [start, start + len), revert the
 		 * EXTENT_QGROUP_RESERVED bit.
 		 */
-		clear_ret = clear_extent_bits(&inode->io_tree, entry_start,
-					      entry_end, EXTENT_QGROUP_RESERVED);
+		clear_ret = btrfs_clear_extent_bits(&inode->io_tree, entry_start,
+						    entry_end, EXTENT_QGROUP_RESERVED);
 		if (!ret && clear_ret < 0)
 			ret = clear_ret;
 
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index e6c0a10c4c67..42c268dba11d 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -95,8 +95,8 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 	if (ret < 0)
 		goto out_unlock;
 
-	clear_extent_bits(&inode->io_tree, file_offset, range_end,
-			  EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG);
+	btrfs_clear_extent_bits(&inode->io_tree, file_offset, range_end,
+				EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG);
 	ret = btrfs_set_extent_delalloc(inode, file_offset, range_end, 0, NULL);
 	if (ret)
 		goto out_unlock;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4ac2e63cbe55..c46b6386b5fe 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2904,10 +2904,10 @@ static int relocate_one_folio(struct reloc_control *rc,
 		ret = btrfs_set_extent_delalloc(BTRFS_I(inode), clamped_start,
 						clamped_end, 0, &cached_state);
 		if (ret) {
-			clear_extent_bit(&BTRFS_I(inode)->io_tree,
-					 clamped_start, clamped_end,
-					 EXTENT_LOCKED | EXTENT_BOUNDARY,
-					 &cached_state);
+			btrfs_clear_extent_bit(&BTRFS_I(inode)->io_tree,
+					       clamped_start, clamped_end,
+					       EXTENT_LOCKED | EXTENT_BOUNDARY,
+					       &cached_state);
 			btrfs_delalloc_release_metadata(BTRFS_I(inode),
 							clamped_len, true);
 			btrfs_delalloc_release_extents(BTRFS_I(inode),
@@ -3643,7 +3643,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	}
 
 	btrfs_release_path(path);
-	clear_extent_bits(&rc->processed_blocks, 0, (u64)-1, EXTENT_DIRTY);
+	btrfs_clear_extent_bits(&rc->processed_blocks, 0, (u64)-1, EXTENT_DIRTY);
 
 	if (trans) {
 		btrfs_end_transaction_throttle(trans);
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 2021090ccd6a..311252356d99 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -325,7 +325,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 out_bits:
 	if (ret)
 		dump_extent_io_tree(tmp);
-	clear_extent_bits(tmp, 0, total_dirty - 1, (unsigned)-1);
+	btrfs_clear_extent_bits(tmp, 0, total_dirty - 1, (unsigned)-1);
 out:
 	if (locked_page)
 		put_page(locked_page);
@@ -661,7 +661,7 @@ static int test_find_first_clear_extent_bit(void)
 out:
 	if (ret)
 		dump_extent_io_tree(&tree);
-	clear_extent_bits(&tree, 0, (u64)-1, CHUNK_TRIMMED | CHUNK_ALLOCATED);
+	btrfs_clear_extent_bits(&tree, 0, (u64)-1, CHUNK_TRIMMED | CHUNK_ALLOCATED);
 
 	return ret;
 }
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index 09ba6e279d24..37b285896af0 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -949,10 +949,10 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	}
 
 	/* [BTRFS_MAX_EXTENT_SIZE/2][sectorsize HOLE][the rest] */
-	ret = clear_extent_bits(&BTRFS_I(inode)->io_tree,
-				BTRFS_MAX_EXTENT_SIZE >> 1,
-				(BTRFS_MAX_EXTENT_SIZE >> 1) + sectorsize - 1,
-				EXTENT_DELALLOC | EXTENT_DELALLOC_NEW);
+	ret = btrfs_clear_extent_bits(&BTRFS_I(inode)->io_tree,
+				      BTRFS_MAX_EXTENT_SIZE >> 1,
+				      (BTRFS_MAX_EXTENT_SIZE >> 1) + sectorsize - 1,
+				      EXTENT_DELALLOC | EXTENT_DELALLOC_NEW);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1016,10 +1016,10 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	}
 
 	/* [BTRFS_MAX_EXTENT_SIZE+4k][4K HOLE][BTRFS_MAX_EXTENT_SIZE+4k] */
-	ret = clear_extent_bits(&BTRFS_I(inode)->io_tree,
-				BTRFS_MAX_EXTENT_SIZE + sectorsize,
-				BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1,
-				EXTENT_DELALLOC | EXTENT_DELALLOC_NEW);
+	ret = btrfs_clear_extent_bits(&BTRFS_I(inode)->io_tree,
+				      BTRFS_MAX_EXTENT_SIZE + sectorsize,
+				      BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1,
+				      EXTENT_DELALLOC | EXTENT_DELALLOC_NEW);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1050,8 +1050,8 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	}
 
 	/* Empty */
-	ret = clear_extent_bits(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
-				EXTENT_DELALLOC | EXTENT_DELALLOC_NEW);
+	ret = btrfs_clear_extent_bits(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
+				      EXTENT_DELALLOC | EXTENT_DELALLOC_NEW);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1065,8 +1065,8 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	ret = 0;
 out:
 	if (ret)
-		clear_extent_bits(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
-				  EXTENT_DELALLOC | EXTENT_DELALLOC_NEW);
+		btrfs_clear_extent_bits(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
+					EXTENT_DELALLOC | EXTENT_DELALLOC_NEW);
 	iput(inode);
 	btrfs_free_dummy_root(root);
 	btrfs_free_dummy_fs_info(fs_info);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index f26a394a9ec5..3d272c140303 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1191,8 +1191,8 @@ static int __btrfs_wait_marked_extents(struct btrfs_fs_info *fs_info,
 		 * concurrently - we do it only at transaction commit time when
 		 * it's safe to do it (through extent_io_tree_release()).
 		 */
-		ret = clear_extent_bit(dirty_pages, start, end,
-				       EXTENT_NEED_WAIT, &cached_state);
+		ret = btrfs_clear_extent_bit(dirty_pages, start, end,
+					     EXTENT_NEED_WAIT, &cached_state);
 		if (ret == -ENOMEM)
 			ret = 0;
 		if (!ret)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 784d5a15ef29..4e49fa9f9fec 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5088,8 +5088,8 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 
 	mutex_lock(&fs_info->chunk_mutex);
 	/* Clear all state bits beyond the shrunk device size */
-	clear_extent_bits(&device->alloc_state, new_size, (u64)-1,
-			  CHUNK_STATE_MASK);
+	btrfs_clear_extent_bits(&device->alloc_state, new_size, (u64)-1,
+				CHUNK_STATE_MASK);
 
 	btrfs_device_set_disk_total_bytes(device, new_size);
 	if (list_empty(&device->post_commit_list))
@@ -5508,9 +5508,9 @@ static void chunk_map_device_clear_bits(struct btrfs_chunk_map *map, unsigned in
 		struct btrfs_io_stripe *stripe = &map->stripes[i];
 		struct btrfs_device *device = stripe->dev;
 
-		clear_extent_bits(&device->alloc_state, stripe->physical,
-				  stripe->physical + map->stripe_size - 1,
-				  bits | EXTENT_NOWAIT);
+		btrfs_clear_extent_bits(&device->alloc_state, stripe->physical,
+					stripe->physical + map->stripe_size - 1,
+					bits | EXTENT_NOWAIT);
 	}
 }
 
-- 
2.45.2


