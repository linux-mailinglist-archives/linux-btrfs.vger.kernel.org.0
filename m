Return-Path: <linux-btrfs+bounces-8529-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA0298F901
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 23:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EDE6B2169C
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 21:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2D11BD01F;
	Thu,  3 Oct 2024 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="F1y1MPZE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VN5aVhtU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89546748D
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727991366; cv=none; b=a6hZ3hGknkrt3Hh+d/UYN5DeqJEDd9B+lry55sQ1PRoVQWZvz7vuKXf/PyBWaKdFnNG48eRU2nR98KcWJ2FonQcQ+cj43jgXzxwHvgsfksi44JGp5CULpYcq1lWHGTTMcUSmJvOCybDGGbaZWzgXDbBKlXW736F0J5y/2fbmkTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727991366; c=relaxed/simple;
	bh=q7YA7uzdaLLnXPTgIckOLpPR8l0b9gD4TvSy4W/Md4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2C8m5nONUFB96DGCEFdHRg1+/98VlLGvk8+wPTzx6vK0uwvfxJUf32B6bNDleDdfIRo4mqvlm335MCvEK7cAsztgr7BO6PLKQrvaQs9poKRMhfThclaIzLchGCe8zOJmTaCS+kHGIudm82ujsNfspJtnVeS0X/KASlbHBQa0+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=F1y1MPZE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VN5aVhtU; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8706B138029F;
	Thu,  3 Oct 2024 17:36:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 03 Oct 2024 17:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1727991363; x=1728077763; bh=pnIGaBXA5u
	JNWVmJgIvKU0jdxCyaQb1MiqcFA0rOT5s=; b=F1y1MPZE3nL27m8FWpomzd2ncZ
	TUVU87VfRcdG7JjA6b2inBBKpCNYyrNJAh1NMeclIi3jGUhZtgZr8IvjXHzhHveF
	ulegPDlOGXrUVJFcD9KL8XHlb4DAVr666RHGfbEjR0WIrntW2z5SM7q5dslB1UEM
	xMMX4x1HFIv/41eV7X5/EwmauJ1e3NxDF8f6eCmCQ+Lcp2WIKYGi7rP9fMB2bVyN
	3ELfmK3wWz9YKDQw/+cyhIibVo5SGUZrmIEKoRRITv7KUTOB1gqkulaKEf5LygDM
	sO4Ye8SDJM2wd+huw/mjq4lZfU0LfjhGxLgXSsI+tgnqA59K+7rRJBJLGevg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727991363; x=1728077763; bh=pnIGaBXA5uJNWVmJgIvKU0jdxCya
	Qb1MiqcFA0rOT5s=; b=VN5aVhtUzJ0FRiOQB0E0v1VhfQ+X5qq2FwvCRs+yeiSR
	WkGL+VTSUzhgJXw3zc/Ut9rOX33nkIszIHNIXAz0QviV8VdolzHaFXvyczk6bO7o
	8NzuulP0CV7J/aWhlBqyDyAw6vsodjmp6uNCAQXAR41TGL/vpoymjz6QH80IgRar
	mqYhJRTqd8K32SXjQVfeXsbn21MTjuctRTD87NhLL2xVvFUppheCDD0+wT7Ud6/V
	OqlT3tR87qfpFDEv+ayk1wRWIGTHAs/XZ1LIQiwEQGWrTfwJd6qEtWSod843OSZE
	NU5sLSYXsvtg1yEq3BpOHyFrs2npiZa1ok26RBgc9w==
X-ME-Sender: <xms:Qw7_ZqWIAXLueTe2LkdIXOUJTMNRRBKfkqT6U6vRl6eWsLfDHUE3LQ>
    <xme:Qw7_ZmmIfUGdQJ22SYeGqM5-7iIk8bgte6O7fjQZRftW20kzsJsWywmWWFENOoNyf
    8IqIzUqz0s5XIz41s8>
