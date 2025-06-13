Return-Path: <linux-btrfs+bounces-14653-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00D5AD9772
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 23:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4208C7A4C92
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 21:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66BD28D8E6;
	Fri, 13 Jun 2025 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="dwhSPGiQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rP9An7Q1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9363528D859
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Jun 2025 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851005; cv=none; b=J92QHD+0dsZrfpQPNBvXmqNvV2uhmqPRlLn5jQIF7jn4QSQG/6LcANO27eG/MuZPrTjLHTwLn33upXa8mzrM2e3TpG/opPmmjcJxWO7e9Y/DjmNz8UwS1azrea9BrxcrF2Jd12S1WRkof8Lvi3ZjCMqOVByyRDJJ7LeZKluXc3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851005; c=relaxed/simple;
	bh=wC0VfCsV07ASe4k73DAAYWOc8aMS2E/E6UOh/T3AcsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfzpG+CeOdfU1p21VkCUCXwqyWtdF+nzk8XpeaRy0V5mslqJcMIHIMxprmE2w8XgZHu9kRFX+JWSLl5x0v774WSwykYW2qFVc+EMsxuBYXBcuvqIRX8yQZhUCT0zHPNFexBmTKUWiobSIwkLPC3v8kI/YiMUUujn1/4Z2b3eOWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=dwhSPGiQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rP9An7Q1; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2A2AC11400C3;
	Fri, 13 Jun 2025 17:41:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 13 Jun 2025 17:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1749850887; x=1749937287; bh=JcXVfUEydt
	WJjJQ2NMQFlVxAdu9L/HLVlp5KDkdnEt4=; b=dwhSPGiQjV9upUZA9xvF0fXofS
	US+qpvBiMiqyj5vkKhEqRaGPGLPKsyeHmMWe2XVsTd6lDCTd6j9/HpnKEyPiau2A
	zbSKYJ1y+V24pV70mvLi3aIEzNolSp4YpYypR+fzBYekrV7puUy3XVn5/uM9z9s9
	Lc7C89B/wV+4fxpucZ4NTO9fCL5PjB8E8Nmktw/W7zzZ20NOAZsXC52/erYAO+lo
	IRkqx7IZmnwLI8xHdvhWCmF8d0oGvTWJ577M5P0vNbV6Oh/JC+Ti9kxZfpy+0ZWD
	9mdkuzbQGav8RM+DEhX6i2EXvQ0rsZj52iYHxyMzTPmNoJRT8IT+87nyD+RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749850887; x=1749937287; bh=JcXVfUEydtWJjJQ2NMQFlVxAdu9L/HLVlp5
	KDkdnEt4=; b=rP9An7Q1NQkm8wuLidQtvbKGNa5Z3+Tz/VaH2Dq9bxzAdE1UOL6
	cjl6DUOmTDqKi7A7tqhoAXQHR47rU/1d3fDPMo0MI0fgEx9gePp9H6UGPT8ifJPc
	ptkhyybiZYIQBPJfVDszJRRLHnI4U1aoc9QPfRQmqBoVoNnwK2rYEw1xHPj6IQd5
	mhQdc/XU6iuCdlcTK2DMgB0Ep3468nzQYM3cCPVLsKg4KFgD42A2YRd1nWMBh8D8
	MIxwI42zwizZ2YF8tseFEHs+G4VESXLud9UP2mliEHpYAvm2lH9fT9l0soo0qs03
	cxdyQOjWpVaiJRpR2qexzRtW0rzmrGiumNQ==
X-ME-Sender: <xms:B5tMaKG0a9JveGYW04iXXhB6TW7aKpJXFxmfWr01Zf-4kTocoWBPsg>
    <xme:B5tMaLWqhsbLUHmv16xYw0OQFcy9NipnWRKwsLTQeh1lktj5Q9NkoBqq7UUAoWp8R
    m0rgDIcoErWo3woQNI>
X-ME-Received: <xmr:B5tMaEKl8dAiGGK-DNyQrEwWlXXPlMC76AgjfrCF-bKkR86YU49FkHKi1qKhxwP3TRSK32pcpXybTfZWdSDN36Y0jEY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduledthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfg
    uefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmrghhrghrmhhsthhonhgvsehfsgdrtghomhdprh
    gtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:B5tMaEEVGOsLQ7rAe_JJEZFBAn06I-RwOiNEwqkns2gylJLG9NKHIQ>
    <xmx:B5tMaAU3ie6H8i7XECDWK68bbeLLOkOf8oYD3IVEKuqsDKzv_TR-Rw>
    <xmx:B5tMaHOHXWcKpSypFtkvOOPrIKpwkLXyknj9Ugaru4Tp_aXXX_zY-A>
    <xmx:B5tMaH2PJRUdnjsE65bNTUZfw8nIJnbqXgw4YuJ7_wKIPE_oVRNN9w>
    <xmx:B5tMaDqBgV5lp5mJR7RRPLv73NzbtqjjSm33uNMsCDhEkANVHhvG7SwN>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jun 2025 17:41:26 -0400 (EDT)
