Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507F058B46C
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Aug 2022 10:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiHFIDv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Aug 2022 04:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHFIDu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Aug 2022 04:03:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2963113DE4
        for <linux-btrfs@vger.kernel.org>; Sat,  6 Aug 2022 01:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3sSX3EM7hm2uqSXiDMnUh+80E/MOisjFDIw8SDPKVMs=; b=hr0JyFT9/cfEyZSrJxDbtkfQPN
        tAqtvKTe/KTUHl/YagA7erzq6oSnF+4EQv0WoyQEN+QGmJb9DkoZVYnbDqOeuHAYgL/8Pz6gFEAK3
        w115mqIyvGZTqD/SAmFYYN7Tyszs8tPNWBMz0xdpVnYeKaKJR3GAcWwL7maiWQUIyOsidKf9DSIg4
        RB/qD/YH+qFGMHRtbiaDH/v6tdYyCYu2sU6bmB1ML/WtGHQP+jLYL6pCAl/RQciCKV6LhIqCirna5
        4wskmjbulMNpx19YyiNgLQLK9TUmkwXTkFQ7Ao5YwM9/rwgRa6pdTYNb4BfYqRwS1DsYRU8eOF9st
        syyybIJw==;
Received: from [2001:4bb8:192:6d54:4997:d9fe:27ec:4c3c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKEmf-006Lpw-Ce; Sat, 06 Aug 2022 08:03:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 05/11] btrfs: remove bioc->stripes_pending
Date:   Sat,  6 Aug 2022 10:03:24 +0200
Message-Id: <20220806080330.3823644-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220806080330.3823644-1-hch@lst.de>
References: <20220806080330.3823644-1-hch@lst.de>
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

The stripes_pending in the btrfs_io_context counts number of inflight
low-level bios for an upper btrfs_bio.  For reads this is generally
one as reads are never cloned, while for writes we can trivially use
the bio remaining mechanisms that is used for chained bios.

To be able to make use of that mechanism, split out a separate trivial
end_io handler for the cloned bios that does a minimal amount of error
tracking and which then calls bio_endio on the original bio to transfer
control to that, with the remaining counter making sure it is completed
last.  This then allows to merge btrfs_end_bioc into the original bio
bi_end_io handler.  To make this all work all error handling needs to
happen through the bi_end_io handler, which requires a small amount
of reshuffling in submit_stripe_bio so that the bio is cloned already
by the time the suitability of the device is checked.

This reduces the size of the btrfs_io_context and prepares splitting
the btrfs_bio at the stripe boundary.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 94 ++++++++++++++++++++++++----------------------
 fs/btrfs/volumes.h |  1 -
 2 files changed, 50 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 014df2e64e67b..8775f2a635919 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5892,7 +5892,6 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
 		sizeof(u64) * (total_stripes),
 		GFP_NOFS|__GFP_NOFAIL);
 
-	atomic_set(&bioc->error, 0);
 	refcount_set(&bioc->refs, 1);
 
 	bioc->fs_info = fs_info;
@@ -6647,7 +6646,21 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
 	bio_trim(bio, offset >> 9, size >> 9);
 	bbio->iter = bio->bi_iter;
 	return bio;
+}
+
+static void btrfs_log_dev_io_error(struct bio *bio, struct btrfs_device *dev)
+{
+	if (!dev || !dev->bdev)
+		return;
+	if (bio->bi_status != BLK_STS_IOERR && bio->bi_status != BLK_STS_TARGET)
+		return;
 
+	if (btrfs_op(bio) == BTRFS_MAP_WRITE)
+		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_WRITE_ERRS);
+	if (!(bio->bi_opf & REQ_RAHEAD))
+		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_READ_ERRS);
+	if (bio->bi_opf & REQ_PREFLUSH)
+		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_FLUSH_ERRS);
 }
 
 static struct workqueue_struct *btrfs_end_io_wq(struct btrfs_io_context *bioc)
@@ -6665,62 +6678,54 @@ static void btrfs_end_bio_work(struct work_struct *work)
 	bio_endio(&bbio->bio);
 }
 
