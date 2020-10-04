Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412002828AE
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Oct 2020 06:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgJDE3R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Oct 2020 00:29:17 -0400
Received: from mail-il1-f207.google.com ([209.85.166.207]:52825 "EHLO
        mail-il1-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgJDE3R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 4 Oct 2020 00:29:17 -0400
Received: by mail-il1-f207.google.com with SMTP id m1so4485450iln.19
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Oct 2020 21:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=dEm5RHm6t/xovL74zB0iSaDTAFwH2/BwEjmJeGG3iy8=;
        b=V4cHYClUflggi4RMRkp7LneB17YDm0oMu1YjTrcsB/o0Nmkf14mvGhB2RUCyzBQ0un
         OTfGL6lRiTM1suGOxpVvEeHDBMMMtlfi/jY+7M/LxlLr7oerzEIgVOLBxR8MAvgV5aBf
         ljoDvdp4vJw9LiLM3oJL7yz32MAvIzicx2jxJPxHaKsNGm9gBUhXAcGXfuzd4ycYL9qu
         /frnV2wMRAaW5lrGVqPqFCPegQxdw/FHGl59ReN5xdR3I6wYfwmF1GuUNc1oenIN8hP2
         p0TIYTGIFpcgQ4NlqxCqTRdbxiRK4gMXnjFnwX56Sk+Aj193sywigSpJLO8+03yGSBlB
         BrLw==
X-Gm-Message-State: AOAM531nUJOt+uIj4SCp/JLWiU8Qndx6uPR7x3jVERFdO4z5DFW8Liu/
        3atcyQa6qodNv1O6GPfn/XOW6Nn9cWV6/77D4CJZI9izQhvY
X-Google-Smtp-Source: ABdhPJzEix4IFeWYT03sr2/StXiM78rygvQjceotGmxH6bwpFEXOjcvhQcckriNY6FGgWZmJ/6M3N6px5foTXQg9lziec3Ggqqzz
MIME-Version: 1.0
X-Received: by 2002:a92:c7b4:: with SMTP id f20mr1110169ilk.199.1601785755736;
 Sat, 03 Oct 2020 21:29:15 -0700 (PDT)
Date:   Sat, 03 Oct 2020 21:29:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa228105b0d0cead@google.com>
Subject: possible deadlock in start_transaction
From:   syzbot <syzbot+ec309a632856890f2635@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ccc1d052 Merge tag 'dmaengine-fix-5.9' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f1fa5b900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41b736b7ce1b3ea4
dashboard link: https://syzkaller.appspot.com/bug?extid=ec309a632856890f2635
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ec309a632856890f2635@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.9.0-rc7-syzkaller #0 Not tainted
------------------------------------------------------
kworker/u4:6/8345 is trying to acquire lock:
ffff888091200640 (sb_internal#3){.+.+}-{0:0}, at: sb_start_intwrite include/linux/fs.h:1690 [inline]
ffff888091200640 (sb_internal#3){.+.+}-{0:0}, at: start_transaction+0xbe7/0x1170 fs/btrfs/transaction.c:624

but task is already holding lock:
ffffc900161ffda8 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x85f/0x1670 kernel/workqueue.c:2244

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}:
       __flush_work+0x60e/0xac0 kernel/workqueue.c:3041
       wb_shutdown+0x180/0x220 mm/backing-dev.c:355
       bdi_unregister+0x174/0x590 mm/backing-dev.c:872
       del_gendisk+0x820/0xa10 block/genhd.c:933
       loop_remove drivers/block/loop.c:2192 [inline]
       loop_control_ioctl drivers/block/loop.c:2291 [inline]
       loop_control_ioctl+0x3b1/0x480 drivers/block/loop.c:2257
       vfs_ioctl fs/ioctl.c:48 [inline]
       __do_sys_ioctl fs/ioctl.c:753 [inline]
       __se_sys_ioctl fs/ioctl.c:739 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #3 (loop_ctl_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x134/0x10e0 kernel/locking/mutex.c:1103
       lo_open+0x19/0xd0 drivers/block/loop.c:1893
       __blkdev_get+0x759/0x1aa0 fs/block_dev.c:1507
       blkdev_get fs/block_dev.c:1639 [inline]
       blkdev_open+0x227/0x300 fs/block_dev.c:1753
       do_dentry_open+0x4b9/0x11b0 fs/open.c:817
       do_open fs/namei.c:3251 [inline]
       path_openat+0x1b9a/0x2730 fs/namei.c:3368
       do_filp_open+0x17e/0x3c0 fs/namei.c:3395
       do_sys_openat2+0x16d/0x420 fs/open.c:1168
       do_sys_open fs/open.c:1184 [inline]
       __do_sys_open fs/open.c:1192 [inline]
       __se_sys_open fs/open.c:1188 [inline]
       __x64_sys_open+0x119/0x1c0 fs/open.c:1188
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #2 (&bdev->bd_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x134/0x10e0 kernel/locking/mutex.c:1103
       blkdev_put+0x30/0x520 fs/block_dev.c:1804
       btrfs_close_bdev fs/btrfs/volumes.c:1117 [inline]
       btrfs_close_bdev fs/btrfs/volumes.c:1107 [inline]
       btrfs_close_one_device fs/btrfs/volumes.c:1133 [inline]
       close_fs_devices.part.0+0x1a4/0x800 fs/btrfs/volumes.c:1161
       close_fs_devices fs/btrfs/volumes.c:1193 [inline]
       btrfs_close_devices+0x95/0x1f0 fs/btrfs/volumes.c:1179
       close_ctree+0x688/0x6cb fs/btrfs/disk-io.c:4148
       generic_shutdown_super+0x144/0x370 fs/super.c:464
       kill_anon_super+0x36/0x60 fs/super.c:1108
       btrfs_kill_super+0x38/0x50 fs/btrfs/super.c:2265
       deactivate_locked_super+0x94/0x160 fs/super.c:335
       deactivate_super+0xad/0xd0 fs/super.c:366
       cleanup_mnt+0x3a3/0x530 fs/namespace.c:1118
       task_work_run+0xdd/0x190 kernel/task_work.c:141
       tracehook_notify_resume include/linux/tracehook.h:188 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:165 [inline]
       exit_to_user_mode_prepare+0x1e1/0x200 kernel/entry/common.c:192
       syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:267
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #1 (&fs_devs->device_list_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x134/0x10e0 kernel/locking/mutex.c:1103
       btrfs_finish_chunk_alloc+0x281/0xf90 fs/btrfs/volumes.c:5255
       btrfs_create_pending_block_groups+0x2f3/0x700 fs/btrfs/block-group.c:2109
       __btrfs_end_transaction+0xf5/0x690 fs/btrfs/transaction.c:916
       btrfs_alloc_data_chunk_ondemand+0x2a1/0x670 fs/btrfs/delalloc-space.c:167
       btrfs_fallocate+0x279/0x2900 fs/btrfs/file.c:3282
       vfs_fallocate+0x48d/0x9d0 fs/open.c:309
       ksys_fallocate fs/open.c:332 [inline]
       __do_sys_fallocate fs/open.c:340 [inline]
       __se_sys_fallocate fs/open.c:338 [inline]
       __x64_sys_fallocate+0xcf/0x140 fs/open.c:338
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (sb_internal#3){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:2496 [inline]
       check_prevs_add kernel/locking/lockdep.c:2601 [inline]
       validate_chain kernel/locking/lockdep.c:3218 [inline]
       __lock_acquire+0x2a96/0x5780 kernel/locking/lockdep.c:4441
       lock_acquire+0x1f3/0xaf0 kernel/locking/lockdep.c:5029
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write+0x228/0x450 fs/super.c:1672
       sb_start_intwrite include/linux/fs.h:1690 [inline]
       start_transaction+0xbe7/0x1170 fs/btrfs/transaction.c:624
       find_free_extent_update_loop fs/btrfs/extent-tree.c:3789 [inline]
       find_free_extent+0x25e1/0x2e60 fs/btrfs/extent-tree.c:4127
       btrfs_reserve_extent+0x166/0x460 fs/btrfs/extent-tree.c:4206
       cow_file_range+0x3de/0x9b0 fs/btrfs/inode.c:1063
       btrfs_run_delalloc_range+0x2cf/0x1410 fs/btrfs/inode.c:1838
       writepage_delalloc+0x150/0x460 fs/btrfs/extent_io.c:3439
       __extent_writepage+0x441/0xd00 fs/btrfs/extent_io.c:3653
       extent_write_cache_pages.constprop.0+0x69d/0x1040 fs/btrfs/extent_io.c:4249
       extent_writepages+0xcd/0x2b0 fs/btrfs/extent_io.c:4370
       do_writepages+0xec/0x290 mm/page-writeback.c:2352
       __writeback_single_inode+0x125/0x1400 fs/fs-writeback.c:1461
       writeback_sb_inodes+0x53d/0xf40 fs/fs-writeback.c:1721
       wb_writeback+0x2ad/0xd40 fs/fs-writeback.c:1894
       wb_do_writeback fs/fs-writeback.c:2039 [inline]
       wb_workfn+0x2dc/0x13e0 fs/fs-writeback.c:2080
       process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
       worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
       kthread+0x3b5/0x4a0 kernel/kthread.c:292
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

other info that might help us debug this:

Chain exists of:
  sb_internal#3 --> loop_ctl_mutex --> (work_completion)(&(&wb->dwork)->work)

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((work_completion)(&(&wb->dwork)->work));
                               lock(loop_ctl_mutex);
                               lock((work_completion)(&(&wb->dwork)->work));
  lock(sb_internal#3);

 *** DEADLOCK ***

2 locks held by kworker/u4:6/8345:
 #0: ffff88821ade2938 ((wq_completion)writeback){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88821ade2938 ((wq_completion)writeback){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff88821ade2938 ((wq_completion)writeback){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff88821ade2938 ((wq_completion)writeback){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff88821ade2938 ((wq_completion)writeback){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff88821ade2938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x82b/0x1670 kernel/workqueue.c:2240
 #1: ffffc900161ffda8 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x85f/0x1670 kernel/workqueue.c:2244

stack backtrace:
CPU: 0 PID: 8345 Comm: kworker/u4:6 Not tainted 5.9.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: writeback wb_workfn (flush-btrfs-6)
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 check_noncircular+0x324/0x3e0 kernel/locking/lockdep.c:1827
 check_prev_add kernel/locking/lockdep.c:2496 [inline]
 check_prevs_add kernel/locking/lockdep.c:2601 [inline]
 validate_chain kernel/locking/lockdep.c:3218 [inline]
 __lock_acquire+0x2a96/0x5780 kernel/locking/lockdep.c:4441
 lock_acquire+0x1f3/0xaf0 kernel/locking/lockdep.c:5029
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 __sb_start_write+0x228/0x450 fs/super.c:1672
 sb_start_intwrite include/linux/fs.h:1690 [inline]
 start_transaction+0xbe7/0x1170 fs/btrfs/transaction.c:624
 find_free_extent_update_loop fs/btrfs/extent-tree.c:3789 [inline]
 find_free_extent+0x25e1/0x2e60 fs/btrfs/extent-tree.c:4127
 btrfs_reserve_extent+0x166/0x460 fs/btrfs/extent-tree.c:4206
 cow_file_range+0x3de/0x9b0 fs/btrfs/inode.c:1063
 btrfs_run_delalloc_range+0x2cf/0x1410 fs/btrfs/inode.c:1838
 writepage_delalloc+0x150/0x460 fs/btrfs/extent_io.c:3439
 __extent_writepage+0x441/0xd00 fs/btrfs/extent_io.c:3653
 extent_write_cache_pages.constprop.0+0x69d/0x1040 fs/btrfs/extent_io.c:4249
 extent_writepages+0xcd/0x2b0 fs/btrfs/extent_io.c:4370
 do_writepages+0xec/0x290 mm/page-writeback.c:2352
 __writeback_single_inode+0x125/0x1400 fs/fs-writeback.c:1461
 writeback_sb_inodes+0x53d/0xf40 fs/fs-writeback.c:1721
 wb_writeback+0x2ad/0xd40 fs/fs-writeback.c:1894
 wb_do_writeback fs/fs-writeback.c:2039 [inline]
 wb_workfn+0x2dc/0x13e0 fs/fs-writeback.c:2080
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
