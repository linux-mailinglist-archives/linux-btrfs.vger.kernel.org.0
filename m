Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3388042D296
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 08:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhJNG3M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 02:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhJNG3M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 02:29:12 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4770C061570
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Oct 2021 23:27:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id d9so19770269edh.5
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Oct 2021 23:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=hsjT+I+rPFkoeqv0LAvJhG9CgfvodGmmRTl3NuMCyhE=;
        b=dtNWWVgrKF7RkZfpH10mJTsOnI4yuHBAwTWMoqRNJ7hQ0UPKQYVkB+W191kCh14n3i
         2PgNQSuMOjfrO6AkpHsikuSgkBtBcJT7VgCvAYpxz7XV11thM1Lsvu4WVVjECXrfGIdf
         /ngwj94Cu1A6qbcKSijDID90AjB/kv0DOLPg3nD3rWRkGFXcrqMhb5pUFLiTmOZHeJsw
         zVHRrVtR9D0IBnAOX+A+PU+NfvGlsk8YtszyWePoYxawTYFCTo+3n5KR1e3AJ9Ohs8fB
         ldifc4MrLgsr6vJnMLP/edxDJct4MNruG3mSqsrIWI06M7SKqTYKtNwoJ+nHz8YptLeI
         WJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hsjT+I+rPFkoeqv0LAvJhG9CgfvodGmmRTl3NuMCyhE=;
        b=NZt4giMoU3zdZGQmm8+Rpz87tlbe68mUuWytay13pD8jFEKWtVZwR9PWSbBDoK/kq3
         Uq7hZrnW5cH6MtR11Hurg0lOoLuc9MGJlWPmi1IsIZHISQ5a6RYnmX6CPlt88RGvP57z
         Y08tfDIfGl/JdbmOGDU2vBkM/6H6QWaGFSBqG7ujcXkEGGnMwZSVXDcvvuMU1rUmgsEW
         3hdL8iIADI2cVaCADFUc0VX/E550wDQLhxLe+c8RaqT12sFJoGlPTUZhEEkrnWOsGLfa
         tYfsbZRE5KpjCv24J3+v/pg/NMd5nrttmJ/ZVVVkZxMm4Itn5uAG9Pdm8R+iEyHGP8+y
         0e3w==
X-Gm-Message-State: AOAM530xh8K3Pq+gQ9shMF3D/Xt0ThxsmbXyMPkpvB4lI/hsWHbtDb3Q
        JTLNfyM/T+E9RXryBS6HRmAYUcyBjjZl2DpkIJp5baKQI5NGHw==
X-Google-Smtp-Source: ABdhPJwa1Q0wFVKR1GOyOpu7aVCUvRRb2SvOJ9rJ+a1rffVpjou/3tXFVWHeATablXBo+CfoZZ6/nzLiYLjraZZKXDI=
X-Received: by 2002:a17:906:3411:: with SMTP id c17mr1615563ejb.290.1634192826043;
 Wed, 13 Oct 2021 23:27:06 -0700 (PDT)
MIME-Version: 1.0
From:   pk <pkoroau@gmail.com>
Date:   Thu, 14 Oct 2021 08:26:54 +0200
Message-ID: <CAMNwjE+GC_beYGCB3oWnkEi6EM0pyxf6uLwHN=6znTjDsn5d5g@mail.gmail.com>
Subject: Cannot resize, Read-only filesystem
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have Debian 11 on a Mac with an SSD and kernel package
5.10.0-9-amd64 (Linux 5.10.70-1). sda4 is mounted on /sda4. A loop
file from under /sda4 (fallocate -l 5G, chattr +C) is a LUKS, mapped
to /dev/mapper/luksdev, with a btrfs, which works fine in heavy
everyday usage.

I try to shrink /dev/sda4 with GParted, with both filesystems mounted,
but ''btrfs filesystem resize 2:19986432K /sda4'' sets the loop device
read-only and fails.

