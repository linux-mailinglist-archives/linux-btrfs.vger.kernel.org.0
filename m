Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 633C517FE6F
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Mar 2020 14:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgCJNfK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 09:35:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:43288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728094AbgCJNfJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 09:35:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 624C3ADFF;
        Tue, 10 Mar 2020 13:35:07 +0000 (UTC)
Subject: Re: [PATCH v8 1/5] btrfs: Introduce per-profile available space
 facility
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
References: <20200221061107.65981-1-wqu@suse.com>
 <20200221061107.65981-2-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <63b7d8bc-3d3a-af4f-3232-dbc27fd3fb0a@suse.com>
Date:   Tue, 10 Mar 2020 15:35:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221061107.65981-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21.02.20 г. 8:11 ч., Qu Wenruo wrote:
> [PROBLEM]
> There are some locations in btrfs requiring accurate estimation on how
> many new bytes can be allocated on unallocated space.
> 
> We have two types of estimation:
> - Factor based calculation
>   Just use all unallocated space, divide by the profile factor
>   One obvious user is can_overcommit().
> 
> - Chunk allocator like calculation
>   This will emulate the chunk allocator behavior, to get a proper
>   estimation.
>   The only user is btrfs_calc_avail_data_space(), utilized by
>   btrfs_statfs().
>   The problem is, that function is not generic purposed enough, can't
>   handle things like RAID5/6.
> 
> Current factor based calculation can't handle the following case:
>   devid 1 unallocated:	1T
>   devid 2 unallocated:	10T
>   metadata type:	RAID1
> 
> If using factor, we can use (1T + 10T) / 2 = 5.5T free space for
> metadata.
> But in fact we can only get 1T free space, as we're limited by the
> smallest device for RAID1.
> 
> [SOLUTION]
> This patch will introduce per-profile available space calculation,
> which can give an estimation based on chunk-allocator-like behavior.
> 
> The difference between it and chunk allocator is mostly on rounding and
> [0, 1M) reserved space handling, which shouldn't cause practical impact.
> 
> The newly introduced per-profile available space calculation will
> calculate available space for each type, using chunk-allocator like
> calculation.
> 
> With that facility, for above device layout we get the full available
> space array:
>   RAID10:	0  (not enough devices)
>   RAID1:	1T
>   RAID1C3:	0  (not enough devices)
>   RAID1C4:	0  (not enough devices)
>   DUP:		5.5T
>   RAID0:	2T
>   SINGLE:	11T
>   RAID5:	1T
>   RAID6:	0  (not enough devices)
> 
> Or for a more complex example:
>   devid 1 unallocated:	1T
>   devid 2 unallocated:  1T
>   devid 3 unallocated:	10T
> 
> We will get an array of:
>   RAID10:	0  (not enough devices)
>   RAID1:	2T
>   RAID1C3:	1T
>   RAID1C4:	0  (not enough devices)
>   DUP:		6T
>   RAID0:	3T
>   SINGLE:	12T
>   RAID5:	2T
>   RAID6:	0  (not enough devices)
> 
> And for the each profile , we go chunk allocator level calculation:
> The pseudo code looks like:
> 
>   clear_virtual_used_space_of_all_rw_devices();
>   do {
>   	/*
>   	 * The same as chunk allocator, despite used space,
>   	 * we also take virtual used space into consideration.
>   	 */
>   	sort_device_with_virtual_free_space();
> 
>   	/*
>   	 * Unlike chunk allocator, we don't need to bother hole/stripe
>   	 * size, so we use the smallest device to make sure we can
>   	 * allocated as many stripes as regular chunk allocator
>   	 */
>   	stripe_size = device_with_smallest_free->avail_space;
> 	stripe_size = min(stripe_size, to_alloc / ndevs);
> 
>   	/*
>   	 * Allocate a virtual chunk, allocated virtual chunk will
>   	 * increase virtual used space, allow next iteration to
>   	 * properly emulate chunk allocator behavior.
>   	 */
>   	ret = alloc_virtual_chunk(stripe_size, &allocated_size);
>   	if (ret == 0)
>   		avail += allocated_size;
>   } while (ret == 0)
> 
> As we always select the device with least free space, the device with
> the most space will be the first to be utilized, just like chunk
> allocator.
> For above 1T + 10T device, we will allocate a 1T virtual chunk
> in the first iteration, then run out of device in next iteration.
> 
> Thus only get 1T free space for RAID1 type, just like what chunk
> allocator would do.
> 
> The patch will update such per-profile available space at the following
> timing:
> - Mount time
> - Chunk allocation
> - Chunk removal
> - Device grow
> - Device shrink
> - Device add
> - Device removal
> 
> Those timing are all protected by chunk_mutex, and what we do are only
> iterating in-memory only structures, no extra IO triggered, so the
> performance impact should be pretty small.
> 
> For the extra error handling, the principle is to keep the old behavior.
> That's to say, if old error handler would just return an error, then we
> follow it, no matter if the caller reverts the device size.
> 
> For the proper error handling, they will be added in later patches.
> As I don't want to make the core facility bloated by the error handling
> code, especially some situation needs quite some new code to handle
> errors.
> 
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Apart from one minor nit below:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  fs/btrfs/volumes.c | 217 ++++++++++++++++++++++++++++++++++++++++-----
>  fs/btrfs/volumes.h |  10 +++
>  2 files changed, 207 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 9cfc668f91f4..e04e3f6e55f4 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1949,6 +1949,171 @@ static u64 btrfs_num_devices(struct btrfs_fs_info *fs_info)
>  	return num_devices;
>  }
>  
<snip>

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
> +	lockdep_assert_held(&fs_info->chunk_mutex);
> +	ASSERT(type >= 0 && type < BTRFS_NR_RAID_TYPES);
> +
> +	/* Not enough devices, quick exit, just update the result */
> +	if (fs_devices->rw_devices < btrfs_raid_array[type].devs_min)
> +		goto out;
> +
> +	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
> +			       GFP_NOFS);
> +	if (!devices_info) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	/* Clear virtual chunk used space for each device */
> +	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list)
> +		device->virtual_allocated = 0;
> +
> +	while (!alloc_virtual_chunk(fs_info, devices_info, type, &allocated))
> +		result += allocated;
> +
> +	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list)
> +		device->virtual_allocated = 0;

nit: This second list_for_each_entry is redundant because
alloc_virtual_chunk is guaranteed to be called with zeroed
device->virtual_allocated because of the list_for_each_entry before the
while(). Furthermore this call path is under chunk_mutex so no one can
sneak in and change it .

<snip>
