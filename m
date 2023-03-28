Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AABA6CCE61
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Mar 2023 01:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjC1X5c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 19:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjC1X50 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 19:57:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741573C38
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 16:57:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 187C31FDA6;
        Tue, 28 Mar 2023 23:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680047803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PIawmMioopduBoTszp6DQ2Vo78HYceAc/HRNgJ7SC18=;
        b=CZ3w1le7afEDZ3t/z/u2+/Jrsgr2EcbJ1KzNsnR+Zh0OLcPRg3T11a1EDZokZFc0LqwnCW
        fu0D7F6WB42b6oF+jnP4+TfKfQT+Qbs0OJ7dAjM04GATiSCI2zZcNSZVnxz3GcYO+7Lxsx
        zklwB7J5xXEuxhkUpDt+TZrdyGFPgcg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55DD413488;
        Tue, 28 Mar 2023 23:56:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4AsyCrp+I2T4eQAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 28 Mar 2023 23:56:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v7 05/13] btrfs: scrub: introduce the structure for new BTRFS_STRIPE_LEN based interface
Date:   Wed, 29 Mar 2023 07:56:12 +0800
Message-Id: <6d487689e311eeec69518a1804f8364bd7ba62b8.1680047473.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680047473.git.wqu@suse.com>
References: <cover.1680047473.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch introduces the following structures:

- scrub_sector_verification
  Contains all the needed info to verify one sector (data or metadata).

- scrub_stripe
  Contains all needed members (mostly bitmap based) to scrub one stripe
  (with a length of BTRFS_STRIPE_LEN).

The basic idea is, we keep the existing per-device scrub behavior, but
merge all the scrub_bio/scrub_bio into one generic structure, and read
the full BTRFS_STRIPE_LEN stripe in the first try.

This means we will read some sectors which is not scrub target, but
that's fine. At dev-replace time we only writeback the utilized and good
sectors, and for read-repair we only writeback the repaired sectors.

With every read submitted in BTRFS_STRIPE_LEN, the need for complex bio
formshaping would be gone.
Although to get the same performance of the old scrub behavior, we would
need to submit the initial read for two stripes at once.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 142 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/scrub.h |   8 +++
 2 files changed, 150 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index e765eb8b8bcf..05ecd1e5c513 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -70,6 +70,94 @@ struct scrub_ctx;
  */
 #define BTRFS_MAX_MIRRORS (4 + 1)
 
+/* Represent one sector and its needed info to verify the content. */
+struct scrub_sector_verification {
+	bool is_metadata;
+
+	union {
+		/*
+		 * Csum pointer for data csum verification.
+		 * Should point to a sector csum inside scrub_stripe::csums.
+		 *
+		 * NULL if this data sector has no csum.
+		 */
+		u8 *csum;
+
+		/*
+		 * Extra info for metadata verification.
+		 * All sectors inside a tree block shares the same
+		 * geneartion.
+		 */
+		u64 generation;
+	};
+};
+
+enum scrub_stripe_flags {
+	/* Set when @mirror_num, @dev, @physical and @logical is set. */
+	SCRUB_STRIPE_FLAG_INITIALIZED,
+
+	/* Set when the read-repair is finished. */
+	SCRUB_STRIPE_FLAG_REPAIR_DONE,
+};
+
+#define SCRUB_STRIPE_PAGES		(BTRFS_STRIPE_LEN / PAGE_SIZE)
+/*
+ * Represent one continuous range with a length of BTRFS_STRIPE_LEN.
+ */
+struct scrub_stripe {
+	struct btrfs_block_group *bg;
+
+	struct page *pages[SCRUB_STRIPE_PAGES];
+	struct scrub_sector_verification *sectors;
+
+	struct btrfs_device *dev;
+	u64 logical;
+	u64 physical;
+
+	u16 mirror_num;
+
+	/* Should be BTRFS_STRIPE_LEN / sectorsize. */
+	u16 nr_sectors;
+
+	atomic_t pending_io;
+	wait_queue_head_t io_wait;
+
+	/*
+	 * Indicates the states of the stripe.
+	 * Bits are defined in scrub_stripe_flags enum.
+	 */
+	unsigned long state;
+
+	/* Indicates which sectors are covered by extent items. */
+	unsigned long extent_sector_bitmap;
+
+	/*
+	 * The errors hit during the initial read of the stripe.
+	 *
+	 * Would be utilized for error reporting and repair.
+	 */
+	unsigned long init_error_bitmap;
+
+	/*
+	 * The following error bitmaps are all for the current status.
+	 * Every time we submit a new read, those bitmaps may be updated.
+	 *
+	 * error_bitmap = io_error_bitmap | csum_error_bitmap | meta_error_bitmap;
+	 *
+	 * IO and csum errors can happen for both metadata and data.
+	 */
+	unsigned long error_bitmap;
+	unsigned long io_error_bitmap;
+	unsigned long csum_error_bitmap;
+	unsigned long meta_error_bitmap;
+
+	/*
+	 * Checksum for the whole stripe if this stripe is inside a data block
+	 * group.
+	 */
+	u8 *csums;
+};
+
 struct scrub_recover {
 	refcount_t		refs;
 	struct btrfs_io_context	*bioc;
@@ -266,6 +354,60 @@ static void detach_scrub_page_private(struct page *page)
 #endif
 }
 
