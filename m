Return-Path: <linux-btrfs+bounces-12882-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3DDA813C2
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 19:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0314D3B6081
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 17:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AB723E334;
	Tue,  8 Apr 2025 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cc1tLOqL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E68E23E325
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133586; cv=none; b=SXbYMDby1E42AYnaYb98bdB8A46xnnt41QlFyi2GakMCr6OdJZD/wme3D6bM1OzgioI9mR2ZKk0/SdZ38XpjtTzDt1iUayBP8tyP4pODALlsx5cnMX9V8vRGfrF3hpZWeObWZgpnYejvUqhB9wJ2eyqWaGO8aisbIi8eG8NfQjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133586; c=relaxed/simple;
	bh=wuWCanMEA5PVrVpMqxdOrdu2JyP92hUMgCzZlrpSKeo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VLhOqllYgjwGm0RTbuyTGRF6WyKRGtEmuYlkXKhwRIHahqRhPxS/2T4kHXqK/erBolZXPIWeHATma1WGTFELHYWHx4p4ynIf/4ukxNdxxRr1qkuOmDIIKt/CYkncQ91VZRNeAzJQlEZnMRRwap38hdH43mmy8IFN8hDJe87rCV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cc1tLOqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE23C4CEE8
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 17:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744133585;
	bh=wuWCanMEA5PVrVpMqxdOrdu2JyP92hUMgCzZlrpSKeo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cc1tLOqLotY5NBfRGOQX1PAg/9fSzVX0yeK1Fq0igTc73H3myNMdq/w05BzdhY6xe
	 JV+7kLF3HdzU38ZrPBneBwJrbmseE8o2mdFzED466tvSQ5UU7iDE6URgRQVCa5/5eT
	 vcf7Du4ELF4RBPDeO00JVNvjAQcccO1E6wQTbra9CELmcHEAUog8gm2Lj7Za8/h9a9
	 WnmGCoEc93wJCninoK/KPUxgp1MPUhDc9l2onPQwDx5E5itXuCuBeBQpt0l5F2Liqm
	 av3Jwy2EJ4Anmf1VTlhk/oFH7dB/N9QeenuA4RP4N/dn0qSCdMNES+cgWCaFjS+4DQ
	 7Wa8twuCMPoUQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs: rename functions to allocate and free extent maps
Date: Tue,  8 Apr 2025 18:32:56 +0100
Message-Id: <529e4b0b43a4b5e800cf11514a267387cac2a73a.1744130413.git.fdmanana@suse.com>
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

These functions are exported and don't have a 'btrfs_' prefix in their
names, which goes against coding style conventions. Rename them to have
such prefix, making it clear they are from btrfs and avoiding pontential
collisions in the future with functions defined elsewhere outside btrfs.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/compression.c            |  6 +--
 fs/btrfs/defrag.c                 | 14 +++---
 fs/btrfs/direct-io.c              | 14 +++---
 fs/btrfs/extent_io.c              | 16 +++----
 fs/btrfs/extent_map.c             | 48 +++++++++----------
 fs/btrfs/extent_map.h             |  4 +-
 fs/btrfs/file.c                   | 24 +++++-----
 fs/btrfs/inode.c                  | 48 +++++++++----------
 fs/btrfs/relocation.c             |  4 +-
 fs/btrfs/tests/extent-map-tests.c | 76 +++++++++++++++----------------
 fs/btrfs/tests/inode-tests.c      | 40 ++++++++--------
 fs/btrfs/tree-log.c               |  4 +-
 fs/btrfs/zoned.c                  |  2 +-
 13 files changed, 150 insertions(+), 150 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 95344cb74d89..fb108c878906 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -513,14 +513,14 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		    (cur + fs_info->sectorsize > btrfs_extent_map_end(em)) ||
 		    (btrfs_extent_map_block_start(em) >> SECTOR_SHIFT) !=
 		    orig_bio->bi_iter.bi_sector) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			btrfs_unlock_extent(tree, cur, page_end, NULL);
 			folio_unlock(folio);
 			folio_put(folio);
 			break;
 		}
 		add_size = min(em->start + em->len, page_end + 1) - cur;
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		btrfs_unlock_extent(tree, cur, page_end, NULL);
 
 		if (folio_contains(folio, end_index)) {
@@ -603,7 +603,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	cb->compress_type = btrfs_extent_map_compression(em);
 	cb->orig_bbio = bbio;
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	cb->nr_folios = DIV_ROUND_UP(compressed_len, PAGE_SIZE);
 	cb->compressed_folios = kcalloc(cb->nr_folios, sizeof(struct page *), GFP_NOFS);
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 8cb225ab1c17..837598c82c9f 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -621,7 +621,7 @@ static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
 	u64 ino = btrfs_ino(inode);
 	int ret;
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		ret = -ENOMEM;
 		goto err;
@@ -731,12 +731,12 @@ static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
 
 not_found:
 	btrfs_release_path(&path);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return NULL;
 
 err:
 	btrfs_release_path(&path);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ERR_PTR(ret);
 }
 
