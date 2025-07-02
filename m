Return-Path: <linux-btrfs+bounces-15207-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E32CAF6096
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 19:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1F95248D2
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 17:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B49130AAD2;
	Wed,  2 Jul 2025 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="npikOab1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y0qp1CY/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EBC30113A
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Jul 2025 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751479043; cv=none; b=MlAEd18lnlCoxSFmFNkliSc9v5VHE5nrVVkAnprtdlkr4wFEKIPVmTIYJ1O6ZjpEvwE9VogGE9LNhuiKHrBiqMIu6brJwvfGXo5tqoCyDwoUEQlzOTiHEBW+DBz9BxKryse5/r1Vp/xAObDsroERAX0pge3D/aNCsRdal6ry0JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751479043; c=relaxed/simple;
	bh=DL3inrbvuCnO8NBI6Wa+qf6xaQ57Lm94OdiMcQ6LpPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXeLIfgNMLT+UNo1xRqJAszTvPwIFzzmqpmpG32bGogNyLXTzbGXbdbuVZLS74kbrrJIov+qxGFy0y1eZxDz9bFmHao1HJGYSQ6x1SRpfxUoYj8s8f1fjvLECnXVMVe8xD2G/8Ae4BZSliAa3+p4n+Y5AsHg8hukUBmbAr0aZjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=npikOab1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y0qp1CY/; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6C6997A0288;
	Wed,  2 Jul 2025 13:57:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 02 Jul 2025 13:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1751479039; x=1751565439; bh=vUciGWO/8q
	aCkE1g+9Y9udBufNm2BCJbO5pSjlrFPTk=; b=npikOab1fx48fHuDzBv7hmu0UI
	dMd7X1ytsSgK7I4QSWN1HbrpoKT/2jubX1EgCB55FoONViSN0QHL+wPw0VYT1TQx
	U8ZWO6wWwWCqTp1E88IsExmlkBrpitG8uVSAwweIhbMi8Bmn6A7fL7mBXvCthtzO
	c3sh/KK9cp6ButpVdxilr9JW5QDnYaT2V0hVB98ZhVu309QVMqbTLLJzOPT7VmKR
	DreGBxfS+sOdrRYC0kRRshbpIfUGH9P5yMjthLc84i1NqHWSluQhZ8HyNMvDvs2X
	tJLWSxeUUFzQXhk/ASsAFxcf7X0P7gzKu4MvkvmIRPTsN/KXLzz1mX7267tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751479039; x=1751565439; bh=vUciGWO/8qaCkE1g+9Y9udBufNm2BCJbO5p
	SjlrFPTk=; b=Y0qp1CY/I3OKCafct82st+pGUqZJ6NSJHkp3KhdFBi68iXxr6s/
	Iack7YTXvFZD1PXOE1MwTHq937xnxW+B8jGsL5ZN1XP/pnEKOZQHY4tNsRWatgHy
	gNDBC9R9+r1KFdQTwCE4xGS9PWOryUUSp5TKvMEfhZmkVHXz3BeSppxhoUacJ1SH
	Weq5AIdzvlCG6JTxP3RWMqqmYGkz6N2tusxOqGfrKsTivj/YQZsr3zm5m1qXkiW7
	ImXMLHCsFieMYgYcFzW5e+A+KetC8TqtZKgsNLc4tsZjI2zVUmGYOCOVkBv9KMk+
	z0HsJzo1n16bru1QJLlJSszwZLTDWWuZsIA==
X-ME-Sender: <xms:_3JlaLmfpmIuO45ouM9eiImDQeogi8yyNe69OTBzq9yWHE4q-RFrDQ>
    <xme:_3JlaO1T9KhorpBc8b3o0IB_JOiSPb2V0vKQ-gRDAfC2oCODniOEa_NfWSXcIgROX
    WH5PQdFaXdPFRO-ktU>
X-ME-Received: <xmr:_3JlaBoCS08Z-lZlJbN4V7F_Olk3XFcWDZkRV3XbFxjfqxZECoOWEN8Hb4-GnWbfsnv85gD37l2epEEkvZF3uOvtVFM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvke
    ffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegushhtvghrsggrsehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfh
    hssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_3JlaDmtrueQykkvH62QicSaBaR9rAzG87qxO7YYyKc1uobgb3sr5w>
    <xmx:_3JlaJ270O818mrRy5TtmjWtc5xYVK92nfoinWWf6VjIfqn4Ikv4Pg>
    <xmx:_3JlaCuMEUD4SZRR6DRNevB9RsE0fLX4G0Vt5g9cVqem3AgjhnhFFg>
    <xmx:_3JlaNXhqP9ehbLzbga1I1CES5HAJ8SKilqo5hhFaq_TkmD8Qmmk3w>
    <xmx:_3JlaKHRexL-bxfWAlFCBfOOkQNQm-fc21D6662UaO0WMJvqRVgnbsdR>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Jul 2025 13:57:18 -0400 (EDT)
