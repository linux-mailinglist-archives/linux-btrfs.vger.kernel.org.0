Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B8344FB99
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Nov 2021 21:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbhKNUhA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Nov 2021 15:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbhKNUgv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Nov 2021 15:36:51 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E61C061746;
        Sun, 14 Nov 2021 12:33:53 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id v138so40646648ybb.8;
        Sun, 14 Nov 2021 12:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iACvn6MK1LO2lB6vFyhNu2ydwbSkNnulX+sOko7Bz0A=;
        b=Myh33ShzDDC1kEzySEO8tnbMKLfdT2xBxjDtl0FaBbh9V3MCdME75Vo9TsP444FIBq
         YtbumvvbtyXIJsc/TJ6NlhTXCPlA1KbFjfswCre2vNxOo/vnIjJC+mOTNZckIugq2VNs
         M60szxnYCTS2nS/91bGQYs3nPvi4JuSzeUr993YaE9CwJgI+aMOYnbBJqs/GdKchIh8y
         YVua+Dt4wah3xkvdNrocRLASZvocD3eJoS+rat/04wMDWXAT86Fz7p7S2XcuRq/dKiZx
         PUNO73A1PVqARtgd7ZgKhtZuqZDH7tl3h0C0YdE4T1vnoTR/kDVa/45/EVMYLjbt5ZA7
         +v8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iACvn6MK1LO2lB6vFyhNu2ydwbSkNnulX+sOko7Bz0A=;
        b=v8pvOK6qvWZYh5cqP2tBEVbr6V6xDQsAbLOXEaEglv+ZdTQLRpL3eKkipl4urkjgOX
         IFZzotZLrWBPxFfJmnu7gPczU9yBQT7SVSBSQzNaOyBNwSQ5IlhDb+T4C9byYt/lCQfR
         v9D8cGmZH4XjpCPLg6agRBtlJVaaPYxMzqmu+n1XHbmfu6u0T84xxyP6rM9OVkknwrpV
         BmalIwjUl2suOJo0wb/3+bkZnHNWtHCT6SEiKEBK50veVKF+MRFRhFQxc50BuNBMCc3i
         kOAIzznBFfqGMGqe7AdA1ADKjOFgum7o4w5GNmsKV/lGju5UMbRyVMLYGOu1GjeWe8cD
         jDcQ==
X-Gm-Message-State: AOAM530ehxWNkXaPaqZ7W8f65SmKoycnPUrYHV86A6338BdymW6pNrFP
        jnCz//7kyZUWTACIKLDry+J7LFikadETZKc5xWo=
X-Google-Smtp-Source: ABdhPJznee7TMd2ZMaYm26gmU6hWlIBtVQTHY+sIBtV7ExbmuuBQACj/pVfeuW3Q1PsDF/GuMSLuiksWeqv7DUEbLPI=
X-Received: by 2002:a25:ad14:: with SMTP id y20mr34423278ybi.102.1636922032754;
 Sun, 14 Nov 2021 12:33:52 -0800 (PST)
MIME-Version: 1.0
References: <20211109013058.22224-1-nickrterrell@gmail.com>
 <CA+icZUVV+RfrW__qvT04Rigx1dTeDT4ah+KdAVhXWMab=13t_g@mail.gmail.com> <CAMuHMdWqBAwVnfuwmonT1hESB4P+EH0p0dtszdrZLJGxBbU2gw@mail.gmail.com>
In-Reply-To: <CAMuHMdWqBAwVnfuwmonT1hESB4P+EH0p0dtszdrZLJGxBbU2gw@mail.gmail.com>
From:   Nick Terrell <nickrterrell@gmail.com>
Date:   Sun, 14 Nov 2021 12:33:41 -0800
Message-ID: <CANr2DbfSu9RWv+c8jzj=6r0cRC-R0f_Z2v3gSkJm2dPR8MJi4A@mail.gmail.com>
Subject: Re: [GIT PULL] zstd changes for v5.16
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Yann Collet <cyan@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Sterba <dsterba@suse.cz>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Felix Handte <felixh@fb.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Paul Jones <paul@pauljones.id.au>,
        Tom Seewald <tseewald@gmail.com>,
        Jean-Denis Girard <jd.girard@sysnux.pf>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Nov 14, 2021 at 11:11 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> On Sat, Nov 13, 2021 at 10:12 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > On Tue, Nov 9, 2021 at 2:24 AM Nick Terrell <nickrterrell@gmail.com> wrote:
