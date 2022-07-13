Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94825572E00
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 08:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbiGMGOW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 02:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiGMGOV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 02:14:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5943FBE0E5
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 23:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xPXvyFDD8ABJOSoVFeoJftPNQUvFQmZA/lEkyMmuf1w=; b=w0/HsyRRgbe1oQ9gqWOiO4HEAR
        gDPAYgOOhEP5CisN/QiInIksZpA7Ny0F3aIteDFl1RRmRh7s3oOOZcDmbIp0nktJ+1VpRqJJZOS0t
        hZUeti61tPQPRuyQ+L6s44/whKNc4XFoqF6GilkRL+xQB6SkYs9bwvSXFz1Cnd36kkH45PfEcBfyx
        UTTEJ5obB7S2mC04UbX7vsmbMuKEmU1sxxBJW8IaevNKvOS4NQt/lmCOSA40nlky5FKPr0vhWsaz/
        1NCG1gNVsfN+2g4HRuznqRKZpyJfVGTXX3Q9Fn++W9yY0KVbpwX95X5/Cu1EdBKtabSkFL0KbkoXK
        hSAZjOAQ==;
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBVdZ-000T5N-VQ; Wed, 13 Jul 2022 06:14:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 07/11] btrfs: give struct btrfs_bio a real end_io handler
Date:   Wed, 13 Jul 2022 08:13:55 +0200
Message-Id: <20220713061359.1980118-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713061359.1980118-1-hch@lst.de>
References: <20220713061359.1980118-1-hch@lst.de>
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

Currently btrfs_bio end I/O handling is a bit of a mess.  The bi_end_io
handler and bi_private pointer of the embedded struct bio are both used
to handle the completion of the high-level btrfs_bio and for the I/O
completion for the low-level device that the embedded bio ends up being
sent to.  To support this bi_end_io and bi_private are saved into the
btrfs_io_context structure and then restored after the bio sent to the
underlying device has completed the actual I/O.

Untangle this by adding an end I/O handler and private data to struct
btrfs_bio for the highlevel btrfs_bio based completions, and leave the
actual bio bi_end_io handler and bi_private pointer entirely to the
low-level device I/O.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/compression.c | 42 +++++++++++++------------------
 fs/btrfs/disk-io.c     | 16 ++++++------
 fs/btrfs/extent_io.c   | 35 +++++++++++++-------------
 fs/btrfs/inode.c       | 56 +++++++++++++++++++-----------------------
 fs/btrfs/volumes.c     | 30 +++++++++++-----------
 fs/btrfs/volumes.h     | 20 ++++++++++++---
 6 files changed, 96 insertions(+), 103 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index b2bc605ec73a9..ea6a391d11980 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -152,9 +152,7 @@ static void finish_compressed_bio_read(struct compressed_bio *cb)
 	}
 
 	/* Do io completion on the original bio */
-	if (cb->status != BLK_STS_OK)
-		cb->orig_bio->bi_status = cb->status;
-	bio_endio(cb->orig_bio);
+	btrfs_bio_end_io(btrfs_bio(cb->orig_bio), cb->status);
 
 	/* Finally free the cb struct */
 	kfree(cb->compressed_pages);
@@ -166,16 +164,15 @@ static void finish_compressed_bio_read(struct compressed_bio *cb)
  * before decompressing it into the original bio and freeing the uncompressed
  * pages.
  */
-static void end_compressed_bio_read(struct bio *bio)
+static void end_compressed_bio_read(struct btrfs_bio *bbio)
 {
-	struct compressed_bio *cb = bio->bi_private;
+	struct compressed_bio *cb = bbio->private;
 	struct inode *inode = cb->inode;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_inode *bi = BTRFS_I(inode);
 	bool csum = !(bi->flags & BTRFS_INODE_NODATASUM) &&
 		    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
-	blk_status_t status = bio->bi_status;
-	struct btrfs_bio *bbio = btrfs_bio(bio);
+	blk_status_t status = bbio->bio.bi_status;
 	struct bvec_iter iter;
 	struct bio_vec bv;
 	u32 offset;
@@ -209,7 +206,7 @@ static void end_compressed_bio_read(struct bio *bio)
 	if (refcount_dec_and_test(&cb->pending_ios))
 		finish_compressed_bio_read(cb);
 	btrfs_bio_free_csum(bbio);
-	bio_put(bio);
+	bio_put(&bbio->bio);
 }
 
 /*
@@ -301,20 +298,20 @@ static void btrfs_finish_compressed_write_work(struct work_struct *work)
  * This also calls the writeback end hooks for the file pages so that metadata
  * and checksums can be updated in the file.
  */
