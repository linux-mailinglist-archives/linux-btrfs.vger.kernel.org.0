Return-Path: <linux-btrfs+bounces-13084-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1080EA9066C
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 16:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8CBF16E3C1
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 14:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA3B1F237B;
	Wed, 16 Apr 2025 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L5HPm2CZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65B91FBE9E
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813721; cv=none; b=g4MpJyA4Mj3wK4lK8fCLVcE8w9SQ60iD0FclRnuIS39rsSNRkBPrgyzI23QDQhCyGXha/lklOFuR/1cmFvgsQ3EQnIR1lKnCC1Wy5SUZhb0UOJTxldYNqR6XNRzA5gbRZwYb0rV5LiZf/Y5DuThQElaQV3MHVCgskeU4bS6w8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813721; c=relaxed/simple;
	bh=Ah7RwYRZb//0D2Luv9yhDNWYDplhTKKZL6LMhDu4iOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F41gub5XDOea1vJQI4NQge6uqBFBrnD/CUgNj+Cy852p755zqf1obivIdSOd8TowDLP2Lerg6biZnO6+v4h0GE019vgYk8Bl6D4S2MZeRrZAtl7K6WpU/VGjh4sY+fgyZ7Vk0JxE9xG+4caOdy6yO2puEboViiDrHRNL9lzi5fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=L5HPm2CZ; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744813719; x=1776349719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ah7RwYRZb//0D2Luv9yhDNWYDplhTKKZL6LMhDu4iOg=;
  b=L5HPm2CZuI4iE3TqpORXBTqnWohdgJJDCv3YBPComOurwYl4OLRhEEWF
   OlEAHZ01BDdkbOtB8shvi6n90uZQPXiMeXZkQZKFaJEiYULxLdB53yIpr
   B10R3oVp4QlH4XDvcmYg+x0EmW3YvDghhr1LxfE6e68YN++12QWtfYRTk
   lEEyY/WWh9snK0fpeC9hwQ6OWvRFJLdXgmg2jgORQ9bEgVV+h87BEM6+l
   vd+iMCLm71zlJg1ftw35skCYLS2y/OWyqTjVE9YGh0mbw7WHVZgYaxYUI
   OvUgpaIXFU5HF0BrxnInewtFK02SVl2VXP92vuhSeMr8aAI9kwJ5XAmKJ
   w==;
X-CSE-ConnectionGUID: wfjXBXVzRyuyFJcQ/c0Ynw==
X-CSE-MsgGUID: ZILgYdHaSPq6s0Woo9iEgQ==
X-IronPort-AV: E=Sophos;i="6.15,216,1739808000"; 
   d="scan'208";a="81484527"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2025 22:28:33 +0800
IronPort-SDR: 67ffb083_7g9kz5hqDS0jHPo0qqYmsuXI8dLH0z3BcEY+/HGw7a+FmwC
 ZkZorj0Om1rGON2AbKXLyEqHVf/+DtFXm9KtgNw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2025 06:28:36 -0700
WDCIronportException: Internal
Received: from 5cg2075gjp.ad.shared (HELO naota-xeon..) ([10.224.104.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2025 07:28:33 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 08/13] btrfs: introduce btrfs_space_info sub-group
Date: Wed, 16 Apr 2025 23:28:13 +0900
Message-ID: <ad0d95fe1fec479076594e78dd8ff489ac0a1e83.1744813603.git.naohiro.aota@wdc.com>
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
 fs/btrfs/block-group.c | 11 +++++++++++
 fs/btrfs/space-info.c  | 38 +++++++++++++++++++++++++++++++++++---
 fs/btrfs/space-info.h  |  8 ++++++++
 fs/btrfs/sysfs.c       | 16 +++++++++++++---
 4 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 846c9737ff5a..475353b0b32c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4411,6 +4411,17 @@ static void check_removing_space_info(struct btrfs_space_info *space_info)
 {
 	struct btrfs_fs_info *info = space_info->fs_info;
 
+	if (space_info->subgroup_id == SUB_GROUP_PRIMARY) {
+		/* This is a top space_info, proceeds its children first. */
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
index 2489c2a16123..37e55298c082 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -249,16 +249,38 @@ static void init_space_info(struct btrfs_fs_info *info,
 	INIT_LIST_HEAD(&space_info->priority_tickets);
 	space_info->clamp = 1;
 	btrfs_update_space_info_chunk_size(space_info, calc_chunk_size(info, flags));
+	space_info->subgroup_id = SUB_GROUP_PRIMARY;
 
 	if (btrfs_is_zoned(info))
 		space_info->bg_reclaim_threshold = BTRFS_DEFAULT_ZONED_RECLAIM_THRESH;
 }
 
+static int create_space_info_sub_group(struct btrfs_space_info *parent, u64 flags,
+				       enum btrfs_space_info_sub_group id)
+{
+	struct btrfs_fs_info *fs_info = parent->fs_info;
+	struct btrfs_space_info *sub_space;
+
+	ASSERT(parent->subgroup_id == SUB_GROUP_PRIMARY);
+	ASSERT(id != SUB_GROUP_PRIMARY);
+
+	sub_space = kzalloc(sizeof(*sub_space), GFP_NOFS);
+	if (!sub_space)
+		return -ENOMEM;
+
+	init_space_info(fs_info, sub_space, flags);
+	parent->sub_group[id] = sub_space;
+	sub_space->parent = parent;
+	sub_space->subgroup_id = id;
+
+	return btrfs_sysfs_add_space_info_type(fs_info, sub_space);
+}
+
 static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 {
 
 	struct btrfs_space_info *space_info;
-	int ret;
+	int ret = 0;
 
 	space_info = kzalloc(sizeof(*space_info), GFP_NOFS);
 	if (!space_info)
@@ -266,6 +288,15 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 
 	init_space_info(info, space_info, flags);
 
+	if (btrfs_is_zoned(info)) {
+		if (flags & BTRFS_BLOCK_GROUP_DATA)
+			ret = create_space_info_sub_group(space_info, flags,
+							  SUB_GROUP_DATA_RELOC);
+		if (ret == -ENOMEM)
+			return ret;
+		ASSERT(!ret);
+	}
+
 	ret = btrfs_sysfs_add_space_info_type(info, space_info);
 	if (ret)
 		return ret;
@@ -561,8 +592,9 @@ static void __btrfs_dump_space_info(const struct btrfs_fs_info *fs_info,
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


