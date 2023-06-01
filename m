Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1A3719A2C
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 12:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjFAKv5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 06:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjFAKvz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 06:51:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414CB9D
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jun 2023 03:51:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D8DD721977;
        Thu,  1 Jun 2023 10:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685616712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Bg5xe+Pi5foQ89KFBXFJgdXsIup7qqK8OjyIzytSDDs=;
        b=VOVlJKYGZLxZz4XQcIMDkDI9BsqC7p24niKHv6TwRXFehU6xSXRNMOKyUv+V1/RV0o0YIU
        XgGDb+LPvfVDiJU1qmXzX2RJlsjaW8AoZ6Zqgw3WTs8VgBt8hCX2WtQ8Hq4+5e3EPxWT+o
        QiU3BWAscovcF8PajicwQg55LooHzQo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0443B13441;
        Thu,  1 Jun 2023 10:51:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pr4+MEd4eGSoVAAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 01 Jun 2023 10:51:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] btrfs: fix dev-replace after the scrub rework
Date:   Thu,  1 Jun 2023 18:51:34 +0800
Message-Id: <61e46bae045ec4e5173874dc81cb178e456644ab.1685616199.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
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

[BUG]
After commit e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror()
to scrub_stripe infrastructure"), scrub no longer works for zoned device
at all.

Even an empty zoned btrfs can not be replaced:

 # mkfs.btrfs -f /dev/nvme0n1
 # mount /dev/nvme0n1 /mnt/btrfs
 # btrfs replace start -Bf 1 /dev/nvme0n2 /mnt/btrfs
 Resetting device zones /dev/nvme1n1 (160 zones) ...
 ERROR: ioctl(DEV_REPLACE_START) failed on "/mnt/btrfs/": Input/output error

And we can hit kernel crash related to that:

 BTRFS info (device nvme1n1): host-managed zoned block device /dev/nvme3n1, 160 zones of 134217728 bytes
 BTRFS info (device nvme1n1): dev_replace from /dev/nvme2n1 (devid 2) to /dev/nvme3n1 started
 nvme3n1: Zone Management Append(0x7d) @ LBA 65536, 4 blocks, Zone Is Full (sct 0x1 / sc 0xb9) DNR
 I/O error, dev nvme3n1, sector 786432 op 0xd:(ZONE_APPEND) flags 0x4000 phys_seg 3 prio class 2
 BTRFS error (device nvme1n1): bdev /dev/nvme3n1 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
 BUG: kernel NULL pointer dereference, address: 00000000000000a8
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
 RIP: 0010:_raw_spin_lock_irqsave+0x1e/0x40
 Call Trace:
  <IRQ>
  btrfs_lookup_ordered_extent+0x31/0x190
  btrfs_record_physical_zoned+0x18/0x40
  btrfs_simple_end_io+0xaf/0xc0
  blk_update_request+0x153/0x4c0
  blk_mq_end_request+0x15/0xd0
  nvme_poll_cq+0x1d3/0x360
  nvme_irq+0x39/0x80
  __handle_irq_event_percpu+0x3b/0x190
  handle_irq_event+0x2f/0x70
  handle_edge_irq+0x7c/0x210
  __common_interrupt+0x34/0xa0
  common_interrupt+0x7d/0xa0
  </IRQ>
  <TASK>
  asm_common_interrupt+0x22/0x40

[CAUSE]
Dev-replace reuses scrub code to iterate all extents and write the
existing content back to the new device.

And for zoned devices, we call fill_writer_pointer_gap() to make sure
all the writes into the zoned device is sequential, even if there may be
some gaps between the writes.

However we have several different bugs all related to zoned dev-replace:

- We are using ZONE_APPEND operation for metadata style write back
  For zoned devices, btrfs has two ways to write data:

  * ZONE_APPEND for data
    This allows higher queue depth, but will not be able to know where
    the write would land.
    Thus needs to grab the real on-disk physical location in it's endio.

  * WRITE for metadata
    This requires single queue depth (new writes can only be submitted
    after previous one finished), and all writes must be sequential.

  For scrub, we go single queue depth, but still goes with ZONE_APPEND,
  which requires btrfs_bio::inode being populated.
  This is the cause of that crash.

- No correct tracing of write_pointer
  After a write finished, we should forward sctx->write_pointer, or
  fill_writer_pointer_gap() would not work properly and cause more
  than necessary zero out, and fill the whole zone prematurely.

- Incorrect physical bytenr passed to fill_writer_pointer_gap()
  In scrub_write_sectors(), one call site passes logical address, which
  is completely wrong.

  The other call site passes physical address of current sector, but
  we should pass the physical address of the btrfs_bio we're submitting.

  This is the cause of the -EIO errors.

