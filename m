Return-Path: <linux-btrfs+bounces-20219-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA50D0043F
	for <lists+linux-btrfs@lfdr.de>; Wed, 07 Jan 2026 23:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C27393013E87
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jan 2026 22:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B402FC881;
	Wed,  7 Jan 2026 22:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="PI5dIlaK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fiobfasV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6BB2E6CB8
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Jan 2026 22:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767823265; cv=none; b=pxw7JwmaYo4DgRpkJ2Rp2wMGTfBr2g/Gga32dK5pq4cvngmiicVhzA3BhMuTudc4IoDcOgd/tRLLjBHFmXs1OpZCR2kzsYEPpLqnwAen7UiRrukzhsN76+UNoyMaW6RMFtCdHwhOBf4kxEsNJX+xTqdop/AKYfl04zxM5js2n8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767823265; c=relaxed/simple;
	bh=i1gc0DIs0UVTSufU0obuvK3tQHnBpVuWrLs1pE2wo4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvQKVMGgA3icKkkE0TTh8qRYHmmTBe/XhTwpqNm8DqGGCbElwcrHTC9tX1dj1zvFJT24b+q9IA9zjzaJSWFkJPn+k9rDZHQTxoQDIGd56FVnRoPTfOcQgJyfiTxnBe8whRr8mhZiBI42mdXS4n0TjqHaTNSUPwHE6YTiBW+1UKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=PI5dIlaK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fiobfasV; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 85FAA1400134;
	Wed,  7 Jan 2026 17:01:01 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 07 Jan 2026 17:01:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767823261; x=1767909661; bh=kXTgEfOxEc
	SysfLcFtFG9KveXwNADhXJYznPQnhjpcU=; b=PI5dIlaKS/O3dqq7p42MofhZ7B
	9XF8KoeWKiUYEerobujjlvSMXAO9lo0CPtY8YjNpD+x8NPFOdNY4eAKQ6IuWVwgi
	FpzX6IF11MqsS5oE23zHZFBYSN74BKs0xFcvyZatdBr6PDqUuSSSb5avAL33RUZp
	UNxejjK2/og7LlMFTbU5J+/0U7yNEtgu/sknYqiCkfM8QplGwurcmCgHdCdPSANw
	iWqxJC0tiY54R/TIkGDK8yuirxq4+X9h9+nvREWZNs/9yt2BlziEgDfRXjt2/xDB
	860I/HmZxYYceAv63pHPMKWKdU0JZwF0Bt0P5oENdoE05MGnxdMcPEqw+Q7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767823261; x=1767909661; bh=kXTgEfOxEcSysfLcFtFG9KveXwNADhXJYzn
	PQnhjpcU=; b=fiobfasVmxDbPQDNLDBu40KyNpNttgHooM17p88k/1MZyp65lnk
	6W+7iaFXP72lDfYyhUeWOcrbCuGJTgR7wxZ1fZZ8xa69hm0GXU+8lyQYcJVplhcn
	bTJiI4YeUJmB4HRXi1/hP4yTg/MP1GkFMePSwG141q/h27G/uS6ou4UipY7o1Pod
	bggnCd0D9y/71z7PKfmJoHWphKOdv1XVsJz/xW1B5PS7sgoTtNGK9txztaZxdQ9J
	lJzz1TvjEA1Zv/2Hb08DSkERFO19ZAz5beNippSRGNL8k1+CrshKJ5hU88xHZqYH
	s3rMgl5jqlgHu4M3KyBYsmbenv3HiDF5/MQ==
X-ME-Sender: <xms:nddeaWziABbX_HLmSGvcVZn9IfyXJ_lNtSMdq1Qsaty9UxruhSzQ0A>
    <xme:nddeaYQP8WVRh7wTHg_C4Z52gdX-_peCcnNRnPW9VGfebf0QMMA6n6hOZVjDE-Y_g
    x4kjuT2HW_9wtx7mvqH4Ue0LnoU53u6MLObSBnaCzq8ZYym9_n7omY>
X-ME-Received: <xmr:nddeaV8pjfV6n_Cmmn5qPLSFD19bfOcCffUh5HJQjXXITBIeMLr9GRavasETn0tMffBF7p-oEyD_i3Ru6bXMkPPfvtE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdegvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepughsthgvrhgsrgesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrh
    hfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nddeaXpAtA28xU5uAawtbpNAvutHI3QdkrfvsVyRUjSwHNYTQWkXWw>
    <xmx:nddeaamN6-0c4lxisfxViNpz-f0nm8ECI_xxdqFhc863TmDlFcz84A>
    <xmx:nddeaWIS9bF6COoHKUib9imT0b-KHqzXKF8amV8Z_xZeeKqB7SrPCQ>
    <xmx:nddeaXySyb0fJEtjE1QXRHh-Po6Cac6iQMdzmsdH4r9DBocjW-C6Vw>
    <xmx:nddeaW-OZ1IKpfG--hCH-APEVHehJVsDYSR5GeJOc1g-WSFfwK1lCmaJ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 17:01:00 -0500 (EST)
