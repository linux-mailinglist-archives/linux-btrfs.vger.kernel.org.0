Return-Path: <linux-btrfs+bounces-5106-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE898C9AAA
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 11:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BB5281FCB
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 09:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64014F5E6;
	Mon, 20 May 2024 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFFgZfsv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49734E1CE
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198419; cv=none; b=jHfD+8n7dQt4HDn1iTO0ZEuwUDSKJI3pPl7zy+y2lZcWgy6VRP4eADiaHCza/9F98xO/Ves5iCfHqrHPej1pD7S7wwUe5y3Hgf26o9n45Mc9et/9ttpxAycM6J+ypuXw4O7TMnaKNvUtAM8wEeE+rZ9X8hNPb8LUj+CbJ9lWbwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198419; c=relaxed/simple;
	bh=axVgvygLn0BB8rBsOlPktnMO7fojFt8Tdy66b/OvR/U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eExcp4e2shHfWsaqKbD5upmoSZ0olXyqiDcVs8b9sXj9gL25ou4EGc4dKt/LJ+6E0sllHF2RHK5wgKD2744+/LApqOT/QZ1gkE7h56I7HRrxu0lfbRdQGQOynCgpEceu7gRRurH92EyMtuoVNjbb4iQhW7pboN0jWzuDtLgTIVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFFgZfsv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D72CC4AF07
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 09:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716198419;
	bh=axVgvygLn0BB8rBsOlPktnMO7fojFt8Tdy66b/OvR/U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZFFgZfsvNALg/VelP4+U7Tnei8p/mc3Hhn1k8Z7gHfDeDkVzRRAG6Z6dzfDqEfsgA
	 dscGh4mGLRCqfi68uEzA0omwYarc0ZR9AoTJa+s7Z+zPPfwGr5PseN33++cMCZbDuE
	 PmTBaVaq4A9J9CKbd/aVXmkX0Wws9eun1Ulf6F78eQ6jI61SWXLJZhEYoDDSBO0X7s
	 hPWu8oJrXqT5aD1DdwxQJLQ5uQreu2UhkdIGpqKV0DgoguEv8tr8nXEIu760BtVN4H
	 wUCb9AqUnG0+wKZ9HQZINPxIjm7TEZgcJuDOVeYzPdqvfKBRVncL0gsaof2IAcBkZD
	 aiOkQaOEEb4qw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 5/6] btrfs: pass a btrfs_inode to btrfs_wait_ordered_range()
Date: Mon, 20 May 2024 10:46:50 +0100
Message-Id: <e2c91cebeb9c0c493e129c71e5b2bb5bce27b924.1716053516.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716053516.git.fdmanana@suse.com>
References: <cover.1716053516.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of passing a (VFS) inode pointer argument, pass a btrfs_inode
instead, as this is generally what we do for internal APIs, making it
more consistent with most of the code base. This will later allow to
help to remove a lot of BTRFS_I() calls in btrfs_sync_file().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c             | 10 +++++-----
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/inode.c            | 16 ++++++++--------
 fs/btrfs/ordered-data.c     |  8 ++++----
 fs/btrfs/ordered-data.h     |  2 +-
 fs/btrfs/reflink.c          |  8 ++++----
 fs/btrfs/relocation.c       |  2 +-
 7 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 23c5510f6271..21a48d326b99 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1884,7 +1884,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * to wait for the IO to stabilize the logical address.
 	 */
 	if (full_sync || btrfs_is_zoned(fs_info)) {
-		ret = btrfs_wait_ordered_range(inode, start, len);
+		ret = btrfs_wait_ordered_range(BTRFS_I(inode), start, len);
 		clear_bit(BTRFS_INODE_COW_WRITE_ERROR, &BTRFS_I(inode)->runtime_flags);
 	} else {
 		/*
@@ -1909,7 +1909,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		 */
 		if (test_and_clear_bit(BTRFS_INODE_COW_WRITE_ERROR,
 				       &BTRFS_I(inode)->runtime_flags))
-			ret = btrfs_wait_ordered_range(inode, start, len);
+			ret = btrfs_wait_ordered_range(BTRFS_I(inode), start, len);
 	}
 
 	if (ret)
@@ -2014,7 +2014,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		ret = btrfs_end_transaction(trans);
 		if (ret)
 			goto out;
