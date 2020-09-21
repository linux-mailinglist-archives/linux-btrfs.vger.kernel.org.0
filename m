Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922F8271F8D
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 12:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgIUKCc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 06:02:32 -0400
Received: from mail-il1-f206.google.com ([209.85.166.206]:54439 "EHLO
        mail-il1-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgIUKCX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 06:02:23 -0400
Received: by mail-il1-f206.google.com with SMTP id p13so10324296ill.21
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 03:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/l/NOq+7TKn1G7pMBPtjRXGm7OYqGvdY0rRGoArh5Q0=;
        b=rquM8r1Cvlw1XzsqtX26kWLS7D5UiX14PvZEikcZh5GxXR7K8wlrshE5u97vHjdZFf
         vsY8ffq4GC/A9P3lW+uFm9OGZJPtH9I4+Qew/YDD6ZaNIylFJr4JwBQYOwG0KMsFzKWf
         +YuT1LfTsMTthvtth5GgOIps+O+thBdWBBQ6muyjcMK0cZMjTrIlzXREv8nYoHEX/ASG
         28hcqnwE1if7JEIcaHddvnbO+8xwysOw+56+BbMpUcxRtK599aXm39no9SoQn/yZd65T
         Rwjgw0jFvvIM+5UEPW100oaNpM3Er6x1JNW7wit6QbYXj4xVOMLavWKenBiu+GW/F4Tk
         Fh+Q==
X-Gm-Message-State: AOAM530VGw0Ijhyz+jGC9WOpm2+I3OSnGg8gMeBMpV/Pxm9GbUZVJlHK
        w7v+PxTgoPyJA2g5GrP4zZIU20VS37FgNbdnue5u2AglCQ+S
X-Google-Smtp-Source: ABdhPJxnfnd5KF7MPBX4xt42GdnjVrdVomMVDd/Vxi/1JQH/nA1VuJNguTtjkLn6mPPo/Q3iorAkryXHcD+XOKXE/WARzaKWYtb9
MIME-Version: 1.0
X-Received: by 2002:a02:4b07:: with SMTP id q7mr40969729jaa.84.1600682542595;
 Mon, 21 Sep 2020 03:02:22 -0700 (PDT)
Date:   Mon, 21 Sep 2020 03:02:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059837b05afcff275@google.com>
Subject: WARNING in btrfs_alloc_chunk
From:   syzbot <syzbot+f54bbed7adc7c7729120@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    325d0eab Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142c89ab900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d39f8ae68f9dcd5
dashboard link: https://syzkaller.appspot.com/bug?extid=f54bbed7adc7c7729120
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f54bbed7adc7c7729120@syzkaller.appspotmail.com

------------[ cut here ]------------
gather_device_info: found more than 0 devices
WARNING: CPU: 1 PID: 26278 at fs/btrfs/volumes.c:4967 gather_device_info fs/btrfs/volumes.c:4967 [inline]
WARNING: CPU: 1 PID: 26278 at fs/btrfs/volumes.c:4967 btrfs_alloc_chunk+0x1a43/0x2000 fs/btrfs/volumes.c:5194
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 26278 Comm: syz-executor.2 Not tainted 5.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 panic+0x382/0x7fb kernel/panic.c:231
 __warn.cold+0x20/0x4b kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:gather_device_info fs/btrfs/volumes.c:4967 [inline]
RIP: 0010:btrfs_alloc_chunk+0x1a43/0x2000 fs/btrfs/volumes.c:5194
Code: ff ff 44 8b 7c 24 78 4c 89 0c 24 e8 17 06 67 fe 4c 8b 0c 24 48 c7 c6 c0 79 a6 88 48 c7 c7 40 67 a6 88 4c 89 ca e8 ff 41 37 fe <0f> 0b 4c 8b 0c 24 e9 f8 f0 ff ff 44 8b 7c 24 78 e8 e8 05 67 fe 31
RSP: 0018:ffffc900049072a8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88809cbee000 RCX: 0000000000000000
RDX: ffff8880645462c0 RSI: ffffffff815f5a85 RDI: fffff52000920e47
RBP: dffffc0000000000 R08: 0000000000000001 R09: ffff8880ae7318e7
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000002800000 R14: 0000000000010000 R15: 0000000000000001
 btrfs_chunk_alloc+0x3fe/0xaa0 fs/btrfs/block-group.c:3136
 find_free_extent_update_loop fs/btrfs/extent-tree.c:3796 [inline]
 find_free_extent+0x2090/0x2e60 fs/btrfs/extent-tree.c:4127
 btrfs_reserve_extent+0x166/0x460 fs/btrfs/extent-tree.c:4206
 btrfs_alloc_tree_block+0x203/0xee0 fs/btrfs/extent-tree.c:4603
 alloc_tree_block_no_bg_flush+0x1b6/0x250 fs/btrfs/ctree.c:987
 __btrfs_cow_block+0x3e0/0x10c0 fs/btrfs/ctree.c:1042
 btrfs_cow_block+0x2c1/0x8a0 fs/btrfs/ctree.c:1487
 commit_cowonly_roots+0x129/0xc70 fs/btrfs/transaction.c:1184
 btrfs_commit_transaction+0xde0/0x2830 fs/btrfs/transaction.c:2272
 btrfs_commit_super+0xc1/0x100 fs/btrfs/disk-io.c:4021
 close_ctree+0x2cd/0x6cb fs/btrfs/disk-io.c:4084
 generic_shutdown_super+0x144/0x370 fs/super.c:464
 kill_anon_super+0x36/0x60 fs/super.c:1108
 btrfs_kill_super+0x38/0x50 fs/btrfs/super.c:2265
 deactivate_locked_super+0x94/0x160 fs/super.c:335
 deactivate_super+0xad/0xd0 fs/super.c:366
 cleanup_mnt+0x3a3/0x530 fs/namespace.c:1118
 task_work_run+0xdd/0x190 kernel/task_work.c:141
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:163 [inline]
 exit_to_user_mode_prepare+0x1e1/0x200 kernel/entry/common.c:190
 syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:265
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x460027
Code: 64 89 04 25 d0 02 00 00 58 5f ff d0 48 89 c7 e8 2f be ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 fd 89 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd0b14c408 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000460027
RDX: 0000000000403188 RSI: 0000000000000002 RDI: 00007ffd0b14c4b0
RBP: 00000000000000ce R08: 0000000000000000 R09: 000000000000000a
R10: 0000000000000005 R11: 0000000000000246 R12: 00007ffd0b14d540
R13: 0000000002358a60 R14: 0000000000000000 R15: 00007ffd0b14d540
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
