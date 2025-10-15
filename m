Return-Path: <linux-btrfs+bounces-17807-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A40FBDC735
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 06:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C2D64EB75B
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 04:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E65B2F25EA;
	Wed, 15 Oct 2025 04:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="kW0Rm1wK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x17nihVS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6B2272E4E
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 04:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760502120; cv=none; b=R8aavgFvcEtkaZQbc575Z1BCmyGw8ds6HYCqclthwlmfLAPFsTksK8NmOIgL4wZWkCu0Moy2EV+cWBDfba0mMuTkw1pZbx1dYx4/u+hK63B6AS5uUUtxn8kwJ1NktA+4mqBhjQXRM6PUHs5wvMnlDOVcQrEgMGpKGjlOCNTDABM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760502120; c=relaxed/simple;
	bh=aBzfZe5b967ksbuXDctPgVLl7zPb2eQ/N3CS81l14T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhsxVvO4UqJsut+fu3Dlb5fa7efyVIend6cUZdLGZUoU2vV4zWdl3IbkFMQ4nXQtzH2E3Nz6eBmghZqEZHePA4izcQKA1BNFOGl/LDxd69c1IxWcE7iNAWu6QLL49vUchjynCAudBU7Nx1PRgyPvTf0vLPakIxJSvd5WQKrRNSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=kW0Rm1wK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x17nihVS; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 838B21400157;
	Wed, 15 Oct 2025 00:21:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 15 Oct 2025 00:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1760502117; x=1760588517; bh=vd88C+8ikz
	ks5gIYZWI4sezD4N0GfsD9aPzF4iFQogU=; b=kW0Rm1wKPfWpKItca8+RaRGx7/
	NBBGdCIKgjqkr5mF52ipowUyXqEny2tKdo66OdlbD/ZJpsEtjj2HZD04pLfDlLcG
	h2S67gBKtOYTFIU7uKmJDYtsjNQPVUmgBEBciA0+PNZpX8rr0mUW4WnUA+b59a9L
	u+Wn7s/mpGCThGCuuaxXtmDTT/HkTx9QAcMSbK8sUx7FRdkwvvMdvUFv17o3W5z+
	tLymUnk0Br8TVa1/gNQK8dWREFTKhXNBQBmxfOdzSvrC+F+8BHGPdu3+W8QoURo+
	LntpMpbYvSv8SU9bdMwuKHVHwF0XoR4R62i+0U53Lx6aPe2ZEESTxtg9Fqpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760502117; x=1760588517; bh=vd88C+8ikzks5gIYZWI4sezD4N0GfsD9aPz
	F4iFQogU=; b=x17nihVSKSIwhS/a24arA+NZNwuPxXi2G6rGsnom9IM9obJSQIE
	vHf6ISEayXwT7/Rcj6eC7rsk5LvhKK0zTEaZ9RJMZu7oL2osafYwFGKKSQlV5FlU
	7U7AxduYcMZVDClcSKWN5HwNs2Is/0EoAitibag3zLiZy0b5XNQQOr6rWjUC2RcQ
	nsSmxUS3OSEWSw/Etvr0MdgB4plH+r4U9x2yBEdmdu8oLJehaqzbaXFunTEKkVpQ
	euLLRbe10SY4ACzv5CUwPNy0g6l3/mLYveKLQRRp3G+c4cIBSb7Amn9x9uG7GGbz
	lxfgawrwU5zfVveb/IcvIfZfajm3SgC80zg==
X-ME-Sender: <xms:ZSHvaGHaw9X1lAxRoyvU76xNQDdhgwp8YILaWl8r5Oa-Su-1ZdXFNQ>
    <xme:ZSHvaNXAlkJWGsYN6OqvdXwQ8aTQVEX7MioTK1d8Vb4F1Sel-LkA72Y745ULFY4mD
    aalPgRKWnuaSS2RTC7TiZwgz7BwrNIvCaNfVXMod5ePkd1qZKhdMU4>
