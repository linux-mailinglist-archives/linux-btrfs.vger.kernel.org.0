Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534C2382B08
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 13:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbhEQL3i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 07:29:38 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:57144 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236794AbhEQL3g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 07:29:36 -0400
Received: by mail-il1-f197.google.com with SMTP id u5-20020a92da850000b0290167339353beso5989033iln.23
        for <linux-btrfs@vger.kernel.org>; Mon, 17 May 2021 04:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4vqbFM88L+wUHVFsyB+vRCfyOoT3HHJ+XhCirLsEHVk=;
        b=gmYXecJCxG5PbBpLdX2P/S27u40cUXGfAAJoolzxe63RG3bvmxqldf4AtnDLms/euC
         zgyDVNihubVAvV9s3UZoI77sawkRHYpkyFcIKAXIhvsAwrEFie79FHaI/4cDRai/9Hvf
         N1Yru+IF7uR6LTc/rFwhb91TmU4NT4f6lVhGmF5LAZ0VlkPMEE+IAbeLj54L2sT5F4El
         S2Wh9i0KTlpiVuxaZnmYxR327cVrZGoQl3+jACHerb5cqe/LMUUBWekJzxbqjME3c8W9
         vk2v+GVI9/FELOmjLzs2Sw+acpG0keyzueG7CJdmxTzt3GWEQi8+h5xcZhz6/az4OhIL
         G3GQ==
X-Gm-Message-State: AOAM5301arKuLC5JVLtdvSTWwzYMP1Do9bP23snhzlO4XDm3Egt7wfFE
        ROS3c/zRYmMgKJc3X81w9Asvnf8S6v9cfoTEitQxE9nC93MD
X-Google-Smtp-Source: ABdhPJzxiki6f3J8KrlNBcjFHTFG/JZhosgfq034Z3nyOuWpD8Zq5ffA3RhnUos5bF2ZilAdUdrHS9T+BCrMoRO11Pi/R6nDbCjh
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1243:: with SMTP id o3mr44174776iou.93.1621250899961;
 Mon, 17 May 2021 04:28:19 -0700 (PDT)
Date:   Mon, 17 May 2021 04:28:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fbecf305c284e3c3@google.com>
Subject: [syzbot] KMSAN: uninit-value in write_extent_buffer
From:   syzbot <syzbot+e197086894c3dfffc6ac@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, glider@google.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4ebaab5f kmsan: drop unneeded references to kmsan_context_..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17d3fcfed00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ab8076fe8508c0d3
dashboard link: https://syzkaller.appspot.com/bug?extid=e197086894c3dfffc6ac
compiler:       Debian clang version 11.0.1-2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e197086894c3dfffc6ac@syzkaller.appspotmail.com

 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in check_eb_range fs/btrfs/extent_io.c:6115 [inline]
BUG: KMSAN: uninit-value in write_extent_buffer+0x394/0xaf0 fs/btrfs/extent_io.c:6253
CPU: 1 PID: 11127 Comm: syz-executor.5 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 check_eb_range fs/btrfs/extent_io.c:6115 [inline]
 write_extent_buffer+0x394/0xaf0 fs/btrfs/extent_io.c:6253
 btrfs_set_dev_stats_value fs/btrfs/volumes.c:7436 [inline]
 update_dev_stat_item fs/btrfs/volumes.c:7573 [inline]
 btrfs_run_dev_stats+0xbb5/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f63549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ff982b0c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ff982bb0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e6a
