Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8CA62FEFD
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Nov 2022 21:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiKRUtw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Nov 2022 15:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiKRUtw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Nov 2022 15:49:52 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6676EB70
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Nov 2022 12:49:50 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id k3-20020a92c243000000b0030201475a6bso4026419ilo.9
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Nov 2022 12:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7CTcOtx/2KkktfwckLDOdL8IONFaCpCN/ZEvdG15U88=;
        b=kfmrlFPhaXFO5kIvniFoYXbaNxd4GcSGxv7eBmlN30nJmt527tq7k+Z2D+I4d3tvx3
         mltY1yUCQjOBBRC4cwGWTtjLsBfnx4qJbFqNwzdpmxo0YJYAjgsnWLcG3H8xaDXrExjS
         /Ed8KSD8Wf7uMHL0PSvUfTxOQVCqoq7Tr0gVAzMB0oGUaw0DvNXNdD3691oORnYOlqby
         1sbXdt3hehWcxGGRQv+i/JeQezcks9hjox36tw8lvxpe2M5r2OzRvgywadek2Yjfr/h+
         phY6ZxDlikmjzRQLvkhWOK71Wesmdu9C3Bqv2kDuHgm9V1/ciuHz8IXcjUT5YYn2B2TE
         dBuw==
X-Gm-Message-State: ANoB5pmqbXcxuAM+qA1lO+cROD/o0S5nUYalsNFDoQU6H5UvRfZ0CV5R
        qPAwTUDgx+IamGxLJupDn4mOSc/0xkbCiwLuMZP31AlYwNZ/
X-Google-Smtp-Source: AA0mqf7TDDgZns6JLklYSeZpmSyZ1SUNbtONSV1hTqfJYaIyMAtIBsYAbB7sFNnl/Jb632AwAat6YNNmS4K+xmp8B4XbQNavHNRN
MIME-Version: 1.0
X-Received: by 2002:a6b:f418:0:b0:6ce:8185:ad0 with SMTP id
 i24-20020a6bf418000000b006ce81850ad0mr4222344iog.213.1668804589922; Fri, 18
 Nov 2022 12:49:49 -0800 (PST)
Date:   Fri, 18 Nov 2022 12:49:49 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c82e1305edc4d882@google.com>
Subject: [syzbot] possible deadlock in __btrfs_tree_lock
From:   syzbot <syzbot+39feedae0c1e29951744@syzkaller.appspotmail.com>
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

