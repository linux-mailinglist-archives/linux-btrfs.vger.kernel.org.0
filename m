Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C833A5C83
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Jun 2021 07:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhFNFnZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Jun 2021 01:43:25 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:50849 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbhFNFnX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Jun 2021 01:43:23 -0400
Received: by mail-io1-f70.google.com with SMTP id x4-20020a5eda040000b02904a91aa10037so22435162ioj.17
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Jun 2021 22:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vd0Pp4K+wO+0tLQcnUgsSoN9w68unbWA/SgwyIREfs8=;
        b=oYDJT/ZY391/7lmS2gX+Buxoegr+vferIPCq6u1kM6XDn84N4hQ61Z12Mjr1FZGO/l
         PXufFEBJcQ213B5bxgIpTEgQT/yqieyhUkhOgP1VWzGNnbkqxIqCGmyBYA9SPb825vws
         O5llYLtxH2odMB/z754rg7i43iEzi7PBTBirxVa+pLW3cia98R7sjIXg6sMzE3qdHGxX
         ftoV1+i71notXweWGg4cztPJCY9PwTtaTxSMKBO1OTa40U0ggi2LqSsIUS+8bJKM1DMv
         8U/dkakUu3a2fw5/X1u/toHdgi6rtTewY9aq9ujK3r4p/cNx/iEwblzbRGaZ5LPcqEUu
         g6sA==
X-Gm-Message-State: AOAM533XesR9Y2IQko+/QOpROMLwbbV/StmNZEdLNB4PXP+hr5yxH+Rk
        o+N/bP8JmT2K+x4xdqkbAGAIx8wWPPfN5f2O2VxnDeCejl3C
X-Google-Smtp-Source: ABdhPJyObjJaK0H9RklzzVVaIjvHLdGvAO1VhBpNnM4OVbtd8ogqfpPo4ucEnc/sJJxO3zdgfFelZ87Qs75/RqTfcA8IImttgYZu
MIME-Version: 1.0
X-Received: by 2002:a6b:8b51:: with SMTP id n78mr13164501iod.143.1623649280590;
 Sun, 13 Jun 2021 22:41:20 -0700 (PDT)
Date:   Sun, 13 Jun 2021 22:41:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c083105c4b34e70@google.com>
Subject: [syzbot] KMSAN: uninit-value in generic_bin_search (2)
From:   syzbot <syzbot+8aa9678d1cda7a0432b7@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, glider@google.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6099c9da x86: entry: speculatively unpoison pt_regs in do_..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12c7a057d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e6842a91012889c
dashboard link: https://syzkaller.appspot.com/bug?extid=8aa9678d1cda7a0432b7
compiler:       Debian clang version 11.0.1-2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8aa9678d1cda7a0432b7@syzkaller.appspotmail.com

 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
 __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
 do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in btrfs_comp_cpu_keys fs/btrfs/ctree.c:1556 [inline]
BUG: KMSAN: uninit-value in comp_keys fs/btrfs/ctree.c:1528 [inline]
BUG: KMSAN: uninit-value in generic_bin_search+0x799/0xbc0 fs/btrfs/ctree.c:1702
CPU: 1 PID: 9364 Comm: syz-executor.2 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 btrfs_comp_cpu_keys fs/btrfs/ctree.c:1556 [inline]
 comp_keys fs/btrfs/ctree.c:1528 [inline]
 generic_bin_search+0x799/0xbc0 fs/btrfs/ctree.c:1702
 btrfs_bin_search fs/btrfs/ctree.c:1724 [inline]
 btrfs_search_slot+0x2144/0x3f20 fs/btrfs/ctree.c:2724
 btrfs_insert_empty_items+0x5a7/0x790 fs/btrfs/ctree.c:4791
 btrfs_insert_empty_item fs/btrfs/ctree.h:2867 [inline]
 alloc_reserved_tree_block+0x403/0xef0 fs/btrfs/extent-tree.c:4618
 run_delayed_tree_ref+0x3ea/0xa30 fs/btrfs/extent-tree.c:1678
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
 do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7ff2549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000fff227dc EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000fff22880 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080ea118
