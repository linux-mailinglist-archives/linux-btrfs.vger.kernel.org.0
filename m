Return-Path: <linux-btrfs+bounces-14838-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD63AE312B
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Jun 2025 19:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06E71697DA
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Jun 2025 17:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CE0153598;
	Sun, 22 Jun 2025 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWe+H8+B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7097430E85D
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Jun 2025 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750613524; cv=none; b=u3jnbRfFDZezWZbHkjX5XWBI7wZDO0m6SMONZ7BM8HOV82ZCrUeYWrp4MMARKU4H/q3z7x5o3kY7HJCzlzL0vV1A20LVufZuUf98wXvI4xVb2sVSA2GCSi1OeyhHypxWyzyM2RcQkRIw9oIsZ2T8ODagoKQpaEfbiq2i3C2sSrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750613524; c=relaxed/simple;
	bh=oqLOFZJQUMUNWLEQ3MRX4stvJx0kzhawe/q/WOxo8xQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=adp4vD1JJ6wxgELIMcAoTcYoXgsnbDk2B17HS/7on4XdE9FkJbPZOSY01aiBxeBnaYHp6tvWENsZaX73QlOchEXZuWYMOJLpCdUm/+29RJFGiGn3SJm4xRE8KSWWG48DEeqhiNvoa0AuZd3+OoQJt+RIzom1dL8b2UsLsXJd2ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWe+H8+B; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a77ffcb795so19521631cf.0
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Jun 2025 10:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750613521; x=1751218321; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a+hlklEX6zEmmuwd/MpLsnhr6E0fhbKvdimuChpmC4Y=;
        b=RWe+H8+B5vavci1cCDqko+jgpt6Bcm5W2sK+jctF7uGb6n2rUqMKFkcCTrLhDVeAzP
         zr27iY2e4Tcsq6qzQmqD1zjLDB/K4O986nOJtDesDdFmDnf2ufPoL1tZdFZ6BIktY8XL
         dYqcvO291FF18/HlC2scUtWdm/TvS0daa47xBsg41CrFghMdUPb1tiIIvsgig1qwlQkI
         UJm/G5YOjBOfU+JJ61j7/kI6ftRgepAv+/GGZ9GPiKr3yHnIJZpKor8OHt7DwtNwIvNU
         N8Z4iQ6hThHaQOYl0MB2tI3XotEprfKd1bycugSsMdka0heUrWyHehlyKy0sZXywmTdD
         sJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750613521; x=1751218321;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a+hlklEX6zEmmuwd/MpLsnhr6E0fhbKvdimuChpmC4Y=;
        b=IEZC4/J4ezg64EUwEidtNPlPU61qtujPibhYH5/+gOE/9ok52Qwk36baFFFknsnqOo
         IkPy9WWZZVqk3NSr9lZQcy99LrkrH2EHF6oFc44d/Tp5K8fGvBYKgh2pHPIDOBV3lEEv
         /ebeJFriNvcggtI44rmRbxC9CBMX/rJ0CQK6AFYdi1QzUJPRnFAkRLgufrekHnUXPNSe
         Z74f0LsIfeUUbIMMZPE65RGxpE+bBRrXh6AezrPN/BJjYIyocrHgfNhuHpmRBKhEBzkG
         GMoiG3E85/Cr1LBk1BgMIGydkk8hCzZrnTjIUABtgzRsbNcyvgnxEKh1mTcFXW8BLITq
         JWOg==
X-Gm-Message-State: AOJu0YytiiJhDD0cTUQMjTXqHXIbXyQrCoeQbxqznTqyKRlsYso41G//
	rprQnAkGSdC71QmkEp6lVLhqLEpqbd2xoXuosXY4t1NJxm9/E3MaVM8B4Y2Dw4KggFhGERTooUb
	Ho08MMaFXvQnWXk5CJQtwt4GXhfOY8NQqFGEd
X-Gm-Gg: ASbGncuEwOu765BKdCCJdx5JfhNsFlZRNYVhArPN3IaZdQx2BVkKkW9YkLNfpUxt+xR
	mCbLu3Qs9o0ImWWPDkxgbtrMcsR1pyWjY26Y+K4bGgVgDPUKGJWXUc1UWKMHUit3Nr8jsjbSL4D
	vgEc2gZCb3OWf3Y152DGF5kg1IXEg5fudb5Y9NNT74SJKROBV7gEfp1HSTVpNHr3Pw6gL9GJLwm
	d1Y
X-Google-Smtp-Source: AGHT+IFVYsu1IFdJ1ySKJ4Vxivef/YELLKBgYGzk5OqMvsJSljTJ4lzOD1+GYEjA6Rv2PbYHKQylkKV/FAS7/KxDWFI=
X-Received: by 2002:a05:622a:1353:b0:4a7:707b:5dec with SMTP id
 d75a77b69052e-4a77a231b31mr116572851cf.24.1750613520937; Sun, 22 Jun 2025
 10:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kai Krakow <hurikhan77@gmail.com>
