Return-Path: <linux-btrfs+bounces-9654-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA4F9C8E8B
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 16:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C94C1B35AF0
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 15:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3DD1B1D65;
	Thu, 14 Nov 2024 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="T+CtWO0k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99211ADFED
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598104; cv=none; b=Q7ta13NOd/DjDSw1HbuZEUfBiEUp6lMevvIMluk4Y2oriONu5OfZW1mPq7+fTGHfVB36tD//Qy8R9xgtU88lHINcPSaBIJswfg3YTfEuJvuYX4JaZ6Q6fOunfWrGhQFkKg1Q0g3ww2sofw/HlqUXBUErIbZ+r4LjztYHKjYBrp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598104; c=relaxed/simple;
	bh=uwlz9Ym4TNnGPdEk5eejNri0P+bccIlHRZuVyJuJRbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4m1g7pHC/1Yn5WyLpkEAx+776/6wizVypPGYuveflHYnWbwAdll9BlmDfm5YsBajrWXHv8VauII8Gb0Ip9B35rbgkzOFAs/JK+e+SNNyM8udbh0JpnSVTjiqZnnpgb0oOLd4R/u511/vLjxH4X3pghBPEeVtVngErCHL/1cI+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=T+CtWO0k; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-288d70788d6so301293fac.1
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 07:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731598100; x=1732202900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rF419cnvCI1sSo/lAda6/Cm28hf6CisfTzw5UCKZsOU=;
        b=T+CtWO0kMypsUNMiZEYgaw3U/o/nnP+YOpm6OWBCUljZr1TEMhQ6UzDDHhA0kYIYVe
         myBepZvo2h1tY1aMzxiQbXqqA1Ubms/q/xrtWVYPZAcslVw0yF83JDJEI1+u2ngwfthu
         6lCHu738WR2LRIEyYQIkTJFvrz3DJTFvmxtaVm2yCd072nyoIOPJbn1ATjhZWoW0jukJ
         CsfM1CdtcDRnkmoYZf5djvw02r9q/Mrx+zRUk1j8sbMsj3lfipDbVgzcnLa+EQRkrGhl
         PtmxUFmaX+THWwlpwPrOAiDBFcOtZRMD3dQlHPmsrqBu+WhLZNIoyboFl6f+h1cJj478
         uPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598100; x=1732202900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rF419cnvCI1sSo/lAda6/Cm28hf6CisfTzw5UCKZsOU=;
        b=cUr69dVU7jVSGom8dHCwZY/DiSBZDG/xddRpIcxLuef1KeKQtrdLWWIN3R+UOsz/bX
         11wxwPRbWdqyLe4RdDi06tS9KKxkIKUyZVkfWu0YUg6a5tmsezm6OcOcPK+teeQuJqHh
         cA5x5nO165URgHPLmlbffPAeYZKKrg2G/k8W7K/euvj8jhM5CNjhcBrCD6LP2kRWFFo6
         8e59wNNGPtxsEYRvGWU7xReuZbWBJwiYC0TWrudoD6KH8SmezYMFH2JAU35ZYE9y4FXD
         Mqo8SpBj4l96AKirfZW+TWdQhWMn2V5UL8kHWh9FlS2eRlx7VOhPh4Tk6MDGCo7Pge1i
         qOYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPko2TFTDuUXS6//PqqTtMrleGryDhoLOYHgwyJYaKISz8NF0O6xwROqI0LD9sUQphEplEZk/5/HyoQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqqEIaqFuyN6fM1jAfn+0S4cUaWu7L7U2tuB69/BN1GOsShLM8
	gWQg8ctCF/wrBhCBiMLMtDH8ank621SK1bk0ywYgRW5bNklDzNt6ekw0v621i4o=
