Return-Path: <linux-btrfs+bounces-15210-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039F1AF61DD
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 20:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963F4486CC8
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 18:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C007B2D0C9D;
	Wed,  2 Jul 2025 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Qt0jvtiO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N/DLXCT1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131FA1E633C
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Jul 2025 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751482325; cv=none; b=Q7xN2ionXp/f2gb9UZ1l+doPMipc663lxasxj5OurYspfl+338VPwWwW0Jz5qwuTjuAUQXLAn+4/9Ggm4x0zqTegrQVsJB70d5KC1HOg5hgozdzgcWD2WyS8ECFphlHhNR1gbiM5K1Yy0SalZhanipLYiDz0n67nn4SZuAMoj9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751482325; c=relaxed/simple;
	bh=QdjAUuOoR0g3UTQdP4LHvNLcDWUUlSUa5hXi7bete18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQm2V88kwr0IipRXmhbn8XJU+NDQE4HxmSlHXjG5KlpPWEYYEjd16Oe68iUngyzWpFlsmP9nKH+H7WaM5X7zOsSGQEQPoX1z28hqc8G5x/kGoUcx9JQnkvKUfQs6qcsXkwyoTVXuJqzO+maw9BqT00rAJOXIsLGsjctfBQFPdAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Qt0jvtiO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N/DLXCT1; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4025614001B6;
	Wed,  2 Jul 2025 14:52:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 02 Jul 2025 14:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1751482323; x=1751568723; bh=gBkdAmDkmV
	1l0Yhgd2Kf3vGDr8A2L6i7IFJZPcCSP2k=; b=Qt0jvtiO3PDDvRuASnP9+17dpR
	oGUwQjfS0nd3pink7n8fUAFxJDIPcJMsTkJ/TXxOwa8w+B5hCtvn3T8yuTnvyCTo
	ROwgJ13z1jp2/lXjxlaqdr/bHfLkc4/rEpyPB69RDyUGXXvuOuH3FgUIXUITkX8z
	jIlRrI756LUtufnGTx2mZlXVozwCE18w1vAbKpJwgjISXEu/6N9Ctq8BsBPp3JEH
	HZPqGY6ZvcXbFoQwEuqNjG03jEtS2OeuTS88iaUE6Mj8yP3n9KaEyhyFh38BBEQj
	3wiDQgoF426OePjH71C/6J27RT5NF1irscpHUdL7sen/Ns9DKAeXGL9Q5QPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751482323; x=1751568723; bh=gBkdAmDkmV1l0Yhgd2Kf3vGDr8A2L6i7IFJ
	ZPcCSP2k=; b=N/DLXCT1BbsPFT9W0NGti1jVUgmvAUx9+nc5ycOwo/pIfAoh+Ho
	5RtZDrN2Q8/IrvpYkJg2JpJpjrVI+75wG4n756txPISbEqLd97PnNBmPebsM1NBz
	Zfpb7fufDn2s5HUoS3mLQhumJ7AN+M420nFxj8Dm+sqjugO990Jrcmnds8fblinw
	cXVe1/RmniTVP5NUtCyTczEpZy4oXU8yr9zodDXebfFpOzUKTv+ppHQ3g1zEr399
	Tyzl8/LDHfm7i2vVQBZ64/zU36GKRdn5+hmSZ26GghVTmJilBThQnI0ac1ThVhlK
	P/gstAsHHWXpP/qka7q0GkmZ1m5+NebkOng==
X-ME-Sender: <xms:0n9laPkZ_FCLK07-SYb6ak2lkXwbIDquYyO4LA5RaMLjDMigFENFDA>
    <xme:0n9laC3hLiKtdY4AhsvcBoUtK1m3MpMLRmy8pESyYCmLII5KZh8lUGFP6FskNJ4Zx
    xqXNBuqduO3ZdY8dpE>
X-ME-Received: <xmr:0n9laFqmID8mMloadz0HOLYLXnB-AJX3OUJLyM1_PLAm_xkr88HxBP_7849CPFMPznabwkEY9Z2cd9ez9MrxSeAiVsc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvke
    ffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegushhtvghrsggrsehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfh
    hssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0n9laHkcN-LPzkEeijAZ6c6vckOTfoYE3SkeugDvG8AhLtHpFYLKDA>
    <xmx:0n9laN2Z2z7GH_85i_YcKNjhici51QL3ygNfAHjBTkGmZGAUsUV3Rw>
    <xmx:0n9laGutXw4R8Nu0PEAgew_XG3JX9ICkAj2gavV53VLGuPrGJgovQA>
    <xmx:0n9laBWKzC9mFllD8QpNEf-04eKaByIrnFAnzF9YqO-0KwCdRd2IGg>
    <xmx:039laOFNnQdvxo_mcvGaWHJF8hhREtsGjlJlga2jZ89O4BiOaQ04qUUR>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Jul 2025 14:52:02 -0400 (EDT)
