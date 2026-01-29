Return-Path: <linux-btrfs+bounces-21216-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uL0EKyHTemlX+wEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21216-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 04:25:21 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E54BAB6EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 04:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EF53303B14F
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 03:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EF734EF0D;
	Thu, 29 Jan 2026 03:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JD8wJpoC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JD8wJpoC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960333161A3
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Jan 2026 03:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769657076; cv=none; b=J6aU++MsbNVaBROk/TBEXGeTRnB8V8Nptn+4RUwlSWXb2ymVANLR0xpMsBLxR6VX16Yj5HscBPUS9p29x90Qs9AyH/qOA3K1st+xOIFJiYVVGDED+EwsIWZVtFI4J+7hEIyhiN3/fmUVjREDZudzemSSgwN9XBz7Y7jrVp/wtHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769657076; c=relaxed/simple;
	bh=vMkWR39h66gy7a3ID+R9Qjql0FudTEVTl0MLLjz4yNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IB2X9+VYtecDAuiTul8B3C4hCIHcFZm01u+TFpo/oNowt68y+kvj6a5tFpgHuahBy519LqQ6XhEVkwfnNM5HfcPJE12Pe0x72+ARegwfy1ivEUxjjpf1ft4Hxc8qsG/D9zJF7P9h5RGtEeL7FSlT7/n6HvLjlQ9bHe1izLiWYJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JD8wJpoC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JD8wJpoC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CFB935BCE2;
	Thu, 29 Jan 2026 03:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769657062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCBRteUo2y1/wjxrQhmcL5u/xSXvU/h+2EicGZbqzHw=;
	b=JD8wJpoCo+gPcx1N2lKc6/ggJxzraTQG8yPmxw/vcMg8N2pgJzm8fh/NpscXUeqjZiisbC
	akmzuEl/PBHZazSR+buRr4ABhjVJHLkfSIyBfmUXVcReX1VoMX9xVzG+LmLsE/P1ICll5q
	QpLXrPf6ngK2UaTxSV82TW90EMv7vSw=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=JD8wJpoC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769657062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCBRteUo2y1/wjxrQhmcL5u/xSXvU/h+2EicGZbqzHw=;
	b=JD8wJpoCo+gPcx1N2lKc6/ggJxzraTQG8yPmxw/vcMg8N2pgJzm8fh/NpscXUeqjZiisbC
	akmzuEl/PBHZazSR+buRr4ABhjVJHLkfSIyBfmUXVcReX1VoMX9xVzG+LmLsE/P1ICll5q
	QpLXrPf6ngK2UaTxSV82TW90EMv7vSw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 716FF3EA61;
	Thu, 29 Jan 2026 03:24:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KID/B+XSemk+TgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 29 Jan 2026 03:24:21 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
Subject: [PATCH v5 8/9] btrfs: get rid of compressed_folios[] usage for encoded writes
Date: Thu, 29 Jan 2026 13:53:45 +1030
Message-ID: <9851729ff3265954ff803661d2ffe61f3d98c1d0.1769656714.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769656714.git.wqu@suse.com>
References: <cover.1769656714.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21216-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid,bur.io:email]
X-Rspamd-Queue-Id: 6E54BAB6EA
X-Rspamd-Action: no action

Currently only encoded writes utilized btrfs_submit_compressed_write(),
which utilized compressed_bio::compressed_folios[] array.

Change the only call site to call the new helper,
btrfs_alloc_compressed_write(), to allocate a compressed bio, then queue
needed folios into that bio, and finally call
btrfs_submit_compressed_write() to submit the compreseed bio.

This change has one hidden benefit, previously we use
btrfs_alloc_folio_array() for the folios of
btrfs_submit_compressed_read(), which doesn't utilize the compression
page pool for bs == ps cases.

Now we call btrfs_alloc_compr_folio() which will benefit from page pool.

The other obvious benefit is that we no longer need to allocate an array
to hold all those folios, thus one less error path.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 53 +++++++++++++++--------------------
 fs/btrfs/compression.h |  6 ++--
 fs/btrfs/inode.c       | 63 +++++++++++++++++++++++-------------------
 3 files changed, 59 insertions(+), 63 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index c018b3c4554e..205f6828c1e6 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -304,25 +304,6 @@ static void end_bbio_compressed_write(struct btrfs_bio *bbio)
 	bio_put(&cb->bbio.bio);
 }
 
