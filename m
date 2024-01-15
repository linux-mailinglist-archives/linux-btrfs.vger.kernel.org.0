Return-Path: <linux-btrfs+bounces-1447-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDB082D718
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jan 2024 11:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE842820C3
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jan 2024 10:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008D0249E2;
	Mon, 15 Jan 2024 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z54xMI+7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z54xMI+7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3185E1E86C
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jan 2024 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2EFF51F8A8;
	Mon, 15 Jan 2024 10:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705313976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MYAK6KH7q3LDFdp/Ax64qMhcgypd5Gs40uZXTXcxAEI=;
	b=Z54xMI+7xLkbW82G0cnHdFdUKGhWMTvR0AP433+7Dnn77A9qvVqVd2A5v8o7w0hQ6YghnM
	WcWee2AwF+1emEGOcHGGwcZS0ehYdxdpexswoX3M4/nsBE/pGrskW035ANKDARyOXOCxDj
	7fA5ZHh88gH5dmJ7dbPlRLhstNGnVBk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705313976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MYAK6KH7q3LDFdp/Ax64qMhcgypd5Gs40uZXTXcxAEI=;
	b=Z54xMI+7xLkbW82G0cnHdFdUKGhWMTvR0AP433+7Dnn77A9qvVqVd2A5v8o7w0hQ6YghnM
	WcWee2AwF+1emEGOcHGGwcZS0ehYdxdpexswoX3M4/nsBE/pGrskW035ANKDARyOXOCxDj
	7fA5ZHh88gH5dmJ7dbPlRLhstNGnVBk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05B32132FA;
	Mon, 15 Jan 2024 10:19:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o2XtLbYGpWVyJwAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 15 Jan 2024 10:19:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Rongrong <i@rong.moe>
Subject: [PATCH] btrfs: scrub: avoid use-after-free when chunk end is not 64K aligned
Date: Mon, 15 Jan 2024 20:49:16 +1030
Message-ID: <8531c41848973ac60ca4e23e2c7a2a47c4b94881.1705313879.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[rong.moe:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

[BUG]
There is a bug report that, on a ext4-converted btrfs, scrub leads to
various problems, including:

- "unable to find chunk map" errors
  BTRFS info (device vdb): scrub: started on devid 1
  BTRFS critical (device vdb): unable to find chunk map for logical 2214744064 length 4096
  BTRFS critical (device vdb): unable to find chunk map for logical 2214744064 length 45056

  This would lead to unrepariable errors.

- Use-after-free KASAN reports:
  ==================================================================
  BUG: KASAN: slab-use-after-free in __blk_rq_map_sg+0x18f/0x7c0
  Read of size 8 at addr ffff8881013c9040 by task btrfs/909
  CPU: 0 PID: 909 Comm: btrfs Not tainted 6.7.0-x64v3-dbg #11 c50636e9419a8354555555245df535e380563b2b
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2023.11-2 12/24/2023
  Call Trace:
   <TASK>
   dump_stack_lvl+0x43/0x60
   print_report+0xcf/0x640
   kasan_report+0xa6/0xd0
   __blk_rq_map_sg+0x18f/0x7c0
   virtblk_prep_rq.isra.0+0x215/0x6a0 [virtio_blk 19a65eeee9ae6fcf02edfad39bb9ddee07dcdaff]
   virtio_queue_rqs+0xc4/0x310 [virtio_blk 19a65eeee9ae6fcf02edfad39bb9ddee07dcdaff]
   blk_mq_flush_plug_list.part.0+0x780/0x860
   __blk_flush_plug+0x1ba/0x220
   blk_finish_plug+0x3b/0x60
   submit_initial_group_read+0x10a/0x290 [btrfs e57987a360bed82fe8756dcd3e0de5406ccfe965]
   flush_scrub_stripes+0x38e/0x430 [btrfs e57987a360bed82fe8756dcd3e0de5406ccfe965]
   scrub_stripe+0x82a/0xae0 [btrfs e57987a360bed82fe8756dcd3e0de5406ccfe965]
   scrub_chunk+0x178/0x200 [btrfs e57987a360bed82fe8756dcd3e0de5406ccfe965]
   scrub_enumerate_chunks+0x4bc/0xa30 [btrfs e57987a360bed82fe8756dcd3e0de5406ccfe965]
   btrfs_scrub_dev+0x398/0x810 [btrfs e57987a360bed82fe8756dcd3e0de5406ccfe965]
   btrfs_ioctl+0x4b9/0x3020 [btrfs e57987a360bed82fe8756dcd3e0de5406ccfe965]
   __x64_sys_ioctl+0xbd/0x100
   do_syscall_64+0x5d/0xe0
   entry_SYSCALL_64_after_hwframe+0x63/0x6b
  RIP: 0033:0x7f47e5e0952b

- Crash, mostly due to above use-after-free

[CAUSE]
The converted fs has the following data chunk layout:

    item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 2214658048) itemoff 16025 itemsize 80
        length 86016 owner 2 stripe_len 65536 type DATA|single

For above logical bytenr 2214744064, it's at the chunk end
(2214744064 + 86016 = 2214744064).

