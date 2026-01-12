Return-Path: <linux-btrfs+bounces-20425-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D337D1594D
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 23:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 180A73034A14
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 22:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4135269D18;
	Mon, 12 Jan 2026 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="TsTtFE+T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D/CIErAn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA399476
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768257139; cv=none; b=GdRnS5lqj3jaVTBQbayw5P16THGiF036nC5wko4jkfTvlJbSibWiIvOV4xsOV0uH0eMvoVqh6nWQBBErcC5SpNivznqLtFsqpg1gkEBIMQ8mBHpMJ6xXiPa3lGuVwK8ACCZLwZrE6QlUlXcSgLQ1C2vQLCPiviwn3pyvPcgAZ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768257139; c=relaxed/simple;
	bh=3AGpa9Fc64dl1xVXMlCGP/UOsgpYSGjXb6de8IyeUuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+JozejFRsNF33GpvFIPV5sG2La45rE8E/oB79zdd81juGlyQ3fGUt0VeFjxvxTb9xx9zbZj3YrwSDekkt3YTI6Qkvh/j7Fm8DPDEvB82AFx5fGGMYS7cY1TLlBn4+hhQDamog3I0ugCPv5CtR8Jx6ikclYxU8zCZnCbFrJLRyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=TsTtFE+T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D/CIErAn; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 81FB77A0050;
	Mon, 12 Jan 2026 17:32:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 12 Jan 2026 17:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1768257136; x=1768343536; bh=sU1UC6qYf1
	BGPLajlBNdG2hDDHtkpn8Ux7yW6ENY3bw=; b=TsTtFE+TYxga3FpiJ8wExZogk+
	/Jq3DTLPp+xrkKeDR04JtHhiBO3jHbuLBR6HeWCkUGuGULHaom8SKsSvWaE953ie
	78xuJVv2hnTEFpKaEI4P6qBWousLcD4TA3KMz5WR/VvUugeIBjwb9wWiwM/YYe2C
	XcbDBhppMJx9xMiPu+3c6sVMxJSttYhUYz6jEzP6Nsk3ixQwE65MweeHFH0BQjd7
	e9yvcLCcjaRKLi7gdN2zp+VByHTUiRmZD01AVPvwuuC7uRYuMRMDqJ7YWqYmmZYZ
	0ZfI58XaO1GQeRHbce944tvNiWdUcrBWjiv19Wp1BLYo/9xF6y4aBL3iBMRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768257136; x=1768343536; bh=sU1UC6qYf1BGPLajlBNdG2hDDHtkpn8Ux7y
	W6ENY3bw=; b=D/CIErAn0GSdZLvi0WVaOpBbR/dGX0C2/sct+E8IkNoylwJEw5a
	qMk6Neks6ikDRwbYCu9bA46D6BapQMySKoj4w8YtPjoN7XaKDprzEvMHGrh5S3C+
	/zOTy0rZoZSN78FA1rlzvBQ3VowXGIELqYP8N6GytPy9BEVBMVAPI0sXi453pTVG
	FlWMELFAp/+hwF0HXHU458Lmvsdj4Fv0/Y3G4UP2Mzxe1tSEKh0cEnULjMkd1Pzt
	eV4T2pFEWAyhXTBRIDkKU53i5cYSHovc4OinfJ/wq4VWyOmokOWlddQfK4m6VWn9
	Mc5Bzqrc9Ue+vHEncjrgyr0kbAcNANjWM6g==
X-ME-Sender: <xms:cHZlafESrtMcoQiILNcpJta7yceTyvBveqFiGLf0bwlp9NgPE703VA>
    <xme:cHZlaSU24tLnojl2IUCHpZXjKjWToEVaCIwx2cLUvKgKXzLB4_M_ihRbceuXUFCjg
    _LbaQkXNq8s70soHs7UgZs4CSpBERKG2fo3e0i5BKVewuRtGLRxCHk9>
X-ME-Received: <xmr:cHZlaexBWzsbavOrzPk28K49inKG_7CQ2_KlpcWSidCatqfBiELqZN8V3SSKfI5U5PvWZmiZhKFKk_ZkqfeyolEnmZI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudekieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhtihhnsehurhgsrggtkhhuphdrohhrghdprhgtphhtthhopehlihhnuhigqd
    gsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cHZlaYNif9gwSTPb4cF8DzLV8krDUeUAPXpC5uo80I0ss1pQsoF0Pw>
    <xmx:cHZlaX4hSfWS6pVAXSp47LaQ7oALbntt03eM94v_1-x5fnt-5lDLNA>
    <xmx:cHZlaRNi-uWKA38pLrlcCDpisoTIX1GAx5B95DSR4OL3ZuKECPYD2w>
    <xmx:cHZladmG0Z411VXn2TljbzA8aN6Zu3WiZqLohuFz3LbmIlgnH8c3NQ>
    <xmx:cHZladzw5nqqUZU4HmtbG1fwKm7iNkxiVdODAMGRYSXUpifg_X20xogT>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 17:32:15 -0500 (EST)