@@ -766,7 +766,7 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
 	 * file extent items in the inode's subvolume tree).
 	 */
 	if (em && (em->flags & EXTENT_FLAG_MERGED)) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 	}
 
@@ -834,7 +834,7 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
 
 	ret = true;
 out:
-	free_extent_map(next);
+	btrfs_free_extent_map(next);
 	return ret;
 }
 
@@ -1096,7 +1096,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		/* Allocate new defrag_target_range */
 		new = kmalloc(sizeof(*new), GFP_NOFS);
 		if (!new) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			ret = -ENOMEM;
 			break;
 		}
@@ -1106,7 +1106,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 
 next:
 		cur = btrfs_extent_map_end(em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 	if (ret < 0) {
 		struct defrag_target_range *entry;
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 2daf0c524500..3793d9d1c574 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -155,7 +155,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 					     (1 << BTRFS_ORDERED_DIRECT));
 	if (IS_ERR(ordered)) {
 		if (em) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			btrfs_drop_extent_map_range(inode, start,
 					start + file_extent->num_bytes - 1, false);
 		}
@@ -265,7 +265,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 						      nowait);
 		if (ret < 0) {
 			/* Our caller expects us to free the input extent map. */
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			*map = NULL;
 			btrfs_dec_nocow_writers(bg);
 			if (nowait && (ret == -ENOSPC || ret == -EDQUOT))
@@ -278,7 +278,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 					      &file_extent, type);
 		btrfs_dec_nocow_writers(bg);
 		if (type == BTRFS_ORDERED_PREALLOC) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			*map = em2;
 			em = em2;
 		}
@@ -291,7 +291,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		dio_data->nocow_done = true;
 	} else {
 		/* Our caller expects us to free the input extent map. */
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		*map = NULL;
 
 		if (nowait) {
@@ -475,7 +475,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	 * the generic code.
 	 */
 	if (btrfs_extent_map_is_compressed(em) || em->disk_bytenr == EXTENT_MAP_INLINE) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		/*
 		 * If we are in a NOWAIT context, return -EAGAIN in order to
 		 * fallback to buffered IO. This is not only because we can
@@ -516,7 +516,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	 * after we have submitted bios for all the extents in the range.
 	 */
 	if ((flags & IOMAP_NOWAIT) && len < length) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		ret = -EAGAIN;
 		goto unlock_err;
 	}
@@ -564,7 +564,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	iomap->offset = start;
 	iomap->bdev = fs_info->fs_devices->latest_dev->bdev;
 	iomap->length = len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/*
 	 * Reads will hold the EXTENT_DIO_LOCKED bit until the io is completed,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 391c5499a444..ec29ea6708cb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -896,7 +896,7 @@ static struct extent_map *get_extent_map(struct btrfs_inode *inode,
 			return em;
 		}
 
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		*em_cached = NULL;
 	}
 
@@ -1024,7 +1024,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		if (prev_em_start)
 			*prev_em_start = em->start;
 
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 
 		/* we've found a hole, just zero and go on */
@@ -1244,7 +1244,7 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
 	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
 	btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state);
 
