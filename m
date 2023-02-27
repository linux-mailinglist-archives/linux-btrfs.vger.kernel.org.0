Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49266A45BE
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 16:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjB0PRP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 10:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjB0PRM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 10:17:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D23222F6
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 07:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=sR/0krQYX01IahChtXona4cHQdB+FaoPy+K/bWIEyL0=; b=0LYrDcYukqCTK+3j8SJbiGBTu7
        TXqJHkpfK1xKU43ia1TDMtQZ1J1iU2o+NZXtj3fRPtDG11UVOv+AkbGuQAytKX2SLTyw7xktRSw0+
        uaUfdXrowaF9kICV7uk/b/B/uxuvKGFVuSprDIz5ZG5WXdsYP4/O8i2muXWBZ4PfLWS7X4pijKoik
        ClYJN53/peuIPh0w9aslu9nYiK6/FiiN1bm+NM5owhvWzXISAKKnO878skzybNPCa1ASsKQBZcFGJ
        bqXZtB9RtJXgVW6yZDMLeqB8cWsbsVtMDbQqwifFiwsc5BMtKrmH3Vgc6kRwowzU2wqoDM6K8SkCX
        r42jT6iQ==;
Received: from [136.36.117.140] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWfFR-00AAsb-F2; Mon, 27 Feb 2023 15:17:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 02/12] btrfs: remove the force_bio_submit to submit_extent_page
Date:   Mon, 27 Feb 2023 08:16:54 -0700
Message-Id: <20230227151704.1224688-3-hch@lst.de>
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

If force_bio_submit, submit_extent_page simply calls submit_one_bio as
the first thing.  This can just be moved to the only caller that sets
force_bio_submit to true.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 90842f5a978931..908a67cf5fb310 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1027,8 +1027,7 @@ static int submit_extent_page(blk_opf_t opf,
 			      struct btrfs_bio_ctrl *bio_ctrl,
 			      u64 disk_bytenr, struct page *page,
 			      size_t size, unsigned long pg_offset,
-			      enum btrfs_compression_type compress_type,
-			      bool force_bio_submit)
+			      enum btrfs_compression_type compress_type)
 {
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
 	unsigned int cur = pg_offset;
@@ -1040,9 +1039,6 @@ static int submit_extent_page(blk_opf_t opf,
 
 	ASSERT(bio_ctrl->end_io_func);
 
-	if (force_bio_submit)
-		submit_one_bio(bio_ctrl);
-
 	while (cur < pg_offset + size) {
 		u32 offset = cur - pg_offset;
 		int added;
@@ -1331,10 +1327,11 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			continue;
 		}
 
+		if (force_bio_submit)
+			submit_one_bio(bio_ctrl);
 		ret = submit_extent_page(REQ_OP_READ | read_flags, NULL,
 					 bio_ctrl, disk_bytenr, page, iosize,
-					 pg_offset, this_bio_flag,
-					 force_bio_submit);
+					 pg_offset, this_bio_flag);
 		if (ret) {
 			/*
 			 * We have to unlock the remaining range, or the page
@@ -1645,8 +1642,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		ret = submit_extent_page(op | write_flags, wbc,
 					 bio_ctrl, disk_bytenr,
 					 page, iosize,
-					 cur - page_offset(page),
-					 0, false);
+					 cur - page_offset(page), 0);
 		if (ret) {
 			has_error = true;
 			if (!saved_ret)
@@ -2139,7 +2135,7 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
 
 	ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
 			bio_ctrl, eb->start, page, eb->len,
-			eb->start - page_offset(page), 0, false);
+			eb->start - page_offset(page), 0);
 	if (ret) {
 		btrfs_subpage_clear_writeback(fs_info, page, eb->start, eb->len);
 		set_btree_ioerr(page, eb);
@@ -2180,7 +2176,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 		set_page_writeback(p);
 		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
 					 bio_ctrl, disk_bytenr, p,
-					 PAGE_SIZE, 0, 0, false);
+					 PAGE_SIZE, 0, 0);
 		if (ret) {
 			set_btree_ioerr(p, eb);
 			if (PageWriteback(p))
@@ -4448,7 +4444,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
 	ret = submit_extent_page(REQ_OP_READ, NULL, &bio_ctrl,
 				 eb->start, page, eb->len,
-				 eb->start - page_offset(page), 0, false);
+				 eb->start - page_offset(page), 0);
 	if (ret) {
 		/*
 		 * In the endio function, if we hit something wrong we will
@@ -4558,7 +4554,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 			ClearPageError(page);
 			err = submit_extent_page(REQ_OP_READ, NULL,
 					 &bio_ctrl, page_offset(page), page,
-					 PAGE_SIZE, 0, 0, false);
+					 PAGE_SIZE, 0, 0);
 			if (err) {
 				/*
 				 * We failed to submit the bio so it's the
-- 
2.39.1

