Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED74163BF79
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Nov 2022 12:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiK2LzF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Nov 2022 06:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbiK2LzC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Nov 2022 06:55:02 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34BA55C95
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Nov 2022 03:54:50 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id a14-20020a921a0e000000b00302a8ffa8e5so11681109ila.2
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Nov 2022 03:54:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNPm+HQyizgfQf2X+LkFy3DvgL3orZ83eZPVaS2Kykw=;
        b=TNxi4RkWEBkOFxBa+b7WfaseHkMvwkku4qnEhE2VwAMXWAJ0ciLjwZ2EXzvkToqNu6
         7XL0FGxOf2HFANrsuB8fuOhZPnKDG/aSlK/A1AoWH1pP1QwL0/RJu0THdJta3MZQfeMA
         wKCeLenYYv2/+o4SXHuWL0LtMIzGXhcNXtUAjQ1nzn0KwJu9pVoSpn6d+IGOl2XaCnGB
         5CFtTJW6JKmB0EsTr27XSFYGyQcvbIdY+gpfK888zqwwQDc7TDIigj7xfhS+qF8BlJ0f
         a0ZhqAWuW3Fa9MQyj1GZ+ptLppdoo4S78ckbbO81tvSlHayCP8WRK450UsoED7+Wsv6i
         HDVg==
X-Gm-Message-State: ANoB5pkmXcSC/eUaZNl1rfQucM9+e7wLFcBxXOOYj0DwzYQtGV4VLoy0
        8UKxpEpZ/bh7EF/m5hddu8aIvWOjXUt+gsMPdHm9tZY+UbcX
X-Google-Smtp-Source: AA0mqf7RSLwtlseFxcWUcZaiWaxnD/IlBkBt3xq2OBEtw+Z8NaSOUjiJyaQPa6osZJ1iIcCq3jX+nguKZsQ5zYRzJYLbtDGye7eo
MIME-Version: 1.0
X-Received: by 2002:a6b:6b07:0:b0:6dd:f70e:dda5 with SMTP id
 g7-20020a6b6b07000000b006ddf70edda5mr19103339ioc.100.1669722890298; Tue, 29
 Nov 2022 03:54:50 -0800 (PST)
Date:   Tue, 29 Nov 2022 03:54:50 -0800
In-Reply-To: <000000000000d916f405ee34206b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bff15605ee9aa7c9@google.com>
Subject: Re: [syzbot] possible deadlock in btrfs_join_transaction
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    6d464646530f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=111da6a1880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=54b747d981acc7b7
dashboard link: https://syzkaller.appspot.com/bug?extid=6eb64eace626d6222d2a
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b284bd880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11346825880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d75f5f77b3a3/disk-6d464646.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9382f86e4d95/vmlinux-6d464646.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cf2b5f0d51dd/Image-6d464646.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6232bad1430d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6eb64eace626d6222d2a@syzkaller.appspotmail.com

BTRFS info (device loop0): using sha256 (sha256-ce) checksum algorithm
BTRFS info (device loop0): using free space tree
BTRFS info (device loop0): enabling ssd optimizations
======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc6-syzkaller-32662-g6d464646530f #0 Not tainted
------------------------------------------------------
syz-executor220/3357 is trying to acquire lock:
ffff0000c9b90650 (sb_internal#2){.+.+}-{0:0}, at: btrfs_join_transaction+0x30/0x40 fs/btrfs/transaction.c:764

but task is already holding lock:
ffff0000ca11fb08 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
ffff0000ca11fb08 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0xa0/0x1d0 mm/util.c:518

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&mm->mmap_lock){++++}-{3:3}:
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

-> #4 (btrfs-root-00){++++}-{3:3}:
       down_read_nested+0x64/0x84 kernel/locking/rwsem.c:1634
       __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
       btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
       btrfs_read_lock_root_node+0x13c/0x1c0 fs/btrfs/locking.c:279
       btrfs_search_slot_get_root+0x8c/0x374 fs/btrfs/ctree.c:1665
       btrfs_search_slot+0x1dc/0x107c fs/btrfs/ctree.c:1985
       btrfs_update_root+0x6c/0x5a4 fs/btrfs/root-tree.c:132
       commit_fs_roots+0x1f0/0x33c fs/btrfs/transaction.c:1441
       btrfs_commit_transaction+0xa94/0x1574 fs/btrfs/transaction.c:2353
       btrfs_sync_fs+0x2b8/0x48c fs/btrfs/super.c:1527
       sync_filesystem+0xe0/0x134 fs/sync.c:66
       generic_shutdown_super+0x38/0x198 fs/super.c:474
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

