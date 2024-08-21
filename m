Return-Path: <linux-btrfs+bounces-7368-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D296995A253
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 18:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028B01C21B41
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 16:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDC215217F;
	Wed, 21 Aug 2024 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="G2/it2Ul"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372B314F131
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256133; cv=none; b=to/xYxs3xRmkWpZXEKQVVmAXKkVfkDGiyYXk3Ava259xECDlbQmF4CLOg8IRk0iX+nRUpxYO1Uoj4EEqSz+RMHfjv9SDVgNE10tyNfgT48+aEMN9x1D7wi24kdjxOnXh7GL0pv7QkXDP3BNSwlnlXabvVAUdBHBvR1vsswERlyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256133; c=relaxed/simple;
	bh=rR9ypka7eqGS5zoDgzgixATAiy7VyJ17s1AMcGO2cHM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvjQC8cyD300RF/G2gILXueDfsZJJFlkLltneNTESgXz27GMtcxRHBNWgI8rZQI2Sj1Fkax/GFEaLn/hsiLdRntr+UWLUsq3sjcEpEx704auchNSlurE0/1XT/I/eeYqnfqiszFg44xzCziOnh6o0Iio39ogUJtn9622s7ARoGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=G2/it2Ul; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6aab656687cso8229417b3.1
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 09:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724256130; x=1724860930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGa73gjIoW7xEA9h9DWBm/Q9njXwKtq+rS04x/d+vGA=;
        b=G2/it2Ulp/e2FsIp96XP6NMIRuGQH59yK+LSNL8SR+SDLENy39iIvf9wcnmXXaWWY7
         BqrRm+2G8sOCyxi9/CJ0VQM6/WqdyJVxBDR08R+XINm0aylVRDGrCsHJKkzSDmQPxK6M
         /OMmL/Lki0g6eTxF/XdaL2IMR0KqcwOTndAULgrEbmqwtaP3oR61uh/Nm9q05bYYAbpT
         XZSt3/SY0ybEGvNbKMTUWXmWefyLb3pBeg1NM32g4NQpLiCpOEg4ra40+I6iYpALYww1
         LvMu/wX/hFjr3bVxYcXY8Zkk6kFWSw+PfDmllghG1Je7k5mr+oBU8AWng8AqPtP8SqAY
         z3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724256130; x=1724860930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGa73gjIoW7xEA9h9DWBm/Q9njXwKtq+rS04x/d+vGA=;
        b=CwPkYplcKVWyqKmOJIHWbeBHEeAB1fSUed5dpRaDxOZ+PlyrLQsnm7Az7OGiom2mGN
         IAZd6dPFDyTOzhC1tGP5Qq3I3sjSekC5b8VFdIn1RXtbr2M3BgYtpvZH246PePtFjsbB
         RJjqfxr0Et8GQyi6OI6/O7NJzG3UCKevyu23+eP1QLDXdh7OWiQDa7oB8UPqVts+rG8A
         Qn1/JxxhzGQ+43+0itlhsy+BluY/j3lfjkidVO0RBxhRJOk6nTX3Htw4L3oz43KUxNPf
         jNJ2oZRMF/TDAr/KOJbBgxAmZN5Wg4w+jIUBmLhX8hJC5HwfysarwdZK8LL9Paa3djfr
         ygTQ==
X-Gm-Message-State: AOJu0Yx2QhnyjGlGpMi4RZmlTZxA6gf4am63usgIQLxB/cfSgo1UFPXt
	QZmYZLPYxKBVqFuQjXh2W5O+DO+vGi32jALC3JQK1U7UyS36qF1wTrINbPNIh1sJRHlDZci7Pwb
	n
X-Google-Smtp-Source: AGHT+IGj8jmLhVWrvtusPFgRfQgUo/1L0Fy7xvW7g5Oco+QL4kHNcbZ0evq7UkgJgsZ4PjyCge5GQA==
X-Received: by 2002:a05:690c:5009:b0:6b7:f467:e0f5 with SMTP id 00721157ae682-6c3041c4029mr1131517b3.9.1724256129736;
        Wed, 21 Aug 2024 09:02:09 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af99f9e012sm22769797b3.41.2024.08.21.09.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:02:09 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 3/3] btrfs: do not hold the extent lock for entire read