RBP: 00000000fff22880 R08: 0000000000000000 R09: 0000000000000000
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
 btrfs_insert_empty_items+0x5a7/0x790 fs/btrfs/ctree.c:4791
 btrfs_insert_empty_item fs/btrfs/ctree.h:2867 [inline]
 alloc_reserved_tree_block+0x403/0xef0 fs/btrfs/extent-tree.c:4618
 run_delayed_tree_ref+0x3ea/0xa30 fs/btrfs/extent-tree.c:1678
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
 do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in leaf_space_used+0x3c0/0x3d0 fs/btrfs/ctree.c:3517
CPU: 1 PID: 9364 Comm: syz-executor.2 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 leaf_space_used+0x3c0/0x3d0 fs/btrfs/ctree.c:3517
 btrfs_leaf_free_space+0x16e/0x3d0 fs/btrfs/ctree.c:3532
 btrfs_search_slot+0x3841/0x3f20 fs/btrfs/ctree.c:2747
 btrfs_insert_empty_items+0x5a7/0x790 fs/btrfs/ctree.c:4791
 btrfs_insert_empty_item fs/btrfs/ctree.h:2867 [inline]
 alloc_reserved_tree_block+0x403/0xef0 fs/btrfs/extent-tree.c:4618
 run_delayed_tree_ref+0x3ea/0xa30 fs/btrfs/extent-tree.c:1678
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
 do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7ff2549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000fff227dc EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000fff22880 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080ea118
RBP: 00000000fff22880 R08: 0000000000000000 R09: 0000000000000000
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
 btrfs_insert_empty_items+0x5a7/0x790 fs/btrfs/ctree.c:4791
 btrfs_insert_empty_item fs/btrfs/ctree.h:2867 [inline]
 alloc_reserved_tree_block+0x403/0xef0 fs/btrfs/extent-tree.c:4618
 run_delayed_tree_ref+0x3ea/0xa30 fs/btrfs/extent-tree.c:1678
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
 do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in btrfs_leaf_free_space+0x246/0x3d0 fs/btrfs/ctree.c:3533
CPU: 1 PID: 9364 Comm: syz-executor.2 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 btrfs_leaf_free_space+0x246/0x3d0 fs/btrfs/ctree.c:3533
 btrfs_search_slot+0x3841/0x3f20 fs/btrfs/ctree.c:2747
 btrfs_insert_empty_items+0x5a7/0x790 fs/btrfs/ctree.c:4791
 btrfs_insert_empty_item fs/btrfs/ctree.h:2867 [inline]
 alloc_reserved_tree_block+0x403/0xef0 fs/btrfs/extent-tree.c:4618
 run_delayed_tree_ref+0x3ea/0xa30 fs/btrfs/extent-tree.c:1678
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
 do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7ff2549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000fff227dc EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000fff22880 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080ea118
RBP: 00000000fff22880 R08: 0000000000000000 R09: 0000000000000000
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
 btrfs_insert_empty_items+0x5a7/0x790 fs/btrfs/ctree.c:4791
 btrfs_insert_empty_item fs/btrfs/ctree.h:2867 [inline]
 alloc_reserved_tree_block+0x403/0xef0 fs/btrfs/extent-tree.c:4618
 run_delayed_tree_ref+0x3ea/0xa30 fs/btrfs/extent-tree.c:1678
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
 do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in btrfs_search_slot+0x394f/0x3f20 fs/btrfs/ctree.c:2746
CPU: 1 PID: 9364 Comm: syz-executor.2 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 btrfs_search_slot+0x394f/0x3f20 fs/btrfs/ctree.c:2746
 btrfs_insert_empty_items+0x5a7/0x790 fs/btrfs/ctree.c:4791
 btrfs_insert_empty_item fs/btrfs/ctree.h:2867 [inline]
 alloc_reserved_tree_block+0x403/0xef0 fs/btrfs/extent-tree.c:4618
 run_delayed_tree_ref+0x3ea/0xa30 fs/btrfs/extent-tree.c:1678
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
 do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7ff2549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000fff227dc EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000fff22880 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080ea118
