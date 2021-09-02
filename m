Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910273FF7F8
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 01:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346279AbhIBXmj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 19:42:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:55415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346276AbhIBXmi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Sep 2021 19:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630626098;
        bh=21EKrJjlrilG4hd8By8yqsoXh6i/d6kOnWlFxSkq6tQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=g2OnRR/8VbnFMvJ7MJMXILuQLBu7CeKT1udqBaGQLQU5YPkNMZhDiuF7ZH3W6KSoG
         Z/uHSlMYnbcaMJ6ZbfumSc9dEWHdepE5P6qJD2aNShZILzdwbX0bmrSxLHN07JuA40
         WCy+eZy/PQ2EvzlM4oZA1ml8+Y1s6QGlh/6G/3JU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mnpnm-1mkot12Bq6-00pQ3j; Fri, 03
 Sep 2021 01:41:38 +0200
Subject: Re: fallocate + ftruncate
To:     Julien Muchembled <jm@nexedi.com>, linux-btrfs@vger.kernel.org
Cc:     Vincent Pelletier <vincent@nexedi.com>
References: <ed3642c2-682e-08a1-f18d-2d63409b7631@nexedi.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <0aa8496e-a666-8fda-8a50-78b4f7890b20@gmx.com>
Date:   Fri, 3 Sep 2021 07:41:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ed3642c2-682e-08a1-f18d-2d63409b7631@nexedi.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GrVSV/lRrjVgssfQ9i2B0wTxCuDn4JMW8CX77qk5GogFGWB1GIY
 UNe8WgzvhbZnQcQ1LhzehKR3spFZ9wCXyDSjQKJzu1L1ttLGu9OXAt6Zb7Rj8PhwPDhxVJB
 Vp43R8K5kSIrvDJcwOKjRE5BTaBRY/+OB/J2lSqpfzrtMVPAdlIDXVy21wvQu/xv5srk8uK
 QiX76pBsuc1PfNIb/4B5g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ym6/QFkKZhw=:c/2K5JEdnzUDDL03UIDId1
 SHaYZ5XLidQc5vJVXJ9fHl/+zPTOB1kDdOOUR7VBYYzVa3ilPpnnbfh1mLzT0Qj0ozQnamT56
 +iXKu1iPl0eyeWfwFlMuRQO7UywWJXmhDIMhd4bmz9CrKnMEfu8CMuSXjjdGccesZcglyl7ac
 Tw+9qukT5OvYHkK/Yit7gPz03RGHcwOpAPEHhTojVa/lJ3WJQpH13VWbpvB8rpQls4y+0fcEM
 lCmZHt3dqemfagMZYzeetmjfQHXTlkEXptlQ/wSdkXM4zq4qeF0J2ihpxihURtRN3KbqJMNr8
 hqouj0Yhx7ECXqS8HOkltyCAbzem3k8fNRYzEdxA/863kDE2t/XmCd6Ry9BCdFtgatt3r37TY
 +hSGUbmApqxhIvKWBd0WoEAEnobw+wlBfIC+qUGj8UCQ4omEHam5MTwh3Kq5nOVklmKEQBlKl
 qTl+qNYFfw4OuOX3oqUEY5qml3ZM0inpXKcU72sfSDfc9O5omTKQgGep/plOQnmOVEfSarkMB
 MBENWLb6P/Sv5Hn7fFNStLBQvdjQ7Ygcro+tkVlMAJ5al4Pdt+KKWSjZbCYwn8D481FfEZkta
 AC9vhEWZ2HAo9UEZoSucnT+5ESI7wTBDK6nNRfPhlw12Ao6uQLb8Rruyq2PCdRf/usZ8UzeKp
 wx7gbVpUuzXiZe5wDYCUC8B2pzULGAzLQbTy66ZThzQ85NjWZwab5VT0xJz+Q4tymnoY5quLY
 HsMw19F5qJH2ev9/Nx7W1KnJmFXGtxpoGwkTM8/5yaBiAdvGmN4E2g/snCA8ylCbc6qHjlP6W
 HuJaaMgWOsE6frhr6HnxO46qtX6N8THEOhbkEgU7tQ9JHAOFn/4Gm4A/jw/1AI/XGiKROXuw1
 F5LmILGjzV3D5yKimUdezXNnx2d7+bZS02AxFqvgOa3lGgoEm8wrHEmJBitMuRSVqSCt1URKO
 asFbi1o5wvEc6YGCBeeGb3jypc/cAwf9JKvuOiBLWDtk0cVrkUPcdkH4mYv5sLITrrp5ra9DP
 u3OiEROuQtNZ5pjGTKEJgOVfefzN6z6PTb+YENoD3xQ+aa0vhXedW8agH2bLgY1AIHM5c904G
 +F2+aEx/2YEoRh8bJLWmNtQZH7Uhu3Bp2VfS2UfuCZbgd/micLC8D2Etg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/3 =E4=B8=8A=E5=8D=882:04, Julien Muchembled wrote:
> I'd like to report what seems to be a Btrfs bug. XFS does not have this =
issue.
>
> On a machine (kernel 4.19.181) that has several RocksDB databases, some =
on XFS and other on Btrfs, we noticed that disk usage increases significan=
tly faster on Btrfs. RocksDB pattern for SST files is:
>
> 1. fallocate(A)
> 2. write(B) with B < A
> 3. fruncate(B)
> 4. close

This is caused by btrfs extent bookend.

For 1. We allocate an extent whose size is round_up(A, sectorsize)

Then 2 happens, which writes round_up(B, sectorsize) to the existing
preallocated extent.
So far so good.

For 3, we just reduce the inode size, resizing the existing file extent
just to point to part of the preallocated extent, and call it a day.

The preallocated extent whose size is round_up(A, sectorsize) will only
be freed if the whole extent is no longer used by any inode.

Thus the truncate won't free any space.

This is quite different from XFS, as XFS is CoW-when-needed, while btrfs
is CoW-by-default.

Thus btrfs frees its extent in a very lazy way.

Thanks,
Qu
>
> And no more modification after that.
>
> It took us a while to understand what's going on because strangely, even=
 'btrfs filesystem du' does not report the actual disk usage. compsize doe=
s, e.g.
>
>    # stat mariadb/#rocksdb/164719.sst
>      File: mariadb/#rocksdb/164719.sst
>      Size: 8127109         Blocks: 15880      IO Block: 4096   regular f=
ile
>    Device: 33h/51d Inode: 24913       Links: 1
>    ...
>    # compsize -b mariadb/#rocksdb/164719.sst
>    Type       Perc     Disk Usage   Uncompressed Referenced
>    TOTAL      100%     147640320    147640320    8130560
>    none       100%     147640320    147640320    8130560
>
> Almost 140MB wasted.
>
> compsize is a bit old but btrfs-search-metadata confirms there's only 1 =
extent:
>    inode objectid 24913 generation 184524 transid 184524 size 8127109 nb=
ytes 8130560 block_group 0 mode 0100640 nlink 1 uid 982 gid 1019 rdev 0 fl=
ags 0x10(PREALLOC)
>    inode ref list objectid 24913 parent_objectid 283 size 1
>      inode ref index 24528 name utf-8 '164719.sst'
>    extent data at 0 generation 184524 ram_bytes 147640320 compression no=
ne type regular disk_bytenr 1210397491200 disk_num_bytes 147640320 offset =
0 num_bytes 8130560
>
> I could reproduce the issue on kernel 5.13.9, with the following program=
:
>
> #define _GNU_SOURCE
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <unistd.h>
>
> int main(int argc, char *argv[])
> {
>    char buf[4096];
>    int fd =3D open(argv[1], O_CREAT|O_WRONLY|O_EXCL, 0666);
>    if (fd < 0 || fallocate(fd, FALLOC_FL_KEEP_SIZE, 0, 1<<24) < 0)
>      return -1;
>    size_t n =3D 0;
>    for (ssize_t i; i =3D read(0, buf, sizeof buf);) {
>      if (i < 0 || write(fd, buf, i) !=3D i)
>        return -1;
>      n +=3D i;
>    }
>    if (ftruncate(fd, n) < 0 ||
>        close(fd) < 0)
>      return -1;
>    return 0;
> }
>
> $ ./tst dst < src # src size should be < 16MiB
>
> $ stat dst
>    File: dst
>    Size: 19374           Blocks: 40         IO Block: 4096   regular fil=
e
> Device: 3eh/62d Inode: 2253170     Links: 1
> ...
>
> $ compsize -b dst
> Processed 1 file, 1 regular extents (1 refs), 0 inline.
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL      100%     16777216     16777216     20480
> prealloc   100%     16777216     16777216     20480
>
> 'btrfs fi defrag dst' does nothing, probably because there's only 1 exte=
nt.
>
> While trying to fix the file, I found what may be another bug. I tried m=
any options of /usr/bin/fallocate without success. But the strangest is:
>
> $ fallocate -p -o 19374 -l 16777216 dst
>
> I hoped that deallocation shrinks the extent but instead it appends a se=
cond one:
>
> $ compsize -b dst
> Processed 1 file, 2 regular extents (2 refs), 0 inline.
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL      100%     16781312     16781312     20480
> none       100%     16781312     16781312     20480
>
> Ironically, now that I have a second extent:
>
> $ btrfs fi defrag dst
>
> $ compsize -b dst
> Processed 1 file, 1 regular extents (1 refs), 0 inline.
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL      100%     20480        20480        20480
> none       100%     20480        20480        20480
>
> Julien
>
