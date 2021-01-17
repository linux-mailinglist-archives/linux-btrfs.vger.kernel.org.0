Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9065F2F9015
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Jan 2021 02:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbhAQBji convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 16 Jan 2021 20:39:38 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35196 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbhAQBjh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jan 2021 20:39:37 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 35D4A94220D; Sat, 16 Jan 2021 20:38:56 -0500 (EST)
Date:   Sat, 16 Jan 2021 20:38:56 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Tim Cuthbertson <ratcheer@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: raid0 confusion question
Message-ID: <20210117013856.GJ31381@hungrycats.org>
References: <CAAKzf7kPv_CmzrMDD8SupbfFGyABvcDqWXg4yZBzBx-QBY6yMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAAKzf7kPv_CmzrMDD8SupbfFGyABvcDqWXg4yZBzBx-QBY6yMw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 16, 2021 at 03:08:00PM -0600, Tim Cuthbertson wrote:
> I thought raid0 "striped" the data across two or more devices to
> increase total capacity, for example when adding a new device to an
> existing filesystem. But that is not apparently what I ended up with.
> 
> Before:
> btrfs device usage /mnt/backup/
> /dev/sdc1, ID: 1
>    Device size:           300.00GiB
>    Device slack:              0.00B
>    Data,single:           226.01GiB
>    Metadata,DUP:            8.00GiB
>    System,DUP:             64.00MiB
>    Unallocated:            65.93GiB
> 
> /dev/sdc2, ID: 2
>    Device size:           300.00GiB
>    Device slack:              0.00B
>    Data,single:             1.00GiB
>    Unallocated:           299.00GiB
> 
> Then, I ran command:
> btrfs balance start -dconvert=raid0 -mconvert=raid1 /mnt/backup
> 
> And what I ended up with seems to be double the amount of data used,
> like what I think would happen with raid1, not raid0:
> 
> btrfs device usage /mnt/backup/
> /dev/sdc1, ID: 1
>    Device size:           300.00GiB
>    Device slack:              0.00B
>    Data,RAID0:            228.00GiB
>    Metadata,RAID1:          5.00GiB
>    System,RAID1:           64.00MiB
>    Unallocated:            66.94GiB
> 
> /dev/sdc2, ID: 2
>    Device size:           300.00GiB
>    Device slack:              0.00B
>    Data,RAID0:            228.00GiB
>    Metadata,RAID1:          5.00GiB
>    System,RAID1:           64.00MiB
>    Unallocated:            66.94GiB
> 
> Or, am I misinterpreting what I am seeing? Thank you.

btrfs divides disks into 1 GiB slices (on disks of this size), and the
joins the slices together to make chunks with a RAID profile.  Data
and metadata is then stored inside the chunks.

btrfs dev usage will show you the size of the chunks, not the amount of
(meta)data inside the chunks.

> # uname -a
> Linux tux 5.10.7-arch1-1 #1 SMP PREEMPT Wed, 13 Jan 2021 12:02:01
> +0000 x86_64 GNU/Linux
> # btrfs --version
> btrfs-progs v5.9
> # btrfs fi show
> Label: none  uuid: c0f4c8e2-b580-4c0d-9562-abdb933b9625
>         Total devices 1 FS bytes used 13.11GiB
>         devid    1 size 449.51GiB used 14.01GiB path /dev/sda3
> 
> Label: none  uuid: 4fe39403-7ba1-4f22-972f-5041e3b6ff6f
>         Total devices 1 FS bytes used 37.36GiB
>         devid    1 size 600.00GiB used 40.02GiB path /dev/sdb1
> 
> Label: none  uuid: 1751eeca-c1a2-47bb-906b-c7199b09eb6d
>         Total devices 2 FS bytes used 229.57GiB
>         devid    1 size 300.00GiB used 233.06GiB path /dev/sdc1
>         devid    2 size 300.00GiB used 233.06GiB path /dev/sdc2

btrfs fi show also reports chunk sizes (228 + 5 + 0.06 = 233.06).

The difference between the btrfs device size and the amount of data
allocated is called "unallocated" in 'btrfs dev usage' and 'btrfs
fi usage'.

The difference between btrfs device size and the physical device size
is called "slack" in 'btrfs dev usage' output (it does not appear in
'fi usage' output).

> # btrfs fi df /mnt/backup
> Data, RAID0: total=456.00GiB, used=226.65GiB
> System, RAID1: total=64.00MiB, used=64.00KiB
> Metadata, RAID1: total=5.00GiB, used=2.92GiB
> GlobalReserve, single: total=401.84MiB, used=0.00B

In 'btrfs fi df' output, 'total' is the size of chunks allocated, 'used'
is the amount of space used within the chunks (GlobalReserve is deducted
from metadata in RAM, it doesn't physically exist on any disk).

If you had shown 'btrfs fi usage' here, it might be clearer.
'fi usage' combines 'dev usage' with 'fi df', and it indicates
how much data is stored in each profile separately from how much
chunk space is allocated on each disk.

Plain 'df' should be showing the same amount of available space,
maybe a few GB different due to the metadata balance.

It is still storing 226 GiB of data, but it has allocated a larger number
of chunks (i.e. one chunk out for each chunk in, but the input chunks
are 1GB and the output chunks are 2x1GB, so each chunk is half full).
1GB of data at the beginning of the new chunk and then 1GB of empty space,
give or take a few blocks.

It's probably harmless, but if you want to waste a lot of iops for
nothing, you can balance the data again and it should pack the data
into chunks more tightly.  I wouldn't bother--the space is allocated
for data, so if you add more data to the filesystem it will just
fill in those chunks.  If you do a data balance, it will repack the
data into the data chunks so that allocated space is closer to used
space, but then later as you add more data to the filesystem new data
chunks will have to be created again.  There's no fragmentation concern
since the free space areas are likely all contiguous 1 GiB or larger.

Same thing has happened with metadata, 5GiB allocated for ~3GiB used.
Definitely do NOT balance the metadata (only balance metadata to change
RAID profiles) because you'll need that extra 2GiB to be preallocated
for metadata as the disk fills up.
