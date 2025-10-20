Return-Path: <linux-btrfs+bounces-18080-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 102CABF347F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 21:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 841B54FD4C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 19:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F7C28C866;
	Mon, 20 Oct 2025 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JswEnUl5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097351F4262
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760989730; cv=none; b=hCDlxtpW55V/nz3fXv9jwQx3g1mY6Qp5d5qvtnfT4h1qtEGahwQR7F1FigXWfDohh8wusanOtYQ05Xl1kPIU4jtPtItkAJJYMw1xRmz47qOVV8l/43C7WhyWcYYh6PqWUOVr14xf2WVxXkO8r3O9tWadKWq7dmOaTIaHMKaj5uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760989730; c=relaxed/simple;
	bh=MgGpsHbRyLLEuSO5v1+IPH3mXujQi4ThCOVYq9DwidM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0vCczvYu6PODO8RyqJ8L0TGaTsif+ASUVtVRp1eJqMvCnO1Hv6ABDyFsbpLy9dHCTiEdMS99WgCegDqMK/XONw96owWxgVXMtTjZSQy4VWiawbUJ3V/f5cRa3QB4gpSlJeQIZ6twZz6R2e1/Y5LBj+8vapij2VSUpw3bfPRdyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JswEnUl5; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63bad3cd668so9060139a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 12:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760989725; x=1761594525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NptN9BDkwDpbcOFbQiGabvU6AAsiO9hE4CrjxRY1XC0=;
        b=JswEnUl5zDus17fUo8qBjCX43cjXAahN42sjlcN3mckfNIanFZzXZJAYZzrgVS0Kxz
         71lrR3xch78uVaAdvb8codk79wR9d4988V3eWzxy8kRLj16iL1gHA7k+N2iKHjnVM5/V
         lC5rRXZyJtroP9gyo5rBiCXWJWkD6+NQwbasU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760989725; x=1761594525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NptN9BDkwDpbcOFbQiGabvU6AAsiO9hE4CrjxRY1XC0=;
        b=lKB8nvhGRwPodm4meIJ75lAXabniFuqOehbYSGOffXV8pZeX2jZneFq7E5HMeuHcRH
         GNdwjaRB0U/iSFkx5np9uhaHm4K98x5RYQpGxdCroG5yXxHLoxOxhABr17iwWSoMVLhe
         rB59huw5Px37V6yr7V4Edznj1wL9IRt7sWrTo+0d2wlhko5xmHkoX9U9AIwL7KXSfFCf
         63PAO6IchGOVGBCA3akLdCI7jL07oUMZAimsyDVOZPuQMQb8F4dbijfgM5rGGaEzUOUu
         Fx8PstCJto8YV6dIeEyrR4UjfS7y+0SWWjwyMAEiuOZP6+71OnmwR//G3Vteb5Z+gNMI
         MWFw==
X-Forwarded-Encrypted: i=1; AJvYcCWypSGKiHwNJhP4XCotmlmLI33u/DizS+AZvewWXCfNmTHCp0kE4ascEkO9JClyPtGc3aF2oiJuYtAlEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTnd2s61Qvptm1jzyZCf+DRiJUjuFo4qRZvnIPTyjSpQLIGTAI
	yaPjorfSCumiUG4GQqix/y2KZGLnAm57CifW4wwX3nr+ZrUtccSEUXM3dhjSC5lGPMX0yGB8D0C
	IRRBDTME=
