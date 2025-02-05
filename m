Return-Path: <linux-btrfs+bounces-11277-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EF4A28373
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 05:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E021667C8
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 04:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9192521D01D;
	Wed,  5 Feb 2025 04:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/n5CzNu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB7E25A647
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 04:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738730924; cv=none; b=s2YwpSTVDqY/WrxbfYD+LopRs9BUkOqZ4i0qBmAhljMAn0Q6wYarR6zcnO6IIvKxPYs9p7thwwkq8sFHouWapr0PzTy8VC0Zpzf9GRzSm7OmML5bK7+CTHBZAg/h6NqgqS7nL39vtbxsjwdN9WGVUqwR4HJcn+TDj+hqz7fFaQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738730924; c=relaxed/simple;
	bh=BPicX5WMqASSYX/QPeUnzRBhx9ISgM5fZcq7YFpSvFo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mSREkuMXXileX5xtsKE3XWtDY3SO4YCuzI5j5y2RbD3y/tM1PXxI90gMzkXkwaXRLzx+MJ/mFtDcgv/sDN/v3ltv6Ik998SNYVeev5Z6axAsNPwIjx1K7pTKdQ96ju4bBldVELz/tFSX8qP2TpZuAulFBoOAAwYbwU9qeKkia08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/n5CzNu; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f9b8ef4261so371605a91.1
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2025 20:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738730922; x=1739335722; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aD4RJ83+ixFalnUlkoGV3e5+qbVdeUFSbVaOYh+AHxM=;
        b=A/n5CzNuJUhNNhaUmo4kCvi0xsb7+T4kRrGLvbrSwt8mA25tHN4uKLpcmYEWMv8dK4
         9ipJ9m0792RKdrOhVyWBKiJ2RM39ACBGcMi6A7n4BBmVfwSTFmdCpBB1zoB1J//ySpUz
         kY4m76zMYgnbZcwNQqhW1s0QIeic4x4I36xiUYGvSOGfRA8mejBDRNpT+7qdo8jXi9k2
         HAwfN2bOw4xjXjU3QHHJeBDeQNjFXnOgjB1qt07O2pb25jDgmzisly9CZXcaMoVMoBld
         3F83dKdEPcJn+QHCVArIOYt5vO3UN+c3q7XFcUili9LSRZ3aj1QhwN4rut2aSEFTHtBj
         6KwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738730922; x=1739335722;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aD4RJ83+ixFalnUlkoGV3e5+qbVdeUFSbVaOYh+AHxM=;
        b=LI+Xg+wdKTK/o3ImMhQ4F0Xu2THI65vl7Rv48c4fCLMxJPLSh/E/jwFl9Q06vDJ2Gh
         45g6DjqnBxc/NrLnQlGcxXlr+zJOTtIuofmBOxYyLsAUVFUFZ56OJKK7cLm9m+xytjb+
         Ql349luScejHaW+O/Cu3NpNUm1FKPTXtUKUs6zATPAgOadsJ7Mnuuo4yFC0bvr4btTeM
         xNJiFlWzH0LOiJ/MJK/Hblc6xDqJRulHWFhcqSyRPmcN4QrdA3VS2QO6FtyMnBSqVoVG
         MSh4rNlMIs42VTqGLwGOuxKK1Dhb7A82kZ9xMn/9MMdH2XuKVdzsr8sWH2NZTCkmJRSJ
         S8Ug==
X-Gm-Message-State: AOJu0YzxC7xEP9WMpuok+G4f+UAetrWniOa+7oIgL2d9NSfeMckEDrQb
	/QgRL/wuvthGkteqD911abQsF2gE1tx9y/uFQD211lDNKKcSEDXP/2LHgsBbRg8bM3z0TO6GRMt
	Zlv6NOVz3+G25PGns0GjngsHcezWKRjMZ
X-Gm-Gg: ASbGncujuSKNWhIluy4hU+lZEJptChR12Y2FBRK27U3Li8NneIVejNJttf8Lw8pQxDq
	voWZBllgZRhPIsDiFbIRQ0HBU/ynAef2mwu8T5dMCScQIPxengQnCAIuOqdhsiX+4KWixVS4=
X-Google-Smtp-Source: AGHT+IEjpGMPyBO2zHjB3ZwwAUd0+O+irizxEiiuAVNYtNO9V9vSveSvAALc1fcJwTlkq25CNh1phu9MCmhfdSkeJPU=
X-Received: by 2002:a17:90b:2f85:b0:2ee:6d73:7ae6 with SMTP id
 98e67ed59e1d1-2f9e087dcafmr808144a91.7.1738730921404; Tue, 04 Feb 2025
 20:48:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eugen Konkov <konkove@gmail.com>
