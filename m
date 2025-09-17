Return-Path: <linux-btrfs+bounces-16902-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7C4B822F3
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 00:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496C51B28035
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 22:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5633231063C;
	Wed, 17 Sep 2025 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bezBRJPi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GgfkBqWD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C4230B500
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758149215; cv=none; b=Ct2CUIOMpUdd7uzGc1poS9Lhb56jyXCa5o1Qv6vOz/xd4vy8l+D+Oc41ePNZbG3hUsJTdTc2mgUKWOfq397TLyDiVhxov7EKjkQ+VFpPUm6rUgz+3ao1a8Ou039wIEpG6KH1KYasxcxFtF6CNLXsrImHA9xEHSLobd0Bu+1ite8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758149215; c=relaxed/simple;
	bh=h4Evn4+NtqC9q+lFTB2s9hYgALCwx6dVgrjIX8nrIcg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TealLCyurWJX5Dp9+2FT91NODCVqpsIjQD4Fac7TzgMw5XJYd2fhjZjYLG03m8CbQDgrSSpEPWRL+0PsVlfif21GCxpLZ8tGxKht0eGLF4v1UagY7c6kuxuw/NCKgP+HtQ26PAZpC8PQlWO561AWRnYwdoH+wpRKzPAKptKbwXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bezBRJPi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GgfkBqWD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D0E065D1CB
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 22:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758149200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=boH//wmXvqm6a1/wfn/Qksg2vYkHqNXs465TpiSN43Y=;
	b=bezBRJPiciYwaQRrHWMn1L5IjXAEs20KZlLGqlQhJMG6jaxsTwL3dEIqhZ5vQMVisnX6X/
	6LmL54Nu7TsulcFH8pzyLCCyof/njcASJFoiRpdfNsqI/O3bBj4IaDnAQ91xgE7L9nBBRB
	2V7mfxyTi+4L2zAM30dnQw2gttTXZwo=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=GgfkBqWD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758149199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=boH//wmXvqm6a1/wfn/Qksg2vYkHqNXs465TpiSN43Y=;
	b=GgfkBqWDXm8cMamXrPRqefoopwXtlPqmSt792r3kUKVIwumLNQ4b1Weh2avF7UFwFdLjbP
	iALeyti5yu1kA602IkxyZg/YXkzuYSqkp6qRJUxedr9nhKxbY76iFvunfsd6snY5ziRCe2
	qy5B0jKN6cdysJySao46ZNI60HYoCUI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FC781368D
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 22:46:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IPpGNU46y2j/HQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 22:46:38 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 3/8] btrfs: prepare lzo to support bs > ps cases
Date: Thu, 18 Sep 2025 08:16:08 +0930
Message-ID: <469716be3f2b1a316aa8074f522dca2031797a7d.1758147788.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1758147788.git.wqu@suse.com>
References: <cover.1758147788.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D0E065D1CB
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email]
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