Date: Wed, 21 Aug 2024 12:02:01 -0400
Message-ID: <174b23dd8cf1a03d54f5ca3dc03c3f5011988d8a.1724255475.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724255475.git.josef@toxicpanda.com>
References: <cover.1724255475.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Historically we've held the extent lock throughout the entire read.
There's been a few reasons for this, but it's mostly just caused us
problems.  For example, this prevents us from allowing page faults
during direct io reads, because we could deadlock.  This has forced us
to only allow 4k reads at a time for io_uring NOWAIT requests because we
have no idea if we'll be forced to page fault and thus have to do a
whole lot of work.

On the buffered side we are protected by the page lock, as long as we're
reading things like buffered writes, punch hole, and even direct IO to a
certain degree will get hung up on the page lock while the page is in
flight.

On the direct side we have the dio extent lock, which acts much like the
way the extent lock worked previously to this patch, however just for
direct reads.  This protects direct reads from concurrent direct writes,
while we're protected from buffered writes via the inode lock.

Now that we're protected in all cases, narrow the extent lock to the
part where we're getting the extent map to submit the reads, no longer
holding the extent lock for the entire read operation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/compression.c |  2 +-
 fs/btrfs/direct-io.c   | 51 ++++++++++++------------
 fs/btrfs/extent_io.c   | 88 +++---------------------------------------
 3 files changed, 31 insertions(+), 110 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 832ab8984c41..511f81f312af 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -521,6 +521,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		}
 		add_size = min(em->start + em->len, page_end + 1) - cur;
 		free_extent_map(em);
+		unlock_extent(tree, cur, page_end, NULL);
 
 		if (folio->index == end_index) {
 			size_t zero_offset = offset_in_folio(folio, isize);
@@ -534,7 +535,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 
 		if (!bio_add_folio(orig_bio, folio, add_size,
 				   offset_in_folio(folio, cur))) {
-			unlock_extent(tree, cur, page_end, NULL);
 			folio_unlock(folio);
 			folio_put(folio);
 			break;
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 576f469cacee..66f1ce5fcfd2 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -366,7 +366,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	int ret = 0;
 	u64 len = length;
 	const u64 data_alloc_len = length;
-	bool unlock_extents = false;
+	u32 unlock_bits = EXTENT_LOCKED;
 
 	/*
 	 * We could potentially fault if we have a buffer > PAGE_SIZE, and if
@@ -527,7 +527,6 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 						    start, &len, flags);
 		if (ret < 0)
 			goto unlock_err;
-		unlock_extents = true;
 		/* Recalc len in case the new em is smaller than requested */
 		len = min(len, em->len - (start - em->start));
 		if (dio_data->data_space_reserved) {
@@ -548,23 +547,8 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 							       release_offset,
 							       release_len);
 		}
-	} else {
-		/*
-		 * We need to unlock only the end area that we aren't using.
-		 * The rest is going to be unlocked by the endio routine.
-		 */
-		lockstart = start + len;
-		if (lockstart < lockend)
-			unlock_extents = true;
 	}
 
-	if (unlock_extents)
-		clear_extent_bit(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-				 EXTENT_LOCKED | EXTENT_DIO_LOCKED,
-				 &cached_state);
-	else
-		free_extent_state(cached_state);
-
 	/*
 	 * Translate extent map information to iomap.
 	 * We trim the extents (and move the addr) even though iomap code does
@@ -583,6 +567,23 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	iomap->length = len;
 	free_extent_map(em);
 
+	/*
+	 * Reads will hold the EXTENT_DIO_LOCKED bit until the io is completed,
+	 * writes only hold it for this part.  We hold the extent lock until
+	 * we're completely done with the extent map to make sure it remains
+	 * valid.
+	 */
+	if (write)
+		unlock_bits |= EXTENT_DIO_LOCKED;
+
+	clear_extent_bit(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+			 unlock_bits, &cached_state);
+
+	/* We didn't use everything, unlock the dio extent for the remainder. */
+	if (!write && (start + len) < lockend)
+		unlock_dio_extent(&BTRFS_I(inode)->io_tree, start + len,
+				  lockend, NULL);
+
 	return 0;
 
 unlock_err:
@@ -615,9 +616,8 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 
 	if (!write && (iomap->type == IOMAP_HOLE)) {
 		/* If reading from a hole, unlock and return */
-		clear_extent_bit(&BTRFS_I(inode)->io_tree, pos,
-				  pos + length - 1,
-				  EXTENT_LOCKED | EXTENT_DIO_LOCKED, NULL);
+		unlock_dio_extent(&BTRFS_I(inode)->io_tree, pos,
+				  pos + length - 1, NULL);
 		return 0;
 	}
 
@@ -628,10 +628,8 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
 						    pos, length, false);
 		else
-			clear_extent_bit(&BTRFS_I(inode)->io_tree, pos,
-					 pos + length - 1,
-					 EXTENT_LOCKED | EXTENT_DIO_LOCKED,
-					 NULL);
+			unlock_dio_extent(&BTRFS_I(inode)->io_tree, pos,
+					  pos + length - 1, NULL);
 		ret = -ENOTBLK;
 	}
 	if (write) {
@@ -663,9 +661,8 @@ static void btrfs_dio_end_io(struct btrfs_bio *bbio)
 					    dip->file_offset, dip->bytes,
 					    !bio->bi_status);
 	} else {
-		clear_extent_bit(&inode->io_tree, dip->file_offset,
-				 dip->file_offset + dip->bytes - 1,
-				 EXTENT_LOCKED | EXTENT_DIO_LOCKED, NULL);
+		unlock_dio_extent(&inode->io_tree, dip->file_offset,
+				  dip->file_offset + dip->bytes - 1, NULL);
 	}
 
 	bbio->bio.bi_private = bbio->private;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 822e2bf8bc99..3f3baec23717 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -480,75 +480,6 @@ static void end_bbio_data_write(struct btrfs_bio *bbio)
 	bio_put(bio);
 }
 
-/*
- * Record previously processed extent range
- *
- * For endio_readpage_release_extent() to handle a full extent range, reducing
- * the extent io operations.
- */
-struct processed_extent {
-	struct btrfs_inode *inode;
-	/* Start of the range in @inode */
-	u64 start;
-	/* End of the range in @inode */
-	u64 end;
-	bool uptodate;
-};
-
-/*
- * Try to release processed extent range
- *
- * May not release the extent range right now if the current range is
- * contiguous to processed extent.
- *
- * Will release processed extent when any of @inode, @uptodate, the range is
- * no longer contiguous to the processed range.
- *
- * Passing @inode == NULL will force processed extent to be released.
- */
-static void endio_readpage_release_extent(struct processed_extent *processed,
-			      struct btrfs_inode *inode, u64 start, u64 end,
-			      bool uptodate)
-{
-	struct extent_state *cached = NULL;
-	struct extent_io_tree *tree;
-
-	/* The first extent, initialize @processed */
-	if (!processed->inode)
-		goto update;
-
-	/*
-	 * Contiguous to processed extent, just uptodate the end.
-	 *
-	 * Several things to notice:
-	 *
-	 * - bio can be merged as long as on-disk bytenr is contiguous
-	 *   This means we can have page belonging to other inodes, thus need to
-	 *   check if the inode still matches.
-	 * - bvec can contain range beyond current page for multi-page bvec
-	 *   Thus we need to do processed->end + 1 >= start check
-	 */
-	if (processed->inode == inode && processed->uptodate == uptodate &&
-	    processed->end + 1 >= start && end >= processed->end) {
-		processed->end = end;
-		return;
-	}
-
-	tree = &processed->inode->io_tree;
-	/*
-	 * Now we don't have range contiguous to the processed range, release
-	 * the processed range now.
-	 */
-	unlock_extent(tree, processed->start, processed->end, &cached);
-
-update:
-	/* Update processed to current range */
-	processed->inode = inode;
-	processed->start = start;
-	processed->end = end;
-	processed->uptodate = uptodate;
-}
-
 static void begin_folio_read(struct btrfs_fs_info *fs_info, struct folio *folio)
 {
 	ASSERT(folio_test_locked(folio));
@@ -575,7 +506,6 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 {
 	struct btrfs_fs_info *fs_info = bbio->fs_info;
 	struct bio *bio = &bbio->bio;
-	struct processed_extent processed = { 0 };
 	struct folio_iter fi;
 	const u32 sectorsize = fs_info->sectorsize;
 
@@ -640,11 +570,7 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 
 		/* Update page status and unlock. */
 		end_folio_read(folio, uptodate, start, len);
-		endio_readpage_release_extent(&processed, BTRFS_I(inode),
-					      start, end, uptodate);
 	}
-	/* Release the last extent */
-	endio_readpage_release_extent(&processed, NULL, 0, 0, false);
 	bio_put(bio);
 }
 
