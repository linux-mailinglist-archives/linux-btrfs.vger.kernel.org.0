Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4F337B52B
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 May 2021 06:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhELEyq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 00:54:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:41738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhELEyp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 00:54:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620795217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nscCee4+jfplHDVcMubDKggYlJDmcVzDFsJoUb8guJ8=;
        b=T2u5Fr2AtyqtdtW5GajdOzJ6kkxTj+Feohywy9NyN8uX2FIhdF3sfYQyFreiqLRr0okbSm
        d9yAOcLUZRPLBeowDpaRdbVFXhCcMwMPQ6Lz7q/wXQEYyII8yYtr+G3DbTooXl+eUB4/6v
        B0wHSYUNiUjS/eEnKYad6/ru/NCa8UA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7C702AE8D
        for <linux-btrfs@vger.kernel.org>; Wed, 12 May 2021 04:53:37 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 2/3] btrfs: submit read time repair only for each corrupted sector
Date:   Wed, 12 May 2021 12:53:29 +0800
Message-Id: <20210512045330.40329-3-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512045330.40329-1-wqu@suse.com>
References: <20210512045330.40329-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs_submit_read_repair() has some extra check on whether the
failed bio needs extra validation for repair.

But we can avoid all these extra mechanism if we submit the repair for
each sector.

By this, each read repair can be easily handled without the need to
verify which sector is corrupted.

This will also benefit subpage, as one subpage bvec can contain several
sectors, making the extra verification more complex.

So this patch will:
- Introduce repair_one_sector()
  The main code submitting repair, which is more or less the same as old
  btrfs_submit_read_repair().
  But this time, it only repairs one sector.

- Make btrfs_submit_read_repair() to handle sectors differently
  There are 3 different cases:
  * Good sector
    We need to release the page and extent, set the range uptodate.

  * Bad sector and failed to submit repair bio
    We need to release the page and extent, but not set the range
    uptodate.

  * Bad sector but repair bio submitted
    The page and extent release will be handled by the submitted repair
    bio. Nothing needs to be done.

  Since btrfs_submit_read_repair() will handle the page and extent
  release now, we need to skip to next bvec even we hit some error.

- Change the lifespan of @uptodate in end_bio_extent_readpage()
  Since now btrfs_submit_read_repair() will handle the full bvec
  which contains any corruption, we don't need to bother updating
  @uptodate bit anymore.
  Just let @uptodate to be local variable inside the main loop,
  so that any error from one bvec won't affect later bvec.

- Only export btrfs_repair_one_sector(), unexport
  btrfs_submit_read_repair()
  The only outside caller for read repair is DIO, which already submit
  its repair for just one sector.
  Only export btrfs_repair_one_sector() for DIO.

This patch will focus on the change on the repair path, the extra
validation code is still kept as is, and will be cleaned up later.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 233 ++++++++++++++++++++++++++++---------------
 fs/btrfs/extent_io.h |  10 +-
 fs/btrfs/inode.c     |   9 +-
 3 files changed, 164 insertions(+), 88 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8b861227daef..85719947fa31 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2494,7 +2494,7 @@ void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start, u64 end)
 }
 
 static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode,
-							     u64 start, u64 end)
+							     u64 start)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct io_failure_record *failrec;
@@ -2502,6 +2502,7 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
+	const u32 sectorsize = fs_info->sectorsize;
 	int ret;
 	u64 logical;
 
@@ -2525,7 +2526,7 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 		return ERR_PTR(-ENOMEM);
 
 	failrec->start = start;
-	failrec->len = end - start + 1;
+	failrec->len = sectorsize;
 	failrec->this_mirror = 0;
 	failrec->bio_flags = 0;
 	failrec->in_validation = 0;
@@ -2564,12 +2565,13 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	free_extent_map(em);
 
 	/* Set the bits in the private failure tree */
