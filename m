Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 092A7BD7FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 07:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfIYFzW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 01:55:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40862 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729231AbfIYFzW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 01:55:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id b24so2913354wmj.5
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 22:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EOXRSrHJANALyHp80lf0LJsVhPrkIlc0AAKn6PESh3U=;
        b=sA9MLWIKt+M/Q9fqPukeyGZ3TX5LRTsCFRJF2YC36Z7PQKCgGI2/3i2CeLXGAIMuQW
         SBee7fIlpNwAIu8F2wMiDmZPBQgK1sRp5KAR8kwJ2mWtCAhyEneqicbU8CJIYXho5r3g
         BnJceIqoBHjjem1Ozm7NGZgUYgc7PQDcPDG0jGDcq6LC34TlYoWvbxACXENoCo5wjYnC
         Cerdsb3v6giwHLyrxsr5drqH0+U10UhF1hzkcVSgiu9+FcJEMm8TNjSOU30m0vWyaqFJ
         V/8UQkLxvogMaS6rOcPrQmRR4HYwuA2RMwk1TwXSJQJgFDWyOsyLnDOIhqee1icOJ29H
         +VoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOXRSrHJANALyHp80lf0LJsVhPrkIlc0AAKn6PESh3U=;
        b=QCfqLGgWiWAmqrXqriRFHgQx7E7Kh69lfvyeoiHF8kKuVf8H0e2ymcwCncF8/MBted
         LBxlr2Dfl76QQWbwGHILaXfM0Bcw/tumgKlUryReh5Oe7+TnlnDiw0rRNBgAyXwiGTjl
         TByTVxCjf3YdpDs0k5OxHIB6ZHZGIq+1d948fEYHgRdJ+iEIeGyPaKbHHxHa3uLCkcXF
         gi83M7NNpEL/gI2UL49O1wntbl41S1gRhIqj8/F5zrCG21zbfa2CRk0ngq7EE4o19NWG
         s0aSIsM6CbjrpOsRjRE4WYvJ9FqxilBPqiHBsvf/Cywn41+IxzmmBuJhKGnkn8hFtBnv
         C0Yw==
X-Gm-Message-State: APjAAAUYLT9021FcGzUCl3lGek1N4R92MTt9lAldBAyGTMK6LPGbAbZH
        hqj6RKg57yrAqu9OCahZmh2JtrhHabfGvLRgAmzckw==
X-Google-Smtp-Source: APXvYqxuuZpkmvV6VTWNHn2l0DX0xYm5F0+eh6ccmEzFjBWgVZZuegcJN77FYOpQUfNfYkajk8+5xyaYwFhjb4adRTE=
X-Received: by 2002:a7b:ce08:: with SMTP id m8mr5118175wmc.106.1569390919943;
 Tue, 24 Sep 2019 22:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <CADyTPEwDifK+YA6-kh6F8Wpf9C0+acQjkxGBJhf1ATTpZbMSYg@mail.gmail.com>
 <CAJCQCtQM_Pn4SubsJw9t0TjF8WNoqguxVf--UYH6K82Ch8Dm9Q@mail.gmail.com> <CADyTPEw=g7y+DroBt+CO-=8T3=8kO5Muj6Ts3LrkwDtKx2=zcQ@mail.gmail.com>
In-Reply-To: <CADyTPEw=g7y+DroBt+CO-=8T3=8kO5Muj6Ts3LrkwDtKx2=zcQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 24 Sep 2019 23:55:08 -0600
Message-ID: <CAJCQCtRGm4vD3a6xqa8mihutYgFxfYOJDtA31KD-Ctu5Hi+kKA@mail.gmail.com>
Subject: Re: Btrfs filesystem trashed after OOM scenario
To:     Nick Bowler <nbowler@draconx.ca>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 24, 2019 at 10:25 PM Nick Bowler <nbowler@draconx.ca> wrote:
>
> On Tue, Sep 24, 2019, 18:34 Chris Murphy, <lists@colorremedies.com> wrote:
> > On Tue, Sep 24, 2019 at 4:04 PM Nick Bowler <nbowler@draconx.ca> wrote:
> > > - Running Linux 5.2.14, I pushed this system to OOM; the oom killer
> > > ran and killed some userspace tasks.  At this point many of the
> > > remaining tasks were stuck in uninterruptible sleeps.  Not really
> > > worried, I turned the machine off and on again to just get everything
> > > back to normal.  But I guess now that everything had gone horribly
> > > wrong already at this point...
> >
> > Yeah the kernel oomkiller is pretty much only about kernel
> > preservation, not user space preservation.
>
> Indeed I am not bothered at all by needing to turn it off and on again
> in this situation.  But filesystems being completely trashed is
> another matter...

Yep I agree. Maybe Filipe will chime in whether you hit this or if
there's some other issue.

> > So if you're willing to blow shit up again, you can try to reproduce
> > with one of those.
>
> Well I could try but it sounds like this might be hard to reproduce...

If you're using 5.2.15+ you won't hit the fixed bug. But if there's
some other cause you might still hit that and it's worth knowing about
under controlled test conditions than some unexpected time.

> > I was also doing oomkiller blow shit up tests a few weeks ago with
> > these same problem kernels and never hit this bug, or any others. I
> > also had to do a LOT of force power offs because the system just
> > became totally wedged in and I had no way of estimating how long it
> > would be for recovery so after 30 minutes I hit the power button. Many
> > times. Zero corruptions. That's with a single Samsung 840 EVO in a
> > laptop relegated to such testing.
>
> Just a thought... the system was alive but I was able to briefly
> inspect the situation and notice that tasks were blocked and
> unkillable... until my shell hung too and then I was hosed.  But I
> didn't hit the power button but rather rebooted with sysrq+e, sysrq+u,
> sysrq+b.  Not sure if that makes a difference.

Dunno.

Basically what I've discovered is you want to avoid depending on
oomkiller, it's just not suitable for maintaining user space
interactivity at all. I've used this:
https://github.com/rfjakob/earlyoom

And that monitors both swap and memory use, and will trigger oom much
sooner than the kernel's oomkiller. The system responsiveness takes a
hit, so I can't call it a good user experience. But the recovery is
faster and with almost no testing off hand it's consistently killing
the largest and most offending program, where oomkiller might
sometimes kill some small unrelated daemon and that will free up just
enough memory that the kernel will be happy for a long time while user
space is totally blocked.


>
> > Might be a different bug. Not sure. But also, this is with
> >
> > > [  347.551595] CPU: 3 PID: 1143 Comm: mount Not tainted 4.19.34-1-lts #1
> >
> > So I don't know how an older kernel will report on the problem caused
> > by the 5.2 bug.
>
> This is the kernel from systemrescuecd.  I can try taking a disk image
> and mounting on another machine with a newer linux version.

Try btrfs check --readonly and report back the results. I suggest
btrfs-progs 5.0 or higher, 5.2.2 if you can muster it. That might help
clarify if you hit the 5.2 regression bug. But btrfs check can't fix
it if that's what you hit. So it's 'btrfs restore' to scrape out what
you can, and then create a new file system.


-- 
Chris Murphy
