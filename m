Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798CE271E63
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 10:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgIUIxT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 04:53:19 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:49363 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgIUIxR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 04:53:17 -0400
Received: by mail-il1-f199.google.com with SMTP id n1so10462509ilm.16
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 01:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=sIEFp5k+H22EAJPxvqeqBRHZBQUr7fvq4bhjMTd5BdU=;
        b=COp3SzCN25oHY+o2Viykm7/6sbK3TlasKxNhIrwO7crd7/taNwAHgwVNvO1j3YRjYO
         rTKVQU+Y/GNAjvY6pP++Hq5nApK8uaUzgvRV0+BcZCc88w/F+HklUFomPVLs01TVySV0
         hOjGFiykylKTw0qR86XVlD6ISFp95lHOhkLRZ0cFhxHN/dRbuAmHO7dDe1s84jMUsirj
         HdBHg3/j2dAtK9yZSUYzoZObUftA73LkiS4elhp8IqtK+p9xKeAMQfL0xtcxrOoB+VxB
         TzQ69ZUgoDtELtS0Tz05dTdvqkasdESkUDOYqqU00FKCwdgXHokcJXccTw2bjZiEthuZ
         3rhg==
X-Gm-Message-State: AOAM532VcEf1WNjFfV/IUJOaOp1zEQvy7KwORCIqz6GX3rEXEtJemM9+
        VdHA33or8oRfl4jlNBPU0QhCXFwv6rOpzZh4kTd0BwS9RF1q
X-Google-Smtp-Source: ABdhPJzwwnw62vEBh4K7ZyFq5xY1AaSH17Iu8LMOX1Ah2zQZlnLE6qnYDwK4bk8HZH62YNxHecheWZQ3f/L9/Sy6z64ru7mz5Uog
MIME-Version: 1.0
X-Received: by 2002:a5e:a613:: with SMTP id q19mr36319793ioi.36.1600678396518;
 Mon, 21 Sep 2020 01:53:16 -0700 (PDT)
