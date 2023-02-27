Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECB16A45C7
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 16:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjB0PR0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 10:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjB0PRQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 10:17:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9383A227B4
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 07:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VASh8IkzPl2ZTusVkXf44ohD0wA0HEBdR6ftSHvYBrk=; b=E6Zeh8mlcYDo77gYfM2l1u9CPV
        tpNESTRy/bT2zbJUbkXGiZiGDcPcD83MNbr4QY3TckC556/suaZvdeDSREKPckluPzbZ+wNZRfpU7
        a+lB1cCuQjHeoh+n6MQXjE+w3nb/pSC6U2IG16vNAjVs+uUZDSZC4Uu7DDcYoCArs2BUrCRGZS3Z3
        LuPYwTe4D2BAE3xJcMRDk5UpOpRrfg+HtBbaSX3+r8x7LhLqwUj2SAwtIxuvXkHw9c0mCbigUOOGp
        9o9xB20poLi3jklz94tFQAgJ86urhVWscqxZTiH8++nj3S/qPza41qpnLUDOHua/nlgpbkNl7dufN
        6s7++Ysg==;
Received: from [136.36.117.140] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWfFW-00AAuL-6G; Mon, 27 Feb 2023 15:17:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 12/12] btrfs: simplify submit_extent_page
Date:   Mon, 27 Feb 2023 08:17:04 -0700
Message-Id: <20230227151704.1224688-13-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230227151704.1224688-1-hch@lst.de>
References: <20230227151704.1224688-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

bio_add_page always adds either the entire range passed to it or nothing.
Based on that btrfs_bio_add_page can only return a length smaller than
the passed in one when hitting the ordered extent limit, which can only
happen for writes.  Given that compressed writes never even use this code
path, this means that all the special cases for compressed extent offset
handling are dead code.

Reflow submit_extent_page to take advantage of this by inlining
btrfs_bio_add_page and handling the ordered extent limit by decremeting
it for each added range and thus significantly simplifying the loop.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 116 +++++++++++--------------------------------
 1 file changed, 30 insertions(+), 86 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8e6f0f07597e45..3ae42c70a82abc 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -897,47 +897,6 @@ static bool btrfs_bio_is_contig(struct btrfs_bio_ctrl *bio_ctrl,
 		page_offset(page) + pg_offset;
 }
 
-/*
- * Attempt to add a page to bio.
- *
- * @bio_ctrl:       record both the bio, and its bio_flags
- * @page:	    page to add to the bio
- * @disk_bytenr:    offset of the new bio or to check whether we are adding
- *                  a contiguous page to the previous one
- * @size:	    portion of page that we want to write
- * @pg_offset:	    starting offset in the page
- *
- * Attempt to add a page to bio considering stripe alignment etc.
- *
- * Return >= 0 for the number of bytes added to the bio.
- * Can return 0 if the current bio is already at stripe/zone boundary.
- * Return <0 for error.
- */
-static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
-			      struct page *page,
-			      u64 disk_bytenr, unsigned int size,
-			      unsigned int pg_offset)
-{
-	struct bio *bio = bio_ctrl->bio;
-	u32 bio_size = bio->bi_iter.bi_size;
-	u32 real_size;
-
-	ASSERT(bio);
-	/* The limit should be calculated when bio_ctrl->bio is allocated */
-	ASSERT(bio_ctrl->len_to_oe_boundary);
-
-	real_size = min(bio_ctrl->len_to_oe_boundary - bio_size, size);
-
-	/*
-	 * If real_size is 0, never call bio_add_*_page(), as even size is 0,
-	 * bio will still execute its endio function on the page!
-	 */
-	if (real_size == 0)
-		return 0;
-
-	return bio_add_page(bio, page, real_size, pg_offset);
-}
-
 static void calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 				struct btrfs_inode *inode, u64 file_offset)
 {
@@ -965,21 +924,14 @@ static void calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 
 static void alloc_new_bio(struct btrfs_inode *inode,
 			  struct btrfs_bio_ctrl *bio_ctrl,
-			  u64 disk_bytenr, u32 offset, u64 file_offset)
+			  u64 disk_bytenr, u64 file_offset)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct bio *bio;
 
 	bio = btrfs_bio_alloc(BIO_MAX_VECS, bio_ctrl->opf, inode,
 			      bio_ctrl->end_io_func, NULL);
