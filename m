Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271CA322F7E
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Feb 2021 18:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhBWRUq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Feb 2021 12:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbhBWRUp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Feb 2021 12:20:45 -0500
Received: from smtp.steev.me.uk (smtp.steev.me.uk [IPv6:2001:8b0:162c:10::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056C5C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Feb 2021 09:20:05 -0800 (PST)
Received: from smtp.steev.me.uk ([2001:8b0:162c:10::25] helo=webmail.steev.me.uk)
        by smtp.steev.me.uk with esmtp (Exim 4.93.0.4)
        id 1lEbLs-003LFH-7R; Tue, 23 Feb 2021 17:20:00 +0000
MIME-Version: 1.0
Date:   Tue, 23 Feb 2021 17:19:59 +0000
From:   Steven Davies <btrfs-list@steev.me.uk>
To:     dsterba@suse.cz, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Steven Davies <btrfs-list@steev.me.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: 5.11.0: open ctree failed: devide total_bytes should be at most X
 but found Y
In-Reply-To: <20210223143020.GW1993@twin.jikos.cz>
References: <34d881ab-7484-6074-7c0b-b5c8d9e46379@steev.me.uk>
 <PH0PR04MB7416AA577A3ED39E4C5833819B809@PH0PR04MB7416.namprd04.prod.outlook.com>
 <PH0PR04MB74167CACC7802BA85638105F9B809@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210223143020.GW1993@twin.jikos.cz>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <457bf37240392e63a84c7e1546f7d47a@steev.me.uk>
X-Sender: btrfs-list@steev.me.uk
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021-02-23 14:30, David Sterba wrote:
> On Tue, Feb 23, 2021 at 09:43:04AM +0000, Johannes Thumshirn wrote:
>> On 23/02/2021 10:13, Johannes Thumshirn wrote:
>> > On 22/02/2021 21:07, Steven Davies wrote:
>> >
>> > [+CC Anand ]
>> >
>> >> Booted my system with kernel 5.11.0 vanilla with the first time and received this:
>> >>
>> >> BTRFS info (device nvme0n1p2): has skinny extents
>> >> BTRFS error (device nvme0n1p2): device total_bytes should be at most 964757028864 but found
>> >> 964770336768
>> >> BTRFS error (device nvme0n1p2): failed to read chunk tree: -22
>> >>
>> >> Booting with 5.10.12 has no issues.
>> >>
>> >> # btrfs filesystem usage /
>> >> Overall:
>> >>      Device size:                 898.51GiB
>> >>      Device allocated:            620.06GiB
>> >>      Device unallocated:          278.45GiB
>> >>      Device missing:                  0.00B
>> >>      Used:                        616.58GiB
>> >>      Free (estimated):            279.94GiB      (min: 140.72GiB)
>> >>      Data ratio:                       1.00
>> >>      Metadata ratio:                   2.00
>> >>      Global reserve:              512.00MiB      (used: 0.00B)
>> >>
>> >> Data,single: Size:568.00GiB, Used:566.51GiB (99.74%)
>> >>     /dev/nvme0n1p2        568.00GiB
>> >>
>> >> Metadata,DUP: Size:26.00GiB, Used:25.03GiB (96.29%)
>> >>     /dev/nvme0n1p2         52.00GiB
>> >>
>> >> System,DUP: Size:32.00MiB, Used:80.00KiB (0.24%)
>> >>     /dev/nvme0n1p2         64.00MiB
>> >>
>> >> Unallocated:
>> >>     /dev/nvme0n1p2        278.45GiB
>> >>
>> >> # parted -l
>> >> Model: Sabrent Rocket Q (nvme)
>> >> Disk /dev/nvme0n1: 1000GB
>> >> Sector size (logical/physical): 512B/512B
>> >> Partition Table: gpt
>> >> Disk Flags:
>> >>
>> >> Number  Start   End     Size    File system     Name  Flags
>> >>   1      1049kB  1075MB  1074MB  fat32                 boot, esp
>> >>   2      1075MB  966GB   965GB   btrfs
>> >>   3      966GB   1000GB  34.4GB  linux-swap(v1)        swap
>> >>
>> >> What has changed in 5.11 which might cause this?
>> >>
>> >>
>> >
>> > This line:
>> >> BTRFS info (device nvme0n1p2): has skinny extents
>> >> BTRFS error (device nvme0n1p2): device total_bytes should be at most 964757028864 but found
>> >> 964770336768
>> >> BTRFS error (device nvme0n1p2): failed to read chunk tree: -22
>> >
>> > comes from 3a160a933111 ("btrfs: drop never met disk total bytes check in verify_one_dev_extent")
>> > which went into v5.11-rc1.
>> >
>> > IIUIC the device item's total_bytes and the block device inode's size are off by 12M, so the check
>> > introduced in the above commit refuses to mount the FS.
>> >
>> > Anand any idea?
>> 
>> OK this is getting interesting:
>> btrfs-porgs sets the device's total_bytes at mkfs time and obtains it 
>> from ioctl(..., BLKGETSIZE64, ...);
>> 
>> BLKGETSIZE64 does:
>> return put_u64(argp, i_size_read(bdev->bd_inode));
>> 
>> The new check in read_one_dev() does:
>> 
>>                u64 max_total_bytes = 
>> i_size_read(device->bdev->bd_inode);
>> 
>>                if (device->total_bytes > max_total_bytes) {
>>                        btrfs_err(fs_info,
>>                        "device total_bytes should be at most %llu but 
>> found %llu",
>>                                  max_total_bytes, 
>> device->total_bytes);
>>                        return -EINVAL;
>> 
>> 
>> So the bdev inode's i_size must have changed between mkfs and mount.

That's likely, this is my development/testing machine and I've changed 
partitions (and btrfs RAID levels) around more than once since mkfs 
time. I can't remember if or how I've modified the fs to take account of 
this.

>> Steven, can you please run:
>> blockdev --getsize64 /dev/nvme0n1p2

# blockdev --getsize64 /dev/nvme0n1p2
964757028864

> 
> The kernel side verifies that the physical device size is not smaller
> than the size recorded in the device item, so that makes sense. I was a
> bit doubtful about the check but it can detect real problems or point
> out some weirdness.

Agreed. It's useful, but somewhat painful when it refuses to mount a 
root device after reboot.

> The 12M delta is not big, but I'd expect that for a physical device it
> should not change. Another possibility would be some kind of rounding 
> to
> a reasonable number, like 16M.

Is there a simple way to fix this partition so that btrfs and the 
partition table agree on its size?

-- 
Steven Davies
