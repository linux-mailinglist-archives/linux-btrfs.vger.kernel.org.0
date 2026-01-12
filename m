Return-Path: <linux-btrfs+bounces-20426-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F80D15B4B
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 23:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A7F0301E683
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 22:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AE82BE64A;
	Mon, 12 Jan 2026 22:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="n7anCKwe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cf99kCdq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A453270EC1
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768258686; cv=none; b=rDrGHxlfR4bImrWxMbbaq6ZkIfLsN9C7p7Jj4JMbTXo8lOzFDbWf0nrsM3kgl+YDqi26STpRa2p/ei7zo4BypkHPPSBlxV7Sn9+HLKrwD8Z0SuVxd7aXZM3KxtrEdeRCsCPR2q2PJfNpOjTnD6UZ21SRY9o4EyclqW+0TEJ7bOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768258686; c=relaxed/simple;
	bh=Fwa13SYsjay6Vg4XB+1C43Qs5Bj7IXQG//wGVtUMsRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbmt3Sa7KSskjc48tIL5sDM47QYH/k+RItarLQ4t24UvGHgxJNHLycUvH+fgLrt+ij8KF/ulHIO51wLYM+pSvRky0OlnYp0hMyt9X3Sx0NikZ7deThH51Au6hqOzbRX/D9ZnsPY5Mv3GvJDn09gjgjzhOQggRRbHxD27u1v/KZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=n7anCKwe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cf99kCdq; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 62E427A00C1;
	Mon, 12 Jan 2026 17:58:03 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 12 Jan 2026 17:58:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1768258683; x=1768345083; bh=lZJJAtfUAd
	9l4AKLsgY0+HzGp9ZbJFnQHmP7BHR1Rig=; b=n7anCKweyCDPXohrEgCFErheBP
	hP0XJDmFQpbIqqdYUnJuhxXDHPR4D9GdrfMtPSHOudglxLBffUOtTSBHh3vSpssR
	xt/ESNdVqzIEg+GgOIom9dn8kly7uaDaSdTb9mzqD144s1vPa7cJven8tBefojH4
	387QjNtlsrk72hnjkiSp6oxC9ILbUMcTLCDNH0xqLrbTz3v6J0O5wqbgRhAWUKk3
	dP4+KyAh7FuMPose3VLHjb3m8ZBRluvm6Xej8+uKpY0G+fYJy5h8e7vqALBIPDJn
	2k8pFK84xsMlO1uD2iLj0RHnVyMTwOgEa4LN125Z/GWy/pK/Pk8f3PpekMvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768258683; x=1768345083; bh=lZJJAtfUAd9l4AKLsgY0+HzGp9ZbJFnQHmP
	7BHR1Rig=; b=cf99kCdqmOUDJWifs900nIDwgF7BfUIGHsb3NiZm26WJrUFlKot
	IyDB3n/uLYX0f7lvGk58y9VDURkpjAiV5YT6Zbw6DK8zcdfOPVEcDlQNoMdCrYyU
	g3yhcMzdo6SR7gjvwg/cKVLHtLa6gS6C2noI7iXlNflJPp8Zp/sNo4VAHIcbKZvf
	mtfbGvGdg/+EY5yocIHNeDj7rfuuOAZuZguxsdVxXjiYCFa8+onZjer2E07kRg4R
	oI0k06LFmY5GceTXbmozqUCKAnhnoZAt3tsk+mZSu9U6/oQLmwLLp1EkUeGseAKA
	M2mzKdh//cUFi/+JKeNJIL4uYZir0K0gGmA==
X-ME-Sender: <xms:e3xlaTGRUh2SvlOaL6cplqtFT4HPglULSVta-bMyZIZmn1d7aQC6VQ>
    <xme:e3xlaWV3Wdp0u50jua4VCDnpFJDQEWingWAnYrdSyCDXrbzN_rQvNPTVYMvGZdP63
    Ntmc3rmXK04DFW2DpTPKOHwEeZemOYek6CkSISZj12PJ5cuVu0QQnw>
X-ME-Received: <xmr:e3xlaSyKwTT1ukccntOGtIn4w3Imaw3Q9sqGVaEOQU4g-9VsRaqADi73JlqqNlFE8e4p6-yS5Jp2_-9GWHIkfEaGQZM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudekjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhtihhnsehurhgsrggtkhhuphdrohhrghdprhgtphhtthhopehlihhnuhigqd
    gsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:e3xlacOl9Qi7SJbOH0Yrf6b8lV1MdIaXVwL_f0VZ9sKnHO1E9yCfMg>
    <xmx:e3xlab5DD1egQ6HzDSpTF6ZdCVLI5Z9csZfrRUexWexlArhs8RNlXw>
    <xmx:e3xlaVN3HJ1pTjzHRYMMQdxRuCxzNTKyp3HUHIDfGp6Bjq7FDixbqw>
    <xmx:e3xlaRkTbE59HodKDqyyMJ3bfJUK9pl4FvuiZrG6H64ozkGMYGKLUQ>
    <xmx:e3xlaRyRGujr2ouGfx3MywdC55CM5n0Bb7Agtcy-Ej_L-1goXi_TTY6P>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 17:58:02 -0500 (EST)
