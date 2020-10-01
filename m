Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE6727F8C4
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 06:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgJAEt0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 00:49:26 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:37896 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgJAEt0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Oct 2020 00:49:26 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 046D583163B; Thu,  1 Oct 2020 00:49:18 -0400 (EDT)
Date:   Thu, 1 Oct 2020 00:49:15 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Emil Heimpel <broetchenrackete@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Need help recovering broken RAID5 array (parent transid verify
 failed)
Message-ID: <20201001044913.GJ5890@hungrycats.org>
References: <9d2d57e7-29d9-42c2-be55-fb8ee50db40e@localhost>
 <CAJCQCtQ9HzjjaV20txtoHAWG7tTVWaqdk6wf5QtB5v+w2p4b2Q@mail.gmail.com>
 <f6d9ee8a-c0da-4b19-af3a-3c58c9c1478e@localhost>
 <343f7aa9-4cff-45b7-8635-4ca19014c4e5@localhost>
 <CAJCQCtQi3KZvKGO17YoQ3AroiePjywhhNAFjdKFD0DwL3tkbLg@mail.gmail.com>
 <21913a92-5059-405f-b2d4-91e785ab77bd@gmail.com>
 <6e239aa3-734e-42fb-9226-110e390092e1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e239aa3-734e-42fb-9226-110e390092e1@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 04, 2020 at 10:55:19PM +0000, Emil Heimpel wrote:
> Hi,
> 
> I checked the smart values for all drives including short tests and
> all seem fine. I found these in journalctl and they must have happened
> during the balance:
> 
> May 08 08:26:10 BlueQ kernel: sd 11:0:3:0: [sdg] tag#2446 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=9s
> May 08 08:26:10 BlueQ kernel: sd 11:0:3:0: [sdg] tag#2446 CDB: Read(16) 88 00 00 00 00 00 42 84 13 18 00 00 00 08 00 00
> May 08 08:26:10 BlueQ kernel: blk_update_request: I/O error, dev sdg, sector 1115951896 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> 
> ...
> 
> May 08 10:53:27 BlueQ kernel: sd 11:0:2:0: [sdf] tag#2455 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=4s
> May 08 10:53:27 BlueQ kernel: sd 11:0:2:0: [sdf] tag#2455 CDB: Read(16) 88 00 00 00 00 00 42 60 db 10 00 00 00 08 00 00
> May 08 10:53:27 BlueQ kernel: blk_update_request: I/O error, dev sdf, sector 1113643792 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0

These are SCSI-level read errors from sdf and sdg.  If you have read
errors from the sd layer, that indicates hardware failure, regardless
of what SMART says.

Start by replacing that hardware.  Note that the failing component
may not be the hard drive: SATA cables, power cables, power supplies,
and even HCI (controller) chips can fail too.  If multiple disks are
intermittently failing it's usually the power supply or some other
device putting excess load on a shared cable.  Power supplies and cables
are cheap--swap them out and see what happens.

If you have multiple devices failing in the same raid5 filesystem,
successful recovery is not guaranteed.

