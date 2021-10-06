Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1D1423A5C
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 11:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237817AbhJFJSu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 05:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbhJFJSs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Oct 2021 05:18:48 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF11AC061749;
        Wed,  6 Oct 2021 02:16:55 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id g2so1819966pfc.6;
        Wed, 06 Oct 2021 02:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=JP0pUY95KZnuobgYEEb2U+8XVZ8Oseboec/ZwdVVqLw=;
        b=kGCagz32NpFZPM3zxQAv7hh1VhZ7cjdLeFC6b/ckmVsGrgb+2fN7W1jQDiBeirpREx
         rfgN00JLQ2JVzUkpD+xF6BExzQEQLkQoMZxa4qJcidVaXVieSXnt3wOV5qLvNqd5A4Q9
         O/TKafgE18duebMybUYDopo7ZFIvvt7ez3z9uU7NPBdaCEVtDCap93k/mR1vkI/3Y4gE
         sJxqHqLxcU91szL761ezohl60SjKADbXUbmH7heGLVV8EKhrVysgq9RjM4zd21EC/fLP
         AXTOjWAAiYZ2hc10mVBwSue4dhxs6yDaZnXFSvbcsBFvLz/04fmotz1kOxta7t3KIJda
         IeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JP0pUY95KZnuobgYEEb2U+8XVZ8Oseboec/ZwdVVqLw=;
        b=So9GKAavVaY4y1tMyRezM3P1BquqKqd+06jIaq5MULOtVcn5m2v8PLg54RCnGUFd10
         47dWQ8SkFXSRUI+VuKDEC+ELivFmFMO1TSTvkSKOi8/xSsTkqdpjeyWsb/rJdMfWbYWM
         R0fJGDCgxuKORVaXdq47UaF3SeVC5BIYtr2OvshtCJKYCg/QdoP88O+T3FDOg9mm+oQH
         q3Q06O5QH1qLeV0AK5cUgILTBDIHahtcpNTWxFtEcs17sh3ZoMbKsxyP7DJrkeuZ61t9
         7HaqIrieRQUqMNaXNOKN4fIDuWBBikRkSGR3nC4Ywy722wQjjRnUOUZDBzvhP/NvRvWD
         EiVQ==
X-Gm-Message-State: AOAM532HiUo5UbrcMqIhD1ySuPdSsaLvINAnqewnkHlcGcHiSSp9LaNO
        EAVyVmJoVJldRDMD/5yfMAMn/oYebhjQJIoqPA==
X-Google-Smtp-Source: ABdhPJxHfaWs6z+KPkkQ6NyL0opVNThi/cFlkk++bb08wOoSfeJJY0Ph/NbrQoPeTbpGYrYHen58s5ucrdOuU1Qqns0=
X-Received: by 2002:aa7:83d9:0:b0:44c:915b:8268 with SMTP id
 j25-20020aa783d9000000b0044c915b8268mr4411439pfn.43.1633511815069; Wed, 06
 Oct 2021 02:16:55 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 6 Oct 2021 17:16:44 +0800
Message-ID: <CACkBjsax51i4mu6C0C3vJqQN3NR_iVuucoeG3U1HXjrgzn5FFQ@mail.gmail.com>
Subject: INFO: task hung in btrfs_search_slot
To:     clm@fb.com, Josef Bacik <josef@toxicpanda.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 42d43c92fc57  Merge branch 'for-linus'
git tree: upstream
console output:
https://drive.google.com/file/d/1tXcyVVsGgK8Q0E1C7fWznV_-nkc-veLP/view?usp=sharing
kernel config: https://drive.google.com/file/d/15vWoQRbJuuMu4ovWhUm1h4SrHyNwK8im/view?usp=sharing

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

INFO: task kworker/u9:5:546 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc3+ #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u9:5    state:D stack:25936 pid:  546 ppid:     2 flags:0x00004000
Workqueue: events_unbound btrfs_async_reclaim_metadata_space
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 rwsem_down_read_slowpath+0x4ee/0x9d0 kernel/locking/rwsem.c:993
 __down_read_common kernel/locking/rwsem.c:1214 [inline]
 __down_read kernel/locking/rwsem.c:1223 [inline]
 down_read_nested+0xe6/0x440 kernel/locking/rwsem.c:1590
 __btrfs_tree_read_lock+0x31/0x350 fs/btrfs/locking.c:47
 btrfs_tree_read_lock fs/btrfs/locking.c:54 [inline]
 btrfs_read_lock_root_node+0x8a/0x320 fs/btrfs/locking.c:191
 btrfs_search_slot_get_root fs/btrfs/ctree.c:1623 [inline]
 btrfs_search_slot+0x13b4/0x2140 fs/btrfs/ctree.c:1728
 btrfs_update_device+0x11f/0x500 fs/btrfs/volumes.c:2794
 btrfs_chunk_alloc_add_chunk_item+0x34d/0xea0 fs/btrfs/volumes.c:5504
 do_chunk_alloc fs/btrfs/block-group.c:3408 [inline]
 btrfs_chunk_alloc+0x84d/0xf50 fs/btrfs/block-group.c:3653
 flush_space+0x54e/0xd80 fs/btrfs/space-info.c:670
 btrfs_async_reclaim_metadata_space+0x396/0xa90 fs/btrfs/space-info.c:953
 process_one_work+0x9df/0x16d0 kernel/workqueue.c:2297
 worker_thread+0x90/0xed0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
