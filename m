Return-Path: <linux-btrfs+bounces-6289-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4190D92A4EF
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 16:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C4B6B2268E
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 14:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA24313E042;
	Mon,  8 Jul 2024 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdLcZH4Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062FB13D272
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449772; cv=none; b=E6oeI59W9NzWtugXEc+0cO+g2bpwnEhUgw/EkCga4mtFZ51r6NBup4t8+4KfWXVQChfLBCgRE81E/N2iM0C5EjzDAvCVhCQ9am2nD0FSCbECMvMx0uX/6zgWVPl50jEWc/7rm5WURpaAfWPPstwB0JJ/IPvkeUVNW0kfSTZu/8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449772; c=relaxed/simple;
	bh=zWISfhbJO+T/OC+nd3ouA4rHRVIJ0sGnJSIRwHOrwH0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JYpNf1QXi7lGDLaQ+B87FAA5HOJNVSReMwli5EVPTr6bY+s4S57/hBVN8ykASVqYUrFlG+6YI2z9J7WCKxWXMWw70yf9WyLY77t0iq7HqV+4443CcZ/mZcFjSSNl3EG8nrCHl/wVsh/DW3HobJYRoPDf3H9znLOm7YCJ12Q1T30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdLcZH4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15721C4AF0A
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 14:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720449771;
	bh=zWISfhbJO+T/OC+nd3ouA4rHRVIJ0sGnJSIRwHOrwH0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TdLcZH4YVlFilqMbfsw+hE+5vu4+WtNRZ8u6pnWtqvz8OLsYQ/YMCZ/IJ8nJ6EsCn
	 aJzsvjs4SfSmCBHwueMflIqqVsjU2x8gWsClaZ+kyBQ8m+Avp5myy2oq4TwBwxAMHU
	 WAFH030Lz1W83cZZcM4k6dx3GF8lnh3V23Zb8rkYr68EW+V4MVL0sSv6QERzqgdU/3
	 2nYnDMxyNtlB13K7y8jZEPk01jcYWgUAtTUdqTxwD1+9cyk3vtUFytsHFaKTFQH+1F
	 LsvYpCoVxlsXSjjeJEH+dzLgeW8LmzC4WIsp3YdBI1j+okkAJH9e/0432ulCSMt14f
	 F0OTV19pD8OEA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: avoid races when tracking progress for extent map shrinking
Date: Mon,  8 Jul 2024 15:42:45 +0100
Message-Id: <fa8b5dd7fa18a4dc2ea6bdeaf5525b1af348f383.1720448664.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1720448663.git.fdmanana@suse.com>
References: <cover.1720448663.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We store the progress (root and inode numbers) of the extent map shrinker
in fs_info without any synchronization but we can have multiple tasks
calling into the shrinker during memory allocations when there's enough
memory pressure for example.

This can result in a task A reading fs_info->extent_map_shrinker_last_ino
after another task B updates it, and task A reading
fs_info->extent_map_shrinker_last_root before task B updates it, making
task A see an odd state that isn't necessarily harmful but may make it
skip certain inode ranges or do more work than necessary by going over
the same inodes again. These unprotected accesses would also trigger
warnings from tools like KCSAN.

So add a lock to protect access to these progress fields.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c           |  2 +
 fs/btrfs/extent_map.c        | 84 +++++++++++++++++++++++++++---------
 fs/btrfs/fs.h                |  1 +
 include/trace/events/btrfs.h | 18 ++++----
 4 files changed, 76 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 38cdb8875e8e..cabb558dbdaa 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2856,6 +2856,8 @@ static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block
 	if (ret)
 		return ret;
 
+	spin_lock_init(&fs_info->extent_map_shrinker_lock);
+
 	ret = percpu_counter_init(&fs_info->dirty_metadata_bytes, 0, GFP_KERNEL);
 	if (ret)
 		return ret;
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 887a0e5dc145..b4c9a6aa118c 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1028,7 +1028,14 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	return ret;
 }
 
