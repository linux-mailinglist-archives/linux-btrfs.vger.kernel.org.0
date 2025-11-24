Return-Path: <linux-btrfs+bounces-19317-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 017C7C822E1
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 19:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 003664E7E72
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 18:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E269131A7E7;
	Mon, 24 Nov 2025 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="YgvX1vcR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11562D46DD
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764010422; cv=none; b=XVz6bRX6LzY5FYEILvvcgRFiAKn7+qvgL/9DuA4rfgxohsUnlo5mzEKyJDaLmaKpCdCxtaRE1CX84Q2HmBCD7UChqZLasjL3azhZGO0mF2ZRukwGex/2ZORnJRvzhfZnoe1OrrnGQfMl90kVQWxBp7pk7F7GdCwLYKEprV9hnLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764010422; c=relaxed/simple;
	bh=SmA3XjgBCabdUGMV2tLKuPeCQIhnpurF7C3rwvKBg0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=F0dQVSJ453KRYAeYvxjVzp15XnyDYwp+Q7eoJDoAz/nV1tu8hGShvSqAblsI/DCTgLzyA38aV3uZVQdAkjvEz+N4+tdo0HHsoIH6RwGZQ9ZqV6zHbg1dT8XlVt9pf7e8KYsZbT900vfgbNi9SvPQ1Olnz6Mo9K3mbY86DppomMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=YgvX1vcR; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 6D00A2DEC65;
	Mon, 24 Nov 2025 18:53:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1764010411;
	bh=ViacvGXuI+u7Z+ASG8xdr+sDewhaDHXWueZB45cymOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YgvX1vcRQF7Lmwjuh7CPM1xNq3Kss5278doC2VbeQ0P9sXseKA04eCqm07eBOR7T5
	 G2519wgI9FnWNKSzMbWv0cfXGAeYw0TtvAFtPAXkO/E5D1lqj/gOMXi7ac+Q4QkQji
	 c2BPF5f+/jE/zfUvknO19R/62U64lk7XTu0B7ZO4=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v7 13/16] btrfs: add do_remap param to btrfs_discard_extent()
Date: Mon, 24 Nov 2025 18:53:05 +0000
Message-ID: <20251124185335.16556-14-mark@harmstone.com>
In-Reply-To: <20251124185335.16556-1-mark@harmstone.com>
References: <20251124185335.16556-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs_discard_extent() can be called either when an extent is removed
or from walking the free-space tree. With a remapped block group these
two things are no longer equivalent: the extent's addresses are
remapped, while the free-space tree exclusively uses underlying
addresses.

Add a do_remap parameter to btrfs_discard_extent() and
btrfs_map_discard(), saying whether or not the address needs to be run
through the remap tree first.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
Reviewed-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent-tree.c      | 11 +++++++----
 fs/btrfs/extent-tree.h      |  2 +-
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/inode.c            |  2 +-
 fs/btrfs/volumes.c          | 23 +++++++++++++++++++++--
 fs/btrfs/volumes.h          |  2 +-
 6 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ef832acf3ff4..1d86abee4e23 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1381,7 +1381,7 @@ static int do_discard_extent(struct btrfs_discard_stripe *stripe, u64 *bytes)
 }
 
 int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
