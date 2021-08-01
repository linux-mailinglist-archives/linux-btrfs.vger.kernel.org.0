Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7343DCE35
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Aug 2021 01:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhHAX4Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Aug 2021 19:56:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:37433 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231361AbhHAX4Q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 1 Aug 2021 19:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627862166;
        bh=vKZ9dSgWrtkszFlxtkxm2+37CFjptYe/kXq8JCGkej4=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=lVQLaEdTxg2OJuxjbdc+CYh8AEWt2IfbQ5zVgzvjpFqR8WLVcFHzcMmEewSND8kAp
         QAoZl9j0OVScCsVWNLJND3heinkLw+Vffx7YQssxfT/JG5HdEO9rVmiNJO1ciBbFgd
         OLF005vNbSPqs7u4nZyQ+d7EeTmt7I4Kt7MUytDw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVeI8-1mZfhR14gm-00RW12; Mon, 02
 Aug 2021 01:56:05 +0200
To:     Caleb Cushing <xenoterracide@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAAHKNRHLfGhuhR7+XKLN=3oN6B+_h7ARRJ90kFjMvVeFHCwtcA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: abysmal performance on newly created filesystem on nvme device
Message-ID: <2dab78e5-d43a-0709-efad-2f95845dbe4f@gmx.com>
Date:   Mon, 2 Aug 2021 07:56:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAAHKNRHLfGhuhR7+XKLN=3oN6B+_h7ARRJ90kFjMvVeFHCwtcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aTL+uj9dwpfFdWjUGDqXp/x+GXzfkTAt3/fyb3iytbvs39fLuUD
 c37O81PL1C7PB4FNlECixSk6pVBColSr1HnPU0uIpGrXmn+rXa2JBkfQBbUCaU9tgX+J8BT
 bWP1uormHdx0oDtZ76PEvRRMBNDSc+6PWIZpYbhN+N29zZgcsMCdMgqJpZLR/4hYHE2aVYw
 EcRRhTpv56fviOa8dAIuQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ftYSO5wyBVE=:H0P7GWXwowmqSm+X2m4tRx
 1cZNWRfLXsLQHSxiKhorlyUlSfwA490V0B91WZlu4cZ3YlG39iWU7kuurUD9CvzR0iNvzuoOq
 ZTICsRYOy/xXc4L8d3zmY0Uz9IawHtn5quHIYW80cC1PohAP6NTEE+BG8rU0rI2AT1IZtvJd8
 o6/PhM1k1XfNC5FAQJ+3DBCjaRZPaBAQVlmBQghNND7J9ut2JJxWYxLL7EXLwrPdaZDuuxRLk
 QG4ErNp59Y4XMf/rTMQbw3/CCcX7tZUlnDgUj2KF2nYza2i7RfZkx03O3cRQCg3nKB3pJCbKt
 xZOnROssABr2rSauXJEmbuAjspgfzWTjTtmE9MSn5+zsK+V3fJ1KuyLVf7pFPRDJFfhfLsuUM
 0geuwS3B75FcvGC9nWQ/Uozda3LAcWyzccFGU5ZNSxrOvTevS+OQJoWKEFEYPVZ94StzzVqdN
 CzM6ZL2Q4irK/m0uGFd4LoXU26T2i5cRmK2BBkQwQDnTw6HBIXiW17lnydaQ7dXHhG/hO+SIZ
 uBo3daO4R0vRYLalGanqArdbD3D8Tq4/ouXJoYztua4Gvq/pI7+GfJbBmbqBv1QjGgrbiwkXF
 ymD/8UoEKUYztTL50CCCFtI5J7VnmyA5QZWa/NnZExS6TGPXodbswuIUzVhP1cLRup3WHh6Z9
 qmFSB+BXbiBUebwa4CHunxCsMMulkvXSIawxmcVR31ztTsIfDOuRwpWseBfQAuwHzZIxpiaqv
 HsDz6A05so2EikW9F7vdBVemfWlmhENQH5LpFbiFANMo0iByhYVBYmGIQerWV5//oOHjP16jT
 cPdFHCnnd3Wkmi8VvEFqdADqjI624WHi6nXR8pFqxU65c+nKBtUfKbLwPfPwRLMlpZQQlHXJ6
 kPzZRwsryBdEWE1Xeus26bJTGcthYe3PkKrjhtXMRY0K0FM2L/uGFUD1rffgiszqkIP19JyFq
 wz/n0dB5s7z/xAwT6Fz141vsqgj5R/4jQ7NZ9ixUbcfJGXcVu5TZcbbGFzoCv1boy6jaTvOdC
 +KaelxXC0TsWx9mP5zChvUiqaKA9aFFL6RlG8HOZge556CIFHVz9ph/52dxcdG2DP4/zT39lU
 fg76XJ+j+78NiP4VA97IUxXlXqQEp/MgKrRwthzSgEFvi8XNvgcdgmi9Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/2 =E4=B8=8A=E5=8D=884:15, Caleb Cushing wrote:
