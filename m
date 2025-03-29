Return-Path: <linux-btrfs+bounces-12676-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E27A75759
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Mar 2025 18:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DC2188FA85
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Mar 2025 18:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BD11CB9F0;
	Sat, 29 Mar 2025 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZYc9/HM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3640D182D2
	for <linux-btrfs@vger.kernel.org>; Sat, 29 Mar 2025 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743271191; cv=none; b=HMuJ8vGUFN8aQ1xDc6jbiUSm7qnNcAh3x5I9XerGFCREWk/XCnxVdZO3wsDUZi3K7Grs5TFyuThB7jok8yfdo01Nz9C1CojEPJ7E9Al80mrJBUIQsVWT/2LqTEa2/wUZMh4wAVNxTeVO9u+nBrXCQvj1PuH25KaGBNSeaeHnh/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743271191; c=relaxed/simple;
	bh=+XW42tmNPlDNcrL8BOMgxeL5pyAHjWrPsFqLhizGDws=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BJRiKB/MH1Bwt/V3sgSn3smROb0UNz26rFB3Ee8FA+S64mVpFE/BIW2g/ZDo0nctqvSOyxq2DKi3uewUhSg45Iu+SVMCCb9Z2m3Pk8RU4b4oJbfpl333ueZidCAPIGxdxpP/4BrTyz64xfRcqsgtzqNvS/d5sVybj22YOJaVMOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZYc9/HM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743271188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=qgT7l4I9TKkJ6Br587Ij8AP8mqJt3wc6Eoy99LSu/Wc=;
	b=eZYc9/HMYnRg1Z/3G6Mo+KLD5ERcO5bvEwQrSIuvmpmQoqHzMy6LN/UFmvp/dQdMN1YTX4
	VkobHIsG2uuYAXq1r69XD0d9o/bBnzCXtRa9PSbqBilJCSIQDqmtUsfSVUnQGPBfnhXoEL
	dLc+4+GLS6V/M20wpBMTIdRJ+6sVcaQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-uTcSCymoMN2hzqQpNqGQqA-1; Sat, 29 Mar 2025 13:59:45 -0400
X-MC-Unique: uTcSCymoMN2hzqQpNqGQqA-1
X-Mimecast-MFC-AGG-ID: uTcSCymoMN2hzqQpNqGQqA_1743271185
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-225974c6272so48505575ad.1
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Mar 2025 10:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743271184; x=1743875984;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qgT7l4I9TKkJ6Br587Ij8AP8mqJt3wc6Eoy99LSu/Wc=;
        b=augS5T9co0GXLMJThbpu+rRKboKYm9SUArKTb0i3a06+xtT2bhYya7nbl+IxCDmqdP
         7Ky1U4Jr50caTGA99LQL0hc0z294k5IgAKfHcyUkVmgpDgG1A6kAx8Nuo4h7HF9fFAbj
         tUQpY4aHTIZNjIcWC7w8huSa/XsWxKE1pxKX80S/0DVZS1sbEq1RRv7RH1eCyhQrAjb7
         mW7VBvzVULl8QBNJO/OY5sbJ7TohTWX+pAR2gWaE0FBPFW0PUZot6LHz+qY2x76fUYu2
         fsbFoQTI4Z+UtCGozPvvMjpE+yeiplrTt7KXgLyfu1r5XvH1XCB4pvP6T/kjG8YdkLuO
         GCHQ==
X-Gm-Message-State: AOJu0YwQNiRNeYES2RdMSPlkehUyodr6CIFHV+IGV2JueDz751PlCEYM
	5kzuoq0efHP2kki4p3LkjZbWc13CLpobVJA1261m7287lvcuiuXWKd6qcJCN738SLESbC0Ddoa6
	VLtvOfaMnPBinwNJrrpnw1Hl0Zdi0LBm+43WxTKQy+y2qSVfufkuz8zZnOB4By5RGhERWk8nAnu
	PeAOPGFk0lyEkBCoKXy7IdI2N9l5URrzdIlv80bxANs9M=
X-Gm-Gg: ASbGnctFQHUnDAAK+GLfW9YNi1zvKTR73eFswmNOssp+DJhYEXoIVgAsE6fyCnOV5dc
	WOepwN00cM3rqa2Y//mpS/dFPI613KkuK282yRB6Dq2jsEGVq2EnmtHDFj6ydwq8qJ8rt5hHKN/
	k3GOZuubxqqWVEZd71WHhsp8Lhf9ya0+AhBaw+44UKF1gZtK6P+g4d/1N7CVT0fd9hRv1w7SKVZ
	W/Vtd/0QoPLxaqSFvXlYIq5ugAwONVoWfqTCGKlY6szQTl1ZRezjH5G055fJ6XJP4uMp22HclL8
	OezKNkd39yn7aV2+keSVTozA8YbtT26SzPHQW0wPdQP34F82o6/TJrPH
