Return-Path: <linux-btrfs+bounces-14957-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 460C2AE86EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 16:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5AC16326E
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 14:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CEB1BBBE5;
	Wed, 25 Jun 2025 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVw/igJe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8B330748C;
	Wed, 25 Jun 2025 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750862759; cv=none; b=ZLZ0yuVqsvCE58rznPrhzK9qPimtlLwyr9dCgUBPrfuKAaTsNmuVJK0eDHZe2yvI2PMLX4QiKIHqFVyW445jC+TA0DkiHnx/1qKZe6ZXC5MQpz5HwbpAz4msLlnCuphOFdXncxPUqCU+A4lhuzx6eL5d2/rgnPuRLk77mXh6d9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750862759; c=relaxed/simple;
	bh=W80ljPaPqQctC4oI5kMx0wXtZhe8dcM9TJmvhSwq0wM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NMtd8BElrE2w4/CVAynLALqmOJYc89cIqYS0ynM7MtJurTNDJJj5G26UVKdQ9FipLosWMcbpPl9KrFQQ1EXrduvzRKI6v/2RNxLDPifL3XzU1RFx73eZ/a05tDC5N1yXatrMPQjHONSNK7tYCIil/83fRbz2+Fw5KYhcu0S1xWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVw/igJe; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e7dc89108bfso1449279276.3;
        Wed, 25 Jun 2025 07:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750862757; x=1751467557; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ddYWH9idNgu4DGvbxEp1Q2l88P/xM1NI5OwRZU4th6I=;
        b=lVw/igJebr4wbZqfO+iqPVl+exP/JQY10whnfJZ7ZTKf180r+fZ4D/aOVS6C9ldHWY
         say5u+ebqTGmW0gGXLhBvTM0M3GFAGg4/iDhPUjR21KyU7y690Tah4N2bZpPPbBdpX10
         vhXAAZLTkqeK7DlByCzybfFRcbcfMKUCyZkktc7atB0qzv7OQyb6kStlkAmGIiXGzMOI
         ofUiCMfdo2qP/NwTl8sKcp6lfGtpWctwnK8fhL668ILjgZ1HWfJpdYtVu+MTYeEYZe9V
         1LVuKV+ge3Q2zsD8kP7YyQ0zIRMiB4AT3kKGJzPSSVy9rPl0cxwNv0bI873drjwIwvfs
         76Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750862757; x=1751467557;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ddYWH9idNgu4DGvbxEp1Q2l88P/xM1NI5OwRZU4th6I=;
        b=KLc9y+X6OAsjDT2mGxJyKcyQmweSu67MMpJ5fEqwci42HavP6X9Cxk6iNgddiXTNIV
         yBvNzBIkOqgFybvdR3LsLrwjmEhJSMun5vJEt4/BuSQ1L5OBLuPdhlKMnqY4nID0m16C
         qQkFE2y7u9QG/5iLoR1B1AWn4zv4Yt5/RPpyiZm3Fv090JDkVM6PZHz0DVzeokD8lg46
         0WpjQNNlUJrof7q9974eFBkYDdEZCD9kMkXWG+3ixFragJ2SSA2WnfWvHSDjD63v14hK
         tnmiteT7oKgj9JIO9n7ttiT9Gw2n7wK2GhrQcQJFk6Ei3oHPC5J+vzf+jx3CkPxmRRle
         /dqw==
X-Forwarded-Encrypted: i=1; AJvYcCU0diADHDTvsdvEZD9q1qR9MzVQKIDDdolkyMSw5KxnySn+wVNQvtAvjNmoZ6Q34JWjJKaRpqu+dVjZjUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGSxOm/kvs9xYKrkJG2ZXEhnlC7wHVbrJZehphy9xNd6Cc6QHt
	NX/kme77Q4ojl1ytICZ1Tb++nDBgJha9a/iBFIhg01jpiI8ae6sXaAwj6PGY+zQbp+bzETMSRMl
	w6DFYg88/7fGupJ/Ltg4zSlpYuBHm4b0uk5Ny
X-Gm-Gg: ASbGncs7ReNpkVvxniukDyS9SZ7gu81FvcEqURE7IYtIenSY5ZnPIVgfIdZ/op7Y8kc
	7CxqeI87GokYBu51btvYcRUM5NrgrbdOTPqq8PRq9K5rFDjkrjfklzF8uOLUK/fhTzYFHSw27h6
	CPh96w6oIYRMsbe9r2G31pOO5ZvHiYmWeGLPFenvxjRS5NAQ==
