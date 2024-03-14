Return-Path: <linux-btrfs+bounces-3273-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7814C87BAB7
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 10:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2AF7B22F56
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 09:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD026D1D8;
	Thu, 14 Mar 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OoYRrN+W";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tAwnOoYb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDDB6CDC0
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409830; cv=none; b=uiiZ89DQbg5QJZIFnSO5+nH5cboDz2VoSZRzLRl0tJsR3QgaWkEPkYwp3H0BoHMJ2vqS26shIZCrSWLru10d1SS1EhNtctLQSMnDytLjzDtAutVb9OHPXvhF+NC4+KaOUh1Ls2rCiAbPuj/5FnTMpVEmbZKtpY8vAcEn13PQil4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409830; c=relaxed/simple;
	bh=64Zi0EUHzsDNQFG4vG6e0HxBbGZpLim5p5NERK9iIi8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AD2iyI4cvfhvSO9Qm9UekcRMTo7NV5aNlp3zwuq8mjwErYtayJ1V+PqAnLTzQ8kwaVp/HAOJX/ol2kiw1Op3Ep0UmFCyYWJ+ITHXd7wx1AHVA6FjAgIOcxpObDOlj3W75l8QMZxNfjBxymQ/5KAoj2Cgz1hCA0pOpRjaBI1AR1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OoYRrN+W; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tAwnOoYb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 104911F843
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710409827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWSyGW/ID1ZagfpwIdllBrADrpWYIpQBEDKl99fh05g=;
	b=OoYRrN+WN3mXj4jWPoRg3D8+8T9D44bWGvAtnMDoNoId8+MXRL+v8ID1AjlHIZJ7QgPVUl
	kQcKERwrSmPLVIZ48e+6whIDvI8rYcfOEFJ3Q81BOFJX8pTmnKuU2DQEYWQySvfwp0mjpu
	Wq3hXIEQ9vJ+IorQ6YPa1VTPgpbanFs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710409826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWSyGW/ID1ZagfpwIdllBrADrpWYIpQBEDKl99fh05g=;
	b=tAwnOoYbwZxz6OMSqsvu2XzyeeHaMGk7defpqZv+WmkJGhhrCC558zlcC6cCjMtoE9WL82
	x7/ycbANZtLxHxRc3T/oQTTApVK2kCotW/hGp/VzqY5Q5xFymT6DeJfWx2J+mJ+yerB6vg
	4qGjagaSW97k0WlT8XvZ63r5eJWPtxI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 449181386D
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aJshOmDI8mWPQQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/7] btrfs: scrub: fix incorrectly reported logical/physical address
Date: Thu, 14 Mar 2024 20:20:14 +1030
Message-ID: <ad7fa3eaa14b93b96cd09dae3657eb825d96d696.1710409033.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710409033.git.wqu@suse.com>
References: <cover.1710409033.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 URIBL_BLOCKED(0.00)[suse.com:email];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 1.90
X-Spam-Flag: NO

[BUG]
Scrub is not reporting the correct logical/physical address, it can be
verified by the following script:

 # mkfs.btrfs -f $dev1
 # mount $dev1 $mnt
 # xfs_io -f -c "pwrite -S 0xaa 0 128k" $mnt/file1
 # umount $mnt
 # xfs_io -f -c "pwrite -S 0xff 13647872 4k" $dev1
 # mount $dev1 $mnt
 # btrfs scrub start -fB $mnt
 # umount $mnt

Note above 13647872 is the physical address for logical 13631488 + 4K.

Scrub would report the following error:

 BTRFS error (device dm-2): unable to fixup (regular) error at logical 13631488 on dev /dev/mapper/test-scratch1 physical 13631488
 BTRFS warning (device dm-2): checksum error at logical 13631488 on dev /dev/mapper/test-scratch1, physical 13631488, root 5, inode 257, offset 0, length 4096, links 1 (path: file1)

