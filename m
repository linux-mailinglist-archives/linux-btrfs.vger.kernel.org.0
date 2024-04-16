Return-Path: <linux-btrfs+bounces-4301-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA5D8A6BD9
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 15:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A7B284C61
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 13:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B067D12C479;
	Tue, 16 Apr 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLrKwERt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D360E12C46F
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272896; cv=none; b=K1uVGsKcJKUicGblIvfGK1JIhQQTLJG2KF0PUNv84I7H7JA6mJnBaG9mhtMsIR7v370/JmClM7kY6or44dn8l1iMIQxVa4GfljaJnZObzmgxEYnmCN8T6V7rdHL40LD+EH1Ef23ZVshMGg5hmYc8BVUtxZciv14sK/ij1zGOqX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272896; c=relaxed/simple;
	bh=8HfSaAjT/yeLH+ayO4nZ8dl13t3iIuN/O+BrjmMmnAo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FvPCyzKjWyrzl/sdVZz0K3JDqFEYEHkKAIoFjwxY5A4ydCZa1E6fr6ZLWkkqvVaocxBMCiDMpmgUPKWvgzYE+atY3MxEa45TkAKz3FIyweVf3R2Vx+NYuiL5mdaINL01OpMQDSBaWG20dnH2NG5SP9lPdiJXVriJRy0+jKheQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLrKwERt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FB3C32783
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 13:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713272896;
	bh=8HfSaAjT/yeLH+ayO4nZ8dl13t3iIuN/O+BrjmMmnAo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bLrKwERtcKFXxJiUqrrrwtAVEe8io+HWDFTWE4tHHhvX0sWBdoW//4hTIH74JCDsR
	 Sto3RQhm1ecujHpGiDd5VGELT8DqQf7B24UxSFHsAHehV4bsJDDnExFKJ0UgLnQZCp
	 +4/0dCp+UFMa3GzKcAd2ldt/OAz5eFevUDdexTQfK1hi8zjJ5xqEL4tmkvVTUE/gUh
	 sDcF07haWcpjBMBmnn9KHJKRx9QS94c9l2qVbjCU5yP6nPGVhxPaAZptsOYbuwElxp
	 MFjuZEz1JB+YKxkpo6ONvMdS8Jr9uTMD/AeTu1Qz4n2vSGezd4k+X3S4NcQcRnzrz4
	 lqXlhWzxdmdVg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 01/10] btrfs: pass the extent map tree's inode to add_extent_mapping()
Date: Tue, 16 Apr 2024 14:08:03 +0100
Message-Id: <2230af95994821e09505d0c1a9b65e93a70383f2.1713267925.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713267925.git.fdmanana@suse.com>
References: <cover.1713267925.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Extent maps are always added to an inode's extent map tree, so there's no
need to pass the extent map tree explicitly to add_extent_mapping().

In order to facilitate an upcoming change that adds a shrinker for extent
maps, change add_extent_mapping() to receive the inode instead of its
extent map tree.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index d125d5ab9b1d..d0e0c4e5415e 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -355,21 +355,22 @@ static inline void setup_extent_mapping(struct extent_map_tree *tree,
 }
 
 /*
- * Add new extent map to the extent tree
+ * Add a new extent map to an inode's extent map tree.
  *
- * @tree:	tree to insert new map in
+ * @inode:	the target inode
  * @em:		map to insert
  * @modified:	indicate whether the given @em should be added to the
  *	        modified list, which indicates the extent needs to be logged
  *
- * Insert @em into @tree or perform a simple forward/backward merge with
- * existing mappings.  The extent_map struct passed in will be inserted
- * into the tree directly, with an additional reference taken, or a
- * reference dropped if the merge attempt was successful.
+ * Insert @em into the @inode's extent map tree or perform a simple
+ * forward/backward merge with existing mappings.  The extent_map struct passed
+ * in will be inserted into the tree directly, with an additional reference
+ * taken, or a reference dropped if the merge attempt was successful.
  */
