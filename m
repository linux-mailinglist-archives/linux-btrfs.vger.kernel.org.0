Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E64E38BF4A
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 08:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhEUG3q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 02:29:46 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:49703 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhEUG3p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 02:29:45 -0400
Received: by mail-il1-f199.google.com with SMTP id w11-20020a92db4b0000b02901bb97fba647so12615427ilq.16
        for <linux-btrfs@vger.kernel.org>; Thu, 20 May 2021 23:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=L1o9dROJQsgdwlXXsYssiQHRONQMaom05fZRhnUzMaM=;
        b=mgmKMTt/2mINdwdo11TyG5L0fNji03SFX2EhbsFrWLR+wb+BMFp/eFgJnE9jMLEqel
         XiDzICr1/wjoXxOyHMrV1kOkPyDgPjl7rDe+xz6G5PRfgbp4d6/Ewf/sXtUbbr2nJMSY
         ug2dKXVfl2K7Nm+bJYTK9qqqjtO3K/3P/d7bpJh+GOM5pzmk+DdO3tHM5pBXroco6513
         694TR66vDQKHh1ogiUV2f1FSfVVoHBX/HOC92rYeR1sMtwkebfOhtqoI+HD1iAz3Z315
         g8Slr45u9xbgKJg2LSkaUZwzsuoIcI9zYrQMoNzjAgpx3QSoPwobya0ax8QbjjKA78I+
         YNcQ==
X-Gm-Message-State: AOAM533YvH49eJYnHeBlT8/1AXpGptM5BuhQMTUE06AoFTG23mSxamVT
        HGaQBbCOR6Nhx8brIgGzYMlpZz30/O4mPtrd9RymRAcipMgC
X-Google-Smtp-Source: ABdhPJxcYZB3q/3R2kRQcoGb8XOt0BHkwlXCztiZlwj7eUE3aneFnpS3zjSscvuvv9GtZM+H20iVnIQzAswuVkZ6WMMGqdMk3HoL
MIME-Version: 1.0
X-Received: by 2002:a92:dd89:: with SMTP id g9mr10620062iln.209.1621578502682;
 Thu, 20 May 2021 23:28:22 -0700 (PDT)
Date:   Thu, 20 May 2021 23:28:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0c15e05c2d12ae5@google.com>
Subject: [syzbot] KMSAN: uninit-value in btrfs_get_64
From:   syzbot <syzbot+8831c9d3fefed7e973a3@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, glider@google.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bdefec9a minor fix
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12346a1dd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e6842a91012889c
dashboard link: https://syzkaller.appspot.com/bug?extid=8831c9d3fefed7e973a3
compiler:       Debian clang version 11.0.1-2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8831c9d3fefed7e973a3@syzkaller.appspotmail.com

 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in btrfs_get_64+0x4bb/0x680 fs/btrfs/struct-funcs.c:163
