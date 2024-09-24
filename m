Return-Path: <linux-btrfs+bounces-8196-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D20659843F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 12:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5582C1F21EDD
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 10:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED751A3046;
	Tue, 24 Sep 2024 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW/QWB6q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B77A1A303C
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727174753; cv=none; b=JjpsyIPlgTn+YgzzWZvTyZjs8yTXg2i1HBWFmxmrMgAiB76JMmav8eWvwgOSHRSknJL//w7kw1S3QvUAMtlcCmOoO0BBiJMKzuKOtaqlG9xn6/s4z2AkPpPES0vdldyVYEaZe4GRLBEYFvhOTapT4KEfOKOg2qiW25mtSI+bShs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727174753; c=relaxed/simple;
	bh=pSdCngQlY6sXZghTvRKJ52LeH+1Ob5n0OAt4YTP27Jo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gQK3chT+HZfZgTLpXE4Z8QM17fuuc1+xkqfFzU9JN8s3YBv6+Dx+wQWu0mVgH3LOKDPZO6sLlIwd+hoMqA15oud8UOXYPlsj1hrPyve45J48ePamlY+DiCQ0yPCtQGAFqy3MVF+h36LmREk6EUEikQJ2DAKtSZo6wVFtTY2ydpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UW/QWB6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2CFC4CEC5
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 10:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727174753;
	bh=pSdCngQlY6sXZghTvRKJ52LeH+1Ob5n0OAt4YTP27Jo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UW/QWB6qeqWkUqdK9Pglk3vWKKQU3CCHHPEEAL1/8gNUYibbwXMXtHKYGcUrsep8e
	 63N7ACMKm8ELIqKpkOvfIRaHxqnPKPxSv+h+l3ziGScwd6+LomIdTTB644Yo+MVCOO
	 RIPmgbvwNUtDGGSvTGe/gtLWnCsggcZxtgb9W6hoYkVHDGw2GG/adsoZjQ0f/bnxAU
	 ccc+B8L+Lr9KlGZ6DvOwrvYu8Pof6oLVpok6Uqm0zvXM4lqUjFZ1QUXWSWQ40vSbzS
	 gNCW3t8TiuhW4soxsCEajP7SEOKiEtGDIVE3wli93Gghgr/0OdLYkuzbfLVdD83orH
	 e4eawOUMF/ePA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/5] btrfs: rename extent map shrinker members from struct btrfs_fs_info
Date: Tue, 24 Sep 2024 11:45:44 +0100
Message-Id: <9dc3ddf3830fa9b24753a284f6c95a2939df1dd6.1727174151.git.fdmanana@suse.com>
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

The names for the members of struct btrfs_fs_info related to the extent
map shrinker are a bit too long, so rename them to be shorter by replacing
the "extent_map_" prefix with the "em_" prefix.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c           |  2 +-
 fs/btrfs/extent_map.c        | 32 ++++++++++++++++----------------
 fs/btrfs/fs.h                |  8 ++++----
 include/trace/events/btrfs.h | 10 +++++-----
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 85c6b14cbf76..2d8053b39203 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4282,7 +4282,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	cancel_work_sync(&fs_info->async_reclaim_work);
 	cancel_work_sync(&fs_info->async_data_reclaim_work);
 	cancel_work_sync(&fs_info->preempt_reclaim_work);
