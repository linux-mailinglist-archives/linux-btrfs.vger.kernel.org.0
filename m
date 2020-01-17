Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07ACC140A2A
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 13:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgAQMvQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 07:51:16 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51283 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgAQMvP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 07:51:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579265474; x=1610801474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EneM6WceyRrMsFpB6DnTbMPZ+dkv9q8AsWLcEvey984=;
  b=fEHNyF5i2GrR/NYC3KIylmvLw3FSIKDc1CKnsl/ZHDnkn9Sgf8EyWu8d
   nwHejSj1g1aBbJab/qXEeJ68tBCKr+vrzAa5JQ7fGTys48/x5lM9MT7Ew
   aBhlRa3ZOno5tjZ45Z/FqFoyZyHUmnVDLy74w8eE2NyHxeSPLXYU2F4IJ
   zL2YvHvZ+1ieFKWBAw4OWR5Lv5WIJVT2N2Rrv9bslfyZuSmiw/SMPYJJC
   REid+1Xbvweusuv/PPhLUBI95VfrAN1rhTLrY8Gzi13HEOrLvMYthc7a9
   grhYxL/s6jhKSbV3Mcouk8MGn9UynUfby95s5TNA5eILp9hmHM86QdLTU
   A==;
IronPort-SDR: iDsAajKqkWV4uT4IPTvT2VdOlYoLXfMJ1QmeAJGcyDSA22TXcm3mYUfyl4h3sg3e9+8O/Tm/qs
 zDrYmhr/VJ08xLxgUnaxz2V21eyWbEr51XLpHxbgqFRalV865QkjTsB31MSXfDjxVUgiR4Gyoe
 TZesXkcmdG/jSI3aAdrtagv+b7gSgG+z/bCkaa4RQt82xrjEQTCBuphZcwE6Nidw6CIfVaS889
 yL53FaEevtIIl5zfSpJNxHELctNrsQ6lfwNa9W8q5Oz4duLdtMJ4X1f27NUPSiFcobAhiS84gZ
 yn8=
X-IronPort-AV: E=Sophos;i="5.70,330,1574092800"; 
   d="scan'208";a="235550983"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2020 20:51:14 +0800
IronPort-SDR: y0inL0dQAuBMGz08JHtN1c3H24xQ/NPefPkWkTK7b4uQNaYgbQFpfoPTf5OP4bDttrH+N/KIqc
 zoqD7u8pU3Wau0nD5St8SQbiXkCt4wbAU2Fc0AviHM5McCtIR9V+mdb5dugnNO51/ZJeoZ4la7
 hkEElmnvnYZ9SMRqPo8D4KvBw0v2F4x9xOcxMEeYVceLKAecA6Hqfle91efcvZYKpLLO06slBY
 YJdu7mW5mA5TmRQQgohWMHrGVJuBeUKAmZ7/g/P41AgLo9ZI27rXRddTeyPeBDy6iRCybByYz9
 BJ/eJNE1FcBHZweqWY2OkMWR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 04:44:47 -0800
IronPort-SDR: /2jW+7iu6nTikyU2ZX24jU7pLaP2HrlAFtaAvzJruIPLujqwXGWo6j8h07f5ROOb3vAwVgaHqb
 To5/U9Ln2xW06B9HqpfMiPGPxoZgA+6Cu53nKcvHDV6s4rvuM3ssQaQ8WnRnqGE6KidVKxrQyJ
 Ci8bLVbg8SUVlC3ByuGxwzld2VzBDeBOwncq708rMA7eFGJI3HSBrDsToTFAD3EmU/aXD6HOWI
 Accbge9Bpp+cSHDsmsfWhntAVqNe9UwtJAX6zFgPpOhSDaSDbq/CoQ3GHm9bDMAmRnhx12Ki/k
 PzU=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jan 2020 04:51:14 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 4/5] btrfs: remove buffer_heads from btrfsic_process_written_block()
Date:   Fri, 17 Jan 2020 21:51:04 +0900
Message-Id: <20200117125105.20989-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117125105.20989-1-johannes.thumshirn@wdc.com>
References: <20200117125105.20989-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that the last caller of btrfsic_process_written_block() with
buffer_heads is gone, remove the buffer_head processing path from it as
well.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/check-integrity.c | 103 +++++++++----------------------------
 1 file changed, 25 insertions(+), 78 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index e7507985435e..4f6db2fe482a 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -152,11 +152,8 @@ struct btrfsic_block {
 	struct list_head ref_to_list;	/* list */
 	struct list_head ref_from_list;	/* list */
 	struct btrfsic_block *next_in_same_bio;
-	void *orig_bio_bh_private;
-	union {
-		bio_end_io_t *bio;
-		bh_end_io_t *bh;
-	} orig_bio_bh_end_io;
+	void *orig_bio_private;
+	bio_end_io_t *orig_bio_end_io;
 	int submit_bio_bh_rw;
 	u64 flush_gen; /* only valid if !never_written */
 };