/dev/sda4
- mount options
rw,relatime,compress=zlib:3,ssd,space_cache,subvolid=5,subvol=/
- btrfs filesystem show
  Total devices 1 FS bytes used 14.57GiB
  devid    2 size 37.61GiB used 34.42GiB path /dev/sda4
- GParted numbers:
  Reduce /dev/sda4 from 37.61 GiB to 19.06 GiB
  Begins at 119062528 Ends at 197926911 Size: 78864384 (37.61 GiB)

/dev/mapper/luksdev
- mount options
rw,relatime,compress=zlib:3,ssd,space_cache,subvolid=5,subvol=/
- btrfs filesystem show
  Total devices 1 FS bytes used 3.86GiB
  devid    1 size 5.00GiB used 5.00GiB path /dev/mapper/luksdev

Here is dmesg.

[  726.388711] BTRFS info (device sda4): resizing devid 2
[  726.467885] ------------[ cut here ]------------
[  726.467894] BTRFS: Transaction aborted (error -28)
[  726.468021] WARNING: CPU: 1 PID: 2571 at
fs/btrfs/free-space-cache.c:281
btrfs_truncate_free_space_cache+0x1ce/0x200 [btrfs]
[  726.468026] Modules linked in: xfs xt_CHECKSUM nft_chain_nat
xt_MASQUERADE nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
nft_counter xt_tcpudp nft_compat bridge stp llc nf_tables rfcomm
nfnetlink cmac algif_hash algif_skcipher af_alg bnep loop
snd_hda_codec_hdmi snd_hda_codec_cirrus snd_hda_codec_generic
ledtrig_audio snd_hda_intel snd_intel_dspcfg soundwire_intel
soundwire_generic_allocation intel_rapl_msr joydev snd_soc_core
intel_rapl_common btusb btrtl snd_compress btbcm btintel
x86_pkg_temp_thermal intel_powerclamp soundwire_cadence bluetooth
coretemp mei_hdcp snd_hda_codec uvcvideo videobuf2_vmalloc wl(POE)
kvm_intel videobuf2_memops jitterentropy_rng snd_hda_core kvm
videobuf2_v4l2 videobuf2_common snd_hwdep applesmc soundwire_bus
irqbypass drbg videodev snd_pcm rapl ansi_cprng bcm5974 mc
intel_cstate cfg80211 ecdh_generic ecc snd_timer intel_uncore
apple_mfi_fastcharge iTCO_wdt efi_pstore snd sg rfkill intel_pmc_bxt
pcspkr sbs acpi_als iTCO_vendor_support soundcore kfifo_buf
[  726.468115]  watchdog mei_me mei industrialio sbshc evdev apple_bl
ac parport_pc ppdev lp parport fuse configfs efivarfs ip_tables
x_tables autofs4 btrfs blake2b_generic ext4 crc16 mbcache jbd2
dm_crypt dm_mod raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0
multipath linear md_mod vfat fat uas usb_storage nls_cp437 nls_ascii
sd_mod t10_pi crc_t10dif crct10dif_generic hid_apple hid_generic
usbhid hid i915 crct10dif_pclmul crct10dif_common crc32_pclmul
crc32c_intel ghash_clmulni_intel ahci libahci aesni_intel libata
i2c_algo_bit libaes crypto_simd drm_kms_helper scsi_mod ehci_pci
cryptd glue_helper uhci_hcd ehci_hcd cec i2c_i801 i2c_smbus drm
usbcore lpc_ich usb_common video button
[  726.468218] CPU: 1 PID: 2571 Comm: btrfs Tainted: P           OE
 5.10.0-9-amd64 #1 Debian 5.10.70-1
