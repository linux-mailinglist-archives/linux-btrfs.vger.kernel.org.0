Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827A05FE95C
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 09:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJNHRo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 03:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJNHRk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 03:17:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5BB160EC0
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 00:17:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 56B0422013
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665731857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VIrj4ve6NmN8pYUbFzBoByE7YlLRarTxDOK46LptGhE=;
        b=UKz+RQIwR5O8MmRu67SeXuwNCTtltLcD5hJ06X7qLlJXShpF9BVIamcpuyGwXjU2YQG8p4
        xR15kLhfjOetKB3jDCj/FZ/47jtKYIkQZPOAmJR2ksdGDYCLdWVyKSVb9FYvcKsf+uliJr
        lTL+vABfn8b8aVU7Tw+x0ebKAQcEtjI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 96EA313451
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:17:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QIG5FhANSWOsUwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:17:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 5/5] btrfs: raid56: do full stripe data checksum verification before RMW
Date:   Fri, 14 Oct 2022 15:17:13 +0800
Message-Id: <9389bb7901990ef7c0d0c58dc4c1168fd4240d27.1665730948.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665730948.git.wqu@suse.com>
References: <cover.1665730948.git.wqu@suse.com>
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

- For raid56_rmw_stripe() we need to read the full stripe
  Unlike the old behavior, which will only read out the missing part,
  now we have to read out the full stripe (including data and P/Q), so
  we can do recovery later.

  All the read will directly go into the rbio stripe sectors.

  This will not affect cached case, as cached rbio will always has all
  its data sectors cached. And since cached sectors are already
  after a RMW (which implies the same data csum check), they should be
  always correct.

- Do data checksum verification for the full stripe
  The target is only the rbio stripe sectors.

  The checksum is already filled before we reach finish_rmw().
  Currently we only do the verification if there is no missing device.

  The checksum verification will do the following work:

  * Verify the data checksums for sectors which has data checksum of
    a vertical stripe.

    For sectors which doesn't has csum, they will be considered fine.

  * Check if we need to repair the vertical stripe

    If no checksum mismatch, we can continue to the next vertical
    stripe.
    If too many corrupted sectors than the tolerance, we error out,
    marking all the bios failed, to avoid further corruption.

  * Repair the vertical stripe

  * Recheck the content of the failed sectors

    If repaired sectors can not pass the checksum verification, we
    error out

This is a much strict workflow, meaning now we will not write a full
stripe if it can not pass full stripe data verification.

Obviously this will have a performance impact, as we are doing more
works during RMW cycle:

- Fetch the data checksum
- Do checksum verification for all data stripes
- Do recovery if needed
- Do checksum verification again

But for full stripe write we won't do it at all, thus for fully
optimized RAID56 workload (always full stripe write), there should be no
extra overhead.

To me, the extra overhead looks reasonable, as data consistency is way
more important than performance.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 279 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 251 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 8f7e25001a2b..e51c07bd4c7b 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1203,6 +1203,150 @@ static void bio_get_trace_info(struct btrfs_raid_bio *rbio, struct bio *bio,
 	trace_info->stripe_nr = -1;
 }
 
