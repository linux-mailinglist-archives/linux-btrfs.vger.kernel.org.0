Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E48B66B7BE
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 08:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjAPHEx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Jan 2023 02:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjAPHEt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 02:04:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9F98A5B
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Jan 2023 23:04:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1DD1334F2B
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673852687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6NsugeZV+TGFduXrPEdFye4MxifUA995zVwXyDi5+Yw=;
        b=N9X622uirx6eo95ZYbLOgybE9pcgPWvz6fq/wdKoeJ0dmgHlRFpyGf7iRb9LQG7M4/ZDlI
        1YcPsKD/QA2OdAB/R8TtUCJbjZa7UASYIbn148AT+Y6iLRRjcjDopPvUMD9sA8qLbVkORN
        m39dGuembxMeDdmcpPfdqOLwBegA6EA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 79594138FA
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SFtuEQ73xGMfZwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/11] btrfs: scrub: introduce a helper to verify one scrub_stripe
Date:   Mon, 16 Jan 2023 15:04:18 +0800
Message-Id: <d3997ba6e84800e087d116a34039d0fce131f538.1673851704.git.wqu@suse.com>
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

The new helper, scrub_verify_stripe() is not much different than
the old scrub way.

The difference is mostly in how we grab pages and their offsets.

Currently the helper will only verify and update the error bitmaps, we
don't yet output any error message for data verification, as that can only
be done after either we repaired the stripe or exhausted all the mirrors.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/scrub.h |  2 +-
 2 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ced98216f69e..656b5395adf5 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2183,7 +2183,7 @@ static unsigned int scrub_stripe_get_page_offset(struct scrub_stripe *stripe,
 	return offset_in_page(sector_nr << fs_info->sectorsize_bits);
 }
 
-void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr)
+static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	const unsigned int sectors_per_tree = fs_info->nodesize >>
@@ -2269,6 +2269,85 @@ void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr)
 	}
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
+	/* Data is much easier, we just verify the data csum (if we have). */
+	if (sector->csum) {
+		int ret;
+		u8 csum_buf[BTRFS_CSUM_SIZE];
+
+		ret = btrfs_check_sector_csum(fs_info, page, pgoff, csum_buf,
+					      sector->csum);
+		if (ret < 0)
+			set_bit(sector_nr, &stripe->csum_error_bitmap);
+	}
+}
+
+void scrub_verify_one_stripe(struct scrub_stripe *stripe)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	const unsigned int sectors_per_tree = fs_info->nodesize >>
+					      fs_info->sectorsize_bits;
+	int sector_nr;
+
+	for_each_set_bit(sector_nr, &stripe->extent_sector_bitmap,
+			 stripe->nr_sectors) {
+		scrub_verify_one_sector(stripe, sector_nr);
+		if (stripe->sectors[sector_nr].is_metadata)
+			sector_nr += sectors_per_tree - 1;
+	}
+	/*
+	 * All error bitmap updated. OR all errors into the
+	 * initial_error_bitmap for later repair runs.
+	 */
+	bitmap_or(&stripe->init_error_bitmap, &stripe->io_error_bitmap,
+		  &stripe->csum_error_bitmap, stripe->nr_sectors);
+	bitmap_or(&stripe->init_error_bitmap, &stripe->init_error_bitmap,
+		  &stripe->meta_error_bitmap, stripe->nr_sectors);
+	bitmap_copy(&stripe->current_error_bitmap, &stripe->init_error_bitmap,
+		    stripe->nr_sectors);
+}
+
 static int scrub_checksum_tree_block(struct scrub_block *sblock)
 {
 	struct scrub_ctx *sctx = sblock->sctx;
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index d9f869fd4d7c..73fa6744a6a7 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -26,6 +26,6 @@ int scrub_find_fill_first_stripe(struct btrfs_root *extent_root,
 				 struct btrfs_block_group *bg,
 				 u64 logical_start, u64 logical_len,
 				 struct scrub_stripe *stripe);
-void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr);
+void scrub_verify_one_stripe(struct scrub_stripe *stripe);
 
 #endif
-- 
2.39.0

