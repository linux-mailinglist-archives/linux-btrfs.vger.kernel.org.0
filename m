Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6B53B39E3
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jun 2021 01:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhFXX4L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Jun 2021 19:56:11 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:32918 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFXX4K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Jun 2021 19:56:10 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id DDAE51E00AB4;
        Fri, 25 Jun 2021 02:53:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1624578829; bh=30jK9qtDcebr/kz0gRtptJWTHtflZ8gpXDAiPzrTcRc=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=AvR+Uk5SmX+pGJ28lh3LGxn5vTCsNq0Vfhn0CHxQ1qYCAL33rIYnmhkqQHWVBpkwU
         N41sdzMqPfdoH4QAMPBwdKVH4IDKu5GKIqxGw0QDenASdJgWOYLbT4iZYWzVuVc9tm
         2GvT+mPksEnS1IC3To8kVIS6D7Y0T2TFx1ftef6c=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id D261C1E00AB2;
        Fri, 25 Jun 2021 02:53:49 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id 7HdEy08OV8Bc; Fri, 25 Jun 2021 02:53:45 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id C2A3D1E00AB3;
        Fri, 25 Jun 2021 02:53:45 +0300 (EEST)
Received: from nas (unknown [153.127.9.202])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 6042B1BE0076;
        Fri, 25 Jun 2021 02:53:43 +0300 (EEST)
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
 <c2cc4d69-a631-8765-cc7e-dd1bd8960265@gmx.com>
User-agent: mu4e 1.5.8; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Zhenyu Wu <wuzy001@gmail.com>, Graham Cobb <g.btrfs@cobb.uk.net>,
        linux-btrfs@vger.kernel.org
Subject: Re: [question] free space of disk with btrfs is too different from
 other du
Date:   Fri, 25 Jun 2021 07:51:15 +0800
In-reply-to: <c2cc4d69-a631-8765-cc7e-dd1bd8960265@gmx.com>
Message-ID: <wnqiom4e.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: OK
X-ESPOL: +dBm1NUOBkfEh1+kQGXfBwEppjRLXO/5mZS31AEq73aJTzLmCkUMVhC2n2R1THi+og==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Fri 25 Jun 2021 at 07:33, Qu Wenruo <quwenruo.btrfs@gmx.com>=20
wrote:

> On 2021/6/24 =E4=B8=8B=E5=8D=8810:52, Zhenyu Wu wrote:
>> the extent.txt has been uploaded to=20
>> <https://share.weiyun.com/1G0Vkvv5>
>>
>> thanks!
>>
>
> Sorry, could you upload it to google drive?
>
The download speepd of tecent disk even is even slower than my=20
VPN.

https://drive.google.com/file/d/1HJzw7vvVDOz4EIpzjg1M2Dr5Y0YbzkgD/view?usp=
=3Dsharing

--
Su

