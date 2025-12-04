Return-Path: <linux-btrfs+bounces-19527-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F03ACA4F32
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 19:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6383D312FD1A
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 18:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D4F3590CC;
	Thu,  4 Dec 2025 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Z+TlQCDv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7573590A8;
	Thu,  4 Dec 2025 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764870996; cv=none; b=Cxc4Wz6nmpij1qyUqSCqThOo2pDTTJ4hMAKEXkB5qmBJ2O2qDue9JGelM2evT2+heLNoTMkr4zuYgAIhQwjibkX/AiWhxILarzXk3nZso2WBPerJiRIC204EXK9aMua5w+EE6Gf1AbmT+PUO3CnzTVKqvrqrXoItiI18uaAawng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764870996; c=relaxed/simple;
	bh=Y67mCM2J3w0NkgoU35NJtGTTjLQ/aE6Qb68AttzNry8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPBPidJSZR99zboPYz56lMAMuSxsZ3Whcm8/ED19FRBEAFbgXMWH87wwFVEJb8XeL1zDBQFsCoPRc+Ke+qmCHNmyZBVClja4uw0D58QmFQzfu+HQJi2/p5onkpJWh3KyTIRAV4vrBE8B5toh80tpIFElgt08nY0B06ExvvJtC5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Z+TlQCDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E3FC4CEFB;
	Thu,  4 Dec 2025 17:56:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Z+TlQCDv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1764870993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GFbzxkSrJd1dNRLfLuJo7Vt6+b5SM48dzQKQwuXhvkY=;
	b=Z+TlQCDvBsRYa2dHOClBOVZTNdHKuZ23UdH7fR4LQ4+qA03gMr5gNzw/LzYPcRy82fBLQP
	SWosfDeydtmAvKQaGjaA21ypEvuleZ246JIobBorqdrSb2ypT1Dfaei3parH5Xg6ZPc8dU
	fnOJpyK8qyN4YQbFicNuP/2f4QlEN58=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c077b8d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Dec 2025 17:56:33 +0000 (UTC)
Date: Thu, 4 Dec 2025 12:56:32 -0500
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Eric Biggers <ebiggers@kernel.org>
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
Message-ID: <aTHLUIjqCHlRs8rr@zx2c4.com>
References: <20251203190652.144076-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251203190652.144076-1-ebiggers@kernel.org>

On Wed, Dec 03, 2025 at 11:06:52AM -0800, Eric Biggers wrote:
>  	G(r, 4, v[0], v[ 5], v[10], v[15]); \
>  	G(r, 5, v[1], v[ 6], v[11], v[12]); \
>  	G(r, 6, v[2], v[ 7], v[ 8], v[13]); \
>  	G(r, 7, v[3], v[ 4], v[ 9], v[14]); \
>  } while (0)
> -		ROUND(0);
> -		ROUND(1);
> -		ROUND(2);
> -		ROUND(3);
> -		ROUND(4);
> -		ROUND(5);
> -		ROUND(6);
> -		ROUND(7);
> -		ROUND(8);
> -		ROUND(9);
> -		ROUND(10);
> -		ROUND(11);
> +
> +#ifdef CONFIG_64BIT
> +		/*
> +		 * Unroll the rounds loop to enable constant-folding of the
> +		 * blake2b_sigma values.  Seems worthwhile on 64-bit kernels.
> +		 * Not worthwhile on 32-bit kernels because the code size is
> +		 * already so large there due to BLAKE2b using 64-bit words.
> +		 */
> +		unrolled_full
> +#endif
> +		for (int r = 0; r < 12; r++)
> +			ROUND(r);
>  
>  #undef G
>  #undef ROUND

Since you're now using `unrolled_full`, ROUND doesn't need to be a macro
anymore. You can just do:

  unrolled_full
  for (int r = 0; r < 12; r++) {
    G(r, 0, v[0], v[ 4], v[ 8], v[12]);
    G(r, 1, v[1], v[ 5], v[ 9], v[13]);
    G(r, 2, v[2], v[ 6], v[10], v[14]);
    G(r, 3, v[3], v[ 7], v[11], v[15]);
    G(r, 4, v[0], v[ 5], v[10], v[15]);
    G(r, 5, v[1], v[ 6], v[11], v[12]);
    G(r, 6, v[2], v[ 7], v[ 8], v[13]);
    G(r, 7, v[3], v[ 4], v[ 9], v[14]);
  }

Likewise, you can simplify the blake2s implementation in the same way
(but don't make the unrolled_full conditional there, obviously).
`unrolled_full` seems like a nice way of doing this compared to macros.

Jason

