Return-Path: <linux-btrfs+bounces-13590-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF55AA58AF
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 May 2025 01:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF947B4599
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 23:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FBC22A1CA;
	Wed, 30 Apr 2025 23:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XmpoG8DY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Le8MJULp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDCE1EB1AF
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 23:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746055746; cv=none; b=ZbpsgiCSVIebxGHgCOP+fgpv5HPkbYU/m0T+YB1z5c3mdoisUIM4Ay/qsm3GdLRM7yQiGdO0O3NC2V9NMIBBYPekkCM0ANiJ7Z0S26yQFIFAVsuL/XjuLWMSirD8AebZuTjEYQUFB1x/jv00hLk6otdnHnxTxQRJkSKfOW6Klxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746055746; c=relaxed/simple;
	bh=zp9Dvr0xyGrFIPzmqOargNygWGAVC9zvzzDmKdFyjE4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mciWWXT9OERoNa4PfP6vjmak9RUXuOJhk+SnkFxga2Gia+Cqu6gLgyzte8b6K05OyC5LlMlApWkss7dkDUW8xRN1fRpK/zFoXUrRJlpusTfHDhAy6s1r32/chDNEThFb2WK+6XyR3yqeOm2K0GeVIrT1aoU0LRVy9ZtkiY+tRSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XmpoG8DY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Le8MJULp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B52801F38A
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 23:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746055741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Dn8Mywq7M9hR5dTEypxE0t5fJYyHCILTkxuctiXBST0=;
	b=XmpoG8DYwBqCnn7VEcjoqdlJBo3U6geCmjfSsU/TLM9tfJtvG9d4FHoLr+2NHoNA4/VrhV
	SoZOdC9PK1zlHe+kD1y/LeEFOTNyt3HdAmyylnqOghi5V1q4fontdmFsA/jt7aAHDv+Ui8
	Ct4nuFFW27XMG25I8DLGoHBhnQKBD+M=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Le8MJULp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746055740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Dn8Mywq7M9hR5dTEypxE0t5fJYyHCILTkxuctiXBST0=;
	b=Le8MJULpwviOo6j6AsOyIvQ+eb2I5yDRS9pZZbQ81R6SAJMPmuMUBVt7J5LvQKKzFMwh0A
	g6cquVIDHv+f6t54e3L2UXYLAyUeGxIXGuGEaZucBvTWKrqyjq+OcO4hujZJIU33YS56dS
	rJSdH06zvXlPO4xvYrpZhAYtJfZm/rA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9CBB139E7
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 23:28:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w0bBKTuyEmhdEwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 23:28:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: scrub: update device stats when an error is detected
Date: Thu,  1 May 2025 08:58:42 +0930
Message-ID: <1f9b59b90bc077095842003add7020fc9475f5f0.1746055699.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B52801F38A
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

[BUG]
Since the migration to the new scrub_stripe interface, scrub no longer
updates the device stats when hitting an error, no matter if it's a read
or checksum mismatch error. E.g:

 BTRFS info (device dm-2): scrub: started on devid 1
 BTRFS error (device dm-2): unable to fixup (regular) error at logical 13631488 on dev /dev/mapper/test-scratch1 physical 13631488
 BTRFS warning (device dm-2): checksum error at logical 13631488 on dev /dev/mapper/test-scratch1, physical 13631488, root 5, inode 257, offset 0, length 4096, links 1 (path: file)
 BTRFS error (device dm-2): unable to fixup (regular) error at logical 13631488 on dev /dev/mapper/test-scratch1 physical 13631488
 BTRFS warning (device dm-2): checksum error at logical 13631488 on dev /dev/mapper/test-scratch1, physical 13631488, root 5, inode 257, offset 0, length 4096, links 1 (path: file)
 BTRFS info (device dm-2): scrub: finished on devid 1 with status: 0

Note there is no line showing the device stats error update.

