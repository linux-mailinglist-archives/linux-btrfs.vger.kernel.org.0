Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B88479333
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 18:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239968AbhLQR5R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 12:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbhLQR5P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 12:57:15 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7781CC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Dec 2021 09:57:15 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bf8so4763431oib.6
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Dec 2021 09:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j33bONWxI8HqLQNyFt0j3bLeksRnrj43gxmYBXawatI=;
        b=NGE9yT1OJfwePKx0UQ2xc9z+K3V0ULRQlgOuC+dWZT19NUFHxSL2GvqTWaIV/w0XJm
         iGcxn7nvetxS15eO4/WsHRX52YiKZ+1Y0UeG7Th3t1LM/e4IweufF2p25c+XmPYRUXzC
         WH9aHfQ1IMIyGR4SBdN23Y/5IxeyTa4hRWKTrnwJT3URvlzxhMyv8uHlH0OHBqzx76EL
         zptOpxczHLTRFVS/W8FgwdtYM/IERHcQU8TPqyOTQm/xaKGUN3MJYaIzjgXCsijF1DDS
         SAz7gvh6XT+pormBmcB3TBNATBsoywzxigHJjXalPewzbnM9awRq1AVCSFmRqWeM+IC2
         899Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j33bONWxI8HqLQNyFt0j3bLeksRnrj43gxmYBXawatI=;
        b=lT/RcJ4/0DLetgKO4kJvJ2rPRK4b4L4gWv0PNXhx20RrDEdD6OITP5yXTyqE5PM5pq
         T5r0E49GIwcfQSJaUlT9O3e8P3PozWtT4ufNWTzNJMoSTKmrGdW4lXCKWNM9KWxxfQKD
         y2/ncDjH+mj/5fDUZw/xnTMQTduoH6V9MkLw/PHhsHozQvI5p5T10+8KPDPfPCaSTkPd
         ATArdA9AJUGyEr4pjurbwFjAJbhUSTyH+I5qdDFWbRmbLBBeu/SrDNQDhzX+s8z5x0aO
         PAWygzw7t3ZdSv8RCbtqdIX6pyASMg9JWlVye5pKgHUAnO2vrk/b94pJovUKkamMut6Y
         Jz4w==
X-Gm-Message-State: AOAM532WVOKawdDFODgcPQb177cxLrlDv3xoQFTEZCct9iX6T6b0xnwn
        V2RlIFm55DZvTFNMk9x2EaXyfzZzj+BnOIFEtjCxbf9XQtM=
X-Google-Smtp-Source: ABdhPJz0E9C3pJ/k3UtjwZz77Dl2JhgDhyJJUTcyXgq95/azkDq/JhWwedk/2kwLAJN9ii+xey4NhBseHhTnqjmAApU=
X-Received: by 2002:aca:6146:: with SMTP id v67mr3077471oib.82.1639763834875;
 Fri, 17 Dec 2021 09:57:14 -0800 (PST)
MIME-Version: 1.0
References: <CAHQ7scWFUthGXGs72M9VYPHc2eiZ2hSSs6LJd6XVL2oQO2fgLw@mail.gmail.com>
 <20211215155059.GB28560@twin.jikos.cz> <PH0PR04MB741678D21AA0328B07AD69689B789@PH0PR04MB7416.namprd04.prod.outlook.com>
In-Reply-To: <PH0PR04MB741678D21AA0328B07AD69689B789@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Jingyun He <jingyun.ho@gmail.com>
Date:   Sat, 18 Dec 2021 01:57:04 +0800
Message-ID: <CAHQ7scWwFxXCexCx-Sm4J6uujzv24gWXuMzvq-0qC2dgC_HZQg@mail.gmail.com>
Subject: Re: unable to use all spaces
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,
Here is output of fi usage:

Overall:
    Device size:   14.55TiB
    Device allocated:   14.55TiB
    Device unallocated:   1.75GiB
    Device missing:     0.00B
    Device zone unusable:     0.00B
    Device zone size:     0.00B
    Used:   14.42TiB
    Free (estimated): 129.49GiB (min: 129.49GiB)
    Free (statfs, df): 129.49GiB
    Data ratio:       1.00
    Metadata ratio:       1.00
    Global reserve: 512.00MiB (used: 112.00KiB)
    Multiple profiles:         no
Data,single: Size:14.53TiB, Used:14.41TiB (99.14%)
   /dev/sds   14.53TiB
Metadata,single: Size:18.00GiB, Used:14.75GiB (81.95%)
   /dev/sds   18.00GiB
System,single: Size:256.00MiB, Used:6.05MiB (2.36%)
   /dev/sds 256.00MiB
Unallocated:
   /dev/sds   1.75GiB

And I'm unable to add another file at 30GiB.
Do you have any advice?

BTW,
blkzone report /dev/sds
returns:
"blkzone: /dev/sds: unable to determine zone size"

Thank you.

On Fri, Dec 17, 2021 at 3:51 PM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 15/12/2021 16:51, David Sterba wrote:
> > On Wed, Dec 15, 2021 at 10:31:13PM +0800, Jingyun He wrote:
> >> Hello,
> >> I have a 14TB WDC HM-SMR disk formatted with BTRFS,
> >> It looks like I'm unable to fill the disk full.
> >> E.g. btrfs fi usage /disk1/
> >> Free (estimated): 128.95GiB (min: 128.95GiB)
> >>
> >> It still has 100+GB available
> >> But I'm unable to put more files.
> >
> > We'd need more information to diagnose that, eg. output of 'btrfs fi df'
> > to see if eg. the metadata space is not exhausted or if the remaining
> > 128G account for the unusable space in the zones (this is also in the
> > 'fi df' output).
>
> Can you also share the output of 'blkzone report /dev/sdX'?
>
>
> Thanks a lot,
>         Johannes
