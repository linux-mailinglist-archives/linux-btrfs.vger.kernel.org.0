Return-Path: <linux-btrfs+bounces-8068-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B8097A4B1
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 17:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857081C25B5B
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 15:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB525165F1C;
	Mon, 16 Sep 2024 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEbhhVSg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F178E165EF5;
	Mon, 16 Sep 2024 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726498783; cv=none; b=O+sO2uDVu3vuV+caoWk3LPiQHZEEPBQ4DEuei3eySNyGhfxuBv3a+huMui6fAvCBWADlELtKkx8vP/TP4S82G2shuOoTkQpl6Y9I07dV102ZzREAcNnznsDZPGetz5r1UrEAIGmkeiCbOerDCewJmuzJ8q+42nogU7wNtpCWde4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726498783; c=relaxed/simple;
	bh=inlSozKf106dAe82l1NnzDHN0QuBp0EWI2GVGSPDhrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3hQF4I3JDcTbhrpIgLzGy/eBPdepgqAKujek4QXfzoMo7w+V2YcqEteAgzyFBLlUD+lVn4aFordi5CPwgSZK7qMc9yZQYpH4Gl229bnTX4R0Lt23SgMT1G7gu88vclqAt4h2/V3X4mk2PEqSy2Rfx42XEv/Ve0OrIZhQv8JBak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEbhhVSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF52AC4CECC;
	Mon, 16 Sep 2024 14:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726498782;
	bh=inlSozKf106dAe82l1NnzDHN0QuBp0EWI2GVGSPDhrM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OEbhhVSgxx9mkFlMCd+WguT9P6jcTWVxgVfn/o7Leh+d1NVWOaU155pjBR1FqsTOd
	 F0AmfBSPN+fQQN2FS7XcuBDlCLJ5iGYZueD+05wEDKAZse5z+euR61ZOW7iR968Ob/
	 uvYAxho+aAg4EEUOgTdDjEGYt6+wb0t9ehASJILfGVBbNZ8q6Acmvenu1/7JaPXTEr
	 Fz6s/7YoJCwUof6hLQeng0QiF+U+8bHznzrLg3k4FyMPEPxQ3epA0j408+pUVLYKLt
	 rGKDD5cy+tX/ulwhoVWHKX6Z9Z2ue1Edobno7jdNCE6xbtWTg3IuBhDQgYU2SFPLX6
	 9mb9O4K4ffXTQ==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so743600966b.1;
        Mon, 16 Sep 2024 07:59:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHwjvyN24D2hEVvPefQmk2f2P+T3TVzKLFNkNoFMURDkwgeR3+A3G8ZgUD7Vw1X6hBF4wxSZkNumNHzQMJ@vger.kernel.org, AJvYcCVSs/Wlko+6KH0xJdEOoFYZAT4wf0tRzrZPH+FVsXlE9mcPwrFyC7kcIfFdSHB5JbMU5ZVipEnX+1QEaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVJPxKUfx7pQ3tD2OKbrnyzkBQ40oD8cJkJknQ3e1giJo+N8EK
	4kWNRgPeF6k+JLVqZAZC3HQid+BuhSY2R2vaLu3TGfxWvhKvaBxVC66pvGd++DMk8JuBlke78BE
	qAtU2DuwmDmWQm0Fi06hSQ/T3+YI=
X-Google-Smtp-Source: AGHT+IHK4dxQdYX6k6W/pErk/ZsqDsIUsGJ2BVSj6yIYleY62XcyepKQneEHizyWAq2x3rrVVbYkmpdNk5BNqaIwbz8=
X-Received: by 2002:a17:907:e69a:b0:a7a:9144:e256 with SMTP id
 a640c23a62f3a-a90293dc29dmr1529364066b.6.1726498781309; Mon, 16 Sep 2024
 07:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003bc82506223d9c64@google.com>
