Return-Path: <linux-btrfs+bounces-13266-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE738A97CF5
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 04:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79813BFF22
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 02:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B97264613;
	Wed, 23 Apr 2025 02:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ntreyGVF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4486264638
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 02:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745376270; cv=none; b=Dt9fMIlrRH82TpY4lYyfELgv1FeyKaolaNYqKyRiyvnyRAV7lX/BVDl4Fk3WX4Mn/ualOMHukPBh1kDyW6FqdgBnv+D0SeA2Oi4syKL0dkaCTrk6lwSh5gqSOKsPz6vnwrqJ0SWMFaeICITnPM8cgVYRMTpJWjmCohww0f8CYzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745376270; c=relaxed/simple;
	bh=KzWXp3zjYJQRLGpU9lroKtZGVyAZ1r6K8Q9/JCqJKtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxlXSLLrcn4bqV6fo9+P8JXXwfaRN4Ms+faC4b/NCfERTFzsimKvRaOg7fw/6S0Yub0ezDV5lT0YxeLZK9xczR+wBD8VN9d9TKk3ISKnkXKoCCShzH0+YBpEPRPM3VHjC3oXy8l+/E64sMNu9MYpDhFxs3Se9X3gW5j55Br2pLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ntreyGVF; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745376268; x=1776912268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KzWXp3zjYJQRLGpU9lroKtZGVyAZ1r6K8Q9/JCqJKtM=;
  b=ntreyGVF5/nj7v0Ran1t7HS7IwXAmgzEyJE1OjWirJW6K1NTG6Q5ZoRv
   FTANBhZgcxYeS8A1J22ux3+Ck/0c+qo86WFmxTXqchlC7SCq9lnlLO0to
   v8zvy/bc3pXAPs//TbvE1QcoTBIkAw1SXNW9niFPDhpaTEuHsnSam3LqO
   bIs5+IlyuPdMw5Rp8qFpiq80wLa7/xaB8QeO7icy4Eup5eR9nwZ2owKe/
   eFKcuMbzVM/SB61BC01LW5W0iIFVxZ80cUZEE20vdRTxAmr4E/mxLKmU6
   zWofstzJ7/XiL60kc4S6Onj9sSo1vNxbhElJfysgZdbeOBjqE0zBg/MLO
   w==;
X-CSE-ConnectionGUID: PrU3vdrNR3+9X62/fjth8w==
X-CSE-MsgGUID: qxfihLGgTsql3I0gBN48xA==
X-IronPort-AV: E=Sophos;i="6.15,232,1739808000"; 
   d="scan'208";a="83011848"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2025 10:44:24 +0800
IronPort-SDR: 680845ef_SoJePHbjZMd+1IoJOH+/9jrc4zGcs9oNLae/Npdmo3k+dsf
 aikb+bCl3qa6dILIqIphyP6iERhosZjPF2nF0QQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2025 18:44:16 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon..) ([10.224.173.39])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Apr 2025 19:44:24 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 10/13] btrfs: tweak extent/chunk allocation for space_info sub-space
Date: Wed, 23 Apr 2025 11:43:50 +0900
Message-ID: <e328fbda75c035bd3216950c3df407e4f1d311d7.1745375070.git.naohiro.aota@wdc.com>
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

Make the extent allocator and the chunk allocator aware of the sub-space.
It now uses BTRFS_SUB_GROUP_DATA_RELOC sub-space for data relocation block
group, and uses BTRFS_SUB_GROUP_TREELOG for metadata tree-log block group.

And, it needs to check the space_info is the right one when a block group
candidate is given. Also, new block group should now belong to the
specified one.

Now that, block_group->space_info is always set before
btrfs_add_bg_to_space_info(), we no longer need to "find" the space_info.
So, rename the variable name to address that as well.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c |  3 +++
 fs/btrfs/extent-tree.c | 14 +++++++++++++-
 fs/btrfs/space-info.c  | 32 +++++++++++++++-----------------
 3 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e2b376d19299..74d8ecfb599b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2371,6 +2371,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	cache->commit_used = cache->used;
 	cache->flags = btrfs_stack_block_group_flags(bgi);
 	cache->global_root_id = btrfs_stack_block_group_chunk_objectid(bgi);
