Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEE66C08D5
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Mar 2023 03:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCTCNY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Mar 2023 22:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCTCNW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Mar 2023 22:13:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227E96A4E
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Mar 2023 19:13:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 75BF321ACA
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679278399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=omkLkyiEMLgHzp7bviyG9MrDSG9c8PmFW1dCed7PaYI=;
        b=Bl6Zpm5eXMG9sWiQHWHHgXcopJTARgLbnHq7bxfcEJ0awiv0Xp5d6YooTjbFA33cd2TgL+
        wiPkIsO/xkL3zpCDCvxguekdQFlSU8hkZZoqUdSbmqgEBCFBwHtY5nK8pd/0A70dG6Fhw5
        xc0KWkeK4oLwiaGSzr8Vk2D5Hw2Qxvo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC6F813416
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EEWUJT7BF2QLPQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 01/12] btrfs: scrub: use dedicated super block verification function to scrub one super block
Date:   Mon, 20 Mar 2023 10:12:47 +0800
Message-Id: <94803d18b1c4ce208b6a93e37998718e61ea37d5.1679278088.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679278088.git.wqu@suse.com>
References: <cover.1679278088.git.wqu@suse.com>
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
 fs/btrfs/scrub.c | 54 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 3cdf73277e7e..e765eb8b8bcf 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -4243,18 +4243,59 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 	return ret;
 }
 
+static int scrub_one_super(struct scrub_ctx *sctx, struct btrfs_device *dev,
+			   struct page *page, u64 physical, u64 generation)
+{
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	struct bio_vec bvec;
+	struct bio bio;
+	struct btrfs_super_block *sb = page_address(page);
+	int ret;
+
+	bio_init(&bio, dev->bdev, &bvec, 1, REQ_OP_READ);
+	bio.bi_iter.bi_sector = physical >> SECTOR_SHIFT;
+	bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE, 0);
+	ret = submit_bio_wait(&bio);
+	bio_uninit(&bio);
+
+	if (ret < 0)
+		return ret;
+	ret = btrfs_check_super_csum(fs_info, sb);
+	if (ret != 0) {
+		btrfs_err_rl(fs_info,
+			"super block at physical %llu devid %llu has bad csum",
+			physical, dev->devid);
+		return -EIO;
+	}
+	if (btrfs_super_generation(sb) != generation) {
+		btrfs_err_rl(fs_info,
+"super block at physical %llu devid %llu has bad generation, has %llu expect %llu",
+			     physical, dev->devid,
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
 	int	i;
 	u64	bytenr;
 	u64	gen;
-	int	ret;
+	int	ret = 0;
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
@@ -4269,15 +4310,12 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 		if (!btrfs_check_super_location(scrub_dev, bytenr))
 			continue;
 
-		ret = scrub_sectors(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,
-				    scrub_dev, BTRFS_EXTENT_FLAG_SUPER, gen, i,
-				    NULL, bytenr);
+		ret = scrub_one_super(sctx, scrub_dev, page, bytenr, gen);
 		if (ret)
-			return ret;
+			break;
 	}
-	wait_event(sctx->list_wait, atomic_read(&sctx->bios_in_flight) == 0);
-
-	return 0;
+	__free_page(page);
+	return ret;
 }
 
 static void scrub_workers_put(struct btrfs_fs_info *fs_info)
-- 
2.39.2

