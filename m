Return-Path: <linux-btrfs+bounces-8071-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C18E97A5A0
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 18:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807D91C26831
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 16:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70847159568;
	Mon, 16 Sep 2024 16:00:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1751E158520
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726502431; cv=none; b=MbG2Um6SyjGr1yEwYudGW0AVjhn2I5bhe1XWwqI3MFFLTJLzzKo7rzxYebvlG6zh+f1bIGcVmB1xJ0cwhHkkuwtKMAYMkeg83FGlSMahK9ALLFs63gaZgeT8dB7ve9CXwfoM65J7qdfeH73Gm298InVqpK39H7CerTwE4J8hLms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726502431; c=relaxed/simple;
	bh=62G1+mqEHEqQpxNcakNzfYevsjKL2LCmIKFWiov7ujA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QyFvBfU1y+lx6gc6ulMMJTAQIdcX46EF9mpADnOcqON6rJKdz+huO+E0UjVCsbUOBE//JPArGlSbWL6LpEAZj96B0BLVq850YVNJzokPZKGEhmuWj0eRzPsJitmAVKCYjC3Ej+9im3T81H3IIe1DTT5DZSmr4AtgFXOJllX/TIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39f6f16ed00so76280625ab.0
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 09:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726502429; x=1727107229;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrR0bm5K+FVGNxR55W2u/i22rkNMsWxBtqV+k/wx2zE=;
        b=ZpMx4wWHVWMrrGwQ9MTqdE24MvvkAwi1bG7SphelJK+IAunI8DGA51j9RaWqmz2/r1
         NX0kOl0KM58oSTeixaMTJaep2RmkTkL2FXkSfBsBVqnPtglHy0V1ngSA1ZoQcPwlvzDh
         MXje2SJHBXYBdpSNM5lCWzIGJ33XwpcR+WgBws8lNSSLh+b3pwwxB7pi7wmnKvgci9F3
         J0jydorTGQmM7hyucFqhk+YhkvD/3RkWMd2gIelS0PKdLVfmaini3jiA4LhK4fW7v08r
         jKAjMdt4TX7tq2BwY35vivozv8JRee6QpUfbM3mlPSXGIeJkeBiwOyYJREIAosO11otI
         3Nag==
X-Forwarded-Encrypted: i=1; AJvYcCUNV+khXYrHnecGAmgksyhfDUJ5HGqsr/ufIPk5XLNv3HCCc3ijBRpavif20+s2jTlofjomLBnof7x6dQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxN57cIizzMuteVJkD03ofAysOZjFRpNSqt4qZ93Vkox3H6dYvq
	w2Ng0eFSTK4k/RWUkhT8u7CUOE9ga8F/8UdJ//RIV3AAhiiIUXyjDFoW++byDYN8tVbdh/2NowN
	ykpDCUbsORL3kbWjbBzoJq4XOIosP6IB6Uqej5WDbMmKe4GGISsBianY=
X-Google-Smtp-Source: AGHT+IFsT8GSHNZ2SmY9QxODQu+6/2hoO42R9sWdiFVVVfT6VS3rxnoZUzSXUivPo3MTK2Baqoyu8aD93TllRD+4Rbisvesqdrry
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a04:b0:3a0:a1d7:791d with SMTP id
 e9e14a558f8ab-3a0a1d77ab5mr29200585ab.25.1726502428839; Mon, 16 Sep 2024
 09:00:28 -0700 (PDT)
Date: Mon, 16 Sep 2024 09:00:28 -0700
In-Reply-To: <0000000000003bc82506223d9c64@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9aad406223eabff@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in btrfs_cleanup_defrag_inodes
From: syzbot <syzbot+ad7966ca1f5dd8b001b3@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, fdmanana@kernel.org, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    adfc3ded5c33 Merge tag 'for-6.12/io_uring-discard-20240913..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152fa29f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71033c66cc4b01c4
dashboard link: https://syzkaller.appspot.com/bug?extid=ad7966ca1f5dd8b001b3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d79c07980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160ca8a9980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-adfc3ded.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/14d8d89edd95/vmlinux-adfc3ded.xz
kernel image: https://storage.googleapis.com/syzbot-assets/77b35977c15b/bzImage-adfc3ded.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/16dc3a6129eb/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ad7966ca1f5dd8b001b3@syzkaller.appspotmail.com

BTRFS info (device loop0 state EA): last unmount of filesystem c9fe44da-de57-406a-8241-57ec7d4412cf
==================================================================
BUG: KASAN: slab-use-after-free in rb_left_deepest_node lib/rbtree.c:595 [inline]
BUG: KASAN: slab-use-after-free in rb_first_postorder+0x69/0x90 lib/rbtree.c:628
Read of size 8 at addr ffff888047515010 by task syz-executor245/5095

