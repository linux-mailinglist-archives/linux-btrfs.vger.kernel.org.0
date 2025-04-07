Return-Path: <linux-btrfs+bounces-12847-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1657CA7E8B2
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 19:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA08F17DF2B
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 17:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96BB253334;
	Mon,  7 Apr 2025 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+ZE+OIv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2A024FC1E
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047396; cv=none; b=CbPwmNE8+Y7aD3XdtauPmTmEGLyNn8LykAaZ+LTewJY6qRzJlKRLoSV0AQLwlHLws4mM/RhKawgf6nyYdATiGlgUp4JAc+JLPvcOSmKHPJziuifKs6siBRElp0YARP4g1/kJqQljdU7n6AF6+H6PIjmFWKAJtFLs1LTrqLuUu1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047396; c=relaxed/simple;
	bh=8nMgRM3glKbgz3BkQoB9ryOVhGCwHNCcclSO5dmhL1w=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P8t6Tcglhb4sf8RDjkFis7Wo2LgkCYU+hZ3ZIB9zv8FY1HeKVhhdxSgpKYJos4IyDaw1sSg6z6OOkJ/EDtOOJobCfrMH7jU+gDfVhIJL/fhvnbYLuQj74E4594k6q4kMWky3zc2aNxT3iJWHo/Vi1MKR5hVpA8ETJXbSXHzN7iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+ZE+OIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79230C4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047396;
	bh=8nMgRM3glKbgz3BkQoB9ryOVhGCwHNCcclSO5dmhL1w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f+ZE+OIv+OZihL7zL9+QD3Q+CfJdO0qFUyZyUbXT5MWROC6gyASExEKyjV0UyHYDN
	 UBfuEEmAotTMilCUPtXtC44OEWN1rMFntdk6PWA+ULqECRlc12VEgqDVXWhtnhYehD
	 ifgZ1RSGIbujvynZlu4UMOO6jFSfDW897kd9JQItL56E0wX0hp2irvPbIxvxK24RaN
	 Q7+WiM8ql3THSUVF/MaxEByuP+mZd5ztrIFpkw/e3Re1rjQnmynsyuGN/VwGW9cwsn
	 wjAtI99uMWqR5cjNxIrf6YLhcM8MCEdnwW5earsPoO7pQsk32THYRSXse81zCASe+t
	 F37YtVaTnWtew==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 09/16] btrfs: rename the functions to get inode and fs_info from an extent io tree
Date: Mon,  7 Apr 2025 18:36:16 +0100
Message-Id: <368f74e86d5c48e92353864f637be7da491a37ed.1744046765.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744046765.git.fdmanana@suse.com>
References: <cover.1744046765.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

These functions are exported so they should have a 'btrfs_' prefix by
convention, to make it clear they are btrfs specific and to avoid
collisions with functions from elsewhere in the kernel.

