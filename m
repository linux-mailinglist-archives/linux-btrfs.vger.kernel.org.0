Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6020841154A
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 15:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238795AbhITNJ3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 09:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbhITNJ2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 09:09:28 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6CBC061574;
        Mon, 20 Sep 2021 06:08:01 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id u18so17338792pgf.0;
        Mon, 20 Sep 2021 06:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7IAkUaEsuoXvk5AHF6ea3F2Us9UC3LmFJzi07/4mfaQ=;
        b=Nz3E7uzD8DEZiRUwvwDIIcop2eTbcxfcShwHNYiQq9tKmJDH7423rI0yovAHrkLW5X
         VIbE5+rQsAZJuvtlThTjuEuh/73SSY8M/IOXGM9/BqTmCtgM/u7jrNk0yWek5uZn3kz3
         8XEMo9A6dgZUfDKM6j9JwAFtqM0NaJXYU4kBHbvg2xTjNO3IOlB8vRQM1m3Rqa/ao2Uq
         RdN9XzpLvzIFqwoxsDdEgD3eEkOT45H3Tb2flnhc4WeBO0QKoTspu/7TMo4krby9VbUU
         Aa8m5yaNFXTalLsWaqHYzHiWPXZtpFqjUYoIHgTLxQltiq8I241668xilRW62dL3rqqE
         zvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7IAkUaEsuoXvk5AHF6ea3F2Us9UC3LmFJzi07/4mfaQ=;
        b=jO0NVF7JJVJx4pI8TPyZxfwglXJGH1zUT7b/TeFjhYY5uRIddnNz+AKhgvfyFUCUdw
         qVmhWOLQyS5sE6GzWriPwkDNUS/A3XAjWn7A1R8Pk5vDEZMkvH5r02QkmT2W/Aqo8FEH
         5zJZb74ZL5I8yMtEQpXkhD3WHczlBPaIH7B00RxcWha8IKHQjUv+aLIGQ046gA5ceoOF
         hwRLwITg9OoQHtnd12tiqnl8Bv+doK/pz9t8zgG3NN6KaEDiFru/n/69sAZCY+B/cFsF
         x4pAHlMDs8WT8qiIvYHjtAAapn8pDSaKLflY/38nVYE04gSJsar847vU6bIXVR/HqmID
         om9g==
X-Gm-Message-State: AOAM530PnWkkxdWwWlUFYU8OZjCQpHUO5s1xZY3ZYOJzDyeP/E+bWrMw
        L5NXmHYlAl5VP6auO7o00o7JVXRNF63ghKAP26sxoKBHrA==
X-Google-Smtp-Source: ABdhPJy5e5yj2vYiuNBQ2msEMyItBUm0X4VS5/DweKBiL0MuZSG+Fpb0pWy9cXaE2Sv+lYSycrOWwgO3p7jmCQM1r/o=
X-Received: by 2002:a63:e04a:: with SMTP id n10mr22920482pgj.381.1632143281153;
 Mon, 20 Sep 2021 06:08:01 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Mon, 20 Sep 2021 21:08:08 +0800
Message-ID: <CACkBjsbgr2326GeHimMCPhisEgt4J0BJgOEyhz3JnAR0KJ3RDw@mail.gmail.com>
Subject: possible deadlock in __btrfs_release_delayed_node
To:     clm@fb.com, dsterba@suse.com, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 4357f03d6611 Merge tag 'pm-5.15-rc2
git tree: upstream
console output:
https://drive.google.com/file/d/1Is2XjAwyco_VmymNbbsMH4xZysHsgfag/view?usp=sharing
kernel config: https://drive.google.com/file/d/1HKZtF_s3l6PL3OoQbNq_ei9CdBus-Tz0/view?usp=sharing

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

