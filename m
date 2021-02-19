Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1722931FEFD
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 19:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhBSSwL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 13:52:11 -0500
Received: from smtp-35.italiaonline.it ([213.209.10.35]:42798 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229607AbhBSSwK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 13:52:10 -0500
Received: from venice.bhome ([78.12.28.43])
        by smtp-35.iol.local with ESMTPA
        id DAsAld3mBpK9wDAsAlawsC; Fri, 19 Feb 2021 19:51:26 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1613760686; bh=uSQMCjMSi8PGAWle3j9XimKVBc24GzyDFsWvYHU9Utc=;
        h=From;
        b=ns0kenOHtzFxYrQx3E+9JroR2CEdmpdMI13YdwY4ZM0y8zjh08NLmYAtBzwYpoGSX
         p0oBWBmlCnReajpO/Ofb6SN33OAo/dBlKLHcSk7UpXTJnAgJeyWCDg/mxjKvxl7WCA
         iHpNWDuvfCBXdIPgEMrGVhpeXQkL1vqo9O1OdmHjQWwi6aw+tuHEBBcqk4umRbmg7M
         wi705mnsWnDDUXojE2ZnGww0o/gmKb6zIqTso9PBkuhFogiYXFqvNdqvYWgJGUBbbB
         Ezib+Dizj+JaX0MQSANSIlRdD8fEOS3O5qbQIkpj4X1Gg9iuhkEYowDtfiW9Bcqll+
         uGNkMtzg0/kBg==
X-CNFS-Analysis: v=2.4 cv=A9ipg4aG c=1 sm=1 tr=0 ts=603008ae cx=a_exe
 a=Q5/16X4GlyvtzKxRBiE+Uw==:117 a=Q5/16X4GlyvtzKxRBiE+Uw==:17
 a=IkcTkHD0fZMA:10 a=5KUk36yq9OGYE-mmDloA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 5/5] btrfs: add allocator_hint mode
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>
References: <20210201212820.64381-1-kreijack@libero.it>
 <20210201212820.64381-6-kreijack@libero.it>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <396b3709-a0b2-a0ee-00b8-75e4ca91b0e7@inwind.it>
