Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA68482882
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Jan 2022 21:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiAAU46 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Jan 2022 15:56:58 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:34066 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229961AbiAAU46 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 1 Jan 2022 15:56:58 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 19A9C12F6AE; Sat,  1 Jan 2022 15:56:56 -0500 (EST)
Date:   Sat, 1 Jan 2022 15:56:56 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Eric Levy <contact@ericlevy.name>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: parent transid verify failed
Message-ID: <YdDAGLU7M5mx7rL8@hungrycats.org>
References: <c0c6ec8de80b8e10185fe1980377dcc7af8d3200.camel@ericlevy.name>
 <Yc9Wgsint947Tj59@hungrycats.org>
 <baa90652685a400aa60636f8596e3d28304da1ad.camel@ericlevy.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baa90652685a400aa60636f8596e3d28304da1ad.camel@ericlevy.name>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 31, 2021 at 03:33:01PM -0500, Eric Levy wrote:
> On Fri, 2021-12-31 at 14:14 -0500, Zygo Blaxell wrote:
> 
> > To be clear, do the parent transid verify failed messages appear
> > _before_
> > or _after_ the filesystem switches to read-only?
> > 
> > "After" is fine.  
> 
> "Fine" in the sense that the file system is fully recoverable, or only
> that the files are not damaged, and may be copied to a different file
> system?

"Fine" in the sense that the "parent transid verify failed" error is
not arising from persistent storage, and everything on disk is OK (or
at least not damaged by previously undetected lost writes _specifically_).

More precisely:  we can't distinguish between p-t-v-f errors caused by
temporary in-memory data vs. errors caused by persistent on-disk data
after the filesystem is forced read-only.  If we want to determine whether
there are any persistent errors on disk, we must umount and mount again
to find out.  We can't rely on any errors reported between the switch
to read-only and umounting the filesystem.

In common cases there are no persistent errors on disk, so we can presume
that any p-t-v-f errors after the readonly switch are exclusively in
memory; however, from other things you've posted in this thread, this
specific case may not be a "common" one.

Depending on what the lower layers did, critical writes may have been
dropped, and unrecoverable damage to metadata may have occurred.

> It seems that the RO switch was before the first parent transid error.
> See logs below (excerpt from more complete capture sent previously).

> > Mount with '-o skip_balance'.  If you're in the "after" case then
> > this
> > will avoid running out of metadata space again during mount.
> 
> It seems not to work. So far, I succeeded in mounting only with the
> "ro" option. I can mount with "skip_balance" and "ro" in combination.
> Is that helpful? (I can also mount with "ro" only, or with "ro" and
> "usebackuproot" in combination.)

It means you can read the data from the filesystem, and it's possible
to update or complete your backups.

> $ sudo mount -o skip_balance /dev/sdc1
> mount: /srv/store: wrong fs type, bad option, bad superblock on /dev/sdc1, missing codepage or helper program, or other error.

We'd need to see the log messages from the failing mounts.

