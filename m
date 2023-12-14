Return-Path: <linux-btrfs+bounces-953-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15698135E5
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Dec 2023 17:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279211C2061C
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Dec 2023 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FA85F1DC;
	Thu, 14 Dec 2023 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qTU2cPGb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ECA10A
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Dec 2023 08:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=IxmqLcvPd4xkwbVKxnh3K0mGKqCJXdh9J06AdcwhQsU=; b=qTU2cPGbdiXjyzQgOqs0YfoGto
	hvYTlVURokq6g39bqCsqCwebj4z0eIS3iDqY3e7Fg46TYEAvbd3R5/VntBvj84+sIijoxtzu697WV
	gQQtsDrxuGFTBAuE73YqY3DlnonAg81MucANeEwBt3DG6lnQLFxnmhWYaLgYflfrho6uE1kJD93pX
	PykKZrD0T0IeQcQxTtSI/0lwgTRZAiACGsrqhTAoe5a5fKct+Ug5NowAnar9LkeIgI43ruSCwv4da
	YAg6eBrAU9rT4mpXZjoF2QYKdFdWdQ/3kQp8KUXAkrLlhQQl4G/Ks/v+NCTRq5vVCsgO/XNmZV9Ce
	xoeqRo0A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rDoL7-008U8F-0A; Thu, 14 Dec 2023 16:13:33 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: Convert defrag_prepare_one_page() to use a folio
Date: Thu, 14 Dec 2023 16:13:30 +0000
Message-Id: <20231214161331.2022416-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231214161331.2022416-1-willy@infradead.org>
References: <20231214161331.2022416-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a folio throughout defrag_prepare_one_page() to remove dozens of
hidden calls to compound_head().  There is no support here for large
folios; indeed, turn the existing check for PageCompound into a check
for large folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/defrag.c | 53 ++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index c276b136ab63..07c40abfe3d7 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -868,13 +868,14 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode, pgoff_t i
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
@@ -884,16 +885,16 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode, pgoff_t i
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
+	ret = set_folio_extent_mapped(folio);
 	if (ret < 0) {
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 		return ERR_PTR(ret);
 	}
 
@@ -908,17 +909,17 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode, pgoff_t i
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
@@ -927,21 +928,21 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode, pgoff_t i
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
2.42.0


