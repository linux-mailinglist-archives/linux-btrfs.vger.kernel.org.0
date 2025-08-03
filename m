Return-Path: <linux-btrfs+bounces-15814-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F93B194FB
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Aug 2025 21:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E17173220
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Aug 2025 19:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956F722EE5;
	Sun,  3 Aug 2025 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxIryxRY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02561F92E
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Aug 2025 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754248926; cv=none; b=AxXrc+AQ+bcOFtTOWhXAhBEz7R18i38FXAJMcb2pKJdpgwXeuMTZZh6YBps6zv/EYj1KjxIP7Vtx3wLbMu70jhV2JRz3NCBTODPXynX7XOcX80gjwmhqIPcDsPj/I+t+/+nX6Lb+1psJ100d+nZZhXVy0aca48XptSezIyqeU/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754248926; c=relaxed/simple;
	bh=klfH/Etp4nlAIxtZRhvFycwIVd75mXEDYz1PrQ6IWBg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SYX/gamFF2keCpWhQG2DpD7EUw24RRFiJvMvHU5lu9weDgTd39y2K34jNyjpjehrJ54xqMFelslg3iJW94FpCPL6jBr+RY6TRpKsqECQOGH6iFytYDK5O9T9fZe+LvteHFHQRXjOTcor8M1bwGgj+8A1cW/t42j2e4Jt23ksXmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxIryxRY; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55b8a7a505cso3464474e87.0
        for <linux-btrfs@vger.kernel.org>; Sun, 03 Aug 2025 12:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754248923; x=1754853723; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R203PsSVXP6J3pDRCJ8EZq5Qb2F5hylqiun2/KKMiWI=;
        b=FxIryxRYqZxHIWM4GnCwUmWRtLNsFqRaHo1/5d0ZAYRC39IlpZIwWuJpscTjHEFzLO
         8pRVeqaJs1R8vRKBAU2UXS9pjBHLmMWJSKkiuBCMZ/Q1gqBGA1N8DJVAGQirk5RkLY8C
         qYMofWjOy6NQM6QhmPrXL0MfSft0a6KLOnTMWXM4kMaRJnZxxVFRNJ8hK7I6vkhHDWAV
         BU/cJ1yVAkEbojTNxnVYuegBcG1oW8HjGjK+DsWipZQkCw8aCR7r7bYcYl5TrX4TFeeQ
         y7LORxq2r1WXpc7YDAu+mLWJO4koixGsEZrY0cJCY+o9mat0amHe4cAxZVP7oEzrUkNX
         uaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754248923; x=1754853723;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R203PsSVXP6J3pDRCJ8EZq5Qb2F5hylqiun2/KKMiWI=;
        b=BVYgkwqCsAh2pW8E/pAH9QR0Km5W3IawCvcg0p2NkkOPyYEGSZFKmmeujKr+nspuTO
         1NEtyabFf4JnvkkuHiaALygMyex+i7ccif6IniE94+Bgx/pcm1N2VCK5FlfDoYpqiHVG
         yB6fKgG1q7d0YWVBNydRo0mQxCCIZbb+AdFlRhJ/NwlZznoQYbxwvJpdtFfGejQJPC/h
         h79n7VHlqnB+ojoh62MSCQ1FbWmhyeCtfFj5rvVYQgFKzVs/aFrbRLt8d9CT4kUdjM77
         P//lIDsW9ypxuHpHjhmrO4PxMjYoT87Ch1MXT6NbNOZ/cCP8Hz/5jylFu5yQGxs5zj61
         ZtIg==
X-Gm-Message-State: AOJu0YxDHfQ4dkW1RVi4rT/ilMFcMw3S2Mw98cEGcQb+A5XE0pxMgMLI
	w3WK5mpSisLDFUiGZ4uzEFCoLqtmLIWHK7VVvnlYLHYxy1OFe5nMbFeReXExTIrFu1sY3J7JmnK
	NDj4rMcWGAK+kkx6WASOyAzVRSmrY5ui4molaBUc=
X-Gm-Gg: ASbGncvqu57WZOrozHafzu/zduP/QiYtCqhiUUM6Iiy+8WjuR0Wpv3OZj7A+/da3rv0
	GN5lEzcIO8UOWIUYi8+5liORs9gr9ftl8NP0syK5a80UhmtO9euX8o1XrQVC2RspQ7P+C2pZ8r5
	MMKuYJcjfZYIpE4kf80zDjkJKqcefcdfkBduc9bO5X3V//c1QBjclvlfNlEUW5mGwoAXByFttq2
	vbv7E1b3sDPRPfGjVkfz4Ybk4EUMDB1vJC+W0z3
