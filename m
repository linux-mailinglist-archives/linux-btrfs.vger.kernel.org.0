Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C897340016E
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 16:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349337AbhICOqK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 10:46:10 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12649 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbhICOqD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Sep 2021 10:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630680303; x=1662216303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m6hv/4OZ8G39pKgWlH6xAh3CAio0uFL5AWu7lFvujPA=;
  b=nOI5YWLbZPZSKdovrxEfYCH1id7M/Er+2hLLngMATeGs4LeOR9J0gqR2
   nDyre/muVBm4e6sHvJamcthJ8R995ZTakRF4oniXl0reJFexxWd+YCThE
   kn0HzYZzYAwV7I7B8AP2SrxZrarPKBpPVRpFOd5svNPHAF5inqHyNhRk5
   p/6b2tpjxoAxgQ+Yqw1QUvI+jJN6e0b2J+jgVRA58B0ffWurCnbj6KVHN
   7TvT3a+BTkU08LUjhseAmD9xDKjcmJHMBqSTW9REgBh288eT35LBVpgdK
   1ZWX/ZK5gNuqUqY3DqaAgLv2JTBCt2Z9ftc5b2Tp848ZN9ih1D44QfF1M
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,265,1624291200"; 
   d="scan'208";a="179681175"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2021 22:45:03 +0800
IronPort-SDR: DDZMHebLY343daH7yGrFH/TnrAwS5l8HziZchwbDMhzTjShsjIZSikc9gNcHbNayWvskuWzz6c
 qF3XYnAG42yVa9TLMQZftTY8RzKtZQkYYGjCDk3shcbdZ025FH5M109zAz9s8MnYtiI/Coo3Rv
 6sX8RQzyVz6uTsQj4csvhps64CuMfuveAgSNhYJ7x9abej2/U88wFh06dsNaTg6+4pZhsZe6cg
 N6sX/3pDCsaQMm0ATPS/fhUFKHDQL92V34sjMNmQhMBrgTPAYiwJRV2Zl0drmhePtT+UzrRloe
 Nu95peQybbeLiwJjEbnmIOQ6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 07:20:06 -0700
IronPort-SDR: mbC7fmBfMEyUjlJCohFMf6JaIGDw22JaqT7txuMHC74usGKHpAPE1h1EIzotpqFbdKsNG58wAy
 p8eRbsJ+Q8MIOyitJ5WtCBvA1n28gudr4Y08REXhCRLYB50rMriNGBh+lDaWZpqhUzuOQP35qk
 g96AkeuM2x2opSPuSnzNKhQspLXlNGRyiBAXEgt8/0mONOwMVcmYmsK6kM1Keq7K8U1KWrDg+6
 nvx9Skp3iLhs6c0MDPx3NH7nsbDzwz3apsx+1m4yhG4X5nm61ReWnbo6iAbiRaSUNjXc1IQhBw
 SYw=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Sep 2021 07:45:02 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/6] btrfs: zoned: add a dedicated data relocation block group
