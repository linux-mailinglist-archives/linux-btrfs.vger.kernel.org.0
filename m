Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4F166B7C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 08:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjAPHE5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Jan 2023 02:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjAPHEw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 02:04:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B52D8A5B
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Jan 2023 23:04:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 269D567473
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673852690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BoHb1DpbQ0DvWQtKIwZKk1gDcyW9HJKVIDdLJqlm0Ck=;
        b=hUwJAMKOZ0zLPLvLuSn3fz+LH82VxOV+D8E31bkPv2l/znx6+myt4Cz1U4PLSUSPXi3501
        z7Z7M4pjyqYgJKChrJfcutxGpoHUHVDIYbg85+JQTi93AFfUpxpngc46R65KzJBNXBDgK8
        wyuKOliToHglcMD9BfjFpdkwccFYmoo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 80A9D138FA
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0Pk2ExH3xGMfZwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/11] btrfs: scrub: introduce error reporting functionality for scrub_stripe
Date:   Mon, 16 Jan 2023 15:04:21 +0800
Message-Id: <2e84987377c2ff1346fb73a7e8f630b52ac0b063.1673851704.git.wqu@suse.com>
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

The new helper, scrub_report_stripe_errors(), will report the result of the
scrub to dmesg.

The main reporting is done by introducing a new helper,
scrub_print_common_warning(), which is mostly the same content from
scrub_print_wanring(), but without the need for a scrub_block.

Since we're reporting the errors, it's the perfect timing to update the
scrub stat too.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 163 ++++++++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/scrub.h |   2 +
 2 files changed, 156 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 638dece0b863..d587ca1fb8e7 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -112,6 +112,13 @@ struct scrub_stripe {
 	/* Should be BTRFS_STRIPE_LEN / sectorsize. */
 	u16 nr_sectors;
 
+	/*
+	 * How many data/meta extents are in this stripe.
+	 * Only for scrub stat report purpose.
+	 */
+	u16 nr_data_extents;
+	u16 nr_meta_extents;
+
 	atomic_t pending_io;
 	wait_queue_head_t io_wait;
 
@@ -1094,9 +1101,9 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 	return 0;
 }
 
-static void scrub_print_warning(const char *errstr, struct scrub_block *sblock)
+static void scrub_print_common_warning(const char *errstr, struct btrfs_device *dev,
+				       bool is_super, u64 logical, u64 physical)
 {
-	struct btrfs_device *dev;
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_path *path;
 	struct btrfs_key found_key;
@@ -1110,22 +1117,20 @@ static void scrub_print_warning(const char *errstr, struct scrub_block *sblock)
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
 
@@ -1174,6 +1179,13 @@ static void scrub_print_warning(const char *errstr, struct scrub_block *sblock)
 	btrfs_free_path(path);
 }
 
+static void scrub_print_warning(const char *errstr, struct scrub_block *sblock)
+{
+	scrub_print_common_warning(errstr, sblock->dev,
+			sblock->sectors[0]->flags & BTRFS_EXTENT_FLAG_SUPER,
+			sblock->logical, sblock->physical);
+}
+
 static inline void scrub_get_recover(struct scrub_recover *recover)
 {
 	refcount_inc(&recover->refs);
@@ -2666,6 +2678,131 @@ int scrub_repair_one_stripe(struct scrub_stripe *stripe)
 	return ret;
 }
 
+void scrub_report_stripe_errors(struct scrub_ctx *sctx,
+				struct scrub_stripe *stripe)
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
+	 * Init needed infos for error reporting.
+	 *
+	 * Although our scrub_stripe infrastucture is mostly based on btrfs_submit_bio()
+	 * thus no need for dev/physical, error reporting still needs dev and physical.
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
+		 * If we failed, dev will be NULL, and later detailed reports
+		 * will just be skipped.
+		 */
+		if (ret < 0)
+			goto skip;
+		physical = bioc->stripes[stripe_index].physical;
+		dev = bioc->stripes[stripe_index].dev;
+		btrfs_put_bioc(bioc);
+	}
+
+skip:
+	for_each_set_bit(sector_nr, &stripe->extent_sector_bitmap,
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
+				scrub_print_common_warning("i/o error", dev, false,
+						     stripe->logical, physical);
+		if (test_bit(sector_nr, &stripe->csum_error_bitmap))
+			if (__ratelimit(&rs) && dev)
+				scrub_print_common_warning("checksum error", dev, false,
+						     stripe->logical, physical);
+		if (test_bit(sector_nr, &stripe->meta_error_bitmap))
+			if (__ratelimit(&rs) && dev)
+				scrub_print_common_warning("header error", dev, false,
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
 static int scrub_checksum_tree_block(struct scrub_block *sblock)
 {
 	struct scrub_ctx *sctx = sblock->sctx;
@@ -4114,6 +4251,10 @@ int scrub_find_fill_first_stripe(struct btrfs_root *extent_root,
 		goto out;
 	get_extent_info(&path, &extent_start, &extent_len,
 			&extent_flags, &extent_gen);
+	if (extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK)
+		stripe->nr_meta_extents++;
+	if (extent_flags & BTRFS_EXTENT_FLAG_DATA)
+		stripe->nr_data_extents++;
 	cur_logical = max(extent_start, cur_logical);
 
 	/*
@@ -4143,6 +4284,10 @@ int scrub_find_fill_first_stripe(struct btrfs_root *extent_root,
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
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index 03f84acd31ce..fc294a250945 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -28,5 +28,7 @@ void scrub_write_wait_sectors(struct scrub_ctx *sctx,
 			      struct scrub_stripe *stripe,
 			      struct btrfs_device *dev, u64 physical,
 			      unsigned long *write_bitmap);
+void scrub_report_stripe_errors(struct scrub_ctx *sctx,
+				struct scrub_stripe *stripe);
 
 #endif
-- 
2.39.0

