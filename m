Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6C26D57E8
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 07:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjDDFQa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 01:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDDFQ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 01:16:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA6E1739
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Apr 2023 22:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=4oDyBymq0cBzKpWPi1sRswPErxJT2V3+ayyG5Jkua6U=; b=R8uzk8dSJcjbEluwk7eRe7QOWD
        EJ7Mj5DJysHdNpDK0YtgkGT5RkwvKqx8t/pXwPn/5VNBET6wsD6YzJCkoUpHW0OtfAFX20ASjdeZR
        X7txoSuoBR4ZR07VGNgVcDpZfPcndN10Ln4eWSkGdF7rkawJWzA3gJ0xi6q0wvIUVa/UmTWzkn4N1
        c2nUrcQnrW3LO8uhuXbauyy572QiNPaQaCjQJegpqChi5OAy5YMo1iH/PU2ZhPjQWvwe6u7p/wqzy
        ITezYakIQ65FC+eNTX/lHyPyjuL2vBBcGX+XRgcjbl/GJoxQMuRLDenGqAEs/ZjsOsOOtN3dF/1Tz
        CGxbtxpQ==;
Received: from [2001:4bb8:191:a744:442d:91f6:d33c:d029] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjZ1s-0004vL-2P;
        Tue, 04 Apr 2023 05:16:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove struct processed_extent
Date:   Tue,  4 Apr 2023 07:16:22 +0200
Message-Id: <20230404051622.2006302-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since commit 4a445b7b6178 ("btrfs: don't merge pages into bio if thei
r page offset is not contiguous"), all pages in buffered I/O bios
are contigous.

Remove the processed_extent machinery and just do a single unlock_extent
for the entire bio, using the bbio-wide information like bbio->inode
where applicable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 115 +++++++------------------------------------
 1 file changed, 19 insertions(+), 96 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a1adadd5d25ddb..8116be675f301b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -606,75 +606,6 @@ static void end_bio_extent_writepage(struct btrfs_bio *bbio)
 	bio_put(bio);
 }
 
-/*
- * Record previously processed extent range
- *
- * For endio_readpage_release_extent() to handle a full extent range, reducing
- * the extent io operations.
- */
-struct processed_extent {
-	struct btrfs_inode *inode;
-	/* Start of the range in @inode */
-	u64 start;
-	/* End of the range in @inode */
-	u64 end;
-	bool uptodate;
-};
-
-/*
- * Try to release processed extent range
- *
- * May not release the extent range right now if the current range is
- * contiguous to processed extent.
- *
- * Will release processed extent when any of @inode, @uptodate, the range is
- * no longer contiguous to the processed range.
- *
- * Passing @inode == NULL will force processed extent to be released.
- */
-static void endio_readpage_release_extent(struct processed_extent *processed,
-			      struct btrfs_inode *inode, u64 start, u64 end,
-			      bool uptodate)
-{
-	struct extent_state *cached = NULL;
-	struct extent_io_tree *tree;
-
-	/* The first extent, initialize @processed */
-	if (!processed->inode)
-		goto update;
-
-	/*
-	 * Contiguous to processed extent, just uptodate the end.
-	 *
-	 * Several things to notice:
-	 *
-	 * - bio can be merged as long as on-disk bytenr is contiguous
-	 *   This means we can have page belonging to other inodes, thus need to
-	 *   check if the inode still matches.
-	 * - bvec can contain range beyond current page for multi-page bvec
-	 *   Thus we need to do processed->end + 1 >= start check
-	 */
-	if (processed->inode == inode && processed->uptodate == uptodate &&
-	    processed->end + 1 >= start && end >= processed->end) {
-		processed->end = end;
-		return;
-	}
-
-	tree = &processed->inode->io_tree;
-	/*
-	 * Now we don't have range contiguous to the processed range, release
-	 * the processed range now.
-	 */
-	unlock_extent(tree, processed->start, processed->end, &cached);
-
-update:
-	/* Update processed to current range */
-	processed->inode = inode;
-	processed->start = start;
-	processed->end = end;
-	processed->uptodate = uptodate;
-}
-
 static void begin_page_read(struct btrfs_fs_info *fs_info, struct page *page)
 {
 	ASSERT(PageLocked(page));
@@ -727,27 +658,28 @@ static struct extent_buffer *find_extent_buffer_readpage(
  */
 static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 {
+	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
+	const u32 sectorsize = fs_info->sectorsize;
+	struct bvec_iter_all iter_all;
 	struct bio *bio = &bbio->bio;
+	bool uptodate = !bio->bi_status;
+	int mirror = bbio->mirror_num;
 	struct bio_vec *bvec;
-	struct processed_extent processed = { 0 };
-	/*
-	 * The offset to the beginning of a bio, since one bio can never be
-	 * larger than UINT_MAX, u32 here is enough.
-	 */
-	u32 bio_offset = 0;
-	int mirror;
-	struct bvec_iter_all iter_all;
+	u64 bio_start = 0;
+	u32 bio_len = 0;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		bool uptodate = !bio->bi_status;
 		struct page *page = bvec->bv_page;
 		struct inode *inode = page->mapping->host;
-		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-		const u32 sectorsize = fs_info->sectorsize;
-		u64 start;
-		u64 end;
-		u32 len;
+		u64 start = page_offset(page) + bvec->bv_offset;
+		u64 end = start + bvec->bv_len - 1;
+		u32 len = bvec->bv_len;
+
+		if (bio_len)
+			ASSERT(start == bio_start + bio_len);
+		else
+			bio_start = start;
 
 		btrfs_debug(fs_info,
 			"end_bio_extent_readpage: bi_sector=%llu, err=%d, mirror=%u",
@@ -771,15 +703,9 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 		"incomplete page read with offset %u and length %u",
 				   bvec->bv_offset, bvec->bv_len);
 
-		start = page_offset(page) + bvec->bv_offset;
-		end = start + bvec->bv_len - 1;
-		len = bvec->bv_len;
-
-		mirror = bbio->mirror_num;
 		if (uptodate && !is_data_inode(inode) &&
 		    btrfs_validate_metadata_buffer(bbio, page, start, end, mirror))
 			uptodate = false;
-
 		if (likely(uptodate)) {
 			loff_t i_size = i_size_read(inode);
 			pgoff_t end_index = i_size >> PAGE_SHIFT;
@@ -811,15 +737,12 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 
 		/* Update page status and unlock. */
 		end_page_read(page, uptodate, start, len);
-		endio_readpage_release_extent(&processed, BTRFS_I(inode),
-					      start, end, PageUptodate(page));
-
-		ASSERT(bio_offset + len > bio_offset);
-		bio_offset += len;
+		bio_len += len;
 
 	}
-	/* Release the last extent */
-	endio_readpage_release_extent(&processed, NULL, 0, 0, false);
+
+	unlock_extent(&bbio->inode->io_tree, bio_start,
+		      bio_start + bio_len - 1, NULL);
 	bio_put(bio);
 }
 
-- 
2.39.2

