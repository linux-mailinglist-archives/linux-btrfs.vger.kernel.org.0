Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1444067F63F
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Jan 2023 09:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjA1IXm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Jan 2023 03:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbjA1IXl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Jan 2023 03:23:41 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47F73E63E
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Jan 2023 00:23:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9BBDC1FF0A
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Jan 2023 08:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674894217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8bGGSXhYNfecvp0nfrvNxacBN1c7QQ0dDBg9+Oenf0I=;
        b=dxtRp+pUdZm4Ufc7W/PBec1IqALICYK2DmnfAyVZN1w2tPlaaPm/Lac74guQv7Je24oQ2U
        711+byIDyaHDS1BpPcPvSmGHYoPX82CV6p/kgFEo2B9rfyrV+5XYbwbswIuI41tbxsWsWi
        NnH3ngAUfheWkseIjk3U7WhVQaG6VvE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE785139BD
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Jan 2023 08:23:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CKXtLYjb1GPqGwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Jan 2023 08:23:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: use a more space efficient way to represent the source of duplicated stripes
Date:   Sat, 28 Jan 2023 16:23:16 +0800
Message-Id: <cb272cf3526cd6271d5c472da974c4bc4662cafe.1674893735.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674893735.git.wqu@suse.com>
References: <cover.1674893735.git.wqu@suse.com>
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

For btrfs dev-replace, we have to duplicate writes to the source
device into the target device.

For non-RAID56, all writes into the same mapped ranges are sharing the
same content, thus they don't really need to bother anything.
(E.g. in btrfs_submit_bio() for non-RAID56 range we just submit the
 same write to all involved devices).

But for RAID56, all stripes contain different content, thus we must
have a clear mapping of which stripe is duplicated from which original
stripe.

Currently we use a complex way using tgtdev_map[] array, e.g:

 num_tgtdevs = 1
 tgtdev_map[0] = 0    <- Means stripes[0] is not involved in replace.
 tgtdev_map[1] = 3    <- Means stripes[1] is involved in replace,
			 and it's duplicated to stripes[3].
 tgtdev_map[2] = 0    <- Means stripes[2] is not involved in replace.

But this is wasting some space, and ignored one important thing for
dev-replace, there is at most ONE running replace.