X-Google-Smtp-Source: AGHT+IGIGvhe/WjPMJCjnaOfkzU8Xl6CU6S5cYSXO5YhEhflY0hO0AoctQ8e7SdfWBdS/h5nA46dPozQW4/QSQL2JsA=
X-Received: by 2002:a05:6902:72e:b0:e81:b731:3c89 with SMTP id
 3f1490d57ef6-e879b8a3df4mr296876276.11.1750862756590; Wed, 25 Jun 2025
 07:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cen zhang <zzzccc427@gmail.com>
Date: Wed, 25 Jun 2025 22:45:44 +0800
X-Gm-Features: Ac12FXzDf7ZEr7vD9Gj0rpT6vkxmEtwdkJgg-foWNAAbzDnbDfJaYOB1jzdsWFI
Message-ID: <CAFRLqsXQMknPBgYkds=ARWFC0vj1xAP77USG+ZG5GH3rbqB5xQ@mail.gmail.com>
Subject: [BUG] btrfs: KASAN: slab-use-after-free in qgroup_rescan_zero_tracking
To: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, zhenghaoran154@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello Btrfs maintainers,

I would like to report a kernel panic in the Btrfs qgroup subsystem,
found using syzkaller.

It appears to be a slab-use-after-free caused by a race condition.
Based on the KASAN report, the race occurs between a thread disabling
quotas (which frees qgroup-related memory) and a background rescan
worker (qgroup_rescan_zero_tracking) which subsequently attempts to
use that freed memory.

Here are the details:

==================================================================
BUG: KASAN: slab-use-after-free in __list_add include/linux/list.h:153 [inline]
BUG: KASAN: slab-use-after-free in list_add include/linux/list.h:169 [inline]
BUG: KASAN: slab-use-after-free in qgroup_dirty fs/btrfs/qgroup.c:1434 [inline]
BUG: KASAN: slab-use-after-free in
qgroup_rescan_zero_tracking+0x280/0x5f0 fs/btrfs/qgroup.c:4005
Write of size 8 at addr ffff88813e2c2490 by task syz-executor.2/12500

CPU: 3 UID: 0 PID: 12500 Comm: syz-executor.2 Not tainted
6.16.0-rc1-g7f6432600434-dirty #51 PREEMPT(voluntary)
Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS
1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x108/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0x191/0x5b0 mm/kasan/report.c:521
 kasan_report+0x139/0x170 mm/kasan/report.c:634
 __list_add include/linux/list.h:153 [inline]
 list_add include/linux/list.h:169 [inline]
 qgroup_dirty fs/btrfs/qgroup.c:1434 [inline]
 qgroup_rescan_zero_tracking+0x280/0x5f0 fs/btrfs/qgroup.c:4005
 btrfs_quota_enable+0x3062/0x5d10 fs/btrfs/qgroup.c:1248
 btrfs_ioctl_quota_ctl+0x36c/0x4e0 fs/btrfs/ioctl.c:3673
 btrfs_ioctl+0xb3f/0x1480 fs/btrfs/ioctl.c:5323
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xd1/0x130 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcf/0x240 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f77e26da35d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f77e1a4e0a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f77e282c050 RCX: 00007f77e26da35d
RDX: 0000000020006900 RSI: 00000000c0109428 RDI: 0000000000000003
RBP: 00007f77e274b4b1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: ffffffffffffffb8 R14: 00007f77e282c050 R15: 00007ffd0f15f770
 </TASK>

Allocated by task 12375:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x82/0x90 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 btrfs_quota_enable+0x2d07/0x5d10 fs/btrfs/qgroup.c:1201
 btrfs_ioctl_quota_ctl+0x36c/0x4e0 fs/btrfs/ioctl.c:3673
 btrfs_ioctl+0xb3f/0x1480 fs/btrfs/ioctl.c:5323
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xd1/0x130 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcf/0x240 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 12446:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x36/0x50 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2388 [inline]
 slab_free mm/slub.c:4670 [inline]
 kfree+0xfd/0x340 mm/slub.c:4869
 btrfs_free_qgroup_config+0xcd/0x2b0 fs/btrfs/qgroup.c:647