-	ret = set_extent_bits(failure_tree, start, end,
+	ret = set_extent_bits(failure_tree, start, start + sectorsize - 1,
 			      EXTENT_LOCKED | EXTENT_DIRTY);
 	if (ret >= 0) {
 		ret = set_state_failrec(failure_tree, start, failrec);
 		/* Set the bits in the inode's tree */
-		ret = set_extent_bits(tree, start, end, EXTENT_DAMAGED);
+		ret = set_extent_bits(tree, start, start + sectorsize - 1,
+				      EXTENT_DAMAGED);
 	} else if (ret < 0) {
 		kfree(failrec);
 		return ERR_PTR(ret);
@@ -2697,11 +2699,11 @@ static bool btrfs_io_needs_validation(struct inode *inode, struct bio *bio)
 	return false;
 }
 
-blk_status_t btrfs_submit_read_repair(struct inode *inode,
-				      struct bio *failed_bio, u32 bio_offset,
-				      struct page *page, unsigned int pgoff,
-				      u64 start, u64 end, int failed_mirror,
-				      submit_bio_hook_t *submit_bio_hook)
+int btrfs_repair_one_sector(struct inode *inode,
+			    struct bio *failed_bio, u32 bio_offset,
+			    struct page *page, unsigned int pgoff,
+			    u64 start, int failed_mirror,
+			    submit_bio_hook_t *submit_bio_hook)
 {
 	struct io_failure_record *failrec;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -2719,16 +2721,22 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
 
 	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
 
-	failrec = btrfs_get_io_failure_record(inode, start, end);
+	failrec = btrfs_get_io_failure_record(inode, start);
 	if (IS_ERR(failrec))
-		return errno_to_blk_status(PTR_ERR(failrec));
-
-	need_validation = btrfs_io_needs_validation(inode, failed_bio);
+		return PTR_ERR(failrec);
 
+	/*
+	 * We will only submit repair for one sector, thus we don't need
+	 * extra validation anymore.
+	 *
+	 * TODO: All those extra validation related code will be cleaned up
+	 * later.
+	 */
+	need_validation = false;
 	if (!btrfs_check_repairable(inode, need_validation, failrec,
 				    failed_mirror)) {
 		free_io_failure(failure_tree, tree, failrec);
-		return BLK_STS_IOERR;
+		return -EIO;
 	}
 
 	repair_bio = btrfs_io_bio_alloc(1);
@@ -2762,7 +2770,120 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
 		free_io_failure(failure_tree, tree, failrec);
 		bio_put(repair_bio);
 	}
-	return status;
+	return blk_status_to_errno(status);
+}
+
+static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+
+	ASSERT(page_offset(page) <= start &&
+	       start + len <= page_offset(page) + PAGE_SIZE);
+
+	/*
+	 * For subapge metadata case, all btrfs_page_* helpers needs page to
+	 * have page::private populated.
+	 * But we can have rare case where the last eb in the page is only
+	 * referred by the IO, and it get released immedately after it's
+	 * read and verified.
+	 *
+	 * This can detach the page private completely.
+	 * In that case, we can just skip the page status update completely,
+	 * as the page has no eb any more.
+	 */
+	if (fs_info->sectorsize < PAGE_SIZE && unlikely(!PagePrivate(page))) {
+		ASSERT(!is_data_inode(page->mapping->host));
+		return;
+	}
+	if (uptodate) {
+		btrfs_page_set_uptodate(fs_info, page, start, len);
+	} else {
+		btrfs_page_clear_uptodate(fs_info, page, start, len);
+		btrfs_page_set_error(fs_info, page, start, len);
+	}
+
+	if (fs_info->sectorsize == PAGE_SIZE)
+		unlock_page(page);
+	else if (is_data_inode(page->mapping->host))
+		/*
+		 * For subpage data, unlock the page if we're the last reader.
+		 * For subpage metadata, page lock is not utilized for read.
+		 */
+		btrfs_subpage_end_reader(fs_info, page, start, len);
+}
+
+static blk_status_t submit_read_repair(struct inode *inode,
+				      struct bio *failed_bio, u32 bio_offset,
+				      struct page *page, unsigned int pgoff,
+				      u64 start, u64 end, int failed_mirror,
+				      unsigned int error_bitmap,
+				      submit_bio_hook_t *submit_bio_hook)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	const u32 sectorsize = fs_info->sectorsize;
+	int error = 0;
+	const int nr_bits = (end + 1 - start) >> fs_info->sectorsize_bits;
+	int i;
+
+	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
+
+	/* We're here because we had some read errors or csum mismatch */
+	ASSERT(error_bitmap);
+
+	/*
+	 * We only get called on buffered IO, thus page must be mapped and bio
+	 * must not be cloned.
+	 */
+	ASSERT(page->mapping && !bio_flagged(failed_bio, BIO_CLONED));
+
+	/* Iterate through all the sectors in the range */
+	for (i = 0; i < nr_bits; i++) {
+		const unsigned int offset = i * sectorsize;
+		struct extent_state *cached = NULL;
+		bool uptodate = false;
+		int ret;
+
+		if (!(error_bitmap & (1U << i))) {
+			/*
+			 * This sector has no error, just end the page read
+			 * and unlock the range.
+			 */
+			uptodate = true;
+			goto next;
+		}
+
+		ret = btrfs_repair_one_sector(inode, failed_bio,
+				bio_offset + offset,
+				page, pgoff + offset, start + offset,
+				failed_mirror, submit_bio_hook);
+		if (!ret) {
+			/*
+			 * We have submitted the read repair, the page release
+			 * will be handled by the endio function of the
+			 * submitted repair bio.
+			 * Thus we don't need to do any thing here.
+			 */
+			continue;
+		}
+		/*
+		 * Repair failed, just record the error but still continue.
+		 * Or the remaining sectors will not be properly unlocked.
+		 */
+		if (!error)
+			error = ret;
+next:
+		end_page_read(page, uptodate, start + offset, sectorsize);
+		if (uptodate)
+			set_extent_uptodate(&BTRFS_I(inode)->io_tree,
+					start + offset,
+					start + offset + sectorsize - 1,
+					&cached, GFP_ATOMIC);
+		unlock_extent_cached_atomic(&BTRFS_I(inode)->io_tree,
+				start + offset,
+				start + offset + sectorsize - 1,
+				&cached);
+	}
+	return errno_to_blk_status(error);
 }
 
 /* lots and lots of room for performance fixes in the end_bio funcs */
