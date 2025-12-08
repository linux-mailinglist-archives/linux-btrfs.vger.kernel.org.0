Return-Path: <linux-btrfs+bounces-19556-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 928E3CABB43
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 01:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 018743019B92
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 00:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0741D5141;
	Mon,  8 Dec 2025 00:54:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0E41B6CE9
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 00:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765155265; cv=none; b=OMgl2Rury/Qd4joqe3E2i9UnQhzDdy2yPobPewHlgripxBVvX7OQCf6afqW5QXKHb6O5evuYl0W1VdgsCTK9oYZXPZECgGav9dlGy4lf2gxld7UGneIOhXM58rvehJv0cfgM6azeWvlcavSISBfHLjwKHewh0AovX07qh2I9+Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765155265; c=relaxed/simple;
	bh=/o41xEs0sEdxf2fQ6yykbW83mjM6XxTKr3E8aCQ3LMw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BO25eqFe2J+lvPYvZmL57RmWeLmsJntOU3FJ34fNyuhKijcqsk886cSuebHGYRnMIcnzkIJODnr9htQTNXOR+/gF1vLPk2i020q6Tzk//nKwcm/lWwQBS4H/874hsOuGJn47lu3gQb5J1/8ZGc83hT3B5gJpoRaWWzc8aOxFcRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-3e891a895e0so4701767fac.1
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Dec 2025 16:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765155263; x=1765760063;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1EdWlikPG84Jcbzgl/AUO8KwIo1Jk1ztUHjenfDFld4=;
        b=PZGUt5w521dkCNQzRbpM0x25HeBkEVB5TKd9qpxXye9R620FkDLvn2Xz9nmwm1kbqv
         nJzbI4SmuDS6NKpwHo21jOtT93tLEH+DxnnhMxa4eIQ53qmwY1P2doi14U/YQjHf6I2a
         BPs+bdTILDRuE+Z1Y/RpBhqw9JF5CjgZsUYYqqgCeOwNRk0coFgarUMUx6jR6/BdWMLn
         0ViBBzCaBklTxTdcD3DpX/8UIZtbXe1cf4/dt/lvILfS9FtQGcDM1luVLRVt9ACZHYjL
         NqZHZipBEyZQWiV72Z4YVAF0TU1kaUGgWNrPfFBXH3WCdLXsDLZEWmuflqme+0VYmtRa
         CKIw==
X-Forwarded-Encrypted: i=1; AJvYcCW7+zzc7KO/7NosNWh49gj/BmsVYqWBA1ny1++w7C8BGTJ/m0q9yyBtE5s+Gut7eNIJ4IBWhPsHntrIjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpH3fKW5VX/TpDowP2vX42VPjzhT33ccSVDmxrpvwz52i2EcpH
	zqz+W0oXrJBTGF+T34d4EkF2gMXyzpgMN6znDWBv6kQrF1xAOhkIkn3hLJRE+zr0/3aK1McVtLC
	Pha8s0e8B8a8cxdh0jde61qQjqUglqkMCmh9+5SI/PL8sDwtsPZeiODBsk1w=
X-Google-Smtp-Source: AGHT+IEYdEwIJuXlRXS7qyX+o5mdGOBIL0cNiGkxDkA2F6SAk2CrsGraGJFTY+VrjNJgFcb/4rk8yNRWQDGCGOmehhUAoGQkW1PG
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1993:b0:659:9a49:8f4e with SMTP id
 006d021491bc7-6599a8e16c5mr2496943eaf.19.1765155263011; Sun, 07 Dec 2025
 16:54:23 -0800 (PST)
Date: Sun, 07 Dec 2025 16:54:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693621be.a70a0220.38f243.0072.GAE@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in join_transaction (3)
From: syzbot <syzbot+c597e3e4382fe9c65845@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    05c93f3395ed Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14386ab4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b5338ad1e59a06c
dashboard link: https://syzkaller.appspot.com/bug?extid=c597e3e4382fe9c65845
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b5c913e373c/disk-05c93f33.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/15e75f1266ef/vmlinux-05c93f33.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dd930129c578/Image-05c93f33.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c597e3e4382fe9c65845@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
kworker/u8:9/7952 is trying to acquire lock:
ffff0000f7ac2538 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0x134/0xb5c fs/btrfs/transaction.c:317

