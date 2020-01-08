Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E80FC133BFE
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 08:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgAHHFU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 02:05:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:56198 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgAHHFU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jan 2020 02:05:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E241BAD3B;
        Wed,  8 Jan 2020 07:05:17 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v4 1/3] btrfs: Introduce per-profile available space facility
Date:   Wed,  8 Jan 2020 15:05:07 +0800
Message-Id: <20200108070509.25483-2-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108070509.25483-1-wqu@suse.com>
References: <20200108070509.25483-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]
There are some locations in btrfs requiring accurate estimation on how
many new bytes can be allocated on unallocated space.

We have two types of estimation:
- Factor based calculation
  Just use all unallocated space, divide by the profile factor
  One obvious user is can_overcommit().

- Chunk allocator like calculation
  This will emulate the chunk allocator behavior, to get a proper
  estimation.
  The only user is btrfs_calc_avail_data_space(), utilized by
  btrfs_statfs().
  The problem is, that function is not generic purposed enough, can't
  handle things like RAID5/6.

Current factor based calculation can't handle the following case:
  devid 1 unallocated:	1T
  devid 2 unallocated:	10T
  metadata type:	RAID1

If using factor, we can use (1T + 10T) / 2 = 5.5T free space for
metadata.
But in fact we can only get 1T free space, as we're limited by the
smallest device for RAID1.

[SOLUTION]
This patch will introduce per-profile available space calculation,
which can give an estimation based on chunk-allocator-like behavior.

The difference between it and chunk allocator is mostly on rounding and
[0, 1M) reserved space handling, which shouldn't cause practical impact.

The newly introduced per-profile available space calculation will
calculate available space for each type, using chunk-allocator like
calculation.

With that facility, for above device layout we get the full available
space array:
  RAID10:	0  (not enough devices)
  RAID1:	1T
  RAID1C3:	0  (not enough devices)
  RAID1C4:	0  (not enough devices)
  DUP:		5.5T
  RAID0:	2T
  SINGLE:	11T
  RAID5:	1T
  RAID6:	0  (not enough devices)

Or for a more complex example:
  devid 1 unallocated:	1T
  devid 2 unallocated:  1T
  devid 3 unallocated:	10T

We will get an array of:
  RAID10:	0  (not enough devices)
  RAID1:	2T
  RAID1C3:	1T
  RAID1C4:	0  (not enough devices)
  DUP:		6T
  RAID0:	3T
  SINGLE:	12T
  RAID5:	2T
  RAID6:	0  (not enough devices)

And for the each profile , we go chunk allocator level calculation:
The pseudo code looks like:

  clear_virtual_used_space_of_all_rw_devices();
  do {
  	/*
  	 * The same as chunk allocator, despite used space,
  	 * we also take virtual used space into consideration.
  	 */
  	sort_device_with_virtual_free_space();

  	/*
  	 * Unlike chunk allocator, we don't need to bother hole/stripe
  	 * size, so we use the smallest device to make sure we can
  	 * allocated as many stripes as regular chunk allocator
  	 */
  	stripe_size = device_with_smallest_free->avail_space;
	stripe_size = min(stripe_size, to_alloc / ndevs);

  	/*
  	 * Allocate a virtual chunk, allocated virtual chunk will
  	 * increase virtual used space, allow next iteration to
  	 * properly emulate chunk allocator behavior.
  	 */
  	ret = alloc_virtual_chunk(stripe_size, &allocated_size);
  	if (ret == 0)
  		avail += allocated_size;
  } while (ret == 0)

As we always select the device with least free space, the device with
the most space will be the first to be utilized, just like chunk
allocator.
For above 1T + 10T device, we will allocate a 1T virtual chunk
in the first iteration, then run out of device in next iteration.

Thus only get 1T free space for RAID1 type, just like what chunk
allocator would do.

The patch will update such per-profile available space at the following
timing:
- Mount time
- Chunk allocation
- Chunk removal
- Device grow
- Device shrink

Those timing are all protected by chunk_mutex, and what we do are only
iterating in-memory only structures, no extra IO triggered, so the
performance impact should be pretty small.

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 212 ++++++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/volumes.h |  11 +++
 2 files changed, 203 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d8e5560db285..4559aaee13f1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -349,6 +349,7 @@ static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid,
 	INIT_LIST_HEAD(&fs_devs->devices);
 	INIT_LIST_HEAD(&fs_devs->alloc_list);
 	INIT_LIST_HEAD(&fs_devs->fs_list);
+	spin_lock_init(&fs_devs->per_profile_lock);
 	if (fsid)
 		memcpy(fs_devs->fsid, fsid, BTRFS_FSID_SIZE);
 