CPU: 0 UID: 0 PID: 5095 Comm: syz-executor245 Not tainted 6.11.0-syzkaller-02520-gadfc3ded5c33 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 rb_left_deepest_node lib/rbtree.c:595 [inline]
 rb_first_postorder+0x69/0x90 lib/rbtree.c:628
 btrfs_cleanup_defrag_inodes+0x2f/0x80 fs/btrfs/defrag.c:212
 close_ctree+0x2af/0xd20 fs/btrfs/disk-io.c:4256
 generic_shutdown_super+0x139/0x2d0 fs/super.c:642
 kill_anon_super+0x3b/0x70 fs/super.c:1237
 btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2121
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x27f0 kernel/exit.c:882
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f37d0596809
Code: Unable to access opcode bytes at 0x7f37d05967df.
RSP: 002b:00007ffd0eed81f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f37d0596809
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 00007f37d0618390 R08: ffffffffffffffb8 R09: 0000000000000000
R10: 0000000000001000 R11: 0000000000000246 R12: 00007f37d0618390
R13: 0000000000000000 R14: 00007f37d0619100 R15: 00007f37d05647a0
 </TASK>

Allocated by task 5098:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3989 [inline]
 slab_alloc_node mm/slub.c:4038 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4045
 btrfs_add_inode_defrag+0x15c/0x790 fs/btrfs/defrag.c:136
 inode_should_defrag fs/btrfs/inode.c:888 [inline]
 cow_file_range+0x380/0x11f0 fs/btrfs/inode.c:1382
 btrfs_run_delalloc_range+0x33d/0xf70 fs/btrfs/inode.c:2334
 writepage_delalloc+0x482/0x7d0 fs/btrfs/extent_io.c:1192
 extent_writepage fs/btrfs/extent_io.c:1454 [inline]
 extent_write_cache_pages fs/btrfs/extent_io.c:2130 [inline]
 btrfs_writepages+0x1157/0x2370 fs/btrfs/extent_io.c:2261
 do_writepages+0x35d/0x870 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:397
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 filemap_fdatawrite_range+0x120/0x180 mm/filemap.c:448
 btrfs_fdatawrite_range+0x53/0xe0 fs/btrfs/file.c:3799
 btrfs_direct_write+0x565/0xa70 fs/btrfs/direct-io.c:961
 btrfs_do_write_iter+0x2a0/0x760 fs/btrfs/file.c:1505
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xa6d/0xc90 fs/read_write.c:683
 ksys_pwrite64 fs/read_write.c:798 [inline]
 __do_sys_pwrite64 fs/read_write.c:808 [inline]
 __se_sys_pwrite64 fs/read_write.c:805 [inline]
 __x64_sys_pwrite64+0x1aa/0x230 fs/read_write.c:805
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5098:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2250 [inline]
 slab_free mm/slub.c:4474 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4549
 btrfs_cleanup_defrag_inodes+0x51/0x80 fs/btrfs/defrag.c:214
 btrfs_remount_cleanup fs/btrfs/super.c:1263 [inline]
 btrfs_reconfigure+0x269c/0x2d40 fs/btrfs/super.c:1555
 reconfigure_super+0x445/0x880 fs/super.c:1083
 vfs_cmd_reconfigure fs/fsopen.c:263 [inline]
 vfs_fsconfig_locked fs/fsopen.c:292 [inline]
 __do_sys_fsconfig fs/fsopen.c:473 [inline]
 __se_sys_fsconfig+0xb68/0xf70 fs/fsopen.c:345
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888047515000
 which belongs to the cache btrfs_inode_defrag of size 56
The buggy address is located 16 bytes inside of
 freed 56-byte region [ffff888047515000, ffff888047515038)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x47515
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 04fff00000000000 ffff88803d4678c0 dead000000000122 0000000000000000
raw: 0000000000000000 00000000802e002e 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5098, tgid 5098 (syz-executor245), ts 85167218149, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1500
 prep_new_page mm/page_alloc.c:1508 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3446
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4702
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2319
 allocate_slab+0x5a/0x2f0 mm/slub.c:2482
 new_slab mm/slub.c:2535 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3721
 __slab_alloc+0x58/0xa0 mm/slub.c:3811
 __slab_alloc_node mm/slub.c:3864 [inline]
 slab_alloc_node mm/slub.c:4026 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4045
 btrfs_add_inode_defrag+0x15c/0x790 fs/btrfs/defrag.c:136
 inode_should_defrag fs/btrfs/inode.c:888 [inline]
 cow_file_range+0x380/0x11f0 fs/btrfs/inode.c:1382
 btrfs_run_delalloc_range+0x33d/0xf70 fs/btrfs/inode.c:2334
 writepage_delalloc+0x482/0x7d0 fs/btrfs/extent_io.c:1192
 extent_writepage fs/btrfs/extent_io.c:1454 [inline]
 extent_write_cache_pages fs/btrfs/extent_io.c:2130 [inline]
 btrfs_writepages+0x1157/0x2370 fs/btrfs/extent_io.c:2261
 do_writepages+0x35d/0x870 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:397
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 filemap_fdatawrite_range+0x120/0x180 mm/filemap.c:448
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888047514f00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888047514f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888047515000: fa fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
                         ^
 ffff888047515080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888047515100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

