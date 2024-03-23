Return-Path: <linux-btrfs+bounces-3518-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489308878E5
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Mar 2024 14:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E767E284D77
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Mar 2024 13:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB0F3F9C1;
	Sat, 23 Mar 2024 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRoVld0w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298EE3D3BB
	for <linux-btrfs@vger.kernel.org>; Sat, 23 Mar 2024 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711200572; cv=none; b=ONw+xx67SN4Qoq+WCyJgOUhqFn6Cuv+8W+Wws/3+GfOCebDDnq0Krelfkk396jNrTvVtniSH6wZn1fKaRIxElp8vMW5T/8AAcdOp3urGfR6fu8rEeo27eNRl8/cYqK0PboELEARBrV3rjcd84RUXBX86dAWjNOfRD2kv3MogLRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711200572; c=relaxed/simple;
	bh=ophnIAjAPl/5X2vwSKb2cNowe7cWwS1ug4kpPLOnhks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s78p8o/SHQulA9f8HHsdX+z8PNmHWhLswMA9oZ1StoK1CKYcoJng9H+uVgC+95nMN2UPw4VMmvuOX38K1saNjgntENhIu9m6Bn0kh7jHxd8q6Xcz86rPvnMDLrYmCuTxDIqfWi+GrLo/ImJPxOOgBfo4nM7CNWIwHX9lnBiaiTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRoVld0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FD5C433F1;
	Sat, 23 Mar 2024 13:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711200571;
	bh=ophnIAjAPl/5X2vwSKb2cNowe7cWwS1ug4kpPLOnhks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iRoVld0wK9KUi7pIwi/PTPDnm1tlUn3BsXJs+xeZygSCRWEP3nZReqSvb2whsuUR2
	 pxwRh5gGWE2CIHOeoPI63EsMAEHpeLteGXCiTMsWc+QBX12VUUYJ0/ApZraVuFJCxz
	 1UBM0UtPe0w2nSdlUmXU1jrK+R1SkVDJUDsOPSySBIvNsVWgGrNNlvBsyF2HJPQAnV
	 V5T55e8C4YVcSWBQ1G97wESdEp3T7Pjb1+Txqy04Ip65HCZYRL6VbyhtnDieAp4Csf
	 /N+5TWuqUyyQanm5h5pCcZ3qdaHPucUOzDkVkWBZiKo6yVbFFSZzTqNEcE+B0fPPLq
	 esxH3Ti2xsBUA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Cc: boris@bur.io
Subject: [PATCH v2] btrfs: stop locking the source extent range during reflink
Date: Sat, 23 Mar 2024 13:29:25 +0000
Message-Id: <5fe82cceb3b6f3434172a7fb0e85a21a2f07e99c.1711199153.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <09a3da957a5b7f60a1dba5f4609971a62b3f7c23.1711134182.git.fdmanana@suse.com>
References: <09a3da957a5b7f60a1dba5f4609971a62b3f7c23.1711134182.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Nowadays before starting a reflink operation we do this:

1) Take the VFS lock of the inodes in exclusive mode (a rw semaphore);

2) Take the  mmap lock of the inodes (struct btrfs_inode::i_mmap_lock);

3) Flush all dealloc in the source and target ranges;

4) Wait for all ordered extents in the source and target ranges to
   complete;

5) Lock the source and destination ranges in the inodes' io trees.

In step 5 we lock the source range because:

1) We needed to serialize against mmap writes, but that is not needed
   anymore because nowadays we do that through the inode's i_mmap_lock
   (step 2). This happens since commit 8c99516a8cdd ("btrfs: exclude mmaps
   while doing remap");

2) To serialize against a concurrent relocation and avoid generating
   a delayed ref for an extent that was just dropped by relocation, see
   commit d8b552424210 (Btrfs: fix race between reflink/dedupe and
   relocation").

Locking the source range however blocks any concurrent reads for that
range and makes test case generic/733 fail.

So instead of locking the source range during reflinks, make relocation
read lock the inode's i_mmap_lock, so that it serializes with a concurrent
reflink while still able to run concurrently with mmap writes and allow
concurrent reads too.

Signed-off-by: Filipe Manana <fdmanana@suse.com>

---

V2: Protect against concurrent relocation of the source extents and
    update comment.

 fs/btrfs/reflink.c    | 54 ++++++++++++++-----------------------------
 fs/btrfs/relocation.c |  8 ++++++-
 2 files changed, 24 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 08d0fb46ceec..f12ba2b75141 100644
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
@@ -662,17 +633,21 @@ static void btrfs_double_mmap_unlock(struct inode *inode1, struct inode *inode2)
 static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
 				   struct inode *dst, u64 dst_loff)
 {
+	const u64 end = dst_loff + len - 1;
+	struct extent_state *cached_state = NULL;
 	struct btrfs_fs_info *fs_info = BTRFS_I(src)->root->fs_info;
 	const u64 bs = fs_info->sectorsize;
 	int ret;
 
 	/*
-	 * Lock destination range to serialize with concurrent readahead() and
-	 * source range to serialize with relocation.
+	 * Lock destination range to serialize with concurrent readahead(), and
+	 * we are safe from concurrency with relocation of source extents
+	 * because we have already locked the inode's i_mmap_lock in exclusive
+	 * mode.
 	 */
-	btrfs_double_extent_lock(src, loff, dst, dst_loff, len);
+	lock_extent(&BTRFS_I(dst)->io_tree, dst_loff, end, &cached_state);
 	ret = btrfs_clone(src, dst, loff, len, ALIGN(len, bs), dst_loff, 1);
-	btrfs_double_extent_unlock(src, loff, dst, dst_loff, len);
+	unlock_extent(&BTRFS_I(dst)->io_tree, dst_loff, end, &cached_state);
 
 	btrfs_btree_balance_dirty(fs_info);
 
@@ -724,6 +699,7 @@ static int btrfs_extent_same(struct inode *src, u64 loff, u64 olen,
 static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 					u64 off, u64 olen, u64 destoff)
 {
+	struct extent_state *cached_state = NULL;
 	struct inode *inode = file_inode(file);
 	struct inode *src = file_inode(file_src);
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
@@ -731,6 +707,7 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 	int wb_ret;
 	u64 len = olen;
 	u64 bs = fs_info->sectorsize;
+	u64 end;
 
 	/*
 	 * VFS's generic_remap_file_range_prep() protects us from cloning the
@@ -763,12 +740,15 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 	}
 
 	/*
-	 * Lock destination range to serialize with concurrent readahead() and
-	 * source range to serialize with relocation.
+	 * Lock destination range to serialize with concurrent readahead(), and
+	 * we are safe from concurrency with relocation of source extents
+	 * because we have already locked the inode's i_mmap_lock in exclusive
+	 * mode.
 	 */
-	btrfs_double_extent_lock(src, off, inode, destoff, len);
+	end = destoff + len - 1;
+	lock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_state);
 	ret = btrfs_clone(src, inode, off, olen, len, destoff, 0);
-	btrfs_double_extent_unlock(src, off, inode, destoff, len);
+	unlock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_state);
 
 	/*
 	 * We may have copied an inline extent into a page of the destination
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f96f267fb4aa..8fe495d74776 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1127,16 +1127,22 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 						    fs_info->sectorsize));
 				WARN_ON(!IS_ALIGNED(end, fs_info->sectorsize));
 				end--;
+				/* Take mmap lock to serialize with reflinks. */
+				if (!down_read_trylock(&BTRFS_I(inode)->i_mmap_lock))
+					continue;
 				ret = try_lock_extent(&BTRFS_I(inode)->io_tree,
 						      key.offset, end,
 						      &cached_state);
-				if (!ret)
+				if (!ret) {
+					up_read(&BTRFS_I(inode)->i_mmap_lock);
 					continue;
+				}
 
 				btrfs_drop_extent_map_range(BTRFS_I(inode),
 							    key.offset, end, true);
 				unlock_extent(&BTRFS_I(inode)->io_tree,
 					      key.offset, end, &cached_state);
+				up_read(&BTRFS_I(inode)->i_mmap_lock);
 			}
 		}
 
-- 
2.43.0