X-ME-Received: <xmr:ZSHvaNxuFHq9eLRmauPTM1x_ypM9c4OSih67X_gUQhzQ-wYoYEiNhTBMJHdAFtMZUTCq1z9aVu4uQUa9G6bDa-ZwBA4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZSHvaLMk93gex05YHkwYKbXq6ovEkLaUJz9p6QRAMempSe0pRZ28Cg>
    <xmx:ZSHvaO7v_YSmwunwUboyMhcA1bL3Cfpb4NFJ6HcWjepjIMuzsA07cg>
    <xmx:ZSHvaMPnrvbFcceFuOItqB7Kdg9BMZ5Ht6IdpoV2bFgJkFo9AqVWpQ>
    <xmx:ZSHvaMmSCsqN6-Kb_3FNUtF8SlKbAKhGXf8qxmIYwZiO3Ry4tTPbeg>
    <xmx:ZSHvaDYlbWkXD33UJTMem5v8fsFPD6EalENQvN5Svr02Hn3btp2ZD-Ir>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 00:21:56 -0400 (EDT)
Date: Tue, 14 Oct 2025 21:21:36 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 08/17] btrfs: redirect I/O for remapped block groups
Message-ID: <20251015042136.GG1702774@zen.localdomain>
References: <20251009112814.13942-1-mark@harmstone.com>
 <20251009112814.13942-9-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009112814.13942-9-mark@harmstone.com>

On Thu, Oct 09, 2025 at 12:28:03PM +0100, Mark Harmstone wrote:
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
> ---
>  fs/btrfs/relocation.c | 59 +++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/relocation.h |  2 ++
>  fs/btrfs/volumes.c    | 31 +++++++++++++++++++++++
>  3 files changed, 92 insertions(+)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 748290758459..4f5d3aaf0f65 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3870,6 +3870,65 @@ static const char *stage_to_string(enum reloc_stage stage)
>  	return "unknown";
>  }
>  
> +int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
> +			  u64 *length, bool nolock)
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
> +	if (nolock) {
> +		path->search_commit_root = 1;
> +		path->skip_locking = 1;
> +	}
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
> index 5c36b3f84b57..a653c42a25a3 100644
> --- a/fs/btrfs/relocation.h
> +++ b/fs/btrfs/relocation.h
> @@ -31,5 +31,7 @@ int btrfs_should_cancel_balance(const struct btrfs_fs_info *fs_info);
>  struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info, u64 bytenr);
>  bool btrfs_should_ignore_reloc_root(const struct btrfs_root *root);
>  u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_fs_info *fs_info);
> +int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
> +			  u64 *length, bool nolock);
>  
>  #endif
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 0abe02a7072f..f2d1203778aa 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6635,6 +6635,37 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>  	if (IS_ERR(map))
>  		return PTR_ERR(map);
>  
> +	if (map->type & BTRFS_BLOCK_GROUP_REMAPPED) {
> +		u64 new_logical = logical;
> +		bool nolock = !(map->type & BTRFS_BLOCK_GROUP_DATA);

Why not data?

> +
> +		/*
> +		 * We use search_commit_root in btrfs_translate_remap for
> +		 * metadata blocks, to avoid lockdep complaining about
> +		 * recursive locking.
> +		 * If we get -ENOENT this means this is a BG that has just had
> +		 * its REMAPPED flag set, and so nothing has yet been actually
> +		 * remapped.
> +		 */

I'm actually kind of worried about this now. What is preventing the
following racy interleaving:

      T1                                         T2
                                        start_block_group_remapping() // in TXN-K set REMAPPED
btrfs_map_block()
  btrfs_translate_remap()
    ENOENT // searched in commit root
                                        do_remap_tree_reloc() // in TXN-K do all remaps
                                        // fully remapped, removed, discarded
                                        // TXN-K committed
  // not remapped! but the original chunk map is gone gone
  num_copies = ...

> +		ret = btrfs_translate_remap(fs_info, &new_logical, length,
> +					    nolock);
> +		if (ret && (!nolock || ret != -ENOENT))
> +			return ret;
> +
> +		if (ret != -ENOENT && new_logical != logical) {
> +			btrfs_free_chunk_map(map);
> +
> +			map = btrfs_get_chunk_map(fs_info, new_logical,
> +						  *length);
> +			if (IS_ERR(map))
> +				return PTR_ERR(map);
> +
> +			logical = new_logical;
> +		}
> +
> +		ret = 0;
> +	}
> +
>  	num_copies = btrfs_chunk_map_num_copies(map);
>  	if (io_geom.mirror_num > num_copies)
>  		return -EINVAL;
> -- 
> 2.49.1
> 

