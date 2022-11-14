Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B09E6273D7
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 01:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbiKNA1O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Nov 2022 19:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbiKNA1J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Nov 2022 19:27:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F03E00B
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 16:27:00 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D5A7D2008F
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 00:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668385618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uWuyMaEO7yBg5EPzdMpEOKs3L7Lhhk2bATX0A4a1KJs=;
        b=p1CPOI/ECsgCir3dnOkG7TmZ4PpU/NaIW3iBHE4ufH4MQrGsVAMv9pBqBGwxeDJcNQ7Jtd
        NyDYc168AycmoI0WhQldLlyZeeAVFi9ALQqbni3UHEqu0ci00Qju2rAEZjWxE0Bv7OktoE
        iz7xRMVnbkfZ8WzVnWyVZt/FDWXtm74=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28CCA13A18
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 00:26:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4PoFOFGLcWN9dAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 00:26:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs: raid56: do data csum verification during RMW cycle
Date:   Mon, 14 Nov 2022 08:26:34 +0800
Message-Id: <b4ccc08e1001268298a740b818a80aa7911aa76c.1668384746.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1668384746.git.wqu@suse.com>
References: <cover.1668384746.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
For the following small script, btrfs will be unable to recover the
content of file1:

  mkfs.btrfs -f -m raid1 -d raid5 -b 1G $dev1 $dev2 $dev3

  mount $dev1 $mnt
  xfs_io -f -c "pwrite -S 0xff 0 64k" -c sync $mnt/file1
  md5sum $mnt/file1
  umount $mnt

  # Corrupt the above 64K data stripe.
  xfs_io -f -c "pwrite -S 0x00 323026944 64K" -c sync $dev3
  mount $dev1 $mnt

  # Write a new 64K, which should be in the other data stripe
  # And this is a sub-stripe write, which will cause RMW
  xfs_io -f -c "pwrite 0 64k" -c sync $mnt/file2
  md5sum $mnt/file1
  umount $mnt

Above md5sum would fail.

[CAUSE]
There is a long existing problem for raid56 (not limited to btrfs
raid56) that, if we already have some corrupted on-disk data, and then
trigger a sub-stripe write (which needs RMW cycle), it can cause further
damage into P/Q stripe.

  Disk 1: data 1 |0x000000000000| <- Corrupted
  Disk 2: data 2 |0x000000000000|
  Disk 2: parity |0xffffffffffff|

In above case, data 1 is already corrupted, the original data should be
64KiB of 0xff.

At this stage, if we read data 1, and it has data checksum, we can still
recover going the regular RAID56 recovery path.

But if now we decide to write some data into data 2, then we need to go
RMW.
Just say we want to write 64KiB of '0x00' into data 2, then we read the
on-disk data of data 1, calculate the new parity, resulting the
following layout:

  Disk 1: data 1 |0x000000000000| <- Corrupted
  Disk 2: data 2 |0x000000000000| <- New '0x00' writes
  Disk 2: parity |0x000000000000| <- New Parity.

But the new parity is calculated using the *corrupted* data 1, we can
no longer recover the correct data of data1.
Thus the corruption is forever there.

[FIX]
To solve above problem, this patch will do a full stripe data checksum
verification at RMW time.

This involves the following changes:

- Always read the full stripe (including data/P/Q) when doing RMW
  Before we only read the missing data sectors, but since we may do a
  data csum verification and recovery, we need to read everything out.

  Please note that, if we have a cached rbio, we don't need to read
  anything, and can treat it the same as full stripe write.

  As only stripe with all its csum matches can be cached.

- Verifup the data csum during read.
  The target is only the rbio stripe sectors, and only if the rbio
  already has csum_buf/csum_bitmap filled.

  And sectors which can not pass csum verification will has its bit
  set in error_bitmap.

- Always call recovery_sectors() after we read out all the sectors
  Since error_bitmap will be updated during read, recover_sectors()
  can easily find out all the bad sectors and try to recover (if still
  under tolerance).

  And since recovery_sectors() is already migrated to use error_bitmap,
  it can skip vertical stripes which don't have any error.

- Verify the repaired sectors against its csum in recover_vertical()

- Rename rmw_read_and_wait() to rmw_read_wait_recover()
  Since we will always recover the sectors, the old name is no longer
  accurate.

  Furthermore since recovery is already done in rmw_read_wait_recover(),
  we no longer needs to call recovery_sectors() inside rmw_rbio().

Obviously this will have a performance impact, as we are doing more
works during RMW cycle:

- Fetch the data checksum
- Do checksum verification for all data stripes
- Do checksum verification again after repair

But for full stripe write or cached rbio we won't have the overhead all,
thus for fully optimized RAID56 workload (always full stripe write),
there should be no extra overhead.

To me, the extra overhead looks reasonable, as data consistency is way
more important than performance.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 169 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 137 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 242d3611d2dd..b7317e0cc616 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -21,6 +21,7 @@
 #include "raid56.h"
 #include "async-thread.h"
 #include "file-item.h"
+#include "btrfs_inode.h"
 
 /* set when additional merges to this rbio are not allowed */
 #define RBIO_RMW_LOCKED_BIT	1
