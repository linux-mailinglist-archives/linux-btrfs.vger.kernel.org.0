Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987B76CFB8E
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 08:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjC3GbS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 02:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjC3GbR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 02:31:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7E04EFC
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 23:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=lrY+PNA3btVfKte69b4KeQJJK32O3tPdJYJ3+Hjc2AU=; b=kKMpeQEsRSWJHpX4Z/TE2pTB5e
        RoQSEbglg2aNekgDwJ9tXQ32AMC+4j4nlVUvjgdaQOJ2wUxyLD1JqF9A6z8qh/s+7w7Ijkb7l0ar7
        PgLpheFMDMCTpeuh+7gfEbVk4xlH8960bBgfHr7DPoG98ycehpcdypqE9/He2ULnlrJnBewCEXYOD
        FyfruktBlrUs/l4ViU+yM5JfT9S1HFP5vTFpuhBPQ+pRegMOvDzbUyDH2oBQMdK8KHbHWvUyVWN4j
        0K3YtTn9TrUQ5S0n6q+RmmKMQdJpQedvW1LFiA7yP+L73o9Feo8gem5HXi2igvVbqdGUs9YJort2I
        dbufdocQ==;
Received: from [182.171.77.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phloZ-002lcO-1E;
        Thu, 30 Mar 2023 06:31:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH 06/21] btrfs: don't use btrfs_bio_ctrl for extent buffer reading
Date:   Thu, 30 Mar 2023 15:30:44 +0900
Message-Id: <20230330063059.1574380-7-hch@lst.de>
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

The btrfs_bio_ctrl machinery is overkill for reading extent_buffers
as we always operate on PAGE SIZE chunks (or one smaller one for the
subpage case) that are contigous and are guaranteed to fit into a
single bio.  Replace it with open coded btrfs_bio_alloc, __bio_add_page
and btrfs_submit_bio calls in a helper function shared between
the subpage and node size >= PAGE_SIZE cases.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 99 ++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 63 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e7a0ef6d70bfe1..8e709b44fa57ec 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -98,22 +98,12 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
  */
 struct btrfs_bio_ctrl {
 	struct btrfs_bio *bbio;
-	int mirror_num;
 	enum btrfs_compression_type compress_type;
 	u32 len_to_oe_boundary;
 	blk_opf_t opf;
 	btrfs_bio_end_io_t end_io_func;
 	struct writeback_control *wbc;
 
-	/*
-	 * This is for metadata read, to provide the extra needed verification
-	 * info.  This has to be provided for submit_one_bio(), as
-	 * submit_one_bio() can submit a bio if it ends at stripe boundary.  If
-	 * no such parent_check is provided, the metadata can hit false alert at
-	 * endio time.
-	 */
-	struct btrfs_tree_parent_check *parent_check;
-
 	/*
 	 * Tell writepage not to lock the state bits for this range, it still
 	 * does the unlocking.
@@ -124,7 +114,6 @@ struct btrfs_bio_ctrl {
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct btrfs_bio *bbio = bio_ctrl->bbio;
-	int mirror_num = bio_ctrl->mirror_num;
 
 	if (!bbio)
 		return;
@@ -132,25 +121,14 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 	/* Caller should ensure the bio has at least some range added */
 	ASSERT(bbio->bio.bi_iter.bi_size);
 
-	if (!is_data_inode(&bbio->inode->vfs_inode)) {
-		if (btrfs_op(&bbio->bio) != BTRFS_MAP_WRITE) {
-			/*
-			 * For metadata read, we should have the parent_check,
-			 * and copy it to bbio for metadata verification.
-			 */
-			ASSERT(bio_ctrl->parent_check);
-			memcpy(&bbio->parent_check,
-			       bio_ctrl->parent_check,
-			       sizeof(struct btrfs_tree_parent_check));
-		}
+	if (!is_data_inode(&bbio->inode->vfs_inode))
 		bbio->bio.bi_opf |= REQ_META;
-	}
 
 	if (btrfs_op(&bbio->bio) == BTRFS_MAP_READ &&
 	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
-		btrfs_submit_compressed_read(bbio, mirror_num);
+		btrfs_submit_compressed_read(bbio, 0);
 	else
-		btrfs_submit_bio(bbio, mirror_num);
+		btrfs_submit_bio(bbio, 0);
 
 	/* The bbio is owned by the end_io handler now */
 	bio_ctrl->bbio = NULL;
@@ -4242,6 +4220,36 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
 	}
 }
 