Date: Wed, 7 Jan 2026 14:01:11 -0800
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/12] btrfs: read eb folio index right before loops
Message-ID: <20260107220111.GF2216040@zen.localdomain>
References: <cover.1767716314.git.dsterba@suse.com>
 <447e5571c40fef2bd83cc8c1580b2747c9eb41a3.1767716314.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447e5571c40fef2bd83cc8c1580b2747c9eb41a3.1767716314.git.dsterba@suse.com>

On Tue, Jan 06, 2026 at 05:20:27PM +0100, David Sterba wrote:
> There are generic helpers to access extent buffer folio data of any
> length, potentially iterating over a few of them. This is a slow path,
> either we use the type based accessors or the eb folio allocation is
> contiguous and we can use the memcpy/memcmp helpers.
> 
> The initialization of 'i' is done at the beginning though it may not be
> needed. Move it right before the folio loop, this has minor effect on
> generated code in __write_extent_buffer().

This seems fine, but also pointless. One right shift that the compiler
*can* move is causing us real pain? How often are we reading/writing
extent_buffers? Should I be constantly worried about any arithmetic I
ever do a hair early just to make code easier to read?

Anyway, if you do think it's worth it, you can add

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/extent_io.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index bbc55873cb1678..97cf1ad91e5780 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3960,7 +3960,7 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
>  	size_t cur;
>  	size_t offset;
>  	char *dst = (char *)dstv;
> -	unsigned long i = get_eb_folio_index(eb, start);
> +	unsigned long i;
>  
>  	if (check_eb_range(eb, start, len)) {
>  		/*
> @@ -3977,7 +3977,7 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
>  	}
>  
>  	offset = get_eb_offset_in_folio(eb, start);
> -
> +	i = get_eb_folio_index(eb, start);
>  	while (len > 0) {
>  		char *kaddr;
>  
> @@ -4000,7 +4000,7 @@ int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
>  	size_t cur;
>  	size_t offset;
>  	char __user *dst = (char __user *)dstv;
> -	unsigned long i = get_eb_folio_index(eb, start);
> +	unsigned long i;
>  	int ret = 0;
>  
>  	WARN_ON(start > eb->len);
> @@ -4013,7 +4013,7 @@ int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
>  	}
>  
>  	offset = get_eb_offset_in_folio(eb, start);
> -
> +	i = get_eb_folio_index(eb, start);
>  	while (len > 0) {
>  		char *kaddr;
>  
> @@ -4041,7 +4041,7 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
>  	size_t offset;
>  	char *kaddr;
>  	char *ptr = (char *)ptrv;
> -	unsigned long i = get_eb_folio_index(eb, start);
> +	unsigned long i;
>  	int ret = 0;
>  
>  	if (check_eb_range(eb, start, len))
> @@ -4051,7 +4051,7 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
>  		return memcmp(ptrv, eb->addr + start, len);
>  
>  	offset = get_eb_offset_in_folio(eb, start);
> -
> +	i = get_eb_folio_index(eb, start);
>  	while (len > 0) {
>  		cur = min(len, unit_size - offset);
>  		kaddr = folio_address(eb->folios[i]);
> @@ -4111,7 +4111,7 @@ static void __write_extent_buffer(const struct extent_buffer *eb,
>  	size_t offset;
>  	char *kaddr;
>  	const char *src = (const char *)srcv;
> -	unsigned long i = get_eb_folio_index(eb, start);
> +	unsigned long i;
>  	/* For unmapped (dummy) ebs, no need to check their uptodate status. */
>  	const bool check_uptodate = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
>  
> @@ -4127,7 +4127,7 @@ static void __write_extent_buffer(const struct extent_buffer *eb,
>  	}
>  
>  	offset = get_eb_offset_in_folio(eb, start);
> -
> +	i = get_eb_folio_index(eb, start);
>  	while (len > 0) {
>  		if (check_uptodate)
>  			assert_eb_folio_uptodate(eb, i);
> @@ -4213,7 +4213,7 @@ void copy_extent_buffer(const struct extent_buffer *dst,
>  	size_t cur;
>  	size_t offset;
>  	char *kaddr;
> -	unsigned long i = get_eb_folio_index(dst, dst_offset);
> +	unsigned long i;
>  
>  	if (check_eb_range(dst, dst_offset, len) ||
>  	    check_eb_range(src, src_offset, len))
> @@ -4223,6 +4223,7 @@ void copy_extent_buffer(const struct extent_buffer *dst,
>  
>  	offset = get_eb_offset_in_folio(dst, dst_offset);
>  
> +	i = get_eb_folio_index(dst, dst_offset);
>  	while (len > 0) {
>  		assert_eb_folio_uptodate(dst, i);
>  
> -- 
> 2.51.1
> 

