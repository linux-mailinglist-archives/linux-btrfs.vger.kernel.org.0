Return-Path: <linux-btrfs+bounces-9658-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112859C8E5B
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 16:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5161281744
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 15:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2841B6CE3;
	Thu, 14 Nov 2024 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ryPp7Zo/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB481B393A
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598109; cv=none; b=aIMgYtgO+fqbVThwQoWnu48SjbMsgkovNPgQEDAy2quAvLaTn0BUgdoX2cp8PTxEQHJaW/+XPtLSZ5gXZMm/3MPThiHUpTq/WX4Dju8Np91bF0ivcBRoqsYaioDmK5BypODpOtrbVqSEfl0Lc3HFAWvBt4cYt0UqOMs6Pu/UywQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598109; c=relaxed/simple;
	bh=KvrrsZd4o42w6FFEWFQ1mvoiCpBhCV2tMq6FGu3bD6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSqokaDkCNLdEjx9bpwy/581be/NUzosVQAfWe5LubyFrP+sc+Xj/V5S5I+ZAFkaoMIxf+dJ1dO9C1dEzc6vDPenSr6VEO78jL9iZTocoumBphRyv72MdaWVQXT57SYbOy2VAka4z0Sdal8+CUJ12nfWLOlG03vxNPvj3Ji/wME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ryPp7Zo/; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ee9e209bb6so360337eaf.0
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 07:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731598107; x=1732202907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsUz6pEpY+ox9az2F5q2xnny+koVz5fK77xTMpol5Tk=;
        b=ryPp7Zo/FFxNM8nzscrCmwbmpbBbx3HBf2MkZTBwejmXhORSfWY2POIJp/oJbCIr82
         XZcbAoorLW7+awt8LjNlVcKUFt3jjTlIhgnXQ1d9LrNPTFv7v6j34vob3JjxyObeceUx
         jB7EjJE0ChVaIsXdSotebhjSYyNyCxhcHhlU9e3bgaBw0bzfjZ/AHs0aSRIcvsI31WV6
         laM6ovcE4vCNzNS+kLK4+HI8UnYZN55+tSd085le9TNnKfZKjVgVuUJ7iLZyt89BvmXd
         4SwEMBpWo0POPcqWo/OjRLDn9rCM4YU3NZHJBj/zjYbUHsKDAgZqw1NmyHyPPpBbgaZp
         x8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598107; x=1732202907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsUz6pEpY+ox9az2F5q2xnny+koVz5fK77xTMpol5Tk=;
        b=pKaJdqla4qAf6aFU1wm5cKpi4PIp455t7qbZwASSeGwReXFgaf5AN7CCwrWz10agZo
         1zDLKF30HZNLRZNyQvvHMOlCsX+AKGj543NjcivoR342KcQB9phW6BVxG7Fa8BzqJFp4
         U3XdbcUCMStbHa7+KfHgWGopK3AdesM/Hz2ehPEa8kdyyrW4hkRotO6XWfzbO4zl3N9D
         L+ABYIWcwyH0B/fhl1vjVcWBMqrUeYHcnvbwlqYr+vMaji7Uhz1l4v+rB335ILNCArkC
         K8C/HQpFkDSvFWTSR17p1QiP6rsRnqjE6VOuwbAab77Bl+MMVJO/643HCBMjgY7IptQR
         qPXw==
X-Forwarded-Encrypted: i=1; AJvYcCVwRMN3k0vQAy9BHMWagBLr34ofla62y0FINR6/heTPC946XTSd+uq2fExJrL3QNrDHvZ+/EPgJlz9SDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywis5lPk1jqKh6khzuDg+U2p/WStAcZgmXvdXRLMMqBemoe9i7y
	K9jUkLH6ISDQl83faTzKjy/bEc3B2GK6K6lu0+hxZuXzS2aP4hANWp35KtW2PJw=
X-Google-Smtp-Source: AGHT+IFc1nzkbPZXQe4aKtw+LtP2VNQBWJFtVjU1qLyGyhTsHecVf/ilzi9Wv0164LJAdz5N+SGBoQ==
X-Received: by 2002:a05:6820:1b08:b0:5ee:a5b:d172 with SMTP id 006d021491bc7-5ee57c530cdmr17735794eaf.5.1731598106027;
        Thu, 14 Nov 2024 07:28:26 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea026eb41sm368250eaf.39.2024.11.14.07.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:28:25 -0800 (PST)
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
Subject: [PATCH 17/17] btrfs: add support for uncached writes
Date: Thu, 14 Nov 2024 08:25:21 -0700
Message-ID: <20241114152743.2381672-19-axboe@kernel.dk>
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

The read side is already covered as btrfs uses the generic filemap
helpers. For writes, just pass in FGP_UNCACHED if uncached IO is being
done, then the folios created should be marked appropriately.

