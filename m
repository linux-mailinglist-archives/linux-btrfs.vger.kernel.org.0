Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31610371052
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 May 2021 03:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhECBaZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 May 2021 21:30:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:50940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbhECBaZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 2 May 2021 21:30:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620005372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2pjT4olFghBAby/KoqS+lx81TR5z4Br8+3gf4OsL50=;
        b=bFMt6kVnkPe6yx/dhVkEFEgV7m/FCf30C9Taw+dr+WJ+WUF1ApnnOpYYFqPrn7wz9Wl28i
        55qH9g5cqEi4EtbV1ZfQkhRljpXFj3Mbew0h9jXoWAweswWoLZoOJgl665yxXbkX85SRZL
        jICCstyyGS9SSHEOLMOnyj4idSfVx7Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 66BC6B05E
        for <linux-btrfs@vger.kernel.org>; Mon,  3 May 2021 01:29:32 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/4] btrfs: submit read time repair only for each corrupted sector
Date:   Mon,  3 May 2021 09:29:23 +0800
Message-Id: <20210503012924.77865-4-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503012924.77865-1-wqu@suse.com>
References: <20210503012924.77865-1-wqu@suse.com>
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
  But this time, it only repair one sector.

- Make btrfs_submit_read_repair() to handle sectors differently
  For sectors without csum error, just release them like what we did
  in end_bio_extent_readpage().
  Although in this context we don't have process_extent structure, thus
  we have to do extent tree operations sector by sector.
  This is slower, but since it's only in csum mismatch path, it should
  be fine.

  For sectors with csum error, we submit repair for each sector.

This patch will focus on the change on the repair path, the extra
validation code is still kept as is, and will be cleaned up later.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 138 +++++++++++++++++++++++++++++++------------
 fs/btrfs/extent_io.h |   1 +
 fs/btrfs/inode.c     |   2 +-
 3 files changed, 101 insertions(+), 40 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0787fae5f7f1..54e49c561783 100644
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
@@ -2682,11 +2684,11 @@ static bool btrfs_io_needs_validation(struct inode *inode, struct bio *bio)
 	return false;
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
@@ -2704,12 +2706,18 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
 
 	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
 
-	failrec = btrfs_get_io_failure_record(inode, start, end);
+	failrec = btrfs_get_io_failure_record(inode, start);
 	if (IS_ERR(failrec))
 		return errno_to_blk_status(PTR_ERR(failrec));
 
-	need_validation = btrfs_io_needs_validation(inode, failed_bio);
-
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
@@ -2750,6 +2758,78 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
 	return status;
 }
 
+static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+
+	ASSERT(page_offset(page) <= start &&
+		start + len <= page_offset(page) + PAGE_SIZE);
+
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
+blk_status_t btrfs_submit_read_repair(struct inode *inode,
+				      struct bio *failed_bio, u32 bio_offset,
+				      struct page *page, unsigned int pgoff,
+				      u64 start, u64 end, int failed_mirror,
+				      unsigned int error_bitmap,
+				      submit_bio_hook_t *submit_bio_hook)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	const u32 sectorsize = fs_info->sectorsize;
+	int nr_bits = (end + 1 - start) / sectorsize;
+	int i;
+
+	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
+
+	/* We're here because we had some read errors or csum mismatch */
+	ASSERT(error_bitmap);
+
+	/* Iterate through all the sectors in the range */
+	for (i = 0; i < nr_bits; i++) {
+		int ret;
+		unsigned int offset = i * sectorsize;
+
+		if (!(error_bitmap & (1 << i))) {
+			struct extent_state *cached = NULL;
+
+			/* This sector has no error, just finish the read. */
+			end_page_read(page, true, start + offset, sectorsize);
+			set_extent_uptodate(&BTRFS_I(inode)->io_tree,
+					start + offset,
+					start + offset + sectorsize - 1,
+					&cached, GFP_ATOMIC);
+			unlock_extent_cached_atomic(&BTRFS_I(inode)->io_tree,
+					start + offset,
+					start + offset + sectorsize - 1,
+					&cached);
+			continue;
+		}
+
+		/* This sector has been corrupted, repair it */
+		ret = repair_one_sector(inode, failed_bio, bio_offset + offset,
+				page, pgoff + offset, start + offset,
+				failed_mirror, submit_bio_hook);
+		if (ret < 0)
+			return errno_to_blk_status(ret);
+	}
+	return BLK_STS_OK;
+}
+
 /* lots and lots of room for performance fixes in the end_bio funcs */
 
 void end_extent_writepage(struct page *page, int err, u64 start, u64 end)
@@ -2904,30 +2984,6 @@ static void begin_page_read(struct btrfs_fs_info *fs_info, struct page *page)
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
@@ -2990,6 +3046,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 		struct inode *inode = page->mapping->host;
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 		const u32 sectorsize = fs_info->sectorsize;
+		unsigned int error_bitmap = (unsigned int)-1;
 		u64 start;
 		u64 end;
 		u32 len;
@@ -3024,12 +3081,14 @@ static void end_bio_extent_readpage(struct bio *bio)
 
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
 				uptodate = 0;
 			else
@@ -3058,6 +3117,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 						page,
 						start - page_offset(page),
 						start, end, mirror,
+						error_bitmap,
 						btrfs_submit_data_bio)) {
 				uptodate = !bio->bi_status;
 				ASSERT(bio_offset + len > bio_offset);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 1d7bc27719da..89820028c4bc 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -312,6 +312,7 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
 				      struct bio *failed_bio, u32 bio_offset,
 				      struct page *page, unsigned int pgoff,
 				      u64 start, u64 end, int failed_mirror,
+				      unsigned int error_bitmap,
 				      submit_bio_hook_t *submit_bio_hook);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e9db33afcb5d..4fc6e6766234 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7941,7 +7941,7 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 							bvec.bv_page, pgoff,
 							start,
 							start + sectorsize - 1,
-							io_bio->mirror_num,
+							io_bio->mirror_num, 1,
 							submit_dio_repair_bio);
 				if (status)
 					err = status;
-- 
2.31.1

