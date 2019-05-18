Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2300222B0
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2019 11:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfERJb4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 18 May 2019 05:31:56 -0400
Received: from len.romanrm.net ([91.121.75.85]:41408 "EHLO len.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfERJb4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 May 2019 05:31:56 -0400
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by len.romanrm.net (Postfix) with SMTP id 66CA820394;
        Sat, 18 May 2019 09:31:54 +0000 (UTC)
Date:   Sat, 18 May 2019 14:31:54 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Michael =?UTF-8?B?TGHDnw==?= <bevan@bi-co.net>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Massive filesystem corruption after balance + fstrim on Linux
 5.1.2
Message-ID: <20190518143154.29307a88@natsu>
In-Reply-To: <AD966642-1043-468D-BABF-8FC9AF514D36@bi-co.net>
References: <297da4cbe20235080205719805b08810@bi-co.net>
        <CAJCQCtR-uo9fgs66pBMEoYX_xAye=O-L8kiMwyAdFjPS5T4+CA@mail.gmail.com>
        <8C31D41C-9608-4A65-B543-8ABCC0B907A0@bi-co.net>
        <CAJCQCtTZWXUgUDh8vn0BFeEbAdKToDSVYYw4Q0bt0rECQr9nxQ@mail.gmail.com>
        <AD966642-1043-468D-BABF-8FC9AF514D36@bi-co.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 18 May 2019 11:18:31 +0200
Michael Laß <bevan@bi-co.net> wrote:

> 
> > Am 18.05.2019 um 06:09 schrieb Chris Murphy <lists@colorremedies.com>:
> > 
> > On Fri, May 17, 2019 at 11:37 AM Michael Laß <bevan@bi-co.net> wrote:
> >> 
> >> 
> >> I tried to reproduce this issue: I recreated the btrfs file system, set up a minimal system and issued fstrim again. It printed the following error message:
> >> 
> >> fstrim: /: FITRIM ioctl failed: Input/output error
> > 
> > Huh. Any kernel message at the same time? I would expect any fstrim
> > user space error message to also have a kernel message. Any i/o error
> > suggests some kind of storage stack failure - which could be hardware
> > or software, you can't know without seeing the kernel messages.
> 
> I missed that. The kernel messages are:
> 
> attempt to access beyond end of device
> sda1: rw=16387, want=252755893, limit=250067632
> BTRFS warning (device dm-5): failed to trim 1 device(s), last error -5
> 
> Here are some more information on the partitions and LVM physical segments:
> 
> fdisk -l /dev/sda:
> 
> Device     Boot Start       End   Sectors   Size Id Type
> /dev/sda1  *     2048 250069679 250067632 119.2G 8e Linux LVM
> 
> pvdisplay -m:
> 
>   --- Physical volume ---
>   PV Name               /dev/sda1
>   VG Name               vg_system
>   PV Size               119.24 GiB / not usable <22.34 MiB
>   Allocatable           yes (but full)
>   PE Size               32.00 MiB
>   Total PE              3815
>   Free PE               0
>   Allocated PE          3815
>   PV UUID               mqCLFy-iDnt-NfdC-lfSv-Maor-V1Ih-RlG8lP

Such peculiar physical layout suggests you resize your LVs up and down a lot,
is there any chance you could have recently shrinked the LV without first
resizing down all the layers above it (Btrfs and LUKS) in proper order?

>   --- Physical Segments ---
>   Physical extent 0 to 1248:
>     Logical volume	/dev/vg_system/btrfs
>     Logical extents	2231 to 3479
>   Physical extent 1249 to 1728:
>     Logical volume	/dev/vg_system/btrfs
>     Logical extents	640 to 1119
>   Physical extent 1729 to 1760:
>     Logical volume	/dev/vg_system/grml-images
>     Logical extents	0 to 31
>   Physical extent 1761 to 2016:
>     Logical volume	/dev/vg_system/swap
>     Logical extents	0 to 255
>   Physical extent 2017 to 2047:
>     Logical volume	/dev/vg_system/btrfs
>     Logical extents	3480 to 3510
>   Physical extent 2048 to 2687:
>     Logical volume	/dev/vg_system/btrfs
>     Logical extents	0 to 639
>   Physical extent 2688 to 3007:
>     Logical volume	/dev/vg_system/btrfs
>     Logical extents	1911 to 2230
>   Physical extent 3008 to 3320:
>     Logical volume	/dev/vg_system/btrfs
>     Logical extents	1120 to 1432
>   Physical extent 3321 to 3336:
>     Logical volume	/dev/vg_system/boot
>     Logical extents	0 to 15
>   Physical extent 3337 to 3814:
>     Logical volume	/dev/vg_system/btrfs
>     Logical extents	1433 to 1910
>    
> 
> Would btrfs even be able to accidentally trim parts of other LVs or does this clearly hint towards a LVM/dm issue? Is there an easy way to somehow trace the trim through the different layers so one can see where it goes wrong?
> 
> Cheers,
> Michael
> 
> PS: Current state of bisection: It looks like the error was introduced somewhere between b5dd0c658c31b469ccff1b637e5124851e7a4a1c and v5.1.


-- 
With respect,
Roman