-> #3 (&fs_info->reloc_mutex){+.+.}-{3:3}:
       __mutex_lock_common+0xd4/0xca8 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
       btrfs_record_root_in_trans fs/btrfs/transaction.c:484 [inline]
       start_transaction+0x248/0x944 fs/btrfs/transaction.c:721
       btrfs_start_transaction+0x34/0x44 fs/btrfs/transaction.c:750
       btrfs_create_common+0xf0/0x1b4 fs/btrfs/inode.c:6633
       btrfs_create+0x8c/0xb0 fs/btrfs/inode.c:6679
       lookup_open fs/namei.c:3413 [inline]
       open_last_lookups fs/namei.c:3481 [inline]
       path_openat+0x804/0x11c4 fs/namei.c:3710
       do_filp_open+0xdc/0x1b8 fs/namei.c:3740
       do_sys_openat2+0xb8/0x22c fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_openat fs/open.c:1342 [inline]
       __se_sys_openat fs/open.c:1337 [inline]
       __arm64_sys_openat+0xb0/0xe0 fs/open.c:1337
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
       btrfs_start_transaction+0x34/0x44 fs/btrfs/transaction.c:750
       btrfs_create_common+0xf0/0x1b4 fs/btrfs/inode.c:6633
       btrfs_create+0x8c/0xb0 fs/btrfs/inode.c:6679
       lookup_open fs/namei.c:3413 [inline]
       open_last_lookups fs/namei.c:3481 [inline]
       path_openat+0x804/0x11c4 fs/namei.c:3710
       do_filp_open+0xdc/0x1b8 fs/namei.c:3740
       do_sys_openat2+0xb8/0x22c fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_openat fs/open.c:1342 [inline]
       __se_sys_openat fs/open.c:1337 [inline]
       __arm64_sys_openat+0xb0/0xe0 fs/open.c:1337
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #1 (btrfs_trans_num_writers){++++}-{0:0}:
       join_transaction+0xe8/0x65c fs/btrfs/transaction.c:298
       start_transaction+0x460/0x944 fs/btrfs/transaction.c:658
       btrfs_start_transaction+0x34/0x44 fs/btrfs/transaction.c:750
       btrfs_create_common+0xf0/0x1b4 fs/btrfs/inode.c:6633
       btrfs_create+0x8c/0xb0 fs/btrfs/inode.c:6679
       lookup_open fs/namei.c:3413 [inline]
       open_last_lookups fs/namei.c:3481 [inline]
       path_openat+0x804/0x11c4 fs/namei.c:3710
       do_filp_open+0xdc/0x1b8 fs/namei.c:3740
       do_sys_openat2+0xb8/0x22c fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_openat fs/open.c:1342 [inline]
       __se_sys_openat fs/open.c:1337 [inline]
       __arm64_sys_openat+0xb0/0xe0 fs/open.c:1337
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
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
       touch_atime+0x1f0/0x4a8 fs/inode.c:1944
       file_accessed include/linux/fs.h:2521 [inline]
       btrfs_file_mmap+0x50/0x88 fs/btrfs/file.c:2333
       call_mmap include/linux/fs.h:2196 [inline]
       mmap_region+0x8a0/0x1064 mm/mmap.c:2625
       do_mmap+0x6e8/0xa30 mm/mmap.c:1412
       vm_mmap_pgoff+0xe8/0x1d0 mm/util.c:520
       ksys_mmap_pgoff+0x1cc/0x278 mm/mmap.c:1458
       __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
       __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
       __arm64_sys_mmap+0x58/0x6c arch/arm64/kernel/sys.c:21
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

other info that might help us debug this:

Chain exists of:
  sb_internal#2 --> btrfs-root-00 --> &mm->mmap_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mm->mmap_lock);
                               lock(btrfs-root-00);
                               lock(&mm->mmap_lock);
  lock(sb_internal#2);

 *** DEADLOCK ***

2 locks held by syz-executor220/3357:
 #0: ffff0000ca11fb08 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #0: ffff0000ca11fb08 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0xa0/0x1d0 mm/util.c:518
 #1: ffff0000c9b90460 (sb_writers#8){.+.+}-{0:0}, at: file_accessed include/linux/fs.h:2521 [inline]
 #1: ffff0000c9b90460 (sb_writers#8){.+.+}-{0:0}, at: btrfs_file_mmap+0x50/0x88 fs/btrfs/file.c:2333

stack backtrace:
CPU: 1 PID: 3357 Comm: syz-executor220 Not tainted 6.1.0-rc6-syzkaller-32662-g6d464646530f #0
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
 touch_atime+0x1f0/0x4a8 fs/inode.c:1944
 file_accessed include/linux/fs.h:2521 [inline]
 btrfs_file_mmap+0x50/0x88 fs/btrfs/file.c:2333
 call_mmap include/linux/fs.h:2196 [inline]
 mmap_region+0x8a0/0x1064 mm/mmap.c:2625
 do_mmap+0x6e8/0xa30 mm/mmap.c:1412
 vm_mmap_pgoff+0xe8/0x1d0 mm/util.c:520
 ksys_mmap_pgoff+0x1cc/0x278 mm/mmap.c:1458
 __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
 __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
 __arm64_sys_mmap+0x58/0x6c arch/arm64/kernel/sys.c:21
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

