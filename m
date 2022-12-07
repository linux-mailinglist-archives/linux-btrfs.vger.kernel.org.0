Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007DF645427
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 07:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiLGGmy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 01:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiLGGmu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 01:42:50 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A38641C
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 22:42:37 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id h11-20020a6b7a0b000000b006e0004fc167so7236640iom.5
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Dec 2022 22:42:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LOtGX3hqBssDQEXuqR4pmCavD11/kHrz96TBQoGppLc=;
        b=xtdmBGrXMFrKF8rKTuwk2g2vWms0hi8FB/26YQs/n1eutksU9RiVGJB7Y3rZOkTkwg
         /Qlq5u4aedu2+7jNuS2rG/PcHR95YPsOqKP8SjNjrLaju0fZSjhHAbq3tGPL77m7Y+12
         3uBjqzwhgiQzMlS6ffPDgb5uRSgpgngnSWSPYEqnjmh54WncIGR0iof160Sy8g/bFBwS
         4VN5ZQwxgFfSO7bLK7VKqnzpEJNQTPg7yR3K0hqquewwC8/LsEjLNxS+rn+1WeFCTocP
         8IuFtZnFUuwmjPOjLsz4QfVFMnnJFuVMant9IbWufajWDpgrb745cw7bC++6kljjq2D9
         FO/w==
X-Gm-Message-State: ANoB5pkMKrMpKRgqqsmxabPpX/XhY8B6W8HFaBbqWjRyyUqqKR7TRJlC
        EnkahY7tqOGKZMWLcV0mfiZvz8PQwPFiO//zpcogMdEmRxkd
X-Google-Smtp-Source: AA0mqf5msqzaeo10Dbs3zW6+dGzTKDmxMlwOMvBtFLFgzzRGKfq69rGqD8gGkkT8J5wBhSxflyfDMwaID0rqE6nhROrkN5q/4Cqs
MIME-Version: 1.0
X-Received: by 2002:a92:dcc3:0:b0:301:23ad:68a0 with SMTP id
 b3-20020a92dcc3000000b0030123ad68a0mr9695343ilr.190.1670395356705; Tue, 06
 Dec 2022 22:42:36 -0800 (PST)
Date:   Tue, 06 Dec 2022 22:42:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000defd4b05ef3739de@google.com>
Subject: [syzbot] KASAN: use-after-free Read in btrfs_clear_delalloc_extent
From:   syzbot <syzbot+7f9db4fc871a025068b5@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8ed710da2873 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=124b4483880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4edf421741552bc3
dashboard link: https://syzkaller.appspot.com/bug?extid=7f9db4fc871a025068b5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7f9db4fc871a025068b5@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
XFS (loop0): Mounting V5 Filesystem
==================================================================
BUG: KASAN: use-after-free in btrfs_sb fs/btrfs/ctree.h:1091 [inline]
BUG: KASAN: use-after-free in btrfs_clear_delalloc_extent+0x83a/0x900 fs/btrfs/inode.c:2445
Read of size 8 at addr ffff888074676678 by task syz-executor.0/19091

