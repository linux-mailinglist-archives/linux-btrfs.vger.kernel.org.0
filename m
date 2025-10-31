Return-Path: <linux-btrfs+bounces-18494-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CADC2718F
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 23:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A30C34E831F
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 22:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C18329E75;
	Fri, 31 Oct 2025 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="SeMCNRAX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gMVJ0CYD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D208A405F7
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 22:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761948189; cv=none; b=mk6LxgYIhjpYGHrb6WeKa0SaYshwfCZ0HyDXjjRm4k1XJcbp05NFAUNLoIcd1wGb39gaZ9uBGIosJLWd5wdo24qIwKA0pVU4vY98aJEZ+jm4LGHRCM0QGlLhtOcSotRR/b55xNdoFzRC/7IjDxgA+Zl9W8d4IK1lMC1vNf1cBfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761948189; c=relaxed/simple;
	bh=F3/bEEENnKkhNAY1Y8xuI1+H2Sru3vnqYAxfwkoTiGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfzOz9w08Ge+2UDCMPIjMX3mvbb1OSRrFg5gR3KIr3mQqVcNB+tNUCv4Gkk/e0JltH+ZPjIIu+vx08tvXcVwpKGo9pt0VX+K4nOgCU2gVRFko9cHbqjDQCLjC+uQAJv7yM4JvrQg+3zfOmviLVnztrpaD7GXviIvdLF5Iwp/YCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=SeMCNRAX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gMVJ0CYD; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B43B5EC01E7;
	Fri, 31 Oct 2025 18:03:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 31 Oct 2025 18:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761948183; x=1762034583; bh=5ekVrjbALN
	lB5Pj82OE8KmmTCiMP1GfVUSdBiJWvSxE=; b=SeMCNRAXAbUtx2bUFrN0S8YGOD
	6Pev7BOF2Z1nAXk8CGqaqeVXQxLGuJXRsYEIkshPSFj0N9pZ4UyteRmvi5VTjdv7
	i3leqn2ffYIMwd7agfvvYJ+RVo3/7gd+XoratAPog6oU+egOmyQHsLDlcxPUGUBs
	OLSF49X99kT+J+pC+qvbrzWmZeQrEo3gsj9Hi1WQG+fiJeIRC8EO5CmKJGXovxsM
	P3yAzfXTT/QcthdLKZ0SeUJOQUscd7izPK+73mTVWqtdBxdX6fxFT/VxrvYGrM0B
	nIxCrQaj2pWHa5tjMPWC0YP6n1HbhNBDjUibALyxokuIf6otgBaQvTHDptPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761948183; x=1762034583; bh=5ekVrjbALNlB5Pj82OE8KmmTCiMP1GfVUSd
	BiJWvSxE=; b=gMVJ0CYDgxWOwj355wb7PqAehJNDnKxq7m0Z+34vwNcBh2DqG6d
	q7kKMPQXQvLPIyHSphlp3lJ1R1sict6tPG0itxqILDoJ1giuXhsklDl9uyyB9HM8
	KRCrAMavv9+WguoSo1cXDCZGL7R4KC+ETfAp3dBvGJOcKdF4LCIymW7wk891zzw0
	mxIPk/Fw3KzLqFJpMq6g8EHeBUL5baG9fy1FKWTF54prYTpMfsVckBcOU3heEzlP
	XASAcxBOCE7+Of0py/dUu4LuVEpyNxh/nyqXUE0xnuxR5nZRjNvxruyaRXScn6QD
	j8l3GDRpRlCGZSD538FsCfVsa7BaHzF3fKg==
X-ME-Sender: <xms:FzIFaZ7DyscySmJ4SHTpw1VIsz2q4UlUwe9wCCH0H-PvSKcFDEBgfQ>
    <xme:FzIFac7dUG-fJ0vXpRYJckby0U3tsVKtVfpPlClUSD_a1ugjXla8T8MvyLyNAdmwu
    ZDS1vUB8PEkLvFhhrGfdEnFJbyZ2j3khjNdCh3FYJxapMXrNwVOJs4>
X-ME-Received: <xmr:FzIFaeF65l63GrySdfurKAi6ss0eVMDzR7TzLqEPYfOvoRz826Q1raG_ZpV6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FzIFadTAzgc-x8yX6KVJp70PGErl10Y9cczDqnZ1yPEyUu87lX9D1Q>
    <xmx:FzIFafsPfZn5z2CiPebtiw4TLZ8NMnnS3THPkAwmIJ-62Oy_sXCNHA>
    <xmx:FzIFaUw7l7kgzg4pk4gOIvFUMD97ycWmSL272mGzDTUwlwBl28k_eg>
    <xmx:FzIFaR46T1KadrhsR-VyFA3HCngvcZIIuuXa6EpzjpQkyXp6NYywwg>
    <xmx:FzIFaTsOOkY_uWU_uSP_b_aixvoGb3aDbXlSs1JWe17rbubp00T313Y9>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 18:03:03 -0400 (EDT)
