Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94009643E77
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Dec 2022 09:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiLFIYU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Dec 2022 03:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbiLFIYF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Dec 2022 03:24:05 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2AF13F93
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 00:24:04 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B27CC1FE6D
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 08:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670315042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qB4eJjY3ZDKNhWntgUZzQ347EmSaBmUpCMMc+ldXtR0=;
        b=lww1cWajaIObZz10MsvaqNN+qvqA7jd9FlF4e1ZBzwa3y1L494s+f7oZl6Kz4BTVsvmSG6
        3gIFUP04M1j7l6fwE5I/xRXaX5vRfioLQ21mX+wgWkX2ra2CxI1KmoPIHZncQAWQ71nZa5
        luaBhvGc6I09hx9U6hIk3wS/UCNSHjE=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 21A8E132F3
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 08:24:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id YJKJOCH8jmNRbAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Dec 2022 08:24:01 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PoC PATCH 06/11] btrfs: scrub: add the error reporting for scrub2_stripe
Date:   Tue,  6 Dec 2022 16:23:33 +0800
Message-Id: <633a0a4c44723cf193962e012530da4591d9b7a9.1670314744.git.wqu@suse.com>
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

The new helper, scrub2_report_errors(), will report the result of the
scrub to dmesg.

The main reporting is done by introducing a new helper,
scrub2_print_warning(), which is mostly the same content from
scrub_print_wanring(), but without the need for a scrub_block.

Since we're reporting the errors, it's the perfect timing to update the
scrub stat too.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 165 ++++++++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/scrub.h |   2 +
 2 files changed, 158 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a581d1e4ae44..cf0b879709b1 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -118,6 +118,13 @@ struct scrub2_stripe {
 	atomic_t pending_io;
 	wait_queue_head_t io_wait;
 
+	/*
+	 * How many data/meta extents are in this stripe.
+	 * Only for scrub stat report purpose.
+	 */
+	u16 nr_data_extents;
+	u16 nr_meta_extents;
+
 	/* Indicates which sectors are covered by extent items. */
 	unsigned long used_sector_bitmap;
 
@@ -1097,9 +1104,9 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 	return 0;
 }
 
-static void scrub_print_warning(const char *errstr, struct scrub_block *sblock)
+static void scrub2_print_warning(const char *errstr, struct btrfs_device *dev,
+				 bool is_super, u64 logical, u64 physical)
 {
-	struct btrfs_device *dev;
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_path *path;
 	struct btrfs_key found_key;
@@ -1113,22 +1120,20 @@ static void scrub_print_warning(const char *errstr, struct scrub_block *sblock)
 	u8 ref_level = 0;
 	int ret;
 
-	WARN_ON(sblock->sector_count < 1);
-	dev = sblock->dev;
-	fs_info = sblock->sctx->fs_info;
+	fs_info = dev->fs_info;
 
 	/* Super block error, no need to search extent tree. */
-	if (sblock->sectors[0]->flags & BTRFS_EXTENT_FLAG_SUPER) {
+	if (is_super) {
 		btrfs_warn_in_rcu(fs_info, "%s on device %s, physical %llu",
-			errstr, btrfs_dev_name(dev), sblock->physical);
+			errstr, btrfs_dev_name(dev), physical);
 		return;
 	}
 	path = btrfs_alloc_path();
 	if (!path)
 		return;
 
-	swarn.physical = sblock->physical;
-	swarn.logical = sblock->logical;
+	swarn.physical = physical;
+	swarn.logical = logical;
 	swarn.errstr = errstr;
 	swarn.dev = NULL;
 
@@ -1177,6 +1182,13 @@ static void scrub_print_warning(const char *errstr, struct scrub_block *sblock)
 	btrfs_free_path(path);
 }
 
