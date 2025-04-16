Return-Path: <linux-btrfs+bounces-13083-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B17FA9066A
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 16:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434E01671B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 14:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B64A1F1526;
	Wed, 16 Apr 2025 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DUZh4VWm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F881DDA31
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813720; cv=none; b=XDQM7JtEB4fiFTUHc5KLqDNRvDs8hFyb8a394yGdiK6nbAbccb7Kd3VNMUTlck3eq4v5GJVp7i96xX/96hZ/p9rYOvxOXRzoAsR0iE1ubmPFGjqqW5a9oLZFBNYAt3xso1ozN6UkNCsoATcdjgjk9/nVyYR3RfRbdiLC2/Ugff0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813720; c=relaxed/simple;
	bh=Tmc1LwVB3pe8siIgy8JHC7uNrskHVxa6NlsYmWRncgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDh8J7BuNQ5gA+Ito7m8uFNMHIV3Pl54nee/h3X2OcL/iVvXdcHbgWJBlRu8FAj+ljwMJkvfdigYpLh1bolOCzhk3FqCLlcFS2lxCWZP54G3LRoUXdiJIH8fhdgEYno8JCzz87vJ/ovXGwVgvvw4oFZp+kuRq9Q2yYwXJW7JgM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DUZh4VWm; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744813718; x=1776349718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tmc1LwVB3pe8siIgy8JHC7uNrskHVxa6NlsYmWRncgY=;
  b=DUZh4VWmbl+VrvCViEOw50wZOD9SqdWlA2DdqQTQDWW7CS113AjPUTV6
   UKBAChBJODaws6Kb6wk3xWVOpfQXMB6wTo5EMsdCVyaJPZEvui87g4IbO
   ljoluWR2B5sktu5BBDkHarmYpqaSbXNCOgUZqKt6P/vPlT0KgDOpPUiBL
   127kSRT90VEFZEU00yLCujaLKY+7xnJ/lW/030Ud7POeGfEbCWlBt2vM3
   E7Mg94ImNUGrc8pzElwD+DcFhKcSy+Lb4GRkHGr1M5tGB8tlGJJ5wzNx6
   CT1jhn3KGupT0X1uKlrA3wKSvgGD+vjVwemO4r4H6g9LEbpMo5AxGTad+
   g==;
X-CSE-ConnectionGUID: ilQdkMtUTeeL4vu6sKoZvg==
X-CSE-MsgGUID: 9ArL6p4FQ+agcp/zKolhqg==
X-IronPort-AV: E=Sophos;i="6.15,216,1739808000"; 
   d="scan'208";a="81484526"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2025 22:28:32 +0800
IronPort-SDR: 67ffb083_0F13WClwgHeHHhmlkftjqVMG95qV5Flv9g3f1SicohYA6e6
 FCGGfcDWT7+evYoAMe6muYX3hw9MbxGBKyn7NwA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2025 06:28:35 -0700
WDCIronportException: Internal
Received: from 5cg2075gjp.ad.shared (HELO naota-xeon..) ([10.224.104.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2025 07:28:32 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 07/13] btrfs: pass space_info for block group creation
Date: Wed, 16 Apr 2025 23:28:12 +0900
Message-ID: <e9c33853d3095c61b982bfb23bd313d8641d6797.1744813603.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744813603.git.naohiro.aota@wdc.com>
References: <cover.1744813603.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add btrfs_space_info parameter to btrfs_make_block_group(), its related
functions and related struct. Passed space_info will have a new block
group. If NULL is passed, it uses the default space_info.

The parameter is used in a later commit and the behavior is unchanged now.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 18 ++++++++++--------
 fs/btrfs/block-group.h |  4 ++--
 fs/btrfs/volumes.c     | 22 +++++++++++++++++-----
 fs/btrfs/volumes.h     |  3 ++-
 4 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 12cc9069d4bb..846c9737ff5a 100644
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
@@ -3902,7 +3902,9 @@ int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type)
 	return btrfs_chunk_alloc(trans, NULL, alloc_flags, CHUNK_ALLOC_FORCE);
 }
 
