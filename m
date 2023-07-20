Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A228E75AC53
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 12:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjGTKsq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 06:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjGTKsl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 06:48:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989961996
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 03:48:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2A57022BDF
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 10:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689850115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1elvpPmA4FI6avCXOgQkXvHZQTxe7+KyW6AH0uwhms8=;
        b=mdsJLrIbw3N3uHgVTpFTHEF54uDflXhs3YLh+9RdkegEZ6teKCq1OgEh/rvgbiuMKgvXru
        cmuNYcAtCddoVjKGtaFkGS89lU2aPaqHVwKNhKk+Lvj/3L1SGfDH3YIGdb5Z5v+QeQBAoZ
        EiJAaA+FPmrdASfFuuk3PsmYwaj8HEg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 739CD133DD
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 10:48:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8H3JDgIRuWQBcQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 10:48:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs: scrub: avoid unnecessary extent tree search preparing stripes
Date:   Thu, 20 Jul 2023 18:48:11 +0800
Message-ID: <a03b32b15e44b8a57e4330bf33f398f9243e7fe0.1689849582.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689849582.git.wqu@suse.com>
References: <cover.1689849582.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since commit e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror()
to scrub_stripe infrastructure"), scrub no longer re-use the same path
for extent tree search.

This can lead to unnecessary extent tree search, especially for the new
stripe based scrub, as we have way more stripes to prepare.

This patch would re-introduce a shared path for extent tree search, and
properly release it when the block group is scrubbed.

With this change alone, it can already improve the performance of scrub
on NVME to around 2.2GiB/s, as this reduces the time to prepare stripes:

 Device        r/s      rkB/s   rrqm/s  %rrqm r_await rareq-sz aqu-sz  %util
 nvme0n1p3 5066.00 2364144.00 31983.00  86.33    0.50   466.67   2.53 100.00

Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 3b09d359c914..2b6888ff4a50 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -189,6 +189,7 @@ struct scrub_ctx {
 	struct scrub_stripe	stripes[SCRUB_STRIPES_PER_SCTX];
 	struct scrub_stripe	*raid56_data_stripes;
 	struct btrfs_fs_info	*fs_info;
+	struct btrfs_path	extent_path;
 	int			first_free;
 	int			cur_stripe;
 	atomic_t		cancel_req;
@@ -353,6 +354,8 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 	refcount_set(&sctx->refs, 1);
 	sctx->is_dev_replace = is_dev_replace;
 	sctx->fs_info = fs_info;
+	sctx->extent_path.search_commit_root = 1;
+	sctx->extent_path.skip_locking = 1;
 	for (i = 0; i < SCRUB_STRIPES_PER_SCTX; i++) {
 		int ret;
 
@@ -1480,6 +1483,7 @@ static void scrub_stripe_reset_bitmaps(struct scrub_stripe *stripe)
  * Return <0 for error.
  */
 static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
+					struct btrfs_path *extent_path,
 					struct btrfs_device *dev, u64 physical,
 					int mirror_num, u64 logical_start,
 					u32 logical_len,
@@ -1489,7 +1493,6 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, bg->start);
 	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, bg->start);
 	const u64 logical_end = logical_start + logical_len;
-	struct btrfs_path path = { 0 };
 	u64 cur_logical = logical_start;
 	u64 stripe_end;
 	u64 extent_start;
@@ -1505,14 +1508,13 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 	/* The range must be inside the bg. */
 	ASSERT(logical_start >= bg->start && logical_end <= bg->start + bg->length);
 
-	path.search_commit_root = 1;
-	path.skip_locking = 1;
-
-	ret = find_first_extent_item(extent_root, &path, logical_start, logical_len);
+	ret = find_first_extent_item(extent_root, extent_path, logical_start,
+				     logical_len);
 	/* Either error or not found. */
 	if (ret)
 		goto out;
