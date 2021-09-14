Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D084740A3CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 04:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbhINCqE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 22:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbhINCqD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 22:46:03 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A4EC061574;
        Mon, 13 Sep 2021 19:44:47 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id w19so6357507pfn.12;
        Mon, 13 Sep 2021 19:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=qZTDoKWjUVrHhi6g+OATSUlsfhBVuaOdE41ITJ/HY9E=;
        b=ObLqSDRz5pf0EdVYNCSTJFsaGJEa9wg6WOZjh1/ofOf6otrbysVsx06nCqTM4ruhxp
         UVft9gLmmjqHToU8WAa1mIUooF0le61WIrPXJfYTM+zOhayKN4d6dPjz7NcGRAFlpqGB
         mGrmvx1OnVFUtNLKw0oJCO8gb/WuGqVexURmjEXWzGbkJ3iNxQIk3XpHjFZoAlZynvFp
         exjoFdXVoNRzpSDFigVVEyK/H3K7azDiQCDxYbsP8L54cZ/Kr+ylPiOIorKGc1Nmw7iV
         gLn7JCxyISMJQQ4C0GBYWkjDpSAqeN/JkNiIFyglXY2YLQJAPHwhSSBxy3g9Q/ic1eD6
         QMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qZTDoKWjUVrHhi6g+OATSUlsfhBVuaOdE41ITJ/HY9E=;
        b=3H1VBmR89sbaMPXsxPQiA5K3Qvrs6mEZ4fPahsu9P7v9u5mTLuo6Uu+cVro5et2qrv
         l0VJ2amj+EBG9RW/HSmrAeoylhxzu4zpQczfxxFDFwZIaxNzggaRGqrlQukv6+qN9VEG
         5iPqN0hk2mClRZt3JglEREj9Jcrb34opQWtFsXeo4ArSqiql1RiqkfsXcVOdsyN3jBjK
         it4fI8SMfEgySDUL88NOSjq9WHl9wYB9cIbDF1+lJ4IB/5REP+6kJ9hwXICXlDRjcnM9
         g4OI3GInPub29B1+AdhE2QKGCfv3fbHwSUAtfvHdrCY++9E2sPbjNLDjPigXRCM42P1P
         UWMg==
X-Gm-Message-State: AOAM5316/hDYf/Du6eL4eEtICE2Nf5fPk4vtqiZhR3kR7Zwi5kkf5m+t
        64dnnaqu9kuiknxQOwfy1iDRMdzwuk97uxYsjA==
X-Google-Smtp-Source: ABdhPJxRNs/meKkYeLfMGX8+uCJhvjXEQrqcghlJg3qOijQ+KUBT2TXoYCzrFZ4SQQYiogYw1L6UdDOoK5rvIvN92k4=
X-Received: by 2002:a62:920b:0:b0:3ec:7912:82be with SMTP id
 o11-20020a62920b000000b003ec791282bemr2563999pfd.34.1631587486741; Mon, 13
 Sep 2021 19:44:46 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Tue, 14 Sep 2021 10:44:35 +0800
Message-ID: <CACkBjsZuFQykH=vQmy0n_mE1ACpiy1t48dvbUT0wtfBuHC4RFw@mail.gmail.com>
Subject: INFO: task hung in btrfs_alloc_tree_block
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 6880fa6c5660 Linux 5.15-rc1
git tree: upstream
console output:
https://drive.google.com/file/d/1U3ei_jCODG9N5UHOspSRmykrEDSey3Qn/view?usp=sharing
kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHTLJvsUdWcgB/view?usp=sharing

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

