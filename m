Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC6641528FB
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 11:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgBEKSe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 05:18:34 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36130 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbgBEKSe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Feb 2020 05:18:34 -0500
Received: by mail-ot1-f66.google.com with SMTP id j20so1434100otq.3
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Feb 2020 02:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MUBgMS+0ygpQqHJsxkHuCjolYZz8rq72Ogq0qcwbNfs=;
        b=m7OVXPTo1JrxaUh1mwfKU6E2fJGC6nzw2D6HLy6Uyif8jV0cZrB82MKerc6ANju2TR
         pPUn1eVIckqw+Q2HjL3hGlUzOT7tFvHn4tiEAULolo+7ZsOf9bI3twmp1DUs6+hHWTQP
         B8FKlMCPXKB2FRVQOYvF3NNm4pdl1mylQYugs54BGYOetB9TM7HfFPAXS8q79PYH0LY7
         g+6vkL7gMxZlvU4lGQCJN+pFSoVASuYE9xxI7RySGEyrdJ7zDPKwbh+MvvaJ4TmFOT4e
         Byn/NZT3TbLa/c7LmrfHkSrcywfLcgr1ZFrGx7oB1Ka0N4R0v/MEp7H2G/uV9BesK+8r
         d+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MUBgMS+0ygpQqHJsxkHuCjolYZz8rq72Ogq0qcwbNfs=;
        b=JzZKCGLqD/F4Bo223R/TPpupPbWP7vbYw4FyHNXCTfsIlvJ+YvcCH5WtDJC3VnwLF5
         LO0OB9r0+16sM9kTd4SmA/ApifDF/yjkpqwULW46DHkZCdbcREA/pdpJ1UPni6v+/j43
         rNCekidGAeDOfnbdjXOz/r/0AR8Op1PSTB3m0QwDl2pKCV3b9x0wvfFvn1yOIFfJzymy
         6l0THEe3b7wO5UsiAdXwDU+eZLrviFa4JPCW8M47wtD6eDNqYXJtF3OwWkvErgKOytEg
         pHU1lSAyZgVUcUyz6oD2FsR3J0Po54GdFUytly3i81dpsc18vMHK/onxznXrfskQ+ic+
         jSHw==
X-Gm-Message-State: APjAAAUZe4DNsszZ4SHBn9Hv47XLpb9lkF5S0oTQEyWl343XqO3De9k+
        yDJgs+OPEPnMPU3VcQco62igzvQPCefety4FVT6zLcrjY/8=
X-Google-Smtp-Source: APXvYqxhJxXMLUjAgB6JSvdGrVuDUrt6sEF0RgNorzziykfJLljHOQTlIQwc0vRraS++OGF0og+SxHusgIfUjXSMfaU=
X-Received: by 2002:a05:6830:1e95:: with SMTP id n21mr26133596otr.25.1580897911744;
 Wed, 05 Feb 2020 02:18:31 -0800 (PST)
MIME-Version: 1.0
From:   Chiung-Ming Huang <photon3108@gmail.com>
Date:   Wed, 5 Feb 2020 18:18:20 +0800
Message-ID: <CAEOGEKHSFCNMpSpNTOxrkDgW_7v5oJzU5rBUSgYZoB8eVZjV_A@mail.gmail.com>
Subject: How to Fix 'Error: could not find extent items for root 257'?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi everyone

It's a long story. I try to describe it shortly. My btrfs RAID1
includes 5 HDDs, 10Tx2, 1Tx1, 2Tx1 and 3Tx1. They all based on bcache
(1Tx1 SSD as cache) and luks. I tried to reorder it to ` Luks -->
Bcache --> SSD --> HDD` with only one layer of luks on bcache. But I
failed because of power-off accidentally. Please help me to fix it.
Thanks.

1. OS: Ubuntu 18.04

2. $ uname -a
Linux rescue 5.3.0-26-generic #28~18.04.1-Ubuntu SMP Wed Dec 18
16:40:14 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

