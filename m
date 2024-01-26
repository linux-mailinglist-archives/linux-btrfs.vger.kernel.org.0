Return-Path: <linux-btrfs+bounces-1818-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7DD83D4F0
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 09:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E651F29015
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 08:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770802137D;
	Fri, 26 Jan 2024 06:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HNX16jzI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBCDBE65
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706252207; cv=none; b=sKoek3bNsP1VukaJ8NuaGdZ5vUSrv2dzxAjz/aw224Mp3ehdpijwOBuMAGS768yNjIEoe0zMe04+wlevcEqMc2J1NK2ybXOY71x9x6bFN2R5qN6H1C//zir8/8aiVByZAy9YYZiHOGw7v2ZwnESfwIlq/cEnmouIC9tM5H9Jyxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706252207; c=relaxed/simple;
	bh=8YxRkFZ9/Vo8KtrzTB8xidJS19LRiq8ELdQ4+Fr7hgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZJEkCFhiAj4QT++vUc0qYcvMruX7Hyh4nu/IOvcJ+uNqqHDeiE259MFNvaySlBhysBdOmqqaUMzh7oj9ELJGB5b/9wHkrSH9nmShBMG6HJzDbEi+A6JcKkwK54FDaLiS1r1faAr47THHq6N3y0MsbDGBl9XYmBk7ALYCdzjRB94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HNX16jzI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=ah4OWUxjYy4hzOp345H3eaRvoE9GozcDoUMWVdS7Wfo=; b=HNX16jzIK54D/JvakB54Ml87VB
	ioj4PbRxY771+yOzAaK5O/ed3uzD5M//E4lUO3wee+7mUcBGNt63tlb+uZhcwqOuIOHyzdt+cBxLm
	rNoPH02UDeUJWkWLz68419/zbxP+UjFsEIArzhZTav+rXEyqL9Z+CK75SPepkrmVed4FC/naj6vy8
	+oL9121z4475aEvafghhIelzMVMnqovfdNcGJSdM9jI4WRFL7BXOHjx0hZjqSnTbntvJOuTVxeVIu
	aSlauOW4lcKIalPzkmPKwpRP1svGAwnx3evsg/ddc6jrPR3WXUI4sxlDt56XhGSPGRHCcxnz7S4Rz
	CX+sIa/w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTG8g-0000000Cp06-2kC1;
	Fri, 26 Jan 2024 06:56:34 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: Convert add_ra_bio_pages() to use a folio
Date: Fri, 26 Jan 2024 06:56:29 +0000
Message-ID: <20240126065631.3055974-1-willy@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocate order-0 folios instead of pages.  Saves twelve hidden calls
to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/compression.c | 58 ++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 68345f73d429..517f9bc58749 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -421,7 +421,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 	u64 cur = cb->orig_bbio->file_offset + orig_bio->bi_iter.bi_size;
 	u64 isize = i_size_read(inode);
 	int ret;
-	struct page *page;
 	struct extent_map *em;
 	struct address_space *mapping = inode->i_mapping;
 	struct extent_map_tree *em_tree;
@@ -447,6 +446,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 	end_index = (i_size_read(inode) - 1) >> PAGE_SHIFT;
 
 	while (cur < compressed_end) {
+		struct folio *folio;
 		u64 page_end;
 		u64 pg_index = cur >> PAGE_SHIFT;
 		u32 add_size;
@@ -454,8 +454,12 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		if (pg_index > end_index)
 			break;
 
-		page = xa_load(&mapping->i_pages, pg_index);
-		if (page && !xa_is_value(page)) {
+		folio = xa_load(&mapping->i_pages, pg_index);
+		if (folio && !xa_is_value(folio)) {
+			/*
+			 * We don't have a reference count on the folio,
+			 * so it is unsafe to refer to folio_size()
+			 */
 			sectors_missed += (PAGE_SIZE - offset_in_page(cur)) >>
 					  fs_info->sectorsize_bits;
 
@@ -471,38 +475,38 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 			continue;
 		}
 
-		page = __page_cache_alloc(mapping_gfp_constraint(mapping,
-								 ~__GFP_FS));
-		if (!page)
+		folio = filemap_alloc_folio(mapping_gfp_constraint(mapping,
+				~__GFP_FS), 0);
+		if (!folio)
 			break;
 
-		if (add_to_page_cache_lru(page, mapping, pg_index, GFP_NOFS)) {
-			put_page(page);
+		if (filemap_add_folio(mapping, folio, pg_index, GFP_NOFS)) {
+			folio_put(folio);
 			/* There is already a page, skip to page end */
 			cur = (pg_index << PAGE_SHIFT) + PAGE_SIZE;
 			continue;
 		}
 
-		if (!*memstall && PageWorkingset(page)) {
+		if (!*memstall && folio_test_workingset(folio)) {
 			psi_memstall_enter(pflags);
 			*memstall = 1;
 		}
 
-		ret = set_page_extent_mapped(page);
+		ret = set_folio_extent_mapped(folio);
 		if (ret < 0) {
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			break;
 		}
 
-		page_end = (pg_index << PAGE_SHIFT) + PAGE_SIZE - 1;
+		page_end = folio_pos(folio) + folio_size(folio) - 1;
 		lock_extent(tree, cur, page_end, NULL);
 		read_lock(&em_tree->lock);
 		em = lookup_extent_mapping(em_tree, cur, page_end + 1 - cur);
 		read_unlock(&em_tree->lock);
 
 		/*
-		 * At this point, we have a locked page in the page cache for
+		 * At this point, we have a locked folio in the page cache for
 		 * these bytes in the file.  But, we have to make sure they map
 		 * to this compressed extent on disk.
 		 */
@@ -511,28 +515,22 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		    (em->block_start >> SECTOR_SHIFT) != orig_bio->bi_iter.bi_sector) {
 			free_extent_map(em);
 			unlock_extent(tree, cur, page_end, NULL);
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			break;
 		}
 		free_extent_map(em);
 
-		if (page->index == end_index) {
-			size_t zero_offset = offset_in_page(isize);
-
-			if (zero_offset) {
-				int zeros;
-				zeros = PAGE_SIZE - zero_offset;
-				memzero_page(page, zero_offset, zeros);
-			}
-		}
+		if (folio->index == end_index)
+			folio_zero_segment(folio, offset_in_page(isize),
+					folio_size(folio));
 
 		add_size = min(em->start + em->len, page_end + 1) - cur;
-		ret = bio_add_page(orig_bio, page, add_size, offset_in_page(cur));
+		ret = bio_add_folio(orig_bio, folio, add_size, offset_in_page(cur));
 		if (ret != add_size) {
 			unlock_extent(tree, cur, page_end, NULL);
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			break;
 		}
 		/*
@@ -541,9 +539,9 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		 * subpage::readers and to unlock the page.
 		 */
 		if (fs_info->sectorsize < PAGE_SIZE)
-			btrfs_subpage_start_reader(fs_info, page_folio(page),
+			btrfs_subpage_start_reader(fs_info, folio,
 						   cur, add_size);
-		put_page(page);
+		folio_put(folio);
 		cur += add_size;
 	}
 	return 0;
-- 
2.43.0


