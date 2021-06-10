Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D563A23B5
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jun 2021 07:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFJFLV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Jun 2021 01:11:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59010 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhFJFLV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Jun 2021 01:11:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 03DD32199E
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Jun 2021 05:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623301765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z12CneU40+wn6Y7ciW0XGQBlnfqN859GfdckqL8wS6Y=;
        b=hXcIFFvec9+4tIiafHvsW8+WJuzUNG6TGrLYGlkjyOXQWfrxQRtk9CWVqk8OdpHlYQktOA
        5koRTL34IggokOM3TQB/PyJ0fAAPJQRjTC06zthZTEJtEe7+UQ6qRmsKYHJOFIC9iGQZ4F
        DD5Lm6FdYiobgX9LKi/EwuvjlEUNKrw=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 107C8A3B81
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Jun 2021 05:09:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 02/10] btrfs: defrag: extract the page preparation code into one helper
Date:   Thu, 10 Jun 2021 13:09:09 +0800
Message-Id: <20210610050917.105458-3-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210610050917.105458-1-wqu@suse.com>
References: <20210610050917.105458-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In cluster_pages_for_defrag(), we have complex code block inside one
for() loop.

The code block is to prepare one page for defrag, this will ensure:
- The page is locked and set up properly
- No ordered extent exists in the page range
- The page is uptodate
- The writeback has finished

This behavior is pretty common and will be reused by later defrag
rework.

So extract the code into its own helper, defrag_prepare_one_page(), for
later usage, and cleanup the code by a little.

Since we're here, also make the page check to be subpage compatible,
which means we will also check page::private, not only page->mapping.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 151 +++++++++++++++++++++++++++--------------------
 1 file changed, 86 insertions(+), 65 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 05af6f5ff3ff..a06ceb8fdf28 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1143,6 +1143,89 @@ static int should_defrag_range(struct inode *inode, u64 start, u32 thresh,
 	return ret;
 }
 
