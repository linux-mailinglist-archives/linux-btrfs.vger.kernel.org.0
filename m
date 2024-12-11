Return-Path: <linux-btrfs+bounces-10239-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A82099ECF3F
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 16:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAA7168871
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 15:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE46A19F13C;
	Wed, 11 Dec 2024 15:03:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635EA246345
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929404; cv=none; b=BRQU9F17mrsCrNOq1GM853sh9A9TbWfn9k1V9g+T7oLXMGWzpTofJn5/oIzATrfb9gdumm5lg3mcj9OdCLbZWteFjsynsThCONW6wXYX5M4dIAvMkNGXaH/JM7L5h1wPsAvGJb/Aky8d3UzRZbyDcWWvX/nShLlp/WryB+W9/aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929404; c=relaxed/simple;
	bh=72fBofn+xdG07xDvo1qlPnC3RLog+1xW3t8UQlnV9/M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CY/uwV46sLTCeEksS8FgdHYfTNi6G2GQoALJHFtmepaz9j2OOy8coe+mVXna2mJjUqnzDX6+T/t3OFR7iD30Mt5NvIJemj+uYDx2IJFJQwvAuKz1Uzp85PRqkoVTE7bDoxnQoFYlVZ5F30xn1fRFGYp/ybb45jxC4SJGlU8CKkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a9cbe8fea1so41684015ab.3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 07:03:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733929401; x=1734534201;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lzf3zyjh8yyoO6NOfnI/w5F7So6Jak72pTsto521oxQ=;
        b=T80ECP4GNw5dK2181YeqmCL1rBV06njU0FR43BuHRinfb/7/7SuvKKl/c+62EpqJ4m
         xfitaFItAz3xY7uqv3TKIQ1u+3vD6vrJ0n3/nbDtAdmYVq3lhh/2Pl/uog39fJax7TC5
         oPcPuSWRHL/CtNlg79fIVFLxTpPUPlC7shF9BmcCkDgOm1XXGNiZ4XO0LN0cqvozYj5+
         XJiqlwcI2wxse2n4htTdP2UPZ9csDx4FrLj1IsLX6/bpM6ONUaLwFG5hH07HyFLEn+GI
         vb4+YhJFmSj7Xiqf90p7GdrZdZxx0+Zymsa/ag+E3R+eEOu60OpCyHj6VYDgqN3Fz9X4
         CsOw==
X-Forwarded-Encrypted: i=1; AJvYcCXsbJEjfH/6xhlxKgK+oZG7szNzQTlcwOf1DYVdZIo6JmjVeLvTif+4mQEb0gqH+QNMg5PCn+RqSEpqyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwR2aw/UeSnMd+77Tl6aulmb/KEClH+igRmMkTg9lYur3Y8+B2F
	6eJJVpI+zjWGEEo1MwIgR9sn5p17+yInRcWvK8evRm+f9SrFok9x6fxXQIo+mW7hDHmhzg380nr
	gP4qFQslXiz1I/bxKxRL7jmCac2C8+RhZj8xltnPFNbYW8WbUoheOEa8=
X-Google-Smtp-Source: AGHT+IFXPYsrMp5ueX0n+s/0motvbSIxP84n5bms/B0vUpqBGtXmTiaMFUi6jBoLGj2ScKRcswBDyl+q702OVBjNBi6AOvV65/si
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a4:b0:3a7:99a5:a207 with SMTP id
 e9e14a558f8ab-3aa056cb760mr33289415ab.5.1733929401449; Wed, 11 Dec 2024
 07:03:21 -0800 (PST)
