Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981C85ED7E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Sep 2022 10:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiI1IgW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Sep 2022 04:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbiI1IgO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Sep 2022 04:36:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9149DF90
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 01:36:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD9371F8F1
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664354171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PaguHnmT6MOhZWpIeFYchl5K66Gukh6weDs8K8BRlPg=;
        b=vHdhqU0N1OPjzaSELhbPS1txre7rHPBCH1SuLlZ5FDIEsCmF8d/98RRlT2QgQSn6xx5vIP
        9+BSr1JDTgvJbF3cQMyU0pzZMzG5+Ng+mRzVycVvfwqAcJTU+i66HIZ/PWpJsriDk99W5G
        Ml4Yl3/DLEI+99E5nbgH/M8r6bGcP3I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 346B813A84
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4JOcOnoHNGO2VgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH PoC v2 05/10] btrfs: scrub: add helpers to fulfill csum/extent_generation
Date:   Wed, 28 Sep 2022 16:35:42 +0800
Message-Id: <b8f32c839295b76dc768b5062e571cae42990c3d.1664353497.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664353497.git.wqu@suse.com>
References: <cover.1664353497.git.wqu@suse.com>
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

This patch will introduce two new major helpers:

- scrub_fs_locate_and_fill_stripe()
  This will find a stripe which contains any extent.
  And then fill corresponding sectors inside sectors[] array with its
  extent_type.

  If it's a metadata extent, it will also fill eb_generation member.

- scrub_fs_fill_stripe_csum()
  This is for data block groups only.

  This helper will find all csums for the stripe, and copy the csum into
  the corresponding position inside scrub_fs_ctx->csum_buf.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 308 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 306 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 6e6c50962ace..f04d2e552666 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -4535,6 +4535,21 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	return ret;
 }
 
