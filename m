Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C53F573C
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 21:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391130AbfKHTT0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 14:19:26 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45918 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391088AbfKHTTY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Nov 2019 14:19:24 -0500
Received: by mail-qt1-f195.google.com with SMTP id 30so7654194qtz.12
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Nov 2019 11:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UzyFlhHv494UuclqtPKAUQl4lezTd4PQtkw5lGZkots=;
        b=mDxj638UW5IT0+b6HmO5qmWG14L59wZ8oh3JT8iuOmcqhp2iRlvbOtwAxFmUnI96hz
         ldZ55jjIsX0w1KnXrDj+AM0zc3EWr8BciKjfPwy7KvezxrmxckLA83UulPfDuQ9B4uvf
         m6bZWMZfEqX+iOELsvipyMXaB7bNUEaEg4jNs9UcDX+14AnMaeHA17Fm789R4xJSuWxF
         obcVDIrawgTKp9S1zjGpv8IbUVQ/gMBqtijOVCIIGUcRMc8h21wclxfeU/hj/rq/9th5
         1a1UZvmrGFYq4JnvOIl10crEOFcX4k018DmodeMGeLL479JSU5fMslVYtoTDsRuAlf+0
         wJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UzyFlhHv494UuclqtPKAUQl4lezTd4PQtkw5lGZkots=;
        b=dOlhCF0EfrPq+o/FXACnbn8Isob7CYXRwrC/yP20d8EqSOaJndMGWsB6nXOIEY0b1t
         rR/yqvy/PAmqQebxq4Z4pplHRFd5PrSPzHUsLWRQQDHwSOXW0RPuOB4ekGvqFWUOcc3r
         Wp145S4vO4bdnp4hBGwS92MI/gK7/EHJC16Eayw7tKK9H0SDaQBBMeYv4JDz5khAtpLt
         xlloTfHqWWiY8NUzBQEcQB3tAJWfD027UnpDo3tjKeuvmKeBd7UAoJrNlzm1R9kIqFyj
         6R33X0Hp+lh4II8NJK+Xiau1nChGJa6GpdcZk+EQkyDwNg+qfryQYeEpcR1R1bl8k+hG
         MLdQ==
X-Gm-Message-State: APjAAAUTIsgC3MzWtcC1DQR2a3Fi+7yfa+KIOj/6iJPh995TYbx5383E
        /BLCPZiaLfccYNS+2VediM+VCA==
X-Google-Smtp-Source: APXvYqzEpAkso6ec8EINmG0879LeofJOe+cx3oGovTOFt1PklRavYCPYzHgl4ftp5wchQYintHrVWw==
X-Received: by 2002:ac8:1c49:: with SMTP id j9mr12501056qtk.173.1573240763068;
        Fri, 08 Nov 2019 11:19:23 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1852])
        by smtp.gmail.com with ESMTPSA id f24sm3154691qkh.81.2019.11.08.11.19.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 11:19:22 -0800 (PST)