[  726.468222] Hardware name: ...
[  726.468271] RIP: 0010:btrfs_truncate_free_space_cache+0x1ce/0x200 [btrfs]
[  726.468277] Code: 55 50 f0 48 0f ba aa 40 0a 00 00 02 72 22 83 f8
fb 74 40 83 f8 e2 74 3b 89 c6 48 c7 c7 60 86 c8 c0 89 44 24 04 e8 85
dd 65 cd <0f> 0b 8b 44 24 04 89 c1 ba 19 01 00 00 48 89 ef 89 44 24 04
48 c7
[  726.468281] RSP: 0018:ffffb080c2923c00 EFLAGS: 00010286
[  726.468285] RAX: 0000000000000000 RBX: ffff8bed4a229400 RCX: ffff8bedaba98a08
[  726.468289] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff8bedaba98a00
[  726.468292] RBP: ffff8bed883d1bc8 R08: 0000000000000000 R09: ffffb080c2923a20
[  726.468295] R10: ffffb080c2923a18 R11: ffffffff8f0cb428 R12: ffff8bed85bbafd0
[  726.468299] R13: ffff8beda7c5b8c0 R14: ffff8bed60e53000 R15: ffff8bed4a229410
[  726.468303] FS:  00007f23351b19c0(0000) GS:ffff8bedaba80000(0000)
knlGS:0000000000000000
[  726.468306] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  726.468310] CR2: 000055bbd9cdc000 CR3: 0000000022840003 CR4: 00000000000606e0
[  726.468312] Call Trace:
[  726.468365]  delete_block_group_cache+0x6f/0xb0 [btrfs]
[  726.468412]  btrfs_relocate_block_group+0xd3/0x300 [btrfs]
[  726.468455]  btrfs_relocate_chunk+0x27/0xc0 [btrfs]
[  726.468495]  btrfs_shrink_device+0x1fa/0x550 [btrfs]
[  726.468536]  btrfs_ioctl_resize+0x3a1/0x3d0 [btrfs]
[  726.468577]  btrfs_ioctl+0x182b/0x3050 [btrfs]
[  726.468588]  ? __x64_sys_ioctl+0x83/0xb0
[  726.468592]  __x64_sys_ioctl+0x83/0xb0
[  726.468599]  do_syscall_64+0x33/0x80
[  726.468604]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  726.468608] RIP: 0033:0x7f2335374cc7
[  726.468613] Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 91 0c 00 f7 d8 64 89
01 48
[  726.468616] RSP: 002b:00007ffd45be11e8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  726.468621] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2335374cc7
[  726.468624] RDX: 00007ffd45be1298 RSI: 0000000050009403 RDI: 0000000000000003
[  726.468627] RBP: 00007ffd45be2efb R08: 00007ffd45be12a0 R09: 000000000000002c
[  726.468630] R10: 0000000000000012 R11: 0000000000000246 R12: 0000000000000003
[  726.468633] R13: 00007ffd45be1298 R14: 00007ffd45be2eef R15: 0000560f8b655504
[  726.468638] ---[ end trace cdaebc86e0440930 ]---
[  726.468645] BTRFS warning (device sda4):
btrfs_truncate_free_space_cache:281: Aborting unused transaction(No
space left).
[  726.468802] BTRFS info (device sda4): relocating block group
91985543168 flags data
[  726.479354] BTRFS warning (device sda4): Skipping commit of aborted
transaction.
[  726.479362] BTRFS: error (device sda4) in cleanup_transaction:1944:
errno=-30 Readonly filesystem
[  726.479365] BTRFS info (device sda4): forced readonly
[  756.805764] loop: Write error at byte offset 1537089536, length 4096.
[  756.805807] blk_update_request: I/O error, dev loop0, sector
3002128 op 0x1:(WRITE) flags 0x800 phys_seg 14 prio class 0
[  756.805842] BTRFS error (device dm-1): bdev /dev/mapper/luksdev
errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
[  756.806783] loop: Write error at byte offset 1537089536, length 4096.
[  756.806812] blk_update_request: I/O error, dev loop0, sector
3002128 op 0x1:(WRITE) flags 0x800 phys_seg 8 prio class 0
[  756.806839] BTRFS error (device dm-1): bdev /dev/mapper/luksdev
errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
[  756.807900] loop: Write error at byte offset 1540784128, length 4096.
[  756.807927] blk_update_request: I/O error, dev loop0, sector
3009344 op 0x1:(WRITE) flags 0x800 phys_seg 30 prio class 0
[  756.807959] BTRFS error (device dm-1): bdev /dev/mapper/luksdev
errs: wr 3, rd 0, flush 0, corrupt 0, gen 0
[  756.808389] loop: Write error at byte offset 1537089536, length 4096.
[  756.808417] blk_update_request: I/O error, dev loop0, sector
3002128 op 0x1:(WRITE) flags 0x800 phys_seg 3 prio class 0
[  756.808443] BTRFS error (device dm-1): bdev /dev/mapper/luksdev
errs: wr 4, rd 0, flush 0, corrupt 0, gen 0
[  756.809246] loop: Write error at byte offset 1540784128, length 4096.
[  756.809264] blk_update_request: I/O error, dev loop0, sector
3009344 op 0x1:(WRITE) flags 0x800 phys_seg 19 prio class 0
[  756.809286] BTRFS error (device dm-1): bdev /dev/mapper/luksdev
errs: wr 5, rd 0, flush 0, corrupt 0, gen 0
[  756.809557] loop: Write error at byte offset 117686272, length 4096.
[  756.809570] blk_update_request: I/O error, dev loop0, sector 229856
op 0x1:(WRITE) flags 0x1800 phys_seg 1 prio class 0
[  756.809581] BTRFS error (device dm-1): bdev /dev/mapper/luksdev
errs: wr 6, rd 0, flush 0, corrupt 0, gen 0
[  756.810034] loop: Write error at byte offset 121847808, length 4096.
[  756.810047] blk_update_request: I/O error, dev loop0, sector 237984
op 0x1:(WRITE) flags 0x1800 phys_seg 22 prio class 0
[  756.810061] BTRFS error (device dm-1): bdev /dev/mapper/luksdev
errs: wr 7, rd 0, flush 0, corrupt 0, gen 0
[  756.810093] loop: Write error at byte offset 123256832, length 4096.
[  756.810111] blk_update_request: I/O error, dev loop0, sector 240736
op 0x1:(WRITE) flags 0x1800 phys_seg 3 prio class 0
[  756.810127] BTRFS error (device dm-1): bdev /dev/mapper/luksdev
errs: wr 8, rd 0, flush 0, corrupt 0, gen 0
[  756.810707] loop: Write error at byte offset 124600320, length 4096.
[  756.810722] blk_update_request: I/O error, dev loop0, sector 243360
op 0x1:(WRITE) flags 0x1800 phys_seg 8 prio class 0
[  756.810740] BTRFS error (device dm-1): bdev /dev/mapper/luksdev
errs: wr 9, rd 0, flush 0, corrupt 0, gen 0
[  756.810956] loop: Write error at byte offset 126025728, length 4096.
[  756.810970] blk_update_request: I/O error, dev loop0, sector 246144
op 0x1:(WRITE) flags 0x1800 phys_seg 4 prio class 0
[  756.810985] BTRFS error (device dm-1): bdev /dev/mapper/luksdev
errs: wr 10, rd 0, flush 0, corrupt 0, gen 0
[  756.812156] BTRFS: error (device dm-1) in
btrfs_commit_transaction:2389: errno=-5 IO failure (Error while
writing out transaction)
[  756.812161] BTRFS info (device dm-1): forced readonly
[  756.812165] BTRFS warning (device dm-1): Skipping commit of aborted
transaction.
[  756.812168] BTRFS: error (device dm-1) in cleanup_transaction:1944:
errno=-5 IO failure
