Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193603CC1F7
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jul 2021 10:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbhGQIRb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Jul 2021 04:17:31 -0400
Received: from mout.gmx.net ([212.227.15.19]:38729 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232789AbhGQIRU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Jul 2021 04:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626509650;
        bh=jOV6qyWgo5a8t95OavvjMcu2ZRi5zLwb9xUu5yAx/KU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BTU9YTEiPhleDw5oGb0HG4z9cX68AgSoLM0nJlRHOZ037utdFlOODrSxJ26yslPly
         w9vIxEdKaZRkfZp0c9n0Loo2qZl7K0pKQhLc+AqbCxg9FwYh4d5cmou2e1LljnmHPv
         L7VzZBxNQkqZ9Rv94JZfy7NBWL6LUY7tEJuO/nxY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N6KYl-1l36SG3pcH-016jeP; Sat, 17
 Jul 2021 10:14:10 +0200
Subject: Re: Read time tree block corruption detected
To:     pepperpoint@mb.ardentcoding.com
Cc:     linux-btrfs@vger.kernel.org
References: <162648632340.7.1932907459648384384.10178178@mb.ardentcoding.com>
 <162650555086.7.16811903270475408953.10183708@simplelogin.co>
 <162650826457.7.1050455337652772013.10184548@mb.ardentcoding.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <e33be945-1db8-c97e-af68-afa70e624d22@gmx.com>
Date:   Sat, 17 Jul 2021 16:14:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <162650826457.7.1050455337652772013.10184548@mb.ardentcoding.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xBYsR+RuTMlocr5EjFdiWC8/Gnx7MnLOLvGRLrk1KpVzOMy9Q8z
 V4/ISDEVQH9EwApvHm7YsCx7pncgHknSe4xf+2hhXXVaHyykoRo3C6SigWkqLHe8V49/zaQ
 +aD7beNVuKwtBgZSC7si98MhjzG4drIDpnGGUhyt+9JJZBaTYxb0pFppOajUsrZsHV8dvAW
 6nKmlmASumPn34gWbrF2w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Y+EwhTYNDY=:tKvcQg3ytAHcnW+I3eUUjb
 n00ZGCGq5KrhvOk45aSD7xAf5LV2LoEfBdAgqH/gK4XKpNNCEm0CA7iPicVN8vtGa1NNx85o7
 1qFlSUYiiEGJDLHMaqf6PbYKYxVdrInyWtQBt5ajK5shDm004pABCmiLXegRZrJjdeBFmuz8A
 jVihzKfI6Xj5xDYqC6W6KruNZf49yezxq+qYkvzF8hAUaXanPThYBxDf+7R6xj5rBkriuafDy
 2OCocht1hrVkYjEuGuQT+apVl5LOC6PgLZPa149roK262imUqKfDiNmrwYWLwOKrKlgbltdi6
 eqgnLLa3vhxeYSlaAeQYbqUuC1NVEs/b0uHL9UgT9mG9OqeKNBGS38pJfLXT01ejRBNPDR5VW
 oyy3hJ/ntoBDeGDhu2pRYy8hFePbl2STLpTPOdpkyu3bkQK6p2DZoB9Mf/mHP7yzyI4VSdztm
 3UW4XBXwAu5CQlLU98mlG3aYG0DFZO8mcWeov6gz5C73slGpWJeqdD1cVOXVW/xIhQ7Lg2iSj
 H+UvQGbeOXQ8oUOd7rds1OfrV0U1rhqUSEVtYrF0gO7O4xmx1vg05KTFNrqvfr6ig/KKp9JRJ
 wCxFPo6v24h6ixPPte9i2ppmAaBPW1sDxTDPCjW5XOGKhwAn+HkO5l+Cpjx2XcXWVwpjD40uc
 jFIl6mW7ljZ4zr+7aV98aV8/jSQZj+lXgkYraHKV8QXsBkqxkQiwtIThTegrwpIhSiZMS/Iue
 x9d4J+y4Irf3i1Cbg7+wUcuZvxB5t6Cx5KJMx+N+qwIdQ8Pm/fgHHYWxfMTBeefvAB6NTTgI7
 bxMg6IE+cjWFNUAy6hL1BS3weh87v8pWeZ0/NQCWi8IoBS7WVR+9y02XlNQHOVByIK946zK6n
 UNXElB5uUYe6GKpS/Ne2pJqjrqs5fHClk3zlNrBEqj4ESpR4DzcnYPvHFvXHbOjHhK1kApGml
 aHbKAcVwR23fmhvKoMtMaLDw7ka8ffoaeqyvsjo9T6r9LHOtlnVD0L1eaJ6jCJjqX1ag/BZNb
 xsHTSYYzp4ySmjXNOpokg3RGCdMTZRDebcYg/iA0SAqNcCYXtYqb5C0tfpZXp/sYJRqw1kSd6
 pzwvK9fVXsKmn83/G1XVIMDPQtTxvqLabFcwK/BvAqb0R8wqHoIHKk2HA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/17 =E4=B8=8B=E5=8D=883:51, pepperpoint@mb.ardentcoding.com wrote=
:
> Hi Qu,
>
> Please see below for the dump.
>
> btrfs-progs v5.12.1
> leaf 174113599488 items 18 free space 2008 generation 1330906 owner 363
> leaf 174113599488 flags 0x1(WRITTEN) backref revision 1
> fs uuid a7d327c4-8594-4116-a6f8-8aa2a4162063
> chunk uuid f885f49e-14a0-4c80-9c12-c2302b9a0229
> 	item 0 key (5471 INODE_ITEM 0) itemoff 3835 itemsize 160
> 		generation 2063 transid 27726 size 40 nbytes 40
> 		block group 0 mode 100600 links 1 uid 0 gid 100 rdev 0
> 		sequence 1501 flags 0x0(none)
> 		atime 1386484844.468769570 (2013-12-08 14:40:44)
> 		ctime 1386484844.468769570 (2013-12-08 14:40:44)
> 		mtime 1386484844.468769570 (2013-12-08 14:40:44)
> 		otime 0.0 (1970-01-01 08:00:00)
> 	item 1 key (5471 INODE_REF 4399) itemoff 3824 itemsize 11
> 		index 12 namelen 1 name: 8
> 	item 2 key (5471 EXTENT_DATA 0) itemoff 3763 itemsize 61
> 		generation 27726 type 0 (inline)
> 		inline extent data size 40 ram_bytes 40 compression 0 (none)
> 	item 3 key (5645 INODE_ITEM 0) itemoff 3603 itemsize 160
> 		generation 2542 transid 61261 size 40 nbytes 40
> 		block group 0 mode 100600 links 1 uid 0 gid 100 rdev 0
> 		sequence 24769 flags 0x0(none)
> 		atime 1394335806.351857522 (2014-03-09 11:30:06)
> 		ctime 1394335827.344389955 (2014-03-09 11:30:27)
> 		mtime 1394335827.344389955 (2014-03-09 11:30:27)
> 		otime 0.0 (1970-01-01 08:00:00)
> 	item 4 key (5645 INODE_REF 4399) itemoff 3592 itemsize 11
> 		index 13 namelen 1 name: 7
> 	item 5 key (5645 EXTENT_DATA 0) itemoff 3531 itemsize 61
> 		generation 61261 type 0 (inline)
> 		inline extent data size 40 ram_bytes 40 compression 0 (none)
> 	item 6 key (7222 INODE_ITEM 0) itemoff 3371 itemsize 160
> 		generation 5754 transid 5767 size 307 nbytes 307
> 		block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
> 		sequence 7 flags 0x0(none)
> 		atime 1379834835.428558020 (2013-09-22 15:27:15)
> 		ctime 1379834835.428558020 (2013-09-22 15:27:15)
> 		mtime 1379834835.428558020 (2013-09-22 15:27:15)
> 		otime 0.0 (1970-01-01 08:00:00)
> 	item 7 key (7222 INODE_REF 287) itemoff 3344 itemsize 27
> 		index 6 namelen 17 name: dhcpcd-eth0.lease
> 	item 8 key (7222 EXTENT_DATA 0) itemoff 3016 itemsize 328
> 		generation 5767 type 0 (inline)
> 		inline extent data size 307 ram_bytes 307 compression 0 (none)
> 	item 9 key (7415 INODE_ITEM 0) itemoff 2856 itemsize 160
> 		generation 5904 transid 1330906 size 180 nbytes 0
> 		block group 0 mode 40755 links 2 uid 0 gid 0 rdev 0
> 		sequence 177 flags 0x0(none)
> 		atime 1483277713.141980592 (2017-01-01 21:35:13)
> 		ctime 1563162901.234656246 (2019-07-15 11:55:01)
> 		mtime 1406534032.158605559 (2014-07-28 15:53:52)
> 		otime 0.0 (1970-01-01 08:00:00)

This inode is indeed a directory.

But it has two hard links, which is definitely something unexpected.

Under Linux we shouldn't have any hardlink for directory, as it would
easily lead to loops.

> 	item 10 key (7415 INODE_REF 260) itemoff 2837 itemsize 19
> 		index 28 namelen 9 name: backlight

Its parent inode is 260 in the same root, with the name backlight.

> 	item 11 key (7415 INODE_REF 286) itemoff 2818 itemsize 19
> 		index 3 namelen 9 name: backlight

Another hardlink in inode 286, which is definitely a regular thing.

Btrfs-progs lacks the ability to detect such problem, we need to enhance
it first.

But do you have any idea how this directory get created?
It looks like the content of sysfs.

Thanks,
Qu

> 	item 12 key (7415 DIR_ITEM 3128336373) itemoff 2746 itemsize 72
> 		location key (120417 INODE_ITEM 0) type FILE
> 		transid 117279 data_len 0 name_len 42
> 		name: pci-0000:00:02.0:backlight:intel_backlight
> 	item 13 key (7415 DIR_ITEM 3218198317) itemoff 2705 itemsize 41
> 		location key (7487 INODE_ITEM 0) type FILE
> 		transid 5992 data_len 0 name_len 11
> 		name: acpi_video0
> 	item 14 key (7415 DIR_ITEM 3582254411) itemoff 2638 itemsize 67
> 		location key (55325 INODE_ITEM 0) type FILE
> 		transid 63351 data_len 0 name_len 37
> 		name: platform-VPC2004:00:backlight:ideapad
> 	item 15 key (7415 DIR_INDEX 2) itemoff 2597 itemsize 41
> 		location key (7487 INODE_ITEM 0) type FILE
> 		transid 5992 data_len 0 name_len 11
> 		name: acpi_video0
> 	item 16 key (7415 DIR_INDEX 4) itemoff 2530 itemsize 67
> 		location key (55325 INODE_ITEM 0) type FILE
> 		transid 63351 data_len 0 name_len 37
> 		name: platform-VPC2004:00:backlight:ideapad
> 	item 17 key (7415 DIR_INDEX 5) itemoff 2458 itemsize 72
> 		location key (120417 INODE_ITEM 0) type FILE
> 		transid 117279 data_len 0 name_len 42
> 		name: pci-0000:00:02.0:backlight:intel_backlight
>
>
> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original=
 Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
>
> On Saturday, July 17th, 2021 at 3:05 PM, Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
>
>> On 2021/7/17 =E4=B8=8A=E5=8D=889:45, pepperpoint@mb.ardentcoding.com wr=
ote:
>>
>>> Hello,
>>>
>>> I see this message on dmesg:
>>>
>>> [ 2452.256756] BTRFS critical (device dm-0): corrupt leaf: root=3D363 =
block=3D174113599488 slot=3D9 ino=3D7415, invalid nlink: has 2 expect no m=
ore than 1 for dir
>>>
>>> [ 2452.256776] BTRFS error (device dm-0): block=3D174113599488 read ti=
me tree block corruption detected
>>
>> Please provide the following dump:
>>
>> btrfs ins dump-tree -b 174113599488 /dev/dm-0
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Thanks,
>>
>> Qu
>>
>>> When I run btrfs scrub and btrfs check, no error was detected.
>>>
>>> I am running Linux 5.12.15-arch1-1 and btrfs-progs v5.12.1
>>>
>>> How should I fix this error?
