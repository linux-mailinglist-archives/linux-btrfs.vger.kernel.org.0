Return-Path: <linux-btrfs+bounces-21137-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uINuFDp3eWkSxQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21137-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 03:40:58 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4009C5B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 03:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7697A30574B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 02:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8A929CB57;
	Wed, 28 Jan 2026 02:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AxjvM8MP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AxjvM8MP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D73A2BEFFB
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 02:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567871; cv=none; b=LETy0BbpydT6sI/RhjvmwBk/7+h0u1uBdwqPrVAAnpSH4XAUs9XRp0I+Cc2zt1nPCmWVuURezgfbnil1F/X2J7jz69aQ0o6PBay3bLMI9YfYfSWTamvE9aOC4ZgWDSBKEQmN8eiIbqhngiAz1MQuUm8He21OWQePpndXI0W3EI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567871; c=relaxed/simple;
	bh=JrS+Kl3xz57hsJE+GWN18SMQAE2ac4H5EKWTVaP2Gtk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhEbRBN6RRMw7NYiyfb1bNmgjNwdC/wSygDdVB0k+DBGInKq2WGqc9S4dspQtaYW6XxZTujaK9P32D9lMSnSYve0smohj1pgmSLdTCVKQJ9mn4KvNQB2kpkKTtGbEr4ytq3dl08B14wHUp+9yclJH9Mqc+89jwtWSwy5aaw0yCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AxjvM8MP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AxjvM8MP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CEA035BCE6
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 02:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769567857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aYsxpUU+7j+4YRXfi/e2gf4pjmteM3IHstzXvIpxBd8=;
	b=AxjvM8MP8a/XCLV8BBdekG8PwwDcbNJZn0RdKHkE0FCBtgM5Qj3EUkYr8aQzrkgYueK6aQ
	VTAuMXQCOyZziQG4ifRG8OVAXJmWhxEaqFgF0ZNUp9itQrErtya7VjrkKfyuUPMSUGxM6E
	mUMpWVbfHdsfQgHnnez5mgajgYqpD4I=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=AxjvM8MP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769567857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aYsxpUU+7j+4YRXfi/e2gf4pjmteM3IHstzXvIpxBd8=;
	b=AxjvM8MP8a/XCLV8BBdekG8PwwDcbNJZn0RdKHkE0FCBtgM5Qj3EUkYr8aQzrkgYueK6aQ
	VTAuMXQCOyZziQG4ifRG8OVAXJmWhxEaqFgF0ZNUp9itQrErtya7VjrkKfyuUPMSUGxM6E
	mUMpWVbfHdsfQgHnnez5mgajgYqpD4I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CF473EA61
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 02:37:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CFV5C3B2eWkbZAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 02:37:36 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 6/9] btrfs: remove the old btrfs_compress_folios() infrastructures
Date: Wed, 28 Jan 2026 13:07:05 +1030
Message-ID: <b7fd38065ed86f9eea3b4316e8d3fb1a0ece3649.1769566870.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769566870.git.wqu@suse.com>
References: <cover.1769566870.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21137-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F4009C5B6
X-Rspamd-Action: no action

Since it's replaced by btrfs_compress_bio(), remove all involved
functions.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c |  70 ---------------
 fs/btrfs/compression.h |  12 ---
 fs/btrfs/inode.c       |   2 +-
 fs/btrfs/lzo.c         | 188 ----------------------------------------
 fs/btrfs/zlib.c        | 189 -----------------------------------------
 fs/btrfs/zstd.c        | 189 -----------------------------------------
 6 files changed, 1 insertion(+), 649 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 1d4e7c7c25c3..1bf17c269524 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -86,37 +86,6 @@ bool btrfs_compress_is_valid_type(const char *str, size_t len)
 	return false;
 }
 
