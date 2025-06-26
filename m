Return-Path: <linux-btrfs+bounces-14987-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BE9AE9AC7
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 12:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E224E038E
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 10:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E4D220698;
	Thu, 26 Jun 2025 10:05:37 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2952E217701
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750932337; cv=none; b=fd2hpAePuvcvAD+rcCiXYahSZ6vE6nGD6vvIzA6XC+myF/xHIiw8/6BASPV0Hqur3ufi+Vx3hPRx+ZPnRsvRbJNsSp8XhAyb95mKPwB+yaPDtaAzfXY2p8AsSGRBA3QBfH4wJg1VWUu5FtCGZJe4UQuQJFvvm4W5pumWZARhTms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750932337; c=relaxed/simple;
	bh=hqp5iWXg7QS0Zu8cF4dv50I19ymXxkRKzOhSmGn++Vw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BhkDOKZH+klvo0HZfpj5O2PkClKTpPqgkCSwzPrPnBdAKPme9YeNN7+qP9KU/bDxy/m6NUcxUoFgbTm3oQ1kljpbeSD6YLf4ZoilcAzH/DVyqdLF7i8awkO//xn2YtGQRjAN2gVJwLIF+3ViOaUJD0iY0wIa4D+s+1FCHc+HkkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ddb4a92e80so10483215ab.3
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 03:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750932334; x=1751537134;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8SWlKXcbGfVq1bqP6GES795wTDd3bwzL3k0lB8D4I5A=;
        b=aa7oTcn8g02t+ORsxPgeJR7Fm3ahFA8w9RLARVGZEZzwf/00m5Oxo4M/ESeHvk1Uvu
         T1oNQLfO3czL3C0Xa8oeEMdlEx3yLEMkMZLMSBR1OENG305KY1Hv90vou8+taCCjleqz
         i5YJxozMvbgvgHe18ArlfCAGVsSlg+3BhJmhZapWN5cOws+x3eetOnc+uHvVKIIBYOPM
         0nUCwjeYnqzY/5S+4c/pDC5hM0XetjyfjpiFMwoUVjzENnobIVM36lWmZtY9p33sCSDf
         rdmOPB8R7AVf8nmpG4RojLIE0EhFYpsgZO5mZ2P95/y8bnJ8OBQLW9yB6/rwW+HRa8Uw
         9RBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUMHzvDvZ/qVoPFbQXpQ+IjTlyk/8wiqNHxICMdvd1EP4KFVIOoODhR7+p0bnzwQcNJtE908ypz5kf6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcOnhSZ2uMdyC/MvmQHpP7yOkqLgf3o7t4PA/9aWd9eypidDTC
	DuDCOotF7T7WBfuMh++uvtbywcIWHM+EcQEm0kOoQE4h1zn4cPc7su7xjG37VhRECAiQI7kvG+C
	ZBunPSpphVEhhetCNd+t+lfRJJ5d/0TPPQ0Am1L+GWFG7YZU25bkLKaDKsF0=
X-Google-Smtp-Source: AGHT+IEC95MJBpOXmV0BZyyx3ets/sDykji5f1j958LFYCebNq95JTvE97nWMRpKRTGK1Us2OkmBPqvkw7VMiozqLd29WQLkIl41
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2703:b0:3dd:8663:d182 with SMTP id
 e9e14a558f8ab-3df329373fbmr58891975ab.13.1750932333860; Thu, 26 Jun 2025
 03:05:33 -0700 (PDT)
