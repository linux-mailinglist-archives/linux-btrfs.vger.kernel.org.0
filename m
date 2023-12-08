Return-Path: <linux-btrfs+bounces-765-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B7980ACF5
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 20:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5E41F210F8
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 19:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9715E4CB54;
	Fri,  8 Dec 2023 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v34J+x97"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB571706
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Dec 2023 11:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=nhP63GVsVrWLVAxPML197F0O3cetLPHMkQz/YgWzztY=; b=v34J+x97/QY2kWqsqiFNEg0JcH
	eSpX/Mm7XXOr33PBmbNbSnv4L0qTwvFXfwC8nQ6off9qDrmakRKvuGwCoWoZkt7qchWxYYHm/9SuE
	B4dFKny6AouIam4JPYApeFxzbtsA/DWgp3E0u9ktqearwcwoO3PT/BGVXFsaV/Pf1XzaIWlAwV4E7
	jP631p84wkgz1UMaMQ76NdlA4XwLl5n3BmOC749wfopZ+08JiU1t13g7ZZpHZs2s7I2azSHr+Zmy+
	Ac2w450Ltg3f6tfyFj7moHxc5jKn1ZJkGkU3ipm18AXvc3mUWTBPXAlpQ7bXkpfwQRi2pJTM/IWK+
	PnnCURAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rBgVT-006OFt-QD; Fri, 08 Dec 2023 19:27:27 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: Use a folio array throughout the defrag process
Date: Fri,  8 Dec 2023 19:27:24 +0000
Message-Id: <20231208192725.1523194-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231208192725.1523194-1-willy@infradead.org>
References: <20231208192725.1523194-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove more hidden calls to compound_head() by using an array of folios
instead of pages.  Also neaten the error path in defrag_one_range() by
adjusting the length of the array instead of checking for NULL.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/defrag.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 17a13d3ed131..4b94362779fe 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -861,7 +861,7 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
  * NOTE: Caller should also wait for page writeback after the cluster is
  * prepared, here we don't do writeback wait for each page.
  */
-static struct page *defrag_prepare_one_page(struct btrfs_inode *inode, pgoff_t index)
+static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t index)
 {
 	struct address_space *mapping = inode->vfs_inode.i_mapping;
 	gfp_t mask = btrfs_alloc_write_mask(mapping);
@@ -875,7 +875,7 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode, pgoff_t i
 	folio = __filemap_get_folio(mapping, index,
 			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
 	if (IS_ERR(folio))
-		return &folio->page;
+		return folio;
 
 	/*
 	 * Since we can defragment files opened read-only, we can encounter
@@ -942,7 +942,7 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode, pgoff_t i
 			return ERR_PTR(-EIO);
 		}
 	}
-	return &folio->page;
+	return folio;
 }
 
 struct defrag_target_range {
@@ -1163,7 +1163,7 @@ static_assert(PAGE_ALIGNED(CLUSTER_SIZE));
  */
 static int defrag_one_locked_target(struct btrfs_inode *inode,
 				    struct defrag_target_range *target,
-				    struct page **pages, int nr_pages,
+				    struct folio **folios, int nr_pages,
 				    struct extent_state **cached_state)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
@@ -1172,7 +1172,7 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 	const u64 len = target->len;
 	unsigned long last_index = (start + len - 1) >> PAGE_SHIFT;
 	unsigned long start_index = start >> PAGE_SHIFT;
-	unsigned long first_index = page_index(pages[0]);
+	unsigned long first_index = folios[0]->index;
 	int ret = 0;
 	int i;
 
@@ -1189,8 +1189,8 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 
 	/* Update the page status */
 	for (i = start_index - first_index; i <= last_index - first_index; i++) {
-		ClearPageChecked(pages[i]);
-		btrfs_page_clamp_set_dirty(fs_info, pages[i], start, len);
+		folio_clear_checked(folios[i]);
+		btrfs_page_clamp_set_dirty(fs_info, &folios[i]->page, start, len);
 	}
 	btrfs_delalloc_release_extents(inode, len);
 	extent_changeset_free(data_reserved);
@@ -1206,7 +1206,7 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 	struct defrag_target_range *entry;
 	struct defrag_target_range *tmp;
 	LIST_HEAD(target_list);
-	struct page **pages;
+	struct folio **folios;
 	const u32 sectorsize = inode->root->fs_info->sectorsize;
 	u64 last_index = (start + len - 1) >> PAGE_SHIFT;
 	u64 start_index = start >> PAGE_SHIFT;
@@ -1217,21 +1217,21 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 	ASSERT(nr_pages <= CLUSTER_SIZE / PAGE_SIZE);
 	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(len, sectorsize));
 
-	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
-	if (!pages)
+	folios = kcalloc(nr_pages, sizeof(struct folio *), GFP_NOFS);
+	if (!folios)
 		return -ENOMEM;
 
 	/* Prepare all pages */
 	for (i = 0; i < nr_pages; i++) {
-		pages[i] = defrag_prepare_one_page(inode, start_index + i);
-		if (IS_ERR(pages[i])) {
-			ret = PTR_ERR(pages[i]);
-			pages[i] = NULL;
-			goto free_pages;
+		folios[i] = defrag_prepare_one_folio(inode, start_index + i);
+		if (IS_ERR(folios[i])) {
+			ret = PTR_ERR(folios[i]);
+			nr_pages = i;
+			goto free_folios;
 		}
 	}
 	for (i = 0; i < nr_pages; i++)
-		wait_on_page_writeback(pages[i]);
+		folio_wait_writeback(folios[i]);
 
 	/* Lock the pages range */
 	lock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
@@ -1251,7 +1251,7 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 		goto unlock_extent;
 
 	list_for_each_entry(entry, &target_list, list) {
-		ret = defrag_one_locked_target(inode, entry, pages, nr_pages,
+		ret = defrag_one_locked_target(inode, entry, folios, nr_pages,
 					       &cached_state);
 		if (ret < 0)
 			break;
@@ -1265,14 +1265,12 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 	unlock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
 		      (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
 		      &cached_state);
-free_pages:
+free_folios:
 	for (i = 0; i < nr_pages; i++) {
-		if (pages[i]) {
-			unlock_page(pages[i]);
-			put_page(pages[i]);
-		}
+		folio_unlock(folios[i]);
+		folio_put(folios[i]);
 	}
-	kfree(pages);
+	kfree(folios);
 	return ret;
 }
 
-- 
2.42.0