+static void assign_one_failed(int failed, int *faila, int *failb)
+{
+	if (*faila < 0)
+		*faila = failed;
+	else if (*failb < 0)
+		*failb = failed;
+}
+
+static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
+			    int extra_faila, int extra_failb,
+			    void **pointers, void **unmap_array);
+
+static int rmw_validate_data_csums(struct btrfs_raid_bio *rbio)
+{
+	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
+	int sector_nr;
+	int tolerance;
+	void **pointers = NULL;
+	void **unmap_array = NULL;
+	int ret = 0;
+
+	/* No checksum, no need to check. */
+	if (!rbio->csum_buf || !rbio->csum_bitmap)
+		return 0;
+
+	/* No datacsum in the range. */
+	if (bitmap_empty(rbio->csum_bitmap,
+			 rbio->nr_data * rbio->stripe_nsectors))
+		return 0;
+
+	pointers = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
+	unmap_array = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
+	if (!pointers || !unmap_array) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (rbio->bioc->map_type & BTRFS_BLOCK_GROUP_RAID5)
+		tolerance = 1;
+	else
+		tolerance = 2;
+
+	for (sector_nr = 0; sector_nr < rbio->stripe_nsectors; sector_nr++) {
+		int stripe_nr;
+		int found_error = 0;
+		int faila = -1;
+		int failb = -1;
+
+		/* Check the datacsum of this vertical stripe. */
+		for (stripe_nr = 0; stripe_nr < rbio->nr_data; stripe_nr++) {
+			struct sector_ptr *sector = rbio_stripe_sector(rbio,
+							stripe_nr, sector_nr);
+			int total_sector = stripe_nr * rbio->stripe_nsectors +
+					   sector_nr;
+			u8 *csum_expected = rbio->csum_buf + total_sector *
+							     fs_info->csum_size;
+			u8 csum[BTRFS_CSUM_SIZE];
+			int ret;
+
+			/*
+			 * No datacsum for this sector, by default consider
+			 * the sector correct.
+			 */
+			if (!test_bit(total_sector, rbio->csum_bitmap))
+				continue;
+
+			ret = btrfs_check_sector_csum(fs_info, sector->page,
+					sector->pgoff, csum, csum_expected);
+			if (ret < 0) {
+				assign_one_failed(stripe_nr, &faila, &failb);
+				found_error++;
+			}
+		}
+
+		/* No error found, everything is fine. */
+		if (found_error == 0)
+			continue;
+
+		/* Check if we can handle all the errors we found above. */
+		if (found_error + atomic_read(&rbio->error) > tolerance) {
+			btrfs_err_rl(fs_info,
+"full stripe %llu veritical stripe %d has too many corruptions, tolerance %d corruptions %d",
+				     rbio->bioc->raid_map[0], sector_nr,
+				     tolerance,
+				     found_error + atomic_read(&rbio->error));
+			ret = -EIO;
+			goto out;
+		}
+
+		/* Try recovery the corrupted sectors in the vertical stripe. */
+		ret = recover_vertical(rbio, sector_nr, faila, failb, pointers, unmap_array);
+		if (ret < 0) {
+			btrfs_err_rl(fs_info,
+			"failed to recovery full stripe %llu vertical stripe %d: %d",
+				     rbio->bioc->raid_map[0], sector_nr, ret);
+			goto out;
+		}
+
+		/* Recheck the failed sectors. */
+		found_error = 0;
+		for (stripe_nr = 0; stripe_nr < rbio->nr_data; stripe_nr++) {
+			struct sector_ptr *sector = rbio_stripe_sector(rbio,
+							stripe_nr, sector_nr);
+			int total_sector = stripe_nr * rbio->stripe_nsectors +
+					   sector_nr;
+			u8 *csum_expected = rbio->csum_buf + total_sector *
+							     fs_info->csum_size;
+			u8 csum[BTRFS_CSUM_SIZE];
+			int ret;
+
+			/*
+			 * No datacsum for this sector, by default consider
+			 * the sector correct.
+			 */
+			if (!test_bit(total_sector, rbio->csum_bitmap))
+				continue;
+
+			/* We only care about the failed sector. */
+			if (stripe_nr != faila && stripe_nr != failb)
+				continue;
+
+			ret = btrfs_check_sector_csum(fs_info, sector->page,
+					sector->pgoff, csum, csum_expected);
+			if (ret < 0)
+				found_error++;
+		}
+		/*
+		 * TODO: We may want to rollback to the old content. For now
+		 * we will error out, thus no big deal.
+		 */
+		if (found_error) {
+			ret = -EIO;
+			btrfs_err_rl(fs_info,
+	"full stripe %llu vertical stripe %d still has error after repair",
+				     rbio->bioc->raid_map[0], sector_nr);
+			goto out;
+		}
+	}
+out:
+	kfree(pointers);
+	kfree(unmap_array);
+	return ret;
+}
+
 /*
  * this is called from one of two situations.  We either
  * have a full stripe from the higher layers, or we've read all
@@ -1227,6 +1371,14 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 	struct bio *bio;
 	int ret;
 
+	ret = rmw_validate_data_csums(rbio);
+	if (ret < 0) {
+		btrfs_err_rl(bioc->fs_info,
+	"full stripe %llu already has corrupted data, abort RMW cycle for it",
+			     bioc->raid_map[0]);
+		goto cleanup;
+	}
+
 	bio_list_init(&bio_list);
 
 	if (rbio->real_stripes - rbio->nr_data == 1)
@@ -1583,6 +1735,7 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 	const int nr_data_sectors = rbio->stripe_nsectors * rbio->nr_data;
 	int ret;
 	int total_sector_nr;
+	bool need_read = false;
 	struct bio *bio;
 
 	bio_list_init(&bio_list);
@@ -1594,46 +1747,49 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 	index_rbio_pages(rbio);
 
 	atomic_set(&rbio->error, 0);
-	/* Build a list of bios to read all the missing data sectors. */
+
+	/* First check if we need to read anything from the disk. */
 	for (total_sector_nr = 0; total_sector_nr < nr_data_sectors;
 	     total_sector_nr++) {
-		struct sector_ptr *sector;
 		int stripe = total_sector_nr / rbio->stripe_nsectors;
 		int sectornr = total_sector_nr % rbio->stripe_nsectors;
+		struct sector_ptr *sector;
 
-		/*
-		 * We want to find all the sectors missing from the rbio and
-		 * read them from the disk.  If sector_in_rbio() finds a page
-		 * in the bio list we don't need to read it off the stripe.
-		 */
+		/* This sector is already covered by bio. */
 		sector = sector_in_rbio(rbio, stripe, sectornr, 1);
 		if (sector)
 			continue;
 
 		sector = rbio_stripe_sector(rbio, stripe, sectornr);
-		/*
-		 * The bio cache may have handed us an uptodate page.  If so,
-		 * use it.
-		 */
+		/* This sector is already covered by cached sector. */
 		if (sector->uptodate)
 			continue;
 
+		/*
+		 * Any sector not covered by bio nor cache means we need to
+		 * read out the full stripe for later full stripe verification.
+		 */
+		need_read = true;
+		break;
+	}
+	if (!need_read)
+		goto finish;
+
+	/* Build a list of all sectors (including data and P/Q) */
+	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
+	     total_sector_nr++) {
+		struct sector_ptr *sector;
+		int stripe = total_sector_nr / rbio->stripe_nsectors;
+		int sectornr = total_sector_nr % rbio->stripe_nsectors;
+
+		sector = rbio_stripe_sector(rbio, stripe, sectornr);
 		ret = rbio_add_io_sector(rbio, &bio_list, sector,
 			       stripe, sectornr, REQ_OP_READ);
 		if (ret)
 			goto cleanup;
 	}
 
