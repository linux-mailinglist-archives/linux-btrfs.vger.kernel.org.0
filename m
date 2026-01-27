Return-Path: <linux-btrfs+bounces-21101-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOcnBG0teGl7oQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21101-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 04:13:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCC98F768
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 04:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F2A9301429C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 03:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2882F5492;
	Tue, 27 Jan 2026 03:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kyucdI/+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kyucdI/+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4936187FE4
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 03:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483498; cv=none; b=iuTw+civQs0XTxZrr/Ah+ckk+3lJ0u/iGnJ0nxaqSATPWVLbF69tIMx4oGkg6mgM08cPithPXINGlXz+/++1O7392QVBY3cuqLSH+IHnCGweo8gU1GN5Owg4lGgsDfpmueb4zDe8rx5wVALqtaIHSKhbotjGMdPiebMWPDxFgLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483498; c=relaxed/simple;
	bh=wQbOBIT+VWKhPS6MwiPnKlh5IVUsRS7r38ShMHXNvdY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMUwSP0s+g3RL5W6Ni/RLHcY4xKPiKI8RWWyDGO4+dGQKpbjrDBTtb1y0ToCrUbsMx0PFM5E9cHQ0qVXQhyU7/D16qSM3BDY58uBVlDBj9ew8uDchXXcopeXlvSN9zN14N+ErahWLg86EGGh7+XvI2xBakPcZ+hHRQcw8OI3/I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kyucdI/+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kyucdI/+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 797893379E
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 03:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769483470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saEoPjvvFoe0mdUJDK8phVZsynbmeOSkN8yYAdqzRoQ=;
	b=kyucdI/+JxeVf3gh0Rrqe4Y7ZgkuGFDdiEDQKd+CrazcK7yPHBrqvfsjZP+ZnDhF8971Ip
	vmSb/ULNQGalhb52LApVL8jIyji13rkbqsosqtwWHAFYeFl1p23HpkBL1PhtMvgnqj1Ig9
	lxU7H08Kkqnt8o4Aa2D/OweQcp3jl84=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769483470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saEoPjvvFoe0mdUJDK8phVZsynbmeOSkN8yYAdqzRoQ=;
	b=kyucdI/+JxeVf3gh0Rrqe4Y7ZgkuGFDdiEDQKd+CrazcK7yPHBrqvfsjZP+ZnDhF8971Ip
	vmSb/ULNQGalhb52LApVL8jIyji13rkbqsosqtwWHAFYeFl1p23HpkBL1PhtMvgnqj1Ig9
	lxU7H08Kkqnt8o4Aa2D/OweQcp3jl84=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CF0E13712
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 03:11:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EL6oBs0seGnFewAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 03:11:09 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 5/9] btrfs: switch to btrfs_compress_bio() interface for compressed writes
Date: Tue, 27 Jan 2026 13:40:38 +1030
Message-ID: <0ede658476d5d18894ef9938a509ff89d8485ef4.1769482298.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769482298.git.wqu@suse.com>
References: <cover.1769482298.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21101-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CCC98F768
X-Rspamd-Action: no action

This switch has the following benefits:

- A single structure to handle all compression

  No more extra members like compressed_folios[] nor compress_type, all
  those members.

  This means the structure of async_extent is much smaller.

- Simpler error handling

  A single cleanup_compressed_bio() will handle everything, no extra
  compressed_folios[] array to bother.

Some special notes:

- Compressed folios releasing

  Now we go bio_for_each_folio_all() loop to release the folios of the
  bio. This will work for both the old compressed_folios[] array and the
  new pure bio method.

  For old compressed_folios[], all folios of that array is queued into
  the bio, thus releasing the folios from the bio is the same as
  releasing each folio of that array. We jut need to be sure no double
  releasing from the array and bio.

  For the new pure bio method, that array is NULL, just usual folio
  releasing of the bio.

  The only extra note is for end_bbio_compressed_read(), as the folios
  are allocated using btrfs_alloc_folio_array(), thus the folios should
  only be released by regular folio_put(), not btrfs_free_compr_folio().

