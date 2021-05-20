Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D441838AFC3
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 15:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbhETNQo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 09:16:44 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:33995 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241122AbhETNQl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 09:16:41 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N1PLB-1lLHyP3FBT-012oHC; Thu, 20 May 2021 15:15:18 +0200
Received: by mail-wr1-f48.google.com with SMTP id q5so17634504wrs.4;
        Thu, 20 May 2021 06:15:18 -0700 (PDT)
X-Gm-Message-State: AOAM533gSHHm1qKmgDA22uawrvfqLzhGQ6DDVo0mfMpU8mVXIVnuWyhx
        UZVQF0WYtRbiBZkwnPrP+xCnGY0a9IXdcZiCMAA=
X-Google-Smtp-Source: ABdhPJy7izUVg5gt6YElALhw2f6/zDsDMB1ic+kYNGjYv2X84KNuAl4bxBkpEVCqClz16VGivLF/RS3eczz4i7BIopU=
X-Received: by 2002:a05:6000:18a:: with SMTP id p10mr4278435wrx.99.1621516518422;
 Thu, 20 May 2021 06:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210518144935.15835-1-dsterba@suse.com> <alpine.DEB.2.22.394.2105200927570.1771368@ramsan.of.borg>
In-Reply-To: <alpine.DEB.2.22.394.2105200927570.1771368@ramsan.of.borg>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 May 2021 15:14:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3_O5CdbUqvJsnTh5p0RbSCsXyFhkO6afaLsnwf176Kiw@mail.gmail.com>
Message-ID: <CAK8P3a3_O5CdbUqvJsnTh5p0RbSCsXyFhkO6afaLsnwf176Kiw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: scrub: per-device bandwidth control
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:P95Wp0dHfCDqtxkBnMxD2851LdCVZdJzaJbDwDgs0BLJrVHqKJI
 dyOiknrBdDuPBZC1o8N4giLlrzkbZIUOGwEVCTwdMZf0+zZubWolX6WtqniSDja3E9VB/fC
 60EM4df0oNFLTgwjYYT0lRQfFlFR3b0oht2iHssqU9Jh/+vMVWr+Sv+afz78BG+XCa1s6VF
 ds90yoR15yhXC4bN6EDgA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sEkOzieQPeQ=:r4DROYVYvjuY/nCJplFbgb
 wrIoasPd9RbKnKC295O4XRkm37dnSqwKSU22E6E+2rvsD1sod1Pml4KupmMd2uGP8Jp7W+EaR
 nby0rCQbZ0qex9hfQ/1cyACCFswLidaVVLSPAN3dCi+LalWjR7Asld7u82jnbevSUgohWsEvE
 RblinN+QhmqjFicpy0INzxkvflX+fy4SpI5P5fiMcT4n+PW9Fznvf7tlvZIGgG4W9uMhlpRcz
 ndM23oA66O1EqJlNSieP2JXc/gIlYQakMuypGqBLWeym2HS1DgvO/pngRAJpuGM99gELkgMH7
 EU4cvb08lPh2YueAOMRhCoTBVNB5vX50pEPVpfN3/MHqTF852SB7ZzjtJcVVXHKcZz70FKVpg
 6N129/1973zvVJvlmjmAqqzGl70V2RqrbToOtmA14VKMojsMyWh3HxnOvrcbqeWIko+yx6s9z
 aZ49uwZkHuh7tLfej33lxefYndH38qNSlmqg2cwsyWz7ZxJPQLEtWpdvea/WyeM5UcWR/NY0h
 e/Jn3LUPgyl2nMOWMEjLkW5ApzHj1zjc8fqT8MOVmm3CsDNyEiMSYP8q1E9YLzoPHFAPawB5o
 YCSrtbfZDvhqozGQNro/Dby3pdjeFRHg4somkQC4biL+Z44K7Ok9Q+rtj+tCsb2ACDiMKRDps
 B99U=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 20, 2021 at 9:43 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, 18 May 2021, David Sterba wrote:

> > --- a/fs/btrfs/scrub.c
> > +++ b/fs/btrfs/scrub.c
> > @@ -1988,6 +1993,60 @@ static void scrub_page_put(struct scrub_page *spage)
> >       }
> > }
> >
> > +/*
> > + * Throttling of IO submission, bandwidth-limit based, the timeslice is 1
> > + * second.  Limit can be set via /sys/fs/UUID/devinfo/devid/scrub_speed_max.
> > + */
> > +static void scrub_throttle(struct scrub_ctx *sctx)
> > +{
> > +     const int time_slice = 1000;
> > +     struct scrub_bio *sbio;
> > +     struct btrfs_device *device;
> > +     s64 delta;
> > +     ktime_t now;
> > +     u32 div;
> > +     u64 bwlimit;
> > +
> > +     sbio = sctx->bios[sctx->curr];
> > +     device = sbio->dev;
> > +     bwlimit = READ_ONCE(device->scrub_speed_max);
> > +     if (bwlimit == 0)
> > +             return;
> > +
> > +     /*
> > +      * Slice is divided into intervals when the IO is submitted, adjust by
> > +      * bwlimit and maximum of 64 intervals.
> > +      */
> > +     div = max_t(u32, 1, (u32)(bwlimit / (16 * 1024 * 1024)));
> > +     div = min_t(u32, 64, div);
> > +
> > +     /* Start new epoch, set deadline */
> > +     now = ktime_get();
> > +     if (sctx->throttle_deadline == 0) {
> > +             sctx->throttle_deadline = ktime_add_ms(now, time_slice / div);
>
> ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!
>
> div_u64(bwlimit, div)

If 'time_slice' is in nanoseconds, the best interface to use
is ktime_divns().

> > +             sctx->throttle_sent = 0;
> > +     }
> > +
> > +     /* Still in the time to send? */
> > +     if (ktime_before(now, sctx->throttle_deadline)) {
> > +             /* If current bio is within the limit, send it */
> > +             sctx->throttle_sent += sbio->bio->bi_iter.bi_size;
> > +             if (sctx->throttle_sent <= bwlimit / div)
> > +                     return;

Doesn't this also need to be changed?

> > +             /* We're over the limit, sleep until the rest of the slice */
> > +             delta = ktime_ms_delta(sctx->throttle_deadline, now);
> > +     } else {
> > +             /* New request after deadline, start new epoch */
> > +             delta = 0;
> > +     }
> > +
> > +     if (delta)
> > +             schedule_timeout_interruptible(delta * HZ / 1000);
>
> ERROR: modpost: "__divdi3" [fs/btrfs/btrfs.ko] undefined!
>
> I'm a bit surprised gcc doesn't emit code for the division by the
> constant 1000, but emits a call to __divdi3().  So this has to become
> div_u64(), too.

There is schedule_hrtimeout(), which takes a ktime_t directly
but has slightly different behavior. There is also an msecs_to_jiffies
helper that should produce a fast division.

       Arnd
