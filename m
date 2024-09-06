Return-Path: <linux-btrfs+bounces-7867-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DE796E70E
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 03:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5271F2434D
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 01:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157A31BC3F;
	Fri,  6 Sep 2024 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9ES2mXW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF671401C
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Sep 2024 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725584407; cv=none; b=XBa8IntBSb8GyxbQjTvz/4PxYTZLDN4d+2gQD5AGBDkj0FPtLnCFVD8/A0vNh7XJqV1sNP7RDs6m9TwRclppnXZjqo+SVqCPOpjisYMSd9sGmCqm8Q4uu2RBjsDbuz4nBDrK5zWLjWYLonTftNL2PFP3nAdmhhOyqiI7xN82FCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725584407; c=relaxed/simple;
	bh=dz9cn8EEJr2lwk4uop4/zU2Xnt1k+j7g1U9b+cOX1ZE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=iw6pRHe8+K/JOLWLAV6gYsQiFuUSBLvlsOph5HOdhEG9zhUlzVMurmOOEQPQZremQ2Kt6U0JRMMjJ5baKkfaIHrwTZ5Ey66SI2SJLERLiV9yz7ermlnI/gls2I+iWNFOjo6QLME3EVwhjIP8JUl8UXZ0cAWTq6vujEh8fdaOaVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9ES2mXW; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a89c8db505bso215990066b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Sep 2024 18:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725584404; x=1726189204; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IrpAP0znPGMi/9v7bR50t9GQV427rkw8DGlY9R4C/5Q=;
        b=B9ES2mXW87Y/G4iuwPo1wen6EQT7A+XbXfCKPcixKW78SI0Wxs2MGAqX4W9jt2D54R
         SvdlTFoXZucniXthFRel8ExVppibb294ioaw1ZbqDX2gySetKBQdsVXlpZII/9d/Uapd
         GdOGqGsoTqTYVnAENPWQlelx9nQ05wIvYAfPmflD3KrsAlsyRNNM3fug+JprsuyukY+n
         6MdN0xgGJ8eDGOI4iYHSs2dSdCL5mnhr6dZ2zhBa6HDC+7ldcfJk1k6CMnUow9M15Sd6
         nOOWlRv++kdtPS7fNKxigxknDLyw/QQvZYXx6gei9bGPyMK6+3P+6IkaLnNTb75GSFej
         a41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725584404; x=1726189204;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IrpAP0znPGMi/9v7bR50t9GQV427rkw8DGlY9R4C/5Q=;
        b=Ps1CUaJlVITy7H27l1Kr3TZH7zSr0W/6+g16+PHNGnpB/2A7yGFSqTVRZVHZfrOZkC
         8c0pAC+rAjjda1EkqPN3+F181DpCB3/ECdTdzsSWO+Uw8Jag64BJM7m0J3vCoBy9Yqw7
         cgkwlpkJKmUzytYGDX5immFirRi1+uDrftc4AR8CVQtorxyO+7kJQkA4wcJSshQ8ziT5
         o+rXVJUj4H4OhxpS9ZLSt20mnIHd2l1eimDX8fT1/cDsUXw5ojlnH49mrohz1WEyq85s
         qDeGXLDkAJbwFeyvSeg48f6qwdei7mYk4Yj3e+J9+0s7rZ6LaOdjjuoaa/uHKyPFU8xI
         OPug==
X-Gm-Message-State: AOJu0Ywgj8//EeuSinsiJ3gAPz/YpIkemdQvj1BLXj+hb0Sopbc775xF
	CNSvgjg4Nhs4Lg72oUlLaSsc7cpLN0C5WgXEVzQ55YKJzCFlN38UkDmk72giLG8VpQWPwjY+gpG
	zDIMluN7M9Bq4PKzYvNM1zPrJEhXn4Nwq
X-Google-Smtp-Source: AGHT+IHN0kjA6C7T3raLxS4XwY5aLCnVnVWT7VkVsu/Pi6LpqZ82RzcUCmPQGMtBsdFyb07AFeU6eTo9K+oabJNklaM=
X-Received: by 2002:a17:907:3d8b:b0:a7a:ba59:3164 with SMTP id
 a640c23a62f3a-a8a888e9c21mr53341666b.53.1725584403505; Thu, 05 Sep 2024
 18:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Brent Bartlett <brent.bartlett1@gmail.com>
Date: Fri, 6 Sep 2024 00:59:52 +0000
Message-ID: <CACSb8pLWjCPBvfYNGqFQ_6V06SFSqdm-Ea=SC6g+D9_=qygvgw@mail.gmail.com>
Subject: SSD stuck in read-only mode with call trace and itemoff / itemsize errors
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have an SSD drive that was mounted by the system as read-only due to
errors. I have posted my full dmesg here:
https://pastebin.com/BDQ9eUVc

