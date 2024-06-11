Return-Path: <linux-btrfs+bounces-5642-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D34A90368B
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 10:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B101F2600F
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 08:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06973174EE2;
	Tue, 11 Jun 2024 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yzcf6PBe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D6414290
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094757; cv=none; b=C0pEs4pQYretSVPpHqdxDaGUAFsqvB1OHOK4W0AnVvcCgD8SV2IRGXL5GfD/H0n79JTSQAnnVbf+eCcuyI2a6RfBUs33/aCucwDni5Gr1pIaz5GqGV1YFG9NhsxZftkl0kLYPhQdrPUjiRtFKDwaH4rCSzeqXW3bZtM4zZJgdDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094757; c=relaxed/simple;
	bh=hkWA6X6iG4sEWhL+A0cqVZT0o1PJb+M9FUyAWL85wa8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=PrNOeM4DoeNaPgzfELgvO1YacF9lS2YItiHNvUGsLJLNkx+lK2kx3dfLKk2Bru2IYZUfmWHEassp+zWgUP3u3VjAoAjGkg6L6aoA4pnZFqubhPD42tVQLgVdTRQVm1I01cI498vCpv7C7lUSUgaBzt4LZ5o1u9cfl400EOqoEBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yzcf6PBe; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70432d3406bso1894524b3a.1
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718094754; x=1718699554; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ik65dSzaynIxHYc1O0NTRpIoCLJYUjl3NCPNWoats24=;
        b=Yzcf6PBeERVQuxchA6ORHJAw9Sr3Hl0JvP3oFEinW7XNQt0MU7JhCmDAITN/o+TZOP
         4irQ6Yk8JCAo8yK6KLyUGZqbwmkf6KnRFCmffOQ+HVREEN7HFNzmHisXg/Ct0uyu5/ma
         Mr+dulsiS66IepymHScUkqNWDnLZGAdW17y1MKW+3vMWRaNcHLerVqIZbQoHH8guqT5Q
         1OWHxK1TTcZmprQ4VAdK+f1rpvPi1ryETnugx3j/LKl7WqmuRPBobJrgA1VwbrnWpiz2
         0GtHPEiLJGyAH8CT20lR+ra29pg7v33rJP7n76WTxCvaXynYvcavf7PIcXFhpL92hv/D
         ac2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718094754; x=1718699554;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ik65dSzaynIxHYc1O0NTRpIoCLJYUjl3NCPNWoats24=;
        b=GDoAxCWI28LFi3YeF2AKYfqJlVNvkdI5viwff4z69V0tVNofOQP3uTkK0cCGXfYLN6
         4FRu3+ZO7AvIgAQL3hoNELxHn7PgPxZtl/3JP1xVZNzlulrWp/2fjv19TKmxdQMEFhUR
         zA195yTVKOVLZkSMQt69bzTS/eXtc6yLG2bzqpXbDfODB3t07MmyhENqOpeBYENBLINn
         HXNb0ZEDC5bCVhAK9qQB/S5FLXFymQ1lQVyT7Pa3Oqy3isyP3FjCeVLZ+rmnEL3eHKE+
         InfhHIRVcVF+YV933jPmAtMk3vfAAy4vwXJsXgvtacIxHPXUodCMvvn20snySkJ8jp6Z
         cpug==
X-Gm-Message-State: AOJu0YxOu1sYv3obOwpPxaXR0O8SjpxnV9AB7bVzqHiEE4YD4wVWG1rw
	nc5uZgZc78awTKipOefnOyEwBb3/PFRqcj4Jy1HptGcK7o4DTJ14lJWxeMKnMTl+SlfDdkdsxEM
	jSP1KGx7cO65eVNQ54j9JD1z1561rghSJ
X-Google-Smtp-Source: AGHT+IEVToFa1EnZyzGeYiWEmRKE8EdcUuCD22tjPWgu1ZgCrKgESg1MNkT5Kx3CRS9oXe8UuQRMe053vttdg+OBDzU=
X-Received: by 2002:a05:6a21:6d91:b0:1b4:a478:227b with SMTP id
 adf61e73a8af0-1b4a478234amr10321892637.20.1718094754224; Tue, 11 Jun 2024
 01:32:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Darius Ski <darius.ski@gmail.com>
