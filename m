Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3308B3B39C4
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jun 2021 01:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhFXXgA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Jun 2021 19:36:00 -0400
Received: from mout.gmx.net ([212.227.15.19]:54211 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhFXXf7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Jun 2021 19:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624577613;
        bh=COxriMih9mdDz96k0MmfKnE0erAo2pACAjQ+46Wa9oE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GMCAcMZ+dvK7iVxL3ceopzrJ5vuvnRBQ7Z8TvRoSfeIwByImn5iMary43FWCAveds
         lvnQxSSI6R+u0fltCdm+c2I9RgO+s/UOHhywfu4lxSTr3E09r9DRbUMRCNCbkQgsCZ
         PvP2sYVrTFXUhK2XMAtjo7rafA8KzHzuDF99mNMo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M5wLZ-1lucuU0aZH-007U0T; Fri, 25
 Jun 2021 01:33:33 +0200
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
 <c14fd9c7-3d4c-0498-de76-56025fe2f37b@gmx.com>
 <CAJ9tZB_35KKsBjXQ+qiDPv=2ffpsJnUH8JaBvp5MP3gUwVXK-A@mail.gmail.com>
 <CAJ9tZB_aVaBue9WTncNe3nObao_D0q-=9Mkmn=0=pPf92tm8gQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <c2cc4d69-a631-8765-cc7e-dd1bd8960265@gmx.com>
Date:   Fri, 25 Jun 2021 07:33:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ9tZB_aVaBue9WTncNe3nObao_D0q-=9Mkmn=0=pPf92tm8gQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PnnYMpvqTTXgEsOZZY90m6EmkcPg3BkxJbC6h/SRBwOKq3M9355
 KMRHp4USxhPtuyVZr6XCVrjNkI2Q+cf0s7llKeV7ROnpged/whzEAskbMtrIsf3nVJBD5uy
 NjOW9Ab4Kd0sHxqj1yrTnJEb29hfV+z/mV0TatZwDMuztSdQ28Dvv2ROYACteDQEZe9v1bX
 wvq1A4J11HiJKUXwOcAig==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tPWJfJuH6I4=:9NqFhcTJPfqhYKb2KKsfTk
 cPTBZ/IufrZ1PsZJ8U3DvT43fBCPgrXMUtAqj6bVus2lGNvFOFT4OSsy5GjXubiG7bWBDwUTJ
 u81Mpjo8QlJSU+bkU/zmPnHLIIJw4i3UOsiei14aXBDGxTtX+L4svN+FHk8cdrsSIoM+E8Dde
 irpyN8MLI8HT38fXSXtjHfObxOeQrtwF/mmpMG29DrmDqYAMkuBQ6WiBoqowVJFvK8t99gW7e
 qfZ6XFsStF01nbRNnbQoXXhdOpAJB9DyA0aRa9WTUlun9md6NpqGgtL4lF9CEOXNxpbDJicnW
 kYldnXwqLx7Xi6ZWsUuDVcLY40nkxt/HeCYPzIPbVf/wAUz41aV8VAIFmn94JAplaEegwml9l
 Y7CAEinjUZus9YknMAHaM8nhMqIzU6Yu2+0n+5MCHrcHxB2b3QDT53rOPw0wxo5G6qde0QqbY
 Z5dsFG9an07/mMNiI6ALpMjj18eyDwj3QFrnYZSzeHVxF9yrgv9UXYH31j+FLxq4pJKgI+Rau
 U/mFryiLFP9//Ndu6S7Q9GV0mo4LvVlXdDmWDuZqQvxgHGxrEg0O4QEikDrrfvqQhzIR0dr/i
 pvAajAl6sH60PAZXSaldPVdzKUFkYK/jpNXSSXvYCFX7KkZeASTU+pWoqaGZ+X0mbchZMgiYT
 pyv1/NVLPEOGewin2OIdx4NdN/yY+almSfIR+8nAKYh9Uh/bkXv9R/9jH1EPBarUAkgz3rASn
 72uO/m/1vbCJrJsBKVjYyhR1t7EZDWehAEpf4E2GZPGEAE5tQSu4OtRbnSPN68UuiFNrkxlcd
 warVmunMJNnTEPyVf3abd3/mtjEd67CAK+edilLg8YKU6+/5WMkUCwJPVBcIb9EwO5obuH+IZ
 MEDBWCIsSxeNVY+BUfu6JfSaZz/GYx3jKLLASv0RtriPKfke/ZEPfk917+/iap9yLYWNFkhre
 uB2/XGGAK07d0H+tiygoxL13EDfFJktqYNQWUeChkC9Wh2I1JIgVUtrELTPbEfqfeS9TSr26I
 9epLPVdZjt7fI2nHu5dz9X3k+xNzwlkAaWJu2uuvDAqBNrdCetD4759MnTfMeHA8BTwIQ0ze/
 3GH0ikikkjoOduzxBTjTxTkW719OpL5oS0b/3UwdT9jnyFpU9SZWW4+ZA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/24 =E4=B8=8B=E5=8D=8810:52, Zhenyu Wu wrote:
> the extent.txt has been uploaded to <https://share.weiyun.com/1G0Vkvv5>
>
> thanks!
>

Sorry, could you upload it to google drive?

I don't have any tencent account to download the file.

Thanks,
Qu

> On Thu, Jun 24, 2021 at 10:38 PM Zhenyu Wu <wuzy001@gmail.com> wrote:
>>
>> ```
>> $ btrfs ins dump-tree -t data_reloc
>> btrfs-progs v5.10.1
>> data reloc tree key (DATA_RELOC_TREE ROOT_ITEM 0)
>> leaf 57458688 items 2 free space 16061 generation 941500 owner DATA_REL=
OC_TREE
>> leaf 57458688 flags 0x1(WRITTEN) backref revision 1
>> fs uuid 644a9e91-5e05-4f5d-a79b-e0eccd21a1a8
>> chunk uuid fa782e34-63ae-4917-ac63-bbbe56851d8b
>> item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
>> generation 3 transid 0 size 0 nbytes 16384
>> block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
>> sequence 0 flags 0x0(none)
>> atime 1579910090.0 (2020-01-24 23:54:50)
>> ctime 1579910090.0 (2020-01-24 23:54:50)
>> mtime 1579910090.0 (2020-01-24 23:54:50)
>> otime 1579910090.0 (2020-01-24 23:54:50)
>> item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
>> index 0 namelen 2 name: ..
>> total bytes 499972575232
>> bytes used 466593501184
>> uuid 644a9e91-5e05-4f5d-a79b-e0eccd21a1a8
>> $ btrfs ins dump-tree -t root 2>&1|tee root.txt
>> # attachment
>> $ btrfs ins dump-tree -t extent 2>&1|tee extent.txt
>> # it's too large, i'll upload it to a cloud disk
>> ```
>>
>> thanks!
>>
>>
>>
>> On Thu, Jun 24, 2021 at 8:30 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>>
>>>
>>>
>>> On 2021/6/24 =E4=B8=8B=E5=8D=887:33, Zhenyu Wu wrote:
>>>> the output has changed. do i need `btrfs ins dump-tree -t root`?
>>>> ```
>>>> $ sudo btrfs quota disable /
>>>> $ sudo btrfs quota enable /
>>>> $ sudo btrfs quota rescan -w /
>>>> # after 22m11s
>>>> $ sudo btrfs qgroup show -pcre /
>>>> qgroupid         rfer         excl     max_rfer     max_excl parent  =
child
>>>> --------         ----         ----     --------     -------- ------  =
-----
>>>> 0/5          81.23GiB      6.90GiB         none         none ---     =
---
>>>> ```
>>>> thanks!
>>>
>>> Yes, dump tree output for both root and data_reloc is needed.
>>>
>>> There may be a larger dump needed, "btrfs ins dump-tree -t extent
>>> <device>", as I guess there is some ghost trees not properly deleted a=
t
>>> all...
>>>
>>> The whole thing is going crazy now.
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> On Thu, Jun 24, 2021 at 6:07 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
>>>>>
>>>>>
>>>>>
>>>>> On 2021/6/24 =E4=B8=8B=E5=8D=885:52, Zhenyu Wu wrote:
>>>>>> i have rescan quota but it looks like nothing change...
>>>>>> ```
>>>>>> $ sudo btrfs quota rescan -w /
>>>>>> quota rescan started
>>>>>> # after 8m39s
>>>>>> $ sudo btrfs qgroup show -pcre /
>>>>>> qgroupid         rfer         excl     max_rfer     max_excl parent=
   child
>>>>>> --------         ----         ----     --------     -------- ------=
   -----
>>>>>> 0/5          81.23GiB      6.89GiB         none         none ---   =
   ---
>>>>>> 0/265           0.00B        0.00B         none         none ---   =
   ---
>>>>>> 0/266           0.00B        0.00B         none         none ---   =
   ---
>>>>>> 0/267           0.00B        0.00B         none         none ---   =
   ---
>>>>>> 0/6482          0.00B        0.00B         none         none ---   =
   ---
>>>>>> 0/7501       16.00KiB     16.00KiB         none         none ---   =
   ---
>>>>>> 0/7502       16.00KiB     16.00KiB         none         none 255/75=
02 ---
>>>>>> 0/7503       16.00KiB     16.00KiB         none         none 255/75=
03 ---
>>>>>
>>>>> This is now getting super weird now.
>>>>>
>>>>> Firstly, if there are some snapshots of subvolume 5, it should show =
up
>>>>> here, with size over several GiB.
>>>>>
>>>>> Thus there seems to be some ghost/hidden subvolumes that even don't =
show
>>>>> up in qgroup.
>>>>>
>>>>> It's possible that some qgroup is intentionally deleted, thus not be=
ing
>>>>> properly updated.
>>>>>
>>>>> For that case, you may want to disable qgroup, re-enable, then do a
>>>>> rescan: (Can all be done on the running system)
>>>>>
>>>>> # btrfs quota disable <mnt>
>>>>> # btrfs quota enable <mnt>
>>>>> # btrfs quota rescan -w <mnt>
>>>>>
>>>>> Then provide the output of 'btrfs qgroup show -prce <mnt>"
>>>>>
>>>>> If the output doesn't change at all, after the full 10min rescan, th=
en I
>>>>> guess you have to dump the root tree, along with the data_reloc tree=
.
>>>>>
>>>>> # btrfs ins dump-tree -t root <device>
>>>>> # btrfs ins dump-tree -t data_reloc <device>
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>> 1/0             0.00B        0.00B         none         none ---   =
   ---
>>>>>> 255/7502     16.00KiB     16.00KiB         none         none ---   =
   0/7502
>>>>>> 255/7503     16.00KiB     16.00KiB         none         none ---   =
   0/7503
>>>>>> ```
>>>>>>
>>>>>> and i try to mount with option subvolid:
>>>>>> ```
>>>>>> $ mkdir /tmp/fulldisk
>>>>>> $ sudo mount -o subvolid=3D5 /dev/sda2 /tmp/fulldisk
>>>>>> $ ls -lA /tmp/fulldisk
>>>>>> total 4
>>>>>> drwxr-xr-x 1 root   root   1936 May  3 21:34 bin
>>>>>> drwxr-xr-x 1 root   root      0 Jan 25  2020 boot
>>>>>> drwxr-xr-x 1 root   root   1686 Jan 20  2020 dev
>>>>>> drwxr-xr-x 1 wzy    wzy    5756 Jun 24 13:51 etc
>>>>>> drwxr-xr-x 1 root   root     22 Oct 17  2020 home
>>>>>> drwxr-xr-x 1 root   root   1332 May 18 14:13 lib
>>>>>> drwxr-xr-x 1 root   root   6606 May 18 14:13 lib64
>>>>>> lrwxrwxrwx 1 root   root     10 Jan 24 20:23 media -> /run/media
>>>>>> drwxr-xr-x 1 wzy    wzy      38 Jan 27 16:51 mnt
>>>>>> drwxr-xr-x 1 root   root    234 Jun 18 14:29 opt
>>>>>> drwxr-xr-x 1 root   root      0 Jan 20  2020 proc
>>>>>> drwx------ 1 wzy    wzy     536 Jun 15 20:26 root
>>>>>> drwxr-xr-x 1 root   root     48 May 30 14:14 run
>>>>>> drwxr-xr-x 1 root   root   4926 May 18 14:12 sbin
>>>>>> drwxr-xr-x 1 root   root     10 Jan 20  2020 sys
>>>>>> drwxrwxrwx 1 nobody nobody    0 Jun 18 14:34 tftproot
>>>>>> drwxrwxrwt 1 root   root      0 May 30 14:25 tmp
>>>>>> drwxr-xr-x 1 root   root    198 Mar 31 19:32 usr
>>>>>> drwxr-xr-x 1 root   root    150 Apr  1 18:21 var
>>>>>> $ sudo btrfs fi du -s /tmp/fulldisk/*
>>>>>>         Total   Exclusive  Set shared  Filename
>>>>>>      10.66MiB       0.00B    10.66MiB  /tmp/fulldisk/bin
>>>>>>         0.00B       0.00B       0.00B  /tmp/fulldisk/boot
>>>>>>         0.00B       0.00B       0.00B  /tmp/fulldisk/dev
>>>>>>      33.34MiB    36.00KiB    33.30MiB  /tmp/fulldisk/etc
>>>>>>      13.79GiB   784.05MiB    12.96GiB  /tmp/fulldisk/home
>>>>>>     922.28MiB       0.00B   922.28MiB  /tmp/fulldisk/lib
>>>>>>      23.11MiB       0.00B    23.11MiB  /tmp/fulldisk/lib64
>>>>>> ERROR: cannot check space of '/tmp/fulldisk/media': Inappropriate
>>>>>> ioctl for device
>>>>>>         0.00B       0.00B       0.00B  /tmp/fulldisk/mnt
>>>>>>      11.08GiB       0.00B    11.08GiB  /tmp/fulldisk/opt
>>>>>>         0.00B       0.00B       0.00B  /tmp/fulldisk/proc
>>>>>>      40.38MiB     4.35MiB    36.03MiB  /tmp/fulldisk/root
>>>>>>         0.00B       0.00B       0.00B  /tmp/fulldisk/run
>>>>>>      26.62MiB       0.00B    26.62MiB  /tmp/fulldisk/sbin
>>>>>>         0.00B       0.00B       0.00B  /tmp/fulldisk/sys
>>>>>>         0.00B       0.00B       0.00B  /tmp/fulldisk/tftproot
>>>>>>         0.00B       0.00B       0.00B  /tmp/fulldisk/tmp
>>>>>>      47.22GiB     1.03GiB    46.15GiB  /tmp/fulldisk/usr
>>>>>>       5.80GiB     4.35GiB     1.45GiB  /tmp/fulldisk/var
>>>>>> ```
>>>>>>
>>>>>> because media is a symbolic link so the ERROR should be normal.
>>>>>> according to `btrfs fi du` it looks like i only use about 80GiB. it=
 is
>>>>>> too weird.
>>>>>> thanks!
>>>>>>
>>>>>> On Thu, Jun 24, 2021 at 4:32 PM Graham Cobb <g.btrfs@cobb.uk.net> w=
rote:
>>>>>>>
>>>>>>> On 24/06/2021 08:45, Zhenyu Wu wrote:
>>>>>>>> Thanks! this is some information of some programs.
>>>>>>>> ```
>>>>>>>> # boot from liveUSB
>>>>>>>> $ btrfs check /dev/sda2
>>>>>>>> [1/7] checking root items
>>>>>>>> [2/7] checking extents
>>>>>>>> [3/7] checking free space cache
>>>>>>>> [4/7] checking fs roots
>>>>>>>> [5/7] checking only csums items (without verifying data)
>>>>>>>> [6/7] checking root refs
>>>>>>>> [7/7] checking quota groups
>>>>>>>> # after mount /dev/sda2 to /mnt/gentoo
>>>>>>>
>>>>>>> Did you do 'mount -o subvolid=3D5 /dev/sda2 /mnt/gentoo' to make s=
ure you
>>>>>>> can see all subvolumes, not just the default subvolume? I guess it
>>>>>>> doesn't matter for quota, but it matters if you are using tools li=
ke du.
>>>>>>>
>>>>>>> You don't even need to use a liveUSB. On your normal mounted syste=
m you
>>>>>>> can do...
>>>>>>>
>>>>>>> mkdir /tmp/fulldisk
>>>>>>> mount -o subvolid=3D5 /dev/sda2 /tmp/fulldisk
>>>>>>> ls -lA /tmp/fulldisk
>>>>>>>
>>>>>>> to see if there are other subvolumes which are not visible in /
