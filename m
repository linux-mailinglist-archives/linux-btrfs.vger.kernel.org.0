Return-Path: <linux-btrfs+bounces-1495-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B537282FE02
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 01:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A563289043
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 00:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3927494;
	Wed, 17 Jan 2024 00:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SD9LhRbC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SD9LhRbC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665335CB0
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 00:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705451575; cv=none; b=s+49gIDoevShmuOjG2dh2l9un8x49VduSeNgWaLzeS1kbKvaE/kV7w/tGBVFKd0erIzp5h9DBpeddFEhUkuA/5J2zU+gM5nqSQnLluUci84u7kNKdqIGqyYB33W89zdEfwTI/lV344DkRHW2kJ7xVC13qDVtn25jWOqmK/FnHT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705451575; c=relaxed/simple;
	bh=eJs9jaULeHaZ4jZv64zMtjFcvaA46RMRcbBkBMeQUUA=;
	h=Received:DKIM-Signature:DKIM-Signature:Received:Received:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Level:
	 X-Spam-Score:X-Spam-Flag; b=kLtn8axrbJJroiKLDGQ9CEyTdePVKkOAGYnChMnOGXN1+2astHpiDeqLu+1K0EsHXBW16Er8JgJHOxwD3pOQn53euAmcTOTakqR8C4CLKQU2gLiY0mk4LWk46oG+U9nMzXqbhNEbJ0Puj/R/Ih4CH8fG/hUVr9+hTLpKJeFTXQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SD9LhRbC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SD9LhRbC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3F3C41FBB1;
	Wed, 17 Jan 2024 00:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705451571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yp10zo7Wf44kVSyHAB2EstdGgQR6v7svrDzvlxu20w4=;
	b=SD9LhRbCDzH4+qdpvMw/S6DfqmpqZOGZ1PHrhyBwPtG1rHOaNz8oQ+tQmdQurzvF2maros
	jbwHJVYn+X9Rn71rD1qrgKLX7OgiNh5wkiud2T4Lgm6XwwcUOm5XZzA3vagasWZqP/iu4N
	RW5uNGghXDgS8y+XdijjdsJZkxh/YKc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705451571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yp10zo7Wf44kVSyHAB2EstdGgQR6v7svrDzvlxu20w4=;
	b=SD9LhRbCDzH4+qdpvMw/S6DfqmpqZOGZ1PHrhyBwPtG1rHOaNz8oQ+tQmdQurzvF2maros
	jbwHJVYn+X9Rn71rD1qrgKLX7OgiNh5wkiud2T4Lgm6XwwcUOm5XZzA3vagasWZqP/iu4N
	RW5uNGghXDgS8y+XdijjdsJZkxh/YKc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B0B913751;
	Wed, 17 Jan 2024 00:32:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UF7EMjEgp2W0GgAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 17 Jan 2024 00:32:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Rongrong <i@rong.moe>
Subject: [PATCH v2 1/2] btrfs: scrub: avoid use-after-free when chunk length is not 64K aligned
Date: Wed, 17 Jan 2024 11:02:25 +1030
Message-ID: <f3accaf4408bbf124abc61e674d13e3f83fd8745.1705449249.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705449249.git.wqu@suse.com>
References: <cover.1705449249.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 URIBL_BLOCKED(0.00)[suse.com:email,rong.moe:email];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
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
(2214658048 + 86016 = 2214744064).

This means btrfs_submit_bio() would split the bio, and trigger endio
function for both of the two halves.

However scrub_submit_initial_read() would only expect the endio function
to be called once, not any more.
This means the first endio function would already free the bbio::bio,
leaving the bvec freed, thus the 2nd endio call would lead to
use-after-free.

[FIX]
- Make sure scrub_read_endio() only updates bits in its range
  Since we may read less than 64K at the end of the chunk, we should not
  touch the bits beyond chunk boundary.

- Make sure scrub_submit_initial_read() only to read the chunk range
  This is done by calculating the real number of sectors we need to
  read, and add sector-by-sector to the bio.

Thankfully the scrub read repair path won't need extra fixes:

- scrub_stripe_submit_repair_read()
  With above fixes, we won't update error bit for range beyond chunk,
  thus scrub_stripe_submit_repair_read() should never submit any read
  beyond the chunk.

Reported-by: Rongrong <i@rong.moe>
Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure")
Tested-by: Rongrong <i@rong.moe>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a01807cbd4d4..2d81b1a18a04 100644
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
@@ -1701,6 +1711,9 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_bio *bbio;
+	unsigned int nr_sectors = min(BTRFS_STRIPE_LEN, stripe->bg->start +
+				      stripe->bg->length - stripe->logical) >>
+				  fs_info->sectorsize_bits;
 	int mirror = stripe->mirror_num;
 
 	ASSERT(stripe->bg);
@@ -1715,14 +1728,16 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
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


