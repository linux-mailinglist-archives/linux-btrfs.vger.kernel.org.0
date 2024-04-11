Return-Path: <linux-btrfs+bounces-4151-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DFD8A1C5F
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 19:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C12F1F24332
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 17:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424F318413F;
	Thu, 11 Apr 2024 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+MchUYV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25540184113
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852365; cv=none; b=aajBPyPZwVoVZsl+k4RgUYvxMNQ0HDdaG3Ka2e9b2eYnfyGALNDHJ7U3oXnrMZCTvT252eiGrNfBtHtm25fXGlIStynP8DetcMSvLJkde64aR7kT+CMWH1VNwjtSGEJoMVaIhoG2ODAvLI1LD+gjn1x4LTRYsj9A8m3HgBAfHA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852365; c=relaxed/simple;
	bh=WEOs238PXlFyLYxlpU8huS8p/TvCwvsSg+SMm+wz+Oc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NWMQP3yr8ucHPVNxhpUjDx0ptpjpFdceAFDmRVBAbsKMBKC9Sx5CsQ46tEkI9aW0CItvOpxT9c6V+c8l3fZmGRQZjMWDBEtpi0H1PmBWr60PBGegDKvHemXwZE0FZMdyoWCcHOAFQwSZ7lpGDOkivEC/ihW+pcdKnZbZ6dxsW8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+MchUYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00369C072AA
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712852364;
	bh=WEOs238PXlFyLYxlpU8huS8p/TvCwvsSg+SMm+wz+Oc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=q+MchUYVJJU+B05npPx87x828Xqva7W/NEPCMpbeLe31Qol9esWO8rZfw8gwPQj3H
	 y/1IIJWuenrJHwsbp+74eaw+UL2rI/ftNxTNUFHVBUxwojnktZGCdmYtnx9KSj07GB
	 1A7tNwshtd5fI1G/gdf4G7H8l47SteMOr8+JFWDICplKNHOQqM1D14qC7IwOFpUE4p
	 pZdN81sc7NxDhIdYZdTGaPf2YXbcJ3pcDOYkN+m3Iy/WP9Snvh8U3luhAz/GbYVLcx
	 aiW7yBRhZ8i5W2FleEeQY72e79LhPDMHcOXB9yALsi1GQ9NITMPwraxNRh165Dk6vH
	 hcPqCKP1aCCJw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 08/15] btrfs: pass the extent map tree's inode to setup_extent_mapping()
Date: Thu, 11 Apr 2024 17:19:02 +0100
Message-Id: <7e8a8cc96cc25b31df62ce8a3492c690dc25608d.1712837044.git.fdmanana@suse.com>
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
there's no need to pass the extent map tree explicitly to
setup_extent_mapping().

In order to facilitate an upcoming change that adds a shrinker for extent
maps, change setup_extent_mapping() to receive the inode instead of its
extent map tree.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 15817b842c24..2753bf2964cb 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -342,7 +342,7 @@ void clear_em_logging(struct btrfs_inode *inode, struct extent_map *em)
 		try_merge_map(tree, em);
 }
 
-static inline void setup_extent_mapping(struct extent_map_tree *tree,
+static inline void setup_extent_mapping(struct btrfs_inode *inode,
 					struct extent_map *em,
 					int modified)
 {
@@ -351,9 +351,9 @@ static inline void setup_extent_mapping(struct extent_map_tree *tree,
 	ASSERT(list_empty(&em->list));
 
 	if (modified)
-		list_add(&em->list, &tree->modified_extents);
+		list_add(&em->list, &inode->extent_tree.modified_extents);
 	else
-		try_merge_map(tree, em);
+		try_merge_map(&inode->extent_tree, em);
 }
 
 /*
@@ -381,7 +381,7 @@ static int add_extent_mapping(struct btrfs_inode *inode,
 	if (ret)
 		return ret;
 
-	setup_extent_mapping(tree, em, modified);
+	setup_extent_mapping(inode, em, modified);
 
 	return 0;
 }
@@ -486,7 +486,7 @@ static void replace_extent_mapping(struct btrfs_inode *inode,
 	rb_replace_node_cached(&cur->rb_node, &new->rb_node, &tree->map);
 	RB_CLEAR_NODE(&cur->rb_node);
 
-	setup_extent_mapping(tree, new, modified);
+	setup_extent_mapping(inode, new, modified);
 }
 
 static struct extent_map *next_extent_map(const struct extent_map *em)
-- 
2.43.0


