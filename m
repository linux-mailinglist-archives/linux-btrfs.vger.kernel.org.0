Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83516F5B05
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 17:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjECPZW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 11:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjECPZV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 11:25:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23F26E85
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 08:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Qfxot90PzO/ei92RThITjQ/Um3nNiSv4HJLMrmEFEuM=; b=cZ3GiIMexm8lla1lPivybxkaP2
        f6SDRTdPOKcAkjQq/fSjogTYc8lSAtU7YUKf+8v/LIihk1AzflL2NyOsOjz5BNCL1GDZcICCj29/Z
        hvuToGFnM1k5Q/Nb/2huUih417cOmJ8LDXOaCYam9FEvhf/+CLRxYoTLwrvvTR8KG5j6amEme6lHJ
        sTWzOa1Y/nacUNblemNYX/S12hmnmeTmELzvB+x0El1ATQJg8EmnggL2oiGLY3gNTEuUOEwX0WqVz
        CZ7Qo//EP5BatNHY06df1kXn6ntt6tTkrhrhMXEOhNzKNxCo1lVgTU2x0dFjTd22hRBycY30wbLym
        5sW5ziUw==;
Received: from [2001:4bb8:181:617f:7279:c4cd:ae56:e444] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puEM3-004xkt-0p;
        Wed, 03 May 2023 15:25:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH 13/21] btrfs: don't use btrfs_bio_ctrl for extent buffer writing
Date:   Wed,  3 May 2023 17:24:33 +0200
Message-Id: <20230503152441.1141019-14-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230503152441.1141019-1-hch@lst.de>
References: <20230503152441.1141019-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The btrfs_bio_ctrl machinery is overkill for writing extent_buffers
as we always operate on PAGE SIZE chunks (or one smaller one for the
subpage case) that are contigous and are guaranteed to fit into a
single bio.  Replace it with open coded btrfs_bio_alloc, __bio_add_page
and btrfs_submit_bio calls.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 76636e7c21b02f..68cdc6bed60c19 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -121,9 +121,6 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 	/* Caller should ensure the bio has at least some range added */
 	ASSERT(bbio->bio.bi_iter.bi_size);
 
-	if (!is_data_inode(&bbio->inode->vfs_inode))
-		bbio->bio.bi_opf |= REQ_META;
-
 	if (btrfs_op(&bbio->bio) == BTRFS_MAP_READ &&
 	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
 		btrfs_submit_compressed_read(bbio);
@@ -1899,11 +1896,7 @@ static void write_one_subpage_eb(struct extent_buffer *eb,
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct page *page = eb->pages[0];
 	bool no_dirty_ebs = false;
-	struct btrfs_bio_ctrl bio_ctrl = {
-		.wbc = wbc,
-		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
-		.end_io_func = end_bio_subpage_eb_writepage,
-	};
+	struct btrfs_bio *bbio;
 
 	prepare_eb_write(eb);
 
@@ -1917,10 +1910,16 @@ static void write_one_subpage_eb(struct extent_buffer *eb,
 	if (no_dirty_ebs)
 		clear_page_dirty_for_io(page);
 
-	submit_extent_page(&bio_ctrl, eb->start, page, eb->len,
-			   eb->start - page_offset(page));
+	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
+			       REQ_OP_WRITE | REQ_META | wbc_to_write_flags(wbc),
+			       eb->fs_info, end_bio_subpage_eb_writepage, NULL);
+	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
+	bbio->inode = BTRFS_I(eb->fs_info->btree_inode);
+	bbio->file_offset = eb->start;
+	__bio_add_page(&bbio->bio, page, eb->len, eb->start - page_offset(page));
 	unlock_page(page);
-	submit_one_bio(&bio_ctrl);
+	btrfs_submit_bio(bbio, 0);
+
 	/*
 	 * Submission finished without problem, if no range of the page is
 	 * dirty anymore, we have submitted a page.  Update nr_written in wbc.
@@ -1932,16 +1931,19 @@ static void write_one_subpage_eb(struct extent_buffer *eb,
 static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 					    struct writeback_control *wbc)
 {
-	u64 disk_bytenr = eb->start;
+	struct btrfs_bio *bbio;
 	int i, num_pages;
-	struct btrfs_bio_ctrl bio_ctrl = {
-		.wbc = wbc,
-		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
-		.end_io_func = end_bio_extent_buffer_writepage,
-	};
 
 	prepare_eb_write(eb);
 
+	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
+			       REQ_OP_WRITE | REQ_META | wbc_to_write_flags(wbc),
+			       eb->fs_info, end_bio_extent_buffer_writepage,
+			       NULL);
+	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
+	bbio->inode = BTRFS_I(eb->fs_info->btree_inode);
+	bbio->file_offset = eb->start;
+
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = eb->pages[i];
@@ -1949,12 +1951,11 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 		lock_page(p);
 		clear_page_dirty_for_io(p);
 		set_page_writeback(p);
-		submit_extent_page(&bio_ctrl, disk_bytenr, p, PAGE_SIZE, 0);
-		disk_bytenr += PAGE_SIZE;
+		__bio_add_page(&bbio->bio, p, PAGE_SIZE, 0);
 		wbc->nr_to_write--;
 		unlock_page(p);
 	}
-	submit_one_bio(&bio_ctrl);
+	btrfs_submit_bio(bbio, 0);
 }
 
 /*
-- 
2.39.2

