Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3EC401664
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 08:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbhIFG3R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 02:29:17 -0400
Received: from mout.gmx.net ([212.227.15.18]:38917 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231271AbhIFG3Q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Sep 2021 02:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630909688;
        bh=BNrjbQPXuTKruxV8NGPBCFhAAqRjSqxgN30l52MVwsw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PPVTeC/5RJg1WdwRPxurXi0UivIpsbC552QSu9wbg9zAnDd2lfTnParrlD99c0KrV
         /CsaqXv86g03FcMaqW/EowEgiT1MT52AUd1SwtkzkKpeHhCjvcjUFeDrdPTzX3aisP
         1CibH1tBGQJmgthsHYjj58aQmlVgA6+/H9rqTrWk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8QS2-1mIiG70msy-004PMQ; Mon, 06
 Sep 2021 08:28:07 +0200
Subject: Re: BTRFS critical: corrupt leaf; BTRFS warning csum failed, expected
 csum 0x00000000 on AMD Ryzen 7 4800H, Samsung SSD 970 EVO Plus
To:     ahipp0 <ahipp0@pm.me>, Qu Wenruo <wqu@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <IZ0izVVsQVN4TIg_nsujavw6xz3UG-k0C53QTbeghmAryLDm5vf13M_UyrvBZ9tgDT5Mh8VXrMKBfGNju1_FBaCksUTcqZRnfuRydexvfvA=@pm.me>
 <01bb7749-eccd-5a3e-eee3-3320c89ce075@gmx.com>
 <ozcaaGlwEFFj_mq4ZFf_hu1RHtOGruGz8Dwb8HHPEUhCn8Sn3G5BhbJxsMefPbtwacd-dcCJmCv6TbdX1Fdx4r-J_GoHa1rAbB4L4QQWZb0=@pm.me>
 <5ebaf4e2-a96e-a34a-f509-2a29154149eb@gmx.com>
 <tDw4sk7EvCGMpj-jprKJJ0hhti2ZS7oRNek_3A3F8IUrhpxQpMPgKRxrhBmWJoMqhA6iZ_OkO2qRUVYrtnB44rv02yPUh0YZe8Adc0IX1R8=@pm.me>
 <44dc1e9a-7739-f007-5189-00fd81c0ef26@suse.com>
 <nlXbBH0TVIiMesk038DMLcR8tUOPa5gWVCWyxtyMLXSgC0l-MItGpoGQQSzXKNC1ZHcj1NXtZqU2czoEA-BTgSgWY6fwv-HPClN7D0PTxIc=@pm.me>
 <a043852e-d552-1ce3-4b35-bdbb1793f8ad@suse.com>
 <BhXDP0Vx_AExb9FuTS6hEpr1eRkrux_n7AoNG-T1HOvtJaM7mkRN2Yifk5tIoodD5wSEfErIrpbNISVqeQyJU_w6-VePY5T060AxrmLqOf0=@pm.me>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <7de2d71d-5c75-8215-d5c9-35b4c4f092ca@gmx.com>
Date:   Mon, 6 Sep 2021 14:28:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <BhXDP0Vx_AExb9FuTS6hEpr1eRkrux_n7AoNG-T1HOvtJaM7mkRN2Yifk5tIoodD5wSEfErIrpbNISVqeQyJU_w6-VePY5T060AxrmLqOf0=@pm.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+z7y/cu8DSyRQxCKX3jkeW4o6e+JV1Tx2KwQOt95+3ItRT4Qafe
 2zOuH5ZgoHLN6wuAeokpSIkEa3Un5Rx8DABVhbxkFJhqxByEeFc0Inggmk/mo6t1MRLgI6S
 ESzmdB4pLqx1tmDu5yUC/U3Tvh2SkAU6Wq59NdJuHrK/9ougag7dA23yLjD05OMCPRYkQ4F
 hCcZLUmMu4wbR0MqTTavg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zU1KA6hiKiY=:wjzaqtOSlGFW2XSVvqkY/h
 jGqoo4J/xh30qLur6WtQCNN/956rVYkyKtHWp4AKnBUpwUA1og8O+eEEJsdhHd1rfaTxydi8s
 JlR5Fe/GlIlay67Xoxu67mKfLgLjD1bHMznWOMxk8d5GfwZvghJ71aHJJ+3HbuUY1/qad/SiX
 Y7D4BHszdpwnKHoYbKQRMYRALcws+Wr4cb4eFDjoJbtbwvU1hVteyw1vyWqzEMlpf/jBXRYhG
 MD27gWb28BcCkbHNUVq+/L72Dbi9rvvTpnIBvcSxid7KgJu4G1GeEr7FOw5HhVWPcaJBhKpwg
 UwEPK3+P1Az4WibnfssZ5JNAqNTJbCek7QonH5LEorM56a6ZiVnzNNP4c2fHXgufySUXzwWtl
 OMrV4JKzy0DKA1nHQZ3h11woGMwpBhe9syx2t98pRQ17lu4rKneXkCwYIu/+4m7HUqPPSieum
 HRoZgiDAkQC/mL4nD05CBNta/klSzcoi/2cQ64HewtGcj6foOGvG2qMLCf3o9jc50N4uQNmTy
 Se5lXC6kI1S0ZfUDITStgiZRJpT5jJ9OLgjR/eH8MtmoiNNX8uTr9UlB+gXOjiMpDn2IOJYx6
 YnJW3w+YfHrqwP4JF3rSjaIHWdJSik31BrgnNECkHCNIW76MY3wm7e7rw65nCbjvWgR9QNrhg
 avEDILAmq+zX0H439Y+BNW5FE/riYNlFyYYcUnHcVruBoV6uGlwekRfELe/guhBgNmI/2WVY+
 mjvdQVhylG9Cyu3AuPbC/FlHkwkt3yrV2r/Ab+aWq5/gxvfXnZGm3N2ZvN6tqggXrE90pfsvh
 dxdDgCfjiFzDkbdqy0LFpOXzERyqxBKbc5a7z0eoaB+oNUckUN3A2DuLZY5R/U+lXnMMERjeN
 kPscErXaol0HQXAW6DTB1iP9WpWo9HXUX7wSruVTZR8zjRz2nmeI4pUlKM5MlIWm2kihhyXRF
 Hzzn8KVzrFZvRwowOI/mI1IF/iqgqoTYxLx6C/q2+oftS4bzCiYKBsgQRGKqMyRu4kYW9nj6K
 vSreqwj3m2GJzqCAFJI4/TCjkzLuSYvL/lvPecYF0ZXyNqZDBnG59C5XGdRGbawZ5j58mWAD0
 A7kYd8D8DHr+BuZChaL4dnw5e/8BMvfpicHfUgdcSushAzO9l2A2oBkWw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/6 =E4=B8=8B=E5=8D=882:13, ahipp0 wrote:
[...]
>> You can try to delete them, but the problem is, if it doesn't work well=
,
>>
>
>> it can cause btrfs to abort transaction (aka, turns into read-only moun=
t).
>>
>
>> Thus you may want to delete them, sync the fs, check the dmesg to make
>>
>
>> sure the fs is still fine.
>
> Hm, looks like it didn't complain.
> (I just nuked the whole .config/SpiderOakONE directory)
>
>> If that works, then btrfs-check again to make sure the problem is gone.
>
> Looks much better now:
>
> $ sudo ./btrfs check /dev/nvme0n1p4
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p4
> UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> root 257 inode 488887 errors 1000, some csum missing
> root 257 inode 488889 errors 1000, some csum missing
> root 257 inode 488895 errors 1000, some csum missing
> root 257 inode 488963 errors 1000, some csum missing
> root 257 inode 488964 errors 1000, some csum missing
> root 257 inode 488966 errors 1000, some csum missing
> root 257 inode 488967 errors 1000, some csum missing
> ERROR: errors found in fs roots
> found 70414278656 bytes used, error(s) found
> total csum bytes: 68552088
> total tree bytes: 209338368
> total fs tree bytes: 111853568
> total extent tree bytes: 14024704
> btree space waste bytes: 41823418
> file data blocks allocated: 73253691392
>   referenced 70072770560
>
>
> $ sudo ./btrfs check --mode=3Dlowmem /dev/nvme0n1p4
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p4
> UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> ERROR: root 257 EXTENT_DATA[488887 4096] csum missing, have: 0, expected=
: 12288
> ERROR: root 257 EXTENT_DATA[488889 4096] csum missing, have: 0, expected=
: 16384
> ERROR: root 257 EXTENT_DATA[488895 0] csum missing, have: 0, expected: 1=
2288
> ERROR: root 257 EXTENT_DATA[488963 0] csum missing, have: 0, expected: 8=
192
> ERROR: root 257 EXTENT_DATA[488964 0] csum missing, have: 0, expected: 8=
192
> ERROR: root 257 EXTENT_DATA[488966 0] csum missing, have: 0, expected: 8=
192
> ERROR: root 257 EXTENT_DATA[488967 0] csum missing, have: 0, expected: 8=
192
> ERROR: errors found in fs roots
> found 70414278656 bytes used, error(s) found
> total csum bytes: 68552088
> total tree bytes: 209338368
> total fs tree bytes: 111853568
> total extent tree bytes: 14024704
> btree space waste bytes: 41823418
> file data blocks allocated: 73253691392
>   referenced 70072770560

Even at this stage, your fs is considered clean already.

The missing csum is really not a big deal.
>
>
> Seems like these inodes with zero csums can all be removed too since it'=
s some Steam (built-in browser?) cache.
>
> $ for i in 488887 488889 488895 488963 488964 488966 488967 ; do sudo ./=
btrfs inspect-internal inode-resolve "$i" /mnt/hippo/ ; done
> /mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcache/Cach=
e/f3778f4fc6657764_0
> /mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcache/Cach=
e/fc05b030bc3ab2bc_0
> /mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcache/Cach=
e/aa9d1c627d0d4ae1_0
> /mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcache/Cach=
e/24ede0e2ab3e0575_0
> /mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcache/Cach=
e/5aa559bb0d57bd6a_0
> /mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcache/Cach=
e/da80b0a1607292bd_0
> /mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcache/Cach=
e/90b6c5585a06e357_0
>
> $ for i in 488887 488889 488895 488963 488964 488966 488967 ; do stat $(=
sudo ./btrfs inspect-internal inode-resolve "$i" /mnt/hippo/) ; done
> File: /mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcach=
e/Cache/f3778f4fc6657764_0
> Size: 15094           Blocks: 32         IO Block: 4096   regular file
> Device: 3bh/59d Inode: 488887      Links: 1
> Access: (0600/-rw-------)  Uid: ( 1000/  andrey)   Gid: ( 1000/  andrey)
> Access: 2021-09-03 23:23:30.297522881 -0400
> Modify: 2021-09-03 23:23:30.705560160 -0400
> Change: 2021-09-03 23:23:30.705560160 -0400
> Birth: -
> File: /mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcach=
e/Cache/fc05b030bc3ab2bc_0
> Size: 19104           Blocks: 40         IO Block: 4096   regular file
> Device: 3bh/59d Inode: 488889      Links: 1
> Access: (0600/-rw-------)  Uid: ( 1000/  andrey)   Gid: ( 1000/  andrey)
> Access: 2021-09-03 23:23:30.509542251 -0400
> Modify: 2021-09-03 23:23:30.893577338 -0400
> Change: 2021-09-03 23:23:30.893577338 -0400
> Birth: -
> File: /mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcach=
e/Cache/aa9d1c627d0d4ae1_0
> Size: 8406            Blocks: 24         IO Block: 4096   regular file
> Device: 3bh/59d Inode: 488895      Links: 1
> Access: (0600/-rw-------)  Uid: ( 1000/  andrey)   Gid: ( 1000/  andrey)
> Access: 2021-09-03 23:23:35.802021943 -0400
> Modify: 2021-09-03 23:23:37.138141842 -0400
> Change: 2021-09-03 23:23:37.138141842 -0400
> Birth: -
> File: /mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcach=
e/Cache/24ede0e2ab3e0575_0
> Size: 7844            Blocks: 16         IO Block: 4096   regular file
> Device: 3bh/59d Inode: 488963      Links: 1
> Access: (0600/-rw-------)  Uid: ( 1000/  andrey)   Gid: ( 1000/  andrey)
> Access: 2021-09-03 23:23:40.054401865 -0400
> Modify: 2021-09-03 23:23:40.362429172 -0400
> Change: 2021-09-03 23:23:40.362429172 -0400
> Birth: -
> File: /mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcach=
e/Cache/5aa559bb0d57bd6a_0
> Size: 7473            Blocks: 16         IO Block: 4096   regular file
> Device: 3bh/59d Inode: 488964      Links: 1
> Access: (0600/-rw-------)  Uid: ( 1000/  andrey)   Gid: ( 1000/  andrey)
> Access: 2021-09-03 23:23:40.054401865 -0400
> Modify: 2021-09-03 23:23:40.370429882 -0400
> Change: 2021-09-03 23:23:40.370429882 -0400
> Birth: -
> File: /mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcach=
e/Cache/da80b0a1607292bd_0
> Size: 5808            Blocks: 16         IO Block: 4096   regular file
> Device: 3bh/59d Inode: 488966      Links: 1
> Access: (0600/-rw-------)  Uid: ( 1000/  andrey)   Gid: ( 1000/  andrey)
> Access: 2021-09-03 23:23:40.054401865 -0400
> Modify: 2021-09-03 23:23:40.226417115 -0400
> Change: 2021-09-03 23:23:40.226417115 -0400
> Birth: -
> File: /mnt/hippo//home-andrey/.steam/debian-installation/config/htmlcach=
e/Cache/90b6c5585a06e357_0
> Size: 7110            Blocks: 16         IO Block: 4096   regular file
> Device: 3bh/59d Inode: 488967      Links: 1
> Access: (0600/-rw-------)  Uid: ( 1000/  andrey)   Gid: ( 1000/  andrey)
> Access: 2021-09-03 23:23:40.054401865 -0400
> Modify: 2021-09-03 23:23:40.362429172 -0400
> Change: 2021-09-03 23:23:40.362429172 -0400
> Birth: -
>
> Seems like these files were all created within 10 seconds of each other.
>
> After deleting the whole /mnt/hippo//home-andrey/.steam/debian-installat=
ion/config/htmlcache/Cache directory,
> it seems the filesystem is clean.
>
> $ sudo ./btrfs check /dev/nvme0n1p4
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p4
> UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 70097395712 bytes used, no error found
> total csum bytes: 68235972
> total tree bytes: 206290944
> total fs tree bytes: 109363200
> total extent tree bytes: 13598720
> btree space waste bytes: 41683028
> file data blocks allocated: 72939855872
>   referenced 69761359872
>
> $ sudo ./btrfs check --mode=3Dlowmem /dev/nvme0n1p4
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p4
> UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs done with fs roots in lowmem mode, skipping
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 70097395712 bytes used, no error found
> total csum bytes: 68235972
> total tree bytes: 206290944
> total fs tree bytes: 109363200
> total extent tree bytes: 13598720
> btree space waste bytes: 41683028
> file data blocks allocated: 72939855872
>   referenced 69761359872
>
> $ sudo ./btrfs scrub status /mnt/hippo/
> UUID:             2b69016b-e03b-478a-84cd-f794eddfebd5
> Scrub started:    Mon Sep  6 02:06:54 2021
> Status:           finished
> Duration:         0:00:22
> Total to scrub:   65.28GiB
> Rate:             2.97GiB/s
> Error summary:    no errors found
>
>
> Can the filesystem now be considered clean as in "never corrupted"?
> Or is there still a reason to reformat it?

It's completely clean now, congratulations.

BTW, you may want to migrate to v2 space cache.

The relation between v1 cache problem and the block group item mismatch
problem is still unknown, but I guess v1 space cache may cause the problem=
.

Thus going to v2 would be a little more safe, and faster.
>
> Would using DUP profile for metadata and system help with this kind of c=
orruption?

Nope, the original corruption looks like some bug in btrfs code,
DUP/RAID1 won't help to prevent it at all.

But v5.11 kernel (and newer) can prevent such problem, with their
boosted sanity check.

> Would it be generally advisable to use it going forward?

You can use the fs without any problem.

Thanks,
Qu

>
>
>>
>
>> The csum missing problem is not a big deal, that can be easily deleted
>> by finding inode 31924 of subvolume 257 and delete it.
>> Or you can easily ignore it completely.
>
> Seems like it's gone already:
>
> $ sudo ./btrfs inspect-internal inode-resolve 31924 /mnt/hippo/
> ERROR: ino paths ioctl: No such file or directory
>
>>
>
>> Thanks,
>>
>
>> Qu
>>
>
>>>> Can you use some newer btrfs-progs and run check on it again? (not ye=
t
>>>>
>
>>>> repair)
>>>
>
>>>> This time in both original and lowmem mode.
>>>
>
>>>> As the involved btrfs-progs is pretty old, thus newer btrfs-progs (th=
e
>>>>
>
>>>> newer the better) may cause some difference.
>>>>
>
>>>> (Sorry, I should mention it earlier)
>>>
>
>>> No worries.
>>>
>
>>> Just built the latest tag from btrfs-progs repository with
>>>
>
>>> ./configure --prefix=3D"${PWD}/_install" --disable-documentation --dis=
able-shared --disable-convert --disable-python --disable-zoned
>>>
>
>>> $ ./btrfs --version
>>>
>
>>> btrfs-progs v5.13.1
>>>
>
>>> $ sudo ./btrfs check --mode=3Dlowmem /dev/nvme0n1p4
>>>
>
>>> Opening filesystem to check...
>>>
>
>>> Checking filesystem on /dev/nvme0n1p4
>>>
>
>>> UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
>>>
>
>>> [1/7] checking root items
>>>
>
>>> [2/7] checking extents
>>>
>
>>> [3/7] checking free space cache
>>>
>
>>> [4/7] checking fs roots
>>>
>
>>> ERROR: root 257 EXTENT_DATA[31924 5689344] csum missing, have: 36864, =
expected: 40960
>>>
>
>>> ERROR: errors found in fs roots
>>>
>
>>> found 71181221888 bytes used, error(s) found
>>>
>
>>> total csum bytes: 69299516
>>>
>
>>> total tree bytes: 212942848
>>>
>
>>> total fs tree bytes: 113672192
>>>
>
>>> total extent tree bytes: 14925824
>>>
>
>>> btree space waste bytes: 42179056
>>>
>
>>> file data blocks allocated: 86059712512
>>>
>
>>> referenced 70790922240
>>>
>
>>> $ sudo ./btrfs check /dev/nvme0n1p4
>>>
>
>>> Opening filesystem to check...
>>>
>
>>> Checking filesystem on /dev/nvme0n1p4
>>>
>
>>> UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
>>>
>
>>> [1/7] checking root items
>>>
>
>>> [2/7] checking extents
>>>
>
>>> extent item 3109511168 has multiple extent items
>>>
>
>>> ref mismatch on [3109511168 2105344] extent item 1, found 5
>>>
>
>>> backref disk bytenr does not match extent record, bytenr=3D3109511168,=
 ref bytenr=3D3111489536
>>>
>
>>> backref bytes do not match extent backref, bytenr=3D3109511168, ref by=
tes=3D2105344, backref bytes=3D8192
>>>
>
>>> backref disk bytenr does not match extent record, bytenr=3D3109511168,=
 ref bytenr=3D3111260160
>>>
>
>>> backref bytes do not match extent backref, bytenr=3D3109511168, ref by=
tes=3D2105344, backref bytes=3D8192
>>>
>
>>> backref disk bytenr does not match extent record, bytenr=3D3109511168,=
 ref bytenr=3D3111411712
>>>
>
>>> backref bytes do not match extent backref, bytenr=3D3109511168, ref by=
tes=3D2105344, backref bytes=3D12288
>>>
>
>>> backref disk bytenr does not match extent record, bytenr=3D3109511168,=
 ref bytenr=3D3111436288
>>>
>
>>> backref bytes do not match extent backref, bytenr=3D3109511168, ref by=
tes=3D2105344, backref bytes=3D16384
>>>
>
>>> backpointer mismatch on [3109511168 2105344]
>>>
>
>>> extent item 3121950720 has multiple extent items
>>>
>
>>> ref mismatch on [3121950720 2220032] extent item 1, found 4
>>>
>
>>> backref disk bytenr does not match extent record, bytenr=3D3121950720,=
 ref bytenr=3D3124080640
>>>
>
>>> backref bytes do not match extent backref, bytenr=3D3121950720, ref by=
tes=3D2220032, backref bytes=3D8192
>>>
>
>>> backref disk bytenr does not match extent record, bytenr=3D3121950720,=
 ref bytenr=3D3123773440
>>>
>
>>> backref bytes do not match extent backref, bytenr=3D3121950720, ref by=
tes=3D2220032, backref bytes=3D8192
>>>
>
>>> backref disk bytenr does not match extent record, bytenr=3D3121950720,=
 ref bytenr=3D3124051968
>>>
>
>>> backref bytes do not match extent backref, bytenr=3D3121950720, ref by=
tes=3D2220032, backref bytes=3D12288
>>>
>
>>> backpointer mismatch on [3121950720 2220032]
>>>
>
>>> ERROR: errors found in extent allocation tree or chunk allocation
>>>
>
>>> [3/7] checking free space cache
>>>
>
>>> [4/7] checking fs roots
>>>
>
>>> root 257 inode 31924 errors 1000, some csum missing
>>>
>
>>> ERROR: errors found in fs roots
>>>
>
>>> found 71181148160 bytes used, error(s) found
>>>
>
>>> total csum bytes: 69299516
>>>
>
>>> total tree bytes: 212942848
>>>
>
>>> total fs tree bytes: 113672192
>>>
>
>>> total extent tree bytes: 14925824
>>>
>
>>> btree space waste bytes: 42179056
>>>
>
>>> file data blocks allocated: 86059712512
>>>
>
>>> referenced 70790922240
>>>
>
>>>> Thanks,
>>>
>
>>>> Qu
