Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D6F61EC1C
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 08:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiKGHcy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Nov 2022 02:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiKGHcx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Nov 2022 02:32:53 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0B61A1
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Nov 2022 23:32:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B4B951F903
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 07:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667806370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05E6uBHw+Gk1Q4IkAio2QczlWvhIqPKBe17UMfYrSjA=;
        b=frk1bXU18LDuBXYQ+95/828maXz/L8/2khyVmkcXKBbSCpF2QsY5Yqiscmjj2B/ZwDFDb5
        g8yWZYUqRjLgsww46e6grITf/ED7ardH3jIHAChmVLnp7SZlWdA9a7hj0jDluu2KYkADSK
        Y/1sktxZcWPvuiVmg4DCjiwdWFuB/90=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0191813AC7
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 07:32:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AL7wLaG0aGMmDAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Nov 2022 07:32:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: raid56: introduce btrfs_raid_bio::error_bitmap
Date:   Mon,  7 Nov 2022 15:32:29 +0800
Message-Id: <aa54be41e66db516ddeb0ab3cc21e185b0b5aff3.1667805755.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1667805755.git.wqu@suse.com>
References: <cover.1667805755.git.wqu@suse.com>
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

Currently btrfs raid56 uses btrfs_raid_bio::faila and failb to indicate
which stripe(s) had IO errors.

But that has some problems:

- If one sector failed csum check, the whole stripe where the corruption
  is will be marked error.
  This can reduce the chance we do recover, like this:

          0  4K 8K
  Data 1  |XX|  |
  Data 2  |  |XX|
  Parity  |  |  |

  In above case, 0~4K in data 1 should be recovered using data 2 and
  parity, while 4K~8K in data 2 should be recovered using data 1 and
  parity.

  Currently if we trigger read on 0~4K of data 1, we will also recover
  4K~8K of data 1 using corrupted data 2 and parity, causing wrong
  result in rbio cache.

- Harder to expand for future M-N scheme
  As we're limited to just faila/b, two corruptions.

- Harder to expand to handle extra csum errors
  This can be problematic if we start to do csum verification.

This patch will introduce an extra @error_bitmap, where one bit
represent error has happened for that sector.

The choice to introduce a new error bitmap other than reusing
sector_ptr, is to avoid extra search between rbio::stripe_sectors[] and
rbio::bio_sectors[].

Since we can submit bio using sectors from both sectors, doing proper
search on both array will more complex.

Although the new bitmap will take extra memory, later we can remove
things like @error and @faila/b to save some memory.

