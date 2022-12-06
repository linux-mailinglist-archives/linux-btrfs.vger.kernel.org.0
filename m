Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAE9643E71
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Dec 2022 09:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiLFIYO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Dec 2022 03:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiLFIYA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Dec 2022 03:24:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302CF13E07
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 00:23:59 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8788A1FDC8
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 08:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670315037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x3//WwO+YIV/iyzRlSD38kaok82pWiWaeXHbMH5lq1Q=;
        b=uAp2AqIejLPJx3KDnEk61JY2pfCET6nBDwNc78+2tIUOcC8dWv2Exjv0jYqwOu86L7+tkO
        pKGj0Pe55t0EfHJrOi3S+F5tvPpmP1+md7NJS8+iovr9C/w8OeO/r6Py/QfbJ6ZETTZ7u3
        hSXtZ4G/5PHgp08eGZnxgiEch2/bsHQ=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id EAB44132F3
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 08:23:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id GAjkLRz8jmNRbAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Dec 2022 08:23:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PoC PATCH 01/11] btrfs: scrub: introduce the structure for new BTRFS_STRIPE_LEN based interface
Date:   Tue,  6 Dec 2022 16:23:28 +0800
Message-Id: <5fc73bee19c14a6e881e0b785837cc5e41876267.1670314744.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1670314744.git.wqu@suse.com>
References: <cover.1670314744.git.wqu@suse.com>
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

These new structures will have "scrub2_" as their prefix, along with the
alloc and free functions for them.

The basic idea is, we keep the existing per-device scrub behavior, but
get rid of the bio form shaping by always read the full BTRFS_STRIPE_LEN
range.

This means we will read some sectors which is not scrub target, but
that's fine. At write back time we still only submit repaired sectors.

With every read submitted in BTRFS_STRIPE_LEN, there should not be much
need for a complex bio form shaping mechanism.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 156 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/scrub.h |   6 ++
 2 files changed, 162 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 52b346795f66..286bdcb8b7ad 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -70,6 +70,101 @@ struct scrub_ctx;
  */
 #define BTRFS_MAX_MIRRORS (4 + 1)
 
+/*
+ * Represent one sector inside a scrub2_stripe.
+ * Contains all the info to verify the sector.
+ */
+struct scrub2_sector {
+	bool is_metadata;
+
+	union {
+		/*
+		 * Csum pointer for data csum verification.
+		 * Should point to a sector csum inside scrub2_stripe::csums.
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
+struct scrub2_stripe {
+	struct btrfs_block_group *bg;
+
+	struct page *pages[BTRFS_STRIPE_LEN / PAGE_SIZE];
+	struct scrub2_sector *sectors;
+
+	u64 logical;
+	/*
+	 * We use btrfs_submit_bio() infrastructure, thus logical + mirror_num
+	 * is enough to locate one stripe.
+	 */
+	u16 mirror_num;
+
+	/* Should be BTRFS_STRIPE_LEN / sectorsize. */
+	u16 nr_sectors;
+
+	atomic_t pending_io;
+	wait_queue_head_t io_wait;
+
+	/* Indicates which sectors are covered by extent items. */
+	unsigned long used_sector_bitmap;
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
+
+	/*
+	 * Used to verify any tree block if this stripe is inside a meta block
+	 * group.
+	 * We reuse the same eb for all metadata of the same stripe.
+	 */
+	struct extent_buffer *dummy_eb;
+};
+
 struct scrub_recover {
 	refcount_t		refs;
 	struct btrfs_io_context	*bioc;
@@ -266,6 +361,67 @@ static void detach_scrub_page_private(struct page *page)
 #endif
 }
 
+static void free_scrub2_stripe(struct scrub2_stripe *stripe)
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
+	if (stripe->dummy_eb)
+		free_extent_buffer(stripe->dummy_eb);
+	kfree(stripe);
+}
+
+struct scrub2_stripe *alloc_scrub2_stripe(struct btrfs_fs_info *fs_info,
+					  struct btrfs_block_group *bg)
+{
+	struct scrub2_stripe *stripe;
+	int ret;
+
+	stripe = kzalloc(sizeof(*stripe), GFP_KERNEL);
+	if (!stripe)
+		return NULL;
+
+	init_waitqueue_head(&stripe->io_wait);
+	atomic_set(&stripe->pending_io, 0);
+
+	stripe->nr_sectors = BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits;
+
+	ret = btrfs_alloc_page_array(BTRFS_STRIPE_LEN >> PAGE_SHIFT,
+				     stripe->pages);
+	if (ret < 0)
+		goto cleanup;
+
+	stripe->sectors = kcalloc(stripe->nr_sectors,
+				  sizeof(struct scrub2_sector), GFP_KERNEL);
+	if (!stripe->sectors)
+		goto cleanup;
+
+	if (bg->flags & BTRFS_BLOCK_GROUP_METADATA) {
+		stripe->dummy_eb = alloc_dummy_extent_buffer(fs_info, 0);
+		if (!stripe->dummy_eb)
+			goto cleanup;
+	}
+	if (bg->flags & BTRFS_BLOCK_GROUP_DATA) {
+		stripe->csums = kzalloc(
+			(BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits) *
+			fs_info->csum_size, GFP_KERNEL);
+		if (!stripe->csums)
+			goto cleanup;
+	}
+	return stripe;
+cleanup:
+	free_scrub2_stripe(stripe);
+	return NULL;
+}
+
 static struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx,
 					     struct btrfs_device *dev,
 					     u64 logical, u64 physical,
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index 7639103ebf9d..d278c0f43007 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -13,4 +13,10 @@ int btrfs_scrub_cancel_dev(struct btrfs_device *dev);
 int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 			 struct btrfs_scrub_progress *progress);
 
+/*
+ * The following functions are temporary exports to avoid warning on unused
+ * static functions.
+ */
+struct scrub2_stripe *alloc_scrub2_stripe(struct btrfs_fs_info *fs_info,
+					  struct btrfs_block_group *bg);
 #endif
-- 
2.38.1

