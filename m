Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C2165AF31
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jan 2023 11:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjABKCT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Jan 2023 05:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjABKBm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Jan 2023 05:01:42 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091282194
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Jan 2023 02:01:41 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id a9-20020a921a09000000b0030bda27ddcbso17774212ila.18
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Jan 2023 02:01:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D2Q3qR1euW7nAjCiZKQII9Vly+x5OIIAh7kDKHzcCOw=;
        b=AwZaTXQYhNeWG4V7Yo4PXPWZ5MVtB1VjcaZIWf98J3QE/Y7k+SQtEMNpQSiDdtJawR
         GCaKE+dMMHD5LiN9KmXzSTRmBsHbzRGyaYbpPEUZ70+5tlkx2BF8ePqXPJHNuxbfSmE6
         Pk12pynQvyQxbDjLVUeteseLwHlvPAZd28CMSdBZBHGUu53PrdHBhkFpd9SIcjk8VfPv
         4Xkzu5WVVGfQVj+YSgt0wBIKN9qC+Vy8u6hAkTiYDXDTNUbzVPYlHwz6X47aOxsfVxoa
         iMoqKaqdAue4tKGylKhdBx59Zc3vFd5mp/eXgukeA7h+ul7kuS6lgPy74RWPcBu2TtgS
         itsA==
X-Gm-Message-State: AFqh2kqpfkfYeDwu4EIU4TZpiXu14VL2tGpKaIWqF5puy7S/Rdk40ScT
        +7e2AlhCNypS/gujeQ18BOoehy1GPcD0gFFG2iB+Uxp7d34a
X-Google-Smtp-Source: AMrXdXtdfiwwj29BZMnN8C9TNWc7EoPdH+9VPzBtkKJlIuB0ULeY+3KykndBC7/ob7BA0eHD9yE6l1WpT8HAoMzIeSdfMZDMnMsL
MIME-Version: 1.0
X-Received: by 2002:a5d:81d9:0:b0:6df:bcf7:d86 with SMTP id
 t25-20020a5d81d9000000b006dfbcf70d86mr2898351iol.188.1672653700406; Mon, 02
 Jan 2023 02:01:40 -0800 (PST)
Date:   Mon, 02 Jan 2023 02:01:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5232d05f14509d0@google.com>
Subject: [syzbot] [btrfs?] KASAN: use-after-free Read in wait_subpage_spinlock
From:   syzbot <syzbot+042fc0183073dc434e78@syzkaller.appspotmail.com>
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

HEAD commit:    1b929c02afd3 Linux 6.2-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170cedb0480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2651619a26b4d687
dashboard link: https://syzkaller.appspot.com/bug?extid=042fc0183073dc434e78
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+042fc0183073dc434e78@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in btrfs_sb fs/btrfs/super.h:14 [inline]
BUG: KASAN: use-after-free in wait_subpage_spinlock+0x1be/0x210 fs/btrfs/inode.c:8232
Read of size 8 at addr ffff888076b74678 by task syz-executor.1/31086