-	bios_to_read = bio_list_size(&bio_list);
-	if (!bios_to_read) {
-		/*
-		 * this can happen if others have merged with
-		 * us, it means there is nothing left to read.
-		 * But if there are missing devices it may not be
-		 * safe to do the full stripe write yet.
-		 */
-		goto finish;
-	}
+	ASSERT(bio_list_size(&bio_list));
 
 	/*
 	 * The bioc may be freed once we submit the last bio. Make sure not to
@@ -1955,28 +2111,87 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 	bio_endio(bio);
 }
 
+/*
+ * We can have two sources of failab, one from rbio->faila/b, the other
+ * from @extra_faila/b (caused by data verification at RMW time).
+ *
+ * So we need to assign them proper using this helper.
+ *
+ * Return the total number of failed stripes (excluding the case where
+ * extra_faila/b is the same as rbio->failab)
+ */
+static int calculate_failab(struct btrfs_raid_bio *rbio,
+			    int extra_faila, int extra_failb,
+			    int *faila, int *failb)
+{
+	int failed = 0;
+
+	*faila = -1;
+	*failb = -1;
+
+	/* Check rbio fails first. */
+	if (rbio->faila >= 0) {
+		assign_one_failed(rbio->faila, faila, failb);
+		failed++;
+	}
+	if (rbio->failb >= 0) {
+		assign_one_failed(rbio->failb, faila, failb);
+		failed++;
+	}
+
+	/* Then the extra ones*/
+	if (extra_faila >= 0) {
+		assign_one_failed(extra_faila, faila, failb);
+		if (extra_faila != *faila && extra_faila != *failb)
+			failed++;
+	}
+	if (extra_failb >= 0) {
+		assign_one_failed(extra_failb, faila, failb);
+		if (extra_faila != *faila && extra_faila != *failb)
+			failed++;
+	}
+	return failed;
+}
+
 /*
  * Recover a vertical stripe specified by @sector_nr.
  * @*pointers are the pre-allocated pointers by the caller, so we don't
  * need to allocate/free the pointers again and again.
+ *
+ * @extra_faila and @extra_failb is for RMW data verification case, where
+ * we do scrub level check to find out the corrupted sectors in a vertical
+ * stripe.
  */
-static void recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
-			     void **pointers, void **unmap_array)
+static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
+			    int extra_faila, int extra_failb,
+			    void **pointers, void **unmap_array)
 {
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
 	struct sector_ptr *sector;
 	const u32 sectorsize = fs_info->sectorsize;
-	const int faila = rbio->faila;
-	const int failb = rbio->failb;
+	int faila = -1;
+	int failb = -1;
+	int failed = 0;
+	int tolerance;
 	int stripe_nr;
 
+	if (rbio->bioc->map_type & BTRFS_BLOCK_GROUP_RAID5)
+		tolerance = 1;
+	else
+		tolerance = 2;
+
+	failed = calculate_failab(rbio, extra_faila, extra_failb, &faila, &failb);
+
+	if (failed > tolerance)
+		return -EIO;
+
 	/*
 	 * Now we just use bitmap to mark the horizontal stripes in
 	 * which we have data when doing parity scrub.
 	 */
 	if (rbio->operation == BTRFS_RBIO_PARITY_SCRUB &&
 	    !test_bit(sector_nr, &rbio->dbitmap))
-		return;
+		return 0;
 
 	/*
 	 * Setup our array of pointers with sectors from each stripe
@@ -2074,6 +2289,7 @@ static void recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 cleanup:
 	for (stripe_nr = rbio->real_stripes - 1; stripe_nr >= 0; stripe_nr--)
 		kunmap_local(unmap_array[stripe_nr]);
+	return 0;
 }
 
 /*
@@ -2122,8 +2338,15 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 
 	index_rbio_pages(rbio);
 
-	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++)
-		recover_vertical(rbio, sectornr, pointers, unmap_array);
+	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
+		int ret;
+
+		ret = recover_vertical(rbio, sectornr, -1, -1, pointers, unmap_array);
+		if (ret < 0) {
+			err = BLK_STS_IOERR;
+			goto cleanup;
+		}
+	}
 
 	/*
 	 * No matter if this is a RMW or recovery, we should have all
-- 
2.37.3

