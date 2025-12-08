Return-Path: <linux-btrfs+bounces-19586-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D1CCAE62A
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 00:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F30AA300A548
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 23:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3E92DCF6B;
	Mon,  8 Dec 2025 23:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTSpj3xy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC96231A23;
	Mon,  8 Dec 2025 23:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765235383; cv=none; b=mhHtogpKLSQO7opyvngT448hK8IkD1e0Fhv5AVWiRp655RGuNa2Wv5htqq5XOIYiiRDBZAQjKm381QBV6e8OAKa4uEdcrXsHmhLpAE/v0ra3celFyd99t+L96brL3XzzBN31aWQKoJ8HgQ+7cNt3OH83nUmU04/iV+AodDqu2I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765235383; c=relaxed/simple;
	bh=Niaz3OcyWSvPRamO7EM3GBNmwSKLzayrhD3s1w1flwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEKngomtk+r3XoVYtHjalz3JniLsonvkIFxjUrkJLRDREbvqr5bcjJ/eOqoJy29SFmXvqRnZbX7CjK4ZecwcjbdmsuQros+7vQxRsYpMwhGnwmNb8Wrv31P0U8baxna1Unu7xJ8hhe/sAdfAgf4E9pYaqb0NjeC40aRTWun+sbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTSpj3xy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE73C4CEF1;
	Mon,  8 Dec 2025 23:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765235383;
	bh=Niaz3OcyWSvPRamO7EM3GBNmwSKLzayrhD3s1w1flwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MTSpj3xyjjSbLZM1CNLcX4tZbJVrhLIpcC0UFb2X/3jpkCEEnCWToZDrDVWXNP0eq
	 PrliHsn7YP+n5w4KcoqUSM6KBPVBTkL4fV9n1QuIpSqa4m+moJEO8MdSIDst6FG51O
	 bZPurH8gFvWBv9K2BKd/DpsKH3yJkWyBm8Kyn0hWTAoGLXwrtQyFZL4nKBWnFs237M
	 FIQOuwPlBRe0dhUh98yZLh0ckC38aZRwLYUfitw8LDs0JRPwswKsNUda8txeVcgk5S
	 frzvAREFqLH7FfutqIxS/zoGFZrvorln6IRSRTVwrjXZ/9nzHKZ4Idh8/V3ZgnnZBb
	 +2crndx5xb0ug==
Date: Mon, 8 Dec 2025 15:09:41 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	David Laight <david.laight@runbox.com>,
	David Sterba <dsterba@suse.com>, llvm@lists.linux.dev,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] lib/crypto: blake2b: Roll up BLAKE2b round loop on
 32-bit
Message-ID: <20251208230941.GB1853@quark>
References: <20251205050330.89704-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205050330.89704-1-ebiggers@kernel.org>

On Thu, Dec 04, 2025 at 09:03:30PM -0800, Eric Biggers wrote:
> BLAKE2b has a state of 16 64-bit words.  Add the message data in and
> there are 32 64-bit words.  With the current code where all the rounds
> are unrolled to enable constant-folding of the blake2b_sigma values,
> this results in a very large code size on 32-bit kernels, including a
> recurring issue where gcc uses a large amount of stack.
> 
> There's just not much benefit to this unrolling when the code is already
> so large.  Let's roll up the rounds when !CONFIG_64BIT.
> 
> To avoid having to duplicate the code, just write code once using a
> loop, and conditionally use 'unrolled_full' from <linux/unroll.h>.
> 
> Then, fold the now-unneeded ROUND() macro into the loop.  Finally, also
> remove the now-unneeded override of the stack frame size warning.
> 
> Code size improvements for blake2b_compress_generic():
> 
>                   Size before (bytes)    Size after (bytes)
>                   -------------------    ------------------
>     i386, gcc           27584                 3632
>     i386, clang         18208                 3248
>     arm32, gcc          19912                 2860
>     arm32, clang        21336                 3344
> 
> Running the BLAKE2b benchmark on a !CONFIG_64BIT kernel on an x86_64
> processor shows a 16384B throughput change of 351 => 340 MB/s (gcc) or
> 442 MB/s => 375 MB/s (clang).  So clearly not much of a slowdown either.
> But also that microbenchmark also effectively disregards cache usage,
> which is important in practice and is far better in the smaller code.
> 
> Note: If we rolled up the loop on x86_64 too, the change would be
> 7024 bytes => 1584 bytes and 1960 MB/s => 1396 MB/s (gcc), or
> 6848 bytes => 1696 bytes and 1920 MB/s => 1263 MB/s (clang).
> Maybe still worth it, though not quite as clearly beneficial.
> 
> Fixes: 91d689337fe8 ("crypto: blake2b - add blake2b generic implementation")
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-fixes

- Eric

