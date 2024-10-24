Return-Path: <linux-btrfs+bounces-9117-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EE69ADAAD
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 05:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6891F22579
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 03:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43B1166F06;
	Thu, 24 Oct 2024 03:50:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AAE1EB3D
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741834; cv=none; b=CiJPQwEGLAgSDvTrzcyJI2Nx5Y9OyTUoQfo4u5TdXab/jTIUXP1skUl0NT4aCaqI8J4AuvcT6aKClndbuHudeViqzQQCsk0u2o2qMj5xOBneFPU+pEMtnS6PZ2RhCdAPH4/MtpmhERRm5oh9j57bm3F98QKSggXJDWpAyX5cLXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741834; c=relaxed/simple;
	bh=OFWoX0BR8uKglVgocFE2OATNkVD0ndGSGOefEwJ8NSM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QjTkl+0AQNuXAYU5nwP3+XYG2i02CqMR45fDYwk5zyIfS2swsQGTi6XGCFjVWvqjn9B/JkIFYgvKP1kWEthEmmMfEextPG+ksExHebFqSak0EBTP+XZ7qhemvKn+AdoVY72m6tLKyisFVhILv0O/4PJ/sXD2kJk0kGyQnX3PjsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3da2d46b9so6563495ab.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 20:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729741831; x=1730346631;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YccEbgCGVFNPv2zEK0O6l4j+t5s/5f+qGxaG8zPTDuY=;
        b=vHplWN4NI5E9PK9Q2fZQSj3xJ4b/08j38C/AQanCbj7NoD59asyI8ux/bP5xc3798m
         WEUl797fjVWKXevf8lGu3y1AMnqf8+iyofsWOSdj9LmRj6Pg52USyRMQHDqKP7ZVBgyN
         tOj0LyM8PG0avIJqpEri6+vjUTiNIhyV+5KC4gRiutr7TvjxD0DE48omVymhpHxjCt1r
         V2lhMqAMfCdtYCgi3ARhl+Fklh/23HL8b2zB6/YEtNlI8Rfjp3Nz6mKZF+wdRyw2osf1
         dSMFU5RAVOBXoC5BM2YNI97Z/lyvIZs3axpTCIq2DToW4qU7gLzoYYnrxHtjSE5AAFXI
         17Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXReyq2/ELuptmC8GyXNXVpg36D8AF39Hdbh4z6IuKSDZzpQfLuQt5Ro/sev3VKHAGswn8ZBn2Vz45jzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKXWqW1Q48FpElAelCYrD0ZLlBd493QcIEzxC1dW3Ldqka1TJR
	leZVx5cwvCzW1DwGDbP1GK4e4MqynD725LEQuue0h10tL1Dv6lF8UspZ6ML3brEcvxLdIjD/vTy
	QNAxNfVnVW2qvdmCftZt8Jd63s2VlxTHfkrUElOq+WjRp7lRjnHcnXEc=
X-Google-Smtp-Source: AGHT+IFjjUBvQ1Xc86yIonNSht0YVOIGQ+BSQjd6jGYfmZp6uT3kmIi6zVEzfhDyx4ufD0EpyRMbc5SWu20RYeedJ4miZjlhmKW5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188f:b0:3a0:9244:191d with SMTP id
 e9e14a558f8ab-3a4de8183d8mr6177165ab.16.1729741831070; Wed, 23 Oct 2024
 20:50:31 -0700 (PDT)
Date: Wed, 23 Oct 2024 20:50:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6719c407.050a0220.10f4f4.01dc.GAE@google.com>
Subject: [syzbot] [btrfs?] general protection fault in btrfs_search_slot
From: syzbot <syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    715ca9dd687f Merge tag 'io_uring-6.12-20241019' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c620a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=16e543edc81a3008
dashboard link: https://syzkaller.appspot.com/bug?extid=3030e17bd57a73d39bd7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c8825f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1417c430580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-715ca9dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ba436e2363b6/vmlinux-715ca9dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3ac78a7a1a30/bzImage-715ca9dd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2ff71deb6e6e/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000041: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000208-0x000000000000020f]
CPU: 0 UID: 0 PID: 5098 Comm: syz-executor113 Not tainted 6.12.0-rc3-syzkaller-00420-g715ca9dd687f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btrfs_search_slot+0xc5/0x30d0 fs/btrfs/ctree.c:2013
Code: 08 43 c7 44 2c 10 04 f2 04 f3 e8 f6 ed e6 fd 48 89 5c 24 38 48 81 c3 08 02 00 00 48 89 d8 48 c1 e8 03 48 89 84 24 d0 00 00 00 <42> 80 3c 28 00 74 08 48 89 df e8 5c b2 50 fe 48 8b 03 48 89 84 24
RSP: 0018:ffffc90000e379e0 EFLAGS: 00010206
RAX: 0000000000000041 RBX: 0000000000000208 RCX: ffff888000ff4880
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000e37bb0 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed100826400e R12: 1ffff920001c6f58
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88803e569b00
FS:  0000555591c73380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcd50a190f8 CR3: 000000003deb2000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 extent_from_logical+0x1c8/0x880 fs/btrfs/backref.c:2216
 iterate_inodes_from_logical+0x13b/0x330 fs/btrfs/backref.c:2560
 btrfs_ioctl_logical_to_ino+0x133/0x2a0 fs/btrfs/ioctl.c:3489
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcd5099cc59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdda2f7428 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcd5099cc59
RDX: 0000000020000080 RSI: 00000000c0389424 RDI: 0000000000000004
RBP: 00007fcd50a155f0 R08: 0000555591c744c0 R09: 0000555591c744c0
R10: 00000000000055c5 R11: 0000000000000246 R12: 00007ffdda2f7450
R13: 00007ffdda2f7678 R14: 431bde82d7b634db R15: 00007fcd509e503b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_search_slot+0xc5/0x30d0 fs/btrfs/ctree.c:2013
Code: 08 43 c7 44 2c 10 04 f2 04 f3 e8 f6 ed e6 fd 48 89 5c 24 38 48 81 c3 08 02 00 00 48 89 d8 48 c1 e8 03 48 89 84 24 d0 00 00 00 <42> 80 3c 28 00 74 08 48 89 df e8 5c b2 50 fe 48 8b 03 48 89 84 24
RSP: 0018:ffffc90000e379e0 EFLAGS: 00010206
RAX: 0000000000000041 RBX: 0000000000000208 RCX: ffff888000ff4880
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000e37bb0 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed100826400e R12: 1ffff920001c6f58
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88803e569b00
FS:  0000555591c73380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d064263098 CR3: 000000003deb2000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	08 43 c7             	or     %al,-0x39(%rbx)
   3:	44 2c 10             	rex.R sub $0x10,%al
   6:	04 f2                	add    $0xf2,%al
   8:	04 f3                	add    $0xf3,%al
   a:	e8 f6 ed e6 fd       	call   0xfde6ee05
   f:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
  14:	48 81 c3 08 02 00 00 	add    $0x208,%rbx
  1b:	48 89 d8             	mov    %rbx,%rax
  1e:	48 c1 e8 03          	shr    $0x3,%rax
  22:	48 89 84 24 d0 00 00 	mov    %rax,0xd0(%rsp)
  29:	00
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 5c b2 50 fe       	call   0xfe50b295
  39:	48 8b 03             	mov    (%rbx),%rax
  3c:	48                   	rex.W
  3d:	89                   	.byte 0x89
  3e:	84                   	.byte 0x84
  3f:	24                   	.byte 0x24


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

