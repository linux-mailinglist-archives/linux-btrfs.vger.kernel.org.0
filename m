Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8373E9391
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 16:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhHKOVe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 10:21:34 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:64262 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbhHKOV0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 10:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628691663; x=1660227663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DCMYMtqFpDFyOOdJko3C5IjxZKrtDPP8ckrvlJCHExk=;
  b=f/G3xtx5aG189/YxGzDFhhf1qPJbo39tHk0iDk9FTihz6cA82l+eMqpm
   fZc+y0T+Qv5Bz93LBTsR+TJomQBATfWQ7dIwoojqn+9FQGehY8Nd1zEbX
   u+tzJEK+PSUib9+OFfWZoYSXV9OJ4y4+vMDs00fPqb1QidzKGOyw/GRnM
   eNqzoCoMBoWGvHAgfln339aGvRZbGdYgCxvgmeuT+5e2bkZB9Tck4kN0K
   u3tPmNNNIzHTwUMiwa0oDDrcOhq/f2kbLSyYy9lt6lrMLI3/BXg7709u9
   Gj2QDY1cE9mTXBDDx6unjtEtyzGH0o65PKPZ6EQpkCgrIMim+uFoQDvKj
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="288506685"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 22:21:03 +0800
IronPort-SDR: Z4KJZGKySDA6nMkIJ++nVyYDsxwjvmjmAO6Z7J36+G62zrAIH8S6+z9x/83A02ndeDuPdpUa6p
 2CzZfRNsw9FTPgfiFOFppnh3gZHE8Z3vQTPdPLaKF2FR/B1fJCNSI56amNUJYitpfBhkmFT6Xm
 zXRvVZ3O/UlKo3WkGObxpnxVIkWUZA5xfNk6WAGtPN+FZ+1NwQJyJS/YBAqJ6+TwOziXlbsB35
 Pojii/lYyh04SBX1QCUuDQqMD/B/o0/o12dTRPybomeJ5wfyVkqresBnxJ/ZY7g/Q1OnFKcyrJ
 FUKFroNz0uvs5amu5+IMR+88
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 06:56:33 -0700
IronPort-SDR: HGTQvSz72Jp4ri404OHS16CASgA/Mm2p85o77y+Wt1p0lqpVwt/09pkXQIQ44C99cs8YjDt2sn
 b5uxgXS4H0NS0s/o8e8BzJ+TU2GxpSZfLVddx2/O0jGUVHmy8HpEFicRDPqALy8+kJxopxfjdk
 4vll1x5KKvjopQ1RlGscg3fdtVYl/6dB2l0Uga3pjapE6u/oevvfPb3gOvtY4jidiRY4lEC9Vj
 Ysuj+mpSydocp9V07Tq4dRV0rXtjwOhAVa31PxH9pxEHvcIuAOBgInfeyO3CSz5E30sE6/ilJ6
 emc=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Aug 2021 07:21:02 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 16/17] btrfs: zoned: finish fully written block group
Date:   Wed, 11 Aug 2021 23:16:40 +0900
Message-Id: <59c069e3890f3cbc7fa425cdcf756d241a8bfc92.1628690222.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628690222.git.naohiro.aota@wdc.com>
References: <cover.1628690222.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have written to the zone capacity, the device automatically
deactivates the zone. Sync up block group side (the active BG list and
zone_is_active flag) with it.

We need to do it both on data BGs and metadata BGs. On data side, we add a
hook to btrfs_finish_ordered_io(). On metadata side, we use
end_extent_buffer_writeback().

To reduce excess lookup of a block group, we mark the last extent buffer in
a block group with EXTENT_BUFFER_ZONE_FINISH flag. This cannot be done for
data (ordered_extent), because the address may change due to
REQ_OP_ZONE_APPEND.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 11 ++++++++-
 fs/btrfs/extent_io.h |  1 +
 fs/btrfs/inode.c     |  6 ++++-
 fs/btrfs/zoned.c     | 58 ++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h     |  8 ++++++
 5 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index aaddd7225348..c353bfd89dfc 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4155,6 +4155,9 @@ void wait_on_extent_buffer_writeback(struct extent_buffer *eb)
 
 static void end_extent_buffer_writeback(struct extent_buffer *eb)
 {
+	if (test_bit(EXTENT_BUFFER_ZONE_FINISH, &eb->bflags))
+		btrfs_zone_finish_endio(eb->fs_info, eb->start, eb->len);
+
 	clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
 	smp_mb__after_atomic();
 	wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
@@ -4756,8 +4759,14 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 		free_extent_buffer(eb);
 		return ret;
 	}
