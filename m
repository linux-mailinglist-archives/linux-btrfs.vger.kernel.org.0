Return-Path: <linux-btrfs+bounces-12411-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747A7A684F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 07:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F87882438
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 06:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C60924EF71;
	Wed, 19 Mar 2025 06:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Fhc5dXH4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1298C24EA9D
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 06:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364906; cv=none; b=j43e/vTslYW56FkIGlN9WIvdGNni8+Op+QaxrA/k6l/ddoXdJwId5IpOXCGNNKKAm9deLbYS9oST6O2XdOAhSHEvfMWwvIy7neEf8hWZLLNo/g4Aw6Amk1zK2Q4Ef59dMKY+TF90a6N/YVpJvd4AYLIxru8n5QEB/TcvDszM4cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364906; c=relaxed/simple;
	bh=Tst1uPTMFAxmau1w4KlkVEO0zo28e4/zcFF7sjMzuXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LoY9+v/j3EfiVMfXw4mwlP+RzwLTmQ00L4YUqI3uT4zsmFlZvD4pYZ7+TVh8SZSSfDzG8oQSmdc3fK4vyN+fUtavBorPdTcCT5LZ3aFs5Lyx6ZZdUGdQ/4YK5wa4n+Ty9ynR+Ware68vnVVbx46tiAHmX4wuOtcCMnfUacn4heI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Fhc5dXH4; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742364904; x=1773900904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tst1uPTMFAxmau1w4KlkVEO0zo28e4/zcFF7sjMzuXs=;
  b=Fhc5dXH4nv7ukh268s+KKpjlga9CfO3UW24MXNtLoGC4F3uxMxYH9bCQ
   5I1nKOWS1L/l20KKBa2NAuL0wmvztzdQgp7KTH/uqwTdOq2102sIdnhvv
   5pQJ4atBe6OkdaMd26oCu9YOdXmBdRcd/mIAK2GKU6rKRKjB0ICESM23o
   r4MOm2IlctcgWbPgv5ReeS6vjiH9WxkgrMB1uxWXHRm6ggTjUbGiXJhLc
   ewJlfmgnaruM1iF5bHIyyjHLlnTCaVeorFgay8Xo1rMfwkRqbydpSVXBC
   WOg/4N1X8YDS5nbZSH43RpDMX8zpCfccrrK3IZjvSeYi9mXxjfgcz19C6
   w==;
X-CSE-ConnectionGUID: t9QFPxsZQ1Co/6YqxiUqrA==
X-CSE-MsgGUID: GfEMESaWRPCOPa20Qqa/2A==
X-IronPort-AV: E=Sophos;i="6.14,258,1736784000"; 
   d="scan'208";a="55227255"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2025 14:15:04 +0800
IronPort-SDR: 67da5308_935c9B+JuRcAQULB5VCHWKnYWN7botfGTYNBOsVwejzExUk
 etWBIkFatP1O+07hdl2lW/UX0MvXZla5BrvuH8Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2025 22:15:53 -0700
WDCIronportException: Internal
Received: from gbdn3z2.ad.shared (HELO naota-xeon..) ([10.224.109.136])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Mar 2025 23:15:03 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 07/13] btrfs: pass space_info for block group creation
Date: Wed, 19 Mar 2025 15:14:38 +0900
Message-ID: <1c2d3aa8f33d04cae6296d2d10a0688f435ef3a7.1742364593.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1742364593.git.naohiro.aota@wdc.com>
References: <cover.1742364593.git.naohiro.aota@wdc.com>
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
---
 fs/btrfs/block-group.c | 15 ++++++++-------
 fs/btrfs/block-group.h |  2 +-
 fs/btrfs/volumes.c     | 16 +++++++++++-----
 fs/btrfs/volumes.h     |  2 +-
 4 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index fa08d7b67b1f..56c3aa0e7fe2 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2868,7 +2868,7 @@ static u64 calculate_global_root_id(const struct btrfs_fs_info *fs_info, u64 off
 }
 
 struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *trans,
-						 u64 type,
+						 struct btrfs_space_info *space_info, u64 type,
 						 u64 chunk_offset, u64 size)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -2923,7 +2923,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	 * assigned to our block group. We want our bg to be added to the rbtree
 	 * with its ->space_info set.
 	 */
-	cache->space_info = btrfs_find_space_info(fs_info, cache->flags);
+	cache->space_info = space_info;
 	ASSERT(cache->space_info);
 
 	ret = btrfs_add_block_group_cache(cache);
@@ -3904,7 +3904,8 @@ int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type)
 	return btrfs_chunk_alloc(trans, NULL, alloc_flags, CHUNK_ALLOC_FORCE);
 }
 
-static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
+static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans,
+						struct btrfs_space_info *space_info, u64 flags)
 {
 	struct btrfs_block_group *bg;
 	int ret;
@@ -3917,7 +3918,7 @@ static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans
 	 */
 	check_system_chunk(trans, flags);
 
-	bg = btrfs_create_chunk(trans, flags);
+	bg = btrfs_create_chunk(trans, space_info, flags);
 	if (IS_ERR(bg)) {
 		ret = PTR_ERR(bg);
 		goto out;
@@ -3966,7 +3967,7 @@ static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans
 		const u64 sys_flags = btrfs_system_alloc_profile(trans->fs_info);
 		struct btrfs_block_group *sys_bg;
 
-		sys_bg = btrfs_create_chunk(trans, sys_flags);
+		sys_bg = btrfs_create_chunk(trans, NULL, sys_flags);
 		if (IS_ERR(sys_bg)) {
 			ret = PTR_ERR(sys_bg);
 			btrfs_abort_transaction(trans, ret);
@@ -4216,7 +4217,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
 			force_metadata_allocation(fs_info);
 	}
 
-	ret_bg = do_chunk_alloc(trans, flags);
+	ret_bg = do_chunk_alloc(trans, space_info, flags);
 	trans->allocating_chunk = false;
 
 	if (IS_ERR(ret_bg)) {
@@ -4299,7 +4300,7 @@ static void reserve_chunk_space(struct btrfs_trans_handle *trans,
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
index c8c21c55be53..b070a549a9e4 100644
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
@@ -5618,7 +5620,7 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 		return ERR_PTR(ret);
 	}
 
-	block_group = btrfs_make_block_group(trans, type, start, ctl->chunk_size);
+	block_group = btrfs_make_block_group(trans, ctl->space_info, type, start, ctl->chunk_size);
 	if (IS_ERR(block_group)) {
 		btrfs_remove_chunk_map(info, map);
 		return block_group;
@@ -5644,7 +5646,7 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 }
 
 struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
-					    u64 type)
+					     struct btrfs_space_info *space_info, u64 type)
 {
 	struct btrfs_fs_info *info = trans->fs_info;
 	struct btrfs_fs_devices *fs_devices = info->fs_devices;
@@ -5672,8 +5674,12 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
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
@@ -5841,12 +5847,12 @@ static noinline int init_first_rw_device(struct btrfs_trans_handle *trans)
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
index e247d551da67..8af536078cab 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -715,7 +715,7 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 int btrfs_read_sys_array(struct btrfs_fs_info *fs_info);
 int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
 struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
-					    u64 type);
+					     struct btrfs_space_info *space_info, u64 type);
 void btrfs_mapping_tree_free(struct btrfs_fs_info *fs_info);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       blk_mode_t flags, void *holder);
-- 
2.49.0


