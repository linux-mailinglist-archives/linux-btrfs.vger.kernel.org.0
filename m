Return-Path: <linux-btrfs+bounces-18306-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB57C07A8F
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 20:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C7B1C27664
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 18:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CED34887D;
	Fri, 24 Oct 2025 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="B3wrznmX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38219347FE1
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329566; cv=none; b=gf6nEEUkO4jKKR/sUvCxeGM6ZyTECz3HM2lRWZoBcu1RfFxYWwhWVSsQRXnTLmbKfQK0OhktAsJLKOxcanZP7cEVIhi07EfUURNJORFw5YwKh1Veeep1YnAjZJxpib+Y+lkSX2VUq6NVF9QgUuphVAQ9csT/rjujtdsBiuiH+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329566; c=relaxed/simple;
	bh=s/7UYMZ5sEqR6JvjpAe/sKVFfTk9Zug3DhrTGerHNkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=FsYWD9al//ZMIn3PdUXfbOPZwkPu18iyzSpRaIcd/KMyPlvSsc+VUvq3y0omsEEfiBLpRf6Xo86E0cl70CGKGn6ncAZokCFvXzLhp1GXAP0cLN/0m0/lcsdka1YbnaQUHpqKFKh1Wnz96Ctyy0g9ETAkCUpX6U8xmZJwc7trQtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=B3wrznmX; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 0DCFC2CFE52;
	Fri, 24 Oct 2025 19:12:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1761329551;
	bh=4Q44DU0ZFU+Jyx+U9w4yqANCqMNss6Zii38fqOqkGEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B3wrznmXwnPtI/EezGrGkHmQ7NiklX8b3ExEMqg41Q2keGoxNdHjXUSRWj5U3JZDl
	 9TQNjjbLZwW3V7vEmiWmvfVrqcWqOyzkJxLLwTuUXHUSLD42YSuyt/IRA32q2SNs48
	 m2RJRi9rb8XRnXGkL4PbyeJGzDURbw1Xh5wH7GSY=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v4 13/16] btrfs: add do_remap param to btrfs_discard_extent()
Date: Fri, 24 Oct 2025 19:12:14 +0100
Message-ID: <20251024181227.32228-14-mark@harmstone.com>
In-Reply-To: <20251024181227.32228-1-mark@harmstone.com>
References: <20251024181227.32228-1-mark@harmstone.com>
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
---
 fs/btrfs/extent-tree.c      | 11 +++++++----
 fs/btrfs/extent-tree.h      |  2 +-
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/inode.c            |  2 +-
 fs/btrfs/volumes.c          | 24 ++++++++++++++++++++++--
 fs/btrfs/volumes.h          |  2 +-
 6 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 10dc6f8d2f71..82dc88915b7e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1380,7 +1380,7 @@ static int do_discard_extent(struct btrfs_discard_stripe *stripe, u64 *bytes)
 }
 
 int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
-			 u64 num_bytes, u64 *actual_bytes)
+			 u64 num_bytes, u64 *actual_bytes, bool do_remap)
 {
 	int ret = 0;
 	u64 discarded_bytes = 0;
@@ -1398,7 +1398,8 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 		int i;
 
 		num_bytes = end - cur;
-		stripes = btrfs_map_discard(fs_info, cur, &num_bytes, &num_stripes);
+		stripes = btrfs_map_discard(fs_info, cur, &num_bytes,
+					    &num_stripes, do_remap);
 		if (IS_ERR(stripes)) {
 			ret = PTR_ERR(stripes);
 			if (ret == -EOPNOTSUPP)
@@ -2914,7 +2915,8 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 
 		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
 			ret = btrfs_discard_extent(fs_info, start,
-						   end + 1 - start, NULL);
+						   end + 1 - start, NULL,
+						   true);
 
 		next_state = btrfs_next_extent_state(unpin, cached_state);
 		btrfs_clear_extent_dirty(unpin, start, end, &cached_state);
@@ -2972,7 +2974,8 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 		ret = -EROFS;
 		if (!TRANS_ABORTED(trans))
 			ret = btrfs_discard_extent(fs_info, block_group->start,
-						   block_group->length, NULL);
+						   block_group->length, NULL,
+						   true);
 
 		/*
 		 * Not strictly necessary to lock, as the block_group should be
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 6b67a4e528da..721b03d682b4 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -162,7 +162,7 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 			struct extent_buffer *parent);
 void btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info, u64 start, u64 end);
 int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
-			 u64 num_bytes, u64 *actual_bytes);
+			 u64 num_bytes, u64 *actual_bytes, bool do_remap);
 int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range);
 int btrfs_handle_fully_remapped_bgs(struct btrfs_trans_handle *trans);
 
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index ec9a97d75d10..91670d0af179 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3675,7 +3675,7 @@ static int do_trimming(struct btrfs_block_group *block_group,
 	spin_unlock(&block_group->lock);
 	spin_unlock(&space_info->lock);
 
-	ret = btrfs_discard_extent(fs_info, start, bytes, &trimmed);
+	ret = btrfs_discard_extent(fs_info, start, bytes, &trimmed, false);
 	if (!ret) {
 		*total_trimmed += trimmed;
 		trim_state = BTRFS_TRIM_STATE_TRIMMED;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 79732756b87f..b31f6f1d53b0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3305,7 +3305,7 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 				btrfs_discard_extent(fs_info,
 						ordered_extent->disk_bytenr,
 						ordered_extent->disk_num_bytes,
-						NULL);
+						NULL, true);
 			btrfs_free_reserved_extent(fs_info,
 					ordered_extent->disk_bytenr,
 					ordered_extent->disk_num_bytes, true);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index cda94c6f5239..76c521485542 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3472,7 +3472,8 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset,
 	 * filesystem's point of view.
 	 */
 	if (btrfs_is_zoned(fs_info)) {
-		ret = btrfs_discard_extent(fs_info, chunk_offset, length, NULL);
+		ret = btrfs_discard_extent(fs_info, chunk_offset, length, NULL,
+					   true);
 		if (ret)
 			btrfs_info(fs_info,
 				"failed to reset zone %llu after relocation",
@@ -6112,7 +6113,7 @@ void btrfs_put_bioc(struct btrfs_io_context *bioc)
  */
 struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 					       u64 logical, u64 *length_ret,
-					       u32 *num_stripes)
+					       u32 *num_stripes, bool do_remap)
 {
 	struct btrfs_chunk_map *map;
 	struct btrfs_discard_stripe *stripes;
@@ -6136,6 +6137,25 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
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
index 0c64cae59f1c..ce8751c1b06a 100644
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
2.49.1


