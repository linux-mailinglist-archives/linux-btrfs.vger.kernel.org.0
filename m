Return-Path: <linux-btrfs+bounces-1737-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFF383B27B
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 20:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C50A287338
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 19:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C75133402;
	Wed, 24 Jan 2024 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="tC46QioO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pD57/1/8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB1112AACC
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125717; cv=none; b=MSIspYRo3/Tr+RhIscs7WRAoXcyk594pRmFT298jKnxO4E7o26zlyKMGGJi14FKSv6+m6dfoiN0iKVpfvQW9eDjfFHjZQkoVI8QpCx3K+iDQku7EULvYXWWgd18wBaKSfDEFYg+bfUhhOg4qL+YoW323gUdDrdmX7caBfjy3Tuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125717; c=relaxed/simple;
	bh=TwkyYJm7+T7TLQdbBRyMGFLzf/loq2SxRUx1pc55JFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2Iv7Vmd6r8TUzqV1fJ6VwJ7mtrBIfvgvZh2ZbSVnsFfSbp0oCXz7txElnGj3XRuuQroM9plMtb9skRkr91Zrm2FFqMvh+kx+56aD3sysTwO4h/8AsfP4Aon+x0A2m/ymfwtZxU4QqZ/OY3WtNLA+iBwAot+y5PBe7LLqYS/rn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=tC46QioO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pD57/1/8; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id C71B05C012E;
	Wed, 24 Jan 2024 14:48:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 24 Jan 2024 14:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1706125713; x=1706212113; bh=QMEN3nxKgT
	RelQnwYo24bMjjl8hbBpprR3ErP1ZfQgE=; b=tC46QioOOXI6YOz09OWDHWJPoA
	PuCTzHXcDH6mn4Zm1upgRCJbEuyXam53fO6wVBPzenSTc5usPHUQvUfNgrrPzwtm
	tKKWo28AtFEvbsG0iLgo1DNYdxWhYNfGUXFGq6HL83V7azNin9jevqQRH/0ajdb6
	8uOauVME7+WSpPkWbUnVMYWxR40EGsxks4K3ZmfITz0An/wKq5HE9wXckOX3RWuo
	d8OmhTTdVGZE6RfDCy6T4QXiqOENi/t/vCkDcCreiEVTsVm/vvEOSk0d0UkrE/6H
	nkHLQ6gIF+lH+aXCN3IptRSMfc+bBAwRRsfivJIB3lh4Zk34eHh+6xGQjhSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706125713; x=1706212113; bh=QMEN3nxKgTRelQnwYo24bMjjl8hb
	BpprR3ErP1ZfQgE=; b=pD57/1/8LK2r7j7CAmddWN6pmt67zUUfDj0Xkx0hCFj+
	AUwjtY3BF8UZJNPthYdtH6yxQYH5sDJmKt4ziXtjbn3PnTc+6qHTvJTvzgmzDmvH
	9HwNeXhy59qDAWI30mzBp4wdUXAnrFf0Rq12dRO6BRUVG7vE9g8CkC8GMEYSDvf5
	ukM4SKmoneFSvHcVDEL6qx07mGv8NDs2f1qTqf3a7nE11zmWSNRlIMC2yW8LurqB
	X2jwnDv7vJ3bgljn2ZMtKBaU2TTxqMHbbasLF07lbV7rH3hDg0KtgonLzDT7388J
	Jl0NRqWOJtMdejbzTB96rMJQgraBnbcdYMRUUXtJHA==
X-ME-Sender: <xms:kWmxZQAlNehtVQ3sJoGznhBHGfJE1SYVN56u6OArfxUwIHfoaBMqfg>
    <xme:kWmxZSjd1AEgaecqis5j03Q_23VuT3S0CFDuf0NmCmHGeQhWpMIDp10RvQhJ1_KGi
    52q40JNJ9kUnlnOQPo>
X-ME-Received: <xmr:kWmxZTlylI4l69KuDMP9WyoIp7SCuU0Mrqg1q1sUMMJY8Brdq0vzTo12sPF8gFqD-_yHzsB6BC1CqMYUNO6c1Jgdplw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeluddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:kWmxZWxEQxMFuCAHNrXba541D0fjxL3B9_bR35lJDu4-rBEobuNHlg>
    <xmx:kWmxZVTu8JpfGkbaQHEXaLa-MQ5brwMCo3P4wrmo13rzOVBn_EJPeg>
    <xmx:kWmxZRaOC31lEqHmBiFU-TySsPiHAzirz7sh1rlfGJ15oITGlHkjyA>
    <xmx:kWmxZULxHVZF0tH4RubPFEBGKvN2HsU89Yy4E8IGb18_maKfVO12Dw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jan 2024 14:48:33 -0500 (EST)
