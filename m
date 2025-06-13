Return-Path: <linux-btrfs+bounces-14657-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AEBAD984B
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Jun 2025 00:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49DD18958D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 22:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D9628E59C;
	Fri, 13 Jun 2025 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="FVu6NIfY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JrB80JNC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC1A223DD1
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Jun 2025 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749854381; cv=none; b=O9PN5G0qkDedA2TTvp959rYlt2OSs2zfYa6vy9hQVv9WGl40UDvracEJltAcHIS/U5VZg/i5JSLhJ/xektTGvf6i3rIBGeIRy7O/ccB5Zx4Xb5NPhXr5JYa04jnsrO+mANDgGevk6/rPRJktwQrMWadmbkexudPrAzWq6ckVwx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749854381; c=relaxed/simple;
	bh=l0kotPJfUUbzp1GJI2MV8ZQ4YA5ky49VugWrnGcgm6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H08Db3PS9rn85pcWyZOr8eWzNZMgNEyVO66MLYOYOhEzHKOmDpu2XrLNKtT7NXlZ/xPTyt+MAQGYpsNmOmMUjjm3hNahpWX+lEJpiYfFgchu0ZUMtjeJP0ZfDRmswiQxfXUJmQevPW3Wx/Ywx9HnTFNVr5JZRHceK4hUT5SCDSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=FVu6NIfY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JrB80JNC; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id AF5871380361;
	Fri, 13 Jun 2025 18:39:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 13 Jun 2025 18:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1749854376; x=1749940776; bh=2+NA02465l
	i1u6ESgXU8xbGXz+skgmM4a9aN3LyRExw=; b=FVu6NIfYJ09QaoAyri3O4wUPoM
	8oR22m3z/sW58c17k347vh1SxyWAboh90c6pm+YZDCA6jr1IaLv4wMqORYoPSkID
	3NiWp45vBmixPWed/K0gizdWyjJ/cNPkMoR6vNLjosUYEUEQQLAA/LBo4c2t6Ezr
	a+dNkhQMugS3vP9+uIQjTfX6IoLBXcRgL6yzS5unDabAlgDjGPsmB1Rlyp9/nDRe
	jHE7nHGNyH6mYpCd7YTu3/T3GMZZcezjyjedsZ6vUsUxJj0EZgAhYs8mvP3wK+ln
	yPRMSdUTYuZkhSXfIvPbfNO650MsefjN+yqsFZ6kBleGmP/sEFfyc76iE9Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749854376; x=1749940776; bh=2+NA02465li1u6ESgXU8xbGXz+skgmM4a9a
	N3LyRExw=; b=JrB80JNCVrytbO5YaluMTlDvD/2PPhGy8kKH8JIWiCKJ0CwS+oX
	5Ii61VqDj8g4aM7auBeh3VxTmKdXf+nAtraMwMYe4itBwUolwl4zKCqTifUQjxX7
	D0Q0q2rOG2fFUAfOapOWaUuD48X81gD3PTmkx+I5ayEgHkjSJyRKBYrYtgUSVAq5
	t82alqO6kQL+BxRvhoIUAeGLmO9lnK80fVbsYQidSHJqOhw+gbBuxGTpmKYvg+Xc
	wxtOZSTqWiV7jdXMn07vVVLH/R5mfrkgy02TzXIjVYOeEFvAFqCJbTFOsS2c67Xc
	Kx8MzwyTSwsDnlMpJs9HS8ZxI9tJXn1Guow==
X-ME-Sender: <xms:qKhMaG9LzsAjHLelOS_9eog4hl4Dw7l9Uql8PeypXTFERjbOHJBDEw>
    <xme:qKhMaGv05YO_RbGf5zAJjXpiL2TysTZmM4xP7IqdkBkJT2Tg4J2UfNxManSh5Q6qB
    SpUoN-R3CEiUltZam4>
X-ME-Received: <xmr:qKhMaMCLhdYCj3BrOVLH-Piq-mkJH6Ho-Pjq2rcKUbNlERN1vGUpNY70MkTpCb4QVMi9UX3UD3_P_OWBfMBBGnfMZkM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduledujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfg
    uefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmrghhrghrmhhsthhonhgvsehfsgdrtghomhdprh
    gtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qKhMaOdsTuzxypw0o-AymHeJ6TvSvXHPXY7diXYnQjytloFfuQzdLA>
    <xmx:qKhMaLOscwZN7wIeRx9peGCBFW4xji0KKKaeukMdRToup57LMxBb7w>
    <xmx:qKhMaIn2U5x7lA0zo2sRvUxLkFkeuyNpZXbhjtwCPNhD12QvcwQdMA>
    <xmx:qKhMaNufKIZT0N0x573Nxm46M0qloxt0b8j-LOVTeM-gpuBvQIOcNw>
    <xmx:qKhMaOhl7vq-aV4RaTLiNRMBK1x1HaVF0PCpZHZh1h6-3uJtFK00K-J_>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jun 2025 18:39:36 -0400 (EDT)
