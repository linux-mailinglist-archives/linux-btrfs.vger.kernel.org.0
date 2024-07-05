Return-Path: <linux-btrfs+bounces-6223-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70D49283AA
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 10:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A071C2494C
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 08:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D8B145B26;
	Fri,  5 Jul 2024 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eD+ULVvK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102C013D276
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2024 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720168141; cv=none; b=Lq3PWTerVy3WbZI+ioRTTerxGu7XM5/g2mMznN7NuiRlygoT7FAwcEWb1Z3GwEYoE6YkT9Zp8473l266yfIScbIAMrLvXK+kgDkmIBmBH/jPzX7YspAMVE8AVWx5Cva2jXoD1/9qxXh8jnkVr5PzT7lFbD6e6h/hOWz/62Djtq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720168141; c=relaxed/simple;
	bh=S89bhCvLl+mrvC2EA59voNB9Kk0JwWeukD2M/xXPNsE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fWJtI/myoMqJxtlXG9llBoGc1EHcK9s+ZIwgVNOtPQhocyYRtmqArL3KS6QQ/+SCVBzRYCK3/l09jWW1mJ4vH7BWoZR6VH6Bfpt1PKjoT8PspSG1lHV888pen5Nu4/OE/aLU1J/L9A0xNsj3V+JzD/whh8Tq//EzuIdlJTBAYM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eD+ULVvK; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e0365588ab8so1369554276.1
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Jul 2024 01:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720168138; x=1720772938; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pEs6n1JVgSnO5EDf53ad4XW3s4FEXopC+MP9FwgRWNw=;
        b=eD+ULVvK8auZtuBdKCsgbxHyF+w/SvMg8urLhJpQ5A6vScHDFjnwV7bpoAFWC983fH
         q1i4diNTY6nuB8hKBE1xGM0Pgquy0FtsqiLyPmSQCa3uiVFen40/qKdSuqapeKUjqTEy
         6KEJZqi8evW/dZpMo+r04FpABMfH0dwoqhe9Q54/GPWbJprzy+6jOvCXOifO3HDTSQYo
         JyBlB+1ohIW5R+F7Zym9b7TDWSEIHYBAmA3hv6MFxZv7BsGeLw1NiZy7L8JXyrkGrtek
         gn2bq1QZUHkpaHoxLXrUpuXCZP7eCV8yt9Lw9m4aPTEE7U/mGRLuZP7dzkCNm0qFax2r
         9Ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720168138; x=1720772938;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pEs6n1JVgSnO5EDf53ad4XW3s4FEXopC+MP9FwgRWNw=;
        b=rYkEYR89ILzXu1hpdpyKL3ppczKpeWyu9zgvvfW+anReFlVlDfr4f8zeXCN5zxMual
         0au4zrruYuBMEvDCdh1FZJwj6xWiwZjUR5Z+flduemE/JpGrvd3La0Bz5lpqwQC3dLjN
         fxC4VYTiinlsY3cL95q4iq0Peq0NJ637WtmDf7FAdqc/eBZ5tvYY/ErvL9c3/mJtcCYb
         lrsg33mxIZdg/5RTAvn+PT/cvzLr/fYUVNjZqt/N9tTx7ErvzWaVKA248J4j+TBCyrjt
         fl8cbeE2fkJ0YiO3eo29xAhBsTycN+M6G1oIpc8SYRWsnyZghwyj15Fodp4MAiTAnAxE
         yZzA==
X-Gm-Message-State: AOJu0YxsccyKk5QzD3wUwFdIYCMRjJIM3h5NPZne3aiRfTmeh+KGATC+
	nTYtq3UBOO8Ay7p8k0h4hanytvfzvsiv1KnCP9Zy3tgAQozqht3kiKo9UUpW0fYBaM8lSZlel7k
	uWkv4kEnJOn+Y/aM51lHVxMRyoMMBEEnN
