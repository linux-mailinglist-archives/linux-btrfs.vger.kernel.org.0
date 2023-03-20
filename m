Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75376C08DA
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Mar 2023 03:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCTCNf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Mar 2023 22:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjCTCNe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Mar 2023 22:13:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE0A6A4E
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Mar 2023 19:13:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2678421AF7
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679278410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SOR4FBqU9vsKbKZoauvQIe+YrZctZjN4GeGNcnbPOBQ=;
        b=mmQ+FCqAsbuKYx7fAsFF8EFwjNe0vIqmuk07O9/BuWzRlAKBeK8rFrnNA01KBYP1J7ahZH
        2uG6/1gh/qSS4ITMdqDYyKTnVLhzoOJD+ziMxnVFRHYUmPfY/M2Cbq8mphD+539zkxroLV
        F5ulNlmpg3HmJxzWuxWJPaLNIWMzPEA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0915213416
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MACjMUjBF2QLPQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 06/12] btrfs: scrub: introduce a helper to verify one metadata
Date:   Mon, 20 Mar 2023 10:12:52 +0800
Message-Id: <247d7a3f94cc940a8dceb03bc6357f9577c7d394.1679278088.git.wqu@suse.com>
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

The new helper, scrub_verify_one_metadata(), is almost the same as
scrub_checksum_tree_block().

The difference is in how we grab the pages.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/scrub.h |   1 +
 2 files changed, 117 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index d44007cccad3..f3445c7f5dc1 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2157,6 +2157,122 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 	return sblock->checksum_error;
 }
 
+static struct page *scrub_stripe_get_page(struct scrub_stripe *stripe,
+					  int sector_nr)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	int page_index = sector_nr << fs_info->sectorsize_bits >> PAGE_SHIFT;
+
+	return stripe->pages[page_index];
+}
+
+static unsigned int scrub_stripe_get_page_offset(struct scrub_stripe *stripe,
+						 int sector_nr)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+
+	return offset_in_page(sector_nr << fs_info->sectorsize_bits);
+}
+
+void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	const unsigned int sectors_per_tree = fs_info->nodesize >>
+					      fs_info->sectorsize_bits;
+	const u64 logical = stripe->logical + (sector_nr << fs_info->sectorsize_bits);
+	const struct page *first_page = scrub_stripe_get_page(stripe, sector_nr);
+	const unsigned int first_off = scrub_stripe_get_page_offset(stripe, sector_nr);
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	u8 on_disk_csum[BTRFS_CSUM_SIZE];
+	u8 calculated_csum[BTRFS_CSUM_SIZE];
+	struct btrfs_header *h;
+	int i;
+
+	/*
+	 * Here we don't have a good way to attach the pages (and subpages)
+	 * to a dummy extent buffer, thus we have to directly grab the members
+	 * from pages.
+	 */
+	h = (struct btrfs_header *)(page_address(first_page) + first_off);
+	memcpy(on_disk_csum, h->csum, fs_info->csum_size);
+
+	if (logical != btrfs_stack_header_bytenr(h)) {
+		bitmap_set(&stripe->csum_error_bitmap, sector_nr,
+			   sectors_per_tree);
+		bitmap_set(&stripe->error_bitmap, sector_nr,
+			   sectors_per_tree);
+		btrfs_warn_rl(fs_info,
+		"tree block %llu mirror %u has bad bytenr, has %llu want %llu",
+			      logical, stripe->mirror_num,
+			      btrfs_stack_header_bytenr(h), logical);
+		return;
+	}
+	if (memcmp(h->fsid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE)) {
+		bitmap_set(&stripe->meta_error_bitmap, sector_nr,
+			   sectors_per_tree);
+		bitmap_set(&stripe->error_bitmap, sector_nr,
+			   sectors_per_tree);
+		btrfs_warn_rl(fs_info,
+		"tree block %llu mirror %u has bad fsid, has %pU want %pU",
+			      logical, stripe->mirror_num,
+			      h->fsid, fs_info->fs_devices->fsid);
+		return;
+	}
+	if (memcmp(h->chunk_tree_uuid, fs_info->chunk_tree_uuid,
+		   BTRFS_UUID_SIZE)) {
+		bitmap_set(&stripe->meta_error_bitmap, sector_nr,
+			   sectors_per_tree);
+		bitmap_set(&stripe->error_bitmap, sector_nr,
+			   sectors_per_tree);
+		btrfs_warn_rl(fs_info,
+		"tree block %llu mirror %u has bad chunk tree uuid, has %pU want %pU",
+			      logical, stripe->mirror_num,
+			      h->chunk_tree_uuid, fs_info->chunk_tree_uuid);
+		return;
+	}
+
+	/* Now check tree block csum. */
+	shash->tfm = fs_info->csum_shash;
+	crypto_shash_init(shash);
+	crypto_shash_update(shash, page_address(first_page) + first_off +
+			    BTRFS_CSUM_SIZE, fs_info->sectorsize - BTRFS_CSUM_SIZE);
+
+	for (i = sector_nr + 1; i < sector_nr + sectors_per_tree; i++) {
+		struct page *page = scrub_stripe_get_page(stripe, i);
+		unsigned int page_off = scrub_stripe_get_page_offset(stripe, i);
+
+		crypto_shash_update(shash, page_address(page) + page_off,
+				    fs_info->sectorsize);
+	}
+	crypto_shash_final(shash, calculated_csum);
+	if (memcmp(calculated_csum, on_disk_csum, fs_info->csum_size)) {
+		bitmap_set(&stripe->meta_error_bitmap, sector_nr,
+			   sectors_per_tree);
+		bitmap_set(&stripe->error_bitmap, sector_nr,
+			   sectors_per_tree);
+		btrfs_warn_rl(fs_info,
+		"tree block %llu mirror %u has bad csum, has " CSUM_FMT " want " CSUM_FMT,
+			      logical, stripe->mirror_num,
+			      CSUM_FMT_VALUE(fs_info->csum_size, on_disk_csum),
+			      CSUM_FMT_VALUE(fs_info->csum_size, calculated_csum));
+		return;
+	}
+	if (stripe->sectors[sector_nr].generation != btrfs_stack_header_generation(h)) {
+		bitmap_set(&stripe->meta_error_bitmap, sector_nr,
+			   sectors_per_tree);
+		bitmap_set(&stripe->error_bitmap, sector_nr,
+			   sectors_per_tree);
+		btrfs_warn_rl(fs_info,
+		"tree block %llu mirror %u has bad geneartion, has %llu want %llu",
+			      logical, stripe->mirror_num,
+			      btrfs_stack_header_generation(h),
+			      stripe->sectors[sector_nr].generation);
+	}
+	bitmap_clear(&stripe->error_bitmap, sector_nr, sectors_per_tree);
+	bitmap_clear(&stripe->csum_error_bitmap, sector_nr, sectors_per_tree);
+	bitmap_clear(&stripe->meta_error_bitmap, sector_nr, sectors_per_tree);
+}
+
 static int scrub_checksum_tree_block(struct scrub_block *sblock)
 {
 	struct scrub_ctx *sctx = sblock->sctx;
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index 27019d86b539..0d8bdc7df89c 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -24,5 +24,6 @@ int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 				 struct btrfs_device *dev, u64 physical,
 				 int mirror_num, u64 logical_start,
 				 u32 logical_len, struct scrub_stripe *stripe);
+void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr);
 
 #endif
-- 
2.39.2

