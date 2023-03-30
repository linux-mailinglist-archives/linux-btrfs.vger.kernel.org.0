Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CAE6CFB95
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 08:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjC3Gbe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 02:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjC3Gbc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 02:31:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BAC6585
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 23:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Ruf1OekTMhobr3JG7I+L+ptQDTagB+T+iFbxdc9hBGM=; b=fFQPQgeRptHf7HWXuvEA8yTRJc
        NPjxAqZnxrofNjijrzDd64bQm2G3MVVPq32vHH6B1jQqe4CXDGUJBG4JosIxpPE4A42U+1dHihTh0
        ng4xT7Qmqqv8MEvR0aUrV7T3XsHV3LGP0s10o1id2er15+WsMMhfjagoySDUgrdrAPGzU7vPyQSzO
        MUFfmIaZ0we9Cns/S7BUbBF2tLT7nwKozq+l6fYZQtpOeaGoAOh/E+LwA9CeEntRuzP071HCi27od
        mxt+7faF+R3omWTzhMJeNxPb9EfpMBsDrXyPbdtNJrvpv4jLggQyU9a9uQLb5B3009+Y/JfGYdW8/
        aBq3tvIA==;
Received: from [182.171.77.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phloo-002lg2-2Q;
        Thu, 30 Mar 2023 06:31:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH 13/21] btrfs: don't use btrfs_bio_ctrl for extent buffer writing
Date:   Thu, 30 Mar 2023 15:30:51 +0900
Message-Id: <20230330063059.1574380-14-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330063059.1574380-1-hch@lst.de>
References: <20230330063059.1574380-1-hch@lst.de>
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

The btrfs_bio_ctrl machinery is overkill for writing extent_buffers
as we always operate on PAGE SIZE chunks (or one smaller one for the
subpage case) that are contigous and are guaranteed to fit into a
single bio.  Replace it with open coded btrfs_bio_alloc, __bio_add_page
and btrfs_submit_bio calls.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 56a2e6421b7189..f813ce5c7e14da 100644
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
@@ -1898,11 +1895,7 @@ static void write_one_subpage_eb(struct extent_buffer *eb,
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
 
@@ -1916,10 +1909,16 @@ static void write_one_subpage_eb(struct extent_buffer *eb,
 	if (no_dirty_ebs)
 		clear_page_dirty_for_io(page);
 
-	submit_extent_page(&bio_ctrl, eb->start, page, eb->len,
-			   eb->start - page_offset(page));
+	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
+			       REQ_OP_WRITE | REQ_META | wbc_to_write_flags(wbc),
+			       BTRFS_I(eb->fs_info->btree_inode),
+			       end_bio_subpage_eb_writepage, NULL);
+	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
+	bbio->file_offset = eb->start;
+	__bio_add_page(&bbio->bio, page, eb->len, eb->start - page_offset(page));
 	unlock_page(page);
-	submit_one_bio(&bio_ctrl);
+	btrfs_submit_bio(bbio, 0);
+
 	/*
 	 * Submission finished without problem, if no range of the page is
 	 * dirty anymore, we have submitted a page.  Update nr_written in wbc.
@@ -1931,16 +1930,18 @@ static void write_one_subpage_eb(struct extent_buffer *eb,
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
+			       BTRFS_I(eb->fs_info->btree_inode),
+			       end_bio_extent_buffer_writepage, NULL);
+	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
+	bbio->file_offset = eb->start;
+
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = eb->pages[i];
@@ -1948,12 +1949,11 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
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