[CAUSE]
In the migration to the new scrub_stripe interface, we no longer call
btrfs_dev_stat_inc_and_print() anymore.

[FIX]
- Introduce a new bitmap for metadata generation errors
  * A new bitmap
    @meta_gen_error_bitmap is introduced to record which blocks have
    metadata generation mismatch errors.

  * A new counter for that bitmap
    @init_nr_meta_gen_errors, is also introduced to store the number of
    generation mismatch errors are found during the initial read.

    This is for the error reporting at scrub_stripe_report_errors().

  * New dedicated error message for unrepaired generation mismatches

  * Update @meta_gen_error_bitmap if a transis mismatch is hit

- Add btrfs_dev_stat_inc_and_print() calls to the following call sites
  * scrub_stripe_report_errors()
  * scrub_write_endio()
    This is only for the write errors.

This means there is a minor behavior change:

- The timing of device stats error message
  Since we concentrate the error messages at
  scrub_stripe_report_errors(), the device stats error messages will all
  show up in one go, after the detailed scrub error messages:

   BTRFS error (device dm-2): unable to fixup (regular) error at logical 13631488 on dev /dev/mapper/test-scratch1 physical 13631488
   BTRFS warning (device dm-2): checksum error at logical 13631488 on dev /dev/mapper/test-scratch1, physical 13631488, root 5, inode 257, offset 0, length 4096, links 1 (path: file)
   BTRFS error (device dm-2): unable to fixup (regular) error at logical 13631488 on dev /dev/mapper/test-scratch1 physical 13631488
   BTRFS warning (device dm-2): checksum error at logical 13631488 on dev /dev/mapper/test-scratch1, physical 13631488, root 5, inode 257, offset 0, length 4096, links 1 (path: file)
   BTRFS error (device dm-2): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
   BTRFS error (device dm-2): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0

Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 5d6166fd917e..212066734b88 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -153,12 +153,14 @@ struct scrub_stripe {
 	unsigned int init_nr_io_errors;
 	unsigned int init_nr_csum_errors;
 	unsigned int init_nr_meta_errors;
+	unsigned int init_nr_meta_gen_errors;
 
 	/*
 	 * The following error bitmaps are all for the current status.
 	 * Every time we submit a new read, these bitmaps may be updated.
 	 *
-	 * error_bitmap = io_error_bitmap | csum_error_bitmap | meta_error_bitmap;
+	 * error_bitmap = io_error_bitmap | csum_error_bitmap | meta_error_bitmap |
+	 *		  meta_generation_bitmap;
 	 *
 	 * IO and csum errors can happen for both metadata and data.
 	 */
@@ -166,6 +168,7 @@ struct scrub_stripe {
 	unsigned long io_error_bitmap;
 	unsigned long csum_error_bitmap;
 	unsigned long meta_error_bitmap;
+	unsigned long meta_gen_error_bitmap;
 
 	/* For writeback (repair or replace) error reporting. */
 	unsigned long write_error_bitmap;
@@ -662,7 +665,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 	}
 	if (stripe->sectors[sector_nr].generation !=
 	    btrfs_stack_header_generation(header)) {
-		bitmap_set(&stripe->meta_error_bitmap, sector_nr, sectors_per_tree);
+		bitmap_set(&stripe->meta_gen_error_bitmap, sector_nr, sectors_per_tree);
 		bitmap_set(&stripe->error_bitmap, sector_nr, sectors_per_tree);
 		btrfs_warn_rl(fs_info,
 		"tree block %llu mirror %u has bad generation, has %llu want %llu",
@@ -674,6 +677,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 	bitmap_clear(&stripe->error_bitmap, sector_nr, sectors_per_tree);
 	bitmap_clear(&stripe->csum_error_bitmap, sector_nr, sectors_per_tree);
 	bitmap_clear(&stripe->meta_error_bitmap, sector_nr, sectors_per_tree);
+	bitmap_clear(&stripe->meta_gen_error_bitmap, sector_nr, sectors_per_tree);
 }
 
 static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
@@ -971,8 +975,22 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 			if (__ratelimit(&rs) && dev)
 				scrub_print_common_warning("header error", dev, false,
 						     stripe->logical, physical);
+		if (test_bit(sector_nr, &stripe->meta_gen_error_bitmap))
+			if (__ratelimit(&rs) && dev)
+				scrub_print_common_warning("generation error", dev, false,
+						     stripe->logical, physical);
 	}
 
+	/* Update the device stats. */
+	for (int i = 0; i < stripe->init_nr_io_errors; i++)
+		btrfs_dev_stat_inc_and_print(stripe->dev, BTRFS_DEV_STAT_READ_ERRS);
+	for (int i = 0; i < stripe->init_nr_csum_errors; i++)
+		btrfs_dev_stat_inc_and_print(stripe->dev, BTRFS_DEV_STAT_CORRUPTION_ERRS);
+	/* Generation mismatch error is based on each metadata, not each block. */
+	for (int i = 0; i < stripe->init_nr_meta_gen_errors;
+	     i += fs_info->nodesize >> fs_info->sectorsize_bits)
+		btrfs_dev_stat_inc_and_print(stripe->dev, BTRFS_DEV_STAT_GENERATION_ERRS);
+
 	spin_lock(&sctx->stat_lock);
 	sctx->stat.data_extents_scrubbed += stripe->nr_data_extents;
 	sctx->stat.tree_extents_scrubbed += stripe->nr_meta_extents;
@@ -981,7 +999,8 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 	sctx->stat.no_csum += nr_nodatacsum_sectors;
 	sctx->stat.read_errors += stripe->init_nr_io_errors;
 	sctx->stat.csum_errors += stripe->init_nr_csum_errors;
-	sctx->stat.verify_errors += stripe->init_nr_meta_errors;
+	sctx->stat.verify_errors += stripe->init_nr_meta_errors +
+				    stripe->init_nr_meta_gen_errors;
 	sctx->stat.uncorrectable_errors +=
 		bitmap_weight(&stripe->error_bitmap, stripe->nr_sectors);
 	sctx->stat.corrected_errors += nr_repaired_sectors;
@@ -1027,6 +1046,8 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
 						    stripe->nr_sectors);
 	stripe->init_nr_meta_errors = bitmap_weight(&stripe->meta_error_bitmap,
 						    stripe->nr_sectors);
