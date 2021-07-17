Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5001B3CC2AB
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jul 2021 12:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhGQKvp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Jul 2021 06:51:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:54749 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhGQKvp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Jul 2021 06:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626518915;
        bh=qrfWZLjaMFyF+7D+0GWeOdeq8+wk+1j8yTxiJpRjhN0=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=hgwqcd8Npbz+6tCASMKWnv3jJILZaL2wAFf0NGgosvrQvSW9293ZydLsheMVzCSKL
         jwhefOCM+9dQ9fHWy2UYxuMniC4HU0I2ftRfDW48AWhQ67bL9sSPX9JOWPN3nEvZp5
         X+InmMz2RszCEZq1Y111cHC5ZsP1/imo/mhhlKao=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Wuq-1m1NxO3VqO-005ZU1; Sat, 17
 Jul 2021 12:48:35 +0200
To:     pepperpoint@mb.ardentcoding.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <162648632340.7.1932907459648384384.10178178@mb.ardentcoding.com>
 <162650555086.7.16811903270475408953.10183708@simplelogin.co>
 <162650826457.7.1050455337652772013.10184548@mb.ardentcoding.com>
 <162650966150.7.11743767259405124657.10185986@simplelogin.co>
 <162651226617.7.3584131829663375587.10186721@mb.ardentcoding.com>
 <162651674065.6.7912816287233908759.10188327@simplelogin.co>
 <162651809235.7.7061042874033963922.10188873@mb.ardentcoding.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Read time tree block corruption detected
Message-ID: <df3be663-ec49-8e29-4011-eac4513ad0c4@gmx.com>
Date:   Sat, 17 Jul 2021 18:48:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <162651809235.7.7061042874033963922.10188873@mb.ardentcoding.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rePU2FdRXX0VDw7jwFKcCuE1Wh5IOY6uq5jf+BXqSlQ1dLuESuh
 6ge1te1r5W062MoCju7SfrqEimdn9/canbtFaEO1QedDRRE7Q0ajytBl86iXh23qGri8fdt
 0AVBOEEVIwl0kOUGhAJ7je5NDGxAgYmE3cQpIaiTErr0z73kk4FbL5ZmmupWGnaCGVyfTQK
 /A1g53cd0CdEB4gTeexLw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EB9f1g3O7RI=:XFwNJRIH/nTuBdPI0JRuJq
 zr1NriR3d2166M5aWXCPXDpXlRAqC6/gKsFYk4mQty9DzNMiKrCOjyVw0OLNdPgexT10e+QWS
 GyhlDSiP2ODPd73G8ZA1F3n56ZbLICL3dlOl9XVZVu6dg4hph0MVZNcV8ToZqPy87ofwUtdzP
 TORV7sYmpxd3kkK+K2aqv82ETwyMcqvnmMjQ1n/51UBpokdBoBIySCLNIq71HV7jnxVJSUtyN
 fuM6wTqyCDwI/9ImYMszwHXpvggxbDc764Ll3HQsyvQ9C/8/WhR8G8OQ2Jn9MH9iVyyLKydAk
 GNNDcbizBcXtjU6p2+srJZ1H8IiT8wRVjPhkch+ieq8MhXo5aLW3U+Kgc1M8vFUzZGrweTl3s
 5gfJmp+OvhjsvXFdqE92pv3igvX+IeMIMJ+dQZOkW1QTaZwhJKfhlxflf6i94gLXfGEXutt4w
 KHDrVwiwAN/upslOUOhZT2s/1P8mT9WRO8WST0cahZfj0rRZjuE/zJrhUBVN6/uvSZWPi/BcY
 81cOpUWVIuw/FRsUL60tVXeBc2aqSz9D3XgpzqmuH13LOG2877WyjZ22fm2EIq1GVViJJ7PiQ
 EHGId+XCZlLOwoJboARCjHbDGOzX3YRpgAQsg1CEyvDOZAFsEcuIGvR2o6B8iiQbc2LkW979g
 Zxq+cAF3oPL6WwfvDZvoGUGifxzwLxzyG6m/zPpfaSriW5LwdYhGflyIaZHujvhUhwE8e3SNz
 m3jGmyDqzjP55fPEZbr90F1CCBUZ+hZzlUU96VCrASXw6J49YmDKqmMVcQFb4kWRVNd8YjgCX
 FVbFuLZxCQGtsAoJGbqeUKFHVie+ANP4I11XwcjCgFEN3DinCVQt9ln8p9yWgEqXI5ICv4IGd
 zn1mSMLnJBw27WT6GRlYe+MAaBKDhihoNGVDHhiYxwC1gnIaZScBO4HX5HIpPoYoImA4fDrWy
 wNNkwkly0J1DAU+okiScAc8AmT0Xhiz3tsc9AmB84gj+NESs5h2ai3injM7cumebj8vCJNV/O
 3E3YSLMDFNsNaCBJt5UTDXvMb/vfdyTY0GVZ6vxSMafErs64vNhA7g5/ibI3rWix6EV+TWDpW
 V3LKKgXO/i4MNc05+/U7k5VVbWzCtx/QVr3U3M0KmIyPrm7WjyA3O8O4g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/17 =E4=B8=8B=E5=8D=886:34, pepperpoint@mb.ardentcoding.com wrote=
