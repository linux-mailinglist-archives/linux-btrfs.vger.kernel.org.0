Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A75B2A6C43
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 18:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbgKDRzv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 12:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731043AbgKDRzv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 12:55:51 -0500
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F08C0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 09:55:49 -0800 (PST)
Received: by mail-oo1-xc44.google.com with SMTP id j6so5284650oot.3
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 09:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhuMgDpKrqkM4w2HAERuPkVhyT5XbllWbSPb9SHvluA=;
        b=BhsRQ7KMydQ06lEUYR1SiHrx4jKSn7WxunBo5JiumTBOVpRIe8T6jVkk8D1RWK7FR0
         miFR6pIn9oppMyPqrunAkVZ0wZvob3q643+LCLeVtSjgPkLU5dL2AkQWBZBb2VpqqVeg
         t4mqNXwn6NgmsRQETrPWoZLuWL6h0FglBFk6lcIrmE+IcntabW3Ef7ohLkaDL91jAvnZ
         e5OKWTrpnCpQZEWvriltbYYzAI7dypq8f5oeksiC6w6pUNHLM+7b30JVP9Y1hppuwtMe
         SsJAfLCU47sEFSFM1Om0BjdyMm2bfp8diTLHysMLgJvtrUuiPkH7ppTIRDiPr1oAUwfX
         hoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhuMgDpKrqkM4w2HAERuPkVhyT5XbllWbSPb9SHvluA=;
        b=kET6LRJx4LuUudE6ubyBVkUvxsk2JJKDH2w4I5uqij4YM8FYMRKIi5UFMq7RUwP+s0
         NOROqIDsu6OdQjQK176/EM6eThlfM+K24KZ/CQRTPrFJbGtjUCfkW3Dr9T6h4XibmHpT
         f4kW0R77h3++TCWaW9Dl22uYQl7RWYCwuMAZlx4jqGfxFNlK3aS3m3j/V0Cdk9Bf6aOP
         GCt6PG9ezxirvkixDFj2C+ClU1PVomt3IQ2yCfMQboJ/bo3wtA8vz2f3u1neD8lDh1nL
         WA3yWzelEdqe9Trj1v6AGi/22m2C2cvuEpzC3rjJeVpSflt8NlNGn6qJFYVpK7HhiXGT
         dhjA==
X-Gm-Message-State: AOAM5300BMY/3bVca/SaFca489241jmXsxR8/9X/yMU7B4fNMneO5X6z
        KztTh5C7QX2G0fGj69pgUpMb0KS0qI4XxhG6d04=
X-Google-Smtp-Source: ABdhPJwdNZ9TkBWagVPhSMW/e1ZBxEMA58Pi2KZb24phPlENQcnY+2O3Yu5GPUD8+tqVkCLewtfJT85j12QyVRrr/fU=
X-Received: by 2002:a4a:be92:: with SMTP id o18mr19704201oop.22.1604512549306;
 Wed, 04 Nov 2020 09:55:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604444952.git.asml.silence@gmail.com> <2a3d84dfc9384eed8659963d1dafedabb3f17c75.1604444952.git.asml.silence@gmail.com>
 <CAE1WUT5+3xLHe54Mk0wEmp1GtbRhkMkdSi=QPERZegphk=ecLw@mail.gmail.com>
 <2be31971-da4f-1a39-cb01-0c13b35cf2aa@gmail.com> <CAE1WUT4HtRLs+-7T825akYVBwCtugcnXZ3J4XvaL0_b5F9G18Q@mail.gmail.com>
 <4484059b-1e9a-995c-1632-b0ee81eaf605@gmail.com>
