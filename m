Return-Path: <linux-btrfs+bounces-15615-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3565B0CBE6
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 22:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B321885DF3
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 20:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB1122F164;
	Mon, 21 Jul 2025 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="nsovVsT1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lL8VImce"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429B6238D56
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130106; cv=none; b=SvXMEm1L9vUKWaIa09VafF0CZhUf+NO68oc6dF6uaAxofMXKkYcajn2NEwxhxJTuxG8mqDZYLSy2tFQSW9jySzk08TouvuAb6SQHfj7Ky+RXGjyR1pFJPfXDWo0GRtfP6XLCN3fkTSiyp/2m+oNeU6WQfJFcf5hl/XUTtufgG6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130106; c=relaxed/simple;
	bh=tIEEqtmFRWNM9smZjdgZT3rXL8252UC3XRYxpKTKM2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gs2qcDHTLsHSEITpW997mPhRz/TaRrasyL7sqKUuYUJwOoNt7VTBjOz6xkPhH/D5yGPzfZTqxFNanuHIO6a/AaAnWWHoyWDts7+zrqLy37h79xfSVtzHQwXavZ8mE9qC+sI4mB/hXt0hwN2/qvz/spYasw5BgXeCeHVfXtSzPYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=nsovVsT1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lL8VImce; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4BBC1EC0281;
	Mon, 21 Jul 2025 16:35:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 21 Jul 2025 16:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753130104; x=1753216504; bh=ri9xtESwT/
	clV73D1Aot87ntahJG3OLLDs/EAfw0NLA=; b=nsovVsT1tb6ni0Cf54+Cll4Ljc
	GojUdhJaA6w3hjjo7NQ2x0ZcfX/ArlHixgVsBrj+NKQHFSSG/Mr8kZY5hWKAvQCn
	h8KTu8+I8p2saGUq8+Fuc3DjjDKwgw1AR2l5mPvjtukCPRvGAwaqWDty4RaH3fTz
	sRxyQa2xrzuSFo0dtGvyFrZPqecTQyA0zfJnA9XnrAj3CWLv8jBEhP8sIus1moeT
	5a5w+wJ1AJjESQWW9ryoNUo5KxCM+9lyQqI2CZ3s16UUOsULboayGy6NWtXjGkDl
	Phq9a0s2LsjzjoBe7uG+rNu0Ftrh+nMHM3WWh9LJmPWLrnZkWh7DVYCsXhZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753130104; x=1753216504; bh=ri9xtESwT/clV73D1Aot87ntahJG3OLLDs/
	EAfw0NLA=; b=lL8VImceFRNcTOvrtsY6Ctbm082mzDn+3xE1hqoArW4swwA+0b9
	7Gm0zScjcn0HIm3/tL22O1b1UnNMs9osbQ3aTerpLGo5zu7e2lsUj+X+GWz7/4lg
	xin+cKKUX6evIM03vru2L4IT+f6baBaqDqXJuHU3omVb0uQYgPJGVHxA7x6CcxUp
	ImWHfmZwc8Aqcjfh91AjPgpOdaNpxMAy37o92qqmrcTYfmpdeRBVpKWmfk81u9XS
	FBLQveF1Tk981m6ta9jcl+LFWnRwTfuwfNX7LKy4rBA/R1g8lda5MgbjSTJn9Qb/
	PDIdi0yWeY8sGji3xRkYzgqF4TlwW9c19fg==
X-ME-Sender: <xms:eKR-aGMZMwDwr1pdRp43csJFFJpM59Laq8tmA_docN64E4zpF41auw>
    <xme:eKR-aFK3HXQ22LDt6Bh5fcFfp4Ua_IQmtjroQnO5m5gZEJYAZuGWiz3OrBBLU5XIH
    ZRD37Kro7dlsWUHxLI>
X-ME-Received: <xmr:eKR-aPECzWaPnbQtYAfooOON4Z6NUsDmnqiGUD6mDVK1x9XBsQn805ldVk3zpLcQaKg79ID8q2SuskJsYcpIta_Dpfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejfedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvke
    ffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    peifqhhusehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:eKR-aFRE4ZPJj5YybMwkQJ_GzpD7vS7bb7XnIFcvMdbYK93MD7FvTA>
    <xmx:eKR-aDF7Vc2-7K0gA7rgUKa8hywvAJKKvPvT-5GDQxnA2h6tBjnqPg>
    <xmx:eKR-aJ8s1CTNFfw3cafVjpagSMamHvHPhX57dNd6ppgi6N3_RUxo5A>
    <xmx:eKR-aFLR0wTuMEdJUq2kObgyZzW2b5097m3kaiZWHpUr-_z1hKnWBg>
    <xmx:eKR-aBcN3Ccuj_eQMbb77Mm12xcxq4d25_5rQvd3D1TAmo54RlzIEO0I>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 16:35:03 -0400 (EDT)
Date: Mon, 21 Jul 2025 13:36:28 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: fix the wrong parameter for
 btrfs_cleanup_ordered_extents()
Message-ID: <20250721203628.GD2071341@zen.localdomain>
References: <cover.1752992367.git.wqu@suse.com>
 <15717a81b5c75c91a129bdb4b81671a4fe2c5e8c.1752992367.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15717a81b5c75c91a129bdb4b81671a4fe2c5e8c.1752992367.git.wqu@suse.com>

On Sun, Jul 20, 2025 at 03:59:11PM +0930, Qu Wenruo wrote:
> Inside nocow_one_range(), if the checksum cloning for data reloc inode
> failed, we call btrfs_cleanup_ordered_extents() to cleanup the just
> allocated ordered extents.
> 
> But unlike extent_clear_unlock_delalloc(),
> btrfs_cleanup_ordered_extents() requires a length, not an inclusive end
> bytenr.
> 
> This can be problematic, as the @end is normally way larger than @len.
> 
> This means btrfs_cleanup_ordered_extents() can be called on folios
> out of the correct range, and if the out-of-range folio is under
> writeback, we can incorrectly clear the ordered flag of the folio, and
> trigger the DEBUG_WARN() inside btrfs_writepage_cow_fixup().
> 
> Fix the wrong parameter with correct length instead.
> 
> Fixes: 94f6c5c17e52 ("btrfs: move ordered extent cleanup to where they are allocated")

Oops, missed that last time :)

Thanks for the fix,
Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5259bb8ec430..6d9a8d8bea4c 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2018,7 +2018,7 @@ static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio
>  	 * cleaered by the caller.
>  	 */
>  	if (ret < 0)
> -		btrfs_cleanup_ordered_extents(inode, file_pos, end);
> +		btrfs_cleanup_ordered_extents(inode, file_pos, len);
>  	return ret;
>  }
>  
> -- 
> 2.50.0
> 

