Return-Path: <linux-btrfs+bounces-10070-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 492ED9E4EE4
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 08:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D2D1664AF
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 07:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410651C303E;
	Thu,  5 Dec 2024 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Wuphavap"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DD51B4F3E
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Dec 2024 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384966; cv=none; b=oVKUeTZLubRy4Sb/orK5Ruh4QeKUVB5vcVetTmnZJT/LUEhO+u7GKh8RRCbGxddUd6nLjf4NwPrt50Fw+C/cOJgDR5z8ArweM4koYuZIEg2IFE2FjYoGA4HlgQlwLOeKclNb9Egt8Wg5FwOystejWjvo8bl/HdTTIpDWJISI6nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384966; c=relaxed/simple;
	bh=gtpFDF7OxtUFik/G4W4FeP4H7ISC29x/D3mxLbq+w1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjx5YOYmReGJk7ob7WPDZsyczMG722sV3phmWUrkLtw/OFShUmiyiFH9WgWgJnHZU2TgStSvZ905Swd8C4q7phLBvYNY7ApKhale+r0vuB90S5a/6yoPUx9zmlnVt4Wy3q9CM/ABuy+JnBgKZj5eEnCX63a2ePB2mzOShyR4/tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Wuphavap; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733384964; x=1764920964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gtpFDF7OxtUFik/G4W4FeP4H7ISC29x/D3mxLbq+w1w=;
  b=Wuphavap197WVl1rfCkkyyiJPlwVaEcCYnTYpcQa/EKGr++hA90pNLbp
   nz18L/z2ANQeONU7PdRz6uEXkj6/EUfOXmdCX/9Fp5UcUc1B3qwzSNgqe
   1EPkbBVGPcCqDu9ib0DjHR0ISS8/OoxwsvK6rLkx2MRSVczsMX4r/B585
   wQ3QKnFX4D8u0HbmJunbsdGBbBjklnq7szdmTbDTAU23mdzZZ3Ge3LhGf
   Axbd/YpMkemjr9hy0bhYYvDyl7cnUqkwkU3MUbzwK70oGEZ4zUPbMtWRk
   K99macYz34GhGwrcDtSMd5aSS8o16f7rbx07ZicHrAhSFmzbDBYhn5Hq/
   g==;
X-CSE-ConnectionGUID: mWlbXwBRSjWItWx5P+/zDg==
X-CSE-MsgGUID: HUpFImBWT8OCyQwkrMhGZQ==
X-IronPort-AV: E=Sophos;i="6.12,209,1728921600"; 
   d="scan'208";a="33626113"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2024 15:49:21 +0800
IronPort-SDR: 67514c5c_cvAOFmFyYmFbqX/GtG0VlPG96oSHHJyQXH6WenRqngwmRdn
 VWFxZ3WsKq2thLMOQpe6xJoKFSsDEuYyQzi+BRA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2024 22:46:52 -0800
WDCIronportException: Internal
Received: from naota-x1.dhcp.fujisawa.hgst.com (HELO naota-x1.ad.shared) ([10.89.81.175])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2024 23:49:21 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 07/11] btrfs: pass space_info for block group creation
Date: Thu,  5 Dec 2024 16:48:23 +0900
Message-ID: <127cf9ae217dd4ac2ce651317fccf6923dd765a9.1733384171.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733384171.git.naohiro.aota@wdc.com>
References: <cover.1733384171.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add btrfs_space_info parameter to btrfs_make_block_group(), its related
functions and related struct. Passed space_info will have a new block group. If
NULL is passed, it uses the default space_info.

The parameter is used in a later commit and the behavior is unchanged now.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 15 ++++++++-------
 fs/btrfs/block-group.h |  2 +-
 fs/btrfs/volumes.c     | 16 +++++++++++-----
 fs/btrfs/volumes.h     |  2 +-
 4 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index ad78c8f1d381..6787f7034b9e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2833,7 +2833,7 @@ static u64 calculate_global_root_id(const struct btrfs_fs_info *fs_info, u64 off
 }
 
 struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *trans,
-						 u64 type,
+						 struct btrfs_space_info *space_info, u64 type,
 						 u64 chunk_offset, u64 size)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -2888,7 +2888,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	 * assigned to our block group. We want our bg to be added to the rbtree
 	 * with its ->space_info set.
 	 */
-	cache->space_info = btrfs_find_space_info(fs_info, cache->flags);
+	cache->space_info = space_info;
 	ASSERT(cache->space_info);
 
 	ret = btrfs_add_block_group_cache(fs_info, cache);
@@ -3873,7 +3873,8 @@ int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type)
 	return btrfs_chunk_alloc(trans, NULL, alloc_flags, CHUNK_ALLOC_FORCE);
 }
 
