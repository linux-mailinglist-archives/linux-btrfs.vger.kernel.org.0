Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56EDD170BA5
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2020 23:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBZWhJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Feb 2020 17:37:09 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37131 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgBZWhI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Feb 2020 17:37:08 -0500
Received: by mail-yw1-f67.google.com with SMTP id l5so1140160ywd.4
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2020 14:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iT/nFvdz92U3R7dyd/c1GIExNzFzvBtq2DA3RycI1J8=;
        b=ozZTZKs/aKQXSfykfOJ0W7Tvf+yVtVH86iLkYmbWOf1UyjuFFcThYB1FAEzkkvkdmG
         42hczJILugPTP9a4G85BgaJmUE8iskBugqu/H4dyDhsbLv5u2McEVCFq+aopfNcL3c6u
         +6rdHWj8FVEfXqRHVV1YI33zLzNjaKDdvEXgkBi/75m9OcKEv1CJ3XBkG9ISpjEIKArq
         vhaDu97QM/8EBantYTzPKPoIWNnTsFCqgSBdbhJQvnZ7VnjIHKz5BBedbpCQZeZQL8ah
         oMsXnwvZ0tLQWBFaZQjJcwHkz3pAPMoQI09jx3X7VGuCfudm/eKlkDTvViOwjUBhkdcf
         UH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iT/nFvdz92U3R7dyd/c1GIExNzFzvBtq2DA3RycI1J8=;
        b=Kqhr4GgXuOnYEGUxYonMOTpGxee+jB3IDeDbePklJDlrfum44vNkMjoyyINn3ms5cK
         hn4WvjL3C7ICN2QVzaEZVvnvPrNzYU2BBFfy+wHEyu9iMHnLDpI/+zaf7c4N8iFU1tac
         B/rPBzsz6iOfbJs190pextbz/WFbVkjaPquXyaiAgQlFEHaoVW1o7PcusFZC1mRf8ySC
         GUGp5/4IOXzYd12LRSyRSkokinSXgEpqu4krwB/JZouSPk7ovbv3ztJUPABS9OkTQEkr
         3xKf11hDkZ3tXwbnNis9i508AHSZKKYyNMq0kZbk1DR9O5c0W5d8gpZaRoF8gUvK0JXM
         wRCA==
X-Gm-Message-State: APjAAAUV4ZiT5FFfRsX8oHaSZGC/iwkqEvyIXZieCMkC7HXxrc/Z9XTe
        cqtlkhV8HlIfqyABWftMxCdRGNcnRjqJJwOdb9NPD/Dh
X-Google-Smtp-Source: APXvYqyTw4XZpuLLVFwCtSvN12y+xHkNwsFsg+M+APO+zrbV66i5Jf3VfzqAu2925WRYtvJz4non1C5MCGqmQikQSxA=
X-Received: by 2002:a0d:c243:: with SMTP id e64mr1553352ywd.12.1582756625264;
 Wed, 26 Feb 2020 14:37:05 -0800 (PST)
MIME-Version: 1.0
References: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
 <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com> <CAAW2-Zfz8goOBCLovDpA7EtBwOsqKOAP5Ta_iS6KfDFDDmn47g@mail.gmail.com>
 <60fba046-0aef-3b25-1e7d-7e39f4884ffe@gmx.com> <CAAW2-ZdczvEfgKb++T9YGSOMxJB+jz3_mwqEt2+-g0Omr7tocQ@mail.gmail.com>
In-Reply-To: <CAAW2-ZdczvEfgKb++T9YGSOMxJB+jz3_mwqEt2+-g0Omr7tocQ@mail.gmail.com>
From:   Steven Fosdick <stevenfosdick@gmail.com>
Date:   Wed, 26 Feb 2020 22:36:54 +0000
Message-ID: <CAG_8rEfjNPwT4g2DwbS9atsurLvYazt7aV4o77HGv-fssNmheQ@mail.gmail.com>
Subject: Re: USB reset + raid6 = majority of files unreadable
To:     Jonathan H <pythonnut@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ok, so to expand on my previous message, I have what was a 3-drive
filesystem with RAID1 metadata and RAID5 data.  One drive failed so I
mounted degraded, added a replacement and tried to remove the missing
(failed) drive.  It won't remove - the remove aborts with an I/O error
after checksum errors have been logged as reported in my last e-mail.