X-Gm-Gg: ASbGncs/c2JzxytmIFpDjsRHRQBWNnNAj0qbbC+yr4uMxFIStjVP1gC/ohIbGrwVXwD
	M8gKHdA0eMTpq3gX102u7WloSY8iulvRytO/hZHwILWrYjImFuGm2c8WPTZK17IsP6KFhRx4h0x
	Io8PXxwZFnsC8Y5+wJNEBj+/mXe/vg2gV6LCO3SQaQ4xZIR0wHa8rFNJS7ayJnVTYndH9NeNeqW
	7gkfrH0aQv6Y4CGjlOealdX/CQjNfaSxTH9kOfKHHBM0nR9WAo1u31MOqbMox6+pZrAn9ixoQl5
	v2ODqnmISkpdQJL6miyaFIgEd5WzlAfREnUTYX941lb+61mVi9SJrWXPrYY6gtlfvKvOmoVKD4U
	707pr+EE/VAOP53V00+VCy2SiRrVOk6xKLIIPXncBxa4CHQu5un/xhv3fhyUwjtONzdTzy6CGmE
	5dPRAuKbYG0hzrDLq4lxq1aHWzqtwPPlzOpmXReO0Gf62ce8xujAS/xwRaj8Gj
X-Google-Smtp-Source: AGHT+IEcEOoEAn3KoULw0EiqrH5ZJCE+3cmSaGjl1oEZK68bbh3gqIuS9baPBit736yqvZeVAcw3aw==
X-Received: by 2002:a05:6402:2706:b0:63c:3efe:d98a with SMTP id 4fb4d7f45d1cf-63c3efeee48mr11149953a12.32.1760989723696;
        Mon, 20 Oct 2025 12:48:43 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48ab54desm7531124a12.13.2025.10.20.12.48.42
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:48:42 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63bad3cd668so9060081a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 12:48:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCjapCqKgffUPrZUX5JaJfMjce2g3U51yQOfEm8q6HvErB+rrkXyVMEvGMHDke2BpVXEH4dg9bi0+Dtg==@vger.kernel.org
X-Received: by 2002:a05:6402:4407:b0:63c:eb9:4778 with SMTP id
 4fb4d7f45d1cf-63c1f626e36mr13356445a12.1.1760989722393; Mon, 20 Oct 2025
 12:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020142228.1819871-1-linux@rasmusvillemoes.dk> <20251020142228.1819871-3-linux@rasmusvillemoes.dk>
In-Reply-To: <20251020142228.1819871-3-linux@rasmusvillemoes.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 Oct 2025 09:48:25 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgHLkpQAEDpA9pwXp_oteWkdcs-56m7rnQD=Th0N2sW9g@mail.gmail.com>
X-Gm-Features: AS18NWDyOPEZYLlpZ_IDtTxJF93fgCvTBpU4BXYpNtKXdpZRRnqLlSITzLAUJMM
Message-ID: <CAHk-=wgHLkpQAEDpA9pwXp_oteWkdcs-56m7rnQD=Th0N2sW9g@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: send: make use of -fms-extensions for defining
 struct fs_path
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Oct 2025 at 04:22, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
>
> +struct __fs_path {
> +       char *start;
> +       char *end;
> +
> +       char *buf;
> +       unsigned short buf_len:15;
> +       unsigned short reversed:1;
> +};
> +static_assert(sizeof(struct __fs_path) < 256);
>  struct fs_path {
> +       struct __fs_path;
> +       /*
> +        * Average path length does not exceed 200 bytes, we'll have
> +        * better packing in the slab and higher chance to satisfy
> +        * an allocation later during send.
> +        */
> +       char inline_buf[256 - sizeof(struct __fs_path)];
>  };

It strikes me that this won't pack as well as it used to before the change.

On 64-bit architectrures, 'struct __fs_path' will be 8-byte aligned
due to the pointers in it, and that means that the size of it will
also be aligned: it will be 32 bytes in size.

So you'll get 256-32 bytes of inline_buf.

And it *used* to be that 'inline_buf[]' was packed righ after the
16-bit buf_len / reversed bits, so it used to get an extra six bytes.

I think it could be fixed with a "__packed" thing on that inner
struct, but that also worries me a bit because we'd certainly never
want the compiler to generate the code for unaligned accesses (on the
broken architectures that would do that). You'd then have to mark the
containing structure as being aligned to make compilers generate good
code.

So either you lose some inline buffer space, or you end up having to
add extra packing stuff. Either way is a bit of a bother.

                  Linus

