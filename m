Return-Path: <linux-btrfs+bounces-275-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDA77F3A4F
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 00:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9D91C20B61
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 23:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA26856778;
	Tue, 21 Nov 2023 23:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nKhK+pxv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814FC83
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 15:35:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0EFC218F2
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 23:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1700609722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CHzL03TMQdOkOIfHfGMSRallumzA+KeN77Xge1rzKuE=;
	b=nKhK+pxvWRbVfPU3sk6dgQGgf0IYaJ3D11O6Ww9q1KmjcpRETGUTYDpHkb5Ae0dkg7nN45
	sse9vN8D+Vh1LI72sypKn0fDlU7me9enpJFuUBmwT7nrNtHR5/S9l/6AmPI+CXcw2ol3AF
	hWGDhoa+JHcaA3YXNebNXCIxCNyr5V0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FACB138E3
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 23:35:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id gPnlM7k+XWUfAgAAMHmgww
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 23:35:21 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: refactor alloc_extent_buffer() to allocate-then-attach method
Date: Wed, 22 Nov 2023 10:05:04 +1030
Message-ID: <ffeb6b667a9ff0cf161f7dcd82899114782c0834.1700609426.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

Currently alloc_extent_buffer() utilizes find_or_create_page() to
allocate one page a time for an extent buffer.

This method has the following disadvantages:

- find_or_create_page() is the legacy way of allocating new pages
  With the new folio infrastructure, find_or_create_page() is just
  redirected to filemap_get_folio().

- Lacks the way to support higher order (order >= 1) folios
  As we can not yet let filemap to give us a higher order folio (yet).

This patch would change the workflow by the following way:

		Old		   |		new
-----------------------------------+-------------------------------------
                                   | ret = btrfs_alloc_page_array();
for (i = 0; i < num_pages; i++) {  | for (i = 0; i < num_pages; i++) {
    p = find_or_create_page();     |     ret = filemap_add_folio();
    /* Attach page private */      |     /* Reuse page cache if needed */
    /* Reused eb if needed */      |
				   |     /* Attach page private and
				   |        reuse eb if needed */
				   | }

By this we split the page allocation and private attaching into two
parts, allowing future updates to each part more easily, and migrate to
folio interfaces (especially for possible higher order folios).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 173 +++++++++++++++++++++++++++++++------------
 1 file changed, 126 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 99cc16aed9d7..0ea65f248c15 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3084,6 +3084,14 @@ static bool page_range_has_eb(struct btrfs_fs_info *fs_info, struct page *page)
 static void detach_extent_buffer_page(struct extent_buffer *eb, struct page *page)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
+	/*
+	 * We can no longer using page->mapping reliably, as some extent buffer
+	 * may not have any page mapped to btree_inode yet.
+	 * Furthermore we have to handle dummy ebs during selftests, where
+	 * btree_inode is not yet initialized.
+	 */
+	struct address_space *mapping = fs_info->btree_inode ?
+					fs_info->btree_inode->i_mapping : NULL;
 	const bool mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
 	struct folio *folio = page_folio(page);
 
@@ -3092,11 +3100,11 @@ static void detach_extent_buffer_page(struct extent_buffer *eb, struct page *pag
 	 * be done under the private_lock.
 	 */
 	if (mapped)
-		spin_lock(&page->mapping->private_lock);
+		spin_lock(&mapping->private_lock);
 
 	if (!folio_test_private(folio)) {
 		if (mapped)
-			spin_unlock(&page->mapping->private_lock);
+			spin_unlock(&mapping->private_lock);
 		return;
 	}
 
@@ -3120,7 +3128,7 @@ static void detach_extent_buffer_page(struct extent_buffer *eb, struct page *pag
 			folio_detach_private(folio);
 		}
 		if (mapped)
-			spin_unlock(&page->mapping->private_lock);
+			spin_unlock(&mapping->private_lock);
 		return;
 	}
 
@@ -3143,7 +3151,7 @@ static void detach_extent_buffer_page(struct extent_buffer *eb, struct page *pag
 	if (!page_range_has_eb(fs_info, page))
 		btrfs_detach_subpage(fs_info, page);
 
-	spin_unlock(&page->mapping->private_lock);
+	spin_unlock(&mapping->private_lock);
 }
 
 /* Release all pages attached to the extent buffer */
@@ -3474,16 +3482,80 @@ static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
 	return 0;
 }
 