-	if (cache)
+	if (cache) {
+		/* Impiles write in zoned btrfs*/
 		btrfs_put_block_group(cache);
+		/* Mark the last eb in a block group */
+		if (cache->seq_zone &&
+		    eb->start + eb->len == cache->zone_capacity)
+			set_bit(EXTENT_BUFFER_ZONE_FINISH, &eb->bflags);
+	}
 	ret = write_one_eb(eb, wbc, epd);
 	free_extent_buffer(eb);
 	if (ret < 0)
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 53abdc280451..9f3e0a45a5e4 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -32,6 +32,7 @@ enum {
 	/* write IO error */
 	EXTENT_BUFFER_WRITE_ERR,
 	EXTENT_BUFFER_NO_CHECK,
+	EXTENT_BUFFER_ZONE_FINISH,
 };
 
 /* these are flags for __process_pages_contig */
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index afe9dcda860b..1697f745ba5c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3010,8 +3010,12 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
-	if (ordered_extent->bdev)
+	/* Non-null bdev implies a write on a sequential zone */
+	if (ordered_extent->bdev) {
 		btrfs_rewrite_logical_zoned(ordered_extent);
+		btrfs_zone_finish_endio(fs_info, ordered_extent->disk_bytenr,
+					logical_len);
+	}
 
 	btrfs_free_io_failure_record(inode, start, end);
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 850662d103e9..dd92e48b7f56 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1897,3 +1897,61 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices,
 
 	return ret;
 }
+
+int btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical,
+			    u64 length)
+{
+	struct btrfs_block_group *block_group;
+	struct map_lookup *map;
+	struct btrfs_device *device;
+	u64 physical;
+	int ret;
+
+	if (!btrfs_is_zoned(fs_info))
+		return 0;
+
+	block_group = btrfs_lookup_block_group(fs_info, logical);
+	ASSERT(block_group);
+
+	if (logical + length < block_group->start + block_group->zone_capacity) {
+		ret = 0;
+		goto out;
+	}
+
+	spin_lock(&block_group->lock);
+
+	if (!block_group->zone_is_active) {
+		spin_unlock(&block_group->lock);
+		ret = 0;
+		goto out;
+	}
+
+	block_group->zone_is_active = 0;
+	/* We should have consumed all the free space */
+	ASSERT(block_group->alloc_offset == block_group->zone_capacity);
+	ASSERT(block_group->free_space_ctl->free_space == 0);
+	btrfs_clear_treelog_bg(block_group);
+	spin_unlock(&block_group->lock);
+
+	map = block_group->physical_map;
+	device = map->stripes[0].dev;
+	physical = map->stripes[0].physical;
+
+	if (!device->zone_info->max_active_zones) {
+		ret = 0;
+		goto out;
+	}
+
+	btrfs_dev_clear_active_zone(device, physical);
+
+	spin_lock(&fs_info->zone_active_bgs_lock);
+	ASSERT(!list_empty(&block_group->active_bg_list));
+	list_del_init(&block_group->active_bg_list);
+	spin_unlock(&fs_info->zone_active_bgs_lock);
+
+	btrfs_put_block_group(block_group);
+
+out:
+	btrfs_put_block_group(block_group);
+	return ret;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index ade6588c4ccd..04a3ea884f3b 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -73,6 +73,8 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group);
 int btrfs_zone_finish(struct btrfs_block_group *block_group);
 bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices,
 			     int raid_index);
+int btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical,
+			    u64 length);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -224,6 +226,12 @@ static inline bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices,
 	return true;
 }
 
+static inline int btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info,
+					  u64 logical, u64 length)
+{
+	return 0;
+}
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.32.0

