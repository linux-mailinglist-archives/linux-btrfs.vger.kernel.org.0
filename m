Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2864F8D7B
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 08:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiDHFLJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 01:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbiDHFLH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 01:11:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB9023B3D5
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Apr 2022 22:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wQDnPvUklJ/9wwN9GPdS7bBkV4qoMQg2piTutqn3mG8=; b=q42LZ/Qp0tzNGPnVUBiUAsEKrN
        ZPWdysU8sN9RZ/M+Prc+Y6YN57tMOVmINJEfnb5cBagKp/r9aiIVvzfAJtv6F1AK3XhOu07HEk/Hr
        r3SH6fPv1q+4Di98zlSz3pfwUSwlxmCHT7qC+UaGsQ9rvN45v8Dik6IzYvv5Mmjy3IQwBTxkkgXJA
        kwKVYLz7Q+DhL2dWRu4peE8H57cUKWodtzV3Qx16VrwYRNMmlwJlbQbr6cbn3waPTD//pSPZD7d82
        NdxEIHSdIjjSSGsMS/jeO4afFd20GCgPeozkxgFhg5y2j4mIcKwlFOWq/Yzqw/g8vTpOD1ksfIXuf
        qnDbD7Bg==;
Received: from 213-225-37-164.nat.highway.a1.net ([213.225.37.164] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncgrm-00F177-PQ; Fri, 08 Apr 2022 05:09:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 06/12] btrfs: simplify scrub_repair_page_from_good_copy
Date:   Fri,  8 Apr 2022 07:08:33 +0200
Message-Id: <20220408050839.239113-7-hch@lst.de>
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

The I/O in repair_io_failue is synchronous and doesn't need a btrfs_bio,
so just use an on-stack bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 3790747c449b0..fe25a0d3d7c2d 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1538,7 +1538,8 @@ static int scrub_repair_sector_from_good_copy(struct scrub_block *sblock_bad,
 	BUG_ON(sector_good->page == NULL);
 	if (force_write || sblock_bad->header_error ||
 	    sblock_bad->checksum_error || sector_bad->io_error) {
-		struct bio *bio;
+		struct bio_vec bvec;
+		struct bio bio;
 		int ret;
 
 		if (!sector_bad->dev->bdev) {
@@ -1547,26 +1548,20 @@ static int scrub_repair_sector_from_good_copy(struct scrub_block *sblock_bad,
 			return -EIO;
 		}
 
-		bio = btrfs_bio_alloc(1);
-		bio_set_dev(bio, sector_bad->dev->bdev);
-		bio->bi_iter.bi_sector = sector_bad->physical >> 9;
-		bio->bi_opf = REQ_OP_WRITE;
+		bio_init(&bio, sector_bad->dev->bdev, &bvec, 1, REQ_OP_WRITE);
+		bio.bi_iter.bi_sector = sector_bad->physical >> 9;
+		__bio_add_page(&bio, sector_good->page, sectorsize, 0);
 
-		ret = bio_add_page(bio, sector_good->page, sectorsize, 0);
-		if (ret != sectorsize) {
-			bio_put(bio);
-			return -EIO;
-		}
+		btrfsic_check_bio(&bio);
+		ret = submit_bio_wait(&bio);
+		bio_uninit(&bio);
 
-		btrfsic_check_bio(bio);
-		if (submit_bio_wait(bio)) {
+		if (ret) {
 			btrfs_dev_stat_inc_and_print(sector_bad->dev,
 				BTRFS_DEV_STAT_WRITE_ERRS);
 			atomic64_inc(&fs_info->dev_replace.num_write_errors);
-			bio_put(bio);
 			return -EIO;
 		}
-		bio_put(bio);
 	}
 
 	return 0;
-- 
2.30.2

