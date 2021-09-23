Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE00F415BC2
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 12:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240323AbhIWKKY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 06:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240186AbhIWKKY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 06:10:24 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED51C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 03:08:52 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y28so24418814lfb.0
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 03:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SCaLgngl2LNVJy6sUfTI7xZD+PUsUvgVNLsOsP6sVC0=;
        b=TpcAYDzFr9jvN9S+81GuNUpDono6E3qL3+rlSizTx/7YM8atoliH3bbUKDRUiqI/Oy
         4xGlMh8iHSzMQmyMcyU+BtuZPAMjgGwdDwht6+A1nEtpm1KbA4YcHsHHVCsk8Z7t5QUT
         T+Y+ni3R73QuY/6s4PDwgwEfYS4qjPhoSwa5EAukYDoPiAVmly2ADBg6JV3r02HbKLNO
         4WXDWMmraPdJSE8o3ej9je8xQb5cisTeNwX5YTP4B9T6cs+hOa+Zm0PqTfV1m8jnhwf3
         JUxB8sEX+UGgqOIYpE6N7y1pzoIwJRG9EhhQ5Rb+IAqJjMnoGN8fzDV8OZ2JEFxqWWsD
         2JuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCaLgngl2LNVJy6sUfTI7xZD+PUsUvgVNLsOsP6sVC0=;
        b=p+YLWANTjyo0KCGFW4ISTU8bXYH3AeeDq+w4A1m2IzZo1DEr3QBO0wk/FRzSaqCkaP
         MKTnjFuoZMWRVk9qzzxY90v9C7rgaWMpYpYbyPqSmQMkZWUhczLyhmp6ml98NTsFyQQ1
         TJX59NYscQcRgPrrGWgxRR6SkMA6MIdTd34/NavsiDiZvG7U7UVZ6D0F4ZPhRecSzgRW
         /Tt1S0mbZm6K+pbrdsJvaBS6tg+rMgdXWfqQWdhc3l7bQA3FMOWR7jzCrouGXDcvVIS/
         0W5oMV41HIFcjtPzu5s94vUPRGsaWj2Hpk5Ig+7Bbcdywsg92pfAZktCZu3FjvtFZrxb
         Olzw==
X-Gm-Message-State: AOAM533MOfFgdEHGO92gLchPdftZcsnI0gyuBfSZLFSDzUqfbQDUujwT
        7qk/gixUVIn+80l1CMSRwt7afwooKTT3npI+7Uo=
X-Google-Smtp-Source: ABdhPJzoEwljAquXjlCeC8J1fZ/L735BJ6moPkA1D05m6LjQKUipuxbMg8uEl5qS2w8nC/qIJSoB9G1VvGtafEtobtE=
X-Received: by 2002:a2e:a37c:: with SMTP id i28mr4118969ljn.76.1632391731079;
 Thu, 23 Sep 2021 03:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAGqt0zz9YrxXPCCGVFjcMoVk5T4MekPBNMaPapxZimcFmsb4Ww@mail.gmail.com>
 <e45e799c-b41a-d8c7-e8d8-598d81602369@gmx.com> <CAGqt0zyEx1pyStPVTSnvsZGYKAGEv9yUunv-82Mj6ZED3WNKRA@mail.gmail.com>
 <CAGqt0zy6a8+awo6ifUn4x+WxN=c6e8PnuMW5kYRodxOQ6vwU-A@mail.gmail.com>
 <72d66f13-6380-7fcd-3475-8152caa965c4@gmx.com> <CAGqt0zz+=nUYbNwLSPYwzYcNLgyxsWT22p+jwwFpAOcyAHAWgA@mail.gmail.com>
 <e83029f0-8583-91b9-47c8-a99d4b00a6ae@gmx.com> <CAGqt0zykaioT1LJAtOM8Zc4eJBXxTEy2ugBrLpgZ=BzCJzixXQ@mail.gmail.com>
 <CAGqt0zwchNdLKz4_qHrdbuxx7RWY9YbdiZ4KBYJcrwWa3sxBZw@mail.gmail.com> <529263b6-4ff9-1bf6-8566-ed1ec648a539@suse.com>
