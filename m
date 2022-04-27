Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9812051123F
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 09:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358718AbiD0HWe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 03:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358690AbiD0HWd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 03:22:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF865E770
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 00:19:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 358C41F746
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651043962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bka4SFCUY7w3XBZ3qlwItufGkcpVMFK6Yd5BleIA368=;
        b=RTlDGovh5qqgJQI4aREHDcgalheF6/8fy4dRxZnGxM0h1Xlh9wPs4PgCsig6tp3JXwG0BQ
        xPDFdK5XCc7ShBZ6dsPBQY6QKPJLXIZxNFw7hf253Guch84Xzqht/RCajhmbgjUDnlr664
        iU/cOO0ZyquOpDa7u+xAJhLFcoPTzbs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BAD313A39
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4H14EHnuaGIbJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:21 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC v2 05/12] btrfs: add a helper to queue a corrupted sector for read repair
Date:   Wed, 27 Apr 2022 15:18:51 +0800
Message-Id: <a136fe858afe9efd29c8caa98d82cb7439d89677.1651043617.git.wqu@suse.com>
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

The new helper, read_repair_bio_add_sector(), will grab the page and
page_offset, and queue the sector into
btrfs_read_repair_ctrl::read_bios for later usage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 107 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent_io.h |   6 +++
 2 files changed, 113 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6304f694c8d6..fbed78ffe8e1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2732,6 +2732,110 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 		btrfs_subpage_end_reader(fs_info, page, start, len);
 }
 
+static struct page *read_repair_get_sector(struct btrfs_read_repair_ctrl *ctrl,
+					   int sector_nr, unsigned int *pgoff)
+{
+	const struct btrfs_fs_info *fs_info = btrfs_sb(ctrl->inode->i_sb);
+	const u32 target_offset = sector_nr << fs_info->sectorsize_bits;
+	struct bvec_iter iter;
+	struct bio_vec bvec;
+	u32 offset = 0;
+
+	ASSERT(pgoff);
+	ASSERT((sector_nr << fs_info->sectorsize_bits) < ctrl->bio_size);
+
+	/*
+	 * This is definitely not effecient, but I don't have better way
+	 * to grab a specified bvec from a bio directly.
+	 */
+	__bio_for_each_segment(bvec, ctrl->failed_bio, iter,
+			       btrfs_bio(ctrl->failed_bio)->iter) {
+		if (target_offset - offset < bvec.bv_len) {
+			*pgoff = bvec.bv_offset + (target_offset - offset);
+			return bvec.bv_page;
+		}
+		offset += bvec.bv_len;
+	}
+	return NULL;
+}
+
+static void read_repair_end_bio(struct bio *bio)
+{
+	struct btrfs_read_repair_ctrl *ctrl = bio->bi_private;
+	const struct btrfs_fs_info *fs_info = btrfs_sb(ctrl->inode->i_sb);
+	struct bvec_iter_all iter_all;
+	struct bio_vec *bvec;
+	u64 logical = btrfs_bio(bio)->iter.bi_sector << SECTOR_SHIFT;
+	u32 offset = 0;
+	bool uptodate = (bio->bi_status == BLK_STS_OK);
+
+	/* We should not have csum in bbio */
+	ASSERT(!btrfs_bio(bio)->csum);
+	bio_for_each_segment_all(bvec, bio, iter_all) {
+		/*
+		 * If we have a successful read, clear the error bit.
+		 * In read_repair_finish(), we will re-check the csum
+		 * (if exists) later.
+		 */
+		if (uptodate)
+			clear_bit((logical + offset - ctrl->logical) >>
+				  fs_info->sectorsize_bits,
+				  ctrl->cur_bad_bitmap);
+		atomic_sub(bvec->bv_len, &ctrl->io_bytes);
+		wake_up(&ctrl->io_wait);
+		offset += bvec->bv_len;
+	}
+	bio_put(bio);
+}
+
+/* Add a sector into the read repair bios list for later submission */
+static void read_repair_bio_add_sector(struct btrfs_read_repair_ctrl *ctrl,
+				       int sector_nr)
+{
+	const struct btrfs_fs_info *fs_info = btrfs_sb(ctrl->inode->i_sb);
+	struct page *page;
+	int pgoff;
+	struct bio *bio;
+	int ret;
+
+	page = read_repair_get_sector(ctrl, sector_nr, &pgoff);
+	ASSERT(page);
+
+	/* Check if the sector can be added to the last bio */
+	if (!bio_list_empty(&ctrl->read_bios)) {
+		bio = ctrl->read_bios.tail;
+		if ((bio->bi_iter.bi_sector << SECTOR_SHIFT) + bio->bi_iter.bi_size ==
+		    ctrl->logical + (sector_nr << fs_info->sectorsize_bits))
+			goto add;
+	}
+	/*
+	 * Here we want to know the logical bytenr at endio time, so we can
+	 * update the bitmap.
+	 * Unfortunately our bi_private will be used, and bi_iter is not
+	 * reliable, thus we have to alloc btrfs_bio, even we just want
+	 * logical bytenr.
+	 */
+	bio = btrfs_bio_alloc(BIO_MAX_VECS);
+	/* It's backed by mempool, thus should not fail */
+	ASSERT(bio);
+
+	bio->bi_opf = REQ_OP_READ;
+	bio->bi_iter.bi_sector = ((sector_nr << fs_info->sectorsize_bits) +
+				  ctrl->logical) >> SECTOR_SHIFT;
+	bio->bi_private = ctrl;
+	bio->bi_end_io = read_repair_end_bio;
+	bio_list_add(&ctrl->read_bios, bio);
+
+add:
+	ret = bio_add_page(bio, page, fs_info->sectorsize, pgoff);
+	/*
+	 * We allocated the read bio with enough bvecs to contain
+	 * the original bio, thus it should not fail to add a sector.
+	 */
+	ASSERT(ret == fs_info->sectorsize);
+	atomic_add(fs_info->sectorsize, &ctrl->io_bytes);
+}
+
 static int read_repair_add_sector(struct inode *inode,
 				  struct btrfs_read_repair_ctrl *ctrl,
 				  struct bio *failed_bio, u32 bio_offset)
@@ -2762,6 +2866,9 @@ static int read_repair_add_sector(struct inode *inode,
 		ctrl->init_mirror = btrfs_bio(failed_bio)->mirror_num;
 		ctrl->num_copies = btrfs_num_copies(fs_info, ctrl->logical,
 						    sectorsize);
+		init_waitqueue_head(&ctrl->io_wait);
+		bio_list_init(&ctrl->read_bios);
+		atomic_set(&ctrl->io_bytes, 0);
 
 		ctrl->cur_bad_bitmap = bitmap_alloc(ctrl->bio_size >>
 					fs_info->sectorsize_bits, GFP_NOFS);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index eff008ba194f..4904229ee73a 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -121,6 +121,12 @@ struct btrfs_read_repair_ctrl {
 	 */
 	unsigned long *prev_bad_bitmap;
 
+	struct bio_list read_bios;
+
+	wait_queue_head_t io_wait;
+
+	atomic_t io_bytes;
+
 	/* The logical bytenr of the original bio. */
 	u64 logical;
 
-- 
2.36.0