@@ -325,14 +322,12 @@ static void btrfsic_process_written_block(struct btrfsic_dev_state *dev_state,
 					  u64 dev_bytenr, char **mapped_datav,
 					  unsigned int num_pages,
 					  struct bio *bio, int *bio_is_patched,
-					  struct buffer_head *bh,
 					  int submit_bio_bh_rw);
 static int btrfsic_process_written_superblock(
 		struct btrfsic_state *state,
 		struct btrfsic_block *const block,
 		struct btrfs_super_block *const super_hdr);
 static void btrfsic_bio_end_io(struct bio *bp);
-static void btrfsic_bh_end_io(struct buffer_head *bh, int uptodate);
 static int btrfsic_is_block_ref_by_superblock(const struct btrfsic_state *state,
 					      const struct btrfsic_block *block,
 					      int recursion_level);
@@ -399,8 +394,8 @@ static void btrfsic_block_init(struct btrfsic_block *b)
 	b->never_written = 0;
 	b->mirror_num = 0;
 	b->next_in_same_bio = NULL;
-	b->orig_bio_bh_private = NULL;
-	b->orig_bio_bh_end_io.bio = NULL;
+	b->orig_bio_private = NULL;
+	b->orig_bio_end_io = NULL;
 	INIT_LIST_HEAD(&b->collision_resolving_node);
 	INIT_LIST_HEAD(&b->all_blocks_node);
 	INIT_LIST_HEAD(&b->ref_to_list);
