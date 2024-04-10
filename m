Return-Path: <linux-btrfs+bounces-4109-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF54E89F0E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 13:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12541C20DE9
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 11:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB8715EFA2;
	Wed, 10 Apr 2024 11:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9OKaymP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D717615ECFA
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748538; cv=none; b=T4ujeBAFQqLiQ7Ck2ZSY+nve2cye/N/op/i8eyCTao3V4bhfx2hwEPEkyoXvPMHvHvSJB0pHkUOmX9uSKy+vQ7/2hqOTVGHvv9oBm5cGIThNMXwFozr6PqkdvhmChhFZGj+uV0ueMAFQSGMfv5s3X89bEnGyzX3MCki/lf7Pv1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748538; c=relaxed/simple;
	bh=Zb2rQqiZU6tC91zUVqi9UHGP3O/3KGkbYmmC6n450kU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gs0ifemHx6XN1MdaRxwEhrAr7PkzFxdxxXhQmmk7YOeOQz3KqjcBRoge6az7ZdunoKGqEx0Y8xhBfsbsfvWnMiAav8WXzk/6340ZN+ayMunJ/+16veltUazzPTWqFBB0KAFbA/uMiAS7qnajMkZ147gDoFHWaIjpfKXywre81Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9OKaymP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C901CC433C7
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 11:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712748538;
	bh=Zb2rQqiZU6tC91zUVqi9UHGP3O/3KGkbYmmC6n450kU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=r9OKaymP7bXn//othh57ID9bVoirObrKs7yyJFhyyUFmBeqvhNKiOYXaMQQHYlWy3
	 OS2WaQoi81AyV1EmT/f8ZyMwisdzLjM29QDOlwe2T4O/YDUUoqFxRLvy96zT/K938o
	 V/Mk4u5fuj9fttlLlCxzo8G64kxgbCfsLivktdHWTbW8HESvlZUSk7p0NvighZyffI
	 9uH8i8cU6jduwv7pLTGRyW4Fcn8IFr/1HSDcfuWyUogyr6owHrjoJbI3aN9+lwOylN
	 pxw/W1VFz3peNFsPql7rGhdzH0Eq7zsjsOM2Lhp6fefXt9acNW+FX63lrC8y86y8i1
	 AdxMvU75P2Zpw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 11/11] btrfs: add tracepoints for extent map shrinker events
Date: Wed, 10 Apr 2024 12:28:43 +0100
Message-Id: <f0e92a41e4f6fe694a74a0a208b4196e45ce2f90.1712748143.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712748143.git.fdmanana@suse.com>
References: <cover.1712748143.git.fdmanana@suse.com>
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
 fs/btrfs/extent_map.c        | 15 ++++++
 include/trace/events/btrfs.h | 92 ++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index fa755921442d..2be5324085fe 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1064,6 +1064,7 @@ static unsigned long btrfs_scan_inode(struct btrfs_inode *inode,
 			btrfs_set_inode_full_sync(inode);
 
 		remove_extent_mapping(inode, em);
+		trace_btrfs_extent_map_shrinker_remove_em(inode, em);
 		/* Drop the reference for the tree. */
 		free_extent_map(em);
 		nr_dropped++;
@@ -1156,6 +1157,12 @@ static unsigned long btrfs_extent_maps_scan(struct shrinker *shrinker,
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
@@ -1180,6 +1187,12 @@ static unsigned long btrfs_extent_maps_scan(struct shrinker *shrinker,
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
 
@@ -1189,6 +1202,8 @@ static unsigned long btrfs_extent_maps_count(struct shrinker *shrinker,
 	struct btrfs_fs_info *fs_info = shrinker->private_data;
 	const s64 total = percpu_counter_sum_positive(&fs_info->evictable_extent_maps);
 
+	trace_btrfs_extent_map_shrinker_count(fs_info, sc->nr_to_scan, total);
+
 	/* The unsigned long type is 32 bits on 32 bits platforms. */
 #if BITS_PER_LONG == 32
 	if (total > ULONG_MAX)
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