Date: Thu, 26 Jun 2025 03:05:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685d1b6d.a00a0220.34b642.00fd.GAE@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in btrfs_join_transaction (2)
From: syzbot <syzbot+872fc61967352fcc3535@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9aa9b43d689e Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1796cdd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27f179c74d5c35cd
dashboard link: https://syzkaller.appspot.com/bug?extid=872fc61967352fcc3535
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/974f3ac1c6a5/disk-9aa9b43d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a5b5075d317f/vmlinux-9aa9b43d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2f0ba7fec19b/Image-9aa9b43d.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+872fc61967352fcc3535@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.16.0-rc2-syzkaller-g9aa9b43d689e #0 Not tainted
------------------------------------------------------
syz.2.224/7634 is trying to acquire lock:
ffff0000c6b20618 (sb_internal#3){.+.+}-{0:0}, at: btrfs_join_transaction+0x30/0x40 fs/btrfs/transaction.c:830

but task is already holding lock:
ffff0000d0c2b7d0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:374 [inline]
ffff0000d0c2b7d0 (&mm->mmap_lock){++++}-{4:4}, at: vm_mmap_pgoff+0x180/0x43c mm/util.c:577

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&mm->mmap_lock){++++}-{4:4}:
       down_read_killable+0x60/0x32c kernel/locking/rwsem.c:1547
       mmap_read_lock_killable+0x28/0x8c include/linux/mmap_lock.h:421
       get_mmap_lock_carefully mm/mmap_lock.c:197 [inline]
       lock_mm_and_find_vma+0x2a4/0x2d8 mm/mmap_lock.c:248
       do_page_fault+0x51c/0x1554 arch/arm64/mm/fault.c:668
       do_translation_fault+0xc4/0x114 arch/arm64/mm/fault.c:783
       do_mem_abort+0x70/0x194 arch/arm64/mm/fault.c:919
       el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:455
       el1h_64_sync_handler+0x50/0xcc arch/arm64/kernel/entry-common.c:533
       el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:595
       __uaccess_mask_ptr arch/arm64/include/asm/uaccess.h:169 [inline]
       filldir64+0x2ec/0x6bc fs/readdir.c:379
       dir_emit include/linux/fs.h:3917 [inline]
       kernfs_fop_readdir+0x498/0x79c fs/kernfs/dir.c:1910
       iterate_dir+0x458/0x5e0 fs/readdir.c:108
       __do_sys_getdents64 fs/readdir.c:410 [inline]
       __se_sys_getdents64 fs/readdir.c:396 [inline]
       __arm64_sys_getdents64+0x110/0x2fc fs/readdir.c:396
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x58/0x17c arch/arm64/kernel/entry-common.c:767
       el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:786
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

-> #4 (&root->kernfs_rwsem){++++}-{4:4}:
       down_write+0x50/0xc0 kernel/locking/rwsem.c:1577
       kernfs_add_one+0x48/0x60c fs/kernfs/dir.c:791
       kernfs_create_dir_ns+0xd4/0x12c fs/kernfs/dir.c:1093
       sysfs_create_dir_ns+0x114/0x24c fs/sysfs/dir.c:59
       create_dir lib/kobject.c:73 [inline]
       kobject_add_internal+0x5a8/0xb20 lib/kobject.c:240
       kobject_add_varg lib/kobject.c:374 [inline]
       kobject_init_and_add+0x118/0x17c lib/kobject.c:457
       btrfs_sysfs_add_qgroups+0x110/0x268 fs/btrfs/sysfs.c:2635
       btrfs_quota_enable+0x224/0x1c70 fs/btrfs/qgroup.c:1030
       btrfs_ioctl_quota_ctl+0x178/0x1bc fs/btrfs/ioctl.c:3673
       btrfs_ioctl+0x86c/0xc3c fs/btrfs/ioctl.c:5323
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:907 [inline]
       __se_sys_ioctl fs/ioctl.c:893 [inline]
       __arm64_sys_ioctl+0x14c/0x1c4 fs/ioctl.c:893
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x58/0x17c arch/arm64/kernel/entry-common.c:767
       el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:786
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

-> #3 (&fs_info->qgroup_ioctl_lock){+.+.}-{4:4}:
       __mutex_lock_common+0x1d0/0x2190 kernel/locking/mutex.c:602
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
       btrfs_quota_enable+0x270/0x1c70 fs/btrfs/qgroup.c:1059
       btrfs_ioctl_quota_ctl+0x178/0x1bc fs/btrfs/ioctl.c:3673
       btrfs_ioctl+0x86c/0xc3c fs/btrfs/ioctl.c:5323
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:907 [inline]
       __se_sys_ioctl fs/ioctl.c:893 [inline]
       __arm64_sys_ioctl+0x14c/0x1c4 fs/ioctl.c:893
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x58/0x17c arch/arm64/kernel/entry-common.c:767
       el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:786
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

