Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD3E77BEA0
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 19:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjHNREL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 13:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjHNREE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 13:04:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F12E63
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 10:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=s8Ul2pgTccMSwgmrWj2LilWQJcUnoQaVE+z6Uh2aRJc=; b=suuJrG8RF9DoJ6sFBAcXJGuiHo
        0drJgdUgfa60I+nex0i8RaVtRGD46O+t+SsYX3QDacafhkz1uIwCoaxzi0bECcSdmY14lEzOmZzGh
        uhQ4t9p5sC3ouD63mVuNXqSAi+GGajuV4KHHqtobopcYfOMtXDSMzfrv+TnYugSRM1jZVd67qhz8t
        AOC4a49K7AXr+LHSMMcK6un6tTLxe3T7zCL5umJj0oMRyivekFcoHemUa0lImV1JnCg98sIVwykMr
        kSl0CTV/fgXbM457Jp16kXGrB7TutpCX7PskPNMtuOmRiT1KA1s5qNoehgjGfTX3mVy+rRm9kGyIk
        x22K4fMA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVayx-003Anl-6n; Mon, 14 Aug 2023 17:03:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: Use a folio array throughout the defrag process
Date:   Mon, 14 Aug 2023 18:03:50 +0100
Message-Id: <20230814170350.756488-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230814170350.756488-1-willy@infradead.org>
References: <20230814170350.756488-1-willy@infradead.org>
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

Remove more hidden calls to compound_head() by using an array of folios
instead of pages.  Also neaten the error path in defrag_one_range() by
adjusting the length of the array instead of checking for NULL.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/defrag.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 4392a09d2bb1..065cb613e3b7 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -717,7 +717,7 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
  * NOTE: Caller should also wait for page writeback after the cluster is
  * prepared, here we don't do writeback wait for each page.
  */
-static struct page *defrag_prepare_one_page(struct btrfs_inode *inode, pgoff_t index)
+static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t index)
 {
 	struct address_space *mapping = inode->vfs_inode.i_mapping;
 	gfp_t mask = btrfs_alloc_write_mask(mapping);
@@ -731,7 +731,7 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode, pgoff_t i
 	folio = __filemap_get_folio(mapping, index,
 			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
 	if (IS_ERR(folio))
-		return &folio->page;
+		return folio;
 
 	/*
 	 * Since we can defragment files opened read-only, we can encounter
@@ -798,7 +798,7 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode, pgoff_t i
 			return ERR_PTR(-EIO);
 		}
 	}
-	return &folio->page;
+	return folio;
 }
 
 struct defrag_target_range {
@@ -1020,7 +1020,7 @@ static_assert(PAGE_ALIGNED(CLUSTER_SIZE));
  */
 static int defrag_one_locked_target(struct btrfs_inode *inode,
 				    struct defrag_target_range *target,
-				    struct page **pages, int nr_pages,
+				    struct folio **folios, int nr_pages,
 				    struct extent_state **cached_state)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
@@ -1029,7 +1029,7 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 	const u64 len = target->len;
 	unsigned long last_index = (start + len - 1) >> PAGE_SHIFT;
 	unsigned long start_index = start >> PAGE_SHIFT;
-	unsigned long first_index = page_index(pages[0]);
+	unsigned long first_index = folios[0]->index;
 	int ret = 0;
 	int i;
 
@@ -1046,8 +1046,8 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 
 	/* Update the page status */
 	for (i = start_index - first_index; i <= last_index - first_index; i++) {
-		ClearPageChecked(pages[i]);
-		btrfs_page_clamp_set_dirty(fs_info, pages[i], start, len);
+		folio_clear_checked(folios[i]);
+		btrfs_page_clamp_set_dirty(fs_info, &folios[i]->page, start, len);
 	}
 	btrfs_delalloc_release_extents(inode, len);
 	extent_changeset_free(data_reserved);
@@ -1063,7 +1063,7 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 	struct defrag_target_range *entry;
 	struct defrag_target_range *tmp;
 	LIST_HEAD(target_list);
-	struct page **pages;
+	struct folio **folios;
 	const u32 sectorsize = inode->root->fs_info->sectorsize;
 	u64 last_index = (start + len - 1) >> PAGE_SHIFT;
 	u64 start_index = start >> PAGE_SHIFT;
@@ -1074,21 +1074,21 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
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
@@ -1108,7 +1108,7 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 		goto unlock_extent;
 
 	list_for_each_entry(entry, &target_list, list) {
-		ret = defrag_one_locked_target(inode, entry, pages, nr_pages,
+		ret = defrag_one_locked_target(inode, entry, folios, nr_pages,
 					       &cached_state);
 		if (ret < 0)
 			break;
@@ -1122,14 +1122,12 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
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
2.40.1

