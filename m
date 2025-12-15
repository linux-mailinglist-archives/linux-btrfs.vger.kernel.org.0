Return-Path: <linux-btrfs+bounces-19744-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AB1CBD66B
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 11:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3469300BED0
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 10:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DCE2DCC13;
	Mon, 15 Dec 2025 10:45:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5A02877D5
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765795530; cv=none; b=CLgJplJeHdkZICcUUpyuqwVbGLPANIWt6uuvBuCt8bd2bHwEfjYMg1jG9h0PohKL5kOF7hIRTumbCxAxZR3qLOlvP+WjVSekqiYEblMUitMqQCNoSTuiyZUMqwb/ZX7NlmbxvF7fAkOi+4+q7Iibqv554Z/z+/gGurnYuWGW/6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765795530; c=relaxed/simple;
	bh=3Aw14BTmLz1BdVvZipLZXOtbCNzY/+YK7xNp9OB77Sc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IylteqRWcPIaMzBtADv62DsY+t9daOSrwMA/ky6JjHtoyM0b7UdxG01APFQ7u1i/Lg1tbwol1mrajbiWdbFKNGg3tEdmfgBJoamy+rDTKV+WHnBYrrgyiNmV0EX/Jt3z1EOjK6kfui1rHt9Zjs+T8a4CeEimV3/l7zIpB+OPLGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-657537cef7cso5015832eaf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 02:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765795527; x=1766400327;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zAXeDbqPJS2XRN2uvNqHDcctpc1JaqlhEUsqAi6Qra0=;
        b=Av1lkso9jObK94YX+WlK2LuXjQWCcnDbNAeeJa/Z9RdtxC23TRdCtQbIjci/cTsY31
         /Q201anvvFfO432SrRpD7s21AaFmaiJ69SUqi46WW+fb0ROP7GbcXNDz4GZPT4Oz2DT4
         nj4IYMrGq/0gXf+AbI31wx8Qgmvzj5VdSDd4Oexv3G9qTEZ5fRfzu5Yo0gXcA5bVql6l
         U5qs58kQTvv7A848OL0qy1pY91f45uB8RbxwPssFpI5EJk2oefnKtapd+pQIJHnHmW1p
         xtw3onYWL2D9AqTPXkaTBm1Uf6BYeC0Ht/pq6I3JH4YvgN2B1O5uf0QXy7O9CWOFMbW+
         2OIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzHSoDk6LfzqxImJw5l7UHL6X0ebNo69WRmFYM71qKAJQUGgT2xt7LRNfCjgLENNmJ2Aq8hHzEanul7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwX9KTMnodvUrwjOM5lzwuB5Z3db4pHaPBQuW5e9aQRYvvDQVNK
	6XJkr6Ba6awFf3KNEYviVDmQemCyVY9wKua7EIKOssDKLGM4+iEJZ3iU5PKv6QB/BzEkFCw4dYj
	9mRedVCBMO+4/IpLjWwF9BA+6shrSfpTuukdcppKdeuLMBMrfgF0QuR+BSzg=
X-Google-Smtp-Source: AGHT+IE5ii4gBKHjiBg9vbtiVdj0YovfZeJneTLd+Fy6pwbHQXqysexz8aPRmRa0pq5qAxgVNP7rSwY8sKHX9J3oXyxUKmtB2z5z
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f030:b0:659:9a49:8fe6 with SMTP id
 006d021491bc7-65b4518bce0mr4840675eaf.19.1765795527600; Mon, 15 Dec 2025
 02:45:27 -0800 (PST)
Date: Mon, 15 Dec 2025 02:45:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693fe6c7.a70a0220.33cd7b.00f8.GAE@google.com>
Subject: [syzbot] [btrfs?] general protection fault in detach_extent_buffer_folio
 (2)
From: syzbot <syzbot+f0d57fef86e1112b6b37@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d358e5254674 Merge tag 'for-6.19/dm-changes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132e161a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de48dccdf203ea90
dashboard link: https://syzkaller.appspot.com/bug?extid=f0d57fef86e1112b6b37
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d358e525.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3fa1d04c1a85/vmlinux-d358e525.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a9b253146e36/bzImage-d358e525.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f0d57fef86e1112b6b37@syzkaller.appspotmail.com

