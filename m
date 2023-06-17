Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228EF733E24
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jun 2023 07:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjFQFHt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Jun 2023 01:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjFQFHs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Jun 2023 01:07:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E6919BB
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jun 2023 22:07:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 049EC21A86
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jun 2023 05:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686978466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jq/17xBPSgnAVhnbOYLvsU/quJIvRfOc0OO8rR8ufJg=;
        b=NwXYeW3Lam/nWlD5+NXzzY+ACne25FYH4+ELYPf9r0xFb/wGuZYs2nBuq1lt9d9HsgFGzL
        tJiYrxBhDS1XZa3D/2zPpwgZ3fPdsyFPkNXBWOhYRxdEXvpLqu6gE89TX2oxvGFBdaKw6k
        GYBSIOZNrTwyRc2aXw3C7KXukYXC3BU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6D8D813915
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jun 2023 05:07:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yMdBM6A/jWTFEgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jun 2023 05:07:44 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 1/5] btrfs: scrub: make scrub_ctx::stripes dynamically allocated
Date:   Sat, 17 Jun 2023 13:07:22 +0800
Message-ID: <93e32d86ead00d7596072aa2f1fbc59022ebb3ad.1686977659.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1686977659.git.wqu@suse.com>
References: <cover.1686977659.git.wqu@suse.com>
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

Currently scrub_ctx::stripes are a fixed size array, this is fine for
most use cases, but later we may want to allocate one larger sized array
for logical bytenr based scrub.

So here we change the member to a dynamically allocated array.

This also affects the lifespan of the member.
Now it only needs to be allocated and initialized at the beginning of
scrub_stripe() function.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 65 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 093823aa8d2c..d83bcc396bb0 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -172,7 +172,7 @@ struct scrub_stripe {
 };
 
 struct scrub_ctx {
-	struct scrub_stripe	stripes[SCRUB_STRIPES_PER_SCTX];
+	struct scrub_stripe	*stripes;
 	struct scrub_stripe	*raid56_data_stripes;
 	struct btrfs_fs_info	*fs_info;
 	int			first_free;
@@ -181,6 +181,9 @@ struct scrub_ctx {
 	int			readonly;
 	int			sectors_per_bio;
 
+	/* Number of stripes we have in @stripes. */
+	unsigned int		nr_stripes;
+
 	/* State of IO submission throttling affecting the associated device */
 	ktime_t			throttle_deadline;
 	u64			throttle_sent;
@@ -315,9 +318,10 @@ static noinline_for_stack void scrub_free_ctx(struct scrub_ctx *sctx)
 	if (!sctx)
 		return;
 
-	for (i = 0; i < SCRUB_STRIPES_PER_SCTX; i++)
-		release_scrub_stripe(&sctx->stripes[i]);
-
+	if (sctx->stripes)
+		for (i = 0; i < sctx->nr_stripes; i++)
+			release_scrub_stripe(&sctx->stripes[i]);
+	kfree(sctx->stripes);
 	kfree(sctx);
 }
 
@@ -331,7 +335,6 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 		struct btrfs_fs_info *fs_info, int is_dev_replace)
 {
 	struct scrub_ctx *sctx;
-	int		i;
 
 	sctx = kzalloc(sizeof(*sctx), GFP_KERNEL);
 	if (!sctx)
@@ -339,14 +342,6 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 	refcount_set(&sctx->refs, 1);
 	sctx->is_dev_replace = is_dev_replace;
 	sctx->fs_info = fs_info;
-	for (i = 0; i < SCRUB_STRIPES_PER_SCTX; i++) {
-		int ret;
-
-		ret = init_scrub_stripe(fs_info, &sctx->stripes[i]);
-		if (ret < 0)
-			goto nomem;
-		sctx->stripes[i].sctx = sctx;
-	}
 	sctx->first_free = 0;
 	atomic_set(&sctx->cancel_req, 0);
 
@@ -1660,6 +1655,7 @@ static int flush_scrub_stripes(struct scrub_ctx *sctx)
 	const int nr_stripes = sctx->cur_stripe;
 	int ret = 0;
 
+	ASSERT(nr_stripes <= sctx->nr_stripes);
 	if (!nr_stripes)
 		return 0;
 
@@ -1754,8 +1750,11 @@ static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *
 	struct scrub_stripe *stripe;
 	int ret;
 
+	ASSERT(sctx->stripes);
+	ASSERT(sctx->nr_stripes);
+
 	/* No available slot, submit all stripes and wait for them. */
-	if (sctx->cur_stripe >= SCRUB_STRIPES_PER_SCTX) {
+	if (sctx->cur_stripe >= sctx->nr_stripes) {
 		ret = flush_scrub_stripes(sctx);
 		if (ret < 0)
 			return ret;
@@ -2080,6 +2079,39 @@ static int scrub_simple_stripe(struct scrub_ctx *sctx,
 	return ret;
 }
 
+static void free_scrub_stripes(struct scrub_ctx *sctx)
+{
+	for (int i = 0; i < sctx->nr_stripes; i++)
+		release_scrub_stripe(&sctx->stripes[i]);
+	kfree(sctx->stripes);
+	sctx->nr_stripes = 0;
+	sctx->stripes = NULL;
+}
+
+static int alloc_scrub_stripes(struct scrub_ctx *sctx, int nr_stripes)
+{
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	int ret;
+
+	ASSERT(!sctx->stripes);
+	ASSERT(!sctx->nr_stripes);
+	sctx->stripes = kcalloc(nr_stripes, sizeof(struct scrub_stripe),
+				GFP_KERNEL);
+	if (!sctx->stripes)
+		return -ENOMEM;
+	sctx->nr_stripes = nr_stripes;
+	for (int i = 0; i < sctx->nr_stripes; i++) {
+		ret = init_scrub_stripe(fs_info, &sctx->stripes[i]);
+		if (ret < 0)
+			goto cleanup;
+		sctx->stripes[i].sctx = sctx;
+	}
+	return 0;
+cleanup:
+	free_scrub_stripes(sctx);
+	return -ENOMEM;
+}
+
 static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   struct btrfs_block_group *bg,
 					   struct extent_map *em,
@@ -2106,6 +2138,10 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 
 	scrub_blocked_if_needed(fs_info);
 
+	ret = alloc_scrub_stripes(sctx, SCRUB_STRIPES_PER_SCTX);
+	if (ret < 0)
+		return ret;
+
 	if (sctx->is_dev_replace &&
 	    btrfs_dev_is_sequential(sctx->wr_tgtdev, physical)) {
 		mutex_lock(&sctx->wr_lock);
@@ -2228,6 +2264,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		kfree(sctx->raid56_data_stripes);
 		sctx->raid56_data_stripes = NULL;
 	}
+	free_scrub_stripes(sctx);
 
 	if (sctx->is_dev_replace && ret >= 0) {
 		int ret2;
-- 
2.41.0