RBP: 00000000ff982bb0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd0/0x1e0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5044
 alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2277
 alloc_pages include/linux/gfp.h:561 [inline]
 __page_cache_alloc mm/filemap.c:978 [inline]
 pagecache_get_page+0x111d/0x2040 mm/filemap.c:1797
 find_or_create_page include/linux/pagemap.h:405 [inline]
 alloc_extent_buffer+0x8f8/0x33d0 fs/btrfs/extent_io.c:5618
 btrfs_find_create_tree_block+0xb6/0xd0 fs/btrfs/disk-io.c:1024
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4743 [inline]
 btrfs_alloc_tree_block+0x545/0x2140 fs/btrfs/extent-tree.c:4845
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:992 [inline]
 __btrfs_cow_block+0xb93/0x2760 fs/btrfs/ctree.c:1048
 btrfs_cow_block+0xa3c/0xc90 fs/btrfs/ctree.c:1495
 btrfs_search_slot+0x1ad5/0x3f20 fs/btrfs/ctree.c:2676
 update_dev_stat_item fs/btrfs/volumes.c:7536 [inline]
 btrfs_run_dev_stats+0x446/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in write_extent_buffer+0x401/0xaf0 fs/btrfs/extent_io.c:6259
CPU: 1 PID: 11127 Comm: syz-executor.5 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 write_extent_buffer+0x401/0xaf0 fs/btrfs/extent_io.c:6259
 btrfs_set_dev_stats_value fs/btrfs/volumes.c:7436 [inline]
 update_dev_stat_item fs/btrfs/volumes.c:7573 [inline]
 btrfs_run_dev_stats+0xbb5/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f63549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ff982b0c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ff982bb0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e6a
RBP: 00000000ff982bb0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd0/0x1e0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5044
 alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2277
 alloc_pages include/linux/gfp.h:561 [inline]
 __page_cache_alloc mm/filemap.c:978 [inline]
 pagecache_get_page+0x111d/0x2040 mm/filemap.c:1797
 find_or_create_page include/linux/pagemap.h:405 [inline]
 alloc_extent_buffer+0x8f8/0x33d0 fs/btrfs/extent_io.c:5618
 btrfs_find_create_tree_block+0xb6/0xd0 fs/btrfs/disk-io.c:1024
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4743 [inline]
 btrfs_alloc_tree_block+0x545/0x2140 fs/btrfs/extent-tree.c:4845
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:992 [inline]
 __btrfs_cow_block+0xb93/0x2760 fs/btrfs/ctree.c:1048
 btrfs_cow_block+0xa3c/0xc90 fs/btrfs/ctree.c:1495
 btrfs_search_slot+0x1ad5/0x3f20 fs/btrfs/ctree.c:2676
 update_dev_stat_item fs/btrfs/volumes.c:7536 [inline]
 btrfs_run_dev_stats+0x446/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in write_extent_buffer+0x95b/0xaf0 fs/btrfs/extent_io.c:6258
CPU: 1 PID: 11127 Comm: syz-executor.5 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 write_extent_buffer+0x95b/0xaf0 fs/btrfs/extent_io.c:6258
 btrfs_set_dev_stats_value fs/btrfs/volumes.c:7436 [inline]
 update_dev_stat_item fs/btrfs/volumes.c:7573 [inline]
 btrfs_run_dev_stats+0xbb5/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f63549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ff982b0c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ff982bb0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e6a
RBP: 00000000ff982bb0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd0/0x1e0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5044
 alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2277
 alloc_pages include/linux/gfp.h:561 [inline]
 __page_cache_alloc mm/filemap.c:978 [inline]
 pagecache_get_page+0x111d/0x2040 mm/filemap.c:1797
 find_or_create_page include/linux/pagemap.h:405 [inline]
 alloc_extent_buffer+0x8f8/0x33d0 fs/btrfs/extent_io.c:5618
 btrfs_find_create_tree_block+0xb6/0xd0 fs/btrfs/disk-io.c:1024
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4743 [inline]
 btrfs_alloc_tree_block+0x545/0x2140 fs/btrfs/extent-tree.c:4845
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:992 [inline]
 __btrfs_cow_block+0xb93/0x2760 fs/btrfs/ctree.c:1048
 btrfs_cow_block+0xa3c/0xc90 fs/btrfs/ctree.c:1495
 btrfs_search_slot+0x1ad5/0x3f20 fs/btrfs/ctree.c:2676
 update_dev_stat_item fs/btrfs/volumes.c:7536 [inline]
 btrfs_run_dev_stats+0x446/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in check_eb_range fs/btrfs/extent_io.c:6115 [inline]