-	get_extent_info(&path, &extent_start, &extent_len, &extent_flags, &extent_gen);
+	get_extent_info(extent_path, &extent_start, &extent_len, &extent_flags,
+			&extent_gen);
 	if (extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK)
 		stripe->nr_meta_extents++;
 	if (extent_flags & BTRFS_EXTENT_FLAG_DATA)
@@ -1540,7 +1542,7 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 
 	/* Fill the extent info for the remaining sectors. */
 	while (cur_logical <= stripe_end) {
-		ret = find_first_extent_item(extent_root, &path, cur_logical,
+		ret = find_first_extent_item(extent_root, extent_path, cur_logical,
 					     stripe_end - cur_logical + 1);
 		if (ret < 0)
 			goto out;
@@ -1548,7 +1550,7 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 			ret = 0;
 			break;
 		}
-		get_extent_info(&path, &extent_start, &extent_len,
+		get_extent_info(extent_path, &extent_start, &extent_len,
 				&extent_flags, &extent_gen);
 		if (extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK)
 			stripe->nr_meta_extents++;
@@ -1588,7 +1590,6 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 	}
 	set_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state);
 out:
-	btrfs_release_path(&path);
 	return ret;
 }
 
@@ -1784,8 +1785,9 @@ static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *
 	ASSERT(sctx->cur_stripe < SCRUB_STRIPES_PER_SCTX);
 	stripe = &sctx->stripes[sctx->cur_stripe];
 	scrub_reset_stripe(stripe);
-	ret = scrub_find_fill_first_stripe(bg, dev, physical, mirror_num,
-					   logical, length, stripe);
+	ret = scrub_find_fill_first_stripe(bg, &sctx->extent_path, dev,
+					   physical, mirror_num, logical,
+					   length, stripe);
 	/* Either >0 as no more extents or <0 for error. */
 	if (ret)
 		return ret;
@@ -1825,6 +1827,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_raid_bio *rbio;
 	struct btrfs_io_context *bioc = NULL;
+	struct btrfs_path extent_path = { 0 };
 	struct bio *bio;
 	struct scrub_stripe *stripe;
 	bool all_empty = true;
@@ -1835,6 +1838,14 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 
 	ASSERT(sctx->raid56_data_stripes);
 
+	/*
+	 * For data stripe search, we can not re-use the same extent path, as
+	 * the data stripe bytenr may be smaller than previous extent.
+	 * Thus we have to use our own extent path.
+	 */
+	extent_path.search_commit_root = 1;
+	extent_path.skip_locking = 1;
+
 	for (int i = 0; i < data_stripes; i++) {
 		int stripe_index;
 		int rot;
@@ -1849,7 +1860,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 
 		scrub_reset_stripe(stripe);
 		set_bit(SCRUB_STRIPE_FLAG_NO_REPORT, &stripe->state);
-		ret = scrub_find_fill_first_stripe(bg,
+		ret = scrub_find_fill_first_stripe(bg, &extent_path,
 				map->stripes[stripe_index].dev, physical, 1,
 				full_stripe_start + btrfs_stripe_nr_to_offset(i),
 				BTRFS_STRIPE_LEN, stripe);
@@ -1977,6 +1988,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	bio_put(bio);
 	btrfs_bio_counter_dec(fs_info);
 
+	btrfs_release_path(&extent_path);
 out:
 	return ret;
 }
@@ -2143,6 +2155,9 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	u64 stripe_logical;
 	int stop_loop = 0;
 
+	/* Extent_path should be probably released. */
+	ASSERT(sctx->extent_path.nodes[0] == NULL);
+
 	scrub_blocked_if_needed(fs_info);
 
 	if (sctx->is_dev_replace &&
@@ -2261,6 +2276,8 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	ret2 = flush_scrub_stripes(sctx);
 	if (!ret)
 		ret = ret2;
+	btrfs_release_path(&sctx->extent_path);
+
 	if (sctx->raid56_data_stripes) {
 		for (int i = 0; i < nr_data_stripes(map); i++)
 			release_scrub_stripe(&sctx->raid56_data_stripes[i]);
-- 
2.41.0

