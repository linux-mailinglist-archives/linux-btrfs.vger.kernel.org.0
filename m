Return-Path: <linux-btrfs+bounces-8194-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3209843F3
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 12:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10CABB234E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 10:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B1E1A302C;
	Tue, 24 Sep 2024 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHrbWMDl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6199E1A3020
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727174751; cv=none; b=o1jt8wHxw1rrfrP/Tn5DTio4UOav8oTiSR2+OU6iZ9t8Eo+GjmAPEu/AA+frsbhL++2luRP3SVos0o4uyGD7iyChTYPZjXhW4vGY4XmbOgZC/smxI5um3FMkxzFDMgUJddNGG8lgPU67yuOQPoq0hAUgiZzVyXbdHOGqYUWA4ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727174751; c=relaxed/simple;
	bh=7VKd3drMTWH6lT+eiOtuGbGhgAQk+vwECXdhodidw3w=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bw8Ce7pqP2yBJWcidWe/wHFB3ePmTSEodgVX+OKo0M+gaFO+ozvLzXTMpIDoLnkU+sj3js55S1WiCWncBl0ePreZQNwXub5srBSj2CpXmEz3TXW5aXNopk4mtfIKx4lLF5sTSGLtHpNEEO9KqY1sTICHGYlxJe77ZvMRtjU5LTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHrbWMDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DE0C4CEC7
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 10:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727174751;
	bh=7VKd3drMTWH6lT+eiOtuGbGhgAQk+vwECXdhodidw3w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DHrbWMDlrDq4fCI1paxRfepqTpngXENBxa42XBPdyR1bPceYVEj3KDVb74J8q3q7r
	 arkBsjtpL2w8nOsO5gD1Gl+VScTsTayhXlDMUTwx87dHGWDDi7M1fdHZWM/r0sZXvz
	 KZpmFTb3xLRVbTI0MIrJmxl4aMa+ZcYgjBpSDLn1Gv1EXNAkJUhKb+06rBJPMxAQJ2
	 ivhF6XRfp4ylm0u2Env7YGTxxMUnLy1B43agqcBZC74/sKl1gvlNB2MvCoVSJuT67d
	 EQ3LshBZUWOZ/Ohf/rvzNvMX6twVleLr3FeJuICk+mBPDH4t645UkVboeLYobobsBK
	 TL4yToQBof1PQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] btrfs: make the extent map shrinker run asynchronously as a work queue job
Date: Tue, 24 Sep 2024 11:45:42 +0100
Message-Id: <1a3f817fc3c5a6e4267bcd56f2f0518a9d8e0e4e.1727174151.git.fdmanana@suse.com>
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

Currently the extent map shrinker is run synchronously for kswapd tasks
that end up calling the fs shrinker (fs/super.c:super_cache_scan()).
This has some disadvantages and for some heavy workloads with memory
pressure it can cause some delays and stalls that make a machine
unresponsive for some periods. This happens because:

1) We can have several kswapd tasks on machines with multiple NUMA zones,
   and running the extent map shrinker concurrently can cause high
   contention on some spin locks, namely the spin locks that protect
   the radix tree that tracks roots, the per root xarray that tracks
   open inodes and the list of delayed iputs. This not only delays the
   shrinker but also causes high CPU consumption and makes the task
   running the shrinker monopolize a core, resulting in the symptoms
   of an unresponsive system. This was noted in previous commits such as
   commit ae1e766f623f ("btrfs: only run the extent map shrinker from
   kswapd tasks");

2) The extent map shrinker's iteration over inodes can often be slow, even
   after changing the data structure that tracks open inodes for a root
   from a red black tree (up to kernel 6.10) to an xarray (kernel 6.10+).
   The transition to the xarray while it made things a bit faster, it's
   still somewhat slow - for example in a test scenario with 10000 inodes
   that have no extent maps loaded, the extent map shrinker took between
   5ms to 8ms, using a release, non-debug kernel. Iterating over the
   extent maps of an inode can also be slow if have an inode with many
   thousands of extent maps, since we use a red black tree to track and
   search extent maps. So having the extent map shrinker run synchronously
   adds extra delay for other things a kswapd task does.

