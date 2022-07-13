Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAC6572E01
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 08:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbiGMGOY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 02:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiGMGOX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 02:14:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F98C1679
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 23:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=cxe0WHxAqUuF2ONxJHJeqOdaEAMlt0ut0M7sd+vwO0A=; b=S70BpfU4jPBxUV5N6+h1ioraMP
        zGCMYvbYP/S5PwXIuBorXH6R8jX8eZTb2hXojJOMAmjbufj58Cenx10xvNvgy/C63IcJljQWZje6a
        Whoo2MxvUYWFUcURuQQMUC28LHFt5lqdqtkz6FydYyHBfbITi/6kNMHxKVF/37KnPTn9Q3qs3lN4b
        blHaMR16Ud+cZjEfV0jf/EiTUemmKqZXrxdIvbQXTkxzPp/WoXk/i6+dzjCFLDHBCMHstDDH7HTUJ
        1ccUkk8HUQpA9TP+crowCQivoOdVNEmoxcG8JwV1p4e115q70rmQSIJsEOprMue6pyrjpy+CDU7LK
        doD3hKeA==;
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBVdc-000T6y-94; Wed, 13 Jul 2022 06:14:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 08/11] btrfs: split submit_stripe_bio
Date:   Wed, 13 Jul 2022 08:13:56 +0200
Message-Id: <20220713061359.1980118-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713061359.1980118-1-hch@lst.de>
References: <20220713061359.1980118-1-hch@lst.de>
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
---
 fs/btrfs/volumes.c | 51 +++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7e092c69ee70b..d5b6777874e3c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6746,28 +6746,8 @@ static void btrfs_clone_write_end_io(struct bio *bio)
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
@@ -6783,8 +6763,11 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
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
@@ -6792,7 +6775,7 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
 			bio->bi_opf |= REQ_OP_WRITE;
 		}
 	}
-	btrfs_debug_in_rcu(fs_info,
+	btrfs_debug_in_rcu(dev->fs_info,
 	"%s: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
 		__func__, bio_op(bio), bio->bi_opf, bio->bi_iter.bi_sector,
 		(unsigned long)dev->bdev->bd_dev, rcu_str_deref(dev->name),
@@ -6802,6 +6785,28 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
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