-	cancel_work_sync(&fs_info->extent_map_shrinker_work);
+	cancel_work_sync(&fs_info->em_shrinker_work);
 
 	/* Cancel or finish ongoing discard work */
 	btrfs_discard_cleanup(fs_info);
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 767f0804f504..d58d6fc40da1 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1206,14 +1206,14 @@ static long btrfs_scan_root(struct btrfs_root *root, struct btrfs_em_shrink_ctx
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_inode *inode;
 	long nr_dropped = 0;
-	u64 min_ino = fs_info->extent_map_shrinker_last_ino + 1;
+	u64 min_ino = fs_info->em_shrinker_last_ino + 1;
 
 	inode = btrfs_find_first_inode(root, min_ino);
 	while (inode) {
 		nr_dropped += btrfs_scan_inode(inode, ctx);
 
 		min_ino = btrfs_ino(inode) + 1;
-		fs_info->extent_map_shrinker_last_ino = btrfs_ino(inode);
+		fs_info->em_shrinker_last_ino = btrfs_ino(inode);
 		btrfs_add_delayed_iput(inode);
 
 		if (ctx->scanned >= ctx->nr_to_scan ||
@@ -1233,14 +1233,14 @@ static long btrfs_scan_root(struct btrfs_root *root, struct btrfs_em_shrink_ctx
 		 * inode if there is one or we will find out this was the last
 		 * one and move to the next root.
 		 */
-		fs_info->extent_map_shrinker_last_root = btrfs_root_id(root);
+		fs_info->em_shrinker_last_root = btrfs_root_id(root);
 	} else {
 		/*
 		 * No more inodes in this root, set extent_map_shrinker_last_ino to 0 so
 		 * that when processing the next root we start from its first inode.
 		 */
-		fs_info->extent_map_shrinker_last_ino = 0;
-		fs_info->extent_map_shrinker_last_root = btrfs_root_id(root) + 1;
+		fs_info->em_shrinker_last_ino = 0;
+		fs_info->em_shrinker_last_root = btrfs_root_id(root) + 1;
 	}
 
 	return nr_dropped;
@@ -1255,13 +1255,13 @@ static void btrfs_extent_map_shrinker_worker(struct work_struct *work)
 	bool cycled = false;
 	long nr_dropped = 0;
 
-	fs_info = container_of(work, struct btrfs_fs_info, extent_map_shrinker_work);
+	fs_info = container_of(work, struct btrfs_fs_info, em_shrinker_work);
 
 	ctx.scanned = 0;
-	ctx.nr_to_scan = atomic64_read(&fs_info->extent_map_shrinker_nr_to_scan);
+	ctx.nr_to_scan = atomic64_read(&fs_info->em_shrinker_nr_to_scan);
 
-	start_root_id = fs_info->extent_map_shrinker_last_root;
-	next_root_id = fs_info->extent_map_shrinker_last_root;
+	start_root_id = fs_info->em_shrinker_last_root;
+	next_root_id = fs_info->em_shrinker_last_root;
 
 	if (trace_btrfs_extent_map_shrinker_scan_enter_enabled()) {
 		s64 nr = percpu_counter_sum_positive(&fs_info->evictable_extent_maps);
@@ -1283,8 +1283,8 @@ static void btrfs_extent_map_shrinker_worker(struct work_struct *work)
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 			if (start_root_id > 0 && !cycled) {
 				next_root_id = 0;
-				fs_info->extent_map_shrinker_last_root = 0;
-				fs_info->extent_map_shrinker_last_ino = 0;
+				fs_info->em_shrinker_last_root = 0;
+				fs_info->em_shrinker_last_ino = 0;
 				cycled = true;
 				continue;
 			}
@@ -1309,7 +1309,7 @@ static void btrfs_extent_map_shrinker_worker(struct work_struct *work)
 		trace_btrfs_extent_map_shrinker_scan_exit(fs_info, nr_dropped, nr);
 	}
 
-	atomic64_set(&fs_info->extent_map_shrinker_nr_to_scan, 0);
+	atomic64_set(&fs_info->em_shrinker_nr_to_scan, 0);
 }
 
 void btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
@@ -1329,14 +1329,14 @@ void btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
 	 * current value is zero, instead of incrementing the counter by
 	 * nr_to_scan.
 	 */
-	if (atomic64_cmpxchg(&fs_info->extent_map_shrinker_nr_to_scan, 0, nr_to_scan) != 0)
+	if (atomic64_cmpxchg(&fs_info->em_shrinker_nr_to_scan, 0, nr_to_scan) != 0)
 		return;
 
-	queue_work(system_unbound_wq, &fs_info->extent_map_shrinker_work);
+	queue_work(system_unbound_wq, &fs_info->em_shrinker_work);
 }
 
 void btrfs_init_extent_map_shrinker_work(struct btrfs_fs_info *fs_info)
 {
-	atomic64_set(&fs_info->extent_map_shrinker_nr_to_scan, 0);
-	INIT_WORK(&fs_info->extent_map_shrinker_work, btrfs_extent_map_shrinker_worker);
+	atomic64_set(&fs_info->em_shrinker_nr_to_scan, 0);
+	INIT_WORK(&fs_info->em_shrinker_work, btrfs_extent_map_shrinker_worker);
 }
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 6639e873b8db..b64d97759e86 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -635,10 +635,10 @@ struct btrfs_fs_info {
 	s32 delalloc_batch;
 
 	struct percpu_counter evictable_extent_maps;
-	u64 extent_map_shrinker_last_root;
-	u64 extent_map_shrinker_last_ino;
-	atomic64_t extent_map_shrinker_nr_to_scan;
-	struct work_struct extent_map_shrinker_work;
+	u64 em_shrinker_last_root;
+	u64 em_shrinker_last_ino;
+	atomic64_t em_shrinker_nr_to_scan;
+	struct work_struct em_shrinker_work;
 
 	/* Protected by 'trans_lock'. */
 	struct list_head dirty_cowonly_roots;
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 957f3a2b31d4..f85bf421a6ae 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2566,10 +2566,10 @@ TRACE_EVENT(btrfs_extent_map_shrinker_scan_enter,
 
 	TP_fast_assign_btrfs(fs_info,
 		__entry->nr_to_scan	= \
-		     atomic64_read(&fs_info->extent_map_shrinker_nr_to_scan);
+		     atomic64_read(&fs_info->em_shrinker_nr_to_scan);
 		__entry->nr		= nr;
-		__entry->last_root_id	= fs_info->extent_map_shrinker_last_root;
-		__entry->last_ino	= fs_info->extent_map_shrinker_last_ino;
+		__entry->last_root_id	= fs_info->em_shrinker_last_root;
+		__entry->last_ino	= fs_info->em_shrinker_last_ino;
 	),
 
 	TP_printk_btrfs("nr_to_scan=%ld nr=%ld last_root=%llu(%s) last_ino=%llu",
@@ -2593,8 +2593,8 @@ TRACE_EVENT(btrfs_extent_map_shrinker_scan_exit,
 	TP_fast_assign_btrfs(fs_info,
 		__entry->nr_dropped	= nr_dropped;
 		__entry->nr		= nr;
-		__entry->last_root_id	= fs_info->extent_map_shrinker_last_root;
-		__entry->last_ino	= fs_info->extent_map_shrinker_last_ino;
+		__entry->last_root_id	= fs_info->em_shrinker_last_root;
+		__entry->last_ino	= fs_info->em_shrinker_last_ino;
 	),
 
 	TP_printk_btrfs("nr_dropped=%ld nr=%ld last_root=%llu(%s) last_ino=%llu",
-- 
2.43.0


