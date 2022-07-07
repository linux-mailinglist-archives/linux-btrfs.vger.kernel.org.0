Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54215699DE
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 07:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiGGFdo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 01:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiGGFdo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 01:33:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7F92E9C4
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 22:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=SBLNuEw8cKkG2lorhAf1z8YYKz9+hzaPKZSGQCoNHxM=; b=fZktaEH9UrMYVSvbNKCvJ6U2Fb
        TeUsUHPAaNQ9IAvR1ihMUdAMzNWCGXPLUgfQbHUkmgK/4VuI+RLOmM/C3HsfTm8lIxLMCuA9DZbyQ
        0UlN2DxaESSNCEiUdUXPHYMvz0geCiqNB4n2mD7idSx8PG04a+LmGWWuecaAjqBCKxD94EBEHSyRu
        M9KjXYRTokMNG20bjN47gABUbyfuUbBoRNtQQjPQrm8cW7oKOT18soFSTVMQScyFTISeKbconSEtw
        udHwcG9ZEgRE7ZBL4oqm/d5lBAGQ+Y6SHW7egaADZPVPafj1tWj0d1SfXQpphGVE/sOdNe+FbskjZ
        ylDBz2Kg==;
Received: from [2001:4bb8:189:3c4a:8caf:7f2b:dda6:253] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9K8y-00DlZO-8z; Thu, 07 Jul 2022 05:33:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs: simplify the pending I/O counting in struct compressed_bio
Date:   Thu,  7 Jul 2022 07:33:27 +0200
Message-Id: <20220707053331.211259-3-hch@lst.de>
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

Instead of counting the bytes just count the bios, with an extra
reference held during submission.  This significantly simplifies the
submission side error handling.

This slightly changes the of of btrfs_submit_compressed_{read,write}
because with the old code the compressed_bio could have been completed
in submit_compressed_{read,write} only if there was an error during
submission for one of the lower bio, whilst with the new code there is
a chance for this to happen even for successful submission if the all
the lower bios complete before the end of the function is reached.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c | 126 ++++++++++-------------------------------
 fs/btrfs/compression.h |   4 +-
 2 files changed, 33 insertions(+), 97 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 907fc8a4c092c..e756da640fd7b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -191,44 +191,6 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
 	return 0;
 }
 
-/*
- * Reduce bio and io accounting for a compressed_bio with its corresponding bio.
- *
- * Return true if there is no pending bio nor io.
- * Return false otherwise.
- */
-static bool dec_and_test_compressed_bio(struct compressed_bio *cb, struct bio *bio)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
-	unsigned int bi_size = 0;
-	bool last_io = false;
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
-
-	/*
-	 * At endio time, bi_iter.bi_size doesn't represent the real bio size.
-	 * Thus here we have to iterate through all segments to grab correct
-	 * bio size.
-	 */
-	bio_for_each_segment_all(bvec, bio, iter_all)
-		bi_size += bvec->bv_len;
-
-	if (bio->bi_status)
-		cb->status = bio->bi_status;
-
-	ASSERT(bi_size && bi_size <= cb->compressed_len);
-	last_io = refcount_sub_and_test(bi_size >> fs_info->sectorsize_bits,
-					&cb->pending_sectors);
-	/*
-	 * Here we must wake up the possible error handler after all other
-	 * operations on @cb finished, or we can race with
-	 * finish_compressed_bio_*() which may free @cb.
-	 */
-	wake_up_var(cb);
-
-	return last_io;
-}
-
 static void finish_compressed_bio_read(struct compressed_bio *cb)
 {
 	unsigned int index;
@@ -288,7 +250,10 @@ static void end_compressed_bio_read(struct bio *bio)
 	unsigned int mirror = btrfs_bio(bio)->mirror_num;
 	int ret = 0;
 
-	if (!dec_and_test_compressed_bio(cb, bio))
+	if (bio->bi_status)
+		cb->status = bio->bi_status;
+
+	if (!refcount_dec_and_test(&cb->pending_ios))
 		goto out;
 
 	/*
@@ -417,7 +382,10 @@ static void end_compressed_bio_write(struct bio *bio)
 {
 	struct compressed_bio *cb = bio->bi_private;
 
-	if (dec_and_test_compressed_bio(cb, bio)) {
+	if (bio->bi_status)
+		cb->status = bio->bi_status;
+
+	if (refcount_dec_and_test(&cb->pending_ios)) {
 		struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
 
 		btrfs_record_physical_zoned(cb->inode, cb->start, bio);
@@ -476,7 +444,7 @@ static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_byte
 		return ERR_PTR(ret);
 	}
 	*next_stripe_start = disk_bytenr + geom.len;
-
+	refcount_inc(&cb->pending_ios);
 	return bio;
 }
 
@@ -503,17 +471,17 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	struct compressed_bio *cb;
 	u64 cur_disk_bytenr = disk_start;
 	u64 next_stripe_start;
-	blk_status_t ret;
 	int skip_sum = inode->flags & BTRFS_INODE_NODATASUM;
 	const bool use_append = btrfs_use_zone_append(inode, disk_start);
 	const unsigned int bio_op = use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE;
+	blk_status_t ret = BLK_STS_OK;
 
 	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
 	       IS_ALIGNED(len, fs_info->sectorsize));
 	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
 	if (!cb)
 		return BLK_STS_RESOURCE;
-	refcount_set(&cb->pending_sectors, compressed_len >> fs_info->sectorsize_bits);
+	refcount_set(&cb->pending_ios, 1);
 	cb->status = BLK_STS_OK;
 	cb->inode = &inode->vfs_inode;
 	cb->start = start;
@@ -543,8 +511,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				&next_stripe_start);
 			if (IS_ERR(bio)) {
 				ret = errno_to_blk_status(PTR_ERR(bio));
-				bio = NULL;
-				goto finish_cb;
+				break;
 			}
 			if (blkcg_css)
 				bio->bi_opf |= REQ_CGROUP_PUNT;
@@ -588,8 +555,11 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 		if (submit) {
 			if (!skip_sum) {
 				ret = btrfs_csum_one_bio(inode, bio, start, true);
-				if (ret)
-					goto finish_cb;
+				if (ret) {
+					bio->bi_status = ret;
+					bio_endio(bio);
+					break;
+				}
 			}
 
 			ASSERT(bio->bi_iter.bi_size);
@@ -598,33 +568,12 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 		}
 		cond_resched();
 	}
-	if (blkcg_css)
-		kthread_associate_blkcg(NULL);
 
-	return 0;
-
-finish_cb:
 	if (blkcg_css)
 		kthread_associate_blkcg(NULL);
 
-	if (bio) {
-		bio->bi_status = ret;
-		bio_endio(bio);
-	}
-	/* Last byte of @cb is submitted, endio will free @cb */
-	if (cur_disk_bytenr == disk_start + compressed_len)
-		return ret;
-
-	wait_var_event(cb, refcount_read(&cb->pending_sectors) ==
-			   (disk_start + compressed_len - cur_disk_bytenr) >>
-			   fs_info->sectorsize_bits);
-	/*
-	 * Even with previous bio ended, we should still have io not yet
-	 * submitted, thus need to finish manually.
-	 */
-	ASSERT(refcount_read(&cb->pending_sectors));
-	/* Now we are the only one referring @cb, can finish it safely. */
-	finish_compressed_bio_write(cb);
+	if (refcount_dec_and_test(&cb->pending_ios))
+		finish_compressed_bio_write(cb);
 	return ret;
 }
 
