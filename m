Return-Path: <linux-btrfs+bounces-12845-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E585CA7E8B0
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 19:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A5E17FDB3
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 17:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A4424502E;
	Mon,  7 Apr 2025 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zz5K/Zih"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ECF23C8BB
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047394; cv=none; b=kHXJ6d/4320eZQody55oVs3jvmA/+eIyVzXmtChko0qsSFm5tUF3C4UD5rX2g7u+xbBznhMt0VIzEqzAhhv/wAPg5IF4Byj3JW+yDsojnG+7xgRj18L0T7NORUWvbkAFUR9Y5e2x0heFIJvUjDfp0QDPAdqo13G459ncxFLMvts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047394; c=relaxed/simple;
	bh=wCtcC9/Cy9DNtbFgRQ8ByfZtw4uFkOExY65O6wXvAX0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R3LMYqX3v8Qjg6bN+hCH7tSfhgUKCT5vqss4szkKmw1VvaiZYwa9dHjmdRoWlhcr6qQAMOpHDMKD7Kk8IQXQv/3W5La/2wubvgiKCg/0ghGkhlkkxh+PF0WA0Xanxic1LtCC8iAqiMc3t8NAMck+FH5QZ4iJffGBwTLkLE65/RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zz5K/Zih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BE6C4CEE9
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047394;
	bh=wCtcC9/Cy9DNtbFgRQ8ByfZtw4uFkOExY65O6wXvAX0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Zz5K/ZihYm7IMxPtd4wTZ/JgHvgcUKJQymVoBUIySSbIEuJIK2I3WJ6D+XEFazTCf
	 QRZvMyaArthTtQ+VzdNcqEJd2e1pluHxhPvjdF0GcN2cQbs7A5ak+RkpJ1WLPupF2E
	 5ITlqOx46m5LSoqyCHMeTbUZMjQabveaJNLckkTgWAW9LL/apQ3+Cs3UZdwbXHit+t
	 zgDdvyv8PMiZiiRup7dCdXk5tQDAaqeXP4E5gh8CVwwmdYlpyscwquWSBvd2Fj+d1z
	 wwW1FyylkOdRptP/9HoD6elef0o1MttIBjvN+7g/vOZaehOUpEkb7hS/KrUskkSsHu
	 XajX6YUYvHlCQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 07/16] btrfs: rename set_extent_bit() to include a btrfs prefix
Date: Mon,  7 Apr 2025 18:36:14 +0100
Message-Id: <0946cfe33a0a612c75c53b9aff184ff48ec30440.1744046765.git.fdmanana@suse.com>
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

This is an exported function so it should have a 'btrfs_' prefix by
convention, to make it clear it's btrfs specific and to avoid collisions
with functions from elsewhere in the kernel.

So rename it to btrfs_set_extent_bit().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c           | 16 ++++++++--------
 fs/btrfs/defrag.c                |  4 ++--
 fs/btrfs/dev-replace.c           |  4 ++--
 fs/btrfs/extent-io-tree.c        |  4 ++--
 fs/btrfs/extent-io-tree.h        |  4 ++--
 fs/btrfs/extent-tree.c           | 24 ++++++++++++------------
 fs/btrfs/file-item.c             | 10 +++++-----
 fs/btrfs/inode.c                 | 14 +++++++-------
 fs/btrfs/relocation.c            | 11 ++++++-----
 fs/btrfs/tests/extent-io-tests.c | 16 ++++++++--------
 fs/btrfs/volumes.c               |  6 +++---
 11 files changed, 57 insertions(+), 56 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index a5c587cf42a7..944c355bf051 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2216,9 +2216,9 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 	if (cache->start < BTRFS_SUPER_INFO_OFFSET) {
 		stripe_len = BTRFS_SUPER_INFO_OFFSET - cache->start;
 		cache->bytes_super += stripe_len;
-		ret = set_extent_bit(&fs_info->excluded_extents, cache->start,
-				     cache->start + stripe_len - 1,
-				     EXTENT_DIRTY, NULL);
+		ret = btrfs_set_extent_bit(&fs_info->excluded_extents, cache->start,
+					   cache->start + stripe_len - 1,
+					   EXTENT_DIRTY, NULL);
 		if (ret)
 			return ret;
 	}
@@ -2244,9 +2244,9 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 				cache->start + cache->length - logical[nr]);
 
 			cache->bytes_super += len;