X-ME-Received: <xmr:Qw7_ZubCLXEcRHvlrbfT7FuG5mpq3vhFBuYbkXGKu-Bkz4eNnDU4_tEygLlsmJl1UmcYdThx-vi1KLLSC6EB3et8uGM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvvddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenuc
    ggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeu
    gfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhoshgvfhesthhogihitghprghnuggrrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:Qw7_ZhUMgrImgYyzffC7j_ycrJ-q4vb9HdnznMxujMVk9a0iTglF8A>
    <xmx:Qw7_ZknH2W2rfUQULVcz9mVTgZpY6JqtxFQme9izxFLJxIYmpQbkLQ>
    <xmx:Qw7_ZmcM-PTp4fTerk4OL1sBHOyynAiKoy4CLW05dJ-wQPf-a2Lgbw>
    <xmx:Qw7_ZmFjU1zsTqi4Xf-di7xhRxeFyxq-_g-dUDOF3wlZtCVcXvwAAQ>
    <xmx:Qw7_Zuj3OE3HmNWG38UYRSNn86dnvCH6CPgmk5jKa6Zgrc4dbj9IE7_C>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 17:36:02 -0400 (EDT)
Date: Thu, 3 Oct 2024 14:36:00 -0700
From: Boris Burkov <boris@bur.io>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 06/10] btrfs: don't build backref tree for cowonly blocks
Message-ID: <20241003213600.GD435178@zen.localdomain>
References: <cover.1727970062.git.josef@toxicpanda.com>
 <b92ec1ed0dc070a6c07f0a42197ea71fc34fdf05.1727970063.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b92ec1ed0dc070a6c07f0a42197ea71fc34fdf05.1727970063.git.josef@toxicpanda.com>

