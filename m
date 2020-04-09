Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02F751A2E68
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Apr 2020 06:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgDIEcr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Apr 2020 00:32:47 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46566 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgDIEcr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Apr 2020 00:32:47 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 79F6E65F103; Thu,  9 Apr 2020 00:32:46 -0400 (EDT)
Date:   Thu, 9 Apr 2020 00:32:46 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     kjansen387 <kjansen387@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs freezing on writes
Message-ID: <20200409043245.GO13306@hungrycats.org>
References: <6a1c8ce0-ce2a-698d-dcc6-0657a125dae4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a1c8ce0-ce2a-698d-dcc6-0657a125dae4@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 07, 2020 at 09:46:29PM +0200, kjansen387 wrote:
> Hello,
> 
> I'm using btrfs on fedora 31 running 5.5.10-200.fc31.x86_64 .
> 
> I've moved my workload from md raid5 to btrfs raid1.
> # btrfs filesystem show
> Label: none  uuid: 8ce9e167-57ea-4cf8-8678-3049ba028c12
>         Total devices 5 FS bytes used 3.73TiB
>         devid    1 size 3.64TiB used 2.53TiB path /dev/sde
>         devid    2 size 3.64TiB used 2.53TiB path /dev/sdf
>         devid    3 size 1.82TiB used 902.00GiB path /dev/sdb
>         devid    4 size 1.82TiB used 902.03GiB path /dev/sdc
>         devid    5 size 1.82TiB used 904.03GiB path /dev/sdd
> 
> # btrfs fi df /export
> Data, RAID1: total=3.85TiB, used=3.72TiB
> System, RAID1: total=32.00MiB, used=608.00KiB
> Metadata, RAID1: total=6.00GiB, used=5.16GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B

Try 'btrfs fi usage /export'.

I'm guessing most or all of your metadata is on sde and sdf, because
that's where the raid1 allocator would initially put it if you put those
drives together in 'mkfs.btrfs'.  'fi usage' will confirm or refute
that guess.

If this is true, then the following set of commands may help:

	btrfs fi resize 1:-4g /export;
	btrfs fi resize 2:-4g /export;
	btrfs balance start -mdevid=1 /export;
	btrfs fi resize 1:max /export;
	btrfs fi resize 2:max /export;

Right now your filesystem has equal space unallocated on each drive.
The first resize commands create a temporary shortage of space on the 2
largest drives, which will cause the allocator to place new metadata on
the 3 smaller ones to equalize free space during the balance.  The last
2 resize commands let you use all the space again--they will be filled in
with later data allocations.  A 4G size reduction is required because you
have 5 GB of metadata and 5 disks.  5 GB / 5 disks = 1 GB per disk, and
5 GB (total metadata on disks 1,2) - 1 GB (desired metadata on each disk)
= 4 GB (how much metadata we want to displace from the bigger disks).

This will probably take 2-3 hours, and the system will be very laggy
while it runs.  Best to leave it overnight.

I see that 'space_cache=v2' has already been suggested.  That usually
helps a lot especially on big filesystems.  space_cache=v2 does an
amount of work proportional to committed data size during a commit, while
space_cache=v1 does an amount of work proportional to *filesystem* size
(and committed data size too, but that is usually negligible if your
workload is nothing but write and fsync).

> After moving to btrfs, I'm seeing freezes of ~10 seconds very, very often
> (multiple times per minute). Mariadb, vim, influxdb, etc.
> 
> See attachment for a stacktrace of vim, and the dmesg output of 'echo w >
> /proc/sysrq-trigger' also including other hanging processes.
> 
> What's going on.. ? Hope someone can help.
> 
> Thanks,
> Klaas

