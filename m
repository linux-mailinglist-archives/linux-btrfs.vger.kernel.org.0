Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8A0766B81
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 13:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbjG1LOc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jul 2023 07:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbjG1LOb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jul 2023 07:14:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE177271D
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 04:14:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8F80B219B7
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 11:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690542868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ExJM3ITVtLsCodx9mjCHEfqPrTKGDzZfElD6esR7FFs=;
        b=WttaH7oOppNbd5BTIzxXQjg7+liKWybvbd7TnlININqsoh8n5rRVAwQZI3Wicqh90eSrKt
        P7NmVmc4e+jOP/vUt4lR6vJ7a/s8YgcSEo65R4WDF8f7GwYxHaDfaJQbstHNnakY04/nkP
        r5TyoskXqqvdG03A95eRrlOqt0Eem5I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC3A1133F7
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 11:14:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gBZkKBOjw2RBQAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 11:14:27 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs: scrub: avoid unnecessary extent tree search preparing stripes
Date:   Fri, 28 Jul 2023 19:14:04 +0800
Message-ID: <4b64a2fb88ea924ccb531ed979011e71429682d8.1690542141.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690542141.git.wqu@suse.com>
References: <cover.1690542141.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

This change alone can improve scrub performance slightly by reducing the
time spend preparing the stripe thus improving the queue depth.

Before (with regression):

 Device         r/s      rkB/s   rrqm/s  %rrqm r_await rareq-sz aqu-sz  %util
 nvme0n1p3 15578.00  993616.00     5.00   0.03    0.09    63.78   1.32 100.00

After (with this patch):

 nvme0n1p3 15875.00 1013328.00    12.00   0.08    0.08    63.83   1.35 100.00

Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index db076e12f442..d10afe94096f 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -175,6 +175,7 @@ struct scrub_ctx {
 	struct scrub_stripe	stripes[SCRUB_STRIPES_PER_SCTX];
 	struct scrub_stripe	*raid56_data_stripes;
 	struct btrfs_fs_info	*fs_info;
+	struct btrfs_path	extent_path;
 	int			first_free;
 	int			cur_stripe;
 	atomic_t		cancel_req;
@@ -339,6 +340,8 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 	refcount_set(&sctx->refs, 1);
 	sctx->is_dev_replace = is_dev_replace;
 	sctx->fs_info = fs_info;
+	sctx->extent_path.search_commit_root = 1;
+	sctx->extent_path.skip_locking = 1;
 	for (i = 0; i < SCRUB_STRIPES_PER_SCTX; i++) {
 		int ret;
 
@@ -1466,6 +1469,7 @@ static void scrub_stripe_reset_bitmaps(struct scrub_stripe *stripe)
  * Return <0 for error.
  */
 static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
+					struct btrfs_path *extent_path,
 					struct btrfs_device *dev, u64 physical,
 					int mirror_num, u64 logical_start,
 					u32 logical_len,
@@ -1475,7 +1479,6 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, bg->start);
 	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, bg->start);
 	const u64 logical_end = logical_start + logical_len;
-	struct btrfs_path path = { 0 };
 	u64 cur_logical = logical_start;
 	u64 stripe_end;
 	u64 extent_start;
@@ -1491,14 +1494,13 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
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
@@ -1526,7 +1528,7 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 
 	/* Fill the extent info for the remaining sectors. */
 	while (cur_logical <= stripe_end) {
-		ret = find_first_extent_item(extent_root, &path, cur_logical,
+		ret = find_first_extent_item(extent_root, extent_path, cur_logical,
 					     stripe_end - cur_logical + 1);
 		if (ret < 0)
 			goto out;
@@ -1534,7 +1536,7 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 			ret = 0;
 			break;
 		}
-		get_extent_info(&path, &extent_start, &extent_len,
+		get_extent_info(extent_path, &extent_start, &extent_len,
 				&extent_flags, &extent_gen);
 		if (extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK)
 			stripe->nr_meta_extents++;
@@ -1574,7 +1576,6 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 	}
 	set_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state);
 out:
-	btrfs_release_path(&path);
 	return ret;
 }
 
@@ -1764,8 +1765,9 @@ static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *
 
 	/* We can queue one stripe using the remaining slot. */
 	scrub_reset_stripe(stripe);
-	ret = scrub_find_fill_first_stripe(bg, dev, physical, mirror_num,
-					   logical, length, stripe);
+	ret = scrub_find_fill_first_stripe(bg, &sctx->extent_path, dev,
+					   physical, mirror_num, logical,
+					   length, stripe);
 	/* Either >0 as no more extents or <0 for error. */
 	if (ret)
 		return ret;
@@ -1783,6 +1785,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_raid_bio *rbio;
 	struct btrfs_io_context *bioc = NULL;
+	struct btrfs_path extent_path = { 0 };
 	struct bio *bio;
 	struct scrub_stripe *stripe;
 	bool all_empty = true;
@@ -1793,6 +1796,14 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 
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
@@ -1807,7 +1818,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 
 		scrub_reset_stripe(stripe);
 		set_bit(SCRUB_STRIPE_FLAG_NO_REPORT, &stripe->state);
-		ret = scrub_find_fill_first_stripe(bg,
+		ret = scrub_find_fill_first_stripe(bg, &extent_path,
 				map->stripes[stripe_index].dev, physical, 1,
 				full_stripe_start + btrfs_stripe_nr_to_offset(i),
 				BTRFS_STRIPE_LEN, stripe);
@@ -1935,6 +1946,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	bio_put(bio);
 	btrfs_bio_counter_dec(fs_info);
 
+	btrfs_release_path(&extent_path);
 out:
 	return ret;
 }
@@ -2102,6 +2114,9 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	u64 stripe_logical;
 	int stop_loop = 0;
 
+	/* Extent_path should be probably released. */
+	ASSERT(sctx->extent_path.nodes[0] == NULL);
+
 	scrub_blocked_if_needed(fs_info);
 
 	if (sctx->is_dev_replace &&
@@ -2220,6 +2235,8 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
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