Date: Wed, 11 Dec 2024 07:03:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6759a9b9.050a0220.1ac542.000d.GAE@google.com>
Subject: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in btrfs_cow_block
From: syzbot <syzbot+8517da8635307182c8a5@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b5f217084ab3 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1055f020580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=8517da8635307182c8a5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-b5f21708.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/858a023f110b/vmlinux-b5f21708.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4b03d6afaab4/bzImage-b5f21708.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8517da8635307182c8a5@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
BTRFS: device fsid ed167579-eb65-4e76-9a50-61ac97e9b59d devid 1 transid 8 /dev/loop0 (7:0) scanned by syz.0.0 (5315)
BTRFS info (device loop0): first mount of filesystem ed167579-eb65-4e76-9a50-61ac97e9b59d
BTRFS info (device loop0): using sha256 (sha256-avx2) checksum algorithm
BTRFS info (device loop0): rebuilding free space tree
BTRFS info (device loop0): disabling free space tree
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
BTRFS info (device loop0): balance: start -d -m
BTRFS info (device loop0): relocating block group 6881280 flags data|metadata
BTRFS info (device loop0): relocating block group 5242880 flags data|metadata
==================================================================
BUG: KASAN: slab-use-after-free in do_perf_trace_btrfs_cow_block include/trace/events/btrfs.h:1082 [inline]
BUG: KASAN: slab-use-after-free in perf_trace_btrfs_cow_block+0x398/0x780 include/trace/events/btrfs.h:1082
Read of size 8 at addr ffff888011f09000 by task syz.0.0/5315

CPU: 0 UID: 0 PID: 5315 Comm: syz.0.0 Not tainted 6.13.0-rc1-syzkaller-00316-gb5f217084ab3 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 do_perf_trace_btrfs_cow_block include/trace/events/btrfs.h:1082 [inline]
 perf_trace_btrfs_cow_block+0x398/0x780 include/trace/events/btrfs.h:1082
 trace_btrfs_cow_block include/trace/events/btrfs.h:1082 [inline]
 btrfs_cow_block+0x9d9/0xa40 fs/btrfs/ctree.c:757
 btrfs_search_slot+0xc01/0x3180 fs/btrfs/ctree.c:2156
 btrfs_update_root+0xf6/0xc70 fs/btrfs/root-tree.c:144
 commit_fs_roots+0x4cd/0x720 fs/btrfs/transaction.c:1509
 btrfs_commit_transaction+0xfa7/0x3720 fs/btrfs/transaction.c:2428
 relocate_block_group+0xc09/0xd40 fs/btrfs/relocation.c:3760
 btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4081
 btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3494
 __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4278
 btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4655
 btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3670
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc4b797fed9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc4b8866058 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc4b7b45fa0 RCX: 00007fc4b797fed9
RDX: 0000000020000180 RSI: 00000000c4009420 RDI: 0000000000000006
RBP: 00007fc4b79f3cc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fc4b7b45fa0 R15: 00007ffc798d71d8
 </TASK>

