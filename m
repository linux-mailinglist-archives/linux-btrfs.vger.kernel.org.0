Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AECD12A841
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Dec 2019 14:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfLYNjr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Dec 2019 08:39:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:56366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfLYNjr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Dec 2019 08:39:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 22851AAA6;
        Wed, 25 Dec 2019 13:39:44 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC 1/3] btrfs: Introduce per-profile available space facility
Date:   Wed, 25 Dec 2019 21:39:36 +0800
Message-Id: <20191225133938.115733-2-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191225133938.115733-1-wqu@suse.com>
References: <20191225133938.115733-1-wqu@suse.com>
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
This patch will introduce the skeleton of per-profile available space
calculation, which can more-or-less get to the point of chunk allocator.

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
The code code looks like:

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

  	/*
  	 * Allocate a virtual chunk, allocated virtual chunk will
  	 * increase virtual used space, allow next iteration to
  	 * properly emulate chunk allocator behavior.
  	 */
  	ret = alloc_virtual_chunk(stripe_size, &allocated_size);
  	if (ret == 0)
  		avail += allocated_size;
  } while (ret == 0)

As we always select the device with least free space (just like chunk
allocator), for above 1T + 10T device, we will allocate a 1T virtual chunk
in the first iteration, then run out of device in next iteration.

Thus only get 1T free space for RAID1 type, just like what chunk
allocator would do.

This patch is just the skeleton, we only do the per-profile chunk
calculation at mount time.

Later commits will update per-profile available space at other proper
timings.

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 190 ++++++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/volumes.h |  10 +++
 2 files changed, 181 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d8e5560db285..8d4be1d48f2f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -349,6 +349,7 @@ static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid,
 	INIT_LIST_HEAD(&fs_devs->devices);
 	INIT_LIST_HEAD(&fs_devs->alloc_list);
 	INIT_LIST_HEAD(&fs_devs->fs_list);
+	spin_lock_init(&fs_devs->per_profile_lock);
 	if (fsid)
 		memcpy(fs_devs->fsid, fsid, BTRFS_FSID_SIZE);
 
@@ -2628,6 +2629,169 @@ static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
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
+ * Return 0 if we allocated a virtual(*) chunk, and restore the size to
+ * @allocated_size
+ * Return -ENOSPC if we have no more space to allocate virtual chunk
+ *
+ * *: virtual chunk is a space holder for per-profile available space
+ *    calculator.
+ *    Such virtual chunks won't take on-disk space, thus called virtual, and
+ *    only affects per-profile available space calulation.
+ */
+static int allocate_virtual_chunk(struct btrfs_fs_info *fs_info,
+				  const struct btrfs_raid_attr *raid_attr,
+				  struct btrfs_device_info *devices_info,
+				  u64 *allocated)
+{
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_device *device;
+	u64 stripe_size;
+	int i;
+	int ndevs = 0;
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
+		if (avail == 0)
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
+	stripe_size = devices_info[ndevs - 1].total_avail;
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
+	const struct btrfs_raid_attr *raid_attr;
+	struct btrfs_device_info *devices_info = NULL;
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_device *device;
+	u64 allocated;
+	u64 result = 0;
+	int ret = 0;
+
+	ASSERT(type >= 0 && type < BTRFS_NR_RAID_TYPES);
+	lockdep_assert_held(&fs_devices->device_list_mutex);
+
+	raid_attr = &btrfs_raid_array[type];
+
+	/* Not enough devices, quick exit, just update the result */
+	if (fs_devices->rw_devices < raid_attr->devs_min)
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
+		ret = allocate_virtual_chunk(fs_info, raid_attr, devices_info,
+					     &allocated);
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
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	int i;
+	int ret;
+
+	lockdep_assert_held(&fs_devices->device_list_mutex);
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
@@ -4690,25 +4854,6 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
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
@@ -7629,6 +7774,13 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 
 	/* Ensure all chunks have corresponding dev extents */
 	ret = verify_chunk_dev_extent_mapping(fs_info);
+	if (ret < 0)
+		goto out;
+
+	/* All dev extents are verified, update per-profile available space */
+	mutex_lock(&fs_info->fs_devices->device_list_mutex);
+	ret = calc_per_profile_avail(fs_info);
+	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 out:
 	btrfs_free_path(path);
 	return ret;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index fc1b564b9cfe..81cdab0d864a 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -138,6 +138,12 @@ struct btrfs_device {
 	atomic_t dev_stat_values[BTRFS_DEV_STAT_VALUES_MAX];
 
 	struct extent_io_tree alloc_state;
+
+	/*
+	 * the "virtual" allocated space by per-profile available space
+	 * calculator. Doesn't affect chunk allocator at all.
+	 */
+	u64 virtual_allocated;
 };
 
 /*
@@ -257,6 +263,10 @@ struct btrfs_fs_devices {
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