X-Google-Smtp-Source: AGHT+IFkfE56a/t6pFAgO4jEnVN5GKN5TyJjXKrtW/zTVHf8sz8xccMWJBjag68+2V5bVg1jFMk4K97ZK59sluPC930=
X-Received: by 2002:a25:ac21:0:b0:e02:a265:34b4 with SMTP id
 3f1490d57ef6-e03c1961890mr3861852276.16.1720168137335; Fri, 05 Jul 2024
 01:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kendy Kutzner <kendy.kutzner@gmail.com>
Date: Fri, 5 Jul 2024 10:28:47 +0200
Message-ID: <CABnrD-X-LgxcWEDgdaV2-yFTEevFXs9AeKLqCMsq4KBp9RaLqg@mail.gmail.com>
Subject: btrfs errors while running out of space during 'device remove'
 (errors found in extent allocation tree or chunk allocation)
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello linux-btrfs@vger.kernel.org

Hardware: 8 sata drives, with mixed sizes between 3TB and 6TB
Setup: an array of data=raid1, meta=raid1c3, system=raid1c3, Debian testing

before the incident
 - shell 1: rapidly creating files (some 3Byte, some 30MB) with 10
cores in parallel
 - shell 2: btrfs dev remove <a 3TB drive>

Adding usage and removing a device is a not so good combination, and
eventually, the system ran out of space. Shell 1 stops processing
The system was already stressed, and a kernel worker printed out [0].
I've attempted to recover the out-of-space situation in shell 3: rm
/a/large/nubmer/of/files

Around that time, trace [1] appeared.

To prevent further damage to a potentially inconsistent system, I've
rebooted. At start, the FS failed to mount:

2024-07-03T22:08:01.745513+02:00 host kernel BTRFS error (device
sdd1): open_ctree failed

Mounting manually with -o ro worked fine (but was slow). An initial
'btrfs check -p' returned no errors. Reading up on 'open_ctree
failed', without much thinking I ran 'clear-ino-cache',
'clear-space-cache' and 'clear-uuid-tree'

Another reboot (again, automatic mount failed with the open_ctree
message), and 'btrfs check' now reports "errors found in extent
allocation tree or chunk allocation": [2]

Any advice before I wipe the FS and replay a backup?

Thanks
Kendy


[0]

2024-07-03T18:45:57.254477+02:00 host kernel INFO: task
kworker/u40:0:656534 blocked for more than 120 seconds.
2024-07-03T18:45:57.254504+02:00 host kernel       Not tainted
6.6.15-amd64 #1 Debian 6.6.15-2
2024-07-03T18:45:57.254507+02:00 host kernel "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
2024-07-03T18:45:57.254509+02:00 host kernel task:kworker/u40:0
state:D stack:0     pid:656534 ppid:2      flags:0x00004000
2024-07-03T18:45:57.254511+02:00 host kernel Workqueue: events_unbound
btrfs_async_reclaim_data_space [btrfs]
2024-07-03T18:45:57.254512+02:00 host kernel Call Trace:
2024-07-03T18:45:57.254514+02:00 host kernel  <TASK>
2024-07-03T18:45:57.254516+02:00 host kernel  __schedule+0x3da/0xb20
2024-07-03T18:45:57.254540+02:00 host kernel  schedule+0x5e/0xd0
2024-07-03T18:45:57.254543+02:00 host kernel
wait_for_commit+0x11e/0x1d0 [btrfs]
2024-07-03T18:45:57.254545+02:00 host kernel  ?
__pfx_autoremove_wake_function+0x10/0x10
2024-07-03T18:45:57.254546+02:00 host kernel
btrfs_wait_for_commit+0x14d/0x1c0 [btrfs]
2024-07-03T18:45:57.254548+02:00 host kernel
btrfs_attach_transaction_barrier+0x43/0x60 [btrfs]
2024-07-03T18:45:57.254549+02:00 host kernel  flush_space+0xec/0x5f0 [btrfs]
2024-07-03T18:45:57.254556+02:00 host kernel  ? psi_task_switch+0xd6/0x230
2024-07-03T18:45:57.254558+02:00 host kernel  ? __switch_to_asm+0x3e/0x70
2024-07-03T18:45:57.254559+02:00 host kernel  ?
finish_task_switch.isra.0+0x8f/0x2d0
2024-07-03T18:45:57.254560+02:00 host kernel
btrfs_async_reclaim_data_space+0xd6/0x160 [btrfs]
2024-07-03T18:45:57.254562+02:00 host kernel  process_one_work+0x171/0x340
2024-07-03T18:45:57.254563+02:00 host kernel  worker_thread+0x27b/0x3a0
2024-07-03T18:45:57.254569+02:00 host kernel  ? __pfx_worker_thread+0x10/0x10
2024-07-03T18:45:57.254603+02:00 host kernel  kthread+0xe5/0x120
2024-07-03T18:45:57.254605+02:00 host kernel  ? __pfx_kthread+0x10/0x10
2024-07-03T18:45:57.254606+02:00 host kernel  ret_from_fork+0x31/0x50
2024-07-03T18:45:57.254608+02:00 host kernel  ? __pfx_kthread+0x10/0x10
2024-07-03T18:45:57.254609+02:00 host kernel  ret_from_fork_asm+0x1b/0x30
2024-07-03T18:45:57.254611+02:00 host kernel  </TASK>