-> #2 (btrfs_trans_num_extwriters){++++}-{0:0}:
       join_transaction+0x190/0xb5c fs/btrfs/transaction.c:321
       start_transaction+0x778/0x155c fs/btrfs/transaction.c:705
       btrfs_join_transaction+0x30/0x40 fs/btrfs/transaction.c:830
       __cow_file_range_inline+0x140/0xf14 fs/btrfs/inode.c:618
       cow_file_range_inline+0x27c/0x338 fs/btrfs/inode.c:690
       cow_file_range+0x324/0xc70 fs/btrfs/inode.c:1293
       btrfs_run_delalloc_range+0x33c/0xd7c fs/btrfs/inode.c:2348
       writepage_delalloc+0x8f0/0x103c fs/btrfs/extent_io.c:1386
       extent_writepage fs/btrfs/extent_io.c:1717 [inline]
       extent_write_cache_pages fs/btrfs/extent_io.c:2403 [inline]
       btrfs_writepages+0x115c/0x20dc fs/btrfs/extent_io.c:2536
       do_writepages+0x270/0x468 mm/page-writeback.c:2636
       __writeback_single_inode+0x15c/0x13e8 fs/fs-writeback.c:1680
       writeback_sb_inodes+0x558/0xe38 fs/fs-writeback.c:1976
       wb_writeback+0x3cc/0xd70 fs/fs-writeback.c:2156
       wb_do_writeback fs/fs-writeback.c:2303 [inline]
       wb_workfn+0x338/0xdc0 fs/fs-writeback.c:2343
       process_one_work+0x7e8/0x155c kernel/workqueue.c:3238
       process_scheduled_works kernel/workqueue.c:3321 [inline]
       worker_thread+0x958/0xed8 kernel/workqueue.c:3402
       kthread+0x5fc/0x75c kernel/kthread.c:464
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847

-> #1 (btrfs_trans_num_writers){++++}-{0:0}:
       join_transaction+0x164/0xb5c fs/btrfs/transaction.c:320
       start_transaction+0x778/0x155c fs/btrfs/transaction.c:705
       btrfs_join_transaction+0x30/0x40 fs/btrfs/transaction.c:830
       __cow_file_range_inline+0x140/0xf14 fs/btrfs/inode.c:618
       cow_file_range_inline+0x27c/0x338 fs/btrfs/inode.c:690
       cow_file_range+0x324/0xc70 fs/btrfs/inode.c:1293
       btrfs_run_delalloc_range+0x33c/0xd7c fs/btrfs/inode.c:2348
       writepage_delalloc+0x8f0/0x103c fs/btrfs/extent_io.c:1386
       extent_writepage fs/btrfs/extent_io.c:1717 [inline]
       extent_write_cache_pages fs/btrfs/extent_io.c:2403 [inline]
       btrfs_writepages+0x115c/0x20dc fs/btrfs/extent_io.c:2536
       do_writepages+0x270/0x468 mm/page-writeback.c:2636
       __writeback_single_inode+0x15c/0x13e8 fs/fs-writeback.c:1680
       writeback_sb_inodes+0x558/0xe38 fs/fs-writeback.c:1976
       wb_writeback+0x3cc/0xd70 fs/fs-writeback.c:2156
       wb_do_writeback fs/fs-writeback.c:2303 [inline]
       wb_workfn+0x338/0xdc0 fs/fs-writeback.c:2343
       process_one_work+0x7e8/0x155c kernel/workqueue.c:3238
       process_scheduled_works kernel/workqueue.c:3321 [inline]
       worker_thread+0x958/0xed8 kernel/workqueue.c:3402
       kthread+0x5fc/0x75c kernel/kthread.c:464
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847

