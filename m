Return-Path: <linux-btrfs+bounces-18853-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02882C49A22
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 23:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC7B3A3D71
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 22:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0A72D8DD0;
	Mon, 10 Nov 2025 22:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="i9z4DSkd";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="i9z4DSkd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B25246788
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762814569; cv=none; b=qZZJiZDyVcC5DxRFloO6to83/GR6iW+gwFqSu/iHZl95XiCL39iD3cmjLYwVx+YHtfD+0Tj1nNaUDMWRxEyrhc4bPUguz3InB2RojuHyHJCMRsKiFcxKVvjJk/HrUL6JbWM15e9NekHew6OTHoDaFHXrStu+3+Atl8PSzkPtz4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762814569; c=relaxed/simple;
	bh=BUCDBoiXeuTfUDGufUKO4h0BYpRyyLK/q6HydphGphw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwT9nswqKL3Uo+cVGDyd6K90JoJoTpABakFDvn5cnU3tNcqhtN+zwerRAPdF63Sfh4dJOyzEUPbC3rJltblNArQbhM12Me8IyDUrbSYdsIjKg5A8ua+oF/4KN0k9NLsotVCAIFY1i3VraKsCvgyfhTMPwirTQr9dw99VvEOkpT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=i9z4DSkd; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=i9z4DSkd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 60EE421EA7
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 22:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762814548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=58nUARqHSqxAYAlTTN65ktHQuPWlcBtm0xOrwJLhHmU=;
	b=i9z4DSkd/dRUqgzu2U0dJKGizhA43iG4tf64QBNMg8Zxf3qbWmrjijAIhDUxINUegIR57K
	cPlFGxUjaBKtt0LVfUcPhGCPRntsc5ZjfA+EwckFAgfeuOYyYFQ14e1idhELS53L6VJl/h
	+zzJbJ3I2Vcl2Eh/7RpC2im2FP5tbJU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762814548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=58nUARqHSqxAYAlTTN65ktHQuPWlcBtm0xOrwJLhHmU=;
	b=i9z4DSkd/dRUqgzu2U0dJKGizhA43iG4tf64QBNMg8Zxf3qbWmrjijAIhDUxINUegIR57K
	cPlFGxUjaBKtt0LVfUcPhGCPRntsc5ZjfA+EwckFAgfeuOYyYFQ14e1idhELS53L6VJl/h
	+zzJbJ3I2Vcl2Eh/7RpC2im2FP5tbJU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E85C14623
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 22:42:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oBFAGFNqEmk/agAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 22:42:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 4/4] btrfs: enable encoded read/write/send for bs > ps cases
Date: Tue, 11 Nov 2025 09:12:01 +1030
Message-ID: <0ababe5a839a4f33ff32d8baf3fc7be575fecc49.1762814274.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1762814274.git.wqu@suse.com>
References: <cover.1762814274.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.72 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.12)[-0.584];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.72
X-Spam-Level: 

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
index fcd28eb68247..1b38e3ee0a33 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -867,21 +867,23 @@ static void assert_bbio_alignment(struct btrfs_bio *bbio)
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
index ef6e4d1662cc..2c94432c2791 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -342,21 +342,21 @@ static void end_bbio_compressed_write(struct btrfs_bio *bbio)
 
 static void btrfs_add_compressed_bio_folios(struct compressed_bio *cb)
 {
-	struct btrfs_fs_info *fs_info = cb->bbio.inode->root->fs_info;
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
index b524db8a4973..1920caf8d308 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4408,10 +4408,6 @@ static int btrfs_ioctl_encoded_read(struct file *file, void __user *argp,
 		goto out_acct;
 	}
 
-	if (fs_info->sectorsize > PAGE_SIZE) {
-		ret = -ENOTTY;
-		goto out_acct;
-	}
 	if (compat) {
 #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
 		struct btrfs_ioctl_encoded_io_args_32 args32;
@@ -4503,7 +4499,6 @@ static int btrfs_ioctl_encoded_read(struct file *file, void __user *argp,
 
 static int btrfs_ioctl_encoded_write(struct file *file, void __user *argp, bool compat)
 {
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(file->f_inode);
 	struct btrfs_ioctl_encoded_io_args args;
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov = iovstack;
@@ -4517,11 +4512,6 @@ static int btrfs_ioctl_encoded_write(struct file *file, void __user *argp, bool
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
@@ -4803,11 +4793,6 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
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
@@ -4935,7 +4920,6 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
 	struct file *file = cmd->file;
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(file->f_inode);
 	loff_t pos;
 	struct kiocb kiocb;
 	ssize_t ret;
@@ -4950,11 +4934,6 @@ static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issu
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
index 9312d74400a3..fa94105e139a 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5634,14 +5634,7 @@ static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
 
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
2.51.2


