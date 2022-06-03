Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D938753C5C4
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 09:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242024AbiFCHLS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jun 2022 03:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241804AbiFCHLQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jun 2022 03:11:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848E23120A
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jun 2022 00:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zxpPJG9fdXJak6/LqxV8PJenc0E+3jO2wDochH7JOoU=; b=m+07o8qvKxdoZqzg0BdJKiCypN
        xRz55pKbRwPw47666srQJ+fnViRFF/EiOXc6oBxyvLxlZJIErjB6VfN1HwBjB4HEU0NhLeQPPoGPF
        Gb7JD0BPDhnl0j2kReKqROxoaxKbrX6DuCmNjuADbi70wi7cZ3YcBXd3MGMwtMluR+5aiKpvpQD1O
        B9Ol+Ha+jRB77Sohxxf0SHgWHnqBoFpIdIbbbrcHwIuINR1+3uWf9VTlc4vVRTDf4qG/iznqeHhna
        Rtr1iftDgkgxOLBWSpI8Rn9oquie7pDt7QoE2gPQEPgs/R+6Vxbadi8Rkt13zmGCa/MGwuNrZN1oY
        FPbRxpEg==;
Received: from [2001:4bb8:185:a81e:b29a:8b56:eb9a:ca3b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nx1Sj-006EnD-1m; Fri, 03 Jun 2022 07:11:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: pass the btrfs_bio_ctrl to submit_one_bio
Date:   Fri,  3 Jun 2022 09:11:03 +0200
Message-Id: <20220603071103.43440-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603071103.43440-1-hch@lst.de>
References: <20220603071103.43440-1-hch@lst.de>
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

submit_one_bio always works on the bio and compression flags from a
btrfs_bio_ctrl structure.  Pass the explicitly and clean up the the
calling conventions by handling a NULL bio in submit_one_bio, and
using the btrfs_bio_ctrl to pass the mirror number as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 82 ++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 72a258fa27947..facca7feb9a22 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -144,6 +144,7 @@ struct tree_entry {
  */
 struct btrfs_bio_ctrl {
 	struct bio *bio;
+	int mirror_num;
 	enum btrfs_compression_type compress_type;
 	u32 len_to_stripe_boundary;
 	u32 len_to_oe_boundary;
@@ -178,10 +179,11 @@ static int add_extent_changeset(struct extent_state *state, u32 bits,
 	return ret;
 }
 
-static void submit_one_bio(struct bio *bio, int mirror_num,
-			   enum btrfs_compression_type compress_type)
+static void __submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 {
+	struct bio *bio = bio_ctrl->bio;
 	struct inode *inode = bio_first_page_all(bio)->mapping->host;
+	int mirror_num = bio_ctrl->mirror_num;
 
 	/* Caller should ensure the bio has at least some range added */
 	ASSERT(bio->bi_iter.bi_size);
@@ -191,14 +193,17 @@ static void submit_one_bio(struct bio *bio, int mirror_num,
 	else if (btrfs_op(bio) == BTRFS_MAP_WRITE)
 		btrfs_submit_data_write_bio(inode, bio, mirror_num);
 	else
-		btrfs_submit_data_read_bio(inode, bio, mirror_num, compress_type);
+		btrfs_submit_data_read_bio(inode, bio, mirror_num,
+					   bio_ctrl->compress_type);
 
-	/*
-	 * Above submission hooks will handle the error by ending the bio,
-	 * which will do the cleanup properly.  So here we should not return
-	 * any error, or the caller of submit_extent_page() will do cleanup
-	 * again, causing problems.
-	 */
+	/* The bio is owned by the bi_end_io handler now */
+	bio_ctrl->bio = NULL;
+}
+
+static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
+{
+	if (bio_ctrl->bio)
+		__submit_one_bio(bio_ctrl);
 }
 
 /*
@@ -215,12 +220,11 @@ static void submit_write_bio(struct extent_page_data *epd, int ret)
 		ASSERT(ret < 0);
 		bio->bi_status = errno_to_blk_status(ret);
 		bio_endio(bio);
+		/* The bio is owned by the bi_end_io handler now */
+		epd->bio_ctrl.bio = NULL;
 	} else {
-		submit_one_bio(bio, 0, 0);
+		__submit_one_bio(&epd->bio_ctrl);
 	}
-
-	/* The bio is owned by the bi_end_io handler now */
-	epd->bio_ctrl.bio = NULL;
 }
 
 int __init extent_state_cache_init(void)
@@ -3408,7 +3412,6 @@ static int submit_extent_page(unsigned int opf,
 			      struct page *page, u64 disk_bytenr,
 			      size_t size, unsigned long pg_offset,
 			      bio_end_io_t end_io_func,
-			      int mirror_num,
 			      enum btrfs_compression_type compress_type,
 			      bool force_bio_submit)
 {
@@ -3420,10 +3423,8 @@ static int submit_extent_page(unsigned int opf,
 
 	ASSERT(pg_offset < PAGE_SIZE && size <= PAGE_SIZE &&
 	       pg_offset + size <= PAGE_SIZE);
-	if (force_bio_submit && bio_ctrl->bio) {
-		submit_one_bio(bio_ctrl->bio, mirror_num, bio_ctrl->compress_type);
-		bio_ctrl->bio = NULL;
-	}
+	if (force_bio_submit)
+		submit_one_bio(bio_ctrl);
 
 	while (cur < pg_offset + size) {
 		u32 offset = cur - pg_offset;
@@ -3463,8 +3464,7 @@ static int submit_extent_page(unsigned int opf,
 		if (added < size - offset) {
 			/* The bio should contain some page(s) */
 			ASSERT(bio_ctrl->bio->bi_iter.bi_size);
-			submit_one_bio(bio_ctrl->bio, mirror_num, bio_ctrl->compress_type);
-			bio_ctrl->bio = NULL;
+			submit_one_bio(bio_ctrl);
 		}
 		cur += added;
 	}
@@ -3741,10 +3741,8 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 
 		ret = submit_extent_page(REQ_OP_READ | read_flags, NULL,
 					 bio_ctrl, page, disk_bytenr, iosize,
-					 pg_offset,
-					 end_bio_extent_readpage, 0,
-					 this_bio_flag,
-					 force_bio_submit);
+					 pg_offset, end_bio_extent_readpage,
+					 this_bio_flag, force_bio_submit);
 		if (ret) {
 			/*
 			 * We have to unlock the remaining range, or the page
@@ -3776,8 +3774,7 @@ int btrfs_readpage(struct file *file, struct page *page)
 	 * If btrfs_do_readpage() failed we will want to submit the assembled
 	 * bio to do the cleanup.
 	 */
-	if (bio_ctrl.bio)
-		submit_one_bio(bio_ctrl.bio, 0, bio_ctrl.compress_type);
+	submit_one_bio(&bio_ctrl);
 	return ret;
 }
 
@@ -4060,7 +4057,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 					 disk_bytenr, iosize,
 					 cur - page_offset(page),
 					 end_bio_extent_writepage,
-					 0, 0, false);
+					 0, false);
 		if (ret) {
 			has_error = true;
 			if (!saved_ret)
@@ -4553,7 +4550,7 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
 	ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
 			&epd->bio_ctrl, page, eb->start, eb->len,
 			eb->start - page_offset(page),
-			end_bio_subpage_eb_writepage, 0, 0, false);
+			end_bio_subpage_eb_writepage, 0, false);
 	if (ret) {
 		btrfs_subpage_clear_writeback(fs_info, page, eb->start, eb->len);
 		set_btree_ioerr(page, eb);
@@ -4594,7 +4591,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 					 &epd->bio_ctrl, p, disk_bytenr,
 					 PAGE_SIZE, 0,
 					 end_bio_extent_buffer_writepage,
-					 0, 0, false);
+					 0, false);
 		if (ret) {
 			set_btree_ioerr(p, eb);
 			if (PageWriteback(p))
@@ -5207,9 +5204,7 @@ void extent_readahead(struct readahead_control *rac)
 
 	if (em_cached)
 		free_extent_map(em_cached);
-
-	if (bio_ctrl.bio)
-		submit_one_bio(bio_ctrl.bio, 0, bio_ctrl.compress_type);
+	submit_one_bio(&bio_ctrl);
 }
 
 /*
@@ -6536,7 +6531,9 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct extent_io_tree *io_tree;
 	struct page *page = eb->pages[0];
-	struct btrfs_bio_ctrl bio_ctrl = { 0 };
+	struct btrfs_bio_ctrl bio_ctrl = {
+		.mirror_num = mirror_num,
+	};
 	int ret = 0;
 
 	ASSERT(!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags));
@@ -6571,8 +6568,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	ret = submit_extent_page(REQ_OP_READ, NULL, &bio_ctrl,
 				 page, eb->start, eb->len,
 				 eb->start - page_offset(page),
-				 end_bio_extent_readpage, mirror_num, 0,
-				 true);
+				 end_bio_extent_readpage, 0, true);
 	if (ret) {
 		/*
 		 * In the endio function, if we hit something wrong we will
@@ -6581,10 +6577,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 		 */
 		atomic_dec(&eb->io_pages);
 	}
