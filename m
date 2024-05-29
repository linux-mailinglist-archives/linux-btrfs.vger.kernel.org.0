Return-Path: <linux-btrfs+bounces-5355-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 445B78D3AC0
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 17:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8B91F24552
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 15:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED99C1802C5;
	Wed, 29 May 2024 15:24:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F226954670
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716996274; cv=none; b=c5cvoIkhO4bCCp4J3Q3ppc/kT0PvHr8ifoEpSGKV3VN+CzwNwdX4yRUFtmsWj0DOecQuVVgkdhldwHQOXTs7WHEwDJGt+3NQ3Y1QTXGUYKM8a0yxi6hZgouZIeogpUR+PBbghokb8wu4CRf6vbcVPnGpLCkIxyHFVmdUSGnwSxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716996274; c=relaxed/simple;
	bh=gR0NR/W1POMlud6zuz0vhVTDnOnvRmP3UrY+oEDtI3g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ChtqjM1DBrVqmQATACGTnOoblWp+Iq76ub5h52Woh9raYjQ4+4NC6VH1isQBJXBmEt8lXiOuRGCHvPbyG8HYeWE62Klk/afImxrUihU9iCp+j5pxAWQ9REZGC+8lBVDl+NL4MlcNGdo3UYoB12+mm/ycMI6FEtVHHdIZSZkAzPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7eaccb5a928so246125339f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 08:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716996272; x=1717601072;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S7PgD150ZW6PXwRjk11mPZpnSNlflnT2YoZOVl9KBTE=;
        b=LESMzgoKfxwI6de/6CHvRgCzsnOziFxiDTga6zwkIyemRYyHRjPChzp4AbUCeiRqHm
         NxdfcD48Xvf9KzNhbcSlBV9BjjPHia+jp3Cm1FOJl10LkaUqIvrTKcn1BmeIRUxLYBUH
         uzfdFtP+hBq5cBJwxP4hTj0vaBeTkGKSClPsrejfIAeVHNh1ykGClUrX7zvJQ5Gj7aZE
         tvUowMuQAhsh5jXb21Dj3if7zLfffy6z5pnwtWZujP/45BGhRnIA4cGWd+v58PHCvVx4
         1+/CWM/KaEeY/VBDMmfCyJ57+gUxPr1ocpju+ER4yPQVn9y1xV0EuWFVyrTDz2oV4FfA
         QVkw==
X-Forwarded-Encrypted: i=1; AJvYcCWVTBXmpbirb15IhzWXUuh2qlXn5pW3utiYqgo9E0t8IN2cP9nzevqltx9qUlM5pgQvFNXAgnucmhvQOcTRfI9DZD1l6mDtq4DJqLQ=
X-Gm-Message-State: AOJu0Yyuwb9mbJwK213OsOsNtET4t00LfMNsP/pzyngQvKvK0Znzxf43
	4Tp6dNglJRxRs/ZXAeBLenxpjZS8k2uwLQrUYvkILJtQBF1ANDSazCTndMni4tbzJFzW9eRrch6
	1tv1ZpXG6GYl9OUHd5RliA7FRgDpKrfT02dzSHUH8epL/9WWPE6uSr3U=
X-Google-Smtp-Source: AGHT+IFlKz8QNaJRUpPZQhyOOBuMXKZXEXbuQQNrR24eq0OlB/Cr+M+JD+pmsFrLUnjVmmMNq+KGZt+/psZN+CS0dYUNcW+r5hRx
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4c86:b0:488:75e3:f3c1 with SMTP id
 8926c6da1cb9f-4b03f171269mr329972173.0.1716996272152; Wed, 29 May 2024
 08:24:32 -0700 (PDT)
Date: Wed, 29 May 2024 08:24:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e1f2bd0619995892@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in btrfs_free_fs_info
From: syzbot <syzbot+2f3cc5860d147a83eb3d@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    56fb6f92854f Merge tag 'drm-next-2024-05-25' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15874672980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b8d1faad9ceb620
dashboard link: https://syzkaller.appspot.com/bug?extid=2f3cc5860d147a83eb3d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-56fb6f92.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/65ffe3ca9bb3/vmlinux-56fb6f92.xz
kernel image: https://storage.googleapis.com/syzbot-assets/354ef77a71b6/bzImage-56fb6f92.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f3cc5860d147a83eb3d@syzkaller.appspotmail.com

assertion failed: percpu_counter_sum_positive(em_counter) == 0, in fs/btrfs/disk-io.c:1274
------------[ cut here ]------------
kernel BUG at fs/btrfs/disk-io.c:1274!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 PID: 5236 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller-12277-g56fb6f92854f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:btrfs_free_fs_info+0x3c6/0x470 fs/btrfs/disk-io.c:1274
Code: e9 df 19 42 fe e8 0a b0 03 fe b9 fa 04 00 00 48 c7 c2 80 99 76 8b 48 c7 c6 20 ab 76 8b 48 c7 c7 00 9a 76 8b e8 fb 4d e4 fd 90 <0f> 0b e8 23 e2 60 fe e9 60 fd ff ff e8 19 e2 60 fe e9 02 fd ff ff
RSP: 0018:ffffc90002bdfda8 EFLAGS: 00010286
RAX: 000000000000005a RBX: 0000000000000001 RCX: ffffffff816f3159
RDX: 0000000000000000 RSI: ffffffff816fbd56 RDI: 0000000000000005
RBP: ffff88805a888000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: ffff88805a8890f0
R13: ffff888057ba1a40 R14: ffffed1003fcaa3d R15: ffff888057ba1a80
FS:  0000000000000000(0000) GS:ffff88802c000000(0063) knlGS:0000000057e98400
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f7384414 CR3: 0000000057b96000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
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
RIP: 0023:0xf731f579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ff9328c8 EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ff932970 RCX: 0000000000000009
RDX: 00000000f7475ff4 RSI: 00000000f73c6361 RDI: 00000000ff933a14
RBP: 00000000ff932970 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_free_fs_info+0x3c6/0x470 fs/btrfs/disk-io.c:1274
Code: e9 df 19 42 fe e8 0a b0 03 fe b9 fa 04 00 00 48 c7 c2 80 99 76 8b 48 c7 c6 20 ab 76 8b 48 c7 c7 00 9a 76 8b e8 fb 4d e4 fd 90 <0f> 0b e8 23 e2 60 fe e9 60 fd ff ff e8 19 e2 60 fe e9 02 fd ff ff
RSP: 0018:ffffc90002bdfda8 EFLAGS: 00010286
RAX: 000000000000005a RBX: 0000000000000001 RCX: ffffffff816f3159
RDX: 0000000000000000 RSI: ffffffff816fbd56 RDI: 0000000000000005
RBP: ffff88805a888000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: ffff88805a8890f0
R13: ffff888057ba1a40 R14: ffffed1003fcaa3d R15: ffff888057ba1a80
FS:  0000000000000000(0000) GS:ffff88802c100000(0063) knlGS:0000000057e98400
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000055bc24d74268 CR3: 0000000057b96000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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

