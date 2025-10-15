Return-Path: <linux-btrfs+bounces-17810-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D34ABDC928
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 07:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A5E1897BF7
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 05:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087EA2BE64F;
	Wed, 15 Oct 2025 05:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="PE1cCRi/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TIpXC2Dt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E092841C72
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 05:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760504762; cv=none; b=NOfA7QjIrXtJKDU6TGxtCOKXLhB46tqZhnMApOKKsrcAMRc3J9XOxEIUDyuCgonpn6/p/qAkKVL8ThEbTAuB+v7uPZmbYZNJVKZSOnOJuh2OcwpEQ3txOzoGudMghinAEfdgRBtsPsviF5dXhUhO3xqT4Rh8O0rh+El2iw7ehFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760504762; c=relaxed/simple;
	bh=uiYzEXWoozP+C8DgeRLWOZdnciGTaupkHtnRiZ7+S04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwYsfX2c1Y05zAwSMNU4NrbFN3xvh2VmCo8zgNnOg+APtKVJvlGiPHmISc6svCBIyoUuNG2eNvR8VNTQY2nMuUZepdVqHrKiyUdZB5IKHdT4xM4c2VmsGG68OGsrndwBByrf+qRq6oc3OG1UcVuSSF4vli4jnpqVWdJqiiw+H5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=PE1cCRi/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TIpXC2Dt; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 012DF1400111;
	Wed, 15 Oct 2025 01:05:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 15 Oct 2025 01:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1760504757; x=1760591157; bh=Cvtf/Fg391
	BQSLOP6m3AfYAfDAWyuL4Ukx3o8NeQO+U=; b=PE1cCRi/+wiBAZqV97izfTJog9
	9qbFqaWIqTdhLe7K7f+rzEC8ajeiNZsyYkx+hlMFFm9BVqGCg8LBnSehzur4sijQ
	Mol6XiO+GaGI9q/M7JNTnO0GH6tV3dJrXLUCJwlBsBmc90Nu74D6W+ADpwUqFphc
	2yO9FzzmWRQn8pJjbED9xuF4vhYWQhNII8TzFhPZeZdTSrqbEC4qtaoa/hioDzQx
	Mv2v/Z3+CC6pW401F82SaGboi1PgjuNODMPOhG7Kuwk3q6tzXZaD4tHrcNyi13u3
	Oyc/ulQuz7wdEhI2Wu6LL6KoJySt4miXQxBz/KRCHeFoX7j9z4zHJR66PZBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760504757; x=1760591157; bh=Cvtf/Fg391BQSLOP6m3AfYAfDAWyuL4Ukx3
	o8NeQO+U=; b=TIpXC2DtokAkwjbSGatFHb0mkrXTvVYS+3xPC+fONO4bp8kxXb3
	mtzUlH9VgEJtwfiSCNIt9svQPwTD/MBeAop6KdKljK9FK1S8q0UwXmB9Y1OL2t/3
	KH4Oz0p9mRSnsDPC27wuJLLGjDS1P/8pOVg4QcFdxdmFIvqZZ3G0YXyFObhXCqpZ
	udp98gytLN5ZKn9DVhvkWRRGqt/7GHseTx4KLSGyX9wIRpGZgthnSw8ZXOpbGqQf
	gZfHsUYcKUsOlaw8WAanSdyPOhTWVIcVNKIiBfgDt+NlMkI6ED/NTprhXD9gz0p6
	NSsAocXKxajVLT5VQln3X1wqKv7IR8YQfbA==
X-ME-Sender: <xms:tSvvaJ_h_vlnnBNTdbhbqHnh1qI0oquQpYqC88NZO5zA_m0hmRAkyw>
    <xme:tSvvaDuKYimt-HEWt9vTHegzbG5kUivGrvvxxGeKinuZcgDUHuJ-nSTFo6nELlHJn
    uPUMh6N-WnOrWPhKMB9K2M2zsVqU9Bz-iab_BNZuKUW8CegGR713njm>