In-Reply-To: <4484059b-1e9a-995c-1632-b0ee81eaf605@gmail.com>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Wed, 4 Nov 2020 09:55:37 -0800
Message-ID: <CAE1WUT6WudydeAyXLKaJBQeaouFb3Sx42euekDHGR9tD61nm3Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: discard: speed up discard up to iops_limit
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 4, 2020 at 9:50 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>
> On 04/11/2020 17:33, Amy Parker wrote:
> > On Wed, Nov 4, 2020 at 9:22 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
> >>
> >> On 04/11/2020 15:29, Amy Parker wrote:
> >>> On Wed, Nov 4, 2020 at 1:50 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
> >>>>
> >>>> Instead of using iops_limit only for cutting off extremes, calculate the
> >>>> discard delay directly from it, so it closely follows iops_limit and
> >>>> doesn't under-discarding even though quotas are not saturated.
> >>>
> >>> This sounds like it potentially be a great performance boost, do you
> >>> have any performance metrics regarding this patch?
> >>
> >> Boosting the discard rate and so reaping stalling blocks may be nice, but
> >> unless it holds too much memory creating lack of space it shouldn't affect
> >> throughput. Though, it's better to ask people with deeper understanding
> >> of the fs.
> >
> > Alright, thanks for the clarification.
> >
> >> What I've seen is that in some cases there are extents staying queued for
> >> discarding for _too_ long. E.g. reaping a small number of very fat extents
> >> keeps delay at max and doesn't allow to reap them effectively. That could
> >> be a problem with fast drives.
> >
> > Ah, yep. Seen this personally to a smaller extent.
> >
> >>
> >>>
> >>>>
> >>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> >>>> ---
> >>>>  fs/btrfs/discard.c | 10 +++++-----
> >>>>  1 file changed, 5 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> >>>> index 741c7e19c32f..76796a90e88d 100644
> >>>> --- a/fs/btrfs/discard.c
> >>>> +++ b/fs/btrfs/discard.c
> >>>> @@ -519,7 +519,6 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
> >>>>         s64 discardable_bytes;
> >>>>         u32 iops_limit;
> >>>>         unsigned long delay;
> >>>> -       unsigned long lower_limit = BTRFS_DISCARD_MIN_DELAY_MSEC;
> >>>>
> >>>>         discardable_extents = atomic_read(&discard_ctl->discardable_extents);
> >>>>         if (!discardable_extents)
> >>>> @@ -550,11 +549,12 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
> >>>>
> >>>>         iops_limit = READ_ONCE(discard_ctl->iops_limit);
> >>>>         if (iops_limit)
> >>>> -               lower_limit = max_t(unsigned long, lower_limit,
> >>>> -                                   MSEC_PER_SEC / iops_limit);
> >>>> +               delay = MSEC_PER_SEC / iops_limit;
> >>>> +       else
> >>>> +               delay = BTRFS_DISCARD_TARGET_MSEC / discardable_extents;
> >>>
> >>> Looks good to me. I wonder why there wasn't handling of if iops_limit
> >>> was unfindable
> >>> before?
> >>
> >> Not sure what you mean by unfindable, but async discard is relatively new,
> >> might be that everyone just have their hands full.
> >
> > By unfindable I mean if iops_limit turned up as null when reading it
> > from discard_ctl.
>
> Ahh, ok. It's handled and I left it as it was, that BTW is still a problem.

How often is iops_limit unfindable?

>
> First it calculates a delay based on number of queued extents and than clamps
> it to (BTRFS_DISCARD_MIN_DELAY_MSEC, BTRFS_DISCARD_MAX_DELAY_MSEC). Without
> this patch it did the same but the lower bound was calculated from iops_limit.

Thanks for clarifying.

>
> > Async discard was added in 5.6, correct? So yeah, makes sense then that people
> > just had their hands full. Thanks for adding it.
>
> b0643e59cfa609c4b5f ("btrfs: add the beginning of async discard, discard
> workqueue"). Dec 2019, so less than a year

Thanks for finding the commit.

>
> >
> >>
> >>>
> >>>>
> >>>> -       delay = BTRFS_DISCARD_TARGET_MSEC / discardable_extents;
> >>>> -       delay = clamp(delay, lower_limit, BTRFS_DISCARD_MAX_DELAY_MSEC);
> >>>> +       delay = clamp(delay, BTRFS_DISCARD_MIN_DELAY_MSEC,
> >>>> +                     BTRFS_DISCARD_MAX_DELAY_MSEC);
> >>>>         discard_ctl->delay = msecs_to_jiffies(delay);
> >>>>
> >>>>         spin_unlock(&discard_ctl->lock);
> >>>> --
> >>>> 2.24.0
> >>>>
> >>>
> >>> This patch looks all great to me.
>
> --
> Pavel Begunkov

Best regards,
Amy Parker
(they/them)
