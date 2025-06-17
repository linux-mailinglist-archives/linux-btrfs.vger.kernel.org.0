Return-Path: <linux-btrfs+bounces-14753-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5B6ADDE1E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 23:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E4517E27E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 21:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89BB2F5313;
	Tue, 17 Jun 2025 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="TzEL7xjw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B5vcklUr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B9F2F5308
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750196376; cv=none; b=g8iJzAcgl+5AnU+q5GCxUxocutTtDbk8Q8FnFC0myGozD3/xEGIaBcHrLwSbGyggrG2pZXHLQK/D6cEd3U1cDkt/SHKQ0iajfxhZqiSFTEreSH6C7ob0TQCyt6Xd9ZUjwPpzT7tZb8qAx9gcg1dd04kRW7HaPui0k3Nxm9ahLNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750196376; c=relaxed/simple;
	bh=iR7X+CUpeZfliEj/+1mqk08bEJKLfTsQ68ODpAB8SbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyQpF9Lk17C8qM7HjO9U+VG/wl/tckjLXN+CUJG9mip9pkBX6ZOEyMWLdG1KW+kcFNHPo6kcmU43koe6bS9ESKbxnZbqq4us8q8HaIXZXZ+2XJDU2hrXDza6Ms/Aa6ph3MuT893vPGJUVVsnHNm/qbLzwZG6l/uFPNKtdQJS+Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=TzEL7xjw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B5vcklUr; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6ABF0254009D;
	Tue, 17 Jun 2025 17:39:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 17 Jun 2025 17:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1750196373; x=1750282773; bh=+l3RDQbX2k
	KAOuAR8mu+HQxBy9OU40KHbAiO4rL++qw=; b=TzEL7xjwinpWZkS1QieGOOJVQy
	VeKL5+s9NmufbPiAeCFacgVfPGUcrP+almgGDYBNTzLka2skYsW02dEi3VHwvLYh
	3fZulCrkXtKbkzTREKoeaFynsJrs4WldLtP/s1XIQ3R/nyNwvKRhaDsuK0lFVdRJ
	uzvIikn7XWgMPyaYV8fDRuwk0if5FvPhMhaGRWLeR0TyAXhi3BdZz5hUMvkenNbQ
	HNj8s6bWRl8uG/joIRjC6MooNrzBotrm9b9lo8Tb9VjtAYu/2cX7XTa3JH/e6du6
	OvVRAizVAg4zdtbhXGGnx3gJARDAthca2VKQONot0lrWBgVekUQCey8TmHgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750196373; x=1750282773; bh=+l3RDQbX2kKAOuAR8mu+HQxBy9OU40KHbAi
	O4rL++qw=; b=B5vcklUr1WR2uB2rOZmhhFDrEh0Y2ZSFUBpZgX6KEgvtUCosn5P
	OiMnSlCiaCx9Qfcky0G3GG+k32nepEfbsk0egdOyHk+SZlvEWQnIKNGmHjpzjNQ2
	0f8aVuXY0FKEvD5DnluyYgLHFAbouclbSkTWSXWxqzLLJ6ECjzGn3dPsEAjgSOIR
	+GWxwRmNU4+EeIetJjFi3mOXVV7mc11+MtRZ49mnx4mlyzMtrPVynimGaY3reLzv
	pG4HkqhiedKKAXuYroYczC62tYq89FuBkn+Sdzr3OfyRzExQlEuisWgbWTGFlJ95
	FxxxBM5zY+pUs4VDcr8DWmH/0yWFAjXoAsQ==
X-ME-Sender: <xms:leBRaNDb2Lmns57iZemZBERS8STAC7ObrX0WzJ7KmB8kabPosFOKjg>
    <xme:leBRaLiTiEInVC2R1cSvKAJ_yOkbXIm8XRpEzma5nuPbzSiYJQfH8LCgRMe6ACa5X
    kqmocTh81_GTJiPRUU>
X-ME-Received: <xmr:leBRaImN3r0kx7UcpQe3wpoh_-AJnSkF_nR_KHD-5Mw1HkVD57TTxUnvdem3IgZmbNY8sStq66oH-A6ql9iawFk8fnM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcu
    oegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhve
    ehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfughmrghn
    rghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:leBRaHzFGlhVK3KjsuZnxCLvuvMvrWwZHayOZMh3pjlAAbPDpSq3pw>
    <xmx:leBRaCRCZ2NyjWfLUeVRILFPQUjhIUUzbDJ-ommzoD2eqm_GDVvs3w>
    <xmx:leBRaKYdesruhkTsjM7vcvz9t4YA26jLcjVh1adpPD_g8a-CpyoVAg>
    <xmx:leBRaDRVR6jYqZtbT-MN_M1JAV3HNuLmv_7cnm16Ja3ZGqXUMK7-vg>
    <xmx:leBRaF9oy-R8FTDnWmFO4z3BnF6Lfm1IowLV8diEItHTsY-Sk04pyfH2>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jun 2025 17:39:32 -0400 (EDT)