BTRFS info (device loop0): balance: start -d -m
BTRFS info (device loop0): relocating block group 6881280 flags data|metadata
BTRFS info (device loop0): relocating block group 5242880 flags data|metadata
Oops: general protection fault, probably for non-canonical address 0xdffffc000000002a: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000150-0x0000000000000157]
CPU: 0 UID: 0 PID: 5340 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:210
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 c3 cc cc cc cc cc 66 66 66 66 66 66 2e
RSP: 0018:ffffc900099bef98 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffffffff8b5f9b4e RCX: 941b0e0fd311fb00
RDX: 0000000000000000 RSI: ffffffff8b5f9b4e RDI: 000000000000002a
RBP: ffffffff83dbedcc R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed10022e803f R12: 0000000000000000
R13: 0000000000000150 R14: 0000000000000150 R15: 0000000000000001
FS:  00007f3e987896c0(0000) GS:ffff88808d22f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f98d1067bc0 CR3: 000000001eed1000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __kasan_check_byte+0x12/0x40 mm/kasan/common.c:572
 kasan_check_byte include/linux/kasan.h:401 [inline]
 lock_acquire+0x84/0x340 kernel/locking/lockdep.c:5842
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 detach_extent_buffer_folio+0xdc/0x730 fs/btrfs/extent_io.c:2909
 btrfs_release_extent_buffer_folios+0xc9/0x4b0 fs/btrfs/extent_io.c:2969
 release_extent_buffer+0x16b/0x240 fs/btrfs/extent_io.c:3618
 btrfs_force_cow_block+0x10d6/0x2410 fs/btrfs/ctree.c:605
 btrfs_cow_block+0x3c4/0xa80 fs/btrfs/ctree.c:708
 do_relocation+0xc0b/0x17c0 fs/btrfs/relocation.c:2287
 relocate_tree_block fs/btrfs/relocation.c:2540 [inline]
 relocate_tree_blocks+0x11c3/0x1fa0 fs/btrfs/relocation.c:2647
 relocate_block_group+0x76e/0xd70 fs/btrfs/relocation.c:3573
 btrfs_relocate_block_group+0x6b6/0xc70 fs/btrfs/relocation.c:3966
 btrfs_relocate_chunk+0x12f/0x5c0 fs/btrfs/volumes.c:3424
 __btrfs_balance+0x18ff/0x24e0 fs/btrfs/volumes.c:4197
 btrfs_balance+0xac2/0x11b0 fs/btrfs/volumes.c:4571
 btrfs_ioctl_balance+0x3d3/0x610 fs/btrfs/ioctl.c:3525
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3e9798f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3e98789038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f3e97be6090 RCX: 00007f3e9798f7c9
RDX: 0000200000000180 RSI: 00000000c4009420 RDI: 0000000000000004
RBP: 00007f3e97a13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3e97be6128 R14: 00007f3e97be6090 R15: 00007ffc12b96d88
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:210
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 c3 cc cc cc cc cc 66 66 66 66 66 66 2e
RSP: 0018:ffffc900099bef98 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffffffff8b5f9b4e RCX: 941b0e0fd311fb00
RDX: 0000000000000000 RSI: ffffffff8b5f9b4e RDI: 000000000000002a
RBP: ffffffff83dbedcc R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed10022e803f R12: 0000000000000000
R13: 0000000000000150 R14: 0000000000000150 R15: 0000000000000001
FS:  00007f3e987896c0(0000) GS:ffff88808d22f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f98d1067bc0 CR3: 000000001eed1000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   7:	00
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	0f 1f 40 d6          	nopl   -0x2a(%rax)
  1c:	48 c1 ef 03          	shr    $0x3,%rdi
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	0f b6 04 07          	movzbl (%rdi,%rax,1),%eax <-- trapping instruction
  2e:	3c 08                	cmp    $0x8,%al
  30:	0f 92 c0             	setb   %al
  33:	c3                   	ret
  34:	cc                   	int3
  35:	cc                   	int3
  36:	cc                   	int3
  37:	cc                   	int3
  38:	cc                   	int3
  39:	66                   	data16
  3a:	66                   	data16
  3b:	66                   	data16
  3c:	66                   	data16
  3d:	66                   	data16
  3e:	66                   	data16
  3f:	2e                   	cs


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

