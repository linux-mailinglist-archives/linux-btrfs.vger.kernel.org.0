Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9955770D6FB
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 10:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbjEWIQD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 04:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbjEWIPd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 04:15:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94803139
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 01:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RoSJQO1PQ0NgKGGai55SkC4YaLO/ncIk/jICftRuYcM=; b=PKrGG1LDDThdTRtEMbhahZfnRw
        aoB5h4J+7r0a5y5JUtirnXu3nsGqIS3g63Crc1jsGHYUkBoFYeTXal9NN7deuu2zlgUDu0XdRN5KJ
        sQu6iVgwDn7qNkpq7CF1jYksTb3eXVGY+2yCuY0BKlif8LxFN4zTmT9rGfu2lJe9zEjHGMb2hg8TX
        CQN1NN4abBOmLTIrMKTB7BaKkjSkYoppSJML1f8J7fLzLae1dz0TBaj5dllJ/zjEMzwwnsVa5ZG2j
        ETOWpb4xdMHwPU8jVlyowLGStMQiC8aJW0sgY9PSXgg7QsYQ0XE8pPbaptRH43XifWOitDfJuZ/8r
        h5XU5+YQ==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1N9G-009OUH-0w;
        Tue, 23 May 2023 08:13:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/16] btrfs: don't fail writeback when allocating the compression context fails
Date:   Tue, 23 May 2023 10:13:11 +0200
Message-Id: <20230523081322.331337-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523081322.331337-1-hch@lst.de>
References: <20230523081322.331337-1-hch@lst.de>
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

If cow_file_range_async fails to allocate the asynchronous writeback
context, it currently returns an error and entirely fails the writeback.
This is not a good idea as a writeback failure is a non-temporary error
condition that will make the file system unusuable.  Just fall back to
synchronous uncompressed writeback instead.  This requires us to delay
setting the BTRFS_INODE_HAS_ASYNC_EXTENT flag until we've committed to
the async writeback.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 74 ++++++++++++++++++------------------------------
 1 file changed, 28 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2e83fb22505261..0741294ce3234b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1720,58 +1720,36 @@ static noinline void async_cow_free(struct btrfs_work *work)
 		kvfree(async_cow);
 }
 
-static int cow_file_range_async(struct btrfs_inode *inode,
-				struct writeback_control *wbc,
-				struct page *locked_page,
-				u64 start, u64 end, int *page_started,
-				unsigned long *nr_written)
+static bool cow_file_range_async(struct btrfs_inode *inode,
+				 struct writeback_control *wbc,
+				 struct page *locked_page,
+				 u64 start, u64 end, int *page_started,
+				 unsigned long *nr_written)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct cgroup_subsys_state *blkcg_css = wbc_blkcg_css(wbc);
 	struct async_cow *ctx;
 	struct async_chunk *async_chunk;
 	unsigned long nr_pages;
-	u64 cur_end;
 	u64 num_chunks = DIV_ROUND_UP(end - start, SZ_512K);
 	int i;
-	bool should_compress;
 	unsigned nofs_flag;
 	const blk_opf_t write_flags = wbc_to_write_flags(wbc);
 
-	unlock_extent(&inode->io_tree, start, end, NULL);
-
-	if (inode->flags & BTRFS_INODE_NOCOMPRESS &&
-	    !btrfs_test_opt(fs_info, FORCE_COMPRESS)) {
-		num_chunks = 1;
-		should_compress = false;
-	} else {
-		should_compress = true;
-	}
-
 	nofs_flag = memalloc_nofs_save();
 	ctx = kvmalloc(struct_size(ctx, chunks, num_chunks), GFP_KERNEL);
 	memalloc_nofs_restore(nofs_flag);
+	if (!ctx)
+		return false;
 
-	if (!ctx) {
-		unsigned clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC |
-			EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
-			EXTENT_DO_ACCOUNTING;
-		unsigned long page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK |
-					 PAGE_END_WRITEBACK | PAGE_SET_ERROR;
-
-		extent_clear_unlock_delalloc(inode, start, end, locked_page,
-					     clear_bits, page_ops);
-		return -ENOMEM;
-	}
+	unlock_extent(&inode->io_tree, start, end, NULL);
+	set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT, &inode->runtime_flags);
 
 	async_chunk = ctx->chunks;
 	atomic_set(&ctx->num_chunks, num_chunks);
 
 	for (i = 0; i < num_chunks; i++) {
-		if (should_compress)
-			cur_end = min(end, start + SZ_512K - 1);
-		else
-			cur_end = end;
+		u64 cur_end = min(end, start + SZ_512K - 1);
 
 		/*
 		 * igrab is called higher up in the call chain, take only the
@@ -1832,7 +1810,7 @@ static int cow_file_range_async(struct btrfs_inode *inode,
 		start = cur_end + 1;
 	}
 	*page_started = 1;
-	return 0;
+	return true;
 }
 
 static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
@@ -2413,8 +2391,8 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 		u64 start, u64 end, int *page_started, unsigned long *nr_written,
 		struct writeback_control *wbc)
 {
-	int ret;
 	const bool zoned = btrfs_is_zoned(inode->root->fs_info);
+	int ret = 0;
 
 	/*
 	 * The range must cover part of the @locked_page, or the returned
@@ -2434,19 +2412,23 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 		ASSERT(!zoned || btrfs_is_data_reloc_root(inode->root));
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
 					 page_started, nr_written);
-	} else if (!btrfs_inode_can_compress(inode) ||
-		   !inode_need_compress(inode, start, end)) {
-		if (zoned)
-			ret = run_delalloc_zoned(inode, locked_page, start, end,
-						 page_started, nr_written);
-		else
-			ret = cow_file_range(inode, locked_page, start, end,
-					     page_started, nr_written, 1, NULL);
-	} else {
-		set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT, &inode->runtime_flags);
-		ret = cow_file_range_async(inode, wbc, locked_page, start, end,
-					   page_started, nr_written);
+		goto out;
 	}
+
+	if (btrfs_inode_can_compress(inode) &&
+	    inode_need_compress(inode, start, end) &&
+	    cow_file_range_async(inode, wbc, locked_page, start,
+				 end, page_started, nr_written))
+		goto out;
+
+	if (zoned)
+		ret = run_delalloc_zoned(inode, locked_page, start, end,
+					 page_started, nr_written);
+	else
+		ret = cow_file_range(inode, locked_page, start, end,
+				     page_started, nr_written, 1, NULL);
+
+out:
 	ASSERT(ret <= 0);
 	if (ret)
 		btrfs_cleanup_ordered_extents(inode, locked_page, start,
-- 
2.39.2

