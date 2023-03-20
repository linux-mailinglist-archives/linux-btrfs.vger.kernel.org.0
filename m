Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDE46C08D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Mar 2023 03:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCTCNb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Mar 2023 22:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjCTCNa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Mar 2023 22:13:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C006A4E
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Mar 2023 19:13:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 964F321ADD
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679278407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DMtvbx1mKiWRcVeO48g0f3RMwjNXkhIgfEt1QJ+ASdM=;
        b=C3dg+EfW6mx2iCxRltPPohupZuddelVT0ULDEdZN4qIFgkdcqa7cAVlxaVoLhsc8XFdyHy
        R74+JwdFJ/xg1Ee66M5+vYSsb8llUbGMT1P5WsMHk8WC+bG8Ggze73aXKqmW30a6Zl08g9
        hFfAXFA3JwAC2yChB9yTXDCecNmXr3A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4982F13416
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mM40D0TBF2QLPQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 04/12] btrfs: scrub: introduce the structure for new BTRFS_STRIPE_LEN based interface
Date:   Mon, 20 Mar 2023 10:12:50 +0800
Message-Id: <14da54c24f582455626e24612740f71e894b896a.1679278088.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679278088.git.wqu@suse.com>
References: <cover.1679278088.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
---
 fs/btrfs/scrub.c | 140 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/scrub.h |   8 +++
 2 files changed, 148 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index e765eb8b8bcf..ff8d484263f9 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -70,6 +70,88 @@ struct scrub_ctx;
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
+/* Set when @mirror_num, @dev, @physical and @logical is set. */
+#define SCRUB_STRIPE_FLAG_INITIALIZED		(0)
+
+/* Set when the read-repair is finished. */
+#define SCRUB_STRIPE_FLAG_REPAIR_DONE		(1)
+
+/*
+ * Represent one continuous range with a length of BTRFS_STRIPE_LEN.
+ */
+struct scrub_stripe {
+	struct btrfs_block_group *bg;
+
+	struct page *pages[BTRFS_STRIPE_LEN / PAGE_SIZE];
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
+	/* Indicates the states of the stripe. */
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
@@ -266,6 +348,64 @@ static void detach_scrub_page_private(struct page *page)
 #endif
 }
 
+static void release_scrub_stripe(struct scrub_stripe *stripe)
+{
+	int i;
+
+	if (!stripe)
+		return;
+
+	for (i = 0; i < BTRFS_STRIPE_LEN >> PAGE_SHIFT; i++) {
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
+
+	ret = btrfs_alloc_page_array(BTRFS_STRIPE_LEN >> PAGE_SHIFT,
+				     stripe->pages);
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

