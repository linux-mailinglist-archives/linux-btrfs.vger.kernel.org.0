Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527C8393B63
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 May 2021 04:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbhE1CaH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 May 2021 22:30:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:60698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236098AbhE1CaD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 May 2021 22:30:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622168908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9HOOQkAqvG4Gp67AC3YsfALV+w+2WDNa8jMaus2Bc64=;
        b=TJBHoi8YBntQPISe6NtHL/e1HZnT2r5mXsAfHhhdnUC5VCM3mCWl9XzJNiPWZdnrzKS6lv
        MYoBo5usRV5ADU1T9CrM3MJRSCqS8MYGfO1YHHE9ftzYck7LbDFCKCJ35P54vrJn2zyAJP
        mQmcu7ESGSyA6jATk3KZojSn+OprS4g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AB0D4AD7F
        for <linux-btrfs@vger.kernel.org>; Fri, 28 May 2021 02:28:28 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/7] btrfs: defrag: extract the page preparation code into one helper
Date:   Fri, 28 May 2021 10:28:16 +0800
Message-Id: <20210528022821.81386-3-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528022821.81386-1-wqu@suse.com>
References: <20210528022821.81386-1-wqu@suse.com>
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

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 151 +++++++++++++++++++++++++++--------------------
 1 file changed, 86 insertions(+), 65 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 67ef9c535eb5..ba69991bca10 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1144,6 +1144,89 @@ static int should_defrag_range(struct inode *inode, u64 start, u32 thresh,
 	return ret;
 }
 
+/*
+ * Prepare one page to be defraged.
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
+	gfp_t mask = btrfs_alloc_write_mask(inode->vfs_inode.i_mapping);
+	u64 page_start = index << PAGE_SHIFT;
+	u64 page_end = page_start + PAGE_SIZE - 1;
+	struct extent_state *cached_state = NULL;
+	struct page *page;
+	int ret;
+
+again:
+	page = find_or_create_page(inode->vfs_inode.i_mapping, index, mask);
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
+		if (page->mapping != inode->vfs_inode.i_mapping ||
+		    !PagePrivate(page)) {
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
+		if (page->mapping != inode->vfs_inode.i_mapping ||
+		    !PagePrivate(page)) {
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
+	wait_on_page_writeback(page);
+	return page;
+}
+
 /*
  * it doesn't do much good to defrag one or two pages
  * at a time.  This pulls in a nice chunk of pages
@@ -1172,11 +1255,8 @@ static int cluster_pages_for_defrag(struct inode *inode,
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
@@ -1189,68 +1269,16 @@ static int cluster_pages_for_defrag(struct inode *inode,
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
-			if (page->mapping != inode->i_mapping || !PagePrivate(page)) {
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
-		if (page->mapping != inode->i_mapping || !PagePrivate(page)) {
-			unlock_page(page);
-			put_page(page);
-			goto again;
-		}
-
 		pages[i] = page;
 		i_done++;
 	}
@@ -1260,13 +1288,6 @@ static int cluster_pages_for_defrag(struct inode *inode,
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
2.31.1

