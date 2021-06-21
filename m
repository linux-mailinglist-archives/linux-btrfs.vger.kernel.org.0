Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C583AE1DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jun 2021 05:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhFUDaB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Jun 2021 23:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhFUDaA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Jun 2021 23:30:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70896C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 20:27:47 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j2so7320913wrs.12
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 20:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fjGZ+h6UAJj7ywHTXS6TOxzVIa2gcXNFKVPtW3B2CfQ=;
        b=rdPqyVQqELLISZrTDqgSAAHh03btS917PVH6danGxv7fDRMFusUbMLjgx7CG6aY7JL
         o05htQNr/Ok+Y6kiZHrDQdySKb3R6r6dWkq+OsSRkpVQQcutqzQsHFDWwRYnjxEVh51m
         UbQ4BHX3ImagXJ0Y4h3fiydn4QFnIC9hbqDoPEFjYiRZdBUn7tWhdoB2I1LF1cMiWfoP
         vXKalX76XSXy8QOAp+3LtPfnddHhVVHDK/HQrIEX6zzcqxmTI3qFP99KiJYGFj/4Exc6
         CxsWBX3CFsxPc9wDsMIhzFknh4iLOZOVuaIMrDxPpe84p5khCeqnH6c7M2/qOz5PS8PA
         hhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fjGZ+h6UAJj7ywHTXS6TOxzVIa2gcXNFKVPtW3B2CfQ=;
        b=c0QHZM+EnCI9RfLtcluk0G7NhOZ7oryv5STatrdnNC/NvPY1LgJrK92GXmcXUldaQ6
         5wlCf46bAvq6ys1DRixM+ebhvLq4uCcg8DyPZWLahxFKOmbb0NwToaEw05SzzS2DdsUH
         IqUZ3pcDszBJ//RFMV4q+cX1EnTCkirOhrAkK9SD8sj8llDQAlWTDq1aJnb7UNmE2l31
         a9o07hN8wSUHJofIb3XvLz8oHom4nqNkaLPaddCImoJibcvsW2mrge2QDJamPrvrv9zM
         Eio0VzNz4CvsojnBnmwtNy79WVotv54/6TbY/ZupgIgE926DvI6VY8OZvxrQj0Efjux1
         USbg==
X-Gm-Message-State: AOAM530/nN5Qky762DnLz4vEE4IglHED64tIf6FYWd3axuDl3FU47zAy
        k1zARFRVQWnV/7zZo9SqRctKsWP6q4S/MQwcuZPmYw==
X-Google-Smtp-Source: ABdhPJyuuptl2OKUO7F/NwilHcEG4avt5/tWeccEIeZwVHFl+JTjlswReMbBXGj6EI2zvI37Mrme0f4IOjtv2rrIXEY=
X-Received: by 2002:a05:6000:12c8:: with SMTP id l8mr6252365wrx.236.1624246065004;
 Sun, 20 Jun 2021 20:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
 <CAJCQCtSWxp+=nEJRFzEjEA0Lxt-rC+6Dq_CtpCNPmapzFw6WPA@mail.gmail.com>
 <ab0e8705-e18f-90eb-c42b-318c04a2101c@gmail.com> <CAJCQCtQXOgHTDAiGCWEN8_RaLNk26o9iDvtNcEBg9EVZ0yfdLg@mail.gmail.com>
 <CAHw5_hkJu-O8+F2WNFvab=z4LFfy2QYh0u6yr-CPmcSQHGjEXQ@mail.gmail.com>
In-Reply-To: <CAHw5_hkJu-O8+F2WNFvab=z4LFfy2QYh0u6yr-CPmcSQHGjEXQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 20 Jun 2021 21:27:28 -0600
Message-ID: <CAJCQCtSjJPh_jVJLK_esiK=HGOAmc4L-XByBN19RRq1mCbhFkQ@mail.gmail.com>
Subject: Re: Filesystem goes readonly soon after mount, cannot free space or rebalance
To:     Asif Youssuff <yoasif@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 20, 2021 at 8:04 PM Asif Youssuff <yoasif@gmail.com> wrote:
>
> > skip_balance,nospace_cache
>
> I did this in the mount that follows.
>
> [77763.027733] BTRFS info (device sde): balance: resume skipped
> [77763.027749] BTRFS info (device sde): checking UUID tree
> [78007.542667] ------------[ cut here ]------------
> [78007.542675] BTRFS: Transaction aborted (error -28)

So about 10 minutes.

But 'btrfs balance cancel' results in an immediate error and forced read only.


