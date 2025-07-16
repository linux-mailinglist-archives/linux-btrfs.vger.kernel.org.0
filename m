Return-Path: <linux-btrfs+bounces-15521-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A509B06FCA
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 10:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB5A17A016
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 08:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27F7291C21;
	Wed, 16 Jul 2025 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZUeUQeIp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680F41D86FF
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652820; cv=none; b=tIsJa9ozugwFMt36egCgidxRRKtlakCkAF1CmpETITiKk3C82cma8irRDKEQ7/FJ6BC4d1LzFNLnCYlm76MOvU+CJ+5ZQ1T8H75k8FrwnajPM1XglFEFJcU804l4D7Qq2o2x3sOi+ISialP+h9f8vCTpjty8Jf38stHLXKz+iDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652820; c=relaxed/simple;
	bh=KX1eYzvKzfEMQ4DglqmIGYzdjQIVlV7mVpm2Lb2DGck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXiR9AwmhTOlkhxq7PWTs5MytQw/HoJVZx/ZWrck97uBzOA91+RaxAv2ekQErpFkIDumsqIDUw+0N1jkfeX8lnwGpGNCYlsyC4D+RAQi78eC3MRuZ0Yuu/JxoJNxG6r+ylinrahIRxBvGa+NVrAXeVH4iHrp1Q2JX8yChEoPVJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZUeUQeIp; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752652818; x=1784188818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KX1eYzvKzfEMQ4DglqmIGYzdjQIVlV7mVpm2Lb2DGck=;
  b=ZUeUQeIpDSmqbQNK0D6vUu/DT6ZRiDdFHuTzqv7BnjNR0YmxVI9XNTCQ
   WoDr63sBVeMJdxWw6ZcbRlNG9VinFmqeysqO0vXfIU85MzVIv6kpS5pUl
   Pj6N1WkdKHFMJbMLEejXQIMcuE3XCOfh6DhYXC6tnZu3yKzUauHf27hgq
   ucY3Pt11TheujRCUrge49cLI6zzjjWlCuW5YPURWjuzQMbp35gOaa6/BS
   O/0YXJ/qZggmOPPLqpvZd7f8h3ien+xpq/c7QhuTEcO3TRgd4nwecNGzc
   9L7rOa0BQe29fmsJk1JsiEb1Pax58L0oH/gHnwC9ADxJDhpW9qWHAxGTj
   w==;
X-CSE-ConnectionGUID: 0O2Gdsg/RLmqOTBPDDYBrA==
X-CSE-MsgGUID: IrvFAhwkSpaK0Uj+7ZOpGA==
X-IronPort-AV: E=Sophos;i="6.16,315,1744041600"; 
   d="scan'208";a="94432936"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2025 16:00:17 +0800
IronPort-SDR: 68774d70_itNNw3JBmuOikjbiD9oqIQPT12GynJiJj8tPCkKzRrGOlyp
 X3hScgVjpefNGqwqgFusEqXL3UrlcwLCA0RU4YA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2025 23:57:52 -0700
WDCIronportException: Internal
Received: from wdap-0lwmw3epm9.ad.shared (HELO naota-xeon) ([10.224.173.10])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Jul 2025 01:00:17 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 2/4] btrfs: zoned: fix data relocation block group reservation
Date: Wed, 16 Jul 2025 16:59:53 +0900
Message-ID: <7547a992a03414e821fd3093ba7a6d281140e6d0.1752652539.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752652539.git.naohiro.aota@wdc.com>
References: <cover.1752652539.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs_zoned_reserve_data_reloc_bg() is called on mount and at that point,
all data block groups belong to the primary data space_info. So, we don't
find anything in the data relocation space_info.

Also, the condition "bg->used > 0" can select a block group with full of
zone_unusable bytes for the candidate. As we cannot allocate from the block
group, it is useless to reserve it as the data relocation block group.

Furthermore, because of the space_info separation, we need to migrate the
selected block group to the data relocation space_info. If not, the extent
allocator cannot use the block group to do the allocation.