:
> Hi Qu,
>
> Unfortunately I cannot find subvolume 363
> # btrfs subvolume list /run/media/root
> ID 361 gen 1814826 top level 584 path @/live/snapshot
> ID 364 gen 1814414 top level 5 path @vtmp/live/snapshot
> ID 369 gen 1814414 top level 5 path @vlmachines/live/snapshot
> ID 493 gen 1814414 top level 5 path @vlportables/live/snapshot
> ID 579 gen 1814828 top level 5 path @vlog/live/snapshot
> ID 580 gen 1814414 top level 5 path @vcache/live/snapshot
> ID 581 gen 1814414 top level 5 path @vlmongodb/live/snapshot
> ID 582 gen 1814414 top level 5 path @vlmysql/live/snapshot
> ID 583 gen 1814414 top level 5 path @vspool/live/snapshot
> ID 584 gen 1814414 top level 5 path @
> ID 598 gen 1813420 top level 584 path @/4/snapshot

Maybe 363 is some subvolume get deleted and later snapshot of it still
exists.

This will be harder to debug.

Can you take a btrfs-image dump of your filesystem? (needs to be taken
with the fs unmounted).

The dumped image will contain your metadata, including file names and
directory structures, but no data inside those files.

Although btrfs-image has "-s" option to mask the filenames, but
considering the filename in this case is useful to locate the inode, I
guess it's better to take the image without any "-s" option.
>
> # btrfs ins dump-tree -t 363 /dev/dm-0 | grep -A 5 "(286 "
> parent transid verify failed on 174170742784 wanted 1789655 found 181262=
1
> parent transid verify failed on 174170742784 wanted 1789655 found 181262=
1
> parent transid verify failed on 174170742784 wanted 1789655 found 181262=
1
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D174170738688 item=3D0 parent =
level=3D2 child bytenr=3D174170742784 child level=3D0

This transid mismatch may be a problem when running dump-tree on mounted
fs, since you mentioned btrfs check reported no error, there shouldn't
be a transid mismatch error.

Anyway, if you can upload the btrfs-image dump, it would be much easier
for us to debug and find out what's really going.

Thanks,
Qu

>
> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original=
 Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
