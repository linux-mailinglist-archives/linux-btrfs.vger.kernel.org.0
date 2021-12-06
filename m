Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E6A468F2D
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 03:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbhLFCdo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Dec 2021 21:33:44 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51894 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbhLFCdn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Dec 2021 21:33:43 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 456B91FD54
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 02:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638757815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FfzzaplRdzADfh5C67JmZThB8OL3fW3foCobHjbNNyA=;
        b=p55ZIx/javsmBQTo24yn54ZzAiwmfEVxRJX/fQ9I2P0YM2kffudUQF5GIeddRSKUqBdzcj
        PAo+AF6BBZ+wcj6194qYEVQlnigUFbA3Kjb4CftsE3wgZJ8zrnkwWTGYugqkJwYlJ+Bzyi
        3iOZ9lgdBa5AKtK2Jxh7kBFpmo3bWMM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9AA9A13451
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 02:30:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GMQZGbZ1rWFEMgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Dec 2021 02:30:14 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 15/17] btrfs: remove stripe boundary calculation for compressed IO
Date:   Mon,  6 Dec 2021 10:29:35 +0800
Message-Id: <20211206022937.26465-16-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206022937.26465-1-wqu@suse.com>
References: <20211206022937.26465-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For compressed IO, we calculate the next stripe start inside
alloc_compressed_bio().

Since now btrfs_map_bio() can handle bio split, we no longer need to
calculate the boundary any more.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 49 +++++-------------------------------------
 1 file changed, 5 insertions(+), 44 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 8b4b84b59b0c..70af7d3973b7 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -442,21 +442,15 @@ static blk_status_t submit_compressed_bio(struct btrfs_fs_info *fs_info,
  *                      from or written to.
  * @endio_func:         The endio function to call after the IO for compressed data
  *                      is finished.
- * @next_stripe_start:  Return value of logical bytenr of where next stripe starts.
- *                      Let the caller know to only fill the bio up to the stripe
- *                      boundary.
  */
 
 
 static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_bytenr,
-					unsigned int opf, bio_end_io_t endio_func,
-					u64 *next_stripe_start)
+					unsigned int opf, bio_end_io_t endio_func)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
-	struct btrfs_io_geometry geom;
 	struct extent_map *em;
 	struct bio *bio;
-	int ret;
 
 	bio = btrfs_bio_alloc(BIO_MAX_VECS);
 
@@ -473,14 +467,7 @@ static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_byte
 
 	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
 		bio_set_dev(bio, em->map_lookup->stripes[0].dev->bdev);
-
-	ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(bio), disk_bytenr, &geom);
 	free_extent_map(em);
-	if (ret < 0) {
-		bio_put(bio);
-		return ERR_PTR(ret);
-	}
-	*next_stripe_start = disk_bytenr + geom.len;
 
 	return bio;
 }
@@ -506,7 +493,6 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	struct bio *bio = NULL;
 	struct compressed_bio *cb;
 	u64 cur_disk_bytenr = disk_start;
-	u64 next_stripe_start;
 	blk_status_t ret;
 	int skip_sum = inode->flags & BTRFS_INODE_NODATASUM;
 	const bool use_append = btrfs_use_zone_append(inode, disk_start);
@@ -539,28 +525,19 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 		/* Allocate new bio if submitted or not yet allocated */
 		if (!bio) {
 			bio = alloc_compressed_bio(cb, cur_disk_bytenr,
-				bio_op | write_flags, end_compressed_bio_write,
-				&next_stripe_start);
+				bio_op | write_flags, end_compressed_bio_write);
 			if (IS_ERR(bio)) {
 				ret = errno_to_blk_status(PTR_ERR(bio));
 				bio = NULL;
 				goto finish_cb;
 			}
 		}
-		/*
-		 * We should never reach next_stripe_start start as we will
-		 * submit comp_bio when reach the boundary immediately.
-		 */
-		ASSERT(cur_disk_bytenr != next_stripe_start);
-
 		/*
 		 * We have various limits on the real read size:
-		 * - stripe boundary
 		 * - page boundary
 		 * - compressed length boundary
 		 */
-		real_size = min_t(u64, U32_MAX, next_stripe_start - cur_disk_bytenr);
-		real_size = min_t(u64, real_size, PAGE_SIZE - offset_in_page(offset));
+		real_size = min_t(u64, U32_MAX, PAGE_SIZE - offset_in_page(offset));
 		real_size = min_t(u64, real_size, compressed_len - offset);
 		ASSERT(IS_ALIGNED(real_size, fs_info->sectorsize));
 
@@ -575,9 +552,6 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 			submit = true;
 
 		cur_disk_bytenr += added;
-		/* Reached stripe boundary */
-		if (cur_disk_bytenr == next_stripe_start)
-			submit = true;
 
 		/* Finished the range */
 		if (cur_disk_bytenr == disk_start + compressed_len)
@@ -797,7 +771,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	struct bio *comp_bio = NULL;
 	const u64 disk_bytenr = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 cur_disk_byte = disk_bytenr;
-	u64 next_stripe_start;
 	u64 file_offset;
 	u64 em_len;
 	u64 em_start;
@@ -878,27 +851,19 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		/* Allocate new bio if submitted or not yet allocated */
 		if (!comp_bio) {
 			comp_bio = alloc_compressed_bio(cb, cur_disk_byte,
-					REQ_OP_READ, end_compressed_bio_read,
-					&next_stripe_start);
+					REQ_OP_READ, end_compressed_bio_read);
 			if (IS_ERR(comp_bio)) {
 				ret = errno_to_blk_status(PTR_ERR(comp_bio));
 				comp_bio = NULL;
 				goto finish_cb;
 			}
 		}
-		/*
-		 * We should never reach next_stripe_start start as we will
-		 * submit comp_bio when reach the boundary immediately.
-		 */
-		ASSERT(cur_disk_byte != next_stripe_start);
 		/*
 		 * We have various limit on the real read size:
-		 * - stripe boundary
 		 * - page boundary
 		 * - compressed length boundary
 		 */
-		real_size = min_t(u64, U32_MAX, next_stripe_start - cur_disk_byte);
-		real_size = min_t(u64, real_size, PAGE_SIZE - offset_in_page(offset));
+		real_size = min_t(u64, U32_MAX, PAGE_SIZE - offset_in_page(offset));
 		real_size = min_t(u64, real_size, compressed_len - offset);
 		ASSERT(IS_ALIGNED(real_size, fs_info->sectorsize));
 
@@ -910,10 +875,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		ASSERT(added == real_size);
 		cur_disk_byte += added;
 
-		/* Reached stripe boundary, need to submit */
-		if (cur_disk_byte == next_stripe_start)
-			submit = true;
-
 		/* Has finished the range, need to submit */
 		if (cur_disk_byte == disk_bytenr + compressed_len)
 			submit = true;
-- 
2.34.1

