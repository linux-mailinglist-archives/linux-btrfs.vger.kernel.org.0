Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6432A6C88
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 19:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgKDSOk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 13:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729918AbgKDSOj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 13:14:39 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D57C0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 10:14:39 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id d9so17143007oib.3
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 10:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d1Olf+C2iDU15w0CWjxhtzz9+m5ci4iZk8rDzyMHw+U=;
        b=apvudbnjlSyt0SIQFoZBX39ptAi/cr8Eb7skjOPcwgwcLwEzTCWW8pQSs4g3gr6jOx
         ADGMRzajjpjgWPLiYPfqmrdCNfnm84dIFufWvW74yZPMWE+4+l65NuLsDEMUs5o5T9K+
         EB4RkZg1oiQ1OTJho2LGC6Fp9xofbWjF2cfgm3z1raGxQcqzkpzor/RR8GpbCTs7YK5y
         cqfUI5gK/yaEAux6sxktEShRa1m9AD3VvgyDVlZ/VAO6J6DruIc2+f6yiVKYDqfqVLrb
         k/jtPlTiDQf5Hwt3xtInIhcoob/441M55z+lkF+HexNkjM3WlPumt/ctTtunfNY0UmRx
         pPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d1Olf+C2iDU15w0CWjxhtzz9+m5ci4iZk8rDzyMHw+U=;
        b=kdE+4/ygoU+4RPqk0o8P9193RKUslrWz0btlLj6VTWr1rXd4KkDtsgaQ1qhkCoXyqW
         dXRvI9YqDa6CAT5tXmMvjbzc0YOmU/h0qohs1pIDH8GxcnUbL7GucZ+gx9hg2K/6nB+l
         BdD53+PRCzxfXQrIlzIO3XeYDHhfFpwNZR/XRXIX7TkR5aPZ/Z4gxRV3CrjY05NZhQjs
         t4aWAMHoIs+4TEGYtSw5MTYiMDMJl00yaxvycHKpbTmdzpZ9snOl0OXxDhvE427knOIo
         Cy9ilL1rf67cDD5xqYAA+MI0j+jR4P0L3bGkgRU4eekcVf4NrDr5SoqVQwkUhkSsieuU
         VDJQ==
X-Gm-Message-State: AOAM532iHThqiLXVWhc01SEqHgKp0r6xL8ZcSsi8Vl1tXXcSGlZslqGG
        zv2QH0HvLLfchLx8h1eABHymCXHW38ApL8wctWo=
X-Google-Smtp-Source: ABdhPJy2pBIjYIzxP/YYGc0Z4SHmXKuoY8tYb5B3TDVFP5Z8XDVf5uYVjIPy3uNruCyX/GrjNSmn2fqO5M5TA8fOO84=
X-Received: by 2002:aca:2111:: with SMTP id 17mr3177566oiz.139.1604513677544;
 Wed, 04 Nov 2020 10:14:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604444952.git.asml.silence@gmail.com> <2a3d84dfc9384eed8659963d1dafedabb3f17c75.1604444952.git.asml.silence@gmail.com>
 <CAE1WUT5+3xLHe54Mk0wEmp1GtbRhkMkdSi=QPERZegphk=ecLw@mail.gmail.com>
 <2be31971-da4f-1a39-cb01-0c13b35cf2aa@gmail.com> <CAE1WUT4HtRLs+-7T825akYVBwCtugcnXZ3J4XvaL0_b5F9G18Q@mail.gmail.com>
 <4484059b-1e9a-995c-1632-b0ee81eaf605@gmail.com> <CAE1WUT6WudydeAyXLKaJBQeaouFb3Sx42euekDHGR9tD61nm3Q@mail.gmail.com>
 <36897f55-26cf-4814-8549-9392a6e9e4b1@gmail.com>
