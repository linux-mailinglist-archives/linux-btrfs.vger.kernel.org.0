Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE48458C2F8
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 07:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbiHHFqP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 01:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbiHHFqN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 01:46:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDFEE033
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Aug 2022 22:46:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0060534970
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 05:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659937570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C/h7G5S7hKe6jon4ySG8QInAUGSYf6COQ9+V/3gJsE0=;
        b=o2q1LdKbC0YLOLJMx6R8jHZHa71S0bKpzEc7yppFAV8NtVenmRROjyXYQRiR284lTwFcVw
        LuxylrQVv2bveatM7VbG07SiKAckVt7E6sdVnNxhovgwZvvzBfTB//3QITORJpGgFwxWsc
        ATVxyO6oxzsW5Ies7HV9wiRu65wu4zk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29B3A13523
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 05:46:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eHjzICCj8GJpfwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Aug 2022 05:46:08 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 6/7] btrfs: scrub: move logical/physical/dev/mirror_num from scrub_sector to scrub_block
Date:   Mon,  8 Aug 2022 13:45:42 +0800
Message-Id: <9d4eb63caafedac15d6696746ed0f7598f654174.1659936510.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1659936510.git.wqu@suse.com>
References: <cover.1659936510.git.wqu@suse.com>
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

Currently we store the following members in scrub_sector:

- logical
- physical
- physical_for_dev_replace
- dev
- mirror_num

However the current scrub code has ensured that scrub_blocks never cross
stripe boundary.
This is caused by the entrace functions (scrub_simple_mirror,
scrub_simple_stripe), thus every scrub_block will not cross stripe
boundary.

Thus this makes it possible to move those members into scrub_block other
than putting them into scrub_sector.

