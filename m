Return-Path: <linux-btrfs+bounces-17801-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9566DBDC616
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 05:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68CB33C4938
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 03:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D792D2485;
	Wed, 15 Oct 2025 03:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="GoIlGvIm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RSbSAx3r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B67B24BD04
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 03:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760500056; cv=none; b=Q4DFky+NVu/CEYmeGxNBY8SXQgXgVONoLBek3ufk/Mvrl37MHdldnaqTIL2+dfobTiXGRFIFxYO+wrv8MTiwD4/gaCMsQU8/qWsx7jQ/PJw4KQ3z55XuQssOc6LeQ33Wu5kbs8Mk0XCtpYTEDWO9fvab56yXJ3YHtlsWEIDBkhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760500056; c=relaxed/simple;
	bh=HWTSF/luaEw8XvBBUI1Unkbqoh1d3HZVcqhNjMCfONg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnWAmrNSdMwp7WUfP4Waqw4roE9iV0DJLcsOQeMSY6LISk4DznDxcy4xhRjruWRcLbujLhN9H5FUWCkd1Wqy7n/q1VWjIOx+let2ZJLPy+g8XlYB+QmbMi7AY0U1kGqGvnQRQH0ysYHIomqsb4xMqUghYTTvFb/0Ls9y9ocjeAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=GoIlGvIm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RSbSAx3r; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 21A9114000FE;
	Tue, 14 Oct 2025 23:47:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 14 Oct 2025 23:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1760500053; x=1760586453; bh=LSapLicddP
	rbTCxOdkCO7o5QqqD/sYhwuGgDUInt75k=; b=GoIlGvIm93IOkV9udh8c/WtvtT
	j/nrEDTrpNCVMv3V7ByoXCMogClHzihkZw26bLVdFdKaOCzEFIw74aQLXGk28jMd
	MeGkF5kTebPAncVnUipRK+xu8gwuXW9yFrJ0rz3Ghd83ZfoyOlu+fdiSE31+lBko
	1EmPoXWjccWTw1iCMvZl0qwzcPtwp5oa+zcJkdQSiUWvpWU9qASkM97KsfQtnKnT
	pdNeVVtjTyb5l9/+0i0QwVHajj5/U/6aIP+KIL4OjK+nPz7loIvVkSKeoNoYQ4ag
	9u2DSFvMPjnO/QoSEjsyEaAzRoRWA76C+ry0JT0YI3jF9013QYROxLseevsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760500053; x=1760586453; bh=LSapLicddPrbTCxOdkCO7o5QqqD/sYhwuGg
	DUInt75k=; b=RSbSAx3r1kxzSLFiEWu56u+cetBgKPnmL04p+D3QHhJVMHMG9F6
	Lx4tTo9tlVKGNqRXkxv3V6Eua6tWeB+2NzIBFJFwRsaRoQ9zcND0GEdoCM0rWuin
	ttUyebZ06iW2TxqUv0UvNChAvMP0i0YfLu1Kp+g0TlIshFT77Px2hohqhGAvg9vH
	zj47s8YsVeTVzqBy1RAPA/AVbRHgl5c+Z4TBz+Tw71OYodvmJH8SKrHKYB+HEPng
	1SbFyllMPlmgLlshSOt93kDIv+4FwqxamyvgCmSk9vzYN3YYx8ojFS+QNhee1scm
	jK7hHIwrrE90WryDLHYX5It7ZL86LxyzGtQ==
X-ME-Sender: <xms:VBnvaDaVM6uQv7VmdDPdmj7E20FoQCz7EVpQvYZo3n-Xg3F95w3StQ>
    <xme:VBnvaIarYHdK97hBXMtN7Ozc9PEwjdz571hThnO1Z1ZtEDNvogH11SJsvKQkwThGe
    -Yfzp1CHKfmveAKxfHsp4KndNFTf_yHxTROCCb6jkVyputW8FRgDoE>
X-ME-Received: <xmr:VBnvaDliFDbYguv9PglxojT7bMmrxJenJjyBevOtfcCS3RcJWRHzAtaq827ThqsprNC1Y7emVzu1uDaqzBzoR_B0Or4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VBnvaExRU3mSxZYXKDUY2R4OytSG_cuu-qgwtxOZa-y6uptC85yK1A>
    <xmx:VBnvaBNjWke2ZSB7hU9b9v4tZKJmRY5102bFIXGUaotAZogNr2px-g>
    <xmx:VBnvaIQsmwO_NG5od-36dpgn90HJDeKZgxT-YIGfenm-3ZVCWm5M3w>
    <xmx:VBnvaPY-VVDE7oU4sa90cTmqk5FvfKikMNU1r-O4i_00TpOW8OOmxw>
    <xmx:VRnvaBNfm6tO8T7h877byhygZXegxDH8cJsIGhbxKCzppa-1XMvN6fPS>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 23:47:32 -0400 (EDT)
