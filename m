Return-Path: <linux-btrfs+bounces-15390-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF94AFE80C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 13:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3051C45C25
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 11:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA5F2D9ECD;
	Wed,  9 Jul 2025 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0pjkOc4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2542D8371
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061548; cv=none; b=ZfEmKBQ74NJK4BqM7qpR+02Zxsvyg4FutC03Y7lgPp2n1fikfnhXAeSk4O7EOD2H5oOEJkn40boFJO+x546ppSkIaEItNg49m5LCHygC232cc36B3xJ9FX8JxMQrMAchPbdzI2oMnclWWSKE2XMiiBFWy3jGMlzulx1Yj9NdMYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061548; c=relaxed/simple;
	bh=NUW5fp9lBhqOLhhg3RHQ69ElZgOpcb/+EyyD2XSvbjU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fS0Nt1J3pQeo/GJ+BBhPnJeMmx2NtYnqKAaXhDKV4NgTdy43VaT665Dpw8eVS2L7+1EtpiaYgEe+nlYgrnPOBZKZYE+PT/b5gJUevCt7QoeokHpiLmh4vXAfTCXmfcju/MZjzhbcS8cMIv1xy6usjypwbOBQSY0XkSs8VlzM/D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0pjkOc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E3BC4CEF4
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 11:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752061547;
	bh=NUW5fp9lBhqOLhhg3RHQ69ElZgOpcb/+EyyD2XSvbjU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=H0pjkOc4C7BC/GwLTTPd63HbkjMSwxQyvorc8u0FyWUmzY77SlseQuvdxqk93dVsj
	 4nLKxGF/CNklDIO6C50hJ9XfyyCLYq+0qd/FjX7tFv5QT9Aqf5U6JolIoJg/i+zoHE
	 H2XHcKsdR0FMuCZw/PwNmNQ1m7r5ME7g8mIv98mJJslirRRsb6riOjCVNi52bhgkIR
	 aij+c1NZ184Sw46YfFvSYatzjmHDIi+dYZJGIJe5QIR4P64+aWw2PsBIsXx96uJRRY
	 SCV0WoO5AP9te9lUapxmj1My8g36U6LtXJ2x5VSUK9J2tYzoRfrRB5PZVhCk1PPErB
	 NUzdPs+DzPSew==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 3/3] btrfs: use btrfs_inode local variable at btrfs_page_mkwrite()
Date: Wed,  9 Jul 2025 12:45:41 +0100
Message-ID: <1d5f2e42e17cb18d9fa5c235c97b0f3b9549aafb.1752061083.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1752061083.git.fdmanana@suse.com>
References: <cover.1752061083.git.fdmanana@suse.com>
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

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 64 +++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index e11b1733e3ae..37bf473f2132 100644
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
 
 		only_release_metadata = true;
@@ -1882,11 +1881,11 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		if (write_bytes < reserved_space)
 			goto out_noreserve;
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
@@ -1895,11 +1894,11 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
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
@@ -1917,11 +1916,11 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
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
@@ -1934,12 +1933,10 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
 			end = page_start + reserved_space - 1;
 			if (only_release_metadata)
-				btrfs_delalloc_release_metadata(BTRFS_I(inode),
-								to_free, true);
+				btrfs_delalloc_release_metadata(inode, to_free, true);
 			else
-				btrfs_delalloc_release_space(BTRFS_I(inode),
-							     data_reserved, end + 1,
-							     to_free, true);
+				btrfs_delalloc_release_space(inode, data_reserved,
+							     end + 1, to_free, true);
 		}
 	}
 
@@ -1954,8 +1951,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 			       EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
 			       EXTENT_DEFRAG, &cached_state);
 
-	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), page_start, end, 0,
-					&cached_state);
+	ret = btrfs_set_extent_delalloc(inode, page_start, end, 0, &cached_state);
 	if (ret < 0) {
 		btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
 		goto out_unlock;
@@ -1974,38 +1970,38 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
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


