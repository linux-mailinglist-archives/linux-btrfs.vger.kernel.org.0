Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F78502BF0
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Apr 2022 16:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354530AbiDOOgG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Apr 2022 10:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245195AbiDOOgF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Apr 2022 10:36:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC75B99EF9
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 07:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jT3VwxTO3tRmPC9G/yF8t35uIFGPy1CavPMKxBxlzOI=; b=H48LW/K9z+Q9iy4XnUy0sk6mHv
        yiAc5P2iuaU/Y3oHEfdXgS3J60+cnkRaxErEw1VldAoXtpF12aNY2mQkiAeNs71ADgDeonOU7mdKr
        Iht3jJ6+H1wfrwC3+xvSr4AVZWwOd5vmAoU83qxrqFaJw8MAZLnTNCzKcZb+PbwDSCbmGjc1tvCmO
        aQFmA8YJlWoVoJafcax5jdM2UsX1ynu9YmH8HOOa8TUvTfDizcFbhXkEseY/6e+Gmv71CYrJ13L0N
        Ulr3xFSQfoIuQYKWyZKlxRFrewlZK+atAUNoXoxr47HYU0cHdVW4HNaPsKfs1cgYcoKq+e7sNPlcZ
        TuQztjfA==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfN0v-00AMru-NB; Fri, 15 Apr 2022 14:33:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs: move btrfs_readpage to extent_io.c
Date:   Fri, 15 Apr 2022 16:33:24 +0200
Message-Id: <20220415143328.349010-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220415143328.349010-1-hch@lst.de>
References: <20220415143328.349010-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Keep btrfs_readpage next to btrfs_do_readpage and the other address
space operations.  This allows to keep submit_one_bio and
struct btrfs_bio_ctrl file local in extent_io.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ctree.h     |  1 -
 fs/btrfs/extent_io.c | 36 ++++++++++++++++++++++++++++++++++--
 fs/btrfs/extent_io.h | 16 +---------------
 fs/btrfs/inode.c     | 20 --------------------
 4 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 55dee124ee447..0fd3a21cd5a89 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3312,7 +3312,6 @@ void btrfs_split_delalloc_extent(struct inode *inode,
 				 struct extent_state *orig, u64 split);
 void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end);
 vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf);
-int btrfs_readpage(struct file *file, struct page *page);
 void btrfs_evict_inode(struct inode *inode);
 int btrfs_write_inode(struct inode *inode, struct writeback_control *wbc);
 struct inode *btrfs_alloc_inode(struct super_block *sb);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 779123e68d7b6..fe146ba21415e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -137,6 +137,17 @@ struct tree_entry {
 	struct rb_node rb_node;
 };
 
+/*
+ * Structure to record info about the bio being assembled, and other info like
+ * how many bytes are there before stripe/ordered extent boundary.
+ */
+struct btrfs_bio_ctrl {
+	struct bio *bio;
+	unsigned long bio_flags;
+	u32 len_to_stripe_boundary;
+	u32 len_to_oe_boundary;
+};
+
 struct extent_page_data {
 	struct btrfs_bio_ctrl bio_ctrl;
 	/* tells writepage not to lock the state bits for this range
@@ -166,7 +177,8 @@ static int add_extent_changeset(struct extent_state *state, u32 bits,
 	return ret;
 }
 
-void submit_one_bio(struct bio *bio, int mirror_num, unsigned long bio_flags)
+static void submit_one_bio(struct bio *bio, int mirror_num,
+		unsigned long bio_flags)
 {
 	struct extent_io_tree *tree = bio->bi_private;
 
@@ -3604,7 +3616,7 @@ __get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
  * XXX JDM: This needs looking at to ensure proper page locking
  * return 0 on success, otherwise return error
  */
-int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
+static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		      struct btrfs_bio_ctrl *bio_ctrl,
 		      unsigned int read_flags, u64 *prev_em_start)
 {
@@ -3793,6 +3805,26 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 	return ret;
 }
 
+int btrfs_readpage(struct file *file, struct page *page)
+{
+	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
+	u64 start = page_offset(page);
+	u64 end = start + PAGE_SIZE - 1;
+	struct btrfs_bio_ctrl bio_ctrl = { 0 };
+	int ret;
+
+	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
+
+	ret = btrfs_do_readpage(page, NULL, &bio_ctrl, 0, NULL);
+	/*
+	 * If btrfs_do_readpage() failed we will want to submit the assembled
+	 * bio to do the cleanup.
+	 */
+	if (bio_ctrl.bio)
+		submit_one_bio(bio_ctrl.bio, 0, bio_ctrl.bio_flags);
+	return ret;
+}
+
 static inline void contiguous_readpages(struct page *pages[], int nr_pages,
 					u64 start, u64 end,
 					struct extent_map **em_cached,
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 9a283b2358b83..c94df8e2ab9d6 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -102,17 +102,6 @@ struct extent_buffer {
 #endif
 };
 
-/*
- * Structure to record info about the bio being assembled, and other info like
- * how many bytes are there before stripe/ordered extent boundary.
- */
-struct btrfs_bio_ctrl {
-	struct bio *bio;
-	unsigned long bio_flags;
-	u32 len_to_stripe_boundary;
-	u32 len_to_oe_boundary;
-};
-
 /*
  * Structure to record how many bytes and which ranges are set/cleared
  */
@@ -178,10 +167,7 @@ typedef struct extent_map *(get_extent_t)(struct btrfs_inode *inode,
 int try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);
 
-void submit_one_bio(struct bio *bio, int mirror_num, unsigned long bio_flags);
-int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
-		      struct btrfs_bio_ctrl *bio_ctrl,
-		      unsigned int read_flags, u64 *prev_em_start);
+int btrfs_readpage(struct file *file, struct page *page);
 int extent_write_full_page(struct page *page, struct writeback_control *wbc);
 int extent_write_locked_range(struct inode *inode, u64 start, u64 end);
 int extent_writepages(struct address_space *mapping,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 29879fb257d5d..f2fb2bfc2f9a2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8147,26 +8147,6 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	return extent_fiemap(BTRFS_I(inode), fieinfo, start, len);
 }
 
-int btrfs_readpage(struct file *file, struct page *page)
-{
-	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
-	u64 start = page_offset(page);
-	u64 end = start + PAGE_SIZE - 1;
-	struct btrfs_bio_ctrl bio_ctrl = { 0 };
-	int ret;
-
-	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
-
-	ret = btrfs_do_readpage(page, NULL, &bio_ctrl, 0, NULL);
-	/*
-	 * If btrfs_do_readpage() failed we will want to submit the assembled
-	 * bio to do the cleanup.
-	 */
-	if (bio_ctrl.bio)
-		submit_one_bio(bio_ctrl.bio, 0, bio_ctrl.bio_flags);
-	return ret;
-}
-
 static int btrfs_writepage(struct page *page, struct writeback_control *wbc)
 {
 	struct inode *inode = page->mapping->host;
-- 
2.30.2