RBP: 00000000fff22880 R08: 0000000000000000 R09: 0000000000000000
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
 btrfs_insert_empty_items+0x5a7/0x790 fs/btrfs/ctree.c:4791
 btrfs_insert_empty_item fs/btrfs/ctree.h:2867 [inline]
 alloc_reserved_tree_block+0x403/0xef0 fs/btrfs/extent-tree.c:4618
 run_delayed_tree_ref+0x3ea/0xa30 fs/btrfs/extent-tree.c:1678
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
 do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in leaf_space_used+0x3c0/0x3d0 fs/btrfs/ctree.c:3517
CPU: 1 PID: 9364 Comm: syz-executor.2 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 leaf_space_used+0x3c0/0x3d0 fs/btrfs/ctree.c:3517
 btrfs_leaf_free_space+0x16e/0x3d0 fs/btrfs/ctree.c:3532
 setup_items_for_insert+0xc47/0x1a00 fs/btrfs/ctree.c:4710
 btrfs_insert_empty_items+0x6f9/0x790 fs/btrfs/ctree.c:4800
 btrfs_insert_empty_item fs/btrfs/ctree.h:2867 [inline]
 alloc_reserved_tree_block+0x403/0xef0 fs/btrfs/extent-tree.c:4618
 run_delayed_tree_ref+0x3ea/0xa30 fs/btrfs/extent-tree.c:1678
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
 do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7ff2549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000fff227dc EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000fff22880 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080ea118
RBP: 00000000fff22880 R08: 0000000000000000 R09: 0000000000000000
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
 btrfs_insert_empty_items+0x5a7/0x790 fs/btrfs/ctree.c:4791
 btrfs_insert_empty_item fs/btrfs/ctree.h:2867 [inline]
 alloc_reserved_tree_block+0x403/0xef0 fs/btrfs/extent-tree.c:4618
 run_delayed_tree_ref+0x3ea/0xa30 fs/btrfs/extent-tree.c:1678
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
 do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in btrfs_leaf_free_space+0x246/0x3d0 fs/btrfs/ctree.c:3533
CPU: 1 PID: 9364 Comm: syz-executor.2 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 btrfs_leaf_free_space+0x246/0x3d0 fs/btrfs/ctree.c:3533
 setup_items_for_insert+0xc47/0x1a00 fs/btrfs/ctree.c:4710
 btrfs_insert_empty_items+0x6f9/0x790 fs/btrfs/ctree.c:4800
 btrfs_insert_empty_item fs/btrfs/ctree.h:2867 [inline]
 alloc_reserved_tree_block+0x403/0xef0 fs/btrfs/extent-tree.c:4618
 run_delayed_tree_ref+0x3ea/0xa30 fs/btrfs/extent-tree.c:1678
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
 do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7ff2549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000fff227dc EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000fff22880 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080ea118
RBP: 00000000fff22880 R08: 0000000000000000 R09: 0000000000000000
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
 btrfs_insert_empty_items+0x5a7/0x790 fs/btrfs/ctree.c:4791
 btrfs_insert_empty_item fs/btrfs/ctree.h:2867 [inline]
 alloc_reserved_tree_block+0x403/0xef0 fs/btrfs/extent-tree.c:4618
 run_delayed_tree_ref+0x3ea/0xa30 fs/btrfs/extent-tree.c:1678
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
 do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in setup_items_for_insert+0x15a8/0x1a00 fs/btrfs/ctree.c:4710
