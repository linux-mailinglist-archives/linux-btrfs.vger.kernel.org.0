Return-Path: <linux-btrfs+bounces-17451-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824FFBBD04A
	for <lists+linux-btrfs@lfdr.de>; Mon, 06 Oct 2025 05:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3FE189255B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Oct 2025 04:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6521D5CE8;
	Mon,  6 Oct 2025 03:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="D6aJ8ie6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="D6aJ8ie6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B9D1B3935
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Oct 2025 03:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759723177; cv=none; b=hQdaGDT35BjIl2YE9rUGRb6/TfktUUdJ7RYhyqHT1BiF4PBayJRvGSOJSL+ErJ0MGWr0HoC0JNLGlxgWaa2B0ubViO6TW5WKYHHehn2BMTfMVIOFE40Lc/e5fiQH80moMR7ZfS3y5VO8vO5K17wQcA9SyChnJSGyFj7NG7vTKoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759723177; c=relaxed/simple;
	bh=9k0+Sh+3gk2mYUb532Mu6rnUY2c8CdBoADN3lkK9yfA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQtmxRcwrH6vBQWDILKccv1f8GujYMjwYgsxrQTBYVTBxdyLx1q7WVXYBuImVzyO3RHgv/PzIriTPOWQylFysiEZ8ghhv7gvei1He1R8CKHY+tttAG+k7+4F1xIJzwyqimRAM2iAYA0EurHZQ/Tg6Tnc5hvrnSC7NPor0y4/2+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D6aJ8ie6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D6aJ8ie6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0E7BF1F7B9
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Oct 2025 03:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759723157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jicFlG+23k2EIMW2clFcKh1mk1+SsxM+K5WQK11e/xM=;
	b=D6aJ8ie6O6TtxHv9u4JEsvQxfjSIz2tGrKhzoV+UdY079xPkeqgfvLcOd4cEuld5fXeZGx
	lqduE50833V2VkvhRisvrmRKtFl9lP44rYKgvl0bbCExvaGBUyQOLk3B48xm50omWlR8cs
	c/IKjtc6vWY1BhirT4/0+n75n6VcI78=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=D6aJ8ie6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759723157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jicFlG+23k2EIMW2clFcKh1mk1+SsxM+K5WQK11e/xM=;
	b=D6aJ8ie6O6TtxHv9u4JEsvQxfjSIz2tGrKhzoV+UdY079xPkeqgfvLcOd4cEuld5fXeZGx
	lqduE50833V2VkvhRisvrmRKtFl9lP44rYKgvl0bbCExvaGBUyQOLk3B48xm50omWlR8cs
	c/IKjtc6vWY1BhirT4/0+n75n6VcI78=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A22F1386E
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Oct 2025 03:59:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MFaFA5Q+42gDaAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 06 Oct 2025 03:59:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 4/4] btrfs: enable encoded read/write/send for bs > ps cases
Date: Mon,  6 Oct 2025 14:28:53 +1030
Message-ID: <780169c19cbd17f63a8c98e033184c8833fa0af2.1759708020.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1759708020.git.wqu@suse.com>
References: <cover.1759708020.git.wqu@suse.com>
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 0E7BF1F7B9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Since the read verification and read repair are all supporting bs > ps
without large folios now, we can enable encoded read/write/send.

Now we can relax the alignment in assert_bbio_alignment() to
min(blocksize, PAGE_SIZE).
But also add the extra blocksize based alignment check for the logical
and length of the bbio.

There is a pitfall in btrfs_add_compress_bio_folios(), which relies on
the folios passed in to meet the minimal folio order.
But now we can pass regular page sized folios in, update it to check
each folio's size instead of using the minimal folio size.

This allows btrfs_add_compress_bio_folios() to even handle folios array
with different sizes, thankfully we don't yet need to handle such crazy
situation.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c         | 22 ++++++++++++----------
 fs/btrfs/compression.c | 10 +++++-----
 fs/btrfs/ioctl.c       | 21 ---------------------
 fs/btrfs/send.c        |  9 +--------
 4 files changed, 18 insertions(+), 44 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index c2b6b950d8dd..75c838d0c07b 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -825,21 +825,23 @@ static void assert_bbio_alignment(struct btrfs_bio *bbio)
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 	const u32 blocksize = fs_info->sectorsize;
+	const u32 alignment = min(blocksize, PAGE_SIZE);
+	const u64 logical = bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
+	const u32 length = bbio->bio.bi_iter.bi_size;
 
-	/* Metadata has no extra bs > ps alignment requirement. */
-	if (!is_data_bbio(bbio))
-		return;
+	/* The logical and length should still be aligned to blocksize. */
+	ASSERT(IS_ALIGNED(logical, blocksize) && IS_ALIGNED(length, blocksize) &&
+	       length != 0, "root=%llu inode=%llu logical=%llu length=%u",
+	       btrfs_root_id(bbio->inode->root),
+	       btrfs_ino(bbio->inode), logical, length);
 
 	bio_for_each_bvec(bvec, &bbio->bio, iter)