-			 u64 num_bytes, u64 *actual_bytes)
+			 u64 num_bytes, u64 *actual_bytes, bool do_remap)
 {
 	int ret = 0;
 	u64 discarded_bytes = 0;
@@ -1399,7 +1399,8 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 		int i;
 
 		num_bytes = end - cur;
-		stripes = btrfs_map_discard(fs_info, cur, &num_bytes, &num_stripes);
+		stripes = btrfs_map_discard(fs_info, cur, &num_bytes,
+					    &num_stripes, do_remap);
 		if (IS_ERR(stripes)) {
 			ret = PTR_ERR(stripes);
 			if (ret == -EOPNOTSUPP)
@@ -2935,7 +2936,8 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 
 		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
 			ret = btrfs_discard_extent(fs_info, start,
-						   end + 1 - start, NULL);
+						   end + 1 - start, NULL,
+						   true);
 
 		next_state = btrfs_next_extent_state(unpin, cached_state);
 		btrfs_clear_extent_dirty(unpin, start, end, &cached_state);
@@ -2993,7 +2995,8 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 		ret = -EROFS;
 		if (!TRANS_ABORTED(trans))
 			ret = btrfs_discard_extent(fs_info, block_group->start,
-						   block_group->length, NULL);
+						   block_group->length, NULL,
+						   true);
 
 		/*
 		 * Not strictly necessary to lock, as the block_group should be
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 638c8aeb3df9..d53f3f76deb1 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -161,7 +161,7 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 			struct extent_buffer *parent);
 void btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info, u64 start, u64 end);
 int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
-			 u64 num_bytes, u64 *actual_bytes);
+			 u64 num_bytes, u64 *actual_bytes, bool do_remap);
 int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range);
 void btrfs_handle_fully_remapped_bgs(struct btrfs_fs_info *fs_info);
 int btrfs_complete_bg_remapping(struct btrfs_block_group *block_group);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 8d4db3d57cf7..17e79ee3e021 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3677,7 +3677,7 @@ static int do_trimming(struct btrfs_block_group *block_group,
 	}
 	spin_unlock(&space_info->lock);
 
-	ret = btrfs_discard_extent(fs_info, start, bytes, &trimmed);
+	ret = btrfs_discard_extent(fs_info, start, bytes, &trimmed, false);
 	if (!ret) {
 		*total_trimmed += trimmed;
 		trim_state = BTRFS_TRIM_STATE_TRIMMED;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0cbac085cdaf..c7324b382ebd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3310,7 +3310,7 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 				btrfs_discard_extent(fs_info,
 						ordered_extent->disk_bytenr,
 						ordered_extent->disk_num_bytes,
-						NULL);
+						NULL, true);
 			btrfs_free_reserved_extent(fs_info,
 					ordered_extent->disk_bytenr,
 					ordered_extent->disk_num_bytes, true);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d676addf6ef4..58ea0ef9d9c4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3429,7 +3429,7 @@ static int btrfs_relocate_chunk_finish(struct btrfs_fs_info *fs_info,
 	 */
 	if (btrfs_is_zoned(fs_info)) {
 		ret = btrfs_discard_extent(fs_info, block_group->start, length,
-					   NULL);
+					   NULL, true);
 		if (ret)
 			btrfs_info(fs_info,
 				   "failed to reset zone %llu after relocation",
@@ -6113,7 +6113,7 @@ void btrfs_put_bioc(struct btrfs_io_context *bioc)
  */
 struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 					       u64 logical, u64 *length_ret,
-					       u32 *num_stripes)
+					       u32 *num_stripes, bool do_remap)
 {
 	struct btrfs_chunk_map *map;
 	struct btrfs_discard_stripe *stripes;
@@ -6137,6 +6137,25 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 	if (IS_ERR(map))
 		return ERR_CAST(map);
 
+	if (do_remap && map->type & BTRFS_BLOCK_GROUP_REMAPPED) {
+		u64 new_logical = logical;
+
+		ret = btrfs_translate_remap(fs_info, &new_logical, &length);
+		if (ret)
+			goto out_free_map;
+
+		if (new_logical != logical) {
+			btrfs_free_chunk_map(map);
+
+			map = btrfs_get_chunk_map(fs_info, new_logical,
+						  length);
+			if (IS_ERR(map))
+				return ERR_CAST(map);
+
+			logical = new_logical;
+		}
+	}
+
 	/* we don't discard raid56 yet */
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
 		ret = -EOPNOTSUPP;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index ccf0a459180d..505a50689fb0 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -732,7 +732,7 @@ int btrfs_map_repair_block(struct btrfs_fs_info *fs_info,
 			   u32 length, int mirror_num);
 struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 					       u64 logical, u64 *length_ret,
-					       u32 *num_stripes);
+					       u32 *num_stripes, bool do_remap);
 int btrfs_read_sys_array(struct btrfs_fs_info *fs_info);
 int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
 struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
-- 
2.51.0


