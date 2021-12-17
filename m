Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4944790EB
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 17:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbhLQQFg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 11:05:36 -0500
Received: from syrinx.knorrie.org ([82.94.188.77]:46838 "EHLO
        syrinx.knorrie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbhLQQFf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 11:05:35 -0500
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Dec 2021 11:05:35 EST
Received: from [IPv6:2a02:a213:2b80:4c00::12] (unknown [IPv6:2a02:a213:2b80:4c00::12])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by syrinx.knorrie.org (Postfix) with ESMTPSA id 2487961038994;
        Fri, 17 Dec 2021 16:58:37 +0100 (CET)
Subject: Re: [PATCH 4/4] btrfs: add allocator_hint mode
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <cover.1635089352.git.kreijack@inwind.it>
 <bf30502eb53ea2c1c05c2ae96c3788d3e327d59e.1635089352.git.kreijack@inwind.it>
From:   Hans van Kranenburg <hans@knorrie.org>
Message-ID: <0fbfde93-3a00-7f20-8891-dd0fa798676e@knorrie.org>
Date:   Fri, 17 Dec 2021 16:58:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <bf30502eb53ea2c1c05c2ae96c3788d3e327d59e.1635089352.git.kreijack@inwind.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On 10/24/21 5:31 PM, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> When this mode is enabled, the chunk allocation policy is modified as
> follow.
> 
> Each disk may have a different tag:
> - BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
> - BTRFS_DEV_ALLOCATION_METADATA_ONLY
> - BTRFS_DEV_ALLOCATION_DATA_ONLY
> - BTRFS_DEV_ALLOCATION_PREFERRED_DATA (default)
> 
> Where:
> - ALLOCATION_PREFERRED_X means that it is preferred to use this disk for
> the X chunk type (the other type may be allowed when the space is low)
> - ALLOCATION_X_ONLY means that it is used *only* for the X chunk type.
> This means also that it is a preferred choice.
> 
> Each time the allocator allocates a chunk of type X , first it takes the
> disks tagged as ALLOCATION_X_ONLY or ALLOCATION_PREFERRED_X; if the space
> is not enough, it uses also the disks tagged as ALLOCATION_METADATA_ONLY;
> if the space is not enough, it uses also the other disks, with the
> exception of the one marked as ALLOCATION_PREFERRED_Y, where Y the other
> type of chunk (i.e. not X).

I read this last paragraph for 5 times now, I think, but I still have no
idea what's going on here. Can you rephrase it? It's more complex than
the actual code below.

What the above text tells me is that if I start filling up my disks, it
will happily write DATA to METADATA_ONLY disks when the DATA ones are
full? And if the METADATA_ONLY disks are full with DATA also, it will
not write DATA into PREFERRED_METADATA disks.

I don't think that's what the code actually does. At least, I hope not.

Hans

> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>  fs/btrfs/volumes.c | 98 +++++++++++++++++++++++++++++++++++++++++++++-
>  fs/btrfs/volumes.h |  1 +
>  2 files changed, 98 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 8ac99771f43c..7ee9c6e7bd44 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -153,6 +153,20 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
>  	},
>  };
>  
> +#define BTRFS_DEV_ALLOCATION_MASK ((1ULL << \
> +		BTRFS_DEV_ALLOCATION_MASK_BIT_COUNT) - 1)
> +#define BTRFS_DEV_ALLOCATION_MASK_COUNT (1ULL << \
> +		BTRFS_DEV_ALLOCATION_MASK_BIT_COUNT)
> +
> +static const char alloc_hint_map[BTRFS_DEV_ALLOCATION_MASK_COUNT] = {
> +	[BTRFS_DEV_ALLOCATION_DATA_ONLY] = -1,
> +	[BTRFS_DEV_ALLOCATION_PREFERRED_DATA] = 0,
> +	[BTRFS_DEV_ALLOCATION_PREFERRED_METADATA] = 1,
> +	[BTRFS_DEV_ALLOCATION_METADATA_ONLY] = 2,
> +	/* the other values are set to 0 */
> +};
> +
> +
>  const char *btrfs_bg_type_to_raid_name(u64 flags)
>  {
>  	const int index = btrfs_bg_flags_to_raid_index(flags);
> @@ -4997,13 +5011,18 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
>  }
>  
>  /*
> - * sort the devices in descending order by max_avail, total_avail
> + * sort the devices in descending order by alloc_hint,
> + * max_avail, total_avail
>   */
>  static int btrfs_cmp_device_info(const void *a, const void *b)
>  {
>  	const struct btrfs_device_info *di_a = a;
>  	const struct btrfs_device_info *di_b = b;
>  
> +	if (di_a->alloc_hint > di_b->alloc_hint)
> +		return -1;
> +	if (di_a->alloc_hint < di_b->alloc_hint)
> +		return 1;
>  	if (di_a->max_avail > di_b->max_avail)
>  		return -1;
>  	if (di_a->max_avail < di_b->max_avail)
> @@ -5166,6 +5185,8 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>  	int ndevs = 0;
>  	u64 max_avail;
>  	u64 dev_offset;
> +	int hint;
> +	int i;
>  
>  	/*
>  	 * in the first pass through the devices list, we gather information
> @@ -5218,16 +5239,91 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>  		devices_info[ndevs].max_avail = max_avail;
>  		devices_info[ndevs].total_avail = total_avail;
>  		devices_info[ndevs].dev = device;
> +
> +		if ((ctl->type & BTRFS_BLOCK_GROUP_DATA) &&
> +		     (ctl->type & BTRFS_BLOCK_GROUP_METADATA)) {
> +			/*
> +			 * if mixed bg set all the alloc_hint
> +			 * fields to the same value, so the sorting
> +			 * is not affected
> +			 */
> +			devices_info[ndevs].alloc_hint = 0;
> +		} else if (ctl->type & BTRFS_BLOCK_GROUP_DATA) {
> +			hint = device->type & BTRFS_DEV_ALLOCATION_MASK;
> +
> +			/*
> +			 * skip BTRFS_DEV_METADATA_ONLY disks
> +			 */
> +			if (hint == BTRFS_DEV_ALLOCATION_METADATA_ONLY)
> +				continue;
> +			/*
> +			 * if a data chunk must be allocated,
> +			 * sort also by hint (data disk
> +			 * higher priority)
> +			 */
> +			devices_info[ndevs].alloc_hint = -alloc_hint_map[hint];
> +		} else { /* BTRFS_BLOCK_GROUP_METADATA */
> +			hint = device->type & BTRFS_DEV_ALLOCATION_MASK;
> +
> +			/*
> +			 * skip BTRFS_DEV_DATA_ONLY disks
> +			 */
> +			if (hint == BTRFS_DEV_ALLOCATION_DATA_ONLY)
> +				continue;
> +			/*
> +			 * if a data chunk must be allocated,
> +			 * sort also by hint (metadata hint
> +			 * higher priority)
> +			 */
> +			devices_info[ndevs].alloc_hint = alloc_hint_map[hint];
> +		}
> +
>  		++ndevs;
>  	}
>  	ctl->ndevs = ndevs;
>  
> +	/*
> +	 * no devices available
> +	 */
> +	if (!ndevs)
> +		return 0;
> +
>  	/*
>  	 * now sort the devices by hole size / available space
>  	 */
>  	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>  	     btrfs_cmp_device_info, NULL);
>  
> +	/*
> +	 * select the minimum set of disks grouped by hint that
> +	 * can host the chunk
> +	 */
> +	ndevs = 0;
> +	while (ndevs < ctl->ndevs) {
> +		hint = devices_info[ndevs++].alloc_hint;
> +		while (ndevs < ctl->ndevs &&
> +		       devices_info[ndevs].alloc_hint == hint)
> +				ndevs++;
> +		if (ndevs >= ctl->devs_min)
> +			break;
> +	}
> +
> +	BUG_ON(ndevs > ctl->ndevs);
> +	ctl->ndevs = ndevs;
> +
> +	/*
> +	 * the next layers require the devices_info ordered by
> +	 * max_avail. If we are returing two (or more) different
> +	 * group of alloc_hint, this is not always true. So sort
> +	 * these gain.
> +	 */
> +
> +	for (i = 0 ; i < ndevs ; i++)
> +		devices_info[i].alloc_hint = 0;
> +
> +	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
> +	     btrfs_cmp_device_info, NULL);
> +
>  	return 0;
>  }
>  
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index b8250f29df6e..37eb37b533c5 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -369,6 +369,7 @@ struct btrfs_device_info {
>  	u64 dev_offset;
>  	u64 max_avail;
>  	u64 total_avail;
> +	int alloc_hint;
>  };
>  
>  struct btrfs_raid_attr {
> 

