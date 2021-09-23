Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCD041556A
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 04:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238894AbhIWC0f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 22:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbhIWC0e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 22:26:34 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848A4C061574;
        Wed, 22 Sep 2021 19:25:03 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id nn5-20020a17090b38c500b0019af1c4b31fso3785887pjb.3;
        Wed, 22 Sep 2021 19:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iWbjnVW9quu+0NtNnTMMNkLY8fmdpVFvrVoHkkaQvEQ=;
        b=LirCHkh4/Ld68Fp4nkh0EaFnDsus30j10wVz/x/a/R7s3nMTUn+l5Bp92FgFPAHWKa
         Ag12W/iAQ2ZI8/qxhF3/rU8E/gGK05tNWMNOo0ezOfy9ABKB9fgr8OZ2IgvU+RShYpJf
         Pu8Cpg+CBhL16jvUUuaRx95akl+I791Rw14u58h7jgOTfvETi0roOq8noEW9bAE39CaN
         SaAeRj1edoeRGOaC0UU35fOzoO81vFZ861HPsi7tbHLbkaFSpCLxlbXDm8CkDD4CAKen
         t7dtWnhae6fgOLVbIbGd1dyfI4oh4D0j4iUSF5B+iFU0soi/M+gNPTeAZETQEWgtDmkm
         t1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iWbjnVW9quu+0NtNnTMMNkLY8fmdpVFvrVoHkkaQvEQ=;
        b=utuiQWqBGvIHI4UX+y6etoI/i6zE3c2Fe83gtGdaQah8+RaAPvlUNiNYE2U+TascMY
         rxBGy6warF3IkhslEc3IxI7bA4XnZauDmdC+LsV7phiPuktcMvLMwXqhUhRKLt1++JKY
         ZRbQU1rxpFMTxehwImh3r2c1xF1NgNAKS5XxwYYX3g6P+Axul5ccicXGyEp3j4BBoLj0
         WAenPt1eixVNwlGDPgs52iL3aLEj4WMWfmYMKGuTuX3nyYENSV2saxLZWgrxYK/YeRZA
         qgogYu7NUHMwW/lneI+psHAIs4XVi+nfo1ZLyhlr9mi09FE8c5XqbZRvWg10+/3foYbu
         CsQA==
X-Gm-Message-State: AOAM533BdLCP4npLNXltLyCu5APtVBA2Ax35mszEc19w4o8m3Yh3s2F+
        i8n1vfCkdLDNiUwUDXw0pEUMc3KklciEPdueYw==
X-Google-Smtp-Source: ABdhPJzcCdvq8q9XQb1O4aR4bIpvJEJGxXrhO6ualjK9V7a2GMhPqSOLanZOyZ3qJdbHQ3QYHTDQ9ncHIm5YCSlIY08=
X-Received: by 2002:a17:90b:3447:: with SMTP id lj7mr2517568pjb.112.1632363901814;
 Wed, 22 Sep 2021 19:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsYjkubyQBvBy7aaQStk_i1UuCu7oPNYXhZhvhWvBCM3ag@mail.gmail.com>
 <145029f0-5bc5-73fd-14ee-75b5829a3334@gmx.com>
In-Reply-To: <145029f0-5bc5-73fd-14ee-75b5829a3334@gmx.com>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Thu, 23 Sep 2021 10:24:51 +0800
Message-ID: <CACkBjsauCShYkOdNU2snmJyLNSmdMvK7C0HbtMfKhoEXuUOSJg@mail.gmail.com>
Subject: Re: kernel BUG in __clear_extent_bit
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     clm@fb.com, dsterba@suse.com, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8815=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=881:33=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 2021/9/15 =E4=B8=8A=E5=8D=8810:20, Hao Sun wrote:
> > Hello,
> >
> > When using Healer to fuzz the latest Linux kernel, the following crash
> > was triggered.
> >
> > HEAD commit: 6880fa6c5660 Linux 5.15-rc1
> > git tree: upstream
> > console output:
> > https://drive.google.com/file/d/1-9wwV6-OmBcJvHGCbMbP5_uCVvrUdTp3/view?=
usp=3Dsharing
> > kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHTL=
JvsUdWcgB/view?usp=3Dsharing
> > C reproducer: https://drive.google.com/file/d/1eXePTqMQ5ZA0TWtgpTX50Ez4=
q9ZKm_HE/view?usp=3Dsharing
> > Syzlang reproducer:
> > https://drive.google.com/file/d/11s13louoKZ7Uz0mdywM2jmE9B1JEIt8U/view?=
usp=3Dsharing
> >
> > If you fix this issue, please add the following tag to the commit:
> > Reported-by: Hao Sun <sunhao.th@gmail.com>
> >
> > loop1: detected capacity change from 0 to 32768
> > BTRFS info (device loop1): disk space caching is enabled
> > BTRFS info (device loop1): has skinny extents
> > BTRFS info (device loop1): enabling ssd optimizations
> > FAULT_INJECTION: forcing a failure.
> > name failslab, interval 1, probability 0, space 0, times 0
> > CPU: 1 PID: 25852 Comm: syz-executor Not tainted 5.15.0-rc1 #16
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:88 [inline]
> >   dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
> >   fail_dump lib/fault-inject.c:52 [inline]
> >   should_fail+0x13c/0x160 lib/fault-inject.c:146
> >   should_failslab+0x5/0x10 mm/slab_common.c:1328
> >   slab_pre_alloc_hook.constprop.99+0x4e/0xc0 mm/slab.h:494
> >   slab_alloc_node mm/slub.c:3120 [inline]
> >   slab_alloc mm/slub.c:3214 [inline]
> >   kmem_cache_alloc+0x44/0x280 mm/slub.c:3219
> >   alloc_extent_state+0x1e/0x1c0 fs/btrfs/extent_io.c:340
>
> This is the one of the core systems btrfs uses, and we really don't want
> that to fail.
>
> Thus in fact it does some preallocation to prevent failure.
>
> But for error injection case, we can still hit BUG_ON() which is used to
> catch ENOMEM.
>

Hello,

Fuzzer triggered following crashes repeatedly when the `fault
injection` was enabled.

HEAD commit: 92477dd1faa6 Merge tag 's390-5.15-ebpf-jit-fixes'
git tree: upstream
kernel config: https://drive.google.com/file/d/1KgvcM8i_3hQiOL3fUh3JFpYNQM4=
itvV4/view?usp=3Dsharing
[1] kernel BUG in btrfs_free_tree_block (fs/btrfs/extent-tree.c:3297):
https://paste.ubuntu.com/p/ZtzVKWbcGm/
[2] kernel BUG in clear_state_bit (fs/btrfs/extent_io.c:658!):
https://paste.ubuntu.com/p/hps2wXPG2b/
[3] kernel BUG in set_extent_bit (fs/btrfs/extent_io.c:1021):
https://paste.ubuntu.com/p/dcptjYYxgd/
[4] kernel BUG in set_state_bits (fs/btrfs/extent_io.c:939):
https://paste.ubuntu.com/p/NV9qtKB4KZ/

All the above crashes were triggered directly by the `BUG_ON()` macro
in the corresponding location.
Most `BUG_ON()` was hit due to `ENOMEM` when fault injected.
Would it be better for btrfs to handle the `ENOMEM` error, e.g.,
gracefully return, rather than panic the kernel?

Regards
Hao