Date: Mon, 12 Jan 2026 14:32:17 -0800
From: Boris Burkov <boris@bur.io>
To: Martin Raiber <martin@urbackup.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/7] btrfs: Use percpu refcounting for block groups
Message-ID: <20260112223217.GA459994@zen.localdomain>
References: <20260112161549.2786827-1-martin@urbackup.org>
 <0102019bb2ff56b7-9302e783-c17d-452d-b6a7-11f773776ae7-000000@eu-west-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0102019bb2ff56b7-9302e783-c17d-452d-b6a7-11f773776ae7-000000@eu-west-1.amazonses.com>

On Mon, Jan 12, 2026 at 04:17:16PM +0000, Martin Raiber wrote:
> Use a percpu counter to keep track of the block group refs.
> This prevents CPU synchronization completely as long as the main reference
> is not freed via btrfs_remove_block_group, improving performance of
> btrfs_put_block_group, btrfs_get_block_group significantly.

Besides the potential mixup with patch 2, this looks like a nice
improvement to me, since we adhere to the pattern of having a "main"
refcount for the rb tree entry.

My only other complaint is that this seems to lose the helpful
refcount_t warning feature. But I think I can live with that.

> 
> Signed-off-by: Martin Raiber <martin@urbackup.org>
> ---
>  fs/btrfs/block-group.c | 111 +++++++++++++++++++++++------------------
>  fs/btrfs/block-group.h |   2 +-
>  2 files changed, 63 insertions(+), 50 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index a1119f06b6d1..7569438ccbd5 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -153,37 +153,44 @@ u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags)
>  
>  void btrfs_get_block_group(struct btrfs_block_group *cache)
>  {
> -	refcount_inc(&cache->refs);
> +	percpu_ref_get(&cache->refs);
>  }
>  
> -void btrfs_put_block_group(struct btrfs_block_group *cache)
> +static void btrfs_free_block_group(struct percpu_ref *ref)
>  {
> -	if (refcount_dec_and_test(&cache->refs)) {
> -		WARN_ON(cache->pinned > 0);
> -		/*
> -		 * If there was a failure to cleanup a log tree, very likely due
> -		 * to an IO failure on a writeback attempt of one or more of its
> -		 * extent buffers, we could not do proper (and cheap) unaccounting
> -		 * of their reserved space, so don't warn on reserved > 0 in that
> -		 * case.
> -		 */
> -		if (!(cache->flags & BTRFS_BLOCK_GROUP_METADATA) ||
> -		    !BTRFS_FS_LOG_CLEANUP_ERROR(cache->fs_info))
> -			WARN_ON(cache->reserved > 0);
> +	struct btrfs_block_group *cache =
> +		container_of(ref, struct btrfs_block_group, refs);

I think for most new code we call these 'block_group' rather than
'cache', so I think this is a good opportunity to update it.

>  
> -		/*
> -		 * A block_group shouldn't be on the discard_list anymore.
> -		 * Remove the block_group from the discard_list to prevent us
> -		 * from causing a panic due to NULL pointer dereference.
> -		 */
> -		if (WARN_ON(!list_empty(&cache->discard_list)))
> -			btrfs_discard_cancel_work(&cache->fs_info->discard_ctl,
> -						  cache);
> +	WARN_ON(cache->pinned > 0);
> +	/*
> +	* If there was a failure to cleanup a log tree, very likely due
> +	* to an IO failure on a writeback attempt of one or more of its
> +	* extent buffers, we could not do proper (and cheap) unaccounting
> +	* of their reserved space, so don't warn on reserved > 0 in that
> +	* case.
> +	*/
> +	if (!(cache->flags & BTRFS_BLOCK_GROUP_METADATA) ||
> +		!BTRFS_FS_LOG_CLEANUP_ERROR(cache->fs_info))
> +		WARN_ON(cache->reserved > 0);
>  
> -		kfree(cache->free_space_ctl);
> -		btrfs_free_chunk_map(cache->physical_map);
> -		kfree(cache);
> -	}
> +	/*
> +	* A block_group shouldn't be on the discard_list anymore.
> +	* Remove the block_group from the discard_list to prevent us
> +	* from causing a panic due to NULL pointer dereference.
> +	*/
> +	if (WARN_ON(!list_empty(&cache->discard_list)))
> +		btrfs_discard_cancel_work(&cache->fs_info->discard_ctl,
> +						cache);
> +
> +	percpu_ref_exit(&cache->refs);
> +	kfree(cache->free_space_ctl);
> +	btrfs_free_chunk_map(cache->physical_map);
> +	kfree(cache);
> +}
> +
> +void btrfs_put_block_group(struct btrfs_block_group *cache)
> +{
> +	percpu_ref_put(&cache->refs);
>  }
>  
>  static int btrfs_bg_start_cmp(const struct rb_node *new,
> @@ -406,8 +413,8 @@ void btrfs_wait_block_group_reservations(struct btrfs_block_group *bg)
>  	 * on the groups' semaphore is held and decremented after releasing
>  	 * the read access on that semaphore and creating the ordered extent.
>  	 */
> -	down_write(&space_info->groups_sem);
> -	up_write(&space_info->groups_sem);
> +	percpu_down_write(&space_info->groups_sem);
> +	percpu_up_write(&space_info->groups_sem);

Did this sneak out of patch 2 into this patch? (several other instances
in this patch that I won't note)

>  
>  	wait_var_event(&bg->reservations, !atomic_read(&bg->reservations));
>  }
> @@ -1012,7 +1019,7 @@ static void clear_incompat_bg_bits(struct btrfs_fs_info *fs_info, u64 flags)
>  		struct btrfs_space_info *sinfo;
>  
>  		list_for_each_entry_rcu(sinfo, head, list) {
> -			down_read(&sinfo->groups_sem);
> +			percpu_down_read(&sinfo->groups_sem);
>  			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID5]))
>  				found_raid56 = true;
>  			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID6]))
> @@ -1021,7 +1028,7 @@ static void clear_incompat_bg_bits(struct btrfs_fs_info *fs_info, u64 flags)
>  				found_raid1c34 = true;
>  			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID1C4]))
>  				found_raid1c34 = true;
> -			up_read(&sinfo->groups_sem);
> +			percpu_up_read(&sinfo->groups_sem);
>  		}
>  		if (!found_raid56)
>  			btrfs_clear_fs_incompat(fs_info, RAID56);
> @@ -1159,11 +1166,11 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>  	RB_CLEAR_NODE(&block_group->cache_node);
>  
>  	/* Once for the block groups rbtree */
> -	btrfs_put_block_group(block_group);
> +	percpu_ref_kill(&block_group->refs);
>  
>  	write_unlock(&fs_info->block_group_cache_lock);
>  
> -	down_write(&block_group->space_info->groups_sem);
> +	percpu_down_write(&block_group->space_info->groups_sem);
>  	/*
>  	 * we must use list_del_init so people can check to see if they
>  	 * are still on the list after taking the semaphore
> @@ -1174,7 +1181,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>  		block_group->space_info->block_group_kobjs[index] = NULL;
>  		clear_avail_alloc_bits(fs_info, block_group->flags);
>  	}
> -	up_write(&block_group->space_info->groups_sem);
> +	percpu_up_write(&block_group->space_info->groups_sem);
>  	clear_incompat_bg_bits(fs_info, block_group->flags);
>  	if (kobj) {
>  		kobject_del(kobj);
> @@ -1544,7 +1551,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  		btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
>  
>  		/* Don't want to race with allocators so take the groups_sem */
> -		down_write(&space_info->groups_sem);
> +		percpu_down_write(&space_info->groups_sem);
>  
>  		/*
>  		 * Async discard moves the final block group discard to be prior
> @@ -1554,7 +1561,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  		if (btrfs_test_opt(fs_info, DISCARD_ASYNC) &&
>  		    !btrfs_is_free_space_trimmed(block_group)) {
>  			trace_btrfs_skip_unused_block_group(block_group);
> -			up_write(&space_info->groups_sem);
> +			percpu_up_write(&space_info->groups_sem);
>  			/* Requeue if we failed because of async discard */
>  			btrfs_discard_queue_work(&fs_info->discard_ctl,
>  						 block_group);
> @@ -1581,7 +1588,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  			trace_btrfs_skip_unused_block_group(block_group);
>  			spin_unlock(&block_group->lock);
>  			spin_unlock(&space_info->lock);
> -			up_write(&space_info->groups_sem);
> +			percpu_up_write(&space_info->groups_sem);
>  			goto next;
>  		}
>  
> @@ -1618,7 +1625,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  			trace_btrfs_skip_unused_block_group(block_group);
>  			spin_unlock(&block_group->lock);
>  			spin_unlock(&space_info->lock);
> -			up_write(&space_info->groups_sem);
> +			percpu_up_write(&space_info->groups_sem);
>  			goto next;
>  		}
>  
> @@ -1627,7 +1634,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  
>  		/* We don't want to force the issue, only flip if it's ok. */
>  		ret = inc_block_group_ro(block_group, 0);
> -		up_write(&space_info->groups_sem);
> +		percpu_up_write(&space_info->groups_sem);
>  		if (ret < 0) {
>  			ret = 0;
>  			goto next;
> @@ -1882,7 +1889,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  		spin_unlock(&fs_info->unused_bgs_lock);
>  
>  		/* Don't race with allocators so take the groups_sem */
> -		down_write(&space_info->groups_sem);
> +		percpu_down_write(&space_info->groups_sem);
>  
>  		spin_lock(&space_info->lock);
>  		spin_lock(&bg->lock);
> @@ -1895,7 +1902,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  			 */
>  			spin_unlock(&bg->lock);
>  			spin_unlock(&space_info->lock);
> -			up_write(&space_info->groups_sem);
> +			percpu_up_write(&space_info->groups_sem);
>  			goto next;
>  		}
>  		if (bg->used == 0) {
> @@ -1914,7 +1921,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  				btrfs_mark_bg_unused(bg);
>  			spin_unlock(&bg->lock);
>  			spin_unlock(&space_info->lock);
> -			up_write(&space_info->groups_sem);
> +			percpu_up_write(&space_info->groups_sem);
>  			goto next;
>  
>  		}
> @@ -1931,7 +1938,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  		if (!should_reclaim_block_group(bg, bg->length)) {
>  			spin_unlock(&bg->lock);
>  			spin_unlock(&space_info->lock);
> -			up_write(&space_info->groups_sem);
> +			percpu_up_write(&space_info->groups_sem);
>  			goto next;
>  		}
>  
> @@ -1947,12 +1954,12 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  		 * never gets back to read-write to let us reclaim again.
>  		 */
>  		if (btrfs_need_cleaner_sleep(fs_info)) {
> -			up_write(&space_info->groups_sem);
> +			percpu_up_write(&space_info->groups_sem);
>  			goto next;
>  		}
>  
>  		ret = inc_block_group_ro(bg, 0);
> -		up_write(&space_info->groups_sem);
> +		percpu_up_write(&space_info->groups_sem);
>  		if (ret < 0)
>  			goto next;
>  
> @@ -2288,7 +2295,12 @@ static struct btrfs_block_group *btrfs_create_block_group(
>  
>  	cache->discard_index = BTRFS_DISCARD_INDEX_UNUSED;
>  
> -	refcount_set(&cache->refs, 1);
> +	if (percpu_ref_init(&cache->refs, btrfs_free_block_group,
> +			  0, GFP_NOFS)) {
> +		kfree(cache->free_space_ctl);
> +		kfree(cache);
> +		return NULL;
> +	}
>  	spin_lock_init(&cache->lock);
>  	init_rwsem(&cache->data_rwsem);
>  	INIT_LIST_HEAD(&cache->list);
> @@ -4550,9 +4562,9 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
>  		RB_CLEAR_NODE(&block_group->cache_node);
>  		write_unlock(&info->block_group_cache_lock);
>  
> -		down_write(&block_group->space_info->groups_sem);
> +		percpu_down_write(&block_group->space_info->groups_sem);
>  		list_del(&block_group->list);
> -		up_write(&block_group->space_info->groups_sem);
> +		percpu_up_write(&block_group->space_info->groups_sem);
>  
>  		/*
>  		 * We haven't cached this block group, which means we could
> @@ -4567,9 +4579,10 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
>  		ASSERT(list_empty(&block_group->dirty_list));
>  		ASSERT(list_empty(&block_group->io_list));
>  		ASSERT(list_empty(&block_group->bg_list));
> -		ASSERT(refcount_read(&block_group->refs) == 1);
> +		ASSERT(!percpu_ref_is_zero(&block_group->refs));
>  		ASSERT(block_group->swap_extents == 0);
> -		btrfs_put_block_group(block_group);
> +		percpu_ref_kill(&block_group->refs);
> +		ASSERT(percpu_ref_is_zero(&block_group->refs));
>  
>  		write_lock(&info->block_group_cache_lock);
>  	}
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 5f933455118c..d44675f9d601 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -178,7 +178,7 @@ struct btrfs_block_group {
>  	/* For block groups in the same raid type */
>  	struct list_head list;
>  
> -	refcount_t refs;
> +	struct percpu_ref refs;
>  
>  	/*
>  	 * List of struct btrfs_free_clusters for this block group.
> -- 
> 2.39.5
> 

