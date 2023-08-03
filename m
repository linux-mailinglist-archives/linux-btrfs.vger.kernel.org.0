Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0842576E04B
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 08:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjHCGeC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Aug 2023 02:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbjHCGeB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Aug 2023 02:34:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40440E7D
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 23:34:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 015291F381
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Aug 2023 06:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691044439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pU7cM6q+zdUed3+rrh5xvJByOLH/5H2Zjb8JNIwLUlA=;
        b=s/0BOrvEQqV63bQzYnNeqaHGoQaM2dKpNUBP51LCSfw8b2CoWU/mlJR/LF5k1Z0czoiJ11
        iDgEkw5frChR39k2id4SOXtFeJBff/CZvsWZXOK5O78CcccPbdE6J5OCkZOOc2184a4jlV
        XussFHhcg8BVesDaN1clbCyhjooZ/R4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5757B134B0
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Aug 2023 06:33:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sPrTCFZKy2SjGAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Aug 2023 06:33:58 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/5] btrfs: scrub: move write back of repaired sectors into scrub_stripe_read_repair_worker()
Date:   Thu,  3 Aug 2023 14:33:33 +0800
Message-ID: <643bd96722e206133a7d3dbd7209cb4cb28045b6.1691044274.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691044274.git.wqu@suse.com>
References: <cover.1691044274.git.wqu@suse.com>
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

Currently the scrub_stripe_read_repair_worker() only do reads to rebuild
the corrupted sectors, it doesn't do any writeback.

The design is mostly to put writeback into a more ordered manner, to
co-operate with dev-replace with zoned mode, which requires every write
to be submitted in their bytenr order.

However the writeback for repaired sectors into the original mirror
doesn't need such strong sync requirement, as it can only happen for
non-zoned devices.

This patch would move the writeback for repaired sectors into
scrub_stripe_read_repair_worker(), which removes two calls sites for
repaired sectors writeback. (one from flush_scrub_stripes(), one from
scrub_raid56_parity_stripe())

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 74 ++++++++++++++++++------------------------------
 1 file changed, 27 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 1001c7724e4c..b2c7832e598b 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -987,6 +987,9 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 	spin_unlock(&sctx->stat_lock);
 }
 
+static void scrub_write_sectors(struct scrub_ctx *sctx, struct scrub_stripe *stripe,
+				unsigned long write_bitmap, bool dev_replace);
+
 /*
  * The main entrance for all read related scrub work, including:
  *
@@ -995,13 +998,16 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
  * - Go through the remaining mirrors and try to read as large blocksize as
  *   possible
  * - Go through all mirrors (including the failed mirror) sector-by-sector
+ * - Submit writeback for repaired sectors
  *
- * Writeback does not happen here, it needs extra synchronization.
+ * Writeback for dev-replace does not happen here, it needs extra
+ * synchronization for zoned devices.
  */
 static void scrub_stripe_read_repair_worker(struct work_struct *work)
 {
 	struct scrub_stripe *stripe = container_of(work, struct scrub_stripe, work);
-	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	struct scrub_ctx *sctx = stripe->sctx;
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	int num_copies = btrfs_num_copies(fs_info, stripe->bg->start,
 					  stripe->bg->length);
 	int mirror;
@@ -1066,7 +1072,25 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
 			goto out;
 	}
 out:
-	scrub_stripe_report_errors(stripe->sctx, stripe);
+	/*
+	 * Submit the repaired sectors.  For zoned case, we cannot do repair
+	 * in-place, but queue the bg to be relocated.
+	 */
+	if (btrfs_is_zoned(fs_info)) {
+		if (!bitmap_empty(&stripe->error_bitmap, stripe->nr_sectors)) {
+			btrfs_repair_one_zone(fs_info,
+					      sctx->stripes[0].bg->start);
+		}
+	} else if (!sctx->readonly) {
+		unsigned long repaired;
+
+		bitmap_andnot(&repaired, &stripe->init_error_bitmap,
+			      &stripe->error_bitmap, stripe->nr_sectors);
+		scrub_write_sectors(sctx, stripe, repaired, false);
+		wait_scrub_stripe_io(stripe);
+	}
+
+	scrub_stripe_report_errors(sctx, stripe);
 	set_bit(SCRUB_STRIPE_FLAG_REPAIR_DONE, &stripe->state);
 	wake_up(&stripe->repair_wait);
 }
@@ -1720,32 +1744,6 @@ static int flush_scrub_stripes(struct scrub_ctx *sctx)
 			   test_bit(SCRUB_STRIPE_FLAG_REPAIR_DONE, &stripe->state));
 	}
 
-	/*
-	 * Submit the repaired sectors.  For zoned case, we cannot do repair
-	 * in-place, but queue the bg to be relocated.
-	 */
-	if (btrfs_is_zoned(fs_info)) {
-		for (int i = 0; i < nr_stripes; i++) {
-			stripe = &sctx->stripes[i];
-
-			if (!bitmap_empty(&stripe->error_bitmap, stripe->nr_sectors)) {
-				btrfs_repair_one_zone(fs_info,
-						      sctx->stripes[0].bg->start);
-				break;
-			}
-		}
-	} else if (!sctx->readonly) {
-		for (int i = 0; i < nr_stripes; i++) {
-			unsigned long repaired;
-
-			stripe = &sctx->stripes[i];
-
-			bitmap_andnot(&repaired, &stripe->init_error_bitmap,
-				      &stripe->error_bitmap, stripe->nr_sectors);
-			scrub_write_sectors(sctx, stripe, repaired, false);
-		}
-	}
-
 	/* Submit for dev-replace. */
 	if (sctx->is_dev_replace) {
 		/*
@@ -1920,24 +1918,6 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	/* For now, no zoned support for RAID56. */
 	ASSERT(!btrfs_is_zoned(sctx->fs_info));
 
-	/* Writeback for the repaired sectors. */
-	for (int i = 0; i < data_stripes; i++) {
-		unsigned long repaired;
-
-		stripe = &sctx->raid56_data_stripes[i];
-
-		bitmap_andnot(&repaired, &stripe->init_error_bitmap,
-			      &stripe->error_bitmap, stripe->nr_sectors);
-		scrub_write_sectors(sctx, stripe, repaired, false);
-	}
-
-	/* Wait for the above writebacks to finish. */
-	for (int i = 0; i < data_stripes; i++) {
-		stripe = &sctx->raid56_data_stripes[i];
-
-		wait_scrub_stripe_io(stripe);
-	}
-
 	/*
 	 * Now all data stripes are properly verified. Check if we have any
 	 * unrepaired, if so abort immediately or we could further corrupt the
-- 
2.41.0