loop9: detected capacity change from 0 to 32768
BTRFS info (device loop9): disk space caching is enabled
BTRFS info (device loop9): has skinny extents
BTRFS info (device loop9): enabling ssd optimizations
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 3 PID: 16884 Comm: syz-executor Not tainted 5.15.0-rc1+ #19
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
 fail_dump lib/fault-inject.c:52 [inline]
 should_fail+0x13c/0x160 lib/fault-inject.c:146
 should_failslab+0x5/0x10 mm/slab_common.c:1328
 slab_pre_alloc_hook.constprop.99+0x4e/0xc0 mm/slab.h:494
 slab_alloc_node mm/slub.c:3120 [inline]
 slab_alloc mm/slub.c:3214 [inline]
 kmem_cache_alloc+0x44/0x280 mm/slub.c:3219
 btrfs_add_delayed_tree_ref+0xc3/0x580 fs/btrfs/delayed-ref.c:917
 btrfs_alloc_tree_block+0x478/0x670 fs/btrfs/extent-tree.c:4853
 __btrfs_cow_block+0x16f/0x820 fs/btrfs/ctree.c:415
 btrfs_cow_block+0x12a/0x300 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x6b0/0xee0 fs/btrfs/ctree.c:1768
 btrfs_lookup_inode+0x50/0x110 fs/btrfs/inode-item.c:408
 __btrfs_update_delayed_inode+0x81/0x3a0 fs/btrfs/delayed-inode.c:948
 btrfs_commit_inode_delayed_inode+0x14a/0x160 fs/btrfs/delayed-inode.c:1189
 btrfs_log_inode+0x438/0x1ab0 fs/btrfs/tree-log.c:5385
 btrfs_log_inode_parent+0x272/0x1110 fs/btrfs/tree-log.c:6168
 btrfs_log_dentry_safe+0x3a/0x50 fs/btrfs/tree-log.c:6269
 btrfs_sync_file+0x2cd/0x760 fs/btrfs/file.c:2264
 vfs_fsync_range+0x48/0xa0 fs/sync.c:200
 generic_write_sync include/linux/fs.h:2955 [inline]
 btrfs_file_write_iter+0x34f/0x510 fs/btrfs/file.c:2034
 call_write_iter include/linux/fs.h:2163 [inline]
 new_sync_write+0x18d/0x260 fs/read_write.c:507
 vfs_write+0x43b/0x4a0 fs/read_write.c:594
 ksys_write+0xd2/0x120 fs/read_write.c:647
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46ae99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f685738cc48 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
RDX: 000000000000000b RSI: 0000000020005940 RDI: 0000000000000003
RBP: 00007f685738cc80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000001e
R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffc71ddb640
BTRFS: error (device loop9) in __btrfs_update_delayed_inode:995:
errno=-12 Out of memory
BTRFS info (device loop9): forced readonly

======================================================
WARNING: possible circular locking dependency detected
5.15.0-rc1+ #19 Not tainted
------------------------------------------------------
syz-executor/16884 is trying to acquire lock:
ffff88810f946ab0 (&delayed_node->mutex){+.+.}-{3:3}, at:
__btrfs_release_delayed_node+0x4e/0x410 fs/btrfs/delayed-inode.c:262

but task is already holding lock:
ffff888016e696e8 (btrfs-tree-01/1){+.+.}-{3:3}, at:
__btrfs_tree_lock+0x2e/0x1a0 fs/btrfs/locking.c:112

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (btrfs-tree-01/1){+.+.}-{3:3}:
       __lock_release kernel/locking/lockdep.c:5341 [inline]
       lock_release+0x135/0x2e0 kernel/locking/lockdep.c:5645
       up_write+0x12/0x130 kernel/locking/rwsem.c:1569
       __btrfs_cow_block+0x552/0x820 fs/btrfs/ctree.c:491
       btrfs_cow_block+0x12a/0x300 fs/btrfs/ctree.c:570
       btrfs_search_slot+0x6b0/0xee0 fs/btrfs/ctree.c:1768
       btrfs_insert_empty_items+0x80/0xf0 fs/btrfs/ctree.c:3905
       btrfs_insert_delayed_item fs/btrfs/delayed-inode.c:736 [inline]
       btrfs_insert_delayed_items fs/btrfs/delayed-inode.c:783 [inline]
       __btrfs_commit_inode_delayed_items fs/btrfs/delayed-inode.c:1041 [inline]
       __btrfs_run_delayed_items+0x307/0x6a0 fs/btrfs/delayed-inode.c:1083
       btrfs_commit_transaction+0x268/0x1450 fs/btrfs/transaction.c:2170
       btrfs_sync_fs+0x9a/0x430 fs/btrfs/super.c:1426
       __sync_filesystem fs/sync.c:39 [inline]
       sync_filesystem+0x9b/0xd0 fs/sync.c:67
       generic_shutdown_super+0x30/0x170 fs/super.c:448
       kill_anon_super+0x15/0x30 fs/super.c:1057
       btrfs_kill_super+0x19/0x30 fs/btrfs/super.c:2348
       deactivate_locked_super+0x43/0x80 fs/super.c:335
       deactivate_super+0x53/0x80 fs/super.c:366
       cleanup_mnt+0x138/0x1b0 fs/namespace.c:1137
       task_work_run+0x86/0xd0 kernel/task_work.c:164
       tracehook_notify_resume include/linux/tracehook.h:189 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
       exit_to_user_mode_prepare+0x271/0x280 kernel/entry/common.c:209
       __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
       syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
       do_syscall_64+0x40/0xb0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (&delayed_node->mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3051 [inline]
       check_prevs_add kernel/locking/lockdep.c:3174 [inline]
       validate_chain kernel/locking/lockdep.c:3789 [inline]
       __lock_acquire+0x161f/0x1d60 kernel/locking/lockdep.c:5015
       lock_acquire+0x1f9/0x340 kernel/locking/lockdep.c:5625
       __mutex_lock_common kernel/locking/mutex.c:596 [inline]
       __mutex_lock+0x98/0xa50 kernel/locking/mutex.c:729
       __btrfs_release_delayed_node+0x4e/0x410 fs/btrfs/delayed-inode.c:262
       btrfs_release_delayed_node fs/btrfs/delayed-inode.c:287 [inline]
       btrfs_commit_inode_delayed_inode+0x104/0x160
fs/btrfs/delayed-inode.c:1201
       btrfs_log_inode+0x438/0x1ab0 fs/btrfs/tree-log.c:5385
       btrfs_log_inode_parent+0x272/0x1110 fs/btrfs/tree-log.c:6168
       btrfs_log_dentry_safe+0x3a/0x50 fs/btrfs/tree-log.c:6269
       btrfs_sync_file+0x2cd/0x760 fs/btrfs/file.c:2264
       vfs_fsync_range+0x48/0xa0 fs/sync.c:200
       generic_write_sync include/linux/fs.h:2955 [inline]
       btrfs_file_write_iter+0x34f/0x510 fs/btrfs/file.c:2034
       call_write_iter include/linux/fs.h:2163 [inline]
       new_sync_write+0x18d/0x260 fs/read_write.c:507
       vfs_write+0x43b/0x4a0 fs/read_write.c:594
       ksys_write+0xd2/0x120 fs/read_write.c:647
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-tree-01/1);
                               lock(&delayed_node->mutex);
                               lock(btrfs-tree-01/1);
  lock(&delayed_node->mutex);

 *** DEADLOCK ***

