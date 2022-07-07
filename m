Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60A95699EA
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 07:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbiGGFdx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 01:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbiGGFdw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 01:33:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE672E9FF
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 22:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pmQNLlPvaDoOfmOGblzksQld7w56dSqFspOa6+UNMzY=; b=1ODVyJhietLghFCn5+X176UoC3
        TQ7BhcxRAod6vBy+E+XGZUhwNEr5pfepwSG55T7UVZykCQFmLkUCN0vpO95FJStqejILhbN/XZbZI
        /yO0SHsbYKVefcgiVYg+qh643MBRHxdClmTfvx/18ztoMvGJooCU+Ay03sLIIZxu/uAidTCTnIDfN
        1uar7ArO9vyrINO8iCmMBJKgFfy5NWh/A4olE7VfdDJnb1aWSsk80r8uD6lxuj/7XSIItbteXBjmB
        q3WUaeiRxgnDvGNaXfucSisyt36jKZ59uHBLmQ9scBo2F6bFnuRMLoECjMRI8feJrGye7xBi8ZE2N
        /1XF00IA==;
Received: from [2001:4bb8:189:3c4a:8caf:7f2b:dda6:253] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9K96-00DleH-B2; Thu, 07 Jul 2022 05:33:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/6] btrfs: fix repair of compressed extents
Date:   Thu,  7 Jul 2022 07:33:30 +0200
Message-Id: <20220707053331.211259-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220707053331.211259-1-hch@lst.de>
References: <20220707053331.211259-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently the checksum of compressed extents is verified based on the
compressed data and the lower btrfs_bio, but the actual repair process
is driven by end_bio_extent_readpage on the upper btrfs_bio for the
decompressed data.

This has a bunch of issues, including not being able to properly
communicate the failed mirror up in case that the I/O submission got
preempted, a general loss of if an error was an I/O error or a checksum
verification failure, but most importantly that this design causes
btrfs_clean_io_failure to eventually write back the uncompressed good
data onto the disk sectors that are supposed to contain compressed data.