3. $ btrfs --version
btrfs-progs v5.4.1

4. $ btrfs fi show
Label: none  uuid: 0b79cf54-c424-40ed-adca-bd66b38ad57a
        Total devices 5 FS bytes used 496.00KiB
        devid    1 size 9.09TiB used 3.93TiB path /dev/bcache2
        devid    3 size 2.73TiB used 746.00GiB path /dev/bcache3
        devid    5 size 9.09TiB used 7.09TiB path /dev/bcache4
        devid    6 size 931.51GiB used 0.00B path /dev/mapper/disk-1t
        devid    7 size 1.82TiB used 0.00B path /dev/mapper/disk-2t

5. $ mount /dev/bcache4 /mnt
It showed the second part of messages after about 10 seconds and
remount it as readonly
------------------ dmesg part 1/2 ------------------

[Wed Feb  5 17:09:04 2020] BTRFS info (device bcache2): disk space
caching is enabled
[Wed Feb  5 17:09:04 2020] BTRFS info (device bcache2): has skinny
extents
[Wed Feb  5 17:09:04 2020] BTRFS info (device bcache2): bdev
/dev/bcache2 errs: wr 0, rd 0, flush 0, corrupt 266140, gen 8928
[Wed Feb  5 17:09:04 2020] BTRFS info (device bcache2): bdev
/dev/bcache3 errs: wr 0, rd 0, flush 0, corrupt 0, gen 3
[Wed Feb  5 17:09:04 2020] BTRFS info (device bcache2): enabling ssd
optimizations
[Wed Feb  5 17:09:04 2020] BTRFS info (device bcache2): checking UUID
tree
[Wed Feb  5 17:09:04 2020] BTRFS error (device bcache2): tree level
mismatch detected, bytenr=3D19499133206528 level expected=3D0 has=3D2
[Wed Feb  5 17:09:04 2020] BTRFS error (device bcache2): tree level
mismatch detected, bytenr=3D19499133206528 level expected=3D0 has=3D2
[Wed Feb  5 17:09:04 2020] BTRFS warning (device bcache2): iterating
uuid_tree failed -117
btrfs fi df /

------------------ dmesg part 2/2 ------------------

