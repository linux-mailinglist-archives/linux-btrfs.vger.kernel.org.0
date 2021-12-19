Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123E247A1AB
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Dec 2021 19:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbhLSSEQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Dec 2021 13:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbhLSSEQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Dec 2021 13:04:16 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FA3C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Dec 2021 10:04:15 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 7so12388156oip.12
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Dec 2021 10:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zZ/hKU4YgEkls9Kf+2aIFlQ0JMj8q1wfI5IE+Qodpls=;
        b=imIrZc+izIVbVicWFhyYWP3knkRmvMNUtB4mOKdHGOnTAnSuFTEKbEVtAVL+2+ZSO/
         siGapXZqeIj2l8I1F9A5O7f2lYNjJyALXbVkZfeEZSxs5NMugwYdxMzfFpEAZa/GBryI
         Gotr28p6RTzb5jAt96QUjs54WgAotOXCI+ukRqVbxj4Lrud7H9mdFr5g/2iZcu3WfSuW
         T+uePQKPj1hSHcSaz2sGaE2JlJCmg4O+UvKFb4sewFRH260qcXlksxOU+jix166LLsIn
         Rfa6yX0B94QonCKpXvJzrg2un2k7/ROsH6Ho3Qp7E4KA7nR5oPeEPcgRtmYZ/iD7gFLc
         6Xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zZ/hKU4YgEkls9Kf+2aIFlQ0JMj8q1wfI5IE+Qodpls=;
        b=UGbcVRUUYGpOT5RYj/ReLFaD8ppTQkc5vYvyoi47KSlBwGYhObThOh+0hl4mTEfdFo
         98aVr+Bkqqobd3cuZibFGTgJsslxBlA1FY1JbcsiUVYBPwpkpctS+WP+SpAaICxZaFSH
         kBNM0jFgmQY2LEwubOjLO2JGeroFdYuWYbZW9oP+dP3topoO1SJHQWfOAz1voT7qFifm
         g1ziStMHGN36uO6GKHStfhXh1Nc8yeAs7QJhEBbp+ZjpvujQc8SZpkPPN2Us1WLNs4rL
         gUCEjO2+D1RdmX0qXx/b9+xg+zQblougQwSGWMqNgLC5fvCuv0VNJ/0PKk5T6J0wjk2b
         +uBg==
X-Gm-Message-State: AOAM532Xh9F5jYYeat0qeYulLPDQrQ63IdqwOgDgN9qbPomNu2cJsfPf
        uf5JCGDO1Tyf/TzgLFQL/RzSDGERXjwFgC2dzcdt6joTuLM=
X-Google-Smtp-Source: ABdhPJwSy2l45OwQk65FRbRQWylS823lT/wpQ3QVr//2zLwCJCr5vCO+2ow7ltf3r9DDWG/4FOa3weUny4ZXqc54Xp0=
X-Received: by 2002:a05:6808:643:: with SMTP id z3mr9355489oih.110.1639937055211;
 Sun, 19 Dec 2021 10:04:15 -0800 (PST)
MIME-Version: 1.0
References: <CAHQ7scWFUthGXGs72M9VYPHc2eiZ2hSSs6LJd6XVL2oQO2fgLw@mail.gmail.com>
 <20211215155059.GB28560@twin.jikos.cz> <PH0PR04MB741678D21AA0328B07AD69689B789@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAHQ7scWwFxXCexCx-Sm4J6uujzv24gWXuMzvq-0qC2dgC_HZQg@mail.gmail.com> <CAHQ7scUXLmgPNmy1h8mJYaTCfGLU8cX5qAEixo-78ysHkLSVRA@mail.gmail.com>
In-Reply-To: <CAHQ7scUXLmgPNmy1h8mJYaTCfGLU8cX5qAEixo-78ysHkLSVRA@mail.gmail.com>
From:   Jingyun He <jingyun.ho@gmail.com>
Date:   Mon, 20 Dec 2021 02:04:04 +0800
Message-ID: <CAHQ7scUEkMdFxFaFEAqKxv7nM_2-zzbRUF=AhK-bMOrOjic0yA@mail.gmail.com>
Subject: Re: unable to use all spaces
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,
Here is the result of the command
"btrfs fi usage /mnt/" of the 14TB HM-SMR device.

