Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642F54081E6
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Sep 2021 23:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbhILVkl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Sep 2021 17:40:41 -0400
Received: from mail.linuxsystems.it ([79.7.78.67]:60961 "EHLO
        mail.linuxsystems.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbhILVkh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Sep 2021 17:40:37 -0400
Received: by mail.linuxsystems.it (Postfix, from userid 33)
        id 649F221036F; Sun, 12 Sep 2021 23:23:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxsystems.it;
        s=linuxsystems.it; t=1631481813;
        bh=iwfNs7NLOmS/Zqtcj2YalE9w6cs1AteCtpGCzxqEMwU=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References:From;
        b=c/VIhxDHinBEr0cd5CB51AfN84KibmQmNFgrc8dmNiSCuWLv1ui+cDx89Z1YLBe4B
         5Hk6p4f02163g0au1CTbfFI+3y7m8K2QAJACsRkYiLtY2mqyqxgSB2YfcXFzGUJf/5
         wfJAVynI5p9EccPUAmStCZ3j85mm76Jp47KL+QPA=
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Unmountable / uncheckable Fedora 34 btrfs: failed to read block  groups: -5 open_ctree failed
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 12 Sep 2021 23:23:33 +0200
From:   =?UTF-8?Q?Niccol=C3=B2_Belli?= <darkbasic@linuxsystems.it>
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <22ac9237-68dd-5bc3-71e1-6a4a32427852@gmx.com>
References: <0303d1f618b815714fe62a6eb90f55ca@linuxsystems.it>
 <22ac9237-68dd-5bc3-71e1-6a4a32427852@gmx.com>
Message-ID: <02f428314a995fa1deea171af9685b9a@linuxsystems.it>
X-Sender: darkbasic@linuxsystems.it
User-Agent: Roundcube Webmail/1.1.5
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I think I've managed to recover the vast majority of my files:

$ sudo cp -a avd var 
/run/media/niko/3ea0705c-21c9-4ba9-80ee-5a511cb2a093/nvme0n1p6/
cp: avd/Pixel_4_API_30.avd/userdata-qemu.img.qcow2: recupero delle 
informazioni degli extent non riuscito: Errore di input/output

$ sudo cp -a snapshots/home/375/snapshot 
/run/media/niko/3ea0705c-21c9-4ba9-80ee-5a511cb2a093/nvme0n1p6/home
cp: 
snapshots/home/375/snapshot/niko/devel/beach/client/android/.gradle/checksums/sha1-checksums.bin: 
recupero delle informazioni degli extent non riuscito: Errore di 
input/output

$ sudo cp -a snapshots/root/3004/snapshot 
/run/media/niko/3ea0705c-21c9-4ba9-80ee-5a511cb2a093/nvme0n1p6/root

$ sudo cp -a snapshots/images/3/snapshot 
/run/media/niko/3ea0705c-21c9-4ba9-80ee-5a511cb2a093/nvme0n1p6/images
cp: snapshots/images/3/snapshot/OSX-KVM/mac_hdd_ng.img: recupero delle 
informazioni degli extent non riuscito: Errore di input/output
cp: snapshots/images/3/snapshot/OSX-KVM/BaseSystem.img: recupero delle 
informazioni degli extent non riuscito: Errore di input/output

The only valuable thing I've lost seems to be an hackintosh vm I use for 
development, but I can create another one.

[ 2213.532522] BTRFS warning (device loop0): Skipping commit of aborted 
transaction.
[ 2213.532526] ------------[ cut here ]------------
[ 2213.532527] BTRFS: Transaction aborted (error -28)
[ 2213.532565] WARNING: CPU: 2 PID: 3061 at fs/btrfs/transaction.c:1946 
btrfs_commit_transaction.cold+0xf2/0x2ef [btrfs]
[ 2213.532609] Modules linked in: loop ext4 mbcache jbd2 ses enclosure 
scsi_transport_sas uas usb_storage cmac ccm xt_conntrack xt_MASQUERADE 
nf_conntrack_netlink nfnetlink xt_addrtype iptable_filter iptable_nat 
nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter overlay 
bridge stp llc snd_hda_codec_hdmi bnep uvcvideo videobuf2_vmalloc 
videobuf2_memops videobuf2_v4l2 videobuf2_common btusb videodev btrtl 
btbcm btintel mc bluetooth ecdh_generic ecc crc16 joydev 
intel_spi_platform intel_spi mousedev spi_nor iTCO_wdt mei_wdt 
intel_pmc_bxt mtd mei_hdcp iTCO_vendor_support intel_rapl_msr wmi_bmof 
dell_laptop i915 dell_wmi dell_smbios dell_wmi_descriptor iwlmvm 
x86_pkg_temp_thermal intel_powerclamp coretemp sparse_keymap snd_ctl_led 
dcdbas snd_hda_codec_realtek i2c_algo_bit snd_hda_codec_generic ttm 
ledtrig_audio mac80211 kvm_intel snd_hda_intel libarc4 snd_intel_dspcfg 
dell_smm_hwmon kvm irqbypass rapl intel_cstate iwlwifi 
snd_intel_sdw_acpi drm_kms_helper intel_uncore snd_hda_codec
[ 2213.532656]  pcspkr psmouse processor_thermal_device_pci_legacy 
i2c_i801 cec processor_thermal_device snd_hda_core 
processor_thermal_rfim cfg80211 i2c_smbus processor_thermal_mbox 
intel_gtt intel_pch_thermal agpgart snd_hwdep processor_thermal_rapl 
syscopyarea lpc_ich rfkill snd_pcm sysfillrect intel_rapl_common mei_me 
snd_timer sysimgblt snd soundcore fb_sys_fops intel_soc_dts_iosf mei wmi 
int3403_thermal i2c_hid_acpi video dw_dmac i2c_hid int3402_thermal 
int3400_thermal int340x_thermal_zone acpi_thermal_rel acpi_pad mac_hid 
nls_iso8859_1 vfat fat crypto_user drm fuse ip_tables x_tables btrfs 
blake2b_generic libcrc32c crc32c_generic xor raid6_pq dm_crypt cbc 
encrypted_keys trusted asn1_encoder tee hid_multitouch usbhid dm_mod 
serio_raw rtsx_pci_sdmmc mmc_core atkbd libps2 crct10dif_pclmul 
crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd 
cryptd rtsx_pci xhci_pci xhci_pci_renesas tpm_crb i8042 serio tpm_tis 
tpm_tis_core tpm rng_core pl2303 mos7720 parport
[ 2213.532705] CPU: 2 PID: 3061 Comm: btrfs-transacti Not tainted 
5.14.0-1-git-11152-g78e709522d2c #1 
4337bfa7fd23c500813a836e2184863944fac299
[ 2213.532708] Hardware name: Dell Inc. XPS 13 9343/0X2GW3, BIOS A20 
06/06/2019
[ 2213.532709] RIP: 0010:btrfs_commit_transaction.cold+0xf2/0x2ef 
[btrfs]
[ 2213.532746] Code: 28 48 89 04 24 48 89 c2 49 8b 44 24 28 48 39 c2 75 
30 0f 0b 0f 0b 48 8b 45 50 eb a1 89 de 48 c7 c7 c8 e7 6e c0 e8 2f 4b 3a 
d9 <0f> 0b eb a9 48 8b 7d 50 89 da 48 c7 c6 f8 e7 6e c0 e8 62 ba ff ff
[ 2213.532748] RSP: 0018:ffffaa6401eebde0 EFLAGS: 00010282
[ 2213.532750] RAX: 0000000000000000 RBX: 00000000ffffffe4 RCX: 
0000000000000027
[ 2213.532751] RDX: ffff9be716518728 RSI: 0000000000000001 RDI: 
ffff9be716518720
[ 2213.532752] RBP: ffff9be577d1c8f0 R08: 0000000000000000 R09: 
ffffaa6401eebc10
[ 2213.532754] R10: ffffaa6401eebc08 R11: ffffffff9aaccca8 R12: 
ffff9be55293b200
[ 2213.532755] R13: ffff9be6d303b000 R14: ffff9be577d1c948 R15: 
ffffaa6401eebe78
[ 2213.532756] FS:  0000000000000000(0000) GS:ffff9be716500000(0000) 
knlGS:0000000000000000
[ 2213.532758] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2213.532759] CR2: 000055d4b013fbd0 CR3: 0000000065a10005 CR4: 
00000000003706e0
[ 2213.532760] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 2213.532761] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[ 2213.532763] Call Trace:
[ 2213.532767]  transaction_kthread+0x12e/0x1a0 [btrfs 
1ccea181fc519646bf0a24aa8f854515e5e21f83]
[ 2213.532799]  ? btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs 
1ccea181fc519646bf0a24aa8f854515e5e21f83]
[ 2213.532830]  kthread+0x132/0x160
[ 2213.532834]  ? set_kthread_struct+0x40/0x40
[ 2213.532836]  ret_from_fork+0x22/0x30
[ 2213.532841] ---[ end trace a9ee4fb88980a146 ]---
[ 2213.532843] BTRFS: error (device loop0) in cleanup_transaction:1946: 
errno=-28 No space left
[ 2224.518838] BTRFS warning (device loop0): checksum verify failed on 
21348679680 wanted 0xd05bf9be found 0x2874489b level 1
[ 2227.041189] BTRFS warning (device loop0): checksum verify failed on 
21348679680 wanted 0xd05bf9be found 0x2874489b level 1

This error is weird instead, considering it's mounted ro it shouldn't 
complain about no space being left.

By the way I didn't get any kind of I/O error while restoring avd, home 
or images with btrfs restore: what's the difference with ibadroots?

Niccolò

