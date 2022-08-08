Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F65658C2FC
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 07:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbiHHFqL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 01:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiHHFqI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 01:46:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3257DFDF
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Aug 2022 22:46:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6AB8034970
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 05:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659937564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2y0R3U5j8V93+pjHTAZRhLcElVzg1sZK3NqoP5grZvI=;
        b=NjG3dnEXY7/3mlTTuaGReYX5ZEdNj1xhPkR/ZZZT/mdjG1kPe5UZGluxoBwgjmZNw8WZsr
        JbjXkXgrR03vGXVMuqnAyHahI2+fnGcjgKqRTz9yi7+joKrRsQh2dnRG9CHhz713Z4m9lG
        ToGGXyvGqsURoCegDw6AZJyMxzeJ0Ko=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 599B713523
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 05:46:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OPe8CRuj8GJpfwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Aug 2022 05:46:03 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/7] btrfs: extract the initialization of scrub_block into a helper function
Date:   Mon,  8 Aug 2022 13:45:38 +0800
Message-Id: <f3b04bb519c12933aac7d27632735fbc5daab70b.1659936510.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1659936510.git.wqu@suse.com>
References: <cover.1659936510.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 9beb293ac4b2..51d8e88a3486 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -202,6 +202,19 @@ struct full_stripe_lock {
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
@@ -912,8 +925,15 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
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
@@ -924,16 +944,6 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
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
 
 	/* Setup the context, map the logical blocks and alloc the sectors */
@@ -2226,7 +2236,7 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 	const u32 sectorsize = sctx->fs_info->sectorsize;
 	int index;
 
-	sblock = kzalloc(sizeof(*sblock), GFP_KERNEL);
+	sblock = alloc_scrub_block(sctx);
 	if (!sblock) {
 		spin_lock(&sctx->stat_lock);
 		sctx->stat.malloc_errors++;
@@ -2234,12 +2244,6 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 		return -ENOMEM;
 	}
 
-	/* one ref inside this function, plus one for each page added to
-	 * a bio later on */
-	refcount_set(&sblock->refs, 1);
-	sblock->sctx = sctx;
-	sblock->no_io_error_seen = 1;
-
 	for (index = 0; len > 0; index++) {
 		struct scrub_sector *sector;
 		/*
@@ -2579,7 +2583,7 @@ static int scrub_sectors_for_parity(struct scrub_parity *sparity,
 
 	ASSERT(IS_ALIGNED(len, sectorsize));
 
-	sblock = kzalloc(sizeof(*sblock), GFP_KERNEL);
+	sblock = alloc_scrub_block(sctx);
 	if (!sblock) {
 		spin_lock(&sctx->stat_lock);
 		sctx->stat.malloc_errors++;
@@ -2587,11 +2591,6 @@ static int scrub_sectors_for_parity(struct scrub_parity *sparity,
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
2.37.0

