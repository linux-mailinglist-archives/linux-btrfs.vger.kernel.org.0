Return-Path: <linux-btrfs+bounces-18488-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4754CC270ED
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 22:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6748C18922D6
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 21:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4105A31076B;
	Fri, 31 Oct 2025 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="saQsJf71";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vFigOaER"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1795E1DDC37
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761946807; cv=none; b=Vu/uNK1D1cDu7cgBBUV8L94bi/jmMZHNbFDxRcmU4Zk10YYmfjeTZ3teTywAk7dl+Rmtp4cUV/Y2x/psYoAWtyaalM4D0cygrTpm3POpplA9h9hkBwQD0XSkX7F4/zTE0GVlz52mQuVXlnlaoI7iORCgL5+7yVmEq07vgJ/GEFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761946807; c=relaxed/simple;
	bh=SZqtripQ3k9QU7pwKO3xfIvp1tOw3Kl/aarKpf7M0v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjdpgDFqroSCZVXO5XuQx5EtouKVDRKNlaWHwV96HsxBcUlMXhhNr39CcFOQMXl7TER0HyPXO+INc1AyUrm/KarCiqhgQzJSvV+Gfh9FMdKt+rxkryY7YiCleQiOd7/h//63/J1Mj4a0PXvGKr1kQNWau25TBJoUAP5kRazBcCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=saQsJf71; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vFigOaER; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D6FC214000D7;
	Fri, 31 Oct 2025 17:40:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 31 Oct 2025 17:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761946801; x=1762033201; bh=iZnMOkNxix
	jjV5zN3tUZ1dA0bv/0Ax36zetyLTH5z5k=; b=saQsJf71l9hCWHVN6uW8McRymx
	f4Ivh3HkJJEmzna+ULv9ogE9rRL60bzVy/eHLZ6/uMxO6eONBwfR285s/ZowyRPr
	gmibtGYG+lsmuvpYVoM0TRtX0Y+/4q04g2IA95JV2kms1OK9LaebLlXiPQunLKCy
	2V488ihIPUcDfYhEzh64o4z7S+oWFoe97yuNrCgOJmw7KAtYmPt+t/5aC7uTpwnH
	qBMutCqhLCRhszGItN95GPckii70Q2UhLKtwnQYJqMYppqS1HxcIcmrdPSJ1nAdm
	tC+9bAM6YmRVXbAlTrSf7x4nRFJnNgIviDM7ZnR/b67SqyUUJzospb4WDCVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761946801; x=1762033201; bh=iZnMOkNxixjjV5zN3tUZ1dA0bv/0Ax36zet
	yLTH5z5k=; b=vFigOaERIWF9BITwW+mIN+WMsc6bmV9qsLFBNAEVJ5p7xckAupd
	PuXWhcOYrsVJofBSmtx14xF8Gs6J/nFPYNAaNSu043xvbT658R9NzKpcIagut7D3
	0LVurNmk3lHJ/J4WimR+TT3Kw+gjR4qnPUomZp0cPPNINDfinsVVBte2qBii0GyV
	6/65HfndL6V//k7XnjCW9YGbd7/OShym1NjQsstoC3U81Plyso7oAfLn+XxKiaRU
	u/cWJUq/QmLZS65qqAV8YNj4fUk75AN4ohqu9bC6TTGq2u2jnyenLHGtJYnut4a8
	o42DtyyVbAid/O4Wr4QQ1BuCJvQHym3VeHQ==
X-ME-Sender: <xms:sSwFaWqVN9xr4hlSP0UyGGRXA7xGEeZLSQlr8P5LUtDXLiayg-FlyA>
    <xme:sSwFaap5MzYp78CXJZOWIE9VKWs7awSQgthCqHA1y1a5_1MQHfAv6DV1H048X3t0q
    X9uHoTEfbhkrQYdQqE4I43roRnvOi-C-QUjDAkJREpNXRlbgDspbI4>
X-ME-Received: <xmr:sSwFaY1_OhzV356ZqkXqx2qMvvEZDvUXCKm8MHqD7nUmD4IYzwFyRM9vddtJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedtheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sSwFaRBGV5ege_uNMVa7-LOpOwDnMkKZAt3q1-5BnFFQTH6HvRLdrw>
    <xmx:sSwFaYeyoTkZNKlAyS0h41EIABdwuDZ5g1kRaYP-9woW9a3DmYbpxQ>
    <xmx:sSwFaeg4ShSSXz9kJviRcrg1d5A076d2NHFm_zsoqshshr60uzsIQA>
    <xmx:sSwFaYpdL9Rd3noOpzJSuIRzGR9hoAMCUma1qYB3pewxv3J2ed-iVw>
    <xmx:sSwFaadX7D2xf8jk2r0SZeegS_KrN5R3_o_s8ZCgeBDLM_6TtXFUvEjT>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 17:40:00 -0400 (EDT)
Date: Fri, 31 Oct 2025 14:39:58 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 03/16] btrfs: allow remapped chunks to have zero
 stripes
Message-ID: <aQUsoIndrcguYvO0@devvm12410.ftw0.facebook.com>
References: <20251024181227.32228-1-mark@harmstone.com>
 <20251024181227.32228-4-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024181227.32228-4-mark@harmstone.com>

On Fri, Oct 24, 2025 at 07:12:04PM +0100, Mark Harmstone wrote:
> When a chunk has been fully remapped, we are going to set its
> num_stripes to 0, as it will no longer represent a physical location on
> disk.
> 
> Change tree-checker to allow for this, and fix read_one_chunk() to avoid
> a divide by zero.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/tree-checker.c | 65 ++++++++++++++++++++++++++++-------------
>  fs/btrfs/volumes.c      |  7 ++++-
>  2 files changed, 51 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 681c5c7fae35..b6827c2a7815 100644
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
>  		chunk_err(fs_info, leaf, chunk, logical,
>  			"invalid num_stripes:sub_stripes %u:%u for profile %llu",
>  			num_stripes, sub_stripes,
> @@ -1004,11 +1029,11 @@ static int check_leaf_chunk_item(struct extent_buffer *leaf,
>  	struct btrfs_fs_info *fs_info = leaf->fs_info;
>  	int num_stripes;
>  
> -	if (unlikely(btrfs_item_size(leaf, slot) < sizeof(struct btrfs_chunk))) {
> +	if (unlikely(btrfs_item_size(leaf, slot) < offsetof(struct btrfs_chunk, stripe))) {
>  		chunk_err(fs_info, leaf, chunk, key->offset,
>  			"invalid chunk item size: have %u expect [%zu, %u)",
>  			btrfs_item_size(leaf, slot),
> -			sizeof(struct btrfs_chunk),
> +			offsetof(struct btrfs_chunk, stripe),
>  			BTRFS_LEAF_DATA_SIZE(fs_info));
>  		return -EUCLEAN;
>  	}
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 82b8189f3e81..8a9bff0426ae 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7059,7 +7059,12 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
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

