Return-Path: <linux-btrfs+bounces-5404-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B49A78D782A
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jun 2024 22:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1BC281539
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jun 2024 20:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C502878269;
	Sun,  2 Jun 2024 20:43:21 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9657770F1
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Jun 2024 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717361001; cv=none; b=uaOHRrPgILYtL6mge84KnUkEL8rX6VZeRr9/2Xhf2oMVmM54/0nXJpaHMfKLetBa++mnMaJEBMsHDzMV3TVpObb1Rf92HhLF2liJ7LGt3NUUoMIS2+QblvpuRf9eaj2WWXTtX4MvCCHKnZ+0UB5eKFoFfV9L58P2R5+1SEotQm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717361001; c=relaxed/simple;
	bh=HQSxyWNxrpNbkdyWIHk/KCV/xyzvVytfQzX67SGoMvE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ej9zSYoAQEhcVNzhwBZT/jdiqt1OuTXKa7Mba6kSppkv+3HJfAc9CZIv8S5EVl5Qcn1lMRXm1mLoOj1XgfAdQhX1U+P3roA9SB/IOTd43IEGYripnlSGJX7psoKGmTnNMn9XsV+sJ8qWqnkplPqybNT2rP2U/thLiingIaxNT0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-37497a1aff0so9318245ab.1
        for <linux-btrfs@vger.kernel.org>; Sun, 02 Jun 2024 13:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717360999; x=1717965799;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mwY95BmSLa5iz9snCb7YRIMhZxZKOamjLjvZ8PEqLco=;
        b=KG8U30u+nx5L/4aGeaUY2HHV93C8TP7GcVrXNJ3ypQcbgT7kEjQFLq0SkkeL6YwndE
         DGlnWZzbpUcldzWdha8xvxFswOAMkPuB/EhgZKq1MQlD/IDZ8RCXGDFvOVQvfoR6Du2b
         OZHFaq9QfZTHgSFT872EUrSCYtLZ5l8IixN8SST+vxcS8zJCXv1ObUBuSzvsaWxchhfS
         N0NQIk4oFpCJMuc39DLdpeQFoyIK+i6SFlTEvXdSFKovxjQ5vWfUFIBQlaSQ5g1VBryq
         tNWX8YAank+UwFI9csjq3xuSHYBlaI/3uci2wE1fUNNaGavZIDvzHWnFbeOEdYLUVEb5
         QLlA==
X-Forwarded-Encrypted: i=1; AJvYcCULkb+jT+BdNdtAWxozXaqwZYvbay/Of7/JbHQsCD2nV9pmc9TFzfX2RIylqAQCRXWuOb4HBBwambeBUZ5lKVqjF/f4OYJvGDYNti8=
X-Gm-Message-State: AOJu0YxdscilVgY4/HvkUsKG4UF7aUxrMp4ZXFIohZC3mjJQB7+GThoT
	XBiw/HKe4GCWIFryfJjcAUdY1E5+EeCaj11Q9PCEvI1MDeckyL0pH4Xc9Pg8tuyJN+wossbNh5w
	2k7nwzm6Np1NHj2u6WJE+VeAYD+h0WKv1mNNemt/yX8gv3pNeeDEb5XQ=
X-Google-Smtp-Source: AGHT+IHPbj/FjRGVkD2dwN+hY8BCYZDpg+XYlS8hduH4LVKwHmrNs0VW6YHwimKTDUsqIy1sUFI87bRXcMTdc3WBnzkPP1BElDhF
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:10d1:b0:374:92d0:caa3 with SMTP id
 e9e14a558f8ab-37492d0cc8cmr1751805ab.4.1717360998911; Sun, 02 Jun 2024
 13:43:18 -0700 (PDT)
Date: Sun, 02 Jun 2024 13:43:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a9d530619ee4494@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in btrfs_quota_enable
From: syzbot <syzbot+bec38eba8bd1096de8d2@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1252deaa980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=733cc7a95171d8e7
dashboard link: https://syzkaller.appspot.com/bug?extid=bec38eba8bd1096de8d2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-4a4be1ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a9bbdc63efe9/vmlinux-4a4be1ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ed08b308e5d6/bzImage-4a4be1ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bec38eba8bd1096de8d2@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0 Not tainted
------------------------------------------------------
syz-executor.0/10258 is trying to acquire lock:
ffff888055fa1870 (&fs_info->qgroup_ioctl_lock){+.+.}-{3:3}, at: btrfs_quota_enable+0x3a1/0x1ef0 fs/btrfs/qgroup.c:1086

