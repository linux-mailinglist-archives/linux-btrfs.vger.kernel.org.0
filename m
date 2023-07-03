Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDC9745627
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 09:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjGCHdX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 03:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjGCHdT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 03:33:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523D1E54
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 00:33:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5B1BC1FD72
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688369591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vTUdZAf5MDy7R5LMoW/1oGwvHe6e7H3aRxC+YL6Ytao=;
        b=XR1tMtcmn5r556rsQEiAODWPXR3zPOYDFUfWwyGo6PnGGwV/nPEQMIGJdxuCXREe0cJC8k
        yxvtL9d/qZ7Z+LegNR22op2uf4qg+AlUGzk9vqXcCguBikN2WwaFtevYVad7/IHEwh+IIo
        urSmxyyYp5e2V22xAauER6F3vJJSg8U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0FCE13276
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:33:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ONlDHrZ5omRoVQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jul 2023 07:33:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 12/14] btrfs: scrub: add RAID56 support for queue_scrub_logical_stripes()
Date:   Mon,  3 Jul 2023 15:32:36 +0800
Message-ID: <9e1666311b1e944fd666e97f77af59b198717676.1688368617.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688368617.git.wqu@suse.com>
References: <cover.1688368617.git.wqu@suse.com>
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

There are several factors that needs to be considered for RAID56 full
stripe:

- Empty data stripes
  We still need those empty data stripes, as they may be involved in the
  P/Q recovery.

- P/Q stripes
  We need special handling for P/Q stripes.

So this patch introduce a new helper, queue_raid56_full_stripes() to
handle those special requirements.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 108 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 105 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 21b3fa55d0f0..f37b9fd30595 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -105,7 +105,7 @@ struct scrub_stripe {
 	u64 logical;
 	u64 physical;
 
-	u16 mirror_num;
+	s16 mirror_num;
 
 	/* Should be BTRFS_STRIPE_LEN / sectorsize. */
 	u16 nr_sectors;
@@ -3147,15 +3147,109 @@ static void scrub_copy_stripe(const struct scrub_stripe *src,
 	set_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &dst->state);
 }
 
+static int queue_raid56_full_stripes(struct scrub_ctx *sctx,
+			struct btrfs_block_group *bg, struct map_lookup *map,
+			u64 logical)
+{
+	const int num_stripes = map->num_stripes;
+	const int old_cur = sctx->cur_stripe;
+	const int data_stripes = nr_data_stripes(map);
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, bg->start);
+	struct btrfs_path path = { 0 };
+	unsigned long extents_bitmap = 0;
+	u64 extent_start;
+	u64 extent_len;
+	u64 extent_flags;
+	u64 extent_gen;
+	u64 full_stripe_start;
+	u32 full_stripe_nr;
+	int ret;
+
+	path.search_commit_root = 1;
+	path.skip_locking = 1;
+
+	ret = find_first_extent_item(extent_root, &path, logical,
+				     bg->start + bg->length - logical);
+	/* Error or no more extent found. */
+	if (ret)
+		return ret;
+	get_extent_info(&path, &extent_start, &extent_len, &extent_flags,
+			&extent_gen);
+	btrfs_release_path(&path);
+
+	full_stripe_nr = rounddown((extent_start - bg->start) >>
+				   BTRFS_STRIPE_LEN_SHIFT, data_stripes);
+	full_stripe_start = btrfs_stripe_nr_to_offset(full_stripe_nr) + bg->start;
+
+	for (int i = 0; i < data_stripes; i++) {
+		struct scrub_stripe *stripe = &sctx->stripes[old_cur + i];
+		u64 cur = full_stripe_start + btrfs_stripe_nr_to_offset(i);
+
+		scrub_reset_stripe(stripe);
+		ret = scrub_find_fill_first_stripe(bg, NULL, 0, 1, cur,
+						   BTRFS_STRIPE_LEN, stripe);
+		if (ret < 0)
+			return ret;
+		/*
+		 * No extent in the data stripe, we need to fill the info
+		 * manually.
+		 */
+		if (ret > 0) {
+			stripe->logical = cur;
+			stripe->physical = 0;
+			stripe->dev = NULL;
+			stripe->bg = bg;
+			stripe->mirror_num = 1;
+			set_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state);
+			ret = 0;
+		}
+		bitmap_or(&extents_bitmap, &extents_bitmap,
+			  &stripe->extent_sector_bitmap, stripe->nr_sectors);
+	}
+
+	/* Manually fill the P/Q stripes */
+	for (int i = 0; i < num_stripes - data_stripes; i++) {
+		struct scrub_stripe *stripe =
+			&sctx->stripes[old_cur + data_stripes + i];
+		scrub_reset_stripe(stripe);
+		/*
+		 * Use the logical of the last data stripes, so the caller
+		 * knows exactly where the next logical should start, no matter
+		 * if it's RAID56 or not.
+		 */
+		stripe->logical = full_stripe_start +
+				btrfs_stripe_nr_to_offset(data_stripes - 1);
+		stripe->dev = NULL;
+		stripe->bg = bg;
+		stripe->mirror_num = -1 - i;
+		bitmap_copy(&stripe->extent_sector_bitmap, &extents_bitmap,
+			    stripe->nr_sectors);
+		/*
+		 * For parity stripes, they don't need any csum checks,
+		 * so mark them as nocsum data.
+		 */
+		for (int sector = 0; sector < stripe->nr_sectors; sector++) {
+			stripe->sectors[sector].is_metadata = false;
+			stripe->sectors[sector].csum = NULL;
+		}
+		set_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state);
+	}
+	sctx->cur_stripe += num_stripes;
+	return 0;
+}
+
 /*
  * Unlike queue_scrub_stripe() which only queue one stripe, this queue all
  * mirrors for non-RAID56 profiles, or the full stripe for RAID56.
  */
 static int queue_scrub_logical_stripes(struct scrub_ctx *sctx,
-			struct btrfs_block_group *bg, u64 logical)
+			struct btrfs_block_group *bg, struct map_lookup *map,
+			u64 logical)
 {
 	const int nr_copies = btrfs_bg_type_to_factor(bg->flags);
 	const int old_cur = sctx->cur_stripe;
+	bool is_raid56 = bg->flags & BTRFS_BLOCK_GROUP_RAID56_MASK;
 	struct scrub_stripe *stripe;
 	int ret;
 
@@ -3168,6 +3262,14 @@ static int queue_scrub_logical_stripes(struct scrub_ctx *sctx,
 			return ret;
 	}
 
+	/*
+	 * For RAID56, we need to queue the full stripe. If there is some data
+	 * stripes containing no sectors, we still need to queue those empty
+	 * stripes for later recovery and P/Q verification.
+	 */
+	if (is_raid56)
+		return queue_raid56_full_stripes(sctx, bg, map, logical);
+
 	stripe = &sctx->stripes[old_cur];
 
 	scrub_reset_stripe(stripe);
@@ -3250,7 +3352,7 @@ static int scrub_logical_one_chunk(struct scrub_ctx *sctx,
 		}
 		spin_unlock(&bg->lock);
 
-		ret = queue_scrub_logical_stripes(sctx, bg, cur);
+		ret = queue_scrub_logical_stripes(sctx, bg, em->map_lookup, cur);
 		if (ret > 0) {
 			ret = 0;
 			break;
-- 
2.41.0

