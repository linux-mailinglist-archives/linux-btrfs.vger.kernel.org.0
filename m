Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B094F8E28
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 08:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbiDHFKy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 01:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbiDHFKw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 01:10:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8365ED918
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Apr 2022 22:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UQp+aqzRArP6L62IKY7G6CCEWxYsDX1jjrdZwoUgYJ8=; b=YZ4p4n1yJsdkvpoHpxjCa5psW5
        l1p6gYfzYIc44NomRm8zbvzSeXZBBdWP/NTlc0aZe0xEDI+XrzWA70cHujR+sOIrBMLknRT08a5AU
        vHcvi+aL3WzybcDlnUusG+LUsIcFF2Sep/FX9mhceYG4xBamGlrDhO4RXna8TYYKMw5aaj8rmdm4L
        0OmHDNwrCeGGlm/nzaDRxlA5Xo1uKvsh5hp/zcRAHeSV1y9gzoHrDoy1wU5TReZHm+aKvTuY9Jpt8
        9Bh5fkDXezQV2vPQ7Fpwf0o96bNcZYUHZdza7JVIgfN4c6VQLGFjhM41JgzXMLUfkUQSciXoBy0Pk
        MK1SW9MA==;
Received: from 213-225-37-164.nat.highway.a1.net ([213.225.37.164] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncgrW-00F13O-2W; Fri, 08 Apr 2022 05:08:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 01/12] btrfs: refactor __btrfsic_submit_bio
Date:   Fri,  8 Apr 2022 07:08:28 +0200
Message-Id: <20220408050839.239113-2-hch@lst.de>
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

Split out two helpers to mak __btrfsic_submit_bio more readable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/check-integrity.c | 150 +++++++++++++++++++------------------
 1 file changed, 78 insertions(+), 72 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index b8f9dfa326207..ec8a73ff82717 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -2633,6 +2633,74 @@ static struct btrfsic_dev_state *btrfsic_dev_state_lookup(dev_t dev)
 						  &btrfsic_dev_state_hashtable);
 }
 