+	stripe->init_nr_meta_gen_errors = bitmap_weight(&stripe->meta_gen_error_bitmap,
+							stripe->nr_sectors);
 
 	if (bitmap_empty(&stripe->init_error_bitmap, stripe->nr_sectors))
 		goto out;
@@ -1141,6 +1162,9 @@ static void scrub_write_endio(struct btrfs_bio *bbio)
 		bitmap_set(&stripe->write_error_bitmap, sector_nr,
 			   bio_size >> fs_info->sectorsize_bits);
 		spin_unlock_irqrestore(&stripe->write_error_lock, flags);
+		for (int i = 0; i < bio_size >> fs_info->sectorsize_bits; i++)
+			btrfs_dev_stat_inc_and_print(stripe->dev,
+						     BTRFS_DEV_STAT_WRITE_ERRS);
 	}
 	bio_put(&bbio->bio);
 
@@ -1502,10 +1526,12 @@ static void scrub_stripe_reset_bitmaps(struct scrub_stripe *stripe)
 	stripe->init_nr_io_errors = 0;
 	stripe->init_nr_csum_errors = 0;
 	stripe->init_nr_meta_errors = 0;
+	stripe->init_nr_meta_gen_errors = 0;
 	stripe->error_bitmap = 0;
 	stripe->io_error_bitmap = 0;
 	stripe->csum_error_bitmap = 0;
 	stripe->meta_error_bitmap = 0;
+	stripe->meta_gen_error_bitmap = 0;
 }
 
 /*
-- 
2.49.0