This should save quite some memory, as a scrub_block can be as large as 64
sectors, even for metadata it's 16 sectors byte default.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 164 ++++++++++++++++++++++++++---------------------
 1 file changed, 92 insertions(+), 72 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f359be9b42a7..6c5be7cf00d0 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -64,15 +64,11 @@ struct scrub_recover {
 
 struct scrub_sector {
 	struct scrub_block	*sblock;
-	struct btrfs_device	*dev;
 	struct list_head	list;
 	u64			flags;  /* extent flags */
 	u64			generation;
-	u64			logical;
-	u64			physical;
-	u64			physical_for_dev_replace;
+	u32			offset; /* offset in bytes to @sblock. */
 	atomic_t		refs;
-	u8			mirror_num;
 	unsigned int		have_csum:1;
 	unsigned int		io_error:1;
 	u8			csum[BTRFS_CSUM_SIZE];
@@ -101,9 +97,13 @@ struct scrub_block {
 	 */
 	struct page		*pages[SCRUB_MAX_PAGES];
 	struct scrub_sector	*sectors[SCRUB_MAX_SECTORS_PER_BLOCK];
+	struct btrfs_device	*dev;
 	u64			logical; /* Logical bytenr of the sblock */
+	u64			physical;
+	u64			physical_for_dev_replace;
 	u32			len; /* The length of sblock in bytes */
 	int			sector_count;
+	int			mirror_num;
 
 	atomic_t		outstanding_sectors;
 	refcount_t		refs; /* free mem on transition to zero */
@@ -250,7 +250,10 @@ static void detach_scrub_page_private(struct page *page)
 }
 
 static struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx,
-					     u64 logical)
+					     struct btrfs_device *dev,
+					     u64 logical, u64 physical,
+					     u64 physical_for_dev_replace,
+					     int mirror_num)
 {
 	struct scrub_block *sblock;
 
@@ -260,6 +263,10 @@ static struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx,
 	refcount_set(&sblock->refs, 1);
 	sblock->sctx = sctx;
 	sblock->logical = logical;
+	sblock->physical = physical;
+	sblock->physical_for_dev_replace = physical_for_dev_replace;
+	sblock->dev = dev;
+	sblock->mirror_num = mirror_num;
 	sblock->no_io_error_seen = 1;
 	/*
 	 * Scrub_block::pages will be allocated at alloc_scrub_sector() when
@@ -279,6 +286,9 @@ static struct scrub_sector *alloc_scrub_sector(struct scrub_block *sblock,
 	const int page_index = (logical - sblock->logical) >> PAGE_SHIFT;
 	struct scrub_sector *ssector;
 
+	/* We should never have scrub_block exceed U32_MAX in size.*/
+	ASSERT(logical - sblock->logical < U32_MAX);
+
 	ssector = kzalloc(sizeof(*ssector), gfp);
 	if (!ssector)
 		return NULL;
@@ -306,7 +316,7 @@ static struct scrub_sector *alloc_scrub_sector(struct scrub_block *sblock,
 	ssector->sblock = sblock;
 	/* This sector to be added should not be used */
 	ASSERT(sblock->sectors[sblock->sector_count] == NULL);
-	ssector->logical = logical;
+	ssector->offset = logical - sblock->logical;
 
 	/* And the sector count should be smaller than the limit */
 	ASSERT(sblock->sector_count < SCRUB_MAX_SECTORS_PER_BLOCK);
@@ -329,9 +339,9 @@ static struct page *scrub_sector_get_page(struct scrub_sector *ssector)
 	ASSERT(sblock);
 
 	/* The range should be inside the sblock range */
-	ASSERT(ssector->logical - sblock->logical < sblock->len);
+	ASSERT(ssector->offset < sblock->len);
 
-	index = (ssector->logical - sblock->logical) >> PAGE_SHIFT;
+	index = ssector->offset >> PAGE_SHIFT;
 	ASSERT(index < SCRUB_MAX_PAGES);
 	ASSERT(sblock->pages[index]);
 	ASSERT(PagePrivate(sblock->pages[index]));
@@ -348,9 +358,9 @@ static unsigned int scrub_sector_get_page_offset(struct scrub_sector *ssector)
 	ASSERT(sblock);
 
 	/* The range should be inside the sblock range */
-	ASSERT(ssector->logical - sblock->logical < sblock->len);
+	ASSERT(ssector->offset < sblock->len);
 
-	return offset_in_page(ssector->logical - sblock->logical);
+	return offset_in_page(ssector->offset);
 }
 
 static char *scrub_sector_get_kaddr(struct scrub_sector *ssector)
@@ -888,22 +898,22 @@ static void scrub_print_warning(const char *errstr, struct scrub_block *sblock)
 	int ret;
 
 	WARN_ON(sblock->sector_count < 1);
-	dev = sblock->sectors[0]->dev;
+	dev = sblock->dev;
 	fs_info = sblock->sctx->fs_info;
 
 	/* Super block error, no need to search extent tree. */
 	if (sblock->sectors[0]->flags & BTRFS_EXTENT_FLAG_SUPER) {
 		btrfs_warn_in_rcu(fs_info, "%s on device %s, physical %llu",
 			errstr, rcu_str_deref(dev->name),
-			sblock->sectors[0]->physical);
+			sblock->physical);
 		return;
 	}
 	path = btrfs_alloc_path();
 	if (!path)
 		return;
 
-	swarn.physical = sblock->sectors[0]->physical;
-	swarn.logical = sblock->sectors[0]->logical;
+	swarn.physical = sblock->physical;
+	swarn.logical = sblock->logical;
 	swarn.errstr = errstr;
 	swarn.dev = NULL;
 
@@ -973,7 +983,7 @@ static inline void scrub_put_recover(struct btrfs_fs_info *fs_info,
 static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 {
 	struct scrub_ctx *sctx = sblock_to_check->sctx;
-	struct btrfs_device *dev = sblock_to_check->sectors[0]->dev;
+	struct btrfs_device *dev = sblock_to_check->dev;
 	struct btrfs_fs_info *fs_info;
 	u64 logical;
 	unsigned int failed_mirror_index;
@@ -1006,9 +1016,9 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_CORRUPTION_ERRS);
 		return 0;
 	}
