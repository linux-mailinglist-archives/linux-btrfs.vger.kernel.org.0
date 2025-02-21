Return-Path: <linux-btrfs+bounces-11702-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D65C1A3FE8F
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 19:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861253BB431
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 18:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A54250BFB;
	Fri, 21 Feb 2025 18:17:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B412B1CAA90
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161851; cv=none; b=Ebq6VFlvIf6eZwKuRgD/0KBhwfvmUWlFDd+E5vGnlPcJqxz/IgmA8NucucVZB2t4oC5a0Zocl33uLscOAHHmW8zBywoj+caUAdfKOqH995GGcXPJfImlAiDpivYs/8eBFG8Pfscj86Di219o2BVhxw5zoIpfE/RnTn/Kpgr/qtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161851; c=relaxed/simple;
	bh=lA2nlzpAaURGAtJmBUMe0SN0v7RrsV9E8H4P1g1Cdc0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hwzW7ZEuI+V3ttgz5VSZDwX6Ris9weSJPs3yj+6QdCZr5NUgL7E4Ed/bZgC0M/29Nphur9U8WTl0MitjBMfbald348du8jG/TtbgHsA84LNlwTgRtkjmTktwwU/WAGDy7NI+1y75spoDsY5KTANWidx8Wjlapr/H2vibVNtCr2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d2a60faa44so44088225ab.0
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 10:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740161849; x=1740766649;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AsFl9EJBSb+e8quohGosTe2uvfmQrjH5XQ/WwcGXrks=;
        b=NqVxcSwgZwPOPgXT9Si+IAL1CpfA9XWwlSOThOUGQiDKit5gmBw0/VjDPzttWlep0R
         tMM8XD+b4ujsEx3i+5XWw0R/NQ/NRQ5ZGl8/YJtzEISX2h8Kju47Hs0EmQsmOeRWeuxf
         xkXGIwwzHRZgcrzLjXe8sq2x/X3TQZiJ8Ox6MPVr5F11Aa7U0q4gv1t4385UvHop//bP
         A8wxi6Y1FHqqrMQvbD5SSIXTtM/0ItEc4AGidJ2gsDTQRo5j5NhBCzkGm/Ie3cbomW4q
         G/dqm9yfUlSsqr6IbHKGagAVLfo1h44i/19eKwY34xdZGyN+atsvdHGvpmfq+Xn3nd6t
         y53g==
X-Forwarded-Encrypted: i=1; AJvYcCW9MioRYemMwyGx4T+X4ks3LKW8e/2VGeeGFMxtUpECtQNizRRpiTabkQS55uQuGEgHuc1RqiGCM3ksUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzV+DkSkgKrvR98rWYdzPQLIxboFMt3K0JUKXyQ9EokSNrKqd8d
	UgluKUGcNX7qRmXPhBGCIOts8Po3ikW9XjP2EtJzl7Pj8Cm6K/8GPRH4cvxcy75UE/E8BgAe1AO
	nmBFyd8xzpYCs2uIgl6JRxZj2IAiLMQ3fOHnaLOYAxwwFNl7WRNWdH0I=
X-Google-Smtp-Source: AGHT+IETZZhmzmoxxeGC6Ec3U96cmbI+Owv/n0peGurubbzeAlFlq4vC0kLDlwMjg4wDZ3NJMyuJjz/li3CaDIfsT34dtcPBJk4T
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2405:b0:3cf:bb6e:3065 with SMTP id
 e9e14a558f8ab-3d2cad7e5c3mr49944225ab.0.1740161848706; Fri, 21 Feb 2025
 10:17:28 -0800 (PST)
Date: Fri, 21 Feb 2025 10:17:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b8c338.050a0220.14d86d.0594.GAE@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in btrfs_backref_release_cache
From: syzbot <syzbot+1de7265d1e4c0c19dd35@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0ad2507d5d93 Linux 6.14-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b775a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=1de7265d1e4c0c19dd35
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-0ad2507d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dfb4fc7c042e/vmlinux-0ad2507d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1682113b81f5/bzImage-0ad2507d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1de7265d1e4c0c19dd35@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
BTRFS: device fsid ed167579-eb65-4e76-9a50-61ac97e9b59d devid 1 transid 8 /dev/loop0 (7:0) scanned by syz.0.0 (5320)
BTRFS info (device loop0): first mount of filesystem ed167579-eb65-4e76-9a50-61ac97e9b59d
BTRFS info (device loop0): using sha256 (sha256-avx2) checksum algorithm
BTRFS info (device loop0): rebuilding free space tree
BTRFS info (device loop0): disabling free space tree
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
BTRFS info (device loop0): balance: start -d -m
BTRFS info (device loop0): relocating block group 6881280 flags data|metadata
BTRFS info (device loop0): relocating block group 5242880 flags data|metadata
BTRFS info (device loop0): found 139 extents, stage: move data extents
assertion failed: !cache->nr_nodes, in fs/btrfs/backref.c:3160
------------[ cut here ]------------
kernel BUG at fs/btrfs/backref.c:3160!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5320 Comm: syz.0.0 Not tainted 6.14.0-rc3-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btrfs_backref_release_cache+0x1b5/0x1e0 fs/btrfs/backref.c:3160
Code: 23 fd 90 0f 0b e8 db 93 be fd 48 c7 c7 a0 ea 6d 8c 48 c7 c6 40 f3 6d 8c 48 c7 c2 40 eb 6d 8c b9 58 0c 00 00 e8 fc e1 23 fd 90 <0f> 0b e8 b4 93 be fd 48 c7 c7 a0 ea 6d 8c 48 c7 c6 80 f3 6d 8c 48
RSP: 0018:ffffc9000d457838 EFLAGS: 00010246
RAX: 000000000000003e RBX: 0000000000000002 RCX: 83d820ae1486a200
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000d457a00 R08: ffffffff81a1108c R09: 1ffff92001a8aea4
R10: dffffc0000000000 R11: fffff52001a8aea5 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff888052f880f0 R15: ffff888052f88020
FS:  00007fb48b6ac6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000044042000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 relocate_block_group+0xabf/0xd40 fs/btrfs/relocation.c:3664
 btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4009
 btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3511
 __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4292
 btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4669
 btrfs_ioctl_balance+0x3f5/0x660 fs/btrfs/ioctl.c:3587
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb48a78cde9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb48b6ac038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fb48a9a5fa0 RCX: 00007fb48a78cde9
RDX: 0000400000000180 RSI: 00000000c4009420 RDI: 0000000000000004
RBP: 00007fb48a80e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb48a9a5fa0 R15: 00007ffedc7a6988
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_backref_release_cache+0x1b5/0x1e0 fs/btrfs/backref.c:3160
Code: 23 fd 90 0f 0b e8 db 93 be fd 48 c7 c7 a0 ea 6d 8c 48 c7 c6 40 f3 6d 8c 48 c7 c2 40 eb 6d 8c b9 58 0c 00 00 e8 fc e1 23 fd 90 <0f> 0b e8 b4 93 be fd 48 c7 c7 a0 ea 6d 8c 48 c7 c6 80 f3 6d 8c 48
RSP: 0018:ffffc9000d457838 EFLAGS: 00010246
RAX: 000000000000003e RBX: 0000000000000002 RCX: 83d820ae1486a200
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000d457a00 R08: ffffffff81a1108c R09: 1ffff92001a8aea4
R10: dffffc0000000000 R11: fffff52001a8aea5 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff888052f880f0 R15: ffff888052f88020
FS:  00007fb48b6ac6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dd4cdc80e8 CR3: 0000000044042000 CR4: 0000000000352ef0
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

