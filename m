Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F947DFE36
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Nov 2023 04:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjKCDDk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 23:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKCDDi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 23:03:38 -0400
Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC51A1A1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 20:03:27 -0700 (PDT)
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-1ef4f8d294aso2296593fac.0
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Nov 2023 20:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698980607; x=1699585407;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gu8Pr5FR+7rDJWQtouwNM75A3jZ28Jj8CfrNRZgzMJQ=;
        b=AvrNXkeuIgptvwBLEJtmd4UYZvHHhoKsZRED5ewMcaUWaxjSjg0B+wMsH+8RYywXSy
         1X5UHoxkFoju7tEvu5he+3HcYFC2IIJ3duOruKJYJhApOivB7pl/T/VWGihF3LV1UDUW
         /MVCuwg8vwLl+5fvZcVBiReXVewa7yweL71k6N6BGGdi50iY+3A5LNcckNawCQkSu8n5
         kkOPrhT8tD2r6M8kbQn2Px+cYr03DGwS71cNsdXfMqZKu1hxt2BWCxu0btq/PULF0qc6
         rHVo5bbaLFagvZHGdFl4gj+DqoioLzOZtZGyWBQQ+giZPvB+NVudSUZGWjwD/Zh0YJEd
         aF9A==
X-Gm-Message-State: AOJu0YysS/nRj8FnZ1C+eCgH+OQm7KItl8ltkH6Dvsm8ZY9GZZBp5YC6
        L1J770tZy+byCCcO3N3zmrMVh7s8EvZLMZ8RjUcDBke9k7Ir
X-Google-Smtp-Source: AGHT+IFUK8Kmaq0Ql85CNV2I6w2QpDbzcZ84OmWFUQ5RhfV2P2EUOdD1OmvZ5zwFqHfCaRz8Tq65edNLne0MpaD4QKf9MNNd+4j2
MIME-Version: 1.0
X-Received: by 2002:a05:6870:218a:b0:1e9:a253:afb1 with SMTP id
 l10-20020a056870218a00b001e9a253afb1mr9691138oae.9.1698980607139; Thu, 02 Nov
 2023 20:03:27 -0700 (PDT)
Date:   Thu, 02 Nov 2023 20:03:27 -0700
In-Reply-To: <000000000000a6429e0609331930@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091a5b2060936bf6d@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in btrfs_qgroup_account_extent
From:   syzbot <syzbot+e0b615318f8fcfc01ceb@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    4652b8e4f3ff Merge tag '6.7-rc-ksmbd-server-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b8cbd7680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d855e3560c4c99c4
dashboard link: https://syzkaller.appspot.com/bug?extid=e0b615318f8fcfc01ceb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b6f140e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/162622d42235/disk-4652b8e4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/62d46f58ffc9/vmlinux-4652b8e4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d1062e5866ab/bzImage-4652b8e4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2bc5f0cf2a6e/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e0b615318f8fcfc01ceb@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report+0x2f/0x130 lib/list_debug.c:49
Read of size 8 at addr ffff888027e420b0 by task kworker/u4:3/48

CPU: 1 PID: 48 Comm: kworker/u4:3 Not tainted 6.6.0-syzkaller-10396-g4652b8e4f3ff #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: btrfs-qgroup-rescan btrfs_work_helper
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x175/0x1b0 mm/kasan/report.c:588
 __list_del_entry_valid_or_report+0x2f/0x130 lib/list_debug.c:49
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del_init include/linux/list.h:287 [inline]
 qgroup_iterator_nested_clean fs/btrfs/qgroup.c:2623 [inline]
 btrfs_qgroup_account_extent+0x18b/0x1150 fs/btrfs/qgroup.c:2883
 qgroup_rescan_leaf fs/btrfs/qgroup.c:3543 [inline]
 btrfs_qgroup_rescan_worker+0x1078/0x1c60 fs/btrfs/qgroup.c:3604
 btrfs_work_helper+0x37c/0xbd0 fs/btrfs/async-thread.c:315
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
 worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>

Allocated by task 6355:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 btrfs_quota_enable+0xee9/0x2060 fs/btrfs/qgroup.c:1209
 btrfs_ioctl_quota_ctl+0x143/0x190 fs/btrfs/ioctl.c:3705
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Freed by task 6355:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0x263/0x3a0 mm/slub.c:3822
 btrfs_remove_qgroup+0x764/0x8c0 fs/btrfs/qgroup.c:1787
 btrfs_ioctl_qgroup_create+0x185/0x1e0 fs/btrfs/ioctl.c:3811
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xad/0xc0 mm/kasan/generic.c:492
 __call_rcu_common kernel/rcu/tree.c:2667 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:2781
 kthread_worker_fn+0x4ba/0xa90 kernel/kthread.c:823
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Second to last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xad/0xc0 mm/kasan/generic.c:492
 __call_rcu_common kernel/rcu/tree.c:2667 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:2781
 kthread_worker_fn+0x4ba/0xa90 kernel/kthread.c:823
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

The buggy address belongs to the object at ffff888027e42000
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 176 bytes inside of
 freed 512-byte region [ffff888027e42000, ffff888027e42200)

The buggy address belongs to the physical page:
page:ffffea00009f9000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x27e40
head:ffffea00009f9000 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c41c80 ffffea0000a5ba00 dead000000000002
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4514, tgid 4514 (udevadm), ts 24598439480, free_ts 23755696267
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x31db/0x3360 mm/page_alloc.c:3170
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4426
 alloc_slab_page+0x6a/0x160 mm/slub.c:1870
 allocate_slab mm/slub.c:2017 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2070
 ___slab_alloc+0xc85/0x1310 mm/slub.c:3223
 __slab_alloc mm/slub.c:3322 [inline]
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x19d/0x270 mm/slub.c:3517
 kmalloc_trace+0x2a/0xe0 mm/slab_common.c:1098
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 kernfs_fop_open+0x3e7/0xcc0 fs/kernfs/file.c:670
 do_dentry_open+0x8fd/0x1590 fs/open.c:948
 do_open fs/namei.c:3622 [inline]
 path_openat+0x2845/0x3280 fs/namei.c:3779
 do_filp_open+0x234/0x490 fs/namei.c:3809
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_openat fs/open.c:1471 [inline]
 __se_sys_openat fs/open.c:1466 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1466
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x8c3/0x9f0 mm/page_alloc.c:2312
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2405
 discard_slab mm/slub.c:2116 [inline]
 __unfreeze_partials+0x1dc/0x220 mm/slub.c:2655
 put_cpu_partial+0x17b/0x250 mm/slub.c:2731
 __slab_free+0x2b6/0x390 mm/slub.c:3679
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x75/0xe0 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook+0x67/0x3d0 mm/slab.h:762
 slab_alloc_node mm/slub.c:3478 [inline]
 slab_alloc mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
 kmem_cache_alloc+0x104/0x2c0 mm/slub.c:3502
 getname_flags+0xbc/0x4f0 fs/namei.c:140
 do_sys_openat2+0xd2/0x1d0 fs/open.c:1434
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_openat fs/open.c:1471 [inline]
 __se_sys_openat fs/open.c:1466 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1466
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Memory state around the buggy address:
 ffff888027e41f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888027e42000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888027e42080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff888027e42100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888027e42180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