Fix this by moving the repair to the lower btrfs_bio.  To do so, a fair
amount of code has to be reshuffled:

 a) the lower btrfs_bio now needs a valid csum pointer.  The easiest way
    to archive that is to pass NULL btrfs_lookup_bio_sums and just use
    the btrfs_bio management of csums.  For a compressed_bio that is
    split into multiple btrfs_bios this mean additional memory
    allocations, but the code becomes a lot more regular.
 b) checksum verifiaction now runs diretly on the lower btrfs_bio instead
    of the compressed_bio.  This actually nicely simplifies the end I/O
    processing.
 c) btrfs_repair_one_sector can't just look up the logical address for
    the file offset any more, as there is no coresponding relative
    offsets that apply to the file offset and the logic address for
    compressed extents.  Instead require that the saved bvec_iter in the
    btrfs_bio is filled out for all read bios and use that, which again
    removes a fair amount of code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c | 171 ++++++++++++++---------------------------
 fs/btrfs/compression.h |   7 --
 fs/btrfs/ctree.h       |   2 +
 fs/btrfs/extent_io.c   |  46 +++--------
 fs/btrfs/extent_io.h   |   1 -
 fs/btrfs/inode.c       |   7 ++
 6 files changed, 77 insertions(+), 157 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index e756da640fd7b..c8b14a5bd89be 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -136,66 +136,14 @@ static int compression_decompress(int type, struct list_head *ws,
 
 static int btrfs_decompress_bio(struct compressed_bio *cb);
 
-static inline int compressed_bio_size(struct btrfs_fs_info *fs_info,
-				      unsigned long disk_size)
-{
-	return sizeof(struct compressed_bio) +
-		(DIV_ROUND_UP(disk_size, fs_info->sectorsize)) * fs_info->csum_size;
-}
-
-static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
-				 u64 disk_start)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	const u32 csum_size = fs_info->csum_size;
-	const u32 sectorsize = fs_info->sectorsize;
-	struct page *page;
-	unsigned int i;
-	u8 csum[BTRFS_CSUM_SIZE];
-	struct compressed_bio *cb = bio->bi_private;
-	u8 *cb_sum = cb->sums;
-
-	if ((inode->flags & BTRFS_INODE_NODATASUM) ||
-	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state))
-		return 0;
-
-	for (i = 0; i < cb->nr_pages; i++) {
-		u32 pg_offset;
-		u32 bytes_left = PAGE_SIZE;
-		page = cb->compressed_pages[i];
-
-		/* Determine the remaining bytes inside the page first */
-		if (i == cb->nr_pages - 1)
-			bytes_left = cb->compressed_len - i * PAGE_SIZE;
-
-		/* Hash through the page sector by sector */
-		for (pg_offset = 0; pg_offset < bytes_left;
-		     pg_offset += sectorsize) {
-			int ret;
-
-			ret = btrfs_check_sector_csum(fs_info, page, pg_offset,
-						      csum, cb_sum);
-			if (ret) {
-				btrfs_print_data_csum_error(inode, disk_start,
-						csum, cb_sum, cb->mirror_num);
-				if (btrfs_bio(bio)->device)
-					btrfs_dev_stat_inc_and_print(
-						btrfs_bio(bio)->device,
-						BTRFS_DEV_STAT_CORRUPTION_ERRS);
-				return -EIO;
-			}
-			cb_sum += csum_size;
-			disk_start += sectorsize;
-		}
-	}
-	return 0;
-}
-
 static void finish_compressed_bio_read(struct compressed_bio *cb)
 {
 	unsigned int index;
 	struct page *page;
 
+	if (cb->status == BLK_STS_OK)
+		cb->status = errno_to_blk_status(btrfs_decompress_bio(cb));
+
 	/* Release the compressed pages */
 	for (index = 0; index < cb->nr_pages; index++) {
 		page = cb->compressed_pages[index];
@@ -233,59 +181,54 @@ static void finish_compressed_bio_read(struct compressed_bio *cb)
 	kfree(cb);
 }
 
-/* when we finish reading compressed pages from the disk, we
- * decompress them and then run the bio end_io routines on the
- * decompressed pages (in the inode address space).
- *
- * This allows the checksumming and other IO error handling routines
- * to work normally
- *
- * The compressed pages are freed here, and it must be run
- * in process context
+/*
+ * Verify the checksums and kick off repair if needed on the uncompressed data
+ * before decompressing it into the original bio and freeing the uncompressed
+ * pages.
  */
 static void end_compressed_bio_read(struct bio *bio)
 {
 	struct compressed_bio *cb = bio->bi_private;
-	struct inode *inode;
-	unsigned int mirror = btrfs_bio(bio)->mirror_num;
-	int ret = 0;
-
-	if (bio->bi_status)
-		cb->status = bio->bi_status;
-
-	if (!refcount_dec_and_test(&cb->pending_ios))
-		goto out;
-
-	/*
-	 * Record the correct mirror_num in cb->orig_bio so that
-	 * read-repair can work properly.
-	 */
-	btrfs_bio(cb->orig_bio)->mirror_num = mirror;
-	cb->mirror_num = mirror;
-
-	/*
-	 * Some IO in this cb have failed, just skip checksum as there
-	 * is no way it could be correct.
-	 */
-	if (cb->status != BLK_STS_OK)
-		goto csum_failed;
+	struct inode *inode = cb->inode;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_inode *bi = BTRFS_I(inode);
+	bool csum = !(bi->flags & BTRFS_INODE_NODATASUM) &&
+		    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
+	blk_status_t status = bio->bi_status;
+	struct btrfs_bio *bbio = btrfs_bio(bio);
+	struct bvec_iter iter;
+	struct bio_vec bv;
+	u32 offset;
+
+	btrfs_bio_for_each_sector(fs_info, bv, bbio, iter, offset) {
+		u64 start = bbio->file_offset + offset;
+
+		if (!status &&
+		    (!csum || !check_data_csum(inode, bbio, offset, bv.bv_page,
+					       bv.bv_offset))) {
+			clean_io_failure(fs_info, &bi->io_failure_tree,
+					 &bi->io_tree, start, bv.bv_page,
+					 btrfs_ino(bi), bv.bv_offset);
+		} else {
+			int ret;
 
-	inode = cb->inode;
-	ret = check_compressed_csum(BTRFS_I(inode), bio,
-				    bio->bi_iter.bi_sector << 9);
-	if (ret)
-		goto csum_failed;
+			refcount_inc(&cb->pending_ios);
+			ret = btrfs_repair_one_sector(inode, bbio, offset,
+					bv.bv_page, bv.bv_offset,
+					btrfs_submit_data_read_bio);
+			if (ret) {
+				refcount_dec(&cb->pending_ios);
+				status = errno_to_blk_status(ret);
+			}
+		}
+	}
 
-	/* ok, we're the last bio for this extent, lets start
-	 * the decompression.
-	 */
-	ret = btrfs_decompress_bio(cb);
+	if (status)
+		cb->status = status;
 
-csum_failed:
-	if (ret)
-		cb->status = errno_to_blk_status(ret);
-	finish_compressed_bio_read(cb);
-out:
+	if (refcount_dec_and_test(&cb->pending_ios))
+		finish_compressed_bio_read(cb);
+	btrfs_bio_free_csum(bbio);
 	bio_put(bio);
 }
 
@@ -478,7 +421,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 
 	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
 	       IS_ALIGNED(len, fs_info->sectorsize));