HEAD commit:    84368d882b96 Merge tag 'soc-fixes-6.1-3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14bf6c21880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f4e5e9899396248
dashboard link: https://syzkaller.appspot.com/bug?extid=39feedae0c1e29951744
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c5385d467ad9/disk-84368d88.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9d5d70ca8a42/vmlinux-84368d88.xz
kernel image: https://storage.googleapis.com/syzbot-assets/da0dc29fc9f3/bzImage-84368d88.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+39feedae0c1e29951744@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc5-syzkaller-00144-g84368d882b96 #0 Not tainted
------------------------------------------------------
syz-executor.2/3014 is trying to acquire lock:
ffff888027f2a598 (&mm->mmap_lock#2){++++}-{3:3}, at: __might_fault+0xa9/0x180 mm/memory.c:5645

but task is already holding lock:
ffff888074c05838 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x350 fs/btrfs/locking.c:134

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (btrfs-root-00){++++}-{3:3}:
       down_write_nested+0x98/0x220 kernel/locking/rwsem.c:1672
       __btrfs_tree_lock+0x32/0x3d0 fs/btrfs/locking.c:196
       btrfs_tree_lock fs/btrfs/locking.c:203 [inline]
       btrfs_lock_root_node+0x61/0x90 fs/btrfs/locking.c:256
       commit_cowonly_roots+0x13c/0xa10 fs/btrfs/transaction.c:1266
       btrfs_commit_transaction+0xb93/0x36e0 fs/btrfs/transaction.c:2376
       btrfs_commit_super+0xc5/0x100 fs/btrfs/disk-io.c:4499
       close_ctree+0x39c/0xdc7 fs/btrfs/disk-io.c:4653
       generic_shutdown_super+0x158/0x410 fs/super.c:492
       kill_anon_super+0x3a/0x60 fs/super.c:1086
       btrfs_kill_super+0x3c/0x50 fs/btrfs/super.c:2441
       deactivate_locked_super+0x98/0x160 fs/super.c:332
       deactivate_super+0xb1/0xd0 fs/super.c:363
       cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1186
       task_work_run+0x16f/0x270 kernel/task_work.c:179
       resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
       exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
       __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
       syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
       do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #4 (&fs_info->reloc_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x12f/0x1360 kernel/locking/mutex.c:747
       btrfs_record_root_in_trans+0x13d/0x1b0 fs/btrfs/transaction.c:484
       start_transaction+0x295/0x1470 fs/btrfs/transaction.c:721
       btrfs_create_common+0x1aa/0x260 fs/btrfs/inode.c:6633
       btrfs_create+0x116/0x160 fs/btrfs/inode.c:6679
       lookup_open.isra.0+0xf05/0x12a0 fs/namei.c:3413
       open_last_lookups fs/namei.c:3481 [inline]
       path_openat+0x996/0x2860 fs/namei.c:3710
       do_filp_open+0x1ba/0x410 fs/namei.c:3740
       do_sys_openat2+0x16d/0x4c0 fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_open fs/open.c:1334 [inline]
       __se_sys_open fs/open.c:1330 [inline]
       __x64_sys_open+0x11d/0x1c0 fs/open.c:1330
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #3 (btrfs_trans_num_extwriters){++++}-{0:0}:
       join_transaction+0x1b3/0x10f0 fs/btrfs/transaction.c:299
       start_transaction+0x407/0x1470 fs/btrfs/transaction.c:658
       btrfs_commit_super+0x9d/0x100 fs/btrfs/disk-io.c:4496
       close_ctree+0x39c/0xdc7 fs/btrfs/disk-io.c:4653
       generic_shutdown_super+0x158/0x410 fs/super.c:492
       kill_anon_super+0x3a/0x60 fs/super.c:1086
       btrfs_kill_super+0x3c/0x50 fs/btrfs/super.c:2441
       deactivate_locked_super+0x98/0x160 fs/super.c:332
       deactivate_super+0xb1/0xd0 fs/super.c:363
       cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1186
       task_work_run+0x16f/0x270 kernel/task_work.c:179
       resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
       exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
       __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
       syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
       do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (btrfs_trans_num_writers){++++}-{0:0}:
       __lock_release kernel/locking/lockdep.c:5382 [inline]
       lock_release+0x371/0x810 kernel/locking/lockdep.c:5688
       percpu_up_read include/linux/percpu-rwsem.h:99 [inline]
       __sb_end_write include/linux/fs.h:1821 [inline]
       sb_end_intwrite include/linux/fs.h:1877 [inline]
       __btrfs_end_transaction+0x5c6/0x930 fs/btrfs/transaction.c:995
       btrfs_dirty_inode+0x174/0x250 fs/btrfs/inode.c:6099
       btrfs_update_time+0x25a/0x2c0 fs/btrfs/inode.c:6127
       inode_update_time fs/inode.c:1871 [inline]
       __file_update_time fs/inode.c:2088 [inline]
       file_update_time+0x1fb/0x270 fs/inode.c:2119
       btrfs_page_mkwrite+0x4f1/0x1140 fs/btrfs/inode.c:8431
       do_page_mkwrite+0x19b/0x680 mm/memory.c:2978
       do_shared_fault mm/memory.c:4619 [inline]
       do_fault mm/memory.c:4687 [inline]
       handle_pte_fault mm/memory.c:4955 [inline]
       __handle_mm_fault+0x2280/0x3a40 mm/memory.c:5097
       handle_mm_fault+0x1cc/0x780 mm/memory.c:5218
       do_user_addr_fault+0x475/0x1210 arch/x86/mm/fault.c:1428
       handle_page_fault arch/x86/mm/fault.c:1519 [inline]
       exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1575
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570

-> #1 (sb_pagefaults#2){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1826 [inline]
       sb_start_pagefault include/linux/fs.h:1930 [inline]
       btrfs_page_mkwrite+0x1b5/0x1140 fs/btrfs/inode.c:8415
       do_page_mkwrite+0x19b/0x680 mm/memory.c:2978
       do_shared_fault mm/memory.c:4619 [inline]
       do_fault mm/memory.c:4687 [inline]
       handle_pte_fault mm/memory.c:4955 [inline]
       __handle_mm_fault+0x2280/0x3a40 mm/memory.c:5097
       handle_mm_fault+0x1cc/0x780 mm/memory.c:5218
       do_user_addr_fault+0x475/0x1210 arch/x86/mm/fault.c:1428
       handle_page_fault arch/x86/mm/fault.c:1519 [inline]
       exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1575
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570

-> #0 (&mm->mmap_lock#2){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
       lock_acquire kernel/locking/lockdep.c:5668 [inline]
       lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
       __might_fault mm/memory.c:5646 [inline]
       __might_fault+0x10c/0x180 mm/memory.c:5639
       _copy_to_user+0x29/0x150 lib/usercopy.c:29
       copy_to_user include/linux/uaccess.h:169 [inline]
       btrfs_ioctl_get_subvol_rootref+0x74e/0xad0 fs/btrfs/ioctl.c:3203
       btrfs_ioctl+0x2de6/0x5be0 fs/btrfs/ioctl.c:5556
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock#2 --> &fs_info->reloc_mutex --> btrfs-root-00

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-root-00);
                               lock(&fs_info->reloc_mutex);
                               lock(btrfs-root-00);
  lock(&mm->mmap_lock#2);

 *** DEADLOCK ***

1 lock held by syz-executor.2/3014:
 #0: ffff888074c05838 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x350 fs/btrfs/locking.c:134

stack backtrace:
CPU: 0 PID: 3014 Comm: syz-executor.2 Not tainted 6.1.0-rc5-syzkaller-00144-g84368d882b96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain kernel/locking/lockdep.c:3831 [inline]
 __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
 __might_fault mm/memory.c:5646 [inline]
 __might_fault+0x10c/0x180 mm/memory.c:5639
 _copy_to_user+0x29/0x150 lib/usercopy.c:29
 copy_to_user include/linux/uaccess.h:169 [inline]
 btrfs_ioctl_get_subvol_rootref+0x74e/0xad0 fs/btrfs/ioctl.c:3203
 btrfs_ioctl+0x2de6/0x5be0 fs/btrfs/ioctl.c:5556
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff87c68b639
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff87d4d8168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff87c7abf80 RCX: 00007ff87c68b639
RDX: 0000000020002100 RSI: 00000000d000943d RDI: 0000000000000004
RBP: 00007ff87c6e6ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc712f14ff R14: 00007ff87d4d8300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