BTRFS info (device sdb): balance: paused
 btrfs_quota_disable+0x826/0x25e0 fs/btrfs/qgroup.c:1393
 btrfs_ioctl_quota_ctl+0x3b3/0x4e0 fs/btrfs/ioctl.c:3703
 btrfs_ioctl+0xb3f/0x1480 fs/btrfs/ioctl.c:5323
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xd1/0x130 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcf/0x240 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88813e2c2400
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 144 bytes inside of
 freed 512-byte region [ffff88813e2c2400, ffff88813e2c2600)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000
index:0xffff88813e2c2800 pfn:0x13e2c0
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x200000000000040(head|node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000040 ffff888100042c80 ffffea0004ce0100 0000000000000003
raw: ffff88813e2c2800 000000000010000f 00000000f5000000 0000000000000000
head: 0200000000000040 ffff888100042c80 ffffea0004ce0100 0000000000000003
head: ffff88813e2c2800 000000000010000f 00000000f5000000 0000000000000000
head: 0200000000000002 ffffea0004f8b001 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88813e2c2380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88813e2c2400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88813e2c2480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88813e2c2500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88813e2c2580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
Oops: general protection fault, probably for non-canonical address
0xff7aaf8000000004: 0000 [#1] SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0xfbd59c0000000020-0xfbd59c0000000027]
CPU: 0 UID: 0 PID: 56 Comm: kworker/u16:3 Tainted: G    B
 6.16.0-rc1-g7f6432600434-dirty #51 PREEMPT(voluntary)
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS
1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: btrfs-qgroup-rescan btrfs_work_helper
RIP: 0010:__list_del include/linux/list.h:195 [inline]
RIP: 0010:__list_del_entry include/linux/list.h:218 [inline]
RIP: 0010:list_del_init include/linux/list.h:287 [inline]
RIP: 0010:btrfs_run_qgroups+0x4a8/0x1ec0 fs/btrfs/qgroup.c:3132
Code: 89 df e8 0b 30 23 ff 4c 8b 3b 4d 8d 67 08 4c 89 e3 48 c1 eb 03
48 b9 00 00 00 00 00 fc ff df 4c 8d 34 0b 4c 89 f0 48 c1 e8 03 <0f> b6
04 08 84 c0 0f 85 0c 0f 00 00 41 80 3e 00 74 22 e8 91 82 f1
RSP: 0018:ffff888119bcf388 EFLAGS: 00010212
RAX: 1f7ab38000000004 RBX: 1bd5a00000000021 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88813e2c2488
RBP: 1ffff11027c58491 R08: ffff888119bcf347 R09: 1ffff11023379e68
R10: dffffc0000000000 R11: ffffed1023379e69 R12: dead000000000108
R13: ffff88813c4409c0 R14: fbd59c0000000021 R15: dead000000000100
FS:  0000000000000000(0000) GS:ffff8883fbf1b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb4485380c0 CR3: 0000000166ff6000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 commit_cowonly_roots+0x67c/0x1c10 fs/btrfs/transaction.c:1354
 btrfs_commit_transaction+0x2a5b/0xc800 fs/btrfs/transaction.c:2457
 btrfs_qgroup_rescan_worker+0xa23/0x4220 fs/btrfs/qgroup.c:3852
 btrfs_work_helper+0x7ea/0x2a80 fs/btrfs/async-thread.c:312
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0x720/0xf10 kernel/workqueue.c:3321
 worker_thread+0xb66/0x11a0 kernel/workqueue.c:3402
 kthread+0x351/0x780 kernel/kthread.c:464
 ret_from_fork+0x10e/0x1c0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del include/linux/list.h:195 [inline]
RIP: 0010:__list_del_entry include/linux/list.h:218 [inline]
RIP: 0010:list_del_init include/linux/list.h:287 [inline]
RIP: 0010:btrfs_run_qgroups+0x4a8/0x1ec0 fs/btrfs/qgroup.c:3132
Code: 89 df e8 0b 30 23 ff 4c 8b 3b 4d 8d 67 08 4c 89 e3 48 c1 eb 03
48 b9 00 00 00 00 00 fc ff df 4c 8d 34 0b 4c 89 f0 48 c1 e8 03 <0f> b6
04 08 84 c0 0f 85 0c 0f 00 00 41 80 3e 00 74 22 e8 91 82 f1
RSP: 0018:ffff888119bcf388 EFLAGS: 00010212
RAX: 1f7ab38000000004 RBX: 1bd5a00000000021 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88813e2c2488
RBP: 1ffff11027c58491 R08: ffff888119bcf347 R09: 1ffff11023379e68
R10: dffffc0000000000 R11: ffffed1023379e69 R12: dead000000000108
R13: ffff88813c4409c0 R14: fbd59c0000000021 R15: dead000000000100
FS:  0000000000000000(0000) GS:ffff8883fbf1b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb4485380c0 CR3: 0000000166ff6000 CR4: 00000000000006f0
note: kworker/u16:3[56] exited with preempt_count 1
kworker/u16:3 (56) used greatest stack depth: 20080 bytes left
BTRFS warning (device sdb): get dev_stats failed, device not found
----------------
Code disassembly (best guess):
   0: 89 df                mov    %ebx,%edi
   2: e8 0b 30 23 ff        call   0xff233012
   7: 4c 8b 3b              mov    (%rbx),%r15
   a: 4d 8d 67 08          lea    0x8(%r15),%r12
   e: 4c 89 e3              mov    %r12,%rbx
  11: 48 c1 eb 03          shr    $0x3,%rbx
  15: 48 b9 00 00 00 00 00 movabs $0xdffffc0000000000,%rcx
  1c: fc ff df
  1f: 4c 8d 34 0b          lea    (%rbx,%rcx,1),%r14
  23: 4c 89 f0              mov    %r14,%rax
  26: 48 c1 e8 03          shr    $0x3,%rax
* 2a: 0f b6 04 08          movzbl (%rax,%rcx,1),%eax <-- trapping instruction
  2e: 84 c0                test   %al,%al
  30: 0f 85 0c 0f 00 00    jne    0xf42
  36: 41 80 3e 00          cmpb   $0x0,(%r14)
  3a: 74 22                je     0x5e
  3c: e8                    .byte 0xe8
  3d: 91                    xchg   %eax,%ecx
  3e: 82                    (bad)
  3f: f1                    int1
==================================================================

Here is the machineinfo:
--------------------------------------------------------------------------------
QEMU emulator version 8.2.2 (Debian 1:8.2.2+ds-0ubuntu1.4)
qemu-system-x86_64 ["-m" "16384" "-smp" "4" "-chardev"
"socket,id=SOCKSYZ,server=on,wait=off,host=localhost,port=24018"
"-mon" "chardev=SOCKSYZ,mode=control" "-display" "none" "-serial"
"stdio" "-no-reboot" "-name" "VM-1" "-device" "virtio-rng-pci"
"-enable-kvm" "-hdb"
"/home/zzzccc/go-work/syzkaller-old/syzkaller/test/btrfs/disk.qcow2"
"-device" "e1000,netdev=net0" "-netdev"
"user,id=net0,restrict=on,hostfwd=tcp:127.0.0.1:55563-:22,hostfwd=tcp::6680-:6060"
"-hda" "/home/zzzccc/go-work/syzkaller-old/syzkaller/test/btrfs/bookworm.img"
"-snapshot" "-kernel" "/home/zzzccc/linux-DDRD/arch/x86/boot/bzImage"
"-append" "root=/dev/sda console=ttyS0 "]

[CPU Info]
processor           : 0, 1, 2, 3
vendor_id           : AuthenticAMD
cpu family          : 15
model               : 107
model name          : QEMU Virtual CPU version 2.5+
stepping            : 1
microcode           : 0x1000065
cpu MHz             : 3593.248
cache size          : 512 KB
physical id         : 0
siblings            : 4
core id             : 0, 1, 2, 3
cpu cores           : 4
apicid              : 0, 1, 2, 3
initial apicid      : 0, 1, 2, 3
fpu                 : yes
fpu_exception       : yes
cpuid level         : 13
wp                  : yes
flags               : fpu de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx lm rep_good
nopl cpuid extd_apicid tsc_known_freq pni cx16 x2apic hypervisor
lahf_lm cmp_legacy svm 3dnowprefetch vmmcall
bugs                : fxsave_leak sysret_ss_attrs null_seg
swapgs_fence amd_e400 spectre_v1 spectre_v2 spectre_v2_user
bogomips            : 7186.49
TLB size            : 1024 4K pages
clflush size        : 64
cache_alignment     : 64
address sizes       : 40 bits physical, 48 bits virtual
power management    :

--------------------------------------------------------------------------------

Here is the log of this
bug:https://github.com/zzzcccyyyggg/Syzkaller-log/blob/main/19a8b3667b7262d7802158f7df18cdd003dbd029/log0

Thank you for your attention to this matter.

Best regards,
Cen Zhang

