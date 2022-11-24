Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3266374E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Nov 2022 10:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiKXJNn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Nov 2022 04:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiKXJNm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Nov 2022 04:13:42 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37EA9B3A5
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Nov 2022 01:13:41 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id h10-20020a056e021b8a00b00302671bb5fdso873634ili.21
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Nov 2022 01:13:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K3v76XqUN0O34ow25tfS2F7/z8dx2+wNXyI/9WKpb8w=;
        b=qu2xghw+vvsI5rI4uWOvRHgFv7jsCF4iF/aUtO3o+/S18X4HbiMz5ijrJy5MDSHm5U
         rxK7SPcLdoQZeLlu7DMOy7B5qDZ3PejjZjnVkTB/lFMlUzrddmi1jEjlBUM8HxkgaeNq
         8Odnhw5T1zppu/4BXlKaE8HliAeSKFzEV8HIKdKUGzyUlLoi/O6iNOGCULqHR0bRcg60
         TC4VZPu1UnLXwR+LZmLUNk5JqHSIpKzAjRLUZV7402OzxRhQA9u5+OEHMdm9TiVNXjG3
         sMdQOxto+/cIEUUmo946Lz++FbEBzM6BuuAA/Ke06+kW7jtnJ5PypAYKoKQB/stLEYIl
         +Bpw==
X-Gm-Message-State: ANoB5plsuJRAyjAuqj+X/pqknUa9rfMMh5LMjqZVZSigQHUCSoGtDEEf
        JUjAqW71oEnSYGGuYJAotN/hqL4ww4xdhDQkQDnE4VovjgK1
X-Google-Smtp-Source: AA0mqf6ggOLVH6/6MwvjUEYQJfG5uxows8ComOx+XoHLnPE2UiwNUSDvqV26jTBp0RMp45cOz8G2Pv1bMtqH0t/gyOtpEotHDyMh
MIME-Version: 1.0
X-Received: by 2002:a02:8796:0:b0:378:8e28:1f8a with SMTP id
 t22-20020a028796000000b003788e281f8amr11343421jai.283.1669281221177; Thu, 24
 Nov 2022 01:13:41 -0800 (PST)
Date:   Thu, 24 Nov 2022 01:13:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037f84b05ee33d2b4@google.com>
Subject: [syzbot] possible deadlock in btrfs_search_forward
From:   syzbot <syzbot+3cf137e672e75b602171@syzkaller.appspotmail.com>
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

HEAD commit:    4312098baf37 Merge tag 'spi-fix-v6.1-rc6' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17166e3d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=3cf137e672e75b602171
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7073d20a37/disk-4312098b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/36a0367a5593/vmlinux-4312098b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/265bedb3086b/bzImage-4312098b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3cf137e672e75b602171@syzkaller.appspotmail.com

BTRFS info (device loop2): enabling ssd optimizations
======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc6-syzkaller-00012-g4312098baf37 #0 Not tainted
------------------------------------------------------
syz-executor.2/11489 is trying to acquire lock:
ffff88801927df98 (&mm->mmap_lock#2){++++}-{3:3}, at: __might_fault+0x8f/0x110 mm/memory.c:5645

but task is already holding lock:
ffff888024223838 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
ffff888024223838 (btrfs-root-00){++++}-{3:3}, at: btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
ffff888024223838 (btrfs-root-00){++++}-{3:3}, at: btrfs_read_lock_root_node+0x2b4/0x400 fs/btrfs/locking.c:279

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (btrfs-root-00){++++}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       down_read_nested+0x3c/0x50 kernel/locking/rwsem.c:1634
       __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
       btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
       btrfs_read_lock_root_node+0x2b4/0x400 fs/btrfs/locking.c:279
       btrfs_search_forward+0x10f/0xe70 fs/btrfs/ctree.c:4488
       btrfs_uuid_scan_kthread+0x25e/0xbc0 fs/btrfs/volumes.c:4654
       kthread+0x266/0x300 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

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
  &mm->mmap_lock#2 --> btrfs_trans_num_extwriters --> btrfs-root-00

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-root-00);
                               lock(btrfs_trans_num_extwriters);
                               lock(btrfs-root-00);
  lock(&mm->mmap_lock#2);

 *** DEADLOCK ***

1 lock held by syz-executor.2/11489:
 #0: ffff888024223838 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
 #0: ffff888024223838 (btrfs-root-00){++++}-{3:3}, at: btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
 #0: ffff888024223838 (btrfs-root-00){++++}-{3:3}, at: btrfs_read_lock_root_node+0x2b4/0x400 fs/btrfs/locking.c:279

stack backtrace:
CPU: 0 PID: 11489 Comm: syz-executor.2 Not tainted 6.1.0-rc6-syzkaller-00012-g4312098baf37 #0
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
RIP: 0033:0x7f1731e8c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1732ba2168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f1731fabf80 RCX: 00007f1731e8c0d9
RDX: 0000000020049dc0 RSI: 00000000d000943d RDI: 0000000000000004
RBP: 00007f1731ee7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd2e5e53af R14: 00007f1732ba2300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
