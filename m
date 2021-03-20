Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD946342C45
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Mar 2021 12:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhCTLei (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Mar 2021 07:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhCTLec (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Mar 2021 07:34:32 -0400
Received: from mail-qk1-x747.google.com (mail-qk1-x747.google.com [IPv6:2607:f8b0:4864:20::747])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851A7C0617AB
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Mar 2021 03:38:43 -0700 (PDT)
Received: by mail-qk1-x747.google.com with SMTP id i11so35624518qkn.21
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Mar 2021 03:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=EMUskcuEzog1w83F1xI5CU0Y2fOGHW/PlvzNd6W0cbM=;
        b=nEthL+P946dq74VX6bBcVgUtLRuNny7Y7Ku1eKoVHGQdr04NvKc238TjGAYIKSc8Xf
         QvWtPyEVQYLoqhsJflUHElhCw/prRr2VkVt9I/o2JKo/ozodeWGFeQtfKdorjRspCgGj
         MKG//elrQ7aLcDEFpp9NZ25C9E9HDOnZyrkIBtTc98S5G98z3lO3NDE5PuqNW5dp8dZU
         A+lqWqsyTOzTR0hvmC4kkR93a/LYxe5VzIzklWUGAWvuNKZFB6ufRRjlOfOUb9I5WjeY
         SNHMtXH/965jcpHLgaKnZ7Cb/g/0Apb6Ik5H8Kg1v2319/Fp+GdeTC1Te5pFxgbc/pcv
         GbXg==
X-Gm-Message-State: AOAM532sfqhMp3FrwI2XfVjdu/kIG6VEoaG/YI7/GJ1mDigUPKdjoY6E
        hpWmH1OlTfr0I4Al6OSsWD55aC5pyqFs9QULn175h5dnHM0A
X-Google-Smtp-Source: ABdhPJyOUiJ5rSKPDZDPIXfEb1UXPcGjInd8faowfincXo3IURCbE1yAlK+c+aGYLdRl3n8lQnEkSQFfvlZLnFpEiPJ6TCpUvNiO
MIME-Version: 1.0
X-Received: by 2002:a02:a303:: with SMTP id q3mr4392096jai.32.1616225182508;
 Sat, 20 Mar 2021 00:26:22 -0700 (PDT)
Date:   Sat, 20 Mar 2021 00:26:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e16a5e05bdf2bf08@google.com>
Subject: [syzbot] KMSAN: uninit-value in btrfs_del_items
From:   syzbot <syzbot+953f9d0ed7600c6d97fb@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, glider@google.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    29ad81a1 arch/x86: add missing include to sparsemem.h
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17eda2dcd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b976581f6bd1e7d
dashboard link: https://syzkaller.appspot.com/bug?extid=953f9d0ed7600c6d97fb
compiler:       Debian clang version 11.0.1-2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+953f9d0ed7600c6d97fb@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in btrfs_clean_tree_block+0x2a9/0x350 fs/btrfs/disk-io.c:995
CPU: 0 PID: 9616 Comm: syz-executor.3 Not tainted 5.11.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
=====================================================
=====================================================
BUG: KMSAN: uninit-value in check_eb_range fs/btrfs/extent_io.c:5690 [inline]
BUG: KMSAN: uninit-value in memmove_extent_buffer+0x9a2/0xd30 fs/btrfs/extent_io.c:6146
CPU: 0 PID: 9616 Comm: syz-executor.3 Tainted: G    B             5.11.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5f/0xa0 mm/kmsan/kmsan_instr.c:197
 check_eb_range fs/btrfs/extent_io.c:5690 [inline]
 memmove_extent_buffer+0x9a2/0xd30 fs/btrfs/extent_io.c:6146
 btrfs_del_items+0x763/0x1a50 fs/btrfs/ctree.c:4929
 __btrfs_free_extent+0x29d6/0x4df0 fs/btrfs/extent-tree.c:3210
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1689
 run_one_delayed_ref fs/btrfs/extent-tree.c:1713 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c10 fs/btrfs/extent-tree.c:2038
 btrfs_run_delayed_refs+0x2d6/0x920 fs/btrfs/extent-tree.c:2169
 commit_cowonly_roots+0x2ff/0x1620 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x204c/0x55b0 fs/btrfs/transaction.c:2275
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4076
 close_ctree+0x473/0xef7 fs/btrfs/disk-io.c:4140
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:326
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1055
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2347
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x12d/0x160 arch/x86/entry/common.c:79
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f13549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffe0580c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffe058b0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e3a
RBP: 00000000ffe058b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd3/0x1f0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5038
 alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2267
 alloc_pages include/linux/gfp.h:547 [inline]
 __page_cache_alloc mm/filemap.c:981 [inline]
 pagecache_get_page+0x1127/0x2070 mm/filemap.c:1841
 find_or_create_page include/linux/pagemap.h:404 [inline]
 alloc_extent_buffer+0x78c/0x28d0 fs/btrfs/extent_io.c:5293
 btrfs_find_create_tree_block+0xb6/0xd0 fs/btrfs/disk-io.c:959
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4597 [inline]
 btrfs_alloc_tree_block+0x545/0x2100 fs/btrfs/extent-tree.c:4698
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:989 [inline]
 __btrfs_cow_block+0xb93/0x2760 fs/btrfs/ctree.c:1045
 btrfs_cow_block+0xa3c/0xc90 fs/btrfs/ctree.c:1490
 btrfs_search_slot+0x1ad5/0x3f20 fs/btrfs/ctree.c:2670
 lookup_inline_extent_backref+0x73a/0x38e0 fs/btrfs/extent-tree.c:862
 lookup_extent_backref fs/btrfs/extent-tree.c:1078 [inline]
 __btrfs_free_extent+0x4e8/0x4df0 fs/btrfs/extent-tree.c:2994
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1689
 run_one_delayed_ref fs/btrfs/extent-tree.c:1713 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c10 fs/btrfs/extent-tree.c:2038
 btrfs_run_delayed_refs+0x2d6/0x920 fs/btrfs/extent-tree.c:2169
 commit_cowonly_roots+0x2ff/0x1620 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x204c/0x55b0 fs/btrfs/transaction.c:2275
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4076
 close_ctree+0x473/0xef7 fs/btrfs/disk-io.c:4140
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:326
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1055
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2347
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x12d/0x160 arch/x86/entry/common.c:79
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in check_eb_range fs/btrfs/extent_io.c:5690 [inline]
BUG: KMSAN: uninit-value in memmove_extent_buffer+0x9ca/0xd30 fs/btrfs/extent_io.c:6147
CPU: 0 PID: 9616 Comm: syz-executor.3 Tainted: G    B             5.11.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5f/0xa0 mm/kmsan/kmsan_instr.c:197
 check_eb_range fs/btrfs/extent_io.c:5690 [inline]
 memmove_extent_buffer+0x9ca/0xd30 fs/btrfs/extent_io.c:6147
 btrfs_del_items+0x763/0x1a50 fs/btrfs/ctree.c:4929
 __btrfs_free_extent+0x29d6/0x4df0 fs/btrfs/extent-tree.c:3210
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1689
 run_one_delayed_ref fs/btrfs/extent-tree.c:1713 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c10 fs/btrfs/extent-tree.c:2038
 btrfs_run_delayed_refs+0x2d6/0x920 fs/btrfs/extent-tree.c:2169
 commit_cowonly_roots+0x2ff/0x1620 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x204c/0x55b0 fs/btrfs/transaction.c:2275
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4076
 close_ctree+0x473/0xef7 fs/btrfs/disk-io.c:4140
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:326
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1055
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2347
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x12d/0x160 arch/x86/entry/common.c:79
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f13549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffe0580c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffe058b0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e3a
RBP: 00000000ffe058b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd3/0x1f0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5038
 alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2267
 alloc_pages include/linux/gfp.h:547 [inline]
 __page_cache_alloc mm/filemap.c:981 [inline]
 pagecache_get_page+0x1127/0x2070 mm/filemap.c:1841
 find_or_create_page include/linux/pagemap.h:404 [inline]
 alloc_extent_buffer+0x78c/0x28d0 fs/btrfs/extent_io.c:5293
 btrfs_find_create_tree_block+0xb6/0xd0 fs/btrfs/disk-io.c:959
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4597 [inline]
 btrfs_alloc_tree_block+0x545/0x2100 fs/btrfs/extent-tree.c:4698
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:989 [inline]
 __btrfs_cow_block+0xb93/0x2760 fs/btrfs/ctree.c:1045
 btrfs_cow_block+0xa3c/0xc90 fs/btrfs/ctree.c:1490
 btrfs_search_slot+0x1ad5/0x3f20 fs/btrfs/ctree.c:2670
 lookup_inline_extent_backref+0x73a/0x38e0 fs/btrfs/extent-tree.c:862
 lookup_extent_backref fs/btrfs/extent-tree.c:1078 [inline]
 __btrfs_free_extent+0x4e8/0x4df0 fs/btrfs/extent-tree.c:2994
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1689
 run_one_delayed_ref fs/btrfs/extent-tree.c:1713 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c10 fs/btrfs/extent-tree.c:2038
 btrfs_run_delayed_refs+0x2d6/0x920 fs/btrfs/extent-tree.c:2169
 commit_cowonly_roots+0x2ff/0x1620 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x204c/0x55b0 fs/btrfs/transaction.c:2275
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4076
 close_ctree+0x473/0xef7 fs/btrfs/disk-io.c:4140
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:326
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1055
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2347
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x12d/0x160 arch/x86/entry/common.c:79
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in check_eb_range fs/btrfs/extent_io.c:5690 [inline]
BUG: KMSAN: uninit-value in memmove_extent_buffer+0x9db/0xd30 fs/btrfs/extent_io.c:6147
CPU: 0 PID: 9616 Comm: syz-executor.3 Tainted: G    B             5.11.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5f/0xa0 mm/kmsan/kmsan_instr.c:197
 check_eb_range fs/btrfs/extent_io.c:5690 [inline]
 memmove_extent_buffer+0x9db/0xd30 fs/btrfs/extent_io.c:6147
 btrfs_del_items+0x763/0x1a50 fs/btrfs/ctree.c:4929
 __btrfs_free_extent+0x29d6/0x4df0 fs/btrfs/extent-tree.c:3210
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1689
 run_one_delayed_ref fs/btrfs/extent-tree.c:1713 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c10 fs/btrfs/extent-tree.c:2038
 btrfs_run_delayed_refs+0x2d6/0x920 fs/btrfs/extent-tree.c:2169
 commit_cowonly_roots+0x2ff/0x1620 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x204c/0x55b0 fs/btrfs/transaction.c:2275
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4076
 close_ctree+0x473/0xef7 fs/btrfs/disk-io.c:4140
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:326
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1055
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2347
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x12d/0x160 arch/x86/entry/common.c:79
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f13549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffe0580c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffe058b0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e3a
RBP: 00000000ffe058b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd3/0x1f0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5038
 alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2267
 alloc_pages include/linux/gfp.h:547 [inline]
 __page_cache_alloc mm/filemap.c:981 [inline]
 pagecache_get_page+0x1127/0x2070 mm/filemap.c:1841
 find_or_create_page include/linux/pagemap.h:404 [inline]
 alloc_extent_buffer+0x78c/0x28d0 fs/btrfs/extent_io.c:5293
 btrfs_find_create_tree_block+0xb6/0xd0 fs/btrfs/disk-io.c:959
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4597 [inline]
 btrfs_alloc_tree_block+0x545/0x2100 fs/btrfs/extent-tree.c:4698
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:989 [inline]
 __btrfs_cow_block+0xb93/0x2760 fs/btrfs/ctree.c:1045
 btrfs_cow_block+0xa3c/0xc90 fs/btrfs/ctree.c:1490
 btrfs_search_slot+0x1ad5/0x3f20 fs/btrfs/ctree.c:2670
 lookup_inline_extent_backref+0x73a/0x38e0 fs/btrfs/extent-tree.c:862
 lookup_extent_backref fs/btrfs/extent-tree.c:1078 [inline]
 __btrfs_free_extent+0x4e8/0x4df0 fs/btrfs/extent-tree.c:2994
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1689
 run_one_delayed_ref fs/btrfs/extent-tree.c:1713 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c10 fs/btrfs/extent-tree.c:2038
 btrfs_run_delayed_refs+0x2d6/0x920 fs/btrfs/extent-tree.c:2169
 commit_cowonly_roots+0x2ff/0x1620 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x204c/0x55b0 fs/btrfs/transaction.c:2275
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4076
 close_ctree+0x473/0xef7 fs/btrfs/disk-io.c:4140
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:326
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1055
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2347
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x12d/0x160 arch/x86/entry/common.c:79
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in memmove_extent_buffer+0xb39/0xd30 fs/btrfs/extent_io.c:6149
CPU: 0 PID: 9616 Comm: syz-executor.3 Tainted: G    B             5.11.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5f/0xa0 mm/kmsan/kmsan_instr.c:197
 memmove_extent_buffer+0xb39/0xd30 fs/btrfs/extent_io.c:6149
 btrfs_del_items+0x763/0x1a50 fs/btrfs/ctree.c:4929
 __btrfs_free_extent+0x29d6/0x4df0 fs/btrfs/extent-tree.c:3210
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1689
 run_one_delayed_ref fs/btrfs/extent-tree.c:1713 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c10 fs/btrfs/extent-tree.c:2038
 btrfs_run_delayed_refs+0x2d6/0x920 fs/btrfs/extent-tree.c:2169
 commit_cowonly_roots+0x2ff/0x1620 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x204c/0x55b0 fs/btrfs/transaction.c:2275
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4076
 close_ctree+0x473/0xef7 fs/btrfs/disk-io.c:4140
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:326
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1055
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2347
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x12d/0x160 arch/x86/entry/common.c:79
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f13549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffe0580c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffe058b0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e3a
RBP: 00000000ffe058b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd3/0x1f0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5038
 alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2267
 alloc_pages include/linux/gfp.h:547 [inline]
 __page_cache_alloc mm/filemap.c:981 [inline]
 pagecache_get_page+0x1127/0x2070 mm/filemap.c:1841
 find_or_create_page include/linux/pagemap.h:404 [inline]
 alloc_extent_buffer+0x78c/0x28d0 fs/btrfs/extent_io.c:5293
 btrfs_find_create_tree_block+0xb6/0xd0 fs/btrfs/disk-io.c:959
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4597 [inline]
 btrfs_alloc_tree_block+0x545/0x2100 fs/btrfs/extent-tree.c:4698
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:989 [inline]
 __btrfs_cow_block+0xb93/0x2760 fs/btrfs/ctree.c:1045
 btrfs_cow_block+0xa3c/0xc90 fs/btrfs/ctree.c:1490
 btrfs_search_slot+0x1ad5/0x3f20 fs/btrfs/ctree.c:2670
 lookup_inline_extent_backref+0x73a/0x38e0 fs/btrfs/extent-tree.c:862
 lookup_extent_backref fs/btrfs/extent-tree.c:1078 [inline]
 __btrfs_free_extent+0x4e8/0x4df0 fs/btrfs/extent-tree.c:2994
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1689
 run_one_delayed_ref fs/btrfs/extent-tree.c:1713 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c10 fs/btrfs/extent-tree.c:2038
 btrfs_run_delayed_refs+0x2d6/0x920 fs/btrfs/extent-tree.c:2169
 commit_cowonly_roots+0x2ff/0x1620 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x204c/0x55b0 fs/btrfs/transaction.c:2275
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4076
 close_ctree+0x473/0xef7 fs/btrfs/disk-io.c:4140
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:326
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1055
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2347
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x12d/0x160 arch/x86/entry/common.c:79
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in memmove_extent_buffer+0xcb6/0xd30 fs/btrfs/extent_io.c:6153
CPU: 0 PID: 9616 Comm: syz-executor.3 Tainted: G    B             5.11.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5f/0xa0 mm/kmsan/kmsan_instr.c:197
 memmove_extent_buffer+0xcb6/0xd30 fs/btrfs/extent_io.c:6153
 btrfs_del_items+0x763/0x1a50 fs/btrfs/ctree.c:4929
 __btrfs_free_extent+0x29d6/0x4df0 fs/btrfs/extent-tree.c:3210
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1689
 run_one_delayed_ref fs/btrfs/extent-tree.c:1713 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c10 fs/btrfs/extent-tree.c:2038
 btrfs_run_delayed_refs+0x2d6/0x920 fs/btrfs/extent-tree.c:2169
 commit_cowonly_roots+0x2ff/0x1620 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x204c/0x55b0 fs/btrfs/transaction.c:2275
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4076
 close_ctree+0x473/0xef7 fs/btrfs/disk-io.c:4140
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:326
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1055
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2347
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x12d/0x160 arch/x86/entry/common.c:79
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f13549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffe0580c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffe058b0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e3a
RBP: 00000000ffe058b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd3/0x1f0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5038
 alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2267
 alloc_pages include/linux/gfp.h:547 [inline]
 __page_cache_alloc mm/filemap.c:981 [inline]
 pagecache_get_page+0x1127/0x2070 mm/filemap.c:1841
 find_or_create_page include/linux/pagemap.h:404 [inline]
 alloc_extent_buffer+0x78c/0x28d0 fs/btrfs/extent_io.c:5293
 btrfs_find_create_tree_block+0xb6/0xd0 fs/btrfs/disk-io.c:959
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4597 [inline]
 btrfs_alloc_tree_block+0x545/0x2100 fs/btrfs/extent-tree.c:4698
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:989 [inline]
 __btrfs_cow_block+0xb93/0x2760 fs/btrfs/ctree.c:1045
 btrfs_cow_block+0xa3c/0xc90 fs/btrfs/ctree.c:1490
 btrfs_search_slot+0x1ad5/0x3f20 fs/btrfs/ctree.c:2670
 lookup_inline_extent_backref+0x73a/0x38e0 fs/btrfs/extent-tree.c:862
 lookup_extent_backref fs/btrfs/extent-tree.c:1078 [inline]
 __btrfs_free_extent+0x4e8/0x4df0 fs/btrfs/extent-tree.c:2994
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1689
 run_one_delayed_ref fs/btrfs/extent-tree.c:1713 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c10 fs/btrfs/extent-tree.c:2038
 btrfs_run_delayed_refs+0x2d6/0x920 fs/btrfs/extent-tree.c:2169
 commit_cowonly_roots+0x2ff/0x1620 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x204c/0x55b0 fs/btrfs/transaction.c:2275
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4076
 close_ctree+0x473/0xef7 fs/btrfs/disk-io.c:4140
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:326
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1055
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2347
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x12d/0x160 arch/x86/entry/common.c:79
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in memmove_extent_buffer+0x8e4/0xd30 fs/btrfs/extent_io.c:6162
CPU: 0 PID: 9616 Comm: syz-executor.3 Tainted: G    B             5.11.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5f/0xa0 mm/kmsan/kmsan_instr.c:197
 memmove_extent_buffer+0x8e4/0xd30 fs/btrfs/extent_io.c:6162
 btrfs_del_items+0x763/0x1a50 fs/btrfs/ctree.c:4929
 __btrfs_free_extent+0x29d6/0x4df0 fs/btrfs/extent-tree.c:3210
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1689
 run_one_delayed_ref fs/btrfs/extent-tree.c:1713 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c10 fs/btrfs/extent-tree.c:2038
 btrfs_run_delayed_refs+0x2d6/0x920 fs/btrfs/extent-tree.c:2169
 commit_cowonly_roots+0x2ff/0x1620 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x204c/0x55b0 fs/btrfs/transaction.c:2275
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4076
 close_ctree+0x473/0xef7 fs/btrfs/disk-io.c:4140
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:326
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1055
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2347
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x12d/0x160 arch/x86/entry/common.c:79
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f13549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffe0580c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffe058b0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e3a
RBP: 00000000ffe058b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd3/0x1f0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5038
 alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2267
 alloc_pages include/linux/gfp.h:547 [inline]
 __page_cache_alloc mm/filemap.c:981 [inline]
 pagecache_get_page+0x1127/0x2070 mm/filemap.c:1841
 find_or_create_page include/linux/pagemap.h:404 [inline]
 alloc_extent_buffer+0x78c/0x28d0 fs/btrfs/extent_io.c:5293
 btrfs_find_create_tree_block+0xb6/0xd0 fs/btrfs/disk-io.c:959
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4597 [inline]
 btrfs_alloc_tree_block+0x545/0x2100 fs/btrfs/extent-tree.c:4698
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:989 [inline]
 __btrfs_cow_block+0xb93/0x2760 fs/btrfs/ctree.c:1045
 btrfs_cow_block+0xa3c/0xc90 fs/btrfs/ctree.c:1490
 btrfs_search_slot+0x1ad5/0x3f20 fs/btrfs/ctree.c:2670
 lookup_inline_extent_backref+0x73a/0x38e0 fs/btrfs/extent-tree.c:862
 lookup_extent_backref fs/btrfs/extent-tree.c:1078 [inline]
 __btrfs_free_extent+0x4e8/0x4df0 fs/btrfs/extent-tree.c:2994
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1689
 run_one_delayed_ref fs/btrfs/extent-tree.c:1713 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c10 fs/btrfs/extent-tree.c:2038
 btrfs_run_delayed_refs+0x2d6/0x920 fs/btrfs/extent-tree.c:2169
 commit_cowonly_roots+0x2ff/0x1620 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x204c/0x55b0 fs/btrfs/transaction.c:2275
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4076
 close_ctree+0x473/0xef7 fs/btrfs/disk-io.c:4140
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:326
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1055
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2347
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x12d/0x160 arch/x86/entry/common.c:79
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in memmove_extent_buffer+0x8fb/0xd30 fs/btrfs/extent_io.c:6162
CPU: 0 PID: 9616 Comm: syz-executor.3 Tainted: G    B             5.11.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5f/0xa0 mm/kmsan/kmsan_instr.c:197
 memmove_extent_buffer+0x8fb/0xd30 fs/btrfs/extent_io.c:6162
 btrfs_del_items+0x763/0x1a50 fs/btrfs/ctree.c:4929
 __btrfs_free_extent+0x29d6/0x4df0 fs/btrfs/extent-tree.c:3210
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1689
 run_one_delayed_ref fs/btrfs/extent-tree.c:1713 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c10 fs/btrfs/extent-tree.c:2038
 btrfs_run_delayed_refs+0x2d6/0x920 fs/btrfs/extent-tree.c:2169
 commit_cowonly_roots+0x2ff/0x1620 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x204c/0x55b0 fs/btrfs/transaction.c:2275
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4076
 close_ctree+0x473/0xef7 fs/btrfs/disk-io.c:4140
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:326
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1055
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2347
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x12d/0x160 arch/x86/entry/common.c:79
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f13549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffe0580c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffe058b0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e3a
RBP: 00000000ffe058b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd3/0x1f0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5038
 alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2267
 alloc_pages include/linux/gfp.h:547 [inline]
 __page_cache_alloc mm/filemap.c:981 [inline]
 pagecache_get_page+0x1127/0x2070 mm/filemap.c:1841
 find_or_create_page include/linux/pagemap.h:404 [inline]
 alloc_extent_buffer+0x78c/0x28d0 fs/btrfs/extent_io.c:5293
 btrfs_find_create_tree_block+0xb6/0xd0 fs/btrfs/disk-io.c:959
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4597 [inline]
 btrfs_alloc_tree_block+0x545/0x2100 fs/btrfs/extent-tree.c:4698
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:989 [inline]
 __btrfs_cow_block+0xb93/0x2760 fs/btrfs/ctree.c:1045
 btrfs_cow_block+0xa3c/0xc90 fs/btrfs/ctree.c:1490
 btrfs_search_slot+0x1ad5/0x3f20 fs/btrfs/ctree.c:2670
 lookup_inline_extent_backref+0x73a/0x38e0 fs/btrfs/extent-tree.c:862
 lookup_extent_backref fs/btrfs/extent-tree.c:1078 [inline]
 __btrfs_free_extent+0x4e8/0x4df0 fs/btrfs/extent-tree.c:2994
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1689
 run_one_delayed_ref fs/btrfs/extent-tree.c:1713 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c10 fs/btrfs/extent-tree.c:2038
 btrfs_run_delayed_refs+0x2d6/0x920 fs/btrfs/extent-tree.c:2169
 commit_cowonly_roots+0x2ff/0x1620 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x204c/0x55b0 fs/btrfs/transaction.c:2275
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4076
 close_ctree+0x473/0xef7 fs/btrfs/disk-io.c:4140
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:326
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1055
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2347
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x12d/0x160 arch/x86/entry/common.c:79
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in copy_pages fs/btrfs/extent_io.c:6093 [inline]
BUG: KMSAN: uninit-value in memmove_extent_buffer+0x97e/0xd30 fs/btrfs/extent_io.c:6162
CPU: 0 PID: 9616 Comm: syz-executor.3 Tainted: G    B             5.11.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5f/0xa0 mm/kmsan/kmsan_instr.c:197
 copy_pages fs/btrfs/extent_io.c:6093 [inline]
 memmove_extent_buffer+0x97e/0xd30 fs/btrfs/extent_io.c:6162
 btrfs_del_items+0x763/0x1a50 fs/btrfs/ctree.c:4929
 __btrfs_free_extent+0x29d6/0x4df0 fs/btrfs/extent-tree.c:3210
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1689
 run_one_delayed_ref fs/btrfs/extent-tree.c:1713 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c10 fs/btrfs/extent-tree.c:2038
 btrfs_run_delayed_refs+0x2d6/0x920 fs/btrfs/extent-tree.c:2169
 commit_cowonly_roots+0x2ff/0x1620 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x204c/0x55b0 fs/btrfs/transaction.c:2275
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4076
 close_ctree+0x473/0xef7 fs/btrfs/disk-io.c:4140
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:326
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1055
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2347
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x12d/0x160 arch/x86/entry/common.c:79
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f13549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffe0580c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffe058b0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e3a
RBP: 00000000ffe058b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd3/0x1f0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5038
 alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2267
 alloc_pages include/linux/gfp.h:547 [inline]
 __page_cache_alloc mm/filemap.c:981 [inline]
 pagecache_get_page+0x1127/0x2070 mm/filemap.c:1841
 find_or_create_page include/linux/pagemap.h:404 [inline]
 alloc_extent_buffer+0x78c/0x28d0 fs/btrfs/extent_io.c:5293
 btrfs_find_create_tree_block+0xb6/0xd0 fs/btrfs/disk-io.c:959
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4597 [inline]
 btrfs_alloc_tree_block+0x545/0x2100 fs/btrfs/extent-tree.c:4698
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:989 [inline]
 __btrfs_cow_block+0xb93/0x2760 fs/btrfs/ctree.c:1045
 btrfs_cow_block+0xa3c/0xc90 fs/btrfs/ctree.c:1490
 btrfs_search_slot+0x1ad5/0x3f20 fs/btrfs/ctree.c:2670
 lookup_inline_extent_backref+0x73a/0x38e0 fs/btrfs/extent-tree.c:862
 lookup_extent_backref fs/btrfs/extent-tree.c:1078 [inline]
 __btrfs_free_extent+0x4e8/0x4df0 fs/btrfs/extent-tree.c:2994
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1689
 run_one_delayed_ref fs/btrfs/extent-tree.c:1713 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c10 fs/btrfs/extent-tree.c:2038
 btrfs_run_delayed_refs+0x2d6/0x920 fs/btrfs/extent-tree.c:2169
 commit_cowonly_roots+0x2ff/0x1620 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x204c/0x55b0 fs/btrfs/transaction.c:2275
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4076
 close_ctree+0x473/0xef7 fs/btrfs/disk-io.c:4140
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:326
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1055
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2347
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x12d/0x160 arch/x86/entry/common.c:79
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in stack_trace_consume_entry+0x151/0x310 kernel/stacktrace.c:85
CPU: 0 PID: 9616 Comm: syz-executor.3 Tainted: G    B             5.11.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5f/0xa0 mm/kmsan/kmsan_instr.c:197
 stack_trace_consume_entry+0x151/0x310 kernel/stacktrace.c:85
 arch_stack_walk+0x2fa/0x3c0 arch/x86/kernel/stacktrace.c:27
 stack_trace_save+0x117/0x1a0 kernel/stacktrace.c:121
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
 kmsan_memcpy_memmove_metadata+0x25e/0x2d0 mm/kmsan/kmsan.c:226
 kmsan_memmove_metadata+0xe/0x10 mm/kmsan/kmsan.c:251
 __msan_memmove+0x46/0x60 mm/kmsan/kmsan_instr.c:92
 copy_pages fs/btrfs/extent_io.c:6094 [inline]
 memmove_extent_buffer+0x7c3/0xd30 fs/btrfs/extent_io.c:6162
 btrfs_del_items+0x763/0x1a50 fs/btrfs/ctree.c:4929
 __btrfs_free_extent+0x29d6/0x4df0 fs/btrfs/extent-tree.c:3210
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1689
 run_one_delayed_ref fs/btrfs/extent-tree.c:1713 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c10 fs/btrfs/extent-tree.c:2038
 btrfs_run_delayed_refs+0x2d6/0x920 fs/btrfs/extent-tree.c:2169
 commit_cowonly_roots+0x2ff/0x1620 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x204c/0x55b0 fs/btrfs/transaction.c:2275
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4076
 close_ctree+0x473/0xef7 fs/btrfs/disk-io.c:4140
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:326
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1055
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2347
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x12d/0x160 arch/x86/entry/common.c:79
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f13549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffe0580c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffe058b0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e3a
RBP: 00000000ffe058b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
 __msan_chain_origin+0x57/0xa0 mm/kmsan/kmsan_instr.c:147
 stack_trace_save+0x17f/0x1a0 kernel/stacktrace.c:115
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
 kmsan_memcpy_memmove_metadata+0x25e/0x2d0 mm/kmsan/kmsan.c:226
 kmsan_memmove_metadata+0xe/0x10 mm/kmsan/kmsan.c:251
 __msan_memmove+0x46/0x60 mm/kmsan/kmsan_instr.c:92
 copy_pages fs/btrfs/extent_io.c:6094 [inline]
 memmove_extent_buffer+0x7c3/0xd30 fs/btrfs/extent_io.c:6162
 btrfs_del_items+0x763/0x1a50 fs/btrfs/ctree.c:4929
 __btrfs_free_extent+0x29d6/0x4df0 fs/btrfs/extent-tree.c:3210
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1689
 run_one_delayed_ref fs/btrfs/extent-tree.c:1713 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c10 fs/btrfs/extent-tree.c:2038
 btrfs_run_delayed_refs+0x2d6/0x920 fs/btrfs/extent-tree.c:2169
 commit_cowonly_roots+0x2ff/0x1620 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x204c/0x55b0 fs/btrfs/transaction.c:2275
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4076
 close_ctree+0x473/0xef7 fs/btrfs/disk-io.c:4140
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:326
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1055
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2347
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x12d/0x160 arch/x86/entry/common.c:79
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd3/0x1f0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5038
 alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2267
 alloc_pages include/linux/gfp.h:547 [inline]
 __page_cache_alloc mm/filemap.c:981 [inline]
 pagecache_get_page+0x1127/0x2070 mm/filemap.c:1841
 find_or_create_page include/linux/pagemap.h:404 [inline]
 alloc_extent_buffer+0x78c/0x28d0 fs/btrfs/extent_io.c:5293
 btrfs_find_create_tree_block+0xb6/0xd0 fs/btrfs/disk-io.c:959
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4597 [inline]
 btrfs_alloc_tree_block+0x545/0x2100 fs/btrfs/extent-tree.c:4698
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:989 [inline]
 __btrfs_cow_block+0xb93/0x2760 fs/btrfs/ctree.c:1045
 btrfs_cow_block+0xa3c/0xc90 fs/btrfs/ctree.c:1490
 btrfs_search_slot+0x1ad5/0x3f20 fs/btrfs/ctree.c:2670
 lookup_inline_extent_backref+0x73a/0x38e0 fs/btrfs/extent-tree.c:862
 lookup_extent_backref fs/btrfs/extent-tree.c:1078 [inline]
 __btrfs_free_extent+0x4e8/0x4df0 fs/btrfs/extent-tree.c:2994
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1689
 run_one_delayed_ref fs/btrfs/extent-tree.c:1713 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c10 fs/btrfs/extent-tree.c:2038
 btrfs_run_delayed_refs+0x2d6/0x920 fs/btrfs/extent-tree.c:2169
 commit_cowonly_roots+0x2ff/0x1620 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x204c/0x55b0 fs/btrfs/transaction.c:2275
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4076
 close_ctree+0x473/0xef7 fs/btrfs/disk-io.c:4140
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:326
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1055
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2347
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x12d/0x160 arch/x86/entry/common.c:79
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in stack_trace_consume_entry+0x171/0x310 kernel/stacktrace.c:88
CPU: 0 PID: 9616 Comm: syz-executor.3 Tainted: G    B             5.11.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5f/0xa0 mm/kmsan/kmsan_instr.c:197
 stack_trace_consume_entry+0x171/0x310 kernel/stacktrace.c:88
 arch_stack_walk+0x2fa/0x3c0 arch/x86/kernel/stacktrace.c:27
 stack_trace_save+0x117/0x1a0 kernel/stacktrace.c:121
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
 kmsan_memcpy_memmove_metadata+0x25e/0x2d0 mm/kmsan/kmsan.c:226
 kmsan_memmove_metadata+0xe/0x10 mm/kmsan/kmsan.c:251
 __msan_memmove+0x46/0x60 mm/kmsan/kmsan_instr.c:92
 copy_pages fs/btrfs/extent_io.c:6094 [inline]
 memmove_extent_buffer+0x7c3/0xd30 fs/btrfs/extent_io.c:6162
 btrfs_del_items+0x763/0x1a50 fs/btrfs/ctree.c:4929
 __btrfs_free_extent+0x29d6/0x4df0 fs/btrfs/extent-tree.c:3210
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1689
 run_one_delayed_ref fs/btrfs/extent-tree.c:1713 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c10 fs/btrfs/extent-tree.c:2038
 btrfs_run_delayed_refs+0x2d6/0x920 fs/btrfs/extent-tree.c:2169
 commit_cowonly_roots+0x2ff/0x1620 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x204c/0x55b0 fs/btrfs/transaction.c:2275
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4076
 close_ctree+0x473/0xef7 fs/btrfs/disk-io.c:4140
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:326
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1055
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2347
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x12d/0x160 arch/x86/entry/common.c:79
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f13549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffe0580c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffe058b0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e3a
RBP: 00000000ffe058b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
 __msan_chain_origin+0x57/0xa0 mm/kmsan/kmsan_instr.c:147
 stack_trace_save+0x193/0x1a0 kernel/stacktrace.c:115
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
 kmsan_memcpy_memmove_metadata+0x25e/0x2d0 mm/kmsan/kmsan.c:226
 kmsan_memmove_metadata+0xe/0x10 mm/kmsan/kmsan.c:251
 __msan_memmove+0x46/0x60 mm/kmsan/kmsan_instr.c:92
 copy_pages fs/btrfs/extent_io.c:6094 [inline]
 memmove_extent_buffer+0x7c3/0xd30 fs/btrfs/extent_io.c:6162
 btrfs_del_items+0x763/0x1a50 fs/btrfs/ctree.c:4929
 __btrfs_free_extent+0x29d6/0x4df0 fs/btrfs/extent-tree.c:3210
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1689
 run_one_delayed_ref fs/btrfs/extent-tree.c:1713 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c10 fs/btrfs/extent-tree.c:2038
 btrfs_run_delayed_refs+0x2d6/0x920 fs/btrfs/extent-tree.c:2169
 commit_cowonly_roots+0x2ff/0x1620 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x204c/0x55b0 fs/btrfs/transaction.c:2275
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4076
 close_ctree+0x473/0xef7 fs/btrfs/disk-io.c:4140
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:326
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1055
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2347
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x12d/0x160 arch/x86/entry/common.c:79
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
 kmsan_alloc_page+0xd3/0x1f0 mm/kmsan/kmsan_shadow.c:274
 __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5038
 alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2267
 alloc_pages include/linux/gfp.h:547 [inline]
 __page_cache_alloc mm/filemap.c:981 [inline]
 pagecache_get_page+0x1127/0x2070 mm/filemap.c:1841
 find_or_create_page include/linux/pagemap.h:404 [inline]
 alloc_extent_buffer+0x78c/0x28d0 fs/btrfs/extent_io.c:5293
 btrfs_find_create_tree_block+0xb6/0xd0 fs/btrfs/disk-io.c:959
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4597 [inline]
 btrfs_alloc_tree_block+0x545/0x2100 fs/btrfs/extent-tree.c:4698
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:989 [inline]
 __btrfs_cow_block+0xb93/0x2760 fs/btrfs/ctree.c:1045
 btrfs_cow_block+0xa3c/0xc90 fs/btrfs/ctree.c:1490
 btrfs_search_slot+0x1ad5/0x3f20 fs/btrfs/ctree.c:2670
 lookup_inline_extent_backref+0x73a/0x38e0 fs/btrfs/extent-tree.c:862
 lookup_extent_backref fs/btrfs/extent-tree.c:1078 [inline]
 __btrfs_free_extent+0x4e8/0x4df0 fs/btrfs/extent-tree.c:2994
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1689
 run_one_delayed_ref fs/btrfs/extent-tree.c:1713 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c10 fs/btrfs/extent-tree.c:2038
 btrfs_run_delayed_refs+0x2d6/0x920 fs/btrfs/extent-tree.c:2169
 commit_cowonly_roots+0x2ff/0x1620 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x204c/0x55b0 fs/btrfs/transaction.c:2275
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4076
 close_ctree+0x473/0xef7 fs/btrfs/disk-io.c:4140
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:326
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1055
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2347
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x12d/0x160 arch/x86/entry/common.c:79
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in stack_trace_consume_entry+0x151/0x310 kernel/stacktrace.c:85
CPU: 0 PID: 9616 Comm: syz-executor.3 Tainted: G    B             5.11.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5f/0xa0 mm/kmsan/kmsan_instr.c:197
 stack_trace_consume_entry+0x151/0x310 kernel/stacktrace.c:85
 arch_stack_walk+0x2fa/0x3c0 arch/x86/kernel/stacktrace.c:27
 stack_trace_save+0x117/0x1a0 kernel/stacktrace.c:121
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
 kmsan_memcpy_memmove_metadata+0x25e/0x2d0 mm/kmsan/kmsan.c:226
 kmsan_memmove_metadata+0xe/0x10 mm/kmsan/kmsan.c:251
 __msan_memmove+0x46/0x60 mm/kmsan/kmsan_instr.c:92
 copy_pages fs/btrfs/extent_io.c:6094 [inline]
 memmove_extent_buffer+0x7c3/0xd30 fs/btrfs/extent_io.c:6162
 btrfs_del_items+0x763/0x1a50 fs/btrfs/ctree.c:4929
 __btrfs_free_extent+0x29d6/0x4df0 fs/btrfs/extent-tree.c:3210
 run_delayed_tree_ref+0x806/0xa30 fs/btrfs/extent-tree.c:1689
 run_one_delayed_ref fs/btrfs/extent-tree.c:1713 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xf48/0x2c10 fs/btrfs/extent-tree.c:2038
 btrfs_run_delayed_refs+0x2d6/0x920 fs/btrfs/extent-tree.c:2169
 commit_cowonly_roots+0x2ff/0x1620 fs/btrfs/transaction.c:1233
 btrfs_commit_transaction+0x204c/0x55b0 fs/btrfs/transaction.c:2275
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4076
 close_ctree+0x473/0xef7 fs/btrfs/disk-io.c:4140
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:326
 generic_shutdown_super+0x2ab/0x650 fs/super.c:464
 kill_anon_super+0x63/0xb0 fs/super.c:1055
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2347
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x7a0/0x870 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x140/0x280 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x12d/0x160 arch/x86/entry/common.c:79
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:166
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:209
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f13549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffe0580c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffe058b0 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080e9e3a
RBP: 00000000ffe058b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
 __msan_

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