BUG: KMSAN: uninit-value in write_extent_buffer+0x394/0xaf0 fs/btrfs/extent_io.c:6253
CPU: 1 PID: 11127 Comm: syz-executor.5 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 check_eb_range fs/btrfs/extent_io.c:6115 [inline]
 write_extent_buffer+0x394/0xaf0 fs/btrfs/extent_io.c:6253
 btrfs_set_dev_stats_value fs/btrfs/volumes.c:7436 [inline]
 update_dev_stat_item fs/btrfs/volumes.c:7573 [inline]
 btrfs_run_dev_stats+0xc69/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f63549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ff982b0c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ff982bb0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e6a
RBP: 00000000ff982bb0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd0/0x1e0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5044
 alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2277
 alloc_pages include/linux/gfp.h:561 [inline]
 __page_cache_alloc mm/filemap.c:978 [inline]
 pagecache_get_page+0x111d/0x2040 mm/filemap.c:1797
 find_or_create_page include/linux/pagemap.h:405 [inline]
 alloc_extent_buffer+0x8f8/0x33d0 fs/btrfs/extent_io.c:5618
 btrfs_find_create_tree_block+0xb6/0xd0 fs/btrfs/disk-io.c:1024
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4743 [inline]
 btrfs_alloc_tree_block+0x545/0x2140 fs/btrfs/extent-tree.c:4845
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:992 [inline]
 __btrfs_cow_block+0xb93/0x2760 fs/btrfs/ctree.c:1048
 btrfs_cow_block+0xa3c/0xc90 fs/btrfs/ctree.c:1495
 btrfs_search_slot+0x1ad5/0x3f20 fs/btrfs/ctree.c:2676
 update_dev_stat_item fs/btrfs/volumes.c:7536 [inline]
 btrfs_run_dev_stats+0x446/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in write_extent_buffer+0x401/0xaf0 fs/btrfs/extent_io.c:6259
CPU: 1 PID: 11127 Comm: syz-executor.5 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 write_extent_buffer+0x401/0xaf0 fs/btrfs/extent_io.c:6259
 btrfs_set_dev_stats_value fs/btrfs/volumes.c:7436 [inline]
 update_dev_stat_item fs/btrfs/volumes.c:7573 [inline]
 btrfs_run_dev_stats+0xc69/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f63549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ff982b0c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ff982bb0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e6a
RBP: 00000000ff982bb0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd0/0x1e0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5044
 alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2277
 alloc_pages include/linux/gfp.h:561 [inline]
 __page_cache_alloc mm/filemap.c:978 [inline]
 pagecache_get_page+0x111d/0x2040 mm/filemap.c:1797
 find_or_create_page include/linux/pagemap.h:405 [inline]
 alloc_extent_buffer+0x8f8/0x33d0 fs/btrfs/extent_io.c:5618
 btrfs_find_create_tree_block+0xb6/0xd0 fs/btrfs/disk-io.c:1024
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4743 [inline]
 btrfs_alloc_tree_block+0x545/0x2140 fs/btrfs/extent-tree.c:4845
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:992 [inline]
 __btrfs_cow_block+0xb93/0x2760 fs/btrfs/ctree.c:1048
 btrfs_cow_block+0xa3c/0xc90 fs/btrfs/ctree.c:1495
 btrfs_search_slot+0x1ad5/0x3f20 fs/btrfs/ctree.c:2676
 update_dev_stat_item fs/btrfs/volumes.c:7536 [inline]
 btrfs_run_dev_stats+0x446/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in write_extent_buffer+0x95b/0xaf0 fs/btrfs/extent_io.c:6258