@@ -2919,45 +3040,6 @@ static void begin_page_read(struct btrfs_fs_info *fs_info, struct page *page)
 	btrfs_subpage_start_reader(fs_info, page, page_offset(page), PAGE_SIZE);
 }
 
-static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
-
-	ASSERT(page_offset(page) <= start &&
-		start + len <= page_offset(page) + PAGE_SIZE);
-
-	/*
-	 * For subapge metadata case, all btrfs_page_* helpers needs page to
-	 * have page::private populate.
-	 * But we can have rare case where the last eb in the page is only
-	 * referred by the IO, and it get released immedately after it's
-	 * read and verified.
-	 *
-	 * This can detach the page private completely.
-	 * In that case, we can just skip the page status update completely,
-	 * as the page has no eb any more.
-	 */
-	if (fs_info->sectorsize < PAGE_SIZE && unlikely(!PagePrivate(page))) {
-		ASSERT(!is_data_inode(page->mapping->host));
-		return;
-	}
-	if (uptodate) {
-		btrfs_page_set_uptodate(fs_info, page, start, len);
-	} else {
-		btrfs_page_clear_uptodate(fs_info, page, start, len);
-		btrfs_page_set_error(fs_info, page, start, len);
-	}
-
-	if (fs_info->sectorsize == PAGE_SIZE)
-		unlock_page(page);
-	else if (is_data_inode(page->mapping->host))
-		/*
-		 * For subpage data, unlock the page if we're the last reader.
-		 * For subpage metadata, page lock is not utilized for read.
-		 */
-		btrfs_subpage_end_reader(fs_info, page, start, len);
-}
-
 /*
  * Find extent buffer for a givne bytenr.
  *
@@ -3001,7 +3083,6 @@ static struct extent_buffer *find_extent_buffer_readpage(
 static void end_bio_extent_readpage(struct bio *bio)
 {
 	struct bio_vec *bvec;
-	int uptodate = !bio->bi_status;
 	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
 	struct extent_io_tree *tree, *failure_tree;
 	struct processed_extent processed = { 0 };
@@ -3016,10 +3097,12 @@ static void end_bio_extent_readpage(struct bio *bio)
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
+		bool uptodate = !bio->bi_status;
 		struct page *page = bvec->bv_page;
 		struct inode *inode = page->mapping->host;
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 		const u32 sectorsize = fs_info->sectorsize;
+		unsigned int error_bitmap = (unsigned int)-1;
 		u64 start;
 		u64 end;
 		u32 len;
@@ -3054,14 +3137,16 @@ static void end_bio_extent_readpage(struct bio *bio)
 
 		mirror = io_bio->mirror_num;
 		if (likely(uptodate)) {
-			if (is_data_inode(inode))
-				ret = btrfs_verify_data_csum(io_bio,
+			if (is_data_inode(inode)) {
+				error_bitmap = btrfs_verify_data_csum(io_bio,
 						bio_offset, page, start, end);
-			else
+				ret = error_bitmap;
+			} else {
 				ret = btrfs_validate_metadata_buffer(io_bio,
 					page, start, end, mirror);
+			}
 			if (ret)
-				uptodate = 0;
+				uptodate = false;
 			else
 				clean_io_failure(BTRFS_I(inode)->root->fs_info,
 						 failure_tree, tree, start,
@@ -3073,27 +3158,19 @@ static void end_bio_extent_readpage(struct bio *bio)
 			goto readpage_ok;
 
 		if (is_data_inode(inode)) {
-
 			/*
-			 * The generic bio_readpage_error handles errors the
-			 * following way: If possible, new read requests are
-			 * created and submitted and will end up in
-			 * end_bio_extent_readpage as well (if we're lucky,
-			 * not in the !uptodate case). In that case it returns
-			 * 0 and we just go on with the next page in our bio.
-			 * If it can't handle the error it will return -EIO and
-			 * we remain responsible for that page.
+			 * btrfs_submit_read_repair() will handle all the
+			 * good and bad sectors, we just continue to next
+			 * bvec.
 			 */