-static void btrfs_add_compressed_bio_folios(struct compressed_bio *cb)
-{
-	struct bio *bio = &cb->bbio.bio;
-	u32 offset = 0;
-	unsigned int findex = 0;
-
-	while (offset < cb->compressed_len) {
-		struct folio *folio = cb->compressed_folios[findex];
-		u32 len = min_t(u32, cb->compressed_len - offset, folio_size(folio));
-		int ret;
-
-		/* Maximum compressed extent is smaller than bio size limit. */
-		ret = bio_add_folio(bio, folio, len, 0);
-		ASSERT(ret);
-		offset += len;
-		findex++;
-	}
-}
-
 /*
  * worker function to build and submit bios for previously compressed pages.
  * The corresponding pages in the inode should be marked for writeback
@@ -333,34 +314,44 @@ static void btrfs_add_compressed_bio_folios(struct compressed_bio *cb)
  * the end io hooks.
  */
 void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
-				   struct folio **compressed_folios,
-				   unsigned int nr_folios,
-				   blk_opf_t write_flags,
-				   bool writeback)
+				   struct compressed_bio *cb)
 {
 	struct btrfs_inode *inode = ordered->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct compressed_bio *cb;
 
 	ASSERT(IS_ALIGNED(ordered->file_offset, fs_info->sectorsize));
 	ASSERT(IS_ALIGNED(ordered->num_bytes, fs_info->sectorsize));
+	ASSERT(cb->writeback);
 
-	cb = alloc_compressed_bio(inode, ordered->file_offset,
-				  REQ_OP_WRITE | write_flags,
-				  end_bbio_compressed_write);
 	cb->start = ordered->file_offset;
 	cb->len = ordered->num_bytes;
-	cb->compressed_folios = compressed_folios;
 	cb->compressed_len = ordered->disk_num_bytes;
-	cb->writeback = writeback;
-	cb->nr_folios = nr_folios;
 	cb->bbio.bio.bi_iter.bi_sector = ordered->disk_bytenr >> SECTOR_SHIFT;
 	cb->bbio.ordered = ordered;
-	btrfs_add_compressed_bio_folios(cb);
 
 	btrfs_submit_bbio(&cb->bbio, 0);
 }
 
+/*
+ * Allocate a compressed write bio for @inode file offset @start length @len.
+ *
+ * The caller still needs to properly queue all folios and populate involved
+ * members.
+ */
+struct compressed_bio *btrfs_alloc_compressed_write(struct btrfs_inode *inode,
+						    u64 start, u64 len)
+{
+	struct compressed_bio *cb;
+
+	cb = alloc_compressed_bio(inode, start, REQ_OP_WRITE,
+				  end_bbio_compressed_write);
+	cb->start = start;
+	cb->len = len;
+	cb->writeback = true;
+
+	return cb;
+}
+
 /*
  * Add extra pages in the same compressed file extent so that we don't need to
  * re-read the same extent again and again.
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 7dc48e556313..2d3a28b26997 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -96,10 +96,10 @@ int btrfs_decompress(int type, const u8 *data_in, struct folio *dest_folio,
 int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
 			      struct compressed_bio *cb, u32 decompressed);
 
+struct compressed_bio *btrfs_alloc_compressed_write(struct btrfs_inode *inode,
+						    u64 start, u64 len);
 void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
-				   struct folio **compressed_folios,
-				   unsigned int nr_folios, blk_opf_t write_flags,
-				   bool writeback);
+				   struct compressed_bio *cb);
 void btrfs_submit_compressed_read(struct btrfs_bio *bbio);
 
 int btrfs_compress_str2level(unsigned int type, const char *str, int *level_ret);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 95b7754c6e92..cbf5411b7488 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9829,12 +9829,12 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	struct extent_state *cached_state = NULL;
 	struct btrfs_ordered_extent *ordered;
 	struct btrfs_file_extent file_extent;
+	struct compressed_bio *cb = NULL;
 	int compression;
 	size_t orig_count;
+	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
 	u64 start, end;
 	u64 num_bytes, ram_bytes, disk_num_bytes;
-	unsigned long nr_folios, i;
-	struct folio **folios;
 	struct btrfs_key ins;
 	bool extent_reserved = false;
 	struct extent_map *em;
@@ -9923,39 +9923,46 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	 * isn't.
 	 */
 	disk_num_bytes = ALIGN(orig_count, fs_info->sectorsize);
