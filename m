Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BDA403D7A
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 18:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348380AbhIHQUx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 12:20:53 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:3327 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348763AbhIHQUw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Sep 2021 12:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631117984; x=1662653984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2/FxjR6XDJ5bZutArlH6O+Su+BwNABwdsCO8gqqA+9A=;
  b=okI7VQbOySfxWib8GmNqjhcXBloA6LImsioWe1Mg/bfGbJNmPXPWscuY
   K7gzwxVq3Iqa9+/Oz/YwVdf/iYp9VjSg8xmVpRktcZrzFu6alP97a7Knv
   esBOgbRkOPCh/HPUmlw/Sg5pdRAwFTg5i8vpuMZulM9jNYIsZ+VDrtMI3
   7FBdP1tesQSS8PCH8o7RCAbLNSqvE6CNYJYBeByWWo+7aRmRLF+dAiwWL
   Vljxjv7RwcvRCtY1BBvUQ9omN27VP0tCQWitlOgjt6CM0VJXjBKpvkO3e
   MlNPiLLxoATZaawfeo/qCsTwcSULYj5sd26UPn2wBE/nNgEmDpSW52ryS
   A==;
X-IronPort-AV: E=Sophos;i="5.85,278,1624291200"; 
   d="scan'208";a="179493936"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2021 00:19:44 +0800
IronPort-SDR: 5Uzn1x8hMWkglPBLoGFtsBe7jxG+9ou50ibRDawKGpL83z2PUKd8+u91nd2nafu7geol8KOz7Y
 RsD4GdnqYZOOt9kzwZUY6kn8W3VTP1eju+eWg+Xp/7L/S99O/YOvHhxk2H6fPjOaXanQrGuvrD
 cpOb8RXrbUkZyfKTnvTmyOxBqesNm0Aer0pNDj8CrGQNx9jtr0Pb+0TqRlbLpqCQepe+fFSvOZ
 AI1f6i/iDA/KI7+JII0BX6agBE+gIig7TQo50YlUdecFMWq+9S1O7Tz8ta2k0A0t/md5SOK2dm
 6iAOzMHyYKCS06dDkxQxWWGp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 08:54:41 -0700
IronPort-SDR: 9UcqUa/tzRMxbjNOVraLz3VVbaKO5o+/Qhaa83vVDAA7g3zD+judJhTSOHkYJUBl1CWfp3fYUJ
 GFZ2SMpsVEV8/KlwXKci+3cRKoLGVS6ax57RziDf5A7q0dcod7UCTikIkzjXOmz1uu7fWcPQZc
 MoG0rPdm1n88PJq+0P5+JJ5G9aTECCBP6N2BwF76g6xRv/dh61GzHYNHUY/2gQFSVfZ/pdJ77q
 v82zJB3PJ1axZSGzfpe5OoUxxVnOZNim80wQQ4ihFof64vTSSfvWnP3Kbyr0VXGybskcqrmVxI
 3No=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Sep 2021 09:19:44 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 2/8] btrfs: zoned: add a dedicated data relocation block group
Date:   Thu,  9 Sep 2021 01:19:26 +0900
Message-Id: <f6720da8b776ab5b6c20fb75989b230d22cde0ae.1631117101.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1631117101.git.johannes.thumshirn@wdc.com>
References: <cover.1631117101.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Relocation in a zoned filesystem can fail with a transaction abort with
error -22 (EINVAL). This happens because the relocation code assumes that
the extents we relocated the data to have the same size the source extents
had and ensures this by preallocating the extents.

But in a zoned filesystem we currently can't preallocate the extents as
this would break the sequential write required rule. Therefore it can
happen that the writeback process kicks in while we're still adding pages
to a delallocation range and starts writing out dirty pages.

This then creates destination extents that are smaller than the source
extents, triggering the following safety check in get_new_location():

 1034         if (num_bytes != btrfs_file_extent_disk_num_bytes(leaf, fi)) {
 1035                 ret = -EINVAL;
 1036                 goto out;
 1037         }

Temporarily create a dedicated block group for the relocation process, so
no non-relocation data writes can interfere with the relocation writes.

This is needed that we can switch the relocation process on a zoned
filesystem from the REQ_OP_ZONE_APPEND writing we use for data to a scheme
like in a non-zoned filesystem using REQ_OP_WRITE and preallocation.

