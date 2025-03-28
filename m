Return-Path: <linux-btrfs+bounces-12647-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71FAA74C7B
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 15:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC283AFD21
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 14:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFE31C3306;
	Fri, 28 Mar 2025 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4F/0FGF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101C41B415F
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743171849; cv=none; b=efzrByaynOS7NI3VYluuujgTINTfNezNGjBspWdVtk9SihAh74MkmZSmhcGqqNeF6FZfbHkKpruJG2mJFauvoH4Mih8l0z3tTK6l60MHnhdAwFCGMUcM0hnLnk2VTBRlcPDdbDhBjh7RDWP9PUDe28LJkYcCWA9HsG4bvpGu1m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743171849; c=relaxed/simple;
	bh=ePZO1L03vuaSEqn+nr+cIWraxlwUOvcINYqAn6Iz1+A=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CEXaqXQKmY5PcOhGhsV8noBHEiiqD5g4r+VkGtP+zyJ7J092+vq261J84Jimy5sbU52/ll51gCTvqXzfsNdzYhCvZ3SXENIYcT73lnIsfq0dVHC8no94qdTf2vNR8qK/iivwQjcsnmQ9fQ+y1GGo9CI3S+Y5sOAwGGvU1RMYs0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4F/0FGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A98BC4CEEA
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 14:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743171848;
	bh=ePZO1L03vuaSEqn+nr+cIWraxlwUOvcINYqAn6Iz1+A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=D4F/0FGFVoIxYDUzeJCEggGY+vqOBPeTQ0u4K10LIRdkk3V0pi6I+makVA+4hGZ+T
	 /YedAJxatUpBl25USCGUl9BefGJvepJN7kOUmKdBxR1rgXlLPrZsXbaIDociT2g6A9
	 4cnLuAXNTcnd2cSEBX+SrhZv1WW/aPLWH/zO86C4/gfwRh89KuL9y1Zy6s5DjaDbcK
	 g1ZeCfxJNixh+xOyC5xNAIJj5m8CA7I+qbXph3NR7xrYGGNdR6I5ZKUJ0t0nD80dEa
	 tpbkoPA6JXvuNis+3iKwyGB1wtl6tF5/alfkpD1HxXYixBRiJscKjlkw6xV4Jggh0s
	 BV7pTmmAoVWoQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: remove leftover EXTENT_UPTODATE clear from an inode's io_tree
Date: Fri, 28 Mar 2025 14:24:02 +0000
Message-Id: <bf2a3a9c338ae2a56cedac14edcb24b33006111a.1743166248.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743166248.git.fdmanana@suse.com>
References: <cover.1743166248.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

After commit 52b029f42751 ("btrfs: remove unnecessary EXTENT_UPTODATE
state in buffered I/O path") we never set EXTENT_UPTODATE in an inode's
io_tree anymore, but we still have some code attempting to clear that
bit from an inode's io_tree. Remove that code as it doesn't do anything
anymore. The sole use of the EXTENT_UPTODATE bit is for the excluded
extents io_tree (fs_info->excluded_extents), which is used to track the
locations of super blocks, so that their ranges are neved marked as free,
making them unavailable for extent allocation.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.h    |  7 -------
 fs/btrfs/inode.c             | 22 ++++++++++------------
 fs/btrfs/relocation.c        |  3 ---
 fs/btrfs/tests/inode-tests.c | 12 ++++--------
 4 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index cf83e094b00e..ac1a59bd2f95 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -203,13 +203,6 @@ int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		   u32 bits, struct extent_state **cached_state);
 
-static inline int clear_extent_uptodate(struct extent_io_tree *tree, u64 start,
-		u64 end, struct extent_state **cached_state)
-{
-	return __clear_extent_bit(tree, start, end, EXTENT_UPTODATE,
-				  cached_state, NULL);
-}
-
 static inline int clear_extent_dirty(struct extent_io_tree *tree, u64 start,
 				     u64 end, struct extent_state **cached)
 {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 469b3fd64f17..95d29b9282ba 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3237,8 +3237,6 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 		btrfs_end_transaction(trans);
 
 	if (ret || truncated) {
-		u64 unwritten_start = start;
-
 		/*
 		 * If we failed to finish this ordered extent for any reason we
 		 * need to make sure BTRFS_ORDERED_IOERR is set on the ordered
@@ -3250,10 +3248,6 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 		if (ret)
 			btrfs_mark_ordered_extent_error(ordered_extent);
 
-		if (truncated)
-			unwritten_start += logical_len;
-		clear_extent_uptodate(io_tree, unwritten_start, end, NULL);
-
 		/*
 		 * Drop extent maps for the part of the extent we didn't write.
 		 *
@@ -3268,9 +3262,15 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 		 * we don't mess with the extent map tree in the NOCOW case, but
 		 * for now simply skip this if we are the free space inode.
 		 */
-		if (!btrfs_is_free_space_inode(inode))
+		if (!btrfs_is_free_space_inode(inode)) {
+			u64 unwritten_start = start;
+
+			if (truncated)
+				unwritten_start += logical_len;
+
 			btrfs_drop_extent_map_range(inode, unwritten_start,
 						    end, false);
+		}
 
 		/*
 		 * If the ordered extent had an IOERR or something else went
@@ -7483,12 +7483,10 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 		 *    Since the IO will never happen for this page.
 		 */
 		btrfs_qgroup_free_data(inode, NULL, cur, range_end + 1 - cur, NULL);
-		if (!inode_evicting) {
+		if (!inode_evicting)
 			clear_extent_bit(tree, cur, range_end, EXTENT_LOCKED |
-				 EXTENT_DELALLOC | EXTENT_UPTODATE |
-				 EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG |
-				 extra_flags, &cached_state);
-		}
+					 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
+					 EXTENT_DEFRAG | extra_flags, &cached_state);
 		cur = range_end + 1;
 	}
 	/*
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f948f4f6431c..ddcd98c59d33 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2706,9 +2706,6 @@ static noinline_for_stack int prealloc_file_extent_cluster(struct reloc_control
 		if (ret < 0)
 			return ret;
 
-		clear_extent_bits(&inode->io_tree, i_size,
-				  round_up(i_size, PAGE_SIZE) - 1,
-				  EXTENT_UPTODATE);
 		folio = filemap_lock_folio(mapping, i_size >> PAGE_SHIFT);
 		/*
 		 * If page is freed we don't need to do anything then, as we
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index 3ea3bc2225fe..8142a84129b6 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -952,8 +952,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	ret = clear_extent_bit(&BTRFS_I(inode)->io_tree,
 			       BTRFS_MAX_EXTENT_SIZE >> 1,
 			       (BTRFS_MAX_EXTENT_SIZE >> 1) + sectorsize - 1,
-			       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
-			       EXTENT_UPTODATE, NULL);
+			       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW, NULL);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1020,8 +1019,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	ret = clear_extent_bit(&BTRFS_I(inode)->io_tree,
 			       BTRFS_MAX_EXTENT_SIZE + sectorsize,
 			       BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1,
-			       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
-			       EXTENT_UPTODATE, NULL);
+			       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW, NULL);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1053,8 +1051,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 
 	/* Empty */
 	ret = clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
-			       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
-			       EXTENT_UPTODATE, NULL);
+			       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW, NULL);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1069,8 +1066,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 out:
 	if (ret)
 		clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
-				 EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
-				 EXTENT_UPTODATE, NULL);
+				 EXTENT_DELALLOC | EXTENT_DELALLOC_NEW, NULL);
 	iput(inode);
 	btrfs_free_dummy_root(root);
 	btrfs_free_dummy_fs_info(fs_info);
-- 
2.45.2


