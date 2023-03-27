Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF996CB264
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 01:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjC0Xbi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 19:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjC0Xbh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 19:31:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6701BEE
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 16:31:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2CD3A1FD82;
        Mon, 27 Mar 2023 23:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679959894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OcZ4FoZMnL2v60NRI5xtr4Tb1ax2Qzkx87FRi83x0h0=;
        b=WjEnSbasf19/I2vL+zW7JjanVw3ddVSHRZF1zn7OdHAGOZZvr4eB/bCpWnmG4VD1V1TfdQ
        J7MJhCoAepEVLCO9le1uxGN3CAnUHX+SAbvzAisSguqI3e7JDqx53aV+j9ikLXCkL5C1O/
        HcPnIJe7Qp0T1KwhGKC2z0vwdyBuog0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 617E513482;
        Mon, 27 Mar 2023 23:31:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gD1KDFUnImTaaAAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 27 Mar 2023 23:31:33 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v5 11/13] btrfs: scrub: introduce error reporting functionality for scrub_stripe
Date:   Tue, 28 Mar 2023 07:31:01 +0800
Message-Id: <ae57baabc0a61ddf21b1e24a2842f26003929ed8.1679959770.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679959770.git.wqu@suse.com>
References: <cover.1679959770.git.wqu@suse.com>
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

The new helper, scrub_stripe_report_errors(), will report the result of the
scrub to dmesg.

The main reporting is done by introducing a new helper,
scrub_print_common_warning(), which is mostly the same content from
scrub_print_wanring(), but without the need for a scrub_block.

Since we're reporting the errors, it's the perfect timing to update the
scrub stat too.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 167 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 158 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 7283b111c471..793c17652851 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -105,6 +105,7 @@ enum scrub_stripe_flags {
  * Represent one continuous range with a length of BTRFS_STRIPE_LEN.
  */
 struct scrub_stripe {
+	struct scrub_ctx *sctx;
 	struct btrfs_block_group *bg;
 
 	struct page *pages[SCRUB_STRIPE_PAGES];
@@ -119,6 +120,13 @@ struct scrub_stripe {
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
 	wait_queue_head_t repair_wait;
@@ -377,6 +385,7 @@ static void release_scrub_stripe(struct scrub_stripe *stripe)
 	kfree(stripe->csums);
 	stripe->sectors = NULL;
 	stripe->csums = NULL;
+	stripe->sctx = NULL;
 	stripe->state = 0;
 }
 
@@ -1046,9 +1055,9 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
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
@@ -1062,22 +1071,20 @@ static void scrub_print_warning(const char *errstr, struct scrub_block *sblock)
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
 
@@ -1126,6 +1133,13 @@ static void scrub_print_warning(const char *errstr, struct scrub_block *sblock)
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
@@ -2470,6 +2484,132 @@ static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
 	}
 }
 
+static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
+				       struct scrub_stripe *stripe)
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
+		    !test_bit(sector_nr, &stripe->error_bitmap)) {
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
+	sctx->stat.no_csum += nr_nodatacsum_sectors;
+	sctx->stat.read_errors +=
+		bitmap_weight(&stripe->io_error_bitmap, stripe->nr_sectors);
+	sctx->stat.csum_errors +=
+		bitmap_weight(&stripe->csum_error_bitmap, stripe->nr_sectors);
+	sctx->stat.verify_errors +=
+		bitmap_weight(&stripe->meta_error_bitmap, stripe->nr_sectors);
+	sctx->stat.uncorrectable_errors +=
+		bitmap_weight(&stripe->error_bitmap, stripe->nr_sectors);
+	sctx->stat.corrected_errors += nr_repaired_sectors;
+	spin_unlock(&sctx->stat_lock);
+}
+
 /*
  * The main entrance for all read related scrub work, including:
  *
@@ -2544,6 +2684,7 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
 			goto out;
 	}
 out:
+	scrub_stripe_report_errors(stripe->sctx, stripe);
 	set_bit(SCRUB_STRIPE_FLAG_REPAIR_DONE, &stripe->state);
 	wake_up(&stripe->repair_wait);
 }
@@ -4212,6 +4353,10 @@ int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 		goto out;
 	get_extent_info(&path, &extent_start, &extent_len,
 			&extent_flags, &extent_gen);
+	if (extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK)
+		stripe->nr_meta_extents++;
+	if (extent_flags & BTRFS_EXTENT_FLAG_DATA)
+		stripe->nr_data_extents++;
 	cur_logical = max(extent_start, cur_logical);
 
 	/*
@@ -4245,6 +4390,10 @@ int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
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
-- 
2.39.2

