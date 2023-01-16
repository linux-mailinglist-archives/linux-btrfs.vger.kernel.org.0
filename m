Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC0966B7BF
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 08:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjAPHEz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Jan 2023 02:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjAPHEu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 02:04:50 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AAEB45D
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Jan 2023 23:04:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1F89534F24
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673852688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xqLkIffO0ozBSmeuWE9AwyAxn8xqG/Hgc02HkfVgp/A=;
        b=MhqW84RTXxOSGBFTKDg4lfNR3E8AGJO70LhqNruNWlWmN2Yt4MddiYdE/4c8MkJx9LtNFF
        0uGcsJx/dXwVHWDkqgN8HaVhTTpHxzNhLkF6qkJCjRbu5tXeYGVHMXbGFhULUiPQFTRMXZ
        2e1aMHT3L6Hm90YhBicrB8hZZwpE9IE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BB54138FA
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2JkwEg/3xGMfZwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:47 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/11] btrfs: scrub: introduce the repair functionality for scrub_stripe
Date:   Mon, 16 Jan 2023 15:04:19 +0800
Message-Id: <555d37edf0a3f9aca4a97b1148026806efbbccb1.1673851704.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673851704.git.wqu@suse.com>
References: <cover.1673851704.git.wqu@suse.com>
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

The new helper, scrub_repair_one_stripe(), would try to repair a
scrub_stripe.

The repair is done by:

- Submit read for all remaining stripes in one go

- Verification is done at the endio function to each read of the mirror

- Wait for all above read to finish

- Copy repaired sectors back to the original stripe
  And clear the current_error_bitmap bit for the original stripe.

- Check if we repaired all the sectors

This is a little different than the original repair behavior:

- We don't read the current mirror

  While the old behavior is to submit read concurrently for all mirrors,
  including the current bad mirror.

  I didn't see such retry had any meaning, thus only read for the
  remaining mirrors.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c   | 208 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/scrub.h   |   5 +-
 fs/btrfs/volumes.c |  10 ++-
 fs/btrfs/volumes.h |   2 +
 4 files changed, 216 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 656b5395adf5..92976310f899 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -24,6 +24,7 @@
 #include "accessors.h"
 #include "file-item.h"
 #include "scrub.h"
+#include "bio.h"
 
 /*
  * This is only the first step towards a full-features scrub. It reads all
@@ -367,8 +368,8 @@ static void free_scrub_stripe(struct scrub_stripe *stripe)
 	kfree(stripe);
 }
 
-struct scrub_stripe *alloc_scrub_stripe(struct btrfs_fs_info *fs_info,
-					struct btrfs_block_group *bg)
+static struct scrub_stripe *alloc_scrub_stripe(struct btrfs_fs_info *fs_info,
+					       struct btrfs_block_group *bg)
 {
 	struct scrub_stripe *stripe;
 	int ret;
@@ -408,11 +409,49 @@ struct scrub_stripe *alloc_scrub_stripe(struct btrfs_fs_info *fs_info,
 	return NULL;
 }
 
-void wait_scrub_stripe(struct scrub_stripe *stripe)
+static void wait_scrub_stripe(struct scrub_stripe *stripe)
 {
 	wait_event(stripe->io_wait, atomic_read(&stripe->pending_io) == 0);
 }
 
+/*
+ * Clones everything except the pages from @src.
+ *
+ * Used for repair path to read extra mirrors without re-doing the csum/extent
+ * tree search.
+ */
+static struct scrub_stripe *clone_scrub_stripe(struct btrfs_fs_info *fs_info,
+					       const struct scrub_stripe *src)
+{
+	struct scrub_stripe *dst;
+	int sector_nr;
+
+	dst = alloc_scrub_stripe(fs_info, src->bg);
+	if (!dst)
+		return NULL;
+	dst->logical = src->logical;
+	if (src->csums)
+		memcpy(dst->csums, src->csums,
+		       src->nr_sectors * fs_info->csum_size);
+	bitmap_copy(&dst->extent_sector_bitmap, &src->extent_sector_bitmap,
+		    src->nr_sectors);
+	for_each_set_bit(sector_nr, &src->extent_sector_bitmap, src->nr_sectors) {
+		dst->sectors[sector_nr].is_metadata =
+			src->sectors[sector_nr].is_metadata;
+		/* For meta, copy the generation number. */
+		if (src->sectors[sector_nr].is_metadata) {
+			dst->sectors[sector_nr].generation =
+				src->sectors[sector_nr].generation;
+			continue;
+		}
+		/* For data, only update csum pointer if there is data csum. */
+		if (src->sectors[sector_nr].csum)
+			dst->sectors[sector_nr].csum = dst->csums +
+				sector_nr * fs_info->csum_size;
+	}
+	return dst;
+}
+
 static struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx,
 					     struct btrfs_device *dev,
 					     u64 logical, u64 physical,