[Wed Feb  5 17:09:36 2020] BTRFS error (device bcache2): tree block
14963956514816 owner 3 already locked by pid=3D3187, extent tree
corruption detected
[Wed Feb  5 17:09:36 2020] ------------[ cut here ]------------
[Wed Feb  5 17:09:36 2020] BTRFS: Transaction aborted (error -117)
[Wed Feb  5 17:09:36 2020] WARNING: CPU: 4 PID: 3187 at
/build/linux-hwe-3HpQOB/linux-hwe-5.3.0/fs/btrfs/volumes.c:3025
btrfs_remove_chunk+0x76e/0x8a0 [btrfs]
[Wed Feb  5 17:09:36 2020] Modules linked in: cmac bnep nls_iso8859_1
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic
ledtrig_audio snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep
edac_mce_amd kvm_amd snd_pcm ccp kvm snd_seq_midi snd_seq_midi_event
irqby
pass k10temp snd_rawmidi btusb fam15h_power btrtl btbcm btintel joydev
nouveau snd_seq input_leds bluetooth snd_seq_device mxm_wmi snd_timer
video ecdh_generic snd ecc ttm i2c_algo_bit soundcore mac_hid
sch_fq_codel parport_pc ppdev lp parport ip_tables x_tables autofs4 b
trfs xor zstd_compress raid6_pq libcrc32c algif_skcipher af_alg
dm_crypt hid_logitech_hidpp bcache crc64 hid_logitech_dj hid_generic
usbhid hid uas usb_storage nvidia_drm(POE) nvidia_modeset(POE)
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel
nvidia(POE) ae
s_x86_64 crypto_simd drm_kms_helper syscopyarea cryptd sysfillrect
glue_helper sysimgblt fb_sys_fops drm r8169 nvme realtek i2c_piix4
ahci ipmi_devintf nvme_core(E) libahci ipmi_msghandler wmi
[Wed Feb  5 17:09:36 2020] CPU: 4 PID: 3187 Comm: btrfs-cleaner
Tainted: P        W  OE     5.3.0-26-generic #28~18.04.1-Ubuntu
[Wed Feb  5 17:09:36 2020] Hardware name: MSI MS-7974/970A-G43 PLUS
(MS-7974), BIOS V1.1 07/04/2016
[Wed Feb  5 17:09:36 2020] RIP: 0010:btrfs_remove_chunk+0x76e/0x8a0 [btrfs]
[Wed Feb  5 17:09:36 2020] Code: 48 8b 50 50 f0 48 0f ba aa 40 ce 00
00 02 8b 45 a0 72 1c 83 f8 fb 0f 84 af 00 00 00 89 c6 48 c7 c7 f0 52
7d c1 e8 72 fa 73 eb <0f> 0b 8b 45 a0 48 8b 7d 90 89 c1 ba d1 0b 00 00
48 c7 c6 90 54 7c
[Wed Feb  5 17:09:36 2020] RSP: 0018:ffffa7a5035d3d98 EFLAGS: 00010282
[Wed Feb  5 17:09:36 2020] RAX: 0000000000000000 RBX: 0000000040000000
RCX: 0000000000000006
[Wed Feb  5 17:09:36 2020] RDX: 0000000000000007 RSI: 0000000000000092
RDI: ffff97cea7b17440
[Wed Feb  5 17:09:36 2020] RBP: ffffa7a5035d3e48 R08: 00000000000005d3
R09: 0000000000000004
[Wed Feb  5 17:09:36 2020] R10: 00000000ffffffff R11: 0000000000000001
R12: ffff97ce9b647c00
[Wed Feb  5 17:09:36 2020] R13: ffff97ce95c2e800 R14: ffff97ce9c1d03b8
R15: ffff97ce9253ec40
[Wed Feb  5 17:09:36 2020] FS:  0000000000000000(0000)
GS:ffff97cea7b00000(0000) knlGS:0000000000000000
[Wed Feb  5 17:09:36 2020] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[Wed Feb  5 17:09:36 2020] CR2: 000055b322010290 CR3: 000000061d628000
CR4: 00000000000406e0
[Wed Feb  5 17:09:36 2020] Call Trace:
[Wed Feb  5 17:09:36 2020]  btrfs_delete_unused_bgs+0x36a/0x490 [btrfs]
[Wed Feb  5 17:09:36 2020]  cleaner_kthread+0xed/0x130 [btrfs]
[Wed Feb  5 17:09:36 2020]  kthread+0x121/0x140
[Wed Feb  5 17:09:36 2020]  ? __btrfs_btree_balance_dirty+0x60/0x60 [btrfs]
[Wed Feb  5 17:09:36 2020]  ? kthread_park+0xb0/0xb0
[Wed Feb  5 17:09:36 2020]  ret_from_fork+0x22/0x40
[Wed Feb  5 17:09:36 2020] ---[ end trace c34270cb20778d7d ]---
[Wed Feb  5 17:09:36 2020] BTRFS: error (device bcache2) in
btrfs_remove_chunk:3025: errno=3D-117 unknown
[Wed Feb  5 17:09:36 2020] BTRFS info (device bcache2): forced readonly
[Wed Feb  5 17:09:36 2020] ------------[ cut here ]------------
[Wed Feb  5 17:09:36 2020] WARNING: CPU: 4 PID: 3187 at
/build/linux-hwe-3HpQOB/linux-hwe-5.3.0/fs/btrfs/space-info.h:106
btrfs_space_info_update_bytes_may_use.part.10+0x14/0x21 [btrfs]
[Wed Feb  5 17:09:36 2020] Modules linked in: cmac bnep nls_iso8859_1
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic
ledtrig_audio snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep
edac_mce_amd kvm_amd snd_pcm ccp kvm snd_seq_midi snd_seq_midi_event
irqby
pass k10temp snd_rawmidi btusb fam15h_power btrtl btbcm btintel joydev
nouveau snd_seq input_leds bluetooth snd_seq_device mxm_wmi snd_timer
video ecdh_generic snd ecc ttm i2c_algo_bit soundcore mac_hid
sch_fq_codel parport_pc ppdev lp parport ip_tables x_tables autofs4 b
trfs xor zstd_compress raid6_pq libcrc32c algif_skcipher af_alg
dm_crypt hid_logitech_hidpp bcache crc64 hid_logitech_dj hid_generic
usbhid hid uas usb_storage nvidia_drm(POE) nvidia_modeset(POE)
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel
nvidia(POE) ae
s_x86_64 crypto_simd drm_kms_helper syscopyarea cryptd sysfillrect
glue_helper sysimgblt fb_sys_fops drm r8169 nvme realtek i2c_piix4
ahci ipmi_devintf nvme_core(E) libahci ipmi_msghandler wmi
[Wed Feb  5 17:09:36 2020] CPU: 4 PID: 3187 Comm: btrfs-cleaner
Tainted: P        W  OE     5.3.0-26-generic #28~18.04.1-Ubuntu
[Wed Feb  5 17:09:36 2020] Hardware name: MSI MS-7974/970A-G43 PLUS
(MS-7974), BIOS V1.1 07/04/2016
[Wed Feb  5 17:09:36 2020] RIP:
0010:btrfs_space_info_update_bytes_may_use.part.10+0x14/0x21 [btrfs]
[Wed Feb  5 17:09:36 2020] Code: 74 05 e8 22 a5 6d eb 48 8d 65 d8 5b
41 5a 41 5c 41 5d 41 5e 5d c3 55 48 89 e5 53 48 89 fb 48 c7 c7 e8 a4
7d c1 e8 d2 84 74 eb <0f> 0b 48 c7 43 28 00 00 00 00 5b 5d c3 55 48 89
e5 53 48 89 fb 48
[Wed Feb  5 17:09:36 2020] RSP: 0018:ffffa7a5035d3ca8 EFLAGS: 00010286
[Wed Feb  5 17:09:36 2020] RAX: 0000000000000024 RBX: ffff97ce96ed5800
RCX: 0000000000000006
[Wed Feb  5 17:09:36 2020] RDX: 0000000000000000 RSI: 0000000000000092
RDI: ffff97cea7b17440
[Wed Feb  5 17:09:36 2020] RBP: ffffa7a5035d3cb0 R08: 00000000000005ed
R09: 0000000000000004
[Wed Feb  5 17:09:36 2020] R10: 0000000000000002 R11: 0000000000000001
R12: ffff97ce96ed5800
[Wed Feb  5 17:09:36 2020] R13: 0000000000080000 R14: 000000000007c000
R15: ffff97ce9c1d0000
[Wed Feb  5 17:09:36 2020] FS:  0000000000000000(0000)
GS:ffff97cea7b00000(0000) knlGS:0000000000000000
[Wed Feb  5 17:09:36 2020] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[Wed Feb  5 17:09:36 2020] CR2: 000055b322010290 CR3: 000000061d628000
CR4: 00000000000406e0
[Wed Feb  5 17:09:36 2020] Call Trace:
[Wed Feb  5 17:09:36 2020]  btrfs_space_info_add_old_bytes+0x261/0x280 [btr=
fs]
[Wed Feb  5 17:09:36 2020]  __btrfs_block_rsv_release+0x16e/0x1a0 [btrfs]
[Wed Feb  5 17:09:36 2020]  btrfs_trans_release_chunk_metadata+0x35/0x50 [b=
trfs]
[Wed Feb  5 17:09:36 2020]
btrfs_create_pending_block_groups+0x13d/0x240 [btrfs]
[Wed Feb  5 17:09:36 2020]  __btrfs_end_transaction+0x6e/0x1e0 [btrfs]
[Wed Feb  5 17:09:36 2020]  btrfs_end_transaction+0x10/0x20 [btrfs]
[Wed Feb  5 17:09:36 2020]  btrfs_delete_unused_bgs+0x28b/0x490 [btrfs]
[Wed Feb  5 17:09:36 2020]  cleaner_kthread+0xed/0x130 [btrfs]
[Wed Feb  5 17:09:36 2020]  kthread+0x121/0x140
[Wed Feb  5 17:09:36 2020]  ? __btrfs_btree_balance_dirty+0x60/0x60 [btrfs]
[Wed Feb  5 17:09:36 2020]  ? kthread_park+0xb0/0xb0
[Wed Feb  5 17:09:36 2020]  ret_from_fork+0x22/0x40
[Wed Feb  5 17:09:36 2020] ---[ end trace c34270cb20778d7e ]---

