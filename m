Return-Path: <linux-btrfs+bounces-16100-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69684B288FE
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 02:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD301D042F6
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 00:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E904A33;
	Sat, 16 Aug 2025 00:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="n8ilWKVx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fv+CngQD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6738038B
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Aug 2025 00:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302554; cv=none; b=TT/bezL9+YGlqqj9bI72aRAG/nFhYJG3ZTKZp14PFPiT1DS8qniWMCikeDrftK869Umg4D8NniVlJTaCIfrMqXBA1XCyVanXLByCckzUyBxupavyReNuPyPe6O2FqvPxVDLYMQ92X8eRE3NTVh3eJhL6EDzOKnW+mcGxT+uYFyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302554; c=relaxed/simple;
	bh=FR8eK/hwH5YOdNoFgIHaiYyfNZ2d9AN+B0DKIYOLfcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2VSZByll0bo20km6f07I9rkHdbYFI+hHFIVhBURK77uXOMLF3xSu8l4J7fLeQHjnmYUT3T+MND8yNfdmawFYc3AZbJ8VUY7EdZgvYt0XK7pxON16rygXlquiJvg4bVMdKLLPQN29rhrgs1YQVb4uPwuvreDyQzeIbkX7ngsHWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=n8ilWKVx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fv+CngQD; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 65B691D0020F;
	Fri, 15 Aug 2025 20:02:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 15 Aug 2025 20:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1755302550; x=1755388950; bh=o3j+8UmivW
	L7OnccBfgEcAniYIAms+HIhzzhBxbBpOQ=; b=n8ilWKVxEWI7y0LePvi5CPOBzA
	pv399Ucasyg+3zdvAjUZYABxmDkJqFLOsUW2c1Mcau78+9oTpmrUaoT/wH6gOds/
	+EuihZ3+rhRNVrszvTs8Mk8Q/mFLn+qaGGh7MEacHBUl+Y2XN2id5v/Ezb5Kb7RI
	bOAUL+Kco+opgZf5vPkPKLIRTtF8NuDPDSTuE+nUmlo9jtaM+Ta4SdOnCF740Z2K
	IqVElia+E0VamULt80j3xB5p+0DguR3ztycN78eaHcu9Nc8hreG8nIvCewpSBamy
	AcIZD3Pjg99XsNznEfPo3Ba+kWXqbFp7xl08AehAUFJs0zu9zA3Nn+k2NqaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755302550; x=1755388950; bh=o3j+8UmivWL7OnccBfgEcAniYIAms+HIhzz
	hBxbBpOQ=; b=fv+CngQDrM5a7Cgf68e/WdcwRfOrYiuqJKAkbFx9FzFN8Xc6wa1
	r0OaI0UFx/Or3kcHNU224TBWVcU2S2thzLgsU74oH5A9S/Yyfr+j2a4EXG5mPFnL
	ijcEGPWYKB8yWX8wNdqtxbVzWNbIOwAqFcexnaek7NtsRGevAQWuEnXqU870PzfR
	YIaRInfqIK9/YQGuqepEy+pCNdM+RGP36yAHEfJgQxCPg/R/TTdST0QFVdA+MRTT
	Y2Qn6YRflFBCDY8CWCNok1Fo3etXGJscT+cf8qSha7jIJUakiyKejUQtwL1ovhLH
	+VfdLpzBp1jhcc6bMEn5PyzhOO4/FpF5eiA==
X-ME-Sender: <xms:lsqfaFmUH5yj1S1nuM-iuPBJXTpmyf86O5ppcw_b8dzpd5jPcIofiw>
    <xme:lsqfaBAWD_2tiVEZBq-qVPo3pbaBrMA9rcJBYEMGA-zT1-3csWkks-mLK40ZYb2yS
    olbJ4MqngmU2_P2hOo>
