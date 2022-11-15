Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4C26291C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 07:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiKOGS4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 01:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiKOGSz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 01:18:55 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9091583F
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 22:18:53 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id a14-20020a6b660e000000b006bd37975cdfso6906516ioc.10
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 22:18:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dlLtc6w6HfHRQLFXd3GSj9ody/dyrqExLOMq4OTwn8Q=;
        b=KJLlrm8/h1MGFDGVzwQxujSwUZ71Iq8kQ/VtRpQ1Pu9DH38rPT7IRhz3TuGvPivsxf
         l8kCdaY59X8cAebD5DuNCzBxiOe/vtkrXMxIASD37c6kiyH553tWAz3O4I5CME9dGqD5
         Bw+2/LhUUqcxpnepRyL8Wgl7uK2NFtDQE0IpDH2FUy8BB4wlRxLVzK5fazZfP46fak3l
         haCajK5RK1Mp0MKOWMvp8u/v0t7lhQCN9YDL6sXAMXpBngEXKlpMTPv7WlCOamWRNlKZ
         4wz4cTYYKS6RnqlyXJK5rD8fIJW21e7VXcjepiZI4ZYJsGda8yHe7qfal5kzNaIRWdCl
         A66A==
X-Gm-Message-State: ANoB5plImPYUzCQgaATzcxRgMwQ7d42RifI7EZFERosqbPY9k0Mm8diE
        rtbZlBeu5yJidhES+Et3mL9ZWpUSf1KQmpOKXPXVgjIAGMP0
X-Google-Smtp-Source: AA0mqf7Mgc+43FsQw6SmHCygF9D6sWhl+yGLQjiUWmmI47ZN3STRi0XVvIwa7rTVsk+1HorAvt6fV5ERhFH9h3z4lfdy5tFMYupb
MIME-Version: 1.0
X-Received: by 2002:a05:6602:258b:b0:6c8:63c1:d8d3 with SMTP id
 p11-20020a056602258b00b006c863c1d8d3mr7362620ioo.114.1668493132325; Mon, 14
 Nov 2022 22:18:52 -0800 (PST)
Date:   Mon, 14 Nov 2022 22:18:52 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076699c05ed7c54a2@google.com>
Subject: [syzbot] possible deadlock in btrfs_commit_transaction
From:   syzbot <syzbot+52d708a0bca2efc4c9df@syzkaller.appspotmail.com>
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

HEAD commit:    e01d50cbd6ee Merge tag 'vfio-v6.1-rc6' of https://github.c..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122bd401880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47b0b2ecc119b39f
dashboard link: https://syzkaller.appspot.com/bug?extid=52d708a0bca2efc4c9df
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167dfbf5880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11558535880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b48e4d485e7e/disk-e01d50cb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dc9ba558e055/vmlinux-e01d50cb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b766d9815123/bzImage-e01d50cb.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ac6062c53b8d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+52d708a0bca2efc4c9df@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc5-syzkaller-00008-ge01d50cbd6ee #0 Not tainted
------------------------------------------------------
syz-executor110/3653 is trying to acquire lock:
ffff88807e4a24d8 (btrfs-root-00){.+.+}-{3:3}, at: __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
ffff88807e4a24d8 (btrfs-root-00){.+.+}-{3:3}, at: btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
ffff88807e4a24d8 (btrfs-root-00){.+.+}-{3:3}, at: btrfs_read_lock_root_node+0x2b4/0x400 fs/btrfs/locking.c:279

but task is already holding lock:
ffff888027234cc0 (&fs_info->reloc_mutex){+.+.}-{3:3}, at: btrfs_commit_transaction+0x13e8/0x3760 fs/btrfs/transaction.c:2316

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&fs_info->reloc_mutex){+.+.}-{3:3}:
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

-> #3 (btrfs_trans_num_extwriters){++++}-{0:0}:
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

-> #2 (btrfs_trans_num_writers){++++}-{0:0}:
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

-> #1 (&mm->mmap_lock#2){++++}-{3:3}:
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

-> #0 (btrfs-root-00){.+.+}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
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
       iterate_supers+0x137/0x1f0 fs/super.c:724
       ksys_sync+0xd5/0x1c0 fs/sync.c:104
       __do_sys_sync+0xa/0x10 fs/sync.c:113
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  btrfs-root-00 --> btrfs_trans_num_extwriters --> &fs_info->reloc_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&fs_info->reloc_mutex);
                               lock(btrfs_trans_num_extwriters);
                               lock(&fs_info->reloc_mutex);
  lock(btrfs-root-00);

 *** DEADLOCK ***

5 locks held by syz-executor110/3653:
 #0: ffff8880264240e0 (&type->s_umount_key#42){++++}-{3:3}, at: iterate_supers+0xb0/0x1f0 fs/super.c:722
 #1: ffff8880272363f0 (btrfs_trans_completed){.+.+}-{0:0}, at: btrfs_commit_transaction+0x130f/0x3760 fs/btrfs/transaction.c:2295
 #2: ffff8880272363c8 (btrfs_trans_super_committed){.+.+}-{0:0}, at: btrfs_commit_transaction+0x133e/0x3760 fs/btrfs/transaction.c:2296
 #3: ffff8880272363a0 (btrfs_trans_unblocked){.+.+}-{0:0}, at: btrfs_commit_transaction+0x136d/0x3760 fs/btrfs/transaction.c:2297
 #4: ffff888027234cc0 (&fs_info->reloc_mutex){+.+.}-{3:3}, at: btrfs_commit_transaction+0x13e8/0x3760 fs/btrfs/transaction.c:2316

stack backtrace:
CPU: 1 PID: 3653 Comm: syz-executor110 Not tainted 6.1.0-rc5-syzkaller-00008-ge01d50cbd6ee #0
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
 down_read_nested+0x3c/0x50 kernel/locking/rwsem.c:1634
 __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
 btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
 btrfs_read_lock_root_node+0x2b4/0x400 fs/btrfs/locking.c:279
 btrfs_search_slot_get_root fs/btrfs/ctree.c:1665 [inline]
 btrfs_search_slot+0x495/0x2fe0 fs/btrfs/ctree.c:1985
 btrfs_update_root+0xf0/0xc60 fs/btrfs/root-tree.c:132
 commit_fs_roots+0x4d3/0x710 fs/btrfs/transaction.c:1441
 btrfs_commit_transaction+0x147f/0x3760 fs/btrfs/transaction.c:2353
 iterate_supers+0x137/0x1f0 fs/super.c:724
 ksys_sync+0xd5/0x1c0 fs/sync.c:104
 __do_sys_sync+0xa/0x10 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fec18d5dc79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd705bc978 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007fec18d9ea80 RCX: 00007fec18d5dc79
RDX: 00007fec18d140c3 RSI: 0000000000000003 RDI: 0000000000004c00
RBP: 00007fec18d9e938 R08: 00005555556912c0 R09: 0000000000000140
R10: 00007ffd705bc680 R11: 0000000000000246 R12: 00007fec18d9e8d0
R13: 00007fec18d9b838 R14: 431bde82d7b634db R15: 00007ffd705bc990
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