Date:   Fri,  3 Sep 2021 23:44:43 +0900
Message-Id: <ac2e5fc11c47dfc3626999460f606b980b0f5523.1630679569.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1630679569.git.johannes.thumshirn@wdc.com>
References: <cover.1630679569.git.johannes.thumshirn@wdc.com>
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
---
 fs/btrfs/block-group.c |  1 +
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/disk-io.c     |  1 +
 fs/btrfs/extent-tree.c | 50 ++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/zoned.h       |  9 ++++++++
 5 files changed, 61 insertions(+), 2 deletions(-)

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
index 8cc0b29e24ee..344ba70315d8 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1017,6 +1017,8 @@ struct btrfs_fs_info {
 	struct mutex zoned_meta_io_lock;
 	spinlock_t treelog_bg_lock;
 	u64 treelog_bg;
+	spinlock_t relocation_bg_lock;
+	u64 data_reloc_bg;
 
 	spinlock_t zone_active_bgs_lock;
 	struct list_head zone_active_bgs;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9a6be409c1d6..5541bc6fe8a7 100644
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
index 239e09f7239a..644791150631 100644
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
 
@@ -3775,6 +3779,18 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	if (skip)
 		return 1;
 
+	/*
+	 * Do not allow non-relocation blocks in the dedicated relocation block
+	 * group, and vice versa.
+	 */
+	spin_lock(&fs_info->relocation_bg_lock);
+	data_reloc_bytenr = fs_info->data_reloc_bg;
+	skip = data_reloc_bytenr &&
+		((ffe_ctl->for_data_reloc && bytenr != data_reloc_bytenr) ||
+		 (!ffe_ctl->for_data_reloc && bytenr == data_reloc_bytenr));
+	spin_unlock(&fs_info->relocation_bg_lock);
+	if (skip)
+		return 1;
 	/* Check RO and no space case before trying to activate it */
 	spin_lock(&block_group->lock);
 	if (block_group->ro ||
@@ -3790,10 +3806,14 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
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
@@ -3810,6 +3830,16 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
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
@@ -3828,6 +3858,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	if (ffe_ctl->for_treelog && !fs_info->treelog_bg)
 		fs_info->treelog_bg = block_group->start;
 
+	if (ffe_ctl->for_data_reloc && !fs_info->data_reloc_bg)
+		fs_info->data_reloc_bg = block_group->start;
+
 	ffe_ctl->found_offset = start + block_group->alloc_offset;
 	block_group->alloc_offset += num_bytes;
 	spin_lock(&ctl->tree_lock);
@@ -3844,6 +3877,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 out:
 	if (ret && ffe_ctl->for_treelog)
 		fs_info->treelog_bg = 0;
+	if (ret && ffe_ctl->for_data_reloc)
+		fs_info->data_reloc_bg = 0;
+	spin_unlock(&fs_info->relocation_bg_lock);
 	spin_unlock(&fs_info->treelog_bg_lock);
 	spin_unlock(&block_group->lock);
 	spin_unlock(&space_info->lock);
@@ -4112,6 +4148,12 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
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
@@ -4245,6 +4287,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		if (unlikely(block_group->ro)) {
 			if (ffe_ctl->for_treelog)
 				btrfs_clear_treelog_bg(block_group);
+			if (ffe_ctl->for_data_reloc)
+				btrfs_clear_data_reloc_bg(block_group);
 			continue;
 		}
 
@@ -4438,6 +4482,7 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 	u64 flags;
 	int ret;
 	bool for_treelog = (root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID);
+	bool for_data_reloc = (btrfs_is_data_reloc_root(root) && is_data);
 
 	flags = get_alloc_profile_by_root(root, is_data);
 again:
@@ -4451,6 +4496,7 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 	ffe_ctl.delalloc = delalloc;
 	ffe_ctl.hint_byte = hint_byte;
 	ffe_ctl.for_treelog = for_treelog;
+	ffe_ctl.for_data_reloc = for_data_reloc;
 
 	ret = find_free_extent(root, ins, &ffe_ctl);
 	if (!ret && !is_data) {
@@ -4470,8 +4516,8 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 
 			sinfo = btrfs_find_space_info(fs_info, flags);
 			btrfs_err(fs_info,
-			"allocation failed flags %llu, wanted %llu tree-log %d",
-				  flags, num_bytes, for_treelog);
+			"allocation failed flags %llu, wanted %llu tree-log %d, relocation: %d",
+				  flags, num_bytes, for_treelog, for_data_reloc);
 			if (sinfo)
 				btrfs_dump_space_info(fs_info, sinfo,
 						      num_bytes, 1);
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 9c512402d7f4..1cf87bb1db08 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -347,4 +347,13 @@ static inline void btrfs_clear_treelog_bg(struct btrfs_block_group *bg)
 	spin_unlock(&fs_info->treelog_bg_lock);
 }
 
+static inline void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+
+	spin_lock(&fs_info->relocation_bg_lock);
+	if (fs_info->data_reloc_bg == bg->start)
+		fs_info->data_reloc_bg = 0;
+	spin_unlock(&fs_info->relocation_bg_lock);
+}
 #endif
-- 
2.32.0

