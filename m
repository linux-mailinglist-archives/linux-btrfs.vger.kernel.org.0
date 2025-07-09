Return-Path: <linux-btrfs+bounces-15375-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFACAFE33D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 10:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 610577BA83E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 08:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C89281509;
	Wed,  9 Jul 2025 08:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2BUr9oq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC5228135D
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051207; cv=none; b=HT0WACuFAniZibqgXy3jgZsv5TRyyBG5lFCpBSulsQgECrLj0hE/z3V05tgQIiAGdScvQiN8SAMnG8No7OKi0NfyjNeHO9uOAyuJQtfZ90OCx5ARsWmFtzNt9h60Oj9i40zO/w/nR5V+iQTVAR8ibgE3ERyVRIQUllp+pMjWIJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051207; c=relaxed/simple;
	bh=CfFknCWL50iHT8NTTahsDJOOfj8A+Q+tfd0jnoGgcgI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1homcPRlwE93v9ZdPApAHerRxBUJtccW8YSSqsVDCDfkHI78lUMyJz1vzrY5+nGXKqWUW+eQQBZ1P6Hj75cL+XMfUG7XdrCtXdRy16hPqechLaGXrJN44vTYIWg44Kvay1XQkdCwHKl+IcyPCsvzSbmDKZe+zjZ6oScnNj9xwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2BUr9oq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C06EC4CEEF
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 08:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752051206;
	bh=CfFknCWL50iHT8NTTahsDJOOfj8A+Q+tfd0jnoGgcgI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=K2BUr9oq/4cWXPHw6vCjBWXSwKKoHgdcWFYv9Tma6iG7AKQJBeEOxvcz8qvHHisAG
	 tq1ZWdFJsSidLizrSDYVdkXiGTR5wf/1G+AWWNxC/aRqRrEaOj9nvWajaLCZKzzEAJ
	 gJwFQiTVTQgDZTORyJ9JjZgcAUrk90ayK9t3mc/dUce6OZjcjeG/jcUO0NYL/04uLv
	 nsCFuuHpcke6O9aXpkOvrOgGR7Z1+NN+jDLZ6YfdhCopc0KxUSvgVPs8YqIgLDV4yv
	 34r88O4os00Efu3eJeJrGww8UJMNYpPLLlNUdoIGO2tJ/yPb4bM+xwRdO5prscjE0x
	 s8t/Xe5lMEvng==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: use btrfs_inode local variable at btrfs_page_mkwrite()
Date: Wed,  9 Jul 2025 09:53:20 +0100
Message-ID: <6aefca8792028e0544de96b2d7f5b34ea836d1c7.1752050704.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1752050704.git.fdmanana@suse.com>
References: <cover.1752050704.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Most of the time we want to use the btrfs_inode, so change the local inode
variable to be a btrfs_inode instead of a vfs inode, reducing verbosity
by eleminating a lot of BTRFS_I() calls.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 58 ++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index e76e92873de5..765ffa06688b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1831,9 +1831,9 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
 	struct folio *folio = page_folio(page);
-	struct inode *inode = file_inode(vmf->vma->vm_file);
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
-	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	struct btrfs_inode *inode = BTRFS_I(file_inode(vmf->vma->vm_file));
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct extent_io_tree *io_tree = &inode->io_tree;
 	struct btrfs_ordered_extent *ordered;
 	struct extent_state *cached_state = NULL;
 	struct extent_changeset *data_reserved = NULL;
@@ -1849,7 +1849,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
 	reserved_space = fsize;
 
-	sb_start_pagefault(inode->i_sb);
+	sb_start_pagefault(inode->vfs_inode.i_sb);
 	page_start = folio_pos(folio);
 	page_end = page_start + folio_size(folio) - 1;
 	end = page_end;
@@ -1862,13 +1862,12 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	 * end up waiting indefinitely to get a lock on the page currently
 	 * being processed by btrfs_page_mkwrite() function.
 	 */
-	ret = btrfs_check_data_free_space(BTRFS_I(inode), &data_reserved,
-					  page_start, reserved_space, false);
+	ret = btrfs_check_data_free_space(inode, &data_reserved, page_start,
+					  reserved_space, false);
 	if (ret < 0) {
 		size_t write_bytes = reserved_space;
 
-		if (btrfs_check_nocow_lock(BTRFS_I(inode), page_start,
-					   &write_bytes, false) <= 0)
+		if (btrfs_check_nocow_lock(inode, page_start, &write_bytes, false) <= 0)
 			goto out_noreserve;
 
 		if (write_bytes < reserved_space)
@@ -1876,11 +1875,11 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
 		only_release_metadata = true;
 	}