CPU: 0 PID: 31086 Comm: syz-executor.1 Not tainted 6.2.0-rc1-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:517
 btrfs_sb fs/btrfs/super.h:14 [inline]
 wait_subpage_spinlock+0x1be/0x210 fs/btrfs/inode.c:8232
 __btrfs_release_folio fs/btrfs/inode.c:8261 [inline]
 btrfs_release_folio+0x109/0x130 fs/btrfs/inode.c:8271
 filemap_release_folio+0x13f/0x1b0 mm/filemap.c:3967
 shrink_folio_list+0x1ea9/0x3a60 mm/vmscan.c:2000
 shrink_inactive_list mm/vmscan.c:2526 [inline]
 shrink_list mm/vmscan.c:2767 [inline]
 shrink_lruvec+0xd0e/0x27a0 mm/vmscan.c:5951
 shrink_node_memcgs mm/vmscan.c:6138 [inline]
 shrink_node+0x8f2/0x1f40 mm/vmscan.c:6169
 shrink_zones mm/vmscan.c:6407 [inline]
 do_try_to_free_pages+0x3b4/0x17a0 mm/vmscan.c:6469
 try_to_free_pages+0x2e5/0x960 mm/vmscan.c:6704
 __perform_reclaim mm/page_alloc.c:4750 [inline]
 __alloc_pages_direct_reclaim mm/page_alloc.c:4772 [inline]
 __alloc_pages_slowpath.constprop.0+0x8b6/0x23d0 mm/page_alloc.c:5178
 __alloc_pages+0x4aa/0x5b0 mm/page_alloc.c:5562
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 alloc_pages_node include/linux/gfp.h:260 [inline]
 bpf_ringbuf_area_alloc kernel/bpf/ringbuf.c:130 [inline]
 bpf_ringbuf_alloc kernel/bpf/ringbuf.c:167 [inline]
 ringbuf_map_alloc kernel/bpf/ringbuf.c:207 [inline]
 ringbuf_map_alloc+0x2a9/0x7d0 kernel/bpf/ringbuf.c:183
 find_and_alloc_map kernel/bpf/syscall.c:131 [inline]
 map_create+0x4d3/0x18d0 kernel/bpf/syscall.c:1123
 __sys_bpf+0x13b7/0x5000 kernel/bpf/syscall.c:4961
 __do_sys_bpf kernel/bpf/syscall.c:5083 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5081 [inline]
 __ia32_sys_bpf+0x78/0xe0 kernel/bpf/syscall.c:5081
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7ff8549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7ff35cc EFLAGS: 00000296
 ORIG_RAX: 0000000000000165
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000200004c0
RDX: 0000000000000048 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 31068:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 ____kasan_kmalloc mm/kasan/common.c:330 [inline]
 __kasan_kmalloc+0xa5/0xb0 mm/kasan/common.c:380
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slab_common.c:968 [inline]
 __kmalloc+0x5a/0xd0 mm/slab_common.c:981
 kmalloc include/linux/slab.h:584 [inline]
 tomoyo_realpath_from_path+0xc3/0x600 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_number_perm+0x217/0x570 security/tomoyo/file.c:723
 security_file_ioctl+0x54/0xb0 security/security.c:1624
 __do_compat_sys_ioctl+0x4e/0x2b0 fs/ioctl.c:920
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Freed by task 31068:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:518
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0xaf/0x3b0 mm/slub.c:3800
 tomoyo_realpath_from_path+0x190/0x600 security/tomoyo/realpath.c:286
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_number_perm+0x217/0x570 security/tomoyo/file.c:723
 security_file_ioctl+0x54/0xb0 security/security.c:1624
 __do_compat_sys_ioctl+0x4e/0x2b0 fs/ioctl.c:920
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

The buggy address belongs to the object at ffff888076b74000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 1656 bytes inside of
 4096-byte region [ffff888076b74000, ffff888076b75000)

The buggy address belongs to the physical page:
page:ffffea0001dadc00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76b70
head:ffffea0001dadc00 order:3 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
anon flags: 0x4fff00000010200(slab|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000010200 ffff888012443040 0000000000000000 0000000000000001
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 4589, tgid 4589 (udevd), ts 844464905092, free_ts 844431282822
 prep_new_page mm/page_alloc.c:2531 [inline]
 get_page_from_freelist+0x119c/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5549
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2286
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x350 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x1a4/0x430 mm/slub.c:3491
 __do_kmalloc_node mm/slab_common.c:967 [inline]
 __kmalloc+0x4a/0xd0 mm/slab_common.c:981
 kmalloc include/linux/slab.h:584 [inline]
 tomoyo_realpath_from_path+0xc3/0x600 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x297/0x3a0 security/tomoyo/file.c:771
 tomoyo_file_open security/tomoyo/tomoyo.c:332 [inline]
 tomoyo_file_open+0xa1/0xc0 security/tomoyo/tomoyo.c:327
 security_file_open+0x49/0xb0 security/security.c:1718
 do_dentry_open+0x575/0x13f0 fs/open.c:869
 do_open fs/namei.c:3557 [inline]
 path_openat+0x1bbc/0x2a50 fs/namei.c:3714
 do_filp_open+0x1ba/0x410 fs/namei.c:3741
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1310
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1446 [inline]
 free_pcp_prepare+0x65c/0xc00 mm/page_alloc.c:1496
 free_unref_page_prepare mm/page_alloc.c:3369 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3464
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2637
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x192/0x220 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x66/0x90 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:761 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x1e4/0x430 mm/slub.c:3476
 kmem_cache_zalloc include/linux/slab.h:710 [inline]
 jbd2_alloc_handle include/linux/jbd2.h:1596 [inline]
 new_handle fs/jbd2/transaction.c:476 [inline]
 jbd2__journal_start+0x195/0x9b0 fs/jbd2/transaction.c:503
 __ext4_journal_start_sb+0x6e9/0x860 fs/ext4/ext4_jbd2.c:111
 __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
 ext4_dirty_inode+0xa5/0x130 fs/ext4/inode.c:6107
 __mark_inode_dirty+0x247/0x11e0 fs/fs-writeback.c:2419
 mark_inode_dirty include/linux/fs.h:2462 [inline]
 generic_write_end+0x354/0x440 fs/buffer.c:2184
 ext4_da_write_end+0x1f5/0xa30 fs/ext4/inode.c:3175
 generic_perform_write+0x316/0x570 mm/filemap.c:3783
 ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:285
 ext4_file_write_iter+0x8bf/0x1710 fs/ext4/file.c:700

Memory state around the buggy address:
 ffff888076b74500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888076b74580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888076b74600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff888076b74680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888076b74700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
