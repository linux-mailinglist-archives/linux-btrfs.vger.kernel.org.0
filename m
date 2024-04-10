Return-Path: <linux-btrfs+bounces-4102-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A2189F0DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 13:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB261F2279D
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 11:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0BC15E800;
	Wed, 10 Apr 2024 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5SVKY+w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB26715E7E3
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748531; cv=none; b=PTWyKQZcPvFqE/ySofTw4FBaGimHinq6J5i27osZ1Kt7v9U3ayoJceqsIk4GBroLZLyCN5zBkEJkGEma5b5nkjUsoQrm414diQZDUxn3L/VBwcwCVV1VgWK0t7lWJAghGaFM41vIkqRZvSTd5A+BReAohEci2h5DTO+kvjGAUQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748531; c=relaxed/simple;
	bh=tVKbSnVlp+ohQ93ZUlxwb7rViyg8CHOrTu1JqhUmt2g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Myn6oYjzJ0os2/mjh5/uriGaIAG5ke7CAq/QBb8yBbn8fWTrPDCOkeM9g9oWd3zYdTJdnYLc+z620KAwpM4zEPcsom9lAe3OgklJ0Y63KPybmCZUJeJTk9lma7SQsh0pjZLSwN4HtjU5Th1GqGZ1caWifTLgFvelxdvSTotTm2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5SVKY+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280B1C433F1
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 11:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712748531;
	bh=tVKbSnVlp+ohQ93ZUlxwb7rViyg8CHOrTu1JqhUmt2g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=U5SVKY+wTI4NX5Ku3SYOdCFPMLwT9/p7RPu1lOngJpF9l9Gr21kHlobbZbezSUd88
	 aL7UJY8EoX4++GRoo81Mj6WNg1TJNoLeVJnmYXclxnDb8Yc1eaCO9O69Is56O6UXcr
	 wuv4ZQ2tRWQRSU6mxZQT3Jm5xLK2JeEakLViWvd/X3F13Cjj0Ml2EFI6eY6uoFYGHF
	 hEv+RigNQEdo1b3pznSO2GZItzUTylk7tOQGNd1JoVVMpMA0EYWF3NsWJ0VOy9NRzW
	 5nHS+ekDzRwiRnxiIM4NjDMA2itDJWpXETbLREixC7MySU4+D0hLUeKTR1AsPPR/4D
	 yRUmIZUXjjRBw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 04/11] btrfs: pass the extent map tree's inode to add_extent_mapping()
Date: Wed, 10 Apr 2024 12:28:36 +0100
Message-Id: <a603068d5188895408247a4033689350c0d9fe92.1712748143.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712748143.git.fdmanana@suse.com>
References: <cover.1712748143.git.fdmanana@suse.com>
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