CPU: 1 PID: 11127 Comm: syz-executor.5 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 write_extent_buffer+0x95b/0xaf0 fs/btrfs/extent_io.c:6258
 btrfs_set_dev_stats_value fs/btrfs/volumes.c:7436 [inline]
 update_dev_stat_item fs/btrfs/volumes.c:7573 [inline]
 btrfs_run_dev_stats+0xc69/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f63549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ff982b0c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ff982bb0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e6a
RBP: 00000000ff982bb0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd0/0x1e0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5044
 alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2277
 alloc_pages include/linux/gfp.h:561 [inline]
 __page_cache_alloc mm/filemap.c:978 [inline]
 pagecache_get_page+0x111d/0x2040 mm/filemap.c:1797
 find_or_create_page include/linux/pagemap.h:405 [inline]
 alloc_extent_buffer+0x8f8/0x33d0 fs/btrfs/extent_io.c:5618
 btrfs_find_create_tree_block+0xb6/0xd0 fs/btrfs/disk-io.c:1024
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4743 [inline]
 btrfs_alloc_tree_block+0x545/0x2140 fs/btrfs/extent-tree.c:4845
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:992 [inline]
 __btrfs_cow_block+0xb93/0x2760 fs/btrfs/ctree.c:1048
 btrfs_cow_block+0xa3c/0xc90 fs/btrfs/ctree.c:1495
 btrfs_search_slot+0x1ad5/0x3f20 fs/btrfs/ctree.c:2676
 update_dev_stat_item fs/btrfs/volumes.c:7536 [inline]
 btrfs_run_dev_stats+0x446/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in check_eb_range fs/btrfs/extent_io.c:6115 [inline]
BUG: KMSAN: uninit-value in write_extent_buffer+0x394/0xaf0 fs/btrfs/extent_io.c:6253
CPU: 1 PID: 11127 Comm: syz-executor.5 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 check_eb_range fs/btrfs/extent_io.c:6115 [inline]
 write_extent_buffer+0x394/0xaf0 fs/btrfs/extent_io.c:6253
 btrfs_set_dev_stats_value fs/btrfs/volumes.c:7436 [inline]
 update_dev_stat_item fs/btrfs/volumes.c:7573 [inline]
 btrfs_run_dev_stats+0xd1d/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f63549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ff982b0c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ff982bb0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e6a
RBP: 00000000ff982bb0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd0/0x1e0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5044
 alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2277
 alloc_pages include/linux/gfp.h:561 [inline]
 __page_cache_alloc mm/filemap.c:978 [inline]
 pagecache_get_page+0x111d/0x2040 mm/filemap.c:1797
 find_or_create_page include/linux/pagemap.h:405 [inline]
 alloc_extent_buffer+0x8f8/0x33d0 fs/btrfs/extent_io.c:5618
 btrfs_find_create_tree_block+0xb6/0xd0 fs/btrfs/disk-io.c:1024
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4743 [inline]
 btrfs_alloc_tree_block+0x545/0x2140 fs/btrfs/extent-tree.c:4845
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:992 [inline]
 __btrfs_cow_block+0xb93/0x2760 fs/btrfs/ctree.c:1048
 btrfs_cow_block+0xa3c/0xc90 fs/btrfs/ctree.c:1495
 btrfs_search_slot+0x1ad5/0x3f20 fs/btrfs/ctree.c:2676
 update_dev_stat_item fs/btrfs/volumes.c:7536 [inline]
 btrfs_run_dev_stats+0x446/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in write_extent_buffer+0x401/0xaf0 fs/btrfs/extent_io.c:6259
CPU: 1 PID: 11127 Comm: syz-executor.5 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 write_extent_buffer+0x401/0xaf0 fs/btrfs/extent_io.c:6259
 btrfs_set_dev_stats_value fs/btrfs/volumes.c:7436 [inline]
 update_dev_stat_item fs/btrfs/volumes.c:7573 [inline]
 btrfs_run_dev_stats+0xd1d/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f63549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ff982b0c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ff982bb0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e6a
