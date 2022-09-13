Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8505B6764
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Sep 2022 07:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiIMFbm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Sep 2022 01:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiIMFbj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Sep 2022 01:31:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588FF54C98
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 22:31:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 13D9633A09;
        Tue, 13 Sep 2022 05:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663047097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v7+i18u2ojLeolHK9TZtFcxpcd6xBX3f0TrkENX5HTc=;
        b=UjvCsV6tgncVRKHiZALekp/7gSlaaKj+dOVBD55fV2Qz1blwYmBmKajCf3xdyZhm29rU+F
        4cOrpBWyJxpz5qHjR8n2BKMt7N7QwVK7u9VrB+CSZ6TWeDDiJqhzcnLRj2p76LsNhLRpXi
        w8dUpwrEP20ZTo4Zi/fSNp67d2fdgSE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 210E313A86;
        Tue, 13 Sep 2022 05:31:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6Nb7NbcVIGO5VwAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 13 Sep 2022 05:31:35 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 3/3] btrfs: move end_io_func argument to btrfs_bio_ctrl structure
Date:   Tue, 13 Sep 2022 13:31:14 +0800
Message-Id: <fa087ebc73094a3384222dee8bc5a0f6fdee6e46.1663046855.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663046855.git.wqu@suse.com>
References: <cover.1663046855.git.wqu@suse.com>
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

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ddf1600ea32b..2499a01f7638 100644
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
@@ -3347,7 +3349,6 @@ static int alloc_new_bio(struct btrfs_inode *inode,
  * @size:	portion of page that we want to write to
  * @pg_offset:	offset of the new bio or to check whether we are adding
  *              a contiguous page to the previous one
- * @end_io_func:     end_io callback for new bio
  * @compress_type:   compress type for current bio
  *
  * The function will either add the page into the existing @bio_ctrl->bio,
@@ -3360,7 +3361,6 @@ static int submit_extent_page(blk_opf_t opf,
 			      struct btrfs_bio_ctrl *bio_ctrl,
 			      u64 disk_bytenr, struct page *page,
 			      size_t size, unsigned long pg_offset,
-			      btrfs_bio_end_io_t end_io_func,
 			      enum btrfs_compression_type compress_type,
 			      bool force_bio_submit)
 {
@@ -3372,6 +3372,9 @@ static int submit_extent_page(blk_opf_t opf,
 
 	ASSERT(pg_offset < PAGE_SIZE && size <= PAGE_SIZE &&
 	       pg_offset + size <= PAGE_SIZE);
+
+	ASSERT(bio_ctrl->end_io_func);
+
 	if (force_bio_submit)
 		submit_one_bio(bio_ctrl);
 
@@ -3382,7 +3385,7 @@ static int submit_extent_page(blk_opf_t opf,
 		/* Allocate new bio if needed */
 		if (!bio_ctrl->bio) {
 			ret = alloc_new_bio(inode, bio_ctrl, wbc, opf,
-					    end_io_func, disk_bytenr, offset,
+					    disk_bytenr, offset,
 					    page_offset(page) + cur,
 					    compress_type);
 			if (ret < 0)
@@ -3562,6 +3565,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			memzero_page(page, zero_offset, iosize);
 		}
 	}
+	bio_ctrl->end_io_func = end_bio_extent_readpage;
 	begin_page_read(fs_info, page);
 	while (cur <= end) {
 		unsigned long this_bio_flag = 0;
@@ -3677,8 +3681,8 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 
 		ret = submit_extent_page(REQ_OP_READ | read_flags, NULL,
 					 bio_ctrl, disk_bytenr, page, iosize,
-					 pg_offset, end_bio_extent_readpage,
-					 this_bio_flag, force_bio_submit);
+					 pg_offset, this_bio_flag,
+					 force_bio_submit);
 		if (ret) {
 			/*
 			 * We have to unlock the remaining range, or the page
@@ -3897,6 +3901,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	 */
 	wbc->nr_to_write--;
 
+	epd->bio_ctrl.end_io_func = end_bio_extent_writepage;
 	while (cur <= end) {
 		u64 disk_bytenr;
 		u64 em_end;
@@ -3993,7 +3998,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 					 &epd->bio_ctrl, disk_bytenr,
 					 page, iosize,
 					 cur - page_offset(page),
-					 end_bio_extent_writepage,
 					 0, false);
 		if (ret) {
 			has_error = true;
@@ -4486,10 +4490,11 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
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
@@ -4520,6 +4525,8 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 
 	prepare_eb_write(eb);
 
+	epd->bio_ctrl.end_io_func = end_bio_extent_buffer_writepage;
+
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = eb->pages[i];
@@ -4528,9 +4535,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
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
@@ -6780,13 +6785,14 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
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
@@ -6877,6 +6883,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 	 * set io_pages. See check_buffer_tree_ref for a more detailed comment.
 	 */
 	check_buffer_tree_ref(eb);
+	bio_ctrl.end_io_func = end_bio_extent_readpage;
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
 
@@ -6890,8 +6897,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
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