X-Google-Smtp-Source: AGHT+IHytZeRUjZNcW+/tx6mNRna3Bh5BL3+8zTGmE3cX7XHmwpWaOpr6tT1A0jLokJ/2rbUw4/iBqQoFeJbQ+P2Cl4=
X-Received: by 2002:a05:6512:3c91:b0:553:c9fb:5bad with SMTP id
 2adb3069b0e04-55b97a842e2mr1611217e87.1.1754248922357; Sun, 03 Aug 2025
 12:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jacob Chapman <chapmanjacobd@gmail.com>
Date: Sun, 3 Aug 2025 14:21:25 -0500
X-Gm-Features: Ac12FXwyuYI7CLX9DFvzgYvyKQFJlHmCjxsC8EKcYHoxhbB69sF3li2d_h_-Yi4
Message-ID: <CAAGO9LE0xAdgo7G3UZbo53=WYcysqDk6uKA8rH-DdWGBdCy5TA@mail.gmail.com>
Subject: Support feedback - HM-SMR Zoned disk ENOSPC; can't mount RW
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Greetings!

I have two zoned disks of the same model (separate btrfs filesystems)
which suffered a similar but different ENOSPC tragedy. I was able to
mount as RW and, after a few minutes of resuscitation[1], it is back
in business.

1. truncate -s 20G "$temp_file"; btrfs device add $(losetup -f
"$temp_file" --show) /mnt/d1

But the other is a more curious case:

# sudo mount -o
noatime,nodiratime,compress-force=zstd:4,degraded,rw,skip_balance,enospc_debug,noautodefrag,notreelog
/dev/sdf /mnt/d10/
mount: /mnt/d10: fsconfig system call failed: No space left on device.
       dmesg(1) may have more information after failed mount system call.

---