Date: Tue, 4 Feb 2025 23:48:30 -0500
X-Gm-Features: AWEUYZnvRWbVNY_303Innh1k4qoLYhaaDVcomR4L-m9Xp08D_Vwy3rrdbIuUwh8
Message-ID: <CAAwmOLyY8=0_=Mddw5rPnRbxz_Lm6iVde9QVr-3SO3Qy2krP7g@mail.gmail.com>
Subject: Issue mounting device in degraded mode
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

```
[19989.390121] ------------[ cut here ]------------
[19989.390123] BTRFS: Transaction aborted (error -28)
[19989.390178] WARNING: CPU: 4 PID: 25509 at
fs/btrfs/extent-tree.c:3257 __btrfs_free_extent.isra.0+0xc21/0x11a0
[btrfs]
[19989.390269] Modules linked in: xfs jfs nls_ucs2_utils overlay
binfmt_misc snd_hda_codec_hdmi snd_sof_pci_intel_tgl
snd_sof_intel_hda_common soundwire_intel snd_sof_intel_hda_mlink
soundwire_cadence snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp
snd_sof intel_rapl_msr intel_rapl_common snd_sof_utils
snd_hda_codec_realtek intel_uncore_frequency snd_soc_hdac_hda
intel_uncore_frequency_common snd_hda_codec_generic snd_hda_ext_core
snd_soc_acpi_intel_match snd_soc_acpi soundwire_generic_allocation
soundwire_bus snd_soc_core snd_compress ac97_bus snd_pcm_dmaengine
x86_pkg_temp_thermal uvcvideo intel_powerclamp snd_hda_intel
videobuf2_vmalloc coretemp snd_intel_dspcfg uvc snd_intel_sdw_acpi
videobuf2_memops videobuf2_v4l2 snd_usb_audio snd_hda_codec kvm_intel
videodev snd_hda_core snd_usbmidi_lib 8821au(OE) snd_hwdep
videobuf2_common snd_ump mei_pxp mei_hdcp mc nls_iso8859_1
snd_seq_midi snd_pcm cfg80211 kvm input_leds joydev snd_seq_midi_event
irqbypass snd_rawmidi snd_seq rapl intel_cstate snd_seq_device
snd_timer
[19989.390309]  eeepc_wmi cmdlinepart snd spi_nor wmi_bmof mtd ee1004
soundcore mei_me mei intel_pmc_core intel_vsec pmt_telemetry acpi_tad
acpi_pad pmt_class mac_hid sch_fq_codel nfsd msr auth_rpcgss
parport_pc nfs_acl ppdev lockd lp grace parport efi_pstore sunrpc
ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid456
async_raid6_recov async_memcpy async_pq async_xor async_tx xor
raid6_pq libcrc32c raid1 raid0 dm_mirror dm_region_hash dm_log
hid_logitech_hidpp hid_logitech_dj xe drm_gpuvm drm_exec hid_generic
gpu_sched drm_suballoc_helper usbhid drm_ttm_helper hid i915
crct10dif_pclmul crc32_pclmul nvme mfd_aaeon polyval_clmulni drm_buddy
asus_wmi i2c_algo_bit polyval_generic ledtrig_audio nvme_core
ghash_clmulni_intel ttm sparse_keymap sha256_ssse3 spi_intel_pci
platform_profile sha1_ssse3 drm_display_helper i2c_i801 spi_intel
intel_lpss_pci nvme_auth e1000e cec ahci intel_lpss i2c_smbus xhci_pci
libahci idma64 vmd xhci_pci_renesas rc_core video wmi
pinctrl_alderlake aesni_intel crypto_simd cryptd
[19989.390374] CPU: 4 PID: 25509 Comm: btrfs-balance Tainted: G
W  OE      6.8.0-51-generic #52~22.04.1-Ubuntu
[19989.390376] Hardware name: ASUS System Product Name/PRIME H610M-A
D4, BIOS 0412 09/29/2021
[19989.390378] RIP: 0010:__btrfs_free_extent.isra.0+0xc21/0x11a0 [btrfs]
[19989.390432] Code: 9d 60 ff ff ff 44 8b 85 7c ff ff ff ba fb 0c 00
00 89 d9 e9 e7 f8 ff ff 8b b5 7c ff ff ff 48 c7 c7 18 8c 0b c1 e8 7f
22 5e f0 <0f> 0b e9 4c f9 ff ff 8b bd 58 ff ff ff e8 bd d7 fe ff 84 c0
0f 85
[19989.390434] RSP: 0018:ffffad3ea1f6b980 EFLAGS: 00010246
[19989.390436] RAX: 0000000000000000 RBX: 0000000001d44000 RCX: 0000000000000000
[19989.390438] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[19989.390439] RBP: ffffad3ea1f6ba48 R08: 0000000000000000 R09: 0000000000000000
[19989.390440] R10: 0000000000000000 R11: 0000000000000000 R12: fffffffffffffff7
[19989.390441] R13: 0000000000000001 R14: ffff9bd962d5b8f0 R15: ffff9bd947403540
[19989.390443] FS:  0000000000000000(0000) GS:ffff9bdaef600000(0000)
knlGS:0000000000000000
[19989.390444] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[19989.390446] CR2: 00007a0cf1b22c14 CR3: 00000003412da005 CR4: 0000000000f70ef0
[19989.390447] PKRU: 55555554
[19989.390448] Call Trace:
[19989.390450]  <TASK>
[19989.390453]  ? show_regs+0x6d/0x80
[19989.390458]  ? __warn+0x89/0x160
[19989.390461]  ? __btrfs_free_extent.isra.0+0xc21/0x11a0 [btrfs]
[19989.390510]  ? report_bug+0x17e/0x1b0
[19989.390514]  ? handle_bug+0x46/0x90
[19989.390518]  ? exc_invalid_op+0x18/0x80
[19989.390521]  ? asm_exc_invalid_op+0x1b/0x20
[19989.390526]  ? __btrfs_free_extent.isra.0+0xc21/0x11a0 [btrfs]
[19989.390571]  run_delayed_tree_ref+0x92/0x200 [btrfs]
[19989.390616]  btrfs_run_delayed_refs_for_head+0x2db/0x530 [btrfs]
[19989.390654]  __btrfs_run_delayed_refs+0xf9/0x1a0 [btrfs]
[19989.390687]  btrfs_run_delayed_refs+0x84/0x130 [btrfs]
[19989.390723]  btrfs_commit_transaction+0x6a/0xbe0 [btrfs]
[19989.390768]  prepare_to_relocate+0x141/0x1d0 [btrfs]
[19989.390823]  relocate_block_group+0x6a/0x540 [btrfs]
[19989.390872]  ? btrfs_wait_ordered_roots+0x1f8/0x230 [btrfs]
[19989.390920]  ? btrfs_wait_nocow_writers+0x29/0xd0 [btrfs]
[19989.390965]  btrfs_relocate_block_group+0x28c/0x3e0 [btrfs]
[19989.391007]  btrfs_relocate_chunk+0x40/0x1b0 [btrfs]
[19989.391051]  __btrfs_balance+0x325/0x550 [btrfs]
[19989.391115]  btrfs_balance+0x52e/0x990 [btrfs]
[19989.391161]  ? __pfx_balance_kthread+0x10/0x10 [btrfs]
[19989.391201]  balance_kthread+0x74/0x120 [btrfs]
[19989.391239]  kthread+0xef/0x120
[19989.391243]  ? __pfx_kthread+0x10/0x10
[19989.391245]  ret_from_fork+0x44/0x70
[19989.391256]  ? __pfx_kthread+0x10/0x10
[19989.391260]  ret_from_fork_asm+0x1b/0x30
[19989.391265]  </TASK>
[19989.391267] ---[ end trace 0000000000000000 ]---
[19989.391270] BTRFS info (device loop10: state A): dumping space info:
[19989.391273] BTRFS info (device loop10: state A): space_info DATA
has 42926080 free, is full
[19989.391276] BTRFS info (device loop10: state A): space_info
total=462422016, used=419430400, pinned=0, reserved=0, may_use=0,
readonly=65536 zone_unusable=0
[19989.391281] BTRFS info (device loop10: state A): space_info
METADATA has -11010048 free, is full
[19989.391283] BTRFS info (device loop10: state A): space_info
total=52428800, used=589824, pinned=0, reserved=16384,
may_use=11010048, readonly=51822592 zone_unusable=0
[19989.391287] BTRFS info (device loop10: state A): space_info SYSTEM
has 8372224 free, is not full
[19989.391289] BTRFS info (device loop10: state A): space_info
total=8388608, used=16384, pinned=0, reserved=0, may_use=0, readonly=0
zone_unusable=0
[19989.391292] BTRFS info (device loop10: state A): global_block_rsv:
size 5767168 reserved 5767168
[19989.391294] BTRFS info (device loop10: state A): trans_block_rsv:
size 0 reserved 0
[19989.391296] BTRFS info (device loop10: state A): chunk_block_rsv:
size 0 reserved 0
[19989.391299] BTRFS info (device loop10: state A): delayed_block_rsv:
size 0 reserved 0
[19989.391302] BTRFS info (device loop10: state A): delayed_refs_rsv:
size 1048576 reserved 1048576
[19989.391305] BTRFS: error (device loop10: state A) in
__btrfs_free_extent:3257: errno=-28 No space left
[19989.391310] BTRFS info (device loop10: state EA): forced readonly
[19989.391312] BTRFS error (device loop10: state EA): failed to run
delayed ref for logical 30687232 num_bytes 16384 type 176 action 2
ref_mod 1: -28
[19989.391318] BTRFS: error (device loop10: state EA) in
btrfs_run_delayed_refs:2261: errno=-28 No space left
[19989.391346] BTRFS info (device loop10: state EA): 2 enospc errors
during balance
[19989.391350] BTRFS info (device loop10: state EA): balance: ended
with status: -30
```

