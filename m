Return-Path: <linux-btrfs+bounces-20104-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C896CCF4935
	for <lists+linux-btrfs@lfdr.de>; Mon, 05 Jan 2026 17:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66289304F8BB
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jan 2026 16:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BC0313281;
	Mon,  5 Jan 2026 16:01:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B883090CC
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Jan 2026 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628889; cv=none; b=aUXnvCSA0HXH5P0A3UOl1WDxPdLoMENMmY8W6JqVdhNagcgFaLB3H4vtR6tIWC3Ckw7pUMx+ul9YJq2v7nXDGUtSBwBNETajcpHMhyyas+heHonpSudbZDLYiICG1hBC12SijPQrX5PzA6AicqasP9fA+5L8svz0NsXsWhsGat0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628889; c=relaxed/simple;
	bh=Dsb3+h2mWvVQoQz+0+htWzwmiIPV22f0g8sgLdXZngA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NNU98xoQ+hDsNFWO6/uyT71T4h5BvQmmzUtwhUXL7JGyumozSeZcaV2Cn1g+o9mqkLk2B7ilaiu272dMhXdeHuUO8PVj8AgCZe9iP+CJSuXg/9jFdpczusZfPW8apHOdH7JYeKqN7IrBQ+rKzvbrjQZ2vTZXVaH5+MZ+rTPNz/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-45a135956eeso248921b6e.0
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jan 2026 08:01:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767628887; x=1768233687;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VANL+QYvStK3k7oYd/VnKzWe/L0akQWo9diozpFjNgY=;
        b=tQFxl3LQZkLJMsEG/IY9NZvVBoHTUAE4ZXmT1zIeNsBakcFytycQpwCqZLbQZbVAj1
         0WIRu0bvEraJnZ92GdwEt3EzFdM6yUsp3OqHHpIUZDXdDZVVAssg3HLQnS92hljlrEOa
         7+zXqvs3vrVYpWJC7+BWjdnHyNY24q3U8qxvkEi97zf/ZaNUiNxY6jMjDe3vdvBNjO2z
         Jw/m/Jfw8jZrFwuE9zezJUI7EyXW8Z0+aPlIAXgDbzJR2PbQhaD79xs4IDZD3ojYGI9w
         2UqmWBcy5il+KTTnK8zGf8AsGnv9Nf+5chplKJUhbJuTnIlqYhFEbX2xGpasTOp4Z1y5
         upyg==
X-Forwarded-Encrypted: i=1; AJvYcCWIUZnAd8iUQFyNGbZ/WYgFaOPfgXBBYLouY/M9aVbx+Lg6loOUU5Akey5d3fjLwgaRCa4uYmxQ5MCFbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBZBImmzE4yy6STiP7hWB65s90A0mT0mEv7f+zTw58RB/JfAzi
	GjIeyPpzTq2996MR3h2b8K30SwFlgCdsiL7lsdUcuYVPnUM/wH5VuWbFMtVNgqT8AS6XOQsSCrK
	hnAYFTDIHMH8vAd3AS74guw92WAQbALdUpk+1JYpvjV1bHJJ8HnZeRa1Z2Vs=
X-Google-Smtp-Source: AGHT+IFmDMZUUWbaiFqkX+/WO0ma/EjN1IeV9HwUQzOCEuDFuPT1iKS88aD277CPBwdtwvvjNRm/hsNbjzTP0Z7nbKfV3ISlyk82
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:30a0:b0:43f:7287:a5de with SMTP id
 5614622812f47-45a5b26aea8mr92545b6e.41.1767628886302; Mon, 05 Jan 2026
 08:01:26 -0800 (PST)