> ...
> 
> May 08 12:55:14 BlueQ kernel: sd 11:0:2:0: [sdf] tag#3311 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=4s
> May 08 12:55:14 BlueQ kernel: sd 11:0:2:0: [sdf] tag#3311 CDB: Read(16) 88 00 00 00 00 00 42 60 7b 38 00 00 00 30 00 00                          May 08 12:55:14 BlueQ kernel: blk_update_request: I/O error, dev sdf, sector 1113619256 op 0x0:(READ) flags 0x80700 phys_seg 6 prio class 0
> May 08 12:55:23 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 1254360 off 0 (dev /dev/sdf1 sector 1113617208)
> May 08 12:55:23 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 1254360 off 4096 (dev /dev/sdf1 sector 1113617216)
> May 08 12:55:23 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 1254360 off 8192 (dev /dev/sdf1 sector 1113617224)
> May 08 12:55:23 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 1254360 off 12288 (dev /dev/sdf1 sector 1113617232)
> May 08 12:55:23 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 1254360 off 16384 (dev /dev/sdf1 sector 1113617240)
> May 08 12:55:23 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 1254360 off 20480 (dev /dev/sdf1 sector 1113617248)
> 
> ...
> 
> May 08 13:51:51 BlueQ kernel: sd 11:0:2:0: [sdf] tag#2470 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=4s
> May 08 13:51:51 BlueQ kernel: sd 11:0:2:0: [sdf] tag#2470 CDB: Read(16) 88 00 00 00 00 00 42 64 19 a0 00 00 00 10 00 00                          May 08 13:51:51 BlueQ kernel: blk_update_request: I/O error, dev sdf, sector 1113856416 op 0x0:(READ) flags 0x80700 phys_seg 2 prio class 0
> May 08 13:51:51 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 1266969 off 0 (dev /dev/sdf1 sector 1113854368)
> May 08 13:51:51 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 1266969 off 4096 (dev /dev/sdf1 sector 1113854376)
> 
> ...
> 
> May 08 23:09:19 BlueQ kernel: sd 11:0:2:0: [sdf] tag#2480 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=4s                         May 08 23:09:19 BlueQ kernel: sd 11:0:2:0: [sdf] tag#2480 CDB: Read(16) 88 00 00 00 00 00 ab 00 30 80 00 00 01 00 00 00                          May 08 23:09:19 BlueQ kernel: blk_update_request: I/O error, dev sdf, sector 2868916352 op 0x0:(READ) flags 0x80700 phys_seg 16 prio class 0
> May 08 23:09:19 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 5126 off 196608 (dev /dev/sdf1 sector 2868914304)
> May 08 23:09:19 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 5126 off 200704 (dev /dev/sdf1 sector 2868914312)
> May 08 23:09:19 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 5126 off 204800 (dev /dev/sdf1 sector 2868914320)
> May 08 23:09:19 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 5126 off 208896 (dev /dev/sdf1 sector 2868914328)
> May 08 23:09:19 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 5126 off 212992 (dev /dev/sdf1 sector 2868914336)
> May 08 23:09:19 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 5126 off 217088 (dev /dev/sdf1 sector 2868914344)
> May 08 23:09:19 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 5126 off 221184 (dev /dev/sdf1 sector 2868914352)
> May 08 23:09:19 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 5126 off 225280 (dev /dev/sdf1 sector 2868914360)
> May 08 23:09:19 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 5126 off 229376 (dev /dev/sdf1 sector 2868914368)
> May 08 23:09:19 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 5126 off 233472 (dev /dev/sdf1 sector 2868914376)
> 
> ...#btrfs balance started probably
> 
> May 09 04:34:52 BlueQ kernel: BTRFS info (device sdc1): found 26 extents, stage: move data extents
> May 09 04:34:53 BlueQ kernel: BTRFS info (device sdc1): found 26 extents, stage: update data pointers
> May 09 04:34:53 BlueQ kernel: BTRFS info (device sdc1): relocating block group 21793982906368 flags data|raid5
> May 09 04:35:26 BlueQ kernel: BTRFS info (device sdc1): found 26 extents, stage: move data extents
> May 09 04:35:27 BlueQ kernel: BTRFS info (device sdc1): found 26 extents, stage: update data pointers
> May 09 04:35:28 BlueQ kernel: BTRFS info (device sdc1): relocating block group 21790761680896 flags data|raid5
> #repeating a lot
> 
> ...
> 
> May 09 05:11:52 BlueQ kernel: BTRFS info (device sdc1): found 29 extents, stage: move data extents                                               May 09 05:11:53 BlueQ kernel: BTRFS info (device sdc1): found 29 extents, stage: update data pointers                                            May 09 05:11:54 BlueQ kernel: BTRFS info (device sdc1): relocating block group 21555612221440 flags data|raid5                                   May 09 05:12:04 BlueQ kernel: BTRFS warning (device sdc1): csum failed root -9 ino 382 off 440291328 csum 0x2ac15d26 expected csum 0xd26a9dcb mirror 1
> May 09 05:12:04 BlueQ kernel: BTRFS warning (device sdc1): csum failed root -9 ino 382 off 440295424 csum 0x2ac15d26 expected csum 0x85d5d3bb mirror 1
> May 09 05:12:04 BlueQ kernel: BTRFS warning (device sdc1): csum failed root -9 ino 382 off 440299520 csum 0x2ac15d26 expected csum 0x20cd77c6 mirror 1
> May 09 05:12:04 BlueQ kernel: BTRFS warning (device sdc1): csum failed root -9 ino 382 off 440303616 csum 0x2ac15d26 expected csum 0x67d2b42b mirror 1
> May 09 05:12:04 BlueQ kernel: BTRFS warning (device sdc1): csum failed root -9 ino 382 off 440307712 csum 0x2ac15d26 expected csum 0xc77fc7cd mirror 1
> May 09 05:12:04 BlueQ kernel: BTRFS warning (device sdc1): csum failed root -9 ino 382 off 440311808 csum 0x2ac15d26 expected csum 0xe4409fd6 mirror 1
> May 09 05:12:04 BlueQ kernel: BTRFS warning (device sdc1): csum failed root -9 ino 382 off 440315904 csum 0x2ac15d26 expected csum 0x99156670 mirror 1