I have run a btrfs check on the filesystem and this gives the following output:

WARNING: filesystem mounted, continuing because of --force
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
Opening filesystem to check...
Checking filesystem on /dev/sda
UUID: a3d38933-ee90-4b84-8f24-3a5c36dfd9be
found 9834224820224 bytes used, no error found
total csum bytes: 9588337304
total tree bytes: 13656375296
total fs tree bytes: 2760966144
total extent tree bytes: 388759552
btree space waste bytes: 1321640764
file data blocks allocated: 9820591190016
 referenced 9820501786624

The filesystem was mounted r/o to avoid any changes upsetting the
check.  I have now started a scrub to see what that finds but the ETA
is Sat Feb 29 07:57:49 2020 so I will report what that finds at the
time.

Regarding kernel messages I have found a few of these in the log
starting before the disc failure:

Sep 27 15:16:08 meije kernel: INFO: task kworker/u128:1:18864 blocked
for more than 122 seconds.
Sep 27 15:16:08 meije kernel:       Not tainted 5.1.10-arch1-1-ARCH #1
Sep 27 15:16:08 meije kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Sep 27 15:16:08 meije kernel: kworker/u128:1  D    0 18864      2 0x80000080
Sep 27 15:16:08 meije kernel: Workqueue: events_unbound
btrfs_async_reclaim_metadata_space [btrfs]
Sep 27 15:16:08 meije kernel: Call Trace:
Sep 27 15:16:08 meije kernel:  ? __schedule+0x26c/0x8c0
Sep 27 15:16:08 meije kernel:  ? preempt_count_add+0x79/0xb0
Sep 27 15:16:08 meije kernel:  schedule+0x3c/0x80
Sep 27 15:16:08 meije kernel:  wait_for_commit+0x53/0x80 [btrfs]
Sep 27 15:16:08 meije kernel:  ? wait_woken+0x70/0x70
Sep 27 15:16:08 meije kernel:  btrfs_commit_transaction+0x145/0x930 [btrfs]
Sep 27 15:16:08 meije kernel:  ? _raw_spin_lock_irqsave+0x26/0x50
Sep 27 15:16:08 meije kernel:  ? _raw_spin_unlock_irqrestore+0x20/0x40
Sep 27 15:16:08 meije kernel:  ? __percpu_counter_sum+0x52/0x60
Sep 27 15:16:08 meije kernel:  flush_space+0x163/0x6a0 [btrfs]
Sep 27 15:16:08 meije kernel:  ? __switch_to_asm+0x41/0x70
Sep 27 15:16:08 meije kernel:  ? __switch_to_asm+0x35/0x70
Sep 27 15:16:08 meije kernel:  ? __switch_to_asm+0x41/0x70
Sep 27 15:16:08 meije kernel:
btrfs_async_reclaim_metadata_space+0xc4/0x4a0 [btrfs]
Sep 27 15:16:08 meije kernel:  ? __schedule+0x274/0x8c0
Sep 27 15:16:08 meije kernel:  process_one_work+0x1d1/0x3e0
Sep 27 15:16:08 meije kernel:  worker_thread+0x4a/0x3d0
Sep 27 15:16:08 meije kernel:  kthread+0xfb/0x130
Sep 27 15:16:08 meije kernel:  ? process_one_work+0x3e0/0x3e0
Sep 27 15:16:08 meije kernel:  ? kthread_park+0x90/0x90
Sep 27 15:16:08 meije kernel:  ret_from_fork+0x35/0x40

but I think these may have nothing to do with it - they may be another
filesystem (root) and the timeout may be because that is a USB stick
which is rather slow.  My reason for thinking that is that the process
that gave rise to the timeout appears to be pacman, the Arch package
manager which primarily writes to the root fileystem.

It looks like the disc started to fail here:

