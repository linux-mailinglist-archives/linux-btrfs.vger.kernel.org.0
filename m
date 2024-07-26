Return-Path: <linux-btrfs+bounces-6747-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 079B093D907
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC17DB20C46
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476A61442F2;
	Fri, 26 Jul 2024 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="fvj8ASLq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7901411C7
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022606; cv=none; b=THeCM50DJFSPZ97e57pq+31GVwpb1iETnwyHXifMIzKDHzNRO9zce6KSn3n4IShZe1hwpTesNHZG98qewUK1F888hzGskVH+pUtIPNd2nmLVlqDKLOg9G+Z4PS8+LW4ur0WRQXzxsTz9OOeNLtZnqO6oJN300T4e2LvBuVlsjAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022606; c=relaxed/simple;
	bh=j74CMC07W9scNtCVqoazaUnIHXzUTI0IdDat6me1qAA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzYazW6H70juXwQpQS3qgZiNJaFy4b42KlIuUjpKuhMD1kzFvV+xZzaPRi89MrRq/4W66/vTQhdJdtAM43uLRJKCPAXWa5f9pVpQeNX3+13ImW4j/rNHZSe0nIuxRPosISTwtEUTTQHcbNKcPVZRfUWULlhlD/ef/EXWS2q1eWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=fvj8ASLq; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e0b10e8b6b7so37759276.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022604; x=1722627404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQUSrK4Jwp1CSW5AxPcMx0ALobcwkzCUtqZnGQVH5AY=;
        b=fvj8ASLq/UYLKdFYkNenNJ6dUMF1cXsouckcik5icHYzGqw/nhJpNadvPw/x60WjhQ
         m8qYfozhRni9zdE7Z9BD55cu96CS2zA2qAzd5CfbqbGzvTY+gI47obnPtVu6A/LtcY7C
         PWjxQWIgt4RWEf6iDvnBYpf1LB4k+io5MNcROMDhhbz0riayWStEB47hrQamDxzvPD7e
         FwCcP0Jb8z1dUpgtsVBlHwJ0asoEYEpKtza9dvoCmddAMoHc9mfn4Tx70IP88U4vhm/0
         OQs6yVqEVfpc70y0yf8h345hCewKUXeAL1uSnLO5hi273dVpFjyGMf+GNZh8DWPnO14J
         w0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022604; x=1722627404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQUSrK4Jwp1CSW5AxPcMx0ALobcwkzCUtqZnGQVH5AY=;
        b=IgRcCL73VdjIDqwFG2EEk+UNQAYUawRoRs12iXWyuCWHDKgqiWpRGFp1x6smLwo1tl
         /6PRtXOi8nomaGQfLxhHr9jTOHe+luXf3xINdnUjkUNl0iMqqh9I5B5Fwb1sJq7inCTc
         QgA6SfKyPW4R++afd+hZldhNM3QWkhnIgGxSN8wuB6ugZiVik+K66DUI4oYnEmbLZvP9
         q+uFGr0uL79k2KytTU4CkoIPM/3jTuBAs0qxlrKtZ1alrdxGktZkwt9BO+ikJqc9CJqk
         Bf5c4gdv/SBnWzioKqcDcNZYIn5NrCN9LJLcJ76O0b9xa2XWPBwMVdN6bMK1lVSYlfFb
         xM/Q==
X-Gm-Message-State: AOJu0YwyL3VXZBRhLxBzX9NLj7eXB5kn2UUwSTsNB2I1I4b8IqeVYpFP
	lpWqMYEG2n8qMTCUuJ5QZdoCc2o5cP5d6efeoCV8WaWqcm/r0vL1c4PmIaB4rDVTV8BaSTnJ0+c
	p
X-Google-Smtp-Source: AGHT+IGtoWidu2hDFaMB2Ds2W3BdysAieg0trIdaXCRuJVi5tg5wLoASIg8SmhikM8He2Oh/nERTcA==
X-Received: by 2002:a05:6902:2807:b0:e03:53f0:2438 with SMTP id 3f1490d57ef6-e0b543f2cfcmr1111692276.7.1722022603685;
        Fri, 26 Jul 2024 12:36:43 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b4ebc5d8fsm176965276.3.2024.07.26.12.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:36:43 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 06/46] btrfs: convert btrfs_do_readpage to only use a folio
Date: Fri, 26 Jul 2024 15:35:53 -0400
Message-ID: <d897ba6dea72e820276cad328bfc46b9cafaba9c.1722022376.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722022376.git.josef@toxicpanda.com>
References: <cover.1722022376.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the callers and helpers mostly use folio, convert
btrfs_do_readpage to take a folio, and rename it to btrfs_do_read_folio.
Update all of the page stuff to use the folio based helpers instead.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 58 ++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 612855e17d04..973028a9ba3f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1004,12 +1004,12 @@ static struct extent_map *__get_extent_map(struct inode *inode, struct page *pag
  * XXX JDM: This needs looking at to ensure proper page locking
  * return 0 on success, otherwise return error
  */
-static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
+static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		      struct btrfs_bio_ctrl *bio_ctrl, u64 *prev_em_start)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
-	u64 start = page_offset(page);
+	u64 start = folio_pos(folio);
 	const u64 end = start + PAGE_SIZE - 1;
 	u64 cur = start;
 	u64 extent_offset;