-	ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), reserved_space,
+	ret = btrfs_delalloc_reserve_metadata(inode, reserved_space,
 					      reserved_space, false);
 	if (ret < 0) {
 		if (!only_release_metadata)
-			btrfs_free_reserved_data_space(BTRFS_I(inode), data_reserved,
+			btrfs_free_reserved_data_space(inode, data_reserved,
 						       page_start, reserved_space);
 		goto out_noreserve;
 	}
@@ -1889,11 +1888,11 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	if (ret < 0)
 		goto out;
 again:
-	down_read(&BTRFS_I(inode)->i_mmap_lock);
+	down_read(&inode->i_mmap_lock);
 	folio_lock(folio);
-	size = i_size_read(inode);
+	size = i_size_read(&inode->vfs_inode);
 
-	if ((folio->mapping != inode->i_mapping) ||
+	if ((folio->mapping != inode->vfs_inode.i_mapping) ||
 	    (page_start >= size)) {
 		/* Page got truncated out from underneath us. */
 		goto out_unlock;
@@ -1911,11 +1910,11 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	 * We can't set the delalloc bits if there are pending ordered
 	 * extents.  Drop our locks and wait for them to finish.
 	 */
-	ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), page_start, fsize);
+	ordered = btrfs_lookup_ordered_range(inode, page_start, fsize);
 	if (ordered) {
 		btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
 		folio_unlock(folio);
-		up_read(&BTRFS_I(inode)->i_mmap_lock);
+		up_read(&inode->i_mmap_lock);
 		btrfs_start_ordered_extent(ordered);
 		btrfs_put_ordered_extent(ordered);
 		goto again;
@@ -1926,7 +1925,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		if (reserved_space < fsize) {
 			end = page_start + reserved_space - 1;
 			if (!only_release_metadata)
-				btrfs_delalloc_release_space(BTRFS_I(inode),
+				btrfs_delalloc_release_space(inode,
 							     data_reserved, end + 1,
 							     fsize - reserved_space,
 							     true);
@@ -1944,8 +1943,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 			       EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
 			       EXTENT_DEFRAG, &cached_state);
 
-	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), page_start, end, 0,
-					&cached_state);
+	ret = btrfs_set_extent_delalloc(inode, page_start, end, 0, &cached_state);
 	if (ret < 0) {
 		btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
 		goto out_unlock;
@@ -1964,38 +1962,38 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	btrfs_folio_set_dirty(fs_info, folio, page_start, end + 1 - page_start);
 	btrfs_folio_set_uptodate(fs_info, folio, page_start, end + 1 - page_start);
 
-	btrfs_set_inode_last_sub_trans(BTRFS_I(inode));
+	btrfs_set_inode_last_sub_trans(inode);
 
 	if (only_release_metadata)
 		btrfs_set_extent_bit(io_tree, page_start, end, EXTENT_NORESERVE,
 				     &cached_state);
 
 	btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
-	up_read(&BTRFS_I(inode)->i_mmap_lock);
+	up_read(&inode->i_mmap_lock);
 
-	btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
+	btrfs_delalloc_release_extents(inode, fsize);
 	if (only_release_metadata)
-		btrfs_check_nocow_unlock(BTRFS_I(inode));
-	sb_end_pagefault(inode->i_sb);
+		btrfs_check_nocow_unlock(inode);
+	sb_end_pagefault(inode->vfs_inode.i_sb);
 	extent_changeset_free(data_reserved);
 	return VM_FAULT_LOCKED;
 
 out_unlock:
 	folio_unlock(folio);
-	up_read(&BTRFS_I(inode)->i_mmap_lock);
+	up_read(&inode->i_mmap_lock);
 out:
-	btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
+	btrfs_delalloc_release_extents(inode, fsize);
 	if (only_release_metadata)
-		btrfs_delalloc_release_metadata(BTRFS_I(inode), reserved_space, true);
+		btrfs_delalloc_release_metadata(inode, reserved_space, true);
 	else
-		btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved,
-					     page_start, reserved_space, true);
+		btrfs_delalloc_release_space(inode, data_reserved, page_start,
+					     reserved_space, true);
 	extent_changeset_free(data_reserved);
 out_noreserve:
 	if (only_release_metadata)
-		btrfs_check_nocow_unlock(BTRFS_I(inode));
+		btrfs_check_nocow_unlock(inode);
 
-	sb_end_pagefault(inode->i_sb);
+	sb_end_pagefault(inode->vfs_inode.i_sb);
 
 	if (ret < 0)
 		return vmf_error(ret);
-- 
2.47.2


