Return-Path: <linux-btrfs+bounces-7100-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A3094E1D3
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 17:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61B128156A
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 15:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615C314A4ED;
	Sun, 11 Aug 2024 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGoBbRjT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7913C20323
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723390271; cv=none; b=X5mXT7/NJrz5ni6IADz3hvoinYcolALBYPf2Mb4KLxXVC7QppTHLwvXVmVAf127/XD2dBgYsxZBrm+rMYEKW7VAHiqGbFNiURF8F0nXq4JgTeXeJOOWl/EUCTGuHwgAdPxNRuHUFKhS8k2T6+6iNZu/Wp/iVrrf3yg5rz2+6zpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723390271; c=relaxed/simple;
	bh=go8C9rYR2xP8zpNYnX9H5hFiHcoIGpVLW5+9O9bhuGs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=aj37A3fqSDtPnHN3PQrtW3e+Ib/ElZ5U0G9Y4xhZazMC6LrTzakb+9KK4qWQsoec4kqYhQxZUoFJaTqtTr/HssfOopm9q9Ueep62WGqhtfpU/Mot9AG5ZMZ7Z4ohNE3JhjaVgJJ6HIW8pYEyQufmDwwqRtnkUvaPWqoSG9HpBrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGoBbRjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87951C32786
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 15:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723390271;
	bh=go8C9rYR2xP8zpNYnX9H5hFiHcoIGpVLW5+9O9bhuGs=;
	h=From:To:Subject:Date:From;
	b=gGoBbRjTORyHUDYdbi1axKuv3lqhqIYe4VFQ1ZKV9Aat2ngWIqdswst+oXuOn8Aiq
	 uvkRDuqWpB5VZE3j0m93kqQ43UuEKQ6WqB1tkOlYGzcRp0FKGOvSfeWC1n3yUv2DZT
	 yBv//h8vOAuDVXTa2GmTKBPkgOOLKmnUIYYyGaPX71xYx+NQkD+H7WMLRYL9CnOEZ2
	 Hpt3D1uJn00zvFsLGURJ2G1SSSxFEo5rE5Gx0ZJa/X6v6AqB52tKuZwJoKdLmUZuXc
	 egBPY3KkaTtPVV+4NvM2c+cVyeMzSoBqSowLt7VOFTjmhT13DsN6cdCXuEAM1HUZCf
	 GJjEn8xmD1Hlg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: only run the extent map shrinker from kswapd tasks
Date: Sun, 11 Aug 2024 16:31:06 +0100
Message-Id: <d85d72b968a1f7b8538c581eeb8f5baa973dfc95.1723377230.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently the extent map shrinker can be run by any task when attempting
to allocate memory and there's enough memory pressure to trigger it.

To avoid too much latency we stop iterating over extent maps and removing
them once the task needs to reschudle. This logic was introduced in commit
b3ebb9b7e92a ("btrfs: stop extent map shrinker if reschedule is needed").

While that solved high latency problems for some use cases, it's still
not enough because with a too high number of tasks entering the extent map
shrinker code, either due to memory allocations or because they are a
kswapd task, we end up having a very high level of contention on some
spin locks, namely:

1) The fs_info->fs_roots_radix_lock spin lock, which we need to find
   roots to iterate over their inodes;

2) The spin lock of the xarray used to track open inodes for a root
   (struct btrfs_root::inodes) - on 6.10 kernels and below, it used to
   be a red black tree and the spin lock was root->inode_lock;

3) The fs_info->delayed_iput_lock spin lock since the shrinker adds
   delayed iputs (calls btrfs_add_delayed_iput()).

Instead of allowing the extent map shrinker to be run by any task, make
it run only by kswapd tasks. This still solves the problem of running
into OOM situations due to an unbounded extent map creation, which is
simple to trigger by direct IO writes, as described in the changelog
of commit 956a17d9d050 ("btrfs: add a shrinker for extent maps"), and
by a similar case when doing buffered IO on files with a very large
number of holes (keeping the file open and creating many holes, whose
extent maps are only released when the file is closed).

