Return-Path: <linux-btrfs+bounces-8900-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D4D99D405
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 17:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDAF2283980
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49651B85E1;
	Mon, 14 Oct 2024 15:56:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706891AC887
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921391; cv=none; b=rPTz74VChjh2SrGLAHLtI9alk7Y/c5JCkzl8IZhIP6FZfOZeJ1j9LPw/WAzQ5bXQSXNH8sC4/8idVn1DJskFCrBKjZEltIvwr23Xdn6g7kQXksIOS0OmCzQAAAPylhe4oKha0g1qChJufjp2/Zy4x2lmw9qhkk3SWkhNvn6e99Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921391; c=relaxed/simple;
	bh=AzM8yCudKL/4KeKny9ltyvt0QXG8orRcNq/+fyyPBtI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Xl78zALui0daIvuKXyciei/UfTfo/9+cBCTs1YEvwl8zIaKUFJbXdLdUUDHWDp3gA7tf/T/GftOvBJQaQ8TtQ879JQvgor52qnt3DYiIvDPtAAAS1RpAm1wDBKw9Yv+mjqvuBypru4zMBRNNkshXlDBMi2xHE5pdEz3ffMO85Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3466d220dso42885895ab.3
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 08:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728921388; x=1729526188;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yYF57znd3ki9dmfyxMDvoxK5mg2h780n/C12lu1gMM4=;
        b=DD9PtACyPSfIppfstlyDRatnIlvl9+VcqZDSxVnIo1Kp+bmWBoUYqmdLHgD6HVCSTw
         QUuj+T4nN62aSWLH8Kspl5DvfpjxXgPwvCOErxqM0j6lu5OAK3otpN6AlepYz9fbE7e0
         55wnhAO0dqI+2L4H4pPi5jTTNhUK3OBKSljUDSwdVlTk6eYzJPfiD8E8K9ckcqnhkDeE
         kVbkgB8wGjcFwgA/7xQWaWVIpPHeRxQiMkIuTvpDO/DeFWjw8pY05kS+NKEU+nDp6MsR
         ml/LIP9SCNZPllCLmyxt5cfkjdebR12sIfT7P6araAyPBVG11KdKgPQZVe2gwHLZP39a
         DX7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWC0rxfjH0GP45FDzSpaQrcWYjVVUApXePZLBUm+otiW4q5/JQ99cY2ebAzux8xRfdvwZw0rPeixh9ZzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQdHaoTdJm7PsqtU6a1pIbnYm203UlaYL7D1kwQqjPbnSBA7KF
	XGZWXO5EIDCM8cBVcCNCw4yLgDWQJ5xYQPjaP6yv2keMwxMH1DdshTRDaXw4r8NldMT2mLQOMiw
	KTS+e5jLXmo7GKMkPYgDsKE4wba3RzRYvB6gez898H7rbQOoaql1e0yY=
X-Google-Smtp-Source: AGHT+IHcm7AwL3u0sHOo7bJKHAjHxaxilCfKOYYwh8FM3EPouZSNgZoCIomO4hQ7pMgpHh2itQ/1+/B9SNz59e5bbwY3I5Wy9z4L
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cf:b0:3a0:8edc:d133 with SMTP id
 e9e14a558f8ab-3a3b5f94601mr102121005ab.9.1728921388510; Mon, 14 Oct 2024
 08:56:28 -0700 (PDT)
Date: Mon, 14 Oct 2024 08:56:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670d3f2c.050a0220.3e960.0066.GAE@google.com>
Subject: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in add_delayed_ref
From: syzbot <syzbot+c3a3a153f0190dca5be9@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d61a00525464 Add linux-next specific files for 20241011
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16f9a887980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8554528c7f4bf3fb
dashboard link: https://syzkaller.appspot.com/bug?extid=c3a3a153f0190dca5be9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1266c727980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ce9440580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f615720e9964/disk-d61a0052.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c4a45c7583c6/vmlinux-d61a0052.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d767ab86d0d0/bzImage-d61a0052.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e1c3551adc6e/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c3a3a153f0190dca5be9@syzkaller.appspotmail.com

BTRFS info (device loop0): first mount of filesystem 395ef67a-297e-477c-816d-cd80a5b93e5d
BTRFS info (device loop0): using sha256 (sha256-avx2) checksum algorithm
BTRFS info (device loop0): using free-space-tree
==================================================================
BUG: KASAN: slab-use-after-free in add_delayed_ref+0x12ca/0x1e00 fs/btrfs/delayed-ref.c:1077
Read of size 8 at addr ffff888027c83570 by task syz-executor406/11166

