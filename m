Return-Path: <linux-btrfs+bounces-10538-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E11169F61F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 10:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC1C67A2201
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 09:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A1519A298;
	Wed, 18 Dec 2024 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RAb8y8hE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RAb8y8hE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FA919993B
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514931; cv=none; b=SaDUdfNLB4A4NSGhSNumVxgRoHOAN5XGCzJrCypWIAyZnIoyXeL3kZMPMmvI6ENJGi1z3ssufa+l2ul2ljvxBgUheqDN5ytNxnwL6tZtsMeABRVMLS04MhRN7FgnteQvVEHnqC8UzOw8mmZ5Gsso/5qfXpYmQTWIl5RNWLls5Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514931; c=relaxed/simple;
	bh=1NxYpO+JGDF24TkZnaWvjrR9wtbvzUfHZXTCOSoRV88=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbM7OHTGfgAeEfg/tE4Bk7DChqMyjChfxHTv8YWUNqyJ+wtsyxFkdsoAqhgvF2+iNJ/ImGwrgvHhQFi7DnhwRBLTwntMep7vAgVrDmv63+7KLaiOELA8SSrnFa3+IAdPlBpCREMzTIxdy6YTofDkdLnzbqXwoKdgIDBpsIhxi1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RAb8y8hE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RAb8y8hE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BFBA22115D
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/bV9y//KnqW3t20XAkwBIB5aR19J+gazNpkeyIT+5dw=;
	b=RAb8y8hE3mJQw0GXIwbPhabJbuA0FbKjsSfn27knAN+701LKfg6CLzW1DUpMCXCnMwf2l6
	PgTbKhLgwOwT+knbMtNHtuLPtKSKLqzW5kBqJDKdcDU+fS6l8sC7u8iKTf7pNd2jnzBvlF
	KitmDCbUAHFPcQ38Hg7TPPZHYchJuY8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=RAb8y8hE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/bV9y//KnqW3t20XAkwBIB5aR19J+gazNpkeyIT+5dw=;
	b=RAb8y8hE3mJQw0GXIwbPhabJbuA0FbKjsSfn27knAN+701LKfg6CLzW1DUpMCXCnMwf2l6
	PgTbKhLgwOwT+knbMtNHtuLPtKSKLqzW5kBqJDKdcDU+fS6l8sC7u8iKTf7pNd2jnzBvlF
	KitmDCbUAHFPcQ38Hg7TPPZHYchJuY8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED664132EA
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0CkiKu2YYmdmSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:05 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 10/18] btrfs: migrate inode.c and btrfs_inode.h to use block size terminology
Date: Wed, 18 Dec 2024 20:11:26 +1030
Message-ID: <aba68f14d64906b8d53927fadd9f8cda8b46ebf0.1734514696.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734514696.git.wqu@suse.com>
References: <cover.1734514696.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BFBA22115D
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

This affects the exported function btrfs_check_sector_csum(), thus also
rename it to btrfs_check_block_csum().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h |   2 +-
 fs/btrfs/inode.c       | 140 ++++++++++++++++++++---------------------
 fs/btrfs/raid56.c      |   6 +-
 fs/btrfs/scrub.c       |   2 +-
 4 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index b2fa33911c28..8ae914aa759d 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -520,7 +520,7 @@ static inline void btrfs_assert_inode_locked(struct btrfs_inode *inode)
 #define CSUM_FMT				"0x%*phN"
 #define CSUM_FMT_VALUE(size, bytes)		size, bytes
 
-int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
+int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 			u32 bio_offset, struct bio_vec *bv);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8a173a24ac05..6f70c88f6f07 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -185,7 +185,7 @@ static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 		btrfs_warn(fs_info,
 "checksum error at logical %llu mirror %u root %llu inode %llu offset %llu length %u links %u (path: %s)",
 			   warn->logical, warn->mirror_num, root, inum, offset,
-			   fs_info->sectorsize, nlink,
+			   fs_info->blocksize, nlink,
 			   (char *)(unsigned long)ipath->fspath->val[i]);
 	}
 
@@ -495,7 +495,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *root = inode->root;
 	struct extent_buffer *leaf;
-	const u32 sectorsize = trans->fs_info->sectorsize;
+	const u32 blocksize = trans->fs_info->blocksize;
 	char *kaddr;
 	unsigned long ptr;
 	struct btrfs_file_extent_item *ei;
