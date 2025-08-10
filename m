Return-Path: <linux-btrfs+bounces-15971-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 792E1B1FC77
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Aug 2025 23:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 982D57A954C
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Aug 2025 21:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ED529B79B;
	Sun, 10 Aug 2025 21:55:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64A81DF97F
	for <linux-btrfs@vger.kernel.org>; Sun, 10 Aug 2025 21:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754862925; cv=none; b=NP9mzOQPqQg4xn8xxQxGzNggfTqN/Ni6RbbrJwtsVB53qwx5f2jzJzBSiAQvo2BElqEcobT4YlhpOAk/v2j28YsMTGHAwz4MHuxy6HDkZkZaTVaFThQh9wX5CYOdbHR1QS75ByetZuEPmUoYkKmqWuNTaiCWkgDmR62BF99iV0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754862925; c=relaxed/simple;
	bh=MRCBh/xh8E0qzjwuodnKjP/03LZyIWVca2FSuTLy79A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bTSqtTV6cX18268J9ZdnCMw24MgbcqbJlABwlZY77uB92Nv9CwlFSnSvX1z5YW9ukk/GweTmArU2Ny39xVheJuZM4F9cBEbjuwkp1wqOd6R2YDiG/fPcnLxyvMqpafIHH+JypkDg6oyWFJ12TyRES8biuDnW9ed35ns5RHj7f0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-881a05b0846so355964139f.1
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Aug 2025 14:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754862923; x=1755467723;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wv9bFpMiDccCulrRjZHbJGrbhfdSTv5fYiCRt2bjYBc=;
        b=nTnAnuBSEq0WuBUp7ZwYmL5pNK0ArFVECctuSgldkI5hTWFA6aD0u4a0uwz0xM82m1
         z3z+xzjeuJkWO5Zfn/s5cqv5w5qEkwKioMGhpF/drMpLW2CmjMDswmtmNlcp7xOGcZfB
         xoq0BBxXYSA5oX/KmnYWB7N9t9ZC6G9oEEAXINEHSGLMwxxjJaGxtqey+yzxCq+uS+dV
         NUeEWWirINObtZyPcByYXrgI5zVtuNKeEm/HmPKDXXlrxRz+iJZ2JXwjST7ELH5xy/IF
         JM+AjwKqpoMNUITnQdWXrQrrFxJ7pANK01swZPeLaQHRnB6inXg2tniSzSvV/23mhDEj
         Vsng==
X-Forwarded-Encrypted: i=1; AJvYcCWDTF2AgEDO+tvDyagFfKZ7HGw3hwfgu40m4JGdqd8aSMu5qeeNaNx38NZJ6cygO2CMujln1gjlId6Cmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5G5MQERVssnNO1l2rGaz5t+EEuo8SdKbxCcJG8zDnge8nwC+S
	iZDaG7v+02UGELYphuqQrFomJoFJaMFWfreHlwDDpwGis4Gjz0Sxj2YGZnYGexHK7x6IgTovdeO
	aXRAn7EiVWXf/Y6/pGCpe8vOqRDeHiE7OyJTqN5WV6dOPNvzyazBZQL7vfMA=
X-Google-Smtp-Source: AGHT+IEs6Btxh1vuctiQqLY9I2Z3E5GBI6RjaU14aBZITv7nPo6FvT96/FWgmaQqqk/JTtAu4jPDh49Sa24bRk/gcRXHcE/NKYML
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4a06:b0:87c:1d65:3aeb with SMTP id
 ca18e2360f4ac-883f11c040dmr1841176739f.2.1754862923026; Sun, 10 Aug 2025
 14:55:23 -0700 (PDT)
Date: Sun, 10 Aug 2025 14:55:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6899154b.050a0220.51d73.0094.GAE@google.com>
Subject: [syzbot] [btrfs?] INFO: task hung in __alloc_workqueue (2)
From: syzbot <syzbot+ead9101689c4ca30dbe8@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, clm@fb.com, dsterba@suse.com, 
	frederic@kernel.org, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    479058002c32 Merge tag 'ata-6.17-rc1-fixes' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1315e042580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=943d6f7b1ddd8799
dashboard link: https://syzkaller.appspot.com/bug?extid=ead9101689c4ca30dbe8
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d262f0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7226b9adab95/disk-47905800.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b10c6c12e41f/vmlinux-47905800.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7e99b92d1763/bzImage-47905800.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1ca3e7130df3/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=17f2f6a2580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ead9101689c4ca30dbe8@syzkaller.appspotmail.com

