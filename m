Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B0143BED6
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 03:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbhJ0BP7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Oct 2021 21:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbhJ0BP6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Oct 2021 21:15:58 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F14C061570;
        Tue, 26 Oct 2021 18:13:34 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id oa4so806791pjb.2;
        Tue, 26 Oct 2021 18:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cpbXfaujGQZZrMSjY13IovM15SN+jLVHfNh23KEBjCY=;
        b=D4rlDYy0U1uqRpnnrortPCA46izWpvMwXgkXWlbSRcDpc5tbaQ2vLBdJNROyZvKP+T
         +Cb152rw9t/NbGVptM98zTgbO2jzaQGF+KOXS7srePTVBt8X+w+J/h0KeFq4jbVpCuXz
         vNUqccHuu7rYsSIoYy04QK61z1qUqfT2f+sJRUPNWIVtqoQ5+KnifhVQJ5QRxYkBSENb
         yX0HH6+o4JecY7zZbn/ahtwz8irvOhVoJ1ElRkRDEqtG19tw5h4ftaJYhAaFSToRPZh3
         abDLq8pmd76rRyLS8brFSaTHZRhQM4Bw3WcDhKTLezS+8GaotLDf1ZEugY6O42AjT4RL
         pJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cpbXfaujGQZZrMSjY13IovM15SN+jLVHfNh23KEBjCY=;
        b=fZPmTu9Ka9Wd3PBVIYpCsDpMDtBZtyigV7fb5vpLRCATaelGVRIn3xyuSJ+1qCAl+0
         FHNKqOmvPOCiPIafcng3a2hks8x4OfB6VJdRuqJRZehRwxcj1Sls0/kEAQ+Uo/ZdNhQQ
         6G8y1PBteAmdLvUhhDUXKKqj3uVWRI9QJYSfT+/6Sv+c8eaP5wUgcevpur0Utk6Sbq4H
         OIVgt5hdbyJs0DBu1aiTz18uXvtRPaFwKOPHEVIccEVJOpAImy3ayNrvQU5dBdZ+FTgU
         ByN0t2+GOk8ekKoKb45jOS75aWqaOViGYJa0tQ2FlXrQ1D+uEmry7sPmw0XqN+xbMd+3
         jhjQ==
X-Gm-Message-State: AOAM530MmemsRdishsJ0kjOM4YRXnNdwz1rjsIOvnPhYReZMUUHl+Dry
        egPy6vipq8lfkfyeZeoYEgKI4ugbnusJ4PW8CA==
X-Google-Smtp-Source: ABdhPJxiSYuBJPCfltcTxd4SuMaei6KWJ2B0RgXw+bRpAinRy4p95GYixUrSRPOlBPXovRxPCdDvrvHqElJEkBWWZSE=
X-Received: by 2002:a17:90a:6b0b:: with SMTP id v11mr2499042pjj.178.1635297213442;
 Tue, 26 Oct 2021 18:13:33 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 27 Oct 2021 09:13:20 +0800
Message-ID: <CACkBjsYV8Xv7Ha-daGhkj+uOK31HSsdt06pgMOyQcYzcxUjSyw@mail.gmail.com>
Subject: INFO: task hung in btrfs_search_slot
To:     clm@fb.com, dsterba@suse.com, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 519d81956ee2 Linux 5.15-rc6
git tree: upstream
console output:
https://drive.google.com/file/d/1SFUNYlZ6tpKe9gvGXKAezMNUFOOjFFiA/view?usp=sharing
kernel config: https://drive.google.com/file/d/12PUnxIM1EPBgW4ZJmI7WJBRaY1lA83an/view?usp=sharing

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

