Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB16B3E24CE
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Aug 2021 10:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243416AbhHFINI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Aug 2021 04:13:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41106 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhHFINH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Aug 2021 04:13:07 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9B37220263
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Aug 2021 08:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628237571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o1GahysZC0JX8geY71kDAwLa/xdCGmYK8UhfS74WXr0=;
        b=QfaO9rQ2zYCCc3GLFg0EQp5BfT5Lhlo7dX8t76M/XOcycxgMbMPZBkN8gvom3I5xKQKRSI
        Umm7w9FPwS0uTPl1x740IJtj8P7paHifIN4BHyR6SaVIZHlEA+Muqihu78aVa/ld7nXsgA
        2nUQtzfjbUo3EkmdpFHkFaxRKUmLpxU=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D48A01399D
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Aug 2021 08:12:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 4AsNJQLvDGF6IQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Aug 2021 08:12:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 04/11] btrfs: defrag: extract the page preparation code into one helper
Date:   Fri,  6 Aug 2021 16:12:35 +0800
Message-Id: <20210806081242.257996-5-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806081242.257996-1-wqu@suse.com>
References: <20210806081242.257996-1-wqu@suse.com>
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

This behavior is pretty common and will be reused by later defrag
rework.

So extract the code into its own helper, defrag_prepare_one_page(), for
later usage, and cleanup the code by a little.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 149 ++++++++++++++++++++++++++++-------------------
 1 file changed, 88 insertions(+), 61 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 5545f33c6a98..c0639780f99c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1192,6 +1192,89 @@ static int should_defrag_range(struct inode *inode, u64 start, u32 thresh,
 	return ret;
 }
 
+/*
+ * Prepare one page to be defragged.
+ *
+ * This will ensure:
+ * - Returned page is locked and has been set up properly
+ * - No ordered extent exists in the page
+ * - The page is uptodate
+ *
+ * NOTE: Caller should also wait for page writeback after the cluster is
+ * prepared, here we don't do writeback wait for each page.
+ */
+static struct page *defrag_prepare_one_page(struct btrfs_inode *inode,
+					    pgoff_t index)
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
+	return page;
+}
+
 /*
  * it doesn't do much good to defrag one or two pages
  * at a time.  This pulls in a nice chunk of pages
@@ -1219,11 +1302,8 @@ static int cluster_pages_for_defrag(struct inode *inode,
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
@@ -1236,69 +1316,16 @@ static int cluster_pages_for_defrag(struct inode *inode,
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
-			if (page->mapping != inode->i_mapping ||
-			    !PagePrivate(page)) {
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
@@ -1309,8 +1336,8 @@ static int cluster_pages_for_defrag(struct inode *inode,
 		goto out;
 
 	/*
-	 * so now we have a nice long stream of locked
-	 * and up to date pages, lets wait on them
+	 * So now we have a nice long stream of locked and up to date pages,
+	 * lets wait on them.
 	 */
 	for (i = 0; i < i_done; i++)
 		wait_on_page_writeback(pages[i]);
-- 
2.32.0