INFO: task syz.1.170:8358 blocked for more than 143 seconds.
      Tainted: G        W           6.16.0-syzkaller-11852-g479058002c32 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.170       state:D stack:26024 pid:8358  tgid:8358  ppid:6003   task_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_timeout+0x9a/0x270 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common kernel/sched/completion.c:121 [inline]
 wait_for_common kernel/sched/completion.c:132 [inline]
 wait_for_completion+0x2bf/0x5d0 kernel/sched/completion.c:153
 kthread_flush_worker+0x1c6/0x240 kernel/kthread.c:1563
 __alloc_workqueue+0x146b/0x1b70 kernel/workqueue.c:5763
 alloc_workqueue_noprof+0xd4/0x210 kernel/workqueue.c:5786
 btrfs_init_workqueues+0x42c/0x6c0 fs/btrfs/disk-io.c:2000
 open_ctree+0x11ef/0x3a10 fs/btrfs/disk-io.c:3424
 btrfs_fill_super fs/btrfs/super.c:977 [inline]
 btrfs_get_tree_super fs/btrfs/super.c:1937 [inline]
 btrfs_get_tree_subvol fs/btrfs/super.c:2074 [inline]
 btrfs_get_tree+0xf55/0x1820 fs/btrfs/super.c:2108
 vfs_get_tree+0x92/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb27169038a
RSP: 002b:00007ffefe6fdaf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffefe6fdb80 RCX: 00007fb27169038a
RDX: 00002000000055c0 RSI: 0000200000000200 RDI: 00007ffefe6fdb40
RBP: 00002000000055c0 R08: 00007ffefe6fdb80 R09: 000000000300000a
R10: 000000000300000a R11: 0000000000000246 R12: 0000200000000200
R13: 00007ffefe6fdb40 R14: 00000000000055a3 R15: 0000200000000080
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/38:
 #0: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
1 lock held by udevd/5207:
 #0: ffff8880358bfa18 (&ep->lock){++++}-{3:3}, at: write_lock_irq include/linux/rwlock_rt.h:104 [inline]
 #0: ffff8880358bfa18 (&ep->lock){++++}-{3:3}, at: ep_poll fs/eventpoll.c:2127 [inline]
 #0: ffff8880358bfa18 (&ep->lock){++++}-{3:3}, at: do_epoll_wait+0x84d/0xbb0 fs/eventpoll.c:2560
2 locks held by getty/5598:
 #0: ffff88823bfae8a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90003e8b2e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x444/0x1410 drivers/tty/n_tty.c:2222
3 locks held by kworker/u8:3/5911:
3 locks held by kworker/u8:7/5942:
6 locks held by udevd/6060:
1 lock held by udevd/6069:
1 lock held by udevd/6190:
6 locks held by udevd/6237:
 #0: ffff88802205eea8 (&sb->s_type->i_mutex_key#7){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:884 [inline]
 #0: ffff88802205eea8 (&sb->s_type->i_mutex_key#7){++++}-{4:4}, at: blkdev_read_iter+0x2ff/0x440 block/fops.c:848
 #1: ffff88803b280250 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_trylock include/linux/mmap_lock.h:472 [inline]
 #1: ffff88803b280250 (&mm->mmap_lock){++++}-{4:4}, at: get_mmap_lock_carefully mm/mmap_lock.c:277 [inline]
 #1: ffff88803b280250 (&mm->mmap_lock){++++}-{4:4}, at: lock_mm_and_find_vma+0x32/0x300 mm/mmap_lock.c:337
 #2: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #2: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #2: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: ___pte_offset_map+0x29/0x200 mm/pgtable-generic.c:286
 #3: ffff888026394c58 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
 #3: ffff888026394c58 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: __pte_offset_map_lock+0x13e/0x210 mm/pgtable-generic.c:401
 #4: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #4: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #4: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #4: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1bb/0x2c0 kernel/locking/spinlock_rt.c:57
 #5: ffff8880b8833490 ((lock)#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
 #5: ffff8880b8833490 ((lock)#2){+.+.}-{3:3}, at: __folio_batch_add_and_move+0x170/0x540 mm/swap.c:-1
2 locks held by kworker/u8:9/6857:
1 lock held by syz.1.170/8358:
 #0: ffff88802315a0d0 (&type->s_umount_key#53/1){+.+.}-{4:4}, at: alloc_super+0x204/0x990 fs/super.c:345