X-ME-Received: <xmr:tSvvaErT0vN4Jqj6VoVQ9e999aAnWIeptbodThQ5YpWYpvNwDha3khzr-4t2WK5jjkXJIbfdQQHVqehdP6ClUKoDpwE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:tSvvaIm7qlYJKWUT6sUygmCOoA_bku2dVnKXf68vg7_NUrkD9cg2_Q>
    <xmx:tSvvaAxtQeVMu8fML60GdhgDpzw8XLdFIgz8pMm5qtbuzbeWRwXg9g>
    <xmx:tSvvaIkhfPEcSLwX7YJUtqFN-04cqgYOoWoFB5EAM9aGh2U6kfLesA>
    <xmx:tSvvaBcQ3Ou-MaHg3qFe5yDaMVWAlss0bRgiimePNW-CKe9PkKKhpQ>
    <xmx:tSvvaLRUbjiTtUWhvyihK8kdU5NCH_8haCu5dSHNKHUBM7mX5H8gVOM3>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 01:05:57 -0400 (EDT)
Date: Tue, 14 Oct 2025 22:05:37 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 17/17] btrfs: add stripe removal pending flag
Message-ID: <20251015050537.GJ1702774@zen.localdomain>
References: <20251009112814.13942-1-mark@harmstone.com>
 <20251009112814.13942-18-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009112814.13942-18-mark@harmstone.com>

On Thu, Oct 09, 2025 at 12:28:12PM +0100, Mark Harmstone wrote:
> If the filesystem is unmounted while the async discard of a fully remapped
> block group is in progress, its unused device extents will never be freed.
> 
> To counter this, add a new flag BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING
> to say that this has been interrupted. Set it in the transaction in which
> the last identity remap has been removed, clear it when we remove the
> device extents, and if we encounter it on mount queue that block group
> up for discard.

I don't see how this is special for remapped block groups.

in read_one_block_group() for empty block groups we queue them for async
discard unconditionally. There is a comment to this effect in discard.c
about crashes and mounts behaving the same.

And either way, if we go down at any point before we remove the bg, then
we will be re-discarding everything we already discarded (possibly the
whole thing) so this is optimistic anyway, right?

I don't think the benefit of this is worth the special case compared to
normal unused bgs, and I don't think it makes sense to "take advantage"
of this format change opportunity to also add the persisted "needs
discard" bit for all discard.

A persisted "discard state" on the extents would actually be
interesting, I think, but I don't think that is in scope or even
necessarily a good idea.

Thanks,
Boris

> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> ---
>  fs/btrfs/block-group.c          | 35 ++++++++++++++++++++++++++++++++-
>  fs/btrfs/free-space-cache.c     |  5 +++++
>  fs/btrfs/relocation.c           | 18 +++++++++++++++++
>  include/uapi/linux/btrfs_tree.h |  1 +
>  4 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index a7dfa6c95223..851d76ce8ec9 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2530,6 +2530,16 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>  		inc_block_group_ro(cache, 1);
>  	}
>  
> +	if (cache->flags & BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING) {
> +		btrfs_get_block_group(cache);
> +		spin_lock(&info->unused_bgs_lock);
> +		list_add_tail(&cache->bg_list, &info->fully_remapped_bgs);
> +		spin_unlock(&info->unused_bgs_lock);
> +
> +		if (btrfs_test_opt(info, DISCARD_ASYNC))
> +			btrfs_discard_queue_work(&info->discard_ctl, cache);
> +	}
> +
>  	return 0;
>  error:
>  	btrfs_put_block_group(cache);
> @@ -4828,6 +4838,29 @@ void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
>  
>  	spin_unlock(&fs_info->unused_bgs_lock);
>  
> -	if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
> +	if (btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
> +		bool bg_already_dirty = true;
> +
> +		spin_lock(&bg->lock);
> +		bg->flags |= BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING;
> +		spin_unlock(&bg->lock);
> +
> +		spin_lock(&trans->transaction->dirty_bgs_lock);
> +		if (list_empty(&bg->dirty_list)) {
> +			list_add_tail(&bg->dirty_list,
> +				      &trans->transaction->dirty_bgs);
> +			bg_already_dirty = false;
> +			btrfs_get_block_group(bg);
> +		}
> +		spin_unlock(&trans->transaction->dirty_bgs_lock);
> +
> +		/*
> +		 * Modified block groups are accounted for in
> +		 * the delayed_refs_rsv.
> +		 */
> +		if (!bg_already_dirty)
> +			btrfs_inc_delayed_refs_rsv_bg_updates(trans->fs_info);
> +
>  		btrfs_discard_queue_work(&fs_info->discard_ctl, bg);
> +	}
>  }
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 56f27487b632..813b82294341 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -3065,6 +3065,7 @@ bool btrfs_is_free_space_trimmed(struct btrfs_block_group *block_group)
>  	bool ret = true;
>  
>  	if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
> +	    !(block_group->flags & BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING) &&
>  	    block_group->remap_bytes == 0 &&
>  	    block_group->identity_remap_count == 0) {
>  		return true;
> @@ -3845,6 +3846,9 @@ void btrfs_trim_fully_remapped_block_group(struct btrfs_block_group *bg)
>  	struct btrfs_trans_handle *trans;
>  	struct btrfs_chunk_map *map;
>  
> +	if (!(bg->flags & BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING))
> +		goto skip_discard;
> +
>  	while (bg->discard_cursor < end) {
>  		u64 trimmed;
>  
> @@ -3897,6 +3901,7 @@ void btrfs_trim_fully_remapped_block_group(struct btrfs_block_group *bg)
>  
>  	btrfs_free_chunk_map(map);
>  
> +skip_discard:
>  	if (bg->used == 0) {
>  		spin_lock(&fs_info->unused_bgs_lock);
>  		list_move_tail(&bg->bg_list, &fs_info->unused_bgs);
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 7bad8d65d145..a179e4a8e960 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4733,6 +4733,7 @@ int btrfs_last_identity_remap_gone(struct btrfs_trans_handle *trans,
>  				   struct btrfs_block_group *bg)
>  {
>  	int ret;
> +	bool bg_already_dirty = true;
>  	BTRFS_PATH_AUTO_FREE(path);
>  
>  	ret = btrfs_remove_dev_extents(trans, chunk);
> @@ -4757,6 +4758,23 @@ int btrfs_last_identity_remap_gone(struct btrfs_trans_handle *trans,
>  
>  	btrfs_remove_bg_from_sinfo(bg);
>  
> +	spin_lock(&bg->lock);
> +	bg->flags &= ~BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING;
> +	spin_unlock(&bg->lock);
> +
> +	spin_lock(&trans->transaction->dirty_bgs_lock);
> +	if (list_empty(&bg->dirty_list)) {
> +		list_add_tail(&bg->dirty_list,
> +			      &trans->transaction->dirty_bgs);
> +		bg_already_dirty = false;
> +		btrfs_get_block_group(bg);
> +	}
> +	spin_unlock(&trans->transaction->dirty_bgs_lock);
> +
> +	/* Modified block groups are accounted for in the delayed_refs_rsv. */
> +	if (!bg_already_dirty)
> +		btrfs_inc_delayed_refs_rsv_bg_updates(trans->fs_info);
> +
>  	path = btrfs_alloc_path();
>  	if (!path)
>  		return -ENOMEM;
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> index 89bcb80081a6..36a7d1a3cbe3 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -1173,6 +1173,7 @@ struct btrfs_dev_replace_item {
>  #define BTRFS_BLOCK_GROUP_RAID1C4       (1ULL << 10)
>  #define BTRFS_BLOCK_GROUP_REMAPPED      (1ULL << 11)
>  #define BTRFS_BLOCK_GROUP_REMAP         (1ULL << 12)
> +#define BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING	(1ULL << 13)
>  #define BTRFS_BLOCK_GROUP_RESERVED	(BTRFS_AVAIL_ALLOC_BIT_SINGLE | \
>  					 BTRFS_SPACE_INFO_GLOBAL_RSV)
>  
> -- 
> 2.49.1
> 

