Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249FF54CC6B
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 17:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiFOPPp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 11:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344978AbiFOPPh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 11:15:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7A829CAC
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 08:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zzi5SbyXzqn0T72VCzOne8atSxMZTUN835WGPfibC7c=; b=jKlnhRMpusz4Ab9cOqz7krQHBn
        0BtCrmwFVgB8xM3sBoW7aOG0TVciiEHZ6yqRsj6MzZ3vvGFqQzTYeJoAjH16hMufCz/2Nev6odauF
        fEtJAWwaSF1vS3hV3HbUlrU4Fw7c5yf2CwhX5ZBC5+LHFZWPJ2McXwHlXVj2qlHbWgGih0La+WnWp
        KZNeTTWADpMKZvoPHk8/lqaqw8ljKmDmzKFLrZuR4Bu7EHB8sPVO/w5M+yTIfRXeevk6CoY5fugUj
        GqhbJHwGfe7pjv08YS9DnMQbt4sTMcl50d+y1IYsKMU64CwdLEtEbkvnNFELfdIvSuwuXg5/9nikI
        nDvRBwmQ==;
Received: from [2001:4bb8:180:36f6:5ab4:8a8:5e48:3d75] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1Uk0-00F8u2-2Y; Wed, 15 Jun 2022 15:15:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs: remove bioc->stripes_pending
Date:   Wed, 15 Jun 2022 17:15:15 +0200
Message-Id: <20220615151515.888424-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220615151515.888424-1-hch@lst.de>
References: <20220615151515.888424-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Replace the the stripes_pending field with the pending counter in the
bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 100 ++++++++++++++++++++++-----------------------
 fs/btrfs/volumes.h |   1 -
 2 files changed, 48 insertions(+), 53 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3a8c437bdd65b..bf80a850347cd 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5889,7 +5889,6 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
 		sizeof(u64) * (total_stripes),
 		GFP_NOFS|__GFP_NOFAIL);
 
-	atomic_set(&bioc->error, 0);
 	refcount_set(&bioc->refs, 1);
 
 	bioc->fs_info = fs_info;
@@ -6619,46 +6618,21 @@ static void btrfs_end_bio_work(struct work_struct *work)
 	struct btrfs_bio *bbio =
 		container_of(work, struct btrfs_bio, end_io_work);
 
-	bio_endio(&bbio->bio);
-}
-
-static void btrfs_end_bioc(struct btrfs_io_context *bioc, bool async)
-{
-	struct bio *orig_bio = bioc->orig_bio;
-	struct btrfs_bio *bbio = btrfs_bio(orig_bio);
-
-	bbio->mirror_num = bioc->mirror_num;
-	orig_bio->bi_private = bioc->private;
-	orig_bio->bi_end_io = bioc->end_io;
-
-	/*
-	 * Only send an error to the higher layers if it is beyond the tolerance
-	 * threshold.
-	 */
-	if (atomic_read(&bioc->error) > bioc->max_errors)
-		orig_bio->bi_status = BLK_STS_IOERR;
-	else
-		orig_bio->bi_status = BLK_STS_OK;
-
-	if (btrfs_op(orig_bio) == BTRFS_MAP_READ && async) {
-		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
-		queue_work(btrfs_end_io_wq(bioc), &bbio->end_io_work);
-	} else {
-		bio_endio(orig_bio);
-	}
-
-	btrfs_put_bioc(bioc);
+	bbio->bio.bi_end_io(&bbio->bio);
 }
 
 static void btrfs_end_bio(struct bio *bio)
 {
 	struct btrfs_io_stripe *stripe = bio->bi_private;
 	struct btrfs_io_context *bioc = stripe->bioc;
+	struct bio *orig_bio = bioc->orig_bio;
+	struct btrfs_bio *bbio = btrfs_bio(orig_bio);
 
 	if (bio->bi_status) {
 		atomic_inc(&bioc->error);
-		if (bio->bi_status == BLK_STS_IOERR ||
-		    bio->bi_status == BLK_STS_TARGET) {
+		if (stripe->dev && stripe->dev->bdev &&
+		    (bio->bi_status == BLK_STS_IOERR ||
+		     bio->bi_status == BLK_STS_TARGET)) {
 			if (btrfs_op(bio) == BTRFS_MAP_WRITE)
 				btrfs_dev_stat_inc_and_print(stripe->dev,
 						BTRFS_DEV_STAT_WRITE_ERRS);
@@ -6671,12 +6645,35 @@ static void btrfs_end_bio(struct bio *bio)
 		}
 	}
 
-	if (bio != bioc->orig_bio)
+	btrfs_bio_counter_dec(bioc->fs_info);
+
+	if (bio != orig_bio) {
+		bio_endio(orig_bio);
 		bio_put(bio);
+		return;
+	}
 
-	btrfs_bio_counter_dec(bioc->fs_info);
-	if (atomic_dec_and_test(&bioc->stripes_pending))
-		btrfs_end_bioc(bioc, true);
+	/*
+	 * Only send an error to the higher layers if it is beyond the tolerance
+	 * threshold.
+	 */
+	if (atomic_read(&bioc->error) > bioc->max_errors)
+		orig_bio->bi_status = BLK_STS_IOERR;
+	else
+		orig_bio->bi_status = BLK_STS_OK;
+
+	bbio->mirror_num = bioc->mirror_num;
+	orig_bio->bi_end_io = bioc->end_io;
+	orig_bio->bi_private = bioc->private;
+	if (btrfs_op(orig_bio) == BTRFS_MAP_READ) {
+		bbio->device = stripe->dev;
+		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
+		queue_work(btrfs_end_io_wq(bioc), &bbio->end_io_work);
+	} else {
+		orig_bio->bi_end_io(orig_bio);
+	}
+
+	btrfs_put_bioc(bioc);
 }
 
 static void submit_stripe_bio(struct btrfs_io_context *bioc,
@@ -6687,28 +6684,30 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
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
 	} else {
 		bio = orig_bio;
-		bio_set_dev(bio, dev->bdev);
-		btrfs_bio(bio)->device = dev;
 	}
 
 	bioc->stripes[dev_nr].bioc = bioc;
 	bio->bi_private = &bioc->stripes[dev_nr];
 	bio->bi_end_io = btrfs_end_bio;
 	bio->bi_iter.bi_sector = physical >> 9;
+
+	btrfs_bio_counter_inc_noblocked(fs_info);
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
@@ -6729,8 +6728,6 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
 		(unsigned long)dev->bdev->bd_dev, rcu_str_deref(dev->name),
 		dev->devid, bio->bi_iter.bi_size);
 
-	btrfs_bio_counter_inc_noblocked(fs_info);
-
 	btrfsic_check_bio(bio);
 	submit_bio(bio);
 }
@@ -6760,7 +6757,6 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	bioc->orig_bio = bio;
 	bioc->private = bio->bi_private;
 	bioc->end_io = bio->bi_end_io;
-	atomic_set(&bioc->stripes_pending, total_devs);
 
 	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
 	    ((btrfs_op(bio) == BTRFS_MAP_WRITE) || (mirror_num > 1))) {
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index c0f5bbba9c6ac..ecbaf92323030 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -444,7 +444,6 @@ struct btrfs_discard_stripe {
  */
 struct btrfs_io_context {
 	refcount_t refs;
-	atomic_t stripes_pending;
 	struct btrfs_fs_info *fs_info;
 	u64 map_type; /* get from map_lookup->type */
 	bio_end_io_t *end_io;
-- 
2.30.2

