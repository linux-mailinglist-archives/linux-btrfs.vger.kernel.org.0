Return-Path: <linux-btrfs+bounces-17808-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B63BDC73C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 06:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359713BB61C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 04:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC0D2F3C31;
	Wed, 15 Oct 2025 04:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="LFjFmF2M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m5pxk+N/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AA62DF144
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 04:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760502319; cv=none; b=qpwgHAq7TurIFJsTLgSS4JnBFCqFMhveiFySl1WS8VmzDNRhlApzTDk/u18MW+JnVweavpKdP8lJq0gjtzBUtwOLjhRGJAG4K6SovT64sjEjAbji2BslKaLSX7Evn3e86ajAMdGxFoOvI6plls003YlEyVj1SlzszLybeYH7cTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760502319; c=relaxed/simple;
	bh=Jh6+BP4uhGHASiJTSWxltXb6s0q4fencwfVK2aSM3Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQ0geQd/4h1IbV/68jzNDrs/yxte8p6Pek9rojouDzKYBymNIOOiT1zg44fPl+ZtPaYBs7wLSyWIM7neoDhy1yQJCLlD7yHsrBtSRLaN2wNPhVWH2XzFRzW0u6s19WWANmU0QbJBGRYq9oout4UbJ8MvTN0YpFdUYRSA9uHPL3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=LFjFmF2M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m5pxk+N/; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E0013140018B;
	Wed, 15 Oct 2025 00:25:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 15 Oct 2025 00:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1760502316; x=1760588716; bh=C3RSEx8sDB
	OMJSlHmoG9FPDQ3llmv9GArjQccAQDQzw=; b=LFjFmF2MVRbWFwcLX8sZklxUSA
	5j/hpSYeIw3Vc68+z/XbfIUpwRZaF7cAZcxbj+sPf07Z0ma7qOQLTE+6wi3M3KKl
	JJUJ253dxRh9Kv1A+YQPdy/tk/pkAUR5/w7Gg6neXkSihoh6vh4YoxNHN8ytd/6y
	8D5AxP3m07XbHH9kpbGNjxp5X2JgIk9g4KSL3Q0EuaFpNz44baFhg4+eQxt0jWUo
	Qxr1Fo6ml6SEBUkDMIqR6iOLeFLfcZgf8OfKO9Gb03ksI6+2zo+T3jqVwWoiqo7e
	tWGw+DBKKuFvf3mIrkWCxAasOJDq5ZhxTVThLydZQ7qzgMhinc2QwK9OOaPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760502316; x=1760588716; bh=C3RSEx8sDBOMJSlHmoG9FPDQ3llmv9GArjQ
	ccAQDQzw=; b=m5pxk+N//0XxmuvH2VnJPYhHz1VUAOEghEtP37a+dug1qxJzVPa
	PVGUCgqebgNK32Z2vJeFeMMFuZdUgMdhgVuskMgRTpBMXRX6wiUylfWEKhQhpit/
	XtAtrVZhKFkGSwrPwFupr9N9TxEvOVwZLVmdyrqsV3BEG85l0XEuZRYHPAvAr3m3
	UBuPoWN+EaHoCSoSy++HObjcLRnrMSQIKfMrEEgeE6PzBPKisciJQF4nLQJdNGOE
	l09YCMS6AtdBAJgr6rmqfSUK4PZW86m8gTTEftgz1LIeRD2+ThK/xlE8iXkotZjE
	tIuxy4vbj11nPtMSDB3rpLuAA40eXevHLsg==
X-ME-Sender: <xms:LCLvaAqdD9C42sjuVUvTp6fTZ3Nr8jtn6o1Tbpo2SLmRymtc7fSBNQ>
    <xme:LCLvaMp4iOdab733EzHihm4qLctUWN5vXYhPJLXzTiNDBnaDZNuddD1WIudfDuNRv
    b3FWGLsgwRutX8uIg4aXl_bM8LFd45Ia7998DPmuRX58OMPDU4ntC5G>