CPU: 0 PID: 9464 Comm: syz-executor.3 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 btrfs_get_64+0x4bb/0x680 fs/btrfs/struct-funcs.c:163
 btrfs_extent_refs fs/btrfs/ctree.h:1794 [inline]
 __btrfs_free_extent+0x2427/0x4df0 fs/btrfs/extent-tree.c:3123
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
RIP: 0023:0xf7f94549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffc5528c EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffc55330 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080ea118
RBP: 00000000ffc55330 R08: 0000000000000000 R09: 0000000000000000
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
 lookup_inline_extent_backref+0x73a/0x38e0 fs/btrfs/extent-tree.c:829
 lookup_extent_backref fs/btrfs/extent-tree.c:1045 [inline]
 __btrfs_free_extent+0x4e8/0x4df0 fs/btrfs/extent-tree.c:2984
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
BUG: KMSAN: uninit-value in check_setget_bounds fs/btrfs/struct-funcs.c:15 [inline]
BUG: KMSAN: uninit-value in btrfs_get_64+0x4d8/0x680 fs/btrfs/struct-funcs.c:163
CPU: 0 PID: 9464 Comm: syz-executor.3 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 check_setget_bounds fs/btrfs/struct-funcs.c:15 [inline]
 btrfs_get_64+0x4d8/0x680 fs/btrfs/struct-funcs.c:163
 btrfs_extent_refs fs/btrfs/ctree.h:1794 [inline]
 __btrfs_free_extent+0x2427/0x4df0 fs/btrfs/extent-tree.c:3123
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
RIP: 0023:0xf7f94549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffc5528c EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffc55330 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080ea118
RBP: 00000000ffc55330 R08: 0000000000000000 R09: 0000000000000000
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
 lookup_inline_extent_backref+0x73a/0x38e0 fs/btrfs/extent-tree.c:829
 lookup_extent_backref fs/btrfs/extent-tree.c:1045 [inline]
 __btrfs_free_extent+0x4e8/0x4df0 fs/btrfs/extent-tree.c:2984
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
BUG: KMSAN: uninit-value in check_setget_bounds fs/btrfs/struct-funcs.c:21 [inline]
BUG: KMSAN: uninit-value in btrfs_get_64+0x4ef/0x680 fs/btrfs/struct-funcs.c:163
CPU: 0 PID: 9464 Comm: syz-executor.3 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 check_setget_bounds fs/btrfs/struct-funcs.c:21 [inline]
 btrfs_get_64+0x4ef/0x680 fs/btrfs/struct-funcs.c:163
 btrfs_extent_refs fs/btrfs/ctree.h:1794 [inline]
 __btrfs_free_extent+0x2427/0x4df0 fs/btrfs/extent-tree.c:3123
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
RIP: 0023:0xf7f94549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffc5528c EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffc55330 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080ea118
RBP: 00000000ffc55330 R08: 0000000000000000 R09: 0000000000000000
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
 lookup_inline_extent_backref+0x73a/0x38e0 fs/btrfs/extent-tree.c:829
 lookup_extent_backref fs/btrfs/extent-tree.c:1045 [inline]
 __btrfs_free_extent+0x4e8/0x4df0 fs/btrfs/extent-tree.c:2984
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
BUG: KMSAN: uninit-value in btrfs_get_64+0x4fb/0x680 fs/btrfs/struct-funcs.c:163
CPU: 0 PID: 9464 Comm: syz-executor.3 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 btrfs_get_64+0x4fb/0x680 fs/btrfs/struct-funcs.c:163
 btrfs_extent_refs fs/btrfs/ctree.h:1794 [inline]
 __btrfs_free_extent+0x2427/0x4df0 fs/btrfs/extent-tree.c:3123
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
RIP: 0023:0xf7f94549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffc5528c EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffc55330 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080ea118
RBP: 00000000ffc55330 R08: 0000000000000000 R09: 0000000000000000
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
 lookup_inline_extent_backref+0x73a/0x38e0 fs/btrfs/extent-tree.c:829
 lookup_extent_backref fs/btrfs/extent-tree.c:1045 [inline]
 __btrfs_free_extent+0x4e8/0x4df0 fs/btrfs/extent-tree.c:2984
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
BUG: KMSAN: uninit-value in btrfs_get_64+0x508/0x680 fs/btrfs/struct-funcs.c:163
CPU: 0 PID: 9464 Comm: syz-executor.3 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 btrfs_get_64+0x508/0x680 fs/btrfs/struct-funcs.c:163
 btrfs_extent_refs fs/btrfs/ctree.h:1794 [inline]
 __btrfs_free_extent+0x2427/0x4df0 fs/btrfs/extent-tree.c:3123
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
RIP: 0023:0xf7f94549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffc5528c EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffc55330 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080ea118
RBP: 00000000ffc55330 R08: 0000000000000000 R09: 0000000000000000
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
 lookup_inline_extent_backref+0x73a/0x38e0 fs/btrfs/extent-tree.c:829
 lookup_extent_backref fs/btrfs/extent-tree.c:1045 [inline]
 __btrfs_free_extent+0x4e8/0x4df0 fs/btrfs/extent-tree.c:2984
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
BUG: KMSAN: uninit-value in __btrfs_free_extent+0x3088/0x4df0 fs/btrfs/extent-tree.c:3124
CPU: 0 PID: 9464 Comm: syz-executor.3 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 __btrfs_free_extent+0x3088/0x4df0 fs/btrfs/extent-tree.c:3124
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
RIP: 0023:0xf7f94549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffc5528c EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffc55330 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080ea118
RBP: 00000000ffc55330 R08: 0000000000000000 R09: 0000000000000000
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
 lookup_inline_extent_backref+0x73a/0x38e0 fs/btrfs/extent-tree.c:829
 lookup_extent_backref fs/btrfs/extent-tree.c:1045 [inline]
 __btrfs_free_extent+0x4e8/0x4df0 fs/btrfs/extent-tree.c:2984
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
BUG: KMSAN: uninit-value in __btrfs_free_extent+0x309f/0x4df0 fs/btrfs/extent-tree.c:3133
CPU: 0 PID: 9464 Comm: syz-executor.3 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 __btrfs_free_extent+0x309f/0x4df0 fs/btrfs/extent-tree.c:3133
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
RIP: 0023:0xf7f94549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffc5528c EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffc55330 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080ea118
RBP: 00000000ffc55330 R08: 0000000000000000 R09: 0000000000000000
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
 lookup_inline_extent_backref+0x73a/0x38e0 fs/btrfs/extent-tree.c:829
 lookup_extent_backref fs/btrfs/extent-tree.c:1045 [inline]
 __btrfs_free_extent+0x4e8/0x4df0 fs/btrfs/extent-tree.c:2984
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
BUG: KMSAN: uninit-value in __btrfs_free_extent+0x3e62/0x4df0 fs/btrfs/extent-tree.c:3172
CPU: 0 PID: 9464 Comm: syz-executor.3 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 __btrfs_free_extent+0x3e62/0x4df0 fs/btrfs/extent-tree.c:3172
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
RIP: 0023:0xf7f94549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffc5528c EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffc55330 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080ea118
RBP: 00000000ffc55330 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
 __msan_chain_origin+0x54/0xa0 mm/kmsan/kmsan_instr.c:147
 lookup_inline_extent_backref+0x3001/0x38e0 fs/btrfs/extent-tree.c:963
 lookup_extent_backref fs/btrfs/extent-tree.c:1045 [inline]
 __btrfs_free_extent+0x4e8/0x4df0 fs/btrfs/extent-tree.c:2984
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
 lookup_inline_extent_backref+0x73a/0x38e0 fs/btrfs/extent-tree.c:829
 lookup_extent_backref fs/btrfs/extent-tree.c:1045 [inline]
 __btrfs_free_extent+0x4e8/0x4df0 fs/btrfs/extent-tree.c:2984
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
BUG: KMSAN: uninit-value in memmove_extent_buffer+0x996/0xd30 fs/btrfs/extent_io.c:6573
CPU: 0 PID: 9464 Comm: syz-executor.3 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 check_eb_range fs/btrfs/extent_io.c:6115 [inline]
 memmove_extent_buffer+0x996/0xd30 fs/btrfs/extent_io.c:6573
 btrfs_del_items+0x763/0x1a50 fs/btrfs/ctree.c:4936
 __btrfs_free_extent+0x29d6/0x4df0 fs/btrfs/extent-tree.c:3200
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
RIP: 0023:0xf7f94549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffc5528c EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffc55330 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080ea118
RBP: 00000000ffc55330 R08: 0000000000000000 R09: 0000000000000000
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
 lookup_inline_extent_backref+0x73a/0x38e0 fs/btrfs/extent-tree.c:829
 lookup_extent_backref fs/btrfs/extent-tree.c:1045 [inline]
 __btrfs_free_extent+0x4e8/0x4df0 fs/btrfs/extent-tree.c:2984
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
BUG: KMSAN: uninit-value in memmove_extent_buffer+0x9a2/0xd30 fs/btrfs/extent_io.c:6573
CPU: 0 PID: 9464 Comm: syz-executor.3 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 check_eb_range fs/btrfs/extent_io.c:6115 [inline]
 memmove_extent_buffer+0x9a2/0xd30 fs/btrfs/extent_io.c:6573
 btrfs_del_items+0x763/0x1a50 fs/btrfs/ctree.c:4936
 __btrfs_free_extent+0x29d6/0x4df0 fs/btrfs/extent-tree.c:3200
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
RIP: 0023:0xf7f94549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffc5528c EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffc55330 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080ea118
RBP: 00000000ffc55330 R08: 0000000000000000 R09: 0000000000000000
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
 lookup_inline_extent_backref+0x73a/0x38e0 fs/btrfs/extent-tree.c:829
 lookup_extent_backref fs/btrfs/extent-tree.c:1045 [inline]
 __btrfs_free_extent+0x4e8/0x4df0 fs/btrfs/extent-tree.c:2984
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
BUG: KMSAN: uninit-value in memmove_extent_buffer+0x9ca/0xd30 fs/btrfs/extent_io.c:6574
CPU: 0 PID: 9464 Comm: syz-executor.3 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 check_eb_range fs/btrfs/extent_io.c:6115 [inline]
 memmove_extent_buffer+0x9ca/0xd30 fs/btrfs/extent_io.c:6574
 btrfs_del_items+0x763/0x1a50 fs/btrfs/ctree.c:4936
 __btrfs_free_extent+0x29d6/0x4df0 fs/btrfs/extent-tree.c:3200
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
RIP: 0023:0xf7f94549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffc5528c EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffc55330 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080ea118
RBP: 00000000ffc55330 R08: 0000000000000000 R09: 0000000000000000
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
 lookup_inline_extent_backref+0x73a/0x38e0 fs/btrfs/extent-tree.c:829
 lookup_extent_backref fs/btrfs/extent-tree.c:1045 [inline]
 __btrfs_free_extent+0x4e8/0x4df0 fs/btrfs/extent-tree.c:2984
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
BUG: KMSAN: uninit-value in memmove_extent_buffer+0x9db/0xd30 fs/btrfs/extent_io.c:6574
CPU: 0 PID: 9464 Comm: syz-executor.3 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 check_eb_range fs/btrfs/extent_io.c:6115 [inline]
 memmove_extent_buffer+0x9db/0xd30 fs/btrfs/extent_io.c:6574
 btrfs_del_items+0x763/0x1a50 fs/btrfs/ctree.c:4936
 __btrfs_free_extent+0x29d6/0x4df0 fs/btrfs/extent-tree.c:3200
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1683
 run_one_delayed_ref fs/btrfs/extent-tree.c:1707 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1961 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c20 fs/btrfs/extent-tree.c:2026
 btrfs_run_delayed_refs+0x2cc/0x910 fs/btrfs/extent-tree.c:2157
 commit_cowonly_roots+0xea1/0x1560 fs/btrfs/transaction.c:1272
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
 __do_fast_syscall_

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