-	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
+	cb = kmalloc(sizeof(struct compressed_bio), GFP_NOFS);
 	if (!cb)
 		return BLK_STS_RESOURCE;
 	refcount_set(&cb->pending_ios, 1);
@@ -486,7 +429,6 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	cb->inode = &inode->vfs_inode;
 	cb->start = start;
 	cb->len = len;
-	cb->mirror_num = 0;
 	cb->compressed_pages = compressed_pages;
 	cb->compressed_len = compressed_len;
 	cb->writeback = writeback;
@@ -755,7 +697,6 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	blk_status_t ret;
 	int ret2;
 	int i;
-	u8 *sums;
 
 	em_tree = &BTRFS_I(inode)->extent_tree;
 
@@ -773,7 +714,7 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 
 	ASSERT(em->compress_type != BTRFS_COMPRESS_NONE);
 	compressed_len = em->block_len;
-	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
+	cb = kmalloc(sizeof(struct compressed_bio), GFP_NOFS);
 	if (!cb) {
 		ret = BLK_STS_RESOURCE;
 		goto out;
@@ -782,8 +723,6 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	refcount_set(&cb->pending_ios, 1);
 	cb->status = BLK_STS_OK;
 	cb->inode = inode;
-	cb->mirror_num = mirror_num;
-	sums = cb->sums;
 
 	cb->start = em->orig_start;
 	em_len = em->len;
@@ -867,19 +806,25 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			submit = true;
 
 		if (submit) {
-			unsigned int nr_sectors;
+			/* Save the original iter for read repair */
+			if (bio_op(comp_bio) == REQ_OP_READ)
+				btrfs_bio(comp_bio)->iter = comp_bio->bi_iter;
+
+			/*
+			 * Just stash the initial offset of this chunk, as there
+			 * is no direct correlation between compressed pages and
+			 * the original file offset.  The field is only used for
+			 * priting error messages anyway.
+			 */
+			btrfs_bio(comp_bio)->file_offset = file_offset;
 
-			ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
+			ret = btrfs_lookup_bio_sums(inode, comp_bio, NULL);
 			if (ret) {
 				comp_bio->bi_status = ret;
 				bio_endio(comp_bio);
 				break;
 			}
 
-			nr_sectors = DIV_ROUND_UP(comp_bio->bi_iter.bi_size,
-						  fs_info->sectorsize);
-			sums += fs_info->csum_size * nr_sectors;
-
 			ASSERT(comp_bio->bi_iter.bi_size);
 			btrfs_submit_bio(fs_info, comp_bio, mirror_num);
 			comp_bio = NULL;
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 0e4cbf04fd866..e9ef24034cad0 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -59,19 +59,12 @@ struct compressed_bio {
 
 	/* IO errors */
 	blk_status_t status;
-	int mirror_num;
 
 	union {
 		/* For reads, this is the bio we are copying the data into */
 		struct bio *orig_bio;
 		struct work_struct write_end_work;
 	};
-
-	/*
-	 * the start of a variable length array of checksums only
-	 * used by reads
-	 */
-	u8 sums[];
 };
 
 static inline unsigned int btrfs_compress_type(unsigned int type_level)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 164f54e6aa447..12f59e35755fa 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3290,6 +3290,8 @@ void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
 			int mirror_num, enum btrfs_compression_type compress_type);
 int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
+int check_data_csum(struct inode *inode, struct btrfs_bio *bbio, u32 bio_offset,
+		    struct page *page, u32 pgoff);
 unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
 				    u32 bio_offset, struct page *page,
 				    u64 start, u64 end);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ec7bdb3fa0921..587d2ba20b53b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2543,13 +2543,10 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u64 start = bbio->file_offset + bio_offset;
 	struct io_failure_record *failrec;
