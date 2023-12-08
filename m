Return-Path: <linux-btrfs+bounces-764-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0719380ACF4
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 20:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387601C20C4A
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 19:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E862B4CB48;
	Fri,  8 Dec 2023 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IdsPZGFF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E841718
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Dec 2023 11:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=I3X4HF1cepEcOUwVgt/rpIZNmH6aN5nzs6WkVuwLMYk=; b=IdsPZGFFYwD+ZEM0NUl/R+gene
	5et01SjgIGI4h4bRIhuHWYSEfZS1W39FFJ1Za+2U6Kzre8E1+SifNSpfyGlWmgZg0glHdyrr7AaYK
	JsKcC6E7JpqaRKq1jRFu8nIZ+1tJrzbVJrb0WA7DPrBoDe7xbUxoCmQfCzisv2M2U0HONFPRqyjKe
	nSgK1r7oHMJc1dPauIS7TPKa36cgIpywqQGpVvnco/S0gkRExB0t44DPAxrmsgCIzjs3nWPL5Q358
	ZqBOHo6TiOYHQLS7+6tbZuMwTsOnTP0DN2vZiPQmFxNqKIJ1kUznhBmngLeoqKmEgf7nilen5+hVA
	CdqNIfHw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rBgVS-006OFp-So; Fri, 08 Dec 2023 19:27:26 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: Convert defrag_prepare_one_page() to use a folio
Date: Fri,  8 Dec 2023 19:27:23 +0000
Message-Id: <20231208192725.1523194-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
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
index a9a068af8d6e..17a13d3ed131 100644
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
+	ret = set_page_extent_mapped(&folio->page);
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