INFO: task syz-executor:6566 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc1 #16
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:10632 pid: 6566 ppid:     1 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0x323/0xae0 kernel/sched/core.c:6287
 schedule+0x36/0xe0 kernel/sched/core.c:6366
 rwsem_down_write_slowpath kernel/locking/rwsem.c:1107 [inline]
 __down_write_common.part.13+0x356/0x7a0 kernel/locking/rwsem.c:1262
 __btrfs_tree_lock+0x2e/0x1a0 fs/btrfs/locking.c:112
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4740 [inline]
 btrfs_alloc_tree_block+0x19c/0x670 fs/btrfs/extent-tree.c:4818
 __btrfs_cow_block+0x16f/0x7d0 fs/btrfs/ctree.c:415
 btrfs_cow_block+0x12a/0x300 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x6b0/0xee0 fs/btrfs/ctree.c:1768
 btrfs_update_root+0x6b/0x430 fs/btrfs/root-tree.c:134
 commit_fs_roots+0x151/0x220 fs/btrfs/transaction.c:1373
 btrfs_commit_transaction+0x443/0x1430 fs/btrfs/transaction.c:2265
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
RIP: 0033:0x46c777
RSP: 002b:00007ffc3accc0b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000046c777
RDX: 0000000000404e22 RSI: 0000000000000002 RDI: 00007ffc3accc180
RBP: 00007ffc3accc180 R08: 00000000025c8033 R09: 0000000000000009
R10: 00000000fffffffb R11: 0000000000000246 R12: 00000000004e38c6
R13: 00007ffc3accd230 R14: 00007ffc3accd22c R15: 0000000000000006
INFO: lockdep is turned off.
NMI backtrace for cpu 1
CPU: 1 PID: 39 Comm: khungtaskd Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
 nmi_cpu_backtrace+0x1e9/0x210 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x120/0x180 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0x4e1/0x980 kernel/hung_task.c:295
 kthread+0x178/0x1b0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 1 to CPUs 0,2-3:
NMI backtrace for cpu 2 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 2 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 2 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:716
NMI backtrace for cpu 0
CPU: 0 PID: 3014 Comm: systemd-journal Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:__seccomp_filter+0x29/0x890 kernel/seccomp.c:1173
Code: 00 41 57 41 56 49 89 f6 41 55 41 54 55 53 48 83 ec 60 65 48 8b
04 25 28 00 00 00 48 89 44 24 58 31 c0 89 7c 24 08 89 54 24 0c <e8> 62
b3 ff ff 4d 85 f6 0f 84 ed 03 00 00 e8 54 b3 ff ff 65 48 8b
RSP: 0018:ffffc900008a3e50 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff888104294480 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000027
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000027
R13: 0000000000000002 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f0e1f6808c0(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0e1cac7000 CR3: 000000000e6b1000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 __secure_computing+0x66/0x150 kernel/seccomp.c:1311
 syscall_trace_enter.isra.17+0x9c/0x270 kernel/entry/common.c:68
 do_syscall_64+0x15/0xb0 arch/x86/entry/common.c:76
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f0e1e919f17
Code: ff ff ff 48 8b 4d a0 0f b7 51 fe 48 8b 4d a8 66 89 54 08 fe e9
1a ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 b8 27 00 00 00 0f 05 <c3> 0f
1f 84 00 00 00 00 00 b8 6e 00 00 00 0f 05 c3 0f 1f 84 00 00
RSP: 002b:00007ffd23799818 EFLAGS: 00000206 ORIG_RAX: 0000000000000027
RAX: ffffffffffffffda RBX: 00005565147301e0 RCX: 00007f0e1e919f17
RDX: 00007ffd237998d8 RSI: 0000000000000001 RDI: 00005565147301e0
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000069 R11: 0000000000000206 R12: 00007ffd237998d8
R13: 0000000000000bc6 R14: 00007ffd2379c6c0 R15: 00007ffd23799cd0
NMI backtrace for cpu 3 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 3 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 3 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:716
----------------
Code disassembly (best guess):
   0: 00 41 57              add    %al,0x57(%rcx)
   3: 41 56                push   %r14
   5: 49 89 f6              mov    %rsi,%r14
   8: 41 55                push   %r13
   a: 41 54                push   %r12
   c: 55                    push   %rbp
   d: 53                    push   %rbx
   e: 48 83 ec 60          sub    $0x60,%rsp
  12: 65 48 8b 04 25 28 00 mov    %gs:0x28,%rax
  19: 00 00
  1b: 48 89 44 24 58        mov    %rax,0x58(%rsp)
  20: 31 c0                xor    %eax,%eax
  22: 89 7c 24 08          mov    %edi,0x8(%rsp)
  26: 89 54 24 0c          mov    %edx,0xc(%rsp)
* 2a: e8 62 b3 ff ff        callq  0xffffb391 <-- trapping instruction
  2f: 4d 85 f6              test   %r14,%r14
  32: 0f 84 ed 03 00 00    je     0x425
  38: e8 54 b3 ff ff        callq  0xffffb391
  3d: 65                    gs
  3e: 48                    rex.W
  3f: 8b                    .byte 0x8b
