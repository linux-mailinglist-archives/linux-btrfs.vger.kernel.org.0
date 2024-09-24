Return-Path: <linux-btrfs+bounces-8193-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F489843F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 12:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C001F2195F
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 10:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2C61A2C3F;
	Tue, 24 Sep 2024 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jl5Wcy8f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA3A1A2C34
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727174750; cv=none; b=gPRM69bpmNV0npBf3p3VDGOnFXjEO+7ZhF2hbwFx97OBHuSmokVVt4wLgRga7VchJUjoyuqDZBDhOPUwt3T0PsBtprHuwqzooZvp29YrW9oBuCpHQR3Hn1eHK0Uw3xHxOUMDeVGZSSlQv9Owf/qXLt1x7z/6ZlaYt4CwGA1bJmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727174750; c=relaxed/simple;
	bh=asbfdfICbRjRicyCGbRpUvpkvk7mTB0InImpUwmcHsI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o0WeT/tUq1bDNflvY0MLMZiDUzKoh+tCnA8ToA55KqT0MQOFPQ4XcG27y0PYk5/c0oQNupO83EZdzH6Rl6ucIIGX0zIxXuaVTZuKLAdjJyF4N364dhv7GStpKuk7ujz7cNdg6Qo4vkDGlPTJpT05lvis0Pf7A8eteNwZn8Vz3LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jl5Wcy8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E615C4CEC6
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 10:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727174750;
	bh=asbfdfICbRjRicyCGbRpUvpkvk7mTB0InImpUwmcHsI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jl5Wcy8f8shIB2PP7/1YLD6scNpYcDE6BIaMDa2Ga37Tz3YVF4+bAvmJb7/i7lAvd
	 gT8UMUOOlniARG7C1USGg5Sb0Kht4tgh9+aEFpzicR5tAAIB+hnj2tXzj75Kj9k7v7
	 6lxeKV3Kuf4Yc5wXe2RrJlBe4rtbrU2hkw78VGSYyIU8UFRR/pgj+vb1KS2hpKtz6d
	 OrsXi9D/xfWq2LwOYx0PeRtpvh3ETPsColufgvGFoi3uWfggT68cvp5k4UjDjQGIxC
	 /UVQMB9UNBRgOVwLp/O7x7ZiXPGAG8vG9pIVDKjyhRsSgIQyEJVtfPyxH761QcftWS
	 xcNUNuJanvuiQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs: add and use helper to remove extent map from its inode's tree
Date: Tue, 24 Sep 2024 11:45:41 +0100
Message-Id: <fb07004bfcdfb702307b484a4910d8d1d4962fc3.1727174151.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727174151.git.fdmanana@suse.com>
References: <cover.1727174151.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Move the common code to remove an extent map from its inode's tree into a
helper function and use it, reducing duplicated code.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 25d191f1ac10..cb2a6f5dce2b 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -77,10 +77,13 @@ static u64 range_end(u64 start, u64 len)
 	return start + len;
 }
 
-static void dec_evictable_extent_maps(struct btrfs_inode *inode)
+static void remove_em(struct btrfs_inode *inode, struct extent_map *em)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
+	rb_erase(&em->rb_node, &inode->extent_tree.root);
+	RB_CLEAR_NODE(&em->rb_node);
+
 	if (!btrfs_is_testing(fs_info) && is_fstree(btrfs_root_id(inode->root)))
 		percpu_counter_dec(&fs_info->evictable_extent_maps);
 }
@@ -333,7 +336,6 @@ static void validate_extent_map(struct btrfs_fs_info *fs_info, struct extent_map
 static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct extent_map_tree *tree = &inode->extent_tree;
 	struct extent_map *merge = NULL;
 	struct rb_node *rb;
 
@@ -365,10 +367,8 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 			em->flags |= EXTENT_FLAG_MERGED;
 
 			validate_extent_map(fs_info, em);
-			rb_erase(&merge->rb_node, &tree->root);
-			RB_CLEAR_NODE(&merge->rb_node);
+			remove_em(inode, merge);
 			free_extent_map(merge);
-			dec_evictable_extent_maps(inode);
 		}
 	}
 
@@ -380,12 +380,10 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 		if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
 			merge_ondisk_extents(em, merge);
 		validate_extent_map(fs_info, em);
-		rb_erase(&merge->rb_node, &tree->root);
-		RB_CLEAR_NODE(&merge->rb_node);
 		em->generation = max(em->generation, merge->generation);
 		em->flags |= EXTENT_FLAG_MERGED;
+		remove_em(inode, merge);
 		free_extent_map(merge);
-		dec_evictable_extent_maps(inode);
 	}
 }
 
@@ -582,12 +580,10 @@ void remove_extent_mapping(struct btrfs_inode *inode, struct extent_map *em)
 	lockdep_assert_held_write(&tree->lock);
 
 	WARN_ON(em->flags & EXTENT_FLAG_PINNED);
-	rb_erase(&em->rb_node, &tree->root);
 	if (!(em->flags & EXTENT_FLAG_LOGGING))
 		list_del_init(&em->list);
-	RB_CLEAR_NODE(&em->rb_node);
 
-	dec_evictable_extent_maps(inode);
+	remove_em(inode, em);
 }
 
 static void replace_extent_mapping(struct btrfs_inode *inode,
-- 
2.43.0