> > > I am sending you a pull request to add myself as the maintainer of zstd and
> > > update the zstd version in the kernel, which is now 4 years out of date,
> > > to the latest zstd release. This includes bug fixes, much more extensive fuzzing,
> > > and performance improvements. And generates the kernel zstd automatically
> > > from upstream zstd, so it is easier to keep the zstd verison up to date, and we
> > > don't fall so far out of date again.
>
> > is it possible to have an adapted version of your work for Linux
> > v5.15.y which is a new kernel with LongTerm Support (see [1])?
>
> Let's wait a bit before porting this to stable...
>
> bloat-o-meter output for an atari_defconfig build with the old/new zstd
> code (i.e. before/after commit e0c1b49f5b674cca ("lib: zstd: Upgrade to
> latest upstream zstd version 1.4.10"):
>
> vmlinux:
>
>     add/remove: 96/28 grow/shrink: 28/29 up/down: 51766/-38162 (13604)
>     CONFIG_ZSTD_DECOMPRESS=y due to CONFIG_RD_ZSTD=y (which is the default)
>
>     Not a small increase, but acceptable, I guess?
>
> lib/zstd/zstd_compress.ko:
>
>     CONFIG_ZSTD_COMPRESS=m
>
>     add/remove: 183/38 grow/shrink: 58/37 up/down: 346620/-51074 (295546)
>     Function                                     old     new   delta
>     ZSTD_compressBlock_btultra_dictMatchState       -   27802  +27802
>     ZSTD_compressBlock_btopt_dictMatchState        -   27614  +27614
>     ZSTD_compressBlock_doubleFast_dictMatchState       -   24420  +24420
>     ZSTD_compressBlock_btultra_extDict             -   24376  +24376
>     ZSTD_compressBlock_fast_dictMatchState         -   16712  +16712
>     ZSTD_compressBlock_btultra2                    -   15432  +15432
>     ZSTD_compressBlock_btopt_extDict            9052   24096  +15044
>     ZSTD_initStats_ultra                           -   15040  +15040
>     ZSTD_compressBlock_btultra                     -   14802  +14802
>     ZSTD_compressBlock_doubleFast_extDict_generic    2432   12216   +9784
>     ZSTD_compressBlock_doubleFast               8846   16342   +7496
>     ZSTD_compressBlock_fast_extDict_generic     1254    8556   +7302
>     ZSTD_compressBlock_btopt                    8826   15184   +6358
>     ZSTD_compressBlock_fast                     3896    9532   +5636
>     ZSTD_compressBlock_lazy2_extDict            6940   11578   +4638
>     ZSTD_compressSuperBlock                        -    4440   +4440
>     ZSTD_resetCCtx_internal                        -    3736   +3736
>     ZSTD_HcFindBestMatch_dedicatedDictSearch_selectMLS.constprop
> -    3706   +3706
>     ...
>
>     An increase of 288 KiB?
>     My first thought was bloat-a-meter doesn't handle modules correctly.
>     So I enabled CONFIG_CRYPTO_ZSTD=y, which made CONFIG_ZSTD_COMPRESS=y,
>     and the impact on vmlinux is:
>
>         add/remove: 288/0 grow/shrink: 5/0 up/down: 432712/0 (432712)
>
>     Whoops...
>
>     All of the top functions above just call ZSTD_compressBlock_opt_generic()
>     with different parameters. Looks like the forced inlining
>
>         FORCE_INLINE_TEMPLATE size_t
>         ZSTD_compressBlock_opt_generic(ZSTD_matchState_t* ms,
>                                        seqStore_t* seqStore,
>                                        U32 rep[ZSTD_REP_NUM],
>                                  const void* src, size_t srcSize,
>                                  const int optLevel,
>                                  const ZSTD_dictMode_e dictMode)
>
>     is not that suitable for the kernel...

Thanks for pointing that out! Code size wasn't something I was measuring in my
tests. I'll put up a patch to fix it.

That function is used by the highest compression level, so there
should be little
usage in the kernel. And what usage there is shouldn't be very speed sensitive.
So we should just be able to disable inlining for that file.

Longer term, we have noticed upstream that we had some code size bloat in
the compressor. We aggressively inlined to get better speed, but that tradeoff
went too far in some cases. So we're working on reducing the code size of
our largest translation units for the next release. All that to say
that we can land
a shorter term fix of disabling inlining for
lib/zstd/compress/zstd_opt.c for the
v5.16 kernel, and handle the problem thoroughly upstream in our next release.

Best,
Nick Terrell

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