>
> On Saturday, July 17th, 2021 at 6:12 PM, Qu Wenruo <wqu@suse.com> wrote:
>
>> On 2021/7/17 =E4=B8=8B=E5=8D=884:57, pepperpoint@mb.ardentcoding.com wr=
ote:
>>
>>> Hi Qu,
>>>
>>> I don't know how the directory was created but last month, I used btrf=
s device add and btrfs device remove to move the filesystem from one parti=
tion to another. It failed because of the same error and was advised to us=
e btrfs replace instead. I don't know if the error also happened before I =
move the file system as I don't have any previous logs.
>>
>> It definitely happens before you moving the fs.
>>
>> As regular dev replacing/add/move only relocates the metadata, but not
>>
>> touching the fs trees.
>>
>>> Here is the result when I search for the inodes you mentioned if it he=
lps:
>>>
>>> find /run/media/root -inum 260 -exec ls -ldi {} \;
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>>>
>>> 260 -rw-r--r-- 1 root root 36864 Jun 25 06:22 /run/media/root/@vcache/=
live/snapshot/app-info/cache/en_US.cache
>>>
>>> 260 drwx------ 1 mongodb mongodb 136 Sep 12 2020 /run/media/root/@vlmo=
ngodb/live/snapshot/diagnostic.data
>>>
>>> 260 -rw-rw---- 1 mysql mysql 50331648 Sep 13 2015 /run/media/root/@vlm=
ysql/live/snapshot/ib_logfile0
>>>
>>> 260 -rw-r----- 1 root lp 8641 Mar 5 2014 /run/media/root/@vspool/live/=
snapshot/cups/d00001-001
>>>
>>> 260 dr-xr-xr-x 1 root root 0 Sep 13 2013 /run/media/root/@/live/snapsh=
ot/sys
>>>
>>> 260 dr-xr-xr-x 1 root root 0 Sep 13 2013 /run/media/root/@/4/snapshot/=
sys
>>
>> Since btrfs can have the same inode number inside different subvolumes,
>>
>> you may want to limit the search inside subvolume 363.
>>
>> "-mount" option of find can do that, you only need to locate subvolume
>>
>> 363 by "btrfs subv list".
>>
>> But from these output I guess above two "sys" directory are more possib=
le.
>>
>> Is there any directory named "blaklight" inside those directory?
>>
>>> find /run/media/root -inum 286 -exec ls -ldi {} \;
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>>>
>>> 286 -rw-r--r-- 1 root root 96 Aug 16 2015 /run/media/root/@vcache/live=
/snapshot/fontconfig/4b172ca7f111e3cffadc3636415fead9-le64.cache-4
>>>
>>> 286 -rw-rw---- 1 mysql mysql 4096 Sep 15 2013 /run/media/root/@vlmysql=
/live/snapshot/mysql/columns_priv.MYI
>>>
>>> 286 -rw-r-----+ 1 root systemd-journal 16777216 Jul 4 01:14 /run/media=
/root/@vlog/live/snapshot/journal/5098dd7845ae46d3ba1826c68a809a7c/user-10=
00@fbd9f65d0ea349f6b996716280e6c4dd-00000000002314c5-0005c5cb84a3a438.jour=
nal
>>
>> This is interesting, it means the inode 286 is not accessible.
>>
>> It can be some orphan inode, but would you dump subvolume 363 then try
>>
>> to locate the inode 286?
>>
>> One example command would be:
>>
>> btrfs ins dump-tree -t 363 <dev> | grep -A 5 "(286 "
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>
>> Thanks,
>>
>> Qu
>>
>>> Directories with pattern /root/@<dir>/live/snapshot/ are subvolumes an=
d directories with pattern /root/@<dir>/<num>/snapshot/ are snapshots of l=
ive.
>>>
>>> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Origin=
al Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
>>>
>>> On Saturday, July 17th, 2021 at 4:14 PM, Qu Wenruo quwenruo.btrfs@gmx.=
com wrote:
>>>
>>>> On 2021/7/17 =E4=B8=8B=E5=8D=883:51, pepperpoint@mb.ardentcoding.com =
wrote:
>>>>
>>>>> Hi Qu,
>>>>>
>>>>> Please see below for the dump.
>>>>>
>>>>> btrfs-progs v5.12.1
>>>>>
>>>>> leaf 174113599488 items 18 free space 2008 generation 1330906 owner =
363
>>>>>
>>>>> leaf 174113599488 flags 0x1(WRITTEN) backref revision 1
>>>>>
>>>>> fs uuid a7d327c4-8594-4116-a6f8-8aa2a4162063
>>>>>
>>>>> chunk uuid f885f49e-14a0-4c80-9c12-c2302b9a0229
>>>>>
>>>>> item 0 key (5471 INODE_ITEM 0) itemoff 3835 itemsize 160
>>>>>
>>>>> generation 2063 transid 27726 size 40 nbytes 40
>>>>>
>>>>> block group 0 mode 100600 links 1 uid 0 gid 100 rdev 0
>>>>>
>>>>> sequence 1501 flags 0x0(none)
>>>>>
>>>>> atime 1386484844.468769570 (2013-12-08 14:40:44)
>>>>>
>>>>> ctime 1386484844.468769570 (2013-12-08 14:40:44)
>>>>>
>>>>> mtime 1386484844.468769570 (2013-12-08 14:40:44)
>>>>>
>>>>> otime 0.0 (1970-01-01 08:00:00)
>>>>>
>>>>> item 1 key (5471 INODE_REF 4399) itemoff 3824 itemsize 11
>>>>>
>>>>> index 12 namelen 1 name: 8
>>>>>
>>>>> item 2 key (5471 EXTENT_DATA 0) itemoff 3763 itemsize 61
>>>>>
>>>>> generation 27726 type 0 (inline)
>>>>>
>>>>> inline extent data size 40 ram_bytes 40 compression 0 (none)
>>>>>
>>>>> item 3 key (5645 INODE_ITEM 0) itemoff 3603 itemsize 160
>>>>>
>>>>> generation 2542 transid 61261 size 40 nbytes 40
>>>>>
>>>>> block group 0 mode 100600 links 1 uid 0 gid 100 rdev 0
>>>>>
>>>>> sequence 24769 flags 0x0(none)
>>>>>
>>>>> atime 1394335806.351857522 (2014-03-09 11:30:06)
>>>>>
>>>>> ctime 1394335827.344389955 (2014-03-09 11:30:27)
>>>>>
>>>>> mtime 1394335827.344389955 (2014-03-09 11:30:27)
>>>>>
>>>>> otime 0.0 (1970-01-01 08:00:00)
>>>>>
>>>>> item 4 key (5645 INODE_REF 4399) itemoff 3592 itemsize 11
>>>>>
>>>>> index 13 namelen 1 name: 7
>>>>>
>>>>> item 5 key (5645 EXTENT_DATA 0) itemoff 3531 itemsize 61
>>>>>
>>>>> generation 61261 type 0 (inline)
>>>>>
>>>>> inline extent data size 40 ram_bytes 40 compression 0 (none)
>>>>>
>>>>> item 6 key (7222 INODE_ITEM 0) itemoff 3371 itemsize 160
>>>>>
>>>>> generation 5754 transid 5767 size 307 nbytes 307
>>>>>
>>>>> block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
>>>>>
>>>>> sequence 7 flags 0x0(none)
>>>>>
>>>>> atime 1379834835.428558020 (2013-09-22 15:27:15)
>>>>>
>>>>> ctime 1379834835.428558020 (2013-09-22 15:27:15)
>>>>>
>>>>> mtime 1379834835.428558020 (2013-09-22 15:27:15)
>>>>>
>>>>> otime 0.0 (1970-01-01 08:00:00)
>>>>>
>>>>> item 7 key (7222 INODE_REF 287) itemoff 3344 itemsize 27
>>>>>
>>>>> index 6 namelen 17 name: dhcpcd-eth0.lease
>>>>>
>>>>> item 8 key (7222 EXTENT_DATA 0) itemoff 3016 itemsize 328
>>>>>
>>>>> generation 5767 type 0 (inline)
>>>>>
>>>>> inline extent data size 307 ram_bytes 307 compression 0 (none)
>>>>>
>>>>> item 9 key (7415 INODE_ITEM 0) itemoff 2856 itemsize 160
>>>>>
>>>>> generation 5904 transid 1330906 size 180 nbytes 0
>>>>>
>>>>> block group 0 mode 40755 links 2 uid 0 gid 0 rdev 0
>>>>>
>>>>> sequence 177 flags 0x0(none)
>>>>>
>>>>> atime 1483277713.141980592 (2017-01-01 21:35:13)
>>>>>
>>>>> ctime 1563162901.234656246 (2019-07-15 11:55:01)
>>>>>
>>>>> mtime 1406534032.158605559 (2014-07-28 15:53:52)
>>>>>
>>>>> otime 0.0 (1970-01-01 08:00:00)
>>>>
>>>> This inode is indeed a directory.
>>>>
>>>> But it has two hard links, which is definitely something unexpected.
>>>>
>>>> Under Linux we shouldn't have any hardlink for directory, as it would
>>>>
>>>> easily lead to loops.
>>>>
>>>>> item 10 key (7415 INODE_REF 260) itemoff 2837 itemsize 19
>>>>>
>>>>> index 28 namelen 9 name: backlight
>>>>
>>>> Its parent inode is 260 in the same root, with the name backlight.
>>>>
>>>>> item 11 key (7415 INODE_REF 286) itemoff 2818 itemsize 19
>>>>>
>>>>> index 3 namelen 9 name: backlight
>>>>
>>>> Another hardlink in inode 286, which is definitely a regular thing.
>>>>
>>>> Btrfs-progs lacks the ability to detect such problem, we need to enha=
nce
>>>>
>>>> it first.
>>>>
>>>> But do you have any idea how this directory get created?
>>>>
>>>> It looks like the content of sysfs.
>>>>
>>>> Thanks,
>>>>
>>>> Qu
>>>>
>>>>> item 12 key (7415 DIR_ITEM 3128336373) itemoff 2746 itemsize 72
>>>>>
>>>>> location key (120417 INODE_ITEM 0) type FILE
>>>>>
>>>>> transid 117279 data_len 0 name_len 42
>>>>>
>>>>> name: pci-0000:00:02.0:backlight:intel_backlight
>>>>>
>>>>> item 13 key (7415 DIR_ITEM 3218198317) itemoff 2705 itemsize 41
>>>>>
>>>>> location key (7487 INODE_ITEM 0) type FILE
>>>>>
>>>>> transid 5992 data_len 0 name_len 11
>>>>>
>>>>> name: acpi_video0
>>>>>
>>>>> item 14 key (7415 DIR_ITEM 3582254411) itemoff 2638 itemsize 67
>>>>>
>>>>> location key (55325 INODE_ITEM 0) type FILE
>>>>>
>>>>> transid 63351 data_len 0 name_len 37
>>>>>
>>>>> name: platform-VPC2004:00:backlight:ideapad
>>>>>
>>>>> item 15 key (7415 DIR_INDEX 2) itemoff 2597 itemsize 41
>>>>>
>>>>> location key (7487 INODE_ITEM 0) type FILE
>>>>>
>>>>> transid 5992 data_len 0 name_len 11
>>>>>
>>>>> name: acpi_video0
>>>>>
>>>>> item 16 key (7415 DIR_INDEX 4) itemoff 2530 itemsize 67
>>>>>
>>>>> location key (55325 INODE_ITEM 0) type FILE
>>>>>
>>>>> transid 63351 data_len 0 name_len 37
>>>>>
>>>>> name: platform-VPC2004:00:backlight:ideapad
>>>>>
>>>>> item 17 key (7415 DIR_INDEX 5) itemoff 2458 itemsize 72
>>>>>
>>>>> location key (120417 INODE_ITEM 0) type FILE
>>>>>
>>>>> transid 117279 data_len 0 name_len 42
>>>>>
>>>>> name: pci-0000:00:02.0:backlight:intel_backlight
>>>>>
>>>>> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Orig=
inal Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=
=90
>>>>>
>>>>> On Saturday, July 17th, 2021 at 3:05 PM, Qu Wenruo quwenruo.btrfs@gm=
x.com wrote:
>>>>>
>>>>>> On 2021/7/17 =E4=B8=8A=E5=8D=889:45, pepperpoint@mb.ardentcoding.co=
m wrote:
>>>>>>
>>>>>>> Hello,
>>>>>>>
>>>>>>> I see this message on dmesg:
>>>>>>>
>>>>>>> [ 2452.256756] BTRFS critical (device dm-0): corrupt leaf: root=3D=
363 block=3D174113599488 slot=3D9 ino=3D7415, invalid nlink: has 2 expect =
no more than 1 for dir
>>>>>>>
>>>>>>> [ 2452.256776] BTRFS error (device dm-0): block=3D174113599488 rea=
d time tree block corruption detected
>>>>>>
>>>>>> Please provide the following dump:
>>>>>>
>>>>>> btrfs ins dump-tree -b 174113599488 /dev/dm-0
>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> Qu
>>>>>>
>>>>>>> When I run btrfs scrub and btrfs check, no error was detected.
>>>>>>>
>>>>>>> I am running Linux 5.12.15-arch1-1 and btrfs-progs v5.12.1
>>>>>>>
>>>>>>> How should I fix this error?