Date: Mon, 05 Jan 2026 08:01:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695be056.050a0220.318c5c.012a.GAE@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in btrfs_quota_disable
From: syzbot <syzbot+42f188c8a5480df414f9@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cc3aa43b44bd Add linux-next specific files for 20251219
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11737222580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da1bc82c6189c463
dashboard link: https://syzkaller.appspot.com/bug?extid=42f188c8a5480df414f9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/30bf539e6f28/disk-cc3aa43b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0e2f8b08e342/vmlinux-cc3aa43b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ec7ee6ece11f/bzImage-cc3aa43b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+42f188c8a5480df414f9@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.6.4382/25959 is trying to acquire lock:
ffff88807ae65990 (&fs_info->qgroup_ioctl_lock){+.+.}-{4:4}, at: btrfs_quota_disable+0x341/0x1000 fs/btrfs/qgroup.c:1369

but task is already holding lock:
ffff88807ae66550 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x164/0xd60 fs/btrfs/transaction.c:322

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (btrfs_trans_num_extwriters){++++}-{0:0}:
       join_transaction+0x1a4/0xd60 fs/btrfs/transaction.c:323
       start_transaction+0x6ba/0x15f0 fs/btrfs/transaction.c:708
       btrfs_create_common+0x146/0x2f0 fs/btrfs/inode.c:6920
       lookup_open fs/namei.c:4439 [inline]
       open_last_lookups fs/namei.c:4539 [inline]
       path_openat+0x1387/0x3840 fs/namei.c:4783
       do_filp_open+0x1fa/0x410 fs/namei.c:4813
       file_open_name fs/open.c:1337 [inline]
       filp_open+0x176/0x1d0 fs/open.c:1357
       coredump_file fs/coredump.c:931 [inline]
       do_coredump fs/coredump.c:1099 [inline]
       vfs_coredump+0x1d6e/0x3e60 fs/coredump.c:1200
       get_signal+0x1108/0x1340 kernel/signal.c:3019
       arch_do_signal_or_restart+0x9a/0x7a0 arch/x86/kernel/signal.c:337
       __exit_to_user_mode_loop kernel/entry/common.c:41 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:75 [inline]
       __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
       irqentry_exit_to_user_mode_prepare include/linux/irq-entry-common.h:270 [inline]
       irqentry_exit_to_user_mode include/linux/irq-entry-common.h:339 [inline]
       irqentry_exit+0x177/0x660 kernel/entry/common.c:196
       exc_page_fault+0xab/0x100 arch/x86/mm/fault.c:1535
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618