X-Google-Smtp-Source: AGHT+IFrxjJdmj36oQy6UzPIhY6HkDZabl7PIZsT4CTZLD+yls1jl9nPP1SVyU+w5pEmbGgfnynQrw==
X-Received: by 2002:a05:6870:e0c6:b0:261:b48:3c99 with SMTP id 586e51a60fabf-29560143149mr21908350fac.23.1731598099964;
        Thu, 14 Nov 2024 07:28:19 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea026eb41sm368250eaf.39.2024.11.14.07.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:28:19 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/17] ext4: add RWF_UNCACHED write support
Date: Thu, 14 Nov 2024 08:25:17 -0700
Message-ID: <20241114152743.2381672-15-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114152743.2381672-2-axboe@kernel.dk>
References: <20241114152743.2381672-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IOCB_UNCACHED IO needs to prune writeback regions on IO completion,
and hence need the worker punt that ext4 also does for unwritten
extents. Add an io_end flag to manage that.

If foliop is set to foliop_uncached in ext4_write_begin(), then set
FGP_UNCACHED so that __filemap_get_folio() will mark newly created
folios as uncached. That in turn will make writeback completion drop
these ranges from the page cache.

Now that ext4 supports both uncached reads and writes, add the fop_flag
FOP_UNCACHED to enable it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/ext4/ext4.h    |  1 +
 fs/ext4/file.c    |  2 +-
 fs/ext4/inline.c  |  7 ++++++-
 fs/ext4/inode.c   | 18 ++++++++++++++++--
 fs/ext4/page-io.c | 28 ++++++++++++++++------------
 5 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 44b0d418143c..60dc9ffae076 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -279,6 +279,7 @@ struct ext4_system_blocks {
  * Flags for ext4_io_end->flags
  */
 #define	EXT4_IO_END_UNWRITTEN	0x0001
+#define EXT4_IO_UNCACHED	0x0002
 
 struct ext4_io_end_vec {
 	struct list_head list;		/* list of io_end_vec */
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index f14aed14b9cf..0ef39d738598 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -944,7 +944,7 @@ const struct file_operations ext4_file_operations = {
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= ext4_fallocate,
 	.fop_flags	= FOP_MMAP_SYNC | FOP_BUFFER_RASYNC |
-			  FOP_DIO_PARALLEL_WRITE,
+			  FOP_DIO_PARALLEL_WRITE | FOP_UNCACHED,
 };
 
 const struct inode_operations ext4_file_inode_operations = {
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 3536ca7e4fcc..500bfb6d4860 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -667,6 +667,7 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 	handle_t *handle;
 	struct folio *folio;
 	struct ext4_iloc iloc;
+	fgf_t fgp_flags;
 
 	if (pos + len > ext4_get_max_inline_size(inode))
 		goto convert;
@@ -702,7 +703,11 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 	if (ret)
 		goto out;
 
-	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
+	fgp_flags = FGP_WRITEBEGIN | FGP_NOFS;
+	if (foliop_is_uncached(foliop))
+		fgp_flags |= FGP_UNCACHED;
+
+	folio = __filemap_get_folio(mapping, 0, fgp_flags,
 					mapping_gfp_mask(mapping));
 	if (IS_ERR(folio)) {
 		ret = PTR_ERR(folio);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 54bdd4884fe6..9b815137fb2c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1138,6 +1138,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	int ret, needed_blocks;
 	handle_t *handle;
 	int retries = 0;
+	fgf_t fgp_flags;
 	struct folio *folio;
 	pgoff_t index;
 	unsigned from, to;
@@ -1164,6 +1165,15 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 			return 0;
 	}
 
+	/*
+	 * Set FGP_WRITEBEGIN, and FGP_UNCACHED if foliop is marked as
+	 * uncached. That's how generic_perform_write() informs us that this
+	 * is an uncached write.
+	 */
+	fgp_flags = FGP_WRITEBEGIN;
+	if (foliop_is_uncached(foliop))
+		fgp_flags |= FGP_UNCACHED;
+
 	/*
 	 * __filemap_get_folio() can take a long time if the
 	 * system is thrashing due to memory pressure, or if the folio
@@ -1172,7 +1182,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	 * the folio (if needed) without using GFP_NOFS.
 	 */
 retry_grab:
-	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+	folio = __filemap_get_folio(mapping, index, fgp_flags,
 					mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
@@ -2903,6 +2913,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	struct folio *folio;
 	pgoff_t index;
 	struct inode *inode = mapping->host;
+	fgf_t fgp_flags;
 
 	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
 		return -EIO;
@@ -2926,8 +2937,11 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 			return 0;
 	}
 
+	fgp_flags = FGP_WRITEBEGIN;
+	if (foliop_is_uncached(foliop))
+		fgp_flags |= FGP_UNCACHED;
 retry:
-	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+	folio = __filemap_get_folio(mapping, index, fgp_flags,
 			mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index ad5543866d21..10447c3c4ff1 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -226,8 +226,6 @@ static void ext4_add_complete_io(ext4_io_end_t *io_end)
 	unsigned long flags;
 
 	/* Only reserved conversions from writeback should enter here */
-	WARN_ON(!(io_end->flag & EXT4_IO_END_UNWRITTEN));
-	WARN_ON(!io_end->handle && sbi->s_journal);
 	spin_lock_irqsave(&ei->i_completed_io_lock, flags);
 	wq = sbi->rsv_conversion_wq;
 	if (list_empty(&ei->i_rsv_conversion_list))
@@ -252,7 +250,7 @@ static int ext4_do_flush_completed_IO(struct inode *inode,
 
 	while (!list_empty(&unwritten)) {
 		io_end = list_entry(unwritten.next, ext4_io_end_t, list);
-		BUG_ON(!(io_end->flag & EXT4_IO_END_UNWRITTEN));
+		BUG_ON(!(io_end->flag & (EXT4_IO_END_UNWRITTEN|EXT4_IO_UNCACHED)));
 		list_del_init(&io_end->list);
 
 		err = ext4_end_io_end(io_end);
@@ -287,14 +285,15 @@ ext4_io_end_t *ext4_init_io_end(struct inode *inode, gfp_t flags)
 
 void ext4_put_io_end_defer(ext4_io_end_t *io_end)
 {
-	if (refcount_dec_and_test(&io_end->count)) {
-		if (!(io_end->flag & EXT4_IO_END_UNWRITTEN) ||
-				list_empty(&io_end->list_vec)) {
-			ext4_release_io_end(io_end);
-			return;
-		}
-		ext4_add_complete_io(io_end);
+	if (!refcount_dec_and_test(&io_end->count))
+		return;
+	if ((!(io_end->flag & EXT4_IO_END_UNWRITTEN) ||
+	    list_empty(&io_end->list_vec)) &&
+	    !(io_end->flag & EXT4_IO_UNCACHED)) {
+		ext4_release_io_end(io_end);
+		return;
 	}
+	ext4_add_complete_io(io_end);
 }
 
 int ext4_put_io_end(ext4_io_end_t *io_end)
@@ -348,7 +347,7 @@ static void ext4_end_bio(struct bio *bio)
 				blk_status_to_errno(bio->bi_status));
 	}
 
-	if (io_end->flag & EXT4_IO_END_UNWRITTEN) {
+	if (io_end->flag & (EXT4_IO_END_UNWRITTEN|EXT4_IO_UNCACHED)) {
 		/*
 		 * Link bio into list hanging from io_end. We have to do it
 		 * atomically as bio completions can be racing against each
@@ -417,8 +416,13 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
 submit_and_retry:
 		ext4_io_submit(io);
 	}
-	if (io->io_bio == NULL)
+	if (io->io_bio == NULL) {
 		io_submit_init_bio(io, bh);
+		if (folio_test_uncached(folio)) {
+			ext4_io_end_t *io_end = io->io_bio->bi_private;
+			io_end->flag |= EXT4_IO_UNCACHED;
+		}
+	}
 	if (!bio_add_folio(io->io_bio, io_folio, bh->b_size, bh_offset(bh)))
 		goto submit_and_retry;
 	wbc_account_cgroup_owner(io->io_wbc, &folio->page, bh->b_size);
-- 
2.45.2


