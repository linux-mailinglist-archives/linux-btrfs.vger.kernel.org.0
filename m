Return-Path: <linux-btrfs+bounces-18157-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7362BBFB214
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 11:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FAC91A06D05
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 09:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096003128C7;
	Wed, 22 Oct 2025 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BD0se277"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED4C3128A4
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124814; cv=none; b=AbRuNJtdne98WXiy5ejDlHXpsMAOP3jjsdbPpJ1xr42PzhiUNn4E//b3zjIPlpbEcx1JfuGEaiH6g3/gWLNosc7n1OSNsQFLM43S9lRN+jsd1i10A9dppCoLm1JGomxpbnScM7I5sN49mjrdCDI8BwauVkGjZY5jvaWfOPcjeBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124814; c=relaxed/simple;
	bh=dRKA2l+GyUtS7VMb5sQGFOGlzc6HP4RBunId+FJYOtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eqeGoYCeiVlD5ZfJJ2KRHjEEEBFmyKqnti5bF88P/xvQOs/Jfh7oCvUaDFzfp+sxYBcKuUE2mO6iBCeZEn7rDYEJPfda6cL/dZgxViab874hg2vsVrud5r2yhcfWhO32cMimNjBsCMqDQjJE8LWyd7NqOZOmU/Ae2jOrRxcpb6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BD0se277; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761124812; x=1792660812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dRKA2l+GyUtS7VMb5sQGFOGlzc6HP4RBunId+FJYOtE=;
  b=BD0se27788s/HHCGEGJolgpF/JtzNU08/44V1NXs5coT+rLsZQ8b+p8C
   M/Po5oGO1GFfBpuwXr9USd5QdjCJVeLrLYS25gUgDwwthQ68APGqvdQ9p
   YBzX38V9qXNCgsMrurJ4zhbeRUpbRRri++nmA4CtUUdqNPsiBSwA8UWrK
   abAft8gdnUZxe0o1EbtDLKv6gF+zlXPkzt+MMnAVNbA1efbKE7IzshWtE
   tttCQwG13ju8rKr+9SB9B3G1ic3nvjI7RKmKC9STKybHmYDbppq6xId+j
   J5Ii2AfG2/SfNbonl93e74AE/MsWsbL/Npw1+1jSEmshZ876VRdM4idJb
   w==;
X-CSE-ConnectionGUID: 5t+sm/3nTCKHj5Xy4opiUQ==
X-CSE-MsgGUID: sBK77cCnSfyxPql7H6qC6w==
X-IronPort-AV: E=Sophos;i="6.19,246,1754928000"; 
   d="scan'208";a="133597352"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2025 17:20:05 +0800
IronPort-SDR: 68f8a1c6_ZIxIxI1eVQWYOTJ4XXDLKh2U4kWwo5NHSWsRsG5MYStab+r
 7OtGzT8q56d8uEwSooEwQVptGc4973eDC21fZ4Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 02:20:06 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.49])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Oct 2025 02:20:03 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: zoned: show statistics for zoned filesystems
Date: Wed, 22 Oct 2025 11:19:59 +0200
Message-ID: <20251022091959.196133-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Provide statistics for zoned filesystems. These statistics include, the
number of active block-groups, how many of them are reclaimable or unused,
if the filesystem needs to be reclaimed, the currently assigned relocation
and treelog block-groups if they're present and a list of active zones.

Example:
  active block-groups: 4
    reclaimable: 0
    unused: 2
    need reclaim: false
  data reclocation block-group: 4294967296
  active zones:
    start: 1610612736, wp: 344064 used: 16384, reserved: 0, unusable: 327680
    start: 1879048192, wp: 34963456 used: 131072, reserved: 0, unusable: 34832384
    start: 4026531840, wp: 0 used: 0, reserved: 0, unusable: 0
    start: 4294967296, wp: 0 used: 0, reserved: 0, unusable: 0

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/sysfs.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index d66681ce2b3d..c901e56d2694 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -10,6 +10,7 @@
 #include <linux/completion.h>
 #include <linux/bug.h>
 #include <linux/list.h>
+#include <linux/string_choices.h>
 #include <crypto/hash.h>
 #include "messages.h"
 #include "ctree.h"
@@ -25,6 +26,7 @@
 #include "misc.h"
 #include "fs.h"
 #include "accessors.h"
+#include "zoned.h"
 
 /*
  * Structure name                       Path
@@ -1187,6 +1189,56 @@ static ssize_t btrfs_commit_stats_store(struct kobject *kobj,
 }
 BTRFS_ATTR_RW(, commit_stats, btrfs_commit_stats_show, btrfs_commit_stats_store);
 
+static ssize_t btrfs_zoned_stats_show(struct kobject *kobj,
+				      struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
+	struct btrfs_block_group *bg;
+	size_t ret = 0;
+
+
+	if (!btrfs_is_zoned(fs_info))
+		return ret;
+
+	spin_lock(&fs_info->zone_active_bgs_lock);
+	ret += sysfs_emit_at(buf, ret, "active block-groups: %zu\n",
+			     list_count_nodes(&fs_info->zone_active_bgs));
+	spin_unlock(&fs_info->zone_active_bgs_lock);
+
+	mutex_lock(&fs_info->reclaim_bgs_lock);
+	spin_lock(&fs_info->unused_bgs_lock);
+	ret += sysfs_emit_at(buf, ret, "\treclaimable: %zu\n",
+			     list_count_nodes(&fs_info->reclaim_bgs));
+	ret += sysfs_emit_at(buf, ret, "\tunused: %zu\n",
+			     list_count_nodes(&fs_info->unused_bgs));
+	spin_unlock(&fs_info->unused_bgs_lock);
+	mutex_unlock(&fs_info->reclaim_bgs_lock);
+
+	ret += sysfs_emit_at(buf, ret, "\tneed reclaim: %s\n",
+			     str_true_false(btrfs_zoned_should_reclaim(fs_info)));
+
+	if (fs_info->data_reloc_bg)
+		ret += sysfs_emit_at(buf, ret,
+				     "data reclocation block-group: %llu\n",
+				     fs_info->data_reloc_bg);
+	if (fs_info->treelog_bg)
+		ret += sysfs_emit_at(buf, ret,
+				     "tree-log block-group: %llu\n",
+				     fs_info->treelog_bg);
+
+	spin_lock(&fs_info->zone_active_bgs_lock);
+	ret += sysfs_emit_at(buf, ret, "active zones:\n");
+	list_for_each_entry(bg, &fs_info->zone_active_bgs, active_bg_list) {
+		ret += sysfs_emit_at(buf, ret,
+				     "\tstart: %llu, wp: %llu used: %llu, reserved: %llu, unusable: %llu\n",
+				     bg->start, bg->alloc_offset, bg->used,
+				     bg->reserved, bg->zone_unusable);
+	}
+	spin_unlock(&fs_info->zone_active_bgs_lock);
+	return ret;
+}
+BTRFS_ATTR(, zoned_stats, btrfs_zoned_stats_show);
+
 static ssize_t btrfs_clone_alignment_show(struct kobject *kobj,
 				struct kobj_attribute *a, char *buf)
 {
@@ -1599,6 +1651,7 @@ static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
 	BTRFS_ATTR_PTR(, commit_stats),
 	BTRFS_ATTR_PTR(, temp_fsid),
+	BTRFS_ATTR_PTR(, zoned_stats),
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	BTRFS_ATTR_PTR(, offload_csum),
 #endif
-- 
2.51.0