X-ME-Received: <xmr:lsqfaNcN2asqrccMwasFEPn74PwzbfiuAmihUtclMIJix4gdjPZkHeOzSoGMMpjPdFM5NQYcKyLNNBYYkltxDDTWfSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:lsqfaEKM1EuhJZoPDnk_YJ0X4xgEgTyZQcN_rpS3KvHEnTi0SbOFlg>
    <xmx:lsqfaIfv8mWhAn9aKk1es0zrmEp8AcBBtp9VCsqijMSFacD9TgZ0og>
    <xmx:lsqfaD35q2nHVk4fNp_VTE9YMbfRKLvWAIxNI0ChCdjSv7DmEmMI9A>
    <xmx:lsqfaJjkM9zPGf5-uHeiXNiD9UKZ5akasw7PdLF7eFoKYAmtX5Ph9w>
    <xmx:lsqfaJp-9TiA6OwAISon0ngwnNSQm6O6RTIBGIhl5H_zkN0xsoDRZ3FN>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 20:02:29 -0400 (EDT)
Date: Fri, 15 Aug 2025 17:03:10 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 03/16] btrfs: allow remapped chunks to have zero
 stripes
Message-ID: <20250816000310.GB3042054@zen.localdomain>
References: <20250813143509.31073-1-mark@harmstone.com>
 <20250813143509.31073-4-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813143509.31073-4-mark@harmstone.com>

On Wed, Aug 13, 2025 at 03:34:45PM +0100, Mark Harmstone wrote:
> When a chunk has been fully remapped, we are going to set its
> num_stripes to 0, as it will no longer represent a physical location on
> disk.
> 
> Change tree-checker to allow for this, and fix a couple of
> divide-by-zeroes seen elsewhere.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> ---
>  fs/btrfs/tree-checker.c | 63 ++++++++++++++++++++++++++++-------------
>  fs/btrfs/volumes.c      |  8 +++++-
>  2 files changed, 50 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index ca898b1f12f1..20bfe333ffdd 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -815,6 +815,39 @@ static void chunk_err(const struct btrfs_fs_info *fs_info,
>  	va_end(args);
>  }
>  
> +static bool valid_stripe_count(u64 profile, u16 num_stripes,
> +			       u16 sub_stripes)
> +{
> +	switch (profile) {
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
> @@ -838,6 +871,7 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
>  	u64 features;
>  	u32 chunk_sector_size;
>  	bool mixed = false;
> +	bool remapped;
>  	int raid_index;
>  	int nparity;
>  	int ncopies;
> @@ -861,12 +895,14 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
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

This relying on the above check for the remapped <=> !num_stripes aspect
was still kinda confusing. Logically looks good now, though.

>  		chunk_err(fs_info, leaf, chunk, logical,
>  			  "invalid chunk num_stripes < ncopies, have %u < %d",
>  			  num_stripes, ncopies);
> @@ -964,22 +1000,9 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
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

This looks great, thanks.

>  		chunk_err(fs_info, leaf, chunk, logical,
>  			"invalid num_stripes:sub_stripes %u:%u for profile %llu",
>  			num_stripes, sub_stripes,
> @@ -1003,11 +1026,11 @@ static int check_leaf_chunk_item(struct extent_buffer *leaf,
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
> index f4d1527f265e..c95f83305c82 100644
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
>  	offset = logical - map->start;
>  	length = min_t(u64, map->start + map->chunk_len - logical, length);
>  	*length_ret = length;
> @@ -6965,7 +6971,7 @@ u64 btrfs_calc_stripe_length(const struct btrfs_chunk_map *map)
>  {
>  	const int data_stripes = calc_data_stripes(map->type, map->num_stripes);
>  
> -	return div_u64(map->chunk_len, data_stripes);
> +	return data_stripes ? div_u64(map->chunk_len, data_stripes) : 0;

My point here was more that we are now including 0 in the range of this
function, where it wasn't before, meaning that callers must properly
handle it. And it's not a meaningful "stripe length", so it breaks that
correspondence, so checking explicitly for "remapped-ness" vs. "length
== 0" feels more robust to me.

I won't die on this hill, just making myself as clear as I can.

>  }
>  
>  #if BITS_PER_LONG == 32
> -- 
> 2.49.1
> 

