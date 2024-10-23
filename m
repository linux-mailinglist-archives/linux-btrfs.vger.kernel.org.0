Return-Path: <linux-btrfs+bounces-9090-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD54A9AC30E
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 11:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A033281C2F
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 09:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B2D175D2D;
	Wed, 23 Oct 2024 09:08:41 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DB1156F3A
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674520; cv=none; b=pcnOIevzUnefr2lHEwDdNvw7osS4YMZT0hYK9NPLfL7t3VxaMfKpHJLq4rr4na2Ft1lvm/65gtzpGd12JrgH7uFBWduIdMRkHIn6VJOOVfUGikt6MeHEl0PwpQFnYS5gVPhHhxZjhCCSMDag1j5vL/+eGtjvrBivfR5w5ywHSl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674520; c=relaxed/simple;
	bh=zEqtjKIPHRyCLSz2AKxhu0W5IyazP2Kj/dcZoCoovZs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=URHK9982ACQ9/Hjfvg2tyIP5x5lkg2a4GLAlTLbLDBis/9PfqHQClH1qDthQ0MNZiPjt+Fa8naOL7Q0ct4AmLYdB2pNipnFAKMk7BCP/jmDx61VLCAQlQkbvijjgJYEcYWU7l0bVf4kS3pB9DWiuG/1dN9JTqmMePD/OP9LcLpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3da2d46b9so52589985ab.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 02:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729674518; x=1730279318;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7x3De/oISwjfrDk09tDIxDDeq0y554RwIR8zLg9MxfU=;
        b=p3UlICikWBwO8Yyvg9dNIJ5sANc4NTlu7/hukEppTXRcxMQALc5D9vNvcvzuXpBOSb
         zEtPlvwa0BliOcBUYzNfyrgkFeQkZ/xFvBjdnF3eYKoOFM4PVK9jdgpgSg+C+WfMclup
         qS7g7jPkGGu3aQi8cDqHs8R83B+mZ4y6psCLJ6xeRHM0RSmxcL4kI1uO1y9VLVGigbCy
         3/dZaZWYqlz8nrvZ80jPjsQCILHwg86Fig10GrtsWJuUdApbHnowXyUIPTPPgPtnUpV/
         1lfD8M3khUb56fWvII8H3SSpK7N5GsyZdvFF8xhVdlpWvzR/eFBSQfO+D+ot8J4b+K4N
         EMDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRdlpeOQ0RYcW8KMFTcZDlNia7xzYW6ZDcnbIkglrDOMBDBZIfzEzIL3QUj/RT5Yutf9Z2HohSXLUqhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXMNQ8KqwQq3l1d9PqNpZ2FCFqinTOJzWv5OVVPH1wNfquhzBT
	rr7PNyr/FgFHBi20BxVuzdyI3xlX+EWz4XZk/LrLVtudPWsjihLwDkPvLkQ7E6CFfdeaF5HB/Dd
	W1prSk+RaLnl/h7q4v80+hhc3dVPJ6M1aP++49qlCPXbqy6it45UKgkY=
X-Google-Smtp-Source: AGHT+IGVd8RWxriAdjeQ26FuLwFn4saFDWlWPe7tOOqWCDsplhsVxb/XtiKImoB0Ti47VzRLi/+FCoNq91NnAzR5BwN4/Oj3gC9P
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1486:b0:3a0:9aef:4d0 with SMTP id
 e9e14a558f8ab-3a4d592cdecmr17763035ab.5.1729674518019; Wed, 23 Oct 2024
 02:08:38 -0700 (PDT)
Date: Wed, 23 Oct 2024 02:08:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6718bd15.050a0220.10f4f4.01a0.GAE@google.com>
Subject: [syzbot] [btrfs?] general protection fault in btrfs_lookup_csums_bitmap
From: syzbot <syzbot+5d2b33d7835870519b5f@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b04ae0f45168 Merge tag 'v6.12-rc3-smb3-client-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11478430580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbd94c114a3d407
dashboard link: https://syzkaller.appspot.com/bug?extid=5d2b33d7835870519b5f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1162d240580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15478430580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-b04ae0f4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3e40a4ec7885/vmlinux-b04ae0f4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9312d8ec05d3/bzImage-b04ae0f4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d4d1e4e89afc/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5d2b33d7835870519b5f@syzkaller.appspotmail.com

