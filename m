Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D3E2F94CA
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Jan 2021 20:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbhAQTE6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 17 Jan 2021 14:04:58 -0500
Received: from mail.eclipso.de ([217.69.254.104]:38238 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729868AbhAQTD5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jan 2021 14:03:57 -0500
Received: from mail.eclipso.de (www1.eclipso.de [217.69.254.102])
        by mail.eclipso.de with ESMTP id 2B18E644
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jan 2021 20:02:41 +0100 (CET)
Date:   Sun, 17 Jan 2021 20:02:41 +0100
MIME-Version: 1.0
Message-ID: <dbdc13b2ab6379b793586b7886fea027@mail.eclipso.de>
X-Mailer: eclipso / 7.4.0
From:   " " <Cedric.dewijs@eclipso.eu>
Subject: btrfs doesn't understand a drive moving from one sata port to another
        during suspend
Reply-To: " " <Cedric.dewijs@eclipso.eu>
To:     "linux-btrfs" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

­I've moved a drive to a different sata controller during a suspend. Btrfs does not understand that. I had to give the filesystem a new uuid before I could access it again. Is there some setting in the kernel so it can deal with this? 

Initial mounting of the btrfs partition:
[199167.697831] BTRFS info (device sdc1): disk space caching is enabled
[199167.697835] BTRFS info (device sdc1): has skinny extents
[199167.697838] BTRFS info (device sdc1): flagging fs with big metadata feature
[199167.708160] BTRFS info (device sdc1): checking UUID tree

Suspend the system:
[200353.483856] PM: suspend entry (deep)
[200354.106728] Filesystems sync: 0.622 seconds
[200354.107073] Freezing user space processes ... (elapsed 0.008 seconds) done.
[200354.115993] OOM killer disabled.
[200354.115994] Freezing remaining freezable tasks ... (elapsed 1.300 seconds) done.
[200355.416151] printk: Suspending console(s) (use no_console_suspend to debug)
[200355.417143] snd_hdac_bus_update_rirb: 59 callbacks suppressed
[200355.417153] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0x620000
[200355.417158] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0x620000
[200355.418087] serial 00:08: disabled
[200355.418916] r8169 0000:04:00.0 enp4s0: Link is Down
[200355.432383] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0x1f0500
[200355.432389] snd_hda_intel 0000:01:00.1: spurious response 0x233:0x0, last cmd=0x1f0500
[200355.435758] sd 2:0:0:0: [sda] Synchronizing SCSI cache
[200355.435817] sd 4:0:0:0: [sdb] Synchronizing SCSI cache
[200355.435984] sd 4:0:0:0: [sdb] Stopping disk
[200355.436457] sd 2:0:0:0: [sda] Stopping disk
[200358.367463] ACPI: Preparing to enter system sleep state S3
[200358.986393] PM: Saving platform NVS memory
[200358.986523] Disabling non-boot CPUs ...
[200358.990521] smpboot: CPU 1 is now offline
[200358.993159] smpboot: CPU 2 is now offline
[200358.996959] smpboot: CPU 3 is now offline
[200358.999283] smpboot: CPU 4 is now offline
[200359.002968] smpboot: CPU 5 is now offline
[200359.007251] smpboot: CPU 6 is now offline
[200359.009456] smpboot: CPU 7 is now offline

Wake the system:
200359.012955] ACPI: Low-level resume complete
[200359.012990] PM: Restoring platform NVS memory
[200359.013078] PCI-DMA: Resuming GART IOMMU
[200359.013078] PCI-DMA: Restoring GART aperture settings
[200359.013083] LVT offset 0 assigned for vector 0x400
[200359.019869] microcode: CPU0: new patch_level=0x06000852
[200359.020013] Enabling non-boot CPUs ...
[200359.020077] x86: Booting SMP configuration:
[200359.020078] smpboot: Booting Node 0 Processor 1 APIC 0x11
[200359.020913] microcode: CPU1: patch_level=0x06000852
[200359.023159] ACPI: \_PR_.P002: Found 2 idle states
[200359.023459] CPU1 is up
[200359.023520] smpboot: Booting Node 0 Processor 2 APIC 0x12
[200359.025237] microcode: CPU2: patch_level=0x06000817
[200359.041657] microcode: CPU2: new patch_level=0x06000852
[200359.044132] ACPI: \_PR_.P003: Found 2 idle states
[200359.044663] CPU2 is up
[200359.044707] smpboot: Booting Node 0 Processor 3 APIC 0x13
[200359.046801] microcode: CPU3: patch_level=0x06000852
[200359.049258] ACPI: \_PR_.P004: Found 2 idle states
[200359.049845] CPU3 is up
[200359.049913] smpboot: Booting Node 0 Processor 4 APIC 0x14
[200359.051632] microcode: CPU4: patch_level=0x06000817
[200359.068100] microcode: CPU4: new patch_level=0x06000852
[200359.070587] ACPI: \_PR_.P005: Found 2 idle states
[200359.071210] CPU4 is up
[200359.071269] smpboot: Booting Node 0 Processor 5 APIC 0x15
[200359.073363] microcode: CPU5: patch_level=0x06000852
[200359.075833] ACPI: \_PR_.P006: Found 2 idle states
[200359.076504] CPU5 is up
[200359.076567] smpboot: Booting Node 0 Processor 6 APIC 0x16
[200359.078287] microcode: CPU6: patch_level=0x06000817
[200359.094806] microcode: CPU6: new patch_level=0x06000852
[200359.097301] ACPI: \_PR_.P007: Found 2 idle states
[200359.098030] CPU6 is up
[200359.098091] smpboot: Booting Node 0 Processor 7 APIC 0x17
[200359.100187] microcode: CPU7: patch_level=0x06000852
[200359.102688] ACPI: \_PR_.P008: Found 2 idle states
[200359.103465] CPU7 is up
[200359.127094] ACPI: Waking up from system sleep state S3
[200359.128297] ahci 0000:00:11.0: set SATA to AHCI mode
[200359.166239] sd 2:0:0:0: [sda] Starting disk
[200359.166298] sd 4:0:0:0: [sdb] Starting disk
[200359.168414] serial 00:08: activated
[200359.283537] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
[200359.334134] ata5.00: ACPI cmd ef/03:08:00:00:00:a0 (SET FEATURES) filtered out
[200359.334140] ata5.00: ACPI cmd ef/03:20:00:00:00:a0 (SET FEATURES) filtered out
[200359.334144] ata5.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[200359.380448] r8169 0000:04:00.0 enp4s0: Link is Down
[200359.475882] ata1: SATA link down (SStatus 0 SControl 300)
[200359.475911] ata4: SATA link down (SStatus 0 SControl 300)
[200359.632066] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[200359.633575] ata3.00: configured for UDMA/133
[200359.948719] [drm] Fence fallback timer expired on ring sdma0
[200360.455386] [drm] Fence fallback timer expired on ring sdma0
[200360.503548] [drm] UVD and UVD ENC initialized successfully.
[200360.614537] [drm] VCE initialized successfully.
[200360.620701] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0x370740
[200360.620707] snd_hda_intel 0000:01:00.1: spurious response 0x600:0x0, last cmd=0x770740
[200360.620713] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0xb70740
[200360.620717] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0x377200
[200360.620720] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0x377200
[200360.620726] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0x577200
[200360.620729] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0x577200
[200360.620732] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0x578901
[200360.620738] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0x777200
[200360.620741] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0x778901
[200361.974017] OOM killer enabled.
[200361.974019] Restarting tasks ... 
[200361.974252] usb 1-2: USB disconnect, device number 11
[200361.996159] done.
[200361.996166] PM: suspend exit
[200362.015166] audit: type=1130 audit(1608872332.618:245): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-suspend comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[200362.015172] audit: type=1131 audit(1608872332.618:246): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-suspend comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'