In-Reply-To: <36897f55-26cf-4814-8549-9392a6e9e4b1@gmail.com>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Wed, 4 Nov 2020 10:14:26 -0800
Message-ID: <CAE1WUT4D9JFYEf5fdhX5TNahRoTPswYbC8QT23fhehZyeBrdvw@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: discard: speed up discard up to iops_limit
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 4, 2020 at 10:09 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>
> On 04/11/2020 17:55, Amy Parker wrote:
> > On Wed, Nov 4, 2020 at 9:50 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
> >>
> >> On 04/11/2020 17:33, Amy Parker wrote:
> >>> On Wed, Nov 4, 2020 at 9:22 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
> >>>>
> >>>> On 04/11/2020 15:29, Amy Parker wrote:
> >>>>> On Wed, Nov 4, 2020 at 1:50 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
> >>>>>>
> >>>>>> Instead of using iops_limit only for cutting off extremes, calculate the
> >>>>>> discard delay directly from it, so it closely follows iops_limit and
> >>>>>> doesn't under-discarding even though quotas are not saturated.
> >>>>>
> >>>>> This sounds like it potentially be a great performance boost, do you
> >>>>> have any performance metrics regarding this patch?
> >>>>
> >>>> Boosting the discard rate and so reaping stalling blocks may be nice, but
> >>>> unless it holds too much memory creating lack of space it shouldn't affect
> >>>> throughput. Though, it's better to ask people with deeper understanding
> >>>> of the fs.
> >>>
> >>> Alright, thanks for the clarification.
> >>>
> >>>> What I've seen is that in some cases there are extents staying queued for
> >>>> discarding for _too_ long. E.g. reaping a small number of very fat extents
> >>>> keeps delay at max and doesn't allow to reap them effectively. That could
> >>>> be a problem with fast drives.
> >>>
> >>> Ah, yep. Seen this personally to a smaller extent.
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> >>>>>> ---
> >>>>>>  fs/btrfs/discard.c | 10 +++++-----
> >>>>>>  1 file changed, 5 insertions(+), 5 deletions(-)
> >>>>>>
> >>>>>> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> >>>>>> index 741c7e19c32f..76796a90e88d 100644
> >>>>>> --- a/fs/btrfs/discard.c
> >>>>>> +++ b/fs/btrfs/discard.c
> >>>>>> @@ -519,7 +519,6 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
> >>>>>>         s64 discardable_bytes;
> >>>>>>         u32 iops_limit;
> >>>>>>         unsigned long delay;
> >>>>>> -       unsigned long lower_limit = BTRFS_DISCARD_MIN_DELAY_MSEC;
> >>>>>>
> >>>>>>         discardable_extents = atomic_read(&discard_ctl->discardable_extents);
> >>>>>>         if (!discardable_extents)
> >>>>>> @@ -550,11 +549,12 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
> >>>>>>
> >>>>>>         iops_limit = READ_ONCE(discard_ctl->iops_limit);
> >>>>>>         if (iops_limit)
> >>>>>> -               lower_limit = max_t(unsigned long, lower_limit,
> >>>>>> -                                   MSEC_PER_SEC / iops_limit);
> >>>>>> +               delay = MSEC_PER_SEC / iops_limit;
> >>>>>> +       else
> >>>>>> +               delay = BTRFS_DISCARD_TARGET_MSEC / discardable_extents;
> >>>>>
> >>>>> Looks good to me. I wonder why there wasn't handling of if iops_limit
> >>>>> was unfindable
> >>>>> before?
> >>>>
> >>>> Not sure what you mean by unfindable, but async discard is relatively new,
> >>>> might be that everyone just have their hands full.
> >>>
> >>> By unfindable I mean if iops_limit turned up as null when reading it
> >>> from discard_ctl.
> >>
> >> Ahh, ok. It's handled and I left it as it was, that BTW is still a problem.
> >
> > How often is iops_limit unfindable?
>
> I don't know, but the default is 10, so shouldn't be too ubiquitous.
> Maybe someone here knows statistics.

So it isn't a major issue right now, and we can just have it looked at whenever
someone has the time to.

>
> >
> >>
> >> First it calculates a delay based on number of queued extents and than clamps
> >> it to (BTRFS_DISCARD_MIN_DELAY_MSEC, BTRFS_DISCARD_MAX_DELAY_MSEC). Without
> >> this patch it did the same but the lower bound was calculated from iops_limit.
> >
> > Thanks for clarifying.
> >
> >>
> >>> Async discard was added in 5.6, correct? So yeah, makes sense then that people
> >>> just had their hands full. Thanks for adding it.
> >>
> >> b0643e59cfa609c4b5f ("btrfs: add the beginning of async discard, discard
> >> workqueue"). Dec 2019, so less than a year
> >
> > Thanks for finding the commit.
> >
> >>
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>> -       delay = BTRFS_DISCARD_TARGET_MSEC / discardable_extents;
> >>>>>> -       delay = clamp(delay, lower_limit, BTRFS_DISCARD_MAX_DELAY_MSEC);
> >>>>>> +       delay = clamp(delay, BTRFS_DISCARD_MIN_DELAY_MSEC,
> >>>>>> +                     BTRFS_DISCARD_MAX_DELAY_MSEC);
> >>>>>>         discard_ctl->delay = msecs_to_jiffies(delay);
> >>>>>>
> >>>>>>         spin_unlock(&discard_ctl->lock);
> >>>>>> --
> >>>>>> 2.24.0
> >>>>>>
> >>>>>
> >>>>> This patch looks all great to me.
> >>
> >> --
> >> Pavel Begunkov
> >
> > Best regards,
> > Amy Parker
> > (they/them)
> >
>
> --
> Pavel Begunkov

Best regards,
Amy Parker
(they/them)