> I don't have any tencent account to download the file.
>
> Thanks,
> Qu
>
>> On Thu, Jun 24, 2021 at 10:38 PM Zhenyu Wu <wuzy001@gmail.com>=20
>> wrote:
>>>
>>> ```
>>> $ btrfs ins dump-tree -t data_reloc
>>> btrfs-progs v5.10.1
>>> data reloc tree key (DATA_RELOC_TREE ROOT_ITEM 0)
>>> leaf 57458688 items 2 free space 16061 generation 941500 owner=20
>>> DATA_RELOC_TREE
>>> leaf 57458688 flags 0x1(WRITTEN) backref revision 1
>>> fs uuid 644a9e91-5e05-4f5d-a79b-e0eccd21a1a8
>>> chunk uuid fa782e34-63ae-4917-ac63-bbbe56851d8b
>>> item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
>>> generation 3 transid 0 size 0 nbytes 16384
>>> block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
>>> sequence 0 flags 0x0(none)
>>> atime 1579910090.0 (2020-01-24 23:54:50)
>>> ctime 1579910090.0 (2020-01-24 23:54:50)
>>> mtime 1579910090.0 (2020-01-24 23:54:50)
>>> otime 1579910090.0 (2020-01-24 23:54:50)
>>> item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
>>> index 0 namelen 2 name: ..
>>> total bytes 499972575232
>>> bytes used 466593501184
>>> uuid 644a9e91-5e05-4f5d-a79b-e0eccd21a1a8
>>> $ btrfs ins dump-tree -t root 2>&1|tee root.txt
>>> # attachment
>>> $ btrfs ins dump-tree -t extent 2>&1|tee extent.txt
>>> # it's too large, i'll upload it to a cloud disk
>>> ```
>>>
>>> thanks!
>>>
>>>
>>>
>>> On Thu, Jun 24, 2021 at 8:30 PM Qu Wenruo=20
>>> <quwenruo.btrfs@gmx.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2021/6/24 =E4=B8=8B=E5=8D=887:33, Zhenyu Wu wrote:
>>>>> the output has changed. do i need `btrfs ins dump-tree -t=20
>>>>> root`?
>>>>> ```
>>>>> $ sudo btrfs quota disable /
>>>>> $ sudo btrfs quota enable /
>>>>> $ sudo btrfs quota rescan -w /
>>>>> # after 22m11s
>>>>> $ sudo btrfs qgroup show -pcre /
>>>>> qgroupid         rfer         excl     max_rfer     max_excl=20
>>>>> parent  child
>>>>> --------         ----         ----     --------     --------=20
>>>>> ------  -----
>>>>> 0/5          81.23GiB      6.90GiB         none         none=20
>>>>> ---     ---
>>>>> ```
>>>>> thanks!
>>>>
>>>> Yes, dump tree output for both root and data_reloc is needed.
>>>>
>>>> There may be a larger dump needed, "btrfs ins dump-tree -t=20
>>>> extent
>>>> <device>", as I guess there is some ghost trees not properly=20
>>>> deleted at
>>>> all...
>>>>
>>>> The whole thing is going crazy now.
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> On Thu, Jun 24, 2021 at 6:07 PM Qu Wenruo=20
>>>>> <quwenruo.btrfs@gmx.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2021/6/24 =E4=B8=8B=E5=8D=885:52, Zhenyu Wu wrote:
>>>>>>> i have rescan quota but it looks like nothing change...
>>>>>>> ```
>>>>>>> $ sudo btrfs quota rescan -w /
>>>>>>> quota rescan started
>>>>>>> # after 8m39s
>>>>>>> $ sudo btrfs qgroup show -pcre /
>>>>>>> qgroupid         rfer         excl     max_rfer=20
>>>>>>> max_excl parent   child
>>>>>>> --------         ----         ----     --------=20
>>>>>>> -------- ------   -----
>>>>>>> 0/5          81.23GiB      6.89GiB         none=20
>>>>>>> none ---      ---
>>>>>>> 0/265           0.00B        0.00B         none=20
>>>>>>> none ---      ---
>>>>>>> 0/266           0.00B        0.00B         none=20
>>>>>>> none ---      ---
>>>>>>> 0/267           0.00B        0.00B         none=20
>>>>>>> none ---      ---
>>>>>>> 0/6482          0.00B        0.00B         none=20
>>>>>>> none ---      ---
>>>>>>> 0/7501       16.00KiB     16.00KiB         none=20
>>>>>>> none ---      ---
>>>>>>> 0/7502       16.00KiB     16.00KiB         none=20
>>>>>>> none 255/7502 ---
>>>>>>> 0/7503       16.00KiB     16.00KiB         none=20
>>>>>>> none 255/7503 ---
>>>>>>
>>>>>> This is now getting super weird now.
>>>>>>
>>>>>> Firstly, if there are some snapshots of subvolume 5, it=20
>>>>>> should show up
>>>>>> here, with size over several GiB.
>>>>>>
>>>>>> Thus there seems to be some ghost/hidden subvolumes that=20
>>>>>> even don't show
>>>>>> up in qgroup.
>>>>>>
>>>>>> It's possible that some qgroup is intentionally deleted,=20
>>>>>> thus not being
>>>>>> properly updated.
>>>>>>
>>>>>> For that case, you may want to disable qgroup, re-enable,=20
>>>>>> then do a
>>>>>> rescan: (Can all be done on the running system)
>>>>>>
>>>>>> # btrfs quota disable <mnt>
>>>>>> # btrfs quota enable <mnt>
>>>>>> # btrfs quota rescan -w <mnt>
>>>>>>
>>>>>> Then provide the output of 'btrfs qgroup show -prce <mnt>"
>>>>>>
>>>>>> If the output doesn't change at all, after the full 10min=20
>>>>>> rescan, then I
>>>>>> guess you have to dump the root tree, along with the=20
>>>>>> data_reloc tree.
>>>>>>
>>>>>> # btrfs ins dump-tree -t root <device>
>>>>>> # btrfs ins dump-tree -t data_reloc <device>
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>> 1/0             0.00B        0.00B         none=20
>>>>>>> none ---      ---
>>>>>>> 255/7502     16.00KiB     16.00KiB         none=20
>>>>>>> none ---      0/7502
>>>>>>> 255/7503     16.00KiB     16.00KiB         none=20
>>>>>>> none ---      0/7503
>>>>>>> ```
>>>>>>>
>>>>>>> and i try to mount with option subvolid:
>>>>>>> ```
>>>>>>> $ mkdir /tmp/fulldisk
>>>>>>> $ sudo mount -o subvolid=3D5 /dev/sda2 /tmp/fulldisk
>>>>>>> $ ls -lA /tmp/fulldisk
>>>>>>> total 4
>>>>>>> drwxr-xr-x 1 root   root   1936 May  3 21:34 bin
>>>>>>> drwxr-xr-x 1 root   root      0 Jan 25  2020 boot
>>>>>>> drwxr-xr-x 1 root   root   1686 Jan 20  2020 dev
>>>>>>> drwxr-xr-x 1 wzy    wzy    5756 Jun 24 13:51 etc
>>>>>>> drwxr-xr-x 1 root   root     22 Oct 17  2020 home
>>>>>>> drwxr-xr-x 1 root   root   1332 May 18 14:13 lib
>>>>>>> drwxr-xr-x 1 root   root   6606 May 18 14:13 lib64
>>>>>>> lrwxrwxrwx 1 root   root     10 Jan 24 20:23 media ->=20
>>>>>>> /run/media
>>>>>>> drwxr-xr-x 1 wzy    wzy      38 Jan 27 16:51 mnt
>>>>>>> drwxr-xr-x 1 root   root    234 Jun 18 14:29 opt
>>>>>>> drwxr-xr-x 1 root   root      0 Jan 20  2020 proc
>>>>>>> drwx------ 1 wzy    wzy     536 Jun 15 20:26 root
>>>>>>> drwxr-xr-x 1 root   root     48 May 30 14:14 run
>>>>>>> drwxr-xr-x 1 root   root   4926 May 18 14:12 sbin
>>>>>>> drwxr-xr-x 1 root   root     10 Jan 20  2020 sys
>>>>>>> drwxrwxrwx 1 nobody nobody    0 Jun 18 14:34 tftproot
>>>>>>> drwxrwxrwt 1 root   root      0 May 30 14:25 tmp
>>>>>>> drwxr-xr-x 1 root   root    198 Mar 31 19:32 usr
>>>>>>> drwxr-xr-x 1 root   root    150 Apr  1 18:21 var
>>>>>>> $ sudo btrfs fi du -s /tmp/fulldisk/*
>>>>>>>         Total   Exclusive  Set shared  Filename
>>>>>>>      10.66MiB       0.00B    10.66MiB  /tmp/fulldisk/bin
>>>>>>>         0.00B       0.00B       0.00B  /tmp/fulldisk/boot
>>>>>>>         0.00B       0.00B       0.00B  /tmp/fulldisk/dev
>>>>>>>      33.34MiB    36.00KiB    33.30MiB  /tmp/fulldisk/etc
>>>>>>>      13.79GiB   784.05MiB    12.96GiB  /tmp/fulldisk/home
>>>>>>>     922.28MiB       0.00B   922.28MiB  /tmp/fulldisk/lib
>>>>>>>      23.11MiB       0.00B    23.11MiB  /tmp/fulldisk/lib64
>>>>>>> ERROR: cannot check space of '/tmp/fulldisk/media':=20
>>>>>>> Inappropriate
>>>>>>> ioctl for device
>>>>>>>         0.00B       0.00B       0.00B  /tmp/fulldisk/mnt
>>>>>>>      11.08GiB       0.00B    11.08GiB  /tmp/fulldisk/opt
>>>>>>>         0.00B       0.00B       0.00B  /tmp/fulldisk/proc
>>>>>>>      40.38MiB     4.35MiB    36.03MiB  /tmp/fulldisk/root
>>>>>>>         0.00B       0.00B       0.00B  /tmp/fulldisk/run
>>>>>>>      26.62MiB       0.00B    26.62MiB  /tmp/fulldisk/sbin
>>>>>>>         0.00B       0.00B       0.00B  /tmp/fulldisk/sys
>>>>>>>         0.00B       0.00B       0.00B=20
>>>>>>>         /tmp/fulldisk/tftproot
>>>>>>>         0.00B       0.00B       0.00B  /tmp/fulldisk/tmp
>>>>>>>      47.22GiB     1.03GiB    46.15GiB  /tmp/fulldisk/usr
>>>>>>>       5.80GiB     4.35GiB     1.45GiB  /tmp/fulldisk/var
>>>>>>> ```
>>>>>>>
>>>>>>> because media is a symbolic link so the ERROR should be=20
>>>>>>> normal.
>>>>>>> according to `btrfs fi du` it looks like i only use about=20
>>>>>>> 80GiB. it is
>>>>>>> too weird.
>>>>>>> thanks!
>>>>>>>
>>>>>>> On Thu, Jun 24, 2021 at 4:32 PM Graham Cobb=20
>>>>>>> <g.btrfs@cobb.uk.net> wrote:
>>>>>>>>
>>>>>>>> On 24/06/2021 08:45, Zhenyu Wu wrote:
>>>>>>>>> Thanks! this is some information of some programs.
>>>>>>>>> ```
>>>>>>>>> # boot from liveUSB
>>>>>>>>> $ btrfs check /dev/sda2
>>>>>>>>> [1/7] checking root items
>>>>>>>>> [2/7] checking extents
>>>>>>>>> [3/7] checking free space cache
>>>>>>>>> [4/7] checking fs roots
>>>>>>>>> [5/7] checking only csums items (without verifying data)
>>>>>>>>> [6/7] checking root refs
>>>>>>>>> [7/7] checking quota groups
>>>>>>>>> # after mount /dev/sda2 to /mnt/gentoo
>>>>>>>>
>>>>>>>> Did you do 'mount -o subvolid=3D5 /dev/sda2 /mnt/gentoo' to=20
>>>>>>>> make sure you
>>>>>>>> can see all subvolumes, not just the default subvolume? I=20
>>>>>>>> guess it
>>>>>>>> doesn't matter for quota, but it matters if you are using=20
>>>>>>>> tools like du.
>>>>>>>>
>>>>>>>> You don't even need to use a liveUSB. On your normal=20
>>>>>>>> mounted system you
>>>>>>>> can do...
>>>>>>>>
>>>>>>>> mkdir /tmp/fulldisk
>>>>>>>> mount -o subvolid=3D5 /dev/sda2 /tmp/fulldisk
>>>>>>>> ls -lA /tmp/fulldisk
>>>>>>>>
>>>>>>>> to see if there are other subvolumes which are not=20
>>>>>>>> visible in /
