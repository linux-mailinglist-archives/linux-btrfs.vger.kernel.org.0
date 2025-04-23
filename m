Return-Path: <linux-btrfs+bounces-13264-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C62A97CF2
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 04:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0483BFDF9
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 02:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE55265633;
	Wed, 23 Apr 2025 02:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Wf9/a5UX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE692264F86
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 02:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745376269; cv=none; b=Cpsr5sBksZD0drLtgF7EQyb3UPt3ko2hP3pZXUj6FMZSjvroqQTSLjQmUnsKeyt8uRffL7w/f61pG7DBtNtRY3wtledBuRehd0seq1oUrheNhzYWD3NcU5GGw6/qL9LI2D0oxxmTDY97d7FWIumyEFQcc6boqZTnb9GeOGCCho4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745376269; c=relaxed/simple;
	bh=LcOnYBJ3leKTOsZnmgksNCp4arAFOVJ5/2S/4/jezPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWoe7mpcEhpltD8GJC7k7719ti9hlolq8rC2wr9BIqfhM+hW6/rmPzRMX2pXU/mtJKc3iiSyjV8s2ncuUVoYr+W0vQGeh/ZpcibZKn2mQZsQRl/k8DRdosOQiyVggQpNrV0NxuQ2HyFSE2GIs4Enx576iEfIU8zyd5taqLiBJJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Wf9/a5UX; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745376267; x=1776912267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LcOnYBJ3leKTOsZnmgksNCp4arAFOVJ5/2S/4/jezPA=;
  b=Wf9/a5UXg9wquaoP+GKNkjcaYBF/wMD94bLbgukTHX+G8ESWBYBb+o6i
   c2mWV35fiUw5SR4aCBVU73NZT7eRg+j1qBWNvZWrBeKZeiYQudalnW+H9
   y+h0qPGd8XQ/ToBtleRIzq3AzeBjLqJGoNpsyWYAwqh0vLVaVPK/iTKWy
   dOBUDZu03ExRL/vjvQbtauxZi/4rS0CiEiNL58mLu3LluBF4YFwwaA0HM
   fXGH1BEBFHUI3dnVLpjFNIbtUWhMOaWMX3zvcKtWzcMSv3Awil2ASGjRW
   nheOERmybRsxtB++AeyWv364KjSFnnetRMIcFj/UeraJD6NORDqenF3fe
   g==;
X-CSE-ConnectionGUID: R87Bqhj2SgOXvcd5/HXDfA==
X-CSE-MsgGUID: er+JsvXeQXi5GuzzoX4JYw==
X-IronPort-AV: E=Sophos;i="6.15,232,1739808000"; 
   d="scan'208";a="83011844"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2025 10:44:22 +0800
IronPort-SDR: 680845ee_YPVZRtxZx9gtho7w4PdPUUdn8KskwWsGi4bxixvtpA7bzAH
 6lU9NQyyc6+SYyndOvnKjE7tmyAr+qX7pp0c/nA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2025 18:44:14 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon..) ([10.224.173.39])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Apr 2025 19:44:22 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 08/13] btrfs: introduce btrfs_space_info sub-group