-static long btrfs_scan_inode(struct btrfs_inode *inode, long *scanned, long nr_to_scan)
+struct btrfs_em_shrink_ctx {
+	long nr_to_scan;
+	long scanned;
+	u64 last_ino;
+	u64 last_root;
+};
+
+static long btrfs_scan_inode(struct btrfs_inode *inode, struct btrfs_em_shrink_ctx *ctx)
 {
 	const u64 cur_fs_gen = btrfs_get_fs_generation(inode->root->fs_info);
 	struct extent_map_tree *tree = &inode->extent_tree;
@@ -1075,7 +1082,7 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, long *scanned, long nr_t
 
 		em = rb_entry(node, struct extent_map, rb_node);
 		node = rb_next(node);
-		(*scanned)++;
+		ctx->scanned++;
 
 		if (em->flags & EXTENT_FLAG_PINNED)
 			goto next;
@@ -1096,7 +1103,7 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, long *scanned, long nr_t
 		free_extent_map(em);
 		nr_dropped++;
 next:
-		if (*scanned >= nr_to_scan)
+		if (ctx->scanned >= ctx->nr_to_scan)
 			break;
 
 		/*
@@ -1115,22 +1122,21 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, long *scanned, long nr_t
 	return nr_dropped;
 }
 
-static long btrfs_scan_root(struct btrfs_root *root, long *scanned, long nr_to_scan)
+static long btrfs_scan_root(struct btrfs_root *root, struct btrfs_em_shrink_ctx *ctx)
 {
-	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_inode *inode;
 	long nr_dropped = 0;
-	u64 min_ino = fs_info->extent_map_shrinker_last_ino + 1;
+	u64 min_ino = ctx->last_ino + 1;
 
 	inode = btrfs_find_first_inode(root, min_ino);
 	while (inode) {
-		nr_dropped += btrfs_scan_inode(inode, scanned, nr_to_scan);
+		nr_dropped += btrfs_scan_inode(inode, ctx);
 
 		min_ino = btrfs_ino(inode) + 1;
-		fs_info->extent_map_shrinker_last_ino = btrfs_ino(inode);
+		ctx->last_ino = btrfs_ino(inode);
 		btrfs_add_delayed_iput(inode);
 
-		if (*scanned >= nr_to_scan)
+		if (ctx->scanned >= ctx->nr_to_scan)
 			break;
 
 		/*
@@ -1151,14 +1157,14 @@ static long btrfs_scan_root(struct btrfs_root *root, long *scanned, long nr_to_s
 		 * inode if there is one or we will find out this was the last
 		 * one and move to the next root.
 		 */
-		fs_info->extent_map_shrinker_last_root = btrfs_root_id(root);
+		ctx->last_root = btrfs_root_id(root);
 	} else {
 		/*
 		 * No more inodes in this root, set extent_map_shrinker_last_ino to 0 so
 		 * that when processing the next root we start from its first inode.
 		 */
-		fs_info->extent_map_shrinker_last_ino = 0;
-		fs_info->extent_map_shrinker_last_root = btrfs_root_id(root) + 1;
+		ctx->last_ino = 0;
+		ctx->last_root = btrfs_root_id(root) + 1;
 	}
 
 	return nr_dropped;
