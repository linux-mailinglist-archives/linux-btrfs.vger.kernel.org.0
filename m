Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17236271A76
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 07:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgIUFiR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 01:38:17 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:38660 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgIUFiQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 01:38:16 -0400
Received: by mail-io1-f71.google.com with SMTP id e21so9256115iod.5
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Sep 2020 22:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mldZOPzd4FXHs/LrrnoJ/fME9Gz63dOekIh0/A0poAI=;
        b=Y3eneALh4nb+oIsG6fl5gFvHGnWoLmhbIrxgMUWXwahDUT5CTsc1SA6gHwDMBxx33M
         ZxrRSjd7Szk6SlOpN49Ehbrsvse6BKb/FXXX9O7Vpgl3McvF5xEcaLFWrW3yEk70pmAa
         bpC1iFXXMQoADRIzGpKwSzyCejA9XwP8lHmS6vmXydck4991nFr7lu56mS9V3xzaDGxo
         hmcFTx4+rN1+8/1cfhRvwYi8NVh2RmSo+f4ixOq6E8hztl/bLNwCxq4u9llybOo3uOEN
         EP6dtxrHo/Y93aAdCMeeCbEiGUYjVj9LsqbHXXuf6aCwOQPbbpzYoPYt6Z2DwQ8reqN9
         aUfQ==
X-Gm-Message-State: AOAM531L8T8U6jd4wgCcPdnJUy5gCuk5QxF5FxbEQ9A7Y1rAGfwIpZOg
        aYOVNGYQXVC5HbVUrTutwCfQDJK06wX1m0ACsZ674wO8VhOL
X-Google-Smtp-Source: ABdhPJxpDNuIFZPkvsdO/G+D9xuSKBngFXdQuVE1BnvCpERn5xIRGkPfhMcl45ZYWl8KGFH9x9q9nSPthg7VWHfZ/qGo9ErOH+vK
MIME-Version: 1.0
X-Received: by 2002:a6b:be44:: with SMTP id o65mr26709302iof.53.1600666695489;
 Sun, 20 Sep 2020 22:38:15 -0700 (PDT)
Date:   Sun, 20 Sep 2020 22:38:15 -0700
In-Reply-To: <0000000000001fe79005afbf52ea@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c9e14b05afcc41ba@google.com>
Subject: Re: KASAN: use-after-free Read in btrfs_scan_one_device
From:   syzbot <syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    325d0eab Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1512df53900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a8a2ae52ed737db
dashboard link: https://syzkaller.appspot.com/bug?extid=582e66e5edf36a22c7b0
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12366f8b900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e6929b900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in btrfs_printk+0x3eb/0x435 fs/btrfs/super.c:245
Read of size 8 at addr ffff8880878e06a8 by task syz-executor225/7068

CPU: 1 PID: 7068 Comm: syz-executor225 Not tainted 5.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1d6/0x29e lib/dump_stack.c:118
 print_address_description+0x66/0x620 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report+0x132/0x1d0 mm/kasan/report.c:530
 btrfs_printk+0x3eb/0x435 fs/btrfs/super.c:245
 device_list_add+0x1a88/0x1d60 fs/btrfs/volumes.c:943
 btrfs_scan_one_device+0x196/0x490 fs/btrfs/volumes.c:1359
 btrfs_mount_root+0x48f/0xb60 fs/btrfs/super.c:1634
 legacy_get_tree+0xea/0x180 fs/fs_context.c:592
 vfs_get_tree+0x88/0x270 fs/super.c:1547
 fc_mount fs/namespace.c:978 [inline]
 vfs_kern_mount+0xc9/0x160 fs/namespace.c:1008
 btrfs_mount+0x33c/0xae0 fs/btrfs/super.c:1732
 legacy_get_tree+0xea/0x180 fs/fs_context.c:592
 vfs_get_tree+0x88/0x270 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x179d/0x29e0 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount+0x126/0x180 fs/namespace.c:3390
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44840a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 cd a2 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 aa a2 fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007ffedfffd608 EFLAGS: 00000293 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffedfffd670 RCX: 000000000044840a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffedfffd630
RBP: 00007ffedfffd630 R08: 00007ffedfffd670 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 000000000000001a
R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003

Allocated by task 6945:
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc+0x100/0x130 mm/kasan/common.c:461
 kmalloc_node include/linux/slab.h:577 [inline]
 kvmalloc_node+0x81/0x110 mm/util.c:574
 kvmalloc include/linux/mm.h:757 [inline]
 kvzalloc include/linux/mm.h:765 [inline]
 btrfs_mount_root+0xd0/0xb60 fs/btrfs/super.c:1613
 legacy_get_tree+0xea/0x180 fs/fs_context.c:592
 vfs_get_tree+0x88/0x270 fs/super.c:1547
 fc_mount fs/namespace.c:978 [inline]
 vfs_kern_mount+0xc9/0x160 fs/namespace.c:1008
 btrfs_mount+0x33c/0xae0 fs/btrfs/super.c:1732
 legacy_get_tree+0xea/0x180 fs/fs_context.c:592
 vfs_get_tree+0x88/0x270 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x179d/0x29e0 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount+0x126/0x180 fs/namespace.c:3390
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 6945:
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_set_track+0x3d/0x70 mm/kasan/common.c:56
 kasan_set_free_info+0x17/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xdd/0x110 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kfree+0x113/0x200 mm/slab.c:3756
 deactivate_locked_super+0xa7/0xf0 fs/super.c:335
 btrfs_mount_root+0x72b/0xb60 fs/btrfs/super.c:1678
 legacy_get_tree+0xea/0x180 fs/fs_context.c:592
 vfs_get_tree+0x88/0x270 fs/super.c:1547
 fc_mount fs/namespace.c:978 [inline]
 vfs_kern_mount+0xc9/0x160 fs/namespace.c:1008
 btrfs_mount+0x33c/0xae0 fs/btrfs/super.c:1732
 legacy_get_tree+0xea/0x180 fs/fs_context.c:592
 vfs_get_tree+0x88/0x270 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x179d/0x29e0 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount+0x126/0x180 fs/namespace.c:3390
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff8880878e0000
 which belongs to the cache kmalloc-16k of size 16384
The buggy address is located 1704 bytes inside of
 16384-byte region [ffff8880878e0000, ffff8880878e4000)
The buggy address belongs to the page:
page:0000000060704f30 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x878e0
head:0000000060704f30 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfffe0000010200(slab|head)
raw: 00fffe0000010200 ffffea00028e9a08 ffffea00021e3608 ffff8880aa440b00
raw: 0000000000000000 ffff8880878e0000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880878e0580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880878e0600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880878e0680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff8880878e0700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880878e0780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

