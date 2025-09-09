Return-Path: <linux-btrfs+bounces-16739-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38777B4A022
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 05:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233151BC2C1D
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 03:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8645E27602F;
	Tue,  9 Sep 2025 03:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PSHAK0pd";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PSHAK0pd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4A72550DD
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Sep 2025 03:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757389152; cv=none; b=D7wZvtqI/nVUQB6FfMd0OaE95d2x8Gvg3j36kfkhvZgvy7aatQXEOAr4VjgVm5ecyZzu50OlcCq+8wvIQ4trn1lzUPQitio4vx8FlAs9dz9u0Wfhj6n45Wwodg1a7q8Km1+8CnRQhO+4G1600uQuMYbW34MAf/A755df92jRpOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757389152; c=relaxed/simple;
	bh=h4Evn4+NtqC9q+lFTB2s9hYgALCwx6dVgrjIX8nrIcg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGpI9GbzDi4emYrkbmB55QjQ357xAF14PTsBz9HVvsr1X0BpMQM5N0L+zXzpZ7peA8wd1WjPKpFO00JQCno9NFosCLi7vgy8VoFT20gbY6yFABtjP0UgT5hkpkQ2UpcE1R4fVAWc0AlAvOZhF7x4OwXxVVlA1FpUKOcT4DYVmt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PSHAK0pd; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PSHAK0pd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9571D296A5
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Sep 2025 03:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757389143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=boH//wmXvqm6a1/wfn/Qksg2vYkHqNXs465TpiSN43Y=;
	b=PSHAK0pdTv81T/J5X/rMi6cA2clN5xDzMfn6Pt0tSc/wdC2wgVSFbxE3uSgwpJ8n/+7yNt
	qfK5A6qfiGhwBRc5IeLb4Z4K91cCtG4qSc1g6ZvwCo4uvMcOTWVkKLJ+H8pUgZJ44Cm7fG
	SyhgL9SFb8cEc1h+NGLPD6hGuM209vM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=PSHAK0pd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757389143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=boH//wmXvqm6a1/wfn/Qksg2vYkHqNXs465TpiSN43Y=;
	b=PSHAK0pdTv81T/J5X/rMi6cA2clN5xDzMfn6Pt0tSc/wdC2wgVSFbxE3uSgwpJ8n/+7yNt
	qfK5A6qfiGhwBRc5IeLb4Z4K91cCtG4qSc1g6ZvwCo4uvMcOTWVkKLJ+H8pUgZJ44Cm7fG
	SyhgL9SFb8cEc1h+NGLPD6hGuM209vM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2B5B13996
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Sep 2025 03:39:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WFPpJFahv2i7JgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 09 Sep 2025 03:39:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: prepare lzo to support bs > ps cases
Date: Tue,  9 Sep 2025 13:08:39 +0930
Message-ID: <94d2735af09eba80780d68968305c63f4bd60191.1757388121.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757388121.git.wqu@suse.com>
References: <cover.1757388121.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 9571D296A5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

This involves converting the following functions to use correct folio
sizes/shifts:

- copy_compress_data_to_page()
- lzo_compress_folios()
- lzo_decompress_bio()

Just like zstd, lzo has some extra incorrect usage of kmap_local_folio()
that the offset is always 0.

