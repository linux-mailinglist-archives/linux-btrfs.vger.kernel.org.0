Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F7E27F939
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 07:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbgJAF6K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 01:58:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:40300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgJAF6K (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 01:58:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601531888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NPMm8IH0RLDFJj7EAl6KXu0fgpNeWCNEpmuEK6e56DY=;
        b=aC2x68v+oy9BYmuIDR7O6vkYgfNjURk5VVEkxMyRFq1yOD/1Oo8EF820L0KclxIHNl9qdp
        OfU2o4agETRPVcTncqdy8BNfXJMLeLpHj7nLBhQgXqVGbLWk0m192+lbPZvofe3P/LhuBq
        u/dpmhPNP29g3x33YHxh92DryxwDxao=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F37ECB320
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Oct 2020 05:58:07 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 9 07/12] btrfs: volumes: introduce the device layout aware per-profile available space infrastructure
Date:   Thu,  1 Oct 2020 13:57:39 +0800
Message-Id: <20201001055744.103261-8-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001055744.103261-1-wqu@suse.com>
References: <20201001055744.103261-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This patch just introduces the infrastructure, no hooks are executed
yet.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 181 ++++++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/volumes.h |  10 +++
 2 files changed, 172 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 214856c4ccb1..28636cf01190 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2038,6 +2038,168 @@ static void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 	update_dev_time(device_path);
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
+ * Return 0 if we allocated any ballon(*) chunk, and restore the size to
+ * @allocated (the last parameter).
+ * Return -ENOSPC if we have no more space to allocate virtual chunk
+ *
+ * *: Ballon chunks are space holder for per-profile available space allocator.
+ *    Ballon chunks won't really take on-disk space, but only to emulate
+ *    chunk allocator behavior to get accurate estimation on available space.
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
+				device->ballon_allocated)
+			avail = device->total_bytes - device->bytes_used -
+				device->ballon_allocated;
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
+	ndevs = rounddown(ndevs, raid_attr->devs_increment);
+	if (ndevs < raid_attr->devs_min)
+		return -ENOSPC;
+	if (raid_attr->devs_max)
+		ndevs = min(ndevs, (int)raid_attr->devs_max);
+	else
+		ndevs = min(ndevs, (int)BTRFS_MAX_DEVS(fs_info));
+
+	/*
+	 * Now allocate a virtual chunk using the unallocated space of the
+	 * device with the least unallocated space.
+	 */
+	stripe_size = round_down(devices_info[ndevs - 1].total_avail,
+				 fs_info->sectorsize);
+	for (i = 0; i < ndevs; i++)
+		devices_info[i].dev->ballon_allocated += stripe_size;
+	*allocated = stripe_size * (ndevs - raid_attr->nparity) /
+		     raid_attr->ncopies;
+	return 0;
+}
+
+static int calc_one_profile_avail(struct btrfs_fs_info *fs_info,
+				  enum btrfs_raid_types type,
+				  u64 *result_ret)
+{
+	struct btrfs_device_info *devices_info = NULL;
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_device *device;
+	u64 allocated;
+	u64 result = 0;
+	int ret = 0;
+
+	lockdep_assert_held(&fs_info->chunk_mutex);
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
+		device->ballon_allocated = 0;
+
+	while (!alloc_virtual_chunk(fs_info, devices_info, type, &allocated))
+		result += allocated;
+
+out:
+	kfree(devices_info);
+	if (ret < 0 && ret != -ENOSPC)
+		return ret;
+	*result_ret = result;
+	return 0;
+}
+
+/*
+ * Update the per-profile available space array.
+ *
+ * Return 0 if we succeeded updating the array.
+ * Return <0 if something went wrong (ENOMEM), and the array is not
+ * updated.
+ */
+int btrfs_update_per_profile_avail(struct btrfs_fs_info *fs_info)
+{
+	u64 results[BTRFS_NR_RAID_TYPES];
+	int i;
+	int ret;
+
+	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++) {
+		ret = calc_one_profile_avail(fs_info, i, &results[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++)
+		atomic64_set(&fs_info->fs_devices->per_profile_avail[i],
+				results[i]);
+	return ret;
+}
+
 int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 		u64 devid)
 {
@@ -4785,25 +4947,6 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
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
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 5eea93916fbf..cd213c5e16cf 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -138,6 +138,12 @@ struct btrfs_device {
 	struct completion kobj_unregister;
 	/* For sysfs/FSID/devinfo/devid/ */
 	struct kobject devid_kobj;
+
+	/*
+	 * The ballon allocated space, to emulate chunk allocator to get
+	 * an esitmation on available space.
+	 */
+	u64 ballon_allocated;
 };
 
 /*
@@ -264,6 +270,9 @@ struct btrfs_fs_devices {
 	struct completion kobj_unregister;
 
 	enum btrfs_chunk_allocation_policy chunk_alloc_policy;
+
+	/* Records accurate per-type available space */
+	atomic64_t per_profile_avail[BTRFS_NR_RAID_TYPES];
 };
 
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
@@ -577,5 +586,6 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
+int btrfs_update_per_profile_avail(struct btrfs_fs_info *fs_info);
 
 #endif
-- 
2.28.0

