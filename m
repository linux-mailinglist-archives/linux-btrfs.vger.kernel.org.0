Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6651AD22D
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 23:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgDPVqw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 17:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728526AbgDPVqw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 17:46:52 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5852C061A0C
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:51 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y22so129046pll.4
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LcoO5JXWi6U7hEw7U4/GAhMEvthRp0rDTrpYyehIiys=;
        b=pu2ItKPMmCAPQpe8ZDw1JYhmPmvKSabf9m4nwrmqkBBQ0DwiNIisUFrj5MIkyPHcPJ
         54f3gQmvVV3uXJECbslaJ1Q5OAej2RqbBvjatgVSj1EPeEwrtFsy5cfb0ZYIvMmaNMl7
         va/IPLjTFV/8RfOMwei1epbDK+4r/QFcX0VfMLdoKrw+s2sgKbjaBdw4ZesbrK8q21Y4
         caU+JOK9rYsrUm5DF8CKjx4dWt6EFVgYfjJizekEKKh4ZvlQCdHZ5U3fE6RbpFZMOGOj
         smZDdZbu1urbBbjtb1XUzftcAaPbZkGU084O/gcdwlVteFwqGeOFKjTJeoMsPgMvXFj6
         GWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LcoO5JXWi6U7hEw7U4/GAhMEvthRp0rDTrpYyehIiys=;
        b=rzFlSdQMRmJLuxMFJsA6uBWevJTfHqW0PZQNIM94coJo/U4B0SnD0PDXB8BKHeWZVK
         BjeocrtjH2hD+7tDf43K8kacTEsJ35LddXcf95DUthvLBkN4k8TYefJyFr0ObvQSBBFa
         s0IHkpi3NDZGgmZ+sZGhkv4V6jpF0QWTIl1+THdrpYDM+7nuWQIFS+OYNCRVp95MRhJc
         yxtz7hLewR3CZrHDk4xcqIMomMn0l3Wptx/F7xUYLGfFoa8cgOlF2EuGyXdA5Fc3nxe0
         KfH8d9qUyWrnV+r5D3+HZewdQ7zEGKnZhitqwL3DXi/pEYRN4qR3zABuz2yJrw2CmGea
         Cr8A==
X-Gm-Message-State: AGi0PuYP1TNfvsLlTSUFbeoqO6bi8SFRdrG+SPPX0jpvVlDdjqgwT8YP
        m1bxhi4uKTV0MUQPAXadTuTxjasDQ6I=
X-Google-Smtp-Source: APiQypJJscN43vnYJiWVdA2zTQ7JNzb/ySyzE6gWbOuM90fP/Up3eYhefm0SBcrYDVDKcn+Ak+MD8w==
X-Received: by 2002:a17:90a:7d09:: with SMTP id g9mr427034pjl.105.1587073610903;
        Thu, 16 Apr 2020 14:46:50 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:844e])
        by smtp.gmail.com with ESMTPSA id 17sm12440228pgg.76.2020.04.16.14.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:46:50 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 15/15] btrfs: unify buffered and direct I/O read repair
Date:   Thu, 16 Apr 2020 14:46:25 -0700
Message-Id: <65f462557c05818d83fe8e141b24f143e2af347e.1587072977.git.osandov@fb.com>
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

Currently, direct I/O has its own versions of bio_readpage_error() and
btrfs_check_repairable() (dio_read_error() and
btrfs_check_dio_repairable(), respectively). The main difference is that
the direct I/O version doesn't do read validation. The rework of direct
I/O repair makes it possible to do validation, so we can get rid of
btrfs_check_dio_repairable() and combine bio_readpage_error() and
dio_read_error() into a new helper, btrfs_submit_read_repair().

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/extent_io.c | 130 ++++++++++++++++++++-----------------------
 fs/btrfs/extent_io.h |  17 ++++--
 fs/btrfs/inode.c     | 103 ++++------------------------------
 3 files changed, 82 insertions(+), 168 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6e1d97bb7652..4c59ff5b0e3c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2602,41 +2602,6 @@ static bool btrfs_check_repairable(struct inode *inode,
 	return true;
 }
 