Overall:
    Device size:   12.73TiB
    Device allocated:   12.73TiB
    Device unallocated:   1.75GiB
    Device missing:     0.00B
    Device zone unusable:     0.00B
    Device zone size: 256.00MiB
    Used:   12.66TiB
    Free (estimated):   72.29GiB (min: 72.29GiB)
    Free (statfs, df):   72.29GiB
    Data ratio:       1.00
    Metadata ratio:       1.00
    Global reserve: 512.00MiB (used: 640.00KiB)
    Multiple profiles:         no
Data,single: Size:12.71TiB, Used:12.64TiB (99.46%)
   /dev/sda   12.71TiB
Metadata,single: Size:20.00GiB, Used:15.91GiB (79.55%)
   /dev/sda   20.00GiB
System,single: Size:256.00MiB, Used:5.28MiB (2.06%)
   /dev/sda 256.00MiB
Unallocated:
   /dev/sda   1.75GiB

And I'm unable to add more files to this device.
[root@server1 mnt]# > a
-bash: a: No space left on device

Anyone can help me ?

Thanks.

On Sat, Dec 18, 2021 at 2:00 AM Jingyun He <jingyun.ho@gmail.com> wrote:
>
> Sorry, my mistake, this device is not HM-SMR device.
> But still I can not fill up the device.
>
> If I mount it with the nodatacow option, will it save some space?
>
> Thank you.
>
> On Sat, Dec 18, 2021 at 1:57 AM Jingyun He <jingyun.ho@gmail.com> wrote:
> >
> > Hello,
> > Here is output of fi usage:
> >
> > Overall:
> >     Device size:   14.55TiB
> >     Device allocated:   14.55TiB
> >     Device unallocated:   1.75GiB
> >     Device missing:     0.00B
> >     Device zone unusable:     0.00B
> >     Device zone size:     0.00B
> >     Used:   14.42TiB
> >     Free (estimated): 129.49GiB (min: 129.49GiB)
> >     Free (statfs, df): 129.49GiB
> >     Data ratio:       1.00
> >     Metadata ratio:       1.00
> >     Global reserve: 512.00MiB (used: 112.00KiB)
> >     Multiple profiles:         no
> > Data,single: Size:14.53TiB, Used:14.41TiB (99.14%)
> >    /dev/sds   14.53TiB
> > Metadata,single: Size:18.00GiB, Used:14.75GiB (81.95%)
> >    /dev/sds   18.00GiB
> > System,single: Size:256.00MiB, Used:6.05MiB (2.36%)
> >    /dev/sds 256.00MiB
> > Unallocated:
> >    /dev/sds   1.75GiB
> >
> > And I'm unable to add another file at 30GiB.
> > Do you have any advice?
> >
> > BTW,
> > blkzone report /dev/sds
> > returns:
> > "blkzone: /dev/sds: unable to determine zone size"
> >
> > Thank you.
> >
> > On Fri, Dec 17, 2021 at 3:51 PM Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> > >
> > > On 15/12/2021 16:51, David Sterba wrote:
> > > > On Wed, Dec 15, 2021 at 10:31:13PM +0800, Jingyun He wrote:
> > > >> Hello,
> > > >> I have a 14TB WDC HM-SMR disk formatted with BTRFS,
> > > >> It looks like I'm unable to fill the disk full.
> > > >> E.g. btrfs fi usage /disk1/
> > > >> Free (estimated): 128.95GiB (min: 128.95GiB)
> > > >>
> > > >> It still has 100+GB available
> > > >> But I'm unable to put more files.
> > > >
> > > > We'd need more information to diagnose that, eg. output of 'btrfs fi df'
> > > > to see if eg. the metadata space is not exhausted or if the remaining
> > > > 128G account for the unusable space in the zones (this is also in the
> > > > 'fi df' output).
> > >
> > > Can you also share the output of 'blkzone report /dev/sdX'?
> > >
> > >
> > > Thanks a lot,
> > >         Johannes
