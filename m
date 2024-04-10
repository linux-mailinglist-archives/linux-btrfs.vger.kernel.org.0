Return-Path: <linux-btrfs+bounces-4110-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA9D89F11A
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 13:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FA23B236FF
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 11:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD3715ADBD;
	Wed, 10 Apr 2024 11:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXDAwMZg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92DA15958A
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749532; cv=none; b=P/YwVcAK5aAU3Q3k5s+buc2QCBZJHgfOv5xwZzDdFf9X9/qWMv55zzyyNtkYLZ7+yhXrL4gavaXxO1Hf1PVVL/8hVaOfZNoWPmOoAxRlYUCw/BWV0HOUr8v3U6rYb8ilIAAl4tyhbCXoZK2mwuDG8irdAWsd3hKbKWaVdOgh69c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749532; c=relaxed/simple;
	bh=9g8lgh7nnrkpPjLTt8gH0em+/RTrJSDw0RDB0PpxywI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=SJw7Z0f6pPP5GpcThhVMIt4Ef8V7QaXJo/zjWqSS7yn6tAJXxG6fhbBYTvVVTv6Yj8wpvxiMrpQoDlC3pTXMj8/OcE0BpuqCQCTI3IVP9V5oKD6wP63I/l3eInoKCKDVCwYWuJlzWwo64JYSOIqQV7ipDw+ht0heEyuU6N0x98Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXDAwMZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86A0C433F1
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 11:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712749532;
	bh=9g8lgh7nnrkpPjLTt8gH0em+/RTrJSDw0RDB0PpxywI=;
	h=From:To:Subject:Date:From;
	b=PXDAwMZgGEgKIj2wm7MZlZ5/5jqGDO4KMb+8ZgduMgaIIuoJUFijTNxc9ZChG9lN7
	 NaEtoz5HkYFZcK12zfWSzRT79t76Nh0Hah1TIimm/o5zowHn4Dfag20jSlO3aV6959
	 A8o4Wmx6d8LtKBy7hxOi0W6bSH/16UoRcNV/hsDfSVKircAiCGLrNJr4WEQCO3thov
	 NmJqP5tDJzCme5Tm6HwoMvw6Tgqu+Yd+EB/gtRE/xwGfcp8lAiqhHXHeR9hPWvGPk4
	 8cWNDAA9WuOx+6Absh1bh1Y6hkTYxi+0cSDhref20ekMH2r30uNJ+ZW8Hmgge5ouQv
	 p7KHh03ZIyyHw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: move btrfs_page_mkwrite() from inode.c into file.c
Date: Wed, 10 Apr 2024 12:45:29 +0100
Message-Id: <b7d1ee7e696e2ed290e3de640102073dcb0334bb.1712749432.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

btrfs_page_mkwrite() is a struct vm_operations_struct callback and we
define that structure in file.c. Currently the function is in inode.c and
has to be exported to be used in file.c, which makes no sense because it's
not used anywhere else. So move btrfs_page_mkwrite() from inode.c and into
file.c.

While at it do a few minor style changes:

1) Capitalize the first word of every comment and end each sentence with
   punctuation;

2) Avoid splitting some statements into two lines when everything fits in
   85 characters or less.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h |   1 -
 fs/btrfs/file.c        | 166 ++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/inode.c       | 167 -----------------------------------------
 3 files changed, 166 insertions(+), 168 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 100020ca4658..ed8bd15aa3e2 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -496,7 +496,6 @@ void btrfs_merge_delalloc_extent(struct btrfs_inode *inode, struct extent_state
 void btrfs_split_delalloc_extent(struct btrfs_inode *inode,
 				 struct extent_state *orig, u64 split);
 void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end);
-vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf);
 void btrfs_evict_inode(struct inode *inode);
 struct inode *btrfs_alloc_inode(struct super_block *sb);
 void btrfs_destroy_inode(struct inode *inode);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0c23053951be..1b972bd05af1 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2029,6 +2029,172 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	goto out;
 }
 
