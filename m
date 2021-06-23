Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BC13B1938
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 13:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhFWLsg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 07:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFWLsf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 07:48:35 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52189C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 04:46:17 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id z7so1258842vso.3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 04:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=awpXh9nRuaQS34Uo0lIb1JCd5+870aFAROEFAoYu3gs=;
        b=MANMRC63Fkf2KV4WWqLOgVN2BXAojIdF1QuxCBZ2FSucItwH7syN8mwIL5Qy2gH4wq
         ofyCzndE7wPjFynIgulgq8uk9+Prmh7w5VehTlfLz9umI/Kxg79FWqVPzo3U3Mh04DlL
         PfAwu6bEnwGthquWUcruckAg27AUQOo8y3nWa886RQwFb3h8yiagIKPtvyJKi9/otVJx
         73dX2cXCgpkBo8t4krP5xB6AlLkh4QEklycCREimNaJURf/DA6jzQgWs8BeVpD4KFU5K
         Q0mPLWhuSq+qYGlBgRGD0gYB3Rp/d2dPDfvp9K2KD/uIVSRyon/4QEm/cRWHNCpSGMfk
         ZBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=awpXh9nRuaQS34Uo0lIb1JCd5+870aFAROEFAoYu3gs=;
        b=H+X1XLDioDxDWrHXmp4AH8j7whg918ZpIEmcfM5HAEHTBQReyjG72IDbY+eZ8fp2Vv
         qsHJ/bayZ41jYaCrNCNMMTT38ClzV8qDstniauFSX8f2hAMQVwV9byHFevaCSC93RPnG
         8FBmTECcdxsSTYxH+SJAk+f4VpuRBm2TNaTUAQDGO0LtjRJ9hrdc5swDhZ+UoCx4Wn8+
         pKTxVDGk18tjrPXXlzMvDd+CnB5VDa0ym4Ho/T7NJb3UtbWESR4EUyncO3UuqS00QJ0v
         bPkPlHkitZo2NGV+WEqGx7fS7zF7GBJxgJ07xrYfZir4+hNRkTXDzLZDKwBvY6ZZeBMP
         8JRQ==
X-Gm-Message-State: AOAM533a1u+DBSJwx3fn/lpgWz6RqyXNTRS3gDZruc8b4WqCaIsYFq9u
        3rOMNrqXGKrCjcD02COktzTuSRTmI58K0//Wr2g=
X-Google-Smtp-Source: ABdhPJzc09ID7HLbHKi7jrkibJPS/6txlX/GBjLFbUqbTAZWGez8fjWpjuXqMuJ+UoAdlb1TAx+NTufKdQ/d2YQjv5g=
X-Received: by 2002:a05:6102:2144:: with SMTP id h4mr27569432vsg.21.1624448776450;
 Wed, 23 Jun 2021 04:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ9tZB_kPgZCsBaoOV93G9UCabdPifUxks+RH0e6RUycJ5wMCA@mail.gmail.com>
 <bl7yotou.fsf@damenly.su> <CAJ9tZB9M=KOWVLH_azagtBnxDzpV2=ssnBcYsJx6Ao8cQOELhg@mail.gmail.com>
 <5yy5orgi.fsf@damenly.su>
In-Reply-To: <5yy5orgi.fsf@damenly.su>
From:   =?UTF-8?B?5ZC05oyv5a6H?= <wuzy001@gmail.com>
Date:   Wed, 23 Jun 2021 19:46:05 +0800
Message-ID: <CAJ9tZB8UjSYCmvLRJ19zyKWyXD=Qp1Am0mFPc=dY8QRgMxcPiA@mail.gmail.com>
Subject: Re: [question] free space of disk with btrfs is too different from
 other du
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for your tips! i forgot to CC linux-btrfs when reply you. sorry.

i believe this problem which my disk is out of memory does not occur
suddenly. before i notice this problem, i use snapper with its default config
to make snapshot for my btrfs filesystem. snapper will create many snapshots
so i don't detect that how much is the true free space (without snapshots),
and when the disk is out of memory. every time i feel the free space is too
small, i will `snapper delete` some snapshots. but the free space of my disk
still decrease inappearently.

about ten days ago, after one compter crash (system freeze), i press power
button to try to restart it. before this time, the same thing has happened
not only one time, but this time is different. after restart, the OS cannot
work -- after dmesg print (these information comes from my mobile photos)
```
[4.941061] BTRFS info (device sda2): disk space caching is enabled
[4.941549] BTRFS info (device sda2): has skinny extents
[11.937528] BTRFS info (device sda2): start tree-log replay
```

after about 200 seconds, it print more information
```
[259.503140] BTRFS: error (device sda2) in btrfs_replay_log:2254:
errno=-22 unknown (Failed to recover log tree)
# this line occur many times
[273.XXXXXX] BTRFS warning (device sda2): page private not zero on
page 85809XXXXXX
[273.478984] BTRFS error (device sda2): open_ctree failed
```