This commit fixes these three issues.

Fixes: e606ff985ec7 ("btrfs: zoned: reserve data_reloc block group on mount")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 55 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index db11b5b5f0e6..77297928334e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -17,6 +17,7 @@
 #include "accessors.h"
 #include "bio.h"
 #include "transaction.h"
+#include "sysfs.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -2504,12 +2505,12 @@ void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg)
 void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_space_info *data_sinfo = fs_info->data_sinfo;
-	struct btrfs_space_info *space_info = data_sinfo->sub_group[0];
+	struct btrfs_space_info *space_info = data_sinfo;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_block_group *bg;
 	struct list_head *bg_list;
 	u64 alloc_flags;
-	bool initial = false;
+	bool first = true;
 	bool did_chunk_alloc = false;
 	int index;
 	int ret;
@@ -2523,21 +2524,52 @@ void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
 	if (sb_rdonly(fs_info->sb))
 		return;
 
-	ASSERT(space_info->subgroup_id == BTRFS_SUB_GROUP_DATA_RELOC);
 	alloc_flags = btrfs_get_alloc_profile(fs_info, space_info->flags);
 	index = btrfs_bg_flags_to_raid_index(alloc_flags);
 
-	bg_list = &data_sinfo->block_groups[index];
+	/* Scan the data space_info to find empty block groups. Take the second one. */
 again:
+	bg_list = &space_info->block_groups[index];
 	list_for_each_entry(bg, bg_list, list) {
-		if (bg->used > 0)
+		if (bg->alloc_offset != 0)
 			continue;
 
-		if (!initial) {
-			initial = true;
+		if (first) {
+			first = false;
 			continue;
 		}
 
+		if (space_info == data_sinfo) {
+			/* Migrate the block group to the data relocation space_info. */
+			struct btrfs_space_info *reloc_sinfo = data_sinfo->sub_group[0];
+			int factor;
+
+			ASSERT(reloc_sinfo->subgroup_id == BTRFS_SUB_GROUP_DATA_RELOC);
+			factor = btrfs_bg_type_to_factor(bg->flags);
+
+			down_write(&space_info->groups_sem);
+			list_del_init(&bg->list);
+			/* We can assume this as we choose the second empty one. */
+			ASSERT(!list_empty(&space_info->block_groups[index]));
+			up_write(&space_info->groups_sem);
+
+			spin_lock(&space_info->lock);
+			space_info->total_bytes -= bg->length;
+			space_info->disk_total -= bg->length * factor;
+			/* There is no allocation ever happened. */
+			ASSERT(bg->used == 0);
+			ASSERT(bg->zone_unusable == 0);
+			/* No super block in a block group on the zoned setup. */
+			ASSERT(bg->bytes_super == 0);
+			spin_unlock(&space_info->lock);
+
+			bg->space_info = reloc_sinfo;
+			if (reloc_sinfo->block_group_kobjs[index] == NULL)
+				btrfs_sysfs_add_block_group_type(bg);
+
+			btrfs_add_bg_to_space_info(fs_info, bg);
+		}
+
 		fs_info->data_reloc_bg = bg->start;
 		set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &bg->runtime_flags);
 		btrfs_zone_activate(bg);
@@ -2552,11 +2584,18 @@ void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
 	if (IS_ERR(trans))
 		return;
 
+	/* Allocate new BG in the data relocation space_info. */
+	space_info = data_sinfo->sub_group[0];
+	ASSERT(space_info->subgroup_id == BTRFS_SUB_GROUP_DATA_RELOC);
 	ret = btrfs_chunk_alloc(trans, space_info, alloc_flags, CHUNK_ALLOC_FORCE);
 	btrfs_end_transaction(trans);
 	if (ret == 1) {
+		/*
+		 * We allocated a new block group in the data relocation space_info. We
+		 * can take that one.
+		 */
+		first = false;
 		did_chunk_alloc = true;
-		bg_list = &space_info->block_groups[index];
 		goto again;
 	}
 }
-- 
2.50.1