+static void scrub_fs_check_sector_mirror_nr(struct scrub_fs_ctx *sfctx,
+					    int sector_nr, int mirror_nr)
+{
+	/* Basic boudary checks. */
+	ASSERT(sector_nr >= 0 && sector_nr < sfctx->sectors_per_stripe);
+	ASSERT(mirror_nr >= 0 && mirror_nr < sfctx->nr_copies);
+}
+
+static struct scrub_fs_sector *scrub_fs_get_sector(struct scrub_fs_ctx *sfctx,
+						   int sector_nr, int mirror_nr)
+{
+	scrub_fs_check_sector_mirror_nr(sfctx, sector_nr, mirror_nr);
+	return &sfctx->sectors[mirror_nr * sfctx->sectors_per_stripe + sector_nr];
+}
+
 static struct scrub_fs_ctx *scrub_fs_alloc_ctx(struct btrfs_fs_info *fs_info,
 					       bool readonly)
 {
@@ -4676,10 +4691,264 @@ static int scrub_fs_init_for_bg(struct scrub_fs_ctx *sfctx,
 	return -ENOMEM;
 }
 
+static int scrub_fs_fill_sector_types(struct scrub_fs_ctx *sfctx,
+				      u64 stripe_start, u64 extent_start,
+				      u64 extent_len, u64 extent_flags,
+				      u64 extent_gen)
+{
+	struct btrfs_fs_info *fs_info = sfctx->fs_info;
+	const u64 stripe_end = stripe_start + (sfctx->sectors_per_stripe <<
+					       fs_info->sectorsize_bits);
+	const u64 real_start = max(stripe_start, extent_start);
+	const u64 real_len = min(stripe_end, extent_start + extent_len) - real_start;
+	bool is_meta = false;
+	u64 cur_logical;
+	int sector_flags;
+
+	if (extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
+		sector_flags = SCRUB_FS_SECTOR_FLAG_META;
+		is_meta = true;
+		/* Metadata should never corss stripe boundary. */
+		if (extent_start != real_start) {
+			btrfs_err(fs_info,
+				"tree block at bytenr %llu crossed stripe boundary",
+				extent_start);
+			return -EUCLEAN;
+		}
+	} else {
+		sector_flags = SCRUB_FS_SECTOR_FLAG_DATA;
+	}
+
+	for (cur_logical = real_start; cur_logical < real_start + real_len;
+	     cur_logical += fs_info->sectorsize) {
+		const int sector_nr = (cur_logical - stripe_start) >>
+				       fs_info->sectorsize_bits;
+		int mirror_nr;
+
+		for (mirror_nr = 0; mirror_nr < sfctx->nr_copies; mirror_nr++) {
+			struct scrub_fs_sector *sector =
+				scrub_fs_get_sector(sfctx, sector_nr, mirror_nr);
+
+			/*
+			 * All sectors in the range should have not been
+			 * initialized.
+			 */
+			ASSERT(sector->flags == SCRUB_FS_SECTOR_FLAG_UNUSED);
+			ASSERT(sector->csum == NULL);
+			ASSERT(sector->eb_generation == 0);
+
+			sector->flags = sector_flags;
+			/*
+			 * Here we only populate eb_*, for csum it will be later
+			 * filled in a dedicated csum tree search.
+			 */
+			if (is_meta) {
+				sector->eb_logical = extent_start;
+				sector->eb_generation = extent_gen;
+			}
+		}
+	}
+	return 0;
+}
+
+/*
+ * To locate a stripe where there is any extent inside it.
+ *
+ * @start:	logical bytenr to start the search. Result stripe should
+ *		be >= @start.
+ * @found_ret:	logical bytenr of the found stripe. Should also be a stripe start
+ *		bytenr.
+ *
+ * Return 0 if we found such stripe, and update @found_ret, furthermore, we will
+ * fill sfctx->stripes[] array with the needed extent info (generation for tree
+ * block, csum for data extents).
+ *
+ * Return <0 if we hit fatal errors.
+ *
+ * Return >0 if there is no more stripe containing any extent after @start.
+ */
+static int scrub_fs_locate_and_fill_stripe(struct scrub_fs_ctx *sfctx, u64 start,
+					   u64 *found_ret)
+{
+	struct btrfs_fs_info *fs_info = sfctx->fs_info;
+	struct btrfs_path path = {0};
+	struct btrfs_root *extent_root = btrfs_extent_root(fs_info,
+							   sfctx->cur_bg->start);
+	const u64 bg_start = sfctx->cur_bg->start;
+	const u64 bg_end = bg_start + sfctx->cur_bg->length;
+	const u32 stripe_len = sfctx->sectors_per_stripe << fs_info->sectorsize_bits;
+	u64 cur_logical = start;
+	/*
+	 * The full stripe start we found. If 0, it means we haven't yet found
+	 * any extent.
+	 */
+	u64 stripe_start = 0;
+	u64 extent_start;
+	u64 extent_size;
+	u64 extent_flags;
+	u64 extent_gen;
+	int ret;
+
+	path.search_commit_root = true;
+	path.skip_locking = true;
+
+	/* Initial search to find any extent inside the block group. */
+	ret = find_first_extent_item(extent_root, &path, cur_logical,
+				     bg_end - cur_logical);
+	/* Either error out or no more extent items. */
+	if (ret)
+		goto out;
+
+	get_extent_info(&path, &extent_start, &extent_size, &extent_flags,
+			&extent_gen);
+	/*
+	 * Note here a full stripe for RAID56 may not be power of 2, thus
+	 * we have to use rounddown(), not round_down().
+	 */
+	stripe_start = rounddown(max(extent_start, cur_logical) - bg_start,
+				 stripe_len) + bg_start;
+	*found_ret = stripe_start;
+
+	scrub_fs_fill_sector_types(sfctx, stripe_start, extent_start,
+				   extent_size, extent_flags, extent_gen);
+
+	cur_logical = min(stripe_start + stripe_len, extent_start + extent_size);
+
+	/* Now iterate all the remaining extents inside the stripe. */
+	while (cur_logical < stripe_start + stripe_len) {
+		ret = find_first_extent_item(extent_root, &path, cur_logical,
+				stripe_start + stripe_len - cur_logical);
+		if (ret)
+			goto out;
+
+		get_extent_info(&path, &extent_start, &extent_size,
+				&extent_flags, &extent_gen);
+		scrub_fs_fill_sector_types(sfctx, stripe_start, extent_start,
+					   extent_size, extent_flags, extent_gen);
+		cur_logical = extent_start + extent_size;
+	}
+out:
+	btrfs_release_path(&path);
+	/*
+	 * Found nothing, the first get_extent_info() returned error or no
+	 * extent found at all, just return @ret directly.
+	 */
+	if (!stripe_start)
+		return ret;
+
+	/*
+	 * Now we have hit at least one extent, if ret > 0, then it means
+	 * we still need to handle the extents we found, in that case we
+	 * return 0, so we will scrub what we found.
+	 */
+	if (ret > 0)
+		ret = 0;
+	return ret;
+}
+
+static void scrub_fs_fill_one_ordered_sum(struct scrub_fs_ctx *sfctx,
+					  struct btrfs_ordered_sum *sum)
+{
+	struct btrfs_fs_info *fs_info = sfctx->fs_info;
+	const u64 stripe_start = sfctx->cur_logical;
+	const u32 stripe_len = sfctx->sectors_per_stripe <<
+			       fs_info->sectorsize_bits;
+	u64 cur;
+
+	ASSERT(stripe_start <= sum->bytenr &&
+	       sum->bytenr + sum->len <= stripe_start + stripe_len);
+
+	for (cur = sum->bytenr; cur < sum->bytenr + sum->len;
+	     cur += fs_info->sectorsize) {
+		int sector_nr = (cur - stripe_start) >> fs_info->sectorsize_bits;
+		int mirror_nr;
+		u8 *csum = sum->sums + (((cur - sum->bytenr) >>
+					fs_info->sectorsize_bits) * fs_info->csum_size);
+
+		/* Fill csum_buf first. */
+		memcpy(sfctx->csum_buf + sector_nr * fs_info->csum_size,
+		       csum, fs_info->csum_size);
+
+		/* Make sectors in all mirrors to point to the correct csum. */
+		for (mirror_nr = 0; mirror_nr < sfctx->nr_copies; mirror_nr++) {
+			struct scrub_fs_sector *sector =
+				scrub_fs_get_sector(sfctx, sector_nr, mirror_nr);
+
+			ASSERT(sector->flags & SCRUB_FS_SECTOR_FLAG_DATA);
+			sector->csum = sfctx->csum_buf + sector_nr * fs_info->csum_size;
+		}
+	}
+}
+
+static int scrub_fs_fill_stripe_csum(struct scrub_fs_ctx *sfctx)
+{
+	struct btrfs_fs_info *fs_info = sfctx->fs_info;
+	struct btrfs_root *csum_root = btrfs_csum_root(fs_info,
+						       sfctx->cur_bg->start);
+	const u64 stripe_start = sfctx->cur_logical;
+	const u32 stripe_len = sfctx->sectors_per_stripe << fs_info->sectorsize_bits;
+	LIST_HEAD(csum_list);
+	int ret;
+
+	ret = btrfs_lookup_csums_range(csum_root, stripe_start,
+				       stripe_start + stripe_len - 1,
+				       &csum_list, true, false);
+	if (ret < 0)
+		return ret;
+
+	/* Extract csum_list and fill them into csum_buf. */
+	while (!list_empty(&csum_list)) {
+		struct btrfs_ordered_sum *sum;
+
+		sum = list_first_entry(&csum_list, struct btrfs_ordered_sum,
+				       list);
+		scrub_fs_fill_one_ordered_sum(sfctx, sum);
+		list_del(&sum->list);
+		kfree(sum);
+	}
+	return 0;
+}
+
+/*
+ * Reset the content of pages/csum_buf and reset sector types/csum, so
+ * no leftover data for the next run.
+ */
+static void scrub_fs_reset_stripe(struct scrub_fs_ctx *sfctx)
+{
+	struct btrfs_fs_info *fs_info = sfctx->fs_info;
+	const int nr_pages = (sfctx->total_sectors <<
+			      fs_info->sectorsize_bits) >> PAGE_SHIFT;
+	int i;
+
+	ASSERT(nr_pages);
+
+	/* Zero page content. */
+	for (i = 0; i < nr_pages; i++)
+		memzero_page(sfctx->pages[i], 0, PAGE_SIZE);
+
+	/* Zero csum_buf. */
+	if (sfctx->csum_buf)
+		memset(sfctx->csum_buf, 0, sfctx->sectors_per_stripe *
+		       fs_info->csum_size);
+
+	/* Clear sector types and its csum pointer. */
+	for (i = 0; i < sfctx->total_sectors; i++) {
+		struct scrub_fs_sector *sector = &sfctx->sectors[i];
+
+		sector->flags = SCRUB_FS_SECTOR_FLAG_UNUSED;
+		sector->csum = NULL;
+		sector->eb_generation = 0;
+		sector->eb_logical = 0;
+	}
+}
 
 static int scrub_fs_block_group(struct scrub_fs_ctx *sfctx,
 				struct btrfs_block_group *bg)
 {
+	const struct btrfs_fs_info *fs_info = sfctx->fs_info;
+	bool is_data = bg->flags & BTRFS_BLOCK_GROUP_DATA;
+	u32 stripe_len;
+	u64 cur_logical = bg->start;
 	int ret;
 
 	/* Not yet supported, just skip RAID56 bgs for now. */
@@ -4690,8 +4959,43 @@ static int scrub_fs_block_group(struct scrub_fs_ctx *sfctx,
 	if (ret < 0)
 		return ret;
 
-	/* Place holder for the loop itearting the sectors. */
-	ret = 0;
+	/*
+	 * We can only trust anything inside sfctx after
+	 * scrub_fs_init_for_bg().
+	 */
+	stripe_len = sfctx->sectors_per_stripe << fs_info->sectorsize_bits;
+	ASSERT(stripe_len);
+
+	while (cur_logical < bg->start + bg->length) {
+		u64 stripe_start;
+
+		ret = scrub_fs_locate_and_fill_stripe(sfctx, cur_logical,
+						      &stripe_start);
+		if (ret < 0)
+			break;
+
+		/* No more extent left in the bg, we have finished the bg. */
+		if (ret > 0) {
+			ret = 0;
+			break;
+		}
+
+		sfctx->cur_logical = stripe_start;
+
+		if (is_data) {
+			ret = scrub_fs_fill_stripe_csum(sfctx);
+			if (ret < 0)
+				break;
+		}
+
+		/* Place holder for real stripe scrubbing. */
+		ret = 0;
+
+		/* Reset the stripe for next run. */
+		scrub_fs_reset_stripe(sfctx);
+
+		cur_logical = stripe_start + stripe_len;
+	}
 
 	scrub_fs_cleanup_for_bg(sfctx);
 	return ret;
-- 
2.37.3