X-Received: by 2002:a17:902:f946:b0:216:271d:e06c with SMTP id d9443c01a7336-2292ec073c5mr44194375ad.4.1743271184503;
        Sat, 29 Mar 2025 10:59:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmRH30AsTEDERO8Y0fbO8Q864psr6B3jBAFbUy5yRMaGMNnlNeyPwgfcRUpbx1Tp8obebqUA==
X-Received: by 2002:a17:902:f946:b0:216:271d:e06c with SMTP id d9443c01a7336-2292ec073c5mr44194155ad.4.1743271183985;
        Sat, 29 Mar 2025 10:59:43 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1df011sm38972345ad.194.2025.03.29.10.59.42
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 10:59:43 -0700 (PDT)
Date: Sun, 30 Mar 2025 01:59:40 +0800
From: Zorro Lang <zlang@redhat.com>
To: linux-btrfs@vger.kernel.org
Subject: [Regression][xfstests btrfs/049 crash] assertion failed:
 folio_order(folio) == 0, in fs/btrfs/disk-io.c:3856
Message-ID: <20250329175940.ppblfevdilky4lnf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

My fstests regression test all crashed [1] on btrfs.

The testing kernel is linux v6.14+ (or call it v6.15-rc0), the HEAD commit is:

  commit 7d06015d936c861160803e020f68f413b5c3cd9d
  Author: Linus Torvalds <torvalds@linux-foundation.org>
  Date:   Fri Mar 28 19:36:53 2025 -0700

    Merge tag 'pci-v6.15-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci

The kernel is built with:

  CONFIG_BTRFS_FS=m
  CONFIG_BTRFS_FS_POSIX_ACL=y
  # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
  # CONFIG_BTRFS_DEBUG is not set
  CONFIG_BTRFS_ASSERT=y
  # CONFIG_BTRFS_EXPERIMENTAL is not set
  # CONFIG_BTRFS_FS_REF_VERIFY is not set

Same test passed on linux v6.14.

Thanks,
Zorro