> [937013.794253] mysqld          D    0 10412      1 0x00004000
> [937013.794254] Call Trace:
> [937013.794255]  ? __schedule+0x2c7/0x740
> [937013.794256]  schedule+0x4a/0xb0
> [937013.794264]  wait_for_commit+0x58/0x80 [btrfs]
> [937013.794266]  ? finish_wait+0x80/0x80
> [937013.794274]  btrfs_commit_transaction+0x87b/0xa20 [btrfs]
> [937013.794276]  ? dput+0xb6/0x2d0
> [937013.794286]  ? btrfs_log_dentry_safe+0x55/0x70 [btrfs]
> [937013.794295]  btrfs_sync_file+0x3b2/0x400 [btrfs]
> [937013.794297]  do_fsync+0x38/0x70
> [937013.794298]  __x64_sys_fsync+0x10/0x20
> [937013.794299]  do_syscall_64+0x5b/0x1c0
> [937013.794300]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

If fsync() can't do everything it wants to do with the (very fast)
log tree, it switches to a (not fast at all) full filesystem commit.
When that happens, the process calling fsync is stuck waiting for another
process to complete a transaction so it can start its own.

> [937013.795098] influxd         D    0 2082804      1 0x00004000
> [937013.795099] Call Trace:
> [937013.795100]  ? __schedule+0x2c7/0x740
> [937013.795102]  schedule+0x4a/0xb0
> [937013.795110]  wait_for_commit+0x58/0x80 [btrfs]
> [937013.795112]  ? finish_wait+0x80/0x80
> [937013.795120]  btrfs_commit_transaction+0x87b/0xa20 [btrfs]
> [937013.795121]  ? dput+0xb6/0x2d0
> [937013.795132]  ? btrfs_log_dentry_safe+0x55/0x70 [btrfs]
> [937013.795141]  btrfs_sync_file+0x3b2/0x400 [btrfs]
> [937013.795143]  do_fsync+0x38/0x70
> [937013.795144]  __x64_sys_fsync+0x10/0x20
> [937013.795145]  do_syscall_64+0x5b/0x1c0
> [937013.795146]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

This one started the transaction that mysqld's fsync is waiting for.

You also have this:

> [937013.794385] postmaster      D    0  3216   2409 0x00004000
> [937013.794385] Call Trace:
> [937013.794387]  ? __schedule+0x2c7/0x740
> [937013.794388]  schedule+0x4a/0xb0
> [937013.794388]  schedule_preempt_disabled+0xa/0x10
> [937013.794390]  __mutex_lock.isra.0+0x16b/0x4d0
> [937013.794398]  ? start_transaction+0xbb/0x4c0 [btrfs]
> [937013.794408]  btrfs_pin_log_trans+0x19/0x30 [btrfs]
> [937013.794417]  btrfs_rename2+0x25b/0x1f60 [btrfs]
> [937013.794419]  ? link_path_walk.part.0+0x74/0x540
> [937013.794420]  ? path_parentat.isra.0+0x3f/0x80
> [937013.794421]  ? inode_permission+0xad/0x140
> [937013.794422]  ? vfs_rename+0x3e1/0x9e0
> [937013.794430]  ? btrfs_create+0x200/0x200 [btrfs]
> [937013.794431]  vfs_rename+0x3e1/0x9e0
> [937013.794433]  ? __d_lookup+0x5e/0x140
> [937013.794434]  ? lookup_dcache+0x18/0x60
> [937013.794435]  do_renameat2+0x381/0x530
> [937013.794437]  __x64_sys_rename+0x1f/0x30
> [937013.794438]  do_syscall_64+0x5b/0x1c0
> [937013.794439]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

I don't know if this renaming over an existing file, but if you do
delete or truncate files (including renames over existing files) a
lot, you might be accumulating delayed refs (increases or decreases
in reference counts are queued up and performed in batches on btrfs
because there are so many).  Try 'slabtop', see if there are a lot of
'btrfs_delayed_ref_head' slabs ("a lot" is more than 10,000).

It's not likely you will hit this problem unless you are deleting a lot of
files, deleting a snapshot, or running a balance; however, if you are
doing those things, they certainly won't help with commit latency.

If you're hitting that bug, there are fixes in development that may help
(probably one or two kernel releases out though).