So make the extent map shrinker run asynchronously as a job for the
system unbounded workqueue, just like what we do for data and metadata
space reclaim jobs.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c    |  2 ++
 fs/btrfs/extent_map.c | 51 ++++++++++++++++++++++++++++++++++++-------
 fs/btrfs/extent_map.h |  3 ++-
 fs/btrfs/fs.h         |  2 ++
 fs/btrfs/super.c      | 13 +++--------
 5 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 25d768e67e37..2148147c5257 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2786,6 +2786,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_init_scrub(fs_info);
 	btrfs_init_balance(fs_info);
 	btrfs_init_async_reclaim_work(fs_info);
+	btrfs_init_extent_map_shrinker_work(fs_info);
 
 	rwlock_init(&fs_info->block_group_cache_lock);
 	fs_info->block_group_cache_tree = RB_ROOT_CACHED;
@@ -4283,6 +4284,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	cancel_work_sync(&fs_info->async_reclaim_work);
 	cancel_work_sync(&fs_info->async_data_reclaim_work);
 	cancel_work_sync(&fs_info->preempt_reclaim_work);
+	cancel_work_sync(&fs_info->extent_map_shrinker_work);
 
 	/* Cancel or finish ongoing discard work */
 	btrfs_discard_cleanup(fs_info);
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index cb2a6f5dce2b..e2eeb94aa349 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1118,7 +1118,8 @@ struct btrfs_em_shrink_ctx {
 
 static long btrfs_scan_inode(struct btrfs_inode *inode, struct btrfs_em_shrink_ctx *ctx)
 {
-	const u64 cur_fs_gen = btrfs_get_fs_generation(inode->root->fs_info);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	const u64 cur_fs_gen = btrfs_get_fs_generation(fs_info);
 	struct extent_map_tree *tree = &inode->extent_tree;
 	long nr_dropped = 0;
 	struct rb_node *node;
@@ -1191,7 +1192,8 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, struct btrfs_em_shrink_c
 		 * lock. This is to avoid slowing other tasks trying to take the
 		 * lock.
 		 */
-		if (need_resched() || rwlock_needbreak(&tree->lock))
+		if (need_resched() || rwlock_needbreak(&tree->lock) ||
+		    btrfs_fs_closing(fs_info))
 			break;
 		node = next;
 	}
@@ -1215,7 +1217,8 @@ static long btrfs_scan_root(struct btrfs_root *root, struct btrfs_em_shrink_ctx
 		ctx->last_ino = btrfs_ino(inode);
 		btrfs_add_delayed_iput(inode);
 
-		if (ctx->scanned >= ctx->nr_to_scan)
+		if (ctx->scanned >= ctx->nr_to_scan ||
+		    btrfs_fs_closing(inode->root->fs_info))
 			break;
 
 		cond_resched();
@@ -1244,16 +1247,19 @@ static long btrfs_scan_root(struct btrfs_root *root, struct btrfs_em_shrink_ctx
 	return nr_dropped;
 }
 
-long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
+static void btrfs_extent_map_shrinker_worker(struct work_struct *work)
 {
+	struct btrfs_fs_info *fs_info;
 	struct btrfs_em_shrink_ctx ctx;
 	u64 start_root_id;
 	u64 next_root_id;
 	bool cycled = false;
 	long nr_dropped = 0;
 
+	fs_info = container_of(work, struct btrfs_fs_info, extent_map_shrinker_work);
+
 	ctx.scanned = 0;
-	ctx.nr_to_scan = nr_to_scan;
+	ctx.nr_to_scan = atomic64_read(&fs_info->extent_map_shrinker_nr_to_scan);
 
 	/*
 	 * In case we have multiple tasks running this shrinker, make the next
@@ -1271,12 +1277,12 @@ long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
 	if (trace_btrfs_extent_map_shrinker_scan_enter_enabled()) {
 		s64 nr = percpu_counter_sum_positive(&fs_info->evictable_extent_maps);
 
-		trace_btrfs_extent_map_shrinker_scan_enter(fs_info, nr_to_scan,
+		trace_btrfs_extent_map_shrinker_scan_enter(fs_info, ctx.nr_to_scan,
 							   nr, ctx.last_root,
 							   ctx.last_ino);
 	}
 
-	while (ctx.scanned < ctx.nr_to_scan) {
+	while (ctx.scanned < ctx.nr_to_scan && !btrfs_fs_closing(fs_info)) {
 		struct btrfs_root *root;
 		unsigned long count;
 
@@ -1334,5 +1340,34 @@ long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
 							  ctx.last_ino);
 	}
 
-	return nr_dropped;
+	atomic64_set(&fs_info->extent_map_shrinker_nr_to_scan, 0);
+}
+
+void btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
+{
+	/*
+	 * Do nothing if the shrinker is already running. In case of high memory
+	 * pressure we can have a lot of tasks calling us and all passing the
+	 * same nr_to_scan value, but in reality we may need only to free
+	 * nr_to_scan extent maps (or less). In case we need to free more than
+	 * that, we will be called again by the fs shrinker, so no worries about
+	 * not doing enough work to reclaim memory from extent maps.
+	 * We can also be repeatedly called with the same nr_to_scan value
+	 * simply because the shrinker runs asynchronously and multiple calls
+	 * to this function are made before the shrinker does enough progress.
+	 *
+	 * That's why we set the atomic counter to nr_to_scan only if its
+	 * current value is zero, instead of incrementing the counter by
+	 * nr_to_scan.
+	 */
+	if (atomic64_cmpxchg(&fs_info->extent_map_shrinker_nr_to_scan, 0, nr_to_scan) != 0)
+		return;
+
+	queue_work(system_unbound_wq, &fs_info->extent_map_shrinker_work);
+}
+
+void btrfs_init_extent_map_shrinker_work(struct btrfs_fs_info *fs_info)
+{
+	atomic64_set(&fs_info->extent_map_shrinker_nr_to_scan, 0);
+	INIT_WORK(&fs_info->extent_map_shrinker_work, btrfs_extent_map_shrinker_worker);
 }
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 5154a8f1d26c..cd123b266b64 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -189,6 +189,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode,
 int btrfs_replace_extent_map_range(struct btrfs_inode *inode,
 				   struct extent_map *new_em,
 				   bool modified);
-long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan);
+void btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan);
+void btrfs_init_extent_map_shrinker_work(struct btrfs_fs_info *fs_info);
 
 #endif
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 785ec15c1b84..a246d8dc0b20 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -638,6 +638,8 @@ struct btrfs_fs_info {
 	spinlock_t extent_map_shrinker_lock;
 	u64 extent_map_shrinker_last_root;
 	u64 extent_map_shrinker_last_ino;
+	atomic64_t extent_map_shrinker_nr_to_scan;
+	struct work_struct extent_map_shrinker_work;
 
 	/* Protected by 'trans_lock'. */
 	struct list_head dirty_cowonly_roots;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index e8a5bf4af918..e9e209dd8e05 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -28,7 +28,6 @@
 #include <linux/btrfs.h>
 #include <linux/security.h>
 #include <linux/fs_parser.h>
-#include <linux/swap.h>
 #include "messages.h"
 #include "delayed-inode.h"
 #include "ctree.h"
@@ -2416,16 +2415,10 @@ static long btrfs_free_cached_objects(struct super_block *sb, struct shrink_cont
 	const long nr_to_scan = min_t(unsigned long, LONG_MAX, sc->nr_to_scan);
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 
-	/*
-	 * We may be called from any task trying to allocate memory and we don't
-	 * want to slow it down with scanning and dropping extent maps. It would
-	 * also cause heavy lock contention if many tasks concurrently enter
-	 * here. Therefore only allow kswapd tasks to scan and drop extent maps.
-	 */
-	if (!current_is_kswapd())
-		return 0;
+	btrfs_free_extent_maps(fs_info, nr_to_scan);
 
-	return btrfs_free_extent_maps(fs_info, nr_to_scan);
+	/* The extent map shrinker runs asynchronously, so always return 0. */
+	return 0;
 }
 
 static const struct super_operations btrfs_super_ops = {
-- 
2.43.0


