Return-Path: <linux-btrfs+bounces-18239-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 771A7C04590
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 06:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB60A3542A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 04:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE9323B62C;
	Fri, 24 Oct 2025 04:42:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744CA219A8A
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 04:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761280951; cv=none; b=ntZqCjaIyDpoxp8SlxIFTGYnTiSN3T2YLULCUTJJKwq1h44Mav+OoVKMlEJh8EVgE8wfJkd0TiqZiLicbdjdYSGefkYvCAUf/J5t6R7uqHkfsRpBUj9BuJ4LnaH4mXxlZOxPCvdLVT5KcIIVqnTswfWqU9dpYEd9jERWR24rxdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761280951; c=relaxed/simple;
	bh=iCOuRElp15S62djUQb+9uTEj6RNFmJdc4WHgf/oLT6M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mNYrl/pnbDEJHEFl6cy2aFsq48QS9devE4L3rAOO8Xl1o3/zdTVoiQTXBqFkH6sRS50VggIGv8owNfvpMOSfQ5EWkFmmoRr4ZRsAZHYOuCCP7Q/Aej00dUmiDpurw5VzDMLfF7Uk/Yw4zOytErZgpHOCXqDOBSmckeIhwwWm75A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-93e7b0584c9so148085239f.0
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 21:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761280948; x=1761885748;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cT3+LvEH9HlvS6EXOyNHTTNiTbILMr+bgFvzHSfXlKc=;
        b=ZhSIgvJSR03k4lREwuNu6rGeinaRRH7LetfQ7q6eCU58uJIVnS8/scmXmxsWDVOOIC
         cNEAYBIIxUjfzoSNRzF3bqYpK5uymKy5mE9MxgAT2qRMzSHf0qD+/0/PsnrB17wgDY6W
         J6yxLaNkD+N7NtFRQvUAcWbKWmuN6rTr6kYUjYXJqcsuakHt+JFqbd8Ru2mOej5PNPI2
         gsDATVuER0Nc1J9SkS4vhwut19TuCtWfv6NJNAxLgSA4O0w0mrBCsOUGS1cEAs5UlX5N
         ks5hJDfqn0GHCBzP19T9jMMII8AuYe0H7bCvXdyI8TtIgt9rXhNi2iKE8g+VKGUt6Vkq
         X4WA==
X-Forwarded-Encrypted: i=1; AJvYcCXoT7wap7JHDVG5T+3vIdRwlVMWxk91vGdUM4BvV1MMsAFni1Tvt6JOWHpE9c2ZAtoJ2iPl/+OX5s/iOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKxyZxenUgc4nLXswxI8J++q64DU6gChl2lB8H5oV8ovyMmtWh
	lr6LBKKYDAoBo1XfQJ8KX/2Ksdbp8GC/VxR3OM73irT9yLyE9dU0x7Uflk8HeGN140hjlwDK13I
	eIJ24rw6Z52lD9p6/PV9Fd14q9B/ypHNHJV22E/mLBig/Bn59XkmL1iU3rOI=
X-Google-Smtp-Source: AGHT+IGEeafr3dssudUgekWvfsYR/umHp9ZhU1K5HWOXLArVUjBYY+a7FYipJYAA1CxwjjyP/WuqjDn5mNTqTQDW5YtFAceq2ev5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26c:0:b0:431:d864:3658 with SMTP id
 e9e14a558f8ab-431d864382dmr79939185ab.20.1761280948603; Thu, 23 Oct 2025
 21:42:28 -0700 (PDT)
