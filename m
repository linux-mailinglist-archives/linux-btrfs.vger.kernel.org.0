Return-Path: <linux-btrfs+bounces-19512-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DE5CA2E89
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 10:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84F3F307DF29
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 09:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C030334374;
	Thu,  4 Dec 2025 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsLKGmut"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2023090FB
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764839158; cv=none; b=ihM/P4EghUS/kawTYtGRCcqz3uRcPkdUUs4d6IlC3ZyCbSlbmwdn7kuvc/zZPinHwbZBPkgj651ycntiNkn262BAd9ddosQS8VReVULmahb/wxn0GnuvgXxSHk+83d6rCUbAeZocZ6BiW/tIVb14HWbmfaQHNkMoem6scZ5UAR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764839158; c=relaxed/simple;
	bh=GCL5jXS0EWcBqxkM9ix5SqD/peOH1ocZzOuyjFc7+/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTwQdPOH3NESTt07O9BdDtZHYc/xyGrzo4GEoY694RVvc6KU4CMTShinQQRPOWjrhKMrJs3Vt+9Wf6DgV120w73xXC7FCLT/Kvy05s6QD/BtL8A0vIUbDetO8OcGLMPBL1NuLNmwKoNyHIKb0Z5O3J0I2gnP3+m7zwhJ3WD2nas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsLKGmut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854C2C4CEFB
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 09:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764839158;
	bh=GCL5jXS0EWcBqxkM9ix5SqD/peOH1ocZzOuyjFc7+/8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bsLKGmut2lytHh1imaA0AWD9JMeYW1e0Ut+9Qkb0ckmMhe/+KdOmXxhlte2mqSZOE
	 2vezaEOHp8q+OiImruutQFB4+bPLz/6kGNkGBSwdkIPbDI5i1w1gx1SZu6ozx39ru4
	 PGFLkSHe/ROqnsPAcbWkAGcJAXhaKo4XfcmkQtr8DMugBrk6qRcStyiSe3xv/kXSBE
	 LqPXpgTSETypsAaEvrrqJDLs/iWW7aCP/WEh4hU7g9Q/i3tWCweoN+2h9WEmj5o7sj
	 OH4rnTpDJgNBFRIj78Z8HVxn3JxXl9AIv1I9oy/vR6XR0aqY5ZYvkKgMKtXsUR/+if
	 MVigyJerVIv3Q==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5943d20f352so771545e87.0
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Dec 2025 01:05:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVA0PCrpXheRzuBjAQoJr5nmmbaeieGrT50AJLglFa0PRIl0ASjAu5Qs/HHNSr51JwoJBSoU0NWi5TLaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIqIz41w88IO6PPntShl657ONqINuwgpXdjNTbyqi8MmTTyuZw
	inTmgaFaEW92TFyJwpN0SmAgUXPupl87ytin9sQMwbN+Kcy0ysGeBizA+O7rdsbRNvdTxvXGgT/
	iCxfHdoCHNg2xtx2z1BdHTHH00fHxv7s=
X-Google-Smtp-Source: AGHT+IEGK9HunF3J8NKfW8zNwREws0bdp4j+4ft/E55sPoVqyzuQASL+rCBKvzFwZAD5noNNAckZ+zFsDWX0d382A8w=
X-Received: by 2002:a05:6512:4028:b0:594:314d:fa8d with SMTP id
 2adb3069b0e04-597d3f90ff1mr2042098e87.26.1764839156715; Thu, 04 Dec 2025
 01:05:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203190652.144076-1-ebiggers@kernel.org>
In-Reply-To: <20251203190652.144076-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 4 Dec 2025 10:05:45 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHkm=vgeymc6qSGtJRfY5AjhJhYJ7+ZD0OFdLw12vFE4w@mail.gmail.com>
X-Gm-Features: AWmQ_blLg6vIT1RB55E509U8ahXy3IsX69zlpaht5KNbncen2voJD3i-7TizW2s
Message-ID: <CAMj1kXHkm=vgeymc6qSGtJRfY5AjhJhYJ7+ZD0OFdLw12vFE4w@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: blake2b: Roll up BLAKE2b round loop on 32-bit
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, David Laight <david.laight@runbox.com>, 
	David Sterba <dsterba@suse.com>, llvm@lists.linux.dev, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Dec 2025 at 20:09, Eric Biggers <ebiggers@kernel.org> wrote:
>
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
>
> Note: If we rolled up the loop on x86_64 too, the change would be
> 7024 bytes => 1584 bytes and 1960 MB/s => 1396 MB/s (gcc), or
> 6848 bytes => 1696 bytes and 1920 MB/s => 1263 MB/s (clang).
> Maybe still worth it, though not quite as clearly beneficial.
>
> Fixes: 91d689337fe8 ("crypto: blake2b - add blake2b generic implementation")
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  lib/crypto/Makefile  |  1 -
>  lib/crypto/blake2b.c | 25 +++++++++++++------------
>  2 files changed, 13 insertions(+), 13 deletions(-)
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

