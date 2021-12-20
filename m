Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024AD47A3C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Dec 2021 04:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbhLTDGg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Dec 2021 22:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhLTDGg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Dec 2021 22:06:36 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE99EC061574
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Dec 2021 19:06:35 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id u74so13739069oie.8
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Dec 2021 19:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=paI+1qltQ13fazXbmSliDsATITALN09SHqgPMTfwrLM=;
        b=YrJFQ8hs5xMcBvj8JS7nBPqD2IoRUUa5TXz6vzNhj7x9nXo/NhXINIBI61jBGo1UYD
         QNdPy4QdQyAx3BNMDTucw+sN+eTPbKW/Tc2NMHqDmCH0FNAKIdkgEePV/tDwT/wuU3S3
         nWBGL4zYBsViVX3NH0yH4RujPyiMi3ll7udfx7R8+YwSoQ5wilkmtW4DsgoV9H4ShSg1
         ymW/oqVB14Sxd0VP10b32soExuKc4bpi+QO0hNecxvLpJ4qUxcLc2rb/1JTDJfHweXAY
         Hpo/Fov4bx6WHP0XlNFI/7AFy/dOGS6bNw8i7W2hJnBgZE+U52fqsf4aLH9/er6Ho0PR
         pO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=paI+1qltQ13fazXbmSliDsATITALN09SHqgPMTfwrLM=;
        b=tQeieFH5MwEF1Iu56essy4lXsIGlaDkKC+7WROg9E2ezHx3sZvCqePpm7e7rsd4LBJ
         uRUEVEINLLa5uSpANTWTQIaMqJ5fRWzfUmWWNl8Fd7X5UqbDME7RWE4xjkHGMDJ1h6WW
         FP4lHjpHAnZrIruIq4Hnxcok8oh6Cn6Op3HlZsZyrXvedUK19vyZmZZPVrirRioEUZCl
         qnOevNkgeY7Ojqcvbbpk8qfTaNggIZq9GCvHhUSDTjVVg8pIVJsLWIcjXyD+1TB3GtWB
         xUZDXVwCwPhUVid4ypZHgUyB1sAJr7uEtcDDDUlO31ZfgHr1tP64VdodjiI2fYdGzNo3
         0+vg==
X-Gm-Message-State: AOAM532ycX2AJebvaCId1FmF5rQS6qTIFqfyTIt1QtcLxptWtHR/mXEH
        jE2FJLgmJFb/zWiA9DRreaWkXqcUCUM8pBgbCu4=
X-Google-Smtp-Source: ABdhPJyBvpUvPlbJbffQWKK1ga17XQS7Y+S+FDAZTpOehgodkrKk8jaKz5uhnf2ovWg/d4P+0uVs4uXcywaPr6OjiZ4=
X-Received: by 2002:a05:6808:1589:: with SMTP id t9mr16814226oiw.108.1639969595304;
 Sun, 19 Dec 2021 19:06:35 -0800 (PST)
MIME-Version: 1.0
References: <CAHQ7scWFUthGXGs72M9VYPHc2eiZ2hSSs6LJd6XVL2oQO2fgLw@mail.gmail.com>
 <20211215155059.GB28560@twin.jikos.cz> <PH0PR04MB741678D21AA0328B07AD69689B789@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAHQ7scWwFxXCexCx-Sm4J6uujzv24gWXuMzvq-0qC2dgC_HZQg@mail.gmail.com>
 <CAHQ7scUXLmgPNmy1h8mJYaTCfGLU8cX5qAEixo-78ysHkLSVRA@mail.gmail.com> <CAHQ7scUEkMdFxFaFEAqKxv7nM_2-zzbRUF=AhK-bMOrOjic0yA@mail.gmail.com>
In-Reply-To: <CAHQ7scUEkMdFxFaFEAqKxv7nM_2-zzbRUF=AhK-bMOrOjic0yA@mail.gmail.com>
From:   Jingyun He <jingyun.ho@gmail.com>
Date:   Mon, 20 Dec 2021 11:06:24 +0800
Message-ID: <CAHQ7scVsHEG+nVxne0e2j4X8P8RE12vnGTJ1wchBHrTiJWMjtA@mail.gmail.com>
Subject: Re: unable to use all spaces
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,
After running
"btrfs balance start -v -dusage=5 /mnt/" resolved this issue now.

