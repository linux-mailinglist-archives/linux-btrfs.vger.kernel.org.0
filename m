Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E1F72B7FC
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 08:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjFLGPH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 02:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbjFLGOu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 02:14:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC12493
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jun 2023 23:14:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7D0B32042C
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 06:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686550487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2NE6sZ3wS7UNlcafVFvw3MXtxjW41hX6fFfJ3dnEhoc=;
        b=ioMFTaH1+bNd5EC+piUzJWicewZgKQOKhdal9Oc9qbO78pMfu7wnB3EBFJCur2temoTaqO
        69CGb//rwlgJDo1rCs8vD7kU/xojb4HCrXGh6yCg8ayax2/UJYGCcyV1eolVtuApBYTR9t
        PU/URt0X9czJMSKQ9XJwGsLhw49Mpoc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFBAB138EC
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 06:14:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iyyPJda3hmT+SQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 06:14:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: scrub: remove scrub_ctx::csum_list member
Date:   Mon, 12 Jun 2023 14:14:29 +0800
Message-ID: <71bd17cb42d8caafe12b9fc009d97ba869d627b4.1686550463.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
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

Since the rework of scrub introduced by commit 2af2aaf98205 ("btrfs:
scrub: introduce structure for new BTRFS_STRIPE_LEN based interface")
and later commits, scrub no longer keeps its data checksum inside sctx.

Instead we have scrub_stripe::csums for the checksum of the stripe.

Thus we can remove the unused scrub_ctx::csum_list member.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 0ab06e9aa4c7..a1a1991c83e9 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -177,7 +177,6 @@ struct scrub_ctx {
 	struct btrfs_fs_info	*fs_info;
 	int			first_free;
 	int			cur_stripe;
-	struct list_head	csum_list;
 	atomic_t		cancel_req;
 	int			readonly;
 	int			sectors_per_bio;
@@ -309,17 +308,6 @@ static void scrub_blocked_if_needed(struct btrfs_fs_info *fs_info)
 	scrub_pause_off(fs_info);
 }
 
-static void scrub_free_csums(struct scrub_ctx *sctx)
-{
-	while (!list_empty(&sctx->csum_list)) {
-		struct btrfs_ordered_sum *sum;
-		sum = list_first_entry(&sctx->csum_list,
-				       struct btrfs_ordered_sum, list);
-		list_del(&sum->list);
-		kfree(sum);
-	}
-}
-
 static noinline_for_stack void scrub_free_ctx(struct scrub_ctx *sctx)
 {
 	int i;
@@ -330,7 +318,6 @@ static noinline_for_stack void scrub_free_ctx(struct scrub_ctx *sctx)
 	for (i = 0; i < SCRUB_STRIPES_PER_SCTX; i++)
 		release_scrub_stripe(&sctx->stripes[i]);
 
-	scrub_free_csums(sctx);
 	kfree(sctx);
 }
 
@@ -352,7 +339,6 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 	refcount_set(&sctx->refs, 1);
 	sctx->is_dev_replace = is_dev_replace;
 	sctx->fs_info = fs_info;
-	INIT_LIST_HEAD(&sctx->csum_list);
 	for (i = 0; i < SCRUB_STRIPES_PER_SCTX; i++) {
 		int ret;
 
-- 
2.41.0