INFO: task kworker/u9:4:1175 blocked for more than 143 seconds.
Not tainted 5.15.0-rc6 #4
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u9:4 state:D stack:23384 pid: 1175 ppid: 2 flags:0x00004000
Workqueue: events_unbound btrfs_async_reclaim_data_space
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
btrfs_async_reclaim_data_space+0x1b8/0x560 fs/btrfs/space-info.c:1168
process_one_work+0x9df/0x16d0 kernel/workqueue.c:2297
worker_thread+0x90/0xed0 kernel/workqueue.c:2444
kthread+0x3e5/0x4d0 kernel/kthread.c:319
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
INFO: task syz-executor:7761 blocked for more than 143 seconds.
Not tainted 5.15.0-rc6 #4
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor state:D stack:22264 pid: 7761 ppid: 6595 flags:0x00004004
Call Trace:
context_switch kernel/sched/core.c:4940 [inline]
__schedule+0xcd9/0x2530 kernel/sched/core.c:6287
schedule+0xd3/0x270 kernel/sched/core.c:6366
btrfs_commit_transaction+0x1f84/0x2e90 fs/btrfs/transaction.c:2174
btrfs_sync_file+0xd14/0x12a0 fs/btrfs/file.c:2297
vfs_fsync_range+0x13a/0x220 fs/sync.c:200
generic_write_sync include/linux/fs.h:2955 [inline]
btrfs_file_write_iter+0xa3a/0xe30 fs/btrfs/file.c:2033
call_write_iter include/linux/fs.h:2163 [inline]
do_iter_readv_writev+0x47b/0x750 fs/read_write.c:729
do_iter_write fs/read_write.c:855 [inline]
do_iter_write+0x18b/0x700 fs/read_write.c:836
vfs_iter_write+0x70/0xa0 fs/read_write.c:896
iter_file_splice_write+0x723/0xbf0 fs/splice.c:689
do_splice_from fs/splice.c:767 [inline]
direct_splice_actor+0x110/0x180 fs/splice.c:936
splice_direct_to_actor+0x34b/0x8c0 fs/splice.c:891
do_splice_direct+0x1b3/0x280 fs/splice.c:979
do_sendfile+0xab6/0x1240 fs/read_write.c:1249
__do_sys_sendfile64 fs/read_write.c:1308 [inline]
__se_sys_sendfile64 fs/read_write.c:1300 [inline]
__x64_sys_sendfile64+0x149/0x210 fs/read_write.c:1300
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f75f1b61c4d
RSP: 002b:00007f75ef0a8c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f75f1c88158 RCX: 00007f75f1b61c4d
RDX: 0000000020006c80 RSI: 0000000000000003 RDI: 0000000000000003
RBP: 00007f75f1bdad80 R08: 0000000000000000 R09: 0000000000000000
R10: 00008080ffffff80 R11: 0000000000000246 R12: 00007f75f1c88158
R13: 00007ffe952bc34f R14: 00007ffe952bc4f0 R15: 00007f75ef0a8dc0
INFO: task syz-executor:7762 blocked for more than 143 seconds.
Not tainted 5.15.0-rc6 #4
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor state:D stack:23248 pid: 7762 ppid: 6595 flags:0x00004004
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
RIP: 0033:0x7f75f1b61c4d
RSP: 002b:00007f75ef087c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f75f1c88210 RCX: 00007f75f1b61c4d
RDX: 0000000000000000 RSI: 000000005000940c RDI: 0000000000000003
RBP: 00007f75f1bdad80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f75f1c88210
R13: 00007ffe952bc34f R14: 00007ffe952bc4f0 R15: 00007f75ef087dc0
INFO: task syz-executor:7763 blocked for more than 143 seconds.
Not tainted 5.15.0-rc6 #4
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor state:D stack:27944 pid: 7763 ppid: 6595 flags:0x00004004
Call Trace:
context_switch kernel/sched/core.c:4940 [inline]
__schedule+0xcd9/0x2530 kernel/sched/core.c:6287
schedule+0xd3/0x270 kernel/sched/core.c:6366
wait_current_trans+0x308/0x430 fs/btrfs/transaction.c:534
start_transaction+0x100d/0x1730 fs/btrfs/transaction.c:676
btrfs_create+0x111/0x630 fs/btrfs/inode.c:6775
lookup_open+0xfae/0x13a0 fs/namei.c:3282
open_last_lookups fs/namei.c:3352 [inline]
path_openat+0xa93/0x2710 fs/namei.c:3558
do_filp_open+0x1c1/0x290 fs/namei.c:3588
do_sys_openat2+0x61b/0x9a0 fs/open.c:1200
do_sys_open+0xc3/0x140 fs/open.c:1216
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f75f1b61c4d
RSP: 002b:00007f75ef066c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f75f1c882c8 RCX: 00007f75f1b61c4d
RDX: 000000000000011b RSI: 0000000000141042 RDI: 0000000020005940
RBP: 00007f75f1bdad80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f75f1c882c8
R13: 00007ffe952bc34f R14: 00007ffe952bc4f0 R15: 00007f75ef066dc0
INFO: lockdep is turned off.
NMI backtrace for cpu 2
CPU: 2 PID: 39 Comm: khungtaskd Not tainted 5.15.0-rc6 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:105
nmi_trigger_cpumask_backtrace+0x1e1/0x220 lib/nmi_backtrace.c:62
trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
watchdog+0xcc8/0x1010 kernel/hung_task.c:295
kthread+0x3e5/0x4d0 kernel/kthread.c:319
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 2 to CPUs 0-1,3:
NMI backtrace for cpu 3
CPU: 3 PID: 3016 Comm: systemd-journal Not tainted 5.15.0-rc6 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:on_stack arch/x86/include/asm/stacktrace.h:45 [inline]
RIP: 0010:unwind_next_frame+0x1034/0x1770 arch/x86/kernel/unwind_orc.c:604
Code: 8e 98 03 00 00 41 39 2e 0f 85 8f 00 00 00 48 b8 00 00 00 00 00
fc ff df 48 8b 14 24 48 c1 ea 03 80 3c 02 00 0f 85 a6 03 00 00 <49> 8d
7e 08 49 8b 6e 38 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48
RSP: 0018:ffffc900017df608 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: 1ffff920002fbec9 RCX: 1ffff920002fbee8
RDX: 1ffff920002fbee7 RSI: ffffc900017dff48 RDI: ffffc900017dff48
RBP: 0000000000000001 R08: ffffffff8e7f1bdc R09: 0000000000000001
R10: ffffc900017df75f R11: 0000000000086088 R12: ffffc900017dff58
R13: ffffc900017df735 R14: ffffc900017df700 R15: ffffc900017df734
FS: 00007f1d8194d8c0(0000) GS:ffff888135d00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1d7ed03000 CR3: 000000001b28a000 CR4: 0000000000350ee0
Call Trace:
arch_stack_walk+0x7d/0xe0 arch/x86/kernel/stacktrace.c:25
stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:121
kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
kasan_record_aux_stack+0xe9/0x110 mm/kasan/generic.c:348
task_work_add+0x3a/0x190 kernel/task_work.c:38
fput_many fs/file_table.c:341 [inline]
fput_many+0xeb/0x1a0 fs/file_table.c:334
path_openat+0x1b9d/0x2710 fs/namei.c:3570
do_filp_open+0x1c1/0x290 fs/namei.c:3588
do_sys_openat2+0x61b/0x9a0 fs/open.c:1200
do_sys_open+0xc3/0x140 fs/open.c:1216
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f1d80edd840
Code: 73 01 c3 48 8b 0d 68 77 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66
0f 1f 44 00 00 83 3d 89 bb 20 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e f6 ff ff 48 89 04 24
RSP: 002b:00007ffea39c6da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007ffea39c70b0 RCX: 00007f1d80edd840
RDX: 00000000000001a0 RSI: 0000000000080042 RDI: 00005622bad902e0
RBP: 000000000000000d R08: 0000000000000000 R09: 00000000ffffffff
R10: 0000000000000069 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00005622bad8c040 R14: 00007ffea39c7070 R15: 00005622bad98470
NMI backtrace for cpu 0 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 0 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 0 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:716
NMI backtrace for cpu 1 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 1 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:716
----------------
Code disassembly (best guess):
0: 8e 98 03 00 00 41 mov 0x41000003(%rax),%ds
6: 39 2e cmp %ebp,(%rsi)
8: 0f 85 8f 00 00 00 jne 0x9d
e: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
15: fc ff df
18: 48 8b 14 24 mov (%rsp),%rdx
1c: 48 c1 ea 03 shr $0x3,%rdx
20: 80 3c 02 00 cmpb $0x0,(%rdx,%rax,1)
24: 0f 85 a6 03 00 00 jne 0x3d0
* 2a: 49 8d 7e 08 lea 0x8(%r14),%rdi <-- trapping instruction
2e: 49 8b 6e 38 mov 0x38(%r14),%rbp
32: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
39: fc ff df
3c: 48 89 fa mov %rdi,%rdx
3f: 48 rex.W
