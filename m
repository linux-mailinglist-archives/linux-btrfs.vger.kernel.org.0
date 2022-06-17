Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D3354F4CF
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 12:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381243AbiFQKEu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 06:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380451AbiFQKEu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 06:04:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CB969738
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 03:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=lVdEpGhzHEVcdU/VyskdinrWjc6yLi6rdExj/HSj8gQ=; b=LCpsDhzxX/1kly3qRM9i6Z0qOH
        1d4GiXTanyvwxG+uNlf3ZNyPWTt/J+BJpNIfOYFk56y5Ldecwp2AJ1DD3+z4J+5Y6ydcdGNXIwR4I
        2o5A0Txco0Vr8ai0Oox8k2+N95B0SRmydcxQS6BpnhvngywCN8TX+BxK8lzOfZy6vQZZBQsNuGHFH
        KAvykKUI9Zeq0squ4dVfzG+6pfd+WTE9Av0MrThvYNswQxIbxcZoOzozWY5HAXDiSGSPJiQKdch5o
        zNZjsox6pOvR7YI2fazKWsSQYK9J4bYvjsC6HwzAuHPg6TBB6MgtrmJhNg6Ych9sSdAqC/ZVWag5s
        Cd70KSzQ==;
Received: from [2001:4bb8:180:36f6:9c91:42c8:8d10:d7ed] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o28qN-006snY-Sx; Fri, 17 Jun 2022 10:04:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/10] btrfs: remove bioc->stripes_pending
Date:   Fri, 17 Jun 2022 12:04:14 +0200
Message-Id: <20220617100414.1159680-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220617100414.1159680-1-hch@lst.de>
References: <20220617100414.1159680-1-hch@lst.de>
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

Replace the stripes_pending field with the pending counter in the bio.
This avoid an extra field and prepares splitting the btrfs_bio at the
stripe boundary.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 100 ++++++++++++++++++++++-----------------------
 fs/btrfs/volumes.h |   1 -
 2 files changed, 48 insertions(+), 53 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fea139d628c04..c1497bde713ad 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5896,7 +5896,6 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
 		sizeof(u64) * (total_stripes),
 		GFP_NOFS|__GFP_NOFAIL);
 
-	atomic_set(&bioc->error, 0);
 	refcount_set(&bioc->refs, 1);
 
 	bioc->fs_info = fs_info;
@@ -6626,46 +6625,21 @@ static void btrfs_end_bio_work(struct work_struct *work)
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
@@ -6678,12 +6652,35 @@ static void btrfs_end_bio(struct bio *bio)
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
@@ -6694,28 +6691,30 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
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
@@ -6736,8 +6735,6 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
 		(unsigned long)dev->bdev->bd_dev, rcu_str_deref(dev->name),
 		dev->devid, bio->bi_iter.bi_size);
 
-	btrfs_bio_counter_inc_noblocked(fs_info);
-
 	btrfsic_check_bio(bio);
 	submit_bio(bio);
 }
@@ -6767,7 +6764,6 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	bioc->orig_bio = bio;
 	bioc->private = bio->bi_private;
 	bioc->end_io = bio->bi_end_io;
-	atomic_set(&bioc->stripes_pending, total_devs);
 
 	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
 	    ((btrfs_op(bio) == BTRFS_MAP_WRITE) || (mirror_num > 1))) {
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index cc9966fe0e517..05713adbbf499 100644
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

