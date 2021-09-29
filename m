Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA81041BC12
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 03:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243544AbhI2BMh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 21:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243507AbhI2BMg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 21:12:36 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F9AC06161C
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 18:10:56 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id h2so1604625ybi.13
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 18:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2nrqVeki+r3XoDEKLbmv8X0EUa9yQFWa1FtnD+HqqM=;
        b=UzNGtbBqlgqTTmhUYhniCgUrnK0gWB41V3XK56HSgmM0dUWiRE4KB3ysL6EdAsn+1N
         q+o8u8fJIch3f4TkItzgK6gtkiktYfnDn5vKbJpmChVAjoc0sU+RD8YIuMTzj5RF53L8
         LngVk4iZRzH4yo6ZWNHC4vpB2p/I0Fk5pQJTbuUOX8uiAdKcZlCUaE577jmQ4Ay7NWD6
         1tB4zhhErMZ1n5f9uqiymPQt7WqRQ1BStvLp+vCQ6whsauZHMhKeDsNzWTSPwjt7dal+
         4Qj/c2bawz1emthACHtLhbiGl/5GUhOh9arC9ldsR7/yEUrCTaldSVVVJM73ubERLOmc
         r0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2nrqVeki+r3XoDEKLbmv8X0EUa9yQFWa1FtnD+HqqM=;
        b=vXOBE05I9vqxVgJyJyXYnrA+nx6jAA920wPIHDGrf6Xa92qCk+nlPpPwWdayC5D/Rz
         SJpUhfqZ6ZDtVYJMNqVq57C5Fb34X4dK/pf0bbRvXJzDtaVQsLhmqdDgayjnnkqom1cd
         OkubZVK55Xb1M10Rl8Oc+bx/1+Yad8nl32KDvPhuYWzof7UTttljPteHRDIWxSsAxi5l
         Jk8uiGLz5f0jemOKIORfk25RUCZNicNbnPIdmXACSpFstVcSoYdDkLddONWP1AU83Nrg
         mAJj/RXfNsJ0iUHhaemI2oBsKVCJfKPw6tDtewYHqeTwpM8gbCZ75jU+U4jMPBb/6bMf
         c9HQ==
X-Gm-Message-State: AOAM533wSreH2/kJLHD9cNHUkSZnmoPyFREDuXciZTLx6ERfWlYaSvis
        Q3PPBi5Wd3hbI491jyLgJRe0r2vEIXr+4a+B2X8K9iUU6NoaNw==
X-Google-Smtp-Source: ABdhPJx0OA8VYXmMVx5SpJ65bioUjg4tEx7bv6zlhC7qeCPGK5FUhyEzY2oFr4L/ineljOT4dElUWT8O+mQQIN3vKAg=
X-Received: by 2002:a25:db91:: with SMTP id g139mr9633642ybf.391.1632877855870;
 Tue, 28 Sep 2021 18:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLfK3VL5P7uAPAqvaRHv5gcoT5hdVqkSR5Nz+hTcb=FRmj9ZQ@mail.gmail.com>
 <CAJCQCtT0CvQ1Rmwpq3_nu1+G5wVx7+5ivDxLMTRG+=Vk0Fh0-g@mail.gmail.com> <CAOLfK3UEeDT0N+jCd_M=JsW2V8N_t_XQzHBk4OQmqHD3_o6WdA@mail.gmail.com>
In-Reply-To: <CAOLfK3UEeDT0N+jCd_M=JsW2V8N_t_XQzHBk4OQmqHD3_o6WdA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 28 Sep 2021 21:10:40 -0400
Message-ID: <CAJCQCtTEeCCoNykJc5+v558_3pMuFNc0crFe_3u_zhGyCW=nOg@mail.gmail.com>
Subject: Re: unable to mount disk?
To:     Matt Zagrabelny <mzagrabe@d.umn.edu>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 28, 2021 at 3:23 PM Matt Zagrabelny <mzagrabe@d.umn.edu> wrote:
>
> On Tue, Sep 28, 2021 at 1:59 PM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > On Tue, Sep 28, 2021 at 2:53 PM Matt Zagrabelny <mzagrabe@d.umn.edu> wrote:
> > >
> > > Greetings btrfs folks,
> > >
> > > I am attempting to mount a filesystem on a (likely) failing disk:
> > >
> > > $ mount /var/local/media
> > > mount: /var/local/media: wrong fs type, bad option, bad superblock on
> > > /dev/sdb, missing codepage or helper program, or other error.
> > >
> > > excerpt from dmesg:
> > >
> > > [  352.642893] BTRFS info (device sdb): disk space caching is enabled
> > > [  352.642897] BTRFS info (device sdb): has skinny extents
> > > [  352.645562] BTRFS error (device sdb): devid 2 uuid
> > > bf09cc8f-44d6-412e-bc42-214ff122584a is missing
> > > [  352.645570] BTRFS error (device sdb): failed to read the system array: -2
> > > [  352.646770] BTRFS error (device sdb): open_ctree failed
> > >
> > > Is there anything I can do to attempt to recover this hardware issue?
> >
> >
> > This is a 2+ device Btrfs file system? And one of the devices, devid2,
> > is missing. So you need to figure out why. If the drive has in fact
> > failed, rather than just missing power/data connection, you can mount
> > degraded using the 'degraded' mount option. Just be advised that there
> > are potentially some consequences to operating under degraded mode,
> > depending on the specific configuration.
>
> Thanks for the hints, Chris. Appreciated.
>
> What sort of potential consequences are we talking about, if you could
> elaborate?
>
> Cheers,
>
> -m


If it's a 2 disk raid1, and one device dies, and you mount -o degraded
- it's no longer possible for btrfs to create raid1 block groups,
because that profile requires creating a mirrored pair of chunks which
can't happen because there's only one device. It's possible some data
will write to existing raid1 chunks, but other data can cause new
single chunks to be created. The data in these block groups won't
automatically be replicated when you do 'btrfs replace' to replace the
failed device, or if you fix the device problem and it rejoins the
working drive, a scrub won't catch up the stale drive either. You will
have to do 'btrfs balance start -dconvert=raid1,soft
-mconvert=raid1,soft" to make sure the single profile block groups are
converted to raid1 block groups.


-- 
Chris Murphy
