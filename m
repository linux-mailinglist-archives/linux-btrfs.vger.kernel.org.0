Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77133B2BD1
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jun 2021 11:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbhFXJzD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Jun 2021 05:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhFXJzC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Jun 2021 05:55:02 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73F8C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Jun 2021 02:52:42 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id ay19so1165629vkb.9
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Jun 2021 02:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2It1T18OIRYC5/gl/kfge/jPToDBcWLJrAo7V6/PciE=;
        b=amxRz8bPTGnkm2DLgzQdlCi8ibof62BUDyXQLQcB9rECAR0vkE3mh117SLxhD6Qde9
         otXSenS1Xs4roeM3Dq0gLiDJOx7FuDOwjyjqckGeVr6BkBJVUPX/ZxRat/x3kXP8e1ZJ
         q7EsZGFgfWyxwoQyyntzE6pq5Im4Cdvv79XRTqwk3tFR0URk2Buhz9tribiPHqHwvuUH
         fnEEkbmSLhda0S4tFBp6X+W8LmRnJRlI4DOO75LZENP8ECHBx5kQQ+u6+8rGnu0Pglcg
         UdJnaTGqYLBcOcpw3XS2u4R+TDdqCzfYNahabKjtG+HpPr/wE/rmcxLcnaEOldZU5d8l
         cLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2It1T18OIRYC5/gl/kfge/jPToDBcWLJrAo7V6/PciE=;
        b=WmN/vFUk6qASbcQClQpIqnNtezeP6y2PZ1VKm0UhCIvXgXX0c5KZjWV455J1I35Ehn
         EDzPURsu4ybv+L5JVVMy1K2PQYE67Yk2k1pa8grDMW3z1jL9sAxRPzBsO/h7EhJmpfjS
         BXixFVgMR0zZDkcb36YJr6lFFQud8s9FU0l5MwX5+QBnl2+gdTvmsGbmL9LxLt9bykZ5
         41GMTuhE4CTCl+7AGICU2rFhn3YiA7XsxXiMttQ7jTSGIkNX7auz5hCiKTN5DZvhP441
         TsHobwAoO2pdzXJ0ckY7BmsNT65sXvsCSTNWylz6S6VyO2/xkrROqAaJGg2yzV56nmzZ
         aq4g==
X-Gm-Message-State: AOAM5334I2V0l1bMwJMKR2LwnhcV6dlY5Es1CqWSJWtzZY1AWHeUwMUj
        0DAXgN2QYSXGQymWmiSt066DMSqxYye/5vLQW/I=
X-Google-Smtp-Source: ABdhPJw3sjJzYeh6lQMj4X7vvX8yVHiMgDZm+SmQj4Unf+2fMTm37tJIGjbdRthfdVJRc4Xq9JryXzmfeCJ54hvsiFI=
X-Received: by 2002:a05:6122:994:: with SMTP id g20mr988212vkd.15.1624528361684;
 Thu, 24 Jun 2021 02:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ9tZB_kPgZCsBaoOV93G9UCabdPifUxks+RH0e6RUycJ5wMCA@mail.gmail.com>
 <bl7yotou.fsf@damenly.su> <CAJ9tZB9M=KOWVLH_azagtBnxDzpV2=ssnBcYsJx6Ao8cQOELhg@mail.gmail.com>
 <5yy5orgi.fsf@damenly.su> <CAJ9tZB8UjSYCmvLRJ19zyKWyXD=Qp1Am0mFPc=dY8QRgMxcPiA@mail.gmail.com>
 <900f5c2c-9058-54d4-bdc8-a32c37dd8bdc@gmx.com> <93eeea80-a5af-fc14-ec71-e111d801eff4@gmx.com>
 <CAJ9tZB8Y+yNoTQmEjuV3f9QL05+=abJ-Ue4m7iRkxAC0NDhTFw@mail.gmail.com> <3670289c-19fb-482f-d2ca-3c84eb5decbe@cobb.uk.net>
In-Reply-To: <3670289c-19fb-482f-d2ca-3c84eb5decbe@cobb.uk.net>
From:   Zhenyu Wu <wuzy001@gmail.com>
Date:   Thu, 24 Jun 2021 17:52:30 +0800
Message-ID: <CAJ9tZB-7ogKcPCF=r72jJ3pvZLD3h6VfQbks-pfkB5N_yhJzTg@mail.gmail.com>
Subject: Re: [question] free space of disk with btrfs is too different from
 other du
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Su Yue <l@damenly.su>, linux-btrfs@vger.kernel.org,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

i have rescan quota but it looks like nothing change...
```
$ sudo btrfs quota rescan -w /
quota rescan started
# after 8m39s
$ sudo btrfs qgroup show -pcre /
qgroupid         rfer         excl     max_rfer     max_excl parent   child
--------         ----         ----     --------     -------- ------   -----
0/5          81.23GiB      6.89GiB         none         none ---      ---
0/265           0.00B        0.00B         none         none ---      ---
0/266           0.00B        0.00B         none         none ---      ---
0/267           0.00B        0.00B         none         none ---      ---
0/6482          0.00B        0.00B         none         none ---      ---
0/7501       16.00KiB     16.00KiB         none         none ---      ---
0/7502       16.00KiB     16.00KiB         none         none 255/7502 ---
0/7503       16.00KiB     16.00KiB         none         none 255/7503 ---
1/0             0.00B        0.00B         none         none ---      ---
255/7502     16.00KiB     16.00KiB         none         none ---      0/7502
255/7503     16.00KiB     16.00KiB         none         none ---      0/7503
```