-		ret = btrfs_wait_ordered_range(inode, start, len);
+		ret = btrfs_wait_ordered_range(BTRFS_I(inode), start, len);
 		if (ret)
 			goto out;
 
@@ -2814,7 +2814,7 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 
 	btrfs_inode_lock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
 
-	ret = btrfs_wait_ordered_range(inode, offset, len);
+	ret = btrfs_wait_ordered_range(BTRFS_I(inode), offset, len);
 	if (ret)
 		goto out_only_mutex;
 
@@ -3309,7 +3309,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 	 * the file range and, due to the previous locking we did, we know there
 	 * can't be more delalloc or ordered extents in the range.
 	 */
-	ret = btrfs_wait_ordered_range(inode, alloc_start,
+	ret = btrfs_wait_ordered_range(BTRFS_I(inode), alloc_start,
 				       alloc_end - alloc_start);
 	if (ret)
 		goto out;
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index e6d599efd713..8bed59fe937c 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1268,7 +1268,7 @@ static int flush_dirty_cache(struct inode *inode)
 {
 	int ret;
 
-	ret = btrfs_wait_ordered_range(inode, 0, (u64)-1);
+	ret = btrfs_wait_ordered_range(BTRFS_I(inode), 0, (u64)-1);
 	if (ret)
 		clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, inode->i_size - 1,
 				 EXTENT_DELALLOC, NULL);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2f3129fe0e58..3cf32bc721d2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5081,7 +5081,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 
 		if (btrfs_is_zoned(fs_info)) {
-			ret = btrfs_wait_ordered_range(inode,
+			ret = btrfs_wait_ordered_range(BTRFS_I(inode),
 					ALIGN(newsize, fs_info->sectorsize),
 					(u64)-1);
 			if (ret)
@@ -5111,7 +5111,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 			 * wait for disk_i_size to be stable and then update the
 			 * in-memory size to match.
 			 */
-			err = btrfs_wait_ordered_range(inode, 0, (u64)-1);
+			err = btrfs_wait_ordered_range(BTRFS_I(inode), 0, (u64)-1);
 			if (err)
 				return err;
 			i_size_write(inode, BTRFS_I(inode)->disk_i_size);
@@ -7955,7 +7955,7 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	 * if we have delalloc in those ranges.
 	 */
 	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC) {
-		ret = btrfs_wait_ordered_range(inode, 0, LLONG_MAX);
+		ret = btrfs_wait_ordered_range(btrfs_inode, 0, LLONG_MAX);
 		if (ret)
 			return ret;
 	}
@@ -7969,7 +7969,7 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	 * possible a new write may have happened in between those two steps.
 	 */
 	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC) {
-		ret = btrfs_wait_ordered_range(inode, 0, LLONG_MAX);
+		ret = btrfs_wait_ordered_range(btrfs_inode, 0, LLONG_MAX);
 		if (ret) {
 			btrfs_inode_unlock(btrfs_inode, BTRFS_ILOCK_SHARED);
 			return ret;
@@ -8238,7 +8238,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 	const u64 min_size = btrfs_calc_metadata_size(fs_info, 1);
 
 	if (!skip_writeback) {
-		ret = btrfs_wait_ordered_range(&inode->vfs_inode,
+		ret = btrfs_wait_ordered_range(inode,
 					       inode->vfs_inode.i_size & (~mask),
 					       (u64)-1);
 		if (ret)
@@ -10059,7 +10059,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 	for (;;) {
 		struct btrfs_ordered_extent *ordered;
 
-		ret = btrfs_wait_ordered_range(&inode->vfs_inode, start,
+		ret = btrfs_wait_ordered_range(inode, start,
 					       lockend - start + 1);
 		if (ret)
 			goto out_unlock_inode;
@@ -10302,7 +10302,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	for (;;) {
 		struct btrfs_ordered_extent *ordered;
 
-		ret = btrfs_wait_ordered_range(&inode->vfs_inode, start, num_bytes);
+		ret = btrfs_wait_ordered_range(inode, start, num_bytes);
 		if (ret)
 			goto out_folios;
 		ret = invalidate_inode_pages2_range(inode->vfs_inode.i_mapping,
@@ -10575,7 +10575,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	 * file changes again after this, the user is doing something stupid and
 	 * we don't really care.
 	 */
-	ret = btrfs_wait_ordered_range(inode, 0, (u64)-1);
+	ret = btrfs_wait_ordered_range(BTRFS_I(inode), 0, (u64)-1);
 	if (ret)
 		return ret;
 
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 605d88e09525..e2c176f7c387 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -840,7 +840,7 @@ void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry)
 /*
  * Used to wait on ordered extents across a large range of bytes.
  */
-int btrfs_wait_ordered_range(struct inode *inode, u64 start, u64 len)
+int btrfs_wait_ordered_range(struct btrfs_inode *inode, u64 start, u64 len)
 {
 	int ret = 0;
 	int ret_wb = 0;
@@ -859,7 +859,7 @@ int btrfs_wait_ordered_range(struct inode *inode, u64 start, u64 len)
 	/* start IO across the range first to instantiate any delalloc
 	 * extents
 	 */
-	ret = btrfs_fdatawrite_range(BTRFS_I(inode), start, orig_end);
+	ret = btrfs_fdatawrite_range(inode, start, orig_end);
 	if (ret)
 		return ret;
 
@@ -870,11 +870,11 @@ int btrfs_wait_ordered_range(struct inode *inode, u64 start, u64 len)
 	 * before the ordered extents complete - to avoid failures (-EEXIST)
 	 * when adding the new ordered extents to the ordered tree.
 	 */
-	ret_wb = filemap_fdatawait_range(inode->i_mapping, start, orig_end);
+	ret_wb = filemap_fdatawait_range(inode->vfs_inode.i_mapping, start, orig_end);
 
 	end = orig_end;
 	while (1) {
-		ordered = btrfs_lookup_first_ordered_extent(BTRFS_I(inode), end);
+		ordered = btrfs_lookup_first_ordered_extent(inode, end);
 		if (!ordered)
 			break;
 		if (ordered->file_offset > orig_end) {
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index bef22179e7c5..4a4dd15d38ba 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -181,7 +181,7 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *inode,
 							 u64 file_offset);
 void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry);
-int btrfs_wait_ordered_range(struct inode *inode, u64 start, u64 len);
+int btrfs_wait_ordered_range(struct btrfs_inode *inode, u64 start, u64 len);
 struct btrfs_ordered_extent *
 btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset);
 struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index d0a3fcecc46a..df6b93b927cd 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -733,7 +733,7 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 		 * we found the previous extent covering eof and before we
 		 * attempted to increment its reference count).
 		 */
-		ret = btrfs_wait_ordered_range(inode, wb_start,
+		ret = btrfs_wait_ordered_range(BTRFS_I(inode), wb_start,
 					       destoff - wb_start);
 		if (ret)
 			return ret;
@@ -755,7 +755,7 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 	 * range, so wait for writeback to complete before truncating pages
 	 * from the page cache. This is a rare case.
 	 */
-	wb_ret = btrfs_wait_ordered_range(inode, destoff, len);
+	wb_ret = btrfs_wait_ordered_range(BTRFS_I(inode), destoff, len);
 	ret = ret ? ret : wb_ret;
 	/*
 	 * Truncate page cache pages so that future reads will see the cloned
@@ -835,11 +835,11 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 	if (ret < 0)
 		return ret;
 
-	ret = btrfs_wait_ordered_range(inode_in, ALIGN_DOWN(pos_in, bs),
+	ret = btrfs_wait_ordered_range(BTRFS_I(inode_in), ALIGN_DOWN(pos_in, bs),
 				       wb_len);
 	if (ret < 0)
 		return ret;
-	ret = btrfs_wait_ordered_range(inode_out, ALIGN_DOWN(pos_out, bs),
+	ret = btrfs_wait_ordered_range(BTRFS_I(inode_out), ALIGN_DOWN(pos_out, bs),
 				       wb_len);
 	if (ret < 0)
 		return ret;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 9f35524b6664..8ce337ec033c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4149,7 +4149,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 		 * out of the loop if we hit an error.
 		 */
 		if (rc->stage == MOVE_DATA_EXTENTS && rc->found_file_extent) {
-			ret = btrfs_wait_ordered_range(rc->data_inode, 0,
+			ret = btrfs_wait_ordered_range(BTRFS_I(rc->data_inode), 0,
 						       (u64)-1);
 			if (ret)
 				err = ret;
-- 
2.43.0


