Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EDD3B0774
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 16:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhFVOfw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Jun 2021 10:35:52 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:59462 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhFVOfv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Jun 2021 10:35:51 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 668781E00705;
        Tue, 22 Jun 2021 17:33:34 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1624372414; bh=uYB4l+Ger4n19MjkjZ8oCvj2b1eaye1WMdTcopNi6kI=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=W9guDbVD5Dver4mugvfIc6RuXaSkWrc7BgmAtJrBX06UHU156royE+A8BopOlBMXn
         XVfJI7BlINQ+/kkfQr9/V9ELzu6kSedLx+agAz15Ye6//Va+eOZw7hCXALRvKGzfY0
         t2HWrEphCkHBLDYrxgL4NGmELtnXLWrG41NuTK3Q=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 5CA291E006E6;
        Tue, 22 Jun 2021 17:33:34 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id G6Ck7wInTk3G; Tue, 22 Jun 2021 17:33:32 +0300 (EEST)
Received: from mail.inbox.eu (unknown [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 170241E006CD;
        Tue, 22 Jun 2021 17:33:32 +0300 (EEST)
Received: from nas (unknown [153.127.9.202])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 42CB31BE0097;
        Tue, 22 Jun 2021 17:33:29 +0300 (EEST)
References: <CAJ9tZB_kPgZCsBaoOV93G9UCabdPifUxks+RH0e6RUycJ5wMCA@mail.gmail.com>
User-agent: mu4e 1.5.8; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     =?utf-8?B?5ZC05oyv5a6H?= <wuzy001@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [question] free space of disk with btrfs is too different from
 other du
Date:   Tue, 22 Jun 2021 22:31:41 +0800
In-reply-to: <CAJ9tZB_kPgZCsBaoOV93G9UCabdPifUxks+RH0e6RUycJ5wMCA@mail.gmail.com>
Message-ID: <bl7yotou.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: OK
X-ESPOL: 885mlY9NBD+mjUCoXXneBxpE3Cc6IvGHiOq4zH8tkXr8MS+GdksMVBar7hJ7DSP4og==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Tue 22 Jun 2021 at 21:02, =E5=90=B4=E6=8C=AF=E5=AE=87 <wuzy001@gmail.com=
> wrote:

> Sorry for my disturbance!
>
> my disk with btrfs filesystem tell me it doesn't have enough=20
> free space:
>
> ```
> $ sudo btrfs fi df /
> Data, single: total=3D448.02GiB, used=3D427.74GiB
> System, DUP: total=3D8.00MiB, used=3D64.00KiB
> Metadata, DUP: total=3D8.80GiB, used=3D6.39GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> $ sudo btrfs fi usage /
> Overall:
>     Device size:                 465.64GiB
>     Device allocated:            465.63GiB
>     Device unallocated:            1.00MiB
>     Device missing:                  0.00B
>     Used:                        440.54GiB
>     Free (estimated):             20.26GiB      (min: 20.26GiB)
>     Data ratio:                       1.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>     Multiple profiles:                  no
>
> Data,single: Size:448.02GiB, Used:427.76GiB (95.48%)
>    /dev/sda2     448.02GiB
>
> Metadata,DUP: Size:8.80GiB, Used:6.39GiB (72.60%)
>    /dev/sda2      17.60GiB
>
> System,DUP: Size:8.00MiB, Used:64.00KiB (0.78%)
>    /dev/sda2      16.00MiB
>
> Unallocated:
>    /dev/sda2       1.00MiB
> $ sudo btrfs fi show /
> Label: none  uuid: 644a9e91-5e05-4f5d-a79b-e0eccd21a1a8
>         Total devices 1 FS bytes used 434.14GiB
>         devid    1 size 465.64GiB used 465.63GiB path /dev/sda2
>
> $ df -Th
> Filesystem     Type      Size  Used Avail Use% Mounted on
> devtmpfs       devtmpfs  3.8G     0  3.8G   0% /dev
> tmpfs          tmpfs     3.9G   46M  3.8G   2% /dev/shm
> tmpfs          tmpfs     3.9G  3.9M  3.9G   1% /run
> /dev/sda2      btrfs     466G  442G   21G  96% /
> tmpfs          tmpfs     3.9G  204K  3.9G   1% /tmp
> /dev/sda1      vfat      128M  125M  2.9M  98% /boot
> tmpfs          tmpfs     785M   16K  785M   1% /run/user/994
> tmpfs          tmpfs     785M   80K  785M   1% /run/user/1000
> ```
>
> however, i try to use gdu to scan my disk. it tell me
>
> ```
> $ sudo gdu /
>  gdu ~ Use arrow keys to navigate, press ? for help
>  --- / ---
>    49.9 GiB [#####     ] /usr
>    15.1 GiB [#         ] /home
>    11.1 GiB [#         ] /opt
>     6.5 GiB [          ] /var
>   930.8 MiB [          ] /lib
>   124.9 MiB [          ] /boot
>    55.2 MiB [          ] /root
>    50.6 MiB [          ] /etc
>    27.1 MiB [          ] /sbin
>    23.5 MiB [          ] /lib64
>    10.9 MiB [          ] /bin
> . 312.0 KiB [          ] /tmp
>    20.0 KiB [          ] /mnt
> e   4.0 KiB [          ] /srv
> e   4.0 KiB [          ] /tftproot
> @   4.0 KiB [          ] media
>  Total disk usage: 83.8 GiB Apparent size: 78.4 GiB Items:=20
>  2424046
> Sorting by: size desc
> ```
>
> 427.76GiB or 83.8 GiB!
>
Maybe your fs have some snapshots?
Try:

btrfs subvolume list /

--
Su

> i know btrfs is a CoW filesystem, which means it will cost more=20
> space
> to store a file. but the gap is too large, which it is hard to=20
> accept
> the fact.
> who can tell me what happened to my disk? and how can i do to=20
> rescue
> my hard disk? the rest free space is not enough. if i cannot=20
> find the
> solution, maybe i should format my hard disk to get more free=20
> space.
> thanks.
>
> there are some information which maybe useful.
>
> ```
> $ uname -r
> 5.11.7-gentoo-x86_64
> $ btrfs --version
> btrfs-progs v5.9
> $ dmesg > dmesg.txt && wgetpaste -s dpaste dmesg.txt
> Pasting > 25 kB often tend to fail with dpaste. Use --verbose or
> --debug to see the
> error output from wget if it fails. Alternatively use another=20
> pastebin service.
> Your paste can be seen here: https://dpaste.com/FCZF83YYA
> ```
