Return-Path: <linux-btrfs+bounces-10533-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFEB9F61F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 10:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE85189607F
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 09:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7341791F4;
	Wed, 18 Dec 2024 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SDiAXSR1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SDiAXSR1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424F9198E6D
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514925; cv=none; b=f61gfcf0STO92DWUPbPSjw/rjDXPdkNbrxcg3RkEjLfkRb3zvKKjaegF/+KTUIzdflGnFS174DURVKs7cAqzWe1rJSycQI4Q0wTE/Ql6iQELvB6cyGYO+Qwb862sRb/jeZDnFisqGgxPxRzJ9/XOFoAQHbWhvmWDYfzMXjw+6i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514925; c=relaxed/simple;
	bh=d2jafA3tOodVQEIrJP0/d+16GWXeA15OvxNQcodbjOo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHnk/I1mtxE0aeVRfOc4CrFoj2CnEQWC6uP8yoTOuPuqROBCRRNUu8Gc8rDLeU7QRXFIvMvLjBs7mCwWYXSRpqDK78MP7E8JAh5blEWKXhb9FYFAuWzyQ45hyVwvpDHL1JtlBi4IF6/jlb27XbWe3uBWNEMkqPp+iYClP/jePrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SDiAXSR1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SDiAXSR1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7154C1F399
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1AOg0/sfb1GvB+ZS1g++mImtn6Lss1B9VzTyPTOZk+E=;
	b=SDiAXSR13e6aYZxF5YpE5b/2OaICRVAaWEFdHQfPFLVram4FaniXODRGqzWq2dgK+SCDi6
	4xumQkZLf8H9wwrpqxPgyWkeZE631K0o0/Mbmw76cD4BanBij5gPtDORJbfyTtrit+RMTW
	PvGWuMxY+7qavQhaUDSBiL0UCe/qEmc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=SDiAXSR1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1AOg0/sfb1GvB+ZS1g++mImtn6Lss1B9VzTyPTOZk+E=;
	b=SDiAXSR13e6aYZxF5YpE5b/2OaICRVAaWEFdHQfPFLVram4FaniXODRGqzWq2dgK+SCDi6
	4xumQkZLf8H9wwrpqxPgyWkeZE631K0o0/Mbmw76cD4BanBij5gPtDORJbfyTtrit+RMTW
	PvGWuMxY+7qavQhaUDSBiL0UCe/qEmc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E2A9132EA
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mK3LFuiYYmdmSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:00 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 06/18] btrfs: migrate compression related code to use block size terminology
Date: Wed, 18 Dec 2024 20:11:22 +1030
Message-ID: <02dbd122ec14fb9a927e7b4ad2a5a3557a6862df.1734514696.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 7154C1F399
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
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

Straightforward rename from "sector" to "block", except the bio
interface.

Most of them are light user of "sectorsize", but LZO is the exception
because the header format is fully blocksize dependent.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 30 ++++++++--------
 fs/btrfs/lzo.c         | 80 +++++++++++++++++++++---------------------
 fs/btrfs/zlib.c        |  2 +-
 fs/btrfs/zstd.c        |  6 ++--
 4 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 0c4d486c3048..847d5e14cc75 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -378,8 +378,8 @@ void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct compressed_bio *cb;
 