6 locks held by syz-executor/16884:
 #0: ffff888104f336f0 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0x55/0x60 fs/file.c:990
 #1: ffff88811394b460 (sb_writers#18){.+.+}-{0:0}, at:
ksys_write+0xd2/0x120 fs/read_write.c:647
 #2: ffff888110cfab70 (&sb->s_type->i_mutex_key#26){++++}-{3:3}, at:
inode_lock include/linux/fs.h:786 [inline]
 #2: ffff888110cfab70 (&sb->s_type->i_mutex_key#26){++++}-{3:3}, at:
btrfs_inode_lock+0x65/0xb0 fs/btrfs/inode.c:126
 #3: ffff888110cfa9f8 (&ei->i_mmap_lock){+.+.}-{3:3}, at:
btrfs_inode_lock+0x80/0xb0 fs/btrfs/inode.c:129
 #4: ffff88811394b650 (sb_internal#2){.+.+}-{0:0}, at:
btrfs_sync_file+0x29e/0x760 fs/btrfs/file.c:2257
 #5: ffff888016e696e8 (btrfs-tree-01/1){+.+.}-{3:3}, at:
__btrfs_tree_lock+0x2e/0x1a0 fs/btrfs/locking.c:112

stack backtrace:
CPU: 1 PID: 16884 Comm: syz-executor Not tainted 5.15.0-rc1+ #19
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
 check_noncircular+0x105/0x120 kernel/locking/lockdep.c:2131
 check_prev_add kernel/locking/lockdep.c:3051 [inline]
 check_prevs_add kernel/locking/lockdep.c:3174 [inline]
 validate_chain kernel/locking/lockdep.c:3789 [inline]
 __lock_acquire+0x161f/0x1d60 kernel/locking/lockdep.c:5015
 lock_acquire+0x1f9/0x340 kernel/locking/lockdep.c:5625
 __mutex_lock_common kernel/locking/mutex.c:596 [inline]
 __mutex_lock+0x98/0xa50 kernel/locking/mutex.c:729
 __btrfs_release_delayed_node+0x4e/0x410 fs/btrfs/delayed-inode.c:262
 btrfs_release_delayed_node fs/btrfs/delayed-inode.c:287 [inline]
 btrfs_commit_inode_delayed_inode+0x104/0x160 fs/btrfs/delayed-inode.c:1201
 btrfs_log_inode+0x438/0x1ab0 fs/btrfs/tree-log.c:5385
 btrfs_log_inode_parent+0x272/0x1110 fs/btrfs/tree-log.c:6168
 btrfs_log_dentry_safe+0x3a/0x50 fs/btrfs/tree-log.c:6269
 btrfs_sync_file+0x2cd/0x760 fs/btrfs/file.c:2264
 vfs_fsync_range+0x48/0xa0 fs/sync.c:200
 generic_write_sync include/linux/fs.h:2955 [inline]
 btrfs_file_write_iter+0x34f/0x510 fs/btrfs/file.c:2034
 call_write_iter include/linux/fs.h:2163 [inline]
 new_sync_write+0x18d/0x260 fs/read_write.c:507
 vfs_write+0x43b/0x4a0 fs/read_write.c:594
 ksys_write+0xd2/0x120 fs/read_write.c:647
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46ae99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f685738cc48 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
RDX: 000000000000000b RSI: 0000000020005940 RDI: 0000000000000003
RBP: 00007f685738cc80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000001e
R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffc71ddb640
