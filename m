Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC3038AFF3
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 15:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbhETN2E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 09:28:04 -0400
Received: from mail-vk1-f173.google.com ([209.85.221.173]:41816 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbhETN2D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 09:28:03 -0400
Received: by mail-vk1-f173.google.com with SMTP id n71so2664221vkf.8;
        Thu, 20 May 2021 06:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kVftqxA9v+JvVyYELD56NQzbqBmkwWKJa852Ut1Tatg=;
        b=cizpZg5tH2uwNSjCBET5vFzhEZJDZUb7/lrohZLAnRbtoZT98NPnNPrsZvZdeTYT3/
         4l6+dvVlys2zYMVQlVYIznMgj8j1sAcgQjUliSYKnxhIRRDXQ9gQcCuEjlh+YL6BLLIu
         o4ln6nn0FaGcHG1eyzOcuGtw3qditlNs69HnaEWopwMsRZY839vW2eQNo7TKenT1gQHN
         p2m/DZy59YW65u0zCq7pJD/vXNbSNZjMx1bQ3ZxVHnk0BNS6397lRKNwAzSGF++LMbh4
         89fhuefNjW08r173lkjBPE39grEhr5PSW2gz+oFVYf0d5bCs7gm8tRooJrmmn/SYmsmO
         0GNQ==
X-Gm-Message-State: AOAM531NJz1ZbZpGwUZh9I1GEEnZa4HDHl+76JRmaq0I/xDfE0cLTgXQ
        M7XJEFrUPuP9GgVwQlsgBHwVXsbLVRZd5FgeKqg7fsFn
X-Google-Smtp-Source: ABdhPJyl6lYJFVdz57nxN6fV6GjRxgWNrWyvP7/aAFid7dKsdHsMIlU4xz5jVMI7LURDD/Z0d7DIpJvvUvqOcKvyAZE=
X-Received: by 2002:a1f:a388:: with SMTP id m130mr4145273vke.1.1621517200867;
 Thu, 20 May 2021 06:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210518144935.15835-1-dsterba@suse.com> <alpine.DEB.2.22.394.2105200927570.1771368@ramsan.of.borg>
 <CAK8P3a3_O5CdbUqvJsnTh5p0RbSCsXyFhkO6afaLsnwf176Kiw@mail.gmail.com>
In-Reply-To: <CAK8P3a3_O5CdbUqvJsnTh5p0RbSCsXyFhkO6afaLsnwf176Kiw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 May 2021 15:26:29 +0200
Message-ID: <CAMuHMdVFAc66m=eSWhd3Vzk4J_YH8UF6Qe+M2C=PRZ1StYMg_w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: scrub: per-device bandwidth control
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Arnd,

On Thu, May 20, 2021 at 3:15 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, May 20, 2021 at 9:43 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, 18 May 2021, David Sterba wrote:
> > > --- a/fs/btrfs/scrub.c
> > > +++ b/fs/btrfs/scrub.c
> > > @@ -1988,6 +1993,60 @@ static void scrub_page_put(struct scrub_page *spage)
> > >       }
> > > }
> > >
> > > +/*
> > > + * Throttling of IO submission, bandwidth-limit based, the timeslice is 1
> > > + * second.  Limit can be set via /sys/fs/UUID/devinfo/devid/scrub_speed_max.
> > > + */
> > > +static void scrub_throttle(struct scrub_ctx *sctx)
> > > +{
> > > +     const int time_slice = 1000;
> > > +     struct scrub_bio *sbio;
> > > +     struct btrfs_device *device;
> > > +     s64 delta;
> > > +     ktime_t now;
> > > +     u32 div;
> > > +     u64 bwlimit;
> > > +
> > > +     sbio = sctx->bios[sctx->curr];
> > > +     device = sbio->dev;
> > > +     bwlimit = READ_ONCE(device->scrub_speed_max);
> > > +     if (bwlimit == 0)
> > > +             return;
> > > +
> > > +     /*
> > > +      * Slice is divided into intervals when the IO is submitted, adjust by
> > > +      * bwlimit and maximum of 64 intervals.
> > > +      */
> > > +     div = max_t(u32, 1, (u32)(bwlimit / (16 * 1024 * 1024)));
> > > +     div = min_t(u32, 64, div);
> > > +
> > > +     /* Start new epoch, set deadline */
> > > +     now = ktime_get();
> > > +     if (sctx->throttle_deadline == 0) {
> > > +             sctx->throttle_deadline = ktime_add_ms(now, time_slice / div);
> >
> > ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!
> >
> > div_u64(bwlimit, div)
>
> If 'time_slice' is in nanoseconds, the best interface to use
> is ktime_divns().

Actually this one is not a problem...

>
> > > +             sctx->throttle_sent = 0;
> > > +     }
> > > +
> > > +     /* Still in the time to send? */
> > > +     if (ktime_before(now, sctx->throttle_deadline)) {
> > > +             /* If current bio is within the limit, send it */
> > > +             sctx->throttle_sent += sbio->bio->bi_iter.bi_size;
> > > +             if (sctx->throttle_sent <= bwlimit / div)
> > > +                     return;
>
> Doesn't this also need to be changed?

... but this is.

Sorry. I added the annotation to the wrong line, after devising which
code caused the issue from looking at the generated assembly ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
