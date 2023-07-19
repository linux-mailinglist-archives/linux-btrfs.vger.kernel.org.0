Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B5C758D23
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jul 2023 07:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjGSFa6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jul 2023 01:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGSFa6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jul 2023 01:30:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919501BF3
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jul 2023 22:30:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 350691F8C0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 05:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689744652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTod6vZDONodYAOBNkj9/yN+oL6sApf/WCN0QlUQUow=;
        b=oZCZNp90Ncs1y59m8Axd0v4JZfoynjX9M+r9R+m+/1FFab8nJbfw7jdYgZr6QvRPM1jb5l
        CCtscdjA8xJCaGnF9g7YnDkc7W16bHVzUn4rdbhMj/0pnqA52JVm76UzDseLE2RF7yxCXj
        B9hmpjXdZOmn8u+OG6ynQtbGe91jMNk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E040138EE
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 05:30:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gOYXNgp1t2R7JQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 05:30:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 4/4] btrfs: scrub: make sctx->stripes[] array work as a ring buffer
Date:   Wed, 19 Jul 2023 13:30:26 +0800
Message-ID: <04b653322f5d8b32c22083a4df9baf6d4c9097ea.1689744163.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689744163.git.wqu@suse.com>
References: <cover.1689744163.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since all scrub works (repair using other mirrors, writeback to the
original mirror, writeback to the dev-replace target) all happens inside
a btrfs workqueue, there is no need to manually flush all the stripes
inside queue_scrub_stripe().

We only need to wait for the current slot to finish its work, then queue
the stripe, and finally increase the cur_stripe number (and mod it).

This should allow scrub to increase its queue depth when submitting read
requests.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 784fbe2341d4..e71ee8d2fbf7 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1770,7 +1770,7 @@ static int flush_scrub_stripes(struct scrub_ctx *sctx)
 	blk_finish_plug(&plug);
 
 	/* Wait for all stripes to finish. */
-	for (int i = 0; i < nr_stripes; i++) {
+	for (int i = 0; i < SCRUB_STRIPES_PER_SCTX; i++) {
 		stripe = &sctx->stripes[i];
 
 		wait_event(stripe->repair_wait, stripe->state == 0);
@@ -1794,40 +1794,46 @@ static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *
 	int ret;
 
 	/*
-	 * We should always have at least one slot, when full the last one who
-	 * queued a slot should handle the flush.
+	 * We should always have at least one slot, as the stripes[] array
+	 * is used as a ring buffer.
 	 */
 	ASSERT(sctx->cur_stripe < SCRUB_STRIPES_PER_SCTX);
 	stripe = &sctx->stripes[sctx->cur_stripe];
-	scrub_reset_stripe(stripe);
+
+	/* Wait if the stripe is still under usage. */
+	wait_event(stripe->repair_wait, stripe->state == 0);
+
 	ret = scrub_find_fill_first_stripe(bg, dev, physical, mirror_num,
 					   logical, length, stripe);
 	/* Either >0 as no more extents or <0 for error. */
 	if (ret)
 		return ret;
+
 	*found_stripe_start_ret = stripe->logical;
 
-	sctx->cur_stripe++;
-
-	/* Last slot used, flush them all. */
-	if (sctx->cur_stripe == SCRUB_STRIPES_PER_SCTX)
-		return flush_scrub_stripes(sctx);
-
-	/* We have filled one group, submit them now. */
-	if (sctx->cur_stripe % SCRUB_STRIPES_PER_GROUP == 0) {
+	/* Last slot in the group, submit the group.*/
+	if ((sctx->cur_stripe + 1) % SCRUB_STRIPES_PER_GROUP == 0) {
+		const int first_stripe = sctx->cur_stripe + 1 -
+					 SCRUB_STRIPES_PER_GROUP;
 		struct blk_plug plug;
 
-		scrub_throttle_dev_io(sctx, sctx->stripes[0].dev,
-			      btrfs_stripe_nr_to_offset(SCRUB_STRIPES_PER_GROUP));
+		scrub_throttle_dev_io(sctx, dev,
+			btrfs_stripe_nr_to_offset(SCRUB_STRIPES_PER_GROUP));
 
 		blk_start_plug(&plug);
-		for (int i = sctx->cur_stripe - SCRUB_STRIPES_PER_GROUP;
-		     i < sctx->cur_stripe; i++) {
+		for (int i = first_stripe;
+		     i < first_stripe + SCRUB_STRIPES_PER_GROUP; i++) {
 			stripe = &sctx->stripes[i];
+
+			/* All stripes in the group should haven been queued. */
+			ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED,
+					&stripe->state));
 			scrub_submit_initial_read(sctx, stripe);
 		}
 		blk_finish_plug(&plug);
 	}
+
+	sctx->cur_stripe = (sctx->cur_stripe + 1) % SCRUB_STRIPES_PER_SCTX;
 	return 0;
 }
 
-- 
2.41.0