+/*
+ * btrfs_page_mkwrite() is not allowed to change the file size as it gets
+ * called from a page fault handler when a page is first dirtied. Hence we must
+ * be careful to check for EOF conditions here. We set the page up correctly
+ * for a written page which means we get ENOSPC checking when writing into
+ * holes and correct delalloc and unwritten extent mapping on filesystems that
+ * support these features.
+ *
+ * We are not allowed to take the i_mutex here so we have to play games to
+ * protect against truncate races as the page could now be beyond EOF.  Because
+ * truncate_setsize() writes the inode size before removing pages, once we have
+ * the page lock we can determine safely if the page is beyond EOF. If it is not
+ * beyond EOF, then the page is guaranteed safe against truncation until we
+ * unlock the page.
+ */
+static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
+{
+	struct page *page = vmf->page;
+	struct folio *folio = page_folio(page);
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
+	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	struct btrfs_ordered_extent *ordered;
+	struct extent_state *cached_state = NULL;
+	struct extent_changeset *data_reserved = NULL;
+	unsigned long zero_start;
+	loff_t size;
+	vm_fault_t ret;
+	int ret2;
+	int reserved = 0;
+	u64 reserved_space;
+	u64 page_start;
+	u64 page_end;
+	u64 end;
+
+	ASSERT(folio_order(folio) == 0);
+
+	reserved_space = PAGE_SIZE;
+
+	sb_start_pagefault(inode->i_sb);
+	page_start = page_offset(page);
+	page_end = page_start + PAGE_SIZE - 1;
+	end = page_end;
+
+	/*
+	 * Reserving delalloc space after obtaining the page lock can lead to
+	 * deadlock. For example, if a dirty page is locked by this function
+	 * and the call to btrfs_delalloc_reserve_space() ends up triggering
+	 * dirty page write out, then the btrfs_writepages() function could
+	 * end up waiting indefinitely to get a lock on the page currently
+	 * being processed by btrfs_page_mkwrite() function.
+	 */
+	ret2 = btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_reserved,
+					    page_start, reserved_space);
+	if (!ret2) {
+		ret2 = file_update_time(vmf->vma->vm_file);
+		reserved = 1;
+	}
+	if (ret2) {
+		ret = vmf_error(ret2);
+		if (reserved)
+			goto out;
+		goto out_noreserve;
+	}
+
+	/* Make the VM retry the fault. */
+	ret = VM_FAULT_NOPAGE;
+again:
+	down_read(&BTRFS_I(inode)->i_mmap_lock);
+	lock_page(page);
+	size = i_size_read(inode);
+
+	if ((page->mapping != inode->i_mapping) ||
+	    (page_start >= size)) {
+		/* Page got truncated out from underneath us. */
+		goto out_unlock;
+	}
+	wait_on_page_writeback(page);
+
+	lock_extent(io_tree, page_start, page_end, &cached_state);
+	ret2 = set_page_extent_mapped(page);
+	if (ret2 < 0) {
+		ret = vmf_error(ret2);
+		unlock_extent(io_tree, page_start, page_end, &cached_state);
+		goto out_unlock;
+	}
+
+	/*
+	 * We can't set the delalloc bits if there are pending ordered
+	 * extents.  Drop our locks and wait for them to finish.
+	 */
+	ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), page_start, PAGE_SIZE);
+	if (ordered) {
+		unlock_extent(io_tree, page_start, page_end, &cached_state);
+		unlock_page(page);
+		up_read(&BTRFS_I(inode)->i_mmap_lock);
+		btrfs_start_ordered_extent(ordered);
+		btrfs_put_ordered_extent(ordered);
+		goto again;
+	}
+
+	if (page->index == ((size - 1) >> PAGE_SHIFT)) {
+		reserved_space = round_up(size - page_start, fs_info->sectorsize);
+		if (reserved_space < PAGE_SIZE) {
+			end = page_start + reserved_space - 1;
+			btrfs_delalloc_release_space(BTRFS_I(inode),
+					data_reserved, page_start,
+					PAGE_SIZE - reserved_space, true);
+		}
+	}
+
+	/*
+	 * page_mkwrite gets called when the page is firstly dirtied after it's
+	 * faulted in, but write(2) could also dirty a page and set delalloc
+	 * bits, thus in this case for space account reason, we still need to
+	 * clear any delalloc bits within this page range since we have to
+	 * reserve data&meta space before lock_page() (see above comments).
+	 */
+	clear_extent_bit(&BTRFS_I(inode)->io_tree, page_start, end,
+			  EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
+			  EXTENT_DEFRAG, &cached_state);
+
+	ret2 = btrfs_set_extent_delalloc(BTRFS_I(inode), page_start, end, 0,
+					&cached_state);
+	if (ret2) {
+		unlock_extent(io_tree, page_start, page_end, &cached_state);
+		ret = VM_FAULT_SIGBUS;
+		goto out_unlock;
+	}
+
+	/* Page is wholly or partially inside EOF. */
+	if (page_start + PAGE_SIZE > size)
+		zero_start = offset_in_page(size);
+	else
+		zero_start = PAGE_SIZE;
+
+	if (zero_start != PAGE_SIZE)
+		memzero_page(page, zero_start, PAGE_SIZE - zero_start);
+
+	btrfs_folio_clear_checked(fs_info, folio, page_start, PAGE_SIZE);
+	btrfs_folio_set_dirty(fs_info, folio, page_start, end + 1 - page_start);
+	btrfs_folio_set_uptodate(fs_info, folio, page_start, end + 1 - page_start);
+
+	btrfs_set_inode_last_sub_trans(BTRFS_I(inode));
+
+	unlock_extent(io_tree, page_start, page_end, &cached_state);
+	up_read(&BTRFS_I(inode)->i_mmap_lock);
+
+	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
+	sb_end_pagefault(inode->i_sb);
+	extent_changeset_free(data_reserved);
+	return VM_FAULT_LOCKED;
+
+out_unlock:
+	unlock_page(page);
+	up_read(&BTRFS_I(inode)->i_mmap_lock);
+out:
+	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
+	btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved, page_start,
+				     reserved_space, (ret != 0));
+out_noreserve:
+	sb_end_pagefault(inode->i_sb);
+	extent_changeset_free(data_reserved);
+	return ret;
+}
+
 static const struct vm_operations_struct btrfs_file_vm_ops = {
 	.fault		= filemap_fault,
 	.map_pages	= filemap_map_pages,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 94ac20e62e13..1a1a4b6d33ed 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8164,173 +8164,6 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	clear_page_extent_mapped(&folio->page);
 }
 