-	struct extent_map *em;
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
-	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
 	const u32 sectorsize = fs_info->sectorsize;
 	int ret;
-	u64 logical;
 
 	failrec = get_state_failrec(failure_tree, start);
 	if (!IS_ERR(failrec)) {
@@ -2573,41 +2570,14 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	failrec->start = start;
 	failrec->len = sectorsize;
 	failrec->failed_mirror = failrec->this_mirror = bbio->mirror_num;
-	failrec->compress_type = BTRFS_COMPRESS_NONE;
-
-	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, start, failrec->len);
-	if (!em) {
-		read_unlock(&em_tree->lock);
-		kfree(failrec);
-		return ERR_PTR(-EIO);
-	}
-
-	if (em->start > start || em->start + em->len <= start) {
-		free_extent_map(em);
-		em = NULL;
-	}
-	read_unlock(&em_tree->lock);
-	if (!em) {
-		kfree(failrec);
-		return ERR_PTR(-EIO);
-	}
-
-	logical = start - em->start;
-	logical = em->block_start + logical;
-	if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
-		logical = em->block_start;
-		failrec->compress_type = em->compress_type;
-	}
+	failrec->logical = (bbio->iter.bi_sector << SECTOR_SHIFT) + bio_offset;
 
 	btrfs_debug(fs_info,
-		    "Get IO Failure Record: (new) logical=%llu, start=%llu, len=%llu",
-		    logical, start, failrec->len);
-
-	failrec->logical = logical;
-	free_extent_map(em);
+		    "Get IO Failure Record: (new) logical=%llu, start=%llu",
+		    failrec->logical, start);
 
-	failrec->num_copies = btrfs_num_copies(fs_info, logical, sectorsize);
+	failrec->num_copies = btrfs_num_copies(fs_info, failrec->logical,
+					       sectorsize);
 	if (failrec->num_copies == 1) {
 		/*
 		 * we only have a single copy of the data, so don't bother with
@@ -2709,7 +2679,7 @@ int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
 	 * will be handled by the endio on the repair_bio, so we can't return an
 	 * error here.
 	 */
-	submit_bio_hook(inode, repair_bio, failrec->this_mirror, failrec->compress_type);
+	submit_bio_hook(inode, repair_bio, failrec->this_mirror, 0);
 	return BLK_STS_OK;
 }
 
@@ -3115,6 +3085,10 @@ static void end_bio_extent_readpage(struct bio *bio)
 			 * Only try to repair bios that actually made it to a
 			 * device.  If the bio failed to be submitted mirror
 			 * is 0 and we need to fail it without retrying.
+			 *
+			 * This also includes the high level bios for compressed
+			 * extents - these never make it to a device and repair
+			 * is already handled on the lower compressed bio.
 			 */
 			if (mirror > 0)
 				repair = true;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index a78051c7627c4..9dec34c009e91 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -261,7 +261,6 @@ struct io_failure_record {
 	u64 start;
 	u64 len;
 	u64 logical;
-	enum btrfs_compression_type compress_type;
 	int this_mirror;
 	int failed_mirror;
 	int num_copies;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 429428fde4a88..eea351216db33 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2707,6 +2707,9 @@ void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
 		return;
 	}
 
+	/* Save the original iter for read repair */
+	btrfs_bio(bio)->iter = bio->bi_iter;
+
 	/*
 	 * Lookup bio sums does extra checks around whether we need to csum or
 	 * not, which is why we ignore skip_sum here.
@@ -8000,6 +8003,10 @@ static void btrfs_submit_dio_bio(struct bio *bio, struct inode *inode,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_dio_private *dip = bio->bi_private;
 	blk_status_t ret;
+		
+	/* Save the original iter for read repair */
+	if (btrfs_op(bio) == BTRFS_MAP_READ)
+		btrfs_bio(bio)->iter = bio->bi_iter;
 
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
 		goto map;
-- 
2.30.2