-	if (bio_ctrl.bio) {
-		submit_one_bio(bio_ctrl.bio, mirror_num, 0);
-		bio_ctrl.bio = NULL;
-	}
+	submit_one_bio(&bio_ctrl);
 	if (ret || wait != WAIT_COMPLETE)
 		return ret;
 
@@ -6604,7 +6597,9 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 	int all_uptodate = 1;
 	int num_pages;
 	unsigned long num_reads = 0;
-	struct btrfs_bio_ctrl bio_ctrl = { 0 };
+	struct btrfs_bio_ctrl bio_ctrl = {
+		.mirror_num = mirror_num,
+	};
 
 	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
 		return 0;
@@ -6678,7 +6673,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 			err = submit_extent_page(REQ_OP_READ, NULL,
 					 &bio_ctrl, page, page_offset(page),
 					 PAGE_SIZE, 0, end_bio_extent_readpage,
-					 mirror_num, 0, false);
+					 0, false);
 			if (err) {
 				/*
 				 * We failed to submit the bio so it's the
@@ -6695,10 +6690,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 		}
 	}
 
-	if (bio_ctrl.bio) {
-		submit_one_bio(bio_ctrl.bio, mirror_num, bio_ctrl.compress_type);
-		bio_ctrl.bio = NULL;
-	}
+	submit_one_bio(&bio_ctrl);
 
 	if (ret || wait != WAIT_COMPLETE)
 		return ret;
-- 
2.30.2