+static void __read_extent_buffer_pages(struct extent_buffer *eb, int mirror_num,
+				       struct btrfs_tree_parent_check *check)
+{
+	int num_pages = num_extent_pages(eb), i;
+	struct btrfs_bio *bbio;
+
+	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
+	eb->read_mirror = 0;
+	atomic_set(&eb->io_pages, num_pages);
+	check_buffer_tree_ref(eb);
+
+	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
+			       REQ_OP_READ | REQ_META,
+			       BTRFS_I(eb->fs_info->btree_inode),
+			       end_bio_extent_readpage, NULL);
+	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
+	bbio->file_offset = eb->start;
+	memcpy(&bbio->parent_check, check, sizeof(*check));
+	if (eb->fs_info->nodesize < PAGE_SIZE) {
+		__bio_add_page(&bbio->bio, eb->pages[0], eb->len,
+			       eb->start - page_offset(eb->pages[0]));
+	} else {
+		for (i = 0; i < num_pages; i++) {
+			ClearPageError(eb->pages[i]);
+			__bio_add_page(&bbio->bio, eb->pages[i], PAGE_SIZE, 0);
+		}
+	}
+	btrfs_submit_bio(bbio, mirror_num);
+}
+
 static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 				      int mirror_num,
 				      struct btrfs_tree_parent_check *check)
@@ -4250,11 +4258,6 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	struct extent_io_tree *io_tree;
 	struct page *page = eb->pages[0];
 	struct extent_state *cached_state = NULL;
-	struct btrfs_bio_ctrl bio_ctrl = {
-		.opf = REQ_OP_READ,
-		.mirror_num = mirror_num,
-		.parent_check = check,
-	};
 	int ret;
 
 	ASSERT(!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags));
@@ -4282,18 +4285,10 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 		return 0;
 	}
 
-	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
-	eb->read_mirror = 0;
-	atomic_set(&eb->io_pages, 1);
-	check_buffer_tree_ref(eb);
-	bio_ctrl.end_io_func = end_bio_extent_readpage;
-
 	btrfs_subpage_clear_error(fs_info, page, eb->start, eb->len);
-
 	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
-	submit_extent_page(&bio_ctrl, eb->start, page, eb->len,
-			   eb->start - page_offset(page));
-	submit_one_bio(&bio_ctrl);
+
+	__read_extent_buffer_pages(eb, mirror_num, check);
 	if (wait != WAIT_COMPLETE) {
 		free_extent_state(cached_state);
 		return 0;
@@ -4314,11 +4309,6 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 	int locked_pages = 0;
 	int all_uptodate = 1;
 	int num_pages;
-	struct btrfs_bio_ctrl bio_ctrl = {
-		.opf = REQ_OP_READ,
-		.mirror_num = mirror_num,
-		.parent_check = check,
-	};
 
 	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
 		return 0;
@@ -4368,24 +4358,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 		goto unlock_exit;
 	}
 
-	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
-	eb->read_mirror = 0;
-	atomic_set(&eb->io_pages, num_pages);
-	/*
-	 * It is possible for release_folio to clear the TREE_REF bit before we
-	 * set io_pages. See check_buffer_tree_ref for a more detailed comment.
-	 */
-	check_buffer_tree_ref(eb);
-	bio_ctrl.end_io_func = end_bio_extent_readpage;
-	for (i = 0; i < num_pages; i++) {
-		page = eb->pages[i];
-
-		ClearPageError(page);
-		submit_extent_page(&bio_ctrl, page_offset(page), page,
-				   PAGE_SIZE, 0);
-	}
-
-	submit_one_bio(&bio_ctrl);
+	__read_extent_buffer_pages(eb, mirror_num, check);
 
 	if (wait != WAIT_COMPLETE)
 		return 0;
-- 
2.39.2

