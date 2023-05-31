Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91D1717692
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 08:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjEaGFt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 02:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbjEaGFr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 02:05:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C047E11D
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 23:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wEAELs01B9uaA8gjggTe5/25GZYdPh5V8YNv2Zsaohw=; b=dRTSfA34FzYxgCg1o210REG3gC
        KMGWH+VYux9pKyQ+zXFif2VAcBZDNgWggCca0201x9leuz/pBwh+x4w/+sjK75JPlnzy1g5Oxfkd+
        4OqrMKvb9dF46oRCZBA+4UfvnVmpI/Ht/RX+LBq/uYapgxDdRf7FMzWsUk5y2kYkilRnQTytti3v7
        OrkMxsYO0IRl7uqjhbobv0gPYd2IKaSGX3cm2yAt2YZ2L8pfGZh5n//3EiZD1dKaoF2gxVcM5naK5
        9+SQ3tLVnojy+f9oUVVaeqmwq/9wkn3VbXG1JItOum8Ds0OrfoQZsXWrNu8o+J+I1nFJoudw9LEkE
        GAf6VdAA==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4Ext-00GF8N-0k;
        Wed, 31 May 2023 06:05:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 12/16] btrfs: only call __extent_writepage_io from extent_write_locked_range
Date:   Wed, 31 May 2023 08:05:01 +0200
Message-Id: <20230531060505.468704-13-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531060505.468704-1-hch@lst.de>
References: <20230531060505.468704-1-hch@lst.de>
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

__extent_writepage does a lot of things that make no sense for
extent_write_locked_range, given that extent_write_locked_range itself is
called from __extent_writepage either directly or through a workqueue,
and all this work has already been done in the first invocation and the
pages haven't been unlocked since.  Just call __extent_writepage_io
directly instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 65 ++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f773ee12ce1cee..1da247e753b08a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -103,12 +103,6 @@ struct btrfs_bio_ctrl {
 	blk_opf_t opf;
 	btrfs_bio_end_io_t end_io_func;
 	struct writeback_control *wbc;
-
-	/*
-	 * Tell writepage not to lock the state bits for this range, it still
-	 * does the unlocking.
-	 */
-	bool extent_locked;
 };
 
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
@@ -1475,7 +1469,6 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 {
 	struct folio *folio = page_folio(page);
 	struct inode *inode = page->mapping->host;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	const u64 page_start = page_offset(page);
 	const u64 page_end = page_start + PAGE_SIZE - 1;
 	int ret;
@@ -1503,13 +1496,11 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 	if (ret < 0)
 		goto done;
 
-	if (!bio_ctrl->extent_locked) {
-		ret = writepage_delalloc(BTRFS_I(inode), page, bio_ctrl->wbc);
-		if (ret == 1)
-			return 0;
-		if (ret)
-			goto done;
-	}
+	ret = writepage_delalloc(BTRFS_I(inode), page, bio_ctrl->wbc);
+	if (ret == 1)
+		return 0;
+	if (ret)
+		goto done;
 
 	ret = __extent_writepage_io(BTRFS_I(inode), page, bio_ctrl, i_size, &nr);
 	if (ret == 1)
@@ -1525,21 +1516,7 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 	}
 	if (ret)
 		end_extent_writepage(page, ret, page_start, page_end);
-	if (bio_ctrl->extent_locked) {
-		struct writeback_control *wbc = bio_ctrl->wbc;
-
-		/*
-		 * If bio_ctrl->extent_locked, it's from extent_write_locked_range(),
-		 * the page can either be locked by lock_page() or
-		 * process_one_page().
-		 * Let btrfs_page_unlock_writer() handle both cases.
-		 */
-		ASSERT(wbc);
-		btrfs_page_unlock_writer(fs_info, page, wbc->range_start,
-					 wbc->range_end + 1 - wbc->range_start);
-	} else {
-		unlock_page(page);
-	}
+	unlock_page(page);
 	ASSERT(ret <= 0);
 	return ret;
 }
@@ -2239,10 +2216,10 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 	int first_error = 0;
 	int ret = 0;
 	struct address_space *mapping = inode->i_mapping;
-	struct page *page;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	const u32 sectorsize = fs_info->sectorsize;
+	loff_t i_size = i_size_read(inode);
 	u64 cur = start;
-	unsigned long nr_pages;
-	const u32 sectorsize = btrfs_sb(inode->i_sb)->sectorsize;
 	struct writeback_control wbc_writepages = {
 		.sync_mode	= WB_SYNC_ALL,
 		.range_start	= start,
@@ -2254,17 +2231,15 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 		/* We're called from an async helper function */
 		.opf = REQ_OP_WRITE | REQ_BTRFS_CGROUP_PUNT |
 			wbc_to_write_flags(&wbc_writepages),
-		.extent_locked = 1,
 	};
 
 	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(end + 1, sectorsize));
-	nr_pages = (round_up(end, PAGE_SIZE) - round_down(start, PAGE_SIZE)) >>
-		   PAGE_SHIFT;
-	wbc_writepages.nr_to_write = nr_pages * 2;
 
 	wbc_attach_fdatawrite_inode(&wbc_writepages, inode);
 	while (cur <= end) {
 		u64 cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
+		struct page *page;
+		int nr = 0;
 
 		page = find_get_page(mapping, cur >> PAGE_SHIFT);
 		/*
@@ -2275,12 +2250,25 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 		ASSERT(PageLocked(page));
 		ASSERT(PageDirty(page));
 		clear_page_dirty_for_io(page);
-		ret = __extent_writepage(page, &bio_ctrl);
-		ASSERT(ret <= 0);
+
+		ret = __extent_writepage_io(BTRFS_I(inode), page, &bio_ctrl,
+					    i_size, &nr);
+		if (ret == 1)
+			goto next_page;
+
+		/* Make sure the mapping tag for page dirty gets cleared. */
+		if (nr == 0) {
+			set_page_writeback(page);
+			end_page_writeback(page);
+		}
+		if (ret)
+			end_extent_writepage(page, ret, cur, cur_end);
+		btrfs_page_unlock_writer(fs_info, page, cur, cur_end + 1 - cur);
 		if (ret < 0) {
 			found_error = true;
 			first_error = ret;
 		}
+next_page:
 		put_page(page);
 		cur = cur_end + 1;
 	}
@@ -2301,7 +2289,6 @@ int extent_writepages(struct address_space *mapping,
 	struct btrfs_bio_ctrl bio_ctrl = {
 		.wbc = wbc,
 		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
-		.extent_locked = 0,
 	};
 
 	/*
-- 
2.39.2

