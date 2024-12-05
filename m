Return-Path: <linux-btrfs+bounces-10069-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631819E4EE3
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 08:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52172810FB
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 07:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230A51C243D;
	Thu,  5 Dec 2024 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WGGG/BKC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D831AB517
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Dec 2024 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384966; cv=none; b=g6+NV1+NX6Mr2EZAOMzzBtULRyC94PGP74gvNBDCN+Zxj2GtQ0eCKStR5Kt0RZUv3bCr5IAX1DaL1n8GKpxNsRRi8ONYvFtQmIxn/GyT7SQ2bPb1Ic8TVIXYagb+EJLaYft2Kz0fa9OVNJKLiI1HOdFBH+O243qHVZOLJCoX7KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384966; c=relaxed/simple;
	bh=0W3hrWB/Irav8nhuGzm/DQC/6Ab9jzUquKNv08/4ztk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSO22eiSkdJ6YIC2qUN0jhpi562wfn+MXy8ncpfDCGqBQya2E2GMTk8OK9q5riYTc4jujuJK8JWL6q4sdBhoJXHxxm9JOn5PFixmSFi/FEJB72qprTrpGBlp/i5GxwldPe2tfOPK4kCV/aG/jAQNegONQtJK76rjmsF1klXBsok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WGGG/BKC; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733384964; x=1764920964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0W3hrWB/Irav8nhuGzm/DQC/6Ab9jzUquKNv08/4ztk=;
  b=WGGG/BKCWXjH2tYt+FVNzIsBaPY6/EUqDSdJrX3IezB4ydgWqg1H/bjZ
   fa4JOW66COXsoZM1LdKLHCeBdEWOKHhMwV2CB8hG1lxnllPrfiB6aJBFC
   I1CL8rl+Z2E0Gvfq1BttKlIAZtNwVLJXJu5fwDuILK8QXWabZkn0UDqNb
   7YLFVCrq0+QFTL3VPMGgV8mQyEzwY/41rhBI4fnMCElh6UH4KGJ5zsPxd
   ocWiksR0oLY/pybKZH9q6bAzNkH8+cPi55slrV32yhs73gzPRIpxm0bqe
   aJT6r4nT0wcTlpN5s0Z2jd3CS8xVQMzgQ0Xkg45KBA4jQTHQ0+5IIyCtc
   A==;
X-CSE-ConnectionGUID: b73YNZ6DQpC6QHPkQkfqjA==
X-CSE-MsgGUID: VwEMmshqTLKjnQVM7cWnfQ==
X-IronPort-AV: E=Sophos;i="6.12,209,1728921600"; 
   d="scan'208";a="33626117"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2024 15:49:22 +0800
IronPort-SDR: 67514c5d_kd7HbZeenE6h44DccAEH0CdnGrjdJBd3KGS9IHK7wOVZvgI
 MXime4eq3Dk8su7KYqqb5ZNgyAMNj147v4BEyuQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2024 22:46:53 -0800
WDCIronportException: Internal
Received: from naota-x1.dhcp.fujisawa.hgst.com (HELO naota-x1.ad.shared) ([10.89.81.175])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2024 23:49:22 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 08/11] btrfs: introduce btrfs_space_info sub-group
Date: Thu,  5 Dec 2024 16:48:24 +0900
Message-ID: <ab8eb232d1acbf02af7352a2224a31b53ece01f5.1733384172.git.naohiro.aota@wdc.com>
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

Currently, the sub-group is only implemented for the relocation data
space_info. In the future, we can also implement the space_info for
the tree-log block group. Or, it could be useful to implement tiered
storage for btrfs e.g, by implementing a sub-group space_info for block
groups resides on a fast storage.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |  6 ++++++
 fs/btrfs/space-info.c  | 20 ++++++++++++++++++--
 fs/btrfs/space-info.h  |  8 ++++++++
 fs/btrfs/sysfs.c       | 16 +++++++++++++---
 4 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 6787f7034b9e..aa35b62e9773 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4506,6 +4506,12 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
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
index 1d0f0c9d8956..16beb25be4b0 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -249,6 +249,7 @@ static void init_space_info(struct btrfs_fs_info *info,
 	INIT_LIST_HEAD(&space_info->priority_tickets);
 	space_info->clamp = 1;
 	btrfs_update_space_info_chunk_size(space_info, calc_chunk_size(info, flags));
+	space_info->subgroup_id = SUB_GROUP_PRIMARY;
 
 	if (btrfs_is_zoned(info))
 		space_info->bg_reclaim_threshold = BTRFS_DEFAULT_ZONED_RECLAIM_THRESH;
@@ -266,6 +267,20 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 
 	init_space_info(info, space_info, flags);
 
+	if (btrfs_is_zoned(info) && (flags & BTRFS_BLOCK_GROUP_DATA)) {
+		struct btrfs_space_info *reloc = kzalloc(sizeof(*reloc), GFP_NOFS);
+
+		if (!reloc)
+			return -ENOMEM;
+		init_space_info(info, reloc, flags);
+		space_info->sub_group[SUB_GROUP_DATA_RELOC] = reloc;
+		reloc->parent = space_info;
+		reloc->subgroup_id = SUB_GROUP_DATA_RELOC;
+
+		ret = btrfs_sysfs_add_space_info_type(info, reloc);
+		ASSERT(!ret);
+	}
+
 	ret = btrfs_sysfs_add_space_info_type(info, space_info);
 	if (ret)
 		return ret;
@@ -561,8 +576,9 @@ static void __btrfs_dump_space_info(const struct btrfs_fs_info *fs_info,
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
index fdcbf650ac31..041ffe5e9cc5 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1792,15 +1792,25 @@ void btrfs_sysfs_remove_space_info(struct btrfs_space_info *space_info)
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
@@ -1820,7 +1830,7 @@ int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
 
 	ret = kobject_init_and_add(&space_info->kobj, &space_info_ktype,
 				   fs_info->space_info_kobj, "%s",
-				   alloc_name(space_info->flags));
+				   alloc_name(space_info));
 	if (ret) {
 		kobject_put(&space_info->kobj);
 		return ret;
-- 
2.47.1


