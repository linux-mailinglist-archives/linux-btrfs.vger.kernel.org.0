Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9B8572AD6
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 03:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiGMBa1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jul 2022 21:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiGMBaZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jul 2022 21:30:25 -0400
X-Greylist: delayed 376 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Jul 2022 18:30:24 PDT
Received: from mail.critical-optimisation.com (unknown [IPv6:2001:861:3205:7e13::905e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DD2C9219
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 18:30:24 -0700 (PDT)
Received: from www.calcool.ai (localhost [IPv6:::1])
        (Authenticated sender: jm)
        by mail.critical-optimisation.com (Postfix) with ESMTPA id 2D6E411004F1
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 03:24:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=critical-optimisation.com; s=ecocity; t=1657675447;
        bh=NG4O6tCJULCX1yuPaxzNHvSvucMDezwL4RS8QK8V+Lk=;
        h=Date:From:To:Subject:From;
        b=CEG1EcMHfIKwRgLmeWErVfZOrHWddGeiYc+zrbn/IzV9BBL17iHMtqjA3NLHOJJzY
         0mKMBRN5gwu/F2AgFst0w50+i/RsRC6EN/2ogqw2PVlA2jdC5QB0JH3sMY3Tt5SJQh
         aHs9i2WHx450eHZ5RepQrfdnoyTkRc+xESGoTYewnHoIOEWfF+oiiTJTRwV8NyLUVz
         rH26hz3T//27znhuOfPySYx+5eTXm2x/9cm3IkMFfHkqnZ2iVXgMz4COWUp+ZIB8ZA
         infU/cfsqYhFi+Gr8tmJEvljsd8T25M8l5Tnhx07ju4BesvozMcXFrMwSI0nXrtmv/
         a9jZ3IKRsf5KQ==
MIME-Version: 1.0
Date:   Wed, 13 Jul 2022 01:24:07 +0000
From:   =?UTF-8?Q?Jean-Marc_LE_PEUV=C3=89DIC?= 
        <jean-marc.le-peuvedic@critical-optimisation.com>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs check reports inode issues and filesystem turns read-only
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <a1daf117746fbb532a8ea8db47f9de6b@critical-optimisation.com>
X-Sender: jean-marc.le-peuvedic@critical-optimisation.com
Organization: Critical Optimisation SAS
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello!

I am requesting advice regarding a failure of the BTRFS volume of an 
Ubuntu 20.04 computer.

The computer is equipped with a main disk, /dev/nvme0n1 split in two 
partitions.

The partition nvme0n1p1 is the EFI partition, formatted in FAT32.

The problem is in the nvme0n1p2 partition, formatted in BTRFS and having 
/ and /home as subvolumes.

Initially, the computer GUI crashed and the console starting showing 
lots of BTRFS errors, which I unfortunately did not copy. There was no 
way to log in, no ping, even though the kernel was apparently running. I 
imagine that the root filesystem was unavailable, or some similarly 
critical issue.

I had to shut it down the hard way. On the next boot I was in busybox: 
the grub-efi boot had somehow been corrupted. I am since using that 
computer from a live USB Ubuntu 20.04 distro.

The actual kernel is different from the USB distro: I am running 
5.13.0-52, probably the latest version released for Ubuntu 20.04 LTS.

The system has been running stable for over 2 years. It runs quite 
complex business web apps using Postgresql in LXD containers. The 
database has been backed up daily, and there are up to date backups, but 
no complete business continuation procedure to use those backups 
(especially the difficulty to reload the db within containers). This is 
not a file server and beyond this application, there isn't much useful 
data. Everything was left at stock Ubuntu settings with Gnome 3. It 
shouldn't be really hard to reinstall.

I have been following the instructions at 
https://btrfs.wiki.kernel.org/index.php/Btrfs_mailing_list.

The computer has also 2 other SSD installed via an interface making them 
look like a 2 TB disk. This disk is divided in two 1000GB partitions 
called sda1 and sda2. sdb1/2 is the Live USB key (also EFI boot). sda1 
and sda2 were empty at the time of the incident.

Before discovering BTRFS issues, I tried boot-repair to reinstall grub, 
but that failed due to inability to mount the BTRFS volume at some 
point. boot-repair produced a log file which include dmesg, but it is 
too big to attach to this message (it was mostly trying to chroot into 
the BTRFS volume and reinit grub stuff). Every action attempted failed, 
because the failing BTRFS volume had mounted read-only.

I made a copy of the nvme0n1p2 partition to sda1 with dd. I can use that 
copy to reset nvme0n1p2 to its initial condition, so I tried "btrfs 
check --repair", and the result was not a working filesystem. The volume 
is currently in its initial state.

I formatted sda2 with BTRFS and could extract most data from 
/dev/nvme0n1p2 using:
btrfs restore -t 4762484736 -s -x -m -S -i /dev/nvme0n1p2 
/media/ubuntu/BACKUPbtrfs restore

The root number after -t was found using:
root@ubuntu:/mnt/boot-sav# btrfs-find-root -a /dev/sda1
Superblock thinks the generation is 4931011
Superblock thinks the level is 1
Well block 4762484736(gen: 4931011 level: 1) seems good, and it matches 
superblock  <== number HERE
Well block 4763828224(gen: 4931010 level: 1) seems good, but 
generation/level doesn't match, want gen: 4931011 level: 1
etc.  <all the following lines resemble the second Well block line 
above>
(note that sda1 is a copy of nvme0n1p2 at the beginning of the incident)

The nvme0n1p2 partition can be mounted rw and ro, but makes errors and 
turns ro very quickly.
A possible mount command is:
mount -o ro,relatime,ssd,space_cache,subvol=@ /dev/nvme0n1p2 
/mnt/boot-sav/nvme0n1p2

I tried the option -o recovery without succeeding to correct errors 
found by btrfs check.

My problem is:
- btrfs check finds errors
- the filesystem turns ro after some use, and the computer becomes 
unusable.

The question is: can I fix the filesystem without reinstalling 
everything?

Here is the recommended command output:

root@ubuntu:/mnt/boot-sav# uname -a
Linux ubuntu 5.4.0-42-generic #46-Ubuntu SMP Fri Jul 10 00:24:02 UTC 
2020 x86_64 x86_64 x86_64 GNU/Linux

root@ubuntu:/mnt/boot-sav# btrfs --version
btrfs-progs v5.4.1

root@ubuntu:/mnt/boot-sav# mount -o ro,relatime,ssd,space_cache,subvol=@ 
/dev/nvme0n1p2 /mnt/boot-sav/nvme0n1p2
root@ubuntu:/mnt/boot-sav# btrfs fi df /mnt/boot-sav/nvme0n1p2
Data, single: total=119.01GiB, used=78.64GiB
System, single: total=4.00MiB, used=16.00KiB
Metadata, single: total=2.01GiB, used=878.11MiB
GlobalReserve, single: total=184.19MiB, used=0.00B

BTRFS complains about seeing two disks with the same UUID (expected 
since sda1 is a binary copy of the
faulty partition).

dmesg is too big to attach to this mail, but the copy of dmesg made by 
boot-repair contains this:
[  442.555785] ------------[ cut here ]------------
[  442.555788] BTRFS: Transaction aborted (error -17)
[  442.555873] WARNING: CPU: 2 PID: 11279 at fs/btrfs/extent-tree.c:2188 
btrfs_run_delayed_refs+0x13c/0x190 [btrfs]
[  442.555874] Modules linked in: ufs qnx4 hfsplus hfs minix ntfs msdos 
jfs xfs ccm rfcomm cmac algif_hash algif_skcipher
af_alg bnep zfs(PO) zunicode(PO) zavl(PO) icp(PO) zcommon(PO) 
znvpair(PO) spl(O) zlua(PO) snd_hda_codec_hdmi snd_sof_pci s
nd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_intel_hda 
snd_sof_intel_byt snd_sof_intel_ipc snd_sof snd_sof_xtensa_dsp
snd_hda_ext_core snd_soc_acpi_intel_match snd_hda_codec_realtek 
snd_soc_acpi snd_hda_codec_generic snd_soc_core ledtrig_au
dio snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel intel_rapl_msr 
snd_intel_dspcfg mei_hdcp snd_hda_codec snd_hda_c
ore snd_hwdep snd_pcm snd_seq_midi snd_seq_midi_event intel_rapl_common 
x86_pkg_temp_thermal intel_powerclamp coretemp snd
_rawmidi kvm_intel kvm iwlmvm intel_cstate intel_rapl_perf mac80211 
snd_seq libarc4 input_leds joydev btusb iwlwifi btrtl
btbcm wmi_bmof intel_wmi_thunderbolt btintel snd_seq_device bluetooth 
snd_timer rtsx_pci_ms snd ecdh_generic memstick ecc
cfg80211 soundcore mei_me
[  442.555912]  intel_pch_thermal mei ir_rc6_decoder rc_rc6_mce ite_cir 
rc_core acpi_tad mac_hid acpi_pad sch_fq_codel par
port_pc ppdev lp parport ip_tables x_tables autofs4 overlay nls_utf8 
isofs btrfs xor zstd_compress raid6_pq libcrc32c nls_
iso8859_1 dm_mirror dm_region_hash dm_log hid_generic uas usbhid 
usb_storage hid crct10dif_pclmul crc32_pclmul ghash_clmul
ni_intel rtsx_pci_sdmmc i915 aesni_intel i2c_algo_bit drm_kms_helper 
crypto_simd nvme syscopyarea sysfillrect cryptd sysimgblt fb_sys_fops 
glue_helper e1000e ahci i2c_i801 drm nvme_core rtsx_pci libahci wmi 
video pinctrl_cannonlake pinctrl_intel
[  442.555945] CPU: 2 PID: 11279 Comm: btrfs-transacti Tainted: P        
    O      5.4.0-42-generic #46-Ubuntu
[  442.555946] Hardware name: BLEUJOUR KUBB-OCTO/NUC8BEB, BIOS 
BECFL357.86A.0083.2020.0730.1436 07/30/2020
[  442.555973] RIP: 0010:btrfs_run_delayed_refs+0x13c/0x190 [btrfs]
[  442.555976] Code: 41 5f 5d c3 49 8b 55 50 f0 48 0f ba aa 38 ce 00 00 
02 72 1b 83 f8 fb 74 34 89 c6 48 c7 c7 b8 f1 91 c0 89 45 d0 e8 7f 1f 24 
ea <0f> 0b 8b 45 d0 89 c1 ba 8c 08 00 00 4c 89 ef 89 45 d0 48 c7 c6 60
[  442.555978] RSP: 0018:ffffb2cb47987df8 EFLAGS: 00010282
[  442.555980] RAX: 0000000000000000 RBX: ffffffffffffffff RCX: 
0000000000000006
[  442.555982] RDX: 0000000000000007 RSI: 0000000000000082 RDI: 
ffff8ca15db178c0
[  442.555983] RBP: ffffb2cb47987e38 R08: 0000000000000439 R09: 
0000000000000004
[  442.555984] R10: 0000000000000000 R11: 0000000000000001 R12: 
ffff8ca092d95758
[  442.555985] R13: ffff8ca01e091a28 R14: ffff8ca153490090 R15: 
ffff8ca1534900f0
[  442.555987] FS:  0000000000000000(0000) GS:ffff8ca15db00000(0000) 
knlGS:0000000000000000
[  442.555989] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  442.555990] CR2: 00007f2be720c004 CR3: 00000004eea0a001 CR4: 
00000000003606e0
[  442.555992] Call Trace:
[  442.556026]  btrfs_commit_transaction+0x442/0x960 [btrfs]
[  442.556055]  transaction_kthread+0x146/0x190 [btrfs]
[  442.556060]  kthread+0x104/0x140
[  442.556086]  ? btrfs_cleanup_transaction+0x530/0x530 [btrfs]
[  442.556089]  ? kthread_park+0x90/0x90
[  442.556093]  ret_from_fork+0x35/0x40
[  442.556096] ---[ end trace e5d311bf6835d1be ]---
[  442.556100] BTRFS: error (device nvme0n1p2) in 
btrfs_run_delayed_refs:2188: errno=-17 Object already exists
[  442.556105] BTRFS info (device nvme0n1p2): forced readonly            
     <=== THIS IS WHERE BTRFS TURNS READ ONLY
[  442.556108] BTRFS warning (device nvme0n1p2): Skipping commit of 
aborted transaction.
[  442.556110] BTRFS: error (device nvme0n1p2) in 
cleanup_transaction:1841: errno=-17 Object already exists

And of course, the symptoms:

root@ubuntu:/mnt/boot-sav# btrfs check -r 4762484736 /dev/nvme0n1p2
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p2
UUID: 5e7b4dbc-a2f7-4f2f-9697-4b5d4bcd625b
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
root 256 inode 25493261 errors 200, dir isize wrong
root 256 inode 35736122 errors 1, no inode item
	unresolved ref dir 25493261 index 85113 namelen 11 name global.stat 
filetype 1 errors 5, no dir item, no inode ref
root 256 inode 35736125 errors 1, no inode item
	unresolved ref dir 25493261 index 85114 namelen 10 name global.tmp 
filetype 1 errors 5, no dir item, no inode ref
	unresolved ref dir 25493261 index 85119 namelen 11 name global.stat 
filetype 1 errors 5, no dir item, no inode ref
root 256 inode 35736126 errors 1, no inode item
	unresolved ref dir 25493261 index 85116 namelen 13 name db_16385.stat 
filetype 1 errors 5, no dir item, no inode ref
root 256 inode 35736127 errors 1, no inode item
	unresolved ref dir 25493261 index 85118 namelen 9 name db_0.stat 
filetype 1 errors 5, no dir item, no inode ref
root 256 inode 35736128 errors 1, no inode item
	unresolved ref dir 25493261 index 85120 namelen 10 name global.tmp 
filetype 1 errors 5, no dir item, no inode ref
ERROR: errors found in fs roots
found 85358792704 bytes used, error(s) found
total csum bytes: 69288016
total tree bytes: 920780800
total fs tree bytes: 727531520
total extent tree bytes: 93896704
btree space waste bytes: 195920372
file data blocks allocated: 516036718592
  referenced 81088217088

(it also says that superblock 2 is beyond the end of the partition when 
using option -s 2, and no change with -s 1).

Kind regards,
-- 
J-M Le Peuvédic
Président, Critical Optimisation SAS
