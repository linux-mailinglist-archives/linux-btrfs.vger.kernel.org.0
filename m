Return-Path: <linux-btrfs+bounces-13263-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F59A97CF1
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 04:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4573BFE63
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 02:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9BB2641E8;
	Wed, 23 Apr 2025 02:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MK3wZRCA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D026C264A89
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 02:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745376268; cv=none; b=MSwOxS/afHxMrE+6kb0bWLtYMvijEyXZYAHAIWPt1yKLEKrmtp4QJYaUyV9PSahz+U5YoIxmZWVXYRDDabtptHJjOti5A4CCdN7cNnsNyAYh6UcGmfbbTRVSYXRMFaSN+DN7uB89GZKveCjphsUrogZV4ZlAVrnUSUTe02FjLX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745376268; c=relaxed/simple;
	bh=/LP5elIz0BE4bGxjNjbcHaGCf29i+i3/QUPHaB/6hUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INc0k6bk6ZtCfMHeEDtflyvmfAAteQZvUIVGKw5A9CLNNPYMbUAmsU0nGldOr61HDFZQKQuS3L8eubUTJKkPI5/M9/AirAfwoH1uN0I2XnE86OqoCH/1SK57oGmCk2xgYj+eVoWpJlXyUOlAWhnRnONDGWi+WJs7k+e4I8QN5R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MK3wZRCA; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745376266; x=1776912266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/LP5elIz0BE4bGxjNjbcHaGCf29i+i3/QUPHaB/6hUA=;
  b=MK3wZRCAFhwrp6frEuL0Ql1B/iBY0ICdLQF8XJiRerY+SjXJ+unR9qsc
   QQUd+Wa73JG/5afkO/PIh9enVGo6Iwgb+BC7f2evNPfE1C8Vg8bWht/rl
   TL4sa4RIdV+BnmasTXBj3N63Nk90gLdP0MGdszS/xVEPS7qW6WGIMYfUh
   0nkGftt/UJl7U4skL4fYPTY4EhAU74yBo9BWxl2rYZJt6fSxSL5grhEu6
   XWCSz8fCntkbYPw9wXDC3lOuY8bgaS87jpP2OtzuHYWfDUUw9HkPvgo02
   nb8KCkSDfoGMtSW0in//GpSXz6ho4fu5FPce/WvA5aDDkCO8Qwr1JiKMm
   g==;
X-CSE-ConnectionGUID: EaOpDt08RnO57tg3BBed8w==
X-CSE-MsgGUID: 0J5XQrEuRDWVy8thF101YQ==
X-IronPort-AV: E=Sophos;i="6.15,232,1739808000"; 
   d="scan'208";a="83011842"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2025 10:44:21 +0800
IronPort-SDR: 680845ed_wTscqZgGFlgDdHJ5eQzniXPCLwTSlnDTkUUQcPVH/lTnvIm
 9f47OGPUZi23smcglBqh9Ol1vdRYzNp+2vmTQDQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2025 18:44:13 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon..) ([10.224.173.39])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Apr 2025 19:44:21 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v4 07/13] btrfs: pass space_info for block group creation
Date: Wed, 23 Apr 2025 11:43:47 +0900
Message-ID: <dbaa3da48f50634bb03a5aaac8df4103e82cb944.1745375070.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745375070.git.naohiro.aota@wdc.com>
References: <cover.1745375070.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add btrfs_space_info parameter to btrfs_make_block_group(), its related
functions and related struct. Passed space_info will have a new block
group.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 31 +++++++++++++++++++++++--------
 fs/btrfs/block-group.h |  4 ++--
 fs/btrfs/volumes.c     | 36 +++++++++++++++++++++++++++++++-----
 fs/btrfs/volumes.h     |  3 ++-
 4 files changed, 58 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index ab5fc5b40f04..70deb3e8739a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2866,8 +2866,8 @@ static u64 calculate_global_root_id(const struct btrfs_fs_info *fs_info, u64 off
 }
 
 struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *trans,