RBP: 00000000ff982bb0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd0/0x1e0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5044
 alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2277
 alloc_pages include/linux/gfp.h:561 [inline]
 __page_cache_alloc mm/filemap.c:978 [inline]
 pagecache_get_page+0x111d/0x2040 mm/filemap.c:1797
 find_or_create_page include/linux/pagemap.h:405 [inline]
 alloc_extent_buffer+0x8f8/0x33d0 fs/btrfs/extent_io.c:5618
 btrfs_find_create_tree_block+0xb6/0xd0 fs/btrfs/disk-io.c:1024
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4743 [inline]
 btrfs_alloc_tree_block+0x545/0x2140 fs/btrfs/extent-tree.c:4845
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:992 [inline]
 __btrfs_cow_block+0xb93/0x2760 fs/btrfs/ctree.c:1048
 btrfs_cow_block+0xa3c/0xc90 fs/btrfs/ctree.c:1495
 btrfs_search_slot+0x1ad5/0x3f20 fs/btrfs/ctree.c:2676
 update_dev_stat_item fs/btrfs/volumes.c:7536 [inline]
 btrfs_run_dev_stats+0x446/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in write_extent_buffer+0x95b/0xaf0 fs/btrfs/extent_io.c:6258
CPU: 1 PID: 11127 Comm: syz-executor.5 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 write_extent_buffer+0x95b/0xaf0 fs/btrfs/extent_io.c:6258
 btrfs_set_dev_stats_value fs/btrfs/volumes.c:7436 [inline]
 update_dev_stat_item fs/btrfs/volumes.c:7573 [inline]
 btrfs_run_dev_stats+0xd1d/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f63549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ff982b0c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ff982bb0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e6a
RBP: 00000000ff982bb0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd0/0x1e0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5044
 alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2277
 alloc_pages include/linux/gfp.h:561 [inline]
 __page_cache_alloc mm/filemap.c:978 [inline]
 pagecache_get_page+0x111d/0x2040 mm/filemap.c:1797
 find_or_create_page include/linux/pagemap.h:405 [inline]
 alloc_extent_buffer+0x8f8/0x33d0 fs/btrfs/extent_io.c:5618
 btrfs_find_create_tree_block+0xb6/0xd0 fs/btrfs/disk-io.c:1024
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4743 [inline]
 btrfs_alloc_tree_block+0x545/0x2140 fs/btrfs/extent-tree.c:4845
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:992 [inline]
 __btrfs_cow_block+0xb93/0x2760 fs/btrfs/ctree.c:1048
 btrfs_cow_block+0xa3c/0xc90 fs/btrfs/ctree.c:1495
 btrfs_search_slot+0x1ad5/0x3f20 fs/btrfs/ctree.c:2676
 update_dev_stat_item fs/btrfs/volumes.c:7536 [inline]
 btrfs_run_dev_stats+0x446/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in check_eb_range fs/btrfs/extent_io.c:6115 [inline]
BUG: KMSAN: uninit-value in write_extent_buffer+0x394/0xaf0 fs/btrfs/extent_io.c:6253
CPU: 1 PID: 11127 Comm: syz-executor.5 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 check_eb_range fs/btrfs/extent_io.c:6115 [inline]
 write_extent_buffer+0x394/0xaf0 fs/btrfs/extent_io.c:6253
 btrfs_set_dev_stats_value fs/btrfs/volumes.c:7436 [inline]
 update_dev_stat_item fs/btrfs/volumes.c:7573 [inline]
 btrfs_run_dev_stats+0xdd8/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f63549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ff982b0c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ff982bb0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e6a
