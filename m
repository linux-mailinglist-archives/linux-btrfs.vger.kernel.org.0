Return-Path: <linux-btrfs+bounces-5154-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C328CADD4
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 14:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B600A1F23636
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 12:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B207603A;
	Tue, 21 May 2024 12:03:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248FA74C08
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292985; cv=none; b=Zu+DfQ/Pc3ym5qoQs6XwgE663DD73gbv5eb30EocqgTW3Rc2Rqvle7leGAlnFx/NVo2CCY0rfAslNThS2AheydRPstPDIbOY3XjanYZDAZlud6c+t/rgEVSIafV36CajUvkh8qgwUXNyDnD1jWldYC2M3DGLO/zZnM96emFYZf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292985; c=relaxed/simple;
	bh=u3iIttHg9NASbB6DzCxhtGEaurumyZBrd5vYTbWrC9U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PkY6C4WMU40a6DKlUbBgm+Nyhgbj2xI3L5TmnNEJ3+jn9DpllQct6XpD1Wa0Fdo96F2yRUUjE+lNYd6Zxo8NhigYiRN6bLA2RC6o0ZLaw/4DuqGRqsBJAulF9afJXv7qAmc9lEuqM9JU06osffws1bW3F+JSm31Mdb26KdW7gQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e17eba6ba3so1128898239f.3
        for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 05:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716292983; x=1716897783;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EuW1xXVlFP0pYy5SWrOSCxRjFQR2tPJVuYwPOncInug=;
        b=u41yddqSj/0mnrhdxLvEQHxHGCsLiHqFwubpmCT/5HIMj/NBLsiQwiNvVEIFbhex5L
         OAnUNcLek3ZedE2cOOM66yYUIpNhMI1VaQRoqQ7qCcE3/KSzcId4lMJRH/6DCX6mZm1R
         O1Y3Uf4HNHhPZQxMbdK/te0/xByKBlzR6IJEmzHd35h9RexaR679t5g+bqjRCTLawoky
         6AwSMn7A8z9nBX9vRvACiPue5ek87cA7X4TJGTt2k2TqCd+LK3iJHSXhV4RTMS168JQh
         SElAbpY6uINRUzi3wKLGf4jIELL2XYXHmZO1GjcDV3pu4wlxNRT03Ck9w4PrFjWHwwwo
         9HSw==
X-Forwarded-Encrypted: i=1; AJvYcCWv+zw6RXgwQr8RMAzLGDr9DIpvbBDIC+7zPnOdhdsaCuZJ9/1EIa2oqd+xOEb3YYcYyr6feRQN3sdQkTeoRJ5FXhM7IQnSGQrtP/U=
X-Gm-Message-State: AOJu0YxTi9H9kIEAlPABV+El7mPgSuNmiamSx2q5/k9epN23zhWXuEbL
	Q6p99J9a2licbEKXopm4rjJmCESBe6s4Vl50M8udS8q6RALRQr7IW04K8LgrZKTzDP59908SsIv
	iQg5Z0bOTjYKd6swfdvv8KeCuX3ky4KBEUDIheCrMbLkZXkZkLY3xE5E=
X-Google-Smtp-Source: AGHT+IFpQf/UUnB15kOQUyjZIBSC8oBVwHr2UqFbSdipg+k+Bml8AV7Cd4EpT2T+3Nr0XtQyNl0BZuHP2KTTkST4Vw8eOLq+NOlY
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f85:b0:7da:9d28:6578 with SMTP id
 ca18e2360f4ac-7e1b521c6famr117103939f.3.1716292983335; Tue, 21 May 2024
 05:03:03 -0700 (PDT)
Date: Tue, 21 May 2024 05:03:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009a4d470618f599f2@google.com>
Subject: [syzbot] [btrfs?] general protection fault in put_pwq_unlocked
From: syzbot <syzbot+bce6ef1d850c98d6d157@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f6a15f095a6 Merge tag 'cocci-for-6.10' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1736b784980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6be91306a8917025
dashboard link: https://syzkaller.appspot.com/bug?extid=bce6ef1d850c98d6d157
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f30c87f89d17/disk-8f6a15f0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3d73f0e35e13/vmlinux-8f6a15f0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3d524f6fb25b/bzImage-8f6a15f0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bce6ef1d850c98d6d157@syzkaller.appspotmail.com