Fixes: 32430c614844 ("btrfs: zoned: enable relocation on a zoned filesystem")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |  1 +
 fs/btrfs/ctree.h       |  7 ++++++
 fs/btrfs/disk-io.c     |  1 +
 fs/btrfs/extent-tree.c | 51 ++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/zoned.c       | 10 +++++++++
 fs/btrfs/zoned.h       |  4 +++-
 6 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 1302bf8d0be1..46fdef7bbe20 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -903,6 +903,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	spin_unlock(&cluster->refill_lock);
 
 	btrfs_clear_treelog_bg(block_group);
+	btrfs_clear_data_reloc_bg(block_group);
 
 	path = btrfs_alloc_path();
 	if (!path) {
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8cc0b29e24ee..2e2f87a6c5f4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1018,6 +1018,13 @@ struct btrfs_fs_info {
 	spinlock_t treelog_bg_lock;
 	u64 treelog_bg;
 
+	/*
+	 * Start of the dedicated data relocation block-group, protected by
+	 * relocation_bg_lock.
+	 */
+	spinlock_t relocation_bg_lock;
+	u64 data_reloc_bg;
+
 	spinlock_t zone_active_bgs_lock;
 	struct list_head zone_active_bgs;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d63c5e776a96..be382276d24f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2885,6 +2885,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	spin_lock_init(&fs_info->unused_bgs_lock);
 	spin_lock_init(&fs_info->treelog_bg_lock);
 	spin_lock_init(&fs_info->zone_active_bgs_lock);
+	spin_lock_init(&fs_info->relocation_bg_lock);
 	rwlock_init(&fs_info->tree_mod_log_lock);
 	mutex_init(&fs_info->unused_bg_unpin_mutex);
 	mutex_init(&fs_info->reclaim_bgs_lock);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 239e09f7239a..708dc6492f97 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3497,6 +3497,9 @@ struct find_free_extent_ctl {
 	/* Allocation is called for tree-log */
 	bool for_treelog;
 
+	/* Allocation is called for data relocation */
+	bool for_data_reloc;
+
 	/* RAID index, converted from flags */
 	int index;
 
@@ -3758,6 +3761,7 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	u64 avail;
 	u64 bytenr = block_group->start;
 	u64 log_bytenr;
+	u64 data_reloc_bytenr;
 	int ret = 0;
 	bool skip;
 
@@ -3775,6 +3779,19 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	if (skip)
 		return 1;
 
+	/*
+	 * Do not allow non-relocation blocks in the dedicated relocation block
+	 * group, and vice versa.
+	 */
+	spin_lock(&fs_info->relocation_bg_lock);
+	data_reloc_bytenr = fs_info->data_reloc_bg;
+	if (data_reloc_bytenr &&
+	    ((ffe_ctl->for_data_reloc && bytenr != data_reloc_bytenr) ||
+	     (!ffe_ctl->for_data_reloc && bytenr == data_reloc_bytenr)))
+		skip = true;
+	spin_unlock(&fs_info->relocation_bg_lock);
+	if (skip)
+		return 1;
 	/* Check RO and no space case before trying to activate it */
 	spin_lock(&block_group->lock);
 	if (block_group->ro ||
@@ -3790,10 +3807,14 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
 	spin_lock(&fs_info->treelog_bg_lock);
+	spin_lock(&fs_info->relocation_bg_lock);
 
 	ASSERT(!ffe_ctl->for_treelog ||
 	       block_group->start == fs_info->treelog_bg ||
 	       fs_info->treelog_bg == 0);
+	ASSERT(!ffe_ctl->for_data_reloc ||
+	       block_group->start == fs_info->data_reloc_bg ||
+	       fs_info->data_reloc_bg == 0);
 
 	if (block_group->ro) {
 		ret = 1;
@@ -3810,6 +3831,16 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 		goto out;
 	}
 
+	/*
+	 * Do not allow currently used block group to be the data relocation
+	 * dedicated block group.
+	 */
+	if (ffe_ctl->for_data_reloc && !fs_info->data_reloc_bg &&
+	    (block_group->used || block_group->reserved)) {
+		ret = 1;
+		goto out;
+	}
+
 	WARN_ON_ONCE(block_group->alloc_offset > block_group->zone_capacity);
 	avail = block_group->zone_capacity - block_group->alloc_offset;
 	if (avail < num_bytes) {
@@ -3828,6 +3859,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	if (ffe_ctl->for_treelog && !fs_info->treelog_bg)
 		fs_info->treelog_bg = block_group->start;
 
+	if (ffe_ctl->for_data_reloc && !fs_info->data_reloc_bg)
+		fs_info->data_reloc_bg = block_group->start;
+
 	ffe_ctl->found_offset = start + block_group->alloc_offset;
 	block_group->alloc_offset += num_bytes;
 	spin_lock(&ctl->tree_lock);
@@ -3844,6 +3878,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 out:
 	if (ret && ffe_ctl->for_treelog)
 		fs_info->treelog_bg = 0;
+	if (ret && ffe_ctl->for_data_reloc)
+		fs_info->data_reloc_bg = 0;
+	spin_unlock(&fs_info->relocation_bg_lock);
 	spin_unlock(&fs_info->treelog_bg_lock);
 	spin_unlock(&block_group->lock);
 	spin_unlock(&space_info->lock);
@@ -4112,6 +4149,12 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
 				ffe_ctl->hint_byte = fs_info->treelog_bg;
 			spin_unlock(&fs_info->treelog_bg_lock);
 		}
+		if (ffe_ctl->for_data_reloc) {
+			spin_lock(&fs_info->relocation_bg_lock);
+			if (fs_info->data_reloc_bg)
+				ffe_ctl->hint_byte = fs_info->data_reloc_bg;
+			spin_unlock(&fs_info->relocation_bg_lock);
+		}
 		return 0;
 	default:
 		BUG();
@@ -4245,6 +4288,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		if (unlikely(block_group->ro)) {
 			if (ffe_ctl->for_treelog)
 				btrfs_clear_treelog_bg(block_group);
+			if (ffe_ctl->for_data_reloc)
+				btrfs_clear_data_reloc_bg(block_group);
 			continue;
 		}
 
@@ -4438,6 +4483,7 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 	u64 flags;
 	int ret;
 	bool for_treelog = (root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID);
+	bool for_data_reloc = (btrfs_is_data_reloc_root(root) && is_data);
 
 	flags = get_alloc_profile_by_root(root, is_data);
 again:
@@ -4451,6 +4497,7 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 	ffe_ctl.delalloc = delalloc;
 	ffe_ctl.hint_byte = hint_byte;
 	ffe_ctl.for_treelog = for_treelog;
+	ffe_ctl.for_data_reloc = for_data_reloc;
 
 	ret = find_free_extent(root, ins, &ffe_ctl);
 	if (!ret && !is_data) {
@@ -4470,8 +4517,8 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 
 			sinfo = btrfs_find_space_info(fs_info, flags);
 			btrfs_err(fs_info,
-			"allocation failed flags %llu, wanted %llu tree-log %d",
-				  flags, num_bytes, for_treelog);
+			"allocation failed flags %llu, wanted %llu tree-log %d, relocation: %d",
+				  flags, num_bytes, for_treelog, for_data_reloc);
 			if (sinfo)
 				btrfs_dump_space_info(fs_info, sinfo,
 						      num_bytes, 1);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 28a06c2d80ad..c7fe3e11e685 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1954,3 +1954,13 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, u64 len
 out:
 	btrfs_put_block_group(block_group);
 }
+
+void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+
+	spin_lock(&fs_info->relocation_bg_lock);
+	if (fs_info->data_reloc_bg == bg->start)
+		fs_info->data_reloc_bg = 0;
+	spin_unlock(&fs_info->relocation_bg_lock);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 9c512402d7f4..0cec8d4050b4 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -75,6 +75,7 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices,
 			     int raid_index);
 void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical,
 			     u64 length);
+void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -229,6 +230,8 @@ static inline bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices,
 static inline void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info,
 					   u64 logical, u64 length) { }
 
+static inline void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg) { }
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
@@ -346,5 +349,4 @@ static inline void btrfs_clear_treelog_bg(struct btrfs_block_group *bg)
 		fs_info->treelog_bg = 0;
 	spin_unlock(&fs_info->treelog_bg_lock);
 }
-
 #endif
-- 
2.32.0

