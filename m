Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F3961E7B5
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 00:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiKFXtz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Nov 2022 18:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKFXty (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Nov 2022 18:49:54 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAF7DEDB
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Nov 2022 15:49:53 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id f25-20020a5d8799000000b006a44e33ddb6so6186164ion.1
        for <linux-btrfs@vger.kernel.org>; Sun, 06 Nov 2022 15:49:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OTBQMVaZQ0bX528sUQZcDbmUevFWv+8ZlejHfQn+X3w=;
        b=6j7CYHrkjTU0srX2TBKb06s2lmaaMzCqWVyM1JUgcYK8AbHRa7B34aFOoHCd6OtTUO
         jWHe8CxcLisH1G0JhWBugKcfOqZYU4GEckLIHynIQ1aFmC+gzRWRo0EimYcv+i83L090
         nAV8/NHBBEqZ/63xN8BMuHdSKFz2XttMxViYhvd2FW5h6CSjjKuvotR5lN/LgSwpv19C
         +Voj13AF8Z2BA4/Y/QphPR/O/xNNS1WZDY78FuomRjOU9FeIUOwmoYn+1TEou6O/hTvd
         +g0rdDVadBxxPkXB7z5m060ll5sx6KmBIB+U9sxfcmV3ZB+SgS4R9o/J9PvGPFcaaRxk
         +gNA==
X-Gm-Message-State: ACrzQf287hWnMKptUyPjzkfB6dpgkxtVfTLuIGIBmsVgCvDD2fN7XP8u
        Hwanvnxvh6a+s/4eQpAsCiV78H6cWC1jse/C6kFzD1+4N7iC
X-Google-Smtp-Source: AMsMyM43aCQqSzWXFrCNvfGV74xNluv1ky75BmmZZzhe5FtFdyWpWwBzQvckLaXeBhSrjP46QOW1syEp3AFt6WGthSmXWxK8SJhh
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1be7:b0:300:348d:99d with SMTP id
 y7-20020a056e021be700b00300348d099dmr28741173ilv.297.1667778593076; Sun, 06
 Nov 2022 15:49:53 -0800 (PST)
Date:   Sun, 06 Nov 2022 15:49:53 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009abbbf05ecd5f687@google.com>
Subject: [syzbot] possible deadlock in btrfs_search_slot_get_root
From:   syzbot <syzbot+4ef9e52e464c6ff47d9d@syzkaller.appspotmail.com>
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

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=163a7961880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=4ef9e52e464c6ff47d9d
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4ef9e52e464c6ff47d9d@syzkaller.appspotmail.com

BTRFS info (device loop5): enabling ssd optimizations
======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0 Not tainted
------------------------------------------------------
syz-executor.5/14151 is trying to acquire lock:
ffff0000c916fad8 (&mm->mmap_lock){++++}-{3:3}, at: __might_fault+0x54/0xb4 mm/memory.c:5576

but task is already holding lock:
ffff00011e1cfa48 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
ffff00011e1cfa48 (btrfs-root-00){++++}-{3:3}, at: btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
ffff00011e1cfa48 (btrfs-root-00){++++}-{3:3}, at: btrfs_read_lock_root_node+0x13c/0x1c0 fs/btrfs/locking.c:279

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (btrfs-root-00){++++}-{3:3}:
       down_read_nested+0x64/0x84 kernel/locking/rwsem.c:1624
       __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
       btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
       btrfs_read_lock_root_node+0x13c/0x1c0 fs/btrfs/locking.c:279
       btrfs_search_slot_get_root+0x74/0x338 fs/btrfs/ctree.c:1637
       btrfs_search_slot+0x1b0/0xfd8 fs/btrfs/ctree.c:1944
       __lookup_free_space_inode fs/btrfs/free-space-cache.c:69 [inline]
       lookup_free_space_inode+0xc4/0x2ac fs/btrfs/free-space-cache.c:116
       btrfs_remove_free_space_inode+0x88/0x1e8 fs/btrfs/free-space-cache.c:230
       cleanup_free_space_cache_v1 fs/btrfs/free-space-cache.c:4079 [inline]
       btrfs_set_free_space_cache_v1_active+0xc0/0x238 fs/btrfs/free-space-cache.c:4107
       btrfs_start_pre_rw_mount+0x238/0x380 fs/btrfs/disk-io.c:3251
       open_ctree+0xd28/0xf84 fs/btrfs/disk-io.c:3732
       btrfs_fill_super+0xc0/0x174 fs/btrfs/super.c:1456
       btrfs_mount_root+0x4a4/0x558 fs/btrfs/super.c:1824
       legacy_get_tree+0x30/0x74 fs/fs_context.c:610
       vfs_get_tree+0x40/0x140 fs/super.c:1530
       fc_mount fs/namespace.c:1043 [inline]
       vfs_kern_mount+0xe0/0x140 fs/namespace.c:1073
       btrfs_mount+0x20c/0x5e8 fs/btrfs/super.c:1884
       legacy_get_tree+0x30/0x74 fs/fs_context.c:610
       vfs_get_tree+0x40/0x140 fs/super.c:1530
       do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
       path_mount+0x358/0x914 fs/namespace.c:3370
       do_mount fs/namespace.c:3383 [inline]
       __do_sys_mount fs/namespace.c:3591 [inline]
       __se_sys_mount fs/namespace.c:3568 [inline]
       __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

-> #1 (sb_internal#2){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1826 [inline]
       sb_start_intwrite include/linux/fs.h:1948 [inline]
       start_transaction+0x360/0x944 fs/btrfs/transaction.c:683
       btrfs_join_transaction+0x30/0x40 fs/btrfs/transaction.c:795
       btrfs_dirty_inode+0x50/0x140 fs/btrfs/inode.c:6103
       btrfs_update_time+0x1c0/0x1e8 fs/btrfs/inode.c:6145
       inode_update_time fs/inode.c:1872 [inline]
       touch_atime+0x1f0/0x4a8 fs/inode.c:1945
       file_accessed include/linux/fs.h:2516 [inline]
       btrfs_file_mmap+0x50/0x88 fs/btrfs/file.c:2407
       call_mmap include/linux/fs.h:2192 [inline]
       mmap_region+0x7fc/0xc14 mm/mmap.c:1752
       do_mmap+0x644/0x97c mm/mmap.c:1540
       vm_mmap_pgoff+0xe8/0x1d0 mm/util.c:552
       ksys_mmap_pgoff+0x1cc/0x278 mm/mmap.c:1586
       __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
       __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
       __arm64_sys_mmap+0x58/0x6c arch/arm64/kernel/sys.c:21
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x1530/0x30a4 kernel/locking/lockdep.c:5053
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
       __might_fault+0x7c/0xb4 mm/memory.c:5577
       _copy_to_user include/linux/uaccess.h:134 [inline]
       copy_to_user include/linux/uaccess.h:160 [inline]
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
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock --> sb_internal#2 --> btrfs-root-00

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-root-00);
                               lock(sb_internal#2);
                               lock(btrfs-root-00);
  lock(&mm->mmap_lock);

 *** DEADLOCK ***

1 lock held by syz-executor.5/14151:
 #0: ffff00011e1cfa48 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
 #0: ffff00011e1cfa48 (btrfs-root-00){++++}-{3:3}, at: btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
 #0: ffff00011e1cfa48 (btrfs-root-00){++++}-{3:3}, at: btrfs_read_lock_root_node+0x13c/0x1c0 fs/btrfs/locking.c:279

stack backtrace:
CPU: 1 PID: 14151 Comm: syz-executor.5 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 print_circular_bug+0x2c4/0x2c8 kernel/locking/lockdep.c:2053
 check_noncircular+0x14c/0x154 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x1530/0x30a4 kernel/locking/lockdep.c:5053
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 __might_fault+0x7c/0xb4 mm/memory.c:5577
 _copy_to_user include/linux/uaccess.h:134 [inline]
 copy_to_user include/linux/uaccess.h:160 [inline]
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
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
