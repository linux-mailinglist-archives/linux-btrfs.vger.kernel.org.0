Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CA56A45CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 16:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjB0PRS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 10:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjB0PRO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 10:17:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6576B22791
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 07:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JAk0DfnYESrHYyyCJUzghVgInG4BNNDt+HakP01Y3ts=; b=RHS0EQY7PMERJNvF/lvZuCqZEV
        fGlbRKiukaiyJKRas6VLm4zuANm2vjV2uSfSF6bFSHOX07BTW+O/h6SKSlE14s/n1R0i3ZOVL6xYU
        N487MsOWSXsOUtTMuIgwrAfl6iPrHhw2bGIKF3P/gjN9JyeghL81O6+CZA5/ha1lzec4Bi5WgkNwg
        Se/pL9n7Xak4VIGvXNU72+4qGtXpLDSfa+A0N+fV2Jex3KkHVHFkvrBAZGhqA9/tOa834ZOc3TafY
        9UtIQvUubM4z2QvqMfbspw03TsKUsYFEfbdFDbF9wn6JuWD/KakJ8/txVF9kXSUPaGRKdwQ5TQOk+
        HLip/kFw==;
Received: from [136.36.117.140] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWfFR-00AAsf-Ss; Mon, 27 Feb 2023 15:17:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH 03/12] btrfs: store the bio opf in struct btrfs_bio_ctrl
Date:   Mon, 27 Feb 2023 08:16:55 -0700
Message-Id: <20230227151704.1224688-4-hch@lst.de>
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

