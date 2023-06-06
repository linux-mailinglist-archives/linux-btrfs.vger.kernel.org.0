Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89743723868
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 09:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbjFFHIu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 03:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjFFHIs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 03:08:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02F9C5
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 00:08:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 42BBE1FD5F
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 07:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686035326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=s2HFhDSEcqrs1tm0bhlGTHGzPFkvmQKOV+X2ORzqhNo=;
        b=RMU+upIjry9K2xF3EgKe9hZ11QbY0Wgi4Az5Yg9CRrPt+I4ORP0r3kcpBDJxTofAcTDYGx
        Jv7rf9/0ljUxe++LpJoZRbPCPPYS+NmKQAjSrfqWYygaUg9DwVEaqqvfHyod6DgH+iN0Xu
        yJyAjc64Iked5wd0GLUpuVvNRZEoAC8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A7FA213519
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 07:08:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pnz/HX3bfmRPAwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Jun 2023 07:08:45 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: scrub: also report errors hit during the initial read
Date:   Tue,  6 Jun 2023 15:08:28 +0800
Message-Id: <40578035047b80505e2adf02978c4c293abb44c9.1686035069.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
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

[BUG]
After the recent scrub rework introduced in commit e02ee89baa66 ("btrfs:
scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure"),
btrfs scrub no longer reports repaired errors any more:

 # mkfs.btrfs -f $dev -d DUP
 # mount $dev $mnt
 # xfs_io -f -d -c "pwrite -b 64K -S 0xaa 0 64" $mnt/file
 # umount $dev
 # xfs_io -f -c "pwrite -S 0xff $phy1 64K" $dev # Corrupt the first mirror
 # mount $dev $mnt
 # btrfs scrub start -BR $mnt
 scrub done for 725e7cb7-8a4a-4c77-9f2a-86943619e218
 Scrub started:    Tue Jun  6 14:56:50 2023
 Status:           finished
 Duration:         0:00:00
 	data_extents_scrubbed: 2
 	tree_extents_scrubbed: 18
 	data_bytes_scrubbed: 131072
 	tree_bytes_scrubbed: 294912
 	read_errors: 0
 	csum_errors: 0 <<< No errors here
 	verify_errors: 0
	[...]
 	uncorrectable_errors: 0
 	unverified_errors: 0
 	corrected_errors: 16 <<< Only corrected errors
 	last_physical: 2723151872

This can confuse btrfs-progs, as it relies on the csum_errors to
determine if there is anything wrong.

While on v6.3.x kernels, the report is different:

 	csum_errors: 16 <<<
 	verify_errors: 0
	[...]
 	uncorrectable_errors: 0
 	unverified_errors: 0
 	corrected_errors: 16 <<<

[CAUSE]
In the reworked scrub, we update the scrub progress inside
scrub_stripe_report_errors(), using various bitmaps to update the
result.

For example for csum_errors, we use bitmap_weight() of
stripe->csum_error_bitmap.

Unfortunately at that stage, all error bitmaps (except
init_error_bitmap) are the result of the latest repair attempt, thus if
the stripe is fully repaired, those error bitmaps will all be empty,
resulting the above output mismatch.

To fix this, record the number of errors into stripe->init_nr_*_errors.
Since we don't really care about where those errors are, we only need to
record the number of errors.

Then in scrub_stripe_report_errors(), use those initial numbers to
update the progress other than using the latest error bitmaps.

Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 375c1f8fef4d..f79f611bde74 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -134,8 +134,14 @@ struct scrub_stripe {
 	 * The errors hit during the initial read of the stripe.
 	 *
 	 * Would be utilized for error reporting and repair.
+	 *
+	 * The remaining init_nr_* records the number of errors hit, only
+	 * used by error reporting.
 	 */
 	unsigned long init_error_bitmap;
+	unsigned int init_nr_io_errors;
+	unsigned int init_nr_csum_errors;
+	unsigned int init_nr_meta_errors;
 
 	/*
 	 * The following error bitmaps are all for the current status.
@@ -968,12 +974,9 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 	sctx->stat.data_bytes_scrubbed += nr_data_sectors << fs_info->sectorsize_bits;
 	sctx->stat.tree_bytes_scrubbed += nr_meta_sectors << fs_info->sectorsize_bits;
 	sctx->stat.no_csum += nr_nodatacsum_sectors;
-	sctx->stat.read_errors +=
-		bitmap_weight(&stripe->io_error_bitmap, stripe->nr_sectors);
-	sctx->stat.csum_errors +=
-		bitmap_weight(&stripe->csum_error_bitmap, stripe->nr_sectors);
-	sctx->stat.verify_errors +=
-		bitmap_weight(&stripe->meta_error_bitmap, stripe->nr_sectors);
+	sctx->stat.read_errors += stripe->init_nr_io_errors;
+	sctx->stat.csum_errors += stripe->init_nr_csum_errors;
+	sctx->stat.verify_errors += stripe->init_nr_meta_errors;
 	sctx->stat.uncorrectable_errors +=
 		bitmap_weight(&stripe->error_bitmap, stripe->nr_sectors);
 	sctx->stat.corrected_errors += nr_repaired_sectors;
@@ -1006,6 +1009,12 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
 	scrub_verify_one_stripe(stripe, stripe->extent_sector_bitmap);
 	/* Save the initial failed bitmap for later repair and report usage. */
 	stripe->init_error_bitmap = stripe->error_bitmap;
+	stripe->init_nr_io_errors = bitmap_weight(&stripe->io_error_bitmap,
+						  stripe->nr_sectors);
+	stripe->init_nr_csum_errors = bitmap_weight(&stripe->csum_error_bitmap,
+						    stripe->nr_sectors);
+	stripe->init_nr_meta_errors = bitmap_weight(&stripe->meta_error_bitmap,
+						    stripe->nr_sectors);
 
 	if (bitmap_empty(&stripe->init_error_bitmap, stripe->nr_sectors))
 		goto out;
@@ -1455,6 +1464,9 @@ static void scrub_stripe_reset_bitmaps(struct scrub_stripe *stripe)
 {
 	stripe->extent_sector_bitmap = 0;
 	stripe->init_error_bitmap = 0;
+	stripe->init_nr_io_errors = 0;
+	stripe->init_nr_csum_errors = 0;
+	stripe->init_nr_meta_errors = 0;
 	stripe->error_bitmap = 0;
 	stripe->io_error_bitmap = 0;
 	stripe->csum_error_bitmap = 0;
-- 
2.40.1

