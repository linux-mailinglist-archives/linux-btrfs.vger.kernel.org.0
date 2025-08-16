Return-Path: <linux-btrfs+bounces-16110-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D7CB28979
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 02:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF22B1D04EBC
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 00:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B415D2F84F;
	Sat, 16 Aug 2025 00:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="RFclxy57";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WrSkBIiM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC7C33EC
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Aug 2025 00:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755305733; cv=none; b=Fp4BDn4eP5iC1R/8BUs2EFx+v/mdWJWRYQYrP9STjGLfgD6VrcTrHT0n4WICKbRbsUhedmDCeP9aePUv+jI+CW6n6wPobygl16R9uv6SwJ2r5d+sN2uusjZ6TaDKWPB7Folf1cb0EUUvb6aa+nx0uXcdXU10YKfW0QZneLbMNps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755305733; c=relaxed/simple;
	bh=2mo/xs658cfCHhjczWZIViXGFZXjAmiOI9p2HOJ8Tas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jV1dUNMXLmSjN9cczS60zpik9QeBHU5dcOo0gu4FaAh/2vRJpzIC4H8GUQ2swFpv/2U7Rd5xaW4r24H9q0XZNIPgiNquljwoVRdXjP+/kjLd7XHCXG6grmkwVZmH8vZKwH1qsPaBsfi9UY+dradOMObLEWEB+w2Vlv/f7WK3Z0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=RFclxy57; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WrSkBIiM; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id C86D71D0025C;
	Fri, 15 Aug 2025 20:55:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 15 Aug 2025 20:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1755305729; x=1755392129; bh=OcCUs4n4re
	hqhepYXPmsORRu5cqYcv6Fbl/bCDNpS4w=; b=RFclxy57Y5zH+JdWc1UBN+z0EX
	8ttkNoi6VbuvjFGMhX17FnOraosLkCJM/z9hTGHXv1m8fHssFbqHLbA1qEUkygzN
	xq1lOxpI+inFk4JshK0V+1DTskB+F5zTFZbVIGV0xdKXH1Wfz0AGufwCAWSqfpk8
	ORMLJKaC/m/5JqJLKf8HpVZ3tojQLm+ok7598QTSncEB3Q+I8eESgzbEYznC6Hq/
	zbGBESty0b29JbXMahVzxtddoM7x+top3w5Xjc1guYY48FMo9UXYWn7/M9PUAfLW
	do0yFOas1mYJrjqnF4N0wIGlXC4my6Lq5Do0kUPsCTBQZYiri5uSSghzjzTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755305729; x=1755392129; bh=OcCUs4n4rehqhepYXPmsORRu5cqYcv6Fbl/
	bCDNpS4w=; b=WrSkBIiML5XUhHXiS8fckkvDaFz4ooA7T2sPzAzSWqE004j84Zc
	l0x8LrOwoq9iQpguEzMPsXFyHrfXS3QwnvCthOk3l/HgP0mp2Dw3RB8GPvv9Rspw
	2+b7J6F7WDJe0Bc2WeboI0HEC/WVltra06O3FoBypuL1TBAq9r8jxyaJkDQjAlol
	lwhDhew3qXbc8Z/KNqzRqOdVgmkz4xHeCwcfUvCOp03DViW5vVyNMHycVLc3cqY2
	1SDik0SeJVxppWzldoF2vDMPiVNZTS+EeOjIO2xsZfSxTnUFoMqpCr9ekPf6Wv0G
	yMq4pzba+fChBL0NOq+e/8ufR011W0yrgow==
X-ME-Sender: <xms:AdefaOo6TTRKEQxj6bksEOEMNd6AnTSIcUKpMX3P_lygkv2A2vwDag>
    <xme:AdefaM1H0ReQLHu4ibOnIG_fKu-L6vz3j2NAqWMeoyfRuUgCIHybxoKy0TQnPY0t-
    0sfyfLUZOV64T7jDtI>