kern  :err   : [Aug 3 13:28] BTRFS error (device sdf): allocation
failed flags 36, wanted 16384 tree-log 0, relocation: 0
kern  :warn  : [  +0.000022] BTRFS warning (device sdf): Skipping
commit of aborted transaction.
kern  :warn  : [  +0.000001] ------------[ cut here ]------------
kern  :err   : [  +0.000001] BTRFS: Transaction aborted (error -28)
kern  :warn  : [  +0.000007] WARNING: CPU: 6 PID: 2810353 at
fs/btrfs/transaction.c:2022 cleanup_transaction+0x69/0xa0
kern  :warn  : [  +0.000005] Modules linked in: dm_crypt uas
usb_storage snd_usb_audio snd_usbmidi_lib mc snd_ump snd_rawmidi
apple_mfi_fastcharge bnep bluetooth uinput snd_seq_dummy snd_hrtimer
xt_MASQUERADE xt_mark nft_compat rpcrdma rdma_cm iw_cm ib_cm ib_core
tun rfkill nft_masq nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6nft_fib nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables qrtr nct6775
nct6775_core hwmon_vid nfsd auth_rpcgss nfs_acl lockd grace
nfs_localio binfmt_misc sunrpc vfat fat snd_sof_pci_intel_tgl
snd_sof_pci_intel_cnl snd_sof_intel_hda_generic soundwire_intel
soundwire_cadence snd_sof_intel_hda_common snd_soc_hdac_hda
snd_sof_intel_hda_mlink intel_rapl_msr snd_sof_intel_hda
intel_rapl_common snd_sof_pci snd_sof_xtensa_dsp
intel_uncore_frequency intel_uncore_frequency_common snd_sof
snd_sof_utils snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks
soundwire_generic_allocation
kern  :warn  : [  +0.000040]  snd_soc_acpi soundwire_bus snd_soc_sdca
snd_soc_avs snd_soc_hda_codec snd_hda_codec_realtek snd_hda_ext_core
x86_pkg_temp_thermal intel_powerclamp snd_soc_core
snd_hda_codec_generic coretemp snd_hda_scodec_component
snd_hda_codec_hdmi snd_compress kvm_intel ac97_bus snd_pcm_dmaengine
snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec kvm
snd_hda_core spi_nor snd_hwdep mtd snd_seq spd5118 snd_seq_device
irqbypass snd_pcm rapl intel_cstate r8169 snd_timer i2c_i801
spi_intel_pci intel_uncore hid_logitech_hidpp joydev pcspkr snd
realtek wmi_bmof spi_intel i2c_smbus soundcore idma64 intel_pmc_core
pmt_telemetry pmt_class intel_vsec acpi_pad acpi_tad mei_me mei loop
nfnetlink zram lz4hc_compress lz4_compress amdgpu amdxcp i2c_algo_bit
drm_ttm_helper ttm drm_exec gpu_sched mpt3sas nvme drm_suballoc_helper
drm_panel_backlight_quirks drm_buddy drm_display_helper
polyval_clmulninvme_core polyval_generic ghash_clmulni_intel
sha512_ssse3 sha256_ssse3 raid_class sha1_ssse3 scsi_transport_sas cec
kern  :warn  : [  +0.000042]  nvme_auth video wmi hid_logitech_dj fuse i2c_dev
kern  :warn  : [  +0.000004] CPU: 6 UID: 0 PID: 2810353 Comm: mount
Tainted: G        W          6.14.11-300.fc42.x86_64 #1
kern  :warn  : [  +0.000003] Tainted: [W]=WARN
kern  :warn  : [  +0.000000] Hardware name: ASRock Z790 Pro RS
WiFi/Z790 Pro RS WiFi, BIOS 13.01 09/27/2024
kern  :warn  : [  +0.000002] RIP: 0010:cleanup_transaction+0x69/0xa0
kern  :warn  : [  +0.000002] Code: 8b ff 8d 41 1e 83 f8 19 76 39 89 ce
48 c7 c7 48 59 e6 9a 4c 89 4c 24 18 4c 89 5c 24 10 4c 89 54 24 08 89
0c 24 e8 e7 5c a3 ff <0f> 0b 8b 0c 24 4c 8b 54 24 08 4c 8b 5c 24 10 4c
8b 4c 24 18 e9 d0
kern  :warn  : [  +0.000002] RSP: 0018:ffffcbe9cd58f680 EFLAGS: 00010246
kern  :warn  : [  +0.000002] RAX: 0000000000000000 RBX:
ffff89d96cb29000 RCX: 0000000000000027
kern  :warn  : [  +0.000001] RDX: ffff89e06f721948 RSI:
0000000000000001 RDI: ffff89e06f721940
kern  :warn  : [  +0.000001] RBP: ffff89d9140fa3f0 R08:
0000000000000000 R09: ffffcbe9cd58f528
kern  :warn  : [  +0.000001] R10: ffffffff9b9368e8 R11:
00000000ffffdfff R12: ffff89d9d130de00
kern  :warn  : [  +0.000001] R13: ffff89d96cb29418 R14:
ffff89d9140fa458 R15: 00000000ffffffe4
kern  :warn  : [  +0.000001] FS:  00007fb24be0b840(0000)
GS:ffff89e06f700000(0000) knlGS:0000000000000000
kern  :warn  : [  +0.000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern  :warn  : [  +0.000001] CR2: 000012102311a004 CR3:
000000015b275006 CR4: 0000000000f72ef0
kern  :warn  : [  +0.000010] PKRU: 55555554
kern  :warn  : [  +0.000001] Call Trace:
kern  :warn  : [  +0.000001]  <TASK>
kern  :warn  : [  +0.000003]  btrfs_commit_transaction+0xb12/0xd20
kern  :warn  : [  +0.000003]  flush_space+0x206/0x270
kern  :warn  : [  +0.000004]  priority_reclaim_metadata_space+0x6f/0x130
kern  :warn  : [  +0.000003]  handle_reserve_ticket+0x60/0x2b0
kern  :warn  : [  +0.000001]  ? calc_available_free_space.isra.0+0x70/0xc0
kern  :warn  : [  +0.000003]  __reserve_bytes+0x276/0x4a0
kern  :warn  : [  +0.000002]  btrfs_reserve_metadata_bytes+0x1f/0xe0
kern  :warn  : [  +0.000002]  btrfs_block_rsv_refill+0x6a/0xa0
kern  :warn  : [  +0.000002]  evict_refill_and_join+0x47/0xc0
kern  :warn  : [  +0.000001]  btrfs_evict_inode+0x325/0x3e0
kern  :warn  : [  +0.000003]  evict+0x113/0x2a0
kern  :warn  : [  +0.000002]  btrfs_orphan_cleanup+0x200/0x2d0
kern  :warn  : [  +0.000002]  btrfs_start_pre_rw_mount+0x17d/0x420
kern  :warn  : [  +0.000003]  open_ctree+0xa03/0xbe7
kern  :warn  : [  +0.000004]  btrfs_get_tree_super.cold+0xb/0xbb
kern  :warn  : [  +0.000003]  vfs_get_tree+0x26/0xd0
kern  :warn  : [  +0.000002]  fc_mount+0x12/0x40
kern  :warn  : [  +0.000002]  btrfs_get_tree_subvol+0x10d/0x210
kern  :warn  : [  +0.000003]  vfs_get_tree+0x26/0xd0
kern  :warn  : [  +0.000001]  vfs_cmd_create+0x57/0xd0
kern  :warn  : [  +0.000003]  __do_sys_fsconfig+0x4b3/0x640
kern  :warn  : [  +0.000002]  do_syscall_64+0x7b/0x160
kern  :warn  : [  +0.000004]  ? __do_sys_fsconfig+0x356/0x640
kern  :warn  : [  +0.000001]  ? syscall_exit_to_user_mode+0x10/0x210
kern  :warn  : [  +0.000003]  ? do_syscall_64+0x87/0x160
kern  :warn  : [  +0.000001]  ? vfs_parse_fs_param+0x9c/0x100
kern  :warn  : [  +0.000002]  ? __do_sys_fsconfig+0x356/0x640
kern  :warn  : [  +0.000001]  ? syscall_exit_to_user_mode+0x10/0x210
kern  :warn  : [  +0.000002]  ? do_syscall_64+0x87/0x160
kern  :warn  : [  +0.000002]  ? syscall_exit_to_user_mode+0x10/0x210
kern  :warn  : [  +0.000001]  ? do_syscall_64+0x87/0x160
kern  :warn  : [  +0.000002]  ? exc_page_fault+0x7e/0x1a0
kern  :warn  : [  +0.000002]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
kern  :warn  : [  +0.000003] RIP: 0033:0x7fb24bfe9abe
kern  :warn  : [  +0.000013] Code: 73 01 c3 48 8b 0d 4a 33 0f 00 f7 d8
64 89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 49 89 ca
b8 af 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1a 33 0f 00
f7 d8 64 89 01 48
kern  :warn  : [  +0.000002] RSP: 002b:00007ffdf0e22fc8 EFLAGS:
00000246 ORIG_RAX: 00000000000001af
kern  :warn  : [  +0.000002] RAX: ffffffffffffffda RBX:
0000562f0363c330 RCX: 00007fb24bfe9abe
kern  :warn  : [  +0.000001] RDX: 0000000000000000 RSI:
0000000000000006 RDI: 0000000000000003
kern  :warn  : [  +0.000000] RBP: 00007ffdf0e23110 R08:
0000000000000000 R09: 0000000000000016
kern  :warn  : [  +0.000001] R10: 0000000000000000 R11:
0000000000000246 R12: 0000000000000000
kern  :warn  : [  +0.000001] R13: 0000562f0363cae0 R14:
00007fb24c166b00 R15: 0000562f0363e2a8
kern  :warn  : [  +0.000002]  </TASK>
kern  :warn  : [  +0.000001] ---[ end trace 0000000000000000 ]---
kern  :crit  : [  +0.000002] BTRFS: error (device sdf state A) in
cleanup_transaction:2022: errno=-28 No space left
kern  :warn  : [  +0.000009] BTRFS warning (device sdf state EA):
could not allocate space for delete; will truncate on mount
kern  :err   : [  +0.000010] BTRFS error (device sdf state EA): Error
removing orphan entry, stopping orphan cleanup
kern  :err   : [  +0.000001] BTRFS error (device sdf state EA): could
not do orphan cleanup -28
kern  :err   : [  +0.000029] BTRFS error (device sdf state EA): commit
super ret -30
kern  :err   : [  +0.110462] BTRFS error (device sdf state EA):
open_ctree failed: -28

---

Linux pakon 6.14.11-300.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Tue Jun 10
16:24:16 UTC 2025 x86_64 GNU/Linux

---

btrfs-progs v6.14
-EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED CRYPTO=libgcrypt

---

Label: none  uuid: c521cf72-e9cc-4b4f-aae1-d427c607cea8
Total devices 1 FS bytes used 12.18TiB
devid    1 size 12.73TiB used 12.73TiB path /dev/sdf

Data, single: total=12.57TiB, used=12.16TiB, zone_unusable=421.84GiB
System, DUP: total=256.00MiB, used=7.62MiB, zone_unusable=20.66MiB
Metadata, DUP: total=81.50GiB, used=23.39GiB, zone_unusable=58.11GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

---

# btrfs check --clear-space-cache v2 /dev/sdf
Opening filesystem to check...
Checking filesystem on /dev/sdf
UUID: c521cf72-e9cc-4b4f-aae1-d427c607cea8
WARNING: --clear-space-cache option is deprecated, please use "btrfs
rescue clear-space-cache" instead
Clear free space cache v2
Unable to find block group for 0
Unable to find block group for 0
Unable to find block group for 0
ERROR: failed to clear free space cache v2: -28
ERROR: commit_root already set when starting transaction
extent buffer leak: start 42313504686080 len 16384

---

It mounts into RO mode just fine. I'll probably copy the data off and
nuke it in a few days. I guess this will be too difficult to fix as a
one-off thing.

My purpose for emailing is to hope that Btrfs will continue to improve
and this edge case will eventually be buffered out. Through my years
of using Btrfs, I've encountered similar situations like this before.
The existing rescue mount options are fantastic for data recovery. But
it would be nice if there were a few more rescue mount options
specifically for mounting to RW mode; maybe an option to include a
temp scratch disk for anything that needs to be written while
mounting?

Cheers,

- Jacob

