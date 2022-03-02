Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0153A4C9FAA
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 09:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240092AbiCBIpX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 03:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240068AbiCBIpR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 03:45:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4127BAB88
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 00:44:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9F3432199B
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 08:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646210670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xHXyOmZRFp/BHdPwZzqC2WdO7v3wWjcHaJ6JjNeBXzs=;
        b=JJL19v3l1Sn/Vhx/9ID3ULxg+V5yPDT2if4h3f+EPRz6WUcMEBa+kAGQe8CYkli75Ba5n1
        sGTzqopf537ad8NCwKYZxXbYeWIT5t+Hucg79ScjJHyh6WIiyEwceTtiFHdwSWTDqe8sXG
        WxUCVYc6VEJjiCsRKCecUIgrxeuonyU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DAFB313345
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 08:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0LHKJm0uH2JHTAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Mar 2022 08:44:29 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] btrfs: extract the initialization of scrub_block into a helper function
Date:   Wed,  2 Mar 2022 16:44:05 +0800
Message-Id: <d6a1ee97967903f43d56ed2a642f14379dd7f77f.1646210538.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646210538.git.wqu@suse.com>
References: <cover.1646210538.git.wqu@suse.com>
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

Although there are only two callers, we are going to add some members
for scrub_block in the incoming patches.

Extracting the initialization code will make later expansion easier.

One thing to note is, even scrub_handle_errored_block() doesn't utilize
scrub_block::refs, we still use alloc_scrub_block() to initialize
sblock::ref, allowing us to use scrub_block_put() to do cleanup.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 49 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index d40a8ea7b0b5..8ccd25666986 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -204,6 +204,19 @@ struct full_stripe_lock {
 	struct mutex mutex;
 };
 
+static struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx)
+{
+	struct scrub_block *sblock;
+
+	sblock = kzalloc(sizeof(*sblock), GFP_KERNEL);
+	if (!sblock)
+		return NULL;
+	refcount_set(&sblock->refs, 1);
+	sblock->sctx = sctx;
+	sblock->no_io_error_seen = 1;
+	return sblock;
+}
+
 static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 				     struct scrub_block *sblocks_for_recheck[]);
 static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
@@ -907,8 +920,15 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 	 * the statistics.
 	 */
 	for (mirror_index = 0; mirror_index < BTRFS_MAX_MIRRORS; mirror_index++) {
-		sblocks_for_recheck[mirror_index] =
-			kzalloc(sizeof(struct scrub_block), GFP_KERNEL);
+		/*
+		 * Note: the two members refs and outstanding_sectors
+		 * are not used in the blocks that are used for the recheck
+		 * procedure.
+		 *
+		 * But alloc_scrub_block() will initialize sblock::ref anyway,
+		 * so we can use scrub_block_put() to clean them up.
+		 */
+		sblocks_for_recheck[mirror_index] = alloc_scrub_block(sctx);
 		if (!sblocks_for_recheck[mirror_index]) {
 			spin_lock(&sctx->stat_lock);
 			sctx->stat.malloc_errors++;
@@ -919,16 +939,6 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 						     BTRFS_DEV_STAT_READ_ERRS);
 			goto out;
 		}
-		/*
-		 * note: the two members refs and outstanding_sectors
-		 * are not used in the blocks that are used for the recheck
-		 * procedure.
-		 *
-		 * But to make the cleanup easier, we just put one ref for
-		 * each sblocks.
-		 */
-		refcount_set(&sblocks_for_recheck[mirror_index]->refs, 1);
-		sblocks_for_recheck[mirror_index]->sctx = sctx;
 	}
 
 	/* setup the context, map the logical blocks and alloc the sectors */
@@ -2266,7 +2276,7 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 	const u32 sectorsize = sctx->fs_info->sectorsize;
 	int index;
 
-	sblock = kzalloc(sizeof(*sblock), GFP_KERNEL);
+	sblock = alloc_scrub_block(sctx);
 	if (!sblock) {
 		spin_lock(&sctx->stat_lock);
 		sctx->stat.malloc_errors++;
@@ -2274,12 +2284,6 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 		return -ENOMEM;
 	}
 
-	/* one ref inside this function, plus one for each page added to
-	 * a bio later on */
-	refcount_set(&sblock->refs, 1);
-	sblock->sctx = sctx;
-	sblock->no_io_error_seen = 1;
-
 	for (index = 0; len > 0; index++) {
 		struct scrub_sector *ssector;
 		/*
@@ -2619,7 +2623,7 @@ static int scrub_sectors_for_parity(struct scrub_parity *sparity,
 
 	ASSERT(IS_ALIGNED(len, sectorsize));
 
-	sblock = kzalloc(sizeof(*sblock), GFP_KERNEL);
+	sblock = alloc_scrub_block(sctx);
 	if (!sblock) {
 		spin_lock(&sctx->stat_lock);
 		sctx->stat.malloc_errors++;
@@ -2627,11 +2631,6 @@ static int scrub_sectors_for_parity(struct scrub_parity *sparity,
 		return -ENOMEM;
 	}
 
-	/* one ref inside this function, plus one for each page added to
-	 * a bio later on */
-	refcount_set(&sblock->refs, 1);
-	sblock->sctx = sctx;
-	sblock->no_io_error_seen = 1;
 	sblock->sparity = sparity;
 	scrub_parity_get(sparity);
 
-- 
2.35.1

