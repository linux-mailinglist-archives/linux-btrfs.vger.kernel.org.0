Return-Path: <linux-btrfs+bounces-20602-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79847D28FFF
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 23:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8207302E15C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 22:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F35328638;
	Thu, 15 Jan 2026 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="F1ED7QaN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WZB7D+xU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858A2320A1A
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768515817; cv=none; b=iRPqwvVRTGZjUyPLVrdOqUpnKzp9C3Nd/uuWOhjP3T13ZBkoEGjnMAh0DYXe9JETpR4boi3tVDiKJjZYA4D+lRr+OPYUmAfqmJBw94W+wqE+lxKBOw5nnenQ6luAyMjKyKRPVlcRY8hWFEqhTRLU/1Bgqld1EL9T9vk9XC0B2tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768515817; c=relaxed/simple;
	bh=Ix8LdTYK7985VQFrftXokWrL8mySvuPFlwCbhHoKfAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfctDvV8Cf5fVZfXTFwqSHsDmRWd7h8NVAGVafHrPuJMQ3ChkL53dRBJbAu+VrE6/mnc5zpsRkGon/tz0efDh6+W9yyFLekIxfgVee1xcn5d/dzfJIgOPCvUxNqLe2tUtkGiObyvClNrTyqxHMwQU0OMBm3EvDDvXTj1FtWsAjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=F1ED7QaN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WZB7D+xU; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CE47F7A0035;
	Thu, 15 Jan 2026 17:23:34 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 15 Jan 2026 17:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1768515814; x=1768602214; bh=seBW2U4JxR
	P/mYCvkFmcY/75Xqcd985FwOm4eIIhsLQ=; b=F1ED7QaNat1rqB2ex31hAFKlPw
	+WYKoLbDOnJhL3c3FSSUr4PtwwaTQzKMXl/chT/7BcjNP+ReHDsC3EWT+auBebP/
	5fTiEfZxz7G5gVRunskKN+sz6wz9Syf3Mf01rnfBclUlqEvGBdS9MDvR185F6hLs
	YyrZPL0rhXxWYxLbceQZouXmcv76EQuWw/Rb90vZydcVvbBsK5OqKrBpOn8a5Rys
	2hQT27cL8Y0b2jOiSsOEWk3PVYJs/oJoKe4WvfvJjaTTmzKPm6YLXocFLLdUYQqU
	9D6kH2qgKlx+wCsu7O9ktMWCJTcWBp76KuxfUCdx4Fu6rHLhqXRQI1ZMO3IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768515814; x=1768602214; bh=seBW2U4JxRP/mYCvkFmcY/75Xqcd985FwOm
	4eIIhsLQ=; b=WZB7D+xU4aUWKD/CDSxPtOX5c67xb2O2zgTS7W+RZGlF9QC4oCB
	QHSbJZtOdKehKLr9WeCBzS3q3411pWEaBu2RcGWEFMIFGBfU8rmYqjviSzAtbrQ+
	5gezRsizYS+GWHKJCc8JgiWRWeK9BT6L+omZfhiygrqomwoJ3+FVarp7wO0Yb8yL
	dTCBdGq8LBQV96bl7sBf+p9jnZ+5E6fXVQ15hAaNzOkOIklQna3Rsbo5UNm84e42
	6dyMHM1LgQOV6O3yAcHPBQ4Zi5aA3Jb7YCGUIv7xAB/66hSEz/boPPFr/FAxeQ/V
	Sk+ApCpcyO2tTe71+ni/a4YSB5tpf+btJ0g==
X-ME-Sender: <xms:5mhpaXXkjmXmek4m8QxVMnoWBM-fhxyKK8rXVG92g3QvuTM_9JHsvA>
    <xme:5mhpaVkDiInHWPoXyo-1bNQkUy_na_U4N59A-TPj332S_mnS_MFKUAcuTmY78v6HP
    Dmor22s4HM5Bj1OYzsKFVS2ttZ811WNR-LyAD0Y48o6lwLIbHN0heA>
