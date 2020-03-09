Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 442EE17EB44
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 22:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCIVdM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 17:33:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40354 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgCIVdL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 17:33:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id l184so5424665pfl.7
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2020 14:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S8STYHxLsVnjqMDvX7YlglXGkK2/RTtA3/njWgyjptU=;
        b=If8GD2y+h1dLHbJUStXnPnii7o1vKE2uBOmGb8efrF62AMdcPi3btE874XhuXYv4s8
         AjBD+XXWQTU9bVuSu4nTDu1Tt8z5bAx9MeBlgGeISJiVqXZxtULa1J9XLTw18rDXwigY
         KBHsnwANdEvcC9/GWWSUm/X0wahP2l9OQfHQMoUnSSK82vDZa4PiiUjMsbBxr0JubfVA
         HjxpWrS20W/JJHbFMTL2u1nrsgOdZfTkyrwf7Fo8WobAfeo+JawXNO7VV5/Cnsotkx03
         mPp5n+u5bSYsExi+HZ2RIX3oOihb17LGgKS+cCSedHG8+a1I4t1mbPIDUgsp5BCWrJIn
         yuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S8STYHxLsVnjqMDvX7YlglXGkK2/RTtA3/njWgyjptU=;
        b=R5szQDp3FTVCG5DV9FysMHv1gOVDGxeBvbBWi1ZRHP5Za6t8X37edvu26hNubRBC1C
         Q+mbl9uzYnwFIfyi0f3QizpSACdITfuSkRq0G+WOkMHxWIUTim1iYMC44LnJ2neSzhL/
         U2dCLbiukjCgLVu+L/8tvjSr7WsvyweSvY8GyL9+381Tp844SSk4g97iAwaCAKQxB9rV
         1valHkliaVBFwZzbZHMpUN029maBHbeY8V5P0AIZRsUTdzVJPi6+roCRSKpuZPldnrmM
         2bM982htigRgQEFifFMKUppLj8ufhqaYECfUkJCvRelBiWyXRmsyDaRIdC/I+gfvTgZx
         AcLg==
X-Gm-Message-State: ANhLgQ10cT4irIeKzEk9Fa3uqyGWTf5qB7AhX4zdwmZNXO6xuvh/wxNx
        X/ks5AH2BdiRqY8gOHxY4gxr5kDojkU=
X-Google-Smtp-Source: ADFU+vtLaj3Ak0ALgoYauUq/EzYNGzNpVAPsod3vZ7k14CVXXH87zkyZwptW5bB3OV2TXba/U14l4A==
X-Received: by 2002:a62:2a8d:: with SMTP id q135mr3470184pfq.220.1583789589585;
        Mon, 09 Mar 2020 14:33:09 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:fe90])
        by smtp.gmail.com with ESMTPSA id 13sm44221683pgo.13.2020.03.09.14.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:33:09 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 13/15] btrfs: simplify direct I/O read repair
Date:   Mon,  9 Mar 2020 14:32:39 -0700
Message-Id: <38cea444fa3f88ca514d161bd979d004c254e969.1583789410.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583789410.git.osandov@fb.com>
References: <cover.1583789410.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Direct I/O read repair is an over-complicated mess. There is major code
duplication between __btrfs_subio_endio_read() (checks checksums and
handles I/O errors for files with checksums),
__btrfs_correct_data_nocsum() (handles I/O errors for files without
checksums), btrfs_retry_endio() (checks checksums and handles I/O errors
for retries of files with checksums), and btrfs_retry_endio_nocsum()
(handles I/O errors for retries of files without checksum). If it sounds
like these should be one function, that's because they should.

After the previous commit getting rid of orig_bio, we can reuse the same
endio callback for repair I/O and the original I/O, we just need to
track the file offset and original iterator in the repair bio. We can
also unify the handling of files with and without checksums and replace
the atrocity that was probably the inspiration for "Go To Statement
Considered Harmful" with normal loops. We also no longer have to wait
for each repair I/O to complete one by one.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/extent_io.c |   2 +
 fs/btrfs/inode.c     | 268 +++++++------------------------------------
 2 files changed, 44 insertions(+), 226 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index aee35d431f91..fad86ef4d09d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2622,6 +2622,8 @@ struct bio *btrfs_create_repair_bio(struct inode *inode, struct bio *failed_bio,
 	}
 
 	bio_add_page(bio, page, failrec->len, pg_offset);
