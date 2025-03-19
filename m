Return-Path: <linux-btrfs+bounces-12412-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE14A684F4
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 07:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B392A881A46
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 06:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288992500BF;
	Wed, 19 Mar 2025 06:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VHBTupJT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92F424FBF7
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 06:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364907; cv=none; b=U9VTz5AClSToJRAVJ227IH0CD4Zrc14aJVpTnoBM2gErODwBzmqiz4VZx46OeK1gjeTc8um9qQoSwfpEGgNLWyxYgs8yD+pj3fTXsqPpEsh04Hsl7aR4JxkUWPYM3dE/Rq1Sin6AAl1F0ZDc4sOv0FqgkyoHdT3LowAMihTXQF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364907; c=relaxed/simple;
	bh=u/pHphpihMHnDsLLvXJGABZT5CWOxqEYfKa7zEainC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0hPVAdPhUJ/BalATaYjkgjwxuYX+xlZkC/j3Mt70FRYrT+7jJ1CYDvi/ocIH5P9IWe1F3kn0O5EYEXLfyuIcdL/J4drsSXPmYAv4fFdiOTv0phpa4fkW1QMjyaLW6Mi16AIRg1fSh2NW5W7lMwxNWkrta+FAfcE6sJ5f2ScZEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VHBTupJT; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742364905; x=1773900905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u/pHphpihMHnDsLLvXJGABZT5CWOxqEYfKa7zEainC4=;
  b=VHBTupJTJt2Tw3+CMLpFasiZ09xzwz778ercoBshJrWswWfKrKJR4GGZ
   l39hibeOYh4rTE46Oxf5Zb1gO3AIxPdA8M5HNXx55XlnDOnhKLUJwzuJQ
   l6pJLUT441CO8BrH0H2UGj6f1PIIK3j8JBAXVOZMDdwx+f3PM7nNBEBC7
   He6hUS8leUt1k8g0LLCQ3dZjwAfijFV3KB3I6poOh4kAqjS+klQMQMgGE
   ckaPRGLz8qx2uMd1mdaOAnsOzjKcUMStAkfzxtilnDPffB0I/WNxodjdy
   WDmiR6Bnog99lVBMeeWnlYi1QOR5GEwnSb3Z/aFxJHr2fB61OMIPegyQ2
   A==;
X-CSE-ConnectionGUID: mbBSbsS1Tr21UPK5UKx+hA==
X-CSE-MsgGUID: oMU0n4aLTDmPWksDLd7I+g==
X-IronPort-AV: E=Sophos;i="6.14,258,1736784000"; 
   d="scan'208";a="55227257"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2025 14:15:05 +0800
IronPort-SDR: 67da5309_KWlWap+kzo809+k1Nv/W2fbvGYeu5fwB/OIMtV5umaYsiKG
 ZsSEPnN2fSZJ88GMRgiXQ732gwp/eOCTroHk4+w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2025 22:15:54 -0700
WDCIronportException: Internal
Received: from gbdn3z2.ad.shared (HELO naota-xeon..) ([10.224.109.136])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Mar 2025 23:15:04 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 08/13] btrfs: introduce btrfs_space_info sub-group
Date: Wed, 19 Mar 2025 15:14:39 +0900
Message-ID: <355f307dca7ea6da7db20038d46b3ef7a2cedd4f.1742364593.git.naohiro.aota@wdc.com>
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

Current code assumes we have only one space_info for each block group type
(DATA, METADATA, and SYSTEM). We sometime needs multiple space_info to
manage special block groups.

One example is handling the data relocation block group for the zoned mode.
That block group is dedicated for writing relocated data and we cannot
allocate any regular extent from that block group, which is implemented in
the zoned extent allocator. That block group still belongs to the normal
data space_info. So, when all the normal data block groups are full and
there are some free space in the dedicated block group, the space_info
looks to have some free space, while it cannot allocate normal extent
anymore. That results in a strange ENOSPC error. We need to have a
space_info for the relocation data block group to represent the situation
properly.

This commit adds a basic infrastructure for having a "sub-group" of a
space_info: creation and removing. A sub-group space_info belongs to one of
the primary space_infos and has the same flags as its parent.

This commit first introduces the relocation data sub-space_info, and the
next commit will introduce tree-log sub-space_info. In the future, it could
be useful to implement tiered storage for btrfs e.g, by implementing a
sub-group space_info for block groups resides on a fast storage.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |  6 ++++++
 fs/btrfs/space-info.c  | 22 ++++++++++++++++++++--
 fs/btrfs/space-info.h  |  8 ++++++++
 fs/btrfs/sysfs.c       | 16 +++++++++++++---
 4 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 56c3aa0e7fe2..f5f0485d37b6 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4537,6 +4537,12 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 					struct btrfs_space_info,
 					list);
 
