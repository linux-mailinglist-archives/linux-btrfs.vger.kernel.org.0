Return-Path: <linux-btrfs+bounces-19544-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C29B2CA7E93
	for <lists+linux-btrfs@lfdr.de>; Fri, 05 Dec 2025 15:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CACCE30196CE
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Dec 2025 14:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694A72E7F2C;
	Fri,  5 Dec 2025 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="YP8j3FNJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BF728B40E;
	Fri,  5 Dec 2025 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764944228; cv=none; b=Rmtlap6fHt+Tz0zC8rSZGUd8oRhoR4ZviIppqcWU38JPZu5L72gswPY3x7CXr/BVFp6SnHlamJeehmD7uhSPa7AHL7fZYwukTmuC3aanmX3jY+rjrlkC5FhnadWjxKP0RZCpsyjI1vfqncgxnQgV05k0zwjMyKdqNRIvglq3Ns4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764944228; c=relaxed/simple;
	bh=OKCW5cDl1+0RGMsHm7AvZSsrkSH8zbzs/RY3A2Fhwys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PdrAs7yeeOP/fa1EkDbAath5VxqU7V7iCcwBfbv2M5tYVHxkrkQNsbgDU23+jtVtHZ50hUYCYPnEbeBng6mhVOkf57RDafdQP8JMu+o0Flx9eQWSCpMmHpRDSTG6lkj0/gmR/sXwr6TsZBJpsbMlH9eAo/iEQTTdONPP5sIZTJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=YP8j3FNJ; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vRWcB-003ux0-OD; Fri, 05 Dec 2025 15:16:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=Fy+YJPeJ4mI8qzgXHembqRChAk+0MsyrPaoiU7cZm54=; b=YP8j3FNJlHy87EcfeYDWLKs4yP
	34duV/JXVGGbByC3nkUUXtTXX5KSDl/yNrdoFpL6SpLKCz4u0QhQ2BFZnpzuLnp/U/RFtApoiaqnS
	o2RRC0i+nWYU67Vq547TKCCEEkcSS+a+dbEz1BM+mt4fIqb0yf+htgudcccVGh2LqrrBEkSS6ssw2
	uqDP82IaLdwajns12/5g0AvCCj/K/GdqOl1WP2aNFRSHVqxyFs8p4i0jtnm7bj8pe9z7w6U/9n64e
	sz4O4IVfAXAE9tNqxKKosPTZwRzeBRYuBoacL08fFK35m05+TUH2riQ8Z8pzKgqCGQOMUwwo5quA3
	K+zUR5MQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vRWcA-0001DL-LW; Fri, 05 Dec 2025 15:16:54 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vRWc3-0033Iy-9e; Fri, 05 Dec 2025 15:16:47 +0100
Date: Fri, 5 Dec 2025 14:16:44 +0000
From: david laight <david.laight@runbox.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Ard
 Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Thorsten Blum
 <thorsten.blum@linux.dev>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, David Sterba
 <dsterba@suse.com>, llvm@lists.linux.dev, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] lib/crypto: blake2b: Roll up BLAKE2b round loop on
 32-bit
Message-ID: <20251205141644.313404db@pumpkin>
In-Reply-To: <20251203190652.144076-1-ebiggers@kernel.org>
References: <20251203190652.144076-1-ebiggers@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Dec 2025 11:06:52 -0800
Eric Biggers <ebiggers@kernel.org> wrote:

> BLAKE2b has a state of 16 64-bit words.  Add the message data in and
> there are 32 64-bit words.  With the current code where all the rounds
> are unrolled to enable constant-folding of the blake2b_sigma values,
> this results in a very large code size on 32-bit kernels, including a
> recurring issue where gcc uses a large amount of stack.
> 
> There's just not much benefit to this unrolling when the code is already
> so large.  Let's roll up the rounds when !CONFIG_64BIT.  Then, remove
> the now-unnecessary override of the stack frame size warning.
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

Any idea how many clocks those are for each G() ?
That number would give an idea of the actual 'quality' of the code.

A quick count shows 14 alu operations with a register dependency
chain length of 12.
So however hard you try G() will take 12 clocks (on 64bit) provided
all the instructions have no extra result latency (probably true).
That means there is plenty of time for two memory reads for each of the
m[*b2b_sigma++] accesses (including the increment).
On x86-64 there aren't enough registers to hold all of v[], so there also
need to be another 4 reads and writes for each G().
Total 8 memory reads, 4 memory writes and 12 alu clocks - shouldn't be
too hard to get that to run in 12 clocks.

Because of the long register dependency chain there will be gains from
running two G() in parallel.
I don't think you'll get two to run in 12 clocks on x86-64.
While two reads and a write can be done in each clock on later cpu it
definitely needs a 'following wind'.
Arm-64 is another matter, that should be able to hold all of v[] in
registers throughout.
(Although the memcpy(v, ctx->h, 64) probably needs replacing with 8
separate assignments.)

Note that executing two G() in parallel probably requires the source
interleave the instructions for the two G() rather than relying on the
cpu's 'out of order execution' to do all the work
(Intel cpu might manage it...).

While all that is a lot of changes to get right, I suspect that just:
	const u8 *b2b_sigma = blake2b_sigma[0];

#define G(a, b, c, d) \
	a += b + m[b2b_sigma[0]];
	...
	a += b + m[b2b_sigma[1]];
	b2b_sigma += 2;
	...

will remove almost all the benefit from unrolling the 'ROUND' loop.
Especially since the loop termination condition can use b2b_sigma.

Everything except x86 will also benefit from multiplying all of
blake2b_sigma by 8 and doing *(u64 *)((u8)m + b2b_sigma[0]) for
the accesses.

32bit is another matter entirely.
I think gcc can handle u64 as either a pair of 32bit values or as
a register-pair (so pairs of simode ops, or single dimode ones).
The code seems better if you stop it doing the latter, but breathe
on something that joins up the two parts and you are stuck with it.

I can't help thinking that swapping the order of the bit-pairs in the
index to v[] would make it easier to write ROUND() as a real loop.
The code size (and I-cache) reduction might make up for any losses,
especially since the code is really memory limited (because of the
accesses to v[]) rather than alu limited - so a few more alu
instructions may make little difference.

	David


