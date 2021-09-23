Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76480415AF1
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 11:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240183AbhIWJ3c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 05:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240033AbhIWJ31 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 05:29:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA32C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 02:27:55 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u18so23477532lfd.12
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 02:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+BiVon36R7osiym203n8QdAltzwM2ixXRPT87J4UnsI=;
        b=HQeVI8+v++7oyihrm9kbLJLfeU1D1HiKiu1ZhmOSJgRRkP7fH47QvLT0fQbvkNp0c8
         MyiZTj5nTsPEpWm1IrYRJ04XrvKzQz48EnFjFZGPO168MdfsTpo2/c64ZDjjrUS9tQqG
         HSghaZA6A+YGYJiFO9x7vmj0YHeQoGCLcgn1HuY4aKO7n6hs6zYx7MEZ78LQXylFsn9K
         YfYiztpMuVG07JCuRGeuN7rYbBP3iFyso3iLPKAAWWwezljJ5IRErGRQxO5bZm1xIgbG
         DO+FBxjKR/pWaiOlsO6IhUPMj0eDIiCvynpekamTDlsbmPUICa/y1ycnyHa/i6ou5xW2
         sYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+BiVon36R7osiym203n8QdAltzwM2ixXRPT87J4UnsI=;
        b=vPUOANarSx0GuOwYh2n69hDUwsxj5MqZ2kIt5OUT/FYT/5NcTiYYVFgMJyNmOit0jE
         NfZ1R5sEKwxIfgUKQc/ITbCbla7WttOKlnseDnDQS5R1PpS36C2vO1Vk6ohqLpEg3NIn
         YZGPJ36s4Hewqq9IIq31FfPRgqx0/wxpAWNYU1UC503TeIuqozwF7Ra/NdCkJ17i+ono
         zSD/OVbk+8OEOQvtt7HJsRh8vy0xmCYA5qygmGZP8xIytAJ4bKlma64/kZH4LZh8ITC9
         lYfbaWPj/RLbcE1tzsxTbuimwrxX9eDMfoRabYYL4Q4MIuJrntk4w0hLwUOOOuI96YUG
         L4dw==
X-Gm-Message-State: AOAM531kiq7yws9YXNsZwMVlUhcxXCEZzMWarUj6v3b15CVJOqeIy+Ar
        RJjwEyXmt0ZLCAaUtbL+WL/7pajREyXWG50zglvE7W8Y
X-Google-Smtp-Source: ABdhPJzxcVNaDcgx2rVIDvS1yOKsnoipiCjgelusapJjirDj4ZyXWycBky7mn2aSvxivTcAq3rRmKl581nYmaQmi7zo=
X-Received: by 2002:a2e:9a09:: with SMTP id o9mr4117022lji.218.1632389273398;
 Thu, 23 Sep 2021 02:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAGqt0zz9YrxXPCCGVFjcMoVk5T4MekPBNMaPapxZimcFmsb4Ww@mail.gmail.com>
 <e45e799c-b41a-d8c7-e8d8-598d81602369@gmx.com> <CAGqt0zyEx1pyStPVTSnvsZGYKAGEv9yUunv-82Mj6ZED3WNKRA@mail.gmail.com>
 <CAGqt0zy6a8+awo6ifUn4x+WxN=c6e8PnuMW5kYRodxOQ6vwU-A@mail.gmail.com>
 <72d66f13-6380-7fcd-3475-8152caa965c4@gmx.com> <CAGqt0zz+=nUYbNwLSPYwzYcNLgyxsWT22p+jwwFpAOcyAHAWgA@mail.gmail.com>
In-Reply-To: <CAGqt0zz+=nUYbNwLSPYwzYcNLgyxsWT22p+jwwFpAOcyAHAWgA@mail.gmail.com>
From:   Yuxuan Shui <yshuiv7@gmail.com>
Date:   Thu, 23 Sep 2021 10:27:41 +0100
Message-ID: <CAGqt0zwAM5fANtn2hYeFz7_LLRoR11c_XGVYieOeAauCLF79gw@mail.gmail.com>
Subject: Fwd: btrfs receive fails with "failed to clone extents"
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

(Sorry I forgot to CC linux-btrfs)

On Thu, Sep 23, 2021 at 3:32 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/9/23 09:40, Yuxuan Shui wrote:
> > On Thu, Sep 23, 2021 at 2:34 AM Yuxuan Shui <yshuiv7@gmail.com> wrote:
> >>
> >> Hi,
> >>
> >> On Thu, Sep 23, 2021 at 12:24 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>>
> >>>
> >>>
> >>> On 2021/9/23 03:37, Yuxuan Shui wrote:
> >>>> Hi,
> >>>>
> >>>> The problem is as the title states. Relevant logs from `btrfs receive -vvv`:
> >>>>
> >>>>     mkfile o119493905-1537066-0
> >>>>     rename o119493905-1537066-0 ->
> >>>> shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h
> >>>>     utimes shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include
> >>>>     clone shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h
> >>>> - source=shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h
> >>>> source offset=0 offset=0 length=131072
> >>>>     ERROR: failed to clone extents to
> >>>> shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h:
> >>>> Invalid argument
> >>>>
> >>>> stat of shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h,
> >>>> on the receiving end:
> >>>>
> >>>>     File: /mnt/backup/home/backup-32/shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h
> >>>>     Size: 145904 Blocks: 288 IO Block: 4096 regular file
> >>>>
> >>>> Looks to me the range of clone is within the boundary of the source
> >>>> file. Not sure why this failed?
> >>>
> >>> The most common reason is, you have changed the parent subvolume from RO
> >>> to RW, and modified the parent subvolume, then converted it back to RO.
> >>
> >> This is 100% not the case. I created these snapshots as RO right
> >> before sending, and definitely haven't
> >> changed them to RW ever.
> >
> > Besides that, I straced the btrfs command and this clone ioctl
> > definitely looks valid, irregardless of whether the parent snapshot
> > has been changed or not. The length looks to be aligned (128k), and
> > the range is within the source file. Why did the clone fail?
>
> The clone source must not have certain bits like NODATACOW.

lsattr doesn't show anything. The entire file system is mounted with
nodatasum, though. But I assume if this bit is the problem, send won't
fail just on this particular file?

>
> If non-incremental send stream works, then it's almost certain it's the
> received UUID bug we're working on.

I haven't tried non-incremental. If by received UUID bug you meant
this one: https://lore.kernel.org/linux-btrfs/87blnsuv7m.fsf@gmail.com/T/
, then I don't think this is the one. I don't have duplicated received
UUIDs on either end.

>
> Thanks,
> Qu
>
> >
> >>
> >>>
> >>> Btrfs should not allow such incremental send at all.
> >>>
> >>> We're already working on such problem, but next time if you want to
> >>> modify a RO subvolume which could be the parent subvolume of incremental
> >>> send, please either do a snapshot then modify the snapshot, or just
> >>> don't do it.
> >>>
> >>> Thanks,
> >>> Qu
> >>>
> >>>>
> >>>> Sending end has 5.14.6 and btrfs-progs 5.14, receiving end has 5.14.6
> >>>> and btrfs-progs 5.13.1
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



--

Regards
Yuxuan Shui
