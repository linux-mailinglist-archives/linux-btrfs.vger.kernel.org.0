Return-Path: <linux-btrfs+bounces-2921-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 567A786C8A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 12:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC611F235F1
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 11:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387497CF31;
	Thu, 29 Feb 2024 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzSalE1F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6901D7CF24
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207788; cv=none; b=FNS1P1R6YaTJjSXvQbv/ARbvXplAb2v2+F9uNzSt6rIsWhzW+NZJEfuYUhMkHthWXs2mbgfNJJULtRhXmVZ8cL91hJvWe21Gur4pgS8zvaW5WMjimzjBWwI9vewqE3X06/uSM1OXxezaQXPk34H001KZ7TM+F07fv4E8XdnD8KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207788; c=relaxed/simple;
	bh=eSf2Ml7WBUZ+XXhq0PWzGgjVAtHJRGBmi6UcRNquCfY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RvTRLSUEBW4o2tBtyxSuItywcFBJoGgY0me6oJZPniHZEc9XGywcbnYtxe7hKoDwtTt17vDZtax1O7QGxLAjK0QCem1LvzMAzsA23PRLXUu9sR6ZTnPVNudoYR/cRJiofRK8mrgqGy0PR535AMSwmPR+REKWulZY6D7AtK02j38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzSalE1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67797C43394
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 11:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709207787;
	bh=eSf2Ml7WBUZ+XXhq0PWzGgjVAtHJRGBmi6UcRNquCfY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tzSalE1FHXVy91hBZt67K9CHNtVEHMExyaa+yARL0oAOWxZmNvYBP+yWvPicLS0Yh
	 owGuZzYU7Hzct30qlFbfgqrajH4VMwm64nWa0DP9CMHdy9AMlaGYPCC/AMaWouIZgL
	 SfRSdczS/mkiFR08VOdgqhyVJSFDTN7DkCNXVbfyTP2spUMQdwQkQs2/G270SeLGlm
	 JjXUz2oLuEtdtSpHXDKl3qRuuCAuVSITCD3LjOKV3wL1GfLF7Mzjet4KL+6s843o9G
	 Xbs/AHfe5ohgQ+VcYELPDfzCp4q3m6OkWanKVRwADJn6Yrzw4b9wmO87bU1/Jhvojz
	 YGhfjPW2/g+pg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: reuse cloned extent buffer during fiemap to avoid re-allocations
Date: Thu, 29 Feb 2024 11:56:22 +0000
Message-Id: <37a099ae91d065b51cc34dd69bb11819a57d02f5.1709202499.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709202499.git.fdmanana@suse.com>
References: <cover.1709202499.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

During fiemap we may have to visit multiples leaves of the subvolume's
inode tree, and each time we are freeing and allocating an extent buffer
to use as a clone of each visited leaf. Optimize this by reusing cloned
extent buffers, to avoid the freeing and re-allocation both of the extent
buffer structure itself and more importantly of the pages attached to the
extent buffer.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e7cfffc4e7b5..c7ecfcac34fc 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2750,7 +2750,7 @@ static int emit_last_fiemap_cache(struct fiemap_extent_info *fieinfo,
 
 static int fiemap_next_leaf_item(struct btrfs_inode *inode, struct btrfs_path *path)
 {
-	struct extent_buffer *clone;
+	struct extent_buffer *clone = path->nodes[0];
 	struct btrfs_key key;
 	int slot;
 	int ret;
@@ -2759,29 +2759,45 @@ static int fiemap_next_leaf_item(struct btrfs_inode *inode, struct btrfs_path *p
 	if (path->slots[0] < btrfs_header_nritems(path->nodes[0]))
 		return 0;
 
+	/*
+	 * Add a temporary extra ref to an already cloned extent buffer to
+	 * prevent btrfs_next_leaf() freeing it, we want to reuse it to avoid
+	 * the cost of allocating a new one.
+	 */
+	ASSERT(test_bit(EXTENT_BUFFER_UNMAPPED, &clone->bflags));
+	atomic_inc(&clone->refs);
+
 	ret = btrfs_next_leaf(inode->root, path);
 	if (ret != 0)
-		return ret;
+		goto out;
 
 	/*
 	 * Don't bother with cloning if there are no more file extent items for
 	 * our inode.
 	 */
 	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-	if (key.objectid != btrfs_ino(inode) || key.type != BTRFS_EXTENT_DATA_KEY)
-		return 1;
+	if (key.objectid != btrfs_ino(inode) || key.type != BTRFS_EXTENT_DATA_KEY) {
+		ret = 1;
+		goto out;
+	}
 
 	/* See the comment at fiemap_search_slot() about why we clone. */
-	clone = btrfs_clone_extent_buffer(path->nodes[0]);
-	if (!clone)
-		return -ENOMEM;
+	copy_extent_buffer_full(clone, path->nodes[0]);
+	/*
+	 * Important to preserve the start field, for the optimizations when
+	 * checking if extents are shared (see extent_fiemap()).
+	 */
+	clone->start = path->nodes[0]->start;
 
 	slot = path->slots[0];
 	btrfs_release_path(path);
 	path->nodes[0] = clone;
 	path->slots[0] = slot;
+out:
+	if (ret)
+		free_extent_buffer(clone);
 
-	return 0;
+	return ret;
 }
 
 /*
-- 
2.40.1


