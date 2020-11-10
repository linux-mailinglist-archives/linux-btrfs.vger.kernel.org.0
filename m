Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A322AD267
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Nov 2020 10:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbgKJJZ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Nov 2020 04:25:26 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:42800 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730014AbgKJJZZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Nov 2020 04:25:25 -0500
Received: by mail-il1-f197.google.com with SMTP id c8so8826309ilh.9
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Nov 2020 01:25:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=O01wwvCOe/D6G91p3Is0danZ+gRa4m6fi8sSZrmiAWk=;
        b=knPJnX6eBbYAAijj3aqYzH4UJysBy6TWPI9F9m+5+DmOiTEdxIuZFcfrg2NARityb9
         +YYaOHW75fehmkoZOGCiiJ/Wz3p75TDg2GNdG3ZkbZZ1rQQvO6nkuh79iKq06IArOGYO
         zNEdCW8lK2g4pP/J0P0K7RWc8AnWMVl1Rsd993h+dUDthgbaJor6QeevPyTwfdaGEmaH
         3N3tQ6lkHWqjHBbVrVt8mcJqfsidycv+rhJTkjDMlZa9yEqHInHjP+d45k1E/bwHZFkF
         dBmdnf6ZIkqZ0JhQ2HGbEpdCG4ZsEOMUzx+wE2el0JfZoKqC9PeA6AuFhOilcD5Uc5u2
         cyOA==
X-Gm-Message-State: AOAM533lkRC3hqJmdj6haz6FfVoMrK1YqtuQug9Am3oKy5m0+K+G18y0
        iDIcVJoRCi61kOrwr38QpYnAXbD6PjYnWVddt5FmekZQO4GE
X-Google-Smtp-Source: ABdhPJxcivXCI9OaxeD+bR6FfaZS+ue+8HHy9XGfJGiuk0oNbMXTHiUL8uWRDlyRiUgmj7mtccLIZQ6xk9tLiPlBCyKeKVoeCDuh
MIME-Version: 1.0
X-Received: by 2002:a02:3b57:: with SMTP id i23mr15287208jaf.110.1605000323849;
 Tue, 10 Nov 2020 01:25:23 -0800 (PST)
Date:   Tue, 10 Nov 2020 01:25:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ae6eb05b3bd420c@google.com>
Subject: KASAN: slab-out-of-bounds Read in btrfs_scan_one_device
From:   syzbot <syzbot+c4b1e5278d93269fd69c@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        jthumshirn@suse.de, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    521b619a Merge tag 'linux-kselftest-kunit-fixes-5.10-rc3' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a55792500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e791ddf0875adf65
dashboard link: https://syzkaller.appspot.com/bug?extid=c4b1e5278d93269fd69c
compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16296f5c500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1614e746500000

The issue was bisected to:

commit 3831bf0094abed51e71cbeca8b6edf8b88c2644b
Author: Johannes Thumshirn <jthumshirn@suse.de>
Date:   Mon Oct 7 09:11:02 2019 +0000

    btrfs: add sha256 to checksumming algorithm

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=163a3034500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=153a3034500000
console output: https://syzkaller.appspot.com/x/log.txt?x=113a3034500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c4b1e5278d93269fd69c@syzkaller.appspotmail.com
Fixes: 3831bf0094ab ("btrfs: add sha256 to checksumming algorithm")

==================================================================
BUG: KASAN: slab-out-of-bounds in btrfs_printk+0x421/0x46b fs/btrfs/super.c:245
Read of size 8 at addr ffff8880146246a0 by task systemd-udevd/8518

CPU: 0 PID: 8518 Comm: systemd-udevd Not tainted 5.10.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x137/0x1be lib/dump_stack.c:118
 print_address_description+0x6c/0x660 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report+0x136/0x1e0 mm/kasan/report.c:562
 btrfs_printk+0x421/0x46b fs/btrfs/super.c:245
 device_list_add+0x1a94/0x1d60 fs/btrfs/volumes.c:943
 btrfs_scan_one_device+0x2e1/0x460 fs/btrfs/volumes.c:1366
 btrfs_control_ioctl+0xd1/0x210 fs/btrfs/super.c:2327
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f7f94bc0017
Code: 00 00 00 48 8b 05 81 7e 2b 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 51 7e 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffc3c7245f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7f94bc0017
RDX: 00007ffc3c724610 RSI: 0000000090009427 RDI: 000000000000000f
RBP: 00007ffc3c724610 R08: 0000000000000000 R09: 0000000000000018
R10: 0000000000000001 R11: 0000000000000246 R12: 000000000000000f
R13: 0000000000000000 R14: 0000564c3b1752c0 R15: 0000564c3b162060

Allocated by task 8745:
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc+0x111/0x140 mm/kasan/common.c:461
 slab_post_alloc_hook+0x3e/0x2b0 mm/slab.h:526
 slab_alloc_node mm/slub.c:2891 [inline]
 kmem_cache_alloc_node+0x144/0x280 mm/slub.c:2927
 alloc_unbound_pwq+0x591/0x1060 kernel/workqueue.c:3801
 apply_wqattrs_prepare+0x3d2/0xcb0 kernel/workqueue.c:3946
 apply_workqueue_attrs_locked+0xcd/0x7b0 kernel/workqueue.c:4029
 apply_workqueue_attrs kernel/workqueue.c:4066 [inline]
 alloc_and_link_pwqs kernel/workqueue.c:4190 [inline]
 alloc_workqueue+0xe7e/0x1480 kernel/workqueue.c:4298
 __btrfs_alloc_workqueue+0x181/0x2d0 fs/btrfs/async-thread.c:108
 btrfs_alloc_workqueue+0x8c/0x1b0 fs/btrfs/async-thread.c:140
 btrfs_init_workqueues fs/btrfs/disk-io.c:2162 [inline]
 open_ctree+0x1243/0x3b3b fs/btrfs/disk-io.c:3088
 btrfs_fill_super fs/btrfs/super.c:1316 [inline]
 btrfs_mount_root+0x9b8/0xb60 fs/btrfs/super.c:1672
 legacy_get_tree+0xea/0x180 fs/fs_context.c:592
 vfs_get_tree+0x88/0x270 fs/super.c:1549
 fc_mount fs/namespace.c:978 [inline]
 vfs_kern_mount+0xc9/0x160 fs/namespace.c:1008
 btrfs_mount+0x345/0xa80 fs/btrfs/super.c:1732
 legacy_get_tree+0xea/0x180 fs/fs_context.c:592
 vfs_get_tree+0x88/0x270 fs/super.c:1549
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x17b4/0x2a20 fs/namespace.c:3205
 do_mount fs/namespace.c:3218 [inline]
 __do_sys_mount fs/namespace.c:3426 [inline]
 __se_sys_mount+0x28c/0x320 fs/namespace.c:3403
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff888014624400
 which belongs to the cache pool_workqueue of size 512
The buggy address is located 160 bytes to the right of
 512-byte region [ffff888014624400, ffff888014624600)
The buggy address belongs to the page:
page:000000006b59311c refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x14624
head:000000006b59311c order:2 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff88801044dc80
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888014624580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888014624600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888014624680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                               ^
 ffff888014624700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888014624780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