-		ASSERT(IS_ALIGNED(bvec.bv_offset, blocksize) &&
-		       IS_ALIGNED(bvec.bv_len, blocksize),
+		ASSERT(IS_ALIGNED(bvec.bv_offset, alignment) &&
+		       IS_ALIGNED(bvec.bv_len, alignment),
 		"root=%llu inode=%llu logical=%llu length=%u index=%u bv_offset=%u bv_len=%u",
 		btrfs_root_id(bbio->inode->root),
-		btrfs_ino(bbio->inode),
-		bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT,
-		bbio->bio.bi_iter.bi_size, iter.bi_idx,
-		bvec.bv_offset,
-		bvec.bv_len);
+		btrfs_ino(bbio->inode), logical, length, iter.bi_idx,
+		bvec.bv_offset, bvec.bv_len);
 #endif
 }
 
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index bacad18357b3..82c43496011c 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -354,21 +354,21 @@ static void end_bbio_compressed_write(struct btrfs_bio *bbio)
 
 static void btrfs_add_compressed_bio_folios(struct compressed_bio *cb)
 {
-	struct btrfs_fs_info *fs_info = cb->bbio.fs_info;
 	struct bio *bio = &cb->bbio.bio;
 	u32 offset = 0;
+	unsigned int findex = 0;
 
 	while (offset < cb->compressed_len) {
-		struct folio *folio;
-		int ret;
+		struct folio *folio = cb->compressed_folios[findex];
 		u32 len = min_t(u32, cb->compressed_len - offset,
-				btrfs_min_folio_size(fs_info));
+				folio_size(folio));
+		int ret;
 
-		folio = cb->compressed_folios[offset >> (PAGE_SHIFT + fs_info->block_min_order)];
 		/* Maximum compressed extent is smaller than bio size limit. */
 		ret = bio_add_folio(bio, folio, len, 0);
 		ASSERT(ret);
 		offset += len;
+		findex++;
 	}
 }
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 938286bee6a8..552ad99e89fc 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4418,10 +4418,6 @@ static int btrfs_ioctl_encoded_read(struct file *file, void __user *argp,
 		goto out_acct;
 	}
 
-	if (fs_info->sectorsize > PAGE_SIZE) {
-		ret = -ENOTTY;
-		goto out_acct;
-	}
 	if (compat) {
 #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
 		struct btrfs_ioctl_encoded_io_args_32 args32;
@@ -4513,7 +4509,6 @@ static int btrfs_ioctl_encoded_read(struct file *file, void __user *argp,
 
 static int btrfs_ioctl_encoded_write(struct file *file, void __user *argp, bool compat)
 {
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(file->f_inode);
 	struct btrfs_ioctl_encoded_io_args args;
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov = iovstack;
@@ -4527,11 +4522,6 @@ static int btrfs_ioctl_encoded_write(struct file *file, void __user *argp, bool
 		goto out_acct;
 	}
 
-	if (fs_info->sectorsize > PAGE_SIZE) {
-		ret = -ENOTTY;
-		goto out_acct;
-	}
-
 	if (!(file->f_mode & FMODE_WRITE)) {
 		ret = -EBADF;
 		goto out_acct;
@@ -4813,11 +4803,6 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 		ret = -EPERM;
 		goto out_acct;
 	}
-	if (fs_info->sectorsize > PAGE_SIZE) {
-		ret = -ENOTTY;
-		goto out_acct;
-	}
-
 	sqe_addr = u64_to_user_ptr(READ_ONCE(cmd->sqe->addr));
 
 	if (issue_flags & IO_URING_F_COMPAT) {
@@ -4945,7 +4930,6 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
 	struct file *file = cmd->file;
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(file->f_inode);
 	loff_t pos;
 	struct kiocb kiocb;
 	ssize_t ret;
@@ -4960,11 +4944,6 @@ static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issu
 		ret = -EPERM;
 		goto out_acct;
 	}
-	if (fs_info->sectorsize > PAGE_SIZE) {
-		ret = -ENOTTY;
-		goto out_acct;
-	}
-
 	sqe_addr = u64_to_user_ptr(READ_ONCE(cmd->sqe->addr));
 
 	if (!(file->f_mode & FMODE_WRITE)) {
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 9230e5066fc6..1fcc820f6baf 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5601,14 +5601,7 @@ static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
 
 	ei = btrfs_item_ptr(leaf, path->slots[0],
 			    struct btrfs_file_extent_item);
-	/*
-	 * Do not go through encoded read for bs > ps cases.
-	 *
-	 * Encoded send is using vmallocated pages as buffer, which we can
-	 * not ensure every folio is large enough to contain a block.
-	 */
-	if (sctx->send_root->fs_info->sectorsize <= PAGE_SIZE &&
-	    (sctx->flags & BTRFS_SEND_FLAG_COMPRESSED) &&
+	if ((sctx->flags & BTRFS_SEND_FLAG_COMPRESSED) &&
 	    btrfs_file_extent_compression(leaf, ei) != BTRFS_COMPRESS_NONE) {
 		bool is_inline = (btrfs_file_extent_type(leaf, ei) ==
 				  BTRFS_FILE_EXTENT_INLINE);
-- 
2.50.1