Date: Sun, 22 Jun 2025 19:31:35 +0200
X-Gm-Features: AX0GCFslD3YrKJxbh-INxhQQtIX0fh-xW7W2Ioy8ztg5zK4IpcFlg6oWRyIb-sQ
Message-ID: <CAMthOuMkG7apm2thceT4rAkdJ-Y7aBBZSxF4Ct219aE6qiaGFw@mail.gmail.com>
Subject: 
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello btrfs list!

Once in a while, we are seeing the following kernel bug during the
night while the backup is putting some additional load on the system:

Jun 22 04:11:29 vch01 kernel: rcu: INFO: rcu_sched self-detected stall on CPU
Jun 22 04:11:29 vch01 kernel: rcu:         10-....: (2100 ticks this
GP) idle=0494/1/0x4000000000000000 softirq=164826140/164826187
fqs=1052
Jun 22 04:11:29 vch01 kernel: rcu:         (t=2100 jiffies g=358306033
q=2241752 ncpus=16)
Jun 22 04:11:29 vch01 kernel: CPU: 10 UID: 0 PID: 1524681 Comm:
map_0x178e45670 Not tainted 6.12.21-gentoo #1
Jun 22 04:11:29 vch01 kernel: Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
Jun 22 04:11:29 vch01 kernel: RIP: 0010:btrfs_get_64+0x65/0x110
Jun 22 04:11:29 vch01 kernel: Code: d3 ed 48 8b 4f 70 48 8b 31 83 e6
40 74 11 0f b6 49 40 41 bc 00 10 00 00 49 d3 e4 49 83 ec 01 4a 8b 5c
ed 70 49 21 d4 45 89 c9 <48> 2b 1d 7c 99 09 01 49 01 c1 8b 55 08 49 8d
49 08 44 8b 75 0c 48
Jun 22 04:11:29 vch01 kernel: RSP: 0018:ffffbb7ad531bba0 EFLAGS: 00000202
Jun 22 04:11:29 vch01 kernel: RAX: 0000000000001f15 RBX:
fffff437ea382200 RCX: fffff437cb891200
Jun 22 04:11:29 vch01 kernel: RDX: 000001922b68df2a RSI:
0000000000000000 RDI: ffffa434c3e66d20
Jun 22 04:11:29 vch01 kernel: RBP: ffffa434c3e66d20 R08:
000001922b68c000 R09: 0000000000000015
Jun 22 04:11:29 vch01 kernel: R10: 6c0000000000000a R11:
0000000009fe7000 R12: 0000000000000f2a
Jun 22 04:11:29 vch01 kernel: R13: 0000000000000001 R14:
ffffa43192e6d230 R15: ffffa43160c4c800
Jun 22 04:11:29 vch01 kernel: FS:  000055d07085e6c0(0000)
GS:ffffa4452bc80000(0000) knlGS:0000000000000000
Jun 22 04:11:29 vch01 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jun 22 04:11:29 vch01 kernel: CR2: 00007fff204ecfc0 CR3:
0000000121a0b000 CR4: 00000000001506f0
Jun 22 04:11:29 vch01 kernel: DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000
Jun 22 04:11:29 vch01 kernel: DR3: 0000000000000000 DR6:
00000000fffe0ff0 DR7: 0000000000000400
Jun 22 04:11:29 vch01 kernel: Call Trace:
Jun 22 04:11:29 vch01 kernel:  <IRQ>
Jun 22 04:11:29 vch01 kernel:  ? rcu_dump_cpu_stacks+0xd3/0x100
Jun 22 04:11:29 vch01 kernel:  ? rcu_sched_clock_irq+0x4ff/0x920
Jun 22 04:11:29 vch01 kernel:  ? update_process_times+0x6c/0xa0
Jun 22 04:11:29 vch01 kernel:  ? tick_nohz_handler+0x82/0x110
Jun 22 04:11:29 vch01 kernel:  ? tick_do_update_jiffies64+0xd0/0xd0
Jun 22 04:11:29 vch01 kernel:  ? __hrtimer_run_queues+0x10b/0x190
Jun 22 04:11:29 vch01 kernel:  ? hrtimer_interrupt+0xf1/0x200
Jun 22 04:11:29 vch01 kernel:  ? __sysvec_apic_timer_interrupt+0x44/0x50
Jun 22 04:11:29 vch01 kernel:  ? sysvec_apic_timer_interrupt+0x60/0x80
Jun 22 04:11:29 vch01 kernel:  </IRQ>
Jun 22 04:11:29 vch01 kernel:  <TASK>
Jun 22 04:11:29 vch01 kernel:  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
Jun 22 04:11:29 vch01 kernel:  ? btrfs_get_64+0x65/0x110
Jun 22 04:11:29 vch01 kernel:  find_parent_nodes+0x1b84/0x1dc0
Jun 22 04:11:29 vch01 kernel:  btrfs_find_all_leafs+0x31/0xd0
Jun 22 04:11:29 vch01 kernel:  ? queued_write_lock_slowpath+0x30/0x70
Jun 22 04:11:29 vch01 kernel:  iterate_extent_inodes+0x6f/0x370
Jun 22 04:11:29 vch01 kernel:  ? update_share_count+0x60/0x60
Jun 22 04:11:29 vch01 kernel:  ? extent_from_logical+0x139/0x190
Jun 22 04:11:29 vch01 kernel:  ? release_extent_buffer+0x96/0xb0
Jun 22 04:11:29 vch01 kernel:  iterate_inodes_from_logical+0xaa/0xd0
Jun 22 04:11:29 vch01 kernel:  btrfs_ioctl_logical_to_ino+0xaa/0x150
Jun 22 04:11:29 vch01 kernel:  __x64_sys_ioctl+0x84/0xc0
Jun 22 04:11:29 vch01 kernel:  do_syscall_64+0x47/0x100
Jun 22 04:11:29 vch01 kernel:  entry_SYSCALL_64_after_hwframe+0x4b/0x53
Jun 22 04:11:29 vch01 kernel: RIP: 0033:0x55d07617eaaf
Jun 22 04:11:29 vch01 kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 44
24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24
10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64
48 2b 04 25 28 00 00
Jun 22 04:11:29 vch01 kernel: RSP: 002b:000055d07085bc20 EFLAGS:
00000246 ORIG_RAX: 0000000000000010
Jun 22 04:11:29 vch01 kernel: RAX: ffffffffffffffda RBX:
000055d0402f8550 RCX: 000055d07617eaaf
Jun 22 04:11:29 vch01 kernel: RDX: 000055d07085bca0 RSI:
00000000c038943b RDI: 0000000000000003
Jun 22 04:11:29 vch01 kernel: RBP: 000055d07085bea0 R08:
00007fee46c84080 R09: 0000000000000000
Jun 22 04:11:29 vch01 kernel: R10: 0000000000000000 R11:
0000000000000246 R12: 0000000000000003
Jun 22 04:11:29 vch01 kernel: R13: 000055d07085bf80 R14:
000055d07085bf48 R15: 000055d07085c0b0
Jun 22 04:11:29 vch01 kernel:  </TASK>

