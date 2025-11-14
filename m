Return-Path: <linux-btrfs+bounces-19024-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D465C5F15D
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 20:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A19420B7D
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 19:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C9534A78F;
	Fri, 14 Nov 2025 19:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="KwmFwkde"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F7431AF36;
	Fri, 14 Nov 2025 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763149510; cv=none; b=scml8HuQzU7fsR5MBBMon7MRuwISIG7sVsHX3CRsLZ488ckIZOOBOA4yHqiqnktHH0oZu9LGRkEbBuT0J9G7qkkU+gMZ4ITp29pDDw0s9AR1AaF5FXjHcwT1nMgU3GYSKNKfeY8X04G40b4UACzFn6jjGSsGUmReLRR8LHI/+v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763149510; c=relaxed/simple;
	bh=276+AyzpGNnUmKkwVH26e5fP6twGMvrTfffc7vfgOgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aeiuSaZXqw4tug0rZbYIb9+NtAWa0XVOmjtHXZtEE0czQfsmRZpta25fHAhfU36ksrl7NsL0dhgXr223zW3iV/Rvb/gPOYavaX+afDnZ+qmCWEM8gj9UwrJZexBB3EDwGcNdmPIVTCSOsDGyoR6U8/s7Jfl+GjZqFUdoj7DQu4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=KwmFwkde; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Andrey Kalachev <kalachev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1763149500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AvdA8HvIC8ETH3XJcIDaT9BkC8aO1bNiY1uexYT0iqg=;
	b=KwmFwkde1jH+327kC+JsDPh7W31PqjNrCcNdIqAxH15Z6mc9tgSxCAiv6JcctR72TeVcAZ
	YE7IH/SvG0cFSA/tymRPq49RgD+Riv0WNyd3zNtJ8P+SozI/SswDHykp8sX4IkUhShJK59
	1o1t9XLSUqGVUtpC3MkRG96ysUr7IRI=
To: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fdmanana@suse.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: stable@vger.kernel.org,
	kalachev@swemel.ru,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1.y v2 5/6] btrfs: reuse cloned extent buffer during fiemap to avoid re-allocations
Date: Fri, 14 Nov 2025 22:44:37 +0300
Message-Id: <20251114194438.5694-6-kalachev@swemel.ru>
In-Reply-To: <20251114194438.5694-1-kalachev@swemel.ru>
References: <20251030131254.9225-1-kalachev@swemel.ru>
 <20251114194438.5694-1-kalachev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 1cab1375ba6d5337a25acb346996106c12bb2dd0 ]

During fiemap we may have to visit multiple leaves of the subvolume's
inode tree, and each time we are freeing and allocating an extent buffer
to use as a clone of each visited leaf. Optimize this by reusing cloned
extent buffers, to avoid the freeing and re-allocation both of the extent
buffer structure itself and more importantly of the pages attached to the
extent buffer.

CC: stable@vger.kernel.org # 6.1
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[cherry picked from upstream commit]
Signed-off-by: Andrey Kalachev <kalachev@swemel.ru>
---
 fs/btrfs/extent_io.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b65cd7adb7e3..da90e5a5f855 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3800,7 +3800,7 @@ static int emit_last_fiemap_cache(struct fiemap_extent_info *fieinfo,
 
 static int fiemap_next_leaf_item(struct btrfs_inode *inode, struct btrfs_path *path)
 {
-	struct extent_buffer *clone;
+	struct extent_buffer *clone = path->nodes[0];
 	struct btrfs_key key;
 	int slot;
 	int ret;
@@ -3809,29 +3809,45 @@ static int fiemap_next_leaf_item(struct btrfs_inode *inode, struct btrfs_path *p
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
2.39.5