@@ -2628,6 +2629,170 @@ static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+/*
+ * sort the devices in descending order by max_avail, total_avail
+ */
+static int btrfs_cmp_device_info(const void *a, const void *b)
+{
+	const struct btrfs_device_info *di_a = a;
+	const struct btrfs_device_info *di_b = b;
+
+	if (di_a->max_avail > di_b->max_avail)
+		return -1;
+	if (di_a->max_avail < di_b->max_avail)
+		return 1;
+	if (di_a->total_avail > di_b->total_avail)
+		return -1;
+	if (di_a->total_avail < di_b->total_avail)
+		return 1;
+	return 0;
+}
+
+/*
+ * Return 0 if we allocated any virtual(*) chunk, and restore the size to
+ * @allocated_size
+ * Return -ENOSPC if we have no more space to allocate virtual chunk
+ *
+ * *: virtual chunk is a space holder for per-profile available space
+ *    calculator.
+ *    Such virtual chunks won't take on-disk space, thus called virtual, and
+ *    only affects per-profile available space calulation.
+ */
+static int alloc_virtual_chunk(struct btrfs_fs_info *fs_info,
+			       struct btrfs_device_info *devices_info,
+			       enum btrfs_raid_types type,
+			       u64 *allocated)
+{
+	const struct btrfs_raid_attr *raid_attr = &btrfs_raid_array[type];
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_device *device;
+	u64 stripe_size;
+	int i;
+	int ndevs = 0;
+
+	lockdep_assert_held(&fs_info->chunk_mutex);
+
+	/* Go through devices to collect their unallocated space */
+	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list) {
+		u64 avail;
+		if (!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
+					&device->dev_state) ||
+		    test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state))
+			continue;
+
+		if (device->total_bytes > device->bytes_used +
+				device->virtual_allocated)
+			avail = device->total_bytes - device->bytes_used -
+				device->virtual_allocated;
+		else
+			avail = 0;
+
+		/* And exclude the [0, 1M) reserved space */
+		if (avail > SZ_1M)
+			avail -= SZ_1M;
+		else
+			avail = 0;
+
+		if (avail < fs_info->sectorsize)
+			continue;
+		/*
+		 * Unlike chunk allocator, we don't care about stripe or hole
+		 * size, so here we use @avail directly
+		 */
+		devices_info[ndevs].dev_offset = 0;
+		devices_info[ndevs].total_avail = avail;
+		devices_info[ndevs].max_avail = avail;
+		devices_info[ndevs].dev = device;
+		++ndevs;
+	}
+	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
+	     btrfs_cmp_device_info, NULL);
+	ndevs -= ndevs % raid_attr->devs_increment;
+	if (ndevs < raid_attr->devs_min)
+		return -ENOSPC;
+	if (raid_attr->devs_max)
+		ndevs = min(ndevs, (int)raid_attr->devs_max);
+	else
+		ndevs = min(ndevs, (int)BTRFS_MAX_DEVS(fs_info));
+
+	/*
+	 * Now allocate a virtual chunk using the unallocate space of the
+	 * device with the least unallocated space.
+	 */
+	stripe_size = round_down(devices_info[ndevs - 1].total_avail,
+				 fs_info->sectorsize);
+	if (stripe_size == 0)
+		return -ENOSPC;
+
+	for (i = 0; i < ndevs; i++)
+		devices_info[i].dev->virtual_allocated += stripe_size;
+	*allocated = stripe_size * (ndevs - raid_attr->nparity) /
+		     raid_attr->ncopies;
+	return 0;
+}
+
+static int calc_one_profile_avail(struct btrfs_fs_info *fs_info,
+				  enum btrfs_raid_types type)
+{
+	struct btrfs_device_info *devices_info = NULL;
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_device *device;
+	u64 allocated;
+	u64 result = 0;
+	int ret = 0;
+
+	ASSERT(type >= 0 && type < BTRFS_NR_RAID_TYPES);
+
+	/* Not enough devices, quick exit, just update the result */
+	if (fs_devices->rw_devices < btrfs_raid_array[type].devs_min)
+		goto out;
+
+	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
+			       GFP_NOFS);
+	if (!devices_info) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	/* Clear virtual chunk used space for each device */
+	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list)
+		device->virtual_allocated = 0;
+	while (ret == 0) {
+		ret = alloc_virtual_chunk(fs_info, devices_info, type,
+					  &allocated);
+		if (ret == 0)
+			result += allocated;
+	}
+	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list)
+		device->virtual_allocated = 0;
+out:
+	kfree(devices_info);
+	if (ret < 0 && ret != -ENOSPC)
+		return ret;
+	spin_lock(&fs_devices->per_profile_lock);
+	fs_devices->per_profile_avail[type] = result;
+	spin_unlock(&fs_devices->per_profile_lock);
+	return 0;
+}
+
+/*
+ * Calculate the per-profile available space array.
+ *
+ * Return 0 if we succeeded updating the array.
+ * Return <0 if something went wrong. (ENOMEM)
+ */
+static int calc_per_profile_avail(struct btrfs_fs_info *fs_info)
+{
+	int i;
+	int ret;
+
+	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++) {
+		ret = calc_one_profile_avail(fs_info, i);
+		if (ret < 0)
+			break;
+	}
+	return ret;
+}
+
 int btrfs_grow_device(struct btrfs_trans_handle *trans,
 		      struct btrfs_device *device, u64 new_size)
 {
@@ -2635,6 +2800,7 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
 	struct btrfs_super_block *super_copy = fs_info->super_copy;
 	u64 old_total;
 	u64 diff;
+	int ret;
 
 	if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state))
 		return -EACCES;
