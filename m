Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FD0511245
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 09:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358724AbiD0HWi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 03:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358719AbiD0HWf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 03:22:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2805F27D
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 00:19:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 84C82210E1
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651043964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dMHIuWleWwX1XyxoSNIY0wx5C73YfgKQD2rbDxKw+NY=;
        b=QedWkGx5MaXH8+62IGUxL2PSZCjDMuGSylIF3xXmQEC+XqhNziBVX2dmFr9vAWBaaMIhLS
        Dy66Rt5K0t+xSk7jgOkpU1/AjDD4nY734b7CN0jTbhzQDAtoavZBXlXJX75oMAfgUdYiJj
        LQTDOloNe4keiGohzIXI3LZKSlA+0ls=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB74C13A39
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uD3wI3vuaGIbJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC v2 07/12] btrfs: allow btrfs read repair to submit all writes in one go
Date:   Wed, 27 Apr 2022 15:18:53 +0800
Message-Id: <834bd7a42f6223794b0bafcbb55b4e167145d024.1651043618.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <cover.1651043617.git.wqu@suse.com>
References: <cover.1651043617.git.wqu@suse.com>
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

Currently if we want to submit write for read time repair, we call
repair_io_failure(), which will submit the bio and wait for it.

But for our newer btrfs_read_repair infrastructure , we want to submit
all write bios in one go, and then wait for all bios to finish, just
like how we handle the read bios.