and i try to mount with option subvolid:
```
$ mkdir /tmp/fulldisk
$ sudo mount -o subvolid=5 /dev/sda2 /tmp/fulldisk
$ ls -lA /tmp/fulldisk
total 4
drwxr-xr-x 1 root   root   1936 May  3 21:34 bin
drwxr-xr-x 1 root   root      0 Jan 25  2020 boot
drwxr-xr-x 1 root   root   1686 Jan 20  2020 dev
drwxr-xr-x 1 wzy    wzy    5756 Jun 24 13:51 etc
drwxr-xr-x 1 root   root     22 Oct 17  2020 home
drwxr-xr-x 1 root   root   1332 May 18 14:13 lib
drwxr-xr-x 1 root   root   6606 May 18 14:13 lib64
lrwxrwxrwx 1 root   root     10 Jan 24 20:23 media -> /run/media
drwxr-xr-x 1 wzy    wzy      38 Jan 27 16:51 mnt
drwxr-xr-x 1 root   root    234 Jun 18 14:29 opt
drwxr-xr-x 1 root   root      0 Jan 20  2020 proc
drwx------ 1 wzy    wzy     536 Jun 15 20:26 root
drwxr-xr-x 1 root   root     48 May 30 14:14 run
drwxr-xr-x 1 root   root   4926 May 18 14:12 sbin
drwxr-xr-x 1 root   root     10 Jan 20  2020 sys
drwxrwxrwx 1 nobody nobody    0 Jun 18 14:34 tftproot
drwxrwxrwt 1 root   root      0 May 30 14:25 tmp
drwxr-xr-x 1 root   root    198 Mar 31 19:32 usr
drwxr-xr-x 1 root   root    150 Apr  1 18:21 var
$ sudo btrfs fi du -s /tmp/fulldisk/*
     Total   Exclusive  Set shared  Filename
  10.66MiB       0.00B    10.66MiB  /tmp/fulldisk/bin
     0.00B       0.00B       0.00B  /tmp/fulldisk/boot
     0.00B       0.00B       0.00B  /tmp/fulldisk/dev
  33.34MiB    36.00KiB    33.30MiB  /tmp/fulldisk/etc
  13.79GiB   784.05MiB    12.96GiB  /tmp/fulldisk/home
 922.28MiB       0.00B   922.28MiB  /tmp/fulldisk/lib
  23.11MiB       0.00B    23.11MiB  /tmp/fulldisk/lib64
ERROR: cannot check space of '/tmp/fulldisk/media': Inappropriate
ioctl for device
     0.00B       0.00B       0.00B  /tmp/fulldisk/mnt
  11.08GiB       0.00B    11.08GiB  /tmp/fulldisk/opt
     0.00B       0.00B       0.00B  /tmp/fulldisk/proc
  40.38MiB     4.35MiB    36.03MiB  /tmp/fulldisk/root
     0.00B       0.00B       0.00B  /tmp/fulldisk/run
  26.62MiB       0.00B    26.62MiB  /tmp/fulldisk/sbin
     0.00B       0.00B       0.00B  /tmp/fulldisk/sys
     0.00B       0.00B       0.00B  /tmp/fulldisk/tftproot
     0.00B       0.00B       0.00B  /tmp/fulldisk/tmp
  47.22GiB     1.03GiB    46.15GiB  /tmp/fulldisk/usr
   5.80GiB     4.35GiB     1.45GiB  /tmp/fulldisk/var
```

because media is a symbolic link so the ERROR should be normal.
according to `btrfs fi du` it looks like i only use about 80GiB. it is
too weird.
thanks!

On Thu, Jun 24, 2021 at 4:32 PM Graham Cobb <g.btrfs@cobb.uk.net> wrote:
>
> On 24/06/2021 08:45, Zhenyu Wu wrote:
> > Thanks! this is some information of some programs.
> > ```
> > # boot from liveUSB
> > $ btrfs check /dev/sda2
> > [1/7] checking root items
> > [2/7] checking extents
> > [3/7] checking free space cache
> > [4/7] checking fs roots
> > [5/7] checking only csums items (without verifying data)
> > [6/7] checking root refs
> > [7/7] checking quota groups
> > # after mount /dev/sda2 to /mnt/gentoo
>
> Did you do 'mount -o subvolid=5 /dev/sda2 /mnt/gentoo' to make sure you
> can see all subvolumes, not just the default subvolume? I guess it
> doesn't matter for quota, but it matters if you are using tools like du.
>
> You don't even need to use a liveUSB. On your normal mounted system you
> can do...
>
> mkdir /tmp/fulldisk
> mount -o subvolid=5 /dev/sda2 /tmp/fulldisk
> ls -lA /tmp/fulldisk
>
> to see if there are other subvolumes which are not visible in /