-	ASSERT(IS_ALIGNED(ordered->file_offset, fs_info->sectorsize));
-	ASSERT(IS_ALIGNED(ordered->num_bytes, fs_info->sectorsize));
+	ASSERT(IS_ALIGNED(ordered->file_offset, fs_info->blocksize));
+	ASSERT(IS_ALIGNED(ordered->num_bytes, fs_info->blocksize));
 
 	cb = alloc_compressed_bio(inode, ordered->file_offset,
 				  REQ_OP_WRITE | write_flags,
@@ -405,7 +405,7 @@ void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
  * NOTE: this won't work well for subpage, as for subpage read, we lock the
  * full page then submit bio for each compressed/regular extents.
  *
- * This means, if we have several sectors in the same page points to the same
+ * This means, if we have several blocks in the same page points to the same
  * on-disk compressed data, we will re-read the same extent many times and
  * this function can only help for the next page.
  */
@@ -425,7 +425,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 	struct address_space *mapping = inode->i_mapping;
 	struct extent_map_tree *em_tree;
 	struct extent_io_tree *tree;
-	int sectors_missed = 0;
+	int blocks_missed = 0;
 
 	em_tree = &BTRFS_I(inode)->extent_tree;
 	tree = &BTRFS_I(inode)->io_tree;
@@ -440,7 +440,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 	 * This makes readahead less effective, so here disable readahead for
 	 * subpage for now, until full compressed write is supported.
 	 */
-	if (fs_info->sectorsize < PAGE_SIZE)
+	if (fs_info->blocksize < PAGE_SIZE)
 		return 0;
 
 	end_index = (i_size_read(inode) - 1) >> PAGE_SHIFT;
@@ -459,11 +459,11 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 			u64 offset = offset_in_folio(folio, cur);
 
 			folio_put(folio);
-			sectors_missed += (folio_sz - offset) >>
-					  fs_info->sectorsize_bits;
+			blocks_missed += (folio_sz - offset) >>
+					  fs_info->blocksize_bits;
 
 			/* Beyond threshold, no need to continue */
-			if (sectors_missed > 4)
+			if (blocks_missed > 4)
 				break;
 
 			/*
@@ -510,7 +510,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		 * to this compressed extent on disk.
 		 */
 		if (!em || cur < em->start ||
-		    (cur + fs_info->sectorsize > extent_map_end(em)) ||
+		    (cur + fs_info->blocksize > extent_map_end(em)) ||
 		    (extent_map_block_start(em) >> SECTOR_SHIFT) !=
 		    orig_bio->bi_iter.bi_sector) {
 			free_extent_map(em);
@@ -544,7 +544,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		 * subpage::readers number, as at endio we will decrease
 		 * subpage::readers and to unlock the page.
 		 */
-		if (fs_info->sectorsize < PAGE_SIZE)
+		if (fs_info->blocksize < PAGE_SIZE)
 			btrfs_folio_set_lock(fs_info, folio, cur, add_size);
 		folio_put(folio);
 		cur += add_size;
@@ -581,7 +581,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 
 	/* we need the actual starting offset of this extent in the file */
 	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, file_offset, fs_info->sectorsize);
+	em = lookup_extent_mapping(em_tree, file_offset, fs_info->blocksize);
 	read_unlock(&em_tree->lock);
 	if (!em) {
 		ret = BLK_STS_IOERR;
@@ -1068,15 +1068,15 @@ int btrfs_decompress(int type, const u8 *data_in, struct folio *dest_folio,
 {
 	struct btrfs_fs_info *fs_info = folio_to_fs_info(dest_folio);
 	struct list_head *workspace;
-	const u32 sectorsize = fs_info->sectorsize;
+	const u32 blocksize = fs_info->blocksize;
 	int ret;
 
 	/*
 	 * The full destination page range should not exceed the page size.
-	 * And the @destlen should not exceed sectorsize, as this is only called for
-	 * inline file extents, which should not exceed sectorsize.
+	 * And the @destlen should not exceed blocksize, as this is only called for
+	 * inline file extents, which should not exceed blocksize.
 	 */
-	ASSERT(dest_pgoff + destlen <= PAGE_SIZE && destlen <= sectorsize);
+	ASSERT(dest_pgoff + destlen <= PAGE_SIZE && destlen <= blocksize);
 
 	workspace = get_workspace(type, 0);
 	ret = compression_decompress(type, workspace, data_in, dest_folio,
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index a45bc11f8665..f124a408edf3 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -35,19 +35,19 @@
  *     payload.
  *     One regular LZO compressed extent can have one or more segments.
  *     For inlined LZO compressed extent, only one segment is allowed.
- *     One segment represents at most one sector of uncompressed data.
+ *     One segment represents at most one block of uncompressed data.
  *
  * 2.1 Segment header
  *     Fixed size. LZO_LEN (4) bytes long, LE32.
  *     Records the total size of the segment (not including the header).
- *     Segment header never crosses sector boundary, thus it's possible to
- *     have at most 3 padding zeros at the end of the sector.
+ *     Segment header never crosses block boundary, thus it's possible to
+ *     have at most 3 padding zeros at the end of the block.
  *
  * 2.2 Data Payload
- *     Variable size. Size up limit should be lzo1x_worst_compress(sectorsize)
- *     which is 4419 for a 4KiB sectorsize.
+ *     Variable size. Size up limit should be lzo1x_worst_compress(blocksize)
+ *     which is 4419 for a 4KiB blocksize.
  *
- * Example with 4K sectorsize:
+ * Example with 4K blocksize:
  * Page 1:
  *          0     0x2   0x4   0x6   0x8   0xa   0xc   0xe     0x10
  * 0x0000   |  Header   | SegHdr 01 | Data payload 01 ...     |
@@ -133,9 +133,9 @@ static int copy_compressed_data_to_page(char *compressed_data,
 					struct folio **out_folios,
 					unsigned long max_nr_folio,
 					u32 *cur_out,
-					const u32 sectorsize)
+					const u32 blocksize)
 {
-	u32 sector_bytes_left;
+	u32 block_bytes_left;
 	u32 orig_out;
 	struct folio *cur_folio;
 	char *kaddr;
@@ -144,10 +144,10 @@ static int copy_compressed_data_to_page(char *compressed_data,
 		return -E2BIG;
 
 	/*
-	 * We never allow a segment header crossing sector boundary, previous
-	 * run should ensure we have enough space left inside the sector.
+	 * We never allow a segment header crossing block boundary, previous
+	 * run should ensure we have enough space left inside the block.
 	 */
-	ASSERT((*cur_out / sectorsize) == (*cur_out + LZO_LEN - 1) / sectorsize);
+	ASSERT((*cur_out / blocksize) == (*cur_out + LZO_LEN - 1) / blocksize);
 
 	cur_folio = out_folios[*cur_out / PAGE_SIZE];
 	/* Allocate a new page */
@@ -167,7 +167,7 @@ static int copy_compressed_data_to_page(char *compressed_data,
 
 	/* Copy compressed data */
 	while (*cur_out - orig_out < compressed_size) {
-		u32 copy_len = min_t(u32, sectorsize - *cur_out % sectorsize,
+		u32 copy_len = min_t(u32, blocksize - *cur_out % blocksize,
 				     orig_out + compressed_size - *cur_out);
 
 		kunmap_local(kaddr);
@@ -193,16 +193,16 @@ static int copy_compressed_data_to_page(char *compressed_data,
 
 	/*
 	 * Check if we can fit the next segment header into the remaining space
-	 * of the sector.
+	 * of the block.
 	 */
-	sector_bytes_left = round_up(*cur_out, sectorsize) - *cur_out;
-	if (sector_bytes_left >= LZO_LEN || sector_bytes_left == 0)
+	block_bytes_left = round_up(*cur_out, blocksize) - *cur_out;
+	if (block_bytes_left >= LZO_LEN || block_bytes_left == 0)
 		goto out;
 
 	/* The remaining size is not enough, pad it with zeros */
 	memset(kaddr + offset_in_page(*cur_out), 0,
-	       sector_bytes_left);
-	*cur_out += sector_bytes_left;
+	       block_bytes_left);
+	*cur_out += block_bytes_left;
 
 out:
 	kunmap_local(kaddr);
@@ -214,7 +214,7 @@ int lzo_compress_folios(struct list_head *ws, struct address_space *mapping,
 			unsigned long *total_in, unsigned long *total_out)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
-	const u32 sectorsize = inode_to_fs_info(mapping->host)->sectorsize;
+	const u32 blocksize = inode_to_fs_info(mapping->host)->blocksize;
 	struct folio *folio_in = NULL;
 	char *sizes_ptr;
 	const unsigned long max_nr_folio = *out_folios;
@@ -237,8 +237,8 @@ int lzo_compress_folios(struct list_head *ws, struct address_space *mapping,
 	cur_out += LZO_LEN;
 	while (cur_in < start + len) {
 		char *data_in;
-		const u32 sectorsize_mask = sectorsize - 1;
-		u32 sector_off = (cur_in - start) & sectorsize_mask;
+		const u32 blocksize_mask = blocksize - 1;
+		u32 block_off = (cur_in - start) & blocksize_mask;
 		u32 in_len;
 		size_t out_len;
 
@@ -249,8 +249,8 @@ int lzo_compress_folios(struct list_head *ws, struct address_space *mapping,
 				goto out;
 		}
 
-		/* Compress at most one sector of data each time */
-		in_len = min_t(u32, start + len - cur_in, sectorsize - sector_off);
+		/* Compress at most one block of data each time */
+		in_len = min_t(u32, start + len - cur_in, blocksize - block_off);
 		ASSERT(in_len);
 		data_in = kmap_local_folio(folio_in, 0);
 		ret = lzo1x_1_compress(data_in +
@@ -266,17 +266,17 @@ int lzo_compress_folios(struct list_head *ws, struct address_space *mapping,
 
 		ret = copy_compressed_data_to_page(workspace->cbuf, out_len,
 						   folios, max_nr_folio,
-						   &cur_out, sectorsize);
+						   &cur_out, blocksize);
 		if (ret < 0)
 			goto out;
 
 		cur_in += in_len;
 
 		/*
-		 * Check if we're making it bigger after two sectors.  And if
+		 * Check if we're making it bigger after two blocks.  And if
 		 * it is so, give up.
 		 */
-		if (cur_in - start > sectorsize * 2 && cur_in - start < cur_out) {
+		if (cur_in - start > blocksize * 2 && cur_in - start < cur_out) {
 			ret = -E2BIG;
 			goto out;
 		}
@@ -332,7 +332,7 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	const struct btrfs_fs_info *fs_info = cb->bbio.inode->root->fs_info;
-	const u32 sectorsize = fs_info->sectorsize;
+	const u32 blocksize = fs_info->blocksize;
 	char *kaddr;
 	int ret;
 	/* Compressed data length, can be unaligned */
@@ -351,11 +351,11 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	 * LZO header length check
 	 *
 	 * The total length should not exceed the maximum extent length,
-	 * and all sectors should be used.
+	 * and all blocks should be used.
 	 * If this happens, it means the compressed extent is corrupted.
 	 */
 	if (unlikely(len_in > min_t(size_t, BTRFS_MAX_COMPRESSED, cb->compressed_len) ||
-		     round_up(len_in, sectorsize) < cb->compressed_len)) {
+		     round_up(len_in, blocksize) < cb->compressed_len)) {
 		struct btrfs_inode *inode = cb->bbio.inode;
 
 		btrfs_err(fs_info,
@@ -370,15 +370,15 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		struct folio *cur_folio;
 		/* Length of the compressed segment */
 		u32 seg_len;
-		u32 sector_bytes_left;
-		size_t out_len = lzo1x_worst_compress(sectorsize);
+		u32 block_bytes_left;
+		size_t out_len = lzo1x_worst_compress(blocksize);
 
 		/*
 		 * We should always have enough space for one segment header
-		 * inside current sector.
+		 * inside current block.
 		 */
-		ASSERT(cur_in / sectorsize ==
-		       (cur_in + LZO_LEN - 1) / sectorsize);
+		ASSERT(cur_in / blocksize ==
+		       (cur_in + LZO_LEN - 1) / blocksize);
 		cur_folio = cb->compressed_folios[cur_in / PAGE_SIZE];
 		ASSERT(cur_folio);
 		kaddr = kmap_local_folio(cur_folio, 0);
@@ -425,13 +425,13 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 			return 0;
 		ret = 0;
 
-		/* Check if the sector has enough space for a segment header */
-		sector_bytes_left = sectorsize - (cur_in % sectorsize);
-		if (sector_bytes_left >= LZO_LEN)
+		/* Check if the block has enough space for a segment header */
+		block_bytes_left = blocksize - (cur_in % blocksize);
+		if (block_bytes_left >= LZO_LEN)
 			continue;
 
 		/* Skip the padding zeros */
-		cur_in += sector_bytes_left;
+		cur_in += block_bytes_left;
 	}
 
 	return 0;
@@ -443,7 +443,7 @@ int lzo_decompress(struct list_head *ws, const u8 *data_in,
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	struct btrfs_fs_info *fs_info = folio_to_fs_info(dest_folio);
-	const u32 sectorsize = fs_info->sectorsize;
+	const u32 blocksize = fs_info->blocksize;
 	size_t in_len;
 	size_t out_len;
 	size_t max_segment_len = WORKSPACE_BUF_LENGTH;
@@ -464,7 +464,7 @@ int lzo_decompress(struct list_head *ws, const u8 *data_in,
 	}
 	data_in += LZO_LEN;
 
-	out_len = sectorsize;
+	out_len = blocksize;
 	ret = lzo1x_decompress_safe(data_in, in_len, workspace->buf, &out_len);
 	if (unlikely(ret != LZO_E_OK)) {
 		struct btrfs_inode *inode = folio_to_inode(dest_folio);
@@ -477,7 +477,7 @@ int lzo_decompress(struct list_head *ws, const u8 *data_in,
 		goto out;
 	}
 
-	ASSERT(out_len <= sectorsize);
+	ASSERT(out_len <= blocksize);
 	memcpy_to_folio(dest_folio, dest_pgoff, workspace->buf, out_len);
 	/* Early end, considered as an error. */
 	if (unlikely(out_len < destlen)) {
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index ddf0d5a448a7..aee1a9cd35e6 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -431,7 +431,7 @@ int zlib_decompress(struct list_head *ws, const u8 *data_in,
 	}
 
 	/*
-	 * Everything (in/out buf) should be at most one sector, there should
+	 * Everything (in/out buf) should be at most one block, there should
 	 * be no need to switch any input/output buffer.
 	 */
 	ret = zlib_inflate(&workspace->strm, Z_FINISH);
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 5232b56d5892..0c97e534b490 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -663,7 +663,7 @@ int zstd_decompress(struct list_head *ws, const u8 *data_in,
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	struct btrfs_fs_info *fs_info = btrfs_sb(folio_inode(dest_folio)->i_sb);
-	const u32 sectorsize = fs_info->sectorsize;
+	const u32 blocksize = fs_info->blocksize;
 	zstd_dstream *stream;
 	int ret = 0;
 	unsigned long to_copy = 0;
@@ -687,10 +687,10 @@ int zstd_decompress(struct list_head *ws, const u8 *data_in,
 
 	workspace->out_buf.dst = workspace->buf;
 	workspace->out_buf.pos = 0;
-	workspace->out_buf.size = sectorsize;
+	workspace->out_buf.size = blocksize;
 
 	/*
-	 * Since both input and output buffers should not exceed one sector,
+	 * Since both input and output buffers should not exceed one block,
 	 * one call should end the decompression.
 	 */
 	ret = zstd_decompress_stream(stream, &workspace->out_buf, &workspace->in_buf);
-- 
2.47.1


