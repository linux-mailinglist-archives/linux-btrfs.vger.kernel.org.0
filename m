Return-Path: <linux-btrfs+bounces-4304-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E6A8A6BDC
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 15:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01A71B20E71
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 13:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B365112C497;
	Tue, 16 Apr 2024 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9yK+yrf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03E312C462
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272900; cv=none; b=VINUYv8yCql6q9SB48JJS3u3QAPjDqlkVJkNoRAekjnA/t+am5b06IsaB3RDgCwNU5zmpwxPUMP9WDg3qriEEjCXO6QwoFsR5q0GTrPxrHkvfXR5aMLUnCzOa0LXiVrIyVIrW2E48bBUJ6C/m2YHxpT7hRyLSoC3K70Gpu5shvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272900; c=relaxed/simple;
	bh=XhLUtIC4Fe2r6iFznUATOGkB7IZocndkxRdtp63EFlM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fMVmkTPzvHkal/c6/ux3KabJUAbV0ODD/V4IXoSj9VrEXKbBtsEMCKJ6T89tP1k3h4stRAxvT42Bk09Ab+SUkuQVNz6R1iI1bgkYA8sTiyntmK0romK9vU4rJfB+dRnDqZboCS1/so8KSyCbep0Xc/lj07c/lFDX4NdwFgNqWig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9yK+yrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2424C2BD11
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 13:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713272899;
	bh=XhLUtIC4Fe2r6iFznUATOGkB7IZocndkxRdtp63EFlM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=E9yK+yrfXjQDaHRWEobFyDhG4HMn6UlpPVG9dN45hRCZ3H6QG8DknCNaOwgtkSxbF
	 G0e8vMZiUTYW2P96Povu2cM/j/N0gXn/iDPY/QtW26jBj6a/dKQdoR/Ky+cykCEsH4
	 ce/DhAcorEbAD4kCW/BAssoiWnIue2EchsV6pLtDdGCAD+dBF7+53ouD/AoQuyJ86x
	 QLgI5TR5MxyVZarnpCWMWbiYEIg1fDJpXwiDwisenq4rqe/DBZqkOIxH48t89NAFUy
	 Fga31jDsKWAOTOmc1trzYUBtx4O1VI+v6UjuDJ6RbJ2Q7GetXHUIca50YzK2/5yFKN
	 WJxVtaiLNXxoA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 04/10] btrfs: pass the extent map tree's inode to replace_extent_mapping()
Date: Tue, 16 Apr 2024 14:08:06 +0100
Message-Id: <a6bd0f93096d8decc2c7fc7e6514225df01e7619.1713267925.git.fdmanana@suse.com>
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

Extent maps are always associated to an inode's extent map tree, so
there's no need to pass the extent map tree explicitly to
replace_extent_mapping().

In order to facilitate an upcoming change that adds a shrinker for extent
maps, change replace_extent_mapping() to receive the inode instead of its
extent map tree.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 289669763965..15817b842c24 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -470,11 +470,13 @@ void remove_extent_mapping(struct btrfs_inode *inode, struct extent_map *em)
 	RB_CLEAR_NODE(&em->rb_node);
 }
 
-static void replace_extent_mapping(struct extent_map_tree *tree,
+static void replace_extent_mapping(struct btrfs_inode *inode,
 				   struct extent_map *cur,
 				   struct extent_map *new,
 				   int modified)
 {
+	struct extent_map_tree *tree = &inode->extent_tree;
+
 	lockdep_assert_held_write(&tree->lock);
 
 	WARN_ON(cur->flags & EXTENT_FLAG_PINNED);
@@ -777,7 +779,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 
 			split->generation = gen;
 			split->flags = flags;
-			replace_extent_mapping(em_tree, em, split, modified);
+			replace_extent_mapping(inode, em, split, modified);
 			free_extent_map(split);
 			split = split2;
 			split2 = NULL;
@@ -818,8 +820,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			}
 
 			if (extent_map_in_tree(em)) {
-				replace_extent_mapping(em_tree, em, split,
-						       modified);
+				replace_extent_mapping(inode, em, split, modified);
 			} else {
 				int ret;
 
@@ -977,7 +978,7 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_pre->flags = flags;
 	split_pre->generation = em->generation;
 
-	replace_extent_mapping(em_tree, em, split_pre, 1);
+	replace_extent_mapping(inode, em, split_pre, 1);
 
 	/*
 	 * Now we only have an extent_map at:
-- 
2.43.0