[1]

2024-07-03T22:05:01.438450+02:00 host kernel ------------[ cut here
]------------
2024-07-03T22:05:01.438478+02:00 host kernel BTRFS: Transaction
aborted (error -28)
2024-07-03T22:05:01.438481+02:00 host kernel WARNING: CPU: 12 PID:
730576 at fs/btrfs/extent-tree.c:2863
__btrfs_free_extent+0x112f/0x1190 [btrfs]
2024-07-03T22:05:01.438484+02:00 host kernel Modules linked in:
tcp_diag inet_diag cpuid cts rpcsec_gss_krb5 xt_nat xt_tcpudp
bluetooth veth ecdh_generic rfkill xt_conntrack nft_chain_nat
xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables
br_netfilter bridge stp llc overlay macvlan msr binfmt_misc
intel_rapl_msr intel_rapl_common intel_uncore_frequency
intel_uncore_frequency_common x86_pkg_temp_thermal intel_powerclamp
kvm_intel i915 kvm irqbypass ghash_clmulni_intel sha512_ssse3
sha256_ssse3 sha1_ssse3 drm_buddy drm_display_helper aesni_intel cec
crypto_simd rc_core cryptd nls_ascii rapl mei_pxp ttm nls_cp437 joydev
mei_hdcp evdev iTCO_wdt vfat intel_pmc_bxt intel_cstate fat wmi_bmof
drm_kms_helper intel_uncore mei_me iTCO_vendor_support pcspkr watchdog
i2c_algo_bit mei intel_pmc_core acpi_pad acpi_tad button sg nfsd
nfs_acl lockd auth_rpcgss grace drm sunrpc nct6775 nct6775_core
hwmon_vid dm_mod coretemp loop nvme_fabrics efi_pstore configfs
nfnetlink efivarfs
2024-07-03T22:05:01.438485+02:00 host kernel  ip_tables x_tables
autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic xor hid_generic
usbhid hid raid6_pq libcrc32c crc32c_generic sd_mod nvme ahci
nvme_core libahci xhci_pci t10_pi libata xhci_hcd r8169 realtek
crc64_rocksoft crc64 mdio_devres scsi_mod usbcore crc_t10dif libphy
crct10dif_generic intel_lpss_pci crc32_pclmul i2c_i801
crct10dif_pclmul intel_lpss video crc32c_intel usb_common scsi_common
i2c_smbus crct10dif_common idma64 wmi
2024-07-03T22:05:01.438487+02:00 host kernel CPU: 12 PID: 730576 Comm:
rm Not tainted 6.6.15-amd64 #1  Debian 6.6.15-2
2024-07-03T22:05:01.438488+02:00 host kernel Hardware name: ASRock
Z790 Pro RS/Z790 Pro RS, BIOS 4.06 11/11/2022
2024-07-03T22:05:01.438490+02:00 host kernel RIP:
0010:__btrfs_free_extent+0x112f/0x1190 [btrfs]
2024-07-03T22:05:01.438491+02:00 host kernel Code: fe ff ff be 8b ff
ff ff 48 c7 c7 f0 70 7b c0 e8 c7 d8 85 fb 0f 0b e9 f2 fe ff ff 44 89
e6 48 c7 c7 f0 70 7b c0 e8 b1 d8 85 fb <0f> 0b e9 0c ff ff ff 44 89 e6
48 c7 c7 f0 70 7b c0 e8 9b d8 85 fb
2024-07-03T22:05:01.438493+02:00 host kernel RSP:
0018:ffffc9000d683960 EFLAGS: 00010282
2024-07-03T22:05:01.438494+02:00 host kernel RAX: 0000000000000000
RBX: 00002c0bed818000 RCX: 0000000000000027
2024-07-03T22:05:01.438495+02:00 host kernel RDX: ffff88904f5213c8
RSI: 0000000000000001 RDI: ffff88904f5213c0
2024-07-03T22:05:01.438496+02:00 host kernel RBP: 0000000000000000
R08: 0000000000000000 R09: ffffc9000d6837e8
2024-07-03T22:05:01.438498+02:00 host kernel R10: 0000000000000003
R11: ffff88908f7798a8 R12: 00000000ffffffe4
2024-07-03T22:05:01.438499+02:00 host kernel R13: ffff88819a11e750
R14: ffff8882130e7c40 R15: 0000000000000025
2024-07-03T22:05:01.438500+02:00 host kernel FS:
00007f420319d740(0000) GS:ffff88904f500000(0000)
knlGS:0000000000000000
2024-07-03T22:05:01.438501+02:00 host kernel CS:  0010 DS: 0000 ES:
0000 CR0: 0000000080050033
2024-07-03T22:05:01.438502+02:00 host kernel CR2: 000055ea24bc5f98
CR3: 0000000106e84000 CR4: 0000000000f50ee0
2024-07-03T22:05:01.438504+02:00 host kernel PKRU: 55555554
2024-07-03T22:05:01.438505+02:00 host kernel Call Trace:
2024-07-03T22:05:01.438506+02:00 host kernel  <TASK>
2024-07-03T22:05:01.438507+02:00 host kernel  ?
__btrfs_free_extent+0x112f/0x1190 [btrfs]
2024-07-03T22:05:01.438509+02:00 host kernel  ? __warn+0x81/0x130
2024-07-03T22:05:01.438510+02:00 host kernel  ?
__btrfs_free_extent+0x112f/0x1190 [btrfs]
2024-07-03T22:05:01.438532+02:00 host kernel  ? report_bug+0x171/0x1a0
2024-07-03T22:05:01.438534+02:00 host kernel  ? console_unlock+0x78/0x120
2024-07-03T22:05:01.438535+02:00 host kernel  ? handle_bug+0x3c/0x80
2024-07-03T22:05:01.438536+02:00 host kernel  ? exc_invalid_op+0x17/0x70
2024-07-03T22:05:01.438537+02:00 host kernel  ? asm_exc_invalid_op+0x1a/0x20
2024-07-03T22:05:01.438538+02:00 host kernel  ?
__btrfs_free_extent+0x112f/0x1190 [btrfs]
2024-07-03T22:05:01.438559+02:00 host kernel
__btrfs_run_delayed_refs+0x28b/0x11c0 [btrfs]
2024-07-03T22:05:01.438563+02:00 host kernel
btrfs_run_delayed_refs+0x59/0x200 [btrfs]
2024-07-03T22:05:01.438575+02:00 host kernel  flush_space+0x189/0x5f0 [btrfs]
2024-07-03T22:05:01.442354+02:00 host kernel
priority_reclaim_metadata_space+0xc7/0x1a0 [btrfs]
2024-07-03T22:05:01.442372+02:00 host kernel
__reserve_bytes+0x2bf/0x700 [btrfs]
2024-07-03T22:05:01.442374+02:00 host kernel  ?
btrfs_truncate_inode_items+0x66f/0xba0 [btrfs]
2024-07-03T22:05:01.442375+02:00 host kernel
btrfs_reserve_metadata_bytes+0x21/0xd0 [btrfs]
2024-07-03T22:05:01.442376+02:00 host kernel
btrfs_block_rsv_refill+0x6a/0x90 [btrfs]
2024-07-03T22:05:01.442378+02:00 host kernel
evict_refill_and_join+0x4b/0xe0 [btrfs]
2024-07-03T22:05:01.442379+02:00 host kernel
btrfs_evict_inode+0x2fa/0x3b0 [btrfs]
2024-07-03T22:05:01.442381+02:00 host kernel  evict+0xcd/0x1d0
2024-07-03T22:05:01.442382+02:00 host kernel  do_unlinkat+0x177/0x320
2024-07-03T22:05:01.442410+02:00 host kernel  __x64_sys_unlinkat+0x37/0x70
2024-07-03T22:05:01.442412+02:00 host kernel  do_syscall_64+0x5d/0xc0
2024-07-03T22:05:01.442413+02:00 host kernel  ?
exit_to_user_mode_prepare+0x40/0x1e0
2024-07-03T22:05:01.442415+02:00 host kernel  ?
syscall_exit_to_user_mode+0x2b/0x40
2024-07-03T22:05:01.442416+02:00 host kernel  ? do_syscall_64+0x6c/0xc0
2024-07-03T22:05:01.442417+02:00 host kernel  ?
syscall_exit_to_user_mode+0x2b/0x40
2024-07-03T22:05:01.442419+02:00 host kernel  ? do_syscall_64+0x6c/0xc0
2024-07-03T22:05:01.442420+02:00 host kernel  ?
syscall_exit_to_user_mode+0x2b/0x40
2024-07-03T22:05:01.442421+02:00 host kernel  ? do_syscall_64+0x6c/0xc0
2024-07-03T22:05:01.442422+02:00 host kernel  ? do_syscall_64+0x6c/0xc0
2024-07-03T22:05:01.442424+02:00 host kernel
entry_SYSCALL_64_after_hwframe+0x6e/0xd8
2024-07-03T22:05:01.442425+02:00 host kernel RIP: 0033:0x7f420329f3b7
2024-07-03T22:05:01.442426+02:00 host kernel Code: 77 01 c3 48 8b 15
69 6a 0d 00 f7 d8 64 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00
00 00 0f 1f 40 00 b8 07 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48
8b 0d 39 6a 0d 00 f7 d8 64 89 01 48
2024-07-03T22:05:01.442428+02:00 host kernel RSP:
002b:00007ffebb205e18 EFLAGS: 00000246 ORIG_RAX: 0000000000000107
2024-07-03T22:05:01.442429+02:00 host kernel RAX: ffffffffffffffda
RBX: 000055dbd62982b0 RCX: 00007f420329f3b7
2024-07-03T22:05:01.442431+02:00 host kernel RDX: 0000000000000000
RSI: 000055dbd60c84a0 RDI: 00000000ffffff9c
2024-07-03T22:05:01.442432+02:00 host kernel RBP: 000055dbd60c8410
R08: 0000000000000000 R09: 00007ffebb205f0c
2024-07-03T22:05:01.442433+02:00 host kernel R10: 000055dbd60c8410
R11: 0000000000000246 R12: 0000000000000000
2024-07-03T22:05:01.442434+02:00 host kernel R13: 00007ffebb206000
R14: 0000000000000004 R15: 000055dbd62982b0
2024-07-03T22:05:01.442435+02:00 host kernel  </TASK>
2024-07-03T22:05:01.442436+02:00 host kernel ---[ end trace
0000000000000000 ]---
2024-07-03T22:05:01.442438+02:00 host kernel BTRFS info (device sdg1:
state A): dumping space info:
2024-07-03T22:05:01.442439+02:00 host kernel BTRFS info (device sdg1:
state A): space_info DATA has 73637888 free, is not full
2024-07-03T22:05:01.442440+02:00 host kernel BTRFS info (device sdg1:
state A): space_info total=15257241583616, used=12487475875840,
pinned=2769691021312, reserved=0, may_use=0, readonly=1048576
zone_unusable=0
2024-07-03T22:05:01.442442+02:00 host kernel BTRFS info (device sdg1:
state A): space_info METADATA has -201667674112 free, is full
2024-07-03T22:05:01.442443+02:00 host kernel BTRFS info (device sdg1:
state A): space_info total=18253611008, used=16923082752,
pinned=658374656, reserved=672153600, may_use=201667674112, readonly=0
zone_unusable=0
2024-07-03T22:05:01.442444+02:00 host kernel BTRFS info (device sdg1:
state A): space_info SYSTEM has 31424512 free, is not full
2024-07-03T22:05:01.442462+02:00 host kernel BTRFS info (device sdg1:
state A): space_info total=33554432, used=2129920, pinned=0,
reserved=0, may_use=0, readonly=0 zone_unusable=0
2024-07-03T22:05:01.442464+02:00 host kernel BTRFS info (device sdg1:
state A): global_block_rsv: size 536870912 reserved 536870912
2024-07-03T22:05:01.442465+02:00 host kernel BTRFS info (device sdg1:
state A): trans_block_rsv: size 0 reserved 0
2024-07-03T22:05:01.442467+02:00 host kernel BTRFS info (device sdg1:
state A): chunk_block_rsv: size 0 reserved 0
2024-07-03T22:05:01.442468+02:00 host kernel BTRFS info (device sdg1:
state A): delayed_block_rsv: size 0 reserved 0
2024-07-03T22:05:01.442469+02:00 host kernel BTRFS info (device sdg1:
state A): delayed_refs_rsv: size 201133129728 reserved 201130147840
2024-07-03T22:05:01.442474+02:00 host kernel BTRFS: error (device
sdg1: state A) in do_free_extent_accounting:2863: errno=-28 No space
left
2024-07-03T22:05:01.442475+02:00 host kernel BTRFS info (device sdg1:
state EA): forced readonly
2024-07-03T22:05:01.442477+02:00 host kernel BTRFS error (device sdg1:
state EA): failed to run delayed ref for logical 48429740949504
num_bytes 116371456 type 178 action 2 ref_mod 1: -28
2024-07-03T22:05:01.442479+02:00 host kernel BTRFS: error (device
sdg1: state EA) in btrfs_run_delayed_refs:2168: errno=-28 No space
left
2024-07-03T22:05:01.442481+02:00 host kernel BTRFS: error (device
sdg1: state EA) in do_free_extent_accounting:2863: errno=-28 No space
left
2024-07-03T22:05:01.442482+02:00 host kernel BTRFS error (device sdg1:
state EA): failed to run delayed ref for logical 48429906407424
num_bytes 61599744 type 184 action 2 ref_mod 1: -28
2024-07-03T22:05:01.442487+02:00 host kernel BTRFS: error (device
sdg1: state EA) in btrfs_run_delayed_refs:2168: errno=-28 No space
left
2024-07-03T22:05:01.442489+02:00 host kernel BTRFS: error (device
sdg1: state EA) in do_free_extent_accounting:2863: errno=-28 No space
left
2024-07-03T22:05:01.442490+02:00 host kernel BTRFS error (device sdg1:
state EA): failed to run delayed ref for logical 48429992550400
num_bytes 53981184 type 178 action 2 ref_mod 1: -28
2024-07-03T22:05:01.442491+02:00 host kernel BTRFS: error (device
sdg1: state EA) in btrfs_run_delayed_refs:2168: errno=-28 No space
left