X-ME-Received: <xmr:5mhpaRBZQDpY52Bb1SVC9M-sRMqbxt3G6gqAflMxHiUSBuE1plnhVm6F3s8u20DDA4BDmfSh0FZCuArg2LhgnSgPBJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdejvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:5mhpadeUBMCYCFCGFFyc3p4nYyUVOocHy-RsSlPJd6-0hR2667dTnw>
    <xmx:5mhpaUIHp3EslGTUn2acU93MKHfGz0xqTLnCox8jXHN5V41T8js0hg>
    <xmx:5mhpaYdOE_8Hsf1dc3MUKQqh8UwssVny5wsCjxG-tcUTWMDsQRIzrg>
    <xmx:5mhpaT1szkVZ-F4g6M_OgIXUSSZzIrrdiud1nudrx63pXzBFrOSslg>
    <xmx:5mhpadq778WS3T1KpiT8BmnFksOTaZQDoTebqaxzXheayuyJd9KqrPQn>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 17:23:34 -0500 (EST)
Date: Thu, 15 Jan 2026 14:23:30 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: add and use helper to compute the free space
 for a block group
Message-ID: <20260115222309.GA2118372@zen.localdomain>
References: <2ba3b023e186d4eec78b8515bb375f310b4b2390.1768512027.git.fdmanana@suse.com>
 <9f70166505b58147e580c51d0ea498b0e9f30ea2.1768513901.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f70166505b58147e580c51d0ea498b0e9f30ea2.1768513901.git.fdmanana@suse.com>

On Thu, Jan 15, 2026 at 09:52:06PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have currently three places that compute how much free space a block
> group has. Add a helper function for this and use it in those places.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

This is nice, thanks.

FWIW, I personally kind of prefer a name involving "available", as I
think "free" is less descriptive of the zone_unusable aspect, for
example. And generally evokes some kind of correlation to the state of
the free space entries.

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
> 
> V2: Fix typos leading to compilation failure.
> 
>  fs/btrfs/block-group.c | 9 ++-------
>  fs/btrfs/block-group.h | 8 ++++++++
>  fs/btrfs/space-info.c  | 3 +--
>  3 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index a1119f06b6d1..d17fe777b727 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1376,8 +1376,7 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, bool force)
>  		goto out;
>  	}
>  
> -	num_bytes = cache->length - cache->reserved - cache->pinned -
> -		    cache->bytes_super - cache->zone_unusable - cache->used;
> +	num_bytes = btrfs_block_group_free_space(cache);
>  
>  	/*
>  	 * Data never overcommits, even in mixed mode, so do just the straight
> @@ -3089,7 +3088,6 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
>  void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
>  {
>  	struct btrfs_space_info *sinfo = cache->space_info;
> -	u64 num_bytes;
>  
>  	BUG_ON(!cache->ro);
>  
> @@ -3105,10 +3103,7 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
>  			btrfs_space_info_update_bytes_zone_unusable(sinfo, cache->zone_unusable);
>  			sinfo->bytes_readonly -= cache->zone_unusable;
>  		}
> -		num_bytes = cache->length - cache->reserved -
> -			    cache->pinned - cache->bytes_super -
> -			    cache->zone_unusable - cache->used;
> -		sinfo->bytes_readonly -= num_bytes;
> +		sinfo->bytes_readonly -= btrfs_block_group_free_space(cache);
>  		list_del_init(&cache->ro_list);
>  	}
>  	spin_unlock(&cache->lock);
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 5f933455118c..6662e644199a 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -295,6 +295,14 @@ static inline bool btrfs_is_block_group_data_only(const struct btrfs_block_group
>  	       !(block_group->flags & BTRFS_BLOCK_GROUP_METADATA);
>  }
>  
> +static inline u64 btrfs_block_group_free_space(const struct btrfs_block_group *bg)
> +{
> +	lockdep_assert_held(&bg->lock);
> +
> +	return (bg->length - bg->used - bg->pinned - bg->reserved -
> +		bg->bytes_super - bg->zone_unusable);
> +}
> +
>  #ifdef CONFIG_BTRFS_DEBUG
>  int btrfs_should_fragment_free_space(const struct btrfs_block_group *block_group);
>  #endif
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 857e4fd2c77e..a9fe6b66c5e1 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -656,8 +656,7 @@ void btrfs_dump_space_info(struct btrfs_space_info *info, u64 bytes,
>  		u64 avail;
>  
>  		spin_lock(&cache->lock);
> -		avail = cache->length - cache->used - cache->pinned -
> -			cache->reserved - cache->bytes_super - cache->zone_unusable;
> +		avail = btrfs_block_group_free_space(cache);
>  		btrfs_info(fs_info,
>  "block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %llu delalloc %llu super %llu zone_unusable (%llu bytes available) %s",
>  			   cache->start, cache->length, cache->used, cache->pinned,
> -- 
> 2.47.2
> 