Date: Mon, 12 Jan 2026 14:58:04 -0800
From: Boris Burkov <boris@bur.io>
To: Martin Raiber <martin@urbackup.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/7] btrfs: Use percpu semaphore for space info groups_sem
Message-ID: <20260112225804.GB459994@zen.localdomain>
References: <20260112161549.2786827-1-martin@urbackup.org>
 <0102019bb2ff5805-8aa151b8-1fe7-4087-9610-4c3314b3b144-000000@eu-west-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0102019bb2ff5805-8aa151b8-1fe7-4087-9610-4c3314b3b144-000000@eu-west-1.amazonses.com>

On Mon, Jan 12, 2026 at 04:17:17PM +0000, Martin Raiber wrote:
> Groups_sem is locked for write mostly only when adding
> or removing block groups, whereas it is locked for read
> constantly by multiple CPUs.
> Change it into a percpu semaphore to significantly
> increase the performance of find_free_extent.

This argument makes sense to me, and I don't think the proposal is wrong
or anything.

However, I am concerned about the low amount of evidence and detail for
a major change like this.

Can you share your benchmarking results?

What, if any, changes in fairness behavior would we expect going from
rwsem to percpu-rwsem?

Can you characterize the effect on adding / removing block groups? How
long does it currently take? How long does it take once you make it wait
for an rcu grace period? That will affect ENOSPC flushing which can be
blocking some task, so drastically hurting that performance could be bad.

I suspect it will be fine, though.

Thanks,
Boris