-
-struct bio *btrfs_create_repair_bio(struct inode *inode, struct bio *failed_bio,
-				    struct io_failure_record *failrec,
-				    struct page *page, int pg_offset, int icsum,
-				    bio_end_io_t *endio_func, void *data)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct bio *bio;
-	struct btrfs_io_bio *btrfs_failed_bio;
-	struct btrfs_io_bio *btrfs_bio;
-
-	bio = btrfs_io_bio_alloc(1);
-	bio->bi_end_io = endio_func;
-	bio->bi_iter.bi_sector = failrec->logical >> 9;
-	bio->bi_iter.bi_size = 0;
-	bio->bi_private = data;
-
-	btrfs_failed_bio = btrfs_io_bio(failed_bio);
-	if (btrfs_failed_bio->csum) {
-		u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
-
-		btrfs_bio = btrfs_io_bio(bio);
-		btrfs_bio->csum = btrfs_bio->csum_inline;
-		icsum *= csum_size;
-		memcpy(btrfs_bio->csum, btrfs_failed_bio->csum + icsum,
-		       csum_size);
-	}
-
-	bio_add_page(bio, page, failrec->len, pg_offset);
-	btrfs_io_bio(bio)->logical = failrec->start;
-	btrfs_io_bio(bio)->iter = bio->bi_iter;
-
-	return bio;
-}
-
 static bool btrfs_io_needs_validation(struct inode *inode, struct bio *bio)
 {
 	struct bio_vec *bvec;
@@ -2654,72 +2619,96 @@ static bool btrfs_io_needs_validation(struct inode *inode, struct bio *bio)
 	/*
 	 * We need to validate each sector individually if the failed I/O was
 	 * for multiple sectors.
+	 *
+	 * There are a few possible bios that can end up here:
+	 * 1. A buffered read bio, which is not cloned.
+	 * 2. A direct I/O read bio, which is cloned.
+	 * 3. A (buffered or direct) repair bio, which is not cloned.
+	 *
+	 * For cloned bios (case 2), we can get the size from
+	 * btrfs_io_bio->iter; for non-cloned bios (cases 1 and 3), we can get
+	 * it from the bvecs.
 	 */
-	bio_for_each_bvec_all(bvec, bio, i) {
-		len += bvec->bv_len;
-		if (len > inode->i_sb->s_blocksize)
+	if (bio_flagged(bio, BIO_CLONED)) {
+		if (btrfs_io_bio(bio)->iter.bi_size > inode->i_sb->s_blocksize)
 			return true;
+	} else {
+		bio_for_each_bvec_all(bvec, bio, i) {
+			len += bvec->bv_len;
+			if (len > inode->i_sb->s_blocksize)
+				return true;
+		}
 	}
 	return false;
 }
 
-/*
- * This is a generic handler for readpage errors. If other copies exist, read
- * those and write back good data to the failed position. Does not investigate
- * in remapping the failed extent elsewhere, hoping the device will be smart
- * enough to do this as needed
- */
-static int bio_readpage_error(struct bio *failed_bio, u64 phy_offset,
-			      struct page *page, u64 start, u64 end,
-			      int failed_mirror)
+blk_status_t btrfs_submit_read_repair(struct inode *inode,
+				      struct bio *failed_bio, u64 phy_offset,
+				      struct page *page, unsigned int pgoff,
+				      u64 start, u64 end, int failed_mirror,
+				      submit_bio_hook_t *submit_bio_hook)
 {
 	struct io_failure_record *failrec;
-	struct inode *inode = page->mapping->host;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
+	struct btrfs_io_bio *failed_io_bio = btrfs_io_bio(failed_bio);
+	int icsum = phy_offset >> inode->i_sb->s_blocksize_bits;
 	bool need_validation;
-	struct bio *bio;
-	int read_mode = 0;
+	struct bio *repair_bio;
+	struct btrfs_io_bio *repair_io_bio;
 	blk_status_t status;
 	int ret;
 
+	btrfs_info(btrfs_sb(inode->i_sb),
+		   "Repair Read Error: read error at %llu", start);
+
 	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
 
 	ret = btrfs_get_io_failure_record(inode, start, end, &failrec);
 	if (ret)
-		return ret;
+		return errno_to_blk_status(ret);
 
 	need_validation = btrfs_io_needs_validation(inode, failed_bio);
 
 	if (!btrfs_check_repairable(inode, need_validation, failrec,
 				    failed_mirror)) {
 		free_io_failure(failure_tree, tree, failrec);
-		return -EIO;
+		return BLK_STS_IOERR;
 	}
 
+	repair_bio = btrfs_io_bio_alloc(1);
+	repair_io_bio = btrfs_io_bio(repair_bio);
+	repair_bio->bi_opf = REQ_OP_READ;
 	if (need_validation)
-		read_mode |= REQ_FAILFAST_DEV;
+		repair_bio->bi_opf |= REQ_FAILFAST_DEV;
+	repair_bio->bi_end_io = failed_bio->bi_end_io;
+	repair_bio->bi_iter.bi_sector = failrec->logical >> 9;
+	repair_bio->bi_private = failed_bio->bi_private;
 
-	phy_offset >>= inode->i_sb->s_blocksize_bits;
-	bio = btrfs_create_repair_bio(inode, failed_bio, failrec, page,
-				      start - page_offset(page),
-				      (int)phy_offset, failed_bio->bi_end_io,
-				      NULL);
-	bio->bi_opf = REQ_OP_READ | read_mode;
+	if (failed_io_bio->csum) {
+		u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+
+		repair_io_bio->csum = repair_io_bio->csum_inline;
+		memcpy(repair_io_bio->csum,
+		       failed_io_bio->csum + csum_size * icsum, csum_size);
+	}
+
+	bio_add_page(repair_bio, page, failrec->len, pgoff);
+	repair_io_bio->logical = failrec->start;
+	repair_io_bio->iter = repair_bio->bi_iter;
 
 	btrfs_debug(btrfs_sb(inode->i_sb),
-		"Repair Read Error: submitting new read[%#x] to this_mirror=%d, in_validation=%d",
-		read_mode, failrec->this_mirror, failrec->in_validation);
+"Repair Read Error: submitting new read to this_mirror=%d, in_validation=%d",
+		    failrec->this_mirror, failrec->in_validation);
 
-	status = tree->ops->submit_bio_hook(tree->private_data, bio, failrec->this_mirror,
-					 failrec->bio_flags);
+	status = submit_bio_hook(inode, repair_bio, failrec->this_mirror,
+				 failrec->bio_flags);
 	if (status) {
 		free_io_failure(failure_tree, tree, failrec);
-		bio_put(bio);
-		ret = blk_status_to_errno(status);
+		bio_put(repair_bio);
 	}
-
-	return ret;
+	return status;
 }
 
 /* lots and lots of room for performance fixes in the end_bio funcs */
