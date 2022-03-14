Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6848B4D7E29
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 10:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbiCNJJ3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 05:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237809AbiCNJJR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 05:09:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3B12654E
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 02:08:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2B2271F391
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647248886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cNaLYfPOCB6iQSMjN474bxT78RqrHDD+i3lmchDTOV4=;
        b=cZGMcHNQxa+2V968sXafkpR7e9fTBIMLVFYW8b+s+1rvRLKOWAB6X3wkTt/3Y6sFz3O2ZN
        hMPPaNfKzy8jWlH5X1/MmENFMSRSWfS8B60ie/0hzxmi2Ci50CFFEFzZlxhkgLahbVfJfU
        ZQ+E2TJAViaU9BJ6lhRMUn43q7fIiCI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D4DD13ADA
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:08:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KNwHEvUFL2IaYgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:08:05 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 15/18] btrfs: remove stripe boundary calculation for compressed IO
Date:   Mon, 14 Mar 2022 17:07:28 +0800
Message-Id: <b795c6746e3f9c953178fc30b2ee9e80025fa152.1647248613.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647248613.git.wqu@suse.com>
References: <cover.1647248613.git.wqu@suse.com>
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

For compressed IO, we calculate the next stripe start inside
alloc_compressed_bio().

Since now btrfs_map_bio() can handle bio split, we no longer need to
calculate the boundary any more.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 49 +++++-------------------------------------
 1 file changed, 5 insertions(+), 44 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index e9b0887c03a9..0bf694038c61 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -443,21 +443,15 @@ static blk_status_t submit_compressed_bio(struct btrfs_fs_info *fs_info,
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
 
@@ -474,14 +468,7 @@ static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_byte
 
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
@@ -508,7 +495,6 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	struct bio *bio = NULL;
 	struct compressed_bio *cb;
 	u64 cur_disk_bytenr = disk_start;
-	u64 next_stripe_start;
 	blk_status_t ret;
 	int skip_sum = inode->flags & BTRFS_INODE_NODATASUM;
 	const bool use_append = btrfs_use_zone_append(inode, disk_start);
@@ -542,28 +528,19 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
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
 
@@ -578,9 +555,6 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 			submit = true;
 
 		cur_disk_bytenr += added;
-		/* Reached stripe boundary */
-		if (cur_disk_bytenr == next_stripe_start)
-			submit = true;
 
 		/* Finished the range */
 		if (cur_disk_bytenr == disk_start + compressed_len)
@@ -800,7 +774,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	struct bio *comp_bio = NULL;
 	const u64 disk_bytenr = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 cur_disk_byte = disk_bytenr;
-	u64 next_stripe_start;
 	u64 file_offset;
 	u64 em_len;
 	u64 em_start;
@@ -887,27 +860,19 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
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
 
@@ -919,10 +884,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
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
2.35.1

