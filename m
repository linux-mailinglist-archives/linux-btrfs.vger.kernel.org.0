Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3796F63753E
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Nov 2022 10:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiKXJfr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Nov 2022 04:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXJfp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Nov 2022 04:35:45 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B1310EA0B
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Nov 2022 01:35:40 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id o15-20020a6bf80f000000b006de313e5cfeso637794ioh.6
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Nov 2022 01:35:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbHAeu8qZKyYCKZr5sAHM/3CSGxCDCesjZ/Fy33E3MA=;
        b=QSrKjWJjcaH8+X0xY2zUZIEybONWGMTJvnyqIr7Oa9GxBtA4t6LzL7Y2bzxYrFokLV
         MS3Nij8dbxX2WEe8atJ4j+dHVV855GOLe2RLuDCLwOGIJRFEERhnzk9ZRgnDH3wefzjF
         Ja1H3isqvJdirUVK7ZaOhP1bZDHC3gHw5QOSva6rrpj6GdsdKRSaWgSMKVE9M9gSc9cI
         JMRcUqa/o5ArP6ih3aawuaUp555z55pDpLU6K0hj38V7V6fiXRh/s2/zi1Hzt10UN7fO
         3WLVZ+Mu3i7s/kZLSPAaBoHTcYiYBaB9+IWzo2kPWc9JgqhswnH+jOMHPhOc+ykn/Ztc
         Ep+Q==
X-Gm-Message-State: ANoB5pnUXD802o3aU7H0Ec+G00qQUeumiRPDaMn3i5x8lvtKc1VvihIM
        z/qhIQkFNth9WazOGBvJPbibRIA6pywtmAIUz2ctfDEX2lR7
X-Google-Smtp-Source: AA0mqf7u+qaeuGXd8xksklfMnXCIQ8sdeNtaeWGOXrvA903TbnJ+9tplDNKRvGkYKOR6jVBKViW+UMvrFFW1XHbWwHVD3sFM4Stt
MIME-Version: 1.0
X-Received: by 2002:a02:cc12:0:b0:386:3792:8569 with SMTP id
 n18-20020a02cc12000000b0038637928569mr3961632jap.76.1669282540359; Thu, 24
 Nov 2022 01:35:40 -0800 (PST)
Date:   Thu, 24 Nov 2022 01:35:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d916f405ee34206b@google.com>
Subject: [syzbot] possible deadlock in btrfs_join_transaction
From:   syzbot <syzbot+6eb64eace626d6222d2a@syzkaller.appspotmail.com>
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

