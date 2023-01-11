Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D767665481
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 07:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjAKGYN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 01:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjAKGYD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 01:24:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF6D11807
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 22:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zXPJ5+UjTkIW0+tP+iLoBQK0vOgtC/27soKXZbcECBw=; b=P7gWZtCPBuEj3iTjMLt/c30M0f
        ZA/RKicuaZe7MayRd3Gf5slO+4+SoOiCAhfEART6TOOlssR8UU8QUPIb4ir/p+HrAEIpDIDojnPVO
        3pveRv3wIMFAdzgVn+y81L0iQHzbKAfXxbxcOci6R7GMKnbdyY7KFCMtWwIRI0c/euoEtDMPsyMVV
        lJ24U9apQ9lv9VMzx32Ls5H6T9kPpOa27HwR7oB5CEGD+J76NpjCdpNqOL94aEq/HmgJz3jOK2P3O
        J74kEEuJB31UDGBA4+Icd7gr7W8IFUqlIGBYUgvhbBq0LUlQGddh1aHHWXd8EMHQ3B/iwrQA3HNeh
        sRNkmKKg==;
Received: from [2001:4bb8:181:656b:8732:62ba:c286:a05b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFUWe-009rBl-Er; Wed, 11 Jan 2023 06:23:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 06/10] btrfs: fold rmw_read_wait_recover into rmw_read_bios
Date:   Wed, 11 Jan 2023 07:23:30 +0100
Message-Id: <20230111062335.1023353-7-hch@lst.de>
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

There is very little extra code in rmw_read_bios, and a large part of it
is the superflous extra cleanup of the bio list.  Merge the two
functions, and only clean up the bio list after it has been added to
but before it has been emptied again by submit_read_wait_bio_list.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 70 ++++++++++++++++-------------------------------
 1 file changed, 24 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 4e983ca8cd532c..88404a6b0b98e7 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1517,39 +1517,6 @@ static void submit_read_wait_bio_list(struct btrfs_raid_bio *rbio,
 	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
 }
 
-static int rmw_assemble_read_bios(struct btrfs_raid_bio *rbio,
-				  struct bio_list *bio_list)
-{
-	int total_sector_nr;
-	int ret = 0;
-
-	ASSERT(bio_list_size(bio_list) == 0);
-
-	/*
-	 * Build a list of bios to read all sectors (including data and P/Q).
-	 *
-	 * This behaviro is to compensate the later csum verification and
-	 * recovery.
-	 */
-	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
-	     total_sector_nr++) {
-		struct sector_ptr *sector;
-		int stripe = total_sector_nr / rbio->stripe_nsectors;
-		int sectornr = total_sector_nr % rbio->stripe_nsectors;
-
-		sector = rbio_stripe_sector(rbio, stripe, sectornr);
-		ret = rbio_add_io_sector(rbio, bio_list, sector,
-			       stripe, sectornr, REQ_OP_READ);
-		if (ret)
-			goto cleanup;
-	}
-	return 0;
-
-cleanup:
-	bio_list_put(bio_list);
-	return ret;
-}
-
 static int alloc_rbio_data_pages(struct btrfs_raid_bio *rbio)
 {
 	const int data_pages = rbio->nr_data * rbio->stripe_npages;
@@ -2169,10 +2136,9 @@ static void fill_data_csums(struct btrfs_raid_bio *rbio)
 
 static int rmw_read_wait_recover(struct btrfs_raid_bio *rbio)
 {
-	struct bio_list bio_list;
-	int ret;
-
-	bio_list_init(&bio_list);
+	struct bio_list bio_list = BIO_EMPTY_LIST;
+	int total_sector_nr;
+	int ret = 0;
 
 	/*
 	 * Fill the data csums we need for data verification.  We need to fill
@@ -2181,21 +2147,33 @@ static int rmw_read_wait_recover(struct btrfs_raid_bio *rbio)
 	 */
 	fill_data_csums(rbio);
 
-	ret = rmw_assemble_read_bios(rbio, &bio_list);
-	if (ret < 0)
-		goto out;
+	/*
+	 * Build a list of bios to read all sectors (including data and P/Q).
+	 *
+	 * This behaviro is to compensate the later csum verification and
+	 * recovery.
+	 */
+	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
+	     total_sector_nr++) {
+		struct sector_ptr *sector;
+		int stripe = total_sector_nr / rbio->stripe_nsectors;
+		int sectornr = total_sector_nr % rbio->stripe_nsectors;
 
-	submit_read_wait_bio_list(rbio, &bio_list);
+		sector = rbio_stripe_sector(rbio, stripe, sectornr);
+		ret = rbio_add_io_sector(rbio, &bio_list, sector,
+			       stripe, sectornr, REQ_OP_READ);
+		if (ret) {
+			bio_list_put(&bio_list);
+			return ret;
+		}
+	}
 
 	/*
 	 * We may or may not have any corrupted sectors (including missing dev
 	 * and csum mismatch), just let recover_sectors() to handle them all.
 	 */
-	ret = recover_sectors(rbio);
-	return ret;
-out:
-	bio_list_put(&bio_list);
-	return ret;
+	submit_read_wait_bio_list(rbio, &bio_list);
+	return recover_sectors(rbio);
 }
 
 static void raid_wait_write_end_io(struct bio *bio)
-- 
2.35.1

