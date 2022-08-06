Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C11458B473
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Aug 2022 10:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbiHFIEG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Aug 2022 04:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbiHFIEF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Aug 2022 04:04:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AA513DFE
        for <linux-btrfs@vger.kernel.org>; Sat,  6 Aug 2022 01:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=HnRUoi39OJ5epATd0d+m5kwpe3yAFVwKNSd6yPeyWlw=; b=aHZfmjUSAUMFeBN5t4Uo1aBXA9
        i7FJsQp8waShCS2a0B9XN+19fHJ/Tdg7dqbuz6hdV/wVIMX2MYrwL3dkvrjuv0EmaWfvRDXb256F2
        Qf06K2IEZWSCC54uSxnStwT+4mj1YAODqAOhKwQS1rsgBsKQ4VL1F/H+LfSSA+AlGY396uhnFZf5M
        6W5Gz0P1lJCovoXLW2LvwFEANL1s6SwySwxzn4wmOGGwN9f9/EAoZgmZDgRVHktgEa1prS9eQTFAA
        eMgW4L6n13A23iomR0x0KKI8YXdaOR1D5xehZ6ojsOt9cTeUi1NYynjWGnt4jEaxIt8HKMEkSOji7
        AT4baiMw==;
Received: from [2001:4bb8:192:6d54:4997:d9fe:27ec:4c3c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKEmu-006LyV-6h; Sat, 06 Aug 2022 08:04:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 11/11] btrfs: stop allocation a btrfs_io_context for simple I/O
Date:   Sat,  6 Aug 2022 10:03:30 +0200
Message-Id: <20220806080330.3823644-12-hch@lst.de>
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

The I/O context structure is only used to pass the btrfs_device to
the end I/O handler for I/Os that go to a single device.

Stop allocating the I/O context for these cases by passing the optional
btrfs_io_stripe argument to __btrfs_map_block to query the mapping
information and then using a fast path submission and I/O completion
handler.  As the old btrfs_io_context based I/O submission path is
only used for mirrored writes, rename the functions to make that
clear and stop setting the btrfs_bio device and mirror_num field
that is only used for reads.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 94 ++++++++++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 43ed4fb21f8ac..70ff11c68f0f6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6700,11 +6700,12 @@ static void btrfs_log_dev_io_error(struct bio *bio, struct btrfs_device *dev)
 		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_FLUSH_ERRS);
 }
 
-static struct workqueue_struct *btrfs_end_io_wq(struct btrfs_io_context *bioc)
+static struct workqueue_struct *btrfs_end_io_wq(struct btrfs_fs_info *fs_info,
+						struct bio *bio)
 {
-	if (bioc->orig_bio->bi_opf & REQ_META)
-		return bioc->fs_info->endio_meta_workers;
-	return bioc->fs_info->endio_workers;
+	if (bio->bi_opf & REQ_META)
+		return fs_info->endio_meta_workers;
+	return fs_info->endio_workers;
 }
 
 static void btrfs_end_bio_work(struct work_struct *work)
@@ -6715,6 +6716,24 @@ static void btrfs_end_bio_work(struct work_struct *work)
 	bbio->end_io(bbio);
 }
 
+static void btrfs_simple_end_io(struct bio *bio)
+{
+	struct btrfs_fs_info *fs_info = bio->bi_private;
+	struct btrfs_bio *bbio = btrfs_bio(bio);
+
+	btrfs_bio_counter_dec(fs_info);
+
+	if (bio->bi_status)
+		btrfs_log_dev_io_error(bio, bbio->device);
+
+	if (bio_op(bio) == REQ_OP_READ) {
+		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
+		queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->end_io_work);
+	} else {
+		bbio->end_io(bbio);
+	}
+}
+
 static void btrfs_raid56_end_io(struct bio *bio)
 {
 	struct btrfs_io_context *bioc = bio->bi_private;
@@ -6727,7 +6746,7 @@ static void btrfs_raid56_end_io(struct bio *bio)
 	btrfs_put_bioc(bioc);
 }
 
-static void btrfs_end_bio(struct bio *bio)
+static void btrfs_orig_write_end_io(struct bio *bio)
 {
 	struct btrfs_io_stripe *stripe = bio->bi_private;
 	struct btrfs_io_context *bioc = stripe->bioc;
@@ -6740,8 +6759,6 @@ static void btrfs_end_bio(struct bio *bio)
 		btrfs_log_dev_io_error(bio, stripe->dev);
 	}
 
