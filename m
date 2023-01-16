Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8927066B7BB
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 08:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjAPHEt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Jan 2023 02:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjAPHEq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 02:04:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507CFB46D
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Jan 2023 23:04:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 133F267470
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673852684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cS/EkCo+/mGhjRjMHn0zExt306dlyScNxfhsIoNOIFo=;
        b=cvU305UbXFK58uwS/nYLXfJMYFjcrkcdi5cby97g686m3ExOXV82hCW2aLglsp8ZjZK/c2
        SvahMql3hDOVrwVB3sjeLJzE1ygiG22XUx0ux/BWZNOwl6bxjyrIULu0CGKWb7VmmIHf1M
        uVi3sMra0SVoGcjI+6aVPdojK8grYyY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E2F2138FA
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aCjUDgv3xGMfZwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:43 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/11] btrfs: scrub: introduce the structure for new BTRFS_STRIPE_LEN based interface
Date:   Mon, 16 Jan 2023 15:04:15 +0800
Message-Id: <fbada655046400fae50e16887930809cfc5fd75c.1673851704.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673851704.git.wqu@suse.com>
References: <cover.1673851704.git.wqu@suse.com>
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
get rid of the bio form shaping by always read the full BTRFS_STRIPE_LEN
range.

This means we will read some sectors which is not scrub target, but
that's fine. At write back time we still only submit repaired sectors.

With every read submitted in BTRFS_STRIPE_LEN, there should not be much
need for a complex bio form shaping mechanism.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 147 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/scrub.h |   8 +++
 2 files changed, 155 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index e554a9904d2a..3beb11153dbf 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -70,6 +70,91 @@ struct scrub_ctx;
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
+
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
+	/* Indicates which sectors are covered by extent items. */
+	unsigned long extent_sector_bitmap;
+
+	/*
+	 * Records the errors found after the initial read.
+	 * This will be used for repair, as any sector with error needs repair
+	 * (if found a good copy).
+	 */
+	unsigned long init_error_bitmap;
+
+	/*
+	 * After reading another copy and verification, sectors can be repaired
+	 * will be cleared.
+	 */
+	unsigned long current_error_bitmap;
+
+	/*
+	 * The following error_bitmap are all for the initial read operation.
+	 * After the initial read, we should not touch those error bitmaps, as
+	 * they will later be used to do error reporting.
+	 *
+	 * Indicates IO errors during read.
+	 */
+	unsigned long io_error_bitmap;
+
+	/* For both metadata and data. */
+	unsigned long csum_error_bitmap;
+
+	/*
+	 * Indicates metadata specific errors.
+	 * (basic sanity checks to transid errors)
+	 */
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
@@ -266,6 +351,68 @@ static void detach_scrub_page_private(struct page *page)
 #endif
 }
 
+static void free_scrub_stripe(struct scrub_stripe *stripe)
+{
+	int i;
+
+	if (!stripe)
+		return;
+
+	for (i = 0; i < BTRFS_STRIPE_LEN >> PAGE_SHIFT; i++) {
+		if (stripe->pages[i])
+			__free_page(stripe->pages[i]);
+	}
+	kfree(stripe->sectors);
+	kfree(stripe->csums);
+	kfree(stripe);
+}
+
+struct scrub_stripe *alloc_scrub_stripe(struct btrfs_fs_info *fs_info,
+					struct btrfs_block_group *bg)
+{
+	struct scrub_stripe *stripe;
+	int ret;
+
+	stripe = kzalloc(sizeof(*stripe), GFP_KERNEL);
+	if (!stripe)
+		return NULL;
+
+	stripe->nr_sectors = BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits;
+	stripe->bg = bg;
+
+	init_waitqueue_head(&stripe->io_wait);
+	atomic_set(&stripe->pending_io, 0);
+
+
+	ret = btrfs_alloc_page_array(BTRFS_STRIPE_LEN >> PAGE_SHIFT,
+				     stripe->pages);
+	if (ret < 0)
+		goto cleanup;
+
+	stripe->sectors = kcalloc(stripe->nr_sectors,
+				  sizeof(struct scrub_sector_verification),
+				  GFP_KERNEL);
+	if (!stripe->sectors)
+		goto cleanup;
+
+	if (bg->flags & BTRFS_BLOCK_GROUP_DATA) {
+		stripe->csums = kzalloc(
+			(BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits) *
+			fs_info->csum_size, GFP_KERNEL);
+		if (!stripe->csums)
+			goto cleanup;
+	}
+	return stripe;
+cleanup:
+	free_scrub_stripe(stripe);
+	return NULL;
+}
+
+void wait_scrub_stripe(struct scrub_stripe *stripe)
+{
+	wait_event(stripe->io_wait, atomic_read(&stripe->pending_io) == 0);
+}
+
 static struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx,
 					     struct btrfs_device *dev,
 					     u64 logical, u64 physical,
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index 7639103ebf9d..a035375083f0 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -13,4 +13,12 @@ int btrfs_scrub_cancel_dev(struct btrfs_device *dev);
 int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 			 struct btrfs_scrub_progress *progress);
 
+/*
+ * The following functions are temporary exports to avoid warning on unused
+ * static functions.
+ */
+struct scrub_stripe *alloc_scrub_stripe(struct btrfs_fs_info *fs_info,
+					struct btrfs_block_group *bg);
+void wait_scrub_stripe(struct scrub_stripe *stripe);
+
 #endif
-- 
2.39.0

