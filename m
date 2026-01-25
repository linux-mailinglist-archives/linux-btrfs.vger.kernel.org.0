Return-Path: <linux-btrfs+bounces-21005-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD0AHf+gdmmOTAEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21005-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 00:02:23 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 900C983110
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 00:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E0A0F3066B60
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 22:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5D730F958;
	Sun, 25 Jan 2026 22:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kSWijzYn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kSWijzYn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E3930FC09
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381370; cv=none; b=gafVsZ1CK5Fa8CBqg1fMt/zKlgV8xUCT4G5HeET81BOLO72a2X62b7Ic6tv2qE6r2SGs7vrVSS4tK3XEkVBfQogowX90t7SQRAJBDhj7D5yMehugpc0jfFkeDGWpBbCsrQXKt9h0Lcs+lZ3cCwVo3HiPGIM1K8biKUqw6n79J6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381370; c=relaxed/simple;
	bh=QPVZrFdTdC2Mwo4JyaZQxGCHRu6EcWD2bo4fM15rO3Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhc1I+e9Kt/ALNCswbgPw58vmoMrdQSlUHg/MT0PYd3LYrYc5FmWkMvVXKECTuUWGeKGtf+kLa/tsLnPd8fRIfUERS+5cn/bh0sNCfyPHAdBoA8KPqT2cNM6FiFVwputyuZ0b0llQryQ2DBhiGtaBlfG7euT0ApTVc7mwyNoQ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kSWijzYn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kSWijzYn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B312E5BCCD
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 22:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769381361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P9xq0Hn57SMA8H2cVD5dgNS7JwOfGAQIV6FVVQRdNco=;
	b=kSWijzYnUVApeCmwZ9HmFL6UhdFWVTSPhKO16wbiqlahTginuVlaDRwsL8UoFI+sPqMkio
	nwignN4fEeDvq6hPP2nkdCIYuvi60L2cpW2qPr//vPLDEzt+PcszmkdG1cAL7hAyS6Q1SD
	nouyGf/hEekr8Exsvtb5cOAwr4+PtLs=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=kSWijzYn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769381361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P9xq0Hn57SMA8H2cVD5dgNS7JwOfGAQIV6FVVQRdNco=;
	b=kSWijzYnUVApeCmwZ9HmFL6UhdFWVTSPhKO16wbiqlahTginuVlaDRwsL8UoFI+sPqMkio
	nwignN4fEeDvq6hPP2nkdCIYuvi60L2cpW2qPr//vPLDEzt+PcszmkdG1cAL7hAyS6Q1SD
	nouyGf/hEekr8Exsvtb5cOAwr4+PtLs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD7A4139E9
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 22:49:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MFQ3F/CddmnSTAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 22:49:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 8/9] btrfs: get rid of compressed_folios[] usage for encoded writes
Date: Mon, 26 Jan 2026 09:18:47 +1030
Message-ID: <d88b4a49a926841ca03b0f9946a82bb0a09bc7db.1769381237.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769381237.git.wqu@suse.com>
References: <cover.1769381237.git.wqu@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21005-lists,linux-btrfs=lfdr.de];
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
X-Rspamd-Queue-Id: 900C983110
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

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 53 +++++++++++++++++----------------------
 fs/btrfs/compression.h |  6 ++---
 fs/btrfs/inode.c       | 56 +++++++++++++++++++++++-------------------
 3 files changed, 56 insertions(+), 59 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 037da3a17c71..c7e2a1fcf5f8 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -305,25 +305,6 @@ static void end_bbio_compressed_write(struct btrfs_bio *bbio)
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
@@ -334,34 +315,44 @@ static void btrfs_add_compressed_bio_folios(struct compressed_bio *cb)
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
index fcf4ae2879de..ecbcd0a8364a 100644
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
index 2bc4e3f45545..bcf5a1a63d3e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9803,12 +9803,13 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
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
+	unsigned long nr_folios;
 	struct btrfs_key ins;
 	bool extent_reserved = false;
 	struct extent_map *em;
@@ -9898,38 +9899,45 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	 */
 	disk_num_bytes = ALIGN(orig_count, fs_info->sectorsize);
 	nr_folios = DIV_ROUND_UP(disk_num_bytes, PAGE_SIZE);
-	folios = kvcalloc(nr_folios, sizeof(struct folio *), GFP_KERNEL_ACCOUNT);
-	if (!folios)
-		return -ENOMEM;
-	for (i = 0; i < nr_folios; i++) {
-		size_t bytes = min_t(size_t, PAGE_SIZE, iov_iter_count(from));
+
+	cb = btrfs_alloc_compressed_write(inode, start, num_bytes);
+	for (int i = 0; i < nr_folios; i++) {
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
+		kaddr = kmap_local_folio(folio, 0);
 		if (copy_from_iter(kaddr, bytes, from) != bytes) {
 			kunmap_local(kaddr);
+			folio_put(folio);
 			ret = -EFAULT;
-			goto out_folios;
+			goto out_cb;
+		}
+		if (bytes < min_folio_size)
+			folio_zero_range(folio, bytes, min_folio_size - bytes);
+		ret = bio_add_folio(&cb->bbio.bio, folio, folio_size(folio), 0);
+		if (!unlikely(ret)) {
+			folio_put(folio);
+			ret = -EINVAL;
+			goto out_cb;
 		}
-		if (bytes < PAGE_SIZE)
-			memset(kaddr + bytes, 0, PAGE_SIZE - bytes);
-		kunmap_local(kaddr);
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
@@ -9961,7 +9969,8 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	    encoded->unencoded_offset == 0 &&
 	    can_cow_file_range_inline(inode, start, encoded->len, orig_count)) {
 		ret = __cow_file_range_inline(inode, encoded->len,
-					      orig_count, compression, folios[0],
+					      orig_count, compression,
+					      bio_first_folio_all(&cb->bbio.bio),
 					      true);
 		if (ret <= 0) {
 			if (ret == 0)
@@ -10006,7 +10015,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 
 	btrfs_delalloc_release_extents(inode, num_bytes);
 
-	btrfs_submit_compressed_write(ordered, folios, nr_folios, 0, false);
+	btrfs_submit_compressed_write(ordered, cb);
 	ret = orig_count;
 	goto out;
 
@@ -10028,12 +10037,9 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
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


