Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E4B3B29AD
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jun 2021 09:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhFXHsd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Jun 2021 03:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbhFXHsd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Jun 2021 03:48:33 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78CCC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Jun 2021 00:46:14 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id l26so2942279vsm.9
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Jun 2021 00:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Oc7/f7Ga3ptXl6o34VBsn/BQZ91Yd1xpojILuoyiY9g=;
        b=JxCMOcIbaBgpcT2f9p8uPpAiG/EzD4hhQvJzjAEssXFE4sqUpRVEvKZtbSbHSUZtz7
         D0Cr8qsrRktjafPAufhxt7I2iaS4rEwBCZqqljgb3zEmwOnQPNbCVptruHkBXrzl+nM5
         twBW8QIXD9i3Zpkfr1yoYNIZWdPqo/kj3+Og9LDqeQYf+KCLKeTJAlmtMmifjovaVyPg
         x7EgcGGp0ib9YBudZXEk9VvqmrDib4wby1UskQ9sl71q+C0WCpWr0rhROg1Gha16zERe
         /ewmTKdSsoTgc8IlqhZFWziiUaWcQXNF3II09h5LKADTk6FnmGgtYL7sI+pL9rIwtjQp
         9IRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Oc7/f7Ga3ptXl6o34VBsn/BQZ91Yd1xpojILuoyiY9g=;
        b=OG09ZOgLCB+nJDAvZhpkcNfiSlRV2FL7PGPIuoSFC3eY5QkaK3++tblrsWup0UV5gT
         rz16fYfLrsMFjLOafuAeMmimMql1ee+vwWFlUYNmsZNkDvZZNqoV0mCS4hcTt52QPiLD
         a/t0xTNLrXpwRe1qQXFEmEyuahZEqxAr9BfEooA8ko3kyNMr/Ly2DQFYq37r8/g4VD0p
         6G1m1S4b29sEytIDPfB/0IBHymvWs+F+sdYM4CXG3UkHnY0q0Cq/nn1Ioh+RTtqn2rdZ
         hphfwZlxdZaQyuRtPiibbg/ktMVGSg0EsjZMCc85W/D1PE8cwWiyBKLfxEk+YrfyRJkT
         w2Sw==
X-Gm-Message-State: AOAM532CDoDstgKWWc3uMZ9aJBKyxpjYvVnHeDT+wsS8Dsc7OFxgf9F1
        mb8PhquAKw6Mzew5/c+9xvFMqFYzFdI+ytHoWT0=
X-Google-Smtp-Source: ABdhPJwy7eyyfXLk42a9WOBlks8dR1ymZFtfETlfCkZRjsDhPw3P8EwFait5uDS1FFj/p2gbF1oBUD15fN90GLyV47A=
X-Received: by 2002:a05:6102:c53:: with SMTP id y19mr1721785vss.30.1624520773882;
 Thu, 24 Jun 2021 00:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ9tZB_kPgZCsBaoOV93G9UCabdPifUxks+RH0e6RUycJ5wMCA@mail.gmail.com>
 <bl7yotou.fsf@damenly.su> <CAJ9tZB9M=KOWVLH_azagtBnxDzpV2=ssnBcYsJx6Ao8cQOELhg@mail.gmail.com>
 <5yy5orgi.fsf@damenly.su> <CAJ9tZB8UjSYCmvLRJ19zyKWyXD=Qp1Am0mFPc=dY8QRgMxcPiA@mail.gmail.com>
 <900f5c2c-9058-54d4-bdc8-a32c37dd8bdc@gmx.com> <93eeea80-a5af-fc14-ec71-e111d801eff4@gmx.com>
In-Reply-To: <93eeea80-a5af-fc14-ec71-e111d801eff4@gmx.com>
From:   Zhenyu Wu <wuzy001@gmail.com>
Date:   Thu, 24 Jun 2021 15:45:50 +0800
Message-ID: <CAJ9tZB8Y+yNoTQmEjuV3f9QL05+=abJ-Ue4m7iRkxAC0NDhTFw@mail.gmail.com>
Subject: Re: [question] free space of disk with btrfs is too different from
 other du
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Su Yue <l@damenly.su>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks! this is some information of some programs.
```
# boot from liveUSB
$ btrfs check /dev/sda2
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups
# after mount /dev/sda2 to /mnt/gentoo
$ btrfs fi sync /mnt/gentoo
# no output
```