but task is already holding lock:
ffff0000d5af8610 (sb_internal#4){.+.+}-{0:0}, at: btrfs_start_transaction+0x34/0x44 fs/btrfs/transaction.c:816

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (sb_internal#4){.+.+}-{0:0}:
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs.h:1916 [inline]
       sb_start_intwrite include/linux/fs.h:2099 [inline]
       start_transaction+0x5bc/0x155c fs/btrfs/transaction.c:699
       btrfs_join_transaction+0x30/0x40 fs/btrfs/transaction.c:830
       btrfs_dirty_inode+0x90/0x190 fs/btrfs/inode.c:6272
       btrfs_update_time+0xa0/0xd0 fs/btrfs/inode.c:6306
       inode_update_time fs/inode.c:2129 [inline]
       touch_atime+0x2e4/0x818 fs/inode.c:2202
       file_accessed include/linux/fs.h:2673 [inline]
       btrfs_file_mmap_prepare+0xc4/0x130 fs/btrfs/file.c:2049
       vfs_mmap_prepare include/linux/fs.h:2410 [inline]
       call_mmap_prepare mm/vma.c:2586 [inline]
       __mmap_region mm/vma.c:2654 [inline]
       mmap_region+0x940/0x1d28 mm/vma.c:2740
       do_mmap+0x968/0xfac mm/mmap.c:558
       vm_mmap_pgoff+0x2d8/0x45c mm/util.c:581
       ksys_mmap_pgoff+0x394/0x5b8 mm/mmap.c:604
       __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
       __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
       __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:724
       el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

-> #4 (&mm->mmap_lock){++++}-{4:4}:
       down_read_killable+0x60/0x32c kernel/locking/rwsem.c:1560
       mmap_read_lock_killable+0x28/0x8c include/linux/mmap_lock.h:377
       get_mmap_lock_carefully mm/mmap_lock.c:377 [inline]
       lock_mm_and_find_vma+0x2a4/0x2d8 mm/mmap_lock.c:428
       do_page_fault+0x50c/0x13cc arch/arm64/mm/fault.c:678
       do_translation_fault+0xc4/0x114 arch/arm64/mm/fault.c:793
       do_mem_abort+0x70/0x194 arch/arm64/mm/fault.c:933
       el1_abort+0x40/0x64 arch/arm64/kernel/entry-common.c:303
       el1h_64_sync_handler+0x50/0xfc arch/arm64/kernel/entry-common.c:437
       el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:591
       __uaccess_mask_ptr arch/arm64/include/asm/uaccess.h:169 [inline]
       filldir64+0x2ec/0x6bc fs/readdir.c:379
       dir_emit include/linux/fs.h:3988 [inline]
       kernfs_fop_readdir+0x498/0x79c fs/kernfs/dir.c:1910
       iterate_dir+0x2dc/0x478 fs/readdir.c:108
       __do_sys_getdents64 fs/readdir.c:410 [inline]
       __se_sys_getdents64 fs/readdir.c:396 [inline]
       __arm64_sys_getdents64+0x110/0x2fc fs/readdir.c:396
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:724
       el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

-> #3 (&root->kernfs_rwsem){++++}-{4:4}:
       down_write+0x50/0xc0 kernel/locking/rwsem.c:1590
       kernfs_add_one+0x48/0x60c fs/kernfs/dir.c:791
       kernfs_create_dir_ns+0xd4/0x12c fs/kernfs/dir.c:1093
       sysfs_create_dir_ns+0x114/0x24c fs/sysfs/dir.c:59
       create_dir lib/kobject.c:73 [inline]
       kobject_add_internal+0x5a8/0xb20 lib/kobject.c:240
       kobject_add_varg lib/kobject.c:374 [inline]
       kobject_init_and_add+0x118/0x17c lib/kobject.c:457
       btrfs_sysfs_add_qgroups+0x110/0x268 fs/btrfs/sysfs.c:2645
       btrfs_quota_enable+0x210/0x2438 fs/btrfs/qgroup.c:1022
       btrfs_ioctl_quota_ctl+0x178/0x1bc fs/btrfs/ioctl.c:3667
       btrfs_ioctl+0x86c/0xc3c fs/btrfs/ioctl.c:5333
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl fs/ioctl.c:583 [inline]
       __arm64_sys_ioctl+0x14c/0x1c4 fs/ioctl.c:583
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:724
       el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

-> #2 (&fs_info->qgroup_ioctl_lock){+.+.}-{4:4}:
       __mutex_lock_common+0x1d0/0x2678 kernel/locking/mutex.c:598
       __mutex_lock kernel/locking/mutex.c:760 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:812
       btrfs_quota_enable+0x24c/0x2438 fs/btrfs/qgroup.c:1051
       btrfs_ioctl_quota_ctl+0x178/0x1bc fs/btrfs/ioctl.c:3667
       btrfs_ioctl+0x86c/0xc3c fs/btrfs/ioctl.c:5333
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl fs/ioctl.c:583 [inline]
       __arm64_sys_ioctl+0x14c/0x1c4 fs/ioctl.c:583
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:724
       el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

-> #1 (btrfs_trans_num_extwriters){++++}-{0:0}:
       join_transaction+0x190/0xb5c fs/btrfs/transaction.c:321
       start_transaction+0x778/0x155c fs/btrfs/transaction.c:705
       btrfs_start_transaction+0x34/0x44 fs/btrfs/transaction.c:816
       btrfs_rebuild_free_space_tree+0xac/0x6c0 fs/btrfs/free-space-tree.c:1340
       btrfs_start_pre_rw_mount+0xed8/0x1728 fs/btrfs/disk-io.c:3062
       open_ctree+0x24cc/0x358c fs/btrfs/disk-io.c:3619
       btrfs_fill_super fs/btrfs/super.c:987 [inline]
       btrfs_get_tree_super fs/btrfs/super.c:1951 [inline]
       btrfs_get_tree_subvol fs/btrfs/super.c:2094 [inline]
       btrfs_get_tree+0xd94/0x15dc fs/btrfs/super.c:2128
       vfs_get_tree+0x90/0x28c fs/super.c:1758
       fc_mount fs/namespace.c:1199 [inline]
       do_new_mount_fc fs/namespace.c:3642 [inline]
       do_new_mount+0x284/0x944 fs/namespace.c:3718
       path_mount+0x5b4/0xdfc fs/namespace.c:4028
       do_mount fs/namespace.c:4041 [inline]
       __do_sys_mount fs/namespace.c:4229 [inline]
       __se_sys_mount fs/namespace.c:4206 [inline]
       __arm64_sys_mount+0x3e8/0x468 fs/namespace.c:4206
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:724
       el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

-> #0 (btrfs_trans_num_writers){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x1774/0x30a4 kernel/locking/lockdep.c:5237
       lock_acquire+0x14c/0x2e0 kernel/locking/lockdep.c:5868
       join_transaction+0x164/0xb5c fs/btrfs/transaction.c:320
       start_transaction+0x778/0x155c fs/btrfs/transaction.c:705
       btrfs_start_transaction+0x34/0x44 fs/btrfs/transaction.c:816
       btrfs_qgroup_rescan_worker+0x280/0x19f8 fs/btrfs/qgroup.c:3824
       btrfs_work_helper+0x380/0xca8 fs/btrfs/async-thread.c:312
       process_one_work+0x7e8/0x155c kernel/workqueue.c:3263
       process_scheduled_works kernel/workqueue.c:3346 [inline]
       worker_thread+0x958/0xed8 kernel/workqueue.c:3427
       kthread+0x5fc/0x75c kernel/kthread.c:463
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844

other info that might help us debug this:

Chain exists of:
  btrfs_trans_num_writers --> &mm->mmap_lock --> sb_internal#4

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_internal#4);
                               lock(&mm->mmap_lock);
                               lock(sb_internal#4);
  rlock(btrfs_trans_num_writers);

 *** DEADLOCK ***

3 locks held by kworker/u8:9/7952:
 #0: ffff0000f51cb148 ((wq_completion)btrfs-qgroup-rescan){+.+.}-{0:0}, at: process_one_work+0x63c/0x155c kernel/workqueue.c:3237
 #1: ffff8000a43c7be0 ((work_completion)(&work->normal_work)){+.+.}-{0:0}, at: process_one_work+0x6d4/0x155c kernel/workqueue.c:3237
 #2: ffff0000d5af8610 (sb_internal#4){.+.+}-{0:0}, at: btrfs_start_transaction+0x34/0x44 fs/btrfs/transaction.c:816

stack backtrace:
CPU: 0 UID: 0 PID: 7952 Comm: kworker/u8:9 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
Workqueue: btrfs-qgroup-rescan btrfs_work_helper
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 print_circular_bug+0x324/0x32c kernel/locking/lockdep.c:2043
 check_noncircular+0x154/0x174 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x1774/0x30a4 kernel/locking/lockdep.c:5237
 lock_acquire+0x14c/0x2e0 kernel/locking/lockdep.c:5868
 join_transaction+0x164/0xb5c fs/btrfs/transaction.c:320
 start_transaction+0x778/0x155c fs/btrfs/transaction.c:705
 btrfs_start_transaction+0x34/0x44 fs/btrfs/transaction.c:816
 btrfs_qgroup_rescan_worker+0x280/0x19f8 fs/btrfs/qgroup.c:3824
 btrfs_work_helper+0x380/0xca8 fs/btrfs/async-thread.c:312
 process_one_work+0x7e8/0x155c kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3427
 kthread+0x5fc/0x75c kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
BTRFS info (device loop7): qgroup scan completed (inconsistency flag cleared)


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

