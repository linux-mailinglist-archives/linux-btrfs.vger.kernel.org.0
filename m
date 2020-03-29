Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 029CF196B8B
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Mar 2020 08:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgC2GmR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 29 Mar 2020 02:42:17 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44082 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgC2GmR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Mar 2020 02:42:17 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 5D23A63D9DD; Sun, 29 Mar 2020 02:42:16 -0400 (EDT)
Date:   Sun, 29 Mar 2020 02:42:16 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Brad Templeton <4brad@templetons.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs-transacti hangs system for several seconds every few
 minutes
Message-ID: <20200329064216.GB13306@hungrycats.org>
References: <7c0a1398-322f-400a-abe4-dfea98fd46e1@templetons.com>
 <20200328212021.GA13306@hungrycats.org>
 <7778ece0-67d4-8d1c-b773-35f07d81dcbe@templetons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <7778ece0-67d4-8d1c-b773-35f07d81dcbe@templetons.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 28, 2020 at 09:02:38PM -0700, Brad Templeton wrote:
>    Not using qgroups.  Not doing snapshots.    Did a reboot with the options
>    to upgrade to v2 -- it failed, in that the disk check took more than 6
>    minutes, but it worked, and the second time I was able to boot, and --
>    knock on wood -- so far it has not hung.
> 
>    I wonder why they put 5.3.0 as the standard advanced Kernel in Ubuntu LTS
>    if it has a data corruption bug.   

Ubuntu, like most Linux distros, chooses the kernel version to ship
based on release date.  QA/defect data does not usually affect that
decision.

Starting with 5.2 there are internal btrfs mitigations for metadata
corruption.  5.3, 5.4, and 5.5 contain improved mitigations which are
able to detect more corruption cases introduced by regressions in 5.1
(and also external causes like RAM failure), and block the corrupted
data before it reaches the disk.  This blocking is done by forcing the
filesystem readonly, so even if you don't get on-disk corruption, you're
still going to need to at least unmount the filesystem and possibly
reboot if you hit the bug.

The risk is that the tree checker can't detect every possible corruption,
and some things might slip through undetected.  The probability of this
failure is normally small (about the same failure rate as an average hard
drive), but the risk increases significantly while metadata-intensive
operations like device delete or shrinking resize are running.  On a
10TB filesystem it is unlikely you would be able to complete a device
delete operation without some kind of error, and then you're rolling
dice to see if the filesystem survives intact.

Ubuntu could backport the fix from 5.4.14 (the patch applies to 5.1
and later).  I don't know if Ubuntu has done this.  When in doubt,
assume the fix is not present.

>    I don't know if I've seen any release
>    of 5.4.14 in a PPA yet -- manual kernel install is such a pain the few
>    times I have done it.  I could revert, but the reason I switched to 5.3,
>    not long ago, was another problem with sound drivers.

Yeah, non-overlapping bug lifetimes suck.

>    BTW, even though it now works, it still takes 90 seconds every boot doing
>    a disk check, even after what I think is a clean shutdown.   I presume
>    that is not normal, any clues on what may cause that?

It shouldn't be doing a disk check at all, even on an unclean shutdown.
btrfs writes data in order so no checking is required unless your disks
break (and with raid1 you need two broken disks at the same time).
fsck.btrfs is a no-op stub.

90 seconds sounds about right for the block group scan when mounting on
a 10TB filesystem.  There's a feature called block group tree in kernel
5.5 that helps with that:  it lays out block group items on disk closer
together so they can be read in milliseconds.  This is an on-disk format
change, so once you enable that feature, you wouldn't be able to mount
the filesystem on an older kernel.  This can be a problem if your
sound drivers have regressions.  You might want to wait a few kernel
releases to be sure you don't need to downgrade.

