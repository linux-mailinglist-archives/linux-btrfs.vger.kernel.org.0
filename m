Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9010C2A6A32
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 17:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbgKDQqW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 11:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730987AbgKDQqV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 11:46:21 -0500
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D51C0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 08:46:21 -0800 (PST)
Received: by mail-oo1-xc44.google.com with SMTP id q1so777237oot.4
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 08:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SHfpYzI99G58vXwA7CXHhoQqrtsyDIZopLp/eDvcVKs=;
        b=r8s59GZ5aO4WKbYoIQy5MKDOYC+tTKxENNIN3lzSY0umcHUbhKsSNVG0lslbr9kzL1
         1THMpGGFMQSauJjvcACqaqv9ie9yd78YPOlB1AvuhIb++OJHho0V8908aeMJndB/0zRC
         M9w8QjBVYWzEiEa/KGrXhtjZ/6VNaIyFxI8glKZRQZjDVAGGLM1VuXR68nGleXChs9ZU
         SZCxiL9RJN3Z6Uob7+mNT1bBe7xKcH/nEUAdERdx2aT4tEtTTPbW2seTLr/ZY/0HSdvA
         n14286q2oNKd6SaUKLxk80dqCcjrhElJBSLByLLJxLj3jUQKCJbZZlrHmvE1vIBHPzUk
         NEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SHfpYzI99G58vXwA7CXHhoQqrtsyDIZopLp/eDvcVKs=;
        b=AoJEY+4JCuL0hYiEMbdfrTyyWumnWkPgGDS5nm+dLcK0HtXmtvk9sjMsdpuJj2CXD4
         U7dU8ak0xPb87hiX+Jfc0ozAlKqq/vmZHxRri0dC77LijTJ+kmbiFKM8+T/3O8pvE3wx
         H5NoB8kU9hSN+pSsDywp57nZije2yezdHJhxCNtua3H/R+M3ZPvZr5HkentA1UtN0nkx
         4uV+gAC3Oweuinp2nusx/eXO0uP1aBZh0nBH9BQV+y+923A4gkrHEtaqx14pWz4n+Zf5
         JApOae73C0z67sjWOjhAwH793/Fgd0Yrh2GsmYiK6LglMtgtFmZqVK8AGd2XaUanPQ+Q
         l0eQ==
X-Gm-Message-State: AOAM5319mHJsmC7xx7Ww5ipHI/qh2KKRXPB1kbdE0PH1lMy7qURQvyI/
        iag+hNesO1fyW+s5ZadcPjHWDRyYWGM23LolKK60vBFz4ZQ=
X-Google-Smtp-Source: ABdhPJwmgbv7J+XRiC+0FTXQ/x7ukYYSOJqzy8wmusBzMQdxJK0uwtGplnHWqxetyF0R8ldguVX1OK5w6dGeHUnixdo=
X-Received: by 2002:a4a:be92:: with SMTP id o18mr19504467oop.22.1604508380509;
 Wed, 04 Nov 2020 08:46:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604444952.git.asml.silence@gmail.com> <5be2ccce4a6ebe7c96274f63091a04aeba9af9d8.1604444952.git.asml.silence@gmail.com>
 <CAE1WUT5k8e_twhb8yZX7=kYFX-ikzUuQwunRkPCCH-zJ80Q6TA@mail.gmail.com> <bcd88bb1-37e6-2b1d-6fe8-390d3aa68d29@gmail.com>