It gave me a call trace and an error -117. I can still use the system,
at least for the moment, but it is of course read-only. When I tried
to back up with rsync, a lot of files had I/O errors. Here's the
section between the "cut here" markers:

[   36.194513] WARNING: CPU: 1 PID: 431 at fs/btrfs/extent-tree.c:3212
__btrfs_free_extent.isra.0+0x7f8/0xb10 [btrfs]
[   36.194551] Modules linked in: ccm ext4 mbcache jbd2 snd_seq_dummy
snd_hrtimer rfcomm snd_seq snd_seq_device qrtr cmac algif_hash
algif_skcipher af_alg bnep btusb btrtl btintel btbcm btmtk bluetooth
vfat fat crc16 amd_atl intel_rapl_msr amdgpu intel_rapl_common iwlmvm
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component
mac80211 snd_hda_codec_hdmi amdxcp drm_exec libarc4 snd_hda_intel
gpu_sched snd_intel_dspcfg snd_intel_sdw_acpi drm_buddy eeepc_wmi
i2c_algo_bit snd_hda_codec asus_wmi kvm_amd drm_suballoc_helper
iwlwifi snd_hda_core drm_ttm_helper platform_profile snd_hwdep ttm
joydev kvm cfg80211 snd_pcm i8042 igc sparse_keymap drm_display_helper
snd_timer ptp serio mousedev pps_core wmi_bmof rfkill cec snd rapl
video i2c_piix4 soundcore k10temp gpio_amdpt gpio_generic mac_hid
dm_mod loop nfnetlink zram ip_tables x_tables hid_generic usbhid
crct10dif_pclmul crc32_pclmul polyval_clmulni polyval_generic gf128mul
ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 aesni_intel
nvme crypto_simd
[   36.194609]  nvme_core cryptd sr_mod ccp sp5100_tco nvme_auth
xhci_pci cdrom xhci_pci_renesas wmi btrfs blake2b_generic libcrc32c
crc32c_generic crc32c_intel xor raid6_pq vboxnetflt(OE) vboxnetadp(OE)
vboxdrv(OE) uinput i2c_dev crypto_user
[   36.194625] CPU: 1 PID: 431 Comm: btrfs-transacti Tainted: G
   OE      6.10.6-zen1-1-zen #1
ee81b56be11bce761cff661f9e15368bf5a1ae77
[   36.194628] Hardware name: ASUS System Product Name/ROG STRIX
B550-A GAMING, BIOS 2604 02/25/2022
[   36.194629] RIP: 0010:__btrfs_free_extent.isra.0+0x7f8/0xb10 [btrfs]
[   36.194654] Code: 41 89 c7 e9 a4 fc ff ff 8b 4b 40 48 8b 3c 24 41
b8 01 00 00 00 48 89 da 48 8b 74 24 28 e8 30 61 ff ff 41 89 c7 e9 82
fc ff ff <0f> 0b 48 8b 04 24 48 8b 40 60 48 89 44 2408 48 05 30 0a 00
00 f0
[   36.194655] RSP: 0018:ffffb59b82d67bf0 EFLAGS: 00010246
[   36.194657] RAX: 00000000fffffffe RBX: ffffa0d0e3005c40 RCX: 0000000000000001
[   36.194659] RDX: 0000000000000000 RSI: 00000000000000b2 RDI: ffffa0d09a8e5ef0
[   36.194660] RBP: 0000003537268000 R08: 0000000000000019 R09: 0000000000001770
[   36.194661] R10: ffffa0d0513a8140 R11: ffffd88545f81e00 R12: ffffa0d0a975e700
[   36.194662] R13: 0000000000000000 R14: 0000000000000101 R15: 00000000fffffffe
[   36.194663] FS:  0000000000000000(0000) GS:ffffa0d33e480000(0000)
knlGS:0000000000000000
[   36.194665] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   36.194666] CR2: 0000653f68a76208 CR3: 000000005fe20000 CR4: 0000000000f50ef0
[   36.194667] PKRU: 55555554
[   36.194668] Call Trace:
[   36.194671]  <TASK>
[   36.194672]  ? __btrfs_free_extent.isra.0+0x7f8/0xb10 [btrfs
f3c6ea29da5bf2c7c58c53b74e95e9ba8d5238e7]
[   36.194693]  ? __warn.cold+0x8e/0xf3
[   36.194699]  ? __btrfs_free_extent.isra.0+0x7f8/0xb10 [btrfs
f3c6ea29da5bf2c7c58c53b74e95e9ba8d5238e7]
[   36.194720]  ? report_bug+0xe7/0x210
[   36.194722]  ? handle_bug+0x3c/0x80
[   36.194725]  ? exc_invalid_op+0x19/0xc0
[   36.194727]  ? asm_exc_invalid_op+0x1a/0x20
[   36.194731]  ? __btrfs_free_extent.isra.0+0x7f8/0xb10 [btrfs
f3c6ea29da5bf2c7c58c53b74e95e9ba8d5238e7]
[   36.194753]  ? __btrfs_run_delayed_refs+0x1066/0x10c0 [btrfs
f3c6ea29da5bf2c7c58c53b74e95e9ba8d5238e7]
[   36.194773]  ? kmem_cache_free+0x39c/0x400
[   36.194776]  __btrfs_run_delayed_refs+0x59c/0x10c0 [btrfs
f3c6ea29da5bf2c7c58c53b74e95e9ba8d5238e7]
[   36.194800]  btrfs_run_delayed_refs+0x9b/0xc0 [btrfs
f3c6ea29da5bf2c7c58c53b74e95e9ba8d5238e7]
[   36.194821]  btrfs_commit_transaction+0x6c/0xd40 [btrfs
f3c6ea29da5bf2c7c58c53b74e95e9ba8d5238e7]
[   36.194847]  ? srso_alias_return_thunk+0x5/0xfbef5
[   36.194849]  ? start_transaction+0x236/0x830 [btrfs
f3c6ea29da5bf2c7c58c53b74e95e9ba8d5238e7]
[   36.194872]  transaction_kthread+0x159/0x1c0 [btrfs
f3c6ea29da5bf2c7c58c53b74e95e9ba8d5238e7]
[   36.194894]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs
f3c6ea29da5bf2c7c58c53b74e95e9ba8d5238e7]
[   36.194914]  kthread+0xd2/0x100
[   36.194917]  ? __pfx_kthread+0x10/0x10
[   36.194919]  ret_from_fork+0x34/0x50
[   36.194922]  ? __pfx_kthread+0x10/0x10
[   36.194923]  ret_from_fork_asm+0x1a/0x30
[   36.194928]  </TASK>
[   36.194928] ---[ end trace 0000000000000000 ]---

