Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1BAABE6E0
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 23:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393593AbfIYVGD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 17:06:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54675 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393586AbfIYVF5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 17:05:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so215152wmp.4
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 14:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BvfaqJZ5TR9Z8/F+dVUhZbr56m9NAYWlXETe6kuQjp8=;
        b=VBYelmwJS9BdmexXYMHo/brUOiFJKULLCc0WSgsAROgnJbhPljcj7dR2lF+m9e9wo/
         hBxzR51I0oq8+YoHtSTcyLrbH+FvzdpXoSkdbMMVHN9fJ7ac07wx6xZpR4Wqgf1QvxHf
         n7uOMuhUdJdPzfZdLPX2yx0LfsPgtfLx1h+WlvBr45336rblmLUNAwnSlCkyAFhYKED8
         ZYgKPfKdKQGMyckjyR+8be718mF+EkLENBsYaMrbbnkkVjsSNuBDO5z6GaGc+9H5GcY8
         WhlwI5IkkvPV9lDX6j+yawK17Ohk1DnhR9ng5m06LEJ5sEgRHtd0mwTRl7wqHV+02usm
         otIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BvfaqJZ5TR9Z8/F+dVUhZbr56m9NAYWlXETe6kuQjp8=;
        b=Dvvrn2n+KMhzARygflU2pGJ1cUkLAIk2jygKLrQDGsktMOzS4mcWvmDzPqbS03Sjtq
         GkF9zV0c0Fb+5q/btYi4Fz46kxh+DpiBIowf4ViDsBPS8h70+gOjy1KxKmIGEnTl9Cwq
         jDGbLTmQInMLNxk5yInYLRwTy1tZ63gvuSv6RAgzITXpXh8P9cB0u1+H4WIzWRQO1lCx
         /4sR6tL4TuJ5qKe7ZshUp03P0tc2gwkYFqFe+3jWcacjKh3KXAzkYnYn5m7t4W44e/R6
         2SxIs2liaoviz4E6xQodtFzmhJauAoJPqxPo6nBiVkpic1Jvs9as/5vOGK49lOROyob+
         rh8w==
X-Gm-Message-State: APjAAAWb+qyqYgRyMXZxuynUhvjOWEW/lVTtNC6cp1zQzj5/ujdaQgnr
        HB6dx+iZ3DGjCXQLQv36FF6xQCYmxmDQ4p3mRebnnSjcpuo=
X-Google-Smtp-Source: APXvYqzvNw6NN3nkATP/PudtlL7TUqzP2fRc7FA4PcFsp+avrfHGNagE8tX7+ug0tNCv6x3vi/kRuQn9TezgxmJsJow=
X-Received: by 2002:a1c:4102:: with SMTP id o2mr163720wma.66.1569445555597;
 Wed, 25 Sep 2019 14:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190925144959.p4xyyhn2d2sajxjj@matt-laptop-p01>
 <CAJCQCtQwHRVs+XwnnUcktGcaRabZGG-UxS4o=g9y_MCiD4yG9Q@mail.gmail.com> <20190925193434.ieyj4oo6vkxmjtnw@matt-laptop-p01>
In-Reply-To: <20190925193434.ieyj4oo6vkxmjtnw@matt-laptop-p01>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 25 Sep 2019 15:05:44 -0600
Message-ID: <CAJCQCtQKypCbxksq5+XCwRy8enPkfZBaOgzS0SN2un+A1GELtA@mail.gmail.com>
Subject: Re: errors found in extent allocation tree or chunk allocation after
 power failure
To:     "Pallissard, Matthew" <matt@pallissard.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 25, 2019 at 1:34 PM Pallissard, Matthew <matt@pallissard.net> wrote:
>
>
> Chris,
>
> Thank you for your reply.  Responses in-line.
>
> On 2019-09-25T13:08:34, Chris Murphy wrote:
> > On Wed, Sep 25, 2019 at 8:50 AM Pallissard, Matthew <matt@pallissard.net> wrote:
> > >
> > > Version:
> > > Kernel: 5.2.2-arch1-1-ARCH #1 SMP PREEMPT Sun Jul 21 19:18:34 UTC 2019 x86_64 GNU/Linux
> >
> > You need to upgrade to arch kernel 5.2.14 or newer (they backported the fix first appearing in stable 5.2.15). Or you need to downgrade to 5.1 series.
> > https://lore.kernel.org/linux-btrfs/20190911145542.1125-1-fdmanana@kernel.org/T/#u
> >
> > That's a nasty bug. I don't offhand see evidence that you've hit this bug. But I'm not certain. So first thing should be to use a different kernel.
>
> Interesting, I'll go ahead with a kernel upgrade as that easy enough.
>
> However, that looks like it's related to a stacktrace regarding a hung process.  Which is not the original problem I had.
>
> Based on the output in my previous email, I've been working under the assumption that there is a problem on-disk.  Is that not correct?

That bug does cause filesystem corruption that is not repairable.
Whether you have that problem or a different problem, I'm not sure.
But it's best to avoid combining problems.

The file system mounts rw now? Or still only mounts ro?

I think most of the errors reported by btrfs check, if they still
exist after doing a scrub, should be repaired by 'btrfs check
--repair' but I don't advise that until later. I'm not a developer,
maybe Qu can offer some advise on those errors.


> > Next, anytime there is a crash or powerfailur with Btrfs raid56, you need to do a complete scrub of the volume. Obviously will take time but that's what needs to be done first.
>
> I'm using raid 10, not 5 or 6.

Same advice, but it's not as important to raid10 because it doesn't
have the write hole problem.


> > OK actually, before the scrub you need to confirm that each drive's SCT ERC time is *less* than the kernel's SCSI command timer. e.g.
>
> I gather that I should probably do this before any scrub, be it raid 5, 6, or 10.  But, Is a scrub the operation I should attempt on this raid 10 array to repair the specific errors mentioned in my previous email?
>

Definitely deal with the timing issue first. If by chance there are
bad sectors on any of the drives, they must be properly reported by
the drive with a discrete read error in order for Btrfs to do a proper
fixup. If the times are mismatched, then Linux can get tired waiting,
and do a link reset on the drive before the read error happens. And
now the whole command queue is lost and the problem isn't fixed.

There are myriad errors and the advice I'm giving to scrub is a safe
first step to make sure the storage stack is sane - or at least we
know where the simpler problems are. And then move to the less simple
ones that have higher risk.  It also changed the volume the least.
Everything else, like balance and chunk recover and btrfs check
--repair - all make substantial changes to the file system and have
higher risk of making things worse.

In theory if the storage stack does exactly what Btrfs says, then at
worst you should lose some data, but the file system itself should be
consistent. And that includes power failures. The fact there's
problems reported suggests a bug somewhere - it could be Btrfs, it
could be device mapper, it could be controller or drive firmware.

--
Chris Murphy