On the other hand, "btrfs check --check-data-csum" is reporting the
correct logical/physical address:

 Checking filesystem on /dev/test/scratch1
 UUID: db2eb621-b09d-4f24-8199-da17dc7b3201
 [5/7] checking csums against data
 mirror 1 bytenr 13647872 csum 0x13fec125 expected csum 0x656bd64e
 ERROR: errors found in csum tree

[CAUSE]
In the function scrub_stripe_report_errors(), we always use the
stripe->logical and its physical address to print the error message, not
taking the sector number into consideration at all.

[FIX]
Fix the error reporting function by calculating logical/physical with
the sector number.

Now the scrub report is correct:

 BTRFS error (device dm-2): unable to fixup (regular) error at logical 13647872 on dev /dev/mapper/test-scratch1 physical 13647872
 BTRFS warning (device dm-2): checksum error at logical 13647872 on dev /dev/mapper/test-scratch1, physical 13647872, root 5, inode 257, offset 16384, length 4096, links 1 (path: file1)

Fixes: 0096580713ff ("btrfs: scrub: introduce error reporting functionality for scrub_stripe")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index fa25004ab04e..119e98797b21 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -870,7 +870,7 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 				      DEFAULT_RATELIMIT_BURST);
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_device *dev = NULL;
-	u64 physical = 0;
+	u64 stripe_physical = stripe->physical;
 	int nr_data_sectors = 0;
 	int nr_meta_sectors = 0;
 	int nr_nodatacsum_sectors = 0;
@@ -903,13 +903,17 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 		 */
 		if (ret < 0)
 			goto skip;
-		physical = bioc->stripes[stripe_index].physical;
+		stripe_physical = bioc->stripes[stripe_index].physical;
 		dev = bioc->stripes[stripe_index].dev;
 		btrfs_put_bioc(bioc);
 	}
 
 skip:
 	for_each_set_bit(sector_nr, &stripe->extent_sector_bitmap, stripe->nr_sectors) {
+		u64 logical = stripe->logical +
+			      (sector_nr << fs_info->sectorsize_bits);
+		u64 physical = stripe_physical +
+			      (sector_nr << fs_info->sectorsize_bits);
 		bool repaired = false;
 
 		if (stripe->sectors[sector_nr].is_metadata) {
@@ -938,12 +942,12 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 			if (dev) {
 				btrfs_err_rl_in_rcu(fs_info,
 			"fixed up error at logical %llu on dev %s physical %llu",
-					    stripe->logical, btrfs_dev_name(dev),
+					    logical, btrfs_dev_name(dev),
 					    physical);
 			} else {
 				btrfs_err_rl_in_rcu(fs_info,
 			"fixed up error at logical %llu on mirror %u",
-					    stripe->logical, stripe->mirror_num);
+					    logical, stripe->mirror_num);
 			}
 			continue;
 		}
@@ -952,26 +956,26 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 		if (dev) {
 			btrfs_err_rl_in_rcu(fs_info,
 	"unable to fixup (regular) error at logical %llu on dev %s physical %llu",
-					    stripe->logical, btrfs_dev_name(dev),
+					    logical, btrfs_dev_name(dev),
 					    physical);
 		} else {
 			btrfs_err_rl_in_rcu(fs_info,
 	"unable to fixup (regular) error at logical %llu on mirror %u",
-					    stripe->logical, stripe->mirror_num);
+					    logical, stripe->mirror_num);
 		}
 
 		if (test_bit(sector_nr, &stripe->io_error_bitmap))
 			if (__ratelimit(&rs) && dev)
 				scrub_print_common_warning("i/o error", dev, false,
-						     stripe->logical, physical);
+						     logical, physical);
 		if (test_bit(sector_nr, &stripe->csum_error_bitmap))
 			if (__ratelimit(&rs) && dev)
 				scrub_print_common_warning("checksum error", dev, false,
-						     stripe->logical, physical);
+						     logical, physical);
 		if (test_bit(sector_nr, &stripe->meta_error_bitmap))
 			if (__ratelimit(&rs) && dev)
 				scrub_print_common_warning("header error", dev, false,
-						     stripe->logical, physical);
+						     logical, physical);
 	}
 
 	spin_lock(&sctx->stat_lock);
-- 
2.44.0


