Return-Path: <linux-btrfs+bounces-19547-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 512F4CA9765
	for <lists+linux-btrfs@lfdr.de>; Fri, 05 Dec 2025 23:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0B273021F59
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Dec 2025 22:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8CE314D14;
	Fri,  5 Dec 2025 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="FpFyLJDK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2FE2D94A9
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Dec 2025 22:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764972284; cv=none; b=UZzZ6E0bhDxk48SufKkY4pyUYlPNulsaoHM2qbejwelrSs0Elhw+5+zr919dZGsYdRi1OndKh855l8gnzIBwC9eprXDEXLEv3/+CA/3oARNeJr+lNcnPB7kAFDZtmySavOxGbjR430lObqTAv4T+kwKAHOobOEziO7WfvdaP2RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764972284; c=relaxed/simple;
	bh=n65s71kz7Rx5F46SSZquv1oVQQt8CVM0M5EFe9ZAmJg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aa0Bal1zf3oWUtl8KimoWmzhYajzwHW3aBUYMG1ynF5eg7ZCVv0gq1JMBAlNaBsoyg9n8ddDlr3oMlQ295wX8Yg6bVCimIsDpaMZHdasSHYjBDLH+HXcIQDSlp+pwn2OszPdcb3g/U/yf9hJ+gG4NVMj+TVtmozyYdLSmoq4wPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=FpFyLJDK; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vRduf-005BVA-4Q; Fri, 05 Dec 2025 23:04:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=VKRmWJJRTmmp/YjxC8OXm6NkYoeSnkf9tDFkckwjyQE=; b=FpFyLJDKpcYOizY+oXsmE0wvZn
	TPCC8CTmb8jCnax7OOceN1vL2jzi4lDpkKwQq4KBSFkD7IvDhH58+uAz/7TYldaryriVfkR0z23MV
	mtXtxvaryMsqYaDh9O3VOfRzs6x3mHSNk/dPQG9r5tedgZROtiZTm1reaNCyDoAbCm78E7hUSnWgq
	J1ASOYvuvQF4EqVni/H3WEH07FlxUygQbuCXNU2nTiQlDCU1Cb/2i8nMa4lkcoQvZiax1QnXtxbrg
	WB80vJqQQRGLQx09V/y3k6LRlCndfCjA346mjjlboF1qP1PpJLShaooTxLEl/kPJW56NidTq9a5/z
	im1KwQZA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vRdud-0003KC-Ul; Fri, 05 Dec 2025 23:04:28 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vRduQ-003vlU-TM; Fri, 05 Dec 2025 23:04:15 +0100
Date: Fri, 5 Dec 2025 22:04:12 +0000
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
Message-ID: <20251205220412.5bf42699@pumpkin>
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

Or they are never interleaved and doing that didn't help.

> It definitely could use some more investigation to better understand
> exactly what is going on, though.
> 
> You're welcome to take a closer look, if you're interested.

I might try calling the code from my 'clock counting' wrapper.
That is good enough to see the data dependency of a 'div' instruction
and the effect of branch misses due to taking a different path from
the previous call (about 20 clocks on a zen-5).

Did you notice that 'u64 t[2];' is a 128bit 'byte counter' for the
buffer being processed!
I doubt 32bit needs that many bits :-)

	David

> 
> - Eric
> 


