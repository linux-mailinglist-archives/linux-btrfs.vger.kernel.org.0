Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF47270BBF
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Sep 2020 10:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgISIMQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Sep 2020 04:12:16 -0400
Received: from mail-il1-f208.google.com ([209.85.166.208]:45600 "EHLO
        mail-il1-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgISIMQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Sep 2020 04:12:16 -0400
Received: by mail-il1-f208.google.com with SMTP id m80so6613885ilb.12
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Sep 2020 01:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6HhLE0HT4Q+SqFsTd2grsdiwXmoqbVkPB3FBmd86n98=;
        b=nzU0FsEs6jem+4CsS9RXJU3H6mMj6VsqdhMf3g/cY3gHxzIcNsG5RsOJyUuDNGGnPt
         q5WLW+2ClRNzLPsQh4fQGPCgZ8BS4RjzzvY8qs7HhoIsAxUPVH1WXefYA5gtZB6SJquo
         024Dr8+CXEEQ35AZJZhm5iQ7o+bp8BcT5pESFQg5impI8C+DLV1t/JylhtIroOnWeoVj
         RjaD3epzSdl9TDF11jodHu2KpUXxExGwC31pkSxIAapKD071jyWG5HQq0FwDNCEGgA82
         tC2pzQsXHj7dqi7M1GJQnMcKZ9qiTr72YfvBKNDH+SrdtFmGXvc47D4n4qFHB6CAfani
         0G3Q==
X-Gm-Message-State: AOAM533arqEvMsssTtwIVfRk00Rj6s5SdMKHtt8+GSGLe3VYbXUjsu2x
        0Ekm03CqwoUPSkg3J1+57InkORLxJh4wNVwZ18Oo9h9rTjYF
X-Google-Smtp-Source: ABdhPJxiTw0xJg+Isg+E4HXVmoCdg7n6xrPKOmy+dKMxnVByjvrmj77RBPRXVtJdg2NGUv5CX3qAe68PHqLo7VhNWT2A+s5G3n1j
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:eb0:: with SMTP id u16mr29723757ilj.291.1600503135094;
 Sat, 19 Sep 2020 01:12:15 -0700 (PDT)
Date:   Sat, 19 Sep 2020 01:12:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4502f05afa62cf4@google.com>
Subject: KMSAN: uninit-value in btrfs_clean_tree_block
From:   syzbot <syzbot+37fb1c865f4d57cc1e7c@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, glider@google.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c5a13b33 kmsan: clang-format core
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1081d69b900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20f149ad694ba4be
dashboard link: https://syzkaller.appspot.com/bug?extid=37fb1c865f4d57cc1e7c
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+37fb1c865f4d57cc1e7c@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in btrfs_clean_tree_block+0x293/0x330 fs/btrfs/disk-io.c:1066
CPU: 0 PID: 10879 Comm: syz-executor.5 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:122
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:219
 btrfs_clean_tree_block+0x293/0x330 fs/btrfs/disk-io.c:1066
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4532 [inline]
 btrfs_alloc_tree_block+0x93d/0x1f40 fs/btrfs/extent-tree.c:4609
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:987 [inline]
 __btrfs_cow_block+0xaee/0x23f0 fs/btrfs/ctree.c:1042
 btrfs_cow_block+0xa15/0xce0 fs/btrfs/ctree.c:1487
 commit_cowonly_roots+0x1c0/0x1620 fs/btrfs/transaction.c:1184
 btrfs_commit_transaction+0x32ff/0x5630 fs/btrfs/transaction.c:2271
 btrfs_sync_fs+0x63c/0x6c0 fs/btrfs/super.c:1383
 __sync_filesystem fs/sync.c:39 [inline]
 sync_filesystem+0x2d4/0x440 fs/sync.c:67
 generic_shutdown_super+0xc7/0x650 fs/super.c:448
 kill_anon_super+0x6c/0xb0 fs/super.c:1108
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2265
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x796/0x880 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x1f2/0x2e0 kernel/task_work.c:141
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:163 [inline]
 exit_to_user_mode_prepare+0x434/0x540 kernel/entry/common.c:190
 syscall_exit_to_user_mode+0x35/0x50 kernel/entry/common.c:265
 __do_fast_syscall_32+0x151/0x180 arch/x86/entry/common.c:80
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:162
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:205
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f10549
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000ffa2f56c EFLAGS: 00000296 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffa2f5fc RCX: 0000000000000002
RDX: 000000000a24f228 RSI: 000000000a24f2b4 RDI: 00000000080d837e
RBP: 00000000ffa2f5fc R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:143
 kmsan_internal_alloc_meta_for_pages mm/kmsan/kmsan_shadow.c:268 [inline]
 kmsan_alloc_page+0xc5/0x1a0 mm/kmsan/kmsan_shadow.c:292
 __alloc_pages_nodemask+0xf34/0x1120 mm/page_alloc.c:4927
 alloc_pages_current+0x685/0xb50 mm/mempolicy.c:2275
 alloc_pages include/linux/gfp.h:545 [inline]
 __page_cache_alloc+0xc8/0x310 mm/filemap.c:957
 pagecache_get_page+0xe81/0x1cd0 mm/filemap.c:1710
 find_or_create_page include/linux/pagemap.h:348 [inline]
 alloc_extent_buffer+0x7c5/0x2820 fs/btrfs/extent_io.c:5246
 btrfs_find_create_tree_block+0x68/0x80 fs/btrfs/disk-io.c:1031
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4513 [inline]
 btrfs_alloc_tree_block+0x4f6/0x1f40 fs/btrfs/extent-tree.c:4609
 alloc_tree_block_no_bg_flush fs/btrfs/ctree.c:987 [inline]
 __btrfs_cow_block+0xaee/0x23f0 fs/btrfs/ctree.c:1042
 btrfs_cow_block+0xa15/0xce0 fs/btrfs/ctree.c:1487
 commit_cowonly_roots+0x1c0/0x1620 fs/btrfs/transaction.c:1184
 btrfs_commit_transaction+0x32ff/0x5630 fs/btrfs/transaction.c:2271
 btrfs_sync_fs+0x63c/0x6c0 fs/btrfs/super.c:1383
 __sync_filesystem fs/sync.c:39 [inline]
 sync_filesystem+0x2d4/0x440 fs/sync.c:67
 generic_shutdown_super+0xc7/0x650 fs/super.c:448
 kill_anon_super+0x6c/0xb0 fs/super.c:1108
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2265
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x1b7/0x1d0 fs/super.c:366
 cleanup_mnt+0x796/0x880 fs/namespace.c:1118
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1125
 task_work_run+0x1f2/0x2e0 kernel/task_work.c:141
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:163 [inline]
 exit_to_user_mode_prepare+0x434/0x540 kernel/entry/common.c:190
 syscall_exit_to_user_mode+0x35/0x50 kernel/entry/common.c:265
 __do_fast_syscall_32+0x151/0x180 arch/x86/entry/common.c:80
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:162
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:205
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