- Rounding up the bio to block size

  We can not simply increase bi_size, as that will not increase the
  length of the last bvec.

  Thus we have to properly add the last part into the bio.
  This will be done by the helper, round_up_last_block().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c |  16 ++--
 fs/btrfs/inode.c       | 161 +++++++++++++++++++----------------------
 2 files changed, 83 insertions(+), 94 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 942b85bcacbe..1d4e7c7c25c3 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -155,13 +155,6 @@ static int compression_decompress(int type, struct list_head *ws,
 	}
 }
 
-static void btrfs_free_compressed_folios(struct compressed_bio *cb)
-{
-	for (unsigned int i = 0; i < cb->nr_folios; i++)
-		btrfs_free_compr_folio(cb->compressed_folios[i]);
-	kfree(cb->compressed_folios);
-}
-
 static int btrfs_decompress_bio(struct compressed_bio *cb);
 
 /*
@@ -270,12 +263,14 @@ static void end_bbio_compressed_read(struct btrfs_bio *bbio)
 {
 	struct compressed_bio *cb = to_compressed_bio(bbio);
 	blk_status_t status = bbio->bio.bi_status;
+	struct folio_iter fi;
 
 	if (!status)
 		status = errno_to_blk_status(btrfs_decompress_bio(cb));
 
-	btrfs_free_compressed_folios(cb);
 	btrfs_bio_end_io(cb->orig_bbio, status);
+	bio_for_each_folio_all(fi, &bbio->bio)
+		folio_put(fi.folio);
 	bio_put(&bbio->bio);
 }
 
@@ -326,6 +321,7 @@ static noinline void end_compressed_writeback(const struct compressed_bio *cb)
 static void end_bbio_compressed_write(struct btrfs_bio *bbio)
 {
 	struct compressed_bio *cb = to_compressed_bio(bbio);
+	struct folio_iter fi;
 
 	btrfs_finish_ordered_extent(cb->bbio.ordered, NULL, cb->start, cb->len,
 				    cb->bbio.bio.bi_status == BLK_STS_OK);
@@ -333,7 +329,9 @@ static void end_bbio_compressed_write(struct btrfs_bio *bbio)
 	if (cb->writeback)
 		end_compressed_writeback(cb);
 	/* Note, our inode could be gone now. */
-	btrfs_free_compressed_folios(cb);
+	bio_for_each_folio_all(fi, &bbio->bio)
+		btrfs_free_compr_folio(fi.folio);
+	kfree(cb->compressed_folios);
 	bio_put(&cb->bbio.bio);
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 10609b8199a0..aafffb72dd0e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -755,10 +755,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode,
 struct async_extent {
 	u64 start;
 	u64 ram_size;
-	u64 compressed_size;
-	struct folio **folios;
-	unsigned long nr_folios;
-	int compress_type;
+	struct compressed_bio *cb;
 	struct list_head list;
 };
 
@@ -779,24 +776,19 @@ struct async_cow {
 	struct async_chunk chunks[];
 };
 
-static noinline int add_async_extent(struct async_chunk *cow,
-				     u64 start, u64 ram_size,
-				     u64 compressed_size,
-				     struct folio **folios,
-				     unsigned long nr_folios,
-				     int compress_type)
+static int add_async_extent(struct async_chunk *cow,
+			    u64 start, u64 ram_size,
+			    struct compressed_bio *cb)
 {
 	struct async_extent *async_extent;
 
 	async_extent = kmalloc(sizeof(*async_extent), GFP_NOFS);
 	if (!async_extent)
 		return -ENOMEM;
+	ASSERT(ram_size < U32_MAX);
 	async_extent->start = start;
 	async_extent->ram_size = ram_size;
-	async_extent->compressed_size = compressed_size;
-	async_extent->folios = folios;
-	async_extent->nr_folios = nr_folios;
-	async_extent->compress_type = compress_type;
+	async_extent->cb = cb;
 	list_add_tail(&async_extent->list, &cow->extents);
 	return 0;
 }
@@ -870,6 +862,36 @@ static int extent_range_clear_dirty_for_io(struct btrfs_inode *inode, u64 start,
 	return ret;
 }
 
