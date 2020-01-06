Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36DF01313A2
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 15:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgAFOcz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 09:32:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:42370 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgAFOcz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 09:32:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7F303AB3D;
        Mon,  6 Jan 2020 14:32:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 296AADA78B; Mon,  6 Jan 2020 15:32:43 +0100 (CET)
Date:   Mon, 6 Jan 2020 15:32:43 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 1/3] btrfs: Introduce per-profile available space
 facility
Message-ID: <20200106143242.GG3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20200106061343.18772-1-wqu@suse.com>
 <20200106061343.18772-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106061343.18772-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 06, 2020 at 02:13:41PM +0800, Qu Wenruo wrote:
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
> +static int alloc_virtual_chunk(struct btrfs_fs_info *fs_info,
> +			       struct btrfs_device_info *devices_info,
> +			       enum btrfs_raid_types type,
> +			       u64 to_alloc, u64 *allocated)
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
> +		if (avail == 0)
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
> +	if (ndevs < raid_attr->devs_min)
> +		return -ENOSPC;
> +	if (raid_attr->devs_max)
> +		ndevs = min(ndevs, (int)raid_attr->devs_max);
> +	else
> +		ndevs = min(ndevs, (int)BTRFS_MAX_DEVS(fs_info));
> +
> +	/*
> +	 * Now allocate a virtual chunk using the unallocate space of the
> +	 * device with the least unallocated space.
> +	 */
> +	stripe_size = round_down(devices_info[ndevs - 1].total_avail,
> +				 fs_info->sectorsize);
> +
> +	/* We can't directly do round_up for (u64)-1 as that would result 0 */
> +	if (to_alloc != (u64)-1)
> +		stripe_size = min_t(u64, stripe_size,
> +				    round_up(div_u64(to_alloc, ndevs),
> +					     fs_info->sectorsize));
> +	if (stripe_size == 0)
> +		return -ENOSPC;
> +
> +	for (i = 0; i < ndevs; i++)
> +		devices_info[i].dev->virtual_allocated += stripe_size;
> +	*allocated = stripe_size * (ndevs - raid_attr->nparity) /
> +		     raid_attr->ncopies;
> +	return 0;
> +}
> +
> +static int calc_one_profile_avail(struct btrfs_fs_info *fs_info,
> +				  enum btrfs_raid_types type)
> +{
> +	struct btrfs_device_info *devices_info = NULL;
> +	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> +	struct btrfs_device *device;
> +	u64 allocated;
> +	u64 result = 0;
> +	int ret = 0;
> +
> +	ASSERT(type >= 0 && type < BTRFS_NR_RAID_TYPES);
> +
> +	/* Not enough devices, quick exit, just update the result */
> +	if (fs_devices->rw_devices < btrfs_raid_array[type].devs_min)
> +		goto out;
> +
> +	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
> +			       GFP_NOFS);

Calling kcalloc is another potential slowdown, for the statfs
considerations.

> +	if (!devices_info) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	/* Clear virtual chunk used space for each device */
> +	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list)
> +		device->virtual_allocated = 0;
> +	while (ret == 0) {
> +		ret = alloc_virtual_chunk(fs_info, devices_info, type,
> +					  (u64)-1, &allocated);
> +		if (ret == 0)
> +			result += allocated;
> +	}
> +	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list)
> +		device->virtual_allocated = 0;
> +out:
> +	kfree(devices_info);
> +	if (ret < 0 && ret != -ENOSPC)
> +		return ret;
> +	spin_lock(&fs_devices->per_profile_lock);
> +	fs_devices->per_profile_avail[type] = result;
> +	spin_unlock(&fs_devices->per_profile_lock);
> +	return 0;
> +}
> +
> +/*
> + * Calculate the per-profile available space array.
> + *
> + * Return 0 if we succeeded updating the array.
> + * Return <0 if something went wrong. (ENOMEM)
> + */
> +static int calc_per_profile_avail(struct btrfs_fs_info *fs_info)
> +{
> +	int i;
> +	int ret;
> +
> +	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++) {
> +		ret = calc_one_profile_avail(fs_info, i);
> +		if (ret < 0)
> +			break;
> +	}
> +	return ret;
> +}
> +
>  int btrfs_grow_device(struct btrfs_trans_handle *trans,
>  		      struct btrfs_device *device, u64 new_size)
>  {
> @@ -2635,6 +2806,7 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
>  	struct btrfs_super_block *super_copy = fs_info->super_copy;
>  	u64 old_total;
>  	u64 diff;
> +	int ret;
>  
>  	if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state))
>  		return -EACCES;
> @@ -2661,7 +2833,12 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
>  	if (list_empty(&device->post_commit_list))
>  		list_add_tail(&device->post_commit_list,
>  			      &trans->transaction->dev_update_list);
> +	ret = calc_per_profile_avail(fs_info);
>  	mutex_unlock(&fs_info->chunk_mutex);
> +	if (ret < 0) {
> +		btrfs_abort_transaction(trans, ret);
> +		return ret;
> +	}
>  
>  	return btrfs_update_device(trans, device);
>  }
> @@ -2831,7 +3008,13 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
>  					device->bytes_used - dev_extent_len);
>  			atomic64_add(dev_extent_len, &fs_info->free_chunk_space);
>  			btrfs_clear_space_info_full(fs_info);
> +			ret = calc_per_profile_avail(fs_info);

Adding new failure modes

>  			mutex_unlock(&fs_info->chunk_mutex);
> +			if (ret < 0) {
> +				mutex_unlock(&fs_devices->device_list_mutex);
> +				btrfs_abort_transaction(trans, ret);
> +				goto out;
> +			}
>  		}
>  
>  		ret = btrfs_update_device(trans, device);
> @@ -4526,6 +4709,12 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
>  		atomic64_sub(diff, &fs_info->free_chunk_space);
>  	}
>  
> +	ret = calc_per_profile_avail(fs_info);
> +	if (ret < 0) {
> +		btrfs_abort_transaction(trans, ret);
> +		btrfs_end_transaction(trans);
> +		goto done;
> +	}
>  	/*
>  	 * Once the device's size has been set to the new size, ensure all
>  	 * in-memory chunks are synced to disk so that the loop below sees them
> @@ -4690,25 +4879,6 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
>  	return 0;
>  }
>  
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -138,6 +138,13 @@ struct btrfs_device {
>  	atomic_t dev_stat_values[BTRFS_DEV_STAT_VALUES_MAX];
>  
>  	struct extent_io_tree alloc_state;
> +
> +	/*
> +	 * the "virtual" allocated space by virtual chunk allocator, which
> +	 * is used to do accurate estimation on available space.
> +	 * Doesn't affect real chunk allocator.
> +	 */
> +	u64 virtual_allocated;

I find it a bit confusing to use 'virtual', though I get what you mean.
As this is per-device it accounts overall space, so the name should
reflect somthing like that. I maybe have a more concrete suggestion once
I read through the whole series.
