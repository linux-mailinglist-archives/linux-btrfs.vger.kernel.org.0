Return-Path: <linux-btrfs+bounces-19748-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D571BCBEE70
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 17:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18B093043F51
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 16:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22662F3618;
	Mon, 15 Dec 2025 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D8i5/zUS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482372F3C22
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765815877; cv=none; b=a4fD6sUoMoQPu99ENC8xu8trBUQSFYafPiGzMy6h7lVbGxKItJt43KUOTJ1k3sm7d3Qhl0pGv1ZijAnlj4gtx25JMRqrfti0cjy4YjB0/ZnSHUkB4FFgZ/DLV8B03vnEX+kbA/JhmC+bln58j4RE+1BAdPtuEVhJz3FPQ7tZnmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765815877; c=relaxed/simple;
	bh=Lwms+15xGibVXXuSS41aESHcJe7OB8Ire3aYwC4jDjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p33erB1N2cR9w//R4it7nzDHIDbTbC4FtVMrQIX2d8+wqlykb1Vt424ktGZiJRRqyDpefhtYVPbDuV+nd/7lcxkznVTcMloQ8mqSyXBDRjnBkT7PsOCfw8HThc/7MTxdbvK7aOMgoeZbWFosVhdSuIaC8POmG0lIISfedRu2Y9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=D8i5/zUS; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765815876; x=1797351876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lwms+15xGibVXXuSS41aESHcJe7OB8Ire3aYwC4jDjk=;
  b=D8i5/zUSRddvOhHV+ejV7Dv3QTDkMu5C3jaKLsCrGtvwvk8f3zGPgEjZ
   cNPLkwUeNmUkSHxwUyDEsF2ms1xnwqs4tWtJfkeqUJ8//LBD56OmOriop
   g/D2+pahqz9HJJRMYJW9ZCMcXXBkydb8OpTsDgoRWxrsgC26fbtsfww2P
   xx6GgWFDQFZ2s3usCuEPPicXvW+aQNdYudl1sYZAOxNQTn1B4Iz9s8XeW
   mnPAZntTjujCSoQRI9MNUS7N56LOQ/8rBcQu9LX0WTuYvSw0JFG7D8ONS
   m3p5Edo1l6Jql252vUSqCyuEZF6wrspRGpPeYOCRiQOh2V4sqIwZ2kaOR
   Q==;
X-CSE-ConnectionGUID: r7g6xFHvQ0SJruJlbq17fA==
X-CSE-MsgGUID: wpJnQZ1OSIG724ZVE/CHxA==
X-IronPort-AV: E=Sophos;i="6.21,151,1763395200"; 
   d="scan'208";a="137916727"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Dec 2025 00:24:31 +0800
IronPort-SDR: 6940363f_KoERfSa8JmdfeIuOFzNJdgfoQbBzAqZWa2WyYsUrkCAe/IR
 XhbWVcj86ntkAkFHDJwzV4CiY5oxZe/OuM6NniA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2025 08:24:31 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.125])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Dec 2025 08:24:29 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 1/3] btrfs: zoned: move zoned stats to mountstats
Date: Mon, 15 Dec 2025 17:24:18 +0100
Message-ID: <20251215162420.238275-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215162420.238275-1-johannes.thumshirn@wdc.com>
References: <20251215162420.238275-1-johannes.thumshirn@wdc.com>
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

The output for /proc/<pid>/mountstats on an example filesystem will be as
follows:

  device /dev/vda mounted on /mnt with fstype btrfs
          active block-groups: 7
            reclaimable: 0
            unused: 5
            need reclaim: false
          data relocation block-group: 1342177280
          active zones:
            start: 1073741824, wp: 268419072 used: 0, reserved: 268419072, unusable: 0
            start: 1342177280, wp: 0 used: 0, reserved: 0, unusable: 0
            start: 1610612736, wp: 49152 used: 16384, reserved: 16384, unusable: 16384
            start: 1879048192, wp: 950272 used: 131072, reserved: 622592, unusable: 196608
            start: 2147483648, wp: 212238336 used: 0, reserved: 212238336, unusable: 0
            start: 2415919104, wp: 0 used: 0, reserved: 0, unusable: 0
            start: 2684354560, wp: 0 used: 0, reserved: 0, unusable: 0

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/super.c | 12 +++++++++++
 fs/btrfs/sysfs.c | 52 ----------------------------------------------
 fs/btrfs/zoned.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h |  8 +++++++
 4 files changed, 74 insertions(+), 52 deletions(-)

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
index 359a98e6de85..6125df428568 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2984,3 +2984,57 @@ int btrfs_reset_unused_block_groups(struct btrfs_space_info *space_info, u64 num
 
 	return 0;
 }
+
+void btrfs_show_zoned_stats(struct btrfs_fs_info *fs_info, struct seq_file *s)
+{
+	struct btrfs_block_group *bg;
+	u64 data_reloc_bg;
+	u64 treelog_bg;
+
+	seq_puts(s, "\n");
+
+	spin_lock(&fs_info->zone_active_bgs_lock);
+	seq_printf(s, "\tactive block-groups: %zu\n",
+			     list_count_nodes(&fs_info->zone_active_bgs));
+	spin_unlock(&fs_info->zone_active_bgs_lock);
+
+	spin_lock(&fs_info->unused_bgs_lock);
+	seq_printf(s, "\t  reclaimable: %zu\n",
+			     list_count_nodes(&fs_info->reclaim_bgs));
+	seq_printf(s, "\t  unused: %zu\n", list_count_nodes(&fs_info->unused_bgs));
+	spin_unlock(&fs_info->unused_bgs_lock);
+
+	seq_printf(s,"\t  need reclaim: %s\n",
+		   str_true_false(btrfs_zoned_should_reclaim(fs_info)));
+
+	data_reloc_bg = data_race(fs_info->data_reloc_bg);
+	if (data_reloc_bg)
+		seq_printf(s, "\tdata relocation block-group: %llu\n",
+			   data_reloc_bg);
+	treelog_bg = data_race(fs_info->treelog_bg);
+	if (treelog_bg)
+		seq_printf(s, "\ttree-log block-group: %llu\n", treelog_bg);
+
+	spin_lock(&fs_info->zone_active_bgs_lock);
+	seq_puts(s, "\tactive zones:\n");
+	list_for_each_entry(bg, &fs_info->zone_active_bgs, active_bg_list) {
+		u64 start;
+		u64 alloc_offset;
+		u64 used;
+		u64 reserved;
+		u64 zone_unusable;
+
+		spin_lock(&bg->lock);
+		start = bg->start;
+		alloc_offset = bg->alloc_offset;
+		used = bg->used;
+		reserved = bg->reserved;
+		zone_unusable = bg->zone_unusable;
+		spin_unlock(&bg->lock);
+
+		seq_printf(s,
+			   "\t  start: %llu, wp: %llu used: %llu, reserved: %llu, unusable: %llu\n",
+			   start, alloc_offset, used, reserved, zone_unusable);
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


