Return-Path: <linux-btrfs+bounces-8355-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD1C98B10E
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 01:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405411C21939
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 23:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBB11A3BDA;
	Mon, 30 Sep 2024 23:39:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CA41A3BA9
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 23:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727739574; cv=none; b=aOTbp7+WXxig0xi1TDt1qyZrk+ker31TnEVT+5orL8BE1ExvN4jhAvpoyV2mB2Prpzs1rcddgB69v41B7lr+qW2nqemn+QQTOUX6OZU3hxoS5v0xhHc9aWhmvjnOpdgvgWirSjAdMvJJrpQIvOj9cnXvpRP6fLwdYzquUswoql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727739574; c=relaxed/simple;
	bh=l/DXOxk7otG+gjhqTI5R4y5QXhpOgrZAfWIqbe+4X/I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LVgOtdb2EhKHsNIhrbh1dp43qfFK8IHf3BY6X6EhOC4SgEaNjDs1XZrLlt4OLSAZNqTKxePl9E6pbWUfmkT5U9K7ErpU/ajJKJmrfnNqjuOscdfsCGwSq75tiAIoCfM2zce0ULzeZfjXZb9nv58DZXYdMOxE67z49dqJ8xZQ6HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82cf28c74efso595100839f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 16:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727739569; x=1728344369;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wl10yVicxFJ7rch8JDf2bnV6iWKCBqZz4SeK8fYyNwk=;
        b=wUGAoZF2EjLXgpXoanLQtSgBYU0zOIrg243WrKyobBFzx3hXa4S+28bFzYWhhNBelZ
         JdlIxyCoOt7uzQPBjYSAvgVD7RlZoZJC6tUX3E5pXmAWIAKmmsDvH3uZ+/k9rIZffjrx
         Mk9PfjfB00J4TyOuCdNKYpqkxEY8tCeRVcowWR30Z6vkUVKFNcKiGfl3PwFA1s3TEdHv
         2f9o3ubbD43E41oJ+7lDVnxEUP0A7GKOiOEWyLAWMh8FAF4JfB64r4/TE/IReaC6+scj
         XDb3tStuSnmPzXfl17G/svGiJCQLYGjTwE1ogy6ZVXspifKtYOMVBEXpQuncKGahKCKJ
         kcBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMkrEszC0nmhySuqXxAUvM+AHU7b0ZKUbUS9Go1opl55+1l0EWD5aacaLThPzRoiiTTuNYGplf1asYGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSUT/9AAB62qukAg6XqE3AgyLGdPm44fnR9ztZRSwd7MqnBpQX
	F6Yc5LHx9BySypDug1DlWRy/eFlMXDzWiCo8CXtg+5QBLhcH4bGABjHLCa8kDD+wkxr1CodxAl8
	ocbM4PVwHfG/RXbpodwJcaw6sDV27RyDTcGsfjn/NHacQimZalOgLRHo=
X-Google-Smtp-Source: AGHT+IG4LuUP6X8rg0CnjBvjZCU3ZX/R1+c2ZtUqrxTuvJKcWN4+OuchF1pJ3Sf8FLnNvaKtpvu+GFzX2Hi2NrmYDhBduQJeHOk1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138b:b0:3a1:a26e:81a with SMTP id
 e9e14a558f8ab-3a345169a94mr130089535ab.7.1727739569360; Mon, 30 Sep 2024
 16:39:29 -0700 (PDT)
Date: Mon, 30 Sep 2024 16:39:29 -0700
In-Reply-To: <000000000000516ace0618827799@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fb36b1.050a0220.aab67.003b.GAE@google.com>
Subject: Re: [syzbot] [kernel] WARNING: locking bug in try_to_wake_up
From: syzbot <syzbot+8aaf2df2ef0164ffe1fb@syzkaller.appspotmail.com>
To: clm@fb.com, davem@davemloft.net, dsterba@suse.com, edumazet@google.com, 
	jason@zx2c4.com, josef@toxicpanda.com, kuba@kernel.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9852d85ec9d4 Linux 6.12-rc1
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16c0ddd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f009dd80b3799c2
dashboard link: https://syzkaller.appspot.com/bug?extid=8aaf2df2ef0164ffe1fb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12017d07980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ad839f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3a7fe74d3205/disk-9852d85e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0332f06aa08e/vmlinux-9852d85e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/58ddf291e00e/bzImage-9852d85e.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/7b9a21b4b8c9/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/e0b9c39ab630/mount_2.gz
mounted in repro #3: https://storage.googleapis.com/syzbot-assets/6d11f8e19e12/mount_10.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8aaf2df2ef0164ffe1fb@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __lock_acquire+0x77/0x2050 kernel/locking/lockdep.c:5065
Read of size 8 at addr ffff8880272a8a18 by task kworker/u8:3/52

