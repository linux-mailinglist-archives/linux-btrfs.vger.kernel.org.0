Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3FD37A013
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 May 2021 08:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhEKGxz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 May 2021 02:53:55 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:37690 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhEKGxy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 May 2021 02:53:54 -0400
Received: by mail-vs1-f43.google.com with SMTP id s15so6869354vsi.4;
        Mon, 10 May 2021 23:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e1OOiDVz4jUv/IlYBZXTh18pllXdMKyAArvIddCeWMw=;
        b=qxrzr2fswzdCK32nZtBCGQiNuL67NB68/5YBr1sCK+ZMO32XysL4XCf8eMZYVzyYtW
         EPHr2lHW2zA8YCHNGCqCIwAHpkLeZwjbrZo2YeO/LNdFDu2u++SxQgoLzICZ7p+O7tGp
         ViiC5xSgcTwtUXgDPTFq3DSEeF4Wq06V250IZzhaL4zzdC+P4PFpPYLEALmcWeOW40Bp
         cticRI/TU8I3HO8W6axJHN9yu8cIp1q+95feiNB0w72hOQEXrbhDuPDU0uwXS74eh9em
         yq5Dfg3sQz3Ah+53iXuU4KBLwubCzBDlhm80hbVJb4v6mrDgoAF4YLFvwHqT8ryifUN+
         /A0w==
X-Gm-Message-State: AOAM5302s6VNW3GcGSP3LP7ZMzX9ESXiGNWicwbScBKZQR+8e5Jpcky9
        Q6DoCNKop2gVPaA54vmUmJbYS9MPodA17TcOJec=
X-Google-Smtp-Source: ABdhPJzmQm74z77d6kfTHhr+3dxao5oa02U1uG8ObktOEbUD9Y7O2VfS1+Xgi4Gagh9y9h8CawKu2tIm8ydW2bCdA+U=
X-Received: by 2002:a67:8745:: with SMTP id j66mr24499434vsd.18.1620715968302;
 Mon, 10 May 2021 23:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210511133551.09bfd39c@canb.auug.org.au> <56cef5d3-cfb4-abe2-1cbc-f146b720396c@infradead.org>
In-Reply-To: <56cef5d3-cfb4-abe2-1cbc-f146b720396c@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 May 2021 08:52:37 +0200
Message-ID: <CAMuHMdWuz9oy2Xnb=9vMZD2q_-JU5XoSZb373CDTpBDLRZaviw@mail.gmail.com>
Subject: Re: linux-next: Tree for May 11 (btrfs)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Randy,

On Tue, May 11, 2021 at 7:13 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 5/10/21 8:35 PM, Stephen Rothwell wrote:
> > Changes since 20210510:
> >
>
> on i386:
>
> ld: fs/btrfs/extent_io.o: in function `btrfs_submit_read_repair':
> extent_io.c:(.text+0x624f): undefined reference to `__udivdi3'

I received a similar report from kisskb for m68k.

I assume the next version will fix this, cfr.
https://lore.kernel.org/linux-btrfs/751b7396-d0fd-d3b2-f14d-e730e6b08222@gmx.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
