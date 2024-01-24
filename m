Return-Path: <linux-btrfs+bounces-1717-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D751183AFA4
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664B11F2A492
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D975128386;
	Wed, 24 Jan 2024 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="jbUsQSyP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FAD1272DC
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116799; cv=none; b=ibCdtLl+Xs9/0b5fvJFCw3pIHytgpZm1cb614YURTn0lVKvpMSXcllVNTpwlqV4Q98/3s8g/LluGXG9/K9tfhQT8pXF78HHC9gUOsKRax3bD6WAg151hHKRgLXbJ5VPJx9GrtKgh4/NkIz8OyY+7fm/L0jewNwU/4PL9bbkLwIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116799; c=relaxed/simple;
	bh=rLS84C8rNkGqB9Esla4F9HnNaRwj2+833wNcTq8HVWI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXeAfL71DB+k8UO2mx7yM27EPY40JFOtaisb9wRdVHTQ+Do+mBITeAWcx9T9Jo5QxJfriuKMIW5m3M80YuZGZvJzJblafsn7+gkI7YvBHygiRyoUS8E25tCvt2xX+0f6FtaWVQDFkvTH0JE0p8rrZPakb36AZl4iDxmqUppYhHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=jbUsQSyP; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5f0629e67f4so61001017b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116796; x=1706721596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDEqPk0kWMR3iz0QvMpGYMU1WA6eE2R/mgYIl1+rHn4=;
        b=jbUsQSyPhbG13uh4nRQ/d+/3m4p7iDPourvukqp2Lf+nm0W9KN+3T68iTa2+s/IMPb
         KGndZnNovw3ze1ZAtDvAcvfuJUmnVKwFkCgLMXcDHKBGeYvg3EvbBq4ydR0xbqAHLQ/W
         /JU4IfyljzrLmeXssvQBE7+wlhcd96Ay0nJpplWQnnYo18akYjHFTCPZW8je/+RVVwCg
         izlfxfOXqDVzGd7RqHsmtPFRungkf2dDV1FhW59OJB6tNr/HLVN9yx5rrFv/Oc6DptI6
         HjBRzx8nRjRpoJXnCAlAlKUoTKExa1w1tYTgLUpyFLMPOx/ZE3z7ZBX3OtqJP8Th+wCr
         uYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116796; x=1706721596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDEqPk0kWMR3iz0QvMpGYMU1WA6eE2R/mgYIl1+rHn4=;
        b=c5ihbHimED9spt0hPav78D7SIaKS+Xzf/oXPlQPg2CzGgDTYiluzTbLZPOoPfKylDN
         KcNH404x6aOI6LXVo/7wc2kaO56z5t4LMiJy5kEpNMAARKuAjgMI8IVpjsff+Huq91cl
         crbrXlv0mBW2uYO5mZDN2eNG4ROvbdom2bIBu5XvkplRW825aB0kwQY6zKaLlb5jGoZZ
         gjPgKRYFaUhXFGIPSpQWGCP1FlTEHOQMVMAPwuDBSGFo2wS7BZQ53aWbI6PBcKm3ob+U
         pSEejWI7XZrX1VZ3EMseEiZDYlTK0bwhakm4YoAlHSu5k2cDMbaZD4h3I4AWW6qGwi9l
         LhhQ==
X-Gm-Message-State: AOJu0Yzv1+K8jMG5QcZDEG3bXtjKtNLoElXpOi+zpT4kP/VmaGtom3tz
	qBYopJqY0qjunR0Wd7D2RqWgq1LmNoNzKtkpo2s95G79Gl7eaJXfjgjlVy/LVkDpIx60Z4hh2ei
	s
X-Google-Smtp-Source: AGHT+IFGRXTBevhIg+6AX6A1xVh1aYdS1mq4HWxm4xcwmeJLZLFPyKN71urX6fUpl1N9itsKRNJLlA==
X-Received: by 2002:a0d:d346:0:b0:5ff:55dd:bf65 with SMTP id v67-20020a0dd346000000b005ff55ddbf65mr1087624ywd.65.1706116795076;
        Wed, 24 Jan 2024 09:19:55 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id cj28-20020a05690c0b1c00b005ff9f60b8besm61291ywb.84.2024.01.24.09.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:54 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 34/52] btrfs: set the bio fscrypt context when applicable
