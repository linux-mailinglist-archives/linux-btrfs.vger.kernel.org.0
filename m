Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750B867F5B9
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Jan 2023 08:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjA1Hio (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Jan 2023 02:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjA1Hin (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Jan 2023 02:38:43 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14C97909A
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 23:38:39 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id z19-20020a056602205300b0070756e30008so3983088iod.15
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 23:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j0Shyn0HF1v6mjE1PQxVh5XUoyrBSj6GdgT+eC9WSAM=;
        b=rXD1LKc7v3KZum2/QG+3D5gOLIiFhZkM5WA3TbS8ZFdrw6UoV6qo11csomMWg5pGrw
         U5HG1m+PYsofRaAfwALGjFWlHRVsBlo/Kq79+R/0FSCPVpTpiUkj7zTQUMaFkOH298Ox
         BrUOCKolmSY35gNeyY/ZhC9qB87K4MT8Yg+ZY8FLqyzZGY/0GNterrvJKRrWOY2AK8qJ
         OcXjXy7ujUnR4Z/IzmQwSohpPLnngxoGwl0jUGDhkvJhijbz3AxjXU96AD3eOr/5gDcU
         70jCOsrcJ0IGR6EgQ/Y1ZlfUPnSP+dMuK4Je2qyijfIYSNY7WTITEp4RCrMbhJ1fYKz5
         VBOQ==
X-Gm-Message-State: AO0yUKU1TB+F38etlMTmcAPdNGK8G7AqZvkRWGYtZ7+YdQGrK2HccgHk
        CJ0F5fq4XvNy9XO2DSGmrkAf+/JLV5ex80EJWafGu35g0mD4
X-Google-Smtp-Source: AK7set/ZtPD7Mxh8jSoT01S5gxdtthVIOG2mZHXHdn0UTln9o4QboeVEdnBSDLjnnSnIcF2KSC8YyrJUJbX36pnWJgznIuHP18/4
MIME-Version: 1.0
X-Received: by 2002:a02:cb03:0:b0:3a9:62f2:c2f2 with SMTP id
 j3-20020a02cb03000000b003a962f2c2f2mr1200654jap.171.1674891519147; Fri, 27
 Jan 2023 23:38:39 -0800 (PST)
Date:   Fri, 27 Jan 2023 23:38:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000946cf05f34e12c2@google.com>
Subject: [syzbot] [btrfs?] INFO: task hung in lock_extent
From:   syzbot <syzbot+eaa05fbc7563874b7ad2@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7bf70dbb1882 Merge tag 'vfio-v6.2-rc6' of https://github.c..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c2d266480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d5c2ee6c2bd4b8
dashboard link: https://syzkaller.appspot.com/bug?extid=eaa05fbc7563874b7ad2
compiler:       Debian clang version 13.0.1-6~deb11u1, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17be7405480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1393d205480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/53c61cb06735/disk-7bf70dbb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/32c395c7005f/vmlinux-7bf70dbb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66787160c113/bzImage-7bf70dbb.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1f3639eee817/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eaa05fbc7563874b7ad2@syzkaller.appspotmail.com

INFO: task kworker/u4:3:51 blocked for more than 143 seconds.
      Not tainted 6.2.0-rc5-syzkaller-00020-g7bf70dbb1882 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:3    state:D stack:19096 pid:51    ppid:2      flags:0x00004000
Workqueue: btrfs-endio-write btrfs_work_helper
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5293 [inline]
 __schedule+0x995/0xe20 kernel/sched/core.c:6606
 schedule+0xcb/0x190 kernel/sched/core.c:6682
 wait_on_state fs/btrfs/extent-io-tree.c:707 [inline]
 wait_extent_bit+0x577/0x6f0 fs/btrfs/extent-io-tree.c:751
 lock_extent+0x1c2/0x280 fs/btrfs/extent-io-tree.c:1742
 btrfs_finish_ordered_io+0x588/0x1cb0 fs/btrfs/inode.c:3300
 btrfs_work_helper+0x312/0x850 fs/btrfs/async-thread.c:280
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task kworker/u4:0:5183 blocked for more than 143 seconds.
      Not tainted 6.2.0-rc5-syzkaller-00020-g7bf70dbb1882 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:0    state:D stack:20280 pid:5183  ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-btrfs-125)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5293 [inline]
 __schedule+0x995/0xe20 kernel/sched/core.c:6606
 schedule+0xcb/0x190 kernel/sched/core.c:6682
 io_schedule+0x83/0x100 kernel/sched/core.c:8868
 folio_wait_bit_common+0x83a/0x12a0 mm/filemap.c:1297
 extent_write_cache_pages+0x6c8/0x1220 fs/btrfs/extent_io.c:3071
 extent_writepages+0x219/0x540 fs/btrfs/extent_io.c:3211
 do_writepages+0x3c3/0x680 mm/page-writeback.c:2581
 __writeback_single_inode+0xd1/0x670 fs/fs-writeback.c:1598
 writeback_sb_inodes+0x812/0x1050 fs/fs-writeback.c:1889
 __writeback_inodes_wb+0x11d/0x260 fs/fs-writeback.c:1960
 wb_writeback+0x440/0x7b0 fs/fs-writeback.c:2065
 wb_check_old_data_flush fs/fs-writeback.c:2165 [inline]
 wb_do_writeback fs/fs-writeback.c:2218 [inline]
 wb_workfn+0xa78/0xef0 fs/fs-writeback.c:2246
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task syz-executor424:8401 blocked for more than 144 seconds.
      Not tainted 6.2.0-rc5-syzkaller-00020-g7bf70dbb1882 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor424 state:D stack:20008 pid:8401  ppid:5146   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5293 [inline]
 __schedule+0x995/0xe20 kernel/sched/core.c:6606
 schedule+0xcb/0x190 kernel/sched/core.c:6682
 wait_on_state fs/btrfs/extent-io-tree.c:707 [inline]
 wait_extent_bit+0x577/0x6f0 fs/btrfs/extent-io-tree.c:751
 lock_extent+0x1c2/0x280 fs/btrfs/extent-io-tree.c:1742
 btrfs_page_mkwrite+0x533/0xc80 fs/btrfs/inode.c:8537
 do_page_mkwrite+0x19e/0x5e0 mm/memory.c:2947
 wp_page_shared+0x15e/0x380 mm/memory.c:3295
 handle_pte_fault mm/memory.c:4949 [inline]
 __handle_mm_fault mm/memory.c:5073 [inline]
 handle_mm_fault+0x1b79/0x26b0 mm/memory.c:5219
 do_user_addr_fault+0x69b/0xcb0 arch/x86/mm/fault.c:1428
 handle_page_fault arch/x86/mm/fault.c:1519 [inline]
 exc_page_fault+0x7a/0x110 arch/x86/mm/fault.c:1575
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:copy_user_short_string+0xd/0x40 arch/x86/lib/copy_user_64.S:233
Code: 74 0a 89 d1 f3 a4 89 c8 0f 01 ca c3 89 d0 0f 01 ca c3 01 ca eb e7 0f 1f 80 00 00 00 00 89 d1 83 e2 07 c1 e9 03 74 12 4c 8b 06 <4c> 89 07 48 8d 76 08 48 8d 7f 08 ff c9 75 ee 21 d2 74 10 89 d1 8a
RSP: 0018:ffffc90005047330 EFLAGS: 00050202
RAX: ffffffff843e7d01 RBX: 00007fffffffefc8 RCX: 0000000000000007
RDX: 0000000000000000 RSI: ffffc900050473e0 RDI: 0000000020000120
RBP: ffffc90005047490 R08: 0000000000000000 R09: fffff52000a08e83
R10: fffff52000a08e83 R11: 1ffff92000a08e7c R12: 0000000000000038
R13: ffffc900050473e0 R14: 0000000020000120 R15: ffffc900050473e0
 copy_user_generic arch/x86/include/asm/uaccess_64.h:37 [inline]
 raw_copy_to_user arch/x86/include/asm/uaccess_64.h:58 [inline]
 _copy_to_user+0xe9/0x130 lib/usercopy.c:34
 copy_to_user include/linux/uaccess.h:169 [inline]
 fiemap_fill_next_extent+0x22e/0x410 fs/ioctl.c:144
 emit_fiemap_extent+0x22d/0x3c0 fs/btrfs/extent_io.c:3458
 fiemap_process_hole+0x393/0xad0 fs/btrfs/extent_io.c:3669
 extent_fiemap+0xe27/0x2100 fs/btrfs/extent_io.c:3922
 btrfs_fiemap+0x172/0x1e0 fs/btrfs/inode.c:8209
 ioctl_fiemap fs/ioctl.c:219 [inline]
 do_vfs_ioctl+0x185b/0x2980 fs/ioctl.c:810
 __do_sys_ioctl fs/ioctl.c:868 [inline]
 __se_sys_ioctl+0x83/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb85e7ac049
RSP: 002b:00007fb85e7572f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fb85e8367a0 RCX: 00007fb85e7ac049
RDX: 0000000020000100 RSI: 00000000c020660b RDI: 0000000000000005
RBP: 00007fb85e8031d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 61635f65646f6e69
R13: 65646f7475616f6e R14: 7261637369646f6e R15: 00007fb85e8367a8
 </TASK>
INFO: task syz-executor424:8448 blocked for more than 145 seconds.
      Not tainted 6.2.0-rc5-syzkaller-00020-g7bf70dbb1882 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor424 state:D stack:21640 pid:8448  ppid:5146   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5293 [inline]
 __schedule+0x995/0xe20 kernel/sched/core.c:6606
 schedule+0xcb/0x190 kernel/sched/core.c:6682
 wait_on_state fs/btrfs/extent-io-tree.c:707 [inline]
 wait_extent_bit+0x577/0x6f0 fs/btrfs/extent-io-tree.c:751
 lock_extent+0x1c2/0x280 fs/btrfs/extent-io-tree.c:1742
 find_lock_delalloc_range+0x4e6/0x9c0 fs/btrfs/extent_io.c:488
 writepage_delalloc+0x1ef/0x540 fs/btrfs/extent_io.c:1863
 __extent_writepage+0x736/0x14e0 fs/btrfs/extent_io.c:2174
 extent_write_cache_pages+0x983/0x1220 fs/btrfs/extent_io.c:3091
 extent_writepages+0x219/0x540 fs/btrfs/extent_io.c:3211
 do_writepages+0x3c3/0x680 mm/page-writeback.c:2581
 filemap_fdatawrite_wbc+0x11e/0x170 mm/filemap.c:388
 __filemap_fdatawrite_range mm/filemap.c:421 [inline]
 filemap_fdatawrite_range+0x175/0x200 mm/filemap.c:439
 btrfs_fdatawrite_range fs/btrfs/file.c:3857 [inline]
 start_ordered_ops fs/btrfs/file.c:1737 [inline]
 btrfs_sync_file+0x383/0x1190 fs/btrfs/file.c:1813
 generic_write_sync include/linux/fs.h:2885 [inline]
 btrfs_do_write_iter+0xcd3/0x1280 fs/btrfs/file.c:1684
 call_write_iter include/linux/fs.h:2189 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb85e7ac049
RSP: 002b:00007fb8573362f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fb85e8367b0 RCX: 00007fb85e7ac049
RDX: 0000000000000128 RSI: 0000000020004400 RDI: 0000000000000006
RBP: 00007fb85e8031d0 R08: 00007fb857336700 R09: 0000000000000000
R10: 00007fb857336700 R11: 0000000000000246 R12: 61635f65646f6e69
R13: 65646f7475616f6e R14: 7261637369646f6e R15: 00007fb85e8367b8
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8d327010 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8d327810 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/28:
 #0: ffffffff8d326e40 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
3 locks held by kworker/u4:3/51:
 #0: ffff888020884938 ((wq_completion)btrfs-endio-write){+.+.}-{0:0}, at: process_one_work+0x7f2/0xdb0
 #1: ffffc90000bc7d00 ((work_completion)(&work->normal_work)){+.+.}-{0:0}, at: process_one_work+0x831/0xdb0 kernel/workqueue.c:2264
 #2: ffff88801ea66430 (btrfs_ordered_extent){++++}-{0:0}, at: btrfs_finish_ordered_io+0x313/0x1cb0 fs/btrfs/inode.c:3254
1 lock held by udevd/4431:
2 locks held by getty/4744:
 #0: ffff888027aac098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:244
 #1: ffffc900015902f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x53b/0x1650 drivers/tty/n_tty.c:2177
3 locks held by kworker/u4:0/5183:
 #0: ffff888017a5d138 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x7f2/0xdb0
 #1: ffffc9000453fd00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x831/0xdb0 kernel/workqueue.c:2264
 #2: ffff88807ae5a0e0 (&type->s_umount_key#42){++++}-{3:3}, at: trylock_super+0x1b/0xf0 fs/super.c:415
3 locks held by syz-executor424/8401:
 #0: ffff88807aae3e98 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:136 [inline]
 #0: ffff88807aae3e98 (&mm->mmap_lock){++++}-{3:3}, at: do_user_addr_fault+0x2e2/0xcb0 arch/x86/mm/fault.c:1369
 #1: ffff88807ae5a558 (sb_pagefaults){.+.+}-{0:0}, at: do_page_mkwrite+0x19e/0x5e0 mm/memory.c:2947
 #2: ffff888072f80468 (&ei->i_mmap_lock){++++}-{3:3}, at: btrfs_page_mkwrite+0x417/0xc80 fs/btrfs/inode.c:8526
2 locks held by syz-executor424/8448:
 #0: ffff8880291325e8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x242/0x2e0 fs/file.c:1046
 #1: ffff88807ae5a460 (sb_writers#9){.+.+}-{0:0}, at: vfs_write+0x287/0xc50 fs/read_write.c:580
2 locks held by syz-executor424/10675:
2 locks held by syz-executor424/10679:
2 locks held by syz-executor424/10676:
3 locks held by syz-executor424/10680:
2 locks held by syz-executor424/10681:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.2.0-rc5-syzkaller-00020-g7bf70dbb1882 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x46f/0x4f0 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1ba/0x420 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:220 [inline]
 watchdog+0xcd5/0xd20 kernel/hung_task.c:377
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 10679 Comm: syz-executor424 Not tainted 6.2.0-rc5-syzkaller-00020-g7bf70dbb1882 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:__set_page_owner_handle+0x38/0x3d0
Code: 89 4c 24 0c 41 89 d7 89 74 24 08 49 89 fd 49 bc 00 00 00 00 00 fc ff df e8 35 c9 a0 ff bf 20 00 00 00 44 89 fe e8 a8 cc a0 ff <b8> 01 00 00 00 44 89 f9 d3 e0 44 89 f9 48 89 4c 24 18 31 db 85 c0
RSP: 0018:ffffc9000aedf2e8 EFLAGS: 00000293
RAX: ffffffff81eb111b RBX: 0000000000140cca RCX: 0000000000000000
RDX: ffff8880292a8000 RSI: 0000000000000000 RDI: 0000000000000020
RBP: ffff8880153069c0 R08: ffffffff81eb1128 R09: fffffbfff20fca31
R10: fffffbfff20fca31 R11: 1ffffffff20fca30 R12: dffffc0000000000
R13: ffff8880153069c0 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fb85e757700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb857336000 CR3: 000000001cb76000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __set_page_owner+0x43/0x60 mm/page_owner.c:195
 prep_new_page mm/page_alloc.c:2531 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4283
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5549
 __folio_alloc+0xf/0x30 mm/page_alloc.c:5581
 vma_alloc_folio+0x660/0xb60 mm/mempolicy.c:2247
 shmem_alloc_folio mm/shmem.c:1569 [inline]
 shmem_alloc_and_acct_folio+0x594/0xd70 mm/shmem.c:1593
 shmem_get_folio_gfp+0x1751/0x3a30 mm/shmem.c:1920
 shmem_get_folio mm/shmem.c:2051 [inline]
 shmem_write_begin+0x133/0x480 mm/shmem.c:2543
 generic_perform_write+0x2e4/0x5e0 mm/filemap.c:3772
 __generic_file_write_iter+0x176/0x400 mm/filemap.c:3900
 generic_file_write_iter+0xab/0x310 mm/filemap.c:3932
 call_write_iter include/linux/fs.h:2189 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb85e7682cf
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 99 fd ff ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 cc fd ff ff 48
RSP: 002b:00007fb85e757140 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fb85e7682cf
RDX: 0000000001000000 RSI: 00007fb856337000 RDI: 0000000000000003
RBP: 00007fb856337000 R08: 0000000000000000 R09: 00000000000050e9
R10: 0000000001000000 R11: 0000000000000293 R12: 00007fb85e7576b8
R13: 00007fb85e757180 R14: 00007fb85e7571c0 R15: 00007fb85e8367a8
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.146 msecs


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
