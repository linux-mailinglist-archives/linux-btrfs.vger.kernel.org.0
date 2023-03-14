Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D816B8B20
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 07:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCNGSH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 02:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCNGSF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 02:18:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3689C83D0
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 23:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RgQmaP0oUs/FGyvrH4U0lCSwOBJyz0/By2BUIojaP/A=; b=wRN5YiLKsjN13l4HqOLddycgfj
        ikIJF6pMsBNxxCEtGXZm1MBz4DA6jLb1h1qCMbwfxW+1+UwJe92MDGJ0q9fe5NioMO4e7wFU6nH3Q
        OLH+6wpdudO1jn6x0HacpF5Rnl49GmxVYs7XWq6lYvz/ijjf1O4usU+mQdJaNPvXhkpfyF+Z0jMrg
        m6k1T5VZXIZxakdoPBl5bfjaLZr9hjAKjFOmuCVfgMBuihNV7CeIXV8oOqDioGJw/PH5rnrTFecaW
        EVnNna14sr63/SLXOUOByjy48q0u80ra3jfdAVgIOE/bVAbdkLbQuYd9fbzELGp96HetHfKWbABPU
        77sUlzXg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbxyx-009Arn-9R; Tue, 14 Mar 2023 06:18:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 21/21] btrfs: merge write_one_subpage_eb into write_one_eb
Date:   Tue, 14 Mar 2023 07:16:55 +0100
Message-Id: <20230314061655.245340-22-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314061655.245340-1-hch@lst.de>
References: <20230314061655.245340-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Most of the code in write_one_subpage_eb and write_one_eb is shared,
so merge the two functions into one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 77 ++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index da4ea02a56c8bf..14a8e1ecdf5f16 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1807,53 +1807,11 @@ static void prepare_eb_write(struct extent_buffer *eb)
 	}
 }
 
-/*
- * Unlike the work in write_one_eb(), we rely completely on extent locking.
- * Page locking is only utilized at minimum to keep the VMM code happy.
- */
-static void write_one_subpage_eb(struct extent_buffer *eb,
-				 struct writeback_control *wbc)
-{
-	struct btrfs_fs_info *fs_info = eb->fs_info;
-	struct page *page = eb->pages[0];
-	bool no_dirty_ebs = false;
-	struct btrfs_bio *bbio;
-
-	prepare_eb_write(eb);
-
-	/* clear_page_dirty_for_io() in subpage helper needs page locked */
-	lock_page(page);
-	btrfs_subpage_set_writeback(fs_info, page, eb->start, eb->len);
-
-	/* Check if this is the last dirty bit to update nr_written */
-	no_dirty_ebs = btrfs_subpage_clear_and_test_dirty(fs_info, page,
-							  eb->start, eb->len);
-	if (no_dirty_ebs)
-		clear_page_dirty_for_io(page);
-
-	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
-			       REQ_OP_WRITE | REQ_META | wbc_to_write_flags(wbc),
-			       BTRFS_I(eb->fs_info->btree_inode),
-			       extent_buffer_write_end_io, eb);
-	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
-	bbio->file_offset = eb->start;
-	__bio_add_page(&bbio->bio, page, eb->len, eb->start - page_offset(page));
-	unlock_page(page);
-	btrfs_submit_bio(bbio, 0);
-
-	/*
-	 * Submission finished without problem, if no range of the page is
-	 * dirty anymore, we have submitted a page.  Update nr_written in wbc.
-	 */
-	if (no_dirty_ebs)
-		wbc->nr_to_write--;
-}
-
 static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 					    struct writeback_control *wbc)
 {
+	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct btrfs_bio *bbio;
-	int i, num_pages;
 
 	prepare_eb_write(eb);
 
@@ -1863,17 +1821,32 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 			       extent_buffer_write_end_io, eb);
 	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
 	bbio->file_offset = eb->start;
-
-	num_pages = num_extent_pages(eb);
-	for (i = 0; i < num_pages; i++) {
-		struct page *p = eb->pages[i];
+	if (fs_info->nodesize < PAGE_SIZE) {
+		struct page *p = eb->pages[0];
 
 		lock_page(p);
-		clear_page_dirty_for_io(p);
-		set_page_writeback(p);
-		__bio_add_page(&bbio->bio, p, PAGE_SIZE, 0);
-		wbc->nr_to_write--;
+		btrfs_subpage_set_writeback(fs_info, p, eb->start, eb->len);
+		if (btrfs_subpage_clear_and_test_dirty(fs_info, p, eb->start,
+						       eb->len)) {
+			clear_page_dirty_for_io(p);
+			wbc->nr_to_write--;
+		}
+		__bio_add_page(&bbio->bio, p, eb->len,
+			       eb->start - page_offset(p));
 		unlock_page(p);
+	} else {
+		int i;
+
+		for (i = 0; i < num_extent_pages(eb); i++) {
+			struct page *p = eb->pages[i];
+
+			lock_page(p);
+			clear_page_dirty_for_io(p);
+			set_page_writeback(p);
+			__bio_add_page(&bbio->bio, p, PAGE_SIZE, 0);
+			wbc->nr_to_write--;
+			unlock_page(p);
+		}
 	}
 	btrfs_submit_bio(bbio, 0);
 }
@@ -1945,7 +1918,7 @@ static int submit_eb_subpage(struct page *page, struct writeback_control *wbc)
 			continue;
 
 		if (lock_extent_buffer_for_io(eb, wbc)) {
-			write_one_subpage_eb(eb, wbc);
+			write_one_eb(eb, wbc);
 			submitted++;
 		}
 		free_extent_buffer(eb);
-- 
2.39.2

