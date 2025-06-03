Return-Path: <linux-btrfs+bounces-14436-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CE0ACCFD5
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 00:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83AC189759A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 22:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEDB24C664;
	Tue,  3 Jun 2025 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="P7nDWzgt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EnWfYUvk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C0C22541C
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748989377; cv=none; b=qjxNE0+/34Y/jbfGX3TOBczi2fd3bWzED0mdF/mWihexW7fVSvQojcQ+zXNrNLHiBJNUvsE8FnQMtwyoIrOzzH9vPrVadtKzxwsXuHkyg7jtMsHKPlHOr2iEGkBukN5bkoJMhPquXrtjYdFtHtoyxznR/p2cM8NyTbJuoMD78tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748989377; c=relaxed/simple;
	bh=mjvnBdxb50hWnRuOwkzI50wE7g4CjBJgg8kKzDzA1Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klffd2M6nQhXDzhGfH4IgJURJhkfRX6sTCBid+PokRq9AaMOZJxI0+y/MX6WNfchPj/mmhBf/00QEMXf1JO9A/MOlrLrkENq1gpm+PWsfysJ8NtE8hVFX96GGz0UW4TWCRAJlL7B9UtKZgbBEMr/GZPwbys4gsY0ksi1W33K69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=P7nDWzgt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EnWfYUvk; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 2025411400E6;
	Tue,  3 Jun 2025 18:22:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 03 Jun 2025 18:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1748989373; x=1749075773; bh=qAzBb6GIPh
	yoNXt0gh79N7dnY1yav21jowSXYYh5rRc=; b=P7nDWzgthV75LHCFHVBOP11nCZ
	wpcOGSq8z2yc5ZCMphYdww6xX19YO7phGMzB/qJvUj61D+CJxT8n694phgVq9twA
	ZO5LldCYLa199PkKOK5toKKMTg3mcSc7/pjZd95/V+QXTTpflCfVuifQ0MkR2vvg
	RXWwDmlmBF95KuuFDkcQK2xjj5ZkOUvMYY/ktERcQ8Fk3X4o4ZEJUISd0q/GhUS4
	IjmhkX2UqFsSXhVyfSvxVDzok8zP7CV810G0s2WLyp8AgxIuRwii4fy0HLHQW3to
	i7j9XQAjGwkIIHA1EybxS0ixKrTlxI8O8QSXCyO9H1PmkytETNRR3ejoY84A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748989373; x=1749075773; bh=qAzBb6GIPhyoNXt0gh79N7dnY1yav21jowS
	XYYh5rRc=; b=EnWfYUvkdulLowDX4Lt/LuWNKTRJB4UmsGPguiya4J9mFIA5zw2
	6+T+CWSQkZloOZR0tc3TIGxtEEzitmobia2OWXyfTeZ2gokN0wcX9jbEQgmxz1Zx
	zBxq+vbkytu9tj2VGaFdcFW50vE5Rb8nf0Z+yvPEzYNgvGBIg/OjZqL898do3pig
	WLJGdf6ncal2mM+7QOkXnI84FDup9lq3ZbqzJ4W9ygDOEtlzEVv61ykf8Fjuv1Yu
	Y/dL6ajB435HXNL79h5slA6F8sQ41QtzyO5+PmySQvsAxNJgYZx1BlVg3waLA1rC
	783zYF5BAXFhOL/ItENMewCBZ9nQSdLeYtg==
X-ME-Sender: <xms:vXU_aAzDjdwapCteHPm-43h6IFf4-LAkkt3RHcCWOrQ4AwJ81n-h5Q>
    <xme:vXU_aETwnsRdHhyxfWmgcpsHqddkVxRJ40GGGmXME_BVK56a05XGQFfdCnWlqaBxx
    9up6G_i_oB1rcWe2_g>
X-ME-Received: <xmr:vXU_aCW9mfGS_M-UeE7s-G5-iCyMlmB_OykTXrNRPxiNS1J45-OVYEHLqqiFBuTPuz0dmxAfBxewufLnbpMyKMBuypw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcu
    oegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhve
    ehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfughmrghn
    rghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vXU_aOgyZLco6Vz3ribzfH1QSB1DeJJ-hkmxF4_n-Qo9CcMid9oEow>
    <xmx:vXU_aCDhiXWJe-UKjdHSCPGyNMrNoOpMl05hZbxU3lUQxs74vu0asQ>
    <xmx:vXU_aPI2XrYqdaCGvki_klgTOVztStf71GcbAkMk9KzOOg6SkrKE0Q>
    <xmx:vXU_aJBiMEE8theyvcsn0LFFKk3_LnA5rrCvG9mi1uE4L5HNQXvKyw>
    <xmx:vXU_aLtTch3o_aQYZVnpQsUFo4qHg3ljp2vnCPtVXynplGmDtrA8836m>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 18:22:53 -0400 (EDT)
Date: Tue, 3 Jun 2025 15:22:50 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: don't silently ignore unexpected extent
 type when replaying log
Message-ID: <20250603222155.GA403413@zen.localdomain>
References: <cover.1748985387.git.fdmanana@suse.com>
 <7a4820f91854e3e0e52ec39a4dd89ce9878193d6.1748985387.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a4820f91854e3e0e52ec39a4dd89ce9878193d6.1748985387.git.fdmanana@suse.com>

On Tue, Jun 03, 2025 at 10:19:58PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If there's an unexpected (invalid) extent type, we just silently ignore
> it. This means a corruption or some bug somewhere, so instead return
> -EUCLEAN to the caller, making log replay fail, and print an error message
> with relevant information.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/tree-log.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index c8dcc7d3f4b0..3f5593fe1215 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -668,7 +668,10 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
>  		extent_end = ALIGN(start + size,
>  				   fs_info->sectorsize);
>  	} else {
> -		return 0;
> +		btrfs_err(fs_info,
> +		  "unexpected extent type=%d root=%llu inode=%llu offset=%llu",
> +			  found_type, btrfs_root_id(root), key->objectid, key->offset);
> +		return -EUCLEAN;
>  	}
>  
>  	inode = read_one_inode(root, key->objectid);
> -- 
> 2.47.2
> 