So add a 'btrfs_' prefix to their name to make it clear they are from
btrfs. Also remove the 'const' suffix from extent_io_tree_to_inode_const()
since there's no non-const variant anymore and makes the naming consistent
with extent_io_tree_to_fs_info() (no 'const' suffix and returns a const
pointer).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c    | 10 +++++-----
 fs/btrfs/extent-io-tree.h    |  4 ++--
 include/trace/events/btrfs.h | 12 ++++++------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 245b78c65edd..abf0f83a15cb 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -65,7 +65,7 @@ static inline void __btrfs_debug_check_extent_io_range(const char *caller,
 	if (tree->owner != IO_TREE_INODE_IO)
 		return;
 
-	inode = extent_io_tree_to_inode_const(tree);
+	inode = btrfs_extent_io_tree_to_inode(tree);
 	isize = i_size_read(&inode->vfs_inode);
 	if (end >= PAGE_SIZE && (end % 2) == 0 && end != isize - 1) {
 		btrfs_debug_rl(inode->root->fs_info,
@@ -81,7 +81,7 @@ static inline void __btrfs_debug_check_extent_io_range(const char *caller,
 #endif
 
 /* Read-only access to the inode. */
-const struct btrfs_inode *extent_io_tree_to_inode_const(const struct extent_io_tree *tree)
+const struct btrfs_inode *btrfs_extent_io_tree_to_inode(const struct extent_io_tree *tree)
 {
 	if (tree->owner == IO_TREE_INODE_IO)
 		return tree->inode;
@@ -89,7 +89,7 @@ const struct btrfs_inode *extent_io_tree_to_inode_const(const struct extent_io_t
 }
 
 /* For read-only access to fs_info. */
-const struct btrfs_fs_info *extent_io_tree_to_fs_info(const struct extent_io_tree *tree)
+const struct btrfs_fs_info *btrfs_extent_io_tree_to_fs_info(const struct extent_io_tree *tree)
 {
 	if (tree->owner == IO_TREE_INODE_IO)
 		return tree->inode->root->fs_info;
@@ -334,7 +334,7 @@ static void __cold extent_io_tree_panic(const struct extent_io_tree *tree,
 					const char *opname,
 					int err)
 {
-	btrfs_panic(extent_io_tree_to_fs_info(tree), err,
+	btrfs_panic(btrfs_extent_io_tree_to_fs_info(tree), err,
 		    "extent io tree error on %s state start %llu end %llu",
 		    opname, state->start, state->end);
 }
@@ -936,7 +936,7 @@ int btrfs_find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
 	struct extent_state *state;
 	int ret = 1;
 
-	ASSERT(!btrfs_fs_incompat(extent_io_tree_to_fs_info(tree), NO_HOLES));
+	ASSERT(!btrfs_fs_incompat(btrfs_extent_io_tree_to_fs_info(tree), NO_HOLES));
 
 	spin_lock(&tree->lock);
 	state = find_first_extent_bit_state(tree, start, bits);
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 60fedf1b855e..361d27c6b294 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -134,8 +134,8 @@ struct extent_state {
 #endif
 };
 
-const struct btrfs_inode *extent_io_tree_to_inode_const(const struct extent_io_tree *tree);
-const struct btrfs_fs_info *extent_io_tree_to_fs_info(const struct extent_io_tree *tree);
+const struct btrfs_inode *btrfs_extent_io_tree_to_inode(const struct extent_io_tree *tree);
+const struct btrfs_fs_info *btrfs_extent_io_tree_to_fs_info(const struct extent_io_tree *tree);
 
 void extent_io_tree_init(struct btrfs_fs_info *fs_info,
 			 struct extent_io_tree *tree, unsigned int owner);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index efc06599bc53..afc31c26efd5 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2069,8 +2069,8 @@ TRACE_EVENT(btrfs_set_extent_bit,
 		__field(	unsigned,	set_bits)
 	),
 
-	TP_fast_assign_btrfs(extent_io_tree_to_fs_info(tree),
-		const struct btrfs_inode *inode = extent_io_tree_to_inode_const(tree);
+	TP_fast_assign_btrfs(btrfs_extent_io_tree_to_fs_info(tree),
+		const struct btrfs_inode *inode = btrfs_extent_io_tree_to_inode(tree);
 
 		__entry->owner		= tree->owner;
 		__entry->ino		= inode ? btrfs_ino(inode) : 0;
@@ -2102,8 +2102,8 @@ TRACE_EVENT(btrfs_clear_extent_bit,
 		__field(	unsigned,	clear_bits)
 	),
 
-	TP_fast_assign_btrfs(extent_io_tree_to_fs_info(tree),
-		const struct btrfs_inode *inode = extent_io_tree_to_inode_const(tree);
+	TP_fast_assign_btrfs(btrfs_extent_io_tree_to_fs_info(tree),
+		const struct btrfs_inode *inode = btrfs_extent_io_tree_to_inode(tree);
 
 		__entry->owner		= tree->owner;
 		__entry->ino		= inode ? btrfs_ino(inode) : 0;
@@ -2136,8 +2136,8 @@ TRACE_EVENT(btrfs_convert_extent_bit,
 		__field(	unsigned,	clear_bits)
 	),
 
-	TP_fast_assign_btrfs(extent_io_tree_to_fs_info(tree),
-		const struct btrfs_inode *inode = extent_io_tree_to_inode_const(tree);
+	TP_fast_assign_btrfs(btrfs_extent_io_tree_to_fs_info(tree),
+		const struct btrfs_inode *inode = btrfs_extent_io_tree_to_inode(tree);
 
 		__entry->owner		= tree->owner;
 		__entry->ino		= inode ? btrfs_ino(inode) : 0;
-- 
2.45.2