@@ -504,18 +504,18 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	u64 i_size;
 
 	/*
-	 * The decompressed size must still be no larger than a sector.  Under
+	 * The decompressed size must still be no larger than a block.  Under
 	 * heavy race, we can have size == 0 passed in, but that shouldn't be a
 	 * big deal and we can continue the insertion.
 	 */
-	ASSERT(size <= sectorsize);
+	ASSERT(size <= blocksize);
 
 	/*
-	 * The compressed size also needs to be no larger than a sector.
+	 * The compressed size also needs to be no larger than a block.
 	 * That's also why we only need one page as the parameter.
 	 */
 	if (compressed_folio)
-		ASSERT(compressed_size <= sectorsize);
+		ASSERT(compressed_size <= blocksize);
 	else
 		ASSERT(compressed_size == 0);
 
@@ -568,11 +568,11 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	btrfs_release_path(path);
 
 	/*
-	 * We align size to sectorsize for inline extents just for simplicity
+	 * We align size to blocksize for inline extents just for simplicity
 	 * sake.
 	 */
 	ret = btrfs_inode_set_file_extent_range(inode, 0,
-					ALIGN(size, root->fs_info->sectorsize));
+					ALIGN(size, root->fs_info->blocksize));
 	if (ret)
 		goto fail;
 
