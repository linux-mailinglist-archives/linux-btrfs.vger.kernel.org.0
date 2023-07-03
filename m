Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F245D745624
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 09:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjGCHdV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 03:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGCHdR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 03:33:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F787E43
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 00:33:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B2F3C218FE;
        Mon,  3 Jul 2023 07:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688369584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IfxRWjgTRSgQST7ocZIjQ+Q9TJbbAel8rOeIPy8Pa/Y=;
        b=Kvuq0ZouLnwBSI/0onQpFZCoEDEDFr/yZlug7kdtViXd5BjRAmYiAqPtmqxyYTU3ery0cQ
        DzTPnw8K2pMCh52bYj5LC6nk6+TlWPo5tNbkZbjMwCglkZNqgktkgSUsDxtPdiKbSKAxOZ
        a4cwwVxPtsFt9/uPytupoYV/IevczZk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7C7A13276;
        Mon,  3 Jul 2023 07:33:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CE58I695omRoVQAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 03 Jul 2023 07:33:03 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 06/14] btrfs: scrub: make scrub_ctx::stripes dynamically allocated
Date:   Mon,  3 Jul 2023 15:32:30 +0800
Message-ID: <e3636085c44cec6e167df77a000d3cd24c2fe678.1688368617.git.wqu@suse.com>
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

Currently scrub_ctx::stripes are a fixed size array, this is fine for
most use cases, but later we may want to allocate one larger sized array
for logical bytenr based scrub.

So here we change the member to a dynamically allocated array.

This also affects the lifespan of the member.
Now it only needs to be allocated and initialized at the beginning of
scrub_stripe() function.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 67 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 41c514db0793..1e49bb066619 100644
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
@@ -308,16 +311,24 @@ static void scrub_blocked_if_needed(struct btrfs_fs_info *fs_info)
 	scrub_pause_off(fs_info);
 }
 
+static void free_scrub_stripes(struct scrub_ctx *sctx)
+{
+	if (!sctx->stripes)
+		return;
+
+	for (int i = 0; i < sctx->nr_stripes; i++)
+		release_scrub_stripe(&sctx->stripes[i]);
+	kfree(sctx->stripes);
+	sctx->nr_stripes = 0;
+	sctx->stripes = NULL;
+}
+
 static noinline_for_stack void scrub_free_ctx(struct scrub_ctx *sctx)
 {
-	int i;
-
 	if (!sctx)
 		return;
 
-	for (i = 0; i < SCRUB_STRIPES_PER_SCTX; i++)
-		release_scrub_stripe(&sctx->stripes[i]);
-
+	free_scrub_stripes(sctx);
 	kfree(sctx);
 }
 
@@ -331,7 +342,6 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 		struct btrfs_fs_info *fs_info, int is_dev_replace)
 {
 	struct scrub_ctx *sctx;
-	int		i;
 
 	sctx = kzalloc(sizeof(*sctx), GFP_KERNEL);
 	if (!sctx)
@@ -339,14 +349,6 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
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
 
@@ -1659,6 +1661,7 @@ static int flush_scrub_stripes(struct scrub_ctx *sctx)
 	const int nr_stripes = sctx->cur_stripe;
 	int ret = 0;
 
+	ASSERT(nr_stripes <= sctx->nr_stripes);
 	if (!nr_stripes)
 		return 0;
 
@@ -1753,8 +1756,11 @@ static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *
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
@@ -2076,6 +2082,30 @@ static int scrub_simple_stripe(struct scrub_ctx *sctx,
 	return ret;
 }
 
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
@@ -2102,6 +2132,10 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 
 	scrub_blocked_if_needed(fs_info);
 
+	ret = alloc_scrub_stripes(sctx, SCRUB_STRIPES_PER_SCTX);
+	if (ret < 0)
+		return ret;
+
 	if (sctx->is_dev_replace &&
 	    btrfs_dev_is_sequential(sctx->wr_tgtdev, physical)) {
 		mutex_lock(&sctx->wr_lock);
@@ -2224,6 +2258,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		kfree(sctx->raid56_data_stripes);
 		sctx->raid56_data_stripes = NULL;
 	}
+	free_scrub_stripes(sctx);
 
 	if (sctx->is_dev_replace && ret >= 0) {
 		int ret2;
-- 
2.41.0

