Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13355D2D36
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 17:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfJJPAu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 11:00:50 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38853 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfJJPAt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 11:00:49 -0400
Received: by mail-qt1-f193.google.com with SMTP id j31so9151427qta.5
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LrCmbUFkkqWd94nngb8Mngccfo4OkloEU2RirTz2o9c=;
        b=NM977KvTphhRdIcwlHj5bujIDTUB1uH+AZ6HTrjwx9zPSFcksiiAdUZlb1vsAp/zQM
         Q0CRuFmTXug6QBXijVBbKDKIPIKUj5tLqDnLOhPZ+Kh+NTvrasnesl06Or2VYJx7A2Ra
         QqeO891SMldcwNlDQW7yroLQwb6mFyZXwIg4eQ2vHylZNKWfLrtcqZHUXIg4lGXEuquR
         zDvhoiThxja7HClz2GWisuiqBnRt3JxQDiUnxpqMMiZOWzrvCfqhF+fRL3Ys2zwqCZeY
         943uHL5/0ia5NG06AcPfJTCkJ6mZRaQCMu6eAslbRMOuooB8FFvpNTuP2IftYxKeexqF
         tPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LrCmbUFkkqWd94nngb8Mngccfo4OkloEU2RirTz2o9c=;
        b=ZA2PQVrvu5Xg9dB6rKnz0292GD9+e13k0StKek0cra0tLT2EYX/BhjTL8J3MpmLsIU
         Taq29H2noer6I16n86NI+g1MCAkCULxmEsZA78/6LpBp4fVj4oX6f5e4jlqOU4jDkYht
         tjzQ2hWzr+9/KSyYio3o9fgw09jHgdzc2M4xXVlt0LQZZfp5U8tAm+u6DJ14Azgfzp0/
         yLMYpZ8JQNJ2CZGVw3r6or6klk4VbWjV6WRpGym0ZTisIOM8ud5rr0IOMgk5osnvNpdq
         tefG0bc8uL9d82A1yrkSAmo08Dyas6TxR2KJSv7Yf4WAhvYKaDS9IESufvnS7fcDNy0m
         3GLw==
X-Gm-Message-State: APjAAAUq+H/wsZCY0tCj1poB2UjTsxEAaX3zcjF+rwdm1VOljAgYZCpX
        x8maFngVZMDi8IybxxjExfDFQQ==
X-Google-Smtp-Source: APXvYqwmIEc/mmKQ/Qn1mtWAkKb819N/3bWKeFe6offMz2UuMWf3sHVW6kzIO5VDFM6H53FQLth98w==
X-Received: by 2002:ac8:4a97:: with SMTP id l23mr10605079qtq.45.1570719644887;
        Thu, 10 Oct 2019 08:00:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::18ce])
        by smtp.gmail.com with ESMTPSA id t63sm2651605qkf.48.2019.10.10.08.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 08:00:44 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:00:42 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 06/19] btrfs: handle empty block_group removal
Message-ID: <20191010150041.ly725ebipb73rc7b@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1570479299.git.dennis@kernel.org>
 <a1d52aa93f0e9e36fcf89979664a55bccf1a0459.1570479299.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1d52aa93f0e9e36fcf89979664a55bccf1a0459.1570479299.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 04:17:37PM -0400, Dennis Zhou wrote:
> block_group removal is a little tricky. It can race with the extent
> allocator, the cleaner thread, and balancing. The current path is for a
> block_group to be added to the unused_bgs list. Then, when the cleaner
> thread comes around, it starts a transaction and then proceeds with
> removing the block_group. Extents that are pinned are subsequently
> removed from the pinned trees and then eventually a discard is issued
> for the entire block_group.
> 
> Async discard introduces another player into the game, the discard
> workqueue. While it has none of the racing issues, the new problem is
> ensuring we don't leave free space untrimmed prior to forgetting the
> block_group.  This is handled by placing fully free block_groups on a
> separate discard queue. This is necessary to maintain discarding order
> as in the future we will slowly trim even fully free block_groups. The
> ordering helps us make progress on the same block_group rather than say
> the last fully freed block_group or needing to search through the fully
> freed block groups at the beginning of a list and insert after.
> 
> The new order of events is a fully freed block group gets placed on the
> discard queue first. Once it's processed, it will be placed on the
> unusued_bgs list and then the original sequence of events will happen,
> just without the final whole block_group discard.
> 
> The mount flags can change when processing unused_bgs, so when flipping
> from DISCARD to DISCARD_ASYNC, the unused_bgs must be punted to the
> discard_list to be trimmed. If we flip off DISCARD_ASYNC, we punt
> free block groups on the discard_list to the unused_bg queue which will
> do the final discard for us.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---
>  fs/btrfs/block-group.c      | 39 ++++++++++++++++++---
>  fs/btrfs/ctree.h            |  2 +-
>  fs/btrfs/discard.c          | 68 ++++++++++++++++++++++++++++++++++++-
>  fs/btrfs/discard.h          | 11 +++++-
>  fs/btrfs/free-space-cache.c | 33 ++++++++++++++++++
>  fs/btrfs/free-space-cache.h |  1 +
>  fs/btrfs/scrub.c            |  7 +++-
>  7 files changed, 153 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 8bbbe7488328..73e5a9384491 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1251,6 +1251,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  	struct btrfs_block_group_cache *block_group;
>  	struct btrfs_space_info *space_info;
>  	struct btrfs_trans_handle *trans;
> +	bool async_trim_enabled = btrfs_test_opt(fs_info, DISCARD_ASYNC);
>  	int ret = 0;
>  
>  	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
> @@ -1260,6 +1261,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  	while (!list_empty(&fs_info->unused_bgs)) {
>  		u64 start, end;
>  		int trimming;
> +		bool async_trimmed;
>  
>  		block_group = list_first_entry(&fs_info->unused_bgs,
>  					       struct btrfs_block_group_cache,
> @@ -1281,10 +1283,20 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  		/* Don't want to race with allocators so take the groups_sem */
>  		down_write(&space_info->groups_sem);
>  		spin_lock(&block_group->lock);
> +
> +		/* async discard requires block groups to be fully trimmed */
> +		async_trimmed = (!btrfs_test_opt(fs_info, DISCARD_ASYNC) ||
> +				 btrfs_is_free_space_trimmed(block_group));
> +
>  		if (block_group->reserved || block_group->pinned ||
>  		    btrfs_block_group_used(&block_group->item) ||
>  		    block_group->ro ||
> -		    list_is_singular(&block_group->list)) {
> +		    list_is_singular(&block_group->list) ||
> +		    !async_trimmed) {
> +			/* requeue if we failed because of async discard */
> +			if (!async_trimmed)
> +				btrfs_discard_queue_work(&fs_info->discard_ctl,
> +							 block_group);
>  			/*
>  			 * We want to bail if we made new allocations or have
>  			 * outstanding allocations in this block group.  We do
> @@ -1367,6 +1379,10 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  		spin_unlock(&block_group->lock);
>  		spin_unlock(&space_info->lock);
>  
> +		if (!async_trim_enabled &&
> +		    btrfs_test_opt(fs_info, DISCARD_ASYNC))
> +			goto flip_async;
> +

This took me a minute to grok, please add a comment indicating that this is
meant to catch the case that we flipped from no async to async and thus need to
kick off the async trim work now before removing the unused bg.

>  		/* DISCARD can flip during remount */
>  		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC);
>  
> @@ -1411,6 +1427,13 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  		spin_lock(&fs_info->unused_bgs_lock);
>  	}
>  	spin_unlock(&fs_info->unused_bgs_lock);
> +	return;
> +
> +flip_async:
> +	btrfs_end_transaction(trans);
> +	mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> +	btrfs_put_block_group(block_group);
> +	btrfs_discard_punt_unused_bgs_list(fs_info);
>  }
>  
>  void btrfs_mark_bg_unused(struct btrfs_block_group_cache *bg)
> @@ -1618,6 +1641,8 @@ static struct btrfs_block_group_cache *btrfs_create_block_group_cache(
>  	cache->full_stripe_len = btrfs_full_stripe_len(fs_info, start);
>  	set_free_space_tree_thresholds(cache);
>  
> +	cache->discard_index = 1;
> +
>  	atomic_set(&cache->count, 1);
>  	spin_lock_init(&cache->lock);
>  	init_rwsem(&cache->data_rwsem);
> @@ -1829,7 +1854,11 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
>  			inc_block_group_ro(cache, 1);
>  		} else if (btrfs_block_group_used(&cache->item) == 0) {
>  			ASSERT(list_empty(&cache->bg_list));
> -			btrfs_mark_bg_unused(cache);
> +			if (btrfs_test_opt(info, DISCARD_ASYNC))
> +				btrfs_add_to_discard_free_list(
> +						&info->discard_ctl, cache);
> +			else
> +				btrfs_mark_bg_unused(cache);
>  		}
>  	}
>  
> @@ -2724,8 +2753,10 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
>  		 * dirty list to avoid races between cleaner kthread and space
>  		 * cache writeout.
>  		 */
> -		if (!alloc && old_val == 0)
> -			btrfs_mark_bg_unused(cache);
> +		if (!alloc && old_val == 0) {
> +			if (!btrfs_test_opt(info, DISCARD_ASYNC))
> +				btrfs_mark_bg_unused(cache);
> +		}
>  
>  		btrfs_put_block_group(cache);
>  		total -= num_bytes;
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 419445868909..c328d2e85e4d 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -439,7 +439,7 @@ struct btrfs_full_stripe_locks_tree {
>  };
>  
>  /* discard control */
> -#define BTRFS_NR_DISCARD_LISTS		1
> +#define BTRFS_NR_DISCARD_LISTS		2
>  
>  struct btrfs_discard_ctl {
>  	struct workqueue_struct *discard_workers;
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index 6df124639e55..fb92b888774d 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -29,8 +29,11 @@ void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
>  
>  	spin_lock(&discard_ctl->lock);
>  
> -	if (list_empty(&cache->discard_list))
> +	if (list_empty(&cache->discard_list) || !cache->discard_index) {
> +		if (!cache->discard_index)
> +			cache->discard_index = 1;

Need a #define for this so it's clear what our intention is, I hate magic
numbers.

>  		cache->discard_delay = now + BTRFS_DISCARD_DELAY;
> +	}
>  
>  	list_move_tail(&cache->discard_list,
>  		       btrfs_get_discard_list(discard_ctl, cache));
> @@ -38,6 +41,23 @@ void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
>  	spin_unlock(&discard_ctl->lock);
>  }
>  
> +void btrfs_add_to_discard_free_list(struct btrfs_discard_ctl *discard_ctl,
> +				    struct btrfs_block_group_cache *cache)
> +{
> +	u64 now = ktime_get_ns();
> +
> +	spin_lock(&discard_ctl->lock);
> +
> +	if (!list_empty(&cache->discard_list))
> +		list_del_init(&cache->discard_list);
> +
> +	cache->discard_index = 0;
> +	cache->discard_delay = now;
> +	list_add_tail(&cache->discard_list, &discard_ctl->discard_list[0]);
> +
> +	spin_unlock(&discard_ctl->lock);
> +}
> +
>  static bool remove_from_discard_list(struct btrfs_discard_ctl *discard_ctl,
>  				     struct btrfs_block_group_cache *cache)
>  {
> @@ -161,10 +181,52 @@ static void btrfs_discard_workfn(struct work_struct *work)
>  			       btrfs_block_group_end(cache), 0);
>  
>  	remove_from_discard_list(discard_ctl, cache);
> +	if (btrfs_is_free_space_trimmed(cache))
> +		btrfs_mark_bg_unused(cache);
> +	else if (cache->free_space_ctl->free_space == cache->key.offset)
> +		btrfs_add_to_discard_free_list(discard_ctl, cache);