Below that, I have

[   36.195342] BTRFS: error (device nvme0n1p2 state A) in
__btrfs_free_extent:3213: errno=-117 Filesystem corrupted
[   36.195345] BTRFS info (device nvme0n1p2 state EA): forced readonly
[   36.195347] BTRFS info (device nvme0n1p2 state EA): leaf 405651456
gen 480973 total ptrs 185 free space 5337 owner 2
[   36.195349]  item 0 key (228555767808 169 0) itemoff 16250 itemsize 33
[   36.195350]          extent refs 1 gen 9826 flags 2
[   36.195351]          ref#0: tree block backref root 257
[   36.195353]  item 1 key (228555784192 169 0) itemoff 16217 itemsize 33
[   36.195355]          extent refs 1 gen 9826 flags 2
[   36.195356]          ref#0: tree block backref root 257
[   36.195357]  item 2 key (228555800576 169 0) itemoff 16184 itemsize 33
[   36.195358]          extent refs 1 gen 9826 flags 2
[   36.195359]          ref#0: tree block backref root 257
[   36.195360]  item 3 key (228555816960 169 0) itemoff 16151 itemsize 33
[   36.195361]          extent refs 1 gen 9826 flags 2
[   36.195362]          ref#0: tree block backref root 257

and it continues through 184 keys before ending with

[   36.195988] BTRFS critical (device nvme0n1p2 state EA): unable to
find ref byte nr 228558536704 parent 0 root 257 owner 0 offset 0 slot
124
[   36.195991] BTRFS error (device nvme0n1p2 state EA): failed to run
delayed ref for logical 228558536704 num_bytes 16384 type 176 action 2
ref_mod 1: -2
[   36.195993] BTRFS: error (device nvme0n1p2 state EA) in
btrfs_run_delayed_refs:2207: errno=-2 No such entry
[   56.242311] BTRFS info: devid 1 device path /dev/nvme0n1p2 changed
to /dev/disk/by-uuid/12e7a361-f58a-4611-81ff-ed8303782bcb scanned by
Thread (pooled) (3304)
[   56.242330] BTRFS error (device nvme0n1p2 state EMA): remounting
read-write after error is not allowed

I had a similar problem several months ago. The dmesg log looked the
same, but the drive wouldn't mount. I seemed to have solved that with
a zerolog, but now it's cropped up again. My system will randomly go
into read-only mode, and I'll get errors because the OS is trying to
write to config files and so on. When I reboot, it's okay again. This
time, though, it went into read-only mode, and it stuck there.

Please let me know if you need any other information. How should I proceed?

