Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A74415B18
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 11:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbhIWJkK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 05:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238217AbhIWJkJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 05:40:09 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDC2C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 02:38:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i25so24402604lfg.6
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 02:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=IbYTRQeULujJJnshABs4T9g4izJUHbe8XAyuuoh0EB4=;
        b=O8CQ82sJjGdFco0cqK4VOtGNdYt28f4YfaoRMnXSzteY5dobuE0t/iYhdsFv9z98R0
         z4cv96Ze71RXO3gZi215ZFfJA805hA3YrWVvCUJVJN+k0AxokRSV6tB7TjjN3RSRILBY
         r4UBc4y4WibVvmBiS/N0tiU26SoABR4rCeAxwgt9NIVxXj5wQFrB1BeZZ0f79yVpvgCq
         3zx9kBqUGth8C3vBpOP3ytJwjrd06jr/BoApJRRZ/8MGsduhZ13CsrJa3mPjRFoODV2a
         wH30EyfsWFHTHDlJPmU8s2SQhIqEkHl752xnIoT41UBpKeouRRk2r53oDzJAGZ31ols4
         azfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=IbYTRQeULujJJnshABs4T9g4izJUHbe8XAyuuoh0EB4=;
        b=xeBeanuuK63pWK2QpDqygvC791XdPYN4gfoZzgdPn10Dr0SKlySPnIkeAcJqmnCJ15
         EfDdIXdYNP0jQZC5QwVnEEm2iY543tgKH99GUyMg9pdLBKJ0krVKUc1iEXMbU13219jl
         cRiZUVRTrwGoO4l0Q17q/3rSZtrU5Vj3N3CGh70DhFOQz2OLqtUDjswONNlez+N3DKMp
         TK2AYOyBd4uDGV7iVF1Wopr2DN+31w6/BOa7dlbC7pNj0Y3ner+4TvLr1yf/2GsDFSZB
         dpc+qX/neYtYY10+1Gn+XI8+eOxnb7kqeNHm2y7YeXRT09z2yYzryGUEjh7/Lv6U1aYl
         Fdzw==
X-Gm-Message-State: AOAM5330mEeYLwdBE02j421mhSfUxctPtfYKJeWU3lDPi1TJ673YTAme
        FDXgjthtWDnG0LyqBmVkd7DM6NIYjIDwXmnl5K9PxkZ5c9w=
X-Google-Smtp-Source: ABdhPJxNbVC65OZqincfyqP2shNDQPXvKecPCCj0K7iyC5L/wdvyXpC/Yxmj/1cc46bXUFeml98O8rNutuZKTEdTs0o=
X-Received: by 2002:a19:6a16:: with SMTP id u22mr3283789lfu.254.1632389916213;
 Thu, 23 Sep 2021 02:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAGqt0zz9YrxXPCCGVFjcMoVk5T4MekPBNMaPapxZimcFmsb4Ww@mail.gmail.com>
 <e45e799c-b41a-d8c7-e8d8-598d81602369@gmx.com> <CAGqt0zyEx1pyStPVTSnvsZGYKAGEv9yUunv-82Mj6ZED3WNKRA@mail.gmail.com>
 <CAGqt0zy6a8+awo6ifUn4x+WxN=c6e8PnuMW5kYRodxOQ6vwU-A@mail.gmail.com>
 <72d66f13-6380-7fcd-3475-8152caa965c4@gmx.com> <CAGqt0zz+=nUYbNwLSPYwzYcNLgyxsWT22p+jwwFpAOcyAHAWgA@mail.gmail.com>
 <e83029f0-8583-91b9-47c8-a99d4b00a6ae@gmx.com>