The kernel is now confused, as the correct drive doesn't work anymore, and there's an identical drive all of a sudden:
[200362.637768] r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow control rx/tx
[200362.688735] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[200362.692375] ata2.00: ATA-8: Hitachi HDS721050CLA660, JP2OA41A, max UDMA/133
[200362.692382] ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 32), AA
[200362.693646] ata2.00: configured for UDMA/133
[200362.693858] scsi 1:0:0:0: Direct-Access     ATA      Hitachi HDS72105 A41A PQ: 0 ANSI: 5
[200362.694444] sd 1:0:0:0: [sdd] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[200362.694462] sd 1:0:0:0: [sdd] Write Protect is off
[200362.694465] sd 1:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[200362.694494] sd 1:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[200362.755814]  sdd: sdd1
[200362.756401] sd 1:0:0:0: [sdd] Attached SCSI disk
[200363.737321] BTRFS warning (device <unknown>): duplicate device /dev/sdd1 devid 1 generation 23 scanned by systemd-udevd (41443)
[200384.465851] audit: type=1100 audit(1608872355.071:247): pid=41460 uid=1000 auid=1000 ses=1 msg='op=PAM:authentication grantors=pam_unix acct="root" exe="/usr/bin/su" hostname=cedric-p4 addr=? terminal=pts/10 res=success'
[200384.465935] audit: type=1101 audit(1608872355.071:248): pid=41460 uid=1000 auid=1000 ses=1 msg='op=PAM:accounting grantors=pam_unix acct="root" exe="/usr/bin/su" hostname=cedric-p4 addr=? terminal=pts/10 res=success'
[200384.468075] audit: type=1103 audit(1608872355.071:249): pid=41460 uid=1000 auid=1000 ses=1 msg='op=PAM:setcred grantors=pam_unix acct="root" exe="/usr/bin/su" hostname=cedric-p4 addr=? terminal=pts/10 res=success'
[200384.468343] audit: type=1105 audit(1608872355.071:250): pid=41460 uid=1000 auid=1000 ses=1 msg='op=PAM:session_open grantors=pam_unix acct="root" exe="/usr/bin/su" hostname=cedric-p4 addr=? terminal=pts/10 res=success'
[200472.458951] BTRFS warning (device <unknown>): duplicate device /dev/sdd1 devid 1 generation 23 scanned by mount (41472)
[200517.785424] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
[200517.786114] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
[200517.786579] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 3, rd 0, flush 0, corrupt 0, gen 0
[200517.787025] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 4, rd 0, flush 0, corrupt 0, gen 0
[200517.787892] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 5, rd 0, flush 0, corrupt 0, gen 0
[200517.788695] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 6, rd 0, flush 0, corrupt 0, gen 0
[200517.789949] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 7, rd 0, flush 0, corrupt 0, gen 0
[200517.790674] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 8, rd 0, flush 0, corrupt 0, gen 0
[200517.791171] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 9, rd 0, flush 0, corrupt 0, gen 0
[200517.792075] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 10, rd 0, flush 0, corrupt 0, gen 0
[200522.895484] btrfs_dev_stat_print_on_error: 534 callbacks suppressed
[200522.895491] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 545, rd 0, flush 0, corrupt 0, gen 0
[200522.896448] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 546, rd 0, flush 0, corrupt 0, gen 0
[200522.897357] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 547, rd 0, flush 0, corrupt 0, gen 0
[200522.899087] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 548, rd 0, flush 0, corrupt 0, gen 0
[200522.901058] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 549, rd 0, flush 0, corrupt 0, gen 0
[200522.902371] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 550, rd 0, flush 0, corrupt 0, gen 0
[200522.904677] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 551, rd 0, flush 0, corrupt 0, gen 0
[200522.905734] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 552, rd 0, flush 0, corrupt 0, gen 0
[200522.906719] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 553, rd 0, flush 0, corrupt 0, gen 0
[200522.907543] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 554, rd 0, flush 0, corrupt 0, gen 0
[200528.332677] btrfs_dev_stat_print_on_error: 114 callbacks suppressed
[200528.332685] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 669, rd 0, flush 0, corrupt 0, gen 0
[200528.335467] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 670, rd 0, flush 0, corrupt 0, gen 0
[200528.338258] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 671, rd 0, flush 0, corrupt 0, gen 0
[200528.353018] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 672, rd 0, flush 0, corrupt 0, gen 0
[200528.357561] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 673, rd 0, flush 0, corrupt 0, gen 0
[200528.358649] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 674, rd 0, flush 0, corrupt 0, gen 0
[200528.389175] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 675, rd 0, flush 0, corrupt 0, gen 0
[200528.413552] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 676, rd 0, flush 0, corrupt 0, gen 0
[200528.509921] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 677, rd 0, flush 0, corrupt 0, gen 0
[200529.790253] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 678, rd 0, flush 0, corrupt 0, gen 0
[200533.934783] btrfs_dev_stat_print_on_error: 24 callbacks suppressed
[200533.934788] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 703, rd 0, flush 0, corrupt 0, gen 0
[200533.950737] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 704, rd 0, flush 0, corrupt 0, gen 0
[200533.953478] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 705, rd 0, flush 0, corrupt 0, gen 0
[200533.983833] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 706, rd 0, flush 0, corrupt 0, gen 0
[200533.998969] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 707, rd 0, flush 0, corrupt 0, gen 0
[200534.211385] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 708, rd 0, flush 0, corrupt 0, gen 0
[200534.218303] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 709, rd 0, flush 0, corrupt 0, gen 0
[200534.218723] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 710, rd 0, flush 0, corrupt 0, gen 0
[200534.219000] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 711, rd 0, flush 0, corrupt 0, gen 0
[200534.219672] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 712, rd 0, flush 0, corrupt 0, gen 0
[200534.855575] BTRFS: error (device sdc1) in __btrfs_free_extent:3069: errno=-5 IO failure
[200534.855581] BTRFS info (device sdc1): forced readonly
[200534.855586] BTRFS: error (device sdc1) in btrfs_run_delayed_refs:2173: errno=-5 IO failure
[200539.143447] btrfs_dev_stat_print_on_error: 8 callbacks suppressed
[200539.143452] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 719, rd 2, flush 0, corrupt 0, gen 0
[200539.145758] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 720, rd 2, flush 0, corrupt 0, gen 0
[200539.145946] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 721, rd 2, flush 0, corrupt 0, gen 0
[200539.146135] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 722, rd 2, flush 0, corrupt 0, gen 0
[200564.738162] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 723, rd 2, flush 0, corrupt 0, gen 0
[200564.749532] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 724, rd 2, flush 0, corrupt 0, gen 0
[200564.753395] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 725, rd 2, flush 0, corrupt 0, gen 0
[200564.753907] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 726, rd 2, flush 0, corrupt 0, gen 0
[200564.755052] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 727, rd 2, flush 0, corrupt 0, gen 0
[200564.755807] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 728, rd 2, flush 0, corrupt 0, gen 0
[200564.760033] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 729, rd 2, flush 0, corrupt 0, gen 0
[200564.764422] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 730, rd 2, flush 0, corrupt 0, gen 0
[200564.764892] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 731, rd 2, flush 0, corrupt 0, gen 0
[200564.765425] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 732, rd 2, flush 0, corrupt 0, gen 0
[200652.273236] BTRFS warning (device <unknown>): duplicate device /dev/sdd1 devid 1 generation 23 scanned by mount (47496)

