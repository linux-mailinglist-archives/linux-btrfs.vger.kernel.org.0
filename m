Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762BE36E662
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 09:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbhD2H5J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 03:57:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:49280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239347AbhD2H5I (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 03:57:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619682981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fo2ziI29M4jRgtz+ARSr9xQm5sFCZAbLs1uxj0j2NM0=;
        b=rihp3eo2exrygSCzv7z6ZcJ3jjICfe1eaPm/3pGZUPmZiktnflzqD2mdK+3cVsJgLA7OXY
        2JVRJCfQP9fD9+ISe35hEzQ085IdDhaVBG8XQBoCljpDK+Hp3qfHJsEpLkfcPY+i5JcZNi
        a320NDzJ99buM+SX9+fHHjrQ2U25YF8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B0474AF65
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Apr 2021 07:56:21 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: make read time repair to be in sectorsize unit
Date:   Thu, 29 Apr 2021 15:56:17 +0800
Message-Id: <20210429075617.213770-1-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs_submit_read_repair() will try to repair the read range
from the bvec.

It works fine for regular sectorsize case, as each bvec covers just one
sector, thus we can do per-sector repair without any problem.

But for subpage case, it can be complex, as one bvec can covers several
sectors.

Previously we hack btrfs_io_needs_validation() for subpage so that we
can submit the whole bvec range for subpage.
This behavior reduces the repair granularity, and make subpage unable to
repair the following file layout:
                0       4K      8K
  Mirror 1      |xxxxxxx|       |
  Mirror 2      |       |xxxxxxx|

As for subpage case we submit one bvec which covers 2 sectors, if any
csum mismatch happens, the whole bvec is considered corrupted, and
above case will be considered both copies are corrupted.

This patch will fix this problem by only submitting the repair for the
corrupted sector(s).

This patch will:
- Introduce repair_one_sector()
  The main code submitting repair, which is more or less the same as old
  btrfs_submit_read_repair().
  But this time, it only repair one sector.

- Make btrfs_verify_data_csum() to return an error bitmap
  So that new btrfs_submit_read_repair() can know exactly which
  sector(s) needs repair.

- Make btrfs_submit_read_repair() to handle sectors differently
  For sectors without csum error, just release them like what we did
  in end_bio_extent_readpage().
  Although in this context we don't have process_extent structure, thus
  we have to do extent tree operations sector by sector.
  This is slower, but since it's only in csum mismatch path, it should
  be fine.

  For sectors with csum error, we submit repair for each sector.

- Remove btrfs_io_needs_validation() and its callers
  In end_bio_extent_readpage(), we already have an ASSERT() to make sure
  all bio passed are not cloned, thus that "bio_flagged(bio, BIO_CLONED)"
  branch never gets executed.

  Then for bvec check, since we're only going to submit repair for each
  sector, then it will always return false anyway.

  Thus we're safe to remove this function and its callers.

With this modification, both regular sectorsize and subpage can handle
repair without problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Although this patch is more suitable for subpage patchset, this patch
works fine for both sectorsize cases.

Furthermore, considering how many code is modified, I'd prefer this
patch get reviewed out of the subpage patchset.
---
 fs/btrfs/extent_io.c | 229 +++++++++++++++++++------------------------
 fs/btrfs/extent_io.h |   1 +
 fs/btrfs/inode.c     |  14 ++-
 3 files changed, 115 insertions(+), 129 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 14ab11381d49..1693e62d9f5b 100644
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
@@ -2503,6 +2503,7 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
 	int ret;
+	const u32 sectorsize = fs_info->sectorsize;
 	u64 logical;
 
 	failrec = get_state_failrec(failure_tree, start);
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
@@ -2578,7 +2580,7 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	return failrec;
 }
 
