Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C06415529
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 03:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238799AbhIWBmP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 21:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbhIWBmP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 21:42:15 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823D4C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 18:40:44 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x27so19864378lfu.5
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 18:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MmUm9et4EBCwf/Mzf2RCBPO5WB4yEpXreJvP+LUSay8=;
        b=QcrIRj1PlLnLTfTkxl/SMUdgoxcjrd6+Zo11SJrTJ0QvR2cS3BIYGn1Nh4ZfGF0+G0
         ZFF7N2vVyT34m5UegyXuPuyqgsttfU3jNU34eyvVX9ZjN54AESXalxnWcvoIQJOPrh6A
         GuXQMtEb0kd+PVnlKs7fo1ai4QHnZ8OfeAIFdxopwVMVJCGttZABQ/no55inXZuvliKo
         JBh4YH2jUOlKbGgTfLdnv2EvD6P/NUIHjXQ2KTcCTAN1zKQJmR/l5bJauhIOVBvlz/F8
         F8GIc0+mLx2WYcM0G424b4KzBO2K4baJ5LUqv2MVDTU0kEzO0QWHyV1x3JKe84h5zVyU
         9UOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MmUm9et4EBCwf/Mzf2RCBPO5WB4yEpXreJvP+LUSay8=;
        b=JSo50C7332/1XbNDY+ciAG9E25TJpF6k7PEPSKiVyQmwPUgh2Y1cV7Qsq8AfalpaPd
         EsJleR3MUQI8DpP9IREa5e05dXjpNoS+pbBDcbM9kCbOoztjZAZCUp9OcD3lYQQNfeDZ
         N0w09t1KrVrYK7NhkG5u5qeU4V/OTJ7oPDPIlFNlmUHgqqOLeHeIG2Sksgx6U7uU5uy6
         gW1Rm91qZc/1yCYQh2g+ftc1ksrWcVf6dEY/GQaJw23yY55MAwrBU9Ei4Cy0neCLXt5z
         v8NuNUW3p/M2Pb9b24jS1h0SV6sKoTzXrPrb3aq10lMYpyBAFZRahz12KB6FgBXT+Pe1
         YElQ==
X-Gm-Message-State: AOAM532FOOChb0xzpc3sUWRKwjnXyVbHFTFxSsQnNB/WRlGVio9fpAd1
        Yw4zEaTwdVOHeADBJiK7Dxo/0lbo02RYB7ozScAHcmGq
X-Google-Smtp-Source: ABdhPJyPqJKkgWrWN15IcK48eduMlPwX7iypZtwiPT+/xG4AI8E/G8tN/omkru5ziAscMbePcCIHgMRT3BRonB9nToo=
X-Received: by 2002:ac2:494d:: with SMTP id o13mr1787831lfi.354.1632361242826;
 Wed, 22 Sep 2021 18:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAGqt0zz9YrxXPCCGVFjcMoVk5T4MekPBNMaPapxZimcFmsb4Ww@mail.gmail.com>
 <e45e799c-b41a-d8c7-e8d8-598d81602369@gmx.com> <CAGqt0zyEx1pyStPVTSnvsZGYKAGEv9yUunv-82Mj6ZED3WNKRA@mail.gmail.com>
In-Reply-To: <CAGqt0zyEx1pyStPVTSnvsZGYKAGEv9yUunv-82Mj6ZED3WNKRA@mail.gmail.com>
From:   Yuxuan Shui <yshuiv7@gmail.com>
Date:   Thu, 23 Sep 2021 02:40:30 +0100
Message-ID: <CAGqt0zy6a8+awo6ifUn4x+WxN=c6e8PnuMW5kYRodxOQ6vwU-A@mail.gmail.com>
Subject: Re: btrfs receive fails with "failed to clone extents"
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 23, 2021 at 2:34 AM Yuxuan Shui <yshuiv7@gmail.com> wrote:
>
> Hi,
>
> On Thu, Sep 23, 2021 at 12:24 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >
> >
> >
> > On 2021/9/23 03:37, Yuxuan Shui wrote:
> > > Hi,
> > >
> > > The problem is as the title states. Relevant logs from `btrfs receive -vvv`:
> > >
> > >    mkfile o119493905-1537066-0
> > >    rename o119493905-1537066-0 ->
> > > shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h
> > >    utimes shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include
> > >    clone shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h
> > > - source=shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h
> > > source offset=0 offset=0 length=131072
> > >    ERROR: failed to clone extents to
> > > shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h:
> > > Invalid argument
> > >
> > > stat of shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h,
> > > on the receiving end:
> > >
> > >    File: /mnt/backup/home/backup-32/shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h
> > >    Size: 145904 Blocks: 288 IO Block: 4096 regular file
> > >
> > > Looks to me the range of clone is within the boundary of the source
> > > file. Not sure why this failed?
> >
> > The most common reason is, you have changed the parent subvolume from RO
> > to RW, and modified the parent subvolume, then converted it back to RO.
>
> This is 100% not the case. I created these snapshots as RO right
> before sending, and definitely haven't
> changed them to RW ever.

Besides that, I straced the btrfs command and this clone ioctl
definitely looks valid, irregardless of whether the parent snapshot
has been changed or not. The length looks to be aligned (128k), and
the range is within the source file. Why did the clone fail?

>
> >
> > Btrfs should not allow such incremental send at all.
> >
> > We're already working on such problem, but next time if you want to
> > modify a RO subvolume which could be the parent subvolume of incremental
> > send, please either do a snapshot then modify the snapshot, or just
> > don't do it.
> >
> > Thanks,
> > Qu
> >
> > >
> > > Sending end has 5.14.6 and btrfs-progs 5.14, receiving end has 5.14.6
> > > and btrfs-progs 5.13.1
> > >
>
>
>
> --
>
> Regards
> Yuxuan Shui



-- 

Regards
Yuxuan Shui