-static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
+static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans,
+						struct btrfs_space_info *space_info,
+						u64 flags)
 {
 	struct btrfs_block_group *bg;
 	int ret;
@@ -3915,7 +3917,7 @@ static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans
 	 */
 	check_system_chunk(trans, flags);
 
-	bg = btrfs_create_chunk(trans, flags);
+	bg = btrfs_create_chunk(trans, space_info, flags);
 	if (IS_ERR(bg)) {
 		ret = PTR_ERR(bg);
 		goto out;
@@ -3964,7 +3966,7 @@ static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans
 		const u64 sys_flags = btrfs_system_alloc_profile(trans->fs_info);
 		struct btrfs_block_group *sys_bg;
 
-		sys_bg = btrfs_create_chunk(trans, sys_flags);
+		sys_bg = btrfs_create_chunk(trans, NULL, sys_flags);
 		if (IS_ERR(sys_bg)) {
 			ret = PTR_ERR(sys_bg);
 			btrfs_abort_transaction(trans, ret);
@@ -4214,7 +4216,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
 			force_metadata_allocation(fs_info);
 	}
 
-	ret_bg = do_chunk_alloc(trans, flags);
+	ret_bg = do_chunk_alloc(trans, space_info, flags);
 	trans->allocating_chunk = false;
 
 	if (IS_ERR(ret_bg)) {
@@ -4297,7 +4299,7 @@ static void reserve_chunk_space(struct btrfs_trans_handle *trans,
 		 * the paths we visit in the chunk tree (they were already COWed
 		 * or created in the current transaction for example).
 		 */
-		bg = btrfs_create_chunk(trans, flags);
+		bg = btrfs_create_chunk(trans, NULL, flags);
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
index 7509cbe3272c..5462c832ea19 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3420,7 +3420,7 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 		const u64 sys_flags = btrfs_system_alloc_profile(fs_info);
 		struct btrfs_block_group *sys_bg;
 
-		sys_bg = btrfs_create_chunk(trans, sys_flags);
+		sys_bg = btrfs_create_chunk(trans, NULL, sys_flags);
 		if (IS_ERR(sys_bg)) {
 			ret = PTR_ERR(sys_bg);
 			btrfs_abort_transaction(trans, ret);
@@ -5216,6 +5216,8 @@ struct alloc_chunk_ctl {
 	u64 stripe_size;
 	u64 chunk_size;
 	int ndevs;
+	/* Space_info the block group is going to belong. */
+	struct btrfs_space_info *space_info;
 };
 
 static void init_alloc_chunk_ctl_policy_regular(
@@ -5617,7 +5619,8 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 		return ERR_PTR(ret);
 	}
 
-	block_group = btrfs_make_block_group(trans, type, start, ctl->chunk_size);
+	block_group = btrfs_make_block_group(trans, ctl->space_info, type, start,
+					     ctl->chunk_size);
 	if (IS_ERR(block_group)) {
 		btrfs_remove_chunk_map(info, map);
 		return block_group;
@@ -5643,7 +5646,8 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 }
 
 struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
-					    u64 type)
+					     struct btrfs_space_info *space_info,
+					     u64 type)
 {
 	struct btrfs_fs_info *info = trans->fs_info;
 	struct btrfs_fs_devices *fs_devices = info->fs_devices;
@@ -5671,8 +5675,16 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (!space_info) {
+		space_info = btrfs_find_space_info(info, type);
+		if (!space_info) {
+			ASSERT(0);
+			return ERR_PTR(-EINVAL);
+		}
+	}
 	ctl.start = find_next_chunk(info);
 	ctl.type = type;
+	ctl.space_info = space_info;
 	init_alloc_chunk_ctl(fs_devices, &ctl);
 
 	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
@@ -5840,12 +5852,12 @@ static noinline int init_first_rw_device(struct btrfs_trans_handle *trans)
 	 */
 
 	alloc_profile = btrfs_metadata_alloc_profile(fs_info);
-	meta_bg = btrfs_create_chunk(trans, alloc_profile);
+	meta_bg = btrfs_create_chunk(trans, NULL, alloc_profile);
 	if (IS_ERR(meta_bg))
 		return PTR_ERR(meta_bg);
 
 	alloc_profile = btrfs_system_alloc_profile(fs_info);
-	sys_bg = btrfs_create_chunk(trans, alloc_profile);
+	sys_bg = btrfs_create_chunk(trans, NULL, alloc_profile);
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


