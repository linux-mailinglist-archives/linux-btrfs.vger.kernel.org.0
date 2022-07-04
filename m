Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D43564FF3
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 10:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiGDIo1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 04:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiGDIo0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 04:44:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4696CB7D4
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 01:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/zhlvA+/Uc+l4vEPvMjXwmG3LClioqpQDMZ4akcdc1Y=; b=PmyZ7kJiFgtLnkM7XQu6cEDoUV
        +PGnmmv3MLJ+/vL3cDJpy54MZrlMPtsHp3NYV7/pj9CCzUxG1LoY+cFnnw+rKNLQHcToDnhG2AdkY
        v3GMg4yw1zgNztPSZiEB1O+/wZKS2yUYSBuCxWqm3xedji4KRRItSRlRkuaj8dtOn6FcpWsoXpdNS
        wNtWVnAClJyP3j+a00sBRzJp14uOKIj5ckAlQZpm9mfUX/osgaDag10UxUe25/5J5qpEVLjWkcgS/
        3EBvlCrytZFzQGb2tmBCRL5unkke8bhYjfl6jHvRPmLMxwi6Tif7AGJSGLHV4bCQZhIGOjbKOahEY
        YQLiF1Sw==;
Received: from [2001:4bb8:189:3c4a:9cc7:69df:e5dc:ef11] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8Hgu-0068MP-66; Mon, 04 Jul 2022 08:44:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/7] btrfs: split out the end_io handler for cloned bios
Date:   Mon,  4 Jul 2022 10:44:05 +0200
Message-Id: <20220704084406.106929-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220704084406.106929-1-hch@lst.de>
References: <20220704084406.106929-1-hch@lst.de>
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

Split the handler for cloned bios from the main end I/O handler.  This
cleans up the logic to be easier to follow, and prepares for additional
low-level bio completion changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 59 +++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1b4b5ce278dd4..32810641737e0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6656,6 +6656,21 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
 	return bio;
 }
 
+static void btrfs_log_dev_io_error(struct bio *bio, struct btrfs_device *dev)
+{
+	if (!dev || !dev->bdev)
+		return;
+	if (bio->bi_status != BLK_STS_IOERR && bio->bi_status != BLK_STS_TARGET)
+		return;
+
+	if (btrfs_op(bio) == BTRFS_MAP_WRITE)
+		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_WRITE_ERRS);
+	if (!(bio->bi_opf & REQ_RAHEAD))
+		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_READ_ERRS);
+	if (bio->bi_opf & REQ_PREFLUSH)
+		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_FLUSH_ERRS);
+}
+
 static struct workqueue_struct *btrfs_end_io_wq(struct btrfs_io_context *bioc)
 {
 	if (bioc->orig_bio->bi_opf & REQ_META)
@@ -6683,34 +6698,29 @@ static void btrfs_raid56_end_io(struct bio *bio)
 	btrfs_put_bioc(bioc);
 }
 
+static void btrfs_clone_write_end_io(struct bio *bio)
+{
+	struct btrfs_io_stripe *stripe = bio->bi_private;
+
+	if (bio->bi_status) {
+		atomic_inc(&stripe->bioc->error);
+		btrfs_log_dev_io_error(bio, stripe->dev);
+	}
+
+	/* Pass on cotrol to the original bio this was cloned from */
+	bio_endio(stripe->bioc->orig_bio);
+	bio_put(bio);
+}
+
 static void btrfs_end_bio(struct bio *bio)
 {
 	struct btrfs_io_stripe *stripe = bio->bi_private;
 	struct btrfs_io_context *bioc = stripe->bioc;
-	struct bio *orig_bio = bioc->orig_bio;
-	struct btrfs_bio *bbio = btrfs_bio(orig_bio);
+	struct btrfs_bio *bbio = btrfs_bio(bio);
 
 	if (bio->bi_status) {
 		atomic_inc(&bioc->error);
-		if (stripe->dev && stripe->dev->bdev &&
-		    (bio->bi_status == BLK_STS_IOERR ||
-		     bio->bi_status == BLK_STS_TARGET)) {
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
-	}
-
-	if (bio != orig_bio) {
-		bio_endio(orig_bio);
-		bio_put(bio);
-		return;
+		btrfs_log_dev_io_error(bio, stripe->dev);
 	}
 
 	/*
@@ -6718,9 +6728,9 @@ static void btrfs_end_bio(struct bio *bio)
 	 * threshold.
 	 */
 	if (atomic_read(&bioc->error) > bioc->max_errors)
-		orig_bio->bi_status = BLK_STS_IOERR;
+		bio->bi_status = BLK_STS_IOERR;
 	else
-		orig_bio->bi_status = BLK_STS_OK;
+		bio->bi_status = BLK_STS_OK;
 
 	btrfs_bio_counter_dec(bioc->fs_info);
 	bbio->mirror_num = bioc->mirror_num;
@@ -6746,13 +6756,14 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
 	if (clone) {
 		bio = bio_alloc_clone(NULL, orig_bio, GFP_NOFS, &fs_bio_set);
 		bio_inc_remaining(orig_bio);
+		bio->bi_end_io = btrfs_clone_write_end_io;
 	} else {
 		bio = orig_bio;
+		bio->bi_end_io = btrfs_end_bio;
 	}
 
 	bioc->stripes[dev_nr].bioc = bioc;
 	bio->bi_private = &bioc->stripes[dev_nr];
-	bio->bi_end_io = btrfs_end_bio;
 	bio->bi_iter.bi_sector = physical >> 9;
 
 	if (!dev || !dev->bdev ||
-- 
2.30.2

