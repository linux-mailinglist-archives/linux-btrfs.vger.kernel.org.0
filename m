Return-Path: <linux-btrfs+bounces-19690-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61641CB8149
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 08:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AB113078380
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 07:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343F030EF75;
	Fri, 12 Dec 2025 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S0U+oS3h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE0B28B3E7
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 07:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765523422; cv=none; b=Z4P48ck+PWrCi2BCakEZN4u+XthSZGaYqu/92CAUyCrpL+ec+7BKSbCE2KZ1Go5ACSZMpymdNX8HzKnyqS8JVDhlmzU4o2hCHVosQu7wJOPfN39zST7mt5jIj0emtPrNw2rHBrGTu3IyG5MygLhgeT/Ej1EVxiLjVpFDSrQg0Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765523422; c=relaxed/simple;
	bh=HQsAFUIhNZdWwtyjddzpgcjCampN/pGoPLc4L9N8mMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOagsnxJALk10nwuRpQIf7x1uisrmEVBA6qR7bX5Rkt6sI7/yAsImA0s4WqbuNzun5fMDdFpX0TElupDovlDCBWfZXfvialL5AQMc7A81C/fCfFMN9oZ9GeBL8O818nXmYrEprMzBGr8WWd2Xaf/0dWuyyOaTiwESx/GT4I1loY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=S0U+oS3h; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765523420; x=1797059420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HQsAFUIhNZdWwtyjddzpgcjCampN/pGoPLc4L9N8mMM=;
  b=S0U+oS3hgESQ6rnF7AIoxFpCNEAlkQzPtTMt/IuY7dbPHxdPOQE9127C
   8aSMZNVdttVsGTgAOE0pirPIxbR58gGJZrp7QVu9hbsyNntzzXv4K6i3A
   7XvK/dfXvc7WLJ1UEDeJX542a8RnjKSH7yMCx8FXMHGggoT59hAnowMS0
   M1SYezzYKrusEgUaGkTJH8cWrATLdaM5PSfd+d8t4QPhPdhNnFAFAyx1f
   OwGdm0eatN1KYUr9dLB4cmTiRDR7SFT+BNWZI9gdrhfe3Ss62TvHGYuHV
   m+bLgsPoGUXOVH1U7qS1AJDf4F/wxUynDrOzIVG+Ha5CLvbXM9Fj14Jyu
   Q==;
X-CSE-ConnectionGUID: jGVF3ioqROa9GYhxPovyzw==
X-CSE-MsgGUID: 91YiqeCqRu6Yqd2yV21Dvg==
X-IronPort-AV: E=Sophos;i="6.21,143,1763395200"; 
   d="scan'208";a="136927262"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2025 15:10:11 +0800
IronPort-SDR: 693bbfd4_tLlX8bv132z4roxSpwUJbYHrx+GO/0m7s03f4H8cM8u76xF
 MvyzkhGGy2v/uU/vciOgUQINlVV/WIxICwOpC5A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2025 23:10:12 -0800
WDCIronportException: Internal
Received: from 5cg1430htq.ad.shared (HELO neo.wdc.com) ([10.224.28.119])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Dec 2025 23:10:08 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 1/4] btrfs: zoned: move zoned stats to mountstats
Date: Fri, 12 Dec 2025 08:09:57 +0100
Message-ID: <20251212071000.135950-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251212071000.135950-1-johannes.thumshirn@wdc.com>
References: <20251212071000.135950-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move zoned statistics to /proc/<pid>/mountstats just like it is for XFS,
because sysfs is limited to a single page, which causes the output to be
truncated.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/super.c | 12 +++++++++++
 fs/btrfs/sysfs.c | 52 ------------------------------------------------
 fs/btrfs/zoned.c | 40 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h |  8 ++++++++
 4 files changed, 60 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a37b71091014..ecbfeaa859a0 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2485,6 +2485,17 @@ static void btrfs_shutdown(struct super_block *sb)
 }
 #endif
 
