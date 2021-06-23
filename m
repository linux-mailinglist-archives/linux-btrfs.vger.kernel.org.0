Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594033B1982
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 14:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhFWMCo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 08:02:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:39903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhFWMCn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 08:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624449623;
        bh=AFcm0QbXMzxytbEJEZGjYX5/55Me5TSusN369B88MAA=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=ANhMTom8/bpMLXkF7SiqtxA20WkVaiBr+vxXibCoxF1RLOw5Gv62wJBJBK3aAv5GT
         Yzz0eHs396Ob88rgmIzQmtm0kS/QCpLIvb4NTl8c7JCN/CKjXz8IjA6JAA1TvI2MlD
         3Yok3fSJax0Y4g4ex2DPY4Bj9D6B0RdtWPBDLQRE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MybKp-1l45eN3lc5-00yv1J; Wed, 23
 Jun 2021 14:00:23 +0200
To:     =?UTF-8?B?5ZC05oyv5a6H?= <wuzy001@gmail.com>, Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
References: <CAJ9tZB_kPgZCsBaoOV93G9UCabdPifUxks+RH0e6RUycJ5wMCA@mail.gmail.com>
 <bl7yotou.fsf@damenly.su>
 <CAJ9tZB9M=KOWVLH_azagtBnxDzpV2=ssnBcYsJx6Ao8cQOELhg@mail.gmail.com>
 <5yy5orgi.fsf@damenly.su>
 <CAJ9tZB8UjSYCmvLRJ19zyKWyXD=Qp1Am0mFPc=dY8QRgMxcPiA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [question] free space of disk with btrfs is too different from
 other du
Message-ID: <900f5c2c-9058-54d4-bdc8-a32c37dd8bdc@gmx.com>
Date:   Wed, 23 Jun 2021 20:00:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ9tZB8UjSYCmvLRJ19zyKWyXD=Qp1Am0mFPc=dY8QRgMxcPiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FxWGx1zXxAvOPiYgFuCOYj6LyMoM1RNOXwATgiAuji5etUCOzLU
 yNP5FQOskiDGrWetwah6vOyKKoqhbRVqdDX4pJL/TW4urkAKNOai4T0kOs1Pev3cSSQgwFE
 jzh1eJPwG5NlYc8hWuoq0jdWTAasOoFzqLqBGZcwQ82htdC/btEmY1bixzoVvRppulhPuTN
 H/8PsvMyDKZeDzOC3ogLA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/lbl9pRh8Us=:VJn2wEjG6QzxU1lyaWVtOH
 OHz97mEITMhemX1segsD48HPPQB3KntfM+Xm0CP1uoGLNHGAv8nDYgmy8MtViZwNHReRVrwyB
 sYIQEAtoC/Xt2V+vlx1VBl/itp861hzHcUwO4L1EwOSkvHlx/B4JaN5ced2qOBfVhxSW1cdou
 20if7HfyjzsGHDeTK78WzxeB99XBE7YMazBCHCblvl3YMcyBUB1wn+eKGtK8BriZ48ieRW2Ls
 Pnil/2F3pHuWVtdU/yPaVOgZ5Rx8toAE3kG749kuOI82WM2ZeFQ5zBo2MiU6Il+HETsKZl8Oc
 eZneg9+kaGXIjGPBIuo8ior7b7xolbFfba1nmlwSedDM6ORM1MwCbR285vEWcQJjvdKrDG9AL
 EkWO1xMRPBMRcp+R+AnAwhhnGggc35Rpkmn1RqZWOd3OjJe5QBX5lsRvNyAqqoNVz327ZVpkB
 UEVwV/MZxocPHzghVHABIDKC/X5wtfyxUW6K47duC4f1b2VVODiaRbs0hqv5VtJnCPEevujxI
 DtPniWzIfRod2q0ZzOmKLm5EEWkcOUtpBl0c3PwjXTzVLBN1D5FIezIoLXzVqL44Omn8lzAJx
 HlG5iYKxjH7395hYhT/MGadwQPV2UOH//yJtsrVJS/ULQG1JCy9rL4BtZgjuebbezjpF83ft8
 NxN3FOK0LzUa6RreRSVaB3Rt7IVngcn+ovsFcC16yDMpbSRvluBiJSFvhyYzIeDjzH/k1JiWH
 sOakKMPR+kFEISXHuAzO1YOE0LJTh5oH6H4XB68E87LB65EkiLZpwWRT1VluFx5DP6jdijZha
 hlpR6UxQPvJ69oBuD2pN5OhycfsYXvtUIYCwZ3H/FP73oCZiRczMPk2WrqXe0wcPDQK0VIsD+
 5Y5lORld4mwlaNZLJRUhrOCp5UHzndJcdG6u/IqqUiq5nqUlL9W6UcQNUiKfCuSOF3VT0lnL6
 3q75H2+6XX48f9Dy13D6Zu30KGbDMWl8gM8k3302UPXyLssT7vlgO5DKfmRDpdZ9htmanGpHc
 5HVETtSlcJ6VuhcoJHTbJFCDXbEti/m+b2TwoxT2utv1oWZVPJTZesVfX0tUqeQA3SfsjfsgU
 1eZDxFL5Sz0Woq7QfSfhdHxFtDO6TPXIAHi24cXt0GwbhzQyZc6w0F7Xw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/23 =E4=B8=8B=E5=8D=887:46, =E5=90=B4=E6=8C=AF=E5=AE=87 wrote:
> Thanks for your tips! i forgot to CC linux-btrfs when reply you. sorry.
>
> i believe this problem which my disk is out of memory does not occur

By "out of memory" I guess you mean "out of space"?

> suddenly. before i notice this problem, i use snapper with its default c=
onfig
> to make snapshot for my btrfs filesystem. snapper will create many snaps=
hots
> so i don't detect that how much is the true free space (without snapshot=
s),
> and when the disk is out of memory. every time i feel the free space is =
too
> small, i will `snapper delete` some snapshots. but the free space of my =
disk
> still decrease inappearently.

This is strange.

Either the deletion is delayed and something wrong happened, they should
really not behave like this.

>
> about ten days ago, after one compter crash (system freeze), i press pow=
er
> button to try to restart it. before this time, the same thing has happen=
ed
> not only one time, but this time is different. after restart, the OS can=
not
> work -- after dmesg print (these information comes from my mobile photos=
)
> ```
> [4.941061] BTRFS info (device sda2): disk space caching is enabled
> [4.941549] BTRFS info (device sda2): has skinny extents
> [11.937528] BTRFS info (device sda2): start tree-log replay
> ```
>
> after about 200 seconds, it print more information
> ```
> [259.503140] BTRFS: error (device sda2) in btrfs_replay_log:2254:
> errno=3D-22 unknown (Failed to recover log tree)

This is not a big deal, btrfs rescue zero log should handle it without
problem.

> # this line occur many times
> [273.XXXXXX] BTRFS warning (device sda2): page private not zero on
> page 85809XXXXXX
> [273.478984] BTRFS error (device sda2): open_ctree failed
> ```
>
> perhaps i should seek for help that time, but i think i should try to so=
lve
> this problem by myself first to avoid disturb other one. after boot my
> computer from liveUSB, then I try to mount /dev/sda2, but failed. then i=
 try
> to `btrfs check /dev/sda2` but not use `--repair` because `--repair` is =
so
> dangerous. it tell me some error like 100, 200, 1.
> i try to
> ```
> btrfs rescue chunk-recovery /dev/sda2
> btrfs rescue super-recovery /dev/sda2
> ```

Those are a little dangerous now...

> but still cannot mount /dev/sda2. at last,
> ```
> btrfs rescue zero-log /dev/sda2
> ```

As expected, zero log should work.

> work and i can mount /dev/sda2. then i can reboot my OS without liveUSB.
> after then, i use `find -inum XXX` to search that file which inode is er=
ror
> 100, and found they are `~/.cache/google-chrome/Default/Code\ Cache/js/X=
XXXXX`
> and delete them.

error 0x100 is inode file extent discount, it's a pretty low priority thin=
g.
Kernel can handle it without problem.