Date: Tue, 14 Oct 2025 20:47:12 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 03/17] btrfs: allow remapped chunks to have zero
 stripes
Message-ID: <20251015034712.GE1702774@zen.localdomain>
References: <20251009112814.13942-1-mark@harmstone.com>
 <20251009112814.13942-4-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009112814.13942-4-mark@harmstone.com>

On Thu, Oct 09, 2025 at 12:27:58PM +0100, Mark Harmstone wrote:
> When a chunk has been fully remapped, we are going to set its
> num_stripes to 0, as it will no longer represent a physical location on
> disk.
> 
> Change tree-checker to allow for this, and fix a couple of
> divide-by-zeroes seen elsewhere.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>

This one feels close to me but I still have a few reservations. Happy to
discuss the details a bit more, of course.

> ---
>  fs/btrfs/tree-checker.c | 65 ++++++++++++++++++++++++++++-------------
>  fs/btrfs/volumes.c      | 13 ++++++++-
>  2 files changed, 57 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 62f35338a555..59b1393e5018 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -816,6 +816,41 @@ static void chunk_err(const struct btrfs_fs_info *fs_info,
>  	va_end(args);
>  }
>  
> +static bool valid_stripe_count(u64 profile, u16 num_stripes,
> +			       u16 sub_stripes)
> +{
> +	switch (profile) {
> +	case BTRFS_BLOCK_GROUP_RAID0:
> +		return true;
> +	case BTRFS_BLOCK_GROUP_RAID10:
> +		return sub_stripes ==
> +			btrfs_raid_array[BTRFS_RAID_RAID10].sub_stripes;
> +	case BTRFS_BLOCK_GROUP_RAID1:
> +		return num_stripes ==
> +			btrfs_raid_array[BTRFS_RAID_RAID1].devs_min;
> +	case BTRFS_BLOCK_GROUP_RAID1C3:
> +		return num_stripes ==
> +			btrfs_raid_array[BTRFS_RAID_RAID1C3].devs_min;
> +	case BTRFS_BLOCK_GROUP_RAID1C4:
> +		return num_stripes ==
> +			btrfs_raid_array[BTRFS_RAID_RAID1C4].devs_min;
> +	case BTRFS_BLOCK_GROUP_RAID5:
> +		return num_stripes >=
> +			btrfs_raid_array[BTRFS_RAID_RAID5].devs_min;
> +	case BTRFS_BLOCK_GROUP_RAID6:
> +		return num_stripes >=
> +			btrfs_raid_array[BTRFS_RAID_RAID6].devs_min;
> +	case BTRFS_BLOCK_GROUP_DUP:
> +		return num_stripes ==
> +			btrfs_raid_array[BTRFS_RAID_DUP].dev_stripes;
> +	case 0: /* SINGLE */
> +		return num_stripes ==
> +			btrfs_raid_array[BTRFS_RAID_SINGLE].dev_stripes;
> +	default:
> +		BUG();
> +	}
> +}
> +
>  /*
>   * The common chunk check which could also work on super block sys chunk array.
>   *
> @@ -839,6 +874,7 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
>  	u64 features;
>  	u32 chunk_sector_size;
>  	bool mixed = false;
> +	bool remapped;
>  	int raid_index;
>  	int nparity;
>  	int ncopies;
> @@ -862,12 +898,14 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
>  	ncopies = btrfs_raid_array[raid_index].ncopies;
>  	nparity = btrfs_raid_array[raid_index].nparity;
>  
> -	if (unlikely(!num_stripes)) {
> +	remapped = type & BTRFS_BLOCK_GROUP_REMAPPED;
> +
> +	if (unlikely(!remapped && !num_stripes)) {
>  		chunk_err(fs_info, leaf, chunk, logical,
>  			  "invalid chunk num_stripes, have %u", num_stripes);
>  		return -EUCLEAN;
>  	}
> -	if (unlikely(num_stripes < ncopies)) {
> +	if (unlikely(num_stripes != 0 && num_stripes < ncopies)) {
>  		chunk_err(fs_info, leaf, chunk, logical,
>  			  "invalid chunk num_stripes < ncopies, have %u < %d",
>  			  num_stripes, ncopies);
> @@ -965,22 +1003,9 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
>  		}
>  	}
>  
> -	if (unlikely((type & BTRFS_BLOCK_GROUP_RAID10 &&
> -		      sub_stripes != btrfs_raid_array[BTRFS_RAID_RAID10].sub_stripes) ||
> -		     (type & BTRFS_BLOCK_GROUP_RAID1 &&
> -		      num_stripes != btrfs_raid_array[BTRFS_RAID_RAID1].devs_min) ||
> -		     (type & BTRFS_BLOCK_GROUP_RAID1C3 &&
> -		      num_stripes != btrfs_raid_array[BTRFS_RAID_RAID1C3].devs_min) ||
> -		     (type & BTRFS_BLOCK_GROUP_RAID1C4 &&
> -		      num_stripes != btrfs_raid_array[BTRFS_RAID_RAID1C4].devs_min) ||
> -		     (type & BTRFS_BLOCK_GROUP_RAID5 &&
> -		      num_stripes < btrfs_raid_array[BTRFS_RAID_RAID5].devs_min) ||
> -		     (type & BTRFS_BLOCK_GROUP_RAID6 &&
> -		      num_stripes < btrfs_raid_array[BTRFS_RAID_RAID6].devs_min) ||
> -		     (type & BTRFS_BLOCK_GROUP_DUP &&
> -		      num_stripes != btrfs_raid_array[BTRFS_RAID_DUP].dev_stripes) ||
> -		     ((type & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0 &&
> -		      num_stripes != btrfs_raid_array[BTRFS_RAID_SINGLE].dev_stripes))) {
> +	if (!remapped &&
> +	    !valid_stripe_count(type & BTRFS_BLOCK_GROUP_PROFILE_MASK,
> +				num_stripes, sub_stripes)) {

Is num_stripes == 0 valid for raid 0 aside from remapped?

>  		chunk_err(fs_info, leaf, chunk, logical,
>  			"invalid num_stripes:sub_stripes %u:%u for profile %llu",
>  			num_stripes, sub_stripes,
> @@ -1004,11 +1029,11 @@ static int check_leaf_chunk_item(struct extent_buffer *leaf,
>  	struct btrfs_fs_info *fs_info = leaf->fs_info;
>  	int num_stripes;
>  
> -	if (unlikely(btrfs_item_size(leaf, slot) < sizeof(struct btrfs_chunk))) {
> +	if (unlikely(btrfs_item_size(leaf, slot) < offsetof(struct btrfs_chunk, stripe))) {

Does this need a remapped parameter as part of the check too?

>  		chunk_err(fs_info, leaf, chunk, key->offset,
>  			"invalid chunk item size: have %u expect [%zu, %u)",
>  			btrfs_item_size(leaf, slot),
> -			sizeof(struct btrfs_chunk),
> +			offsetof(struct btrfs_chunk, stripe),
>  			BTRFS_LEAF_DATA_SIZE(fs_info));
>  		return -EUCLEAN;
>  	}
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index e14b86e2996b..6750f6f0af59 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6145,6 +6145,12 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
>  		goto out_free_map;
>  	}
>  
> +	/* avoid divide by zero on fully-remapped chunks */
> +	if (map->num_stripes == 0) {
> +		ret = -EOPNOTSUPP;
> +		goto out_free_map;
> +	}
> +

I'll reconsider this when I read the discard stuff more closely, but
aren't you intending to discard fully remapped chunks? So this seems
counter-intuitive at best. Since you tested it, I assume it must work,
just saying since it stuck out to me..

>  	offset = logical - map->start;
>  	length = min_t(u64, map->start + map->chunk_len - logical, length);
>  	*length_ret = length;
> @@ -7088,7 +7094,12 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
>  	 */
>  	map->sub_stripes = btrfs_raid_array[index].sub_stripes;
>  	map->verified_stripes = 0;
> -	map->stripe_size = btrfs_calc_stripe_length(map);
> +
> +	if (num_stripes > 0)
> +		map->stripe_size = btrfs_calc_stripe_length(map);
> +	else
> +		map->stripe_size = 0;
> +
>  	for (i = 0; i < num_stripes; i++) {
>  		map->stripes[i].physical =
>  			btrfs_stripe_offset_nr(leaf, chunk, i);
> -- 
> 2.49.1
> 