-						 u64 type,
-						 u64 chunk_offset, u64 size)
+						 struct btrfs_space_info *space_info,
+						 u64 type, u64 chunk_offset, u64 size)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_block_group *cache;
@@ -2921,7 +2921,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	 * assigned to our block group. We want our bg to be added to the rbtree
 	 * with its ->space_info set.
 	 */
-	cache->space_info = btrfs_find_space_info(fs_info, cache->flags);
+	cache->space_info = space_info;
 	ASSERT(cache->space_info);
 
 	ret = btrfs_add_block_group_cache(cache);
@@ -3910,7 +3910,9 @@ int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type)
 	return btrfs_chunk_alloc(trans, space_info, alloc_flags, CHUNK_ALLOC_FORCE);
 }
 
-static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
+static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans,
+						struct btrfs_space_info *space_info,
+						u64 flags)
 {
 	struct btrfs_block_group *bg;
 	int ret;
@@ -3923,7 +3925,7 @@ static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans
 	 */
 	check_system_chunk(trans, flags);
 
-	bg = btrfs_create_chunk(trans, flags);
+	bg = btrfs_create_chunk(trans, space_info, flags);
 	if (IS_ERR(bg)) {
 		ret = PTR_ERR(bg);
 		goto out;
@@ -3971,8 +3973,17 @@ static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans
 	if (ret == -ENOSPC) {
 		const u64 sys_flags = btrfs_system_alloc_profile(trans->fs_info);
 		struct btrfs_block_group *sys_bg;
+		struct btrfs_space_info *sys_space_info;
 
-		sys_bg = btrfs_create_chunk(trans, sys_flags);
+		sys_space_info = btrfs_find_space_info(trans->fs_info, sys_flags);
+		if (!sys_space_info) {
+			ASSERT(0);
+			ret = -EINVAL;
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
+
+		sys_bg = btrfs_create_chunk(trans, sys_space_info, sys_flags);
 		if (IS_ERR(sys_bg)) {
 			ret = PTR_ERR(sys_bg);
 			btrfs_abort_transaction(trans, ret);
@@ -4216,7 +4227,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
 			force_metadata_allocation(fs_info);
 	}
 
-	ret_bg = do_chunk_alloc(trans, flags);
+	ret_bg = do_chunk_alloc(trans, space_info, flags);
 	trans->allocating_chunk = false;
 
 	if (IS_ERR(ret_bg)) {
@@ -4292,6 +4303,10 @@ static void reserve_chunk_space(struct btrfs_trans_handle *trans,
 	if (left < bytes) {
 		u64 flags = btrfs_system_alloc_profile(fs_info);
 		struct btrfs_block_group *bg;
+		struct btrfs_space_info *space_info;
+
+		space_info = btrfs_find_space_info(fs_info, flags);
+		ASSERT(space_info);
 
 		/*
 		 * Ignore failure to create system chunk. We might end up not
@@ -4299,7 +4314,7 @@ static void reserve_chunk_space(struct btrfs_trans_handle *trans,
 		 * the paths we visit in the chunk tree (they were already COWed
 		 * or created in the current transaction for example).
 		 */
-		bg = btrfs_create_chunk(trans, flags);
+		bg = btrfs_create_chunk(trans, space_info, flags);
 		if (IS_ERR(bg)) {
 			ret = PTR_ERR(bg);
 		} else {
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index c01f3af726a1..35309b690d6f 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -326,8 +326,8 @@ void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info);
 void btrfs_mark_bg_to_reclaim(struct btrfs_block_group *bg);
 int btrfs_read_block_groups(struct btrfs_fs_info *info);
 struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *trans,
-						 u64 type,
-						 u64 chunk_offset, u64 size);
+						 struct btrfs_space_info *space_info,
+						 u64 type, u64 chunk_offset, u64 size);
 void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans);
 int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 			     bool do_chunk_alloc);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index dbbed3f4f88a..18474d93601a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3423,8 +3423,17 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 	if (ret == -ENOSPC) {
 		const u64 sys_flags = btrfs_system_alloc_profile(fs_info);
 		struct btrfs_block_group *sys_bg;
+		struct btrfs_space_info *space_info;
 
-		sys_bg = btrfs_create_chunk(trans, sys_flags);
+		space_info = btrfs_find_space_info(fs_info, sys_flags);
+		if (!space_info) {
+			ASSERT(0);
+			ret = -EINVAL;
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
+
+		sys_bg = btrfs_create_chunk(trans, space_info, sys_flags);
 		if (IS_ERR(sys_bg)) {
 			ret = PTR_ERR(sys_bg);
 			btrfs_abort_transaction(trans, ret);
@@ -5221,6 +5230,8 @@ struct alloc_chunk_ctl {
 	u64 stripe_size;
 	u64 chunk_size;
 	int ndevs;
+	/* Space_info the block group is going to belong. */
+	struct btrfs_space_info *space_info;
 };
 
 static void init_alloc_chunk_ctl_policy_regular(
@@ -5626,7 +5637,8 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 		return ERR_PTR(ret);
 	}
 
-	block_group = btrfs_make_block_group(trans, type, start, ctl->chunk_size);
+	block_group = btrfs_make_block_group(trans, ctl->space_info, type, start,
+					     ctl->chunk_size);
 	if (IS_ERR(block_group)) {
 		btrfs_remove_chunk_map(info, map);
 		return block_group;
@@ -5652,7 +5664,8 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 }
 
 struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
-					    u64 type)
+					     struct btrfs_space_info *space_info,
+					     u64 type)
 {
 	struct btrfs_fs_info *info = trans->fs_info;
 	struct btrfs_fs_devices *fs_devices = info->fs_devices;
@@ -5682,6 +5695,7 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 
 	ctl.start = find_next_chunk(info);
 	ctl.type = type;
+	ctl.space_info = space_info;
 	init_alloc_chunk_ctl(fs_devices, &ctl);
 
 	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
@@ -5825,7 +5839,9 @@ static noinline int init_first_rw_device(struct btrfs_trans_handle *trans)
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	u64 alloc_profile;
 	struct btrfs_block_group *meta_bg;
+	struct btrfs_space_info *meta_space_info;
 	struct btrfs_block_group *sys_bg;
+	struct btrfs_space_info *sys_space_info;
 
 	/*
 	 * When adding a new device for sprouting, the seed device is read-only
@@ -5849,12 +5865,22 @@ static noinline int init_first_rw_device(struct btrfs_trans_handle *trans)
 	 */
 
 	alloc_profile = btrfs_metadata_alloc_profile(fs_info);
-	meta_bg = btrfs_create_chunk(trans, alloc_profile);
+	meta_space_info = btrfs_find_space_info(fs_info, alloc_profile);
+	if (!meta_space_info) {
+		ASSERT(0);
+		return -EINVAL;
+	}
+	meta_bg = btrfs_create_chunk(trans, meta_space_info, alloc_profile);
 	if (IS_ERR(meta_bg))
 		return PTR_ERR(meta_bg);
 
 	alloc_profile = btrfs_system_alloc_profile(fs_info);
-	sys_bg = btrfs_create_chunk(trans, alloc_profile);
+	sys_space_info = btrfs_find_space_info(fs_info, alloc_profile);
+	if (!sys_space_info) {
+		ASSERT(0);
+		return -EINVAL;
+	}
+	sys_bg = btrfs_create_chunk(trans, sys_space_info, alloc_profile);
 	if (IS_ERR(sys_bg))
 		return PTR_ERR(sys_bg);
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index e247d551da67..7f314a4487c4 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -715,7 +715,8 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 int btrfs_read_sys_array(struct btrfs_fs_info *fs_info);
 int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
 struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
-					    u64 type);
+					     struct btrfs_space_info *space_info,
+					     u64 type);
 void btrfs_mapping_tree_free(struct btrfs_fs_info *fs_info);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       blk_mode_t flags, void *holder);
-- 
2.49.0


