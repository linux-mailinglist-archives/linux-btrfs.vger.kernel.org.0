Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73915174ED0
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2020 18:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgCAR6F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 12:58:05 -0500
Received: from mail.itouring.de ([188.40.134.68]:41860 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgCAR6F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 1 Mar 2020 12:58:05 -0500
Received: from tux.applied-asynchrony.com (p5B07E2B3.dip0.t-ipconnect.de [91.7.226.179])
        by mail.itouring.de (Postfix) with ESMTPSA id 17544416D6C2;
        Sun,  1 Mar 2020 18:58:03 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id C68A7F01606;
        Sun,  1 Mar 2020 18:58:02 +0100 (CET)
Subject: Re: [PATCH][RESEND] btrfs: kill update_block_group_flags
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200117140826.42616-1-josef@toxicpanda.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <2e16f37e-014e-6d86-76c6-801d6cb7bc20@applied-asynchrony.com>
Date:   Sun, 1 Mar 2020 18:58:02 +0100
MIME-Version: 1.0
In-Reply-To: <20200117140826.42616-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/17/20 3:08 PM, Josef Bacik wrote:
> btrfs/061 has been failing consistently for me recently with a
> transaction abort.  We run out of space in the system chunk array, which
> means we've allocated way too many system chunks than we need.
> 
> Chris added this a long time ago for balance as a poor mans restriping.
> If you had a single disk and then added another disk and then did a
> balance, update_block_group_flags would then figure out which RAID level
> you needed.
> 
> Fast forward to today and we have restriping behavior, so we can
> explicitly tell the fs that we're trying to change the raid level.  This
> is accomplished through the normal get_alloc_profile path.
> 
> Furthermore this code actually causes btrfs/061 to fail, because we do
> things like mkfs -m dup -d single with multiple devices.  This trips
> this check
> 
> alloc_flags = update_block_group_flags(fs_info, cache->flags);
> if (alloc_flags != cache->flags) {
> 	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
> 
> in btrfs_inc_block_group_ro.  Because we're balancing and scrubbing, but
> not actually restriping, we keep forcing chunk allocation of RAID1
> chunks.  This eventually causes us to run out of system space and the
> file system aborts and flips read only.
> 
> We don't need this poor mans restriping any more, simply use the normal
> get_alloc_profile helper, which will get the correct alloc_flags and
> thus make the right decision for chunk allocation.  This keeps us from
> allocating a billion system chunks and falling over.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> - Just rebased onto misc-next.
> 
>   fs/btrfs/block-group.c | 52 ++----------------------------------------
>   1 file changed, 2 insertions(+), 50 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 7e71ec9682d0..77ec0597bd17 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2132,54 +2132,6 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
>   	return 0;
>   }
>   
> -static u64 update_block_group_flags(struct btrfs_fs_info *fs_info, u64 flags)
> -{
> -	u64 num_devices;
> -	u64 stripped;
> -
> -	/*
> -	 * if restripe for this chunk_type is on pick target profile and
> -	 * return, otherwise do the usual balance
> -	 */
> -	stripped = get_restripe_target(fs_info, flags);
> -	if (stripped)
> -		return extended_to_chunk(stripped);
> -
> -	num_devices = fs_info->fs_devices->rw_devices;
> -
> -	stripped = BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID56_MASK |
> -		BTRFS_BLOCK_GROUP_RAID1_MASK | BTRFS_BLOCK_GROUP_RAID10;
> -
> -	if (num_devices == 1) {
> -		stripped |= BTRFS_BLOCK_GROUP_DUP;
> -		stripped = flags & ~stripped;
> -
> -		/* turn raid0 into single device chunks */
> -		if (flags & BTRFS_BLOCK_GROUP_RAID0)
> -			return stripped;
> -
> -		/* turn mirroring into duplication */
> -		if (flags & (BTRFS_BLOCK_GROUP_RAID1_MASK |
> -			     BTRFS_BLOCK_GROUP_RAID10))
> -			return stripped | BTRFS_BLOCK_GROUP_DUP;
> -	} else {
> -		/* they already had raid on here, just return */
> -		if (flags & stripped)
> -			return flags;
> -
> -		stripped |= BTRFS_BLOCK_GROUP_DUP;
> -		stripped = flags & ~stripped;
> -
> -		/* switch duplicated blocks with raid1 */
> -		if (flags & BTRFS_BLOCK_GROUP_DUP)
> -			return stripped | BTRFS_BLOCK_GROUP_RAID1;
> -
> -		/* this is drive concat, leave it alone */
> -	}
> -
> -	return flags;
> -}
> -
>   /*
>    * Mark one block group RO, can be called several times for the same block
>    * group.
> @@ -2225,7 +2177,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
>   		 * If we are changing raid levels, try to allocate a
>   		 * corresponding block group with the new raid level.
>   		 */
> -		alloc_flags = update_block_group_flags(fs_info, cache->flags);
> +		alloc_flags = btrfs_get_alloc_profile(fs_info, cache->flags);
>   		if (alloc_flags != cache->flags) {
>   			ret = btrfs_chunk_alloc(trans, alloc_flags,
>   						CHUNK_ALLOC_FORCE);
> @@ -2252,7 +2204,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
>   	ret = inc_block_group_ro(cache, 0);
>   out:
>   	if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
> -		alloc_flags = update_block_group_flags(fs_info, cache->flags);
> +		alloc_flags = btrfs_get_alloc_profile(fs_info, cache->flags);
>   		mutex_lock(&fs_info->chunk_mutex);
>   		check_system_chunk(trans, alloc_flags);
>   		mutex_unlock(&fs_info->chunk_mutex);
> 

It seems that this patch breaks forced metadata rebalance from dup to single;
all chunks remain dup (or are rewritten as dup again). I bisected the broken
balance behaviour to this commit which for some reason was in my tree ;-) and
reverting it immediately fixed things.

I don't (yet) see this applied anywhere, but couldn't find any discussion or
revocation either. Maybe the logic between update_block_group_flags() and
btrfs_get_alloc_profile() is not completely exchangeable?

thanks,
Holger
