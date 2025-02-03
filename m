Return-Path: <linux-btrfs+bounces-11247-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C71FAA26040
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 17:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DE91887E7E
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 16:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07D820B1F7;
	Mon,  3 Feb 2025 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gA/MJxJN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA5D20AF9B
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738600549; cv=none; b=IDbDwMdpxy0y2koq3ZdCO2vB0yTb9qhhbqIT0t036+wtdj10/X0wpt21nTLT6BaOzcIDVsOTM+gEo4tH9HA6tHFFc6jxYZOpOIoSwC/pVywqsR7hrD+6TWn9/yG++OwJQ30yanKIXgVtGuiZhI15VUBy++9VLGMS8qBWVCM+oFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738600549; c=relaxed/simple;
	bh=Q6gb0xZedErTs3Rsv71mezPraU6UOhWujGvxzGx2cvc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=WXvimIYhV/7KgZ1JP70duj3C3PA1Tee5Hb9LWdFq4ID1Xr8HosRPjBRL/JToksztphfPob8JoURvJoE5qj99nLA3G37fwCypnNJi7FC+VnsHWB9BZwSLbAvnxrT+9YGZq/BB1MZPT8gUVdHnHOCJaedKNCrmXojhrPt94tZTqTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gA/MJxJN; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-844e7bc6d84so138021939f.0
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2025 08:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738600544; x=1739205344; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvDadieaeXTt94mvASlW70ZaJOr7Q4WU3G4ldjR5AH8=;
        b=gA/MJxJNLGtoeEduF/CqSxyxrBzoNXKhoSppEVlXbE4X30+RJZh5UVga5KFrqMZtgc
         tokyIcUV+MCfek/1E5+7LCuEq5Zv4DOYe6+KmoECOVsWZSFXe2M81Ot8H9PDbRxNWIKE
         /Ezy7ZD8wsBSixaL71JQXcr+7IbDLZgcS448xGJf61Lfp29IOEXkZ2oY2VyaYaXV8yVd
         MtZ4YXzWqBMagktYiSXW3g4ZksTOqB2JYXbS+5CLzLTyUPvqdBndXvW+sTZoum+mapc4
         lqhMih2q1zNWxKfZfR0snAQa4ou9u0wKIa2UtLP4V/ef2peXMwk9dccuF28i5n60ONAc
         WSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738600544; x=1739205344;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bvDadieaeXTt94mvASlW70ZaJOr7Q4WU3G4ldjR5AH8=;
        b=fxnJza2kxigAwmh4T6ZqXZIIWgJKGBZQrOIXn5Da53pd/7H1X8h4AdT+/CQQ7vJGPG
         /nR76i9mLOVhkq2nhAE1b4vO4tufY6kxoFuSTYHAp6RkGdJWF41amYUn9lC/E73czO0k
         RAirXpTHNRuXydQHsBDNXJYpclkMz9udGRLXHaWDtlTMHsGGUBioSNaTT2eFs+sV5l4k
         BNouIIGeP8W9UXg1usMbhAhiQd3bVnCY9sH4yLrA3cBrnNzI/qvMuJHZ/bpE3YKGsnIE
         y8aKKwNXS8+GJ5T2G7mePHD1jzkmrZyC+jjpWoosXjmOmlc/iA99Xci4RzBvthJwZFD+
         oFsw==
X-Gm-Message-State: AOJu0YzuMJanxEFXqU+6lH4ZA1gIiJvSWNd+d0mHRtY5SPX3FnyaZkob
	SCCF/Ro0Q/rG5OOMuLrxDp3U0eRL7w2oMOs6XFwFG3w6rVJhCdRWxA8P+HmotVY=
X-Gm-Gg: ASbGncuaXgyTKUD/bTy0Tn+3LCDSdpB9B/RC6vqQVJcWfyzF1l/H6ZjKNntaaFTtdFO
	9HvqALHlWevIwk3N2aqVHUsC9pxIVoGYwZ5Hl8JPuCUhJ3OtDh9ouHTMvgdRIzKsOY0VGmwrBoh
	Zs/TOipfc7co4hIZhIH3gsDGpkfcT/O5dsVHvvmLpHq3S2yFGnLr62T//VsVk0QoDRTXYCJp8zI
	fW7gu6bJtb7+TEGHZRfCks0n/Pn3GcZywXDX8Dmm2PQUydR5dSj2Vz1GaUTIQ2Y3V3vOz/hulg1
	Vumq1gYM8Hk=
X-Google-Smtp-Source: AGHT+IH2KzVMb97hjNJQhQJ0cY1PGZ+rPRlbURHdje6mT6Va/ScmECcFpxygXXkVtQQzNKiIvrQqJA==
X-Received: by 2002:a05:6602:7510:b0:84f:537d:8967 with SMTP id ca18e2360f4ac-8549fab0d23mr1332589339f.7.1738600544285;
        Mon, 03 Feb 2025 08:35:44 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854a1717231sm246995939f.35.2025.02.03.08.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 08:35:43 -0800 (PST)
Message-ID: <00cb89e6-225a-491f-b7f1-8a9465a7aabb@kernel.dk>
Date: Mon, 3 Feb 2025 09:35:42 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] btrfs: add support for uncached writes
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The read side is already covered as btrfs uses the generic filemap
helpers. For writes, just pass in FGP_DONTCACHE if uncached IO is being
done, then the folios created should be marked appropriately.

For IO completion, ensure that writing back folios that are uncached
gets punted to one of the btrfs workers, as task context is needed for
that. Add an 'uncached_io' member to struct btrfs_bio to manage that.