@@ -607,7 +607,7 @@ static bool can_cow_file_range_inline(struct btrfs_inode *inode,
 
 	/*
 	 * Due to the page size limit, for subpage we can only trigger the
-	 * writeback for the dirty sectors of page, that means data writeback
+	 * writeback for the dirty blocks of page, that means data writeback
 	 * is doing more writeback than what we want.
 	 *
 	 * This is especially unexpected for some call sites like fallocate,
@@ -615,11 +615,11 @@ static bool can_cow_file_range_inline(struct btrfs_inode *inode,
 	 * This means we can trigger inline extent even if we didn't want to.
 	 * So here we skip inline extent creation completely.
 	 */
-	if (fs_info->sectorsize != PAGE_SIZE)
+	if (fs_info->blocksize != PAGE_SIZE)
 		return false;
 
-	/* Inline extents are limited to sectorsize. */
-	if (size > fs_info->sectorsize)
+	/* Inline extents are limited to blocksize. */
+	if (size > fs_info->blocksize)
 		return false;
 
 	/* We cannot exceed the maximum inline data size. */
@@ -672,7 +672,7 @@ static noinline int __cow_file_range_inline(struct btrfs_inode *inode,
 
 	drop_args.path = path;
 	drop_args.start = 0;
-	drop_args.end = fs_info->sectorsize;
+	drop_args.end = fs_info->blocksize;
 	drop_args.drop_cache = true;
 	drop_args.replace_extent = true;
 	drop_args.extent_item_size = btrfs_file_extent_calc_inline_size(data_len);
@@ -831,7 +831,7 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
 		return 0;
 	}
 	/*
-	 * Only enable sector perfect compression for experimental builds.
+	 * Only enable block perfect compression for experimental builds.
 	 *
 	 * This is a big feature change for subpage cases, and can hit
 	 * different corner cases, so only limit this feature for
@@ -839,7 +839,7 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
 	 *
 	 * ETA for moving this out of experimental builds is 6.15.
 	 */
-	if (fs_info->sectorsize < PAGE_SIZE &&
+	if (fs_info->blocksize < PAGE_SIZE &&
 	    !IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL)) {
 		if (!PAGE_ALIGNED(start) ||
 		    !PAGE_ALIGNED(end + 1))
@@ -912,7 +912,7 @@ static void compress_file_range(struct btrfs_work *work)
 	struct btrfs_inode *inode = async_chunk->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct address_space *mapping = inode->vfs_inode.i_mapping;
-	u64 blocksize = fs_info->sectorsize;
+	u64 blocksize = fs_info->blocksize;
 	u64 start = async_chunk->start;
 	u64 end = async_chunk->end;
 	u64 actual_end;
@@ -1057,9 +1057,9 @@ static void compress_file_range(struct btrfs_work *work)
 	/*
 	 * One last check to make sure the compression is really a win, compare
 	 * the page count read with the blocks on disk, compression must free at
-	 * least one sector.
+	 * least one block.
 	 */
-	total_in = round_up(total_in, fs_info->sectorsize);
+	total_in = round_up(total_in, fs_info->blocksize);
 	if (total_compressed + blocksize > total_in)
 		goto mark_incompressible;
 
@@ -1334,7 +1334,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	u64 num_bytes;
 	u64 cur_alloc_size = 0;
 	u64 min_alloc_size;
-	u64 blocksize = fs_info->sectorsize;
+	u64 blocksize = fs_info->blocksize;
 	struct btrfs_key ins;
 	struct extent_map *em;
 	unsigned clear_bits;
@@ -1386,7 +1386,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	if (btrfs_is_data_reloc_root(root))
 		min_alloc_size = num_bytes;
 	else
-		min_alloc_size = fs_info->sectorsize;
+		min_alloc_size = fs_info->blocksize;
 
 	while (num_bytes > 0) {
 		struct btrfs_ordered_extent *ordered;
@@ -2868,7 +2868,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 				       u64 qgroup_reserved)
 {
 	struct btrfs_root *root = inode->root;
-	const u64 sectorsize = root->fs_info->sectorsize;
+	const u64 blocksize = root->fs_info->blocksize;
 	struct btrfs_path *path;
 	struct extent_buffer *leaf;
 	struct btrfs_key ins;
@@ -2928,13 +2928,13 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	 * The remaining of the range will be processed when clearning the
 	 * EXTENT_DELALLOC_BIT bit through the ordered extent completion.
 	 */
-	if (file_pos == 0 && !IS_ALIGNED(drop_args.bytes_found, sectorsize)) {
-		u64 inline_size = round_down(drop_args.bytes_found, sectorsize);
+	if (file_pos == 0 && !IS_ALIGNED(drop_args.bytes_found, blocksize)) {
+		u64 inline_size = round_down(drop_args.bytes_found, blocksize);
 
 		inline_size = drop_args.bytes_found - inline_size;
-		btrfs_update_inode_bytes(inode, sectorsize, inline_size);
+		btrfs_update_inode_bytes(inode, blocksize, inline_size);
 		drop_args.bytes_found -= inline_size;
-		num_bytes -= sectorsize;
+		num_bytes -= blocksize;
 	}
 
 	if (update_inode_bytes)
@@ -3267,21 +3267,21 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered)
 }
 
 /*
- * Verify the checksum for a single sector without any extra action that depend
+ * Verify the checksum for a single block without any extra action that depend
  * on the type of I/O.
  */
-int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
+int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected)
 {
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	char *kaddr;
 
-	ASSERT(pgoff + fs_info->sectorsize <= PAGE_SIZE);
+	ASSERT(pgoff + fs_info->blocksize <= PAGE_SIZE);
 
 	shash->tfm = fs_info->csum_shash;
 
 	kaddr = kmap_local_page(page) + pgoff;
-	crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
+	crypto_shash_digest(shash, kaddr, fs_info->blocksize, csum);
 	kunmap_local(kaddr);
 
 	if (memcmp(csum, csum_expected, fs_info->csum_size))
@@ -3290,17 +3290,17 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 }
 
 /*
- * Verify the checksum of a single data sector.
+ * Verify the checksum of a single data block.
  *
  * @bbio:	btrfs_io_bio which contains the csum
- * @dev:	device the sector is on
+ * @dev:	device the block is on
  * @bio_offset:	offset to the beginning of the bio (in bytes)
  * @bv:		bio_vec to check
  *
  * Check if the checksum on a data block is valid.  When a checksum mismatch is
  * detected, report the error and fill the corrupted range with zero.
  *
- * Return %true if the sector is ok or had no checksum to start with, else %false.
+ * Return %true if the block is ok or had no checksum to start with, else %false.
  */
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 			u32 bio_offset, struct bio_vec *bv)
@@ -3312,7 +3312,7 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 	u8 *csum_expected;
 	u8 csum[BTRFS_CSUM_SIZE];
 
-	ASSERT(bv->bv_len == fs_info->sectorsize);
+	ASSERT(bv->bv_len == fs_info->blocksize);
 
 	if (!bbio->csum)
 		return true;
@@ -3326,9 +3326,9 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 		return true;
 	}
 
-	csum_expected = bbio->csum + (bio_offset >> fs_info->sectorsize_bits) *
+	csum_expected = bbio->csum + (bio_offset >> fs_info->blocksize_bits) *
 				fs_info->csum_size;
