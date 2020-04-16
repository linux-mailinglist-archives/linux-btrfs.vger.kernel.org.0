Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991331AD22B
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 23:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgDPVqu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 17:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728502AbgDPVqt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 17:46:49 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69007C061A0C
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:49 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a32so125185pje.5
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fBIBBXiDKsW6ibbp4jYvW0Cq/4xUMCc2deFJPEe5w0c=;
        b=ZLnoSzEQQVfT7ThtkDFKekNNQNfkwIb0GuV9Ei1KO3ReHrernHboGhsRZ84Ghfn1RS
         +AJL0OrFtiD0Sm1pzvpRSZJyC4AdprwL1P6uLsRfL59gXEicPhtXFNJq6Rzh4wYgl+DO
         8WACjZjH8xRQZ/RK2Hjx2mRGcm78XOzz18sb1+EZAlVoxRAOAZtmkMgjeVtO/Fo0mmw5
         ZGXJD+sL7hatNSJm2HSaK+FvH7294qsfSMgvJ/gtQTdRmNk+cfGnrILyP0qkwf58ake1
         6lwZMuPwvd5NuCQBDDn6yuD42ehPIauQW/Ey5NmXOZM+vnib5aDvy2B+ZCLJWkFxXr7/
         KXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fBIBBXiDKsW6ibbp4jYvW0Cq/4xUMCc2deFJPEe5w0c=;
        b=XSR7E5rNqauF71cZqgyZVdU2fVNRk010cRDOk55VXYpKxdIG3WbOb0l25611nX0QZU
         BjFtbUeXSzizYT7SB8PG0o+US50EuP3XereKZe4eE8RjBLRB9FLz4FSqBBrMj2keuMwF
         sTutK/SirOGx85ZJMs+fr35y6LOd6+yQtuyxruhHPr0jSaEIus+fJ2LWUXQBcS9oRWw1
         aRRDYqC6eAJG/uhy3bRJOE+IGeP5I1cVXgx9isUqjSeToZw2E9FgFif2UtVDackbaPOb
         cJ+Gz9ovB02b3dmlnCPg3PwDi+ORktT3+RD5LVfCNXDQXTkIWEP3S19m7YKWsyr99o9c
         aAuw==
X-Gm-Message-State: AGi0PuYwRodlrsZrMBqJwE/7Hn8urJC8cz+rHcHCtOJBaZCudzdT7STk
        Z1Szz4a2gDcZbb8MsU0Y6TBa3FR9Cvw=
X-Google-Smtp-Source: APiQypLFik1luT0aFMiF46+x0wQ2LtWr3p1vAKI/j8nkVZDya2AdMrlQ7SAAVe9PLkEIzlons90W+g==
X-Received: by 2002:a17:90a:e2c1:: with SMTP id fr1mr471073pjb.124.1587073608250;
        Thu, 16 Apr 2020 14:46:48 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:844e])
        by smtp.gmail.com with ESMTPSA id 17sm12440228pgg.76.2020.04.16.14.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:46:47 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 13/15] btrfs: simplify direct I/O read repair
Date:   Thu, 16 Apr 2020 14:46:23 -0700
Message-Id: <ae795cbe844de282bb9efa6681d1dec2e043f7a0.1587072977.git.osandov@fb.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587072977.git.osandov@fb.com>
References: <cover.1587072977.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Direct I/O read repair was originally implemented in commit 8b110e393c5a
("Btrfs: implement repair function when direct read fails"). This
implementation is unnecessarily complicated. There is major code
duplication between __btrfs_subio_endio_read() (checks checksums and
handles I/O errors for files with checksums),
__btrfs_correct_data_nocsum() (handles I/O errors for files without
checksums), btrfs_retry_endio() (checks checksums and handles I/O errors
for retries of files with checksums), and btrfs_retry_endio_nocsum()
(handles I/O errors for retries of files without checksum). If it sounds
like these should be one function, that's because they should.
Additionally, these functions are very hard to follow due to their
excessive use of goto.

This commit replaces the original implementation. After the previous
commit getting rid of orig_bio, we can reuse the same endio callback for
repair I/O and the original I/O, we just need to track the file offset
and original iterator in the repair bio. We can also unify the handling
of files with and without checksums and simplify the control flow. We
also no longer have to wait for each repair I/O to complete one by one.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/extent_io.c |   2 +
 fs/btrfs/inode.c     | 268 +++++++------------------------------------
 2 files changed, 44 insertions(+), 226 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 85e98ba349a8..6e1d97bb7652 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2631,6 +2631,8 @@ struct bio *btrfs_create_repair_bio(struct inode *inode, struct bio *failed_bio,
 	}
 
 	bio_add_page(bio, page, failrec->len, pg_offset);
+	btrfs_io_bio(bio)->logical = failrec->start;
+	btrfs_io_bio(bio)->iter = bio->bi_iter;
 
 	return bio;
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 79b884d2f3ed..2580f2d251d4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7435,19 +7435,17 @@ static int btrfs_check_dio_repairable(struct inode *inode,
 
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
 
@@ -7462,261 +7460,79 @@ static blk_status_t dio_read_error(struct inode *inode, struct bio *failed_bio,
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
+		for (i = 0; i < nr_sectors; i++) {
 			ASSERT(pgoff < PAGE_SIZE);
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
-			ASSERT(pgoff < PAGE_SIZE);
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
@@ -7785,7 +7601,7 @@ static void btrfs_end_dio_bio(struct bio *bio)
 
 	if (bio_op(bio) == REQ_OP_READ) {
 		err = btrfs_check_read_dio_bio(dip->inode, btrfs_io_bio(bio),
-					       err);
+					       !err);
 	}
 
 	if (err)
-- 
2.26.1