-static void end_compressed_bio_write(struct bio *bio)
+static void end_compressed_bio_write(struct btrfs_bio *bbio)
 {
-	struct compressed_bio *cb = bio->bi_private;
+	struct compressed_bio *cb = bbio->private;
 
-	if (bio->bi_status)
-		cb->status = bio->bi_status;
+	if (bbio->bio.bi_status)
+		cb->status = bbio->bio.bi_status;
 
 	if (refcount_dec_and_test(&cb->pending_ios)) {
 		struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
 
-		btrfs_record_physical_zoned(cb->inode, cb->start, bio);
+		btrfs_record_physical_zoned(cb->inode, cb->start, &bbio->bio);
 		queue_work(fs_info->compressed_write_workers, &cb->write_end_work);
 	}
-	bio_put(bio);
+	bio_put(&bbio->bio);
 }
 
 /*
@@ -335,7 +332,8 @@ static void end_compressed_bio_write(struct bio *bio)
 
 
 static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_bytenr,
-					unsigned int opf, bio_end_io_t endio_func,
+					unsigned int opf,
+					btrfs_bio_end_io_t endio_func,
 					u64 *next_stripe_start)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
@@ -344,11 +342,8 @@ static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_byte
 	struct bio *bio;
 	int ret;
 
-	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf);
-
+	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, endio_func, cb);
 	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
-	bio->bi_private = cb;
-	bio->bi_end_io = endio_func;
 
 	em = btrfs_get_chunk_map(fs_info, disk_bytenr, fs_info->sectorsize);
 	if (IS_ERR(em)) {
@@ -477,8 +472,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 			if (!skip_sum) {
 				ret = btrfs_csum_one_bio(inode, bio, start, true);
 				if (ret) {
-					bio->bi_status = ret;
-					bio_endio(bio);
+					btrfs_bio_end_io(btrfs_bio(bio), ret);
 					break;
 				}
 			}
@@ -799,8 +793,7 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 
 			ret = btrfs_lookup_bio_sums(inode, comp_bio, NULL);
 			if (ret) {
-				comp_bio->bi_status = ret;
-				bio_endio(comp_bio);
+				btrfs_bio_end_io(btrfs_bio(comp_bio), ret);
 				break;
 			}
 
@@ -826,8 +819,7 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	kfree(cb);
 out:
 	free_extent_map(em);
-	bio->bi_status = ret;
-	bio_endio(bio);
+	btrfs_bio_end_io(btrfs_bio(bio), ret);
 	return;
 }
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 717c9f6b9ba5b..d62ab276fd6b7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -728,16 +728,14 @@ static void run_one_async_start(struct btrfs_work *work)
  */
 static void run_one_async_done(struct btrfs_work *work)
 {
-	struct async_submit_bio *async;
-	struct inode *inode;
-
-	async = container_of(work, struct  async_submit_bio, work);
-	inode = async->inode;
+	struct async_submit_bio *async =
+		container_of(work, struct  async_submit_bio, work);
+	struct inode *inode = async->inode;
+	struct btrfs_bio *bbio = btrfs_bio(async->bio);
 
 	/* If an error occurred we just want to clean up the bio and move on */
 	if (async->status) {
-		async->bio->bi_status = async->status;
-		bio_endio(async->bio);
+		btrfs_bio_end_io(bbio, async->status);
 		return;
 	}
 
@@ -838,6 +836,7 @@ static bool should_async_write(struct btrfs_fs_info *fs_info,
 void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_num)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_bio *bbio = btrfs_bio(bio);
 	blk_status_t ret;
 
 	bio->bi_opf |= REQ_META;
@@ -857,8 +856,7 @@ void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_
 
 	ret = btree_csum_one_bio(bio);
 	if (ret) {
-		bio->bi_status = ret;
-		bio_endio(bio);
+		btrfs_bio_end_io(bbio, ret);
 		return;
 	}
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 667b4f439a089..36d604711fe04 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -206,7 +206,7 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 		btrfs_submit_data_read_bio(inode, bio, mirror_num,
 					   bio_ctrl->compress_type);
 
-	/* The bio is owned by the bi_end_io handler now */
+	/* The bio is owned by the end_io handler now */
 	bio_ctrl->bio = NULL;
 }
 
