Return-Path: <linux-btrfs+bounces-13600-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D18AA67AC
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 02:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49062189132E
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 00:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A7928E7;
	Fri,  2 May 2025 00:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="g+leJ3h5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="g+leJ3h5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD3EEC4
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 00:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746144691; cv=none; b=VCTnA1BmJDQW6xK0xl5NctQPdcxfC98ncOMjHoGaCoL0buCFai2cMQ13ZrFe6w1ah/ipeIIUH0lmiXJYdQfVr1H/b+zha7C49UWBVo9oKwmlunWpBggjsJwrSo0YkKGFVZRnfC2cmV33T7ZYjylC6bIaimPZ4pqH6JIdVncDTUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746144691; c=relaxed/simple;
	bh=w9pfAwj4zfclCxrWMAGUSzG9HzOk1lyZ4MoCdko09I8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=B359sgjJj/M15EGFXHFPVj3BtW5BrewoWEe0T+n+ZJ8RZx5eyEnybt7ozj8z1SRtpjuOCiaMg3q8SIlpDp5Hm/GmmCju7mFUjxp3swphs/1DPWT0emVqksx5Oy0IhEmGeIYUnjELtZOlbh7fSQDBo/G0p+Wfnx7ckw34VL7sllU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=g+leJ3h5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=g+leJ3h5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 91F1621A48
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 00:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746144686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8L9sceClxuNk8UAwCfYBcKiRK4votRAmqJdCQ97UNcM=;
	b=g+leJ3h5IFvtOk00xkwDeua1/TpVBE1Me9Jx93SIQxAiaOQyIl6UQe5s1OTCi2rNHTiACE
	8Lkg9Jr0SCxYfJpvHV54B6FgNGrNMq8N60d/89K3Ai2X1mW59VIuQpnwYhnfGnsGPDuL+k
	XdA8lVNh0iplv6L+/J8IN7gbUM1+xqs=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746144686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8L9sceClxuNk8UAwCfYBcKiRK4votRAmqJdCQ97UNcM=;
	b=g+leJ3h5IFvtOk00xkwDeua1/TpVBE1Me9Jx93SIQxAiaOQyIl6UQe5s1OTCi2rNHTiACE
	8Lkg9Jr0SCxYfJpvHV54B6FgNGrNMq8N60d/89K3Ai2X1mW59VIuQpnwYhnfGnsGPDuL+k
	XdA8lVNh0iplv6L+/J8IN7gbUM1+xqs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C211813306
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 00:11:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DRbvH60NFGiqVQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 02 May 2025 00:11:25 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: scrub: move error reporting members to stack
Date: Fri,  2 May 2025 09:41:07 +0930
Message-ID: <142a1de91d82b12c583f3d18efcdd92529a1d664.1746144642.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Currently the following members of scrub_stripe are only utilized for
error reporting:

- init_error_bitmap
- init_nr_io_errors
- init_nr_csum_errors
- init_nr_meta_errors
- init_nr_meta_gen_errors

There is no need to put all those members into scrub_stripe, which takes
24 bytes for each stripe, and we have 128 stripes for each device.

Instead introduce a structure, scrub_error_records, and move all above
members into that structure.

And allocate such structure from stack inside
scrub_stripe_read_repair_worker().
Since that function is called from a workqueue context, we have more
than enough stack space for just 24 bytes.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This relies on a previous patch fixing scrub device stats update:
  https://lore.kernel.org/linux-btrfs/1f9b59b90bc077095842003add7020fc9475f5f0.1746055699.git.wqu@suse.com/T/#u
