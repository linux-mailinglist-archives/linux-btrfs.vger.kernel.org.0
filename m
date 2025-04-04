Return-Path: <linux-btrfs+bounces-12796-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A621A7BAEC
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 12:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420F13A3820
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 10:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E801C84DC;
	Fri,  4 Apr 2025 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtLaMx3d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1B11B21B4
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762670; cv=none; b=L4xdYtaCLJsrlj6dkqWT1/Iuk7uRYMkhTrJ1LtY4Gt+Td9Jf+iZCkfGkLv7FxWgT3F0v+Ut/pg/B4QQ4W6Jfm3KVPbqZ/YD82WfQ8iqYyKzd8oBO+FUUUyCMkC88jABNh96UvcxsCzcomVFzM1sMc6mJ1THBYnf8TmbM/FaFiJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762670; c=relaxed/simple;
	bh=ASV7GmG6hZ4bPLk4UgCCwLfpykH5Uf53H+fdjXzVymU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=isuV8KEjFceiYctOsvPxYxDVXvKFbiCXDFO/Nky4fHyvsQb67iZNkNvgqXN4Vpkkw7X7MjVOeNMOjqN5TdrE381PMlrptB+RPvenEBoTzkwKN+w7EAiWO12yruYhgwjut1i+1u2qDycRBqy8H0jWCS3rr/aaMf2YVmy7/UAtX4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtLaMx3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98470C4CEDD
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 10:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743762669;
	bh=ASV7GmG6hZ4bPLk4UgCCwLfpykH5Uf53H+fdjXzVymU=;
	h=From:To:Subject:Date:From;
	b=YtLaMx3dctlOBzDXGB40RKJDA96UwEPU4QrDWbP6IHknVIsAyuwjFYKKy2ZiEDwrR
	 05R1wHTbjBWWaUpa0Hyhccn5Eaxq2z4j+Pm4sHEsVrSiypa0WbxIcwtMj8Kavi0i66
	 ezulzmfXQkR9MTpAW21SD1sJwIsRKItOb1WK43uksLpJYFy+hFS2V9GyG38s/BjM9a
	 mFKjVHG6jvC4D6rtwB+wGG1YXRtEkJ/0EV03NgGbr2y8WaMekoyRW+KVPNurp/iTbS
	 VHHS4ctkbH0VZ3NlmWqZndWqILRZ2zPkWmHdzZq8r5dHcR9LHXCCeKiLz1TgSwODCE
	 yBb6Xa/rnfVdw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: tracepoints: use btrfs_root_id() to get the id of a root