+	btrfs_io_bio(bio)->logical = failrec->start;
+	btrfs_io_bio(bio)->iter = bio->bi_iter;
 
 	return bio;
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 40c1562704e9..ef302b7c6c2d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7463,19 +7463,17 @@ static int btrfs_check_dio_repairable(struct inode *inode,
 
 static blk_status_t dio_read_error(struct inode *inode, struct bio *failed_bio,
 				   struct page *page, unsigned int pgoff,
-				   u64 start, u64 end, int failed_mirror,
-				   bio_end_io_t *repair_endio, void *repair_arg)
+				   u64 start, u64 end, int failed_mirror)
 {
+	struct btrfs_dio_private *dip = failed_bio->bi_private;
 	struct io_failure_record *failrec;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
 	struct bio *bio;
 	int isector;
 	unsigned int read_mode = 0;
-	int segs;
 	int ret;
 	blk_status_t status;
-	struct bio_vec bvec;
 
 	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
 
@@ -7490,261 +7488,79 @@ static blk_status_t dio_read_error(struct inode *inode, struct bio *failed_bio,
 		return BLK_STS_IOERR;
 	}
 
-	segs = bio_segments(failed_bio);
-	bio_get_first_bvec(failed_bio, &bvec);
-	if (segs > 1 ||
-	    (bvec.bv_len > btrfs_inode_sectorsize(inode)))
+	if (btrfs_io_bio(failed_bio)->iter.bi_size > inode->i_sb->s_blocksize)
 		read_mode |= REQ_FAILFAST_DEV;
 
 	isector = start - btrfs_io_bio(failed_bio)->logical;
 	isector >>= inode->i_sb->s_blocksize_bits;
-	bio = btrfs_create_repair_bio(inode, failed_bio, failrec, page,
-				pgoff, isector, repair_endio, repair_arg);
+	bio = btrfs_create_repair_bio(inode, failed_bio, failrec, page, pgoff,
+				      isector, failed_bio->bi_end_io, dip);
 	bio->bi_opf = REQ_OP_READ | read_mode;
 
 	btrfs_debug(BTRFS_I(inode)->root->fs_info,
 		    "repair DIO read error: submitting new dio read[%#x] to this_mirror=%d, in_validation=%d",
 		    read_mode, failrec->this_mirror, failrec->in_validation);
 
+	refcount_inc(&dip->refs);
 	status = submit_dio_repair_bio(inode, bio, failrec->this_mirror);
 	if (status) {
 		free_io_failure(failure_tree, io_tree, failrec);
 		bio_put(bio);
+		refcount_dec(&dip->refs);
 	}
 
 	return status;
 }
 
