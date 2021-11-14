Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8536344FA14
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Nov 2021 20:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbhKNTOq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Nov 2021 14:14:46 -0500
Received: from mail-ua1-f44.google.com ([209.85.222.44]:34804 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236231AbhKNTOo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Nov 2021 14:14:44 -0500
Received: by mail-ua1-f44.google.com with SMTP id n6so13712650uak.1;
        Sun, 14 Nov 2021 11:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Sknt59G7NNuQ4Eiu1wyh6p23EFcYGDA0b1KDBZyFXw=;
        b=LL3JGMB2RccvlA5j6Magq7CxV92Nz3BsC/tQQ2wwhtr3LAJWyNJ1jZRPV5ZmwxOmyB
         72n6Vj560XD4isHc/Iyu2DY2UFqVDgpnL2VKVYK1jBAee+Bv840Il26xF/2CDKZa3BDj
         NjFAVp85q9WSGA6SblDHtnnHLBpbrLAsVYNeGqYN1+903RrM/NKR/23Fre/lqGXWO2qj
         aUb2g65J8MqvRnhP8GcA2h4awPFeJVOfWGCJF5pmECAPwJ0cDmxy601uGRY0udTTQjkE
         oB1ys9dEHKLYghaqJhDJlBwRD7WefQq1SRRhpM5krNuHvjpfQ81xLoxT6naeLOdBU0M4
         XCSw==
X-Gm-Message-State: AOAM530wvVqRBGqM7S8cOcyQM6jQnt0gHTC10PzDJ1780pTvUmqo4se/
        n2K45ob+tAQWUFOaLxo5cy3rxOIpHCuuWg==
X-Google-Smtp-Source: ABdhPJzqdlbsEs5KQQtqZrLrI6Utz4fvnNwCGHzOCplarahvTji8sdzDOgqVzqRW06qr6wkBSecECw==
X-Received: by 2002:ab0:3049:: with SMTP id x9mr49248710ual.55.1636917083009;
        Sun, 14 Nov 2021 11:11:23 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id c23sm7726257vko.8.2021.11.14.11.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 11:11:22 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id 84so7993704vkc.6;
        Sun, 14 Nov 2021 11:11:21 -0800 (PST)
X-Received: by 2002:a1f:f24f:: with SMTP id q76mr49851846vkh.11.1636917081468;
 Sun, 14 Nov 2021 11:11:21 -0800 (PST)
MIME-Version: 1.0
References: <20211109013058.22224-1-nickrterrell@gmail.com> <CA+icZUVV+RfrW__qvT04Rigx1dTeDT4ah+KdAVhXWMab=13t_g@mail.gmail.com>
In-Reply-To: <CA+icZUVV+RfrW__qvT04Rigx1dTeDT4ah+KdAVhXWMab=13t_g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 14 Nov 2021 20:11:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWqBAwVnfuwmonT1hESB4P+EH0p0dtszdrZLJGxBbU2gw@mail.gmail.com>
Message-ID: <CAMuHMdWqBAwVnfuwmonT1hESB4P+EH0p0dtszdrZLJGxBbU2gw@mail.gmail.com>
Subject: Re: [GIT PULL] zstd changes for v5.16
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Nick Terrell <nickrterrell@gmail.com>,
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

On Sat, Nov 13, 2021 at 10:12 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On Tue, Nov 9, 2021 at 2:24 AM Nick Terrell <nickrterrell@gmail.com> wrote:
> > I am sending you a pull request to add myself as the maintainer of zstd and
> > update the zstd version in the kernel, which is now 4 years out of date,
> > to the latest zstd release. This includes bug fixes, much more extensive fuzzing,
> > and performance improvements. And generates the kernel zstd automatically
> > from upstream zstd, so it is easier to keep the zstd verison up to date, and we
> > don't fall so far out of date again.

> is it possible to have an adapted version of your work for Linux
> v5.15.y which is a new kernel with LongTerm Support (see [1])?

Let's wait a bit before porting this to stable...

bloat-o-meter output for an atari_defconfig build with the old/new zstd
code (i.e. before/after commit e0c1b49f5b674cca ("lib: zstd: Upgrade to
latest upstream zstd version 1.4.10"):

vmlinux:

    add/remove: 96/28 grow/shrink: 28/29 up/down: 51766/-38162 (13604)
    CONFIG_ZSTD_DECOMPRESS=y due to CONFIG_RD_ZSTD=y (which is the default)

    Not a small increase, but acceptable, I guess?

lib/zstd/zstd_compress.ko:

    CONFIG_ZSTD_COMPRESS=m

    add/remove: 183/38 grow/shrink: 58/37 up/down: 346620/-51074 (295546)
    Function                                     old     new   delta
    ZSTD_compressBlock_btultra_dictMatchState       -   27802  +27802
    ZSTD_compressBlock_btopt_dictMatchState        -   27614  +27614
    ZSTD_compressBlock_doubleFast_dictMatchState       -   24420  +24420
    ZSTD_compressBlock_btultra_extDict             -   24376  +24376
    ZSTD_compressBlock_fast_dictMatchState         -   16712  +16712
    ZSTD_compressBlock_btultra2                    -   15432  +15432
    ZSTD_compressBlock_btopt_extDict            9052   24096  +15044
    ZSTD_initStats_ultra                           -   15040  +15040
    ZSTD_compressBlock_btultra                     -   14802  +14802
    ZSTD_compressBlock_doubleFast_extDict_generic    2432   12216   +9784
    ZSTD_compressBlock_doubleFast               8846   16342   +7496
    ZSTD_compressBlock_fast_extDict_generic     1254    8556   +7302
    ZSTD_compressBlock_btopt                    8826   15184   +6358
    ZSTD_compressBlock_fast                     3896    9532   +5636
    ZSTD_compressBlock_lazy2_extDict            6940   11578   +4638
    ZSTD_compressSuperBlock                        -    4440   +4440
    ZSTD_resetCCtx_internal                        -    3736   +3736
    ZSTD_HcFindBestMatch_dedicatedDictSearch_selectMLS.constprop
-    3706   +3706
    ...

    An increase of 288 KiB?
    My first thought was bloat-a-meter doesn't handle modules correctly.
    So I enabled CONFIG_CRYPTO_ZSTD=y, which made CONFIG_ZSTD_COMPRESS=y,
    and the impact on vmlinux is:

        add/remove: 288/0 grow/shrink: 5/0 up/down: 432712/0 (432712)

    Whoops...

    All of the top functions above just call ZSTD_compressBlock_opt_generic()
    with different parameters. Looks like the forced inlining

        FORCE_INLINE_TEMPLATE size_t
        ZSTD_compressBlock_opt_generic(ZSTD_matchState_t* ms,
                                       seqStore_t* seqStore,
                                       U32 rep[ZSTD_REP_NUM],
                                 const void* src, size_t srcSize,
                                 const int optLevel,
                                 const ZSTD_dictMode_e dictMode)

    is not that suitable for the kernel...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