+static void zero_last_folio(struct compressed_bio *cb)
+{
+	struct bio *bio = &cb->bbio.bio;
+	struct bio_vec *bvec = bio_last_bvec_all(bio);
+	phys_addr_t last_paddr = page_to_phys(bvec->bv_page) + bvec->bv_offset + bvec->bv_len - 1;
+	struct folio *last_folio = page_folio(phys_to_page(last_paddr));
+	const u32 bio_size = bio->bi_iter.bi_size;
+	const u32 foffset = offset_in_folio(last_folio, bio_size);
+
+	folio_zero_range(last_folio, foffset, folio_size(last_folio) - foffset);
+}
+
+static void round_up_last_block(struct compressed_bio *cb, u32 blocksize)
+{
+	struct bio *bio = &cb->bbio.bio;
+	struct bio_vec *bvec = bio_last_bvec_all(bio);
+	phys_addr_t last_paddr = page_to_phys(bvec->bv_page) + bvec->bv_offset + bvec->bv_len - 1;
+	struct folio *last_folio = page_folio(phys_to_page(last_paddr));
+	const u32 bio_size = bio->bi_iter.bi_size;
+	const u32 foffset = offset_in_folio(last_folio, bio_size);
+	bool ret;
+
+	if (IS_ALIGNED(bio_size, blocksize))
+		return;
+
+	ret = bio_add_folio(bio, last_folio, round_up(foffset, blocksize) - foffset, foffset);
+	/* The remaining part should be merged thus never fail. */
+	ASSERT(ret);
+}
+
 /*
  * Work queue call back to started compression on a file and pages.
  *
@@ -890,20 +912,18 @@ static void compress_file_range(struct btrfs_work *work)
 	struct btrfs_inode *inode = async_chunk->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct address_space *mapping = inode->vfs_inode.i_mapping;
-	const u32 min_folio_shift = PAGE_SHIFT + fs_info->block_min_order;
+	struct compressed_bio *cb = NULL;
 	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
 	u64 blocksize = fs_info->sectorsize;
 	u64 start = async_chunk->start;
 	u64 end = async_chunk->end;
 	u64 actual_end;
 	u64 i_size;
+	u32 cur_len;
 	int ret = 0;
-	struct folio **folios = NULL;
-	unsigned long nr_folios;
 	unsigned long total_compressed = 0;
 	unsigned long total_in = 0;
 	unsigned int loff;
-	int i;
 	int compress_type = fs_info->compress_type;
 	int compress_level = fs_info->compress_level;
 
@@ -942,9 +962,10 @@ static void compress_file_range(struct btrfs_work *work)
 	barrier();
 	actual_end = min_t(u64, i_size, end + 1);
 again:
-	folios = NULL;
-	nr_folios = (end >> min_folio_shift) - (start >> min_folio_shift) + 1;
-	nr_folios = min_t(unsigned long, nr_folios, BTRFS_MAX_COMPRESSED >> min_folio_shift);
+	total_in = 0;
+	cur_len = min(end + 1 - start, BTRFS_MAX_UNCOMPRESSED);
+	ret = 0;
+	cb = NULL;
 
 	/*
 	 * we don't want to send crud past the end of i_size through
@@ -959,10 +980,6 @@ static void compress_file_range(struct btrfs_work *work)
 	if (actual_end <= start)
 		goto cleanup_and_bail_uncompressed;
 
-	total_compressed = min_t(unsigned long, actual_end - start, BTRFS_MAX_UNCOMPRESSED);
-	total_in = 0;
-	ret = 0;
-
 	/*
 	 * We do compression for mount -o compress and when the inode has not
 	 * been flagged as NOCOMPRESS.  This flag can change at any time if we
@@ -971,15 +988,6 @@ static void compress_file_range(struct btrfs_work *work)
 	if (!inode_need_compress(inode, start, end))
 		goto cleanup_and_bail_uncompressed;
 
-	folios = kcalloc(nr_folios, sizeof(struct folio *), GFP_NOFS);
-	if (!folios) {
-		/*
-		 * Memory allocation failure is not a fatal error, we can fall
-		 * back to uncompressed code.
-		 */
-		goto cleanup_and_bail_uncompressed;
-	}
-
 	if (0 < inode->defrag_compress && inode->defrag_compress < BTRFS_NR_COMPRESS_TYPES) {
 		compress_type = inode->defrag_compress;
 		compress_level = inode->defrag_compress_level;
@@ -988,11 +996,15 @@ static void compress_file_range(struct btrfs_work *work)
 	}
 
 	/* Compression level is applied here. */