X-ME-Received: <xmr:LCLvaC3gIexfU3kC7SULELh3I-y-nZnu6A79kgm7EjvdAKpDbNfImld67qTFD-TjYVvyaUYi3yXz0uR_bYkjN83v5Us>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LCLvaDAqK9H1draDU99JJmx6zCtUwrl4x7xBIvd242hoTMz3G5m88Q>
    <xmx:LCLvaCeUTkU-6_WrRhYi1D0a2_NN32Zw6C6bUHpIdRbCaMi11VrZjA>
    <xmx:LCLvaAgKHB91oa5_XxSt8fakZSJV0w0UWIh2hVQc7vSeznJVAKff2w>
    <xmx:LCLvaCoo6HofKBQfZTDF_v7VdRFqomGsWFgffsFvm2yPlXtADw7lwg>
    <xmx:LCLvaEfy_ob2R4DFGADynoD9oJJ62LwiReBwJ-VdPtI7Ns8LvoDJ44sv>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 00:25:16 -0400 (EDT)
Date: Tue, 14 Oct 2025 21:24:56 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 15/17] btrfs: allow balancing remap tree
Message-ID: <20251015042456.GH1702774@zen.localdomain>
References: <20251009112814.13942-1-mark@harmstone.com>
 <20251009112814.13942-16-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009112814.13942-16-mark@harmstone.com>

