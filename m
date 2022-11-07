Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0661261FD91
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 19:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiKGSaB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Nov 2022 13:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbiKGS36 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Nov 2022 13:29:58 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2141902A
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 10:29:52 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id x21-20020a5d9455000000b006bc1172e639so7709488ior.18
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Nov 2022 10:29:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILXgDeED0B9TieOZ1yhu4rMHPM18i/4CeVyvudKaPP8=;
        b=qtQ/wCHOJoF1kWYwTfCTSpDxqCFK85C+hiwcS7mwAdrVFUVT7p1motIXpzS/mWm2O+
         R4A+fbivQjg+oIQfocFamQhRGOO0aSyO8GIzUdShDWYzpeJII3evN/m4Sr4PZJ820s20
         D61mtPlPKLRK7pHPo9eM3l6OTLQ3nKcbpv5TrmbZQKUSiqENvsEhaXuHcKkn040noE86
         3mDuyr8fxdo/6RR5d6TL1dzBfMW3mo62slWMMstPfnVMQMsT+UnwqElN8uQFT4sFwGkB
         wMj6o2f5pP63yBIYoKpiC6IEY9SJdzvFeNISqT0OU4rbQQLYU268dQq0e1yIV0QWiOU9
         oeeg==
X-Gm-Message-State: ACrzQf2chxNJ2fgt5HP2Cgx3aVBLt1WiV+D5KT70odB32JizlBOO/nN/
        CG0SKN/m7n7tAlUPpHMQX3oCHGXYN8HQX8/dm+h5nVE2PigM
X-Google-Smtp-Source: AMsMyM7oXP1WtFevwDBtmgOdu03qyjgu1zf89PWRBtzdXhD+z8wKRhMDmfNKPvkejJS5rNtI1TL6dZrntC/La9OdYtX7SgDhptMt
MIME-Version: 1.0
X-Received: by 2002:a05:6638:264c:b0:375:2a59:683c with SMTP id
 n12-20020a056638264c00b003752a59683cmr29825763jat.232.1667845792271; Mon, 07
 Nov 2022 10:29:52 -0800 (PST)
Date:   Mon, 07 Nov 2022 10:29:52 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd151d05ece59b42@google.com>
Subject: [syzbot] possible deadlock in btrfs_search_slot
From:   syzbot <syzbot+c06034aecf9f5eab1ac1@syzkaller.appspotmail.com>
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

