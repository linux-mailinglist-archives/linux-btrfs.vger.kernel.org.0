Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6132714DD
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Sep 2020 16:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgITOMQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Sep 2020 10:12:16 -0400
Received: from mail-il1-f207.google.com ([209.85.166.207]:51709 "EHLO
        mail-il1-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgITOMQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Sep 2020 10:12:16 -0400
Received: by mail-il1-f207.google.com with SMTP id i80so8858771ild.18
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Sep 2020 07:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Qvrl1OY6JWgcCCiAihQHsiSzx2LkWVCbic+Pwh/YJR0=;
        b=jufCOOwq3adEVA7KX/aakBrwJaFTqG9RTBK2RBTFiDgduH62t14xEhxyF0BT0ngawx
         b8eUeznm7CsRmgIHWyuVvMonuIGyrKfksxg4Ixt3qGZGqRZY8bunfaGuZbuVp61CkuXl
         xMbMIbclV83P8HsQe+r2JaozX9oCwrWaYKrQxnByqJolRIMv0uy6AD6US1GMU9IM6Zaf
         yJKO7iaLbjZVaITzp81FydtauDb29Jbpr4mMpy2VHuOP80TUYsX+Jv/3aTjOnw1WVaIl
         ztgB91SEihYAYE7vS+VHE+R2QmqjwqmnqEUWCaIvDWt4xxZgHMTv1KkAtmpkb1b7Tp5G
         jT4Q==
X-Gm-Message-State: AOAM5331V2wdLaFDPmggLPMXB4UJ+szAq/qH32zyCaX9zBBgZFR90Nc1
        3o0SaW1w+y1ruFB7frJyBZftgi8xmgpWciE7n7vK0JaSe/Oe
X-Google-Smtp-Source: ABdhPJxyy0CfEsBkWTJ31KU+gh1V+8mrn09UVYc3pTuWHTKEZ3gbWhn6swYFUSrykOLLIf1TbFExBzyt2FFG2wdjLGqnFMMtjn35
MIME-Version: 1.0
X-Received: by 2002:a02:c72d:: with SMTP id h13mr37751287jao.17.1600611134988;
 Sun, 20 Sep 2020 07:12:14 -0700 (PDT)
Date:   Sun, 20 Sep 2020 07:12:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001fe79005afbf52ea@google.com>
Subject: KASAN: use-after-free Read in btrfs_scan_one_device
From:   syzbot <syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    eb5f95f1 Merge tag 's390-5.9-6' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a0a8bb900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ffe85b197a57c180
dashboard link: https://syzkaller.appspot.com/bug?extid=582e66e5edf36a22c7b0
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in btrfs_printk+0x38b/0x40c fs/btrfs/super.c:245
Read of size 8 at addr ffff8880637006a8 by task syz-executor.2/15287

CPU: 1 PID: 15287 Comm: syz-executor.2 Not tainted 5.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 btrfs_printk+0x38b/0x40c fs/btrfs/super.c:245
 device_list_add.cold+0x58/0x2d2 fs/btrfs/volumes.c:943
 btrfs_scan_one_device+0x339/0x4a0 fs/btrfs/volumes.c:1359
 btrfs_mount_root+0x4d5/0xbb0 fs/btrfs/super.c:1634
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 fc_mount fs/namespace.c:978 [inline]
 vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1008
 vfs_kern_mount+0x3c/0x60 fs/namespace.c:995
 btrfs_mount+0x234/0xaa0 fs/btrfs/super.c:1732
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x1387/0x20a0 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount fs/namespace.c:3390 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x46004a
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd 89 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da 89 fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007f50d2ce8a88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f50d2ce8b20 RCX: 000000000046004a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f50d2ce8ae0
RBP: 00007f50d2ce8ae0 R08: 00007f50d2ce8b20 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 0000000020001d40 R15: 0000000020000040

Allocated by task 15246:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 kmalloc_node include/linux/slab.h:577 [inline]
 kvmalloc_node+0xb4/0xf0 mm/util.c:574
 kvmalloc include/linux/mm.h:757 [inline]
 kvzalloc include/linux/mm.h:765 [inline]
 btrfs_mount_root+0x117/0xbb0 fs/btrfs/super.c:1613
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 fc_mount fs/namespace.c:978 [inline]
 vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1008
 vfs_kern_mount+0x3c/0x60 fs/namespace.c:995
 btrfs_mount+0x234/0xaa0 fs/btrfs/super.c:1732
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x1387/0x20a0 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount fs/namespace.c:3390 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 15246:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kfree+0x10e/0x2b0 mm/slab.c:3756
 kvfree+0x42/0x50 mm/util.c:603
 deactivate_locked_super+0x94/0x160 fs/super.c:335
 btrfs_mount_root+0x772/0xbb0 fs/btrfs/super.c:1678
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 fc_mount fs/namespace.c:978 [inline]
 vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1008
 vfs_kern_mount+0x3c/0x60 fs/namespace.c:995
 btrfs_mount+0x234/0xaa0 fs/btrfs/super.c:1732
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x1387/0x20a0 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount fs/namespace.c:3390 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff888063700000
 which belongs to the cache kmalloc-16k of size 16384
The buggy address is located 1704 bytes inside of
 16384-byte region [ffff888063700000, ffff888063704000)
The buggy address belongs to the page:
page:00000000e0472e19 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x63700
head:00000000e0472e19 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfffe0000010200(slab|head)
raw: 00fffe0000010200 ffffea00024a4c08 ffffea000150ce08 ffff8880aa040b00
raw: 0000000000000000 ffff888063700000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888063700580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888063700600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888063700680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff888063700700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888063700780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