-			if (!btrfs_submit_read_repair(inode, bio, bio_offset,
-						page,
-						start - page_offset(page),
-						start, end, mirror,
-						btrfs_submit_data_bio)) {
-				uptodate = !bio->bi_status;
-				ASSERT(bio_offset + len > bio_offset);
-				bio_offset += len;
-				continue;
-			}
+			submit_read_repair(inode, bio, bio_offset, page,
+					   start - page_offset(page), start,
+					   end, mirror, error_bitmap,
+					   btrfs_submit_data_bio);
+
+			ASSERT(bio_offset + len > bio_offset);
+			bio_offset += len;
+			continue;
 		} else {
 			struct extent_buffer *eb;
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 1d7bc27719da..c49ce96c8b5d 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -308,11 +308,11 @@ struct io_failure_record {
 };
 
 
-blk_status_t btrfs_submit_read_repair(struct inode *inode,
-				      struct bio *failed_bio, u32 bio_offset,
-				      struct page *page, unsigned int pgoff,
-				      u64 start, u64 end, int failed_mirror,
-				      submit_bio_hook_t *submit_bio_hook);
+int btrfs_repair_one_sector(struct inode *inode,
+			    struct bio *failed_bio, u32 bio_offset,
+			    struct page *page, unsigned int pgoff,
+			    u64 start, int failed_mirror,
+			    submit_bio_hook_t *submit_bio_hook);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 bool find_lock_delalloc_range(struct inode *inode,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1c019b1dc114..6e118b855239 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7938,19 +7938,18 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 						 btrfs_ino(BTRFS_I(inode)),
 						 pgoff);
 			} else {
-				blk_status_t status;
+				int ret;
 
 				ASSERT((start - io_bio->logical) < UINT_MAX);
-				status = btrfs_submit_read_repair(inode,
+				ret = btrfs_repair_one_sector(inode,
 							&io_bio->bio,
 							start - io_bio->logical,
 							bvec.bv_page, pgoff,
 							start,
-							start + sectorsize - 1,
 							io_bio->mirror_num,
 							submit_dio_repair_bio);
-				if (status)
-					err = status;
+				if (ret)
+					err = errno_to_blk_status(ret);
 			}
 			start += sectorsize;
 			ASSERT(bio_offset + sectorsize > bio_offset);
-- 
2.31.1

