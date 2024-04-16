Return-Path: <linux-btrfs+bounces-4310-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 604428A6BE3
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 15:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5298D1C214CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 13:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B72F12C473;
	Tue, 16 Apr 2024 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfoWc41J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76D412CD8C
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272905; cv=none; b=i3Qlj/oburaxSNvpVPsii7o71zgdf6uCG7afO/LzI65B8+BflDwZiINYeSXjfkufdmXRtdd0i9siNI2EsrfD8tq+nuYYerPUbHTmoAuVOccC+RK4CvP7MQTOHvk80PaoitcndUvvl+3njz0qg4dg8l26VBgLm+pyexYSK6kIj+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272905; c=relaxed/simple;
	bh=CnF0TlW1MdISiGc6Pb32Gfocqps+xZ7JI3Umg1IrJmo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aC+0LzOah53az2OK3aUThpZE2TW55DnMQDZcXfPPr9tT2T77pZNgU+v7WIbJJ2haJ7Eh4q44GjwUpy4KgiFAxeeFDCUOuriS0x04VTqA318eIbcNMKDT0rHKadV5rwPqbQ23khUWyYUbI4+kOVsUvm7Dwb9W46moVRGbUWl27Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfoWc41J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D3DC32783
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 13:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713272905;
	bh=CnF0TlW1MdISiGc6Pb32Gfocqps+xZ7JI3Umg1IrJmo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RfoWc41JisSw8gl9R1D/Cwa//9kp1mslbzRQSu7AAWsXxBYfj/qicRUUZfm9URc35
	 XY2ZTOja3zzrxlnAUW44wFmpxtbadKWL47GPDz6AXhIIttMABoiMtAWzcXpcTuOoyy
	 BfLcGdO5P0AQ6PIac43BtIDuYSs/4hUCub6b/1qm3jVY6Cl10mUnysNOOga4rWAjiZ
	 hbFUGdJoyTPfWOQqDcC3LgGRsNeDeYlXHgyrLXz1QBt+IVufyf2HS3e0XDIzlb5b6H
	 sfhaR2zwOG3CtL3ytgAYMtKycc3Q2SY1RFWPKeruJU4V6n1ZsfsBsOgABt27+zrAiA
	 Bzr7RRH8lryaQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 10/10] btrfs: add tracepoints for extent map shrinker events
Date: Tue, 16 Apr 2024 14:08:12 +0100
Message-Id: <1f936e6053adef193d57f9ca87c68797c88fae1e.1713267925.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713267925.git.fdmanana@suse.com>
References: <cover.1713267925.git.fdmanana@suse.com>
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
 fs/btrfs/extent_map.c        | 13 +++++
 fs/btrfs/super.c             |  5 +-
 include/trace/events/btrfs.h | 99 ++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index b638d87db500..2967b3d78399 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1080,6 +1080,7 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, long *scanned, long nr_t
 			btrfs_set_inode_full_sync(inode);
 
 		remove_extent_mapping(inode, em);
+		trace_btrfs_extent_map_shrinker_remove_em(inode, em);
 		/* Drop the reference for the tree. */
 		free_extent_map(em);
 		nr_dropped++;
@@ -1152,6 +1153,12 @@ long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
 	long nr_dropped = 0;
 	long scanned = 0;
 
+	if (trace_btrfs_extent_map_shrinker_scan_enter_enabled()) {
+		s64 nr = percpu_counter_sum_positive(&fs_info->evictable_extent_maps);
+
+		trace_btrfs_extent_map_shrinker_scan_enter(fs_info, nr_to_scan, nr);
+	}
+
 	while (scanned < nr_to_scan) {
 		struct btrfs_root *root;
 		unsigned long count;
@@ -1183,5 +1190,11 @@ long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
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
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a3877e65d3b5..670914835d8a 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2377,8 +2377,11 @@ static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
 static long btrfs_nr_cached_objects(struct super_block *sb, struct shrink_control *sc)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+	const s64 nr = percpu_counter_sum_positive(&fs_info->evictable_extent_maps);
 
-	return percpu_counter_sum_positive(&fs_info->evictable_extent_maps);
+	trace_btrfs_extent_map_shrinker_count(fs_info, nr);
+
+	return nr;
 }
 
 static long btrfs_free_cached_objects(struct super_block *sb, struct shrink_control *sc)
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 8f2497603cb5..d2d94d7c3fb5 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2537,6 +2537,105 @@ TRACE_EVENT(btrfs_get_raid_extent_offset,
 			__entry->devid)
 );
 
+TRACE_EVENT(btrfs_extent_map_shrinker_count,
+
+	TP_PROTO(const struct btrfs_fs_info *fs_info, long nr),
+
+	TP_ARGS(fs_info, nr),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	long,	nr	)
+	),
+
+	TP_fast_assign_btrfs(fs_info,
+		__entry->nr		= nr;
+	),
+
+	TP_printk_btrfs("nr=%ld", __entry->nr)
+);
+
+TRACE_EVENT(btrfs_extent_map_shrinker_scan_enter,
+
+	TP_PROTO(const struct btrfs_fs_info *fs_info, long nr_to_scan, long nr),
+
+	TP_ARGS(fs_info, nr_to_scan, nr),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	long,	nr_to_scan	)
+		__field(	long,	nr		)
+		__field(	u64,	last_root_id	)
+		__field(	u64,	last_ino	)
+	),
+
+	TP_fast_assign_btrfs(fs_info,
+		__entry->nr_to_scan	= nr_to_scan;
+		__entry->nr		= nr;
+		__entry->last_root_id	= fs_info->extent_map_shrinker_last_root;
+		__entry->last_ino	= fs_info->extent_map_shrinker_last_ino;
+	),
+
+	TP_printk_btrfs("nr_to_scan=%ld nr=%ld last_root=%llu(%s) last_ino=%llu",
+			__entry->nr_to_scan, __entry->nr,
+			show_root_type(__entry->last_root_id), __entry->last_ino)
+);
+
+TRACE_EVENT(btrfs_extent_map_shrinker_scan_exit,
+
+	TP_PROTO(const struct btrfs_fs_info *fs_info, long nr_dropped, long nr),
+
+	TP_ARGS(fs_info, nr_dropped, nr),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	long,	nr_dropped	)
+		__field(	long,	nr		)
+		__field(	u64,	last_root_id	)
+		__field(	u64,	last_ino	)
+	),
+
+	TP_fast_assign_btrfs(fs_info,
+		__entry->nr_dropped	= nr_dropped;
+		__entry->nr		= nr;
+		__entry->last_root_id	= fs_info->extent_map_shrinker_last_root;
+		__entry->last_ino	= fs_info->extent_map_shrinker_last_ino;
+	),
+
+	TP_printk_btrfs("nr_dropped=%ld nr=%ld last_root=%llu(%s) last_ino=%llu",
+			__entry->nr_dropped, __entry->nr,
+			show_root_type(__entry->last_root_id), __entry->last_ino)
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