Date: Wed, 2 Jul 2025 10:58:54 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/7] btrfs: accessors: use type sizeof constants directly
Message-ID: <20250702175854.GA2308047@zen.localdomain>
References: <cover.1751390044.git.dsterba@suse.com>
 <eedbe03f6ee33939841d4bf895519304dfa1c59f.1751390044.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eedbe03f6ee33939841d4bf895519304dfa1c59f.1751390044.git.dsterba@suse.com>

On Tue, Jul 01, 2025 at 07:23:49PM +0200, David Sterba wrote:
> Now unit_size is used only once, so use it directly in 'part'
> calculation. Don't cache sizeof(type) in a variable. While this is a
> compile-time constant, forcing the type 'int' generates worse code as it
> leads to additional conversion from 32 to 64 bit type on x86_64.
> 
> The sizeof() is used only a few times and it does not make the code that
> harder to read, so use it directly and let the compiler utilize the
> immediate constants in the context it needs. The .ko code size slightly
> increases (+50) but further patches will reduce that again.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/accessors.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
> index b54c8abe467a06..2e90b9b14e73f4 100644
> --- a/fs/btrfs/accessors.c
> +++ b/fs/btrfs/accessors.c
> @@ -52,19 +52,17 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
>  	const unsigned long idx = get_eb_folio_index(eb, member_offset);\
>  	const unsigned long oil = get_eb_offset_in_folio(eb,		\
>  							 member_offset);\
> -	const int unit_size = eb->folio_size;				\
>  	char *kaddr = folio_address(eb->folios[idx]);			\
> -	const int size = sizeof(u##bits);				\
> -	const int part = unit_size - oil;				\
> +	const int part = eb->folio_size - oil;				\

nit: the names oil and part are pretty non-sensical to me. Oil used to
be oip for Offset In Page. Is it Offset In foLio?

I can't figure out what part should mean.

So while I see why you're doing all the changes, I can' help but notice
that you removed the two named variables with logical names and left the
confusing ones. :)

>  	u8 lebytes[sizeof(u##bits)];					\
>  									\
> -	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
> +	ASSERT(check_setget_bounds(eb, ptr, off, sizeof(u##bits)));	\
>  	if (INLINE_EXTENT_BUFFER_PAGES == 1 || likely(sizeof(u##bits) <= part))	\
>  		return get_unaligned_le##bits(kaddr + oil);		\
>  									\
>  	memcpy(lebytes, kaddr + oil, part);				\
>  	kaddr = folio_address(eb->folios[idx + 1]);			\
> -	memcpy(lebytes + part, kaddr, size - part);			\
> +	memcpy(lebytes + part, kaddr, sizeof(u##bits) - part);		\
>  	return get_unaligned_le##bits(lebytes);				\
>  }									\
>  void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
> @@ -74,13 +72,11 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
>  	const unsigned long idx = get_eb_folio_index(eb, member_offset);\
>  	const unsigned long oil = get_eb_offset_in_folio(eb,		\
>  							 member_offset);\
> -	const int unit_size = eb->folio_size;				\
>  	char *kaddr = folio_address(eb->folios[idx]);			\
> -	const int size = sizeof(u##bits);				\
> -	const int part = unit_size - oil;				\
> +	const int part = eb->folio_size - oil;				\
>  	u8 lebytes[sizeof(u##bits)];					\
>  									\
> -	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
> +	ASSERT(check_setget_bounds(eb, ptr, off, sizeof(u##bits)));	\
>  	if (INLINE_EXTENT_BUFFER_PAGES == 1 ||				\
>  	    likely(sizeof(u##bits) <= part)) {				\
>  		put_unaligned_le##bits(val, kaddr + oil);		\
> @@ -90,7 +86,7 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
>  	put_unaligned_le##bits(val, lebytes);				\
>  	memcpy(kaddr + oil, lebytes, part);				\
>  	kaddr = folio_address(eb->folios[idx + 1]);			\
> -	memcpy(kaddr, lebytes + part, size - part);			\
> +	memcpy(kaddr, lebytes + part, sizeof(u##bits) - part);		\
>  }
>  
>  DEFINE_BTRFS_SETGET_BITS(8)
> -- 
> 2.49.0
> 