[FIX]
- Do not use ZONE_APPEND for btrfs_submit_repair_write().

- Manually forward sctx->write_pointer after success writeback

- Use the physical address of the to-be-submitted btrfs_bio for
  fill_writer_pointer_gap()

Now zoned device replace would work as expected.

Reported-by: Christoph Hellwig <hch@lst.de>
Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Concentrace the write bio submission into a dedicated helper
  This would cleanup the code as the submission part is getting more
  complex than before.
---
 fs/btrfs/bio.c   |  4 ----
 fs/btrfs/scrub.c | 48 ++++++++++++++++++++++++++++++++----------------
 2 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 85511a8a4801..c9b4aa339b4b 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -785,10 +785,6 @@ void btrfs_submit_repair_write(struct btrfs_bio *bbio, int mirror_num, bool dev_
 		goto fail;
 
 	if (dev_replace) {
-		if (btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE && btrfs_is_zoned(fs_info)) {
-			bbio->bio.bi_opf &= ~REQ_OP_WRITE;
-			bbio->bio.bi_opf |= REQ_OP_ZONE_APPEND;
-		}
 		ASSERT(smap.dev == fs_info->dev_replace.srcdev);
 		smap.dev = fs_info->dev_replace.tgtdev;
 	}
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 8fce48d9e07a..28caad17ccc7 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1102,6 +1102,35 @@ static void scrub_write_endio(struct btrfs_bio *bbio)
 		wake_up(&stripe->io_wait);
 }
 
+static void scrub_submit_write_bio(struct scrub_ctx *sctx,
+				   struct scrub_stripe *stripe,
+				   struct btrfs_bio *bbio, bool dev_replace)
+{
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	u32 bio_len = bbio->bio.bi_iter.bi_size;
+	u32 bio_off = (bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT) -
+		      stripe->logical;
+
+	fill_writer_pointer_gap(sctx, stripe->physical + bio_off);
+	atomic_inc(&stripe->pending_io);
+	btrfs_submit_repair_write(bbio, stripe->mirror_num, dev_replace);
+	if (!btrfs_is_zoned(fs_info))
+		return;
+	/*
+	 * For zoned writeback, queue depth must be 1, thus we must wait for
+	 * the write to finish before the next write.
+	 */
+	wait_scrub_stripe_io(stripe);
+
+	/*
+	 * And also need to update the write pointer if write finished
+	 * successfully.
+	 */
+	if (!test_bit(bio_off >> fs_info->sectorsize_bits,
+		      &stripe->write_error_bitmap))
+		sctx->write_pointer += bio_len;
+}
+
 /*
  * Submit the write bio(s) for the sectors specified by @write_bitmap.
  *
@@ -1120,7 +1149,6 @@ static void scrub_write_sectors(struct scrub_ctx *sctx, struct scrub_stripe *str
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct btrfs_bio *bbio = NULL;
-	const bool zoned = btrfs_is_zoned(fs_info);
 	int sector_nr;
 
 	for_each_set_bit(sector_nr, &write_bitmap, stripe->nr_sectors) {
@@ -1133,13 +1161,7 @@ static void scrub_write_sectors(struct scrub_ctx *sctx, struct scrub_stripe *str
 
 		/* Cannot merge with previous sector, submit the current one. */
 		if (bbio && sector_nr && !test_bit(sector_nr - 1, &write_bitmap)) {
-			fill_writer_pointer_gap(sctx, stripe->physical +
-					(sector_nr << fs_info->sectorsize_bits));
-			atomic_inc(&stripe->pending_io);
-			btrfs_submit_repair_write(bbio, stripe->mirror_num, dev_replace);
-			/* For zoned writeback, queue depth must be 1. */
-			if (zoned)
-				wait_scrub_stripe_io(stripe);
+			scrub_submit_write_bio(sctx, stripe, bbio, dev_replace);
 			bbio = NULL;
 		}
 		if (!bbio) {
@@ -1152,14 +1174,8 @@ static void scrub_write_sectors(struct scrub_ctx *sctx, struct scrub_stripe *str
 		ret = bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
 		ASSERT(ret == fs_info->sectorsize);
 	}
-	if (bbio) {
-		fill_writer_pointer_gap(sctx, bbio->bio.bi_iter.bi_sector <<
-					SECTOR_SHIFT);
-		atomic_inc(&stripe->pending_io);
-		btrfs_submit_repair_write(bbio, stripe->mirror_num, dev_replace);
-		if (zoned)
-			wait_scrub_stripe_io(stripe);
-	}
+	if (bbio)
+		scrub_submit_write_bio(sctx, stripe, bbio, dev_replace);
 }
 
 /*
-- 
2.40.1

