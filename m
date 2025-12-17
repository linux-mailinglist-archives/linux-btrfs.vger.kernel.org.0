Return-Path: <linux-btrfs+bounces-19825-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A309ACC6942
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 09:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1CBBE3004626
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 08:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78EB33B95B;
	Wed, 17 Dec 2025 08:29:49 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA6F244675
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765960188; cv=none; b=K+ZrwqdL1Y/wxvYvBE+cbZ7ZQAWMAw+D2FMmepCwpgEvpZxAapB69uP4nOjskeMJ4cZuFb3gupj1AQBLwz3xqv237iWmnAiPF5wW/yCqk90JslmxvUwx8nQNAbSougHqF3iS0WfFlHCADUEIWuKUmAPq9y7E07YEIuYpOL+UQCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765960188; c=relaxed/simple;
	bh=Yo2yfOheYd2QQCuW4V5KjVb+tCEqrKNsHTqv1ceZiv4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZCA124DN6ZFxBQMFePcjw8t15wwWHq/ronwcusdixzusL/b5O/IN00oW2NziLtIB8E/z+/KxUDfTIi4N6r6YuJ781E3tQQSaOaCU5IiBeTxkeIvnk9tUyU4PA9s5jlIH2XU4Xs7Y71YDF/hjHKAYU0XlBRC2vbfV0holS/gSKWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-65b153371efso619186eaf.1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 00:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765960184; x=1766564984;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/5l5YWT+gFM36FSeuF8wxKsKPKWJgnH7Ud+WIs5w/08=;
        b=CpNc85mfABvxTcXwLon2PlkONzz36p92lpB1yfbl0kt2WOS6GKGf/xGGr/V8Y2+Ew/
         vqSlwxFsybNNiqrdTLgWWNYQN+QjycF5u3qrVmHqAIZXcorjBkSnl7kcaLeZ9IFCB9xI
         uXLEHx+sU8Kmc7cbgA0/08WqkVJayVB0qRWeTmX2wWp34xKT9vmugV23D03jF5YUv2r/
         RWprwzxuCnKPFvmLgXMn4OP0RLOErPn/l6F5aHrzO5BsQaTDnYvuOvJTK32jZnzMX4ec
         FW+bxuVQKECHZrg6XMQivM/myMTMzXiQzdugc0jtNMiTS/JA8ZiPu4ccpUbp5ctMQPXs
         FezA==
X-Forwarded-Encrypted: i=1; AJvYcCX6VONN0N/1gyvPv7rV6LqVWlUYWBN3yEGSVsBu5XcEg3Ue+uVSAbHoc+LOykAzlwmDq0awzzNbHlxNTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjKf5ozvPeLVTKOWhdStuQ7xfaW1QHxDGpeSCh0M+DeXsBTABd
	U0zKKpUHNz5iZCcsmhMmuJD2iMrOeLBc8inkZRkachdTppB+ux8eF061TXAW9s4WsNfY9N2pH6Q
	kCRSDyaFhNg1LPU0RBtQf4c82D1d/z33OiWH3/hmJ0XCa/zdudEtO5a1Dshw=
X-Google-Smtp-Source: AGHT+IFoD0ISrA7KSLqLiNYOALRZmAMhP+LiFe14Bd1UQKPPqZ4OqzEzzDsHOXoN2O3n7fotlPzlDMSOAE559EBDrTCZbe0QhGb0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:d8d:b0:65b:8181:e18d with SMTP id
 006d021491bc7-65b8181e33bmr1510457eaf.28.1765960184779; Wed, 17 Dec 2025
 00:29:44 -0800 (PST)
Date: Wed, 17 Dec 2025 00:29:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694269f8.a70a0220.207337.0046.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in __btrfs_update_delayed_inode (3)
From: syzbot <syzbot+d85308bac7187ac131d3@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9551a26f17d9 Merge tag 'loongarch-6.19' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=141f31b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f315601b98a91c0b
dashboard link: https://syzkaller.appspot.com/bug?extid=d85308bac7187ac131d3
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b23c812ec291/disk-9551a26f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b0564ab1672/vmlinux-9551a26f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b8aac5f6fcdb/bzImage-9551a26f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d85308bac7187ac131d3@syzkaller.appspotmail.com

