Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E2377BE9F
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 19:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjHNREL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 13:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjHNREA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 13:04:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F02E63
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=hd6k7GBQ7+Qasf0kpw2AKunZfGOV7oFj0NiPqZ4N5RM=; b=SMB4kSFWA19GlZ85vG3uNZqQzj
        5WPMfQgw+nJ+M4/FnkNe2hg+d5rUjB3uvG3UAXOHOfOy5EjN6G4onUSkT7OcyjqIkZS8V/xfIURIC
        v8j5Z9XqmYxJepY87/vvaPaHMhmzaaFWAnWDcGV3AumVZ1PE4rGMDsYFPjOuXf5/1YrLZJ8/B3Fsx
        550o6zmPDoH4PWBER7FF6q0s1vR8bJ2jeq34IQ8U6QFtSeEMRdJDhMsTn8NLBbuMojF6QFGwdW7Gp
        kA3pu+A0601yoBNpmL2GvrF6um7lgmpJ8/6qcnrneNn7w7UC7qSv3fHMNVjHxzrcEDjYb8wmY0KPE
        9GAQLV3g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVayx-003Anj-3i; Mon, 14 Aug 2023 17:03:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: Convert defrag_prepare_one_page() to use a folio
Date:   Mon, 14 Aug 2023 18:03:49 +0100
Message-Id: <20230814170350.756488-1-willy@infradead.org>
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

Use a folio throughout defrag_prepare_one_page() to remove dozens of
hidden calls to compound_head().  There is no support here for large
folios; indeed, turn the existing check for PageCompound into a check
for large folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/defrag.c | 53 ++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index f2ff4cbe8656..4392a09d2bb1 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -724,13 +724,14 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode, pgoff_t i
 	u64 page_start = (u64)index << PAGE_SHIFT;
 	u64 page_end = page_start + PAGE_SIZE - 1;
 	struct extent_state *cached_state = NULL;
-	struct page *page;
+	struct folio *folio;
 	int ret;
 
 again:
-	page = find_or_create_page(mapping, index, mask);
-	if (!page)
-		return ERR_PTR(-ENOMEM);
+	folio = __filemap_get_folio(mapping, index,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
+	if (IS_ERR(folio))
+		return &folio->page;
 
 	/*
 	 * Since we can defragment files opened read-only, we can encounter
@@ -740,16 +741,16 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode, pgoff_t i
 	 * executables that explicitly enable them, so this isn't very
 	 * restrictive.
 	 */
-	if (PageCompound(page)) {
-		unlock_page(page);
-		put_page(page);
+	if (folio_test_large(folio)) {
+		folio_unlock(folio);
+		folio_put(folio);
 		return ERR_PTR(-ETXTBSY);
 	}
 
-	ret = set_page_extent_mapped(page);
+	ret = set_page_extent_mapped(&folio->page);
 	if (ret < 0) {
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 		return ERR_PTR(ret);
 	}
 
@@ -764,17 +765,17 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode, pgoff_t i
 		if (!ordered)
 			break;
 
-		unlock_page(page);
+		folio_unlock(folio);
 		btrfs_start_ordered_extent(ordered);
 		btrfs_put_ordered_extent(ordered);
-		lock_page(page);
+		folio_lock(folio);
 		/*
-		 * We unlocked the page above, so we need check if it was
+		 * We unlocked the folio above, so we need check if it was
 		 * released or not.
 		 */
-		if (page->mapping != mapping || !PagePrivate(page)) {
-			unlock_page(page);
-			put_page(page);
+		if (folio->mapping != mapping || !folio->private) {
+			folio_unlock(folio);
+			folio_put(folio);
 			goto again;
 		}
 	}
@@ -783,21 +784,21 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode, pgoff_t i
 	 * Now the page range has no ordered extent any more.  Read the page to
 	 * make it uptodate.
 	 */
-	if (!PageUptodate(page)) {
-		btrfs_read_folio(NULL, page_folio(page));
-		lock_page(page);
-		if (page->mapping != mapping || !PagePrivate(page)) {
-			unlock_page(page);
-			put_page(page);
+	if (!folio_test_uptodate(folio)) {
+		btrfs_read_folio(NULL, folio);
+		folio_lock(folio);
+		if (folio->mapping != mapping || !folio->private) {
+			folio_unlock(folio);
+			folio_put(folio);
 			goto again;
 		}
-		if (!PageUptodate(page)) {
-			unlock_page(page);
-			put_page(page);
+		if (!folio_test_uptodate(folio)) {
+			folio_unlock(folio);
+			folio_put(folio);
 			return ERR_PTR(-EIO);
 		}
 	}
-	return page;
+	return &folio->page;
 }
 
 struct defrag_target_range {
-- 
2.40.1