CPU: 1 PID: 9364 Comm: syz-executor.2 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 setup_items_for_insert+0x15a8/0x1a00 fs/btrfs/ctree.c:4710
 btrfs_insert_empty_items+0x6f9/0x790 fs/btrfs/ctree.c:4800
 btrfs_insert_empty_item fs/btrfs/ctree.h:2867 [inline]
 alloc_reserved_tree_block+0x403/0xef0 fs/btrfs/extent-tree.c:4618
 run_delayed_tree_ref+0x3ea/0xa30 fs/btrfs/extent-tree.c:1678
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
 do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7ff2549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000fff227dc EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000fff22880 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080ea118
RBP: 00000000fff22880 R08: 0000000000000000 R09: 0000000000000000
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
 btrfs_insert_empty_items+0x5a7/0x790 fs/btrfs/ctree.c:4791
 btrfs_insert_empty_item fs/btrfs/ctree.h:2867 [inline]
 alloc_reserved_tree_block+0x403/0xef0 fs/btrfs/extent-tree.c:4618
 run_delayed_tree_ref+0x3ea/0xa30 fs/btrfs/extent-tree.c:1678
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
 do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in setup_items_for_insert+0x18eb/0x1a00 fs/btrfs/ctree.c:4721
CPU: 1 PID: 9364 Comm: syz-executor.2 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 setup_items_for_insert+0x18eb/0x1a00 fs/btrfs/ctree.c:4721
 btrfs_insert_empty_items+0x6f9/0x790 fs/btrfs/ctree.c:4800
 btrfs_insert_empty_item fs/btrfs/ctree.h:2867 [inline]
 alloc_reserved_tree_block+0x403/0xef0 fs/btrfs/extent-tree.c:4618
 run_delayed_tree_ref+0x3ea/0xa30 fs/btrfs/extent-tree.c:1678
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
 do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7ff2549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000fff227dc EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000fff22880 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080ea118
RBP: 00000000fff22880 R08: 0000000000000000 R09: 0000000000000000
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
 btrfs_insert_empty_items+0x5a7/0x790 fs/btrfs/ctree.c:4791
 btrfs_insert_empty_item fs/btrfs/ctree.h:2867 [inline]
 alloc_reserved_tree_block+0x403/0xef0 fs/btrfs/extent-tree.c:4618
 run_delayed_tree_ref+0x3ea/0xa30 fs/btrfs/extent-tree.c:1678
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
 do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in check_eb_range fs/btrfs/extent_io.c:6115 [inline]
BUG: KMSAN: uninit-value in memmove_extent_buffer+0x996/0xd30 fs/btrfs/extent_io.c:6573
CPU: 1 PID: 9364 Comm: syz-executor.2 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 check_eb_range fs/btrfs/extent_io.c:6115 [inline]
 memmove_extent_buffer+0x996/0xd30 fs/btrfs/extent_io.c:6573
 setup_items_for_insert+0x1258/0x1a00 fs/btrfs/ctree.c:4746
 btrfs_insert_empty_items+0x6f9/0x790 fs/btrfs/ctree.c:4800
 btrfs_insert_empty_item fs/btrfs/ctree.h:2867 [inline]
 alloc_reserved_tree_block+0x403/0xef0 fs/btrfs/extent-tree.c:4618
 run_delayed_tree_ref+0x3ea/0xa30 fs/btrfs/extent-tree.c:1678
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
 do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7ff2549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000fff227dc EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000fff22880 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080ea118
RBP: 00000000fff22880 R08: 0000000000000000 R09: 0000000000000000
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
 btrfs_insert_empty_items+0x5a7/0x790 fs/btrfs/ctree.c:4791
 btrfs_insert_empty_item fs/btrfs/ctree.h:2867 [inline]
 alloc_reserved_tree_block+0x403/0xef0 fs/btrfs/extent-tree.c:4618
 run_delayed_tree_ref+0x3ea/0xa30 fs/btrfs/extent-tree.c:1678
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
 do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in check_eb_range fs/btrfs/extent_io.c:6115 [inline]