```
# normal boot
$ sudo btrfs qoata rescan /
$ sudo btrfs qgroup show -pcre /
qgroupid         rfer         excl     max_rfer     max_excl parent   child
--------         ----         ----     --------     -------- ------   -----
0/5          81.23GiB      6.90GiB         none         none ---      ---
0/265           0.00B        0.00B         none         none ---      ---
0/266           0.00B        0.00B         none         none ---      ---
0/267           0.00B        0.00B         none         none ---      ---
0/6482          0.00B        0.00B         none         none ---      ---
0/7501       16.00KiB     16.00KiB         none         none ---      ---
0/7502       16.00KiB     16.00KiB         none         none 255/7502 ---
0/7503       16.00KiB     16.00KiB         none         none 255/7503 ---
1/0             0.00B        0.00B         none         none ---      ---
255/7502     16.00KiB     16.00KiB         none         none ---      0/750=
2
255/7503     16.00KiB     16.00KiB         none         none ---      0/750=
3
```
i don't know why these qgroups exist because they are not created by me...

the result of `btrfs check` looks like now there is not any error in
filesystem. but i still want to know where does the free space go and
how to inrease them?

out of memory is a typo. sorry:(

sorry for late, `btrfs check` costs a very long time.

On Wed, Jun 23, 2021 at 8:08 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/6/23 =E4=B8=8B=E5=8D=888:00, Qu Wenruo wrote:
> >
> >
> > On 2021/6/23 =E4=B8=8B=E5=8D=887:46, =E5=90=B4=E6=8C=AF=E5=AE=87 wrote:
> >> Thanks for your tips! i forgot to CC linux-btrfs when reply you. sorry=
.
> >>
> >> i believe this problem which my disk is out of memory does not occur
> >
> > By "out of memory" I guess you mean "out of space"?
> >
> >> suddenly. before i notice this problem, i use snapper with its default
> >> config
> >> to make snapshot for my btrfs filesystem. snapper will create many
> >> snapshots
> >> so i don't detect that how much is the true free space (without
> >> snapshots),
> >> and when the disk is out of memory. every time i feel the free space
> >> is too
> >> small, i will `snapper delete` some snapshots. but the free space of
> >> my disk
> >> still decrease inappearently.
> >
> > This is strange.
> >
> > Either the deletion is delayed and something wrong happened, they shoul=
d
> > really not behave like this.
>
> BTW, since you're using snapper, maybe it has already enabled qgroup.
>
> With qgroup, it has some pretty good indication of real space used by
> certain subvolume.
> This number includes the extent booking, which would be more accurate
> numbers.
>
> Also, qgroup could more or less shows the process of snapshot deletion,
> so you can check it by the following command:
>
> # btrfs qgroup show -prce </mnt>
>
> Thanks,
> Qu
>
> >
> >>
> >> about ten days ago, after one compter crash (system freeze), i press
> >> power
> >> button to try to restart it. before this time, the same thing has
> >> happened
> >> not only one time, but this time is different. after restart, the OS
> >> cannot
> >> work -- after dmesg print (these information comes from my mobile phot=
os)
> >> ```
> >> [4.941061] BTRFS info (device sda2): disk space caching is enabled
> >> [4.941549] BTRFS info (device sda2): has skinny extents
> >> [11.937528] BTRFS info (device sda2): start tree-log replay
> >> ```
> >>
> >> after about 200 seconds, it print more information
> >> ```
> >> [259.503140] BTRFS: error (device sda2) in btrfs_replay_log:2254:
> >> errno=3D-22 unknown (Failed to recover log tree)
> >
> > This is not a big deal, btrfs rescue zero log should handle it without
> > problem.
> >
> >> # this line occur many times
> >> [273.XXXXXX] BTRFS warning (device sda2): page private not zero on
> >> page 85809XXXXXX
> >> [273.478984] BTRFS error (device sda2): open_ctree failed
> >> ```
> >>
> >> perhaps i should seek for help that time, but i think i should try to
> >> solve
> >> this problem by myself first to avoid disturb other one. after boot my
> >> computer from liveUSB, then I try to mount /dev/sda2, but failed. then
> >> i try
> >> to `btrfs check /dev/sda2` but not use `--repair` because `--repair`
> >> is so
> >> dangerous. it tell me some error like 100, 200, 1.
> >> i try to
> >> ```
> >> btrfs rescue chunk-recovery /dev/sda2
> >> btrfs rescue super-recovery /dev/sda2
> >> ```
> >
> > Those are a little dangerous now...
> >
> >> but still cannot mount /dev/sda2. at last,
> >> ```
> >> btrfs rescue zero-log /dev/sda2
> >> ```
> >
> > As expected, zero log should work.
> >
> >> work and i can mount /dev/sda2. then i can reboot my OS without liveUS=
B.
> >> after then, i use `find -inum XXX` to search that file which inode is
> >> error
> >> 100, and found they are `~/.cache/google-chrome/Default/Code\
> >> Cache/js/XXXXXX`
> >> and delete them.
> >
> > error 0x100 is inode file extent discount, it's a pretty low priority
> > thing.
> > Kernel can handle it without problem.
> >
> >>
> >> after that time, i doubt my filesystem is not normal. and try to use
> >> some du
> >> tools to scan my disk. initially i thought maybe my disk is full
> >> truly. but
> >> this is the gdu result: (these information come from my mobile photos)
> >> ```
> >> gdu ~ Use arrow keys to navigate, press ? for help
> >> --- /mnt/gentoo ---
> >>   115.3 GiB [#####     ] /.snapshots
> >>    49.8 GiB [##        ] /usr
> >>    33.4 GiB [#         ] /home
> >>    12.5 GiB [          ] /opt
> >>     9.7 GiB [          ] /var
> >>   930.8 MiB [          ] /lib
> >>    55.2 MiB [          ] /root
> >>    50.6 MiB [          ] /etc
> >>    27.1 MiB [          ] /sbin
> >>    23.5 MiB [          ] /lib64
> >>    10.1 MiB [          ] /bin
> >>     8.1 MiB [          ] /tftproot
> >>    24.0 KiB [          ] /dev
> >>    20.0 KiB [          ] /mnt
> >>    20.0 KiB [          ] /run
> >>     4.0 KiB [          ] /sys
> >> e  4.0 KiB [          ] /proc
> >> e  4.0 KiB [          ] /boot
> >> e  4.0 KiB [          ] /srv
> >> e  4.0 KiB [          ] /tmp
> >> @  4.0 KiB [          ] media
> >> Total disk usage: 221.8 GiB Apparent size: 210.7 GiB Items: 5175776
> >> Sorting by: size desc
> >> ```
> >>
> >> so i try to delete snapshots but the free space is not change almostly=
 --