@@ -1019,11 +945,9 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 	size_t pg_offset = 0;
 	size_t iosize;
 	size_t blocksize = fs_info->sectorsize;
-	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 
 	ret = set_folio_extent_mapped(folio);
 	if (ret < 0) {
-		unlock_extent(tree, start, end, NULL);
 		folio_unlock(folio);
 		return ret;
 	}
@@ -1047,14 +971,12 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		if (cur >= last_byte) {
 			iosize = folio_size(folio) - pg_offset;
 			folio_zero_range(folio, pg_offset, iosize);
-			unlock_extent(tree, cur, cur + iosize - 1, NULL);
 			end_folio_read(folio, true, cur, iosize);
 			break;
 		}
 		em = __get_extent_map(inode, folio, cur, end - cur + 1,
 				      em_cached);
 		if (IS_ERR(em)) {
-			unlock_extent(tree, cur, end, NULL);
 			end_folio_read(folio, false, cur, end + 1 - cur);
 			return PTR_ERR(em);
 		}
@@ -1123,7 +1045,6 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		if (block_start == EXTENT_MAP_HOLE) {
 			folio_zero_range(folio, pg_offset, iosize);
 
-			unlock_extent(tree, cur, cur + iosize - 1, NULL);
 			end_folio_read(folio, true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
@@ -1131,7 +1052,6 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		}
 		/* the get_extent function already copied into the folio */
 		if (block_start == EXTENT_MAP_INLINE) {
-			unlock_extent(tree, cur, cur + iosize - 1, NULL);
 			end_folio_read(folio, true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
@@ -1161,11 +1081,13 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
 	u64 end = start + folio_size(folio) - 1;
 	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ };
 	struct extent_map *em_cached = NULL;
+	struct extent_state *cached = NULL;
 	int ret;
 
-	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
+	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached);
 
 	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
+	unlock_extent(&inode->io_tree, start, end, &cached);
 	free_extent_map(em_cached);
 
 	/*
@@ -2350,13 +2272,15 @@ void btrfs_readahead(struct readahead_control *rac)
 	u64 start = readahead_pos(rac);
 	u64 end = start + readahead_length(rac) - 1;
 	struct extent_map *em_cached = NULL;
+	struct extent_state *cached = NULL;
 	u64 prev_em_start = (u64)-1;
 
-	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
+	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached);;
 
 	while ((folio = readahead_folio(rac)) != NULL)
 		btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
 
+	unlock_extent(&inode->io_tree, start, end, &cached);
 	if (em_cached)
 		free_extent_map(em_cached);
 	submit_one_bio(&bio_ctrl);
-- 
2.43.0


