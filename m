Return-Path: <linux-btrfs+bounces-20027-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE142CE0145
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Dec 2025 20:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 268EF301B2E4
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Dec 2025 19:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620E9218AA0;
	Sat, 27 Dec 2025 19:03:20 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C919156CA
	for <linux-btrfs@vger.kernel.org>; Sat, 27 Dec 2025 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766862200; cv=none; b=PtBHW5jvX3oxIU/DFMLSq6JxjUV76AlOKx8JP0zwqFzH2+/c8zG3CYaOCK8KGKvltkL/CW29SIrBiKrtzQawYtxVYw9o1bg/cjkGZRtDopA/jxCUU+gGtQyliBCbGSnulwBkdlu22MFeeriVvYBbCcgeMygbmkemKeZr/SbTwqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766862200; c=relaxed/simple;
	bh=S5ofOxQGA3txAcN4240VAJPbRgADNteZobLNv6bjERk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WhW1pxbAQfwpC9xyxEvzM8vN7q6DeSj0dqusluyMDTV4SELjdWMQ3JlTu1OctWmaHQ/vTgXb9V+R5vvU8n96iIqIEfZsVpzQGS5NQm4qC3KqIlpO3R3xjrICmK7b9qsCLXDmhuQSq9JbACAG8ou+KfXVpdNs3/mbzrY+DeeXbso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-6574d564a9eso14456667eaf.2
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Dec 2025 11:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766862197; x=1767466997;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vP9kyigWsNRBs7Ukm1ULwW89i666suHzh82NKq/WSVo=;
        b=ilKWTmH1XHHI/Q++Z5M3ogmryJiOzBG5c+CAeBXYXn4kwhAoaMqzP3CgKV5VMvM+yu
         t8z7ICUslGpcUrqEfA+kxPY9rhTQkKs1/oLxoFsgWPtp3l7qxDi62IC98MCpkxroaEHO
         ZOAwtyWWM9SrQQWqkvFSNRgulA0NH+FJM6JI1Ps7ADD+Cl15jezy6nVOp7dD2t7Mo/rW
         dZSGMTkAPjzYexiZQnu5KmLgzh8hGb4FkCwK+VUr2KWzT5nRGw9QQjodkQ11M8fkHZU9
         vetvg+jJjCFUn0pdjw1mWlzQN6+XsNz0omR3m8IzZIE/TViLe7aXcSNMs0K1oA7nx6VF
         gC1A==
X-Forwarded-Encrypted: i=1; AJvYcCXLoUx1OfFQP/poutA1//B9B9C+78AN2E1KkUYus8eQR7ldU7PLbgTPaG+ydy5NuPXFfL7RU+vz2JOE/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVtez8u3sS2biE/sgXGRMLafbO8oYuJYM3USzjbe4xZy3DMeLp
	ZaslyLwdPm9Hgm8JAzM5w7I7RjRTKrEVM02ofQ7MEMbcDv6UgGi/3z6HMgeI/cYp70mTvl1jKnp
	IgDvv7Q+s7sP6j5Y/Unuy42EojtvgA0XAmJBoiwVhtGRBWjIf67VwynmQxx4=
X-Google-Smtp-Source: AGHT+IEk6DjgqueSGHbHMAju7kwic2TmHfgs66H2TTnA2Tvwz8pJAvUPTS5WU2+RXKrObLY/Fh8/dALPemj/OcYpb99QLSQIpMHZ
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4289:b0:65d:163:3ea with SMTP id
 006d021491bc7-65d0e94d67emr8765307eaf.5.1766862197143; Sat, 27 Dec 2025
 11:03:17 -0800 (PST)
Date: Sat, 27 Dec 2025 11:03:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69502d75.050a0220.35954c.0098.GAE@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in submit_compressed_extents
From: syzbot <syzbot+6bcfce568a4af2a909bc@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b927546677c8 Merge tag 'dma-mapping-6.19-2025-12-22' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1600df1a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=513255d80ab78f2b
dashboard link: https://syzkaller.appspot.com/bug?extid=6bcfce568a4af2a909bc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-b9275466.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/16f89c42bab9/vmlinux-b9275466.xz
kernel image: https://storage.googleapis.com/syzbot-assets/54c5ab9b0ef0/bzImage-b9275466.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6bcfce568a4af2a909bc@syzkaller.appspotmail.com

