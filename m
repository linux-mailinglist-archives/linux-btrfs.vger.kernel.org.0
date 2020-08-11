Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2008424185F
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 10:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgHKIlD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 04:41:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:33922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbgHKIlD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 04:41:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 32CE8B1ED;
        Tue, 11 Aug 2020 08:41:22 +0000 (UTC)
Subject: Re: [PATCH v4] btrfs: trim: fix underflow in trim length to prevent
 access beyond device boundary
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
References: <20200731112911.115665-1-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5cda2c95-e407-8b11-e206-20c4aac5d48b@suse.com>
Date:   Tue, 11 Aug 2020 11:41:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731112911.115665-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 31.07.20 г. 14:29 ч., Qu Wenruo wrote:
> [BUG]
> The following script can lead to tons of beyond device boundary access:
> 
>   mkfs.btrfs -f $dev -b 10G
>   mount $dev $mnt
>   trimfs $mnt
>   btrfs filesystem resize 1:-1G $mnt
>   trimfs $mnt
> 
> [CAUSE]
> Since commit 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to
> find_first_clear_extent_bit"), we try to avoid trimming ranges that's
> already trimmed.
> 
> So we check device->alloc_state by finding the first range which doesn't
> have CHUNK_TRIMMED and CHUNK_ALLOCATED not set.
> 
> But if we shrunk the device, that bits are not cleared, thus we could
> easily got a range starts beyond the shrunk device size.
> 
> This results the returned @start and @end are all beyond device size,
> then we call "end = min(end, device->total_bytes -1);" making @end
> smaller than device size.
> 
> Then finally we goes "len = end - start + 1", totally underflow the
> result, and lead to the beyond-device-boundary access.
> 
> [FIX]
> This patch will fix the problem in two ways:
> - Clear CHUNK_TRIMMED | CHUNK_ALLOCATED bits when shrinking device
>   This is the root fix
> 
> - Add extra safe net when trimming free device extents
>   We check and warn if the returned range is already beyond current
>   device.
> 
> Link: https://github.com/kdave/btrfs-progs/issues/282
> Fixes: 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to find_first_clear_extent_bit")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> ---
> Changelog:
> v2:
> - Add proper fixes tag
> - Add extra warning for beyond device end case
> - Add graceful exit for already trimmed case
> v3:
> - Don't return EUCLEAN for beyond boundary access
> - Rephrase the warning message for beyond boundary access
> v4:
> - Remove one duplicated check on exiting the trim loop
> ---
>  fs/btrfs/extent-tree.c | 14 ++++++++++++++
>  fs/btrfs/volumes.c     | 12 ++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index fa7d83051587..6b1b5dfba4b3 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -33,6 +33,7 @@
>  #include "delalloc-space.h"
>  #include "block-group.h"
>  #include "discard.h"
> +#include "rcu-string.h"
>  
>  #undef SCRAMBLE_DELAYED_REFS
>  
> @@ -5669,6 +5670,19 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
>  					    &start, &end,
>  					    CHUNK_TRIMMED | CHUNK_ALLOCATED);
>  
> +		/* CHUNK_* bits not cleared properly */
> +		if (start > device->total_bytes) {
> +			WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> +			btrfs_warn_in_rcu(fs_info,
> +"ignoring attempt to trim beyond device size: offset %llu length %llu device %s device size %llu",
> +					  start, end - start + 1,
> +					  rcu_str_deref(device->name),
> +					  device->total_bytes);
> +			mutex_unlock(&fs_info->chunk_mutex);
> +			ret = 0;
> +			break;
> +		}

Isn't this a NOOP, because the latter chunk ensures we can never cross
device->total_bytes. Since this is a purely defensive mechanism and
following this patch we *should* never have CHUNK_* bits set beyond
device->total_bytes I'd say make this an ASSERT(). Otherwise you force
people to pay the cost of the check for every trim ...


> +
>  		/* Ensure we skip the reserved area in the first 1M */
>  		start = max_t(u64, start, SZ_1M);
>  
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index d7670e2a9f39..4e51ef68ea72 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4720,6 +4720,18 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
>  	}
>  
>  	mutex_lock(&fs_info->chunk_mutex);
> +	/*
> +	 * Also clear any CHUNK_TRIMMED and CHUNK_ALLOCATED bits beyond the
> +	 * current device boundary.
> +	 * This shouldn't fail, as alloc_state should only utilize those two
> +	 * bits, thus we shouldn't alloc new memory for clearing the status.
> +	 *
> +	 * So here we just do an ASSERT() to catch future behavior change.
> +	 */
> +	ret = clear_extent_bits(&device->alloc_state, new_size, (u64)-1,
> +				CHUNK_TRIMMED | CHUNK_ALLOCATED);
> +	ASSERT(!ret);

I agree with this part.

> +
>  	btrfs_device_set_disk_total_bytes(device, new_size);
>  	if (list_empty(&device->post_commit_list))
>  		list_add_tail(&device->post_commit_list,
> 