In-Reply-To: <529263b6-4ff9-1bf6-8566-ed1ec648a539@suse.com>
From:   Yuxuan Shui <yshuiv7@gmail.com>
Date:   Thu, 23 Sep 2021 11:08:39 +0100
Message-ID: <CAGqt0zxrm=A8v7Mm6CDNUv77Sxsgt_kp4uJpCbpbCGXrnUmBqA@mail.gmail.com>
Subject: Re: btrfs receive fails with "failed to clone extents"
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On Thu, Sep 23, 2021 at 10:45 AM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2021/9/23 17:43, Yuxuan Shui wrote:
> > Hi,
> >
> > On Thu, Sep 23, 2021 at 10:38 AM Yuxuan Shui <yshuiv7@gmail.com> wrote:
> >>
> >> Hi,
> >>
> >> On Thu, Sep 23, 2021 at 4:28 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>>
> >>>
> >>>
> >>> On 2021/9/23 11:09, Yuxuan Shui wrote:
> >>>> Hi,
> >>>>
> >>>> On Thu, Sep 23, 2021 at 3:32 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 2021/9/23 09:40, Yuxuan Shui wrote:
> >>>>>> On Thu, Sep 23, 2021 at 2:34 AM Yuxuan Shui <yshuiv7@gmail.com> wrote:
> >>>>>>>
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> On Thu, Sep 23, 2021 at 12:24 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 2021/9/23 03:37, Yuxuan Shui wrote:
> >>>>>>>>> Hi,
> >>>>>>>>>
> >>>>>>>>> The problem is as the title states. Relevant logs from `btrfs receive -vvv`:
> >>>>>>>>>
> >>>>>>>>>       mkfile o119493905-1537066-0
> >>>>>>>>>       rename o119493905-1537066-0 ->
> >>>>>>>>> shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h
> >>>>>>>>>       utimes shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include
> >>>>>>>>>       clone shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h
> >>>>>>>>> - source=shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h
> >>>>>>>>> source offset=0 offset=0 length=131072
> >>>>>>>>>       ERROR: failed to clone extents to
> >>>>>>>>> shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h:
> >>>>>>>>> Invalid argument
> >>>>>>>>>
> >>>>>>>>> stat of shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h,
> >>>>>>>>> on the receiving end:
> >>>>>>>>>
> >>>>>>>>>       File: /mnt/backup/home/backup-32/shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h
> >>>>>>>>>       Size: 145904 Blocks: 288 IO Block: 4096 regular file
> >>>>>>>>>
> >>>>>>>>> Looks to me the range of clone is within the boundary of the source
> >>>>>>>>> file. Not sure why this failed?
> >>>>>>>>
> >>>>>>>> The most common reason is, you have changed the parent subvolume from RO
> >>>>>>>> to RW, and modified the parent subvolume, then converted it back to RO.
> >>>>>>>
> >>>>>>> This is 100% not the case. I created these snapshots as RO right
> >>>>>>> before sending, and definitely haven't
> >>>>>>> changed them to RW ever.
> >>>>>>
> >>>>>> Besides that, I straced the btrfs command and this clone ioctl
> >>>>>> definitely looks valid, irregardless of whether the parent snapshot
> >>>>>> has been changed or not. The length looks to be aligned (128k), and
> >>>>>> the range is within the source file. Why did the clone fail?
> >>>>>
> >>>>> The clone source must not have certain bits like NODATACOW.
> >>>>
> >>>> lsattr doesn't show anything. The entire file system is mounted with
> >>>> nodatasum, though. But I assume if this bit is the problem, send won't
> >>>> fail just on this particular file?
> >>>
> >>> If source and dest file has different NODATASUM flags (one has and the
> >>> other doesn't), then it will also be rejected.
> >>>
> >>> NODATASUM flag won't show up in lsattr, thus you need to use "btrfs
> >>> prop" to check.
> >>
> >> I checked but I don't think "btrfs prop" shows the NODATASUM flag. The
> >> flags it displays include ro, label and compression only.
> >>
> >>>
> >>> Considering you're mounting with NODATASUM, I guess that could the case.
> >>> Your receive target is inheriting the NODATASUM flag, while the source
> >>> file doesn't have the NODATASUM flag.
> >>
> >>
> >> Interesting, but the clone is within the same subvolume that is been
> >> received. Won't the whole subvolume get the same flag, since the file
> >> system is mounted with nodatasum?
> >>
> >>>
> >>> If that's the case, I guess we may hit a new bug for receive, that we
> >>> should also update the dest file's flags before doing reflink.
> >>>
> >>> Could you remove the partially received (and fialed) subvolume, remount
> >>> the fs without nodatasum, then try again to see if that's the case?
> >>> (It may need to change the destination directory too to remove the
> >>> NODATASUM flag)
> >
> > Yes, the send/receive worked without nodatasum.
>
> Mind to provide the full send stream dump?
>
> This indeed looks like a bug now.

Sorry, this might have data I am not allowed to share, and I don't
think I will be able to vet all the files in the stream.

But if you can let me know what I can do to help debugging, I could try that.

>
> Thanks,
> Qu
>
> >
> >>>
> >>> Thanks,
> >>> Qu
> >>>>
> >>>>>
> >>>>> If non-incremental send stream works, then it's almost certain it's the
> >>>>> received UUID bug we're working on.
> >>>>
> >>>> I haven't tried non-incremental. If by received UUID bug you meant
> >>>> this one: https://lore.kernel.org/linux-btrfs/87blnsuv7m.fsf@gmail.com/T/
> >>>> , then I don't think this is the one. I don't have duplicated received
> >>>> UUIDs on either end.
> >>>>
> >>>>>
> >>>>> Thanks,
> >>>>> Qu
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Btrfs should not allow such incremental send at all.
> >>>>>>>>
> >>>>>>>> We're already working on such problem, but next time if you want to
> >>>>>>>> modify a RO subvolume which could be the parent subvolume of incremental
> >>>>>>>> send, please either do a snapshot then modify the snapshot, or just
> >>>>>>>> don't do it.
> >>>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>> Qu
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Sending end has 5.14.6 and btrfs-progs 5.14, receiving end has 5.14.6
> >>>>>>>>> and btrfs-progs 5.13.1
> >>>>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> --
> >>>>>>>
> >>>>>>> Regards
> >>>>>>> Yuxuan Shui
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>
> >>>>
> >>>>
> >>
> >>
> >>
> >> --
> >>
> >> Regards
> >> Yuxuan Shui
> >
> >
> >
>


-- 

Regards
Yuxuan Shui