but task is already holding lock:
ffff888055fa2418 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x137/0xf40 fs/btrfs/transaction.c:314

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (btrfs_trans_num_extwriters){++++}-{0:0}:
       join_transaction+0x164/0xf40 fs/btrfs/transaction.c:315
       start_transaction+0x427/0x1a70 fs/btrfs/transaction.c:700
       btrfs_commit_super+0xa1/0x110 fs/btrfs/disk-io.c:4170
       close_ctree+0xcb0/0xf90 fs/btrfs/disk-io.c:4324
       generic_shutdown_super+0x159/0x3d0 fs/super.c:642
       kill_anon_super+0x3a/0x60 fs/super.c:1226
       btrfs_kill_super+0x3b/0x50 fs/btrfs/super.c:2096
       deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
       deactivate_super+0xde/0x100 fs/super.c:506
       cleanup_mnt+0x222/0x450 fs/namespace.c:1267
       task_work_run+0x14e/0x250 kernel/task_work.c:180
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
       __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #2 (btrfs_trans_num_writers){++++}-{0:0}:
       __lock_release kernel/locking/lockdep.c:5468 [inline]
       lock_release+0x33e/0x6c0 kernel/locking/lockdep.c:5774
       percpu_up_read include/linux/percpu-rwsem.h:99 [inline]
       __sb_end_write include/linux/fs.h:1650 [inline]
       sb_end_intwrite include/linux/fs.h:1767 [inline]
       __btrfs_end_transaction+0x5ca/0x920 fs/btrfs/transaction.c:1071
       btrfs_commit_inode_delayed_inode+0x228/0x330 fs/btrfs/delayed-inode.c:1301
       btrfs_evict_inode+0x960/0xe80 fs/btrfs/inode.c:5291
       evict+0x2ed/0x6c0 fs/inode.c:667
       iput_final fs/inode.c:1741 [inline]
       iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
       iput+0x5c/0x80 fs/inode.c:1757
       dentry_unlink_inode+0x295/0x480 fs/dcache.c:400
       __dentry_kill+0x1d0/0x600 fs/dcache.c:603
       dput.part.0+0x4b1/0x9b0 fs/dcache.c:845
       dput+0x1f/0x30 fs/dcache.c:835
       ovl_destroy_inode+0x3e/0x190 fs/overlayfs/super.c:181
       destroy_inode+0xc4/0x1b0 fs/inode.c:311
       iput_final fs/inode.c:1741 [inline]
       iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
       iput+0x5c/0x80 fs/inode.c:1757
       dentry_unlink_inode+0x295/0x480 fs/dcache.c:400
       __dentry_kill+0x1d0/0x600 fs/dcache.c:603
       shrink_kill fs/dcache.c:1048 [inline]
       shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
       super_cache_scan+0x32a/0x550 fs/super.c:221
       do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
       shrink_slab_memcg mm/shrinker.c:548 [inline]
       shrink_slab+0xa87/0x1310 mm/shrinker.c:626
       shrink_one+0x493/0x7c0 mm/vmscan.c:4790
       shrink_many mm/vmscan.c:4851 [inline]
       lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4951
       shrink_node mm/vmscan.c:5910 [inline]
       kswapd_shrink_node mm/vmscan.c:6720 [inline]
       balance_pgdat+0x1105/0x1970 mm/vmscan.c:6911
       kswapd+0x5ea/0xbf0 mm/vmscan.c:7180
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:3783 [inline]
       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3797
       might_alloc include/linux/sched/mm.h:334 [inline]
       slab_pre_alloc_hook mm/slub.c:3890 [inline]
       slab_alloc_node mm/slub.c:3980 [inline]
       kmalloc_trace_noprof+0x51/0x310 mm/slub.c:4147
       kmalloc_noprof include/linux/slab.h:660 [inline]
       ulist_alloc+0x77/0x1c0 fs/btrfs/ulist.c:98
       btrfs_quota_enable+0x342/0x1ef0 fs/btrfs/qgroup.c:1051
       btrfs_ioctl_quota_ctl fs/btrfs/ioctl.c:3765 [inline]
       btrfs_ioctl+0x6af4/0x8290 fs/btrfs/ioctl.c:4762
       __do_compat_sys_ioctl+0x2c3/0x330 fs/ioctl.c:1007
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #0 (&fs_info->qgroup_ioctl_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       btrfs_quota_enable+0x3a1/0x1ef0 fs/btrfs/qgroup.c:1086
       btrfs_ioctl_quota_ctl fs/btrfs/ioctl.c:3765 [inline]
       btrfs_ioctl+0x6af4/0x8290 fs/btrfs/ioctl.c:4762
       __do_compat_sys_ioctl+0x2c3/0x330 fs/ioctl.c:1007
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

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

5 locks held by syz-executor.0/10258:
 #0: ffff88802565c420 (sb_writers#18){.+.+}-{0:0}, at: btrfs_ioctl_quota_ctl fs/btrfs/ioctl.c:3751 [inline]
 #0: ffff88802565c420 (sb_writers#18){.+.+}-{0:0}, at: btrfs_ioctl+0x20a0/0x8290 fs/btrfs/ioctl.c:4762
 #1: ffff888055fa0bd0 (&fs_info->subvol_sem){++++}-{3:3}, at: btrfs_ioctl_quota_ctl fs/btrfs/ioctl.c:3764 [inline]
 #1: ffff888055fa0bd0 (&fs_info->subvol_sem){++++}-{3:3}, at: btrfs_ioctl+0x6ae9/0x8290 fs/btrfs/ioctl.c:4762
 #2: ffff88802565c610 (sb_internal#3){.+.+}-{0:0}, at: btrfs_quota_enable+0x392/0x1ef0 fs/btrfs/qgroup.c:1084
 #3: ffff888055fa23f0 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0x137/0xf40 fs/btrfs/transaction.c:314
 #4: ffff888055fa2418 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x137/0xf40 fs/btrfs/transaction.c:314

stack backtrace:
CPU: 1 PID: 10258 Comm: syz-executor.0 Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 btrfs_quota_enable+0x3a1/0x1ef0 fs/btrfs/qgroup.c:1086
 btrfs_ioctl_quota_ctl fs/btrfs/ioctl.c:3765 [inline]
 btrfs_ioctl+0x6af4/0x8290 fs/btrfs/ioctl.c:4762
 __do_compat_sys_ioctl+0x2c3/0x330 fs/ioctl.c:1007
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7321579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5f135ac EFLAGS: 00000292 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000c0109428
RDX: 0000000020000040 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

