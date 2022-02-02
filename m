Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170464A6916
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 01:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241315AbiBBAKU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 19:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiBBAKU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Feb 2022 19:10:20 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C726C061714
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Feb 2022 16:10:20 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id g15-20020a17090a67cf00b001b7d5b6bedaso4292099pjm.4
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Feb 2022 16:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/niTeFwsUyoyMCimlVia0HfXLgrgH3hY1nscwHChCNY=;
        b=F50sXk79EbIrNUNSroShwUwYTYQHj6IWre0zF1fsvU78QKmHIOqcggyliqQgkawqwZ
         uYKN4bSzLMUOTENdjXfXA/tDl8lvy45I5G7PjbyBPDCWiiWid6XgyCKiNRlgiMjfZ3o8
         tc4i2PnJ4Teqho5UvZ+6zcmAnujz4qZJ4QPPpcjMEb4ogqebr7D4wKUDqCg4tXqUG9q4
         eO5po21ExA+bGsLUjqywz1XjcvDxwK4RDh3oeVzqDasDLloJ1Y+YukoNF+1WioPKMwJI
         k03kjiekLjR2bSv7Ju8vLBDzWEMx+bZG6WgO5zOwqyCHZ6wPNyUWojYHiz4oQjPuFFJ2
         RksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/niTeFwsUyoyMCimlVia0HfXLgrgH3hY1nscwHChCNY=;
        b=nQEX61a25GMxCuPkcv3PRk18Cokc8Mcnl4gheIM1RvvHUaTT4u082V2ftA0nMy/OMp
         xOJZNqPNFVNrr+sTjI0+46Uzqm2iAFKsMDV4VOMvVu6N51h5pqCAH3gARU7TaunW8Wfn
         2T4PalGcBgLqTF6DsqAmprbu6P2YPsXxB5EdeFdE3DfF4xbdtygFe7kK4U6SaIbp64Xb
         POt/skCgT84N9caNbdIbr3VyVlQ5N0xYIQAIdvpBypenX7xGZseSwTWEB8GSfVMYqp+n
         2xuuyQTTWyv82L+GvNuOzQp2sHoNCjzYZANK+wFdJ/429Z6QXYDN5egi1IT18y5D9unp
         LKBA==
X-Gm-Message-State: AOAM530TVn9gwW9FPmzrzXH1UxjnP76YxYnwMu6CMWQaW5r+JzZhuLeH
        REvc4FYeDyRDGB/CtS15dwPG8G0RAloESthTtxUO944X
X-Google-Smtp-Source: ABdhPJyXcCbZ6zYxKr9yEippuqxrtdRchqD1gEql0ZZScpIReVmqv2OixDXAzcFOTNc81qfHDyp8NFPrL9G+3x0novk=
X-Received: by 2002:a17:903:32d2:: with SMTP id i18mr28466436plr.23.1643760619832;
 Tue, 01 Feb 2022 16:10:19 -0800 (PST)
MIME-Version: 1.0
References: <20220130010956.1459147-1-rosenp@gmail.com> <20220131143930.GL14046@twin.jikos.cz>
 <CAKxU2N8jeMT_4kJrwLFng0WLYBo=kfYmrz0Hu1NpdWR-fOzVnA@mail.gmail.com>
 <a05a9bcf-d2a2-99a9-0e18-7313e74e29dc@gmx.com> <20220201134402.GM14046@twin.jikos.cz>
In-Reply-To: <20220201134402.GM14046@twin.jikos.cz>
From:   Rosen Penev <rosenp@gmail.com>
Date:   Tue, 1 Feb 2022 16:11:25 -0800
Message-ID: <CAKxU2N8YVZOrPTEi0tL2dAKRgpLuSs+F8rqqvwHcw1Bbzurh5w@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: fix 64-bit mips and powerpc types
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Rosen Penev <rosenp@gmail.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 1, 2022 at 5:44 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Feb 01, 2022 at 08:58:55PM +0800, Qu Wenruo wrote:
> >
> >
> > On 2022/2/1 04:46, Rosen Penev wrote:
> > > On Mon, Jan 31, 2022 at 6:40 AM David Sterba <dsterba@suse.cz> wrote:
> > >>
> > >> On Sat, Jan 29, 2022 at 05:09:56PM -0800, Rosen Penev wrote:
> > >>> The kernel uses unsigned long specifically for ppc64 and mips64. This
> > >>> fixes that.
> > >>
> > >> What do you mean? Uses unsigned long for what?
> > > kernel's u64 is normally unsigned long long, but not for ppc64 and mips64.
> > >>
> > >>> Removed asm/types.h include as it will get included properly later.
> > >>>
> > >>> Fixes -Wformat warnings.
> > >>>
> > >>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > >>> ---
> > >>>   cmds/receive-dump.c | 1 -
> > >>>   kerncompat.h        | 4 ++++
> > >>>   2 files changed, 4 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/cmds/receive-dump.c b/cmds/receive-dump.c
> > >>> index 47a0a30e..00ad4fd1 100644
> > >>> --- a/cmds/receive-dump.c
> > >>> +++ b/cmds/receive-dump.c
> > >>> @@ -31,7 +31,6 @@
> > >>>   #include <stdlib.h>
> > >>>   #include <time.h>
> > >>>   #include <ctype.h>
> > >>> -#include <asm/types.h>
> > >>>   #include <uuid/uuid.h>
> > >>>   #include "common/utils.h"
> > >>>   #include "cmds/commands.h"
> > >>> diff --git a/kerncompat.h b/kerncompat.h
> > >>> index 6ca1526e..4b36b45a 100644
> > >>> --- a/kerncompat.h
> > >>> +++ b/kerncompat.h
> > >>> @@ -19,6 +19,10 @@
> > >>>   #ifndef __KERNCOMPAT_H__
> > >>>   #define __KERNCOMPAT_H__
> > >>>
> > >>> +#ifndef __SANE_USERSPACE_TYPES__
> > >>> +#define __SANE_USERSPACE_TYPES__     /* For PPC64, to get LL64 types */
> > >>> +#endif
> > >>
> > >> Is there a cleaner way instead of defining magic macros?
> > > no. https://github.com/torvalds/linux/blob/master/arch/powerpc/include/uapi/asm/types.h#L18
> >
> > Really?
> >
> > I have the same issue in btrfs-fuse, but it can be easily solved without
> > using the magic macro.
> >
> > See this issue:
> >
> > https://github.com/adam900710/btrfs-fuse/issues/2
> >
> > including <linux/types.h> seems to solve it for btrfs-fuse.
>
> Ok, so it's just the asm/types.h, once it's deleted it should all work
> with linux/types.h (included via kerncompat.h).
Qu is referring to a different issue. I am referring to bad printf formats.
>
> Rosen, could you please verify that this is sufficient (without the
> extra macro)?
It is not.

Also note that this is specific to ppc64 and mips64. and alpha
(whatever that is).

a git grep of the linux tree for that macro shows that it's used in tools/
