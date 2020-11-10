Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E342ADED7
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Nov 2020 19:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbgKJSzT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Nov 2020 13:55:19 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:46677 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbgKJSzT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Nov 2020 13:55:19 -0500
Received: by mail-io1-f70.google.com with SMTP id a2so9103011iod.13
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Nov 2020 10:55:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UBBVE26iMIwjToKruwBtc4rwDCIqTbom0jdq+SEqTcQ=;
        b=ZLobO0d1uRo1pSOH1QDGb1y7R19Q3lx6UbNf4tDHyyGSXMJELcc4KDcqowa0LW4hKY
         BUm4vUrBY+SF8TTjwegiqEZfKGSiYiEpVYO+yFT0BEk2LAPE5QOIw2pMBTTBjDEeb1yu
         Ehz3iinYHf/wX/x4l3UbsA2MH60R7TOdjEGmFy984di15NaxEoXVe8HCDwO2ngpewdue
         exMXhFhGzLKVowiWukL0WZm2I/d07db60cGlMtMQnZR9TYPA2aCbbnnEaybksepGQNGM
         3/jLbws1v0pq0/gXWY8OKi7JgoZwxYXDzqRuQps75W8oR0+eyZj90CNIJPfZGmnDch3y
         8mLA==
X-Gm-Message-State: AOAM533AACI2VkMR0PLIwRZVoYY5DK/+J98rNxarTbVo1EWGbtgas2M4
        4UMQtYqktTCtr6pIF3eV87TrjEPMPDObOixasin3s61+UGBh
X-Google-Smtp-Source: ABdhPJx2yvRathBvneil1m9OlLm3IiET5QFJeZrZz196892H5xm1bMGH/MwY7oueVpKu8iIjoWIAv5qByTCTXftdXAL+MrzLRyYt
MIME-Version: 1.0
X-Received: by 2002:a02:6948:: with SMTP id e69mr16775986jac.6.1605034518502;
 Tue, 10 Nov 2020 10:55:18 -0800 (PST)
Date:   Tue, 10 Nov 2020 10:55:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053e36405b3c538fc@google.com>
Subject: KASAN: null-ptr-deref Write in start_transaction
From:   syzbot <syzbot+6700bca07dff187809c4@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    521b619a Merge tag 'linux-kselftest-kunit-fixes-5.10-rc3' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=173b8fb6500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61033507391c77ff
dashboard link: https://syzkaller.appspot.com/bug?extid=6700bca07dff187809c4
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a07ab2500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10fe69c6500000

The issue was bisected to:

commit 4d004099a668c41522242aa146a38cc4eb59cb1e
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Fri Oct 2 09:04:21 2020 +0000

    lockdep: Fix lockdep recursion

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=100c0532500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=120c0532500000
console output: https://syzkaller.appspot.com/x/log.txt?x=140c0532500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6700bca07dff187809c4@syzkaller.appspotmail.com
Fixes: 4d004099a668 ("lockdep: Fix lockdep recursion")

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
BUG: KASAN: null-ptr-deref in atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:142 [inline]
BUG: KASAN: null-ptr-deref in __refcount_add include/linux/refcount.h:193 [inline]
BUG: KASAN: null-ptr-deref in __refcount_inc include/linux/refcount.h:250 [inline]
BUG: KASAN: null-ptr-deref in refcount_inc include/linux/refcount.h:267 [inline]
BUG: KASAN: null-ptr-deref in start_transaction+0x158/0x1170 fs/btrfs/transaction.c:541
Write of size 4 at addr 000000000000003a by task syz-executor154/8513

CPU: 1 PID: 8513 Comm: syz-executor154 Not tainted 5.10.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 __kasan_report mm/kasan/report.c:549 [inline]
 kasan_report.cold+0x5/0x37 mm/kasan/report.c:562
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:142 [inline]
 __refcount_add include/linux/refcount.h:193 [inline]
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 start_transaction+0x158/0x1170 fs/btrfs/transaction.c:541
 flush_space+0x1c0/0xf60 fs/btrfs/space-info.c:685
 priority_reclaim_metadata_space fs/btrfs/space-info.c:1154 [inline]
 handle_reserve_ticket fs/btrfs/space-info.c:1238 [inline]
 __reserve_bytes+0xd2c/0x1480 fs/btrfs/space-info.c:1403
 btrfs_reserve_metadata_bytes+0x75/0x260 fs/btrfs/space-info.c:1429
 btrfs_delalloc_reserve_metadata+0x261/0xb90 fs/btrfs/delalloc-space.c:332
 btrfs_buffered_write.isra.0+0x445/0xf10 fs/btrfs/file.c:1703
 __btrfs_direct_write fs/btrfs/file.c:1874 [inline]
 btrfs_file_write_iter+0xda6/0x16d0 fs/btrfs/file.c:2046
 call_write_iter include/linux/fs.h:1887 [inline]
 do_iter_readv_writev+0x46f/0x740 fs/read_write.c:740
 do_iter_write+0x188/0x670 fs/read_write.c:866
 vfs_writev+0x1aa/0x2e0 fs/read_write.c:939
 do_pwritev fs/read_write.c:1036 [inline]
 __do_sys_pwritev fs/read_write.c:1083 [inline]
 __se_sys_pwritev fs/read_write.c:1078 [inline]
 __x64_sys_pwritev+0x231/0x310 fs/read_write.c:1078
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44d959
Code: 7d cb fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 4b cb fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f78b0d8bce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000128
RAX: ffffffffffffffda RBX: 00000000006e1c28 RCX: 000000000044d959
RDX: 0000000000000001 RSI: 00000000200014c0 RDI: 0000000000000003
RBP: 00000000006e1c20 R08: 0000000000000020 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 00000000006e1c2c
R13: 00007ffefe638f4f R14: 00007f78b0d8c9c0 R15: 20c49ba5e353f7cf
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