-	logical = sblock_to_check->sectors[0]->logical;
-	BUG_ON(sblock_to_check->sectors[0]->mirror_num < 1);
-	failed_mirror_index = sblock_to_check->sectors[0]->mirror_num - 1;
+	logical = sblock_to_check->logical;
+	ASSERT(sblock_to_check->mirror_num);
+	failed_mirror_index = sblock_to_check->mirror_num - 1;
 	is_metadata = !(sblock_to_check->sectors[0]->flags &
 			BTRFS_EXTENT_FLAG_DATA);
 	have_csum = sblock_to_check->sectors[0]->have_csum;
@@ -1081,9 +1091,13 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 		 *
 		 * But alloc_scrub_block() will initialize sblock::ref anyway,
 		 * so we can use scrub_block_put() to clean them up.
+		 *
+		 * And here we don't setup the physical/dev for the sblock yet,
+		 * they will be correctly initialized in
+		 * scrub_setup_recheck_block().
 		 */
-		sblocks_for_recheck[mirror_index] = alloc_scrub_block(sctx,
-								      logical);
+		sblocks_for_recheck[mirror_index] = alloc_scrub_block(sctx, NULL,
+							logical, 0, 0, mirror_index);
 		if (!sblocks_for_recheck[mirror_index]) {
 			spin_lock(&sctx->stat_lock);
 			sctx->stat.malloc_errors++;
@@ -1207,7 +1221,7 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 
 			ASSERT(failed_mirror_index == 0);
 			sblock_other = sblocks_for_recheck[1];
-			sblock_other->sectors[0]->mirror_num = 1 + mirror_index;
+			sblock_other->mirror_num = 1 + mirror_index;
 		}
 
 		/* build and submit the bios, check checksums */
@@ -1431,8 +1445,8 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 {
 	struct scrub_ctx *sctx = original_sblock->sctx;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	u64 logical = original_sblock->logical;
 	u64 length = original_sblock->sector_count << fs_info->sectorsize_bits;
-	u64 logical = original_sblock->sectors[0]->logical;
 	u64 generation = original_sblock->sectors[0]->generation;
 	u64 flags = original_sblock->sectors[0]->flags;
 	u64 have_csum = original_sblock->sectors[0]->have_csum;
@@ -1512,16 +1526,20 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 						      mirror_index,
 						      &stripe_index,
 						      &stripe_offset);
-			sector->physical = bioc->stripes[stripe_index].physical +
-					 stripe_offset;
-			sector->dev = bioc->stripes[stripe_index].dev;
+			/*
+			 * We're at the first sector, also populate @sblock
+			 * physical and dev.
+			 */
+			if (sector_index == 0) {
+				sblock->physical =
+					bioc->stripes[stripe_index].physical +
+					stripe_offset;
+				sblock->dev = bioc->stripes[stripe_index].dev;
+				sblock->physical_for_dev_replace =
+					original_sblock->physical_for_dev_replace;
+			}
 
 			BUG_ON(sector_index >= original_sblock->sector_count);
-			sector->physical_for_dev_replace =
-				original_sblock->sectors[sector_index]->
-				physical_for_dev_replace;
-			/* for missing devices, dev->bdev is NULL */
-			sector->mirror_num = mirror_index + 1;
 			scrub_get_recover(recover);
 			sector->recover = recover;
 		}