6. $ btrfs fi df /mnt
Data, RAID1: total=3D4.21TiB, used=3D0.00B
Data, single: total=3D3.30TiB, used=3D0.00B
System, RAID1: total=3D32.00MiB, used=3D0.00B
Metadata, RAID1: total=3D12.00GiB, used=3D496.00KiB
Metadata, single: total=3D8.00GiB, used=3D0.00B
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

7. $ btrfs check -p /dev/bcache4
Opening filesystem to check...
Checking filesystem on /dev/bcache4
UUID: 0b79cf54-c424-40ed-adca-bd66b38ad57a
Error: could not find extent items for root 257(0:00:00 elapsed, 1199
items checked)
[1/7] checking root items                      (0:00:00 elapsed, 7748
items checked)
ERROR: failed to repair root items: No such file or directory

8. $ btrfs scrub start -B -R /mnt
The status is aborted because the file system was forcely re-mounted readon=
ly.

9. $ lsblk -o NAME,SIZE,TYPE,FSTYPE
sda                     931.5G disk  bcache
=E2=94=94=E2=94=80bcache0               931.5G disk  crypto_LUKS
  =E2=94=94=E2=94=80disk-1t                931.5G crypt btrfs
sdb                     232.9G disk
=E2=94=94=E2=94=80sdb6                     10G part  crypto_LUKS
  =E2=94=94=E2=94=80rescue                 10G crypt btrfs
