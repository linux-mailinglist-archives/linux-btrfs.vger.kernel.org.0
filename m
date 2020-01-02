Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD80212E5A7
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 12:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgABL2I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 06:28:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:43216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbgABL2I (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jan 2020 06:28:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 03807B217
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jan 2020 11:28:05 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/4] btrfs: statfs: Use virtual chunk allocation to calculation available data space
Date:   Thu,  2 Jan 2020 19:27:46 +0800
Message-Id: <20200102112746.145045-5-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102112746.145045-1-wqu@suse.com>
References: <20200102112746.145045-1-wqu@suse.com>
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

Although current per-profile available space itself is not able to
handle metadata over-commit itself, the virtual chunk infrastructure can
be re-used to address above problems.

This patch will change btrfs_calc_avail_data_space() to do the following
things:
- Do metadata virtual chunk allocation first
  This is to address the over-commit behavior.
  If current metadata chunks have enough free space, we can completely
  skip this step.

- Allocate data virtual chunks as many as possible
  Just like what we did in per-profile available space estimation.
  Here we only need to calculate one profile, since statfs() call is
  a relative cold path.

Now statfs() should be able to report near perfect estimation on
available data space, and can handle RAID5/6 better.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c   | 190 ++++++++++++++++-----------------------------
 fs/btrfs/volumes.c |  12 +--
 fs/btrfs/volumes.h |   4 +
 3 files changed, 79 insertions(+), 127 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f452a94abdc3..718ff54b62f0 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1893,119 +1893,88 @@ static inline void btrfs_descending_sort_devices(
 /*
  * The helper to calc the free space on the devices that can be used to store
  * file data.
+ *
+ * The calculation will:
+ * - Allocate enough metadata virtual chunks to fulfill over-commit
+ *   To ensure we still have enough space to contain metadata chunks
+ * - Allocate any many data virtual chunks as possible
+ *   To get a true estimation on available data free space.
+ *
+ * Only with such comprehensive check, we can get a good result considering
+ * all the uneven disk layouts.
  */
 static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
-					      u64 *free_bytes)
+					      u64 free_meta, u64 *result)
 {
 	struct btrfs_device_info *devices_info;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_device *device;
-	u64 type;
-	u64 avail_space;
-	u64 min_stripe_size;
-	int num_stripes = 1;
-	int i = 0, nr_devices;
-	const struct btrfs_raid_attr *rattr;
+	u64 meta_index;
+	u64 data_index;
+	u64 meta_rsv;
+	u64 meta_allocated = 0;
+	u64 data_allocated = 0;
+	u64 allocated;
+	int nr_devices;
+	int ret = 0;
 
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
+	spin_lock(&fs_info->global_block_rsv.lock);
+	meta_rsv = fs_info->global_block_rsv.size;
+	spin_unlock(&fs_info->global_block_rsv.lock);
 
+	mutex_lock(&fs_devices->device_list_mutex);
+	nr_devices = fs_devices->rw_devices;
 	devices_info = kmalloc_array(nr_devices, sizeof(*devices_info),
 			       GFP_KERNEL);
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
+	if (!devices_info) {
+		ret = -ENOMEM;
+		goto out;
 	}
-	rcu_read_unlock();
-
-	nr_devices = i;
 
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
+	data_index = btrfs_bg_flags_to_raid_index(
+			btrfs_data_alloc_profile(fs_info));
+	meta_index = btrfs_bg_flags_to_raid_index(
+			btrfs_metadata_alloc_profile(fs_info));
+
+	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list)
+		device->virtual_allocated = 0;
+
+	/* Current metadata space is enough, no need to bother meta space */
+	if (meta_rsv <= free_meta)
+		goto data_only;
+
+	/* Allocate space for exceeding meta space */
+	while (meta_allocated < meta_rsv - free_meta) {
+		ret = btrfs_alloc_virtual_chunk(fs_info, devices_info,
+				meta_index,
+				meta_rsv - free_meta - meta_allocated,
+				&allocated);
+		if (ret < 0)
+			goto out;
+		meta_allocated += allocated;
+	}
+data_only:
+	/*
+	 * meta virtual chunks have been allocated, now allocate data virtual
+	 * chunks
+	 */
+	while (ret == 0) {
+		ret = btrfs_alloc_virtual_chunk(fs_info, devices_info,
+				data_index, -1, &allocated);
+		if (ret < 0)
+			goto out;
+		data_allocated += allocated;
 	}
 
+out:
+	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list)
+		device->virtual_allocated = 0;
+	mutex_unlock(&fs_devices->device_list_mutex);
 	kfree(devices_info);
-	*free_bytes = avail_space;
-	return 0;
+	*result = data_allocated;
+	if (ret == -ENOSPC)
+		ret = 0;
+	return ret;
 }
 
 /*
@@ -2034,7 +2003,6 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	unsigned factor = 1;
 	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
 	int ret;
-	u64 thresh = 0;
 	int mixed = 0;
 
 	rcu_read_lock();
@@ -2082,31 +2050,11 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 		buf->f_bfree = 0;
 	spin_unlock(&block_rsv->lock);
 
-	buf->f_bavail = div_u64(total_free_data, factor);
-	ret = btrfs_calc_avail_data_space(fs_info, &total_free_data);
+	ret = btrfs_calc_avail_data_space(fs_info, total_free_meta,
+					  &buf->f_bavail);
 	if (ret)
 		return ret;
-	buf->f_bavail += div_u64(total_free_data, factor);
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
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index be8250332c60..b2155a143740 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2658,10 +2658,10 @@ static int btrfs_cmp_device_info(const void *a, const void *b)
  *    Such virtual chunks won't take on-disk space, thus called virtual, and
  *    only affects per-profile available space calulation.
  */
-static int alloc_virtual_chunk(struct btrfs_fs_info *fs_info,
-			       struct btrfs_device_info *devices_info,
-			       enum btrfs_raid_types type,
-			       u64 to_alloc, u64 *allocated)
+int btrfs_alloc_virtual_chunk(struct btrfs_fs_info *fs_info,
+			      struct btrfs_device_info *devices_info,
+			      enum btrfs_raid_types type,
+			      u64 to_alloc, u64 *allocated)
 {
 	const struct btrfs_raid_attr *raid_attr = &btrfs_raid_array[type];
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
@@ -2761,8 +2761,8 @@ static int calc_one_profile_avail(struct btrfs_fs_info *fs_info,
 	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list)
 		device->virtual_allocated = 0;
 	while (ret == 0) {
-		ret = alloc_virtual_chunk(fs_info, devices_info, type,
-					  (u64)-1, &allocated);
+		ret = btrfs_alloc_virtual_chunk(fs_info, devices_info, type,
+						(u64)-1, &allocated);
 		if (ret == 0)
 			result += allocated;
 	}
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 81cdab0d864a..3c327ad6924e 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -459,6 +459,10 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
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