-static int compression_compress_pages(int type, struct list_head *ws,
-				      struct btrfs_inode *inode, u64 start,
-				      struct folio **folios, unsigned long *out_folios,
-				      unsigned long *total_in, unsigned long *total_out)
-{
-	switch (type) {
-	case BTRFS_COMPRESS_ZLIB:
-		return zlib_compress_folios(ws, inode, start, folios,
-					    out_folios, total_in, total_out);
-	case BTRFS_COMPRESS_LZO:
-		return lzo_compress_folios(ws, inode, start, folios,
-					   out_folios, total_in, total_out);
-	case BTRFS_COMPRESS_ZSTD:
-		return zstd_compress_folios(ws, inode, start, folios,
-					    out_folios, total_in, total_out);
-	case BTRFS_COMPRESS_NONE:
-	default:
-		/*
-		 * This can happen when compression races with remount setting
-		 * it to 'no compress', while caller doesn't call
-		 * inode_need_compress() to check if we really need to
-		 * compress.
-		 *
-		 * Not a big deal, just need to inform caller that we
-		 * haven't allocated any pages yet.
-		 */
-		*out_folios = 0;
-		return -E2BIG;
-	}
-}
-
 static int compression_decompress_bio(struct list_head *ws,
 				      struct compressed_bio *cb)
 {
@@ -1023,45 +992,6 @@ int btrfs_compress_filemap_get_folio(struct address_space *mapping, u64 start,
 	return 0;
 }
 
-/*
- * Given an address space and start and length, compress the bytes into @pages
- * that are allocated on demand.
- *
- * @type_level is encoded algorithm and level, where level 0 means whatever
- * default the algorithm chooses and is opaque here;
- * - compression algo are 0-3
- * - the level are bits 4-7
- *
- * @out_folios is an in/out parameter, holds maximum number of folios to allocate
- * and returns number of actually allocated folios
- *
- * @total_in is used to return the number of bytes actually read.  It
- * may be smaller than the input length if we had to exit early because we
- * ran out of room in the folios array or because we cross the
- * max_out threshold.
- *
- * @total_out is an in/out parameter, must be set to the input length and will
- * be also used to return the total number of compressed bytes
- */
-int btrfs_compress_folios(unsigned int type, int level, struct btrfs_inode *inode,
-			 u64 start, struct folio **folios, unsigned long *out_folios,
-			 unsigned long *total_in, unsigned long *total_out)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	const unsigned long orig_len = *total_out;
-	struct list_head *workspace;
-	int ret;
-
-	level = btrfs_compress_set_level(type, level);
-	workspace = get_workspace(fs_info, type, level);
-	ret = compression_compress_pages(type, workspace, inode, start, folios,
-					 out_folios, total_in, total_out);
-	/* The total read-in bytes should be no larger than the input. */
-	ASSERT(*total_in <= orig_len);
-	put_workspace(fs_info, type, workspace);
-	return ret;
-}
-
 /*
  * Given an address space and start and length, compress the page cache
  * contents into @cb.
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index fd0cce5d07cf..7dc48e556313 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -91,9 +91,6 @@ int __init btrfs_init_compress(void);
 void __cold btrfs_exit_compress(void);
 
 bool btrfs_compress_level_valid(unsigned int type, int level);
-int btrfs_compress_folios(unsigned int type, int level, struct btrfs_inode *inode,
-			  u64 start, struct folio **folios, unsigned long *out_folios,
-			 unsigned long *total_in, unsigned long *total_out);
 int btrfs_decompress(int type, const u8 *data_in, struct folio *dest_folio,
 		     unsigned long dest_pgoff, size_t srclen, size_t destlen);
 int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
@@ -160,9 +157,6 @@ static inline void cleanup_compressed_bio(struct compressed_bio *cb)
 	bio_put(bio);
 }
 
-int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
-			 u64 start, struct folio **folios, unsigned long *out_folios,
-		unsigned long *total_in, unsigned long *total_out);
 int zlib_compress_bio(struct list_head *ws, struct compressed_bio *cb);
 int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
 int zlib_decompress(struct list_head *ws, const u8 *data_in,
@@ -172,9 +166,6 @@ struct list_head *zlib_alloc_workspace(struct btrfs_fs_info *fs_info, unsigned i
 void zlib_free_workspace(struct list_head *ws);
 struct list_head *zlib_get_workspace(struct btrfs_fs_info *fs_info, unsigned int level);
 
-int lzo_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
-			u64 start, struct folio **folios, unsigned long *out_folios,
-		unsigned long *total_in, unsigned long *total_out);
 int lzo_compress_bio(struct list_head *ws, struct compressed_bio *cb);
 int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
 int lzo_decompress(struct list_head *ws, const u8 *data_in,
@@ -183,9 +174,6 @@ int lzo_decompress(struct list_head *ws, const u8 *data_in,
 struct list_head *lzo_alloc_workspace(struct btrfs_fs_info *fs_info);
 void lzo_free_workspace(struct list_head *ws);
 
-int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
-			 u64 start, struct folio **folios, unsigned long *out_folios,
-		unsigned long *total_in, unsigned long *total_out);
 int zstd_compress_bio(struct list_head *ws, struct compressed_bio *cb);
 int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
 int zstd_decompress(struct list_head *ws, const u8 *data_in,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index aafffb72dd0e..d010621b64d5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -942,7 +942,7 @@ static void compress_file_range(struct btrfs_work *work)
 	/*
 	 * All the folios should have been locked thus no failure.
 	 *
-	 * And even if some folios are missing, btrfs_compress_folios()
+	 * And even if some folios are missing, btrfs_compress_bio()
 	 * would handle them correctly, so here just do an ASSERT() check for
 	 * early logic errors.
 	 */
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 7314ab500005..4a7abb0b9809 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -122,98 +122,6 @@ static inline size_t read_compress_length(const char *buf)
 	return le32_to_cpu(dlen);
 }
 
