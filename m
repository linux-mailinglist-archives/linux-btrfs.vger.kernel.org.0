Return-Path: <linux-btrfs+bounces-4329-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595BB8A8193
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 13:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70F46B236C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 11:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54B013D27B;
	Wed, 17 Apr 2024 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecOWDI6I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B2913CF96
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351828; cv=none; b=KWS0WUzHwRphj2cywd6ZkgavuHgbJsw1BC+lMyQx+3+xq/JeerDeuKux0gBSaLIZQ8uhs3WmmJRc7JuQk0aa3qKJGCksxFce9AKdocZjIbObHTLxBI/Q4oQcja1O4K37I/NVDXnnyHoUOP72IAnLPvy0/RoMWmoS9OFkmlKV5xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351828; c=relaxed/simple;
	bh=PBOiZc/yGTGQpRZy+Y/vY9LFPQbJkuTYshHrGRaLEFQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OOv67CG4nFCIeJaE+RJFsBf4XhOYopmxX1UUboW05gg+iDm81qdzazH7tsTlHgYMu8HGFZ8dPYVfwLhre34EK/2xH18Pghk1N7g0yFS4QqieOMcpa8eE8NAS77GyXKkwCItq4fR74nGb751s2Jx2RnPMqLMPR/62fD1E3QaQkeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecOWDI6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C690C4AF0A
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 11:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713351828;
	bh=PBOiZc/yGTGQpRZy+Y/vY9LFPQbJkuTYshHrGRaLEFQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ecOWDI6I+ErOxmwfriQ+oG12V7HqUKl1C08tR2dnIgTtz4zoOmqQGHM2mhis5ykK/
	 uGRoewWqJlN5u78K/GjzHMNwO7dLlNyfn+DY7XbP9HOsjwVh4FABrtA+/lXOprSVpK
	 Qh5PWihiMm16AdsOKiUaKx2z69ArZ/M/SzVFqaj4LDIvZn1lBj/a951IBTpBaHmbDj
	 qx/DB3z6lW5G1WcAM7tJF0fMaYz1pkwy90/m/J06PJ/4DM8HoK/PjwgAeRXlEv9a+w
	 UD7HreA1SEsb37L1PqItPPK55oTet5Ex243VSiwO3TZ0YAl/oTyxl3ZxpzLobyI+71
	 vVn2bCFOk7YhQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs: rename some variables at try_release_extent_mapping()
Date: Wed, 17 Apr 2024 12:03:31 +0100
Message-Id: <4a210b101a5bf6fc2a1dac4e9e66d612ce50d0f2.1713302470.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713302470.git.fdmanana@suse.com>
References: <cover.1713302470.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Rename the following variables:

1) "btrfs_inode" to "inode", because it's shorter to type and clear, and
   we don't have a vfs inode here as well, so there's no confusion;

2) "tree" to "io_tree", to be clear which tree we are dealing with, since
   we use 2 different trees in the function;

3) "map" to "extent_tree" since "map" gives the idea we are dealing with
   an extent map for example, but we are dealing with the inode's extent
   tree (the tree which stores extent maps).

These also makes the next patches simpler.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7b10f47d8f83..6438c3e74756 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2398,9 +2398,9 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 	struct extent_map *em;
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
-	struct btrfs_inode *btrfs_inode = page_to_inode(page);
-	struct extent_io_tree *tree = &btrfs_inode->io_tree;
-	struct extent_map_tree *map = &btrfs_inode->extent_tree;
+	struct btrfs_inode *inode = page_to_inode(page);
+	struct extent_io_tree *io_tree = &inode->io_tree;
+	struct extent_map_tree *extent_tree = &inode->extent_tree;
 
 	if (gfpflags_allow_blocking(mask) &&
 	    page->mapping->host->i_size > SZ_16M) {
@@ -2410,19 +2410,19 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 			u64 cur_gen;
 
 			len = end - start + 1;
-			write_lock(&map->lock);
-			em = lookup_extent_mapping(map, start, len);
+			write_lock(&extent_tree->lock);
+			em = lookup_extent_mapping(extent_tree, start, len);
 			if (!em) {
-				write_unlock(&map->lock);
+				write_unlock(&extent_tree->lock);
 				break;
 			}
 			if ((em->flags & EXTENT_FLAG_PINNED) ||
 			    em->start != start) {
-				write_unlock(&map->lock);
+				write_unlock(&extent_tree->lock);
 				free_extent_map(em);
 				break;
 			}
-			if (test_range_bit_exists(tree, em->start,
+			if (test_range_bit_exists(io_tree, em->start,
 						  extent_map_end(em) - 1,
 						  EXTENT_LOCKED))
 				goto next;
@@ -2442,7 +2442,7 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 			 * Otherwise don't remove it, we could be racing with an
 			 * ongoing fast fsync that could miss the new extent.
 			 */
-			fs_info = btrfs_inode->root->fs_info;
+			fs_info = inode->root->fs_info;
 			spin_lock(&fs_info->trans_lock);
 			cur_gen = fs_info->generation;
 			spin_unlock(&fs_info->trans_lock);
@@ -2457,12 +2457,12 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 			 * hurts the fsync performance for workloads with a data
 			 * size that exceeds or is close to the system's memory).
 			 */
-			remove_extent_mapping(btrfs_inode, em);
+			remove_extent_mapping(inode, em);
 			/* once for the rb tree */
 			free_extent_map(em);
 next:
 			start = extent_map_end(em);
-			write_unlock(&map->lock);
+			write_unlock(&extent_tree->lock);
 
 			/* once for us */
 			free_extent_map(em);
@@ -2470,7 +2470,7 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 			cond_resched(); /* Allow large-extent preemption. */
 		}
 	}
-	return try_release_extent_state(tree, page, mask);
+	return try_release_extent_state(io_tree, page, mask);
 }
 
 struct btrfs_fiemap_entry {
-- 
2.43.0


