Return-Path: <linux-btrfs+bounces-20630-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 234E5D300F2
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 12:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB672305BD26
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 11:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82BE3644C8;
	Fri, 16 Jan 2026 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctUupbUT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC90362147
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768561385; cv=none; b=lyrOoE8Y8ZPW8oIFifEzUdRAQUpNpRgoVBAwjglsnFpOB3E/38P8PS4EvllWj9El2cA2nFC8ibtxNz2yY91y7ZaY9vHDMI44bTgl0K/zKuuO+ix/6yTAwGyBNesPUrxITvG3TOdPgTT+x+6BIvsNOJIUTVCA+RBKi+/xfx43mLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768561385; c=relaxed/simple;
	bh=fVoBbzrYzgQiiyMpUagzKpXqUNRErzuLrgzJU8gkdkU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Zm1vpOHU3F2c9oND5ZGdjfTO24zSCotkdwuKmXIZpo+ROBtI8lykWU149OSIm0oEUxM1Mke1h9lRjGn5eXS7zUTutfHBVB16eW+6JYHCHrZUYNKwvNr0tX7Xd8L2RQDgLUv0iJmhqH1LA+wYpk/qe899Q9vPSJ5XLcG0loaCJt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctUupbUT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5767BC116C6
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 11:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768561384;
	bh=fVoBbzrYzgQiiyMpUagzKpXqUNRErzuLrgzJU8gkdkU=;
	h=From:To:Subject:Date:From;
	b=ctUupbUTnlJ2ZsDdM/lBbE7YnjHphjifJDkndLAiZXey040umbuamEyL/BdCvLvP6
	 pYgOt3xBa60OOgVFL23x5vo7ygSU3a9+7p9YJ/TZwZU2C+zJod5UFT/CDGAFbkKcTV
	 3sfwI36OSgaVj2nrhkYWGYHNr8hYMyX0T7HvO3E6ZBC2L2O79xbvP+D4ik7U/WFE/M
	 yCmgqTUUyJ6YPf88p9+N6i1WImQ4XmyjBBEwlMav/E7SvxAghadgePU0WcpIApQEJl
	 c4xle6tCYGwMIhyUzXqbctNTHtgqPkCZdBbNQ4L5fU2QmncrwTjKlRjgekxMWIc1Aj
	 CDWIxQCIIhKcA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use the btrfs_extent_map_end() helper everywhere
Date: Fri, 16 Jan 2026 11:03:02 +0000
Message-ID: <69ddaceff63e94c5c1b94f12c52a83a798a9f037.1768561288.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have a helper to calculate an extent map's exclusive end offset, but
we only use it in some places. Update every site that open codes the
calculation to use the helper.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/compression.c       |  2 +-
 fs/btrfs/defrag.c            |  5 +++--
 fs/btrfs/extent_io.c         |  2 +-
 fs/btrfs/file.c              |  9 +++++----
 fs/btrfs/inode.c             |  2 +-
 fs/btrfs/tests/inode-tests.c | 32 ++++++++++++++++----------------
 fs/btrfs/tree-log.c          |  2 +-
 7 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 4323d4172c7b..4c6298cf01b2 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -519,7 +519,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 			folio_put(folio);
 			break;
 		}
-		add_size = min(em->start + em->len, page_end + 1) - cur;
+		add_size = min(btrfs_extent_map_end(em), page_end + 1) - cur;
 		btrfs_free_extent_map(em);
 		btrfs_unlock_extent(tree, cur, page_end, NULL);
 
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index bcc6656ad034..ecf05cd64696 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -792,10 +792,11 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct extent_map *next;
+	const u64 em_end = btrfs_extent_map_end(em);
 	bool ret = false;
 
 	/* This is the last extent */
-	if (em->start + em->len >= i_size_read(inode))
+	if (em_end >= i_size_read(inode))
 		return false;
 
 	/*
@@ -804,7 +805,7 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
 	 * one will not be a target.
 	 * This will just cause extra IO without really reducing the fragments.
 	 */