>
> after that time, i doubt my filesystem is not normal. and try to use som=
e du
> tools to scan my disk. initially i thought maybe my disk is full truly. =
but
> this is the gdu result: (these information come from my mobile photos)
> ```
> gdu ~ Use arrow keys to navigate, press ? for help
> --- /mnt/gentoo ---
>   115.3 GiB [#####     ] /.snapshots
>    49.8 GiB [##        ] /usr
>    33.4 GiB [#         ] /home
>    12.5 GiB [          ] /opt
>     9.7 GiB [          ] /var
>   930.8 MiB [          ] /lib
>    55.2 MiB [          ] /root
>    50.6 MiB [          ] /etc
>    27.1 MiB [          ] /sbin
>    23.5 MiB [          ] /lib64
>    10.1 MiB [          ] /bin
>     8.1 MiB [          ] /tftproot
>    24.0 KiB [          ] /dev
>    20.0 KiB [          ] /mnt
>    20.0 KiB [          ] /run
>     4.0 KiB [          ] /sys
> e  4.0 KiB [          ] /proc
> e  4.0 KiB [          ] /boot
> e  4.0 KiB [          ] /srv
> e  4.0 KiB [          ] /tmp
> @  4.0 KiB [          ] media
> Total disk usage: 221.8 GiB Apparent size: 210.7 GiB Items: 5175776
> Sorting by: size desc
> ```
>
> so i try to delete snapshots but the free space is not change almostly -=
-
> maybe because they are snapshots. then i try to delete some `~/.cache` a=
nd
> some file to make `df -Th` have 4% free space in order to i can use my
> computer now.

Snapshot deletion doesn't happen immediate.

They just get unlinked first, and then get deleted at background.

It's preferred to run "btrfs fi sync" to wait for all of the deletion
finishes, then check again.


BTW, if you are not confident about the healthy of your fs, use liveUSB
to run "btrfs check" on the fs and save the output.

I don't believe it's a big deal, mostly just small (and mostly solvable)
problems.

>
> it's almostly all the things i can remember with the remind of photos. i=
f you
> want to see any other output of program, i'll do. thanks.
>
> sorry for disturbing anyone's precious time!

Don't need to be too humble, in fact we really care what the end users
hits in real world, so that we can enhance btrfs.

As long as your kernel isn't too heavily backported nor too old, we're
pretty happy to help.

Thanks,
Qu

