Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86DE4825C1
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Dec 2021 21:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhLaUdE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Dec 2021 15:33:04 -0500
Received: from zmcc-3-mx.zmailcloud.com ([34.200.143.36]:39984 "EHLO
        zmcc-3-mx.zmailcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbhLaUdD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Dec 2021 15:33:03 -0500
Received: from zmcc-3.zmailcloud.com (zmcc-3-mta-1.zmailcloud.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 9991B405B4
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Dec 2021 14:33:47 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id 0FD2A803440E
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Dec 2021 14:33:03 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id 017308034415
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Dec 2021 14:33:03 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3cOGmoCNwPBw for <linux-btrfs@vger.kernel.org>;
        Fri, 31 Dec 2021 14:33:02 -0600 (CST)
Received: from epl-dy1-mint (unknown [154.21.21.52])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id AC89A803440E
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Dec 2021 14:33:02 -0600 (CST)
Message-ID: <baa90652685a400aa60636f8596e3d28304da1ad.camel@ericlevy.name>
Subject: Re: parent transid verify failed
From:   Eric Levy <contact@ericlevy.name>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date:   Fri, 31 Dec 2021 15:33:01 -0500
In-Reply-To: <Yc9Wgsint947Tj59@hungrycats.org>
References: <c0c6ec8de80b8e10185fe1980377dcc7af8d3200.camel@ericlevy.name>
         <Yc9Wgsint947Tj59@hungrycats.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 2021-12-31 at 14:14 -0500, Zygo Blaxell wrote:

> To be clear, do the parent transid verify failed messages appear
> _before_
> or _after_ the filesystem switches to read-only?
> 
> "After" is fine.  

"Fine" in the sense that the file system is fully recoverable, or only
that the files are not damaged, and may be copied to a different file
system?

It seems that the RO switch was before the first parent transid error.
See logs below (excerpt from more complete capture sent previously).

I am also recalling that I originally created a partition on the new
volume, which I added, but then removed, in favor of adding the entire
unpartitioned device. Is it possible the second add operation clobbered
part of the file system, even though I submitted a remove operation in
between the two add operations?

$ sudo btrfs device add /dev/sdd1 ./ -f
$ sudo btrfs device remove /dev/sdd1 ./
$ sudo btrfs device add /dev/sdd ./ -f

> Mount with '-o skip_balance'.  If you're in the "after" case then
> this
> will avoid running out of metadata space again during mount.

It seems not to work. So far, I succeeded in mounting only with the
"ro" option. I can mount with "skip_balance" and "ro" in combination.
Is that helpful? (I can also mount with "ro" only, or with "ro" and
"usebackuproot" in combination.)

$ sudo mount -o skip_balance /dev/sdc1
mount: /srv/store: wrong fs type, bad option, bad superblock on /dev/sdc1, missing codepage or helper program, or other error.

$ sudo mount -o skip_balance,ro /dev/sdc1

---

Dec 29 21:01:09 hostname kernel: sd 4:0:0:1: Warning! Received an indication that the LUN assignments on this target have changed. The Linux SCSI layer does not automatical
Dec 29 21:01:12 hostname kernel: scsi 4:0:0:2: Direct-Access     SYNOLOGY Storage          4.0  PQ: 0 ANSI: 5
Dec 29 21:01:12 hostname kernel: sd 4:0:0:2: Attached scsi generic sg5 type 0
Dec 29 21:01:12 hostname kernel: sd 4:0:0:2: [sdd] 524288000 512-byte logical blocks: (268 GB/250 GiB)
Dec 29 21:01:12 hostname kernel: sd 4:0:0:2: [sdd] Write Protect is off
Dec 29 21:01:12 hostname kernel: sd 4:0:0:2: [sdd] Mode Sense: 43 00 10 08
Dec 29 21:01:12 hostname kernel: sd 4:0:0:2: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA
Dec 29 21:01:12 hostname kernel: sd 4:0:0:2: [sdd] Optimal transfer size 16384 logical blocks > dev_max (8192 logical blocks)
Dec 29 21:01:12 hostname kernel: sd 4:0:0:2: [sdd] Attached SCSI disk
Dec 29 21:05:56 hostname kernel:  sdd:
Dec 29 21:05:56 hostname kernel:  sdd:
Dec 29 21:05:56 hostname kernel:  sdd:
Dec 29 21:06:19 hostname kernel:  sdd: sdd1
Dec 29 21:06:20 hostname kernel:  sdd: sdd1
Dec 29 21:06:20 hostname kernel:  sdd: sdd1
Dec 29 21:06:20 hostname kernel: BTRFS: device fsid e523753b-f3fd-4586-971e-fd7333115ded devid 1 transid 5 /dev/sdd1 scanned by mkfs.btrfs (1191911)
Dec 29 21:06:23 hostname kernel:  sdd: sdd1
Dec 29 21:09:21 hostname kernel: BTRFS info (device sdc1): disk added /dev/sdd1
Dec 29 22:26:47 hostname kernel: BTRFS info (device sdc1): device deleted: /dev/sdd1
Dec 29 22:28:28 hostname kernel:  sdd: sdd1
Dec 29 22:28:28 hostname kernel: BTRFS info (device sdc1): disk added /dev/sdd
Dec 30 03:45:09 hostname kernel:  connection1:0: ping timeout of 5 secs expired, recv timeout 5, last rx 4461894664, last ping 4461895936, now 4461897216
Dec 30 03:45:09 hostname kernel:  connection1:0: detected conn error (1022)
Dec 30 03:47:10 hostname kernel:  session1: session recovery timed out after 120 secs
Dec 30 03:47:10 hostname kernel: sd 4:0:0:1: rejecting I/O to offline device
Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523542288 op 0x1:(WRITE) flags 0x104000 phys_seg 128 prio class 0
Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523540240 op 0x1:(WRITE) flags 0x100000 phys_seg 128 prio class 0
Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523538192 op 0x1:(WRITE) flags 0x100000 phys_seg 128 prio class 0
Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523537168 op 0x1:(WRITE) flags 0x104000 phys_seg 128 prio class 0
Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523541264 op 0x1:(WRITE) flags 0x104000 phys_seg 128 prio class 0
Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523539216 op 0x1:(WRITE) flags 0x104000 phys_seg 128 prio class 0
Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523543312 op 0x1:(WRITE) flags 0x100000 phys_seg 1 prio class 0
Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 3, rd 0, flush 0, corrupt 0, gen 0
Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523635088 op 0x1:(WRITE) flags 0x800 phys_seg 64 prio class 0
Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 4, rd 0, flush 0, corrupt 0, gen 0
Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523543320 op 0x1:(WRITE) flags 0x100000 phys_seg 81 prio class 0
Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 5, rd 0, flush 0, corrupt 0, gen 0
Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523543968 op 0x1:(WRITE) flags 0x104000 phys_seg 128 prio class 0
Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 6, rd 0, flush 0, corrupt 0, gen 0
Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 7, rd 0, flush 0, corrupt 0, gen 0
Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 8, rd 0, flush 0, corrupt 0, gen 0
Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 9, rd 0, flush 0, corrupt 0, gen 0
Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 10, rd 0, flush 0, corrupt 0, gen 0
Dec 30 03:47:10 hostname kernel: BTRFS warning (device sdc1): error -5 while searching for dev_stats item for device /dev/sdc1
Dec 30 03:47:10 hostname kernel: BTRFS warning (device sdc1): Skipping commit of aborted transaction.
Dec 30 03:47:10 hostname kernel: BTRFS: error (device sdc1) in cleanup_transaction:1975: errno=-5 IO failure
Dec 30 03:47:10 hostname kernel: BTRFS info (device sdc1): forced readonly
Dec 30 05:11:10 hostname kernel: BTRFS warning (device sdc1): sdc1 checksum verify failed on 867254272 wanted 0x62c8b548 found 0x982a1375 level 0
Dec 30 05:11:10 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867254272 wanted 9212 found 8675
Dec 30 05:11:10 hostname kernel: BTRFS warning (device sdc1): csum hole found for disk bytenr range [271567056896, 271567060992)
Dec 30 05:11:10 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867254272 wanted 9212 found 8675
Dec 30 05:11:10 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867254272 wanted 9212 found 8675