Date: Tue, 17 Jun 2025 14:41:11 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 15/16] btrfs: add and use helper to determine if using
 bitmaps in free space tree
Message-ID: <20250617214111.GA2330659@zen.localdomain>
References: <cover.1750075579.git.fdmanana@suse.com>
 <3a6d4004a9bda4c4596d559c7c43b98e74151f11.1750075579.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a6d4004a9bda4c4596d559c7c43b98e74151f11.1750075579.git.fdmanana@suse.com>

On Tue, Jun 17, 2025 at 05:13:10PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When adding and removing free space to the free space tree, we need to
> lookup the respective block group's free info item in the free space tree,
> check its flags for the BTRFS_FREE_SPACE_USING_BITMAPS bit and then
> release the path.
> 
> Move these steps into a helper function and use it in both sites.
> This will also help avoiding duplicate code in a subsequent change.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/free-space-tree.c | 50 ++++++++++++++++++++------------------
>  1 file changed, 26 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index c85ca7ce2683..3c8bb95fa044 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -791,32 +791,40 @@ static int remove_free_space_extent(struct btrfs_trans_handle *trans,
>  	return update_free_space_extent_count(trans, block_group, path, new_extents);
>  }
>  
> +static int use_bitmaps(struct btrfs_block_group *bg, struct btrfs_path *path)

I think 'using_bitmaps' makes more sense, given the name of the flag.
Ditto for the next patch and the caching variables.

> +{
> +	struct btrfs_free_space_info *info;
> +	u32 flags;
> +
> +	info = btrfs_search_free_space_info(NULL, bg, path, 0);
> +	if (IS_ERR(info))
> +		return PTR_ERR(info);
> +	flags = btrfs_free_space_flags(path->nodes[0], info);
> +	btrfs_release_path(path);
> +
> +	return (flags & BTRFS_FREE_SPACE_USING_BITMAPS) ? 1 : 0;
> +}
> +
>  EXPORT_FOR_TESTS
>  int __btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
>  					struct btrfs_block_group *block_group,
>  					struct btrfs_path *path, u64 start, u64 size)
>  {
> -	struct btrfs_free_space_info *info;
> -	u32 flags;
>  	int ret;
>  
>  	ret = __add_block_group_free_space(trans, block_group, path);
>  	if (ret)
>  		return ret;
>  
> -	info = btrfs_search_free_space_info(NULL, block_group, path, 0);
> -	if (IS_ERR(info))
> -		return PTR_ERR(info);
> -	flags = btrfs_free_space_flags(path->nodes[0], info);
> -	btrfs_release_path(path);
> +	ret = use_bitmaps(block_group, path);
> +	if (ret < 0)
> +		return ret;
>  
> -	if (flags & BTRFS_FREE_SPACE_USING_BITMAPS) {
> +	if (ret)
>  		return modify_free_space_bitmap(trans, block_group, path,
>  						start, size, true);
> -	} else {
> -		return remove_free_space_extent(trans, block_group, path,
> -						start, size);
> -	}
> +
> +	return remove_free_space_extent(trans, block_group, path, start, size);
>  }
>  
>  int btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
> @@ -984,27 +992,21 @@ int __btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
>  				   struct btrfs_block_group *block_group,
>  				   struct btrfs_path *path, u64 start, u64 size)
>  {
> -	struct btrfs_free_space_info *info;
> -	u32 flags;
>  	int ret;
>  
>  	ret = __add_block_group_free_space(trans, block_group, path);
>  	if (ret)
>  		return ret;
>  
> -	info = btrfs_search_free_space_info(NULL, block_group, path, 0);
> -	if (IS_ERR(info))
> -		return PTR_ERR(info);
> -	flags = btrfs_free_space_flags(path->nodes[0], info);
> -	btrfs_release_path(path);
> +	ret = use_bitmaps(block_group, path);
> +	if (ret < 0)
> +		return ret;
>  
> -	if (flags & BTRFS_FREE_SPACE_USING_BITMAPS) {
> +	if (ret)
>  		return modify_free_space_bitmap(trans, block_group, path,
>  						start, size, false);
> -	} else {
> -		return add_free_space_extent(trans, block_group, path, start,
> -					     size);
> -	}
> +
> +	return add_free_space_extent(trans, block_group, path, start, size);
>  }
>  
>  int btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
> -- 
> 2.47.2
> 

