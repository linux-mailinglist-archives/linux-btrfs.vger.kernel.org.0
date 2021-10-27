Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE3243BECF
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 03:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbhJ0BOO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Oct 2021 21:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbhJ0BON (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Oct 2021 21:14:13 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFFBC061570;
        Tue, 26 Oct 2021 18:11:49 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f8so787274plo.12;
        Tue, 26 Oct 2021 18:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=qzd+FKh/REvC8KJXQdoIT82TAynz1iQhvNdqmp1KxQM=;
        b=dq3oufjNGgSPQoz3cNfSg7oA1FfzTL7bCx0YakN9khlVqG4b16BmLTIj0CB01lrLdg
         fzDfW1O32u5zfT/Cprtd4oNM7rJpwAtD1hztm7oOmlTlEe45rqtMmgQrFKcg6z6aCtOa
         GjXgv+Hk5qr3uGhOUvQaX7sTNFLvuO6DnTs0HmsVbopBmCN7elYFJ2Z/+L1ooAUhpJrA
         +SH7zkezSCxMADm7xnoekHEtrdSJuK259eM1kWiAPJzRjl/0yjTJ4ynD9BhQX9pBBpi8
         3jZjZww7mdsumlGrMpRBzimPuTADE3JLfVphExR4aK9st3afAtOu9xdRpTLEWWj18r3x
         7tfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qzd+FKh/REvC8KJXQdoIT82TAynz1iQhvNdqmp1KxQM=;
        b=Qh7SSUft7sZc7KVV8kFb/wzmvZnMicYaoS3rD7X5UNWulPx9eLVHTiEL45vxRnsm/R
         qfPGkqywVi4Wf4/G4FbaIqgNQU/rdi1ZCo2/vCUYhKaTAUx0Wcjyd5hoAwIVtSk5MgxR
         Pqyz39UWdmJuv+lZFTP+6WkhprAAi4wMKSVUWzc7jG5oPCLtfjiHaRiKefB5P6xGGHC7
         8VQqHYH2HJDvb3ChXWADH17YIjs68VVXDsPrN+cp2h1Wt7Zg0S+LFgvV+t/mTIAqPQze
         aFNSChfnt2dDTFX1fO0DvxFSzvwHo1+9Lau9yrWdjcr3K6i1yY8+UmJmQLrUn3yajZYQ
         vXKQ==
X-Gm-Message-State: AOAM530LE8IqJfmc+3IOSzNiXQcgKKona8YfMcdnrSMdhbCjoZ8I52hC
        dyV11oH4UIIKciyjJv99g51bA9vufqi0Vyp5Ug==
X-Google-Smtp-Source: ABdhPJyH7GQ/mgHSrKjarrAOX5+DopkhZ3gk6IWIHcvJ8y1R2HSLRxoZs9NKwXIrCXx5+613GXgChBwsISr13EeLQsU=
X-Received: by 2002:a17:90a:430d:: with SMTP id q13mr2474586pjg.112.1635297108711;
 Tue, 26 Oct 2021 18:11:48 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 27 Oct 2021 09:11:35 +0800
Message-ID: <CACkBjsZQF19bQ1C6=yetF3BvL10OSORpFUcWXTP6HErshDB4dQ@mail.gmail.com>
Subject: INFO: task hung in btrfs_commit_transaction
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
https://drive.google.com/file/d/13Kdx_4doleLLGr-de_j4t0GE_NxPawq4/view?usp=sharing
kernel config: https://drive.google.com/file/d/12PUnxIM1EPBgW4ZJmI7WJBRaY1lA83an/view?usp=sharing

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

INFO: task syz-executor:25604 blocked for more than 143 seconds.
Not tainted 5.15.0-rc6 #4
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor state:D stack:24800 pid:25604 ppid: 24873 flags:0x00004004
Call Trace:
context_switch kernel/sched/core.c:4940 [inline]
__schedule+0xcd9/0x2530 kernel/sched/core.c:6287
schedule+0xd3/0x270 kernel/sched/core.c:6366
btrfs_commit_transaction+0x994/0x2e90 fs/btrfs/transaction.c:2201
btrfs_quota_enable+0x95c/0x1790 fs/btrfs/qgroup.c:1120
btrfs_ioctl_quota_ctl fs/btrfs/ioctl.c:4229 [inline]
btrfs_ioctl+0x637e/0x7b70 fs/btrfs/ioctl.c:5010
vfs_ioctl fs/ioctl.c:51 [inline]
__do_sys_ioctl fs/ioctl.c:874 [inline]
__se_sys_ioctl fs/ioctl.c:860 [inline]
__x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f86920b2c4d
RSP: 002b:00007f868f61ac58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f86921d90a0 RCX: 00007f86920b2c4d
RDX: 0000000020005e40 RSI: 00000000c0109428 RDI: 0000000000000008
RBP: 00007f869212bd80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f86921d90a0
R13: 00007fff6d233e4f R14: 00007fff6d233ff0 R15: 00007f868f61adc0
INFO: task syz-executor:25628 blocked for more than 143 seconds.
Not tainted 5.15.0-rc6 #4
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor state:D stack:29080 pid:25628 ppid: 24873 flags:0x00004004
Call Trace:
context_switch kernel/sched/core.c:4940 [inline]
__schedule+0xcd9/0x2530 kernel/sched/core.c:6287
schedule+0xd3/0x270 kernel/sched/core.c:6366
schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
__mutex_lock_common kernel/locking/mutex.c:669 [inline]
__mutex_lock+0xc96/0x1680 kernel/locking/mutex.c:729
btrfs_remove_qgroup+0xb7/0x7d0 fs/btrfs/qgroup.c:1548
btrfs_ioctl_qgroup_create fs/btrfs/ioctl.c:4333 [inline]
btrfs_ioctl+0x683c/0x7b70 fs/btrfs/ioctl.c:5014
vfs_ioctl fs/ioctl.c:51 [inline]
__do_sys_ioctl fs/ioctl.c:874 [inline]
__se_sys_ioctl fs/ioctl.c:860 [inline]
__x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f86920b2c4d
RSP: 002b:00007f868f5f9c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f86921d9158 RCX: 00007f86920b2c4d
RDX: 0000000020005e80 RSI: 000000004010942a RDI: 0000000000000007
RBP: 00007f869212bd80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f86921d9158
R13: 00007fff6d233e4f R14: 00007fff6d233ff0 R15: 00007f868f5f9dc0
INFO: task syz-executor:25629 blocked for more than 143 seconds.
Not tainted 5.15.0-rc6 #4
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor state:D stack:23744 pid:25629 ppid: 24873 flags:0x00000004
Call Trace:
context_switch kernel/sched/core.c:4940 [inline]
__schedule+0xcd9/0x2530 kernel/sched/core.c:6287
schedule+0xd3/0x270 kernel/sched/core.c:6366
wait_current_trans+0x308/0x430 fs/btrfs/transaction.c:534
start_transaction+0xae2/0x1730 fs/btrfs/transaction.c:681
btrfs_dirty_inode+0xf4/0x250 fs/btrfs/inode.c:6254
btrfs_update_time+0x33b/0x3d0 fs/btrfs/inode.c:6296
update_time+0x6d/0xc0 fs/inode.c:1788
touch_atime+0x3c4/0x5b0 fs/inode.c:1860
file_accessed include/linux/fs.h:2504 [inline]
filemap_read+0xc3e/0xe40 mm/filemap.c:2700
btrfs_file_read_iter+0x1c6/0x590 fs/btrfs/file.c:3678
__kernel_read+0x599/0xb40 fs/read_write.c:443
integrity_kernel_read+0x7b/0xb0 security/integrity/iint.c:199
ima_calc_file_hash_tfm+0x2aa/0x3b0 security/integrity/ima/ima_crypto.c:484
ima_calc_file_shash security/integrity/ima/ima_crypto.c:515 [inline]
ima_calc_file_hash+0x19d/0x4b0 security/integrity/ima/ima_crypto.c:572
ima_collect_measurement+0x4ca/0x570 security/integrity/ima/ima_api.c:254
process_measurement+0xd18/0x1920 security/integrity/ima/ima_main.c:337
ima_file_check+0xb1/0x100 security/integrity/ima/ima_main.c:516
do_open fs/namei.c:3430 [inline]
path_openat+0x1797/0x2710 fs/namei.c:3561
do_filp_open+0x1c1/0x290 fs/namei.c:3588
do_sys_openat2+0x61b/0x9a0 fs/open.c:1200
do_sys_open+0xc3/0x140 fs/open.c:1216
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f86920b2c4d
RSP: 002b:00007f868f5d8c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f86921d9210 RCX: 00007f86920b2c4d
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020005ec0
RBP: 00007f869212bd80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f86921d9210
R13: 00007fff6d233e4f R14: 00007fff6d233ff0 R15: 00007f868f5d8dc0
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
CPU: 3 PID: 28996 Comm: syz-executor Not tainted 5.15.0-rc6 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:choose_new_asid arch/x86/mm/tlb.c:219 [inline]
RIP: 0010:switch_mm_irqs_off+0x76f/0xd10 arch/x86/mm/tlb.c:617
Code: 31 f6 e8 74 2f ff ff 65 ff 0d 7d 9e cd 7e 0f 85 90 fe ff ff e8
e1 f3 cb ff e9 86 fe ff ff 65 48 c7 05 a1 bf ce 7e 01 00 00 00 <31> d2
b8 28 00 00 00 45 31 f6 bb 20 00 00 00 66 89 14 24 45 31 c9
RSP: 0018:ffffc9000f1a7b48 EFLAGS: 00000046
RAX: dffffc0000000000 RBX: ffff888030eb3770 RCX: ffffffff81344c11
RDX: 1ffff11020016084 RSI: 0000000000000008 RDI: ffff8881000b0420
RBP: ffff8881000b0000 R08: 0000000000000001 R09: ffffed1020016085
R10: ffff8881000b0427 R11: ffffed1020016084 R12: 0000000000110fd6
R13: ffff888030eb3100 R14: 0000000000000003 R15: ffff888030eb3770
FS: 00007f617700a700(0000) GS:ffff888135d00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe4dd966080 CR3: 000000002215b000 CR4: 0000000000350ee0
Call Trace:
use_temporary_mm arch/x86/kernel/alternative.c:741 [inline]
__text_poke+0x449/0x8c0 arch/x86/kernel/alternative.c:838
text_poke_bp_batch+0x3d7/0x560 arch/x86/kernel/alternative.c:1178
text_poke_flush arch/x86/kernel/alternative.c:1268 [inline]
text_poke_finish+0x16/0x30 arch/x86/kernel/alternative.c:1275
arch_jump_label_transform_apply+0x13/0x20 arch/x86/kernel/jump_label.c:146
jump_label_update+0x32d/0x440 kernel/jump_label.c:830
static_key_slow_inc_cpuslocked+0x1b2/0x250 kernel/jump_label.c:144
static_key_slow_inc+0x16/0x20 kernel/jump_label.c:159
kvm_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1099 [inline]
kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:4613 [inline]
kvm_dev_ioctl+0x16db/0x1aa0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4668
vfs_ioctl fs/ioctl.c:51 [inline]
__do_sys_ioctl fs/ioctl.c:874 [inline]
__se_sys_ioctl fs/ioctl.c:860 [inline]
__x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f6179ac2c4d
Code: Unable to access opcode bytes at RIP 0x7f6179ac2c23.
RSP: 002b:00007f6177009c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6179be9158 RCX: 00007f6179ac2c4d
RDX: 0000000000000000 RSI: 000000000000ae01 RDI: 0000000000000038
RBP: 00007f6179b3bd80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6179be9158
R13: 00007ffe77d38d9f R14: 00007ffe77d38f40 R15: 00007f6177009dc0
NMI backtrace for cpu 1
CPU: 1 PID: 3023 Comm: systemd-journal Not tainted 5.15.0-rc6 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:deref_stack_reg+0x2/0x70 arch/x86/kernel/unwind_orc.c:351
Code: e9 7b ff ff ff 48 89 14 24 e8 da 9a 8a 00 48 8b 14 24 e9 48 ff
ff ff 48 89 0c 24 e8 c8 9a 8a 00 48 8b 0c 24 eb 9d 66 90 41 54 <55> 48
89 f5 53 48 89 d3 ba 08 00 00 00 48 83 ec 08 e8 c8 fe ff ff
RSP: 0018:ffffc900017ef8f0 EFLAGS: 00000246
RAX: ffffc900017efa48 RBX: 1ffff920002fdf28 RCX: 0000000000000001
RDX: ffffc900017efa90 RSI: ffffc900017efa40 RDI: ffffc900017efa48
RBP: 0000000000000001 R08: ffffffff8de80f68 R09: ffffffff8de80f68
R10: ffffc900017efaa7 R11: 0000000000086088 R12: ffffc900017efa90
R13: ffffc900017efa7d R14: ffffc900017efa48 R15: ffffc900017efa7c
FS: 00007fe4e1aea8c0(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe4dd96f090 CR3: 0000000018e9b000 CR4: 0000000000350ee0
Call Trace:
unwind_next_frame+0xb02/0x1770 arch/x86/kernel/unwind_orc.c:534
__unwind_start+0x524/0x810 arch/x86/kernel/unwind_orc.c:699
unwind_start arch/x86/include/asm/unwind.h:60 [inline]
arch_stack_walk+0x5c/0xe0 arch/x86/kernel/stacktrace.c:24
stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:121
kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
kasan_set_track mm/kasan/common.c:46 [inline]
set_alloc_info mm/kasan/common.c:434 [inline]
__kasan_slab_alloc+0x83/0xb0 mm/kasan/common.c:467
kasan_slab_alloc include/linux/kasan.h:254 [inline]
slab_post_alloc_hook+0x4d/0x4b0 mm/slab.h:519
slab_alloc_node mm/slub.c:3206 [inline]
slab_alloc mm/slub.c:3214 [inline]
kmem_cache_alloc+0x150/0x340 mm/slub.c:3219
prepare_creds+0x3f/0x7b0 kernel/cred.c:262
access_override_creds fs/open.c:351 [inline]
do_faccessat+0x3f4/0x850 fs/open.c:415
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fe4e0da69c7
Code: 83 c4 08 48 3d 01 f0 ff ff 73 01 c3 48 8b 0d c8 d4 2b 00 f7 d8
64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 b8 15 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d a1 d4 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffe9f3f4f98 EFLAGS: 00000246 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00007ffe9f3f7fc0 RCX: 00007fe4e0da69c7
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055dea031a9a3
RBP: 00007ffe9f3f50e0 R08: 000055dea03103e5 R09: 0000000000000018
R10: 0000000000000069 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 000055dea06578a0 R15: 00007ffe9f3f55d0
NMI backtrace for cpu 0
CPU: 0 PID: 28993 Comm: syz-executor Not tainted 5.15.0-rc6 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x4/0x20 kernel/kcov.c:284
Code: 84 00 00 00 00 00 48 8b 0c 24 0f b7 d6 0f b7 f7 bf 03 00 00 00
e9 ec fe ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 8b 0c 24 <89> f2
89 fe bf 05 00 00 00 e9 ce fe ff ff 66 66 2e 0f 1f 84 00 00
RSP: 0018:ffffc9000322fa18 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffffffff83a8fb9c
RDX: ffffc90011d50000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888105d6be00 R08: ffffffff83a8fb86 R09: 0000000000000010
R10: 0000000000000001 R11: fffffbfff2078908 R12: 0000000000000010
R13: 00000000000000b0 R14: dffffc0000000000 R15: 0000000000000000
FS: 00007f617702b700(0000) GS:ffff888063e00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000007 CR3: 000000002215b000 CR4: 0000000000350ef0
Call Trace:
tomoyo_domain_quota_is_ok+0x30c/0x540 security/tomoyo/util.c:1093
tomoyo_supervisor+0x290/0xe30 security/tomoyo/common.c:2089
tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
tomoyo_path_permission security/tomoyo/file.c:587 [inline]
tomoyo_path_permission+0x270/0x3a0 security/tomoyo/file.c:573
tomoyo_path_perm+0x2fc/0x420 security/tomoyo/file.c:838
security_path_truncate+0xcf/0x140 security/security.c:1199
do_sys_ftruncate+0x392/0x740 fs/open.c:190
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x2000004a
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 a8 4a 2a e9 2c 21 1c 42 0f 05 <bf> 03
00 00 00 c4 a3 7b f0 c5 5c 41 e2 e9 2e 36 3e 46 0f 1a 70 00
RSP: 002b:00007f617702abb8 EFLAGS: 00000a06 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 000000002000004a
RDX: 0000000000000001 RSI: 0000000000000003 RDI: 0000000000000003
RBP: 00000000000000c2 R08: 0000000000000005 R09: 0000000000000006
R10: 0000000000000007 R11: 0000000000000a06 R12: 000000000000000b
R13: 000000000000000c R14: 000000000000000d R15: 00007f617702adc0
----------------
Code disassembly (best guess):
0: 31 f6 xor %esi,%esi
2: e8 74 2f ff ff callq 0xffff2f7b
7: 65 ff 0d 7d 9e cd 7e decl %gs:0x7ecd9e7d(%rip) # 0x7ecd9e8b
e: 0f 85 90 fe ff ff jne 0xfffffea4
14: e8 e1 f3 cb ff callq 0xffcbf3fa
19: e9 86 fe ff ff jmpq 0xfffffea4
1e: 65 48 c7 05 a1 bf ce movq $0x1,%gs:0x7ecebfa1(%rip) # 0x7ecebfcb
25: 7e 01 00 00 00
* 2a: 31 d2 xor %edx,%edx <-- trapping instruction
2c: b8 28 00 00 00 mov $0x28,%eax
31: 45 31 f6 xor %r14d,%r14d
34: bb 20 00 00 00 mov $0x20,%ebx
39: 66 89 14 24 mov %dx,(%rsp)
3d: 45 31 c9 xor %r9d,%r9d
