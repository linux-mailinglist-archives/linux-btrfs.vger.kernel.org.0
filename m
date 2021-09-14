Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE54440A435
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 05:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbhINDO2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 23:14:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:45857 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238399AbhINDO1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 23:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631589184;
        bh=FDcCglNkPZz4lASQT4DoL1Od/4u3h98G0g5mE85ynXs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KpXPJqy5/3BE9lS7+d+QFBzcKQUVcJOiGH9oajCFmwGzO/MZNlMfjzrjTsk9o9xKD
         MqMLYOuGOsib7KTpcHKIczZ9oQnAdYHoqwqzZV7crG1hMY8MI/ZCUegTCh+XtlzCrz
         KEh9WcJmUcrAcxaY+KgBq+FVeuI2eFSot6mSW+Y0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7Jza-1mXfyV2MJw-007hfF; Tue, 14
 Sep 2021 05:13:04 +0200
Subject: Re: INFO: task hung in btrfs_alloc_tree_block
To:     Hao Sun <sunhao.th@gmail.com>, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <CACkBjsZuFQykH=vQmy0n_mE1ACpiy1t48dvbUT0wtfBuHC4RFw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <1ffc5484-b68e-22db-349c-d1e0c31f9562@gmx.com>
Date:   Tue, 14 Sep 2021 11:12:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACkBjsZuFQykH=vQmy0n_mE1ACpiy1t48dvbUT0wtfBuHC4RFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i3Iwal3Ics6jUCLEHp+ie27Z6e+fkOsLBH0kAKyN/CkeH+wyw8N
 fJuY7pbj/3Yhkwp9/YIi4ghfINU41kao4WWl00agxnWXBhG3ruPj5bG845fW9pL/OZVk8U5
 gpppp+bu6hBWd0cQivVFxWSAxjqdUP7NvnJpV2AoFKSs7eJ1+DBaCNM3C7NZPcfgVJYXMPf
 j7BQhO8lFEQojRaz/caew==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4XwKJHGVDpI=:6D8NCuLnyW+Pztqer8wQE7
 kKBjqcogNwGMTey6srCWLE5dxgNAW3E2i7mSV2rVB1bM5LFdkyJHSZcx8xrDVGGd9meZmygiB
 8T10qGowzo049EVZaOwm3H+dlUyxcKb12aweBvREs2X7ykxaRMSGaHf8/o9KyRf7rqqPsA8GL
 2GvJMao3SmeTK7TRmF78KQdWGsyG4/ncaUhO69sOhqiMWVZNSDOh8EweNGyl9tCkvAQNeqplO
 F77+PeHopYbrqRJehIMdfLT4p4R/trKRWI+oCuzyTpEIMunJQRV0z35uHN37nJAncjPt/yVFo
 C0p/DjU4CkygH/MKoLpaFghgZDkfkBVuvTpP+awayciiJ4WDoFNcCayj6Tzq12IdhthQL+L0M
 3fhiZ/Iet16G8ap54dfRCEZ5hqxe9q22P08GP5zNcuii+gtfJbhvBwPV8VpnhXexMhWGe0h5o
 mv4QtD8bs5zYOK4N8/JDJkRjjwpc1mlWOxRrcDsOL2RNXS5ITAnLjHixvA9o9qGJMY1yfaZYc
 g0cuzZRIzhynrFObGvKKxOm+QOcwYsY1O6FQgHIO9detlRxrGDmsIxSThdJPhYYFdl2DWVqRM
 lLs6xdTgHWIdYIn89dVvxOHnmLpzgsEgVcUulr9PoBivdltC6FhyerWCiBxJgYJkJoYVHF/pP
 M4768d33A7+15wyRNAwWSSrdcrFZJdYpoZkF5mICr78KwvpoeVYHJ2fLYgqO6I22E/k96qsDo
 0/QN5r6P2YaU5lr8EOdNxpTWPd9KjDy3ROJvpQt945kvjerPMdvSy77SNwyDRlttcFESBhAzB
 P14drUd+74zYDwi0/GLfV4pn0jz9ZPg+o40NLuwT9glg6MkU4BzjgS6jU1ZCbkDsBI++1vwYO
 rGjFDkqSnHdrmCEcOEBX25L1seqHZHLdC5n+OvSt5DYh+DXEZNBv2o/7zV2u68YpCr2eHj0l6
 cE4wWWyfXZtgXZ4WEnv00z2dujFhQIyPETS1fZk7Xjn7hHabUJ6CtZRjnGBkekLSxGJUpemMV
 7XMfDhTipBpeBcYreDRfD/l1hp5X/WnkXFQ0ApQPZRSJeE8U3I3hd6cuKmUEPMNd7Tc4dIYlf
 3VtTe+WglBhKpjLPHKejx/yHhjr+/bk8ELRO3rrTB8Y+aZNDvLalZG64kNxl9XyeFFpgNLdHG
 1Fc6xf522CYbOAI6jBid/q0hoW
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/14 =E4=B8=8A=E5=8D=8810:44, Hao Sun wrote:
> Hello,
>
> When using Healer to fuzz the latest Linux kernel, the following crash
> was triggered.
>
> HEAD commit: 6880fa6c5660 Linux 5.15-rc1
> git tree: upstream
> console output:
> https://drive.google.com/file/d/1U3ei_jCODG9N5UHOspSRmykrEDSey3Qn/view?u=
sp=3Dsharing
> kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHTLJ=
vsUdWcgB/view?usp=3Dsharing

