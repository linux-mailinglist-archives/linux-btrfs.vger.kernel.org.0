Return-Path: <linux-btrfs+bounces-20287-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE326D05926
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 19:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C847306C987
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 18:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC15031195C;
	Thu,  8 Jan 2026 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ENk30/hj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MkTiaTqU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFD1319870
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897118; cv=none; b=fS8tI5n0P+rw7bajcXcOSLYnNGAw9m9qYD7NPhVB4oBWZEcEuAphqMIJFISwmPb+CE9wELy1iWOPgPb+SogJ8fw033b+HNpsm8GoLkTbKCJBbsjZUthXTq7kRGrPtGuiRv2owwzcxxxl4sImLS7I/isu0wINpop3crzPf1CyhyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897118; c=relaxed/simple;
	bh=mQgGFCHW0HNlXIlNQA+SuPPU7wKeqIus1C8VefyOsOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQlksNLywlribiJYM0k+F7pHWKk9OLsc7jueALhJ/6fpW7NxQX4M1unLxY5yV2d86tMtoGzCHBP9w8/VM3bdyRhqbpcwuHljajPTzYCjudmAlU6RhZYw6wJA1iVI5xSg/1OVbh9ggRBIePSWehqXTw0NTvDmEck7pO9Kmb/O2uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ENk30/hj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MkTiaTqU; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 666587A005A;
	Thu,  8 Jan 2026 13:31:55 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 08 Jan 2026 13:31:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767897115; x=1767983515; bh=5qrqLDd9U8
	MH49b7Ddgmvgs8IuDIqbTjxn9jw6WJCPs=; b=ENk30/hjvUoMs8hR6i0SGSCLz5
	ij28f3GNqEUgk5ln67JSbw2065jHT/1PVkpO5ozofBJit3ujzzZkcL4pZ8fyapGp
	Om8oIwuOC6bHdh85tvrlB0WDe4v/rY7zShr3wL8M4VN0dW28KnMNRRnsTfveSY9j
	hHkgfAtTbsgYdc7vj1AR3wmuWSAbEWXo3nOMhwroD5mqGJK2auUfGlVxzTy6G5Lp
	AxnT9z0joyrwF03rwAh6Aq0UkV0WI99kEoPRyjoa1rI2s5eGzOycLPcMZn9ASyut
	ISG/I5g64x3C7gbXAgUh7Ew9IOcCIzbsSEXILGDIOesmudL7oWzoJ7fHlQEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767897115; x=1767983515; bh=5qrqLDd9U8MH49b7Ddgmvgs8IuDIqbTjxn9
	jw6WJCPs=; b=MkTiaTqUwoMIf/OVuu6C1mXVaaVcFeGHrbBsovmHHu52FHs5N4s
	nkhw45YZ4imeZIBLAPkLeO0RUAl/0U/F6fxRw9R4Mo54T7YsVUUHeKkSoRotl9FL
	jvmvr1iBwCrSbNmfeNRmL/rjWloqrmEprPLAvfkBd6wmYxDVqTH0j9eCghiHmTcU
	DTkRTFltczj0rEGgBDaAmufs0KeZcWgfrHB/2AtI+HAmpkouUNkTZ2R0DSszUhzC
	J67HIKB51uzeblG/WaGDIqUyJS902CjQjUrCestpbtYpOcxKT5WEvp638bmHS3E8
	kgG6zPRDB5GvWQvgcu/sFVI8K+ueJRZlfog==
X-ME-Sender: <xms:G_hfaVi6C9ouaIYp5krIzrLVyTZtdeQf4EZ_Mefth96oGHmZEHcbkA>
    <xme:G_hfaQAHHVKE3LvzFA8WYlyklsBUHqYuSAR6hgqV6nvrz7Ry792YfY67lXYs1ShR2
    J2yv0bh0JX2r1ne8Pt26mCfgw_8dR-asLHc28vJB_EP_9Xb43fM8Pw>
X-ME-Received: <xmr:G_hfaSvx7rKfVTbxZJpJEP7CfdGurs8UKex0_GHfeAJEXG-vMk-PudCvZsGHLdrqgIjBcT_5pZxkXtd-QVwA3YEJEaE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeiieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepughsthgvrhgsrgesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrh
    hfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:G_hfaVaa56H5svDa5zyee38hR2aKAzFAVJaQdRmCK7orE_Io3zalbQ>
    <xmx:G_hfaVV4VMnsJv0xBxl8a3tx10Esm7yUYB987AVuFaPR5CVm3TDPxA>
    <xmx:G_hfaZ6FB99sNKDYfvoYuJh8gue-KYVbcmMf2VejUKmtGDO43u1-jg>
    <xmx:G_hfaQiLfMU-58S3oWa6oQlZmGXXGO_20Y_k5P69cFPz9wUC7Mit-Q>
    <xmx:G_hfabvujVpz4ODKboTwbLQ0bu9q25KAVlAFFDQaK7Ajd3X9fUH-TgaA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 13:31:54 -0500 (EST)
Date: Thu, 8 Jan 2026 10:32:03 -0800
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/12] btrfs: use common eb range validation in
 read_extent_buffer_to_user_nofault()
Message-ID: <20260108183203.GG2216040@zen.localdomain>
References: <cover.1767716314.git.dsterba@suse.com>
 <1a00041c9fec994ea70ba05edad7fd53a1630bc2.1767716314.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a00041c9fec994ea70ba05edad7fd53a1630bc2.1767716314.git.dsterba@suse.com>

On Tue, Jan 06, 2026 at 05:20:28PM +0100, David Sterba wrote:
> The extent buffer access is checked in other helpers by
> check_eb_range(), which validates the requested start, length against
> the extent buffer. While this almost never fails we should still handle
> it as an error and not just warn.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/extent_io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 97cf1ad91e5780..897ea52167c612 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4003,8 +4003,8 @@ int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
>  	unsigned long i;
>  	int ret = 0;
>  
> -	WARN_ON(start > eb->len);
> -	WARN_ON(start + len > eb->start + eb->len);
> +	if (check_eb_range(eb, start, len))
> +		return -EINVAL;
>  
>  	if (eb->addr) {
>  		if (copy_to_user_nofault(dstv, eb->addr + start, len))
> -- 
> 2.51.1
> 