-	nr_folios = DIV_ROUND_UP(disk_num_bytes, PAGE_SIZE);
-	folios = kvcalloc(nr_folios, sizeof(struct folio *), GFP_KERNEL_ACCOUNT);
-	if (!folios)
-		return -ENOMEM;
-	for (i = 0; i < nr_folios; i++) {
-		size_t bytes = min_t(size_t, PAGE_SIZE, iov_iter_count(from));
+
+	cb = btrfs_alloc_compressed_write(inode, start, num_bytes);
+	for (int i = 0; i * min_folio_size < disk_num_bytes; i++) {
+		struct folio *folio;
+		size_t bytes = min(min_folio_size, iov_iter_count(from));
 		char *kaddr;
 
-		folios[i] = folio_alloc(GFP_KERNEL_ACCOUNT, 0);
-		if (!folios[i]) {
+		folio = btrfs_alloc_compr_folio(fs_info);
+		if (!folio) {
 			ret = -ENOMEM;
-			goto out_folios;
+			goto out_cb;
 		}
-		kaddr = kmap_local_folio(folios[i], 0);
-		if (copy_from_iter(kaddr, bytes, from) != bytes) {
-			kunmap_local(kaddr);
-			ret = -EFAULT;
-			goto out_folios;
-		}
-		if (bytes < PAGE_SIZE)
-			memset(kaddr + bytes, 0, PAGE_SIZE - bytes);
+		kaddr = kmap_local_folio(folio, 0);
+		ret = copy_from_iter(kaddr, bytes, from);
 		kunmap_local(kaddr);
+		if (ret != bytes) {
+			folio_put(folio);
+			ret = -EFAULT;
+			goto out_cb;
+		}
+		if (bytes < min_folio_size)
+			folio_zero_range(folio, bytes, min_folio_size - bytes);
+		ret = bio_add_folio(&cb->bbio.bio, folio, folio_size(folio), 0);
+		if (unlikely(!ret)) {
+			folio_put(folio);
+			ret = -EINVAL;
+			goto out_cb;
+		}
 	}
+	ASSERT(cb->bbio.bio.bi_iter.bi_size == disk_num_bytes);
 
 	for (;;) {
 		ret = btrfs_wait_ordered_range(inode, start, num_bytes);
 		if (ret)
-			goto out_folios;
+			goto out_cb;
 		ret = invalidate_inode_pages2_range(inode->vfs_inode.i_mapping,
 						    start >> PAGE_SHIFT,
 						    end >> PAGE_SHIFT);
 		if (ret)
-			goto out_folios;
+			goto out_cb;
 		btrfs_lock_extent(io_tree, start, end, &cached_state);
 		ordered = btrfs_lookup_ordered_range(inode, start, num_bytes);
 		if (!ordered &&
@@ -9987,7 +9994,8 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	    encoded->unencoded_offset == 0 &&
 	    can_cow_file_range_inline(inode, start, encoded->len, orig_count)) {
 		ret = __cow_file_range_inline(inode, encoded->len,
-					      orig_count, compression, folios[0],
+					      orig_count, compression,
+					      bio_first_folio_all(&cb->bbio.bio),
 					      true);
 		if (ret <= 0) {
 			if (ret == 0)
@@ -10032,7 +10040,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 
 	btrfs_delalloc_release_extents(inode, num_bytes);
 
-	btrfs_submit_compressed_write(ordered, folios, nr_folios, 0, false);
+	btrfs_submit_compressed_write(ordered, cb);
 	ret = orig_count;
 	goto out;
 
@@ -10054,12 +10062,9 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 		btrfs_free_reserved_data_space_noquota(inode, disk_num_bytes);
 out_unlock:
 	btrfs_unlock_extent(io_tree, start, end, &cached_state);
-out_folios:
-	for (i = 0; i < nr_folios; i++) {
-		if (folios[i])
-			folio_put(folios[i]);
-	}
-	kvfree(folios);
+out_cb:
+	if (cb)
+		cleanup_compressed_bio(cb);
 out:
 	if (ret >= 0)
 		iocb->ki_pos += encoded->len;
-- 
2.52.0