-	free_extent_map(em_cached);
+	btrfs_free_extent_map(em_cached);
 
 	/*
 	 * If btrfs_do_readpage() failed we will want to submit the assembled
@@ -1549,7 +1549,7 @@ static int submit_one_sector(struct btrfs_inode *inode,
 	ASSERT(block_start != EXTENT_MAP_HOLE);
 	ASSERT(block_start != EXTENT_MAP_INLINE);
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	em = NULL;
 
 	/*
@@ -2564,7 +2564,7 @@ void btrfs_readahead(struct readahead_control *rac)
 	btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state);
 
 	if (em_cached)
-		free_extent_map(em_cached);
+		btrfs_free_extent_map(em_cached);
 	submit_one_bio(&bio_ctrl);
 }
 
@@ -2673,7 +2673,7 @@ bool try_release_extent_mapping(struct folio *folio, gfp_t mask)
 		}
 		if ((em->flags & EXTENT_FLAG_PINNED) || em->start != start) {
 			write_unlock(&extent_tree->lock);
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			break;
 		}
 		if (btrfs_test_range_bit_exists(io_tree, em->start,
@@ -2707,13 +2707,13 @@ bool try_release_extent_mapping(struct folio *folio, gfp_t mask)
 		 */
 		remove_extent_mapping(inode, em);
 		/* Once for the inode's extent map tree. */
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 next:
 		start = btrfs_extent_map_end(em);
 		write_unlock(&extent_tree->lock);
 
 		/* Once for us, for the lookup_extent_mapping() reference. */
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 
 		if (need_resched()) {
 			/*
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index e91ce1402473..458215cafbb4 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -42,7 +42,7 @@ void extent_map_tree_init(struct extent_map_tree *tree)
  * Allocate a new extent_map structure.  The new structure is returned with a
  * reference count of one and needs to be freed using free_extent_map()
  */
-struct extent_map *alloc_extent_map(void)
+struct extent_map *btrfs_alloc_extent_map(void)
 {
 	struct extent_map *em;
 	em = kmem_cache_zalloc(extent_map_cache, GFP_NOFS);
@@ -58,7 +58,7 @@ struct extent_map *alloc_extent_map(void)
  * Drop the reference out on @em by one and free the structure if the reference
  * count hits zero.
  */
-void free_extent_map(struct extent_map *em)
+void btrfs_free_extent_map(struct extent_map *em)
 {
 	if (!em)
 		return;
@@ -374,7 +374,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 
 			validate_extent_map(fs_info, em);
 			remove_em(inode, merge);
-			free_extent_map(merge);
+			btrfs_free_extent_map(merge);
 		}
 	}
 
@@ -389,7 +389,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 		em->generation = max(em->generation, merge->generation);
 		em->flags |= EXTENT_FLAG_MERGED;
 		remove_em(inode, merge);
-		free_extent_map(merge);
+		btrfs_free_extent_map(merge);
 	}
 }
 
@@ -444,7 +444,7 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
 
 out:
 	write_unlock(&tree->lock);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 
 }
@@ -726,7 +726,7 @@ int btrfs_add_extent_mapping(struct btrfs_inode *inode,
 		 */
 		if (start >= existing->start &&
 		    start < btrfs_extent_map_end(existing)) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			*em_in = existing;
 			ret = 0;
 		} else {
@@ -739,14 +739,14 @@ int btrfs_add_extent_mapping(struct btrfs_inode *inode,
 			 */
 			ret = merge_extent_mapping(inode, existing, em, start);
 			if (WARN_ON(ret)) {
-				free_extent_map(em);
+				btrfs_free_extent_map(em);
 				*em_in = NULL;
 				btrfs_warn(fs_info,
 "extent map merge error existing [%llu, %llu) with em [%llu, %llu) start %llu",
 					   existing->start, btrfs_extent_map_end(existing),
 					   orig_start, orig_start + orig_len, start);
 			}
-			free_extent_map(existing);
+			btrfs_free_extent_map(existing);
 		}
 	}
 
