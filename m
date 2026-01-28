Return-Path: <linux-btrfs+bounces-21133-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Nl5MJl2eWkSxQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21133-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 03:38:17 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 203BE9C554
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 03:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27D0A301F336
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 02:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2AF2BDC25;
	Wed, 28 Jan 2026 02:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n+aN5of0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n+aN5of0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6143D29D27A
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 02:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567858; cv=none; b=XJSn0VsxbNQKGe/Mwwruj3vkySZ5HbCO1deABo1Wy8H9evweMxTZxxJg7Vaa9Fthxk5tsvg4JARzhNwqDSuMM+ip1JbsUa3EzOIT8t66Ox0RDZrNXZp79S9JzQW9R8X5XC1c0USqGnRPgiB81nr6LPHK4f8ja5NynscScuqGFMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567858; c=relaxed/simple;
	bh=xDEoqhMu4DebQL0f2esCzYekZjcmMv7bqYP+R3z8p4s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnasVUA2g2v7BpPJTysMdjrnE8/2sxUAi4WCIctGMxgGh4Wa5MvTsuTEzhlW/CsBMGVEI+j/rD6fOeLEWej80l0oytGlE+dJ27NzDQ8z2uL7cjj9VTZTtDrC1oI3+YUqKtceqHlr5RcO3rACwapy8MM7QfKnvjp8BBF586Vk94Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n+aN5of0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n+aN5of0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 827955BCDF
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 02:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769567849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QdYeW+f0t1fs4+Lw+0MdCHaNI+LPWUs4A6jMmKIqtGo=;
	b=n+aN5of0nPC2pnXNCYD+IaunOaN4RoW/Ms0ol2+F4XjcFeDPOr/KxvRr7Q+sugpkIxBeMg
	GeU6RDhfAngWmnPUpC7TbP7BjDZjQcnyZnBFPYTSR2V1uKlsoGL7AQPkeYZlsI5Chr5Fhb
	tJxHafZtcqWdpTqSwKMcksmAqLm+RLI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769567849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QdYeW+f0t1fs4+Lw+0MdCHaNI+LPWUs4A6jMmKIqtGo=;
	b=n+aN5of0nPC2pnXNCYD+IaunOaN4RoW/Ms0ol2+F4XjcFeDPOr/KxvRr7Q+sugpkIxBeMg
	GeU6RDhfAngWmnPUpC7TbP7BjDZjQcnyZnBFPYTSR2V1uKlsoGL7AQPkeYZlsI5Chr5Fhb
	tJxHafZtcqWdpTqSwKMcksmAqLm+RLI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DAB93EA61
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 02:37:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cHeoC2h2eWkbZAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 02:37:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 1/9] btrfs: introduce lzo_compress_bio() helper
Date: Wed, 28 Jan 2026 13:07:00 +1030
Message-ID: <4257741ffc6e5dabc242a3b732f504c4de1377de.1769566870.git.wqu@suse.com>
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
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
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
	TAGGED_FROM(0.00)[bounces-21133-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: 203BE9C554
X-Rspamd-Action: no action

The new helper has the following enhancements against the existing
lzo_compress_folios()

- Much smaller parameter list

  No more shared IN/OUT members, no need to pre-allocate a
  compressed_folios[] array.

  Just a workspace list header and a compressed_bio pointer.

  Everything else can be fetched from that @cb pointer.

- Read-to-be-submitted compressed bio

  Although the caller still needs to do some common works like
  rounding up and zeroing the tailing part of the last fs block.

Some workloads are specific to lzo that is not needed with other
multi-run compression interfaces:

- Need to write a LZO header or segment header

  Use the new write_and_queue_folio() helper to do the bio_add_folio()
  call and folio switching.

- Need to update the LZO header after compression is done

  Use bio_first_folio_all() to grab the first folio and update the header.

- Extra corner case of error handling

  This can happen when we have queued part of a folio and hit an error.
  In that case those folios will be released by the bio.
  Thus we can only release the folio that has no queued part.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.h |   1 +
 fs/btrfs/lzo.c         | 261 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 262 insertions(+)

diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index e0228017e861..4b63d7e4a9ad 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -161,6 +161,7 @@ struct list_head *zlib_get_workspace(struct btrfs_fs_info *fs_info, unsigned int
 int lzo_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			u64 start, struct folio **folios, unsigned long *out_folios,
 		unsigned long *total_in, unsigned long *total_out);
+int lzo_compress_bio(struct list_head *ws, struct compressed_bio *cb);
 int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
 int lzo_decompress(struct list_head *ws, const u8 *data_in,
 		struct folio *dest_folio, unsigned long dest_pgoff, size_t srclen,
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index bd5ee82080fa..7314ab500005 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -214,6 +214,159 @@ static int copy_compressed_data_to_page(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+/*
+ * Write data into @out_folio and queue it into @out_bio.
+ *
+ * Return 0 if everything is fine and @total_out will be increased.
+ * Return <0 for error.
+ *
+ * The @out_folio can be NULL after a full folio is queued.
+ * Thus the caller should check and allocate a new folio when needed.
+ */
+static int write_and_queue_folio(struct bio *out_bio,
+				 struct folio **out_folio,
+				 u32 *total_out, u32 write_len)
+{
+	const u32 fsize = folio_size(*out_folio);
+	const u32 foffset = offset_in_folio(*out_folio, *total_out);
+
+	ASSERT(out_folio && *out_folio);
+	/* Should not cross folio boundary. */
+	ASSERT(foffset + write_len <= fsize);
+
+	/* We can not use bio_add_folio_nofail() which doesn't do any merge. */
+	if (!bio_add_folio(out_bio, *out_folio, write_len, foffset)) {
+		/*
+		 * We have allocated a bio that havs BTRFS_MAX_COMPRESSED_PAGES
+		 * vecs, and all ranges inside the same folio should have been
+		 * merged.
+		 * If bio_add_folio() still failed, that means we have reached
+		 * the bvec limits.
+		 *
+		 * This should only happen at the beginning of a folio, and
+		 * caller is responsible for releasing the folio, since it's
+		 * not yet queued into the bio.
+		 */
+		ASSERT(IS_ALIGNED(*total_out, fsize));
+		return -E2BIG;
+	}
+
+	*total_out += write_len;
+	/*
+	 * The full folio has been filled and queued, reset @out_folio to NULL,
+	 * so that error handling is fully handled by the bio.
+	 */
+	if (IS_ALIGNED(*total_out, fsize))
+		*out_folio = NULL;
+	return 0;
+}
+
+/*
+ * Will do:
+ *
+ * - Write a segment header into the destination
+ * - Copy the compressed buffer into the destination
+ * - Make sure we have enough space in the last sector to fit a segment header
+ *   If not, we will pad at most (LZO_LEN (4)) - 1 bytes of zeros.
+ * - If a full folio is filled, it will be queued into @out_bio, and @out_folio
+ *   will be updated.
+ *
+ * Will allocate new pages when needed.
+ *
+ * @out_bio:		The bio that will contain all the compressed data.
+ * @compressed_data:	The compressed data of this segment.
+ * @compressed_size:	The size of the compressed data.
+ * @out_folio:		The current output folio, will be updated if a new
+ *			folio is allocated.
+ * @total_out:		The total bytes of current output.
+ * @max_out:		The maximum size of the compressed data.
+ */
+static int copy_compressed_data_to_bio(struct btrfs_fs_info *fs_info,
+				       struct bio *out_bio,
+				       const char *compressed_data,
+				       size_t compressed_size,
+				       struct folio **out_folio,
+				       u32 *total_out, u32 max_out)
+{
+	const u32 sectorsize = fs_info->sectorsize;
+	const u32 sectorsize_bits = fs_info->sectorsize_bits;
+	const u32 fsize = btrfs_min_folio_size(fs_info);
+	const u32 old_size = out_bio->bi_iter.bi_size;
+	u32 copy_start;
+	u32 sector_bytes_left;
+	char *kaddr;
+	int ret;
+
+	ASSERT(out_folio);
+
+	/* There should be at least a lzo header queued. */
+	ASSERT(old_size);
+	ASSERT(old_size == *total_out);
+
+	/*
+	 * We never allow a segment header crossing sector boundary, previous
+	 * run should ensure we have enough space left inside the sector.
+	 */
+	ASSERT((old_size >> sectorsize_bits) == (old_size + LZO_LEN - 1) >> sectorsize_bits);
+
+	if (!*out_folio) {
+		*out_folio = btrfs_alloc_compr_folio(fs_info);
+		if (!*out_folio)
+			return -ENOMEM;
+	}
+
+	/* Write the segment header first. */
+	kaddr = kmap_local_folio(*out_folio, offset_in_folio(*out_folio, *total_out));
+	write_compress_length(kaddr, compressed_size);
+	kunmap_local(kaddr);
+	ret = write_and_queue_folio(out_bio, out_folio, total_out, LZO_LEN);
+	if (ret < 0)
+		return ret;
+
+	copy_start = *total_out;
+
+	/* Copy compressed data. */
+	while (*total_out - copy_start < compressed_size) {
+		u32 copy_len = min_t(u32, sectorsize - *total_out % sectorsize,
+				     copy_start + compressed_size - *total_out);
+		u32 foffset = *total_out & (fsize - 1);
+
+		/* With the range copied, we're larger than the original range. */
+		if (((*total_out + copy_len) >> sectorsize_bits) >=
+		    max_out >> sectorsize_bits)
+			return -E2BIG;
+
+		if (!*out_folio) {
+			*out_folio = btrfs_alloc_compr_folio(fs_info);
+			if (!*out_folio)
+				return -ENOMEM;
+		}
+
+		kaddr = kmap_local_folio(*out_folio, foffset);
+		memcpy(kaddr, compressed_data + *total_out - copy_start, copy_len);
+		kunmap_local(kaddr);
+		ret = write_and_queue_folio(out_bio, out_folio, total_out, copy_len);
+		if (ret < 0)
+			return ret;
+	}
+
+	/*
+	 * Check if we can fit the next segment header into the remaining space
+	 * of the sector.
+	 */
+	sector_bytes_left = round_up(*total_out, sectorsize) - *total_out;
+	if (sector_bytes_left >= LZO_LEN || sector_bytes_left == 0)
+		return 0;
+
+	ASSERT(*out_folio);
+
+	/* The remaining size is not enough, pad it with zeros */
+	folio_zero_range(*out_folio, offset_in_folio(*out_folio, *total_out),
+			 sector_bytes_left);
+	return write_and_queue_folio(out_bio, out_folio, total_out,
+				     sector_bytes_left);
+}
+
 int lzo_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			u64 start, struct folio **folios, unsigned long *out_folios,
 			unsigned long *total_in, unsigned long *total_out)
@@ -310,6 +463,114 @@ int lzo_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	return ret;
 }
 
+int lzo_compress_bio(struct list_head *ws, struct compressed_bio *cb)
+{
+	struct btrfs_inode *inode = cb->bbio.inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct workspace *workspace = list_entry(ws, struct workspace, list);
+	struct bio *bio = &cb->bbio.bio;
+	const u64 start = cb->start;
+	const u32 len = cb->len;
+	const u32 sectorsize = fs_info->sectorsize;
+	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
+	struct address_space *mapping = inode->vfs_inode.i_mapping;
+	struct folio *folio_in = NULL;
+	struct folio *folio_out = NULL;
+	char *sizes_ptr;
+	int ret = 0;
+	/* Points to the file offset of input data */
+	u64 cur_in = start;
+	/* Points to the current output byte */
+	u32 total_out = 0;
+
+	ASSERT(bio->bi_iter.bi_size == 0);
+	ASSERT(len);
+
+	folio_out = btrfs_alloc_compr_folio(fs_info);
+	if (!folio_out)
+		return -ENOMEM;
+
+	/* Queue a segment header first. */
+	ret = write_and_queue_folio(bio, &folio_out, &total_out, LZO_LEN);
+	/* The first header should not fail. */
+	ASSERT(ret == 0);
+
+	while (cur_in < start + len) {
+		char *data_in;
+		const u32 sectorsize_mask = sectorsize - 1;
+		u32 sector_off = (cur_in - start) & sectorsize_mask;
+		u32 in_len;
+		size_t out_len;
+
+		/* Get the input page first */
+		if (!folio_in) {
+			ret = btrfs_compress_filemap_get_folio(mapping, cur_in, &folio_in);
+			if (ret < 0)
+				goto out;
+		}
+
+		/* Compress at most one sector of data each time */
+		in_len = min_t(u32, start + len - cur_in, sectorsize - sector_off);
+		ASSERT(in_len);
+		data_in = kmap_local_folio(folio_in, offset_in_folio(folio_in, cur_in));
+		ret = lzo1x_1_compress(data_in, in_len,
+				       workspace->cbuf, &out_len,
+				       workspace->mem);
+		kunmap_local(data_in);
+		if (unlikely(ret < 0)) {
+			/* lzo1x_1_compress never fails. */
+			ret = -EIO;
+			goto out;
+		}
+
+		ret = copy_compressed_data_to_bio(fs_info, bio, workspace->cbuf, out_len,
+						  &folio_out, &total_out, len);
+		if (ret < 0)
+			goto out;
+
+		cur_in += in_len;
+
+		/*
+		 * Check if we're making it bigger after two sectors.  And if
+		 * it is so, give up.
+		 */
+		if (cur_in - start > sectorsize * 2 && cur_in - start < total_out) {
+			ret = -E2BIG;
+			goto out;
+		}
+
+		/* Check if we have reached input folio boundary. */
+		if (IS_ALIGNED(cur_in, min_folio_size)) {
+			folio_put(folio_in);
+			folio_in = NULL;
+		}
+	}
+	/*
+	 * The last folio is already queued. Bio is responsible for
+	 * freeing those folios now.
+	 */
+	folio_out = NULL;
+
+	/* Store the size of all chunks of compressed data */
+	sizes_ptr = kmap_local_folio(bio_first_folio_all(bio), 0);
+	write_compress_length(sizes_ptr, total_out);
+	kunmap_local(sizes_ptr);
+out:
+	/*
+	 * We can only free the folio that has no part queued into the bio.
+	 *
+	 * As any folio that is already queued into bio will be released by
+	 * the endio function of bio.
+	 */
+	if (folio_out && IS_ALIGNED(total_out, min_folio_size)) {
+		btrfs_free_compr_folio(folio_out);
+		folio_out = NULL;
+	}
+	if (folio_in)
+		folio_put(folio_in);
+	return ret;
+}
+
 static struct folio *get_current_folio(struct compressed_bio *cb, struct folio_iter *fi,
 				       u32 *cur_folio_index, u32 cur_in)
 {
-- 
2.52.0