-	next = defrag_lookup_extent(inode, em->start + em->len, newer_than, locked);
+	next = defrag_lookup_extent(inode, em_end, newer_than, locked);
 	/* No more em or hole */
 	if (!next || next->disk_bytenr >= EXTENT_MAP_LAST_BYTE)
 		goto out;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bbc55873cb16..cd8c505d92f5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -970,7 +970,7 @@ static void btrfs_readahead_expand(struct readahead_control *ractl,
 {
 	const u64 ra_pos = readahead_pos(ractl);
 	const u64 ra_end = ra_pos + readahead_length(ractl);
-	const u64 em_end = em->start + em->len;
+	const u64 em_end = btrfs_extent_map_end(em);
 
 	/* No expansion for holes and inline extents. */
 	if (em->disk_bytenr > EXTENT_MAP_LAST_BYTE)
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 5d47cff5af42..1759776d2d57 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2195,10 +2195,11 @@ static int find_first_non_hole(struct btrfs_inode *inode, u64 *start, u64 *len)
 
 	/* Hole or vacuum extent(only exists in no-hole mode) */
 	if (em->disk_bytenr == EXTENT_MAP_HOLE) {
+		const u64 em_end = btrfs_extent_map_end(em);
+
 		ret = 1;
-		*len = em->start + em->len > *start + *len ?
-		       0 : *start + *len - em->start - em->len;
-		*start = em->start + em->len;
+		*len = (em_end > *start + *len) ? 0 : (*start + *len - em_end);
+		*start = em_end;
 	}
 	btrfs_free_extent_map(em);
 	return ret;
@@ -2947,7 +2948,7 @@ static int btrfs_zero_range(struct inode *inode,
 	 * new prealloc extent, so that we get a larger contiguous disk extent.
 	 */
 	if (em->start <= alloc_start && (em->flags & EXTENT_FLAG_PREALLOC)) {
-		const u64 em_end = em->start + em->len;
+		const u64 em_end = btrfs_extent_map_end(em);
 
 		if (em_end >= offset + len) {
 			/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index be47aa58e944..7a28b947f4a3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7161,7 +7161,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	read_unlock(&em_tree->lock);
 
 	if (em) {
-		if (em->start > start || em->start + em->len <= start)
+		if (em->start > start || btrfs_extent_map_end(em) <= start)
 			btrfs_free_extent_map(em);
 		else if (em->disk_bytenr == EXTENT_MAP_INLINE && folio)
 			btrfs_free_extent_map(em);
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index a4c2b7748b95..6bd17d059ae6 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -313,7 +313,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	 * unless we have a page for it to write into.  Maybe we should change
 	 * this?
 	 */
-	offset = em->start + em->len;
+	offset = btrfs_extent_map_end(em);
 	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
@@ -335,7 +335,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("unexpected flags set, want 0 have %u", em->flags);
 		goto out;
 	}
-	offset = em->start + em->len;
+	offset = btrfs_extent_map_end(em);
 	btrfs_free_extent_map(em);
 
 	/* Regular extent */
@@ -362,7 +362,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("wrong offset, want 0, have %llu", em->offset);
 		goto out;
 	}
-	offset = em->start + em->len;
+	offset = btrfs_extent_map_end(em);
 	btrfs_free_extent_map(em);
 
 	/* The next 3 are split extents */
@@ -391,7 +391,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	}
 	disk_bytenr = btrfs_extent_map_block_start(em);
 	orig_start = em->start;
-	offset = em->start + em->len;
+	offset = btrfs_extent_map_end(em);
 	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
@@ -413,7 +413,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("unexpected flags set, want 0 have %u", em->flags);
 		goto out;
 	}
-	offset = em->start + em->len;
+	offset = btrfs_extent_map_end(em);
 	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
@@ -446,7 +446,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 			 disk_bytenr, btrfs_extent_map_block_start(em));
 		goto out;
 	}
-	offset = em->start + em->len;
+	offset = btrfs_extent_map_end(em);
 	btrfs_free_extent_map(em);
 
 	/* Prealloc extent */
@@ -474,7 +474,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("wrong offset, want 0, have %llu", em->offset);
 		goto out;
 	}
-	offset = em->start + em->len;
+	offset = btrfs_extent_map_end(em);
 	btrfs_free_extent_map(em);
 
 	/* The next 3 are a half written prealloc extent */
@@ -504,7 +504,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	}
 	disk_bytenr = btrfs_extent_map_block_start(em);
 	orig_start = em->start;
-	offset = em->start + em->len;
+	offset = btrfs_extent_map_end(em);
 	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
@@ -536,7 +536,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 			 disk_bytenr + em->offset, btrfs_extent_map_block_start(em));
 		goto out;
 	}
-	offset = em->start + em->len;
+	offset = btrfs_extent_map_end(em);
 	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
@@ -569,7 +569,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 			 disk_bytenr + em->offset, btrfs_extent_map_block_start(em));
 		goto out;
 	}
-	offset = em->start + em->len;
+	offset = btrfs_extent_map_end(em);
 	btrfs_free_extent_map(em);
 
 	/* Now for the compressed extent */
@@ -602,7 +602,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 			 BTRFS_COMPRESS_ZLIB, btrfs_extent_map_compression(em));
 		goto out;
 	}
-	offset = em->start + em->len;
+	offset = btrfs_extent_map_end(em);
 	btrfs_free_extent_map(em);
 
 	/* Split compressed extent */
@@ -637,7 +637,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	}
 	disk_bytenr = btrfs_extent_map_block_start(em);
 	orig_start = em->start;
-	offset = em->start + em->len;
+	offset = btrfs_extent_map_end(em);
 	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
@@ -663,7 +663,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("wrong offset, want 0, have %llu", em->offset);
 		goto out;
 	}
-	offset = em->start + em->len;
+	offset = btrfs_extent_map_end(em);
 	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
@@ -697,7 +697,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 			 BTRFS_COMPRESS_ZLIB, btrfs_extent_map_compression(em));
 		goto out;
 	}
-	offset = em->start + em->len;
+	offset = btrfs_extent_map_end(em);
 	btrfs_free_extent_map(em);
 
 	/* A hole between regular extents but no hole extent */
@@ -724,7 +724,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("wrong offset, want 0, have %llu", em->offset);
 		goto out;
 	}
-	offset = em->start + em->len;
+	offset = btrfs_extent_map_end(em);
 	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, SZ_4M);
@@ -756,7 +756,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("wrong offset, want 0, have %llu", em->offset);
 		goto out;
 	}
-	offset = em->start + em->len;
+	offset = btrfs_extent_map_end(em);
 	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6cffcf0c3e7a..e1bd03ebfd98 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5160,7 +5160,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	if (ctx->logged_before) {
 		drop_args.path = path;
 		drop_args.start = em->start;
-		drop_args.end = em->start + em->len;
+		drop_args.end = btrfs_extent_map_end(em);
 		drop_args.replace_extent = true;
 		drop_args.extent_item_size = sizeof(fi);
 		ret = btrfs_drop_extents(trans, log, inode, &drop_args);
-- 
2.47.2


