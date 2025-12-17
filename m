Return-Path: <linux-btrfs+bounces-19838-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC7CCC7F57
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 14:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25023311003F
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 13:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058E6348875;
	Wed, 17 Dec 2025 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Fd7xxMhZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9B7346781
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765978909; cv=none; b=HifDrnm9Hxk+GLPJ/Tp+r0swNcK0+r6YhfqEkkl9sXVm9c4NZYRaZMam5NV8EVGqB2bLUBJXuvmQLKiqqpECrh1CfyRkNZvDZt8OcH53S+C4FjLy3h26ZKiLf/dZEYqljO8pEsqgMFi/XYwZE7HRT5I3JSoSu3kp3r2lDkeHsQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765978909; c=relaxed/simple;
	bh=exISnpL3u4zWIUYZPvktmougnj5wN2RSpiZF0uJaPRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4JbmpU4DFjvEzp8AwyDYnt2o5EiaBwjhdY0o5+Esf+OHzzvbSO7Wlq3why+bHbzVwx27xGuDddtOTi8jtVvWFHO66MOnbhh8x7d1lmo4ERhUPJLFHEb2BQl3tn3JAaxge9bOzMiobRhj3YOL6g5aQhvpVwSyD97S2atRWNfakg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Fd7xxMhZ; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765978907; x=1797514907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=exISnpL3u4zWIUYZPvktmougnj5wN2RSpiZF0uJaPRs=;
  b=Fd7xxMhZyNBEpgDKXrk81dgUBRtYkxlJ0XZE6VgA45blnZH4SXPYg7+H
   kVaZYxCVAu/l2zn6TaTp30jN/bQSIvtX8Z3R3t1DJQkGudn6mkFy4Qf7i
   7cs0j+Lr/+6ZmV7UdOZA/DbFW5bOPOULnKXdE69R6CPnNVcRgolIzWILw
   yd9N1X80Pe1DTHLHFAIhoTQMpfR2ziOIAZSHVqiL7W4aNJqO/ISrvB+mA
   RobgM5sh/9ERD/6i69b9/mbKvaffYm14YkRLq69n5aIMNtcq84i8OHFsz
   ttf5XZyb/7y1Qp4YHHSrguyws+W5ADxL+Cp8YTr8sBAGbH2FxexSzCiQt
   Q==;
X-CSE-ConnectionGUID: cmgQFCy0S6aio2BO4kblPg==
X-CSE-MsgGUID: qTt85pqhST6KGZMpZXQXlQ==
X-IronPort-AV: E=Sophos;i="6.21,155,1763395200"; 
   d="scan'208";a="136693794"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2025 21:41:47 +0800
IronPort-SDR: 6942b31b_3QhtnrHK3snt/wf+El5w39Gdq2DTompkh7ZfGXn0Jutwz5t
 NxK8HQiZ03tqVG6ga/yudDr/LgMRS8qhmoxpmtQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2025 05:41:47 -0800
WDCIronportException: Internal
Received: from 5cg1443rm2.ad.shared (HELO neo.fritz.box) ([10.224.28.135])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Dec 2025 05:41:46 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 2/4] btrfs: zoned: show statistics about zoned filesystems in mountstats
Date: Wed, 17 Dec 2025 14:41:37 +0100
Message-ID: <20251217134139.275174-3-johannes.thumshirn@wdc.com>
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

Add statistics output to /proc/<pid>/mountstats for zoned BTRFS, similar
to the zoned statistics from XFS in mountstats.

The output for /proc/<pid>/mountstats on an example filesystem will be as
follows:

  device /dev/vda mounted on /mnt with fstype btrfs
    zoned statistics:
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
 fs/btrfs/super.c | 13 ++++++++++++
 fs/btrfs/zoned.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h |  8 +++++++
 3 files changed, 75 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a37b71091014..e382acec2b1e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2485,6 +2485,18 @@ static void btrfs_shutdown(struct super_block *sb)
 }
 #endif
 
+static int btrfs_show_stats(struct seq_file *s, struct dentry *root)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(root->d_sb);
+
+	if (btrfs_is_zoned(fs_info)) {
+		btrfs_show_zoned_stats(fs_info, s);
+		return 0;
+	}
+
+	return 0;
+}
+
 static const struct super_operations btrfs_super_ops = {
 	.drop_inode	= btrfs_drop_inode,
 	.evict_inode	= btrfs_evict_inode,
@@ -2500,6 +2512,7 @@ static const struct super_operations btrfs_super_ops = {
 	.unfreeze_fs	= btrfs_unfreeze,
 	.nr_cached_objects = btrfs_nr_cached_objects,
 	.free_cached_objects = btrfs_free_cached_objects,
+	.show_stats	= btrfs_show_stats,
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	.remove_bdev	= btrfs_remove_bdev,
 	.shutdown	= btrfs_shutdown,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 359a98e6de85..fa61276058d8 100644
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
+	seq_puts(s, "\n  zoned statistics:\n");
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


