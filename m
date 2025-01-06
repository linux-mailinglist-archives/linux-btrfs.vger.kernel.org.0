Return-Path: <linux-btrfs+bounces-10729-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F54A01D10
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 02:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98DA57A030D
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 01:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5FA4EB48;
	Mon,  6 Jan 2025 01:43:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BA817C
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Jan 2025 01:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736127803; cv=none; b=jU2fikVln9X/60lalBxFs25Ytkydk9vv37iicpZziD6I6DAFLytl7pDxuILqEukOvUvhKUh1T6fH5/q8Sh2+Jd4t80tSEsQKGXnA4dSRj5afIqy4NW1/pyiXkqtvFlTca0Rd4tkto91DAh/Ra4qj5PLlqdth/l6aju/AfvMWhEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736127803; c=relaxed/simple;
	bh=QQo21dYyvhTeY6tsD9Av8TLESaBIDLlDBlI+ottv2YY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PJ50w9vQy55uk0H/UCTVUlnoc3o02zx8zK37lp1qoJtt8l/LcdHuVSTXyPRvyK6iFQlmdFaCuuU32mFOvF7ZSAQJj/QIG6DI4aVJZipbraBJl1EcVYtywETbmK9WxL2aZXSevGexCSuETqXE/AcKP2xIGwm2y+A3Lw2QEnRCaEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a7d85ab308so137171725ab.3
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Jan 2025 17:43:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736127800; x=1736732600;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bzk4paH1CMhQCPP3To/ofQgsIKJl7IQ93lpUWhF35uI=;
        b=Jw96rH/tL/azpiPtgjmje/0SSxSV8rwmhAI38RRbYDUEjxX9pzRbbDXt+4MjK4K74/
         0HuYOAXq7z4URZw4tPRwllLMfr2J1ImeEUor3bqCPJjSY+1cx5Gx78pmvXSEF7NzD7TI
         V04+UxQd7/3CMsn2ZzD14fW/rjBy4WZACV6+kSvjCHxJUoeqRdgtiuno5CqFYnYuXVDo
         qPZwL7OLK4afYNSVFMgd36mwK14OVN0SUVrrNN9bN/rWZa1KBXNLLpn5eQmqWcklGdvv
         ND4R7FyUxZD+vdpOzmeGrjYcmUyeejjKi8pWh6rEYOOJgWAODw5ZXA3o/3FULlD3s/SE
         p4RA==
X-Forwarded-Encrypted: i=1; AJvYcCX03gN/aV3H9sYWrmnc6IRGRBoUpEYxWyMZveldRMakGwD7WY0hoVVVyE5WSssp7cyeY5/z/EkA8safFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoniGCzrNzii55HI86iDw72uH7ynPtdu/trqBQCKdmhAIzt5p4
	8kVnhZD0tWLuAce8CVHwBOBqjerF1Gx6PpMViMBVPhimR3zfkSAtL05K2VnVNuUBoRMBtiVS3ct
	Bqg3+/8n8yBUKE0dHrE/9beirkhR4TQhFp/CwjFEG7QobCRKRuLtX40I=
X-Google-Smtp-Source: AGHT+IEyAzSRep2V+dgfFtojsFxdAjw7giPcir8FpRxCs+K+aROghxLCwJCv4WGdO8RGeM5uDeXKigVj0XlWu6mMGxqrkXCgedUZ
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2c:b0:3a7:e286:a572 with SMTP id
 e9e14a558f8ab-3c2d14d19d2mr518430975ab.3.1736127800667; Sun, 05 Jan 2025
 17:43:20 -0800 (PST)
Date: Sun, 05 Jan 2025 17:43:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677b3538.050a0220.3b53b0.0065.GAE@google.com>
Subject: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in btrfs_backref_cleanup_node
From: syzbot <syzbot+b7694c9988ea48719f93@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ab75170520d4 Merge tag 'linux-watchdog-6.13-rc6' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=128104b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c541fa8af5c9cc7
dashboard link: https://syzkaller.appspot.com/bug?extid=b7694c9988ea48719f93
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-ab751705.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/81d0d11be3bd/vmlinux-ab751705.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1f076be686f8/bzImage-ab751705.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b7694c9988ea48719f93@syzkaller.appspotmail.com

