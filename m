Return-Path: <linux-btrfs+bounces-20744-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC78D3BC3A
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 01:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C960302CDDD
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 00:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D510D2264AA;
	Tue, 20 Jan 2026 00:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oUV7VCGt";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oUV7VCGt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B674424886E
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768867235; cv=none; b=hLr97NeaVdmLsUprj+uqaxluDoQHOViFXLoQRJLh2wZRfQpXnwL4tPTYl6SuOY/XFDvhErEdyePJe/kHdsfxtpg7tr4lgbtyVfjczNo4t3Nrp31QIXsdSKtQZoDBaiqjM78NPx4FhZvYfjd71yWCvo8q/KVWaguWR82B2y03j6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768867235; c=relaxed/simple;
	bh=WIP6WOt23ovBBsGA+7obztrr7l/GIeL5miFi5UvHhss=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ql0Xf1J4+x13Wg0PQ/mtmShmbzjgkjXEunfHWoFyfVF9FR7Cca2p1HAvdC4llM90OSnD13UQWz5nVO0BMss2FKbhB5d4wpQ2z6ByCbVuaVFW4+0KXMX2Bq3JEm/qOf1JrC9BQSWKTd7KKx5t1iyav7/A5EOkAxbLJ7i6Lzk6Ee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oUV7VCGt; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oUV7VCGt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6C629337BC
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 00:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768867231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Um/8mIEAagZGnnC8Rl9HU6EuDJiWdSYQMXUjjvW7jkE=;
	b=oUV7VCGtbaBW9dRrmxctYz9SP+WlXnCX8Ji7U3/Jvm3QvdzmJExBcr65Ssa0n3TpdFFl3+
	Lf9iWdCMpSSyBBxaBvKCfLlLC2kpl2Ib5KK/ANUFzEZs0jJdR+lIvGtx8mdltBCAgvT5fz
	FfX07yUXg+Rt7W1bTpDoizsGU7Ky190=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768867231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Um/8mIEAagZGnnC8Rl9HU6EuDJiWdSYQMXUjjvW7jkE=;
	b=oUV7VCGtbaBW9dRrmxctYz9SP+WlXnCX8Ji7U3/Jvm3QvdzmJExBcr65Ssa0n3TpdFFl3+
	Lf9iWdCMpSSyBBxaBvKCfLlLC2kpl2Ib5KK/ANUFzEZs0jJdR+lIvGtx8mdltBCAgvT5fz
	FfX07yUXg+Rt7W1bTpDoizsGU7Ky190=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BDBA3EA63
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 00:00:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iJ8SB57FbmlsGwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 00:00:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: use folio_iter to handle lzo_decompress_bio()
Date: Tue, 20 Jan 2026 10:30:08 +1030
Message-ID: <df3dc0988cf89793f262241d71f8ac00200e1f07.1768866942.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768866942.git.wqu@suse.com>
References: <cover.1768866942.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

Currently lzo_decompress_bio() is using
compressed_bio->compressed_folios[] array to grab each compressed folio.

This is making the code much easier to read, as we only need to maintain
a single iterator, @cur_in, and can easily grab any random folio using
@cur_in >> min_folio_shift as an index.

However lzo_decompress_bio() itself is ensured to only advance to the
next folio at one time, and compressed_folios[] is just a pointer to
each folio of the compressed bio, thus we have no real random access
requirement for lzo_decompress_bio().

Replace the compressed_folios[] access by a helper, get_current_folio(),
which uses folio_iter and an external folio counter to properly switch
the folio when needed.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/lzo.c | 48 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 4758f66da449..83c106ca1c14 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -310,23 +310,46 @@ int lzo_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	return ret;
 }
 
