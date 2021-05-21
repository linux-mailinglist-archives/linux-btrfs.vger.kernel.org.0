Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A74038CA4A
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 17:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbhEUPjn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 11:39:43 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:36353 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbhEUPjm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 11:39:42 -0400
Received: by mail-vs1-f50.google.com with SMTP id x2so4508569vss.3;
        Fri, 21 May 2021 08:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=p+cQg0XqSw6N2gR6iurEXLJBxBLY4iIdtLsf7ZxFkHA=;
        b=Gd33xmQjcPQLtCh31ouFnzrMC/ButHylb/kg7/ghIjXPlaNvoqBC6qDAbHMpfUFQHa
         e37w0EKt1AvqrYoA11VN4iMlp09niV7CLQQOZ2oKGalJJ1uiLIIlHGn1M//TssvXxEPr
         4N0hG5nEwxkbQdsdg7ur0zNjEZ7b3+fkJKzs1DkiB4iVVSGmL/3C2yu7iIlexoFtyxKs
         +X1yMODpBAZwnFT/MGU6uO+FORRXQCreFzPtZW/4w2L5eSbjhKcJnZhVnrzNab8b/OFH
         KD+1Y05rLn4mlD5lCVwY+X+yK37KZWYZT+jx667aUcv5i1aqVKHN/4T7/U5/gd5VNCK9
         5lhw==
X-Gm-Message-State: AOAM533Rq5PuHgCTpFFVjxMfqgtUcn5MK4nhD95DzZhE7RfQwTB2/QS8
        EgtiDrQBbfCQSiFb2QCugjUcTZNvJckXHYFihqnHhVfqMQI=
X-Google-Smtp-Source: ABdhPJzvJ6WAm5Hd6nkVmcmFxZ/wnRKHwpbIb8qxtfhirrBSKX76Fi7A4Ucyyvc1V2uDsyLj6XOuWg+ZbNvd5ylWB/0=
X-Received: by 2002:a67:fb52:: with SMTP id e18mr11604406vsr.18.1621611498180;
 Fri, 21 May 2021 08:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210518144935.15835-1-dsterba@suse.com> <alpine.DEB.2.22.394.2105200927570.1771368@ramsan.of.borg>
 <CAK8P3a3_O5CdbUqvJsnTh5p0RbSCsXyFhkO6afaLsnwf176Kiw@mail.gmail.com> <20210521151613.GN7604@twin.jikos.cz>
In-Reply-To: <20210521151613.GN7604@twin.jikos.cz>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 May 2021 17:38:06 +0200
Message-ID: <CAMuHMdWJC3PhD7ScnkG3kg_yjAh_UpfmyBOHrOq0e8dJ18ANew@mail.gmail.com>
Subject: Re: [PATCH] btrfs: scrub: per-device bandwidth control
To:     David Sterba <dsterba@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

On Fri, May 21, 2021 at 5:18 PM David Sterba <dsterba@suse.cz> wrote:
> On Thu, May 20, 2021 at 03:14:03PM +0200, Arnd Bergmann wrote:
> > On Thu, May 20, 2021 at 9:43 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, 18 May 2021, David Sterba wrote:
> > > > +     /* Start new epoch, set deadline */
> > > > +     now = ktime_get();
> > > > +     if (sctx->throttle_deadline == 0) {
> > > > +             sctx->throttle_deadline = ktime_add_ms(now, time_slice / div);
> > >
> > > ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!
> > >
> > > div_u64(bwlimit, div)
> >
> > If 'time_slice' is in nanoseconds, the best interface to use
> > is ktime_divns().
>
> It's in miliseconds and the division above is int/int, the problematic
> one is below.

Yep, sorry for the wrong pointer.

> >
> > > > +             sctx->throttle_sent = 0;
> > > > +     }
> > > > +
> > > > +     /* Still in the time to send? */
> > > > +     if (ktime_before(now, sctx->throttle_deadline)) {
> > > > +             /* If current bio is within the limit, send it */
> > > > +             sctx->throttle_sent += sbio->bio->bi_iter.bi_size;
> > > > +             if (sctx->throttle_sent <= bwlimit / div)
> > > > +                     return;
> >
> > Doesn't this also need to be changed?
> >
> > > > +             /* We're over the limit, sleep until the rest of the slice */
> > > > +             delta = ktime_ms_delta(sctx->throttle_deadline, now);
> > > > +     } else {
> > > > +             /* New request after deadline, start new epoch */
> > > > +             delta = 0;
> > > > +     }
> > > > +
> > > > +     if (delta)
> > > > +             schedule_timeout_interruptible(delta * HZ / 1000);
> > >
> > > ERROR: modpost: "__divdi3" [fs/btrfs/btrfs.ko] undefined!
> > >
> > > I'm a bit surprised gcc doesn't emit code for the division by the
> > > constant 1000, but emits a call to __divdi3().  So this has to become
> > > div_u64(), too.
> >
> > There is schedule_hrtimeout(), which takes a ktime_t directly
> > but has slightly different behavior. There is also an msecs_to_jiffies
> > helper that should produce a fast division.
>
> I'll use msecs_to_jiffies, thanks. If 'hr' in schedule_hrtimeout stands
> for high resolution, it's not necessary here.

msecs_to_jiffies() takes (32-bit) "unsigned int", while delta is "s64".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