Jan 30 13:41:04 meije kernel: scsi_io_completion_action: 806 callbacks
suppressed
Jan 30 13:41:04 meije kernel: sd 3:0:0:0: [sde] tag#18 FAILED Result:
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
Jan 30 13:41:04 meije kernel: sd 3:0:0:0: [sde] tag#18 CDB: Read(16)
88 00 00 00 00 00 a2 d3 3b 00 00 00 00 40 00 00
Jan 30 13:41:04 meije kernel: print_req_error: 806 callbacks suppressed
Jan 30 13:41:04 meije kernel: blk_update_request: I/O error, dev sde,
sector 2731752192 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
Jan 30 13:41:04 meije kernel: sd 3:0:0:0: [sde] tag#15 FAILED Result:
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
Jan 30 13:41:04 meije kernel: sd 3:0:0:0: [sde] tag#15 CDB: Write(16)
8a 00 00 00 00 00 a2 d3 3b 00 00 00 00 08 00 00
Jan 30 13:41:04 meije kernel: blk_update_request: I/O error, dev sde,
sector 2731752192 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
Jan 30 13:41:04 meije kernel: btrfs_dev_stat_print_on_error: 732
callbacks suppressed
Jan 30 13:41:04 meije kernel: BTRFS error (device sda): bdev /dev/sde
errs: wr 743, rd 0, flush 0, corrupt 0, gen 0
Jan 30 13:41:04 meije kernel: sd 3:0:0:0: [sde] tag#19 FAILED Result:
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
Jan 30 13:41:04 meije kernel: sd 3:0:0:0: [sde] tag#19 CDB: Write(16)
8a 00 00 00 00 00 a2 d3 3b 08 00 00 00 08 00 00
Jan 30 13:41:04 meije kernel: blk_update_request: I/O error, dev sde,
sector 2731752200 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
Jan 30 13:41:04 meije kernel: sd 3:0:0:0: [sde] tag#21 FAILED Result:
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
Jan 30 13:41:04 meije kernel: sd 3:0:0:0: [sde] tag#21 CDB: Write(16)
8a 00 00 00 00 00 a2 d3 3b 18 00 00 00 08 00 00
Jan 30 13:41:04 meije kernel: blk_update_request: I/O error, dev sde,
sector 2731752216 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
Jan 30 13:41:04 meije kernel: sd 3:0:0:0: [sde] tag#20 FAILED Result:
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
Jan 30 13:41:04 meije kernel: sd 3:0:0:0: [sde] tag#20 CDB: Write(16)
8a 00 00 00 00 00 a2 d3 3b 10 00 00 00 08 00 00
Jan 30 13:41:04 meije kernel: blk_update_request: I/O error, dev sde,
sector 2731752208 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
Jan 30 13:41:04 meije kernel: BTRFS error (device sda): bdev /dev/sde
errs: wr 744, rd 0, flush 0, corrupt 0, gen 0
Jan 30 13:41:04 meije kernel: BTRFS error (device sda): bdev /dev/sde
errs: wr 745, rd 0, flush 0, corrupt 0, gen 0
Jan 30 13:41:04 meije kernel: sd 3:0:0:0: [sde] tag#22 FAILED Result:
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
Jan 30 13:41:04 meije kernel: sd 3:0:0:0: [sde] tag#22 CDB: Write(16)
8a 00 00 00 00 00 a2 d3 3b 20 00 00 00 08 00 00
Jan 30 13:41:04 meije kernel: blk_update_request: I/O error, dev sde,
sector 2731752224 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
Jan 30 13:41:04 meije kernel: BTRFS error (device sda): bdev /dev/sde
errs: wr 746, rd 0, flush 0, corrupt 0, gen 0
Jan 30 13:41:04 meije kernel: sd 3:0:0:0: [sde] tag#23 FAILED Result:
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
Jan 30 13:41:04 meije kernel: sd 3:0:0:0: [sde] tag#23 CDB: Write(16)
8a 00 00 00 00 00 a2 d3 3b 28 00 00 00 08 00 00
Jan 30 13:41:04 meije kernel: blk_update_request: I/O error, dev sde,
sector 2731752232 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
Jan 30 13:41:04 meije kernel: BTRFS error (device sda): bdev /dev/sde
errs: wr 747, rd 0, flush 0, corrupt 0, gen 0
Jan 30 13:41:04 meije kernel: BTRFS error (device sda): bdev /dev/sde
errs: wr 748, rd 0, flush 0, corrupt 0, gen 0
Jan 30 13:41:04 meije kernel: sd 3:0:0:0: [sde] tag#21 FAILED Result:
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
Jan 30 13:41:04 meije kernel: sd 3:0:0:0: [sde] tag#21 CDB: Write(16)
8a 00 00 00 00 00 a2 d3 3b 30 00 00 00 08 00 00
Jan 30 13:41:04 meije kernel: blk_update_request: I/O error, dev sde,
sector 2731752240 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
Jan 30 13:41:04 meije kernel: sd 3:0:0:0: [sde] tag#22 FAILED Result:
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
Jan 30 13:41:04 meije kernel: sd 3:0:0:0: [sde] tag#22 CDB: Write(16)
8a 00 00 00 00 00 a2 d3 3b 38 00 00 00 08 00 00
Jan 30 13:41:04 meije kernel: blk_update_request: I/O error, dev sde,
sector 2731752248 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
Jan 30 13:41:04 meije kernel: BTRFS error (device sda): bdev /dev/sde
errs: wr 749, rd 0, flush 0, corrupt 0, gen 0
Jan 30 13:41:04 meije kernel: BTRFS error (device sda): bdev /dev/sde
errs: wr 750, rd 0, flush 0, corrupt 0, gen 0
Jan 30 13:42:37 meije rwhod[451]: sending on interface eno1
...

