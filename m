Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF1250DAA6
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 09:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbiDYH7B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 03:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241859AbiDYH6V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 03:58:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CD9115
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 00:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NzecoMtpeOg5c6Cl2uGmLdeMMaw+aVX3XZ4qT5ad6w8=; b=UUU8plt0ImXQiOSaj3Mx94EAe2
        D3UQ1zjXKDfGRjyY1paK37Uh0nYigJ2Gii2puYrsEeKjVPeegXFlkwf3fYcaCa8Hwg5QK+tTZ2EyR
        VIzCEK4Dn8Ss15xiLjvU84braYMZCwG3reoKrKEANz9srDDhRHoi3bjyheKj3I1JZI7RJ32+t9EqI
        ir/zq2xoTSZIkPTOk9DwU70rBGmm46hnH8ISX6J7iuXBtifQ6xGtveQrLjVKWzOYMbXBMSH5jgUXj
        sMeYsuWpNbfhASMHIFHQiub2mv2aLNNLsNyP8AwfWMxWIESJceNjktjdym4gwU+saiYchTCDMNahs
        YID2OGWQ==;
Received: from 80-254-69-104.dynamic.monzoon.net ([80.254.69.104] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nitYY-008gmj-CO; Mon, 25 Apr 2022 07:54:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 09/10] btrfs: refactor btrfs_map_bio
Date:   Mon, 25 Apr 2022 09:54:17 +0200
Message-Id: <20220425075418.2192130-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425075418.2192130-1-hch@lst.de>
References: <20220425075418.2192130-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use a label for common cleanup, untangle the conditionals for parity
RAID and move all per-stripe handling into submit_stripe_bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 96 +++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5f18e9105fe08..d54aacb4f05f2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6695,10 +6695,30 @@ static void btrfs_end_bio(struct bio *bio)
 		btrfs_end_bioc(bioc, true);
 }
 
-static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
-			      u64 physical, struct btrfs_device *dev)
+static void submit_stripe_bio(struct btrfs_io_context *bioc,
+		struct bio *orig_bio, int dev_nr, bool clone)
 {
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
+	struct btrfs_device *dev = bioc->stripes[dev_nr].dev;
+	u64 physical = bioc->stripes[dev_nr].physical;
+	struct bio *bio;
+
+	if (!dev || !dev->bdev ||
+	    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
+	    (btrfs_op(orig_bio) == BTRFS_MAP_WRITE &&
+	     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
+		atomic_inc(&bioc->error);
+		if (atomic_dec_and_test(&bioc->stripes_pending))
+			btrfs_end_bioc(bioc, false);
+		return;
+	}
+
+	if (clone) {
+		bio = btrfs_bio_clone(dev->bdev, orig_bio);
+	} else {
+		bio = orig_bio;
+		bio_set_dev(bio, dev->bdev);
+	}
 
 	bio->bi_private = bioc;
 	btrfs_bio(bio)->device = dev;
@@ -6733,46 +6753,44 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
 blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			   int mirror_num)
 {
-	struct btrfs_device *dev;
-	struct bio *first_bio = bio;
 	u64 logical = bio->bi_iter.bi_sector << 9;
-	u64 length = 0;
-	u64 map_length;
+	u64 length = bio->bi_iter.bi_size;
+	u64 map_length = length;
 	int ret;
 	int dev_nr;
 	int total_devs;
 	struct btrfs_io_context *bioc = NULL;
 
-	length = bio->bi_iter.bi_size;
-	map_length = length;
-
 	btrfs_bio_counter_inc_blocked(fs_info);
 	ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical,
 				&map_length, &bioc, mirror_num, 1);
-	if (ret) {
-		btrfs_bio_counter_dec(fs_info);
-		return errno_to_blk_status(ret);
-	}
+	if (ret)
+		goto out_dec;
 
 	total_devs = bioc->num_stripes;
-	bioc->orig_bio = first_bio;
-	bioc->private = first_bio->bi_private;
-	bioc->end_io = first_bio->bi_end_io;
-	atomic_set(&bioc->stripes_pending, bioc->num_stripes);
-
-	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
-	    ((btrfs_op(bio) == BTRFS_MAP_WRITE) || (mirror_num > 1))) {
-		/* In this case, map_length has been set to the length of
-		   a single stripe; not the whole write */
+	bioc->orig_bio = bio;
+	bioc->private = bio->bi_private;
+	bioc->end_io = bio->bi_end_io;
+	atomic_set(&bioc->stripes_pending, total_devs);
+
+	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		/*
+		 * In this case, map_length has been set to the length of a
+		 * single stripe; not the whole write.
+		 */
 		if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
 			ret = raid56_parity_write(bio, bioc, map_length);
-		} else {
+			goto out_dec;
+		}
+		if (mirror_num > 1) {
 			ret = raid56_parity_recover(bio, bioc, map_length,
 						    mirror_num, 1);
+			goto out_dec;
 		}
-
-		btrfs_bio_counter_dec(fs_info);
-		return errno_to_blk_status(ret);
+		/*
+		 * Normal reads do not require special parity read handling, so
+		 * fall through here.
+		 */
 	}
 
 	if (map_length < length) {
@@ -6782,29 +6800,11 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		BUG();
 	}
 
-	for (dev_nr = 0; dev_nr < total_devs; dev_nr++) {
-		dev = bioc->stripes[dev_nr].dev;
-		if (!dev || !dev->bdev || test_bit(BTRFS_DEV_STATE_MISSING,
-						   &dev->dev_state) ||
-		    (btrfs_op(first_bio) == BTRFS_MAP_WRITE &&
-		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
-			atomic_inc(&bioc->error);
-			if (atomic_dec_and_test(&bioc->stripes_pending))
-				btrfs_end_bioc(bioc, false);
-			continue;
-		}
-
-		if (dev_nr < total_devs - 1) {
-			bio = btrfs_bio_clone(dev->bdev, first_bio);
-		} else {
-			bio = first_bio;
-			bio_set_dev(bio, dev->bdev);
-		}
-
-		submit_stripe_bio(bioc, bio, bioc->stripes[dev_nr].physical, dev);
-	}
+	for (dev_nr = 0; dev_nr < total_devs; dev_nr++)
+		submit_stripe_bio(bioc, bio, dev_nr, dev_nr < total_devs - 1);
+out_dec:
 	btrfs_bio_counter_dec(fs_info);
-	return BLK_STS_OK;
+	return errno_to_blk_status(ret);
 }
 
 static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
-- 
2.30.2