-/*
- * Will do:
- *
- * - Write a segment header into the destination
- * - Copy the compressed buffer into the destination
- * - Make sure we have enough space in the last sector to fit a segment header
- *   If not, we will pad at most (LZO_LEN (4)) - 1 bytes of zeros.
- *
- * Will allocate new pages when needed.
- */
-static int copy_compressed_data_to_page(struct btrfs_fs_info *fs_info,
-					char *compressed_data,
-					size_t compressed_size,
-					struct folio **out_folios,
-					unsigned long max_nr_folio,
-					u32 *cur_out)
-{
-	const u32 sectorsize = fs_info->sectorsize;
-	const u32 min_folio_shift = PAGE_SHIFT + fs_info->block_min_order;
-	u32 sector_bytes_left;
-	u32 orig_out;
-	struct folio *cur_folio;
-	char *kaddr;
-
-	if ((*cur_out >> min_folio_shift) >= max_nr_folio)
-		return -E2BIG;
-
-	/*
-	 * We never allow a segment header crossing sector boundary, previous
-	 * run should ensure we have enough space left inside the sector.
-	 */
-	ASSERT((*cur_out / sectorsize) == (*cur_out + LZO_LEN - 1) / sectorsize);
-
-	cur_folio = out_folios[*cur_out >> min_folio_shift];
-	/* Allocate a new page */
-	if (!cur_folio) {
-		cur_folio = btrfs_alloc_compr_folio(fs_info);
-		if (!cur_folio)
-			return -ENOMEM;
-		out_folios[*cur_out >> min_folio_shift] = cur_folio;
-	}
-
-	kaddr = kmap_local_folio(cur_folio, offset_in_folio(cur_folio, *cur_out));
-	write_compress_length(kaddr, compressed_size);
-	*cur_out += LZO_LEN;
-
-	orig_out = *cur_out;
-
-	/* Copy compressed data */
-	while (*cur_out - orig_out < compressed_size) {
-		u32 copy_len = min_t(u32, sectorsize - *cur_out % sectorsize,
-				     orig_out + compressed_size - *cur_out);
-
-		kunmap_local(kaddr);
-
-		if ((*cur_out >> min_folio_shift) >= max_nr_folio)
-			return -E2BIG;
-
-		cur_folio = out_folios[*cur_out >> min_folio_shift];
-		/* Allocate a new page */
-		if (!cur_folio) {
-			cur_folio = btrfs_alloc_compr_folio(fs_info);
-			if (!cur_folio)
-				return -ENOMEM;
-			out_folios[*cur_out >> min_folio_shift] = cur_folio;
-		}
-		kaddr = kmap_local_folio(cur_folio, 0);
-
-		memcpy(kaddr + offset_in_folio(cur_folio, *cur_out),
-		       compressed_data + *cur_out - orig_out, copy_len);
-
-		*cur_out += copy_len;
-	}
-
-	/*
-	 * Check if we can fit the next segment header into the remaining space
-	 * of the sector.
-	 */
-	sector_bytes_left = round_up(*cur_out, sectorsize) - *cur_out;
-	if (sector_bytes_left >= LZO_LEN || sector_bytes_left == 0)
-		goto out;
-
-	/* The remaining size is not enough, pad it with zeros */
-	memset(kaddr + offset_in_page(*cur_out), 0,
-	       sector_bytes_left);
-	*cur_out += sector_bytes_left;
-
-out:
-	kunmap_local(kaddr);
-	return 0;
-}
-
 /*
  * Write data into @out_folio and queue it into @out_bio.
  *
@@ -367,102 +275,6 @@ static int copy_compressed_data_to_bio(struct btrfs_fs_info *fs_info,
 				     sector_bytes_left);
 }
 
-int lzo_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
-			u64 start, struct folio **folios, unsigned long *out_folios,
-			unsigned long *total_in, unsigned long *total_out)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct workspace *workspace = list_entry(ws, struct workspace, list);
-	const u32 sectorsize = fs_info->sectorsize;
-	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
-	struct address_space *mapping = inode->vfs_inode.i_mapping;
-	struct folio *folio_in = NULL;
-	char *sizes_ptr;
-	const unsigned long max_nr_folio = *out_folios;
-	int ret = 0;
-	/* Points to the file offset of input data */
-	u64 cur_in = start;
-	/* Points to the current output byte */
-	u32 cur_out = 0;
-	u32 len = *total_out;
-
-	ASSERT(max_nr_folio > 0);
-	*out_folios = 0;
-	*total_out = 0;
-	*total_in = 0;
-
-	/*
-	 * Skip the header for now, we will later come back and write the total
-	 * compressed size
-	 */
-	cur_out += LZO_LEN;
-	while (cur_in < start + len) {
-		char *data_in;
-		const u32 sectorsize_mask = sectorsize - 1;
-		u32 sector_off = (cur_in - start) & sectorsize_mask;
-		u32 in_len;
-		size_t out_len;
-
-		/* Get the input page first */
-		if (!folio_in) {
-			ret = btrfs_compress_filemap_get_folio(mapping, cur_in, &folio_in);
-			if (ret < 0)
-				goto out;
-		}
-
-		/* Compress at most one sector of data each time */
-		in_len = min_t(u32, start + len - cur_in, sectorsize - sector_off);
-		ASSERT(in_len);
-		data_in = kmap_local_folio(folio_in, offset_in_folio(folio_in, cur_in));
-		ret = lzo1x_1_compress(data_in, in_len,
-				       workspace->cbuf, &out_len,
-				       workspace->mem);
-		kunmap_local(data_in);
-		if (unlikely(ret < 0)) {
-			/* lzo1x_1_compress never fails. */
-			ret = -EIO;
-			goto out;
-		}
-
-		ret = copy_compressed_data_to_page(fs_info, workspace->cbuf, out_len,
-						   folios, max_nr_folio,
-						   &cur_out);
-		if (ret < 0)
-			goto out;
-
-		cur_in += in_len;
-
-		/*
-		 * Check if we're making it bigger after two sectors.  And if
-		 * it is so, give up.
-		 */
-		if (cur_in - start > sectorsize * 2 && cur_in - start < cur_out) {
-			ret = -E2BIG;
-			goto out;
-		}
-
-		/* Check if we have reached folio boundary. */
-		if (IS_ALIGNED(cur_in, min_folio_size)) {
-			folio_put(folio_in);
-			folio_in = NULL;
-		}
-	}
-
-	/* Store the size of all chunks of compressed data */
-	sizes_ptr = kmap_local_folio(folios[0], 0);
-	write_compress_length(sizes_ptr, cur_out);
-	kunmap_local(sizes_ptr);
-
-	ret = 0;
-	*total_out = cur_out;
-	*total_in = cur_in - start;
-out:
-	if (folio_in)
-		folio_put(folio_in);
-	*out_folios = DIV_ROUND_UP(cur_out, min_folio_size);
-	return ret;
-}
-
 int lzo_compress_bio(struct list_head *ws, struct compressed_bio *cb)
 {
 	struct btrfs_inode *inode = cb->bbio.inode;
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 6f2a43f06b5c..d378c7f5b047 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -145,195 +145,6 @@ static int copy_data_into_buffer(struct address_space *mapping,
 	return 0;
 }
 
-int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
-			 u64 start, struct folio **folios, unsigned long *out_folios,
-			 unsigned long *total_in, unsigned long *total_out)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct workspace *workspace = list_entry(ws, struct workspace, list);
-	struct address_space *mapping = inode->vfs_inode.i_mapping;
-	const u32 min_folio_shift = PAGE_SHIFT + fs_info->block_min_order;
-	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
-	int ret;
-	char *data_in = NULL;
-	char *cfolio_out;
-	int nr_folios = 0;
-	struct folio *in_folio = NULL;
-	struct folio *out_folio = NULL;
-	unsigned long len = *total_out;
-	unsigned long nr_dest_folios = *out_folios;
-	const unsigned long max_out = nr_dest_folios << min_folio_shift;
-	const u32 blocksize = fs_info->sectorsize;
-	const u64 orig_end = start + len;
-
-	*out_folios = 0;
-	*total_out = 0;
-	*total_in = 0;
-
-	ret = zlib_deflateInit(&workspace->strm, workspace->level);
-	if (unlikely(ret != Z_OK)) {
-		btrfs_err(fs_info,
-	"zlib compression init failed, error %d root %llu inode %llu offset %llu",
-			  ret, btrfs_root_id(inode->root), btrfs_ino(inode), start);
-		ret = -EIO;
-		goto out;
-	}
-
-	workspace->strm.total_in = 0;
-	workspace->strm.total_out = 0;
-
-	out_folio = btrfs_alloc_compr_folio(fs_info);
-	if (out_folio == NULL) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	cfolio_out = folio_address(out_folio);
-	folios[0] = out_folio;
-	nr_folios = 1;
-
-	workspace->strm.next_in = workspace->buf;
-	workspace->strm.avail_in = 0;
-	workspace->strm.next_out = cfolio_out;
-	workspace->strm.avail_out = min_folio_size;
-
-	while (workspace->strm.total_in < len) {
-		/*
-		 * Get next input pages and copy the contents to
-		 * the workspace buffer if required.
-		 */
-		if (workspace->strm.avail_in == 0) {
-			unsigned long bytes_left = len - workspace->strm.total_in;
-			unsigned int copy_length = min(bytes_left, workspace->buf_size);
-
-			/*
-			 * For s390 hardware accelerated zlib, and our folio is smaller
-			 * than the copy_length, we need to fill the buffer so that
-			 * we can take full advantage of hardware acceleration.
-			 */
-			if (need_special_buffer(fs_info)) {
-				ret = copy_data_into_buffer(mapping, workspace,
-							    start, copy_length);
-				if (ret < 0)
-					goto out;
-				start += copy_length;
-				workspace->strm.next_in = workspace->buf;
-				workspace->strm.avail_in = copy_length;
-			} else {
-				unsigned int cur_len;
-
-				if (data_in) {
-					kunmap_local(data_in);
-					folio_put(in_folio);
-					data_in = NULL;
-				}
-				ret = btrfs_compress_filemap_get_folio(mapping,
-						start, &in_folio);
-				if (ret < 0)
-					goto out;
-				cur_len = btrfs_calc_input_length(in_folio, orig_end, start);
-				data_in = kmap_local_folio(in_folio,
-							   offset_in_folio(in_folio, start));
-				start += cur_len;
-				workspace->strm.next_in = data_in;
-				workspace->strm.avail_in = cur_len;
-			}
-		}
-
-		ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
-		if (unlikely(ret != Z_OK)) {
-			btrfs_warn(fs_info,
-		"zlib compression failed, error %d root %llu inode %llu offset %llu",
-				   ret, btrfs_root_id(inode->root), btrfs_ino(inode),
-				   start);
-			zlib_deflateEnd(&workspace->strm);
-			ret = -EIO;
-			goto out;
-		}
-
-		/* we're making it bigger, give up */
-		if (workspace->strm.total_in > blocksize * 2 &&
-		    workspace->strm.total_in <
-		    workspace->strm.total_out) {
-			ret = -E2BIG;
-			goto out;
-		}
-		/* we need another page for writing out.  Test this
-		 * before the total_in so we will pull in a new page for
-		 * the stream end if required
-		 */
-		if (workspace->strm.avail_out == 0) {
-			if (nr_folios == nr_dest_folios) {
-				ret = -E2BIG;
-				goto out;
-			}
-			out_folio = btrfs_alloc_compr_folio(fs_info);
-			if (out_folio == NULL) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			cfolio_out = folio_address(out_folio);
-			folios[nr_folios] = out_folio;
-			nr_folios++;
-			workspace->strm.avail_out = min_folio_size;
-			workspace->strm.next_out = cfolio_out;
-		}
-		/* we're all done */
-		if (workspace->strm.total_in >= len)
-			break;
-		if (workspace->strm.total_out > max_out)
-			break;
-	}
-	workspace->strm.avail_in = 0;
-	/*
-	 * Call deflate with Z_FINISH flush parameter providing more output
-	 * space but no more input data, until it returns with Z_STREAM_END.
-	 */
-	while (ret != Z_STREAM_END) {
-		ret = zlib_deflate(&workspace->strm, Z_FINISH);
-		if (ret == Z_STREAM_END)
-			break;
-		if (unlikely(ret != Z_OK && ret != Z_BUF_ERROR)) {
-			zlib_deflateEnd(&workspace->strm);
-			ret = -EIO;
-			goto out;
-		} else if (workspace->strm.avail_out == 0) {
-			/* Get another folio for the stream end. */
-			if (nr_folios == nr_dest_folios) {
-				ret = -E2BIG;
-				goto out;
-			}
-			out_folio = btrfs_alloc_compr_folio(fs_info);
-			if (out_folio == NULL) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			cfolio_out = folio_address(out_folio);
-			folios[nr_folios] = out_folio;
-			nr_folios++;
-			workspace->strm.avail_out = min_folio_size;
-			workspace->strm.next_out = cfolio_out;
-		}
-	}
-	zlib_deflateEnd(&workspace->strm);
-
-	if (workspace->strm.total_out >= workspace->strm.total_in) {
-		ret = -E2BIG;
-		goto out;
-	}
-
-	ret = 0;
-	*total_out = workspace->strm.total_out;
-	*total_in = workspace->strm.total_in;
-out:
-	*out_folios = nr_folios;
-	if (data_in) {
-		kunmap_local(data_in);
-		folio_put(in_folio);
-	}
-
-	return ret;
-}
-
 int zlib_compress_bio(struct list_head *ws, struct compressed_bio *cb)
 {
 	struct btrfs_inode *inode = cb->bbio.inode;
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index ce204a9300b5..caaf8d8213de 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -396,195 +396,6 @@ struct list_head *zstd_alloc_workspace(struct btrfs_fs_info *fs_info, int level)
 	return ERR_PTR(-ENOMEM);
 }
 