Date:   Fri, 19 Feb 2021 19:51:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210201212820.64381-6-kreijack@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIZrTbxmVuStT6si5cqGDhAeJUNnCYYAtpaj6PV89hiYQeiO+XAu2YOrDvXrG6MoGfys3qXfJUDrG1AFxG+87mmq6PT7xhhtYyX8n9WkOXiYPuxyiYPv
 wfGlsdQXofhaDPGutX6V2K4hoN9FI4mTJGOj+wS+gM5mAOaQbP9X4jN+NR2M1nnigex3TsvjaZ8UBVT5Dp/JjL9NelWxeyux7jS6Tfbw2opq7t53P7SmCEis
 lzPnYYn0g2iI1Grm6rsW8FRuCPPHUdkcUgbdknrDnLci7Ya3EjRiCcXGs6y3h195
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/1/21 10:28 PM, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> When this mode is enabled, the chunk allocation policy is modified as follow.
> 
> Each disk may have a different tag:
> - BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
> - BTRFS_DEV_ALLOCATION_METADATA_ONLY
> - BTRFS_DEV_ALLOCATION_DATA_ONLY
> - BTRFS_DEV_ALLOCATION_PREFERRED_DATA (default)
> 
> Where:
> - ALLOCATION_PREFERRED_X means that it is preferred to use this disk for the
> X chunk type (the other type may be allowed when the space is low)
> - ALLOCATION_X_ONLY means that it is used *only* for the X chunk type. This
> means also that it is a preferred choice.
> 
> Each time the allocator allocates a chunk of type X , first it takes the disks
> tagged as ALLOCATION_X_ONLY or ALLOCATION_PREFERRED_X; if the space is not
> enough, it uses also the disks tagged as ALLOCATION_METADATA_ONLY; if the space
> is not enough, it uses also the other disks, with the exception of the one
> marked as ALLOCATION_PREFERRED_Y, where Y the other type of chunk (i.e. not X).
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>   fs/btrfs/volumes.c | 81 +++++++++++++++++++++++++++++++++++++++++++++-
>   fs/btrfs/volumes.h |  1 +
>   2 files changed, 81 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 68b346c5465d..57ee3e2fdac0 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4806,13 +4806,18 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
>   }
>   
>   /*
> - * sort the devices in descending order by max_avail, total_avail
> + * sort the devices in descending order by alloc_hint,
> + * max_avail, total_avail
>    */
>   static int btrfs_cmp_device_info(const void *a, const void *b)
>   {
>   	const struct btrfs_device_info *di_a = a;
>   	const struct btrfs_device_info *di_b = b;
>   
> +	if (di_a->alloc_hint > di_b->alloc_hint)
> +		return -1;
> +	if (di_a->alloc_hint < di_b->alloc_hint)
> +		return 1;
>   	if (di_a->max_avail > di_b->max_avail)
>   		return -1;
>   	if (di_a->max_avail < di_b->max_avail)
> @@ -4939,6 +4944,15 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>   	int ndevs = 0;
>   	u64 max_avail;
>   	u64 dev_offset;
> +	int hint;
> +
> +	static const char alloc_hint_map[BTRFS_DEV_ALLOCATION_MASK_COUNT] = {
> +		[BTRFS_DEV_ALLOCATION_DATA_ONLY] = -1,
> +		[BTRFS_DEV_ALLOCATION_PREFERRED_DATA] = 0,
> +		[BTRFS_DEV_ALLOCATION_METADATA_ONLY] = 1,
> +		[BTRFS_DEV_ALLOCATION_PREFERRED_METADATA] = 2

Finally I found the reason of the wrong allocation. The last two values
are swapped: the priority starts from BTRFS_DEV_ALLOCATION_DATA_ONLY
and ends to BTRFS_DEV_ALLOCATION_METADATA_ONLY.

Ok, now I have to restart the tests :-)

> +		/* the other values are set to 0 */
> +	};
>   
>   	/*
>   	 * in the first pass through the devices list, we gather information
> @@ -4991,16 +5005,81 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>   		devices_info[ndevs].max_avail = max_avail;
>   		devices_info[ndevs].total_avail = total_avail;
>   		devices_info[ndevs].dev = device;
> +
> +		if (((ctl->type & BTRFS_BLOCK_GROUP_DATA) &&
> +		     (ctl->type & BTRFS_BLOCK_GROUP_METADATA)) ||
> +		    info->allocation_hint_mode ==
> +		     BTRFS_ALLOCATION_HINT_DISABLED) {
> +			/*
> +			 * if mixed bg or the allocator hint is
> +			 * disable, set all the alloc_hint
> +			 * fields to the same value, so the sorting
> +			 * is not affected
> +			 */
> +			devices_info[ndevs].alloc_hint = 0;
> +		} else if(ctl->type & BTRFS_BLOCK_GROUP_DATA) {
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
>   		++ndevs;
>   	}
>   	ctl->ndevs = ndevs;
>   
> +	/*
> +	 * no devices available
> +	 */
> +	if (!ndevs)
> +		return 0;
> +
>   	/*
>   	 * now sort the devices by hole size / available space
>   	 */
>   	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>   	     btrfs_cmp_device_info, NULL);
>   
> +	/*
> +	 * select the minimum set of disks grouped by hint that
> +	 * can host the chunk
> +	 */
> +	ndevs = 0;
> +	while (ndevs < ctl->ndevs) {
> +		hint = devices_info[ndevs++].alloc_hint;
> +		while (devices_info[ndevs].alloc_hint == hint &&
> +		       ndevs < ctl->ndevs)
> +				ndevs++;
> +		if (ndevs >= ctl->devs_min)
> +			break;
> +	}
> +
> +	BUG_ON(ndevs > ctl->ndevs);
> +	ctl->ndevs = ndevs;
> +
>   	return 0;
>   }
>   
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index d776b7f55d56..31a3e4cf93b5 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -364,6 +364,7 @@ struct btrfs_device_info {
>   	u64 dev_offset;
>   	u64 max_avail;
>   	u64 total_avail;
> +	int alloc_hint;
>   };
>   
>   struct btrfs_raid_attr {
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
