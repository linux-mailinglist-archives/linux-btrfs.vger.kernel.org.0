Return-Path: <linux-btrfs+bounces-7793-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B34996A4AE
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 18:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997011F23BD1
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 16:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F63018BC30;
	Tue,  3 Sep 2024 16:42:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B8D18BC11
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381749; cv=none; b=I55dV8HiO4+BXKwvCYM42iINxTpRkWiF0w5q2+LVOvHX8XSj5ZVbr+jOXe4Esa/ONN+bto1/gwnzcDjxvRScapzYDGdwVaaRw3aYGs9gZoZXs6f4gfFWYTDqJHW5OoXIQNxkR6gG9Jr898ZP0V0qraHCderoOkv8G9Pjb+hhiYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381749; c=relaxed/simple;
	bh=T+hxNDjjWwRCZ4d+SWr9x2bgF8PDTpQjDBuji2be/oM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KqunLpUxr0eHJuNibyF2fTy6baxFYf2xD2XviG53MwBAgEz1BEivFke6+R32iPSTmnr0LPOkqrqyTdWrrg99uym6C2f7/ywm9fNweZqj8ZiiIZhBgaYnfx34EDX7Hx07pb4Yy6vAFRsGujiUoeQLEx8TINRFoVpj5LN9nk5wKlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a330ab764so419768039f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Sep 2024 09:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725381746; x=1725986546;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Od3Fg/J+auF2dT/V8kiIX6aTrRBNDcmt6+YUb4C/pcE=;
        b=r8G04wa2Pbzao8p9aMcMsFPJIynEYb8EW79yfLN7jhomlURIUrSGWvB2TtNDfBdZW8
         asyUSiqBeYdZswakQZKyvd4AvMkjldvl96Hohhz+kues80QhHRU8r1KeTTlH0tJ9QyHs
         iTNiQT2b56gmGoZnnRHfpdXnfh0jqwfQN0W4GynoMBZUXGxqdC5o0uF03NE0o9H84wDI
         onitg4C7bjM6g3zP7rBMnIBlxoUUpI8oYlVpsNlwlnxTjD1clr0VJf4fMnRY/7tKUyd/
         H+pLWvorkNJma6HT4s6IY9XMb0ch3U54A+B/DpKl1fWkv3v1uITS3TJ7xH6y3CMoH2AO
         QMhw==
X-Forwarded-Encrypted: i=1; AJvYcCUII7Nz2K/5GlAOCqlvmF7PNeXKvTQaxFVZrcAp0ts2Op/ylXGeHnfMhQrHdHF8bstYrT8U0xgDmwWk/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvaVcqR8+IGlESLSMNjOaFUu6RcnEw8vM2ZKCUz0KcTlGHEd7N
	8MXLBt34H38RzNERoY9OQYtlqqAAlQ0xZdY1x44WdCO1peSJ1rY0fGbogBjHytWaT2MlS87zLl1
	7irIJLgWKpeSndd1RpcnOTfcShaGwQlEOSUWtXyWJ9Kr4NzFLDhtcxbM=
X-Google-Smtp-Source: AGHT+IFEW74CvGS49DVdlBBwU0X61h5ahASOjkE+vHc3S9GKBA8FN2UARl3OcPybeF7q3Olj4OHDeEW0yUIGtdL2LHI6KX9liSCw
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14c2:b0:822:45d1:5d82 with SMTP id
 ca18e2360f4ac-82a26118194mr112406939f.0.1725381746575; Tue, 03 Sep 2024
 09:42:26 -0700 (PDT)
Date: Tue, 03 Sep 2024 09:42:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b6052062139be1c@google.com>
Subject: [syzbot] [btrfs?] general protection fault in btrfs_root_node
From: syzbot <syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    20371ba12063 Merge tag 'drm-fixes-2024-08-30' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16206c53980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=9c3e0cdfbfe351b0bc0e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16778a63980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14924339980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-20371ba1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/35987fde8063/vmlinux-20371ba1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1012e3751087/bzImage-20371ba1.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/892f30044c3a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com