+static void release_scrub_stripe(struct scrub_stripe *stripe)
+{
+	if (!stripe)
+		return;
+
+	for (int i = 0; i < SCRUB_STRIPE_PAGES; i++) {
+		if (stripe->pages[i])
+			__free_page(stripe->pages[i]);
+		stripe->pages[i] = NULL;
+	}
+	kfree(stripe->sectors);
+	kfree(stripe->csums);
+	stripe->sectors = NULL;
+	stripe->csums = NULL;
+	stripe->state = 0;
+}
+
+int init_scrub_stripe(struct btrfs_fs_info *fs_info, struct scrub_stripe *stripe)
+{
+	int ret;
+
+	memset(stripe, 0, sizeof(*stripe));
+
+	stripe->nr_sectors = BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits;
+	stripe->state = 0;
+
+	init_waitqueue_head(&stripe->io_wait);
+	atomic_set(&stripe->pending_io, 0);
+
+	ret = btrfs_alloc_page_array(SCRUB_STRIPE_PAGES, stripe->pages);
+	if (ret < 0)
+		goto error;
+
+	stripe->sectors = kcalloc(stripe->nr_sectors,
+				  sizeof(struct scrub_sector_verification),
+				  GFP_KERNEL);
+	if (!stripe->sectors)
+		goto error;
+
+	stripe->csums = kzalloc((BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits) *
+				fs_info->csum_size, GFP_KERNEL);
+	if (!stripe->csums)
+		goto error;
+	return 0;
+error:
+	release_scrub_stripe(stripe);
+	return -ENOMEM;
+}
+
+void wait_scrub_stripe_io(struct scrub_stripe *stripe)
+{
+	wait_event(stripe->io_wait, atomic_read(&stripe->pending_io) == 0);
+}
+
 static struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx,
 					     struct btrfs_device *dev,
 					     u64 logical, u64 physical,
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index 7639103ebf9d..e04764f8bb7e 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -13,4 +13,12 @@ int btrfs_scrub_cancel_dev(struct btrfs_device *dev);
 int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 			 struct btrfs_scrub_progress *progress);
 
+/*
+ * The following functions are temporary exports to avoid warning on unused
+ * static functions.
+ */
+struct scrub_stripe;
+int init_scrub_stripe(struct btrfs_fs_info *fs_info, struct scrub_stripe *stripe);
+void wait_scrub_stripe_io(struct scrub_stripe *stripe);
+
 #endif
-- 
2.39.2