perhaps i should seek for help that time, but i think i should try to solve
this problem by myself first to avoid disturb other one. after boot my
computer from liveUSB, then I try to mount /dev/sda2, but failed. then i try
to `btrfs check /dev/sda2` but not use `--repair` because `--repair` is so
dangerous. it tell me some error like 100, 200, 1.
i try to
```
btrfs rescue chunk-recovery /dev/sda2
btrfs rescue super-recovery /dev/sda2
```
but still cannot mount /dev/sda2. at last,
```
btrfs rescue zero-log /dev/sda2
```
work and i can mount /dev/sda2. then i can reboot my OS without liveUSB.
after then, i use `find -inum XXX` to search that file which inode is error
100, and found they are `~/.cache/google-chrome/Default/Code\ Cache/js/XXXXXX`
and delete them.

after that time, i doubt my filesystem is not normal. and try to use some du
tools to scan my disk. initially i thought maybe my disk is full truly. but
this is the gdu result: (these information come from my mobile photos)
```
gdu ~ Use arrow keys to navigate, press ? for help
--- /mnt/gentoo ---
 115.3 GiB [#####     ] /.snapshots
  49.8 GiB [##        ] /usr
  33.4 GiB [#         ] /home
  12.5 GiB [          ] /opt
   9.7 GiB [          ] /var
 930.8 MiB [          ] /lib
  55.2 MiB [          ] /root
  50.6 MiB [          ] /etc
  27.1 MiB [          ] /sbin
  23.5 MiB [          ] /lib64
  10.1 MiB [          ] /bin
   8.1 MiB [          ] /tftproot
  24.0 KiB [          ] /dev
  20.0 KiB [          ] /mnt
  20.0 KiB [          ] /run
   4.0 KiB [          ] /sys
e  4.0 KiB [          ] /proc
e  4.0 KiB [          ] /boot
e  4.0 KiB [          ] /srv
e  4.0 KiB [          ] /tmp
@  4.0 KiB [          ] media
Total disk usage: 221.8 GiB Apparent size: 210.7 GiB Items: 5175776
Sorting by: size desc
```

so i try to delete snapshots but the free space is not change almostly --
maybe because they are snapshots. then i try to delete some `~/.cache` and
some file to make `df -Th` have 4% free space in order to i can use my
computer now.

it's almostly all the things i can remember with the remind of photos. if you
want to see any other output of program, i'll do. thanks.

sorry for disturbing anyone's precious time!