-	ret = btrfs_compress_folios(compress_type, compress_level,
-				    inode, start, folios, &nr_folios, &total_in,
-				    &total_compressed);
-	if (ret)
+	cb = btrfs_compress_bio(inode, start, cur_len, compress_type,
+				 compress_level, async_chunk->write_flags);
+	if (IS_ERR(cb)) {
+		cb = NULL;
 		goto mark_incompressible;
+	}
+
+	total_compressed = cb->bbio.bio.bi_iter.bi_size;
+	total_in = cur_len;
 
 	/*
 	 * Zero the tail end of the last folio, as we might be sending it down
@@ -1000,7 +1012,7 @@ static void compress_file_range(struct btrfs_work *work)
 	 */
 	loff = (total_compressed & (min_folio_size - 1));
 	if (loff)
-		folio_zero_range(folios[nr_folios - 1], loff, min_folio_size - loff);
+		zero_last_folio(cb);
 
 	/*
 	 * Try to create an inline extent.
@@ -1016,11 +1028,13 @@ static void compress_file_range(struct btrfs_work *work)
 					    BTRFS_COMPRESS_NONE, NULL, false);
 	else
 		ret = cow_file_range_inline(inode, NULL, start, end, total_compressed,
-					    compress_type, folios[0], false);
+					    compress_type,
+					    bio_first_folio_all(&cb->bbio.bio), false);
 	if (ret <= 0) {
+		cleanup_compressed_bio(cb);
 		if (ret < 0)
 			mapping_set_error(mapping, -EIO);
-		goto free_pages;
+		return;
 	}
 
 	/*
@@ -1028,6 +1042,7 @@ static void compress_file_range(struct btrfs_work *work)
 	 * block size boundary so the allocator does sane things.
 	 */
 	total_compressed = ALIGN(total_compressed, blocksize);
+	round_up_last_block(cb, blocksize);
 
 	/*
 	 * One last check to make sure the compression is really a win, compare
@@ -1038,12 +1053,12 @@ static void compress_file_range(struct btrfs_work *work)
 	if (total_compressed + blocksize > total_in)
 		goto mark_incompressible;
 
+
 	/*
 	 * The async work queues will take care of doing actual allocation on
 	 * disk for these compressed pages, and will submit the bios.
 	 */
-	ret = add_async_extent(async_chunk, start, total_in, total_compressed, folios,
-			       nr_folios, compress_type);
+	ret = add_async_extent(async_chunk, start, total_in, cb);
 	BUG_ON(ret);
 	if (start + total_in < end) {
 		start += total_in;
@@ -1056,33 +1071,10 @@ static void compress_file_range(struct btrfs_work *work)
 	if (!btrfs_test_opt(fs_info, FORCE_COMPRESS) && !inode->prop_compress)
 		inode->flags |= BTRFS_INODE_NOCOMPRESS;
 cleanup_and_bail_uncompressed:
-	ret = add_async_extent(async_chunk, start, end - start + 1, 0, NULL, 0,
-			       BTRFS_COMPRESS_NONE);
+	ret = add_async_extent(async_chunk, start, end - start + 1, NULL);
 	BUG_ON(ret);
-free_pages:
-	if (folios) {
-		for (i = 0; i < nr_folios; i++) {
-			WARN_ON(folios[i]->mapping);
-			btrfs_free_compr_folio(folios[i]);
-		}
-		kfree(folios);
-	}
-}
-
-static void free_async_extent_pages(struct async_extent *async_extent)
-{
-	int i;
-
-	if (!async_extent->folios)
-		return;
-
-	for (i = 0; i < async_extent->nr_folios; i++) {
-		WARN_ON(async_extent->folios[i]->mapping);
-		btrfs_free_compr_folio(async_extent->folios[i]);
-	}
-	kfree(async_extent->folios);
-	async_extent->nr_folios = 0;
-	async_extent->folios = NULL;
+	if (cb)
+		cleanup_compressed_bio(cb);
 }
 
 static void submit_uncompressed_range(struct btrfs_inode *inode,
@@ -1129,7 +1121,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	struct extent_state *cached = NULL;
 	struct extent_map *em;
 	int ret = 0;
-	bool free_pages = false;
+	u32 compressed_size;
 	u64 start = async_extent->start;
 	u64 end = async_extent->start + async_extent->ram_size - 1;
 
@@ -1149,17 +1141,14 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 			locked_folio = async_chunk->locked_folio;
 	}
 