This needs to be

else if (btrfs_block_group_used(cache) == 0)

because we just exclude super mirrors from the free space cache, so completely
empty free_space != cache->key.offset.

>  
>  	btrfs_discard_schedule_work(discard_ctl, false);
>  }
>  
> +void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_block_group_cache *cache, *next;
> +
> +	/* we enabled async discard, so punt all to the queue */
> +	spin_lock(&fs_info->unused_bgs_lock);
> +
> +	list_for_each_entry_safe(cache, next, &fs_info->unused_bgs, bg_list) {
> +		list_del_init(&cache->bg_list);
> +		btrfs_add_to_discard_free_list(&fs_info->discard_ctl, cache);
> +	}
> +
> +	spin_unlock(&fs_info->unused_bgs_lock);
> +}
> +
> +static void btrfs_discard_purge_list(struct btrfs_discard_ctl *discard_ctl)
> +{
> +	struct btrfs_block_group_cache *cache, *next;
> +	int i;
> +
> +	spin_lock(&discard_ctl->lock);
> +
> +	for (i = 0; i < BTRFS_NR_DISCARD_LISTS; i++) {
> +		list_for_each_entry_safe(cache, next,
> +					 &discard_ctl->discard_list[i],
> +					 discard_list) {
> +			list_del_init(&cache->discard_list);
> +			spin_unlock(&discard_ctl->lock);
> +			if (cache->free_space_ctl->free_space ==
> +			    cache->key.offset)
> +				btrfs_mark_bg_unused(cache);
> +			spin_lock(&discard_ctl->lock);
> +		}
> +	}
> +
> +	spin_unlock(&discard_ctl->lock);
> +}
> +
>  void btrfs_discard_resume(struct btrfs_fs_info *fs_info)
>  {
>  	if (!btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
> @@ -172,6 +234,8 @@ void btrfs_discard_resume(struct btrfs_fs_info *fs_info)
>  		return;
>  	}
>  
> +	btrfs_discard_punt_unused_bgs_list(fs_info);
> +
>  	set_bit(BTRFS_FS_DISCARD_RUNNING, &fs_info->flags);
>  }
>  
> @@ -197,4 +261,6 @@ void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
>  {
>  	btrfs_discard_stop(fs_info);
>  	cancel_delayed_work_sync(&fs_info->discard_ctl.work);
> +
> +	btrfs_discard_purge_list(&fs_info->discard_ctl);
>  }
> diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
> index 6d7805bb0eb7..55f79b624943 100644
> --- a/fs/btrfs/discard.h
> +++ b/fs/btrfs/discard.h
> @@ -10,9 +10,14 @@
>  #include <linux/workqueue.h>
>  
>  #include "ctree.h"
> +#include "block-group.h"
> +#include "free-space-cache.h"
>  
>  void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
>  			       struct btrfs_block_group_cache *cache);
> +void btrfs_add_to_discard_free_list(struct btrfs_discard_ctl *discard_ctl,
> +				    struct btrfs_block_group_cache *cache);
> +void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info);
>  
>  void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
>  			       struct btrfs_block_group_cache *cache);
> @@ -41,7 +46,11 @@ void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
>  	if (!cache || !btrfs_test_opt(cache->fs_info, DISCARD_ASYNC))
>  		return;
>  
> -	btrfs_add_to_discard_list(discard_ctl, cache);
> +	if (cache->free_space_ctl->free_space == cache->key.offset)
> +		btrfs_add_to_discard_free_list(discard_ctl, cache);

