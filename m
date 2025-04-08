Return-Path: <linux-btrfs+bounces-12884-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB70A813BA
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 19:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDDC461E6B
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 17:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F3E23E350;
	Tue,  8 Apr 2025 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5y7mAXO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039E52356C2
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133588; cv=none; b=RbTSQDiTtKHAfUETVh3Eqth10gSoJbmrO5xstCIMeXgP1smFKYxGNDx4aBPEJRx1FdUVvmrMa/Gd5K6bPwTRVWVpQ79dcjubmiuyAlCLlyf18mnJmKXQGPpfzYZku0rkqZaHGfn4XrZrPVFDzr+MBvNp4z/MtMfW4nqJQoGhKVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133588; c=relaxed/simple;
	bh=Dn152+wVS31vRCX2oqxsvSRHZSeRERlZpkeQ1M+7QZA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L9XwwjsdQxwLtBbutvZwYFXEx5Lz2Dqsbyq3ej8EUp5Y7NlKoOf01VeHmihhR7qXw7je8VaT7h+LzAot7cqyATSV0fOzF/qsE+iSarDK36nUJke4mKS4QyJqM0i8SXeuKaS3And5amXVwUGEfq0kCIcryvsjj7djLXbVzOFzpaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5y7mAXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF89FC4CEE5
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 17:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744133586;
	bh=Dn152+wVS31vRCX2oqxsvSRHZSeRERlZpkeQ1M+7QZA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=p5y7mAXOkbJ3ywHW9FpcJ36zGmdFBHnQHZJAOY218Hs74PD7+9X7YiWxJ49AsZ/tq
	 BrZQnzvKkH8Ff1J2h3Zb9V6hjip3avNXnNF+p1ls1QOW4bk8B6MgLt9kvvrpxhEahB
	 I5oCRK9L/tOKkz0Zr1Fkigx58g3n8o/vSPvG7R0sOr+hhky8nnUDWpoHp17pY5qc+n
	 5xSuijnKbZKGogQZG9XkrL+czGmwgjnRvTlmDekYaRMglxJ4/MQmmDXhZOCGjPrktT
	 6gs1pxVj1yWv+Kh13s9olyWd59aVRwsBUq/NL/rFkCCSVf6TUPU8E9irc3zvfZm2fj
	 QoufKvgzu+xJQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/6] btrfs: rename remaining exported extent map functions
Date: Tue,  8 Apr 2025 18:32:57 +0100
Message-Id: <8d487e5958ac565dae550471c6414de2e5a1c08f.1744130413.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744130413.git.fdmanana@suse.com>
References: <cover.1744130413.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Rename all the exported functions from extent_map.h that don't have a
'btrfs_' prefix in their names, so that they are consistent with all the
other functions, to make it clear they are btrfs specific functions and
to avoid potential name collisions in the future with functions defined
elsewhere in the kernel.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/compression.c            |  4 ++--
 fs/btrfs/defrag.c                 |  2 +-
 fs/btrfs/direct-io.c              |  6 ++---
 fs/btrfs/disk-io.c                |  2 +-
 fs/btrfs/extent_io.c              |  4 ++--
 fs/btrfs/extent_map.c             | 38 +++++++++++++++----------------
 fs/btrfs/extent_map.h             | 24 +++++++++----------
 fs/btrfs/inode.c                  | 12 +++++-----
 fs/btrfs/super.c                  |  4 ++--
 fs/btrfs/tests/extent-map-tests.c | 12 +++++-----
 fs/btrfs/tree-log.c               |  4 ++--
 fs/btrfs/zoned.c                  |  8 +++----
 12 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index fb108c878906..6911eaa6b408 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -501,7 +501,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		page_end = (pg_index << PAGE_SHIFT) + folio_size(folio) - 1;
 		btrfs_lock_extent(tree, cur, page_end, NULL);
 		read_lock(&em_tree->lock);
-		em = lookup_extent_mapping(em_tree, cur, page_end + 1 - cur);
+		em = btrfs_lookup_extent_mapping(em_tree, cur, page_end + 1 - cur);
 		read_unlock(&em_tree->lock);
 
 		/*
@@ -581,7 +581,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 
 	/* we need the actual starting offset of this extent in the file */
 	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, file_offset, fs_info->sectorsize);
