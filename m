Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B43535BC3
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 10:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349813AbiE0Inr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 04:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240856AbiE0Inp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 04:43:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9A04B421
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 01:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=C/d6+ung3MOjefm2dIiytyBUmOopj0MfgDrP/CBpcwU=; b=dwSJSVIn3I12gxUilfgDPM1bUB
        LQQQ956vimxF53sUj6V0ge9tYSkJsIuHBSyxU8xIgDZRSBx/IpCz7GMIWj0TtPNd7TjZ6u85x3Mbm
        4QGn16PoSu9Wh/9VHYrx6fNZX5QZHxMgG8liBPLy8CENRkO++X1az5JOs1+8+mbOGO98w3jsh07zX
        2Sv1CGV6PTRhcb8+8yGs+kB2hXICt3OPjjgmRRjykMeaJ3+7xgHUsvyGAg3Lk50eJYiNVwA+qLqbs
        LKMbBFtAXYWmZlwJaZZI4r0UY9oV+dnvA9cfdLcPUB2joxOgjBXUyM05YzHgaIPu/ICaQCH8lebtw
        a6ijLw/w==;
Received: from [2001:4bb8:18c:7298:b5ab:7d49:c6be:2011] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuVZM-00H3Yt-9h; Fri, 27 May 2022 08:43:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 7/9] btrfs: use the new read repair code for buffered reads
Date:   Fri, 27 May 2022 10:43:18 +0200
Message-Id: <20220527084320.2130831-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220527084320.2130831-1-hch@lst.de>
References: <20220527084320.2130831-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Start/end a repair session as needed in end_bio_extent_readpage and
submit_data_read_repair.  Unlike direct I/O, the buffered I/O handler
completes I/O on a per-sector basis and thus needs to pass an endio
handler to the repair code, which unlocks all pages and marks them
as either uptodate or not.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 76 ++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 27775031ed2d4..9d7835ba6d396 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -30,6 +30,7 @@
 #include "zoned.h"
 #include "block-group.h"
 #include "compression.h"
+#include "read-repair.h"
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
@@ -2683,14 +2684,29 @@ static void end_sector_io(struct page *page, u64 offset, bool uptodate)
 				    offset + sectorsize - 1, &cached);
 }
 
+static void end_read_repair(struct btrfs_bio *repair_bbio, struct inode *inode,
+		bool uptodate)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct bvec_iter iter;
+	struct bio_vec bv;
+	u32 offset;
+
+	btrfs_bio_for_each_sector(fs_info, bv, repair_bbio, iter, offset)
+		end_sector_io(bv.bv_page, repair_bbio->file_offset + offset,
+				uptodate);
+}
+
 static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
 				    u32 bio_offset, const struct bio_vec *bvec,
-				    int failed_mirror, unsigned int error_bitmap)
+				    int failed_mirror,
+				    unsigned int error_bitmap,
+				    struct btrfs_read_repair *rr)
 {
-	const unsigned int pgoff = bvec->bv_offset;
+	struct btrfs_bio *failed_bbio = btrfs_bio(failed_bio);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	u64 start = page_offset(bvec->bv_page) + bvec->bv_offset;
 	struct page *page = bvec->bv_page;
-	const u64 start = page_offset(bvec->bv_page) + bvec->bv_offset;
 	const u64 end = start + bvec->bv_len - 1;
 	const u32 sectorsize = fs_info->sectorsize;
 	const int nr_bits = (end + 1 - start) >> fs_info->sectorsize_bits;
@@ -2712,38 +2728,17 @@ static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
 
 	/* Iterate through all the sectors in the range */
 	for (i = 0; i < nr_bits; i++) {
-		const unsigned int offset = i * sectorsize;
-		bool uptodate = false;
-		int ret;
-
-		if (!(error_bitmap & (1U << i))) {
-			/*
-			 * This sector has no error, just end the page read
-			 * and unlock the range.
-			 */
-			uptodate = true;
-			goto next;
+		bool uptodate = !(error_bitmap & (1U << i));
+
+		if (uptodate ||
+		    !btrfs_read_repair_add(rr, failed_bbio, inode,
+		    		bio_offset)) {
+			btrfs_read_repair_finish(rr, failed_bbio, inode,
+					bio_offset, end_read_repair);
+			end_sector_io(page, start, uptodate);
 		}
-
-		ret = btrfs_repair_one_sector(inode, failed_bio,
-				bio_offset + offset,
-				page, pgoff + offset, start + offset,
-				failed_mirror, btrfs_submit_data_read_bio);
-		if (!ret) {
-			/*
-			 * We have submitted the read repair, the page release
-			 * will be handled by the endio function of the
-			 * submitted repair bio.
-			 * Thus we don't need to do any thing here.
-			 */
-			continue;
-		}
-		/*
-		 * Continue on failed repair, otherwise the remaining sectors
-		 * will not be properly unlocked.
-		 */
-next:
-		end_sector_io(page, start + offset, uptodate);
+		bio_offset += sectorsize;
+		start += sectorsize;
 	}
 }
 
@@ -2954,8 +2949,6 @@ static void end_bio_extent_readpage(struct bio *bio)
 	struct bio_vec *bvec;
 	struct btrfs_bio *bbio = btrfs_bio(bio);
 	int mirror = bbio->mirror_num;
-	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
-	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
 	bool uptodate = !bio->bi_status;
 	struct processed_extent processed = { 0 };
 	/*
@@ -2964,6 +2957,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 	 */
 	u32 bio_offset = 0;
 	struct bvec_iter_all iter_all;
+	struct btrfs_read_repair rr = { };
 
 	btrfs_bio(bio)->file_offset =
 		page_offset(first_vec->bv_page) + first_vec->bv_offset;
@@ -3020,10 +3014,6 @@ static void end_bio_extent_readpage(struct bio *bio)
 			loff_t i_size = i_size_read(inode);
 			pgoff_t end_index = i_size >> PAGE_SHIFT;
 
-			clean_io_failure(BTRFS_I(inode)->root->fs_info,
-					 failure_tree, tree, start, page,
-					 btrfs_ino(BTRFS_I(inode)), 0);
-
 			/*
 			 * Zero out the remaining part if this range straddles
 			 * i_size.
@@ -3063,9 +3053,11 @@ static void end_bio_extent_readpage(struct bio *bio)
 			 * and bad sectors, we just continue to the next bvec.
 			 */
 			submit_data_read_repair(inode, bio, bio_offset, bvec,
-						mirror, error_bitmap);
+						mirror, error_bitmap, &rr);
 		} else {
 			/* Update page status and unlock */
+			btrfs_read_repair_finish(&rr, btrfs_bio(bio), inode,
+					bio_offset, end_read_repair);
 			end_page_read(page, uptodate, start, len);
 			endio_readpage_release_extent(&processed, BTRFS_I(inode),
 					start, end, PageUptodate(page));
@@ -3076,6 +3068,8 @@ static void end_bio_extent_readpage(struct bio *bio)
 
 	}
 	/* Release the last extent */
+	btrfs_read_repair_finish(&rr, btrfs_bio(bio), inode, bio_offset,
+			end_read_repair);
 	endio_readpage_release_extent(&processed, NULL, 0, 0, false);
 	btrfs_bio_free_csum(bbio);
 	bio_put(bio);
-- 
2.30.2