+	cache->space_info = btrfs_find_space_info(info, cache->flags);
 
 	set_free_space_tree_thresholds(cache);
 
@@ -2449,6 +2450,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		btrfs_remove_free_space_cache(cache);
 		goto error;
 	}
+
 	trace_btrfs_add_block_group(info, cache, 0);
 	btrfs_add_bg_to_space_info(info, cache);
 
@@ -2493,6 +2495,7 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
 		bg->cached = BTRFS_CACHE_FINISHED;
 		bg->used = map->chunk_len;
 		bg->flags = map->type;
+		bg->space_info = btrfs_find_space_info(fs_info, bg->flags);
 		ret = btrfs_add_block_group_cache(bg);
 		/*
 		 * We may have some valid block group cache added already, in
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1762918dd9a1..b920efbc9cfa 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4380,8 +4380,19 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	trace_btrfs_find_free_extent(root, ffe_ctl);
 
 	space_info = btrfs_find_space_info(fs_info, ffe_ctl->flags);
+	if (btrfs_is_zoned(fs_info) && space_info) {
+		/* Use dedicated sub-space_info for dedicated block group users. */
+		if (ffe_ctl->for_data_reloc) {
+			space_info = space_info->sub_group[0];
+			ASSERT(space_info->subgroup_id == BTRFS_SUB_GROUP_DATA_RELOC);
+		} else if (ffe_ctl->for_treelog) {
+			space_info = space_info->sub_group[0];
+			ASSERT(space_info->subgroup_id == BTRFS_SUB_GROUP_TREELOG);
+		}
+	}
 	if (!space_info) {
-		btrfs_err(fs_info, "No space info for %llu", ffe_ctl->flags);
+		btrfs_err(fs_info, "No space info for %llu, tree-log %d, relocation %d",
+			  ffe_ctl->flags, ffe_ctl->for_treelog, ffe_ctl->for_data_reloc);
 		return -ENOSPC;
 	}
 
@@ -4403,6 +4414,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		 * picked out then we don't care that the block group is cached.
 		 */
 		if (block_group && block_group_bits(block_group, ffe_ctl->flags) &&
+		    block_group->space_info == space_info &&
 		    block_group->cached != BTRFS_CACHE_NO) {
 			down_read(&space_info->groups_sem);
 			if (list_empty(&block_group->list) ||
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index a34771cf0870..1205588b6234 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -358,31 +358,29 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
 void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 				struct btrfs_block_group *block_group)
 {
-	struct btrfs_space_info *found;
+	struct btrfs_space_info *space_info = block_group->space_info;
 	int factor, index;
 
 	factor = btrfs_bg_type_to_factor(block_group->flags);
 
-	found = btrfs_find_space_info(info, block_group->flags);
-	ASSERT(found);
-	spin_lock(&found->lock);
-	found->total_bytes += block_group->length;
-	found->disk_total += block_group->length * factor;
-	found->bytes_used += block_group->used;
-	found->disk_used += block_group->used * factor;
-	found->bytes_readonly += block_group->bytes_super;
-	btrfs_space_info_update_bytes_zone_unusable(found, block_group->zone_unusable);
+	spin_lock(&space_info->lock);
+	space_info->total_bytes += block_group->length;
+	space_info->disk_total += block_group->length * factor;
+	space_info->bytes_used += block_group->used;
+	space_info->disk_used += block_group->used * factor;
+	space_info->bytes_readonly += block_group->bytes_super;
+	btrfs_space_info_update_bytes_zone_unusable(space_info, block_group->zone_unusable);
 	if (block_group->length > 0)
-		found->full = 0;
-	btrfs_try_granting_tickets(info, found);
-	spin_unlock(&found->lock);
+		space_info->full = 0;
+	btrfs_try_granting_tickets(info, space_info);
+	spin_unlock(&space_info->lock);
 
-	block_group->space_info = found;
+	block_group->space_info = space_info;
 
 	index = btrfs_bg_flags_to_raid_index(block_group->flags);
-	down_write(&found->groups_sem);
-	list_add_tail(&block_group->list, &found->block_groups[index]);
-	up_write(&found->groups_sem);
+	down_write(&space_info->groups_sem);
+	list_add_tail(&block_group->list, &space_info->block_groups[index]);
+	up_write(&space_info->groups_sem);
 }
 
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
-- 
2.49.0