With that, add FOP_DONTCACHE to the btrfs file_operations fop_flags
structure, enabling use of RWF_DONTCACHE.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index bc2555c44a12..fd51dbc16176 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -337,7 +337,7 @@ static void btrfs_end_bio_work(struct work_struct *work)
 	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, end_io_work);
 
 	/* Metadata reads are checked and repaired by the submitter. */
-	if (is_data_bbio(bbio))
+	if (bio_op(&bbio->bio) == REQ_OP_READ && is_data_bbio(bbio))
 		btrfs_check_read_bio(bbio, bbio->bio.bi_private);
 	else
 		btrfs_bio_end_io(bbio, bbio->bio.bi_status);
@@ -354,7 +354,7 @@ static void btrfs_simple_end_io(struct bio *bio)
 	if (bio->bi_status)
 		btrfs_log_dev_io_error(bio, dev);
 
-	if (bio_op(bio) == REQ_OP_READ) {
+	if (bio_op(bio) == REQ_OP_READ || bbio->dropbehind_io) {
 		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
 		queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->end_io_work);
 	} else {
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index e2fe16074ad6..b41c5236c93d 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -82,6 +82,8 @@ struct btrfs_bio {
 	/* Save the first error status of split bio. */
 	blk_status_t status;
 
+	bool dropbehind_io;
+
 	/*
 	 * This member must come last, bio_alloc_bioset will allocate enough
 	 * bytes for entire btrfs_bio but relies on bio being last.
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a2cac9d0a1a9..cab29a1c5867 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -758,8 +758,11 @@ static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
 	ASSERT(bio_ctrl->end_io_func);
 
 	if (bio_ctrl->bbio &&
-	    !btrfs_bio_is_contig(bio_ctrl, folio, disk_bytenr, pg_offset))
+	    !btrfs_bio_is_contig(bio_ctrl, folio, disk_bytenr, pg_offset)) {
+		if (folio_test_dropbehind(folio))
+			bio_ctrl->bbio->dropbehind_io = true;
 		submit_one_bio(bio_ctrl);
+	}
 
 	do {
 		u32 len = size;
@@ -777,6 +780,9 @@ static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
 			len = bio_ctrl->len_to_oe_boundary;
 		}
 
+		if (folio_test_dropbehind(folio))
+			bio_ctrl->bbio->dropbehind_io = true;
+
 		if (!bio_add_folio(&bio_ctrl->bbio->bio, folio, len, pg_offset)) {
 			/* bio full: move on to a new one */
 			submit_one_bio(bio_ctrl);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 36f51c311bb1..70f2bb4b316e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -857,18 +857,17 @@ static gfp_t get_prepare_gfp_flags(struct inode *inode, bool nowait)
  */
 static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_ret,
 				      loff_t pos, size_t write_bytes,
-				      bool force_uptodate, bool nowait)
+				      bool force_uptodate, fgf_t fgp_flags)
 {
 	unsigned long index = pos >> PAGE_SHIFT;
-	gfp_t mask = get_prepare_gfp_flags(inode, nowait);
-	fgf_t fgp_flags = (nowait ? FGP_WRITEBEGIN | FGP_NOWAIT : FGP_WRITEBEGIN);
+	gfp_t mask = get_prepare_gfp_flags(inode, fgp_flags & FGP_NOWAIT);
 	struct folio *folio;
 	int ret = 0;
 
 again:
 	folio = __filemap_get_folio(inode->i_mapping, index, fgp_flags, mask);
 	if (IS_ERR(folio)) {
-		if (nowait)
+		if (fgp_flags & FGP_NOWAIT)
 			ret = -EAGAIN;
 		else
 			ret = PTR_ERR(folio);
@@ -887,7 +886,7 @@ static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_
 	if (ret) {
 		/* The folio is already unlocked. */
 		folio_put(folio);
-		if (!nowait && ret == -EAGAIN) {
+		if (!(fgp_flags & FGP_NOWAIT) && ret == -EAGAIN) {
 			ret = 0;
 			goto again;
 		}
@@ -1097,9 +1096,15 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 	const bool nowait = (iocb->ki_flags & IOCB_NOWAIT);
 	unsigned int bdp_flags = (nowait ? BDP_ASYNC : 0);
 	bool only_release_metadata = false;
+	fgf_t fgp_flags = FGP_WRITEBEGIN;
 
-	if (nowait)
+	if (nowait) {
 		ilock_flags |= BTRFS_ILOCK_TRY;
+		fgp_flags |= FGP_NOWAIT;
+	}
+
+	if (iocb->ki_flags & IOCB_DONTCACHE)
+		fgp_flags |= FGP_DONTCACHE;
 
 	ret = btrfs_inode_lock(BTRFS_I(inode), ilock_flags);
 	if (ret < 0)
@@ -1195,7 +1200,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		}
 
 		ret = prepare_one_folio(inode, &folio, pos, write_bytes,
-					force_page_uptodate, false);
+					force_page_uptodate, fgp_flags);
 		if (ret) {
 			btrfs_delalloc_release_extents(BTRFS_I(inode),
 						       reserve_bytes);
@@ -3671,7 +3676,7 @@ const struct file_operations btrfs_file_operations = {
 #endif
 	.remap_file_range = btrfs_remap_file_range,
 	.uring_cmd	= btrfs_uring_cmd,
-	.fop_flags	= FOP_BUFFER_RASYNC | FOP_BUFFER_WASYNC,
+	.fop_flags	= FOP_BUFFER_RASYNC | FOP_BUFFER_WASYNC | FOP_DONTCACHE,
 };
 
 int btrfs_fdatawrite_range(struct btrfs_inode *inode, loff_t start, loff_t end)

-- 
Jens Axboe