@@ -773,7 +773,7 @@ static void drop_all_extent_maps_fast(struct btrfs_inode *inode)
 		em = rb_entry(node, struct extent_map, rb_node);
 		em->flags &= ~(EXTENT_FLAG_PINNED | EXTENT_FLAG_LOGGING);
 		remove_extent_mapping(inode, em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 
 		if (cond_resched_rwlock_write(&tree->lock))
 			node = rb_first(&tree->root);
@@ -826,8 +826,8 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 	 * range ends after our range (and they might be the same extent map),
 	 * because we need to split those two extent maps at the boundaries.
 	 */
-	split = alloc_extent_map();
-	split2 = alloc_extent_map();
+	split = btrfs_alloc_extent_map();
+	split2 = btrfs_alloc_extent_map();
 
 	write_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, start, len);
@@ -898,7 +898,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			split->generation = gen;
 			split->flags = flags;
 			replace_extent_mapping(inode, em, split, modified);
-			free_extent_map(split);
+			btrfs_free_extent_map(split);
 			split = split2;
 			split2 = NULL;
 		}
@@ -936,7 +936,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 				if (WARN_ON(ret != 0) && modified)
 					btrfs_set_inode_full_sync(inode);
 			}
-			free_extent_map(split);
+			btrfs_free_extent_map(split);
 			split = NULL;
 		}
 remove_em:
@@ -972,18 +972,18 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 		 * Once for the tree reference (we replaced or removed the
 		 * extent map from the tree).
 		 */
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 next:
 		/* Once for us (for our lookup reference). */
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 
 		em = next_em;
 	}
 
 	write_unlock(&em_tree->lock);
 
-	free_extent_map(split);
-	free_extent_map(split2);
+	btrfs_free_extent_map(split);
+	btrfs_free_extent_map(split2);
 }
 
 /*
@@ -1046,10 +1046,10 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	ASSERT(pre != 0);
 	ASSERT(pre < len);
 
-	split_pre = alloc_extent_map();
+	split_pre = btrfs_alloc_extent_map();
 	if (!split_pre)
 		return -ENOMEM;
-	split_mid = alloc_extent_map();
+	split_mid = btrfs_alloc_extent_map();
 	if (!split_mid) {
 		ret = -ENOMEM;
 		goto out_free_pre;
@@ -1102,16 +1102,16 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	add_extent_mapping(inode, split_mid, 1);
 
 	/* Once for us */
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	/* Once for the tree */
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 out_unlock:
 	write_unlock(&em_tree->lock);
 	btrfs_unlock_extent(&inode->io_tree, start, start + len - 1, NULL);
-	free_extent_map(split_mid);
+	btrfs_free_extent_map(split_mid);
 out_free_pre:
-	free_extent_map(split_pre);
+	btrfs_free_extent_map(split_pre);
 	return ret;
 }
 
@@ -1171,7 +1171,7 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, struct btrfs_em_shrink_c
 		remove_extent_mapping(inode, em);
 		trace_btrfs_extent_map_shrinker_remove_em(inode, em);
 		/* Drop the reference for the tree. */
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		nr_dropped++;
 next:
 		if (ctx->scanned >= ctx->nr_to_scan)
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index de7d14fbaee2..890ea53a92d2 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -174,8 +174,8 @@ void remove_extent_mapping(struct btrfs_inode *inode, struct extent_map *em);
 int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 		     u64 new_logical);
 
-struct extent_map *alloc_extent_map(void);
-void free_extent_map(struct extent_map *em);
+struct extent_map *btrfs_alloc_extent_map(void);
+void btrfs_free_extent_map(struct extent_map *em);
 int __init extent_map_init(void);
 void __cold extent_map_exit(void);
 int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index b5f262536bc5..225877bada65 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2104,7 +2104,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 out:
 	btrfs_release_path(path);
 