+static void btrfsic_check_write_bio(struct bio *bio,
+		struct btrfsic_dev_state *dev_state)
+{
+	unsigned int segs = bio_segments(bio);
+	u64 dev_bytenr = 512 * bio->bi_iter.bi_sector;
+	u64 cur_bytenr = dev_bytenr;
+	struct bvec_iter iter;
+	struct bio_vec bvec;
+	char **mapped_datav;
+	int bio_is_patched = 0;
+	int i = 0;
+
+	if (dev_state->state->print_mask & BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH)
+		pr_info("submit_bio(rw=%d,0x%x, bi_vcnt=%u, bi_sector=%llu (bytenr %llu), bi_bdev=%p)\n",
+		       bio_op(bio), bio->bi_opf, segs,
+		       bio->bi_iter.bi_sector, dev_bytenr, bio->bi_bdev);
+
+	mapped_datav = kmalloc_array(segs, sizeof(*mapped_datav), GFP_NOFS);
+	if (!mapped_datav)
+		return;
+
+	bio_for_each_segment(bvec, bio, iter) {
+		BUG_ON(bvec.bv_len != PAGE_SIZE);
+		mapped_datav[i] = page_address(bvec.bv_page);
+		i++;
+
+		if (dev_state->state->print_mask &
+		    BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH_VERBOSE)
+			pr_info("#%u: bytenr=%llu, len=%u, offset=%u\n",
+			       i, cur_bytenr, bvec.bv_len, bvec.bv_offset);
+		cur_bytenr += bvec.bv_len;
+	}
+
+	btrfsic_process_written_block(dev_state, dev_bytenr, mapped_datav, segs,
+				      bio, &bio_is_patched, bio->bi_opf);
+	kfree(mapped_datav);
+}
+
+static void btrfsic_check_flush_bio(struct bio *bio,
+		struct btrfsic_dev_state *dev_state)
+{
+	if (dev_state->state->print_mask & BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH)
+		pr_info("submit_bio(rw=%d,0x%x FLUSH, bdev=%p)\n",
+		       bio_op(bio), bio->bi_opf, bio->bi_bdev);
+
+	if (dev_state->dummy_block_for_bio_bh_flush.is_iodone) {
+		struct btrfsic_block *const block =
+			&dev_state->dummy_block_for_bio_bh_flush;
+
+		block->is_iodone = 0;
+		block->never_written = 0;
+		block->iodone_w_error = 0;
+		block->flush_gen = dev_state->last_flush_gen + 1;
+		block->submit_bio_bh_rw = bio->bi_opf;
+		block->orig_bio_private = bio->bi_private;
+		block->orig_bio_end_io = bio->bi_end_io;
+		block->next_in_same_bio = NULL;
+		bio->bi_private = block;
+		bio->bi_end_io = btrfsic_bio_end_io;
+	} else if ((dev_state->state->print_mask &
+		   (BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH |
+		    BTRFSIC_PRINT_MASK_VERBOSE))) {
+		pr_info(
+"btrfsic_submit_bio(%pg) with FLUSH but dummy block already in use (ignored)!\n",
+		       dev_state->bdev);
+	}
+}
+
 static void __btrfsic_submit_bio(struct bio *bio)
 {
 	struct btrfsic_dev_state *dev_state;
@@ -2640,80 +2708,18 @@ static void __btrfsic_submit_bio(struct bio *bio)
 	if (!btrfsic_is_initialized)
 		return;
 
-	mutex_lock(&btrfsic_mutex);
-	/* since btrfsic_submit_bio() is also called before
-	 * btrfsic_mount(), this might return NULL */
+	/*
+	 * We can be called before btrfsic_mount, so there might not be a
+	 * dev_state.
+	 */
 	dev_state = btrfsic_dev_state_lookup(bio->bi_bdev->bd_dev);
-	if (NULL != dev_state &&
-	    (bio_op(bio) == REQ_OP_WRITE) && bio_has_data(bio)) {
-		int i = 0;
-		u64 dev_bytenr;
-		u64 cur_bytenr;
-		struct bio_vec bvec;
-		struct bvec_iter iter;
-		int bio_is_patched;
-		char **mapped_datav;
-		unsigned int segs = bio_segments(bio);
-
-		dev_bytenr = 512 * bio->bi_iter.bi_sector;
-		bio_is_patched = 0;
-		if (dev_state->state->print_mask &
-		    BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH)
-			pr_info("submit_bio(rw=%d,0x%x, bi_vcnt=%u, bi_sector=%llu (bytenr %llu), bi_bdev=%p)\n",
-			       bio_op(bio), bio->bi_opf, segs,
-			       bio->bi_iter.bi_sector, dev_bytenr, bio->bi_bdev);
-
-		mapped_datav = kmalloc_array(segs,
-					     sizeof(*mapped_datav), GFP_NOFS);
-		if (!mapped_datav)
-			goto leave;
-		cur_bytenr = dev_bytenr;
-
-		bio_for_each_segment(bvec, bio, iter) {
-			BUG_ON(bvec.bv_len != PAGE_SIZE);
-			mapped_datav[i] = page_address(bvec.bv_page);
-			i++;
-
-			if (dev_state->state->print_mask &
-			    BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH_VERBOSE)
-				pr_info("#%u: bytenr=%llu, len=%u, offset=%u\n",
-				       i, cur_bytenr, bvec.bv_len, bvec.bv_offset);
-			cur_bytenr += bvec.bv_len;
-		}
-		btrfsic_process_written_block(dev_state, dev_bytenr,
-					      mapped_datav, segs,
-					      bio, &bio_is_patched,
-					      bio->bi_opf);
-		kfree(mapped_datav);
-	} else if (NULL != dev_state && (bio->bi_opf & REQ_PREFLUSH)) {
-		if (dev_state->state->print_mask &
-		    BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH)
-			pr_info("submit_bio(rw=%d,0x%x FLUSH, bdev=%p)\n",
-			       bio_op(bio), bio->bi_opf, bio->bi_bdev);
-		if (!dev_state->dummy_block_for_bio_bh_flush.is_iodone) {
-			if ((dev_state->state->print_mask &
-			     (BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH |
-			      BTRFSIC_PRINT_MASK_VERBOSE)))
-				pr_info(
-"btrfsic_submit_bio(%pg) with FLUSH but dummy block already in use (ignored)!\n",
-				       dev_state->bdev);
-		} else {
-			struct btrfsic_block *const block =
-				&dev_state->dummy_block_for_bio_bh_flush;
-
-			block->is_iodone = 0;
-			block->never_written = 0;
-			block->iodone_w_error = 0;
-			block->flush_gen = dev_state->last_flush_gen + 1;
-			block->submit_bio_bh_rw = bio->bi_opf;
-			block->orig_bio_private = bio->bi_private;
-			block->orig_bio_end_io = bio->bi_end_io;
-			block->next_in_same_bio = NULL;
-			bio->bi_private = block;
-			bio->bi_end_io = btrfsic_bio_end_io;
-		}
+	mutex_lock(&btrfsic_mutex);
+	if (dev_state) {
+		if (bio_op(bio) == REQ_OP_WRITE && bio_has_data(bio))
+			btrfsic_check_write_bio(bio, dev_state);
+		else if (bio->bi_opf & REQ_PREFLUSH)
+			btrfsic_check_flush_bio(bio, dev_state);
 	}
-leave:
 	mutex_unlock(&btrfsic_mutex);
 }
 
-- 
2.30.2