HEAD commit:    f0c4d9fc9cc9 Linux 6.1-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d158fe880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=771b06c41e08f95b
dashboard link: https://syzkaller.appspot.com/bug?extid=c06034aecf9f5eab1ac1
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8c210d1cda58/disk-f0c4d9fc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ab3065e17b8b/vmlinux-f0c4d9fc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/739b786269f4/bzImage-f0c4d9fc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c06034aecf9f5eab1ac1@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc4-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.1/21431 is trying to acquire lock:
ffff888028341e58 (&mm->mmap_lock#2){++++}-{3:3}, at: __might_fault+0x8f/0x110 mm/memory.c:5645

but task is already holding lock:
ffff888020a77838 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
ffff888020a77838 (btrfs-root-00){++++}-{3:3}, at: btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
ffff888020a77838 (btrfs-root-00){++++}-{3:3}, at: btrfs_read_lock_root_node+0x2b4/0x400 fs/btrfs/locking.c:279

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (btrfs-root-00){++++}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       down_read_nested+0x3c/0x50 kernel/locking/rwsem.c:1634
       __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
       btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
       btrfs_read_lock_root_node+0x2b4/0x400 fs/btrfs/locking.c:279
       btrfs_search_slot_get_root fs/btrfs/ctree.c:1649 [inline]
       btrfs_search_slot+0x495/0x2fe0 fs/btrfs/ctree.c:1969
       btrfs_insert_empty_items fs/btrfs/ctree.c:4103 [inline]
       btrfs_insert_empty_item fs/btrfs/ctree.h:3127 [inline]
       btrfs_insert_item+0x199/0x3b0 fs/btrfs/ctree.c:4132
       btrfs_create_tree+0x7c9/0xc30 fs/btrfs/disk-io.c:1229
       btrfs_create_free_space_tree+0x116/0x1160 fs/btrfs/free-space-tree.c:1169
       btrfs_start_pre_rw_mount+0x4df/0x660 fs/btrfs/disk-io.c:3254
       open_ctree+0x27e6/0x2d6d fs/btrfs/disk-io.c:3790
       btrfs_fill_super+0x1c6/0x2d0 fs/btrfs/super.c:1461
       btrfs_mount_root+0x885/0x9a0 fs/btrfs/super.c:1829
       legacy_get_tree+0xea/0x180 fs/fs_context.c:610
       vfs_get_tree+0x88/0x270 fs/super.c:1531
       fc_mount fs/namespace.c:1043 [inline]
       vfs_kern_mount+0xc9/0x160 fs/namespace.c:1073
       btrfs_mount+0x3d3/0xbb0 fs/btrfs/super.c:1889
       legacy_get_tree+0xea/0x180 fs/fs_context.c:610
       vfs_get_tree+0x88/0x270 fs/super.c:1531
       do_new_mount+0x289/0xad0 fs/namespace.c:3040
       do_mount fs/namespace.c:3383 [inline]
       __do_sys_mount fs/namespace.c:3591 [inline]
       __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (btrfs_trans_num_extwriters){++++}-{0:0}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       join_transaction+0x19f/0xe60 fs/btrfs/transaction.c:299
       start_transaction+0x6fb/0x1180 fs/btrfs/transaction.c:658
       btrfs_commit_super+0x9a/0xd0 fs/btrfs/disk-io.c:4494
       close_ctree+0x3a7/0xbde fs/btrfs/disk-io.c:4651
       generic_shutdown_super+0x130/0x310 fs/super.c:492
       kill_anon_super+0x36/0x60 fs/super.c:1086
       btrfs_kill_super+0x3d/0x50 fs/btrfs/super.c:2441
       deactivate_locked_super+0xa7/0xf0 fs/super.c:332
       cleanup_mnt+0x494/0x520 fs/namespace.c:1186
       task_work_run+0x243/0x300 kernel/task_work.c:179
       resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
       exit_to_user_mode_loop+0x124/0x150 kernel/entry/common.c:171
       exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:203
       __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
       syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:296
       do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (btrfs_trans_num_writers){++++}-{0:0}:
       reacquire_held_locks+0x386/0x650 kernel/locking/lockdep.c:5193
       __lock_release kernel/locking/lockdep.c:5382 [inline]
       lock_release+0x2e2/0x820 kernel/locking/lockdep.c:5688
       percpu_up_read include/linux/percpu-rwsem.h:99 [inline]
       __sb_end_write include/linux/fs.h:1821 [inline]
       sb_end_intwrite+0x1e/0x1a0 include/linux/fs.h:1877
       __btrfs_end_transaction+0x388/0x790 fs/btrfs/transaction.c:995
       btrfs_dirty_inode+0x177/0x1c0 fs/btrfs/inode.c:6099
       inode_update_time fs/inode.c:1871 [inline]
       touch_atime+0x315/0x630 fs/inode.c:1944
       file_accessed include/linux/fs.h:2521 [inline]
       btrfs_file_mmap+0xbb/0x120 fs/btrfs/file.c:2333
       call_mmap include/linux/fs.h:2196 [inline]
       mmap_region+0x10c1/0x1da0 mm/mmap.c:2625
       do_mmap+0x8d9/0xf60 mm/mmap.c:1412
       vm_mmap_pgoff+0x19e/0x2b0 mm/util.c:520
       ksys_mmap_pgoff+0x48c/0x6d0 mm/mmap.c:1458
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&mm->mmap_lock#2){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __might_fault+0xb2/0x110 mm/memory.c:5646
       _copy_to_user+0x26/0x130 lib/usercopy.c:29
       copy_to_user include/linux/uaccess.h:169 [inline]
       btrfs_ioctl_get_subvol_rootref+0x8cf/0xa90 fs/btrfs/ioctl.c:3203
       btrfs_ioctl+0xb7c/0xc10 fs/btrfs/ioctl.c:5556
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock#2 --> btrfs_trans_num_extwriters --> btrfs-root-00

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-root-00);
                               lock(btrfs_trans_num_extwriters);
                               lock(btrfs-root-00);
  lock(&mm->mmap_lock#2);

 *** DEADLOCK ***

1 lock held by syz-executor.1/21431:
 #0: ffff888020a77838 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
 #0: ffff888020a77838 (btrfs-root-00){++++}-{3:3}, at: btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
 #0: ffff888020a77838 (btrfs-root-00){++++}-{3:3}, at: btrfs_read_lock_root_node+0x2b4/0x400 fs/btrfs/locking.c:279

stack backtrace:
CPU: 1 PID: 21431 Comm: syz-executor.1 Not tainted 6.1.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
 __might_fault+0xb2/0x110 mm/memory.c:5646
 _copy_to_user+0x26/0x130 lib/usercopy.c:29
 copy_to_user include/linux/uaccess.h:169 [inline]
 btrfs_ioctl_get_subvol_rootref+0x8cf/0xa90 fs/btrfs/ioctl.c:3203
 btrfs_ioctl+0xb7c/0xc10 fs/btrfs/ioctl.c:5556
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1a4f28b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1a4ffb1168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f1a4f3ac050 RCX: 00007f1a4f28b5a9
RDX: 0000000020058480 RSI: 00000000d000943d RDI: 0000000000000005
RBP: 00007f1a4f2e67b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc4fbced1f R14: 00007f1a4ffb1300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