INFO: task syz-executor:9107 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc3+ #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:23200 pid: 9107 ppid:  7792 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xc96/0x1680 kernel/locking/mutex.c:729
 btrfs_chunk_alloc+0x31a/0xf50 fs/btrfs/block-group.c:3631
 find_free_extent_update_loop fs/btrfs/extent-tree.c:3986 [inline]
 find_free_extent+0x25cb/0x3a30 fs/btrfs/extent-tree.c:4335
 btrfs_reserve_extent+0x1f1/0x500 fs/btrfs/extent-tree.c:4415
 btrfs_alloc_tree_block+0x203/0x1120 fs/btrfs/extent-tree.c:4813
 __btrfs_cow_block+0x412/0x1620 fs/btrfs/ctree.c:415
 btrfs_cow_block+0x2f6/0x8c0 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x1094/0x2140 fs/btrfs/ctree.c:1768
 relocate_tree_block fs/btrfs/relocation.c:2694 [inline]
 relocate_tree_blocks+0xf73/0x1770 fs/btrfs/relocation.c:2757
 relocate_block_group+0x47e/0xc70 fs/btrfs/relocation.c:3673
 btrfs_relocate_block_group+0x48a/0xc60 fs/btrfs/relocation.c:4070
 btrfs_relocate_chunk+0x96/0x280 fs/btrfs/volumes.c:3181
 __btrfs_balance fs/btrfs/volumes.c:3911 [inline]
 btrfs_balance+0x1f03/0x3cd0 fs/btrfs/volumes.c:4301
 btrfs_ioctl_balance+0x61e/0x800 fs/btrfs/ioctl.c:4137
 btrfs_ioctl+0x39ea/0x7b70 fs/btrfs/ioctl.c:4949
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fd5cf992c4d
RSP: 002b:00007fd5ccefac58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fd5cfab90a0 RCX: 00007fd5cf992c4d
RDX: 0000000000000000 RSI: 000000005000940c RDI: 0000000000000008
RBP: 00007fd5cfa0bd80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd5cfab90a0
R13: 00007fff3b868b6f R14: 00007fff3b868d10 R15: 00007fd5ccefadc0
INFO: lockdep is turned off.
NMI backtrace for cpu 1
CPU: 1 PID: 39 Comm: khungtaskd Not tainted 5.15.0-rc3+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1e1/0x220 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace ./include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xcc8/0x1010 kernel/hung_task.c:295
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 1 to CPUs 0,2-3:
NMI backtrace for cpu 2
CPU: 2 PID: 11380 Comm: vivid-008-vid-c Not tainted 5.15.0-rc3+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:85 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:102 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:128 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:159 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0xe0/0x1b0 mm/kasan/generic.c:189
Code: f2 48 85 c0 41 b8 01 00 00 00 75 6b 5b 44 89 c0 5d 41 5c c3 4d
85 c9 74 4d 49 01 d9 eb 09 48 83 c0 01 4c 39 c8 74 3f 80 38 00 <74> f2
eb d3 41 bc 08 00 00 00 45 29 c4 49 89 d8 4d 8d 0c 1c eb 0c
RSP: 0018:ffffc9000973fbd0 EFLAGS: 00000046
RAX: fffffbfff1adaf8a RBX: fffffbfff1adaf8a RCX: ffffffff815b9748
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff8d6d7c50
RBP: fffffbfff1adaf8b R08: 0000000000000000 R09: fffffbfff1adaf8b
R10: ffffffff8d6d7c57 R11: fffffbfff1adaf8a R12: 0000000000000002
R13: ffffffff8b97e9e0 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555680de88 CR3: 000000010452e000 CR4: 0000000000350ee0
Call Trace:
 instrument_atomic_read ./include/linux/instrumented.h:71 [inline]
 test_bit ./include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
 cpumask_test_cpu ./include/linux/cpumask.h:344 [inline]
 cpu_online ./include/linux/cpumask.h:895 [inline]
 trace_lock_acquire ./include/trace/events/lock.h:13 [inline]
 lock_acquire+0xb8/0x520 kernel/locking/lockdep.c:5596
 rcu_lock_acquire ./include/linux/rcupdate.h:267 [inline]
 rcu_read_lock ./include/linux/rcupdate.h:687 [inline]
 cgroup_account_cputime ./include/linux/cgroup.h:794 [inline]
 update_curr+0x31a/0x850 kernel/sched/fair.c:853
 pick_next_task_fair+0x22b/0xce0 kernel/sched/fair.c:7292
 __pick_next_task kernel/sched/core.c:5561 [inline]
 pick_next_task kernel/sched/core.c:6103 [inline]
 __schedule+0x70c/0x2530 kernel/sched/core.c:6251
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 vivid_thread_vid_cap+0x6d4/0xb10
drivers/media/test-drivers/vivid/vivid-kthread-cap.c:895
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
NMI backtrace for cpu 3 skipped: idling at native_safe_halt
./arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 3 skipped: idling at arch_safe_halt
./arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 3 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:716
NMI backtrace for cpu 0
CPU: 0 PID: 6542 Comm: rs:main Q:Reg Not tainted 5.15.0-rc3+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:percpu_counter_read_positive
./include/linux/percpu_counter.h:83 [inline]
RIP: 0010:ext4_nonda_switch+0x64/0x1f0 fs/ext4/inode.c:2917
Code: 00 48 b8 00 00 00 00 00 fc ff df 48 8d bd 20 01 00 00 48 89 fa
48 c1 ea 03 80 3c 02 00 0f 85 87 01 00 00 48 8b 9d 20 01 00 00 <48> 8d
bd 40 02 00 00 b8 00 00 00 00 48 89 fa 48 85 db 48 0f 48 d8
RSP: 0018:ffffc900017af958 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: 000000000004fd28 RCX: ffff888024db8000
RDX: 1ffff11002579424 RSI: ffff888024db8000 RDI: ffff888012bca120
RBP: ffff888012bca000 R08: ffffffff821269c0 R09: 0000000000000000
R10: 0000000000000007 R11: ffffed1002579470 R12: ffff888012bc8000
R13: 0000000000000000 R14: ffff888012bca000 R15: ffff88801b724a90
FS:  00007f9c17a91700(0000) GS:ffff888063e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f613a848ab4 CR3: 00000000167ff000 CR4: 0000000000350ef0
Call Trace:
 ext4_da_write_begin+0x177/0x1180 fs/ext4/inode.c:2963
 generic_perform_write+0x1fe/0x510 mm/filemap.c:3770
 ext4_buffered_write_iter+0x206/0x4c0 fs/ext4/file.c:269
 ext4_file_write_iter+0x42e/0x14a0 fs/ext4/file.c:680
 call_write_iter ./include/linux/fs.h:2163 [inline]
 new_sync_write+0x432/0x660 fs/read_write.c:507
 vfs_write+0x67a/0xae0 fs/read_write.c:594
 ksys_write+0x12d/0x250 fs/read_write.c:647
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f9c1a4d51cd
Code: c2 20 00 00 75 10 b8 01 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31
c3 48 83 ec 08 e8 ae fc ff ff 48 89 04 24 b8 01 00 00 00 0f 05 <48> 8b
3c 24 48 89 c2 e8 f7 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007f9c17a90590 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f9c0800ad60 RCX: 00007f9c1a4d51cd
RDX: 0000000000000514 RSI: 00007f9c0800ad60 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f9c1962f297
R10: 0000000000000000 R11: 0000000000000293 R12: 00007f9c0800aae0
R13: 00007f9c17a905b0 R14: 0000558fb1d7a360 R15: 0000000000000514
----------------
Code disassembly (best guess):
   0: f2 48 85 c0          repnz test %rax,%rax
   4: 41 b8 01 00 00 00    mov    $0x1,%r8d
   a: 75 6b                jne    0x77
   c: 5b                    pop    %rbx
   d: 44 89 c0              mov    %r8d,%eax
  10: 5d                    pop    %rbp
  11: 41 5c                pop    %r12
  13: c3                    retq
  14: 4d 85 c9              test   %r9,%r9
  17: 74 4d                je     0x66
  19: 49 01 d9              add    %rbx,%r9
  1c: eb 09                jmp    0x27
  1e: 48 83 c0 01          add    $0x1,%rax
  22: 4c 39 c8              cmp    %r9,%rax
  25: 74 3f                je     0x66
  27: 80 38 00              cmpb   $0x0,(%rax)
* 2a: 74 f2                je     0x1e <-- trapping instruction
  2c: eb d3                jmp    0x1
  2e: 41 bc 08 00 00 00    mov    $0x8,%r12d
  34: 45 29 c4              sub    %r8d,%r12d
  37: 49 89 d8              mov    %rbx,%r8
  3a: 4d 8d 0c 1c          lea    (%r12,%rbx,1),%r9
  3e: eb 0c                jmp    0x4c
