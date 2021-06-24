Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC8C3B2EF3
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jun 2021 14:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhFXMdW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Jun 2021 08:33:22 -0400
Received: from mout.gmx.net ([212.227.17.20]:59421 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231478AbhFXMdE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Jun 2021 08:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624537827;
        bh=KcsaBuHT6UzxNGH9SMZ0bFWLyWlWFlnA+dR+FAbkJMM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bs+0glxEZMnApELrl3OWk5LRWrpB6JUfGWYFID+guK/iPAvf+5iKGBErXBthwGyXk
         Y3IFsxtAeMX4lxl7SHGCEdymsJ2jYM87Togtlmu0ZFD46FEW4J49eK4A45geROIYap
         tj3dPO16pwaMDzdV21vtSZ53fw/oqcumx1pZBvMc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MoO6C-1lTsAk3CVU-00olqE; Thu, 24
 Jun 2021 14:30:27 +0200
Subject: Re: [question] free space of disk with btrfs is too different from
 other du
To:     Zhenyu Wu <wuzy001@gmail.com>
Cc:     Graham Cobb <g.btrfs@cobb.uk.net>, Su Yue <l@damenly.su>,
        linux-btrfs@vger.kernel.org
References: <CAJ9tZB_kPgZCsBaoOV93G9UCabdPifUxks+RH0e6RUycJ5wMCA@mail.gmail.com>
 <bl7yotou.fsf@damenly.su>
 <CAJ9tZB9M=KOWVLH_azagtBnxDzpV2=ssnBcYsJx6Ao8cQOELhg@mail.gmail.com>
 <5yy5orgi.fsf@damenly.su>
 <CAJ9tZB8UjSYCmvLRJ19zyKWyXD=Qp1Am0mFPc=dY8QRgMxcPiA@mail.gmail.com>
 <900f5c2c-9058-54d4-bdc8-a32c37dd8bdc@gmx.com>
 <93eeea80-a5af-fc14-ec71-e111d801eff4@gmx.com>
 <CAJ9tZB8Y+yNoTQmEjuV3f9QL05+=abJ-Ue4m7iRkxAC0NDhTFw@mail.gmail.com>
 <3670289c-19fb-482f-d2ca-3c84eb5decbe@cobb.uk.net>
 <CAJ9tZB-7ogKcPCF=r72jJ3pvZLD3h6VfQbks-pfkB5N_yhJzTg@mail.gmail.com>
 <93bc4428-467f-9a08-0dbf-1fae8cec42dd@gmx.com>
 <CAJ9tZB9Zpnmkg-QTcVCHYKt8e5w4fBseZkJPGUT4wrH2zHokTg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <c14fd9c7-3d4c-0498-de76-56025fe2f37b@gmx.com>
Date:   Thu, 24 Jun 2021 20:30:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ9tZB9Zpnmkg-QTcVCHYKt8e5w4fBseZkJPGUT4wrH2zHokTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6i1HbXPSxbtLDhuK891VaUeuwWqttlr3deIqjjewhHUVUfWMrcs
 aqvkbLZO3pJqDrhC92bjcoGtM1KyBH1RihrMp7XQoRU1lvyBpf/bl0WSKDDwlsWYUmAbdgc
 090IkK0W8q44iB67em/wPUSw4le2aAp1MTITcymKjxsWxhoGBHf6Xj+CcfylsNE0nLB+Hfq
 sVddh8JooTal4xQ9vgcGg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eEPU8+eYTJ8=:MKMMbNp7c7drnsJ9aKSBBb
 bdWad7g/8L4h/SR3FDx8cWh/Tb6iI61iQ31DYA2+64s9Njn4uC4/VR9Abx+38jiuGAFJWUVjv
 qADdF+0qTdJPcqljOplEZEv5DyuqK+wTdrQ69+tgUWT61sNEC4pmxI3zXdtoAxEwfH2vHtGX5
 DwjrtVvT0LLvWLCMbv0i8NW3qekPe4qpY/6Rv9lTAJ7O/BLUB2L7lxMZ5KXXRzGrqS/fosdvu
 N70kPxaALyhqHrSLc41ltEJuyAsCW6tqYZ99hZiLLHXsATnP6a04/vQwM+TP3JAJjXrDecHTE
 P6a2L5r5YnHTPsfeF1AuDmHLVvuMFAennWS4rTmhRVUweM7z3+dgsfyZ6wDz5LBQp+ftOVVti
 oIOKzONL6fw0OOLJqzlJKUn6gt8ApGltilhhYHyd6J4HbAs/C5HLik5kVG7nU7Mjrb9Iseeht
 69l9O34BZizlQvpcCMgOGGCZIEfXyBTQLcTShZwz+V0waDs8GbLqjfHr4shcd1btm9y+pIVsw
 WanXASELJP/blDtwQxuRWFRh7NL9sb/nKOpL0NuV+AszoE6oGryWObbkIRre+/jt30lEn76hf
 k2+0RYpp1SVwHvarM+Q29ZBgQzwqGXHXe8pGy/kWaeSHO8niEaVg6p4DjciRmPVg8EUhZRxio
 XH+zmIHeCvpd/Th5AOJlYYm0KvdPzaMOWW0c5arphhHAe3RIQyd/3toZ2yotW+eylvpirGuyQ
 a9FJyvcBGCnZhKX03BDFGOe57R/HcUGyQxs2BqbZj0xtHH0g94rQSBGZ0PCammeTNj0CAZjML
 G+Mv0x9OIcQZvmkFVvNioUJReg3LjRn20Vl7rsqvQ6ZoBTMAZjFG3NB+3ENUyImuY5rBhUoFt
 HXWDEAijdP3hnDc7SGLhY8hl8UMitI0tIef96e+3PSKmjyByo6xlg+dEC+t8hZ8BP4J8T7Ewe
 6uxb4sbN9v2q4c+dysIk9wMq4KYt8xJbiwHO8ss4h4lV5b34sozScWapR7V2CWfrUOjAkcRQj
 FwAxA9rdW5r3IL4bgGwc+Dx3R2MY6wZkCYI7YEJa2FcQweatTL+/SIzTsFZIe5jjF43ABnD4R
 dpL4o1AtZ5sIFt8wW3BcSZPyvDfj2UPnwQF0zxKEsV2DyiVRibPtxzp2g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/24 =E4=B8=8B=E5=8D=887:33, Zhenyu Wu wrote:
> the output has changed. do i need `btrfs ins dump-tree -t root`?
> ```
> $ sudo btrfs quota disable /
> $ sudo btrfs quota enable /
> $ sudo btrfs quota rescan -w /
> # after 22m11s
> $ sudo btrfs qgroup show -pcre /
> qgroupid         rfer         excl     max_rfer     max_excl parent  chi=
ld
> --------         ----         ----     --------     -------- ------  ---=
--
> 0/5          81.23GiB      6.90GiB         none         none ---     ---
> ```
> thanks!

Yes, dump tree output for both root and data_reloc is needed.

There may be a larger dump needed, "btrfs ins dump-tree -t extent
<device>", as I guess there is some ghost trees not properly deleted at
all...

The whole thing is going crazy now.

Thanks,
Qu
>
> On Thu, Jun 24, 2021 at 6:07 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2021/6/24 =E4=B8=8B=E5=8D=885:52, Zhenyu Wu wrote:
>>> i have rescan quota but it looks like nothing change...
>>> ```
>>> $ sudo btrfs quota rescan -w /
>>> quota rescan started
>>> # after 8m39s
>>> $ sudo btrfs qgroup show -pcre /
>>> qgroupid         rfer         excl     max_rfer     max_excl parent   =
child
>>> --------         ----         ----     --------     -------- ------   =
-----
>>> 0/5          81.23GiB      6.89GiB         none         none ---      =
---
>>> 0/265           0.00B        0.00B         none         none ---      =
---
>>> 0/266           0.00B        0.00B         none         none ---      =
---
>>> 0/267           0.00B        0.00B         none         none ---      =
---
>>> 0/6482          0.00B        0.00B         none         none ---      =
---
>>> 0/7501       16.00KiB     16.00KiB         none         none ---      =
---
>>> 0/7502       16.00KiB     16.00KiB         none         none 255/7502 =
=2D--
>>> 0/7503       16.00KiB     16.00KiB         none         none 255/7503 =
=2D--
>>
>> This is now getting super weird now.
>>
>> Firstly, if there are some snapshots of subvolume 5, it should show up
>> here, with size over several GiB.
>>
>> Thus there seems to be some ghost/hidden subvolumes that even don't sho=
w
>> up in qgroup.
>>
>> It's possible that some qgroup is intentionally deleted, thus not being
>> properly updated.
>>
>> For that case, you may want to disable qgroup, re-enable, then do a
>> rescan: (Can all be done on the running system)
>>
>> # btrfs quota disable <mnt>
>> # btrfs quota enable <mnt>
>> # btrfs quota rescan -w <mnt>
>>
>> Then provide the output of 'btrfs qgroup show -prce <mnt>"
>>
>> If the output doesn't change at all, after the full 10min rescan, then =
I
>> guess you have to dump the root tree, along with the data_reloc tree.
>>
>> # btrfs ins dump-tree -t root <device>
>> # btrfs ins dump-tree -t data_reloc <device>
>>
>> Thanks,
>> Qu
>>> 1/0             0.00B        0.00B         none         none ---      =
---
>>> 255/7502     16.00KiB     16.00KiB         none         none ---      =
0/7502
>>> 255/7503     16.00KiB     16.00KiB         none         none ---      =
0/7503
>>> ```
>>>
>>> and i try to mount with option subvolid:
>>> ```
>>> $ mkdir /tmp/fulldisk
>>> $ sudo mount -o subvolid=3D5 /dev/sda2 /tmp/fulldisk
>>> $ ls -lA /tmp/fulldisk
>>> total 4
>>> drwxr-xr-x 1 root   root   1936 May  3 21:34 bin
>>> drwxr-xr-x 1 root   root      0 Jan 25  2020 boot
>>> drwxr-xr-x 1 root   root   1686 Jan 20  2020 dev
>>> drwxr-xr-x 1 wzy    wzy    5756 Jun 24 13:51 etc
>>> drwxr-xr-x 1 root   root     22 Oct 17  2020 home
>>> drwxr-xr-x 1 root   root   1332 May 18 14:13 lib
>>> drwxr-xr-x 1 root   root   6606 May 18 14:13 lib64
>>> lrwxrwxrwx 1 root   root     10 Jan 24 20:23 media -> /run/media
>>> drwxr-xr-x 1 wzy    wzy      38 Jan 27 16:51 mnt
>>> drwxr-xr-x 1 root   root    234 Jun 18 14:29 opt
>>> drwxr-xr-x 1 root   root      0 Jan 20  2020 proc
>>> drwx------ 1 wzy    wzy     536 Jun 15 20:26 root
>>> drwxr-xr-x 1 root   root     48 May 30 14:14 run
>>> drwxr-xr-x 1 root   root   4926 May 18 14:12 sbin
>>> drwxr-xr-x 1 root   root     10 Jan 20  2020 sys
>>> drwxrwxrwx 1 nobody nobody    0 Jun 18 14:34 tftproot
>>> drwxrwxrwt 1 root   root      0 May 30 14:25 tmp
>>> drwxr-xr-x 1 root   root    198 Mar 31 19:32 usr
>>> drwxr-xr-x 1 root   root    150 Apr  1 18:21 var
>>> $ sudo btrfs fi du -s /tmp/fulldisk/*
>>>        Total   Exclusive  Set shared  Filename
>>>     10.66MiB       0.00B    10.66MiB  /tmp/fulldisk/bin
>>>        0.00B       0.00B       0.00B  /tmp/fulldisk/boot
>>>        0.00B       0.00B       0.00B  /tmp/fulldisk/dev
>>>     33.34MiB    36.00KiB    33.30MiB  /tmp/fulldisk/etc
>>>     13.79GiB   784.05MiB    12.96GiB  /tmp/fulldisk/home
>>>    922.28MiB       0.00B   922.28MiB  /tmp/fulldisk/lib
>>>     23.11MiB       0.00B    23.11MiB  /tmp/fulldisk/lib64
>>> ERROR: cannot check space of '/tmp/fulldisk/media': Inappropriate
>>> ioctl for device
>>>        0.00B       0.00B       0.00B  /tmp/fulldisk/mnt
>>>     11.08GiB       0.00B    11.08GiB  /tmp/fulldisk/opt
>>>        0.00B       0.00B       0.00B  /tmp/fulldisk/proc
>>>     40.38MiB     4.35MiB    36.03MiB  /tmp/fulldisk/root
>>>        0.00B       0.00B       0.00B  /tmp/fulldisk/run
>>>     26.62MiB       0.00B    26.62MiB  /tmp/fulldisk/sbin
>>>        0.00B       0.00B       0.00B  /tmp/fulldisk/sys
>>>        0.00B       0.00B       0.00B  /tmp/fulldisk/tftproot
>>>        0.00B       0.00B       0.00B  /tmp/fulldisk/tmp
>>>     47.22GiB     1.03GiB    46.15GiB  /tmp/fulldisk/usr
>>>      5.80GiB     4.35GiB     1.45GiB  /tmp/fulldisk/var
>>> ```
>>>
>>> because media is a symbolic link so the ERROR should be normal.
>>> according to `btrfs fi du` it looks like i only use about 80GiB. it is
>>> too weird.
>>> thanks!
>>>
>>> On Thu, Jun 24, 2021 at 4:32 PM Graham Cobb <g.btrfs@cobb.uk.net> wrot=
e:
>>>>
>>>> On 24/06/2021 08:45, Zhenyu Wu wrote:
>>>>> Thanks! this is some information of some programs.
>>>>> ```
>>>>> # boot from liveUSB
>>>>> $ btrfs check /dev/sda2
>>>>> [1/7] checking root items
>>>>> [2/7] checking extents
>>>>> [3/7] checking free space cache
>>>>> [4/7] checking fs roots
>>>>> [5/7] checking only csums items (without verifying data)
>>>>> [6/7] checking root refs
>>>>> [7/7] checking quota groups
>>>>> # after mount /dev/sda2 to /mnt/gentoo
>>>>
>>>> Did you do 'mount -o subvolid=3D5 /dev/sda2 /mnt/gentoo' to make sure=
 you
>>>> can see all subvolumes, not just the default subvolume? I guess it
>>>> doesn't matter for quota, but it matters if you are using tools like =
du.
>>>>
>>>> You don't even need to use a liveUSB. On your normal mounted system y=
ou
>>>> can do...
>>>>
>>>> mkdir /tmp/fulldisk
>>>> mount -o subvolid=3D5 /dev/sda2 /tmp/fulldisk
>>>> ls -lA /tmp/fulldisk
>>>>
>>>> to see if there are other subvolumes which are not visible in /