-struct btrfs_retry_complete {
-	struct completion done;
-	struct inode *inode;
-	u64 start;
-	int uptodate;
-};
-
-static void btrfs_retry_endio_nocsum(struct bio *bio)
-{
-	struct btrfs_retry_complete *done = bio->bi_private;
-	struct inode *inode = done->inode;
-	struct bio_vec *bvec;
-	struct extent_io_tree *io_tree, *failure_tree;
-	struct bvec_iter_all iter_all;
-
-	if (bio->bi_status)
-		goto end;
-
-	ASSERT(bio->bi_vcnt == 1);
-	io_tree = &BTRFS_I(inode)->io_tree;
-	failure_tree = &BTRFS_I(inode)->io_failure_tree;
-	ASSERT(bio_first_bvec_all(bio)->bv_len == btrfs_inode_sectorsize(inode));
-
-	done->uptodate = 1;
-	ASSERT(!bio_flagged(bio, BIO_CLONED));
-	bio_for_each_segment_all(bvec, bio, iter_all)
-		clean_io_failure(BTRFS_I(inode)->root->fs_info, failure_tree,
-				 io_tree, done->start, bvec->bv_page,
-				 btrfs_ino(BTRFS_I(inode)), 0);
-end:
-	complete(&done->done);
-	bio_put(bio);
-}
-
-static blk_status_t __btrfs_correct_data_nocsum(struct inode *inode,
-						struct btrfs_io_bio *io_bio)
+static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
+					     struct btrfs_io_bio *io_bio,
+					     const bool uptodate)
 {
-	struct btrfs_fs_info *fs_info;
+	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
+	u32 sectorsize = fs_info->sectorsize;
+	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
+	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 	struct bio_vec bvec;
 	struct bvec_iter iter;
-	struct btrfs_retry_complete done;
-	u64 start;
-	unsigned int pgoff;
-	u32 sectorsize;
-	int nr_sectors;
-	blk_status_t ret;
+	u64 start = io_bio->logical;
+	int icsum = 0;
 	blk_status_t err = BLK_STS_OK;
 
-	fs_info = BTRFS_I(inode)->root->fs_info;
-	sectorsize = fs_info->sectorsize;
-
-	start = io_bio->logical;
-	done.inode = inode;
-	io_bio->bio.bi_iter = io_bio->iter;
+	__bio_for_each_segment(bvec, &io_bio->bio, iter, io_bio->iter) {
+		unsigned int i, nr_sectors, pgoff;
 
-	bio_for_each_segment(bvec, &io_bio->bio, iter) {
 		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec.bv_len);
 		pgoff = bvec.bv_offset;
-
-next_block_or_try_again:
-		done.uptodate = 0;
-		done.start = start;
-		init_completion(&done.done);
-
-		ret = dio_read_error(inode, &io_bio->bio, bvec.bv_page,
-				pgoff, start, start + sectorsize - 1,
-				io_bio->mirror_num,
-				btrfs_retry_endio_nocsum, &done);
-		if (ret) {
-			err = ret;
-			goto next;
-		}
-
-		wait_for_completion_io(&done.done);
-
-		if (!done.uptodate) {
-			/* We might have another mirror, so try again */
-			goto next_block_or_try_again;
-		}
-
-next:
-		start += sectorsize;
-
-		nr_sectors--;
-		if (nr_sectors) {
-			pgoff += sectorsize;
-			ASSERT(pgoff < PAGE_SIZE);
-			goto next_block_or_try_again;
-		}
-	}
-
-	return err;
-}
-
-static void btrfs_retry_endio(struct bio *bio)
-{
-	struct btrfs_retry_complete *done = bio->bi_private;
-	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
-	struct extent_io_tree *io_tree, *failure_tree;
-	struct inode *inode = done->inode;
-	struct bio_vec *bvec;
-	int uptodate;
-	int ret;
-	int i = 0;
-	struct bvec_iter_all iter_all;
-
-	if (bio->bi_status)
-		goto end;
-
-	uptodate = 1;
-
-	ASSERT(bio->bi_vcnt == 1);
-	ASSERT(bio_first_bvec_all(bio)->bv_len == btrfs_inode_sectorsize(done->inode));
-
-	io_tree = &BTRFS_I(inode)->io_tree;
-	failure_tree = &BTRFS_I(inode)->io_failure_tree;
-
-	ASSERT(!bio_flagged(bio, BIO_CLONED));
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		ret = check_data_csum(inode, io_bio, i, bvec->bv_page,
-				      bvec->bv_offset, done->start,
-				      bvec->bv_len);
-		if (!ret)
-			clean_io_failure(BTRFS_I(inode)->root->fs_info,
-					 failure_tree, io_tree, done->start,
-					 bvec->bv_page,
-					 btrfs_ino(BTRFS_I(inode)),
-					 bvec->bv_offset);
-		else
-			uptodate = 0;
-		i++;
-	}
-
-	done->uptodate = uptodate;
-end:
-	complete(&done->done);
-	bio_put(bio);
-}
-
-static blk_status_t __btrfs_subio_endio_read(struct inode *inode,
-		struct btrfs_io_bio *io_bio, blk_status_t err)
-{
-	struct btrfs_fs_info *fs_info;
-	struct bio_vec bvec;
-	struct bvec_iter iter;
-	struct btrfs_retry_complete done;
-	u64 start;
-	u64 offset = 0;
-	u32 sectorsize;
-	int nr_sectors;
-	unsigned int pgoff;
-	int csum_pos;
-	bool uptodate = (err == 0);
-	int ret;
-	blk_status_t status;
-
-	fs_info = BTRFS_I(inode)->root->fs_info;
-	sectorsize = fs_info->sectorsize;
-
-	err = BLK_STS_OK;
-	start = io_bio->logical;
-	done.inode = inode;
-	io_bio->bio.bi_iter = io_bio->iter;
-
-	bio_for_each_segment(bvec, &io_bio->bio, iter) {
-		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec.bv_len);
-
-		pgoff = bvec.bv_offset;
-next_block:
-		if (uptodate) {
-			csum_pos = BTRFS_BYTES_TO_BLKS(fs_info, offset);
-			ret = check_data_csum(inode, io_bio, csum_pos,
-					      bvec.bv_page, pgoff, start,
-					      sectorsize);
-			if (likely(!ret))
-				goto next;
-		}
-try_again:
-		done.uptodate = 0;
-		done.start = start;
-		init_completion(&done.done);
-
-		status = dio_read_error(inode, &io_bio->bio, bvec.bv_page,
-					pgoff, start, start + sectorsize - 1,
-					io_bio->mirror_num, btrfs_retry_endio,
-					&done);
-		if (status) {
-			err = status;
-			goto next;
-		}
-
-		wait_for_completion_io(&done.done);
-
-		if (!done.uptodate) {
-			/* We might have another mirror, so try again */
-			goto try_again;
-		}
-next:
-		offset += sectorsize;
-		start += sectorsize;
-
-		ASSERT(nr_sectors);
-
-		nr_sectors--;
-		if (nr_sectors) {
+		for (i = 0; i < nr_sectors; i++) {
+			if (uptodate &&
+			    (!csum || !check_data_csum(inode, io_bio, icsum,
+						       bvec.bv_page, pgoff,
+						       start, sectorsize))) {
+				clean_io_failure(fs_info, failure_tree, io_tree,
+						 start, bvec.bv_page,
+						 btrfs_ino(BTRFS_I(inode)),
+						 pgoff);
+			} else {
+				blk_status_t status;
+
+				status = dio_read_error(inode, &io_bio->bio,
+							bvec.bv_page, pgoff,
+							start,
+							start + sectorsize - 1,
+							io_bio->mirror_num);
+				if (status)
+					err = status;
+			}
+			start += sectorsize;
+			icsum++;
 			pgoff += sectorsize;
 			ASSERT(pgoff < PAGE_SIZE);
-			goto next_block;
 		}
 	}
-
 	return err;
 }
 
-static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
-					     struct btrfs_io_bio *io_bio,
-					     blk_status_t err)
-{
-	bool skip_csum = BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM;
-
-	if (skip_csum) {
-		if (unlikely(err))
-			return __btrfs_correct_data_nocsum(inode, io_bio);
-		else
-			return BLK_STS_OK;
-	} else {
-		return __btrfs_subio_endio_read(inode, io_bio, err);
-	}
-}
-
 static void __endio_write_update_ordered(struct inode *inode,
 					 const u64 offset, const u64 bytes,
 					 const bool uptodate)
@@ -7813,7 +7629,7 @@ static void btrfs_end_dio_bio(struct bio *bio)
 
 	if (bio_op(bio) == REQ_OP_READ) {
 		err = btrfs_check_read_dio_bio(dip->inode, btrfs_io_bio(bio),
-					       err);
+					       !err);
 	}
 
 	if (err)
-- 
2.25.1

