Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80265217DB9
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 05:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgGHDoK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 23:44:10 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48288 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgGHDoJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 23:44:09 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 9393574FEF5; Tue,  7 Jul 2020 23:44:07 -0400 (EDT)
Date:   Tue, 7 Jul 2020 23:44:07 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: 5.6 pretty massive unexplained btrfs corruption:  parent transid
 verify failed + open_ctree failed
Message-ID: <20200708034407.GE10769@hungrycats.org>
References: <20200707035530.GP30660@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707035530.GP30660@merlins.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 06, 2020 at 08:55:30PM -0700, Marc MERLIN wrote:
> I'd love to know what went wrong so that it doesn't happen again, but let me know if you'd like data off this 
> before I wipe it (which I assume is the only way out at this point)
> myth:~# btrfs check --mode=lowmem /dev/mapper/crypt_bcache0
> parent transid verify failed on 7325633544192 wanted 359658 found 359661
> parent transid verify failed on 7325633544192 wanted 359658 found 359661
> parent transid verify failed on 7325633544192 wanted 359658 found 359661
> Ignoring transid failure
> leaf parent key incorrect 7325633544192
> ERROR: failed to read block groups: Operation not permitted
> ERROR: cannot open file system
> 
> 
> I did run bees on that filesystem, but I also just did a full btrfs check on it, and it came back clean:
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/crypt_bcache4
> UUID: 36f5079e-ca6c-4855-8639-ccb82695c18d
> [1/7] checking root items
> Fixed 0 roots.
> [2/7] checking extents
> No device size related problem found
> [3/7] checking free space cache
> cache and super generation don't match, space cache will be invalidated
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 18089211043840 bytes used, no error found
> total csum bytes: 17580412652
> total tree bytes: 82326192128
> total fs tree bytes: 56795086848
> total extent tree bytes: 5154258944
> btree space waste bytes: 13682108904
> file data blocks allocated: 24050542804992
> 
> 
> I then moved it to the target machine, started a btrfs send to it, and it failed quickly (due to a mistake
> I had an old btrfs binary on that server, but I'm hoping most of the work is done in kernel space and that the user space
> btrfs should not corrupt the disk if it's a bit old)

btrfs send has historically had bugs but not filesystem-damaging
ones (just relatively harmless kernel crashes and send failures).
btrfs receive is almost entirely userspace--it can't corrupt anything
that can't be corrupted by normal filesystem operations.

> myth:/mnt# uname -r
> 5.6.5-amd64-preempt-sysrq-20190817
> 
> Soon after, the copy failed:
> [ 2575.931316] BTRFS info (device dm-0): use zlib compression, level 3
> [ 2575.931329] BTRFS info (device dm-0): disk space caching is enabled
> [ 2575.931343] BTRFS info (device dm-0): has skinny extents
> [ 2577.286749] BTRFS info (device dm-0): bdev /dev/mapper/crypt_bcache0 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0

This line does indicate an older problem with the filesystem.  It doesn't
tell us whether the corruption happened yesterday or a year ago.
You will need to look at your older kernel logs for that.

> [ 2607.943516] BTRFS info (device dm-0): enabling ssd optimizations
> [ 2708.835200] BTRFS warning (device dm-0): block group 13002170433536 has wrong amount of free space
> [ 2708.835209] BTRFS warning (device dm-0): failed to load free space cache for block group 13002170433536, rebuilding it now
> [ 2740.589580] BTRFS warning (device dm-0): block group 17151175950336 has wrong amount of free space
> [ 2740.589593] BTRFS warning (device dm-0): failed to load free space cache for block group 17151175950336, rebuilding it now
> [ 2797.204169] perf: interrupt took too long (3146 > 3138), lowering kernel.perf_event_max_sample_rate to 63500
> [ 2882.545242] BTRFS info (device dm-0): the free space cache file (26234763345920) is invalid, skip it

Use space_cache=v2, especially on a big filesystem because space_cache=v1
slows down linearly with filesystem size.  There is no need for these
warnings.  They're probably a symptom rather than cause here.

> [ 3071.631905] BTRFS error (device dm-0): parent transid verify failed on 6353897537536 wanted 359658 found 359661
> [ 3071.643430] BTRFS error (device dm-0): parent transid verify failed on 6353897537536 wanted 359658 found 359661
> [ 3071.661985] BTRFS error (device dm-0): parent transid verify failed on 6353897537536 wanted 359658 found 359661
> [ 3071.661995] BTRFS: error (device dm-0) in btrfs_run_delayed_refs:2210: errno=-5 IO failure
> [ 3071.661999] BTRFS info (device dm-0): forced readonly
> [ 3071.662567] BTRFS error (device dm-0): parent transid verify failed on 6353897537536 wanted 359658 found 359661
> [ 3071.663076] BTRFS error (device dm-0): parent transid verify failed on 6353897537536 wanted 359658 found 359661
> [ 3071.663083] BTRFS: error (device dm-0) in btrfs_run_delayed_refs:2210: errno=-5 IO failure
> 
> Ok, maybe there was an IO failure, although none was shown by the kernel:

The "IO failure" mentioned here is the earlier parent transid verify
failure.  When the verification fails, the caller gets -EIO.

> however, now the FS is mostly dead:
> [ 3649.106084] BTRFS info (device dm-0): use zlib compression, level 3
> [ 3649.106095] BTRFS info (device dm-0): disk space caching is enabled
> [ 3649.106100] BTRFS info (device dm-0): has skinny extents
> [ 3650.445828] BTRFS info (device dm-0): bdev /dev/mapper/crypt_bcache0 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
> [ 3652.952110] BTRFS error (device dm-0): parent transid verify failed on 7325633544192 wanted 359658 found 359661
> [ 3652.959199] BTRFS error (device dm-0): parent transid verify failed on 7325633544192 wanted 359658 found 359661
> [ 3652.959208] BTRFS error (device dm-0): failed to read block groups: -5
> [ 3653.002227] BTRFS error (device dm-0): open_ctree failed
> [ 3876.808183] BTRFS info (device dm-0): use zlib compression, level 3
> [ 3876.808192] BTRFS info (device dm-0): disk space caching is enabled
> [ 3876.808195] BTRFS info (device dm-0): has skinny extents
> [ 3878.140763] BTRFS info (device dm-0): bdev /dev/mapper/crypt_bcache0 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
> [ 3880.623113] BTRFS error (device dm-0): parent transid verify failed on 7325633544192 wanted 359658 found 359661
> [ 3880.633290] BTRFS error (device dm-0): parent transid verify failed on 7325633544192 wanted 359658 found 359661
> [ 3880.633298] BTRFS error (device dm-0): failed to read block groups: -5
> [ 3880.669435] BTRFS error (device dm-0): open_ctree failed
> [ 4057.606879] BTRFS info (device dm-0): use zlib compression, level 3
> [ 4057.606890] BTRFS info (device dm-0): disk space caching is enabled
> [ 4057.606894] BTRFS info (device dm-0): has skinny extents
> [ 4058.886212] BTRFS info (device dm-0): bdev /dev/mapper/crypt_bcache0 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
> [ 4061.501589] BTRFS error (device dm-0): parent transid verify failed on 7325633544192 wanted 359658 found 359661
> [ 4061.503790] BTRFS error (device dm-0): parent transid verify failed on 7325633544192 wanted 359658 found 359661

The amount of damage here is small, but it looks like you lost a
superblock update or two (btrfs expected an old page and found a new one)
so the root of the filesystem now points at an old tree that has since
been partially overwritten.

Any part of the filesystem on the other side of the missing metadata pages
is no longer accessible without a brute force search of the metadata.
This might take longer than mkfs+restore with the current btrfs check
--repair, especially if you have to run chunk-recover as well.

> myth:/mnt# btrfs-zero-log /dev/mapper/crypt_bcache0
> WARNING: this utility is deprecated, please use 'btrfs rescue zero-log'
> parent transid verify failed on 7325633544192 wanted 359658 found 359661
> parent transid verify failed on 7325633544192 wanted 359658 found 359661
> parent transid verify failed on 7325633544192 wanted 359658 found 359661
> parent transid verify failed on 7325633544192 wanted 359658 found 359661
> Ignoring transid failure
> leaf parent key incorrect 7325633544192
> Clearing log on /dev/mapper/crypt_bcache0, previous log_root 0, level 0

Clearing log tree will have no effect on parent transid verify failure.
It only helps to work around bugs that occur during log tree replay,
which happens at a later stage of mounting the filesystem.

> myth:/mnt# mount -t btrfs -o recovery,nospace_cache,clear_cache /dev/mapper/crypt_bcache0 /mnt/btrfs_bigbackup/
> mount: wrong fs type, bad option, bad superblock on /dev/mapper/crypt_bcache0,
>        missing codepage or helper program, or other error
>        In some cases useful info is found in syslog - try
>        dmesg | tail  or so
> 
> myth:/mnt# dmtail
> [ 6665.975324] BTRFS info (device dm-0): unrecognized mount option 'rootflags=recovery'
> [ 6665.975357] BTRFS error (device dm-0): open_ctree failed
> [ 6686.664202] BTRFS warning (device dm-0): 'recovery' is deprecated, use 'usebackuproot' instead
> [ 6686.664213] BTRFS info (device dm-0): trying to use backup root at mount time
> [ 6686.664219] BTRFS info (device dm-0): disabling disk space caching
> [ 6686.664224] BTRFS info (device dm-0): force clearing of disk cache
> [ 6686.664232] BTRFS info (device dm-0): has skinny extents
> [ 6687.911926] BTRFS info (device dm-0): bdev /dev/mapper/crypt_bcache0 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
> [ 6690.522785] BTRFS error (device dm-0): parent transid verify failed on 7325633544192 wanted 359658 found 359661
> [ 6690.529495] BTRFS error (device dm-0): parent transid verify failed on 7325633544192 wanted 359658 found 359661
> [ 6690.529504] BTRFS error (device dm-0): failed to read block groups: -5
> [ 6690.556227] BTRFS error (device dm-0): open_ctree failed
> 
> 
> myth:/mnt# btrfs restore /dev/mapper/crypt_bcache0 /mnt/btrfs_bigbackup/
> Skipping snapshot win_ro.20200615_02:49:02
> Skipping snapshot 0Notmachines_ro.20200626_16:09:30
> Skipping snapshot 1Appliances_ro.20200626_17:08:56
> Skipping snapshot debian32_ro.20200626_17:11:57
> Skipping snapshot debian64_ro.20200626_17:18:15
> Skipping snapshot ubuntu_ro.20200626_17:18:44
> Skipping snapshot win_ro.20200626_18:39:13
> Skipping snapshot 0Notmachines_ro.20200629_00:48:39
> Skipping snapshot 1Appliances_ro.20200629_01:11:44
> Skipping snapshot debian32_ro.20200629_01:11:50
> Skipping snapshot debian64_ro.20200629_01:19:52
> Skipping snapshot ubuntu_ro.20200629_01:20:01
> Error copying data for /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
> Error searching /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
> Error searching /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
> Error searching /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
> Error searching /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
> Error searching /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
> Error searching /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
> Error searching /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
> Error searching /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
> Error searching /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
> Error searching /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
> Error searching /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
> myth:/mnt# l /mnt/btrfs_bigbackup/
> is missing a lot of stuff
> 
> It's a backup server, I can recreate the data, but it will probably take
> 2 weeks to copy everything again, and I'd like to know what on earth
> happened so that I can avoid having this again.

"parent transid verify failed" is btrfs's gentle way of saying "your
devices have busted write ordering, reconfigure or replace them and
try again."

In a later post in this thread, you posted a log showing your drive model
numbers and firmware revisions.  White Label repackages drives made
by other companies(*) under their own part number (singular, they all
use the same part number), but they leave the firmware revision intact,
so we can look up the firmware revision and see that you have two
different WD models in your md6 array from families with known broken
firmware write caching.

sdd is running firmware 0957, also found in circa-2014 WD Green.
The others are running 01.01RA2 firmware that appears in a model family
that includes some broken WD Green and Red models from a few years back
(including the venerable datavore 80.00A80).  I have a few of the WD
branded versions of these drives.  They are unusable with write cache
enabled.  1 in 10 unclean shutdowns lead to filesystem corruption on
btrfs; on ext4, git and postgresql database corruption.  After disabling
write cache, I've used them for years with no problems.

Hopefully your bcache drive is OK, you didn't post any details on that.
bcache on a drive with buggy firmware write caching fails *spectacularly*.

You can work around buggy write cache firmware with a udev rule like
this to disable write cache on all the drives:

        ACTION=="add|change", SUBSYSTEM=="block", DRIVERS=="sd", KERNEL=="sd*[!0-9]", RUN+="/sbin/hdparm -W 0 $devnode"

Note that in your logs, the kernel reports that 'sdd' has write cache
disabled already, maybe due to lack of firmware support or a conservative
default setting.  That makes it probably the only drive in that array
that is working properly.

bcache could be losing its mind too, but although I've heard a lot
of rumors of bcache bugs, I've yet to catch it having a problem that
wasn't directly caused by bad SSD firmware or host configuration.
If the bcache was configured in writeback mode and it was separated from
the backing device for a while then there could be a consistency issue
that would result in something like this, but bcache is pretty good at
preventing that.

In theory, space_cache=v1 might have consistency issues that lead to some
or all of the symptoms above; however, a) btrfs has checks at multiple
points to detect or prevent that, and b) the inconsistency would have
to be caused by a firmware write cache bug or bcache bug anyway.

There are some other questionable things in your setup:  you have a
mdadm-raid5 with no journal device, so if PPL is also not enabled,
and you are running btrfs on top, then this filesystem is vulnerable
to instant destruction by mdadm-raid5 write hole after a disk fails.
bcache in writeback mode with a single cache pool using multiple physical
backing store devices is vulnerable to extra data corruption failures
in the event that the SSD(s) go bad.  I'm guessing that none of the
backing store drives have scterc support, which will complicate error
recovery with SATA bus timeouts and resets as disks fail (though most
of the problems with that are conveniently also prevented by disabling
write cache).  None of these issues caused problems today, though,
and won't cause a problem until disks start to fail.


(*) their product description text says "other companies", but maybe
White Label is just a part of WD, hiding their shame as they dispose of
unsalable inventory in an unsuspecting market.  Don't know, don't care
enough to find out.

> 
> Thanks,
> Marc
> -- 
> "A mouse is a device used to point at the xterm you want to type in" - A.S.R.
>  
> Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
