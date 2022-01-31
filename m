Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3C34A5073
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jan 2022 21:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343557AbiAaUq2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jan 2022 15:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379217AbiAaUpu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jan 2022 15:45:50 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E005DC06173D
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jan 2022 12:45:49 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id e16so13345825pgn.4
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jan 2022 12:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=FPJk7BRqdyL6QHj99PG5jL8BT2suMUJo0UNrZFqlvvA=;
        b=nEqZlLoKz4tfFq+lW4lkQArm/wkU7NYF4cRrBrwHA4Aipe/yLcTeA4ZHlAstAdq0Ax
         tVJiio3crIET/g26y9dpJR46yzQCZIhWRyvq1ayt/nVH7nHFLas7dzH3zLEqWBCsYj7H
         WC0++8SAI4xDxzCuVo3UiVCU1wsPgGxc9L9JCIVEG3THTlFnqCYUwXnmxyyAmygl3diA
         bEpxyoIo0PB4SV/hgvjrAlyXdzLTvuBV5FKOVfGCJj/1k1a2SBZDpDSO6jN69avpx7oq
         hMP4GXptLSs1XM/I9RxacD0h8hw4mrG2GyoMAB43q2cKiHhUrhBVUjGmZ8MRnDHAIaa1
         RPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=FPJk7BRqdyL6QHj99PG5jL8BT2suMUJo0UNrZFqlvvA=;
        b=fsmyoQ6JVuZnRWRi4+ua6pYOKyvDZIzN230mip3vy31ziPr48+v8wUjryYNZDeAlvQ
         YS9FLoEuHiqfSVHty1i66oak4IRPVOEM3bME+RCmZRguAt2E2TfDyC06Ug0RzhupIvWI
         l8A1vLjZquTw1v8qToKai1k1IVf/TqXzQlhyI9jRhOGW8RG2Mkv7pfy4JKT5F42d3D5l
         5icL3AZTcg1sRckgZ+bCipT9Kb7DEkfF4ZaEf+G1htGV1nPiyrd/jveuSOdsy/iEz5Wm
         y9FukyLi0bEuHsxuVGePoBR0yJ4wQuOmwWWIM03/0g5zjpfls0wftupwREATMch/1E0i
         Mzrg==
X-Gm-Message-State: AOAM5301/BMw2vs5bemj6oRn7IZM5dFVKgKdUDIRLPMJjoBajbw7s6UB
        k2CkCzzwCSf1lcv5hoLQL+wjqCpTv4xuinZW5gU=
X-Google-Smtp-Source: ABdhPJwT163ZYYbEnBbL+2XCiZ6okunVzg/6yGtUVq0Vy/mj0Q7WgM73Tx/fnVPkyZDn/nLJ400y5K4S5OMTYPDaI0Y=
X-Received: by 2002:a63:26c1:: with SMTP id m184mr18425080pgm.296.1643661949314;
 Mon, 31 Jan 2022 12:45:49 -0800 (PST)
MIME-Version: 1.0
References: <20220130010956.1459147-1-rosenp@gmail.com> <20220131143930.GL14046@twin.jikos.cz>
In-Reply-To: <20220131143930.GL14046@twin.jikos.cz>
From:   Rosen Penev <rosenp@gmail.com>
Date:   Mon, 31 Jan 2022 12:46:54 -0800
Message-ID: <CAKxU2N8jeMT_4kJrwLFng0WLYBo=kfYmrz0Hu1NpdWR-fOzVnA@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: fix 64-bit mips and powerpc types
To:     dsterba@suse.cz, Rosen Penev <rosenp@gmail.com>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 31, 2022 at 6:40 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Sat, Jan 29, 2022 at 05:09:56PM -0800, Rosen Penev wrote:
> > The kernel uses unsigned long specifically for ppc64 and mips64. This
> > fixes that.
>
> What do you mean? Uses unsigned long for what?
kernel's u64 is normally unsigned long long, but not for ppc64 and mips64.
>
> > Removed asm/types.h include as it will get included properly later.
> >
> > Fixes -Wformat warnings.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  cmds/receive-dump.c | 1 -
> >  kerncompat.h        | 4 ++++
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/cmds/receive-dump.c b/cmds/receive-dump.c
> > index 47a0a30e..00ad4fd1 100644
> > --- a/cmds/receive-dump.c
> > +++ b/cmds/receive-dump.c
> > @@ -31,7 +31,6 @@
> >  #include <stdlib.h>
> >  #include <time.h>
> >  #include <ctype.h>
> > -#include <asm/types.h>
> >  #include <uuid/uuid.h>
> >  #include "common/utils.h"
> >  #include "cmds/commands.h"
> > diff --git a/kerncompat.h b/kerncompat.h
> > index 6ca1526e..4b36b45a 100644
> > --- a/kerncompat.h
> > +++ b/kerncompat.h
> > @@ -19,6 +19,10 @@
> >  #ifndef __KERNCOMPAT_H__
> >  #define __KERNCOMPAT_H__
> >
> > +#ifndef __SANE_USERSPACE_TYPES__
> > +#define __SANE_USERSPACE_TYPES__     /* For PPC64, to get LL64 types */
> > +#endif
>
> Is there a cleaner way instead of defining magic macros?
no. https://github.com/torvalds/linux/blob/master/arch/powerpc/include/uapi/asm/types.h#L18
>
> > +
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <errno.h>
> > --
> > 2.34.1