Thus we can change it to a fixed array to represent the mapping:

 replace_nr_stripes = 1
 tgtdev_map[0] = 1    <- Means stripes[1] is involved in replace.
 tgtdev_map[1] = -1   <- Means the second slot is not used.
                         (Only DUP can use this slot, but they
                          don't really care)

By this we can save some space for large RAID56 chunks.

Thus the patch involves the following changes:

- Replace @num_tgtdevs and @tgtdev_map[] with @replace_nr_stripes
  and @replace_stripe_src[2]

  @num_tgtdevs is just renamed to @replace_nr_stripes.
  While the mapping is completely changed.

- Add extra ASSERT()s for RAID56 code

- Only add two more extra stripes for dev-replace cases.
  As we have a upper limit on how many dev-replace stripes we can have.

- Unify the behavior of handle_ops_on_dev_replace()
  Previously handle_ops_on_dev_replace() go two different paths for
  WRITE and GET_READ_MIRRORS.
  Now unify them by always go WRITE path first (with at most 2 replace
  stripes), then if we're doing GET_READ_MIRRORS and we have 2 extra
  stripes, just drop one stripe.

- Remove the @real_stripes argument from alloc_btrfs_io_context()
  As we don't need the old variable length array any more.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c  |  44 +++++++++---
 fs/btrfs/scrub.c   |   4 +-
 fs/btrfs/volumes.c | 170 ++++++++++++++++++++-------------------------
 fs/btrfs/volumes.h |  23 +++---
 4 files changed, 126 insertions(+), 115 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index d095c07a152d..093c8db5720b 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -912,7 +912,7 @@ static struct sector_ptr *sector_in_rbio(struct btrfs_raid_bio *rbio,
 static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 					 struct btrfs_io_context *bioc)
 {
-	const unsigned int real_stripes = bioc->num_stripes - bioc->num_tgtdevs;
+	const unsigned int real_stripes = bioc->num_stripes - bioc->replace_nr_stripes;
 	const unsigned int stripe_npages = BTRFS_STRIPE_LEN >> PAGE_SHIFT;
 	const unsigned int num_pages = stripe_npages * real_stripes;
 	const unsigned int stripe_nsectors =
@@ -1275,10 +1275,20 @@ static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
 			goto error;
 	}
 
-	if (likely(!rbio->bioc->num_tgtdevs))
+	if (likely(!rbio->bioc->replace_nr_stripes))
 		return 0;
 
-	/* Make a copy for the replace target device. */
+	/*
+	 * Make a copy for the replace target device.
+	 *
+	 * Thus the source stripe number (in replace_stripe_src[0])
+	 * should be valid.
+	 * And just in case, make sure the second slot is uninitialized
+	 * (-1), as there can only be one device being replace in RAID56.
+	 */
+	ASSERT(rbio->bioc->replace_stripe_src[0] >= 0);
+	ASSERT(rbio->bioc->replace_stripe_src[1] < 0);
+
 	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
 	     total_sector_nr++) {
 		struct sector_ptr *sector;
@@ -1286,7 +1296,12 @@ static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
 		stripe = total_sector_nr / rbio->stripe_nsectors;
 		sectornr = total_sector_nr % rbio->stripe_nsectors;
 
-		if (!rbio->bioc->tgtdev_map[stripe]) {
+		/*
+		 * For RAID56, there is only one device can be replaced,
+		 * and replace_stripe_src[0] indicates the stripe number
+		 * we need to copy from.
+		 */
+		if (stripe != rbio->bioc->replace_stripe_src[0]) {
 			/*
 			 * We can skip the whole stripe completely, note
 			 * total_sector_nr will be increased by one anyway.
@@ -1309,7 +1324,7 @@ static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
 		}
 
 		ret = rbio_add_io_sector(rbio, bio_list, sector,
-					 rbio->bioc->tgtdev_map[stripe],
+					 rbio->real_stripes,
 					 sectornr, REQ_OP_WRITE);
 		if (ret)
 			goto error;
@@ -2518,7 +2533,12 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio, int need_check)
 	else
 		BUG();
 
-	if (bioc->num_tgtdevs && bioc->tgtdev_map[rbio->scrubp]) {
+	/*
+	 * Replace is running and our P/Q stripe is being replace, then
+	 * we need to duplicated the final write to reaplce target.
+	 */
+	if (bioc->replace_nr_stripes &&
+	    bioc->replace_stripe_src[0] == rbio->scrubp) {
 		is_replace = 1;
 		bitmap_copy(pbitmap, &rbio->dbitmap, rbio->stripe_nsectors);
 	}
@@ -2620,13 +2640,21 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio, int need_check)
 	if (!is_replace)
 		goto submit_write;
 
+	/*
+	 * Replace is running and our parity stripe needs to be duplicated
+	 * to target device.
+	 * Checks we have valid source stripe number in the first slot,
+	 * and the second slot is unused.
+	 */
+	ASSERT(rbio->bioc->replace_stripe_src[0] >= 0);
+	ASSERT(rbio->bioc->replace_stripe_src[1] < 0);
 	for_each_set_bit(sectornr, pbitmap, rbio->stripe_nsectors) {
 		struct sector_ptr *sector;
 
 		sector = rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
 		ret = rbio_add_io_sector(rbio, &bio_list, sector,
-				       bioc->tgtdev_map[rbio->scrubp],
-				       sectornr, REQ_OP_WRITE);
+					 rbio->real_stripes,
+					 sectornr, REQ_OP_WRITE);
 		if (ret)
 			goto cleanup;
 	}
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 69c93ae333f6..4ef1611f46f1 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1230,7 +1230,7 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 			sblock_other = sblocks_for_recheck[mirror_index];
 		} else {
 			struct scrub_recover *r = sblock_bad->sectors[0]->recover;
-			int max_allowed = r->bioc->num_stripes - r->bioc->num_tgtdevs;
+			int max_allowed = r->bioc->num_stripes - r->bioc->replace_nr_stripes;
 
 			if (mirror_index >= max_allowed)
 				break;
@@ -1540,7 +1540,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 						      bioc->map_type,
 						      bioc->raid_map,
 						      bioc->num_stripes -
-						      bioc->num_tgtdevs,
+						      bioc->replace_nr_stripes,
 						      mirror_index,
 						      &stripe_index,
 						      &stripe_offset);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f00716fbb6cd..790511d2917e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5885,8 +5885,7 @@ static void sort_parity_stripes(struct btrfs_io_context *bioc, int num_stripes)
 }
 
 static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