root -9 is the relocation tree, which does not exist on disk (it is always
converted to a real tree on transaction commit).  You are probably hitting
a known raid5 bug where parity reconstruction fails in degraded mode
(or at other times when a disk block cannot be read).  This will give
you a lot of false read errors with fictional csum values.  The errors
on other roots could be either a disk failure or a btrfs raid5 bug, but
root -9 errors are almost exclusively the btrfs raid5 bug.

Ignore all of this for now.  Find and replace the broken hardware first.
If you determine that the problem is a failing disk, use 'btrfs replace'
to replace the disk.  If it's just cable or power supply and the disk
is OK, then 'btrfs scrub' should suffice.  Be sure to run scrub on each
disk separately, one at a time, to avoid hitting other btrfs raid5 bugs.

Do not use 'balance', 'dev remove' or 'dev add' in the meantime.
They will just keep failing while the hardware issues are present.
If the drive is failing then the extra seeking will speed up
that failure.

> May 09 05:12:04 BlueQ kernel: BTRFS warning (device sdc1): csum failed root -9 ino 382 off 440320000 csum 0x2ac15d26 expected csum 0xfd4f65c0 mirror 1
> May 09 05:12:04 BlueQ kernel: BTRFS warning (device sdc1): csum failed root -9 ino 382 off 440324096 csum 0x2ac15d26 expected csum 0xbc27383b mirror 1
> May 09 05:12:04 BlueQ kernel: BTRFS warning (device sdc1): csum failed root -9 ino 382 off 440328192 csum 0x2ac15d26 expected csum 0x84fb6b1f mirror 1
> May 09 05:12:05 BlueQ kernel: repair_io_failure: 6 callbacks suppressed
> May 09 05:12:05 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 382 off 440291328 (dev /dev/sda1 sector 6697578792)
> May 09 05:12:05 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 382 off 440295424 (dev /dev/sda1 sector 6697578800)
> May 09 05:12:05 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 382 off 440303616 (dev /dev/sda1 sector 6697578816)
> May 09 05:12:05 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 382 off 440299520 (dev /dev/sda1 sector 6697578808)
> May 09 05:12:05 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 382 off 440307712 (dev /dev/sda1 sector 6697578824)
> May 09 05:12:05 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 382 off 440311808 (dev /dev/sda1 sector 6697578832)
> May 09 05:12:05 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 382 off 440315904 (dev /dev/sda1 sector 6697578840)
> May 09 05:12:05 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 382 off 440320000 (dev /dev/sda1 sector 6697578848)
> May 09 05:12:05 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 382 off 440324096 (dev /dev/sda1 sector 6697578856)
> May 09 05:12:06 BlueQ kernel: BTRFS info (device sdc1): read error corrected: ino 382 off 440328192 (dev /dev/sda1 sector 6697578864)
> May 09 05:12:36 BlueQ kernel: btrfs_print_data_csum_error: 349 callbacks suppressed
> May 09 05:12:36 BlueQ kernel: BTRFS warning (device sdc1): csum failed root -9 ino 382 off 3137126400 csum 0x2ac15d26 expected csum 0xde18d96f m>
> May 09 05:12:36 BlueQ kernel: BTRFS warning (device sdc1): csum failed root -9 ino 382 off 3137130496 csum 0x2ac15d26 expected csum 0xda0ff7db m>
> May 09 05:12:36 BlueQ kernel: BTRFS warning (device sdc1): csum failed root -9 ino 382 off 3137134592 csum 0x2ac15d26 expected csum 0xf76a890c m>
> May 09 05:12:36 BlueQ kernel: BTRFS warning (device sdc1): csum failed root -9 ino 382 off 3137138688 csum 0x2ac15d26 expected csum 0x228317a4 m>
> May 09 05:12:37 BlueQ kernel: BTRFS warning (device sdc1): csum failed root -9 ino 382 off 3138387968 csum 0x2ac15d26 expected csum 0xcf6b7db7 m>
> May 09 05:12:37 BlueQ kernel: BTRFS warning (device sdc1): csum failed root -9 ino 382 off 3138519040 csum 0x2ac15d26 expected csum 0xa992d2c0 m>
> May 09 05:12:37 BlueQ kernel: BTRFS warning (device sdc1): csum failed root -9 ino 382 off 3138650112 csum 0x2ac15d26 expected csum 0xfeae0823 m>
> May 09 05:12:37 BlueQ kernel: BTRFS warning (device sdc1): csum failed root -9 ino 382 off 3138523136 csum 0x2ac15d26 expected csum 0xf05799e5 m>
> May 09 05:12:37 BlueQ kernel: BTRFS warning (device sdc1): csum failed root -9 ino 382 off 3138527232 csum 0x2ac15d26 expected csum 0x41210896 m>
> May 09 05:12:37 BlueQ kernel: BTRFS warning (device sdc1): csum failed root -9 ino 382 off 3138531328 csum 0x2ac15d26 expected csum 0x8ff1d037 m>
> May 09 05:12:37 BlueQ kernel: repair_io_failure: 350 callbacks suppressed
> 
> ... #Happily balancing for over 24h without warnings or errors...
> 
> May 10 08:32:41 BlueQ kernel: BTRFS info (device sdc1): relocating block group 10412162809856 flags data|raid5
> May 10 08:33:17 BlueQ kernel: sd 11:0:3:0: attempting task abort!scmd(0x00000000931cd1e4), outstanding for 7174 ms & timeout 7000 ms
> May 10 08:33:17 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1340 CDB: ATA command pass through(16) 85 06 20 00 00 00 00 00 00 00 00 00 00 00 e5 00
> May 10 08:33:17 BlueQ kernel: scsi target11:0:3: handle(0x000c), sas_address(0x4433221107000000), phy(7)
> May 10 08:33:17 BlueQ kernel: scsi target11:0:3: enclosure logical id(0x590b11c022f3fb00), slot(4)
> May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: task abort: SUCCESS scmd(0x00000000931cd1e4)                                                          May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1342 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=14s
> May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1342 Sense Key : Not Ready [current]
> May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1342 Add. Sense: Logical unit not ready, cause not reportable
> May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1342 CDB: Synchronize Cache(10) 35 00 00 00 00 00 00 00 00 00
> May 10 08:33:21 BlueQ kernel: blk_update_request: I/O error, dev sdg, sector 0 op 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
> May 10 08:33:21 BlueQ kernel: BTRFS error (device sdc1): bdev /dev/sdg1 errs: wr 0, rd 0, flush 1, corrupt 0, gen 0                              May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1343 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=14s
> May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1343 Sense Key : Not Ready [current]
> May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1343 Add. Sense: Logical unit not ready, cause not reportable
> May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1343 CDB: Write(16) 8a 00 00 00 00 02 0a 9a a0 80 00 00 0a 00 00 00
> May 10 08:33:21 BlueQ kernel: blk_update_request: I/O error, dev sdg, sector 8767840384 op 0x1:(WRITE) flags 0x0 phys_seg 61 prio class 0
> May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1280 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=14s
> May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1280 Sense Key : Not Ready [current]
> May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1280 Add. Sense: Logical unit not ready, cause not reportable
> May 10 08:33:21 BlueQ kernel: sd 11:0:3:0: [sdg] tag#1280 CDB: Write(16) 8a 00 00 00 00 02 0a 9a aa 80 00 00 0a 00 00 00
> May 10 08:33:21 BlueQ kernel: blk_update_request: I/O error, dev sdg, sector 8767842944 op 0x1:(WRITE) flags 0x0 phys_seg 65 prio class 0
> May 10 08:33:21 BlueQ kernel: blk_update_request: I/O error, dev sdg, sector 8767855488 op 0x1:(WRITE) flags 0x4000 phys_seg 37 prio class 0
> May 10 08:33:21 BlueQ kernel: BTRFS warning (device sdc1): lost page write due to IO error on /dev/sdg1
> May 10 08:33:21 BlueQ kernel: BTRFS error (device sdc1): bdev /dev/sdg1 errs: wr 1, rd 0, flush 1, corrupt 0, gen 0
> May 10 08:33:21 BlueQ kernel: BTRFS warning (device sdc1): lost page write due to IO error on /dev/sdg1

