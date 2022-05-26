Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E2B534AE1
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 09:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240771AbiEZHhQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 03:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245684AbiEZHhM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 03:37:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E709CF13
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 00:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MIQ9UER/Y0mlsZ1vppb+lvuO8qhRtUQ/YPxT2n/+Sjo=; b=sX5hfEIu3x7Nk3uauxmGZjyOMG
        ztBte4sEAFRBQYcsrC4RMd1bnFUyY8gRXEqlJdD93Wy6HyiN4vf9cGqwiXrmu+Vl1xkq8oNcqRpLo
        uXgtpIDR2TRMEN/uTLZy71k8fdC6tZx40xi/IDIyyTc3jnWzmN80OqN9GFDAMFxcyNN6yZxow4Foh
        NhD5SPtgfexR0ouifbXMdmgFve8WFcaNlp0Dqvz5uq/eK4rx/67+G0QU4nuk81c1TQLQGCTA5QfDU
        q2sNmf0GdI1lzqZrqlCoZ7qpOgYI7G3YYIBPbHlK/MoqnNXhdJCr2ayedmBmNbnM/EMyfDcNaXn27
        BQhRVx6Q==;
Received: from [2001:4bb8:18c:7298:d94:e0f5:2d65:4015] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nu83R-00DpcW-EY; Thu, 26 May 2022 07:37:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/10] btrfs: do not allocate a btrfs_bio for low-level bios
Date:   Thu, 26 May 2022 09:36:42 +0200
Message-Id: <20220526073642.1773373-11-hch@lst.de>
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

The bios submitted from btrfs_map_bio don't really interact with the
rest of btrfs and the only btrfs_bio member actually used in the
low-level bios is the pointer to the btrfs_io_contex used for endio
handler.

Use a union in struct btrfs_io_stripe that allows the endio handler to
find the btrfs_io_context and remove the spurious ->device assignment
so that a plain fs_bio_set bio can be used for the low-level bios
allocated inside btrfs_map_bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 13 -------------
 fs/btrfs/extent_io.h |  1 -
 fs/btrfs/volumes.c   | 20 ++++++++++----------
 fs/btrfs/volumes.h   |  5 ++++-
 4 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cbe04b3decee9..48463705ef0e6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3202,19 +3202,6 @@ struct bio *btrfs_bio_alloc(unsigned int nr_iovecs)
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
index 23d4103c88316..72966cf21961e 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -247,7 +247,6 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array);
 struct bio *btrfs_bio_alloc(unsigned int nr_iovecs);
-struct bio *btrfs_bio_clone(struct block_device *bdev, struct bio *bio);
 struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
 
 void end_extent_writepage(struct page *page, int err, u64 start, u64 end);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bd82735fbfbbe..1954a3e1c93a9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6671,23 +6671,21 @@ static void btrfs_end_bioc(struct btrfs_io_context *bioc, bool async)
 
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
@@ -6719,14 +6717,16 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
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
index 413969430893e..517288d46ecf5 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -412,7 +412,10 @@ static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)
 
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