>
> On Wed, Jun 23, 2021 at 5:33 PM Su Yue <l@damenly.su> wrote:
>>
>>
>> On Wed 23 Jun 2021 at 14:47, Zhenyu Wu <wuzy001@gmail.com> wrote:
>>
>> BTW if your info is not so sensitive, better to reply me and CC
>> linux-btrfs. Others can see your info and help you ;)
>>
>> --
>> Su
>>> Sorry for my late reply!
>>> thanks for your suggestion.
>>> ```
>>> $ sudo btrfs subvolume list /
>>> ID 7501 gen 942958 top level 5 path srv
>>> ID 7502 gen 942959 top level 5 path var/lib/portables
>>> ID 7503 gen 942960 top level 5 path var/lib/machines
>>> ```
>>>
>>> these directories are all empty. however, if i delete them:
>>>
>>> ```
>>> $ sudo btrfs subvolume delete
>>> {/srv,/var/lib/portables,/var/lib/machines}
>>> Delete subvolume (no-commit): '//srv'
>>> Delete subvolume (no-commit): '/var/lib/portables'
>>> Delete subvolume (no-commit): '/var/lib/machines'
>>> ```
>>>
>>> when i reboot, these will occur again. i believe there exists
>>> some
>>> autostart script to create these subvolumes.
>>>
>>> i don't know whether this is the true reason. how can i do to
>>> solve
>>> this problem?
>>>
>>> thanks!
>>>
>>> On Tue, Jun 22, 2021 at 10:33 PM Su Yue <l@damenly.su> wrote:
>>>>
>>>>
>>>> On Tue 22 Jun 2021 at 21:02, Zhenyu Wu <wuzy001@gmail.com> wrote:
>>>>
>>>>> Sorry for my disturbance!
>>>>>
>>>>> my disk with btrfs filesystem tell me it doesn't have enough
>>>>> free space:
>>>>>
>>>>> ```
>>>>> $ sudo btrfs fi df /
>>>>> Data, single: total=3D448.02GiB, used=3D427.74GiB
>>>>> System, DUP: total=3D8.00MiB, used=3D64.00KiB
>>>>> Metadata, DUP: total=3D8.80GiB, used=3D6.39GiB
>>>>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>>>> $ sudo btrfs fi usage /
>>>>> Overall:
>>>>>      Device size:                 465.64GiB
>>>>>      Device allocated:            465.63GiB
>>>>>      Device unallocated:            1.00MiB
>>>>>      Device missing:                  0.00B
>>>>>      Used:                        440.54GiB
>>>>>      Free (estimated):             20.26GiB      (min:
>>>>>      20.26GiB)
>>>>>      Data ratio:                       1.00
>>>>>      Metadata ratio:                   2.00
>>>>>      Global reserve:              512.00MiB      (used: 0.00B)
>>>>>      Multiple profiles:                  no
>>>>>
>>>>> Data,single: Size:448.02GiB, Used:427.76GiB (95.48%)
>>>>>     /dev/sda2     448.02GiB
>>>>>
>>>>> Metadata,DUP: Size:8.80GiB, Used:6.39GiB (72.60%)
>>>>>     /dev/sda2      17.60GiB
>>>>>
>>>>> System,DUP: Size:8.00MiB, Used:64.00KiB (0.78%)
>>>>>     /dev/sda2      16.00MiB
>>>>>
>>>>> Unallocated:
>>>>>     /dev/sda2       1.00MiB
>>>>> $ sudo btrfs fi show /
>>>>> Label: none  uuid: 644a9e91-5e05-4f5d-a79b-e0eccd21a1a8
>>>>>          Total devices 1 FS bytes used 434.14GiB
>>>>>          devid    1 size 465.64GiB used 465.63GiB path
>>>>>          /dev/sda2
>>>>>
>>>>> $ df -Th
>>>>> Filesystem     Type      Size  Used Avail Use% Mounted on
>>>>> devtmpfs       devtmpfs  3.8G     0  3.8G   0% /dev
>>>>> tmpfs          tmpfs     3.9G   46M  3.8G   2% /dev/shm
>>>>> tmpfs          tmpfs     3.9G  3.9M  3.9G   1% /run
>>>>> /dev/sda2      btrfs     466G  442G   21G  96% /
>>>>> tmpfs          tmpfs     3.9G  204K  3.9G   1% /tmp
>>>>> /dev/sda1      vfat      128M  125M  2.9M  98% /boot
>>>>> tmpfs          tmpfs     785M   16K  785M   1% /run/user/994
>>>>> tmpfs          tmpfs     785M   80K  785M   1% /run/user/1000
>>>>> ```
>>>>>
>>>>> however, i try to use gdu to scan my disk. it tell me
>>>>>
>>>>> ```
>>>>> $ sudo gdu /
>>>>>   gdu ~ Use arrow keys to navigate, press ? for help
>>>>>   --- / ---
>>>>>     49.9 GiB [#####     ] /usr
>>>>>     15.1 GiB [#         ] /home
>>>>>     11.1 GiB [#         ] /opt
>>>>>      6.5 GiB [          ] /var
>>>>>    930.8 MiB [          ] /lib
>>>>>    124.9 MiB [          ] /boot
>>>>>     55.2 MiB [          ] /root
>>>>>     50.6 MiB [          ] /etc
>>>>>     27.1 MiB [          ] /sbin
>>>>>     23.5 MiB [          ] /lib64
>>>>>     10.9 MiB [          ] /bin
>>>>> . 312.0 KiB [          ] /tmp
>>>>>     20.0 KiB [          ] /mnt
>>>>> e   4.0 KiB [          ] /srv
>>>>> e   4.0 KiB [          ] /tftproot
>>>>> @   4.0 KiB [          ] media
>>>>>   Total disk usage: 83.8 GiB Apparent size: 78.4 GiB Items:
>>>>>   2424046
>>>>> Sorting by: size desc
>>>>> ```
>>>>>
>>>>> 427.76GiB or 83.8 GiB!
>>>>>
>>>> Maybe your fs have some snapshots?
>>>> Try:
>>>>
>>>> btrfs subvolume list /
>>>>
>>>> --
>>>> Su
>>>>
>>>>> i know btrfs is a CoW filesystem, which means it will cost
>>>>> more
>>>>> space
>>>>> to store a file. but the gap is too large, which it is hard
>>>>> to
>>>>> accept
>>>>> the fact.
>>>>> who can tell me what happened to my disk? and how can i do to
>>>>> rescue
>>>>> my hard disk? the rest free space is not enough. if i cannot
>>>>> find the
>>>>> solution, maybe i should format my hard disk to get more free
>>>>> space.
>>>>> thanks.
>>>>>
>>>>> there are some information which maybe useful.
>>>>>
>>>>> ```
>>>>> $ uname -r
>>>>> 5.11.7-gentoo-x86_64
>>>>> $ btrfs --version
>>>>> btrfs-progs v5.9
>>>>> $ dmesg > dmesg.txt && wgetpaste -s dpaste dmesg.txt
>>>>> Pasting > 25 kB often tend to fail with dpaste. Use --verbose
>>>>> or
>>>>> --debug to see the
>>>>> error output from wget if it fails. Alternatively use another
>>>>> pastebin service.
>>>>> Your paste can be seen here: https://dpaste.com/FCZF83YYA
>>>>> ```
