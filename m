Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36B53B1993
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 14:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhFWMK6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 08:10:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:36013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhFWMK5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 08:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624450117;
        bh=dQEVCpKRJOxYs7rIWmJOfknb4Rx57lh/3WIYic7T34Q=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=gxb79kqMAgjbnO3tJrvHLy29aB6dClyVuv+v7r1YfG49slmKedx8jwJ07jYX6afms
         F9UMVWNC3q2WmznchZP3tHyQuP83KcuqQWW0/pdmyf/lkCYfnyLH9rCD0K7k6AymEL
         LrdpnHXikLxn0s4EScEUxe3iz15IrfJShYmgBJTE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2O2Q-1lymZW41LK-003xob; Wed, 23
 Jun 2021 14:08:37 +0200
Subject: Re: [question] free space of disk with btrfs is too different from
 other du
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     =?UTF-8?B?5ZC05oyv5a6H?= <wuzy001@gmail.com>, Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
References: <CAJ9tZB_kPgZCsBaoOV93G9UCabdPifUxks+RH0e6RUycJ5wMCA@mail.gmail.com>
 <bl7yotou.fsf@damenly.su>
 <CAJ9tZB9M=KOWVLH_azagtBnxDzpV2=ssnBcYsJx6Ao8cQOELhg@mail.gmail.com>
 <5yy5orgi.fsf@damenly.su>
 <CAJ9tZB8UjSYCmvLRJ19zyKWyXD=Qp1Am0mFPc=dY8QRgMxcPiA@mail.gmail.com>
 <900f5c2c-9058-54d4-bdc8-a32c37dd8bdc@gmx.com>
Message-ID: <93eeea80-a5af-fc14-ec71-e111d801eff4@gmx.com>
Date:   Wed, 23 Jun 2021 20:08:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <900f5c2c-9058-54d4-bdc8-a32c37dd8bdc@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SB/QsnXJWsnZVru09RNC+aP/O/y8+lj+sGxn8Q6msiu/TqKaLU4
 nzFpepypoHOC223AxuHi1+oWDfM4F//VCd5n7e36GmMPhRAMwGI5/5DP+/veg7En4MmVNqR
 Wn7IFEgcxxPQV/93dC5amXn5Lhi4jC7+zsR9td9vJQso/d+l7Znw16f2tcBRn2p16pU67yr
 P8qH9tUOT6197g/zsOLUw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:X4+PabV9gJs=:eJIwJLKfXIgLVFYABDxnAn
 wntgrszoaoNTqV6HukUkvJhjEzPdy8XNSAnSlmXh7LkPzvCKANdt7FZhJ1lB+dmz5M6De+iH8
 VxVq8rN+6v1g9I9J4x2IAiy5kiw1rhdW46CDUSU1eWf1CgMQa6EAy0z4UGLCiHcLT9iK5m3wQ
 wTpj9Qzc9Bsut7GfN0MyXyC9wuVuSaKE1GIqFBZD8RBbTSOdqG6+rEKq1lfOeiNAwODd+pL4Q
 UPZOEDQkaQWx/Lq+g0eGmc1dT/6MRLnQXrozb9aUVdPdo42ikTcVnZpAVnLF40DKA/u0Tbd8o
 sFPxArZw9O6LXPhXQA+L+snLxsEPz7HUvInFWf9e+7lo9X2qGdSiw9+35xQH2Y/cNiyuFzidv
 ohnkw7X45+MBZBWppTFl4pVsxaQwzZigadoceGM47yHccvsYoatTsbR7rV48EEE5FdwDhLV8+
 2we84YJxC2eShoLSThoNJoaqKrnN7+J7CO7vbatEe/8M0Byjofy83QvMFgP7mi7PVNSrBk8Os
 qYHOFjJin9zyOH/Qcj2zNo7KlD3E2BlDjVoNmGnucTcQ3YADfeBS1QHmhbsi+r3nv0gWueSZI
 eyMmsiXtxyanaUzOpA3BlWYy3BFaJRjHemwQJ0I5qo6wvMsMtL+c1qLPhYS3aSPRMoy9bImpe
 mmQedCqbFXrTx6SkMGUHgRZ6/s1n2NDdk6q2MUIokcVkR4RpVl0TUhKv95MkStOzATh/xbeE6
 x/lzYJn1DcN3Z5jBTN7mXIYP9DDIy3uwLKY41F/kJPBHKHZ7CDXUY5rpsqVNby7u65l9g6jY2
 YzL2MPU5clrbbz3++DYSqCFTpn23SZYczr/17pBaf9gOeQGASkA57rjPp11w/cxaSyNSP6zW9
 A0mphPyHuFKtGHriM93p5HKkn04skYjQJuGAQGe2SOx7ihMlNx1Ggm3QE22henpqpfSRwmPdm
 UeEGsMWkiEnU6+XiwnPIAwHgnGvYBFYH/eKQfxTjVXecY9bRrgIFGCyrOkupipM/4vNzqPA1z
 DBLS4W3oVXm25HyOCN1ojmtFfRnGM/i8g3jmXgSMg7wwl1itIRmmxQzR2q58BnxllTgvWr9Xi
 Fsun4maHEGznzX5EDEwaGTNl3qW0lyG/IDsRAePDo4saXRDrBokggO6WA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/23 =E4=B8=8B=E5=8D=888:00, Qu Wenruo wrote:
>
>
> On 2021/6/23 =E4=B8=8B=E5=8D=887:46, =E5=90=B4=E6=8C=AF=E5=AE=87 wrote:
>> Thanks for your tips! i forgot to CC linux-btrfs when reply you. sorry.
>>
>> i believe this problem which my disk is out of memory does not occur
>
> By "out of memory" I guess you mean "out of space"?
>
>> suddenly. before i notice this problem, i use snapper with its default
>> config
>> to make snapshot for my btrfs filesystem. snapper will create many
>> snapshots
>> so i don't detect that how much is the true free space (without
>> snapshots),
>> and when the disk is out of memory. every time i feel the free space
>> is too
>> small, i will `snapper delete` some snapshots. but the free space of
>> my disk
>> still decrease inappearently.
>
> This is strange.
>
> Either the deletion is delayed and something wrong happened, they should
> really not behave like this.

BTW, since you're using snapper, maybe it has already enabled qgroup.

With qgroup, it has some pretty good indication of real space used by
certain subvolume.
This number includes the extent booking, which would be more accurate
numbers.

Also, qgroup could more or less shows the process of snapshot deletion,
so you can check it by the following command:

# btrfs qgroup show -prce </mnt>

Thanks,
Qu

>
>>
>> about ten days ago, after one compter crash (system freeze), i press
>> power
>> button to try to restart it. before this time, the same thing has
>> happened
>> not only one time, but this time is different. after restart, the OS
>> cannot
>> work -- after dmesg print (these information comes from my mobile photo=
s)
>> ```
>> [4.941061] BTRFS info (device sda2): disk space caching is enabled
>> [4.941549] BTRFS info (device sda2): has skinny extents
>> [11.937528] BTRFS info (device sda2): start tree-log replay
>> ```
>>
>> after about 200 seconds, it print more information
>> ```
>> [259.503140] BTRFS: error (device sda2) in btrfs_replay_log:2254:
>> errno=3D-22 unknown (Failed to recover log tree)
>
> This is not a big deal, btrfs rescue zero log should handle it without
> problem.
>
>> # this line occur many times
>> [273.XXXXXX] BTRFS warning (device sda2): page private not zero on
>> page 85809XXXXXX
>> [273.478984] BTRFS error (device sda2): open_ctree failed
>> ```
>>
>> perhaps i should seek for help that time, but i think i should try to
>> solve
>> this problem by myself first to avoid disturb other one. after boot my
>> computer from liveUSB, then I try to mount /dev/sda2, but failed. then
>> i try
>> to `btrfs check /dev/sda2` but not use `--repair` because `--repair`
>> is so
>> dangerous. it tell me some error like 100, 200, 1.
>> i try to
>> ```
>> btrfs rescue chunk-recovery /dev/sda2
>> btrfs rescue super-recovery /dev/sda2
>> ```
>
> Those are a little dangerous now...
>
>> but still cannot mount /dev/sda2. at last,
>> ```
>> btrfs rescue zero-log /dev/sda2
>> ```
>
> As expected, zero log should work.
>
>> work and i can mount /dev/sda2. then i can reboot my OS without liveUSB=
.
>> after then, i use `find -inum XXX` to search that file which inode is
>> error
>> 100, and found they are `~/.cache/google-chrome/Default/Code\
>> Cache/js/XXXXXX`
>> and delete them.
>
> error 0x100 is inode file extent discount, it's a pretty low priority
> thing.
> Kernel can handle it without problem.
>
>>
>> after that time, i doubt my filesystem is not normal. and try to use
>> some du
>> tools to scan my disk. initially i thought maybe my disk is full
>> truly. but
>> this is the gdu result: (these information come from my mobile photos)
>> ```
>> gdu ~ Use arrow keys to navigate, press ? for help
>> --- /mnt/gentoo ---
>> =C2=A0 115.3 GiB [#####=C2=A0=C2=A0=C2=A0=C2=A0 ] /.snapshots
>> =C2=A0=C2=A0 49.8 GiB [##=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ] /=
usr
>> =C2=A0=C2=A0 33.4 GiB [#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ] /home
>> =C2=A0=C2=A0 12.5 GiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ] /opt
>> =C2=A0=C2=A0=C2=A0 9.7 GiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ] /var
>> =C2=A0 930.8 MiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ] /lib
>> =C2=A0=C2=A0 55.2 MiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ] /root
>> =C2=A0=C2=A0 50.6 MiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ] /etc
>> =C2=A0=C2=A0 27.1 MiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ] /sbin
>> =C2=A0=C2=A0 23.5 MiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ] /lib64
>> =C2=A0=C2=A0 10.1 MiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ] /bin
>> =C2=A0=C2=A0=C2=A0 8.1 MiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ] /tftproot
>> =C2=A0=C2=A0 24.0 KiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ] /dev
>> =C2=A0=C2=A0 20.0 KiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ] /mnt
>> =C2=A0=C2=A0 20.0 KiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ] /run
>> =C2=A0=C2=A0=C2=A0 4.0 KiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ] /sys
>> e=C2=A0 4.0 KiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ] /proc
>> e=C2=A0 4.0 KiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ] /boot
>> e=C2=A0 4.0 KiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ] /srv
>> e=C2=A0 4.0 KiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ] /tmp
>> @=C2=A0 4.0 KiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ] media
>> Total disk usage: 221.8 GiB Apparent size: 210.7 GiB Items: 5175776
>> Sorting by: size desc
>> ```
>>
>> so i try to delete snapshots but the free space is not change almostly =
=2D-
>> maybe because they are snapshots. then i try to delete some `~/.cache`
>> and
>> some file to make `df -Th` have 4% free space in order to i can use my
>> computer now.
>
> Snapshot deletion doesn't happen immediate.
>
> They just get unlinked first, and then get deleted at background.
>
> It's preferred to run "btrfs fi sync" to wait for all of the deletion
> finishes, then check again.
>
>
> BTW, if you are not confident about the healthy of your fs, use liveUSB
> to run "btrfs check" on the fs and save the output.
>
> I don't believe it's a big deal, mostly just small (and mostly solvable)
> problems.
>
>>
>> it's almostly all the things i can remember with the remind of photos.
>> if you
>> want to see any other output of program, i'll do. thanks.
>>
>> sorry for disturbing anyone's precious time!
>
> Don't need to be too humble, in fact we really care what the end users
> hits in real world, so that we can enhance btrfs.
>
> As long as your kernel isn't too heavily backported nor too old, we're
> pretty happy to help.
>
> Thanks,
> Qu
>
>>
>> On Wed, Jun 23, 2021 at 5:33 PM Su Yue <l@damenly.su> wrote:
>>>
>>>
>>> On Wed 23 Jun 2021 at 14:47, Zhenyu Wu <wuzy001@gmail.com> wrote:
>>>
>>> BTW if your info is not so sensitive, better to reply me and CC
>>> linux-btrfs. Others can see your info and help you ;)
>>>
>>> --
>>> Su
>>>> Sorry for my late reply!
>>>> thanks for your suggestion.
>>>> ```
>>>> $ sudo btrfs subvolume list /
>>>> ID 7501 gen 942958 top level 5 path srv
>>>> ID 7502 gen 942959 top level 5 path var/lib/portables
>>>> ID 7503 gen 942960 top level 5 path var/lib/machines
>>>> ```
>>>>
>>>> these directories are all empty. however, if i delete them:
>>>>
>>>> ```
>>>> $ sudo btrfs subvolume delete
>>>> {/srv,/var/lib/portables,/var/lib/machines}
>>>> Delete subvolume (no-commit): '//srv'
>>>> Delete subvolume (no-commit): '/var/lib/portables'
>>>> Delete subvolume (no-commit): '/var/lib/machines'
>>>> ```
>>>>
>>>> when i reboot, these will occur again. i believe there exists
>>>> some
>>>> autostart script to create these subvolumes.
>>>>
>>>> i don't know whether this is the true reason. how can i do to
>>>> solve
>>>> this problem?
>>>>
>>>> thanks!
>>>>
>>>> On Tue, Jun 22, 2021 at 10:33 PM Su Yue <l@damenly.su> wrote:
>>>>>
>>>>>
>>>>> On Tue 22 Jun 2021 at 21:02, Zhenyu Wu <wuzy001@gmail.com> wrote:
>>>>>
>>>>>> Sorry for my disturbance!
>>>>>>
>>>>>> my disk with btrfs filesystem tell me it doesn't have enough
>>>>>> free space:
>>>>>>
>>>>>> ```
>>>>>> $ sudo btrfs fi df /
>>>>>> Data, single: total=3D448.02GiB, used=3D427.74GiB
>>>>>> System, DUP: total=3D8.00MiB, used=3D64.00KiB
>>>>>> Metadata, DUP: total=3D8.80GiB, used=3D6.39GiB
>>>>>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>>>>> $ sudo btrfs fi usage /
>>>>>> Overall:
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 465.64G=
iB
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Device allocated:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 465.63GiB
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Device unallocated:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00MiB
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Device missing:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0.00B
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Used:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 440.54GiB
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Free (estimated):=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20.26GiB=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (min:
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 20.26GiB)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Data ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Metadata ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 2.00
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Global reserve:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 512.00MiB=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (used: 0.00B)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Multiple profiles:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 no
>>>>>>
>>>>>> Data,single: Size:448.02GiB, Used:427.76GiB (95.48%)
>>>>>> =C2=A0=C2=A0=C2=A0 /dev/sda2=C2=A0=C2=A0=C2=A0=C2=A0 448.02GiB
>>>>>>
>>>>>> Metadata,DUP: Size:8.80GiB, Used:6.39GiB (72.60%)
>>>>>> =C2=A0=C2=A0=C2=A0 /dev/sda2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 17.60GiB
>>>>>>
>>>>>> System,DUP: Size:8.00MiB, Used:64.00KiB (0.78%)
>>>>>> =C2=A0=C2=A0=C2=A0 /dev/sda2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16.00MiB
>>>>>>
>>>>>> Unallocated:
>>>>>> =C2=A0=C2=A0=C2=A0 /dev/sda2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.=
00MiB
>>>>>> $ sudo btrfs fi show /
>>>>>> Label: none=C2=A0 uuid: 644a9e91-5e05-4f5d-a79b-e0eccd21a1a8
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS=
 bytes used 434.14GiB
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=
=C2=A0 1 size 465.64GiB used 465.63GiB path
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /dev/sda2
>>>>>>
>>>>>> $ df -Th
>>>>>> Filesystem=C2=A0=C2=A0=C2=A0=C2=A0 Type=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Size=C2=A0 Used Avail Use% Mounted on
>>>>>> devtmpfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devtmpfs=C2=A0 3.8G=C2=
=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 3.8G=C2=A0=C2=A0 0% /dev
>>>>>> tmpfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmpfs=
=C2=A0=C2=A0=C2=A0=C2=A0 3.9G=C2=A0=C2=A0 46M=C2=A0 3.8G=C2=A0=C2=A0 2% /d=
ev/shm
>>>>>> tmpfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmpfs=
=C2=A0=C2=A0=C2=A0=C2=A0 3.9G=C2=A0 3.9M=C2=A0 3.9G=C2=A0=C2=A0 1% /run
>>>>>> /dev/sda2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs=C2=A0=C2=A0=C2=A0=C2=
=A0 466G=C2=A0 442G=C2=A0=C2=A0 21G=C2=A0 96% /
>>>>>> tmpfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmpfs=
=C2=A0=C2=A0=C2=A0=C2=A0 3.9G=C2=A0 204K=C2=A0 3.9G=C2=A0=C2=A0 1% /tmp
>>>>>> /dev/sda1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vfat=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 128M=C2=A0 125M=C2=A0 2.9M=C2=A0 98% /boot
>>>>>> tmpfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmpfs=
=C2=A0=C2=A0=C2=A0=C2=A0 785M=C2=A0=C2=A0 16K=C2=A0 785M=C2=A0=C2=A0 1% /r=
un/user/994
>>>>>> tmpfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmpfs=
=C2=A0=C2=A0=C2=A0=C2=A0 785M=C2=A0=C2=A0 80K=C2=A0 785M=C2=A0=C2=A0 1% /r=
un/user/1000
>>>>>> ```
>>>>>>
>>>>>> however, i try to use gdu to scan my disk. it tell me
>>>>>>
>>>>>> ```
>>>>>> $ sudo gdu /
>>>>>> =C2=A0 gdu ~ Use arrow keys to navigate, press ? for help
>>>>>> =C2=A0 --- / ---
>>>>>> =C2=A0=C2=A0=C2=A0 49.9 GiB [#####=C2=A0=C2=A0=C2=A0=C2=A0 ] /usr
>>>>>> =C2=A0=C2=A0=C2=A0 15.1 GiB [#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ] /home
>>>>>> =C2=A0=C2=A0=C2=A0 11.1 GiB [#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ] /opt
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 6.5 GiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ] /var
>>>>>> =C2=A0=C2=A0 930.8 MiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ] /lib
>>>>>> =C2=A0=C2=A0 124.9 MiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ] /boot
>>>>>> =C2=A0=C2=A0=C2=A0 55.2 MiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ] /root
>>>>>> =C2=A0=C2=A0=C2=A0 50.6 MiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ] /etc
>>>>>> =C2=A0=C2=A0=C2=A0 27.1 MiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ] /sbin
>>>>>> =C2=A0=C2=A0=C2=A0 23.5 MiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ] /lib64
>>>>>> =C2=A0=C2=A0=C2=A0 10.9 MiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ] /bin
>>>>>> . 312.0 KiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ] /tmp
>>>>>> =C2=A0=C2=A0=C2=A0 20.0 KiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ] /mnt
>>>>>> e=C2=A0=C2=A0 4.0 KiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ] /srv
>>>>>> e=C2=A0=C2=A0 4.0 KiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ] /tftproot
>>>>>> @=C2=A0=C2=A0 4.0 KiB [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ] media
>>>>>> =C2=A0 Total disk usage: 83.8 GiB Apparent size: 78.4 GiB Items:
>>>>>> =C2=A0 2424046
>>>>>> Sorting by: size desc
>>>>>> ```
>>>>>>
>>>>>> 427.76GiB or 83.8 GiB!
>>>>>>
>>>>> Maybe your fs have some snapshots?
>>>>> Try:
>>>>>
>>>>> btrfs subvolume list /
>>>>>
>>>>> --
>>>>> Su
>>>>>
>>>>>> i know btrfs is a CoW filesystem, which means it will cost
>>>>>> more
>>>>>> space
>>>>>> to store a file. but the gap is too large, which it is hard
>>>>>> to
>>>>>> accept
>>>>>> the fact.
>>>>>> who can tell me what happened to my disk? and how can i do to
>>>>>> rescue
>>>>>> my hard disk? the rest free space is not enough. if i cannot
>>>>>> find the
>>>>>> solution, maybe i should format my hard disk to get more free
>>>>>> space.
>>>>>> thanks.
>>>>>>
>>>>>> there are some information which maybe useful.
>>>>>>
>>>>>> ```
>>>>>> $ uname -r
>>>>>> 5.11.7-gentoo-x86_64
>>>>>> $ btrfs --version
>>>>>> btrfs-progs v5.9
>>>>>> $ dmesg > dmesg.txt && wgetpaste -s dpaste dmesg.txt
>>>>>> Pasting > 25 kB often tend to fail with dpaste. Use --verbose
>>>>>> or
>>>>>> --debug to see the
>>>>>> error output from wget if it fails. Alternatively use another
>>>>>> pastebin service.
>>>>>> Your paste can be seen here: https://dpaste.com/FCZF83YYA
>>>>>> ```
