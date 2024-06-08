Return-Path: <linux-btrfs+bounces-5570-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 812DA900F74
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 06:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E043A282C1D
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 04:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08C912E71;
	Sat,  8 Jun 2024 04:19:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C62AB64E
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2024 04:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717820372; cv=none; b=K9Bjf+JzqZCNycNyzKNsO1weA/RQ3uFa5LW7eLEFUBRA+oWTdXVGr/lDg6EVph/xPRDowljeJz1d+akTkHVGlu9oThZTLaPnE41xQu0PzUTc9fjECiQiUBovGr60i1RM92cb0xGIPHQhR9rv+YiFo8CByl1k5EDfcNZ/15EsltY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717820372; c=relaxed/simple;
	bh=X0teV559jlfZtNFTdn0vczKwkiEC69CYvIAxRsiPpCA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mud+UnwVpxuTlZDHKzDotlint2LFPbxXUMIscpJoQf2W4GYdIDXxCuVU5ZzUJNtUv34HdDT4m+fKutUmdFVfqyme72U3oYCYahLjkAv/mXVjSg2S/XCHT0kzU7g64w9t3B4S2eW0CUKtkGipnt/GqDFzIS+23XUu0luUN7eXm+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-36db3bbf931so30908835ab.0
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jun 2024 21:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717820369; x=1718425169;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aFuJHIowLvdv+S/MY3yW2L+R0NtntumzDdr8pfEPbnA=;
        b=nfAz/JPIIP7JYvB0YSxTsCjjvSXE4Yh2dU2/7FJCBPxL3Ac/kqSLwK0Mak7KaEg5k1
         e2cj+XuIZRoejc7e+bTvg3KHcJALoixxJ4SH4A2sl4+T0fyh+YN5mR5ubkTzYsgBbTXk
         GTPIcGacV2RTN0UCxwK7TjNo9/1kMEJ93CkmKfunG78USdlEzDVVxB100Xt4bE1cNOul
         oKtKM+uEqfZMwx3P1Sfvtzu//HfyFGkK9MqjT1kMC+Y99gxrse43GELY+0Lj5xzOQ3vy
         ostqEYBcdG9G4tnDqqpLDdQxAg/EP9hncjSGoydRbLZYv7bgYTvrxkRY1SnrDn0RLQKR
         Nm+g==
X-Forwarded-Encrypted: i=1; AJvYcCUzhsrjCD8CzfDnpTQgOdCzis9MSSR+iiIGRmUFBcFnxVzK4thT7bMkEfWByAhEKcJBrOoB8ss041STGyS7v2b/VVuNsjIWWAWUJ1k=
X-Gm-Message-State: AOJu0YwWvsDvfUdDnQacVU1V837tRmjuT94WEQq6KA8sUJssuwX8VnVe
	QHQP6T8TLfqxzinPiXiFEvf59kj8Fq2TFlWiJo2gUU/SgUa+epR1fNkxcaFjBgt2pR5YWQjMHxV
	DEceOoQGW2LjortntExqCfxbkQhaB0lk/aUsvMX0LArZRNUpIlgRB0A8=
X-Google-Smtp-Source: AGHT+IG+tBNAsB4soo5Wd1WTLfqHn2iEeP1fHWDV1vVAOHz8Q9oGKp+gOvSsE42TikUV3AwOJ+seTavtBssdIgKSiDfGZXBYwqMc
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4b:b0:369:f7ca:a361 with SMTP id
 e9e14a558f8ab-37580303aebmr3387565ab.1.1717820368771; Fri, 07 Jun 2024
 21:19:28 -0700 (PDT)
Date: Fri, 07 Jun 2024 21:19:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de6b81061a5938d6@google.com>
Subject: [syzbot] [btrfs?] INFO: trying to register non-static key in btrfs_stop_all_workers
From: syzbot <syzbot+8e86db7d430e87415248@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f06ce441457d Merge tag 'loongarch-fixes-6.10-1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=176b7026980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=998c63c06e77f5e7
dashboard link: https://syzkaller.appspot.com/bug?extid=8e86db7d430e87415248
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-f06ce441.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/67a525046331/vmlinux-f06ce441.xz
kernel image: https://storage.googleapis.com/syzbot-assets/01865e308aa0/bzImage-f06ce441.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8e86db7d430e87415248@syzkaller.appspotmail.com

BTRFS info (device loop2): last unmount of filesystem 395ef67a-297e-477c-816d-cd80a5b93e5d
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 9630 Comm: syz-executor.2 Not tainted 6.10.0-rc2-syzkaller-00007-gf06ce441457d #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 assign_lock_key kernel/locking/lockdep.c:976 [inline]
 register_lock_class+0xc2a/0x1230 kernel/locking/lockdep.c:1289
 __lock_acquire+0x111/0x3b30 kernel/locking/lockdep.c:5014
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0x36/0x50 kernel/locking/spinlock.c:170
 put_pwq_unlocked kernel/workqueue.c:1662 [inline]
 put_pwq_unlocked kernel/workqueue.c:1655 [inline]
 destroy_workqueue+0x5df/0xaa0 kernel/workqueue.c:5851
 btrfs_stop_all_workers+0x29f/0x370 fs/btrfs/disk-io.c:1804
 close_ctree+0x4e3/0xf90 fs/btrfs/disk-io.c:4365
 generic_shutdown_super+0x159/0x3d0 fs/super.c:642
 kill_anon_super+0x3a/0x60 fs/super.c:1226
 btrfs_kill_super+0x3b/0x50 fs/btrfs/super.c:2096
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
 deactivate_super+0xde/0x100 fs/super.c:506
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf72e5579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffbeced8 EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffbecf80 RCX: 0000000000000009
RDX: 00000000f743bff4 RSI: 00000000f738c361 RDI: 00000000ffbee024
RBP: 00000000ffbecf80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in kernel/locking/qspinlock.c:131:9
index 855 is out of range for type 'long unsigned int [8]'
CPU: 0 PID: 9630 Comm: syz-executor.2 Not tainted 6.10.0-rc2-syzkaller-00007-gf06ce441457d #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x110/0x150 lib/ubsan.c:429
 decode_tail kernel/locking/qspinlock.c:131 [inline]
 __pv_queued_spin_lock_slowpath+0xcb2/0xcc0 kernel/locking/qspinlock.c:468
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x210/0x2c0 kernel/locking/spinlock_debug.c:116
 put_pwq_unlocked kernel/workqueue.c:1662 [inline]
 put_pwq_unlocked kernel/workqueue.c:1655 [inline]
 destroy_workqueue+0x5df/0xaa0 kernel/workqueue.c:5851
 btrfs_stop_all_workers+0x29f/0x370 fs/btrfs/disk-io.c:1804
 close_ctree+0x4e3/0xf90 fs/btrfs/disk-io.c:4365
 generic_shutdown_super+0x159/0x3d0 fs/super.c:642
 kill_anon_super+0x3a/0x60 fs/super.c:1226
 btrfs_kill_super+0x3b/0x50 fs/btrfs/super.c:2096
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
 deactivate_super+0xde/0x100 fs/super.c:506
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf72e5579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffbeced8 EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffbecf80 RCX: 0000000000000009
RDX: 00000000f743bff4 RSI: 00000000f738c361 RDI: 00000000ffbee024
RBP: 00000000ffbecf80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
---[ end trace ]---
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

