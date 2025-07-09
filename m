Return-Path: <linux-btrfs+bounces-15386-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5EDAFE76E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 13:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0265A422C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 11:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1DB295DA5;
	Wed,  9 Jul 2025 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivN9bMiG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29342957CD
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059641; cv=none; b=JGiZdb2GFfhwqXSuK8WPNMoVepdvO6r7ZGxwMPAKXyFZhQjn/9iwHDfucU2lJUj9uZhNakzExvmA4ITK/8SCOm5wie1FDSr73NdYd9rwqruoUrYDtcgC6Fn9Gtipv3IuZeF1m5wKJUFAUu7FYmOBfmqouNB80gQVi3taoxH4qLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059641; c=relaxed/simple;
	bh=gmbMxiR7pNcNroh9Dv77E/XDCsNKLllpj3VPTH9E3FU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrUYPbYZzfytMuQ1JDmE2BgHqRfkRPDLg/agHdQ6CnwOhkkhr7FVAx97wRKeGNJE2IuF5luCxitKFCqSir6POzy4OTKqTWeIVIN0ofqXnxVNekJbDjFsxV50gZr2pAugjZ6xclh5/gsPbWdiKObc0MawRCwhyI9HGfykWn6kOgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivN9bMiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6C8C4CEEF
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 11:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752059640;
	bh=gmbMxiR7pNcNroh9Dv77E/XDCsNKLllpj3VPTH9E3FU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ivN9bMiGyAHMvbZrfz8yeWgDpTFlmtYz9T2xZpHRDsf2TmggZoxsTy30c8oUy6OCv
	 d3MXG2SgOHYtN9oBxd5i+pM3z2kZNiATB6Uvz7TnVIjMWiiatcpsYblpepW0x4uoL+
	 dY8KokxNYqpJcIQzVq7wYV6Q3WQ0eMGKk6qF1RHxpM/ik7s/sn07JAWlOb4hcaGtNY
	 XVOqOEKjQYZn3eBO31LjNRrV44JATMQyAYDUOxsSWHIDqBYTBQ4m06k0aPWsZP1Bc+
	 JgZ2v1p2Q/E2NQ9UQvVqa4GgmMjTs4EK2Q1zNz7wXYCbIpDwigc+yDML8tqLhsm2g9
	 PZw5SXKBCSJcg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs: use btrfs_inode local variable at btrfs_page_mkwrite()
Date: Wed,  9 Jul 2025 12:13:53 +0100
Message-ID: <183bb5f834b748160f0782c3994b8558baf0af5c.1752058855.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1752058855.git.fdmanana@suse.com>
References: <cover.1752058855.git.fdmanana@suse.com>
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
 fs/btrfs/file.c | 58 ++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 80a828f39bbd..d1f5da14f6d1 100644
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
@@ -1932,7 +1931,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		if (reserved_space < fsize) {
 			end = page_start + reserved_space - 1;
 			if (!only_release_metadata)
-				btrfs_delalloc_release_space(BTRFS_I(inode),
+				btrfs_delalloc_release_space(inode,
 							     data_reserved, end + 1,
 							     fsize - reserved_space,
 							     true);
@@ -1950,8 +1949,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 			       EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
 			       EXTENT_DEFRAG, &cached_state);
 
-	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), page_start, end, 0,
-					&cached_state);
+	ret = btrfs_set_extent_delalloc(inode, page_start, end, 0, &cached_state);
 	if (ret < 0) {
 		btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
 		goto out_unlock;
@@ -1970,38 +1968,38 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
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


