Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69108629003
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 03:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiKOCkp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 21:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiKOCkn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 21:40:43 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7B9642E
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 18:40:42 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id o10-20020a056e02102a00b003006328df7bso10457552ilj.17
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 18:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AwywVRkZYtsJ+bP4m6rF25XGCLzNCFV5QYizmq9aNrg=;
        b=rxOqE1cko30NwrTc01u74mNUFW425gj6zklN1OKfYqJAZ7IBRifPyXM9YbNIYKWkeo
         ld+yGpS1anSU+upuXqEjv1lKvuLPyDaCAgZIyh986tNNnkX1fFzGz23bgiANRBlef9HR
         AT8ACRe27q60oDt9Z+9vojSgR+LopIi6Zl04tyhrZ8t/V4sxf+OUB81qYnqJFk/+adg1
         yxh97P4cLC4p1ifN6zUG9tHMaL9Jkh64A08rNYI5rcNJNBju1CLzobMevlGF+ju2u75U
         PfQy6n0Tr7+udzws7kixfCyAkXZZI2iqTi8/3FL9xHB7e68Zk0EdrfodkHiFEp6v/17i
         yynA==
X-Gm-Message-State: ANoB5plzgJSet1OSk5Yg97b8VII48XWeEEeEMCXigly23GKhCVQXPVT3
        xU0264UxU0Hn0n7nkGbaA1KxHO9Ylw31ch2aftmVrtT9niUw
X-Google-Smtp-Source: AA0mqf4IvFOrJHWUJqZihrBkUA1MedkFZVsIcEMEYpzK4ANaH8ekVxDTzeKKnmR/z+imW+ldBlu/7Pxy5UYQowwb1zUp/fG67pbm
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1483:b0:376:91d:b188 with SMTP id
 j3-20020a056638148300b00376091db188mr4527225jak.49.1668480041695; Mon, 14 Nov
 2022 18:40:41 -0800 (PST)
