Return-Path: <linux-btrfs+bounces-16105-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1B1B28949
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 02:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF50A4E1D4B
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 00:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C69A10A1E;
	Sat, 16 Aug 2025 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ki7/+GFw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UrDdrpgW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F5F1FC3
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Aug 2025 00:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755304315; cv=none; b=rqX8ktEPWHW1Qjd0Mw2JSMp88Kq11zv32BLK4GKwrA9RnLVeJzXWnTyAfrU5d9qHOaO+wBr7uF94/8cZRU/Om0oh1BFL/SNSd3c28XfXV1LF9DNja+Yr09kz7KcIIdVBQf7TD3PHHTL4aCe/owCZfJAaq5roQ4MoacdaT2eY01E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755304315; c=relaxed/simple;
	bh=XBi1n9g1SZH2ykIjGa0NW5cfdp2rP4Y70wVH4f38AF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtRSNLmGWCbvzW2zah2C4x9tYOiiwSEMJr4O/KoI6lUGDZMSasWUNPjyJ2FqisKxcbpcoIoaz0tUzmt0lSOZyi1VUnAOFu66dBpMkYOPW+8MY+Iki0rOU2jr5V1oYzgG5dNRd1Wzgl48lx5pLo4nL2k9VaA3cKWUtzpSUObnudA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ki7/+GFw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UrDdrpgW; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id CC81C1D001B6;
	Fri, 15 Aug 2025 20:31:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 15 Aug 2025 20:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1755304312; x=1755390712; bh=Mfh3ATHE8b
	6MFUogQ3bCPqTlCSNB9UQLm6/drfIIfnw=; b=ki7/+GFwCKN2JkrH8lwSZoP/Wn
	WEvJsswONTL7betg9vGygb6e+a4XdZy10PmbEguSRSLlmCuJcFjudl45+evpzsmm
	3yB+BNZDzROn10VzuFKKbDjnwqI0tes46uMC+t8UzmYADFCmA9lpvPMaxXWSeP31
	ndKhKAs9UTfi4V2lZuxQiA2tYA6bMmlRvZ0BcCoboxdv16AhMguJRUBUM2lVqdHu
	Yvk3LqDzIHLnFZq2dCvtTiWfpm1q0ah/nu0u6etdhSNFaTXDfOzgz2J2iGZmfp3h
	9aIKzsS/4ohYKDewyKEYdseihNmK997q1wBBsjKyu1RvjPbYoNWDlQDM+xLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755304312; x=1755390712; bh=Mfh3ATHE8b6MFUogQ3bCPqTlCSNB9UQLm6/
	drfIIfnw=; b=UrDdrpgWqmhBphvBldV333b1r+BtA+F5s4UZj1gpz65RuSp0PNT
	buZxBrpoEhOtXbMM0VVabJq2Z7uCnkfAedKsh3oi7bTi+qDjx/zhFg9ZAfFKWyHY
	zQ0+bdMB9Gwqgwo6T5I+EwaT3FRnnn3JXz1S9DSGOmCVSgFnzfzqhrdjDBJJo+7t
	WJotIXd4xqlkw92WSBFMsQsWsghZDWu1lu/hA9p3NTfgLU97KCcJYW4zJrmW5GY4
	EHyvGErj5sHFGsldFigIwQruaXUY3q3pljs/K86FwkbqogovRTMeEvW4eHoV6aDE
	WAZBkus+/jgsRbKFz1xG3l+YBDkhzkniFJQ==
X-ME-Sender: <xms:eNGfaKwc4CQVoKGje159xBsmL08cR_bJx5MMeaKVz_cj-dh1UGEOkA>
    <xme:eNGfaGezB9gsz53h4PSSunKIWWfigyykG8uNpejX1Fk21DHEwNja8YkH8v7PyMVAz
    u4Q0ZJZt_CVhiqfwFo>
X-ME-Received: <xmr:eNGfaOI1RMNjJ2wa_DPMpI4wCt_NF5rjAaR85IvsIcgXCQhZFD2PiMJoZileVmtsmdSiyVvIT6G-zkpg2fsCArSDhyI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:eNGfaPF6kv7AOUmNIt4NEfC0Ed4zzJqyBhsMszP02KlB5Z7chiDVgA>
    <xmx:eNGfaArKlvA8_cSk9Mea4CFYmxtjSL73sDX4j3wzKwNAyXiRIcKr2Q>
    <xmx:eNGfaAS1hbLdMq1BtLbtHBicQ7pFg943T700njgXMvin_77oZtJ83Q>
    <xmx:eNGfaFOiES3lfz08LPMOylPGxJezCLidYIp2ERzVXJxYT-l22QFcnw>
    <xmx:eNGfaNW1o38g6GBaxxeG9ylS9I58GaqgyihnR3cMy_EXVXqoyaIvsJhj>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 20:31:52 -0400 (EDT)
Date: Fri, 15 Aug 2025 17:32:33 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 09/16] btrfs: release BG lock before calling
 btrfs_link_bg_list()
Message-ID: <20250816003233.GF3042054@zen.localdomain>
References: <20250813143509.31073-1-mark@harmstone.com>
 <20250813143509.31073-10-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813143509.31073-10-mark@harmstone.com>

On Wed, Aug 13, 2025 at 03:34:51PM +0100, Mark Harmstone wrote:
> Release block_group->lock before calling btrfs_link_bg_list() in
> btrfs_delete_unused_bgs(), as this was causing lockdep issues.
> 
> This lock isn't held in any other place that we call btrfs_link_bg_list(), as
> the block group lists are manipulated while holding fs_info->unused_bgs_lock.
> 

Please include the offending lockdep output you are fixing.

Is this a generic fix unrelated to your other changes? I think a
separate patch from the series is clearer in that case. And it would
need a Fixes: tag (probably my patch that added btrfs_link_bg_list, haha)

Thanks.

> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> ---
>  fs/btrfs/block-group.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index bed9c58b6cbc..8c28f829547e 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1620,6 +1620,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  		if ((space_info->total_bytes - block_group->length < used &&
>  		     block_group->zone_unusable < block_group->length) ||
>  		    has_unwritten_metadata(block_group)) {
> +			spin_unlock(&block_group->lock);
> +
>  			/*
>  			 * Add a reference for the list, compensate for the ref
>  			 * drop under the "next" label for the
> @@ -1628,7 +1630,6 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  			btrfs_link_bg_list(block_group, &retry_list);
>  
>  			trace_btrfs_skip_unused_block_group(block_group);
> -			spin_unlock(&block_group->lock);
>  			spin_unlock(&space_info->lock);
>  			up_write(&space_info->groups_sem);
>  			goto next;
> -- 
> 2.49.1
> 