In-Reply-To: <0000000000003bc82506223d9c64@google.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 16 Sep 2024 15:59:04 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6mj2ftRYvq3RKjwa18E2V4_NOqOgWZZFxLQPy049T47A@mail.gmail.com>
Message-ID: <CAL3q7H6mj2ftRYvq3RKjwa18E2V4_NOqOgWZZFxLQPy049T47A@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in btrfs_cleanup_defrag_inodes
To: syzbot <syzbot+ad7966ca1f5dd8b001b3@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 3:44=E2=80=AFPM syzbot
<syzbot+ad7966ca1f5dd8b001b3@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    adfc3ded5c33 Merge tag 'for-6.12/io_uring-discard-2024091=
3..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1013a29f98000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6f94136b4da4e=
897
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dad7966ca1f5dd8b=
001b3
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4d908436e309/dis=
k-adfc3ded.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c7ab09b5ccee/vmlinu=
x-adfc3ded.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/fa3017710376/b=
zImage-adfc3ded.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+ad7966ca1f5dd8b001b3@syzkaller.appspotmail.com
>
> BTRFS info (device loop3 state EA): last unmount of filesystem ed167579-e=
b65-4e76-9a50-61ac97e9b59d
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in rb_left_deepest_node lib/rbtree.c:595 =
[inline]
> BUG: KASAN: slab-use-after-free in rb_first_postorder+0x69/0x90 lib/rbtre=
e.c:628
> Read of size 8 at addr ffff888056652010 by task syz-executor/11584
>
> CPU: 1 UID: 0 PID: 11584 Comm: syz-executor Not tainted 6.11.0-syzkaller-=
02520-gadfc3ded5c33 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/06/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:93 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  rb_left_deepest_node lib/rbtree.c:595 [inline]
>  rb_first_postorder+0x69/0x90 lib/rbtree.c:628
>  btrfs_cleanup_defrag_inodes+0x2f/0x80 fs/btrfs/defrag.c:212
>  close_ctree+0x2af/0xd20 fs/btrfs/disk-io.c:4256
>  generic_shutdown_super+0x139/0x2d0 fs/super.c:642
>  kill_anon_super+0x3b/0x70 fs/super.c:1237
>  btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2121
>  deactivate_locked_super+0xc4/0x130 fs/super.c:473
>  cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
>  task_work_run+0x24f/0x310 kernel/task_work.c:228
>  exit_task_work include/linux/task_work.h:40 [inline]
>  do_exit+0xa2f/0x27f0 kernel/exit.c:882
>  do_group_exit+0x207/0x2c0 kernel/exit.c:1031
>  __do_sys_exit_group kernel/exit.c:1042 [inline]
>  __se_sys_exit_group kernel/exit.c:1040 [inline]
>  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
>  x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:=
232
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f6e26d7def9
> Code: Unable to access opcode bytes at 0x7f6e26d7decf.
> RSP: 002b:00007ffc1e161938 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 00007f6e26df0a86 RCX: 00007f6e26d7def9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
> RBP: 0000000000000010 R08: 00007ffc1e15f6d6 R09: 00007ffc1e162bf0
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc1e162bf0
> R13: 00007f6e26df0a14 R14: 000055555899a4a8 R15: 00007ffc1e163cb0
>  </TASK>
>
> Allocated by task 11:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  unpoison_slab_object mm/kasan/common.c:312 [inline]
>  __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
>  kasan_slab_alloc include/linux/kasan.h:201 [inline]
>  slab_post_alloc_hook mm/slub.c:3989 [inline]
>  slab_alloc_node mm/slub.c:4038 [inline]
>  kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4045
>  btrfs_add_inode_defrag+0x15c/0x790 fs/btrfs/defrag.c:136
>  inode_should_defrag fs/btrfs/inode.c:888 [inline]
>  cow_file_range+0x380/0x11f0 fs/btrfs/inode.c:1382
>  btrfs_run_delalloc_range+0x33d/0xf70 fs/btrfs/inode.c:2334
>  writepage_delalloc+0x482/0x7d0 fs/btrfs/extent_io.c:1192
>  extent_writepage fs/btrfs/extent_io.c:1454 [inline]
>  extent_write_cache_pages fs/btrfs/extent_io.c:2130 [inline]
>  btrfs_writepages+0x1157/0x2370 fs/btrfs/extent_io.c:2261
>  do_writepages+0x35d/0x870 mm/page-writeback.c:2683
>  __writeback_single_inode+0x14f/0x10d0 fs/fs-writeback.c:1658
>  writeback_sb_inodes+0x812/0x1370 fs/fs-writeback.c:1954
>  wb_writeback+0x41b/0xbd0 fs/fs-writeback.c:2134
>  wb_do_writeback fs/fs-writeback.c:2281 [inline]
>  wb_workfn+0x410/0x1090 fs/fs-writeback.c:2321
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3393
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Freed by task 11917:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>  poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
>  __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
>  kasan_slab_free include/linux/kasan.h:184 [inline]
>  slab_free_hook mm/slub.c:2250 [inline]
>  slab_free mm/slub.c:4474 [inline]
>  kmem_cache_free+0x145/0x350 mm/slub.c:4549
>  btrfs_cleanup_defrag_inodes+0x51/0x80 fs/btrfs/defrag.c:214
>  btrfs_remount_cleanup fs/btrfs/super.c:1263 [inline]
>  btrfs_reconfigure+0x269c/0x2d40 fs/btrfs/super.c:1555
>  reconfigure_super+0x445/0x880 fs/super.c:1083
>  do_remount fs/namespace.c:3047 [inline]
>  path_mount+0xc22/0xfa0 fs/namespace.c:3826
>  do_mount fs/namespace.c:3847 [inline]
>  __do_sys_mount fs/namespace.c:4055 [inline]
>  __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> The buggy address belongs to the object at ffff888056652000
>  which belongs to the cache btrfs_inode_defrag of size 56
> The buggy address is located 16 bytes inside of
>  freed 56-byte region [ffff888056652000, ffff888056652038)
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5665=
2
> flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> page_type: 0xfdffffff(slab)
> raw: 00fff00000000000 ffff888030f77780 dead000000000122 0000000000000000
> raw: 0000000000000000 00000000802e002e 00000001fdffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152c40=
(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL), pid 62, tg=
id 62 (kworker/u8:4), ts 261251744217, free_ts 261164089851
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1500
>  prep_new_page mm/page_alloc.c:1508 [inline]
>  get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3446
>  __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4702
>  __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
>  alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
>  alloc_slab_page+0x5f/0x120 mm/slub.c:2319
>  allocate_slab+0x5a/0x2f0 mm/slub.c:2482
>  new_slab mm/slub.c:2535 [inline]
>  ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3721
>  __slab_alloc+0x58/0xa0 mm/slub.c:3811
>  __slab_alloc_node mm/slub.c:3864 [inline]
>  slab_alloc_node mm/slub.c:4026 [inline]
>  kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4045
>  btrfs_add_inode_defrag+0x15c/0x790 fs/btrfs/defrag.c:136
>  inode_should_defrag fs/btrfs/inode.c:888 [inline]
>  compress_file_range+0x2ef/0x1300 fs/btrfs/inode.c:945
>  btrfs_work_helper+0x390/0xc50 fs/btrfs/async-thread.c:314
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3393
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> page last free pid 7513 tgid 7512 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1101 [inline]
>  free_unref_page+0xd19/0xea0 mm/page_alloc.c:2619
>  stack_depot_save_flags+0x6f6/0x830 lib/stackdepot.c:666
>  kasan_save_stack mm/kasan/common.c:48 [inline]
>  kasan_save_track+0x51/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
>  kasan_kmalloc include/linux/kasan.h:211 [inline]
>  __do_kmalloc_node mm/slub.c:4159 [inline]
>  __kmalloc_noprof+0x1fc/0x400 mm/slub.c:4171
>  kmalloc_noprof include/linux/slab.h:694 [inline]
>  hfsplus_find_init+0x85/0x1c0 fs/hfsplus/bfind.c:21
>  hfsplus_lookup+0x1ae/0xc70 fs/hfsplus/dir.c:44
>  lookup_one_qstr_excl+0x11f/0x260 fs/namei.c:1633
>  filename_create+0x297/0x540 fs/namei.c:4027
>  do_mkdirat+0xbd/0x3a0 fs/namei.c:4272
>  __do_sys_mkdirat fs/namei.c:4295 [inline]
>  __se_sys_mkdirat fs/namei.c:4293 [inline]
>  __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4293
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Memory state around the buggy address:
>  ffff888056651f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff888056651f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffff888056652000: fa fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
>                          ^
>  ffff888056652080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff888056652100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title

#syz btrfs: fix use-after-free on rbtree that tracks inodes for auto defrag

https://lore.kernel.org/linux-btrfs/743f120462032370c7ae8ff899bfd8dbfb0ed00=
6.1726486545.git.fdmanana@suse.com/

>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