Allocated by task 5315:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4160
 __alloc_extent_buffer+0x33/0x170 fs/btrfs/extent_io.c:2617
 alloc_extent_buffer+0x1ad/0x2740 fs/btrfs/extent_io.c:3019
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:5019 [inline]
 btrfs_alloc_tree_block+0x28e/0x1440 fs/btrfs/extent-tree.c:5132
 btrfs_force_cow_block+0x526/0x1da0 fs/btrfs/ctree.c:573
 btrfs_cow_block+0x35e/0xa40 fs/btrfs/ctree.c:754
 btrfs_search_slot+0xc01/0x3180 fs/btrfs/ctree.c:2156
 btrfs_insert_empty_items fs/btrfs/ctree.c:4354 [inline]
 btrfs_insert_empty_item fs/btrfs/ctree.h:669 [inline]
 btrfs_insert_item+0x1a0/0x3b0 fs/btrfs/ctree.c:4383
 create_reloc_root+0x60f/0x9a0 fs/btrfs/relocation.c:741
 btrfs_init_reloc_root+0x338/0x4f0 fs/btrfs/relocation.c:817
 record_root_in_trans+0x2c9/0x360 fs/btrfs/transaction.c:450
 btrfs_record_root_in_trans+0x164/0x190 fs/btrfs/transaction.c:496
 select_reloc_root+0x27e/0xfd0 fs/btrfs/relocation.c:2101
 do_relocation+0x329/0x1a50 fs/btrfs/relocation.c:2326
 relocate_tree_block fs/btrfs/relocation.c:2658 [inline]
 relocate_tree_blocks+0xf34/0x1dd0 fs/btrfs/relocation.c:2712
 relocate_block_group+0x755/0xd40 fs/btrfs/relocation.c:3680
 btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4081
 btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3494
 __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4278
 btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4655
 btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3670
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 8:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kmem_cache_free+0x195/0x410 mm/slub.c:4700
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 ipv6_get_lladdr+0x295/0x3d0 net/ipv6/addrconf.c:1936
 mld_newpack+0x337/0xaf0 net/ipv6/mcast.c:1755
 add_grhead net/ipv6/mcast.c:1850 [inline]
 add_grec+0x1492/0x19a0 net/ipv6/mcast.c:1988
 mld_send_initial_cr+0x228/0x4b0 net/ipv6/mcast.c:2234
 mld_dad_work+0x44/0x500 net/ipv6/mcast.c:2260
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
 __call_rcu_common kernel/rcu/tree.c:3086 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3190
 release_extent_buffer+0x206/0x2c0 fs/btrfs/extent_io.c:3230
 btrfs_force_cow_block+0xf9c/0x1da0 fs/btrfs/ctree.c:659
 btrfs_cow_block+0x35e/0xa40 fs/btrfs/ctree.c:754
 btrfs_search_slot+0xc01/0x3180 fs/btrfs/ctree.c:2156
 btrfs_update_root+0xf6/0xc70 fs/btrfs/root-tree.c:144
 commit_fs_roots+0x4cd/0x720 fs/btrfs/transaction.c:1509
 btrfs_commit_transaction+0xfa7/0x3720 fs/btrfs/transaction.c:2428
 relocate_block_group+0xc09/0xd40 fs/btrfs/relocation.c:3760
 btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4081
 btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3494
 __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4278
 btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4655
 btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3670
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888011f09000
 which belongs to the cache btrfs_extent_buffer of size 416
The buggy address is located 0 bytes inside of
 freed 416-byte region [ffff888011f09000, ffff888011f091a0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11f09
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88803fe35640 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5315, tgid 5314 (syz.0.0), ts 76027898168, free_ts 75595688995
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2408
 allocate_slab+0x5a/0x2f0 mm/slub.c:2574
 new_slab mm/slub.c:2627 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3815
 __slab_alloc+0x58/0xa0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 kmem_cache_alloc_noprof+0x268/0x380 mm/slub.c:4160
 __alloc_extent_buffer+0x33/0x170 fs/btrfs/extent_io.c:2617
 alloc_extent_buffer+0x1ad/0x2740 fs/btrfs/extent_io.c:3019
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:5019 [inline]
 btrfs_alloc_tree_block+0x28e/0x1440 fs/btrfs/extent-tree.c:5132
 btrfs_force_cow_block+0x526/0x1da0 fs/btrfs/ctree.c:573
 btrfs_cow_block+0x35e/0xa40 fs/btrfs/ctree.c:754
 btrfs_search_slot+0xc01/0x3180 fs/btrfs/ctree.c:2156
 btrfs_insert_empty_items fs/btrfs/ctree.c:4354 [inline]
 btrfs_insert_empty_item fs/btrfs/ctree.h:669 [inline]
 btrfs_insert_item+0x1a0/0x3b0 fs/btrfs/ctree.c:4383
page last free pid 4722 tgid 4722 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xdef/0x1130 mm/page_alloc.c:2657
 __slab_free+0x31b/0x3d0 mm/slub.c:4509
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4160
 getname_flags+0xb7/0x540 fs/namei.c:139
 do_readlinkat+0xd8/0x3a0 fs/stat.c:561
 __do_sys_readlink fs/stat.c:599 [inline]
 __se_sys_readlink fs/stat.c:596 [inline]
 __x64_sys_readlink+0x7f/0x90 fs/stat.c:596
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888011f08f00: 00 00 00 00 00 00 fc fc fc fc 00 00 00 00 00 00
 ffff888011f08f80: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888011f09000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888011f09080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888011f09100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