On Mon, Dec 20, 2021 at 2:04 AM Jingyun He <jingyun.ho@gmail.com> wrote:
>
> Hello,
> Here is the result of the command
> "btrfs fi usage /mnt/" of the 14TB HM-SMR device.
>
> Overall:
>     Device size:   12.73TiB
>     Device allocated:   12.73TiB
>     Device unallocated:   1.75GiB
>     Device missing:     0.00B
>     Device zone unusable:     0.00B
>     Device zone size: 256.00MiB
>     Used:   12.66TiB
>     Free (estimated):   72.29GiB (min: 72.29GiB)
>     Free (statfs, df):   72.29GiB
>     Data ratio:       1.00
>     Metadata ratio:       1.00
>     Global reserve: 512.00MiB (used: 640.00KiB)
>     Multiple profiles:         no
> Data,single: Size:12.71TiB, Used:12.64TiB (99.46%)
>    /dev/sda   12.71TiB
> Metadata,single: Size:20.00GiB, Used:15.91GiB (79.55%)
>    /dev/sda   20.00GiB
> System,single: Size:256.00MiB, Used:5.28MiB (2.06%)
>    /dev/sda 256.00MiB
> Unallocated:
>    /dev/sda   1.75GiB
>
> And I'm unable to add more files to this device.
> [root@server1 mnt]# > a
> -bash: a: No space left on device
>
> Anyone can help me ?
>
> Thanks.
>
> On Sat, Dec 18, 2021 at 2:00 AM Jingyun He <jingyun.ho@gmail.com> wrote:
> >
> > Sorry, my mistake, this device is not HM-SMR device.
> > But still I can not fill up the device.
> >
> > If I mount it with the nodatacow option, will it save some space?
> >
> > Thank you.
> >
> > On Sat, Dec 18, 2021 at 1:57 AM Jingyun He <jingyun.ho@gmail.com> wrote:
> > >
> > > Hello,
> > > Here is output of fi usage:
> > >
> > > Overall:
> > >     Device size:   14.55TiB
> > >     Device allocated:   14.55TiB
> > >     Device unallocated:   1.75GiB
> > >     Device missing:     0.00B
> > >     Device zone unusable:     0.00B
> > >     Device zone size:     0.00B
> > >     Used:   14.42TiB
> > >     Free (estimated): 129.49GiB (min: 129.49GiB)
> > >     Free (statfs, df): 129.49GiB
> > >     Data ratio:       1.00
> > >     Metadata ratio:       1.00
> > >     Global reserve: 512.00MiB (used: 112.00KiB)
> > >     Multiple profiles:         no
> > > Data,single: Size:14.53TiB, Used:14.41TiB (99.14%)
> > >    /dev/sds   14.53TiB
> > > Metadata,single: Size:18.00GiB, Used:14.75GiB (81.95%)
> > >    /dev/sds   18.00GiB
> > > System,single: Size:256.00MiB, Used:6.05MiB (2.36%)
> > >    /dev/sds 256.00MiB
> > > Unallocated:
> > >    /dev/sds   1.75GiB
> > >
> > > And I'm unable to add another file at 30GiB.
> > > Do you have any advice?
> > >
> > > BTW,
> > > blkzone report /dev/sds
> > > returns:
> > > "blkzone: /dev/sds: unable to determine zone size"
> > >
> > > Thank you.
> > >
> > > On Fri, Dec 17, 2021 at 3:51 PM Johannes Thumshirn
> > > <Johannes.Thumshirn@wdc.com> wrote:
> > > >
> > > > On 15/12/2021 16:51, David Sterba wrote:
> > > > > On Wed, Dec 15, 2021 at 10:31:13PM +0800, Jingyun He wrote:
> > > > >> Hello,
> > > > >> I have a 14TB WDC HM-SMR disk formatted with BTRFS,
> > > > >> It looks like I'm unable to fill the disk full.
> > > > >> E.g. btrfs fi usage /disk1/
> > > > >> Free (estimated): 128.95GiB (min: 128.95GiB)
> > > > >>
> > > > >> It still has 100+GB available
> > > > >> But I'm unable to put more files.
> > > > >
> > > > > We'd need more information to diagnose that, eg. output of 'btrfs fi df'
> > > > > to see if eg. the metadata space is not exhausted or if the remaining
> > > > > 128G account for the unusable space in the zones (this is also in the
> > > > > 'fi df' output).
> > > >
> > > > Can you also share the output of 'blkzone report /dev/sdX'?
> > > >
> > > >
> > > > Thanks a lot,
> > > >         Johannes
