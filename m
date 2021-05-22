Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E0938D2E8
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 May 2021 04:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhEVCK0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 21 May 2021 22:10:26 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:34512 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhEVCKX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 22:10:23 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 1FD1AA6F855; Fri, 21 May 2021 22:08:59 -0400 (EDT)
Date:   Fri, 21 May 2021 22:08:59 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Leszek Dubiel <leszek@dubiel.pl>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Btrfs not using all devices in raid1
Message-ID: <20210522020858.GB11733@hungrycats.org>
References: <63123a58-18a4-24ff-3b30-9a0668c167c4@dubiel.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <63123a58-18a4-24ff-3b30-9a0668c167c4@dubiel.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 21, 2021 at 06:34:27PM +0200, Leszek Dubiel wrote:
> 
> Hello!
> 
> Why Btrfs is not using /dev/sdc2?
> There is no line "Data,RAID1" for this disk.
> Isn't it supposed to use disk that has most of free space?
> 
> Thanks for help :) :)
> Using Btrfs in production.
> 
> 
> Here are some command outputs:
> 
> 
> 
> ### btrfs fi show /
> 
> Label: none  uuid: ea6ae51d-d9b0-4628-a8f3-3406e1dc59c6
>     Total devices 4 FS bytes used 2.96TiB
>     devid    1 size 7.25TiB used 3.20TiB path /dev/sda2
>     devid    2 size 7.25TiB used 3.20TiB path /dev/sdb2
>     devid    3 size 7.25TiB used 3.21TiB path /dev/sdd2
>     devid    4 size 7.25TiB used 32.00MiB path /dev/sdc2
> 
> 
> 
> ### btrfs fi df /
> 
> Data, RAID1: total=4.49TiB, used=2.90TiB

There are about 1.5TB of available space in existing block groups, so
those will be filled in first.  Block group allocations will start on
sdc2 after the existing block groups are filled.

> System, RAID1: total=64.00MiB, used=784.00KiB
> Metadata, RAID1: total=321.00GiB, used=56.08GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> 
> 
> ### btrfs dev usa /
> 
> /dev/sda2, ID: 1
>    Device size:             7.25TiB
>    Device slack:              0.00B
>    Data,RAID1:              2.99TiB
>    Metadata,RAID1:        210.00GiB
>    System,RAID1:           64.00MiB
>    Unallocated:             4.05TiB
> 
> /dev/sdb2, ID: 2
>    Device size:             7.25TiB
>    Device slack:              0.00B
>    Data,RAID1:              3.00TiB
>    Metadata,RAID1:        210.00GiB
>    Unallocated:             4.04TiB
> 
> /dev/sdc2, ID: 4
>    Device size:             7.25TiB
>    Device slack:              0.00B   ... no Data/RAID1
>    System,RAID1:           32.00MiB
>    Unallocated:             7.25TiB
> 
> /dev/sdd2, ID: 3
>    Device size:             7.25TiB
>    Device slack:              0.00B
>    Data,RAID1:              2.99TiB
>    Metadata,RAID1:        222.00GiB
>    System,RAID1:           32.00MiB
>    Unallocated:             4.04TiB

The disks in decreasing size order have 7.25TB, 4.05 TB, 4.04 TB, and 4.04
TB.  RAID1 requires the sum of all disks after the largest be equal or
greater in size to the largest, and 12.13 >= 7.25, so you're good to go.

> ### time btrfs balance start -dconvert=raid1,soft -mconvert=raid1,soft /
> 
> Done, had to relocate 0 out of 4922 chunks
> 
> real    0m0,522s
> user    0m0,000s
> sys    0m0,033s

You might want something more like;

	time btrfs balance start -dlimit=1000,devid=1 /
	time btrfs balance start -dlimit=1000,devid=2 /
	time btrfs balance start -dlimit=1000,devid=3 /

but that will take a long time and isn't strictly necessary.

Alternatively, use 'btrfs-balance-least-used' from the 'python-btrfs'
package, with a usage limit of about 90%.  That will repack all of the
data into existing block groups first, so future allocations will use
sdc2.

Unfortunately balance is the only way to redistribute the existing data
onto new drives, so if you don't want to run balance, then you'll just
have to wait until sdc2 fills in naturally.
