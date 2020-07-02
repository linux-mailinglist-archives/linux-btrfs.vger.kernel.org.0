Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7A7212C60
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 20:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgGBSbg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 2 Jul 2020 14:31:36 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:37272 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgGBSbg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 14:31:36 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 3CAD07430F7; Thu,  2 Jul 2020 14:31:34 -0400 (EDT)
Date:   Thu, 2 Jul 2020 14:31:34 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Marc Lehmann <schmorp@schmorp.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: first mount(s) after unclean shutdown always fail
Message-ID: <20200702183134.GB10769@hungrycats.org>
References: <20200701005116.GA5478@schmorp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200701005116.GA5478@schmorp.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 01, 2020 at 02:51:16AM +0200, Marc Lehmann wrote:
> Hi!
> 
> I have a server with multiple btrfs filesystems and some moderate-sized
> dmcache caches (a few million blocks/100s of GBs).
> 
> When the server has an unclean shutdown, dmcache treats all cached blocks
> as dirty. This has the effect of extremely slow I/O, as dmcache basically
> caches a lot of random I/O, and writing these blocks back to the rotating
> disk backing store can take hours. This, I think, is related to the
> problem.
> 
> When the server is in this condition, then all btrfs filesystems on slow
> stores (regardless of whether they use dmcache or not) fail their first
> mount attempt(s) like this:
> 
>    [  173.243117] BTRFS info (device dm-7): has skinny extents
>    [  864.982108] BTRFS error (device dm-7): open_ctree failed
> 
> Recent kernels sometimes additionally fail like this (super_total_bytes):
> 
>    [  867.721885] BTRFS info (device dm-7): turning on sync discard
>    [  867.722341] BTRFS info (device dm-7): disk space caching is enabled
>    [  867.722691] BTRFS info (device dm-7): has skinny extents
>    [  871.257020] BTRFS error (device dm-7): super_total_bytes 858976681984 mismatch with fs_devices total_rw_bytes 1717953363968
>    [  871.257487] BTRFS error (device dm-7): failed to read chunk tree: -22
>    [  871.269989] BTRFS error (device dm-7): open_ctree failed
> 
> all the filesystems in question are mounted twice during normal boots,
> with diferent subvolumes, and systemd parallelises these mounts. This might
> play a role in these failures.

When LVM is manipulating the device-mapper table it can sometimes trigger
udev events and run btrfs dev scan, which temporarily points btrfs to
the wrong device.  

It's possible that the backing device for lvmcache is visible temporarily
during startup (userspace cache_check has to be able to access the cache
layers separately while it runs during lvm startup).  If systemd attempts
to mount the btrfs, and btrfs ends up using the backing store directly
while cache_check is running, then btrfs gets confused when LVM enables
the cache and flips btrfs to the cached LV (not to mention any metadata
inconsistencies from looking at the backing disk that will be missing
unflushed writeback updates).  Normally this isn't a problem if you run
vgchange then btrfs dev scan then mount, but systemd's hyperaggressive
mount execution and potentially incomplete parallel execution dependency
model might make it a problem.

btrfs is not blameless here either.  Once a btrfs has been mounted
on a set of devices, it should be difficult or impossible for udev
rules to switch to different devices without umounting, possibly with
narrow exceptions e.g. for filesystems mounted on removable USB media.
It certainly shouldn't happen several times each time lvm reloads the
device-mapper table, as the btrfs signature can appear on a lot of
different dm-table devices.

This happens all the time with pvmove and other LVM volume management
operations, you'll see a handful of btrfs corruption errors scrolling
by while moving btrfs LVs between disks, sometimes also when creating
new LVs.  In one instance, I pvmoved a btrfs raid1 LV and deleted a
swap LV from a disk, then attempted to recreate the swap LV.  The new
swap LV ended up in the same physical position as the btrfs raid1 LV,
which was still mounted and active.  udev immediately flipped btrfs over
to using the swap LV as its raid1 mirror, then the swap LV was formatted
and used, with predictably disastrous results: btrfs raid1 interpreted
the swapped out pages as data corruption errors and repaired them, while
programs were killed because their swapped-out pages were overwritten
with filesystem and crashed hard when the pages were swapped back in.
A fine example of worst-case udev and LVM behavior.