> $ sudo mount -o skip_balance,ro /dev/sdc1
> 
> ---
> 
> Dec 29 21:01:09 hostname kernel: sd 4:0:0:1: Warning! Received an indication that the LUN assignments on this target have changed. The Linux SCSI layer does not automatical
> Dec 29 21:01:12 hostname kernel: scsi 4:0:0:2: Direct-Access     SYNOLOGY Storage          4.0  PQ: 0 ANSI: 5
> Dec 29 21:01:12 hostname kernel: sd 4:0:0:2: Attached scsi generic sg5 type 0
> Dec 29 21:01:12 hostname kernel: sd 4:0:0:2: [sdd] 524288000 512-byte logical blocks: (268 GB/250 GiB)
> Dec 29 21:01:12 hostname kernel: sd 4:0:0:2: [sdd] Write Protect is off
> Dec 29 21:01:12 hostname kernel: sd 4:0:0:2: [sdd] Mode Sense: 43 00 10 08
> Dec 29 21:01:12 hostname kernel: sd 4:0:0:2: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA
> Dec 29 21:01:12 hostname kernel: sd 4:0:0:2: [sdd] Optimal transfer size 16384 logical blocks > dev_max (8192 logical blocks)
> Dec 29 21:01:12 hostname kernel: sd 4:0:0:2: [sdd] Attached SCSI disk
> Dec 29 21:05:56 hostname kernel:  sdd:
> Dec 29 21:05:56 hostname kernel:  sdd:
> Dec 29 21:05:56 hostname kernel:  sdd:
> Dec 29 21:06:19 hostname kernel:  sdd: sdd1
> Dec 29 21:06:20 hostname kernel:  sdd: sdd1
> Dec 29 21:06:20 hostname kernel:  sdd: sdd1
> Dec 29 21:06:20 hostname kernel: BTRFS: device fsid e523753b-f3fd-4586-971e-fd7333115ded devid 1 transid 5 /dev/sdd1 scanned by mkfs.btrfs (1191911)
> Dec 29 21:06:23 hostname kernel:  sdd: sdd1
> Dec 29 21:09:21 hostname kernel: BTRFS info (device sdc1): disk added /dev/sdd1
> Dec 29 22:26:47 hostname kernel: BTRFS info (device sdc1): device deleted: /dev/sdd1
> Dec 29 22:28:28 hostname kernel:  sdd: sdd1
> Dec 29 22:28:28 hostname kernel: BTRFS info (device sdc1): disk added /dev/sdd
> Dec 30 03:45:09 hostname kernel:  connection1:0: ping timeout of 5 secs expired, recv timeout 5, last rx 4461894664, last ping 4461895936, now 4461897216
> Dec 30 03:45:09 hostname kernel:  connection1:0: detected conn error (1022)
> Dec 30 03:47:10 hostname kernel:  session1: session recovery timed out after 120 secs
> Dec 30 03:47:10 hostname kernel: sd 4:0:0:1: rejecting I/O to offline device
> Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523542288 op 0x1:(WRITE) flags 0x104000 phys_seg 128 prio class 0
> Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523540240 op 0x1:(WRITE) flags 0x100000 phys_seg 128 prio class 0
> Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523538192 op 0x1:(WRITE) flags 0x100000 phys_seg 128 prio class 0
> Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523537168 op 0x1:(WRITE) flags 0x104000 phys_seg 128 prio class 0
> Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
> Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523541264 op 0x1:(WRITE) flags 0x104000 phys_seg 128 prio class 0
> Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523539216 op 0x1:(WRITE) flags 0x104000 phys_seg 128 prio class 0
> Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
> Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523543312 op 0x1:(WRITE) flags 0x100000 phys_seg 1 prio class 0
> Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 3, rd 0, flush 0, corrupt 0, gen 0
> Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523635088 op 0x1:(WRITE) flags 0x800 phys_seg 64 prio class 0
> Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 4, rd 0, flush 0, corrupt 0, gen 0
> Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523543320 op 0x1:(WRITE) flags 0x100000 phys_seg 81 prio class 0
> Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 5, rd 0, flush 0, corrupt 0, gen 0
> Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523543968 op 0x1:(WRITE) flags 0x104000 phys_seg 128 prio class 0
> Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 6, rd 0, flush 0, corrupt 0, gen 0
> Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 7, rd 0, flush 0, corrupt 0, gen 0
> Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 8, rd 0, flush 0, corrupt 0, gen 0
> Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 9, rd 0, flush 0, corrupt 0, gen 0
> Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 10, rd 0, flush 0, corrupt 0, gen 0
> Dec 30 03:47:10 hostname kernel: BTRFS warning (device sdc1): error -5 while searching for dev_stats item for device /dev/sdc1
> Dec 30 03:47:10 hostname kernel: BTRFS warning (device sdc1): Skipping commit of aborted transaction.
> Dec 30 03:47:10 hostname kernel: BTRFS: error (device sdc1) in cleanup_transaction:1975: errno=-5 IO failure
> Dec 30 03:47:10 hostname kernel: BTRFS info (device sdc1): forced readonly
> Dec 30 05:11:10 hostname kernel: BTRFS warning (device sdc1): sdc1 checksum verify failed on 867254272 wanted 0x62c8b548 found 0x982a1375 level 0
> Dec 30 05:11:10 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867254272 wanted 9212 found 8675
> Dec 30 05:11:10 hostname kernel: BTRFS warning (device sdc1): csum hole found for disk bytenr range [271567056896, 271567060992)
> Dec 30 05:11:10 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867254272 wanted 9212 found 8675
> Dec 30 05:11:10 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867254272 wanted 9212 found 8675
> 
