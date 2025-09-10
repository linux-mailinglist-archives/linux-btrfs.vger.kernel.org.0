Return-Path: <linux-btrfs+bounces-16773-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D16FFB50D0F
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 07:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196BC1C27252
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 05:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BF829C33D;
	Wed, 10 Sep 2025 05:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X1VGYw2U";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X1VGYw2U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68363259498
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 05:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757481516; cv=none; b=U+xOGed4A8mPssz6O957UiHtL6AI0ilSDUkAYT9nO5KDdEvhxdNzpaOM+SYbaCJ8R38bgB/f+9qWcXpITNtqFvElgQmRJKH94rgFBard3D1/Ci6pb8OOuUSvyfaIohP1/AP8/LVZJboaA0zObF5YI1854pmF9aS53IkwxJ9iz/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757481516; c=relaxed/simple;
	bh=ycmfGpzC3egHqNKTlRNTiF30+rqZMj4s1Qm1kUh9/OI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3Plvnwu8wdtQRADrKnTeELWDND5iDZDbNAdsujTy77aK+FXt3MYNoUHdCqH5qst36TjeGEG2nxiLvI5T5bkPPVFIhhRJCEhEH8U9Leqjyq3RrKdFVOSab7VlTihUXHjcMzsrJlfqPeUUcPWfCt5Qz46AUznjFPnhdtwalzKHSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X1VGYw2U; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X1VGYw2U; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3BC033703
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 05:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757481507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q892c4cA5W70L/sGUZ+hYCCgNPlX6M9MLuyBzM4uNww=;
	b=X1VGYw2U6xA2y9RcWsRNp5+R2gDxWiplIkmv7JBkd2AOFKilZFXgpR+IbXKMfIsXr7xl3p
	UqWQPMq8EIv4ELO76+3huhGiD8F55ImtPpMkFiBzTLsloxiLBdFYQ+zES1Y8HLJL9TGgs2
	ABW03SZFS6+dbvbb92UJptDLYZ37ia0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757481507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q892c4cA5W70L/sGUZ+hYCCgNPlX6M9MLuyBzM4uNww=;
	b=X1VGYw2U6xA2y9RcWsRNp5+R2gDxWiplIkmv7JBkd2AOFKilZFXgpR+IbXKMfIsXr7xl3p
	UqWQPMq8EIv4ELO76+3huhGiD8F55ImtPpMkFiBzTLsloxiLBdFYQ+zES1Y8HLJL9TGgs2
	ABW03SZFS6+dbvbb92UJptDLYZ37ia0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0A1413301
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 05:18:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4CrhJyIKwWjvdAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 05:18:26 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/4] btrfs: prepare zstd to support bs > ps cases
Date: Wed, 10 Sep 2025 14:48:04 +0930
Message-ID: <6eafe2db1ec8d5f8e6686083e3d12ba7b54f0195.1757481354.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757481354.git.wqu@suse.com>
References: <cover.1757481354.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

This involves converting the following functions to use proper folio
sizes/shifts:

- zstd_compress_folios()
- zstd_decompress_bio()

The function zstd_decompress() is already using block size correctly
without using page size, thus it needs no modification.

And since zstd compression is calling kmap_local_folio(), the existing
code can not handle large folios with HIGHMEM, as kmap_local_folio()
requires us to handle one page range each time.

I do not really think it's worthy to spend time on some feature that
will be deprecated eventually.
So here just add an extra explicit rejection for bs > ps with HIGHMEM
feature enabled kernels.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/fs.c   | 17 +++++++++++++++++
 fs/btrfs/zstd.c | 29 ++++++++++++++++-------------
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index 014fb8b12f96..35084b4e498b 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -79,6 +79,23 @@ bool __attribute_const__ btrfs_supported_blocksize(u32 blocksize)
 	if (blocksize == PAGE_SIZE || blocksize == SZ_4K || blocksize == BTRFS_MIN_BLOCKSIZE)
 		return true;
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
+	/*
+	 * For bs > ps support it's done by specifying a minimal folio order
+	 * for filemap, thus implying large data folios.
+	 * For HIGHMEM systems, we can not always access the content of a (large)
+	 * folio in one go, but go through them page by page.
+	 *
+	 * A lot of features doesn't implement a proper PAGE sized loop for large
+	 * folios, this includes:
+	 * - compression
+	 * - verity
+	 * - encoded write
+	 *
+	 * Considering HIGHMEM is such a pain in the backend and it's going
+	 * to be deprecated eventually, just reject HIGHMEM && bs > ps cases.
+	 */
+	if (IS_ENABLED(CONFIG_HIGHMEM) && blocksize > PAGE_SIZE)
+		return false;
 	if (blocksize <= PAGE_SIZE)
 		return true;
 #endif
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 28e2e99a2463..2f1593ddef4a 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -414,7 +414,8 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	const unsigned long nr_dest_folios = *out_folios;
 	const u64 orig_end = start + len;
 	const u32 blocksize = fs_info->sectorsize;