Date: Tue, 11 Jun 2024 11:32:23 +0300
Message-ID: <CAKt3ReKmcitUjF66q2Y3QS7-69DXmpecY_fUKp9dEOk_jLHrpw@mail.gmail.com>
Subject: [bug-report] BTRFS lock up on 6.8.7
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

we have btrfs running on single NVME device, mounted as
UUID=b74b3db5-e432-4b78-b101-e7200879c7e7       /storage/mysql  btrfs
 noatime,nodiratime,nodatacow,nodiscard  0       1
===
nvme12n1     btrfs
b74b3db5-e432-4b78-b101-e7200879c7e7    1.4T    59% /storage/mysql_old

And during this morning it completely locked up when under light mysql load.
Of interest, we are doing the dance of :
obtain mysql lock / make snapshot / copy files from snapshot to
different disk / drop snapshot

But it has been working since 2019 on old server ( and also saved our
bottoms today, as we had perfectly workable copy of >TB database ).

Lock up happened ~4 hours after completing snapshot dance ( if it is
even related at all ).

[721257.851100] INFO: task mysqld:6614 blocked for more than 120 seconds.
[721257.851272]       Not tainted 6.8.7-custom #1
[721257.851419] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[721257.851682] task:mysqld          state:D stack:0     pid:6614
tgid:6579  ppid:1      flags:0x00000002
[721257.851686] Call Trace:
[721257.851688]  <TASK>
[721257.851692]  __schedule+0x36a/0x9a0
[721257.851700]  ? common_interrupt+0xf/0xa0
[721257.851704]  schedule+0x27/0xc0
[721257.851705]  schedule_preempt_disabled+0xa/0x10
[721257.851707]  rwsem_down_read_slowpath+0x1cb/0x430
[721257.851711]  down_read+0x3d/0x80
[721257.851712]  __btrfs_tree_read_lock+0x17/0x60
[721257.851718]  btrfs_search_slot+0x391/0xc80
[721257.851724]  ? set_state_bits.isra.0+0x77/0x80
[721257.851729]  ? __cond_resched+0x16/0x40
[721257.851731]  btrfs_lookup_file_extent+0x37/0x40
[721257.851734]  can_nocow_extent+0xa1/0x2a0
[721257.851737]  ? btrfs_get_extent+0x3e6/0x6f0
[721257.851739]  ? lock_extent+0x3f/0x280
[721257.851743]  btrfs_dio_iomap_begin+0x573/0xab0
[721257.851745]  ? __cond_resched+0x16/0x40
[721257.851746]  ? kmalloc_trace+0x1d8/0x270
[721257.851750]  iomap_iter+0x173/0x2e0
[721257.851755]  __iomap_dio_rw+0x177/0x750
[721257.851757]  ? load_balance+0x171/0xe70
[721257.851761]  btrfs_dio_write+0x4b/0x50
[721257.851762]  btrfs_do_write_iter+0x23c/0x500
[721257.851764]  aio_write+0x109/0x1f0
[721257.851768]  ? mpol_misplaced+0x5d/0x1e0
[721257.851772]  ? __cond_resched+0x16/0x40
[721257.851772]  ? kmem_cache_alloc+0x1c4/0x260
[721257.851773]  ? io_submit_one+0x452/0x770
[721257.851775]  io_submit_one+0x452/0x770
[721257.851778]  __x64_sys_io_submit+0x69/0x120
[721257.851780]  do_syscall_64+0x3a/0xc0
[721257.851782]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[721257.851786] RIP: 0033:0x7ff446c41719
[721257.851788] RSP: 002b:00007fe40dbff2d8 EFLAGS: 00000246 ORIG_RAX:
00000000000000d1
[721257.851790] RAX: ffffffffffffffda RBX: 00007fe40dc00618 RCX:
00007ff446c41719
[721257.851791] RDX: 00007fe40dbff318 RSI: 0000000000000001 RDI:
00007ff44435c000
[721257.851791] RBP: 00007ff44435c000 R08: 00000000000b00d9 R09:
000000000000000b
[721257.851792] R10: 00007fe40dbff318 R11: 0000000000000246 R12:
0000000000000001
[721257.851793] R13: 000000000000000d R14: 00007fe40dbff318 R15:
00007ff4421cfc10
[721257.851794]  </TASK>
[721257.851802] INFO: task mysqld:12146 blocked for more than 120 seconds.
[721257.851968]       Not tainted 6.8.7-custom #1
[721257.852115] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[721257.852379] task:mysqld          state:D stack:0     pid:12146
tgid:6579  ppid:1      flags:0x00000002
[721257.852381] Call Trace:
[721257.852382]  <TASK>
[721257.852383]  __schedule+0x36a/0x9a0
[721257.852384]  ? __cond_resched+0x16/0x40
[721257.852385]  schedule+0x27/0xc0
[721257.852386]  io_schedule+0x42/0x70
[721257.852387]  folio_wait_bit_common+0x112/0x300
[721257.852393]  ? filemap_alloc_folio+0xe0/0xe0
[721257.852394]  __filemap_get_folio+0x200/0x2c0
[721257.852398]  ? __file_remove_privs+0x9c/0x120
[721257.852400]  pagecache_get_page+0xe/0x40
[721257.852404]  prepare_pages.constprop.0+0xdc/0x1f0
[721257.852406]  btrfs_buffered_write+0x2b7/0x910
[721257.852409]  btrfs_do_write_iter+0x2cf/0x500
[721257.852411]  vfs_write+0x238/0x400
[721257.852417]  __x64_sys_pwrite64+0x72/0xb0
[721257.852419]  do_syscall_64+0x3a/0xc0
[721257.852421]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[721257.852423] RIP: 0033:0x7ff446c363b7
[721257.852424] RSP: 002b:00007fe41f163490 EFLAGS: 00000293 ORIG_RAX:
0000000000000012
[721257.852425] RAX: ffffffffffffffda RBX: 00007fe41f1636e0 RCX:
00007ff446c363b7
[721257.852426] RDX: 0000000000000400 RSI: 00007feb252d3c30 RDI:
00000000000000a6
[721257.852427] RBP: 00007fe41f163590 R08: 0000000000000000 R09:
0000000000000000
[721257.852428] R10: 0000000000176400 R11: 0000000000000293 R12:
0000000000000400
[721257.852428] R13: 00007feb252d3c30 R14: 0000000000000000 R15:
00007fe41f169618
[721257.852429]  </TASK>
[721257.852440] INFO: task mysqld:1490063 blocked for more than 120 seconds.
[721257.852610]       Not tainted 6.8.7-custom #1
[721257.852759] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[721257.853022] task:mysqld          state:D stack:0     pid:1490063
tgid:6579  ppid:1      flags:0x00000002
[721257.853023] Call Trace:
[721257.853024]  <TASK>
[721257.853025]  __schedule+0x36a/0x9a0
[721257.853026]  schedule+0x27/0xc0
[721257.853027]  schedule_preempt_disabled+0xa/0x10
[721257.853028]  rwsem_down_read_slowpath+0x1cb/0x430
[721257.853030]  ? schedule+0x90/0xc0
[721257.853031]  down_read+0x3d/0x80
[721257.853032]  __btrfs_tree_read_lock+0x17/0x60
[721257.853033]  btrfs_read_lock_root_node+0x34/0x70
[721257.853034]  btrfs_search_slot+0x11c/0xc80
[721257.853037]  ? __cond_resched+0x16/0x40
[721257.853038]  btrfs_lookup_file_extent+0x37/0x40
[721257.853039]  btrfs_get_extent+0x10f/0x6f0
[721257.853040]  ? clear_state_bit+0xab/0x150
[721257.853042]  btrfs_set_extent_delalloc+0xa4/0x170
[721257.853044]  btrfs_dirty_pages+0xb8/0x190
[721257.853046]  btrfs_buffered_write+0x606/0x910
[721257.853049]  btrfs_do_write_iter+0x2cf/0x500
[721257.853050]  vfs_write+0x238/0x400
[721257.853053]  __x64_sys_pwrite64+0x72/0xb0
[721257.853054]  do_syscall_64+0x3a/0xc0
[721257.853056]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[721257.853058] RIP: 0033:0x7ff446c363b7
[721257.853059] RSP: 002b:00007fe427566f50 EFLAGS: 00000293 ORIG_RAX:
0000000000000012
[721257.853060] RAX: ffffffffffffffda RBX: 00000000000000b0 RCX:
00007ff446c363b7
[721257.853061] RDX: 00000000000000b0 RSI: 00007fe1b8086a94 RDI:
000000000000042e
[721257.853062] RBP: 00007fe427567050 R08: 0000000000000000 R09:
00007fe427567070
[721257.853062] R10: 000000018ce03fcc R11: 0000000000000293 R12:
00000000000000b0
[721257.853063] R13: 00007fe1b8086a94 R14: 0000000000000000 R15:
00007fe427569618
[721257.853065]  </TASK>
[721257.853066] INFO: task mysqld:1490071 blocked for more than 120 seconds.
[721257.853247]       Not tainted 6.8.7-custom #1
[721257.853395] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[721257.853660] task:mysqld          state:D stack:0     pid:1490071
tgid:6579  ppid:1      flags:0x00000002
[721257.853661] Call Trace:
[721257.853662]  <TASK>
[721257.853663]  __schedule+0x36a/0x9a0
[721257.853665]  schedule+0x27/0xc0
[721257.853666]  schedule_preempt_disabled+0xa/0x10
[721257.853667]  rwsem_down_read_slowpath+0x1cb/0x430
[721257.853669]  down_read+0x3d/0x80
[721257.853670]  __btrfs_tree_read_lock+0x17/0x60
[721257.853671]  btrfs_read_lock_root_node+0x34/0x70
[721257.853672]  btrfs_search_slot+0x11c/0xc80
[721257.853675]  ? __cond_resched+0x16/0x40
[721257.853676]  ? __cond_resched+0x16/0x40
[721257.853676]  btrfs_lookup_file_extent+0x37/0x40
[721257.853678]  btrfs_get_extent+0x10f/0x6f0
[721257.853680]  btrfs_set_extent_delalloc+0xa4/0x170
[721257.853681]  btrfs_dirty_pages+0xb8/0x190
[721257.853682]  btrfs_buffered_write+0x606/0x910
[721257.853684]  btrfs_do_write_iter+0x2cf/0x500
[721257.853686]  vfs_write+0x238/0x400
[721257.853687]  ksys_write+0x53/0xc0
[721257.853689]  do_syscall_64+0x3a/0xc0
[721257.853690]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[721257.853691] RIP: 0033:0x7ff446c3827f
[721257.853692] RSP: 002b:00007fe437d99270 EFLAGS: 00000293 ORIG_RAX:
0000000000000001
[721257.853692] RAX: ffffffffffffffda RBX: 00007fdfbc016780 RCX:
00007ff446c3827f
[721257.853693] RDX: 0000000000004b40 RSI: 00007fe1ec051b10 RDI:
0000000000000165
[721257.853694] RBP: 00007fe437d99370 R08: 0000000000000000 R09:
0000000000000001
[721257.853694] R10: 00007fe437d993b0 R11: 0000000000000293 R12:
0000000000004b40
[721257.853695] R13: 0000000000000000 R14: 00007fe1ec051b10 R15:
00007fe437d9b618
[721257.853696]  </TASK>
[721257.853698] INFO: task mysqld:1490103 blocked for more than 120 seconds.
[721257.853886]       Not tainted 6.8.7-custom #1
[721257.854033] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[721257.854297] task:mysqld          state:D stack:0     pid:1490103
tgid:6579  ppid:1      flags:0x00000002
[721257.854298] Call Trace:
[721257.854299]  <TASK>
[721257.854300]  __schedule+0x36a/0x9a0
[721257.854301]  schedule+0x27/0xc0
[721257.854302]  schedule_preempt_disabled+0xa/0x10
[721257.854303]  rwsem_down_read_slowpath+0x1cb/0x430
[721257.854304]  ? schedule+0x90/0xc0
[721257.854305]  down_read+0x3d/0x80
[721257.854306]  __btrfs_tree_read_lock+0x17/0x60
[721257.854307]  btrfs_read_lock_root_node+0x34/0x70
[721257.854309]  btrfs_search_slot+0x11c/0xc80
[721257.854311]  ? kmem_cache_alloc+0x1c4/0x260
[721257.854312]  ? alloc_extent_state+0x17/0x90
[721257.854314]  ? __cond_resched+0x16/0x40
[721257.854315]  btrfs_lookup_file_extent+0x37/0x40
[721257.854317]  btrfs_get_extent+0x10f/0x6f0
[721257.854318]  ? __cond_resched+0x16/0x40
[721257.854319]  btrfs_set_extent_delalloc+0xa4/0x170
[721257.854321]  btrfs_dirty_pages+0xb8/0x190
[721257.854322]  btrfs_buffered_write+0x606/0x910
[721257.854323]  ? __sk_flush_backlog+0x10/0x40
[721257.854329]  btrfs_do_write_iter+0x2cf/0x500
[721257.854330]  vfs_write+0x238/0x400
[721257.854332]  __x64_sys_pwrite64+0x72/0xb0
[721257.854334]  do_syscall_64+0x3a/0xc0
[721257.854335]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[721257.854336] RIP: 0033:0x7ff446c363b7
[721257.854336] RSP: 002b:00007fe41f198f50 EFLAGS: 00000293 ORIG_RAX:
0000000000000012
[721257.854337] RAX: ffffffffffffffda RBX: 0000000000010728 RCX:
00007ff446c363b7
[721257.854337] RDX: 0000000000010728 RSI: 00007fe1a0187383 RDI:
000000000000044d
[721257.854338] RBP: 00007fe41f199050 R08: 0000000000000000 R09:
00007fe41f199070
[721257.854338] R10: 00000022bd4eb8a8 R11: 0000000000000293 R12:
0000000000010728
[721257.854339] R13: 00007fe1a0187383 R14: 0000000000000000 R15:
00007fe41f19b618
[721257.854340]  </TASK>
[721257.854873] INFO: task kworker/u385:5:1086049 blocked for more
than 120 seconds.
[721257.855069]       Not tainted 6.8.7-custom #1
[721257.855216] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[721257.855480] task:kworker/u385:5  state:D stack:0     pid:1086049
tgid:1086049 ppid:2      flags:0x00004000
[721257.855482] Workqueue: btrfs-endio-write btrfs_work_helper
[721257.855487] Call Trace:
[721257.855488]  <TASK>
[721257.855488]  __schedule+0x36a/0x9a0
[721257.855490]  schedule+0x27/0xc0
[721257.855491]  schedule_preempt_disabled+0xa/0x10
[721257.855492]  rwsem_down_read_slowpath+0x1cb/0x430
[721257.855494]  down_read+0x3d/0x80
[721257.855495]  __btrfs_tree_read_lock+0x17/0x60
[721257.855496]  btrfs_read_lock_root_node+0x34/0x70
[721257.855497]  btrfs_search_slot+0x11c/0xc80
[721257.855499]  btrfs_lookup_file_extent+0x37/0x40
[721257.855500]  btrfs_drop_extents+0x10c/0xe00
[721257.855503]  insert_reserved_file_extent+0xd9/0x360
[721257.855505]  ? join_transaction+0x24/0x400
[721257.855509]  ? start_transaction+0xd0/0x7a0
[721257.855511]  btrfs_finish_one_ordered+0x5bd/0xa30
[721257.855513]  ? select_task_rq_fair+0x1b3/0x1200
[721257.855519]  btrfs_work_helper+0xda/0x310
[721257.855522]  process_one_work+0x13f/0x2c0
[721257.855526]  worker_thread+0x26d/0x390
[721257.855528]  ? rescuer_thread+0x380/0x380
[721257.855530]  kthread+0xc3/0xf0
[721257.855533]  ? kthread_complete_and_exit+0x20/0x20
[721257.855535]  ret_from_fork+0x2d/0x50
[721257.855538]  ? kthread_complete_and_exit+0x20/0x20
[721257.855539]  ret_from_fork_asm+0x11/0x20
[721257.855543]  </TASK>
[721257.855544] INFO: task kworker/u385:16:1096779 blocked for more
than 120 seconds.
[721257.855739]       Not tainted 6.8.7-custom #1
[721257.855885] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[721257.856148] task:kworker/u385:16 state:D stack:0     pid:1096779
tgid:1096779 ppid:2      flags:0x00004000
[721257.856150] Workqueue: btrfs-endio-write btrfs_work_helper
[721257.856152] Call Trace:
[721257.856153]  <TASK>
[721257.856153]  __schedule+0x36a/0x9a0
[721257.856155]  schedule+0x27/0xc0
[721257.856156]  schedule_preempt_disabled+0xa/0x10
[721257.856156]  rwsem_down_read_slowpath+0x1cb/0x430
[721257.856158]  down_read+0x3d/0x80
[721257.856160]  __btrfs_tree_read_lock+0x17/0x60
[721257.856161]  btrfs_read_lock_root_node+0x34/0x70
[721257.856161]  btrfs_search_slot+0x11c/0xc80
[721257.856164]  ? intel_iommu_iotlb_sync_map+0x79/0xc0
[721257.856168]  btrfs_lookup_file_extent+0x37/0x40
[721257.856170]  btrfs_drop_extents+0x10c/0xe00
[721257.856172]  insert_reserved_file_extent+0xd9/0x360
[721257.856173]  ? join_transaction+0x24/0x400
[721257.856175]  ? start_transaction+0xd0/0x7a0
[721257.856177]  btrfs_finish_one_ordered+0x5bd/0xa30
[721257.856178]  ? sched_clock+0x5/0x10
[721257.856179]  btrfs_work_helper+0xda/0x310
[721257.856181]  process_one_work+0x13f/0x2c0
[721257.856183]  worker_thread+0x26d/0x390
[721257.856184]  ? rescuer_thread+0x380/0x380
[721257.856185]  kthread+0xc3/0xf0
[721257.856186]  ? kthread_complete_and_exit+0x20/0x20
[721257.856187]  ret_from_fork+0x2d/0x50
[721257.856188]  ? kthread_complete_and_exit+0x20/0x20
[721257.856188]  ret_from_fork_asm+0x11/0x20
[721257.856190]  </TASK>
[721257.856192] INFO: task kworker/u385:17:1116291 blocked for more
than 120 seconds.
[721257.856401]       Not tainted 6.8.7-custom #1
[721257.856547] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[721257.856810] task:kworker/u385:17 state:D stack:0     pid:1116291
tgid:1116291 ppid:2      flags:0x00004000
[721257.856812] Workqueue: btrfs-endio-write btrfs_work_helper
[721257.856814] Call Trace:
[721257.856815]  <TASK>
[721257.856816]  __schedule+0x36a/0x9a0
[721257.856817]  schedule+0x27/0xc0
[721257.856818]  schedule_preempt_disabled+0xa/0x10
[721257.856818]  rwsem_down_write_slowpath+0x279/0x590
[721257.856820]  down_write+0x38/0x40
[721257.856822]  __btrfs_tree_lock+0x17/0x60
[721257.856823]  btrfs_lock_root_node+0x34/0x70
[721257.856824]  btrfs_search_slot+0x177/0xc80
[721257.856825]  ? intel_iommu_iotlb_sync_map+0x79/0xc0
[721257.856826]  btrfs_lookup_file_extent+0x37/0x40
[721257.856828]  btrfs_drop_extents+0x10c/0xe00
[721257.856829]  ? dma_pool_alloc+0x54/0x200
[721257.856831]  insert_reserved_file_extent+0xd9/0x360
[721257.856832]  ? join_transaction+0x24/0x400
[721257.856834]  ? start_transaction+0xd0/0x7a0
[721257.856836]  btrfs_finish_one_ordered+0x5bd/0xa30
[721257.856837]  ? select_task_rq_fair+0x1b3/0x1200
[721257.856839]  btrfs_work_helper+0xda/0x310
[721257.856841]  process_one_work+0x13f/0x2c0
[721257.856842]  worker_thread+0x26d/0x390
[721257.856843]  ? rescuer_thread+0x380/0x380
[721257.856844]  kthread+0xc3/0xf0
[721257.856845]  ? kthread_complete_and_exit+0x20/0x20
[721257.856846]  ret_from_fork+0x2d/0x50
[721257.856847]  ? kthread_complete_and_exit+0x20/0x20
[721257.856847]  ret_from_fork_asm+0x11/0x20
[721257.856849]  </TASK>
[721257.856851] INFO: task kworker/u385:1:1130009 blocked for more
than 120 seconds.
[721257.857061]       Not tainted 6.8.7-custom #1
[721257.857209] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[721257.857471] task:kworker/u385:1  state:D stack:0     pid:1130009
tgid:1130009 ppid:2      flags:0x00004000
[721257.857473] Workqueue: btrfs-endio-write btrfs_work_helper
[721257.857475] Call Trace:
[721257.857476]  <TASK>
[721257.857477]  __schedule+0x36a/0x9a0
[721257.857478]  schedule+0x27/0xc0
[721257.857479]  schedule_preempt_disabled+0xa/0x10
[721257.857481]  rwsem_down_read_slowpath+0x1cb/0x430
[721257.857482]  down_read+0x3d/0x80
[721257.857484]  __btrfs_tree_read_lock+0x17/0x60
[721257.857484]  btrfs_read_lock_root_node+0x34/0x70
[721257.857485]  btrfs_search_slot+0x11c/0xc80
[721257.857488]  btrfs_lookup_file_extent+0x37/0x40
[721257.857489]  btrfs_drop_extents+0x10c/0xe00
[721257.857491]  insert_reserved_file_extent+0xd9/0x360
[721257.857493]  ? join_transaction+0x24/0x400
[721257.857494]  ? start_transaction+0xd0/0x7a0
[721257.857496]  btrfs_finish_one_ordered+0x5bd/0xa30
[721257.857498]  ? select_task_rq_fair+0x1b3/0x1200
[721257.857500]  btrfs_work_helper+0xda/0x310
[721257.857502]  process_one_work+0x13f/0x2c0
[721257.857503]  worker_thread+0x26d/0x390
[721257.857504]  ? rescuer_thread+0x380/0x380
[721257.857505]  kthread+0xc3/0xf0
[721257.857506]  ? kthread_complete_and_exit+0x20/0x20
[721257.857506]  ret_from_fork+0x2d/0x50
[721257.857507]  ? kthread_complete_and_exit+0x20/0x20
[721257.857508]  ret_from_fork_asm+0x11/0x20
[721257.857509]  </TASK>
[721257.857529] INFO: task kworker/u385:2:1139524 blocked for more
than 120 seconds.
[721257.857723]       Not tainted 6.8.7-custom #1
[721257.857869] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[721257.858134] task:kworker/u385:2  state:D stack:0     pid:1139524
tgid:1139524 ppid:2      flags:0x00004000
[721257.858135] Workqueue: btrfs-endio-write btrfs_work_helper
[721257.858137] Call Trace:
[721257.858138]  <TASK>
[721257.858138]  __schedule+0x36a/0x9a0
[721257.858139]  ? __alloc_pages_bulk+0x2c0/0x6a0
[721257.858144]  schedule+0x27/0xc0
[721257.858145]  schedule_preempt_disabled+0xa/0x10
[721257.858146]  rwsem_down_read_slowpath+0x1cb/0x430
[721257.858148]  down_read+0x3d/0x80
[721257.858149]  __btrfs_tree_read_lock+0x17/0x60
[721257.858150]  btrfs_read_lock_root_node+0x34/0x70
[721257.858152]  btrfs_search_slot+0x11c/0xc80
[721257.858154]  ? __cond_resched+0x16/0x40
[721257.858155]  ? btrfs_global_root+0x31/0x60
[721257.858158]  btrfs_lookup_extent_info+0xac/0x4a0
[721257.858159]  update_ref_for_cow+0x16a/0x380
[721257.858162]  btrfs_force_cow_block+0x22e/0x790
[721257.858164]  btrfs_cow_block+0xd2/0x260
[721257.858166]  btrfs_search_slot+0x566/0xc80
[721257.858169]  btrfs_lookup_file_extent+0x37/0x40
[721257.858170]  btrfs_drop_extents+0x10c/0xe00
[721257.858172]  insert_reserved_file_extent+0xd9/0x360
[721257.858173]  ? join_transaction+0x24/0x400
[721257.858175]  ? start_transaction+0xd0/0x7a0
[721257.858176]  btrfs_finish_one_ordered+0x5bd/0xa30
[721257.858178]  ? select_task_rq_fair+0x1b3/0x1200
[721257.858180]  btrfs_work_helper+0xda/0x310
[721257.858182]  process_one_work+0x13f/0x2c0
[721257.858184]  worker_thread+0x26d/0x390
[721257.858185]  ? rescuer_thread+0x380/0x380
[721257.858187]  kthread+0xc3/0xf0
[721257.858188]  ? kthread_complete_and_exit+0x20/0x20
[721257.858189]  ret_from_fork+0x2d/0x50
[721257.858190]  ? kthread_complete_and_exit+0x20/0x20
[721257.858191]  ret_from_fork_asm+0x11/0x20
[721257.858192]  </TASK>
[721257.858193] Future hung task reports are suppressed, see sysctl
kernel.hung_task_warnings

Anyone got insights why did that happen? Sorry if this is known
problem with 6.8.

Best regards,

Darius Ski.