-	if (btrfs_check_sector_csum(fs_info, bv->bv_page, bv->bv_offset, csum,
+	if (btrfs_check_block_csum(fs_info, bv->bv_page, bv->bv_offset, csum,
 				    csum_expected))
 		goto zeroit;
 	return true;
@@ -3848,7 +3848,7 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 	i_gid_write(inode, btrfs_inode_gid(leaf, inode_item));
 	btrfs_i_size_write(BTRFS_I(inode), btrfs_inode_size(leaf, inode_item));
 	btrfs_inode_set_file_extent_range(BTRFS_I(inode), 0,
-			round_up(i_size_read(inode), fs_info->sectorsize));
+			round_up(i_size_read(inode), fs_info->blocksize));
 
 	inode_set_atime(inode, btrfs_timespec_sec(leaf, &inode_item->atime),
 			btrfs_timespec_nsec(leaf, &inode_item->atime));
@@ -4737,7 +4737,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	struct extent_state *cached_state = NULL;
 	struct extent_changeset *data_reserved = NULL;
 	bool only_release_metadata = false;
-	u32 blocksize = fs_info->sectorsize;
+	u32 blocksize = fs_info->blocksize;
 	pgoff_t index = from >> PAGE_SHIFT;
 	unsigned offset = from & (blocksize - 1);
 	struct folio *folio;
@@ -4931,8 +4931,8 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 	struct extent_io_tree *io_tree = &inode->io_tree;
 	struct extent_map *em = NULL;
 	struct extent_state *cached_state = NULL;
-	u64 hole_start = ALIGN(oldsize, fs_info->sectorsize);
-	u64 block_end = ALIGN(size, fs_info->sectorsize);
+	u64 hole_start = ALIGN(oldsize, fs_info->blocksize);
+	u64 block_end = ALIGN(size, fs_info->blocksize);
 	u64 last_byte;
 	u64 cur_offset;
 	u64 hole_size;
@@ -4961,7 +4961,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 			break;
 		}
 		last_byte = min(extent_map_end(em), block_end);
