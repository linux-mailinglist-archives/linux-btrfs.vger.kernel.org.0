Return-Path: <linux-btrfs+bounces-17308-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23199BAFEA8
	for <lists+linux-btrfs@lfdr.de>; Wed, 01 Oct 2025 11:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A7F3B24F1
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Oct 2025 09:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132A9286D40;
	Wed,  1 Oct 2025 09:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bmLmKrag";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WhRu4u5d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A72238D42
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759312238; cv=none; b=FHid7nvI8M+9rmMKbEO/QS77GSfUc6ru+y1favG2Cy+WsMwxqlLldqIFqOHR2LhHszoViHpv4wVUGyCn2Lgzi9KY20vVoF/FLd5z8U/OkVGmj096XGWxQ++BllAMzvlq1QMIHTN6M7TkOKZlyUjsYbEKpUEHqSO3flNzeibXbDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759312238; c=relaxed/simple;
	bh=samKGaXk3EWPXLpt/UKVbbW+jahcOIy1kkaxtXomut0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxxuwdkbj8dGWYn8KGwCqAsudRqdmmv0nwfssMCTh5kVQjZJTYw3jcaAy4Ut1rc/awHsSuAyDeTqDwr+w4LDwNxdMLCHji8Ytg9uWIGnbc3kuBENPTB1dAX4CrFePjzgOen5hI/sxYKC9NjeflyStBazbqmqzgLkqQa9zyTfbao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bmLmKrag; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WhRu4u5d; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EBBE01F456
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 09:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759312232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eOgAGwNG40pIdf+eJx3ah8iBvNd019BwFISmbm3lPm4=;
	b=bmLmKragIdEYZnpTbXJ37eY9O9kSPVDUCff0i246iwps7ZVJ/ymk+VveeB5YvRCuzXhYM3
	eB60hIJnGammRTRyyoA7IP10JgJUiDDzoXIri4EYyv+sGui7SfJ/gA3COJvoOrAe+JS/H9
	vRhTHsTL+HDq7dyIjj7Dr08MZfsBgpg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=WhRu4u5d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759312231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eOgAGwNG40pIdf+eJx3ah8iBvNd019BwFISmbm3lPm4=;
	b=WhRu4u5dbi2RqtvLn767fRWyg9T8oJHyqWFi99Aw3h1So79QH52cmwrcEOOgAansmqRIe1
	j2jUytSaXPvaaxwL9E+ZScBgB0mGitB47tzOt8Fts9HqGU5im2KcLVpTtNGBTo0+otkSos
	dvR/2IikOawDbyzTXN+twotwGrQMPm0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 351A513A3F
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 09:50:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WKsDOmb53GikSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 01 Oct 2025 09:50:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: enable encoded read/write/send for bs > ps cases
Date: Wed,  1 Oct 2025 19:20:08 +0930
Message-ID: <a65187d492cd65649b28d7a3e84090ba11c8d8c3.1759311101.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1759311100.git.wqu@suse.com>
References: <cover.1759311100.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EBBE01F456
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email]
X-Spam-Score: -3.01

Since the read verification and read repair are all supporting bs > ps
without large folios now, we can enable encoded read/write/send.

Now we can relax the alignment in assert_bbio_alignment() to
min(blocksize, PAGE_SIZE).
But also add the extra blocksize based alignment check for the logical
and length of the bbio.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c   | 22 ++++++++++++----------
 fs/btrfs/ioctl.c | 21 ---------------------
 fs/btrfs/send.c  |  9 +--------
 3 files changed, 13 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index a29812d3d2c9..35c154aff95e 100644
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