BTRFS info (device loop0): balance: start -d -m
BTRFS info (device loop0): relocating block group 6881280 flags data|metadata
BTRFS info (device loop0): relocating block group 5242880 flags data|metadata
==================================================================
BUG: KASAN: slab-use-after-free in list_empty include/linux/list.h:373 [inline]
BUG: KASAN: slab-use-after-free in btrfs_backref_cleanup_node+0x2ea/0x4a0 fs/btrfs/backref.c:3154
Read of size 8 at addr ffff888000d4f050 by task syz.0.0/5342

CPU: 0 UID: 0 PID: 5342 Comm: syz.0.0 Not tainted 6.13.0-rc5-syzkaller-00163-gab75170520d4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 list_empty include/linux/list.h:373 [inline]
 btrfs_backref_cleanup_node+0x2ea/0x4a0 fs/btrfs/backref.c:3154
 btrfs_backref_release_cache+0xbb/0x720 fs/btrfs/backref.c:3180
 relocate_block_group+0xabf/0xd40 fs/btrfs/relocation.c:3741
 btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4087
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
RIP: 0033:0x7f3be4b85d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3be45dd038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f3be4d76160 RCX: 00007f3be4b85d29
RDX: 0000000020000180 RSI: 00000000c4009420 RDI: 0000000000000008
RBP: 00007f3be4c01b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f3be4d76160 R15: 00007fff6101e6a8
 </TASK>

Allocated by task 5342:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4329
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 btrfs_backref_alloc_node fs/btrfs/backref.c:3040 [inline]
 handle_indirect_tree_backref fs/btrfs/backref.c:3397 [inline]
 btrfs_backref_add_tree_node+0x16d2/0x2ed0 fs/btrfs/backref.c:3567
 build_backref_tree+0x2bc/0xf30 fs/btrfs/relocation.c:434
 relocate_tree_blocks+0x790/0x1dd0 fs/btrfs/relocation.c:2705
 relocate_block_group+0x755/0xd40 fs/btrfs/relocation.c:3686
 btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4087
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

Freed by task 5342:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kfree+0x196/0x430 mm/slub.c:4761
 btrfs_backref_release_cache+0x5a/0x720 fs/btrfs/backref.c:3174
 relocate_block_group+0xabf/0xd40 fs/btrfs/relocation.c:3741
 btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4087
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

The buggy address belongs to the object at ffff888000d4f000
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 80 bytes inside of
 freed 128-byte region [ffff888000d4f000, ffff888000d4f080)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xd4f
flags: 0x7ff00000000000(node=0|zone=0|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 007ff00000000000 ffff88801ac41a00 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5342, tgid 5320 (syz.0.0), ts 78052212500, free_ts 77737190918
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1558
 prep_new_page mm/page_alloc.c:1566 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3476
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4753
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2269
 alloc_slab_page+0x6a/0x110 mm/slub.c:2423
 allocate_slab+0x5a/0x2b0 mm/slub.c:2589
 new_slab mm/slub.c:2642 [inline]
 ___slab_alloc+0xc27/0x14a0 mm/slub.c:3830
 __slab_alloc+0x58/0xa0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 __kmalloc_cache_noprof+0x27b/0x390 mm/slub.c:4324
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 btrfs_backref_alloc_node fs/btrfs/backref.c:3040 [inline]
 handle_indirect_tree_backref fs/btrfs/backref.c:3397 [inline]
 btrfs_backref_add_tree_node+0x16d2/0x2ed0 fs/btrfs/backref.c:3567
 build_backref_tree+0x2bc/0xf30 fs/btrfs/relocation.c:434
 relocate_tree_blocks+0x790/0x1dd0 fs/btrfs/relocation.c:2705
 relocate_block_group+0x755/0xd40 fs/btrfs/relocation.c:3686
 btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4087
 btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3494
 __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4278
page last free pid 5323 tgid 5323 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xd3f/0x1010 mm/page_alloc.c:2659
 discard_slab mm/slub.c:2688 [inline]
 __put_partials+0x160/0x1c0 mm/slub.c:3157
 put_cpu_partial+0x17c/0x250 mm/slub.c:3232
 __slab_free+0x290/0x380 mm/slub.c:4483
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4119 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4175
 getname_flags+0xb7/0x540 fs/namei.c:139
 getname fs/namei.c:223 [inline]
 __do_sys_symlink fs/namei.c:4716 [inline]
 __se_sys_symlink fs/namei.c:4714 [inline]
 __x64_sys_symlink+0x5d/0x90 fs/namei.c:4714
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888000d4ef00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888000d4ef80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888000d4f000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                 ^
 ffff888000d4f080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888000d4f100: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
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