-/*
- * btrfs_page_mkwrite() is not allowed to change the file size as it gets
- * called from a page fault handler when a page is first dirtied. Hence we must
- * be careful to check for EOF conditions here. We set the page up correctly
- * for a written page which means we get ENOSPC checking when writing into
- * holes and correct delalloc and unwritten extent mapping on filesystems that
- * support these features.
- *
- * We are not allowed to take the i_mutex here so we have to play games to
- * protect against truncate races as the page could now be beyond EOF.  Because
- * truncate_setsize() writes the inode size before removing pages, once we have
- * the page lock we can determine safely if the page is beyond EOF. If it is not
- * beyond EOF, then the page is guaranteed safe against truncation until we
- * unlock the page.
- */
-vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
-{
-	struct page *page = vmf->page;
-	struct folio *folio = page_folio(page);
-	struct inode *inode = file_inode(vmf->vma->vm_file);
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
-	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
-	struct btrfs_ordered_extent *ordered;
-	struct extent_state *cached_state = NULL;
-	struct extent_changeset *data_reserved = NULL;
-	unsigned long zero_start;
-	loff_t size;
-	vm_fault_t ret;
-	int ret2;
-	int reserved = 0;
-	u64 reserved_space;
-	u64 page_start;
-	u64 page_end;
-	u64 end;
-
-	ASSERT(folio_order(folio) == 0);
-
-	reserved_space = PAGE_SIZE;
-
-	sb_start_pagefault(inode->i_sb);
-	page_start = page_offset(page);
-	page_end = page_start + PAGE_SIZE - 1;
-	end = page_end;
-
-	/*
-	 * Reserving delalloc space after obtaining the page lock can lead to
-	 * deadlock. For example, if a dirty page is locked by this function
-	 * and the call to btrfs_delalloc_reserve_space() ends up triggering
-	 * dirty page write out, then the btrfs_writepages() function could
-	 * end up waiting indefinitely to get a lock on the page currently
-	 * being processed by btrfs_page_mkwrite() function.
-	 */
-	ret2 = btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_reserved,
-					    page_start, reserved_space);
-	if (!ret2) {
-		ret2 = file_update_time(vmf->vma->vm_file);
-		reserved = 1;
-	}
-	if (ret2) {
-		ret = vmf_error(ret2);
-		if (reserved)
-			goto out;
-		goto out_noreserve;
-	}
-
-	ret = VM_FAULT_NOPAGE; /* make the VM retry the fault */
-again:
-	down_read(&BTRFS_I(inode)->i_mmap_lock);
-	lock_page(page);
-	size = i_size_read(inode);
-
-	if ((page->mapping != inode->i_mapping) ||
-	    (page_start >= size)) {
-		/* page got truncated out from underneath us */
-		goto out_unlock;
-	}
-	wait_on_page_writeback(page);
-
-	lock_extent(io_tree, page_start, page_end, &cached_state);
-	ret2 = set_page_extent_mapped(page);
-	if (ret2 < 0) {
-		ret = vmf_error(ret2);
-		unlock_extent(io_tree, page_start, page_end, &cached_state);
-		goto out_unlock;
-	}
-
-	/*
-	 * we can't set the delalloc bits if there are pending ordered
-	 * extents.  Drop our locks and wait for them to finish
-	 */
-	ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), page_start,
-			PAGE_SIZE);
-	if (ordered) {
-		unlock_extent(io_tree, page_start, page_end, &cached_state);
-		unlock_page(page);
-		up_read(&BTRFS_I(inode)->i_mmap_lock);
-		btrfs_start_ordered_extent(ordered);
-		btrfs_put_ordered_extent(ordered);
-		goto again;
-	}
-
-	if (page->index == ((size - 1) >> PAGE_SHIFT)) {
-		reserved_space = round_up(size - page_start,
-					  fs_info->sectorsize);
-		if (reserved_space < PAGE_SIZE) {
-			end = page_start + reserved_space - 1;
-			btrfs_delalloc_release_space(BTRFS_I(inode),
-					data_reserved, page_start,
-					PAGE_SIZE - reserved_space, true);
-		}
-	}
-
-	/*
-	 * page_mkwrite gets called when the page is firstly dirtied after it's
-	 * faulted in, but write(2) could also dirty a page and set delalloc
-	 * bits, thus in this case for space account reason, we still need to
-	 * clear any delalloc bits within this page range since we have to
-	 * reserve data&meta space before lock_page() (see above comments).
-	 */
-	clear_extent_bit(&BTRFS_I(inode)->io_tree, page_start, end,
-			  EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
-			  EXTENT_DEFRAG, &cached_state);
-
-	ret2 = btrfs_set_extent_delalloc(BTRFS_I(inode), page_start, end, 0,
-					&cached_state);
-	if (ret2) {
-		unlock_extent(io_tree, page_start, page_end, &cached_state);
-		ret = VM_FAULT_SIGBUS;
-		goto out_unlock;
-	}
-
-	/* page is wholly or partially inside EOF */
-	if (page_start + PAGE_SIZE > size)
-		zero_start = offset_in_page(size);
-	else
-		zero_start = PAGE_SIZE;
-
-	if (zero_start != PAGE_SIZE)
-		memzero_page(page, zero_start, PAGE_SIZE - zero_start);
-
-	btrfs_folio_clear_checked(fs_info, folio, page_start, PAGE_SIZE);
-	btrfs_folio_set_dirty(fs_info, folio, page_start, end + 1 - page_start);
-	btrfs_folio_set_uptodate(fs_info, folio, page_start, end + 1 - page_start);
-
-	btrfs_set_inode_last_sub_trans(BTRFS_I(inode));
-
-	unlock_extent(io_tree, page_start, page_end, &cached_state);
-	up_read(&BTRFS_I(inode)->i_mmap_lock);
-
-	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
-	sb_end_pagefault(inode->i_sb);
-	extent_changeset_free(data_reserved);
-	return VM_FAULT_LOCKED;
-
-out_unlock:
-	unlock_page(page);
-	up_read(&BTRFS_I(inode)->i_mmap_lock);
-out:
-	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
-	btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved, page_start,
-				     reserved_space, (ret != 0));
-out_noreserve:
-	sb_end_pagefault(inode->i_sb);
-	extent_changeset_free(data_reserved);
-	return ret;
-}
-
 static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 {
 	struct btrfs_truncate_control control = {
-- 
2.43.0


