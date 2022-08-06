Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32A958B470
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Aug 2022 10:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbiHFIEC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Aug 2022 04:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiHFID5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Aug 2022 04:03:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CA813E1C
        for <linux-btrfs@vger.kernel.org>; Sat,  6 Aug 2022 01:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7CuF7TZF3UQnTLgwSagp7RkyQCLscz9Iej/wBS7Yt5E=; b=2EhC8blomIOnY6jVPpA3X4rYRw
        66KCs7YkOIssMwth8wLybM8MVQEgjtoNKN9GVEcvvncKPKlgz9Ott1bKkApYfqmYTtPBKzk/Dh6di
        CTdrFogMscxDrkYkaG559kJhqClMF2DgS+8JSgZRoHt4swpf8jdRr3BbJ8378LfraWULGplyx1wH7
        YFnQk9H6S5tyOmaefenH/XOo8KKzaglga/IVbojOaUs7T79s9dn0VMoKCx5LvFX6iSRPPlj70+8BT
        kGXAX7gkjMxqzqtec9xSdUEanHIKJYpo/OEA6JP3nx5Bh6MrZVg9oqy/cl518Vhxa6N182GIPEFtA
        4Bd2cmNw==;
Received: from [2001:4bb8:192:6d54:4997:d9fe:27ec:4c3c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKEmm-006LuL-Pz; Sat, 06 Aug 2022 08:03:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 08/11] btrfs: split submit_stripe_bio
Date:   Sat,  6 Aug 2022 10:03:27 +0200
Message-Id: <20220806080330.3823644-9-hch@lst.de>
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

Split out a low-level btrfs_submit_dev_bio helper that just submits
the bio without any cloning decisions or setting up the end I/O handler
for future reuse by a different caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 51 +++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7c8f84ff659ea..5c5beb789594d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6743,28 +6743,8 @@ static void btrfs_clone_write_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-static void submit_stripe_bio(struct btrfs_io_context *bioc,
-			      struct bio *orig_bio, int dev_nr, bool clone)
+static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 {
-	struct btrfs_fs_info *fs_info = bioc->fs_info;
-	struct btrfs_device *dev = bioc->stripes[dev_nr].dev;
-	u64 physical = bioc->stripes[dev_nr].physical;
-	struct bio *bio;
-
-	if (clone) {
-		bio = bio_alloc_clone(NULL, orig_bio, GFP_NOFS, &fs_bio_set);
-		bio_inc_remaining(orig_bio);
-		bio->bi_end_io = btrfs_clone_write_end_io;
-	} else {
-		bio = orig_bio;
-		btrfs_bio(bio)->device = dev;
-		bio->bi_end_io = btrfs_end_bio;
-	}
-
-	bioc->stripes[dev_nr].bioc = bioc;
-	bio->bi_private = &bioc->stripes[dev_nr];
-	bio->bi_iter.bi_sector = physical >> 9;
-
 	if (!dev || !dev->bdev ||
 	    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
 	    (btrfs_op(bio) == BTRFS_MAP_WRITE &&
@@ -6780,8 +6760,11 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
 	 * zone
 	 */
 	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		u64 physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
+
 		if (btrfs_dev_is_sequential(dev, physical)) {
-			u64 zone_start = round_down(physical, fs_info->zone_size);
+			u64 zone_start = round_down(physical,
+						    dev->fs_info->zone_size);
 
 			bio->bi_iter.bi_sector = zone_start >> SECTOR_SHIFT;
 		} else {
@@ -6789,7 +6772,7 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
 			bio->bi_opf |= REQ_OP_WRITE;
 		}
 	}
-	btrfs_debug_in_rcu(fs_info,
+	btrfs_debug_in_rcu(dev->fs_info,
 	"%s: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
 		__func__, bio_op(bio), bio->bi_opf, bio->bi_iter.bi_sector,
 		(unsigned long)dev->bdev->bd_dev, rcu_str_deref(dev->name),
@@ -6799,6 +6782,28 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
 	submit_bio(bio);
 }
 
+static void submit_stripe_bio(struct btrfs_io_context *bioc,
+			      struct bio *orig_bio, int dev_nr, bool clone)
+{
+	struct bio *bio;
+
+	/* Reuse the bio embedded into the btrfs_bio for the last mirror */
+	if (!clone) {
+		bio = orig_bio;
+		btrfs_bio(bio)->device = bioc->stripes[dev_nr].dev;
+		bio->bi_end_io = btrfs_end_bio;
+	} else {
+		bio = bio_alloc_clone(NULL, orig_bio, GFP_NOFS, &fs_bio_set);
+		bio_inc_remaining(orig_bio);
+		bio->bi_end_io = btrfs_clone_write_end_io;
+	}
+
+	bio->bi_private = &bioc->stripes[dev_nr];
+	bio->bi_iter.bi_sector = bioc->stripes[dev_nr].physical >> SECTOR_SHIFT;
+	bioc->stripes[dev_nr].bioc = bioc;
+	btrfs_submit_dev_bio(bioc->stripes[dev_nr].dev, bio);
+}
+
 void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror_num)
 {
 	u64 logical = bio->bi_iter.bi_sector << 9;
-- 
2.30.2

