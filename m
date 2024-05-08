Return-Path: <linux-btrfs+bounces-4846-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B488C0120
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 17:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74442284520
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 15:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514F21292D6;
	Wed,  8 May 2024 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="A+azkakD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W/QpmYuG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF161272A0;
	Wed,  8 May 2024 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715182521; cv=none; b=WPXUca58+9vcObuQF90KlcjGyex5gJ2oZkdXwumUEFQ7gorJtX2p7nCWK3UiyPKQWo3TXWKU6fAqVi0TuGcoxSy6bUDTJX6Y1T3MzvijceevZlfG5+qrc4VSbsy3STr2dhX9R0Qd/xfxvaFRYTrylzt4rWWEjg1J09Au5hemzLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715182521; c=relaxed/simple;
	bh=+dRTs8ZqtmxuGvGGQTyQR67DLee11cjjm+poaEq/vJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovKPTXap3Qsr2pUdVIwieNEVFJjU8LIYrIrgphjQCCs8OJAjKZMX62Ovqq9EsYQXvUs7M41jjqX3PpgkQEvzxgpaCd4k8vTo+Ulg58L8XNRxIIZsLocrkrlhdHm/JpQ8UvNMbAX5vXdGNDk3Hx/l7dfspRbPu03DQpGqdIz7/Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=A+azkakD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W/QpmYuG; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 4249B1C00117;
	Wed,  8 May 2024 11:35:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 08 May 2024 11:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1715182517;
	 x=1715268917; bh=lm7blVN96AATC1Uf2yDMcFq6LkeeP8cygV+zg6qPXC4=; b=
	A+azkakDnYGBO9BeCz/RXCX4GlmqJiq3dB0KkEEO/vXz9alEURN/UlczpnBtc48b
	TgXCqAD/I61eNhZAVZSaYdSjep2CoDFdhB9guSN8HAwTkk6dNzynL0ichVEoebdY
	xmgDGXpW3FX68/07UDwzT3KOcl9rb2KQWY5mf9P37Se5pdJ8YxTpUvjblnUT1LVZ
	0Nx10hldSGgbmgTjVVQAMITP+98OeLzKF2SQC+IluzHwvW+sNCGn0xWo1hB9lp0M
	f39D3V2x1E3LVZX9M1pUNcAUjEJUeS1EMZ3M76m2AN0IzMcUsvAi4F4TS/xrIU86
	uPyAhbQ6qBl6tQeTYd2EcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715182517; x=
	1715268917; bh=lm7blVN96AATC1Uf2yDMcFq6LkeeP8cygV+zg6qPXC4=; b=W
	/QpmYuGKDgvozx+qRfKTDGJUZyhHkcq0d7TGKvZvEfJGnFUi+b3YcQ6mlcmxA6zi
	POG9hmTbs3W30JR8sqdyFZs2Lfqqt75ihM+PFsA6JRmMXcHJpxW2VNzLTrZC+rQ1
	NZpPayYDIcUTkcJ5omYdPfzDb0i3r5eqlepUnfLaW76OGAS/lfsC3MzcLDre/JC6
	eCG1tTOZmvDPtJfX097G8B6B2KtG/6LsKLLoDxOkylpGus8tD7S9DPbWYmuujo+5
	pZh6oD/BbWdDBBoLbuh5RbF6xLvfR5SLzDE+8HJuY9vDOWllZtVOjchwkQAM7ngW
	8MdymGtjmNJjBVwGFhIgg==
X-ME-Sender: <xms:tZs7ZpXLaTsCH-QKeoe8fuc4qHMOJmrdJjp_OibxL5D6HoVE6xA2bg>
    <xme:tZs7ZpmoRYT6ztO3Vl74ZYsMVtC0O2wLRVbIAys4kvF_HfNbxjf4LVPEp8N_VqLry
    oDt53ed-EUl_tjbY1I>
X-ME-Received: <xmr:tZs7ZlaXjvkMB35RgCVckGH6eTQSEOA2179PDhijyLe-eA5k1j28aZfTmo3jMbjJ_rbqDd6B7-i-8QpE_MYw116qCCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epudelhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:tZs7ZsUf2blgOI_Y9RqZIQ-PoeGm65w0hjvj5IES6JNswdHUAU7UsA>
    <xmx:tZs7ZjlJ3Y8cvEt8BkHWNMpKlS1tecVmFacH8D1Fi-ik-NceX2-QOg>
    <xmx:tZs7Zpf_c4AMsBhOlOmwWR9Vx7RcxYu_DkDEFKIZRZshU90Tng_whA>
    <xmx:tZs7ZtEO1-zybTS9VRjYDAC-2tFfCaYJsPesbEhje6uuJzYMfJrHbw>
    <xmx:tZs7ZhZAZbQgLwX0-U2pxE0PPGXx3rqpLuGD_cN2faQBDMRetIKiBrio>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 May 2024 11:35:16 -0400 (EDT)
Date: Wed, 8 May 2024 08:37:35 -0700
From: Boris Burkov <boris@bur.io>
To: Lu Yao <yaolu@kylinos.cn>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: fix a compilation warning
Message-ID: <20240508153735.GB372255@zen.localdomain>
References: <20240507023417.31796-1-yaolu@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240507023417.31796-1-yaolu@kylinos.cn>

On Tue, May 07, 2024 at 10:34:17AM +0800, Lu Yao wrote:
> The following error message is displayed:
>   ../fs/btrfs/scrub.c:2152:9: error: ‘ret’ may be used uninitialized
>   in this function [-Werror=maybe-uninitialized]"
> 
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
> gcc version: (Debian 10.2.1-6) 10.2.1 20210110
> ---
>  fs/btrfs/scrub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 4b22cfe9a98c..afd6932f5e89 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2100,7 +2100,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
>  	struct btrfs_fs_info *fs_info = sctx->fs_info;
>  	const u64 logical_end = logical_start + logical_length;
>  	u64 cur_logical = logical_start;
> -	int ret;
> +	int ret = 0;
>  
>  	/* The range must be inside the bg */
>  	ASSERT(logical_start >= bg->start && logical_end <= bg->start + bg->length);
> -- 
> 2.25.1
> 