-			ret = set_extent_bit(&fs_info->excluded_extents, logical[nr],
-					     logical[nr] + len - 1,
-					     EXTENT_DIRTY, NULL);
+			ret = btrfs_set_extent_bit(&fs_info->excluded_extents,
+						   logical[nr], logical[nr] + len - 1,
+						   EXTENT_DIRTY, NULL);
 			if (ret) {
 				kfree(logical);
 				return ret;
@@ -3736,8 +3736,8 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		spin_unlock(&cache->lock);
 		spin_unlock(&space_info->lock);
 
-		set_extent_bit(&trans->transaction->pinned_extents, bytenr,
-			       bytenr + num_bytes - 1, EXTENT_DIRTY, NULL);
+		btrfs_set_extent_bit(&trans->transaction->pinned_extents, bytenr,
+				     bytenr + num_bytes - 1, EXTENT_DIRTY, NULL);
 	}
 
 	spin_lock(&trans->transaction->dirty_bgs_lock);
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index ee00250776bb..587f2504a570 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -1173,8 +1173,8 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 	btrfs_clear_extent_bit(&inode->io_tree, start, start + len - 1,
 			       EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
 			       EXTENT_DEFRAG, cached_state);
-	set_extent_bit(&inode->io_tree, start, start + len - 1,
-		       EXTENT_DELALLOC | EXTENT_DEFRAG, cached_state);
+	btrfs_set_extent_bit(&inode->io_tree, start, start + len - 1,
+			     EXTENT_DELALLOC | EXTENT_DEFRAG, cached_state);
 
 	/* Update the page status */
 	for (i = start_index - first_index; i <= last_index - first_index; i++) {
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 53d7d85cb4be..db94c7f22461 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -797,8 +797,8 @@ static int btrfs_set_target_alloc_state(struct btrfs_device *srcdev,
 	while (find_first_extent_bit(&srcdev->alloc_state, start,
 				     &found_start, &found_end,
 				     CHUNK_ALLOCATED, &cached_state)) {
-		ret = set_extent_bit(&tgtdev->alloc_state, found_start,
-				     found_end, CHUNK_ALLOCATED, NULL);
+		ret = btrfs_set_extent_bit(&tgtdev->alloc_state, found_start,
+					   found_end, CHUNK_ALLOCATED, NULL);
 		if (ret)
 			break;
 		start = found_end + 1;
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 50b4d0b29468..49a9202dc5d0 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1256,8 +1256,8 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 
 }
 
-int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   u32 bits, struct extent_state **cached_state)
+int btrfs_set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+			 u32 bits, struct extent_state **cached_state)
 {
 	return __set_extent_bit(tree, start, end, bits, NULL, NULL,
 				cached_state, NULL);
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 6c2148ed0bb6..e092d776a755 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -199,8 +199,8 @@ static inline int btrfs_clear_extent_bits(struct extent_io_tree *tree, u64 start
 
 int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			   u32 bits, struct extent_changeset *changeset);
-int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   u32 bits, struct extent_state **cached_state);
+int btrfs_set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+			 u32 bits, struct extent_state **cached_state);
 
 static inline int btrfs_clear_extent_dirty(struct extent_io_tree *tree, u64 start,
 					   u64 end, struct extent_state **cached)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 841f538a940e..06eb0d724f3d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2598,8 +2598,8 @@ static int pin_down_extent(struct btrfs_trans_handle *trans,
 	spin_unlock(&cache->lock);
 	spin_unlock(&cache->space_info->lock);
 
-	set_extent_bit(&trans->transaction->pinned_extents, bytenr,
-		       bytenr + num_bytes - 1, EXTENT_DIRTY, NULL);
+	btrfs_set_extent_bit(&trans->transaction->pinned_extents, bytenr,
+			     bytenr + num_bytes - 1, EXTENT_DIRTY, NULL);
 	return 0;
 }
 
@@ -5065,17 +5065,17 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		 * EXTENT bit to differentiate dirty pages.
 		 */
 		if (buf->log_index == 0)
-			set_extent_bit(&root->dirty_log_pages, buf->start,
-				       buf->start + buf->len - 1,
-				       EXTENT_DIRTY, NULL);
+			btrfs_set_extent_bit(&root->dirty_log_pages, buf->start,
+					     buf->start + buf->len - 1,
+					     EXTENT_DIRTY, NULL);
 		else
-			set_extent_bit(&root->dirty_log_pages, buf->start,
-				       buf->start + buf->len - 1,
-				       EXTENT_NEW, NULL);
+			btrfs_set_extent_bit(&root->dirty_log_pages, buf->start,
+					     buf->start + buf->len - 1,
+					     EXTENT_NEW, NULL);
 	} else {
 		buf->log_index = -1;
-		set_extent_bit(&trans->transaction->dirty_pages, buf->start,
-			       buf->start + buf->len - 1, EXTENT_DIRTY, NULL);
+		btrfs_set_extent_bit(&trans->transaction->dirty_pages, buf->start,
+				     buf->start + buf->len - 1, EXTENT_DIRTY, NULL);
 	}
 	/* this returns a buffer locked for blocking */
 	return buf;
