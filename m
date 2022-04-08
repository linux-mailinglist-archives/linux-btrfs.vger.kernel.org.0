Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AFC4F8E66
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 08:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiDHFLP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 01:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbiDHFLN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 01:11:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B8523D475
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Apr 2022 22:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Oifr63Lw4P/2C7KwU/cGEK666Nk5gRV/4ZbkTgvel14=; b=CF0Yrs9RzN7D4F7tZNqcms01qA
        bW7htr9grp5mVwA4hV1QIDjR4Yt+QQODV/ArieOBCndQTBNIZ1esNXMNkQKJndEjuBpQWGlKS/lNy
        XYXZQ8n2xKrpTMnp8TTJUBH3v9JHvF7iGbdFSbcsZHyfZ1/IJnXpz7HT6rpO8P7ZUpy/ysM73O3nv
        9WykUazQWaLyFk7y1vr/+HB0RRkyFW3exuQg6FEXur7+RakRgEzOYbPThwj+FfVPAMO9SOnyoslwG
        ZmSsHg0bDmL9bAqWEygeGuEXTj5JAaWwYP091N1vo1ST44DAUcjLB1oOXICk5gvY6MXw2oCiuQ+gG
        zvXwsbJA==;
Received: from 213-225-37-164.nat.highway.a1.net ([213.225.37.164] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncgrt-00F18i-Dw; Fri, 08 Apr 2022 05:09:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 08/12] btrfs: pass a block_device to btrfs_bio_clone
Date:   Fri,  8 Apr 2022 07:08:35 +0200
Message-Id: <20220408050839.239113-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408050839.239113-1-hch@lst.de>
References: <20220408050839.239113-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Pass the block_device to btrfs_bio_clone so that it can be paased on to
bio_alloc_clone instead of setting it later.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 4 ++--
 fs/btrfs/extent_io.h | 2 +-
 fs/btrfs/volumes.c   | 9 +++++----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ede7a72fe840c..1a5a7ded31758 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3188,13 +3188,13 @@ struct bio *btrfs_bio_alloc(unsigned int nr_iovecs)
 	return bio;
 }
 
-struct bio *btrfs_bio_clone(struct bio *bio)
+struct bio *btrfs_bio_clone(struct block_device *bdev, struct bio *bio)
 {
 	struct btrfs_bio *bbio;
 	struct bio *new;
 
 	/* Bio allocation backed by a bioset does not fail */
-	new = bio_alloc_clone(bio->bi_bdev, bio, GFP_NOFS, &btrfs_bioset);
+	new = bio_alloc_clone(bdev, bio, GFP_NOFS, &btrfs_bioset);
 	bbio = btrfs_bio(new);
 	btrfs_bio_init(bbio);
 	bbio->iter = bio->bi_iter;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 1331902c75815..05253612ce7bb 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -280,7 +280,7 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array);
 struct bio *btrfs_bio_alloc(unsigned int nr_iovecs);
-struct bio *btrfs_bio_clone(struct bio *bio);
+struct bio *btrfs_bio_clone(struct block_device *bdev, struct bio *bio);
 struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
 
 void end_extent_writepage(struct page *page, int err, u64 start, u64 end);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8e066b9ebfbde..2368a2ffbee75 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6824,12 +6824,13 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			continue;
 		}
 
-		if (dev_nr < total_devs - 1)
-			bio = btrfs_bio_clone(first_bio);
-		else
+		if (dev_nr < total_devs - 1) {
+			bio = btrfs_bio_clone(dev->bdev, first_bio);
+		} else {
 			bio = first_bio;
+			bio_set_dev(bio, dev->bdev);
+		}
 
-		bio_set_dev(bio, dev->bdev);
 		submit_stripe_bio(bioc, bio, bioc->stripes[dev_nr].physical, dev);
 	}
 	btrfs_bio_counter_dec(fs_info);
-- 
2.30.2