Date: Wed, 24 Jan 2024 12:18:56 -0500
Message-ID: <9ca883acc746b5aba980d1d19317168a7491aba6.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have the fscrypt_info plumbed through everywhere, add the
code to setup the bio encryption context from the extent context.

We use the per-extent fscrypt_extent_info for encryption/decryption.
We use the offset into the extent as the lblk for fscrypt.  So the start
of the extent has the lblk of 0, 4k into the extent has the lblk of 4k,
etc.  This is done to allow things like relocation to continue to work
properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/compression.c |  6 ++++
 fs/btrfs/extent_io.c   | 76 +++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/fscrypt.c     | 36 ++++++++++++++++++++
 fs/btrfs/fscrypt.h     | 22 ++++++++++++
 fs/btrfs/inode.c       | 10 ++++++
 5 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 68345f73d429..5988813c5bd0 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -37,6 +37,7 @@
 #include "zoned.h"
 #include "file-item.h"
 #include "super.h"
+#include "fscrypt.h"
 
 static struct bio_set btrfs_compressed_bioset;
 
@@ -396,6 +397,9 @@ void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
 	cb->bbio.ordered = ordered;
 	btrfs_add_compressed_bio_pages(cb);
 
+	btrfs_set_bio_crypt_ctx_from_extent(&cb->bbio.bio, inode,
+					    ordered->fscrypt_info, 0);
+
 	btrfs_submit_bio(&cb->bbio, 0);
 }
 
@@ -600,6 +604,8 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	cb->compress_type = extent_map_compression(em);
 	cb->orig_bbio = bbio;
 
+	btrfs_set_bio_crypt_ctx_from_extent(&cb->bbio.bio, inode,
+					    em->fscrypt_info, 0);
 	free_extent_map(em);
 
 	cb->nr_pages = DIV_ROUND_UP(compressed_len, PAGE_SIZE);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 19c4f0657098..43680f26ddbe 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -36,6 +36,7 @@
 #include "dev-replace.h"
 #include "super.h"
 #include "transaction.h"
+#include "fscrypt.h"
 
 static struct kmem_cache *extent_buffer_cache;
 
