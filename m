Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897E946BF7B
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 16:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbhLGPju (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 10:39:50 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:35689 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238916AbhLGPju (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 10:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638891379; x=1670427379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DCxYfL3uIZjRnzZip4bZzYhjB6rfPyfShRoAZauzxwM=;
  b=BNdtbhh6DmsihMnXhP5xTaRTCp05MP64l8zXbxu0I5xjUC27yykeQIUQ
   /485NTM1XfGqeSv+Kf5TgsjFA9mf0JMOdTZrHYkNUTRhMnQ5lJNjCVawX
   vxrpwnCpmDc45iM+j7lr3tHDwqqRdp4vBwfog1g8lzIArIv73lkXTcL8N
   1Ksm6q3ESTz4QkYvB8hQ1TiQg5TqZIDcXATPXmiHDOt/OYTKEbhrWd5Dj
   x84TrUjqHaXkzmGId6aa2Ee5ggzW8NOBUIgg/Z2iDVdgkScyydzRUKO7b
   wad5e0yA88c4YV8tAmT77+HaEez/jH8g2HNBwr4je/mq+Kql6RtXlkNRR
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,293,1631548800"; 
   d="scan'208";a="192442653"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2021 23:36:19 +0800
IronPort-SDR: OGh0fw4IZ2As+rii/1/Rw2HbqyKlDL72iiwoeSkq1Cx5hc4gVqNyuBEuhAYFcbD12WIMXHkxdB
 D00V5se6M7zbg3T8qh5oDX7Bq5fhmn5p8ltHGRMRJRNZfphpXSJedUFu1XdNz+Q5EC4y4TOeNh
 CPHLEjVvtWb5djd92byrMQZUttrd7HpgXt5PQW7h59oGLJDFKeTgHMpISVO4cTlxVMxsTd/Rhd
 2BDLCIyo52Dn4yeAyfoVYhmuwjXdyxTR43yrpuyqJm/bKcUgYG7+2ja/swuTRpK7HqoNRoXnYf
 Kvo1F+7lvKoycaFUjFohqyS8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 07:09:24 -0800
IronPort-SDR: pIm3QcFvqUKK0Db7nVkjE1ORQ6K/uY/wPIwfRNyCsJxNSbh2NdPIYvw6kJiOeHcQmjdr06FNH5
 HviX7woHdeH00Arw6uMeBlOoEU2c+YqbY1ys+BLgDoL6PSdKAH7VUgJb6PLkHESReIotDZ9Pyi
 gn7qu6RU8HWtOj4o7fZrazAem9wYwqWK1eUOQm8G6SUv2eAwHfONjln00ir/jVSVm9Si6grXdS
 qvY4iiBY+xoCX+A2qg8E71BO7z4nt4fml5neBuRnlmidjDzdT1EknLbH2Krq3ASr2cXRaO4VmZ
 ARY=
WDCIronportException: Internal
Received: from hx4cl13.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.41])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Dec 2021 07:36:20 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 3/3] btrfs: zoned: fix chunk allocation condition for zoned allocator
Date:   Wed,  8 Dec 2021 00:35:49 +0900
Message-Id: <20211207153549.2946602-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211207153549.2946602-1-naohiro.aota@wdc.com>
References: <20211207153549.2946602-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The ZNS specification defines a limit on the number of "active"
zones. That limit impose us to limit the number of block groups which
can be used for an allocation at the same time. Not to exceed the
limit, we reuse the existing active block groups as much as possible
when we can't activate any other zones without sacrificing an already
activated block group in commit a85f05e59bc1 ("btrfs: zoned: avoid
chunk allocation if active block group has enough space").

However, the check is wrong in two ways. First, it checks the
condition for every raid index (ffe_ctl->index). Even if it reaches
the condition and "ffe_ctl->max_extent_size >=
ffe_ctl->min_alloc_size" is met, there can be other block groups
having enough space to hold ffe_ctl->num_bytes. (Actually, this won't
happen in the current zoned code as it only supports SINGLE
profile. But, it can happen once it enables other RAID types.)

Second, it checks the active zone availability depending on the
raid index. The raid index is just an index for
space_info->block_groups, so it has nothing to do with chunk allocation.

These mistakes are causing a faulty allocation in a certain
situation. Consider we are running zoned btrfs on a device whose
max_active_zone == 0 (no limit). And, suppose no block group have a
room to fit ffe_ctl->num_bytes but some room to meet
ffe_ctl->min_alloc_size (i.e. max_extent_size > num_bytes >=
min_alloc_size).

In this situation, the following occur:

- With SINGLE raid_index, it reaches the chunk allocation checking
  code
- The check returns true because we can activate a new zone (no limit)
- But, before allocating the chunk, it iterates to the next raid index
  (RAID5)
- Since there are no RAID5 block groups on zoned mode, it again
  reaches the check code
- The check returns false because of btrfs_can_activate_zone()'s "if
  (raid_index != BTRFS_RAID_SINGLE)" part
- That results in returning -ENOSPC without allocating a new chunk

As a result, we end up hitting -ENOSPC too early.

Move the check to the right place in the can_allocate_chunk() hook,
and do the active zone check depending on the allocation flag, not on
the raid index.
---
 fs/btrfs/extent-tree.c | 21 +++++++++------------
 fs/btrfs/zoned.c       |  5 ++---
 fs/btrfs/zoned.h       |  5 ++---
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5ec512673dc5..802add9857ed 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3966,6 +3966,15 @@ static bool can_allocate_chunk(struct btrfs_fs_info *fs_info,
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		return true;
 	case BTRFS_EXTENT_ALLOC_ZONED:
+		/*
+		 * If we have enough free space left in an already
+		 * active block group and we can't activate any other
+		 * zone now, do not allow allocating a new chunk and
+		 * let find_free_extent() retry with a smaller size.
+		 */
+		if (ffe_ctl->max_extent_size >= ffe_ctl->min_alloc_size &&
+		    !btrfs_can_activate_zone(fs_info->fs_devices, ffe_ctl->flags))
+			return false;
 		return true;
 	default:
 		BUG();
@@ -4012,18 +4021,6 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 		return 0;
 	}
 
-	if (ffe_ctl->max_extent_size >= ffe_ctl->min_alloc_size &&
-	    !btrfs_can_activate_zone(fs_info->fs_devices, ffe_ctl->index)) {
-		/*
-		 * If we have enough free space left in an already active block
-		 * group and we can't activate any other zone now, retry the
-		 * active ones with a smaller allocation size.  Returning early
-		 * from here will tell btrfs_reserve_extent() to haven the
-		 * size.
-		 */
-		return -ENOSPC;
-	}
-
 	if (ffe_ctl->loop >= LOOP_CACHING_WAIT && ffe_ctl->have_caching_bg)
 		return 1;
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 67d932d70798..06681fae450a 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1883,7 +1883,7 @@ int btrfs_zone_finish(struct btrfs_block_group *block_group)
 	return ret;
 }
 
-bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, int raid_index)
+bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 {
 	struct btrfs_device *device;
 	bool ret = false;
@@ -1892,8 +1892,7 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, int raid_index
 		return true;
 
 	/* Non-single profiles are not supported yet */
-	if (raid_index != BTRFS_RAID_SINGLE)
-		return false;
+	ASSERT((flags & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0);
 
 	/* Check if there is a device with active zones left */
 	mutex_lock(&fs_devices->device_list_mutex);
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index e53ab7b96437..002ff86c8608 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -71,8 +71,7 @@ struct btrfs_device *btrfs_zoned_get_device(struct btrfs_fs_info *fs_info,
 					    u64 logical, u64 length);
 bool btrfs_zone_activate(struct btrfs_block_group *block_group);
 int btrfs_zone_finish(struct btrfs_block_group *block_group);
-bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices,
-			     int raid_index);
+bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags);
 void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical,
 			     u64 length);
 void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg);
@@ -222,7 +221,7 @@ static inline int btrfs_zone_finish(struct btrfs_block_group *block_group)
 }
 
 static inline bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices,
-					   int raid_index)
+					   u64 flags)
 {
 	return true;
 }
-- 
2.34.1