-	if (async_extent->compress_type == BTRFS_COMPRESS_NONE) {
-		ASSERT(!async_extent->folios);
-		ASSERT(async_extent->nr_folios == 0);
+	if (!async_extent->cb) {
 		submit_uncompressed_range(inode, async_extent, locked_folio);
-		free_pages = true;
 		goto done;
 	}
 
+	compressed_size = async_extent->cb->bbio.bio.bi_iter.bi_size;
 	ret = btrfs_reserve_extent(root, async_extent->ram_size,
-				   async_extent->compressed_size,
-				   async_extent->compressed_size,
+				   compressed_size, compressed_size,
 				   0, *alloc_hint, &ins, true, true);
 	if (ret) {
 		/*
@@ -1169,7 +1158,8 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 		 * fall back to uncompressed.
 		 */
 		submit_uncompressed_range(inode, async_extent, locked_folio);
-		free_pages = true;
+		cleanup_compressed_bio(async_extent->cb);
+		async_extent->cb = NULL;
 		goto done;
 	}
 
@@ -1181,7 +1171,9 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	file_extent.ram_bytes = async_extent->ram_size;
 	file_extent.num_bytes = async_extent->ram_size;
 	file_extent.offset = 0;
-	file_extent.compression = async_extent->compress_type;
+	file_extent.compression = async_extent->cb->compress_type;
+
+	async_extent->cb->bbio.bio.bi_iter.bi_sector = ins.objectid >> SECTOR_SHIFT;
 
 	em = btrfs_create_io_em(inode, start, &file_extent, BTRFS_ORDERED_COMPRESSED);
 	if (IS_ERR(em)) {
@@ -1197,22 +1189,20 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 		ret = PTR_ERR(ordered);
 		goto out_free_reserve;
 	}
+	async_extent->cb->bbio.ordered = ordered;
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 
 	/* Clear dirty, set writeback and unlock the pages. */
 	extent_clear_unlock_delalloc(inode, start, end,
 			NULL, &cached, EXTENT_LOCKED | EXTENT_DELALLOC,
 			PAGE_UNLOCK | PAGE_START_WRITEBACK);
-	btrfs_submit_compressed_write(ordered,
-			    async_extent->folios,	/* compressed_folios */
-			    async_extent->nr_folios,
-			    async_chunk->write_flags, true);
+	btrfs_submit_bbio(&async_extent->cb->bbio, 0);
+	async_extent->cb = NULL;
+
 	*alloc_hint = ins.objectid + ins.offset;
 done:
 	if (async_chunk->blkcg_css)
 		kthread_associate_blkcg(NULL);
-	if (free_pages)
-		free_async_extent_pages(async_extent);
 	kfree(async_extent);
 	return;
 
@@ -1227,7 +1217,8 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 				     EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING,
 				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
 				     PAGE_END_WRITEBACK);
-	free_async_extent_pages(async_extent);
+	if (async_extent->cb)
+		cleanup_compressed_bio(async_extent->cb);
 	if (async_chunk->blkcg_css)
 		kthread_associate_blkcg(NULL);
 	btrfs_debug(fs_info,
-- 
2.52.0


