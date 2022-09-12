Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B4F5B5488
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 08:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiILG3H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 02:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiILG3C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 02:29:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28630239
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Sep 2022 23:29:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CFEF821F7E
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 06:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662964139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HRkl2j++ssa+viZNPupIPSvJ+GC46lXXqnOp65t1dSg=;
        b=ue2dPtHlJGsTCNze3fqhka1lwPdgpHGuadElTV7LQl5H3e5Q4L638uxiBbWWx6HzzpY+WF
        j/44SMVZhKp0xXkgCLI06znhI3g/VJDhWFrF2JgGrcm36n5ypk2n0TyX04tF8RKTb5+3tA
        /vhqSQA5jYhI1exL9HyNJgXwQsMczh4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25BCB139E0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 06:28:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gHUPN6rRHmMAdgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 06:28:58 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: move end_io_func argument to btrfs_bio_ctrl structure
Date:   Mon, 12 Sep 2022 14:28:39 +0800
Message-Id: <6addc5a6053cabb5c898cead3b0bf41634c8dd4f.1662963954.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1662963954.git.wqu@suse.com>
References: <cover.1662963954.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For function submit_extent_page() and alloc_new_bio(), we have an
argument @end_io_func to indicate the end io function.

But that function never change inside any call site of them, thus no
need to pass the pointer around everywhere.

There is a better match for the lifespan of all the call sites, as we
have btrfs_bio_ctrl structure, thus we can put the endio function
pointer there, and grab the pointer every time we allocate a new bio.

Also add extra ASSERT()s to make sure every call site of
submit_extent_page() and alloc_new_bio() has properly set the pointer
inside btrfs_bio_ctrl.

This removes one argument from the already long argument list of
submit_extent_page().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index dd0697555385..e88d8a7a70d9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -147,6 +147,7 @@ struct btrfs_bio_ctrl {
 	enum btrfs_compression_type compress_type;
 	u32 len_to_stripe_boundary;
 	u32 len_to_oe_boundary;
+	btrfs_bio_end_io_t end_io_func;
 };
 
 struct extent_page_data {
@@ -3278,7 +3279,6 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 			 struct btrfs_bio_ctrl *bio_ctrl,
 			 struct writeback_control *wbc,
 			 blk_opf_t opf,
-			 btrfs_bio_end_io_t end_io_func,
 			 u64 disk_bytenr, u32 offset, u64 file_offset,
 			 enum btrfs_compression_type compress_type)
 {
@@ -3286,7 +3286,9 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	struct bio *bio;
 	int ret;
 
-	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, end_io_func, NULL);
+	ASSERT(bio_ctrl->end_io_func);
+
+	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, bio_ctrl->end_io_func, NULL);
 	/*
 	 * For compressed page range, its disk_bytenr is always @disk_bytenr
 	 * passed in, no matter if we have added any range into previous bio.
@@ -3358,7 +3360,6 @@ static int submit_extent_page(blk_opf_t opf,
 			      struct btrfs_bio_ctrl *bio_ctrl,
 			      u64 disk_bytenr, struct page *page,
 			      size_t size, unsigned long pg_offset,
-			      btrfs_bio_end_io_t end_io_func,
 			      enum btrfs_compression_type compress_type,
 			      bool force_bio_submit)
 {
@@ -3370,6 +3371,9 @@ static int submit_extent_page(blk_opf_t opf,
 
 	ASSERT(pg_offset < PAGE_SIZE && size <= PAGE_SIZE &&
 	       pg_offset + size <= PAGE_SIZE);
+
+	ASSERT(bio_ctrl->end_io_func);
+
 	if (force_bio_submit)
 		submit_one_bio(bio_ctrl);
 
@@ -3380,7 +3384,7 @@ static int submit_extent_page(blk_opf_t opf,
 		/* Allocate new bio if needed */
 		if (!bio_ctrl->bio) {
 			ret = alloc_new_bio(inode, bio_ctrl, wbc, opf,
-					    end_io_func, disk_bytenr, offset,
+					    disk_bytenr, offset,
 					    page_offset(page) + cur,
 					    compress_type);
 			if (ret < 0)
@@ -3560,6 +3564,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			memzero_page(page, zero_offset, iosize);
 		}
 	}
