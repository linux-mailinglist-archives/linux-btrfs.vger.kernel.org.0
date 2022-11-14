Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A00362878E
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 18:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbiKNRzV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 12:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbiKNRyv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 12:54:51 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A9C19C21
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 09:54:50 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id f23-20020a6b5117000000b006dbd4e6a5abso6146437iob.17
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 09:54:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOkCdzlE+Hz4uAljsp5Prv0NV09WuaTUlB724G5H6Cs=;
        b=Wolm0Vyz45AQKwtj5bjiwPPSlvIZHTF2/8guAkxY0jTeNNTj5FZyzSLZ4k6i/3Ruj8
         j1kDENhCpbvJSaHDgon4umkcBWBw54Dl9pEmuNcv04TsITQBTxCVm9SeSpHTYrZpEiGt
         g8baRtyDobeOgbZcUECLYa3iDLUJmJsU3Rbx8TqrgZV3ifcfkIwfTF8hP+ngJMZcjmJE
         cHTVh6gmaE27GyzqrXQaTtMIufzJthMh/l7aubU0Y06VfrvWwZQTw5uHoUFKyu5MX8Zf
         5lJVBG1TQX+A6Vm7W3VpPiLJf3CiT6T1jOVSO1uQyZJipWzoTQT0wPPexYEpdvMnuRMH
         vTFg==
X-Gm-Message-State: ANoB5pltwSjLKKA+/YKBf8vspyZN5DocYkB4CapPtHzkzH9zfySTO1iK
        HlCMS0AEaC8BuHtu1PeCE666CEJdLfe/nMdyiUAPOn/9GMre
X-Google-Smtp-Source: AA0mqf6Vst1Qwu8P/BCAZBhut/2dLa3okbbru7XoD+m8w0UUPU5nGelJW9Iool62tb4tSOrQ8dHV6GzLBeah35PppaHt/NFnFTkl
MIME-Version: 1.0
X-Received: by 2002:a05:6638:f84:b0:375:9e02:b459 with SMTP id
 h4-20020a0566380f8400b003759e02b459mr6085261jal.30.1668448489768; Mon, 14 Nov
 2022 09:54:49 -0800 (PST)
Date:   Mon, 14 Nov 2022 09:54:49 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f0ed405ed71ef58@google.com>
Subject: [syzbot] possible deadlock in btrfs_dirty_inode
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

Hello,

syzbot found the following issue on:

HEAD commit:    094226ad94f4 Linux 6.1-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152efa11880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b338c1b9de0823a3
dashboard link: https://syzkaller.appspot.com/bug?extid=37edf86c9b60581e523f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3b689839e3f5/disk-094226ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a4f2a27061e6/vmlinux-094226ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/37b109ab179c/bzImage-094226ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+37edf86c9b60581e523f@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc5-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.2/15801 is trying to acquire lock:
ffff88807b322650 (sb_internal#2){.+.+}-{0:0}, at: btrfs_dirty_inode+0xcc/0x1c0 fs/btrfs/inode.c:6085

but task is already holding lock:
ffff888027b98fd8 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
ffff888027b98fd8 (&mm->mmap_lock#2){++++}-{3:3}, at: vm_mmap_pgoff+0x14d/0x2b0 mm/util.c:518

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&mm->mmap_lock#2){++++}-{3:3}:
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

-> #3 (btrfs-root-00){++++}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       down_read_nested+0x3c/0x50 kernel/locking/rwsem.c:1634
       __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
       btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
       btrfs_read_lock_root_node+0x2b4/0x400 fs/btrfs/locking.c:279
       btrfs_search_slot_get_root fs/btrfs/ctree.c:1665 [inline]
       btrfs_search_slot+0x495/0x2fe0 fs/btrfs/ctree.c:1985
       __lookup_free_space_inode fs/btrfs/free-space-cache.c:87 [inline]
       lookup_free_space_inode+0x272/0x820 fs/btrfs/free-space-cache.c:134
       btrfs_remove_free_space_inode+0xe3/0x470 fs/btrfs/free-space-cache.c:246
       cleanup_free_space_cache_v1 fs/btrfs/free-space-cache.c:4092 [inline]
       btrfs_set_free_space_cache_v1_active+0xf1/0x210 fs/btrfs/free-space-cache.c:4120
       btrfs_start_pre_rw_mount+0x3fe/0x660 fs/btrfs/disk-io.c:3265
       open_ctree+0x27e6/0x2d6d fs/btrfs/disk-io.c:3792
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
       btrfs_create_common+0x2c6/0x420 fs/btrfs/inode.c:6633
       lookup_open fs/namei.c:3413 [inline]
       open_last_lookups fs/namei.c:3481 [inline]
       path_openat+0x12d0/0x2df0 fs/namei.c:3710
       do_filp_open+0x264/0x4f0 fs/namei.c:3740
       do_sys_openat2+0x124/0x4e0 fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_openat fs/open.c:1342 [inline]
       __se_sys_openat fs/open.c:1337 [inline]
       __x64_sys_openat+0x243/0x290 fs/open.c:1337
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
       __do_sys_openat fs/open.c:1342 [inline]
       __se_sys_openat fs/open.c:1337 [inline]
       __x64_sys_openat+0x243/0x290 fs/open.c:1337
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
       mmap_region+0xff6/0x1e00 mm/mmap.c:2625
       do_mmap+0x8d9/0xf60 mm/mmap.c:1412
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

2 locks held by syz-executor.2/15801:
 #0: ffff888027b98fd8 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #0: ffff888027b98fd8 (&mm->mmap_lock#2){++++}-{3:3}, at: vm_mmap_pgoff+0x14d/0x2b0 mm/util.c:518
 #1: ffff88807b322460 (sb_writers#17){.+.+}-{0:0}, at: file_accessed include/linux/fs.h:2521 [inline]
 #1: ffff88807b322460 (sb_writers#17){.+.+}-{0:0}, at: btrfs_file_mmap+0xbb/0x120 fs/btrfs/file.c:2333

stack backtrace:
CPU: 1 PID: 15801 Comm: syz-executor.2 Not tainted 6.1.0-rc5-syzkaller #0
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
 mmap_region+0xff6/0x1e00 mm/mmap.c:2625
 do_mmap+0x8d9/0xf60 mm/mmap.c:1412
 vm_mmap_pgoff+0x19e/0x2b0 mm/util.c:520
 ksys_mmap_pgoff+0x48c/0x6d0 mm/mmap.c:1458
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4d3fe8b639
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4d40c4e168 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f4d3ffac050 RCX: 00007f4d3fe8b639
RDX: 0000000000000002 RSI: 0000000000b36000 RDI: 0000000020000000
RBP: 00007f4d3fee6ae9 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000028011 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffedddb50ff R14: 00007f4d40c4e300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