CPU: 2 PID: 19091 Comm: syz-executor.0 Not tainted 6.1.0-rc8-syzkaller-00014-g8ed710da2873 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:284 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:395
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:495
 btrfs_sb fs/btrfs/ctree.h:1091 [inline]
 btrfs_clear_delalloc_extent+0x83a/0x900 fs/btrfs/inode.c:2445
 clear_state_bit+0x6b/0x3a0 fs/btrfs/extent-io-tree.c:514
 __clear_extent_bit+0x3de/0xca0 fs/btrfs/extent-io-tree.c:648
 try_release_extent_state fs/btrfs/extent_io.c:3391 [inline]
 try_release_extent_mapping+0x539/0x690 fs/btrfs/extent_io.c:3487
 __btrfs_release_folio fs/btrfs/inode.c:8175 [inline]
 btrfs_release_folio+0xc8/0x130 fs/btrfs/inode.c:8188
 filemap_release_folio+0x13f/0x1b0 mm/filemap.c:3948
 shrink_folio_list+0x1cb4/0x35b0 mm/vmscan.c:1982
 shrink_inactive_list mm/vmscan.c:2489 [inline]
 shrink_list mm/vmscan.c:2728 [inline]
 shrink_lruvec+0xce7/0x2740 mm/vmscan.c:5923
 shrink_node_memcgs mm/vmscan.c:6110 [inline]
 shrink_node+0x8d2/0x1f30 mm/vmscan.c:6141
 shrink_zones mm/vmscan.c:6379 [inline]
 do_try_to_free_pages+0x3b4/0x17a0 mm/vmscan.c:6441
 try_to_free_pages+0x2e5/0x960 mm/vmscan.c:6676
 __perform_reclaim mm/page_alloc.c:4758 [inline]
 __alloc_pages_direct_reclaim mm/page_alloc.c:4780 [inline]
 __alloc_pages_slowpath.constprop.0+0x8b6/0x23d0 mm/page_alloc.c:5186
 __alloc_pages+0x4aa/0x5b0 mm/page_alloc.c:5571
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 alloc_pages_node include/linux/gfp.h:260 [inline]
 __kmalloc_large_node+0x85/0x160 mm/slab_common.c:1096
 __do_kmalloc_node mm/slab_common.c:943 [inline]
 __kmalloc_node+0x8e/0xd0 mm/slab_common.c:962
 kmalloc_node include/linux/slab.h:579 [inline]
 kvmalloc_node+0xaa/0x1b0 mm/util.c:581
 kvmalloc include/linux/slab.h:706 [inline]
 kvzalloc include/linux/slab.h:714 [inline]
 xlog_alloc_buffer+0x122/0x1f0 fs/xfs/xfs_log_recover.c:104
 xlog_write_log_records+0x11b/0x3c0 fs/xfs/xfs_log_recover.c:1534
 xlog_clear_stale_blocks+0x20a/0x470 fs/xfs/xfs_log_recover.c:1681
 xlog_find_tail+0x807/0x980 fs/xfs/xfs_log_recover.c:1365
 xlog_recover+0x7d/0x500 fs/xfs/xfs_log_recover.c:3361
 xfs_log_mount+0x363/0x6f0 fs/xfs/xfs_log.c:739
 xfs_mountfs+0x11e1/0x1f60 fs/xfs/xfs_mount.c:805
 xfs_fs_fill_super+0x13b7/0x2000 fs/xfs/xfs_super.c:1666
 get_tree_bdev+0x444/0x760 fs/super.c:1324
 vfs_get_tree+0x8d/0x2f0 fs/super.c:1531
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x132a/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __ia32_sys_mount+0x282/0x300 fs/namespace.c:3568
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7ff8549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7ff3410 EFLAGS: 00000296 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00000000f7ff3480 RCX: 0000000020009640
RDX: 0000000020009600 RSI: 0000000000000000 RDI: 00000000f7ff34c0
RBP: 00000000f7ff34c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 11840:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 ____kasan_kmalloc mm/kasan/common.c:330 [inline]
 __kasan_kmalloc+0xa5/0xb0 mm/kasan/common.c:380
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slab_common.c:955 [inline]
 __kmalloc_node_track_caller+0x5b/0xc0 mm/slab_common.c:975
 kmalloc_reserve net/core/skbuff.c:437 [inline]
 __alloc_skb+0xdd/0x300 net/core/skbuff.c:509
 alloc_skb include/linux/skbuff.h:1267 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:751 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:808 [inline]
 nsim_dev_trap_report_work+0x2b1/0xc80 drivers/net/netdevsim/dev.c:853
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Freed by task 11840:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1724 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1750
 slab_free mm/slub.c:3661 [inline]
 __kmem_cache_free+0xaf/0x3b0 mm/slub.c:3674
 skb_free_head+0xac/0x110 net/core/skbuff.c:760
 skb_release_data+0x5f1/0x870 net/core/skbuff.c:789
 skb_release_all net/core/skbuff.c:854 [inline]
 __kfree_skb net/core/skbuff.c:868 [inline]
 consume_skb net/core/skbuff.c:1033 [inline]
 consume_skb+0xc6/0x160 net/core/skbuff.c:1027
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:824 [inline]
 nsim_dev_trap_report_work+0x87c/0xc80 drivers/net/netdevsim/dev.c:853
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:481
 insert_work+0x48/0x350 kernel/workqueue.c:1358
 __queue_work+0x693/0x13b0 kernel/workqueue.c:1517
 queue_work_on+0xf2/0x110 kernel/workqueue.c:1545
 rcu_do_batch kernel/rcu/tree.c:2250 [inline]
 rcu_core+0x81f/0x1980 kernel/rcu/tree.c:2510
 __do_softirq+0x1fb/0xadc kernel/softirq.c:571