-	bbio->mirror_num = bioc->mirror_num;
-
 	/*
 	 * Only send an error to the higher layers if it is beyond the tolerance
 	 * threshold.
@@ -6751,13 +6768,7 @@ static void btrfs_end_bio(struct bio *bio)
 	else
 		bio->bi_status = BLK_STS_OK;
 
-	if (btrfs_op(bio) == BTRFS_MAP_READ) {
-		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
-		queue_work(btrfs_end_io_wq(bioc), &bbio->end_io_work);
-	} else {
-		bbio->end_io(bbio);
-	}
-
+	bbio->end_io(bbio);
 	btrfs_put_bioc(bioc);
 }
 
@@ -6814,15 +6825,16 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 	submit_bio(bio);
 }
 
-static void submit_stripe_bio(struct btrfs_io_context *bioc, int dev_nr)
+static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
 {
 	struct bio *orig_bio = bioc->orig_bio, *bio;
 
+	ASSERT(bio_op(orig_bio) != REQ_OP_READ);
+
 	/* Reuse the bio embedded into the btrfs_bio for the last mirror */
 	if (dev_nr == bioc->num_stripes - 1) {
 		bio = orig_bio;
-		btrfs_bio(bio)->device = bioc->stripes[dev_nr].dev;
-		bio->bi_end_io = btrfs_end_bio;
+		bio->bi_end_io = btrfs_orig_write_end_io;
 	} else {
 		bio = bio_alloc_clone(NULL, orig_bio, GFP_NOFS, &fs_bio_set);
 		bio_inc_remaining(orig_bio);
@@ -6840,34 +6852,19 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 	u64 logical = bio->bi_iter.bi_sector << 9;
 	u64 length = bio->bi_iter.bi_size;
 	u64 map_length = length;
-	int ret;
-	int dev_nr;
-	int total_devs;
 	struct btrfs_io_context *bioc = NULL;
+	struct btrfs_io_stripe smap;
+	int ret;
 
 	btrfs_bio_counter_inc_blocked(fs_info);
 	ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
-				&bioc, NULL, &mirror_num, 1);
+				&bioc, &smap, &mirror_num, 1);
 	if (ret) {
 		btrfs_bio_counter_dec(fs_info);
 		btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
 		return;
 	}
 
-	total_devs = bioc->num_stripes;
-	bioc->orig_bio = bio;
-
-	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
-	    ((btrfs_op(bio) == BTRFS_MAP_WRITE) || (mirror_num > 1))) {
-		bio->bi_private = bioc;
-		bio->bi_end_io = btrfs_raid56_end_io;
-		if (btrfs_op(bio) == BTRFS_MAP_WRITE)
-			raid56_parity_write(bio, bioc);
-		else
-			raid56_parity_recover(bio, bioc, mirror_num);
-		return;
-	}
-
 	if (map_length < length) {
 		btrfs_crit(fs_info,
 			   "mapping failed logical %llu bio len %llu len %llu",
@@ -6875,8 +6872,31 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 		BUG();
 	}
 
-	for (dev_nr = 0; dev_nr < total_devs; dev_nr++)
-		submit_stripe_bio(bioc, dev_nr);
+	if (!bioc) {
+		/* Single mirror read/write fast path */
+		btrfs_bio(bio)->mirror_num = mirror_num;
+		btrfs_bio(bio)->device = smap.dev;
+		bio->bi_iter.bi_sector = smap.physical >> SECTOR_SHIFT;
+		bio->bi_private = fs_info;
+		bio->bi_end_io = btrfs_simple_end_io;
+		btrfs_submit_dev_bio(smap.dev, bio);
+	} else if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		/* Parity RAID write or read recovery */
+		bio->bi_private = bioc;
+		bio->bi_end_io = btrfs_raid56_end_io;
+		if (bio_op(bio) == REQ_OP_READ)
+			raid56_parity_recover(bio, bioc, mirror_num);
+		else
+			raid56_parity_write(bio, bioc);
+	} else {
+		/* Write to multiple mirrors */
+		int total_devs = bioc->num_stripes;
+		int dev_nr;
+
+		bioc->orig_bio = bio;
+		for (dev_nr = 0; dev_nr < total_devs; dev_nr++)
+			btrfs_submit_mirrored_bio(bioc, dev_nr);
+	}
 }
 
 static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
-- 
2.30.2

