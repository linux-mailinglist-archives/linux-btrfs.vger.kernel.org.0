Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAA877BF53
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 19:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjHNRwh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 13:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjHNRwX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 13:52:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2985B10D5
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 10:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=OvnjAgD2GLMyaGyicTvQ3bN/q4pHiJcEXmwwrdSmzz0=; b=ilipptXo1eacYnF/sqYAu6Fllr
        L+o8PqsgriJ5MRB95YEReNprnEy+pfoJtyrdwvhyMMfXFbw1rI0xlDCMBjbkNZIu6NzaoYkYxzsRm
        zaL05AOu0iffkIZSiXAqxzSBhZOaui22KrQvidXzhrSVTBW5Vl85NGkeTZWios7CRgRO1TFJC5Oh2
        /CqwkcFJUcOTBMttwgctlToHvSJGFUxwfr4rvBaJUFvvYRp0MFzZibGUgLTki8cO6V7XVqxpoK8Bk
        ULgwM57QnafWbdTU7Ey/YU/5Eu7TUiSOMFQ2BevrDxSkZT+dTPaZxVCK47OIkBFeoXa2o52/IXx0u
        gr0Qs77A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVbje-003Ovh-9z; Mon, 14 Aug 2023 17:52:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: Convert btrfs_read_merkle_tree_page() to use a folio
Date:   Mon, 14 Aug 2023 18:52:08 +0100
Message-Id: <20230814175208.810785-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Remove a number of hidden calls to compound_head() by using a folio
throughout.  Also follow core kernel code style by adding the folio to
the page cache immediately after allocation instead of doing the read
first, then adding it to the page cache.  This ordering makes subsequent
readers block waiting for the first reader instead of duplicating the
work only to throw it away when they find out they lost the race.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/verity.c | 62 +++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index c5ff16f9e9fa..04d85db9bb58 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -715,7 +715,7 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
 						pgoff_t index,
 						unsigned long num_ra_pages)
 {
-	struct page *page;
+	struct folio *folio;
 	u64 off = (u64)index << PAGE_SHIFT;
 	loff_t merkle_pos = merkle_file_pos(inode);
 	int ret;
@@ -726,29 +726,38 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
 		return ERR_PTR(-EFBIG);
 	index += merkle_pos >> PAGE_SHIFT;
 again:
-	page = find_get_page_flags(inode->i_mapping, index, FGP_ACCESSED);
-	if (page) {
-		if (PageUptodate(page))
-			return page;
+	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
+	if (!IS_ERR(folio)) {
+		if (folio_test_uptodate(folio))
+			goto out;
 
-		lock_page(page);
+		folio_lock(folio);
 		/*
-		 * We only insert uptodate pages, so !Uptodate has to be
-		 * an error
+		 * If it's not uptodate after we have the lock, we got a
+		 * read error.
 		 */
-		if (!PageUptodate(page)) {
-			unlock_page(page);
-			put_page(page);
+		if (!folio_test_uptodate(folio)) {
+			folio_unlock(folio);
+			folio_put(folio);
 			return ERR_PTR(-EIO);
 		}
-		unlock_page(page);
-		return page;
+		folio_unlock(folio);
+		goto out;
 	}
 
-	page = __page_cache_alloc(mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS));
-	if (!page)
+	folio = filemap_alloc_folio(mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS), 0);
+	if (!folio)
 		return ERR_PTR(-ENOMEM);
 
+	ret = filemap_add_folio(inode->i_mapping, folio, index, GFP_NOFS);
+	if (ret) {
+		folio_put(folio);
+		/* Did someone else insert a folio here? */
+		if (ret == -EEXIST)
+			goto again;
+		return ERR_PTR(ret);
+	}
+
 	/*
 	 * Merkle item keys are indexed from byte 0 in the merkle tree.
 	 * They have the form:
@@ -756,28 +765,19 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
 	 * [ inode objectid, BTRFS_MERKLE_ITEM_KEY, offset in bytes ]
 	 */
 	ret = read_key_bytes(BTRFS_I(inode), BTRFS_VERITY_MERKLE_ITEM_KEY, off,
-			     page_address(page), PAGE_SIZE, page);
+			     folio_address(folio), PAGE_SIZE, &folio->page);
 	if (ret < 0) {
-		put_page(page);
+		folio_put(folio);
 		return ERR_PTR(ret);
 	}
 	if (ret < PAGE_SIZE)
-		memzero_page(page, ret, PAGE_SIZE - ret);
+		folio_zero_segment(folio, ret, PAGE_SIZE);
 
-	SetPageUptodate(page);
-	ret = add_to_page_cache_lru(page, inode->i_mapping, index, GFP_NOFS);
+	folio_mark_uptodate(folio);
+	folio_unlock(folio);
 
-	if (!ret) {
-		/* Inserted and ready for fsverity */
-		unlock_page(page);
-	} else {
-		put_page(page);
-		/* Did someone race us into inserting this page? */
-		if (ret == -EEXIST)
-			goto again;
-		page = ERR_PTR(ret);
-	}
-	return page;
+out:
+	return folio_file_page(folio, index);
 }
 
 /*
-- 
2.40.1