page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x6a1
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x7ff00000000040(head|node=0|zone=0|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 007ff00000000001 ffffea000001a801 00000000ffffffff 00000000ffffffff
raw: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
head: 007ff00000000040 ffff888040d47dc0 dead000000000122 0000000000000000
head: 0000000000000000 00000000800a000a 00000000f5000000 0000000000000000
head: 007ff00000000001 ffffea000001a801 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: VM_BUG_ON_PAGE(page->compound_head & 1)
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd2800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2676, tgid 2676 (kworker/u4:12), ts 86875534140, free_ts 86855865505
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x234/0x290 mm/page_alloc.c:1846
 prep_new_page mm/page_alloc.c:1854 [inline]
 get_page_from_freelist+0x24e0/0x2580 mm/page_alloc.c:3915
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5210
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2486
 alloc_slab_page mm/slub.c:3075 [inline]
 allocate_slab+0x86/0x3b0 mm/slub.c:3248
 new_slab mm/slub.c:3302 [inline]
 ___slab_alloc+0xe53/0x1820 mm/slub.c:4656
 __slab_alloc+0x65/0x100 mm/slub.c:4779
 __slab_alloc_node mm/slub.c:4855 [inline]
 slab_alloc_node mm/slub.c:5251 [inline]
 kmem_cache_alloc_noprof+0x40f/0x710 mm/slub.c:5270
 mempool_alloc_noprof+0x1c9/0x2f0 mm/mempool.c:567
 bio_alloc_bioset+0x337/0x14e0 block/bio.c:561
 alloc_compressed_bio fs/btrfs/compression.c:68 [inline]
 btrfs_submit_compressed_write+0x16f/0x430 fs/btrfs/compression.c:382
 submit_one_async_extent fs/btrfs/inode.c:1188 [inline]
 submit_compressed_extents+0xe7a/0x1670 fs/btrfs/inode.c:1599
 run_ordered_work fs/btrfs/async-thread.c:243 [inline]
 btrfs_work_helper+0x564/0xbf0 fs/btrfs/async-thread.c:322
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
 kthread+0x711/0x8a0 kernel/kthread.c:463
page last free pid 78 tgid 78 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 free_unref_folios+0xdb3/0x14f0 mm/page_alloc.c:3000
 shrink_folio_list+0x4800/0x5010 mm/vmscan.c:1603
 evict_folios+0x473e/0x57f0 mm/vmscan.c:4711
 try_to_shrink_lruvec+0x8a3/0xb50 mm/vmscan.c:4874
 shrink_one+0x25c/0x720 mm/vmscan.c:4919
 shrink_many mm/vmscan.c:4982 [inline]
 lru_gen_shrink_node mm/vmscan.c:5060 [inline]
 shrink_node+0x2f7d/0x35b0 mm/vmscan.c:6047
 kswapd_shrink_node mm/vmscan.c:6901 [inline]
 balance_pgdat mm/vmscan.c:7084 [inline]
 kswapd+0x145a/0x2820 mm/vmscan.c:7354
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
------------[ cut here ]------------
kernel BUG at ./include/linux/page-flags.h:351!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 2676 Comm: kworker/u4:12 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: btrfs-delalloc btrfs_work_helper
RIP: 0010:const_folio_flags include/linux/page-flags.h:351 [inline]
RIP: 0010:folio_test_head include/linux/page-flags.h:844 [inline]
RIP: 0010:folio_test_large include/linux/page-flags.h:865 [inline]
RIP: 0010:folio_order include/linux/mm.h:1246 [inline]
RIP: 0010:folio_size include/linux/mm.h:2354 [inline]
RIP: 0010:submit_one_async_extent fs/btrfs/inode.c:1128 [inline]
RIP: 0010:submit_compressed_extents+0x161a/0x1670 fs/btrfs/inode.c:1599
Code: 8c 9d 53 fe 4d 8b 1e 4c 89 ff 2e 2e 2e 41 ff d3 e9 d6 fd ff ff e8 96 f2 eb fd 4c 89 ef 48 c7 c6 00 a6 af 8b e8 07 f4 52 fd 90 <0f> 0b e8 7f f2 eb fd 48 c7 c7 40 93 af 8b 48 c7 c6 e0 a8 af 8b 31
RSP: 0018:ffffc9000ff4f7e0 EFLAGS: 00010246
RAX: b7630c6330986b00 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000006 RSI: ffffffff8d798217 RDI: 00000000ffffffff
RBP: ffffc9000ff4f9d0 R08: ffffffff8f824277 R09: 1ffffffff1f0484e
R10: dffffc0000000000 R11: fffffbfff1f0484f R12: ffffffffffffffff
R13: ffffea000001a840 R14: 0000000000005000 R15: ffff888036c31410
FS:  0000000000000000(0000) GS:ffff88808d416000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc38501a000 CR3: 00000000110e3000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 run_ordered_work fs/btrfs/async-thread.c:243 [inline]
 btrfs_work_helper+0x564/0xbf0 fs/btrfs/async-thread.c:322
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:const_folio_flags include/linux/page-flags.h:351 [inline]
RIP: 0010:folio_test_head include/linux/page-flags.h:844 [inline]
RIP: 0010:folio_test_large include/linux/page-flags.h:865 [inline]
RIP: 0010:folio_order include/linux/mm.h:1246 [inline]
RIP: 0010:folio_size include/linux/mm.h:2354 [inline]
RIP: 0010:submit_one_async_extent fs/btrfs/inode.c:1128 [inline]
RIP: 0010:submit_compressed_extents+0x161a/0x1670 fs/btrfs/inode.c:1599
Code: 8c 9d 53 fe 4d 8b 1e 4c 89 ff 2e 2e 2e 41 ff d3 e9 d6 fd ff ff e8 96 f2 eb fd 4c 89 ef 48 c7 c6 00 a6 af 8b e8 07 f4 52 fd 90 <0f> 0b e8 7f f2 eb fd 48 c7 c7 40 93 af 8b 48 c7 c6 e0 a8 af 8b 31
RSP: 0018:ffffc9000ff4f7e0 EFLAGS: 00010246
RAX: b7630c6330986b00 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000006 RSI: ffffffff8d798217 RDI: 00000000ffffffff
RBP: ffffc9000ff4f9d0 R08: ffffffff8f824277 R09: 1ffffffff1f0484e
R10: dffffc0000000000 R11: fffffbfff1f0484f R12: ffffffffffffffff
R13: ffffea000001a840 R14: 0000000000005000 R15: ffff888036c31410
FS:  0000000000000000(0000) GS:ffff88808d416000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc38501a000 CR3: 00000000373f0000 CR4: 0000000000352ef0


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