Date: Wed, 24 Jan 2024 11:49:34 -0800
From: Boris Burkov <boris@bur.io>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 09/52] btrfs: add infrastructure for safe em freeing
Message-ID: <20240124194934.GB1789919@zen.localdomain>
References: <cover.1706116485.git.josef@toxicpanda.com>
 <6cf44f7860e94de68df242e69f4c5250bd061cff.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cf44f7860e94de68df242e69f4c5250bd061cff.1706116485.git.josef@toxicpanda.com>

On Wed, Jan 24, 2024 at 12:18:31PM -0500, Josef Bacik wrote:
> When we add fscrypt support we're going to have fscrypt objects hanging
> off of extent_maps.  This includes a block key, which if we're the last
> one freeing the key we may have to unregister it from the block layer.
> This requires taking a semaphore in the block layer, which means we
> can't free em's under the extent map tree lock.
> 
> Thankfully we only do this in two places, one where we're dropping a
> range of extent maps, and when we're freeing logged extents.  Add a
> free_extent_map_safe() which will add the em to a list in the em_tree if
> we free'd the object.  Currently this is unconditional but will be
> changed to conditional on the fscrypt object we will add in a later
> patch.
> 
> To process these delayed objects add a free_pending_extent_maps() that
> is called after the lock has been dropped on the em_tree.  This will
> process the extent maps on the freed list and do the appropriate freeing
> work in a safe manner.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/extent_map.c | 76 +++++++++++++++++++++++++++++++++++++++++--
>  fs/btrfs/extent_map.h | 10 ++++++
>  fs/btrfs/tree-log.c   |  6 ++--
>  3 files changed, 87 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index b61099bf97a8..f8705103819c 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -35,7 +35,9 @@ void __cold extent_map_exit(void)
>  void extent_map_tree_init(struct extent_map_tree *tree)
>  {
>  	tree->map = RB_ROOT_CACHED;
> +	tree->flags = 0;
>  	INIT_LIST_HEAD(&tree->modified_extents);
> +	INIT_LIST_HEAD(&tree->freed_extents);
>  	rwlock_init(&tree->lock);
>  }
>  
> @@ -52,9 +54,15 @@ struct extent_map *alloc_extent_map(void)
>  	RB_CLEAR_NODE(&em->rb_node);
>  	refcount_set(&em->refs, 1);
>  	INIT_LIST_HEAD(&em->list);
> +	INIT_LIST_HEAD(&em->free_list);
>  	return em;
>  }
>  
> +static void __free_extent_map(struct extent_map *em)
> +{
> +	kmem_cache_free(extent_map_cache, em);
> +}
> +
>  /*
>   * Drop the reference out on @em by one and free the structure if the reference
>   * count hits zero.
> @@ -66,10 +74,69 @@ void free_extent_map(struct extent_map *em)
>  	if (refcount_dec_and_test(&em->refs)) {
>  		WARN_ON(extent_map_in_tree(em));
>  		WARN_ON(!list_empty(&em->list));
> -		kmem_cache_free(extent_map_cache, em);
> +		__free_extent_map(em);
>  	}
>  }
>  
> +/*
> + * Drop a ref for the extent map in the given tree.
> + *
> + * @tree:	tree that the em is a part of.
> + * @em:		the em to drop the reference to.
> + *
> + * Drop the reference count on @em by one, if the reference count hits 0 and
> + * there is an object on the em that can't be safely freed in the current
> + * context (if we are holding the extent_map_tree->lock for example), then add
> + * it to the freed_extents list on the extent_map_tree for later processing.
> + *
> + * This must be followed by a free_pending_extent_maps() to clear the pending
> + * frees.
> + */
> +void free_extent_map_safe(struct extent_map_tree *tree,
> +			  struct extent_map *em)
> +{
> +	lockdep_assert_held_write(&tree->lock);
> +
> +	if (!em)
> +		return;
> +
> +	if (refcount_dec_and_test(&em->refs)) {
> +		WARN_ON(extent_map_in_tree(em));
> +		WARN_ON(!list_empty(&em->list));

I'm pretty convinced that the refcount properly protects the rb_node
path as well, but I think a WARN/ASSERT on that wouldn't hurt either,
now that we are adding this deferred unlocked freeing.

> +		list_add_tail(&em->free_list, &tree->freed_extents);
> +		set_bit(EXTENT_MAP_TREE_PENDING_FREES, &tree->flags);
> +	}
> +}
> +
> +/*
> + * Free the em objects that exist on the em tree
> + *
> + * @tree:	the tree to free the objects from.
> + *
> + * If there are any objects on the em->freed_extents list go ahead and free them
> + * here in a safe way.  This is to be coupled with any uses of
> + * free_extent_map_safe().
> + */
> +void free_pending_extent_maps(struct extent_map_tree *tree)
> +{
> +	struct extent_map *em;
> +
> +	/* Avoid taking the write lock if we don't have any pending frees. */
> +	if (!test_and_clear_bit(EXTENT_MAP_TREE_PENDING_FREES, &tree->flags))
> +		return;
> +
> +	write_lock(&tree->lock);
> +	while ((em = list_first_entry_or_null(&tree->freed_extents,
> +					      struct extent_map, free_list))) {
> +		list_del_init(&em->free_list);
> +		write_unlock(&tree->lock);
> +		__free_extent_map(em);
> +		cond_resched();
> +		write_lock(&tree->lock);
> +	}
> +	write_unlock(&tree->lock);
> +}
> +
>  /* Do the math around the end of an extent, handling wrapping. */
>  static u64 range_end(u64 start, u64 len)
>  {
> @@ -654,10 +721,12 @@ static void drop_all_extent_maps_fast(struct extent_map_tree *tree)
>  		em = rb_entry(node, struct extent_map, rb_node);
>  		em->flags &= ~(EXTENT_FLAG_PINNED | EXTENT_FLAG_LOGGING);
>  		remove_extent_mapping(tree, em);
> -		free_extent_map(em);
> +		free_extent_map_safe(tree, em);
>  		cond_resched_rwlock_write(&tree->lock);
>  	}
>  	write_unlock(&tree->lock);
> +
> +	free_pending_extent_maps(tree);
>  }
>  
>  /*
> @@ -875,13 +944,14 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
>  		free_extent_map(em);
>  next:
>  		/* Once for us (for our lookup reference). */
> -		free_extent_map(em);
> +		free_extent_map_safe(em_tree, em);
>  
>  		em = next_em;
>  	}
>  
>  	write_unlock(&em_tree->lock);
>  
> +	free_pending_extent_maps(em_tree);
>  	free_extent_map(split);
>  	free_extent_map(split2);
>  }
> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> index e380fc08bbe4..d31f2a03670e 100644
> --- a/fs/btrfs/extent_map.h
> +++ b/fs/btrfs/extent_map.h
> @@ -55,11 +55,18 @@ struct extent_map {
>  	u32 flags;
>  	refcount_t refs;
>  	struct list_head list;
> +	struct list_head free_list;
> +};
> +
> +enum extent_map_flags {
> +	EXTENT_MAP_TREE_PENDING_FREES,
>  };
>  
>  struct extent_map_tree {
>  	struct rb_root_cached map;
> +	unsigned long flags;
>  	struct list_head modified_extents;
> +	struct list_head freed_extents;
>  	rwlock_t lock;
>  };
>  
> @@ -122,6 +129,9 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
>  
>  struct extent_map *alloc_extent_map(void);
>  void free_extent_map(struct extent_map *em);
> +void free_extent_map_safe(struct extent_map_tree *tree,
> +			  struct extent_map *em);
> +void free_pending_extent_maps(struct extent_map_tree *tree);
>  int __init extent_map_init(void);
>  void __cold extent_map_exit(void);
>  int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen);
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 331fc7429952..916e54b91ecc 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -4884,7 +4884,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
>  		 */
>  		if (ret) {
>  			clear_em_logging(tree, em);
> -			free_extent_map(em);
> +			free_extent_map_safe(tree, em);
>  			continue;
>  		}
>  
> @@ -4893,11 +4893,13 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
>  		ret = log_one_extent(trans, inode, em, path, ctx);
>  		write_lock(&tree->lock);
>  		clear_em_logging(tree, em);
> -		free_extent_map(em);
> +		free_extent_map_safe(tree, em);
>  	}
>  	WARN_ON(!list_empty(&extents));
>  	write_unlock(&tree->lock);
>  
> +	free_pending_extent_maps(tree);
> +
>  	if (!ret)
>  		ret = btrfs_log_prealloc_extents(trans, inode, path);
>  	if (ret)
> -- 
> 2.43.0
> 

