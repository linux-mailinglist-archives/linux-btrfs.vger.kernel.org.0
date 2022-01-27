Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0747A49ED45
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 22:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiA0VOw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 16:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiA0VOv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 16:14:51 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B33C061714
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jan 2022 13:14:50 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id p5so12425170ybd.13
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jan 2022 13:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RUl17Pv1DlrsmWFZXPKsdvZER5XVmWklGowVlufmc0k=;
        b=zMnoVW1MmVJBK5HJDJFr4X0yc6Ilz9N1GIT1j/WxSLaTWbNgICdMI3kNtXm6g9v3cC
         6WbDZ8nhdg18RrSZNugLetsBqf+gDqcKnfsq2wG9iuRBgoVRaS55ICtYNh/cZxfoSc8S
         Kh2a1ERlTX2ltUU6XqU04jIHkF+OJgepefukn9YQ7WN6k7iLwFytUkQfMUjVfLIhBGUD
         CLrpRpTNVMLQF9FYX0vqgIB1W4sZP12U7kxSlnhquBAkL91/HZFz2aARxY9UobUT8bwg
         Pz7f0S7kwJ+TDcTDJdLoqh6oz/D7yEuo2nUV0nW3IOXBMN6Y1AZVAq2usGBctSYJiMyH
         N1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RUl17Pv1DlrsmWFZXPKsdvZER5XVmWklGowVlufmc0k=;
        b=Wmiv2IuTf8GeIXsN/6blVUw8rDnrK+PBjW5a9PlnNjZAyqFryiLzuXl+UQe1hc6oR5
         tfELstCNenGDPRuMLiQNfWfjwInBtdE1LmZ15DAf/WahTfRshmJntOpfCepCTOPCa/6P
         tlNmCwga227TY8L74SlURmqlyhbyvojUoST8AxgSEmopxO2kQppUGo9/4yVxagclgPHy
         p0ikLAm9rzQknlyuvJTQdyvB4QIXyu81Q0f1XW43EhGyEHpeq/WtsDTVz4hiLiWEqyuL
         tcbz5/q+Iee2r7ZVNY+hlQDw/3DlKHDvgCuticKkfqkDVK7YmJa/7m28syhg464NVGAd
         kUuQ==
X-Gm-Message-State: AOAM532P9ubstE/j4laBNkDpRfjf6cVxldHSbNDw+R/q0G/5TqcmbDK+
        fpwOsVKNa3IDAmCMTbDW304piGWwX7Q+LNLeFK5gFZrKowihdQ==
X-Google-Smtp-Source: ABdhPJz6u0we30wBwC+DsPka0b6ewRfQ9L0pdvS2u5AZQ6y7G6Y/Du1To1+zI1pcQC0Fzn26T3nW3VQumJm1esUw7/8=
X-Received: by 2002:a25:ba0a:: with SMTP id t10mr7297387ybg.509.1643318090088;
 Thu, 27 Jan 2022 13:14:50 -0800 (PST)
MIME-Version: 1.0
References: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com>
In-Reply-To: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 27 Jan 2022 14:14:34 -0700
Message-ID: <CAJCQCtSuVFMOtekSU_MENxku53bNgf841WDS6-sOh5ELaL40JA@mail.gmail.com>
Subject: Re: fstab autodegrag with 5.10 & 5.15 kernels, Debian?
To:     piorunz <piorunz@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 27, 2022 at 8:25 AM piorunz <piorunz@gmx.com> wrote:
>
> Hi all,
>
> Is it safe & recommended to run autodefrag mount option in fstab?

Yes. But it's intended for the desktop use case, with small database
files that tend to get heavily fragmented. It's not intended for
larger or active databases, or VMs, where the write pattern will
trigger autodefrag way too often. And autodefrag works by just
dirtying the entire file, causing the whole file to be submitted
through the normal write path. i.e. it's basically the same as just
duplicating the file and deleting the original. Therefore some
workloads will just trigger a ton of excessive writes, and slow
everything down. Hence, it's mainly for the desktop use case.


> I am considering two machines here, normal desktop which has Btrfs as
> /home, and server with VM and other databases also btrfs /home.

You probably don't want to use autodefrag. Instead you can configure
btrfsmaintenance to do a scheduled defragment on specific directories.


>Both
> Btrfs RAID10 types. Both are heavily fragmented. I never defragmented
> them, in fact. I run Debian 11 on server (kernel 5.10) and Debian
> Testing (kernel 5.15) on desktop.
>
> Running manual defrag on server machine, like:
> sudo btrfs filesystem defrag -v -t4G -r /home
> takes ages and can cause 120 second timeout kernel error in dmesg due to
> service timeouts. I prefer to autodefrag gradually, overtime, mount
> option seems to be good for that.

For VM images you could use a target length of 1-4 MiB instead of the
default 32 MiB. Is this on a spinning hard drive or SSD? Defragment is
more important as fragmentation leads to high latency.


> My current fstab mounting:
>
> noatime,space_cache=v2,compress-force=zstd:3 0 2

In this case you don't want the target extent size to be larger than
128 KiB. Compression extent size is up to 128 KiB. If you use a target
size bigger than this, it's not actually going to do much
defragmenting, it'll just submit a ton of extents to be rewritten
elsewhere and take a long time.


>
> Will autodefrag break COW files?

It's not so much that it breaks them as much as it'll get triggered
constantly while the file is in use - and performance will get worse.

Also, defragment is not reflink/snapshot aware. So any directories
you're regularly defragmenting you might want to exclude from
snapshots. The autodefrag use case (web browser type workloads) are
small enough files that duplicating the extents upon defragmenting
them isn't a big problem like it is with large files suddenly no
longer being deduped (via relink copy or snapshot).



-- 
Chris Murphy