-static bool btrfs_check_repairable(struct inode *inode, bool needs_validation,
+static bool btrfs_check_repairable(struct inode *inode,
 				   struct io_failure_record *failrec,
 				   int failed_mirror)
 {
@@ -2602,35 +2604,20 @@ static bool btrfs_check_repairable(struct inode *inode, bool needs_validation,
 	 * there are two premises:
 	 *	a) deliver good data to the caller
 	 *	b) correct the bad sectors on disk
+	 *
+	 * we're ready to fulfill a) and b) alongside. get a good copy
+	 * of the failed sector and if we succeed, we have setup
+	 * everything for repair_io_failure to do the rest for us.
 	 */
-	if (needs_validation) {
-		/*
-		 * to fulfill b), we need to know the exact failing sectors, as
-		 * we don't want to rewrite any more than the failed ones. thus,
-		 * we need separate read requests for the failed bio
-		 *
-		 * if the following BUG_ON triggers, our validation request got
-		 * merged. we need separate requests for our algorithm to work.
-		 */
-		BUG_ON(failrec->in_validation);
-		failrec->in_validation = 1;
-		failrec->this_mirror = failed_mirror;
-	} else {
-		/*
-		 * we're ready to fulfill a) and b) alongside. get a good copy
-		 * of the failed sector and if we succeed, we have setup
-		 * everything for repair_io_failure to do the rest for us.
-		 */
-		if (failrec->in_validation) {
-			BUG_ON(failrec->this_mirror != failed_mirror);
-			failrec->in_validation = 0;
-			failrec->this_mirror = 0;
-		}
-		failrec->failed_mirror = failed_mirror;
-		failrec->this_mirror++;
-		if (failrec->this_mirror == failed_mirror)
-			failrec->this_mirror++;
+	if (failrec->in_validation) {
+		BUG_ON(failrec->this_mirror != failed_mirror);
+		failrec->in_validation = 0;
+		failrec->this_mirror = 0;
 	}
+	failrec->failed_mirror = failed_mirror;
+	failrec->this_mirror++;
+	if (failrec->this_mirror == failed_mirror)
+		failrec->this_mirror++;
 
 	if (failrec->this_mirror > num_copies) {
 		btrfs_debug(fs_info,
@@ -2642,66 +2629,35 @@ static bool btrfs_check_repairable(struct inode *inode, bool needs_validation,
 	return true;
 }
 
-static bool btrfs_io_needs_validation(struct inode *inode, struct bio *bio)
+static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 {
-	u64 len = 0;
-	const u32 blocksize = inode->i_sb->s_blocksize;
+	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
 
-	/*
-	 * If bi_status is BLK_STS_OK, then this was a checksum error, not an
-	 * I/O error. In this case, we already know exactly which sector was
-	 * bad, so we don't need to validate.
-	 */
-	if (bio->bi_status == BLK_STS_OK)
-		return false;
+	ASSERT(page_offset(page) <= start &&
+		start + len <= page_offset(page) + PAGE_SIZE);
 
-	/*
-	 * For subpage case, read bio are always submitted as multiple-sector
-	 * bio if the range is in the same page.
-	 * For now, let's just skip the validation, and do page sized repair.
-	 *
-	 * This reduce the granularity for repair, meaning if we have two
-	 * copies with different csum mismatch at different location, we're
-	 * unable to repair in subpage case.
-	 *
-	 * TODO: Make validation code to be fully subpage compatible
-	 */
-	if (blocksize < PAGE_SIZE)
-		return false;
-	/*
-	 * We need to validate each sector individually if the failed I/O was
-	 * for multiple sectors.
-	 *
-	 * There are a few possible bios that can end up here:
-	 * 1. A buffered read bio, which is not cloned.
-	 * 2. A direct I/O read bio, which is cloned.
-	 * 3. A (buffered or direct) repair bio, which is not cloned.
-	 *
-	 * For cloned bios (case 2), we can get the size from
-	 * btrfs_io_bio->iter; for non-cloned bios (cases 1 and 3), we can get
-	 * it from the bvecs.
-	 */
-	if (bio_flagged(bio, BIO_CLONED)) {
-		if (btrfs_io_bio(bio)->iter.bi_size > blocksize)
-			return true;
+	if (uptodate) {
+		btrfs_page_set_uptodate(fs_info, page, start, len);
 	} else {
-		struct bio_vec *bvec;
-		int i;
-
-		bio_for_each_bvec_all(bvec, bio, i) {
-			len += bvec->bv_len;
-			if (len > blocksize)
-				return true;
-		}
+		btrfs_page_clear_uptodate(fs_info, page, start, len);
+		btrfs_page_set_error(fs_info, page, start, len);
 	}
-	return false;
+
+	if (fs_info->sectorsize == PAGE_SIZE)
+		unlock_page(page);
+	else if (is_data_inode(page->mapping->host))
+		/*
+		 * For subpage data, unlock the page if we're the last reader.
+		 * For subpage metadata, page lock is not utilized for read.
+		 */
+		btrfs_subpage_end_reader(fs_info, page, start, len);
 }
 
-blk_status_t btrfs_submit_read_repair(struct inode *inode,
-				      struct bio *failed_bio, u32 bio_offset,
-				      struct page *page, unsigned int pgoff,
-				      u64 start, u64 end, int failed_mirror,
-				      submit_bio_hook_t *submit_bio_hook)
+static int repair_one_sector(struct inode *inode,
+			     struct bio *failed_bio, u32 bio_offset,
+			     struct page *page, unsigned int pgoff,
+			     u64 start, int failed_mirror,
+			     submit_bio_hook_t *submit_bio_hook)
 {
 	struct io_failure_record *failrec;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -2709,33 +2665,23 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
 	struct btrfs_io_bio *failed_io_bio = btrfs_io_bio(failed_bio);
 	const int icsum = bio_offset >> fs_info->sectorsize_bits;
-	bool need_validation;
 	struct bio *repair_bio;
 	struct btrfs_io_bio *repair_io_bio;
 	blk_status_t status;
 
-	btrfs_debug(fs_info,
-		   "repair read error: read error at %llu", start);
-
-	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
-
-	failrec = btrfs_get_io_failure_record(inode, start, end);
+	failrec = btrfs_get_io_failure_record(inode, start);
 	if (IS_ERR(failrec))
-		return errno_to_blk_status(PTR_ERR(failrec));
-
-	need_validation = btrfs_io_needs_validation(inode, failed_bio);
+		return PTR_ERR(failrec);
 
-	if (!btrfs_check_repairable(inode, need_validation, failrec,
+	if (!btrfs_check_repairable(inode, failrec,
 				    failed_mirror)) {
 		free_io_failure(failure_tree, tree, failrec);
-		return BLK_STS_IOERR;
+		return -EIO;
 	}
 
 	repair_bio = btrfs_io_bio_alloc(1);
 	repair_io_bio = btrfs_io_bio(repair_bio);
 	repair_bio->bi_opf = REQ_OP_READ;
-	if (need_validation)
-		repair_bio->bi_opf |= REQ_FAILFAST_DEV;
 	repair_bio->bi_end_io = failed_bio->bi_end_io;
 	repair_bio->bi_iter.bi_sector = failrec->logical >> 9;
 	repair_bio->bi_private = failed_bio->bi_private;
@@ -2762,7 +2708,58 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
 		free_io_failure(failure_tree, tree, failrec);
 		bio_put(repair_bio);
 	}
-	return status;
+	return blk_status_to_errno(status);
+}
+
+blk_status_t btrfs_submit_read_repair(struct inode *inode,
+				      struct bio *failed_bio, u32 bio_offset,
+				      struct page *page,
+				      unsigned int pgoff,
+				      u64 start, u64 end, int failed_mirror,
+				      int error_bitmap,
+				      submit_bio_hook_t *submit_bio_hook)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	const u32 sectorsize = fs_info->sectorsize;
+	int nr_bits = (end + 1 - start) / sectorsize;
+	int i;
+
+	btrfs_debug(fs_info,
+		   "repair read error: read error at %llu", start);
+
+	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
+
+	ASSERT(error_bitmap);
+	for (i = 0; i < nr_bits; i++) {
+		int ret;
+		int offset = i * fs_info->sectorsize;
+		/*
+		 * No error, end the page read just like what we did in
+		 * readpage_ok tag of end_bio_extent_readpage()
+		 */
+		if (!(error_bitmap & (1 << i))) {
+			struct extent_state *cached = NULL;
+
+			end_page_read(page, 1, start + offset, sectorsize);
+			set_extent_uptodate(&BTRFS_I(inode)->io_tree,
+					start + offset,
+					start + offset + sectorsize - 1,
+					&cached, GFP_ATOMIC);
+			unlock_extent_cached_atomic(&BTRFS_I(inode)->io_tree,
+					start + offset,
+					start + offset + sectorsize - 1,
+					&cached);
+
+			continue;
+		}
+
+		ret = repair_one_sector(inode, failed_bio, bio_offset + offset,
+				page, pgoff + offset, start + offset,
+				failed_mirror, submit_bio_hook);
+		if (ret < 0)
+			return errno_to_blk_status(ret);
+	}
+	return BLK_STS_OK;
 }
 
 /* lots and lots of room for performance fixes in the end_bio funcs */
@@ -2919,30 +2916,6 @@ static void begin_page_read(struct btrfs_fs_info *fs_info, struct page *page)
 	btrfs_subpage_start_reader(fs_info, page, page_offset(page), PAGE_SIZE);
 }
 
-static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
-
-	ASSERT(page_offset(page) <= start &&
-		start + len <= page_offset(page) + PAGE_SIZE);
-
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
@@ -3005,6 +2978,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 		struct inode *inode = page->mapping->host;
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 		const u32 sectorsize = fs_info->sectorsize;
+		int error_bitmap;
 		u64 start;
 		u64 end;
 		u32 len;
@@ -3039,12 +3013,14 @@ static void end_bio_extent_readpage(struct bio *bio)
 
 		mirror = io_bio->mirror_num;
 		if (likely(uptodate)) {
-			if (is_data_inode(inode))
+			if (is_data_inode(inode)) {
 				ret = btrfs_verify_data_csum(io_bio,
 						bio_offset, page, start, end);
-			else
+				error_bitmap = ret;
+			} else {
 				ret = btrfs_validate_metadata_buffer(io_bio,
 					page, start, end, mirror);
+			}
 			if (ret)
 				uptodate = 0;
 			else
@@ -3073,6 +3049,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 						page,
 						start - page_offset(page),
 						start, end, mirror,
+						error_bitmap,
 						btrfs_submit_data_bio)) {
 				uptodate = !bio->bi_status;
 				ASSERT(bio_offset + len > bio_offset);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 1d7bc27719da..9b78a1d9fcc7 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -312,6 +312,7 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
 				      struct bio *failed_bio, u32 bio_offset,
 				      struct page *page, unsigned int pgoff,
 				      u64 start, u64 end, int failed_mirror,
+				      int error_bitmap,
 				      submit_bio_hook_t *submit_bio_hook);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 294d8d98280d..19dc4afe40e6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3135,6 +3135,8 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
  * @bio_offset:	offset to the beginning of the bio (in bytes)
  * @start:	file offset of the range start
  * @end:	file offset of the range end (inclusive)
+ *
+ * Return the an error bitmap indicating where the error is.
  */
 int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
 			   struct page *page, u64 start, u64 end)
@@ -3144,6 +3146,7 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	const u32 sectorsize = root->fs_info->sectorsize;
 	u32 pg_off;
+	int result = 0;
 
 	if (PageChecked(page)) {
 		ClearPageChecked(page);
@@ -3171,10 +3174,14 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
 
 		ret = check_data_csum(inode, io_bio, bio_offset, page, pg_off,
 				      page_offset(page) + pg_off);
-		if (ret < 0)
-			return -EIO;
+		if (ret < 0) {
+			int nr_bit = (pg_off - offset_in_page(start)) /
+					sectorsize;
+
+			result |= (1 << nr_bit);
+		}
 	}
-	return 0;
+	return result;
 }
 
 /*
@@ -7935,6 +7942,7 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 							start,
 							start + sectorsize - 1,
 							io_bio->mirror_num,
+							1,
 							submit_dio_repair_bio);
 				if (status)
 					err = status;
-- 
2.31.1