CPU: 1 UID: 0 PID: 52 Comm: kworker/u8:3 Not tainted 6.12.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: btrfs-fixup btrfs_work_helper
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __lock_acquire+0x77/0x2050 kernel/locking/lockdep.c:5065
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
 try_to_wake_up+0xb0/0x1480 kernel/sched/core.c:4154
 btrfs_writepage_fixup_worker+0xc16/0xdf0 fs/btrfs/inode.c:2842
 btrfs_work_helper+0x390/0xc50 fs/btrfs/async-thread.c:314
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 2:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4086 [inline]
 slab_alloc_node mm/slub.c:4135 [inline]
 kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4187
 alloc_task_struct_node kernel/fork.c:180 [inline]
 dup_task_struct+0x57/0x8c0 kernel/fork.c:1107
 copy_process+0x5d1/0x3d50 kernel/fork.c:2206
 kernel_clone+0x223/0x880 kernel/fork.c:2787
 kernel_thread+0x1bc/0x240 kernel/fork.c:2849
 create_kthread kernel/kthread.c:412 [inline]
 kthreadd+0x60d/0x810 kernel/kthread.c:765
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 61:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2343 [inline]
 slab_free mm/slub.c:4580 [inline]
 kmem_cache_free+0x1a2/0x420 mm/slub.c:4682
 put_task_struct include/linux/sched/task.h:144 [inline]
 delayed_put_task_struct+0x125/0x300 kernel/exit.c:228
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1037 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1037
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3086 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3190
 context_switch kernel/sched/core.c:5318 [inline]
 __schedule+0x184b/0x4ae0 kernel/sched/core.c:6675
 schedule_idle+0x56/0x90 kernel/sched/core.c:6793
 do_idle+0x56a/0x5d0 kernel/sched/idle.c:354
 cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:424
 start_secondary+0x102/0x110 arch/x86/kernel/smpboot.c:314
 common_startup_64+0x13e/0x147

The buggy address belongs to the object at ffff8880272a8000
 which belongs to the cache task_struct of size 7424
The buggy address is located 2584 bytes inside of
 freed 7424-byte region [ffff8880272a8000, ffff8880272a9d00)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x272a8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801bafa500 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080040004 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801bafa500 dead000000000122 0000000000000000
head: 0000000000000000 0000000080040004 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea00009caa01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2, tgid 2 (kthreadd), ts 71247381401, free_ts 71214998153
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3039/0x3180 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x120 mm/slub.c:2413
 allocate_slab+0x5a/0x2f0 mm/slub.c:2579
 new_slab mm/slub.c:2632 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3819
 __slab_alloc+0x58/0xa0 mm/slub.c:3909
 __slab_alloc_node mm/slub.c:3962 [inline]
 slab_alloc_node mm/slub.c:4123 [inline]
 kmem_cache_alloc_node_noprof+0x1fe/0x320 mm/slub.c:4187
 alloc_task_struct_node kernel/fork.c:180 [inline]
 dup_task_struct+0x57/0x8c0 kernel/fork.c:1107
 copy_process+0x5d1/0x3d50 kernel/fork.c:2206
 kernel_clone+0x223/0x880 kernel/fork.c:2787
 kernel_thread+0x1bc/0x240 kernel/fork.c:2849
 create_kthread kernel/kthread.c:412 [inline]
 kthreadd+0x60d/0x810 kernel/kthread.c:765
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
page last free pid 5230 tgid 5230 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcd0/0xf00 mm/page_alloc.c:2638
 discard_slab mm/slub.c:2678 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3146
 put_cpu_partial+0x17c/0x250 mm/slub.c:3221
 __slab_free+0x2ea/0x3d0 mm/slub.c:4450
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4086 [inline]
 slab_alloc_node mm/slub.c:4135 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4142
 getname_flags+0xb7/0x540 fs/namei.c:139
 do_sys_openat2+0xd2/0x1d0 fs/open.c:1409
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880272a8900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880272a8980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880272a8a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff8880272a8a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880272a8b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

