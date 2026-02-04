Return-Path: <linux-btrfs+bounces-21350-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FsNBxa1gmnwYgMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21350-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 03:55:18 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69316E10A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 03:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70FD830CA07C
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Feb 2026 02:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9642D838C;
	Wed,  4 Feb 2026 02:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="q9nYUtJe";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="q9nYUtJe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6842BEC5F
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 02:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770173681; cv=none; b=tN0/O/MgKEbSnKjbh+geSrIcZMENVk3koUt9A8NEsxYLmozz5HTw5nzSHvBqDwjKFivqpPbF5iiWxFmrYabDG7kOSEL5O7fKvMw2unUxIl3wqH9f1KeYXXbSBICJqIEZzah9MtWyvMMl+/3Abkc1xjvCaPAaeI2CHVuh5yxVbKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770173681; c=relaxed/simple;
	bh=0bYydenqbGYkTIyjfzC+NameEEOG8bQ9a4tiIMwnsSw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Owsw8T/Jzi5OfBjZcmq/mG/0B1W96QUh6gu1508dN1M+CrJ1/u+gLoDwOdveOnaq1bsyglMX5+bMuwIiO5AsVBdHEEN7EVW7B4R0LAQFTxifc38P/7RDLHB/BofjVZZtMFIDm7xv3HoeBltxt/mV/gSwMevoZfdkLvvV6xYBWNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=q9nYUtJe; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=q9nYUtJe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F2B3E3E6D2
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 02:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770173672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76+jhFthQQGCkDVth5+xYTzi6liCmk7WMppzTZxaHpY=;
	b=q9nYUtJeRShLmhMOa0b25CEkR4JKH2dJyJKh6M/Z61TZL3ArnuHuqu+AxHKGEGf07ROBdm
	VnzFyPDQAnr5Nazp10gkaJ8nAJqcFo/zxXJ+Ta3ECNCM9x3CU5dKoIkVzGiKU7BlmTkceS
	2NjYRCQLDTzGv853b2QO9DNZbg/lFqc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770173672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76+jhFthQQGCkDVth5+xYTzi6liCmk7WMppzTZxaHpY=;
	b=q9nYUtJeRShLmhMOa0b25CEkR4JKH2dJyJKh6M/Z61TZL3ArnuHuqu+AxHKGEGf07ROBdm
	VnzFyPDQAnr5Nazp10gkaJ8nAJqcFo/zxXJ+Ta3ECNCM9x3CU5dKoIkVzGiKU7BlmTkceS
	2NjYRCQLDTzGv853b2QO9DNZbg/lFqc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A7543EA63
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 02:54:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GG8FN+a0gmknHAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 04 Feb 2026 02:54:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs: introduce the device layout aware per-profile available space
Date: Wed,  4 Feb 2026 13:24:06 +1030
Message-ID: <ef73e5bf75b19e839f68c018596f10437a8ba23b.1770173615.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770173615.git.wqu@suse.com>
References: <cover.1770173615.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21350-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: 69316E10A6
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
  RAID5:	2T
  RAID6:	1T

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

This minimal available space based calculation is not perfect, but the
important part is, the estimation is never exceeding the real available
space.

This patch just introduces the infrastructure, no hooks are executed
yet.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 163 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  34 ++++++++++
 2 files changed, 197 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f281d113519b..a28e7400e8dc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5372,6 +5372,169 @@ static int btrfs_cmp_device_info(const void *a, const void *b)
 	return 0;
 }
 
+/*
+ * Return 0 if we allocated any virtual(*) chunk, and restore the size to
+ * @allocated.
+ * Return -ENOSPC if we have no more space to allocate virtual chunk
+ *
+ * *: A virtual chunk is a chunk that only exists during per-profile available
+ *    estimation.
+ *    Those numbers won't really take on-disk space, but only to emulate
+ *    chunk allocator behavior to get accurate estimation on available space.
+ *
+ *    Another different is, a virtual chunk has no size limit and doesn't care
+ *    about the hole size in device tree, allowing us to exhause device space
+ *    much faster.
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
+	int ndevs = 0;
+
+	lockdep_assert_held(&fs_info->chunk_mutex);
+
+	/* Go through devices to collect their unallocated space. */
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
+		avail = round_down(avail, fs_info->sectorsize);
+
+		/* And exclude the [0, 1M) reserved space. */
+		if (avail > BTRFS_DEVICE_RANGE_RESERVED)
+			avail -= BTRFS_DEVICE_RANGE_RESERVED;
+		else
+			avail = 0;
+
+		/*
+		 * Not enough to support a single stripe, this device
+		 * can not be utilized for chunk allocation.
+		 */
+		if (avail < BTRFS_STRIPE_LEN)
+			continue;
+
+		/*
+		 * Unlike chunk allocator, we don't care about stripe or hole
+		 * size, so here we use @avail directly.
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
+	 * Stripe size will be determined by the device with the least
+	 * unallocated space.
+	 */
+	stripe_size = devices_info[ndevs - 1].total_avail;
+
+	for (int i = 0; i < ndevs; i++)
+		devices_info[i].dev->per_profile_allocated += stripe_size;
+	*allocated = div_u64(stripe_size * (ndevs - raid_attr->nparity),
+			     raid_attr->ncopies);
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
+	/* Not enough devices, quick exit, just update the result. */
+	if (fs_devices->rw_devices < btrfs_raid_array[type].devs_min) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
+			       GFP_NOFS);
+	if (!devices_info) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	/* Clear virtual chunk used space for each device. */
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
+	int ret;
+
+	/*
+	 * Zoned is more complex as we can not simply get the amount of
+	 * available space for each device.
+	 */
+	if (btrfs_is_zoned(fs_info))
+		goto error;
+
+	for (int i = 0; i < BTRFS_NR_RAID_TYPES; i++) {
+		ret = calc_one_profile_avail(fs_info, i, &results[i]);
+		if (ret < 0)
+			goto error;
+	}
+
+	spin_lock(&fs_info->fs_devices->per_profile_lock);
+	for (int i = 0; i < BTRFS_NR_RAID_TYPES; i++)
+		fs_info->fs_devices->per_profile_avail[i] = results[i];
+	spin_unlock(&fs_info->fs_devices->per_profile_lock);
+	return;
+error:
+	spin_lock(&fs_info->fs_devices->per_profile_lock);
+	for (int i = 0; i < BTRFS_NR_RAID_TYPES; i++)
+		fs_info->fs_devices->per_profile_avail[i] = U64_MAX;
+	spin_unlock(&fs_info->fs_devices->per_profile_lock);
+}
+
 static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 type)
 {
 	if (!(type & BTRFS_BLOCK_GROUP_RAID56_MASK))
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index ebc85bf53ee7..3dde32143058 100644
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
@@ -458,6 +465,15 @@ struct btrfs_fs_devices {
 	/* Device to be used for reading in case of RAID1. */
 	u64 read_devid;
 #endif
+
+	/*
+	 * Each value indicates the available space for that profile.
+	 * U64_MAX means the estimation is unavailable.
+	 *
+	 * Protected by per_profile_lock;
+	 */
+	u64 per_profile_avail[BTRFS_NR_RAID_TYPES];
+	spinlock_t per_profile_lock;
 };
 
 #define BTRFS_MAX_DEVS(info) ((BTRFS_MAX_ITEM_SIZE(info)	\
@@ -886,6 +902,24 @@ int btrfs_bg_type_to_factor(u64 flags);
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
+	if (fs_devices->per_profile_avail[index] != U64_MAX) {
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