+	em = btrfs_lookup_extent_mapping(em_tree, file_offset, fs_info->sectorsize);
 	read_unlock(&em_tree->lock);
 	if (!em) {
 		ret = BLK_STS_IOERR;
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 837598c82c9f..9dfdf29f54a0 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -753,7 +753,7 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
 	 * full extent lock.
 	 */
 	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, start, sectorsize);
+	em = btrfs_lookup_extent_mapping(em_tree, start, sectorsize);
 	read_unlock(&em_tree->lock);
 
 	/*
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 3793d9d1c574..3a03142dee09 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -692,9 +692,9 @@ static int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
 	 * a pre-existing one.
 	 */
 	if (!test_bit(BTRFS_ORDERED_NOCOW, &ordered->flags)) {
-		ret = split_extent_map(bbio->inode, bbio->file_offset,
-				       ordered->num_bytes, len,
-				       ordered->disk_bytenr);
+		ret = btrfs_split_extent_map(bbio->inode, bbio->file_offset,
+					     ordered->num_bytes, len,
+					     ordered->disk_bytenr);
 		if (ret)
 			return ret;
 	}
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5ee05955d004..59da809b7d57 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1922,7 +1922,7 @@ static int btrfs_init_btree_inode(struct super_block *sb)
 
 	btrfs_extent_io_tree_init(fs_info, &BTRFS_I(inode)->io_tree,
 				  IO_TREE_BTREE_INODE_IO);
-	extent_map_tree_init(&BTRFS_I(inode)->extent_tree);
+	btrfs_extent_map_tree_init(&BTRFS_I(inode)->extent_tree);
 
 	BTRFS_I(inode)->root = btrfs_grab_root(fs_info->tree_root);
 	set_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ec29ea6708cb..5f08615b334f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2666,7 +2666,7 @@ bool try_release_extent_mapping(struct folio *folio, gfp_t mask)
 		struct extent_map *em;
 
 		write_lock(&extent_tree->lock);