@@ -103,6 +104,10 @@ struct btrfs_bio_ctrl {
 	blk_opf_t opf;
 	btrfs_bio_end_io_t end_io_func;
 	struct writeback_control *wbc;
+
+	/* This is set for reads and we have encryption. */
+	struct fscrypt_extent_info *fscrypt_info;
+	u64 orig_start;
 };
 
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
@@ -739,10 +744,31 @@ static bool btrfs_bio_is_contig(struct btrfs_bio_ctrl *bio_ctrl,
 				struct page *page, u64 disk_bytenr,
 				unsigned int pg_offset)
 {
-	struct bio *bio = &bio_ctrl->bbio->bio;
+	struct inode *inode = page->mapping->host;
+	struct btrfs_bio *bbio = bio_ctrl->bbio;
+	struct bio *bio = &bbio->bio;
 	struct bio_vec *bvec = bio_last_bvec_all(bio);
 	const sector_t sector = disk_bytenr >> SECTOR_SHIFT;
 
+	if (IS_ENCRYPTED(inode)) {
+		u64 file_offset = page_offset(page) + pg_offset;
+		u64 offset = 0;
+		struct fscrypt_extent_info *fscrypt_info = NULL;
+
+		/* bio_ctrl->fscrypt_info is only set in the READ case. */
+		if (bio_ctrl->fscrypt_info) {
+			offset = file_offset - bio_ctrl->orig_start;
+			fscrypt_info = bio_ctrl->fscrypt_info;
+		} else if (bbio->ordered) {
+			fscrypt_info = bbio->ordered->fscrypt_info;
+			offset = file_offset - bbio->ordered->orig_offset;
+		}
+
+		if (!btrfs_mergeable_encrypted_bio(bio, inode, fscrypt_info,
+						   offset))
+			return false;
+	}
+
 	if (bio_ctrl->compress_type != BTRFS_COMPRESS_NONE) {
 		/*
 		 * For compression, all IO should have its logical bytenr set
@@ -773,6 +799,8 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_bio *bbio;
+	struct fscrypt_extent_info *fscrypt_info = NULL;
+	u64 offset = 0;
 
 	bbio = btrfs_bio_alloc(BIO_MAX_VECS, bio_ctrl->opf, fs_info,
 			       bio_ctrl->end_io_func, NULL);
@@ -792,6 +820,8 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 					ordered->file_offset +
 					ordered->disk_num_bytes - file_offset);
 			bbio->ordered = ordered;
+			fscrypt_info = ordered->fscrypt_info;
+			offset = file_offset - ordered->orig_offset;
 		}
 
 		/*
@@ -802,7 +832,13 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 		 */
 		bio_set_dev(&bbio->bio, fs_info->fs_devices->latest_dev->bdev);
 		wbc_init_bio(bio_ctrl->wbc, &bbio->bio);
+	} else {
+		fscrypt_info = bio_ctrl->fscrypt_info;
+		offset = file_offset - bio_ctrl->orig_start;
 	}
+
+	btrfs_set_bio_crypt_ctx_from_extent(&bbio->bio, inode, fscrypt_info,
+					    offset);
 }
 
 /*
@@ -846,6 +882,19 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 			len = bio_ctrl->len_to_oe_boundary;
 		}
 
+		/*
+		 * Encryption has to allocate bounce buffers to encrypt the bio,
+		 * and we need to make sure that it doesn't split the bio so we
+		 * retain all of our special info in the btrfs_bio, so submit
+		 * any bio that gets up to BIO_MAX_VECS worth of segments.
+		 */
+		if (IS_ENCRYPTED(&inode->vfs_inode) &&
+		    bio_data_dir(&bio_ctrl->bbio->bio) == WRITE &&
+		    bio_segments(&bio_ctrl->bbio->bio) == BIO_MAX_VECS) {
+			submit_one_bio(bio_ctrl);
+			continue;
+		}
+
 		if (bio_add_page(&bio_ctrl->bbio->bio, page, len, pg_offset) != len) {
 			/* bio full: move on to a new one */
 			submit_one_bio(bio_ctrl);
@@ -1040,6 +1089,8 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		bool force_bio_submit = false;
 		u64 disk_bytenr;
 
+		bio_ctrl->fscrypt_info = NULL;
+
 		ASSERT(IS_ALIGNED(cur, fs_info->sectorsize));
 		if (cur >= last_byte) {
 			iosize = PAGE_SIZE - pg_offset;
@@ -1112,6 +1163,22 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		if (prev_em_start)
 			*prev_em_start = em->start;
 
+		/*
+		 * We use the extent offset for the IV when decrypting the page,
+		 * so we have to set the extent_offset based on the orig_start
+		 * for this extent.  Also save the fscrypt_info so the bio ctx
+		 * can be set properly.  If this inode isn't encrypted this
+		 * won't do anything.
+		 *
+		 * If we're compressed we'll handle all of this in
+		 * btrfs_submit_compressed_read.
+		 */
+		if (compress_type == BTRFS_COMPRESS_NONE) {
+			bio_ctrl->orig_start = em->orig_start;
+			bio_ctrl->fscrypt_info =
+				fscrypt_get_extent_info(em->fscrypt_info);
+		}
+
 		free_extent_map(em);
 		em = NULL;
 
@@ -1123,6 +1190,9 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			end_page_read(page, true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
+
+			/* This shouldn't be set, but clear it just in case. */
+			fscrypt_put_extent_info(bio_ctrl->fscrypt_info);
 			continue;
 		}
 		/* the get_extent function already copied into the page */
@@ -1131,6 +1201,9 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			end_page_read(page, true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
+
+			/* This shouldn't be set, but clear it just in case. */
+			fscrypt_put_extent_info(bio_ctrl->fscrypt_info);
 			continue;
 		}
 
@@ -1143,6 +1216,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			submit_one_bio(bio_ctrl);
 		submit_extent_page(bio_ctrl, disk_bytenr, page, iosize,
 				   pg_offset);
+		fscrypt_put_extent_info(bio_ctrl->fscrypt_info);
 		cur = cur + iosize;
 		pg_offset += iosize;
 	}
diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
index 00cbb64129c0..b93fce2db3d5 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -272,6 +272,42 @@ ssize_t btrfs_fscrypt_context_for_new_extent(struct btrfs_inode *inode,
 	return ret + sizeof(struct btrfs_encryption_info);
 }
 
+void btrfs_set_bio_crypt_ctx_from_extent(struct bio *bio,
+					 struct btrfs_inode *inode,
+					 struct fscrypt_extent_info *fi,
+					 u64 logical_offset)
+{
+	if (!fi)
+		return;
+
+	/*
+	 * fscrypt uses bytes >> s_blocksize_bits for the block numbers, so we
+	 * have to adjust everything based on our sectorsize so that the DUN
+	 * calculations are correct.
+	 */
+	logical_offset = div64_u64(logical_offset,
+				   inode->root->fs_info->sectorsize);
+	fscrypt_set_bio_crypt_ctx_from_extent(bio, fi, logical_offset,
+					      GFP_NOFS);
+}
+
+bool btrfs_mergeable_encrypted_bio(struct bio *bio, struct inode *inode,
+				   struct fscrypt_extent_info *fi,
+				   u64 logical_offset)
+{
+	if (!fi)
+		return true;
+
+	/*
+	 * fscrypt uses bytes >> s_blocksize_bits for the block numbers, so we
+	 * have to adjust everything based on our sectorsize so that the DUN
+	 * calculations are correct.
+	 */
+	logical_offset = div64_u64(logical_offset,
+				   BTRFS_I(inode)->root->fs_info->sectorsize);
+	return fscrypt_mergeable_extent_bio(bio, fi, logical_offset);
+}
+
 const struct fscrypt_operations btrfs_fscrypt_ops = {
 	.has_per_extent_encryption = 1,
 	.get_context = btrfs_fscrypt_get_context,
diff --git a/fs/btrfs/fscrypt.h b/fs/btrfs/fscrypt.h
index 21b5dfc6100d..4da80090361f 100644
--- a/fs/btrfs/fscrypt.h
+++ b/fs/btrfs/fscrypt.h
@@ -30,6 +30,13 @@ void btrfs_fscrypt_save_extent_info(struct btrfs_inode *inode,
 ssize_t btrfs_fscrypt_context_for_new_extent(struct btrfs_inode *inode,
 					     struct fscrypt_extent_info *info,
 					     u8 *ctx);
+void btrfs_set_bio_crypt_ctx_from_extent(struct bio *bio,
+					 struct btrfs_inode *inode,
+					 struct fscrypt_extent_info *fi,
+					 u64 logical_offset);
+bool btrfs_mergeable_encrypted_bio(struct bio *bio, struct inode *inode,
+				   struct fscrypt_extent_info *fi,
+				   u64 logical_offset);
 
 #else
 static inline void btrfs_fscrypt_save_extent_info(struct btrfs_inode *inode,
@@ -70,6 +77,21 @@ static inline ssize_t btrfs_fscrypt_context_for_new_extent(struct btrfs_inode *i
 	return -EINVAL;
 }
 
+static inline void btrfs_set_bio_crypt_ctx_from_extent(struct bio *bio,
+						       struct btrfs_inode *inode,
+						       struct fscrypt_extent_info *fi,
+						       u64 logical_offset)
+{
+}
+
+static inline bool btrfs_mergeable_encrypted_bio(struct bio *bio,
+						 struct inode *inode,
+						 struct fscrypt_extent_info *fi,
+						 u64 logical_offset)
+{
+	return true;
+}
+
 #endif /* CONFIG_FS_ENCRYPTION */
 
 extern const struct fscrypt_operations btrfs_fscrypt_ops;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a84ff55b7eb5..6d882b2de7e2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7934,6 +7934,8 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 	struct btrfs_dio_private *dip =
 		container_of(bbio, struct btrfs_dio_private, bbio);
 	struct btrfs_dio_data *dio_data = iter->private;
+	struct fscrypt_extent_info *fscrypt_info = NULL;
+	u64 offset = 0;
 
 	btrfs_bio_init(bbio, BTRFS_I(iter->inode)->root->fs_info,
 		       btrfs_dio_end_io, bio->bi_private);
@@ -7955,6 +7957,9 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 	if (iter->flags & IOMAP_WRITE) {
 		int ret;
 
+		offset = file_offset - dio_data->ordered->orig_offset;
+		fscrypt_info = dio_data->ordered->fscrypt_info;
+
 		ret = btrfs_extract_ordered_extent(bbio, dio_data->ordered);
 		if (ret) {
 			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
@@ -7964,8 +7969,13 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 			iomap_dio_bio_end_io(bio);
 			return;
 		}
+	} else {
+		fscrypt_info = dio_data->fscrypt_info;
+		offset = file_offset - dio_data->orig_start;
 	}
 
+	btrfs_set_bio_crypt_ctx_from_extent(&bbio->bio, bbio->inode,
+					    fscrypt_info, offset);
 	btrfs_submit_bio(bbio, 0);
 }
 
-- 
2.43.0


