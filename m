Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D432164F2
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 05:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGGDzb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 23:55:31 -0400
Received: from magic.merlins.org ([209.81.13.136]:57312 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgGGDzb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jul 2020 23:55:31 -0400
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:36256 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92 #3)
        id 1jsehe-0007Ja-Fw by authid <merlins.org> with srv_auth_plain; Mon, 06 Jul 2020 20:55:30 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1jsehe-0007uc-5l; Mon, 06 Jul 2020 20:55:30 -0700
Date:   Mon, 6 Jul 2020 20:55:30 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: 5.6 pretty massive unexplained btrfs corruption:  parent transid
 verify failed + open_ctree failed
Message-ID: <20200707035530.GP30660@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'd love to know what went wrong so that it doesn't happen again, but let me know if you'd like data off this 
before I wipe it (which I assume is the only way out at this point)
myth:~# btrfs check --mode=lowmem /dev/mapper/crypt_bcache0
Opening filesystem to check...
parent transid verify failed on 7325633544192 wanted 359658 found 359661
parent transid verify failed on 7325633544192 wanted 359658 found 359661
parent transid verify failed on 7325633544192 wanted 359658 found 359661
Ignoring transid failure
leaf parent key incorrect 7325633544192
ERROR: failed to read block groups: Operation not permitted
ERROR: cannot open file system


I did run bees on that filesystem, but I also just did a full btrfs check on it, and it came back clean:

Opening filesystem to check...
Checking filesystem on /dev/mapper/crypt_bcache4
UUID: 36f5079e-ca6c-4855-8639-ccb82695c18d
[1/7] checking root items
Fixed 0 roots.
[2/7] checking extents
No device size related problem found
[3/7] checking free space cache
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 18089211043840 bytes used, no error found
total csum bytes: 17580412652
total tree bytes: 82326192128
total fs tree bytes: 56795086848
total extent tree bytes: 5154258944
btree space waste bytes: 13682108904
file data blocks allocated: 24050542804992


I then moved it to the target machine, started a btrfs send to it, and it failed quickly (due to a mistake
I had an old btrfs binary on that server, but I'm hoping most of the work is done in kernel space and that the user space
btrfs should not corrupt the disk if it's a bit old)

myth:/mnt# uname -r
5.6.5-amd64-preempt-sysrq-20190817

Soon after, the copy failed:
[ 2575.931316] BTRFS info (device dm-0): use zlib compression, level 3
[ 2575.931329] BTRFS info (device dm-0): disk space caching is enabled
[ 2575.931343] BTRFS info (device dm-0): has skinny extents
[ 2577.286749] BTRFS info (device dm-0): bdev /dev/mapper/crypt_bcache0 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
[ 2607.943516] BTRFS info (device dm-0): enabling ssd optimizations
[ 2708.835200] BTRFS warning (device dm-0): block group 13002170433536 has wrong amount of free space
[ 2708.835209] BTRFS warning (device dm-0): failed to load free space cache for block group 13002170433536, rebuilding it now
[ 2740.589580] BTRFS warning (device dm-0): block group 17151175950336 has wrong amount of free space
[ 2740.589593] BTRFS warning (device dm-0): failed to load free space cache for block group 17151175950336, rebuilding it now
[ 2797.204169] perf: interrupt took too long (3146 > 3138), lowering kernel.perf_event_max_sample_rate to 63500
[ 2882.545242] BTRFS info (device dm-0): the free space cache file (26234763345920) is invalid, skip it
[ 3071.631905] BTRFS error (device dm-0): parent transid verify failed on 6353897537536 wanted 359658 found 359661
[ 3071.643430] BTRFS error (device dm-0): parent transid verify failed on 6353897537536 wanted 359658 found 359661
[ 3071.661985] BTRFS error (device dm-0): parent transid verify failed on 6353897537536 wanted 359658 found 359661
[ 3071.661995] BTRFS: error (device dm-0) in btrfs_run_delayed_refs:2210: errno=-5 IO failure
[ 3071.661999] BTRFS info (device dm-0): forced readonly
[ 3071.662567] BTRFS error (device dm-0): parent transid verify failed on 6353897537536 wanted 359658 found 359661
[ 3071.663076] BTRFS error (device dm-0): parent transid verify failed on 6353897537536 wanted 359658 found 359661
[ 3071.663083] BTRFS: error (device dm-0) in btrfs_run_delayed_refs:2210: errno=-5 IO failure

Ok, maybe there was an IO failure, although none was shown by the kernel:

however, now the FS is mostly dead:
[ 3649.106084] BTRFS info (device dm-0): use zlib compression, level 3
[ 3649.106095] BTRFS info (device dm-0): disk space caching is enabled
[ 3649.106100] BTRFS info (device dm-0): has skinny extents
[ 3650.445828] BTRFS info (device dm-0): bdev /dev/mapper/crypt_bcache0 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
[ 3652.952110] BTRFS error (device dm-0): parent transid verify failed on 7325633544192 wanted 359658 found 359661
[ 3652.959199] BTRFS error (device dm-0): parent transid verify failed on 7325633544192 wanted 359658 found 359661
[ 3652.959208] BTRFS error (device dm-0): failed to read block groups: -5
[ 3653.002227] BTRFS error (device dm-0): open_ctree failed
[ 3876.808183] BTRFS info (device dm-0): use zlib compression, level 3
[ 3876.808192] BTRFS info (device dm-0): disk space caching is enabled
[ 3876.808195] BTRFS info (device dm-0): has skinny extents
[ 3878.140763] BTRFS info (device dm-0): bdev /dev/mapper/crypt_bcache0 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
[ 3880.623113] BTRFS error (device dm-0): parent transid verify failed on 7325633544192 wanted 359658 found 359661
[ 3880.633290] BTRFS error (device dm-0): parent transid verify failed on 7325633544192 wanted 359658 found 359661
[ 3880.633298] BTRFS error (device dm-0): failed to read block groups: -5
[ 3880.669435] BTRFS error (device dm-0): open_ctree failed
[ 4057.606879] BTRFS info (device dm-0): use zlib compression, level 3
[ 4057.606890] BTRFS info (device dm-0): disk space caching is enabled
[ 4057.606894] BTRFS info (device dm-0): has skinny extents
[ 4058.886212] BTRFS info (device dm-0): bdev /dev/mapper/crypt_bcache0 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
[ 4061.501589] BTRFS error (device dm-0): parent transid verify failed on 7325633544192 wanted 359658 found 359661
[ 4061.503790] BTRFS error (device dm-0): parent transid verify failed on 7325633544192 wanted 359658 found 359661
[ 4061.503799] BTRFS error (device dm-0): failed to read block g


myth:/mnt# btrfs-zero-log /dev/mapper/crypt_bcache0
WARNING: this utility is deprecated, please use 'btrfs rescue zero-log'
parent transid verify failed on 7325633544192 wanted 359658 found 359661
parent transid verify failed on 7325633544192 wanted 359658 found 359661
parent transid verify failed on 7325633544192 wanted 359658 found 359661
parent transid verify failed on 7325633544192 wanted 359658 found 359661
Ignoring transid failure
leaf parent key incorrect 7325633544192
Clearing log on /dev/mapper/crypt_bcache0, previous log_root 0, level 0


myth:/mnt# mount -t btrfs -o recovery,nospace_cache,clear_cache /dev/mapper/crypt_bcache0 /mnt/btrfs_bigbackup/
mount: wrong fs type, bad option, bad superblock on /dev/mapper/crypt_bcache0,
       missing codepage or helper program, or other error
       In some cases useful info is found in syslog - try
       dmesg | tail  or so

myth:/mnt# dmtail
[ 6665.975324] BTRFS info (device dm-0): unrecognized mount option 'rootflags=recovery'
[ 6665.975357] BTRFS error (device dm-0): open_ctree failed
[ 6686.664202] BTRFS warning (device dm-0): 'recovery' is deprecated, use 'usebackuproot' instead
[ 6686.664213] BTRFS info (device dm-0): trying to use backup root at mount time
[ 6686.664219] BTRFS info (device dm-0): disabling disk space caching
[ 6686.664224] BTRFS info (device dm-0): force clearing of disk cache
[ 6686.664232] BTRFS info (device dm-0): has skinny extents
[ 6687.911926] BTRFS info (device dm-0): bdev /dev/mapper/crypt_bcache0 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
[ 6690.522785] BTRFS error (device dm-0): parent transid verify failed on 7325633544192 wanted 359658 found 359661
[ 6690.529495] BTRFS error (device dm-0): parent transid verify failed on 7325633544192 wanted 359658 found 359661
[ 6690.529504] BTRFS error (device dm-0): failed to read block groups: -5
[ 6690.556227] BTRFS error (device dm-0): open_ctree failed


myth:/mnt# btrfs restore /dev/mapper/crypt_bcache0 /mnt/btrfs_bigbackup/
Skipping snapshot win_ro.20200615_02:49:02
Skipping snapshot 0Notmachines_ro.20200626_16:09:30
Skipping snapshot 1Appliances_ro.20200626_17:08:56
Skipping snapshot debian32_ro.20200626_17:11:57
Skipping snapshot debian64_ro.20200626_17:18:15
Skipping snapshot ubuntu_ro.20200626_17:18:44
Skipping snapshot win_ro.20200626_18:39:13
Skipping snapshot 0Notmachines_ro.20200629_00:48:39
Skipping snapshot 1Appliances_ro.20200629_01:11:44
Skipping snapshot debian32_ro.20200629_01:11:50
Skipping snapshot debian64_ro.20200629_01:19:52
Skipping snapshot ubuntu_ro.20200629_01:20:01
Error copying data for /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
Error searching /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
Error searching /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
Error searching /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
Error searching /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
Error searching /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
Error searching /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
Error searching /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
Error searching /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
Error searching /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
Error searching /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
Error searching /mnt/btrfs_bigbackup/DS2/backup-btrfssend/gargamel/root_last_ro/lib/modules/5.1.19-amd64-preempt-sysrq-20180818/kernel/drivers/video/fbdev/arkfb.ko
myth:/mnt# l /mnt/btrfs_bigbackup/
is missing a lot of stuff

It's a backup server, I can recreate the data, but it will probably take
2 weeks to copy everything again, and I'd like to know what on earth
happened so that I can avoid having this again.

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
