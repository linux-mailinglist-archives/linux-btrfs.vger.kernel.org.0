Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58A7415525
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 03:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbhIWBgf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 21:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbhIWBgf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 21:36:35 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F35C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 18:35:04 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g41so19635494lfv.1
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 18:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PADN15KgWCp8iIlPoWHJG7Igt/x81PZMXJV0iBy1Ihg=;
        b=Kh5H0mcI7xu3sa7TZCdWV1veWgJsj0nh4h7A+DQO94i5/zW8dIVS0O+9LUz7BBuE1w
         ICT2vGj6bmE5rQJseQpLc88YWc771elq18YwBqyCmYOqU1BpPuRhwi6AvmorGKTlGEnO
         sww54mqiCBq1hDjfPSleT8IislRfXwKa2jEGVRSL4CXTfhhR8SnOpi4/3R4JaNeBeJni
         GXvDBzErbbfPRS9JXrrssm89PLVGu7ErDW2bGXztQiWqaDSko4zrNgF9z/6tDSj/5SSn
         5QHzAXC7bWCBfFeGTmoqgQhGWAg7g2G4G+krnkYRTqBqZrMoJlx1vAanIby5Z0C4ieSO
         evlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PADN15KgWCp8iIlPoWHJG7Igt/x81PZMXJV0iBy1Ihg=;
        b=rYfA/vg+jQYXnqMQmfaZGdvx4OnZc1yav4mDgcED13sZ5XsbgrgRdpdH42eEEI9U3g
         ZgaWUdcqNbpWKFuQydF6hj9Eo776/+Uu6+Sk2SnUNvRWFwQDTmmMAHV+jtX/KO+UBMdD
         laX4BkvcquwlyK/DMISsUavoKF9/HfYNIJFRnKMmAgLxRrHIWGgC7+5/QNWJ2KGXNAcn
         Jm3TGBHZqSIIAt5Tr5IfQbzdY1AtPnEo9OhAI8luQ13LUxVuxwcU4OuF/TW1IgsFheNs
         0nydqlwrAiHSGmdTM0JRsYOePgnuLi6TWzVT+jNfvIyQi06nuCjj7vD1nim/Zyx4+650
         PkbQ==
X-Gm-Message-State: AOAM531oHJYuhQDPs2AlJ7qjCn9fYCaAlSZhc0FNrh48v+oU0a64yk+Z
        C4gAWPBdDB4EmK+aSV4PVpOUkrIDfIpIO+STJveNr5hE
X-Google-Smtp-Source: ABdhPJxYxGXKvyzbbbVvd+BYVtQZ/XssYmn7Bl9Kxosc2R4lpIi9Bm+VCXVxd553pprVil76733LYsQrUmlBERx8Lu8=
X-Received: by 2002:a2e:80c6:: with SMTP id r6mr2463758ljg.58.1632360902511;
 Wed, 22 Sep 2021 18:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAGqt0zz9YrxXPCCGVFjcMoVk5T4MekPBNMaPapxZimcFmsb4Ww@mail.gmail.com>
 <e45e799c-b41a-d8c7-e8d8-598d81602369@gmx.com>
In-Reply-To: <e45e799c-b41a-d8c7-e8d8-598d81602369@gmx.com>
From:   Yuxuan Shui <yshuiv7@gmail.com>
Date:   Thu, 23 Sep 2021 02:34:50 +0100
Message-ID: <CAGqt0zyEx1pyStPVTSnvsZGYKAGEv9yUunv-82Mj6ZED3WNKRA@mail.gmail.com>
Subject: Re: btrfs receive fails with "failed to clone extents"
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On Thu, Sep 23, 2021 at 12:24 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/9/23 03:37, Yuxuan Shui wrote:
> > Hi,
> >
> > The problem is as the title states. Relevant logs from `btrfs receive -vvv`:
> >
> >    mkfile o119493905-1537066-0
> >    rename o119493905-1537066-0 ->
> > shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h
> >    utimes shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include
> >    clone shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h
> > - source=shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h
> > source offset=0 offset=0 length=131072
> >    ERROR: failed to clone extents to
> > shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h:
> > Invalid argument
> >
> > stat of shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h,
> > on the receiving end:
> >
> >    File: /mnt/backup/home/backup-32/shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h
> >    Size: 145904 Blocks: 288 IO Block: 4096 regular file
> >
> > Looks to me the range of clone is within the boundary of the source
> > file. Not sure why this failed?
>
> The most common reason is, you have changed the parent subvolume from RO
> to RW, and modified the parent subvolume, then converted it back to RO.

This is 100% not the case. I created these snapshots as RO right
before sending, and definitely haven't
changed them to RW ever.

>
> Btrfs should not allow such incremental send at all.
>
> We're already working on such problem, but next time if you want to
> modify a RO subvolume which could be the parent subvolume of incremental
> send, please either do a snapshot then modify the snapshot, or just
> don't do it.
>
> Thanks,
> Qu
>
> >
> > Sending end has 5.14.6 and btrfs-progs 5.14, receiving end has 5.14.6
> > and btrfs-progs 5.13.1
> >



-- 

Regards
Yuxuan Shui
