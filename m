Return-Path: <linux-btrfs+bounces-15008-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 904D4AEA478
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 19:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2550A188A86B
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 17:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8485B2E7170;
	Thu, 26 Jun 2025 17:35:37 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8E81C5D55
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750959337; cv=none; b=Qu5EJoh9N5u5vq8edQYty1TqCQXG68o8HfMptMURFK9x1SJSJIixb2+iCSu2L4ndhi6mEZMlCxKXMYw6OIUog/Ir/F6ChcQmJNS0rnDbAPcYbzMcJsGsWuX/e39fkXx6zyJ1Z3UW3YLA2a41uhAeZicSgQtLKkM9uRqFJ10TyqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750959337; c=relaxed/simple;
	bh=XRpgJZJaDbblfzAjOZsZowY+pQiRxQMyHq67oRlYGLo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PsHrAZ270iCT8jfKh0a3+RZxmCl4g/43+mFtniRyoGBNZi7KNMO0lgo75kwsRSxsmBY/sGbHwjG4rfneCmkHxM9I6jqcZ7D41UibocV9ym0Id0jDThrTR658d+KZXX1HYwy76/E1Ty0raT8XgCwv5J7gTxYWT7xaJfwTgA2drwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ddc5137992so13959745ab.2
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 10:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750959334; x=1751564134;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TU197a3JfH+4pS4vtdq7wZCi16xhDkdjrNkV8+wYE64=;
        b=Hs2lYRhNtYZ2EikVFuX2O6DVCqAt9Oo/Kt6PV1wll33Rhv/xi9OziKoB2dU9OE/jvK
         80/3w6Q3Y7wTCerpREn9qdsBuvMHqu4f22Qcmd9NDxaVJqi2Wwy6teTbl2oAMoKgrrk5
         hNXoXTFVf9nsmA4fCqBtu9Uw9PItyWV/zy69UfCNdgjGfrDyOyeZAhQXxGRlf4YUmbWa
         O6vjLn+T6ChoknJ9A5VbIA8ygPhy5awGwk5Or/2JHzE2IMoAKAbqDlCDnRlBIMSHFmiw
         Rh0SdVbJQDrnr62JcdBK5nPStNJVrLb2f/vhGIb2lot70tejCjpF9/UdjWEczQGXhnSt
         SGCg==
X-Forwarded-Encrypted: i=1; AJvYcCVXZS81MV9s7qQwMVgnzL8ZsfzO/tajJJCNjF/X2g0ZRcGLq24HmAvDPi5DkbC33imWE3Q9xs2oaJTu7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLyrulVaz3SekEPRIFtxnJickSrmwX7vyqyYyg0+q8YAuICEW8
	Qp8Eg9hcZBGaOKwmsS4JXV4+R9M4+W7JsSBhB2p/e/N0V8EqOs7K8IYeI+PafL9Ie7m2RdL5FIH
	wQkibBBFysfqtM2e3+JtNjcWuT6ms8tab9hxVFmhPma7qPBK9T9krVG4rqhs=
X-Google-Smtp-Source: AGHT+IFODPi3tMIWSSJBeVS5eH3z6jHwUwrvgQptMdeT6s7HrAaMEpvfN+AackGuVMOdcNPixcMjbVX3yW3LGo0r2u8pfwdI19g4
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b49:b0:3df:3a07:a208 with SMTP id
 e9e14a558f8ab-3df4ab2b877mr4185535ab.4.1750959334450; Thu, 26 Jun 2025
 10:35:34 -0700 (PDT)
Date: Thu, 26 Jun 2025 10:35:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685d84e6.a00a0220.2e5631.02e4.GAE@google.com>
Subject: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in close_fs_devices
From: syzbot <syzbot+772bdfe41846e057fa83@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ecb259c4f70d Add linux-next specific files for 20250626
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11147182580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f0c48ed70f20d0d2
dashboard link: https://syzkaller.appspot.com/bug?extid=772bdfe41846e057fa83
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a6a71f1563ce/disk-ecb259c4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/914a0673e6a0/vmlinux-ecb259c4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/87f7194e2a0e/bzImage-ecb259c4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+772bdfe41846e057fa83@syzkaller.appspotmail.com

BTRFS: device fsid a6a605fc-d5f1-4e66-8595-3726e2b761d6 devid 1 transid 8 /dev/loop4 (7:4) scanned by syz.4.616 (8589)
==================================================================
BUG: KASAN: slab-use-after-free in close_fs_devices+0x81f/0x870 fs/btrfs/volumes.c:1182
Read of size 4 at addr ffff88802fe14930 by task syz.4.616/8589