Date:   Mon, 14 Nov 2022 18:40:41 -0800
In-Reply-To: <0000000000008f0ed405ed71ef58@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033405805ed794899@google.com>
Subject: Re: [syzbot] possible deadlock in btrfs_dirty_inode
From:   syzbot <syzbot+37edf86c9b60581e523f@syzkaller.appspotmail.com>
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    e01d50cbd6ee Merge tag 'vfio-v6.1-rc6' of https://github.c..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=149ca515880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47b0b2ecc119b39f
dashboard link: https://syzkaller.appspot.com/bug?extid=37edf86c9b60581e523f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140c35d1880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10df68e6880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b48e4d485e7e/disk-e01d50cb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dc9ba558e055/vmlinux-e01d50cb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b766d9815123/bzImage-e01d50cb.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/690a6e936871/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+37edf86c9b60581e523f@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc5-syzkaller-00008-ge01d50cbd6ee #0 Not tainted
------------------------------------------------------
syz-executor589/3733 is trying to acquire lock:
ffff88807658c650 (sb_internal#2){.+.+}-{0:0}, at: btrfs_dirty_inode+0xcc/0x1c0 fs/btrfs/inode.c:6085

but task is already holding lock:
ffff88807d23acd8 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
ffff88807d23acd8 (&mm->mmap_lock#2){++++}-{3:3}, at: vm_mmap_pgoff+0x14d/0x2b0 mm/util.c:518

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&mm->mmap_lock#2){++++}-{3:3}:
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

-> #4 (btrfs-root-00){++++}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       down_read_nested+0x3c/0x50 kernel/locking/rwsem.c:1634
       __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
       btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
       btrfs_read_lock_root_node+0x2b4/0x400 fs/btrfs/locking.c:279
       btrfs_search_slot_get_root fs/btrfs/ctree.c:1665 [inline]
       btrfs_search_slot+0x495/0x2fe0 fs/btrfs/ctree.c:1985
       btrfs_update_root+0xf0/0xc60 fs/btrfs/root-tree.c:132
       commit_fs_roots+0x4d3/0x710 fs/btrfs/transaction.c:1441
       btrfs_commit_transaction+0x147f/0x3760 fs/btrfs/transaction.c:2353
       sync_filesystem+0x1bc/0x220 fs/sync.c:66
       generic_shutdown_super+0x6b/0x310 fs/super.c:474
       kill_anon_super+0x36/0x60 fs/super.c:1086
       btrfs_kill_super+0x3d/0x50 fs/btrfs/super.c:2441
       deactivate_locked_super+0xa7/0xf0 fs/super.c:332
       cleanup_mnt+0x494/0x520 fs/namespace.c:1186
       task_work_run+0x243/0x300 kernel/task_work.c:179
       ptrace_notify+0x29a/0x340 kernel/signal.c:2354
       ptrace_report_syscall include/linux/ptrace.h:420 [inline]
       ptrace_report_syscall_exit include/linux/ptrace.h:482 [inline]
       syscall_exit_work+0x8c/0xe0 kernel/entry/common.c:251
       syscall_exit_to_user_mode_prepare+0x63/0xc0 kernel/entry/common.c:278
       __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
       syscall_exit_to_user_mode+0xa/0x60 kernel/entry/common.c:296
       do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #3 (&fs_info->reloc_mutex){+.+.}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       btrfs_record_root_in_trans+0x153/0x180 fs/btrfs/transaction.c:484
       start_transaction+0x3af/0x1180 fs/btrfs/transaction.c:721
       btrfs_create_common+0x2c6/0x420 fs/btrfs/inode.c:6633
       lookup_open fs/namei.c:3413 [inline]
       open_last_lookups fs/namei.c:3481 [inline]
       path_openat+0x12d0/0x2df0 fs/namei.c:3710
       do_filp_open+0x264/0x4f0 fs/namei.c:3740
       do_sys_openat2+0x124/0x4e0 fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_open fs/open.c:1334 [inline]
       __se_sys_open fs/open.c:1330 [inline]
       __x64_sys_open+0x221/0x270 fs/open.c:1330
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (btrfs_trans_num_extwriters){++++}-{0:0}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       join_transaction+0x19f/0xe60 fs/btrfs/transaction.c:299
       start_transaction+0x6fb/0x1180 fs/btrfs/transaction.c:658
       btrfs_create_common+0x2c6/0x420 fs/btrfs/inode.c:6633
       lookup_open fs/namei.c:3413 [inline]
       open_last_lookups fs/namei.c:3481 [inline]
       path_openat+0x12d0/0x2df0 fs/namei.c:3710
       do_filp_open+0x264/0x4f0 fs/namei.c:3740
       do_sys_openat2+0x124/0x4e0 fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_open fs/open.c:1334 [inline]
       __se_sys_open fs/open.c:1330 [inline]
       __x64_sys_open+0x221/0x270 fs/open.c:1330
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (btrfs_trans_num_writers){++++}-{0:0}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       join_transaction+0x17a/0xe60 fs/btrfs/transaction.c:298
       start_transaction+0x6fb/0x1180 fs/btrfs/transaction.c:658
       btrfs_create_common+0x2c6/0x420 fs/btrfs/inode.c:6633
       lookup_open fs/namei.c:3413 [inline]
       open_last_lookups fs/namei.c:3481 [inline]
       path_openat+0x12d0/0x2df0 fs/namei.c:3710
       do_filp_open+0x264/0x4f0 fs/namei.c:3740
       do_sys_openat2+0x124/0x4e0 fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_open fs/open.c:1334 [inline]
       __se_sys_open fs/open.c:1330 [inline]
       __x64_sys_open+0x221/0x270 fs/open.c:1330
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (sb_internal#2){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1826 [inline]
       sb_start_intwrite include/linux/fs.h:1948 [inline]
       start_transaction+0x5cb/0x1180 fs/btrfs/transaction.c:652
       btrfs_dirty_inode+0xcc/0x1c0 fs/btrfs/inode.c:6085
       inode_update_time fs/inode.c:1871 [inline]
       touch_atime+0x315/0x630 fs/inode.c:1944
       file_accessed include/linux/fs.h:2521 [inline]
       btrfs_file_mmap+0xbb/0x120 fs/btrfs/file.c:2333
       call_mmap include/linux/fs.h:2196 [inline]
       mmap_region+0xfe6/0x1e20 mm/mmap.c:2625
       do_mmap+0x8d9/0xf30 mm/mmap.c:1412
       vm_mmap_pgoff+0x19e/0x2b0 mm/util.c:520
       ksys_mmap_pgoff+0x48c/0x6d0 mm/mmap.c:1458
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  sb_internal#2 --> btrfs-root-00 --> &mm->mmap_lock#2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mm->mmap_lock#2);
                               lock(btrfs-root-00);
                               lock(&mm->mmap_lock#2);
  lock(sb_internal#2);

 *** DEADLOCK ***

2 locks held by syz-executor589/3733:
 #0: ffff88807d23acd8 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #0: ffff88807d23acd8 (&mm->mmap_lock#2){++++}-{3:3}, at: vm_mmap_pgoff+0x14d/0x2b0 mm/util.c:518
 #1: ffff88807658c460 (sb_writers#9){.+.+}-{0:0}, at: file_accessed include/linux/fs.h:2521 [inline]
 #1: ffff88807658c460 (sb_writers#9){.+.+}-{0:0}, at: btrfs_file_mmap+0xbb/0x120 fs/btrfs/file.c:2333

stack backtrace:
CPU: 0 PID: 3733 Comm: syz-executor589 Not tainted 6.1.0-rc5-syzkaller-00008-ge01d50cbd6ee #0
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
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 __sb_start_write include/linux/fs.h:1826 [inline]
 sb_start_intwrite include/linux/fs.h:1948 [inline]
 start_transaction+0x5cb/0x1180 fs/btrfs/transaction.c:652
 btrfs_dirty_inode+0xcc/0x1c0 fs/btrfs/inode.c:6085
 inode_update_time fs/inode.c:1871 [inline]
 touch_atime+0x315/0x630 fs/inode.c:1944
 file_accessed include/linux/fs.h:2521 [inline]
 btrfs_file_mmap+0xbb/0x120 fs/btrfs/file.c:2333
 call_mmap include/linux/fs.h:2196 [inline]
 mmap_region+0xfe6/0x1e20 mm/mmap.c:2625
 do_mmap+0x8d9/0xf30 mm/mmap.c:1412
 vm_mmap_pgoff+0x19e/0x2b0 mm/util.c:520
 ksys_mmap_pgoff+0x48c/0x6d0 mm/mmap.c:1458
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f714153d709
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffda0941a38 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f7141585938 RCX: 00007f714153d709
RDX: 0000000000000001 RSI: 0000000000400000 RDI: 0000000020000000
RBP: 00007f7141585850 R08: 0000000000000006 R09: 0000000000000000
R10: 0000000000010012 R11: 0000000000000246 R12: 00007f7141585708
R13: 00007f71415856a0 R14: 00007ffda0941a80 R15: 0000000000000006
 </TASK>