Date: Wed, 23 Apr 2025 11:43:48 +0900
Message-ID: <1f716cd29f21359ebbae68650279c065888836ef.1745375070.git.naohiro.aota@wdc.com>
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 11 +++++++++++
 fs/btrfs/space-info.c  | 44 +++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/space-info.h  |  8 ++++++++
 fs/btrfs/sysfs.c       | 18 ++++++++++++++---
 4 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 70deb3e8739a..e2b376d19299 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4426,6 +4426,17 @@ static void check_removing_space_info(struct btrfs_space_info *space_info)
 {
 	struct btrfs_fs_info *info = space_info->fs_info;
 
+	if (space_info->subgroup_id == BTRFS_SUB_GROUP_PRIMARY) {
+		/* This is a top space_info, proceed its children first. */
+		for (int i = 0; i < BTRFS_SPACE_INFO_SUB_GROUP_MAX; i++) {
+			if (space_info->sub_group[i]) {
+				check_removing_space_info(space_info->sub_group[i]);
+				kfree(space_info->sub_group[i]);
+				space_info->sub_group[i] = NULL;
+			}
+		}
+	}
+
 	/*
 	 * Do not hide this behind enospc_debug, this is actually
 	 * important and indicates a real bug if this happens.
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 2489c2a16123..e45e9db37497 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -249,16 +249,45 @@ static void init_space_info(struct btrfs_fs_info *info,
 	INIT_LIST_HEAD(&space_info->priority_tickets);
 	space_info->clamp = 1;
 	btrfs_update_space_info_chunk_size(space_info, calc_chunk_size(info, flags));
+	space_info->subgroup_id = BTRFS_SUB_GROUP_PRIMARY;
 
 	if (btrfs_is_zoned(info))
 		space_info->bg_reclaim_threshold = BTRFS_DEFAULT_ZONED_RECLAIM_THRESH;
 }
 
+static int create_space_info_sub_group(struct btrfs_space_info *parent,
+				       u64 flags, enum btrfs_space_info_sub_group id,
+				       int index)
+{
+	struct btrfs_fs_info *fs_info = parent->fs_info;
+	struct btrfs_space_info *sub_group;
+	int ret;
+
+	ASSERT(parent->subgroup_id == BTRFS_SUB_GROUP_PRIMARY);
+	ASSERT(id != BTRFS_SUB_GROUP_PRIMARY);
+
+	sub_group = kzalloc(sizeof(*sub_group), GFP_NOFS);
+	if (!sub_group)
+		return -ENOMEM;
+
+	init_space_info(fs_info, sub_group, flags);
+	parent->sub_group[index] = sub_group;
+	sub_group->parent = parent;
+	sub_group->subgroup_id = id;
+
+	ret = btrfs_sysfs_add_space_info_type(fs_info, sub_group);
+	if (ret) {
+		kfree(sub_group);
+		parent->sub_group[index] = NULL;
+	}
+	return ret;
+}
+
 static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 {
 
 	struct btrfs_space_info *space_info;
-	int ret;
+	int ret = 0;
 
 	space_info = kzalloc(sizeof(*space_info), GFP_NOFS);
 	if (!space_info)
@@ -266,6 +295,14 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 
 	init_space_info(info, space_info, flags);
 
+	if (btrfs_is_zoned(info)) {
+		if (flags & BTRFS_BLOCK_GROUP_DATA)
+			ret = create_space_info_sub_group(space_info, flags,
+							  BTRFS_SUB_GROUP_DATA_RELOC, 0);
+		if (ret)
+			return ret;
+	}
+
 	ret = btrfs_sysfs_add_space_info_type(info, space_info);
 	if (ret)
 		return ret;
@@ -561,8 +598,9 @@ static void __btrfs_dump_space_info(const struct btrfs_fs_info *fs_info,
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
index 7459b4eb99cd..c76929a65475 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -98,8 +98,16 @@ enum btrfs_flush_state {
 	RESET_ZONES		= 12,
 };
 
+enum btrfs_space_info_sub_group {
+	BTRFS_SUB_GROUP_PRIMARY,
+	BTRFS_SUB_GROUP_DATA_RELOC,
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
index b9af74498b0c..4667b388e046 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1930,16 +1930,28 @@ void btrfs_sysfs_remove_space_info(struct btrfs_space_info *space_info)
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
+		ASSERT(space_info->subgroup_id == BTRFS_SUB_GROUP_PRIMARY);
 		return "metadata";
 	case BTRFS_BLOCK_GROUP_DATA:
-		return "data";
+		switch (space_info->subgroup_id) {
+		case BTRFS_SUB_GROUP_PRIMARY:
+			return "data";
+		case BTRFS_SUB_GROUP_DATA_RELOC:
+			return "data-reloc";
+		default:
+			WARN_ON_ONCE(1);
+			return "data (unknown sub-group)";
+		}
 	case BTRFS_BLOCK_GROUP_SYSTEM:
+		ASSERT(space_info->subgroup_id == BTRFS_SUB_GROUP_PRIMARY);
 		return "system";
 	default:
 		WARN_ON(1);
@@ -1958,7 +1970,7 @@ int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
 
 	ret = kobject_init_and_add(&space_info->kobj, &space_info_ktype,
 				   fs_info->space_info_kobj, "%s",
-				   alloc_name(space_info->flags));
+				   alloc_name(space_info));
 	if (ret) {
 		kobject_put(&space_info->kobj);
 		return ret;
-- 
2.49.0


