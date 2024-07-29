Return-Path: <linux-btrfs+bounces-6843-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8697093F8B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 16:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC681C21B4C
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 14:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD86155A56;
	Mon, 29 Jul 2024 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdUlTAAH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBBB1553B3
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264689; cv=none; b=jl7gb2ei705XsXGgLFVe8AuBPD4IZvxkhXQ0kYlUyfMkbmEHvSindwzLudiviJ8GTmkzuoFMm+ctdl/Sy/Kgmb4vkEDk5169FODyyLNdVhGSxLKRlLuZRaLc41/yFbAeQ+2O2k1OIPcEdHAZ72yWAipXTin8s7kSqz8GINZxgmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264689; c=relaxed/simple;
	bh=MzRZBIDmxYfnDXXFinpAsmHEfbqFzIStQpMKmXTBvRg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H9YciUovBvzlbOWRupwZABKQQsefwv6hp78zor2PZfke1Q7mCVlmKVZnUj7/T8IhIdsoUK/7/DOwcRqFMlV9e5YebVB2qCaZD42xV5t9eBIGb1/C3bLyB2QHZA+x0rR6AEueMKGA4CSJrwCPsijBfIg2ZgCP+d8TkDoroGOdrro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdUlTAAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A097C4AF09
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 14:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722264688;
	bh=MzRZBIDmxYfnDXXFinpAsmHEfbqFzIStQpMKmXTBvRg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NdUlTAAHTw3TSirBk/szG1znxRn5czZOoZq2t9VeHxhIjnw1cSs4GyNeFiodo40oU
	 bhUMrc5NmHckbzNcwPYQQfhaSjlclERoBrngimp3S8rdGNZHDO9uPYxdYZIO8prXFJ
	 Ty07kpbOqKZbInb3jz03b/9nCy67/tQ/qJruEP6UzO4Io2mCkZUDBAKVKeqozYi1yK
	 T3wmJ8hEGy1Uo68uY8YiSSN/C73rWerb6Kb5YDAXl/1e1FXF9+xrMBc6Esyon7EeOU
	 YEd9EFottihDyar/BC9BHG6CkCiaYxf+EwlOeyeh9TIOKHVLIffaKo481OIlQVfmrK
	 dlMT56TYS1saw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: more efficient chunk map iteration when device replace finishes
Date: Mon, 29 Jul 2024 15:51:23 +0100
Message-Id: <ab207c82fc8596fcfc4e21169011e8657ee945fa.1722264391.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722264391.git.fdmanana@suse.com>
References: <cover.1722264391.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When iterating the chunk maps when a device replace finishes we are doing
a full rbtree search for each chunk map, which is not the most efficient
thing to do, wasting CPU time. As we are holdwing a write lock on the tree
during the whole iteration, we can simply start from the first node in the
tree and then move to the next chunk map by doing a rb_next() call - the
only exception is when we need to reschedule, in which case we have to do
a full rbtree search since we dropped the write lock and the tree may have
changed (chunk maps may have been removed and the tree got rebalanced).
So just do that.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/dev-replace.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 20cf5e95f2bc..83d5cdd77f29 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -824,8 +824,7 @@ static void btrfs_dev_replace_update_device_in_mapping_tree(
 						struct btrfs_device *srcdev,
 						struct btrfs_device *tgtdev)
 {
-	u64 start = 0;
-	int i;
+	struct rb_node *node;
 
 	/*
 	 * The chunk mutex must be held so that no new chunks can be created
@@ -836,19 +835,34 @@ static void btrfs_dev_replace_update_device_in_mapping_tree(
 	lockdep_assert_held(&fs_info->chunk_mutex);
 
 	write_lock(&fs_info->mapping_tree_lock);
-	do {
+	node = rb_first_cached(&fs_info->mapping_tree);
+	while (node) {
+		struct rb_node *next = rb_next(node);
 		struct btrfs_chunk_map *map;
+		u64 next_start;
 
-		map = btrfs_find_chunk_map_nolock(fs_info, start, U64_MAX);
-		if (!map)
-			break;
-		for (i = 0; i < map->num_stripes; i++)
+		map = rb_entry(node, struct btrfs_chunk_map, rb_node);
+		next_start = map->start + map->chunk_len;
+
+		for (int i = 0; i < map->num_stripes; i++)
 			if (srcdev == map->stripes[i].dev)
 				map->stripes[i].dev = tgtdev;
-		start = map->start + map->chunk_len;
-		btrfs_free_chunk_map(map);
-		cond_resched_rwlock_write(&fs_info->mapping_tree_lock);
-	} while (start);
+
+		if (cond_resched_rwlock_write(&fs_info->mapping_tree_lock)) {
+			map = btrfs_find_chunk_map_nolock(fs_info, next_start, U64_MAX);
+			if (!map)
+				break;
+			node = &map->rb_node;
+			/*
+			 * Drop the lookup reference since we are holding the
+			 * lock in write mode and no one can remove the chunk
+			 * map from the tree and drop its tree reference.
+			 */
+			btrfs_free_chunk_map(map);
+		} else {
+			node = next;
+		}
+	}
 	write_unlock(&fs_info->mapping_tree_lock);
 }
 
-- 
2.43.0


