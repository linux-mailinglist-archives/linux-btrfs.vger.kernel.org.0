Return-Path: <linux-btrfs+bounces-19498-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15139CA1A8F
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 22:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00AEA3004453
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Dec 2025 21:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0784A2BE7A7;
	Wed,  3 Dec 2025 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="aojE/agT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qZy8SU8R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A122BE7B4;
	Wed,  3 Dec 2025 21:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796889; cv=none; b=sgJ93vLrcOgNSqGMo8oUH+W83MhHLMuubpH2WFdflwO2hd0IHlE4gwzYmP5hmbZWw+S6KnDC2dSLggMWYvecLn4puHKNdvaectqF6ExRLypMkS/0n6lNPecxgfkq+gjNAH5RWc3N+UzsjF9Y/ilou/nXoHwPql0q8akgh+E8CGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796889; c=relaxed/simple;
	bh=AIkhICtH4DTfK/2SU3s3twcc2zxgRV6L8wc3Ds19FnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awtIKOkBbu1VFnUL5SiUJVA03RHolwfxPB3sCl1W53K+zrpz9ykJF5LYZp6FFgXrDshkL0+VGPiXvbfGV3P3NnJ1chIt2rgDSR2swowF4N/lTTtpHlryznSeIcYh8cj11kDXyGjO+OAym5S/hvMgrwH57QC5PGev66ZFvo1HXSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=aojE/agT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qZy8SU8R; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 056847A0186;
	Wed,  3 Dec 2025 16:21:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 03 Dec 2025 16:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764796885; x=1764883285; bh=8loxiW6iU1
	lTRylgVkYUvow6Eq+DRXPskyNJXcwBTqc=; b=aojE/agTXjL+3UjRUgxNtADENw
	NMPj/Q59AVyQpGfAqZrJTNE4jQ4WixGUr6cZgHS32ytGn1v7mpWbM1cgpObtEEbT
	RK7NNAbWa3uMFx02MBNi9/VSVdSGKspAL6v9aAzD5t2j5rDKm6OcjoI8kBg6pzWX
	sfnELXCN/w2R6AS803nAUDYjFgJLUv+NGZHMD/0qJatVBxWK3RuaGgr/yxvQqHvd
	PCuuka28wcIlt7JPeDTKcJG0H9gnkAJvAjrIC5s1PAUsigxn49JkmmDPSZG6EdGb
	My1uHB9TWXqyn6rmBPn5HQnLqF+kDItylnz98B2jXNGoVYc2zUDvCoVp+T+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764796885; x=1764883285; bh=8loxiW6iU1lTRylgVkYUvow6Eq+DRXPskyN
	JXcwBTqc=; b=qZy8SU8R4jSLxwnKi+VxG6dP9wJPR8TGsy8wk6gZ/95W+9a1Y+e
	llhfD/nWMdCBBtLmkRC+2cYIlSJxqsNw7x/dAeQFa/qHSVRSaXBI4yNk7395Ke6K
	ir8ZMd/1kBFA6bXMnGO1XVk6u3T0vkryeHWoMYgTL/LXwYYhQddZEvxvEHa4Lom/
	M/MrTtyoBsIW4KbjBysmJqzS4luW9dunryL4GYeuD6ZfeDM8xIg4ivB2i2rQGS8X
	I5osRwXGNPoW+NyGCEHGgwRbhpfTRVAuW4crGcJKIEkAPMKvgLVyJMNjznt4i0a9
	o6mm62BEfB7n32tx9NJT1yl6qjI+9rkTjVg==
X-ME-Sender: <xms:1akwaV7NTuYisvNEk6ynLZqQ81EpLmxeECkjd1yRHjVpZtg9PFdkwQ>
    <xme:1akwaUYPWTh6mewmvl1kSl5qqG5MG4zonvtLdQ04uPQ9OMHSWlWdonp_B2g7WVG2h
    Ae5rUtUf2QWcxDlwNAxHmHNLgJnJ-D9Kv-PYsvNcUgAGOsnljJFJREz>
X-ME-Received: <xmr:1akwacghQv_epi7M4Az72KtnMIdwj7-EJUY7XNHKQJDGPOjv8iSXck6ozaKM26jTUaOpzv1JPq22MlWeX9SxUS7uNZI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiud
    fguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeehpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehmphgvlhhlihiiiigvrhdruggvvhesghhmrghi
    lhdrtghomhdprhgtphhtthhopegtlhhmsehfsgdrtghomhdprhgtphhtthhopegushhtvg
    hrsggrsehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1akwad9r3rH5qkKI3meijs4bdj5NXHYF3MNP5tv7b5j5BGES8ojTlw>
    <xmx:1akwafqPa7o0Wp1fRNpBRrI3OkSdf_u1CpZF5KEdx5qp_qecSlOptQ>
    <xmx:1akwadUqEIGhTrCTD5CN3u8Fq6z_VmYB76z4TwQ8hO05w--APsMMKA>
    <xmx:1akwaWD1fPU3obeHnQS4nmW5gf-jBNCpoxWNFGQRInGwIHHDNh8B6Q>
    <xmx:1akwad3jF1yLJbZk-XmIfEf-BPaNL4MxBRxuK0IRxGTElFON5mN7OUoB>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 16:21:25 -0500 (EST)
Date: Wed, 3 Dec 2025 13:21:45 -0800
From: Boris Burkov <boris@bur.io>
To: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove dead assignment in prepare_one_folio()
Message-ID: <20251203212145.GC3589713@zen.localdomain>
References: <20251128174804.293605-1-mpellizzer.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128174804.293605-1-mpellizzer.dev@gmail.com>

On Fri, Nov 28, 2025 at 05:47:55PM +0000, Massimiliano Pellizzer wrote:
> In the error path of prepare_one_folio(), we assign ret = 0
> before jumping to the again label to retry the operation.
> However, ret is immediately overwritten by
> ret = set_folio_extent_mapped(folio).
> 
> The zero assignment is never observerd by any code path,
> therefore it can be safely removed.
> 
> No functional change.

This looks fine to me. But given the fact that we are setting ret = 0
before entering the again: loop, this code is maintaining that
(unneeded) invariant. So I think we should remove both or neither.

I would lean towards removing both, but I don't feel strongly about it.

Thanks,
Boris

> 
> Signed-off-by: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
> ---
>  fs/btrfs/file.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 7a501e73d880..7d875aa261d1 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -877,7 +877,6 @@ static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_
>  		/* The folio is already unlocked. */
>  		folio_put(folio);
>  		if (!nowait && ret == -EAGAIN) {
> -			ret = 0;
>  			goto again;
>  		}
>  		return ret;
> -- 
> 2.51.0
> 

