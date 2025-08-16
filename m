Return-Path: <linux-btrfs+bounces-16111-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B041B28986
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 03:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2255E6124
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 01:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C45617736;
	Sat, 16 Aug 2025 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="gW61QZiU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GcLiWCsj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C098BE8
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Aug 2025 01:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755306115; cv=none; b=mqtZSCDpp+fML+soM8ByqDCw4vo/D6lhrklP74X+C9RDWYYKPCa05Jclux5KpNvXb/we/heh+ytiOwaCQ7Se6s9MunnFHpZth7u7fN3pBiIk1mhlykj0rjnZKI65szWyc5ygvjwkwotBSHde8rXWKML2nTErGz2dONIeHR+fEu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755306115; c=relaxed/simple;
	bh=MzcEI7C6tn0yd23SPTySjKyDKVKUIW3PzoetCSMaLD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpiHDjsjaVZYjuQj4jg+q5mMMMX1FcIf5zP3yIsORA2QrTh6wSw/6e9P+k7jpfJ59OfCZwmMvOPTK6IbMWpsVGSRIm3c9Rf8JHsR4J4Y9GGlRbUcuogafLHi2C1a1hfyYxgkySZ8a4FvWEqh3Knl4PrPeJrSnlk7Hg3uWL9lw9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=gW61QZiU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GcLiWCsj; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3E8241D00223;
	Fri, 15 Aug 2025 21:01:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 15 Aug 2025 21:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1755306111; x=1755392511; bh=Sgic1r/yxs
	ucd7XUKtmpS/KqlhSVTwbSQqRzEqsMGI8=; b=gW61QZiU8e8Iswqs6Zp7m+V8vs
	zQFKzSZPV0Y1mNtXu6fclmtgQu+O+KclPd3an9LyZ6MVVbfpdbQx16hI303RjRwT
	B//jFRWCZeuplzVhRIbIkHkS+sGoPW7ZCGMeIEHrmtBu4nXV2nX+zygro3nnFbSG
	PNXq8bSGtl+u3w+JhkCYd61OTK83NzzKOT7WN6Rvg9eFpAFD7eP/1tpExHUIYoBo
	5yelxEpfY4ZhM9iYb6o8ang/IO1DuoZ+rPWjoQ/UE30O0ERfQgr6cSEy48QiIJ7X
	xcj6HtN4HLrk5zkaNuozcvAxBe3WXUcATZWhGb5JqJoNq1Z0Hi52M8HpbW1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755306111; x=1755392511; bh=Sgic1r/yxsucd7XUKtmpS/KqlhSVTwbSQqR
	zEqsMGI8=; b=GcLiWCsjyMElV4uXTI4gBLvD9a+yp2gLuQTVIDTEsfvUbFzqQAh
	3+vuEgyIJBHeSxlsEq5ocQmmTVdvJfEQ/MhkE8icf1DB7qtusLXleDQIC2qzKVaC
	a8fEEfIq4nnwMbtblaRDpmFSfADK1tp4U01IX9SbML7drdywVkt1CB8PfT2ehQs3
	ZCW7vAZqaTbxJUurdAvKBtUDHvfhU7GB5WqglNW7Nu/kIYJLwwYYQYrgDaW1Rtry
	LWi0526FU3Le7p7Xpy6/cjE/r8pSyF0EbgxOfJXVoyuttQgx03XQpU/3Gd/Lcbfv
	kHZNcxCdVXl7P69ea6vMTcZ7VFxqxUiJLyA==
X-ME-Sender: <xms:ftifaHZjGhWkHdQPOyrSAD_EfKIYeZj55sNAw1JiadaLDineqMAIEA>
    <xme:ftifaGlTqeoVMwUpersBEd9R4aNr8tuuWudJEDy86eXsyE9jomN2GVv57LvydQwWX
    MVtBOBo3yURq-VqpMM>