> ok, to start, I'm running this all from a livecd, so nothing else is
> doing any IO, I haven't tuned the ISO in any way, the only change I've
> made in the live environment is installing fio (and I guess enabling
> zram, but eh).
>
> [manjaro-gnome /]#   uname -a
>    btrfs --version
>    btrfs fi show
> Linux manjaro-gnome 5.10.42-1-MANJARO #1 SMP PREEMPT Thu Jun 3
> 14:37:11 UTC 2021 x86_64 GNU/Linux
> btrfs-progs v5.12.1
> Label: 'home'  uuid: 75dc7a2c-9268-4bf6-b95b-e77eab133f57
>      Total devices 1 FS bytes used 4.40GiB
>      devid    1 size 8.00GiB used 5.14GiB path /dev/zram1
>
> Label: 'old'  uuid: fc61784a-a27f-4a1d-92e0-63d8a7e3f060
>      Total devices 1 FS bytes used 2.17GiB
>      devid    1 size 32.23GiB used 4.26GiB path /dev/nvme0n1p6
>
> Label: 'cryptoroot'  uuid: 6e1b865c-36cf-48fa-8e1d-d475f4aebc6b
>      Total devices 1 FS bytes used 2.13GiB
>      devid    1 size 665.36GiB used 7.02GiB path /dev/nvme0n1p7
>
>
> [manjaro-gnome /]#   btrfs fi df /mnt/
> Data, single: total=3D4.00GiB, used=3D2.07GiB
> System, single: total=3D4.00MiB, used=3D16.00KiB
> Metadata, single: total=3D264.00MiB, used=3D99.09MiB
> GlobalReserve, single: total=3D45.91MiB, used=3D0.00B
>
> [manjaro-gnome /]# lsblk -o name,partlabel,label,size,fstype,uuid
> NAME        PARTLABEL                    LABEL                SIZE FSTYP=
E  UUID
> loop0                                                        76.4M squas=
hf
> loop1                                                       388.6M squas=
hf
> loop2                                                         1.5G squas=
hf
> loop3                                                       731.7M squas=
hf
> sda                                      MANJARO_GNOME_2107  28.7G
> iso9660 2021-06-14-15-49-54-00
> =E2=94=9C=E2=94=80sda1                                   MANJARO_GNOME_2=
107   2.7G
> iso9660 2021-06-14-15-49-54-00
> =E2=94=94=E2=94=80sda2                                   MISO_EFI       =
        4M
> vfat    3491-2D7B
> zram0                                                           1G
> zram1                                                           8G
> nvme0n1                                                     953.9G
> =E2=94=9C=E2=94=80nvme0n1p8                                             =
     48.8G
> =E2=94=9C=E2=94=80nvme0n1p1 EFI system partition                        =
      202M
> vfat    6CEB-F417
> =E2=94=9C=E2=94=80nvme0n1p2 Microsoft reserved partition                =
       16M
> =E2=94=9C=E2=94=80nvme0n1p3 Basic data partition                        =
    199.9G
> ntfs    8016FB6116FB569E
> =E2=94=9C=E2=94=80nvme0n1p4                                             =
    509.9M
> ntfs    CA343C30343C223D
> =E2=94=9C=E2=94=80nvme0n1p5 isos                                        =
      5.9G
> f2fs    beb0bd83-51f5-4701-ba96-a824ecc512ee
> =E2=94=9C=E2=94=80nvme0n1p6 swap                         old            =
     32.2G
