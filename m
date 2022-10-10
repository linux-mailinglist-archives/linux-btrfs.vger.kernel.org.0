Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADA45F9CDB
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 12:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiJJKgl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 06:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiJJKgj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 06:36:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9448D57BE2
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 03:36:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3D44B21940
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665398194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r5/clrjTZZfXEKWd0IO2WuWpGPGy+9O4bPpb10A5IHg=;
        b=K9lL2WMsxwmyOC3y4KCtdIjIOHY79ceq0/45nijb4P7HVZ+vp0uh9dl7CJ5rIwWEVpAhIY
        4iY+Y0BbtsfdeBveVaYZclmUyveuYqK7obtqpGqD0y62QnrqLQjqrImX1w6Q6l01ttZ8zn
        W06PAz1tQEuOCZecWzJgF8DOsyaR0o8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 815C513ACA
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:36:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +B2rEbH1Q2M9LgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:36:33 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs: raid56: make it more explicit that cache rbio should have all its data sectors uptodate
Date:   Mon, 10 Oct 2022 18:36:10 +0800
Message-Id: <8fda749e551df0f1c06c8e6a7d05b82a51170de4.1665397731.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665397731.git.wqu@suse.com>
References: <cover.1665397731.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For Btrfs RAID56, we have a caching system for btrfs raid bios (rbio).

We call cache_rbio_pages() to mark a qualified rbio ready for cache.

The timing happens at:

- finish_rmw()

  At this timing, we have already read all necessary sectors, along with
  the rbio sectors, we have covered all data stripes.

- __raid_recover_end_io()

  At this timing, we have rebuild the rbio, thus all data sectors
  involved (either from stripe or bio list) are uptodate now.

Thus at the timing of cache_rbio_pages(), we should have all data
sectors uptodate.

This patch will make it explicit that all data sectors are uptodate at
cache_rbio_pages() timing, mostly to prepare for the incoming
verification at RMW time.

This patch will add:

- Extra ASSERT()s in cache_rbio_pages()
  This is to make sure all data sectors, which are not covered by bio,
  are already uptodate.

- Extra ASSERT()s in steal_rbio()
  Since only cached rbio can be stolen, thus every data sector should
  already be uptodate in the source rbio.

- Update __raid_recover_end_io() to update recovered sector->uptodate
  Previously __raid_recover_end_io() will only mark failed sectors
  uptodate if it's doing an RMW.

  But this can trigger new ASSERT()s, as for recovery case, a recovered
  failed sector will not be marked uptodate, and trigger ASSERT() in
  later cache_rbio_pages() call.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 70 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 4ec211a58f15..c009c0a2081e 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -176,8 +176,16 @@ static void cache_rbio_pages(struct btrfs_raid_bio *rbio)
 
 	for (i = 0; i < rbio->nr_sectors; i++) {
 		/* Some range not covered by bio (partial write), skip it */
-		if (!rbio->bio_sectors[i].page)
+		if (!rbio->bio_sectors[i].page) {
+			/*
+			 * Even if the sector is not covered by bio, if it is
+			 * a data sector it should still be uptodate as it is
+			 * read from disk.
+			 */
+			if (i < rbio->nr_data * rbio->stripe_nsectors)
+				ASSERT(rbio->stripe_sectors[i].uptodate);
 			continue;
+		}
 
 		ASSERT(rbio->stripe_sectors[i].page);
 		memcpy_page(rbio->stripe_sectors[i].page,
@@ -264,6 +272,21 @@ static void steal_rbio_page(struct btrfs_raid_bio *src,
 		dest->stripe_sectors[i].uptodate = true;
 }
 
+static bool is_data_stripe_page(struct btrfs_raid_bio *rbio, int page_nr)
+{
+	const int sector_nr = (page_nr << PAGE_SHIFT) >>
+			      rbio->bioc->fs_info->sectorsize_bits;
+
+	/*
+	 * We have ensured PAGE_SIZE is aligned with sectorsize, thus
+	 * we won't have a page which is half data half parity.
+	 *
+	 * Thus if the first sector of the page belongs to data stripes, then
+	 * the full page belongs to data stripes.
+	 */
+	return (sector_nr < rbio->nr_data * rbio->stripe_nsectors);
+}
+
 /*
  * Stealing an rbio means taking all the uptodate pages from the stripe array
  * in the source rbio and putting them into the destination rbio.
@@ -274,16 +297,26 @@ static void steal_rbio_page(struct btrfs_raid_bio *src,
 static void steal_rbio(struct btrfs_raid_bio *src, struct btrfs_raid_bio *dest)
 {
 	int i;
-	struct page *s;
 
 	if (!test_bit(RBIO_CACHE_READY_BIT, &src->flags))
 		return;
 
 	for (i = 0; i < dest->nr_pages; i++) {
-		s = src->stripe_pages[i];
-		if (!s || !full_page_sectors_uptodate(src, i))
+		struct page *p = src->stripe_pages[i];
+
+		/*
+		 * We don't need to steal P/Q pages as they will always be
+		 * regenerated for RMW or full write anyway.
+		 */
+		if (!is_data_stripe_page(src, i))
 			continue;
 
+		/*
+		 * If @src already has RBIO_CACHE_READY_BIT, it should have
+		 * all data stripe pages present and uptodate.
+		 */
+		ASSERT(p);
+		ASSERT(full_page_sectors_uptodate(src, i));
 		steal_rbio_page(src, dest, i);
 	}
 	index_stripe_sectors(dest);
@@ -2003,22 +2036,21 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 			/* xor in the rest */
 			run_xor(pointers, rbio->nr_data - 1, sectorsize);
 		}
-		/* if we're doing this rebuild as part of an rmw, go through
-		 * and set all of our private rbio pages in the
-		 * failed stripes as uptodate.  This way finish_rmw will
-		 * know they can be trusted.  If this was a read reconstruction,
-		 * other endio functions will fiddle the uptodate bits
+
+		/*
+		 * No matter if this is a RMW or recovery, we should have all
+		 * failed sectors repaired, thus they are now uptodate.
+		 * Especially if we determine to cache the rbio, we need to
+		 * have at least all data sectors uptodate.
 		 */
-		if (rbio->operation == BTRFS_RBIO_WRITE) {
-			for (i = 0;  i < rbio->stripe_nsectors; i++) {
-				if (faila != -1) {
-					sector = rbio_stripe_sector(rbio, faila, i);
-					sector->uptodate = 1;
-				}
-				if (failb != -1) {
-					sector = rbio_stripe_sector(rbio, failb, i);
-					sector->uptodate = 1;
-				}
+		for (i = 0;  i < rbio->stripe_nsectors; i++) {
+			if (faila != -1) {
+				sector = rbio_stripe_sector(rbio, faila, i);
+				sector->uptodate = 1;
+			}
+			if (failb != -1) {
+				sector = rbio_stripe_sector(rbio, failb, i);
+				sector->uptodate = 1;
 			}
 		}
 		for (stripe = rbio->real_stripes - 1; stripe >= 0; stripe--)
-- 
2.37.3

