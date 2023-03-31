Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571D56D14E7
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Mar 2023 03:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjCaBUj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 21:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCaBUh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 21:20:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C609CCDCF
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Mar 2023 18:20:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 78CA61FE32;
        Fri, 31 Mar 2023 01:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680225634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PhfVyTdjvVUPBITmJpPodiRuw6jQsvA/Nl7KFfSiT/o=;
        b=nuUaHYmCthPHQQ6CC7/eHpmFwOgWeW4YNRhl0ctve81K+DJ4gNZbJ6KRaT4OkxbJg8Tf+f
        Y/9pr0TQigtx8rMVCaRbEQgK4VDk9XEJAMdn4At2iBuXFp5EQRf5gCvBru3W/39TKTTyP2
        v6Fh0nS3T3VjwAH2E2lfPwZZCIVEk84=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42C3113451;
        Fri, 31 Mar 2023 01:20:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4MndBGE1JmSKWAAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 31 Mar 2023 01:20:33 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v8 01/12] btrfs: scrub: use dedicated super block verification function to scrub one super block
Date:   Fri, 31 Mar 2023 09:20:04 +0800
Message-Id: <3d1f229744c0d6edfa3e6f54599b207471913376.1680225140.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680225140.git.wqu@suse.com>
References: <cover.1680225140.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 60 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 3cdf73277e7e..ef4046a2572c 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -4243,18 +4243,62 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
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
+	__bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE, 0);
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
+	return btrfs_validate_super(fs_info, sb, -1);
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
+	if (!page) {
+		spin_lock(&sctx->stat_lock);
+		sctx->stat.malloc_errors++;
+		spin_unlock(&sctx->stat_lock);
+		return -ENOMEM;
+	}
+
 	/* Seed devices of a new filesystem has their own generation. */
 	if (scrub_dev->fs_devices != fs_info->fs_devices)
 		gen = scrub_dev->generation;
@@ -4269,14 +4313,14 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 		if (!btrfs_check_super_location(scrub_dev, bytenr))
 			continue;
 
-		ret = scrub_sectors(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,
-				    scrub_dev, BTRFS_EXTENT_FLAG_SUPER, gen, i,
-				    NULL, bytenr);
-		if (ret)
-			return ret;
+		ret = scrub_one_super(sctx, scrub_dev, page, bytenr, gen);
+		if (ret) {
+			spin_lock(&sctx->stat_lock);
+			sctx->stat.super_errors++;
+			spin_unlock(&sctx->stat_lock);
+		}
 	}
-	wait_event(sctx->list_wait, atomic_read(&sctx->bios_in_flight) == 0);
-
+	__free_page(page);
 	return 0;
 }
 
-- 
2.39.2

