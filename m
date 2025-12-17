Return-Path: <linux-btrfs+bounces-19837-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EBACC7F51
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 14:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DA54310D72B
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 13:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67423469E3;
	Wed, 17 Dec 2025 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="buNlMBSp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75447344054
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765978907; cv=none; b=FupDIvm7I62aejjVJh81pM71LYAJ2DoFBKt2mlvSxvPYaZ7KsTkI8EMNJwQkeFceZHhakpTi9ryE0sZGJ6qCkAm7nQ8TIUIdtVxYZhqQeCSftA3LvY3xM4KGWGk9MQCiQglwLozLbDz2cHcDqHjLeGVXWWaHHkGXw1uR6/9RJjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765978907; c=relaxed/simple;
	bh=nSBHuLUx+EaJCUwh2SF1E9/u+BuwgSj7uB9BTf9re3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBJ8TvvNlWkQFi6+WgocX5uyhAjUQE2BW/5jN+3qActZLSuEh9DuZ7bleIL86Od66Pqv2Bsgf4sCryhh4rXsr6zTSWhmPlzJJzAI5yC6BxpUK7FxQqM06rUdKaf/63kb3DkPeLwWi5XPKC3WIlLgWGCwuWXqNmIx3d3qeRKad5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=buNlMBSp; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765978905; x=1797514905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nSBHuLUx+EaJCUwh2SF1E9/u+BuwgSj7uB9BTf9re3U=;
  b=buNlMBSpm7geXMv3jA/tnWfXe6cVNFn1DW4kYKs0qoucRz9Aa39Kqb/1
   BBNLErBtEY+UnFOI/tFb1m1BTuZ3QOnoMw3/IboZdmFxNVJnx7TvOi2ll
   fIA51V99gGu2btRpao52x2BQ681LNhTboBtuBgiQPZCI81zih4je5vjlT
   3BgtC7MR6SV6IGU+uRSsAt4xmQ57IYkT/yOi3Dj/Dbh9HJ4dg7QisyJjS
   ZZLWqPt6rPxeoBZHhvw2q0xg9R9ynur181QyhFXkko2eKKhH9k85rjVkK
   X7El3+IAXS2BXj4uRqpZjN2pe6vhhlm5gjxL5o26gAZfmdjGjDTehVl+K
   g==;
X-CSE-ConnectionGUID: 0faI9amxSPOBSV+5VO8dMA==
X-CSE-MsgGUID: jaMHHOcpRE2D6fRWH7iblA==
X-IronPort-AV: E=Sophos;i="6.21,155,1763395200"; 
   d="scan'208";a="136693790"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2025 21:41:45 +0800
IronPort-SDR: 6942b319_wdazYD4OKKECpukCiz3dJ7WCKxaIuz1SGhUqDjUutNkUkB0
 RiB4x/7Mclojz4LMqDDMjiCFHsaLIKLaKYX7e2A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2025 05:41:45 -0800
WDCIronportException: Internal
Received: from 5cg1443rm2.ad.shared (HELO neo.fritz.box) ([10.224.28.135])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Dec 2025 05:41:44 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 1/4] btrfs: remove zoned statistics from sysfs
Date: Wed, 17 Dec 2025 14:41:36 +0100
Message-ID: <20251217134139.275174-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217134139.275174-1-johannes.thumshirn@wdc.com>
References: <20251217134139.275174-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the newly introduced zoned statistics from sysfs, as sysfs can
only show a single page this will truncate the output on a busy
filesystem.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/sysfs.c | 52 ------------------------------------------------
 1 file changed, 52 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 7f00e4babbc1..f0974f4c0ae4 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -25,7 +25,6 @@
 #include "misc.h"
 #include "fs.h"
 #include "accessors.h"
-#include "zoned.h"
 
 /*
  * Structure name                       Path
@@ -1188,56 +1187,6 @@ static ssize_t btrfs_commit_stats_store(struct kobject *kobj,
 }
 BTRFS_ATTR_RW(, commit_stats, btrfs_commit_stats_show, btrfs_commit_stats_store);
 
-static ssize_t btrfs_zoned_stats_show(struct kobject *kobj,
-				      struct kobj_attribute *a, char *buf)
-{
-	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
-	struct btrfs_block_group *bg;
-	size_t ret = 0;
-
-
-	if (!btrfs_is_zoned(fs_info))
-		return ret;
-
-	spin_lock(&fs_info->zone_active_bgs_lock);
-	ret += sysfs_emit_at(buf, ret, "active block-groups: %zu\n",
-			     list_count_nodes(&fs_info->zone_active_bgs));
-	spin_unlock(&fs_info->zone_active_bgs_lock);
-
-	mutex_lock(&fs_info->reclaim_bgs_lock);
-	spin_lock(&fs_info->unused_bgs_lock);
-	ret += sysfs_emit_at(buf, ret, "\treclaimable: %zu\n",
-			     list_count_nodes(&fs_info->reclaim_bgs));
-	ret += sysfs_emit_at(buf, ret, "\tunused: %zu\n",
-			     list_count_nodes(&fs_info->unused_bgs));
-	spin_unlock(&fs_info->unused_bgs_lock);
-	mutex_unlock(&fs_info->reclaim_bgs_lock);
-
-	ret += sysfs_emit_at(buf, ret, "\tneed reclaim: %s\n",
-			     str_true_false(btrfs_zoned_should_reclaim(fs_info)));
-
-	if (fs_info->data_reloc_bg)
-		ret += sysfs_emit_at(buf, ret,
-				     "data relocation block-group: %llu\n",
-				     fs_info->data_reloc_bg);
-	if (fs_info->treelog_bg)
-		ret += sysfs_emit_at(buf, ret,
-				     "tree-log block-group: %llu\n",
-				     fs_info->treelog_bg);
-
-	spin_lock(&fs_info->zone_active_bgs_lock);
-	ret += sysfs_emit_at(buf, ret, "active zones:\n");
-	list_for_each_entry(bg, &fs_info->zone_active_bgs, active_bg_list) {
-		ret += sysfs_emit_at(buf, ret,
-				     "\tstart: %llu, wp: %llu used: %llu, reserved: %llu, unusable: %llu\n",
-				     bg->start, bg->alloc_offset, bg->used,
-				     bg->reserved, bg->zone_unusable);
-	}
-	spin_unlock(&fs_info->zone_active_bgs_lock);
-	return ret;
-}
-BTRFS_ATTR(, zoned_stats, btrfs_zoned_stats_show);
-
 static ssize_t btrfs_clone_alignment_show(struct kobject *kobj,
 				struct kobj_attribute *a, char *buf)
 {
@@ -1649,7 +1598,6 @@ static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
 	BTRFS_ATTR_PTR(, commit_stats),
 	BTRFS_ATTR_PTR(, temp_fsid),
-	BTRFS_ATTR_PTR(, zoned_stats),
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	BTRFS_ATTR_PTR(, offload_csum),
 #endif
-- 
2.52.0