-static int add_extent_mapping(struct extent_map_tree *tree,
+static int add_extent_mapping(struct btrfs_inode *inode,
 			      struct extent_map *em, int modified)
 {
+	struct extent_map_tree *tree = &inode->extent_tree;
 	int ret;
 
 	lockdep_assert_held_write(&tree->lock);
@@ -508,7 +509,7 @@ static struct extent_map *prev_extent_map(struct extent_map *em)
  * and an extent that you want to insert, deal with overlap and insert
  * the best fitted new extent into the tree.
  */
-static noinline int merge_extent_mapping(struct extent_map_tree *em_tree,
+static noinline int merge_extent_mapping(struct btrfs_inode *inode,
 					 struct extent_map *existing,
 					 struct extent_map *em,
 					 u64 map_start)
@@ -542,7 +543,7 @@ static noinline int merge_extent_mapping(struct extent_map_tree *em_tree,
 		em->block_start += start_diff;
 		em->block_len = em->len;
 	}
-	return add_extent_mapping(em_tree, em, 0);
+	return add_extent_mapping(inode, em, 0);
 }
 
 /*
@@ -570,7 +571,6 @@ int btrfs_add_extent_mapping(struct btrfs_inode *inode,
 {
 	int ret;
 	struct extent_map *em = *em_in;
-	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
 	/*
@@ -580,7 +580,7 @@ int btrfs_add_extent_mapping(struct btrfs_inode *inode,
 	if (em->block_start == EXTENT_MAP_INLINE)
 		ASSERT(em->start == 0);
 
-	ret = add_extent_mapping(em_tree, em, 0);
+	ret = add_extent_mapping(inode, em, 0);
 	/* it is possible that someone inserted the extent into the tree
 	 * while we had the lock dropped.  It is also possible that
 	 * an overlapping map exists in the tree
@@ -588,7 +588,7 @@ int btrfs_add_extent_mapping(struct btrfs_inode *inode,
 	if (ret == -EEXIST) {
 		struct extent_map *existing;
 
-		existing = search_extent_mapping(em_tree, start, len);
+		existing = search_extent_mapping(&inode->extent_tree, start, len);
 
 		trace_btrfs_handle_em_exist(fs_info, existing, em, start, len);
 
@@ -609,8 +609,7 @@ int btrfs_add_extent_mapping(struct btrfs_inode *inode,
 			 * The existing extent map is the one nearest to
 			 * the [start, start + len) range which overlaps
 			 */
-			ret = merge_extent_mapping(em_tree, existing,
-						   em, start);
+			ret = merge_extent_mapping(inode, existing, em, start);
 			if (WARN_ON(ret)) {
 				free_extent_map(em);
 				*em_in = NULL;
@@ -818,8 +817,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			} else {
 				int ret;
 
-				ret = add_extent_mapping(em_tree, split,
-							 modified);
+				ret = add_extent_mapping(inode, split, modified);
 				/* Logic error, shouldn't happen. */
 				ASSERT(ret == 0);
 				if (WARN_ON(ret != 0) && modified)
@@ -909,7 +907,7 @@ int btrfs_replace_extent_map_range(struct btrfs_inode *inode,
 	do {
 		btrfs_drop_extent_map_range(inode, new_em->start, end, false);
 		write_lock(&tree->lock);
-		ret = add_extent_mapping(tree, new_em, modified);
+		ret = add_extent_mapping(inode, new_em, modified);
 		write_unlock(&tree->lock);
 	} while (ret == -EEXIST);
 
@@ -990,7 +988,7 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_mid->ram_bytes = split_mid->len;
 	split_mid->flags = flags;
 	split_mid->generation = em->generation;
-	add_extent_mapping(em_tree, split_mid, 1);
+	add_extent_mapping(inode, split_mid, 1);
 
 	/* Once for us */
 	free_extent_map(em);
-- 
2.43.0