@@ -1743,7 +1738,6 @@ static void btrfsic_process_written_block(struct btrfsic_dev_state *dev_state,
 					  u64 dev_bytenr, char **mapped_datav,
 					  unsigned int num_pages,
 					  struct bio *bio, int *bio_is_patched,
-					  struct buffer_head *bh,
 					  int submit_bio_bh_rw)
 {
 	int is_metadata;
@@ -1902,9 +1896,9 @@ static void btrfsic_process_written_block(struct btrfsic_dev_state *dev_state,
 				block->is_iodone = 0;
 				BUG_ON(NULL == bio_is_patched);
 				if (!*bio_is_patched) {
-					block->orig_bio_bh_private =
+					block->orig_bio_private =
 					    bio->bi_private;
-					block->orig_bio_bh_end_io.bio =
+					block->orig_bio_end_io =
 					    bio->bi_end_io;
 					block->next_in_same_bio = NULL;
 					bio->bi_private = block;
@@ -1916,25 +1910,17 @@ static void btrfsic_process_written_block(struct btrfsic_dev_state *dev_state,
 					    bio->bi_private;
 
 					BUG_ON(NULL == chained_block);
-					block->orig_bio_bh_private =
-					    chained_block->orig_bio_bh_private;
-					block->orig_bio_bh_end_io.bio =
-					    chained_block->orig_bio_bh_end_io.
-					    bio;
+					block->orig_bio_private =
+					    chained_block->orig_bio_private;
+					block->orig_bio_end_io =
+					    chained_block->orig_bio_end_io;
 					block->next_in_same_bio = chained_block;
 					bio->bi_private = block;
 				}
-			} else if (NULL != bh) {
-				block->is_iodone = 0;
-				block->orig_bio_bh_private = bh->b_private;
-				block->orig_bio_bh_end_io.bh = bh->b_end_io;
-				block->next_in_same_bio = NULL;
-				bh->b_private = block;
-				bh->b_end_io = btrfsic_bh_end_io;
 			} else {
 				block->is_iodone = 1;
-				block->orig_bio_bh_private = NULL;
-				block->orig_bio_bh_end_io.bio = NULL;
+				block->orig_bio_private = NULL;
+				block->orig_bio_end_io = NULL;
 				block->next_in_same_bio = NULL;
 			}
 		}
@@ -2042,8 +2028,8 @@ static void btrfsic_process_written_block(struct btrfsic_dev_state *dev_state,
 			block->is_iodone = 0;
 			BUG_ON(NULL == bio_is_patched);
 			if (!*bio_is_patched) {
-				block->orig_bio_bh_private = bio->bi_private;
-				block->orig_bio_bh_end_io.bio = bio->bi_end_io;
+				block->orig_bio_private = bio->bi_private;
+				block->orig_bio_end_io = bio->bi_end_io;
 				block->next_in_same_bio = NULL;
 				bio->bi_private = block;
 				bio->bi_end_io = btrfsic_bio_end_io;
@@ -2054,24 +2040,17 @@ static void btrfsic_process_written_block(struct btrfsic_dev_state *dev_state,
 				    bio->bi_private;
 
 				BUG_ON(NULL == chained_block);
-				block->orig_bio_bh_private =
-				    chained_block->orig_bio_bh_private;
-				block->orig_bio_bh_end_io.bio =
-				    chained_block->orig_bio_bh_end_io.bio;
+				block->orig_bio_private =
+				    chained_block->orig_bio_private;
+				block->orig_bio_end_io =
+				    chained_block->orig_bio_end_io;
 				block->next_in_same_bio = chained_block;
 				bio->bi_private = block;
 			}
-		} else if (NULL != bh) {
-			block->is_iodone = 0;
-			block->orig_bio_bh_private = bh->b_private;
-			block->orig_bio_bh_end_io.bh = bh->b_end_io;
-			block->next_in_same_bio = NULL;
-			bh->b_private = block;
-			bh->b_end_io = btrfsic_bh_end_io;
 		} else {
 			block->is_iodone = 1;
-			block->orig_bio_bh_private = NULL;
-			block->orig_bio_bh_end_io.bio = NULL;
+			block->orig_bio_private = NULL;
+			block->orig_bio_end_io = NULL;
 			block->next_in_same_bio = NULL;
 		}
 		if (state->print_mask & BTRFSIC_PRINT_MASK_VERBOSE)
@@ -2112,8 +2091,8 @@ static void btrfsic_bio_end_io(struct bio *bp)
 		iodone_w_error = 1;
 
 	BUG_ON(NULL == block);
-	bp->bi_private = block->orig_bio_bh_private;
-	bp->bi_end_io = block->orig_bio_bh_end_io.bio;
+	bp->bi_private = block->orig_bio_private;
+	bp->bi_end_io = block->orig_bio_end_io;
 
 	do {
 		struct btrfsic_block *next_block;
@@ -2146,38 +2125,6 @@ static void btrfsic_bio_end_io(struct bio *bp)
 	bp->bi_end_io(bp);
 }
 
-static void btrfsic_bh_end_io(struct buffer_head *bh, int uptodate)
-{
-	struct btrfsic_block *block = (struct btrfsic_block *)bh->b_private;
-	int iodone_w_error = !uptodate;
-	struct btrfsic_dev_state *dev_state;
-
-	BUG_ON(NULL == block);
-	dev_state = block->dev_state;
-	if ((dev_state->state->print_mask & BTRFSIC_PRINT_MASK_END_IO_BIO_BH))
-		pr_info("bh_end_io(error=%d) for %c @%llu (%s/%llu/%d)\n",
-		       iodone_w_error,
-		       btrfsic_get_block_type(dev_state->state, block),
-		       block->logical_bytenr, block->dev_state->name,
-		       block->dev_bytenr, block->mirror_num);
-
-	block->iodone_w_error = iodone_w_error;
-	if (block->submit_bio_bh_rw & REQ_PREFLUSH) {
-		dev_state->last_flush_gen++;
-		if ((dev_state->state->print_mask &
-		     BTRFSIC_PRINT_MASK_END_IO_BIO_BH))
-			pr_info("bh_end_io() new %s flush_gen=%llu\n",
-			       dev_state->name, dev_state->last_flush_gen);
-	}
-	if (block->submit_bio_bh_rw & REQ_FUA)
-		block->flush_gen = 0; /* FUA completed means block is on disk */
-
-	bh->b_private = block->orig_bio_bh_private;
-	bh->b_end_io = block->orig_bio_bh_end_io.bh;
-	block->is_iodone = 1; /* for FLUSH, this releases the block */
-	bh->b_end_io(bh, uptodate);
-}
-
 static int btrfsic_process_written_superblock(
 		struct btrfsic_state *state,
 		struct btrfsic_block *const superblock,
@@ -2781,7 +2728,7 @@ static void __btrfsic_submit_bio(struct bio *bio)
 		btrfsic_process_written_block(dev_state, dev_bytenr,
 					      mapped_datav, segs,
 					      bio, &bio_is_patched,
-					      NULL, bio->bi_opf);
+					      bio->bi_opf);
 		bio_for_each_segment(bvec, bio, iter)
 			kunmap(bvec.bv_page);
 		kfree(mapped_datav);
@@ -2805,8 +2752,8 @@ static void __btrfsic_submit_bio(struct bio *bio)
 			block->iodone_w_error = 0;
 			block->flush_gen = dev_state->last_flush_gen + 1;
 			block->submit_bio_bh_rw = bio->bi_opf;
-			block->orig_bio_bh_private = bio->bi_private;
-			block->orig_bio_bh_end_io.bio = bio->bi_end_io;
+			block->orig_bio_private = bio->bi_private;
+			block->orig_bio_end_io = bio->bi_end_io;
 			block->next_in_same_bio = NULL;
 			bio->bi_private = block;
 			bio->bi_end_io = btrfsic_bio_end_io;
-- 
2.24.1

