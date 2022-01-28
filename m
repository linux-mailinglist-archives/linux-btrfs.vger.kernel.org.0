Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623E249F9B7
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 13:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348645AbiA1Mmf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 07:42:35 -0500
Received: from mout.gmx.net ([212.227.15.19]:53597 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348636AbiA1MmZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 07:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643373742;
        bh=xkgZvnK33345G1oB7xiW018Pl9Tpzl+InLWDZYTeEl8=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=DrzE7irKYBlR3IHZ/7ESlAc7TAnxaVE/LYIzQW4D+CzogJhohJ5ldylLj571+lJj/
         88eygN4giKwvev7jFeHh7MBn12r9QE9DneUZh4p9nUXE7D4tD2s7UEIaqNr73Vn0ob
         V9KK+BHsau+Cc+ni7BalPTQH6vDRsjNlN2+QSGxc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N9dwd-1mA1uq2MVh-015ZpX; Fri, 28
 Jan 2022 13:42:22 +0100
Message-ID: <e2dee101-bcff-a269-e062-710438bded3d@gmx.com>
Date:   Fri, 28 Jan 2022 20:42:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     piorunz <piorunz@gmx.com>, Kai Krakow <hurikhan77+btrfs@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com>
 <CAMthOuOg8SVYrehoS4VS=Gj4paYyobmqX85bKzGxYcG-2oJBDA@mail.gmail.com>
 <cf0cd0df-7391-adf5-abbc-42dfd1f07129@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: fstab autodegrag with 5.10 & 5.15 kernels, Debian?
In-Reply-To: <cf0cd0df-7391-adf5-abbc-42dfd1f07129@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J/R/Gtds2+mB2QidgujYu5CgYfPPxCK8e5XubgOZTVAswu+/mWU
 P6QZh1AyTwL03z2v+qY4uYx66FMw7oemsbB1RBwr8oKM6n+pfAy+uAmwd/6vxblaALkqdaE
 +zKb260BFsBeGIHkbL+IyVIss06haMkpw3kptyPtVTdNuCfhlssk+gDvAxvzh/g1Npge49s
 z0wV/J1VngtIwdkBMH7Mg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xa5jipAhHHQ=:lBuJXiZMZEomJ9yNvVOEy/
 O7f1bNY1hMT7iWo0t1s6wF9AOQiJMztP3qN2NZrI1gEJLtaQorHFvdI34fKnK/qZDcKhMwUmd
 iNiIy0X8XSB7OQpjjq5Qr4L1KvGoLGVPaodjdXVwmliS43HHyFUima8GqOoNxxdXdCYYDJxrE
 +e5OdxCKyKnakI19tGHM0iJxkOrxbw6L1Wxij6K48eRT/YuCMuuWHGLJ4aElz90LkoQ64UMYA
 h2La01psGV29JwwFz0gpKz+dsZcjAriOlfZWWEtwKazNPc8RjWMaUv2oJDfT5E5tSlDmxwjNR
 2D/AA+23P9coF+DZQMfsmM2tK2vCpQaLMybXzdKkiDj0kYKvQ9QIz73o2OIA5RIq8nRoHTgu1
 nLmggvTglYbrpnWQgej9ktqdPHr1kccm2jJJI7rbYX/g0a1cM00KE/r2z7zZqMk/1Jlm8Z2vd
 wjVCYBzb7/phPPJSh9wMu65vu0DxgP7ZwhmaJ8eSfzTxc+nVuOKAtfFSYyODepWsSpUKvcO5h
 kvPEU4Ju2wEhj7/kXcNErUUBh0PN+D/OdNwk+cVcIEQgCUDeJGfz6cf8t9EQNbBSprYLAORlX
 Zqv8idc7kPuoCaa+xGymddqeRdc7y/SXhklP6QJGJdSv5W/RSf/vhXmE0Ii+aU1BPScvKYi4l
 jNHdsFhzbUCR78AECDDqS03eODVTEjUIDh9NKVt2gkwmNfQxJzja2GY2KzIX57EL5Sg7mV6Eq
 B0EPAHyQ0tm8cMF41oV/as3uP4z+baPqVzyizX2mPqC+yirIJTLiDS9m/OyZ/vWBBCVVUAqHJ
 3qqki+QJYns3PhZaDSz+3WZnU7TW2IUGs1Cuv2XF1Twbf8eT+qsKXA9AVKAPnAzSQEgfnXVyx
 ypyL9AheOJP/r1d+e2LByNFR/T9x/NDhl0PDDcFuXa4xAs+ZLeCPN/0chq9Us732ecZqNhytN
 HjH3VcqsSLjse2U1vptYN/c3+CeXH4U8KqGFzUb7r0PhrxRjb1hohDI6mOypztt6EfsrkC6hz
 CZMnxbtnAPCoTFYSr7POly4U3BcBQdzYQz/fPdooZJWNMVz7J6Rir92NkKHmWaHFBteXt4fCv
 IYcsjGpbCx0fOw=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/28 20:14, piorunz wrote:
> Hi all,
>
> Chris, Qu, Kai, thanks for all your replies. :)
>
> As I mentioned, I never considered defragmenting before, so I am not
> experienced in this matter, but now I decided to tackle this problem a
> bit more seriously.
> So yes, I run /home RAID10 on 4 HDDs and I don't want to change it at
> this time. It's running quite fine. I'd love to run RAID 5 or 6 but I
> know this functionality is not ready.
> HDDs are 2TB each in my server, and 500GB each in desktop.
>
> So, I see that solution I found while searching internet (defrag with
> -t4G) is not suitable for compressed Btrfs.
> Also, autodefrag will not work in my case. I use 5.10 and 5.15 kernels.
>
> So, I should manually run:
> sudo btrfs filesystem defrag -v -t128K -r /home
> That will be more suitable, right?