+static void scrub_print_warning(const char *errstr, struct scrub_block *sblock)
+{
+	scrub2_print_warning(errstr, sblock->dev,
+			sblock->sectors[0]->flags & BTRFS_EXTENT_FLAG_SUPER,
+			sblock->logical, sblock->physical);
+}
+
 static inline void scrub_get_recover(struct scrub_recover *recover)
 {
 	refcount_inc(&recover->refs);
@@ -3633,6 +3645,11 @@ int scrub2_find_fill_first_stripe(struct btrfs_root *extent_root,
 		goto out;
 	get_extent_info(&path, &extent_start, &extent_len,
 			&extent_flags, &extent_gen);
+	if (extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK)
+		stripe->nr_meta_extents++;
+	if (extent_flags & BTRFS_EXTENT_FLAG_DATA)
+		stripe->nr_data_extents++;
+
 	cur_logical = max(extent_start, cur_logical);
 
 	/*
@@ -3662,6 +3679,10 @@ int scrub2_find_fill_first_stripe(struct btrfs_root *extent_root,
 		}
 		get_extent_info(&path, &extent_start, &extent_len,
 				&extent_flags, &extent_gen);
+		if (extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK)
+			stripe->nr_meta_extents++;
+		if (extent_flags & BTRFS_EXTENT_FLAG_DATA)
+			stripe->nr_data_extents++;
 		fill_one_extent_info(fs_info, stripe, extent_start, extent_len,
 				     extent_flags, extent_gen);
 		cur_logical = extent_start + extent_len;
@@ -4075,6 +4096,132 @@ void scrub2_repair_one_stripe(struct scrub2_stripe *stripe)
 		      &stripe->current_error_bitmap, stripe->nr_sectors);
 }
 
+void scrub2_report_errors(struct scrub_ctx *sctx,
+			  struct scrub2_stripe *stripe)
+{
+	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
+				      DEFAULT_RATELIMIT_BURST);
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	struct btrfs_device *dev = NULL;
+	u64 physical = 0;
+	int nr_data_sectors = 0;
+	int nr_meta_sectors = 0;
+	int nr_nodatacsum_sectors = 0;
+	int nr_repaired_sectors = 0;
+	int sector_nr;
+
+	/*
+	 * Init needed infos for error reporting, as although our scrub2
+	 * infrastucture is all based on btrfs_submit_bio() thus no need for
+	 * dev/physical.
+	 *
+	 * But our error reporting system still needs dev and physical.
+	 */
+	if (!bitmap_empty(&stripe->init_error_bitmap, stripe->nr_sectors)) {
+		u64 mapped_len = fs_info->sectorsize;
+		struct btrfs_io_context *bioc = NULL;
+		int stripe_index = stripe->mirror_num - 1;
+		int ret;
+
+		/* For scrub, our mirror_num should always start at 1. */
+		ASSERT(stripe->mirror_num >= 1);
+		ret = btrfs_map_sblock(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
+				      stripe->logical, &mapped_len, &bioc);
+		/*
+		 * If we failed, sblock->sctx will be NULL, and later detailed
+		 * reports will just be skipped.
+		 */
+		if (ret < 0)
+			goto skip;
+		physical = bioc->stripes[stripe_index].physical;
+		dev = bioc->stripes[stripe_index].dev;
+		btrfs_put_bioc(bioc);
+	}
+
+skip:
+	for_each_set_bit(sector_nr, &stripe->used_sector_bitmap,
+			 stripe->nr_sectors) {
+		bool repaired = false;
+
+		if (stripe->sectors[sector_nr].is_metadata) {
+			nr_meta_sectors++;
+		} else {
+			nr_data_sectors++;
+			if (!stripe->sectors[sector_nr].csum)
+				nr_nodatacsum_sectors++;
+		}
+
+		if (test_bit(sector_nr, &stripe->init_error_bitmap) &&
+		    !test_bit(sector_nr, &stripe->current_error_bitmap)) {
+			nr_repaired_sectors++;
+			repaired = true;
+		}
+
+		/* Good sector from the beginning, nothing need to be done. */
+		if (!test_bit(sector_nr, &stripe->init_error_bitmap))
+			continue;
+
+		/*
+		 * Report error for the corrupted sectors.
+		 * If repaired, just output the message of repaired message.
+		 */
+		if (repaired) {
+			if (dev)
+				btrfs_err_rl_in_rcu(fs_info,
+			"fixed up error at logical %llu on dev %s physical %llu",
+					    stripe->logical, btrfs_dev_name(dev),
+					    physical);
+			else
+				btrfs_err_rl_in_rcu(fs_info,
+			"fixed up error at logical %llu on mirror %u",
+					    stripe->logical, stripe->mirror_num);
+			continue;
+		}
+
+		/* The remaining are all for unrepaired. */
+		if (dev)
+			btrfs_err_rl_in_rcu(fs_info,
+	"unable to fixup (regular) error at logical %llu on dev %s physical %llu",
+					    stripe->logical, btrfs_dev_name(dev),
+					    physical);
+		else
+			btrfs_err_rl_in_rcu(fs_info,
+	"unable to fixup (regular) error at logical %llu on mirror %u",
+					    stripe->logical, stripe->mirror_num);
+
+		if (test_bit(sector_nr, &stripe->io_error_bitmap))
+			if (__ratelimit(&rs) && dev)
+				scrub2_print_warning("i/o error", dev, false,
+						     stripe->logical, physical);
+		if (test_bit(sector_nr, &stripe->csum_error_bitmap))
+			if (__ratelimit(&rs) && dev)
+				scrub2_print_warning("checksum error", dev, false,
+						     stripe->logical, physical);
+		if (test_bit(sector_nr, &stripe->meta_error_bitmap))
+			if (__ratelimit(&rs) && dev)
+				scrub2_print_warning("header error", dev, false,
+						     stripe->logical, physical);
+	}
+
+	spin_lock(&sctx->stat_lock);
+	sctx->stat.data_extents_scrubbed += stripe->nr_data_extents;
+	sctx->stat.tree_extents_scrubbed += stripe->nr_meta_extents;
+	sctx->stat.data_bytes_scrubbed += nr_data_sectors <<
+					  fs_info->sectorsize_bits;
+	sctx->stat.tree_bytes_scrubbed += nr_meta_sectors <<
+					  fs_info->sectorsize_bits;
+	sctx->stat.read_errors +=
+		bitmap_weight(&stripe->io_error_bitmap, stripe->nr_sectors);
+	sctx->stat.csum_errors +=
+		bitmap_weight(&stripe->csum_error_bitmap, stripe->nr_sectors);
+	sctx->stat.verify_errors +=
+		bitmap_weight(&stripe->meta_error_bitmap, stripe->nr_sectors);
+	sctx->stat.uncorrectable_errors +=
+		bitmap_weight(&stripe->current_error_bitmap, stripe->nr_sectors);
+	sctx->stat.corrected_errors += nr_repaired_sectors;
+	spin_unlock(&sctx->stat_lock);
+}
+
 /*
  * Scrub one range which can only has simple mirror based profile.
  * (Including all range in SINGLE/DUP/RAID1/RAID1C*, and each stripe in
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index a9519214bd41..362742692a29 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -28,5 +28,7 @@ int scrub2_find_fill_first_stripe(struct btrfs_root *extent_root,
 void scrub2_repair_one_stripe(struct scrub2_stripe *stripe);
 void scrub2_writeback_sectors(struct scrub2_stripe *stripe,
 			      unsigned long *write_bitmap);
+void scrub2_report_errors(struct scrub_ctx *sctx,
+			  struct scrub2_stripe *stripe);
 
 #endif
-- 
2.38.1