-> #3 (btrfs_trans_num_writers){++++}-{0:0}:
       __lock_release kernel/locking/lockdep.c:5574 [inline]
       lock_release+0x1ab/0x3b0 kernel/locking/lockdep.c:5889
       percpu_up_read include/linux/percpu-rwsem.h:112 [inline]
       __sb_end_write include/linux/fs/super.h:14 [inline]
       sb_end_intwrite+0x26/0x1c0 include/linux/fs/super.h:101
       __btrfs_end_transaction+0x248/0x640 fs/btrfs/transaction.c:1084
       btrfs_dirty_inode+0x14c/0x190 fs/btrfs/inode.c:6420
       inode_update_time fs/inode.c:2167 [inline]
       touch_atime+0x2f9/0x6d0 fs/inode.c:2240
       file_accessed include/linux/fs.h:2255 [inline]
       btrfs_file_mmap_prepare+0x176/0x1f0 fs/btrfs/file.c:2050
       vfs_mmap_prepare include/linux/fs.h:2059 [inline]
       call_mmap_prepare mm/vma.c:2596 [inline]
       __mmap_region mm/vma.c:2692 [inline]
       mmap_region+0xb2b/0x1d10 mm/vma.c:2786
       do_mmap+0xc45/0x10d0 mm/mmap.c:558
       vm_mmap_pgoff+0x2a6/0x4d0 mm/util.c:581
       ksys_mmap_pgoff+0x51f/0x760 mm/mmap.c:604
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&mm->mmap_lock){++++}-{4:4}:
       down_read_killable+0x50/0x350 kernel/locking/rwsem.c:1560
       mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:400
       get_mmap_lock_carefully mm/mmap_lock.c:399 [inline]
       lock_mm_and_find_vma+0x2a8/0x300 mm/mmap_lock.c:450
       do_user_addr_fault+0x331/0x1380 arch/x86/mm/fault.c:1359
       handle_page_fault arch/x86/mm/fault.c:1476 [inline]
       exc_page_fault+0x82/0x100 arch/x86/mm/fault.c:1532
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
       filldir64+0x2c1/0x690 fs/readdir.c:-1
       dir_emit include/linux/fs.h:3526 [inline]
       kernfs_fop_readdir+0x537/0x870 fs/kernfs/dir.c:1913
       iterate_dir+0x399/0x570 fs/readdir.c:108
       __do_sys_getdents64 fs/readdir.c:410 [inline]
       __se_sys_getdents64+0xe4/0x260 fs/readdir.c:396
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&root->kernfs_rwsem){++++}-{4:4}:
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
       kernfs_add_one+0x41/0x5c0 fs/kernfs/dir.c:794
       kernfs_create_dir_ns+0xde/0x130 fs/kernfs/dir.c:1096
       sysfs_create_dir_ns+0x123/0x280 fs/sysfs/dir.c:59
       create_dir lib/kobject.c:73 [inline]
       kobject_add_internal+0x6ab/0xcc0 lib/kobject.c:240
       kobject_add_varg lib/kobject.c:374 [inline]
       kobject_init_and_add+0x125/0x190 lib/kobject.c:457
       btrfs_sysfs_add_qgroups+0x111/0x2b0 fs/btrfs/sysfs.c:2643
       btrfs_quota_enable+0x25d/0x2920 fs/btrfs/qgroup.c:1034
       btrfs_ioctl_quota_ctl+0x183/0x1c0 fs/btrfs/ioctl.c:3613
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&fs_info->qgroup_ioctl_lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x15a6/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0x117/0x340 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:776
       btrfs_quota_disable+0x341/0x1000 fs/btrfs/qgroup.c:1369
       btrfs_ioctl_quota_ctl+0x150/0x1c0 fs/btrfs/ioctl.c:3643
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &fs_info->qgroup_ioctl_lock --> btrfs_trans_num_writers --> btrfs_trans_num_extwriters

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(btrfs_trans_num_extwriters);
                               lock(btrfs_trans_num_writers);
                               lock(btrfs_trans_num_extwriters);
  lock(&fs_info->qgroup_ioctl_lock);

 *** DEADLOCK ***

6 locks held by syz.6.4382/25959:
 #0: ffff8880308d2420 (sb_writers#24){.+.+}-{0:0}, at: mnt_want_write_file+0x60/0x200 fs/namespace.c:543
 #1: ffff88807ae648e0 (&fs_info->cleaner_mutex){+.+.}-{4:4}, at: btrfs_ioctl_quota_ctl+0x139/0x1c0 fs/btrfs/ioctl.c:3641
 #2: ffff88807ae64c60 (&fs_info->subvol_sem){+.+.}-{4:4}, at: btrfs_ioctl_quota_ctl+0x148/0x1c0 fs/btrfs/ioctl.c:3642
 #3: ffff8880308d2610 (sb_internal#5){.+.+}-{0:0}, at: btrfs_quota_disable+0x32f/0x1000 fs/btrfs/qgroup.c:1367
 #4: ffff88807ae66528 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0x164/0xd60 fs/btrfs/transaction.c:322
 #5: ffff88807ae66550 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x164/0xd60 fs/btrfs/transaction.c:322

stack backtrace:
CPU: 1 UID: 0 PID: 25959 Comm: syz.6.4382 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2043
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x15a6/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x117/0x340 kernel/locking/lockdep.c:5868
 __mutex_lock_common kernel/locking/mutex.c:614 [inline]
 __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:776
 btrfs_quota_disable+0x341/0x1000 fs/btrfs/qgroup.c:1369
 btrfs_ioctl_quota_ctl+0x150/0x1c0 fs/btrfs/ioctl.c:3643
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feaa538f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007feaa62dd038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007feaa55e6090 RCX: 00007feaa538f749
RDX: 0000200000000080 RSI: 00000000c0109428 RDI: 0000000000000003
RBP: 00007feaa5413f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007feaa55e6128 R14: 00007feaa55e6090 R15: 00007ffc3f417778
 </TASK>


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

