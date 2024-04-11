Return-Path: <linux-btrfs+bounces-4158-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A6C8A1C66
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 19:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E471F22E5D
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 17:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4DB190692;
	Thu, 11 Apr 2024 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoEK7XGM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67341190684
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852372; cv=none; b=FbfmLzLCNT0IBgD/45IapJ9fJVB6bb4XmqZCknJa6hDLn4sgmVbX9EfOlCpPKdaJaYE5Yi8NjtjwOvyIYopVU3+cziNKpHhHsfC2QFy728zjZ6dAU61YeAGUzAp8Tq4oSxOkTO9EcnY8LsVp2LW4Jb4tLYomNiiBY6f4ISi2jp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852372; c=relaxed/simple;
	bh=Zzh8G9Ktno/CPunpZz99wWJA9ns+H0V6qjxJUzvCzVo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TehdeTM1Nf0cMxpva3Crg6+gEJnzN72A3IKP6KQGJW3Wrrn+EXGpaVIU6h+8KW0g/UpTi/KOJDxWRBZoub20QPnSZ53AnppWgBFb2yMg3ibrbdxv7q4lGC35vf0K51RlTKONHMlK8Rrc797tyMfkGHkfSdCEHT6Bi8ou9HLadDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoEK7XGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700F4C113CD
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712852372;
	bh=Zzh8G9Ktno/CPunpZz99wWJA9ns+H0V6qjxJUzvCzVo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aoEK7XGMzVCVYFgafzh7qlX+K3EZmEgBE/5VOMG0ma3q7xpwC5Fe4pec9EamBZcFT
	 VJH72EqvNozKO5q7EyvnTHBAka08XAQ2SGbygdRaWWAVGW+p9xgw4IrHIswww0yRQT
	 gOhKvGumKqoE9T3bvfxmkdqirLreT3AzAVzvJxYe6d6HVKJNNBiJfAOusoBVNoiaGK
	 zjzX15g3H+H3t6Am9S6DcTZaRVgHoOVE/jqjlYCh5RityTM+zmGaeNf3j8FcXleWzJ
	 PStPFNXzk5SOTMzOEEZdFURfC+2pb8kAdHzx8Bp+rUX7BZxHrmKMvxOCgIcDIp9Yny
	 L4pqdkCzBxcpA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 15/15] btrfs: add tracepoints for extent map shrinker events
Date: Thu, 11 Apr 2024 17:19:09 +0100
Message-Id: <f291471384c2b3819f2dcf4eeb9d11158aa11e84.1712837044.git.fdmanana@suse.com>
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

