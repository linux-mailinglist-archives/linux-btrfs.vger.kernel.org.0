Return-Path: <linux-btrfs+bounces-13663-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB08DAA9A48
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 19:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF84C189C8EE
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 17:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4822D26A0CA;
	Mon,  5 May 2025 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="WQeVjkEH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r0I7mbVK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8238726B95D
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746465615; cv=none; b=g6D6RAkTHthMBK/jxr+R7K7QIkjrkbLN682uq8fEcPK9IOL8OtYZVqDhQDz0A62h1ovfsYhFm5Bz5ZMwPG6sdWsVnRoeiRe+BjqCCzX4k93K6EIutEU4ayl7jtgJrcGrU280YqrWwxIZMuP1v22VRx8HJazTlBLrb0Dlm6u2hF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746465615; c=relaxed/simple;
	bh=bGyPtszcCXV+BHDy+R+e8OM4rGUa75gmXntc1+m7CQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9glce69SW54YvvmFoBxdy7c/W3o+BC0aIKavCsGaDE8YjopFPlNh2A4Mov90aX1UEwZNen/cRxkD0vmo0HWS7Heq7QtmuUBE1ccK7oWCaZ+NvK1h5+8tY6ERr2CkUXO4BDoI+rjjiU65UYolDSyG+GWz8kn3bfBNNCXSO/RnD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=WQeVjkEH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r0I7mbVK; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8F30B2540287;
	Mon,  5 May 2025 13:20:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 05 May 2025 13:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1746465612; x=1746552012; bh=Me19fn7cph
	Mm/HRHwjCIKLpJWPMUqR4JQTI+rwVQOdc=; b=WQeVjkEHLyZpQyoVlEA/deF7ON
	yvJqe9mNF2zq15N3fGX3lKPtVx2Yh3WLA1AQv8XTR11tvKCpazzQKJtXymWPCZn9
	KnVnqKkcyjQStedXkm4pIOYZmk4i6iC6KwHKYjMjVBuT1sLzkZfeXv/xS+MI8EqX
	W5kO59z78zLvWEnY5r0P7uqbfGrxSD3kWRQ61uZ/0pAoa85K+go3077MiFoyROrJ
	63LTsfGdhPgC1LmYJjK21tX2D/X265V4ZbPdnquF7r1uvvqwxtt4+xW8wdVR35uT
	3pjXLXlYYJYKsYKOC0xSayfSlYym8Qro4xfIowi1o0Waz1ZefnOAfXtzSj6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746465612; x=1746552012; bh=Me19fn7cphMm/HRHwjCIKLpJWPMUqR4JQTI
	+rwVQOdc=; b=r0I7mbVKF6UxGd99HVIZmPtG/n506iwMGfg/p8qK4dZ8QsaivBU
	xju6TO3bfJuUmikQWe//yAJGaywOId0LCmlLGLvsnYQd3vAulYw6xlv3A0ykVwtC
	DU9/vHLERsS/8Bz9R9st3URkQqpGqlLbYXIKT07u3L0lrSJDX2kDkE0ytVzblsRT
	rSwwdWd2Tra2/u3zQJPiiHC0Lypj12eP+mw6KwqnKpzfEtERGF1gZXTPmTfeJaVI
	HZxDvDrPzdSMkP9g7+5qIshMjUd9jaULY3axeP1jA9Z4onfVcOBGJ/Gg01K3jHW9
	RyJsiG1wNGkfpunLTu3w8FGwDTLIX2cZJVw==
X-ME-Sender: <xms:TPMYaBpXn7Fh-as0PWcYMHHKMWzbEtHA5xu24gv0HvJRjkToH1qLFg>
    <xme:TPMYaDqOB-leBjWF8IlYOIM2fl5gyfc1mNWwVZ280iC7ki16m-VHYgKArRvTESoLk
    AXe_Y3vy1Xf1ySaa1w>
X-ME-Received: <xmr:TPMYaOMC2GIWT1G4h-pf814TspcI7QYncRCHTcGnrK4wPrdcmaAUVipBs4h0Z-3VHSsWf1Jn2YXu7EiJ4yTwprP8frg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeduieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhho
    vhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeelle
    fhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfughm
    rghnrghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TPMYaM6YuPC5sdMivaj1mth0PtK8IPc76UKEXvmoU62RjUYLuDYcbg>
    <xmx:TPMYaA7oDRZYNAVhs0uaD2akD0RiKt4XnLbegZU10SwfKvmNvf86vw>
    <xmx:TPMYaEj-NnTukY2xrhItusZJix5Zzj0AaIj5n606TPM2BuuBQEEw3w>
    <xmx:TPMYaC6G3DBye5PBotfqJw8u2ydv_dGd4OnPmWq5XHfspTpqVMJTsw>
    <xmx:TPMYaFmePvsJVReXnbCVmyCkInLmTYLyDlPFRe8dxUUNezg2K8e50lDw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 13:20:11 -0400 (EDT)
Date: Mon, 5 May 2025 10:20:58 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: use verbose assert at peek_discard_list()
Message-ID: <20250505172058.GB3436025@zen.localdomain>
References: <cover.1746460035.git.fdmanana@suse.com>
 <28f059e4718c988385c0d330c5c4663e253b60b0.1746460035.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28f059e4718c988385c0d330c5c4663e253b60b0.1746460035.git.fdmanana@suse.com>

On Mon, May 05, 2025 at 04:49:56PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We now have a verbose variant of ASSERT() so that we can print the value
> of the block group's discard_index. So use it for better problem analysis
> in case the assertion is triggered.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/discard.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index de23c4b3515e..89fe85778115 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -256,7 +256,9 @@ static struct btrfs_block_group *peek_discard_list(
>  				 * the discard lists.
>  				 */
>  				ASSERT(block_group->discard_index !=
> -				       BTRFS_DISCARD_INDEX_UNUSED);
> +				       BTRFS_DISCARD_INDEX_UNUSED,
> +				       "discard_index=%d",
> +				       block_group->discard_index);
>  			} else {
>  				list_del_init(&block_group->discard_list);
>  				btrfs_put_block_group(block_group);
> -- 
> 2.47.2
> 