@@ -1022,23 +1022,23 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 	size_t blocksize = fs_info->sectorsize;
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 
-	ret = set_page_extent_mapped(page);
+	ret = set_folio_extent_mapped(folio);
 	if (ret < 0) {
 		unlock_extent(tree, start, end, NULL);
-		unlock_page(page);
+		folio_unlock(folio);
 		return ret;
 	}
 
-	if (page->index == last_byte >> PAGE_SHIFT) {
-		size_t zero_offset = offset_in_page(last_byte);
+	if (folio->index == last_byte >> folio_shift(folio)) {
+		size_t zero_offset = offset_in_folio(folio, last_byte);
 
 		if (zero_offset) {
-			iosize = PAGE_SIZE - zero_offset;
-			memzero_page(page, zero_offset, iosize);
+			iosize = folio_size(folio) - zero_offset;
+			folio_zero_range(folio, zero_offset, iosize);
 		}
 	}
 	bio_ctrl->end_io_func = end_bbio_data_read;
-	begin_folio_read(fs_info, page_folio(page));
+	begin_folio_read(fs_info, folio);
 	while (cur <= end) {
 		enum btrfs_compression_type compress_type = BTRFS_COMPRESS_NONE;
 		bool force_bio_submit = false;
@@ -1046,16 +1046,17 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 
 		ASSERT(IS_ALIGNED(cur, fs_info->sectorsize));
 		if (cur >= last_byte) {
-			iosize = PAGE_SIZE - pg_offset;
-			memzero_page(page, pg_offset, iosize);
+			iosize = folio_size(folio) - pg_offset;
+			folio_zero_range(folio, pg_offset, iosize);
 			unlock_extent(tree, cur, cur + iosize - 1, NULL);
-			end_folio_read(page_folio(page), true, cur, iosize);
+			end_folio_read(folio, true, cur, iosize);
 			break;
 		}
-		em = __get_extent_map(inode, page, cur, end - cur + 1, em_cached);
+		em = __get_extent_map(inode, folio_page(folio, 0), cur,
+				      end - cur + 1, em_cached);
 		if (IS_ERR(em)) {
 			unlock_extent(tree, cur, end, NULL);
-			end_folio_read(page_folio(page), false, cur, end + 1 - cur);
+			end_folio_read(folio, false, cur, end + 1 - cur);
 			return PTR_ERR(em);
 		}
 		extent_offset = cur - em->start;
@@ -1080,8 +1081,8 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		 * to the same compressed extent (possibly with a different
 		 * offset and/or length, so it either points to the whole extent
 		 * or only part of it), we must make sure we do not submit a
-		 * single bio to populate the pages for the 2 ranges because
-		 * this makes the compressed extent read zero out the pages
+		 * single bio to populate the folios for the 2 ranges because
+		 * this makes the compressed extent read zero out the folios
 		 * belonging to the 2nd range. Imagine the following scenario:
 		 *
 		 *  File layout
@@ -1094,13 +1095,13 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		 * [extent X, compressed length = 4K uncompressed length = 16K]
 		 *
 		 * If the bio to read the compressed extent covers both ranges,
-		 * it will decompress extent X into the pages belonging to the
+		 * it will decompress extent X into the folios belonging to the
 		 * first range and then it will stop, zeroing out the remaining
-		 * pages that belong to the other range that points to extent X.
+		 * folios that belong to the other range that points to extent X.
 		 * So here we make sure we submit 2 bios, one for the first
 		 * range and another one for the third range. Both will target
 		 * the same physical extent from disk, but we can't currently
-		 * make the compressed bio endio callback populate the pages
+		 * make the compressed bio endio callback populate the folios
 		 * for both ranges because each compressed bio is tightly
 		 * coupled with a single extent map, and each range can have
 		 * an extent map with a different offset value relative to the
@@ -1121,18 +1122,18 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 
 		/* we've found a hole, just zero and go on */
 		if (block_start == EXTENT_MAP_HOLE) {
-			memzero_page(page, pg_offset, iosize);
+			folio_zero_range(folio, pg_offset, iosize);
 
 			unlock_extent(tree, cur, cur + iosize - 1, NULL);
-			end_folio_read(page_folio(page), true, cur, iosize);
+			end_folio_read(folio, true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
 		}
-		/* the get_extent function already copied into the page */
+		/* the get_extent function already copied into the folio */
 		if (block_start == EXTENT_MAP_INLINE) {
 			unlock_extent(tree, cur, cur + iosize - 1, NULL);
-			end_folio_read(page_folio(page), true, cur, iosize);
+			end_folio_read(folio, true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
@@ -1145,8 +1146,8 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 
 		if (force_bio_submit)
 			submit_one_bio(bio_ctrl);
-		submit_extent_folio(bio_ctrl, disk_bytenr, page_folio(page),
-				    iosize, pg_offset);
+		submit_extent_folio(bio_ctrl, disk_bytenr, folio, iosize,
+				    pg_offset);
 		cur = cur + iosize;
 		pg_offset += iosize;
 	}
@@ -1165,7 +1166,7 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
 
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
-	ret = btrfs_do_readpage(&folio->page, &em_cached, &bio_ctrl, NULL);
+	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
 	free_extent_map(em_cached);
 
 	/*
@@ -2369,8 +2370,7 @@ void btrfs_readahead(struct readahead_control *rac)
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
 	while ((folio = readahead_folio(rac)) != NULL)
-		btrfs_do_readpage(&folio->page, &em_cached, &bio_ctrl,
-				  &prev_em_start);
+		btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
 
 	if (em_cached)
 		free_extent_map(em_cached);
-- 
2.43.0


