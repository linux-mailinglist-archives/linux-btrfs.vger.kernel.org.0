Return-Path: <linux-btrfs+bounces-19546-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F040CA938C
	for <lists+linux-btrfs@lfdr.de>; Fri, 05 Dec 2025 21:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0B12301CD6D
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Dec 2025 20:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B79326CE39;
	Fri,  5 Dec 2025 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDTLWS15"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54F9249EB;
	Fri,  5 Dec 2025 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764965653; cv=none; b=Gug0y3J+VEmNHN8DIxP9NR3qdX0A8II8bIlZKYMC/LPV+vyheFSaRnzBH/Z2HMfD7NkM2kl5tI2k3Y7Ixe52nFCI0pWQVcLe19vX1Qm8kHphRUTwSqL3yfyThjmrIEt+2d6+HH6oAZcNTlGDPBfJBW2H6JA/RAjJQUPNsbLxzZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764965653; c=relaxed/simple;
	bh=Q+4BbbNpfu1Rkx2Ir1s73CTRiiN6qB1gFoCLSGvF23Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWnCMqVN9BNNKMbVV/1h3q1afro6bqdw/rT7hOXEFf2DeFnk5tQp97iCkycz/qwpr6dkl4SfSJmNH42eX+0wZ4np9sZDFtRJ3Lb6ze83Vwon8TQGxkGhinZinJz5BwoqBPbvaQejIRUiimDAZcxbZItdYjirL0vgq8wdPOpwYDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDTLWS15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AE7C4CEF1;
	Fri,  5 Dec 2025 20:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764965653;
	bh=Q+4BbbNpfu1Rkx2Ir1s73CTRiiN6qB1gFoCLSGvF23Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDTLWS15bMR6dUgRwmHJWiJPokbiGNL2Ct3os7AdqksHtN8fiqibPShPc9LMlIu/D
	 cwBm57TE4zUGYoZKsIAF6g6sKzNfCEwQGQTVyaCin/zqpdTX+DI5n/TRCRyDilYlec
	 WCWAaA0QYQjQ1bWmYZobj1ojQNXjQ04P5rvLOD1cX9MyvrZd86nrBjj9shy5/M5pkR
	 nb7q1/9+4EXturxOX8ijF8cAcAz0qPex67VRs5Uw0fkS4ab5p66oNXDYD/9NAiQZ8x
	 YAlfBuXkPsK/z4Ur9CxcLKSu36DJLZf6Tpli6ckN9Niy18QwN/91vuRaJRKjRdpdh9
	 CdkTQg8iGLR/A==
Date: Fri, 5 Dec 2025 12:14:11 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: david laight <david.laight@runbox.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	David Sterba <dsterba@suse.com>, llvm@lists.linux.dev,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] lib/crypto: blake2b: Roll up BLAKE2b round loop on 32-bit
Message-ID: <20251205201411.GA1954@quark>
References: <20251203190652.144076-1-ebiggers@kernel.org>
 <20251205141644.313404db@pumpkin>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205141644.313404db@pumpkin>

On Fri, Dec 05, 2025 at 02:16:44PM +0000, david laight wrote:
> Note that executing two G() in parallel probably requires the source
> interleave the instructions for the two G() rather than relying on the
> cpu's 'out of order execution' to do all the work
> (Intel cpu might manage it...).

I actually tried that earlier, and it didn't help.  Either the compiler
interleaved the calculations already, or the CPU did, or both.

It definitely could use some more investigation to better understand
exactly what is going on, though.

You're welcome to take a closer look, if you're interested.

- Eric