Add some tracepoints for the extent map shrinker to help debug and analyse
main events. These have proved useful during development of the shrinker.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c        | 18 ++++++-
 include/trace/events/btrfs.h | 92 ++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 9791acda5b57..5c40efe39e70 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1064,6 +1064,7 @@ static unsigned long btrfs_scan_inode(struct btrfs_inode *inode,
 			btrfs_set_inode_full_sync(inode);
 
 		remove_extent_mapping(inode, em);
+		trace_btrfs_extent_map_shrinker_remove_em(inode, em);
 		/* Drop the reference for the tree. */
 		free_extent_map(em);
 		nr_dropped++;
@@ -1118,6 +1119,12 @@ static unsigned long btrfs_extent_maps_scan(struct shrinker *shrinker,
 	unsigned long scanned = 0;
 	u64 next_root_id = 0;
 
+	if (trace_btrfs_extent_map_shrinker_scan_enter_enabled()) {
+		s64 nr = percpu_counter_sum_positive(&fs_info->evictable_extent_maps);
+
+		trace_btrfs_extent_map_shrinker_scan_enter(fs_info, sc->nr_to_scan, nr);
+	}
+
 	while (scanned < sc->nr_to_scan) {
 		struct btrfs_root *root;
 		unsigned long count;
@@ -1142,6 +1149,12 @@ static unsigned long btrfs_extent_maps_scan(struct shrinker *shrinker,
 		btrfs_put_root(root);
 	}
 
+	if (trace_btrfs_extent_map_shrinker_scan_exit_enabled()) {
+		s64 nr = percpu_counter_sum_positive(&fs_info->evictable_extent_maps);
+
+		trace_btrfs_extent_map_shrinker_scan_exit(fs_info, nr_dropped, nr);
+	}
+
 	return nr_dropped;
 }
 
@@ -1149,8 +1162,11 @@ static unsigned long btrfs_extent_maps_count(struct shrinker *shrinker,
 					     struct shrink_control *sc)
 {
 	struct btrfs_fs_info *fs_info = shrinker->private_data;
+	const s64 nr = percpu_counter_sum_positive(&fs_info->evictable_extent_maps);
+
+	trace_btrfs_extent_map_shrinker_count(fs_info, sc->nr_to_scan, nr);
 
-	return percpu_counter_sum_positive(&fs_info->evictable_extent_maps);
+	return nr;
 }
 
 int btrfs_register_extent_map_shrinker(struct btrfs_fs_info *fs_info)
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 766cfd48386c..ba49efa2bc74 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2551,6 +2551,98 @@ TRACE_EVENT(btrfs_get_raid_extent_offset,
 			__entry->devid)
 );
 
+TRACE_EVENT(btrfs_extent_map_shrinker_count,
+
+	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 nr_to_scan, u64 nr),
+
+	TP_ARGS(fs_info, nr_to_scan, nr),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	nr_to_scan	)
+		__field(	u64,	nr		)
+	),
+
+	TP_fast_assign_btrfs(fs_info,
+		__entry->nr_to_scan	= nr_to_scan;
+		__entry->nr		= nr;
+	),
+
+	TP_printk_btrfs("nr_to_scan=%llu nr=%llu",
+			__entry->nr_to_scan, __entry->nr)
+);
+
+TRACE_EVENT(btrfs_extent_map_shrinker_scan_enter,
+
+	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 nr_to_scan, u64 nr),
+
+	TP_ARGS(fs_info, nr_to_scan, nr),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	nr_to_scan	)
+		__field(	u64,	nr		)
+	),
+
+	TP_fast_assign_btrfs(fs_info,
+		__entry->nr_to_scan	= nr_to_scan;
+		__entry->nr		= nr;
+	),
+
+	TP_printk_btrfs("nr_to_scan=%llu nr=%llu",
+			__entry->nr_to_scan, __entry->nr)
+);
+
+TRACE_EVENT(btrfs_extent_map_shrinker_scan_exit,
+
+	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 nr_dropped, u64 nr),
+
+	TP_ARGS(fs_info, nr_dropped, nr),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	nr_dropped	)
+		__field(	u64,	nr		)
+	),
+
+	TP_fast_assign_btrfs(fs_info,
+		__entry->nr_dropped	= nr_dropped;
+		__entry->nr		= nr;
+	),
+
+	TP_printk_btrfs("nr_dropped=%llu nr=%llu",
+			__entry->nr_dropped, __entry->nr)
+);
+
+TRACE_EVENT(btrfs_extent_map_shrinker_remove_em,
+
+	TP_PROTO(const struct btrfs_inode *inode, const struct extent_map *em),
+
+	TP_ARGS(inode, em),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	ino		)
+		__field(	u64,	root_id		)
+		__field(	u64,	start		)
+		__field(	u64,	len		)
+		__field(	u64,	block_start	)
+		__field(	u32,	flags		)
+	),
+
+	TP_fast_assign_btrfs(inode->root->fs_info,
+		__entry->ino		= btrfs_ino(inode);
+		__entry->root_id	= inode->root->root_key.objectid;
+		__entry->start		= em->start;
+		__entry->len		= em->len;
+		__entry->block_start	= em->block_start;
+		__entry->flags		= em->flags;
+	),
+
+	TP_printk_btrfs(
+"ino=%llu root=%llu(%s) start=%llu len=%llu block_start=%llu(%s) flags=%s",
+			__entry->ino, show_root_type(__entry->root_id),
+			__entry->start, __entry->len,
+			show_map_type(__entry->block_start),
+			show_map_flags(__entry->flags))
+);
+
 #endif /* _TRACE_BTRFS_H */
 
 /* This part must be outside protection */
-- 
2.43.0