Date:   Fri, 8 Nov 2019 14:19:21 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 06/22] btrfs: handle empty block_group removal
Message-ID: <20191108191920.pw3n62bk77bbgmdu@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1571865774.git.dennis@kernel.org>
 <2232e97f78d01b39e48454844c7a462b1b7b7cb8.1571865774.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2232e97f78d01b39e48454844c7a462b1b7b7cb8.1571865774.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 23, 2019 at 06:53:00PM -0400, Dennis Zhou wrote:
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
> unused discard queue first. Once it's processed, it will be placed on
> the unusued_bgs list and then the original sequence of events will
> happen, just without the final whole block_group discard.
> 
> The mount flags can change when processing unused_bgs, so when flipping
> from DISCARD to DISCARD_ASYNC, the unused_bgs must be punted to the
> discard_list to be trimmed. If we flip off DISCARD_ASYNC, we punt
> free block groups on the discard_list to the unused_bg queue which will
> do the final discard for us.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---
>  fs/btrfs/block-group.c      |  50 ++++++++++++++--
>  fs/btrfs/ctree.h            |   9 ++-
>  fs/btrfs/discard.c          | 112 +++++++++++++++++++++++++++++++++++-
>  fs/btrfs/discard.h          |   6 ++
>  fs/btrfs/free-space-cache.c |  36 ++++++++++++
>  fs/btrfs/free-space-cache.h |   1 +
>  fs/btrfs/scrub.c            |   7 ++-
>  7 files changed, 211 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 8bbbe7488328..b447a7c5ac34 100644
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
> @@ -1281,10 +1283,24 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  		/* Don't want to race with allocators so take the groups_sem */
>  		down_write(&space_info->groups_sem);
>  		spin_lock(&block_group->lock);
> +
> +		/*
> +		 * Async discard moves the final block group discard to be prior
> +		 * to the unused_bgs code path.  Therefore, if it's not fully
> +		 * trimmed, punt it back to the async discard lists.
> +		 */
> +		async_trimmed = (!btrfs_test_opt(fs_info, DISCARD_ASYNC) ||
> +				 btrfs_is_free_space_trimmed(block_group));
> +
>  		if (block_group->reserved || block_group->pinned ||
>  		    btrfs_block_group_used(&block_group->item) ||
>  		    block_group->ro ||
> -		    list_is_singular(&block_group->list)) {
> +		    list_is_singular(&block_group->list) ||
> +		    !async_trimmed) {
> +			/* Requeue if we failed because of async discard. */
> +			if (!async_trimmed)
> +				btrfs_discard_queue_work(&fs_info->discard_ctl,
> +							 block_group);
>  			/*
>  			 * We want to bail if we made new allocations or have
>  			 * outstanding allocations in this block group.  We do
> @@ -1367,6 +1383,17 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  		spin_unlock(&block_group->lock);
>  		spin_unlock(&space_info->lock);
>  
> +		/*
> +		 * The normal path here is an unused block group is passed here,
> +		 * then trimming is handled in the transaction commit path.
> +		 * Async discard interposes before this to do the trimming
> +		 * before coming down the unused block group path as trimming
> +		 * will no longer be done later in the transaction commit path.
> +		 */
> +		if (!async_trim_enabled &&
> +		    btrfs_test_opt(fs_info, DISCARD_ASYNC))
> +			goto flip_async;
> +
>  		/* DISCARD can flip during remount */
>  		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC);
>  
> @@ -1411,6 +1438,13 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
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
> @@ -1618,6 +1652,8 @@ static struct btrfs_block_group_cache *btrfs_create_block_group_cache(
>  	cache->full_stripe_len = btrfs_full_stripe_len(fs_info, start);
>  	set_free_space_tree_thresholds(cache);
>  
> +	cache->discard_index = BTRFS_DISCARD_INDEX_UNUSED;
> +
>  	atomic_set(&cache->count, 1);
>  	spin_lock_init(&cache->lock);
>  	init_rwsem(&cache->data_rwsem);
> @@ -1829,7 +1865,11 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
>  			inc_block_group_ro(cache, 1);
>  		} else if (btrfs_block_group_used(&cache->item) == 0) {
>  			ASSERT(list_empty(&cache->bg_list));
> -			btrfs_mark_bg_unused(cache);
> +			if (btrfs_test_opt(info, DISCARD_ASYNC))
> +				btrfs_add_to_discard_unused_list(
> +						&info->discard_ctl, cache);
> +			else
> +				btrfs_mark_bg_unused(cache);
>  		}
>  	}
>  
> @@ -2724,8 +2764,10 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
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
> index efa8390e8419..e21aeb3a2266 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -441,9 +441,14 @@ struct btrfs_full_stripe_locks_tree {
>  /* Discard control. */
>  /*
>   * Async discard uses multiple lists to differentiate the discard filter
> - * parameters.
> + * parameters.  Index 0 is for completely free block groups where we need to
> + * ensure the entire block group is trimmed without being lossy.  Indices
> + * afterwards represent monotonically decreasing discard filter sizes to
> + * prioritize what should be discarded next.
>   */
> -#define BTRFS_NR_DISCARD_LISTS		1
> +#define BTRFS_NR_DISCARD_LISTS		2
> +#define BTRFS_DISCARD_INDEX_UNUSED	0
> +#define BTRFS_DISCARD_INDEX_START	1
>  
>  struct btrfs_discard_ctl {
>  	struct workqueue_struct *discard_workers;
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index 0a72a1902ca6..5b5be658c397 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -28,9 +28,13 @@ void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
>  {
>  	spin_lock(&discard_ctl->lock);
>  
> -	if (list_empty(&cache->discard_list))
> +	if (list_empty(&cache->discard_list) ||
> +	    cache->discard_index == BTRFS_DISCARD_INDEX_UNUSED) {
> +		if (cache->discard_index == BTRFS_DISCARD_INDEX_UNUSED)
> +			cache->discard_index = BTRFS_DISCARD_INDEX_START;
>  		cache->discard_eligible_time = (ktime_get_ns() +
>  						BTRFS_DISCARD_DELAY);
> +	}
>  
>  	list_move_tail(&cache->discard_list,
>  		       btrfs_get_discard_list(discard_ctl, cache));
> @@ -38,6 +42,22 @@ void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
>  	spin_unlock(&discard_ctl->lock);
>  }
>  
> +void btrfs_add_to_discard_unused_list(struct btrfs_discard_ctl *discard_ctl,
> +				      struct btrfs_block_group_cache *cache)
> +{
> +	spin_lock(&discard_ctl->lock);
> +
> +	if (!list_empty(&cache->discard_list))
> +		list_del_init(&cache->discard_list);
> +
> +	cache->discard_index = BTRFS_DISCARD_INDEX_UNUSED;
> +	cache->discard_eligible_time = ktime_get_ns();
> +	list_add_tail(&cache->discard_list,
> +		      &discard_ctl->discard_list[BTRFS_DISCARD_INDEX_UNUSED]);
> +
> +	spin_unlock(&discard_ctl->lock);
> +}
> +
>  static bool remove_from_discard_list(struct btrfs_discard_ctl *discard_ctl,
>  				     struct btrfs_block_group_cache *cache)
>  {
> @@ -152,7 +172,11 @@ void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
>  	if (!cache || !btrfs_test_opt(cache->fs_info, DISCARD_ASYNC))
>  		return;
>  
> -	btrfs_add_to_discard_list(discard_ctl, cache);
> +	if (btrfs_block_group_used(&cache->item) == 0)
> +		btrfs_add_to_discard_unused_list(discard_ctl, cache);
> +	else
> +		btrfs_add_to_discard_list(discard_ctl, cache);
> +
>  	if (!delayed_work_pending(&discard_ctl->work))
>  		btrfs_discard_schedule_work(discard_ctl, false);
>  }
> @@ -197,6 +221,27 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
>  	spin_unlock(&discard_ctl->lock);
>  }
>  
> +/**
> + * btrfs_finish_discard_pass - determine next step of a block_group
> + *
> + * This determines the next step for a block group after it's finished going
> + * through a pass on a discard list.  If it is unused and fully trimmed, we can
> + * mark it unused and send it to the unused_bgs path.  Otherwise, pass it onto
> + * the appropriate filter list or let it fall off.
> + */
> +static void btrfs_finish_discard_pass(struct btrfs_discard_ctl *discard_ctl,
> +				      struct btrfs_block_group_cache *cache)
> +{
> +	remove_from_discard_list(discard_ctl, cache);
> +
> +	if (btrfs_block_group_used(&cache->item) == 0) {
> +		if (btrfs_is_free_space_trimmed(cache))
> +			btrfs_mark_bg_unused(cache);
> +		else
> +			btrfs_add_to_discard_unused_list(discard_ctl, cache);
> +	}
> +}
> +
>  /**
>   * btrfs_discard_workfn - discard work function
>   * @work: work
> @@ -218,7 +263,7 @@ static void btrfs_discard_workfn(struct work_struct *work)
>  	btrfs_trim_block_group(cache, &trimmed, cache->key.objectid,
>  			       btrfs_block_group_end(cache), 0);
>  
> -	remove_from_discard_list(discard_ctl, cache);
> +	btrfs_finish_discard_pass(discard_ctl, cache);
>  
>  	btrfs_discard_schedule_work(discard_ctl, false);
>  }
> @@ -239,6 +284,63 @@ bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl)
>  		test_bit(BTRFS_FS_DISCARD_RUNNING, &fs_info->flags));
>  }
>  
> +/**
> + * btrfs_discard_punt_unused_bgs_list - punt unused_bgs list to discard lists
> + * @fs_info: fs_info of interest
> + *
> + * The unused_bgs list needs to be punted to the discard lists because the
> + * order of operations is changed.  In the normal sychronous discard path, the
> + * block groups are trimmed via a single large trim in transaction commit.  This
> + * is ultimately what we are trying to avoid with asynchronous discard.  Thus,
> + * it must be done before going down the unused_bgs path.
> + */
> +void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_block_group_cache *cache, *next;
> +
> +	spin_lock(&fs_info->unused_bgs_lock);
> +
> +	/* We enabled async discard, so punt all to the queue. */
> +	list_for_each_entry_safe(cache, next, &fs_info->unused_bgs, bg_list) {
> +		list_del_init(&cache->bg_list);
> +		btrfs_add_to_discard_unused_list(&fs_info->discard_ctl, cache);
> +	}
> +
> +	spin_unlock(&fs_info->unused_bgs_lock);
> +}
> +
> +/**
> + * btrfs_discard_purge_list - purge discard lists
> + * @discard_ctl: discard control
> + *
> + * If we are disabling async discard, we may have intercepted block groups that
> + * are completely free and ready for the unused_bgs path.  As discarding will
> + * now happen in transaction commit or not at all, we can safely mark the
> + * corresponding block groups as unused and they will be sent on their merry
> + * way to the unused_bgs list.
> + */
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
> +			if (btrfs_block_group_used(&cache->item) == 0)
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
> @@ -246,6 +348,8 @@ void btrfs_discard_resume(struct btrfs_fs_info *fs_info)
>  		return;
>  	}
>  
> +	btrfs_discard_punt_unused_bgs_list(fs_info);
> +
>  	set_bit(BTRFS_FS_DISCARD_RUNNING, &fs_info->flags);
>  }
>  
> @@ -271,4 +375,6 @@ void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
>  {
>  	btrfs_discard_stop(fs_info);
>  	cancel_delayed_work_sync(&fs_info->discard_ctl.work);
> +
> +	btrfs_discard_purge_list(&fs_info->discard_ctl);
>  }
> diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
> index 48b4710a80d0..db003a244eb7 100644
> --- a/fs/btrfs/discard.h
> +++ b/fs/btrfs/discard.h
> @@ -9,9 +9,13 @@ struct btrfs_fs_info;
>  struct btrfs_discard_ctl;
>  struct btrfs_block_group_cache;
>  
> +/* List operations. */
>  void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
>  			       struct btrfs_block_group_cache *cache);
> +void btrfs_add_to_discard_unused_list(struct btrfs_discard_ctl *discard_ctl,
> +				      struct btrfs_block_group_cache *cache);
>  
> +/* Work operations. */
>  void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
>  			       struct btrfs_block_group_cache *cache);
>  void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
> @@ -20,6 +24,8 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
>  				 bool override);
>  bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl);
>  
> +/* Setup/Cleanup operations. */
> +void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info);
>  void btrfs_discard_resume(struct btrfs_fs_info *fs_info);
>  void btrfs_discard_stop(struct btrfs_fs_info *fs_info);
>  void btrfs_discard_init(struct btrfs_fs_info *fs_info);
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 8120630e4439..80a205449547 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -2681,6 +2681,37 @@ void btrfs_remove_free_space_cache(struct btrfs_block_group_cache *block_group)
>  
>  }
>  
> +/**
> + * btrfs_is_free_space_trimmed - see if everything is trimmed
> + * @cache: block_group of interest
> + *
> + * Walk the @cache's free space rb_tree to determine if everything is trimmed.
> + */
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

I'm not a fan of this, but it's only appears to be called when
btrfs_block_group_item_used() == 0, so there should only be at most 2 entries in
general.  However this could be fixed up to keep track of untrimmed ytes in
free_space_ctl.  Not a big enough deal for right now, but maybe if you feel
squirrely in the future.  Otherwise

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
