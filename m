Return-Path: <linux-btrfs+bounces-4152-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009A98A1CB9
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 19:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22EEDB2B9C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 17:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F0F181BA7;
	Thu, 11 Apr 2024 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdiPxl5B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B3B180A73
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852366; cv=none; b=j3B27USezwuPdDb0wWmCWnAsMrWc+qRnYeReaZAdrjroRh2gWlOBSCZY1kRW1idVpGiGKb2Ubairr3fnUeeIxDHcE3bageS9YnvWYF8Y87j9pYvA0IPTjIr1y7pzLd9k606QYAhLAYl6n594FWKYgeY/LcD8fB/mYVEVBb7YOls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852366; c=relaxed/simple;
	bh=TJwFNHUjYoJ+JCI3wVQ+01oev1ZWlC8DHs1UdVlyE/M=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QquEq8YClqYTwZ1Ij6py6jYAIRAsKsdKpzsnrzTw33JAhwWmJJptrg/RB+ZFnINOquyS5EWN9stGuymYdCiBvXB4Jm7Hk6YIERsug1hFx3TaM0aXKEROR8W0evgkPThqGUspd1NYE3r0O8qpU/Ua65F9s5UwmeZ/5rrGdaiFmkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdiPxl5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F77FC113CE
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712852365;
	bh=TJwFNHUjYoJ+JCI3wVQ+01oev1ZWlC8DHs1UdVlyE/M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NdiPxl5BFWa0j9O9MrEH0d4SniN6KMx0DfkcSU0FMHhiJ4NZBom3gvUyuyObyKi6z
	 OMJiFN7+48AtrSIrz3BpGyP60yyNkgIBW0Eea907Ra0hvznJzAUz25xzEHRqgVMrEt
	 cPMQjxyjQL7uKTPuH94hO7M6Yk6NdfMvGTNkzrGSFN4uLlePh7fNtaCi2nxNgrIcvI
	 IaM3DlwK6gnKiO2yadC4UNeaB2BJ9PFszctspnV95hL/KxkY/PrRZMSLOEFLIo7htK
	 O+eFqaSP6kCN3dk3VSutziC0mmL6ISX+5TceiiM5p8TEAwsv5XcuhBkC+TROJKPMcS
	 XbL9gTQ8fCRGQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 09/15] btrfs: pass the extent map tree's inode to try_merge_map()
Date: Thu, 11 Apr 2024 17:19:03 +0100
Message-Id: <81628b9abb3ece8fd7e35a521068cfa958aca112.1712837044.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712837044.git.fdmanana@suse.com>
References: <cover.1712837044.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Extent maps are always associated to an inode's extent map tree, so
there's no need to pass the extent map tree explicitly to try_merge_map().

In order to facilitate an upcoming change that adds a shrinker for extent
maps, change try_merge_map() to receive the inode instead of its extent
map tree.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 2753bf2964cb..97a8e0484415 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -223,8 +223,9 @@ static bool mergeable_maps(const struct extent_map *prev, const struct extent_ma
 	return next->block_start == prev->block_start;
 }
 
-static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
+static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 {
+	struct extent_map_tree *tree = &inode->extent_tree;
 	struct extent_map *merge = NULL;
 	struct rb_node *rb;
 
@@ -322,7 +323,7 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
 	em->generation = gen;
 	em->flags &= ~EXTENT_FLAG_PINNED;
 
-	try_merge_map(tree, em);
+	try_merge_map(inode, em);
 
 out:
 	write_unlock(&tree->lock);
@@ -333,13 +334,11 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
 
 void clear_em_logging(struct btrfs_inode *inode, struct extent_map *em)
 {
-	struct extent_map_tree *tree = &inode->extent_tree;
-
-	lockdep_assert_held_write(&tree->lock);
+	lockdep_assert_held_write(&inode->extent_tree.lock);
 
 	em->flags &= ~EXTENT_FLAG_LOGGING;
 	if (extent_map_in_tree(em))
-		try_merge_map(tree, em);
+		try_merge_map(inode, em);
 }
 
 static inline void setup_extent_mapping(struct btrfs_inode *inode,
@@ -353,7 +352,7 @@ static inline void setup_extent_mapping(struct btrfs_inode *inode,
 	if (modified)
 		list_add(&em->list, &inode->extent_tree.modified_extents);
 	else
-		try_merge_map(&inode->extent_tree, em);
+		try_merge_map(inode, em);
 }
 
 /*
-- 
2.43.0


