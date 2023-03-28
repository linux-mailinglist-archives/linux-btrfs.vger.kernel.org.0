Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B806CB9E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 10:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjC1Ix1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 04:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjC1IxZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 04:53:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F0C19A1
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 01:53:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C963221835;
        Tue, 28 Mar 2023 08:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679993602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QykEp8LULWfVYZ28rg3bnCmVnfBe1YqeplFGe83YCIc=;
        b=qlx+OftaHzmZRpBcBW6ZsMsCJEr4Ms4DVrp0NbxJVA8cFKcIYsgo1sdfWyN/hL2pwDXkwO
        fQR2Q/2sviX6gTlrDQjEv6qiMegMlmpOP07bhK+aSpaKiixst0627lgaTqhfxlS88niBGf
        D+2opRJ6YKGNIMQw6D+DqUiWSf0nVj4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A8C91390B;
        Tue, 28 Mar 2023 08:53:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +LnFMgGrImRBMwAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 28 Mar 2023 08:53:21 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v6 07/13] btrfs: scrub: introduce a helper to verify one metadata
Date:   Tue, 28 Mar 2023 16:52:51 +0800
Message-Id: <3bfac35f93f9be9b9cbbbfc901315bd3b388c5a7.1679993368.git.wqu@suse.com>
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

The new helper, scrub_verify_one_metadata(), is almost the same as
scrub_checksum_tree_block().

The difference is in how we grab the pages.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/scrub.h |   1 +
 2 files changed, 117 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ed55a7363b8a..d386fa6c1f2f 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2159,6 +2159,122 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 	return sblock->checksum_error;
 }
 
+static struct page *scrub_stripe_get_page(struct scrub_stripe *stripe,
+					  int sector_nr)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	int page_index = (sector_nr << fs_info->sectorsize_bits) >> PAGE_SHIFT;
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
+	struct btrfs_header *header;
+
+	/*
+	 * Here we don't have a good way to attach the pages (and subpages)
+	 * to a dummy extent buffer, thus we have to directly grab the members
+	 * from pages.
+	 */
+	header = (struct btrfs_header *)(page_address(first_page) + first_off);
+	memcpy(on_disk_csum, header->csum, fs_info->csum_size);
+
+	if (logical != btrfs_stack_header_bytenr(header)) {
+		bitmap_set(&stripe->csum_error_bitmap, sector_nr,
+			   sectors_per_tree);
+		bitmap_set(&stripe->error_bitmap, sector_nr,
+			   sectors_per_tree);
+		btrfs_warn_rl(fs_info,
+		"tree block %llu mirror %u has bad bytenr, has %llu want %llu",
+			      logical, stripe->mirror_num,
+			      btrfs_stack_header_bytenr(header), logical);
+		return;
+	}
+	if (memcmp(header->fsid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE) != 0) {
+		bitmap_set(&stripe->meta_error_bitmap, sector_nr,
+			   sectors_per_tree);
+		bitmap_set(&stripe->error_bitmap, sector_nr,
+			   sectors_per_tree);
+		btrfs_warn_rl(fs_info,
+		"tree block %llu mirror %u has bad fsid, has %pU want %pU",
+			      logical, stripe->mirror_num,
+			      header->fsid, fs_info->fs_devices->fsid);
+		return;
+	}
+	if (memcmp(header->chunk_tree_uuid, fs_info->chunk_tree_uuid,
+		   BTRFS_UUID_SIZE) != 0) {
+		bitmap_set(&stripe->meta_error_bitmap, sector_nr,
+			   sectors_per_tree);
+		bitmap_set(&stripe->error_bitmap, sector_nr,
+			   sectors_per_tree);
+		btrfs_warn_rl(fs_info,
+		"tree block %llu mirror %u has bad chunk tree uuid, has %pU want %pU",
+			      logical, stripe->mirror_num,
+			      header->chunk_tree_uuid, fs_info->chunk_tree_uuid);
+		return;
+	}
+
+	/* Now check tree block csum. */
+	shash->tfm = fs_info->csum_shash;
+	crypto_shash_init(shash);
+	crypto_shash_update(shash, page_address(first_page) + first_off +
+			    BTRFS_CSUM_SIZE, fs_info->sectorsize - BTRFS_CSUM_SIZE);
+
+	for (int i = sector_nr + 1; i < sector_nr + sectors_per_tree; i++) {
+		struct page *page = scrub_stripe_get_page(stripe, i);
+		unsigned int page_off = scrub_stripe_get_page_offset(stripe, i);
+
+		crypto_shash_update(shash, page_address(page) + page_off,
+				    fs_info->sectorsize);
+	}
+	crypto_shash_final(shash, calculated_csum);
+	if (memcmp(calculated_csum, on_disk_csum, fs_info->csum_size) != 0) {
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
+	if (stripe->sectors[sector_nr].generation !=
+	    btrfs_stack_header_generation(header)) {
+		bitmap_set(&stripe->meta_error_bitmap, sector_nr,
+			   sectors_per_tree);
+		bitmap_set(&stripe->error_bitmap, sector_nr,
+			   sectors_per_tree);
+		btrfs_warn_rl(fs_info,
+		"tree block %llu mirror %u has bad geneartion, has %llu want %llu",
+			      logical, stripe->mirror_num,
+			      btrfs_stack_header_generation(header),
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