@@ -2323,7 +2362,7 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe,
 	}
 }
 
-void scrub_verify_one_stripe(struct scrub_stripe *stripe)
+static void scrub_verify_one_stripe(struct scrub_stripe *stripe)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	const unsigned int sectors_per_tree = fs_info->nodesize >>
@@ -2348,6 +2387,167 @@ void scrub_verify_one_stripe(struct scrub_stripe *stripe)
 		    stripe->nr_sectors);
 }
 
+static void scrub_read_endio(struct btrfs_bio *bbio)
+{
+	struct scrub_stripe *stripe = bbio->private;
+
+	if (bbio->bio.bi_status) {
+		bitmap_set(&stripe->io_error_bitmap, 0, stripe->nr_sectors);
+		bitmap_set(&stripe->init_error_bitmap, 0, stripe->nr_sectors);
+	}
+	bio_put(&bbio->bio);
+	scrub_verify_one_stripe(stripe);
+	if (atomic_dec_and_test(&stripe->pending_io))
+		wake_up(&stripe->io_wait);
+}
+
+static void scrub_submit_read_one_stripe(struct scrub_stripe *stripe)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	struct bio *bio;
+	int ret;
+	int i;
+
+	ASSERT(stripe->mirror_num >= 1);
+
+	ASSERT(atomic_read(&stripe->pending_io) == 0);
+	bio = btrfs_bio_alloc(BTRFS_STRIPE_LEN >> PAGE_SHIFT, REQ_OP_READ,
+			      scrub_read_endio, stripe);
+	/* Backed by mempool, should not fail. */
+	ASSERT(bio);
+
+	bio->bi_iter.bi_sector = stripe->logical >> SECTOR_SHIFT;
+
+	for (i = 0; i < BTRFS_STRIPE_LEN >> PAGE_SHIFT; i++) {
+		ret = bio_add_page(bio, stripe->pages[i], PAGE_SIZE, 0);
+		ASSERT(ret == PAGE_SIZE);
+	}
+	atomic_inc(&stripe->pending_io);
+	btrfs_submit_bio(fs_info, bio, stripe->mirror_num);
+}
+
+static int get_next_mirror(int mirror, int nr_copies)
+{
+	int ret = mirror + 1;
+
+	if (ret > nr_copies)
+		return ret - nr_copies;
+	return ret;
+}
+
+static void scrub_repair_from_mirror(struct scrub_stripe *orig,
+				     struct scrub_stripe *repair)
+{
+	struct btrfs_fs_info *fs_info = orig->bg->fs_info;
+	const int nr_sectors = orig->nr_sectors;
+	int sector_nr;
+
+	/* IO should have done for both stripes. */
+	ASSERT(atomic_read(&orig->pending_io) == 0);
+	ASSERT(atomic_read(&repair->pending_io) == 0);
+
+	for_each_set_bit(sector_nr, &orig->extent_sector_bitmap, nr_sectors) {
+		int page_index = (sector_nr << fs_info->sectorsize_bits) >>
+				 PAGE_SHIFT;
+		int pgoff = offset_in_page(sector_nr << fs_info->sectorsize_bits);
+
+		if (test_bit(sector_nr, &orig->current_error_bitmap) &&
+		    !test_bit(sector_nr, &repair->current_error_bitmap)) {
+
+			/* Copy the repaired content. */
+			memcpy_page(orig->pages[page_index], pgoff,
+				    repair->pages[page_index], pgoff,
+				    fs_info->sectorsize);
+			/*
+			 * And clear the bit in @current_error_bitmap, so
+			 * later we know we need to write this sector back.
+			 */
+			clear_bit(sector_nr, &orig->current_error_bitmap);
+		}
+	}
+}
+
+int scrub_repair_one_stripe(struct scrub_stripe *stripe)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	struct scrub_stripe **repair_stripes;
+	int nr_copies;
+	int ret = 0;
+	int i;
+
+	/*
+	 * The stripe should only have been verified once, thus its init and
+	 * current error bitmap should match.
+	 */
+	ASSERT(bitmap_equal(&stripe->current_error_bitmap,
+			    &stripe->init_error_bitmap, stripe->nr_sectors));
+
+	/* The stripe has no error from the beginning. */
+	if (bitmap_empty(&stripe->init_error_bitmap, stripe->nr_sectors))
+		return 0;
+
+	/*
+	 * If we're called for replace, the target device is just garbage,
+	 * no need to use it as an extra mirror.
+	 * If we're called for scrub, replace can not be executing at the same
+	 * time.
+	 *
+	 * Thus by all means, we don't want to use replace target at an extra
+	 * copy.
+	 */
+	nr_copies = btrfs_num_copies_no_extra_mirror(fs_info, stripe->logical,
+						     fs_info->sectorsize);
+	/*
+	 * No extra mirrors to go. Still return 0, as we didn't have errors
+	 * repairing the stripe.
+	 */
+	if (nr_copies == 1)
+		return 0;
+
+	repair_stripes = kcalloc(nr_copies - 1, sizeof(struct scrub_stripe *),
+				 GFP_KERNEL);
+	if (!repair_stripes)
+		return -ENOMEM;
+
+	/* Get all remaining stripes setup. */
+	for (i = 0; i < nr_copies - 1; i++) {
+		int next_mirror = get_next_mirror(i + stripe->mirror_num, nr_copies);
+
+		repair_stripes[i] = clone_scrub_stripe(fs_info, stripe);
+		if (!repair_stripes[i]) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		repair_stripes[i]->mirror_num = next_mirror;
+	}
+
+	/* Submit read for all remaining mirrors. */
+	for (i = 0; i < nr_copies - 1; i++)
+		scrub_submit_read_one_stripe(repair_stripes[i]);
+
+	/* Wait for all reads finish */
+	for (i = 0; i < nr_copies - 1; i++)
+		wait_scrub_stripe(repair_stripes[i]);
+
+	/* Repair from the remaining mirrors. */
+	for (i = 0; i < nr_copies - 1; i++) {
+		scrub_repair_from_mirror(stripe, repair_stripes[i]);
+
+		/* Already repaired all bad sectors. */
+		if (bitmap_empty(&stripe->current_error_bitmap,
+				 stripe->nr_sectors))
+			break;
+	}
+
+out:
+	for (i = 0; i < nr_copies - 1; i++) {
+		if (repair_stripes[i])
+			free_scrub_stripe(repair_stripes[i]);
+	}
+	kfree(repair_stripes);
+	return ret;
+}
+
 static int scrub_checksum_tree_block(struct scrub_block *sblock)
 {
 	struct scrub_ctx *sctx = sblock->sctx;
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index 73fa6744a6a7..fc732187db16 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -18,14 +18,11 @@ int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
  * static functions.
  */
 struct scrub_stripe;
-struct scrub_stripe *alloc_scrub_stripe(struct btrfs_fs_info *fs_info,
-					struct btrfs_block_group *bg);
-void wait_scrub_stripe(struct scrub_stripe *stripe);
 int scrub_find_fill_first_stripe(struct btrfs_root *extent_root,
 				 struct btrfs_root *csum_root,
 				 struct btrfs_block_group *bg,
 				 u64 logical_start, u64 logical_len,
 				 struct scrub_stripe *stripe);
-void scrub_verify_one_stripe(struct scrub_stripe *stripe);
+int scrub_repair_one_stripe(struct scrub_stripe *stripe);
 
 #endif
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bcfef75b97da..7bf572632e55 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5715,7 +5715,9 @@ void btrfs_mapping_tree_free(struct extent_map_tree *tree)
 	}
 }
 