> btrfs   fc61784a-a27f-4a1d-92e0-63d8a7e3f060
> =E2=94=94=E2=94=80nvme0n1p7 cryptroot                    cryptoroot     =
    665.4G
> btrfs   6e1b865c-36cf-48fa-8e1d-d475f4aebc6b
>
>
> I've been running this command against mount options, I can give the
> full details, but here's a summary
>
> fio --name=3Drandom-write-2 --ioengine=3Dposixaio --rw=3Drandwrite --bs=
=3D4k
> --numjobs=3D1 --size=3D2g --iodepth=3D1 --runtime=3D60 --time_based
> --end_fsync=3D1 --directory=3D/mnt/

Btrfs itself is not good at handling small writes, as it will generate
too many metadata updates due to the on-disk data structure.

Another point to note is the end_fsync. Btrfs handles fsync using its
log tree, which still generates quite some metadata updates.


Nodatacow can sometimes reduce the metadata updates, but for this random
writes scenario, it's not that helpful, as we still need to generate new
file extent items and extent items.

>
> for comparison this is a test of the f2fs partition with compression
> turned on, I've seen it hit 300MiBs
>
> F2FS
> Run status group 0 (all jobs):
>    WRITE: bw=3D275MiB/s (288MB/s), 275MiB/s-275MiB/s (288MB/s-288MB/s),
> io=3D16.1GiB (17.3GB), run=3D60101-60101msec
>
> I did a few of these, this was the best
>
>    WRITE: bw=3D300MiB/s (315MB/s), 300MiB/s-300MiB/s (315MB/s-315MB/s),
> io=3D17.6GiB (18.9GB), run=3D60102-60102msec
>
>
> BTRFS with default mount options
>    WRITE: bw=3D44.2MiB/s (46.3MB/s), 44.2MiB/s-44.2MiB/s
> (46.3MB/s-46.3MB/s), io=3D645MiB (676MB), run=3D14604-14604msec
>
> BTRFS with nossd,space_cache=3Dv2
>    WRITE: bw=3D72.1MiB/s (75.6MB/s), 72.1MiB/s-72.1MiB/s
> (75.6MB/s-75.6MB/s), io=3D4369MiB (4581MB), run=3D60623-60623msec
>
> BTRFS with nossd
>    WRITE: bw=3D40.5MiB/s (42.4MB/s), 40.5MiB/s-40.5MiB/s
> (42.4MB/s-42.4MB/s), io=3D2456MiB (2575MB), run=3D60708-60708msec
>
> BTRFS with nodatacow
>    WRITE: bw=3D41.0MiB/s (43.0MB/s), 41.0MiB/s-41.0MiB/s
> (43.0MB/s-43.0MB/s), io=3D2496MiB (2617MB), run=3D60882-60882msec
>
> so here's the really weird thing, the big btrfs partition is getting
> more than twice the speed but still only like 1/2 - 2/3 of the speed
> of f2fs

One reason the smaller fs is slower may be caused by the metadata usage.

As mentioned, btrfs requires metadata COW, and considering how larger
btrfs metadata is compared to other fs, this means btrfs needs quite a
lot more metadata space.

For smaller fs, the metadata usage can expose an obvious pressure to the
extent allocator, causing us to flush more, and slowing down the filesyste=
m.

For larger fs, btrfs can do more over-commit using the unallocated
space, while less slow down due to metadata space pressure.

Thanks,
Qu

>
>    WRITE: bw=3D168MiB/s (176MB/s), 168MiB/s-168MiB/s (176MB/s-176MB/s),
> io=3D10.1GiB (10.9GB), run=3D61680-61680msec
>
> I can give more runs after I install on the unformatted 50G space,
> here's a test against that space
>
> RAW
>   fio --name=3Drandom-write-2 --ioengine=3Dlibaio --rw=3Drandwrite --bs=
=3D4k
> --numjobs=3D1 --size=3D2g --iodepth=3D1 --runtime=3D60 --time_based
> --end_fsync=3D1 --direct=3D1 --filename=3D/dev/nvme0n1p8
>    WRITE: bw=3D257MiB/s (269MB/s), 257MiB/s-257MiB/s (269MB/s-269MB/s),
> io=3D15.0GiB (16.2GB), run=3D60001-60001msec
>
>
