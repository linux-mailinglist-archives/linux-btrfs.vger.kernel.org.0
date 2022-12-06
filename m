Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF75A643E73
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Dec 2022 09:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbiLFIYR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Dec 2022 03:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbiLFIYC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Dec 2022 03:24:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DABEE36
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 00:24:01 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DBE3C1FE6F
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 08:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670315039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xy0WK7fDCYameXUtqVlzP6nHTIUSzBKgG6/JKujqMpw=;
        b=U6HcfwnZObb6D6hr8gOb7TPjGFm/a0Fbkmw5O/g84vj1eLS4cNWrQh7c/vuVxvqQhIIbEf
        MxK37Jwr0uLx4NHotQzJUALOp/slHuIXchLVoXL/jUCcYH/a+A8wNEROYjNDihuiSNe9A4
        TAiyPEApiR3eOMYwYGQcfNx+/XjzyUU=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 413C3132F3
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 08:23:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id OOWCKB78jmNRbAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Dec 2022 08:23:58 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PoC PATCH 03/11] btrfs: scrub: introduce a helper to verify one scrub2_stripe
Date:   Tue,  6 Dec 2022 16:23:30 +0800
Message-Id: <f5fe6f6d3f2e188b72965e719018c8cfd39c486a.1670314744.git.wqu@suse.com>
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

The new helper, scrub2_verify_stripe() is not much different than
the old scrub way.

The difference is mostly in how we handle metadata verification.

This version will use a dummy extent buffer so we can share all the
existing metadata verification code.