---
 fs/btrfs/scrub.c | 82 +++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 212066734b88..4ac615143e72 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -141,20 +141,6 @@ struct scrub_stripe {
 	/* Indicate which sectors are covered by extent items. */
 	unsigned long extent_sector_bitmap;
 
-	/*
-	 * The errors hit during the initial read of the stripe.
-	 *
-	 * Would be utilized for error reporting and repair.
-	 *
-	 * The remaining init_nr_* records the number of errors hit, only used
-	 * by error reporting.
-	 */
-	unsigned long init_error_bitmap;
-	unsigned int init_nr_io_errors;
-	unsigned int init_nr_csum_errors;
-	unsigned int init_nr_meta_errors;
-	unsigned int init_nr_meta_gen_errors;
-
 	/*
 	 * The following error bitmaps are all for the current status.
 	 * Every time we submit a new read, these bitmaps may be updated.
@@ -231,6 +217,21 @@ struct scrub_warning {
 	struct btrfs_device	*dev;
 };
 
+/* Various members that are only for error reporting. */
+struct scrub_error_records {
+	/*
+	 * Bitmap recording which blocks hit errors (IO/csum/...) during
+	 * the initial read.
+	 */
+	unsigned long init_error_bitmap;
+
+	/* How many errors hit for each type (IO, csum, metadata). */
+	unsigned int init_nr_io_errors;
+	unsigned int init_nr_csum_errors;
+	unsigned int init_nr_meta_errors;
+	unsigned int init_nr_meta_gen_errors;
+};
+
 static void release_scrub_stripe(struct scrub_stripe *stripe)
 {
 	if (!stripe)
@@ -867,7 +868,8 @@ static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
 }
 
 static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
-				       struct scrub_stripe *stripe)
+				       struct scrub_stripe *stripe,
+				       const struct scrub_error_records *errors)
 {
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
@@ -889,7 +891,7 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 	 * Although our scrub_stripe infrastructure is mostly based on btrfs_submit_bio()
 	 * thus no need for dev/physical, error reporting still needs dev and physical.
 	 */
-	if (!bitmap_empty(&stripe->init_error_bitmap, stripe->nr_sectors)) {
+	if (!bitmap_empty(&errors->init_error_bitmap, stripe->nr_sectors)) {
 		u64 mapped_len = fs_info->sectorsize;
 		struct btrfs_io_context *bioc = NULL;
 		int stripe_index = stripe->mirror_num - 1;
@@ -923,14 +925,14 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 				nr_nodatacsum_sectors++;
 		}
 
-		if (test_bit(sector_nr, &stripe->init_error_bitmap) &&
+		if (test_bit(sector_nr, &errors->init_error_bitmap) &&
 		    !test_bit(sector_nr, &stripe->error_bitmap)) {
 			nr_repaired_sectors++;
 			repaired = true;
 		}
 
 		/* Good sector from the beginning, nothing need to be done. */
-		if (!test_bit(sector_nr, &stripe->init_error_bitmap))
+		if (!test_bit(sector_nr, &errors->init_error_bitmap))
 			continue;
 
 		/*
@@ -982,12 +984,12 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 	}
 
 	/* Update the device stats. */
-	for (int i = 0; i < stripe->init_nr_io_errors; i++)
+	for (int i = 0; i < errors->init_nr_io_errors; i++)
 		btrfs_dev_stat_inc_and_print(stripe->dev, BTRFS_DEV_STAT_READ_ERRS);
-	for (int i = 0; i < stripe->init_nr_csum_errors; i++)
+	for (int i = 0; i < errors->init_nr_csum_errors; i++)
 		btrfs_dev_stat_inc_and_print(stripe->dev, BTRFS_DEV_STAT_CORRUPTION_ERRS);
 	/* Generation mismatch error is based on each metadata, not each block. */
-	for (int i = 0; i < stripe->init_nr_meta_gen_errors;
+	for (int i = 0; i < errors->init_nr_meta_gen_errors;
 	     i += fs_info->nodesize >> fs_info->sectorsize_bits)
 		btrfs_dev_stat_inc_and_print(stripe->dev, BTRFS_DEV_STAT_GENERATION_ERRS);
 
@@ -997,10 +999,10 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 	sctx->stat.data_bytes_scrubbed += nr_data_sectors << fs_info->sectorsize_bits;
 	sctx->stat.tree_bytes_scrubbed += nr_meta_sectors << fs_info->sectorsize_bits;
 	sctx->stat.no_csum += nr_nodatacsum_sectors;
-	sctx->stat.read_errors += stripe->init_nr_io_errors;
-	sctx->stat.csum_errors += stripe->init_nr_csum_errors;
-	sctx->stat.verify_errors += stripe->init_nr_meta_errors +
-				    stripe->init_nr_meta_gen_errors;
+	sctx->stat.read_errors += errors->init_nr_io_errors;
+	sctx->stat.csum_errors += errors->init_nr_csum_errors;
+	sctx->stat.verify_errors += errors->init_nr_meta_errors +
+				    errors->init_nr_meta_gen_errors;
 	sctx->stat.uncorrectable_errors +=
 		bitmap_weight(&stripe->error_bitmap, stripe->nr_sectors);
 	sctx->stat.corrected_errors += nr_repaired_sectors;
@@ -1028,6 +1030,7 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
 	struct scrub_stripe *stripe = container_of(work, struct scrub_stripe, work);
 	struct scrub_ctx *sctx = stripe->sctx;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	struct scrub_error_records errors = { 0 };
 	int num_copies = btrfs_num_copies(fs_info, stripe->bg->start,
 					  stripe->bg->length);
 	unsigned long repaired;
@@ -1039,17 +1042,17 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
 	wait_scrub_stripe_io(stripe);
 	scrub_verify_one_stripe(stripe, stripe->extent_sector_bitmap);
 	/* Save the initial failed bitmap for later repair and report usage. */
-	stripe->init_error_bitmap = stripe->error_bitmap;
-	stripe->init_nr_io_errors = bitmap_weight(&stripe->io_error_bitmap,
-						  stripe->nr_sectors);
-	stripe->init_nr_csum_errors = bitmap_weight(&stripe->csum_error_bitmap,
-						    stripe->nr_sectors);
-	stripe->init_nr_meta_errors = bitmap_weight(&stripe->meta_error_bitmap,
-						    stripe->nr_sectors);
-	stripe->init_nr_meta_gen_errors = bitmap_weight(&stripe->meta_gen_error_bitmap,
-							stripe->nr_sectors);
+	errors.init_error_bitmap = stripe->error_bitmap;
+	errors.init_nr_io_errors = bitmap_weight(&stripe->io_error_bitmap,
+						 stripe->nr_sectors);
+	errors.init_nr_csum_errors = bitmap_weight(&stripe->csum_error_bitmap,
+						   stripe->nr_sectors);
+	errors.init_nr_meta_errors = bitmap_weight(&stripe->meta_error_bitmap,
+						   stripe->nr_sectors);
+	errors.init_nr_meta_errors = bitmap_weight(&stripe->meta_gen_error_bitmap,
+						   stripe->nr_sectors);
 
-	if (bitmap_empty(&stripe->init_error_bitmap, stripe->nr_sectors))
+	if (bitmap_empty(&errors.init_error_bitmap, stripe->nr_sectors))
 		goto out;
 
 	/*
@@ -1099,7 +1102,7 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
 	 * Submit the repaired sectors.  For zoned case, we cannot do repair
 	 * in-place, but queue the bg to be relocated.
 	 */
-	bitmap_andnot(&repaired, &stripe->init_error_bitmap, &stripe->error_bitmap,
+	bitmap_andnot(&repaired, &errors.init_error_bitmap, &stripe->error_bitmap,
 		      stripe->nr_sectors);
 	if (!sctx->readonly && !bitmap_empty(&repaired, stripe->nr_sectors)) {
 		if (btrfs_is_zoned(fs_info)) {
@@ -1110,7 +1113,7 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
 		}
 	}
 
-	scrub_stripe_report_errors(sctx, stripe);
+	scrub_stripe_report_errors(sctx, stripe, &errors);
 	set_bit(SCRUB_STRIPE_FLAG_REPAIR_DONE, &stripe->state);
 	wake_up(&stripe->repair_wait);
 }
@@ -1522,11 +1525,6 @@ static void fill_one_extent_info(struct btrfs_fs_info *fs_info,
 static void scrub_stripe_reset_bitmaps(struct scrub_stripe *stripe)
 {
 	stripe->extent_sector_bitmap = 0;
-	stripe->init_error_bitmap = 0;
-	stripe->init_nr_io_errors = 0;
-	stripe->init_nr_csum_errors = 0;
-	stripe->init_nr_meta_errors = 0;
-	stripe->init_nr_meta_gen_errors = 0;
 	stripe->error_bitmap = 0;
 	stripe->io_error_bitmap = 0;
 	stripe->csum_error_bitmap = 0;
-- 
2.49.0