+	bio_ctrl->end_io_func = end_bio_extent_readpage;
 	begin_page_read(fs_info, page);
 	while (cur <= end) {
 		unsigned long this_bio_flag = 0;
@@ -3675,8 +3680,8 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 
 		ret = submit_extent_page(REQ_OP_READ | read_flags, NULL,
 					 bio_ctrl, disk_bytenr, page, iosize,
-					 pg_offset, end_bio_extent_readpage,
-					 this_bio_flag, force_bio_submit);
+					 pg_offset, this_bio_flag,
+					 force_bio_submit);
 		if (ret) {
 			/*
 			 * We have to unlock the remaining range, or the page
@@ -3895,6 +3900,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	 */
 	wbc->nr_to_write--;
 
+	epd->bio_ctrl.end_io_func = end_bio_extent_writepage;
 	while (cur <= end) {
 		u64 disk_bytenr;
 		u64 em_end;
@@ -3991,7 +3997,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 					 &epd->bio_ctrl, disk_bytenr,
 					 page, iosize,
 					 cur - page_offset(page),
-					 end_bio_extent_writepage,
 					 0, false);
 		if (ret) {
 			has_error = true;
@@ -4484,10 +4489,11 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
 	if (no_dirty_ebs)
 		clear_page_dirty_for_io(page);
 
+	epd->bio_ctrl.end_io_func = end_bio_subpage_eb_writepage;
+
 	ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
 			&epd->bio_ctrl, eb->start, page, eb->len,
-			eb->start - page_offset(page),
-			end_bio_subpage_eb_writepage, 0, false);
+			eb->start - page_offset(page), 0, false);
 	if (ret) {
 		btrfs_subpage_clear_writeback(fs_info, page, eb->start, eb->len);
 		set_btree_ioerr(page, eb);
@@ -4518,6 +4524,8 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 
 	prepare_eb_write(eb);
 
+	epd->bio_ctrl.end_io_func = end_bio_extent_buffer_writepage;
+
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = eb->pages[i];
@@ -4526,9 +4534,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 		set_page_writeback(p);
 		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
 					 &epd->bio_ctrl, disk_bytenr, p,
-					 PAGE_SIZE, 0,
-					 end_bio_extent_buffer_writepage,
-					 0, false);
+					 PAGE_SIZE, 0, 0, false);
 		if (ret) {
 			set_btree_ioerr(p, eb);
 			if (PageWriteback(p))
@@ -6778,13 +6784,14 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	eb->read_mirror = 0;
 	atomic_set(&eb->io_pages, 1);
 	check_buffer_tree_ref(eb);
+	bio_ctrl.end_io_func = end_bio_extent_readpage;
+
 	btrfs_subpage_clear_error(fs_info, page, eb->start, eb->len);
 
 	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
 	ret = submit_extent_page(REQ_OP_READ, NULL, &bio_ctrl,
 				 eb->start, page, eb->len,
-				 eb->start - page_offset(page),
-				 end_bio_extent_readpage, 0, true);
+				 eb->start - page_offset(page), 0, true);
 	if (ret) {
 		/*
 		 * In the endio function, if we hit something wrong we will
@@ -6875,6 +6882,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 	 * set io_pages. See check_buffer_tree_ref for a more detailed comment.
 	 */
 	check_buffer_tree_ref(eb);
+	bio_ctrl.end_io_func = end_bio_extent_readpage;
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
 
@@ -6888,8 +6896,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 			ClearPageError(page);
 			err = submit_extent_page(REQ_OP_READ, NULL,
 					 &bio_ctrl, page_offset(page), page,
-					 PAGE_SIZE, 0, end_bio_extent_readpage,
-					 0, false);
+					 PAGE_SIZE, 0, 0, false);
 			if (err) {
 				/*
 				 * We failed to submit the bio so it's the
-- 
2.37.3