+/*
+ * Prepare one page to be defragged.
+ *
+ * This will ensure:
+ * - Returned page is locked and has been set up properly
+ * - No ordered extent exists in the page
+ * - The page is uptodate
+ * - The writeback has finished
+ */
+static struct page *defrag_prepare_one_page(struct btrfs_inode *inode,
+					    unsigned long index)
+{
+	struct address_space *mapping = inode->vfs_inode.i_mapping;
+	gfp_t mask = btrfs_alloc_write_mask(mapping);
+	u64 page_start = index << PAGE_SHIFT;
+	u64 page_end = page_start + PAGE_SIZE - 1;
+	struct extent_state *cached_state = NULL;
+	struct page *page;
+	int ret;
+
+again:
+	page = find_or_create_page(mapping, index, mask);
+	if (!page)
+		return ERR_PTR(-ENOMEM);
+
+	ret = set_page_extent_mapped(page);
+	if (ret < 0) {
+		unlock_page(page);
+		put_page(page);
+		return ERR_PTR(ret);
+	}
+
+	/* Wait for any exists ordered extent in the range */
+	while (1) {
+		struct btrfs_ordered_extent *ordered;
+
+		lock_extent_bits(&inode->io_tree, page_start, page_end,
+				 &cached_state);
+		ordered = btrfs_lookup_ordered_range(inode, page_start,
+						     PAGE_SIZE);
+		unlock_extent_cached(&inode->io_tree, page_start, page_end,
+				     &cached_state);
+		if (!ordered)
+			break;
+
+		unlock_page(page);
+		btrfs_start_ordered_extent(ordered, 1);
+		btrfs_put_ordered_extent(ordered);
+		lock_page(page);
+		/*
+		 * we unlocked the page above, so we need check if
+		 * it was released or not.
+		 */
+		if (page->mapping != mapping || !PagePrivate(page)) {
+			unlock_page(page);
+			put_page(page);
+			goto again;
+		}
+	}
+
+	/*
+	 * Now the page range has no ordered extent any more.
+	 * Read the page to make it uptodate.
+	 */
+	if (!PageUptodate(page)) {
+		btrfs_readpage(NULL, page);
+		lock_page(page);
+		if (page->mapping != mapping || !PagePrivate(page)) {
+			unlock_page(page);
+			put_page(page);
+			goto again;
+		}
+		if (!PageUptodate(page)) {
+			unlock_page(page);
+			put_page(page);
+			return ERR_PTR(-EIO);
+		}
+	}
+
+	wait_on_page_writeback(page);
+	return page;
+}
+
 /*
  * it doesn't do much good to defrag one or two pages
  * at a time.  This pulls in a nice chunk of pages
@@ -1170,11 +1253,8 @@ static int cluster_pages_for_defrag(struct inode *inode,
 	int ret;
 	int i;
 	int i_done;
-	struct btrfs_ordered_extent *ordered;
 	struct extent_state *cached_state = NULL;
-	struct extent_io_tree *tree;
 	struct extent_changeset *data_reserved = NULL;
-	gfp_t mask = btrfs_alloc_write_mask(inode->i_mapping);
 
 	file_end = (isize - 1) >> PAGE_SHIFT;
 	if (!isize || start_index > file_end)
@@ -1187,68 +1267,16 @@ static int cluster_pages_for_defrag(struct inode *inode,
 	if (ret)
 		return ret;
 	i_done = 0;
-	tree = &BTRFS_I(inode)->io_tree;
 
 	/* step one, lock all the pages */
 	for (i = 0; i < page_cnt; i++) {
 		struct page *page;
-again:
-		page = find_or_create_page(inode->i_mapping,
-					   start_index + i, mask);
-		if (!page)
-			break;
 
-		ret = set_page_extent_mapped(page);
-		if (ret < 0) {
-			unlock_page(page);
-			put_page(page);
+		page = defrag_prepare_one_page(BTRFS_I(inode), start_index + i);
+		if (IS_ERR(page)) {
+			ret = PTR_ERR(page);
 			break;
 		}
-
-		page_start = page_offset(page);
-		page_end = page_start + PAGE_SIZE - 1;
-		while (1) {
-			lock_extent_bits(tree, page_start, page_end,
-					 &cached_state);
-			ordered = btrfs_lookup_ordered_extent(BTRFS_I(inode),
-							      page_start);
-			unlock_extent_cached(tree, page_start, page_end,
-					     &cached_state);
-			if (!ordered)
-				break;
-
-			unlock_page(page);
-			btrfs_start_ordered_extent(ordered, 1);
-			btrfs_put_ordered_extent(ordered);
-			lock_page(page);
-			/*
-			 * we unlocked the page above, so we need check if
-			 * it was released or not.
-			 */
-			if (page->mapping != inode->i_mapping) {
-				unlock_page(page);
-				put_page(page);
-				goto again;
-			}
-		}
-
-		if (!PageUptodate(page)) {
-			btrfs_readpage(NULL, page);
-			lock_page(page);
-			if (!PageUptodate(page)) {
-				unlock_page(page);
-				put_page(page);
-				ret = -EIO;
-				break;
-			}
-		}
-
-		if (page->mapping != inode->i_mapping) {
-			unlock_page(page);
-			put_page(page);
-			goto again;
-		}
-
 		pages[i] = page;
 		i_done++;
 	}
@@ -1258,13 +1286,6 @@ static int cluster_pages_for_defrag(struct inode *inode,
 	if (!(inode->i_sb->s_flags & SB_ACTIVE))
 		goto out;
 
-	/*
-	 * so now we have a nice long stream of locked
-	 * and up to date pages, lets wait on them
-	 */
-	for (i = 0; i < i_done; i++)
-		wait_on_page_writeback(pages[i]);
-
 	page_start = page_offset(pages[0]);
 	page_end = page_offset(pages[i_done - 1]) + PAGE_SIZE;
 
-- 
2.32.0