Some more information about the environment and incident observations:

The kernel is compiled without module support, everything baked in, no
proprietary modules.

The file system has previously been recreated by restoring from backup
but we still see this problem once in a while, so I suspect there's no
file system inconsistency involved.

The rootfs itself is on xfs, so I can still login. But the system is
very slow, takes 5-10 minutes to log in via SSH, commands like
"reboot" time out because the system dbus is congested.

This bug cannot be easily triggered. So far, it only happened at
night, the system needs uptime of multiple days or weeks, with some
amount of swap used, and the backup (borg backup) has to run. So I
think this happens because we get some memory pressure while we also
have memory fragmentation going on for some time.

The system is running bees on the btrfs pool because naturally this
web and mail hosting system has a lot of duplicate files. Mysql is
running on xfs only. Temporary files during backup are created on xfs
only (the backup can access the btrfs only via r/o, no writes
allowed). Snapper takes snapshots every hour and cleans out older
snapshots over time.

I've now upgraded to the current Gentoo stable release 6.21.31 of the kernel.

btrfs is running in single data / raid1 meta on three disks provided
by KVM via virtio. The KVM images itself are served by drbd redundant
over multiple servers (outside of the VM). The hardware itself has no
known hardware issues (no memory errors, no storage errors). Scrubbing
finds no checksum or other errors. The VM or storage hasn't been
migrated at time of the incident or recently.

#  uname -a
Linux vch01 6.12.21-gentoo #2 SMP Thu May 15 18:02:52 CEST 2025 x86_64
Intel Xeon E3-12xx v2 (Ivy Bridge) GenuineIntel GNU/Linux

# free -m
              total        used        free      shared  buff/cache   available
Mem:           84476       33122        1941        3344       48183       51353
Swap:          15358        5362        9996

#  cat /proc/cpuinfo | egrep 'processor|model|cpu|cache' | sort -u
bugs            : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass
l1tf mds swapgs itlb_multihit srbds mmio_unknown bhi
cache_alignment : 64
cache size      : 4096 KB
cpu cores       : 1
cpu family      : 6
cpuid level     : 13
cpu MHz         : 2399.998
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx rdtscp lm
constant_tsc rep_good nopl cpuid tsc_known_freq pni pclmulqdq ssse3
cx16 sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c
rdrand hypervisor lahf_lm fsgsbase smep erms xsaveopt
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx rdtscp lm
constant_tsc rep_good nopl cpuid tsc_known_freq pni pclmulqdq ssse3
cx16 sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c
rdrand hypervisor lahf_lm intel_ppin fsgsbase smep erms xsaveopt
model           : 58
model name      : Intel Xeon E3-12xx v2 (Ivy Bridge)
processor       : 0
processor       : 1
processor       : 10
processor       : 11
processor       : 12
processor       : 13
processor       : 14
processor       : 15
processor       : 2
processor       : 3
processor       : 4
processor       : 5
processor       : 6
processor       : 7
processor       : 8
processor       : 9

Thanks for looking into it. If you need more information, I may be
able to provide it as long as I don't have to get it from the still
running machine: it has been rebooted since the incident.

Regards,
Kai