-int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
-			 u64 start, struct folio **folios, unsigned long *out_folios,
-			 unsigned long *total_in, unsigned long *total_out)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct workspace *workspace = list_entry(ws, struct workspace, list);
-	struct address_space *mapping = inode->vfs_inode.i_mapping;
-	zstd_cstream *stream;
-	int ret = 0;
-	int nr_folios = 0;
-	struct folio *in_folio = NULL;  /* The current folio to read. */
-	struct folio *out_folio = NULL; /* The current folio to write to. */
-	unsigned long tot_in = 0;
-	unsigned long tot_out = 0;
-	unsigned long len = *total_out;
-	const unsigned long nr_dest_folios = *out_folios;
-	const u64 orig_end = start + len;
-	const u32 blocksize = fs_info->sectorsize;
-	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
-	unsigned long max_out = nr_dest_folios * min_folio_size;
-	unsigned int cur_len;
-
-	workspace->params = zstd_get_btrfs_parameters(workspace->req_level, len);
-	*out_folios = 0;
-	*total_out = 0;
-	*total_in = 0;
-
-	/* Initialize the stream */
-	stream = zstd_init_cstream(&workspace->params, len, workspace->mem,
-			workspace->size);
-	if (unlikely(!stream)) {
-		btrfs_err(fs_info,
-	"zstd compression init level %d failed, root %llu inode %llu offset %llu",
-			  workspace->req_level, btrfs_root_id(inode->root),
-			  btrfs_ino(inode), start);
-		ret = -EIO;
-		goto out;
-	}
-
-	/* map in the first page of input data */
-	ret = btrfs_compress_filemap_get_folio(mapping, start, &in_folio);
-	if (ret < 0)
-		goto out;
-	cur_len = btrfs_calc_input_length(in_folio, orig_end, start);
-	workspace->in_buf.src = kmap_local_folio(in_folio, offset_in_folio(in_folio, start));
-	workspace->in_buf.pos = 0;
-	workspace->in_buf.size = cur_len;
-
-	/* Allocate and map in the output buffer */
-	out_folio = btrfs_alloc_compr_folio(fs_info);
-	if (out_folio == NULL) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	folios[nr_folios++] = out_folio;
-	workspace->out_buf.dst = folio_address(out_folio);
-	workspace->out_buf.pos = 0;
-	workspace->out_buf.size = min_t(size_t, max_out, min_folio_size);
-
-	while (1) {
-		size_t ret2;
-
-		ret2 = zstd_compress_stream(stream, &workspace->out_buf,
-				&workspace->in_buf);
-		if (unlikely(zstd_is_error(ret2))) {
-			btrfs_warn(fs_info,
-"zstd compression level %d failed, error %d root %llu inode %llu offset %llu",
-				   workspace->req_level, zstd_get_error_code(ret2),
-				   btrfs_root_id(inode->root), btrfs_ino(inode),
-				   start);
-			ret = -EIO;
-			goto out;
-		}
-
-		/* Check to see if we are making it bigger */
-		if (tot_in + workspace->in_buf.pos > blocksize * 2 &&
-				tot_in + workspace->in_buf.pos <
-				tot_out + workspace->out_buf.pos) {
-			ret = -E2BIG;
-			goto out;
-		}
-
-		/* We've reached the end of our output range */
-		if (workspace->out_buf.pos >= max_out) {
-			tot_out += workspace->out_buf.pos;
-			ret = -E2BIG;
-			goto out;
-		}
-
-		/* Check if we need more output space */
-		if (workspace->out_buf.pos == workspace->out_buf.size) {
-			tot_out += min_folio_size;
-			max_out -= min_folio_size;
-			if (nr_folios == nr_dest_folios) {
-				ret = -E2BIG;
-				goto out;
-			}
-			out_folio = btrfs_alloc_compr_folio(fs_info);
-			if (out_folio == NULL) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			folios[nr_folios++] = out_folio;
-			workspace->out_buf.dst = folio_address(out_folio);
-			workspace->out_buf.pos = 0;
-			workspace->out_buf.size = min_t(size_t, max_out, min_folio_size);
-		}
-
-		/* We've reached the end of the input */
-		if (workspace->in_buf.pos >= len) {
-			tot_in += workspace->in_buf.pos;
-			break;
-		}
-
-		/* Check if we need more input */
-		if (workspace->in_buf.pos == workspace->in_buf.size) {
-			tot_in += workspace->in_buf.size;
-			kunmap_local(workspace->in_buf.src);
-			workspace->in_buf.src = NULL;
-			folio_put(in_folio);
-			start += cur_len;
-			len -= cur_len;
-			ret = btrfs_compress_filemap_get_folio(mapping, start, &in_folio);
-			if (ret < 0)
-				goto out;
-			cur_len = btrfs_calc_input_length(in_folio, orig_end, start);
-			workspace->in_buf.src = kmap_local_folio(in_folio,
-							 offset_in_folio(in_folio, start));
-			workspace->in_buf.pos = 0;
-			workspace->in_buf.size = cur_len;
-		}
-	}
-	while (1) {
-		size_t ret2;
-
-		ret2 = zstd_end_stream(stream, &workspace->out_buf);
-		if (unlikely(zstd_is_error(ret2))) {
-			btrfs_err(fs_info,
-"zstd compression end level %d failed, error %d root %llu inode %llu offset %llu",
-				  workspace->req_level, zstd_get_error_code(ret2),
-				  btrfs_root_id(inode->root), btrfs_ino(inode),
-				  start);
-			ret = -EIO;
-			goto out;
-		}
-		if (ret2 == 0) {
-			tot_out += workspace->out_buf.pos;
-			break;
-		}
-		if (workspace->out_buf.pos >= max_out) {
-			tot_out += workspace->out_buf.pos;
-			ret = -E2BIG;
-			goto out;
-		}
-
-		tot_out += min_folio_size;
-		max_out -= min_folio_size;
-		if (nr_folios == nr_dest_folios) {
-			ret = -E2BIG;
-			goto out;
-		}
-		out_folio = btrfs_alloc_compr_folio(fs_info);
-		if (out_folio == NULL) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		folios[nr_folios++] = out_folio;
-		workspace->out_buf.dst = folio_address(out_folio);
-		workspace->out_buf.pos = 0;
-		workspace->out_buf.size = min_t(size_t, max_out, min_folio_size);
-	}
-
-	if (tot_out >= tot_in) {
-		ret = -E2BIG;
-		goto out;
-	}
-
-	ret = 0;
-	*total_in = tot_in;
-	*total_out = tot_out;
-out:
-	*out_folios = nr_folios;
-	if (workspace->in_buf.src) {
-		kunmap_local(workspace->in_buf.src);
-		folio_put(in_folio);
-	}
-	return ret;
-}
-
 int zstd_compress_bio(struct list_head *ws, struct compressed_bio *cb)
 {
 	struct btrfs_inode *inode = cb->bbio.inode;
-- 
2.52.0


