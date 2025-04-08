Return-Path: <linux-btrfs+bounces-12873-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6966FA80F77
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 17:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0132B16A189
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 15:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5492253B2;
	Tue,  8 Apr 2025 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVgarCat"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652852144A1
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124989; cv=none; b=QAkuQn6iC5jqorAXXow1MTTenxCRu1HODbCFwZPXIdJpyftDvhcsXdlK0PWT0osBw+aJjH0sgiBXyKIVTyZh+MdoC81R3XpI3a24uMkvj8EHFg76zs2wgEkST9jobaIbQ+6HiyKrWWVBCwMyzdwS7e8p4+/KLd/tE2lf4j/Y3Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124989; c=relaxed/simple;
	bh=rbuErCJg3Qg5wT8BoH9qrrn8MFK567ZuyPjBsHjLHMs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yx43TIxEgCBESNoWq3XJSe0Oqz5tL3udpV8/c9vMqff9e0EDPLfRUgcHYecjmu5DgA1HEg5Be4Nk7g+jCeYFz8V1h1nSYmGIDikfysrmRGyfBUWqbfGgt39wqlAlOT04Obdu0jdwuiloq30GbbNiGU34zNMQluBUYqai+o5ULHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVgarCat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56401C4CEE7
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 15:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744124988;
	bh=rbuErCJg3Qg5wT8BoH9qrrn8MFK567ZuyPjBsHjLHMs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nVgarCatxe2V2wcCGlxi0C91BJn79JyV0pc2HBAnG0nBsS6cmaw4qIljl8Y/wEtzR
	 mXlNyFjdYIpkw5G8Mea4qKEA/VhLw8uuysXGLO/VV/Y6UeWy3r3BwOOY9582RjtsBV
	 4d2aj+mkrjI1nQsnAwF7m9ShN3RQ394M1agVmdiBBtwC4evYjhDRyd3xW8jMOZHykc
	 rfTBarrDXFxlT+XsKh9wuJyNx0mZsXbybzSKcq4PnOceV0E/w/De5Qzw8qPx4jSGnd
	 ZNyZHTaH5xwPMxlQMet5+1Fqg3N91G47hrvdZPuvu2wE09VGyGPhgBJuTHqAbGPi3w
	 mCHPGdK5wAKWA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: tracepoints: add btrfs prefix to names where it's missing
Date: Tue,  8 Apr 2025 16:09:43 +0100
Message-Id: <2e7de4ead72137012e7b8a1aaf44e542e4a28184.1744124799.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744124799.git.fdmanana@suse.com>
References: <cover.1744124799.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Most of our tracepoints have the 'btrfs_' prefix in their names but a few
of them are missing, making it inconsistent. So add the prefix to the ones
that are missing it, creating consistency, making it clear for users these
are btrfs tracepoints and eventually avoid name collisions with other
tracepoints defined by other kernel subsystems.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c       |  6 +++---
 fs/btrfs/qgroup.c            | 20 ++++++++++----------
 include/trace/events/btrfs.h | 18 +++++++++---------
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 266a159fe5bb..a68a8a07caff 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4376,7 +4376,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	ins->objectid = 0;
 	ins->offset = 0;
 
-	trace_find_free_extent(root, ffe_ctl);
+	trace_btrfs_find_free_extent(root, ffe_ctl);
 
 	space_info = btrfs_find_space_info(fs_info, ffe_ctl->flags);
 	if (!space_info) {
@@ -4427,7 +4427,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		}
 	}
 search:
-	trace_find_free_extent_search_loop(root, ffe_ctl);
+	trace_btrfs_find_free_extent_search_loop(root, ffe_ctl);
 	ffe_ctl->have_caching_bg = false;
 	if (ffe_ctl->index == btrfs_bg_flags_to_raid_index(ffe_ctl->flags) ||
 	    ffe_ctl->index == 0)
@@ -4479,7 +4479,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		}
 
 have_block_group:
-		trace_find_free_extent_have_block_group(root, ffe_ctl, block_group);
+		trace_btrfs_find_free_extent_have_block_group(root, ffe_ctl, block_group);
 		ffe_ctl->cached = btrfs_block_group_done(block_group);
 		if (unlikely(!ffe_ctl->cached)) {
 			ffe_ctl->have_caching_bg = true;
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 34d1920a51e2..f85e21e9cb40 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -83,7 +83,7 @@ static void qgroup_rsv_add(struct btrfs_fs_info *fs_info,
 			   struct btrfs_qgroup *qgroup, u64 num_bytes,
 			   enum btrfs_qgroup_rsv_type type)
 {
-	trace_qgroup_update_reserve(fs_info, qgroup, num_bytes, type);
+	trace_btrfs_qgroup_update_reserve(fs_info, qgroup, num_bytes, type);
 	qgroup->rsv.values[type] += num_bytes;
 }
 
@@ -91,7 +91,7 @@ static void qgroup_rsv_release(struct btrfs_fs_info *fs_info,
 			       struct btrfs_qgroup *qgroup, u64 num_bytes,
 			       enum btrfs_qgroup_rsv_type type)
 {
-	trace_qgroup_update_reserve(fs_info, qgroup, -(s64)num_bytes, type);
+	trace_btrfs_qgroup_update_reserve(fs_info, qgroup, -(s64)num_bytes, type);
 	if (qgroup->rsv.values[type] >= num_bytes) {
 		qgroup->rsv.values[type] -= num_bytes;
 		return;
@@ -2837,8 +2837,8 @@ static void qgroup_update_counters(struct btrfs_fs_info *fs_info,
 		cur_old_count = btrfs_qgroup_get_old_refcnt(qg, seq);
 		cur_new_count = btrfs_qgroup_get_new_refcnt(qg, seq);
 
-		trace_qgroup_update_counters(fs_info, qg, cur_old_count,
-					     cur_new_count);
+		trace_btrfs_qgroup_update_counters(fs_info, qg, cur_old_count,
+						   cur_new_count);
 
 		/* Rfer update part */
 		if (cur_old_count == 0 && cur_new_count > 0) {
@@ -3100,8 +3100,8 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 		kfree(record);
 
 	}
-	trace_qgroup_num_dirty_extents(fs_info, trans->transid,
-				       num_dirty_extents);
+	trace_btrfs_qgroup_num_dirty_extents(fs_info, trans->transid,
+					     num_dirty_extents);
 	return ret;
 }
 
@@ -4474,7 +4474,7 @@ int btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
 		return 0;
 
 	BUG_ON(num_bytes != round_down(num_bytes, fs_info->nodesize));
-	trace_qgroup_meta_reserve(root, (s64)num_bytes, type);
+	trace_btrfs_qgroup_meta_reserve(root, (s64)num_bytes, type);
 	ret = qgroup_reserve(root, num_bytes, enforce, type);
 	if (ret < 0)
 		return ret;
@@ -4519,7 +4519,7 @@ void btrfs_qgroup_free_meta_all_pertrans(struct btrfs_root *root)
 		return;
 
 	/* TODO: Update trace point to handle such free */
-	trace_qgroup_meta_free_all_pertrans(root);
+	trace_btrfs_qgroup_meta_free_all_pertrans(root);
 	/* Special value -1 means to free all reserved space */
 	btrfs_qgroup_free_refroot(fs_info, btrfs_root_id(root), (u64)-1,
 				  BTRFS_QGROUP_RSV_META_PERTRANS);
@@ -4541,7 +4541,7 @@ void __btrfs_qgroup_free_meta(struct btrfs_root *root, int num_bytes,
 	 */
 	num_bytes = sub_root_meta_rsv(root, num_bytes, type);
 	BUG_ON(num_bytes != round_down(num_bytes, fs_info->nodesize));
-	trace_qgroup_meta_reserve(root, -(s64)num_bytes, type);
+	trace_btrfs_qgroup_meta_reserve(root, -(s64)num_bytes, type);
 	btrfs_qgroup_free_refroot(fs_info, btrfs_root_id(root), num_bytes, type);
 }
 
@@ -4595,7 +4595,7 @@ void btrfs_qgroup_convert_reserved_meta(struct btrfs_root *root, int num_bytes)
 	/* Same as btrfs_qgroup_free_meta_prealloc() */
 	num_bytes = sub_root_meta_rsv(root, num_bytes,
 				      BTRFS_QGROUP_RSV_META_PREALLOC);
-	trace_qgroup_meta_convert(root, num_bytes);
+	trace_btrfs_qgroup_meta_convert(root, num_bytes);
 	qgroup_convert_meta(fs_info, btrfs_root_id(root), num_bytes);
 	if (!sb_rdonly(fs_info->sb))
 		add_root_meta_rsv(root, num_bytes, BTRFS_QGROUP_RSV_META_PERTRANS);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index afc31c26efd5..c261ccc3edec 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1236,7 +1236,7 @@ DEFINE_EVENT(btrfs__reserved_extent,  btrfs_reserved_extent_free,
 	TP_ARGS(fs_info, start, len)
 );
 
-TRACE_EVENT(find_free_extent,
+TRACE_EVENT(btrfs_find_free_extent,
 
 	TP_PROTO(const struct btrfs_root *root,
 		 const struct find_free_extent_ctl *ffe_ctl),
@@ -1264,7 +1264,7 @@ TRACE_EVENT(find_free_extent,
 				 BTRFS_GROUP_FLAGS))
 );
 
-TRACE_EVENT(find_free_extent_search_loop,
+TRACE_EVENT(btrfs_find_free_extent_search_loop,
 
 	TP_PROTO(const struct btrfs_root *root,
 		 const struct find_free_extent_ctl *ffe_ctl),
@@ -1294,7 +1294,7 @@ TRACE_EVENT(find_free_extent_search_loop,
 		  __entry->loop)
 );
 
-TRACE_EVENT(find_free_extent_have_block_group,
+TRACE_EVENT(btrfs_find_free_extent_have_block_group,
 
 	TP_PROTO(const struct btrfs_root *root,
 		 const struct find_free_extent_ctl *ffe_ctl,
@@ -1739,7 +1739,7 @@ DEFINE_EVENT(btrfs_qgroup_extent, btrfs_qgroup_trace_extent,
 	TP_ARGS(fs_info, rec, bytenr)
 );
 
-TRACE_EVENT(qgroup_num_dirty_extents,
+TRACE_EVENT(btrfs_qgroup_num_dirty_extents,
 
 	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 transid,
 		 u64 num_dirty_extents),
@@ -1793,7 +1793,7 @@ TRACE_EVENT(btrfs_qgroup_account_extent,
 		__entry->nr_new_roots)
 );
 
-TRACE_EVENT(qgroup_update_counters,
+TRACE_EVENT(btrfs_qgroup_update_counters,
 
 	TP_PROTO(const struct btrfs_fs_info *fs_info,
 		 const struct btrfs_qgroup *qgroup,
@@ -1822,7 +1822,7 @@ TRACE_EVENT(qgroup_update_counters,
 		  __entry->cur_old_count, __entry->cur_new_count)
 );
 
-TRACE_EVENT(qgroup_update_reserve,
+TRACE_EVENT(btrfs_qgroup_update_reserve,
 
 	TP_PROTO(const struct btrfs_fs_info *fs_info, const struct btrfs_qgroup *qgroup,
 		 s64 diff, int type),
@@ -1848,7 +1848,7 @@ TRACE_EVENT(qgroup_update_reserve,
 		__entry->cur_reserved, __entry->diff)
 );
 
-TRACE_EVENT(qgroup_meta_reserve,
+TRACE_EVENT(btrfs_qgroup_meta_reserve,
 
 	TP_PROTO(const struct btrfs_root *root, s64 diff, int type),
 
@@ -1871,7 +1871,7 @@ TRACE_EVENT(qgroup_meta_reserve,
 		__print_symbolic(__entry->type, QGROUP_RSV_TYPES), __entry->diff)
 );
 
-TRACE_EVENT(qgroup_meta_convert,
+TRACE_EVENT(btrfs_qgroup_meta_convert,
 
 	TP_PROTO(const struct btrfs_root *root, s64 diff),
 
@@ -1894,7 +1894,7 @@ TRACE_EVENT(qgroup_meta_convert,
 		__entry->diff)
 );
 
-TRACE_EVENT(qgroup_meta_free_all_pertrans,
+TRACE_EVENT(btrfs_qgroup_meta_free_all_pertrans,
 
 	TP_PROTO(struct btrfs_root *root),
 
-- 
2.45.2