-		last_byte = ALIGN(last_byte, fs_info->sectorsize);
+		last_byte = ALIGN(last_byte, fs_info->blocksize);
 		hole_size = last_byte - cur_offset;
 
 		if (!(em->flags & EXTENT_FLAG_PREALLOC)) {
@@ -5067,7 +5067,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 
 		if (btrfs_is_zoned(fs_info)) {
 			ret = btrfs_wait_ordered_range(BTRFS_I(inode),
-					ALIGN(newsize, fs_info->sectorsize),
+					ALIGN(newsize, fs_info->blocksize),
 					(u64)-1);
 			if (ret)
 				return ret;
@@ -6949,7 +6949,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		 * Other members are not utilized for inline extents.
 		 */
 		ASSERT(em->disk_bytenr == EXTENT_MAP_INLINE);
-		ASSERT(em->len == fs_info->sectorsize);
+		ASSERT(em->len == fs_info->blocksize);
 
 		ret = read_inline_extent(path, folio);
 		if (ret < 0)
@@ -7095,7 +7095,7 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 		u64 range_end;
 
 		range_end = round_up(offset + nocow_args.file_extent.num_bytes,
-				     root->fs_info->sectorsize) - 1;
+				     root->fs_info->blocksize) - 1;
 		ret = test_range_bit_exists(io_tree, offset, range_end, EXTENT_DELALLOC);
 		if (ret) {
 			ret = -EAGAIN;
@@ -7291,7 +7291,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	/*
 	 * For subpage case, we have call sites like
 	 * btrfs_punch_hole_lock_range() which passes range not aligned to
-	 * sectorsize.
+	 * blocksize.
 	 * If the range doesn't cover the full folio, we don't need to and
 	 * shouldn't clear page extent mapped, as folio->private can still
 	 * record subpage dirty bits for other part of the range.
@@ -7440,7 +7440,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 	struct btrfs_block_rsv *rsv;
 	int ret;
 	struct btrfs_trans_handle *trans;
-	u64 mask = fs_info->sectorsize - 1;
+	u64 mask = fs_info->blocksize - 1;
 	const u64 min_size = btrfs_calc_metadata_size(fs_info, 1);
 
 	if (!skip_writeback) {
@@ -7513,7 +7513,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 	while (1) {
 		struct extent_state *cached_state = NULL;
 		const u64 new_size = inode->vfs_inode.i_size;
-		const u64 lock_start = ALIGN_DOWN(new_size, fs_info->sectorsize);
+		const u64 lock_start = ALIGN_DOWN(new_size, fs_info->blocksize);
 
 		control.new_size = new_size;
 		lock_extent(&inode->io_tree, lock_start, (u64)-1, &cached_state);
@@ -7523,7 +7523,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 		 * block of the extent just the way it is.
 		 */
 		btrfs_drop_extent_map_range(inode,
-					    ALIGN(new_size, fs_info->sectorsize),
+					    ALIGN(new_size, fs_info->blocksize),
 					    (u64)-1, false);
 
 		ret = btrfs_truncate_inode_items(trans, root, &control);
@@ -7829,7 +7829,7 @@ static int btrfs_getattr(struct mnt_idmap *idmap,
 	u64 delalloc_bytes;
 	u64 inode_bytes;
 	struct inode *inode = d_inode(path->dentry);
-	u32 blocksize = btrfs_sb(inode->i_sb)->sectorsize;
+	u32 blocksize = btrfs_sb(inode->i_sb)->blocksize;
 	u32 bi_flags = BTRFS_I(inode)->flags;
 	u32 bi_ro_flags = BTRFS_I(inode)->ro_flags;
 
@@ -8966,13 +8966,13 @@ int btrfs_encoded_io_compression_from_extent(struct btrfs_fs_info *fs_info,
 		return BTRFS_ENCODED_IO_COMPRESSION_ZLIB;
 	case BTRFS_COMPRESS_LZO:
 		/*
-		 * The LZO format depends on the sector size. 64K is the maximum
-		 * sector size that we support.
+		 * The LZO format depends on the block size. 64K is the maximum
+		 * block size that we support.
 		 */
-		if (fs_info->sectorsize < SZ_4K || fs_info->sectorsize > SZ_64K)
+		if (fs_info->blocksize < SZ_4K || fs_info->blocksize > SZ_64K)
 			return -EINVAL;
 		return BTRFS_ENCODED_IO_COMPRESSION_LZO_4K +
-		       (fs_info->sectorsize_bits - 12);
+		       (fs_info->blocksize_bits - 12);
 	case BTRFS_COMPRESS_ZSTD:
 		return BTRFS_ENCODED_IO_COMPRESSION_ZSTD;
 	default:
@@ -9261,7 +9261,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 		btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 		return 0;
 	}
-	start = ALIGN_DOWN(iocb->ki_pos, fs_info->sectorsize);
+	start = ALIGN_DOWN(iocb->ki_pos, fs_info->blocksize);
 	/*
 	 * We don't know how long the extent containing iocb->ki_pos is, but if
 	 * it's compressed we know that it won't be longer than this.
@@ -9374,7 +9374,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 		count = start + *disk_io_size - iocb->ki_pos;
 		encoded->len = count;
 		encoded->unencoded_len = count;
-		*disk_io_size = ALIGN(*disk_io_size, fs_info->sectorsize);
+		*disk_io_size = ALIGN(*disk_io_size, fs_info->blocksize);
 	}
 	free_extent_map(em);
 	em = NULL;
@@ -9437,10 +9437,10 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	case BTRFS_ENCODED_IO_COMPRESSION_LZO_16K:
 	case BTRFS_ENCODED_IO_COMPRESSION_LZO_32K:
 	case BTRFS_ENCODED_IO_COMPRESSION_LZO_64K:
-		/* The sector size must match for LZO. */
+		/* The block size must match for LZO. */
 		if (encoded->compression -
 		    BTRFS_ENCODED_IO_COMPRESSION_LZO_4K + 12 !=
-		    fs_info->sectorsize_bits)
+		    fs_info->blocksize_bits)
 			return -EINVAL;
 		compression = BTRFS_COMPRESS_LZO;
 		break;
@@ -9473,41 +9473,41 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	 * extents.
 	 *
 	 * Note that this is less strict than the current check we have that the
-	 * compressed data must be at least one sector smaller than the
+	 * compressed data must be at least one block smaller than the
 	 * decompressed data. We only want to enforce the weaker requirement
 	 * from old kernels that it is at least one byte smaller.
 	 */
 	if (orig_count >= encoded->unencoded_len)
 		return -EINVAL;
 
-	/* The extent must start on a sector boundary. */
+	/* The extent must start on a block boundary. */
 	start = iocb->ki_pos;
-	if (!IS_ALIGNED(start, fs_info->sectorsize))
+	if (!IS_ALIGNED(start, fs_info->blocksize))
 		return -EINVAL;
 
 	/*
-	 * The extent must end on a sector boundary. However, we allow a write
+	 * The extent must end on a block boundary. However, we allow a write
 	 * which ends at or extends i_size to have an unaligned length; we round
 	 * up the extent size and set i_size to the unaligned end.
 	 */
 	if (start + encoded->len < inode->vfs_inode.i_size &&
-	    !IS_ALIGNED(start + encoded->len, fs_info->sectorsize))
+	    !IS_ALIGNED(start + encoded->len, fs_info->blocksize))
 		return -EINVAL;
 
-	/* Finally, the offset in the unencoded data must be sector-aligned. */
-	if (!IS_ALIGNED(encoded->unencoded_offset, fs_info->sectorsize))
+	/* Finally, the offset in the unencoded data must be block-aligned. */
+	if (!IS_ALIGNED(encoded->unencoded_offset, fs_info->blocksize))
 		return -EINVAL;
 
-	num_bytes = ALIGN(encoded->len, fs_info->sectorsize);
-	ram_bytes = ALIGN(encoded->unencoded_len, fs_info->sectorsize);
+	num_bytes = ALIGN(encoded->len, fs_info->blocksize);
+	ram_bytes = ALIGN(encoded->unencoded_len, fs_info->blocksize);
 	end = start + num_bytes - 1;
 
 	/*
 	 * If the extent cannot be inline, the compressed data on disk must be
-	 * sector-aligned. For convenience, we extend it with zeroes if it
+	 * block-aligned. For convenience, we extend it with zeroes if it
 	 * isn't.
 	 */
-	disk_num_bytes = ALIGN(orig_count, fs_info->sectorsize);
+	disk_num_bytes = ALIGN(orig_count, fs_info->blocksize);
 	nr_folios = DIV_ROUND_UP(disk_num_bytes, PAGE_SIZE);
 	folios = kvcalloc(nr_folios, sizeof(struct folio *), GFP_KERNEL_ACCOUNT);
 	if (!folios)
@@ -9903,7 +9903,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	atomic_inc(&root->nr_swapfiles);
 	spin_unlock(&root->root_item_lock);
 
-	isize = ALIGN_DOWN(inode->i_size, fs_info->sectorsize);
+	isize = ALIGN_DOWN(inode->i_size, fs_info->blocksize);
 
 	lock_extent(io_tree, 0, isize - 1, &cached_state);
 	while (prev_extent_end < isize) {
@@ -10144,9 +10144,9 @@ void btrfs_update_inode_bytes(struct btrfs_inode *inode,
  * Verify that there are no ordered extents for a given file range.
  *
  * @inode:   The target inode.
- * @start:   Start offset of the file range, should be sector size aligned.
+ * @start:   Start offset of the file range, should be block size aligned.
  * @end:     End offset (inclusive) of the file range, its value +1 should be
- *           sector size aligned.
+ *           block size aligned.
  *
  * This should typically be used for cases where we locked an inode's VFS lock in
  * exclusive mode, we have also locked the inode's i_mmap_lock in exclusive mode,
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index cdd373c27784..0c5b19c2d0db 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1589,7 +1589,7 @@ static void verify_bio_data_sectors(struct btrfs_raid_bio *rbio,
 			if (!test_bit(total_sector_nr, rbio->csum_bitmap))
 				continue;
 
-			ret = btrfs_check_sector_csum(fs_info, bvec->bv_page,
+			ret = btrfs_check_block_csum(fs_info, bvec->bv_page,
 				bv_offset, csum_buf, expected_csum);
 			if (ret < 0)
 				set_bit(total_sector_nr, rbio->error_bitmap);
@@ -1814,8 +1814,8 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 	csum_expected = rbio->csum_buf +
 			(stripe_nr * rbio->stripe_nsectors + sector_nr) *
 			fs_info->csum_size;
-	ret = btrfs_check_sector_csum(fs_info, sector->page, sector->pgoff,
-				      csum_buf, csum_expected);
+	ret = btrfs_check_block_csum(fs_info, sector->page, sector->pgoff,
+				     csum_buf, csum_expected);
 	return ret;
 }
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 5cec0875a707..383f0859202d 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -737,7 +737,7 @@ static void scrub_verify_one_block(struct scrub_stripe *stripe, int block_nr)
 		return;
 	}
 
-	ret = btrfs_check_sector_csum(fs_info, page, pgoff, csum_buf, block->csum);
+	ret = btrfs_check_block_csum(fs_info, page, pgoff, csum_buf, block->csum);
 	if (ret < 0) {
 		set_bit(block_nr, &stripe->csum_error_bitmap);
 		set_bit(block_nr, &stripe->error_bitmap);
-- 
2.47.1