sdc                       2.7T disk  crypto_LUKS
=E2=94=94=E2=94=80disk-3t             2.7T crypt bcache
  =E2=94=94=E2=94=80bcache3               2.7T disk  btrfs
sdd                       9.1T disk  crypto_LUKS
=E2=94=94=E2=94=80disk-10t           9.1T crypt bcache
  =E2=94=94=E2=94=80bcache2               9.1T disk  btrfs
sde                       1.8T disk  bcache
=E2=94=94=E2=94=80bcache1                 1.8T disk  crypto_LUKS
  =E2=94=94=E2=94=80disk-2t          1.8T crypt btrfs
sdf                       9.1T disk  crypto_LUKS
=E2=94=94=E2=94=80disk-10t          9.1T crypt bcache
  =E2=94=94=E2=94=80bcache4               9.1T disk  btrfs
nvme0n1                 953.9G disk
=E2=94=94=E2=94=80nvme0n1p1               636G part  crypto_LUKS
  =E2=94=94=E2=94=80cache                 636G crypt bcache
    =E2=94=9C=E2=94=80bcache0           931.5G disk  crypto_LUKS
    =E2=94=82 =E2=94=94=E2=94=80disk-1t           931.5G crypt btrfs
    =E2=94=9C=E2=94=80bcache1             1.8T disk  crypto_LUKS
    =E2=94=82 =E2=94=94=E2=94=80disk-2t          1.8T crypt btrfs
    =E2=94=9C=E2=94=80bcache2             9.1T disk  btrfs
    =E2=94=9C=E2=94=80bcache3             2.7T disk  btrfs
    =E2=94=94=E2=94=80bcache4             9.1T disk  btrfs


Regards,
Chiung-Ming Huang