This goes on for pages and quite a few days, I can extract more if it
is of interest.  Next is a reboot:

Feb 10 16:19:50 meije kernel: sd 3:0:0:0: [sde] tag#0 CDB: Write(16)
8a 00 00 00 00 02 18 c2 76 00 00 00 00 80 00 00
Feb 10 16:19:50 meije kernel: blk_update_request: I/O error, dev sde,
sector 9005331968 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
Feb 10 16:19:50 meije kernel: BTRFS error (device sda): bdev /dev/sde
errs: wr 2857068, rd 20518, flush 0, corrupt 0, gen 0
Feb 10 16:19:50 meije kernel: BTRFS error (device sda): bdev /dev/sde
errs: wr 2857069, rd 20518, flush 0, corrupt 0, gen 0
Feb 10 16:19:50 meije kernel: BTRFS error (device sda): bdev /dev/sde
errs: wr 2857070, rd 20518, flush 0, corrupt 0, gen 0
Feb 10 16:19:50 meije kernel: BTRFS error (device sda): bdev /dev/sde
errs: wr 2857071, rd 20518, flush 0, corrupt 0, gen 0
Feb 10 16:19:50 meije kernel: BTRFS error (device sda): bdev /dev/sde
errs: wr 2857072, rd 20518, flush 0, corrupt 0, gen 0
Feb 10 16:19:50 meije kernel: BTRFS error (device sda): bdev /dev/sde
errs: wr 2857073, rd 20518, flush 0, corrupt 0, gen 0
Feb 10 16:19:50 meije kernel: BTRFS error (device sda): bdev /dev/sde
errs: wr 2857074, rd 20518, flush 0, corrupt 0, gen 0
Feb 10 16:19:50 meije kernel: BTRFS error (device sda): bdev /dev/sde
errs: wr 2857075, rd 20518, flush 0, corrupt 0, gen 0
Feb 10 16:19:50 meije kernel: BTRFS error (device sda): bdev /dev/sde
errs: wr 2857076, rd 20518, flush 0, corrupt 0, gen 0
Feb 10 16:19:50 meije kernel: BTRFS error (device sda): bdev /dev/sde
errs: wr 2857077, rd 20518, flush 0, corrupt 0, gen 0
Feb 10 16:19:50 meije kernel: BTRFS warning (device sda): lost page
write due to IO error on /dev/sde
Feb 10 16:19:50 meije kernel: BTRFS warning (device sda): lost page
write due to IO error on /dev/sde
Feb 10 16:19:50 meije kernel: BTRFS warning (device sda): lost page
write due to IO error on /dev/sde
Feb 10 16:19:50 meije kernel: BTRFS error (device sda): error writing
primary super block to device 3
Feb 10 16:19:50 meije systemd[1]: data.mount: Succeeded.
Feb 10 16:19:50 meije systemd[1]: Unmounted /data.
Feb 10 16:19:50 meije systemd[1]: Stopped target Local File Systems (Pre).