On Thu, Oct 09, 2025 at 12:28:10PM +0100, Mark Harmstone wrote:
> Balancing the REMAP chunk, i.e. the chunk in which the remap tree lives,
> is a special case.
> 
> We can't use the remap tree itself for this, as then we'd have no way to
> boostrap it on mount. And we can't use the pre-remap tree code for this
> as it relies on walking the extent tree, and we're not creating backrefs
> for REMAP chunks.
> 
> So instead, if a balance would relocate any REMAP block groups, mark
> those block groups as readonly and COW every leaf of the remap tree.
> 
> There's more sophisticated ways of doing this, such as only COWing nodes
> within a block group that's to be relocated, but they're fiddly and with
> lots of edge cases. Plus it's not anticipated that a) the number of
> REMAP chunks is going to be particularly large, or b) that users will
> want to only relocate some of these chunks - the main use case here is
> to unbreak RAID conversion and device removal.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/volumes.c | 159 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 155 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 1ce06c343918..a4dcafe2d565 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4016,8 +4016,11 @@ static bool should_balance_chunk(struct extent_buffer *leaf, struct btrfs_chunk
>  	struct btrfs_balance_args *bargs = NULL;
>  	u64 chunk_type = btrfs_chunk_type(leaf, chunk);
>  
> -	if (chunk_type & BTRFS_BLOCK_GROUP_REMAP)
> -		return false;
> +	/* treat REMAP chunks as METADATA */
> +	if (chunk_type & BTRFS_BLOCK_GROUP_REMAP) {
> +		chunk_type &= ~BTRFS_BLOCK_GROUP_REMAP;
> +		chunk_type |= BTRFS_BLOCK_GROUP_METADATA;
> +	}
>  
>  	/* type filter */
>  	if (!((chunk_type & BTRFS_BLOCK_GROUP_TYPE_MASK) &
> @@ -4100,6 +4103,113 @@ static bool should_balance_chunk(struct extent_buffer *leaf, struct btrfs_chunk
>  	return true;
>  }
>  
> +struct remap_chunk_info {
> +	struct list_head list;
> +	u64 offset;
> +	struct btrfs_block_group *bg;
> +	bool made_ro;
> +};
> +
> +static int cow_remap_tree(struct btrfs_trans_handle *trans,
> +			  struct btrfs_path *path)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_key key = { 0 };
> +	int ret;
> +
> +	ret = btrfs_search_slot(trans, fs_info->remap_root, &key, path, 0, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	while (true) {
> +		ret = btrfs_next_leaf(fs_info->remap_root, path);
> +		if (ret < 0) {
> +			return ret;
> +		} else if (ret > 0) {
> +			ret = 0;
> +			break;
> +		}
> +
> +		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> +
> +		btrfs_release_path(path);
> +
> +		ret = btrfs_search_slot(trans, fs_info->remap_root, &key, path,
> +					0, 1);
> +		if (ret < 0)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int balance_remap_chunks(struct btrfs_fs_info *fs_info,
> +				struct btrfs_path *path,
> +				struct list_head *chunks)
> +{
> +	struct remap_chunk_info *rci, *tmp;
> +	struct btrfs_trans_handle *trans;
> +	int ret;
> +
> +	list_for_each_entry_safe(rci, tmp, chunks, list) {
> +		rci->bg = btrfs_lookup_block_group(fs_info, rci->offset);
> +		if (!rci->bg) {
> +			list_del(&rci->list);
> +			kfree(rci);
> +			continue;
> +		}
> +
> +		ret = btrfs_inc_block_group_ro(rci->bg, false);
> +		if (ret)
> +			goto end;
> +
> +		rci->made_ro = true;
> +	}
> +
> +	if (list_empty(chunks))
> +		return 0;
> +
> +	trans = btrfs_start_transaction(fs_info->remap_root, 0);
> +	if (IS_ERR(trans)) {
> +		ret = PTR_ERR(trans);
> +		goto end;
> +	}
> +
> +	mutex_lock(&fs_info->remap_mutex);
> +
> +	ret = cow_remap_tree(trans, path);
> +
> +	btrfs_release_path(path);
> +
> +	mutex_unlock(&fs_info->remap_mutex);
> +
> +	btrfs_commit_transaction(trans);
> +
> +end:
> +	while (!list_empty(chunks)) {
> +		bool unused;
> +
> +		rci = list_first_entry(chunks, struct remap_chunk_info, list);
> +
> +		spin_lock(&rci->bg->lock);
> +		unused = !btrfs_is_block_group_used(rci->bg);
> +		spin_unlock(&rci->bg->lock);
> +
> +		if (unused)
> +			btrfs_mark_bg_unused(rci->bg);
> +
> +		if (rci->made_ro)
> +			btrfs_dec_block_group_ro(rci->bg);
> +
> +		btrfs_put_block_group(rci->bg);
> +
> +		list_del(&rci->list);
> +		kfree(rci);
> +	}
> +
> +	return ret;
> +}
> +
>  static int __btrfs_balance(struct btrfs_fs_info *fs_info)
>  {
>  	struct btrfs_balance_control *bctl = fs_info->balance_ctl;
> @@ -4122,6 +4232,9 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
>  	u32 count_meta = 0;
>  	u32 count_sys = 0;
>  	int chunk_reserved = 0;
> +	struct remap_chunk_info *rci;
> +	unsigned int num_remap_chunks = 0;
> +	LIST_HEAD(remap_chunks);
>  
>  	path = btrfs_alloc_path();
>  	if (!path) {
> @@ -4220,7 +4333,8 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
>  				count_data++;
>  			else if (chunk_type & BTRFS_BLOCK_GROUP_SYSTEM)
>  				count_sys++;
> -			else if (chunk_type & BTRFS_BLOCK_GROUP_METADATA)
> +			else if (chunk_type & (BTRFS_BLOCK_GROUP_METADATA |
> +					       BTRFS_BLOCK_GROUP_REMAP))
>  				count_meta++;
>  
>  			goto loop;
> @@ -4240,6 +4354,30 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
>  			goto loop;
>  		}
>  
> +		/*
> +		 * Balancing REMAP chunks takes place separately - add the
> +		 * details to a list so it can be processed later.
> +		 */
> +		if (chunk_type & BTRFS_BLOCK_GROUP_REMAP) {
> +			mutex_unlock(&fs_info->reclaim_bgs_lock);
> +
> +			rci = kmalloc(sizeof(struct remap_chunk_info),
> +				      GFP_NOFS);
> +			if (!rci) {
> +				ret = -ENOMEM;
> +				goto error;
> +			}
> +
> +			rci->offset = found_key.offset;
> +			rci->bg = NULL;
> +			rci->made_ro = false;
> +			list_add_tail(&rci->list, &remap_chunks);
> +
> +			num_remap_chunks++;
> +
> +			goto loop;
> +		}
> +
>  		if (!chunk_reserved) {
>  			/*
>  			 * We may be relocating the only data chunk we have,
> @@ -4279,11 +4417,24 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
>  		key.offset = found_key.offset - 1;
>  	}
>  
> +	btrfs_release_path(path);
> +
>  	if (counting) {
> -		btrfs_release_path(path);
>  		counting = false;
>  		goto again;
>  	}
> +
> +	if (!list_empty(&remap_chunks)) {
> +		ret = balance_remap_chunks(fs_info, path, &remap_chunks);
> +		if (ret == -ENOSPC)
> +			enospc_errors++;
> +
> +		if (!ret) {
> +			spin_lock(&fs_info->balance_lock);
> +			bctl->stat.completed += num_remap_chunks;
> +			spin_unlock(&fs_info->balance_lock);
> +		}
> +	}
>  error:
>  	btrfs_free_path(path);
>  	if (enospc_errors) {
> -- 
> 2.49.1
> 