In-Reply-To: <bcd88bb1-37e6-2b1d-6fe8-390d3aa68d29@gmail.com>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Wed, 4 Nov 2020 08:46:08 -0800
Message-ID: <CAE1WUT4VGT3zA1OkiH8S3wCTw8D-5=-c0psGCWndJt+M6UgGYg@mail.gmail.com>
Subject: Re: [PATCH 2/4] btrfs: discard: save discard delay as ns not jiffy
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 4, 2020 at 7:51 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>
> On 04/11/2020 15:35, Amy Parker wrote:
> > On Wed, Nov 4, 2020 at 1:52 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
> >>
> >> Most of calculations are done in ns or ms, so store discard_ctl->delay
> >> in ms and convert the final delay to jiffies only in the end.
> >
> > Great idea.
> >
> >>
> >> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> >> ---
> >>  fs/btrfs/ctree.h   |  2 +-
> >>  fs/btrfs/discard.c | 14 +++++++-------
> >>  2 files changed, 8 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> >> index aac3d6f4e35b..d43a82dcdfc0 100644
> >> --- a/fs/btrfs/ctree.h
> >> +++ b/fs/btrfs/ctree.h
> >> @@ -472,7 +472,7 @@ struct btrfs_discard_ctl {
> >>         atomic_t discardable_extents;
> >>         atomic64_t discardable_bytes;
> >>         u64 max_discard_size;
> >> -       unsigned long delay;
> >> +       u64 delay_ms;
> >
> > Thanks for converting this from the ambiguous unsigned long to the
> > more specific u64.
> >
> >>         u32 iops_limit;
> >>         u32 kbps_limit;
> >>         u64 discard_extent_bytes;
> >> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> >> index 76796a90e88d..b6c68e5711f0 100644
> >> --- a/fs/btrfs/discard.c
> >> +++ b/fs/btrfs/discard.c
> >> @@ -355,7 +355,7 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
> >>
> >>         block_group = find_next_block_group(discard_ctl, now);
> >>         if (block_group) {
> >> -               unsigned long delay = discard_ctl->delay;
> >> +               u64 delay = discard_ctl->delay_ms * NSEC_PER_MSEC;
> >
> > I worry about a potential performance impact with this, but it should be
> > minimal at most.
>
> That's nothing, nsecs_to_jiffies() in the end is heavier, but this is not
> in a hot path and by all means it's heavily amortised by actual discarding.

Alright, sounds good.

>
> >
> >>                 u32 kbps_limit = READ_ONCE(discard_ctl->kbps_limit);
> >>
> >>                 /*
> >> @@ -366,9 +366,9 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
> >>                 if (kbps_limit && discard_ctl->prev_discard) {
> >>                         u64 bps_limit = ((u64)kbps_limit) * SZ_1K;
> >>                         u64 bps_delay = div64_u64(discard_ctl->prev_discard *
> >> -                                                 MSEC_PER_SEC, bps_limit);
> >> +                                                 NSEC_PER_SEC, bps_limit);
> >>
> >> -                       delay = max(delay, msecs_to_jiffies(bps_delay));
> >> +                       delay = max(delay, bps_delay);
> >
> > Great that we got this down to just passing max() a value. Same thing on
> > the instance below.
> >
> >>                 }
> >>
> >>                 /*
> >> @@ -378,11 +378,11 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
> >>                 if (now < block_group->discard_eligible_time) {
> >>                         u64 bg_timeout = block_group->discard_eligible_time - now;
> >>
> >> -                       delay = max(delay, nsecs_to_jiffies(bg_timeout));
> >> +                       delay = max(delay, bg_timeout);
> >>                 }
> >>
> >>                 mod_delayed_work(discard_ctl->discard_workers,
> >> -                                &discard_ctl->work, delay);
> >> +                                &discard_ctl->work, nsecs_to_jiffies(delay));
> >>         }
> >>  out:
> >>         spin_unlock(&discard_ctl->lock);
> >> @@ -555,7 +555,7 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
> >>
> >>         delay = clamp(delay, BTRFS_DISCARD_MIN_DELAY_MSEC,
> >>                       BTRFS_DISCARD_MAX_DELAY_MSEC);
> >> -       discard_ctl->delay = msecs_to_jiffies(delay);
> >> +       discard_ctl->delay_ms = delay;
> >>
> >>         spin_unlock(&discard_ctl->lock);
> >>  }
> >> @@ -687,7 +687,7 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
> >>         atomic_set(&discard_ctl->discardable_extents, 0);
> >>         atomic64_set(&discard_ctl->discardable_bytes, 0);
> >>         discard_ctl->max_discard_size = BTRFS_ASYNC_DISCARD_DEFAULT_MAX_SIZE;
> >> -       discard_ctl->delay = BTRFS_DISCARD_MAX_DELAY_MSEC;
> >> +       discard_ctl->delay_ms = BTRFS_DISCARD_MAX_DELAY_MSEC;
> >>         discard_ctl->iops_limit = BTRFS_DISCARD_MAX_IOPS;
> >>         discard_ctl->kbps_limit = 0;
> >>         discard_ctl->discard_extent_bytes = 0;
> >> --
> >> 2.24.0
> >>
> >
> > Looks all fine to me.
>
>
> --
> Pavel Begunkov

In this case, I see nothing more to consider with this.

Best regards,
Amy Parker
(they/them)
