Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2422D534ADC
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 09:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346445AbiEZHgy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 03:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346426AbiEZHgw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 03:36:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EBC994FC
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 00:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OahmsiLkcC6NZfDJwHXKtYcT9+tztDint+ELf20X0Ac=; b=BKcFArzzfJs0zofUqKrztToV++
        tZr6XU+765EigMTlhFrX/cJVgg3BPhLKSNNfWGifgcybpz/wxA95gLDb1l/bNeZJrMaX7mNF/x4nY
        zJ5xr83ghzBeSHQm5b9knKaGZ0d7qhd8LFyq54zU8W/PG1FvTq6VpYxRYE+j0t0HzLAj24BBImRyc
        Tm3+/VGwT8ibcJF/hr7sB2TDuZQlgG0kCzZsxHo7YugMlkaRSPOe0csxv/TgoaZ/QD+Igimb1IUnE
        e0JhqoO3x6qjD4onnw4+pH0bxW2Bm2lXB4Nnz+qncAtuyycIIJJ+gbZQihYiMl3Ui2G4etFoYOzxp
        l3Fq29VA==;
Received: from [2001:4bb8:18c:7298:d94:e0f5:2d65:4015] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nu835-00DpVw-5A; Thu, 26 May 2022 07:36:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 01/10] btrfs: move more work into btrfs_end_bioc
Date:   Thu, 26 May 2022 09:36:33 +0200
Message-Id: <20220526073642.1773373-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220526073642.1773373-1-hch@lst.de>
References: <20220526073642.1773373-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Assign ->mirror_num and ->bi_status in btrfs_end_bioc instead of
duplicating the logic in the callers.  Also remove the bio argument as
it always must be bioc->orig_bio and the now pointless bioc_error that
did nothing but assign bi_sector to the same value just sampled in the
caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 72 ++++++++++++++--------------------------------
 1 file changed, 22 insertions(+), 50 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a2bb0928dc066..03d941c19f4cb 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6626,19 +6626,29 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret, 0, 1);
 }
 
-static inline void btrfs_end_bioc(struct btrfs_io_context *bioc, struct bio *bio)
+static inline void btrfs_end_bioc(struct btrfs_io_context *bioc)
 {
-	bio->bi_private = bioc->private;
-	bio->bi_end_io = bioc->end_io;
-	bio_endio(bio);
+	struct bio *orig_bio = bioc->orig_bio;
 
+	btrfs_bio(orig_bio)->mirror_num = bioc->mirror_num;
+	orig_bio->bi_private = bioc->private;
+	orig_bio->bi_end_io = bioc->end_io;
+
+	/*
+	 * Only send an error to the higher layers if it is beyond the tolerance
+	 * threshold.
+	 */
+	if (atomic_read(&bioc->error) > bioc->max_errors)
+		orig_bio->bi_status = BLK_STS_IOERR;
+	else
+		orig_bio->bi_status = BLK_STS_OK;
+	bio_endio(orig_bio);
 	btrfs_put_bioc(bioc);
 }
 
 static void btrfs_end_bio(struct bio *bio)
 {
 	struct btrfs_io_context *bioc = bio->bi_private;
-	int is_orig_bio = 0;
 
 	if (bio->bi_status) {
 		atomic_inc(&bioc->error);
@@ -6659,35 +6669,12 @@ static void btrfs_end_bio(struct bio *bio)
 		}
 	}
 
-	if (bio == bioc->orig_bio)
-		is_orig_bio = 1;
+	if (bio != bioc->orig_bio)
+		bio_put(bio);
 
 	btrfs_bio_counter_dec(bioc->fs_info);
-
-	if (atomic_dec_and_test(&bioc->stripes_pending)) {
-		if (!is_orig_bio) {
-			bio_put(bio);
-			bio = bioc->orig_bio;
-		}
-
-		btrfs_bio(bio)->mirror_num = bioc->mirror_num;
-		/* only send an error to the higher layers if it is
-		 * beyond the tolerance of the btrfs bio
-		 */
-		if (atomic_read(&bioc->error) > bioc->max_errors) {
-			bio->bi_status = BLK_STS_IOERR;
-		} else {
-			/*
-			 * this bio is actually up to date, we didn't
-			 * go over the max number of errors
-			 */
-			bio->bi_status = BLK_STS_OK;
-		}
-
-		btrfs_end_bioc(bioc, bio);
-	} else if (!is_orig_bio) {
-		bio_put(bio);
-	}
+	if (atomic_dec_and_test(&bioc->stripes_pending))
+		btrfs_end_bioc(bioc);
 }
 
 static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
@@ -6725,23 +6712,6 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
 	submit_bio(bio);
 }
 
-static void bioc_error(struct btrfs_io_context *bioc, struct bio *bio, u64 logical)
-{
-	atomic_inc(&bioc->error);
-	if (atomic_dec_and_test(&bioc->stripes_pending)) {
-		/* Should be the original bio. */
-		WARN_ON(bio != bioc->orig_bio);
-
-		btrfs_bio(bio)->mirror_num = bioc->mirror_num;
-		bio->bi_iter.bi_sector = logical >> 9;
-		if (atomic_read(&bioc->error) > bioc->max_errors)
-			bio->bi_status = BLK_STS_IOERR;
-		else
-			bio->bi_status = BLK_STS_OK;
-		btrfs_end_bioc(bioc, bio);
-	}
-}
-
 blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			   int mirror_num)
 {
@@ -6800,7 +6770,9 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 						   &dev->dev_state) ||
 		    (btrfs_op(first_bio) == BTRFS_MAP_WRITE &&
 		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
-			bioc_error(bioc, first_bio, logical);
+			atomic_inc(&bioc->error);
+			if (atomic_dec_and_test(&bioc->stripes_pending))
+				btrfs_end_bioc(bioc);
 			continue;
 		}
 
-- 
2.30.2