[2]

dozens of

ref mismatch on [44558104043520 802816] extent item 2, found 1d,
1063474 items checked)
data extent[44558104043520, 802816] bytenr mimsmatch, extent item
bytenr 44558104043520 file item bytenr 0
data extent[44558104043520, 802816] referencer count mismatch (parent
48647977648128) wanted 1 have 0
backpointer mismatch on [44558104043520 802816]
ref mismatch on [44677886496768 1048576] extent item 2, found 1
data extent[44677886496768, 1048576] bytenr mimsmatch, extent item
bytenr 44677886496768 file item bytenr 0
data extent[44677886496768, 1048576] referencer count mismatch (parent
48647977648128) wanted 1 have 0
backpointer mismatch on [44677886496768 1048576]
ref mismatch on [45016544555008 1179648] extent item 2, found 1
data extent[45016544555008, 1179648] bytenr mimsmatch, extent item
bytenr 45016544555008 file item bytenr 0
data extent[45016544555008, 1179648] referencer count mismatch (parent
48647977648128) wanted 1 have 0
backpointer mismatch on [45016544555008 1179648]
ref mismatch on [45016545734656 73728] extent item 2, found 1
data extent[45016545734656, 73728] bytenr mimsmatch, extent item
bytenr 45016545734656 file item bytenr 0
data extent[45016545734656, 73728] referencer count mismatch (parent
48647977648128) wanted 1 have 0
backpointer mismatch on [45016545734656 73728]
ref mismatch on [45016545808384 69632] extent item 2, found 1
data extent[45016545808384, 69632] bytenr mimsmatch, extent item
bytenr 45016545808384 file item bytenr 0
data extent[45016545808384, 69632] referencer count mismatch (parent
48647977648128) wanted 1 have 0
backpointer mismatch on [45016545808384 69632]
ref mismatch on [45016545878016 65536] extent item 2, found 1
data extent[45016545878016, 65536] bytenr mimsmatch, extent item
bytenr 45016545878016 file item bytenr 0
data extent[45016545878016, 65536] referencer count mismatch (parent
48647977648128) wanted 1 have 0
backpointer mismatch on [45016545878016 65536]
ref mismatch on [45016545943552 49152] extent item 2, found 1
data extent[45016545943552, 49152] bytenr mimsmatch, extent item
bytenr 45016545943552 file item bytenr 0
data extent[45016545943552, 49152] referencer count mismatch (parent
48647977648128) wanted 1 have 0
backpointer mismatch on [45016545943552 49152]
ref mismatch on [45016545992704 614400] extent item 2, found 1
data extent[45016545992704, 614400] bytenr mimsmatch, extent item
bytenr 45016545992704 file item bytenr 0
data extent[45016545992704, 614400] referencer count mismatch (parent
48647977648128) wanted 1 have 0
backpointer mismatch on [45016545992704 614400]
ref mismatch on [45016546607104 65536] extent item 2, found 1
data extent[45016546607104, 65536] bytenr mimsmatch, extent item
bytenr 45016546607104 file item bytenr 0
data extent[45016546607104, 65536] referencer count mismatch (parent
48647977648128) wanted 1 have 0
backpointer mismatch on [45016546607104 65536]
ref mismatch on [45016546672640 57344] extent item 2, found 1
data extent[45016546672640, 57344] bytenr mimsmatch, extent item
bytenr 45016546672640 file item bytenr 0
data extent[45016546672640, 57344] referencer count mismatch (parent
48647977648128) wanted 1 have 0
backpointer mismatch on [45016546672640 57344]
ref mismatch on [45016546729984 32768] extent item 2, found 1

[2/7] checking extents                         (0:09:04 elapsed,
1063726 items checked)
ERROR: errors found in extent allocation tree or chunk allocation