-		em = lookup_extent_mapping(extent_tree, start, len);
+		em = btrfs_lookup_extent_mapping(extent_tree, start, len);
 		if (!em) {
 			write_unlock(&extent_tree->lock);
 			break;
@@ -2705,7 +2705,7 @@ bool try_release_extent_mapping(struct folio *folio, gfp_t mask)
 		 * fsync performance for workloads with a data size that exceeds
 		 * or is close to the system's memory).
 		 */
-		remove_extent_mapping(inode, em);
+		btrfs_remove_extent_mapping(inode, em);
 		/* Once for the inode's extent map tree. */
 		btrfs_free_extent_map(em);
 next:
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 458215cafbb4..042b8b2e8b52 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -13,7 +13,7 @@
 
 static struct kmem_cache *extent_map_cache;
 
-int __init extent_map_init(void)
+int __init btrfs_extent_map_init(void)
 {
 	extent_map_cache = kmem_cache_create("btrfs_extent_map",
 					     sizeof(struct extent_map), 0, 0, NULL);
@@ -22,7 +22,7 @@ int __init extent_map_init(void)
 	return 0;
 }
 
-void __cold extent_map_exit(void)
+void __cold btrfs_extent_map_exit(void)
 {
 	kmem_cache_destroy(extent_map_cache);
 }
@@ -31,7 +31,7 @@ void __cold extent_map_exit(void)
  * Initialize the extent tree @tree.  Should be called for each new inode or
  * other user of the extent_map interface.
  */
-void extent_map_tree_init(struct extent_map_tree *tree)
+void btrfs_extent_map_tree_init(struct extent_map_tree *tree)
 {
 	tree->root = RB_ROOT;
 	INIT_LIST_HEAD(&tree->modified_extents);
@@ -409,7 +409,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
  * 	    -ENOENT  when the extent is not found in the tree
  * 	    -EUCLEAN if the found extent does not match the expected start
  */
-int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
+int btrfs_unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_map_tree *tree = &inode->extent_tree;
@@ -417,7 +417,7 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
 	struct extent_map *em;
 
 	write_lock(&tree->lock);
-	em = lookup_extent_mapping(tree, start, len);
+	em = btrfs_lookup_extent_mapping(tree, start, len);
 
 	if (WARN_ON(!em)) {
 		btrfs_warn(fs_info,
@@ -449,7 +449,7 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
 
 }
 
-void clear_em_logging(struct btrfs_inode *inode, struct extent_map *em)
+void btrfs_clear_em_logging(struct btrfs_inode *inode, struct extent_map *em)
 {
 	lockdep_assert_held_write(&inode->extent_tree.lock);
 
@@ -546,8 +546,8 @@ __lookup_extent_mapping(struct extent_map_tree *tree,
  * intersect, so check the object returned carefully to make sure that no
  * additional lookups are needed.
  */
-struct extent_map *lookup_extent_mapping(struct extent_map_tree *tree,
-					 u64 start, u64 len)
+struct extent_map *btrfs_lookup_extent_mapping(struct extent_map_tree *tree,
+					       u64 start, u64 len)
 {
 	return __lookup_extent_mapping(tree, start, len, 1);
 }
@@ -564,8 +564,8 @@ struct extent_map *lookup_extent_mapping(struct extent_map_tree *tree,
  *
  * If one can't be found, any nearby extent may be returned
  */
-struct extent_map *search_extent_mapping(struct extent_map_tree *tree,
-					 u64 start, u64 len)
+struct extent_map *btrfs_search_extent_mapping(struct extent_map_tree *tree,
+					       u64 start, u64 len)
 {
 	return __lookup_extent_mapping(tree, start, len, 0);
 }
@@ -579,7 +579,7 @@ struct extent_map *search_extent_mapping(struct extent_map_tree *tree,
  * Remove @em from the extent tree of @inode.  No reference counts are dropped,
  * and no checks are done to see if the range is in use.
  */
-void remove_extent_mapping(struct btrfs_inode *inode, struct extent_map *em)
+void btrfs_remove_extent_mapping(struct btrfs_inode *inode, struct extent_map *em)
 {
 	struct extent_map_tree *tree = &inode->extent_tree;
 
@@ -716,7 +716,7 @@ int btrfs_add_extent_mapping(struct btrfs_inode *inode,
 	if (ret == -EEXIST) {
 		struct extent_map *existing;
 
-		existing = search_extent_mapping(&inode->extent_tree, start, len);
+		existing = btrfs_search_extent_mapping(&inode->extent_tree, start, len);
 
 		trace_btrfs_handle_em_exist(fs_info, existing, em, start, len);
 
@@ -772,7 +772,7 @@ static void drop_all_extent_maps_fast(struct btrfs_inode *inode)
 
 		em = rb_entry(node, struct extent_map, rb_node);
 		em->flags &= ~(EXTENT_FLAG_PINNED | EXTENT_FLAG_LOGGING);
-		remove_extent_mapping(inode, em);
+		btrfs_remove_extent_mapping(inode, em);
 		btrfs_free_extent_map(em);
 
 		if (cond_resched_rwlock_write(&tree->lock))
@@ -830,7 +830,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 	split2 = btrfs_alloc_extent_map();
 
 	write_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, start, len);
+	em = btrfs_lookup_extent_mapping(em_tree, start, len);
 
 	while (em) {
 		/* extent_map_end() returns exclusive value (last byte + 1). */
@@ -965,7 +965,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 				ASSERT(!split);
 				btrfs_set_inode_full_sync(inode);
 			}
-			remove_extent_mapping(inode, em);
+			btrfs_remove_extent_mapping(inode, em);
 		}
 
 		/*
@@ -1033,8 +1033,8 @@ int btrfs_replace_extent_map_range(struct btrfs_inode *inode,
  *
  * This function is used when an ordered_extent needs to be split.
  */
-int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
-		     u64 new_logical)
+int btrfs_split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
+			   u64 new_logical)
 {
 	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em;
@@ -1057,7 +1057,7 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 
 	btrfs_lock_extent(&inode->io_tree, start, start + len - 1, NULL);
 	write_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, start, len);
+	em = btrfs_lookup_extent_mapping(em_tree, start, len);
 	if (!em) {
 		ret = -EIO;
 		goto out_unlock;
@@ -1168,7 +1168,7 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, struct btrfs_em_shrink_c
 		if (!list_empty(&em->list) && em->generation >= cur_fs_gen)
 			btrfs_set_inode_full_sync(inode);
 
-		remove_extent_mapping(inode, em);
+		btrfs_remove_extent_mapping(inode, em);
 		trace_btrfs_extent_map_shrinker_remove_em(inode, em);
 		/* Drop the reference for the tree. */
 		btrfs_free_extent_map(em);
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 890ea53a92d2..d4b81ee4d97b 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -167,21 +167,21 @@ static inline u64 btrfs_extent_map_end(const struct extent_map *em)
 	return em->start + em->len;
 }
 
-void extent_map_tree_init(struct extent_map_tree *tree);
-struct extent_map *lookup_extent_mapping(struct extent_map_tree *tree,
-					 u64 start, u64 len);
-void remove_extent_mapping(struct btrfs_inode *inode, struct extent_map *em);
-int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
-		     u64 new_logical);
+void btrfs_extent_map_tree_init(struct extent_map_tree *tree);
+struct extent_map *btrfs_lookup_extent_mapping(struct extent_map_tree *tree,
+					       u64 start, u64 len);
+void btrfs_remove_extent_mapping(struct btrfs_inode *inode, struct extent_map *em);
+int btrfs_split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
+			   u64 new_logical);
 
 struct extent_map *btrfs_alloc_extent_map(void);
 void btrfs_free_extent_map(struct extent_map *em);
-int __init extent_map_init(void);
-void __cold extent_map_exit(void);
-int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen);
-void clear_em_logging(struct btrfs_inode *inode, struct extent_map *em);
-struct extent_map *search_extent_mapping(struct extent_map_tree *tree,
-					 u64 start, u64 len);
+int __init btrfs_extent_map_init(void);
+void __cold btrfs_extent_map_exit(void);
+int btrfs_unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen);
+void btrfs_clear_em_logging(struct btrfs_inode *inode, struct extent_map *em);
+struct extent_map *btrfs_search_extent_mapping(struct extent_map_tree *tree,
+					       u64 start, u64 len);
 int btrfs_add_extent_mapping(struct btrfs_inode *inode,
 			     struct extent_map **em_in, u64 start, u64 len);
 void btrfs_drop_extent_map_range(struct btrfs_inode *inode,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a73691e4a668..ddbddf5d2423 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1203,7 +1203,7 @@ u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
 	u64 alloc_hint = 0;
 
 	read_lock(&em_tree->lock);
-	em = search_extent_mapping(em_tree, start, num_bytes);
+	em = btrfs_search_extent_mapping(em_tree, start, num_bytes);
 	if (em) {
 		/*
 		 * if block start isn't an actual block number then find the
@@ -1212,7 +1212,7 @@ u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
 		 */
 		if (em->disk_bytenr >= EXTENT_MAP_LAST_BYTE) {
 			btrfs_free_extent_map(em);
-			em = search_extent_mapping(em_tree, 0, 0);
+			em = btrfs_search_extent_mapping(em_tree, 0, 0);
 			if (em && em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
 				alloc_hint = btrfs_extent_map_block_start(em);
 			if (em)
@@ -3185,8 +3185,8 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
-	ret = unpin_extent_cache(inode, ordered_extent->file_offset,
-				 ordered_extent->num_bytes, trans->transid);
+	ret = btrfs_unpin_extent_cache(inode, ordered_extent->file_offset,
+				       ordered_extent->num_bytes, trans->transid);
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -6867,7 +6867,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	struct extent_map_tree *em_tree = &inode->extent_tree;
 
 	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, start, len);
+	em = btrfs_lookup_extent_mapping(em_tree, start, len);
 	read_unlock(&em_tree->lock);
 
 	if (em) {
@@ -7732,7 +7732,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	ei->i_otime_nsec = 0;
 
 	inode = &ei->vfs_inode;
-	extent_map_tree_init(&ei->extent_tree);
+	btrfs_extent_map_tree_init(&ei->extent_tree);
 
 	/* This io tree sets the valid inode. */
 	btrfs_extent_io_tree_init(fs_info, &ei->io_tree, IO_TREE_INODE_IO);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 344cc0812ef7..eb92465536f3 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2534,8 +2534,8 @@ static const struct init_sequence mod_init_seq[] = {
 		.init_func = btrfs_bioset_init,
 		.exit_func = btrfs_bioset_exit,
 	}, {
-		.init_func = extent_map_init,
-		.exit_func = extent_map_exit,
+		.init_func = btrfs_extent_map_init,
+		.exit_func = btrfs_extent_map_exit,
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	}, {
 		.init_func = btrfs_read_policy_init,
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 3b7487c032d4..3a86534c116f 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -22,7 +22,7 @@ static int free_extent_map_tree(struct btrfs_inode *inode)
 	while (!RB_EMPTY_ROOT(&em_tree->root)) {
 		node = rb_first(&em_tree->root);
 		em = rb_entry(node, struct extent_map, rb_node);
-		remove_extent_mapping(inode, em);
+		btrfs_remove_extent_mapping(inode, em);
 
 #ifdef CONFIG_BTRFS_DEBUG
 		if (refcount_read(&em->refs) != 1) {
@@ -826,7 +826,7 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	/* Make sure our extent maps look sane. */
 	ret = -EINVAL;
 
-	em = lookup_extent_mapping(em_tree, 0, SZ_16K);
+	em = btrfs_lookup_extent_mapping(em_tree, 0, SZ_16K);
 	if (!em) {
 		test_err("didn't find an em at 0 as expected");
 		goto out;
@@ -845,7 +845,7 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	btrfs_free_extent_map(em);
 
 	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, SZ_16K, SZ_16K);
+	em = btrfs_lookup_extent_mapping(em_tree, SZ_16K, SZ_16K);
 	read_unlock(&em_tree->lock);
 	if (em) {
 		test_err("found an em when we weren't expecting one");
@@ -853,7 +853,7 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	}
 
 	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, SZ_32K, SZ_16K);
+	em = btrfs_lookup_extent_mapping(em_tree, SZ_32K, SZ_16K);
 	read_unlock(&em_tree->lock);
 	if (!em) {
 		test_err("didn't find an em at 32K as expected");
@@ -879,7 +879,7 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	btrfs_free_extent_map(em);
 
 	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, 48 * SZ_1K, (u64)-1);
+	em = btrfs_lookup_extent_mapping(em_tree, 48 * SZ_1K, (u64)-1);
 	read_unlock(&em_tree->lock);
 	if (em) {
 		test_err("found an unexpected em above 48K");
@@ -890,7 +890,7 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 out:
 	btrfs_free_extent_map(em);
 	/* Unpin our extent to prevent warning when removing it below. */
-	ret2 = unpin_extent_cache(inode, 0, SZ_16K, 0);
+	ret2 = btrfs_unpin_extent_cache(inode, 0, SZ_16K, 0);
 	if (ret == 0)
 		ret = ret2;
 	ret2 = free_extent_map_tree(inode);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 3d20473a4bc3..411dad8860a8 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4956,7 +4956,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 		 * private list.
 		 */
 		if (ret) {
-			clear_em_logging(inode, em);
+			btrfs_clear_em_logging(inode, em);
 			btrfs_free_extent_map(em);
 			continue;
 		}
@@ -4965,7 +4965,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 
 		ret = log_one_extent(trans, inode, em, path, ctx);
 		write_lock(&tree->lock);
-		clear_em_logging(inode, em);
+		btrfs_clear_em_logging(inode, em);
 		btrfs_free_extent_map(em);
 	}
 	WARN_ON(!list_empty(&extents));
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 20806f15ceaa..c1fb28a48940 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1783,8 +1783,8 @@ static void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered,
 	ordered->disk_bytenr = logical;
 
 	write_lock(&em_tree->lock);
-	em = search_extent_mapping(em_tree, ordered->file_offset,
-				   ordered->num_bytes);
+	em = btrfs_search_extent_mapping(em_tree, ordered->file_offset,
+					 ordered->num_bytes);
 	/* The em should be a new COW extent, thus it should not have an offset. */
 	ASSERT(em->offset == 0);
 	em->disk_bytenr = logical;
@@ -1798,8 +1798,8 @@ static bool btrfs_zoned_split_ordered(struct btrfs_ordered_extent *ordered,
 	struct btrfs_ordered_extent *new;
 
 	if (!test_bit(BTRFS_ORDERED_NOCOW, &ordered->flags) &&
-	    split_extent_map(ordered->inode, ordered->file_offset,
-			     ordered->num_bytes, len, logical))
+	    btrfs_split_extent_map(ordered->inode, ordered->file_offset,
+				   ordered->num_bytes, len, logical))
 		return false;
 
 	new = btrfs_split_ordered_extent(ordered, len);
-- 
2.45.2