-static void btrfs_end_bioc(struct btrfs_io_context *bioc, bool async)
+static void btrfs_end_bio(struct bio *bio)
 {
-	struct bio *orig_bio = bioc->orig_bio;
-	struct btrfs_bio *bbio = btrfs_bio(orig_bio);
+	struct btrfs_io_stripe *stripe = bio->bi_private;
+	struct btrfs_io_context *bioc = stripe->bioc;
+	struct btrfs_bio *bbio = btrfs_bio(bio);
 
 	btrfs_bio_counter_dec(bioc->fs_info);
 
+	if (bio->bi_status) {
+		atomic_inc(&bioc->error);
+		btrfs_log_dev_io_error(bio, stripe->dev);
+	}
+
 	bbio->mirror_num = bioc->mirror_num;
-	orig_bio->bi_private = bioc->private;
-	orig_bio->bi_end_io = bioc->end_io;
+	bio->bi_end_io = bioc->end_io;
+	bio->bi_private = bioc->private;
 
 	/*
 	 * Only send an error to the higher layers if it is beyond the tolerance
 	 * threshold.
 	 */
 	if (atomic_read(&bioc->error) > bioc->max_errors)
-		orig_bio->bi_status = BLK_STS_IOERR;
+		bio->bi_status = BLK_STS_IOERR;
 	else
-		orig_bio->bi_status = BLK_STS_OK;
+		bio->bi_status = BLK_STS_OK;
 
-	if (btrfs_op(orig_bio) == BTRFS_MAP_READ && async) {
+	if (btrfs_op(bio) == BTRFS_MAP_READ) {
 		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
 		queue_work(btrfs_end_io_wq(bioc), &bbio->end_io_work);
 	} else {
-		bio_endio(orig_bio);
+		bio_endio(bio);
 	}
 
 	btrfs_put_bioc(bioc);
 }
 
-static void btrfs_end_bio(struct bio *bio)
+static void btrfs_clone_write_end_io(struct bio *bio)
 {
 	struct btrfs_io_stripe *stripe = bio->bi_private;
-	struct btrfs_io_context *bioc = stripe->bioc;
 
 	if (bio->bi_status) {
-		atomic_inc(&bioc->error);
-		if (bio->bi_status == BLK_STS_IOERR ||
-		    bio->bi_status == BLK_STS_TARGET) {
-			if (btrfs_op(bio) == BTRFS_MAP_WRITE)
-				btrfs_dev_stat_inc_and_print(stripe->dev,
-						BTRFS_DEV_STAT_WRITE_ERRS);
-			else if (!(bio->bi_opf & REQ_RAHEAD))
-				btrfs_dev_stat_inc_and_print(stripe->dev,
-						BTRFS_DEV_STAT_READ_ERRS);
-			if (bio->bi_opf & REQ_PREFLUSH)
-				btrfs_dev_stat_inc_and_print(stripe->dev,
-						BTRFS_DEV_STAT_FLUSH_ERRS);
-		}
+		atomic_inc(&stripe->bioc->error);
+		btrfs_log_dev_io_error(bio, stripe->dev);
 	}
 
-	if (bio != bioc->orig_bio)
-		bio_put(bio);
-
-	if (atomic_dec_and_test(&bioc->stripes_pending))
-		btrfs_end_bioc(bioc, true);
+	/* Pass on control to the original bio this one was cloned from */
+	bio_endio(stripe->bioc->orig_bio);
+	bio_put(bio);
 }
 
 static void submit_stripe_bio(struct btrfs_io_context *bioc,
@@ -6731,28 +6736,30 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
 	u64 physical = bioc->stripes[dev_nr].physical;
 	struct bio *bio;
 
-	if (!dev || !dev->bdev ||
-	    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
-	    (btrfs_op(orig_bio) == BTRFS_MAP_WRITE &&
-	     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
-		atomic_inc(&bioc->error);
-		if (atomic_dec_and_test(&bioc->stripes_pending))
-			btrfs_end_bioc(bioc, false);
-		return;
-	}
-
 	if (clone) {
-		bio = bio_alloc_clone(dev->bdev, orig_bio, GFP_NOFS, &fs_bio_set);
+		bio = bio_alloc_clone(NULL, orig_bio, GFP_NOFS, &fs_bio_set);
+		bio_inc_remaining(orig_bio);
+		bio->bi_end_io = btrfs_clone_write_end_io;
 	} else {
 		bio = orig_bio;
-		bio_set_dev(bio, dev->bdev);
 		btrfs_bio(bio)->device = dev;
+		bio->bi_end_io = btrfs_end_bio;
 	}
 
 	bioc->stripes[dev_nr].bioc = bioc;
 	bio->bi_private = &bioc->stripes[dev_nr];
-	bio->bi_end_io = btrfs_end_bio;
 	bio->bi_iter.bi_sector = physical >> 9;
+
+	if (!dev || !dev->bdev ||
+	    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
+	    (btrfs_op(bio) == BTRFS_MAP_WRITE &&
+	     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
+		bio_io_error(bio);
+		return;
+	}
+
+	bio_set_dev(bio, dev->bdev);
+
 	/*
 	 * For zone append writing, bi_sector must point the beginning of the
 	 * zone
@@ -6801,7 +6808,6 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 	bioc->orig_bio = bio;
 	bioc->private = bio->bi_private;
 	bioc->end_io = bio->bi_end_io;
-	atomic_set(&bioc->stripes_pending, total_devs);
 
 	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
 	    ((btrfs_op(bio) == BTRFS_MAP_WRITE) || (mirror_num > 1))) {
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index bd108c7ed1ac3..9e984a9922c59 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -454,7 +454,6 @@ struct btrfs_discard_stripe {
  */
 struct btrfs_io_context {
 	refcount_t refs;
-	atomic_t stripes_pending;
 	struct btrfs_fs_info *fs_info;
 	u64 map_type; /* get from map_lookup->type */
 	bio_end_io_t *end_io;
-- 
2.30.2

