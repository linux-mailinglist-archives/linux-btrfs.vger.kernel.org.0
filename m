Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C70643E78
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Dec 2022 09:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiLFIYY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Dec 2022 03:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbiLFIYG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Dec 2022 03:24:06 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83B2DFC3
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 00:24:05 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 994BE21C04
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 08:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670315044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HyAvAqVyTXiAW74hmD2xN4DKVLgr65Y7AM7t51i1lV8=;
        b=S3GN5yB3ShgVCV7iBesf1zG6SOG/9iwsqZEau/Nih+5wj9bgSW+7nwIAlCn2myU0d5VrDb
        vLhJyzdACgKOY1VbpeOnU0dtFgXxN23eZDBgwrXTfpsy3o85KAMR8Znmht/lkOTPrsNY9I
        3vPXbr09BBN//h4qDYvQxdlDMpS7FHY=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0930E132F3
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 08:24:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id yMObMiP8jmNRbAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Dec 2022 08:24:03 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PoC PATCH 08/11] btrfs: scrub: use dedicated super block verification function to scrub one super block
Date:   Tue,  6 Dec 2022 16:23:35 +0800
Message-Id: <8f9c062829fb59ea0ae793801e528afabff7e979.1670314744.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1670314744.git.wqu@suse.com>
References: <cover.1670314744.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is really no need to go through the super complex scrub_sectors()
to just handle super blocks.

This patch will introduce a dedicated function (less than 50 lines) to
handle super block scrubing.

This new function will introduce a behavior change, instead of using the
complex but concurrent scrub_bio system, here we just go
submit-and-wait.

There is really not much sense to care the performance of super block
scrubbing. It only has 3 super blocks at most, and they are all scattered
around the devices already.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 162f7e1dd378..9a9e706cba3e 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -5239,6 +5239,38 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 	return ret;
 }
 
+static int scrub2_one_super(struct scrub_ctx *sctx,
+			    struct btrfs_device *scrub_dev,
+			    struct page *page, u64 physical, u64 generation)
+{
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	struct bio_vec bvec;
+	struct bio bio;
+	struct btrfs_super_block *sb = page_address(page);
+	int ret;
+
+	bio_init(&bio, scrub_dev->bdev, &bvec, 1, REQ_OP_READ);
+	bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE, 0);
+	ret = submit_bio_wait(&bio);
+	bio_uninit(&bio);
+
+	if (ret < 0)
+		return ret;
+	ret = btrfs_check_super_csum(fs_info, sb);
+	if (ret < 0)
+		return ret;
+	if (btrfs_super_generation(sb) != generation) {
+		btrfs_err_rl(fs_info,
+"super block at physical %llu devid %llu has bad generation, has %llu expect %llu",
+			     physical, scrub_dev->devid,
+			     btrfs_super_generation(sb), generation);
+		return -EUCLEAN;
+	}
+
+	ret = btrfs_validate_super(fs_info, sb, -1);
+	return ret;
+}
+
 static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 					   struct btrfs_device *scrub_dev)
 {
@@ -5246,11 +5278,16 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 	u64	bytenr;
 	u64	gen;
 	int	ret;
+	struct page *page;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 
 	if (BTRFS_FS_ERROR(fs_info))
 		return -EROFS;
 
+	page = alloc_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
 	/* Seed devices of a new filesystem has their own generation. */
 	if (scrub_dev->fs_devices != fs_info->fs_devices)
 		gen = scrub_dev->generation;
@@ -5265,13 +5302,11 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 		if (!btrfs_check_super_location(scrub_dev, bytenr))
 			continue;
 
-		ret = scrub_sectors(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,
-				    scrub_dev, BTRFS_EXTENT_FLAG_SUPER, gen, i,
-				    NULL, bytenr);
+		ret = scrub2_one_super(sctx, scrub_dev, page, bytenr, gen);
 		if (ret)
 			return ret;
 	}
-	wait_event(sctx->list_wait, atomic_read(&sctx->bios_in_flight) == 0);
+	__free_page(page);
 
 	return 0;
 }
-- 
2.38.1

