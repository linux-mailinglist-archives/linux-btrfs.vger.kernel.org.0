Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5E0C22294
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2019 11:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbfERJSe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 18 May 2019 05:18:34 -0400
Received: from voltaic.bi-co.net ([134.119.3.22]:43185 "EHLO voltaic.bi-co.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfERJSd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 May 2019 05:18:33 -0400
Received: from lass-mb.fritz.box (aftr-95-222-30-100.unity-media.net [95.222.30.100])
        by voltaic.bi-co.net (Postfix) with ESMTPSA id 04681209BD;
        Sat, 18 May 2019 11:18:31 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Massive filesystem corruption after balance + fstrim on Linux
 5.1.2
From:   =?utf-8?Q?Michael_La=C3=9F?= <bevan@bi-co.net>
In-Reply-To: <CAJCQCtTZWXUgUDh8vn0BFeEbAdKToDSVYYw4Q0bt0rECQr9nxQ@mail.gmail.com>
Date:   Sat, 18 May 2019 11:18:31 +0200
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <AD966642-1043-468D-BABF-8FC9AF514D36@bi-co.net>
References: <297da4cbe20235080205719805b08810@bi-co.net>
 <CAJCQCtR-uo9fgs66pBMEoYX_xAye=O-L8kiMwyAdFjPS5T4+CA@mail.gmail.com>
 <8C31D41C-9608-4A65-B543-8ABCC0B907A0@bi-co.net>
 <CAJCQCtTZWXUgUDh8vn0BFeEbAdKToDSVYYw4Q0bt0rECQr9nxQ@mail.gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> Am 18.05.2019 um 06:09 schrieb Chris Murphy <lists@colorremedies.com>:
> 
> On Fri, May 17, 2019 at 11:37 AM Michael Laß <bevan@bi-co.net> wrote:
>> 
>> 
>> I tried to reproduce this issue: I recreated the btrfs file system, set up a minimal system and issued fstrim again. It printed the following error message:
>> 
>> fstrim: /: FITRIM ioctl failed: Input/output error
> 
> Huh. Any kernel message at the same time? I would expect any fstrim
> user space error message to also have a kernel message. Any i/o error
> suggests some kind of storage stack failure - which could be hardware
> or software, you can't know without seeing the kernel messages.

I missed that. The kernel messages are:

attempt to access beyond end of device
sda1: rw=16387, want=252755893, limit=250067632
BTRFS warning (device dm-5): failed to trim 1 device(s), last error -5

Here are some more information on the partitions and LVM physical segments:

fdisk -l /dev/sda:

Device     Boot Start       End   Sectors   Size Id Type
/dev/sda1  *     2048 250069679 250067632 119.2G 8e Linux LVM

pvdisplay -m:

  --- Physical volume ---
  PV Name               /dev/sda1
  VG Name               vg_system
  PV Size               119.24 GiB / not usable <22.34 MiB
  Allocatable           yes (but full)
  PE Size               32.00 MiB
  Total PE              3815
  Free PE               0
  Allocated PE          3815
  PV UUID               mqCLFy-iDnt-NfdC-lfSv-Maor-V1Ih-RlG8lP
   
  --- Physical Segments ---
  Physical extent 0 to 1248:
    Logical volume	/dev/vg_system/btrfs
    Logical extents	2231 to 3479
  Physical extent 1249 to 1728:
    Logical volume	/dev/vg_system/btrfs
    Logical extents	640 to 1119
  Physical extent 1729 to 1760:
    Logical volume	/dev/vg_system/grml-images
    Logical extents	0 to 31
  Physical extent 1761 to 2016:
    Logical volume	/dev/vg_system/swap
    Logical extents	0 to 255
  Physical extent 2017 to 2047:
    Logical volume	/dev/vg_system/btrfs
    Logical extents	3480 to 3510
  Physical extent 2048 to 2687:
    Logical volume	/dev/vg_system/btrfs
    Logical extents	0 to 639
  Physical extent 2688 to 3007:
    Logical volume	/dev/vg_system/btrfs
    Logical extents	1911 to 2230
  Physical extent 3008 to 3320:
    Logical volume	/dev/vg_system/btrfs
    Logical extents	1120 to 1432
  Physical extent 3321 to 3336:
    Logical volume	/dev/vg_system/boot
    Logical extents	0 to 15
  Physical extent 3337 to 3814:
    Logical volume	/dev/vg_system/btrfs
    Logical extents	1433 to 1910
   

Would btrfs even be able to accidentally trim parts of other LVs or does this clearly hint towards a LVM/dm issue? Is there an easy way to somehow trace the trim through the different layers so one can see where it goes wrong?

Cheers,
Michael

PS: Current state of bisection: It looks like the error was introduced somewhere between b5dd0c658c31b469ccff1b637e5124851e7a4a1c and v5.1.
