Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8746F165DDA
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 13:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBTMtj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 07:49:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:53574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbgBTMtj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 07:49:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3F2BAAD3F;
        Thu, 20 Feb 2020 12:49:36 +0000 (UTC)
Subject: Re: [PATCH v7 1/5] btrfs: Introduce per-profile available space
 facility
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
References: <20200211051153.19466-1-wqu@suse.com>
 <20200211051153.19466-2-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <329cf703-f3f2-4583-73bf-c90c9e001956@suse.com>
Date:   Thu, 20 Feb 2020 14:49:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211051153.19466-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

<snip>

> 
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/volumes.c | 216 ++++++++++++++++++++++++++++++++++++++++-----
>  fs/btrfs/volumes.h |  11 +++
>  2 files changed, 207 insertions(+), 20 deletions(-)
> 

<snip>

> +
> +/*
> + * Return 0 if we allocated any virtual(*) chunk, and restore the size to
> + * @allocated_size
> + * Return -ENOSPC if we have no more space to allocate virtual chunk
> + *
> + * *: virtual chunk is a space holder for per-profile available space
> + *    calculator.
> + *    Such virtual chunks won't take on-disk space, thus called virtual, and
> + *    only affects per-profile available space calulation.
> + */

Document that the last parameter is an output value which contains the
size of the allocated virtual chunk.

> +static int alloc_virtual_chunk(struct btrfs_fs_info *fs_info,
> +			       struct btrfs_device_info *devices_info,
> +			       enum btrfs_raid_types type,
> +			       u64 *allocated)
> +{
> +	const struct btrfs_raid_attr *raid_attr = &btrfs_raid_array[type];
> +	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> +	struct btrfs_device *device;
> +	u64 stripe_size;
> +	int i;
> +	int ndevs = 0;
> +
> +	lockdep_assert_held(&fs_info->chunk_mutex);
> +
> +	/* Go through devices to collect their unallocated space */
> +	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list) {
> +		u64 avail;
> +		if (!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
> +					&device->dev_state) ||
> +		    test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state))
> +			continue;
> +
> +		if (device->total_bytes > device->bytes_used +
> +				device->virtual_allocated)
> +			avail = device->total_bytes - device->bytes_used -
> +				device->virtual_allocated;
> +		else
> +			avail = 0;
> +
> +		/* And exclude the [0, 1M) reserved space */
> +		if (avail > SZ_1M)
> +			avail -= SZ_1M;
> +		else
> +			avail = 0;
> +
> +		if (avail < fs_info->sectorsize)
> +			continue;
> +		/*
> +		 * Unlike chunk allocator, we don't care about stripe or hole
> +		 * size, so here we use @avail directly
> +		 */
> +		devices_info[ndevs].dev_offset = 0;
> +		devices_info[ndevs].total_avail = avail;
> +		devices_info[ndevs].max_avail = avail;
> +		devices_info[ndevs].dev = device;
> +		++ndevs;
> +	}
> +	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
> +	     btrfs_cmp_device_info, NULL);
> +	ndevs -= ndevs % raid_attr->devs_increment;

nit: ndevs = rounddown(ndevs, raid_attr->devs_increment);
makes it more clear what's going on. Since you are working with at most
int it's not a problem for 32bits.


> +	if (ndevs < raid_attr->devs_min)
> +		return -ENOSPC;
> +	if (raid_attr->devs_max)
> +		ndevs = min(ndevs, (int)raid_attr->devs_max);
> +	else
> +		ndevs = min(ndevs, (int)BTRFS_MAX_DEVS(fs_info));

Instead of casting simply use min_t(int, ndevs, BTRFS_MAX_DEVS...)

> +
> +	/*
> +	 * Now allocate a virtual chunk using the unallocate space of the

nit: missing d after 'unallocate'

> +	 * device with the least unallocated space.
> +	 */
> +	stripe_size = round_down(devices_info[ndevs - 1].total_avail,
> +				 fs_info->sectorsize);
> +	if (stripe_size == 0)
> +		return -ENOSPC;

Isn't this check redundant - in the loop where you iterate the devices
you always ensure total_avail is at least a sector size, this guarantees
that stripe_size cannot be 0 at this point.

> +
> +	for (i = 0; i < ndevs; i++)
> +		devices_info[i].dev->virtual_allocated += stripe_size;
> +	*allocated = stripe_size * (ndevs - raid_attr->nparity) /
> +		     raid_attr->ncopies;
> +	return 0;
> +}
> +
> +static int calc_one_profile_avail(struct btrfs_fs_info *fs_info,
> +				  enum btrfs_raid_types type,
> +				  u64 *result_ret)
> +{
> +	struct btrfs_device_info *devices_info = NULL;
> +	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> +	struct btrfs_device *device;
> +	u64 allocated;
> +	u64 result = 0;
> +	int ret = 0;
> +

lockdep assert that chunk mutex is held since you access alloc_list.

> +	ASSERT(type >= 0 && type < BTRFS_NR_RAID_TYPES);
> +
> +	/* Not enough devices, quick exit, just update the result */
> +	if (fs_devices->rw_devices < btrfs_raid_array[type].devs_min)
> +		goto out;

You can directly return.

> +
> +	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
> +			       GFP_NOFS);
> +	if (!devices_info) {
> +		ret = -ENOMEM;
> +		goto out;

Same here.

> +	}
> +	/* Clear virtual chunk used space for each device */
> +	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list)
> +		device->virtual_allocated = 0;
> +	while (ret == 0) {
> +		ret = alloc_virtual_chunk(fs_info, devices_info, type,
> +					  &allocated);
The 'allocated' variable is used only in this loop so declare it in the
loop. Ideally we want variables to have the shortest possible lifecycle.

> +		if (ret == 0)
> +			result += allocated;
> +	}

Why do you need to call this in a loop calling alloc_virtual_chunk once
simply calculate the available space for the given raid type.

> +	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list)
> +		device->virtual_allocated = 0;
> +out:
> +	kfree(devices_info);
> +	if (ret < 0 && ret != -ENOSPC)
> +		return ret;
> +	*result_ret = result;
> +	return 0;
> +}

<snip>

> @@ -259,6 +266,10 @@ struct btrfs_fs_devices {
>  	struct kobject fsid_kobj;
>  	struct kobject *devices_kobj;
>  	struct completion kobj_unregister;
> +
> +	/* Records per-type available space */
> +	spinlock_t per_profile_lock;
> +	u64 per_profile_avail[BTRFS_NR_RAID_TYPES];

Since every avail quantity is independent of any other, can you turn
this into an array of atomic64 values and get rid of the spinlock? My
head spins how many locks we have in btrfs.

>  };
>  
>  #define BTRFS_BIO_INLINE_CSUM_SIZE	64
> 
