Return-Path: <linux-btrfs+bounces-2760-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70775866872
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 04:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFE04B210FE
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 03:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A5A18EA1;
	Mon, 26 Feb 2024 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d+jHwVdA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A3417745
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 03:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916469; cv=none; b=jlmich/6e+zR8e/BcWIK9Xbs1Z7YDR+O/UUcdDiJscpaWzhIen1yaDfGIF1PIHSnG6HD3dm/BKFhGlN9iMBlFs2SL8aHWTo+azXWehquHv7BbUirOHoTS8zc74vCaeY03glHp2+3RVOi5zHfRwGBNpuwh0eQZw1P2r7DdjkOlYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916469; c=relaxed/simple;
	bh=SyhHpPBCPZdPaZLUFLiw1AEQPQtLw6T522aHRmmlLtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkQWt3h+DBCUVRD0oo8c8UmZlwjfZolgPuI9hfEpZKtKXD/hZ1l85VbveiOP/obuq7dda05RvAn4VRvnlNKw/JundXToP8+L8cK8HHEaph0zdoGZKMkqlH3WU9unMr4rpC1PEJMc8fh4P/nCShJNnbjszWYXGsVpSr8NgxcLRGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d+jHwVdA; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <82a6560f-2f2e-455c-a4f3-e8678b303d56@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708916463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5koaLzex9813qI8uQfwXEgWC6CJf/jJP7/pJtPSdPrc=;
	b=d+jHwVdAJYQhabbJIchaY2/ieVOklbJP7Ow1wKdAh6JtiQm0rIbgCWmLGZEOazNuqjYzbG
	Y4cDzKKXE/IQbL4BAMya1byONLElEYWfb8oHIr/BjBODQ73eyqGc+5D08csdpWB8aw2gK7
	JZh3HUtLv3B08F3EvRIce+SKMpytlt8=
Date: Mon, 26 Feb 2024 11:00:55 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] btrfs: remove SLAB_MEM_SPREAD flag usage
Content-Language: en-US
To: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 vbabka@suse.cz, roman.gushchin@linux.dev, Xiongwei.Song@windriver.com
References: <20240224134709.829191-1-chengming.zhou@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240224134709.829191-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/24 21:47, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.

Update changelog to make it clearer:

The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
removed as of v6.8-rc1, so it became a dead flag since the commit
16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
series[1] went on to mark it obsolete to avoid confusion for users.
Here we can just remove all its users, which has no functional change.