The bio op and flags never change over the life time of a bio_ctrl,
so move it in there instead of passing it down the deep callchain
all the way down to alloc_new_bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 65 ++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 908a67cf5fb310..2fb23e939b9975 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -101,6 +101,7 @@ struct btrfs_bio_ctrl {
 	int mirror_num;
 	enum btrfs_compression_type compress_type;
 	u32 len_to_oe_boundary;
+	blk_opf_t opf;
 	btrfs_bio_end_io_t end_io_func;
 
 	/*
@@ -973,15 +974,15 @@ static void calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 
 static void alloc_new_bio(struct btrfs_inode *inode,
 			  struct btrfs_bio_ctrl *bio_ctrl,
-			  struct writeback_control *wbc, blk_opf_t opf,
+			  struct writeback_control *wbc,
 			  u64 disk_bytenr, u32 offset, u64 file_offset,
 			  enum btrfs_compression_type compress_type)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct bio *bio;
 
-	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, inode, bio_ctrl->end_io_func,
-			      NULL);
+	bio = btrfs_bio_alloc(BIO_MAX_VECS, bio_ctrl->opf, inode,
+			      bio_ctrl->end_io_func, NULL);
 	/*
 	 * For compressed page range, its disk_bytenr is always @disk_bytenr
 	 * passed in, no matter if we have added any range into previous bio.
@@ -1008,7 +1009,6 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 }
 
 /*
- * @opf:	bio REQ_OP_* and REQ_* flags as one value
  * @wbc:	optional writeback control for io accounting
  * @disk_bytenr: logical bytenr where the write will be
  * @page:	page to add to the bio
@@ -1022,8 +1022,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
  * The mirror number for this IO should already be initizlied in
  * @bio_ctrl->mirror_num.
  */
-static int submit_extent_page(blk_opf_t opf,
-			      struct writeback_control *wbc,
+static int submit_extent_page(struct writeback_control *wbc,
 			      struct btrfs_bio_ctrl *bio_ctrl,
 			      u64 disk_bytenr, struct page *page,
 			      size_t size, unsigned long pg_offset,
@@ -1045,7 +1044,7 @@ static int submit_extent_page(blk_opf_t opf,
 
 		/* Allocate new bio if needed */
 		if (!bio_ctrl->bio) {
-			alloc_new_bio(inode, bio_ctrl, wbc, opf, disk_bytenr,
+			alloc_new_bio(inode, bio_ctrl, wbc, disk_bytenr,
 				      offset, page_offset(page) + cur,
 				      compress_type);
 		}
@@ -1189,8 +1188,7 @@ __get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
  * return 0 on success, otherwise return error
  */
 static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
-		      struct btrfs_bio_ctrl *bio_ctrl,
-		      blk_opf_t read_flags, u64 *prev_em_start)
+		      struct btrfs_bio_ctrl *bio_ctrl, u64 *prev_em_start)
 {
 	struct inode *inode = page->mapping->host;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -1329,8 +1327,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 
 		if (force_bio_submit)
 			submit_one_bio(bio_ctrl);
-		ret = submit_extent_page(REQ_OP_READ | read_flags, NULL,
-					 bio_ctrl, disk_bytenr, page, iosize,
+		ret = submit_extent_page(NULL, bio_ctrl, disk_bytenr, page, iosize,
 					 pg_offset, this_bio_flag);
 		if (ret) {
 			/*
@@ -1354,12 +1351,12 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
-	struct btrfs_bio_ctrl bio_ctrl = { 0 };
+	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ };
 	int ret;
 
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
-	ret = btrfs_do_readpage(page, NULL, &bio_ctrl, 0, NULL);
+	ret = btrfs_do_readpage(page, NULL, &bio_ctrl, NULL);
 	/*
 	 * If btrfs_do_readpage() failed we will want to submit the assembled
 	 * bio to do the cleanup.
@@ -1381,7 +1378,7 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
 
 	for (index = 0; index < nr_pages; index++) {
 		btrfs_do_readpage(pages[index], em_cached, bio_ctrl,
-				  REQ_RAHEAD, prev_em_start);
+				  prev_em_start);
 		put_page(pages[index]);
 	}
 }
@@ -1531,8 +1528,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	int saved_ret = 0;
 	int ret = 0;
 	int nr = 0;
-	enum req_op op = REQ_OP_WRITE;
-	const blk_opf_t write_flags = wbc_to_write_flags(wbc);
 	bool has_error = false;
 	bool compressed;
 
@@ -1639,10 +1634,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		 */
 		btrfs_page_clear_dirty(fs_info, page, cur, iosize);
 
-		ret = submit_extent_page(op | write_flags, wbc,
-					 bio_ctrl, disk_bytenr,
-					 page, iosize,
-					 cur - page_offset(page), 0);
+		ret = submit_extent_page(wbc, bio_ctrl, disk_bytenr, page,
+					 iosize, cur - page_offset(page), 0);
 		if (ret) {
 			has_error = true;
 			if (!saved_ret)
@@ -2115,7 +2108,6 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct page *page = eb->pages[0];
-	blk_opf_t write_flags = wbc_to_write_flags(wbc);
 	bool no_dirty_ebs = false;
 	int ret;
 
@@ -2133,8 +2125,7 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
 
 	bio_ctrl->end_io_func = end_bio_subpage_eb_writepage;
 
-	ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
-			bio_ctrl, eb->start, page, eb->len,
+	ret = submit_extent_page(wbc, bio_ctrl, eb->start, page, eb->len,
 			eb->start - page_offset(page), 0);
 	if (ret) {
 		btrfs_subpage_clear_writeback(fs_info, page, eb->start, eb->len);
@@ -2161,7 +2152,6 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 {
 	u64 disk_bytenr = eb->start;
 	int i, num_pages;
-	blk_opf_t write_flags = wbc_to_write_flags(wbc);
 	int ret = 0;
 
 	prepare_eb_write(eb);
@@ -2174,8 +2164,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 
 		clear_page_dirty_for_io(p);
 		set_page_writeback(p);
-		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
-					 bio_ctrl, disk_bytenr, p,
+		ret = submit_extent_page(wbc, bio_ctrl, disk_bytenr, p,
 					 PAGE_SIZE, 0, 0);
 		if (ret) {
 			set_btree_ioerr(p, eb);
@@ -2397,6 +2386,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 {
 	struct extent_buffer *eb_context = NULL;
 	struct btrfs_bio_ctrl bio_ctrl = {
+		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
 		.extent_locked = 0,
 		.sync_io = (wbc->sync_mode == WB_SYNC_ALL),
 	};
@@ -2683,10 +2673,6 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 	u64 cur = start;
 	unsigned long nr_pages;
 	const u32 sectorsize = btrfs_sb(inode->i_sb)->sectorsize;
-	struct btrfs_bio_ctrl bio_ctrl = {
-		.extent_locked = 1,
-		.sync_io = 1,
-	};
 	struct writeback_control wbc_writepages = {
 		.sync_mode	= WB_SYNC_ALL,
 		.range_start	= start,
@@ -2695,6 +2681,11 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 		.punt_to_cgroup	= 1,
 		.no_cgroup_owner = 1,
 	};
+	struct btrfs_bio_ctrl bio_ctrl = {
+		.opf = REQ_OP_WRITE | wbc_to_write_flags(&wbc_writepages),
+		.extent_locked = 1,
+		.sync_io = 1,
+	};
 
 	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(end + 1, sectorsize));
 	nr_pages = (round_up(end, PAGE_SIZE) - round_down(start, PAGE_SIZE)) >>
@@ -2738,6 +2729,7 @@ int extent_writepages(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	int ret = 0;
 	struct btrfs_bio_ctrl bio_ctrl = {
+		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
 		.extent_locked = 0,
 		.sync_io = (wbc->sync_mode == WB_SYNC_ALL),
 	};
@@ -2755,7 +2747,7 @@ int extent_writepages(struct address_space *mapping,
 
 void extent_readahead(struct readahead_control *rac)
 {
-	struct btrfs_bio_ctrl bio_ctrl = { 0 };
+	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ | REQ_RAHEAD };
 	struct page *pagepool[16];
 	struct extent_map *em_cached = NULL;
 	u64 prev_em_start = (u64)-1;
@@ -4402,6 +4394,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	struct page *page = eb->pages[0];
 	struct extent_state *cached_state = NULL;
 	struct btrfs_bio_ctrl bio_ctrl = {
+		.opf = REQ_OP_READ,
 		.mirror_num = mirror_num,
 		.parent_check = check,
 	};
@@ -4442,8 +4435,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	btrfs_subpage_clear_error(fs_info, page, eb->start, eb->len);
 
 	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
-	ret = submit_extent_page(REQ_OP_READ, NULL, &bio_ctrl,
-				 eb->start, page, eb->len,
+	ret = submit_extent_page(NULL, &bio_ctrl, eb->start, page, eb->len,
 				 eb->start - page_offset(page), 0);
 	if (ret) {
 		/*
@@ -4478,6 +4470,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 	int num_pages;
 	unsigned long num_reads = 0;
 	struct btrfs_bio_ctrl bio_ctrl = {
+		.opf = REQ_OP_READ,
 		.mirror_num = mirror_num,
 		.parent_check = check,
 	};
@@ -4552,9 +4545,9 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 			}
 
 			ClearPageError(page);
-			err = submit_extent_page(REQ_OP_READ, NULL,
-					 &bio_ctrl, page_offset(page), page,
-					 PAGE_SIZE, 0, 0);
+			err = submit_extent_page(NULL, &bio_ctrl,
+						 page_offset(page), page,
+						 PAGE_SIZE, 0, 0);
 			if (err) {
 				/*
 				 * We failed to submit the bio so it's the
-- 
2.39.1