+static struct folio *get_current_folio(struct compressed_bio *cb,
+				       struct folio_iter *fi,
+				       u32 *cur_folio_index,
+				       u32 cur_in)
+{
+	struct btrfs_fs_info *fs_info = cb_to_fs_info(cb);
+	const u32 min_folio_shift = PAGE_SHIFT + fs_info->block_min_order;
+
+	ASSERT(cur_folio_index);
+
+	/* Need to switch to the next folio. */
+	if (cur_in >> min_folio_shift != *cur_folio_index) {
+		/* We can only do the switch one folio a time. */
+		ASSERT(cur_in >> min_folio_shift == *cur_folio_index + 1);
+
+		bio_next_folio(fi, &cb->bbio.bio);
+		(*cur_folio_index)++;
+	}
+	return fi->folio;
+}
+
 /*
  * Copy the compressed segment payload into @dest.
  *
  * For the payload there will be no padding, just need to do page switching.
  */
 static void copy_compressed_segment(struct compressed_bio *cb,
+				    struct folio_iter *fi,
+				    u32 *cur_folio_index,
 				    char *dest, u32 len, u32 *cur_in)
 {
-	struct btrfs_fs_info *fs_info = cb_to_fs_info(cb);
-	const u32 min_folio_shift = PAGE_SHIFT + fs_info->block_min_order;
 	u32 orig_in = *cur_in;
 
 	while (*cur_in < orig_in + len) {
-		struct folio *cur_folio = cb->compressed_folios[*cur_in >> min_folio_shift];
-		u32 copy_len = min_t(u32, orig_in + len - *cur_in,
-				     folio_size(cur_folio) - offset_in_folio(cur_folio, *cur_in));
+		struct folio *cur_folio = get_current_folio(cb, fi, cur_folio_index, *cur_in);
+		u32 copy_len;
 
+		ASSERT(cur_folio);
+		copy_len = min_t(u32, orig_in + len - *cur_in,
+				 folio_size(cur_folio) - offset_in_folio(cur_folio, *cur_in));
 		ASSERT(copy_len);
 
 		memcpy_from_folio(dest + *cur_in - orig_in, cur_folio,
@@ -341,7 +364,7 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	const struct btrfs_fs_info *fs_info = cb->bbio.inode->root->fs_info;
 	const u32 sectorsize = fs_info->sectorsize;
-	const u32 min_folio_shift = PAGE_SHIFT + fs_info->block_min_order;
+	struct folio_iter fi;
 	char *kaddr;
 	int ret;
 	/* Compressed data length, can be unaligned */
@@ -350,8 +373,14 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	u32 cur_in = 0;
 	/* Bytes decompressed so far */
 	u32 cur_out = 0;
+	/* The current folio index number inside the bio. */
+	u32 cur_folio_index = 0;
 
-	kaddr = kmap_local_folio(cb->compressed_folios[0], 0);
+	bio_first_folio(&fi, &cb->bbio.bio, 0);
+	/* There must be a compressed folio and matches the sectorsize. */
+	ASSERT(fi.folio);
+	ASSERT(folio_size(fi.folio) == sectorsize);
+	kaddr = kmap_local_folio(fi.folio, 0);
 	len_in = read_compress_length(kaddr);
 	kunmap_local(kaddr);
 	cur_in += LZO_LEN;
@@ -388,7 +417,7 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		 */
 		ASSERT(cur_in / sectorsize ==
 		       (cur_in + LZO_LEN - 1) / sectorsize);
-		cur_folio = cb->compressed_folios[cur_in >> min_folio_shift];
+		cur_folio = get_current_folio(cb, &fi, &cur_folio_index, cur_in);
 		ASSERT(cur_folio);
 		kaddr = kmap_local_folio(cur_folio, 0);
 		seg_len = read_compress_length(kaddr + offset_in_folio(cur_folio, cur_in));
@@ -410,7 +439,8 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		}
 
 		/* Copy the compressed segment payload into workspace */
-		copy_compressed_segment(cb, workspace->cbuf, seg_len, &cur_in);
+		copy_compressed_segment(cb, &fi, &cur_folio_index, workspace->cbuf,
+					seg_len, &cur_in);
 
 		/* Decompress the data */
 		ret = lzo1x_decompress_safe(workspace->cbuf, seg_len,
-- 
2.52.0


