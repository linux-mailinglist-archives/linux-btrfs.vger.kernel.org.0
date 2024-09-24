Return-Path: <linux-btrfs+bounces-8195-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9759843F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 12:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE99E1F22593
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 10:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3639D1A303A;
	Tue, 24 Sep 2024 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3ctq9t4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627621A2C3E
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727174752; cv=none; b=Ogu19WQp1BC4+WYS4+p3RUy3juouVO1muAgnvn/lc2C7A6fodAJfk8i3zJZBWS2A7uGkqHPwa0X1RdgUJ+jCJd43oFP6UxzxhnVE7co1VGkfLj0JffazS7mZnA2trH04hx/gO31bJBH7dnfXmT0p/uacMmvz+SK8BnKrrjVW6T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727174752; c=relaxed/simple;
	bh=TH/iNSjsmIEJ1cKYSP8ugJ6+9j7ULGgx6gE6EdPHjr0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PWz65vGpON8sKTGFYdRnMggA7iNo9vSMZPPpvZRMG/TSjFBODTpU7CMa/vlKBXHy9ij7QRDNMDZh/xJBrrYwZ67G3LOii8q2ZJxton86j+serM6SqiM6tw9188xsn0Kt30sJVhBZqRLPwVFYadxDP88cBCVUuYijAycuhf/piWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3ctq9t4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D44C4CEC4
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 10:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727174752;
	bh=TH/iNSjsmIEJ1cKYSP8ugJ6+9j7ULGgx6gE6EdPHjr0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Y3ctq9t48kiXi5unwStYuUnI9kb3Kc3bkj1Y0FO23Qe4KELMpYBHJ1oWsTOaO9tIK
	 eKcOLGInnPTO5pOx60/KCtHJRbE3ZBqSQIrGHC/WH7HV5P3EKLB0BAnclHn7OpMbcQ
	 SEN6KWNEZZZixTQ63TPXattjyCywEBt20v3ez4xOA7Eo/PCbVTUCcObyJJD/YG4HpU
	 Lr5lpnQzbxnzAWggZN8TMyMrWopzXbzV3DXkcMuwd2IUhFWdY2VHYCuzpBi12LvZCr
	 xS21GDzrhKsPVV7smWLLuTC9LWijne/x3A5fmHqqy52wu6upWSXUV313d+Hb4tXqdC
	 ndaki+6P7DUsQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs: simplify tracking progress for the extent map shrinker
Date: Tue, 24 Sep 2024 11:45:43 +0100
Message-Id: <01a67b4842c000fe1c31018543d95c7e24eb1150.1727174151.git.fdmanana@suse.com>
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

Now that the extent map shrinker can only be run by a single task (as a
work queue item) there is no need to keep the progress of the shrinker
protected by a spinlock and passing the progress to trace events as
parameters. So remove the lock and simplify the arguments for the trace
events.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c           |  2 --
 fs/btrfs/extent_map.c        | 55 ++++++++----------------------------
 fs/btrfs/fs.h                |  1 -
 include/trace/events/btrfs.h | 21 +++++++-------
 4 files changed, 22 insertions(+), 57 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2148147c5257..85c6b14cbf76 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2853,8 +2853,6 @@ static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block
 	if (ret)
 		return ret;
 
-	spin_lock_init(&fs_info->extent_map_shrinker_lock);
-
 	ret = percpu_counter_init(&fs_info->dirty_metadata_bytes, 0, GFP_KERNEL);
 	if (ret)
 		return ret;
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index e2eeb94aa349..767f0804f504 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1112,8 +1112,6 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 struct btrfs_em_shrink_ctx {
 	long nr_to_scan;
 	long scanned;
-	u64 last_ino;
-	u64 last_root;
 };
 
 static long btrfs_scan_inode(struct btrfs_inode *inode, struct btrfs_em_shrink_ctx *ctx)
