Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3174153330
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 15:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBEOim (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 09:38:42 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34709 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgBEOil (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Feb 2020 09:38:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580913522; x=1612449522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4XmU7DnFA5F5WMG30kokJMLVAtAX/4N6K9p/+pblNvo=;
  b=owS853EVviV3AyqbxvfRAFcVNTIDkt5e3QKajzn65m/y/WfT/vqsWu09
   5PPOlpTeOSD3QeyIZG0plamcNiAdGd943qUOCJqfUjsrpXJWnNyoVSV7Q
   /7LCVctuWz6LIeqFAYUge4PvYJqtXmB2Z+VML3YIDWaZWw63No+2Lq8Hz
   tCBTNdbNF5jbb7qr98KfxEz1Vlq5d8ZINkwdGOsgwLzCqT5XjqLXzcLIx
   BxfIED+0f4he9TxOobukzG8jZ367S4I2ipKKV8qv5ChrdfqYhzYuBbNMm
   F6LFs8H/gc8kiZSc5YWuVnOzJevOhOas7KvLreZDNooK9oJvJvCQBp0Qk
   Q==;
IronPort-SDR: R+G8mL7m08OwS+IMZyy+x9hsJeF/sKOdPDK25puzc/qkzZuMv7aUP75y564OyMyAd5zAth/t4I
 gXs4NLLdLh26SsT3pEf4bCBSBUoZfszzOz1c3IDi/nGwEm+oYJ8BMEUtqYEJ4clpYGoI2l+pzw
 oCrx8HZPux5f0CVpIxwV3mxcEElWbHQ8HJ2Uw5vU5EPcWrDuKZYMcSJVNRKEDMOOBP0Wfmm9lX
 HKvAZj1fqCIVUlmPSQo80UNFiCRzDHYM103J+GiVxnqRcw9QodFYMMDwbXkiQ3sjpmOlDVfuDt
 QUI=
X-IronPort-AV: E=Sophos;i="5.70,405,1574092800"; 
   d="scan'208";a="133512049"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 22:38:41 +0800
IronPort-SDR: Kcr/yFO1cXxpYeyXWAn9zooaBBzwG30hDhrwHoSAocHhQV7pG5or3tWJqRsXIi8lkAeb12ZiNH
 RHMRLzRX/mZltjsD61jxSvUwaOGVVIniqGX9J/aZCsG3WJQLDyiLeteTbaMTik4zA18NQAgrLb
 TWFHt6S0drEKL6Aw1qGDbF1h3PyIF9kSQ/FV0Ovh06pPvP9ZgqhgS/QS1tsC+3kfSITGqk7md+
 t2qiGQr8aIdiAoZv+aoiT5Yjmt4NBu7IumtkabFjyhpz+1eA0v9fZPK9WeDwCSFZ0YGVGIM1HF
 wII280Be2TdLgdHYUy0XeiUP
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 06:31:42 -0800
IronPort-SDR: 64NRK41bCjSSw7rV1Ki8crvMl/sPkLDDvo4F0OziQkadkXj9jV0VtFvSSKv6Solx3HCfwpPpHi
 KWIQhf0KytSakdW5Bf/Bodmk5NegONy22lD7kfbIEyh46rFNmhDmIYwzdUrPivB48QfzIz2kPK
 T+QPYRNOTJ1KzYvoUJC7LIuJ2swus5eu0X6tCEv34C5d9Pv9f8vFYzSWP62R4cVBBCLUpoelxw
 I20HGcRYlQXU66awFOQPkM7iZ8Umwy09pP8SvdGBVnwBv6hKDEbQGD9d88s7Bdn4SEZG3GDhfP
 gPI=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Feb 2020 06:38:40 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 4/5] btrfs: remove buffer_heads from btrfsic_process_written_block()
Date:   Wed,  5 Feb 2020 23:38:30 +0900
Message-Id: <20200205143831.13959-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205143831.13959-1-johannes.thumshirn@wdc.com>
References: <20200205143831.13959-1-johannes.thumshirn@wdc.com>
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
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

