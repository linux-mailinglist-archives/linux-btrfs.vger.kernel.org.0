Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F79D31FF74
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 20:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhBSTaa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 14:30:30 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46950 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBSTa3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 14:30:29 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 05B57995E06; Fri, 19 Feb 2021 14:29:47 -0500 (EST)
Date:   Fri, 19 Feb 2021 14:29:47 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: ERROR: failed to read block groups: Input/output error
Message-ID: <20210219192947.GJ32440@hungrycats.org>
References: <CAOE4rSyacNvoACo7+CYc76=WFS6XYtKMJg9akV61qfnnR1uTGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOE4rSyacNvoACo7+CYc76=WFS6XYtKMJg9akV61qfnnR1uTGg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 14, 2021 at 01:09:40AM +0200, Dāvis Mosāns wrote:
> Hi,
> 
> I've 6x 3TB HDD RAID1 BTRFS filesystem where HBA card failed and
> caused some corruption.
> When I try to mount it I get
> $ mount /dev/sdt /mnt
> mount: /mnt/: wrong fs type, bad option, bad superblock on /dev/sdt,
> missing codepage or helper program, or other error
> $ dmesg | tail -n 9
> [  617.158962] BTRFS info (device sdt): disk space caching is enabled
> [  617.158965] BTRFS info (device sdt): has skinny extents
> [  617.756924] BTRFS info (device sdt): bdev /dev/sdl errs: wr 0, rd
> 0, flush 0, corrupt 473, gen 0
> [  617.756929] BTRFS info (device sdt): bdev /dev/sdj errs: wr 31626,
> rd 18765, flush 178, corrupt 5841, gen 0
> [  617.756933] BTRFS info (device sdt): bdev /dev/sdg errs: wr 6867,
> rd 2640, flush 178, corrupt 1066, gen 0

You have write errors on 2 disks, read errors on 3 disks, and raid1
tolerates only 1 disk failure, so successful recovery is unlikely.

> [  631.353725] BTRFS warning (device sdt): sdt checksum verify failed
> on 21057101103104 wanted 0x753cdd5f found 0x9c0ba035 level 0
> [  631.376024] BTRFS warning (device sdt): sdt checksum verify failed
> on 21057101103104 wanted 0x753cdd5f found 0xb908effa level 0

Both copies of this metadata block are corrupted, differently.

This is consistent with some kinds of HBA failure:  every outgoing block
from the host is potentially corrupted, usually silently.  Due to the HBA
failure, there is no indication of failure available to the filesystem
until after several corrupt blocks are written to disk.  By the time
failure is detected, damage is extensive, especially for metadata where
overwrites are frequent.

This is failure mode that you need backups to recover from (or mirror
disks on separate, non-failing HBA hardware).

> [  631.376038] BTRFS error (device sdt): failed to read block groups: -5
> [  631.422811] BTRFS error (device sdt): open_ctree failed
> 
> $ uname -r
> 5.9.14-arch1-1
> $ btrfs --version
> btrfs-progs v5.9
> $ btrfs check /dev/sdt
> Opening filesystem to check...
> checksum verify failed on 21057101103104 found 000000B9 wanted 00000075
> checksum verify failed on 21057101103104 found 0000009C wanted 00000075
> checksum verify failed on 21057101103104 found 000000B9 wanted 00000075
> Csum didn't match
> ERROR: failed to read block groups: Input/output error
> ERROR: cannot open file system
> 
> $ btrfs filesystem show
> Label: 'RAID'  uuid: 8aef11a9-beb6-49ea-9b2d-7876611a39e5
> Total devices 6 FS bytes used 4.69TiB
> devid    1 size 2.73TiB used 1.71TiB path /dev/sdt
> devid    2 size 2.73TiB used 1.70TiB path /dev/sdl
> devid    3 size 2.73TiB used 1.71TiB path /dev/sdj
> devid    4 size 2.73TiB used 1.70TiB path /dev/sds
> devid    5 size 2.73TiB used 1.69TiB path /dev/sdg
> devid    6 size 2.73TiB used 1.69TiB path /dev/sdc
> 
> 
> My guess is that some drives dropped out while kernel was still
> writing to rest thus causing inconsistency.
> There should be some way to find out which drives has the most
> up-to-date info and assume those are correct.

Neither available copy is correct, so the kernel's self-healing mechanism
doesn't work.  Thousands of pages are damaged, possibly only with minor
errors, but multiply a minor error by a thousand and it's no longer minor.

At this point it is a forensic recovery exercise.

> I tried to mount with
> $ mount -o ro,degraded,rescue=usebackuproot /dev/sdt /mnt
> but that didn't make any difference
> 
> So any idea how to fix this filesystem?

Before you can mount the filesystem read-write again, you would need to
rebuild the extent tree from the surviving pages of the subvol trees.
All other metadata pages on the filesystem must be scanned, any excess
reference items must be deleted, and any missing reference items must
be inserted.  Once the metadata references are correct, btrfs can
rebuild the free space maps, and then you can scrub and delete/replace
any damaged data files.

'btrfs check --repair' might work if only a handful of blocks are
corrupted (it takes a few short cuts and can repair minor damage)
but according to your dev stats you have thousands of corrupted blocks,
so the filesystem is probably beyond the capabilities of this tool.

'btrfs check --repair --init-extent-tree' is a brute-force operation that
will more or less rebuild the entire filesystem by scraping metadata
leaf pages off the disks.  This is your only hope here, and it's not a
good one.

Both methods are likely to fail in the presence of so much corruption
and they may take so long to run that mkfs + restore from backups could
be significantly faster.  Definitely extract any data from the filesystem
that you want to keep _before_ attempting any of these operations.

It might be possible to recover by manually inspecting the corrupted
metadata blocks and making guesses and adjustments, but that could take
even longer than check --repair if there are thousands of damaged pages.

> Thanks!
> 
> Best regards,
> Dāvis
