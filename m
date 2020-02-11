Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65B1515895D
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 06:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgBKFMN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 00:12:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:44598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbgBKFMM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 00:12:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D48D8AF76
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2020 05:12:10 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v7 3/5] btrfs: statfs: Use pre-calculated per-profile available space
Date:   Tue, 11 Feb 2020 13:11:51 +0800
Message-Id: <20200211051153.19466-4-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211051153.19466-1-wqu@suse.com>
References: <20200211051153.19466-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although btrfs_calc_avail_data_space() is trying to do an estimation
on how many data chunks it can allocate, the estimation is far from
perfect:

- Metadata over-commit is not considered at all
- Chunk allocation doesn't take RAID5/6 into consideration

This patch will change btrfs_calc_avail_data_space() to use
pre-calculated per-profile available space.

This provides the following benefits:
- Accurate unallocated data space estimation
  It's as accurate as chunk allocator, and can handle RAID5/6 and newly
  introduced RAID1C3/C4.

For the metadata over-commit part, we don't take that into consideration
yet. As metadata over-commit only happens when we have enough
unallocated space, and under most case we won't use that much metadata
space at all.

And we still have the existing 0-available space check, to prevent us
from reporting too optimistic f_bavail result.

Since we're keeping the old lock-free design, statfs should not experience
any extra delay.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 133 ++++-------------------------------------------
 1 file changed, 9 insertions(+), 124 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 0616a5434793..0e53f39e2d29 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1921,124 +1921,6 @@ static inline void btrfs_descending_sort_devices(
 	     btrfs_cmp_device_free_bytes, NULL);
 }
 
-/*
- * The helper to calc the free space on the devices that can be used to store
- * file data.
- */
-static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
-					      u64 *free_bytes)
-{
-	struct btrfs_device_info *devices_info;
-	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
-	struct btrfs_device *device;
-	u64 type;
-	u64 avail_space;
-	u64 min_stripe_size;
-	int num_stripes = 1;
-	int i = 0, nr_devices;
-	const struct btrfs_raid_attr *rattr;
-
-	/*
-	 * We aren't under the device list lock, so this is racy-ish, but good
-	 * enough for our purposes.
-	 */
-	nr_devices = fs_info->fs_devices->open_devices;
-	if (!nr_devices) {
-		smp_mb();
-		nr_devices = fs_info->fs_devices->open_devices;
-		ASSERT(nr_devices);
-		if (!nr_devices) {
-			*free_bytes = 0;
-			return 0;
-		}
-	}
-
-	devices_info = kmalloc_array(nr_devices, sizeof(*devices_info),
-			       GFP_KERNEL);
-	if (!devices_info)
-		return -ENOMEM;
-
-	/* calc min stripe number for data space allocation */
-	type = btrfs_data_alloc_profile(fs_info);
-	rattr = &btrfs_raid_array[btrfs_bg_flags_to_raid_index(type)];
-
-	if (type & BTRFS_BLOCK_GROUP_RAID0)
-		num_stripes = nr_devices;
-	else if (type & BTRFS_BLOCK_GROUP_RAID1)
-		num_stripes = 2;
-	else if (type & BTRFS_BLOCK_GROUP_RAID1C3)
-		num_stripes = 3;
-	else if (type & BTRFS_BLOCK_GROUP_RAID1C4)
-		num_stripes = 4;
-	else if (type & BTRFS_BLOCK_GROUP_RAID10)
-		num_stripes = 4;
-
-	/* Adjust for more than 1 stripe per device */
-	min_stripe_size = rattr->dev_stripes * BTRFS_STRIPE_LEN;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
-		if (!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
-						&device->dev_state) ||
-		    !device->bdev ||
-		    test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state))
-			continue;
-
-		if (i >= nr_devices)
-			break;
-
-		avail_space = device->total_bytes - device->bytes_used;
-
-		/* align with stripe_len */
-		avail_space = rounddown(avail_space, BTRFS_STRIPE_LEN);
-
-		/*
-		 * In order to avoid overwriting the superblock on the drive,
-		 * btrfs starts at an offset of at least 1MB when doing chunk
-		 * allocation.
-		 *
-		 * This ensures we have at least min_stripe_size free space
-		 * after excluding 1MB.
-		 */
-		if (avail_space <= SZ_1M + min_stripe_size)
-			continue;
-
-		avail_space -= SZ_1M;
-
-		devices_info[i].dev = device;
-		devices_info[i].max_avail = avail_space;
-
-		i++;
-	}
-	rcu_read_unlock();
-
-	nr_devices = i;
-
-	btrfs_descending_sort_devices(devices_info, nr_devices);
-
-	i = nr_devices - 1;
-	avail_space = 0;
-	while (nr_devices >= rattr->devs_min) {
-		num_stripes = min(num_stripes, nr_devices);
-
-		if (devices_info[i].max_avail >= min_stripe_size) {
-			int j;
-			u64 alloc_size;
-
-			avail_space += devices_info[i].max_avail * num_stripes;
-			alloc_size = devices_info[i].max_avail;
-			for (j = i + 1 - num_stripes; j <= i; j++)
-				devices_info[j].max_avail -= alloc_size;
-		}
-		i--;
-		nr_devices--;
-	}
-
-	kfree(devices_info);
-	*free_bytes = avail_space;
-	return 0;
-}
-
 /*
  * Calculate numbers for 'df', pessimistic in case of mixed raid profiles.
  *
@@ -2055,6 +1937,7 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(dentry->d_sb);
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_super_block *disk_super = fs_info->super_copy;
 	struct btrfs_space_info *found;
 	u64 total_used = 0;
@@ -2064,7 +1947,7 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	__be32 *fsid = (__be32 *)fs_info->fs_devices->fsid;
 	unsigned factor = 1;
 	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
-	int ret;
+	enum btrfs_raid_types data_type;
 	u64 thresh = 0;
 	int mixed = 0;
 
@@ -2113,11 +1996,13 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 		buf->f_bfree = 0;
 	spin_unlock(&block_rsv->lock);
 
-	buf->f_bavail = div_u64(total_free_data, factor);
-	ret = btrfs_calc_avail_data_space(fs_info, &total_free_data);
-	if (ret)
-		return ret;
-	buf->f_bavail += div_u64(total_free_data, factor);
+	data_type = btrfs_bg_flags_to_raid_index(
+			btrfs_data_alloc_profile(fs_info));
+
+	spin_lock(&fs_devices->per_profile_lock);
+	buf->f_bavail = fs_devices->per_profile_avail[data_type] +
+			total_free_data;
+	spin_unlock(&fs_devices->per_profile_lock);
 	buf->f_bavail = buf->f_bavail >> bits;
 
 	/*
-- 
2.25.0