@@ -1545,11 +1563,12 @@ static int scrub_submit_raid56_bio_wait(struct btrfs_fs_info *fs_info,
 {
 	DECLARE_COMPLETION_ONSTACK(done);
 
-	bio->bi_iter.bi_sector = sector->logical >> 9;
+	bio->bi_iter.bi_sector = (sector->offset + sector->sblock->logical) >>
+				 SECTOR_SHIFT;
 	bio->bi_private = &done;
 	bio->bi_end_io = scrub_bio_wait_endio;
 	raid56_parity_recover(bio, sector->recover->bioc,
-			      sector->sblock->sectors[0]->mirror_num, false);
+			      sector->sblock->mirror_num, false);
 
 	wait_for_completion_io(&done);
 	return blk_status_to_errno(bio->bi_status);
@@ -1563,11 +1582,11 @@ static void scrub_recheck_block_on_raid56(struct btrfs_fs_info *fs_info,
 	int i;
 
 	/* All sectors in sblock belong to the same stripe on the same device. */
-	ASSERT(first_sector->dev);
-	if (!first_sector->dev->bdev)
+	ASSERT(sblock->dev);
+	if (!sblock->dev->bdev)
 		goto out;
 
-	bio = bio_alloc(first_sector->dev->bdev, BIO_MAX_VECS, REQ_OP_READ, GFP_NOFS);
+	bio = bio_alloc(sblock->dev->bdev, BIO_MAX_VECS, REQ_OP_READ, GFP_NOFS);
 
 	for (i = 0; i < sblock->sector_count; i++) {
 		struct scrub_sector *sector = sblock->sectors[i];
@@ -1616,15 +1635,16 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 		struct bio bio;
 		struct bio_vec bvec;
 
-		if (sector->dev->bdev == NULL) {
+		if (sblock->dev->bdev == NULL) {
 			sector->io_error = 1;
 			sblock->no_io_error_seen = 0;
 			continue;
 		}
 
-		bio_init(&bio, sector->dev->bdev, &bvec, 1, REQ_OP_READ);
+		bio_init(&bio, sblock->dev->bdev, &bvec, 1, REQ_OP_READ);
 		bio_add_scrub_sector(&bio, sector, fs_info->sectorsize);
-		bio.bi_iter.bi_sector = sector->physical >> 9;
+		bio.bi_iter.bi_sector = (sblock->physical + sector->offset) >>
+					SECTOR_SHIFT;
 
 		btrfsic_check_bio(&bio);
 		if (submit_bio_wait(&bio)) {
@@ -1641,7 +1661,7 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 
 static inline int scrub_check_fsid(u8 fsid[], struct scrub_sector *sector)
 {
-	struct btrfs_fs_devices *fs_devices = sector->dev->fs_devices;
+	struct btrfs_fs_devices *fs_devices = sector->sblock->dev->fs_devices;
 	int ret;
 
 	ret = memcmp(fsid, fs_devices->fsid, BTRFS_FSID_SIZE);
@@ -1693,14 +1713,15 @@ static int scrub_repair_sector_from_good_copy(struct scrub_block *sblock_bad,
 		struct bio_vec bvec;
 		int ret;
 
-		if (!sector_bad->dev->bdev) {
+		if (!sblock_bad->dev->bdev) {
 			btrfs_warn_rl(fs_info,
 				"scrub_repair_page_from_good_copy(bdev == NULL) is unexpected");
 			return -EIO;
 		}
 
-		bio_init(&bio, sector_bad->dev->bdev, &bvec, 1, REQ_OP_WRITE);
-		bio.bi_iter.bi_sector = sector_bad->physical >> 9;
+		bio_init(&bio, sblock_bad->dev->bdev, &bvec, 1, REQ_OP_WRITE);
+		bio.bi_iter.bi_sector = (sblock_bad->physical +
+					 sector_bad->offset) >> SECTOR_SHIFT;
 		ret = bio_add_scrub_sector(&bio, sector_good, sectorsize);
 
 		btrfsic_check_bio(&bio);
@@ -1708,7 +1729,7 @@ static int scrub_repair_sector_from_good_copy(struct scrub_block *sblock_bad,
 		bio_uninit(&bio);
 
 		if (ret) {
-			btrfs_dev_stat_inc_and_print(sector_bad->dev,
+			btrfs_dev_stat_inc_and_print(sblock_bad->dev,
 				BTRFS_DEV_STAT_WRITE_ERRS);
 			atomic64_inc(&fs_info->dev_replace.num_write_errors);
 			return -EIO;
@@ -1780,6 +1801,7 @@ static void scrub_block_get(struct scrub_block *sblock)
 static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
 				      struct scrub_sector *sector)
 {
+	struct scrub_block *sblock = sector->sblock;
 	struct scrub_bio *sbio;
 	int ret;
 	const u32 sectorsize = sctx->fs_info->sectorsize;
@@ -1798,14 +1820,16 @@ static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
 	}
 	sbio = sctx->wr_curr_bio;
 	if (sbio->sector_count == 0) {
-		ret = fill_writer_pointer_gap(sctx, sector->physical_for_dev_replace);
+		ret = fill_writer_pointer_gap(sctx, sector->offset +
+				sblock->physical_for_dev_replace);
 		if (ret) {
 			mutex_unlock(&sctx->wr_lock);
 			return ret;
 		}
 
-		sbio->physical = sector->physical_for_dev_replace;
-		sbio->logical = sector->logical;
+		sbio->physical = sblock->physical_for_dev_replace +
+				 sector->offset;
+		sbio->logical = sblock->logical + sector->offset;
 		sbio->dev = sctx->wr_tgtdev;
 		if (!sbio->bio) {
 			sbio->bio = bio_alloc(sbio->dev->bdev, sctx->sectors_per_bio,
@@ -1816,9 +1840,9 @@ static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
 		sbio->bio->bi_iter.bi_sector = sbio->physical >> 9;
 		sbio->status = 0;
 	} else if (sbio->physical + sbio->sector_count * sectorsize !=
-		   sector->physical_for_dev_replace ||
+		   sblock->physical_for_dev_replace + sector->offset ||
 		   sbio->logical + sbio->sector_count * sectorsize !=
-		   sector->logical) {
+		   sblock->logical + sector->offset) {
 		scrub_wr_submit(sctx);
 		goto again;
 	}
@@ -2013,7 +2037,7 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	 * a) don't have an extent buffer and
 	 * b) the page is already kmapped
 	 */
-	if (sector->logical != btrfs_stack_header_bytenr(h))
+	if (sblock->logical != btrfs_stack_header_bytenr(h))
 		sblock->header_error = 1;
 
 	if (sector->generation != btrfs_stack_header_generation(h)) {
@@ -2062,7 +2086,7 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 	kaddr = scrub_sector_get_kaddr(sector);
 	s = (struct btrfs_super_block *)kaddr;
 
-	if (sector->logical != btrfs_super_bytenr(s))
+	if (sblock->logical != btrfs_super_bytenr(s))
 		++fail_cor;
 
 	if (sector->generation != btrfs_super_generation(s))
@@ -2215,9 +2239,9 @@ static int scrub_add_sector_to_rd_bio(struct scrub_ctx *sctx,
 	}
 	sbio = sctx->bios[sctx->curr];
 	if (sbio->sector_count == 0) {
-		sbio->physical = sector->physical;
-		sbio->logical = sector->logical;
-		sbio->dev = sector->dev;
+		sbio->physical = sblock->physical + sector->offset;
+		sbio->logical = sblock->logical + sector->offset;
+		sbio->dev = sblock->dev;
 		if (!sbio->bio) {
 			sbio->bio = bio_alloc(sbio->dev->bdev, sctx->sectors_per_bio,
 					      REQ_OP_READ, GFP_NOFS);
@@ -2227,10 +2251,10 @@ static int scrub_add_sector_to_rd_bio(struct scrub_ctx *sctx,
 		sbio->bio->bi_iter.bi_sector = sbio->physical >> 9;
 		sbio->status = 0;
 	} else if (sbio->physical + sbio->sector_count * sectorsize !=
-		   sector->physical ||
+		   sblock->physical + sector->offset ||
 		   sbio->logical + sbio->sector_count * sectorsize !=
-		   sector->logical ||
-		   sbio->dev != sector->dev) {
+		   sblock->logical + sector->offset ||
+		   sbio->dev != sblock->dev) {
 		scrub_submit(sctx);
 		goto again;
 	}
@@ -2277,8 +2301,8 @@ static void scrub_missing_raid56_worker(struct work_struct *work)
 	u64 logical;
 	struct btrfs_device *dev;
 
-	logical = sblock->sectors[0]->logical;
-	dev = sblock->sectors[0]->dev;
+	logical = sblock->logical;
+	dev = sblock->dev;
 
 	if (sblock->no_io_error_seen)
 		scrub_recheck_block_checksum(sblock);
@@ -2316,7 +2340,7 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 	struct scrub_ctx *sctx = sblock->sctx;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	u64 length = sblock->sector_count << fs_info->sectorsize_bits;
-	u64 logical = sblock->sectors[0]->logical;
+	u64 logical = sblock->logical;
 	struct btrfs_io_context *bioc = NULL;
 	struct bio *bio;
 	struct btrfs_raid_bio *rbio;
@@ -2354,7 +2378,7 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 
 		raid56_add_scrub_pages(rbio, scrub_sector_get_page(sector),
 				       scrub_sector_get_page_offset(sector),
-				       sector->logical);
+				       sector->offset + sector->sblock->logical);
 	}
 
 	INIT_WORK(&sblock->work, scrub_missing_raid56_worker);
@@ -2382,7 +2406,8 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 	const u32 sectorsize = sctx->fs_info->sectorsize;
 	int index;
 
-	sblock = alloc_scrub_block(sctx, logical);
+	sblock = alloc_scrub_block(sctx, dev, logical, physical,
+				   physical_for_dev_replace, mirror_num);
 	if (!sblock) {
 		spin_lock(&sctx->stat_lock);
 		sctx->stat.malloc_errors++;
@@ -2407,12 +2432,8 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 			scrub_block_put(sblock);
 			return -ENOMEM;
 		}
-		sector->dev = dev;
 		sector->flags = flags;
 		sector->generation = gen;
-		sector->physical = physical;
-		sector->physical_for_dev_replace = physical_for_dev_replace;
-		sector->mirror_num = mirror_num;
 		if (csum) {
 			sector->have_csum = 1;
 			memcpy(sector->csum, csum, sctx->fs_info->csum_size);
@@ -2564,8 +2585,9 @@ static void scrub_block_complete(struct scrub_block *sblock)
 	}
 
 	if (sblock->sparity && corrupted && !sblock->data_corrected) {
-		u64 start = sblock->sectors[0]->logical;
-		u64 end = sblock->sectors[sblock->sector_count - 1]->logical +
+		u64 start = sblock->logical;
+		u64 end = sblock->logical +
+			  sblock->sectors[sblock->sector_count - 1]->offset +
 			  sblock->sctx->fs_info->sectorsize;
 
 		ASSERT(end - start <= U32_MAX);
@@ -2719,7 +2741,8 @@ static int scrub_sectors_for_parity(struct scrub_parity *sparity,
 
 	ASSERT(IS_ALIGNED(len, sectorsize));
 
-	sblock = alloc_scrub_block(sctx, logical);
+	sblock = alloc_scrub_block(sctx, dev, logical, physical, physical,
+				   mirror_num);
 	if (!sblock) {
 		spin_lock(&sctx->stat_lock);
 		sctx->stat.malloc_errors++;
@@ -2745,11 +2768,8 @@ static int scrub_sectors_for_parity(struct scrub_parity *sparity,
 		/* For scrub parity */
 		scrub_sector_get(sector);
 		list_add_tail(&sector->list, &sparity->sectors_list);
-		sector->dev = dev;
 		sector->flags = flags;
 		sector->generation = gen;
-		sector->physical = physical;
-		sector->mirror_num = mirror_num;
 		if (csum) {
 			sector->have_csum = 1;
 			memcpy(sector->csum, csum, sctx->fs_info->csum_size);
-- 
2.37.0