-	hole_em = alloc_extent_map();
+	hole_em = btrfs_alloc_extent_map();
 	if (!hole_em) {
 		btrfs_drop_extent_map_range(inode, offset, end - 1, false);
 		btrfs_set_inode_full_sync(inode);
@@ -2118,7 +2118,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 		hole_em->generation = trans->transid;
 
 		ret = btrfs_replace_extent_map_range(inode, hole_em, true);
-		free_extent_map(hole_em);
+		btrfs_free_extent_map(hole_em);
 		if (ret)
 			btrfs_set_inode_full_sync(inode);
 	}
@@ -2151,7 +2151,7 @@ static int find_first_non_hole(struct btrfs_inode *inode, u64 *start, u64 *len)
 		       0 : *start + *len - em->start - em->len;
 		*start = em->start + em->len;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -2858,7 +2858,7 @@ static int btrfs_zero_range_check_range_boundary(struct btrfs_inode *inode,
 	else
 		ret = RANGE_BOUNDARY_WRITTEN_EXTENT;
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -2902,7 +2902,7 @@ static int btrfs_zero_range(struct inode *inode,
 			 * do nothing except updating the inode's i_size if
 			 * needed.
 			 */
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			ret = btrfs_fallocate_update_isize(inode, offset + len,
 							   mode);
 			goto out;
@@ -2917,7 +2917,7 @@ static int btrfs_zero_range(struct inode *inode,
 		offset = alloc_start;
 		alloc_hint = btrfs_extent_map_block_start(em) + em->len;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	if (BTRFS_BYTES_TO_BLKS(fs_info, offset) ==
 	    BTRFS_BYTES_TO_BLKS(fs_info, offset + len - 1)) {
@@ -2928,13 +2928,13 @@ static int btrfs_zero_range(struct inode *inode,
 		}
 
 		if (em->flags & EXTENT_FLAG_PREALLOC) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			ret = btrfs_fallocate_update_isize(inode, offset + len,
 							   mode);
 			goto out;
 		}
 		if (len < sectorsize && em->disk_bytenr != EXTENT_MAP_HOLE) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			ret = btrfs_truncate_block(BTRFS_I(inode), offset, len,
 						   0);
 			if (!ret)
@@ -2943,7 +2943,7 @@ static int btrfs_zero_range(struct inode *inode,
 								   mode);
 			return ret;
 		}
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		alloc_start = round_down(offset, sectorsize);
 		alloc_end = alloc_start + sectorsize;
 		goto reserve_space;
@@ -3153,19 +3153,19 @@ static long btrfs_fallocate(struct file *file, int mode,
 
 			ret = add_falloc_range(&reserve_list, cur_offset, range_len);
 			if (ret < 0) {
-				free_extent_map(em);
+				btrfs_free_extent_map(em);
 				break;
 			}
 			ret = btrfs_qgroup_reserve_data(BTRFS_I(inode),
 					&data_reserved, cur_offset, range_len);
 			if (ret < 0) {
-				free_extent_map(em);
+				btrfs_free_extent_map(em);
 				break;
 			}
 			qgroup_reserved += range_len;
 			data_space_needed += range_len;
 		}
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		cur_offset = last_byte;
 	}
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3a9877ee91b7..a73691e4a668 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1148,7 +1148,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 		ret = PTR_ERR(em);
 		goto out_free_reserve;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
 					     1 << BTRFS_ORDERED_COMPRESSED);
@@ -1211,15 +1211,15 @@ u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
 		 * block is also bogus then just don't worry about it.
 		 */
 		if (em->disk_bytenr >= EXTENT_MAP_LAST_BYTE) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			em = search_extent_mapping(em_tree, 0, 0);
 			if (em && em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
 				alloc_hint = btrfs_extent_map_block_start(em);
 			if (em)
-				free_extent_map(em);
+				btrfs_free_extent_map(em);
 		} else {
 			alloc_hint = btrfs_extent_map_block_start(em);
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 		}
 	}
 	read_unlock(&em_tree->lock);
@@ -1393,7 +1393,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			ret = PTR_ERR(em);
 			goto out_reserve;
 		}
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 
 		ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
 						     1 << BTRFS_ORDERED_REGULAR);