-						       int total_stripes,
-						       int real_stripes)
+						       int total_stripes)
 {
 	struct btrfs_io_context *bioc;
 
@@ -5902,8 +5901,6 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
 		sizeof(struct btrfs_io_context) +
 		/* Plus the variable array for the stripes */
 		sizeof(struct btrfs_io_stripe) * (total_stripes) +
-		/* Plus the variable array for the tgt dev */
-		sizeof(u16) * (real_stripes) +
 		/*
 		 * Plus the raid_map, which includes both the tgt dev
 		 * and the stripes.
@@ -5917,8 +5914,9 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
 	refcount_set(&bioc->refs, 1);
 
 	bioc->fs_info = fs_info;
-	bioc->tgtdev_map = (u16 *)(bioc->stripes + total_stripes);
-	bioc->raid_map = (u64 *)(bioc->tgtdev_map + real_stripes);
+	bioc->raid_map = (u64 *)(bioc->stripes + total_stripes);
+	bioc->replace_stripe_src[0] = -1;
+	bioc->replace_stripe_src[1] = -1;
 
 	return bioc;
 }
@@ -6183,93 +6181,77 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 				      int *num_stripes_ret, int *max_errors_ret)
 {
 	u64 srcdev_devid = dev_replace->srcdev->devid;
-	int tgtdev_indexes = 0;
+	/*
+	 * At this stage, num_stripes is still the real number of stripes,
+	 * excluding the duplicated stripes.
+	 */
 	int num_stripes = *num_stripes_ret;
+	int nr_extra_stripes = 0;
 	int max_errors = *max_errors_ret;
 	int i;
 
-	if (op == BTRFS_MAP_WRITE) {
-		int index_where_to_add;
+	/*
+	 * A block group which have "to_copy" set will eventually
+	 * copied by dev-replace process. We can avoid cloning IO here.
+	 */
+	if (is_block_group_to_copy(dev_replace->srcdev->fs_info, logical))
+		return;
+
+	/*
+	 * duplicate the write operations while the dev replace
+	 * procedure is running. Since the copying of the old disk to
+	 * the new disk takes place at run time while the filesystem is
+	 * mounted writable, the regular write operations to the old
+	 * disk have to be duplicated to go to the new disk as well.
+	 *
+	 * Note that device->missing is handled by the caller, and that
+	 * the write to the old disk is already set up in the stripes
+	 * array.
+	 */
+	for (i = 0; i < num_stripes; i++) {
+		struct btrfs_io_stripe *old = &bioc->stripes[i];
+		struct btrfs_io_stripe *new = &bioc->stripes[
+						num_stripes + nr_extra_stripes];
+
+		if (old->dev->devid != srcdev_devid)
+			continue;
+
+		new->physical = old->physical;
+		new->dev = dev_replace->tgtdev;
+		bioc->replace_stripe_src[nr_extra_stripes] = i;
+		nr_extra_stripes++;
+	}
+
+	/* We can only have at most 2 extra nr_stripes (for DUP). */
+	ASSERT(nr_extra_stripes <= 2);
+	/*
+	 * For GET_READ_MIRRORS, we can only return at most 1 extra stripes for
+	 * replace.
+	 * If we have 2 extra stripes, only choose the one with smaller physical.
+	 */
+	if (op == BTRFS_MAP_GET_READ_MIRRORS && nr_extra_stripes == 2) {
+		struct btrfs_io_stripe *first = &bioc->stripes[num_stripes];
+		struct btrfs_io_stripe *second = &bioc->stripes[num_stripes + 1];
+
+		/* Only DUP can have two extra stripes. */
+		ASSERT(bioc->map_type & BTRFS_BLOCK_GROUP_DUP);
 
 		/*
-		 * A block group which have "to_copy" set will eventually
-		 * copied by dev-replace process. We can avoid cloning IO here.
+		 * Swap the last stripe stripes and just reduce
+		 * @nr_extra_stripes.
+		 * The extra stripe would still be there, but won't be
+		 * accessed.
 		 */
-		if (is_block_group_to_copy(dev_replace->srcdev->fs_info, logical))
-			return;
-
-		/*
-		 * duplicate the write operations while the dev replace
-		 * procedure is running. Since the copying of the old disk to
-		 * the new disk takes place at run time while the filesystem is
-		 * mounted writable, the regular write operations to the old
-		 * disk have to be duplicated to go to the new disk as well.
-		 *
-		 * Note that device->missing is handled by the caller, and that
-		 * the write to the old disk is already set up in the stripes
-		 * array.
-		 */
-		index_where_to_add = num_stripes;
-		for (i = 0; i < num_stripes; i++) {
-			if (bioc->stripes[i].dev->devid == srcdev_devid) {
-				/* write to new disk, too */
-				struct btrfs_io_stripe *new =
-					bioc->stripes + index_where_to_add;
-				struct btrfs_io_stripe *old =
-					bioc->stripes + i;
-
-				new->physical = old->physical;
-				new->dev = dev_replace->tgtdev;
-				bioc->tgtdev_map[i] = index_where_to_add;
-				index_where_to_add++;
-				max_errors++;
-				tgtdev_indexes++;
-			}
-		}
-		num_stripes = index_where_to_add;
-	} else if (op == BTRFS_MAP_GET_READ_MIRRORS) {
-		int index_srcdev = 0;
-		int found = 0;
-		u64 physical_of_found = 0;
-
-		/*
-		 * During the dev-replace procedure, the target drive can also
-		 * be used to read data in case it is needed to repair a corrupt
-		 * block elsewhere. This is possible if the requested area is
-		 * left of the left cursor. In this area, the target drive is a
-		 * full copy of the source drive.
-		 */
-		for (i = 0; i < num_stripes; i++) {
-			if (bioc->stripes[i].dev->devid == srcdev_devid) {
-				/*
-				 * In case of DUP, in order to keep it simple,
-				 * only add the mirror with the lowest physical
-				 * address
-				 */
-				if (found &&
-				    physical_of_found <= bioc->stripes[i].physical)
-					continue;
-				index_srcdev = i;
-				found = 1;
-				physical_of_found = bioc->stripes[i].physical;
-			}
-		}
-		if (found) {
-			struct btrfs_io_stripe *tgtdev_stripe =
-				bioc->stripes + num_stripes;
-
-			tgtdev_stripe->physical = physical_of_found;
-			tgtdev_stripe->dev = dev_replace->tgtdev;
-			bioc->tgtdev_map[index_srcdev] = num_stripes;
-
-			tgtdev_indexes++;
-			num_stripes++;
+		if (first->physical > second->physical) {
+			swap(second->physical, first->physical);
+			swap(second->dev, first->dev);
+			nr_extra_stripes--;
 		}
 	}
 
-	*num_stripes_ret = num_stripes;
-	*max_errors_ret = max_errors;
-	bioc->num_tgtdevs = tgtdev_indexes;
+	*num_stripes_ret = num_stripes + nr_extra_stripes;
+	*max_errors_ret = max_errors + nr_extra_stripes;
+	bioc->replace_nr_stripes = nr_extra_stripes;
 }
 
 static bool need_full_stripe(enum btrfs_map_op op)
@@ -6390,7 +6372,6 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	int mirror_num = (mirror_num_ret ? *mirror_num_ret : 0);
 	int num_stripes;
 	int max_errors = 0;
-	int tgtdev_indexes = 0;
 	struct btrfs_io_context *bioc = NULL;
 	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
 	int dev_replace_is_ongoing = 0;
@@ -6540,13 +6521,16 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	}
 
 	num_alloc_stripes = num_stripes;
-	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL) {
-		if (op == BTRFS_MAP_WRITE)
-			num_alloc_stripes <<= 1;
-		if (op == BTRFS_MAP_GET_READ_MIRRORS)
-			num_alloc_stripes++;
-		tgtdev_indexes = num_stripes;
-	}
+	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
+	    op != BTRFS_MAP_READ)
+		/*
+		 * For replace case, we need to add extra stripes for extra
+		 * duplicated stripes.
+		 *
+		 * For both WRITE and GET_READ_MIRRORS, we may have
+		 * at most 2 more stripes (DUP types, otherwise 1).
+		 */
+		num_alloc_stripes += 2;
 
 	/*
 	 * If this I/O maps to a single device, try to return the device and
@@ -6571,11 +6555,12 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		goto out;
 	}
 
-	bioc = alloc_btrfs_io_context(fs_info, num_alloc_stripes, tgtdev_indexes);
+	bioc = alloc_btrfs_io_context(fs_info, num_alloc_stripes);
 	if (!bioc) {
 		ret = -ENOMEM;
 		goto out;
 	}
+	bioc->map_type = map->type;
 
 	for (i = 0; i < num_stripes; i++) {
 		set_io_stripe(&bioc->stripes[i], map, stripe_index, stripe_offset,
@@ -6616,7 +6601,6 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	}
 
 	*bioc_ret = bioc;
-	bioc->map_type = map->type;
 	bioc->num_stripes = num_stripes;
 	bioc->max_errors = max_errors;
 	bioc->mirror_num = mirror_num;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index fe664512191b..7288fd476e40 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -438,14 +438,13 @@ struct btrfs_io_context {
 	/*
 	 * The following two members are for dev-replace case only.
 	 *
-	 * @num_tgtdevs:	Number of duplicated stripes which needs to be
+	 * @replace_nr_stripes:	Number of duplicated stripes which needs to be
 	 *			written to replace target.
 	 *			Should be <= 2 (2 for DUP, otherwise <= 1).
-	 * @tgtdev_map:		The array indicates where the duplicated stripes
-	 *			are from. The size is the number of original
-	 *			stripes (num_stripes - num_tgtdevs).
+	 * @replace_stripe_src:	The array indicates where the duplicated stripes
+	 *			are from.
 	 *
-	 * The @tgtdev_map[] array is mostly for RAID56 cases.
+	 * The @replace_stripe_src[] array is mostly for RAID56 cases.
 	 * As non-RAID56 stripes share the same contents for the mapped range,
 	 * thus no need to bother where the duplicated ones are from.
 	 *
@@ -459,14 +458,14 @@ struct btrfs_io_context {
 	 * stripes[2]:		dev = devid 3, physical = Z
 	 * stripes[3]:		dev = devid 0, physical = Y
 	 *
-	 * num_tgtdevs = 1
-	 * tgtdev_map[0] = 0	<- Means stripes[0] is not involved in replace.
-	 * tgtdev_map[1] = 3	<- Means stripes[1] is involved in replace,
-	 *			   and it's duplicated to stripes[3].
-	 * tgtdev_map[2] = 0	<- Means stripes[2] is not involved in replace.
+	 * replace_nr_stripes = 1
+	 * tgtdev_map[0] = 1	<- Means stripes[1] is involved in replace.
+	 * tgtdev_map[1] = -1	<- Means the second slot is not used.
+	 *			   (Only DUP can use this slot, but they
+	 *			    don't really care)
 	 */
-	u16 num_tgtdevs;
-	u16 *tgtdev_map;
+	u16 replace_nr_stripes;
+	s16 replace_stripe_src[2];
 	/*
 	 * logical block numbers for the start of each stripe
 	 * The last one or two are p/q.  These are sorted,
-- 
2.39.1