sdg definitely failing here.

> May 10 08:33:21 BlueQ kernel: BTRFS error (device sdc1): bdev /dev/sdg1 errs: wr 2, rd 0, flush 1, corrupt 0, gen 0
> May 10 08:33:21 BlueQ kernel: BTRFS warning (device sdc1): lost page write due to IO error on /dev/sdg1
> May 10 08:33:21 BlueQ kernel: BTRFS error (device sdc1): bdev /dev/sdg1 errs: wr 3, rd 0, flush 1, corrupt 0, gen 0                              May 10 08:33:21 BlueQ udisksd[3593]: Error performing housekeeping for drive /org/freedesktop/UDisks2/drives/ST5000DM000_1FK178_W4J10239: Error >

OK, forget all that stuff I said above about power and SATA cables.
That is a Seagate Barracuda.  It's almost certainly the drive.

> 0000: 00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00    ................
> 0010: 00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00    ................
> (g-io-error-quark, 0)
> May 10 08:33:21 BlueQ kernel: BTRFS error (device sdc1): error writing primary super block to device 2
> May 10 08:33:23 BlueQ kernel: BTRFS error (device sdc1): bdev /dev/sdg1 errs: wr 3, rd 0, flush 2, corrupt 0, gen 0
> May 10 08:33:23 BlueQ kernel: BTRFS warning (device sdc1): lost page write due to IO error on /dev/sdg1
> May 10 08:33:23 BlueQ kernel: BTRFS error (device sdc1): bdev /dev/sdg1 errs: wr 4, rd 0, flush 2, corrupt 0, gen 0
> May 10 08:33:23 BlueQ kernel: BTRFS warning (device sdc1): lost page write due to IO error on /dev/sdg1
> 
> Do I need to worry about the hdds?

