Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8824F8E14
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 08:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbiDHFLU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 01:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbiDHFLT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 01:11:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5182414DE
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Apr 2022 22:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=U5zbdWAGHJg3kKc3W4c1kns0IIJKQitI9VA1JUQmduM=; b=J5HBUSoR16AwQtBvjuT+D7Drmj
        eIaySTUmMQD0ER7iSAWfhLvXxcvgVkMyhhUKEgCwdUhcb38yKRuURyBOb+3HtLsKsMORvOWI+kkam
        LCroMNOPolf93Gv/IlQ0M08QBMdGxuC1203hDonjPcCiQBHMwmApR7HBBDZOQ7sonnuAaqOykq3oH
        0H1UmLpJqg5t8cFImDNWuyAbQp2l/Ri/wnMyeuv0wjP2HekK6+OlFpBwXtkk0MQa+l/O3DGmNFk5U
        bfkhLQlR3OXsCbKBql0U6yWIUTwZZOgoWu7wJEqPlNYKelpjDRuqDfWnQeUtwkOrkSoDgDQzPnG/z
        SfOn2Z6w==;
Received: from 213-225-37-164.nat.highway.a1.net ([213.225.37.164] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncgrw-00F19M-P8; Fri, 08 Apr 2022 05:09:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 09/12] btrfs: initialize ->bi_opf and ->bi_private in rbio_add_io_page
Date:   Fri,  8 Apr 2022 07:08:36 +0200
Message-Id: <20220408050839.239113-10-hch@lst.de>
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

Prepare for further refactoring by moving this initialization to a single
place.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index ba6f6be771213..13a998628b90b 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1048,7 +1048,8 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
 			    struct page *page,
 			    int stripe_nr,
 			    unsigned long page_index,
-			    unsigned long bio_max_len)
+			    unsigned long bio_max_len,
+			    unsigned int opf)
 {
 	struct bio *last = bio_list->tail;
 	int ret;
@@ -1085,7 +1086,9 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
 	btrfs_bio(bio)->device = stripe->dev;
 	bio->bi_iter.bi_size = 0;
 	bio_set_dev(bio, stripe->dev->bdev);
+	bio->bi_opf = opf;
 	bio->bi_iter.bi_sector = disk_start >> 9;
+	bio->bi_private = rbio;
 
 	bio_add_page(bio, page, PAGE_SIZE, 0);
 	bio_list_add(bio_list, bio);
@@ -1254,7 +1257,8 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 			}
 
 			ret = rbio_add_io_page(rbio, &bio_list,
-				       page, stripe, pagenr, rbio->stripe_len);
+				       page, stripe, pagenr, rbio->stripe_len,
+				       REQ_OP_WRITE);
 			if (ret)
 				goto cleanup;
 		}
@@ -1279,7 +1283,8 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 
 			ret = rbio_add_io_page(rbio, &bio_list, page,
 					       rbio->bioc->tgtdev_map[stripe],
-					       pagenr, rbio->stripe_len);
+					       pagenr, rbio->stripe_len,
+					       REQ_OP_WRITE);
 			if (ret)
 				goto cleanup;
 		}
@@ -1290,9 +1295,7 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 	BUG_ON(atomic_read(&rbio->stripes_pending) == 0);
 
 	while ((bio = bio_list_pop(&bio_list))) {
-		bio->bi_private = rbio;
 		bio->bi_end_io = raid_write_end_io;
-		bio->bi_opf = REQ_OP_WRITE;
 
 		submit_bio(bio);
 	}
@@ -1496,7 +1499,8 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 				continue;
 
 			ret = rbio_add_io_page(rbio, &bio_list, page,
-				       stripe, pagenr, rbio->stripe_len);
+				       stripe, pagenr, rbio->stripe_len,
+				       REQ_OP_READ);
 			if (ret)
 				goto cleanup;
 		}
@@ -1519,9 +1523,7 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 	 */
 	atomic_set(&rbio->stripes_pending, bios_to_read);
 	while ((bio = bio_list_pop(&bio_list))) {
-		bio->bi_private = rbio;
 		bio->bi_end_io = raid_rmw_end_io;
-		bio->bi_opf = REQ_OP_READ;
 
 		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
 
@@ -2038,7 +2040,8 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 
 			ret = rbio_add_io_page(rbio, &bio_list,
 				       rbio_stripe_page(rbio, stripe, pagenr),
-				       stripe, pagenr, rbio->stripe_len);
+				       stripe, pagenr, rbio->stripe_len,
+				       REQ_OP_READ);
 			if (ret < 0)
 				goto cleanup;
 		}
@@ -2065,9 +2068,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 	 */
 	atomic_set(&rbio->stripes_pending, bios_to_read);
 	while ((bio = bio_list_pop(&bio_list))) {
-		bio->bi_private = rbio;
 		bio->bi_end_io = raid_recover_end_io;
-		bio->bi_opf = REQ_OP_READ;
 
 		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
 
@@ -2398,8 +2399,8 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 		struct page *page;
 
 		page = rbio_stripe_page(rbio, rbio->scrubp, pagenr);
-		ret = rbio_add_io_page(rbio, &bio_list,
-			       page, rbio->scrubp, pagenr, rbio->stripe_len);
+		ret = rbio_add_io_page(rbio, &bio_list, page, rbio->scrubp,
+				       pagenr, rbio->stripe_len, REQ_OP_WRITE);
 		if (ret)
 			goto cleanup;
 	}
@@ -2413,7 +2414,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 		page = rbio_stripe_page(rbio, rbio->scrubp, pagenr);
 		ret = rbio_add_io_page(rbio, &bio_list, page,
 				       bioc->tgtdev_map[rbio->scrubp],
-				       pagenr, rbio->stripe_len);
+				       pagenr, rbio->stripe_len, REQ_OP_WRITE);
 		if (ret)
 			goto cleanup;
 	}
@@ -2429,9 +2430,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 	atomic_set(&rbio->stripes_pending, nr_data);
 
 	while ((bio = bio_list_pop(&bio_list))) {
-		bio->bi_private = rbio;
 		bio->bi_end_io = raid_write_end_io;
-		bio->bi_opf = REQ_OP_WRITE;
 
 		submit_bio(bio);
 	}
@@ -2583,8 +2582,9 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
 			if (PageUptodate(page))
 				continue;
 
-			ret = rbio_add_io_page(rbio, &bio_list, page,
-				       stripe, pagenr, rbio->stripe_len);
+			ret = rbio_add_io_page(rbio, &bio_list, page, stripe,
+					       pagenr, rbio->stripe_len,
+					       REQ_OP_READ);
 			if (ret)
 				goto cleanup;
 		}
@@ -2607,9 +2607,7 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
 	 */
 	atomic_set(&rbio->stripes_pending, bios_to_read);
 	while ((bio = bio_list_pop(&bio_list))) {
-		bio->bi_private = rbio;
 		bio->bi_end_io = raid56_parity_scrub_end_io;
-		bio->bi_opf = REQ_OP_READ;
 
 		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
 
-- 
2.30.2