@@ -1166,23 +1172,41 @@ static long btrfs_scan_root(struct btrfs_root *root, long *scanned, long nr_to_s
 
 long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
 {
-	const u64 start_root_id = fs_info->extent_map_shrinker_last_root;
-	u64 next_root_id = start_root_id;
+	struct btrfs_em_shrink_ctx ctx;
+	u64 start_root_id;
+	u64 next_root_id;
 	bool cycled = false;
 	long nr_dropped = 0;
-	long scanned = 0;
+
+	ctx.scanned = 0;
+	ctx.nr_to_scan = nr_to_scan;
+
+	/*
+	 * In case we have multiple tasks running this shrinker, make the next
+	 * one start from the next inode in case it starts before we finish.
+	 */
+	spin_lock(&fs_info->extent_map_shrinker_lock);
+	ctx.last_ino = fs_info->extent_map_shrinker_last_ino;
+	fs_info->extent_map_shrinker_last_ino++;
+	ctx.last_root = fs_info->extent_map_shrinker_last_root;
+	spin_unlock(&fs_info->extent_map_shrinker_lock);
+
+	start_root_id = ctx.last_root;
+	next_root_id = ctx.last_root;
 
 	if (trace_btrfs_extent_map_shrinker_scan_enter_enabled()) {
 		s64 nr = percpu_counter_sum_positive(&fs_info->evictable_extent_maps);
 
-		trace_btrfs_extent_map_shrinker_scan_enter(fs_info, nr_to_scan, nr);
+		trace_btrfs_extent_map_shrinker_scan_enter(fs_info, nr_to_scan,
+							   nr, ctx.last_root,
+							   ctx.last_ino);
 	}
 
 	/*
 	 * We may be called from memory allocation paths, so we don't want to
 	 * take too much time and slowdown tasks, so stop if we need reschedule.
 	 */
-	while (scanned < nr_to_scan && !need_resched()) {
+	while (ctx.scanned < ctx.nr_to_scan && !need_resched()) {
 		struct btrfs_root *root;
 		unsigned long count;
 
@@ -1194,8 +1218,8 @@ long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 			if (start_root_id > 0 && !cycled) {
 				next_root_id = 0;
-				fs_info->extent_map_shrinker_last_root = 0;
-				fs_info->extent_map_shrinker_last_ino = 0;
+				ctx.last_root = 0;
+				ctx.last_ino = 0;
 				cycled = true;
 				continue;
 			}
@@ -1209,15 +1233,33 @@ long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
 			continue;
 
 		if (is_fstree(btrfs_root_id(root)))
-			nr_dropped += btrfs_scan_root(root, &scanned, nr_to_scan);
+			nr_dropped += btrfs_scan_root(root, &ctx);
 
 		btrfs_put_root(root);
 	}
 
+	/*
+	 * In case of multiple tasks running this extent map shrinking code this
+	 * isn't perfect but it's simple and silences things like KCSAN. It's
+	 * not possible to know which task made more progress because we can
+	 * cycle back to the first root and first inode if it's not the first
+	 * time the shrinker ran, see the above logic. Also a task that started
+	 * later may finish ealier than another task and made less progress. So
+	 * make this simple and update to the progress of the last task that
+	 * finished, with the occasional possiblity of having two consecutive
+	 * runs of the shrinker process the same inodes.
+	 */
+	spin_lock(&fs_info->extent_map_shrinker_lock);
+	fs_info->extent_map_shrinker_last_ino = ctx.last_ino;
+	fs_info->extent_map_shrinker_last_root = ctx.last_root;
+	spin_unlock(&fs_info->extent_map_shrinker_lock);
+
 	if (trace_btrfs_extent_map_shrinker_scan_exit_enabled()) {
 		s64 nr = percpu_counter_sum_positive(&fs_info->evictable_extent_maps);
 
-		trace_btrfs_extent_map_shrinker_scan_exit(fs_info, nr_dropped, nr);
+		trace_btrfs_extent_map_shrinker_scan_exit(fs_info, nr_dropped,
+							  nr, ctx.last_root,
+							  ctx.last_ino);
 	}
 
 	return nr_dropped;
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 89f0650631cd..833dc3fe0a38 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -630,6 +630,7 @@ struct btrfs_fs_info {
 	s32 delalloc_batch;
 
 	struct percpu_counter evictable_extent_maps;
+	spinlock_t extent_map_shrinker_lock;
 	u64 extent_map_shrinker_last_root;
 	u64 extent_map_shrinker_last_ino;
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index fadf406b5260..c978fa2893a5 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2556,9 +2556,10 @@ TRACE_EVENT(btrfs_extent_map_shrinker_count,
 
 TRACE_EVENT(btrfs_extent_map_shrinker_scan_enter,
 
-	TP_PROTO(const struct btrfs_fs_info *fs_info, long nr_to_scan, long nr),
+	TP_PROTO(const struct btrfs_fs_info *fs_info, long nr_to_scan, long nr,
+		 u64 last_root_id, u64 last_ino),
 
-	TP_ARGS(fs_info, nr_to_scan, nr),
+	TP_ARGS(fs_info, nr_to_scan, nr, last_root_id, last_ino),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	long,	nr_to_scan	)
@@ -2570,8 +2571,8 @@ TRACE_EVENT(btrfs_extent_map_shrinker_scan_enter,
 	TP_fast_assign_btrfs(fs_info,
 		__entry->nr_to_scan	= nr_to_scan;
 		__entry->nr		= nr;
-		__entry->last_root_id	= fs_info->extent_map_shrinker_last_root;
-		__entry->last_ino	= fs_info->extent_map_shrinker_last_ino;
+		__entry->last_root_id	= last_root_id;
+		__entry->last_ino	= last_ino;
 	),
 
 	TP_printk_btrfs("nr_to_scan=%ld nr=%ld last_root=%llu(%s) last_ino=%llu",
@@ -2581,9 +2582,10 @@ TRACE_EVENT(btrfs_extent_map_shrinker_scan_enter,
 
 TRACE_EVENT(btrfs_extent_map_shrinker_scan_exit,
 
-	TP_PROTO(const struct btrfs_fs_info *fs_info, long nr_dropped, long nr),
+	TP_PROTO(const struct btrfs_fs_info *fs_info, long nr_dropped, long nr,
+		 u64 last_root_id, u64 last_ino),
 
-	TP_ARGS(fs_info, nr_dropped, nr),
+	TP_ARGS(fs_info, nr_dropped, nr, last_root_id, last_ino),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	long,	nr_dropped	)
@@ -2595,8 +2597,8 @@ TRACE_EVENT(btrfs_extent_map_shrinker_scan_exit,
 	TP_fast_assign_btrfs(fs_info,
 		__entry->nr_dropped	= nr_dropped;
 		__entry->nr		= nr;
-		__entry->last_root_id	= fs_info->extent_map_shrinker_last_root;
-		__entry->last_ino	= fs_info->extent_map_shrinker_last_ino;
+		__entry->last_root_id	= last_root_id;
+		__entry->last_ino	= last_ino;
 	),
 
 	TP_printk_btrfs("nr_dropped=%ld nr=%ld last_root=%llu(%s) last_ino=%llu",
-- 
2.43.0