then on the way back up:

Feb 10 16:52:44 meije kernel: Btrfs loaded, crc32c=crc32c-intel
Feb 10 16:52:44 meije kernel: BTRFS: device fsid
f8ffa6cb-ab56-466a-99f1-438e705609c6 devid 1 transid 2007 /dev/sdb
scanned by systemd-udevd (199)
Feb 10 16:52:44 meije kernel: usb 3-1: New USB device found,
idVendor=051d, idProduct=0002, bcdDevice= 1.06
Feb 10 16:52:44 meije kernel: usb 3-1: New USB device strings: Mfr=3,
Product=1, SerialNumber=2
Feb 10 16:52:44 meije kernel: usb 3-1: Product: Back-UPS ES 550
FW:828.D3 .I USB FW:D3
Feb 10 16:52:44 meije kernel: usb 3-1: Manufacturer: APC
Feb 10 16:52:44 meije kernel: usb 3-1: SerialNumber: 3B0918X18511
Feb 10 16:52:44 meije kernel: BTRFS: device label data devid 2 transid
389104 /dev/sdc scanned by systemd-udevd (191)
Feb 10 16:52:44 meije kernel: hid: raw HID events driver (C) Jiri Kosina
Feb 10 16:52:44 meije kernel: BTRFS: device fsid
aae38dd1-9303-4169-97b1-35a7fc951e02 devid 1 transid 2954881 /dev/sdd1
scanned by systemd-udevd (199)
Feb 10 16:52:44 meije kernel: usbcore: registered new interface driver usbhid
Feb 10 16:52:44 meije kernel: usbhid: USB HID core driver
Feb 10 16:52:44 meije kernel: hid-generic 0003:051D:0002.0001:
hiddev0,hidraw0: USB HID v1.10 Device [APC Back-UPS ES 550 FW:828.D3
.I USB FW:D3 ] on usb-0000:0>
Feb 10 16:52:44 meije kernel: ata4: SATA link up 3.0 Gbps (SStatus 123
SControl 300)
Feb 10 16:52:44 meije kernel: ata4.00: failed to IDENTIFY
(INIT_DEV_PARAMS failed, err_mask=0x80)
Feb 10 16:52:44 meije kernel: BTRFS info (device sdd1): disk space
caching is enabled
Feb 10 16:52:44 meije kernel: BTRFS info (device sdd1): has skinny extents
...
Feb 10 17:01:46 meije kernel: BTRFS info (device sda): disk space
caching is enabled
Feb 10 17:01:46 meije kernel: BTRFS info (device sda): has skinny extents
Feb 10 17:01:46 meije kernel: BTRFS error (device sda): devid 3 uuid
443cd484-9ae5-49cf-b630-3f886f523302 is missing
Feb 10 17:01:46 meije kernel: BTRFS error (device sda): failed to read
the system array: -2
Feb 10 17:01:46 meije kernel: BTRFS error (device sda): open_ctree failed

then after mounting degraded, add a new device and attempt to remove
the missing one:

Feb 10 19:38:36 meije kernel: BTRFS info (device sda): disk added /dev/sdb
Feb 10 19:39:18 meije kernel: BTRFS info (device sda): relocating
block group 10045992468480 flags data|raid5
Feb 10 19:39:27 meije kernel: BTRFS info (device sda): found 19 extents
Feb 10 19:39:34 meije kernel: BTRFS info (device sda): found 19 extents
Feb 10 19:39:39 meije kernel: BTRFS info (device sda): clearing
incompat feature flag for RAID56 (0x80)
Feb 10 19:39:39 meije kernel: BTRFS info (device sda): relocating
block group 10043844984832 flags data|raid5
Feb 10 19:39:41 meije kernel: BTRFS info (device sda): setting
incompat feature flag for RAID56 (0x80)
Feb 10 19:39:52 meije kernel: BTRFS info (device sda): found 38 extents
Feb 10 19:39:57 meije kernel: BTRFS info (device sda): found 38 extents
Feb 10 19:40:01 meije kernel: BTRFS info (device sda): clearing
incompat feature flag for RAID56 (0x80)
Feb 10 19:40:01 meije kernel: BTRFS info (device sda): relocating
block group 10041697501184 flags data|raid5
Feb 10 19:40:21 meije kernel: BTRFS info (device sda): setting
incompat feature flag for RAID56 (0x80)
Feb 10 19:40:32 meije kernel: BTRFS info (device sda): found 155 extents
Feb 10 19:40:37 meije kernel: BTRFS info (device sda): found 155 extents
Feb 10 19:40:42 meije kernel: BTRFS info (device sda): clearing
incompat feature flag for RAID56 (0x80)
Feb 10 19:40:42 meije kernel: BTRFS info (device sda): relocating
block group 10039550017536 flags data|raid5
Feb 10 19:41:01 meije kernel: BTRFS info (device sda): setting
incompat feature flag for RAID56 (0x80)
Feb 10 19:41:13 meije kernel: BTRFS info (device sda): found 166 extents
Feb 10 19:41:18 meije kernel: BTRFS info (device sda): found 166 extents
Feb 10 19:41:23 meije kernel: BTRFS info (device sda): clearing
incompat feature flag for RAID56 (0x80)
Feb 10 19:41:23 meije kernel: BTRFS info (device sda): relocating
block group 10037402533888 flags data|raid5
Feb 10 19:41:45 meije kernel: BTRFS info (device sda): setting
incompat feature flag for RAID56 (0x80)
Feb 10 19:41:59 meije kernel: BTRFS info (device sda): found 518 extents
Feb 10 19:42:04 meije kernel: BTRFS info (device sda): found 518 extents
Feb 10 19:42:09 meije kernel: BTRFS info (device sda): clearing
incompat feature flag for RAID56 (0x80)
Feb 10 19:42:09 meije kernel: BTRFS info (device sda): relocating
block group 10035255050240 flags data|raid5
Feb 10 19:42:21 meije kernel: BTRFS info (device sda): setting
incompat feature flag for RAID56 (0x80)
Feb 10 19:42:40 meije kernel: BTRFS info (device sda): found 46 extents
Feb 10 19:42:45 meije kernel: BTRFS info (device sda): found 46 extents
Feb 10 19:42:47 meije kernel: BTRFS info (device sda): clearing
incompat feature flag for RAID56 (0x80)
Feb 10 19:42:47 meije kernel: BTRFS info (device sda): relocating
block group 10033107566592 flags data|raid5
Feb 10 19:42:55 meije kernel: BTRFS info (device sda): setting
incompat feature flag for RAID56 (0x80)
Feb 10 19:43:18 meije kernel: BTRFS info (device sda): found 45 extents
Feb 10 19:43:21 meije kernel: BTRFS info (device sda): found 45 extents
Feb 10 19:43:26 meije kernel: BTRFS info (device sda): clearing
incompat feature flag for RAID56 (0x80)
Feb 10 19:43:26 meije kernel: BTRFS info (device sda): relocating
block group 10030960082944 flags data|raid5
Feb 10 19:43:38 meije kernel: BTRFS info (device sda): setting
incompat feature flag for RAID56 (0x80)
Feb 10 19:43:58 meije kernel: BTRFS info (device sda): found 66 extents
Feb 10 19:44:00 meije rwhod[422]: sending on interface eno1
Feb 10 19:44:02 meije kernel: BTRFS info (device sda): found 66 extents
Feb 10 19:44:06 meije kernel: BTRFS info (device sda): clearing
incompat feature flag for RAID56 (0x80)
Feb 10 19:44:06 meije kernel: BTRFS info (device sda): relocating
block group 10028812599296 flags data|raid5
Feb 10 19:44:21 meije kernel: BTRFS info (device sda): setting
incompat feature flag for RAID56 (0x80)
Feb 10 19:44:36 meije kernel: BTRFS info (device sda): found 64 extents
Feb 10 19:44:41 meije kernel: BTRFS info (device sda): found 64 extents
Feb 10 19:44:44 meije kernel: BTRFS info (device sda): clearing
incompat feature flag for RAID56 (0x80)
Feb 10 19:44:44 meije kernel: BTRFS info (device sda): relocating
block group 10026665115648 flags data|raid5
Feb 10 19:44:55 meije kernel: BTRFS info (device sda): setting
incompat feature flag for RAID56 (0x80)
Feb 10 19:45:13 meije kernel: BTRFS info (device sda): found 51 extents
Feb 10 19:45:17 meije kernel: BTRFS info (device sda): found 51 extents
Feb 10 19:45:22 meije kernel: BTRFS info (device sda): clearing
incompat feature flag for RAID56 (0x80)
Feb 10 19:45:22 meije kernel: BTRFS info (device sda): relocating
block group 10024517632000 flags data|raid5
Feb 10 19:45:36 meije kernel: BTRFS info (device sda): setting
incompat feature flag for RAID56 (0x80)
Feb 10 19:45:52 meije kernel: BTRFS info (device sda): found 46 extents
Feb 10 19:45:56 meije kernel: BTRFS info (device sda): found 46 extents
Feb 10 19:46:00 meije kernel: BTRFS info (device sda): clearing
incompat feature flag for RAID56 (0x80)
Feb 10 19:46:00 meije kernel: BTRFS info (device sda): relocating
block group 10022370148352 flags data|raid5
Feb 10 19:46:17 meije kernel: BTRFS info (device sda): setting
incompat feature flag for RAID56 (0x80)
Feb 10 19:46:31 meije kernel: BTRFS info (device sda): found 49 extents
Feb 10 19:46:36 meije kernel: BTRFS info (device sda): found 49 extents
Feb 10 19:46:41 meije kernel: BTRFS info (device sda): clearing
incompat feature flag for RAID56 (0x80)
Feb 10 19:46:41 meije kernel: BTRFS info (device sda): relocating
block group 10020222664704 flags data|raid5
Feb 10 19:47:00 meije rwhod[422]: sending on interface eno1
Feb 10 19:47:00 meije kernel: BTRFS info (device sda): setting
incompat feature flag for RAID56 (0x80)
Feb 10 19:47:14 meije kernel: BTRFS info (device sda): found 51 extents
Feb 10 19:47:19 meije kernel: BTRFS info (device sda): found 51 extents
Feb 10 19:47:24 meije kernel: BTRFS info (device sda): clearing
incompat feature flag for RAID56 (0x80)
Feb 10 19:47:24 meije kernel: BTRFS info (device sda): relocating
block group 10018075181056 flags data|raid5
Feb 10 19:47:44 meije kernel: BTRFS info (device sda): setting
incompat feature flag for RAID56 (0x80)
Feb 10 19:48:04 meije kernel: BTRFS info (device sda): found 1060 extents
Feb 10 19:48:11 meije kernel: BTRFS info (device sda): found 1060 extents
Feb 10 19:48:22 meije kernel: BTRFS info (device sda): clearing
incompat feature flag for RAID56 (0x80)
Feb 10 19:48:25 meije kernel: BTRFS info (device sda): relocating
block group 10015927697408 flags data|raid5
Feb 10 19:48:44 meije kernel: BTRFS info (device sda): setting
incompat feature flag for RAID56 (0x80)
Feb 10 19:49:44 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 1494749184 csum 0x8941f998 expected csum
0x4c946d24 mirror 2
Feb 10 19:49:44 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 1494753280 csum 0x8941f998 expected csum
0x3cacfa54 mirror 2
Feb 10 19:49:44 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 1494757376 csum 0x8941f998 expected csum
0x453f4f60 mirror 2
Feb 10 19:49:44 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 1494761472 csum 0x8941f998 expected csum
0x5630f6fa mirror 2
Feb 10 19:49:44 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 1494765568 csum 0x8941f998 expected csum
0xbf215c7a mirror 2
Feb 10 19:49:44 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 1494769664 csum 0x8941f998 expected csum
0x242df5b3 mirror 2
Feb 10 19:49:44 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 1494773760 csum 0x8941f998 expected csum
0x84d8643c mirror 2
Feb 10 19:49:44 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 1494777856 csum 0x8941f998 expected csum
0xcd4799e3 mirror 2
Feb 10 19:49:44 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 1494781952 csum 0x8941f998 expected csum
0x84e72065 mirror 2
Feb 10 19:49:44 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 1494786048 csum 0x8941f998 expected csum
0xa1a55d97 mirror 2