-int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
+/* For call sites which don't want using replace target as an extra mirror. */
+int btrfs_num_copies_no_extra_mirror(struct btrfs_fs_info *fs_info, u64 logical,
+				     u64 len)
 {
 	struct extent_map *em;
 	struct map_lookup *map;
@@ -5750,6 +5752,12 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 		 */
 		ret = map->num_stripes;
 	free_extent_map(em);
+	return ret;
+}
+
+int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
+{
+	int ret = btrfs_num_copies_no_extra_mirror(fs_info, logical, len);
 
 	down_read(&fs_info->dev_replace.rwsem);
 	if (btrfs_dev_replace_is_ongoing(&fs_info->dev_replace) &&
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 6b7a05f6cf82..840beaee56f1 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -578,6 +578,8 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 		    struct block_device **bdev, fmode_t *mode);
 void __exit btrfs_cleanup_fs_uuids(void);
 int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len);
+int btrfs_num_copies_no_extra_mirror(struct btrfs_fs_info *fs_info, u64 logical,
+				     u64 len);
 int btrfs_grow_device(struct btrfs_trans_handle *trans,
 		      struct btrfs_device *device, u64 new_size);
 struct btrfs_device *btrfs_find_device(const struct btrfs_fs_devices *fs_devices,
-- 
2.39.0

