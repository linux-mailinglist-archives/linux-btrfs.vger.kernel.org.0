Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0531875AC54
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 12:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjGTKss (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 06:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjGTKsl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 06:48:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03611995
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 03:48:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 70D7F21D9B
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 10:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689850117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XHwqqKpCrdgNt6ZXCJiO7sAvB+sZal/UWU5h0ezv17k=;
        b=Mm8+H+mXWPxmWB12v47legLjBea03a0ICw80HScmLNutNsDZomZS7f+O38zgSP5R4QFHv6
        pQqfDxHuRygLhADQ2NA3fR+1KzIbdvIKNwXR1R1QvimtbJ0zLKzCN+1OM4MEZT4giLzrqS
        FjuS4RLfVFXSEjJqP1mIs9qV4BLJc7E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8BA7133DD
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 10:48:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sIhcHwQRuWQBcQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 10:48:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs: scrub: move write back of repaired sectors into  scrub_stripe_read_repair_worker()
Date:   Thu, 20 Jul 2023 18:48:13 +0800
Message-ID: <f8fc338c865d2474838ccaeeb205f24da745d44f.1689849582.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689849582.git.wqu@suse.com>
References: <cover.1689849582.git.wqu@suse.com>
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

Currently the scrub_stripe_read_repair_worker() only do reads to rebuild
the corrupted sectors, it doesn't do any writeback.

The design is mostly to put writeback into a more ordered manner, to
co-operate with dev-replace with zoned mode, which requires every write
to be submitted in their bytenr order.

However the writeback for repaired sectors into the original mirror
doesn't need such strong requirement, as it can only happen for
non-zoned devices.

This patch would move the writeback for repaired sectors into
scrub_stripe_read_repair_worker().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 5f8c95290e60..516703d20a13 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -989,6 +989,8 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 	spin_unlock(&sctx->stat_lock);
 }
 
+static void scrub_write_sectors(struct scrub_ctx *sctx, struct scrub_stripe *stripe,
+				unsigned long write_bitmap, bool dev_replace);
 /*
  * The main entrance for all read related scrub work, including:
  *
@@ -1003,6 +1005,7 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 static void scrub_stripe_read_repair_worker(struct work_struct *work)
 {
 	struct scrub_stripe *stripe = container_of(work, struct scrub_stripe, work);
+	struct scrub_ctx *sctx = stripe->sctx;
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	int num_copies = btrfs_num_copies(fs_info, stripe->bg->start,
 					  stripe->bg->length);
@@ -1068,7 +1071,25 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
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
-- 
2.41.0

