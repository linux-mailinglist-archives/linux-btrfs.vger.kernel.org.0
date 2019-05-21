Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6CC255F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2019 18:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfEUQqZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 21 May 2019 12:46:25 -0400
Received: from voltaic.bi-co.net ([134.119.3.22]:57261 "EHLO voltaic.bi-co.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbfEUQqZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 12:46:25 -0400
Received: from lass-mb.fritz.box (aftr-95-222-30-100.unity-media.net [95.222.30.100])
        by voltaic.bi-co.net (Postfix) with ESMTPSA id 9992F20BA8;
        Tue, 21 May 2019 18:46:21 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [dm-devel] fstrim discarding too many or wrong blocks on Linux
 5.1, leading to data loss
From:   =?utf-8?Q?Michael_La=C3=9F?= <bevan@bi-co.net>
In-Reply-To: <3142764D-5944-4004-BC57-C89C89AC9ED9@bi-co.net>
Date:   Tue, 21 May 2019 18:46:20 +0200
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <F170BB63-D9D7-4D08-9097-3C18815BE869@bi-co.net>
References: <297da4cbe20235080205719805b08810@bi-co.net>
 <CAJCQCtR-uo9fgs66pBMEoYX_xAye=O-L8kiMwyAdFjPS5T4+CA@mail.gmail.com>
 <8C31D41C-9608-4A65-B543-8ABCC0B907A0@bi-co.net>
 <CAJCQCtTZWXUgUDh8vn0BFeEbAdKToDSVYYw4Q0bt0rECQr9nxQ@mail.gmail.com>
 <AD966642-1043-468D-BABF-8FC9AF514D36@bi-co.net>
 <158a3491-e4d2-d905-7f58-11a15bddcd70@gmx.com>
 <C1CD4646-E75D-4AAF-9CD6-B3AC32495FD3@bi-co.net>
 <3142764D-5944-4004-BC57-C89C89AC9ED9@bi-co.net>
To:     dm-devel@redhat.com
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> Am 20.05.2019 um 13:38 schrieb Michael Laß <bevan@bi-co.net>:
> 
>> 
>> Am 19.05.2019 um 21:55 schrieb Michael Laß <bevan@bi-co.net>:
>> 
>> CC'ing dm-devel, as this seems to be a dm-related issue. Short summary for new readers:
>> 
>> On Linux 5.1 (tested up to 5.1.3), fstrim may discard too many blocks, leading to data loss. I have the following storage stack:
>> 
>> btrfs
>> dm-crypt (LUKS)
>> LVM logical volume
>> LVM single physical volume
>> MBR partition
>> Samsung 830 SSD
>> 
>> The mapping between logical volumes and physical segments is a bit mixed up. See below for the output for “pvdisplay -m”. When I issue fstrim on the mounted btrfs volume, I get the following kernel messages:
>> 
>> attempt to access beyond end of device
>> sda1: rw=16387, want=252755893, limit=250067632
>> BTRFS warning (device dm-5): failed to trim 1 device(s), last error -5
>> 
>> At the same time, other logical volumes on the same physical volume are destroyed. Also the btrfs volume itself may be damaged (this seems to depend on the actual usage).
>> 
>> I can easily reproduce this issue locally and I’m currently bisecting. So far I could narrow down the range of commits to:
>> Good: 92fff53b7191cae566be9ca6752069426c7f8241
>> Bad: 225557446856448039a9e495da37b72c20071ef2
> 
> I finished bisecting. Here’s the responsible commit:
> 
> commit 61697a6abd24acba941359c6268a94f4afe4a53d
> Author: Mike Snitzer <snitzer@redhat.com>
> Date:   Fri Jan 18 14:19:26 2019 -0500
> 
>    dm: eliminate 'split_discard_bios' flag from DM target interface
> 
>    There is no need to have DM core split discards on behalf of a DM target
>    now that blk_queue_split() handles splitting discards based on the
>    queue_limits.  A DM target just needs to set max_discard_sectors,
>    discard_granularity, etc, in queue_limits.
> 
>    Signed-off-by: Mike Snitzer <snitzer@redhat.com>

Reverting that commit solves the issue for me on Linux 5.1.3. Would that be an option until the root cause has been identified? I’d rather not let more people run into this issue.

Cheers,
Michael


> Maybe the assumptions taken here ("A DM target just needs to set max_discard_sectors, discard_granularity, etc, in queue_limits.”) isn’t valid in my case? Does anyone have an idea?
> 
> 
>> 
>> In this range of commits, there are only dm-related changes.
>> 
>> So far, I have not reproduced the issue with other file systems or a simplified stack. I first want to continue bisecting but this may take another day.
>> 
>> 
>>> Am 18.05.2019 um 12:26 schrieb Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>> On 2019/5/18 下午5:18, Michael Laß wrote:
>>>> 
>>>>> Am 18.05.2019 um 06:09 schrieb Chris Murphy <lists@colorremedies.com>:
>>>>> 
>>>>> On Fri, May 17, 2019 at 11:37 AM Michael Laß <bevan@bi-co.net> wrote:
>>>>>> 
>>>>>> 
>>>>>> I tried to reproduce this issue: I recreated the btrfs file system, set up a minimal system and issued fstrim again. It printed the following error message:
>>>>>> 
>>>>>> fstrim: /: FITRIM ioctl failed: Input/output error
>>>>> 
>>>>> Huh. Any kernel message at the same time? I would expect any fstrim
>>>>> user space error message to also have a kernel message. Any i/o error
>>>>> suggests some kind of storage stack failure - which could be hardware
>>>>> or software, you can't know without seeing the kernel messages.
>>>> 
>>>> I missed that. The kernel messages are:
>>>> 
>>>> attempt to access beyond end of device
>>>> sda1: rw=16387, want=252755893, limit=250067632
>>>> BTRFS warning (device dm-5): failed to trim 1 device(s), last error -5
>>>> 
>>>> Here are some more information on the partitions and LVM physical segments:
>>>> 
>>>> fdisk -l /dev/sda:
>>>> 
>>>> Device     Boot Start       End   Sectors   Size Id Type
>>>> /dev/sda1  *     2048 250069679 250067632 119.2G 8e Linux LVM
>>>> 
>>>> pvdisplay -m:
>>>> 
>>>> --- Physical volume ---
>>>> PV Name               /dev/sda1
>>>> VG Name               vg_system
>>>> PV Size               119.24 GiB / not usable <22.34 MiB
>>>> Allocatable           yes (but full)
>>>> PE Size               32.00 MiB
>>>> Total PE              3815
>>>> Free PE               0
>>>> Allocated PE          3815
>>>> PV UUID               mqCLFy-iDnt-NfdC-lfSv-Maor-V1Ih-RlG8lP
>>>> 
>>>> --- Physical Segments ---
>>>> Physical extent 0 to 1248:
>>>>  Logical volume	/dev/vg_system/btrfs
>>>>  Logical extents	2231 to 3479
>>>> Physical extent 1249 to 1728:
>>>>  Logical volume	/dev/vg_system/btrfs
>>>>  Logical extents	640 to 1119
>>>> Physical extent 1729 to 1760:
>>>>  Logical volume	/dev/vg_system/grml-images
>>>>  Logical extents	0 to 31
>>>> Physical extent 1761 to 2016:
>>>>  Logical volume	/dev/vg_system/swap
>>>>  Logical extents	0 to 255
>>>> Physical extent 2017 to 2047:
>>>>  Logical volume	/dev/vg_system/btrfs
>>>>  Logical extents	3480 to 3510
>>>> Physical extent 2048 to 2687:
>>>>  Logical volume	/dev/vg_system/btrfs
>>>>  Logical extents	0 to 639
>>>> Physical extent 2688 to 3007:
>>>>  Logical volume	/dev/vg_system/btrfs
>>>>  Logical extents	1911 to 2230
>>>> Physical extent 3008 to 3320:
>>>>  Logical volume	/dev/vg_system/btrfs
>>>>  Logical extents	1120 to 1432
>>>> Physical extent 3321 to 3336:
>>>>  Logical volume	/dev/vg_system/boot
>>>>  Logical extents	0 to 15
>>>> Physical extent 3337 to 3814:
>>>>  Logical volume	/dev/vg_system/btrfs
>>>>  Logical extents	1433 to 1910
>>>> 
>>>> 
>>>> Would btrfs even be able to accidentally trim parts of other LVs or does this clearly hint towards a LVM/dm issue?
>>> 
>>> I can't speak sure, but (at least for latest kernel) btrfs has a lot of
>>> extra mount time self check, including chunk stripe check against
>>> underlying device, thus the possibility shouldn't be that high for btrfs.
>> 
>> Indeed, bisecting the issue led me to a range of commits that only contains dm-related and no btrfs-related changes. So I assume this is a bug in dm.
>> 
>>>> Is there an easy way to somehow trace the trim through the different layers so one can see where it goes wrong?
>>> 
>>> Sure, you could use dm-log-writes.
>>> It will record all read/write (including trim) for later replay.
>>> 
>>> So in your case, you can build the storage stack like:
>>> 
>>> Btrfs
>>> <dm-log-writes>
>>> LUKS/dmcrypt
>>> LVM
>>> MBR partition
>>> Samsung SSD
>>> 
>>> Then replay the log (using src/log-write/replay-log in fstests) with
>>> verbose output, you can verify every trim operation against the dmcrypt
>>> device size.
>>> 
>>> If all trim are fine, then move the dm-log-writes a layer lower, until
>>> you find which layer is causing the problem.
>> 
>> That sounds like a plan! However, I first want to continue bisecting as I am afraid to lose my reproducer by changing parts of my storage stack.
>> 
>> Cheers,
>> Michael
>> 
>>> 
>>> Thanks,
>>> Qu
>>>> 
>>>> Cheers,
>>>> Michael
>>>> 
>>>> PS: Current state of bisection: It looks like the error was introduced somewhere between b5dd0c658c31b469ccff1b637e5124851e7a4a1c and v5.1.
>> 
>> 
>> --
>> dm-devel mailing list
>> dm-devel@redhat.com
>> https://www.redhat.com/mailman/listinfo/dm-devel
> 
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://www.redhat.com/mailman/listinfo/dm-devel

