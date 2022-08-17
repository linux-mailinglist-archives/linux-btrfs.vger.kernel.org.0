Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0407596C44
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 11:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiHQJsQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 05:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbiHQJrz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 05:47:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A01E6AA38
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 02:47:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BC026142A
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 09:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D10C433D6;
        Wed, 17 Aug 2022 09:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660729672;
        bh=7IgIvpItRzG5n///Wmmzb32VY8HdvCwJmIYxglZOdl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PSHzizp6jxRR8f4JynH9BPLXp4LCNp2J1x/1GSKMPTaDJZx7oW8+K9vQIwlpsZt57
         9t1qke5YqBccMnMeQWpEZOI26BzX20taEY6YoaWwN4skwY+Fuwv5tDOwr+bk/eQXXV
         AqPp+v0ZCpq5RwNY+MBvAUrRHorUbuTNxGJvFddxuIZqSUbqT06hb0bT+/poLe1opt
         Svdl0+/8K5eZWtKU9Xw6H03jaEDmr6S5DAHiRkbm2NVnBOrEMvUBR02WGGJXII1XhZ
         d/179zKpNM/m5nI6TS75WppUKzqYU130W/UFqYGzmah0OI34uLBMGEx7k1zRe+w0C/
         zCyAJozCJuHQA==
Date:   Wed, 17 Aug 2022 10:47:49 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: get rid of block group caching progress logic
Message-ID: <20220817094749.GB2815552@falcondesktop>
References: <cover.1660690698.git.osandov@fb.com>
 <1ac68be51384f9cc2433bb7979f4cda563e72976.1660690698.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ac68be51384f9cc2433bb7979f4cda563e72976.1660690698.git.osandov@fb.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 16, 2022 at 04:12:16PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> struct btrfs_caching_ctl::progress and struct
