Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF65475AC57
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 12:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjGTKsv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 06:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjGTKsn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 06:48:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD791738
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 03:48:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BB72520687
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 10:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689850119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bQrXZqEK+ahkSThFQV1d+HvPsWOlTmsSWQQiZbC7lV4=;
        b=WFFIsEAV2szS0JuJ2ls2CEPr/Cuh5LZQkHe/2wLr1emXxocjxeS8oJCmU/wrUM5/RhbFYk
        SCkzWWs7Am2fWN3abK86+YlOYnD3r7FHWAJYx+wCveLH8EPnjdrKMB13wLuuitXHPdkIuR
        8HjLouZgP6odxJGCyMv5v4LmfLrKGSA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C4F1133DD
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 10:48:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4LX8MAYRuWQBcQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 10:48:38 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs: scrub: extract the stripe group submission into a helper
Date:   Thu, 20 Jul 2023 18:48:15 +0800
Message-ID: <c326029c9c515e2ac293810f0492a41a8196e4a2.1689849582.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689849582.git.wqu@suse.com>
References: <cover.1689849582.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce a new helper, submit_initial_stripes_read(), to submit
multiple stripes in one go.

This function can be utilized to submit one group, or the remaining ones
which doesn't fill a full group (during flush_scrub_stripes()).

This helper has extra ASSERT()s to make sure the stripes are properly
initialized and not yet submitted.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 67 +++++++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 6d08836c0056..d6dfffb4efc9 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1695,12 +1695,36 @@ static bool stripe_has_metadata_error(struct scrub_stripe *stripe)
 	return false;
 }
 
+static void submit_initial_stripes_read(struct scrub_ctx *sctx, int first_slot,
+					int nr_stripes)
+{
+	struct blk_plug plug;
+
+	ASSERT(first_slot >= 0);
+	ASSERT(first_slot + nr_stripes <= SCRUB_STRIPES_PER_SCTX);
+
+	scrub_throttle_dev_io(sctx, sctx->stripes[0].dev,
+			      btrfs_stripe_nr_to_offset(nr_stripes));
+
+	blk_start_plug(&plug);
+	for (int i = 0; i < nr_stripes; i++) {
+		struct scrub_stripe *stripe = &sctx->stripes[first_slot + i];
+
+		/* Those stripes should be initialized and not yet submitted. */
+		ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state));
+		ASSERT(!test_bit(SCRUB_STRIPE_FLAG_READ_SUBMITTED, &stripe->state));
+
+		scrub_submit_initial_read(sctx, stripe);
+	}
+	blk_finish_plug(&plug);
+
+}
+
 static int flush_scrub_stripes(struct scrub_ctx *sctx)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct scrub_stripe *stripe;
 	const int nr_stripes = sctx->cur_stripe;
-	struct blk_plug plug;
 	int ret = 0;
 
 	if (!nr_stripes)
@@ -1708,17 +1732,14 @@ static int flush_scrub_stripes(struct scrub_ctx *sctx)
 
 	ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &sctx->stripes[0].state));
 
-	/* We should only have at most one group to submit. */
-	scrub_throttle_dev_io(sctx, sctx->stripes[0].dev,
-			      btrfs_stripe_nr_to_offset(
-				      nr_stripes % SCRUB_STRIPES_PER_GROUP ?:
-				      SCRUB_STRIPES_PER_GROUP));
-	blk_start_plug(&plug);
-	for (int i = 0; i < nr_stripes; i++) {
-		stripe = &sctx->stripes[i];
-		scrub_submit_initial_read(sctx, stripe);
+	/* Submit the stripes which are populated but not submitted. */
+	if (nr_stripes % SCRUB_STRIPES_PER_GROUP) {
+		const int first_slot = round_down(nr_stripes,
+						  SCRUB_STRIPES_PER_GROUP);
+
+		submit_initial_stripes_read(sctx, first_slot,
+					    nr_stripes - first_slot);
 	}
-	blk_finish_plug(&plug);
 
 	for (int i = 0; i < nr_stripes; i++) {
 		stripe = &sctx->stripes[i];
@@ -1820,25 +1841,19 @@ static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *
 
 	sctx->cur_stripe++;
 
+	/* We have filled one group, submit them now. */
+	if (sctx->cur_stripe % SCRUB_STRIPES_PER_GROUP == 0) {
+		const int first_slot = sctx->cur_stripe -
+				       SCRUB_STRIPES_PER_GROUP;
+
+		submit_initial_stripes_read(sctx, first_slot,
+					    SCRUB_STRIPES_PER_GROUP);
+	}
+
 	/* Last slot used, flush them all. */
 	if (sctx->cur_stripe == SCRUB_STRIPES_PER_SCTX)
 		return flush_scrub_stripes(sctx);
 
-	/* We have filled one group, submit them now. */
-	if (sctx->cur_stripe % SCRUB_STRIPES_PER_GROUP == 0) {
-		struct blk_plug plug;
-
-		scrub_throttle_dev_io(sctx, sctx->stripes[0].dev,
-			      btrfs_stripe_nr_to_offset(SCRUB_STRIPES_PER_GROUP));
-
-		blk_start_plug(&plug);
-		for (int i = sctx->cur_stripe - SCRUB_STRIPES_PER_GROUP;
-		     i < sctx->cur_stripe; i++) {
-			stripe = &sctx->stripes[i];
-			scrub_submit_initial_read(sctx, stripe);
-		}
-		blk_finish_plug(&plug);
-	}
 	return 0;
 }
 
-- 
2.41.0

