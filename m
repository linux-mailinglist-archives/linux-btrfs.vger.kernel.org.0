Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3E04A6946
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 01:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243400AbiBBAem (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 19:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243361AbiBBAem (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Feb 2022 19:34:42 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E8DC061714
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Feb 2022 16:34:42 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id oa14-20020a17090b1bce00b001b61aed4a03so4331018pjb.5
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Feb 2022 16:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zFWjCBYgngrdpuB/gsmPV1h14Jx19QHAJN09+wsCqbY=;
        b=GF6L836GDStHLf4/7b+2pC7cNbHTU7cCbstR9IGB/IX4tN4HImqdpCME35OP7q22US
         G8FId59yDtASWFCpRPFmTxHpKwFmL/eKbR1GUfu4giTRyfQj2jtRynqFLyRUul7d7s7g
         VQaWfjPs8xUYeYuTfgwdrEsB02ag3KJyn1KfnIOfN7na+FpZCpgqOb6fW2j4/oo7IFGn
         4/HVI2WRvUffM54kGan97W6+YEJaQIk/UqRIne+ala8a3LAVciiNbb+Hf94hIjhAx/mv
         4nBsa3RT9a9WamvswgxN87E5VLPjoRJ72RzdWOkALccC28zyKg873C1i2oDHMaeD3e63
         8Y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zFWjCBYgngrdpuB/gsmPV1h14Jx19QHAJN09+wsCqbY=;
        b=0ySU1mO9K/DmYTmIaBMLcAuAur4fwDdvr+Pgg0WqVjqi24jVvpxyG1RHCDokCgNvI6
         JIqzLjFxaAHPlPRWYL9AxM2orrgV0U0EHevDbkgM+yGeEM+4NGF0QoidIfMloBOdIPsi
         ggA7cXhv29BOF6+z374e2F1RZyuppbk4z32V4RztjLupAqbW51x/RW+QH9iBgqK5gmm4
         lg3BCErbKjtEXowSLMaxKJl61sZen3MjOo4vDc7VjEbIYYl9rZOsegw4t7At9UVjFB1H
         Lh3AB1+aMgCywfZbGn3HGv6z6mmWmczqENJv15c0jqcZe19e/8j07tua8kpkDmtOontl
         EaCA==
X-Gm-Message-State: AOAM531c/+MiLRRxgqOHF9XfC+Zl8S/UC8Rk4IBj1RCYWxUHvpUyUqJX
        6RY9fkfUrV/d0DVHxpoBoume6GT9V71v7QbpUF32OKq2
X-Google-Smtp-Source: ABdhPJwHbm795GOxJRxF7gs1Yg5qEnqUbnL7Bk0pV3xMuJ3WgmPoQY+OqsZ6LWfbNWlLGAHvfuBH5+/m+pk7lywCD2w=
X-Received: by 2002:a17:903:32d2:: with SMTP id i18mr28544896plr.23.1643762081753;
 Tue, 01 Feb 2022 16:34:41 -0800 (PST)
MIME-Version: 1.0
References: <20220130010956.1459147-1-rosenp@gmail.com> <20220131143930.GL14046@twin.jikos.cz>
 <CAKxU2N8jeMT_4kJrwLFng0WLYBo=kfYmrz0Hu1NpdWR-fOzVnA@mail.gmail.com>
 <a05a9bcf-d2a2-99a9-0e18-7313e74e29dc@gmx.com> <20220201134402.GM14046@twin.jikos.cz>
 <CAKxU2N8YVZOrPTEi0tL2dAKRgpLuSs+F8rqqvwHcw1Bbzurh5w@mail.gmail.com> <2d9decd4-7442-efb2-3bd5-df00705f02ff@gmx.com>
In-Reply-To: <2d9decd4-7442-efb2-3bd5-df00705f02ff@gmx.com>
From:   Rosen Penev <rosenp@gmail.com>
Date:   Tue, 1 Feb 2022 16:35:46 -0800
Message-ID: <CAKxU2N-93WgUcv_hNZPXcfhWh1GmtNmLdA92J7ZoFzK5Lx_7aw@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: fix 64-bit mips and powerpc types
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 1, 2022 at 4:31 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/2/2 08:11, Rosen Penev wrote:
> > On Tue, Feb 1, 2022 at 5:44 AM David Sterba <dsterba@suse.cz> wrote:
> >>
> >> On Tue, Feb 01, 2022 at 08:58:55PM +0800, Qu Wenruo wrote:
> >>>
> >>>
> >>> On 2022/2/1 04:46, Rosen Penev wrote:
> >>>> On Mon, Jan 31, 2022 at 6:40 AM David Sterba <dsterba@suse.cz> wrote:
> >>>>>
> >>>>> On Sat, Jan 29, 2022 at 05:09:56PM -0800, Rosen Penev wrote:
> >>>>>> The kernel uses unsigned long specifically for ppc64 and mips64. This
> >>>>>> fixes that.
> >>>>>
> >>>>> What do you mean? Uses unsigned long for what?
> >>>> kernel's u64 is normally unsigned long long, but not for ppc64 and mips64.
> >>>>>
> >>>>>> Removed asm/types.h include as it will get included properly later.
> >>>>>>
> >>>>>> Fixes -Wformat warnings.
> >>>>>>
> >>>>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >>>>>> ---
> >>>>>>    cmds/receive-dump.c | 1 -
> >>>>>>    kerncompat.h        | 4 ++++
> >>>>>>    2 files changed, 4 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/cmds/receive-dump.c b/cmds/receive-dump.c
> >>>>>> index 47a0a30e..00ad4fd1 100644
> >>>>>> --- a/cmds/receive-dump.c
> >>>>>> +++ b/cmds/receive-dump.c
> >>>>>> @@ -31,7 +31,6 @@
> >>>>>>    #include <stdlib.h>
> >>>>>>    #include <time.h>
> >>>>>>    #include <ctype.h>
> >>>>>> -#include <asm/types.h>
> >>>>>>    #include <uuid/uuid.h>
> >>>>>>    #include "common/utils.h"
> >>>>>>    #include "cmds/commands.h"
> >>>>>> diff --git a/kerncompat.h b/kerncompat.h
> >>>>>> index 6ca1526e..4b36b45a 100644
> >>>>>> --- a/kerncompat.h
> >>>>>> +++ b/kerncompat.h
> >>>>>> @@ -19,6 +19,10 @@
> >>>>>>    #ifndef __KERNCOMPAT_H__
> >>>>>>    #define __KERNCOMPAT_H__
> >>>>>>
> >>>>>> +#ifndef __SANE_USERSPACE_TYPES__
> >>>>>> +#define __SANE_USERSPACE_TYPES__     /* For PPC64, to get LL64 types */
> >>>>>> +#endif
> >>>>>
> >>>>> Is there a cleaner way instead of defining magic macros?
> >>>> no. https://github.com/torvalds/linux/blob/master/arch/powerpc/include/uapi/asm/types.h#L18
> >>>
> >>> Really?
> >>>
> >>> I have the same issue in btrfs-fuse, but it can be easily solved without
> >>> using the magic macro.
> >>>
> >>> See this issue:
> >>>
> >>> https://github.com/adam900710/btrfs-fuse/issues/2
> >>>
> >>> including <linux/types.h> seems to solve it for btrfs-fuse.
> >>
> >> Ok, so it's just the asm/types.h, once it's deleted it should all work
> >> with linux/types.h (included via kerncompat.h).
> > Qu is referring to a different issue. I am referring to bad printf formats.
>
> Weird, as the report includes format '%llu' warning for printf formats.
>
> >>
> >> Rosen, could you please verify that this is sufficient (without the
> >> extra macro)?
> > It is not.
> >
> > Also note that this is specific to ppc64 and mips64. and alpha
> > (whatever that is).
> >
> > a git grep of the linux tree for that macro shows that it's used in tools/
>
> OK, after checking the latest build log from Fedora36 ppc64le, it indeed
> still shows the warning:
>
> https://kojipkgs.fedoraproject.org//packages/btrfs-fuse/0/6.20211113git8635fbc.fc36/data/logs/ppc64le/build.log
>
>
> Although from what I see, that magic is more common set for packaging,
> not directly into the source code:
OTOH tools/perf and some tests define this macro.
>
> https://chromium.googlesource.com/chromium/src.git/+/7d38bae3ef691d5091b6d4d7973a9b4d2cd85eb2/build/config/compiler/BUILD.gn#988
>
> Where chromium choose to add that magic only for mips64
>
> Or this:
>
> https://github.com/LLNL/lustre/blob/2.12.7-llnl/lustre.spec.in#L343
>
> Which is only defined during packaging, not in the source code.
>
>
> We can put this into our Makefile, and only for affected archtectures then.
>
> Thanks,
> Qu
