Return-Path: <linux-btrfs+bounces-12880-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6F9A813C0
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 19:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F106D3A572F
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 17:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7F623CF07;
	Tue,  8 Apr 2025 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mocyRABt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD6C23C8D3
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133583; cv=none; b=W1SSFkqqaQqdMKM4NdlNXoEtSiKYEg3uYXi/fYd5oOWyVzP65vmi4KTUhdNgQLWJtq5zV07vXufzBh0AdAZ79FgZmN19+Uo1rHIOoez8Fvasv/GwtJioirlnVg1/3BZqpm9Fi2gFGRrSkyrnLsJg2pnU8qwxxHBu+ZjHPgsaPP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133583; c=relaxed/simple;
	bh=AbwAAhndJAd22wDVfH8wimYEHsDT4r2FC3sZheLxF5k=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pS3DSYfQawuSCzNnqq6b5E1mRdnXsBowTeLL9R5epcMOmahjTPAo7nfc4GKhGv//Gaw3Se+j0Fr45BOkkwH0tLxbUEvP8yTAtXWE53aNM4+hFHC6DwEfgRLb9ee1BD+T6G5yLb+HRiTzeXgAGJ12pNWNi/AOill3M/6YZZzkfUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mocyRABt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22A4C4CEE8
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 17:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744133583;
	bh=AbwAAhndJAd22wDVfH8wimYEHsDT4r2FC3sZheLxF5k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mocyRABthF7Pxh+xgDHDB7cPAJT1VleXOlEac3IIYuuAshr5tcqXfgOHcQTuWPO91
	 CiO66LP1DUrd+R7TRN3vEX12gyoip1z/rc68Z7ScB+d5gNjAcLseMnTC1vg6McBvRv
	 6i1U0+vHjkY2uEkDUjcR2ccIEAdmeDzJI4LUDwROJBKiqLhLNO3U5G4SmGrs1uwFxL
	 bWBRGFdwGmxEFgRwOrDDAAHo+RJh+OUHAejCoSuSY66K5eJjUVaN+C+Um0xYCluHmQ
	 VdCrA+/fQpxGlAqHvfk2a1ANP13R5qtsRFv71af3tSt+1xlvME6V2IlXP7SLa7NZde
	 2lDwakD18eGIA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/6] btrfs: rename exported extent map compression functions
Date: Tue,  8 Apr 2025 18:32:54 +0100
Message-Id: <bee6fad0d6b678134f0691c86f6ff015aa0e25b0.1744130413.git.fdmanana@suse.com>
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
 fs/btrfs/compression.c       |  4 ++--
 fs/btrfs/defrag.c            |  2 +-
 fs/btrfs/direct-io.c         |  2 +-
 fs/btrfs/extent_io.c         |  4 ++--
 fs/btrfs/extent_map.c        | 14 +++++++-------
 fs/btrfs/extent_map.h        | 11 ++++++-----
 fs/btrfs/file-item.c         |  4 ++--
 fs/btrfs/inode.c             |  6 +++---
 fs/btrfs/tests/inode-tests.c | 12 ++++++------
 fs/btrfs/tree-log.c          |  4 ++--
 10 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 1e6ac863f84a..09c7c35554a7 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -588,7 +588,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 		goto out;
 	}
 