@@ -6430,8 +6430,8 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 		ret = btrfs_issue_discard(device->bdev, start, len,
 					  &bytes);
 		if (!ret)
-			set_extent_bit(&device->alloc_state, start,
-				       start + bytes - 1, CHUNK_TRIMMED, NULL);
+			btrfs_set_extent_bit(&device->alloc_state, start,
+					     start + bytes - 1, CHUNK_TRIMMED, NULL);
 		mutex_unlock(&fs_info->chunk_mutex);
 
 		if (ret)
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index aa840ba94634..87e956cd3520 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -91,8 +91,8 @@ int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start,
 
 	ASSERT(IS_ALIGNED(start + len, inode->root->fs_info->sectorsize));
 
-	return set_extent_bit(inode->file_extent_tree, start, start + len - 1,
-			      EXTENT_DIRTY, NULL);
+	return btrfs_set_extent_bit(inode->file_extent_tree, start, start + len - 1,
+				    EXTENT_DIRTY, NULL);
 }
 
 /*
@@ -430,9 +430,9 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 			if (btrfs_root_id(inode->root) == BTRFS_DATA_RELOC_TREE_OBJECTID) {
 				u64 file_offset = bbio->file_offset + bio_offset;
 
-				set_extent_bit(&inode->io_tree, file_offset,
-					       file_offset + sectorsize - 1,
-					       EXTENT_NODATASUM, NULL);
+				btrfs_set_extent_bit(&inode->io_tree, file_offset,
+						     file_offset + sectorsize - 1,
+						     EXTENT_NODATASUM, NULL);
 			} else {
 				btrfs_warn_rl(fs_info,
 			"csum hole found for disk bytenr range [%llu, %llu)",
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6edf0998e627..1ebdd5e46af6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2683,9 +2683,9 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
 		if (em_len > search_len)
 			em_len = search_len;
 
-		ret = set_extent_bit(&inode->io_tree, search_start,
-				     search_start + em_len - 1,
-				     EXTENT_DELALLOC_NEW, cached_state);
+		ret = btrfs_set_extent_bit(&inode->io_tree, search_start,
+					   search_start + em_len - 1,
+					   EXTENT_DELALLOC_NEW, cached_state);
 next:
 		search_start = extent_map_end(em);
 		free_extent_map(em);
@@ -2718,8 +2718,8 @@ int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 			return ret;
 	}
 
-	return set_extent_bit(&inode->io_tree, start, end,
-			      EXTENT_DELALLOC | extra_bits, cached_state);
+	return btrfs_set_extent_bit(&inode->io_tree, start, end,
+				    EXTENT_DELALLOC | extra_bits, cached_state);
 }
 
 /* see btrfs_writepage_start_hook for details on why this is required */
@@ -4902,8 +4902,8 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	btrfs_unlock_extent(io_tree, block_start, block_end, &cached_state);
 
 	if (only_release_metadata)
-		set_extent_bit(&inode->io_tree, block_start, block_end,
-			       EXTENT_NORESERVE, NULL);
+		btrfs_set_extent_bit(&inode->io_tree, block_start, block_end,
+				     EXTENT_NORESERVE, NULL);
 
 out_unlock:
 	if (ret) {
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c46b6386b5fe..ec31cefd0dc1 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -178,8 +178,9 @@ static void mark_block_processed(struct reloc_control *rc,
 	    in_range(node->bytenr, rc->block_group->start,
 		     rc->block_group->length)) {
 		blocksize = rc->extent_root->fs_info->nodesize;
-		set_extent_bit(&rc->processed_blocks, node->bytenr,
-			       node->bytenr + blocksize - 1, EXTENT_DIRTY, NULL);
+		btrfs_set_extent_bit(&rc->processed_blocks, node->bytenr,
+				     node->bytenr + blocksize - 1, EXTENT_DIRTY,
+				     NULL);
 	}
 	node->processed = 1;
 }