-	unsigned long max_out = nr_dest_folios * PAGE_SIZE;
+	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
+	unsigned long max_out = nr_dest_folios * min_folio_size;
 	unsigned int cur_len;
 
 	workspace->params = zstd_get_btrfs_parameters(workspace->req_level, len);
@@ -452,7 +453,7 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	folios[nr_folios++] = out_folio;
 	workspace->out_buf.dst = folio_address(out_folio);
 	workspace->out_buf.pos = 0;
-	workspace->out_buf.size = min_t(size_t, max_out, PAGE_SIZE);
+	workspace->out_buf.size = min_t(size_t, max_out, min_folio_size);
 
 	while (1) {
 		size_t ret2;
@@ -486,8 +487,8 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 
 		/* Check if we need more output space */
 		if (workspace->out_buf.pos == workspace->out_buf.size) {
-			tot_out += PAGE_SIZE;
-			max_out -= PAGE_SIZE;
+			tot_out += min_folio_size;
+			max_out -= min_folio_size;
 			if (nr_folios == nr_dest_folios) {
 				ret = -E2BIG;
 				goto out;
@@ -501,7 +502,7 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			workspace->out_buf.dst = folio_address(out_folio);
 			workspace->out_buf.pos = 0;
 			workspace->out_buf.size = min_t(size_t, max_out,
-							PAGE_SIZE);
+							min_folio_size);
 		}
 
 		/* We've reached the end of the input */
@@ -551,8 +552,8 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			goto out;
 		}
 
-		tot_out += PAGE_SIZE;
-		max_out -= PAGE_SIZE;
+		tot_out += min_folio_size;
+		max_out -= min_folio_size;
 		if (nr_folios == nr_dest_folios) {
 			ret = -E2BIG;
 			goto out;
@@ -565,7 +566,7 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 		folios[nr_folios++] = out_folio;
 		workspace->out_buf.dst = folio_address(out_folio);
 		workspace->out_buf.pos = 0;
-		workspace->out_buf.size = min_t(size_t, max_out, PAGE_SIZE);
+		workspace->out_buf.size = min_t(size_t, max_out, min_folio_size);
 	}
 
 	if (tot_out >= tot_in) {
@@ -587,14 +588,16 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 
 int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 {
+	struct btrfs_fs_info *fs_info = cb_to_fs_info(cb);
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	struct folio **folios_in = cb->compressed_folios;
 	size_t srclen = cb->compressed_len;
 	zstd_dstream *stream;
 	int ret = 0;
-	const u32 blocksize = cb_to_fs_info(cb)->sectorsize;
+	const u32 blocksize = fs_info->sectorsize;
+	const unsigned int min_folio_size = btrfs_min_folio_size(fs_info);
 	unsigned long folio_in_index = 0;
-	unsigned long total_folios_in = DIV_ROUND_UP(srclen, PAGE_SIZE);
+	unsigned long total_folios_in = DIV_ROUND_UP(srclen, min_folio_size);
 	unsigned long buf_start;
 	unsigned long total_out = 0;
 
@@ -612,7 +615,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
 	workspace->in_buf.src = kmap_local_folio(folios_in[folio_in_index], 0);
 	workspace->in_buf.pos = 0;
-	workspace->in_buf.size = min_t(size_t, srclen, PAGE_SIZE);
+	workspace->in_buf.size = min_t(size_t, srclen, min_folio_size);
 
 	workspace->out_buf.dst = workspace->buf;
 	workspace->out_buf.pos = 0;
@@ -657,11 +660,11 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 				ret = -EIO;
 				goto done;
 			}
-			srclen -= PAGE_SIZE;
+			srclen -= min_folio_size;
 			workspace->in_buf.src =
 				kmap_local_folio(folios_in[folio_in_index], 0);
 			workspace->in_buf.pos = 0;
-			workspace->in_buf.size = min_t(size_t, srclen, PAGE_SIZE);
+			workspace->in_buf.size = min_t(size_t, srclen, min_folio_size);
 		}
 	}
 	ret = 0;
-- 
2.50.1