@@ -830,7 +779,7 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		goto out;
 	}
 
-	refcount_set(&cb->pending_sectors, compressed_len >> fs_info->sectorsize_bits);
+	refcount_set(&cb->pending_ios, 1);
 	cb->status = BLK_STS_OK;
 	cb->inode = inode;
 	cb->mirror_num = mirror_num;
@@ -880,9 +829,9 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 					REQ_OP_READ, end_compressed_bio_read,
 					&next_stripe_start);
 			if (IS_ERR(comp_bio)) {
-				ret = errno_to_blk_status(PTR_ERR(comp_bio));
-				comp_bio = NULL;
-				goto finish_cb;
+				cb->status =
+					errno_to_blk_status(PTR_ERR(comp_bio));
+				break;
 			}
 		}
 		/*
@@ -921,8 +870,11 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			unsigned int nr_sectors;
 
 			ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
-			if (ret)
-				goto finish_cb;
+			if (ret) {
+				comp_bio->bi_status = ret;
+				bio_endio(comp_bio);
+				break;
+			}
 
 			nr_sectors = DIV_ROUND_UP(comp_bio->bi_iter.bi_size,
 						  fs_info->sectorsize);
@@ -933,6 +885,9 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			comp_bio = NULL;
 		}
 	}
+
+	if (refcount_dec_and_test(&cb->pending_ios))
+		finish_compressed_bio_read(cb);
 	return;
 
 fail:
@@ -950,25 +905,6 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	bio->bi_status = ret;
 	bio_endio(bio);
 	return;
-finish_cb:
-	if (comp_bio) {
-		comp_bio->bi_status = ret;
-		bio_endio(comp_bio);
-	}
-	/* All bytes of @cb is submitted, endio will free @cb */
-	if (cur_disk_byte == disk_bytenr + compressed_len)
-		return;
-
-	wait_var_event(cb, refcount_read(&cb->pending_sectors) ==
-			   (disk_bytenr + compressed_len - cur_disk_byte) >>
-			   fs_info->sectorsize_bits);
-	/*
-	 * Even with previous bio ended, we should still have io not yet
-	 * submitted, thus need to finish @cb manually.
-	 */
-	ASSERT(refcount_read(&cb->pending_sectors));
-	/* Now we are the only one referring @cb, can finish it safely. */
-	finish_compressed_bio_read(cb);
 }
 
 /*
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 5fca7603e928a..0e4cbf04fd866 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -30,8 +30,8 @@ static_assert((BTRFS_MAX_COMPRESSED % PAGE_SIZE) == 0);
 #define	BTRFS_ZLIB_DEFAULT_LEVEL		3
 
 struct compressed_bio {
-	/* Number of sectors with unfinished IO (unsubmitted or unfinished) */
-	refcount_t pending_sectors;
+	/* Number of outstanding bios */
+	refcount_t pending_ios;
 
 	/* Number of compressed pages in the array */
 	unsigned int nr_pages;
-- 
2.30.2