Currently the helper will only verify and update the error bitmaps, we
don't yet output any error message, as that can only be done after
either we repaired the stripe or exhausted all the mirrors.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c |  10 +--
 fs/btrfs/disk-io.h |   2 +
 fs/btrfs/scrub.c   | 153 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/scrub.h   |   1 +
 4 files changed, 161 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0888d484df80..e2b91f14d14a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -98,7 +98,7 @@ struct async_submit_bio {
 /*
  * Compute the csum of a btree block and store the result to provided buffer.
  */
-static void csum_tree_block(struct extent_buffer *buf, u8 *result)
+void btrfs_csum_tree_block(struct extent_buffer *buf, u8 *result)
 {
 	struct btrfs_fs_info *fs_info = buf->fs_info;
 	const int num_pages = num_extent_pages(buf);
@@ -337,7 +337,7 @@ static int csum_one_extent_buffer(struct extent_buffer *eb)
 	ASSERT(memcmp_extent_buffer(eb, fs_info->fs_devices->metadata_uuid,
 				    offsetof(struct btrfs_header, fsid),
 				    BTRFS_FSID_SIZE) == 0);
-	csum_tree_block(eb, result);
+	btrfs_csum_tree_block(eb, result);
 
 	if (btrfs_header_level(eb))
 		ret = btrfs_check_node(eb);
@@ -448,7 +448,7 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct bio_vec *bvec
 	return csum_one_extent_buffer(eb);
 }
 
-static int check_tree_block_fsid(struct extent_buffer *eb)
+int btrfs_check_tree_block_fsid(struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices, *seed_devs;
@@ -499,7 +499,7 @@ static int validate_extent_buffer(struct extent_buffer *eb,
 		ret = -EIO;
 		goto out;
 	}
-	if (check_tree_block_fsid(eb)) {
+	if (btrfs_check_tree_block_fsid(eb)) {
 		btrfs_err_rl(fs_info, "bad fsid on logical %llu mirror %u",
 			     eb->start, eb->read_mirror);
 		ret = -EIO;
@@ -514,7 +514,7 @@ static int validate_extent_buffer(struct extent_buffer *eb,
 		goto out;
 	}
 
-	csum_tree_block(eb, result);
+	btrfs_csum_tree_block(eb, result);
 	header_csum = page_address(eb->pages[0]) +
 		get_eb_offset_in_page(eb, offsetof(struct btrfs_header, csum));
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 363935cfc084..08c498b8c40d 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -44,6 +44,8 @@ void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info);
 int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info);
 int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
 			   const struct btrfs_super_block *disk_sb);
+int btrfs_check_tree_block_fsid(struct extent_buffer *eb);
+void btrfs_csum_tree_block(struct extent_buffer *buf, u8 *result);
 int __cold open_ctree(struct super_block *sb,
 	       struct btrfs_fs_devices *fs_devices,
 	       char *options);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f4632fca5e67..de194c31428e 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3657,6 +3657,159 @@ int scrub2_find_fill_first_stripe(struct btrfs_root *extent_root,
 	return ret;
 }
 
+static void scrub2_copy_sector_into_eb(struct scrub2_stripe *stripe,
+				       int sector_nr)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	struct extent_buffer *eb = stripe->dummy_eb;
+	int i;
+	const unsigned int sectors_per_tree = fs_info->nodesize >>
+					      fs_info->sectorsize_bits;
+
+	/* Our tree block should not cross stripe boundary. */
+	ASSERT(sector_nr >= 0 &&
+	       sector_nr + sectors_per_tree - 1 < stripe->nr_sectors);
+
+	eb->start = stripe->logical + (sector_nr << fs_info->sectorsize_bits);
+
+	for (i = sector_nr; i < sector_nr + sectors_per_tree; i++) {
+		int page_index = i << fs_info->sectorsize_bits >> PAGE_SHIFT;
+		void *src = page_address(stripe->pages[page_index]) +
+			    offset_in_page(i << fs_info->sectorsize_bits);
+
+		write_extent_buffer(eb, src,
+				(i - sector_nr) << fs_info->sectorsize_bits,
+				fs_info->sectorsize);
+	}
+}
+
+/*
+ * At this stage, we should only update the error bitmaps, not yet output
+ * any warning message.
+ * The warning messages would be outputted after exhausting all copies (without
+ * a good copy), or after repaired the stripe.
+ */
+static void scrub2_verify_one_metadata(struct scrub2_stripe *stripe,
+				       int sector_nr)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	struct extent_buffer *eb = stripe->dummy_eb;
+	const unsigned int sectors_per_tree = fs_info->nodesize >>
+					      fs_info->sectorsize_bits;
+	u8 result[BTRFS_CSUM_SIZE];
+	const u8 *header_csum;
+
+	scrub2_copy_sector_into_eb(stripe, sector_nr);
+
+	/* Basic sanity checks (bytenr and fsid)  */
+	if (btrfs_header_bytenr(eb) !=
+	    stripe->logical + (sector_nr << fs_info->sectorsize_bits)) {
+		bitmap_set(&stripe->meta_error_bitmap, sector_nr,
+			   sectors_per_tree);
+		return;
+	}
+	if (btrfs_check_tree_block_fsid(eb)) {
+		bitmap_set(&stripe->meta_error_bitmap, sector_nr,
+			   sectors_per_tree);
+		return;
+	}
+	if (btrfs_header_level(eb) >= BTRFS_MAX_LEVEL) {
+		bitmap_set(&stripe->meta_error_bitmap, sector_nr,
+			   sectors_per_tree);
+		return;
+	}
+	btrfs_csum_tree_block(eb, result);
+	header_csum = page_address(eb->pages[0]) +
+		get_eb_offset_in_page(eb, offsetof(struct btrfs_header, csum));
+	if (memcmp(result, header_csum, fs_info->csum_size) != 0) {
+		bitmap_set(&stripe->csum_error_bitmap, sector_nr,
+			   sectors_per_tree);
+		return;
+	}
+	if (btrfs_header_generation(eb) !=
+	    stripe->sectors[sector_nr].generation) {
+		bitmap_set(&stripe->meta_error_bitmap, sector_nr,
+			   sectors_per_tree);
+		return;
+	}
+}
+
+static void scrub2_verify_one_sector(struct scrub2_stripe *stripe,
+				     int sector_nr)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	struct scrub2_sector *sector = &stripe->sectors[sector_nr];
+	const unsigned int sectors_per_tree = fs_info->nodesize >>
+					      fs_info->sectorsize_bits;
+	int page_index = sector_nr << fs_info->sectorsize_bits >> PAGE_SHIFT;
+	int pgoff = offset_in_page(sector_nr << fs_info->sectorsize_bits);
+
+	ASSERT(sector_nr >= 0 && sector_nr < stripe->nr_sectors);
+
+	/* Sector not utilized, skip it. */
+	if (test_bit(sector_nr, &stripe->used_sector_bitmap))
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
+		if (unlikely(sector_nr + sectors_per_tree >=
+			     stripe->nr_sectors)) {
+			btrfs_warn_rl(fs_info,
+			"tree block at %llu crosses stripe boundary %llu",
+				      stripe->logical +
+				      (sector_nr << fs_info->sectorsize_bits),
+				      stripe->logical);
+			return;
+		}
+		scrub2_verify_one_metadata(stripe, sector_nr);
+		return;
+	}
+
+	/* Data is much easier, we just verify the data csum (if we have). */
+	if (sector->csum) {
+		int ret;
+		u8 csum_buf[BTRFS_CSUM_SIZE];
+
+		ret = btrfs_check_sector_csum(fs_info, stripe->pages[page_index], pgoff,
+				csum_buf, sector->csum);
+		if (ret < 0)
+			set_bit(sector_nr, &stripe->csum_error_bitmap);
+	}
+}
+
+void scrub2_verify_one_stripe(struct scrub2_stripe *stripe)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	const unsigned int sectors_per_tree = fs_info->nodesize >>
+					      fs_info->sectorsize_bits;
+	int sector_nr;
+
+	for_each_set_bit(sector_nr, &stripe->used_sector_bitmap,
+			 stripe->nr_sectors) {
+		scrub2_verify_one_sector(stripe, sector_nr);
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
 /*
  * Scrub one range which can only has simple mirror based profile.
  * (Including all range in SINGLE/DUP/RAID1/RAID1C*, and each stripe in
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index 0b2a89f7a2e0..0aaed61e4d4d 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -25,5 +25,6 @@ int scrub2_find_fill_first_stripe(struct btrfs_root *extent_root,
 				  struct btrfs_block_group *bg,
 				  u64 logical_start, u64 logical_len,
 				  struct scrub2_stripe *stripe);
+void scrub2_verify_one_stripe(struct scrub2_stripe *stripe);
 
 #endif
-- 
2.38.1

