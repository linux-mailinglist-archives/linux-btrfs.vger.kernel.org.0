Return-Path: <linux-btrfs+bounces-8067-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C33997A45D
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 16:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506011C21513
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 14:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B1F158A26;
	Mon, 16 Sep 2024 14:44:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F90615854F
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726497872; cv=none; b=oGu+8jciwPVDb+55eTTYNk7Y+Jl6kIUoP55hm6t4dKbfEgVlM9/Vz3K4rbKUsmAP0i3W63r5r4n0gxHiarl6roG04BL60lc0wNNF39A26rIA9FiE4o4kL8A5wuNob47Q1Rkw1ik2xDz/452JlbZigx/MTnjjneKFwBZORk6U4FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726497872; c=relaxed/simple;
	bh=4XLX4me90FY3H1iDCYVuoejkzmX5dwsTmuuo5fjtF+M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ainjouibDmQ5I6cPMcf83+5xGGa3A8y+/134K3obWzIewhyyPy8skP+P0Y6voiXs1BnLabJkSjo6EBGYDOGKgbHI3NfGEPvM97u3m+F7OXsUj71F4OXsxPhssVkfSryddg/9K+YEt6bXvxl76II4J+Y6Ew5sc3qt+yAL8HBEXTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0a71b7d90so11719065ab.0
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 07:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726497870; x=1727102670;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MKq5hEn8bDO5i7Jy9Ts4snH4ZjRzxZe/KAWDe5MIK8o=;
        b=aYWXqDYzSTYX6MPkYI9LxT6OrF+qVRofWXwNoGSlX08MCkPI+cne1fuxzcQOdcrPAW
         6UFmeTZ65Tp+cMXQ+laCzQe7W+HUCqP5dz9ZCtQNpxtORLEyz4eAw4DAoCLtEQjYKJpB
         lUrQmiJZ5AFjVa5ZNEubLHDkvNK6ASo0IzbQN4imIIdxNJQjC9MdyPbKFKq6PJ7Ws1k4
         qHB6e85MNaYD/B/bx7c+jcMiWCS9gFRPdYxrr0z9ik2v7RdxTItbU3sR3DN6Snpja7F9
         ZHn6jGU3URgxgbRSS7cPavZk3J3NPrfiR1KZU1wi2cC9qsXyT9TW3MqqSBiFSr8ZZV70
         SOCg==
X-Forwarded-Encrypted: i=1; AJvYcCVTb6gdSmRwX/hNN9L1L2iSRQHgXfXoBeJ1IqXM0U7ETsjU6TTA+xtf4dKY6/TXGC0wgRg7g1JiJpWJcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtDQTIg5d99cMUB8/CP6XfsVOFqMCNAWkKQxG6SRWc5Xyn4yUt
	cOfJoPRa3Ntr8ZZgGmGKgXw6CRXMyIycIMn17H5xnqaT01wstgZAmvWiyRne/YrebTBQ56noCzs
	K9z8iJsD8gz/eRoltZqoJVSEwpgAvecmVCQg+rR/SQBzMIZ0hUxuDwXU=
X-Google-Smtp-Source: AGHT+IGHsWAxLJVZQCTMXTSDNbeNINwzq9me0L2rRMqjBnbI4ed3iexuCNjVLpMVqrrO/vSkTSe0eK/b3PqG7Yy3LH4E201SBbUv
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56b:0:b0:3a0:9264:c4a8 with SMTP id
 e9e14a558f8ab-3a09264cf57mr78051295ab.25.1726497869771; Mon, 16 Sep 2024
 07:44:29 -0700 (PDT)
Date: Mon, 16 Sep 2024 07:44:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003bc82506223d9c64@google.com>
Subject: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in btrfs_cleanup_defrag_inodes
From: syzbot <syzbot+ad7966ca1f5dd8b001b3@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    adfc3ded5c33 Merge tag 'for-6.12/io_uring-discard-20240913..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1013a29f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f94136b4da4e897
dashboard link: https://syzkaller.appspot.com/bug?extid=ad7966ca1f5dd8b001b3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4d908436e309/disk-adfc3ded.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c7ab09b5ccee/vmlinux-adfc3ded.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fa3017710376/bzImage-adfc3ded.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ad7966ca1f5dd8b001b3@syzkaller.appspotmail.com

BTRFS info (device loop3 state EA): last unmount of filesystem ed167579-eb65-4e76-9a50-61ac97e9b59d
==================================================================
BUG: KASAN: slab-use-after-free in rb_left_deepest_node lib/rbtree.c:595 [inline]
BUG: KASAN: slab-use-after-free in rb_first_postorder+0x69/0x90 lib/rbtree.c:628
Read of size 8 at addr ffff888056652010 by task syz-executor/11584