Date: Wed, 2 Jul 2025 11:53:37 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 7/7] btrfs: accessors: factor out split memcpy with two
 sources
Message-ID: <20250702185337.GC2308047@zen.localdomain>
References: <cover.1751390044.git.dsterba@suse.com>
 <1db66bf81b5790c6e14183a5c30a8abf6d1b1126.1751390044.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1db66bf81b5790c6e14183a5c30a8abf6d1b1126.1751390044.git.dsterba@suse.com>

On Tue, Jul 01, 2025 at 07:23:54PM +0200, David Sterba wrote:
> The case of a reading the bytes from 2 folios needs two memcpy()s, the
> compiler does not emit calls but two inline loops.
> 
> Factoring out the code makes some improvement (stack, code) and in the
> future will provide an optimized implementation as well. (The analogical
> version with two destinations is not done as it increases stack usage
> but can be done if needed.)

Is there some fundamental reason for this, or does it just happen to be
so? Sort of interesting either way. Does it make you worry that this
stuff will regress randomly in the future?

> 
> The address of the second folio is reordered before the first memcpy,
> which leads to an optimization reusing the vmemmap_base and
> page_offset_base (implementing folio_address()).
> 
> Stack usage reduction:
> 
>   btrfs_get_32                                           -8 (32 -> 24)
>   btrfs_get_64                                           -8 (32 -> 24)
> 
> Code size reduction:
> 
>      text    data     bss     dec     hex filename
>   1454279  115665   16088 1586032  183370 pre/btrfs.ko
>   1454229  115665   16088 1585982  18333e post/btrfs.ko
> 
>   DELTA: -50
> 
> As this is the last patch in this series, here's the overall diff
> starting and including commit "btrfs: accessors: simplify folio bounds
> checks":
> 
> Stack:
> 
>   btrfs_set_16                                          -72 (88 -> 16)
>   btrfs_get_32                                          -56 (80 -> 24)
>   btrfs_set_8                                           -72 (88 -> 16)
>   btrfs_set_64                                          -64 (88 -> 24)
>   btrfs_get_8                                           -72 (80 -> 8)
>   btrfs_get_16                                          -64 (80 -> 16)
>   btrfs_set_32                                          -64 (88 -> 24)
>   btrfs_get_64                                          -56 (80 -> 24)
> 
>   NEW (48):
> 	  report_setget_bounds                           48
>   LOST/NEW DELTA:      +48
>   PRE/POST DELTA:     -472
> 
> Code:
> 
>      text    data     bss     dec     hex filename
>   1456601  115665   16088 1588354  183c82 pre/btrfs.ko
>   1454229  115665   16088 1585982  18333e post/btrfs.ko
> 
>   DELTA: -2372

Sweet!

> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/accessors.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
> index af11f547371815..f554c4f723617f 100644
> --- a/fs/btrfs/accessors.c
> +++ b/fs/btrfs/accessors.c
> @@ -20,6 +20,15 @@ static void __cold report_setget_bounds(const struct extent_buffer *eb,
>  		   (unsigned long)ptr, eb->start, member_offset, size);
>  }
>  
> +/* Copy bytes from @src1 and @src2 to @dest. */
> +static __always_inline void memcpy_split_src(char *dest, const char *src1,
> +					     const char *src2, const size_t len1,
> +					     const size_t total)
> +{
> +	memcpy(dest, src1, len1);
> +	memcpy(dest + len1, src2, total - len1);
> +}
> +
>  /*
>   * Macro templates that define helpers to read/write extent buffer data of a
>   * given size, that are also used via ctree.h for access to item members by
> @@ -64,9 +73,9 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
>  		kaddr = folio_address(eb->folios[idx + 1]);		\
>  		lebytes[1] = *kaddr;					\
>  	} else {							\
> -		memcpy(lebytes, kaddr, part);				\
> -		kaddr = folio_address(eb->folios[idx + 1]);		\
> -		memcpy(lebytes + part, kaddr, sizeof(u##bits) - part);	\
> +		memcpy_split_src(lebytes, kaddr,			\
> +				 folio_address(eb->folios[idx + 1]),	\
> +				 part, sizeof(u##bits));		\
>  	}								\
>  	return get_unaligned_le##bits(lebytes);				\
>  }									\
> -- 
> 2.49.0
> 