Date:   Mon, 21 Sep 2020 01:53:16 -0700
In-Reply-To: <SN4PR0401MB3598EE548546274CFDD618AA9B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003969bf05afcefb36@google.com>
Subject: Re: Re: KASAN: use-after-free Read in btrfs_scan_one_device
From:   syzbot <syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Johannes.Thumshirn@wdc.com, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> On 21/09/2020 07:38, syzbot wrote:
>> syzbot has found a reproducer for the following issue on:
>> 
>> HEAD commit:    325d0eab Merge branch 'akpm' (patches from Andrew)
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1512df53900000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=6a8a2ae52ed737db
>> dashboard link: https://syzkaller.appspot.com/bug?extid=582e66e5edf36a22c7b0
>> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12366f8b900000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e6929b900000
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com
>> 
>> ==================================================================
>> BUG: KASAN: use-after-free in btrfs_printk+0x3eb/0x435 fs/btrfs/super.c:245
>> Read of size 8 at addr ffff8880878e06a8 by task syz-executor225/7068
>> 
>> CPU: 1 PID: 7068 Comm: syz-executor225 Not tainted 5.9.0-rc5-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x1d6/0x29e lib/dump_stack.c:118
>>  print_address_description+0x66/0x620 mm/kasan/report.c:383
>>  __kasan_report mm/kasan/report.c:513 [inline]
>>  kasan_report+0x132/0x1d0 mm/kasan/report.c:530
>>  btrfs_printk+0x3eb/0x435 fs/btrfs/super.c:245
>>  device_list_add+0x1a88/0x1d60 fs/btrfs/volumes.c:943
>>  btrfs_scan_one_device+0x196/0x490 fs/btrfs/volumes.c:1359
>>  btrfs_mount_root+0x48f/0xb60 fs/btrfs/super.c:1634
>>  legacy_get_tree+0xea/0x180 fs/fs_context.c:592
>>  vfs_get_tree+0x88/0x270 fs/super.c:1547
>>  fc_mount fs/namespace.c:978 [inline]
>>  vfs_kern_mount+0xc9/0x160 fs/namespace.c:1008
>>  btrfs_mount+0x33c/0xae0 fs/btrfs/super.c:1732
>>  legacy_get_tree+0xea/0x180 fs/fs_context.c:592
>>  vfs_get_tree+0x88/0x270 fs/super.c:1547
>>  do_new_mount fs/namespace.c:2875 [inline]
>>  path_mount+0x179d/0x29e0 fs/namespace.c:3192
>>  do_mount fs/namespace.c:3205 [inline]
>>  __do_sys_mount fs/namespace.c:3413 [inline]
>>  __se_sys_mount+0x126/0x180 fs/namespace.c:3390
>>  do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
>>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> RIP: 0033:0x44840a
>> Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 cd a2 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 aa a2 fb ff c3 66 0f 1f 84 00 00 00 00 00
>> RSP: 002b:00007ffedfffd608 EFLAGS: 00000293 ORIG_RAX: 00000000000000a5
>> RAX: ffffffffffffffda RBX: 00007ffedfffd670 RCX: 000000000044840a
>> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffedfffd630
>> RBP: 00007ffedfffd630 R08: 00007ffedfffd670 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000293 R12: 000000000000001a
>> R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003
>> 
>> Allocated by task 6945:
>>  kasan_save_stack mm/kasan/common.c:48 [inline]
>>  kasan_set_track mm/kasan/common.c:56 [inline]
>>  __kasan_kmalloc+0x100/0x130 mm/kasan/common.c:461
>>  kmalloc_node include/linux/slab.h:577 [inline]
>>  kvmalloc_node+0x81/0x110 mm/util.c:574
>>  kvmalloc include/linux/mm.h:757 [inline]
>>  kvzalloc include/linux/mm.h:765 [inline]
>>  btrfs_mount_root+0xd0/0xb60 fs/btrfs/super.c:1613
>>  legacy_get_tree+0xea/0x180 fs/fs_context.c:592
>>  vfs_get_tree+0x88/0x270 fs/super.c:1547
>>  fc_mount fs/namespace.c:978 [inline]
>>  vfs_kern_mount+0xc9/0x160 fs/namespace.c:1008
>>  btrfs_mount+0x33c/0xae0 fs/btrfs/super.c:1732
>>  legacy_get_tree+0xea/0x180 fs/fs_context.c:592
>>  vfs_get_tree+0x88/0x270 fs/super.c:1547
>>  do_new_mount fs/namespace.c:2875 [inline]
>>  path_mount+0x179d/0x29e0 fs/namespace.c:3192
>>  do_mount fs/namespace.c:3205 [inline]
>>  __do_sys_mount fs/namespace.c:3413 [inline]
>>  __se_sys_mount+0x126/0x180 fs/namespace.c:3390
>>  do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
>>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> 
>> Freed by task 6945:
>>  kasan_save_stack mm/kasan/common.c:48 [inline]
>>  kasan_set_track+0x3d/0x70 mm/kasan/common.c:56
>>  kasan_set_free_info+0x17/0x30 mm/kasan/generic.c:355
>>  __kasan_slab_free+0xdd/0x110 mm/kasan/common.c:422
>>  __cache_free mm/slab.c:3418 [inline]
>>  kfree+0x113/0x200 mm/slab.c:3756
>>  deactivate_locked_super+0xa7/0xf0 fs/super.c:335
>>  btrfs_mount_root+0x72b/0xb60 fs/btrfs/super.c:1678
>>  legacy_get_tree+0xea/0x180 fs/fs_context.c:592
>>  vfs_get_tree+0x88/0x270 fs/super.c:1547
>>  fc_mount fs/namespace.c:978 [inline]
>>  vfs_kern_mount+0xc9/0x160 fs/namespace.c:1008
>>  btrfs_mount+0x33c/0xae0 fs/btrfs/super.c:1732
>>  legacy_get_tree+0xea/0x180 fs/fs_context.c:592
>>  vfs_get_tree+0x88/0x270 fs/super.c:1547
>>  do_new_mount fs/namespace.c:2875 [inline]
>>  path_mount+0x179d/0x29e0 fs/namespace.c:3192
>>  do_mount fs/namespace.c:3205 [inline]
>>  __do_sys_mount fs/namespace.c:3413 [inline]
>>  __se_sys_mount+0x126/0x180 fs/namespace.c:3390
>>  do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
>>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> 
>> The buggy address belongs to the object at ffff8880878e0000
>>  which belongs to the cache kmalloc-16k of size 16384
>> The buggy address is located 1704 bytes inside of
>>  16384-byte region [ffff8880878e0000, ffff8880878e4000)
>> The buggy address belongs to the page:
>> page:0000000060704f30 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x878e0
>> head:0000000060704f30 order:3 compound_mapcount:0 compound_pincount:0
>> flags: 0xfffe0000010200(slab|head)
>> raw: 00fffe0000010200 ffffea00028e9a08 ffffea00021e3608 ffff8880aa440b00
>> raw: 0000000000000000 ffff8880878e0000 0000000100000001 0000000000000000
>> page dumped because: kasan: bad access detected
>> 
>> Memory state around the buggy address:
>>  ffff8880878e0580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>  ffff8880878e0600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>> ffff8880878e0680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>                                   ^
>>  ffff8880878e0700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>  ffff8880878e0780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ==================================================================
>> 
>> 
>
> #syz test: btrfs: Fix missing close devices

want 2 args (repo, branch), got 5

>
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/SN4PR0401MB3598EE548546274CFDD618AA9B3A0%40SN4PR0401MB3598.namprd04.prod.outlook.com.