[1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

Thanks!

> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  fs/btrfs/backref.c          | 2 +-
>  fs/btrfs/ctree.c            | 2 +-
>  fs/btrfs/defrag.c           | 2 +-
>  fs/btrfs/delayed-inode.c    | 2 +-
>  fs/btrfs/delayed-ref.c      | 8 ++++----
>  fs/btrfs/extent-io-tree.c   | 2 +-
>  fs/btrfs/extent_io.c        | 2 +-
>  fs/btrfs/extent_map.c       | 2 +-
>  fs/btrfs/free-space-cache.c | 4 ++--
>  fs/btrfs/inode.c            | 2 +-
>  fs/btrfs/ordered-data.c     | 2 +-
>  fs/btrfs/transaction.c      | 2 +-
>  12 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 6514cb1d404a..f2abb9afd04a 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -200,7 +200,7 @@ int __init btrfs_prelim_ref_init(void)
>  	btrfs_prelim_ref_cache = kmem_cache_create("btrfs_prelim_ref",
>  					sizeof(struct prelim_ref),
>  					0,
> -					SLAB_MEM_SPREAD,
> +					0,
>  					NULL);
>  	if (!btrfs_prelim_ref_cache)
>  		return -ENOMEM;
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index bae17dbe71d6..aaf53fd84358 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -5086,7 +5086,7 @@ int btrfs_previous_extent_item(struct btrfs_root *root,
>  
>  int __init btrfs_ctree_init(void)
>  {
> -	btrfs_path_cachep = KMEM_CACHE(btrfs_path, SLAB_MEM_SPREAD);
> +	btrfs_path_cachep = KMEM_CACHE(btrfs_path, 0);
>  	if (!btrfs_path_cachep)
>  		return -ENOMEM;
>  	return 0;
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 6d3abfcf92d4..4f9e78a94a0a 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -1516,7 +1516,7 @@ int __init btrfs_auto_defrag_init(void)
>  {
>  	btrfs_inode_defrag_cachep = kmem_cache_create("btrfs_inode_defrag",
>  					sizeof(struct inode_defrag), 0,
> -					SLAB_MEM_SPREAD,
> +					0,
>  					NULL);
>  	if (!btrfs_inode_defrag_cachep)
>  		return -ENOMEM;
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 0a7a40d97e91..dd6f566a383f 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -28,7 +28,7 @@ static struct kmem_cache *delayed_node_cache;
>  
>  int __init btrfs_delayed_inode_init(void)
>  {
> -	delayed_node_cache = KMEM_CACHE(btrfs_delayed_node, SLAB_MEM_SPREAD);
> +	delayed_node_cache = KMEM_CACHE(btrfs_delayed_node, 0);
>  	if (!delayed_node_cache)
>  		return -ENOMEM;
>  	return 0;
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index c90efc20b8b2..7c5377151a1f 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -1308,22 +1308,22 @@ void __cold btrfs_delayed_ref_exit(void)
>  int __init btrfs_delayed_ref_init(void)
>  {
>  	btrfs_delayed_ref_head_cachep = KMEM_CACHE(btrfs_delayed_ref_head,
> -						   SLAB_MEM_SPREAD);
> +						   0);
>  	if (!btrfs_delayed_ref_head_cachep)
>  		goto fail;
>  
>  	btrfs_delayed_tree_ref_cachep = KMEM_CACHE(btrfs_delayed_tree_ref,
> -						   SLAB_MEM_SPREAD);
> +						   0);
>  	if (!btrfs_delayed_tree_ref_cachep)
>  		goto fail;
>  
>  	btrfs_delayed_data_ref_cachep = KMEM_CACHE(btrfs_delayed_data_ref,
> -						   SLAB_MEM_SPREAD);
> +						   0);
>  	if (!btrfs_delayed_data_ref_cachep)
>  		goto fail;
>  
>  	btrfs_delayed_extent_op_cachep = KMEM_CACHE(btrfs_delayed_extent_op,
> -						    SLAB_MEM_SPREAD);
> +						    0);
>  	if (!btrfs_delayed_extent_op_cachep)
>  		goto fail;
>  
> diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> index 6b923c0ef4ea..102572e31636 100644
> --- a/fs/btrfs/extent-io-tree.c
> +++ b/fs/btrfs/extent-io-tree.c
> @@ -1884,7 +1884,7 @@ int __init extent_state_init_cachep(void)
>  {
>  	extent_state_cache = kmem_cache_create("btrfs_extent_state",
>  			sizeof(struct extent_state), 0,
> -			SLAB_MEM_SPREAD, NULL);
> +			0, NULL);
>  	if (!extent_state_cache)
>  		return -ENOMEM;
>  
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index bfef67c68221..e779a85e752f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -147,7 +147,7 @@ int __init extent_buffer_init_cachep(void)
>  {
>  	extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
>  			sizeof(struct extent_buffer), 0,
> -			SLAB_MEM_SPREAD, NULL);
> +			0, NULL);
>  	if (!extent_buffer_cache)
>  		return -ENOMEM;
>  
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index ea08601988de..692d62b2fab2 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -16,7 +16,7 @@ int __init extent_map_init(void)
>  {
>  	extent_map_cache = kmem_cache_create("btrfs_extent_map",
>  			sizeof(struct extent_map), 0,
> -			SLAB_MEM_SPREAD, NULL);
> +			0, NULL);
>  	if (!extent_map_cache)
>  		return -ENOMEM;
>  	return 0;
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index d984912dae06..c8a05d5eb9cb 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -4154,13 +4154,13 @@ int btrfs_set_free_space_cache_v1_active(struct btrfs_fs_info *fs_info, bool act
>  
>  int __init btrfs_free_space_init(void)
>  {
> -	btrfs_free_space_cachep = KMEM_CACHE(btrfs_free_space, SLAB_MEM_SPREAD);
> +	btrfs_free_space_cachep = KMEM_CACHE(btrfs_free_space, 0);
>  	if (!btrfs_free_space_cachep)
>  		return -ENOMEM;
>  
>  	btrfs_free_space_bitmap_cachep = kmem_cache_create("btrfs_free_space_bitmap",
>  							PAGE_SIZE, PAGE_SIZE,
> -							SLAB_MEM_SPREAD, NULL);
> +							0, NULL);
>  	if (!btrfs_free_space_bitmap_cachep) {
>  		kmem_cache_destroy(btrfs_free_space_cachep);
>  		return -ENOMEM;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index df55dd891137..6c4d60746af6 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8717,7 +8717,7 @@ int __init btrfs_init_cachep(void)
>  {
>  	btrfs_inode_cachep = kmem_cache_create("btrfs_inode",
>  			sizeof(struct btrfs_inode), 0,
> -			SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT,
> +			SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
>  			init_once);
>  	if (!btrfs_inode_cachep)
>  		goto fail;
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 1ee2fb8dcd6a..b749ba45da2b 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -1235,7 +1235,7 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
>  
>  int __init ordered_data_init(void)
>  {
> -	btrfs_ordered_extent_cache = KMEM_CACHE(btrfs_ordered_extent, SLAB_MEM_SPREAD);
> +	btrfs_ordered_extent_cache = KMEM_CACHE(btrfs_ordered_extent, 0);
>  	if (!btrfs_ordered_extent_cache)
>  		return -ENOMEM;
>  
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index ea080ec2f927..2f151c5367ed 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -2672,7 +2672,7 @@ void __cold __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
>  int __init btrfs_transaction_init(void)
>  {
>  	btrfs_trans_handle_cachep = KMEM_CACHE(btrfs_trans_handle,
> -					       SLAB_TEMPORARY | SLAB_MEM_SPREAD);
> +					       SLAB_TEMPORARY);
>  	if (!btrfs_trans_handle_cachep)
>  		return -ENOMEM;
>  	return 0;

