Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEB8514D03
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 16:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377442AbiD2OeW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 10:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377450AbiD2OeO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 10:34:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE2B7E589
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 07:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9p9wV8+e6z21AZazcyp7c90XzYi5GUI7OfChZxgYHks=; b=Q3K8xJ95ZL+IzgDHXQ2CQV1547
        rhIxZVnH84wEM49Bh5BRFhA2ZaNWMVqLQQIOHp3uuQT/RoMxie6RXfVVRgx3sZDCqyDLaC+4YdAWu
        zSAMKjUYhIcFmhOw8vJvgbczvojk6b7FGzhMUnZYVmOZdebeDTbMBrbUsDNa4pzad4tSdvPZOgCRe
        1vpww5XSf9BaHEiVoCvndiQ+H9Kfop2TNIpQEDJexaN10HyamGrCLUvw5xNHTJFpQEf/WKcOW+nbq
        MWTaopzZDth1sf3ocEJ0BBmR5KDdbVfEDoQMP96YksuKE3pHVbvY31L+h1Kx6/HQKP7tjakqzpgxq
        TtvvazEQ==;
Received: from [2607:fb90:27d7:71af:6ca1:91e8:bf19:edd2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkRdy-00Bal4-L1; Fri, 29 Apr 2022 14:30:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/10] btrfs: do not allocate a btrfs_bio for low-level bios
Date:   Fri, 29 Apr 2022 07:30:40 -0700
Message-Id: <20220429143040.106889-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220429143040.106889-1-hch@lst.de>
References: <20220429143040.106889-1-hch@lst.de>
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

The bios submitted from btrfs_map_bio don't really interact with the
rest of btrfs and the only btrfs_bio member actually used in the
low-level bios is the pointer to the btrfs_io_contex used for endio
handler.

Use a union in struct btrfs_io_stripe that allows the endio handler to
find the btrfs_io_context and remove the spurious ->device assignment
so that a plain fs_bio_set bio can be used for the low-level bios
allocated inside btrfs_map_bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 13 -------------
 fs/btrfs/extent_io.h |  1 -
 fs/btrfs/volumes.c   | 20 ++++++++++----------
 fs/btrfs/volumes.h   |  5 ++++-
 4 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a14ed9b9dc2d0..37f4eee418219 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3209,19 +3209,6 @@ struct bio *btrfs_bio_alloc(unsigned int nr_iovecs)
 	return bio;
 }
 
-struct bio *btrfs_bio_clone(struct block_device *bdev, struct bio *bio)
-{
-	struct btrfs_bio *bbio;
-	struct bio *new;
-
-	/* Bio allocation backed by a bioset does not fail */
-	new = bio_alloc_clone(bdev, bio, GFP_NOFS, &btrfs_bioset);
-	bbio = btrfs_bio(new);
-	btrfs_bio_init(bbio);
-	bbio->iter = bio->bi_iter;
-	return new;
-}
-
 struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
 {
 	struct bio *bio;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index b390ec79f9a86..3078e90be3a99 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -265,7 +265,6 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array);
 struct bio *btrfs_bio_alloc(unsigned int nr_iovecs);
-struct bio *btrfs_bio_clone(struct block_device *bdev, struct bio *bio);
 struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
 
 void end_extent_writepage(struct page *page, int err, u64 start, u64 end);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 28ac2bfb5d296..8577893ccb4b9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6666,23 +6666,21 @@ static void btrfs_end_bioc(struct btrfs_io_context *bioc, bool async)
 
 static void btrfs_end_bio(struct bio *bio)
 {
-	struct btrfs_io_context *bioc = bio->bi_private;
+	struct btrfs_io_stripe *stripe = bio->bi_private;
+	struct btrfs_io_context *bioc = stripe->bioc;
 
 	if (bio->bi_status) {
 		atomic_inc(&bioc->error);
 		if (bio->bi_status == BLK_STS_IOERR ||
 		    bio->bi_status == BLK_STS_TARGET) {
-			struct btrfs_device *dev = btrfs_bio(bio)->device;
-
-			ASSERT(dev->bdev);
 			if (btrfs_op(bio) == BTRFS_MAP_WRITE)
-				btrfs_dev_stat_inc_and_print(dev,
+				btrfs_dev_stat_inc_and_print(stripe->dev,
 						BTRFS_DEV_STAT_WRITE_ERRS);
 			else if (!(bio->bi_opf & REQ_RAHEAD))
-				btrfs_dev_stat_inc_and_print(dev,
+				btrfs_dev_stat_inc_and_print(stripe->dev,
 						BTRFS_DEV_STAT_READ_ERRS);
 			if (bio->bi_opf & REQ_PREFLUSH)
-				btrfs_dev_stat_inc_and_print(dev,
+				btrfs_dev_stat_inc_and_print(stripe->dev,
 						BTRFS_DEV_STAT_FLUSH_ERRS);
 		}
 	}
@@ -6714,14 +6712,16 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
 	}
 
 	if (clone) {
-		bio = btrfs_bio_clone(dev->bdev, orig_bio);
+		bio = bio_alloc_clone(dev->bdev, orig_bio, GFP_NOFS,
+				      &fs_bio_set);
 	} else {
 		bio = orig_bio;
 		bio_set_dev(bio, dev->bdev);
+		btrfs_bio(bio)->device = dev;
 	}
 
-	bio->bi_private = bioc;
-	btrfs_bio(bio)->device = dev;
+	bioc->stripes[dev_nr].bioc = bioc;
+	bio->bi_private = &bioc->stripes[dev_nr];
 	bio->bi_end_io = btrfs_end_bio;
 	bio->bi_iter.bi_sector = physical >> 9;
 	/*
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 28e28b7c48649..825e44c82f2b0 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -396,7 +396,10 @@ static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)
 
 struct btrfs_io_stripe {
 	struct btrfs_device *dev;
-	u64 physical;
+	union {
+		u64 physical;			/* block mapping */
+		struct btrfs_io_context *bioc;	/* for the endio handler */
+	};
 	u64 length; /* only used for discard mappings */
 };
 
-- 
2.30.2