X-ME-Received: <xmr:AdefaFAJdElN1AT04gXb8dSh5DJtFQoSAydscFuguTe9mskA1gWrZzKqTVmq8qFYcrSUmgBf4e3Tn556WcT2gW7Ydpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:AdefaMdUTGZKO7WhrDrSJQJo_txuk252bkfdq0mXvTgrZ0Dyz-y9EA>
    <xmx:AdefaCjOtnmpNSpc7LNL0xzu7CmOzBqUk3TuFnvME_I7GDPrK-q8Ng>
    <xmx:AdefaMppgqhA3QjEcCjsXeP13nhLs0JkH1HrBVPB8cVr9MUPRevskQ>
    <xmx:AdefaKF-nE5PvQYvu8QM2pkqHPGRiyBJcBLoftGj-95A-6ZHRa_Hbw>
    <xmx:AdefaCPRCMD9gami165Z-9ks_66FhjlJC2fUVqrIxXJRHgWPg6TlXBpf>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 20:55:28 -0400 (EDT)
Date: Fri, 15 Aug 2025 17:56:09 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 15/16] btrfs: add fully_remapped_bgs list
Message-ID: <20250816005609.GG3042054@zen.localdomain>
References: <20250813143509.31073-1-mark@harmstone.com>
 <20250813143509.31073-16-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813143509.31073-16-mark@harmstone.com>

On Wed, Aug 13, 2025 at 03:34:57PM +0100, Mark Harmstone wrote:
> Add a fully_remapped_bgs list to struct btrfs_transaction, which holds
> block groups which have just had their last identity remap removed.
> 
> In btrfs_finish_extent_commit() we can then discard their full dev
> extents, as we're also setting their num_stripes to 0. Finally if the BG
> is now empty, i.e. there's neither identity remaps nor normal remaps,
> add it to the unused_bgs list to be taken care of there.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> ---
>  fs/btrfs/block-group.c | 26 ++++++++++++++++++++++++++
>  fs/btrfs/block-group.h |  2 ++
>  fs/btrfs/extent-tree.c | 37 ++++++++++++++++++++++++++++++++++++-
>  fs/btrfs/relocation.c  |  2 ++
>  fs/btrfs/transaction.c |  1 +
>  fs/btrfs/transaction.h |  1 +
>  6 files changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 7a0524138235..7f8707dfd62c 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1803,6 +1803,14 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
>  	struct btrfs_fs_info *fs_info = bg->fs_info;
>  
>  	spin_lock(&fs_info->unused_bgs_lock);
> +
> +	/* Leave fully remapped block groups on the fully_remapped_bgs list. */
> +	if (bg->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
> +	    bg->identity_remap_count == 0) {
> +		spin_unlock(&fs_info->unused_bgs_lock);
> +		return;
> +	}
> +
>  	if (list_empty(&bg->bg_list)) {
>  		btrfs_get_block_group(bg);
>  		trace_btrfs_add_unused_block_group(bg);
> @@ -4792,3 +4800,21 @@ bool btrfs_block_group_should_use_size_class(const struct btrfs_block_group *bg)
>  		return false;
>  	return true;
>  }
> +
> +void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
> +				  struct btrfs_trans_handle *trans)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +
> +	spin_lock(&fs_info->unused_bgs_lock);
> +
> +	if (!list_empty(&bg->bg_list))
> +		list_del(&bg->bg_list);
> +	else
> +		btrfs_get_block_group(bg);
> +
> +	list_add_tail(&bg->bg_list, &trans->transaction->fully_remapped_bgs);
> +
> +	spin_unlock(&fs_info->unused_bgs_lock);
> +
> +}

Why does the fully remapped bg list takeover from other lists rather
than use the link function?

What protection is in place to ensure that we never mark it fully
remapped while it is on the new_bgs list (as with the unused list)?

I suspect such a block group won't ever be reclaimed even with explicit
balances, but it is important to check and be sure.

If this *is* strictly necessary, I would like to see an extension to
btrfs_link_bg_list that can handle the list_move_tail variant.

Another option is to generalize this one together with mark_unused()
and just check the NEW flag here.

> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 0433b0127ed8..025ea2c6f8a8 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -408,5 +408,7 @@ int btrfs_use_block_group_size_class(struct btrfs_block_group *bg,
>  				     enum btrfs_block_group_size_class size_class,
>  				     bool force_wrong_size_class);
>  bool btrfs_block_group_should_use_size_class(const struct btrfs_block_group *bg);
> +void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
> +				  struct btrfs_trans_handle *trans);
>  
>  #endif /* BTRFS_BLOCK_GROUP_H */
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index b02e99b41553..157a032df128 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2853,7 +2853,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
>  {
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  	struct btrfs_block_group *block_group, *tmp;
> -	struct list_head *deleted_bgs;
> +	struct list_head *deleted_bgs, *fully_remapped_bgs;
>  	struct extent_io_tree *unpin = &trans->transaction->pinned_extents;
>  	struct extent_state *cached_state = NULL;
>  	u64 start;
> @@ -2951,6 +2951,41 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
>  		}
>  	}
>  

1. This will block the next transaction waiting on TRANS_STATE_COMPLETED

2. This is not compatible with the spirit and purpose of async discard,
which is our default and best discard mode.

3. This doesn't check discard mode at all, it just defaults to
DISCARD_SYNC style behavior, so it doesn't respect NODISCARD either.

> +	fully_remapped_bgs = &trans->transaction->fully_remapped_bgs;
> +	list_for_each_entry_safe(block_group, tmp, fully_remapped_bgs, bg_list) {
> +		struct btrfs_chunk_map *map;
> +
> +		if (!TRANS_ABORTED(trans))
> +			ret = btrfs_discard_extent(fs_info, block_group->start,
> +						   block_group->length, NULL,
> +						   false);
> +
> +		map = btrfs_get_chunk_map(fs_info, block_group->start, 1);
> +		if (IS_ERR(map))
> +			return PTR_ERR(map);
> +
> +		/*
> +		 * Set num_stripes to 0, so that btrfs_remove_dev_extents()
> +		 * won't run a second time.
> +		 */
> +		map->num_stripes = 0;
> +
> +		btrfs_free_chunk_map(map);
> +
> +		if (block_group->used == 0 && block_group->remap_bytes == 0) {
> +			spin_lock(&fs_info->unused_bgs_lock);
> +			list_move_tail(&block_group->bg_list,
> +				       &fs_info->unused_bgs);
> +			spin_unlock(&fs_info->unused_bgs_lock);

Please use the helpers, it's important for ensuring correct ref counting
in the long run. I also think that the previous patch had some
discussion for more standardized integration with unused_bgs so I sort
of hope this code goes away entirely.

> +		} else {
> +			spin_lock(&fs_info->unused_bgs_lock);
> +			list_del_init(&block_group->bg_list);
> +			spin_unlock(&fs_info->unused_bgs_lock);
> +
> +			btrfs_put_block_group(block_group);
> +		}
> +	}
> +
>  	return unpin_error;
>  }
>  
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 84ff59866e96..0745a3d1c867 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4819,6 +4819,8 @@ static int last_identity_remap_gone(struct btrfs_trans_handle *trans,
>  	if (ret)
>  		return ret;
>  
> +	btrfs_mark_bg_fully_remapped(bg, trans);
> +
>  	return 0;
>  }
>  
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 64b9c427af6a..7c308d33e767 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -381,6 +381,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
>  	mutex_init(&cur_trans->cache_write_mutex);
>  	spin_lock_init(&cur_trans->dirty_bgs_lock);
>  	INIT_LIST_HEAD(&cur_trans->deleted_bgs);
> +	INIT_LIST_HEAD(&cur_trans->fully_remapped_bgs);
>  	spin_lock_init(&cur_trans->dropped_roots_lock);
>  	list_add_tail(&cur_trans->list, &fs_info->trans_list);
>  	btrfs_extent_io_tree_init(fs_info, &cur_trans->dirty_pages,
> diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
> index 9f7c777af635..b362915288b5 100644
> --- a/fs/btrfs/transaction.h
> +++ b/fs/btrfs/transaction.h
> @@ -109,6 +109,7 @@ struct btrfs_transaction {
>  	spinlock_t dirty_bgs_lock;
>  	/* Protected by spin lock fs_info->unused_bgs_lock. */
>  	struct list_head deleted_bgs;
> +	struct list_head fully_remapped_bgs;
>  	spinlock_t dropped_roots_lock;
>  	struct btrfs_delayed_ref_root delayed_refs;
>  	struct btrfs_fs_info *fs_info;
> -- 
> 2.49.1
> 

