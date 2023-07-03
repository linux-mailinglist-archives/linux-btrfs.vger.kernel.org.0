Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4A8745623
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 09:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjGCHdU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 03:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjGCHdP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 03:33:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190D1E64
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 00:33:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B3E9A1F8AC
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688369580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zRX1CFK6Lwh8rCfC0lbbKXIi/8mlmCJ2MZKyvM6jBxI=;
        b=h0LcnMtQI5BPXr/82Vxsku4QDATeTrgQzuv7xWJsNE76Cm2I3PwOet3MIXTytHnJ5IdJ/a
        4uo5bUuaaJciy0yTK5ilkfXl82DTvD5dU8f34HPdAS67FtxgOYBDrOAueUya9wZx/3RkF7
        nRV81EVW/jg7QpFdId6BD7LJIrO151U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A6AE13276
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:32:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sAXxMKt5omRoVQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jul 2023 07:32:59 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/14] btrfs: raid56: allow caching P/Q stripes
Date:   Mon,  3 Jul 2023 15:32:27 +0800
Message-ID: <04691a8119ab8612a3f3bc4b003f44dcb189be86.1688368617.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688368617.git.wqu@suse.com>
References: <cover.1688368617.git.wqu@suse.com>
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

Currently raid56_parity_cache_scrub_pages() only allows to cache data
stripes, as the only scrub call site is only going to scrub P/Q stripes.

But later we want to use cached pages to do recovery, thus we need to
cache P/Q stripes.

This patch would do the following changes to allow such new ability by:

- Rename the function to raid56_parity_cache_pages()

- Use @stripe_num to indicate where the cached stripe is

- Change the ASSERT() to allow P/Q stripes to be cached

- Introduce a new member, btrfs_raid_bio::cached, to allow recovery path
  to use cached pages

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 43 ++++++++++++++++++++++++++++++-------------
 fs/btrfs/raid56.h | 12 +++++++++---
 fs/btrfs/scrub.c  |  3 +--
 3 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index d96bfc3a16fc..b2eb7e60a137 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1932,11 +1932,10 @@ static void recover_rbio(struct btrfs_raid_bio *rbio)
 
 	/*
 	 * Read everything that hasn't failed. However this time we will
-	 * not trust any cached sector.
+	 * not trust any cached sector, unless it's explicitly required.
+	 *
 	 * As we may read out some stale data but higher layer is not reading
 	 * that stale part.
-	 *
-	 * So here we always re-read everything in recovery path.
 	 */
 	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
 	     total_sector_nr++) {
@@ -1960,6 +1959,14 @@ static void recover_rbio(struct btrfs_raid_bio *rbio)
 		}
 
 		sector = rbio_stripe_sector(rbio, stripe, sectornr);
+
+		/*
+		 * If we're forced to use cache and the sector is already cached,
+		 * then we can skip this sector.
+		 * Otherwise we should still read from disk.
+		 */
+		if (rbio->cached && sector->uptodate)
+			continue;
 		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
 					 sectornr, REQ_OP_READ);
 		if (ret < 0) {
@@ -2765,22 +2772,32 @@ void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio)
 }
 
 /*
- * This is for scrub call sites where we already have correct data contents.
- * This allows us to avoid reading data stripes again.
+ * This is for scrub call sites where we already have correct stripe contents.
+ * This allows us to avoid reading on-disk stripes again.
  *
  * Unfortunately here we have to do page copy, other than reusing the pages.
  * This is due to the fact rbio has its own page management for its cache.
+ * But this is also a good thing for recovery tries, this prevents the recovery
+ * path to modify the stripes until we've verified the recovered data.
+ *
+ * @rbio:	The allocated rbio by raid56_parity_alloc_*_rbio()
+ * @pages:	The pages which contains the stripe contents.
+ * @stripe_num:	The stripe number, 0 means the first data stripe, and
+ *		@rbio->nr_data means the P stripe.
  */