-> #0 (sb_internal#3){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain kernel/locking/lockdep.c:3911 [inline]
       __lock_acquire+0x1774/0x30a4 kernel/locking/lockdep.c:5240
       lock_acquire+0x14c/0x2e0 kernel/locking/lockdep.c:5871
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs.h:1793 [inline]
       sb_start_intwrite include/linux/fs.h:1976 [inline]
       start_transaction+0x5bc/0x155c fs/btrfs/transaction.c:699
       btrfs_join_transaction+0x30/0x40 fs/btrfs/transaction.c:830
       btrfs_dirty_inode+0x90/0x190 fs/btrfs/inode.c:6225
       btrfs_update_time+0xa0/0xd0 fs/btrfs/inode.c:6259
       inode_update_time fs/inode.c:2076 [inline]
       touch_atime+0x2e4/0x818 fs/inode.c:2149
       file_accessed include/linux/fs.h:2650 [inline]
       btrfs_file_mmap+0xac/0x118 fs/btrfs/file.c:1988
       call_mmap include/linux/fs.h:2284 [inline]
       mmap_file mm/internal.h:167 [inline]
       __mmap_new_file_vma mm/vma.c:2405 [inline]
       __mmap_new_vma mm/vma.c:2467 [inline]
       __mmap_region mm/vma.c:2622 [inline]
       mmap_region+0xe9c/0x1c0c mm/vma.c:2692
       do_mmap+0x968/0xfac mm/mmap.c:561
       vm_mmap_pgoff+0x2b8/0x43c mm/util.c:579
       ksys_mmap_pgoff+0x394/0x5b8 mm/mmap.c:607
       __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
       __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
       __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x58/0x17c arch/arm64/kernel/entry-common.c:767
       el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:786
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

other info that might help us debug this:

Chain exists of:
  sb_internal#3 --> &root->kernfs_rwsem --> &mm->mmap_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mm->mmap_lock);
                               lock(&root->kernfs_rwsem);
                               lock(&mm->mmap_lock);
  rlock(sb_internal#3);

 *** DEADLOCK ***

2 locks held by syz.2.224/7634:
 #0: ffff0000d0c2b7d0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:374 [inline]
 #0: ffff0000d0c2b7d0 (&mm->mmap_lock){++++}-{4:4}, at: vm_mmap_pgoff+0x180/0x43c mm/util.c:577
 #1: ffff0000c6b20428 (sb_writers#23){.+.+}-{0:0}, at: file_accessed include/linux/fs.h:2650 [inline]
 #1: ffff0000c6b20428 (sb_writers#23){.+.+}-{0:0}, at: btrfs_file_mmap+0xac/0x118 fs/btrfs/file.c:1988

stack backtrace:
CPU: 1 UID: 0 PID: 7634 Comm: syz.2.224 Not tainted 6.16.0-rc2-syzkaller-g9aa9b43d689e #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:501 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 print_circular_bug+0x324/0x32c kernel/locking/lockdep.c:2046
 check_noncircular+0x154/0x174 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3168 [inline]
 check_prevs_add kernel/locking/lockdep.c:3287 [inline]
 validate_chain kernel/locking/lockdep.c:3911 [inline]
 __lock_acquire+0x1774/0x30a4 kernel/locking/lockdep.c:5240
 lock_acquire+0x14c/0x2e0 kernel/locking/lockdep.c:5871
 percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
 percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 __sb_start_write include/linux/fs.h:1793 [inline]
 sb_start_intwrite include/linux/fs.h:1976 [inline]
 start_transaction+0x5bc/0x155c fs/btrfs/transaction.c:699
 btrfs_join_transaction+0x30/0x40 fs/btrfs/transaction.c:830
 btrfs_dirty_inode+0x90/0x190 fs/btrfs/inode.c:6225
 btrfs_update_time+0xa0/0xd0 fs/btrfs/inode.c:6259
 inode_update_time fs/inode.c:2076 [inline]
 touch_atime+0x2e4/0x818 fs/inode.c:2149
 file_accessed include/linux/fs.h:2650 [inline]
 btrfs_file_mmap+0xac/0x118 fs/btrfs/file.c:1988
 call_mmap include/linux/fs.h:2284 [inline]
 mmap_file mm/internal.h:167 [inline]
 __mmap_new_file_vma mm/vma.c:2405 [inline]
 __mmap_new_vma mm/vma.c:2467 [inline]
 __mmap_region mm/vma.c:2622 [inline]
 mmap_region+0xe9c/0x1c0c mm/vma.c:2692
 do_mmap+0x968/0xfac mm/mmap.c:561
 vm_mmap_pgoff+0x2b8/0x43c mm/util.c:579
 ksys_mmap_pgoff+0x394/0x5b8 mm/mmap.c:607
 __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
 __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
 __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x17c arch/arm64/kernel/entry-common.c:767
 el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:786
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600


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