HEAD commit:    9500fc6e9e60 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=173a95f9880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b25c9f218686dd5e
dashboard link: https://syzkaller.appspot.com/bug?extid=6eb64eace626d6222d2a
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1363e60652f7/disk-9500fc6e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fcc4da811bb6/vmlinux-9500fc6e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b554298f1fa/Image-9500fc6e.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6eb64eace626d6222d2a@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc5-syzkaller-32269-g9500fc6e9e60 #0 Not tainted
------------------------------------------------------
syz-executor.4/30618 is trying to acquire lock:
ffff0000d3bca650 (sb_internal#2){.+.+}-{0:0}, at: btrfs_join_transaction+0x30/0x40 fs/btrfs/transaction.c:764

but task is already holding lock:
ffff0000d3bca558 (sb_pagefaults#2){.+.+}-{0:0}, at: do_page_mkwrite+0x74/0x288 mm/memory.c:2978

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (sb_pagefaults#2){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1826 [inline]
       sb_start_pagefault include/linux/fs.h:1930 [inline]
       btrfs_page_mkwrite+0xb4/0x6fc fs/btrfs/inode.c:8415
       do_page_mkwrite+0x74/0x288 mm/memory.c:2978
       do_shared_fault mm/memory.c:4619 [inline]
       do_fault+0x274/0x550 mm/memory.c:4687
       handle_pte_fault mm/memory.c:4955 [inline]
       __handle_mm_fault mm/memory.c:5097 [inline]
       handle_mm_fault+0x78c/0xa48 mm/memory.c:5218
       __do_page_fault arch/arm64/mm/fault.c:512 [inline]
       do_page_fault+0x428/0x79c arch/arm64/mm/fault.c:612
       do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:695
       do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:831
       el0_da+0x70/0x16c arch/arm64/kernel/entry-common.c:515
       el0t_64_sync_handler+0xcc/0xf0 arch/arm64/kernel/entry-common.c:658
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #4 (&mm->mmap_lock){++++}-{3:3}:
       __might_fault+0x7c/0xb4 mm/memory.c:5646
       _copy_to_user include/linux/uaccess.h:143 [inline]
       copy_to_user include/linux/uaccess.h:169 [inline]
       btrfs_ioctl_get_subvol_rootref+0x3a8/0x4bc fs/btrfs/ioctl.c:3203
       btrfs_ioctl+0xa08/0xa64 fs/btrfs/ioctl.c:5556
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __arm64_sys_ioctl+0xd0/0x140 fs/ioctl.c:856
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #3 (btrfs-root-00){++++}-{3:3}:
       down_read_nested+0x64/0x84 kernel/locking/rwsem.c:1634
       __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
       btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
       btrfs_read_lock_root_node+0x13c/0x1c0 fs/btrfs/locking.c:279
       btrfs_search_slot_get_root+0x8c/0x374 fs/btrfs/ctree.c:1665
       btrfs_search_slot+0x1dc/0x107c fs/btrfs/ctree.c:1985
       btrfs_del_root+0x50/0xd0 fs/btrfs/root-tree.c:317
       btrfs_clear_free_space_tree+0x268/0x49c fs/btrfs/free-space-tree.c:1273
       btrfs_start_pre_rw_mount+0x128/0x380 fs/btrfs/disk-io.c:3210
       open_ctree+0xb70/0xdc8 fs/btrfs/disk-io.c:3792
       btrfs_fill_super+0xc0/0x174 fs/btrfs/super.c:1461
       btrfs_mount_root+0x4a4/0x558 fs/btrfs/super.c:1829
       legacy_get_tree+0x30/0x74 fs/fs_context.c:610
       vfs_get_tree+0x40/0x140 fs/super.c:1531
       fc_mount fs/namespace.c:1043 [inline]
       vfs_kern_mount+0xe0/0x140 fs/namespace.c:1073
       btrfs_mount+0x20c/0x5e8 fs/btrfs/super.c:1889
       legacy_get_tree+0x30/0x74 fs/fs_context.c:610
       vfs_get_tree+0x40/0x140 fs/super.c:1531
       do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
       path_mount+0x358/0x890 fs/namespace.c:3370
       do_mount fs/namespace.c:3383 [inline]
       __do_sys_mount fs/namespace.c:3591 [inline]
       __se_sys_mount fs/namespace.c:3568 [inline]
       __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #2 (btrfs_trans_num_extwriters){++++}-{0:0}:
       join_transaction+0x10c/0x65c fs/btrfs/transaction.c:299
       start_transaction+0x460/0x944 fs/btrfs/transaction.c:658
       btrfs_join_transaction+0x30/0x40 fs/btrfs/transaction.c:764
       btrfs_commit_super+0x64/0xa0 fs/btrfs/disk-io.c:4496
       close_ctree+0x1dc/0x60c fs/btrfs/disk-io.c:4653
       btrfs_put_super+0x20/0x30 fs/btrfs/super.c:394
       generic_shutdown_super+0x94/0x198 fs/super.c:492
       kill_anon_super+0x24/0x44 fs/super.c:1086
       btrfs_kill_super+0x24/0x3c fs/btrfs/super.c:2441
       deactivate_locked_super+0x70/0xe8 fs/super.c:332
       deactivate_super+0xd0/0xd4 fs/super.c:363
       cleanup_mnt+0x184/0x1c0 fs/namespace.c:1186
       __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
       task_work_run+0x100/0x148 kernel/task_work.c:179
       resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
       do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
       prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
       exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
       el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:638
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #1 (btrfs_trans_num_writers){++++}-{0:0}:
       join_transaction+0xe8/0x65c fs/btrfs/transaction.c:298
       start_transaction+0x460/0x944 fs/btrfs/transaction.c:658
       btrfs_join_transaction+0x30/0x40 fs/btrfs/transaction.c:764
       btrfs_commit_super+0x64/0xa0 fs/btrfs/disk-io.c:4496
       close_ctree+0x1dc/0x60c fs/btrfs/disk-io.c:4653
       btrfs_put_super+0x20/0x30 fs/btrfs/super.c:394
       generic_shutdown_super+0x94/0x198 fs/super.c:492
       kill_anon_super+0x24/0x44 fs/super.c:1086
       btrfs_kill_super+0x24/0x3c fs/btrfs/super.c:2441
       deactivate_locked_super+0x70/0xe8 fs/super.c:332
       deactivate_super+0xd0/0xd4 fs/super.c:363
       cleanup_mnt+0x184/0x1c0 fs/namespace.c:1186
       __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
       task_work_run+0x100/0x148 kernel/task_work.c:179
       resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
       do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
       prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
       exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
       el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:638
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #0 (sb_internal#2){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x1530/0x3084 kernel/locking/lockdep.c:5055
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1826 [inline]
       sb_start_intwrite include/linux/fs.h:1948 [inline]
       start_transaction+0x360/0x944 fs/btrfs/transaction.c:652
       btrfs_join_transaction+0x30/0x40 fs/btrfs/transaction.c:764
       btrfs_dirty_inode+0x4c/0x13c fs/btrfs/inode.c:6085
       btrfs_update_time+0x120/0x138 fs/btrfs/inode.c:6127
       inode_update_time fs/inode.c:1871 [inline]
       __file_update_time fs/inode.c:2088 [inline]
       file_update_time+0x194/0x2c0 fs/inode.c:2119
       btrfs_page_mkwrite+0x204/0x6fc fs/btrfs/inode.c:8431
       do_page_mkwrite+0x74/0x288 mm/memory.c:2978
       do_shared_fault mm/memory.c:4619 [inline]
       do_fault+0x274/0x550 mm/memory.c:4687
       handle_pte_fault mm/memory.c:4955 [inline]
       __handle_mm_fault mm/memory.c:5097 [inline]
       handle_mm_fault+0x78c/0xa48 mm/memory.c:5218
       __do_page_fault arch/arm64/mm/fault.c:512 [inline]
       do_page_fault+0x428/0x79c arch/arm64/mm/fault.c:612
       do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:695
       do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:831
       el0_da+0x70/0x16c arch/arm64/kernel/entry-common.c:515
       el0t_64_sync_handler+0xcc/0xf0 arch/arm64/kernel/entry-common.c:658
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

other info that might help us debug this:

Chain exists of:
  sb_internal#2 --> &mm->mmap_lock --> sb_pagefaults#2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sb_pagefaults#2);
                               lock(&mm->mmap_lock);
                               lock(sb_pagefaults#2);
  lock(sb_internal#2);

 *** DEADLOCK ***

2 locks held by syz-executor.4/30618:
 #0: ffff0000c0e15648 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 #0: ffff0000c0e15648 (&mm->mmap_lock){++++}-{3:3}, at: do_page_fault+0x3c8/0x79c arch/arm64/mm/fault.c:597
 #1: ffff0000d3bca558 (sb_pagefaults#2){.+.+}-{0:0}, at: do_page_mkwrite+0x74/0x288 mm/memory.c:2978

stack backtrace:
CPU: 0 PID: 30618 Comm: syz-executor.4 Not tainted 6.1.0-rc5-syzkaller-32269-g9500fc6e9e60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 print_circular_bug+0x2c4/0x2c8 kernel/locking/lockdep.c:2055
 check_noncircular+0x14c/0x154 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain kernel/locking/lockdep.c:3831 [inline]
 __lock_acquire+0x1530/0x3084 kernel/locking/lockdep.c:5055
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 __sb_start_write include/linux/fs.h:1826 [inline]
 sb_start_intwrite include/linux/fs.h:1948 [inline]
 start_transaction+0x360/0x944 fs/btrfs/transaction.c:652
 btrfs_join_transaction+0x30/0x40 fs/btrfs/transaction.c:764
 btrfs_dirty_inode+0x4c/0x13c fs/btrfs/inode.c:6085
 btrfs_update_time+0x120/0x138 fs/btrfs/inode.c:6127
 inode_update_time fs/inode.c:1871 [inline]
 __file_update_time fs/inode.c:2088 [inline]
 file_update_time+0x194/0x2c0 fs/inode.c:2119
 btrfs_page_mkwrite+0x204/0x6fc fs/btrfs/inode.c:8431
 do_page_mkwrite+0x74/0x288 mm/memory.c:2978
 do_shared_fault mm/memory.c:4619 [inline]
 do_fault+0x274/0x550 mm/memory.c:4687
 handle_pte_fault mm/memory.c:4955 [inline]
 __handle_mm_fault mm/memory.c:5097 [inline]
 handle_mm_fault+0x78c/0xa48 mm/memory.c:5218
 __do_page_fault arch/arm64/mm/fault.c:512 [inline]
 do_page_fault+0x428/0x79c arch/arm64/mm/fault.c:612
 do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:695
 do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:831
 el0_da+0x70/0x16c arch/arm64/kernel/entry-common.c:515
 el0t_64_sync_handler+0xcc/0xf0 arch/arm64/kernel/entry-common.c:658
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