This means btrfs_submit_bio() would split the bio, and trigger endio
function for both of the two halves.

However scrub_submit_initial_read() would only expect the endio function
to be called once, not any more.
This means the first endio function would already free the bbio::bio,
leaving the bvec freed, thus the 2nd endio call would lead to
use-after-free.

[FIX]
- Make sure scrub_read_endio() only updates bits in its range
  This is not only for the fix, but also for the existing code
  of RST scrub.
  Since RST scrub can only submit part of the stripe, we can no longer
  assume the initial read bbio is always the full 64K.

- Make sure scrub_submit_initial_read() only to read the chunk range
  This is done by calculating the real number of sectors we need to
  read, and add sector-by-sector to the bio.

- Make sure scrub_submit_extent_sector_read() won't read beyond chunk
  Normally this function won't read beyond chunk as it would only
  read ranges covered by an extent.
  But in the case of corrupted extent tree, where an extent can exist
  beyond chunk boundary, we can still read beyond chunk.
  In this case, add extra checks to prevent such read beyond chunk.

Thankfully the other scrub read path won't need extra fixes:

- scrub_stripe_submit_repair_read()
  With above fixes, we won't update error bit for range beyond chunk,
  thus scrub_stripe_submit_repair_read() should never submit any read
  beyond the chunk.

Reported-by: Rongrong <i@rong.moe>
Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure")
Tested-by: Rongrong <i@rong.moe>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a01807cbd4d4..01dd146f050d 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1098,12 +1098,22 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
 static void scrub_read_endio(struct btrfs_bio *bbio)
 {
 	struct scrub_stripe *stripe = bbio->private;
+	struct bio_vec *bvec;
+	int sector_nr = calc_sector_number(stripe, bio_first_bvec_all(&bbio->bio));
+	int num_sectors;
+	u32 bio_size = 0;
+	int i;
+
+	ASSERT(sector_nr < stripe->nr_sectors);
+	bio_for_each_bvec_all(bvec, &bbio->bio, i)
+		bio_size += bvec->bv_len;
+	num_sectors = bio_size >> stripe->bg->fs_info->sectorsize_bits;
 
 	if (bbio->bio.bi_status) {
-		bitmap_set(&stripe->io_error_bitmap, 0, stripe->nr_sectors);
-		bitmap_set(&stripe->error_bitmap, 0, stripe->nr_sectors);
+		bitmap_set(&stripe->io_error_bitmap, sector_nr, num_sectors);
+		bitmap_set(&stripe->error_bitmap, sector_nr, num_sectors);
 	} else {
-		bitmap_clear(&stripe->io_error_bitmap, 0, stripe->nr_sectors);
+		bitmap_clear(&stripe->io_error_bitmap, sector_nr, num_sectors);
 	}
 	bio_put(&bbio->bio);
 	if (atomic_dec_and_test(&stripe->pending_io)) {
@@ -1636,6 +1646,9 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct btrfs_bio *bbio = NULL;
+	unsigned int nr_sectors = min(BTRFS_STRIPE_LEN, stripe->bg->start +
+				      stripe->bg->length - stripe->logical) >>
+				  fs_info->sectorsize_bits;
 	u64 stripe_len = BTRFS_STRIPE_LEN;
 	int mirror = stripe->mirror_num;
 	int i;
@@ -1646,6 +1659,9 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
 		struct page *page = scrub_stripe_get_page(stripe, i);
 		unsigned int pgoff = scrub_stripe_get_page_offset(stripe, i);
 
+		if (i >= nr_sectors)
+			break;
+
 		/* The current sector cannot be merged, submit the bio. */
 		if (bbio &&
 		    ((i > 0 &&
@@ -1701,6 +1717,9 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_bio *bbio;
+	unsigned int nr_sectors = min(BTRFS_STRIPE_LEN, stripe->bg->start +
+				      stripe->bg->length - stripe->logical) >>
+				  fs_info->sectorsize_bits;
 	int mirror = stripe->mirror_num;
 
 	ASSERT(stripe->bg);
@@ -1715,14 +1734,16 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 	bbio = btrfs_bio_alloc(SCRUB_STRIPE_PAGES, REQ_OP_READ, fs_info,
 			       scrub_read_endio, stripe);
 
-	/* Read the whole stripe. */
 	bbio->bio.bi_iter.bi_sector = stripe->logical >> SECTOR_SHIFT;
-	for (int i = 0; i < BTRFS_STRIPE_LEN >> PAGE_SHIFT; i++) {
+	/* Read the whole range inside the chunk boundary. */
+	for (unsigned int cur = 0; cur < nr_sectors; cur++) {
+		struct page *page = scrub_stripe_get_page(stripe, cur);
+		unsigned int pgoff = scrub_stripe_get_page_offset(stripe, cur);
 		int ret;
 
-		ret = bio_add_page(&bbio->bio, stripe->pages[i], PAGE_SIZE, 0);
+		ret = bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
 		/* We should have allocated enough bio vectors. */
-		ASSERT(ret == PAGE_SIZE);
+		ASSERT(ret == fs_info->sectorsize);
 	}
 	atomic_inc(&stripe->pending_io);
 
-- 
2.43.0