@@ -1971,7 +1971,7 @@ static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio
 			btrfs_unlock_extent(&inode->io_tree, file_pos, end, cached);
 			return PTR_ERR(em);
 		}
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 
 	ordered = btrfs_alloc_ordered_extent(inode, file_pos, &nocow_args->file_extent,
@@ -2679,7 +2679,7 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
 					   EXTENT_DELALLOC_NEW, cached_state);
 next:
 		search_start = btrfs_extent_map_end(em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		if (ret)
 			return ret;
 	}
@@ -5021,7 +5021,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 			if (ret)
 				break;
 
-			hole_em = alloc_extent_map();
+			hole_em = btrfs_alloc_extent_map();
 			if (!hole_em) {
 				btrfs_drop_extent_map_range(inode, cur_offset,
 						    cur_offset + hole_size - 1,
@@ -5038,7 +5038,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 			hole_em->generation = btrfs_get_fs_generation(fs_info);
 
 			ret = btrfs_replace_extent_map_range(inode, hole_em, true);
-			free_extent_map(hole_em);
+			btrfs_free_extent_map(hole_em);
 		} else {
 			ret = btrfs_inode_set_file_extent_range(inode,
 							cur_offset, hole_size);
@@ -5046,13 +5046,13 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 				break;
 		}
 next:
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 		cur_offset = last_byte;
 		if (cur_offset >= block_end)
 			break;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	btrfs_unlock_extent(io_tree, hole_start, block_end - 1, &cached_state);
 	return ret;
 }
@@ -6872,13 +6872,13 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 
 	if (em) {
 		if (em->start > start || em->start + em->len <= start)
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 		else if (em->disk_bytenr == EXTENT_MAP_INLINE && folio)
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 		else
 			goto out;
 	}
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		ret = -ENOMEM;
 		goto out;
@@ -7032,7 +7032,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	trace_btrfs_get_extent(root, inode, em);
 
 	if (ret) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		return ERR_PTR(ret);
 	}
 	return em;
@@ -7204,7 +7204,7 @@ struct extent_map *btrfs_create_io_em(struct btrfs_inode *inode, u64 start,
 		break;
 	}
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em)
 		return ERR_PTR(-ENOMEM);
 
@@ -7221,11 +7221,11 @@ struct extent_map *btrfs_create_io_em(struct btrfs_inode *inode, u64 start,
 
 	ret = btrfs_replace_extent_map_range(inode, em, true);
 	if (ret) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		return ERR_PTR(ret);
 	}
 
-	/* em got 2 refs now, callers needs to do free_extent_map once. */
+	/* em got 2 refs now, callers needs to do btrfs_free_extent_map once. */
 	return em;
 }
 
@@ -8880,7 +8880,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 			break;
 		}
 