Date: Fri, 13 Jun 2025 15:39:16 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/12] btrfs: don't add metadata items for the remap tree
 to the extent tree
Message-ID: <20250613223916.GE3621880@zen.localdomain>
References: <20250605162345.2561026-1-maharmstone@fb.com>
 <20250605162345.2561026-6-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605162345.2561026-6-maharmstone@fb.com>

On Thu, Jun 05, 2025 at 05:23:35PM +0100, Mark Harmstone wrote:
> There is the following potential problem with the remap tree and delayed refs:
> 
> * Remapped extent freed in a delayed ref, which removes an entry from the
>   remap tree
> * Remap tree now small enough to fit in a single leaf
> * Corruption as we now have a level-0 block with a level-1 metadata item
>   in the extent tree
> 
> One solution to this would be to rework the remap tree code so that it operates
> via delayed refs. But as we're hoping to remove cow-only metadata items in the
> future anyway, change things so that the remap tree doesn't have any entries in
> the extent tree. This also has the benefit of reducing write amplification.
> 
> We also make it so that the clear_cache mount option is a no-op, as with the
> extent tree v2, as the free-space tree can no longer be recreated from the
> extent tree.
> 
> Finally disable relocating the remap tree itself for the time being: rather
> than walking the extent tree, this will need to be changed so that the remap
> tree gets walked, and any nodes within the specified block groups get COWed.
> This code will also cover the future cases when we remove the metadata items
> for the SYSTEM block groups, i.e. the chunk and root trees.

Why not a separate trivial patch for disabling remap tree reloc?

> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>  fs/btrfs/disk-io.c     |   3 ++
>  fs/btrfs/extent-tree.c | 114 ++++++++++++++++++++++++-----------------
>  fs/btrfs/volumes.c     |   3 ++
>  3 files changed, 73 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 60cce96a9ec4..324116c3566c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3064,6 +3064,9 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
>  		if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
>  			btrfs_warn(fs_info,
>  				   "'clear_cache' option is ignored with extent tree v2");
> +		else if (btrfs_fs_incompat(fs_info, REMAP_TREE))
> +			btrfs_warn(fs_info,
> +				   "'clear_cache' option is ignored with remap tree");
>  		else
>  			rebuild_free_space_tree = true;
>  	} else if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 46d4963a8241..205692fc1c7e 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3106,6 +3106,24 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
>  	bool skinny_metadata = btrfs_fs_incompat(info, SKINNY_METADATA);
>  	u64 delayed_ref_root = href->owning_root;
>  
> +	is_data = owner_objectid >= BTRFS_FIRST_FREE_OBJECTID;
> +
> +	if (!is_data && node->ref_root == BTRFS_REMAP_TREE_OBJECTID) {

Are there cases where ref_root is REMAP_TREE but is_data is true? Or is
this redundant? If so, an assert might make more sense than including it
in the if condition.


Also, rather than special-casing / short-cutting a generic function or
metadata/data that is fully concerned with *extents*, I would come up
with a name for the "non extent tree metadata" concept and make that a
case at the metadata-freeing callsite.

> +		ret = add_to_free_space_tree(trans, bytenr, num_bytes);
> +		if (ret) {
> +			btrfs_abort_transaction(trans, ret);
> +			return ret;
> +		}
> +
> +		ret = btrfs_update_block_group(trans, bytenr, num_bytes, false);
> +		if (ret) {
> +			btrfs_abort_transaction(trans, ret);
> +			return ret;
> +		}
> +
> +		return 0;
> +	}
> +
>  	extent_root = btrfs_extent_root(info, bytenr);
>  	ASSERT(extent_root);
>  
> @@ -3113,8 +3131,6 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
>  	if (!path)
>  		return -ENOMEM;
>  
> -	is_data = owner_objectid >= BTRFS_FIRST_FREE_OBJECTID;
> -
>  	if (!is_data && refs_to_drop != 1) {
>  		btrfs_crit(info,
>  "invalid refs_to_drop, dropping more than 1 refs for tree block %llu refs_to_drop %u",
> @@ -4893,57 +4909,61 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
>  	int level = btrfs_delayed_ref_owner(node);
>  	bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
>  
> -	extent_key.objectid = node->bytenr;
> -	if (skinny_metadata) {
> -		/* The owner of a tree block is the level. */
> -		extent_key.offset = level;
> -		extent_key.type = BTRFS_METADATA_ITEM_KEY;
> -	} else {
> -		extent_key.offset = node->num_bytes;
> -		extent_key.type = BTRFS_EXTENT_ITEM_KEY;
> -		size += sizeof(*block_info);
> -	}
> +	if (node->ref_root != BTRFS_REMAP_TREE_OBJECTID) {

Similarly, I don't like jamming this whole allocation function that
fundamentally doesn't care about remap_tree behind a remap tree check
if.

I would at least change it to

if (unlikely(remap_tree))
        goto skip;

or something.

> +		extent_key.objectid = node->bytenr;
> +		if (skinny_metadata) {
> +			/* The owner of a tree block is the level. */
> +			extent_key.offset = level;
> +			extent_key.type = BTRFS_METADATA_ITEM_KEY;
> +		} else {
> +			extent_key.offset = node->num_bytes;
> +			extent_key.type = BTRFS_EXTENT_ITEM_KEY;
> +			size += sizeof(*block_info);
> +		}
>  
> -	path = btrfs_alloc_path();
> -	if (!path)
> -		return -ENOMEM;
> +		path = btrfs_alloc_path();
> +		if (!path)
> +			return -ENOMEM;
>  
> -	extent_root = btrfs_extent_root(fs_info, extent_key.objectid);
> -	ret = btrfs_insert_empty_item(trans, extent_root, path, &extent_key,
> -				      size);
> -	if (ret) {
> -		btrfs_free_path(path);
> -		return ret;
> -	}
> +		extent_root = btrfs_extent_root(fs_info, extent_key.objectid);
> +		ret = btrfs_insert_empty_item(trans, extent_root, path,
> +					      &extent_key, size);
> +		if (ret) {
> +			btrfs_free_path(path);
> +			return ret;
> +		}
>  
> -	leaf = path->nodes[0];
> -	extent_item = btrfs_item_ptr(leaf, path->slots[0],
> -				     struct btrfs_extent_item);
> -	btrfs_set_extent_refs(leaf, extent_item, 1);
> -	btrfs_set_extent_generation(leaf, extent_item, trans->transid);
> -	btrfs_set_extent_flags(leaf, extent_item,
> -			       flags | BTRFS_EXTENT_FLAG_TREE_BLOCK);
> +		leaf = path->nodes[0];
> +		extent_item = btrfs_item_ptr(leaf, path->slots[0],
> +					struct btrfs_extent_item);
> +		btrfs_set_extent_refs(leaf, extent_item, 1);
> +		btrfs_set_extent_generation(leaf, extent_item, trans->transid);
> +		btrfs_set_extent_flags(leaf, extent_item,
> +				flags | BTRFS_EXTENT_FLAG_TREE_BLOCK);
>  
> -	if (skinny_metadata) {
> -		iref = (struct btrfs_extent_inline_ref *)(extent_item + 1);
> -	} else {
> -		block_info = (struct btrfs_tree_block_info *)(extent_item + 1);
> -		btrfs_set_tree_block_key(leaf, block_info, &extent_op->key);
> -		btrfs_set_tree_block_level(leaf, block_info, level);
> -		iref = (struct btrfs_extent_inline_ref *)(block_info + 1);
> -	}
> +		if (skinny_metadata) {
> +			iref = (struct btrfs_extent_inline_ref *)(extent_item + 1);
> +		} else {
> +			block_info = (struct btrfs_tree_block_info *)(extent_item + 1);
> +			btrfs_set_tree_block_key(leaf, block_info, &extent_op->key);
> +			btrfs_set_tree_block_level(leaf, block_info, level);
> +			iref = (struct btrfs_extent_inline_ref *)(block_info + 1);
> +		}
>  
> -	if (node->type == BTRFS_SHARED_BLOCK_REF_KEY) {
> -		btrfs_set_extent_inline_ref_type(leaf, iref,
> -						 BTRFS_SHARED_BLOCK_REF_KEY);
> -		btrfs_set_extent_inline_ref_offset(leaf, iref, node->parent);
> -	} else {
> -		btrfs_set_extent_inline_ref_type(leaf, iref,
> -						 BTRFS_TREE_BLOCK_REF_KEY);
> -		btrfs_set_extent_inline_ref_offset(leaf, iref, node->ref_root);
> -	}
> +		if (node->type == BTRFS_SHARED_BLOCK_REF_KEY) {
> +			btrfs_set_extent_inline_ref_type(leaf, iref,
> +						BTRFS_SHARED_BLOCK_REF_KEY);
> +			btrfs_set_extent_inline_ref_offset(leaf, iref,
> +							   node->parent);
> +		} else {
> +			btrfs_set_extent_inline_ref_type(leaf, iref,
> +						BTRFS_TREE_BLOCK_REF_KEY);
> +			btrfs_set_extent_inline_ref_offset(leaf, iref,
> +							   node->ref_root);
> +		}
>  
> -	btrfs_free_path(path);
> +		btrfs_free_path(path);
> +	}
>  
>  	return alloc_reserved_extent(trans, node->bytenr, fs_info->nodesize);
>  }
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 9159d11cb143..0f4954f998cd 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3981,6 +3981,9 @@ static bool should_balance_chunk(struct extent_buffer *leaf, struct btrfs_chunk
>  	struct btrfs_balance_args *bargs = NULL;
>  	u64 chunk_type = btrfs_chunk_type(leaf, chunk);
>  
> +	if (chunk_type & BTRFS_BLOCK_GROUP_REMAP)
> +		return false;
> +
>  	/* type filter */
>  	if (!((chunk_type & BTRFS_BLOCK_GROUP_TYPE_MASK) &
>  	      (bctl->flags & BTRFS_BALANCE_TYPE_MASK))) {
> -- 
> 2.49.0
> 