CPU: 1 UID: 0 PID: 11584 Comm: syz-executor Not tainted 6.11.0-syzkaller-02520-gadfc3ded5c33 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 rb_left_deepest_node lib/rbtree.c:595 [inline]
 rb_first_postorder+0x69/0x90 lib/rbtree.c:628
 btrfs_cleanup_defrag_inodes+0x2f/0x80 fs/btrfs/defrag.c:212
 close_ctree+0x2af/0xd20 fs/btrfs/disk-io.c:4256
 generic_shutdown_super+0x139/0x2d0 fs/super.c:642
 kill_anon_super+0x3b/0x70 fs/super.c:1237
 btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2121
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x27f0 kernel/exit.c:882
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6e26d7def9
Code: Unable to access opcode bytes at 0x7f6e26d7decf.
RSP: 002b:00007ffc1e161938 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f6e26df0a86 RCX: 00007f6e26d7def9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000010 R08: 00007ffc1e15f6d6 R09: 00007ffc1e162bf0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc1e162bf0
R13: 00007f6e26df0a14 R14: 000055555899a4a8 R15: 00007ffc1e163cb0
 </TASK>

Allocated by task 11:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3989 [inline]
 slab_alloc_node mm/slub.c:4038 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4045
 btrfs_add_inode_defrag+0x15c/0x790 fs/btrfs/defrag.c:136
 inode_should_defrag fs/btrfs/inode.c:888 [inline]
 cow_file_range+0x380/0x11f0 fs/btrfs/inode.c:1382
 btrfs_run_delalloc_range+0x33d/0xf70 fs/btrfs/inode.c:2334
 writepage_delalloc+0x482/0x7d0 fs/btrfs/extent_io.c:1192
 extent_writepage fs/btrfs/extent_io.c:1454 [inline]
 extent_write_cache_pages fs/btrfs/extent_io.c:2130 [inline]
 btrfs_writepages+0x1157/0x2370 fs/btrfs/extent_io.c:2261
 do_writepages+0x35d/0x870 mm/page-writeback.c:2683
 __writeback_single_inode+0x14f/0x10d0 fs/fs-writeback.c:1658
 writeback_sb_inodes+0x812/0x1370 fs/fs-writeback.c:1954
 wb_writeback+0x41b/0xbd0 fs/fs-writeback.c:2134
 wb_do_writeback fs/fs-writeback.c:2281 [inline]
 wb_workfn+0x410/0x1090 fs/fs-writeback.c:2321
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x870/0xd30 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 11917:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2250 [inline]
 slab_free mm/slub.c:4474 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4549
 btrfs_cleanup_defrag_inodes+0x51/0x80 fs/btrfs/defrag.c:214
 btrfs_remount_cleanup fs/btrfs/super.c:1263 [inline]
 btrfs_reconfigure+0x269c/0x2d40 fs/btrfs/super.c:1555
 reconfigure_super+0x445/0x880 fs/super.c:1083
 do_remount fs/namespace.c:3047 [inline]
 path_mount+0xc22/0xfa0 fs/namespace.c:3826
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888056652000
 which belongs to the cache btrfs_inode_defrag of size 56
The buggy address is located 16 bytes inside of
 freed 56-byte region [ffff888056652000, ffff888056652038)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x56652
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000000 ffff888030f77780 dead000000000122 0000000000000000
raw: 0000000000000000 00000000802e002e 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL), pid 62, tgid 62 (kworker/u8:4), ts 261251744217, free_ts 261164089851
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1500
 prep_new_page mm/page_alloc.c:1508 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3446
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4702
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2319
 allocate_slab+0x5a/0x2f0 mm/slub.c:2482
 new_slab mm/slub.c:2535 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3721
 __slab_alloc+0x58/0xa0 mm/slub.c:3811
 __slab_alloc_node mm/slub.c:3864 [inline]
 slab_alloc_node mm/slub.c:4026 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4045
 btrfs_add_inode_defrag+0x15c/0x790 fs/btrfs/defrag.c:136
 inode_should_defrag fs/btrfs/inode.c:888 [inline]
 compress_file_range+0x2ef/0x1300 fs/btrfs/inode.c:945
 btrfs_work_helper+0x390/0xc50 fs/btrfs/async-thread.c:314
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x870/0xd30 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
page last free pid 7513 tgid 7512 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_page+0xd19/0xea0 mm/page_alloc.c:2619
 stack_depot_save_flags+0x6f6/0x830 lib/stackdepot.c:666
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_save_track+0x51/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4159 [inline]
 __kmalloc_noprof+0x1fc/0x400 mm/slub.c:4171
 kmalloc_noprof include/linux/slab.h:694 [inline]
 hfsplus_find_init+0x85/0x1c0 fs/hfsplus/bfind.c:21
 hfsplus_lookup+0x1ae/0xc70 fs/hfsplus/dir.c:44
 lookup_one_qstr_excl+0x11f/0x260 fs/namei.c:1633
 filename_create+0x297/0x540 fs/namei.c:4027
 do_mkdirat+0xbd/0x3a0 fs/namei.c:4272
 __do_sys_mkdirat fs/namei.c:4295 [inline]
 __se_sys_mkdirat fs/namei.c:4293 [inline]
 __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4293
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888056651f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888056651f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888056652000: fa fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
                         ^
 ffff888056652080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888056652100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


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

