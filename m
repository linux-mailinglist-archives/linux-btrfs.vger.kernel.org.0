Return-Path: <linux-btrfs+bounces-10703-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A54E2A00A74
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 15:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7264716075D
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 14:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F7B1FA826;
	Fri,  3 Jan 2025 14:23:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E724A1494B2
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Jan 2025 14:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735914208; cv=none; b=j1mwJw5wK99Nj5hej9tHnFdjiUUz/7V4kMEntUy9pA39Es70gXsVR2oeF04U/StEywJBJBAcsw0bRC6c63CTc4tlcPbL3vltY7mcgOLg1AJgOrQMPHA5a02Wl1t7/Oh1umdBxITXpp8vu842v1WINyn08KpljWVhbLmuuTbKCa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735914208; c=relaxed/simple;
	bh=b3m1H1OfO9vRCBpWO6sXQ3/cL7j+k5RALqTFaUT0Ct4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oW9rWmK/nScmkouKcaOoAEx2wOKFO4OJ7uarerY3deKNJZwIc4UtYorPxc5+i31gfsSKjyTuil1w3Y2q+h8/A6a1FCZ6UFZCM+5ThrSjNGkiW1n9vyruRla3SCiT2RHv/l3uDQECJB7k2DNJbuRJ6kmPsWXIMJM+DEGs11W1cGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a814406be9so249288455ab.1
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jan 2025 06:23:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735914205; x=1736519005;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMQ0D7tgZkF+44PHmBZsIYGohHMhv4XLcLU2fJa6OWg=;
        b=IQIdUuEM+M9DN03WKenh1t7/PdzRqYf1PgR/C6e9vn6VJnRGOf/5F9bCV0svFEmbsP
         GRoyr2DmlN3ouTWxyyMLetCeoz+lSiyubvH2M0Q/aQt4yc2OQaRE8Xx7lfWCqIh5ml5i
         9fUg2GSlIU6xI4l82GCLuHgLcsU61iSQhn0EPxJO20CDVvLuG4kQWAQ7MSY4zpK0Pzyf
         450FPT5dlae67TrDX/Ee7R1jBSZ78GrVtPw2okaEvUYotlWMl3cWXF6JM2kFmR6b/nd8
         felow0L+dgkJusC2kieOUqjFs+o+lQelkiAxEpYUP/WOF6Lg5/dtzbd1g1MJtJzuxjqN
         du5A==
X-Forwarded-Encrypted: i=1; AJvYcCUxONCja6kAXZe002Sfd46hnvyfe8WNVC/GDz3Dl8zS16EPbGSA8F/g4fNYdhzZdtXoUi5tNaokW4+iig==@vger.kernel.org
X-Gm-Message-State: AOJu0YxypAvMP9JiBY99o8ujtLEssblJBKBgktqvkIEG/tbesZY8oHFa
	9RCEbovoFkeWRXhKvFbCFbC/MCA8uA/pUEL6Ba44lQpd2IDieZX3eO3/j0VsbS+Og21SlbqZiVp
	xJ1gaRPZ0mOp/ZkcjWiNd4zFAOennEXupjrf5SiE1FBUjKe8ibjhEcTc=
X-Google-Smtp-Source: AGHT+IFOM0p8pcBCLiG3aZFiXv/r9wtoCOYfCEpt0fCGerZ5Mdjza8tmoksiF5AlAygn/XWsE5MVuBjlaGj4o1hiwMRk5w5m6U1H
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a44:b0:3a7:e86a:e803 with SMTP id
 e9e14a558f8ab-3c2d25673f5mr386706505ab.8.1735914205035; Fri, 03 Jan 2025
 06:23:25 -0800 (PST)
Date: Fri, 03 Jan 2025 06:23:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6777f2dd.050a0220.178762.0045.GAE@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in btrfs_split_ordered_extent
From: syzbot <syzbot+f60d8337a5c8e8d92a77@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fc033cf25e61 Linux 6.13-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1566a6df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c541fa8af5c9cc7
dashboard link: https://syzkaller.appspot.com/bug?extid=f60d8337a5c8e8d92a77
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-fc033cf2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c984d36162d8/vmlinux-fc033cf2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1905eb42e5b6/bzImage-fc033cf2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f60d8337a5c8e8d92a77@syzkaller.appspotmail.com

FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 1
CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted 6.13.0-rc5-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 fail_dump lib/fault-inject.c:53 [inline]
 should_fail_ex+0x3b0/0x4e0 lib/fault-inject.c:154
 should_failslab+0xac/0x100 mm/failslab.c:46
 slab_pre_alloc_hook mm/slub.c:4072 [inline]
 slab_alloc_node mm/slub.c:4148 [inline]
 __do_kmalloc_node mm/slub.c:4297 [inline]
 __kmalloc_noprof+0xdd/0x4c0 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 btrfs_chunk_alloc_add_chunk_item+0x244/0x1100 fs/btrfs/volumes.c:5742
 reserve_chunk_space+0x1ca/0x2c0 fs/btrfs/block-group.c:4292
 check_system_chunk fs/btrfs/block-group.c:4319 [inline]
 do_chunk_alloc fs/btrfs/block-group.c:3891 [inline]
 btrfs_chunk_alloc+0x77b/0xf80 fs/btrfs/block-group.c:4187
 find_free_extent_update_loop fs/btrfs/extent-tree.c:4166 [inline]
 find_free_extent+0x42d1/0x5810 fs/btrfs/extent-tree.c:4579
 btrfs_reserve_extent+0x422/0x810 fs/btrfs/extent-tree.c:4672
 btrfs_new_extent_direct fs/btrfs/direct-io.c:186 [inline]
 btrfs_get_blocks_direct_write+0x706/0xfa0 fs/btrfs/direct-io.c:321
 btrfs_dio_iomap_begin+0xbb7/0x1180 fs/btrfs/direct-io.c:525
 iomap_iter+0x697/0xf60 fs/iomap/iter.c:90
 __iomap_dio_rw+0xeb9/0x25b0 fs/iomap/direct-io.c:702
 btrfs_dio_write fs/btrfs/direct-io.c:775 [inline]
 btrfs_direct_write+0x610/0xa30 fs/btrfs/direct-io.c:880
 btrfs_do_write_iter+0x2a0/0x760 fs/btrfs/file.c:1397
 do_iter_readv_writev+0x600/0x880
 vfs_writev+0x376/0xba0 fs/read_write.c:1050
 do_pwritev fs/read_write.c:1146 [inline]
 __do_sys_pwritev2 fs/read_write.c:1204 [inline]
 __se_sys_pwritev2+0x196/0x2b0 fs/read_write.c:1195
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1281f85d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f12819fe038 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007f1282176080 RCX: 00007f1281f85d29
RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000005
RBP: 00007f12819fe090 R08: 0000000000000000 R09: 0000000000000003
R10: 0000000000007000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007f1282176080 R15: 00007ffcb9e23328
 </TASK>
BTRFS error (device loop0 state A): Transaction aborted (error -12)
BTRFS: error (device loop0 state A) in btrfs_chunk_alloc_add_chunk_item:5745: errno=-12 Out of memory
BTRFS info (device loop0 state EA): forced readonly
assertion failed: !(flags & ~BTRFS_ORDERED_TYPE_FLAGS), in fs/btrfs/ordered-data.c:1234
------------[ cut here ]------------
kernel BUG at fs/btrfs/ordered-data.c:1234!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted 6.13.0-rc5-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btrfs_split_ordered_extent+0xd8d/0xe20 fs/btrfs/ordered-data.c:1234
Code: 43 fd 90 0f 0b e8 43 c4 db fd 48 c7 c7 20 0c 4c 8c 48 c7 c6 80 0f 4c 8c 48 c7 c2 e0 0b 4c 8c b9 d2 04 00 00 e8 04 57 43 fd 90 <0f> 0b e8 1c c4 db fd eb 5b e8 15 c4 db fd 48 c7 c7 20 0c 4c 8c 48
RSP: 0018:ffffc9000d1df2b8 EFLAGS: 00010246
RAX: 0000000000000057 RBX: 000000000006a000 RCX: 9ce21886c4195300
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000091 R08: ffffffff817f0a3c R09: 1ffff92001a3bdf4
R10: dffffc0000000000 R11: fffff52001a3bdf5 R12: 1ffff1100a45f401
R13: ffff8880522fa018 R14: dffffc0000000000 R15: 000000000006a000
FS:  00007f12819fe6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557750bd7da8 CR3: 00000000400ea000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_extract_ordered_extent fs/btrfs/direct-io.c:702 [inline]
 btrfs_dio_submit_io+0x4be/0x6d0 fs/btrfs/direct-io.c:737
 iomap_dio_submit_bio fs/iomap/direct-io.c:85 [inline]
 iomap_dio_bio_iter+0x1022/0x1740 fs/iomap/direct-io.c:447
 __iomap_dio_rw+0x13b7/0x25b0 fs/iomap/direct-io.c:703
 btrfs_dio_write fs/btrfs/direct-io.c:775 [inline]
 btrfs_direct_write+0x610/0xa30 fs/btrfs/direct-io.c:880
 btrfs_do_write_iter+0x2a0/0x760 fs/btrfs/file.c:1397
 do_iter_readv_writev+0x600/0x880
 vfs_writev+0x376/0xba0 fs/read_write.c:1050
 do_pwritev fs/read_write.c:1146 [inline]
 __do_sys_pwritev2 fs/read_write.c:1204 [inline]
 __se_sys_pwritev2+0x196/0x2b0 fs/read_write.c:1195
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1281f85d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f12819fe038 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007f1282176080 RCX: 00007f1281f85d29
RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000005
RBP: 00007f12819fe090 R08: 0000000000000000 R09: 0000000000000003
R10: 0000000000007000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007f1282176080 R15: 00007ffcb9e23328
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_split_ordered_extent+0xd8d/0xe20 fs/btrfs/ordered-data.c:1234
Code: 43 fd 90 0f 0b e8 43 c4 db fd 48 c7 c7 20 0c 4c 8c 48 c7 c6 80 0f 4c 8c 48 c7 c2 e0 0b 4c 8c b9 d2 04 00 00 e8 04 57 43 fd 90 <0f> 0b e8 1c c4 db fd eb 5b e8 15 c4 db fd 48 c7 c7 20 0c 4c 8c 48
RSP: 0018:ffffc9000d1df2b8 EFLAGS: 00010246
RAX: 0000000000000057 RBX: 000000000006a000 RCX: 9ce21886c4195300
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000091 R08: ffffffff817f0a3c R09: 1ffff92001a3bdf4
R10: dffffc0000000000 R11: fffff52001a3bdf5 R12: 1ffff1100a45f401
R13: ffff8880522fa018 R14: dffffc0000000000 R15: 000000000006a000
FS:  00007f12819fe6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557750bd7da8 CR3: 00000000400ea000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