4 locks held by kworker/u8:11/10100:
1 lock held by syz.3.381/11502:
2 locks held by syz.4.382/11516:
 #0: ffff88805e1a80d0 (&type->s_umount_key#53/1){+.+.}-{4:4}, at: alloc_super+0x204/0x990 fs/super.c:345
 #1: ffffffff8d611078 (bit_wait_table + i){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
 #1: ffffffff8d611078 (bit_wait_table + i){+.+.}-{3:3}, at: finish_wait kernel/sched/wait.c:394 [inline]
 #1: ffffffff8d611078 (bit_wait_table + i){+.+.}-{3:3}, at: __wait_on_bit+0x1ff/0x300 kernel/sched/wait_bit.c:55
3 locks held by syz.0.383/11517:
 #0: ffff88801aa94488 (sb_writers#5){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3107 [inline]
 #0: ffff88801aa94488 (sb_writers#5){.+.+}-{0:0}, at: vfs_write+0x217/0xaa0 fs/read_write.c:682
 #1: ffff888054b3c598 (&sb->s_type->i_mutex_key#12){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
 #1: ffff888054b3c598 (&sb->s_type->i_mutex_key#12){+.+.}-{4:4}, at: shmem_file_write_iter+0x82/0x120 mm/shmem.c:3518
 #2: ffff8880b8833490 ((lock)#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
 #2: ffff8880b8833490 ((lock)#2){+.+.}-{3:3}, at: __folio_batch_add_and_move+0x170/0x540 mm/swap.c:-1
3 locks held by syz.5.384/11518:
 #0: ffff88801aa94488 (sb_writers#5){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3107 [inline]
 #0: ffff88801aa94488 (sb_writers#5){.+.+}-{0:0}, at: vfs_write+0x217/0xaa0 fs/read_write.c:682
 #1: ffff8880254a6e88 (&sb->s_type->i_mutex_key#12){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
 #1: ffff8880254a6e88 (&sb->s_type->i_mutex_key#12){+.+.}-{4:4}, at: shmem_file_write_iter+0x82/0x120 mm/shmem.c:3518
 #2: ffff8880b8833490 ((lock)#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
 #2: ffff8880b8833490 ((lock)#2){+.+.}-{3:3}, at: __folio_batch_add_and_move+0x170/0x540 mm/swap.c:-1
7 locks held by syz.2.385/11535:
1 lock held by udevadm/11536:

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 38 Comm: khungtaskd Tainted: G        W           6.16.0-syzkaller-11852-g479058002c32 #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:328 [inline]
 watchdog+0xf93/0xfe0 kernel/hung_task.c:491
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5911 Comm: kworker/u8:3 Tainted: G        W           6.16.0-syzkaller-11852-g479058002c32 #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
RIP: 0010:get_timer_this_cpu_base kernel/time/timer.c:939 [inline]
RIP: 0010:__mod_timer+0x81c/0xf60 kernel/time/timer.c:1101
Code: 01 00 00 00 48 8b 5c 24 20 41 0f b6 44 2d 00 84 c0 0f 85 72 06 00 00 8b 2b e8 f0 bb 49 09 41 89 c5 89 c3 bf 08 00 00 00 89 c6 <e8> 0f c1 12 00 41 83 fd 07 44 89 34 24 0f 87 69 06 00 00 e8 4c bc
RSP: 0018:ffffc90004fff680 EFLAGS: 00000082
RAX: 0000000000000000 RBX: 0000000000000000 RCX: f9fab87ca5ec6a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000008
RBP: 0000000000200000 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff520009ffeac R12: ffff8880b8825a80
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000802
FS:  0000000000000000(0000) GS:ffff8881268cd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f46b6524000 CR3: 000000003afb2000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 queue_delayed_work_on+0x18b/0x280 kernel/workqueue.c:2559
 queue_delayed_work include/linux/workqueue.h:684 [inline]
 batadv_forw_packet_queue+0x239/0x2a0 net/batman-adv/send.c:691
 batadv_iv_ogm_schedule_buff net/batman-adv/bat_iv_ogm.c:842 [inline]
 batadv_iv_ogm_schedule+0x892/0xf00 net/batman-adv/bat_iv_ogm.c:874
 batadv_iv_send_outstanding_bat_ogm_packet+0x6c6/0x7e0 net/batman-adv/bat_iv_ogm.c:1714
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