@@ -1433,14 +1434,56 @@ static void rbio_update_error_bitmap(struct btrfs_raid_bio *rbio, struct bio *bi
 		   bio_size >> rbio->bioc->fs_info->sectorsize_bits);
 }
 
+/* Verify the data sectors at read time. */
+static void verify_bio_data_sectors(struct btrfs_raid_bio *rbio,
+				    struct bio *bio)
+{
+	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
+	int total_sector_nr = get_bio_sector_nr(rbio, bio);
+	struct bio_vec *bvec;
+	struct bvec_iter_all iter_all;
+
+	/* No data csum for the whole stripe, no need to verify. */
+	if (!rbio->csum_bitmap || !rbio->csum_buf)
+		return;
+
+	/* P/Q stripes, they have no data csum to verify against. */
+	if (total_sector_nr >= rbio->nr_data * rbio->stripe_nsectors)
+		return;
+
+	bio_for_each_segment_all(bvec, bio, iter_all) {
+		int bv_offset;
+
+		for (bv_offset = bvec->bv_offset;
+		     bv_offset < bvec->bv_offset + bvec->bv_len;
+		     bv_offset += fs_info->sectorsize, total_sector_nr++) {
+			u8 csum_buf[BTRFS_CSUM_SIZE];
+			u8 *expected_csum = rbio->csum_buf +
+					    total_sector_nr * fs_info->csum_size;
+			int ret;
+
+			/* No csum for this sector, skip to the next sector. */
+			if (!test_bit(total_sector_nr, rbio->csum_bitmap))
+				continue;
+
+			ret = btrfs_check_sector_csum(fs_info, bvec->bv_page,
+				bv_offset, csum_buf, expected_csum);
+			if (ret < 0)
+				set_bit(total_sector_nr, rbio->error_bitmap);
+		}
+	}
+}
+
 static void raid_wait_read_end_io(struct bio *bio)
 {
 	struct btrfs_raid_bio *rbio = bio->bi_private;
 
-	if (bio->bi_status)
+	if (bio->bi_status) {
 		rbio_update_error_bitmap(rbio, bio);
-	else
+	} else {
 		set_bio_pages_uptodate(rbio, bio);
+		verify_bio_data_sectors(rbio, bio);
+	}
 
 	bio_put(bio);
 	if (atomic_dec_and_test(&rbio->stripes_pending))
@@ -1469,37 +1512,25 @@ static void submit_read_bios(struct btrfs_raid_bio *rbio,
 static int rmw_assemble_read_bios(struct btrfs_raid_bio *rbio,
 				  struct bio_list *bio_list)
 {
-	const int nr_data_sectors = rbio->stripe_nsectors * rbio->nr_data;
 	struct bio *bio;
 	int total_sector_nr;
 	int ret = 0;
 
 	ASSERT(bio_list_size(bio_list) == 0);
 
-	/* Build a list of bios to read all the missing data sectors. */
-	for (total_sector_nr = 0; total_sector_nr < nr_data_sectors;
+	/*
+	 * Build a list of bios to read all sectors (including data and P/Q).
+	 *
+	 * This behaviro is to compensate the later csum verification and
+	 * recovery.
+	 */
+	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
 	     total_sector_nr++) {
 		struct sector_ptr *sector;
 		int stripe = total_sector_nr / rbio->stripe_nsectors;
 		int sectornr = total_sector_nr % rbio->stripe_nsectors;
 
-		/*
-		 * We want to find all the sectors missing from the rbio and
-		 * read them from the disk.  If sector_in_rbio() finds a page
-		 * in the bio list we don't need to read it off the stripe.
-		 */
-		sector = sector_in_rbio(rbio, stripe, sectornr, 1);
-		if (sector)
-			continue;
-
 		sector = rbio_stripe_sector(rbio, stripe, sectornr);
-		/*
-		 * The bio cache may have handed us an uptodate page.  If so,
-		 * use it.
-		 */
-		if (sector->uptodate)
-			continue;
-
 		ret = rbio_add_io_sector(rbio, bio_list, sector,
 			       stripe, sectornr, REQ_OP_READ);
 		if (ret)
@@ -1670,6 +1701,42 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 	bio_endio(bio);
 }
 
+static int verify_one_sector(struct btrfs_raid_bio *rbio,
+			     int stripe_nr, int sector_nr)
+{
+	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
+	struct sector_ptr *sector;
+	u8 csum_buf[BTRFS_CSUM_SIZE];
+	u8 *csum_expected;
+	int ret;
+
+	if (!rbio->csum_bitmap || !rbio->csum_buf)
+		return 0;
+
+	/* No way to verify P/Q as they are not covered by data csum. */
+	if (stripe_nr >= rbio->nr_data)
+		return 0;
+	/*
+	 * If we're rebuilding a read, we have to use pages from the
+	 * bio list if possible.
+	 */
+	if ((rbio->operation == BTRFS_RBIO_READ_REBUILD ||
+	     rbio->operation == BTRFS_RBIO_REBUILD_MISSING)) {
+		sector = sector_in_rbio(rbio, stripe_nr, sector_nr, 0);
+	} else {
+		sector = rbio_stripe_sector(rbio, stripe_nr, sector_nr);
+	}
+
+	ASSERT(sector->page);
+
+	csum_expected = rbio->csum_buf +
+			(stripe_nr * rbio->stripe_nsectors + sector_nr) *
+			fs_info->csum_size;
+	ret = btrfs_check_sector_csum(fs_info, sector->page, sector->pgoff,
+				      csum_buf, csum_expected);
+	return ret;
+}
+
 /*
  * Recover a vertical stripe specified by @sector_nr.
  * @*pointers are the pre-allocated pointers by the caller, so we don't
@@ -1685,6 +1752,7 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 	int faila;
 	int failb;
 	int stripe_nr;
+	int ret = 0;
 
 	/*
 	 * Now we just use bitmap to mark the horizontal stripes in
@@ -1805,12 +1873,23 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 	 * uptodate.
 	 * Especially if we determine to cache the rbio, we need to
 	 * have at least all data sectors uptodate.
+	 *
+	 * If possible, also check if the repaired sector matches its data
+	 * checksum.
 	 */
 	if (faila >= 0) {
+		ret = verify_one_sector(rbio, faila, sector_nr);
+		if (ret < 0)
+			goto cleanup;
+
 		sector = rbio_stripe_sector(rbio, faila, sector_nr);
 		sector->uptodate = 1;
 	}
 	if (failb >= 0) {
+		ret = verify_one_sector(rbio, faila, sector_nr);
+		if (ret < 0)
+			goto cleanup;
+
 		sector = rbio_stripe_sector(rbio, failb, sector_nr);
 		sector->uptodate = 1;
 	}
@@ -1818,7 +1897,7 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 cleanup:
 	for (stripe_nr = rbio->real_stripes - 1; stripe_nr >= 0; stripe_nr--)
 		kunmap_local(unmap_array[stripe_nr]);
-	return 0;
+	return ret;
 }
 
 static int recover_sectors(struct btrfs_raid_bio *rbio)
@@ -2115,7 +2194,7 @@ static void fill_data_csums(struct btrfs_raid_bio *rbio)
 	rbio->csum_bitmap = NULL;
 }
 
-static int rmw_read_and_wait(struct btrfs_raid_bio *rbio)
+static int rmw_read_wait_recover(struct btrfs_raid_bio *rbio)
 {
 	struct bio_list bio_list;
 	struct bio *bio;
@@ -2136,6 +2215,12 @@ static int rmw_read_and_wait(struct btrfs_raid_bio *rbio)
 
 	submit_read_bios(rbio, &bio_list);
 	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
+
+	/*
+	 * We may or may not have any corrupted sectors (including missing dev
+	 * and csum mismatch), just let recover_sectors() to handle them all.
+	 */
+	ret = recover_sectors(rbio);
 	return ret;
 out:
 	while ((bio = bio_list_pop(&bio_list)))
@@ -2175,6 +2260,28 @@ static void submit_write_bios(struct btrfs_raid_bio *rbio,
 	}
 }
 
+/*
+ * To determine if we need to read any sector from the disk.
+ * Should only be utilized in RMW path, to skip cached rbio.
+ */
+static bool need_read_stripe_sectors(struct btrfs_raid_bio *rbio)
+{
+	int i;
+
+	for (i = 0; i < rbio->nr_data * rbio->stripe_nsectors; i++) {
+		struct sector_ptr *sector = &rbio->stripe_sectors[i];
+
+		/*
+		 * We have a sector which doesn't have page nor uptodate,
+		 * thus this rbio can not be cached one, as cached one must
+		 * have all its data sectors present and uptodate.
+		 */
+		if (!sector->page || !sector->uptodate)
+			return true;
+	}
+	return false;
+}
+
 static int rmw_rbio(struct btrfs_raid_bio *rbio)
 {
 	struct bio_list bio_list;
@@ -2189,9 +2296,13 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
 	if (ret < 0)
 		return ret;
 
-	/* Full stripe write, can write the full stripe right now. */
-	if (rbio_is_full(rbio))
+	/*
+	 * Either full stripe write, or we have every data sector already
+	 * cached, can go to write path immediately.
+	 */
+	if (rbio_is_full(rbio) || !need_read_stripe_sectors(rbio))
 		goto write;
+
 	/*
 	 * Now we're doing sub-stripe write, also need all data stripes to do
 	 * the full RMW.
@@ -2202,16 +2313,10 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
 
 	index_rbio_pages(rbio);
 
-	ret = rmw_read_and_wait(rbio);
+	ret = rmw_read_wait_recover(rbio);
 	if (ret < 0)
 		return ret;
 
-	/* We have read errors, try recovery path. */
-	if (!bitmap_empty(rbio->error_bitmap, rbio->nr_sectors)) {
-		ret = recover_rbio(rbio);
-		if (ret < 0)
-			return ret;
-	}
 write:
 	/*
 	 * At this stage we're not allowed to add any new bios to the
-- 
2.38.1

