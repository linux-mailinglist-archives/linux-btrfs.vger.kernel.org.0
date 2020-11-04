Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F8F2A6BBE
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 18:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgKDRd1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 12:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgKDRd1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 12:33:27 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B22C0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 09:33:27 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id g19so10603707otp.13
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 09:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jidzrOk+kTD3BChM6SHWvDod2vcVw7HvFBLp5y6wXr0=;
        b=GQ0L0o7wMWCtRpFn9KhBnrqKChuR6HklKcJ22D4FED6Pkcf6Hk8W+Pspj61oi0Y4ce
         VUkXrEqd4rVhroR7VxaW3QClaYisZWPFTGGmCMUeyOye2gnCXj09EyZBySvIZ1n7eaeH
         p1Y+aLOM+6UftXD1XH7qO4NUK30SipjYfRWkzcEhmAHcQDZFHL8QYhcD6q9BmCk8hH/L
         sQZ+uRQgPdJb+Jtab2k/OOczoRV33I5CX602gztiyaqPuQveHlNK1ZxwyYpNvsuDYiCm
         ABQdez7IWiF1MeELKqFHvJTBSlyqt4ijvta080EH9wbi8F/uk14c2C+u8GbRd4HA4JfC
         QPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jidzrOk+kTD3BChM6SHWvDod2vcVw7HvFBLp5y6wXr0=;
        b=XRAkuna/bUGr8536bC9q6H38WBaCHknzw9/j6wFOUeYWR6tIWCRGAIe7d57vV/IRBk
         8hToFZO2fl7BZMSk+tG1SWxwZOQDCkvpk53lL5k/TROV8B585o4FKSahhjDPONf0ylbs
         cL8vxgCmMtynxydyZjUXfgQ9UahsVSOVjjNHc6Hro6MiVjhssTETRFK1+NJo804rD1kv
         9zfxUMTUjFk45VwaCeenhbhxokuFJ+jbuny1/fNBWvENIWGJbtSBmbovYrgWxs/8xW4B
         Qy35JK7kR1ivcVp/5tHqLi7lFPWGs4XTOkIRHEUHP/RYe47SFOGSWBatzWvhuSLVFaRC
         JWkw==
X-Gm-Message-State: AOAM530Oj+hvV6LtfZQF97FggGhl9wELO/Lv8h/M8FbWbvISBn1H1b/I
        r+KBM4E/JL2GCRd/3oDJ4UKFubH+h6mi8BiuO0I=
X-Google-Smtp-Source: ABdhPJxSCwzy/L0ICxwuPD1texgaoSJzWV5QZ/zpnObhIn9ZKsUXDT4n3BJYdPumqBGpQwwrEFgW4mN/+Y9jGJ5soPw=
X-Received: by 2002:a9d:1b2:: with SMTP id e47mr13914090ote.45.1604511206601;
 Wed, 04 Nov 2020 09:33:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604444952.git.asml.silence@gmail.com> <2a3d84dfc9384eed8659963d1dafedabb3f17c75.1604444952.git.asml.silence@gmail.com>
 <CAE1WUT5+3xLHe54Mk0wEmp1GtbRhkMkdSi=QPERZegphk=ecLw@mail.gmail.com> <2be31971-da4f-1a39-cb01-0c13b35cf2aa@gmail.com>
In-Reply-To: <2be31971-da4f-1a39-cb01-0c13b35cf2aa@gmail.com>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Wed, 4 Nov 2020 09:33:15 -0800
Message-ID: <CAE1WUT4HtRLs+-7T825akYVBwCtugcnXZ3J4XvaL0_b5F9G18Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: discard: speed up discard up to iops_limit
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 4, 2020 at 9:22 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>
> On 04/11/2020 15:29, Amy Parker wrote:
> > On Wed, Nov 4, 2020 at 1:50 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
> >>
> >> Instead of using iops_limit only for cutting off extremes, calculate the
> >> discard delay directly from it, so it closely follows iops_limit and
> >> doesn't under-discarding even though quotas are not saturated.
> >
> > This sounds like it potentially be a great performance boost, do you
> > have any performance metrics regarding this patch?
>
> Boosting the discard rate and so reaping stalling blocks may be nice, but
> unless it holds too much memory creating lack of space it shouldn't affect
> throughput. Though, it's better to ask people with deeper understanding
> of the fs.

Alright, thanks for the clarification.

> What I've seen is that in some cases there are extents staying queued for
> discarding for _too_ long. E.g. reaping a small number of very fat extents
> keeps delay at max and doesn't allow to reap them effectively. That could
> be a problem with fast drives.

Ah, yep. Seen this personally to a smaller extent.

>
> >
> >>
> >> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> >> ---
> >>  fs/btrfs/discard.c | 10 +++++-----
> >>  1 file changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> >> index 741c7e19c32f..76796a90e88d 100644
> >> --- a/fs/btrfs/discard.c
> >> +++ b/fs/btrfs/discard.c
> >> @@ -519,7 +519,6 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
> >>         s64 discardable_bytes;
> >>         u32 iops_limit;
> >>         unsigned long delay;
> >> -       unsigned long lower_limit = BTRFS_DISCARD_MIN_DELAY_MSEC;
> >>
> >>         discardable_extents = atomic_read(&discard_ctl->discardable_extents);
> >>         if (!discardable_extents)
> >> @@ -550,11 +549,12 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
> >>
> >>         iops_limit = READ_ONCE(discard_ctl->iops_limit);
> >>         if (iops_limit)
> >> -               lower_limit = max_t(unsigned long, lower_limit,
> >> -                                   MSEC_PER_SEC / iops_limit);
> >> +               delay = MSEC_PER_SEC / iops_limit;
> >> +       else
> >> +               delay = BTRFS_DISCARD_TARGET_MSEC / discardable_extents;
> >
> > Looks good to me. I wonder why there wasn't handling of if iops_limit
> > was unfindable
> > before?
>
> Not sure what you mean by unfindable, but async discard is relatively new,
> might be that everyone just have their hands full.

By unfindable I mean if iops_limit turned up as null when reading it
from discard_ctl.
Async discard was added in 5.6, correct? So yeah, makes sense then that people
just had their hands full. Thanks for adding it.

>
> >
> >>
> >> -       delay = BTRFS_DISCARD_TARGET_MSEC / discardable_extents;
> >> -       delay = clamp(delay, lower_limit, BTRFS_DISCARD_MAX_DELAY_MSEC);
> >> +       delay = clamp(delay, BTRFS_DISCARD_MIN_DELAY_MSEC,
> >> +                     BTRFS_DISCARD_MAX_DELAY_MSEC);
> >>         discard_ctl->delay = msecs_to_jiffies(delay);
> >>
> >>         spin_unlock(&discard_ctl->lock);
> >> --
> >> 2.24.0
> >>
> >
> > This patch looks all great to me.
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
