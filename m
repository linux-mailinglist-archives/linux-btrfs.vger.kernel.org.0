Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB663FA94A
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 07:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhH2F0M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 01:26:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59228 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbhH2F0I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 01:26:08 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 70D6B21D6B
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630214716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DYpmN1rQcvsVKjLJ4cSTPmym++WnBw6fje7yPHZlzqI=;
        b=inDeIkX+WzjMfMYl8AAQWN/LipY7zwxOvXPZQIvQhO2UQ14RkArR4Q9q/+D95JisPnRM0X
        6OjA3DF/TGg2txRPmgCVZD/ZVrxS1dJSEhKFaXtJhWdRldcbxl9ZCNm6HrTWO+EHI1bou6
        k9yXM+0mCnRJD0s2dkDCQix6qxF1QBg=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id AECC813964
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id kKgyHDsaK2HnPAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 12/26] btrfs: make btrfs_submit_compressed_read() to determine stripe boundary at bio allocation time
Date:   Sun, 29 Aug 2021 13:24:44 +0800
Message-Id: <20210829052458.15454-13-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829052458.15454-1-wqu@suse.com>
References: <20210829052458.15454-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs_submit_compressed_read() will check
btrfs_bio_fits_in_stripe() each time a new page is going to be added.

Even compressed extent is small, we don't really need to do that for
every page.

This patch will align the behavior to extent_io.c, by determining the
stripe boundary when allocating a bio.

Unlike extent_io.c, in compressed.c we don't need to bother things like
different bio flags, thus no need to re-use bio_ctrl.

Here we just manually introduce new local variable, next_stripe_start,
and teach alloc_compressed_bio() to calculate the stripe boundary.

Then each time we add some page range into the bio, we check if we
reached the boundary.
And if reached, submit it.

Also, since we have @cur_disk_byte to determine whether we're the last
bio, we don't need a explicit last_bio: tag for error handling any more.

And we can use @cur_disk_byte to track which range has been added to
bio, we can also use @cur_disk_byte to calculate the wait condition, no
need for @pending_bios.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 164 +++++++++++++++++++++++------------------
 1 file changed, 93 insertions(+), 71 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 7fdc9c131ac5..ac50972e4920 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -439,11 +439,18 @@ static blk_status_t submit_compressed_bio(struct btrfs_fs_info *fs_info,
 
 /*
  * To allocate a compressed_bio, which will be used to read/write on-disk data.
+ *
+ * @next_stripe_start:	Disk bytenr of next stripe start
  */
 static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_bytenr,
-					unsigned int opf, bio_end_io_t endio_func)
+					unsigned int opf, bio_end_io_t endio_func,
+					u64 *next_stripe_start)
 {
+	struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
+	struct btrfs_io_geometry geom;
+	struct extent_map *em;
 	struct bio *bio;
+	int ret;
 
 	bio = btrfs_bio_alloc(disk_bytenr);
 
@@ -451,18 +458,24 @@ static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_byte
 	bio->bi_private = cb;
 	bio->bi_end_io = endio_func;
 
-	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-		struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
-		struct btrfs_device *device;
+	em = btrfs_get_chunk_map(fs_info, disk_bytenr, fs_info->sectorsize);
+	if (IS_ERR(em)) {
+		bio_put(bio);
+		return ERR_CAST(em);
+	}
 
-		device = btrfs_zoned_get_device(fs_info, disk_bytenr,
-						fs_info->sectorsize);
-		if (IS_ERR(device)) {
-			bio_put(bio);
-			return ERR_CAST(device);
-		}
-		bio_set_dev(bio, device->bdev);
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
+		bio_set_dev(bio, em->map_lookup->stripes[0].dev->bdev);
+
+	ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(bio), disk_bytenr,
+				    &geom);
+	free_extent_map(em);
+	if (ret < 0) {
+		bio_put(bio);
+		return ERR_PTR(ret);
 	}
+	*next_stripe_start = disk_bytenr + geom.len;
+
 	return bio;
 }
 
@@ -490,6 +503,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	int pg_index = 0;
 	struct page *page;
 	u64 first_byte = disk_start;
+	u64 next_stripe_start;
 	blk_status_t ret;
 	int skip_sum = inode->flags & BTRFS_INODE_NODATASUM;
 	const bool use_append = btrfs_use_zone_append(inode, disk_start);
