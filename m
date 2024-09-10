Return-Path: <linux-btrfs+bounces-7917-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1110797456A
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 00:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33452289B2A
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 22:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D751ABEA5;
	Tue, 10 Sep 2024 22:11:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BF217A924
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 22:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726006288; cv=none; b=jvWeCtAuFkTPv8iAWkuG7rIn2Tq0vunUSBumyy5bVk1BjHHiQLkCcmFwEdczqyzG1KTM3/xjL90WGoErTyVzene0m2CnqjZ0b3sXZoobYyPF00luzbJ1i7GY5ytzHvAkeiK06KuaCSQweXI3jQ6ytBzaAJoKRUyHAcngd22uh10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726006288; c=relaxed/simple;
	bh=oaxeySwHXmdi/GRB9V3p83bklbN3ZWi84n9ubxHIuSw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aVor5KLku7kQqq6YsBW/u2Uf5AZX+AP4vTb6YLmMiPwjgpD/WmMErH3k6ZDuBlwqW5a47q8Hv4SoAxW1ppYd/+T10L1i7Gt+AvqYI4PtXOiRbG+6MfPQ9a2ddWgVT9Prn8xQwct/+P/ArTMj93YchfZNbMI9HOZcGCTMMazCNIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39f56ac8d88so114684565ab.2
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 15:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726006286; x=1726611086;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+rlNg+uvtZz8iDWOVfJiuabdoZkyy8CETYE4t97EPUA=;
        b=tRqn3Xiogoj+aok9t+E+ODBD0gy6pSEBWpT3OBVFd7Dz5Gaz+AFX3mPUs/ty+FrskF
         olD0CHA3J/+7da+3t8HQ6jgY19Z8Hg795PfDNWBrj0R/eO9pLUvppXZu1adqr9gdys+n
         yps3sUauZ6lPhjQ9CZxHV5Fi0plQVNKX8NEEpxxTFd3YNLlpLqw7lpL5De9vlnaBV8o/
         LfoURZLFTBn6yeT7Oy1KjdDCT5ULwWs0BrQtCFB7cg0SqW06lxI4OT9qPdUfyqIJtiqo
         tYoIA6SmTQuQG0U23kkRnY7ifGDU1ORTYV97krW1yNiRLVNck0/m+VP8P5KPLQpGqRvv
         MarA==
X-Forwarded-Encrypted: i=1; AJvYcCW4A2mLnRGrTn0/2R/aYLPPZopke92ZBLpT6F55BiqpEkO6+o0rm5G4c+y2SIaf2qNRBNWCpQ/U5E4z5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLBgE7MHxPgKQzlVanHCLleL2GU9+fA3Sf7nJptUqrmfy17gtT
	0h6HdsqaNwr8HZBO+D5CcjyR9caDehnNcxH4qkgiYda1o0c88nIk+3bCvV6iR5d3WX8OaJHkG9Q
	0y7mjDC8q+5TH86BbS4szOPXu1ohioBX3cWeH1giuJk/E4vOWvtZ4nq4=
X-Google-Smtp-Source: AGHT+IEhMZSQi9z18imm1By9OGoI2R7aRo0E90BR1im6LL/naumMz1hP1s5BzMVqNQcUttWe+J3FhJbYcYZCq6UzMiq/QLgVOCzQ
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c6:b0:39a:ea89:22ec with SMTP id
 e9e14a558f8ab-3a04f0765b5mr214256585ab.9.1726006285846; Tue, 10 Sep 2024
 15:11:25 -0700 (PDT)
Date: Tue, 10 Sep 2024 15:11:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c5d090621cb2770@google.com>
Subject: [syzbot] [btrfs?] general protection fault in write_all_supers
From: syzbot <syzbot+56360f93efa90ff15870@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b831f83e40a2 Merge tag 'bpf-6.11-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1197909f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=56360f93efa90ff15870
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ccaffb980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107d03c7980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-b831f83e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ab02bf22935d/vmlinux-b831f83e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c1101078451d/bzImage-b831f83e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6d79e1e6aae6/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+56360f93efa90ff15870@syzkaller.appspotmail.com