>    On 3/28/20 2:20 PM, Zygo Blaxell wrote:
> 
>  On Sat, Mar 28, 2020 at 11:26:56AM -0700, Brad Templeton wrote:
> 
>  I have a decent sized 3 disk Raid 1 that I have had on btrfs for many
>  years. Over time, a serious problem has emerged, in that from time to
>  time all I/O will pause, freezing any programs attempting to use the
>  btrfs filesystem.   Performance has degraded over the years as well, so
>  that just browsing around in directories with 300 or so files often
>  takes many seconds just to autocomplete a filename or do an ls.
> 
>  But the big problem is that during periods of active but not heavy use,
>  every few minutes the i/o system will hang for periods of 1 to 10
>  seconds.   During these hangs, btrfs-transacti is doing very heavy I/O.
>    Programs waiting on I/O block -- the most frustrating is typing in vi
>  and having the echo stop.  It's getting close to unusable and may be
>  time to leave btrfs after many years for a different FS.
> 
>  During these incidents iotop will look like this:
> 
>  Total DISK READ :     499.57 K/s | Total DISK WRITE :    1639.00 K/s
>  Actual DISK READ:     492.73 K/s | Actual DISK WRITE:       0.00 B/s
>    TID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN      IO    COMMAND
>    882 be/4 root      499.57 K/s 1604.78 K/s  0.00 % 98.60 %
>  [btrfs-transacti]
>  21829 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.23 %
>  [kworker/u32:1-btrfs-endio-meta]
>  14662 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.17 %
>  [kworker/u32:0-btrfs-endio-meta]
>  22184 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.11 %
>  [kworker/u32:3-events_freezable_power_]
>  13063 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.06 %
>  [kworker/u32:6-events_freezable_power_]
>    486 be/3 root        0.00 B/s    6.84 K/s  0.00 %  0.00 % systemd-journald
>  22213 be/4 brad        0.00 B/s    6.84 K/s  0.00 %  0.00 % chrome
>  --no-startup-window [ThreadPoolForeg]
> 
>  A way to reliably generate it, I have found, is to quickly skim through
>  my large video collection  (looking for videos) I would be hitting
>  "next" every second or so -- lots of read, but very little write.
>  After doing about 40 seconds of this, it is sure to hang.
> 
>  I am running kernel 5.3.0 on Ubuntu 18.04.4, but have seen this problem
>  gong back into much older kernels.
> 
>  PSA:  Get off 5.3.0.  There is a serious bug in kernels 5.1 to 5.4.13 that
>  can lead to metadata corruption resulting in loss of the filesystem.
>  Go to 5.4.14 or later, or back to 4.19.y for y > 100 or so.  This advice
>  applies to all btrfs users, it's not related to latency.
> 
>  In this case 4.19 might be a better choice than later kernels for latency.
>  5.0 had some latency-related regressions, and fixes for those are still
>  in development.
> 
> 
>  My array looks like this:
> 
>  /dev/sda, ID: 2
>     Device size:             3.64TiB
>     Device slack:              0.00B
>     Data,RAID1:              1.79TiB
>     Metadata,RAID1:          8.00GiB
>     Unallocated:             1.84TiB
> 
>  /dev/sdg, ID: 1
>     Device size:             9.10TiB
>     Device slack:              0.00B
>     Data,RAID1:              7.21TiB
>     Metadata,RAID1:         14.00GiB
>     System,RAID1:           32.00MiB
>     Unallocated:             1.87TiB
> 
>  /dev/sdh, ID: 3
>     Device size:             7.28TiB
>     Device slack:          344.00KiB
>     Data,RAID1:              5.43TiB
>     Metadata,RAID1:          8.00GiB
>     System,RAID1:           32.00MiB
>     Unallocated:             1.84TiB
> 
>  /dev/sdg on /home type btrfs
>  (rw,relatime,space_cache,subvolid=256,subvol=/home)
> 
>  Two things in the mount options:
> 
>  1.  PSA:  Upgrade to space_cache=v2.  Unmount the filesystem, then mount
>  it with '-o clear_cache,space_cache=v2' (remount is not sufficient, you
>  have to completely umount).  This will take some minutes, but it only
>  has to be done once.  Transactions will be quite slow on a filesystem
>  with ~10000 block groups with space_cache=v1.  Afterwards, use
> 
>          btrfs ins dump-tree -t 10 /dev/vgwaya/root |
>                  grep 'owner FREE_SPACE_TREE' | wc -l
> 
>  to verify the space_cache=v2 conversion was done (it should give a
>  non-zero number).  Although directly relevant to this case, this advice
>  is a PSA because it also applies to all btrfs users.
> 
>  2.  Use noatime instead of relatime.
> 
>  In the mount man page for 'relatime':
> 
>          since Linux 2.6.30, the file's last access time is always updated
>          if it is more than 1 day old
> 
>  If you get this high-latency behavior about once a day, but it's fine
>  at other times, then this is the likely cause.  Some users need atime
>  updates, and they're usually OK on small SSD filesystems; however, this
>  filesystem is neither small nor SSD, and most users don't need atime.
> 
>  You didn't mention snapshots.  If you don't have snapshots then disregard
>  the rest of this paragraph.  If you do have snapshots, then each time
>  you modify a snapshotted subvol (either origin or snapshot, doesn't
>  matter, what matters is that the metadata is shared), btrfs will be
>  doing extra writes to unshare shared pages and update reference counts.
>  Immediately after the snapshot is created, the write multiplication factor
>  is about 300.  The factor drops rapidly to 1.0, but it can take a few
>  minutes to get through the first 10000 page updates after a snapshot,
>  and you can easily get that many by touching 500 files.  Note that the
>  snapshot could have been made in the past, its existence will still
>  affect the write performance of the filesystem in the present.
> 
>  All of the above effects combine:  5.0 and later do not attempt to manage
>  latency, atime updates throw a lot of writes into the queue at once,
>  space_cache=v1 makes every write slower to exit the queue, and fresh
>  snapshots multiply everything else by an order of magnitude.  With all of
>  those at once, I'm surprised it's as fast as you reported.  Starting with
>  kernel 5.0 it's not hard to make a btrfs commit take 10 hours.
> 
> 
>  I have 16gb of ram with 16gb of swap on a flash drive, the swap is in use
> 
>  KiB Mem : 16393944 total,   398800 free, 13538088 used,  2457056 buff/cache
>  KiB Swap: 16777212 total,  6804352 free,  9972860 used.  2045812 avail Mem
> 
>  Check slabtop:
> 
>          # slabtop | grep btrfs_delayed_ref_head
>          105072 105072 100%    0.33K   8756       12     35024K btrfs_delayed_ref_head
> 
>  Divide the second number (count of btrfs_delayed_ref_head slabs in use)
>  by about 1000 (depends on how fast your disks are, range is about 500 to
>  10000 for consumer hardware) and the result is roughly the commit latency
>  in seconds.  It's not the only time spent in a commit, but btrfs spends
>  orders of magnitude more time on delayed refs than on anything else.
>  On kernels before 5.0 btrfs kept the delayed ref head count below 10000,
>  but after 5.0 it is allowed to grow until memory is exhausted.
> 
>  The latency fixes currently in development put the latency caps from
>  4.19 back in, and also add new ones, e.g. snapshot delete could create
>  unlimited latency in btrfs since the beginning.  5.7 or 5.8 should be
>  better at latency than 4.19.
> 
> 
>  What other information would be useful in attempting to diagnose or fix
>  this?   I like a number of things about BTFS.  One of them that I don't
>  want to give up is the ability to do RAID with different sized disks,
>  which seems like the only way it should work.  Switching to ZFS or mdadm
>  again would involve disk upgrades and a very large amount of time
>  copying this much data, but I'll have to do it if I can't diagnose this.