workqueue: max_active 32767 requested for btrfs-compressed-write is out of range, clamping between 1 and 512
workqueue: max_active 32767 requested for btrfs-scrub is out of range, clamping between 1 and 512
BTRFS info (device loop0 state CS): scrub: started on devid 1
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000041: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000208-0x000000000000020f]
CPU: 0 UID: 0 PID: 5110 Comm: syz-executor381 Not tainted 6.12.0-rc3-syzkaller-00319-gb04ae0f45168 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btrfs_lookup_csums_bitmap+0xc4/0x1600 fs/btrfs/file-item.c:615
Code: 8c 24 a8 00 00 00 42 c7 44 31 08 f3 f3 f3 f3 e8 d2 83 e1 fd 48 89 9c 24 88 00 00 00 48 81 c3 08 02 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 9d 39 4b fe 4c 8b 2b ba 11 00 00
RSP: 0018:ffffc9000af5f100 EFLAGS: 00010206
RAX: 0000000000000041 RBX: 0000000000000208 RCX: ffff888000cf2440
RDX: 0000000000000000 RSI: ffff888047132080 RDI: 0000000000000000
RBP: ffffc9000af5f290 R08: ffff88801fb3c800 R09: ffffc9000af5f420
R10: dffffc0000000000 R11: ffffed1008e2402e R12: 0000000000500000
R13: ffffc9000af5f420 R14: dffffc0000000000 R15: 0000000000500000
FS:  00005555764d5480(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055572fc64400 CR3: 0000000040a06000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 scrub_find_fill_first_stripe+0xe96/0x1200 fs/btrfs/scrub.c:1618
 queue_scrub_stripe fs/btrfs/scrub.c:1912 [inline]
 scrub_simple_mirror+0x5c6/0x960 fs/btrfs/scrub.c:2144
 scrub_stripe+0xa7a/0x2a60 fs/btrfs/scrub.c:2310
 scrub_chunk+0x2e3/0x470 fs/btrfs/scrub.c:2442
 scrub_enumerate_chunks+0xc4f/0x16a0 fs/btrfs/scrub.c:2706
 btrfs_scrub_dev+0x774/0xde0 fs/btrfs/scrub.c:3028
 btrfs_ioctl_scrub+0x236/0x370 fs/btrfs/ioctl.c:3251
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4e99a28f19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcb799b9b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4e99a28f19
RDX: 0000000020000000 RSI: 00000000c400941b RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffcb799ba00
R13: 00007ffcb799bc88 R14: 431bde82d7b634db R15: 00007f4e99a7103b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_lookup_csums_bitmap+0xc4/0x1600 fs/btrfs/file-item.c:615
Code: 8c 24 a8 00 00 00 42 c7 44 31 08 f3 f3 f3 f3 e8 d2 83 e1 fd 48 89 9c 24 88 00 00 00 48 81 c3 08 02 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 9d 39 4b fe 4c 8b 2b ba 11 00 00
RSP: 0018:ffffc9000af5f100 EFLAGS: 00010206
RAX: 0000000000000041 RBX: 0000000000000208 RCX: ffff888000cf2440
RDX: 0000000000000000 RSI: ffff888047132080 RDI: 0000000000000000
RBP: ffffc9000af5f290 R08: ffff88801fb3c800 R09: ffffc9000af5f420
R10: dffffc0000000000 R11: ffffed1008e2402e R12: 0000000000500000
R13: ffffc9000af5f420 R14: dffffc0000000000 R15: 0000000000500000
FS:  00005555764d5480(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055572fc64400 CR3: 0000000040a06000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8c 24 a8             	mov    %fs,(%rax,%rbp,4)
   3:	00 00                	add    %al,(%rax)
   5:	00 42 c7             	add    %al,-0x39(%rdx)
   8:	44 31 08             	xor    %r9d,(%rax)
   b:	f3 f3 f3 f3 e8 d2 83 	repz repz repz repz call 0xfde183e6
  12:	e1 fd
  14:	48 89 9c 24 88 00 00 	mov    %rbx,0x88(%rsp)
  1b:	00
  1c:	48 81 c3 08 02 00 00 	add    $0x208,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 9d 39 4b fe       	call   0xfe4b39d6
  39:	4c 8b 2b             	mov    (%rbx),%r13
  3c:	ba                   	.byte 0xba
  3d:	11 00                	adc    %eax,(%rax)


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

