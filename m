Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593B23F1933
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 14:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239474AbhHSM2F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 08:28:05 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46903 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239438AbhHSM2B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629376045; x=1660912045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sv9X4xoExeqETaSflvJF1lYEUrvqKjq1BuN8b6U+ZIM=;
  b=N4gVHIg8wZXiqZUxVbKBwcAbfcTPXKNJwGC7WN6ovWq6kUYuqRDhTjv1
   UtanOs6ft56UcXPr+zB0zva2w3VzCXZaeB4k3LB+ffR6qXUGKzbmTmG5n
   CqFHx7/E1wtujaTAtSz5IUWreHAgQx0fgBY3ErPgGvWSpgGf3u+6imEYB
   +G6ygXUyJO5L6g8s2kHGlsfMEK9ZFqX/8Jn99gZAbalc5HvV9Ahqlg6jU
   i0q7K1CjgASccPbitv4DQh0soJcmxV1G63wRJ0+aOe76mJgOZ0/sCsNPN
   L1hRQggkPq6WI1KgTVHjLGNaa82GNFHzIT2JZZiSoatq8E68imMWSw/r0
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,334,1620662400"; 
   d="scan'208";a="177773633"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2021 20:27:25 +0800
IronPort-SDR: zx1ZrWHuIQ5yoNpvs+IVN0JtnkukrbRSfSZFamTNo2UvfdsgMBj5707w+PZ6cVss9U5i+S6nlE
 h1d6fzrQybBLxPENfuvk8ALZ1E5BXPdVdPDqOXSBOrSI92X+oioPM7/XIx4o1ou5kN9DOdoIDu
 107Ud2zDrdCRe71K4mmRBMNNDTB7ZFrkpsOIaHZWyaavwUZQzTR4m1ohIEMDpU9N/Flir09Ceh
 jy7I7CbW90toU2twm/wEagSAYLcmmALWd2S4t4RmqA05BnAzf9HJQPWjub2ICx1L3y5+lW0Y/Z
 4gamb81QO/9QKG3Tcq4hhO1B
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 05:04:33 -0700
IronPort-SDR: q8KJ36jmwUBfUirJN7D+nSgPSWO5qPXhXdVfkNK/MFwdkIzZJ54ARCnF3DPWLXYluhCEuaSKYf
 BlHzFBnqP9F1FhPiCLtvkGPzLqKDisr2oAD+CrOR4jhNEghBz76Pl6HzS1jlSQogC78bnaf3qv
 lNpZfnU2/vuZPPNGtYbOIXSNQ9IhFYkM+cRmmuVzHU2qPI2tSDYlJRNFeSyT2AfFKrOrWk6I4d
 ANmXW7VRpEDbDUvbL3F9xPMMiv/kQ/HAiwQw5HSeXxcSegv2pYPHr1Rmgr/qWUZ9EqroOiOsnM
 1g4=
WDCIronportException: Internal
Received: from gkg9hr2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.52.110])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2021 05:27:24 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 16/17] btrfs: zoned: finish fully written block group
Date:   Thu, 19 Aug 2021 21:19:23 +0900
Message-Id: <8ed0671f9a06acdc14dff407ed8009e835a478c4.1629349224.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1629349224.git.naohiro.aota@wdc.com>
References: <cover.1629349224.git.naohiro.aota@wdc.com>
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
 fs/btrfs/extent_io.c | 11 +++++++++-
 fs/btrfs/extent_io.h |  1 +
 fs/btrfs/inode.c     |  6 +++++-
 fs/btrfs/zoned.c     | 51 ++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h     |  5 +++++
 5 files changed, 72 insertions(+), 2 deletions(-)

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
index 2aa9646bce56..a72992c4b88f 100644
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
+					ordered_extent->disk_num_bytes);
+	}
 
 	btrfs_free_io_failure_record(inode, start, end);
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 74f98d38abcc..90dd49def00e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1910,3 +1910,54 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices,
 
 	return ret;
 }
+
+void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical,
+			     u64 length)
+{
+	struct btrfs_block_group *block_group;
+	struct map_lookup *map;
+	struct btrfs_device *device;
+	u64 physical;
+
+	if (!btrfs_is_zoned(fs_info))
+		return;
+
+	block_group = btrfs_lookup_block_group(fs_info, logical);
+	ASSERT(block_group);
+
+	if (logical + length < block_group->start + block_group->zone_capacity)
+		goto out;
+
+	spin_lock(&block_group->lock);
+
+	if (!block_group->zone_is_active) {
+		spin_unlock(&block_group->lock);
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
+	if (!device->zone_info->max_active_zones)
+		goto out;
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
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index ade6588c4ccd..9c512402d7f4 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -73,6 +73,8 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group);
 int btrfs_zone_finish(struct btrfs_block_group *block_group);
 bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices,
 			     int raid_index);
+void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical,
+			     u64 length);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -224,6 +226,9 @@ static inline bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices,
 	return true;
 }
 
+static inline void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info,
+					   u64 logical, u64 length) { }
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.33.0