> 
> Signed-off-by: Martin Raiber <martin@urbackup.org>
> ---
>  fs/btrfs/extent-tree.c |  8 ++++----
>  fs/btrfs/ioctl.c       |  8 ++++----
>  fs/btrfs/space-info.c  | 29 +++++++++++++++++++----------
>  fs/btrfs/space-info.h  |  2 +-
>  fs/btrfs/sysfs.c       |  9 +++++----
>  fs/btrfs/zoned.c       | 11 +++++------
>  6 files changed, 38 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 1dcd69fe97ed..ce2eef069663 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4442,7 +4442,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  		if (block_group && block_group_bits(block_group, ffe_ctl->flags) &&
>  		    block_group->space_info == space_info &&
>  		    block_group->cached != BTRFS_CACHE_NO) {
> -			down_read(&space_info->groups_sem);
> +			percpu_down_read(&space_info->groups_sem);
>  			if (list_empty(&block_group->list) ||
>  			    block_group->ro) {
>  				/*
> @@ -4452,7 +4452,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  				 * valid
>  				 */
>  				btrfs_put_block_group(block_group);
> -				up_read(&space_info->groups_sem);
> +				percpu_up_read(&space_info->groups_sem);
>  			} else {
>  				ffe_ctl->index = btrfs_bg_flags_to_raid_index(
>  							block_group->flags);
> @@ -4471,7 +4471,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  	if (ffe_ctl->index == btrfs_bg_flags_to_raid_index(ffe_ctl->flags) ||
>  	    ffe_ctl->index == 0)
>  		full_search = true;
> -	down_read(&space_info->groups_sem);
> +	percpu_down_read(&space_info->groups_sem);
>  	list_for_each_entry(block_group,
>  			    &space_info->block_groups[ffe_ctl->index], list) {
>  		struct btrfs_block_group *bg_ret;
> @@ -4609,7 +4609,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  		release_block_group(block_group, ffe_ctl, ffe_ctl->delalloc);
>  		cond_resched();
>  	}
> -	up_read(&space_info->groups_sem);
> +	percpu_up_read(&space_info->groups_sem);
>  
>  	ret = find_free_extent_update_loop(fs_info, ins, ffe_ctl, space_info,
>  					   full_search);
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index d9e7dd317670..73ff0efc0381 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2940,12 +2940,12 @@ static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
>  		if (!info)
>  			continue;
>  
> -		down_read(&info->groups_sem);
> +		percpu_down_read(&info->groups_sem);
>  		for (c = 0; c < BTRFS_NR_RAID_TYPES; c++) {
>  			if (!list_empty(&info->block_groups[c]))
>  				slot_count++;
>  		}
> -		up_read(&info->groups_sem);
> +		percpu_up_read(&info->groups_sem);
>  	}
>  
>  	/*
> @@ -2992,7 +2992,7 @@ static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
>  
>  		if (!info)
>  			continue;
> -		down_read(&info->groups_sem);
> +		percpu_down_read(&info->groups_sem);
>  		for (c = 0; c < BTRFS_NR_RAID_TYPES; c++) {
>  			if (!list_empty(&info->block_groups[c])) {
>  				get_block_group_info(&info->block_groups[c],
> @@ -3005,7 +3005,7 @@ static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
>  			if (!slot_count)
>  				break;
>  		}
> -		up_read(&info->groups_sem);
> +		percpu_up_read(&info->groups_sem);
>  	}
>  
>  	/*
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 857e4fd2c77e..ddedeccbdade 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -234,13 +234,14 @@ void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space_info,
>  	WRITE_ONCE(space_info->chunk_size, chunk_size);
>  }
>  
> -static void init_space_info(struct btrfs_fs_info *info,
> +static int init_space_info(struct btrfs_fs_info *info,
>  			    struct btrfs_space_info *space_info, u64 flags)
>  {
>  	space_info->fs_info = info;
>  	for (int i = 0; i < BTRFS_NR_RAID_TYPES; i++)
>  		INIT_LIST_HEAD(&space_info->block_groups[i]);
> -	init_rwsem(&space_info->groups_sem);
> +	if (!percpu_init_rwsem(&space_info->groups_sem))
> +		return -ENOMEM;
>  	spin_lock_init(&space_info->lock);
>  	space_info->flags = flags & BTRFS_BLOCK_GROUP_TYPE_MASK;
>  	space_info->force_alloc = CHUNK_ALLOC_NO_FORCE;
> @@ -253,6 +254,8 @@ static void init_space_info(struct btrfs_fs_info *info,
>  
>  	if (btrfs_is_zoned(info))
>  		space_info->bg_reclaim_threshold = BTRFS_DEFAULT_ZONED_RECLAIM_THRESH;
> +
> +	return 0;
>  }
>  
>  static int create_space_info_sub_group(struct btrfs_space_info *parent, u64 flags,
> @@ -270,7 +273,10 @@ static int create_space_info_sub_group(struct btrfs_space_info *parent, u64 flag
>  	if (!sub_group)
>  		return -ENOMEM;
>  
> -	init_space_info(fs_info, sub_group, flags);
> +	if (init_space_info(fs_info, sub_group, flags)) {
> +		kfree(sub_group);
> +		return -ENOMEM;
> +	}
>  	parent->sub_group[index] = sub_group;
>  	sub_group->parent = parent;
>  	sub_group->subgroup_id = id;
> @@ -293,7 +299,10 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>  	if (!space_info)
>  		return -ENOMEM;
>  
> -	init_space_info(info, space_info, flags);
> +	if (init_space_info(info, space_info, flags)) {
> +		kfree(space_info);
> +		return -ENOMEM;
> +	}
>  
>  	if (btrfs_is_zoned(info)) {
>  		if (flags & BTRFS_BLOCK_GROUP_DATA)
> @@ -384,9 +393,9 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
>  	block_group->space_info = space_info;
>  
>  	index = btrfs_bg_flags_to_raid_index(block_group->flags);
> -	down_write(&space_info->groups_sem);
> +	percpu_down_write(&space_info->groups_sem);
>  	list_add_tail(&block_group->list, &space_info->block_groups[index]);
> -	up_write(&space_info->groups_sem);
> +	percpu_up_write(&space_info->groups_sem);
>  }
>  
>  struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
> @@ -650,7 +659,7 @@ void btrfs_dump_space_info(struct btrfs_space_info *info, u64 bytes,
>  	if (!dump_block_groups)
>  		return;
>  
> -	down_read(&info->groups_sem);
> +	percpu_down_read(&info->groups_sem);
>  again:
>  	list_for_each_entry(cache, &info->block_groups[index], list) {
>  		u64 avail;
> @@ -670,7 +679,7 @@ void btrfs_dump_space_info(struct btrfs_space_info *info, u64 bytes,
>  	}
>  	if (++index < BTRFS_NR_RAID_TYPES)
>  		goto again;
> -	up_read(&info->groups_sem);
> +	percpu_up_read(&info->groups_sem);
>  
>  	btrfs_info(fs_info, "%llu bytes available across all block groups", total_avail);
>  }
> @@ -2095,7 +2104,7 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
>  	thresh_pct = btrfs_calc_reclaim_threshold(space_info);
>  	spin_unlock(&space_info->lock);
>  
> -	down_read(&space_info->groups_sem);
> +	percpu_down_read(&space_info->groups_sem);
>  again:
>  	list_for_each_entry(bg, &space_info->block_groups[raid], list) {
>  		u64 thresh;
> @@ -2127,7 +2136,7 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
>  		goto again;
>  	}
>  
> -	up_read(&space_info->groups_sem);
> +	percpu_up_read(&space_info->groups_sem);
>  }
>  
>  void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes)
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index 0703f24b23f7..f99624069391 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -175,7 +175,7 @@ struct btrfs_space_info {
>  	 */
>  	u64 tickets_id;
>  
> -	struct rw_semaphore groups_sem;
> +	struct percpu_rw_semaphore groups_sem;
>  	/* for block groups in our same type */
>  	struct list_head block_groups[BTRFS_NR_RAID_TYPES];
>  
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index ebd6d1d6778b..ccec9eb1fa4f 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -701,14 +701,14 @@ static ssize_t raid_bytes_show(struct kobject *kobj,
>  	int index = btrfs_bg_flags_to_raid_index(to_raid_kobj(kobj)->flags);
>  	u64 val = 0;
>  
> -	down_read(&sinfo->groups_sem);
> +	percpu_down_read(&sinfo->groups_sem);
>  	list_for_each_entry(block_group, &sinfo->block_groups[index], list) {
>  		if (&attr->attr == BTRFS_ATTR_PTR(raid, total_bytes))
>  			val += block_group->length;
>  		else
>  			val += block_group->used;
>  	}
> -	up_read(&sinfo->groups_sem);
> +	percpu_up_read(&sinfo->groups_sem);
>  	return sysfs_emit(buf, "%llu\n", val);
>  }
>  
> @@ -816,7 +816,7 @@ static ssize_t btrfs_size_classes_show(struct kobject *kobj,
>  	u32 large = 0;
>  
>  	for (int i = 0; i < BTRFS_NR_RAID_TYPES; ++i) {
> -		down_read(&sinfo->groups_sem);
> +		percpu_down_read(&sinfo->groups_sem);
>  		list_for_each_entry(bg, &sinfo->block_groups[i], list) {
>  			if (!btrfs_block_group_should_use_size_class(bg))
>  				continue;
> @@ -835,7 +835,7 @@ static ssize_t btrfs_size_classes_show(struct kobject *kobj,
>  				break;
>  			}
>  		}
> -		up_read(&sinfo->groups_sem);
> +		percpu_up_read(&sinfo->groups_sem);
>  	}
>  	return sysfs_emit(buf, "none %u\n"
>  			       "small %u\n"
> @@ -1046,6 +1046,7 @@ ATTRIBUTE_GROUPS(space_info);
>  static void space_info_release(struct kobject *kobj)
>  {
>  	struct btrfs_space_info *sinfo = to_space_info(kobj);
> +	percpu_free_rwsem(&sinfo->groups_sem);
>  	kfree(sinfo);
>  }
>  
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 2e861eef5cd8..da92b0d38a1b 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2588,12 +2588,11 @@ void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
>  			       "reloc_sinfo->subgroup_id=%d", reloc_sinfo->subgroup_id);
>  			factor = btrfs_bg_type_to_factor(bg->flags);
>  
> -			down_write(&space_info->groups_sem);
> +			percpu_down_write(&space_info->groups_sem);
>  			list_del_init(&bg->list);
>  			/* We can assume this as we choose the second empty one. */
>  			ASSERT(!list_empty(&space_info->block_groups[index]));
> -			up_write(&space_info->groups_sem);
> -
> +			percpu_up_write(&space_info->groups_sem);
>  			spin_lock(&space_info->lock);
>  			space_info->total_bytes -= bg->length;
>  			space_info->disk_total -= bg->length * factor;
> @@ -2771,7 +2770,7 @@ int btrfs_zoned_activate_one_bg(struct btrfs_space_info *space_info, bool do_fin
>  		int ret;
>  		bool need_finish = false;
>  
> -		down_read(&space_info->groups_sem);
> +		percpu_down_read(&space_info->groups_sem);
>  		for (index = 0; index < BTRFS_NR_RAID_TYPES; index++) {
>  			list_for_each_entry(bg, &space_info->block_groups[index],
>  					    list) {
> @@ -2786,14 +2785,14 @@ int btrfs_zoned_activate_one_bg(struct btrfs_space_info *space_info, bool do_fin
>  				spin_unlock(&bg->lock);
>  
>  				if (btrfs_zone_activate(bg)) {
> -					up_read(&space_info->groups_sem);
> +					percpu_up_read(&space_info->groups_sem);
>  					return 1;
>  				}
>  
>  				need_finish = true;
>  			}
>  		}
> -		up_read(&space_info->groups_sem);
> +		percpu_up_read(&space_info->groups_sem);
>  
>  		if (!do_finish || !need_finish)
>  			break;
> -- 
> 2.39.5
> 