> >> maybe because they are snapshots. then i try to delete some `~/.cache`
> >> and
> >> some file to make `df -Th` have 4% free space in order to i can use my
> >> computer now.
> >
> > Snapshot deletion doesn't happen immediate.
> >
> > They just get unlinked first, and then get deleted at background.
> >
> > It's preferred to run "btrfs fi sync" to wait for all of the deletion
> > finishes, then check again.
> >
> >
> > BTW, if you are not confident about the healthy of your fs, use liveUSB
> > to run "btrfs check" on the fs and save the output.
> >
> > I don't believe it's a big deal, mostly just small (and mostly solvable=
)
> > problems.
> >
> >>
> >> it's almostly all the things i can remember with the remind of photos.
> >> if you
> >> want to see any other output of program, i'll do. thanks.
> >>
> >> sorry for disturbing anyone's precious time!
> >
> > Don't need to be too humble, in fact we really care what the end users
> > hits in real world, so that we can enhance btrfs.
> >
> > As long as your kernel isn't too heavily backported nor too old, we're
> > pretty happy to help.
> >
> > Thanks,
> > Qu
> >
> >>
> >> On Wed, Jun 23, 2021 at 5:33 PM Su Yue <l@damenly.su> wrote:
> >>>
> >>>
> >>> On Wed 23 Jun 2021 at 14:47, Zhenyu Wu <wuzy001@gmail.com> wrote:
> >>>
> >>> BTW if your info is not so sensitive, better to reply me and CC
> >>> linux-btrfs. Others can see your info and help you ;)
> >>>
> >>> --
> >>> Su
> >>>> Sorry for my late reply!
> >>>> thanks for your suggestion.
> >>>> ```
> >>>> $ sudo btrfs subvolume list /
> >>>> ID 7501 gen 942958 top level 5 path srv
> >>>> ID 7502 gen 942959 top level 5 path var/lib/portables
> >>>> ID 7503 gen 942960 top level 5 path var/lib/machines
> >>>> ```
> >>>>
> >>>> these directories are all empty. however, if i delete them:
> >>>>
> >>>> ```
> >>>> $ sudo btrfs subvolume delete
> >>>> {/srv,/var/lib/portables,/var/lib/machines}
> >>>> Delete subvolume (no-commit): '//srv'
> >>>> Delete subvolume (no-commit): '/var/lib/portables'
> >>>> Delete subvolume (no-commit): '/var/lib/machines'
> >>>> ```
> >>>>
> >>>> when i reboot, these will occur again. i believe there exists
> >>>> some
> >>>> autostart script to create these subvolumes.
> >>>>
> >>>> i don't know whether this is the true reason. how can i do to
> >>>> solve
> >>>> this problem?
> >>>>
> >>>> thanks!
> >>>>
> >>>> On Tue, Jun 22, 2021 at 10:33 PM Su Yue <l@damenly.su> wrote:
> >>>>>
> >>>>>
> >>>>> On Tue 22 Jun 2021 at 21:02, Zhenyu Wu <wuzy001@gmail.com> wrote:
> >>>>>
> >>>>>> Sorry for my disturbance!
> >>>>>>
> >>>>>> my disk with btrfs filesystem tell me it doesn't have enough
> >>>>>> free space:
> >>>>>>
> >>>>>> ```
> >>>>>> $ sudo btrfs fi df /
> >>>>>> Data, single: total=3D448.02GiB, used=3D427.74GiB
> >>>>>> System, DUP: total=3D8.00MiB, used=3D64.00KiB
> >>>>>> Metadata, DUP: total=3D8.80GiB, used=3D6.39GiB
> >>>>>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> >>>>>> $ sudo btrfs fi usage /
> >>>>>> Overall:
> >>>>>>      Device size:                 465.64GiB
> >>>>>>      Device allocated:            465.63GiB
> >>>>>>      Device unallocated:            1.00MiB
> >>>>>>      Device missing:                  0.00B
> >>>>>>      Used:                        440.54GiB
> >>>>>>      Free (estimated):             20.26GiB      (min:
> >>>>>>      20.26GiB)
> >>>>>>      Data ratio:                       1.00
> >>>>>>      Metadata ratio:                   2.00
> >>>>>>      Global reserve:              512.00MiB      (used: 0.00B)
> >>>>>>      Multiple profiles:                  no
> >>>>>>
> >>>>>> Data,single: Size:448.02GiB, Used:427.76GiB (95.48%)
> >>>>>>     /dev/sda2     448.02GiB
> >>>>>>
> >>>>>> Metadata,DUP: Size:8.80GiB, Used:6.39GiB (72.60%)
> >>>>>>     /dev/sda2      17.60GiB
> >>>>>>
> >>>>>> System,DUP: Size:8.00MiB, Used:64.00KiB (0.78%)
> >>>>>>     /dev/sda2      16.00MiB
> >>>>>>
> >>>>>> Unallocated:
> >>>>>>     /dev/sda2       1.00MiB
> >>>>>> $ sudo btrfs fi show /
> >>>>>> Label: none  uuid: 644a9e91-5e05-4f5d-a79b-e0eccd21a1a8
> >>>>>>          Total devices 1 FS bytes used 434.14GiB
> >>>>>>          devid    1 size 465.64GiB used 465.63GiB path
> >>>>>>          /dev/sda2
> >>>>>>
> >>>>>> $ df -Th
> >>>>>> Filesystem     Type      Size  Used Avail Use% Mounted on
> >>>>>> devtmpfs       devtmpfs  3.8G     0  3.8G   0% /dev
> >>>>>> tmpfs          tmpfs     3.9G   46M  3.8G   2% /dev/shm
> >>>>>> tmpfs          tmpfs     3.9G  3.9M  3.9G   1% /run
> >>>>>> /dev/sda2      btrfs     466G  442G   21G  96% /
> >>>>>> tmpfs          tmpfs     3.9G  204K  3.9G   1% /tmp
> >>>>>> /dev/sda1      vfat      128M  125M  2.9M  98% /boot
> >>>>>> tmpfs          tmpfs     785M   16K  785M   1% /run/user/994
> >>>>>> tmpfs          tmpfs     785M   80K  785M   1% /run/user/1000
> >>>>>> ```
> >>>>>>
> >>>>>> however, i try to use gdu to scan my disk. it tell me
> >>>>>>
> >>>>>> ```
> >>>>>> $ sudo gdu /
> >>>>>>   gdu ~ Use arrow keys to navigate, press ? for help
> >>>>>>   --- / ---
> >>>>>>     49.9 GiB [#####     ] /usr
> >>>>>>     15.1 GiB [#         ] /home
> >>>>>>     11.1 GiB [#         ] /opt
> >>>>>>      6.5 GiB [          ] /var
> >>>>>>    930.8 MiB [          ] /lib
> >>>>>>    124.9 MiB [          ] /boot
> >>>>>>     55.2 MiB [          ] /root
> >>>>>>     50.6 MiB [          ] /etc
> >>>>>>     27.1 MiB [          ] /sbin
> >>>>>>     23.5 MiB [          ] /lib64
> >>>>>>     10.9 MiB [          ] /bin
> >>>>>> . 312.0 KiB [          ] /tmp
> >>>>>>     20.0 KiB [          ] /mnt
> >>>>>> e   4.0 KiB [          ] /srv
> >>>>>> e   4.0 KiB [          ] /tftproot
> >>>>>> @   4.0 KiB [          ] media
> >>>>>>   Total disk usage: 83.8 GiB Apparent size: 78.4 GiB Items:
> >>>>>>   2424046
> >>>>>> Sorting by: size desc
> >>>>>> ```
> >>>>>>
> >>>>>> 427.76GiB or 83.8 GiB!
> >>>>>>
> >>>>> Maybe your fs have some snapshots?
> >>>>> Try:
> >>>>>
> >>>>> btrfs subvolume list /
> >>>>>
> >>>>> --
> >>>>> Su
> >>>>>
> >>>>>> i know btrfs is a CoW filesystem, which means it will cost
> >>>>>> more
> >>>>>> space
> >>>>>> to store a file. but the gap is too large, which it is hard
> >>>>>> to
> >>>>>> accept
> >>>>>> the fact.
> >>>>>> who can tell me what happened to my disk? and how can i do to
> >>>>>> rescue
> >>>>>> my hard disk? the rest free space is not enough. if i cannot
> >>>>>> find the
> >>>>>> solution, maybe i should format my hard disk to get more free
> >>>>>> space.
> >>>>>> thanks.
> >>>>>>
> >>>>>> there are some information which maybe useful.
> >>>>>>
> >>>>>> ```
> >>>>>> $ uname -r
> >>>>>> 5.11.7-gentoo-x86_64
> >>>>>> $ btrfs --version
> >>>>>> btrfs-progs v5.9
> >>>>>> $ dmesg > dmesg.txt && wgetpaste -s dpaste dmesg.txt
> >>>>>> Pasting > 25 kB often tend to fail with dpaste. Use --verbose
> >>>>>> or
> >>>>>> --debug to see the
> >>>>>> error output from wget if it fails. Alternatively use another
> >>>>>> pastebin service.
> >>>>>> Your paste can be seen here: https://dpaste.com/FCZF83YYA
> >>>>>> ```
