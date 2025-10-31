Return-Path: <linux-btrfs+bounces-18490-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 506D8C27117
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 22:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7588D1A23622
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 21:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB25F31813F;
	Fri, 31 Oct 2025 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="lyVNJRn+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BGwpkjqT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2A431579B
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761947060; cv=none; b=Q8F7whmFP0tuBpXCl4okVocoXi6sWad/7rLXKNpqauZ/BRQT2/iNIE34u5XCDiZ6IEzd0IiMXXeeo5+xG6MTIh52wdtjBlB3zhBKjZ194ZfYIQyh9WijrKIDj1dsyuiIwq6t51mB6HbGcNyHZmBQ7pyjc2sl06JgKpzqs1aJ/wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761947060; c=relaxed/simple;
	bh=ejFLZwcC0ukdBRUNxYYB7Oy4cSAgqJ8LXzaCPYlXfpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhQyybMWrgdJnS5BzmjkoTIWOp7fMVhOFv0oW62c5yZJUqhQTOMtvwy0GbirxF94dDP+ZjPCEQ27NXo8t29MfD8SHfwca5/LvPmOvD466tS2lsiVq4qgX8LslmPP2gkbk/d2l2JeXgrsbsSVMWbSX6grRKNkWHJFWJ9skcW+kQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=lyVNJRn+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BGwpkjqT; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 4A711EC01B1;
	Fri, 31 Oct 2025 17:44:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 31 Oct 2025 17:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761947056; x=1762033456; bh=6aWoI77oZA
	tz2ccW3rzHSNcm75PFtMRU0CM8LFlgqfo=; b=lyVNJRn+R5dZniTBfNJy7PvQQH
	O9CVS23Fq1dGq+Hs0q/Qt0BafmojGQGAOHWdx76/yCy+2dSHOSuZM6kNuMkPAkUS
	0jSFFfiAI8+j2CRakPGur3NFEue45Zihm3lcHLF4MA2JI2xn3pQMhx5DeyewFh9G
	F/W73pjNO3ux2Xgg/f7So/Bde7nDvFhN5T4jVZ2s/LeeInPculc8A/zrLhstyeHF
	9dSxn7bv15xEvduuwiFHN5dM664+Dw2oQ4L91Y3TIi49WVGmP6OJxE7YA46JfwqW
	Ni8qgVORsuGzTciLY6FsQG2hMDk3D8DZ48lcSK78govuccgVAVIAaHGJeKHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761947056; x=1762033456; bh=6aWoI77oZAtz2ccW3rzHSNcm75PFtMRU0CM
	8LFlgqfo=; b=BGwpkjqT/rfjYrIz3SkfivaArrVZoMB2jOCX6nEkv4ehkiTfWkE
	JRMgLDvCl/IjXLFSjA9l+S5NpaWlCEhyIeXNy4gIND5t6dqNdjk1+Hq6/UuQOhsf
	zuer6FdeAfvvoxLaBwGAwejXHKr+9e8lEwaDRRG0V5CTIyYE/lkh3oJ7Cd5KtrhX
	34UU10JFnO7Sr9n/qwjBMP8YpszHoATc/q9kQM/nDd8cO+ACWlpimwwaHVL/4W98
	ESkAywI3bn+ENq6yPdkB3FbgWe9eStPUgGnvZG+dAQ2vaBGcuzVtFz40/5GvATF2
	EaHP/Wsn75nklR7VCaPyJEOZvMaInvqLHGA==
X-ME-Sender: <xms:sC0FafPl_ZTp1WHljedVw3o0mPXsUWdssg9KmHW-VN5v54FowIr2ag>
    <xme:sC0Faf_ZShv4WgTlWB7fgYbK5CdcHJHb0H9OQRYNC33BrcgavJdrUfy0JbOHmoJib
    QbcjCDNk2P92MqiZZ8otPJb5vkYzPjLXo78BMB14QqmdB8jijy34nA>
X-ME-Received: <xmr:sC0Fab7hFiwT0rye0RzbrQP5hpNgBB6MI23yuLUDcMF8_9TOHB-C4O9omYIC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedtiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sC0Fae0akVtF5QpVMIUMhaIAXGD0Idt-ApDrM4vbMZCCtBfWApJ6JQ>
    <xmx:sC0FaaDiO5330-A74X_Dp9oKFIvD7KgqdWy99voAfexw-vOs6nv_Tg>
    <xmx:sC0FaY0pMwlDtCLKZVfFAQy52lnM2TRU0OVnaV2-GXG3CBX6h5YjXg>
    <xmx:sC0FacsRrlH36gO9TppgjHuu8t6-rsTRBa9KjpA0PT0VyU4q5uaR_g>
    <xmx:sC0FaWhAB4vyt06kub5funwtjXyL-97k3Q10Cmqdz76eOitWUw7_EPpk>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 17:44:15 -0400 (EDT)
Date: Fri, 31 Oct 2025 14:44:12 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 04/16] btrfs: remove remapped block groups from the
 free-space tree
Message-ID: <aQUtrBM3XIb2Ufkr@devvm12410.ftw0.facebook.com>
References: <20251024181227.32228-1-mark@harmstone.com>
 <20251024181227.32228-5-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024181227.32228-5-mark@harmstone.com>

On Fri, Oct 24, 2025 at 07:12:05PM +0100, Mark Harmstone wrote:
> No new allocations can be done from block groups that have the REMAPPED flag
> set, so there's no value in their having entries in the free-space tree.
> 
> Prevent a search through the free-space tree being scheduled for such a
> block group, and prevent any additions to the in-memory free-space tree.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> ---
>  fs/btrfs/block-group.c      | 15 ++++++++++++---
>  fs/btrfs/free-space-cache.c |  3 +++
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index ec1e4fc0cd51..b5f2ec8d013f 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -933,6 +933,13 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, bool wait)
>  	if (btrfs_is_zoned(fs_info))
>  		return 0;
>  
> +	/*
> +	 * No allocations can be done from remapped block groups, so they have
> +	 * no entries in the free-space tree.
> +	 */
> +	if (cache->flags & BTRFS_BLOCK_GROUP_REMAPPED)
> +		return 0;
> +
>  	caching_ctl = kzalloc(sizeof(*caching_ctl), GFP_NOFS);
>  	if (!caching_ctl)
>  		return -ENOMEM;
> @@ -1248,9 +1255,11 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>  	 * another task to attempt to create another block group with the same
>  	 * item key (and failing with -EEXIST and a transaction abort).
>  	 */
> -	ret = btrfs_remove_block_group_free_space(trans, block_group);
> -	if (ret)
> -		goto out;
> +	if (!(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)) {
> +		ret = btrfs_remove_block_group_free_space(trans, block_group);
> +		if (ret)
> +			goto out;
> +	}

I feel like a comment or the commit message could explain the change to
the btrfs_remove_block_group bit more clearly. Like "remapped has no free
space so removing it is a no-op". If it is in fact a no-op, is there any
problem with calling it?

With that extra bit of doc/explanation, feel free to add
Reviewed-by: Boris Burkov <boris@bur.io>

>  
>  	ret = remove_block_group_item(trans, path, block_group);
>  	if (ret < 0)
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index ab873bd67192..ec9a97d75d10 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -2756,6 +2756,9 @@ int btrfs_add_free_space(struct btrfs_block_group *block_group,
>  {
>  	enum btrfs_trim_state trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
>  
> +	if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)
> +		return 0;
> +
>  	if (btrfs_is_zoned(block_group->fs_info))
>  		return __btrfs_add_free_space_zoned(block_group, bytenr, size,
>  						    true);
> -- 
> 2.49.1
> 