X-ME-Received: <xmr:ftifaLwiryXQuMwLR_Fxtrk-Ygk-dbYIj-tf4taR4wuOy42GECmqBnlrhiL-VuqPkowt8iNNwodMmTisJtXG5-FW2a4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ftifaMMv3VsuUllaiMqwNQLd8Zb0xDi-TS1LEelY54w3SB4WNqOtVQ>
    <xmx:ftifaHRzcpVJVHDydnW03Dj5z-ZHdmpSyh2BeIVo6BSvOVglVTqAdw>
    <xmx:ftifaCYT-ldT0auqevwOzAQiS5rsJZrtEmtKLuDF6TVJtWFrWk-z5w>
    <xmx:ftifaM1CiG_nj3URuj6SrvmexjCgSqkMc0viNzCXaoWrb6ejhn30cA>
    <xmx:f9ifaE8b5hbw147OpibdFNzfzTeN0zDENQu9gJfkqgFQug1jh6HuPkYH>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 21:01:50 -0400 (EDT)
Date: Fri, 15 Aug 2025 18:02:31 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 16/16] btrfs: allow balancing remap tree
Message-ID: <20250816010231.GH3042054@zen.localdomain>
References: <20250813143509.31073-1-mark@harmstone.com>
 <20250813143509.31073-17-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813143509.31073-17-mark@harmstone.com>

On Wed, Aug 13, 2025 at 03:34:58PM +0100, Mark Harmstone wrote:
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
> ---
>  fs/btrfs/volumes.c | 161 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 157 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index e13f16a7a904..dc535ed90ae0 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4011,8 +4011,11 @@ static bool should_balance_chunk(struct extent_buffer *leaf, struct btrfs_chunk
>  	struct btrfs_balance_args *bargs = NULL;
>  	u64 chunk_type = btrfs_chunk_type(leaf, chunk);
>  
> -	if (chunk_type & BTRFS_BLOCK_GROUP_REMAP)
> -		return false;
> +	/* treat REMAP chunks as METADATA */
> +	if (chunk_type & BTRFS_BLOCK_GROUP_REMAP) {
> +		chunk_type &= ~BTRFS_BLOCK_GROUP_REMAP;
> +		chunk_type |= BTRFS_BLOCK_GROUP_METADATA;

why not honor the REMAP chunk type where appropriate?

> +	}
>  
>  	/* type filter */
>  	if (!((chunk_type & BTRFS_BLOCK_GROUP_TYPE_MASK) &
> @@ -4095,6 +4098,113 @@ static bool should_balance_chunk(struct extent_buffer *leaf, struct btrfs_chunk
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

Just thinking out loud, what happens if we concurrently attempt a
balance that would need to use the remap tree? Is something structurally
blocking that at a higher level? Or will it fail? How will that failure
be handled? Does the answer hold for btrfs-internal background reclaim
rather than explicit balancing?

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
> @@ -4117,6 +4227,9 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
>  	u32 count_meta = 0;
>  	u32 count_sys = 0;
>  	int chunk_reserved = 0;
> +	struct remap_chunk_info *rci;
> +	unsigned int num_remap_chunks = 0;
> +	LIST_HEAD(remap_chunks);
>  
>  	path = btrfs_alloc_path();
>  	if (!path) {
> @@ -4215,7 +4328,8 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
>  				count_data++;
>  			else if (chunk_type & BTRFS_BLOCK_GROUP_SYSTEM)
>  				count_sys++;
> -			else if (chunk_type & BTRFS_BLOCK_GROUP_METADATA)
> +			else if (chunk_type & (BTRFS_BLOCK_GROUP_METADATA |
> +					       BTRFS_BLOCK_GROUP_REMAP))
>  				count_meta++;
>  
>  			goto loop;
> @@ -4235,6 +4349,30 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
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
> @@ -4274,11 +4412,26 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
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
> +			btrfs_delete_unused_bgs(fs_info);

Why is this necessary here?

> +
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