RBP: 00000000ff982bb0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd0/0x1e0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5044
 alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2277
 alloc_pages include/linux/gfp.h:561 [inline]
 __page_cache_alloc mm/filemap.c:978 [inline]
 pagecache_get_page+0x111d/0x2040 mm/filemap.c:1797
 find_or_create_page include/linux/pagemap.h:405 [inline]
 alloc_extent_buffer+0x8f8/0x33d0 fs/btrfs/extent_io.c:5618
 btrfs_find_create_tree_block+0xb6/0xd0 fs/btrfs/disk-io.c:1024
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4743 [inline]
 btrfs_alloc_tree_block+0x545/0x2140 fs/btrfs/extent-tree.c:4845
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:992 [inline]
 __btrfs_cow_block+0xb93/0x2760 fs/btrfs/ctree.c:1048
 btrfs_cow_block+0xa3c/0xc90 fs/btrfs/ctree.c:1495
 btrfs_search_slot+0x1ad5/0x3f20 fs/btrfs/ctree.c:2676
 update_dev_stat_item fs/btrfs/volumes.c:7536 [inline]
 btrfs_run_dev_stats+0x446/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in write_extent_buffer+0x401/0xaf0 fs/btrfs/extent_io.c:6259
CPU: 1 PID: 11127 Comm: syz-executor.5 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 write_extent_buffer+0x401/0xaf0 fs/btrfs/extent_io.c:6259
 btrfs_set_dev_stats_value fs/btrfs/volumes.c:7436 [inline]
 update_dev_stat_item fs/btrfs/volumes.c:7573 [inline]
 btrfs_run_dev_stats+0xdd8/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f63549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ff982b0c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ff982bb0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e6a
RBP: 00000000ff982bb0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd0/0x1e0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5044
 alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2277
 alloc_pages include/linux/gfp.h:561 [inline]
 __page_cache_alloc mm/filemap.c:978 [inline]
 pagecache_get_page+0x111d/0x2040 mm/filemap.c:1797
 find_or_create_page include/linux/pagemap.h:405 [inline]
 alloc_extent_buffer+0x8f8/0x33d0 fs/btrfs/extent_io.c:5618
 btrfs_find_create_tree_block+0xb6/0xd0 fs/btrfs/disk-io.c:1024
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4743 [inline]
 btrfs_alloc_tree_block+0x545/0x2140 fs/btrfs/extent-tree.c:4845
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:992 [inline]
 __btrfs_cow_block+0xb93/0x2760 fs/btrfs/ctree.c:1048
 btrfs_cow_block+0xa3c/0xc90 fs/btrfs/ctree.c:1495
 btrfs_search_slot+0x1ad5/0x3f20 fs/btrfs/ctree.c:2676
 update_dev_stat_item fs/btrfs/volumes.c:7536 [inline]
 btrfs_run_dev_stats+0x446/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in write_extent_buffer+0x95b/0xaf0 fs/btrfs/extent_io.c:6258
CPU: 1 PID: 11127 Comm: syz-executor.5 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 write_extent_buffer+0x95b/0xaf0 fs/btrfs/extent_io.c:6258
 btrfs_set_dev_stats_value fs/btrfs/volumes.c:7436 [inline]
 update_dev_stat_item fs/btrfs/volumes.c:7573 [inline]
 btrfs_run_dev_stats+0xdd8/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f63549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ff982b0c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ff982bb0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e6a
RBP: 00000000ff982bb0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd0/0x1e0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5044
 alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2277
 alloc_pages include/linux/gfp.h:561 [inline]
 __page_cache_alloc mm/filemap.c:978 [inline]
 pagecache_get_page+0x111d/0x2040 mm/filemap.c:1797
 find_or_create_page include/linux/pagemap.h:405 [inline]
 alloc_extent_buffer+0x8f8/0x33d0 fs/btrfs/extent_io.c:5618
 btrfs_find_create_tree_block+0xb6/0xd0 fs/btrfs/disk-io.c:1024
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4743 [inline]
 btrfs_alloc_tree_block+0x545/0x2140 fs/btrfs/extent-tree.c:4845
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:992 [inline]
 __btrfs_cow_block+0xb93/0x2760 fs/btrfs/ctree.c:1048
 btrfs_cow_block+0xa3c/0xc90 fs/btrfs/ctree.c:1495
 btrfs_search_slot+0x1ad5/0x3f20 fs/btrfs/ctree.c:2676
 update_dev_stat_item fs/btrfs/volumes.c:7536 [inline]
 btrfs_run_dev_stats+0x446/0x13b0 fs/btrfs/volumes.c:7613
 commit_cowonly_roots+0x2ed/0x1560 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in btrfs_comp_cpu_keys fs/btrfs/ctree.c:1552 [inline]