@@ -2661,7 +2827,12 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
 	if (list_empty(&device->post_commit_list))
 		list_add_tail(&device->post_commit_list,
 			      &trans->transaction->dev_update_list);
+	ret = calc_per_profile_avail(fs_info);
 	mutex_unlock(&fs_info->chunk_mutex);
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
 
 	return btrfs_update_device(trans, device);
 }
@@ -2831,7 +3002,13 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 					device->bytes_used - dev_extent_len);
 			atomic64_add(dev_extent_len, &fs_info->free_chunk_space);
 			btrfs_clear_space_info_full(fs_info);
+			ret = calc_per_profile_avail(fs_info);
 			mutex_unlock(&fs_info->chunk_mutex);
+			if (ret < 0) {
+				mutex_unlock(&fs_devices->device_list_mutex);
+				btrfs_abort_transaction(trans, ret);
+				goto out;
+			}
 		}
 
 		ret = btrfs_update_device(trans, device);
@@ -4526,6 +4703,12 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 		atomic64_sub(diff, &fs_info->free_chunk_space);
 	}
 
+	ret = calc_per_profile_avail(fs_info);
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
+		goto done;
+	}
 	/*
 	 * Once the device's size has been set to the new size, ensure all
 	 * in-memory chunks are synced to disk so that the loop below sees them
@@ -4690,25 +4873,6 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-/*
- * sort the devices in descending order by max_avail, total_avail
- */
-static int btrfs_cmp_device_info(const void *a, const void *b)
-{
-	const struct btrfs_device_info *di_a = a;
-	const struct btrfs_device_info *di_b = b;
-
-	if (di_a->max_avail > di_b->max_avail)
-		return -1;
-	if (di_a->max_avail < di_b->max_avail)
-		return 1;
-	if (di_a->total_avail > di_b->total_avail)
-		return -1;
-	if (di_a->total_avail < di_b->total_avail)
-		return 1;
-	return 0;
-}
-
 static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 type)
 {
 	if (!(type & BTRFS_BLOCK_GROUP_RAID56_MASK))
@@ -4992,9 +5156,10 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	free_extent_map(em);
 	check_raid56_incompat_flag(info, type);
 	check_raid1c34_incompat_flag(info, type);
+	ret = calc_per_profile_avail(info);
 
 	kfree(devices_info);
-	return 0;
+	return ret;
 
 error_del_extent:
 	write_lock(&em_tree->lock);
@@ -7629,6 +7794,13 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 
 	/* Ensure all chunks have corresponding dev extents */
 	ret = verify_chunk_dev_extent_mapping(fs_info);
+	if (ret < 0)
+		goto out;
+
+	/* All dev extents are verified, update per-profile available space */
+	mutex_lock(&fs_info->chunk_mutex);
+	ret = calc_per_profile_avail(fs_info);
+	mutex_unlock(&fs_info->chunk_mutex);
 out:
 	btrfs_free_path(path);
 	return ret;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index fc1b564b9cfe..5cddfe7cfee8 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -138,6 +138,13 @@ struct btrfs_device {
 	atomic_t dev_stat_values[BTRFS_DEV_STAT_VALUES_MAX];
 
 	struct extent_io_tree alloc_state;
+
+	/*
+	 * the "virtual" allocated space by virtual chunk allocator, which
+	 * is used to do accurate estimation on available space.
+	 * Doesn't affect real chunk allocator.
+	 */
+	u64 virtual_allocated;
 };
 
 /*
@@ -257,6 +264,10 @@ struct btrfs_fs_devices {
 	struct kobject fsid_kobj;
 	struct kobject *device_dir_kobj;
 	struct completion kobj_unregister;
+
+	/* Records per-type available space */
+	spinlock_t per_profile_lock;
+	u64 per_profile_avail[BTRFS_NR_RAID_TYPES];
 };
 
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
-- 
2.24.1

