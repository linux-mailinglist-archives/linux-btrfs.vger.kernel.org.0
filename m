Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22946233C58
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 01:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbgG3X7P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 19:59:15 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:45428 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgG3X7P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 19:59:15 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 91D0478BE4A; Thu, 30 Jul 2020 19:59:13 -0400 (EDT)
Date:   Thu, 30 Jul 2020 19:59:13 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Thommandra Gowtham <trgowtham123@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: RAID1 disk missing
Message-ID: <20200730235913.GJ5890@hungrycats.org>
References: <CA+XNQ=i9dbr924u+dOT3=s_HLx3kOnOo=ajjQEOnOdWzNbG+kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+XNQ=i9dbr924u+dOT3=s_HLx3kOnOo=ajjQEOnOdWzNbG+kA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 30, 2020 at 05:08:53PM +0530, Thommandra Gowtham wrote:
> Hi,
> 
> I have root as BTRFS and are moving from 'single' to a RAID1
> configuration with 2 disks. If one of the disk goes bad i.e completely
> inaccessible to kernel(might be due a hardware issue), we are seeing
> errors like below
> 
> [24710.550168] BTRFS error (device sdb3): bdev /dev/sda3 errs: wr
> 96618, rd 16870, flush 105, corrupt 0, gen 0
> [24710.561121] BTRFS error (device sdb3): bdev /dev/sda3 errs: wr
> 96619, rd 16870, flush 105, corrupt 0, gen 0
> [24710.572056] BTRFS error (device sdb3): bdev /dev/sda3 errs: wr
> 96620, rd 16870, flush 105, corrupt 0, gen 0
> [24710.582983] BTRFS error (device sdb3): bdev /dev/sda3 errs: wr
> 96621, rd 16870, flush 105, corrupt 0, gen 0
> [24710.593993] BTRFS error (device sdb3): bdev /dev/sda3 errs: wr
> 96622, rd 16870, flush 105, corrupt 0, gen 0
> [24710.605112] BTRFS error (device sdb3): bdev /dev/sda3 errs: wr
> 96623, rd 16870, flush 105, corrupt 0, gen 0
> 
> The above are expected because one of the disks is missing. How do I
> make sure that the system works fine until a replacement disk is
> added? That can take a few days or a week?

btrfs doesn't have a good way to eject a disk from the array if it
fails while mounted.  It should, but it doesn't.

You might be able to drop the SCSI device with:

	echo 1 > /sys/block/sdb/device/delete

which will at least stop the flood of kernel errors.

> # btrfs fi show
> Label: 'rpool'  uuid: 2e9cf1a2-6688-4f7d-b371-a3a878e4bdf3
> Total devices 2 FS bytes used 10.86GiB
> devid    1 size 206.47GiB used 28.03GiB path /dev/sdb3
> *** Some devices missing
> 
> Sometimes, the bad disk works fine after a power-cycle. When the disk
> is seen again by the kernel after power-cycle, we see errors like
> below
> 
> [  222.410779] BTRFS error (device sdb3): parent transid verify failed
> on 1042750283776 wanted 422935 found 422735
> [  222.429451] BTRFS error (device sdb3): parent transid verify failed
> on 1042750353408 wanted 422939 found 422899
> [  222.442354] BTRFS error (device sdb3): parent transid verify failed
> on 1042750357504 wanted 422915 found 422779

btrfs has data integrity checks on references between nodes in the
filesystem tree.  These integrity checks can detect silent data
corruptions (except nodatasum files and short csum collisions) by any
cause, including a disconnected raid1 array member.  btrfs doesn't handle
device disconnects or IO errors specially since the data integrity checks
are sufficient.

When a disk is disconnected in raid1, blocks are not updated on the
disconnected disk.  If the disk is reconnected later, every update
that occurred while the disk was disconnected is detected by btrfs as
silent data corruption errors, and can be repaired the same way as any
other silent data corruption.  Scrub or device replace will fix such
corruptions after the disk is replaced, and any bad data detected during
normal reads will be repaired as well.

Generally it's not a good idea to continue to use a disk that
intermittently disconnects.  Each time it happens, you must run a
scrub to verify all data is present on both disks and repair any lost
writes on the disconnected disk.  You don't necessarily need to do this
immediately--if the other disk is healthy, btrfs will just repair the
out-of-sync disk when normal reads trip over errors.  You can schedule
the scrub for a maintenance window.

In some cases intermittent disconnects can happen due to bad power supply
or bad cabling, rather than a broken disk, but in any case if there are
intermittent disconnects then _some_ hardware is broken and needs to
be replaced.

If you have two disks that intermittently disconnect, it will break
the array.  raid1 tolerates one and only one disk failure.  If a second
disk fails before scrub/replace is finished on the first failing disk,
the filesystem will be severely damaged.  btrfs check --repair, or mkfs
and start over.

> And the BTRFS is unable to mount the filesystem in several cases due
> to the errors. How do I proactively take action when a disk goes
> missing(and can take a few days to get replaced)?

Normally no action is required for raid1[1].  If the disk is causing a
performance or power issue (i.e. it's still responding to IO requests
but very slowly, or it's failing so badly that it's damaging the power
supply, then we'll disconnect it, but normally we don't touch the array
[2] at all until the replacement disk arrives.

> Is moving back from RAID1 to 'single' the only solution?

In a 2-disk array there is little difference between degraded mode and
single.  Almost any failure event that will kill a raid1 degraded array
will also kill a single-disk filesystem.

If it's a small array, you could balance metadata to raid1 (if you still
have 2 or more disks left) or dup (if you are down to just one disk).
This will provide slightly more robustness against a second partial disk
failure while the array is degraded (i.e. a bad sector on the disk that
is still online).  For large arrays the metadata balance will take far
longer than the disk replacement time, so there's no point.

> Please let me know your inputs.

Also note that some disks have firmware bugs that break write caching
when there are UNC errors on the disk.  Unfortunately it's hard to tell
if your drive firmware has such a bug until it has bad sectors.  If you
have a drive with this type of bug in a raid1 array, btrfs will simply
repair all the write cache corruption from copies of the data stored on
the healthy array members.  In degraded mode, such repair is no longer
possible, so you may want to use hdparm -W0 on all disks in the array
while it is degraded.

> I am using#   btrfs --version
> btrfs-progs v4.4
> 
> Ubuntu 16.04: 4.15.0-36-generic #1 SMP Mon Oct 22 21:20:30 PDT 2018
> x86_64 x86_64 x86_64 GNU/Linux
> 
> BTRFS in RAID1 configuration
> # btrfs fi show
> Label: 'rpool'  uuid: 2e9cf1a2-6688-4f7d-b371-a3a878e4bdf3
> Total devices 2 FS bytes used 11.14GiB
> devid    1 size 206.47GiB used 28.03GiB path /dev/sdb3
> devid    2 size 206.47GiB used 28.03GiB path /dev/sda3
> 
> Regards,
> Gowtham

[1] This doesn't work for btrfs raid5 and raid6--the array is more or
less useless while disks are missing, and the only way to fix it is to
replace (not delete) the missing devices or fix the kernel bugs.

[2] Literally, we do not touch the array.  There is a small but non-zero
risk of damaging an array every time a person holds a disk in their hands.
Humans sometimes drop things, and disks get more physically fragile and
sensitive to handling as they age.  We don't take those risks more than
we have to.
