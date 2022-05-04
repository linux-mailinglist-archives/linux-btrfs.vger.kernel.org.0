Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193EA519F45
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 14:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349414AbiEDM3R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 08:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349438AbiEDM3L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 08:29:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CC12664
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 05:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gJP+YbY3PIl8c3kRm3l8b4Vu3M4DoKDLe+Puz5KFXkk=; b=JUMzggwRm8RSSqdqK71Fd8Kqku
        gpF+eY6TSq1xZTUs4YzgY3HzII4qOp9Ao4YNwx3AywdZ+9BlgGiV6R5m6tDMIFRUh/zIPb5Zi/na6
        J1llwjcTnUhRXOE4OYaXdNXOG8HYdO2VW9ib5OqXxjVSmTlVf2wvJs/SADfg6gP7uQK03hMVumTw7
        D1+9WpKT8817IXonKAiQI4i81eJVFBhwEe6glUsZRL266Ami53Agaih0W3P41XD/TQhvLfb4q9L1Q
        0pBVHt5y/Tl4hIaRvGMfv/YmBFWgfP7uTY9n0rxjNutxiPdCp7z4QYMr5g/YXajp3KIJLuPQENV6g
        smITH0vA==;
Received: from [8.34.116.185] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmE4T-00AhoO-Cg; Wed, 04 May 2022 12:25:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/10] btrfs: do not allocate a btrfs_bio for low-level bios
Date:   Wed,  4 May 2022 05:25:24 -0700
Message-Id: <20220504122524.558088-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220504122524.558088-1-hch@lst.de>
References: <20220504122524.558088-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 93191771e5bf1..7efbc964585d3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3210,19 +3210,6 @@ struct bio *btrfs_bio_alloc(unsigned int nr_iovecs)
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
index 17674b7e699c6..ce69a4732f718 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -248,7 +248,6 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 
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