For IO completion, ensure that writing back folios that are uncached
gets punted to one of the btrfs workers, as task context is needed for
that. Add an 'uncached_io' member to struct btrfs_bio to manage that.

With that, add FOP_UNCACHED to the btrfs file_operations fop_flags
structure, enabling use of RWF_UNCACHED.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/btrfs/bio.c       | 4 ++--
 fs/btrfs/bio.h       | 2 ++
 fs/btrfs/extent_io.c | 8 +++++++-
 fs/btrfs/file.c      | 9 ++++++---
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 7e0f9600b80c..253e1a656934 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -334,7 +334,7 @@ static void btrfs_end_bio_work(struct work_struct *work)
 	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, end_io_work);
 
 	/* Metadata reads are checked and repaired by the submitter. */
-	if (is_data_bbio(bbio))
+	if (bio_op(&bbio->bio) == REQ_OP_READ && is_data_bbio(bbio))
 		btrfs_check_read_bio(bbio, bbio->bio.bi_private);
 	else
 		btrfs_bio_end_io(bbio, bbio->bio.bi_status);
@@ -351,7 +351,7 @@ static void btrfs_simple_end_io(struct bio *bio)
 	if (bio->bi_status)
 		btrfs_log_dev_io_error(bio, dev);
 
-	if (bio_op(bio) == REQ_OP_READ) {
+	if (bio_op(bio) == REQ_OP_READ || bbio->uncached_io) {
 		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
 		queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->end_io_work);
 	} else {
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index e2fe16074ad6..39b98326c98f 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -82,6 +82,8 @@ struct btrfs_bio {
 	/* Save the first error status of split bio. */
 	blk_status_t status;
 
+	bool uncached_io;
+
 	/*
 	 * This member must come last, bio_alloc_bioset will allocate enough
 	 * bytes for entire btrfs_bio but relies on bio being last.
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 872cca54cc6c..b97b21178ed7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -760,8 +760,11 @@ static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
 	ASSERT(bio_ctrl->end_io_func);
 
 	if (bio_ctrl->bbio &&
-	    !btrfs_bio_is_contig(bio_ctrl, folio, disk_bytenr, pg_offset))
+	    !btrfs_bio_is_contig(bio_ctrl, folio, disk_bytenr, pg_offset)) {
+		if (folio_test_uncached(folio))
+			bio_ctrl->bbio->uncached_io = true;
 		submit_one_bio(bio_ctrl);
+	}
 
 	do {
 		u32 len = size;
@@ -779,6 +782,9 @@ static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
 			len = bio_ctrl->len_to_oe_boundary;
 		}
 
+		if (folio_test_uncached(folio))
+			bio_ctrl->bbio->uncached_io = true;
+
 		if (!bio_add_folio(&bio_ctrl->bbio->bio, folio, len, pg_offset)) {
 			/* bio full: move on to a new one */
 			submit_one_bio(bio_ctrl);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 4fb521d91b06..cfee783f4c4d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -919,7 +919,7 @@ static gfp_t get_prepare_gfp_flags(struct inode *inode, bool nowait)
 static noinline int prepare_pages(struct inode *inode, struct page **pages,
 				  size_t num_pages, loff_t pos,
 				  size_t write_bytes, bool force_uptodate,
-				  bool nowait)
+				  bool nowait, bool uncached)
 {
 	int i;
 	unsigned long index = pos >> PAGE_SHIFT;
@@ -928,6 +928,8 @@ static noinline int prepare_pages(struct inode *inode, struct page **pages,
 	int ret = 0;
 	int faili;
 
+	if (uncached)
+		fgp_flags |= FGP_UNCACHED;
 	for (i = 0; i < num_pages; i++) {
 again:
 		pages[i] = pagecache_get_page(inode->i_mapping, index + i,
@@ -1323,7 +1325,8 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		 * contents of pages from loop to loop
 		 */
 		ret = prepare_pages(inode, pages, num_pages,
-				    pos, write_bytes, force_page_uptodate, false);
+				    pos, write_bytes, force_page_uptodate,
+				    false, iocb->ki_flags & IOCB_UNCACHED);
 		if (ret) {
 			btrfs_delalloc_release_extents(BTRFS_I(inode),
 						       reserve_bytes);
@@ -3802,7 +3805,7 @@ const struct file_operations btrfs_file_operations = {
 	.compat_ioctl	= btrfs_compat_ioctl,
 #endif
 	.remap_file_range = btrfs_remap_file_range,
-	.fop_flags	= FOP_BUFFER_RASYNC | FOP_BUFFER_WASYNC,
+	.fop_flags	= FOP_BUFFER_RASYNC | FOP_BUFFER_WASYNC | FOP_UNCACHED,
 };
 
 int btrfs_fdatawrite_range(struct btrfs_inode *inode, loff_t start, loff_t end)
-- 
2.45.2


