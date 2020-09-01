Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333F0259907
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 18:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbgIAQfj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 12:35:39 -0400
Received: from anderith.bouah.net ([108.61.181.222]:44492 "EHLO
        anderith.bouah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730584AbgIAPaR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 11:30:17 -0400
X-Greylist: delayed 4671 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Sep 2020 11:30:13 EDT
Date:   Tue, 1 Sep 2020 17:29:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bouah.net; s=anderith;
        t=1598974205; bh=jZgfRnY4LtBCYqO0prdWgO6D7xb16EpRqQmiXxJ5cWI=;
        h=Date:From:To:Subject:References:In-Reply-To;
        b=A69zBU/fGpRk1IlPjJsKHXFX4b8iVZA90GPevcIu7O7D8A0qdbEbAEhp2hzfhNzs9
         eJzmHppN3DZyIhyXPhsWvsjSMONJKdR/G0U89a4kH42QqUGdrvahV3VGLUbYJzj4va
         p1RAo6IEWPpKx9DqXEt30y9m2pfAaK1yBHAOo5KE=
From:   Maxime Buquet <pep@bouah.net>
To:     linux-btrfs@vger.kernel.org
Subject: Re: "bad tree block" on Linux 5.8.5
Message-ID: <20200901152958.GA65427@caska>
References: <20200901140634.GA774@caska>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20200901140634.GA774@caska>
X-PGP-Key: https://bouah.net/0x840FD3DCCA998D434FD2155DDEDA74AEECA9D0F2.asc.pub
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020/09/01, Maxime Buquet wrote:
> Hi there,
>=20
> I'm having bad tree block issues on Linux 5.8.5 since yesterday. I'm not
> entirely sure how it happened. Any help is appreciated to try and debug.

I dug up kernel logs from when it happened, and I'm seeing slightly more
errors, on 5.8.1.

The skipped snippets should only be unrelated stuff, I tried to include
everything related. I also included a smartctl test for good measure at
the end, (suggested by folks on IRC).


Aug 31 09:31:52 caska kernel: usb 2-1: new SuperSpeed Gen 1 USB device numb=
er 2 using xhci_hcd
Aug 31 09:31:52 caska kernel: usb 2-1: New USB device found, idVendor=3D105=
8, idProduct=3D25a1, bcdDevice=3D10.14
Aug 31 09:31:52 caska kernel: usb 2-1: New USB device strings: Mfr=3D2, Pro=
duct=3D3, SerialNumber=3D1
Aug 31 09:31:52 caska kernel: usb 2-1: Product: Elements 25A1
Aug 31 09:31:52 caska kernel: usb 2-1: Manufacturer: Western Digital
Aug 31 09:31:52 caska kernel: usb 2-1: SerialNumber: 575853314543374658314C=
38
Aug 31 09:31:52 caska kernel: usb-storage 2-1:1.0: USB Mass Storage device =
detected
Aug 31 09:31:52 caska kernel: scsi host3: usb-storage 2-1:1.0
Aug 31 09:31:52 caska kernel: usbcore: registered new interface driver usb-=
storage
Aug 31 09:31:52 caska kernel: usbcore: registered new interface driver uas
Aug 31 09:31:53 caska kernel: scsi 3:0:0:0: Direct-Access     WD       Elem=
ents 25A1    1014 PQ: 0 ANSI: 6
Aug 31 09:31:53 caska kernel: sd 3:0:0:0: Attached scsi generic sg1 type 0
Aug 31 09:31:53 caska kernel: sd 3:0:0:0: [sdb] Spinning up disk...
Aug 31 09:32:00 caska kernel: .......ready
Aug 31 09:32:00 caska kernel: sd 3:0:0:0: [sdb] Very big device. Trying to =
use READ CAPACITY(16).
Aug 31 09:32:00 caska kernel: sd 3:0:0:0: [sdb] 7813969920 512-byte logical=
 blocks: (4.00 TB/3.64 TiB)
Aug 31 09:32:00 caska kernel: sd 3:0:0:0: [sdb] 4096-byte physical blocks
Aug 31 09:32:00 caska kernel: sd 3:0:0:0: [sdb] Write Protect is off
Aug 31 09:32:00 caska kernel: sd 3:0:0:0: [sdb] Mode Sense: 47 00 10 08
Aug 31 09:32:00 caska kernel: sd 3:0:0:0: [sdb] No Caching mode page found
Aug 31 09:32:00 caska kernel: sd 3:0:0:0: [sdb] Assuming drive cache: write=
 through
Aug 31 09:32:00 caska kernel:  sdb: sdb1
Aug 31 09:32:00 caska kernel: sd 3:0:0:0: [sdb] Attached SCSI disk
Aug 31 09:43:54 caska kernel: BTRFS: device fsid dd439261-afed-4c9e-8685-07=
d46e46e917 devid 1 transid 71912 /dev/dm-1 scanned by systemd-udevd (150530)
Aug 31 09:44:02 caska kernel: BTRFS info (device dm-1): disk space caching =
is enabled
Aug 31 09:44:02 caska kernel: BTRFS info (device dm-1): has skinny extents
Aug 31 09:44:02 caska kernel: BTRFS info (device dm-1): bdev /dev/mapper/da=
ta errs: wr 0, rd 0, flush 0, corrupt 304, gen 0
Aug 31 09:52:11 caska kernel: INFO: task kworker/u16:8:150652 blocked for m=
ore than 122 seconds.
Aug 31 09:52:11 caska kernel:       Tainted: G        W IOE     5.8.1-arch1=
-1 #1
Aug 31 09:52:11 caska kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_=
secs" disables this message.
Aug 31 09:52:11 caska kernel: kworker/u16:8   D    0 150652      2 0x000040=
80
Aug 31 09:52:11 caska kernel: Workqueue: btrfs-endio-write btrfs_work_helpe=
r [btrfs]
Aug 31 09:52:11 caska kernel: Call Trace:
Aug 31 09:52:11 caska kernel:  __schedule+0x2a9/0x8d0
Aug 31 09:52:11 caska kernel:  schedule+0x46/0xf0
Aug 31 09:52:11 caska kernel:  btrfs_tree_lock+0xe6/0x200 [btrfs]
Aug 31 09:52:11 caska kernel:  ? wait_woken+0x80/0x80
Aug 31 09:52:11 caska kernel:  btrfs_lock_root_node+0x2f/0x40 [btrfs]
Aug 31 09:52:11 caska kernel:  btrfs_search_slot+0x506/0x980 [btrfs]
Aug 31 09:52:11 caska kernel:  ? btrfs_add_delayed_data_ref+0x3c5/0x4e0 [bt=
rfs]
Aug 31 09:52:11 caska kernel:  btrfs_lookup_csum+0x8c/0x1a0 [btrfs]
Aug 31 09:52:11 caska kernel:  ? insert_reserved_file_extent.constprop.0+0x=
271/0x300 [btrfs]
Aug 31 09:52:11 caska kernel:  btrfs_csum_file_blocks+0x195/0x6f0 [btrfs]
Aug 31 09:52:11 caska kernel:  ? insert_reserved_file_extent.constprop.0+0x=
271/0x300 [btrfs]
Aug 31 09:52:11 caska kernel:  add_pending_csums+0x50/0x70 [btrfs]
Aug 31 09:52:11 caska kernel:  btrfs_finish_ordered_io.isra.0+0x3e9/0x7b0 [=
btrfs]
Aug 31 09:52:11 caska kernel:  btrfs_work_helper+0xd7/0x3e0 [btrfs]
Aug 31 09:52:11 caska kernel:  process_one_work+0x1da/0x3d0
Aug 31 09:52:11 caska kernel:  worker_thread+0x4d/0x3d0
Aug 31 09:52:11 caska kernel:  ? rescuer_thread+0x410/0x410
Aug 31 09:52:11 caska kernel:  kthread+0x142/0x160
Aug 31 09:52:11 caska kernel:  ? __kthread_bind_mask+0x60/0x60
Aug 31 09:52:11 caska kernel:  ret_from_fork+0x22/0x30

[..]

Aug 31 14:35:27 caska kernel: usb 2-1: USB disconnect, device number 2
Aug 31 14:44:04 caska kernel: usb 2-1: new SuperSpeed Gen 1 USB device numb=
er 3 using xhci_hcd
Aug 31 14:44:04 caska kernel: usb 2-1: New USB device found, idVendor=3D105=
8, idProduct=3D25a1, bcdDevice=3D10.14
Aug 31 14:44:04 caska kernel: usb 2-1: New USB device strings: Mfr=3D2, Pro=
duct=3D3, SerialNumber=3D1
Aug 31 14:44:04 caska kernel: usb 2-1: Product: Elements 25A1
Aug 31 14:44:04 caska kernel: usb 2-1: Manufacturer: Western Digital
Aug 31 14:44:04 caska kernel: usb 2-1: SerialNumber: 575853314543374658314C=
38
Aug 31 14:44:04 caska kernel: usb-storage 2-1:1.0: USB Mass Storage device =
detected
Aug 31 14:44:04 caska kernel: scsi host4: usb-storage 2-1:1.0
Aug 31 14:44:05 caska kernel: scsi 4:0:0:0: Direct-Access     WD       Elem=
ents 25A1    1014 PQ: 0 ANSI: 6
Aug 31 14:44:05 caska kernel: sd 4:0:0:0: Attached scsi generic sg1 type 0
Aug 31 14:44:05 caska kernel: sd 4:0:0:0: [sdc] Spinning up disk...
Aug 31 14:44:10 caska kernel: ....
Aug 31 14:44:10 caska kernel: BTRFS info (device dm-0): balance: start -dus=
age=3D100
Aug 31 14:44:10 caska kernel: BTRFS info (device dm-0): relocating block gr=
oup 1831526531072 flags data
Aug 31 14:44:12 caska kernel: ...ready
Aug 31 14:44:12 caska kernel: sd 4:0:0:0: [sdc] Very big device. Trying to =
use READ CAPACITY(16).
Aug 31 14:44:12 caska kernel: sd 4:0:0:0: [sdc] 7813969920 512-byte logical=
 blocks: (4.00 TB/3.64 TiB)
Aug 31 14:44:12 caska kernel: sd 4:0:0:0: [sdc] 4096-byte physical blocks
Aug 31 14:44:12 caska kernel: sd 4:0:0:0: [sdc] Write Protect is off
Aug 31 14:44:12 caska kernel: sd 4:0:0:0: [sdc] Mode Sense: 47 00 10 08
Aug 31 14:44:12 caska kernel: sd 4:0:0:0: [sdc] No Caching mode page found
Aug 31 14:44:12 caska kernel: sd 4:0:0:0: [sdc] Assuming drive cache: write=
 through
Aug 31 14:44:12 caska kernel:  sdc: sdc1
Aug 31 14:44:12 caska kernel: sd 4:0:0:0: [sdc] Attached SCSI disk

[..]

Aug 31 14:53:02 caska kernel: BTRFS error (device dm-1): bdev /dev/mapper/d=
ata errs: wr 0, rd 1, flush 0, corrupt 304, gen 0
Aug 31 14:53:04 caska kernel: BTRFS error (device dm-1): bdev /dev/mapper/d=
ata errs: wr 0, rd 2, flush 0, corrupt 304, gen 0

[..]

Aug 31 14:56:21 caska kernel: BTRFS error (device dm-1): bdev /dev/mapper/d=
ata errs: wr 1, rd 2, flush 0, corrupt 304, gen 0
Aug 31 14:56:21 caska kernel: BTRFS error (device dm-1): bdev /dev/mapper/d=
ata errs: wr 1, rd 3, flush 0, corrupt 304, gen 0
Aug 31 14:56:21 caska kernel: BTRFS error (device dm-1): bdev /dev/mapper/d=
ata errs: wr 1, rd 4, flush 0, corrupt 304, gen 0
Aug 31 14:56:21 caska kernel: BTRFS: error (device dm-1) in btrfs_start_dir=
ty_block_groups:2710: errno=3D-5 IO failure
Aug 31 14:56:21 caska kernel: BTRFS info (device dm-1): forced readonly
Aug 31 14:56:21 caska kernel: BTRFS warning (device dm-1): Skipping commit =
of aborted transaction.
Aug 31 14:56:21 caska kernel: BTRFS error (device dm-1): bdev /dev/mapper/d=
ata errs: wr 2, rd 4, flush 0, corrupt 304, gen 0
Aug 31 15:08:23 caska kernel: ------------[ cut here ]------------
Aug 31 15:08:23 caska kernel: WARNING: CPU: 0 PID: 157051 at fs/btrfs/block=
-rsv.c:451 btrfs_release_global_block_rsv+0x70/0xc0 [btrfs]
Aug 31 15:08:23 caska kernel: Modules linked in: snd_seq_dummy snd_hrtimer =
snd_seq snd_seq_device fuse uas usb_storage veth xt_conntrack xt_MASQUERADE=
 nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype iptable_fil=
ter iptable_nat nf_nat nf_conntrack nf_defrag_i>
Aug 31 15:08:23 caska kernel:  ecdh_generic rapl ecc drm_kms_helper snd_hwd=
ep intel_cstate crc16 thinkpad_acpi intel_uncore psmouse input_leds pcspkr =
cfg80211 tpm_tis nvram snd_pcm cec ledtrig_audio mei_me evdev tpm_tis_core =
mac_hid rfkill snd_timer ac e1000e rc_core inte>
Aug 31 15:08:23 caska kernel: CPU: 0 PID: 157051 Comm: umount Tainted: G   =
     W IOE     5.8.1-arch1-1 #1
Aug 31 15:08:23 caska kernel: Hardware name: LENOVO 20CM001UUK/20CM001UUK, =
BIOS N10ET27W (1.04 ) 12/01/2014
Aug 31 15:08:23 caska kernel: RIP: 0010:btrfs_release_global_block_rsv+0x70=
/0xc0 [btrfs]
Aug 31 15:08:23 caska kernel: Code: 48 83 bb a8 01 00 00 00 75 54 48 83 bb =
b0 01 00 00 00 75 56 48 83 bb e8 01 00 00 00 75 58 48 83 bb e0 01 00 00 00 =
75 02 5b c3 <0f> 0b 5b c3 0f 0b 48 83 bb 40 01 00 00 00 74 b2 0f 0b 48 83 b=
b 70
Aug 31 15:08:23 caska kernel: RSP: 0018:ffffb4420313bdf0 EFLAGS: 00010206
Aug 31 15:08:23 caska kernel: RAX: 000000001fff0000 RBX: ffff8e9928a21000 R=
CX: 0000000000000000
Aug 31 15:08:23 caska kernel: RDX: 0000000000000001 RSI: ffff8e98cbf764a8 R=
DI: 00000000ffffffff
Aug 31 15:08:23 caska kernel: RBP: ffff8e98cbf77c00 R08: 0000000020000000 R=
09: 0000000000000000
Aug 31 15:08:23 caska kernel: R10: 00000000000014f5 R11: 0000000000000000 R=
12: ffff8e9928a216a0
Aug 31 15:08:23 caska kernel: R13: dead000000000122 R14: dead000000000100 R=
15: dead000000000100
Aug 31 15:08:23 caska kernel: FS:  00007eff900b4540(0000) GS:ffff8e9abdc000=
00(0000) knlGS:0000000000000000
Aug 31 15:08:23 caska kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
Aug 31 15:08:23 caska kernel: CR2: 000055983c57f018 CR3: 000000020940c006 C=
R4: 00000000003606f0
Aug 31 15:08:23 caska kernel: Call Trace:
Aug 31 15:08:23 caska kernel:  btrfs_free_block_groups+0x1f1/0x280 [btrfs]
Aug 31 15:08:23 caska kernel:  close_ctree+0x262/0x2a4 [btrfs]
Aug 31 15:08:23 caska kernel:  generic_shutdown_super+0x6c/0x100
Aug 31 15:08:23 caska kernel:  kill_anon_super+0x14/0x30
Aug 31 15:08:23 caska kernel:  btrfs_kill_super+0x12/0x20 [btrfs]
Aug 31 15:08:23 caska kernel:  deactivate_locked_super+0x36/0x90
Aug 31 15:08:23 caska kernel:  cleanup_mnt+0x12d/0x190
Aug 31 15:08:23 caska kernel:  task_work_run+0x5c/0x90
Aug 31 15:08:23 caska kernel:  __prepare_exit_to_usermode+0x198/0x1c0
Aug 31 15:08:23 caska kernel:  do_syscall_64+0x50/0x70
Aug 31 15:08:23 caska kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug 31 15:08:23 caska kernel: RIP: 0033:0x7eff90233c2b
Aug 31 15:08:23 caska kernel: Code: 02 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 =
66 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 =
00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 35 02 0c 00 f7 d8 64 89 0=
1 48
Aug 31 15:08:23 caska kernel: RSP: 002b:00007fff6d3be1a8 EFLAGS: 00000246 O=
RIG_RAX: 00000000000000a6
Aug 31 15:08:23 caska kernel: RAX: 0000000000000000 RBX: 00007eff90358264 R=
CX: 00007eff90233c2b
Aug 31 15:08:23 caska kernel: RDX: 0000000000000007 RSI: 0000000000000000 R=
DI: 000055983c574bd0
Aug 31 15:08:23 caska kernel: RBP: 000055983c572440 R08: 0000000000000000 R=
09: 00007eff902f4a40
Aug 31 15:08:23 caska kernel: R10: 000055983c57abc0 R11: 0000000000000246 R=
12: 0000000000000000
Aug 31 15:08:23 caska kernel: R13: 000055983c574bd0 R14: 000055983c572550 R=
15: 000055983c572670
Aug 31 15:08:23 caska kernel: ---[ end trace 9b4acfec61180645 ]---


[..]

Aug 31 18:29:47 caska kernel: usb 2-1: USB disconnect, device number 3
Aug 31 19:43:01 caska kernel: usb 2-1: new SuperSpeed Gen 1 USB device numb=
er 4 using xhci_hcd
Aug 31 19:43:01 caska kernel: usb 2-1: New USB device found, idVendor=3D105=
8, idProduct=3D25a1, bcdDevice=3D10.14
Aug 31 19:43:01 caska kernel: usb 2-1: New USB device strings: Mfr=3D2, Pro=
duct=3D3, SerialNumber=3D1
Aug 31 19:43:01 caska kernel: usb 2-1: Product: Elements 25A1
Aug 31 19:43:01 caska kernel: usb 2-1: Manufacturer: Western Digital
Aug 31 19:43:01 caska kernel: usb 2-1: SerialNumber: 575853314543374658314C=
38
Aug 31 19:43:01 caska kernel: usb-storage 2-1:1.0: USB Mass Storage device =
detected
Aug 31 19:43:01 caska kernel: scsi host4: usb-storage 2-1:1.0
Aug 31 19:43:02 caska kernel: scsi 4:0:0:0: Direct-Access     WD       Elem=
ents 25A1    1014 PQ: 0 ANSI: 6
Aug 31 19:43:02 caska kernel: sd 4:0:0:0: Attached scsi generic sg1 type 0
Aug 31 19:43:02 caska kernel: sd 4:0:0:0: [sdc] Spinning up disk...
Aug 31 19:43:09 caska kernel: .......ready
Aug 31 19:43:09 caska kernel: sd 4:0:0:0: [sdc] Very big device. Trying to =
use READ CAPACITY(16).
Aug 31 19:43:09 caska kernel: sd 4:0:0:0: [sdc] 7813969920 512-byte logical=
 blocks: (4.00 TB/3.64 TiB)
Aug 31 19:43:09 caska kernel: sd 4:0:0:0: [sdc] 4096-byte physical blocks
Aug 31 19:43:09 caska kernel: sd 4:0:0:0: [sdc] Write Protect is off
Aug 31 19:43:09 caska kernel: sd 4:0:0:0: [sdc] Mode Sense: 47 00 10 08
Aug 31 19:43:09 caska kernel: sd 4:0:0:0: [sdc] No Caching mode page found
Aug 31 19:43:09 caska kernel: sd 4:0:0:0: [sdc] Assuming drive cache: write=
 through
Aug 31 19:43:09 caska kernel:  sdc: sdc1
Aug 31 19:43:09 caska kernel: sd 4:0:0:0: [sdc] Attached SCSI disk

[..]

Aug 31 19:45:34 caska kernel: usb 2-1: USB disconnect, device number 4
Aug 31 19:45:36 caska kernel: usb 2-1: new SuperSpeed Gen 1 USB device numb=
er 5 using xhci_hcd
Aug 31 19:45:36 caska kernel: usb 2-1: New USB device found, idVendor=3D105=
8, idProduct=3D25a1, bcdDevice=3D10.14
Aug 31 19:45:36 caska kernel: usb 2-1: New USB device strings: Mfr=3D2, Pro=
duct=3D3, SerialNumber=3D1
Aug 31 19:45:36 caska kernel: usb 2-1: Product: Elements 25A1
Aug 31 19:45:36 caska kernel: usb 2-1: Manufacturer: Western Digital
Aug 31 19:45:36 caska kernel: usb 2-1: SerialNumber: 575853314543374658314C=
38
Aug 31 19:45:36 caska kernel: usb-storage 2-1:1.0: USB Mass Storage device =
detected
Aug 31 19:45:36 caska kernel: scsi host4: usb-storage 2-1:1.0
Aug 31 19:45:37 caska kernel: scsi 4:0:0:0: Direct-Access     WD       Elem=
ents 25A1    1014 PQ: 0 ANSI: 6
Aug 31 19:45:37 caska kernel: sd 4:0:0:0: Attached scsi generic sg1 type 0
Aug 31 19:45:37 caska kernel: sd 4:0:0:0: [sdc] Spinning up disk...
Aug 31 19:45:40 caska kernel: ...ready
Aug 31 19:45:40 caska kernel: sd 4:0:0:0: [sdc] Very big device. Trying to =
use READ CAPACITY(16).
Aug 31 19:45:40 caska kernel: sd 4:0:0:0: [sdc] 7813969920 512-byte logical=
 blocks: (4.00 TB/3.64 TiB)
Aug 31 19:45:40 caska kernel: sd 4:0:0:0: [sdc] 4096-byte physical blocks
Aug 31 19:45:40 caska kernel: sd 4:0:0:0: [sdc] Write Protect is off
Aug 31 19:45:40 caska kernel: sd 4:0:0:0: [sdc] Mode Sense: 47 00 10 08
Aug 31 19:45:40 caska kernel: sd 4:0:0:0: [sdc] No Caching mode page found
Aug 31 19:45:40 caska kernel: sd 4:0:0:0: [sdc] Assuming drive cache: write=
 through
Aug 31 19:45:40 caska kernel:  sdc: sdc1
Aug 31 19:45:40 caska kernel: sd 4:0:0:0: [sdc] Attached SCSI disk
Aug 31 19:48:40 caska kernel: usb 2-1: USB disconnect, device number 5
Aug 31 19:48:57 caska kernel: usb 2-1: new SuperSpeed Gen 1 USB device numb=
er 6 using xhci_hcd
Aug 31 19:48:57 caska kernel: usb 2-1: New USB device found, idVendor=3D105=
8, idProduct=3D25a1, bcdDevice=3D10.14
Aug 31 19:48:57 caska kernel: usb 2-1: New USB device strings: Mfr=3D2, Pro=
duct=3D3, SerialNumber=3D1
Aug 31 19:48:57 caska kernel: usb 2-1: Product: Elements 25A1
Aug 31 19:48:57 caska kernel: usb 2-1: Manufacturer: Western Digital
Aug 31 19:48:57 caska kernel: usb 2-1: SerialNumber: 575853314543374658314C=
38
Aug 31 19:48:57 caska kernel: usb-storage 2-1:1.0: USB Mass Storage device =
detected
Aug 31 19:48:57 caska kernel: scsi host4: usb-storage 2-1:1.0
Aug 31 19:48:58 caska kernel: scsi 4:0:0:0: Direct-Access     WD       Elem=
ents 25A1    1014 PQ: 0 ANSI: 6
Aug 31 19:48:58 caska kernel: sd 4:0:0:0: Attached scsi generic sg1 type 0
Aug 31 19:48:58 caska kernel: sd 4:0:0:0: [sdc] Spinning up disk...
Aug 31 19:49:00 caska kernel: ..
Aug 31 19:49:00 caska kernel: BTRFS info (device dm-0): balance: start -dus=
age=3D100
Aug 31 19:49:00 caska kernel: BTRFS info (device dm-0): relocating block gr=
oup 2248171913216 flags data
Aug 31 19:49:05 caska kernel: .....ready
Aug 31 19:49:05 caska kernel: sd 4:0:0:0: [sdc] Very big device. Trying to =
use READ CAPACITY(16).
Aug 31 19:49:05 caska kernel: sd 4:0:0:0: [sdc] 7813969920 512-byte logical=
 blocks: (4.00 TB/3.64 TiB)
Aug 31 19:49:05 caska kernel: sd 4:0:0:0: [sdc] 4096-byte physical blocks
Aug 31 19:49:05 caska kernel: sd 4:0:0:0: [sdc] Write Protect is off
Aug 31 19:49:05 caska kernel: sd 4:0:0:0: [sdc] Mode Sense: 47 00 10 08
Aug 31 19:49:05 caska kernel: sd 4:0:0:0: [sdc] No Caching mode page found
Aug 31 19:49:05 caska kernel: sd 4:0:0:0: [sdc] Assuming drive cache: write=
 through
Aug 31 19:49:05 caska kernel:  sdc: sdc1
Aug 31 19:49:05 caska kernel: sd 4:0:0:0: [sdc] Attached SCSI disk

[..]

Aug 31 20:04:41 caska kernel: Buffer I/O error on dev dm-1, logical block 1=
28, async page read
Aug 31 20:04:41 caska kernel: Buffer I/O error on dev dm-1, logical block 1=
29, async page read
Aug 31 20:04:41 caska kernel: Buffer I/O error on dev dm-1, logical block 1=
30, async page read
Aug 31 20:04:41 caska kernel: Buffer I/O error on dev dm-1, logical block 1=
31, async page read
Aug 31 20:04:41 caska kernel: Buffer I/O error on dev dm-1, logical block 1=
32, async page read
Aug 31 20:04:41 caska kernel: Buffer I/O error on dev dm-1, logical block 1=
33, async page read
Aug 31 20:04:41 caska kernel: Buffer I/O error on dev dm-1, logical block 1=
34, async page read
Aug 31 20:04:41 caska kernel: Buffer I/O error on dev dm-1, logical block 1=
35, async page read
Aug 31 20:05:08 caska kernel: usb 2-1: USB disconnect, device number 6
Aug 31 20:05:11 caska kernel: usb 2-1: new SuperSpeed Gen 1 USB device numb=
er 7 using xhci_hcd
Aug 31 20:05:11 caska kernel: usb 2-1: New USB device found, idVendor=3D105=
8, idProduct=3D25a1, bcdDevice=3D10.14
Aug 31 20:05:11 caska kernel: usb 2-1: New USB device strings: Mfr=3D2, Pro=
duct=3D3, SerialNumber=3D1
Aug 31 20:05:11 caska kernel: usb 2-1: Product: Elements 25A1
Aug 31 20:05:11 caska kernel: usb 2-1: Manufacturer: Western Digital
Aug 31 20:05:11 caska kernel: usb 2-1: SerialNumber: 575853314543374658314C=
38
Aug 31 20:05:11 caska kernel: usb-storage 2-1:1.0: USB Mass Storage device =
detected
Aug 31 20:05:11 caska kernel: scsi host3: usb-storage 2-1:1.0
Aug 31 20:05:12 caska kernel: scsi 3:0:0:0: Direct-Access     WD       Elem=
ents 25A1    1014 PQ: 0 ANSI: 6
Aug 31 20:05:12 caska kernel: sd 3:0:0:0: Attached scsi generic sg1 type 0
Aug 31 20:05:12 caska kernel: sd 3:0:0:0: [sdb] Spinning up disk...
Aug 31 20:05:14 caska kernel: ..ready
Aug 31 20:05:14 caska kernel: sd 3:0:0:0: [sdb] Very big device. Trying to =
use READ CAPACITY(16).
Aug 31 20:05:14 caska kernel: sd 3:0:0:0: [sdb] 7813969920 512-byte logical=
 blocks: (4.00 TB/3.64 TiB)
Aug 31 20:05:14 caska kernel: sd 3:0:0:0: [sdb] 4096-byte physical blocks
Aug 31 20:05:14 caska kernel: sd 3:0:0:0: [sdb] Write Protect is off
Aug 31 20:05:14 caska kernel: sd 3:0:0:0: [sdb] Mode Sense: 47 00 10 08
Aug 31 20:05:14 caska kernel: sd 3:0:0:0: [sdb] No Caching mode page found
Aug 31 20:05:14 caska kernel: sd 3:0:0:0: [sdb] Assuming drive cache: write=
 through
Aug 31 20:05:14 caska kernel:  sdb: sdb1
Aug 31 20:05:14 caska kernel: sd 3:0:0:0: [sdb] Attached SCSI disk
Aug 31 20:05:28 caska kernel: BTRFS info (device dm-1): disk space caching =
is enabled
Aug 31 20:05:28 caska kernel: BTRFS info (device dm-1): has skinny extents
Aug 31 20:05:29 caska kernel: BTRFS info (device dm-1): bdev /dev/mapper/da=
ta errs: wr 0, rd 0, flush 0, corrupt 304, gen 0
Aug 31 20:05:52 caska kernel: BTRFS info (device dm-1): balance: start -dus=
age=3D100
Aug 31 20:05:52 caska kernel: BTRFS info (device dm-1): relocating block gr=
oup 3978277421056 flags data
Aug 31 20:06:22 caska kernel: BTRFS info (device dm-1): found 8 extents, st=
age: move data extents
Aug 31 20:06:30 caska kernel: BTRFS info (device dm-1): found 8 extents, st=
age: update data pointers
Aug 31 20:06:32 caska kernel: BTRFS info (device dm-1): relocating block gr=
oup 3977203679232 flags data
Aug 31 20:07:09 caska kernel: BTRFS info (device dm-1): found 14 extents, s=
tage: move data extents
Aug 31 20:07:10 caska kernel: BTRFS info (device dm-1): found 14 extents, s=
tage: update data pointers
Aug 31 20:07:10 caska kernel: BTRFS info (device dm-1): relocating block gr=
oup 3976129937408 flags data
Aug 31 20:07:47 caska kernel: BTRFS info (device dm-1): found 12 extents, s=
tage: move data extents
Aug 31 20:07:48 caska kernel: BTRFS info (device dm-1): found 12 extents, s=
tage: update data pointers
Aug 31 20:07:48 caska kernel: BTRFS info (device dm-1): relocating block gr=
oup 3975056195584 flags data
Aug 31 20:08:17 caska kernel: BTRFS info (device dm-1): found 10 extents, s=
tage: move data extents
Aug 31 20:08:17 caska kernel: BTRFS info (device dm-1): found 10 extents, s=
tage: update data pointers
Aug 31 20:08:17 caska kernel: BTRFS info (device dm-1): relocating block gr=
oup 3973982453760 flags data
Aug 31 20:08:38 caska kernel: BTRFS info (device dm-1): found 12 extents, s=
tage: move data extents
Aug 31 20:08:38 caska kernel: BTRFS info (device dm-1): found 12 extents, s=
tage: update data pointers
Aug 31 20:08:39 caska kernel: BTRFS info (device dm-1): relocating block gr=
oup 3972908711936 flags data
Aug 31 20:08:59 caska kernel: BTRFS info (device dm-1): found 12 extents, s=
tage: move data extents
Aug 31 20:08:59 caska kernel: BTRFS info (device dm-1): found 12 extents, s=
tage: update data pointers
Aug 31 20:09:00 caska kernel: BTRFS info (device dm-1): relocating block gr=
oup 3970761228288 flags data
Aug 31 20:09:29 caska kernel: BTRFS info (device dm-1): found 9 extents, st=
age: move data extents
Aug 31 20:09:29 caska kernel: BTRFS info (device dm-1): found 9 extents, st=
age: update data pointers
Aug 31 20:09:30 caska kernel: BTRFS info (device dm-1): relocating block gr=
oup 3968613744640 flags data
Aug 31 20:10:08 caska kernel: BTRFS info (device dm-1): found 10 extents, s=
tage: move data extents
Aug 31 20:10:08 caska kernel: BTRFS info (device dm-1): found 10 extents, s=
tage: update data pointers
Aug 31 20:10:08 caska kernel: BTRFS info (device dm-1): relocating block gr=
oup 3967540002816 flags data
Aug 31 20:10:49 caska kernel: BTRFS info (device dm-1): found 11 extents, s=
tage: move data extents
Aug 31 20:10:49 caska kernel: BTRFS info (device dm-1): found 11 extents, s=
tage: update data pointers
Aug 31 20:10:49 caska kernel: BTRFS info (device dm-1): relocating block gr=
oup 3966466260992 flags data
Aug 31 20:11:28 caska kernel: BTRFS info (device dm-1): found 9 extents, st=
age: move data extents
Aug 31 20:11:28 caska kernel: BTRFS info (device dm-1): found 9 extents, st=
age: update data pointers
Aug 31 20:11:29 caska kernel: BTRFS info (device dm-1): relocating block gr=
oup 3965392519168 flags data
Aug 31 20:12:08 caska kernel: BTRFS info (device dm-1): found 10 extents, s=
tage: move data extents
Aug 31 20:12:08 caska kernel: BTRFS info (device dm-1): found 10 extents, s=
tage: update data pointers
Aug 31 20:12:08 caska kernel: BTRFS info (device dm-1): relocating block gr=
oup 3964318777344 flags data
Aug 31 20:12:49 caska kernel: BTRFS info (device dm-1): found 9 extents, st=
age: move data extents
Aug 31 20:12:49 caska kernel: BTRFS info (device dm-1): found 9 extents, st=
age: update data pointers
Aug 31 20:12:50 caska kernel: BTRFS info (device dm-1): relocating block gr=
oup 3962171293696 flags data
Aug 31 20:13:28 caska kernel: BTRFS info (device dm-1): found 8 extents, st=
age: move data extents
Aug 31 20:13:28 caska kernel: BTRFS info (device dm-1): found 8 extents, st=
age: update data pointers
Aug 31 20:13:29 caska kernel: BTRFS info (device dm-1): relocating block gr=
oup 3960023810048 flags data
Aug 31 20:14:08 caska kernel: BTRFS info (device dm-1): found 10 extents, s=
tage: move data extents
Aug 31 20:14:08 caska kernel: BTRFS info (device dm-1): found 10 extents, s=
tage: update data pointers
Aug 31 20:14:09 caska kernel: BTRFS info (device dm-1): relocating block gr=
oup 3958950068224 flags data
Aug 31 20:14:47 caska kernel: BTRFS info (device dm-1): found 13 extents, s=
tage: move data extents
Aug 31 20:14:47 caska kernel: BTRFS info (device dm-1): found 13 extents, s=
tage: update data pointers
Aug 31 20:14:48 caska kernel: BTRFS info (device dm-1): relocating block gr=
oup 3957876326400 flags data
Aug 31 20:15:27 caska kernel: BTRFS info (device dm-1): found 10 extents, s=
tage: move data extents
Aug 31 20:15:27 caska kernel: BTRFS info (device dm-1): found 10 extents, s=
tage: update data pointers
Aug 31 20:15:28 caska kernel: BTRFS info (device dm-1): relocating block gr=
oup 3956802584576 flags data
Aug 31 20:16:07 caska kernel: BTRFS info (device dm-1): found 10 extents, s=
tage: move data extents
Aug 31 20:16:07 caska kernel: BTRFS info (device dm-1): found 10 extents, s=
tage: update data pointers
Aug 31 20:16:08 caska kernel: BTRFS info (device dm-1): relocating block gr=
oup 3955728842752 flags data
Aug 31 20:16:48 caska kernel: BTRFS info (device dm-1): found 9 extents, st=
age: move data extents
Aug 31 20:16:48 caska kernel: BTRFS info (device dm-1): found 9 extents, st=
age: update data pointers
Aug 31 20:16:49 caska kernel: BTRFS info (device dm-1): relocating block gr=
oup 3954655100928 flags data
Aug 31 20:17:27 caska kernel: BTRFS info (device dm-1): found 8 extents, st=
age: move data extents
Aug 31 20:17:27 caska kernel: BTRFS info (device dm-1): found 8 extents, st=
age: update data pointers
Aug 31 20:17:27 caska kernel: BTRFS info (device dm-1): relocating block gr=
oup 3953581359104 flags data
Aug 31 20:18:07 caska kernel: BTRFS info (device dm-1): found 13 extents, s=
tage: move data extents
Aug 31 20:18:07 caska kernel: BTRFS info (device dm-1): found 13 extents, s=
tage: update data pointers
Aug 31 20:18:07 caska kernel: BTRFS info (device dm-1): relocating block gr=
oup 3952507617280 flags data
Aug 31 20:18:32 caska kernel: usb 2-1: USB disconnect, device number 7
Aug 31 20:18:32 caska kernel: scsi 3:0:0:0: rejecting I/O to dead device
Aug 31 20:18:32 caska kernel: blk_update_request: I/O error, dev sdb, secto=
r 7459659368 op 0x1:(WRITE) flags 0x4800 phys_seg 140 prio class 0
Aug 31 20:18:32 caska kernel: scsi 3:0:0:0: rejecting I/O to dead device
Aug 31 20:18:32 caska kernel: blk_update_request: I/O error, dev sdb, secto=
r 7459661416 op 0x1:(WRITE) flags 0x4800 phys_seg 130 prio class 0
Aug 31 20:18:32 caska kernel: BTRFS error (device dm-1): bdev /dev/mapper/d=
ata errs: wr 1, rd 0, flush 0, corrupt 304, gen 0
Aug 31 20:18:32 caska kernel: BTRFS error (device dm-1): bdev /dev/mapper/d=
ata errs: wr 2, rd 0, flush 0, corrupt 304, gen 0
Aug 31 20:18:32 caska kernel: BTRFS error (device dm-1): bdev /dev/mapper/d=
ata errs: wr 3, rd 0, flush 0, corrupt 304, gen 0
Aug 31 20:18:32 caska kernel: scsi 3:0:0:0: rejecting I/O to dead device
Aug 31 20:18:32 caska kernel: blk_update_request: I/O error, dev sdb, secto=
r 7459663464 op 0x1:(WRITE) flags 0x800 phys_seg 129 prio class 0
Aug 31 20:18:32 caska kernel: BTRFS error (device dm-1): bdev /dev/mapper/d=
ata errs: wr 4, rd 0, flush 0, corrupt 304, gen 0
Aug 31 20:18:32 caska kernel: BTRFS error (device dm-1): bdev /dev/mapper/d=
ata errs: wr 5, rd 0, flush 0, corrupt 304, gen 0
Aug 31 20:18:32 caska kernel: BTRFS error (device dm-1): bdev /dev/mapper/d=
ata errs: wr 6, rd 0, flush 0, corrupt 304, gen 0
Aug 31 20:18:32 caska kernel: BTRFS error (device dm-1): bdev /dev/mapper/d=
ata errs: wr 7, rd 0, flush 0, corrupt 304, gen 0
Aug 31 20:18:32 caska kernel: BTRFS error (device dm-1): bdev /dev/mapper/d=
ata errs: wr 8, rd 0, flush 0, corrupt 304, gen 0
Aug 31 20:18:32 caska kernel: BTRFS error (device dm-1): bdev /dev/mapper/d=
ata errs: wr 9, rd 0, flush 0, corrupt 304, gen 0
Aug 31 20:18:32 caska kernel: BTRFS error (device dm-1): bdev /dev/mapper/d=
ata errs: wr 10, rd 0, flush 0, corrupt 304, gen 0
Aug 31 20:18:32 caska kernel: BTRFS info (device dm-1): balance: ended with=
 status: -5
Aug 31 20:18:32 caska kernel: BTRFS: error (device dm-1) in btrfs_commit_tr=
ansaction:2323: errno=3D-5 IO failure (Error while writing out transaction)
Aug 31 20:18:32 caska kernel: BTRFS info (device dm-1): forced readonly
Aug 31 20:18:33 caska kernel: BTRFS warning (device dm-1): Skipping commit =
of aborted transaction.
Aug 31 20:18:33 caska kernel: BTRFS: error (device dm-1) in cleanup_transac=
tion:1894: errno=3D-5 IO failure
Aug 31 20:18:33 caska kernel: BTRFS: error (device dm-1) in reset_balance_s=
tate:3321: errno=3D-5 IO failure
Aug 31 20:18:40 caska kernel: usb 2-1: new SuperSpeed Gen 1 USB device numb=
er 8 using xhci_hcd
Aug 31 20:18:40 caska kernel: usb 2-1: New USB device found, idVendor=3D105=
8, idProduct=3D25a1, bcdDevice=3D10.14
Aug 31 20:18:40 caska kernel: usb 2-1: New USB device strings: Mfr=3D2, Pro=
duct=3D3, SerialNumber=3D1
Aug 31 20:18:40 caska kernel: usb 2-1: Product: Elements 25A1
Aug 31 20:18:40 caska kernel: usb 2-1: Manufacturer: Western Digital
Aug 31 20:18:40 caska kernel: usb 2-1: SerialNumber: 575853314543374658314C=
38
Aug 31 20:18:40 caska kernel: usb-storage 2-1:1.0: USB Mass Storage device =
detected
Aug 31 20:18:40 caska kernel: scsi host4: usb-storage 2-1:1.0
Aug 31 20:18:41 caska kernel: scsi 4:0:0:0: Direct-Access     WD       Elem=
ents 25A1    1014 PQ: 0 ANSI: 6
Aug 31 20:18:41 caska kernel: sd 4:0:0:0: Attached scsi generic sg1 type 0
Aug 31 20:18:41 caska kernel: sd 4:0:0:0: [sdc] Spinning up disk...
Aug 31 20:18:48 caska kernel: .......ready
Aug 31 20:18:48 caska kernel: sd 4:0:0:0: [sdc] Very big device. Trying to =
use READ CAPACITY(16).
Aug 31 20:18:48 caska kernel: sd 4:0:0:0: [sdc] 7813969920 512-byte logical=
 blocks: (4.00 TB/3.64 TiB)
Aug 31 20:18:48 caska kernel: sd 4:0:0:0: [sdc] 4096-byte physical blocks
Aug 31 20:18:48 caska kernel: sd 4:0:0:0: [sdc] Write Protect is off
Aug 31 20:18:48 caska kernel: sd 4:0:0:0: [sdc] Mode Sense: 47 00 10 08
Aug 31 20:18:48 caska kernel: sd 4:0:0:0: [sdc] No Caching mode page found
Aug 31 20:18:48 caska kernel: sd 4:0:0:0: [sdc] Assuming drive cache: write=
 through
Aug 31 20:18:48 caska kernel:  sdc: sdc1
Aug 31 20:18:48 caska kernel: sd 4:0:0:0: [sdc] Attached SCSI disk
Aug 31 20:18:49 caska kernel: Buffer I/O error on dev dm-1, logical block 1=
28, async page read
Aug 31 20:18:49 caska kernel: Buffer I/O error on dev dm-1, logical block 1=
29, async page read
Aug 31 20:18:49 caska kernel: Buffer I/O error on dev dm-1, logical block 1=
30, async page read
Aug 31 20:18:49 caska kernel: Buffer I/O error on dev dm-1, logical block 1=
31, async page read
Aug 31 20:18:49 caska kernel: Buffer I/O error on dev dm-1, logical block 1=
32, async page read
Aug 31 20:18:49 caska kernel: Buffer I/O error on dev dm-1, logical block 1=
33, async page read
Aug 31 20:18:49 caska kernel: Buffer I/O error on dev dm-1, logical block 1=
34, async page read
Aug 31 20:18:49 caska kernel: Buffer I/O error on dev dm-1, logical block 1=
35, async page read
Aug 31 20:18:59 caska kernel: usb 2-1: USB disconnect, device number 8
Aug 31 20:19:00 caska kernel: usb 2-1: new SuperSpeed Gen 1 USB device numb=
er 9 using xhci_hcd
Aug 31 20:19:00 caska kernel: usb 2-1: New USB device found, idVendor=3D105=
8, idProduct=3D25a1, bcdDevice=3D10.14
Aug 31 20:19:00 caska kernel: usb 2-1: New USB device strings: Mfr=3D2, Pro=
duct=3D3, SerialNumber=3D1
Aug 31 20:19:00 caska kernel: usb 2-1: Product: Elements 25A1
Aug 31 20:19:00 caska kernel: usb 2-1: Manufacturer: Western Digital
Aug 31 20:19:00 caska kernel: usb 2-1: SerialNumber: 575853314543374658314C=
38
Aug 31 20:19:00 caska kernel: usb-storage 2-1:1.0: USB Mass Storage device =
detected
Aug 31 20:19:00 caska kernel: scsi host3: usb-storage 2-1:1.0
Aug 31 20:19:01 caska kernel: scsi 3:0:0:0: Direct-Access     WD       Elem=
ents 25A1    1014 PQ: 0 ANSI: 6
Aug 31 20:19:01 caska kernel: sd 3:0:0:0: Attached scsi generic sg1 type 0
Aug 31 20:19:01 caska kernel: sd 3:0:0:0: [sdb] Spinning up disk...
Aug 31 20:19:05 caska kernel: ....ready
Aug 31 20:19:05 caska kernel: sd 3:0:0:0: [sdb] Very big device. Trying to =
use READ CAPACITY(16).
Aug 31 20:19:05 caska kernel: sd 3:0:0:0: [sdb] 7813969920 512-byte logical=
 blocks: (4.00 TB/3.64 TiB)
Aug 31 20:19:05 caska kernel: sd 3:0:0:0: [sdb] 4096-byte physical blocks
Aug 31 20:19:05 caska kernel: sd 3:0:0:0: [sdb] Write Protect is off
Aug 31 20:19:05 caska kernel: sd 3:0:0:0: [sdb] Mode Sense: 47 00 10 08
Aug 31 20:19:05 caska kernel: sd 3:0:0:0: [sdb] No Caching mode page found
Aug 31 20:19:05 caska kernel: sd 3:0:0:0: [sdb] Assuming drive cache: write=
 through
Aug 31 20:19:05 caska kernel:  sdb: sdb1
Aug 31 20:19:05 caska kernel: sd 3:0:0:0: [sdb] Attached SCSI disk
Aug 31 20:19:14 caska kernel: BTRFS info (device dm-1): disk space caching =
is enabled
Aug 31 20:19:14 caska kernel: BTRFS info (device dm-1): has skinny extents
Aug 31 20:19:14 caska kernel: BTRFS error (device dm-1): bad tree block sta=
rt, want 3972119019520 have 7305823418170705648
Aug 31 20:19:14 caska kernel: BTRFS error (device dm-1): bad tree block sta=
rt, want 3972119019520 have 5982236876204203511
Aug 31 20:19:14 caska kernel: BTRFS warning (device dm-1): failed to read t=
ree root
Aug 31 20:19:14 caska kernel: BTRFS error (device dm-1): open_ctree failed
Aug 31 20:19:54 caska kernel: BTRFS info (device dm-1): disk space caching =
is enabled
Aug 31 20:19:54 caska kernel: BTRFS info (device dm-1): has skinny extents
Aug 31 20:19:54 caska kernel: BTRFS error (device dm-1): bad tree block sta=
rt, want 3972119019520 have 7305823418170705648
Aug 31 20:19:54 caska kernel: BTRFS error (device dm-1): bad tree block sta=
rt, want 3972119019520 have 5982236876204203511
Aug 31 20:19:54 caska kernel: BTRFS warning (device dm-1): failed to read t=
ree root
Aug 31 20:19:54 caska kernel: BTRFS error (device dm-1): open_ctree failed
Aug 31 20:20:05 caska kernel: usb 2-1: USB disconnect, device number 9
Aug 31 20:20:15 caska kernel: usb 2-1: new SuperSpeed Gen 1 USB device numb=
er 10 using xhci_hcd
Aug 31 20:20:15 caska kernel: usb 2-1: New USB device found, idVendor=3D105=
8, idProduct=3D25a1, bcdDevice=3D10.14
Aug 31 20:20:15 caska kernel: usb 2-1: New USB device strings: Mfr=3D2, Pro=
duct=3D3, SerialNumber=3D1
Aug 31 20:20:15 caska kernel: usb 2-1: Product: Elements 25A1
Aug 31 20:20:15 caska kernel: usb 2-1: Manufacturer: Western Digital
Aug 31 20:20:15 caska kernel: usb 2-1: SerialNumber: 575853314543374658314C=
38
Aug 31 20:20:15 caska kernel: usb-storage 2-1:1.0: USB Mass Storage device =
detected
Aug 31 20:20:15 caska kernel: scsi host3: usb-storage 2-1:1.0
Aug 31 20:20:16 caska kernel: scsi 3:0:0:0: Direct-Access     WD       Elem=
ents 25A1    1014 PQ: 0 ANSI: 6
Aug 31 20:20:16 caska kernel: sd 3:0:0:0: Attached scsi generic sg1 type 0
Aug 31 20:20:16 caska kernel: sd 3:0:0:0: [sdb] Spinning up disk...
Aug 31 20:20:24 caska kernel: ........ready
Aug 31 20:20:24 caska kernel: sd 3:0:0:0: [sdb] Very big device. Trying to =
use READ CAPACITY(16).
Aug 31 20:20:24 caska kernel: sd 3:0:0:0: [sdb] 7813969920 512-byte logical=
 blocks: (4.00 TB/3.64 TiB)
Aug 31 20:20:24 caska kernel: sd 3:0:0:0: [sdb] 4096-byte physical blocks
Aug 31 20:20:24 caska kernel: sd 3:0:0:0: [sdb] Write Protect is off
Aug 31 20:20:24 caska kernel: sd 3:0:0:0: [sdb] Mode Sense: 47 00 10 08
Aug 31 20:20:24 caska kernel: sd 3:0:0:0: [sdb] No Caching mode page found
Aug 31 20:20:24 caska kernel: sd 3:0:0:0: [sdb] Assuming drive cache: write=
 through
Aug 31 20:20:24 caska kernel:  sdb: sdb1
Aug 31 20:20:24 caska kernel: sd 3:0:0:0: [sdb] Attached SCSI disk
Aug 31 20:21:59 caska kernel: BTRFS info (device dm-1): disk space caching =
is enabled
Aug 31 20:21:59 caska kernel: BTRFS info (device dm-1): has skinny extents
Aug 31 20:21:59 caska kernel: BTRFS error (device dm-1): bad tree block sta=
rt, want 3972119019520 have 7305823418170705648
Aug 31 20:21:59 caska kernel: BTRFS error (device dm-1): bad tree block sta=
rt, want 3972119019520 have 5982236876204203511
Aug 31 20:21:59 caska kernel: BTRFS warning (device dm-1): failed to read t=
ree root
Aug 31 20:21:59 caska kernel: BTRFS error (device dm-1): open_ctree failed




# smartctl -x /dev/sdb
smartctl 7.1 2019-12-30 r5022 [x86_64-linux-5.8.5-arch1-1] (local build)
Copyright (C) 2002-19, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Family:     Western Digital Elements / My Passport (USB, AF)
Device Model:     WDC WD40NMZW-11GX6S1
Serial Number:    WD-WXS1EC7FX1L8
LU WWN Device Id: 5 0014ee 6b3683dad
Firmware Version: 01.01A01
User Capacity:    4,000,787,030,016 bytes [4.00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    5400 rpm
Form Factor:      2.5 inches
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ACS-3 (minor revision not indicated)
SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Tue Sep  1 17:12:49 2020 CEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
AAM feature is:   Unavailable
APM level is:     128 (minimum power consumption without standby)
Rd look-ahead is: Enabled
Write cache is:   Enabled
DSN feature is:   Unavailable
ATA Security is:  Disabled, NOT FROZEN [SEC1]
Wt Cache Reorder: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00) Offline data collection activity
                                        was never started.
                                        Auto Offline Data Collection: Disab=
led.
Self-test execution status:      (   0) The previous self-test routine comp=
leted
                                        without error or no self-test has e=
ver=20
                                        been run.
Total time to complete Offline=20
data collection:                (20160) seconds.
Offline data collection
capabilities:                    (0x1b) SMART execute Offline immediate.
                                        Auto Offline data collection on/off=
 support.
                                        Suspend Offline collection upon new
                                        command.
                                        Offline surface scan supported.
                                        Self-test supported.
                                        No Conveyance Self-test supported.
                                        No Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                        power-saving mode.
                                        Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                        General Purpose Logging supported.
Short self-test routine=20
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        ( 648) minutes.
SCT capabilities:              (0x30b5) SCT Status supported.
                                        SCT Feature Control supported.
                                        SCT Data Table supported.
SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
  1 Raw_Read_Error_Rate     POSR-K   200   200   051    -    0
  3 Spin_Up_Time            POS--K   253   253   021    -    4341
  4 Start_Stop_Count        -O--CK   100   100   000    -    588
  5 Reallocated_Sector_Ct   PO--CK   200   200   140    -    0
  7 Seek_Error_Rate         -OSR-K   200   200   000    -    0
  9 Power_On_Hours          -O--CK   091   091   000    -    6692
 10 Spin_Retry_Count        -O--CK   100   100   000    -    0
 11 Calibration_Retry_Count -O--CK   100   100   000    -    0
 12 Power_Cycle_Count       -O--CK   100   100   000    -    106
192 Power-Off_Retract_Count -O--CK   200   200   000    -    79
193 Load_Cycle_Count        -O--CK   170   170   000    -    91002
194 Temperature_Celsius     -O---K   128   098   000    -    24
196 Reallocated_Event_Count -O--CK   200   200   000    -    0
197 Current_Pending_Sector  -O--CK   200   200   000    -    0
198 Offline_Uncorrectable   ----CK   100   253   000    -    0
199 UDMA_CRC_Error_Count    -O--CK   200   200   000    -    0
200 Multi_Zone_Error_Rate   ---R--   100   253   000    -    0
                            ||||||_ K auto-keep
                            |||||__ C event count
                            ||||___ R error rate
                            |||____ S speed/performance
                            ||_____ O updated online
                            |______ P prefailure warning

General Purpose Log Directory Version 1
SMART           Log Directory Version 1 [multi-sector log support]
Address    Access  R/W   Size  Description
0x00       GPL,SL  R/O      1  Log Directory
0x01           SL  R/O      1  Summary SMART error log
0x02           SL  R/O      5  Comprehensive SMART error log
0x03       GPL     R/O      6  Ext. Comprehensive SMART error log
0x06           SL  R/O      1  SMART self-test log
0x07       GPL     R/O      1  Extended self-test log
0x09           SL  R/W      1  Selective self-test log
0x10       GPL     R/O      1  NCQ Command Error log
0x11       GPL     R/O      1  SATA Phy Event Counters log
0x24       GPL     R/O    277  Current Device Internal Status Data log
0x30       GPL,SL  R/O      9  IDENTIFY DEVICE data log
0x80-0x9f  GPL,SL  R/W     16  Host vendor specific log
0xa0-0xa7  GPL,SL  VS      16  Device vendor specific log
0xa8-0xb6  GPL,SL  VS       1  Device vendor specific log
0xb7       GPL,SL  VS      81  Device vendor specific log
0xbd       GPL,SL  VS       1  Device vendor specific log
0xc0       GPL,SL  VS       1  Device vendor specific log
0xc1       GPL     VS      93  Device vendor specific log
0xe0       GPL,SL  R/W      1  SCT Command/Status
0xe1       GPL,SL  R/W      1  SCT Data Transfer

SMART Extended Comprehensive Error Log Version: 1 (6 sectors)
No Errors Logged

SMART Extended Self-test Log Version: 1 (1 sectors)
No self-tests have been logged.  [To run self-tests, use: smartctl -t]

Selective Self-tests/Logging not supported

SCT Status Version:                  3
SCT Version (vendor specific):       258 (0x0102)
Device State:                        Active (0)
Current Temperature:                    24 Celsius
Power Cycle Min/Max Temperature:     24/24 Celsius
Lifetime    Min/Max Temperature:     17/55 Celsius
Specified Max Operating Temperature:    39 Celsius
Under/Over Temperature Limit Count:   0/0
Vendor specific:
01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
SCT Temperature History Version:     2
Temperature Sampling Period:         1 minute
Temperature Logging Interval:        1 minute
Min/Max recommended Temperature:      0/60 Celsius
Min/Max Temperature Limit:           -41/85 Celsius
Temperature History Size (Index):    128 (106)

Index    Estimated Time   Temperature Celsius
 107    2020-09-01 15:05    52  *********************************
 ...    ..( 53 skipped).    ..  *********************************
  33    2020-09-01 15:59    52  *********************************
  34    2020-09-01 16:00    51  ********************************
  35    2020-09-01 16:01    50  *******************************
  36    2020-09-01 16:02    50  *******************************
  37    2020-09-01 16:03    49  ******************************
  38    2020-09-01 16:04    49  ******************************
  39    2020-09-01 16:05    49  ******************************
  40    2020-09-01 16:06    48  *****************************
 ...    ..(  3 skipped).    ..  *****************************
  44    2020-09-01 16:10    48  *****************************
  45    2020-09-01 16:11    47  ****************************
 ...    ..(  5 skipped).    ..  ****************************
  51    2020-09-01 16:17    47  ****************************
  52    2020-09-01 16:18     ?  -
  53    2020-09-01 16:19    46  ***************************
  54    2020-09-01 16:20     ?  -
  55    2020-09-01 16:21    34  ***************
 ...    ..( 28 skipped).    ..  ***************
  84    2020-09-01 16:50    34  ***************
  85    2020-09-01 16:51     ?  -
  86    2020-09-01 16:52    32  *************
  87    2020-09-01 16:53     ?  -
  88    2020-09-01 16:54    32  *************
  89    2020-09-01 16:55     ?  -
  90    2020-09-01 16:56    33  **************
  91    2020-09-01 16:57     ?  -
  92    2020-09-01 16:58    32  *************
 ...    ..( 10 skipped).    ..  *************
 103    2020-09-01 17:09    32  *************
 104    2020-09-01 17:10    33  **************
 105    2020-09-01 17:11     ?  -
 106    2020-09-01 17:12    24  *****

SCT Error Recovery Control command not supported

Device Statistics (GP/SMART Log 0x04) not supported

Pending Defects log (GP Log 0x0c) not supported

SATA Phy Event Counters (GP Log 0x11)
ID      Size     Value  Description
0x0001  2            0  Command failed due to ICRC error
0x0002  2            0  R_ERR response for data FIS
0x0003  2            0  R_ERR response for device-to-host data FIS
0x0004  2            0  R_ERR response for host-to-device data FIS
0x0005  2            0  R_ERR response for non-data FIS
0x0006  2            0  R_ERR response for device-to-host non-data FIS
0x0007  2            0  R_ERR response for host-to-device non-data FIS
0x0008  2            0  Device-to-host non-data FIS retries
0x0009  2            0  Transition from drive PhyRdy to drive PhyNRdy
0x000a  2            1  Device-to-host register FISes sent due to a COMRESET
0x000b  2            0  CRC errors within host-to-device FIS
0x000d  2            0  Non-CRC errors within host-to-device FIS
0x000f  2            0  R_ERR response for host-to-device data FIS, CRC
0x0012  2            0  R_ERR response for host-to-device non-data FIS, CRC
0x8000  4            9  Vendor specific

--=20
Maxime =E2=80=9Cpep=E2=80=9D Buquet

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEhA/T3MqZjUNP0hVd3tp0ruyp0PIFAl9OaPYACgkQ3tp0ruyp
0PIUPQ//Sx0UkyqIds2KmyD+eaB5zFIDNzl13LJ025x1pgV/zE5A2ZCcyJ9TKUQl
Du6BaZ1qr8772x3ohsgXuTkfO9QF69A1f843kQ/AK+nrk4U144zhfrOTQqEGqs0O
UcgOqj5mTPKkGvMe0S6UPRrplTmYrlKZDux0L9deK0sTmPzX9pN2gbyyVRJ+usc/
nN1gn1MjHtdjU2EOrkKGMOAxSLKIK2WeZ93BGSC5W8zKxg7/ctqRRjXUmObDC/0b
0Oxfa1UwRPsiHVFvwa2ubQFXN0fJNdvXkQQ0ItIRVm21Zezk39EL52TlhirAKazv
fwypr1v/LwmijXv/eTmFGX/qh/dldvOn9APfkjPLORoqQyOU2L6ALIRTsgUJP/JF
Cdyo3US3sezJBA9g4ESDcr90zbF7FSZNDFOE6qpXnBz7wwNLAz3VWLKxxOZ1gnRX
5go9M8RkZWSUDZX1aT/tY4WI+5TJZVtLzU+9RbmHnx3Xl5MLKp4NOxl9PqislX0o
B5kvma2mpjDX8XmdpgQsW1sYqLFjrfM5Wqtw2MdS6dP/8S2EyjbadxlSGVQpPjjr
d+K501894qTl020/EfvpnG4Ex0xISm6tsUwI5ztGgk9uIllNEptOKdvWU7USzUo0
o0K+6GVsGy3v8zWBEOEIwtFPijlaSHFtjRm+hz+ybVpskr3n1nk=
=l2VF
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
