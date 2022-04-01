Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495914EEC5B
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 13:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345514AbiDALZ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 07:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345503AbiDALZx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 07:25:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE2119609B
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 04:24:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0238521A98
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648812242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=StDy/z0BZqJm0VTj8n01xBviGQNKzP0BQBpjkJPBJgE=;
        b=WJAoArqLDIhznXc+X8WSLxgOiBWm6AtRj0Zpc5RmLkhdOxN7k5orJeSBaIaMdUIlYRRSxq
        JaL71PawRo6SL5xwx38WMOZRkzCk9hezsObn09ush6l8ecVlUPDJOUZauK4/w3aPxTaaDG
        ILpNFYIolerMZYEG6s/FK1PgwDxKT1c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B623132C1
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:24:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QLq5CtHgRmJeFwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Apr 2022 11:24:01 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 12/16] btrfs: remove btrfs_raid_bio::bio_pages array
Date:   Fri,  1 Apr 2022 19:23:27 +0800
Message-Id: <fae22a3feb6936f1987b91783adc71bc256602b2.1648807440.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648807440.git.wqu@suse.com>
References: <cover.1648807440.git.wqu@suse.com>
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
 fs/btrfs/raid56.c | 43 +++----------------------------------------
 1 file changed, 3 insertions(+), 40 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 74e246f4758e..b45f63b40131 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -179,9 +179,6 @@ struct btrfs_raid_bio {
 	/* Pointers to the sectors in the bio_list, for faster lookup */
 	struct sector_ptr *bio_sectors;
 
-	/* Pointers to the pages in the bio_list, for faster lookup */
-	struct page **bio_pages;
-
 	/*
 	 * For subpage support, we need to map each sector to above
 	 * stripe_pages.
@@ -263,7 +260,7 @@ int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info)
 
 /*
  * caching an rbio means to copy anything from the
- * bio_pages array into the stripe_pages array.  We
+ * bio_sectors array into the stripe_pages array.  We
  * use the page uptodate bit in the stripe cache array
  * to indicate if it has valid data
  *
@@ -279,18 +276,6 @@ static void cache_rbio_pages(struct btrfs_raid_bio *rbio)
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
-	/*
-	 * TODO: This work is duplicated with above loop, should remove above
-	 * loop when the switch is fully done.
-	 */
 	for (i = 0; i < rbio->nr_sectors; i++) {
 		/* Some range not covered by bio (partial write), skip it */
 		if (!rbio->bio_sectors[i].page)
@@ -1067,7 +1052,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	atomic_set(&rbio->stripes_pending, 0);
 
 	/*
-	 * the stripe_pages, bio_pages, etc arrays point to the extra
+	 * the stripe_pages, bio_sectors, etc arrays point to the extra
 	 * memory we allocated past the end of the rbio
 	 */
 	p = rbio + 1;
@@ -1076,7 +1061,6 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 		p = (unsigned char *)p + sizeof(*(ptr)) * (count);	\
 	} while (0)
 	CONSUME_ALLOC(rbio->stripe_pages, num_pages);
-	CONSUME_ALLOC(rbio->bio_pages, num_pages);
 	CONSUME_ALLOC(rbio->bio_sectors, num_sectors);
 	CONSUME_ALLOC(rbio->stripe_sectors, num_sectors);
 	CONSUME_ALLOC(rbio->finish_pointers, real_stripes);
@@ -1250,7 +1234,7 @@ static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio)
 }
 
 /*
- * helper function to walk our bio list and populate the bio_pages array with
+ * Helper function to walk our bio list and populate the bio_sectors array with
  * the result.  This seems expensive, but it is faster than constantly
  * searching through the bio list as we setup the IO in finish_rmw or stripe
  * reconstruction.
@@ -1260,29 +1244,8 @@ static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio)
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
-		if (bio_flagged(bio, BIO_CLONED))
-			bio->bi_iter = btrfs_bio(bio)->iter;
-
-		bio_for_each_segment(bvec, bio, iter) {
-			rbio->bio_pages[page_index + i] = bvec.bv_page;
-			i++;
-		}
-	}
-	/* TODO: This loop will replace above loop when the full switch is done */
 	bio_list_for_each(bio, &rbio->bio_list)
 		index_one_bio(rbio, bio);
 
-- 
2.35.1