@@ -2929,9 +2930,9 @@ static int relocate_one_folio(struct reloc_control *rc,
 			u64 boundary_end = boundary_start +
 					   fs_info->sectorsize - 1;
 
-			set_extent_bit(&BTRFS_I(inode)->io_tree,
-				       boundary_start, boundary_end,
-				       EXTENT_BOUNDARY, NULL);
+			btrfs_set_extent_bit(&BTRFS_I(inode)->io_tree,
+					     boundary_start, boundary_end,
+					     EXTENT_BOUNDARY, NULL);
 		}
 		btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end,
 				    &cached_state);
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 311252356d99..5b5506f4b512 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -175,7 +175,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	 * |--- delalloc ---|
 	 * |---  search  ---|
 	 */
-	set_extent_bit(tmp, 0, sectorsize - 1, EXTENT_DELALLOC, NULL);
+	btrfs_set_extent_bit(tmp, 0, sectorsize - 1, EXTENT_DELALLOC, NULL);
 	start = 0;
 	end = start + PAGE_SIZE - 1;
 	found = find_lock_delalloc_range(inode, page_folio(locked_page), &start,
@@ -206,7 +206,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 		test_err("couldn't find the locked page");
 		goto out_bits;
 	}
-	set_extent_bit(tmp, sectorsize, max_bytes - 1, EXTENT_DELALLOC, NULL);
+	btrfs_set_extent_bit(tmp, sectorsize, max_bytes - 1, EXTENT_DELALLOC, NULL);
 	start = test_start;
 	end = start + PAGE_SIZE - 1;
 	found = find_lock_delalloc_range(inode, page_folio(locked_page), &start,
@@ -261,7 +261,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	 *
 	 * We are re-using our test_start from above since it works out well.
 	 */
-	set_extent_bit(tmp, max_bytes, total_dirty - 1, EXTENT_DELALLOC, NULL);
+	btrfs_set_extent_bit(tmp, max_bytes, total_dirty - 1, EXTENT_DELALLOC, NULL);
 	start = test_start;
 	end = start + PAGE_SIZE - 1;
 	found = find_lock_delalloc_range(inode, page_folio(locked_page), &start,
@@ -577,8 +577,8 @@ static int test_find_first_clear_extent_bit(void)
 	 * Set 1M-4M alloc/discard and 32M-64M thus leaving a hole between
 	 * 4M-32M
 	 */
-	set_extent_bit(&tree, SZ_1M, SZ_4M - 1,
-		       CHUNK_TRIMMED | CHUNK_ALLOCATED, NULL);
+	btrfs_set_extent_bit(&tree, SZ_1M, SZ_4M - 1,
+			     CHUNK_TRIMMED | CHUNK_ALLOCATED, NULL);
 
 	find_first_clear_extent_bit(&tree, SZ_512K, &start, &end,
 				    CHUNK_TRIMMED | CHUNK_ALLOCATED);
@@ -590,8 +590,8 @@ static int test_find_first_clear_extent_bit(void)
 	}
 
 	/* Now add 32M-64M so that we have a hole between 4M-32M */
-	set_extent_bit(&tree, SZ_32M, SZ_64M - 1,
-		       CHUNK_TRIMMED | CHUNK_ALLOCATED, NULL);
+	btrfs_set_extent_bit(&tree, SZ_32M, SZ_64M - 1,
+			     CHUNK_TRIMMED | CHUNK_ALLOCATED, NULL);
 
 	/*
 	 * Request first hole starting at 12M, we should get 4M-32M
@@ -622,7 +622,7 @@ static int test_find_first_clear_extent_bit(void)
 	 * Set 64M-72M with CHUNK_ALLOC flag, then search for CHUNK_TRIMMED flag
 	 * being unset in this range, we should get the entry in range 64M-72M
 	 */
-	set_extent_bit(&tree, SZ_64M, SZ_64M + SZ_8M - 1, CHUNK_ALLOCATED, NULL);
+	btrfs_set_extent_bit(&tree, SZ_64M, SZ_64M + SZ_8M - 1, CHUNK_ALLOCATED, NULL);
 	find_first_clear_extent_bit(&tree, SZ_64M + SZ_1M, &start, &end,
 				    CHUNK_TRIMMED);
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4e49fa9f9fec..1a60622096da 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5496,9 +5496,9 @@ static void chunk_map_device_set_bits(struct btrfs_chunk_map *map, unsigned int
 		struct btrfs_io_stripe *stripe = &map->stripes[i];
 		struct btrfs_device *device = stripe->dev;
 
-		set_extent_bit(&device->alloc_state, stripe->physical,
-			       stripe->physical + map->stripe_size - 1,
-			       bits | EXTENT_NOWAIT, NULL);
+		btrfs_set_extent_bit(&device->alloc_state, stripe->physical,
+				     stripe->physical + map->stripe_size - 1,
+				     bits | EXTENT_NOWAIT, NULL);
 	}
 }
 
-- 
2.45.2