-	ASSERT(extent_map_is_compressed(em));
+	ASSERT(btrfs_extent_map_is_compressed(em));
 	compressed_len = em->disk_num_bytes;
 
 	cb = alloc_compressed_bio(inode, file_offset, REQ_OP_READ,
@@ -600,7 +600,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 
 	cb->len = bbio->bio.bi_iter.bi_size;
 	cb->compressed_len = compressed_len;
-	cb->compress_type = extent_map_compression(em);
+	cb->compress_type = btrfs_extent_map_compression(em);
 	cb->orig_bbio = bbio;
 
 	free_extent_map(em);
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index d56815a685be..5909740b2ce9 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -791,7 +791,7 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
 static u32 get_extent_max_capacity(const struct btrfs_fs_info *fs_info,
 				   const struct extent_map *em)
 {
-	if (extent_map_is_compressed(em))
+	if (btrfs_extent_map_is_compressed(em))
 		return BTRFS_MAX_COMPRESSED;
 	return fs_info->max_extent_size;
 }
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index ddfa867ff1e5..045497c8118a 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -474,7 +474,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	 * to buffered IO.  Don't blame me, this is the price we pay for using
 	 * the generic code.
 	 */
-	if (extent_map_is_compressed(em) || em->disk_bytenr == EXTENT_MAP_INLINE) {
+	if (btrfs_extent_map_is_compressed(em) || em->disk_bytenr == EXTENT_MAP_INLINE) {
 		free_extent_map(em);
 		/*
 		 * If we are in a NOWAIT context, return -EAGAIN in order to
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d4142ea950b7..7778feb88b62 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -970,7 +970,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		BUG_ON(extent_map_end(em) <= cur);
 		BUG_ON(end < cur);
 
-		compress_type = extent_map_compression(em);
+		compress_type = btrfs_extent_map_compression(em);
 
 		if (compress_type != BTRFS_COMPRESS_NONE)
 			disk_bytenr = em->disk_bytenr;
@@ -1545,7 +1545,7 @@ static int submit_one_sector(struct btrfs_inode *inode,
 	block_start = extent_map_block_start(em);
 	disk_bytenr = extent_map_block_start(em) + extent_offset;
 
-	ASSERT(!extent_map_is_compressed(em));
+	ASSERT(!btrfs_extent_map_is_compressed(em));
 	ASSERT(block_start != EXTENT_MAP_HOLE);
 	ASSERT(block_start != EXTENT_MAP_INLINE);
 
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 67c724a576ee..ccf69308ffb2 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -188,7 +188,7 @@ static struct rb_node *__tree_search(struct rb_root *root, u64 offset,
 
 static inline u64 extent_map_block_len(const struct extent_map *em)
 {
-	if (extent_map_is_compressed(em))
+	if (btrfs_extent_map_is_compressed(em))
 		return em->disk_num_bytes;
 	return em->len;
 }
@@ -210,7 +210,7 @@ static bool can_merge_extent_map(const struct extent_map *em)
 		return false;
 
 	/* Don't merge compressed extents, we need to know their actual size. */
-	if (extent_map_is_compressed(em))
+	if (btrfs_extent_map_is_compressed(em))
 		return false;
 
 	if (em->flags & EXTENT_FLAG_LOGGING)
@@ -270,8 +270,8 @@ static void merge_ondisk_extents(const struct extent_map *prev, const struct ext
 	u64 new_offset;
 
 	/* @prev and @next should not be compressed. */
-	ASSERT(!extent_map_is_compressed(prev));
-	ASSERT(!extent_map_is_compressed(next));
+	ASSERT(!btrfs_extent_map_is_compressed(prev));
+	ASSERT(!btrfs_extent_map_is_compressed(next));
 
 	/*
 	 * There are two different cases where @prev and @next can be merged.
@@ -327,9 +327,9 @@ static void validate_extent_map(struct btrfs_fs_info *fs_info, struct extent_map
 		if (em->offset + em->len > em->ram_bytes)
 			dump_extent_map(fs_info, "ram_bytes too small", em);
 		if (em->offset + em->len > em->disk_num_bytes &&
-		    !extent_map_is_compressed(em))
+		    !btrfs_extent_map_is_compressed(em))
 			dump_extent_map(fs_info, "disk_num_bytes too small", em);
-		if (!extent_map_is_compressed(em) &&
+		if (!btrfs_extent_map_is_compressed(em) &&
 		    em->ram_bytes != em->disk_num_bytes)
 			dump_extent_map(fs_info,
 		"ram_bytes mismatch with disk_num_bytes for non-compressed em",
@@ -1064,7 +1064,7 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	}
 
 	ASSERT(em->len == len);
-	ASSERT(!extent_map_is_compressed(em));
+	ASSERT(!btrfs_extent_map_is_compressed(em));
 	ASSERT(em->disk_bytenr < EXTENT_MAP_LAST_BYTE);
 	ASSERT(em->flags & EXTENT_FLAG_PINNED);
 	ASSERT(!(em->flags & EXTENT_FLAG_LOGGING));
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index cd123b266b64..6aecb132c874 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -108,8 +108,8 @@ struct extent_map_tree {
 
 struct btrfs_inode;
 
-static inline void extent_map_set_compression(struct extent_map *em,
-					      enum btrfs_compression_type type)
+static inline void btrfs_extent_map_set_compression(struct extent_map *em,
+						    enum btrfs_compression_type type)
 {
 	if (type == BTRFS_COMPRESS_ZLIB)
 		em->flags |= EXTENT_FLAG_COMPRESS_ZLIB;
@@ -119,7 +119,8 @@ static inline void extent_map_set_compression(struct extent_map *em,
 		em->flags |= EXTENT_FLAG_COMPRESS_ZSTD;
 }
 
-static inline enum btrfs_compression_type extent_map_compression(const struct extent_map *em)
+static inline enum btrfs_compression_type btrfs_extent_map_compression(
+						       const struct extent_map *em)
 {
 	if (em->flags & EXTENT_FLAG_COMPRESS_ZLIB)
 		return BTRFS_COMPRESS_ZLIB;
@@ -137,7 +138,7 @@ static inline enum btrfs_compression_type extent_map_compression(const struct ex
  * More efficient way to determine if extent is compressed, instead of using
  * 'extent_map_compression() != BTRFS_COMPRESS_NONE'.
  */
-static inline bool extent_map_is_compressed(const struct extent_map *em)
+static inline bool btrfs_extent_map_is_compressed(const struct extent_map *em)
 {
 	return (em->flags & (EXTENT_FLAG_COMPRESS_ZLIB |
 			     EXTENT_FLAG_COMPRESS_LZO |
@@ -152,7 +153,7 @@ static inline int extent_map_in_tree(const struct extent_map *em)
 static inline u64 extent_map_block_start(const struct extent_map *em)
 {
 	if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE) {
-		if (extent_map_is_compressed(em))
+		if (btrfs_extent_map_is_compressed(em))
 			return em->disk_bytenr;
 		return em->disk_bytenr + em->offset;
 	}
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index c5fb4b357100..827d156a7bd7 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1296,7 +1296,7 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 		em->disk_num_bytes = btrfs_file_extent_disk_num_bytes(leaf, fi);
 		em->offset = btrfs_file_extent_offset(leaf, fi);
 		if (compress_type != BTRFS_COMPRESS_NONE) {
-			extent_map_set_compression(em, compress_type);
+			btrfs_extent_map_set_compression(em, compress_type);
 		} else {
 			/*
 			 * Older kernels can create regular non-hole data
@@ -1316,7 +1316,7 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 		em->start = 0;
 		em->len = fs_info->sectorsize;
 		em->offset = 0;
-		extent_map_set_compression(em, compress_type);
+		btrfs_extent_map_set_compression(em, compress_type);
 	} else {
 		btrfs_err(fs_info,
 			  "unknown file extent item type %d, inode %llu, offset %llu, "
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3a5aebc47458..d9c60bf4a18d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7217,7 +7217,7 @@ struct extent_map *btrfs_create_io_em(struct btrfs_inode *inode, u64 start,
 	em->offset = file_extent->offset;
 	em->flags |= EXTENT_FLAG_PINNED;
 	if (type == BTRFS_ORDERED_COMPRESSED)
-		extent_map_set_compression(em, file_extent->compression);
+		btrfs_extent_map_set_compression(em, file_extent->compression);
 
 	ret = btrfs_replace_extent_map_range(inode, em, true);
 	if (ret) {
@@ -9422,7 +9422,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 		count = min_t(u64, count, encoded->len);
 		encoded->len = count;
 		encoded->unencoded_len = count;
-	} else if (extent_map_is_compressed(em)) {
+	} else if (btrfs_extent_map_is_compressed(em)) {
 		*disk_bytenr = em->disk_bytenr;
 		/*
 		 * Bail if the buffer isn't large enough to return the whole
@@ -9437,7 +9437,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 		encoded->unencoded_len = em->ram_bytes;
 		encoded->unencoded_offset = iocb->ki_pos - (em->start - em->offset);
 		ret = btrfs_encoded_io_compression_from_extent(fs_info,
-							       extent_map_compression(em));
+					       btrfs_extent_map_compression(em));
 		if (ret < 0)
 			goto out_em;
 		encoded->compression = ret;
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index 37b285896af0..6aa0f92f8c02 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -597,9 +597,9 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("wrong offset, want 0, have %llu", em->offset);
 		goto out;
 	}
-	if (extent_map_compression(em) != BTRFS_COMPRESS_ZLIB) {
+	if (btrfs_extent_map_compression(em) != BTRFS_COMPRESS_ZLIB) {
 		test_err("unexpected compress type, wanted %d, got %d",
-			 BTRFS_COMPRESS_ZLIB, extent_map_compression(em));
+			 BTRFS_COMPRESS_ZLIB, btrfs_extent_map_compression(em));
 		goto out;
 	}
 	offset = em->start + em->len;
@@ -630,9 +630,9 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("wrong offset, want 0, have %llu", em->offset);
 		goto out;
 	}
-	if (extent_map_compression(em) != BTRFS_COMPRESS_ZLIB) {
+	if (btrfs_extent_map_compression(em) != BTRFS_COMPRESS_ZLIB) {
 		test_err("unexpected compress type, wanted %d, got %d",
-			 BTRFS_COMPRESS_ZLIB, extent_map_compression(em));
+			 BTRFS_COMPRESS_ZLIB, btrfs_extent_map_compression(em));
 		goto out;
 	}
 	disk_bytenr = extent_map_block_start(em);
@@ -692,9 +692,9 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 			 em->start, em->offset, orig_start);
 		goto out;
 	}
-	if (extent_map_compression(em) != BTRFS_COMPRESS_ZLIB) {
+	if (btrfs_extent_map_compression(em) != BTRFS_COMPRESS_ZLIB) {
 		test_err("unexpected compress type, wanted %d, got %d",
-			 BTRFS_COMPRESS_ZLIB, extent_map_compression(em));
+			 BTRFS_COMPRESS_ZLIB, btrfs_extent_map_compression(em));
 		goto out;
 	}
 	offset = em->start + em->len;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 856ec4431ce2..d5e95ab2c9fd 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4648,7 +4648,7 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 		return 0;
 
 	/* If we're compressed we have to save the entire range of csums. */
-	if (extent_map_is_compressed(em)) {
+	if (btrfs_extent_map_is_compressed(em)) {
 		csum_offset = 0;
 		csum_len = em->disk_num_bytes;
 	} else {
@@ -4703,7 +4703,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 		btrfs_set_stack_file_extent_type(&fi, BTRFS_FILE_EXTENT_REG);
 
 	block_len = em->disk_num_bytes;
-	compress_type = extent_map_compression(em);
+	compress_type = btrfs_extent_map_compression(em);
 	if (compress_type != BTRFS_COMPRESS_NONE) {
 		btrfs_set_stack_file_extent_disk_bytenr(&fi, block_start);
 		btrfs_set_stack_file_extent_disk_num_bytes(&fi, block_len);
-- 
2.45.2


