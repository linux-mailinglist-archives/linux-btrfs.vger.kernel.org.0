Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C86FD109C26
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 11:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfKZKSf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 05:18:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:40592 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727603AbfKZKSf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 05:18:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 41615AB9D;
        Tue, 26 Nov 2019 10:18:32 +0000 (UTC)
Subject: Re: [PATCH 4/4] btrfs: use btrfs_can_overcommit in inc_block_group_ro
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, wqu@suse.com
References: <20191125144011.146722-1-josef@toxicpanda.com>
 <20191125144011.146722-5-josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3decb2b5-49dc-f019-5afc-e055ad916972@suse.com>
Date:   Tue, 26 Nov 2019 12:18:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191125144011.146722-5-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 25.11.19 г. 16:40 ч., Josef Bacik wrote:
> inc_block_group_ro does a calculation to see if we have enough room left
> over if we mark this block group as read only in order to see if it's ok
> to mark the block group as read only.
> 
> The problem is this calculation _only_ works for data, where our used is
> always less than our total.  For metadata we will overcommit, so this
> will almost always fail for metadata.
> 
> Fix this by exporting btrfs_can_overcommit, and then see if we have
> enough space to remove the remaining free space in the block group we
> are trying to mark read only.  If we do then we can mark this block
> group as read only.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/block-group.c | 37 ++++++++++++++++++++++++++-----------
>  fs/btrfs/space-info.c  | 19 ++++++++++---------
>  fs/btrfs/space-info.h  |  3 +++
>  3 files changed, 39 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 3ffbc2e0af21..7b1f6d2b9621 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1184,7 +1184,6 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
>  {
>  	struct btrfs_space_info *sinfo = cache->space_info;
>  	u64 num_bytes;
> -	u64 sinfo_used;
>  	int ret = -ENOSPC;
>  
>  	spin_lock(&sinfo->lock);
> @@ -1200,19 +1199,38 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
>  
>  	num_bytes = cache->length - cache->reserved - cache->pinned -
>  		    cache->bytes_super - cache->used;
> -	sinfo_used = btrfs_space_info_used(sinfo, true);
>  
>  	/*
> -	 * sinfo_used + num_bytes should always <= sinfo->total_bytes.
> -	 *
> -	 * Here we make sure if we mark this bg RO, we still have enough
> -	 * free space as buffer.
> +	 * Data never overcommits, even in mixed mode, so do just the straight
> +	 * check of left over space in how much we have allocated.
>  	 */
> -	if (sinfo_used + num_bytes + sinfo->total_bytes) {
> +	if (sinfo->flags & BTRFS_BLOCK_GROUP_DATA) {
> +		u64 sinfo_used = btrfs_space_info_used(sinfo, true);

does that mean bytes_may_write is always 0 for DATA?

> +
> +		/*
> +		 * sinfo_used + num_bytes should always <= sinfo->total_bytes.

This invariant warrants an ASSERT.

> +		 *
> +		 * Here we make sure if we mark this bg RO, we still have enough
> +		 * free space as buffer.
> +		 */
> +		if (sinfo_used + num_bytes + sinfo->total_bytes)
> +			ret = 0;
> +	} else {
> +		/*
> +		 * We overcommit metadata, so we need to do the
> +		 * btrfs_can_overcommit check here, and we need to pass in
> +		 * BTRFS_RESERVE_NO_FLUSH to give ourselves the most amount of
> +		 * leeway to allow us to mark this block group as read only.
> +		 */
> +		if (btrfs_can_overcommit(cache->fs_info, sinfo, num_bytes,
> +					 BTRFS_RESERVE_NO_FLUSH))
> +			ret = 0;
> +	}
> +
> +	if (!ret) {
>  		sinfo->bytes_readonly += num_bytes;
>  		cache->ro++;
>  		list_add_tail(&cache->ro_list, &sinfo->ro_bgs);
> -		ret = 0;
>  	}
>  out:
>  	spin_unlock(&cache->lock);
> @@ -1220,9 +1238,6 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
>  	if (ret == -ENOSPC && btrfs_test_opt(cache->fs_info, ENOSPC_DEBUG)) {
>  		btrfs_info(cache->fs_info,
>  			"unable to make block group %llu ro", cache->start);
> -		btrfs_info(cache->fs_info,
> -			"sinfo_used=%llu bg_num_bytes=%llu",
> -			sinfo_used, num_bytes);
>  		btrfs_dump_space_info(cache->fs_info, cache->space_info, 0, 0);
>  	}
>  	return ret;
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index df5fb68df798..01297c5b2666 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -159,9 +159,9 @@ static inline u64 calc_global_rsv_need_space(struct btrfs_block_rsv *global)
>  	return (global->size << 1);
>  }
>  
> -static int can_overcommit(struct btrfs_fs_info *fs_info,
> -			  struct btrfs_space_info *space_info, u64 bytes,
> -			  enum btrfs_reserve_flush_enum flush)
> +int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
> +			 struct btrfs_space_info *space_info, u64 bytes,
> +			 enum btrfs_reserve_flush_enum flush)
>  {
>  	u64 profile;
>  	u64 avail;
> @@ -226,7 +226,8 @@ void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
>  
>  		/* Check and see if our ticket can be satisified now. */
>  		if ((used + ticket->bytes <= space_info->total_bytes) ||
> -		    can_overcommit(fs_info, space_info, ticket->bytes, flush)) {
> +		    btrfs_can_overcommit(fs_info, space_info, ticket->bytes,
> +					 flush)) {
>  			btrfs_space_info_update_bytes_may_use(fs_info,
>  							      space_info,
>  							      ticket->bytes);
> @@ -639,14 +640,14 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
>  		return to_reclaim;
>  
>  	to_reclaim = min_t(u64, num_online_cpus() * SZ_1M, SZ_16M);
> -	if (can_overcommit(fs_info, space_info, to_reclaim,
> -			   BTRFS_RESERVE_FLUSH_ALL))
> +	if (btrfs_can_overcommit(fs_info, space_info, to_reclaim,
> +				 BTRFS_RESERVE_FLUSH_ALL))
>  		return 0;
>  
>  	used = btrfs_space_info_used(space_info, true);
>  
> -	if (can_overcommit(fs_info, space_info, SZ_1M,
> -			   BTRFS_RESERVE_FLUSH_ALL))
> +	if (btrfs_can_overcommit(fs_info, space_info, SZ_1M,
> +				 BTRFS_RESERVE_FLUSH_ALL))
>  		expected = div_factor_fine(space_info->total_bytes, 95);
>  	else
>  		expected = div_factor_fine(space_info->total_bytes, 90);
> @@ -1005,7 +1006,7 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
>  	 */
>  	if (!pending_tickets &&
>  	    ((used + orig_bytes <= space_info->total_bytes) ||
> -	     can_overcommit(fs_info, space_info, orig_bytes, flush))) {
> +	     btrfs_can_overcommit(fs_info, space_info, orig_bytes, flush))) {
>  		btrfs_space_info_update_bytes_may_use(fs_info, space_info,
>  						      orig_bytes);
>  		ret = 0;
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index 1a349e3f9cc1..24514cd2c6c1 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -127,6 +127,9 @@ int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
>  				 enum btrfs_reserve_flush_enum flush);
>  void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
>  				struct btrfs_space_info *space_info);
> +int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
> +			 struct btrfs_space_info *space_info, u64 bytes,
> +			 enum btrfs_reserve_flush_enum flush);
>  
>  static inline void btrfs_space_info_free_bytes_may_use(
>  				struct btrfs_fs_info *fs_info,
> 
