Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8456F6C08DB
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Mar 2023 03:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjCTCNg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Mar 2023 22:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjCTCNe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Mar 2023 22:13:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA77A193DF
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Mar 2023 19:13:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 89D2E21ADD
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679278411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t9K3bC8CYN2ESXZCLgMQ+pWFnD9it3SMz/fEQFezR8M=;
        b=mqVlEiDl38ellH7gPmcPxis4BWfffUUc14q0j85HNsLQ0oo9Zni6k7s525B6VLjd5sv1r8
        GWDzEGgsnK9tp4miHRJTepi71dGGzSicdX4SHHw2eOqCh10+TVs4RAQGWL0mHYiqyuZaBw
        QIU32edfhkd+X6c470zMhnxsZxEAdzQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A8AC13416
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IHGjEUrBF2QLPQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 07/12] btrfs: scrub: introduce a helper to verify one scrub_stripe
Date:   Mon, 20 Mar 2023 10:12:53 +0800
Message-Id: <374cf04284f8f890f3df222d18b6dd271d478caa.1679278088.git.wqu@suse.com>
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

The new helper, scrub_verify_stripe(), shares the same main workflow of
the old scrub code.

The major differences are:

- How pages/page_offset is grabbed
  Everything can be grabbed from scrub_stripe easily.

- When error report happens
  Currently the helper only verify the sectors, not really doing any
  error reporting.
  The error reporting would be done after we have done the repair.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/scrub.h |  2 +-
 2 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f3445c7f5dc1..ed8b9a97f9dd 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2174,7 +2174,7 @@ static unsigned int scrub_stripe_get_page_offset(struct scrub_stripe *stripe,
 	return offset_in_page(sector_nr << fs_info->sectorsize_bits);
 }
 
-void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr)
+static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	const unsigned int sectors_per_tree = fs_info->nodesize >>
@@ -2273,6 +2273,84 @@ void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr)
 	bitmap_clear(&stripe->meta_error_bitmap, sector_nr, sectors_per_tree);
 }
 
+static void scrub_verify_one_sector(struct scrub_stripe *stripe,
+				    int sector_nr)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	struct scrub_sector_verification *sector = &stripe->sectors[sector_nr];
+	const unsigned int sectors_per_tree = fs_info->nodesize >>
+					      fs_info->sectorsize_bits;
+	struct page *page = scrub_stripe_get_page(stripe, sector_nr);
+	unsigned int pgoff = scrub_stripe_get_page_offset(stripe, sector_nr);
+	u8 csum_buf[BTRFS_CSUM_SIZE];
+	int ret;
+
+	ASSERT(sector_nr >= 0 && sector_nr < stripe->nr_sectors);
+
+	/* Sector not utilized, skip it. */
+	if (!test_bit(sector_nr, &stripe->extent_sector_bitmap))
+		return;
+
+	/* IO error, no need to check. */
+	if (test_bit(sector_nr, &stripe->io_error_bitmap))
+		return;
+
+	/* Metadata, verify the full tree block. */
+	if (sector->is_metadata) {
+		/*
+		 * Check if the tree block crosses the stripe boudary.
+		 * If crossed the boundary, we can not verify it but only
+		 * gives a warning.
+		 *
+		 * This can only happen in very old fs where chunks are not
+		 * ensured to be stripe aligned.
+		 */
+		if (unlikely(sector_nr + sectors_per_tree > stripe->nr_sectors)) {
+			btrfs_warn_rl(fs_info,
+			"tree block at %llu crosses stripe boundary %llu",
+				      stripe->logical +
+				      (sector_nr << fs_info->sectorsize_bits),
+				      stripe->logical);
+			return;
+		}
+		scrub_verify_one_metadata(stripe, sector_nr);
+		return;
+	}
+
+	/*
+	 * Data is much easier, we just verify the data csum (if we have).
+	 * For cases without csum, we have no other choice but to trust it.
+	 */
+	if (!sector->csum) {
+		clear_bit(sector_nr, &stripe->error_bitmap);
+		return;
+	}
+
+	ret = btrfs_check_sector_csum(fs_info, page, pgoff, csum_buf, sector->csum);
+	if (ret < 0) {
+		set_bit(sector_nr, &stripe->csum_error_bitmap);
+		set_bit(sector_nr, &stripe->error_bitmap);
+	} else {
+		clear_bit(sector_nr, &stripe->csum_error_bitmap);
+		clear_bit(sector_nr, &stripe->error_bitmap);
+	}
+}
+
+/* Verify specified sectors of a stripe. */
+void scrub_verify_one_stripe(struct scrub_stripe *stripe, unsigned long bitmap)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	const unsigned int sectors_per_tree = fs_info->nodesize >>
+					      fs_info->sectorsize_bits;
+	int sector_nr;
+
+	for_each_set_bit(sector_nr, &bitmap, stripe->nr_sectors) {
+		scrub_verify_one_sector(stripe, sector_nr);
+		if (stripe->sectors[sector_nr].is_metadata)
+			sector_nr += sectors_per_tree - 1;
+	}
+}
+
 static int scrub_checksum_tree_block(struct scrub_block *sblock)
 {
 	struct scrub_ctx *sctx = sblock->sctx;
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index 0d8bdc7df89c..45ff7e149806 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -24,6 +24,6 @@ int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 				 struct btrfs_device *dev, u64 physical,
 				 int mirror_num, u64 logical_start,
 				 u32 logical_len, struct scrub_stripe *stripe);
-void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr);
+void scrub_verify_one_stripe(struct scrub_stripe *stripe, unsigned long bitmap);
 
 #endif
-- 
2.39.2

