Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A5438AF97
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 15:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbhETNGH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 09:06:07 -0400
Received: from mail-vs1-f52.google.com ([209.85.217.52]:36644 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242444AbhETNFu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 09:05:50 -0400
Received: by mail-vs1-f52.google.com with SMTP id x2so2420671vss.3;
        Thu, 20 May 2021 06:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=foGnt7urXKNYjsWqXFpWrjCuk/hA7vhmeA822d2QImU=;
        b=UfAqH8qylmgC1f1JexZf6/7SWlx8eiaY/fEtwdABLQ39pISvCjz73r9brlyy7O5EJN
         B+jm4bdoY8W0M23L0exklBEFzWf+8sU81QOcHmFM3yeC/YaHkPYMWHvTt7j6PHIZyUEE
         xe4esXtGSDhsgvBfp5qPZYDlJSh41BU5wvuugahUaafNKCZVDfOg1B/zUXn8QOjdUkzX
         wlL8RTm/2n0SZ7l3S19a1Jk5XRGjOXpMk3Hu4UNHvBLF/m7ur15eVDU+aXhhDA/KMeql
         6bXQENkNUWdIJgZalNbZuLs1UzZ5lYBZacmqhlAPpqoncHT7iSBa/aafbbLzbqzTvPN+
         HTvA==
X-Gm-Message-State: AOAM531fjqMoLxzy10jYq9w6O2u8L7LlhcQ6bk2sLPs9mB4KY7+iw6Ja
        yY0NTbscP+ETcpW8kPtn7RoK9eG4uF3xPsRmuwOlZVJe
X-Google-Smtp-Source: ABdhPJyHS10oMMIyYWIe0+274SwzL6E1ylXlWyRdfMR4gr9yWyWKZZTB3dGG6Gl03fyxKrc/NfKtZCewZVfrFRa0kzA=
X-Received: by 2002:a67:fb52:: with SMTP id e18mr3948317vsr.18.1621515867443;
 Thu, 20 May 2021 06:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210518144935.15835-1-dsterba@suse.com> <alpine.DEB.2.22.394.2105200927570.1771368@ramsan.of.borg>
 <20210520125508.GA7604@twin.jikos.cz>
In-Reply-To: <20210520125508.GA7604@twin.jikos.cz>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 May 2021 15:04:15 +0200
Message-ID: <CAMuHMdVLGamSHLthpXQ=bd-0WJ-1X_d6ONYyjAzVf7e-2P5_uQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: scrub: per-device bandwidth control
To:     David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

On Thu, May 20, 2021 at 2:57 PM David Sterba <dsterba@suse.cz> wrote:
> On Thu, May 20, 2021 at 09:43:10AM +0200, Geert Uytterhoeven wrote:
> > > - values written to the file accept suffixes like K, M
> > > - file is in the per-device directory /sys/fs/btrfs/FSID/devinfo/DEVID/scrub_speed_max
> > > - 0 means use default priority of IO
> > >
> > > The scheduler is a simple deadline one and the accuracy is up to nearest
> > > 128K.
> > >
> > > Signed-off-by: David Sterba <dsterba@suse.com>
> >
> > Thanks for your patch, which is now commit b4a9f4bee31449bc ("btrfs:
> > scrub: per-device bandwidth control") in linux-next.
> >
> > noreply@ellerman.id.au reported the following failures for e.g.
> > m68k/defconfig:
> >
> > ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!
> > ERROR: modpost: "__divdi3" [fs/btrfs/btrfs.ko] undefined!
>
> I'll fix it, thanks for the report.

Thanks!

> > BTW, any chance you can start adding lore Link: tags to your commits, to
> > make it easier to find the email thread to reply to when reporting a
> > regression?
>
> Well, no I'm not going to do that, sorry. It should be easy enough to
> paste the patch subject to the search field on lore.k.org and click the
> link leading to the mail, I do that all the time. Making sure that

There's no global search field on lore.kernel.org (yet), so you still have
to guess the mailing list.  In this case that was obvious, but that's not always
the case.

> patches have all the tags and information takes time already so I'm not
> too keen to spend time on adding links.

The link can be added automatically by a git hook.  Hence if you use b4
to get the series with all tags, you'll get the Link: for free!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