> Simply trying to mount the filesystems again then (usually) succeeds with
> seemingly no issues, so these are spurious mount failures. These repeated
> mount attewmpts are also much faster, presumably because a lot of the data
> is already in memory.
> 
> As far as I am concerned, this is 100% reproducible (i.e. it happens on every
> unclean shutdown). It also happens on "old" (4.19 era) filesystems as well as
> on filesystems that have never seen anything older than 5.4 kernels.
> 
> It does _not_ happen with filesystems on SSDs, regardless of whether they
> are mounted multiple times or not. It does happen to all filesystems that
> are on rotating disks affected by dm-cache writes, regardless of whether
> the filesystem itself uses dmcache or not.

Does this mean that you have a rotating disk which contains a dm-cached
filesystem and a btrfs filesystem that does not use dm-cache, and the
btrfs filesystem is affected?  That would dismiss my theory above.
I have no theory to handle that case.

> The system in question is currently running 5.6.17, but the same thing
> happens with 5.4 and 5.2 kernels, and it might have happened with much
> earlier kernels as well, but I didn't have time to report this (as I
> secretly hoped newer kernels would fix this, and unclean shutdowns are
> rare).

FWIW unclean shutdowns are the only kind of shutdown I do with lvmcache
and btrfs (intentionally, in order to detect bugs like this), and I
haven't seen this problem.  I don't run systemd.

> Example btrfs kernel messages for one such unclean boot. This involved
> normal boot, followed by unsuccessfull "mount -va" in the emergency shell
> (i.e. a second mount fasilure for the same filesystem), followed by a
> successfull "mount -va" in the shell.
> 
> [  122.856787] BTRFS: device label LOCALVOL devid 1 transid 152865 /dev/mapper/cryptlocalvol scanned by btrfs (727)
> [  173.242545] BTRFS info (device dm-7): disk space caching is enabled
> [  173.243117] BTRFS info (device dm-7): has skinny extents
> [  363.573875] INFO: task mount:1103 blocked for more than 120 seconds.
> the above message repeats multiple times, backtrace &c has been removed for clarity
> [  484.405875] INFO: task mount:1103 blocked for more than 241 seconds.
> [  605.237859] INFO: task mount:1103 blocked for more than 362 seconds.
> [  605.252478] INFO: task mount:1211 blocked for more than 120 seconds.
> [  726.069900] INFO: task mount:1103 blocked for more than 483 seconds.
> [  726.084415] INFO: task mount:1211 blocked for more than 241 seconds.
> [  846.901874] INFO: task mount:1103 blocked for more than 604 seconds.
> [  846.916431] INFO: task mount:1211 blocked for more than 362 seconds.
> [  864.982108] BTRFS error (device dm-7): open_ctree failed
> [  867.551400] BTRFS info (device dm-7): turning on sync discard
> [  867.551875] BTRFS info (device dm-7): disk space caching is enabled
> [  867.552242] BTRFS info (device dm-7): has skinny extents
> [  867.565896] BTRFS error (device dm-7): open_ctree failed

Have you deleted some log messages there?  There's no explanation for
the first two open_ctree failures.

> [  867.721885] BTRFS info (device dm-7): turning on sync discard
> [  867.722341] BTRFS info (device dm-7): disk space caching is enabled
> [  867.722691] BTRFS info (device dm-7): has skinny extents
> [  871.257020] BTRFS error (device dm-7): super_total_bytes 858976681984 mismatch with fs_devices total_rw_bytes 1717953363968
> [  871.257487] BTRFS error (device dm-7): failed to read chunk tree: -22
> [  871.269989] BTRFS error (device dm-7): open_ctree failed
> [  872.535935] BTRFS info (device dm-7): disk space caching is enabled
> [  872.536438] BTRFS info (device dm-7): has skinny extents
> 
> Example fstab entries for the mounts above:
> 
> /dev/mapper/cryptlocalvol       /localvol       btrfs           defaults,nossd,discard                  0       0
> /dev/mapper/cryptlocalvol       /cryptlocalvol  btrfs           defaults,nossd,subvol=/                 0       0
> 
> I don't need assistance, I merely write this in the hope of btrfs being
> improved by this information.
> 
> -- 
>                 The choice of a       Deliantra, the free code+content MORPG
>       -----==-     _GNU_              http://www.deliantra.net
>       ----==-- _       generation
>       ---==---(_)__  __ ____  __      Marc Lehmann
>       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
>       -=====/_/_//_/\_,_/ /_/\_\