Second to last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:481
 call_rcu+0x9d/0x820 kernel/rcu/tree.c:2798
 __put_super fs/super.c:347 [inline]
 put_super fs/super.c:311 [inline]
 deactivate_locked_super+0x142/0x160 fs/super.c:343
 deactivate_super+0xb1/0xd0 fs/super.c:363
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1186
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
 __do_fast_syscall_32+0x72/0xf0 arch/x86/entry/common.c:181
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

The buggy address belongs to the object at ffff888074676000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 1656 bytes inside of
 4096-byte region [ffff888074676000, ffff888074677000)

The buggy address belongs to the physical page:
page:ffffea0001d19c00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x74670
head:ffffea0001d19c00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0x4fff00000010200(slab|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000010200 dead000000000100 dead000000000122 ffff888012043040
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 14057, tgid 14056 (syz-executor.3), ts 619891798449, free_ts 619557125427
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x10b5/0x2d50 mm/page_alloc.c:4291
 __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5558
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2285
 alloc_slab_page mm/slub.c:1794 [inline]
 allocate_slab+0x25f/0x350 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3180
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3279
 slab_alloc_node mm/slub.c:3364 [inline]
 __kmem_cache_alloc_node+0x199/0x3e0 mm/slub.c:3437
 kmalloc_trace+0x26/0x60 mm/slab_common.c:1045
 kmalloc include/linux/slab.h:553 [inline]
 kzalloc include/linux/slab.h:689 [inline]
 btrfs_alloc_root+0x48/0x90 fs/btrfs/disk-io.c:1048
 open_ctree+0x56e/0x4581 fs/btrfs/disk-io.c:3426
 btrfs_fill_super fs/btrfs/super.c:1461 [inline]
 btrfs_mount_root.cold+0x15/0x162 fs/btrfs/super.c:1829
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610
 vfs_get_tree+0x8d/0x2f0 fs/super.c:1531
 fc_mount fs/namespace.c:1043 [inline]
 vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1073
 vfs_kern_mount+0x40/0x60 fs/namespace.c:1060
 btrfs_mount+0x238/0xa70 fs/btrfs/super.c:1889
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1459 [inline]
 free_pcp_prepare+0x65c/0xd90 mm/page_alloc.c:1509
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x1d/0x4d0 mm/page_alloc.c:3483
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2586
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x184/0x210 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x66/0x90 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 __kmem_cache_alloc_node+0x2e2/0x3e0 mm/slub.c:3437
 kmalloc_node_trace+0x21/0x60 mm/slab_common.c:1058
 kmalloc_node include/linux/slab.h:575 [inline]
 kzalloc_node include/linux/slab.h:700 [inline]
 __get_vm_area_node+0xed/0x3f0 mm/vmalloc.c:2494
 __vmalloc_node_range+0x25b/0x13c0 mm/vmalloc.c:3173
 __vmalloc_node mm/vmalloc.c:3278 [inline]
 vmalloc+0x6b/0x80 mm/vmalloc.c:3311
 xt_compat_init_offsets+0xe3/0x220 net/netfilter/x_tables.c:733
 compat_table_info+0xb7/0x510 net/ipv4/netfilter/arp_tables.c:779
 compat_get_entries+0x1ca/0x6c0 net/ipv4/netfilter/arp_tables.c:1388
 do_arpt_get_ctl+0x4f3/0x8f0 net/ipv4/netfilter/arp_tables.c:1450
 nf_getsockopt+0x76/0xd0 net/netfilter/nf_sockopt.c:116

Memory state around the buggy address:
 ffff888074676500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888074676580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888074676600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff888074676680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888074676700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
   0:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
   4:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b8740d
   a:	10 06                	adc    %al,(%rsi)
   c:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
  10:	10 07                	adc    %al,(%rdi)
  12:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
  16:	10 08                	adc    %cl,(%rax)
  18:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1c:	00 00                	add    %al,(%rax)
  1e:	00 00                	add    %al,(%rax)
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
* 2a:	5d                   	pop    %rbp <-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	retq
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
