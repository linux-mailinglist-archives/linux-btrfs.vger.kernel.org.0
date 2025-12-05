Return-Path: <linux-btrfs+bounces-19533-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E65CA6218
	for <lists+linux-btrfs@lfdr.de>; Fri, 05 Dec 2025 06:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 757FD318402E
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Dec 2025 05:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB942DF141;
	Fri,  5 Dec 2025 05:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkPaTak3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685074A35;
	Fri,  5 Dec 2025 05:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764910844; cv=none; b=gJijnegDFPXB2keQj+q5xKqjn0vccsTxoLRD3i+Sly49jbR5GGwbUvx9QdQmcMDXlXUDXGDKtJRLdC5fgjVFBgXGJC7WzcEjUUPWBsgtpN2W6QDFZN5xnesj9p77GKOZS9+n6DPTIyzIZvnB5ZnBLKvJrs78BCvDtk1Zkpj+73o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764910844; c=relaxed/simple;
	bh=kN54tH5UrzydrUIGyDiyvO626n7A2/Oz/NhOOG2V9uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcoYq5U7yeRf6oRh/A3HDhDDITVwnChrMxaZRSrR1c/M0NM/9pNZ6dPHHn/Y4iyqwd/iOmCLuuKxzNs2Lh7S/qYmQOA64REskcnTdLm+ga5ziv9RqqBPF6D9l7RJXs0D4X9WrCa04R7ZMJt01eNsPAyaAdwXVvC25PrZGacpXXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkPaTak3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4DDC4CEF1;
	Fri,  5 Dec 2025 05:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764910843;
	bh=kN54tH5UrzydrUIGyDiyvO626n7A2/Oz/NhOOG2V9uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AkPaTak3ZhHP1f+KoGz8dNjzJ8iJT1MsTDqr1g3aFKyt7ycZdmRkipFP1sXE7wNzm
	 agTsoiz1AN1CccSikYvT1IzMAoT7HfaW/xAg06FZIsJ3vaFnhr4ySK3LZpzGplyF1n
	 UxyhRjzE1MA6y5qRnBYziheLyTMPGGPjWMr9ai/fGBcH4v5jrrlYNdR0rmzM/JDLlq
	 9CvyDVC0zU1n2Ywl4GXsmcu7CNMhj6XZnbKaraxJVTdVdNNMJhnhUjOdwyO6r4QpGF
	 lDiIzxBXFwX+eBQ9Vvb+m3IdOiKEQ29pL+r1IDesQlHek58VDtymtzqyTbHYAKQsXn
	 itJbU8oHJNWtg==
Date: Thu, 4 Dec 2025 20:58:49 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	David Laight <david.laight@runbox.com>,
	David Sterba <dsterba@suse.com>, llvm@lists.linux.dev,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] lib/crypto: blake2b: Roll up BLAKE2b round loop on 32-bit
Message-ID: <20251205045849.GB6421@sol>
References: <20251203190652.144076-1-ebiggers@kernel.org>
 <aTHLUIjqCHlRs8rr@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTHLUIjqCHlRs8rr@zx2c4.com>

On Thu, Dec 04, 2025 at 12:56:32PM -0500, Jason A. Donenfeld wrote:
> On Wed, Dec 03, 2025 at 11:06:52AM -0800, Eric Biggers wrote:
> >  	G(r, 4, v[0], v[ 5], v[10], v[15]); \
> >  	G(r, 5, v[1], v[ 6], v[11], v[12]); \
> >  	G(r, 6, v[2], v[ 7], v[ 8], v[13]); \
> >  	G(r, 7, v[3], v[ 4], v[ 9], v[14]); \
> >  } while (0)
> > -		ROUND(0);
> > -		ROUND(1);
> > -		ROUND(2);
> > -		ROUND(3);
> > -		ROUND(4);
> > -		ROUND(5);
> > -		ROUND(6);
> > -		ROUND(7);
> > -		ROUND(8);
> > -		ROUND(9);
> > -		ROUND(10);
> > -		ROUND(11);
> > +
> > +#ifdef CONFIG_64BIT
> > +		/*
> > +		 * Unroll the rounds loop to enable constant-folding of the
> > +		 * blake2b_sigma values.  Seems worthwhile on 64-bit kernels.
> > +		 * Not worthwhile on 32-bit kernels because the code size is
> > +		 * already so large there due to BLAKE2b using 64-bit words.
> > +		 */
> > +		unrolled_full
> > +#endif
> > +		for (int r = 0; r < 12; r++)
> > +			ROUND(r);
> >  
> >  #undef G
> >  #undef ROUND
> 
> Since you're now using `unrolled_full`, ROUND doesn't need to be a macro
> anymore. You can just do:
> 
>   unrolled_full
>   for (int r = 0; r < 12; r++) {
>     G(r, 0, v[0], v[ 4], v[ 8], v[12]);
>     G(r, 1, v[1], v[ 5], v[ 9], v[13]);
>     G(r, 2, v[2], v[ 6], v[10], v[14]);
>     G(r, 3, v[3], v[ 7], v[11], v[15]);
>     G(r, 4, v[0], v[ 5], v[10], v[15]);
>     G(r, 5, v[1], v[ 6], v[11], v[12]);
>     G(r, 6, v[2], v[ 7], v[ 8], v[13]);
>     G(r, 7, v[3], v[ 4], v[ 9], v[14]);
>   }
> 
> Likewise, you can simplify the blake2s implementation in the same way
> (but don't make the unrolled_full conditional there, obviously).
> `unrolled_full` seems like a nice way of doing this compared to macros.

Yes, good idea.  I'll do that.

- Eric

