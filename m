Return-Path: <linux-btrfs+bounces-21301-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMXLLT5lgWlMGAMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21301-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 04:02:22 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFC4D3F5D
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 04:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66E813050A02
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 03:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38E913DBA0;
	Tue,  3 Feb 2026 03:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gilGSudS";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gilGSudS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DD33BB57
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 03:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770087715; cv=none; b=n3hLBHuIHoj9fpdQ8tnAprMGOgxXHpzjMbLRqozsjmzIoZ64ZEG6AmdzOrZGqD6/I7DsvXSfdCYhcVSfwDqQ81/nUUIv1wCVEIMM5XYSE8qIFHR3p2W9oZxtqMgMJs/1gJr0n36cfJS6mDNVuwT2mFk3gw/GPkq2hnyAFo1EObg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770087715; c=relaxed/simple;
	bh=KRYJe8HoeYmxIbJjI/X0CH3h4567bno1lB/NjiM19BM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ooK8wrvZv0iyH1tK1epV5CWKnnOGvXhj5jiRqesWxcwRhLfVuq9vo92vZ3QM3L9yuFAvIUlv9OI5Yd0sBo91fUnDxjM0/EwDvyTHlAEdhIQQN/HzmWRHOqi9nW/m11BjV/xrJdl3ZBqsRBSMBJ/y36gr+NNw/S8LHTyqhVGR8GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gilGSudS; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gilGSudS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6CF893E6CB
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 03:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770087711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vmp+JJT1LKNnMLZ3B3PQIoGpjw7Mq078v7PvuInA398=;
	b=gilGSudSm1+eHCBsEYrVQgeO3EbSPXFNiRR0r3MpiM0i75hM3aWJ4xJJY7qPhBJlOCfz2l
	8diqUNi9MzFVHrOQOaqlOjxyjmQJwwQsBHlPIjHKNISXa81AqHKUixWAnDWXkWvDbWMXsS
	NSRoYIaHAGPCzgjsfKLgzH5jdlIpSCU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770087711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vmp+JJT1LKNnMLZ3B3PQIoGpjw7Mq078v7PvuInA398=;
	b=gilGSudSm1+eHCBsEYrVQgeO3EbSPXFNiRR0r3MpiM0i75hM3aWJ4xJJY7qPhBJlOCfz2l
	8diqUNi9MzFVHrOQOaqlOjxyjmQJwwQsBHlPIjHKNISXa81AqHKUixWAnDWXkWvDbWMXsS
	NSRoYIaHAGPCzgjsfKLgzH5jdlIpSCU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9977A3EA62
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 03:01:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aH2BFh5lgWnVUgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 03 Feb 2026 03:01:50 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: introduce the device layout aware per-profile available space
Date: Tue,  3 Feb 2026 13:31:29 +1030
Message-ID: <eb573bac21a16092d8e9f64533c6b0d6ed6b16a4.1770087101.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770087101.git.wqu@suse.com>
References: <cover.1770087101.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21301-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5FFC4D3F5D
X-Rspamd-Action: no action

[BUG]
There is a long known bug that if metadata is using RAID1 on two disks
with unbalanced sizes, there is a very high chance to hit ENOSPC related
transaction abort.

[CAUSE]
The root cause is in the available space estimation code:

- Factor based calculation
  Just use all unallocated space, divide by the profile factor
  One obvious user is can_overcommit().

This can not handle the following example:

  devid 1 unallocated:	1GiB
  devid 2 unallocated:	50GiB
  metadata type:	RAID1

If using factor based estimation, we can use (1GiB + 50GiB) / 2 = 25.5GiB
free space for metadata.
Thus we can continue allocating metadata (over-commit) way beyond the
1GiB limit.

But this estimation is completely wrong, in reality we can only allocate
one single 1GiB RAID1 block group, thus if we continue over-commit, at
one time we will hit ENOSPC at some critical path and flips the fs
read-only.

[SOLUTION]
This patch will introduce per-profile available space estimation,
which can provide chunk-allocator like behavior to give a (mostly)
accurate result, with under-estimate corner cases.

There are some differences between the estimation and real chunk
allocator:

- No consideration on hole size
  It's fine for most cases, as all data/metadata strips are in 1GiB size
  thus there should not be any hole wasting much space.

  And chunk allocator is able to use smaller stripes when there is
  really no other choice.

  Although in theory this means it can lead to some over-estimation, it
  should not cause too much hassle in the real world.

  The other benefit of such behavior is, we avoid dev-extent tree search
  completely, thus the overhead is very small.

- No true balance for certain cases
  If we have 3 disks RAID1, and each device has 2GiB unallocated space,
  we can load balance the chunk allocation so that we can allocate 3GiB
  RAID1 chunks, and that's what chunk allocator will do.

  But this current estimation code is using the largest available space
  to do a single allocation. Meaning the estimation will be 2GiB, thus
  under estimate.

  Such under estimation is fine and after the first chunk allocation, the
  estimation will be updated and still give a correct 2GiB
  estimation.
  So this only means the estimation will be a little conservative, which
  is safer for call sites like metadata over-commit check.