Date: Thu, 23 Oct 2025 21:42:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb03b4.050a0220.346f24.0091.GAE@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in btrfs_finish_one_ordered (2)
From: syzbot <syzbot+473ef2d15099286c23bb@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d9043c79ba68 Merge tag 'sched_urgent_for_v6.18_rc2' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c36b04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=473ef2d15099286c23bb
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4cfd59a0fd17/disk-d9043c79.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6a2cad21d523/vmlinux-d9043c79.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a466aca5efb9/bzImage-d9043c79.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+473ef2d15099286c23bb@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
kworker/u8:0/12 is trying to acquire lock:
ffff88803cfb8770 (sb_internal#3){.+.+}-{0:0}, at: btrfs_finish_one_ordered+0x7b0/0x21a0 fs/btrfs/inode.c:3143

but task is already holding lock:
ffff88805da8afc0 (btrfs_ordered_extent){++++}-{0:0}, at: btrfs_finish_one_ordered+0x30b/0x21a0 fs/btrfs/inode.c:3105

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (btrfs_ordered_extent){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       btrfs_start_ordered_extent_nowriteback+0x39c/0x6e0 fs/btrfs/ordered-data.c:896
       btrfs_start_ordered_extent fs/btrfs/ordered-data.h:199 [inline]
       btrfs_page_mkwrite+0x84d/0x1a80 fs/btrfs/file.c:1946
       do_page_mkwrite+0x150/0x310 mm/memory.c:3488
       wp_page_shared mm/memory.c:3889 [inline]
       do_wp_page+0x25c8/0x4930 mm/memory.c:4108
       handle_pte_fault mm/memory.c:6193 [inline]
       __handle_mm_fault mm/memory.c:6318 [inline]
       handle_mm_fault+0x97c/0x3400 mm/memory.c:6487
       do_user_addr_fault+0xa7c/0x1380 arch/x86/mm/fault.c:1336
       handle_page_fault arch/x86/mm/fault.c:1476 [inline]
       exc_page_fault+0x82/0x100 arch/x86/mm/fault.c:1532
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618

-> #6 (sb_pagefaults#2){.+.+}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs.h:1916 [inline]
       sb_start_pagefault include/linux/fs.h:2081 [inline]
       btrfs_page_mkwrite+0x32c/0x1a80 fs/btrfs/file.c:1874
       do_page_mkwrite+0x150/0x310 mm/memory.c:3488
       do_shared_fault mm/memory.c:5774 [inline]
       do_fault mm/memory.c:5836 [inline]
       do_pte_missing mm/memory.c:4361 [inline]
       handle_pte_fault mm/memory.c:6177 [inline]
       __handle_mm_fault mm/memory.c:6318 [inline]
       handle_mm_fault+0x124b/0x3400 mm/memory.c:6487
       do_user_addr_fault+0x764/0x1380 arch/x86/mm/fault.c:1387
       handle_page_fault arch/x86/mm/fault.c:1476 [inline]
       exc_page_fault+0x82/0x100 arch/x86/mm/fault.c:1532
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618

-> #5 (&mm->mmap_lock){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_read_killable+0x9d/0x220 kernel/locking/rwsem.c:1560
       mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:377
       get_mmap_lock_carefully mm/mmap_lock.c:377 [inline]
       lock_mm_and_find_vma+0x2a8/0x300 mm/mmap_lock.c:428
       do_user_addr_fault+0x331/0x1380 arch/x86/mm/fault.c:1359
       handle_page_fault arch/x86/mm/fault.c:1476 [inline]
       exc_page_fault+0x82/0x100 arch/x86/mm/fault.c:1532
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
       user_access_begin arch/x86/include/asm/uaccess.h:-1 [inline]
       filldir+0x29c/0x6c0 fs/readdir.c:290
       dir_emit include/linux/fs.h:3986 [inline]
       kernfs_fop_readdir+0x53a/0x870 fs/kernfs/dir.c:1910
       iterate_dir+0x3a5/0x580 fs/readdir.c:108
       __do_sys_getdents fs/readdir.c:326 [inline]
       __se_sys_getdents+0xe4/0x250 fs/readdir.c:312
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&root->kernfs_rwsem){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1590
       kernfs_add_one+0x41/0x520 fs/kernfs/dir.c:791
       kernfs_create_dir_ns+0xde/0x130 fs/kernfs/dir.c:1093
       sysfs_create_dir_ns+0x123/0x280 fs/sysfs/dir.c:59
       create_dir lib/kobject.c:73 [inline]
       kobject_add_internal+0x5a5/0xb50 lib/kobject.c:240
       kobject_add_varg lib/kobject.c:374 [inline]
       kobject_init_and_add+0x125/0x190 lib/kobject.c:457
       btrfs_sysfs_add_qgroups+0x111/0x2b0 fs/btrfs/sysfs.c:2645
       btrfs_quota_enable+0x25d/0x2920 fs/btrfs/qgroup.c:1022
       btrfs_ioctl_quota_ctl+0x186/0x1c0 fs/btrfs/ioctl.c:3667
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xff/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&fs_info->qgroup_ioctl_lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/rtmutex_api.c:535 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:547
       btrfs_quota_enable+0x29c/0x2920 fs/btrfs/qgroup.c:1051
       btrfs_ioctl_quota_ctl+0x186/0x1c0 fs/btrfs/ioctl.c:3667
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xff/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (btrfs_trans_num_extwriters){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       join_transaction+0x1a4/0xca0 fs/btrfs/transaction.c:321
       start_transaction+0x6b6/0x1620 fs/btrfs/transaction.c:705
       btrfs_quota_enable+0x28f/0x2920 fs/btrfs/qgroup.c:1049
       btrfs_ioctl_quota_ctl+0x186/0x1c0 fs/btrfs/ioctl.c:3667
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xff/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (btrfs_trans_num_writers){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       join_transaction+0x182/0xca0 fs/btrfs/transaction.c:320
       start_transaction+0x6b6/0x1620 fs/btrfs/transaction.c:705
       btrfs_quota_enable+0x28f/0x2920 fs/btrfs/qgroup.c:1049
       btrfs_ioctl_quota_ctl+0x186/0x1c0 fs/btrfs/ioctl.c:3667
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xff/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sb_internal#3){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs.h:1916 [inline]
       sb_start_intwrite include/linux/fs.h:2099 [inline]
       start_transaction+0x56e/0x1620 fs/btrfs/transaction.c:699
       btrfs_finish_one_ordered+0x7b0/0x21a0 fs/btrfs/inode.c:3143
       btrfs_work_helper+0x39b/0xc00 fs/btrfs/async-thread.c:312
       process_one_work kernel/workqueue.c:3263 [inline]
       process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
       worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
       kthread+0x711/0x8a0 kernel/kthread.c:463
       ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

Chain exists of:
  sb_internal#3 --> sb_pagefaults#2 --> btrfs_ordered_extent

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(btrfs_ordered_extent);
                               lock(sb_pagefaults#2);
                               lock(btrfs_ordered_extent);
  rlock(sb_internal#3);

 *** DEADLOCK ***

3 locks held by kworker/u8:0/12:
 #0: ffff88803dc68138 ((wq_completion)btrfs-endio-write){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3238 [inline]
 #0: ffff88803dc68138 ((wq_completion)btrfs-endio-write){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3346
 #1: ffffc90000117ba0 ((work_completion)(&work->normal_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3239 [inline]
 #1: ffffc90000117ba0 ((work_completion)(&work->normal_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3346
 #2: ffff88805da8afc0 (btrfs_ordered_extent){++++}-{0:0}, at: btrfs_finish_one_ordered+0x30b/0x21a0 fs/btrfs/inode.c:3105

stack backtrace:
CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: btrfs-endio-write btrfs_work_helper
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
 percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 __sb_start_write include/linux/fs.h:1916 [inline]
 sb_start_intwrite include/linux/fs.h:2099 [inline]
 start_transaction+0x56e/0x1620 fs/btrfs/transaction.c:699
 btrfs_finish_one_ordered+0x7b0/0x21a0 fs/btrfs/inode.c:3143
 btrfs_work_helper+0x39b/0xc00 fs/btrfs/async-thread.c:312
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered forwarding state
wlan0: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
wlan0: Creating new IBSS network, BSSID 50:50:50:50:50:50


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

