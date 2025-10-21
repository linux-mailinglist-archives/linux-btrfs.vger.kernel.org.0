Return-Path: <linux-btrfs+bounces-18108-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3838BF5E50
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 12:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE401983519
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 10:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7782C32D445;
	Tue, 21 Oct 2025 10:52:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4815C32B9A4
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043946; cv=none; b=CYYPJFTj4ZXudM+fZfI6eRePhPc9Xv3+w7paf84cPWOeS9o+t/PZ7LwCictcyKTChEzhXan2xIkA7sXQoq/8QXMbgsGv7+bG2w/qWbnB36zVPYyIkl8bLNilYKBKeuylmhlAkN32jVkByUqqyKcCD2XUD1y4YOdvUGQysC0NlGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043946; c=relaxed/simple;
	bh=k4+x/4Pc5WbcPGrx/Ued/YG0FZK+SVVlfYq/U4m/crg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kfmwP/tZJOhpknKu7DEjHLd6y+Dd/6G0FHb7JEW08Rx6z0nEwTAOgBF/17WvB3PieYL5AM4zxz0qz0gzDyaCtI0MrCORBSooskCaH6yjWST8z+Hdusvj4fTTjDWOhYjO0eKcgOKE0G+8d+7KYxfW0JZtp8nCNPNRnvpPMX0jttE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-93e8db8badeso276227639f.3
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 03:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761043943; x=1761648743;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XGGkkMNkHmC4tm1IO7kdwE41Uv9388JAygyHw2qBF5E=;
        b=oasAvtylbQ6qb3luK8buSqCivKS28W1omgIyS6HEa/mFOUx6Fz2i9pU9kez5i8GdUS
         ozQNm1wJ+AwYank86dzldc12P+eYwaz6AUavgjnpg8RJzxXG47EjAGXPQy5lfDOLDxr8
         rikebHlS2F1C0EcDFxBKACyQYw+UH8OCynqP12x+yTkO5xtseB1UNSi4o8uBxosVBYAP
         hkonJXntJbN5M+KDpFxitACpZzQjwO0dczpV40esJolAuUwl002fNzAUrxFnZSd16T/M
         xoc6XKgQsHwOcahAzv64LUsJDDsCT4jkuHxJA3UtlZTIYtPgNH4yN4ehoTEJn5ir008L
         RVyA==
X-Forwarded-Encrypted: i=1; AJvYcCX65SrDpVqqa15XDZn8nVlI+PXx0qq6AAu0fi44pC5JDpZ8iqlBymJ16UIeWSj28GWYOi4tnjOpsg3rSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwG5MnYMhOc2hoVOOthFiSx7wqyz0CAUc9c03ViD7WLbOy0ME/Y
	m8VCMYCiJWnapR+icXfjpWkpqbQLUalpfnmtkDwM8hrV5Rjh1FdYmqOvvXjzOh3peqpt3wuawri
	7kQZ73D4RzqcaKVrHf31ioDRrcfIsQzHAH1tgZjBM4SX3tUTDvpWXau9AYtI=
X-Google-Smtp-Source: AGHT+IGZl/z9F3NGvnVY+4zx0T3/5eRzUDTVNeEAVsxrcpu9Kl75QHk4JVAqg9mnWOqdC1rEv0pCnJdsDiI880v7ISAFskicLI5i
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1651:b0:940:d1b4:1089 with SMTP id
 ca18e2360f4ac-940d1b41221mr1519079439f.1.1761043943425; Tue, 21 Oct 2025
 03:52:23 -0700 (PDT)
Date: Tue, 21 Oct 2025 03:52:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f765e7.050a0220.346f24.0012.GAE@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in btrfs_backref_release_cache (2)
From: syzbot <syzbot+6dafaff006dcd512c3af@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    98ac9cc4b445 Merge tag 'f2fs-fix-6.18-rc2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15facb04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2d7b4143707d3a0
dashboard link: https://syzkaller.appspot.com/bug?extid=6dafaff006dcd512c3af
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-98ac9cc4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4a2afc96e189/vmlinux-98ac9cc4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/92d24cde05de/bzImage-98ac9cc4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6dafaff006dcd512c3af@syzkaller.appspotmail.com

BTRFS info (device loop0): balance: start -d -m
BTRFS info (device loop0): relocating block group 6881280 flags data|metadata
BTRFS info (device loop0): found 1 extents, stage: move data extents
BTRFS info (device loop0): relocating block group 5242880 flags data|metadata
BTRFS info (device loop0): found 9 extents, stage: move data extents
assertion failed: !cache->nr_nodes :: 0, in fs/btrfs/backref.c:3160
------------[ cut here ]------------
kernel BUG at fs/btrfs/backref.c:3160!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5319 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btrfs_backref_release_cache+0x1ef/0x220 fs/btrfs/backref.c:3160
Code: 0f 0b e8 84 5f d7 fd 48 c7 c7 80 16 b0 8b 48 c7 c6 20 1f b0 8b 31 d2 48 c7 c1 20 17 b0 8b 41 b8 58 0c 00 00 e8 22 9d 3e fd 90 <0f> 0b e8 5a 5f d7 fd 48 c7 c7 80 16 b0 8b 48 c7 c6 60 1f b0 8b 31
RSP: 0018:ffffc9000d5c7830 EFLAGS: 00010246
RAX: 0000000000000043 RBX: ffff88801f4f2020 RCX: 85e0f5a888a8ee00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000002 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa650 R12: 1ffff11003e9e421
R13: 00000000fffffffe R14: ffff88801f4f20f0 R15: dffffc0000000000
FS:  00007faaa33d86c0(0000) GS:ffff88808d300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5176a4e949 CR3: 000000001fd36000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 relocate_block_group+0xac6/0xd70 fs/btrfs/relocation.c:3638
 btrfs_relocate_block_group+0x6bc/0xc60 fs/btrfs/relocation.c:3983
 btrfs_relocate_chunk+0x12f/0x5c0 fs/btrfs/volumes.c:3451
 __btrfs_balance+0x1860/0x23f0 fs/btrfs/volumes.c:4227
 btrfs_balance+0xac2/0x11b0 fs/btrfs/volumes.c:4604
 btrfs_ioctl_balance+0x3d3/0x610 fs/btrfs/ioctl.c:3577
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faaa258efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007faaa33d8038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007faaa27e6090 RCX: 00007faaa258efc9
RDX: 0000200000000180 RSI: 00000000c4009420 RDI: 0000000000000005
RBP: 00007faaa2611f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007faaa27e6128 R14: 00007faaa27e6090 R15: 00007ffe79b9d7c8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_backref_release_cache+0x1ef/0x220 fs/btrfs/backref.c:3160
Code: 0f 0b e8 84 5f d7 fd 48 c7 c7 80 16 b0 8b 48 c7 c6 20 1f b0 8b 31 d2 48 c7 c1 20 17 b0 8b 41 b8 58 0c 00 00 e8 22 9d 3e fd 90 <0f> 0b e8 5a 5f d7 fd 48 c7 c7 80 16 b0 8b 48 c7 c6 60 1f b0 8b 31
RSP: 0018:ffffc9000d5c7830 EFLAGS: 00010246
RAX: 0000000000000043 RBX: ffff88801f4f2020 RCX: 85e0f5a888a8ee00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000002 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa650 R12: 1ffff11003e9e421
R13: 00000000fffffffe R14: ffff88801f4f20f0 R15: dffffc0000000000
FS:  00007faaa33d86c0(0000) GS:ffff88808d300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5176a5bae0 CR3: 000000001fd36000 CR4: 0000000000352ef0


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