On Thu, Oct 03, 2024 at 11:43:08AM -0400, Josef Bacik wrote:
> We already determine the owner for any blocks we find when we're
> relocating, and for cowonly blocks (and the data reloc tree) we cow down
> to the block and call it good enough.  However we still build a whole
> backref tree for them, even though we're not going to use it, and then
> just don't put these blocks in the cache.
> 
> Rework the code to check if the block belongs to a cowonly root or the
> data reloc root, and then just cow down to the block, skipping the
> backref cache generation.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/relocation.c | 89 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 70 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 7de94e55234c..db5f6bda93c9 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2136,17 +2136,11 @@ static noinline_for_stack u64 calcu_metadata_size(struct reloc_control *rc,
>  	return num_bytes;
>  }
>  
> -static int reserve_metadata_space(struct btrfs_trans_handle *trans,
> -				  struct reloc_control *rc,
> -				  struct btrfs_backref_node *node)
> +static int refill_metadata_space(struct btrfs_trans_handle *trans,
> +				 struct reloc_control *rc, u64 num_bytes)
>  {
> -	struct btrfs_root *root = rc->extent_root;
> -	struct btrfs_fs_info *fs_info = root->fs_info;
> -	u64 num_bytes;
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
>  	int ret;
> -	u64 tmp;
> -
> -	num_bytes = calcu_metadata_size(rc, node) * 2;
>  
>  	trans->block_rsv = rc->block_rsv;
>  	rc->reserved_bytes += num_bytes;
> @@ -2159,7 +2153,7 @@ static int reserve_metadata_space(struct btrfs_trans_handle *trans,
>  	ret = btrfs_block_rsv_refill(fs_info, rc->block_rsv, num_bytes,
>  				     BTRFS_RESERVE_FLUSH_LIMIT);
>  	if (ret) {
> -		tmp = fs_info->nodesize * RELOCATION_RESERVED_NODES;
> +		u64 tmp = fs_info->nodesize * RELOCATION_RESERVED_NODES;
>  		while (tmp <= rc->reserved_bytes)
>  			tmp <<= 1;
>  		/*
> @@ -2177,6 +2171,16 @@ static int reserve_metadata_space(struct btrfs_trans_handle *trans,
>  	return 0;
>  }
>  
> +static int reserve_metadata_space(struct btrfs_trans_handle *trans,
> +				  struct reloc_control *rc,
> +				  struct btrfs_backref_node *node)
> +{
> +	u64 num_bytes;
> +
> +	num_bytes = calcu_metadata_size(rc, node) * 2;
> +	return refill_metadata_space(trans, rc, num_bytes);
> +}
> +
>  /*
>   * relocate a block tree, and then update pointers in upper level
>   * blocks that reference the block to point to the new location.
> @@ -2528,15 +2532,11 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
>  			node->root = btrfs_grab_root(root);
>  			ASSERT(node->root);
>  		} else {
> -			path->lowest_level = node->level;
> -			if (root == root->fs_info->chunk_root)
> -				btrfs_reserve_chunk_metadata(trans, false);
> -			ret = btrfs_search_slot(trans, root, key, path, 0, 1);
> -			btrfs_release_path(path);
> -			if (root == root->fs_info->chunk_root)
> -				btrfs_trans_release_chunk_metadata(trans);
> -			if (ret > 0)
> -				ret = 0;
> +			btrfs_err(root->fs_info,
> +				  "bytenr %llu resolved to a non-shareable root",
> +				  node->bytenr);
> +			ret = -EUCLEAN;
> +			goto out;
>  		}
>  		if (!ret)
>  			update_processed_blocks(rc, node);
> @@ -2549,6 +2549,43 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
>  	return ret;
>  }
>  
> +static noinline_for_stack
> +int relocate_cowonly_block(struct btrfs_trans_handle *trans,
> +			   struct reloc_control *rc, struct tree_block *block,
> +			   struct btrfs_path *path)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_root *root;
> +	u64 num_bytes;
> +	int nr_levels;
> +	int ret;
> +
> +	root = btrfs_get_fs_root(fs_info, block->owner, true);
> +	if (IS_ERR(root))
> +		return PTR_ERR(root);
> +
> +	nr_levels = max(btrfs_header_level(root->node) - block->level, 0) + 1;
> +
> +	num_bytes = fs_info->nodesize * nr_levels;
> +	ret = refill_metadata_space(trans, rc, num_bytes);
> +	if (ret) {
> +		btrfs_put_root(root);
> +		return ret;
> +	}
> +	path->lowest_level = block->level;
> +	if (root == root->fs_info->chunk_root)
> +		btrfs_reserve_chunk_metadata(trans, false);
> +	ret = btrfs_search_slot(trans, root, &block->key, path, 0, 1);
> +	path->lowest_level = 0;
> +	btrfs_release_path(path);
> +	if (root == root->fs_info->chunk_root)
> +		btrfs_trans_release_chunk_metadata(trans);
> +	if (ret > 0)
> +		ret = 0;
> +	btrfs_put_root(root);
> +	return ret;
> +}
> +
>  /*
>   * relocate a list of blocks
>   */
> @@ -2588,6 +2625,20 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
>  
>  	/* Do tree relocation */
>  	rbtree_postorder_for_each_entry_safe(block, next, blocks, rb_node) {
> +		/*
> +		 * For cowonly blocks, or the data reloc tree, we only need to
> +		 * cow down to the block, there's no need to generate a backref
> +		 * tree.
> +		 */
> +		if (block->owner &&
> +		    (!is_fstree(block->owner) ||
> +		     block->owner == BTRFS_DATA_RELOC_TREE_OBJECTID)) {

would it make sense to capture this (and probably other conditions using
roots instead of backref cache blocks) into a named cowonly concept?

> +			ret = relocate_cowonly_block(trans, rc, block, path);
> +			if (ret)
> +				break;
> +			continue;
> +		}
> +
>  		node = build_backref_tree(trans, rc, &block->key,
>  					  block->level, block->bytenr);
>  		if (IS_ERR(node)) {
> -- 
> 2.43.0
> 