BUG: KMSAN: uninit-value in memmove_extent_buffer+0x9a2/0xd30 fs/btrfs/extent_io.c:6573
CPU: 1 PID: 9364 Comm: syz-executor.2 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 check_eb_range fs/btrfs/extent_io.c:6115 [inline]
 memmove_extent_buffer+0x9a2/0xd30 fs/btrfs/extent_io.c:6573
 setup_items_for_insert+0x1258/0x1a00 fs/btrfs/ctree.c:4746
 btrfs_insert_empty_items+0x6f9/0x790 fs/btrfs/ctree.c:4800
 btrfs_insert_empty_item fs/btrfs/ctree.h:2867 [inline]
 alloc_reserved_tree_block+0x403/0xef0 fs/btrfs/extent-tree.c:4618
 run_delayed_tree_ref+0x3ea/0xa30 fs/btrfs/extent-tree.c:1678
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
 do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7ff2549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000fff227dc EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000fff22880 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080ea118
RBP: 00000000fff22880 R08: 0000000000000000 R09: 0000000000000000
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
 btrfs_insert_empty_items+0x5a7/0x790 fs/btrfs/ctree.c:4791
 btrfs_insert_empty_item fs/btrfs/ctree.h:2867 [inline]
 alloc_reserved_tree_block+0x403/0xef0 fs/btrfs/extent-tree.c:4618
 run_delayed_tree_ref+0x3ea/0xa30 fs/btrfs/extent-tree.c:1678
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
 do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in check_eb_range fs/btrfs/extent_io.c:6115 [inline]
BUG: KMSAN: uninit-value in memmove_extent_buffer+0x9ca/0xd30 fs/btrfs/extent_io.c:6574
CPU: 1 PID: 9364 Comm: syz-executor.2 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 check_eb_range fs/btrfs/extent_io.c:6115 [inline]
 memmove_extent_buffer+0x9ca/0xd30 fs/btrfs/extent_io.c:6574
 setup_items_for_insert+0x1258/0x1a00 fs/btrfs/ctree.c:4746
 btrfs_insert_empty_items+0x6f9/0x790 fs/btrfs/ctree.c:4800
 btrfs_insert_empty_item fs/btrfs/ctree.h:2867 [inline]
 alloc_reserved_tree_block+0x403/0xef0 fs/btrfs/extent-tree.c:4618
 run_delayed_tree_ref+0x3ea/0xa30 fs/btrfs/extent-tree.c:1678
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
 do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7ff2549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000fff227dc EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000fff22880 RCX: 0000000000000002
RDX: 000000000816c000 RSI: 0000000000000000 RDI: 00000000080ea118
RBP: 00000000fff22880 R08: 0000000000000000 R09: 0000000000000000
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
 btrfs_insert_empty_items+0x5a7/0x790 fs/btrfs/ctree.c:4791
 btrfs_insert_empty_item fs/btrfs/ctree.h:2867 [inline]
 alloc_reserved_tree_block+0x403/0xef0 fs/btrfs/extent-tree.c:4618
 run_delayed_tree_ref+0x3ea/0xa30 fs/btrfs/extent-tree.c:1678
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
 do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in check_eb_range fs/btrfs/extent_io.c:6115 [inline]
BUG: KMSAN: uninit-value in memmove_extent_buffer+0x9db/0xd30 fs/btrfs/extent_io.c:6574
CPU: 1 PID: 9364 Comm: syz-executor.2 Tainted: G    B             5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
 check_eb_range fs/btrfs/extent_io.c:6115 [inline]
 memmove_extent_buffer+0x9db/0xd30 fs/btrfs/extent_io.c:6574
 setup_items_for_insert+0x1258/0x1a00 fs/btrfs/ctree.c:4746
 btrfs_insert_empty_items+0x6f9/0x790 fs/btrfs/ctree.c:4800
 btrfs_insert_empty_item fs/btrfs/ctree.h:2867 [inline]
 alloc_reserved_tree_block+0x403/0xef0 fs/btrfs/extent-tree.c:4618
 run_delayed_tree_ref+0x3ea/0xa30 fs/btrfs/extent-tree.c:1678
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
 exit_to_user_mode_prepar

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