> btrfs fi us /media/camino/
> WARNING: RAID56 detected, not implemented
> Overall:
>     Device size:          96.42TiB
>     Device allocated:          75.24TiB
>     Device unallocated:          21.18TiB
>     Device missing:             0.00B
>     Used:              74.02TiB
>     Free (estimated):          15.30TiB    (min: 11.42TiB)
>     Data ratio:                  1.46
>     Metadata ratio:              1.00
>     Global reserve:         512.00MiB    (used: 1.61MiB)
>
> Data,RAID1: Size:37.59TiB, Used:36.98TiB
>    /dev/sda       5.70TiB
>    /dev/sdb       4.65TiB
>    /dev/sdc       5.80TiB
>    /dev/sdd       4.69TiB
>    /dev/sde       4.62TiB
>    /dev/sdf       5.41TiB
>    /dev/sdg      11.22TiB
>    /dev/sdj       6.32TiB
>    /dev/sdl       5.26TiB
>    /dev/sdm       5.71TiB
>    /dev/sdn       5.68TiB
>    /dev/sdo       4.01TiB
>    /dev/sdp       6.10TiB
>
> Data,RAID6: Size:13.77TiB, Used:13.75TiB
>    /dev/sda       1.56TiB
>    /dev/sdb     808.33GiB
>    /dev/sdc       1.46TiB
>    /dev/sdd     775.98GiB
>    /dev/sde     849.14GiB
>    /dev/sdf       2.07TiB
>    /dev/sdg       1.45TiB
>    /dev/sdj     964.87GiB
>    /dev/sdl       2.00TiB
>    /dev/sdm       1.56TiB
>    /dev/sdn       1.58TiB
>    /dev/sdo       2.37TiB
>    /dev/sdp       1.14TiB
>
> Metadata,single: Size:66.00GiB, Used:65.58GiB
>    /dev/sda      18.00GiB
>    /dev/sdb      14.00GiB
>    /dev/sdc      16.00GiB
>    /dev/sdd      15.00GiB
>    /dev/sde       9.00GiB
>    /dev/sdf      12.00GiB
>    /dev/sdg      66.00GiB
>    /dev/sdj      14.00GiB
>    /dev/sdl      15.00GiB
>    /dev/sdm      11.00GiB
>    /dev/sdn      18.00GiB
>    /dev/sdo      28.00GiB
>    /dev/sdp      28.00GiB
>
> System,single: Size:32.00MiB, Used:13.00MiB
>    /dev/sdf      32.00MiB
>    /dev/sdg      32.00MiB
>    /dev/sdl      32.00MiB
>    /dev/sdo      32.00MiB
>
> Unallocated:
>    /dev/sda       1.02MiB
>    /dev/sdb       1.02MiB
>    /dev/sdc       1.02MiB
>    /dev/sdd       1.02MiB
>    /dev/sde       1.02MiB
>    /dev/sdf       1.60TiB
>    /dev/sdg       3.44MiB
>    /dev/sdj       1.02MiB
>    /dev/sdl      14.09MiB
>    /dev/sdm       1.02MiB
>    /dev/sdn       1.02MiB
>    /dev/sdo     881.16GiB
>    /dev/sdp       1.02MiB


This output is slightly confusing because it's an older btrfsprogs
that doesn't fully understand raid1c4 or raid56.  But the gist is that
there's not enough space on 4 drives to create a metadata block group,
which it wants to do for some reason even though there's ~600MiB
available in metadata bg's currently.


> Before I emailed the list, I had tried to add a new disk - it never
> worked for me - I think because btrfs sees the balance operation in
> progress and the "add" won't complete with it.  I can try again, but
> was previously unsuccessful in adding a single device.

Well the balance operation is skipped, it shouldn't need to happen at
all. I'm not sure what's starting up 10 minutes later that results in
the error and flipping to read only. But yeah, whatever that is,
probably has a higher priority than device add.

Another remote possibility is doing a filtered balance that quickly
frees up space with minimal metadata writes. In fact, sdf and sdo
already have enough space; so you only need to free up enough space on
two devices to get btrfs to create a new metadata bg on those four.

This is part of upstream btrfs-progs, but isn't packaged by most
distros. Download that and set proper perms and run it.
https://github.com/kdave/btrfs-progs/blob/master/btrfs-debugfs

sudo ./btrfs-debugfs -b /mntpoint

You'll get a lot of output, and chances are your mua will wrap it
badly to the list so you might want to post it in a pastebin expiring
in a week or so. I figure the ideal block group would be one that is
(a) least full, and (b) raid1. So we also need the chunk tree to
figure that out. Point this command to any of the devices for this
btrfs and it'll output the chunk tree. Put that up in a pastebin also
for a week.

sudo btrfs insp dump-t -t chunk /dev/any




-- 
Chris Murphy
