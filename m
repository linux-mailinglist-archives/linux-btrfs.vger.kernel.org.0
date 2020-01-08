Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25F94133C00
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 08:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgAHHF0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 02:05:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:56232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgAHHF0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jan 2020 02:05:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5BEEAADFE
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jan 2020 07:05:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 3/3] btrfs: statfs: Use virtual chunk allocation to calculation available data space
Date:   Wed,  8 Jan 2020 15:05:09 +0800
Message-Id: <20200108070509.25483-4-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108070509.25483-1-wqu@suse.com>
References: <20200108070509.25483-1-wqu@suse.com>
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
- Accurate unallocated data space estimation, including RAID5/6
  It's as accurate as chunk allocator, and can handle RAID5/6.

Although it still can't handle metadata over-commit that accurately, we
still have fallback method for over-commit, by using factor based
estimation.

The good news is, over-commit can only happen when we have enough
unallocated space, so even we may not report byte accurate result when
the fs is empty, the result will get more and more accurate when
unallocated space is reducing.

So the metadata over-commit shouldn't cause too many problem.

Since we're keeping the old lock-free design, statfs should not experience
any extra delay.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c   | 174 +++++++++++----------------------------------
 fs/btrfs/volumes.h |   4 ++
 2 files changed, 47 insertions(+), 131 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f452a94abdc3..ecca25c40637 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1894,118 +1894,53 @@ static inline void btrfs_descending_sort_devices(
  * The helper to calc the free space on the devices that can be used to store
  * file data.
  */
-static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
-					      u64 *free_bytes)
+static u64 btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
+				       u64 free_meta)
 {
-	struct btrfs_device_info *devices_info;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
-	struct btrfs_device *device;
-	u64 type;
-	u64 avail_space;
-	u64 min_stripe_size;
-	int num_stripes = 1;
-	int i = 0, nr_devices;
-	const struct btrfs_raid_attr *rattr;
+	enum btrfs_raid_types data_type;
+	u64 data_profile = btrfs_data_alloc_profile(fs_info);
+	u64 data_avail;
+	u64 meta_rsv;
 
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
+	spin_lock(&fs_info->global_block_rsv.lock);
+	meta_rsv = fs_info->global_block_rsv.size;
+	spin_unlock(&fs_info->global_block_rsv.lock);
 
-	/* Adjust for more than 1 stripe per device */
-	min_stripe_size = rattr->dev_stripes * BTRFS_STRIPE_LEN;
+	data_type = btrfs_bg_flags_to_raid_index(data_profile);
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
-		if (!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
-						&device->dev_state) ||
-		    !device->bdev ||
-		    test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state))
-			continue;
+	spin_lock(&fs_devices->per_profile_lock);
+	data_avail = fs_devices->per_profile_avail[data_type];
+	spin_unlock(&fs_devices->per_profile_lock);
 
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
+	/*
+	 * We have meta over-committed, do some wild guess using factor.
+	 *
+	 * To get an accurate result, we should allocate a metadata virtual
+	 * chunk first, then allocate data virtual chunks to get real
+	 * estimation.
+	 * But that needs chunk_mutex, which could be very slow to accquire.
+	 *
+	 * So here we trade for non-blocking statfs. And meta over-committing is
+	 * less a problem because:
+	 * - Meta over-commit only happens when we have unallocated space
+	 *   So no over-commit if we're low on available space.
+	 *
+	 * This may not be as accurate as virtual chunk based one, but it
+	 * should be good enough for statfs usage.
+	 */
+	if (free_meta < meta_rsv) {
+		u64 meta_needed = meta_rsv - free_meta;
+		int data_factor = btrfs_bg_type_to_factor(data_profile);
+		int meta_factor = btrfs_bg_type_to_factor(
+				btrfs_metadata_alloc_profile(fs_info));
+
+		if (data_avail < meta_needed * meta_factor / data_factor)
+			data_avail = 0;
+		else
+			data_avail -= meta_needed * meta_factor / data_factor;
 	}
-
-	kfree(devices_info);
-	*free_bytes = avail_space;
-	return 0;
+	return data_avail;
 }
 
 /*
@@ -2033,8 +1968,6 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	__be32 *fsid = (__be32 *)fs_info->fs_devices->fsid;
 	unsigned factor = 1;
 	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
-	int ret;
-	u64 thresh = 0;
 	int mixed = 0;
 
 	rcu_read_lock();
@@ -2082,31 +2015,10 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 		buf->f_bfree = 0;
 	spin_unlock(&block_rsv->lock);
 
-	buf->f_bavail = div_u64(total_free_data, factor);
-	ret = btrfs_calc_avail_data_space(fs_info, &total_free_data);
-	if (ret)
-		return ret;
-	buf->f_bavail += div_u64(total_free_data, factor);
+	buf->f_bavail = btrfs_calc_avail_data_space(fs_info, total_free_meta);
+	if (buf->f_bavail > 0)
+		buf->f_bavail += total_free_data;
 	buf->f_bavail = buf->f_bavail >> bits;
-
-	/*
-	 * We calculate the remaining metadata space minus global reserve. If
-	 * this is (supposedly) smaller than zero, there's no space. But this
-	 * does not hold in practice, the exhausted state happens where's still
-	 * some positive delta. So we apply some guesswork and compare the
-	 * delta to a 4M threshold.  (Practically observed delta was ~2M.)
-	 *
-	 * We probably cannot calculate the exact threshold value because this
-	 * depends on the internal reservations requested by various
-	 * operations, so some operations that consume a few metadata will
-	 * succeed even if the Avail is zero. But this is better than the other
-	 * way around.
-	 */
-	thresh = SZ_4M;
-
-	if (!mixed && total_free_meta - thresh < block_rsv->size)
-		buf->f_bavail = 0;
-
 	buf->f_type = BTRFS_SUPER_MAGIC;
 	buf->f_bsize = dentry->d_sb->s_blocksize;
 	buf->f_namelen = BTRFS_NAME_LEN;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 5cddfe7cfee8..0b4fe2603b0e 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -460,6 +460,10 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
 		      struct btrfs_device *device, u64 new_size);
 struct btrfs_device *btrfs_find_device(struct btrfs_fs_devices *fs_devices,
 				       u64 devid, u8 *uuid, u8 *fsid, bool seed);
+int btrfs_alloc_virtual_chunk(struct btrfs_fs_info *fs_info,
+			      struct btrfs_device_info *devices_info,
+			      enum btrfs_raid_types type,
+			      u64 to_alloc, u64 *allocated);
 int btrfs_shrink_device(struct btrfs_device *device, u64 new_size);
 int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *path);
 int btrfs_balance(struct btrfs_fs_info *fs_info,
-- 
2.24.1

