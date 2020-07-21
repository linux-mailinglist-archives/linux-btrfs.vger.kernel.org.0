Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF59222743C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 02:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgGUA51 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 20 Jul 2020 20:57:27 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36232 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgGUA5Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jul 2020 20:57:25 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 500A5770CD4; Mon, 20 Jul 2020 20:57:24 -0400 (EDT)
Date:   Mon, 20 Jul 2020 20:57:24 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Edmund Urbani <edmund.urbani@liland.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Troubles removing missing device from RAID 6
Message-ID: <20200721005724.GK10769@hungrycats.org>
References: <23712d34-1787-058d-b49a-6b3e78969920@liland.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <23712d34-1787-058d-b49a-6b3e78969920@liland.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 19, 2020 at 04:13:29PM +0200, Edmund Urbani wrote:
> Hello everyone,
> 
> after having RMA'd a faulty HDD from my RAID6 and having received the
> replacement, I added the new disk to the filesystem. At that point the
> missing device was still listed and I went ahead to remove it like so:
> 
> btrfs device delete missing /mnt/shared/
> 
> After a few hours that command aborted with an I/O error and the logs
> revealed this problem:
> 
> [284564.279190] BTRFS info (device sda1): relocating block group
> 51490279391232 flags data|raid6
> [284572.319649] btrfs_print_data_csum_error: 75 callbacks suppressed
> [284572.319656] BTRFS warning (device sda1): csum failed root -9 ino 433 off
> 386727936 csum 0x791e44cc expected csum 0xbd1725d0 mirror 2
> [284572.320165] BTRFS warning (device sda1): csum failed root -9 ino 433 off
> 386732032 csum 0xec5f6097 expected csum 0x9114b5fa mirror 2
> [284572.320211] BTRFS warning (device sda1): csum failed root -9 ino 433 off
> 386736128 csum 0x4d2fa4b9 expected csum 0xf8a923f9 mirror 2
> [284572.320225] BTRFS warning (device sda1): csum failed root -9 ino 433 off
> 386740224 csum 0xcad08362 expected csum 0xa9361ed3 mirror 2
> [284572.320266] BTRFS warning (device sda1): csum failed root -9 ino 433 off
> 386744320 csum 0x469ac192 expected csum 0xb1e94692 mirror 2
> [284572.320279] BTRFS warning (device sda1): csum failed root -9 ino 433 off
> 386748416 csum 0x69759c1f expected csum 0xb3b9aa86 mirror 2
> [284572.320290] BTRFS warning (device sda1): csum failed root -9 ino 433 off
> 386752512 csum 0xd3a7c5d5 expected csum 0xd351862f mirror 2
> [284572.320465] BTRFS warning (device sda1): csum failed root -9 ino 433 off
> 386756608 csum 0x1264af83 expected csum 0x3a2c0ed5 mirror 2
> [284572.320480] BTRFS warning (device sda1): csum failed root -9 ino 433 off
> 386760704 csum 0x260a13ef expected csum 0xb3b4aec0 mirror 2
> [284572.320492] BTRFS warning (device sda1): csum failed root -9 ino 433 off
> 386764800 csum 0x6b615cd9 expected csum 0x99eaf560 mirror 2
> 
> I ran a long SMART self-test on the drives in the array which found no
> problem. 

You are hitting a few of the known bugs in btrfs raid5/6.  See

	https://lore.kernel.org/linux-btrfs/20200627032414.GX10769@hungrycats.org/

TL;DR don't expect anything to work right until 'btrfs replace' is done.

> Currently I am running scrub to attempt and fix the block group.

Scrub can only correct errors that exist on the disk, so scrub has no
effect here.  Wait until 'btrfs replace' is done, then scrub the other
disks in the array.

btrfs raid6 has broken read code for degraded mode.  The errors above
all originate from trees inside the kernel (root -9 isn't a normal
on-disk root).  Those errors don't exist on disk.  The errors are
triggered repeatably by on-disk structures, so the errors will _appear_
to be persistent (i.e.  if you try to balance the same block group twice
it will usually fail at the same spot); however, the on-disk structures
are valid, and should not produce an error if the kernel code was correct,
or if the missing disk is replaced.

> scrub status:
> 
> UUID:             9c3c3f8d-a601-4bd3-8871-d068dd500a15
> 
> Scrub started:    Fri Jul 17 07:52:06 2020
> Status:           running
> Duration:         14:47:07
> Time left:        202:05:46
> ETA:              Tue Jul 28 00:07:36 2020
> Total to scrub:   16.80TiB
> Bytes scrubbed:   1.14TiB
> Rate:             22.56MiB/s
> Error summary:    read=295132162
>   Corrected:      0
>   Uncorrectable:  295132162
>   Unverified:     0
> 
> device stats:
> 
> Label: none  uuid: 9c3c3f8d-a601-4bd3-8871-d068dd500a15
>         Total devices 5 FS bytes used 16.80TiB
>         devid    3 size 9.09TiB used 8.76TiB path /dev/sda1
>         devid    4 size 9.09TiB used 8.76TiB path /dev/sdb1
>         devid    5 size 9.09TiB used 8.74TiB path /dev/sdd1
>         devid    6 size 9.09TiB used 498.53GiB path /dev/sdc1
>         *** Some devices missing
> 
> Is there anything else I can do to try and specifically fix that one block
> group rather than scrubbing the entire filesytem? Also, is it "normal" that
> scrub stats would show a huge number of "uncorrectable" errors when a device
> is missing or should I be worried about that?

There might be a few dozen KB of uncorrectable data after the 'btrfs
replace' is done, depending on how messy the original disk failure was.

You may want to zero the dev stats once the btrfs replace is done,
as the stats collected during degraded mode will be mostly garbage.

> Kind regards,
>  Edmund
> 
> 
> -- 
> Auch Liland ist in der Krise für Sie da! #WirBleibenZuhause und liefern
> Ihnen trotzdem weiterhin hohe Qualität und besten Service. 
> Unser Support <mailto:support@liland.com> steht weiterhin wie gewohnt zur
> Verfügung.
> Ihr Team LILAND
> *
> *
> *Liland IT GmbH*
> 
> 
> Ferlach ● Wien ● München
> Tel: +43 463 220111
> Tel: +49 89 458 15 940
> office@Liland.com
> https://Liland.com <https://Liland.com> 
> <https://twitter.com/lilandit>  <https://www.instagram.com/liland_com/> 
> <https://www.facebook.com/LilandIT/>
> 
> Copyright © 2020 Liland IT GmbH 
> 
> 
> Diese Mail enthaelt vertrauliche und/oder rechtlich geschuetzte 
> Informationen. 
> Wenn Sie nicht der richtige Adressat sind oder diese Email
> irrtuemlich erhalten haben, informieren Sie bitte sofort den Absender und
> vernichten Sie diese Mail. Das unerlaubte Kopieren sowie die unbefugte
> Weitergabe dieser Mail ist nicht gestattet. 
> 
> This email may contain confidential and/or privileged information. 
> If you are not the intended recipient (or have received this email in error)
> please notify the sender immediately and destroy this email.
> Any unauthorised copying, disclosure or distribution of the material in
> this email is strictly forbidden.
