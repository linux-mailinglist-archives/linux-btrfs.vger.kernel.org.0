Return-Path: <linux-btrfs+bounces-4306-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4358A6BDE
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 15:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487D728525D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 13:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F10C12C538;
	Tue, 16 Apr 2024 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1O6lA2U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC7312C49D
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272901; cv=none; b=eJvUDRYgr/808OaFU8u7y4xXIwLS2wMRzy9qhAqskGnv5Es320O8BmekPzPhRHYVjJBRbyPfilws7Uju4lU9W64UJo5dzjiohgqi3v6m3Kp6fitpvswF17H8tc7o3vaFb2bOxFKZ4hMUT9uz1mXKlLdn80PV3OnoLPWIHIStVWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272901; c=relaxed/simple;
	bh=g91G3/q4bMeb7ReGDD/rMoY+jexL8fbN3ftACf2rvWY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HtHQDKlfGUxycAx2BpIHAPq81B68oO9xQlTn7h717M3wfM+zT5SorGevKuxkctegqIPtqopQbDBCfGprV8lcVehHptddu63EyDFtrGbhvHi4RAl9uzfsUWekoncf0S80qIJEqN+46Ho9BGqvDqg/FEW59eVBOhY8pDtEnm5dXu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1O6lA2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C888FC2BD10
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 13:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713272901;
	bh=g91G3/q4bMeb7ReGDD/rMoY+jexL8fbN3ftACf2rvWY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Y1O6lA2U1glAut8II2mT6oBwAQSDVjLush9NIjxiib5woMXY2XYnjz5tkKHOUe30I
	 CL/iHk5AXCINKqVgiLl9RNbAkD2rkvX82A3r6dIc6CgTLY7HHOHdpT1c9MgcKzh/6m
	 /YKCup9Y7p60Xv3ZmmS21vHDZ11GglgKfEdSBNXB2HDmYZOE/rWM+FxpUPZX3DujOY
	 kQ4VmFEyrIDOp4SDjUNdiYmq4FpwK3ijmX1ZurmrXiBhXLx6myvNgwRabIBjaGvsWp
	 iKJySu6SZZEjWXzAmUb76j6x6Q96PGTG02k93o3g5PcC+1EP06sOPh7+DGV/q8YhZ2
	 JRZa3lw2WwIzg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 06/10] btrfs: pass the extent map tree's inode to try_merge_map()
Date: Tue, 16 Apr 2024 14:08:08 +0100
Message-Id: <7b4df753d47b4efc82769f897708ac146dfaf521.1713267925.git.fdmanana@suse.com>
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
there's no need to pass the extent map tree explicitly to try_merge_map().

In order to facilitate an upcoming change that adds a shrinker for extent
maps, change try_merge_map() to receive the inode instead of its extent
map tree.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
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