Reported-by: kzd <kzd@56709.net>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219121
Reported-by: Octavia Togami <octavia.togami@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CAHPNGSSt-a4ZZWrtJdVyYnJFscFjP9S7rMcvEMaNSpR556DdLA@mail.gmail.com/
Fixes: 956a17d9d050 ("btrfs: add a shrinker for extent maps")
CC: stable@vger.kernel.org # 6.10+
Tested-by: kzd <kzd@56709.net>
Tested-by: Octavia Togami <octavia.togami@gmail.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 22 ++++++----------------
 fs/btrfs/super.c      | 10 ++++++++++
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index c5096fe05ec6..25d191f1ac10 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1150,8 +1150,7 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, struct btrfs_em_shrink_c
 		return 0;
 
 	/*
-	 * We want to be fast because we can be called from any path trying to
-	 * allocate memory, so if the lock is busy we don't want to spend time
+	 * We want to be fast so if the lock is busy we don't want to spend time
 	 * waiting for it - either some task is about to do IO for the inode or
 	 * we may have another task shrinking extent maps, here in this code, so
 	 * skip this inode.
@@ -1194,9 +1193,7 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, struct btrfs_em_shrink_c
 		/*
 		 * Stop if we need to reschedule or there's contention on the
 		 * lock. This is to avoid slowing other tasks trying to take the
-		 * lock and because the shrinker might be called during a memory
-		 * allocation path and we want to avoid taking a very long time
-		 * and slowing down all sorts of tasks.
+		 * lock.
 		 */
 		if (need_resched() || rwlock_needbreak(&tree->lock))
 			break;
@@ -1225,12 +1222,7 @@ static long btrfs_scan_root(struct btrfs_root *root, struct btrfs_em_shrink_ctx
 		if (ctx->scanned >= ctx->nr_to_scan)
 			break;
 
-		/*
-		 * We may be called from memory allocation paths, so we don't
-		 * want to take too much time and slowdown tasks.
-		 */
-		if (need_resched())
-			break;
+		cond_resched();
 
 		inode = btrfs_find_first_inode(root, min_ino);
 	}
@@ -1288,14 +1280,12 @@ long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
 							   ctx.last_ino);
 	}
 
-	/*
-	 * We may be called from memory allocation paths, so we don't want to
-	 * take too much time and slowdown tasks, so stop if we need reschedule.
-	 */
-	while (ctx.scanned < ctx.nr_to_scan && !need_resched()) {
+	while (ctx.scanned < ctx.nr_to_scan) {
 		struct btrfs_root *root;
 		unsigned long count;
 
+		cond_resched();
+
 		spin_lock(&fs_info->fs_roots_radix_lock);
 		count = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
 					       (void **)&root,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 83478deada3b..11044e9e2cb1 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -28,6 +28,7 @@
 #include <linux/btrfs.h>
 #include <linux/security.h>
 #include <linux/fs_parser.h>
+#include <linux/swap.h>
 #include "messages.h"
 #include "delayed-inode.h"
 #include "ctree.h"
@@ -2409,6 +2410,15 @@ static long btrfs_free_cached_objects(struct super_block *sb, struct shrink_cont
 	const long nr_to_scan = min_t(unsigned long, LONG_MAX, sc->nr_to_scan);
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 
+	/*
+	 * We may be called from any task trying to allocate memory and we don't
+	 * want to slow it down with scanning and dropping extent maps. It would
+	 * also cause heavy lock contention if many tasks concurrently enter
+	 * here. Therefore only allow kswapd tasks to scan and drop extent maps.
+	 */
+	if (!current_is_kswapd())
+		return 0;
+
 	return btrfs_free_extent_maps(fs_info, nr_to_scan);
 }
 
-- 
2.43.0