and at that point the device remove aborted with an I/O error.

I did discover I could use balance with a filter to balance much of
the onto the three working discs, away from the missing one but I also
discovered that whenever the checksum error appears the space cache
seems to get corrupted.  Any further balance attempt results in
getting stuck in a loop.  Mounting with clear_cache resolves that.

Regards.
Steve.

On Wed, 26 Feb 2020 at 16:49, Jonathan H <pythonnut@gmail.com> wrote:
>
> On Tue, Feb 25, 2020 at 8:37 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > It's great that your metadata is safe.
> >
> > The biggest concern is no longer a concern now.
>
> Glad to hear.
>
> > More context would be welcomed.
>
> Here's a string of uncorrectable errors detected by the scrub: http://ix.io/2cJM
>
> Here is another attempt to read a file giving an I/O error: http://ix.io/2cJS
> The last two lines are produced when trying to read the file a second time.
>
> Here's the state of the currently running scrub: http://ix.io/2cJU
> I had to cancel and resume the scrub to run `btrfs check` earlier, but
> otherwise it has been uninterrupted.
>
> > Anyway, even with more context, it may still lack the needed info as
> > such csum failure message is rate limited.
> >
> > The mirror num 2 means it's the first rebuild try failed.
> >
> > Since only the first rebuild try failed, and there are some corrected
> > data read, it looks btrfs can still rebuild the data.
> >
> > Since you have already observed some EIO, it looks like write hole is
> > involved, screwing up the rebuild process.
> > But it's still very strange, as I'm expecting more mirror number other
> > than 2.
> > For your 6 disks with 1 bad disk, we still have 5 ways to rebuild data,
> > only showing mirror num 2 doesn't look correct to me.
>
> I'm sort of curious why so many files have been affected. It seems
> like most of the file system has become unreadable, but I was under
> the impression that if the write hole occurred it would at least not
> damage too much data at once. Is that incorrect?
>
> > BTW, since your free space cache is already corrupted, it's recommended
> > to clear the space cache.
>
> It's strange to me that the free space cache is giving an error, since
> I cleared it previously and the most recent unmount was clean.
>
> > For now, since it looks like write hole is involved, the only way to
> > solve the problem is to remove all offending files (including a super
> > large file in root 5).
> >
> > You can use `btrfs inspect logical-resolve <bytenr> <mnt>" to see all
> > the involved files.
> >
> > The full <bytenr> are the bytenr shown in btrfs check --check-data-csum
> > output.
>
> The strange thing is if you use `btrfs inspect logical-resolve` on all
> of the bytenrs mentioned in the check output, I get that all of the
> corruption is in the same file (see http://ix.io/2cJP), but this does
> not seem consistent with the uncorrectable csum errors the scrub is
> detecting.
>
> I've been calculating the offsets of the files mentioned in the
> relocation csum errors (by adding the block group and offset),
> resolving the files with `btrfs inspect logical-resolve` and deleting
> them. But it seems like the set of files I'm deleting is also totally
> unrelated to the set of files the scrub is detecting errors in. Given
> the frequency of relocation errors, I fear I will need to delete
> almost everything on the file system for the deletion to complete. I
> can't tell if I should expect these errors to be fixable since the
> relocation isn't making any attempt to correct them as far as I can
> tell.