-		em = alloc_extent_map();
+		em = btrfs_alloc_extent_map();
 		if (!em) {
 			btrfs_drop_extent_map_range(BTRFS_I(inode), cur_offset,
 					    cur_offset + ins.offset - 1, false);
@@ -8898,7 +8898,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		em->generation = trans->transid;
 
 		ret = btrfs_replace_extent_map_range(BTRFS_I(inode), em, true);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 next:
 		num_bytes -= ins.offset;
 		cur_offset += ins.offset;
@@ -9402,7 +9402,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 		 * For inline extents we get everything we need out of the
 		 * extent item.
 		 */
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 		ret = btrfs_encoded_read_inline(iocb, iter, start, lockend,
 						cached_state, extent_start,
@@ -9455,7 +9455,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 		encoded->unencoded_len = count;
 		*disk_io_size = ALIGN(*disk_io_size, fs_info->sectorsize);
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	em = NULL;
 
 	if (*disk_bytenr == EXTENT_MAP_HOLE) {
@@ -9471,7 +9471,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 	}
 
 out_em:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out_unlock_extent:
 	/* Leave inode and extent locked if we need to do a read. */
 	if (!unlocked && ret != -EIOCBQUEUED)
@@ -9679,7 +9679,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 		ret = PTR_ERR(em);
 		goto out_free_reserved;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
 				       (1 << BTRFS_ORDERED_ENCODED) |
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4bfc5403cf17..6ba9fcb53c33 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2764,7 +2764,7 @@ static noinline_for_stack int setup_relocation_extent_mapping(struct reloc_contr
 	u64 end = rc->cluster.end - offset;
 	int ret = 0;
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em)
 		return -ENOMEM;
 
@@ -2778,7 +2778,7 @@ static noinline_for_stack int setup_relocation_extent_mapping(struct reloc_contr
 	btrfs_lock_extent(&inode->io_tree, start, end, &cached_state);
 	ret = btrfs_replace_extent_map_range(inode, em, false);
 	btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	return ret;
 }
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 2c3cfa9479ab..3b7487c032d4 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -36,7 +36,7 @@ static int free_extent_map_tree(struct btrfs_inode *inode)
 			refcount_set(&em->refs, 1);
 		}
 #endif
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 	write_unlock(&em_tree->lock);
 
@@ -68,7 +68,7 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	int ret;
 	int ret2;
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		return -ENOMEM;
@@ -87,10 +87,10 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		test_err("cannot add extent range [0, 16K)");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Add [16K, 20K) following [0, 16K)  */
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		ret = -ENOMEM;
@@ -109,9 +109,9 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		test_err("cannot add extent range [16K, 20K)");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		ret = -ENOMEM;
@@ -145,7 +145,7 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 			 em->disk_bytenr, em->disk_num_bytes);
 		ret = -EINVAL;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out:
 	ret2 = free_extent_map_tree(inode);
 	if (ret == 0)
@@ -167,7 +167,7 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	int ret;
 	int ret2;
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		return -ENOMEM;
@@ -186,10 +186,10 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		test_err("cannot add extent range [0, 1K)");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Add [4K, 8K) following [0, 1K)  */
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		ret = -ENOMEM;
@@ -208,9 +208,9 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		test_err("cannot add extent range [4K, 8K)");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		ret = -ENOMEM;
@@ -242,7 +242,7 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 			 ret, em->start, em->len, em->disk_bytenr);
 		ret = -EINVAL;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out:
 	ret2 = free_extent_map_tree(inode);
 	if (ret == 0)
@@ -260,7 +260,7 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 	int ret;
 	int ret2;
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		return -ENOMEM;
@@ -279,9 +279,9 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 		test_err("cannot add extent range [4K, 8K)");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		ret = -ENOMEM;
@@ -320,7 +320,7 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 			 em->disk_bytenr, em->disk_num_bytes);
 		ret = -EINVAL;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out:
 	ret2 = free_extent_map_tree(inode);
 	if (ret == 0)
@@ -369,7 +369,7 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	int ret;
 	int ret2;
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		return -ENOMEM;
@@ -388,9 +388,9 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 		test_err("cannot add extent range [0, 8K)");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		ret = -ENOMEM;
@@ -410,9 +410,9 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 		test_err("cannot add extent range [8K, 32K)");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		ret = -ENOMEM;
@@ -445,7 +445,7 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 			 em->disk_bytenr, em->disk_num_bytes);
 		ret = -EINVAL;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out:
 	ret2 = free_extent_map_tree(inode);
 	if (ret == 0)
