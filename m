Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D02ED2D9D
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 17:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfJJPWs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 11:22:48 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33470 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJPWs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 11:22:48 -0400
Received: by mail-qk1-f194.google.com with SMTP id x134so5995917qkb.0
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 08:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dUhQ5lyxgjDNA3TJyYKnpn6rlzj0QPwb30MBxUP4QA4=;
        b=P4ITNxpVYBQDNh2YsSOFTkoYY4OFqsAFTmU2WlH+03ojKNy62tb9ie752M6IpK/F+z
         a2bGHWgbVeucmmbfEo1IlyLhE4vOzxtGs+wb1AcKCxzCXQ+ZJnq3gCEldpT/b73ehV+V
         PQ3lnzyz5FthVLrUy70QSrNg/RBrCCfG6WdwmA9yj6N1iI2OwMJWLO63EfqbwZBn0J/E
         2BXAgZDhq67ux2K1Tj7PgYygLtpgw6zbiyQt7CfO/kj7vrOgYSvhUtCGi8J3NjYK6251
         f53MmrAI3sPeOSFjr5VDKAnGKoOa6Z0/XIfK0tTL2l1AMdAc6O6QCzqwyYTT8qeD09hV
         NygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dUhQ5lyxgjDNA3TJyYKnpn6rlzj0QPwb30MBxUP4QA4=;
        b=G5edRCDaR9wkkRwFk3J9uTHg0OrOKE083yhMGxMKYDk4pSAH4dKx38rtFDi3HC5NGC
         6lZAL1kSmn35c4+9SO+cIx8cPGLHEV5dH5H2xi4PGpBD+q3zMNqMtGNsIjOacbMPZfYa
         ttNygfH+El99VNYxKb9x6SURBEdnk3GDB8y7FD1Yyc2tBjBuUWGYDoacMWBpg5oNT9Y6
         MnApGNWthq7fRAcS9QbeTUpUQninRQxwfuObfnT8gvkbnHceRZwGZkzeu6FRw7Ihkssv
         EZLXZWM0c/gm1dSyozL6+wPk3oAxHJE17CxG3F3LJuPx7n/xGzIEcvbEWnavFV6zZ9++
         gbDg==
X-Gm-Message-State: APjAAAUd67IPG5/WjI7zxcEYd8+cPk2QsBYu8O3218gpZcGOcRZI1rug
        7+FddJqrf5++6yuErcTt5aoJBg==
X-Google-Smtp-Source: APXvYqyjAuCcBWg/dBe9G18bBsMin9sGz8UMIvl/QC78RWEMX61pdCkhkN+aAj7yz1cpZLXsb+kUog==
X-Received: by 2002:a37:ac19:: with SMTP id e25mr10157016qkm.394.1570720966882;
        Thu, 10 Oct 2019 08:22:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::18ce])
        by smtp.gmail.com with ESMTPSA id d133sm3275437qkg.31.2019.10.10.08.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 08:22:46 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:22:44 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 07/19] btrfs: discard one region at a time in async
 discard
Message-ID: <20191010152243.guevccs7bacoop2m@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1570479299.git.dennis@kernel.org>
 <79b26926486575eb53825c1aad607e99028d8447.1570479299.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79b26926486575eb53825c1aad607e99028d8447.1570479299.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 04:17:38PM -0400, Dennis Zhou wrote:
> The prior two patches added discarding via a background workqueue. This
> just piggybacked off of the fstrim code to trim the whole block at once.
> Well inevitably this is worse performance wise and will aggressively
> overtrim. But it was nice to plumb the other infrastructure to keep the
> patches easier to review.
> 
> This adds the real goal of this series which is discarding slowly (ie a
> slow long running fstrim). The discarding is split into two phases,
> extents and then bitmaps. The reason for this is two fold. First, the
> bitmap regions overlap the extent regions. Second, discarding the
> extents first will let the newly trimmed bitmaps have the highest chance
> of coalescing when being readded to the free space cache.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---
>  fs/btrfs/block-group.h      |   2 +
>  fs/btrfs/discard.c          |  73 ++++++++++++++++++++-----
>  fs/btrfs/discard.h          |  16 ++++++
>  fs/btrfs/extent-tree.c      |   3 +-
>  fs/btrfs/free-space-cache.c | 106 ++++++++++++++++++++++++++----------
>  fs/btrfs/free-space-cache.h |   6 +-
>  6 files changed, 159 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 0f9a1c91753f..b59e6a8ed73d 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -120,6 +120,8 @@ struct btrfs_block_group_cache {
>  	struct list_head discard_list;
>  	int discard_index;
>  	u64 discard_delay;
> +	u64 discard_cursor;
> +	u32 discard_flags;
>  

Same comment as the free space flags, this is just a state holder and never has
more than one bit set, so switch it to an enum and treat it like a state.

>  	/* For dirty block groups */
>  	struct list_head dirty_list;
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index fb92b888774d..26a1e44b4bfa 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -22,21 +22,28 @@ btrfs_get_discard_list(struct btrfs_discard_ctl *discard_ctl,
>  	return &discard_ctl->discard_list[cache->discard_index];
>  }
>  
> -void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
> -			       struct btrfs_block_group_cache *cache)
> +static void __btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
> +					struct btrfs_block_group_cache *cache)
>  {
>  	u64 now = ktime_get_ns();
>  
> -	spin_lock(&discard_ctl->lock);
> -
>  	if (list_empty(&cache->discard_list) || !cache->discard_index) {
>  		if (!cache->discard_index)
>  			cache->discard_index = 1;
>  		cache->discard_delay = now + BTRFS_DISCARD_DELAY;
> +		cache->discard_flags |= BTRFS_DISCARD_RESET_CURSOR;
>  	}
>  
>  	list_move_tail(&cache->discard_list,
>  		       btrfs_get_discard_list(discard_ctl, cache));
> +}
> +
> +void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
> +			       struct btrfs_block_group_cache *cache)
> +{
> +	spin_lock(&discard_ctl->lock);
> +
> +	__btrfs_add_to_discard_list(discard_ctl, cache);
>  
>  	spin_unlock(&discard_ctl->lock);
>  }
> @@ -53,6 +60,7 @@ void btrfs_add_to_discard_free_list(struct btrfs_discard_ctl *discard_ctl,
>  
>  	cache->discard_index = 0;
>  	cache->discard_delay = now;
> +	cache->discard_flags |= BTRFS_DISCARD_RESET_CURSOR;
>  	list_add_tail(&cache->discard_list, &discard_ctl->discard_list[0]);
>  
>  	spin_unlock(&discard_ctl->lock);
> @@ -114,13 +122,24 @@ peek_discard_list(struct btrfs_discard_ctl *discard_ctl)
>  
>  	spin_lock(&discard_ctl->lock);
>  
> +again:
>  	cache = find_next_cache(discard_ctl, now);
>  
> -	if (cache && now < cache->discard_delay)
> +	if (cache && now > cache->discard_delay) {
> +		discard_ctl->cache = cache;
> +		if (cache->discard_index == 0 &&
> +		    cache->free_space_ctl->free_space != cache->key.offset) {
> +			__btrfs_add_to_discard_list(discard_ctl, cache);
> +			goto again;

The magic number thing again, it needs to be discard_index == UNUSED_DISCARD or
some such descriptive thing.  Also needs to be btrfs_block_group_used(cache) ==
0;

> +		}
> +		if (btrfs_discard_reset_cursor(cache)) {
> +			cache->discard_cursor = cache->key.objectid;
> +			cache->discard_flags &= ~(BTRFS_DISCARD_RESET_CURSOR |
> +						  BTRFS_DISCARD_BITMAPS);
> +		}
> +	} else {
>  		cache = NULL;
> -
> -	discard_ctl->cache = cache;
> -
> +	}
>  	spin_unlock(&discard_ctl->lock);
>  
>  	return cache;
> @@ -173,18 +192,42 @@ static void btrfs_discard_workfn(struct work_struct *work)
>  
>  	discard_ctl = container_of(work, struct btrfs_discard_ctl, work.work);
>  
> +again:
>  	cache = peek_discard_list(discard_ctl);
>  	if (!cache || !btrfs_run_discard_work(discard_ctl))
>  		return;
>  
> -	btrfs_trim_block_group(cache, &trimmed, cache->key.objectid,
> -			       btrfs_block_group_end(cache), 0);
> +	if (btrfs_discard_bitmaps(cache))
> +		btrfs_trim_block_group_bitmaps(cache, &trimmed,
> +					       cache->discard_cursor,
> +					       btrfs_block_group_end(cache),
> +					       0, true);
> +	else
> +		btrfs_trim_block_group(cache, &trimmed, cache->discard_cursor,
> +				       btrfs_block_group_end(cache), 0, true);
> +
> +	if (cache->discard_cursor >= btrfs_block_group_end(cache)) {
> +		if (btrfs_discard_bitmaps(cache)) {
> +			remove_from_discard_list(discard_ctl, cache);
> +			if (btrfs_is_free_space_trimmed(cache))
> +				btrfs_mark_bg_unused(cache);
> +			else if (cache->free_space_ctl->free_space ==
> +				 cache->key.offset)

btrfs_block_group_used(cache) == 0;

> +				btrfs_add_to_discard_free_list(discard_ctl,
> +							       cache);
> +		} else {
> +			cache->discard_cursor = cache->key.objectid;
> +			cache->discard_flags |= BTRFS_DISCARD_BITMAPS;
> +		}
> +	}
> +
> +	spin_lock(&discard_ctl->lock);
> +	discard_ctl->cache = NULL;
> +	spin_unlock(&discard_ctl->lock);
>  
> -	remove_from_discard_list(discard_ctl, cache);
> -	if (btrfs_is_free_space_trimmed(cache))
> -		btrfs_mark_bg_unused(cache);
> -	else if (cache->free_space_ctl->free_space == cache->key.offset)
> -		btrfs_add_to_discard_free_list(discard_ctl, cache);
> +	/* we didn't trim anything but we really ought to so try again */
> +	if (trimmed == 0)
> +		goto again;

Why?  We'll reschedule if we need to.  We unconditionally do this, I feel like
there's going to be some corner case where we end up seeing this workfn using
100% on a bunch of sandcastle boxes and we'll all be super sad.

>  
>  	btrfs_discard_schedule_work(discard_ctl, false);
>  }
> diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
> index 55f79b624943..22cfa7e401bb 100644
> --- a/fs/btrfs/discard.h
> +++ b/fs/btrfs/discard.h
> @@ -13,6 +13,22 @@
>  #include "block-group.h"
>  #include "free-space-cache.h"
>  
> +/* discard flags */
> +#define BTRFS_DISCARD_RESET_CURSOR	(1UL << 0)
> +#define BTRFS_DISCARD_BITMAPS           (1UL << 1)
> +
> +static inline
> +bool btrfs_discard_reset_cursor(struct btrfs_block_group_cache *cache)
> +{
> +	return (cache->discard_flags & BTRFS_DISCARD_RESET_CURSOR);
> +}
> +
> +static inline
> +bool btrfs_discard_bitmaps(struct btrfs_block_group_cache *cache)
> +{
> +	return (cache->discard_flags & BTRFS_DISCARD_BITMAPS);
> +}
> +
>  void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
>  			       struct btrfs_block_group_cache *cache);
>  void btrfs_add_to_discard_free_list(struct btrfs_discard_ctl *discard_ctl,
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index d69ee5f51b38..ff42e4abb01d 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5683,7 +5683,8 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>  						     &group_trimmed,
>  						     start,
>  						     end,
> -						     range->minlen);
> +						     range->minlen,
> +						     false);
>  
>  			trimmed += group_trimmed;
>  			if (ret) {
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index ed0e7ee4c78d..97b3074e83c0 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -3267,7 +3267,8 @@ static int do_trimming(struct btrfs_block_group_cache *block_group,
>  }
>  
>  static int trim_no_bitmap(struct btrfs_block_group_cache *block_group,
> -			  u64 *total_trimmed, u64 start, u64 end, u64 minlen)
> +			  u64 *total_trimmed, u64 start, u64 end, u64 minlen,
> +			  bool async)
>  {
>  	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
>  	struct btrfs_free_space *entry;
> @@ -3284,36 +3285,25 @@ static int trim_no_bitmap(struct btrfs_block_group_cache *block_group,
>  		mutex_lock(&ctl->cache_writeout_mutex);
>  		spin_lock(&ctl->tree_lock);
>  
> -		if (ctl->free_space < minlen) {
> -			spin_unlock(&ctl->tree_lock);
> -			mutex_unlock(&ctl->cache_writeout_mutex);
> -			break;
> -		}
> +		if (ctl->free_space < minlen)
> +			goto out_unlock;
>  
>  		entry = tree_search_offset(ctl, start, 0, 1);
> -		if (!entry) {
> -			spin_unlock(&ctl->tree_lock);
> -			mutex_unlock(&ctl->cache_writeout_mutex);
> -			break;
> -		}
> +		if (!entry)
> +			goto out_unlock;
>  
>  		/* skip bitmaps */
> -		while (entry->bitmap) {
> +		while (entry->bitmap || (async &&
> +					 btrfs_free_space_trimmed(entry))) {

Update the comment to say we're skipping already trimmed entries as well please.

>  			node = rb_next(&entry->offset_index);
> -			if (!node) {
> -				spin_unlock(&ctl->tree_lock);
> -				mutex_unlock(&ctl->cache_writeout_mutex);
> -				goto out;
> -			}
> +			if (!node)
> +				goto out_unlock;
>  			entry = rb_entry(node, struct btrfs_free_space,
>  					 offset_index);
>  		}
>  
> -		if (entry->offset >= end) {
> -			spin_unlock(&ctl->tree_lock);
> -			mutex_unlock(&ctl->cache_writeout_mutex);
> -			break;
> -		}
> +		if (entry->offset >= end)
> +			goto out_unlock;
>  
>  		extent_start = entry->offset;
>  		extent_bytes = entry->bytes;
> @@ -3338,10 +3328,15 @@ static int trim_no_bitmap(struct btrfs_block_group_cache *block_group,
>  		ret = do_trimming(block_group, total_trimmed, start, bytes,
>  				  extent_start, extent_bytes, extent_flags,
>  				  &trim_entry);
> -		if (ret)
> +		if (ret) {
> +			block_group->discard_cursor = start + bytes;
>  			break;
> +		}
>  next:
>  		start += bytes;
> +		block_group->discard_cursor = start;
> +		if (async && *total_trimmed)
> +			break;

Alright so this means we'll only trim one entry and then return if we're async?
It seems to be the same below for bitmaps.  This deserves a comment for the
functions, it fundamentally changes the behavior of the function if we're async.

>  
>  		if (fatal_signal_pending(current)) {
>  			ret = -ERESTARTSYS;
> @@ -3350,7 +3345,14 @@ static int trim_no_bitmap(struct btrfs_block_group_cache *block_group,
>  
>  		cond_resched();
>  	}
> -out:
> +
> +	return ret;
> +
> +out_unlock:
> +	block_group->discard_cursor = btrfs_block_group_end(block_group);
> +	spin_unlock(&ctl->tree_lock);
> +	mutex_unlock(&ctl->cache_writeout_mutex);
> +
>  	return ret;
>  }
>  
> @@ -3390,7 +3392,8 @@ static void end_trimming_bitmap(struct btrfs_free_space *entry)
>  }
>  
>  static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
> -			u64 *total_trimmed, u64 start, u64 end, u64 minlen)
> +			u64 *total_trimmed, u64 start, u64 end, u64 minlen,
> +			bool async)
>  {
>  	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
>  	struct btrfs_free_space *entry;
> @@ -3407,13 +3410,16 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
>  		spin_lock(&ctl->tree_lock);
>  
>  		if (ctl->free_space < minlen) {
> +			block_group->discard_cursor =
> +				btrfs_block_group_end(block_group);
>  			spin_unlock(&ctl->tree_lock);
>  			mutex_unlock(&ctl->cache_writeout_mutex);
>  			break;
>  		}
>  
>  		entry = tree_search_offset(ctl, offset, 1, 0);
> -		if (!entry) {
> +		if (!entry || (async && start == offset &&
> +			       btrfs_free_space_trimmed(entry))) {
>  			spin_unlock(&ctl->tree_lock);
>  			mutex_unlock(&ctl->cache_writeout_mutex);
>  			next_bitmap = true;
> @@ -3446,6 +3452,16 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
>  			goto next;
>  		}
>  
> +		/*
> +		 * We already trimmed a region, but are using the locking above
> +		 * to reset the BTRFS_FSC_TRIMMING_BITMAP flag.
> +		 */
> +		if (async && *total_trimmed) {
> +			spin_unlock(&ctl->tree_lock);
> +			mutex_unlock(&ctl->cache_writeout_mutex);
> +			return ret;
> +		}
> +
>  		bytes = min(bytes, end - start);
>  		if (bytes < minlen) {
>  			entry->flags &= ~BTRFS_FSC_TRIMMING_BITMAP;
> @@ -3468,6 +3484,8 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
>  				  start, bytes, 0, &trim_entry);
>  		if (ret) {
>  			reset_trimming_bitmap(ctl, offset);
> +			block_group->discard_cursor =
> +				btrfs_block_group_end(block_group);
>  			break;
>  		}
>  next:
> @@ -3477,6 +3495,7 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
>  		} else {
>  			start += bytes;
>  		}
> +		block_group->discard_cursor = start;
>  
>  		if (fatal_signal_pending(current)) {
>  			if (start != offset)
> @@ -3488,6 +3507,9 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
>  		cond_resched();
>  	}
>  
> +	if (offset >= end)
> +		block_group->discard_cursor = end;
> +
>  	return ret;
>  }
>  
> @@ -3532,7 +3554,8 @@ void btrfs_put_block_group_trimming(struct btrfs_block_group_cache *block_group)
>  }
>  
>  int btrfs_trim_block_group(struct btrfs_block_group_cache *block_group,
> -			   u64 *trimmed, u64 start, u64 end, u64 minlen)
> +			   u64 *trimmed, u64 start, u64 end, u64 minlen,
> +			   bool async)
>  {
>  	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
>  	int ret;
> @@ -3547,11 +3570,11 @@ int btrfs_trim_block_group(struct btrfs_block_group_cache *block_group,
>  	btrfs_get_block_group_trimming(block_group);
>  	spin_unlock(&block_group->lock);
>  
> -	ret = trim_no_bitmap(block_group, trimmed, start, end, minlen);
> -	if (ret)
> +	ret = trim_no_bitmap(block_group, trimmed, start, end, minlen, async);
> +	if (ret || async)
>  		goto out;
>  

You already separate out btrfs_trim_block_group_bitmaps, so this function really
only trims the whole block group if !async.  Make a separate helper for trimming
only the extents so it's clear what the async stuff is doing, and we're not
relying on the async to change the behavior of btrfs_trim_block_group().
Thanks,

Josef
