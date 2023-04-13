Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056886E069B
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Apr 2023 07:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjDMF5r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Apr 2023 01:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjDMF5p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Apr 2023 01:57:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE417D9E
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 22:57:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7D2F5218DF
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Apr 2023 05:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681365458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TWjqzxCLVJICsrrIlCUEyDL7sxV7eMQFQTjvw3vMsos=;
        b=rGbiusAhwo4BPl+8pjZSx4kTzgpycPYA7Xw20Hb82rpz8oOrhzCTM/Qc9vFxKGpU8WJMhI
        xRQRvxA9k0JoRaVSOdoyJ14r0n8L8RF3lUu6R9oj4Dj4GzTUtm/7c7nSqP5gHq318i1RJl
        D7y5NZ2aIDOnOdnShCDVp0MRTMuLips=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0E371390E
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Apr 2023 05:57:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MD6TK9GZN2QxVgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Apr 2023 05:57:37 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: scrub: use recovered data stripes as cache to avoid unnecessary read
Date:   Thu, 13 Apr 2023 13:57:18 +0800
Message-Id: <1675f1e5f2db78438437366901e3f114ff035dfc.1681364951.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681364951.git.wqu@suse.com>
References: <cover.1681364951.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For P/Q stripe scrub, we have quite some duplicated read IO:

- Data stripes read for verification
  This is triggered by the scrub_submit_initial_read() inside
  scrub_raid56_parity_stripe().

- Data stripes read (again) for P/Q stripe verification
  This is triggered by scrub_assemble_read_bios() from scrub_rbio().

  Although we can have hit rbio cache and avoid unnecessary read, the
  chance is very low, as scrub would easily flush the whole rbio cache.

This means, even we're just scrubing a single P/Q stripe, we would read
the data stripes twice for the best case scenario.
If we need to recover some data stripes, it would cause more reads on
the same data stripes, again and again.

However before we call raid56_parity_submit_scrub_rbio() we already
have all data stripes repaired and their contents ready to use.
But RAID56 cache is unaware about the scrub cache, thus RAID56 layer
itself still needs to re-read the data stripes.

To avoid such cache miss, this patch would:

- Introduce a new helper, raid56_parity_cache_data_pages()
  This function would grab the pages from an array, and copy the content
  to the rbio, marking all the involved sectors uptodate.

  The page copy is unavoidable because of the cache pages of rbio are all
  self managed, thus can not utilize outside pages without screwing up
  the lifespan.

- Use the repaired data stripes as cache inside
  scrub_raid56_parity_stripe()

By this, we ensure all the data sectors of the scrub rbio are already
uptodate, and no need to read them again from disk.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid56.h |  3 +++
 fs/btrfs/scrub.c  |  7 +++++++
 3 files changed, 56 insertions(+)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 2fab37f062de..eaa96e8b3f10 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2747,3 +2747,49 @@ void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio)
 	if (!lock_stripe_add(rbio))
 		start_async_work(rbio, scrub_rbio_work_locked);
 }
+
+/*
+ * This is for scrub call sites where we already have correct data contents.
+ * This allows us to avoid reading data stripes again.
+ *
+ * Unfortunately here we have to do page copy, other than reusing the pages.
+ * This is due to the fact rbio has its own page management for its cache.
+ */
+void raid56_parity_cache_data_pages(struct btrfs_raid_bio *rbio,
+				    struct page **data_pages, u64 data_logical)
+{
+	const u64 offset_in_full_stripe = data_logical -
+					  rbio->bioc->full_stripe_logical;
+	const int page_index = offset_in_full_stripe >> PAGE_SHIFT;
+	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
+	const u32 sectors_per_page = PAGE_SIZE / sectorsize;
+	int ret;
+
+	/*
+	 * If we hit ENOMEM temporarily, but later at
+	 * raid56_parity_submit_scrub_rbio() time it succeeded, we just do
+	 * the extra read, not a big deal.
+	 *
+	 * If we hit ENOMEM later at raid56_parity_submit_scrub_rbio() time,
+	 * the bio would got proper error number set.
+	 */
+	ret = alloc_rbio_data_pages(rbio);
+	if (ret < 0)
+		return;
+
+	/* @data_logical must be at stripe boundary and inside the full stripe. */
+	ASSERT(IS_ALIGNED(offset_in_full_stripe, BTRFS_STRIPE_LEN));
+	ASSERT(offset_in_full_stripe < (rbio->nr_data << BTRFS_STRIPE_LEN_SHIFT));
+
+	for (int page_nr = 0; page_nr < (BTRFS_STRIPE_LEN >> PAGE_SHIFT);
+	     page_nr++) {
+		struct page *dst = rbio->stripe_pages[page_nr + page_index];
+		struct page *src = data_pages[page_nr];
+
+		memcpy_page(dst, 0, src, 0, PAGE_SIZE);
+		for (int sector_nr = sectors_per_page * page_index;
+		     sector_nr < sectors_per_page * (page_index + 1);
+		     sector_nr++)
+			rbio->stripe_sectors[sector_nr].uptodate = true;
+	}
+}
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 0f7f31c8cb98..0e84c9c9293f 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -193,6 +193,9 @@ struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 				unsigned long *dbitmap, int stripe_nsectors);
 void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio);
 
+void raid56_parity_cache_data_pages(struct btrfs_raid_bio *rbio,
+				    struct page **data_pages, u64 data_logical);
+
 int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info);
 void btrfs_free_stripe_hash_table(struct btrfs_fs_info *info);
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 22ce3a628eb5..33c49a563986 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1944,6 +1944,13 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 		btrfs_bio_counter_dec(fs_info);
 		goto out;
 	}
+	/* Use the recovered stripes as cache to avoid read them from disk again. */
+	for (int i = 0; i < data_stripes; i++) {
+		stripe = &sctx->raid56_data_stripes[i];
+
+		raid56_parity_cache_data_pages(rbio, stripe->pages,
+				full_stripe_start + (i << BTRFS_STRIPE_LEN_SHIFT));
+	}
 	raid56_parity_submit_scrub_rbio(rbio);
 	wait_for_completion_io(&io_done);
 	ret = blk_status_to_errno(bio->bi_status);
-- 
2.39.2