Currently the new error bitmap and failab mechanism is co-existing,
the error bitmap is only updated at endio time and recover entrance.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 104 ++++++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/raid56.h |  11 +++++
 2 files changed, 108 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 143c115c977e..e5c630a0e8e9 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -76,6 +76,7 @@ static void scrub_rbio_work_locked(struct work_struct *work);
 
 static void free_raid_bio_pointers(struct btrfs_raid_bio *rbio)
 {
+	bitmap_free(rbio->error_bitmap);
 	kfree(rbio->stripe_pages);
 	kfree(rbio->bio_sectors);
 	kfree(rbio->stripe_sectors);
@@ -950,9 +951,10 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	rbio->stripe_sectors = kcalloc(num_sectors, sizeof(struct sector_ptr),
 				       GFP_NOFS);
 	rbio->finish_pointers = kcalloc(real_stripes, sizeof(void *), GFP_NOFS);
+	rbio->error_bitmap = bitmap_zalloc(num_sectors, GFP_NOFS);
 
 	if (!rbio->stripe_pages || !rbio->bio_sectors || !rbio->stripe_sectors ||
-	    !rbio->finish_pointers) {
+	    !rbio->finish_pointers || !rbio->error_bitmap) {
 		free_raid_bio_pointers(rbio);
 		kfree(rbio);
 		return ERR_PTR(-ENOMEM);
@@ -1044,8 +1046,11 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 	disk_start = stripe->physical + sector_nr * sectorsize;
 
 	/* if the device is missing, just fail this stripe */
-	if (!stripe->dev->bdev)
+	if (!stripe->dev->bdev) {
+		set_bit(stripe_nr * rbio->stripe_nsectors + sector_nr,
+			rbio->error_bitmap);
 		return fail_rbio_index(rbio, stripe_nr);
+	}
 
 	/* see if we can add this page onto our existing bio */
 	if (last) {
@@ -1209,6 +1214,7 @@ static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
 	 * write.
 	 */
 	atomic_set(&rbio->error, 0);
+	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
 	rbio->faila = -1;
 	rbio->failb = -1;
 
@@ -1332,6 +1338,43 @@ static int find_logical_bio_stripe(struct btrfs_raid_bio *rbio,
 	return -1;
 }
 
+static void set_rbio_range_error(struct btrfs_raid_bio *rbio,
+				  struct bio *bio)
+{
+	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
+	u32 offset = (bio->bi_iter.bi_sector << SECTOR_SHIFT) -
+		     rbio->bioc->raid_map[0];
+	int total_nr_sector = offset >> fs_info->sectorsize_bits;
+
+	ASSERT(total_nr_sector < rbio->nr_data * rbio->stripe_nsectors);
+
+	bitmap_set(rbio->error_bitmap, total_nr_sector,
+		   bio->bi_iter.bi_size >> fs_info->sectorsize_bits);
+
+	/*
+	 * Special handling for raid56_alloc_missing_rbio() used by
+	 * scrub/replace.
+	 * Unlike call path in raid56_parity_recover(), they pass an
+	 * empty bio here.
+	 * Thus we have to find out the missing device and mark the stripe
+	 * error instead.
+	 */
+	if (bio->bi_iter.bi_size == 0) {
+		bool found_missing = false;
+		int stripe_nr;
+
+		for (stripe_nr = 0; stripe_nr < rbio->real_stripes; stripe_nr++) {
+			if (!rbio->bioc->stripes[stripe_nr].dev->bdev) {
+				found_missing = true;
+				bitmap_set(rbio->error_bitmap,
+					   stripe_nr * rbio->stripe_nsectors,
+					   rbio->stripe_nsectors);
+			}
+		}
+		ASSERT(found_missing);
+	}
+}
+
 /*
  * returns -EIO if we had too many failures
  */
@@ -1423,13 +1466,50 @@ static void set_bio_pages_uptodate(struct btrfs_raid_bio *rbio, struct bio *bio)
 	}
 }
 
+static int get_bio_sector_nr(struct btrfs_raid_bio *rbio, struct bio *bio)
+{
+	struct bio_vec *bv = bio_first_bvec_all(bio);
+	int i;
+
+	for (i = 0; i < rbio->nr_sectors; i++) {
+		struct sector_ptr *sector;
+
+		sector = &rbio->stripe_sectors[i];
+		if (sector->page == bv->bv_page &&
+		    sector->pgoff == bv->bv_offset)
+			break;
+		sector = &rbio->bio_sectors[i];
+		if (sector->page == bv->bv_page &&
+		    sector->pgoff == bv->bv_offset)
+			break;
+	}
+	ASSERT(i < rbio->nr_sectors);
+	return i;
+}
+
+static void rbio_update_error_bitmap(struct btrfs_raid_bio *rbio,
+				     struct bio *bio)
+{
+	int total_sector_nr = get_bio_sector_nr(rbio, bio);
+	int bio_size = 0;
+	struct bio_vec *bvec;
+	struct bvec_iter_all iter_all;
+
+	bio_for_each_segment_all(bvec, bio, iter_all)
+		bio_size += bvec->bv_len;
+
+	bitmap_set(rbio->error_bitmap, total_sector_nr,
+		   bio_size >> rbio->bioc->fs_info->sectorsize_bits);
+}
+
 static void raid_wait_read_end_io(struct bio *bio)
 {
 	struct btrfs_raid_bio *rbio = bio->bi_private;
 
-	if (bio->bi_status)
+	if (bio->bi_status) {
 		fail_bio_stripe(rbio, bio);
-	else
+		rbio_update_error_bitmap(rbio, bio);
+	} else
 		set_bio_pages_uptodate(rbio, bio);
 
 	bio_put(bio);
@@ -1863,10 +1943,10 @@ static int recover_assemble_read_bios(struct btrfs_raid_bio *rbio,
 		struct sector_ptr *sector;
 
 		if (rbio->faila == stripe || rbio->failb == stripe) {
-			atomic_inc(&rbio->error);
 			/* Skip the current stripe. */
 			ASSERT(sectornr == 0);
 			total_sector_nr += rbio->stripe_nsectors - 1;
+			atomic_inc(&rbio->error);
 			continue;
 		}
 		sector = rbio_stripe_sector(rbio, stripe, sectornr);
@@ -1891,9 +1971,10 @@ static int recover_rbio(struct btrfs_raid_bio *rbio)
 
 	/*
 	 * Either we're doing recover for a read failure or degraded write,
-	 * caller should have set faila/b correctly.
+	 * caller should have set faila/b and error bitmap correctly.
 	 */
 	ASSERT(rbio->faila >= 0 || rbio->failb >= 0);
+	ASSERT(bitmap_weight(rbio->error_bitmap, rbio->nr_sectors));
 	bio_list_init(&bio_list);
 
 	/*
@@ -1978,6 +2059,8 @@ void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 	rbio->operation = BTRFS_RBIO_READ_REBUILD;
 	rbio_add_bio(rbio, bio);
 
+	set_rbio_range_error(rbio, bio);
+
 	rbio->faila = find_logical_bio_stripe(rbio, bio);
 	if (rbio->faila == -1) {
 		btrfs_warn(fs_info,
@@ -2038,8 +2121,10 @@ static void raid_wait_write_end_io(struct bio *bio)
 	struct btrfs_raid_bio *rbio = bio->bi_private;
 	blk_status_t err = bio->bi_status;
 
-	if (err)
+	if (err) {
 		fail_bio_stripe(rbio, bio);
+		rbio_update_error_bitmap(rbio, bio);
+	}
 	bio_put(bio);
 	atomic_dec(&rbio->stripes_pending);
 	wake_up(&rbio->io_wait);
@@ -2117,6 +2202,7 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
 	spin_unlock_irq(&rbio->bio_list_lock);
 
 	atomic_set(&rbio->error, 0);
+	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
 
 	index_rbio_pages(rbio);
 
@@ -2328,6 +2414,7 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio, int need_check)
 	}
 
 	atomic_set(&rbio->error, 0);
+	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
 
 	/* Map the parity stripe just once */
 	pointers[nr_data] = kmap_local_page(p_sector.page);
@@ -2533,6 +2620,8 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
 		goto cleanup;
 
 	atomic_set(&rbio->error, 0);
+	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
+
 	ret = scrub_assemble_read_bios(rbio, &bio_list);
 	if (ret < 0)
 		goto cleanup;
@@ -2612,6 +2701,7 @@ raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bioc)
 	 */
 	ASSERT(!bio->bi_iter.bi_size);
 
+	set_rbio_range_error(rbio, bio);
 	rbio->faila = find_logical_bio_stripe(rbio, bio);
 	if (rbio->faila == -1) {
 		btrfs_warn_rl(fs_info,
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 9fae97b7a2a5..e38da4fa76d6 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -126,6 +126,17 @@ struct btrfs_raid_bio {
 
 	/* Allocated with real_stripes-many pointers for finish_*() calls */
 	void **finish_pointers;
+
+	/*
+	 * The bitmap recording where IO errors happened.
+	 * Each bit is corresponding to one sector in either bio_sectors[] or
+	 * stripe_sectors[] array.
+	 *
+	 * The reason we don't use another bit in sector_ptr is, we have two
+	 * arrays of sectors, and a lot of IO can use sectors in both arrays.
+	 * Thus making it much harder to iterate.
+	 */
+	unsigned long *error_bitmap;
 };
 
 /*
-- 
2.38.1