-	/*
-	 * For compressed page range, its disk_bytenr is always @disk_bytenr
-	 * passed in, no matter if we have added any range into previous bio.
-	 */
-	if (bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
-		bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
-	else
-		bio->bi_iter.bi_sector = (disk_bytenr + offset) >> SECTOR_SHIFT;
+	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
 	btrfs_bio(bio)->file_offset = file_offset;
 	bio_ctrl->bio = bio;
 	calc_bio_boundaries(bio_ctrl, inode, file_offset);
@@ -1013,56 +965,48 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 			       size_t size, unsigned long pg_offset)
 {
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
-	unsigned int cur = pg_offset;
-
-	ASSERT(bio_ctrl);
-
-	ASSERT(pg_offset < PAGE_SIZE && size <= PAGE_SIZE &&
-	       pg_offset + size <= PAGE_SIZE);
 
+	ASSERT(pg_offset + size <= PAGE_SIZE);
 	ASSERT(bio_ctrl->end_io_func);
 
 	if (bio_ctrl->bio &&
 	    !btrfs_bio_is_contig(bio_ctrl, page, disk_bytenr, pg_offset))
 		submit_one_bio(bio_ctrl);
 
-	while (cur < pg_offset + size) {
-		u32 offset = cur - pg_offset;
-		int added;
+	do {
+		u32 len = size;
 
 		/* Allocate new bio if needed */
 		if (!bio_ctrl->bio) {
 			alloc_new_bio(inode, bio_ctrl, disk_bytenr,
-				      offset, page_offset(page) + cur);
+				      page_offset(page) + pg_offset);
 		}
-		/*
-		 * We must go through btrfs_bio_add_page() to ensure each
-		 * page range won't cross various boundaries.
-		 */
-		if (bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
-			added = btrfs_bio_add_page(bio_ctrl, page, disk_bytenr,
-					size - offset, pg_offset + offset);
-		else
-			added = btrfs_bio_add_page(bio_ctrl, page,
-					disk_bytenr + offset, size - offset,
-					pg_offset + offset);
-
-		/* Metadata page range should never be split */
-		if (!is_data_inode(&inode->vfs_inode))
-			ASSERT(added == 0 || added == size - offset);
-
-		/* At least we added some page, update the account */
-		if (bio_ctrl->wbc && added)
-			wbc_account_cgroup_owner(bio_ctrl->wbc, page, added);
-
-		/* We have reached boundary, submit right now */
-		if (added < size - offset) {
-			/* The bio should contain some page(s) */
-			ASSERT(bio_ctrl->bio->bi_iter.bi_size);
+
+		/* Cap to the current ordered extent boundary if there is one */
+		if (len > bio_ctrl->len_to_oe_boundary) {
+			ASSERT(bio_ctrl->compress_type == BTRFS_COMPRESS_NONE);
+			ASSERT(is_data_inode(&inode->vfs_inode));
+			len = bio_ctrl->len_to_oe_boundary;
+		}
+
+		if (bio_add_page(bio_ctrl->bio, page, len, pg_offset) != len) {
+			/* bio full: move on to a new one */
 			submit_one_bio(bio_ctrl);
+			continue;
 		}
-		cur += added;
-	}
+
+		if (bio_ctrl->wbc)
+			wbc_account_cgroup_owner(bio_ctrl->wbc, page, len);
+
+		size -= len;
+		pg_offset += len;
+		disk_bytenr += len;
+		bio_ctrl->len_to_oe_boundary -= len;
+
+		/* Ordered extent boundary: move on to a new bio */
+		if (bio_ctrl->len_to_oe_boundary == 0)
+			submit_one_bio(bio_ctrl);
+	} while (size);
 }
 
 static int attach_extent_buffer_page(struct extent_buffer *eb,
-- 
2.39.1

