Return-Path: <linux-btrfs+bounces-17300-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A930BAE8A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 22:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C83175EAC
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 20:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E1F24C06A;
	Tue, 30 Sep 2025 20:29:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7EC34BA32
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Sep 2025 20:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759264174; cv=none; b=YVByFkuaxrz+60/OR2fg9lCrW1juzl76LlNUgsnhSUGcfMmt1lP/SYNqj7zCOGN/U2rBM1PKmqDeuVSF9onz74tROw2giEuXws0zV1K9veR52ZoK2WBvZImtLvF3+rH7YNKe9+JvWr3mu5Ml+2OvodRq+4Jo3X1CqLh8DUyarO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759264174; c=relaxed/simple;
	bh=HYVrxLorviy9/LcLk+sJcFHB5u8xcwx12lbV6OBKubw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OnuNCvFwsICLLWsQyGQ97e/+o5OJjAsNQGQxC85ue+bjrfPrH2l9R51jT2xCk7XtqFmwE28p1QRnM9wHL03utbWG0Kg+vnRVnr1BpbABIw2Gk0VcmBMxcezOwuQT0wX8p1BB7OEMvTeaui2OnowNVbSz6VoxtRaRnmzr20WPKAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-428feeed482so37165295ab.1
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Sep 2025 13:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759264172; x=1759868972;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XjLWIlvweUHagMNdlXHm8j88YhPLq+xnooiFq97mL4I=;
        b=wfO7mpQKceBgwIQSsNL8Q5G56v/n09Jh/2BxJnUmCUDzdrUSV8W8iBY1ZicMcCXeF1
         miUCM6t27L6z9rg/YSZBseLE97cU3/dUx28Hur4f5T3LnVU95WQ+/8Kg6kFjsCcSGY62
         ELzMDnCpKKQVIejs4yO3eOpArWoEruh5insIpJAbAsJJ/b34AfXrKGkmAdTkOW17uy51
         fUN8AN/7e6ESwF/TOEwVaeRL2kc++FqRZHs8HPKG4yOTxF47XmfOJP6shUQqVjkd+O0s
         VXeIpq+47GGJoPJoq8zdx4/9xaOxY2D3NZ05DxVcx9yfMik9vWsB5EQWgHyttyiV7v+p
         5VyA==
X-Forwarded-Encrypted: i=1; AJvYcCWsm5PzAH4PrZBiGfbkozOJkA1YPxbLbVRtXvOTE56fDSneCYg0vGm5ieAPj6IgaQRnX+bQgEhTwqdG/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaKiBx++3WK2futeWdq1O8Fcj1OPMmtggalEnhg0lvLy4zELYa
	jtsfKYtxSDQ9zc2EwfWnAHOiRdr2jLaepdb7p3ebR0PhbK2gN1LvGJ0CjefLPVbm1PHbAa27Nf8
	ZagNW4bh5sfsbeEmGcOZujzC/aHib762hldLCXp7L13TZp9uzxouNmJYSb/I=
X-Google-Smtp-Source: AGHT+IHAiZHIaPR3+uqTjIwMls4jnI6NenQ9eHlcMquZTT5xpAYj4H7IeVo/3QFcEIjKxACEGR9F9zY+6pg98Qr9jhrg1gsK4tAX
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa4:b0:413:d5e2:b751 with SMTP id
 e9e14a558f8ab-42d815ab94emr20716375ab.6.1759264171998; Tue, 30 Sep 2025
 13:29:31 -0700 (PDT)
Date: Tue, 30 Sep 2025 13:29:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dc3dab.a00a0220.102ee.004e.GAE@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in populate_free_space_tree (2)
From: syzbot <syzbot+884dc4621377ba579a6f@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3b9b1f8df454 Add linux-next specific files for 20250929
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12785ae2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7658505af38711c6
dashboard link: https://syzkaller.appspot.com/bug?extid=884dc4621377ba579a6f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170e2334580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2484efae3582/disk-3b9b1f8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c39cb0b765cf/vmlinux-3b9b1f8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5aaf42edc1cb/bzImage-3b9b1f8d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8172ca4171ed/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=13de6942580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+884dc4621377ba579a6f@syzkaller.appspotmail.com