Same here.

> +	else
> +		btrfs_add_to_discard_list(discard_ctl, cache);
> +
>  	if (!delayed_work_pending(&discard_ctl->work))
>  		btrfs_discard_schedule_work(discard_ctl, false);
>  }
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 54ff1bc97777..ed0e7ee4c78d 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -2653,6 +2653,31 @@ void btrfs_remove_free_space_cache(struct btrfs_block_group_cache *block_group)
>  
>  }
>  
> +bool btrfs_is_free_space_trimmed(struct btrfs_block_group_cache *cache)
> +{
> +	struct btrfs_free_space_ctl *ctl = cache->free_space_ctl;
> +	struct btrfs_free_space *info;
> +	struct rb_node *node;
> +	bool ret = true;
> +
> +	spin_lock(&ctl->tree_lock);
> +	node = rb_first(&ctl->free_space_offset);
> +
> +	while (node) {
> +		info = rb_entry(node, struct btrfs_free_space, offset_index);
> +
> +		if (!btrfs_free_space_trimmed(info)) {
> +			ret = false;
> +			break;
> +		}
> +
> +		node = rb_next(node);
> +	}
> +
> +	spin_unlock(&ctl->tree_lock);
> +	return ret;
> +}
> +
>  u64 btrfs_find_space_for_alloc(struct btrfs_block_group_cache *block_group,
>  			       u64 offset, u64 bytes, u64 empty_size,
>  			       u64 *max_extent_size)
> @@ -2739,6 +2764,9 @@ int btrfs_return_cluster_to_free_space(
>  	ret = __btrfs_return_cluster_to_free_space(block_group, cluster);
>  	spin_unlock(&ctl->tree_lock);
>  
> +	btrfs_discard_queue_work(&block_group->fs_info->discard_ctl,
> +				 block_group);
> +
>  	/* finally drop our ref */
>  	btrfs_put_block_group(block_group);
>  	return ret;
> @@ -3097,6 +3125,7 @@ int btrfs_find_space_cluster(struct btrfs_block_group_cache *block_group,
>  	u64 min_bytes;
>  	u64 cont1_bytes;
>  	int ret;
> +	bool found_cluster = false;
>  
>  	/*
>  	 * Choose the minimum extent size we'll require for this
> @@ -3149,6 +3178,7 @@ int btrfs_find_space_cluster(struct btrfs_block_group_cache *block_group,
>  		list_del_init(&entry->list);
>  
>  	if (!ret) {
> +		found_cluster = true;
>  		atomic_inc(&block_group->count);
>  		list_add_tail(&cluster->block_group_list,
>  			      &block_group->cluster_list);
> @@ -3160,6 +3190,9 @@ int btrfs_find_space_cluster(struct btrfs_block_group_cache *block_group,
>  	spin_unlock(&cluster->lock);
>  	spin_unlock(&ctl->tree_lock);
>  
> +	if (found_cluster)
> +		btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
> +
>  	return ret;
>  }

This bit here seems unrelated to the rest of the change.  Why do we want to
cancel the discard work if we find a cluster?  And what does it have to do with
unused bgs?  If it's the allocation part that makes you want to cancel then that
sort of makes sense in the unused bg context, but this is happening no matter
what.  It should probably be in its own patch with an explanation, or at least
in a different patch.  Thanks,

Josef