BTRFS info (device loop0): using crc32c (crc32c-intel) checksum algorithm
BTRFS info (device loop0): using free-space-tree
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 UID: 0 PID: 5105 Comm: syz-executor368 Not tainted 6.11.0-rc5-syzkaller-00176-g20371ba12063 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btrfs_root_node+0x86/0x3b0 fs/btrfs/ctree.c:260
Code: a0 aa c8 fd 48 83 c4 08 e8 47 80 12 08 89 c3 31 ff 89 c6 e8 4c 6f ec fd 85 db 74 17 e8 33 a1 d2 fd 84 c0 74 1c e8 fa 6a ec fd <43> 80 3c 3c 00 75 4b eb 51 e8 ec 6a ec fd 43 80 3c 3c 00 75 3d eb
RSP: 0018:ffffc90000e376c0 EFLAGS: 00010293
RAX: ffffffff83a72136 RBX: 0000000000000001 RCX: ffff888000784880
RDX: 0000000000000000 RSI: ffffffff8c608d20 RDI: ffffffff8c608ce0
RBP: ffffc90000e378b0 R08: ffffffff83a72124 R09: 1ffffffff283c908
R10: dffffc0000000000 R11: fffffbfff283c909 R12: 0000000000000003
R13: dffffc0000000000 R14: 0000000000000018 R15: dffffc0000000000
FS:  0000555578f7a380(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f674dc59068 CR3: 0000000034fa8000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_read_lock_root_node+0x27/0xd0 fs/btrfs/locking.c:279
 btrfs_build_ref_tree+0x112/0x16f0 fs/btrfs/ref-verify.c:1005
 open_ctree+0x1fea/0x2a10 fs/btrfs/disk-io.c:3533
 btrfs_fill_super fs/btrfs/super.c:965 [inline]
 btrfs_get_tree_super fs/btrfs/super.c:1888 [inline]
 btrfs_get_tree+0xe7a/0x1920 fs/btrfs/super.c:2114
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 fc_mount+0x1b/0xb0 fs/namespace.c:1231
 btrfs_get_tree_subvol fs/btrfs/super.c:2077 [inline]
 btrfs_get_tree+0x652/0x1920 fs/btrfs/super.c:2115
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3e4d3e7eea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcc9f71558 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffcc9f71560 RCX: 00007f3e4d3e7eea
RDX: 0000000020005100 RSI: 0000000020000040 RDI: 00007ffcc9f71560
RBP: 0000000000000004 R08: 00007ffcc9f715a0 R09: 0000000000005110
R10: 0000000000a08811 R11: 0000000000000282 R12: 00007ffcc9f715a0
R13: 0000000000000003 R14: 0000000001000000 R15: 00007f3e4d42f03b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_root_node+0x86/0x3b0 fs/btrfs/ctree.c:260
Code: a0 aa c8 fd 48 83 c4 08 e8 47 80 12 08 89 c3 31 ff 89 c6 e8 4c 6f ec fd 85 db 74 17 e8 33 a1 d2 fd 84 c0 74 1c e8 fa 6a ec fd <43> 80 3c 3c 00 75 4b eb 51 e8 ec 6a ec fd 43 80 3c 3c 00 75 3d eb
RSP: 0018:ffffc90000e376c0 EFLAGS: 00010293
RAX: ffffffff83a72136 RBX: 0000000000000001 RCX: ffff888000784880
RDX: 0000000000000000 RSI: ffffffff8c608d20 RDI: ffffffff8c608ce0
RBP: ffffc90000e378b0 R08: ffffffff83a72124 R09: 1ffffffff283c908
R10: dffffc0000000000 R11: fffffbfff283c909 R12: 0000000000000003
R13: dffffc0000000000 R14: 0000000000000018 R15: dffffc0000000000
FS:  0000555578f7a380(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005610c6449d38 CR3: 0000000034fa8000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	a0 aa c8 fd 48 83 c4 	movabs 0xe808c48348fdc8aa,%al
   7:	08 e8
   9:	47 80 12 08          	rex.RXB adcb $0x8,(%r10)
   d:	89 c3                	mov    %eax,%ebx
   f:	31 ff                	xor    %edi,%edi
  11:	89 c6                	mov    %eax,%esi
  13:	e8 4c 6f ec fd       	call   0xfdec6f64
  18:	85 db                	test   %ebx,%ebx
  1a:	74 17                	je     0x33
  1c:	e8 33 a1 d2 fd       	call   0xfdd2a154
  21:	84 c0                	test   %al,%al
  23:	74 1c                	je     0x41
  25:	e8 fa 6a ec fd       	call   0xfdec6b24
* 2a:	43 80 3c 3c 00       	cmpb   $0x0,(%r12,%r15,1) <-- trapping instruction
  2f:	75 4b                	jne    0x7c
  31:	eb 51                	jmp    0x84
  33:	e8 ec 6a ec fd       	call   0xfdec6b24
  38:	43 80 3c 3c 00       	cmpb   $0x0,(%r12,%r15,1)
  3d:	75 3d                	jne    0x7c
  3f:	eb                   	.byte 0xeb


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