Date: Fri,  4 Apr 2025 11:31:05 +0100
Message-Id: <acef2fc25f3912f7cb105e45d4d63a3a096c2eb6.1743762625.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of open coding btrfs_root_id() to get the ID of a root, use the
helper in the tracepoints, which also makes the code less verbose.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 include/trace/events/btrfs.h | 50 +++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 60f279181ae2..f3481a362483 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -223,8 +223,7 @@ DECLARE_EVENT_CLASS(btrfs__inode,
 		__entry->generation = BTRFS_I(inode)->generation;
 		__entry->last_trans = BTRFS_I(inode)->last_trans;
 		__entry->logged_trans = BTRFS_I(inode)->logged_trans;
-		__entry->root_objectid =
-				BTRFS_I(inode)->root->root_key.objectid;
+		__entry->root_objectid = btrfs_root_id(BTRFS_I(inode)->root);
 	),
 
 	TP_printk_btrfs("root=%llu(%s) gen=%llu ino=%llu blocks=%llu "
@@ -296,7 +295,7 @@ TRACE_EVENT_CONDITION(btrfs_get_extent,
 	),
 
 	TP_fast_assign_btrfs(root->fs_info,
-		__entry->root_objectid	= root->root_key.objectid;
+		__entry->root_objectid	= btrfs_root_id(root);
 		__entry->ino		= btrfs_ino(inode);
 		__entry->start		= map->start;
 		__entry->len		= map->len;
@@ -375,7 +374,7 @@ DECLARE_EVENT_CLASS(btrfs__file_extent_item_regular,
 	),
 
 	TP_fast_assign_btrfs(bi->root->fs_info,
-		__entry->root_obj	= bi->root->root_key.objectid;
+		__entry->root_obj	= btrfs_root_id(bi->root);
 		__entry->ino		= btrfs_ino(bi);
 		__entry->isize		= bi->vfs_inode.i_size;
 		__entry->disk_isize	= bi->disk_i_size;
@@ -426,7 +425,7 @@ DECLARE_EVENT_CLASS(
 
 	TP_fast_assign_btrfs(
 		bi->root->fs_info,
-		__entry->root_obj	= bi->root->root_key.objectid;
+		__entry->root_obj	= btrfs_root_id(bi->root);
 		__entry->ino		= btrfs_ino(bi);
 		__entry->isize		= bi->vfs_inode.i_size;
 		__entry->disk_isize	= bi->disk_i_size;
@@ -526,7 +525,7 @@ DECLARE_EVENT_CLASS(btrfs__ordered_extent,
 		__entry->flags		= ordered->flags;
 		__entry->compress_type	= ordered->compress_type;
 		__entry->refs		= refcount_read(&ordered->refs);
-		__entry->root_objectid	= inode->root->root_key.objectid;
+		__entry->root_objectid	= btrfs_root_id(inode->root);
 		__entry->truncated_len	= ordered->truncated_len;
 	),
 
@@ -663,7 +662,7 @@ TRACE_EVENT(btrfs_finish_ordered_extent,
 		__entry->start	= start;
 		__entry->len	= len;
 		__entry->uptodate = uptodate;
-		__entry->root_objectid = inode->root->root_key.objectid;
+		__entry->root_objectid = btrfs_root_id(inode->root);
 	),
 
 	TP_printk_btrfs("root=%llu(%s) ino=%llu start=%llu len=%llu uptodate=%d",
@@ -704,8 +703,7 @@ DECLARE_EVENT_CLASS(btrfs__writepage,
 		__entry->for_reclaim	= wbc->for_reclaim;
 		__entry->range_cyclic	= wbc->range_cyclic;
 		__entry->writeback_index = inode->i_mapping->writeback_index;
-		__entry->root_objectid	=
-				 BTRFS_I(inode)->root->root_key.objectid;
+		__entry->root_objectid	= btrfs_root_id(BTRFS_I(inode)->root);
 	),
 
 	TP_printk_btrfs("root=%llu(%s) ino=%llu page_index=%lu "
@@ -749,7 +747,7 @@ TRACE_EVENT(btrfs_writepage_end_io_hook,
 		__entry->start	= start;
 		__entry->end	= end;
 		__entry->uptodate = uptodate;
-		__entry->root_objectid = inode->root->root_key.objectid;
+		__entry->root_objectid = btrfs_root_id(inode->root);
 	),
 
 	TP_printk_btrfs("root=%llu(%s) ino=%llu start=%llu end=%llu uptodate=%d",
@@ -779,8 +777,7 @@ TRACE_EVENT(btrfs_sync_file,
 		__entry->ino		= btrfs_ino(BTRFS_I(inode));
 		__entry->parent		= btrfs_ino(BTRFS_I(d_inode(dentry->d_parent)));
 		__entry->datasync	= datasync;
-		__entry->root_objectid	=
-				 BTRFS_I(inode)->root->root_key.objectid;
+		__entry->root_objectid	= btrfs_root_id(BTRFS_I(inode)->root);
 	),
 
 	TP_printk_btrfs("root=%llu(%s) ino=%llu parent=%llu datasync=%d",
@@ -1051,7 +1048,7 @@ DECLARE_EVENT_CLASS(btrfs__chunk,
 		__entry->sub_stripes	= map->sub_stripes;
 		__entry->offset		= offset;
 		__entry->size		= size;
-		__entry->root_objectid	= fs_info->chunk_root->root_key.objectid;
+		__entry->root_objectid	= btrfs_root_id(fs_info->chunk_root);
 	),
 
 	TP_printk_btrfs("root=%llu(%s) offset=%llu size=%llu "
@@ -1096,7 +1093,7 @@ TRACE_EVENT(btrfs_cow_block,
 	),
 
 	TP_fast_assign_btrfs(root->fs_info,
-		__entry->root_objectid	= root->root_key.objectid;
+		__entry->root_objectid	= btrfs_root_id(root);
 		__entry->buf_start	= buf->start;
 		__entry->refs		= atomic_read(&buf->refs);
 		__entry->cow_start	= cow->start;
@@ -1254,7 +1251,7 @@ TRACE_EVENT(find_free_extent,
 	),
 
 	TP_fast_assign_btrfs(root->fs_info,
-		__entry->root_objectid	= root->root_key.objectid;
+		__entry->root_objectid	= btrfs_root_id(root);
 		__entry->num_bytes	= ffe_ctl->num_bytes;
 		__entry->empty_size	= ffe_ctl->empty_size;
 		__entry->flags		= ffe_ctl->flags;
@@ -1283,7 +1280,7 @@ TRACE_EVENT(find_free_extent_search_loop,
 	),
 
 	TP_fast_assign_btrfs(root->fs_info,
-		__entry->root_objectid	= root->root_key.objectid;
+		__entry->root_objectid	= btrfs_root_id(root);
 		__entry->num_bytes	= ffe_ctl->num_bytes;
 		__entry->empty_size	= ffe_ctl->empty_size;
 		__entry->flags		= ffe_ctl->flags;
@@ -1317,7 +1314,7 @@ TRACE_EVENT(find_free_extent_have_block_group,
 	),
 
 	TP_fast_assign_btrfs(root->fs_info,
-		__entry->root_objectid	= root->root_key.objectid;
+		__entry->root_objectid	= btrfs_root_id(root);
 		__entry->num_bytes	= ffe_ctl->num_bytes;
 		__entry->empty_size	= ffe_ctl->empty_size;
 		__entry->flags		= ffe_ctl->flags;
@@ -1671,8 +1668,7 @@ DECLARE_EVENT_CLASS(btrfs__qgroup_rsv_data,
 	),
 
 	TP_fast_assign_btrfs(btrfs_sb(inode->i_sb),
-		__entry->rootid		=
-			BTRFS_I(inode)->root->root_key.objectid;
+		__entry->rootid		= btrfs_root_id(BTRFS_I(inode)->root);
 		__entry->ino		= btrfs_ino(BTRFS_I(inode));
 		__entry->start		= start;
 		__entry->len		= len;
@@ -1865,7 +1861,7 @@ TRACE_EVENT(qgroup_meta_reserve,
 	),
 
 	TP_fast_assign_btrfs(root->fs_info,
-		__entry->refroot	= root->root_key.objectid;
+		__entry->refroot	= btrfs_root_id(root);
 		__entry->diff		= diff;
 		__entry->type		= type;
 	),
@@ -1887,7 +1883,7 @@ TRACE_EVENT(qgroup_meta_convert,
 	),
 
 	TP_fast_assign_btrfs(root->fs_info,
-		__entry->refroot	= root->root_key.objectid;
+		__entry->refroot	= btrfs_root_id(root);
 		__entry->diff		= diff;
 	),
 
@@ -1911,7 +1907,7 @@ TRACE_EVENT(qgroup_meta_free_all_pertrans,
 	),
 
 	TP_fast_assign_btrfs(root->fs_info,
-		__entry->refroot	= root->root_key.objectid;
+		__entry->refroot	= btrfs_root_id(root);
 		spin_lock(&root->qgroup_meta_rsv_lock);
 		__entry->diff		= -(s64)root->qgroup_meta_rsv_pertrans;
 		spin_unlock(&root->qgroup_meta_rsv_lock);
@@ -1993,7 +1989,7 @@ TRACE_EVENT(btrfs_inode_mod_outstanding_extents,
 	),
 
 	TP_fast_assign_btrfs(root->fs_info,
-		__entry->root_objectid	= root->root_key.objectid;
+		__entry->root_objectid	= btrfs_root_id(root);
 		__entry->ino		= ino;
 		__entry->mod		= mod;
 		__entry->outstanding    = outstanding;
@@ -2078,7 +2074,7 @@ TRACE_EVENT(btrfs_set_extent_bit,
 
 		__entry->owner		= tree->owner;
 		__entry->ino		= inode ? btrfs_ino(inode) : 0;
-		__entry->rootid		= inode ? inode->root->root_key.objectid : 0;
+		__entry->rootid		= inode ? btrfs_root_id(inode->root) : 0;
 		__entry->start		= start;
 		__entry->len		= len;
 		__entry->set_bits	= set_bits;
@@ -2111,7 +2107,7 @@ TRACE_EVENT(btrfs_clear_extent_bit,
 
 		__entry->owner		= tree->owner;
 		__entry->ino		= inode ? btrfs_ino(inode) : 0;
-		__entry->rootid		= inode ? inode->root->root_key.objectid : 0;
+		__entry->rootid		= inode ? btrfs_root_id(inode->root) : 0;
 		__entry->start		= start;
 		__entry->len		= len;
 		__entry->clear_bits	= clear_bits;
@@ -2145,7 +2141,7 @@ TRACE_EVENT(btrfs_convert_extent_bit,
 
 		__entry->owner		= tree->owner;
 		__entry->ino		= inode ? btrfs_ino(inode) : 0;
-		__entry->rootid		= inode ? inode->root->root_key.objectid : 0;
+		__entry->rootid		= inode ? btrfs_root_id(inode->root) : 0;
 		__entry->start		= start;
 		__entry->len		= len;
 		__entry->set_bits	= set_bits;
@@ -2620,7 +2616,7 @@ TRACE_EVENT(btrfs_extent_map_shrinker_remove_em,
 
 	TP_fast_assign_btrfs(inode->root->fs_info,
 		__entry->ino		= btrfs_ino(inode);
-		__entry->root_id	= inode->root->root_key.objectid;
+		__entry->root_id	= btrfs_root_id(inode->root);
 		__entry->start		= em->start;
 		__entry->len		= em->len;
 		__entry->flags		= em->flags;
-- 
2.45.2