Date: Fri, 31 Oct 2025 15:03:00 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 08/16] btrfs: redirect I/O for remapped block groups
Message-ID: <aQUyFCq35cRtOhrd@devvm12410.ftw0.facebook.com>
References: <20251024181227.32228-1-mark@harmstone.com>
 <20251024181227.32228-9-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024181227.32228-9-mark@harmstone.com>

On Fri, Oct 24, 2025 at 07:12:09PM +0100, Mark Harmstone wrote:
> Change btrfs_map_block() so that if the block group has the REMAPPED
> flag set, we call btrfs_translate_remap() to obtain a new address.
> 
> btrfs_translate_remap() searches the remap tree for a range
> corresponding to the logical address passed to btrfs_map_block(). If it
> is within an identity remap, this part of the block group hasn't yet
> been relocated, and so we use the existing address.
> 
> If it is within an actual remap, we subtract the start of the remap
> range and add the address of its destination, contained in the item's
> payload.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/relocation.c | 54 +++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/relocation.h |  2 ++
>  fs/btrfs/volumes.c    | 19 +++++++++++++++
>  3 files changed, 75 insertions(+)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 96539e8b7b4b..a8abe24de8d7 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3870,6 +3870,60 @@ static const char *stage_to_string(enum reloc_stage stage)
>  	return "unknown";
>  }
>  
> +int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
> +			  u64 *length)
> +{
> +	int ret;
> +	struct btrfs_key key, found_key;
> +	struct extent_buffer *leaf;
> +	struct btrfs_remap *remap;
> +	BTRFS_PATH_AUTO_FREE(path);
> +
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	key.objectid = *logical;
> +	key.type = (u8)-1;
> +	key.offset = (u64)-1;
> +
> +	ret = btrfs_search_slot(NULL, fs_info->remap_root, &key, path,
> +				0, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	leaf = path->nodes[0];
> +
> +	if (path->slots[0] == 0)
> +		return -ENOENT;
> +
> +	path->slots[0]--;
> +
> +	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> +
> +	if (found_key.type != BTRFS_REMAP_KEY &&
> +	    found_key.type != BTRFS_IDENTITY_REMAP_KEY) {
> +		return -ENOENT;
> +	}
> +
> +	if (found_key.objectid > *logical ||
> +	    found_key.objectid + found_key.offset <= *logical) {
> +		return -ENOENT;
> +	}
> +
> +	if (*logical + *length > found_key.objectid + found_key.offset)
> +		*length = found_key.objectid + found_key.offset - *logical;
> +
> +	if (found_key.type == BTRFS_IDENTITY_REMAP_KEY)
> +		return 0;
> +
> +	remap = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_remap);
> +
> +	*logical += btrfs_remap_address(leaf, remap) - found_key.objectid;
> +
> +	return 0;
> +}
> +
>  /*
>   * function to relocate all extents in a block group.
>   */
> diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
> index 5c36b3f84b57..b2ba83966650 100644
> --- a/fs/btrfs/relocation.h
> +++ b/fs/btrfs/relocation.h
> @@ -31,5 +31,7 @@ int btrfs_should_cancel_balance(const struct btrfs_fs_info *fs_info);
>  struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info, u64 bytenr);
>  bool btrfs_should_ignore_reloc_root(const struct btrfs_root *root);
>  u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_fs_info *fs_info);
> +int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
> +			  u64 *length);
>  
>  #endif
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 7b2bec28dbd7..d117f74e08c1 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6598,6 +6598,25 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>  	if (IS_ERR(map))
>  		return PTR_ERR(map);
>  
> +	if (map->type & BTRFS_BLOCK_GROUP_REMAPPED) {
> +		u64 new_logical = logical;
> +
> +		ret = btrfs_translate_remap(fs_info, &new_logical, length);
> +		if (ret)
> +			return ret;
> +
> +		if (new_logical != logical) {
> +			btrfs_free_chunk_map(map);
> +
> +			map = btrfs_get_chunk_map(fs_info, new_logical,
> +						  *length);
> +			if (IS_ERR(map))
> +				return PTR_ERR(map);
> +
> +			logical = new_logical;
> +		}
> +	}
> +
>  	num_copies = btrfs_chunk_map_num_copies(map);
>  	if (io_geom.mirror_num > num_copies)
>  		return -EINVAL;
> -- 
> 2.49.1
> 