Changing the uuid and mounting the filesystem:
# btrfstune -u /dev/sde1
WARNING: it's recommended to run 'btrfs check --readonly' before this operation.
	The whole operation must finish before the filesystem can be mounted again.
	If cancelled or interrupted, run 'btrfstune -u' to restart.
We are going to change UUID, are your sure? [y/N]: y
Current fsid: eb5c0207-31a4-4f30-8514-13f46141687e
New fsid: 65c321f9-2995-497a-b269-999717c1cdcb
Set superblock flag CHANGING_FSID
Change fsid in extents
Change fsid on devices
Clear superblock flag CHANGING_FSID
Fsid change finished
[200679.093130] BTRFS: device fsid eb5c0207-31a4-4f30-8514-13f46141687e devid 1 transid 5 /dev/sdd1 scanned by mkfs.btrfs (47500)
[200693.666012] BTRFS info (device sdd1): disk space caching is enabled
[200693.666017] BTRFS info (device sdd1): has skinny extents
[200693.666020] BTRFS info (device sdd1): flagging fs with big metadata feature
[200693.678861] BTRFS info (device sdd1): checking UUID tree

My version:
uname -a
Linux cedric-p4 5.9.14-arch1-1 #1 SMP PREEMPT Sat, 12 Dec 2020 14:37:12 +0000 x86_64 GNU/Linux

---

Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: https://www.eclipso.eu - Time to change!


