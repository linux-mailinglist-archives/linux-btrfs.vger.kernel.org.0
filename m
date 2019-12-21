Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 769B612895D
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2019 15:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfLUOGH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Dec 2019 09:06:07 -0500
Received: from mout.gmx.net ([212.227.17.20]:55941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbfLUOGH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Dec 2019 09:06:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576937163;
        bh=gCApY3FQxlcUS9rYiM7xEkfCH0ZB7DqpLF9xVIGMKxI=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=cFleuRkhBhwCBP85lp/Te2m5/puhXqSRPtUtxL21ln0vcSkw/A8uZZtxR1KlHDdUQ
         eo2ZqM5hG7S6a3ShAf8pA7Xu7HisKeQglxE+DYoqlr0rK8xP6ekjkKkjCHRNdec7AX
         Jt/2Dxe4UYzI9P8V4KV9bYIifeZS4qWfmrr9SNLY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.0.8.1] ([91.17.252.101]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Msq24-1hpssU3Zge-00tDm9 for
 <linux-btrfs@vger.kernel.org>; Sat, 21 Dec 2019 15:06:03 +0100
Date:   Sat, 21 Dec 2019 15:06:00 +0100
From:   jollemeyer@gmx.de
To:     linux-btrfs@vger.kernel.org
Message-ID: <af9d16c9-2bf5-46fa-a146-84c4f8f6cc31.maildroid@localhost>
Subject: read time block corruption on root partition, Not booting
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: MailDroid/4.91 (Android 9)
User-Agent: MailDroid/4.91 (Android 9)
X-Provags-ID: V03:K1:Hy2Py7gu4swOJ+G2j08FcdDS6yOMP/UPIXFDUJ3d8HUpAGv98R9
 nClRkgckoE8o9Abkekg/dstoF2NXWcE8x9d1N6tVqot6VPHAo57G1Afm122NZG334KnBh41
 taANOc04HWERBqGqoCgzbCEh3pn5ip4Q81dSAUmPB+r5Y0JZMsuDKDJGwSN9ha1mSCbw4uj
 IzBOCW50qLzfFCGRCDX1Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wHWnFrQJb3g=:/ojyVqF2NZTP+FVeUJO6c5
 z1Nw5py+Rjpv6bWF3ihocPnsQJH0cpq0rO77eLyRDKDfxE9XDJiblAe802L2vMIFL5EJnLB1t
 PK6BCBLBFOGkfSkOHG76ZRJ//Bxe+qhAoCqtHEOYkqJvpoHr2A1EPjo+3mFsPML+OEF4UqJNK
 WHSSvw/dqT7w/Hljn2Lfijjm4JAYZYogCvddtfzGTrVna999EkVUin2vggdnUKu9zOHc0dNT+
 SWMbTVtFI08QFMeWt4QvjcntrA+GH8WC1zzLtd4liHdywvoILvtqkv5DwdStBPGfoTCVBkcsh
 VfCdcApltx9H2pQ08XP7sTUc3cRpNF6g3jf9SJMLDBox/QZ38ATDDsA3bbmHt6vh2o7SbKdMt
 81ginoQhF+Vm6u5QAv8wgtODyW2cURslC04LZ6/0xpI521OJaZn6nEmKEsBBTBJ2SoM6i+kDb
 RoJmkQZpNjXkKPWiXD8tKJZ7v2d7Pvfss/fv1HAEY3afWq6PoIqqLNBgWKFHkVtYIExbOr67C
 gNS9TD4FIo6NXWxp/pao9Tz2PkHGkPN54g06Ru7kyfgVKxtE3IZKayUNhbwy5WFzOtaR7FZId
 BolLf3zaeoSyaxS+hx4RVuZ0+ymNqMdqTR+pAYMCIeNlMaDo87iYBTuWC7R83G7zi0PlW7OKi
 50D3tKRIEuzxWPyJcmlr9eQp0C839u1MPF4wY/HafkS4vlJ7vfM5vl2cfClwprGdzgK8Es+DQ
 YhpEdOudATqDEcnhL7RzDERcIm5ANJ+il7I50wI8tKu/1u0vHAYrVc3dC3671JWJzRdDPtnji
 4AegGcGqurBTJ9dxSt0JqjC6IJ74RGOVDPDyNwvHw4owgug7quz9mIbWaIH7HBFbBxdAquJHz
 jPUK5eC54tZ/UO4HsUKRkK3cLeCLrQEpQqUJbupk7JD8witBqLAV5RNisv2DPTDZ8b96sYNyU
 YJiDqpY0pWTK2gPkCmbq1NoxgEMEJqmM10JKnxzNeHWcSS3NMYHZuSRFEW/+B/aej+uRs9mee
 TLPIhdzGkVdZfJY9bPuTU+lQfEkfE0JFHLDQKa2/h7vA42TudYNd74SPRbeYac36fOf4ZHZax
 maXc4IJD6FOXtV9HmiUdK3dsFTpH9XnI2gk2Bm1SCX+BJH6auEGnQ5g/FnwVesYxlpPUIJAdn
 7jtCEQU8VuIyJWS3PJBeaBf9rAy2al+oLd2HUFBQmFSXsFvynAnRosHHN3Ig0TuqtYTe6uwWE
 fooQqqCKLbT5mxzgQc1Vxc/mVtjYMqvELkBAg54S8CFgKC5DBO4EPola8r58=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear all,
=20
on my BTRFS root partition (/dev/sda), a "read time block corruption" was d=
etected. The system refuses to boot.
Current kernel is 5.4.2-1-Manjaro.
=20
Systemd's journalctl generated the following output:
=20
Dez 21 10:46:41 Phoenix kernel: BTRFS critical (device sda): corrupt leaf: =
block=3D2089035464704 slot=3D85 extent bytenr=3D1937096425472 len=3D4096 in=
valid extent refs, have 1 expect >=3D inline 1048577
Dez 21 10:46:41 Phoenix kernel: BTRFS error (device sda): block=3D208903546=
4704 read time tree block corruption detected
Dez 21 10:46:41 Phoenix kernel: BTRFS critical (device sda): corrupt leaf: =
block=3D2089035464704 slot=3D85 extent bytenr=3D1937096425472 len=3D4096 in=
valid extent refs, have 1 expect >=3D inline 1048577
Dez 21 10:46:41 Phoenix kernel: BTRFS error (device sda): block=3D208903546=
4704 read time tree block corruption detected
Dez 21 10:46:41 Phoenix kernel: BTRFS critical (device sda): corrupt leaf: =
block=3D2089035464704 slot=3D85 extent bytenr=3D1937096425472 len=3D4096 in=
valid extent refs, have 1 expect >=3D inline 1048577
Dez 21 10:46:41 Phoenix kernel: BTRFS error (device sda): block=3D208903546=
4704 read time tree block corruption detected
Dez 21 10:46:41 Phoenix kernel: BTRFS critical (device sda): corrupt leaf: =
block=3D2089035464704 slot=3D85 extent bytenr=3D1937096425472 len=3D4096 in=
valid extent refs, have 1 expect >=3D inline 1048577
Dez 21 10:46:41 Phoenix kernel: BTRFS error (device sda): block=3D208903546=
4704 read time tree block corruption detected
Dez 21 10:46:41 Phoenix kernel: BTRFS: error (device sda) in btrfs_replay_l=
og:2293: errno=3D-5 IO failure (Failed to recover log tree)
Dez 21 10:46:41 Phoenix kernel: ------------[ cut here ]------------
Dez 21 10:46:41 Phoenix kernel: WARNING: CPU: 7 PID: 621 at fs/btrfs/block-=
group.c:132 btrfs_put_block_group+0x42/0x50 [btrfs]
Dez 21 10:46:41 Phoenix kernel: Modules linked in: usblp snd_hda_codec_hdmi=
 intel_rapl_msr snd_hda_codec_realtek intel_rapl_common snd_hda_codec_gener=
ic ext4 ledtrig_audio x86_pkg_temp_thermal intel_powerclamp coretemp crc16 =
kvm_intel mbcache i915 jbd2 kvm snd_hda_intel snd_intel_nhlt i2c_algo_bit i=
rqbypass drm_kms_helper snd_hda_codec crct10dif_pclmul crc32_pclmul snd_hda=
_core mousedev ghash_clmulni_intel drm snd_hwdep snd_pcm aesni_intel crypto=
_simd cryptd glue_helper mei_hdcp intel_cstate iTCO_wdt intel_gtt snd_timer=
 iTCO_vendor_support intel_uncore mei_me intel_rapl_perf input_leds agpgart=
 i2c_i801 snd syscopyarea mei sysfillrect lpc_ich r8168(OE) sysimgblt sound=
core fb_sys_fops evdev ie31200_edac mac_hid vboxpci(OE) vboxnetflt(OE) vbox=
netadp(OE) vboxdrv(OE) sg crypto_user ip_tables x_tables hid_generic usbhid=
 hid btrfs libcrc32c crc32c_generic xor uas usb_storage raid6_pq sr_mod cdr=
om sd_mod ahci serio_raw atkbd libahci libps2 libata xhci_pci scsi_mod xhci=
_hcd ehci_pci crc32c_intel ehci_hcd i8042 serio
Dez 21 10:46:41 Phoenix kernel: CPU: 7 PID: 621 Comm: mount Tainted: G     =
      OE     5.4.2-1-MANJARO #1
Dez 21 10:46:41 Phoenix kernel: Hardware name: To Be Filled By O.E.M. To Be=
 Filled By O.E.M./H77 Pro4/MVP, BIOS P1.40 09/04/2012
Dez 21 10:46:41 Phoenix kernel: RIP: 0010:btrfs_put_block_group+0x42/0x50 [=
btrfs]
Dez 21 10:46:41 Phoenix kernel: Code: 2d 48 83 7d 50 00 75 22 48 8b 85 e8 0=
1 00 00 48 85 c0 75 1e 48 8b bd d8 00 00 00 e8 a8 08 66 d9 48 89 ef 5d e9 9=
f 08 66 d9 c3 <0f> 0b eb da 0f 0b eb cf 0f 0b eb de 66 90 0f 1f 44 00 00 31=
 d2 e9
Dez 21 10:46:41 Phoenix kernel: RSP: 0018:ffffa95900f47ae8 EFLAGS: 00010206
Dez 21 10:46:41 Phoenix kernel: RAX: 0000000000000001 RBX: ffff8a1eb7bfe0e0=
 RCX: 0000000000000000
Dez 21 10:46:41 Phoenix kernel: RDX: 0000000000000001 RSI: ffff8a1ecf5f0250=
 RDI: ffff8a1eb7bfe000
Dez 21 10:46:41 Phoenix kernel: RBP: ffff8a1eb7bfe000 R08: 0000000000000000=
 R09: 0000000000000001
Dez 21 10:46:41 Phoenix kernel: R10: 00000000003f6c00 R11: 0000000000000000=
 R12: ffff8a1ec81b0080
Dez 21 10:46:41 Phoenix kernel: R13: ffff8a1ec81b0090 R14: ffff8a1eb7bfe000=
 R15: dead000000000100
Dez 21 10:46:41 Phoenix kernel: FS:  00007f77003d7500(0000) GS:ffff8a1ecf5c=
0000(0000) knlGS:0000000000000000
Dez 21 10:46:41 Phoenix kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
Dez 21 10:46:41 Phoenix kernel: CR2: 0000559652364460 CR3: 00000003fbaec005=
 CR4: 00000000001606e0
Dez 21 10:46:41 Phoenix kernel: Call Trace:
Dez 21 10:46:41 Phoenix kernel:  btrfs_free_block_groups+0x11c/0x260 [btrfs=
]
Dez 21 10:46:41 Phoenix kernel:  open_ctree+0x187a/0x1bc0 [btrfs]
Dez 21 10:46:41 Phoenix kernel:  btrfs_mount_root+0x57b/0x670 [btrfs]
Dez 21 10:46:41 Phoenix kernel:  legacy_get_tree+0x27/0x40
Dez 21 10:46:41 Phoenix kernel:  vfs_get_tree+0x25/0xb0
Dez 21 10:46:41 Phoenix kernel:  fc_mount+0xe/0x30
Dez 21 10:46:41 Phoenix kernel:  vfs_kern_mount.part.0+0x71/0x90
Dez 21 10:46:41 Phoenix kernel:  btrfs_mount+0x18e/0x930 [btrfs]
Dez 21 10:46:41 Phoenix kernel:  ? filename_lookup+0x105/0x190
Dez 21 10:46:41 Phoenix kernel:  ? legacy_get_tree+0x27/0x40
Dez 21 10:46:41 Phoenix kernel:  ? btrfs_remount+0x4d0/0x4d0 [btrfs]
Dez 21 10:46:41 Phoenix kernel:  legacy_get_tree+0x27/0x40
Dez 21 10:46:41 Phoenix kernel:  vfs_get_tree+0x25/0xb0
Dez 21 10:46:41 Phoenix kernel:  do_mount+0x77a/0xa30
Dez 21 10:46:41 Phoenix kernel:  ksys_mount+0x7e/0xc0
Dez 21 10:46:41 Phoenix kernel:  __x64_sys_mount+0x21/0x30
Dez 21 10:46:41 Phoenix kernel:  do_syscall_64+0x4e/0x140
Dez 21 10:46:41 Phoenix kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Dez 21 10:46:41 Phoenix kernel: RIP: 0033:0x7f770055ae4e
Dez 21 10:46:41 Phoenix kernel: Code: 48 8b 0d 35 00 0c 00 f7 d8 64 89 01 4=
8 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 0=
0 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 02 00 0c 00 f7 d8 64 89=
 01 48
Dez 21 10:46:41 Phoenix kernel: RSP: 002b:00007ffedb3135c8 EFLAGS: 00000246=
 ORIG_RAX: 00000000000000a5
Dez 21 10:46:41 Phoenix kernel: RAX: ffffffffffffffda RBX: 00007f7700681204=
 RCX: 00007f770055ae4e
Dez 21 10:46:41 Phoenix kernel: RDX: 000055d9705f5650 RSI: 000055d9705f56f0=
 RDI: 000055d9705f73d0
Dez 21 10:46:41 Phoenix kernel: RBP: 000055d9705f5440 R08: 000055d9705f5670=
 R09: 0000000000000000
Dez 21 10:46:41 Phoenix kernel: R10: 0000000000000000 R11: 0000000000000246=
 R12: 0000000000000000
Dez 21 10:46:41 Phoenix kernel: R13: 000055d9705f73d0 R14: 000055d9705f5650=
 R15: 000055d9705f5440
Dez 21 10:46:41 Phoenix kernel: ---[ end trace 71465d442bb4c509 ]---
Dez 21 10:46:41 Phoenix kernel: ------------[ cut here ]------------
Dez 21 10:46:41 Phoenix kernel: WARNING: CPU: 0 PID: 621 at fs/btrfs/block-=
group.c:3166 btrfs_free_block_groups+0x1ea/0x260 [btrfs]
Dez 21 10:46:41 Phoenix kernel: Modules linked in: usblp snd_hda_codec_hdmi=
 intel_rapl_msr snd_hda_codec_realtek intel_rapl_common snd_hda_codec_gener=
ic ext4 ledtrig_audio x86_pkg_temp_thermal intel_powerclamp coretemp crc16 =
kvm_intel mbcache i915 jbd2 kvm snd_hda_intel snd_intel_nhlt i2c_algo_bit i=
rqbypass drm_kms_helper snd_hda_codec crct10dif_pclmul crc32_pclmul snd_hda=
_core mousedev ghash_clmulni_intel drm snd_hwdep snd_pcm aesni_intel crypto=
_simd cryptd glue_helper mei_hdcp intel_cstate iTCO_wdt intel_gtt snd_timer=
 iTCO_vendor_support intel_uncore mei_me intel_rapl_perf input_leds agpgart=
 i2c_i801 snd syscopyarea mei sysfillrect lpc_ich r8168(OE) sysimgblt sound=
core fb_sys_fops evdev ie31200_edac mac_hid vboxpci(OE) vboxnetflt(OE) vbox=
netadp(OE) vboxdrv(OE) sg crypto_user ip_tables x_tables hid_generic usbhid=
 hid btrfs libcrc32c crc32c_generic xor uas usb_storage raid6_pq sr_mod cdr=
om sd_mod ahci serio_raw atkbd libahci libps2 libata xhci_pci scsi_mod xhci=
_hcd ehci_pci crc32c_intel ehci_hcd i8042 serio
Dez 21 10:46:41 Phoenix kernel: CPU: 0 PID: 621 Comm: mount Tainted: G     =
   W  OE     5.4.2-1-MANJARO #1
Dez 21 10:46:41 Phoenix kernel: Hardware name: To Be Filled By O.E.M. To Be=
 Filled By O.E.M./H77 Pro4/MVP, BIOS P1.40 09/04/2012
Dez 21 10:46:41 Phoenix kernel: RIP: 0010:btrfs_free_block_groups+0x1ea/0x2=
60 [btrfs]
Dez 21 10:46:41 Phoenix kernel: Code: 49 bd 22 01 00 00 00 00 ad de e8 51 1=
3 d1 d9 e8 0c d3 4e d9 48 89 ef e8 64 9b ff ff 48 8b 85 00 10 00 00 49 39 c=
4 75 3c eb 5f <0f> 0b 31 c9 31 d2 4c 89 fe 48 89 ef e8 55 85 ff ff 48 8b 43=
 08 48
Dez 21 10:46:41 Phoenix kernel: RSP: 0018:ffffa95900f47af8 EFLAGS: 00010206
Dez 21 10:46:41 Phoenix kernel: RAX: ffff8a1eca367488 RBX: ffff8a1eca367488=
 RCX: 0000000000000000
Dez 21 10:46:41 Phoenix kernel: RDX: 0000000000000001 RSI: ffff8a1eca364200=
 RDI: 00000000ffffffff
Dez 21 10:46:41 Phoenix kernel: RBP: ffff8a1ec81b0000 R08: 0000000000000000=
 R09: 0000000020000000
Dez 21 10:46:41 Phoenix kernel: R10: 0000000000000005 R11: ffffffffffd5ce37=
 R12: ffff8a1ec81b1000
Dez 21 10:46:41 Phoenix kernel: R13: dead000000000122 R14: dead000000000100=
 R15: ffff8a1eca367400
Dez 21 10:46:41 Phoenix kernel: FS:  00007f77003d7500(0000) GS:ffff8a1ecf40=
0000(0000) knlGS:0000000000000000
Dez 21 10:46:41 Phoenix kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
Dez 21 10:46:41 Phoenix kernel: CR2: 0000559006e55d68 CR3: 00000003fbaec006=
 CR4: 00000000001606f0
Dez 21 10:46:41 Phoenix kernel: Call Trace:
Dez 21 10:46:41 Phoenix kernel:  open_ctree+0x187a/0x1bc0 [btrfs]
Dez 21 10:46:41 Phoenix kernel:  btrfs_mount_root+0x57b/0x670 [btrfs]
Dez 21 10:46:41 Phoenix kernel:  legacy_get_tree+0x27/0x40
Dez 21 10:46:41 Phoenix kernel:  vfs_get_tree+0x25/0xb0
Dez 21 10:46:41 Phoenix kernel:  fc_mount+0xe/0x30
Dez 21 10:46:41 Phoenix kernel:  vfs_kern_mount.part.0+0x71/0x90
Dez 21 10:46:41 Phoenix kernel:  btrfs_mount+0x18e/0x930 [btrfs]
Dez 21 10:46:41 Phoenix kernel:  ? filename_lookup+0x105/0x190
Dez 21 10:46:41 Phoenix kernel:  ? legacy_get_tree+0x27/0x40
Dez 21 10:46:41 Phoenix kernel:  ? btrfs_remount+0x4d0/0x4d0 [btrfs]
Dez 21 10:46:41 Phoenix kernel:  legacy_get_tree+0x27/0x40
Dez 21 10:46:41 Phoenix kernel:  vfs_get_tree+0x25/0xb0
Dez 21 10:46:41 Phoenix kernel:  do_mount+0x77a/0xa30
Dez 21 10:46:41 Phoenix kernel:  ksys_mount+0x7e/0xc0
Dez 21 10:46:41 Phoenix kernel:  __x64_sys_mount+0x21/0x30
Dez 21 10:46:41 Phoenix kernel:  do_syscall_64+0x4e/0x140
Dez 21 10:46:41 Phoenix kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Dez 21 10:46:41 Phoenix kernel: RIP: 0033:0x7f770055ae4e
Dez 21 10:46:41 Phoenix kernel: Code: 48 8b 0d 35 00 0c 00 f7 d8 64 89 01 4=
8 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 0=
0 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 02 00 0c 00 f7 d8 64 89=
 01 48
Dez 21 10:46:41 Phoenix kernel: RSP: 002b:00007ffedb3135c8 EFLAGS: 00000246=
 ORIG_RAX: 00000000000000a5
Dez 21 10:46:41 Phoenix kernel: RAX: ffffffffffffffda RBX: 00007f7700681204=
 RCX: 00007f770055ae4e
Dez 21 10:46:41 Phoenix kernel: RDX: 000055d9705f5650 RSI: 000055d9705f56f0=
 RDI: 000055d9705f73d0
Dez 21 10:46:41 Phoenix kernel: RBP: 000055d9705f5440 R08: 000055d9705f5670=
 R09: 0000000000000000
Dez 21 10:46:41 Phoenix kernel: R10: 0000000000000000 R11: 0000000000000246=
 R12: 0000000000000000
Dez 21 10:46:41 Phoenix kernel: R13: 000055d9705f73d0 R14: 000055d9705f5650=
 R15: 000055d9705f5440
Dez 21 10:46:41 Phoenix kernel: ---[ end trace 71465d442bb4c50a ]---
Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda): space_info 1 has 7=
33175808 free, is not full
Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda): space_info total=
=3D1386200694784, used=3D1385467318272, pinned=3D0, reserved=3D4096, may_us=
e=3D0, readonly=3D196608
Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda): global_block_rsv: =
size 0 reserved 0
Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda): trans_block_rsv: s=
ize 0 reserved 0
Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda): chunk_block_rsv: s=
ize 0 reserved 0
Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda): delayed_block_rsv:=
 size 0 reserved 0
Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda): delayed_refs_rsv: =
size 0 reserved 0
Dez 21 10:46:41 Phoenix kernel: BTRFS error (device sda): open_ctree failed
-- Subject: Unit process exited
-- Defined-By: systemd
=20
Btrfs check --readonly /dev/sda also found errors:
=20
Opening filesystem to check...
Checking filesystem on /dev/sda
UUID: 014bdf0a-bcb3-4a7c-b58d-c1fc17281f7e
found 1386975199232 bytes used, error(s) found
total csum bytes: 1352697008
total tree bytes: 1508327424
total fs tree bytes: 61161472
total extent tree bytes: 37421056
btree space waste bytes: 55303865
file data blocks allocated: 1388605296640
 referenced 1385670742016
=20
Btrfs scrub does not recognize any errors.
=20
Kindly help me to recover this error.
=20
many thanks,
=20
J=C3=B6rg Meyer
=20