This patch will get rid of the repair_io_failure() call, replacing it
with the same bios handling, by assembling all bios into a bio_list,
then submit them all and wait for them.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 116 +++++++++++++++++++++++++++----------------
 fs/btrfs/extent_io.h |   2 +-
 2 files changed, 75 insertions(+), 43 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7db6800cba31..bbdd8d1a966a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2795,20 +2795,28 @@ static void read_repair_end_bio(struct bio *bio)
 
 /* Add a sector into the read repair bios list for later submission */
 static void read_repair_bio_add_sector(struct btrfs_read_repair_ctrl *ctrl,
-				       int sector_nr)
+				       int sector_nr, unsigned int opf)
 {
-	const struct btrfs_fs_info *fs_info = btrfs_sb(ctrl->inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(ctrl->inode->i_sb);
 	struct page *page;
 	int pgoff;
 	struct bio *bio;
 	int ret;
 
+	ASSERT(opf == REQ_OP_WRITE || opf == REQ_OP_READ);
+
+	/* For write, we need to handle zoned case first */
+	if (opf == REQ_OP_WRITE) {
+		if (btrfs_repair_one_zone(fs_info, ctrl->logical))
+			return;
+	}
+
 	page = read_repair_get_sector(ctrl, sector_nr, &pgoff);
 	ASSERT(page);
 
 	/* Check if the sector can be added to the last bio */
-	if (!bio_list_empty(&ctrl->read_bios)) {
-		bio = ctrl->read_bios.tail;
+	if (!bio_list_empty(&ctrl->bios)) {
+		bio = ctrl->bios.tail;
 		if ((bio->bi_iter.bi_sector << SECTOR_SHIFT) + bio->bi_iter.bi_size ==
 		    ctrl->logical + (sector_nr << fs_info->sectorsize_bits))
 			goto add;
@@ -2824,12 +2832,12 @@ static void read_repair_bio_add_sector(struct btrfs_read_repair_ctrl *ctrl,
 	/* It's backed by mempool, thus should not fail */
 	ASSERT(bio);
 
-	bio->bi_opf = REQ_OP_READ;
+	bio->bi_opf = opf;
 	bio->bi_iter.bi_sector = ((sector_nr << fs_info->sectorsize_bits) +
 				  ctrl->logical) >> SECTOR_SHIFT;
 	bio->bi_private = ctrl;
 	bio->bi_end_io = read_repair_end_bio;
-	bio_list_add(&ctrl->read_bios, bio);
+	bio_list_add(&ctrl->bios, bio);
 
 add:
 	ret = bio_add_page(bio, page, fs_info->sectorsize, pgoff);
@@ -2841,19 +2849,57 @@ static void read_repair_bio_add_sector(struct btrfs_read_repair_ctrl *ctrl,
 	atomic_add(fs_info->sectorsize, &ctrl->io_bytes);
 }
 
+static void read_repair_submit_bio(struct btrfs_read_repair_ctrl *ctrl,
+				   struct bio *bio, int mirror)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(ctrl->inode->i_sb);
+	blk_status_t ret;
+
+	btrfs_bio(bio)->iter = bio->bi_iter;
+
+	/*
+	 * Zoned repair will be handled separately, thus we would only have
+	 * regular write or read bios here.
+	 */
+	ASSERT(bio_op(bio) == REQ_OP_WRITE || bio_op(bio) == REQ_OP_READ);
+	ASSERT(bio->bi_private == ctrl);
+	ASSERT(bio->bi_end_io == read_repair_end_bio);
+
+	/*
+	 * Avoid races with device replace and make sure our bioc has devices
+	 * associated to its stripes that don't go away while we are doing the
+	 * write operation.
+	 */
+	if (bio_op(bio) == REQ_OP_WRITE)
+		btrfs_bio_counter_inc_blocked(fs_info);
+
+	/*
+	 * Our endio is super atomic, and we don't want to waste time on
+	 * lookup data csum. So here we just call btrfs_map_bio()
+	 * directly.
+	 */
+	ret = btrfs_map_bio(fs_info, bio, mirror);
+
+	if (bio_op(bio) == REQ_OP_WRITE)
+		btrfs_bio_counter_dec(fs_info);
+
+	if (ret) {
+		bio->bi_status = ret;
+		bio_endio(bio);
+	}
+}
+
 static void read_repair_from_one_mirror(struct btrfs_read_repair_ctrl *ctrl,
 					struct inode *inode, int mirror)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	const int nbits = ctrl->bio_size >> fs_info->sectorsize_bits;
-	const u64 failed_logical = ctrl->failed_bio->bi_iter.bi_sector <<
-				   SECTOR_SHIFT;
 	const u32 sectorsize = fs_info->sectorsize;
 	struct bio *bio;
 	int bit;
 
 	/* We shouldn't have any pending read */
-	ASSERT(bio_list_size(&ctrl->read_bios) == 0 &&
+	ASSERT(bio_list_size(&ctrl->bios) == 0 &&
 	       atomic_read(&ctrl->io_bytes) == 0);
 
 	/*
@@ -2863,39 +2909,19 @@ static void read_repair_from_one_mirror(struct btrfs_read_repair_ctrl *ctrl,
 	 */
 	bitmap_copy(ctrl->prev_bad_bitmap, ctrl->cur_bad_bitmap, nbits);
 
-	/* Queue all bad sectors into our read_bios list */
+	/* Queue all bad sectors into our bios list */
 	for_each_set_bit(bit, ctrl->prev_bad_bitmap, nbits)
-		read_repair_bio_add_sector(ctrl, bit);
-
-	/* Submit all bios in read_bios and wait for them to finish */
-	for (bio = bio_list_pop(&ctrl->read_bios); bio;
-	     bio = bio_list_pop(&ctrl->read_bios)) {
-		blk_status_t ret;
+		read_repair_bio_add_sector(ctrl, bit, REQ_OP_READ);
 
-		btrfs_bio(bio)->iter = bio->bi_iter;
-
-		ASSERT(bio_op(bio) == REQ_OP_READ);
-		ASSERT(bio->bi_private == ctrl);
-		ASSERT(bio->bi_end_io == read_repair_end_bio);
-
-		/*
-		 * Our endio is super atomic, and we don't want to waste time on
-		 * lookup data csum. So here we just call btrfs_map_bio()
-		 * directly.
-		 */
-		ret = btrfs_map_bio(fs_info, bio, mirror);
-		if (ret) {
-			bio->bi_status = ret;
-			bio_endio(bio);
-		}
-	}
+	/* Submit all bios in bios list and wait for them to finish */
+	for (bio = bio_list_pop(&ctrl->bios); bio;
+	     bio = bio_list_pop(&ctrl->bios))
+		read_repair_submit_bio(ctrl, bio, mirror);
 	wait_event(ctrl->io_wait, atomic_read(&ctrl->io_bytes) == 0);
 
 	/* Now re-verify the newly read out data */
 	for_each_set_bit(bit, ctrl->prev_bad_bitmap, nbits) {
 		struct extent_state *cached = NULL;
-		const u64 logical = failed_logical +
-				    (bit << fs_info->sectorsize_bits);
 		const u64 file_offset = ctrl->file_offset +
 					(bit << fs_info->sectorsize_bits);
 		struct page *page;
@@ -2934,13 +2960,12 @@ static void read_repair_from_one_mirror(struct btrfs_read_repair_ctrl *ctrl,
 uptodate:
 		clear_bit(bit, ctrl->cur_bad_bitmap);
 		/*
-		 * We repaired one sector, write the correct data back
-		 * to the bad mirror. Note that this function do the
-		 * write synchronously, and can be optimized later.
+		 * We repaired one sector, queue this sector for later
+		 * writeback to recover the bad mirror.
+		 * Don't worry about zoned yet, it will be handled
+		 * in that function.
 		 */
-		repair_io_failure(fs_info, btrfs_ino(BTRFS_I(inode)),
-			file_offset, sectorsize, logical, page, pgoff,
-			get_prev_mirror(mirror, ctrl->num_copies));
+		read_repair_bio_add_sector(ctrl, bit, REQ_OP_WRITE);
 
 		/* Also update the page status */
 		end_page_read(page, true, file_offset, sectorsize);
@@ -2951,6 +2976,13 @@ static void read_repair_from_one_mirror(struct btrfs_read_repair_ctrl *ctrl,
 				file_offset, file_offset + sectorsize - 1,
 				&cached);
 	}
+
+	/* Submit and wait for all bios in the bios list */
+	for (bio = bio_list_pop(&ctrl->bios); bio;
+	     bio = bio_list_pop(&ctrl->bios))
+		read_repair_submit_bio(ctrl, bio,
+				get_prev_mirror(mirror, ctrl->num_copies));
+	wait_event(ctrl->io_wait, atomic_read(&ctrl->io_bytes) == 0);
 }
 
 static int read_repair_add_sector(struct inode *inode,
@@ -2984,7 +3016,7 @@ static int read_repair_add_sector(struct inode *inode,
 		ctrl->num_copies = btrfs_num_copies(fs_info, ctrl->logical,
 						    sectorsize);
 		init_waitqueue_head(&ctrl->io_wait);
-		bio_list_init(&ctrl->read_bios);
+		bio_list_init(&ctrl->bios);
 		atomic_set(&ctrl->io_bytes, 0);
 
 		ctrl->cur_bad_bitmap = bitmap_alloc(ctrl->bio_size >>
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 8b2ccbb2813e..e056ebc7ae01 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -122,7 +122,7 @@ struct btrfs_read_repair_ctrl {
 	 */
 	unsigned long *prev_bad_bitmap;
 
-	struct bio_list read_bios;
+	struct bio_list bios;
 
 	wait_queue_head_t io_wait;
 
-- 
2.36.0