@@ -2891,9 +2880,10 @@ static void end_bio_extent_readpage(struct bio *bio)
 			 * If it can't handle the error it will return -EIO and
 			 * we remain responsible for that page.
 			 */
-			ret = bio_readpage_error(bio, offset, page, start, end,
-						 mirror);
-			if (ret == 0) {
+			if (!btrfs_submit_read_repair(inode, bio, offset, page,
+						start - page_offset(page),
+						start, end, mirror,
+						tree->ops->submit_bio_hook)) {
 				uptodate = !bio->bi_status;
 				offset += len;
 				continue;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index f4dfac756455..a2842b2d9a98 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -66,6 +66,10 @@ struct btrfs_io_bio;
 struct io_failure_record;
 struct extent_io_tree;
 
+typedef blk_status_t (submit_bio_hook_t)(struct inode *inode, struct bio *bio,
+					 int mirror_num,
+					 unsigned long bio_flags);
+
 typedef blk_status_t (extent_submit_bio_start_t)(void *private_data,
 		struct bio *bio, u64 bio_offset);
 
@@ -74,8 +78,7 @@ struct extent_io_ops {
 	 * The following callbacks must be always defined, the function
 	 * pointer will be called unconditionally.
 	 */
-	blk_status_t (*submit_bio_hook)(struct inode *inode, struct bio *bio,
-					int mirror_num, unsigned long bio_flags);
+	submit_bio_hook_t *submit_bio_hook;
 	int (*readpage_end_io_hook)(struct btrfs_io_bio *io_bio, u64 phy_offset,
 				    struct page *page, u64 start, u64 end,
 				    int mirror);
@@ -312,10 +315,12 @@ struct io_failure_record {
 };
 
 
-struct bio *btrfs_create_repair_bio(struct inode *inode, struct bio *failed_bio,
-				    struct io_failure_record *failrec,
-				    struct page *page, int pg_offset, int icsum,
-				    bio_end_io_t *endio_func, void *data);
+blk_status_t btrfs_submit_read_repair(struct inode *inode,
+				      struct bio *failed_bio, u64 phy_offset,
+				      struct page *page, unsigned int pgoff,
+				      u64 start, u64 end, int failed_mirror,
+				      submit_bio_hook_t *submit_bio_hook);
+
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 bool find_lock_delalloc_range(struct inode *inode,
 			     struct page *locked_page, u64 *start,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 72fb398a88f7..a4e9f9d0a43d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7379,10 +7379,11 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 	kfree(dip);
 }
 
-static inline blk_status_t submit_dio_repair_bio(struct inode *inode,
-						 struct bio *bio,
-						 int mirror_num)
+static blk_status_t submit_dio_repair_bio(struct inode *inode, struct bio *bio,
+					  int mirror_num,
+					  unsigned long bio_flags)
 {
+	struct btrfs_dio_private *dip = bio->bi_private;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	blk_status_t ret;
 
@@ -7392,96 +7393,11 @@ static inline blk_status_t submit_dio_repair_bio(struct inode *inode,
 	if (ret)
 		return ret;
 
+	refcount_inc(&dip->refs);
 	ret = btrfs_map_bio(fs_info, bio, mirror_num);
-
-	return ret;
-}
-
-static int btrfs_check_dio_repairable(struct inode *inode,
-				      struct bio *failed_bio,
-				      struct io_failure_record *failrec,
-				      int failed_mirror)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	int num_copies;
-
-	num_copies = btrfs_num_copies(fs_info, failrec->logical, failrec->len);
-	if (num_copies == 1) {
-		/*
-		 * we only have a single copy of the data, so don't bother with
-		 * all the retry and error correction code that follows. no
-		 * matter what the error is, it is very likely to persist.
-		 */
-		btrfs_debug(fs_info,
-			"Check DIO Repairable: cannot repair, num_copies=%d, next_mirror %d, failed_mirror %d",
-			num_copies, failrec->this_mirror, failed_mirror);
-		return 0;
-	}
-
-	failrec->failed_mirror = failed_mirror;
-	failrec->this_mirror++;
-	if (failrec->this_mirror == failed_mirror)
-		failrec->this_mirror++;
-
-	if (failrec->this_mirror > num_copies) {
-		btrfs_debug(fs_info,
-			"Check DIO Repairable: (fail) num_copies=%d, next_mirror %d, failed_mirror %d",
-			num_copies, failrec->this_mirror, failed_mirror);
-		return 0;
-	}
-
-	return 1;
-}
-
-static blk_status_t dio_read_error(struct inode *inode, struct bio *failed_bio,
-				   struct page *page, unsigned int pgoff,
-				   u64 start, u64 end, int failed_mirror)
-{
-	struct btrfs_dio_private *dip = failed_bio->bi_private;
-	struct io_failure_record *failrec;
-	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
-	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
-	struct bio *bio;
-	int isector;
-	unsigned int read_mode = 0;
-	int ret;
-	blk_status_t status;
-
-	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
-
-	ret = btrfs_get_io_failure_record(inode, start, end, &failrec);
 	if (ret)
-		return errno_to_blk_status(ret);
-
-	ret = btrfs_check_dio_repairable(inode, failed_bio, failrec,
-					 failed_mirror);
-	if (!ret) {
-		free_io_failure(failure_tree, io_tree, failrec);
-		return BLK_STS_IOERR;
-	}
-
-	if (btrfs_io_bio(failed_bio)->iter.bi_size > inode->i_sb->s_blocksize)
-		read_mode |= REQ_FAILFAST_DEV;
-
-	isector = start - btrfs_io_bio(failed_bio)->logical;
-	isector >>= inode->i_sb->s_blocksize_bits;
-	bio = btrfs_create_repair_bio(inode, failed_bio, failrec, page, pgoff,
-				      isector, failed_bio->bi_end_io, dip);
-	bio->bi_opf = REQ_OP_READ | read_mode;
-
-	btrfs_debug(BTRFS_I(inode)->root->fs_info,
-		    "repair DIO read error: submitting new dio read[%#x] to this_mirror=%d, in_validation=%d",
-		    read_mode, failrec->this_mirror, failrec->in_validation);
-
-	refcount_inc(&dip->refs);
-	status = submit_dio_repair_bio(inode, bio, failrec->this_mirror);
-	if (status) {
-		free_io_failure(failure_tree, io_tree, failrec);
-		bio_put(bio);
 		refcount_dec(&dip->refs);
-	}
-
-	return status;
+	return ret;
 }
 
 static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
@@ -7517,11 +7433,14 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 			} else {
 				blk_status_t status;
 
-				status = dio_read_error(inode, &io_bio->bio,
+				status = btrfs_submit_read_repair(inode,
+							&io_bio->bio,
+							start - io_bio->logical,
 							bvec.bv_page, pgoff,
 							start,
 							start + sectorsize - 1,
-							io_bio->mirror_num);
+							io_bio->mirror_num,
+							submit_dio_repair_bio);
 				if (status)
 					err = status;
 			}
-- 
2.26.1