Yep, more suitable for your kernels.

BTW, there is already patch submitted to address some problems with
compressed extents.
Like not to defrag compressed extents which are already at its max size.

For now, your -t128k would emulate that.

>
> I know performance can be improved for databases or VMs I run (6x
> Windows running 24/7), but I don't want to complicate systems more than
> they already are, so I will skip manual attr changes at this point, let
> me try one thing at a time. :)
>
> If manual defragging with -t128K is correct, I can run that regularly,
> please let me know if that would be your consensus guys. Thank you.

With -t 128k you may hit the 120s timeout problem less frequently.

Although sometimes you may want to further reduce the value to something
like 64K, to reduce the workload.

I may craft a fix to add cond_resche() inside btrfs_defrag_file() so
that can be backported to v5.15, to let the problem to be gone for good.

Thanks,
Qu

>
> On 28/01/2022 11:55, Kai Krakow wrote:
>> Hi!
>>
>> Am Fr., 28. Jan. 2022 um 08:51 Uhr schrieb piorunz <piorunz@gmx.com>:
>>
>>> Is it safe & recommended to run autodefrag mount option in fstab?
>>
>> I've tried autodefrag a few times, and usually it caused btrfs to
>> explode under some loads (usually databases and VMs), ending in
>> invalid tree states, and after reboot the FS was unmountable. This may
>> have changed meanwhile (last time I tried was in the 5.10 series).
>> YMMV. Run and test your backups.
>>
>>
>>> I am considering two machines here, normal desktop which has Btrfs as
>>> /home, and server with VM and other databases also btrfs /home. Both
>>> Btrfs RAID10 types. Both are heavily fragmented. I never defragmented
>>> them, in fact. I run Debian 11 on server (kernel 5.10) and Debian
>>> Testing (kernel 5.15) on desktop.
>>
>> Database and VM workloads are not well suited for btrfs-cow. I'd
>> consider using `chattr +C` on the directories storing such data, then
>> backup the contents, purge the directory empty, and restore the
>> contents, thus properly recreating the files in nocow mode. This
>> allows the databases and VMs to write data in-place. You're losing
>> transactional guarantees and checksums but at least for databases,
>> this is probably better left to the database itself anyways. For VMs
>> it depends, usually the embedded VM filesystem running in the images
>> should detect errors properly. That said, qemu qcow2 works very well
>> for me even with cow but I disabled compression (`chattr +m`) for the
>> images directory ("+m" is supported by recent chattr versions).
>>
>>
>>> Running manual defrag on server machine, like:
>>> sudo btrfs filesystem defrag -v -t4G -r /home
>>> takes ages and can cause 120 second timeout kernel error in dmesg due =
to
>>> service timeouts. I prefer to autodefrag gradually, overtime, mount
>>> option seems to be good for that.
>>
>> This is probably the worst scenario you can create: forcing
>> compression forces extents to be no bigger than 128k, which in turn
>> increases IO overhead, and encourages fragmentation a lot. Since you
>> are forcing compression, setting a target size of 4G probably does
>> nothing, your extents will end up with 128k size.
>>
>> I also found that depending on your workload, RAID10 may not be
>> beneficial at all because IO will always engage all spindles. In a
>> multi-process environment, a non-striping mode may be better (e.g.
>> RAID1). The high fragmentation would emphasize this bottleneck a lot.
>>
>>
>>> My current fstab mounting:
>>>
>>> noatime,space_cache=3Dv2,compress-force=3Dzstd:3 0 2
>>>
>>> Will autodefrag break COW files? Like I copy paste a file and I save
>>> space, but defrag with destroy this space saving?
>>
>> Yes, it will. You could run the bees daemon instead to recombine
>> duplicate extents. It usually gives better space savings than forcing
>> compression. Using forced compression is probably only useful for
>> archive storage, or when every single byte counts.
>>
>>
>>> Also, will autodefrag compress files automatically, as mount option
>>> enforces (compress-force=3Dzstd:3)?
>>
>> It should, but I never tried. Compression is usually only skipped for
>> very small extents (when it wouldn't save a block), or for inline
>> extents. If you run without forced compression, a heuristic is used
>> for whether compressing an extent.
>>
>>
>> Regards,
>> Kai
>
>
> --
> With kindest regards, Piotr.
>
> =E2=A2=80=E2=A3=B4=E2=A0=BE=E2=A0=BB=E2=A2=B6=E2=A3=A6=E2=A0=80
> =E2=A3=BE=E2=A0=81=E2=A2=A0=E2=A0=92=E2=A0=80=E2=A3=BF=E2=A1=81 Debian -=
 The universal operating system
> =E2=A2=BF=E2=A1=84=E2=A0=98=E2=A0=B7=E2=A0=9A=E2=A0=8B=E2=A0=80 https://=
www.debian.org/
> =E2=A0=88=E2=A0=B3=E2=A3=84=E2=A0=80=E2=A0=80=E2=A0=80=E2=A0=80
