Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2134FDCB1
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Apr 2022 13:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351585AbiDLKiM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Apr 2022 06:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354491AbiDLKdl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Apr 2022 06:33:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2930456439
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 02:33:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D9DC0210EC
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649756020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bk6HnXLQwuKeDK6UBDclm4rT0IUGAeI8LePTjyEOZak=;
        b=V66shsqaatCS/YJyeAJagTVlJbolE6riuouZFCqieF2rjgjaSnHe5pq7GFOzjii4+PCTbo
        DBaF0IaujBXp7LRjLLYhH3gymNK3Hk/r9YyicF8jy7pKJ9LVDbKvkdZiQPMmomc7ED1+tg
        L275e7nMTuxdzEhHRLH3sI88U6ym97k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33FD713A99
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MJ4jO3NHVWI8LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 13/17] btrfs: remove btrfs_raid_bio::bio_pages array
Date:   Tue, 12 Apr 2022 17:33:03 +0800
Message-Id: <18f0ece5263b55c0a373eeaa67404d2dd557d18b.1649753690.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649753690.git.wqu@suse.com>
References: <cover.1649753690.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The functionality is completely replaced by the new bio_sectors member,
now it's time to remove the old member.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 38 +++-----------------------------------
 1 file changed, 3 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 5f89ff3963c2..af8ba1aff682 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -178,12 +178,6 @@ struct btrfs_raid_bio {
 	/* Pointers to the sectors in the bio_list, for faster lookup */
 	struct sector_ptr *bio_sectors;
 
-	/*
-	 * pointers to the pages in the bio_list.  Stored
-	 * here for faster lookup
-	 */
-	struct page **bio_pages;
-
 	/*
 	 * For subpage support, we need to map each sector to above
 	 * stripe_pages.
@@ -265,7 +259,7 @@ int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info)
 
 /*
  * caching an rbio means to copy anything from the
- * bio_pages array into the stripe_pages array.  We
+ * bio_sectors array into the stripe_pages array.  We
  * use the page uptodate bit in the stripe cache array
  * to indicate if it has valid data
  *
@@ -281,14 +275,6 @@ static void cache_rbio_pages(struct btrfs_raid_bio *rbio)
 	if (ret)
 		return;
 
-	for (i = 0; i < rbio->nr_pages; i++) {
-		if (!rbio->bio_pages[i])
-			continue;
-
-		copy_highpage(rbio->stripe_pages[i], rbio->bio_pages[i]);
-		SetPageUptodate(rbio->stripe_pages[i]);
-	}
-
 	for (i = 0; i < rbio->nr_sectors; i++) {
 		/* Some range not covered by bio (partial write), skip it */
 		if (!rbio->bio_sectors[i].page)
@@ -1064,7 +1050,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	atomic_set(&rbio->stripes_pending, 0);
 
 	/*
-	 * the stripe_pages, bio_pages, etc arrays point to the extra
+	 * The stripe_pages, bio_sectors, etc arrays point to the extra
 	 * memory we allocated past the end of the rbio
 	 */
 	p = rbio + 1;
@@ -1073,7 +1059,6 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 		p = (unsigned char *)p + sizeof(*(ptr)) * (count);	\
 	} while (0)
 	CONSUME_ALLOC(rbio->stripe_pages, num_pages);
-	CONSUME_ALLOC(rbio->bio_pages, num_pages);
 	CONSUME_ALLOC(rbio->bio_sectors, num_sectors);
 	CONSUME_ALLOC(rbio->stripe_sectors, num_sectors);
 	CONSUME_ALLOC(rbio->finish_pointers, real_stripes);
@@ -1234,7 +1219,7 @@ static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio)
 }
 
 /*
- * helper function to walk our bio list and populate the bio_pages array with
+ * Helper function to walk our bio list and populate the bio_sectors array with
  * the result.  This seems expensive, but it is faster than constantly
  * searching through the bio list as we setup the IO in finish_rmw or stripe
  * reconstruction.
@@ -1244,25 +1229,8 @@ static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio)
 static void index_rbio_pages(struct btrfs_raid_bio *rbio)
 {
 	struct bio *bio;
-	u64 start;
-	unsigned long stripe_offset;
-	unsigned long page_index;
 
 	spin_lock_irq(&rbio->bio_list_lock);
-	bio_list_for_each(bio, &rbio->bio_list) {
-		struct bio_vec bvec;
-		struct bvec_iter iter;
-		int i = 0;
-
-		start = bio->bi_iter.bi_sector << 9;
-		stripe_offset = start - rbio->bioc->raid_map[0];
-		page_index = stripe_offset >> PAGE_SHIFT;
-
-		bio_for_each_segment(bvec, bio, iter) {
-			rbio->bio_pages[page_index + i] = bvec.bv_page;
-			i++;
-		}
-	}
 	bio_list_for_each(bio, &rbio->bio_list)
 		index_one_bio(rbio, bio);
 
-- 
2.35.1

