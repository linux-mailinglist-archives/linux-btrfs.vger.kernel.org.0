Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0EE636C22
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 22:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiKWVMo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 16:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbiKWVMn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 16:12:43 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C5CE017
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 13:12:41 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id x10-20020a056e021bca00b00302b6c0a683so9489422ilv.23
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 13:12:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6dPcC2y362ci0r0xewITGb2zxAQpc5oJw31st1MUisA=;
        b=HA95g2vTBCiL5w/mePT3g9bKcDW6mkwSdxeYkCSJ7XU2gh9SqSX11JF3/YjdHLkAlU
         psHlkUsfX5nWB+IqieklRSuLUJ3wxFF0H6n/S9adKT6YOxV6eRjzgNlzGg4T4XHf4CkV
         1+BrrXStqdADIi1QwPWtKArQbyk7cs1SCGcnf7To5RhsfAOQpp640DYtg9vkrAV7CPlO
         rutDtRpOhchgMuaOFFjlMORWxQjB9GkRQ6PDHVr3v2AGQeigwYhpI5Ao7kpC4tT1erFs
         hrzSFdrrSM0CSstC62OmxeHyPGIzT+up4VhMPivJTvMkmOJf0rw78O4U+YIkPgoJUDje
         BCJg==
X-Gm-Message-State: ANoB5plG9OuotfsO4mvZfwsO7koGFvZLoDt8ZMov/y6g16ssYo6mieEo
        QRinhC8gVFLM12XeB29JnBvmRJWo8oewCuN9ni5eOpPqYK/v
X-Google-Smtp-Source: AA0mqf6QlzV/nwj3As3W09/FVAfT3D/jheAu8yKCEzraiSCnt8h7HBvWymQzD5/R3yIWAUbJWTPBA+7wK+BiSRd3VW0mHIe2uB51
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5a5:b0:300:d831:8c90 with SMTP id
 k5-20020a056e0205a500b00300d8318c90mr6447427ils.21.1669237960493; Wed, 23 Nov
 2022 13:12:40 -0800 (PST)
Date:   Wed, 23 Nov 2022 13:12:40 -0800
In-Reply-To: <000000000000fd151d05ece59b42@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae550405ee29bffa@google.com>
Subject: Re: [syzbot] possible deadlock in btrfs_search_slot
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    eb7081409f94 Linux 6.1-rc6
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12afdce5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=c06034aecf9f5eab1ac1
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124fc309880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126dfde5880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/815bacde9ae6/disk-eb708140.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ce54e3220860/vmlinux-eb708140.xz
kernel image: https://storage.googleapis.com/syzbot-assets/52a8ac111c19/bzImage-eb708140.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a1ff934d6bf0/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c06034aecf9f5eab1ac1@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc6-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor338/3631 is trying to acquire lock:
ffff888077fa2598 (&mm->mmap_lock#2){++++}-{3:3}, at: __might_fault+0x8f/0x110 mm/memory.c:5645

but task is already holding lock:
ffff88807e7ba4d8 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
ffff88807e7ba4d8 (btrfs-root-00){++++}-{3:3}, at: btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
ffff88807e7ba4d8 (btrfs-root-00){++++}-{3:3}, at: btrfs_read_lock_root_node+0x2b4/0x400 fs/btrfs/locking.c:279

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

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
       flush_space+0x97c/0xbc0 fs/btrfs/space-info.c:810
       btrfs_async_reclaim_data_space+0x2a6/0x520 fs/btrfs/space-info.c:1315
       process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
       worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
       kthread+0x266/0x300 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

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
       __do_sys_creat fs/open.c:1402 [inline]
       __se_sys_creat fs/open.c:1396 [inline]
       __x64_sys_creat+0x11f/0x160 fs/open.c:1396
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
       __do_sys_creat fs/open.c:1402 [inline]
       __se_sys_creat fs/open.c:1396 [inline]
       __x64_sys_creat+0x11f/0x160 fs/open.c:1396
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
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
       mmap_region+0xfe6/0x1e20 mm/mmap.c:2625
       do_mmap+0x8d9/0xf30 mm/mmap.c:1412
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
  &mm->mmap_lock#2 --> &fs_info->reloc_mutex --> btrfs-root-00

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-root-00);
                               lock(&fs_info->reloc_mutex);
                               lock(btrfs-root-00);
  lock(&mm->mmap_lock#2);

 *** DEADLOCK ***

1 lock held by syz-executor338/3631:
 #0: ffff88807e7ba4d8 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
 #0: ffff88807e7ba4d8 (btrfs-root-00){++++}-{3:3}, at: btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
 #0: ffff88807e7ba4d8 (btrfs-root-00){++++}-{3:3}, at: btrfs_read_lock_root_node+0x2b4/0x400 fs/btrfs/locking.c:279

stack backtrace:
CPU: 1 PID: 3631 Comm: syz-executor338 Not tainted 6.1.0-rc6-syzkaller #0
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
RIP: 0033:0x7fedeabbefb9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd63c463b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffd63c463c8 RCX: 00007fedeabbefb9
RDX: 000000002005de40 RSI: 00000000d000943d RDI: 0000000000000006
RBP: 00007ffd63c463c0 R08: 00007ffd63c463c0 R09: 00007fedeab7c570
R10: 00007ffd63c463c0 R11: 0000000000000246 R12: 000000