+/*
+ * Return 0 if eb->pages[i] is attached to btree inode successfully.
+ * Return >0 if there is already annother extent buffer for the range,
+ * and @found_eb_ret would be updated.
+ */
+static int attach_eb_page_to_filemap(struct extent_buffer *eb, int i,
+				     struct extent_buffer **found_eb_ret)
+{
+
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct address_space *mapping = fs_info->btree_inode->i_mapping;
+	const unsigned long index = eb->start >> PAGE_SHIFT;
+	struct folio *existing_folio;
+	int ret;
+
+	ASSERT(found_eb_ret);
+
+	/* Caller should ensure the page exists. */
+	ASSERT(eb->pages[i]);
+
+retry:
+	ret = filemap_add_folio(mapping, page_folio(eb->pages[i]), index + i,
+			GFP_NOFS | __GFP_NOFAIL);
+	if (!ret)
+		return 0;
+
+	existing_folio = filemap_lock_folio(mapping, index + i);
+	/* The page cache only exists for a very short time, just retry. */
+	if (IS_ERR(existing_folio))
+		goto retry;
+
+	/*
+	 * For now, we should only have single-page folios for btree
+	 * inode.
+	 */
+	ASSERT(folio_nr_pages(existing_folio) == 1);
+
+	if (fs_info->nodesize < PAGE_SIZE) {
+		/*
+		 * We're going to reuse the existing page, can
+		 * drop our page and subpage structure now.
+		 */
+		__free_page(eb->pages[i]);
+		eb->pages[i] = folio_page(existing_folio, 0);
+	} else {
+		struct extent_buffer *existing_eb;
+
+		existing_eb = grab_extent_buffer(fs_info,
+					folio_page(existing_folio, 0));
+		if (existing_eb) {
+			/*
+			 * The extent buffer still exists, we can use
+			 * it directly.
+			 */
+			*found_eb_ret = existing_eb;
+			folio_unlock(existing_folio);
+			folio_put(existing_folio);
+			return 1;
+		}
+		/* The extent buffer no longer exists, we can reuse the folio. */
+		__free_page(eb->pages[i]);
+		eb->pages[i] = folio_page(existing_folio, 0);
+	}
+	return 0;
+}
+
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 start, u64 owner_root, int level)
 {
 	unsigned long len = fs_info->nodesize;
 	int num_pages;
-	int i;
-	unsigned long index = start >> PAGE_SHIFT;
+	int attached = 0;
 	struct extent_buffer *eb;
-	struct extent_buffer *exists = NULL;
-	struct page *p;
+	struct extent_buffer *existing_eb = NULL;
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	struct btrfs_subpage *prealloc = NULL;
 	u64 lockdep_owner = owner_root;
@@ -3534,31 +3606,39 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	if (fs_info->nodesize < PAGE_SIZE) {
 		prealloc = btrfs_alloc_subpage(fs_info, BTRFS_SUBPAGE_METADATA);
 		if (IS_ERR(prealloc)) {
-			exists = ERR_CAST(prealloc);
-			goto free_eb;
+			ret = PTR_ERR(prealloc);
+			goto out;
 		}
 	}
 
-	for (i = 0; i < num_pages; i++, index++) {
-		p = find_or_create_page(mapping, index, GFP_NOFS|__GFP_NOFAIL);
-		if (!p) {
-			exists = ERR_PTR(-ENOMEM);
-			btrfs_free_subpage(prealloc);
-			goto free_eb;
+	/* Alloc all pages. */
+	ret = btrfs_alloc_page_array(num_pages, eb->pages);
+	if (ret < 0) {
+		ret = -ENOMEM;
+		btrfs_free_subpage(prealloc);
+		goto out;
+	}
+
+	/* Attach all pages to the filemap. */
+	for (int i = 0; i < num_pages; i++) {
+		struct page *eb_page;
+
+		ret = attach_eb_page_to_filemap(eb, i, &existing_eb);
+		if (ret > 0) {
+			ASSERT(existing_eb);
+			goto out;
 		}
 
+		/*
+		 * Only after attach_eb_page_to_filemap(), eb->pages[] is
+		 * reliable, as we may choose to reuse the existing page cache
+		 * and free the allocated page.
+		 */
+		eb_page = eb->pages[i];
+
 		spin_lock(&mapping->private_lock);
-		exists = grab_extent_buffer(fs_info, p);
-		if (exists) {
-			spin_unlock(&mapping->private_lock);
-			unlock_page(p);
-			put_page(p);
-			mark_extent_buffer_accessed(exists, p);
-			btrfs_free_subpage(prealloc);
-			goto free_eb;
-		}
 		/* Should not fail, as we have preallocated the memory */
-		ret = attach_extent_buffer_page(eb, p, prealloc);
+		ret = attach_extent_buffer_page(eb, eb_page, prealloc);
 		ASSERT(!ret);
 		/*
 		 * To inform we have extra eb under allocation, so that
@@ -3569,22 +3649,18 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		 * detach_extent_buffer_page().
 		 * Thus needs no special handling in error path.
 		 */
-		btrfs_page_inc_eb_refs(fs_info, p);
+		btrfs_page_inc_eb_refs(fs_info, eb_page);
 		spin_unlock(&mapping->private_lock);
 
-		WARN_ON(btrfs_page_test_dirty(fs_info, p, eb->start, eb->len));
-		eb->pages[i] = p;
-
+		WARN_ON(btrfs_page_test_dirty(fs_info, eb_page, eb->start, eb->len));
 		/*
 		 * Check if the current page is physically contiguous with previous eb
 		 * page.
 		 */
-		if (i && eb->pages[i - 1] + 1 != p)
+		if (i && eb->pages[i - 1] + 1 != eb_page)
 			page_contig = false;
-
-		if (!btrfs_page_test_uptodate(fs_info, p, eb->start, eb->len))
+		if (!btrfs_page_test_uptodate(fs_info, eb_page, eb->start, eb->len))
 			uptodate = 0;
-
 		/*
 		 * We can't unlock the pages just yet since the extent buffer
 		 * hasn't been properly inserted in the radix tree, this
@@ -3595,15 +3671,15 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	}
 	if (uptodate)
 		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
+
 	/* All pages are physically contiguous, can skip cross page handling. */
 	if (page_contig)
 		eb->addr = page_address(eb->pages[0]) + offset_in_page(eb->start);
+
 again:
 	ret = radix_tree_preload(GFP_NOFS);
-	if (ret) {
-		exists = ERR_PTR(ret);
-		goto free_eb;
-	}
+	if (ret)
+		goto out;
 
 	spin_lock(&fs_info->buffer_lock);
 	ret = radix_tree_insert(&fs_info->buffer_radix,
@@ -3611,9 +3687,9 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	spin_unlock(&fs_info->buffer_lock);
 	radix_tree_preload_end();
 	if (ret == -EEXIST) {
-		exists = find_extent_buffer(fs_info, start);
-		if (exists)
-			goto free_eb;
+		existing_eb = find_extent_buffer(fs_info, start);
+		if (existing_eb)
+			goto out;
 		else
 			goto again;
 	}
@@ -3626,19 +3702,22 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	 * btree_release_folio will correctly detect that a page belongs to a
 	 * live buffer and won't free them prematurely.
 	 */
-	for (i = 0; i < num_pages; i++)
+	for (int i = 0; i < num_pages; i++)
 		unlock_page(eb->pages[i]);
 	return eb;
 
-free_eb:
+out:
 	WARN_ON(!atomic_dec_and_test(&eb->refs));
-	for (i = 0; i < num_pages; i++) {
-		if (eb->pages[i])
-			unlock_page(eb->pages[i]);
+	for (int i = 0; i < attached; i++) {
+		ASSERT(eb->pages[i]);
+		unlock_page(eb->pages[i]);
 	}
 
 	btrfs_release_extent_buffer(eb);
-	return exists;
+	if (ret < 0)
+		return ERR_PTR(ret);
+	ASSERT(existing_eb);
+	return existing_eb;
 }
 
 static inline void btrfs_release_extent_buffer_rcu(struct rcu_head *head)
-- 
2.42.1