BTRFS info (device loop0 state MCS): disabling free space tree
BTRFS info (device loop0 state MCS): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
BTRFS info (device loop0 state MCS): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 UID: 0 PID: 5101 Comm: syz-executor285 Not tainted 6.11.0-rc6-syzkaller-00183-gb831f83e40a2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:backup_super_roots fs/btrfs/disk-io.c:1691 [inline]
RIP: 0010:write_all_supers+0x97a/0x40f0 fs/btrfs/disk-io.c:4041
Code: 00 00 00 48 89 d8 48 c1 e8 03 42 0f b6 04 28 84 c0 0f 85 8a 34 00 00 44 88 33 48 8b 5c 24 10 48 83 c3 18 49 89 df 49 c1 ef 03 <43> 80 3c 2f 00 74 08 48 89 df e8 17 b6 4b fe 48 89 5c 24 10 48 8b
RSP: 0018:ffffc90002d3f040 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000000018 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffff888035eeaa80
RBP: ffffc90002d3f3f0 R08: ffff88803d48806b R09: 1ffff11007a9100d
R10: dffffc0000000000 R11: ffffed1007a9100e R12: dffffc0000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000003
FS:  0000555594a77380(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056349cf20668 CR3: 000000003f9f4000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_commit_transaction+0x1eae/0x3740 fs/btrfs/transaction.c:2530
 btrfs_delete_free_space_tree+0x383/0x730 fs/btrfs/free-space-tree.c:1312
 btrfs_start_pre_rw_mount+0xf28/0x1300 fs/btrfs/disk-io.c:3012
 btrfs_remount_rw fs/btrfs/super.c:1309 [inline]
 btrfs_reconfigure+0xae6/0x2d40 fs/btrfs/super.c:1534
 btrfs_reconfigure_for_mount fs/btrfs/super.c:2020 [inline]
 btrfs_get_tree_subvol fs/btrfs/super.c:2079 [inline]
 btrfs_get_tree+0x918/0x1920 fs/btrfs/super.c:2115
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb7b8916e99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe5c5484c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007fb7b8916e99
RDX: 0000000020000280 RSI: 0000000020000180 RDI: 0000000020000100
RBP: 00007fb7b89905f0 R08: 0000000000000000 R09: 0000555594a784c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe5c5484f0
R13: 00007ffe5c548718 R14: 431bde82d7b634db R15: 00007fb7b896003b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:backup_super_roots fs/btrfs/disk-io.c:1691 [inline]
RIP: 0010:write_all_supers+0x97a/0x40f0 fs/btrfs/disk-io.c:4041
Code: 00 00 00 48 89 d8 48 c1 e8 03 42 0f b6 04 28 84 c0 0f 85 8a 34 00 00 44 88 33 48 8b 5c 24 10 48 83 c3 18 49 89 df 49 c1 ef 03 <43> 80 3c 2f 00 74 08 48 89 df e8 17 b6 4b fe 48 89 5c 24 10 48 8b
RSP: 0018:ffffc90002d3f040 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000000018 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffff888035eeaa80
RBP: ffffc90002d3f3f0 R08: ffff88803d48806b R09: 1ffff11007a9100d
R10: dffffc0000000000 R11: ffffed1007a9100e R12: dffffc0000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000003
FS:  0000555594a77380(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f731263196e CR3: 000000003f9f4000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 48 89             	add    %cl,-0x77(%rax)
   5:	d8 48 c1             	fmuls  -0x3f(%rax)
   8:	e8 03 42 0f b6       	call   0xb60f4210
   d:	04 28                	add    $0x28,%al
   f:	84 c0                	test   %al,%al
  11:	0f 85 8a 34 00 00    	jne    0x34a1
  17:	44 88 33             	mov    %r14b,(%rbx)
  1a:	48 8b 5c 24 10       	mov    0x10(%rsp),%rbx
  1f:	48 83 c3 18          	add    $0x18,%rbx
  23:	49 89 df             	mov    %rbx,%r15
  26:	49 c1 ef 03          	shr    $0x3,%r15
* 2a:	43 80 3c 2f 00       	cmpb   $0x0,(%r15,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 17 b6 4b fe       	call   0xfe4bb650
  39:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
  3e:	48                   	rex.W
  3f:	8b                   	.byte 0x8b


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