[1]
[ 2034.655012] run fstests btrfs/049 at 2025-03-29 11:20:42 
[ 2036.211059] BTRFS: device fsid 90b97234-668a-4983-b695-76e31dd712ad devid 1 transid 8 /dev/sda5 (8:5) scanned by mount (160942) 
[ 2036.235484] BTRFS info (device sda5): first mount of filesystem 90b97234-668a-4983-b695-76e31dd712ad 
[ 2036.245943] BTRFS info (device sda5): using crc32c (crc32c-x86_64) checksum algorithm 
[ 2036.254853] BTRFS info (device sda5): using free-space-tree 
[ 2036.311936] BTRFS info (device sda5): checking UUID tree 
[ 2036.470450] Adding 36k swap on /mnt/xfstests/scratch/swap.  Priority:-3 extents:1 across:36k  
[ 2036.549168] BTRFS info (device sda5): last unmount of filesystem 90b97234-668a-4983-b695-76e31dd712ad 
[ 2037.407142] BTRFS: device fsid 348377c0-ffc8-49cd-9fd2-6925f9a17d7c devid 1 transid 8 /dev/sda5 (8:5) scanned by mkfs.btrfs (161068) 
[ 2037.422089] BTRFS: device fsid 348377c0-ffc8-49cd-9fd2-6925f9a17d7c devid 2 transid 8 /dev/sda6 (8:6) scanned by mkfs.btrfs (161068) 
[ 2037.476356] BTRFS info (device sda5): first mount of filesystem 348377c0-ffc8-49cd-9fd2-6925f9a17d7c 
[ 2037.487934] BTRFS info (device sda5): using crc32c (crc32c-x86_64) checksum algorithm 
[ 2037.496751] BTRFS info (device sda5): using free-space-tree 
[ 2037.556762] BTRFS info (device sda5): checking UUID tree 
[ 2038.606917] BTRFS info (device sda5): balance: start -d -m -s 
[ 2038.615939] BTRFS info (device sda5): relocating block group 298844160 flags data 
[ 2038.639186] BTRFS info (device sda5): balance: paused 
[ 2038.720673] BTRFS warning (device sda5): cannot activate swapfile while exclusive operation is running 
[ 2040.041304] BTRFS info (device sda5): last unmount of filesystem 348377c0-ffc8-49cd-9fd2-6925f9a17d7c 
[ 2040.130920] BTRFS info (device sda5): first mount of filesystem 348377c0-ffc8-49cd-9fd2-6925f9a17d7c 
[ 2040.141180] BTRFS info (device sda5): using crc32c (crc32c-x86_64) checksum algorithm 
[ 2040.151144] BTRFS info (device sda5): using free-space-tree 
[ 2040.213117] BTRFS info (device sda5): balance: resume skipped 
[ 2040.283234] BTRFS warning (device sda5): cannot activate swapfile while exclusive operation is running 
[ 2040.373251] assertion failed: folio_order(folio) == 0, in fs/btrfs/disk-io.c:3856 
[ 2040.381838] ------------[ cut here ]------------ 
[ 2040.387014] kernel BUG at fs/btrfs/disk-io.c:3856! 
[ 2040.392385] Oops: invalid opcode: 0000 [#1] SMP KASAN PTI 
[ 2040.398434] CPU: 14 UID: 0 PID: 161149 Comm: btrfs Kdump: loaded Not tainted 6.14.0+ #1 PREEMPT(voluntary)  
[ 2040.409313] Hardware name: FUJITSU PRIMEQUEST 2800E3/D3752, BIOS PRIMEQUEST 2000 Series BIOS Version 01.51 06/29/2020 
[ 2040.421159] RIP: 0010:write_dev_supers.cold+0xc6/0xc8 [btrfs] 
[ 2040.427881] Code: 24 e7 f0 41 ff 06 e9 ac d4 da ff b9 10 0f 00 00 48 c7 c2 60 95 41 c3 48 c7 c6 c0 9f 41 c3 48 c7 c7 e0 95 41 c3 e8 da fb 52 e6 <0f> 0b 48 8d 7b 20 b8 ff ff 37 00 48 89 fa 48 c1 e0 2a 48 c1 ea 03 
[ 2040.448840] RSP: 0018:ffffc9005e6f76d8 EFLAGS: 00010286 
[ 2040.454678] RAX: 0000000000000045 RBX: dffffc0000000000 RCX: 0000000000000000 
[ 2040.462646] RDX: 0000000000000045 RSI: ffffffffac9c97c0 RDI: fffff5200bcdeecd 
[ 2040.470615] RBP: 0000000000000000 R08: 0000000000000001 R09: fffff5200bcdee8b 
[ 2040.478582] R10: ffffc9005e6f745f R11: 0000000000000001 R12: 0000000000010000 
[ 2040.486548] R13: ffffea000f0b8000 R14: ffff88826257d0b0 R15: ffff88826257d000 
[ 2040.494516] FS:  00007f854f61a5c0(0000) GS:ffff888e582e6000(0000) knlGS:0000000000000000 
[ 2040.503550] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 
[ 2040.509964] CR2: 00005626caa45000 CR3: 00000002408bc005 CR4: 00000000003726f0 
[ 2040.517930] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 
[ 2040.525895] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400 
[ 2040.533853] Call Trace: 
[ 2040.536585]  <TASK> 
[ 2040.538929]  ? show_trace_log_lvl+0x1af/0x2f0 
[ 2040.543797]  ? show_trace_log_lvl+0x1af/0x2f0 
[ 2040.548666]  ? write_all_supers+0x854/0x1080 [btrfs] 
[ 2040.554385]  ? write_dev_supers.cold+0xc6/0xc8 [btrfs] 
[ 2040.560276]  ? __die_body.cold+0x8/0x12 
[ 2040.564559]  ? die+0x2e/0x50 
[ 2040.567778]  ? do_trap+0x1ea/0x2d0 
[ 2040.571577]  ? write_dev_supers.cold+0xc6/0xc8 [btrfs] 
[ 2040.577493]  ? do_error_trap+0xa3/0x170 
[ 2040.581775]  ? write_dev_supers.cold+0xc6/0xc8 [btrfs] 
[ 2040.587631]  ? handle_invalid_op+0x2c/0x40 
[ 2040.592205]  ? write_dev_supers.cold+0xc6/0xc8 [btrfs] 
[ 2040.598063]  ? exc_invalid_op+0x2d/0x40 
[ 2040.602347]  ? asm_exc_invalid_op+0x1a/0x20 
[ 2040.607013]  ? write_dev_supers.cold+0xc6/0xc8 [btrfs] 
[ 2040.612872]  ? write_dev_supers.cold+0xc6/0xc8 [btrfs] 
[ 2040.618753]  ? __pfx_write_dev_supers+0x10/0x10 [btrfs] 
[ 2040.624756]  ? barrier_all_devices+0x371/0x580 [btrfs] 
[ 2040.630621]  write_all_supers+0x854/0x1080 [btrfs] 
[ 2040.636152]  ? __pfx_btrfs_write_and_wait_transaction+0x10/0x10 [btrfs] 
[ 2040.643666]  ? __pfx_write_all_supers+0x10/0x10 [btrfs] 
[ 2040.649667]  ? __lock_release.isra.0+0xbc/0x2c0 
[ 2040.654731]  btrfs_commit_transaction+0x166d/0x2fd0 [btrfs] 
[ 2040.661104]  ? __pfx_btrfs_commit_transaction+0x10/0x10 [btrfs] 
[ 2040.667841]  ? lockdep_init_map_type+0x66/0x260 
[ 2040.672891]  ? btrfs_sysfs_add_device+0x20f/0x3a0 [btrfs] 
[ 2040.679052]  btrfs_init_new_device+0x11f3/0x1c30 [btrfs] 
[ 2040.685119]  ? __pfx_btrfs_init_new_device+0x10/0x10 [btrfs] 
[ 2040.691569]  ? __might_fault+0x9d/0x120 
[ 2040.695856]  ? _inline_copy_from_user+0x4f/0xa0 
[ 2040.700908]  btrfs_ioctl+0x1f3f/0x2500 [btrfs] 
[ 2040.706005]  ? __pfx_btrfs_ioctl+0x10/0x10 [btrfs] 
[ 2040.711487]  ? __lock_acquire+0x557/0xb70 
[ 2040.715966]  ? rcu_is_watching+0x15/0xb0 
[ 2040.720347]  ? __pfx_ioctl_has_perm.constprop.0.isra.0+0x10/0x10 
[ 2040.727045]  ? find_held_lock+0x32/0x90 
[ 2040.731331]  ? local_clock_noinstr+0xd/0xe0 
[ 2040.736008]  __x64_sys_ioctl+0x134/0x190 
[ 2040.740390]  do_syscall_64+0x92/0x770 
[ 2040.744478]  ? rcu_is_watching+0x15/0xb0 
[ 2040.748859]  entry_SYSCALL_64_after_hwframe+0x76/0x7e 
[ 2040.754501] RIP: 0033:0x7f854f7565ff 
[ 2040.758493] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00 
[ 2040.779454] RSP: 002b:00007ffcb6b04230 EFLAGS: 00000246 ORIG_RAX: 0000000000000010 
[ 2040.787926] RAX: ffffffffffffffda RBX: 00007ffcb6b054a8 RCX: 00007f854f7565ff 
[ 2040.795895] RDX: 00007ffcb6b042e0 RSI: 000000005000940a RDI: 0000000000000003 
[ 2040.803863] RBP: 000000003ac6f7f0 R08: 0000000000000007 R09: 00007ffcb6b0360a 
[ 2040.811822] R10: 00007f854f9f92e0 R11: 0000000000000246 R12: 0000000000000003 
[ 2040.819788] R13: 0000000000000000 R14: 0000000000000001 R15: 00007ffcb6b054a0 
[ 2040.827760]  </TASK> 
[ 2040.830199] Modules linked in: btrfs blake2b_generic xor zstd_compress raid6_pq tls rfkill sunrpc intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm vfat fat igb iTCO_wdt e1000e rapl intel_cstate mgag200 iTCO_vendor_support intel_uncore ipmi_ssif dca i2c_i801 i2c_algo_bit acpi_ipmi i2c_smbus pcspkr ipmi_si lpc_ich joydev ipmi_devintf ipmi_msghandler sg fuse loop dm_mod nfnetlink xfs sd_mod ghash_clmulni_intel megaraid_sas 
[    0.000000] Linux version 6.14.0+ (root@pq6-0.khw.eng.bos2.dc.redhat.com) (gcc (GCC) 14.2.1 20250110 (Red Hat 14.2.1-7), GNU ld version 2.41-53.el10) #1 SMP PREEMPT_DYNAMIC Sat Mar 29 10:26:25 EDT 2025 
[    0.000000] Command line: elfcorehdr=0x20000000 BOOT_IMAGE=(hd0,gpt2)/vmlinuz-6.14.0+ ro resume=UUID=0a813a92-c47a-49e8-b0dd-040222f542b3 console=ttyS0,115200n81 irqpoll nr_cpus=1 reset_devices cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 acpi_no_memhotplug transparent_hugepage=never nokaslr hest_disable novmcoredd cma=0 hugetlb_cma=0 pcie_ports=compat disable_cpu_apicid=0 