------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: fs/btrfs/delayed-inode.c:1039 at 0x0, CPU#1: syz.1.67/6479
Modules linked in:
CPU: 1 UID: 0 PID: 6479 Comm: syz.1.67 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:__btrfs_update_delayed_inode+0xcc6/0xed0 fs/btrfs/delayed-inode.c:1039
Code: d1 e1 fd e9 22 01 00 00 e8 57 aa c7 fd 84 c0 74 23 e8 8e d1 e1 fd e9 0f 01 00 00 e8 84 d1 e1 fd 48 8d 3d 5d 2d 05 0b 44 89 ee <67> 48 0f b9 3a e9 2c 01 00 00 e8 3b 97 f4 06 89 c3 31 ff 89 c6 e8
RSP: 0018:ffffc9000daf7080 EFLAGS: 00010283
RAX: ffffffff83dea0bc RBX: 00000000ffffffe4 RCX: 0000000000080000
RDX: ffffc9000d259000 RSI: 00000000ffffffe4 RDI: ffffffff8ee3ce20
RBP: ffffc9000daf7190 R08: ffff888028a01e40 R09: 0000000000000003
R10: 0000000000000100 R11: 00000000fffffffb R12: ffff88805e9ad9b0
R13: 00000000ffffffe4 R14: ffff88803dd5d580 R15: 0000000000000000
FS:  00007f393a8ee6c0(0000) GS:ffff888126e06000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f87afed8000 CR3: 000000003a514000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 btrfs_update_delayed_inode fs/btrfs/delayed-inode.c:1115 [inline]
 __btrfs_commit_inode_delayed_items+0x1cfc/0x1e70 fs/btrfs/delayed-inode.c:1138
 __btrfs_run_delayed_items+0x215/0x540 fs/btrfs/delayed-inode.c:1173
 btrfs_commit_transaction+0x8cb/0x3b10 fs/btrfs/transaction.c:2343
 prepare_to_relocate+0x3a1/0x490 fs/btrfs/relocation.c:3479
 relocate_block_group+0x132/0xd70 fs/btrfs/relocation.c:3504
 btrfs_relocate_block_group+0x580/0xba0 fs/btrfs/relocation.c:3966
 btrfs_relocate_chunk+0x12f/0x5d0 fs/btrfs/volumes.c:3424
 __btrfs_balance+0x190e/0x24f0 fs/btrfs/volumes.c:4197
 btrfs_balance+0xac2/0x11b0 fs/btrfs/volumes.c:4571
 btrfs_ioctl_balance+0x3d6/0x610 fs/btrfs/ioctl.c:3525
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xff/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f393c68f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f393a8ee038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f393c8e5fa0 RCX: 00007f393c68f749
RDX: 0000200000000180 RSI: 00000000c4009420 RDI: 0000000000000004
RBP: 00007f393c713f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f393c8e6038 R14: 00007f393c8e5fa0 R15: 00007ffd84049f78
 </TASK>
----------------
Code disassembly (best guess):
   0:	d1 e1                	shl    %ecx
   2:	fd                   	std
   3:	e9 22 01 00 00       	jmp    0x12a
   8:	e8 57 aa c7 fd       	call   0xfdc7aa64
   d:	84 c0                	test   %al,%al
   f:	74 23                	je     0x34
  11:	e8 8e d1 e1 fd       	call   0xfde1d1a4
  16:	e9 0f 01 00 00       	jmp    0x12a
  1b:	e8 84 d1 e1 fd       	call   0xfde1d1a4
  20:	48 8d 3d 5d 2d 05 0b 	lea    0xb052d5d(%rip),%rdi        # 0xb052d84
  27:	44 89 ee             	mov    %r13d,%esi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	e9 2c 01 00 00       	jmp    0x160
  34:	e8 3b 97 f4 06       	call   0x6f49774
  39:	89 c3                	mov    %eax,%ebx
  3b:	31 ff                	xor    %edi,%edi
  3d:	89 c6                	mov    %eax,%esi
  3f:	e8                   	.byte 0xe8


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

