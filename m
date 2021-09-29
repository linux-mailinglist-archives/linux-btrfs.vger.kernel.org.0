Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D1441C2F1
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 12:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244888AbhI2Kqf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 06:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244849AbhI2Kqe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 06:46:34 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3759DC06161C
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Sep 2021 03:44:53 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id p4so1816460qki.3
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Sep 2021 03:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=7aZ360A3zXu4eVkCVAlzQ0HY3ca5ZYZQbSHkFv9pPNo=;
        b=jSpluEc/aAeG338yrwTfdURQHxnOWdMHNl7GguhpFt/VoNFJ8xlmhp5JoKUyJon1oH
         6LhFAf4xhb/P9xW35YhRHyAflVDLpnYRFBTY5wd9oFM1MpvRg+6iI8zy/pnUIn39ReiO
         +orwr1j5Y/tTpFPTUqsQ2csJAMe7gc08AxY+Ojna5bq5szdQ5zqQZYFKuVw2D30xgj8j
         /qdLCNkcFYPNZFjhFl9CettSnnKQct3ZICmArfEPR4KSpgC1e0+GMZAb5dKK6+eFxtid
         clvrRUG3SME7hsJ5fBu1Y8M8M4WeVsSSGPYuOEeJnJRica/0tMaHhzFxU0FnLen3tDZ6
         8ZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=7aZ360A3zXu4eVkCVAlzQ0HY3ca5ZYZQbSHkFv9pPNo=;
        b=hUNfAkOnmPoN2MzgCsu99mBWPV+Fx/PurT062FFtWp90Wy/6kOxk2rSI1PPo9jJk0L
         wtn4trvMHThLoO51+BhMrSJJilBCg74cLwSbtxQS9GMRjbY/WEdHYpeRfeWfGVK6AMRT
         Mafod2c8Tr2XnLjguGHE3XG4s9zPEJP0G4Lv+8XnqL2EGq3a+9WglXfCaZqMXmGbDZ3S
         laBZ/o3S2pxryYNsJtAtkVK//kVM+CDAZYYWN0bkJyGgGQFiDllbUkLdT7z5+M8uXTqQ
         UZhZLOCG9pqK1KRxp4IHBgYt6PtITBg8JfAfTp40Yifq97UM4qAmQxdhfKyFr3dx7x6y
         jYjA==
X-Gm-Message-State: AOAM530T8xwFM+aCmu3jZDLsCu6RyGhssyZddVJDrrkh4y5+b21i/ZFq
        fU14tFQqGOB/GGfV946EF/cPO8U60yQkbab61qY=
X-Google-Smtp-Source: ABdhPJz/pYA2wMQ2cZtDSs10s9Y1QljSLjyqses7llo5P1fGaslxUBwWtQi/3BwXaJyLOkoUlBVRh100R/GQ6WAMKr4=
X-Received: by 2002:a05:620a:2844:: with SMTP id h4mr4651303qkp.388.1632912292326;
 Wed, 29 Sep 2021 03:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210928235159.9440-1-wqu@suse.com> <CAL3q7H4OqEpAEWhGUH4okvOedhdK0dChYHdJkYrv-1vsAqKAow@mail.gmail.com>
 <99b58a1c-7cae-5311-1747-d51c4b5415a5@gmx.com> <CAL3q7H7doRb75LRJGbuyEJu5V+DDhaq8qytWTnYr1wQ7Z-b_yA@mail.gmail.com>
 <bec618cc-4373-9fd6-b34b-683c565772c9@suse.com>
In-Reply-To: <bec618cc-4373-9fd6-b34b-683c565772c9@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 29 Sep 2021 11:44:16 +0100
Message-ID: <CAL3q7H7VGN66iosggHjBQvLdpVRQ=QaBVtQBS=qZfCM+_Zw+5w@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs-progs: receive: fallback to buffered copy if
 clone failed
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 29, 2021 at 11:25 AM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2021/9/29 17:59, Filipe Manana wrote:
> [...]
> >>> Normally we should only exit if errno is not EINTR, and retry
> >>> (continue) on the EINTR case.
> >>
> >> For this, I'm a little concerned.
> >>
> >> EINTR means the operation is interrupted (by signal).
> >> In that case, doesn't it mean the user want to stop the receive?
> >
> > There will be plenty of opportunities to be interrupted and still be re=
sponsive.
> > But ok, you can leave it as it is.
> >
> >>
> [...]
> >>>
> >>> What if we have thousands of clone operations?
> >>> Is there any rate limited print() in progs like there is for kernel?
> >>
> >> Unfortunately we don't yet have.
> >>
> >> But the good news (that I didn't catch at time of writing) is, we now
> >> have global verbose/quite switch, so that we can easily hide those
> >> warning by default and only output such warning for verbose run.
> >
> > The problem with this is that it will possibly hide future bugs with
> > the kernel sending incorrect clone operations.
> >
> > Having this fallback-to-read-write behaviour by default would hide
> > some bugs we had in the past on the kernel side, and unless users
> > start running receive with the verbose switch, we won't know about it.
> > Even if they do run with the verbose switch, some might not notice the
> > warnings at all, and for those who notice it they might not bother to
> > report the warnings since the receive succeeded and they didn't find
> > any data corruption/loss.
> >
> > Or we might start receiving reports about send/receive doing less
> > cloning/extent sharing than before, and we won't easily know that the
> > receive side has fallen back to this read-write behaviour due to some
> > bug on kernel.
> >
> > That's why making the behaviour explicit through a new command line
> > flag would cause less surprises and make it harder to miss regressions
> > on the kernel. And add some documentation explaining on which cases
> > the flag is useful.
>
> This sounds indeed better, handling both cases well.
>
> I'll try to add a new option to receive, maybe something called
> --clone-fallback.
>
> Any advice on the option name would be very helpful.

--clone-fallback

Sounds fine to me. It's short enough and gives some clue what it's about.
It's not completely self-explanatory, but I don't have a better
suggestion, and I think any name will always require an explanation of
what it does and when it's useful in the documentation (--help, man
page).

Thanks.


>
> Thanks,
> Qu
>
> >
> > Thanks.
> >
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>> That's one reason why my proposal had in mind an optional flag to
> >>> trigger this behaviour.
> >>>
> >>> Thanks for doing it, I was planning on doing something similar soon.
> >>>
> >>>> +               ret =3D buffered_copy(clone_fd, rctx->write_fd, clon=
e_offset,
> >>>> +                                   len, offset);
> >>>>           }
> >>>>
> >>>>    out:
> >>>> --
> >>>> 2.33.0
> >>>>
> >>>
> >>>
> >
> >
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