Any recorded info for the injected errors during the test?

It's hanging on a tree lock, without knowing the error injected, it's
really hard to find out what's the cause.

Thanks,
Qu
>
> Sorry, I don't have a reproducer for this crash, hope the symbolized
> report can help.
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Hao Sun <sunhao.th@gmail.com>
>
> INFO: task syz-executor:6566 blocked for more than 143 seconds.
>        Not tainted 5.15.0-rc1 #16
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message=
.
> task:syz-executor    state:D stack:10632 pid: 6566 ppid:     1 flags:0x0=
0004004
> Call Trace:
>   context_switch kernel/sched/core.c:4940 [inline]
>   __schedule+0x323/0xae0 kernel/sched/core.c:6287
>   schedule+0x36/0xe0 kernel/sched/core.c:6366
>   rwsem_down_write_slowpath kernel/locking/rwsem.c:1107 [inline]
>   __down_write_common.part.13+0x356/0x7a0 kernel/locking/rwsem.c:1262
>   __btrfs_tree_lock+0x2e/0x1a0 fs/btrfs/locking.c:112
>   btrfs_init_new_buffer fs/btrfs/extent-tree.c:4740 [inline]
>   btrfs_alloc_tree_block+0x19c/0x670 fs/btrfs/extent-tree.c:4818
>   __btrfs_cow_block+0x16f/0x7d0 fs/btrfs/ctree.c:415
>   btrfs_cow_block+0x12a/0x300 fs/btrfs/ctree.c:570
>   btrfs_search_slot+0x6b0/0xee0 fs/btrfs/ctree.c:1768
>   btrfs_update_root+0x6b/0x430 fs/btrfs/root-tree.c:134
>   commit_fs_roots+0x151/0x220 fs/btrfs/transaction.c:1373
>   btrfs_commit_transaction+0x443/0x1430 fs/btrfs/transaction.c:2265
>   btrfs_sync_fs+0x9a/0x430 fs/btrfs/super.c:1426
>   __sync_filesystem fs/sync.c:39 [inline]
>   sync_filesystem+0x9b/0xd0 fs/sync.c:67
>   generic_shutdown_super+0x30/0x170 fs/super.c:448
>   kill_anon_super+0x15/0x30 fs/super.c:1057
>   btrfs_kill_super+0x19/0x30 fs/btrfs/super.c:2348
>   deactivate_locked_super+0x43/0x80 fs/super.c:335
>   deactivate_super+0x53/0x80 fs/super.c:366
>   cleanup_mnt+0x138/0x1b0 fs/namespace.c:1137
>   task_work_run+0x86/0xd0 kernel/task_work.c:164
>   tracehook_notify_resume include/linux/tracehook.h:189 [inline]
>   exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
>   exit_to_user_mode_prepare+0x271/0x280 kernel/entry/common.c:209
>   __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
>   syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
>   do_syscall_64+0x40/0xb0 arch/x86/entry/common.c:86
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x46c777
> RSP: 002b:00007ffc3accc0b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000046c777
> RDX: 0000000000404e22 RSI: 0000000000000002 RDI: 00007ffc3accc180
> RBP: 00007ffc3accc180 R08: 00000000025c8033 R09: 0000000000000009
> R10: 00000000fffffffb R11: 0000000000000246 R12: 00000000004e38c6
> R13: 00007ffc3accd230 R14: 00007ffc3accd22c R15: 0000000000000006
> INFO: lockdep is turned off.
> NMI backtrace for cpu 1
> CPU: 1 PID: 39 Comm: khungtaskd Not tainted 5.15.0-rc1 #16
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> Call Trace:
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
>   nmi_cpu_backtrace+0x1e9/0x210 lib/nmi_backtrace.c:105
>   nmi_trigger_cpumask_backtrace+0x120/0x180 lib/nmi_backtrace.c:62
>   trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
>   check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
>   watchdog+0x4e1/0x980 kernel/hung_task.c:295
>   kthread+0x178/0x1b0 kernel/kthread.c:319
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> Sending NMI from CPU 1 to CPUs 0,2-3:
> NMI backtrace for cpu 2 skipped: idling at native_safe_halt
> arch/x86/include/asm/irqflags.h:51 [inline]
> NMI backtrace for cpu 2 skipped: idling at arch_safe_halt
> arch/x86/include/asm/irqflags.h:89 [inline]
> NMI backtrace for cpu 2 skipped: idling at default_idle+0xb/0x10
> arch/x86/kernel/process.c:716
> NMI backtrace for cpu 0
> CPU: 0 PID: 3014 Comm: systemd-journal Not tainted 5.15.0-rc1 #16
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> RIP: 0010:__seccomp_filter+0x29/0x890 kernel/seccomp.c:1173
> Code: 00 41 57 41 56 49 89 f6 41 55 41 54 55 53 48 83 ec 60 65 48 8b
> 04 25 28 00 00 00 48 89 44 24 58 31 c0 89 7c 24 08 89 54 24 0c <e8> 62
> b3 ff ff 4d 85 f6 0f 84 ed 03 00 00 e8 54 b3 ff ff 65 48 8b
> RSP: 0018:ffffc900008a3e50 EFLAGS: 00000246
> RAX: 0000000000000000 RBX: ffff888104294480 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000027
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000027
> R13: 0000000000000002 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f0e1f6808c0(0000) GS:ffff88807dc00000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f0e1cac7000 CR3: 000000000e6b1000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>   __secure_computing+0x66/0x150 kernel/seccomp.c:1311
>   syscall_trace_enter.isra.17+0x9c/0x270 kernel/entry/common.c:68
>   do_syscall_64+0x15/0xb0 arch/x86/entry/common.c:76
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f0e1e919f17
> Code: ff ff ff 48 8b 4d a0 0f b7 51 fe 48 8b 4d a8 66 89 54 08 fe e9
> 1a ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 b8 27 00 00 00 0f 05 <c3> 0f
> 1f 84 00 00 00 00 00 b8 6e 00 00 00 0f 05 c3 0f 1f 84 00 00
> RSP: 002b:00007ffd23799818 EFLAGS: 00000206 ORIG_RAX: 0000000000000027
> RAX: ffffffffffffffda RBX: 00005565147301e0 RCX: 00007f0e1e919f17
> RDX: 00007ffd237998d8 RSI: 0000000000000001 RDI: 00005565147301e0
> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000069 R11: 0000000000000206 R12: 00007ffd237998d8
> R13: 0000000000000bc6 R14: 00007ffd2379c6c0 R15: 00007ffd23799cd0
> NMI backtrace for cpu 3 skipped: idling at native_safe_halt
> arch/x86/include/asm/irqflags.h:51 [inline]
> NMI backtrace for cpu 3 skipped: idling at arch_safe_halt
> arch/x86/include/asm/irqflags.h:89 [inline]
> NMI backtrace for cpu 3 skipped: idling at default_idle+0xb/0x10
> arch/x86/kernel/process.c:716
> ----------------
> Code disassembly (best guess):
>     0: 00 41 57              add    %al,0x57(%rcx)
>     3: 41 56                push   %r14
>     5: 49 89 f6              mov    %rsi,%r14
>     8: 41 55                push   %r13
>     a: 41 54                push   %r12
>     c: 55                    push   %rbp
>     d: 53                    push   %rbx
>     e: 48 83 ec 60          sub    $0x60,%rsp
>    12: 65 48 8b 04 25 28 00 mov    %gs:0x28,%rax
>    19: 00 00
>    1b: 48 89 44 24 58        mov    %rax,0x58(%rsp)
>    20: 31 c0                xor    %eax,%eax
>    22: 89 7c 24 08          mov    %edi,0x8(%rsp)
>    26: 89 54 24 0c          mov    %edx,0xc(%rsp)
> * 2a: e8 62 b3 ff ff        callq  0xffffb391 <-- trapping instruction
>    2f: 4d 85 f6              test   %r14,%r14
>    32: 0f 84 ed 03 00 00    je     0x425
>    38: e8 54 b3 ff ff        callq  0xffffb391
>    3d: 65                    gs
>    3e: 48                    rex.W
>    3f: 8b                    .byte 0x8b
>