CPU: 0 UID: 0 PID: 8589 Comm: syz.4.616 Not tainted 6.16.0-rc3-next-20250626-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xd2/0x2b0 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 close_fs_devices+0x81f/0x870 fs/btrfs/volumes.c:1182
 btrfs_close_devices+0xc5/0x560 fs/btrfs/volumes.c:1201
 btrfs_free_fs_info+0x4f/0x3c0 fs/btrfs/disk-io.c:1250
 deactivate_locked_super+0xbc/0x130 fs/super.c:474
 btrfs_get_tree_super fs/btrfs/super.c:-1 [inline]
 btrfs_get_tree_subvol fs/btrfs/super.c:2073 [inline]
 btrfs_get_tree+0xd1e/0x17f0 fs/btrfs/super.c:2107
 vfs_get_tree+0x92/0x2b0 fs/super.c:1804
 do_new_mount+0x24a/0xa40 fs/namespace.c:3902
 do_mount fs/namespace.c:4239 [inline]
 __do_sys_mount fs/namespace.c:4450 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4427
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fedccd900ca
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fedcdc28e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fedcdc28ef0 RCX: 00007fedccd900ca
RDX: 00002000000055c0 RSI: 0000200000005600 RDI: 00007fedcdc28eb0
RBP: 00002000000055c0 R08: 00007fedcdc28ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000200000005600
R13: 00007fedcdc28eb0 R14: 000000000000559d R15: 0000200000000440
 </TASK>

Allocated by task 8589:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4396
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 alloc_fs_devices+0x4f/0x1d0 fs/btrfs/volumes.c:384
 device_list_add+0x6b7/0x20b0 fs/btrfs/volumes.c:813
 btrfs_scan_one_device+0x3fd/0x5b0 fs/btrfs/volumes.c:1487
 btrfs_get_tree_super fs/btrfs/super.c:1856 [inline]
 btrfs_get_tree_subvol fs/btrfs/super.c:2073 [inline]
 btrfs_get_tree+0x433/0x17f0 fs/btrfs/super.c:2107
 vfs_get_tree+0x92/0x2b0 fs/super.c:1804
 do_new_mount+0x24a/0xa40 fs/namespace.c:3902
 do_mount fs/namespace.c:4239 [inline]
 __do_sys_mount fs/namespace.c:4450 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4427
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 7454:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free mm/slub.c:4680 [inline]
 kfree+0x18e/0x440 mm/slub.c:4879
 btrfs_free_stale_devices+0x61c/0x6b0 fs/btrfs/volumes.c:564
 btrfs_scan_one_device+0x3d5/0x5b0 fs/btrfs/volumes.c:1481
 btrfs_control_ioctl+0x11f/0x360 fs/btrfs/super.c:2256
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802fe14800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 304 bytes inside of
 freed 512-byte region [ffff88802fe14800, ffff88802fe14a00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2fe14
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801a441c80 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801a441c80 0000000000000000 dead000000000001
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea0000bf8501 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5205, tgid 5205 (udevadm), ts 34630804861, free_ts 34502396580
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1848
 prep_new_page mm/page_alloc.c:1856 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3855
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5145
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2419
 alloc_slab_page mm/slub.c:2487 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2655
 new_slab mm/slub.c:2709 [inline]
 ___slab_alloc+0xbeb/0x1410 mm/slub.c:3891
 __slab_alloc mm/slub.c:3981 [inline]
 __slab_alloc_node mm/slub.c:4056 [inline]
 slab_alloc_node mm/slub.c:4217 [inline]
 __kmalloc_cache_noprof+0x296/0x3d0 mm/slub.c:4391
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 kernfs_fop_open+0x397/0xca0 fs/kernfs/file.c:623
 do_dentry_open+0xdf3/0x1970 fs/open.c:964
 vfs_open+0x3b/0x340 fs/open.c:1094
 do_open fs/namei.c:3887 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4046
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1434
 do_sys_open fs/open.c:1449 [inline]
 __do_sys_openat fs/open.c:1465 [inline]
 __se_sys_openat fs/open.c:1460 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1460
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5205 tgid 5205 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1392 [inline]
 __free_frozen_pages+0xb80/0xd80 mm/page_alloc.c:2892
 __slab_free+0x303/0x3c0 mm/slub.c:4591
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 __do_kmalloc_node mm/slub.c:4364 [inline]
 __kmalloc_noprof+0x224/0x4f0 mm/slub.c:4377
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kernfs_fop_write_iter+0x158/0x4f0 fs/kernfs/file.c:311
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x54b/0xa90 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802fe14800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802fe14880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802fe14900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88802fe14980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802fe14a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