This will not handle HIGHMEM large folios correct, but those cases are
already rejected explicitly so it should not cause problems when bs > ps
support is enabled.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/lzo.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index c5a25fd872bd..bc0890f3c2bb 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -140,12 +140,13 @@ static int copy_compressed_data_to_page(struct btrfs_fs_info *fs_info,
 					u32 *cur_out)
 {
 	const u32 sectorsize = fs_info->sectorsize;
+	const u32 min_folio_shift = PAGE_SHIFT + fs_info->block_min_order;
 	u32 sector_bytes_left;
 	u32 orig_out;
 	struct folio *cur_folio;
 	char *kaddr;
 
-	if ((*cur_out / PAGE_SIZE) >= max_nr_folio)
+	if ((*cur_out >> min_folio_shift) >= max_nr_folio)
 		return -E2BIG;
 
 	/*
@@ -154,18 +155,17 @@ static int copy_compressed_data_to_page(struct btrfs_fs_info *fs_info,
 	 */
 	ASSERT((*cur_out / sectorsize) == (*cur_out + LZO_LEN - 1) / sectorsize);
 
-	cur_folio = out_folios[*cur_out / PAGE_SIZE];
+	cur_folio = out_folios[*cur_out >> min_folio_shift];
 	/* Allocate a new page */
 	if (!cur_folio) {
 		cur_folio = btrfs_alloc_compr_folio(fs_info);
 		if (!cur_folio)
 			return -ENOMEM;
-		out_folios[*cur_out / PAGE_SIZE] = cur_folio;
+		out_folios[*cur_out >> min_folio_shift] = cur_folio;
 	}
 
-	kaddr = kmap_local_folio(cur_folio, 0);
-	write_compress_length(kaddr + offset_in_page(*cur_out),
-			      compressed_size);
+	kaddr = kmap_local_folio(cur_folio, offset_in_folio(cur_folio, *cur_out));
+	write_compress_length(kaddr, compressed_size);
 	*cur_out += LZO_LEN;
 
 	orig_out = *cur_out;
@@ -177,20 +177,20 @@ static int copy_compressed_data_to_page(struct btrfs_fs_info *fs_info,
 
 		kunmap_local(kaddr);
 
-		if ((*cur_out / PAGE_SIZE) >= max_nr_folio)
+		if ((*cur_out >> min_folio_shift) >= max_nr_folio)
 			return -E2BIG;
 
-		cur_folio = out_folios[*cur_out / PAGE_SIZE];
+		cur_folio = out_folios[*cur_out >> min_folio_shift];
 		/* Allocate a new page */
 		if (!cur_folio) {
 			cur_folio = btrfs_alloc_compr_folio(fs_info);
 			if (!cur_folio)
 				return -ENOMEM;
-			out_folios[*cur_out / PAGE_SIZE] = cur_folio;
+			out_folios[*cur_out >> min_folio_shift] = cur_folio;
 		}
 		kaddr = kmap_local_folio(cur_folio, 0);
 
-		memcpy(kaddr + offset_in_page(*cur_out),
+		memcpy(kaddr + offset_in_folio(cur_folio, *cur_out),
 		       compressed_data + *cur_out - orig_out, copy_len);
 
 		*cur_out += copy_len;
@@ -221,6 +221,7 @@ int lzo_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	const u32 sectorsize = fs_info->sectorsize;
+	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
 	struct address_space *mapping = inode->vfs_inode.i_mapping;
 	struct folio *folio_in = NULL;
 	char *sizes_ptr;
@@ -287,8 +288,8 @@ int lzo_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			goto out;
 		}
 
-		/* Check if we have reached page boundary */
-		if (PAGE_ALIGNED(cur_in)) {
+		/* Check if we have reached folio boundary */
+		if (IS_ALIGNED(cur_in, min_folio_size)) {
 			folio_put(folio_in);
 			folio_in = NULL;
 		}
@@ -305,7 +306,7 @@ int lzo_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 out:
 	if (folio_in)
 		folio_put(folio_in);
-	*out_folios = DIV_ROUND_UP(cur_out, PAGE_SIZE);
+	*out_folios = DIV_ROUND_UP(cur_out, min_folio_size);
 	return ret;
 }
 
@@ -317,15 +318,16 @@ int lzo_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 static void copy_compressed_segment(struct compressed_bio *cb,
 				    char *dest, u32 len, u32 *cur_in)
 {
+	struct btrfs_fs_info *fs_info = cb_to_fs_info(cb);
+	const u32 min_folio_shift = PAGE_SHIFT + fs_info->block_min_order;
 	u32 orig_in = *cur_in;
 
 	while (*cur_in < orig_in + len) {
-		struct folio *cur_folio;
-		u32 copy_len = min_t(u32, PAGE_SIZE - offset_in_page(*cur_in),
-					  orig_in + len - *cur_in);
+		struct folio *cur_folio = cb->compressed_folios[*cur_in >> min_folio_shift];
+		u32 copy_len = min_t(u32, orig_in + len - *cur_in,
+				     folio_size(cur_folio) - offset_in_folio(cur_folio, *cur_in));
 
 		ASSERT(copy_len);
-		cur_folio = cb->compressed_folios[*cur_in / PAGE_SIZE];
 
 		memcpy_from_folio(dest + *cur_in - orig_in, cur_folio,
 				  offset_in_folio(cur_folio, *cur_in), copy_len);
@@ -339,6 +341,7 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	const struct btrfs_fs_info *fs_info = cb->bbio.inode->root->fs_info;
 	const u32 sectorsize = fs_info->sectorsize;
+	const u32 min_folio_shift = PAGE_SHIFT + fs_info->block_min_order;
 	char *kaddr;
 	int ret;
 	/* Compressed data length, can be unaligned */
@@ -385,10 +388,10 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		 */
 		ASSERT(cur_in / sectorsize ==
 		       (cur_in + LZO_LEN - 1) / sectorsize);
-		cur_folio = cb->compressed_folios[cur_in / PAGE_SIZE];
+		cur_folio = cb->compressed_folios[cur_in >> min_folio_shift];
 		ASSERT(cur_folio);
 		kaddr = kmap_local_folio(cur_folio, 0);
-		seg_len = read_compress_length(kaddr + offset_in_page(cur_in));
+		seg_len = read_compress_length(kaddr + offset_in_folio(cur_folio, cur_in));
 		kunmap_local(kaddr);
 		cur_in += LZO_LEN;
 
-- 
2.50.1