-void raid56_parity_cache_data_pages(struct btrfs_raid_bio *rbio,
-				    struct page **data_pages, u64 data_logical)
+void raid56_parity_cache_pages(struct btrfs_raid_bio *rbio, struct page **pages,
+			       int stripe_num)
 {
-	const u64 offset_in_full_stripe = data_logical -
-					  rbio->bioc->full_stripe_logical;
+	const u64 offset_in_full_stripe = btrfs_stripe_nr_to_offset(stripe_num);
 	const int page_index = offset_in_full_stripe >> PAGE_SHIFT;
 	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
 	const u32 sectors_per_page = PAGE_SIZE / sectorsize;
 	int ret;
 
+	if (stripe_num >= rbio->nr_data)
+		ret = alloc_rbio_parity_pages(rbio);
+	else
+		ret = alloc_rbio_data_pages(rbio);
 	/*
 	 * If we hit ENOMEM temporarily, but later at
 	 * raid56_parity_submit_scrub_rbio() time it succeeded, we just do
@@ -2789,17 +2806,16 @@ void raid56_parity_cache_data_pages(struct btrfs_raid_bio *rbio,
 	 * If we hit ENOMEM later at raid56_parity_submit_scrub_rbio() time,
 	 * the bio would got proper error number set.
 	 */
-	ret = alloc_rbio_data_pages(rbio);
 	if (ret < 0)
 		return;
 
-	/* data_logical must be at stripe boundary and inside the full stripe. */
+	/* The stripe must be at stripe boundary and inside the full stripe. */
 	ASSERT(IS_ALIGNED(offset_in_full_stripe, BTRFS_STRIPE_LEN));
-	ASSERT(offset_in_full_stripe < btrfs_stripe_nr_to_offset(rbio->nr_data));
+	ASSERT(offset_in_full_stripe < btrfs_stripe_nr_to_offset(rbio->real_stripes));
 
 	for (int page_nr = 0; page_nr < (BTRFS_STRIPE_LEN >> PAGE_SHIFT); page_nr++) {
 		struct page *dst = rbio->stripe_pages[page_nr + page_index];
-		struct page *src = data_pages[page_nr];
+		struct page *src = pages[page_nr];
 
 		memcpy_page(dst, 0, src, 0, PAGE_SIZE);
 		for (int sector_nr = sectors_per_page * page_index;
@@ -2807,4 +2823,5 @@ void raid56_parity_cache_data_pages(struct btrfs_raid_bio *rbio,
 		     sector_nr++)
 			rbio->stripe_sectors[sector_nr].uptodate = true;
 	}
+	rbio->cached = true;
 }
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 1871a2a16a1c..41354a9f158a 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -82,6 +82,13 @@ struct btrfs_raid_bio {
 	 */
 	int bio_list_bytes;
 
+	/*
+	 * If this rbio is forced to use cached stripes provided by the caller.
+	 *
+	 * Used by scrub path to reduce IO.
+	 */
+	bool cached;
+
 	refcount_t refs;
 
 	atomic_t stripes_pending;
@@ -191,9 +198,8 @@ struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 				struct btrfs_device *scrub_dev,
 				unsigned long *dbitmap);
 void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio);
-
-void raid56_parity_cache_data_pages(struct btrfs_raid_bio *rbio,
-				    struct page **data_pages, u64 data_logical);
+void raid56_parity_cache_pages(struct btrfs_raid_bio *rbio, struct page **pages,
+			       int stripe_num);
 
 int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info);
 void btrfs_free_stripe_hash_table(struct btrfs_fs_info *info);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 5a0626a3c23c..1864856abb13 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1925,8 +1925,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	for (int i = 0; i < data_stripes; i++) {
 		stripe = &sctx->raid56_data_stripes[i];
 
-		raid56_parity_cache_data_pages(rbio, stripe->pages,
-				full_stripe_start + btrfs_stripe_nr_to_offset(i));
+		raid56_parity_cache_pages(rbio, stripe->pages, i);
 	}
 	raid56_parity_submit_scrub_rbio(rbio);
 	wait_for_completion_io(&io_done);
-- 
2.41.0

