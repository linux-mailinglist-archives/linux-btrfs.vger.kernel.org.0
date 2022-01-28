Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FB849F8D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 12:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiA1L4G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 06:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiA1L4F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 06:56:05 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DD1C061714
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 03:56:05 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id y84so7460513iof.0
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 03:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RKfvz4jNJ8mwGIIXXsmQmNZMkxdJWl9QaUiyu0zD53o=;
        b=nIkIG0EZNE63XKKMKNQzc5duHXjw2n5WWG6PoPI902+MSPRfJih4QfnAizaF1pynfI
         4Da02Ik1kzAjOYHktWHY6VtWhI0k/GoVmv28p8Sm79Y07ZH+H9Yr48ZaVzIP4zlOyaOy
         DLFepcNDgDoUXIPXxKTcIgwuO5f3TP+7o+6P6kakOEekLoDZe+PnFZ8e+xNxDiZq3AU6
         bpqiaOUFquPYtA55Tk1YdWE+5cV2cLWs1RpFdvwexsZQPG6fU0JCDls38RH3fq0tFd43
         HkT2m/DXQD48UXBP/WA7nXL5NVmQbLabFT5I8rl1nPHGv5Wm8yF5MqdKtVQa5L+tmYxB
         Rasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RKfvz4jNJ8mwGIIXXsmQmNZMkxdJWl9QaUiyu0zD53o=;
        b=a0cw4bX+wK1d+LwU99UYlFnLFR3pYthDBB9wNzqiLJ1MlqV/yAjB7adbkxY05I6OTQ
         /aHUF2/iwphuktMIz13NtolhmxL373keZJDRIFw0ee0TXL/sdxFCjan0OV4kjKlgaPmj
         OWbytSirwS49FyywmWo0NJ+gn9zu/d1VwPbuwrHufzpJP7kXpd9VKlKRiq84PGqeF87v
         FUFocFnQx/AzXfDM/2uRWXplb3J+XZbm3cZawrxyMS88XP7Le7PRNKcTM6XJZ1EFEYgg
         DK2ztEYpL/D5KrYcXzj0S3+DfeLS/yWHty1lcvLOVeRdWrfZu0WH3T49TZBUb0732/3Y
         Zijw==
X-Gm-Message-State: AOAM5324ulvGa63L6IX7qoxDX5mnHyydklddmp84LgIx5dWCMCX8nJFw
        FVfWPXjdKjEJglav5+ODw0EQBW4wlwVPZiJZB8AK6Iek
X-Google-Smtp-Source: ABdhPJxFfDMH8UfgKNDRUFuYJNMNp8bs59fZUHP5UpPrc8v6lnHoKlyTep4OyomCHBT6yxfqzJoPqvKmUnyJgWsjLO0=
X-Received: by 2002:a02:7754:: with SMTP id g81mr4210140jac.153.1643370965096;
 Fri, 28 Jan 2022 03:56:05 -0800 (PST)
MIME-Version: 1.0
References: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com>
In-Reply-To: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com>
From:   Kai Krakow <hurikhan77+btrfs@gmail.com>
Date:   Fri, 28 Jan 2022 12:55:39 +0100
Message-ID: <CAMthOuOg8SVYrehoS4VS=Gj4paYyobmqX85bKzGxYcG-2oJBDA@mail.gmail.com>
Subject: Re: fstab autodegrag with 5.10 & 5.15 kernels, Debian?
To:     piorunz <piorunz@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

Am Fr., 28. Jan. 2022 um 08:51 Uhr schrieb piorunz <piorunz@gmx.com>:

> Is it safe & recommended to run autodefrag mount option in fstab?

I've tried autodefrag a few times, and usually it caused btrfs to
explode under some loads (usually databases and VMs), ending in
invalid tree states, and after reboot the FS was unmountable. This may
have changed meanwhile (last time I tried was in the 5.10 series).
YMMV. Run and test your backups.


> I am considering two machines here, normal desktop which has Btrfs as
> /home, and server with VM and other databases also btrfs /home. Both
> Btrfs RAID10 types. Both are heavily fragmented. I never defragmented
> them, in fact. I run Debian 11 on server (kernel 5.10) and Debian
> Testing (kernel 5.15) on desktop.

Database and VM workloads are not well suited for btrfs-cow. I'd
consider using `chattr +C` on the directories storing such data, then
backup the contents, purge the directory empty, and restore the
contents, thus properly recreating the files in nocow mode. This
allows the databases and VMs to write data in-place. You're losing
transactional guarantees and checksums but at least for databases,
this is probably better left to the database itself anyways. For VMs
it depends, usually the embedded VM filesystem running in the images
should detect errors properly. That said, qemu qcow2 works very well
for me even with cow but I disabled compression (`chattr +m`) for the
images directory ("+m" is supported by recent chattr versions).


> Running manual defrag on server machine, like:
> sudo btrfs filesystem defrag -v -t4G -r /home
> takes ages and can cause 120 second timeout kernel error in dmesg due to
> service timeouts. I prefer to autodefrag gradually, overtime, mount
> option seems to be good for that.

This is probably the worst scenario you can create: forcing
compression forces extents to be no bigger than 128k, which in turn
increases IO overhead, and encourages fragmentation a lot. Since you
are forcing compression, setting a target size of 4G probably does
nothing, your extents will end up with 128k size.

I also found that depending on your workload, RAID10 may not be
beneficial at all because IO will always engage all spindles. In a
multi-process environment, a non-striping mode may be better (e.g.
RAID1). The high fragmentation would emphasize this bottleneck a lot.


> My current fstab mounting:
>
> noatime,space_cache=v2,compress-force=zstd:3 0 2
>
> Will autodefrag break COW files? Like I copy paste a file and I save
> space, but defrag with destroy this space saving?

Yes, it will. You could run the bees daemon instead to recombine
duplicate extents. It usually gives better space savings than forcing
compression. Using forced compression is probably only useful for
archive storage, or when every single byte counts.


> Also, will autodefrag compress files automatically, as mount option
> enforces (compress-force=zstd:3)?

It should, but I never tried. Compression is usually only skipped for
very small extents (when it wouldn't save a block), or for inline
extents. If you run without forced compression, a heuristic is used
for whether compressing an extent.


Regards,
Kai