In-Reply-To: <e83029f0-8583-91b9-47c8-a99d4b00a6ae@gmx.com>
From:   Yuxuan Shui <yshuiv7@gmail.com>
Date:   Thu, 23 Sep 2021 10:38:24 +0100
Message-ID: <CAGqt0zykaioT1LJAtOM8Zc4eJBXxTEy2ugBrLpgZ=BzCJzixXQ@mail.gmail.com>
Subject: Re: btrfs receive fails with "failed to clone extents"
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On Thu, Sep 23, 2021 at 4:28 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/9/23 11:09, Yuxuan Shui wrote:
> > Hi,
> >
> > On Thu, Sep 23, 2021 at 3:32 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>
> >>
> >>
> >> On 2021/9/23 09:40, Yuxuan Shui wrote:
> >>> On Thu, Sep 23, 2021 at 2:34 AM Yuxuan Shui <yshuiv7@gmail.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> On Thu, Sep 23, 2021 at 12:24 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 2021/9/23 03:37, Yuxuan Shui wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> The problem is as the title states. Relevant logs from `btrfs receive -vvv`:
> >>>>>>
> >>>>>>      mkfile o119493905-1537066-0
> >>>>>>      rename o119493905-1537066-0 ->
> >>>>>> shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h
> >>>>>>      utimes shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include
> >>>>>>      clone shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h
> >>>>>> - source=shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h
> >>>>>> source offset=0 offset=0 length=131072
> >>>>>>      ERROR: failed to clone extents to
> >>>>>> shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h:
> >>>>>> Invalid argument
> >>>>>>
> >>>>>> stat of shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h,
> >>>>>> on the receiving end:
> >>>>>>
> >>>>>>      File: /mnt/backup/home/backup-32/shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h
> >>>>>>      Size: 145904 Blocks: 288 IO Block: 4096 regular file
> >>>>>>
> >>>>>> Looks to me the range of clone is within the boundary of the source
> >>>>>> file. Not sure why this failed?
> >>>>>
> >>>>> The most common reason is, you have changed the parent subvolume from RO
> >>>>> to RW, and modified the parent subvolume, then converted it back to RO.
> >>>>
> >>>> This is 100% not the case. I created these snapshots as RO right
> >>>> before sending, and definitely haven't
> >>>> changed them to RW ever.
> >>>
> >>> Besides that, I straced the btrfs command and this clone ioctl
> >>> definitely looks valid, irregardless of whether the parent snapshot
> >>> has been changed or not. The length looks to be aligned (128k), and
> >>> the range is within the source file. Why did the clone fail?
> >>
> >> The clone source must not have certain bits like NODATACOW.
> >
> > lsattr doesn't show anything. The entire file system is mounted with
> > nodatasum, though. But I assume if this bit is the problem, send won't
> > fail just on this particular file?
>
> If source and dest file has different NODATASUM flags (one has and the
> other doesn't), then it will also be rejected.
>
> NODATASUM flag won't show up in lsattr, thus you need to use "btrfs
> prop" to check.

I checked but I don't think "btrfs prop" shows the NODATASUM flag. The
flags it displays include ro, label and compression only.

>
> Considering you're mounting with NODATASUM, I guess that could the case.
> Your receive target is inheriting the NODATASUM flag, while the source
> file doesn't have the NODATASUM flag.


Interesting, but the clone is within the same subvolume that is been
received. Won't the whole subvolume get the same flag, since the file
system is mounted with nodatasum?

>
> If that's the case, I guess we may hit a new bug for receive, that we
> should also update the dest file's flags before doing reflink.
>
> Could you remove the partially received (and fialed) subvolume, remount
> the fs without nodatasum, then try again to see if that's the case?
> (It may need to change the destination directory too to remove the
> NODATASUM flag)
>
> Thanks,
> Qu
> >
> >>
> >> If non-incremental send stream works, then it's almost certain it's the
> >> received UUID bug we're working on.
> >
> > I haven't tried non-incremental. If by received UUID bug you meant
> > this one: https://lore.kernel.org/linux-btrfs/87blnsuv7m.fsf@gmail.com/T/
> > , then I don't think this is the one. I don't have duplicated received
> > UUIDs on either end.
> >
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>>>
> >>>>>
> >>>>> Btrfs should not allow such incremental send at all.
> >>>>>
> >>>>> We're already working on such problem, but next time if you want to
> >>>>> modify a RO subvolume which could be the parent subvolume of incremental
> >>>>> send, please either do a snapshot then modify the snapshot, or just
> >>>>> don't do it.
> >>>>>
> >>>>> Thanks,
> >>>>> Qu
> >>>>>
> >>>>>>
> >>>>>> Sending end has 5.14.6 and btrfs-progs 5.14, receiving end has 5.14.6
> >>>>>> and btrfs-progs 5.13.1
> >>>>>>
> >>>>
> >>>>
> >>>>
> >>>> --
> >>>>
> >>>> Regards
> >>>> Yuxuan Shui
> >>>
> >>>
> >>>
> >
> >
> >



-- 

Regards
Yuxuan Shui