+		for (int i = 0; i < BTRFS_SPACE_INFO_SUB_GROUP_MAX; i++) {
+			if (space_info->sub_group[i]) {
+				check_removing_space_info(space_info->sub_group[i]);
+				kfree(space_info->sub_group[i]);
+			}
+		}
 		check_removing_space_info(space_info);
 		list_del(&space_info->list);
 		btrfs_sysfs_remove_space_info(space_info);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index c421161f4237..53eea3cd2bf3 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -249,6 +249,7 @@ static void init_space_info(struct btrfs_fs_info *info,
 	INIT_LIST_HEAD(&space_info->priority_tickets);
 	space_info->clamp = 1;
 	btrfs_update_space_info_chunk_size(space_info, calc_chunk_size(info, flags));
+	space_info->subgroup_id = SUB_GROUP_PRIMARY;
 
 	if (btrfs_is_zoned(info))
 		space_info->bg_reclaim_threshold = BTRFS_DEFAULT_ZONED_RECLAIM_THRESH;
@@ -266,6 +267,22 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 
 	init_space_info(info, space_info, flags);
 
+	if (btrfs_is_zoned(info)) {
+		if (flags & BTRFS_BLOCK_GROUP_DATA) {
+			struct btrfs_space_info *reloc = kzalloc(sizeof(*reloc), GFP_NOFS);
+
+			if (!reloc)
+				return -ENOMEM;
+			init_space_info(info, reloc, flags);
+			space_info->sub_group[SUB_GROUP_DATA_RELOC] = reloc;
+			reloc->parent = space_info;
+			reloc->subgroup_id = SUB_GROUP_DATA_RELOC;
+
+			ret = btrfs_sysfs_add_space_info_type(info, reloc);
+			ASSERT(!ret);
+		}
+	}
+
 	ret = btrfs_sysfs_add_space_info_type(info, space_info);
 	if (ret)
 		return ret;
@@ -561,8 +578,9 @@ static void __btrfs_dump_space_info(const struct btrfs_fs_info *fs_info,
 	lockdep_assert_held(&info->lock);
 
 	/* The free space could be negative in case of overcommit */
-	btrfs_info(fs_info, "space_info %s has %lld free, is %sfull",
-		   flag_str,
+	btrfs_info(fs_info,
+		   "space_info %s (sub-group id %d) has %lld free, is %sfull",
+		   flag_str, info->subgroup_id,
 		   (s64)(info->total_bytes - btrfs_space_info_used(info, true)),
 		   info->full ? "" : "not ");
 	btrfs_info(fs_info,
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 7459b4eb99cd..64641885babd 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -98,8 +98,16 @@ enum btrfs_flush_state {
 	RESET_ZONES		= 12,
 };
 
+enum btrfs_space_info_sub_group {
+	SUB_GROUP_DATA_RELOC = 0,
+	SUB_GROUP_PRIMARY = -1,
+};
+#define BTRFS_SPACE_INFO_SUB_GROUP_MAX 1
 struct btrfs_space_info {
 	struct btrfs_fs_info *fs_info;
+	struct btrfs_space_info *parent;
+	struct btrfs_space_info *sub_group[BTRFS_SPACE_INFO_SUB_GROUP_MAX];
+	int subgroup_id;
 	spinlock_t lock;
 
 	u64 total_bytes;	/* total bytes in the space,
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index b9af74498b0c..92caa5d09e2f 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1930,15 +1930,25 @@ void btrfs_sysfs_remove_space_info(struct btrfs_space_info *space_info)
 	kobject_put(&space_info->kobj);
 }
 
-static const char *alloc_name(u64 flags)
+static const char *alloc_name(struct btrfs_space_info *space_info)
 {
+	u64 flags = space_info->flags;
+
 	switch (flags) {
 	case BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA:
 		return "mixed";
 	case BTRFS_BLOCK_GROUP_METADATA:
 		return "metadata";
 	case BTRFS_BLOCK_GROUP_DATA:
-		return "data";
+		switch (space_info->subgroup_id) {
+		case SUB_GROUP_PRIMARY:
+			return "data";
+		case SUB_GROUP_DATA_RELOC:
+			return "data-reloc";
+		default:
+			WARN_ON_ONCE(1);
+			return "data (unknown sub-group)";
+		}
 	case BTRFS_BLOCK_GROUP_SYSTEM:
 		return "system";
 	default:
@@ -1958,7 +1968,7 @@ int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
 
 	ret = kobject_init_and_add(&space_info->kobj, &space_info_ktype,
 				   fs_info->space_info_kobj, "%s",
-				   alloc_name(space_info->flags));
+				   alloc_name(space_info));
 	if (ret) {
 		kobject_put(&space_info->kobj);
 		return ret;
-- 
2.49.0


