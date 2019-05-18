Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE23D22313
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2019 12:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfERKJq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 18 May 2019 06:09:46 -0400
Received: from voltaic.bi-co.net ([134.119.3.22]:43349 "EHLO voltaic.bi-co.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfERKJq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 May 2019 06:09:46 -0400
Received: from lass-mb.fritz.box (aftr-95-222-30-100.unity-media.net [95.222.30.100])
        by voltaic.bi-co.net (Postfix) with ESMTPSA id 7C12920DD3;
        Sat, 18 May 2019 12:09:44 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Massive filesystem corruption after balance + fstrim on Linux
 5.1.2
From:   =?utf-8?Q?Michael_La=C3=9F?= <bevan@bi-co.net>
In-Reply-To: <20190518143154.29307a88@natsu>
Date:   Sat, 18 May 2019 12:09:43 +0200
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <D7E038F3-A487-4D73-A6B8-E1EF06F05D8B@bi-co.net>
References: <297da4cbe20235080205719805b08810@bi-co.net>
 <CAJCQCtR-uo9fgs66pBMEoYX_xAye=O-L8kiMwyAdFjPS5T4+CA@mail.gmail.com>
 <8C31D41C-9608-4A65-B543-8ABCC0B907A0@bi-co.net>
 <CAJCQCtTZWXUgUDh8vn0BFeEbAdKToDSVYYw4Q0bt0rECQr9nxQ@mail.gmail.com>
 <AD966642-1043-468D-BABF-8FC9AF514D36@bi-co.net>
 <20190518143154.29307a88@natsu>
To:     Roman Mamedov <rm@romanrm.net>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> Am 18.05.2019 um 11:31 schrieb Roman Mamedov <rm@romanrm.net>:
> 
> On Sat, 18 May 2019 11:18:31 +0200
> Michael Laß <bevan@bi-co.net> wrote:
>> 
>> pvdisplay -m:
>> 
>>  --- Physical volume ---
>>  PV Name               /dev/sda1
>>  VG Name               vg_system
>>  PV Size               119.24 GiB / not usable <22.34 MiB
>>  Allocatable           yes (but full)
>>  PE Size               32.00 MiB
>>  Total PE              3815
>>  Free PE               0
>>  Allocated PE          3815
>>  PV UUID               mqCLFy-iDnt-NfdC-lfSv-Maor-V1Ih-RlG8lP
> 
> Such peculiar physical layout suggests you resize your LVs up and down a lot,
> is there any chance you could have recently shrinked the LV without first
> resizing down all the layers above it (Btrfs and LUKS) in proper order?

This is mostly a result from my transition from several ext4 volumes to one btrfs volume, where I extended the new btrfs volume several times. I quickly checked my shell history and it was something like this:

cryptsetup luksFormat /dev/mapper/vg_system-btrfs
cryptsetup luksOpen --allow-discards /dev/mapper/vg_system-btrfs cryptsystem
mkfs.btrfs -L system /dev/mapper/cryptsystem
lvextend -l100%free /dev/vg_system/btrfs
cryptsetup resize cryptsystem
btrfs fi resize max /

The previous ext4 volumes had been resized a couple of times as well before. However, the last resize operation was in 2015 and never caused any issues since then.

The btrfs file system which I now use to reproduce the issue is freshly created. So if there is any fallout from these resize operations, it would have to be in dm-crypt or LVM. Just to double-check, I compared the output of “cryptsetup status” and “lvdisplay”:

lvdisplay shows me that vg_system/btrfs uses 3511 LE. Each of those is 32MiB which makes
3511 * 32 * 1024 * 1024 / 512 = 230096896 sectors

cryptsetup shows me that the volume has a size of 230092800 sectors and an offset of 4096 which makes
230092800 + 4096 = 230096896 sectors

So this seems to match perfectly.

>>  --- Physical Segments ---
>>  Physical extent 0 to 1248:
>>    Logical volume	/dev/vg_system/btrfs
>>    Logical extents	2231 to 3479
>>  Physical extent 1249 to 1728:
>>    Logical volume	/dev/vg_system/btrfs
>>    Logical extents	640 to 1119
>>  Physical extent 1729 to 1760:
>>    Logical volume	/dev/vg_system/grml-images
>>    Logical extents	0 to 31
>>  Physical extent 1761 to 2016:
>>    Logical volume	/dev/vg_system/swap
>>    Logical extents	0 to 255
>>  Physical extent 2017 to 2047:
>>    Logical volume	/dev/vg_system/btrfs
>>    Logical extents	3480 to 3510
>>  Physical extent 2048 to 2687:
>>    Logical volume	/dev/vg_system/btrfs
>>    Logical extents	0 to 639
>>  Physical extent 2688 to 3007:
>>    Logical volume	/dev/vg_system/btrfs
>>    Logical extents	1911 to 2230
>>  Physical extent 3008 to 3320:
>>    Logical volume	/dev/vg_system/btrfs
>>    Logical extents	1120 to 1432
>>  Physical extent 3321 to 3336:
>>    Logical volume	/dev/vg_system/boot
>>    Logical extents	0 to 15
>>  Physical extent 3337 to 3814:
>>    Logical volume	/dev/vg_system/btrfs
>>    Logical extents	1433 to 1910