@@ -222,9 +222,8 @@ static void submit_write_bio(struct extent_page_data *epd, int ret)
 
 	if (ret) {
 		ASSERT(ret < 0);
-		bio->bi_status = errno_to_blk_status(ret);
-		bio_endio(bio);
-		/* The bio is owned by the bi_end_io handler now */
+		btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
+		/* The bio is owned by the end_io handler now */
 		epd->bio_ctrl.bio = NULL;
 	} else {
 		submit_one_bio(&epd->bio_ctrl);
@@ -2629,12 +2628,11 @@ int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
 		return -EIO;
 	}
 
-	repair_bio = btrfs_bio_alloc(1, REQ_OP_READ);
+	repair_bio = btrfs_bio_alloc(1, REQ_OP_READ, failed_bbio->end_io,
+				     failed_bbio->private);
 	repair_bbio = btrfs_bio(repair_bio);
 	repair_bbio->file_offset = start;
-	repair_bio->bi_end_io = failed_bio->bi_end_io;
 	repair_bio->bi_iter.bi_sector = failrec->logical >> 9;
-	repair_bio->bi_private = failed_bio->bi_private;
 
 	if (failed_bbio->csum) {
 		const u32 csum_size = fs_info->csum_size;
@@ -2801,8 +2799,9 @@ void end_extent_writepage(struct page *page, int err, u64 start, u64 end)
  * Scheduling is not allowed, so the extent state tree is expected
  * to have one and only one object corresponding to this IO.
  */
-static void end_bio_extent_writepage(struct bio *bio)
+static void end_bio_extent_writepage(struct btrfs_bio *bbio)
 {
+	struct bio *bio = &bbio->bio;
 	int error = blk_status_to_errno(bio->bi_status);
 	struct bio_vec *bvec;
 	u64 start;
@@ -2964,10 +2963,10 @@ static struct extent_buffer *find_extent_buffer_readpage(
  * Scheduling is not allowed, so the extent state tree is expected
  * to have one and only one object corresponding to this IO.
  */
-static void end_bio_extent_readpage(struct bio *bio)
+static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 {
+	struct bio *bio = &bbio->bio;
 	struct bio_vec *bvec;
-	struct btrfs_bio *bbio = btrfs_bio(bio);
 	struct extent_io_tree *tree, *failure_tree;
 	struct processed_extent processed = { 0 };
 	/*
@@ -3258,7 +3257,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 			 struct btrfs_bio_ctrl *bio_ctrl,
 			 struct writeback_control *wbc,
 			 unsigned int opf,
-			 bio_end_io_t end_io_func,
+			 btrfs_bio_end_io_t end_io_func,
 			 u64 disk_bytenr, u32 offset, u64 file_offset,
 			 enum btrfs_compression_type compress_type)
 {
@@ -3266,7 +3265,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	struct bio *bio;
 	int ret;
 
-	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf);
+	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, end_io_func, NULL);
 	/*
 	 * For compressed page range, its disk_bytenr is always @disk_bytenr
 	 * passed in, no matter if we have added any range into previous bio.
@@ -3277,7 +3276,6 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 		bio->bi_iter.bi_sector = (disk_bytenr + offset) >> SECTOR_SHIFT;
 	bio_ctrl->bio = bio;
 	bio_ctrl->compress_type = compress_type;
-	bio->bi_end_io = end_io_func;
 	ret = calc_bio_boundaries(bio_ctrl, inode, file_offset);
 	if (ret < 0)
 		goto error;
@@ -3316,8 +3314,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	return 0;
 error:
 	bio_ctrl->bio = NULL;
-	bio->bi_status = errno_to_blk_status(ret);
-	bio_endio(bio);
+	btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
 	return ret;
 }
 
@@ -3340,7 +3337,7 @@ static int submit_extent_page(unsigned int opf,
 			      struct btrfs_bio_ctrl *bio_ctrl,
 			      struct page *page, u64 disk_bytenr,
 			      size_t size, unsigned long pg_offset,
-			      bio_end_io_t end_io_func,
+			      btrfs_bio_end_io_t end_io_func,
 			      enum btrfs_compression_type compress_type,
 			      bool force_bio_submit)
 {
@@ -4337,8 +4334,9 @@ static struct extent_buffer *find_extent_buffer_nolock(
  * Unlike end_bio_extent_buffer_writepage(), we only call end_page_writeback()
  * after all extent buffers in the page has finished their writeback.
  */
-static void end_bio_subpage_eb_writepage(struct bio *bio)
+static void end_bio_subpage_eb_writepage(struct btrfs_bio *bbio)
 {
+	struct bio *bio = &bbio->bio;
 	struct btrfs_fs_info *fs_info;
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
@@ -4394,8 +4392,9 @@ static void end_bio_subpage_eb_writepage(struct bio *bio)
 	bio_put(bio);
 }
 
-static void end_bio_extent_buffer_writepage(struct bio *bio)
+static void end_bio_extent_buffer_writepage(struct btrfs_bio *bbio)
 {
+	struct bio *bio = &bbio->bio;
 	struct bio_vec *bvec;
 	struct extent_buffer *eb;
 	int done;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 18284f6105e7c..e1b6a5164d035 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2701,8 +2701,10 @@ void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio, int mirro
 	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 		ret = extract_ordered_extent(bi, bio,
 				page_offset(bio_first_bvec_all(bio)->bv_page));
-		if (ret)
-			goto out;
+		if (ret) {
+			btrfs_bio_end_io(btrfs_bio(bio), ret);
+			return;
+		}
 	}
 
 	/*
@@ -2722,16 +2724,12 @@ void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio, int mirro
 			return;
 
 		ret = btrfs_csum_one_bio(bi, bio, (u64)-1, false);
-		if (ret)
-			goto out;
+		if (ret) {
+			btrfs_bio_end_io(btrfs_bio(bio), ret);
+			return;
+		}
 	}
 	btrfs_submit_bio(fs_info, bio, mirror_num);
-	return;
-out:
-	if (ret) {
-		bio->bi_status = ret;
-		bio_endio(bio);
-	}
 }
 
 void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
@@ -2758,8 +2756,7 @@ void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
 	 */
 	ret = btrfs_lookup_bio_sums(inode, bio, NULL);
 	if (ret) {
-		bio->bi_status = ret;
-		bio_endio(bio);
+		btrfs_bio_end_io(btrfs_bio(bio), ret);
 		return;
 	}
 
@@ -7974,7 +7971,7 @@ static void submit_dio_repair_bio(struct inode *inode, struct bio *bio,
 				  int mirror_num,
 				  enum btrfs_compression_type compress_type)
 {
-	struct btrfs_dio_private *dip = bio->bi_private;
+	struct btrfs_dio_private *dip = btrfs_bio(bio)->private;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 
 	BUG_ON(bio_op(bio) == REQ_OP_WRITE);
@@ -8027,10 +8024,10 @@ static blk_status_t btrfs_submit_bio_start_direct_io(struct inode *inode,
 	return btrfs_csum_one_bio(BTRFS_I(inode), bio, dio_file_offset, false);
 }
 
-static void btrfs_end_dio_bio(struct bio *bio)
+static void btrfs_end_dio_bio(struct btrfs_bio *bbio)
 {
-	struct btrfs_dio_private *dip = bio->bi_private;
-	struct btrfs_bio *bbio = btrfs_bio(bio);
+	struct btrfs_dio_private *dip = bbio->private;
+	struct bio *bio = &bbio->bio;
 	blk_status_t err = bio->bi_status;
 
 	if (err)
@@ -8056,7 +8053,7 @@ static void btrfs_submit_dio_bio(struct bio *bio, struct inode *inode,
 				 u64 file_offset, int async_submit)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_dio_private *dip = bio->bi_private;
+	struct btrfs_dio_private *dip = btrfs_bio(bio)->private;
 	blk_status_t ret;
 
 	/* Save the original iter for read repair */
@@ -8079,8 +8076,7 @@ static void btrfs_submit_dio_bio(struct bio *bio, struct inode *inode,
 		 */
 		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, file_offset, false);
 		if (ret) {
-			bio->bi_status = ret;
-			bio_endio(bio);
+			btrfs_bio_end_io(btrfs_bio(bio), ret);
 			return;
 		}
 	} else {
@@ -8163,9 +8159,8 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 		 * This will never fail as it's passing GPF_NOFS and
 		 * the allocation is backed by btrfs_bioset.
 		 */
-		bio = btrfs_bio_clone_partial(dio_bio, clone_offset, clone_len);
-		bio->bi_private = dip;
-		bio->bi_end_io = btrfs_end_dio_bio;
+		bio = btrfs_bio_clone_partial(dio_bio, clone_offset, clone_len,
+					      btrfs_end_dio_bio, dip);
 		btrfs_bio(bio)->file_offset = file_offset;
 
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
@@ -10364,7 +10359,7 @@ struct btrfs_encoded_read_private {
 static blk_status_t submit_encoded_read_bio(struct btrfs_inode *inode,
 					    struct bio *bio, int mirror_num)
 {
-	struct btrfs_encoded_read_private *priv = bio->bi_private;
+	struct btrfs_encoded_read_private *priv = btrfs_bio(bio)->private;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	blk_status_t ret;
 
@@ -10382,7 +10377,7 @@ static blk_status_t submit_encoded_read_bio(struct btrfs_inode *inode,
 static blk_status_t btrfs_encoded_read_verify_csum(struct btrfs_bio *bbio)
 {
 	const bool uptodate = (bbio->bio.bi_status == BLK_STS_OK);
-	struct btrfs_encoded_read_private *priv = bbio->bio.bi_private;
+	struct btrfs_encoded_read_private *priv = bbio->private;
 	struct btrfs_inode *inode = priv->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	u32 sectorsize = fs_info->sectorsize;
@@ -10410,10 +10405,9 @@ static blk_status_t btrfs_encoded_read_verify_csum(struct btrfs_bio *bbio)
 	return BLK_STS_OK;
 }
 
-static void btrfs_encoded_read_endio(struct bio *bio)
+static void btrfs_encoded_read_endio(struct btrfs_bio *bbio)
 {
-	struct btrfs_encoded_read_private *priv = bio->bi_private;
-	struct btrfs_bio *bbio = btrfs_bio(bio);
+	struct btrfs_encoded_read_private *priv = bbio->private;
 	blk_status_t status;
 
 	status = btrfs_encoded_read_verify_csum(bbio);
@@ -10431,7 +10425,7 @@ static void btrfs_encoded_read_endio(struct bio *bio)
 	if (!atomic_dec_return(&priv->pending))
 		wake_up(&priv->wait);
 	btrfs_bio_free_csum(bbio);
-	bio_put(bio);
+	bio_put(&bbio->bio);
 }
 
 int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
@@ -10478,11 +10472,11 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 			size_t bytes = min_t(u64, remaining, PAGE_SIZE);
 
 			if (!bio) {
-				bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ);
+				bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ,
+						      btrfs_encoded_read_endio,
+						      &priv);
 				bio->bi_iter.bi_sector =
 					(disk_bytenr + cur) >> SECTOR_SHIFT;
-				bio->bi_end_io = btrfs_encoded_read_endio;
-				bio->bi_private = &priv;
 			}
 
 			if (!bytes ||
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a635442c06c3e..7e092c69ee70b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6614,9 +6614,12 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
  * Initialize a btrfs_bio structure.  This skips the embedded bio itself as it
  * is already initialized by the block layer.
  */
-static inline void btrfs_bio_init(struct btrfs_bio *bbio)
+static inline void btrfs_bio_init(struct btrfs_bio *bbio,
+				  btrfs_bio_end_io_t end_io, void *private)
 {
 	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
+	bbio->end_io = end_io;
+	bbio->private = private;
 }
 
 /*
@@ -6626,16 +6629,18 @@ static inline void btrfs_bio_init(struct btrfs_bio *bbio)
  * Just like the underlying bio_alloc_bioset it will no fail as it is backed by
  * a mempool.
  */
-struct bio *btrfs_bio_alloc(unsigned int nr_vecs, unsigned int opf)
+struct bio *btrfs_bio_alloc(unsigned int nr_vecs, unsigned int opf,
+			    btrfs_bio_end_io_t end_io, void *private)
 {
 	struct bio *bio;
 
 	bio = bio_alloc_bioset(NULL, nr_vecs, opf, GFP_NOFS, &btrfs_bioset);
-	btrfs_bio_init(btrfs_bio(bio));
+	btrfs_bio_init(btrfs_bio(bio), end_io, private);
 	return bio;
 }
 
-struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
+struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
+				    btrfs_bio_end_io_t end_io, void *private)
 {
 	struct bio *bio;
 	struct btrfs_bio *bbio;
@@ -6644,7 +6649,7 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
 
 	bio = bio_alloc_clone(orig->bi_bdev, orig, GFP_NOFS, &btrfs_bioset);
 	bbio = btrfs_bio(bio);
-	btrfs_bio_init(bbio);
+	btrfs_bio_init(bbio, end_io, private);
 
 	bio_trim(bio, offset >> 9, size >> 9);
 	bbio->iter = bio->bi_iter;
@@ -6678,7 +6683,7 @@ static void btrfs_end_bio_work(struct work_struct *work)
 	struct btrfs_bio *bbio =
 		container_of(work, struct btrfs_bio, end_io_work);
 
-	bio_endio(&bbio->bio);
+	bbio->end_io(bbio);
 }
 
 static void btrfs_raid56_end_io(struct bio *bio)
@@ -6688,9 +6693,7 @@ static void btrfs_raid56_end_io(struct bio *bio)
 
 	btrfs_bio_counter_dec(bioc->fs_info);
 	bbio->mirror_num = bioc->mirror_num;
-	bio->bi_end_io = bioc->end_io;
-	bio->bi_private = bioc->private;
-	bio->bi_end_io(bio);
+	bbio->end_io(bbio);
 
 	btrfs_put_bioc(bioc);
 }
@@ -6709,8 +6712,6 @@ static void btrfs_end_bio(struct bio *bio)
 	}
 
 	bbio->mirror_num = bioc->mirror_num;
-	bio->bi_end_io = bioc->end_io;
-	bio->bi_private = bioc->private;
 
 	/*
 	 * Only send an error to the higher layers if it is beyond the tolerance
@@ -6725,7 +6726,7 @@ static void btrfs_end_bio(struct bio *bio)
 		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
 		queue_work(btrfs_end_io_wq(bioc), &bbio->end_io_work);
 	} else {
-		bio_endio(bio);
+		bbio->end_io(bbio);
 	}
 
 	btrfs_put_bioc(bioc);
@@ -6816,15 +6817,12 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 				&map_length, &bioc, mirror_num, 1);
 	if (ret) {
 		btrfs_bio_counter_dec(fs_info);
-		bio->bi_status = errno_to_blk_status(ret);
-		bio_endio(bio);
+		btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
 		return;
 	}
 
 	total_devs = bioc->num_stripes;
 	bioc->orig_bio = bio;
-	bioc->private = bio->bi_private;
-	bioc->end_io = bio->bi_end_io;
 
 	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
 	    ((btrfs_op(bio) == BTRFS_MAP_WRITE) || (mirror_num > 1))) {
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 9e984a9922c59..d3667592fec76 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -361,6 +361,8 @@ struct btrfs_fs_devices {
  */
 #define BTRFS_MAX_BIO_SECTORS				(256)
 
+typedef void (*btrfs_bio_end_io_t)(struct btrfs_bio *bbio);
+
 /*
  * Additional info to pass along bio.
  *
@@ -378,6 +380,10 @@ struct btrfs_bio {
 	u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
 	struct bvec_iter iter;
 
+	/* End I/O information supplied to btrfs_bio_alloc */
+	btrfs_bio_end_io_t end_io;
+	void *private;
+
 	/* For read end I/O handling */
 	struct work_struct end_io_work;
 
@@ -393,8 +399,16 @@ static inline struct btrfs_bio *btrfs_bio(struct bio *bio)
 	return container_of(bio, struct btrfs_bio, bio);
 }
 
-struct bio *btrfs_bio_alloc(unsigned int nr_vecs, unsigned int opf);
-struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
+struct bio *btrfs_bio_alloc(unsigned int nr_vecs, unsigned int opf,
+			    btrfs_bio_end_io_t end_io, void *private);
+struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
+				    btrfs_bio_end_io_t end_io, void *private);
+
+static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
+{
+	bbio->bio.bi_status = status;
+	bbio->end_io(bbio);
+}
 
 static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)
 {
@@ -456,9 +470,7 @@ struct btrfs_io_context {
 	refcount_t refs;
 	struct btrfs_fs_info *fs_info;
 	u64 map_type; /* get from map_lookup->type */
-	bio_end_io_t *end_io;
 	struct bio *orig_bio;
-	void *private;
 	atomic_t error;
 	int max_errors;
 	int num_stripes;
-- 
2.30.2