With that facility, for above 1GiB + 50GiB case, it will give a RAID1
estimation of 1GiB, instead of the incorrect 25.5GiB.

Or for a more complex example:
  devid 1 unallocated:	1T
  devid 2 unallocated:  1T
  devid 3 unallocated:	10T

We will get an array of:
  RAID10:	2T
  RAID1:	2T
  RAID1C3:	1T
  RAID1C4:	0  (not enough devices)
  DUP:		6T
  RAID0:	3T
  SINGLE:	12T
  RAID5:	1T
  RAID6:	0  (not enough devices)

[IMPLEMENTATION]
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

This minimal available space based calculation is not perfect, but the
important part is, the estimation is never exceeding the real available
space.

This patch just introduces the infrastructure, no hooks are executed
yet.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 153 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  30 +++++++++
 2 files changed, 183 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f281d113519b..2348d4d5e0b5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5372,6 +5372,159 @@ static int btrfs_cmp_device_info(const void *a, const void *b)
 	return 0;
 }
 
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
+
+		if (!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
+					&device->dev_state) ||
+		    test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state))
+			continue;
+
+		if (device->total_bytes > device->bytes_used +
+				device->per_profile_allocated)
+			avail = device->total_bytes - device->bytes_used -
+				device->per_profile_allocated;
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
+		devices_info[i].dev->per_profile_allocated += stripe_size;
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
+		device->per_profile_allocated = 0;
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
+/* Update the per-profile available space array. */
+void btrfs_update_per_profile_avail(struct btrfs_fs_info *fs_info)
+{
+	u64 results[BTRFS_NR_RAID_TYPES];
+	int i = 0;
+	int ret;
+
+	/*
+	 * Zoned is more complex as we can not simply get the amount of
+	 * available space for each device.
+	 */
+	if (btrfs_is_zoned(fs_info))
+		goto error;
+
+	for (; i < BTRFS_NR_RAID_TYPES; i++) {
+		ret = calc_one_profile_avail(fs_info, i, &results[i]);
+		if (ret < 0)
+			goto error;
+	}
+
+	spin_lock(&fs_info->fs_devices->per_profile_lock);
+	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++) {
+		fs_info->fs_devices->per_profile_avail[i] = results[i];
+		set_bit(i, &fs_info->fs_devices->per_profile_uptodate);
+	}
+	spin_unlock(&fs_info->fs_devices->per_profile_lock);
+	return;
+error:
+	spin_lock(&fs_info->fs_devices->per_profile_lock);
+	bitmap_clear(&fs_info->fs_devices->per_profile_uptodate, 0,
+		     BTRFS_NR_RAID_TYPES);
+	spin_unlock(&fs_info->fs_devices->per_profile_lock);
+}
+
 static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 type)
 {
 	if (!(type & BTRFS_BLOCK_GROUP_RAID56_MASK))
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index ebc85bf53ee7..ecb5ad9cf249 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -22,6 +22,7 @@
 #include <uapi/linux/btrfs_tree.h>
 #include "messages.h"
 #include "extent-io-tree.h"
+#include "fs.h"
 
 struct block_device;
 struct bdev_handle;
@@ -213,6 +214,12 @@ struct btrfs_device {
 
 	/* Bandwidth limit for scrub, in bytes */
 	u64 scrub_speed_max;
+
+	/*
+	 * A temporary number of allocated space during per-profile
+	 * available space calculation.
+	 */
+	u64 per_profile_allocated;
 };
 
 /*
@@ -458,6 +465,11 @@ struct btrfs_fs_devices {
 	/* Device to be used for reading in case of RAID1. */
 	u64 read_devid;
 #endif
+
+	u64 per_profile_avail[BTRFS_NR_RAID_TYPES];
+	/* Records per-type available space estimation. */
+	spinlock_t per_profile_lock;
+	unsigned long per_profile_uptodate;
 };
 
 #define BTRFS_MAX_DEVS(info) ((BTRFS_MAX_ITEM_SIZE(info)	\
@@ -886,6 +898,24 @@ int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
 bool btrfs_verify_dev_items(const struct btrfs_fs_info *fs_info);
+void btrfs_update_per_profile_avail(struct btrfs_fs_info *fs_info);
+
+static inline bool btrfs_get_per_profile_avail(struct btrfs_fs_info *fs_info,
+					       u64 profile, u64 *avail_ret)
+{
+	enum btrfs_raid_types index = btrfs_bg_flags_to_raid_index(profile);
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	bool uptodate = false;
+
+	spin_lock(&fs_devices->per_profile_lock);
+	if (test_bit(index, &fs_devices->per_profile_uptodate)) {
+		uptodate = true;
+		*avail_ret = fs_devices->per_profile_avail[index];
+	}
+	spin_unlock(&fs_info->fs_devices->per_profile_lock);
+	return uptodate;
+}
+
 bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
 
 bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
-- 
2.52.0


