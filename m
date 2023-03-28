Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C966CB9DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 10:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjC1Ix1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 04:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjC1Ix0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 04:53:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387844EDA
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 01:53:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EEBEB1FD81;
        Tue, 28 Mar 2023 08:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679993603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CZp1wU7Va+7xRbEu4hJj65UO3OQ3AV7i8h+CTMdhTsE=;
        b=ryirRt0H5PHKnDUh4pFoah/+ZKpBX/T6rASVMneCNDDrBRUqLsPnQKeCnhccW4QoW1qBZo
        esUfkVjS8rv0EuhnTgegFAYI6YZSVfiVuHkqR73sBfcMpy3h2Yq2C+xsgAib1gibrWo+KV
        dLe/hj09Kt4ByX7NPh5eZGwf+BFN/gE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E38B1390B;
        Tue, 28 Mar 2023 08:53:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qCCIOwKrImRBMwAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 28 Mar 2023 08:53:22 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v6 08/13] btrfs: scrub: introduce a helper to verify one scrub_stripe
Date:   Tue, 28 Mar 2023 16:52:52 +0800
Message-Id: <0bc91d6441e5e7cf60f3f91ff2ff77e057756a03.1679993368.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679993368.git.wqu@suse.com>
References: <cover.1679993368.git.wqu@suse.com>
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
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/scrub.h |  2 +-
 2 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index d386fa6c1f2f..001972d9a3c4 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2176,7 +2176,7 @@ static unsigned int scrub_stripe_get_page_offset(struct scrub_stripe *stripe,
 	return offset_in_page(sector_nr << fs_info->sectorsize_bits);
 }
 
-void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr)
+static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	const unsigned int sectors_per_tree = fs_info->nodesize >>
@@ -2275,6 +2275,84 @@ void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr)
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