BUG: KMSAN: uninit-value in comp_keys fs/btrfs/ctree.c:1528 [inline]
BUG: KMSAN: uninit-value in generic_bin_search+0x703/0xbc0 fs/btrfs/ctree.c:1702
CPU: 1 PID: 11127 Comm: syz-executor.5 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 btrfs_comp_cpu_keys fs/btrfs/ctree.c:1552 [inline]
 comp_keys fs/btrfs/ctree.c:1528 [inline]
 generic_bin_search+0x703/0xbc0 fs/btrfs/ctree.c:1702
 btrfs_bin_search fs/btrfs/ctree.c:1724 [inline]
 btrfs_search_slot+0x2144/0x3f20 fs/btrfs/ctree.c:2724
 btrfs_update_root+0x193/0x1220 fs/btrfs/root-tree.c:134
 update_cowonly_root fs/btrfs/transaction.c:1204 [inline]
 commit_cowonly_roots+0xbc2/0x1560 fs/btrfs/transaction.c:1266
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f63549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ff982b0c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ff982bb0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e6a
RBP: 00000000ff982bb0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd0/0x1e0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5044
 alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2277
 alloc_pages include/linux/gfp.h:561 [inline]
 __page_cache_alloc mm/filemap.c:978 [inline]
 pagecache_get_page+0x111d/0x2040 mm/filemap.c:1797
 find_or_create_page include/linux/pagemap.h:405 [inline]
 alloc_extent_buffer+0x8f8/0x33d0 fs/btrfs/extent_io.c:5618
 btrfs_find_create_tree_block+0xb6/0xd0 fs/btrfs/disk-io.c:1024
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4743 [inline]
 btrfs_alloc_tree_block+0x545/0x2140 fs/btrfs/extent-tree.c:4845
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:992 [inline]
 __btrfs_cow_block+0xb93/0x2760 fs/btrfs/ctree.c:1048
 btrfs_cow_block+0xa3c/0xc90 fs/btrfs/ctree.c:1495
 commit_cowonly_roots+0x1c8/0x1560 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x212b/0x5640 fs/btrfs/transaction.c:2293
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4210
 close_ctree+0x4b1/0xf57 fs/btrfs/disk-io.c:4275
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:325
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1056
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2353
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1136
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1143
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:167
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:210
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in btrfs_comp_cpu_keys fs/btrfs/ctree.c:1552 [inline]
BUG: KMSAN: uninit-value in comp_keys fs/btrfs/ctree.c:1528 [inline]
BUG: KMSAN: uninit-value in generic_bin_search+0x703/0xbc0 fs/btrfs/ctree.c:1702
CPU: 1 PID: 11127 Comm: syz-executor.5 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 btrfs_comp_cpu_keys fs/btrfs/ctree.c:1552 [inline]
 comp_keys fs/btrfs/ctree.c:1528 [inline]
 generic_bin_search+0x703/0xbc0 fs/btrfs/ctree.c:1702
 btrfs_bin_search fs/btrfs/ctree.c:1724 [inline]
 btrfs_search_slot+0x2144/0x3f20 fs/btrfs/ctree.c:2724
 btrfs_update_root+0x193/0x1220 fs/btrfs/root-tree.c:134
 update_cowonly_root fs/btrfs/transaction.c:1204 [inline]
 commi

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