> btrfs_block_group::last_byte_to_unpin were previously needed to ensure
> that unpin_extent_range() didn't return a range to the free space cache
> before the caching thread had a chance to cache that range. However, the
> previous commit made it so that we always synchronously cache the block
> group at the time that we pin the extent, so this machinery is no longer
> necessary.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/block-group.c     | 13 ------------
>  fs/btrfs/block-group.h     |  2 --
>  fs/btrfs/extent-tree.c     |  9 ++-------
>  fs/btrfs/free-space-tree.c |  8 --------
>  fs/btrfs/transaction.c     | 41 --------------------------------------
>  fs/btrfs/zoned.c           |  1 -
>  6 files changed, 2 insertions(+), 72 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 1af6fc395a52..68992ad9ff2a 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -593,8 +593,6 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
>  
>  			if (need_resched() ||
>  			    rwsem_is_contended(&fs_info->commit_root_sem)) {
> -				if (wakeup)
> -					caching_ctl->progress = last;
>  				btrfs_release_path(path);
>  				up_read(&fs_info->commit_root_sem);
>  				mutex_unlock(&caching_ctl->mutex);
> @@ -618,9 +616,6 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
>  			key.objectid = last;
>  			key.offset = 0;
>  			key.type = BTRFS_EXTENT_ITEM_KEY;
> -
> -			if (wakeup)
> -				caching_ctl->progress = last;
>  			btrfs_release_path(path);
>  			goto next;
>  		}
> @@ -655,7 +650,6 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
>  
>  	total_found += add_new_free_space(block_group, last,
>  				block_group->start + block_group->length);
> -	caching_ctl->progress = (u64)-1;
>  
>  out:
>  	btrfs_free_path(path);
> @@ -725,8 +719,6 @@ static noinline void caching_thread(struct btrfs_work *work)
>  	}
>  #endif
>  
> -	caching_ctl->progress = (u64)-1;
> -
>  	up_read(&fs_info->commit_root_sem);
>  	btrfs_free_excluded_extents(block_group);
>  	mutex_unlock(&caching_ctl->mutex);
> @@ -755,7 +747,6 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, bool wait)
>  	mutex_init(&caching_ctl->mutex);
>  	init_waitqueue_head(&caching_ctl->wait);
>  	caching_ctl->block_group = cache;
> -	caching_ctl->progress = cache->start;
>  	refcount_set(&caching_ctl->count, 2);
>  	btrfs_init_work(&caching_ctl->work, caching_thread, NULL, NULL);
>  
> @@ -2076,11 +2067,9 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>  		/* Should not have any excluded extents. Just in case, though. */
>  		btrfs_free_excluded_extents(cache);
>  	} else if (cache->length == cache->used) {
> -		cache->last_byte_to_unpin = (u64)-1;
>  		cache->cached = BTRFS_CACHE_FINISHED;
>  		btrfs_free_excluded_extents(cache);
>  	} else if (cache->used == 0) {
> -		cache->last_byte_to_unpin = (u64)-1;
>  		cache->cached = BTRFS_CACHE_FINISHED;
>  		add_new_free_space(cache, cache->start,
>  				   cache->start + cache->length);
> @@ -2136,7 +2125,6 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
>  		/* Fill dummy cache as FULL */
>  		bg->length = em->len;
>  		bg->flags = map->type;
> -		bg->last_byte_to_unpin = (u64)-1;
>  		bg->cached = BTRFS_CACHE_FINISHED;
>  		bg->used = em->len;
>  		bg->flags = map->type;
> @@ -2482,7 +2470,6 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
>  	set_free_space_tree_thresholds(cache);
>  	cache->used = bytes_used;
>  	cache->flags = type;
> -	cache->last_byte_to_unpin = (u64)-1;
>  	cache->cached = BTRFS_CACHE_FINISHED;
>  	cache->global_root_id = calculate_global_root_id(fs_info, cache->start);
>  
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 9dba28bb1806..59a86e82a28e 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -63,7 +63,6 @@ struct btrfs_caching_control {
>  	wait_queue_head_t wait;
>  	struct btrfs_work work;
>  	struct btrfs_block_group *block_group;
> -	u64 progress;
>  	refcount_t count;
>  };
>  
> @@ -115,7 +114,6 @@ struct btrfs_block_group {
>  	/* Cache tracking stuff */
>  	int cached;
>  	struct btrfs_caching_control *caching_ctl;
> -	u64 last_byte_to_unpin;
>  
>  	struct btrfs_space_info *space_info;
>  
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 86ac953c69ac..bcd0e72cded3 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2686,13 +2686,8 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
>  		len = cache->start + cache->length - start;
>  		len = min(len, end + 1 - start);
>  
> -		down_read(&fs_info->commit_root_sem);
> -		if (start < cache->last_byte_to_unpin && return_free_space) {
> -			u64 add_len = min(len, cache->last_byte_to_unpin - start);
> -
> -			btrfs_add_free_space(cache, start, add_len);
> -		}
> -		up_read(&fs_info->commit_root_sem);
> +		if (return_free_space)
> +			btrfs_add_free_space(cache, start, len);
>  
>  		start += len;
>  		total_unpinned += len;
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index 1bf89aa67216..367bcfcf68f5 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -1453,8 +1453,6 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
>  		ASSERT(key.type == BTRFS_FREE_SPACE_BITMAP_KEY);
>  		ASSERT(key.objectid < end && key.objectid + key.offset <= end);
>  
> -		caching_ctl->progress = key.objectid;
> -
>  		offset = key.objectid;
>  		while (offset < key.objectid + key.offset) {
>  			bit = free_space_test_bit(block_group, path, offset);
> @@ -1490,8 +1488,6 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
>  		goto out;
>  	}
>  
> -	caching_ctl->progress = (u64)-1;
> -
>  	ret = 0;
>  out:
>  	return ret;
> @@ -1531,8 +1527,6 @@ static int load_free_space_extents(struct btrfs_caching_control *caching_ctl,
>  		ASSERT(key.type == BTRFS_FREE_SPACE_EXTENT_KEY);
>  		ASSERT(key.objectid < end && key.objectid + key.offset <= end);
>  
> -		caching_ctl->progress = key.objectid;
> -
>  		total_found += add_new_free_space(block_group, key.objectid,
>  						  key.objectid + key.offset);
>  		if (total_found > CACHING_CTL_WAKE_UP) {
> @@ -1552,8 +1546,6 @@ static int load_free_space_extents(struct btrfs_caching_control *caching_ctl,
>  		goto out;
>  	}
>  
> -	caching_ctl->progress = (u64)-1;
> -
>  	ret = 0;
>  out:
>  	return ret;
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 6e3b2cb6a04a..4c87bf2abc14 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -161,7 +161,6 @@ static noinline void switch_commit_roots(struct btrfs_trans_handle *trans)
>  	struct btrfs_transaction *cur_trans = trans->transaction;
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  	struct btrfs_root *root, *tmp;
> -	struct btrfs_caching_control *caching_ctl, *next;
>  
>  	/*
>  	 * At this point no one can be using this transaction to modify any tree
> @@ -196,46 +195,6 @@ static noinline void switch_commit_roots(struct btrfs_trans_handle *trans)
>  	}
>  	spin_unlock(&cur_trans->dropped_roots_lock);
>  
> -	/*
> -	 * We have to update the last_byte_to_unpin under the commit_root_sem,
> -	 * at the same time we swap out the commit roots.
> -	 *
> -	 * This is because we must have a real view of the last spot the caching
> -	 * kthreads were while caching.  Consider the following views of the
> -	 * extent tree for a block group
> -	 *
> -	 * commit root
> -	 * +----+----+----+----+----+----+----+
> -	 * |\\\\|    |\\\\|\\\\|    |\\\\|\\\\|
> -	 * +----+----+----+----+----+----+----+
> -	 * 0    1    2    3    4    5    6    7
> -	 *
> -	 * new commit root
> -	 * +----+----+----+----+----+----+----+
> -	 * |    |    |    |\\\\|    |    |\\\\|
> -	 * +----+----+----+----+----+----+----+
> -	 * 0    1    2    3    4    5    6    7
> -	 *
> -	 * If the cache_ctl->progress was at 3, then we are only allowed to
> -	 * unpin [0,1) and [2,3], because the caching thread has already
> -	 * processed those extents.  We are not allowed to unpin [5,6), because
> -	 * the caching thread will re-start it's search from 3, and thus find
> -	 * the hole from [4,6) to add to the free space cache.
> -	 */
> -	write_lock(&fs_info->block_group_cache_lock);
> -	list_for_each_entry_safe(caching_ctl, next,
> -				 &fs_info->caching_block_groups, list) {
> -		struct btrfs_block_group *cache = caching_ctl->block_group;
> -
> -		if (btrfs_block_group_done(cache)) {
> -			cache->last_byte_to_unpin = (u64)-1;
> -			list_del_init(&caching_ctl->list);
> -			btrfs_put_caching_control(caching_ctl);
> -		} else {
> -			cache->last_byte_to_unpin = caching_ctl->progress;
> -		}
> -	}
> -	write_unlock(&fs_info->block_group_cache_lock);
>  	up_write(&fs_info->commit_root_sem);
>  }
>  
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 61ae58c3a354..56a147a6e571 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1558,7 +1558,6 @@ void btrfs_calc_zone_unusable(struct btrfs_block_group *cache)
>  	free = cache->zone_capacity - cache->alloc_offset;
>  
>  	/* We only need ->free_space in ALLOC_SEQ block groups */
> -	cache->last_byte_to_unpin = (u64)-1;
>  	cache->cached = BTRFS_CACHE_FINISHED;
>  	cache->free_space_ctl->free_space = free;
>  	cache->zone_unusable = unusable;
> -- 
> 2.37.2
> 