CPU: 1 UID: 0 PID: 11166 Comm: syz-executor406 Not tainted 6.12.0-rc2-next-20241011-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 add_delayed_ref+0x12ca/0x1e00 fs/btrfs/delayed-ref.c:1077
 btrfs_alloc_tree_block+0xdfb/0x1440 fs/btrfs/extent-tree.c:5209
 btrfs_force_cow_block+0x526/0x1da0 fs/btrfs/ctree.c:573
 btrfs_cow_block+0x35e/0xa40 fs/btrfs/ctree.c:754
 btrfs_search_slot+0xbdd/0x30d0 fs/btrfs/ctree.c:2116
 btrfs_insert_empty_items+0x9c/0x1a0 fs/btrfs/ctree.c:4314
 btrfs_create_new_inode+0xe27/0x1f60 fs/btrfs/inode.c:6344
 btrfs_create_common+0x1d4/0x2e0 fs/btrfs/inode.c:6578
 vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
 do_mkdirat+0x264/0x3a0 fs/namei.c:4280
 __do_sys_mkdirat fs/namei.c:4295 [inline]
 __se_sys_mkdirat fs/namei.c:4293 [inline]
 __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4293
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5219f05379
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5219eb3168 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f5219f8b6c8 RCX: 00007f5219f05379
RDX: 0000000000000000 RSI: 0000000020000200 RDI: 0000000000000005
RBP: 00007f5219f8b6c0 R08: 00007f5219eb36c0 R09: 0000000000000000
R10: 00007f5219eb36c0 R11: 0000000000000246 R12: 00007f5219f8b6cc
R13: 0000000000000016 R14: 00007fff9f716d90 R15: 00007fff9f716e78
 </TASK>

Allocated by task 11166:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4094 [inline]
 slab_alloc_node mm/slub.c:4143 [inline]
 kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4150
 add_delayed_ref+0x13a/0x1e00 fs/btrfs/delayed-ref.c:1020
 btrfs_alloc_tree_block+0xdfb/0x1440 fs/btrfs/extent-tree.c:5209
 btrfs_force_cow_block+0x526/0x1da0 fs/btrfs/ctree.c:573
 btrfs_cow_block+0x35e/0xa40 fs/btrfs/ctree.c:754
 btrfs_search_slot+0xbdd/0x30d0 fs/btrfs/ctree.c:2116
 btrfs_insert_empty_items+0x9c/0x1a0 fs/btrfs/ctree.c:4314
 btrfs_create_new_inode+0xe27/0x1f60 fs/btrfs/inode.c:6344
 btrfs_create_common+0x1d4/0x2e0 fs/btrfs/inode.c:6578
 vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
 do_mkdirat+0x264/0x3a0 fs/namei.c:4280
 __do_sys_mkdirat fs/namei.c:4295 [inline]
 __se_sys_mkdirat fs/namei.c:4293 [inline]
 __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4293
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 55:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2329 [inline]
 slab_free mm/slub.c:4588 [inline]
 kmem_cache_free+0x1a2/0x440 mm/slub.c:4690
 btrfs_put_delayed_ref_head fs/btrfs/delayed-ref.h:358 [inline]
 cleanup_ref_head fs/btrfs/extent-tree.c:1932 [inline]
 __btrfs_run_delayed_refs+0x3d34/0x4680 fs/btrfs/extent-tree.c:2113
 btrfs_run_delayed_refs+0xe3/0x2c0 fs/btrfs/extent-tree.c:2213
 btrfs_commit_transaction+0x4be/0x3740 fs/btrfs/transaction.c:2197
 btrfs_qgroup_rescan_worker+0x17ac/0x1c60 fs/btrfs/qgroup.c:3864
 btrfs_work_helper+0x390/0xc50 fs/btrfs/async-thread.c:314
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888027c83570
 which belongs to the cache btrfs_delayed_ref_head of size 328
The buggy address is located 0 bytes inside of
 freed 328-byte region [ffff888027c83570, ffff888027c836b8)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x27c82
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88802fe6a000 ffffea0001ecef00 dead000000000004
raw: 0000000000000000 0000000080140014 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88802fe6a000 ffffea0001ecef00 dead000000000004
head: 0000000000000000 0000000080140014 00000001f5000000 0000000000000000
head: 00fff00000000001 ffffea00009f2081 ffffffffffffffff 0000000000000000
head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5557, tgid 5556 (syz-executor406), ts 235052280151, free_ts 234997412486
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3129/0x3270 mm/page_alloc.c:3493
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4769
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x120 mm/slub.c:2399
 allocate_slab+0x5a/0x2f0 mm/slub.c:2565
 new_slab mm/slub.c:2618 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3805
 __slab_alloc+0x58/0xa0 mm/slub.c:3895
 __slab_alloc_node mm/slub.c:3970 [inline]
 slab_alloc_node mm/slub.c:4131 [inline]
 kmem_cache_alloc_noprof+0x268/0x380 mm/slub.c:4150
 add_delayed_ref+0x13a/0x1e00 fs/btrfs/delayed-ref.c:1020
 btrfs_free_tree_block+0x354/0xd80 fs/btrfs/extent-tree.c:3455
 btrfs_force_cow_block+0xf44/0x1da0 fs/btrfs/ctree.c:622
 btrfs_cow_block+0x35e/0xa40 fs/btrfs/ctree.c:754
 btrfs_search_slot+0xbdd/0x30d0 fs/btrfs/ctree.c:2116
 btrfs_insert_empty_items+0x9c/0x1a0 fs/btrfs/ctree.c:4314
 btrfs_create_new_inode+0xe27/0x1f60 fs/btrfs/inode.c:6344
page last free pid 5558 tgid 5558 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2674
 __slab_free+0x31b/0x3d0 mm/slub.c:4499
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4094 [inline]
 slab_alloc_node mm/slub.c:4143 [inline]
 kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4150
 getname_flags+0xb7/0x540 fs/namei.c:139
 do_sys_openat2+0xd2/0x1d0 fs/open.c:1409
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888027c83400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888027c83480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888027c83500: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fa fb
                                                             ^
 ffff888027c83580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888027c83600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

