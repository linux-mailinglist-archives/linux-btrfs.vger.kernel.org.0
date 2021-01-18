Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A1D2F9851
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jan 2021 04:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbhARDgZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Jan 2021 22:36:25 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33114 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730186AbhARDgY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jan 2021 22:36:24 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10I3Z5Ac181351;
        Mon, 18 Jan 2021 03:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=M/4IyWU7fzWmyl0/7vLLDN4NVBDwioyl5nW5JEK0J+M=;
 b=fDSEsyQgEjkHNEN9khXITglXNIuPWtv/nS1IuKHo4Rz46GoxFu87CRv7vTA3h0cOf8L4
 dC2q3LCmHlDq6X1IYLfJFco/SefaiSNaq+GxQ+p1sqnCobGrr6S8u5Jjah/cfoUDoP+7
 E0hgfDiJvM1iJxv5Tlcd8NFRjAgNqvJVUDp2QFKtPAVSo9GJFc+FGBwoowOj/nR/MQl/
 1O75KgKIkDfiYejqcNhvfxF3duk3OpkYMkD2Qy1qbf8uFQ4X+nFcjchb70rcDub4kj2f
 jiYX4saSqld+bOslfbCSf8RHB9pAJ0coR7UvwhQpiIBbefYEZqvf/9bS5aUILHxFJBUD QQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 363r3kk6m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jan 2021 03:35:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10I3Ttok089693;
        Mon, 18 Jan 2021 03:35:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 364a1vume7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jan 2021 03:35:26 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10I3ZNjg025695;
        Mon, 18 Jan 2021 03:35:24 GMT
Received: from [192.168.10.137] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 17 Jan 2021 19:35:23 -0800
Subject: Re: btrfs doesn't understand a drive moving from one sata port to
 another during suspend
To:     Cedric.dewijs@eclipso.eu, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <dbdc13b2ab6379b793586b7886fea027@mail.eclipso.de>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.com
Message-ID: <736da0c5-5b13-d225-b031-278985496d05@oracle.com>
Date:   Mon, 18 Jan 2021 11:35:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <dbdc13b2ab6379b793586b7886fea027@mail.eclipso.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9867 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101180019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9867 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101180019
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


I wish there are btrfs unmount logs or ctree-close logs so that we can
  know if the device was closed during the suspend. Those patches aren't
  merged yet.

So here if I guess it correctly, the suspend does not seems to unmount
  the filesystem, which means the device open is never closed. And, if
  the device is moved to another port/controller when suspended it shall
  appear as a new device with a new major,minor number.

The error below what you notice is expected. I suggest umounting the
  device or power off the system before the device is detached
  physically.


