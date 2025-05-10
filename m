Return-Path: <linux-btrfs+bounces-13861-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3DCAB253F
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 May 2025 22:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB694A20D2
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 May 2025 20:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E85B21FF3C;
	Sat, 10 May 2025 20:51:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476861D63CD
	for <linux-btrfs@vger.kernel.org>; Sat, 10 May 2025 20:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746910287; cv=none; b=duIplVxr+I7tNrl46iW07Ar6PTACbvgnbG8zUwARzfFuW4CkJPekQ42Dgo3AfH8uM3MajwjOBf7ebvJtkYU1jdqyViosovo3hy+RqlT93UrToeNxDExpmSO+BzX0bXVgmxuUrcbwzbYGDyqqxY0+M2zbu15eMLs28FhFPtJCB9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746910287; c=relaxed/simple;
	bh=etnFAJdPilO2UOpUe7FCkPR5SHaz8o0TsYgF3Cie18I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qP/1Tcfy9xie7hDQWk99ziq/pe0yOP/2WvnOBsPippa1VVIl10arOMzyF7ha5cfj5fHV7/H05FjEC3SUhRRM0kDcBomrlw3bmnMHo1kER45ddn/zfe7Bn6NXjBTypNTMBsUhjRR1m1/xUKK6f5nbfByjCizY7xXRTQADBMBmhX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3da707dea42so74092765ab.3
        for <linux-btrfs@vger.kernel.org>; Sat, 10 May 2025 13:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746910284; x=1747515084;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JCP1zXbTNQN7L59TRIQEtVqguw7ZBOFO0HhGtbpBOzw=;
        b=b3lodF2dLQ4qwhk23SgWQFOk3OJdZFATVsHpK0LWxUPx8D8dheHErX3sU5HIWUYQ2U
         sBiQ6FUv7LX9IVbKewz5Msm/QyQP4XPQCmsybk2XTplsqeGKoPIFa04ETUto4XTBEyic
         5irsBbGt/YhG3t5IC3aVzOcG4rO96+mmk52B1IeBpFqEHuV9F3IMMBQcV5ngIf9hZ1nB
         hksX8/rbCfI8SUazU5WRkNWZIvbr3Eqd2VlucJUqQzx2fkcp8WzBD21/7wBxYxtNNvzB
         ByX5y6w7WOAmMBoDlufPdVTW/oR2AR/LjOXVfVoxOM1GVukpgTR5dK+pBQzTm8S2LGwK
         i/NA==
X-Forwarded-Encrypted: i=1; AJvYcCWup6agULi0s+Hpn/D5UfLcWp6dhHnYI0NKXlQL3tYLgPp0rq5Bx2rtkujzYz6iQ5INlvZDp9vrhhNTZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRDPXWNXywH4Y9iG3f5iM/piKhGAGp/ZiogwYRUIQzWzxI/AIS
	BHkyId3G83rsscrSCC6KjzqJCxdecJPPRTqhVPUzPRcXEYRm3eb3aY+4IbqIJQO2OYRvB92RGCE
	5QVrI8KmTQwm70ZDS09GZPxU5hQveJu0OdqTU13gjtGkgf+RrpZjUZ9c=
X-Google-Smtp-Source: AGHT+IG0NQArmQFp6m7Z2wGTou5HokZ+/1qujG2VVm1FqmvhnuWlT918AU5UbARAvQgkIquCozJayYAnimMyUQP4si7fG2Zf9e+b
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4516:10b0:3d9:6dfe:5137 with SMTP id
 e9e14a558f8ab-3da7e1e3ac3mr62066475ab.10.1746910284337; Sat, 10 May 2025
 13:51:24 -0700 (PDT)
Date: Sat, 10 May 2025 13:51:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681fbc4c.050a0220.f2294.0018.GAE@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in btrfs_quota_enable (2)
From: syzbot <syzbot+3a88c590edd72179657c@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0d8d44db295c Merge tag 'for-6.15-rc5-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135ed39b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9683d529ec1b880
dashboard link: https://syzkaller.appspot.com/bug?extid=3a88c590edd72179657c
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3248bbf33c7c/disk-0d8d44db.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7a1ed3b1be50/vmlinux-0d8d44db.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e6ac2567359a/bzImage-0d8d44db.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3a88c590edd72179657c@syzkaller.appspotmail.com

BTRFS info (device loop4): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
======================================================
WARNING: possible circular locking dependency detected
6.15.0-rc5-syzkaller-00032-g0d8d44db295c #0 Not tainted
------------------------------------------------------
syz.4.219/7436 is trying to acquire lock:
ffff88806ce71918 (&fs_info->qgroup_ioctl_lock){+.+.}-{4:4}, at: btrfs_quota_enable+0x2be/0x1d50 fs/btrfs/qgroup.c:1059

