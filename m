Return-Path: <linux-btrfs+bounces-20023-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6646BCDEFA1
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 21:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4EE73009AA6
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 20:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77315275AFD;
	Fri, 26 Dec 2025 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="JT6QTaUX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CCF274B58;
	Fri, 26 Dec 2025 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766780710; cv=none; b=etCdiOYSyWJdfk1vXqffNFGPws8voNwA8ZdcRS4MQGi82uczuMZLhUNAzr1bn1e6syR8BzurqsCDqvatvjAjvSA/KEjCqcLpuandSgdf/Cra26/vFFXSOKC6CKR24UGLU4jeGztsP4cmiXTwVDVGvCxxskFXvojGz8NWIkn1t7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766780710; c=relaxed/simple;
	bh=nvlLVnvatpqwgOjAS/q3NGOgoHfMJaX/ZS0arCm25vI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1bfNFaNm6oXhQIvfNLjNzP83HR4HER+Y5CNUC+bhnLYmuqlVDvLa8+weXqFRgGy3GNycDfwhETM+/zqGO5am8swgTBUFUcHQMAKXicWeiqSb5fNZFVEEq0dlzwSyDkG2bhUVT+nlsInqF3ihc1gDJliXpLW0GIc8b2zgkbk2BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=JT6QTaUX; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vZEMf-003iee-38; Fri, 26 Dec 2025 21:24:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=i1GRlWCzDCZz3wdSHgzwoDEJfj5lb11Zn8FwETxb/9c=; b=JT6QTaUXUK+E4xcKu7QGqIZCOa
	TKrrz8OrTaQqR+6vp6Me/XQ5GevgJZn0yZyHvJ9bkASBio+x6/RWP1EEXF0vpSLNH7M8LPlVrcXzG
	3p9/33+lbiQ/aMuWhlCSXdYTz1yFWwpot82lX3fMA+4MbHPrjPma/oJ/hBpMz9atpp7zp79D68Ykj
	N+6GXhcLYnvK7rtT19eq9dxr1ZziF3EEa+hm3F/hDNF7x8zY+9nV1ctacLh3EKAzgorMuLSQU3dgx
	HMqLG837EHQT5/bLHjq8qGQnwZ6YuZizsmRsXhb6coKVtbQI/Ts1B2huGfAO+yFMxGzXaRnW/ooW+
	lyPkVvDA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vZEMd-0008Sz-UA; Fri, 26 Dec 2025 21:24:44 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vZEMV-00H1T6-CE; Fri, 26 Dec 2025 21:24:35 +0100
Date: Fri, 26 Dec 2025 20:24:33 +0000
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
Message-ID: <20251226202433.107af09a@pumpkin>
In-Reply-To: <20251205201411.GA1954@quark>
References: <20251203190652.144076-1-ebiggers@kernel.org>
	<20251205141644.313404db@pumpkin>
	<20251205201411.GA1954@quark>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Dec 2025 12:14:11 -0800
Eric Biggers <ebiggers@kernel.org> wrote:

> On Fri, Dec 05, 2025 at 02:16:44PM +0000, david laight wrote:
> > Note that executing two G() in parallel probably requires the source
> > interleave the instructions for the two G() rather than relying on the
> > cpu's 'out of order execution' to do all the work
> > (Intel cpu might manage it...).  
> 
> I actually tried that earlier, and it didn't help.  Either the compiler
> interleaved the calculations already, or the CPU did, or both.
> 
> It definitely could use some more investigation to better understand
> exactly what is going on, though.
> 
> You're welcome to take a closer look, if you're interested.

I had a quick look at the objdump output for the 'not unrolled loop'
of blake2s on x86-64 compiled with gcc 12.2.
The generated code seemed reasonable.
A single register tracked the array of offsets for the data buffer.
So on x86 there was a read of the offset then nn(%rsp,%reg,4) to
get the value (%reg,8 for blake2b).
There weren't many spills to stack, I suspect that 14 of the v[]
were assigned to registers - but didn't analyse the entire loop.
The fully unrolled loop is harder to read, but one of the v[] still
needs spilling to stack.

Each 1/2G has at least one memory read and seven ALU operations.
The Intel cpu (Haswell onwards) can execute 4 ALU instructions
every clock - so however well the multiple G get scheduled each
1/2G will be (pretty much) two clocks.
That really means it should be possible to include the second
memory read (for the not-unrolled loop) without slowing things down.
Even if the nn(%rsp,%reg,8) needs an extra ALU operations the change
shouldn't be massive.

Which makes be wonder whether the slowdown for rolling-up the loop
is due to data cache effects rather than actual ALU instructions.

Of course this is x86 and the nn(%rsp,%reg,8) addressing mode helps.
Otherwise you'd want to multiply the offsets by 8 and, ideally, add
in the stack offset of the data[] array allowing the simpler (%sp,%reg)
addressing mode.

I've still not done any timings, on holiday with the wrong computers.

	David


> 
> - Eric
> 