BTRFS info (device loop3): last unmount of filesystem c9fe44da-de57-406a-8241-57ec7d4412cf
Oops: general protection fault, probably for non-canonical address 0xe01ffbf11002a143: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0x00ffff8880150a18-0x00ffff8880150a1f]
CPU: 0 PID: 8186 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller-10323-g8f6a15f095a6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:__lock_acquire+0x6a/0x1fd0 kernel/locking/lockdep.c:5005
Code: df 0f b6 04 30 84 c0 0f 85 4b 16 00 00 83 3d 28 c3 39 0e 00 0f 84 1c 11 00 00 83 3d 5f 8b ad 0c 00 74 2c 4c 89 e0 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 e7 e8 c8 42 86 00 48 be 00 00 00 00 00 fc
RSP: 0000:ffffc900041bf790 EFLAGS: 00010002
RAX: 001ffff11002a143 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 00ffff8880150a18
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: dffffc0000000000 R11: fffffbfff1f5818e R12: 00ffff8880150a18
R13: 0000000000000001 R14: ffff88802658da00 R15: 0000000000000000
FS:  00005555668d4480(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6558b0b000 CR3: 0000000067b3c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0xd3/0x120 kernel/locking/spinlock.c:170
 put_pwq_unlocked+0x42/0x190 kernel/workqueue.c:1662
 destroy_workqueue+0x9a4/0xc40 kernel/workqueue.c:5851
 btrfs_destroy_workqueue+0x45/0x260 fs/btrfs/async-thread.c:360
 btrfs_stop_all_workers+0x15a/0x2a0 fs/btrfs/disk-io.c:1797
 close_ctree+0x67d/0xd20 fs/btrfs/disk-io.c:4365
 generic_shutdown_super+0x136/0x2d0 fs/super.c:642
 kill_anon_super+0x3b/0x70 fs/super.c:1226
 btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2088
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x102/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff305e7e217
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007fff1d9a1428 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007ff305e7e217
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fff1d9a14e0
RBP: 00007fff1d9a14e0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fff1d9a25a0
R13: 00007ff305ec8336 R14: 00000000000507f7 R15: 0000000000000006
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x6a/0x1fd0 kernel/locking/lockdep.c:5005
Code: df 0f b6 04 30 84 c0 0f 85 4b 16 00 00 83 3d 28 c3 39 0e 00 0f 84 1c 11 00 00 83 3d 5f 8b ad 0c 00 74 2c 4c 89 e0 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 e7 e8 c8 42 86 00 48 be 00 00 00 00 00 fc
RSP: 0000:ffffc900041bf790 EFLAGS: 00010002
RAX: 001ffff11002a143 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 00ffff8880150a18
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: dffffc0000000000 R11: fffffbfff1f5818e R12: 00ffff8880150a18
R13: 0000000000000001 R14: ffff88802658da00 R15: 0000000000000000
FS:  00005555668d4480(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6558b0b000 CR3: 0000000067b3c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	df 0f                	fisttps (%rdi)
   2:	b6 04                	mov    $0x4,%dh
   4:	30 84 c0 0f 85 4b 16 	xor    %al,0x164b850f(%rax,%rax,8)
   b:	00 00                	add    %al,(%rax)
   d:	83 3d 28 c3 39 0e 00 	cmpl   $0x0,0xe39c328(%rip)        # 0xe39c33c
  14:	0f 84 1c 11 00 00    	je     0x1136
  1a:	83 3d 5f 8b ad 0c 00 	cmpl   $0x0,0xcad8b5f(%rip)        # 0xcad8b80
  21:	74 2c                	je     0x4f
  23:	4c 89 e0             	mov    %r12,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 30 00          	cmpb   $0x0,(%rax,%rsi,1) <-- trapping instruction
  2e:	74 12                	je     0x42
  30:	4c 89 e7             	mov    %r12,%rdi
  33:	e8 c8 42 86 00       	call   0x864300
  38:	48                   	rex.W
  39:	be 00 00 00 00       	mov    $0x0,%esi
  3e:	00 fc                	add    %bh,%ah


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