but task is already holding lock:
ffff88806ce724f8 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x164/0xd70 fs/btrfs/transaction.c:320

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (btrfs_trans_num_extwriters){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
       join_transaction+0x1a4/0xd70 fs/btrfs/transaction.c:321
       start_transaction+0x6ae/0x1620 fs/btrfs/transaction.c:705
       btrfs_dirty_inode+0x9f/0x190 fs/btrfs/inode.c:6129
       inode_update_time fs/inode.c:2076 [inline]
       touch_atime+0x2f6/0x6d0 fs/inode.c:2149
       file_accessed include/linux/fs.h:2599 [inline]
       filemap_read+0x1024/0x11d0 mm/filemap.c:2774
       __kernel_read+0x469/0x8c0 fs/read_write.c:528
       integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
       ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
       ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
       ima_calc_file_hash+0x152c/0x18d0 security/integrity/ima/ima_crypto.c:568
       ima_collect_measurement+0x42e/0x8e0 security/integrity/ima/ima_api.c:293
       process_measurement+0x1121/0x1a40 security/integrity/ima/ima_main.c:385
       ima_file_check+0xd7/0x120 security/integrity/ima/ima_main.c:613
       security_file_post_open+0xbb/0x290 security/security.c:3130
       do_open fs/namei.c:3882 [inline]
       path_openat+0x2f26/0x3830 fs/namei.c:4039
       do_filp_open+0x1fa/0x410 fs/namei.c:4066
       do_sys_openat2+0x121/0x1c0 fs/open.c:1429
       do_sys_open fs/open.c:1444 [inline]
       __do_sys_openat fs/open.c:1460 [inline]
       __se_sys_openat fs/open.c:1455 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1455
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (btrfs_trans_num_writers){++++}-{0:0}:
       reacquire_held_locks+0x127/0x1d0 kernel/locking/lockdep.c:5383
       __lock_release kernel/locking/lockdep.c:5572 [inline]
       lock_release+0x1b4/0x3e0 kernel/locking/lockdep.c:5887
       percpu_up_read include/linux/percpu-rwsem.h:100 [inline]
       __sb_end_write include/linux/fs.h:1778 [inline]
       sb_end_intwrite+0x26/0x1c0 include/linux/fs.h:1895
       __btrfs_end_transaction+0x248/0x640 fs/btrfs/transaction.c:1075
       btrfs_dirty_inode+0x14c/0x190 fs/btrfs/inode.c:6143
       inode_update_time fs/inode.c:2076 [inline]
       __file_update_time fs/inode.c:2305 [inline]
       file_update_time+0x344/0x490 fs/inode.c:2335
       btrfs_page_mkwrite+0x634/0x16a0 fs/btrfs/file.c:1814
       do_page_mkwrite+0x14a/0x310 mm/memory.c:3287
       wp_page_shared mm/memory.c:3688 [inline]
       do_wp_page+0x2626/0x5760 mm/memory.c:3907
       handle_pte_fault mm/memory.c:6013 [inline]
       __handle_mm_fault+0x1028/0x5380 mm/memory.c:6140
       handle_mm_fault+0x2d5/0x7f0 mm/memory.c:6309
       do_user_addr_fault+0xa81/0x1390 arch/x86/mm/fault.c:1337
       handle_page_fault arch/x86/mm/fault.c:1480 [inline]
       exc_page_fault+0x68/0x110 arch/x86/mm/fault.c:1538
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #3 (sb_pagefaults#2){.+.+}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
       percpu_down_read include/linux/percpu-rwsem.h:52 [inline]
       __sb_start_write include/linux/fs.h:1783 [inline]
       sb_start_pagefault include/linux/fs.h:1948 [inline]
       btrfs_page_mkwrite+0x3b2/0x16a0 fs/btrfs/file.c:1798
       do_page_mkwrite+0x14a/0x310 mm/memory.c:3287
       do_shared_fault mm/memory.c:5594 [inline]
       do_fault mm/memory.c:5656 [inline]
       do_pte_missing mm/memory.c:4160 [inline]
       handle_pte_fault mm/memory.c:5997 [inline]
       __handle_mm_fault+0x18d2/0x5380 mm/memory.c:6140
       handle_mm_fault+0x2d5/0x7f0 mm/memory.c:6309
       do_user_addr_fault+0x764/0x1390 arch/x86/mm/fault.c:1388
       handle_page_fault arch/x86/mm/fault.c:1480 [inline]
       exc_page_fault+0x68/0x110 arch/x86/mm/fault.c:1538
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #2 (&mm->mmap_lock){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
       down_read_killable+0x50/0x350 kernel/locking/rwsem.c:1547
       mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:193
       get_mmap_lock_carefully mm/memory.c:6355 [inline]
       lock_mm_and_find_vma+0x2a8/0x300 mm/memory.c:6406
       do_user_addr_fault+0x331/0x1390 arch/x86/mm/fault.c:1360
       handle_page_fault arch/x86/mm/fault.c:1480 [inline]
       exc_page_fault+0x68/0x110 arch/x86/mm/fault.c:1538
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       filldir64+0x2b3/0x690 fs/readdir.c:371
       dir_emit include/linux/fs.h:3861 [inline]
       kernfs_fop_readdir+0x534/0x870 fs/kernfs/dir.c:1907
       iterate_dir+0x5ac/0x770 fs/readdir.c:108
       __do_sys_getdents64 fs/readdir.c:403 [inline]
       __se_sys_getdents64+0xe4/0x260 fs/readdir.c:389
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&root->kernfs_rwsem){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1577
       kernfs_add_one+0x41/0x520 fs/kernfs/dir.c:791
       kernfs_create_dir_ns+0xde/0x130 fs/kernfs/dir.c:1091
       sysfs_create_dir_ns+0x123/0x280 fs/sysfs/dir.c:59
       create_dir lib/kobject.c:73 [inline]
       kobject_add_internal+0x59f/0xb40 lib/kobject.c:240
       kobject_add_varg lib/kobject.c:374 [inline]
       kobject_init_and_add+0x125/0x190 lib/kobject.c:457
       btrfs_sysfs_add_qgroups+0x111/0x2b0 fs/btrfs/sysfs.c:2616
       btrfs_quota_enable+0x278/0x1d50 fs/btrfs/qgroup.c:1030
       btrfs_ioctl_quota_ctl+0x183/0x1c0 fs/btrfs/ioctl.c:3676
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&fs_info->qgroup_ioctl_lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3166 [inline]
       check_prevs_add kernel/locking/lockdep.c:3285 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3909
       __lock_acquire+0xaac/0xd20 kernel/locking/lockdep.c:5235
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:746
       btrfs_quota_enable+0x2be/0x1d50 fs/btrfs/qgroup.c:1059
       btrfs_ioctl_quota_ctl+0x183/0x1c0 fs/btrfs/ioctl.c:3676
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &fs_info->qgroup_ioctl_lock --> btrfs_trans_num_writers --> btrfs_trans_num_extwriters

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(btrfs_trans_num_extwriters);
                               lock(btrfs_trans_num_writers);
                               lock(btrfs_trans_num_extwriters);
  lock(&fs_info->qgroup_ioctl_lock);

 *** DEADLOCK ***

5 locks held by syz.4.219/7436:
 #0: ffff8880259ac420 (sb_writers#17){.+.+}-{0:0}, at: mnt_want_write_file+0x60/0x200 fs/namespace.c:600
 #1: ffff88806ce70bd0 (&fs_info->subvol_sem){+.+.}-{4:4}, at: btrfs_ioctl_quota_ctl+0x178/0x1c0 fs/btrfs/ioctl.c:3675
 #2: ffff8880259ac610 (sb_internal#3){.+.+}-{0:0}, at: btrfs_quota_enable+0x2b1/0x1d50 fs/btrfs/qgroup.c:1057
 #3: ffff88806ce724d0 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0x164/0xd70 fs/btrfs/transaction.c:320
 #4: ffff88806ce724f8 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x164/0xd70 fs/btrfs/transaction.c:320

stack backtrace:
CPU: 1 UID: 0 PID: 7436 Comm: syz.4.219 Not tainted 6.15.0-rc5-syzkaller-00032-g0d8d44db295c #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2079
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2211
 check_prev_add kernel/locking/lockdep.c:3166 [inline]
 check_prevs_add kernel/locking/lockdep.c:3285 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3909
 __lock_acquire+0xaac/0xd20 kernel/locking/lockdep.c:5235
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
 __mutex_lock_common kernel/locking/mutex.c:601 [inline]
 __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:746
 btrfs_quota_enable+0x2be/0x1d50 fs/btrfs/qgroup.c:1059
 btrfs_ioctl_quota_ctl+0x183/0x1c0 fs/btrfs/ioctl.c:3676
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7c0cf8e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7c0adf6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f7c0d1b5fa0 RCX: 00007f7c0cf8e969
RDX: 0000200000000580 RSI: 00000000c0109428 RDI: 0000000000000003
RBP: 00007f7c0d010ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f7c0d1b5fa0 R15: 00007ffe0a7382c8
 </TASK>


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