@@ -498,7 +498,7 @@ static int add_compressed_extent(struct btrfs_inode *inode,
 	struct extent_map *em;
 	int ret;
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		return -ENOMEM;
@@ -513,7 +513,7 @@ static int add_compressed_extent(struct btrfs_inode *inode,
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	if (ret < 0) {
 		test_err("cannot add extent map [%llu, %llu)", start, start + len);
 		return ret;
@@ -719,7 +719,7 @@ static int test_case_6(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	if (ret)
 		goto out;
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		ret = -ENOMEM;
@@ -751,7 +751,7 @@ static int test_case_6(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	}
 	ret = 0;
 out:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	ret2 = free_extent_map_tree(inode);
 	if (ret == 0)
 		ret = ret2;
@@ -773,7 +773,7 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 
 	test_msg("Running btrfs_drop_extent_cache with pinned");
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		return -ENOMEM;
@@ -793,9 +793,9 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		test_err("couldn't add extent map");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		ret = -ENOMEM;
@@ -815,7 +815,7 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		test_err("couldn't add extent map");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/*
 	 * Drop [0, 36K) This should skip the [0, 4K) extent and then split the
@@ -842,7 +842,7 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		goto out;
 	}
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	read_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, SZ_16K, SZ_16K);
@@ -876,7 +876,7 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		goto out;
 	}
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	read_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, 48 * SZ_1K, (u64)-1);
@@ -888,7 +888,7 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 
 	ret = 0;
 out:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	/* Unpin our extent to prevent warning when removing it below. */
 	ret2 = unpin_extent_cache(inode, 0, SZ_16K, 0);
 	if (ret == 0)
@@ -913,7 +913,7 @@ static int test_case_8(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	int ret;
 	int ret2;
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		return -ENOMEM;
@@ -928,13 +928,13 @@ static int test_case_8(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	if (ret < 0) {
 		test_err("couldn't add extent map for range [120K, 128K)");
 		goto out;
 	}
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		ret = -ENOMEM;
@@ -967,7 +967,7 @@ static int test_case_8(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(inode, &em, SZ_1K * 140, SZ_4K);
 	write_unlock(&em_tree->lock);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	if (ret < 0) {
 		test_err("couldn't add extent map for range [108K, 144K)");
 		goto out;
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index 1e2118e96ba1..a29d2c02c2c8 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -268,7 +268,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("expected a hole, got %llu", em->disk_bytenr);
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	btrfs_drop_extent_map_range(BTRFS_I(inode), 0, (u64)-1, false);
 
 	/*
@@ -314,7 +314,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	 * this?
 	 */
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -336,7 +336,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Regular extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
@@ -363,7 +363,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* The next 3 are split extents */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
@@ -392,7 +392,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	disk_bytenr = btrfs_extent_map_block_start(em);
 	orig_start = em->start;
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -414,7 +414,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -447,7 +447,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Prealloc extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
@@ -475,7 +475,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* The next 3 are a half written prealloc extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
@@ -505,7 +505,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	disk_bytenr = btrfs_extent_map_block_start(em);
 	orig_start = em->start;
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -537,7 +537,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -570,7 +570,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Now for the compressed extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
@@ -603,7 +603,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Split compressed extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
@@ -638,7 +638,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	disk_bytenr = btrfs_extent_map_block_start(em);
 	orig_start = em->start;
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -664,7 +664,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -698,7 +698,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* A hole between regular extents but no hole extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset + 6, sectorsize);
@@ -725,7 +725,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, SZ_4M);
 	if (IS_ERR(em)) {
@@ -757,7 +757,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -785,7 +785,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	ret = 0;
 out:
 	if (!IS_ERR(em))
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	iput(inode);
 	btrfs_free_dummy_root(root);
 	btrfs_free_dummy_fs_info(fs_info);
@@ -858,7 +858,7 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 			 em->flags);
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, sectorsize, 2 * sectorsize);
 	if (IS_ERR(em)) {
@@ -884,7 +884,7 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 	ret = 0;
 out:
 	if (!IS_ERR(em))
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	iput(inode);
 	btrfs_free_dummy_root(root);
 	btrfs_free_dummy_fs_info(fs_info);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 88ef4b9c2c1f..3d20473a4bc3 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4957,7 +4957,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 		 */
 		if (ret) {
 			clear_em_logging(inode, em);
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			continue;
 		}
 
@@ -4966,7 +4966,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 		ret = log_one_extent(trans, inode, em, path, ctx);
 		write_lock(&tree->lock);
 		clear_em_logging(inode, em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 	WARN_ON(!list_empty(&extents));
 	write_unlock(&tree->lock);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 7c502192cd6b..20806f15ceaa 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1788,7 +1788,7 @@ static void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered,
 	/* The em should be a new COW extent, thus it should not have an offset. */
 	ASSERT(em->offset == 0);
 	em->disk_bytenr = logical;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	write_unlock(&em_tree->lock);
 }
 
-- 
2.45.2