On 18/1/21 3:02 am, Cedric.dewijs@eclipso.eu wrote:
> ­I've moved a drive to a different sata controller during a suspend. Btrfs does not understand that. I had to give the filesystem a new uuid before I could access it again. Is there some setting in the kernel so it can deal with this?
> 
> Initial mounting of the btrfs partition:
> [199167.697831] BTRFS info (device sdc1): disk space caching is enabled
> [199167.697835] BTRFS info (device sdc1): has skinny extents
> [199167.697838] BTRFS info (device sdc1): flagging fs with big metadata feature
> [199167.708160] BTRFS info (device sdc1): checking UUID tree
> 
> Suspend the system:
> [200353.483856] PM: suspend entry (deep)
> [200354.106728] Filesystems sync: 0.622 seconds
> [200354.107073] Freezing user space processes ... (elapsed 0.008 seconds) done.
> [200354.115993] OOM killer disabled.
> [200354.115994] Freezing remaining freezable tasks ... (elapsed 1.300 seconds) done.
> [200355.416151] printk: Suspending console(s) (use no_console_suspend to debug)
> [200355.417143] snd_hdac_bus_update_rirb: 59 callbacks suppressed
> [200355.417153] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0x620000
> [200355.417158] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0x620000
> [200355.418087] serial 00:08: disabled
> [200355.418916] r8169 0000:04:00.0 enp4s0: Link is Down
> [200355.432383] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0x1f0500
> [200355.432389] snd_hda_intel 0000:01:00.1: spurious response 0x233:0x0, last cmd=0x1f0500
> [200355.435758] sd 2:0:0:0: [sda] Synchronizing SCSI cache
> [200355.435817] sd 4:0:0:0: [sdb] Synchronizing SCSI cache
> [200355.435984] sd 4:0:0:0: [sdb] Stopping disk
> [200355.436457] sd 2:0:0:0: [sda] Stopping disk
> [200358.367463] ACPI: Preparing to enter system sleep state S3
> [200358.986393] PM: Saving platform NVS memory
> [200358.986523] Disabling non-boot CPUs ...
> [200358.990521] smpboot: CPU 1 is now offline
> [200358.993159] smpboot: CPU 2 is now offline
> [200358.996959] smpboot: CPU 3 is now offline
> [200358.999283] smpboot: CPU 4 is now offline
> [200359.002968] smpboot: CPU 5 is now offline
> [200359.007251] smpboot: CPU 6 is now offline
> [200359.009456] smpboot: CPU 7 is now offline
> 
> Wake the system:
> 200359.012955] ACPI: Low-level resume complete
> [200359.012990] PM: Restoring platform NVS memory
> [200359.013078] PCI-DMA: Resuming GART IOMMU
> [200359.013078] PCI-DMA: Restoring GART aperture settings
> [200359.013083] LVT offset 0 assigned for vector 0x400
> [200359.019869] microcode: CPU0: new patch_level=0x06000852
> [200359.020013] Enabling non-boot CPUs ...
> [200359.020077] x86: Booting SMP configuration:
> [200359.020078] smpboot: Booting Node 0 Processor 1 APIC 0x11
> [200359.020913] microcode: CPU1: patch_level=0x06000852
> [200359.023159] ACPI: \_PR_.P002: Found 2 idle states
> [200359.023459] CPU1 is up
> [200359.023520] smpboot: Booting Node 0 Processor 2 APIC 0x12
> [200359.025237] microcode: CPU2: patch_level=0x06000817
> [200359.041657] microcode: CPU2: new patch_level=0x06000852
> [200359.044132] ACPI: \_PR_.P003: Found 2 idle states
> [200359.044663] CPU2 is up
> [200359.044707] smpboot: Booting Node 0 Processor 3 APIC 0x13
> [200359.046801] microcode: CPU3: patch_level=0x06000852
> [200359.049258] ACPI: \_PR_.P004: Found 2 idle states
> [200359.049845] CPU3 is up
> [200359.049913] smpboot: Booting Node 0 Processor 4 APIC 0x14
> [200359.051632] microcode: CPU4: patch_level=0x06000817
> [200359.068100] microcode: CPU4: new patch_level=0x06000852
> [200359.070587] ACPI: \_PR_.P005: Found 2 idle states
> [200359.071210] CPU4 is up
> [200359.071269] smpboot: Booting Node 0 Processor 5 APIC 0x15
> [200359.073363] microcode: CPU5: patch_level=0x06000852
> [200359.075833] ACPI: \_PR_.P006: Found 2 idle states
> [200359.076504] CPU5 is up
> [200359.076567] smpboot: Booting Node 0 Processor 6 APIC 0x16
> [200359.078287] microcode: CPU6: patch_level=0x06000817
> [200359.094806] microcode: CPU6: new patch_level=0x06000852
> [200359.097301] ACPI: \_PR_.P007: Found 2 idle states
> [200359.098030] CPU6 is up
> [200359.098091] smpboot: Booting Node 0 Processor 7 APIC 0x17
> [200359.100187] microcode: CPU7: patch_level=0x06000852
> [200359.102688] ACPI: \_PR_.P008: Found 2 idle states
> [200359.103465] CPU7 is up
> [200359.127094] ACPI: Waking up from system sleep state S3
> [200359.128297] ahci 0000:00:11.0: set SATA to AHCI mode
> [200359.166239] sd 2:0:0:0: [sda] Starting disk
> [200359.166298] sd 4:0:0:0: [sdb] Starting disk
> [200359.168414] serial 00:08: activated
> [200359.283537] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
> [200359.334134] ata5.00: ACPI cmd ef/03:08:00:00:00:a0 (SET FEATURES) filtered out
> [200359.334140] ata5.00: ACPI cmd ef/03:20:00:00:00:a0 (SET FEATURES) filtered out
> [200359.334144] ata5.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
> [200359.380448] r8169 0000:04:00.0 enp4s0: Link is Down
> [200359.475882] ata1: SATA link down (SStatus 0 SControl 300)
> [200359.475911] ata4: SATA link down (SStatus 0 SControl 300)
> [200359.632066] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [200359.633575] ata3.00: configured for UDMA/133
> [200359.948719] [drm] Fence fallback timer expired on ring sdma0
> [200360.455386] [drm] Fence fallback timer expired on ring sdma0
> [200360.503548] [drm] UVD and UVD ENC initialized successfully.
> [200360.614537] [drm] VCE initialized successfully.
> [200360.620701] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0x370740
> [200360.620707] snd_hda_intel 0000:01:00.1: spurious response 0x600:0x0, last cmd=0x770740
> [200360.620713] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0xb70740
> [200360.620717] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0x377200
> [200360.620720] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0x377200
> [200360.620726] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0x577200
> [200360.620729] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0x577200
> [200360.620732] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0x578901
> [200360.620738] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0x777200
> [200360.620741] snd_hda_intel 0000:01:00.1: spurious response 0x0:0x0, last cmd=0x778901
> [200361.974017] OOM killer enabled.
> [200361.974019] Restarting tasks ...
> [200361.974252] usb 1-2: USB disconnect, device number 11
> [200361.996159] done.
> [200361.996166] PM: suspend exit
> [200362.015166] audit: type=1130 audit(1608872332.618:245): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-suspend comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [200362.015172] audit: type=1131 audit(1608872332.618:246): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-suspend comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> 
> The kernel is now confused, as the correct drive doesn't work anymore, and there's an identical drive all of a sudden:
> [200362.637768] r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow control rx/tx
> [200362.688735] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [200362.692375] ata2.00: ATA-8: Hitachi HDS721050CLA660, JP2OA41A, max UDMA/133
> [200362.692382] ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 32), AA
> [200362.693646] ata2.00: configured for UDMA/133
> [200362.693858] scsi 1:0:0:0: Direct-Access     ATA      Hitachi HDS72105 A41A PQ: 0 ANSI: 5
> [200362.694444] sd 1:0:0:0: [sdd] 976773168 512-byte logical blocks: (500 GB/466 GiB)
> [200362.694462] sd 1:0:0:0: [sdd] Write Protect is off
> [200362.694465] sd 1:0:0:0: [sdd] Mode Sense: 00 3a 00 00
> [200362.694494] sd 1:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [200362.755814]  sdd: sdd1
> [200362.756401] sd 1:0:0:0: [sdd] Attached SCSI disk
> [200363.737321] BTRFS warning (device <unknown>): duplicate device /dev/sdd1 devid 1 generation 23 scanned by systemd-udevd (41443)
> [200384.465851] audit: type=1100 audit(1608872355.071:247): pid=41460 uid=1000 auid=1000 ses=1 msg='op=PAM:authentication grantors=pam_unix acct="root" exe="/usr/bin/su" hostname=cedric-p4 addr=? terminal=pts/10 res=success'
> [200384.465935] audit: type=1101 audit(1608872355.071:248): pid=41460 uid=1000 auid=1000 ses=1 msg='op=PAM:accounting grantors=pam_unix acct="root" exe="/usr/bin/su" hostname=cedric-p4 addr=? terminal=pts/10 res=success'
> [200384.468075] audit: type=1103 audit(1608872355.071:249): pid=41460 uid=1000 auid=1000 ses=1 msg='op=PAM:setcred grantors=pam_unix acct="root" exe="/usr/bin/su" hostname=cedric-p4 addr=? terminal=pts/10 res=success'
> [200384.468343] audit: type=1105 audit(1608872355.071:250): pid=41460 uid=1000 auid=1000 ses=1 msg='op=PAM:session_open grantors=pam_unix acct="root" exe="/usr/bin/su" hostname=cedric-p4 addr=? terminal=pts/10 res=success'
> [200472.458951] BTRFS warning (device <unknown>): duplicate device /dev/sdd1 devid 1 generation 23 scanned by mount (41472)
> [200517.785424] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
> [200517.786114] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
> [200517.786579] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 3, rd 0, flush 0, corrupt 0, gen 0
> [200517.787025] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 4, rd 0, flush 0, corrupt 0, gen 0
> [200517.787892] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 5, rd 0, flush 0, corrupt 0, gen 0
> [200517.788695] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 6, rd 0, flush 0, corrupt 0, gen 0
> [200517.789949] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 7, rd 0, flush 0, corrupt 0, gen 0
> [200517.790674] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 8, rd 0, flush 0, corrupt 0, gen 0
> [200517.791171] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 9, rd 0, flush 0, corrupt 0, gen 0
> [200517.792075] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 10, rd 0, flush 0, corrupt 0, gen 0
> [200522.895484] btrfs_dev_stat_print_on_error: 534 callbacks suppressed
> [200522.895491] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 545, rd 0, flush 0, corrupt 0, gen 0
> [200522.896448] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 546, rd 0, flush 0, corrupt 0, gen 0
> [200522.897357] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 547, rd 0, flush 0, corrupt 0, gen 0
> [200522.899087] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 548, rd 0, flush 0, corrupt 0, gen 0
> [200522.901058] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 549, rd 0, flush 0, corrupt 0, gen 0
> [200522.902371] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 550, rd 0, flush 0, corrupt 0, gen 0
> [200522.904677] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 551, rd 0, flush 0, corrupt 0, gen 0
> [200522.905734] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 552, rd 0, flush 0, corrupt 0, gen 0
> [200522.906719] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 553, rd 0, flush 0, corrupt 0, gen 0
> [200522.907543] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 554, rd 0, flush 0, corrupt 0, gen 0
> [200528.332677] btrfs_dev_stat_print_on_error: 114 callbacks suppressed
> [200528.332685] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 669, rd 0, flush 0, corrupt 0, gen 0
> [200528.335467] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 670, rd 0, flush 0, corrupt 0, gen 0
> [200528.338258] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 671, rd 0, flush 0, corrupt 0, gen 0
> [200528.353018] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 672, rd 0, flush 0, corrupt 0, gen 0
> [200528.357561] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 673, rd 0, flush 0, corrupt 0, gen 0
> [200528.358649] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 674, rd 0, flush 0, corrupt 0, gen 0
> [200528.389175] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 675, rd 0, flush 0, corrupt 0, gen 0
> [200528.413552] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 676, rd 0, flush 0, corrupt 0, gen 0
> [200528.509921] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 677, rd 0, flush 0, corrupt 0, gen 0
> [200529.790253] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 678, rd 0, flush 0, corrupt 0, gen 0
> [200533.934783] btrfs_dev_stat_print_on_error: 24 callbacks suppressed
> [200533.934788] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 703, rd 0, flush 0, corrupt 0, gen 0
> [200533.950737] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 704, rd 0, flush 0, corrupt 0, gen 0
> [200533.953478] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 705, rd 0, flush 0, corrupt 0, gen 0
> [200533.983833] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 706, rd 0, flush 0, corrupt 0, gen 0
> [200533.998969] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 707, rd 0, flush 0, corrupt 0, gen 0
> [200534.211385] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 708, rd 0, flush 0, corrupt 0, gen 0
> [200534.218303] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 709, rd 0, flush 0, corrupt 0, gen 0
> [200534.218723] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 710, rd 0, flush 0, corrupt 0, gen 0
> [200534.219000] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 711, rd 0, flush 0, corrupt 0, gen 0
> [200534.219672] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 712, rd 0, flush 0, corrupt 0, gen 0
> [200534.855575] BTRFS: error (device sdc1) in __btrfs_free_extent:3069: errno=-5 IO failure
> [200534.855581] BTRFS info (device sdc1): forced readonly
> [200534.855586] BTRFS: error (device sdc1) in btrfs_run_delayed_refs:2173: errno=-5 IO failure
> [200539.143447] btrfs_dev_stat_print_on_error: 8 callbacks suppressed
> [200539.143452] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 719, rd 2, flush 0, corrupt 0, gen 0
> [200539.145758] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 720, rd 2, flush 0, corrupt 0, gen 0
> [200539.145946] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 721, rd 2, flush 0, corrupt 0, gen 0
> [200539.146135] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 722, rd 2, flush 0, corrupt 0, gen 0
> [200564.738162] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 723, rd 2, flush 0, corrupt 0, gen 0
> [200564.749532] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 724, rd 2, flush 0, corrupt 0, gen 0
> [200564.753395] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 725, rd 2, flush 0, corrupt 0, gen 0
> [200564.753907] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 726, rd 2, flush 0, corrupt 0, gen 0
> [200564.755052] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 727, rd 2, flush 0, corrupt 0, gen 0
> [200564.755807] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 728, rd 2, flush 0, corrupt 0, gen 0
> [200564.760033] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 729, rd 2, flush 0, corrupt 0, gen 0
> [200564.764422] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 730, rd 2, flush 0, corrupt 0, gen 0
> [200564.764892] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 731, rd 2, flush 0, corrupt 0, gen 0
> [200564.765425] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 732, rd 2, flush 0, corrupt 0, gen 0
> [200652.273236] BTRFS warning (device <unknown>): duplicate device /dev/sdd1 devid 1 generation 23 scanned by mount (47496)
> 
> Changing the uuid and mounting the filesystem:
> # btrfstune -u /dev/sde1
> WARNING: it's recommended to run 'btrfs check --readonly' before this operation.
> 	The whole operation must finish before the filesystem can be mounted again.
> 	If cancelled or interrupted, run 'btrfstune -u' to restart.
> We are going to change UUID, are your sure? [y/N]: y
> Current fsid: eb5c0207-31a4-4f30-8514-13f46141687e
> New fsid: 65c321f9-2995-497a-b269-999717c1cdcb
> Set superblock flag CHANGING_FSID
> Change fsid in extents
> Change fsid on devices
> Clear superblock flag CHANGING_FSID
> Fsid change finished
> [200679.093130] BTRFS: device fsid eb5c0207-31a4-4f30-8514-13f46141687e devid 1 transid 5 /dev/sdd1 scanned by mkfs.btrfs (47500)
> [200693.666012] BTRFS info (device sdd1): disk space caching is enabled
> [200693.666017] BTRFS info (device sdd1): has skinny extents
> [200693.666020] BTRFS info (device sdd1): flagging fs with big metadata feature
> [200693.678861] BTRFS info (device sdd1): checking UUID tree
> 
> My version:
> uname -a
> Linux cedric-p4 5.9.14-arch1-1 #1 SMP PREEMPT Sat, 12 Dec 2020 14:37:12 +0000 x86_64 GNU/Linux
> 
> ---
> 
> Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: https://www.eclipso.eu - Time to change!
> 
> 