-static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
+static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans,
+						struct btrfs_space_info *space_info, u64 flags)
 {
 	struct btrfs_block_group *bg;
 	int ret;
@@ -3886,7 +3887,7 @@ static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans
 	 */
 	check_system_chunk(trans, flags);
 
-	bg = btrfs_create_chunk(trans, flags);
+	bg = btrfs_create_chunk(trans, space_info, flags);
 	if (IS_ERR(bg)) {
 		ret = PTR_ERR(bg);
 		goto out;
@@ -3935,7 +3936,7 @@ static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans
 		const u64 sys_flags = btrfs_system_alloc_profile(trans->fs_info);
 		struct btrfs_block_group *sys_bg;
 
-		sys_bg = btrfs_create_chunk(trans, sys_flags);
+		sys_bg = btrfs_create_chunk(trans, NULL, sys_flags);
 		if (IS_ERR(sys_bg)) {
 			ret = PTR_ERR(sys_bg);
 			btrfs_abort_transaction(trans, ret);
@@ -4185,7 +4186,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
 			force_metadata_allocation(fs_info);
 	}
 
-	ret_bg = do_chunk_alloc(trans, flags);
+	ret_bg = do_chunk_alloc(trans, space_info, flags);
 	trans->allocating_chunk = false;
 
 	if (IS_ERR(ret_bg)) {
@@ -4268,7 +4269,7 @@ static void reserve_chunk_space(struct btrfs_trans_handle *trans,
 		 * the paths we visit in the chunk tree (they were already COWed
 		 * or created in the current transaction for example).
 		 */
-		bg = btrfs_create_chunk(trans, flags);
+		bg = btrfs_create_chunk(trans, NULL, flags);
 		if (IS_ERR(bg)) {
 			ret = PTR_ERR(bg);
 		} else {
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index c01f3af726a1..cb9b0405172c 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -326,7 +326,7 @@ void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info);
 void btrfs_mark_bg_to_reclaim(struct btrfs_block_group *bg);
 int btrfs_read_block_groups(struct btrfs_fs_info *info);
 struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *trans,
-						 u64 type,
+						 struct btrfs_space_info *space_info, u64 type,
 						 u64 chunk_offset, u64 size);
 void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans);
 int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1cccaf9c2b0d..d1f3068377aa 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3403,7 +3403,7 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 		const u64 sys_flags = btrfs_system_alloc_profile(fs_info);
 		struct btrfs_block_group *sys_bg;
 
-		sys_bg = btrfs_create_chunk(trans, sys_flags);
+		sys_bg = btrfs_create_chunk(trans, NULL, sys_flags);
 		if (IS_ERR(sys_bg)) {
 			ret = PTR_ERR(sys_bg);
 			btrfs_abort_transaction(trans, ret);
@@ -5202,6 +5202,8 @@ struct alloc_chunk_ctl {
 	u64 stripe_size;
 	u64 chunk_size;
 	int ndevs;
+	/* Space_info the block group is going to belong. */
+	struct btrfs_space_info *space_info;
 };
 
 static void init_alloc_chunk_ctl_policy_regular(
@@ -5603,7 +5605,7 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 		return ERR_PTR(ret);
 	}
 
-	block_group = btrfs_make_block_group(trans, type, start, ctl->chunk_size);
+	block_group = btrfs_make_block_group(trans, ctl->space_info, type, start, ctl->chunk_size);
 	if (IS_ERR(block_group)) {
 		btrfs_remove_chunk_map(info, map);
 		return block_group;
@@ -5629,7 +5631,7 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 }
 
 struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
-					    u64 type)
+					     struct btrfs_space_info *space_info, u64 type)
 {
 	struct btrfs_fs_info *info = trans->fs_info;
 	struct btrfs_fs_devices *fs_devices = info->fs_devices;
@@ -5657,8 +5659,12 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (!space_info)
+		space_info = btrfs_find_space_info(info, type);
+	ASSERT(space_info);
 	ctl.start = find_next_chunk(info);
 	ctl.type = type;
+	ctl.space_info = space_info;
 	init_alloc_chunk_ctl(fs_devices, &ctl);
 
 	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
@@ -5826,12 +5832,12 @@ static noinline int init_first_rw_device(struct btrfs_trans_handle *trans)
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
index 3a416b1bc24c..2faee2d2e584 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -690,7 +690,7 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 int btrfs_read_sys_array(struct btrfs_fs_info *fs_info);
 int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
 struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
-					    u64 type);
+					     struct btrfs_space_info *space_info, u64 type);
 void btrfs_mapping_tree_free(struct btrfs_fs_info *fs_info);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       blk_mode_t flags, void *holder);
-- 
2.47.1