BTRFS warning: 'usebackuproot' is deprecated, use 'rescue=usebackuproot' instead
BTRFS info (device loop3 state M): rebuilding free space tree
assertion failed: ret == 0 :: 0, in fs/btrfs/free-space-tree.c:1115
------------[ cut here ]------------
kernel BUG at fs/btrfs/free-space-tree.c:1115!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 6352 Comm: syz.3.25 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:populate_free_space_tree+0x700/0x710 fs/btrfs/free-space-tree.c:1115
Code: ff ff e8 d3 74 d2 fd 48 c7 c7 80 0a f0 8b 48 c7 c6 60 12 f0 8b 31 d2 48 c7 c1 e0 08 f0 8b 41 b8 5b 04 00 00 e8 81 c1 39 fd 90 <0f> 0b 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
RSP: 0018:ffffc9000430f780 EFLAGS: 00010246
RAX: 0000000000000043 RBX: ffff88805b709630 RCX: fea61d0e2e79d000
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000430f8b0 R08: ffffc9000430f4a7 R09: 1ffff92000861e94
R10: dffffc0000000000 R11: fffff52000861e95 R12: 0000000000000001
R13: 1ffff92000861f00 R14: dffffc0000000000 R15: 0000000000000000
FS:  00007f424d9fe6c0(0000) GS:ffff888125afc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd78ad212c0 CR3: 0000000076d68000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 btrfs_rebuild_free_space_tree+0x1ba/0x6d0 fs/btrfs/free-space-tree.c:1364
 btrfs_start_pre_rw_mount+0x128f/0x1bf0 fs/btrfs/disk-io.c:3062
 btrfs_remount_rw fs/btrfs/super.c:1334 [inline]
 btrfs_reconfigure+0xaed/0x2160 fs/btrfs/super.c:1559
 reconfigure_super+0x227/0x890 fs/super.c:1076
 do_remount fs/namespace.c:3279 [inline]
 path_mount+0xd1a/0xfe0 fs/namespace.c:4027
 do_mount fs/namespace.c:4048 [inline]
 __do_sys_mount fs/namespace.c:4236 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4213
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f424e39066a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f424d9fde68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f424d9fdef0 RCX: 00007f424e39066a
RDX: 0000200000000180 RSI: 0000200000000380 RDI: 0000000000000000
RBP: 0000200000000180 R08: 00007f424d9fdef0 R09: 0000000000000020
R10: 0000000000000020 R11: 0000000000000246 R12: 0000200000000380
R13: 00007f424d9fdeb0 R14: 0000000000000000 R15: 00002000000002c0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:populate_free_space_tree+0x700/0x710 fs/btrfs/free-space-tree.c:1115
Code: ff ff e8 d3 74 d2 fd 48 c7 c7 80 0a f0 8b 48 c7 c6 60 12 f0 8b 31 d2 48 c7 c1 e0 08 f0 8b 41 b8 5b 04 00 00 e8 81 c1 39 fd 90 <0f> 0b 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
RSP: 0018:ffffc9000430f780 EFLAGS: 00010246
RAX: 0000000000000043 RBX: ffff88805b709630 RCX: fea61d0e2e79d000
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000430f8b0 R08: ffffc9000430f4a7 R09: 1ffff92000861e94
R10: dffffc0000000000 R11: fffff52000861e95 R12: 0000000000000001
R13: 1ffff92000861f00 R14: dffffc0000000000 R15: 0000000000000000
FS:  00007f424d9fe6c0(0000) GS:ffff888125afc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd78ad212c0 CR3: 0000000076d68000 CR4: 00000000003526f0


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