+static int btrfs_show_stats(struct seq_file *s, struct dentry *root)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(root->d_sb);
+
+	if (!btrfs_is_zoned(fs_info))
+		return 0 ;
+
+	btrfs_show_zoned_stats(fs_info, s);
+	return 0;
+}
+
 static const struct super_operations btrfs_super_ops = {
 	.drop_inode	= btrfs_drop_inode,
 	.evict_inode	= btrfs_evict_inode,
@@ -2500,6 +2511,7 @@ static const struct super_operations btrfs_super_ops = {
 	.unfreeze_fs	= btrfs_unfreeze,
 	.nr_cached_objects = btrfs_nr_cached_objects,
 	.free_cached_objects = btrfs_free_cached_objects,
+	.show_stats	= btrfs_show_stats,
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	.remove_bdev	= btrfs_remove_bdev,
 	.shutdown	= btrfs_shutdown,
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
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 359a98e6de85..2235187a2807 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2984,3 +2984,43 @@ int btrfs_reset_unused_block_groups(struct btrfs_space_info *space_info, u64 num
 
 	return 0;
 }
+
+void btrfs_show_zoned_stats(struct btrfs_fs_info *fs_info, struct seq_file *s)
+{
+	struct btrfs_block_group *bg;
+
+	seq_puts(s, "\n");
+
+	spin_lock(&fs_info->zone_active_bgs_lock);
+	seq_printf(s, "\tactive block-groups: %zu\n",
+			     list_count_nodes(&fs_info->zone_active_bgs));
+	spin_unlock(&fs_info->zone_active_bgs_lock);
+
+	mutex_lock(&fs_info->reclaim_bgs_lock);
+	spin_lock(&fs_info->unused_bgs_lock);
+	seq_printf(s, "\t  reclaimable: %zu\n",
+			     list_count_nodes(&fs_info->reclaim_bgs));
+	seq_printf(s, "\t  unused: %zu\n", list_count_nodes(&fs_info->unused_bgs));
+	spin_unlock(&fs_info->unused_bgs_lock);
+	mutex_unlock(&fs_info->reclaim_bgs_lock);
+
+	seq_printf(s,"\t  need reclaim: %s\n",
+		   str_true_false(btrfs_zoned_should_reclaim(fs_info)));
+
+	if (fs_info->data_reloc_bg)
+		seq_printf(s, "\tdata relocation block-group: %llu\n",
+				fs_info->data_reloc_bg);
+	if (fs_info->treelog_bg)
+		seq_printf(s, "\ttree-log block-group: %llu\n",
+				fs_info->treelog_bg);
+
+	spin_lock(&fs_info->zone_active_bgs_lock);
+	seq_puts(s, "\tactive zones:\n");
+	list_for_each_entry(bg, &fs_info->zone_active_bgs, active_bg_list) {
+		seq_printf(s,
+			   "\t  start: %llu, wp: %llu used: %llu, reserved: %llu, unusable: %llu\n",
+			   bg->start, bg->alloc_offset, bg->used, bg->reserved,
+			   bg->zone_unusable);
+	}
+	spin_unlock(&fs_info->zone_active_bgs_lock);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 5cefdeb08b7b..e54b951359ea 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
+#include <linux/seq_file.h>
 #include "messages.h"
 #include "volumes.h"
 #include "disk-io.h"
@@ -96,6 +97,8 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info);
 int btrfs_zoned_activate_one_bg(struct btrfs_space_info *space_info, bool do_finish);
 void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info);
 int btrfs_reset_unused_block_groups(struct btrfs_space_info *space_info, u64 num_bytes);
+void btrfs_show_zoned_stats(struct btrfs_fs_info *fs_info, struct seq_file *s);
+
 #else /* CONFIG_BLK_DEV_ZONED */
 
 static inline int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
@@ -275,6 +278,11 @@ static inline int btrfs_reset_unused_block_groups(struct btrfs_space_info *space
 	return 0;
 }
 
+static inline int btrfs_show_zoned_stats(struct btrfs_fs_info *fs_info, struct seq_file *s)
+{
+	return 0;
+}
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.52.0


