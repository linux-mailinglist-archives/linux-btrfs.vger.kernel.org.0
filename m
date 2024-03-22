Return-Path: <linux-btrfs+bounces-3513-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AEF887392
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 20:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C772285007
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 19:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E8576F1D;
	Fri, 22 Mar 2024 19:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUWwWrEA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CD35B5D9
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Mar 2024 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711134447; cv=none; b=VzxnlVZmiWGSxWeIvi/H8W+nLe4xK96D4PImkbM9I+eSQY+eUzUlq7SQTxiNhfdaEPpb7BPn7u9tR9RKAd6qoBWspN0UpOyTQpo3B9ZALs3IdWYk9LVYu9ucpP2UJaTyD2EtB2lG0Hrvj5jOMoQCyr4CRGwb3dZq0kwZqaG/OU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711134447; c=relaxed/simple;
	bh=qYK6veJM5lkdtTJrHCphjI+ftyObuLaN0xBb+FdOtQQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=APnmdhLDEW3bPyB3sP8PDPDzandsiP/CqEDucq7f5PVwJE7bsoxQ++RkLra/2WHdvSOFU9sk7GoPqB6Af58BXkgHWHiix4V2RZtwkTPuF4OvJvNPHAIVjooY0MlUqyqFQ/7xDaeBShP+EDHlLmDgaNpj48GZpX/YBWpQaU5aXiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUWwWrEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C74C43394
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Mar 2024 19:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711134445;
	bh=qYK6veJM5lkdtTJrHCphjI+ftyObuLaN0xBb+FdOtQQ=;
	h=From:To:Subject:Date:From;
	b=EUWwWrEAeoxx74oGwzftWrOhOSALI4kQMFXPJJSt4ibWT0Rcrhv04egb8JNMvOvaS
	 Os5h/0f5T6z7UwsGjzWk8wX4ah0NdsNwpukwsdHLTWNou53U2etdCavCvDUm2gPK7N
	 Yaag2vRGh1QVn/8CLRWrfd4C5WcPzBTJY1W9ILMPPZ+K2lKRq6Q+RHNDwJvEaucsH+
	 82D6cw3t7qrCZDa36y1jaodIgFYUeHtPT3h2Xo9yefH2bRL7ayEbhSA+fngubFIta1
	 W/p/Iru2e4YeFr/PEGtsMFGeQFXIIgE6fNZOWUvexHE3btaTkFLF6W+9RPDs5e/4NY
	 zJuhp6rJvE55w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: stop locking the source extent range during reflink
Date: Fri, 22 Mar 2024 19:07:18 +0000
Message-Id: <09a3da957a5b7f60a1dba5f4609971a62b3f7c23.1711134182.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Nowadays before starting a reflink operation we do this:

1) Take the VFS lock of the inodes in exlcusive mode (a rw semaphore);

2) Take the  mmap lock of the inodes (struct btrfs_inode::i_mmap_lock);

3) Flush all dealloc in the source and target ranges;

4) Wait for all ordered extents in the source and target ranges to
   complete;

5) Lock the source and destination ranges in the inodes' io trees.

In step 5 we don't need anymore to lock the source range because nowadays
we have the mmap lock (step 2) and locking the source range was just to
avoid races with mmap writes before we had that mmap lock, which was added
in commit 8c99516a8cdd ("btrfs: exclude mmaps while doing remap").

So stop locking the source file range, allowing concurrent reads to happen
in parallel and making test case generic/733 pass.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/reflink.c | 42 +++++++++---------------------------------
 1 file changed, 9 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 08d0fb46ceec..6e7a3970394b 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -616,35 +616,6 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 	return ret;
 }
 
-static void btrfs_double_extent_unlock(struct inode *inode1, u64 loff1,
-				       struct inode *inode2, u64 loff2, u64 len)
-{
-	unlock_extent(&BTRFS_I(inode1)->io_tree, loff1, loff1 + len - 1, NULL);
-	unlock_extent(&BTRFS_I(inode2)->io_tree, loff2, loff2 + len - 1, NULL);
-}
-
-static void btrfs_double_extent_lock(struct inode *inode1, u64 loff1,
-				     struct inode *inode2, u64 loff2, u64 len)
-{
-	u64 range1_end = loff1 + len - 1;
-	u64 range2_end = loff2 + len - 1;
-
-	if (inode1 < inode2) {
-		swap(inode1, inode2);
-		swap(loff1, loff2);
-		swap(range1_end, range2_end);
-	} else if (inode1 == inode2 && loff2 < loff1) {
-		swap(loff1, loff2);
-		swap(range1_end, range2_end);
-	}
-
-	lock_extent(&BTRFS_I(inode1)->io_tree, loff1, range1_end, NULL);
-	lock_extent(&BTRFS_I(inode2)->io_tree, loff2, range2_end, NULL);
-
-	btrfs_assert_inode_range_clean(BTRFS_I(inode1), loff1, range1_end);
-	btrfs_assert_inode_range_clean(BTRFS_I(inode2), loff2, range2_end);
-}
-
 static void btrfs_double_mmap_lock(struct inode *inode1, struct inode *inode2)
 {
 	if (inode1 < inode2)
@@ -662,6 +633,8 @@ static void btrfs_double_mmap_unlock(struct inode *inode1, struct inode *inode2)
 static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
 				   struct inode *dst, u64 dst_loff)
 {
+	const u64 end = dst_loff + len - 1;
+	struct extent_state *cached_state = NULL;
 	struct btrfs_fs_info *fs_info = BTRFS_I(src)->root->fs_info;
 	const u64 bs = fs_info->sectorsize;
 	int ret;
@@ -670,9 +643,9 @@ static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
 	 * Lock destination range to serialize with concurrent readahead() and
 	 * source range to serialize with relocation.
 	 */
-	btrfs_double_extent_lock(src, loff, dst, dst_loff, len);
+	lock_extent(&BTRFS_I(dst)->io_tree, dst_loff, end, &cached_state);
 	ret = btrfs_clone(src, dst, loff, len, ALIGN(len, bs), dst_loff, 1);
-	btrfs_double_extent_unlock(src, loff, dst, dst_loff, len);
+	unlock_extent(&BTRFS_I(dst)->io_tree, dst_loff, end, &cached_state);
 
 	btrfs_btree_balance_dirty(fs_info);
 
@@ -724,6 +697,7 @@ static int btrfs_extent_same(struct inode *src, u64 loff, u64 olen,
 static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 					u64 off, u64 olen, u64 destoff)
 {
+	struct extent_state *cached_state = NULL;
 	struct inode *inode = file_inode(file);
 	struct inode *src = file_inode(file_src);
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
@@ -731,6 +705,7 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 	int wb_ret;
 	u64 len = olen;
 	u64 bs = fs_info->sectorsize;
+	u64 end;
 
 	/*
 	 * VFS's generic_remap_file_range_prep() protects us from cloning the
@@ -766,9 +741,10 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 	 * Lock destination range to serialize with concurrent readahead() and
 	 * source range to serialize with relocation.
 	 */
-	btrfs_double_extent_lock(src, off, inode, destoff, len);
+	end = destoff + len - 1;
+	lock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_state);
 	ret = btrfs_clone(src, inode, off, olen, len, destoff, 0);
-	btrfs_double_extent_unlock(src, off, inode, destoff, len);
+	unlock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_state);
 
 	/*
 	 * We may have copied an inline extent into a page of the destination
-- 
2.43.0