@@ -513,7 +527,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	cb->nr_pages = nr_pages;
 
 	bio = alloc_compressed_bio(cb, first_byte, bio_op | write_flags,
-				   end_compressed_bio_write);
+				   end_compressed_bio_write,
+				   &next_stripe_start);
 	if (IS_ERR(bio)) {
 		kfree(cb);
 		return errno_to_blk_status(PTR_ERR(bio));
@@ -562,7 +577,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 
 			bio = alloc_compressed_bio(cb, first_byte,
 					bio_op | write_flags,
-					end_compressed_bio_write);
+					end_compressed_bio_write,
+					&next_stripe_start);
 			if (IS_ERR(bio)) {
 				ret = errno_to_blk_status(PTR_ERR(bio));
 				bio = NULL;
@@ -795,9 +811,10 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	unsigned int compressed_len;
 	unsigned int nr_pages;
 	unsigned int pg_index;
-	struct page *page;
-	struct bio *comp_bio;
-	u64 cur_disk_byte = bio->bi_iter.bi_sector << 9;
+	struct bio *comp_bio = NULL;
+	const u64 disk_bytenr = bio->bi_iter.bi_sector << SECTOR_SHIFT;
+	u64 cur_disk_byte = disk_bytenr;
+	u64 next_stripe_start;
 	u64 file_offset;
 	u64 em_len;
 	u64 em_start;
@@ -866,39 +883,62 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	/* include any pages we added in add_ra-bio_pages */
 	cb->len = bio->bi_iter.bi_size;
 
-	comp_bio = alloc_compressed_bio(cb, cur_disk_byte, REQ_OP_READ,
-					end_compressed_bio_read);
-	if (IS_ERR(comp_bio)) {
-		ret = errno_to_blk_status(PTR_ERR(comp_bio));
-		comp_bio = NULL;
-		goto fail2;
-	}
-
-	for (pg_index = 0; pg_index < nr_pages; pg_index++) {
-		u32 pg_len = PAGE_SIZE;
-		int submit = 0;
+	while (cur_disk_byte < disk_bytenr + compressed_len) {
+		u64 offset = cur_disk_byte - disk_bytenr;
+		unsigned int index = offset >> PAGE_SHIFT;
+		unsigned int real_size;
+		unsigned int added;
+		struct page *page = cb->compressed_pages[index];
+		bool submit = false;
 
+		/* Allocate new bio if submitted or not yet allocated */
+		if (!comp_bio) {
+			comp_bio = alloc_compressed_bio(cb, cur_disk_byte,
+					REQ_OP_READ, end_compressed_bio_read,
+					&next_stripe_start);
+			if (IS_ERR(comp_bio)) {
+				ret = errno_to_blk_status(PTR_ERR(comp_bio));
+				comp_bio = NULL;
+				goto finish_cb;
+			}
+		}
 		/*
-		 * To handle subpage case, we need to make sure the bio only
-		 * covers the range we need.
-		 *
-		 * If we're at the last page, truncate the length to only cover
-		 * the remaining part.
+		 * We should never reach next_stripe_start start as we will
+		 * submit comp_bio when reach the boundary immediately.
+		 */
+		ASSERT(cur_disk_byte != next_stripe_start);
+		/*
+		 * We have various limit on the real read size:
+		 * - stripe boundary
+		 * - page boundary
+		 * - compressed length boundary
+		 */
+		real_size = min_t(u64, U32_MAX,
+				  next_stripe_start - cur_disk_byte);
+		real_size = min_t(u64, real_size,
+				  PAGE_SIZE - offset_in_page(offset));
+		real_size = min_t(u64, real_size,
+				  compressed_len - offset);
+		ASSERT(IS_ALIGNED(real_size, fs_info->sectorsize));
+
+		added = bio_add_page(comp_bio, page, real_size,
+				     offset_in_page(offset));
+		/*
+		 * Maximum compressed extent is smaller than bio size limit,
+		 * thus bio_add_page() should always success.
 		 */
-		if (pg_index == nr_pages - 1)
-			pg_len = min_t(u32, PAGE_SIZE,
-					compressed_len - pg_index * PAGE_SIZE);
+		ASSERT(added == real_size);
+		cur_disk_byte += added;
 
-		page = cb->compressed_pages[pg_index];
-		page->mapping = inode->i_mapping;
-		page->index = em_start >> PAGE_SHIFT;
+		/* Reached stripe boundary, need to submit */
+		if (cur_disk_byte == next_stripe_start)
+			submit = true;
 
-		if (comp_bio->bi_iter.bi_size)
-			submit = btrfs_bio_fits_in_stripe(page, pg_len,
-							  comp_bio, 0);
+		/* Has finished the range, need to submit */
+		if (cur_disk_byte == disk_bytenr + compressed_len)
+			submit = true;
 
-		page->mapping = NULL;
-		if (submit || bio_add_page(comp_bio, page, pg_len, 0) < pg_len) {
+		if (submit) {
 			unsigned int nr_sectors;
 
 			ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
@@ -909,32 +949,13 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 						  fs_info->sectorsize);
 			sums += fs_info->csum_size * nr_sectors;
 
-			ret = submit_compressed_bio(fs_info, cb, comp_bio, mirror_num);
+			ret = submit_compressed_bio(fs_info, cb, comp_bio,
+						    mirror_num);
 			if (ret)
 				goto finish_cb;
-
-			comp_bio = alloc_compressed_bio(cb, cur_disk_byte,
-					REQ_OP_READ,
-					end_compressed_bio_read);
-			if (IS_ERR(comp_bio)) {
-				ret = errno_to_blk_status(PTR_ERR(comp_bio));
-				comp_bio = NULL;
-				goto finish_cb;
-			}
-
-			bio_add_page(comp_bio, page, pg_len, 0);
+			comp_bio = NULL;
 		}
-		cur_disk_byte += pg_len;
 	}
-
-	ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
-	if (ret)
-		goto last_bio;
-
-	ret = submit_compressed_bio(fs_info, cb, comp_bio, mirror_num);
-	if (ret)
-		goto last_bio;
-
 	return 0;
 
 fail2:
@@ -949,17 +970,18 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 out:
 	free_extent_map(em);
 	return ret;
-last_bio:
-	comp_bio->bi_status = ret;
-	/* This is the last bio, endio functions will free @cb */
-	bio_endio(comp_bio);
-	return ret;
 finish_cb:
 	if (comp_bio) {
 		comp_bio->bi_status = ret;
 		bio_endio(comp_bio);
 	}
-	wait_var_event(cb, atomic_read(&cb->pending_bios) == 0);
+	/* All bytes of @cb is submitted, endio will free @cb */
+	if (cur_disk_byte == disk_bytenr + compressed_len)
+		return ret;
+
+	wait_var_event(cb, refcount_read(&cb->pending_sectors) ==
+			   (disk_bytenr + compressed_len - cur_disk_byte) >>
+			   fs_info->sectorsize_bits);
 	/*
 	 * Even with previous bio ended, we should still have io not yet
 	 * submitted, thus need to finish @cb manually.
-- 
2.32.0