The one of disks gone. I mounted btrfs in degraded mode and trying to
replace device

```
kes@work /mnt $ sudo btrfs filesystem show  /mnt/raid_test
Label: none  uuid: 1829435a-a68c-464f-9e78-e9ad71ade889
Total devices 2 FS bytes used 400.58MiB
devid    1 size 500.00MiB used 479.00MiB path /dev/loop10
devid    2 size 500.00MiB used 479.00MiB path /dev/loop11

kes@work /mnt $ sudo umount /mnt/raid_test
kes@work /mnt $
kes@work /mnt $ sudo losetup -d /dev/loop10
sudo losetup -d /dev/loop11kes@work /mnt $
kes@work /mnt $ sudo losetup -d /dev/loop10
sudo losetup -d /dev/loop11
losetup: /dev/loop10: detach failed: No such device or address
kes@work /mnt $ sudo losetup -d /dev/loop10
sudo losetup -d /dev/loop11
losetup: /dev/loop10: detach failed: No such device or address
losetup: /dev/loop11: detach failed: No such device or address
kes@work /mnt $
kes@work /mnt $ sudo losetup -d /dev/loop10
sudo losetup -d /dev/loop11
losetup: /dev/loop10: detach failed: No such device or address
losetup: /dev/loop11: detach failed: No such device or address
kes@work /mnt $
kes@work /mnt $
kes@work /mnt $ losetup -a
/dev/loop2: [0042]:5036995 (/home/kes/work/projects/raid/disk3.img)
kes@work /mnt $ sudo losetup -a
/dev/loop2: [0042]:5036995 (/home/kes/work/projects/raid/disk3.img)
kes@work /mnt $
kes@work /mnt $ sudo losetup -a
/dev/loop2: [0042]:5036995 (/home/kes/work/projects/raid/disk3.img)
kes@work /mnt $ sudo losetup -d /dev/loop12
losetup: /dev/loop12: detach failed: No such device or address
kes@work /mnt $ sudo losetup -a
/dev/loop2: [0042]:5036995 (/home/kes/work/projects/raid/disk3.img)
kes@work /mnt $ sudo losetup -d /dev/loop1^C
kes@work /mnt $
kes@work /mnt $
kes@work /mnt $ sudo losetup /dev/loop10 disk1.img
losetup: disk1.img: failed to set up loop device: No such file or directory
kes@work /mnt $
kes@work /mnt $
kes@work /mnt $
kes@work ~/work/projects/raid $ sudo losetup /dev/loop10 disk1.img
kes@work ~/work/projects/raid $
kes@work ~/work/projects/raid $
kes@work ~/work/projects/raid $ sudo mount /dev/loop10 /mnt/raid_test
mount: /mnt/raid_test: mount(2) system call failed: No such file or directory.
kes@work ~/work/projects/raid $
kes@work ~/work/projects/raid $ sudo mount -o degraded /dev/loop10
/mnt/raid_test
kes@work ~/work/projects/raid $
kes@work ~/work/projects/raid $ mount | grep loop
/dev/loop10 on /mnt/raid_test type btrfs
(rw,relatime,degraded,ssd,discard=async,space_cache=v2,subvolid=5,subvol=/)
kes@work ~/work/projects/raid $ sudo btrfs filesystem show  /mnt/raid_test
Label: none  uuid: 1829435a-a68c-464f-9e78-e9ad71ade889
Total devices 2 FS bytes used 400.58MiB
devid    1 size 500.00MiB used 479.00MiB path /dev/loop10
*** Some devices missing

kes@work ~/work/projects/raid $ dd if=/dev/urandom of=replace.img
bs=1M count=500
500+0 records in
500+0 records out
524288000 bytes (524 MB, 500 MiB) copied, 0,973095 s, 539 MB/s
kes@work ~/work/projects/raid $
kes@work ~/work/projects/raid $ sudo btrfs replace start -B 2
/dev/loop12 /mnt/raid_test/
ERROR: cannot check mount status of /dev/loop12: No such device or address
kes@work ~/work/projects/raid $ sudo losetup /dev/loop12 replace.img
kes@work ~/work/projects/raid $
kes@work ~/work/projects/raid $ sudo btrfs replace start -B 2
/dev/loop12 /mnt/raid_test/
Performing full device TRIM /dev/loop12 (500.00MiB) ...
ERROR: ioctl(DEV_REPLACE_START) failed on "/mnt/raid_test/": No space
left on device
```

I am not expecting: No space left on device, because I want to replace
the old device.