@@ -1205,16 +1203,17 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, struct btrfs_em_shrink_c
 
 static long btrfs_scan_root(struct btrfs_root *root, struct btrfs_em_shrink_ctx *ctx)
 {
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_inode *inode;
 	long nr_dropped = 0;
-	u64 min_ino = ctx->last_ino + 1;
+	u64 min_ino = fs_info->extent_map_shrinker_last_ino + 1;
 
 	inode = btrfs_find_first_inode(root, min_ino);
 	while (inode) {
 		nr_dropped += btrfs_scan_inode(inode, ctx);
 
 		min_ino = btrfs_ino(inode) + 1;
-		ctx->last_ino = btrfs_ino(inode);
+		fs_info->extent_map_shrinker_last_ino = btrfs_ino(inode);
 		btrfs_add_delayed_iput(inode);
 
 		if (ctx->scanned >= ctx->nr_to_scan ||
@@ -1234,14 +1233,14 @@ static long btrfs_scan_root(struct btrfs_root *root, struct btrfs_em_shrink_ctx
 		 * inode if there is one or we will find out this was the last
 		 * one and move to the next root.
 		 */
-		ctx->last_root = btrfs_root_id(root);
+		fs_info->extent_map_shrinker_last_root = btrfs_root_id(root);
 	} else {
 		/*
 		 * No more inodes in this root, set extent_map_shrinker_last_ino to 0 so
 		 * that when processing the next root we start from its first inode.
 		 */
-		ctx->last_ino = 0;
-		ctx->last_root = btrfs_root_id(root) + 1;
+		fs_info->extent_map_shrinker_last_ino = 0;
+		fs_info->extent_map_shrinker_last_root = btrfs_root_id(root) + 1;
 	}
 
 	return nr_dropped;
@@ -1261,25 +1260,13 @@ static void btrfs_extent_map_shrinker_worker(struct work_struct *work)
 	ctx.scanned = 0;
 	ctx.nr_to_scan = atomic64_read(&fs_info->extent_map_shrinker_nr_to_scan);
 
-	/*
-	 * In case we have multiple tasks running this shrinker, make the next
-	 * one start from the next inode in case it starts before we finish.
-	 */
-	spin_lock(&fs_info->extent_map_shrinker_lock);
-	ctx.last_ino = fs_info->extent_map_shrinker_last_ino;
-	fs_info->extent_map_shrinker_last_ino++;
-	ctx.last_root = fs_info->extent_map_shrinker_last_root;
-	spin_unlock(&fs_info->extent_map_shrinker_lock);
-
-	start_root_id = ctx.last_root;
-	next_root_id = ctx.last_root;
+	start_root_id = fs_info->extent_map_shrinker_last_root;
+	next_root_id = fs_info->extent_map_shrinker_last_root;
 
 	if (trace_btrfs_extent_map_shrinker_scan_enter_enabled()) {
 		s64 nr = percpu_counter_sum_positive(&fs_info->evictable_extent_maps);
 
-		trace_btrfs_extent_map_shrinker_scan_enter(fs_info, ctx.nr_to_scan,
-							   nr, ctx.last_root,
-							   ctx.last_ino);
+		trace_btrfs_extent_map_shrinker_scan_enter(fs_info, nr);
 	}
 
 	while (ctx.scanned < ctx.nr_to_scan && !btrfs_fs_closing(fs_info)) {
@@ -1296,8 +1283,8 @@ static void btrfs_extent_map_shrinker_worker(struct work_struct *work)
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 			if (start_root_id > 0 && !cycled) {
 				next_root_id = 0;
-				ctx.last_root = 0;
-				ctx.last_ino = 0;
+				fs_info->extent_map_shrinker_last_root = 0;
+				fs_info->extent_map_shrinker_last_ino = 0;
 				cycled = true;
 				continue;
 			}
@@ -1316,28 +1303,10 @@ static void btrfs_extent_map_shrinker_worker(struct work_struct *work)
 		btrfs_put_root(root);
 	}
 
-	/*
-	 * In case of multiple tasks running this extent map shrinking code this
-	 * isn't perfect but it's simple and silences things like KCSAN. It's
-	 * not possible to know which task made more progress because we can
-	 * cycle back to the first root and first inode if it's not the first
-	 * time the shrinker ran, see the above logic. Also a task that started
-	 * later may finish ealier than another task and made less progress. So
-	 * make this simple and update to the progress of the last task that
-	 * finished, with the occasional possiblity of having two consecutive
-	 * runs of the shrinker process the same inodes.
-	 */
-	spin_lock(&fs_info->extent_map_shrinker_lock);
-	fs_info->extent_map_shrinker_last_ino = ctx.last_ino;
-	fs_info->extent_map_shrinker_last_root = ctx.last_root;
-	spin_unlock(&fs_info->extent_map_shrinker_lock);
-
 	if (trace_btrfs_extent_map_shrinker_scan_exit_enabled()) {
 		s64 nr = percpu_counter_sum_positive(&fs_info->evictable_extent_maps);
 
-		trace_btrfs_extent_map_shrinker_scan_exit(fs_info, nr_dropped,
-							  nr, ctx.last_root,
-							  ctx.last_ino);
+		trace_btrfs_extent_map_shrinker_scan_exit(fs_info, nr_dropped, nr);
 	}
 
 	atomic64_set(&fs_info->extent_map_shrinker_nr_to_scan, 0);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index a246d8dc0b20..6639e873b8db 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -635,7 +635,6 @@ struct btrfs_fs_info {
 	s32 delalloc_batch;
 
 	struct percpu_counter evictable_extent_maps;
-	spinlock_t extent_map_shrinker_lock;
 	u64 extent_map_shrinker_last_root;
 	u64 extent_map_shrinker_last_ino;
 	atomic64_t extent_map_shrinker_nr_to_scan;
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index bf60ad50011e..957f3a2b31d4 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2553,10 +2553,9 @@ TRACE_EVENT(btrfs_extent_map_shrinker_count,
 
 TRACE_EVENT(btrfs_extent_map_shrinker_scan_enter,
 
-	TP_PROTO(const struct btrfs_fs_info *fs_info, long nr_to_scan, long nr,
-		 u64 last_root_id, u64 last_ino),
+	TP_PROTO(const struct btrfs_fs_info *fs_info, long nr),
 
-	TP_ARGS(fs_info, nr_to_scan, nr, last_root_id, last_ino),
+	TP_ARGS(fs_info, nr),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	long,	nr_to_scan	)
@@ -2566,10 +2565,11 @@ TRACE_EVENT(btrfs_extent_map_shrinker_scan_enter,
 	),
 
 	TP_fast_assign_btrfs(fs_info,
-		__entry->nr_to_scan	= nr_to_scan;
+		__entry->nr_to_scan	= \
+		     atomic64_read(&fs_info->extent_map_shrinker_nr_to_scan);
 		__entry->nr		= nr;
-		__entry->last_root_id	= last_root_id;
-		__entry->last_ino	= last_ino;
+		__entry->last_root_id	= fs_info->extent_map_shrinker_last_root;
+		__entry->last_ino	= fs_info->extent_map_shrinker_last_ino;
 	),
 
 	TP_printk_btrfs("nr_to_scan=%ld nr=%ld last_root=%llu(%s) last_ino=%llu",
@@ -2579,10 +2579,9 @@ TRACE_EVENT(btrfs_extent_map_shrinker_scan_enter,
 
 TRACE_EVENT(btrfs_extent_map_shrinker_scan_exit,
 
-	TP_PROTO(const struct btrfs_fs_info *fs_info, long nr_dropped, long nr,
-		 u64 last_root_id, u64 last_ino),
+	TP_PROTO(const struct btrfs_fs_info *fs_info, long nr_dropped, long nr),
 
-	TP_ARGS(fs_info, nr_dropped, nr, last_root_id, last_ino),
+	TP_ARGS(fs_info, nr_dropped, nr),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	long,	nr_dropped	)
@@ -2594,8 +2593,8 @@ TRACE_EVENT(btrfs_extent_map_shrinker_scan_exit,
 	TP_fast_assign_btrfs(fs_info,
 		__entry->nr_dropped	= nr_dropped;
 		__entry->nr		= nr;
-		__entry->last_root_id	= last_root_id;
-		__entry->last_ino	= last_ino;
+		__entry->last_root_id	= fs_info->extent_map_shrinker_last_root;
+		__entry->last_ino	= fs_info->extent_map_shrinker_last_ino;
 	),
 
 	TP_printk_btrfs("nr_dropped=%ld nr=%ld last_root=%llu(%s) last_ino=%llu",
-- 
2.43.0