Date: Fri, 13 Jun 2025 14:41:07 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/12] btrfs: allow remapped chunks to have zero stripes
Message-ID: <20250613214107.GC3621880@zen.localdomain>
References: <20250605162345.2561026-1-maharmstone@fb.com>
 <20250605162345.2561026-4-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605162345.2561026-4-maharmstone@fb.com>

On Thu, Jun 05, 2025 at 05:23:33PM +0100, Mark Harmstone wrote:
> When a chunk has been fully remapped, we are going to set its
> num_stripes to 0, as it will no longer represent a physical location on
> disk.
> 
> Change tree-checker to allow for this, and fix a couple of
> divide-by-zeroes seen elsewhere.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>  fs/btrfs/tree-checker.c | 16 +++++++++-------
>  fs/btrfs/volumes.c      |  8 +++++++-
>  2 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 0505f8d76581..fd83df06e3fb 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -829,7 +829,7 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
>  	u64 type;
>  	u64 features;
>  	u32 chunk_sector_size;
> -	bool mixed = false;
> +	bool mixed = false, remapped;

nit:
I *personally* don't like such declarations. I think they are lightly if
not decisively discouraged in the Linux Coding Style document as well
(at least to my reading). In our code, I found some examples where they
are used where both values are related and get assigned. But I haven't
seen any like this for unrelated variables with mixed assignment.

>  	int raid_index;
>  	int nparity;
>  	int ncopies;
> @@ -853,12 +853,14 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info, >  	ncopies = btrfs_raid_array[raid_index].ncopies;
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
> +	if (unlikely(!remapped && num_stripes < ncopies)) {

I think remapped only permits you exactly num_stripes == 0, not
num_stripes = 2 if ncopies = 3, right? Though it makes the logic less
neat, I would make the check as precise as possible on the invariants.

>  		chunk_err(fs_info, leaf, chunk, logical,
>  			  "invalid chunk num_stripes < ncopies, have %u < %d",
>  			  num_stripes, ncopies);
> @@ -960,7 +962,7 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
>  		}
>  	}
>  
> -	if (unlikely((type & BTRFS_BLOCK_GROUP_RAID10 &&
> +	if (unlikely(!remapped && ((type & BTRFS_BLOCK_GROUP_RAID10 &&
>  		      sub_stripes != btrfs_raid_array[BTRFS_RAID_RAID10].sub_stripes) ||
>  		     (type & BTRFS_BLOCK_GROUP_RAID1 &&
>  		      num_stripes != btrfs_raid_array[BTRFS_RAID_RAID1].devs_min) ||
> @@ -975,7 +977,7 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
>  		     (type & BTRFS_BLOCK_GROUP_DUP &&
>  		      num_stripes != btrfs_raid_array[BTRFS_RAID_DUP].dev_stripes) ||
>  		     ((type & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0 &&
> -		      num_stripes != btrfs_raid_array[BTRFS_RAID_SINGLE].dev_stripes))) {
> +		      num_stripes != btrfs_raid_array[BTRFS_RAID_SINGLE].dev_stripes)))) {
>  		chunk_err(fs_info, leaf, chunk, logical,
>  			"invalid num_stripes:sub_stripes %u:%u for profile %llu",
>  			num_stripes, sub_stripes,
> @@ -999,11 +1001,11 @@ static int check_leaf_chunk_item(struct extent_buffer *leaf,
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

Same complaint as above for nstripes < ncopies. Is there some way to
more generically bypass stripe checking if we detect the case we care
about: (remapped && num_stripes == 0) ?

>  	}
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index e7c467b6af46..9159d11cb143 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6133,6 +6133,12 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
>  		goto out_free_map;
>  	}
>  
> +	/* avoid divide by zero on fully-remapped chunks */
> +	if (map->num_stripes == 0) {
> +		ret = -EOPNOTSUPP;
> +		goto out_free_map;
> +	}
> +

This seems kinda sketchy to me. Presumably once we have remapped a block
group, we do want to discard it. But this makes that impossible? Does
the discarding happen before we set num_stripes to 0? Even with
discard=async?

>  	offset = logical - map->start;
>  	length = min_t(u64, map->start + map->chunk_len - logical, length);
>  	*length_ret = length;
> @@ -6953,7 +6959,7 @@ u64 btrfs_calc_stripe_length(const struct btrfs_chunk_map *map)
>  {
>  	const int data_stripes = calc_data_stripes(map->type, map->num_stripes);
>  
> -	return div_u64(map->chunk_len, data_stripes);
> +	return data_stripes ? div_u64(map->chunk_len, data_stripes) : 0;

Rather than making 0 a special value meaning remapped, would it be
useful/clearer to also include a remapped flag on the btrfs_chunk_map?
This function would have to behave the same way, presumably, but it
would be less implicit, and we could make assertions on chunk maps that
they have 0 stripes iff remapped at various places where we use the
stripe length. That would raise confidence that all the uses of stripe
logic account for remapped chunks.

>  }
>  
>  #if BITS_PER_LONG == 32
> -- 
> 2.49.0
> 

