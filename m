Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C83A66547D
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 07:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjAKGYN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 01:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbjAKGYB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 01:24:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D556811452
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 22:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Y2zEdlTCC6Hcz+nhwF+QEzelXoB7TewsWzyIR5GV64k=; b=1mTLNe69/I9JOLogX/iA8CL4Gg
        7qwVE+BMK07SNWJmh90W2JDuEmMs0KoQJGvvUGo2DtqMg9sR8LCcYj2lMAxCR2ZhbPjYhjfOEA99Z
        NzHOlZ1o6HB37mH7SbJZkjinT5CVzzOXyadqThZhN+73yfPZPrs3eG+AsQ6fOP4Jchlr6YJdo3rfv
        BROZQi0BHgp9uQniE4PNAHSRuEoIuDdb0ZpubY3C1gtYeFJMFQ6x8JZruOb1rXqCH0eOmBHLcLIhE
        PbI+He/FMWf1fy/r4/DGDfLJO+MJATjcGLBg2tMAbmm9/pmPEPSqQkWz3vRawieUdTLrBenofLxsc
        JjJljvtw==;
Received: from [2001:4bb8:181:656b:8732:62ba:c286:a05b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFUWb-009rBQ-Si; Wed, 11 Jan 2023 06:23:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 05/10] btrfs: fold recover_assemble_read_bios into recover_rbio
Date:   Wed, 11 Jan 2023 07:23:29 +0100
Message-Id: <20230111062335.1023353-6-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230111062335.1023353-1-hch@lst.de>
References: <20230111062335.1023353-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is very little extra code in recover_rbio, and a large part of it
is the superflous extra cleanup of the bio list.  Merge the two
functions, and only clean up the bio list after it has been added to
but before it has been emptied again by submit_read_wait_bio_list.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 61 ++++++++++++++++-------------------------------
 1 file changed, 21 insertions(+), 40 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 666d634f0ba2c1..4e983ca8cd532c 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1940,13 +1940,25 @@ static int recover_sectors(struct btrfs_raid_bio *rbio)
 	return ret;
 }
 
-static int recover_assemble_read_bios(struct btrfs_raid_bio *rbio,
-				      struct bio_list *bio_list)
+static int recover_rbio(struct btrfs_raid_bio *rbio)
 {
+	struct bio_list bio_list = BIO_EMPTY_LIST;
 	int total_sector_nr;
 	int ret = 0;
 
-	ASSERT(bio_list_size(bio_list) == 0);
+	/*
+	 * Either we're doing recover for a read failure or degraded write,
+	 * caller should have set error bitmap correctly.
+	 */
+	ASSERT(bitmap_weight(rbio->error_bitmap, rbio->nr_sectors));
+
+	/* For recovery, we need to read all sectors including P/Q. */
+	ret = alloc_rbio_pages(rbio);
+	if (ret < 0)
+		return ret;
+
+	index_rbio_pages(rbio);
+
 	/*
 	 * Read everything that hasn't failed. However this time we will
 	 * not trust any cached sector.
@@ -1977,47 +1989,16 @@ static int recover_assemble_read_bios(struct btrfs_raid_bio *rbio,
 		}
 
 		sector = rbio_stripe_sector(rbio, stripe, sectornr);
-		ret = rbio_add_io_sector(rbio, bio_list, sector, stripe,
+		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
 					 sectornr, REQ_OP_READ);
-		if (ret < 0)
-			goto error;
+		if (ret < 0) {
+			bio_list_put(&bio_list);
+			return ret;
+		}
 	}
-	return 0;
-error:
-	bio_list_put(bio_list);
-	return -EIO;
-}
-
-static int recover_rbio(struct btrfs_raid_bio *rbio)
-{
-	struct bio_list bio_list;
-	int ret;
-
-	/*
-	 * Either we're doing recover for a read failure or degraded write,
-	 * caller should have set error bitmap correctly.
-	 */
-	ASSERT(bitmap_weight(rbio->error_bitmap, rbio->nr_sectors));
-	bio_list_init(&bio_list);
-
-	/* For recovery, we need to read all sectors including P/Q. */
-	ret = alloc_rbio_pages(rbio);
-	if (ret < 0)
-		goto out;
-
-	index_rbio_pages(rbio);
-
-	ret = recover_assemble_read_bios(rbio, &bio_list);
-	if (ret < 0)
-		goto out;
 
 	submit_read_wait_bio_list(rbio, &bio_list);
-
-	ret = recover_sectors(rbio);
-
-out:
-	bio_list_put(&bio_list);
-	return ret;
+	return recover_sectors(rbio);
 }
 
 static void recover_rbio_work(struct work_struct *work)
-- 
2.35.1