On Wed, Jun 23, 2021 at 5:33 PM Su Yue <l@damenly.su> wrote:
>
>
> On Wed 23 Jun 2021 at 14:47, Zhenyu Wu <wuzy001@gmail.com> wrote:
>
> BTW if your info is not so sensitive, better to reply me and CC
> linux-btrfs. Others can see your info and help you ;)
>
> --
> Su
> > Sorry for my late reply!
> > thanks for your suggestion.
> > ```
> > $ sudo btrfs subvolume list /
> > ID 7501 gen 942958 top level 5 path srv
> > ID 7502 gen 942959 top level 5 path var/lib/portables
> > ID 7503 gen 942960 top level 5 path var/lib/machines
> > ```
> >
> > these directories are all empty. however, if i delete them:
> >
> > ```
> > $ sudo btrfs subvolume delete
> > {/srv,/var/lib/portables,/var/lib/machines}
> > Delete subvolume (no-commit): '//srv'
> > Delete subvolume (no-commit): '/var/lib/portables'
> > Delete subvolume (no-commit): '/var/lib/machines'
> > ```
> >
> > when i reboot, these will occur again. i believe there exists
> > some
> > autostart script to create these subvolumes.
> >
> > i don't know whether this is the true reason. how can i do to
> > solve
> > this problem?
> >
> > thanks!
> >
> > On Tue, Jun 22, 2021 at 10:33 PM Su Yue <l@damenly.su> wrote:
> >>
> >>
> >> On Tue 22 Jun 2021 at 21:02, Zhenyu Wu <wuzy001@gmail.com> wrote:
> >>
> >> > Sorry for my disturbance!
> >> >
> >> > my disk with btrfs filesystem tell me it doesn't have enough
> >> > free space:
> >> >
> >> > ```
> >> > $ sudo btrfs fi df /
> >> > Data, single: total=448.02GiB, used=427.74GiB
> >> > System, DUP: total=8.00MiB, used=64.00KiB
> >> > Metadata, DUP: total=8.80GiB, used=6.39GiB
> >> > GlobalReserve, single: total=512.00MiB, used=0.00B
> >> > $ sudo btrfs fi usage /
> >> > Overall:
> >> >     Device size:                 465.64GiB
> >> >     Device allocated:            465.63GiB
> >> >     Device unallocated:            1.00MiB
> >> >     Device missing:                  0.00B
> >> >     Used:                        440.54GiB
> >> >     Free (estimated):             20.26GiB      (min:
> >> >     20.26GiB)
> >> >     Data ratio:                       1.00
> >> >     Metadata ratio:                   2.00
> >> >     Global reserve:              512.00MiB      (used: 0.00B)
> >> >     Multiple profiles:                  no
> >> >
> >> > Data,single: Size:448.02GiB, Used:427.76GiB (95.48%)
> >> >    /dev/sda2     448.02GiB
> >> >
> >> > Metadata,DUP: Size:8.80GiB, Used:6.39GiB (72.60%)
> >> >    /dev/sda2      17.60GiB
> >> >
> >> > System,DUP: Size:8.00MiB, Used:64.00KiB (0.78%)
> >> >    /dev/sda2      16.00MiB
> >> >
> >> > Unallocated:
> >> >    /dev/sda2       1.00MiB
> >> > $ sudo btrfs fi show /
> >> > Label: none  uuid: 644a9e91-5e05-4f5d-a79b-e0eccd21a1a8
> >> >         Total devices 1 FS bytes used 434.14GiB
> >> >         devid    1 size 465.64GiB used 465.63GiB path
> >> >         /dev/sda2
> >> >
> >> > $ df -Th
> >> > Filesystem     Type      Size  Used Avail Use% Mounted on
> >> > devtmpfs       devtmpfs  3.8G     0  3.8G   0% /dev
> >> > tmpfs          tmpfs     3.9G   46M  3.8G   2% /dev/shm
> >> > tmpfs          tmpfs     3.9G  3.9M  3.9G   1% /run
> >> > /dev/sda2      btrfs     466G  442G   21G  96% /
> >> > tmpfs          tmpfs     3.9G  204K  3.9G   1% /tmp
> >> > /dev/sda1      vfat      128M  125M  2.9M  98% /boot
> >> > tmpfs          tmpfs     785M   16K  785M   1% /run/user/994
> >> > tmpfs          tmpfs     785M   80K  785M   1% /run/user/1000
> >> > ```
> >> >
> >> > however, i try to use gdu to scan my disk. it tell me
> >> >
> >> > ```
> >> > $ sudo gdu /
> >> >  gdu ~ Use arrow keys to navigate, press ? for help
> >> >  --- / ---
> >> >    49.9 GiB [#####     ] /usr
> >> >    15.1 GiB [#         ] /home
> >> >    11.1 GiB [#         ] /opt
> >> >     6.5 GiB [          ] /var
> >> >   930.8 MiB [          ] /lib
> >> >   124.9 MiB [          ] /boot
> >> >    55.2 MiB [          ] /root
> >> >    50.6 MiB [          ] /etc
> >> >    27.1 MiB [          ] /sbin
> >> >    23.5 MiB [          ] /lib64
> >> >    10.9 MiB [          ] /bin
> >> > . 312.0 KiB [          ] /tmp
> >> >    20.0 KiB [          ] /mnt
> >> > e   4.0 KiB [          ] /srv
> >> > e   4.0 KiB [          ] /tftproot
> >> > @   4.0 KiB [          ] media
> >> >  Total disk usage: 83.8 GiB Apparent size: 78.4 GiB Items:
> >> >  2424046
> >> > Sorting by: size desc
> >> > ```
> >> >
> >> > 427.76GiB or 83.8 GiB!
> >> >
> >> Maybe your fs have some snapshots?
> >> Try:
> >>
> >> btrfs subvolume list /
> >>
> >> --
> >> Su
> >>
> >> > i know btrfs is a CoW filesystem, which means it will cost
> >> > more
> >> > space
> >> > to store a file. but the gap is too large, which it is hard
> >> > to
> >> > accept
> >> > the fact.
> >> > who can tell me what happened to my disk? and how can i do to
> >> > rescue
> >> > my hard disk? the rest free space is not enough. if i cannot
> >> > find the
> >> > solution, maybe i should format my hard disk to get more free
> >> > space.
> >> > thanks.
> >> >
> >> > there are some information which maybe useful.
> >> >
> >> > ```
> >> > $ uname -r
> >> > 5.11.7-gentoo-x86_64
> >> > $ btrfs --version
> >> > btrfs-progs v5.9
> >> > $ dmesg > dmesg.txt && wgetpaste -s dpaste dmesg.txt
> >> > Pasting > 25 kB often tend to fail with dpaste. Use --verbose
> >> > or
> >> > --debug to see the
> >> > error output from wget if it fails. Alternatively use another
> >> > pastebin service.
> >> > Your paste can be seen here: https://dpaste.com/FCZF83YYA
> >> > ```