It looks like sdg just gave up.

> Emil
> P. S.: Not sure if my previous email reached the ML....?
> 
> Jun 3, 2020 10:44:49 Emil Heimpel <broetchenrackete@gmail.com>:
> 
> > Hi again.
> > 
> > I think I managed to restore all data to a new backup except one old Systembackup image from a laptop. Of course there could be files that weren't found at all, but I didn't notice any.
> > 
> > I tried init-extent-tree with and without the alternate root tree block, but both failed. Both seemed to crash with a segmentation fault, see attached logs and dmesg-snippets for more information. I did disable write cache on all drives with hdparm as suggested.
> > 
> > Now I'm not sure what the best way to go forward is. If you have further suggestions I could try to repair the array, I would try them today. Otherwise I would format the drives and create a new array (Metadata raid1(C3?), data raid5, checksum maybe sha or blake2, maybe zstd compression, space_cache v2). If you have any suggestions for the new array feel free to tell me!
> > 
> > Thank you for the help so far!
> > 
> > Emil
> > 
> > dmesg logs:
> > 
> > "btrfs check --init-extent-tree -p /dev/sda1
> > [1534223.372937] btrfs[181698]: segfault at 10 ip 00007f3ef8358d77 sp 00007ffd4c006ee0 error 4 in libc-2.31.so[7f3ef82f6000+14d000]
> > [1534223.372949] Code: 88 08 00 00 0f 86 39 04 00 00 8b 35 b7 bf 13 00 85 f6 0f 85 ab 05 00 00 41 f6 44 24 08 01 75 24 49 8b 04 24 49 29 c4 48 01 c3 <49> 8b 54 24 08 48 83 e2 f8 48 39 c2 0f 85 09 06 00 00 4c 89 e7 e8
> > [1534223.373107] audit: type=1701 audit(1591128122.557:1822): auid=1000 uid=0 gid=0 ses=39 pid=181698 comm="btrfs" exe="/usr/bin/btrfs" sig=11 res=1
> > 
> > btrfs check --init-extent-tree -r 30122107502592 -p /dev/sda1
> > [1535246.991899] sd 11:0:3:0: [sdg] tag#46 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=9s
> > [1535246.991905] sd 11:0:3:0: [sdg] tag#46 CDB: Read(16) 88 00 00 00 00 02 46 30 d9 00 00 00 00 08 00 00
> > [1535246.991909] blk_update_request: I/O error, dev sdg, sector 9767540992 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > [1535251.466041] sd 11:0:2:0: [sdf] tag#11 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=4s
> > [1535251.466047] sd 11:0:2:0: [sdf] tag#11 CDB: Read(16) 88 00 00 00 00 01 d1 c0 be 00 00 00 00 08 00 00
> > [1535251.466051] blk_update_request: I/O error, dev sdf, sector 7814036992 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > [1535328.853062] btrfs[181874]: segfault at 10 ip 00007f6c9c447d77 sp 00007ffc666cc940 error 4 in libc-2.31.so[7f6c9c3e5000+14d000]
> > [1535328.853069] Code: 88 08 00 00 0f 86 39 04 00 00 8b 35 b7 bf 13 00 85 f6 0f 85 ab 05 00 00 41 f6 44 24 08 01 75 24 49 8b 04 24 49 29 c4 48 01 c3 <49> 8b 54 24 08 48 83 e2 f8 48 39 c2 0f 85 09 06 00 00 4c 89 e7 e8
> > [1535328.853097] audit: type=1701 audit(1591129228.050:1845): auid=1000 uid=0 gid=0 ses=39 pid=181874 comm="btrfs" exe="/usr/bin/btrfs" sig=11 res=1"
> > 
> > Log from failed restore:
> > ERROR: exhausted mirros trying to read (3 > 2)
> > Error copying data for /path/to/file/xxxxxxxxxxxxxx.vhdx
> > 
> > May 20, 2020 21:01:45 Chris Murphy <lists@colorremedies.com>:
> > 
> >> On Wed, May 20, 2020 at 5:56 AM Emil Heimpel <broetchenrackete@gmail.com> wrote:
> >>> 
> >>> Hi again,
> >>> 
> >>> I ran find-root and using the first found root (that is not in the superblock) seems to be finding data with btrfs-restore (only did a dry-run, because I don't have the space at the moment to do a full restore). At least I got warnings about folders where it stopped looping and I recognized the folders. It is still not showing any files, but maybe I misunderstood what the dry-run option is suppose to be doing.
> >>> 
> >>> Because the generation of the root is higher than expected, I don't know which root is expected to be the best option to choose from. One that is closest to the root the super thinks is the correct one (fe 30122555883520(gen: 116442 level: 0)) or the one with the highest generation (30122107502592(gen: 116502 level: 1))? To be honest I don't think I quite understand generations and levels :)
> >> 
> >> Yeah it's confusing.
> >> 
> >> I think there's extent tree corruption and I'm not sure it can be
> >> repaired. I suggest 'btrfs restore' until you're satisfied, and then
> >> you can try 'btrfs check --init-extent-tree' and see if it can fix the
> >> extent tree. It's maybe a 50/50 chance, hard to say. If it completes,
> >> follow it up with 'btrfs check' without options, and see if it
> >> complains about anything else.
> >> 
> >> One thing that's important to consider is using space_cache v2. The
> >> default space_cache v1 puts free space metadata into data chunks,
> >> subjecting them to raid56, which is not great. Since you went to the
> >> effort to use raid1 metadata, best to also use space_cache=v2 at first
> >> mount, putting free space metadata into metadata chunks. It's expected
> >> to be the default soon, I guess, but I'm not sure what the time frame
> >> is.
> >> 
> >> Also consider using hdparm -W (capital W not lower case, see man page)
> >> to disable the write cache on all drives if you're not certain they
> >> consistently honor FUA or fsync.
> >> 
> >> -- 
> >> Chris Murphy
> >> 
